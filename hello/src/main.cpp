#include <iostream>


int main()
{
    std::string str = "abcd";
    std::string str2 = "bc";


    std::cout <<str.compare(str2) << std::endl;
    std::cout << (str <= str2) << std::endl;
    return 0;
}