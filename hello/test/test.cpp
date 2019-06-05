#include <iostream>
#include "curl/curl.h"

using namespace std;

int main()
{
    cout << "before invoking curl.." << endl;
    curl_easy_init();
    cout << "after curl..." << endl;
    return 0;
}