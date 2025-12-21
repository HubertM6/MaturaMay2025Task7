#include "testlib.h"
#include <iostream>

using namespace std;

int main(int argc, char* argv[])
{
    ios_base::sync_with_stdio(false);
    cin.tie(0);

    registerTestlibCmd(argc, argv);

    string userAnswer = ouf.readLine();
    ouf.readEof();

    if (userAnswer == "Mare Boreum") quitp(_pc(2), "Poprawna odpowiedź.");
    else if (userAnswer == "Sinus Sabaeus") quitp(_pc(1), "Podano nazwę obszaru, na którym znaleziono najmniej wody.");
    else if (userAnswer == "MC-01") quitp(_pc(1), "Podano kod obszaru zamiast jego nazwy.");
    else quitp(_pc(0), "Odpowiedź " + userAnswer + " nie jest poprawna");
}