#include "types.h"
#include "stat.h"
#include "user.h"
#include "trace.h"
#include "syscall.h"


#define MAX_EVENTS 8
#define COLOR_NORMAL 0x07
#define COLOR_TITLE 0x0f
#define COLOR_GREEN 0x0a
#define COLOR_CYAN 0x0b
#define COLOR_YELLOW 0x0e
#define COLOR_RED 0x0c

int sys_count, proc_count, mem_count, trap_count = 0;

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

static void
updatecounter(struct trace_event *event){
    if(event->type == TRACE_TYPE_SYSCALL)
        sys_count++;
    else if(event->type == TRACE_TYPE_PROC)
        proc_count++;
    else if(event->type == TRACE_TYPE_MEM)
        mem_count++;
    else if(event->type == TRACE_TYPE_TRAP)
        trap_count++;
}

static void
printevent(struct trace_event *event)
{
  if(event->type == TRACE_TYPE_SYSCALL){
    printf(1, "%d %d %s pid %d name %s num %d ret %d\n",
           event->seq,
           event->ticks,
           typename(event->type),
           event->pid,
           event->name,
           event->arg0,
           event->arg1);
  } else if(event->type == TRACE_TYPE_PROC){
    printf(1, "%d %d %s pid %d name %s parent %d\n",
           event->seq,
           event->ticks,
           typename(event->type),
           event->pid,
           event->name,
           event->arg0);
  } else if(event->type == TRACE_TYPE_MEM){
    printf(1, "%d %d %s pid %d name %s page %d\n",
           event->seq,
           event->ticks,
           typename(event->type),
           event->pid,
           event->name,
           event->arg0);
  } else if(event->type == TRACE_TYPE_TRAP){
    printf(1, "%d %d %s pid %d name %s trap %d err %d\n",
           event->seq,
           event->ticks,
           typename(event->type),
           event->pid,
           event->name,
           event->arg0,
           event->arg1);
  } else {
    printf(1, "%d %d %s pid %d name %s arg0 %d arg1 %d\n",
           event->seq,
           event->ticks,
           typename(event->type),
           event->pid,
           event->name,
           event->arg0,
           event->arg1);
  }
}


static void
itoa( int val, char *buf){
    char temp[16];
    int i,j,neg = 0;

    if(val < 0){
        neg = 1;
        val = -val;
    }
    if(val == 0){
        buf[0] = '0';
        buf[1] = 0;
        return;
    }

    while(val > 0 && i < sizeof(temp)-1){
        temp[i++] = '0' + val % 10;
        val = val / 10;
        i++;
    }

    if(neg && sizeof(temp)-1){
        temp[i++] = '-';
        i++;
    }
    
    while(i > 0){
        i--;
        buf[j++] = temp[--i];
        j++;
    }
    buf[j] = 0;
}

static void
drawnum(int row, int col, int val, int color){
    char buf[16];
    itoa(val, buf);
    vidputs(row, col, buf, color);
}

static void
draweventrow(int row, struct trace_event *event){
    vidputs(row, 0, "                                                                            ", COLOR_NORMAL);
    drawnum(row, 0, event->seq, COLOR_NORMAL);
    drawnum(row, 6, event->ticks, COLOR_NORMAL);
    vidputs(row, 13, typename(event->type), COLOR_CYAN);
    drawnum(row, 23, event->pid, COLOR_NORMAL);
    vidputs(row, 29, event->name, COLOR_YELLOW);

    if(event->type == TRACE_TYPE_SYSCALL){
        vidputs(row, 42, "num", COLOR_NORMAL);
        drawnum(row, 46, event->arg0, COLOR_NORMAL);
        vidputs(row, 52, "ret", COLOR_NORMAL);
        drawnum(row, 56, event->arg1, COLOR_NORMAL);
    } else if(event->type == TRACE_TYPE_PROC){
        vidputs(row, 42, "parent", COLOR_NORMAL);
        drawnum(row, 49, event->arg0, COLOR_NORMAL);
    } else if(event->type == TRACE_TYPE_MEM){
        vidputs(row, 42, "page", COLOR_NORMAL);
        drawnum(row, 47, event->arg0, COLOR_NORMAL);
    } else if(event->type == TRACE_TYPE_TRAP){
        vidputs(row, 42, "trap", COLOR_RED);
        drawnum(row, 47, event->arg0, COLOR_RED);
        vidputs(row, 53, "err", COLOR_RED);
        drawnum(row, 57, event->arg1, COLOR_RED);
    }
}


static void
drawBoard(struct trace_event *recent, int recent_count, int recent_start,
          int sys_count, int proc_count, int mem_count, int trap_count)
{
    int i, index;

    vidclear();

    vidputs(0, 0, "XV6 LIVE KERNEL TRACE DASHBOARD\n", COLOR_TITLE);
    vidputs(1, 0, "------------------------------------------------------------", COLOR_NORMAL);
    
    vidputs(3, 0, "SYSCALLS", COLOR_CYAN);
    drawnum(3, 10, sys_count, COLOR_CYAN);

    vidputs(3, 22, "PROC", COLOR_GREEN);
    drawnum(3, 28, proc_count, COLOR_GREEN);

    vidputs(3, 40, "MEM", COLOR_YELLOW);
    drawnum(3, 45, mem_count, COLOR_YELLOW);

    vidputs(3, 56, "TRAP", COLOR_RED);
    drawnum(3, 62, trap_count, COLOR_RED);

    vidputs(5, 0, "SEQ   TICKS  TYPE      PID   EVENT        DETAILS", COLOR_TITLE);
    vidputs(6, 0, "------------------------------------------------------------", COLOR_NORMAL);
   
    for(i = 0; i < recent_count && i < 8; i++){
        index = (recent_start + i) % MAX_EVENTS;
        draweventrow(7 + i, &recent[index]);
    }

    printf(1, "--------------------------------\n");
}

int
main(int argc, char **argv){
    // Create space for one event
    struct trace_event event;
    struct trace_event recent[MAX_EVENTS];
    int recent_count = 0;
    int recent_start = 0;
    int limit = 20;
    int seen = 0;

    vidclear();
    
    sleep(100);

    if(argc > 1)
        limit = atoi(argv[1]);

    //printf(1, "SEQ TICKS TYPE DETAILS\n");

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
        
        if(event.type == TRACE_TYPE_SYSCALL && (event.arg0 == SYS_write || event.arg0 == SYS_sleep))
            continue;

        updatecounter(&event);

        if(recent_count < MAX_EVENTS){
            recent[recent_count] = event;
            recent_count++;
        } else {
            recent[recent_start] = event;
            recent_start = (recent_start + 1) % MAX_EVENTS;
        }

        drawBoard(recent, recent_count, recent_start, sys_count, 
                  proc_count, mem_count, trap_count);

        seen++;
    }
    exit();
}