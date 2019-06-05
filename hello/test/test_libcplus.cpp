#include <iostream>
#include <cstring>
#include <vector>

#include "curl/curl.h"
#include "add.h"
#include "get.h"
#include "crfpp.h"

void test_cstring()
{
    char str1[11] = "Hello";
    char str2[11] = "World";
    char str3[11];
    int len;

    // 复制 str1 到 str3
    strcpy(str3, str1);
    std::cout << "strcpy( str3, str1) : " << str3 << std::endl;

    // 连接 str1 和 str2
    strcat(str1, str2);
    std::cout << "strcat( str1, str2): " << str1 << std::endl;

    // 连接后，str1 的总长度
    len = strlen(str1);
    std::cout << "strlen(str1) : " << len << std::endl;
}

void test_vector()
{
    // vector
    std::vector<int> g1;
    for (int i = 0; i <= 5; i++)
    {
        g1.push_back(i);
    }

    std::cout << "Output of begin and end: ";
    for (auto i = g1.begin(); i != g1.end(); ++i)
    {
        std::cout << *i << " ";
    }
    std::cout << std::endl;
}

void *thread2(void *junk)
{
    int status = 23333;
    std::cout << "status addr is " << std::endl;
    pthread_exit((void *)&status);
}

void test_pthread()
{
    void *status_m;
    std::cout << "status_m addr is " << std::endl;
    pthread_t t_a;
    // 创建进程 t_a
    pthread_create(&t_a, NULL, thread2, NULL);
    // 等待进程结束
    pthread_join(t_a, &status_m);
    std::cout << "status_m value is " << status_m << std::endl;
    int *re = (int *)status_m;
    std::cout << "the value is " << *re << std::endl;
}

void test_crfpp(int argc, char **argv)
{
    // crfpp
    int ret = crfpp_learn(argc, argv);
    std::cout << "crfpp ret: " << ret << std::endl;
}

int main(int argc, char **argv)
{

    test_cstring();
    test_vector();
    test_pthread(); // 测试 libpthread.so 动态链接库
    test_crfpp(argc, argv);

    std::cout << "before invoking curl..." << std::endl;
    curl_easy_init();
    std::cout << "after curl..." << std::endl;

    int ret = add(3, 4);
    std::cout << "3 + 4 =" << ret << std::endl;

    int a = 100;
    int b = get();
    int c = set(a);
    int d = get();

    std::cout << "a = " << a << std::endl;
    std::cout << "b = " << b << std::endl;
    std::cout << "c = " << c << std::endl;
    std::cout << "d = " << d << std::endl;

    return 0;
}