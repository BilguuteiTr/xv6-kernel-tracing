#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char **argv)
{
  int fd;
  int i;
  int pid;
  char buf[64];
  char *mem;

  printf(1, "trace_demo: generating file, memory, and process events\n");

  fd = open("trace_demo.txt", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "trace_demo: open failed\n");
    exit();
  }

  for(i = 0; i < 12; i++)
    write(fd, "trace event sample\n", 19);

  close(fd);

  fd = open("trace_demo.txt", O_RDONLY);
  if(fd >= 0){
    for(i = 0; i < 6; i++)
      read(fd, buf, sizeof(buf));
    close(fd);
  }

  for(i = 0; i < 8; i++){
    mem = sbrk(4096);
    if(mem != (char*)-1)
      mem[0] = i;
  }

  pid = fork();
  if(pid == 0){
    printf(1, "trace_demo child: pid %d uptime %d\n", getpid(), uptime());
    exit();
  }

  wait();
  unlink("trace_demo.txt");

  printf(1, "trace_demo: done\n");
  exit();
}
