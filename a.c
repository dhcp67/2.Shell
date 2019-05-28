/*************************************************************************
	> File Name: a.c
	> Author: lichun
	> Mail: 318082789@qq.com
	> Created Time: 2019年05月26日 星期日 17时08分57秒
 ************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main () {
    pid_t pid;
    int x = 0;
    for (int i = 0; i <= 9; i++) {
        pid=fork();
        x = i;
    printf(" %d\n", x);
        if(pid == 0) break;
    } 
    return 0;
}
