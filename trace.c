#include "types.h"
#include "stat.h"
#include "user.h"
#include "trace.h"
#include "syscall.h"


#define MAX_EVENTS 16
#define COLOR_NORMAL 0x07
#define COLOR_TITLE 0x0f
#define COLOR_GREEN 0x0a
#define COLOR_CYAN 0x0b
#define COLOR_YELLOW 0x0e
#define COLOR_RED 0x0c

#define GRAPH_WIDTH 50

int sys_count, proc_count, mem_count, trap_count = 0;
int t_sys_count, t_proc_count, t_mem_count, t_trap_count = 0;

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
            return "all";
    }
}

static int
type_color(int type){
    switch(type){
        case TRACE_TYPE_SYSCALL:
            return COLOR_CYAN;
        case TRACE_TYPE_PROC:
            return COLOR_GREEN;
        case TRACE_TYPE_MEM:
            return COLOR_YELLOW;
        case TRACE_TYPE_TRAP:
            return COLOR_RED;
        default:
            return COLOR_NORMAL;
    }
}

static int
detail_color(struct trace_event *event){
    if(event->type == TRACE_TYPE_TRAP)
        return COLOR_RED;
    if(event->type == TRACE_TYPE_MEM)
        return COLOR_YELLOW;
    if(event->type == TRACE_TYPE_PROC)
        return COLOR_GREEN;
    if(event->type == TRACE_TYPE_SYSCALL)
        if(event->arg1 < 0)
            return COLOR_RED;
        return COLOR_CYAN;
    return COLOR_NORMAL;
}

static int
latency_color(int latency){
    if(latency >= 5)
        return COLOR_RED;
    if(latency >= 2)
        return COLOR_YELLOW;
    return COLOR_GREEN;
}

static int
want_event(struct trace_event *event, int type_filter, int pid_filter){
    if(type_filter != 0 && event->type != type_filter)
        return 0;
    if(pid_filter != -1 && event->pid != pid_filter)
        return 0;
    return 1;
}

static void
update_window_counts(struct trace_event *event){
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
update_total_counts(struct trace_event *event){
    if(event->type == TRACE_TYPE_SYSCALL)
        t_sys_count++;
    else if(event->type == TRACE_TYPE_PROC)
        t_proc_count++;
    else if(event->type == TRACE_TYPE_MEM)
        t_mem_count++;
    else if(event->type == TRACE_TYPE_TRAP)
        t_trap_count++;
}


static void
itoa( int val, char *buf){
    char temp[16];
    int i = 0, j = 0, neg = 0;

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
    }

    if(neg && i < sizeof(temp)-1){
        temp[i++] = '-';
    }
    
    while(i > 0){
        buf[j++] = temp[--i];
    }
    buf[j] = 0;
}

