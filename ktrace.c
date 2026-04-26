#include "types.h"
#include "defs.h"
#include "param.h"
#include "spinlock.h"
#include "trace.h"
#include "proc.h"

#define TRACE_BUF_SIZE 128      // Remember the most recent 128

struct {
    struct spinlock lock;  // Lock for syncronization
    int enabled;           // turn on or off 
    uint seq;              // where the event is written
    uint readseq;          // the next event the user program should read
    struct trace_event events[TRACE_BUF_SIZE];  // Ring buffer
} traceBuffer;

// Initalize the tracing event
void 
traceinit(void){
    initlock(&traceBuffer.lock, "trace");
    traceBuffer.enabled = 1;
    traceBuffer.seq = 0;
    traceBuffer.readseq = 0;
}

// trace the current event
void 
traceevent(int type, int pid, int arg0, int arg1, char *name){
    struct trace_event *event;

    // if the trace buffer is not enabled, then return nothing
    if(!traceBuffer.enabled)
        return;

    //aquire the lock
    acquire(&traceBuffer.lock);

    event = &traceBuffer.events[traceBuffer.seq % TRACE_BUF_SIZE]; // Allows ring to wrap

    // Set the event metadata
    event->seq = traceBuffer.seq;
    event->ticks = ticks;
    event->type = type;
    event->pid = pid;
    event->arg0 = arg0;
    event->arg1 = arg1;

    memset(event->name, 0, sizeof(event->name));

    if(name)
        safestrcpy(event->name, name, sizeof(event->name));

    traceBuffer.seq++; // Update sequence number

    // If the writer gets more than 128 events ahead, old events are gone, move readseq  foreward to the oldest event still available
    if(traceBuffer.seq - traceBuffer.readseq > TRACE_BUF_SIZE)
        traceBuffer.readseq = traceBuffer.seq - TRACE_BUF_SIZE;

    // Release the lock
    release(&traceBuffer.lock);
}

int
traceread(struct trace_event *dst){
    struct trace_event event;

    // No unread events available, return 0
    if(traceBuffer.readseq == traceBuffer.seq){
        release(&traceBuffer.lock); // Release the lock
        return 0;
    }

    event = traceBuffer.events[traceBuffer.readseq % TRACE_BUF_SIZE];
    traceBuffer.readseq++; // Increment

    if(copyout(proc->pgdir, (addr_t)dst, &event, sizeof(event)) < 0)
        return -1;

    return 1;
}