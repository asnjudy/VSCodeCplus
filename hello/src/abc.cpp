#include <iostream>

class User
{
private:
    int x, y;
};

int main()
{
    const std::string str2 = "hello";
    std::cout << "xx:" << str2[5] << "xx"<< std::endl;
    

    return 0;
}