static void
itox(uint val, char *buf){
    char *hex = "0123456789abcdef";
    int i = 0, j = 0;
    char temp[16];

    if(val == 0){
        buf[0] = '0';
        buf[1] = 0;
        return;
    }

    while(val > 0 && i < sizeof(temp)-1){
        temp[i++] = hex[val % 16];
        val = val / 16;
    }

    while(i > 0){
        buf[j++] = temp[--i];
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
drawhex(int row, int col, uint val, int color){
    char buf[16];
    itox(val, buf);
    vidputs(row, col, "0x", color);
    vidputs(row, col+2, buf, color);
}

static void
draweventrow(int row, struct trace_event *event){
    vidputs(row, 0, "                                                                                ", COLOR_NORMAL);
    drawnum(row, 0, event->seq, COLOR_NORMAL);
    drawnum(row, 6, event->ticks, COLOR_NORMAL);
    drawnum(row, 14, event->pid, type_color(event->type));
    vidputs(row, 20, event->comm, type_color(event->type));
    vidputs(row, 29, typename(event->type), type_color(event->type));
    vidputs(row, 39, event->event, type_color(event->type));
    

    if(event->type == TRACE_TYPE_SYSCALL){
        vidputs(row, 49, "num=", COLOR_NORMAL);
        drawnum(row, 53, event->arg0, COLOR_CYAN);
        vidputs(row, 57, " ret=", COLOR_NORMAL);
        drawnum(row, 62, event->arg1, detail_color(event));
        vidputs(row, 68, " lat=", COLOR_NORMAL);
        drawnum(row, 73, event->arg2, latency_color(event->arg2));
    } else if(event->type == TRACE_TYPE_PROC){
        vidputs(row, 49, "parent=", COLOR_NORMAL);
        drawnum(row, 56, event->arg0, COLOR_GREEN);
    } else if(event->type == TRACE_TYPE_MEM){
        vidputs(row, 49, "page=", COLOR_NORMAL);
        drawhex(row, 54, event->arg0, COLOR_YELLOW);
    } else if(event->type == TRACE_TYPE_TRAP){
        vidputs(row, 49, "cause=", COLOR_RED);
        drawnum(row, 55, event->arg0, COLOR_RED);
        vidputs(row, 60, " err=", COLOR_RED);
        drawnum(row, 65, event->arg1, COLOR_RED);
    }
}

static void
draw_graph(int row, int col, int *activity, int activity_pos){
    int i, index, count, color;
    char bar[2];

    bar[1] = 0;
    vidputs(row, col, "event rate last 50 ticks: . none | - low | = medium | # high", COLOR_TITLE);

    for(i = 0; i < GRAPH_WIDTH; i++){
        index = (activity_pos + 1 + i) % GRAPH_WIDTH;
        count = activity[index];

        if(count == 0){
            bar[0] = '.';
            color = COLOR_NORMAL;
        } else if (count < 3){
            bar[0] = '-';
            color = COLOR_GREEN;
        } else if(count < 7){
            bar[0] = '=';
            color = COLOR_YELLOW;
        } else {
            bar[0] = '#';
            color = COLOR_RED;
        }

        vidputs(row + 1, col + i, bar, color);
    }
}

static void
drawBoard(struct trace_event *recent, int recent_count, int recent_start,
          int filter_type, int filter_pid, int overwritten)
{
    int i, index;

    vidclear();

    vidputs(0, 0, "xv6 live kernel trace dashboard", COLOR_TITLE);
    
    vidputs(1, 0, "filter: type=", COLOR_NORMAL);
    vidputs(1, 13, typename(filter_type), type_color(filter_type));
    vidputs(1, 21, " pid=", COLOR_NORMAL);
    if(filter_pid == -1)
        vidputs(1, 26, "all", COLOR_NORMAL);
    else
        drawnum(1, 26, filter_pid, COLOR_NORMAL);

    vidputs(1, 32, "| window: syscall=", COLOR_NORMAL);
    drawnum(1, 50, sys_count, COLOR_CYAN);
    vidputs(1, 54, " proc=", COLOR_NORMAL);
    drawnum(1, 60, proc_count, COLOR_GREEN);
    vidputs(1, 64, " mem=", COLOR_NORMAL);
    drawnum(1, 69, mem_count, COLOR_YELLOW);
    vidputs(1, 73, " trap=", COLOR_NORMAL);
    drawnum(1, 79, trap_count, COLOR_RED);

    vidputs(2, 0, "total: syscall=", COLOR_NORMAL);
    drawnum(2, 15, t_sys_count, COLOR_CYAN);
    vidputs(2, 20, " proc=", COLOR_NORMAL);
    drawnum(2, 26, t_proc_count, COLOR_GREEN);
    vidputs(2, 30, " mem=", COLOR_NORMAL);
    drawnum(2, 35, t_mem_count, COLOR_YELLOW);
    vidputs(2, 40, " trap=", COLOR_NORMAL);
    drawnum(2, 46, t_trap_count, COLOR_RED);
    vidputs(2, 52, "| overwritten=", COLOR_NORMAL);
    drawnum(2, 66, overwritten, overwritten > 0 ? COLOR_RED : COLOR_NORMAL);

    // draw_graph(4, 0, activity, activity_pos); // activity graph needs activity array

    vidputs(6, 0, "SEQ   TICKS   PID   PROC     SUBSYS    EVENT     DETAILS", COLOR_TITLE);
    vidputs(7, 0, "---------------------------------------------------------------------------", COLOR_NORMAL);
   
    for(i = 0; i < recent_count && i < MAX_EVENTS; i++){
        index = (recent_start + i) % MAX_EVENTS;
        draweventrow(8 + i, &recent[index]);
    }

}



int
main(int argc, char **argv){
    struct trace_event event;
    struct trace_event recent[MAX_EVENTS];
    int recent_count = 0;
    int recent_start = 0;
    int limit = 1000;
    int seen = 0;
    int activity[GRAPH_WIDTH];
    int activity_pos = 0;
    int last_tick = -1;
    int i;
    int filter_type = 0;
    int filter_pid = -1;
    int overwritten = 0;

    vidclear();
    
    sleep(10);

    if(argc > 1)
        limit = atoi(argv[1]);
    if(argc > 2){
        if(strcmp(argv[2], "syscall") == 0)
            filter_type = TRACE_TYPE_SYSCALL;
        else if(strcmp(argv[2], "proc") == 0)
            filter_type = TRACE_TYPE_PROC;
        else if(strcmp(argv[2], "mem") == 0)
            filter_type = TRACE_TYPE_MEM;
        else if(strcmp(argv[2], "trap") == 0)
            filter_type = TRACE_TYPE_TRAP;
        else if(atoi(argv[2]) > 0 || strcmp(argv[2], "0") == 0)
            filter_pid = atoi(argv[2]);
    }
    if(argc > 3){
        filter_pid = atoi(argv[3]);
    }

    // initialize activity graph
    for(i = 0; i < GRAPH_WIDTH; i++){
        activity[i] = 0;
    }

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

        update_total_counts(&event);
        overwritten = event.overwritten;

        if(!want_event(&event, filter_type, filter_pid))
            continue;
        
        update_window_counts(&event);

        // Update the activity graph
        if(last_tick == -1)
            last_tick = event.ticks;

        if(event.ticks != last_tick){
            int diff = event.ticks - last_tick;
            if(diff > 50) diff = 50; // Cap it
            for(i = 0; i < diff; i++) {
                activity_pos = (activity_pos + 1) % GRAPH_WIDTH;
                activity[activity_pos] = 0;
            }
            last_tick = event.ticks;
        }
        activity[activity_pos]++;


        if(recent_count < MAX_EVENTS){
            recent[recent_count] = event;
            recent_count++;
        } else {
            recent[recent_start] = event;
            recent_start = (recent_start + 1) % MAX_EVENTS;
        }
        
        drawBoard(recent, recent_count, recent_start, filter_type, filter_pid, overwritten);
        draw_graph(4, 0, activity, activity_pos);

        seen++;
    }
    exit();
}
