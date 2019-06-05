//
//  CRF++ -- Yet Another CRF toolkit
//
//  $Id: crf_learn.cpp 1587 2007-02-12 09:00:36Z taku $;
//
//  Copyright(C) 2005-2007 Taku Kudo <taku@chasen.org>
//
#include <iostream>
#include <cstring>
#include "crfpp.h"
#include "winmain.h"

using namespace std;

int main(int argc, char **argv)
{
  cout << "Hello!!" << endl;
  int hello_len = strlen("Hello");
  cout << "Hello length:" << hello_len << endl;
  return crfpp_learn(argc, argv);
}
