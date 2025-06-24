#!/bin/bash
set -e

echo "Initializing database..."

psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /data/schema/schema.sql

for file in /data/tables/*; do
  table=$(basename "$file" | sed 's/\.[^.]*$//')
  if [[ "$file" == *.tsv ]]; then
    delimiter=$'\t'
  else
    delimiter=","
  fi
  echo "Importing data into $table from $file with delimiter '$delimiter'..."
  psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "\COPY $table FROM '$file' WITH (FORMAT csv, DELIMITER '$delimiter', HEADER)"
done

echo "Running user query..."
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /data/src/query.sql --csv > /data/output/result.csv
echo "Done."

# 🛑 Stop PostgreSQL server (and thus the container)
pg_ctl -D "$PGDATA" -m fast stop

exit 0
