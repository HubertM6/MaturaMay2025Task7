#!/bin/bash
set -e

echo "Waiting for MySQL to be ready..."
until mysqladmin ping -h "localhost" --silent; do
  sleep 1
done

echo "Initializing database schema..."
mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" < /data/schema/schema.sql

# Load tables
for file in /data/tables/*; do
  table=$(basename "$file" | sed 's/\.[^.]*$//')
  if [[ "$file" == *.tsv ]]; then
    delimiter=$'\t'
  else
    delimiter=","
  fi

  echo "Importing data into $table from $file with delimiter '$delimiter'..."

  mysql --local-infile=1 -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" -e "
    LOAD DATA LOCAL INFILE '$file'
    INTO TABLE $table
    FIELDS TERMINATED BY '$delimiter'
    IGNORE 1 ROWS;
  "
done

echo "Running user query..."
if ! mysql --local-infile=1 -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" --batch --raw --skip-column-names < /data/src/query.sql > /data/src/result.csv 2> /data/output/query_error.log; then
  echo "User query failed. See query_error.log for details."
  exit 100
fi
echo "Done."

# echo "Shutting down..."
# mysqladmin -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" shutdown

exit 0

