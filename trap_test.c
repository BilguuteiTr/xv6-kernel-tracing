#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv){
    int *p;

    p = (int*) 0xffffffffffffffff;
    *p = 123;

    exit();
}