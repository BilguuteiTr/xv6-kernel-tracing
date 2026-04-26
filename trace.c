#include "types.h"
#include "stat.h"
#include "user.h"
#include "trace.h"

static char*
typename(int type){
    switch(type){
        case TRACE_TYPE_SYSCALL:
            return "syscall";
        case TRACE_TYPE_PROC:
            return "proc";
        case TRACE_TYPE_TRAP:
            return "trap";
        case TRACE_TYPE_MEM:
            return "mem";
        default:
            return "unknown";
    }
}

int
main(int argc, char **argv){
    // Create space for one event
    struct trace_event event;


    int limit = 20;
    int seen = 0;


    if(argc > 1)
        limit = atoi(argv[1]);

    printf(1, "SEQ TICKS TYPE PID ARG0 ARG1 NAME\n");

    while(seen < limit){
        int n = traceread(&event);

        if(n < 0){
            printf(1, "traceread failed\n");
            exit();
        }

        if(n == 0){
            sleep(10);
            continue;
        }
        printf(1, "%d %d %s %d %d %d %s\n",
            event.seq, event.ticks, typename(event.type),
            event.pid, event.arg0, event.arg1, event.name
        );
        seen++;
    }
    exit();
}