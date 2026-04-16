
kernel:     file format elf64-x86-64


Disassembly of section .text:

ffff800000100000 <begin>:
ffff800000100000:	02 b0 ad 1b 00 00    	add    0x1bad(%rax),%dh
ffff800000100006:	01 00                	add    %eax,(%rax)
ffff800000100008:	fe 4f 51             	decb   0x51(%rdi)
ffff80000010000b:	e4 00                	in     $0x0,%al
ffff80000010000d:	00 10                	add    %dl,(%rax)
ffff80000010000f:	00 00                	add    %al,(%rax)
ffff800000100011:	00 10                	add    %dl,(%rax)
ffff800000100013:	00 00                	add    %al,(%rax)
ffff800000100015:	e0 10                	loopne ffff800000100027 <mboot_entry+0x7>
ffff800000100017:	00 00                	add    %al,(%rax)
ffff800000100019:	10 12                	adc    %dl,(%rdx)
ffff80000010001b:	00 20                	add    %ah,(%rax)
ffff80000010001d:	00 10                	add    %dl,(%rax)
	...

ffff800000100020 <mboot_entry>:
  .long mboot_entry_addr

.code32
mboot_entry:
# zero 2 pages for our bootstrap page tables
  xor     %eax, %eax    # value=0
ffff800000100020:	31 c0                	xor    %eax,%eax
  mov     $0x1000, %edi # starting at 4096
ffff800000100022:	bf 00 10 00 00       	mov    $0x1000,%edi
  mov     $0x2000, %ecx # size=8192
ffff800000100027:	b9 00 20 00 00       	mov    $0x2000,%ecx
  rep     stosb         # memset(4096, 0, 8192)
ffff80000010002c:	f3 aa                	rep stos %al,(%rdi)

# map both virtual address 0 and KERNBASE to the same PDPT
# note: 32-bit operations manipulating 64-bit page table
# PML4T[0] -> 0x2000 (PDPT)
# PML4T[256] -> 0x2000 (PDPT)
  mov     $(0x2000 | PTE_P | PTE_W), %eax
ffff80000010002e:	b8 03 20 00 00       	mov    $0x2003,%eax
  mov     %eax, 0x1000  # PML4T[0]
ffff800000100033:	a3 00 10 00 00 a3 00 	movabs %eax,0x1800a300001000
ffff80000010003a:	18 00 
  mov     %eax, 0x1800  # PML4T[256]
ffff80000010003c:	00 b8 83 00 00 00    	add    %bh,0x83(%rax)

# PDPT[0] -> 0x0 (1 GB flat map page)
  mov     $(0x0 | PTE_P | PTE_PS | PTE_W), %eax
  mov     %eax, 0x2000  # PDPT[0]
ffff800000100042:	a3                   	.byte 0xa3
ffff800000100043:	00 20                	add    %ah,(%rax)
ffff800000100045:	00 00                	add    %al,(%rax)

# Clear ebx for initial processor boot.
# When secondary processors boot, they'll call through
# entry32mp (from entryother), but with a nonzero ebx.
# We'll reuse these bootstrap pagetables and GDT.
  xor     %ebx, %ebx
ffff800000100047:	31 db                	xor    %ebx,%ebx

ffff800000100049 <entry32mp>:

.global entry32mp
entry32mp:
# CR3 -> 0x1000 (PML4T)
  mov     $0x1000, %eax
ffff800000100049:	b8 00 10 00 00       	mov    $0x1000,%eax
  mov     %eax, %cr3
ffff80000010004e:	0f 22 d8             	mov    %rax,%cr3

  lgdt    (gdtr64 - mboot_header + mboot_load_addr)
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xdf0e8>

# PAE is required for 64-bit paging: CR4.PAE=1
  mov     %cr4, %eax
ffff800000100058:	0f 20 e0             	mov    %cr4,%rax
  bts     $5, %eax
ffff80000010005b:	0f ba e8 05          	bts    $0x5,%eax
  mov     %eax, %cr4
ffff80000010005f:	0f 22 e0             	mov    %rax,%cr4

# access EFER Model specific register
  mov     $MSR_EFER, %ecx
ffff800000100062:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
  rdmsr
ffff800000100067:	0f 32                	rdmsr
  bts     $0, %eax #enable system call extensions
ffff800000100069:	0f ba e8 00          	bts    $0x0,%eax
  bts     $8, %eax #enable long mode
ffff80000010006d:	0f ba e8 08          	bts    $0x8,%eax
  wrmsr
ffff800000100071:	0f 30                	wrmsr

# enable paging
  mov     %cr0, %eax
ffff800000100073:	0f 20 c0             	mov    %cr0,%rax
  orl     $(CR0_PG | CR0_WP | CR0_MP), %eax
ffff800000100076:	0d 02 00 01 80       	or     $0x80010002,%eax
  mov     %eax, %cr0
ffff80000010007b:	0f 22 c0             	mov    %rax,%cr0

# shift to 64bit segment
  ljmp    $8, $(entry64low - mboot_header + mboot_load_addr)
ffff80000010007e:	ea                   	(bad)
ffff80000010007f:	c0 00 10             	rolb   $0x10,(%rax)
ffff800000100082:	00 08                	add    %cl,(%rax)
ffff800000100084:	00 66 66             	add    %ah,0x66(%rsi)
ffff800000100087:	2e 0f 1f 84 00 00 00 	cs nopl 0x0(%rax,%rax,1)
ffff80000010008e:	00 00 

ffff800000100090 <gdtr64>:
ffff800000100090:	17                   	(bad)
ffff800000100091:	00 a0 00 10 00 00    	add    %ah,0x1000(%rax)
ffff800000100097:	00 00                	add    %al,(%rax)
ffff800000100099:	00 90 0f 1f 44 00    	add    %dl,0x441f0f(%rax)
	...

ffff8000001000a0 <gdt64_begin>:
	...
ffff8000001000ac:	00 98 20 00 00 00    	add    %bl,0x20(%rax)
ffff8000001000b2:	00 00                	add    %al,(%rax)
ffff8000001000b4:	00                   	.byte 0
ffff8000001000b5:	90                   	nop
	...

ffff8000001000b8 <gdt64_end>:
ffff8000001000b8:	90                   	nop
ffff8000001000b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

ffff8000001000c0 <entry64low>:
gdt64_end:

.align 16
.code64
entry64low:
  movabs  $entry64high, %rax
ffff8000001000c0:	48 b8 cc 00 10 00 00 	movabs $0xffff8000001000cc,%rax
ffff8000001000c7:	80 ff ff 
  jmp     *%rax
ffff8000001000ca:	ff e0                	jmp    *%rax

ffff8000001000cc <_start>:
.global _start
_start:
entry64high:

# ensure data segment registers are sane
  xor     %rax, %rax
ffff8000001000cc:	48 31 c0             	xor    %rax,%rax
  mov     %ax, %ss
ffff8000001000cf:	8e d0                	mov    %eax,%ss
  mov     %ax, %ds
ffff8000001000d1:	8e d8                	mov    %eax,%ds
  mov     %ax, %es
ffff8000001000d3:	8e c0                	mov    %eax,%es
  mov     %ax, %fs
ffff8000001000d5:	8e e0                	mov    %eax,%fs
  mov     %ax, %gs
ffff8000001000d7:	8e e8                	mov    %eax,%gs
  # mov     %cr4, %rax
  # or      $(CR4_PAE | CR4_OSXFSR | CR4_OSXMMEXCPT) , %rax
  # mov     %rax, %cr4

# check to see if we're booting a secondary core
  test    %ebx, %ebx
ffff8000001000d9:	85 db                	test   %ebx,%ebx
  jnz     entry64mp  # jump if booting a secondary code
ffff8000001000db:	75 14                	jne    ffff8000001000f1 <entry64mp>
# setup initial stack
  movabs  $0xFFFF800000010000, %rax
ffff8000001000dd:	48 b8 00 00 01 00 00 	movabs $0xffff800000010000,%rax
ffff8000001000e4:	80 ff ff 
  mov     %rax, %rsp
ffff8000001000e7:	48 89 c4             	mov    %rax,%rsp

# enter main()
  jmp     main  # end of initial (the first) core ASM
ffff8000001000ea:	e9 3e 53 00 00       	jmp    ffff80000010542d <main>

ffff8000001000ef <__deadloop>:

.global __deadloop
__deadloop:
# we should never return here...
  jmp     .
ffff8000001000ef:	eb fe                	jmp    ffff8000001000ef <__deadloop>

ffff8000001000f1 <entry64mp>:

entry64mp:
# obtain kstack from data block before entryother
  mov     $0x7000, %rax
ffff8000001000f1:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
  mov     -16(%rax), %rsp
ffff8000001000f8:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
  jmp     mpenter  # end of secondary code ASM
ffff8000001000fc:	e9 50 54 00 00       	jmp    ffff800000105551 <mpenter>

ffff800000100101 <wrmsr>:

.global wrmsr
wrmsr:
  mov     %rdi, %rcx     # arg0 -> msrnum
ffff800000100101:	48 89 f9             	mov    %rdi,%rcx
  mov     %rsi, %rax     # val.low -> eax
ffff800000100104:	48 89 f0             	mov    %rsi,%rax
  shr     $32, %rsi
ffff800000100107:	48 c1 ee 20          	shr    $0x20,%rsi
  mov     %rsi, %rdx     # val.high -> edx
ffff80000010010b:	48 89 f2             	mov    %rsi,%rdx
  wrmsr
ffff80000010010e:	0f 30                	wrmsr
  retq
ffff800000100110:	c3                   	ret

ffff800000100111 <ignore_sysret>:

.global ignore_sysret
ignore_sysret: #return error code 38, meaning function unimplemented
  mov     $-38, %rax
ffff800000100111:	48 c7 c0 da ff ff ff 	mov    $0xffffffffffffffda,%rax
  sysretq
ffff800000100118:	48 0f 07             	sysretq

ffff80000010011b <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
ffff80000010011b:	55                   	push   %rbp
ffff80000010011c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010011f:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
ffff800000100123:	48 ba d0 c7 10 00 00 	movabs $0xffff80000010c7d0,%rdx
ffff80000010012a:	80 ff ff 
ffff80000010012d:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100134:	80 ff ff 
ffff800000100137:	48 89 d6             	mov    %rdx,%rsi
ffff80000010013a:	48 89 c7             	mov    %rax,%rdi
ffff80000010013d:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000100144:	80 ff ff 
ffff800000100147:	ff d0                	call   *%rax
//PAGEBREAK!

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffff800000100149:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100150:	80 ff ff 
ffff800000100153:	48 b9 08 31 11 00 00 	movabs $0xffff800000113108,%rcx
ffff80000010015a:	80 ff ff 
ffff80000010015d:	48 89 88 a0 51 00 00 	mov    %rcx,0x51a0(%rax)
  bcache.head.next = &bcache.head;
ffff800000100164:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010016b:	80 ff ff 
ffff80000010016e:	48 89 88 a8 51 00 00 	mov    %rcx,0x51a8(%rax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100175:	48 b8 68 e0 10 00 00 	movabs $0xffff80000010e068,%rax
ffff80000010017c:	80 ff ff 
ffff80000010017f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100183:	e9 8e 00 00 00       	jmp    ffff800000100216 <binit+0xfb>
    b->next = bcache.head.next;
ffff800000100188:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010018f:	80 ff ff 
ffff800000100192:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010019d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff8000001001a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001a8:	48 be 08 31 11 00 00 	movabs $0xffff800000113108,%rsi
ffff8000001001af:	80 ff ff 
ffff8000001001b2:	48 89 b0 98 00 00 00 	mov    %rsi,0x98(%rax)
    initsleeplock(&b->lock, "buffer");
ffff8000001001b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001bd:	48 83 c0 10          	add    $0x10,%rax
ffff8000001001c1:	48 ba d7 c7 10 00 00 	movabs $0xffff80000010c7d7,%rdx
ffff8000001001c8:	80 ff ff 
ffff8000001001cb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d1:	48 b8 da 74 10 00 00 	movabs $0xffff8000001074da,%rax
ffff8000001001d8:	80 ff ff 
ffff8000001001db:	ff d0                	call   *%rax
    bcache.head.next->prev = b;
ffff8000001001dd:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001001e4:	80 ff ff 
ffff8000001001e7:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001001ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001001f2:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001001f9:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff800000100200:	80 ff ff 
ffff800000100203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100207:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff80000010020e:	48 81 45 f8 b0 02 00 	addq   $0x2b0,-0x8(%rbp)
ffff800000100215:	00 
ffff800000100216:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff80000010021d:	80 ff ff 
ffff800000100220:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000100224:	0f 82 5e ff ff ff    	jb     ffff800000100188 <binit+0x6d>
  }
}
ffff80000010022a:	90                   	nop
ffff80000010022b:	90                   	nop
ffff80000010022c:	c9                   	leave
ffff80000010022d:	c3                   	ret

ffff80000010022e <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
ffff80000010022e:	55                   	push   %rbp
ffff80000010022f:	48 89 e5             	mov    %rsp,%rbp
ffff800000100232:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100236:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100239:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  acquire(&bcache.lock);
ffff80000010023c:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100243:	80 ff ff 
ffff800000100246:	48 89 c7             	mov    %rax,%rdi
ffff800000100249:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000100250:	80 ff ff 
ffff800000100253:	ff d0                	call   *%rax

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff800000100255:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010025c:	80 ff ff 
ffff80000010025f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100266:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010026a:	eb 77                	jmp    ffff8000001002e3 <bget+0xb5>
    if(b->dev == dev && b->blockno == blockno){
ffff80000010026c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100270:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000100273:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000100276:	75 5c                	jne    ffff8000001002d4 <bget+0xa6>
ffff800000100278:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010027c:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010027f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff800000100282:	75 50                	jne    ffff8000001002d4 <bget+0xa6>
      b->refcnt++;
ffff800000100284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100288:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010028e:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100295:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
      release(&bcache.lock);
ffff80000010029b:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001002a2:	80 ff ff 
ffff8000001002a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001002a8:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001002af:	80 ff ff 
ffff8000001002b2:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff8000001002b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002b8:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001002bf:	48 b8 32 75 10 00 00 	movabs $0xffff800000107532,%rax
ffff8000001002c6:	80 ff ff 
ffff8000001002c9:	ff d0                	call   *%rax
      return b;
ffff8000001002cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002cf:	e9 f6 00 00 00       	jmp    ffff8000001003ca <bget+0x19c>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff8000001002d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002d8:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff8000001002df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001002e3:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff8000001002ea:	80 ff ff 
ffff8000001002ed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001002f1:	0f 85 75 ff ff ff    	jne    ffff80000010026c <bget+0x3e>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff8000001002f7:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001002fe:	80 ff ff 
ffff800000100301:	48 8b 80 a0 51 00 00 	mov    0x51a0(%rax),%rax
ffff800000100308:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010030c:	e9 8c 00 00 00       	jmp    ffff80000010039d <bget+0x16f>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
ffff800000100311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100315:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010031b:	85 c0                	test   %eax,%eax
ffff80000010031d:	75 6f                	jne    ffff80000010038e <bget+0x160>
ffff80000010031f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100323:	8b 00                	mov    (%rax),%eax
ffff800000100325:	83 e0 04             	and    $0x4,%eax
ffff800000100328:	85 c0                	test   %eax,%eax
ffff80000010032a:	75 62                	jne    ffff80000010038e <bget+0x160>
      b->dev = dev;
ffff80000010032c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100330:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000100333:	89 50 04             	mov    %edx,0x4(%rax)
      b->blockno = blockno;
ffff800000100336:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010033a:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010033d:	89 50 08             	mov    %edx,0x8(%rax)
      b->flags = 0;
ffff800000100340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100344:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
      b->refcnt = 1;
ffff80000010034a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010034e:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%rax)
ffff800000100355:	00 00 00 
      release(&bcache.lock);
ffff800000100358:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010035f:	80 ff ff 
ffff800000100362:	48 89 c7             	mov    %rax,%rdi
ffff800000100365:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010036c:	80 ff ff 
ffff80000010036f:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff800000100371:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100375:	48 83 c0 10          	add    $0x10,%rax
ffff800000100379:	48 89 c7             	mov    %rax,%rdi
ffff80000010037c:	48 b8 32 75 10 00 00 	movabs $0xffff800000107532,%rax
ffff800000100383:	80 ff ff 
ffff800000100386:	ff d0                	call   *%rax
      return b;
ffff800000100388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010038c:	eb 3c                	jmp    ffff8000001003ca <bget+0x19c>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff80000010038e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100392:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100399:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010039d:	48 b8 08 31 11 00 00 	movabs $0xffff800000113108,%rax
ffff8000001003a4:	80 ff ff 
ffff8000001003a7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001003ab:	0f 85 60 ff ff ff    	jne    ffff800000100311 <bget+0xe3>
    }
  }
  panic("bget: no buffers");
ffff8000001003b1:	48 b8 de c7 10 00 00 	movabs $0xffff80000010c7de,%rax
ffff8000001003b8:	80 ff ff 
ffff8000001003bb:	48 89 c7             	mov    %rax,%rdi
ffff8000001003be:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001003c5:	80 ff ff 
ffff8000001003c8:	ff d0                	call   *%rax
}
ffff8000001003ca:	c9                   	leave
ffff8000001003cb:	c3                   	ret

ffff8000001003cc <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
ffff8000001003cc:	55                   	push   %rbp
ffff8000001003cd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001003d0:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001003d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001003d7:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *b;

  b = bget(dev, blockno);
ffff8000001003da:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001003dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001003e0:	89 d6                	mov    %edx,%esi
ffff8000001003e2:	89 c7                	mov    %eax,%edi
ffff8000001003e4:	48 b8 2e 02 10 00 00 	movabs $0xffff80000010022e,%rax
ffff8000001003eb:	80 ff ff 
ffff8000001003ee:	ff d0                	call   *%rax
ffff8000001003f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(!(b->flags & B_VALID)) {
ffff8000001003f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001003f8:	8b 00                	mov    (%rax),%eax
ffff8000001003fa:	83 e0 02             	and    $0x2,%eax
ffff8000001003fd:	85 c0                	test   %eax,%eax
ffff8000001003ff:	75 13                	jne    ffff800000100414 <bread+0x48>
    iderw(b);
ffff800000100401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100405:	48 89 c7             	mov    %rax,%rdi
ffff800000100408:	48 b8 bb 3c 10 00 00 	movabs $0xffff800000103cbb,%rax
ffff80000010040f:	80 ff ff 
ffff800000100412:	ff d0                	call   *%rax
  }
  return b;
ffff800000100414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000100418:	c9                   	leave
ffff800000100419:	c3                   	ret

ffff80000010041a <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
ffff80000010041a:	55                   	push   %rbp
ffff80000010041b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010041e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100422:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holdingsleep(&b->lock))
ffff800000100426:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010042a:	48 83 c0 10          	add    $0x10,%rax
ffff80000010042e:	48 89 c7             	mov    %rax,%rdi
ffff800000100431:	48 b8 1d 76 10 00 00 	movabs $0xffff80000010761d,%rax
ffff800000100438:	80 ff ff 
ffff80000010043b:	ff d0                	call   *%rax
ffff80000010043d:	85 c0                	test   %eax,%eax
ffff80000010043f:	75 19                	jne    ffff80000010045a <bwrite+0x40>
    panic("bwrite");
ffff800000100441:	48 b8 ef c7 10 00 00 	movabs $0xffff80000010c7ef,%rax
ffff800000100448:	80 ff ff 
ffff80000010044b:	48 89 c7             	mov    %rax,%rdi
ffff80000010044e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000100455:	80 ff ff 
ffff800000100458:	ff d0                	call   *%rax
  b->flags |= B_DIRTY;
ffff80000010045a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010045e:	8b 00                	mov    (%rax),%eax
ffff800000100460:	83 c8 04             	or     $0x4,%eax
ffff800000100463:	89 c2                	mov    %eax,%edx
ffff800000100465:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100469:	89 10                	mov    %edx,(%rax)
  iderw(b);
ffff80000010046b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010046f:	48 89 c7             	mov    %rax,%rdi
ffff800000100472:	48 b8 bb 3c 10 00 00 	movabs $0xffff800000103cbb,%rax
ffff800000100479:	80 ff ff 
ffff80000010047c:	ff d0                	call   *%rax
}
ffff80000010047e:	90                   	nop
ffff80000010047f:	c9                   	leave
ffff800000100480:	c3                   	ret

ffff800000100481 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
ffff800000100481:	55                   	push   %rbp
ffff800000100482:	48 89 e5             	mov    %rsp,%rbp
ffff800000100485:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100489:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holdingsleep(&b->lock))
ffff80000010048d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100491:	48 83 c0 10          	add    $0x10,%rax
ffff800000100495:	48 89 c7             	mov    %rax,%rdi
ffff800000100498:	48 b8 1d 76 10 00 00 	movabs $0xffff80000010761d,%rax
ffff80000010049f:	80 ff ff 
ffff8000001004a2:	ff d0                	call   *%rax
ffff8000001004a4:	85 c0                	test   %eax,%eax
ffff8000001004a6:	75 19                	jne    ffff8000001004c1 <brelse+0x40>
    panic("brelse");
ffff8000001004a8:	48 b8 f6 c7 10 00 00 	movabs $0xffff80000010c7f6,%rax
ffff8000001004af:	80 ff ff 
ffff8000001004b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004b5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001004bc:	80 ff ff 
ffff8000001004bf:	ff d0                	call   *%rax

  releasesleep(&b->lock);
ffff8000001004c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004c5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001004cc:	48 b8 b8 75 10 00 00 	movabs $0xffff8000001075b8,%rax
ffff8000001004d3:	80 ff ff 
ffff8000001004d6:	ff d0                	call   *%rax

  acquire(&bcache.lock);
ffff8000001004d8:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001004df:	80 ff ff 
ffff8000001004e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e5:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001004ec:	80 ff ff 
ffff8000001004ef:	ff d0                	call   *%rax
  b->refcnt--;
ffff8000001004f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004f5:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001004fb:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001004fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100502:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
  if (b->refcnt == 0) {
ffff800000100508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010050c:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000100512:	85 c0                	test   %eax,%eax
ffff800000100514:	0f 85 9c 00 00 00    	jne    ffff8000001005b6 <brelse+0x135>
    // no one is waiting for it.
    b->next->prev = b->prev;
ffff80000010051a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010051e:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff800000100525:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000100529:	48 8b 92 98 00 00 00 	mov    0x98(%rdx),%rdx
ffff800000100530:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    b->prev->next = b->next;
ffff800000100537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010053b:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100542:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000100546:	48 8b 92 a0 00 00 00 	mov    0xa0(%rdx),%rdx
ffff80000010054d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->next = bcache.head.next;
ffff800000100554:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010055b:	80 ff ff 
ffff80000010055e:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100569:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff800000100570:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100574:	48 b9 08 31 11 00 00 	movabs $0xffff800000113108,%rcx
ffff80000010057b:	80 ff ff 
ffff80000010057e:	48 89 88 98 00 00 00 	mov    %rcx,0x98(%rax)
    bcache.head.next->prev = b;
ffff800000100585:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff80000010058c:	80 ff ff 
ffff80000010058f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100596:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010059a:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001005a1:	48 ba 00 e0 10 00 00 	movabs $0xffff80000010e000,%rdx
ffff8000001005a8:	80 ff ff 
ffff8000001005ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001005af:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  }

  release(&bcache.lock);
ffff8000001005b6:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001005bd:	80 ff ff 
ffff8000001005c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001005c3:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001005ca:	80 ff ff 
ffff8000001005cd:	ff d0                	call   *%rax
}
ffff8000001005cf:	90                   	nop
ffff8000001005d0:	c9                   	leave
ffff8000001005d1:	c3                   	ret

ffff8000001005d2 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
ffff8000001005d2:	55                   	push   %rbp
ffff8000001005d3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005d6:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001005da:	89 f8                	mov    %edi,%eax
ffff8000001005dc:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff8000001005e0:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001005e4:	89 c2                	mov    %eax,%edx
ffff8000001005e6:	ec                   	in     (%dx),%al
ffff8000001005e7:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff8000001005ea:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff8000001005ee:	c9                   	leave
ffff8000001005ef:	c3                   	ret

ffff8000001005f0 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
ffff8000001005f0:	55                   	push   %rbp
ffff8000001005f1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005f4:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001005f8:	89 fa                	mov    %edi,%edx
ffff8000001005fa:	89 f0                	mov    %esi,%eax
ffff8000001005fc:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000100600:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000100603:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000100607:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010060b:	ee                   	out    %al,(%dx)
}
ffff80000010060c:	90                   	nop
ffff80000010060d:	c9                   	leave
ffff80000010060e:	c3                   	ret

ffff80000010060f <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
ffff80000010060f:	55                   	push   %rbp
ffff800000100610:	48 89 e5             	mov    %rsp,%rbp
ffff800000100613:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100617:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010061b:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  volatile ushort pd[5];
  addr_t addr = (addr_t)p;
ffff80000010061e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000100622:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  pd[0] = size-1;
ffff800000100626:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000100629:	83 e8 01             	sub    $0x1,%eax
ffff80000010062c:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff800000100630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100634:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff800000100638:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010063c:	48 c1 e8 10          	shr    $0x10,%rax
ffff800000100640:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff800000100644:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100648:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010064c:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff800000100650:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100654:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000100658:	66 89 45 f6          	mov    %ax,-0xa(%rbp)

  asm volatile("lidt (%0)" : : "r" (pd));
ffff80000010065c:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff800000100660:	0f 01 18             	lidt   (%rax)
}
ffff800000100663:	90                   	nop
ffff800000100664:	c9                   	leave
ffff800000100665:	c3                   	ret

ffff800000100666 <cli>:
  return eflags;
}

static inline void
cli(void)
{
ffff800000100666:	55                   	push   %rbp
ffff800000100667:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffff80000010066a:	fa                   	cli
}
ffff80000010066b:	90                   	nop
ffff80000010066c:	5d                   	pop    %rbp
ffff80000010066d:	c3                   	ret

ffff80000010066e <hlt>:
  asm volatile("sti");
}

static inline void
hlt(void)
{
ffff80000010066e:	55                   	push   %rbp
ffff80000010066f:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff800000100672:	f4                   	hlt
}
ffff800000100673:	90                   	nop
ffff800000100674:	5d                   	pop    %rbp
ffff800000100675:	c3                   	ret

ffff800000100676 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(addr_t x)
{
ffff800000100676:	55                   	push   %rbp
ffff800000100677:	48 89 e5             	mov    %rsp,%rbp
ffff80000010067a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010067e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
ffff800000100682:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100689:	eb 30                	jmp    ffff8000001006bb <print_x64+0x45>
    consputc(digits[x >> (sizeof(addr_t) * 8 - 4)]);
ffff80000010068b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010068f:	48 c1 e8 3c          	shr    $0x3c,%rax
ffff800000100693:	48 ba 00 d0 10 00 00 	movabs $0xffff80000010d000,%rdx
ffff80000010069a:	80 ff ff 
ffff80000010069d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001006a1:	0f be c0             	movsbl %al,%eax
ffff8000001006a4:	89 c7                	mov    %eax,%edi
ffff8000001006a6:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001006ad:	80 ff ff 
ffff8000001006b0:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
ffff8000001006b2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001006b6:	48 c1 65 e8 04       	shlq   $0x4,-0x18(%rbp)
ffff8000001006bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001006be:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001006c1:	76 c8                	jbe    ffff80000010068b <print_x64+0x15>
}
ffff8000001006c3:	90                   	nop
ffff8000001006c4:	90                   	nop
ffff8000001006c5:	c9                   	leave
ffff8000001006c6:	c3                   	ret

ffff8000001006c7 <print_x32>:

  static void
print_x32(uint x)
{
ffff8000001006c7:	55                   	push   %rbp
ffff8000001006c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001006cb:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001006cf:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
ffff8000001006d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001006d9:	eb 31                	jmp    ffff80000010070c <print_x32+0x45>
    consputc(digits[x >> (sizeof(uint) * 8 - 4)]);
ffff8000001006db:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001006de:	c1 e8 1c             	shr    $0x1c,%eax
ffff8000001006e1:	89 c2                	mov    %eax,%edx
ffff8000001006e3:	48 b8 00 d0 10 00 00 	movabs $0xffff80000010d000,%rax
ffff8000001006ea:	80 ff ff 
ffff8000001006ed:	89 d2                	mov    %edx,%edx
ffff8000001006ef:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
ffff8000001006f3:	0f be c0             	movsbl %al,%eax
ffff8000001006f6:	89 c7                	mov    %eax,%edi
ffff8000001006f8:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001006ff:	80 ff ff 
ffff800000100702:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
ffff800000100704:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100708:	c1 65 ec 04          	shll   $0x4,-0x14(%rbp)
ffff80000010070c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010070f:	83 f8 07             	cmp    $0x7,%eax
ffff800000100712:	76 c7                	jbe    ffff8000001006db <print_x32+0x14>
}
ffff800000100714:	90                   	nop
ffff800000100715:	90                   	nop
ffff800000100716:	c9                   	leave
ffff800000100717:	c3                   	ret

ffff800000100718 <print_d>:

  static void
print_d(int v)
{
ffff800000100718:	55                   	push   %rbp
ffff800000100719:	48 89 e5             	mov    %rsp,%rbp
ffff80000010071c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100720:	89 7d dc             	mov    %edi,-0x24(%rbp)
  char buf[16];
  int64 x = v;
ffff800000100723:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000100726:	48 98                	cltq
ffff800000100728:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
ffff80000010072c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000100730:	79 04                	jns    ffff800000100736 <print_d+0x1e>
    x = -x;
ffff800000100732:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
ffff800000100736:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
ffff80000010073d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000100741:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
ffff800000100748:	66 66 66 
ffff80000010074b:	48 89 c8             	mov    %rcx,%rax
ffff80000010074e:	48 f7 ea             	imul   %rdx
ffff800000100751:	48 c1 fa 02          	sar    $0x2,%rdx
ffff800000100755:	48 89 c8             	mov    %rcx,%rax
ffff800000100758:	48 c1 f8 3f          	sar    $0x3f,%rax
ffff80000010075c:	48 29 c2             	sub    %rax,%rdx
ffff80000010075f:	48 89 d0             	mov    %rdx,%rax
ffff800000100762:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000100766:	48 01 d0             	add    %rdx,%rax
ffff800000100769:	48 01 c0             	add    %rax,%rax
ffff80000010076c:	48 29 c1             	sub    %rax,%rcx
ffff80000010076f:	48 89 ca             	mov    %rcx,%rdx
ffff800000100772:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000100775:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000100778:	89 4d f4             	mov    %ecx,-0xc(%rbp)
ffff80000010077b:	48 b9 00 d0 10 00 00 	movabs $0xffff80000010d000,%rcx
ffff800000100782:	80 ff ff 
ffff800000100785:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
ffff800000100789:	48 98                	cltq
ffff80000010078b:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
ffff80000010078f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000100793:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
ffff80000010079a:	66 66 66 
ffff80000010079d:	48 89 c8             	mov    %rcx,%rax
ffff8000001007a0:	48 f7 ea             	imul   %rdx
ffff8000001007a3:	48 89 d0             	mov    %rdx,%rax
ffff8000001007a6:	48 c1 f8 02          	sar    $0x2,%rax
ffff8000001007aa:	48 c1 f9 3f          	sar    $0x3f,%rcx
ffff8000001007ae:	48 89 ca             	mov    %rcx,%rdx
ffff8000001007b1:	48 29 d0             	sub    %rdx,%rax
ffff8000001007b4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
ffff8000001007b8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001007bd:	0f 85 7a ff ff ff    	jne    ffff80000010073d <print_d+0x25>

  if (v < 0)
ffff8000001007c3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff8000001007c7:	79 2d                	jns    ffff8000001007f6 <print_d+0xde>
    buf[i++] = '-';
ffff8000001007c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007cc:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001007cf:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff8000001007d2:	48 98                	cltq
ffff8000001007d4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
ffff8000001007d9:	eb 1b                	jmp    ffff8000001007f6 <print_d+0xde>
    consputc(buf[i]);
ffff8000001007db:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007de:	48 98                	cltq
ffff8000001007e0:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
ffff8000001007e5:	0f be c0             	movsbl %al,%eax
ffff8000001007e8:	89 c7                	mov    %eax,%edi
ffff8000001007ea:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001007f1:	80 ff ff 
ffff8000001007f4:	ff d0                	call   *%rax
  while (--i >= 0)
ffff8000001007f6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
ffff8000001007fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff8000001007fe:	79 db                	jns    ffff8000001007db <print_d+0xc3>
}
ffff800000100800:	90                   	nop
ffff800000100801:	90                   	nop
ffff800000100802:	c9                   	leave
ffff800000100803:	c3                   	ret

ffff800000100804 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
  void
cprintf(char *fmt, ...)
{
ffff800000100804:	55                   	push   %rbp
ffff800000100805:	48 89 e5             	mov    %rsp,%rbp
ffff800000100808:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
ffff80000010080f:	48 89 bd 18 ff ff ff 	mov    %rdi,-0xe8(%rbp)
ffff800000100816:	48 89 b5 58 ff ff ff 	mov    %rsi,-0xa8(%rbp)
ffff80000010081d:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
ffff800000100824:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
ffff80000010082b:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
ffff800000100832:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
ffff800000100839:	84 c0                	test   %al,%al
ffff80000010083b:	74 20                	je     ffff80000010085d <cprintf+0x59>
ffff80000010083d:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
ffff800000100841:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
ffff800000100845:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
ffff800000100849:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
ffff80000010084d:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
ffff800000100851:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
ffff800000100855:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
ffff800000100859:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c, locking;
  char *s;

  va_start(ap, fmt);
ffff80000010085d:	c7 85 20 ff ff ff 08 	movl   $0x8,-0xe0(%rbp)
ffff800000100864:	00 00 00 
ffff800000100867:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
ffff80000010086e:	00 00 00 
ffff800000100871:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffff800000100875:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffff80000010087c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
ffff800000100883:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)

  locking = cons.locking;
ffff80000010088a:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100891:	80 ff ff 
ffff800000100894:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000100897:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if (locking)
ffff80000010089d:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff8000001008a4:	74 19                	je     ffff8000001008bf <cprintf+0xbb>
    acquire(&cons.lock);
ffff8000001008a6:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001008ad:	80 ff ff 
ffff8000001008b0:	48 89 c7             	mov    %rax,%rdi
ffff8000001008b3:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001008ba:	80 ff ff 
ffff8000001008bd:	ff d0                	call   *%rax

  if (fmt == 0)
ffff8000001008bf:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008c6:	00 
ffff8000001008c7:	75 19                	jne    ffff8000001008e2 <cprintf+0xde>
    panic("null fmt");
ffff8000001008c9:	48 b8 fd c7 10 00 00 	movabs $0xffff80000010c7fd,%rax
ffff8000001008d0:	80 ff ff 
ffff8000001008d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001008d6:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001008dd:	80 ff ff 
ffff8000001008e0:	ff d0                	call   *%rax

  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff8000001008e2:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
ffff8000001008e9:	00 00 00 
ffff8000001008ec:	e9 a0 02 00 00       	jmp    ffff800000100b91 <cprintf+0x38d>
    if (c != '%') {
ffff8000001008f1:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff8000001008f8:	74 19                	je     ffff800000100913 <cprintf+0x10f>
      consputc(c);
ffff8000001008fa:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100900:	89 c7                	mov    %eax,%edi
ffff800000100902:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100909:	80 ff ff 
ffff80000010090c:	ff d0                	call   *%rax
      continue;
ffff80000010090e:	e9 77 02 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    }
    c = fmt[++i] & 0xff;
ffff800000100913:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff80000010091a:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100920:	48 63 d0             	movslq %eax,%rdx
ffff800000100923:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff80000010092a:	48 01 d0             	add    %rdx,%rax
ffff80000010092d:	0f b6 00             	movzbl (%rax),%eax
ffff800000100930:	0f be c0             	movsbl %al,%eax
ffff800000100933:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100938:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
    if (c == 0)
ffff80000010093e:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000100945:	0f 84 79 02 00 00    	je     ffff800000100bc4 <cprintf+0x3c0>
      break;
    switch(c) {
ffff80000010094b:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffff800000100952:	0f 84 b0 00 00 00    	je     ffff800000100a08 <cprintf+0x204>
ffff800000100958:	83 bd 38 ff ff ff 78 	cmpl   $0x78,-0xc8(%rbp)
ffff80000010095f:	0f 8f ff 01 00 00    	jg     ffff800000100b64 <cprintf+0x360>
ffff800000100965:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffff80000010096c:	0f 84 42 01 00 00    	je     ffff800000100ab4 <cprintf+0x2b0>
ffff800000100972:	83 bd 38 ff ff ff 73 	cmpl   $0x73,-0xc8(%rbp)
ffff800000100979:	0f 8f e5 01 00 00    	jg     ffff800000100b64 <cprintf+0x360>
ffff80000010097f:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffff800000100986:	0f 84 d1 00 00 00    	je     ffff800000100a5d <cprintf+0x259>
ffff80000010098c:	83 bd 38 ff ff ff 70 	cmpl   $0x70,-0xc8(%rbp)
ffff800000100993:	0f 8f cb 01 00 00    	jg     ffff800000100b64 <cprintf+0x360>
ffff800000100999:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff8000001009a0:	0f 84 ab 01 00 00    	je     ffff800000100b51 <cprintf+0x34d>
ffff8000001009a6:	83 bd 38 ff ff ff 64 	cmpl   $0x64,-0xc8(%rbp)
ffff8000001009ad:	0f 85 b1 01 00 00    	jne    ffff800000100b64 <cprintf+0x360>
    case 'd':
      print_d(va_arg(ap, int));
ffff8000001009b3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff8000001009b9:	83 f8 2f             	cmp    $0x2f,%eax
ffff8000001009bc:	77 23                	ja     ffff8000001009e1 <cprintf+0x1dd>
ffff8000001009be:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff8000001009c5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff8000001009cb:	89 d2                	mov    %edx,%edx
ffff8000001009cd:	48 01 d0             	add    %rdx,%rax
ffff8000001009d0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff8000001009d6:	83 c2 08             	add    $0x8,%edx
ffff8000001009d9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff8000001009df:	eb 12                	jmp    ffff8000001009f3 <cprintf+0x1ef>
ffff8000001009e1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff8000001009e8:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff8000001009ec:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff8000001009f3:	8b 00                	mov    (%rax),%eax
ffff8000001009f5:	89 c7                	mov    %eax,%edi
ffff8000001009f7:	48 b8 18 07 10 00 00 	movabs $0xffff800000100718,%rax
ffff8000001009fe:	80 ff ff 
ffff800000100a01:	ff d0                	call   *%rax
      break;
ffff800000100a03:	e9 82 01 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    case 'x':
      print_x32(va_arg(ap, uint));
ffff800000100a08:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100a0e:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100a11:	77 23                	ja     ffff800000100a36 <cprintf+0x232>
ffff800000100a13:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100a1a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a20:	89 d2                	mov    %edx,%edx
ffff800000100a22:	48 01 d0             	add    %rdx,%rax
ffff800000100a25:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a2b:	83 c2 08             	add    $0x8,%edx
ffff800000100a2e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100a34:	eb 12                	jmp    ffff800000100a48 <cprintf+0x244>
ffff800000100a36:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100a3d:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100a41:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100a48:	8b 00                	mov    (%rax),%eax
ffff800000100a4a:	89 c7                	mov    %eax,%edi
ffff800000100a4c:	48 b8 c7 06 10 00 00 	movabs $0xffff8000001006c7,%rax
ffff800000100a53:	80 ff ff 
ffff800000100a56:	ff d0                	call   *%rax
      break;
ffff800000100a58:	e9 2d 01 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    case 'p':
      print_x64(va_arg(ap, addr_t));
ffff800000100a5d:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100a63:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100a66:	77 23                	ja     ffff800000100a8b <cprintf+0x287>
ffff800000100a68:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100a6f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a75:	89 d2                	mov    %edx,%edx
ffff800000100a77:	48 01 d0             	add    %rdx,%rax
ffff800000100a7a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100a80:	83 c2 08             	add    $0x8,%edx
ffff800000100a83:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100a89:	eb 12                	jmp    ffff800000100a9d <cprintf+0x299>
ffff800000100a8b:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100a92:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100a96:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100a9d:	48 8b 00             	mov    (%rax),%rax
ffff800000100aa0:	48 89 c7             	mov    %rax,%rdi
ffff800000100aa3:	48 b8 76 06 10 00 00 	movabs $0xffff800000100676,%rax
ffff800000100aaa:	80 ff ff 
ffff800000100aad:	ff d0                	call   *%rax
      break;
ffff800000100aaf:	e9 d6 00 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
ffff800000100ab4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
ffff800000100aba:	83 f8 2f             	cmp    $0x2f,%eax
ffff800000100abd:	77 23                	ja     ffff800000100ae2 <cprintf+0x2de>
ffff800000100abf:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
ffff800000100ac6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100acc:	89 d2                	mov    %edx,%edx
ffff800000100ace:	48 01 d0             	add    %rdx,%rax
ffff800000100ad1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
ffff800000100ad7:	83 c2 08             	add    $0x8,%edx
ffff800000100ada:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
ffff800000100ae0:	eb 12                	jmp    ffff800000100af4 <cprintf+0x2f0>
ffff800000100ae2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
ffff800000100ae9:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000100aed:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
ffff800000100af4:	48 8b 00             	mov    (%rax),%rax
ffff800000100af7:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
ffff800000100afe:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
ffff800000100b05:	00 
ffff800000100b06:	75 39                	jne    ffff800000100b41 <cprintf+0x33d>
        s = "(null)";
ffff800000100b08:	48 b8 06 c8 10 00 00 	movabs $0xffff80000010c806,%rax
ffff800000100b0f:	80 ff ff 
ffff800000100b12:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
ffff800000100b19:	eb 26                	jmp    ffff800000100b41 <cprintf+0x33d>
        consputc(*(s++));
ffff800000100b1b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b22:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000100b26:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
ffff800000100b2d:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b30:	0f be c0             	movsbl %al,%eax
ffff800000100b33:	89 c7                	mov    %eax,%edi
ffff800000100b35:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b3c:	80 ff ff 
ffff800000100b3f:	ff d0                	call   *%rax
      while (*s)
ffff800000100b41:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b48:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b4b:	84 c0                	test   %al,%al
ffff800000100b4d:	75 cc                	jne    ffff800000100b1b <cprintf+0x317>
      break;
ffff800000100b4f:	eb 39                	jmp    ffff800000100b8a <cprintf+0x386>
    case '%':
      consputc('%');
ffff800000100b51:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b56:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b5d:	80 ff ff 
ffff800000100b60:	ff d0                	call   *%rax
      break;
ffff800000100b62:	eb 26                	jmp    ffff800000100b8a <cprintf+0x386>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
ffff800000100b64:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b69:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b70:	80 ff ff 
ffff800000100b73:	ff d0                	call   *%rax
      consputc(c);
ffff800000100b75:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100b7b:	89 c7                	mov    %eax,%edi
ffff800000100b7d:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000100b84:	80 ff ff 
ffff800000100b87:	ff d0                	call   *%rax
      break;
ffff800000100b89:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffff800000100b8a:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff800000100b91:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100b97:	48 63 d0             	movslq %eax,%rdx
ffff800000100b9a:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff800000100ba1:	48 01 d0             	add    %rdx,%rax
ffff800000100ba4:	0f b6 00             	movzbl (%rax),%eax
ffff800000100ba7:	0f be c0             	movsbl %al,%eax
ffff800000100baa:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100baf:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffff800000100bb5:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000100bbc:	0f 85 2f fd ff ff    	jne    ffff8000001008f1 <cprintf+0xed>
ffff800000100bc2:	eb 01                	jmp    ffff800000100bc5 <cprintf+0x3c1>
      break;
ffff800000100bc4:	90                   	nop
    }
  }

  if (locking)
ffff800000100bc5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff800000100bcc:	74 19                	je     ffff800000100be7 <cprintf+0x3e3>
    release(&cons.lock);
ffff800000100bce:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100bd5:	80 ff ff 
ffff800000100bd8:	48 89 c7             	mov    %rax,%rdi
ffff800000100bdb:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000100be2:	80 ff ff 
ffff800000100be5:	ff d0                	call   *%rax
}
ffff800000100be7:	90                   	nop
ffff800000100be8:	c9                   	leave
ffff800000100be9:	c3                   	ret

ffff800000100bea <panic>:

__attribute__((noreturn))
  void
panic(char *s)
{
ffff800000100bea:	55                   	push   %rbp
ffff800000100beb:	48 89 e5             	mov    %rsp,%rbp
ffff800000100bee:	48 83 ec 70          	sub    $0x70,%rsp
ffff800000100bf2:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
  int i;
  addr_t pcs[10];

  cli();
ffff800000100bf6:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000100bfd:	80 ff ff 
ffff800000100c00:	ff d0                	call   *%rax
  cons.locking = 0;
ffff800000100c02:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000100c09:	80 ff ff 
ffff800000100c0c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  cprintf("cpu%d: panic: ", cpu->id);
ffff800000100c13:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000100c1a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000100c1e:	0f b6 00             	movzbl (%rax),%eax
ffff800000100c21:	0f b6 c0             	movzbl %al,%eax
ffff800000100c24:	48 ba 0d c8 10 00 00 	movabs $0xffff80000010c80d,%rdx
ffff800000100c2b:	80 ff ff 
ffff800000100c2e:	89 c6                	mov    %eax,%esi
ffff800000100c30:	48 89 d7             	mov    %rdx,%rdi
ffff800000100c33:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c38:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c3f:	80 ff ff 
ffff800000100c42:	ff d2                	call   *%rdx
  cprintf(s);
ffff800000100c44:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000100c48:	48 89 c7             	mov    %rax,%rdi
ffff800000100c4b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c50:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c57:	80 ff ff 
ffff800000100c5a:	ff d2                	call   *%rdx
  cprintf("\n");
ffff800000100c5c:	48 b8 1c c8 10 00 00 	movabs $0xffff80000010c81c,%rax
ffff800000100c63:	80 ff ff 
ffff800000100c66:	48 89 c7             	mov    %rax,%rdi
ffff800000100c69:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c6e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c75:	80 ff ff 
ffff800000100c78:	ff d2                	call   *%rdx
  getcallerpcs(&s, pcs);
ffff800000100c7a:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
ffff800000100c7e:	48 8d 45 98          	lea    -0x68(%rbp),%rax
ffff800000100c82:	48 89 d6             	mov    %rdx,%rsi
ffff800000100c85:	48 89 c7             	mov    %rax,%rdi
ffff800000100c88:	48 b8 fb 77 10 00 00 	movabs $0xffff8000001077fb,%rax
ffff800000100c8f:	80 ff ff 
ffff800000100c92:	ff d0                	call   *%rax
  for (i=0; i<10; i++)
ffff800000100c94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100c9b:	eb 2f                	jmp    ffff800000100ccc <panic+0xe2>
    cprintf(" %p\n", pcs[i]);
ffff800000100c9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ca0:	48 98                	cltq
ffff800000100ca2:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffff800000100ca7:	48 ba 1e c8 10 00 00 	movabs $0xffff80000010c81e,%rdx
ffff800000100cae:	80 ff ff 
ffff800000100cb1:	48 89 c6             	mov    %rax,%rsi
ffff800000100cb4:	48 89 d7             	mov    %rdx,%rdi
ffff800000100cb7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100cbc:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100cc3:	80 ff ff 
ffff800000100cc6:	ff d2                	call   *%rdx
  for (i=0; i<10; i++)
ffff800000100cc8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100ccc:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000100cd0:	7e cb                	jle    ffff800000100c9d <panic+0xb3>
  panicked = 1; // freeze other CPU
ffff800000100cd2:	48 b8 b8 34 11 00 00 	movabs $0xffff8000001134b8,%rax
ffff800000100cd9:	80 ff ff 
ffff800000100cdc:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  for (;;)
    hlt();
ffff800000100ce2:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff800000100ce9:	80 ff ff 
ffff800000100cec:	ff d0                	call   *%rax
ffff800000100cee:	eb f2                	jmp    ffff800000100ce2 <panic+0xf8>

ffff800000100cf0 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

  static void
cgaputc(int c)
{
ffff800000100cf0:	55                   	push   %rbp
ffff800000100cf1:	48 89 e5             	mov    %rsp,%rbp
ffff800000100cf4:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100cf8:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
ffff800000100cfb:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100d00:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d05:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100d0c:	80 ff ff 
ffff800000100d0f:	ff d0                	call   *%rax
  pos = inb(CRTPORT+1) << 8;
ffff800000100d11:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d16:	48 b8 d2 05 10 00 00 	movabs $0xffff8000001005d2,%rax
ffff800000100d1d:	80 ff ff 
ffff800000100d20:	ff d0                	call   *%rax
ffff800000100d22:	0f b6 c0             	movzbl %al,%eax
ffff800000100d25:	c1 e0 08             	shl    $0x8,%eax
ffff800000100d28:	89 45 fc             	mov    %eax,-0x4(%rbp)
  outb(CRTPORT, 15);
ffff800000100d2b:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100d30:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d35:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100d3c:	80 ff ff 
ffff800000100d3f:	ff d0                	call   *%rax
  pos |= inb(CRTPORT+1);
ffff800000100d41:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d46:	48 b8 d2 05 10 00 00 	movabs $0xffff8000001005d2,%rax
ffff800000100d4d:	80 ff ff 
ffff800000100d50:	ff d0                	call   *%rax
ffff800000100d52:	0f b6 c0             	movzbl %al,%eax
ffff800000100d55:	09 45 fc             	or     %eax,-0x4(%rbp)

  if (c == '\n')
ffff800000100d58:	83 7d ec 0a          	cmpl   $0xa,-0x14(%rbp)
ffff800000100d5c:	75 37                	jne    ffff800000100d95 <cgaputc+0xa5>
    pos += 80 - pos%80;
ffff800000100d5e:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100d61:	48 63 c1             	movslq %ecx,%rax
ffff800000100d64:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
ffff800000100d6b:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000100d6f:	89 c2                	mov    %eax,%edx
ffff800000100d71:	c1 fa 05             	sar    $0x5,%edx
ffff800000100d74:	89 c8                	mov    %ecx,%eax
ffff800000100d76:	c1 f8 1f             	sar    $0x1f,%eax
ffff800000100d79:	29 c2                	sub    %eax,%edx
ffff800000100d7b:	89 d0                	mov    %edx,%eax
ffff800000100d7d:	c1 e0 02             	shl    $0x2,%eax
ffff800000100d80:	01 d0                	add    %edx,%eax
ffff800000100d82:	c1 e0 04             	shl    $0x4,%eax
ffff800000100d85:	29 c1                	sub    %eax,%ecx
ffff800000100d87:	89 ca                	mov    %ecx,%edx
ffff800000100d89:	b8 50 00 00 00       	mov    $0x50,%eax
ffff800000100d8e:	29 d0                	sub    %edx,%eax
ffff800000100d90:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff800000100d93:	eb 43                	jmp    ffff800000100dd8 <cgaputc+0xe8>
  else if (c == BACKSPACE) {
ffff800000100d95:	81 7d ec 00 01 00 00 	cmpl   $0x100,-0x14(%rbp)
ffff800000100d9c:	75 0c                	jne    ffff800000100daa <cgaputc+0xba>
    if (pos > 0) --pos;
ffff800000100d9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000100da2:	7e 34                	jle    ffff800000100dd8 <cgaputc+0xe8>
ffff800000100da4:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffff800000100da8:	eb 2e                	jmp    ffff800000100dd8 <cgaputc+0xe8>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // gray on black
ffff800000100daa:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000100dad:	0f b6 c0             	movzbl %al,%eax
ffff800000100db0:	80 cc 07             	or     $0x7,%ah
ffff800000100db3:	89 c6                	mov    %eax,%esi
ffff800000100db5:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100dbc:	80 ff ff 
ffff800000100dbf:	48 8b 08             	mov    (%rax),%rcx
ffff800000100dc2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100dc5:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100dc8:	89 55 fc             	mov    %edx,-0x4(%rbp)
ffff800000100dcb:	48 98                	cltq
ffff800000100dcd:	48 01 c0             	add    %rax,%rax
ffff800000100dd0:	48 01 c8             	add    %rcx,%rax
ffff800000100dd3:	89 f2                	mov    %esi,%edx
ffff800000100dd5:	66 89 10             	mov    %dx,(%rax)

  if ((pos/80) >= 24){  // Scroll up.
ffff800000100dd8:	81 7d fc 7f 07 00 00 	cmpl   $0x77f,-0x4(%rbp)
ffff800000100ddf:	7e 74                	jle    ffff800000100e55 <cgaputc+0x165>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
ffff800000100de1:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100de8:	80 ff ff 
ffff800000100deb:	48 8b 00             	mov    (%rax),%rax
ffff800000100dee:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff800000100df5:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100dfc:	80 ff ff 
ffff800000100dff:	48 8b 00             	mov    (%rax),%rax
ffff800000100e02:	ba 60 0e 00 00       	mov    $0xe60,%edx
ffff800000100e07:	48 89 ce             	mov    %rcx,%rsi
ffff800000100e0a:	48 89 c7             	mov    %rax,%rdi
ffff800000100e0d:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff800000100e14:	80 ff ff 
ffff800000100e17:	ff d0                	call   *%rax
    pos -= 80;
ffff800000100e19:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
ffff800000100e1d:	b8 80 07 00 00       	mov    $0x780,%eax
ffff800000100e22:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000100e25:	8d 14 00             	lea    (%rax,%rax,1),%edx
ffff800000100e28:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100e2f:	80 ff ff 
ffff800000100e32:	48 8b 00             	mov    (%rax),%rax
ffff800000100e35:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000100e38:	48 63 c9             	movslq %ecx,%rcx
ffff800000100e3b:	48 01 c9             	add    %rcx,%rcx
ffff800000100e3e:	48 01 c8             	add    %rcx,%rax
ffff800000100e41:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000100e46:	48 89 c7             	mov    %rax,%rdi
ffff800000100e49:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000100e50:	80 ff ff 
ffff800000100e53:	ff d0                	call   *%rax
  }

  outb(CRTPORT, 14);
ffff800000100e55:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100e5a:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100e5f:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e66:	80 ff ff 
ffff800000100e69:	ff d0                	call   *%rax
  outb(CRTPORT+1, pos>>8);
ffff800000100e6b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100e6e:	c1 f8 08             	sar    $0x8,%eax
ffff800000100e71:	0f b6 c0             	movzbl %al,%eax
ffff800000100e74:	89 c6                	mov    %eax,%esi
ffff800000100e76:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100e7b:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e82:	80 ff ff 
ffff800000100e85:	ff d0                	call   *%rax
  outb(CRTPORT, 15);
ffff800000100e87:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100e8c:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100e91:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e98:	80 ff ff 
ffff800000100e9b:	ff d0                	call   *%rax
  outb(CRTPORT+1, pos);
ffff800000100e9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ea0:	0f b6 c0             	movzbl %al,%eax
ffff800000100ea3:	89 c6                	mov    %eax,%esi
ffff800000100ea5:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100eaa:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100eb1:	80 ff ff 
ffff800000100eb4:	ff d0                	call   *%rax
  crt[pos] = ' ' | 0x0700;
ffff800000100eb6:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100ebd:	80 ff ff 
ffff800000100ec0:	48 8b 00             	mov    (%rax),%rax
ffff800000100ec3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100ec6:	48 63 d2             	movslq %edx,%rdx
ffff800000100ec9:	48 01 d2             	add    %rdx,%rdx
ffff800000100ecc:	48 01 d0             	add    %rdx,%rax
ffff800000100ecf:	66 c7 00 20 07       	movw   $0x720,(%rax)
}
ffff800000100ed4:	90                   	nop
ffff800000100ed5:	c9                   	leave
ffff800000100ed6:	c3                   	ret

ffff800000100ed7 <consputc>:

  void
consputc(int c)
{
ffff800000100ed7:	55                   	push   %rbp
ffff800000100ed8:	48 89 e5             	mov    %rsp,%rbp
ffff800000100edb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100edf:	89 7d fc             	mov    %edi,-0x4(%rbp)
  if (panicked) {
ffff800000100ee2:	48 b8 b8 34 11 00 00 	movabs $0xffff8000001134b8,%rax
ffff800000100ee9:	80 ff ff 
ffff800000100eec:	8b 00                	mov    (%rax),%eax
ffff800000100eee:	85 c0                	test   %eax,%eax
ffff800000100ef0:	74 1a                	je     ffff800000100f0c <consputc+0x35>
    cli();
ffff800000100ef2:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000100ef9:	80 ff ff 
ffff800000100efc:	ff d0                	call   *%rax
    for(;;)
      hlt();
ffff800000100efe:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff800000100f05:	80 ff ff 
ffff800000100f08:	ff d0                	call   *%rax
ffff800000100f0a:	eb f2                	jmp    ffff800000100efe <consputc+0x27>
  }

  if (c == BACKSPACE) {
ffff800000100f0c:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffff800000100f13:	75 35                	jne    ffff800000100f4a <consputc+0x73>
    uartputc('\b'); uartputc(' '); uartputc('\b');
ffff800000100f15:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f1a:	48 b8 db a7 10 00 00 	movabs $0xffff80000010a7db,%rax
ffff800000100f21:	80 ff ff 
ffff800000100f24:	ff d0                	call   *%rax
ffff800000100f26:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000100f2b:	48 b8 db a7 10 00 00 	movabs $0xffff80000010a7db,%rax
ffff800000100f32:	80 ff ff 
ffff800000100f35:	ff d0                	call   *%rax
ffff800000100f37:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f3c:	48 b8 db a7 10 00 00 	movabs $0xffff80000010a7db,%rax
ffff800000100f43:	80 ff ff 
ffff800000100f46:	ff d0                	call   *%rax
ffff800000100f48:	eb 11                	jmp    ffff800000100f5b <consputc+0x84>
  } else
    uartputc(c);
ffff800000100f4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f4d:	89 c7                	mov    %eax,%edi
ffff800000100f4f:	48 b8 db a7 10 00 00 	movabs $0xffff80000010a7db,%rax
ffff800000100f56:	80 ff ff 
ffff800000100f59:	ff d0                	call   *%rax
  cgaputc(c);
ffff800000100f5b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f5e:	89 c7                	mov    %eax,%edi
ffff800000100f60:	48 b8 f0 0c 10 00 00 	movabs $0xffff800000100cf0,%rax
ffff800000100f67:	80 ff ff 
ffff800000100f6a:	ff d0                	call   *%rax
}
ffff800000100f6c:	90                   	nop
ffff800000100f6d:	c9                   	leave
ffff800000100f6e:	c3                   	ret

ffff800000100f6f <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

  void
consoleintr(int (*getc)(void))
{
ffff800000100f6f:	55                   	push   %rbp
ffff800000100f70:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f73:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100f77:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int c;

  acquire(&input.lock);
ffff800000100f7b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000100f82:	80 ff ff 
ffff800000100f85:	48 89 c7             	mov    %rax,%rdi
ffff800000100f88:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000100f8f:	80 ff ff 
ffff800000100f92:	ff d0                	call   *%rax
  while((c = getc()) >= 0){
ffff800000100f94:	e9 6d 02 00 00       	jmp    ffff800000101206 <consoleintr+0x297>
    switch(c){
ffff800000100f99:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000100f9d:	0f 84 fd 00 00 00    	je     ffff8000001010a0 <consoleintr+0x131>
ffff800000100fa3:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000100fa7:	0f 8f 54 01 00 00    	jg     ffff800000101101 <consoleintr+0x192>
ffff800000100fad:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff800000100fb1:	74 2f                	je     ffff800000100fe2 <consoleintr+0x73>
ffff800000100fb3:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff800000100fb7:	0f 8f 44 01 00 00    	jg     ffff800000101101 <consoleintr+0x192>
ffff800000100fbd:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff800000100fc1:	74 7f                	je     ffff800000101042 <consoleintr+0xd3>
ffff800000100fc3:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff800000100fc7:	0f 8f 34 01 00 00    	jg     ffff800000101101 <consoleintr+0x192>
ffff800000100fcd:	83 7d fc 08          	cmpl   $0x8,-0x4(%rbp)
ffff800000100fd1:	0f 84 c9 00 00 00    	je     ffff8000001010a0 <consoleintr+0x131>
ffff800000100fd7:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
ffff800000100fdb:	74 20                	je     ffff800000100ffd <consoleintr+0x8e>
ffff800000100fdd:	e9 1f 01 00 00       	jmp    ffff800000101101 <consoleintr+0x192>
    case C('Z'): // reboot
      lidt(0,0);
ffff800000100fe2:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000100fe7:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000100fec:	48 b8 0f 06 10 00 00 	movabs $0xffff80000010060f,%rax
ffff800000100ff3:	80 ff ff 
ffff800000100ff6:	ff d0                	call   *%rax
      break;
ffff800000100ff8:	e9 09 02 00 00       	jmp    ffff800000101206 <consoleintr+0x297>
    case C('P'):  // Process listing.
      procdump();
ffff800000100ffd:	48 b8 39 73 10 00 00 	movabs $0xffff800000107339,%rax
ffff800000101004:	80 ff ff 
ffff800000101007:	ff d0                	call   *%rax
      break;
ffff800000101009:	e9 f8 01 00 00       	jmp    ffff800000101206 <consoleintr+0x297>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffff80000010100e:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101015:	80 ff ff 
ffff800000101018:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff80000010101e:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101021:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101028:	80 ff ff 
ffff80000010102b:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff800000101031:	bf 00 01 00 00       	mov    $0x100,%edi
ffff800000101036:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff80000010103d:	80 ff ff 
ffff800000101040:	ff d0                	call   *%rax
      while(input.e != input.w &&
ffff800000101042:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101049:	80 ff ff 
ffff80000010104c:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff800000101052:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101059:	80 ff ff 
ffff80000010105c:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101062:	39 c2                	cmp    %eax,%edx
ffff800000101064:	0f 84 95 01 00 00    	je     ffff8000001011ff <consoleintr+0x290>
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffff80000010106a:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101071:	80 ff ff 
ffff800000101074:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff80000010107a:	83 e8 01             	sub    $0x1,%eax
ffff80000010107d:	83 e0 7f             	and    $0x7f,%eax
ffff800000101080:	89 c2                	mov    %eax,%edx
ffff800000101082:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101089:	80 ff ff 
ffff80000010108c:	89 d2                	mov    %edx,%edx
ffff80000010108e:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
      while(input.e != input.w &&
ffff800000101093:	3c 0a                	cmp    $0xa,%al
ffff800000101095:	0f 85 73 ff ff ff    	jne    ffff80000010100e <consoleintr+0x9f>
      }
      break;
ffff80000010109b:	e9 5f 01 00 00       	jmp    ffff8000001011ff <consoleintr+0x290>
    case C('H'): case '\x7f':  // Backspace
      if (input.e != input.w) {
ffff8000001010a0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010a7:	80 ff ff 
ffff8000001010aa:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001010b0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010b7:	80 ff ff 
ffff8000001010ba:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff8000001010c0:	39 c2                	cmp    %eax,%edx
ffff8000001010c2:	0f 84 3a 01 00 00    	je     ffff800000101202 <consoleintr+0x293>
        input.e--;
ffff8000001010c8:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010cf:	80 ff ff 
ffff8000001010d2:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001010d8:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001010db:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001010e2:	80 ff ff 
ffff8000001010e5:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff8000001010eb:	bf 00 01 00 00       	mov    $0x100,%edi
ffff8000001010f0:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff8000001010f7:	80 ff ff 
ffff8000001010fa:	ff d0                	call   *%rax
      }
      break;
ffff8000001010fc:	e9 01 01 00 00       	jmp    ffff800000101202 <consoleintr+0x293>
    default:
      if (c != 0 && input.e-input.r < INPUT_BUF) {
ffff800000101101:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101105:	0f 84 fa 00 00 00    	je     ffff800000101205 <consoleintr+0x296>
ffff80000010110b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101112:	80 ff ff 
ffff800000101115:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff80000010111b:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101122:	80 ff ff 
ffff800000101125:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010112b:	29 c2                	sub    %eax,%edx
ffff80000010112d:	83 fa 7f             	cmp    $0x7f,%edx
ffff800000101130:	0f 87 cf 00 00 00    	ja     ffff800000101205 <consoleintr+0x296>
        c = (c == '\r') ? '\n' : c;
ffff800000101136:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffff80000010113a:	75 07                	jne    ffff800000101143 <consoleintr+0x1d4>
ffff80000010113c:	c7 45 fc 0a 00 00 00 	movl   $0xa,-0x4(%rbp)
        input.buf[input.e++ % INPUT_BUF] = c;
ffff800000101143:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010114a:	80 ff ff 
ffff80000010114d:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101153:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101156:	48 b9 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rcx
ffff80000010115d:	80 ff ff 
ffff800000101160:	89 91 f0 00 00 00    	mov    %edx,0xf0(%rcx)
ffff800000101166:	83 e0 7f             	and    $0x7f,%eax
ffff800000101169:	89 c2                	mov    %eax,%edx
ffff80000010116b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010116e:	89 c1                	mov    %eax,%ecx
ffff800000101170:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101177:	80 ff ff 
ffff80000010117a:	89 d2                	mov    %edx,%edx
ffff80000010117c:	88 4c 10 68          	mov    %cl,0x68(%rax,%rdx,1)
        consputc(c);
ffff800000101180:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101183:	89 c7                	mov    %eax,%edi
ffff800000101185:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff80000010118c:	80 ff ff 
ffff80000010118f:	ff d0                	call   *%rax
        if (c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF) {
ffff800000101191:	83 7d fc 0a          	cmpl   $0xa,-0x4(%rbp)
ffff800000101195:	74 2d                	je     ffff8000001011c4 <consoleintr+0x255>
ffff800000101197:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff80000010119b:	74 27                	je     ffff8000001011c4 <consoleintr+0x255>
ffff80000010119d:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011a4:	80 ff ff 
ffff8000001011a7:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001011ad:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011b4:	80 ff ff 
ffff8000001011b7:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001011bd:	83 e8 80             	sub    $0xffffff80,%eax
ffff8000001011c0:	39 c2                	cmp    %eax,%edx
ffff8000001011c2:	75 41                	jne    ffff800000101205 <consoleintr+0x296>
          input.w = input.e;
ffff8000001011c4:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001011cb:	80 ff ff 
ffff8000001011ce:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001011d4:	48 ba c0 33 11 00 00 	movabs $0xffff8000001133c0,%rdx
ffff8000001011db:	80 ff ff 
ffff8000001011de:	89 82 ec 00 00 00    	mov    %eax,0xec(%rdx)
          wakeup(&input.r);
ffff8000001011e4:	48 b8 a8 34 11 00 00 	movabs $0xffff8000001134a8,%rax
ffff8000001011eb:	80 ff ff 
ffff8000001011ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001011f1:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff8000001011f8:	80 ff ff 
ffff8000001011fb:	ff d0                	call   *%rax
        }
      }
      break;
ffff8000001011fd:	eb 06                	jmp    ffff800000101205 <consoleintr+0x296>
      break;
ffff8000001011ff:	90                   	nop
ffff800000101200:	eb 04                	jmp    ffff800000101206 <consoleintr+0x297>
      break;
ffff800000101202:	90                   	nop
ffff800000101203:	eb 01                	jmp    ffff800000101206 <consoleintr+0x297>
      break;
ffff800000101205:	90                   	nop
  while((c = getc()) >= 0){
ffff800000101206:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010120a:	ff d0                	call   *%rax
ffff80000010120c:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010120f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101213:	0f 89 80 fd ff ff    	jns    ffff800000100f99 <consoleintr+0x2a>
    }
  }
  release(&input.lock);
ffff800000101219:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101220:	80 ff ff 
ffff800000101223:	48 89 c7             	mov    %rax,%rdi
ffff800000101226:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010122d:	80 ff ff 
ffff800000101230:	ff d0                	call   *%rax
}
ffff800000101232:	90                   	nop
ffff800000101233:	c9                   	leave
ffff800000101234:	c3                   	ret

ffff800000101235 <consoleread>:

  int
consoleread(struct inode *ip, uint off, char *dst, int n)
{
ffff800000101235:	55                   	push   %rbp
ffff800000101236:	48 89 e5             	mov    %rsp,%rbp
ffff800000101239:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010123d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101241:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000101244:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101248:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint target;
  int c;

  iunlock(ip);
ffff80000010124b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010124f:	48 89 c7             	mov    %rax,%rdi
ffff800000101252:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101259:	80 ff ff 
ffff80000010125c:	ff d0                	call   *%rax
  target = n;
ffff80000010125e:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101261:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffff800000101264:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010126b:	80 ff ff 
ffff80000010126e:	48 89 c7             	mov    %rax,%rdi
ffff800000101271:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000101278:	80 ff ff 
ffff80000010127b:	ff d0                	call   *%rax
  while(n > 0){
ffff80000010127d:	e9 23 01 00 00       	jmp    ffff8000001013a5 <consoleread+0x170>
    while(input.r == input.w){
      if (proc->killed) {
ffff800000101282:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101289:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010128d:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000101290:	85 c0                	test   %eax,%eax
ffff800000101292:	74 36                	je     ffff8000001012ca <consoleread+0x95>
        release(&input.lock);
ffff800000101294:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010129b:	80 ff ff 
ffff80000010129e:	48 89 c7             	mov    %rax,%rdi
ffff8000001012a1:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001012a8:	80 ff ff 
ffff8000001012ab:	ff d0                	call   *%rax
        ilock(ip);
ffff8000001012ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001012b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001012b4:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001012bb:	80 ff ff 
ffff8000001012be:	ff d0                	call   *%rax
        return -1;
ffff8000001012c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001012c5:	e9 21 01 00 00       	jmp    ffff8000001013eb <consoleread+0x1b6>
      }
      sleep(&input.r, &input.lock);
ffff8000001012ca:	48 ba c0 33 11 00 00 	movabs $0xffff8000001133c0,%rdx
ffff8000001012d1:	80 ff ff 
ffff8000001012d4:	48 b8 a8 34 11 00 00 	movabs $0xffff8000001134a8,%rax
ffff8000001012db:	80 ff ff 
ffff8000001012de:	48 89 d6             	mov    %rdx,%rsi
ffff8000001012e1:	48 89 c7             	mov    %rax,%rdi
ffff8000001012e4:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff8000001012eb:	80 ff ff 
ffff8000001012ee:	ff d0                	call   *%rax
    while(input.r == input.w){
ffff8000001012f0:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001012f7:	80 ff ff 
ffff8000001012fa:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000101300:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101307:	80 ff ff 
ffff80000010130a:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101310:	39 c2                	cmp    %eax,%edx
ffff800000101312:	0f 84 6a ff ff ff    	je     ffff800000101282 <consoleread+0x4d>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffff800000101318:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010131f:	80 ff ff 
ffff800000101322:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101328:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010132b:	48 b9 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rcx
ffff800000101332:	80 ff ff 
ffff800000101335:	89 91 e8 00 00 00    	mov    %edx,0xe8(%rcx)
ffff80000010133b:	83 e0 7f             	and    $0x7f,%eax
ffff80000010133e:	89 c2                	mov    %eax,%edx
ffff800000101340:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff800000101347:	80 ff ff 
ffff80000010134a:	89 d2                	mov    %edx,%edx
ffff80000010134c:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
ffff800000101351:	0f be c0             	movsbl %al,%eax
ffff800000101354:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if (c == C('D')) {  // EOF
ffff800000101357:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffff80000010135b:	75 2d                	jne    ffff80000010138a <consoleread+0x155>
      if (n < target) {
ffff80000010135d:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101360:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffff800000101363:	73 4c                	jae    ffff8000001013b1 <consoleread+0x17c>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
ffff800000101365:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010136c:	80 ff ff 
ffff80000010136f:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101375:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101378:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff80000010137f:	80 ff ff 
ffff800000101382:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
      }
      break;
ffff800000101388:	eb 27                	jmp    ffff8000001013b1 <consoleread+0x17c>
    }
    *dst++ = c;
ffff80000010138a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010138e:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000101392:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101396:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000101399:	88 10                	mov    %dl,(%rax)
    --n;
ffff80000010139b:	83 6d e0 01          	subl   $0x1,-0x20(%rbp)
    if (c == '\n')
ffff80000010139f:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffff8000001013a3:	74 0f                	je     ffff8000001013b4 <consoleread+0x17f>
  while(n > 0){
ffff8000001013a5:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
ffff8000001013a9:	0f 8f 41 ff ff ff    	jg     ffff8000001012f0 <consoleread+0xbb>
ffff8000001013af:	eb 04                	jmp    ffff8000001013b5 <consoleread+0x180>
      break;
ffff8000001013b1:	90                   	nop
ffff8000001013b2:	eb 01                	jmp    ffff8000001013b5 <consoleread+0x180>
      break;
ffff8000001013b4:	90                   	nop
  }
  release(&input.lock);
ffff8000001013b5:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001013bc:	80 ff ff 
ffff8000001013bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001013c2:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001013c9:	80 ff ff 
ffff8000001013cc:	ff d0                	call   *%rax
  ilock(ip);
ffff8000001013ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001013d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001013d5:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001013dc:	80 ff ff 
ffff8000001013df:	ff d0                	call   *%rax

  return target - n;
ffff8000001013e1:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001013e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001013e7:	29 c2                	sub    %eax,%edx
ffff8000001013e9:	89 d0                	mov    %edx,%eax
}
ffff8000001013eb:	c9                   	leave
ffff8000001013ec:	c3                   	ret

ffff8000001013ed <consolewrite>:

  int
consolewrite(struct inode *ip, uint off, char *buf, int n)
{
ffff8000001013ed:	55                   	push   %rbp
ffff8000001013ee:	48 89 e5             	mov    %rsp,%rbp
ffff8000001013f1:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001013f5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001013f9:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff8000001013fc:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101400:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  int i;

  iunlock(ip);
ffff800000101403:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101407:	48 89 c7             	mov    %rax,%rdi
ffff80000010140a:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101411:	80 ff ff 
ffff800000101414:	ff d0                	call   *%rax
  acquire(&cons.lock);
ffff800000101416:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff80000010141d:	80 ff ff 
ffff800000101420:	48 89 c7             	mov    %rax,%rdi
ffff800000101423:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010142a:	80 ff ff 
ffff80000010142d:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff80000010142f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000101436:	eb 28                	jmp    ffff800000101460 <consolewrite+0x73>
    consputc(buf[i] & 0xff);
ffff800000101438:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010143b:	48 63 d0             	movslq %eax,%rdx
ffff80000010143e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101442:	48 01 d0             	add    %rdx,%rax
ffff800000101445:	0f b6 00             	movzbl (%rax),%eax
ffff800000101448:	0f be c0             	movsbl %al,%eax
ffff80000010144b:	0f b6 c0             	movzbl %al,%eax
ffff80000010144e:	89 c7                	mov    %eax,%edi
ffff800000101450:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000101457:	80 ff ff 
ffff80000010145a:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff80000010145c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000101460:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101463:	3b 45 e0             	cmp    -0x20(%rbp),%eax
ffff800000101466:	7c d0                	jl     ffff800000101438 <consolewrite+0x4b>
  release(&cons.lock);
ffff800000101468:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff80000010146f:	80 ff ff 
ffff800000101472:	48 89 c7             	mov    %rax,%rdi
ffff800000101475:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010147c:	80 ff ff 
ffff80000010147f:	ff d0                	call   *%rax
  ilock(ip);
ffff800000101481:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101485:	48 89 c7             	mov    %rax,%rdi
ffff800000101488:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010148f:	80 ff ff 
ffff800000101492:	ff d0                	call   *%rax

  return n;
ffff800000101494:	8b 45 e0             	mov    -0x20(%rbp),%eax
}
ffff800000101497:	c9                   	leave
ffff800000101498:	c3                   	ret

ffff800000101499 <consoleinit>:

  void
consoleinit(void)
{
ffff800000101499:	55                   	push   %rbp
ffff80000010149a:	48 89 e5             	mov    %rsp,%rbp
  initlock(&cons.lock, "console");
ffff80000010149d:	48 ba 23 c8 10 00 00 	movabs $0xffff80000010c823,%rdx
ffff8000001014a4:	80 ff ff 
ffff8000001014a7:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001014ae:	80 ff ff 
ffff8000001014b1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001014b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001014b7:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff8000001014be:	80 ff ff 
ffff8000001014c1:	ff d0                	call   *%rax
  initlock(&input.lock, "input");
ffff8000001014c3:	48 ba 2b c8 10 00 00 	movabs $0xffff80000010c82b,%rdx
ffff8000001014ca:	80 ff ff 
ffff8000001014cd:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001014d4:	80 ff ff 
ffff8000001014d7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001014da:	48 89 c7             	mov    %rax,%rdi
ffff8000001014dd:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff8000001014e4:	80 ff ff 
ffff8000001014e7:	ff d0                	call   *%rax

  devsw[CONSOLE].write = consolewrite;
ffff8000001014e9:	48 b8 40 35 11 00 00 	movabs $0xffff800000113540,%rax
ffff8000001014f0:	80 ff ff 
ffff8000001014f3:	48 b9 ed 13 10 00 00 	movabs $0xffff8000001013ed,%rcx
ffff8000001014fa:	80 ff ff 
ffff8000001014fd:	48 89 48 18          	mov    %rcx,0x18(%rax)
  devsw[CONSOLE].read = consoleread;
ffff800000101501:	48 b8 40 35 11 00 00 	movabs $0xffff800000113540,%rax
ffff800000101508:	80 ff ff 
ffff80000010150b:	48 b9 35 12 10 00 00 	movabs $0xffff800000101235,%rcx
ffff800000101512:	80 ff ff 
ffff800000101515:	48 89 48 10          	mov    %rcx,0x10(%rax)
  cons.locking = 1;
ffff800000101519:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff800000101520:	80 ff ff 
ffff800000101523:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)

  ioapicenable(IRQ_KBD, 0);
ffff80000010152a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010152f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000101534:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff80000010153b:	80 ff ff 
ffff80000010153e:	ff d0                	call   *%rax
}
ffff800000101540:	90                   	nop
ffff800000101541:	5d                   	pop    %rbp
ffff800000101542:	c3                   	ret

ffff800000101543 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
ffff800000101543:	55                   	push   %rbp
ffff800000101544:	48 89 e5             	mov    %rsp,%rbp
ffff800000101547:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffff80000010154e:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffff800000101555:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  oldpgdir = proc->pgdir;
ffff80000010155c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101563:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101567:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010156b:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

  begin_op();
ffff80000010156f:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000101576:	80 ff ff 
ffff800000101579:	ff d0                	call   *%rax

  if((ip = namei(path)) == 0){
ffff80000010157b:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff800000101582:	48 89 c7             	mov    %rax,%rdi
ffff800000101585:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff80000010158c:	80 ff ff 
ffff80000010158f:	ff d0                	call   *%rax
ffff800000101591:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff800000101595:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010159a:	75 16                	jne    ffff8000001015b2 <exec+0x6f>
    end_op();
ffff80000010159c:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001015a3:	80 ff ff 
ffff8000001015a6:	ff d0                	call   *%rax
    return -1;
ffff8000001015a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001015ad:	e9 69 05 00 00       	jmp    ffff800000101b1b <exec+0x5d8>
  }
  ilock(ip);
ffff8000001015b2:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001015b6:	48 89 c7             	mov    %rax,%rdi
ffff8000001015b9:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001015c0:	80 ff ff 
ffff8000001015c3:	ff d0                	call   *%rax
  pgdir = 0;
ffff8000001015c5:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffff8000001015cc:	00 

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
ffff8000001015cd:	48 8d b5 50 fe ff ff 	lea    -0x1b0(%rbp),%rsi
ffff8000001015d4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001015d8:	b9 40 00 00 00       	mov    $0x40,%ecx
ffff8000001015dd:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001015e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001015e5:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff8000001015ec:	80 ff ff 
ffff8000001015ef:	ff d0                	call   *%rax
ffff8000001015f1:	83 f8 40             	cmp    $0x40,%eax
ffff8000001015f4:	0f 85 b7 04 00 00    	jne    ffff800000101ab1 <exec+0x56e>
    goto bad;
  if(elf.magic != ELF_MAGIC)
ffff8000001015fa:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffff800000101600:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffff800000101605:	0f 85 a9 04 00 00    	jne    ffff800000101ab4 <exec+0x571>
    goto bad;

  if((pgdir = setupkvm()) == 0)
ffff80000010160b:	48 b8 a5 b8 10 00 00 	movabs $0xffff80000010b8a5,%rax
ffff800000101612:	80 ff ff 
ffff800000101615:	ff d0                	call   *%rax
ffff800000101617:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff80000010161b:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101620:	0f 84 91 04 00 00    	je     ffff800000101ab7 <exec+0x574>
    goto bad;

  // Load program into memory.
  sz = PGSIZE; // skip the first page
ffff800000101626:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
ffff80000010162d:	00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff80000010162e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff800000101635:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffff80000010163c:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff80000010163f:	e9 0f 01 00 00       	jmp    ffff800000101753 <exec+0x210>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
ffff800000101644:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000101647:	48 8d b5 10 fe ff ff 	lea    -0x1f0(%rbp),%rsi
ffff80000010164e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101652:	b9 38 00 00 00       	mov    $0x38,%ecx
ffff800000101657:	48 89 c7             	mov    %rax,%rdi
ffff80000010165a:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000101661:	80 ff ff 
ffff800000101664:	ff d0                	call   *%rax
ffff800000101666:	83 f8 38             	cmp    $0x38,%eax
ffff800000101669:	0f 85 4b 04 00 00    	jne    ffff800000101aba <exec+0x577>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
ffff80000010166f:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffff800000101675:	83 f8 01             	cmp    $0x1,%eax
ffff800000101678:	0f 85 c7 00 00 00    	jne    ffff800000101745 <exec+0x202>
      continue;
    if(ph.memsz < ph.filesz)
ffff80000010167e:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffff800000101685:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff80000010168c:	48 39 c2             	cmp    %rax,%rdx
ffff80000010168f:	0f 82 28 04 00 00    	jb     ffff800000101abd <exec+0x57a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
ffff800000101695:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff80000010169c:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001016a3:	48 01 c2             	add    %rax,%rdx
ffff8000001016a6:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff8000001016ad:	48 39 c2             	cmp    %rax,%rdx
ffff8000001016b0:	0f 82 0a 04 00 00    	jb     ffff800000101ac0 <exec+0x57d>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
ffff8000001016b6:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff8000001016bd:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001016c4:	48 01 c2             	add    %rax,%rdx
ffff8000001016c7:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001016cb:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001016cf:	48 89 ce             	mov    %rcx,%rsi
ffff8000001016d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001016d5:	48 b8 fc bf 10 00 00 	movabs $0xffff80000010bffc,%rax
ffff8000001016dc:	80 ff ff 
ffff8000001016df:	ff d0                	call   *%rax
ffff8000001016e1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001016e5:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001016ea:	0f 84 d3 03 00 00    	je     ffff800000101ac3 <exec+0x580>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
ffff8000001016f0:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff8000001016f7:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff8000001016fc:	48 85 c0             	test   %rax,%rax
ffff8000001016ff:	0f 85 c1 03 00 00    	jne    ffff800000101ac6 <exec+0x583>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
ffff800000101705:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff80000010170c:	89 c7                	mov    %eax,%edi
ffff80000010170e:	48 8b 85 18 fe ff ff 	mov    -0x1e8(%rbp),%rax
ffff800000101715:	89 c1                	mov    %eax,%ecx
ffff800000101717:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff80000010171e:	48 89 c6             	mov    %rax,%rsi
ffff800000101721:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffff800000101725:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101729:	41 89 f8             	mov    %edi,%r8d
ffff80000010172c:	48 89 c7             	mov    %rax,%rdi
ffff80000010172f:	48 b8 d4 be 10 00 00 	movabs $0xffff80000010bed4,%rax
ffff800000101736:	80 ff ff 
ffff800000101739:	ff d0                	call   *%rax
ffff80000010173b:	85 c0                	test   %eax,%eax
ffff80000010173d:	0f 88 86 03 00 00    	js     ffff800000101ac9 <exec+0x586>
ffff800000101743:	eb 01                	jmp    ffff800000101746 <exec+0x203>
      continue;
ffff800000101745:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff800000101746:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff80000010174a:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010174d:	83 c0 38             	add    $0x38,%eax
ffff800000101750:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff800000101753:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffff80000010175a:	0f b7 c0             	movzwl %ax,%eax
ffff80000010175d:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000101760:	0f 8c de fe ff ff    	jl     ffff800000101644 <exec+0x101>
      goto bad;
  }
  iunlockput(ip);
ffff800000101766:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010176a:	48 89 c7             	mov    %rax,%rdi
ffff80000010176d:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000101774:	80 ff ff 
ffff800000101777:	ff d0                	call   *%rax
  end_op();
ffff800000101779:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000101780:	80 ff ff 
ffff800000101783:	ff d0                	call   *%rax
  ip = 0;
ffff800000101785:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffff80000010178c:	00 

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
ffff80000010178d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101791:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000101797:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010179d:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
ffff8000001017a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001017a5:	48 8d 90 00 20 00 00 	lea    0x2000(%rax),%rdx
ffff8000001017ac:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001017b0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001017b4:	48 89 ce             	mov    %rcx,%rsi
ffff8000001017b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001017ba:	48 b8 fc bf 10 00 00 	movabs $0xffff80000010bffc,%rax
ffff8000001017c1:	80 ff ff 
ffff8000001017c4:	ff d0                	call   *%rax
ffff8000001017c6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001017ca:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001017cf:	0f 84 f7 02 00 00    	je     ffff800000101acc <exec+0x589>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
ffff8000001017d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001017d9:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffff8000001017df:	48 89 c2             	mov    %rax,%rdx
ffff8000001017e2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001017e6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001017e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001017ec:	48 b8 70 c4 10 00 00 	movabs $0xffff80000010c470,%rax
ffff8000001017f3:	80 ff ff 
ffff8000001017f6:	ff d0                	call   *%rax
  sp = sz;
ffff8000001017f8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001017fc:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
ffff800000101800:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff800000101807:	00 
ffff800000101808:	e9 c9 00 00 00       	jmp    ffff8000001018d6 <exec+0x393>
    if(argc >= MAXARG)
ffff80000010180d:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffff800000101812:	0f 87 b7 02 00 00    	ja     ffff800000101acf <exec+0x58c>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~(sizeof(addr_t)-1);
ffff800000101818:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010181c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101823:	00 
ffff800000101824:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff80000010182b:	48 01 d0             	add    %rdx,%rax
ffff80000010182e:	48 8b 00             	mov    (%rax),%rax
ffff800000101831:	48 89 c7             	mov    %rax,%rdi
ffff800000101834:	48 b8 94 7d 10 00 00 	movabs $0xffff800000107d94,%rax
ffff80000010183b:	80 ff ff 
ffff80000010183e:	ff d0                	call   *%rax
ffff800000101840:	83 c0 01             	add    $0x1,%eax
ffff800000101843:	48 98                	cltq
ffff800000101845:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101849:	48 29 c2             	sub    %rax,%rdx
ffff80000010184c:	48 89 d0             	mov    %rdx,%rax
ffff80000010184f:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff800000101853:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
ffff800000101857:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010185b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101862:	00 
ffff800000101863:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff80000010186a:	48 01 d0             	add    %rdx,%rax
ffff80000010186d:	48 8b 00             	mov    (%rax),%rax
ffff800000101870:	48 89 c7             	mov    %rax,%rdi
ffff800000101873:	48 b8 94 7d 10 00 00 	movabs $0xffff800000107d94,%rax
ffff80000010187a:	80 ff ff 
ffff80000010187d:	ff d0                	call   *%rax
ffff80000010187f:	83 c0 01             	add    $0x1,%eax
ffff800000101882:	48 63 c8             	movslq %eax,%rcx
ffff800000101885:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101889:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101890:	00 
ffff800000101891:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101898:	48 01 d0             	add    %rdx,%rax
ffff80000010189b:	48 8b 10             	mov    (%rax),%rdx
ffff80000010189e:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff8000001018a2:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001018a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001018a9:	48 b8 e2 c6 10 00 00 	movabs $0xffff80000010c6e2,%rax
ffff8000001018b0:	80 ff ff 
ffff8000001018b3:	ff d0                	call   *%rax
ffff8000001018b5:	85 c0                	test   %eax,%eax
ffff8000001018b7:	0f 88 15 02 00 00    	js     ffff800000101ad2 <exec+0x58f>
      goto bad;
    ustack[1+argc] = sp;
ffff8000001018bd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018c1:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001018c5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001018c9:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffff8000001018d0:	ff 
  for(argc = 0; argv[argc]; argc++) {
ffff8000001018d1:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffff8000001018d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018da:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001018e1:	00 
ffff8000001018e2:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff8000001018e9:	48 01 d0             	add    %rdx,%rax
ffff8000001018ec:	48 8b 00             	mov    (%rax),%rax
ffff8000001018ef:	48 85 c0             	test   %rax,%rax
ffff8000001018f2:	0f 85 15 ff ff ff    	jne    ffff80000010180d <exec+0x2ca>
  }
  ustack[1+argc] = 0;
ffff8000001018f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001018fc:	48 83 c0 01          	add    $0x1,%rax
ffff800000101900:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffff800000101907:	ff 00 00 00 00 

  ustack[0] = 0xffffffffffffffff;  // fake return PC
ffff80000010190c:	48 c7 85 90 fe ff ff 	movq   $0xffffffffffffffff,-0x170(%rbp)
ffff800000101913:	ff ff ff ff 

	// argc and argv for main() entry point
  proc->tf->rdi = argc;
ffff800000101917:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010191e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101922:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101926:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010192a:	48 89 50 30          	mov    %rdx,0x30(%rax)
  proc->tf->rsi = sp - (argc+1)*sizeof(addr_t);
ffff80000010192e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101932:	48 83 c0 01          	add    $0x1,%rax
ffff800000101936:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff80000010193d:	00 
ffff80000010193e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101945:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101949:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010194d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101951:	48 29 ca             	sub    %rcx,%rdx
ffff800000101954:	48 89 50 28          	mov    %rdx,0x28(%rax)

  sp -= (1+argc+1) * sizeof(addr_t);
ffff800000101958:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010195c:	48 83 c0 02          	add    $0x2,%rax
ffff800000101960:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000101964:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  if(copyout(pgdir, sp, ustack, (1+argc+1)*sizeof(addr_t)) < 0)
ffff800000101968:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010196c:	48 83 c0 02          	add    $0x2,%rax
ffff800000101970:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff800000101977:	00 
ffff800000101978:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffff80000010197f:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff800000101983:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101987:	48 89 c7             	mov    %rax,%rdi
ffff80000010198a:	48 b8 e2 c6 10 00 00 	movabs $0xffff80000010c6e2,%rax
ffff800000101991:	80 ff ff 
ffff800000101994:	ff d0                	call   *%rax
ffff800000101996:	85 c0                	test   %eax,%eax
ffff800000101998:	0f 88 37 01 00 00    	js     ffff800000101ad5 <exec+0x592>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
ffff80000010199e:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff8000001019a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001019a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019ad:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001019b1:	eb 1c                	jmp    ffff8000001019cf <exec+0x48c>
    if(*s == '/')
ffff8000001019b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019b7:	0f b6 00             	movzbl (%rax),%eax
ffff8000001019ba:	3c 2f                	cmp    $0x2f,%al
ffff8000001019bc:	75 0c                	jne    ffff8000001019ca <exec+0x487>
      last = s+1;
ffff8000001019be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019c2:	48 83 c0 01          	add    $0x1,%rax
ffff8000001019c6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(last=s=path; *s; s++)
ffff8000001019ca:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff8000001019cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001019d3:	0f b6 00             	movzbl (%rax),%eax
ffff8000001019d6:	84 c0                	test   %al,%al
ffff8000001019d8:	75 d9                	jne    ffff8000001019b3 <exec+0x470>
  safestrcpy(proc->name, last, sizeof(proc->name));
ffff8000001019da:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001019e1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001019e5:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001019ec:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001019f0:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001019f5:	48 89 c6             	mov    %rax,%rsi
ffff8000001019f8:	48 89 cf             	mov    %rcx,%rdi
ffff8000001019fb:	48 b8 31 7d 10 00 00 	movabs $0xffff800000107d31,%rax
ffff800000101a02:	80 ff ff 
ffff800000101a05:	ff d0                	call   *%rax

  // Commit to the user image.
  proc->pgdir = pgdir;
ffff800000101a07:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a0e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a12:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffff800000101a16:	48 89 50 08          	mov    %rdx,0x8(%rax)
  proc->sz = sz;
ffff800000101a1a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a21:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a25:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000101a29:	48 89 10             	mov    %rdx,(%rax)
  proc->tf->rip = elf.entry;  // main
ffff800000101a2c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a33:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a37:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a3b:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101a42:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  proc->tf->rcx = elf.entry;
ffff800000101a49:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a50:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a54:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a58:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101a5f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  proc->tf->rsp = sp;
ffff800000101a63:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a6a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a6e:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a72:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101a76:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  switchuvm(proc);
ffff800000101a7d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a84:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a88:	48 89 c7             	mov    %rax,%rdi
ffff800000101a8b:	48 b8 03 ba 10 00 00 	movabs $0xffff80000010ba03,%rax
ffff800000101a92:	80 ff ff 
ffff800000101a95:	ff d0                	call   *%rax
  freevm(oldpgdir);
ffff800000101a97:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101a9b:	48 89 c7             	mov    %rax,%rdi
ffff800000101a9e:	48 b8 39 c2 10 00 00 	movabs $0xffff80000010c239,%rax
ffff800000101aa5:	80 ff ff 
ffff800000101aa8:	ff d0                	call   *%rax
  return 0;
ffff800000101aaa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101aaf:	eb 6a                	jmp    ffff800000101b1b <exec+0x5d8>
    goto bad;
ffff800000101ab1:	90                   	nop
ffff800000101ab2:	eb 22                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101ab4:	90                   	nop
ffff800000101ab5:	eb 1f                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101ab7:	90                   	nop
ffff800000101ab8:	eb 1c                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101aba:	90                   	nop
ffff800000101abb:	eb 19                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101abd:	90                   	nop
ffff800000101abe:	eb 16                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac0:	90                   	nop
ffff800000101ac1:	eb 13                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac3:	90                   	nop
ffff800000101ac4:	eb 10                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac6:	90                   	nop
ffff800000101ac7:	eb 0d                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ac9:	90                   	nop
ffff800000101aca:	eb 0a                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101acc:	90                   	nop
ffff800000101acd:	eb 07                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101acf:	90                   	nop
ffff800000101ad0:	eb 04                	jmp    ffff800000101ad6 <exec+0x593>
      goto bad;
ffff800000101ad2:	90                   	nop
ffff800000101ad3:	eb 01                	jmp    ffff800000101ad6 <exec+0x593>
    goto bad;
ffff800000101ad5:	90                   	nop

 bad:
  if(pgdir)
ffff800000101ad6:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101adb:	74 13                	je     ffff800000101af0 <exec+0x5ad>
    freevm(pgdir);
ffff800000101add:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101ae1:	48 89 c7             	mov    %rax,%rdi
ffff800000101ae4:	48 b8 39 c2 10 00 00 	movabs $0xffff80000010c239,%rax
ffff800000101aeb:	80 ff ff 
ffff800000101aee:	ff d0                	call   *%rax
  if(ip){
ffff800000101af0:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000101af5:	74 1f                	je     ffff800000101b16 <exec+0x5d3>
    iunlockput(ip);
ffff800000101af7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101afb:	48 89 c7             	mov    %rax,%rdi
ffff800000101afe:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000101b05:	80 ff ff 
ffff800000101b08:	ff d0                	call   *%rax
    end_op();
ffff800000101b0a:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000101b11:	80 ff ff 
ffff800000101b14:	ff d0                	call   *%rax
  }
  return -1;
ffff800000101b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101b1b:	c9                   	leave
ffff800000101b1c:	c3                   	ret

ffff800000101b1d <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
ffff800000101b1d:	55                   	push   %rbp
ffff800000101b1e:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ftable.lock, "ftable");
ffff800000101b21:	48 ba 31 c8 10 00 00 	movabs $0xffff80000010c831,%rdx
ffff800000101b28:	80 ff ff 
ffff800000101b2b:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b32:	80 ff ff 
ffff800000101b35:	48 89 d6             	mov    %rdx,%rsi
ffff800000101b38:	48 89 c7             	mov    %rax,%rdi
ffff800000101b3b:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000101b42:	80 ff ff 
ffff800000101b45:	ff d0                	call   *%rax
}
ffff800000101b47:	90                   	nop
ffff800000101b48:	5d                   	pop    %rbp
ffff800000101b49:	c3                   	ret

ffff800000101b4a <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
ffff800000101b4a:	55                   	push   %rbp
ffff800000101b4b:	48 89 e5             	mov    %rsp,%rbp
ffff800000101b4e:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;

  acquire(&ftable.lock);
ffff800000101b52:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b59:	80 ff ff 
ffff800000101b5c:	48 89 c7             	mov    %rax,%rdi
ffff800000101b5f:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000101b66:	80 ff ff 
ffff800000101b69:	ff d0                	call   *%rax
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101b6b:	48 b8 48 36 11 00 00 	movabs $0xffff800000113648,%rax
ffff800000101b72:	80 ff ff 
ffff800000101b75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101b79:	eb 3a                	jmp    ffff800000101bb5 <filealloc+0x6b>
    if(f->ref == 0){
ffff800000101b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101b7f:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101b82:	85 c0                	test   %eax,%eax
ffff800000101b84:	75 2a                	jne    ffff800000101bb0 <filealloc+0x66>
      f->ref = 1;
ffff800000101b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101b8a:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      release(&ftable.lock);
ffff800000101b91:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b98:	80 ff ff 
ffff800000101b9b:	48 89 c7             	mov    %rax,%rdi
ffff800000101b9e:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000101ba5:	80 ff ff 
ffff800000101ba8:	ff d0                	call   *%rax
      return f;
ffff800000101baa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101bae:	eb 33                	jmp    ffff800000101be3 <filealloc+0x99>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101bb0:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000101bb5:	48 b8 e8 45 11 00 00 	movabs $0xffff8000001145e8,%rax
ffff800000101bbc:	80 ff ff 
ffff800000101bbf:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000101bc3:	72 b6                	jb     ffff800000101b7b <filealloc+0x31>
    }
  }
  release(&ftable.lock);
ffff800000101bc5:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101bcc:	80 ff ff 
ffff800000101bcf:	48 89 c7             	mov    %rax,%rdi
ffff800000101bd2:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000101bd9:	80 ff ff 
ffff800000101bdc:	ff d0                	call   *%rax
  return 0;
ffff800000101bde:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000101be3:	c9                   	leave
ffff800000101be4:	c3                   	ret

ffff800000101be5 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffff800000101be5:	55                   	push   %rbp
ffff800000101be6:	48 89 e5             	mov    %rsp,%rbp
ffff800000101be9:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101bed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffff800000101bf1:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101bf8:	80 ff ff 
ffff800000101bfb:	48 89 c7             	mov    %rax,%rdi
ffff800000101bfe:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000101c05:	80 ff ff 
ffff800000101c08:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c0e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c11:	85 c0                	test   %eax,%eax
ffff800000101c13:	7f 19                	jg     ffff800000101c2e <filedup+0x49>
    panic("filedup");
ffff800000101c15:	48 b8 38 c8 10 00 00 	movabs $0xffff80000010c838,%rax
ffff800000101c1c:	80 ff ff 
ffff800000101c1f:	48 89 c7             	mov    %rax,%rdi
ffff800000101c22:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101c29:	80 ff ff 
ffff800000101c2c:	ff d0                	call   *%rax
  f->ref++;
ffff800000101c2e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c32:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c35:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c3c:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffff800000101c3f:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c46:	80 ff ff 
ffff800000101c49:	48 89 c7             	mov    %rax,%rdi
ffff800000101c4c:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000101c53:	80 ff ff 
ffff800000101c56:	ff d0                	call   *%rax
  return f;
ffff800000101c58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000101c5c:	c9                   	leave
ffff800000101c5d:	c3                   	ret

ffff800000101c5e <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffff800000101c5e:	55                   	push   %rbp
ffff800000101c5f:	48 89 e5             	mov    %rsp,%rbp
ffff800000101c62:	53                   	push   %rbx
ffff800000101c63:	48 83 ec 48          	sub    $0x48,%rsp
ffff800000101c67:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffff800000101c6b:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101c72:	80 ff ff 
ffff800000101c75:	48 89 c7             	mov    %rax,%rdi
ffff800000101c78:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000101c7f:	80 ff ff 
ffff800000101c82:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c84:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101c88:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c8b:	85 c0                	test   %eax,%eax
ffff800000101c8d:	7f 19                	jg     ffff800000101ca8 <fileclose+0x4a>
    panic("fileclose");
ffff800000101c8f:	48 b8 40 c8 10 00 00 	movabs $0xffff80000010c840,%rax
ffff800000101c96:	80 ff ff 
ffff800000101c99:	48 89 c7             	mov    %rax,%rdi
ffff800000101c9c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101ca3:	80 ff ff 
ffff800000101ca6:	ff d0                	call   *%rax
  if(--f->ref > 0){
ffff800000101ca8:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101cac:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101caf:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101cb2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101cb6:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101cb9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101cbd:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101cc0:	85 c0                	test   %eax,%eax
ffff800000101cc2:	7e 1e                	jle    ffff800000101ce2 <fileclose+0x84>
    release(&ftable.lock);
ffff800000101cc4:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101ccb:	80 ff ff 
ffff800000101cce:	48 89 c7             	mov    %rax,%rdi
ffff800000101cd1:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000101cd8:	80 ff ff 
ffff800000101cdb:	ff d0                	call   *%rax
ffff800000101cdd:	e9 b2 00 00 00       	jmp    ffff800000101d94 <fileclose+0x136>
    return;
  }
  ff = *f;
ffff800000101ce2:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101ce6:	48 8b 08             	mov    (%rax),%rcx
ffff800000101ce9:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffff800000101ced:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff800000101cf1:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff800000101cf5:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffff800000101cf9:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffff800000101cfd:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff800000101d01:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff800000101d05:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000101d09:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  f->ref = 0;
ffff800000101d0d:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d11:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffff800000101d18:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101d1c:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  release(&ftable.lock);
ffff800000101d22:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101d29:	80 ff ff 
ffff800000101d2c:	48 89 c7             	mov    %rax,%rdi
ffff800000101d2f:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000101d36:	80 ff ff 
ffff800000101d39:	ff d0                	call   *%rax

  if(ff.type == FD_PIPE)
ffff800000101d3b:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101d3e:	83 f8 01             	cmp    $0x1,%eax
ffff800000101d41:	75 1e                	jne    ffff800000101d61 <fileclose+0x103>
    pipeclose(ff.pipe, ff.writable);
ffff800000101d43:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffff800000101d47:	0f be d0             	movsbl %al,%edx
ffff800000101d4a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101d4e:	89 d6                	mov    %edx,%esi
ffff800000101d50:	48 89 c7             	mov    %rax,%rdi
ffff800000101d53:	48 b8 03 5e 10 00 00 	movabs $0xffff800000105e03,%rax
ffff800000101d5a:	80 ff ff 
ffff800000101d5d:	ff d0                	call   *%rax
ffff800000101d5f:	eb 33                	jmp    ffff800000101d94 <fileclose+0x136>
  else if(ff.type == FD_INODE){
ffff800000101d61:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101d64:	83 f8 02             	cmp    $0x2,%eax
ffff800000101d67:	75 2b                	jne    ffff800000101d94 <fileclose+0x136>
    begin_op();
ffff800000101d69:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000101d70:	80 ff ff 
ffff800000101d73:	ff d0                	call   *%rax
    iput(ff.ip);
ffff800000101d75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101d79:	48 89 c7             	mov    %rax,%rdi
ffff800000101d7c:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000101d83:	80 ff ff 
ffff800000101d86:	ff d0                	call   *%rax
    end_op();
ffff800000101d88:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000101d8f:	80 ff ff 
ffff800000101d92:	ff d0                	call   *%rax
  }
}
ffff800000101d94:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000101d98:	c9                   	leave
ffff800000101d99:	c3                   	ret

ffff800000101d9a <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffff800000101d9a:	55                   	push   %rbp
ffff800000101d9b:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d9e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101da2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101da6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffff800000101daa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101dae:	8b 00                	mov    (%rax),%eax
ffff800000101db0:	83 f8 02             	cmp    $0x2,%eax
ffff800000101db3:	75 53                	jne    ffff800000101e08 <filestat+0x6e>
    ilock(f->ip);
ffff800000101db5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101db9:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101dbd:	48 89 c7             	mov    %rax,%rdi
ffff800000101dc0:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000101dc7:	80 ff ff 
ffff800000101dca:	ff d0                	call   *%rax
    stati(f->ip, st);
ffff800000101dcc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101dd0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101dd4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000101dd8:	48 89 d6             	mov    %rdx,%rsi
ffff800000101ddb:	48 89 c7             	mov    %rax,%rdi
ffff800000101dde:	48 b8 8f 2e 10 00 00 	movabs $0xffff800000102e8f,%rax
ffff800000101de5:	80 ff ff 
ffff800000101de8:	ff d0                	call   *%rax
    iunlock(f->ip);
ffff800000101dea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101dee:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101df2:	48 89 c7             	mov    %rax,%rdi
ffff800000101df5:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101dfc:	80 ff ff 
ffff800000101dff:	ff d0                	call   *%rax
    return 0;
ffff800000101e01:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101e06:	eb 05                	jmp    ffff800000101e0d <filestat+0x73>
  }
  return -1;
ffff800000101e08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101e0d:	c9                   	leave
ffff800000101e0e:	c3                   	ret

ffff800000101e0f <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffff800000101e0f:	55                   	push   %rbp
ffff800000101e10:	48 89 e5             	mov    %rsp,%rbp
ffff800000101e13:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101e17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101e1b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101e1f:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffff800000101e22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e26:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffff800000101e2a:	84 c0                	test   %al,%al
ffff800000101e2c:	75 0a                	jne    ffff800000101e38 <fileread+0x29>
    return -1;
ffff800000101e2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101e33:	e9 c9 00 00 00       	jmp    ffff800000101f01 <fileread+0xf2>
  if(f->type == FD_PIPE)
ffff800000101e38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e3c:	8b 00                	mov    (%rax),%eax
ffff800000101e3e:	83 f8 01             	cmp    $0x1,%eax
ffff800000101e41:	75 26                	jne    ffff800000101e69 <fileread+0x5a>
    return piperead(f->pipe, addr, n);
ffff800000101e43:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e47:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101e4b:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101e4e:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101e52:	48 89 ce             	mov    %rcx,%rsi
ffff800000101e55:	48 89 c7             	mov    %rax,%rdi
ffff800000101e58:	48 b8 16 60 10 00 00 	movabs $0xffff800000106016,%rax
ffff800000101e5f:	80 ff ff 
ffff800000101e62:	ff d0                	call   *%rax
ffff800000101e64:	e9 98 00 00 00       	jmp    ffff800000101f01 <fileread+0xf2>
  if(f->type == FD_INODE){
ffff800000101e69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e6d:	8b 00                	mov    (%rax),%eax
ffff800000101e6f:	83 f8 02             	cmp    $0x2,%eax
ffff800000101e72:	75 74                	jne    ffff800000101ee8 <fileread+0xd9>
    ilock(f->ip);
ffff800000101e74:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e78:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e7c:	48 89 c7             	mov    %rax,%rdi
ffff800000101e7f:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000101e86:	80 ff ff 
ffff800000101e89:	ff d0                	call   *%rax
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffff800000101e8b:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffff800000101e8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e92:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101e95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101e99:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101e9d:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffff800000101ea1:	48 89 c7             	mov    %rax,%rdi
ffff800000101ea4:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000101eab:	80 ff ff 
ffff800000101eae:	ff d0                	call   *%rax
ffff800000101eb0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101eb3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101eb7:	7e 13                	jle    ffff800000101ecc <fileread+0xbd>
      f->off += r;
ffff800000101eb9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ebd:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101ec0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101ec3:	01 c2                	add    %eax,%edx
ffff800000101ec5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ec9:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffff800000101ecc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ed0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ed4:	48 89 c7             	mov    %rax,%rdi
ffff800000101ed7:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000101ede:	80 ff ff 
ffff800000101ee1:	ff d0                	call   *%rax
    return r;
ffff800000101ee3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101ee6:	eb 19                	jmp    ffff800000101f01 <fileread+0xf2>
  }
  panic("fileread");
ffff800000101ee8:	48 b8 4a c8 10 00 00 	movabs $0xffff80000010c84a,%rax
ffff800000101eef:	80 ff ff 
ffff800000101ef2:	48 89 c7             	mov    %rax,%rdi
ffff800000101ef5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101efc:	80 ff ff 
ffff800000101eff:	ff d0                	call   *%rax
}
ffff800000101f01:	c9                   	leave
ffff800000101f02:	c3                   	ret

ffff800000101f03 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffff800000101f03:	55                   	push   %rbp
ffff800000101f04:	48 89 e5             	mov    %rsp,%rbp
ffff800000101f07:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101f0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101f0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101f13:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffff800000101f16:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f1a:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffff800000101f1e:	84 c0                	test   %al,%al
ffff800000101f20:	75 0a                	jne    ffff800000101f2c <filewrite+0x29>
    return -1;
ffff800000101f22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101f27:	e9 63 01 00 00       	jmp    ffff80000010208f <filewrite+0x18c>
  if(f->type == FD_PIPE)
ffff800000101f2c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f30:	8b 00                	mov    (%rax),%eax
ffff800000101f32:	83 f8 01             	cmp    $0x1,%eax
ffff800000101f35:	75 26                	jne    ffff800000101f5d <filewrite+0x5a>
    return pipewrite(f->pipe, addr, n);
ffff800000101f37:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f3b:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101f3f:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101f42:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101f46:	48 89 ce             	mov    %rcx,%rsi
ffff800000101f49:	48 89 c7             	mov    %rax,%rdi
ffff800000101f4c:	48 b8 d6 5e 10 00 00 	movabs $0xffff800000105ed6,%rax
ffff800000101f53:	80 ff ff 
ffff800000101f56:	ff d0                	call   *%rax
ffff800000101f58:	e9 32 01 00 00       	jmp    ffff80000010208f <filewrite+0x18c>
  if(f->type == FD_INODE){
ffff800000101f5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f61:	8b 00                	mov    (%rax),%eax
ffff800000101f63:	83 f8 02             	cmp    $0x2,%eax
ffff800000101f66:	0f 85 0a 01 00 00    	jne    ffff800000102076 <filewrite+0x173>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffff800000101f6c:	c7 45 f4 00 1a 00 00 	movl   $0x1a00,-0xc(%rbp)
    int i = 0;
ffff800000101f73:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffff800000101f7a:	e9 d4 00 00 00       	jmp    ffff800000102053 <filewrite+0x150>
      int n1 = n - i;
ffff800000101f7f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000101f82:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000101f85:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffff800000101f88:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000101f8b:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffff800000101f8e:	7e 06                	jle    ffff800000101f96 <filewrite+0x93>
        n1 = max;
ffff800000101f90:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000101f93:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_op();
ffff800000101f96:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000101f9d:	80 ff ff 
ffff800000101fa0:	ff d0                	call   *%rax
      ilock(f->ip);
ffff800000101fa2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fa6:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101faa:	48 89 c7             	mov    %rax,%rdi
ffff800000101fad:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000101fb4:	80 ff ff 
ffff800000101fb7:	ff d0                	call   *%rax
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffff800000101fb9:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffff800000101fbc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fc0:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fc3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101fc6:	48 63 f0             	movslq %eax,%rsi
ffff800000101fc9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101fcd:	48 01 c6             	add    %rax,%rsi
ffff800000101fd0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fd4:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fd8:	48 89 c7             	mov    %rax,%rdi
ffff800000101fdb:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff800000101fe2:	80 ff ff 
ffff800000101fe5:	ff d0                	call   *%rax
ffff800000101fe7:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000101fea:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000101fee:	7e 13                	jle    ffff800000102003 <filewrite+0x100>
        f->off += r;
ffff800000101ff0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ff4:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101ff7:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000101ffa:	01 c2                	add    %eax,%edx
ffff800000101ffc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102000:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffff800000102003:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102007:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff80000010200b:	48 89 c7             	mov    %rax,%rdi
ffff80000010200e:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000102015:	80 ff ff 
ffff800000102018:	ff d0                	call   *%rax
      end_op();
ffff80000010201a:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000102021:	80 ff ff 
ffff800000102024:	ff d0                	call   *%rax

      if(r < 0)
ffff800000102026:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff80000010202a:	78 35                	js     ffff800000102061 <filewrite+0x15e>
        break;
      if(r != n1)
ffff80000010202c:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010202f:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000102032:	74 19                	je     ffff80000010204d <filewrite+0x14a>
        panic("short filewrite");
ffff800000102034:	48 b8 53 c8 10 00 00 	movabs $0xffff80000010c853,%rax
ffff80000010203b:	80 ff ff 
ffff80000010203e:	48 89 c7             	mov    %rax,%rdi
ffff800000102041:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102048:	80 ff ff 
ffff80000010204b:	ff d0                	call   *%rax
      i += r;
ffff80000010204d:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102050:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffff800000102053:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102056:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102059:	0f 8c 20 ff ff ff    	jl     ffff800000101f7f <filewrite+0x7c>
ffff80000010205f:	eb 01                	jmp    ffff800000102062 <filewrite+0x15f>
        break;
ffff800000102061:	90                   	nop
    }
    return i == n ? n : -1;
ffff800000102062:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102065:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102068:	75 05                	jne    ffff80000010206f <filewrite+0x16c>
ffff80000010206a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010206d:	eb 20                	jmp    ffff80000010208f <filewrite+0x18c>
ffff80000010206f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102074:	eb 19                	jmp    ffff80000010208f <filewrite+0x18c>
  }
  panic("filewrite");
ffff800000102076:	48 b8 63 c8 10 00 00 	movabs $0xffff80000010c863,%rax
ffff80000010207d:	80 ff ff 
ffff800000102080:	48 89 c7             	mov    %rax,%rdi
ffff800000102083:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010208a:	80 ff ff 
ffff80000010208d:	ff d0                	call   *%rax
}
ffff80000010208f:	c9                   	leave
ffff800000102090:	c3                   	ret

ffff800000102091 <readsb>:
struct superblock sb;

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffff800000102091:	55                   	push   %rbp
ffff800000102092:	48 89 e5             	mov    %rsp,%rbp
ffff800000102095:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102099:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010209c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp = bread(dev, 1);
ffff8000001020a0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001020a3:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001020a8:	89 c7                	mov    %eax,%edi
ffff8000001020aa:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001020b1:	80 ff ff 
ffff8000001020b4:	ff d0                	call   *%rax
ffff8000001020b6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffff8000001020ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001020be:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001020c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001020c9:	ba 1c 00 00 00       	mov    $0x1c,%edx
ffff8000001020ce:	48 89 ce             	mov    %rcx,%rsi
ffff8000001020d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001020d4:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff8000001020db:	80 ff ff 
ffff8000001020de:	ff d0                	call   *%rax
  brelse(bp);
ffff8000001020e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001020e4:	48 89 c7             	mov    %rax,%rdi
ffff8000001020e7:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001020ee:	80 ff ff 
ffff8000001020f1:	ff d0                	call   *%rax
}
ffff8000001020f3:	90                   	nop
ffff8000001020f4:	c9                   	leave
ffff8000001020f5:	c3                   	ret

ffff8000001020f6 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffff8000001020f6:	55                   	push   %rbp
ffff8000001020f7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001020fa:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001020fe:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102101:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp = bread(dev, bno);
ffff800000102104:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000102107:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010210a:	89 d6                	mov    %edx,%esi
ffff80000010210c:	89 c7                	mov    %eax,%edi
ffff80000010210e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102115:	80 ff ff 
ffff800000102118:	ff d0                	call   *%rax
ffff80000010211a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffff80000010211e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102122:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102128:	ba 00 02 00 00       	mov    $0x200,%edx
ffff80000010212d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000102132:	48 89 c7             	mov    %rax,%rdi
ffff800000102135:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010213c:	80 ff ff 
ffff80000010213f:	ff d0                	call   *%rax
  log_write(bp);
ffff800000102141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102145:	48 89 c7             	mov    %rax,%rdi
ffff800000102148:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff80000010214f:	80 ff ff 
ffff800000102152:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102154:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102158:	48 89 c7             	mov    %rax,%rdi
ffff80000010215b:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102162:	80 ff ff 
ffff800000102165:	ff d0                	call   *%rax
}
ffff800000102167:	90                   	nop
ffff800000102168:	c9                   	leave
ffff800000102169:	c3                   	ret

ffff80000010216a <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffff80000010216a:	55                   	push   %rbp
ffff80000010216b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010216e:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102172:	89 7d dc             	mov    %edi,-0x24(%rbp)
  int b, bi, m;
  struct buf *bp;
  for(b = 0; b < sb.size; b += BPB){
ffff800000102175:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010217c:	e9 4a 01 00 00       	jmp    ffff8000001022cb <balloc+0x161>
    bp = bread(dev, BBLOCK(b, sb));
ffff800000102181:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102184:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffff80000010218a:	85 c0                	test   %eax,%eax
ffff80000010218c:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010218f:	c1 f8 0c             	sar    $0xc,%eax
ffff800000102192:	89 c2                	mov    %eax,%edx
ffff800000102194:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff80000010219b:	80 ff ff 
ffff80000010219e:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001021a1:	01 c2                	add    %eax,%edx
ffff8000001021a3:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001021a6:	89 d6                	mov    %edx,%esi
ffff8000001021a8:	89 c7                	mov    %eax,%edi
ffff8000001021aa:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001021b1:	80 ff ff 
ffff8000001021b4:	ff d0                	call   *%rax
ffff8000001021b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff8000001021ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff8000001021c1:	e9 c4 00 00 00       	jmp    ffff80000010228a <balloc+0x120>
      m = 1 << (bi % 8);
ffff8000001021c6:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001021c9:	83 e0 07             	and    $0x7,%eax
ffff8000001021cc:	ba 01 00 00 00       	mov    $0x1,%edx
ffff8000001021d1:	89 c1                	mov    %eax,%ecx
ffff8000001021d3:	d3 e2                	shl    %cl,%edx
ffff8000001021d5:	89 d0                	mov    %edx,%eax
ffff8000001021d7:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffff8000001021da:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001021dd:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001021e0:	85 c0                	test   %eax,%eax
ffff8000001021e2:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001021e5:	c1 f8 03             	sar    $0x3,%eax
ffff8000001021e8:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001021ec:	48 98                	cltq
ffff8000001021ee:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001021f5:	00 
ffff8000001021f6:	0f b6 c0             	movzbl %al,%eax
ffff8000001021f9:	23 45 ec             	and    -0x14(%rbp),%eax
ffff8000001021fc:	85 c0                	test   %eax,%eax
ffff8000001021fe:	0f 85 82 00 00 00    	jne    ffff800000102286 <balloc+0x11c>
        bp->data[bi/8] |= m;  // Mark block in use.
ffff800000102204:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102207:	8d 50 07             	lea    0x7(%rax),%edx
ffff80000010220a:	85 c0                	test   %eax,%eax
ffff80000010220c:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010220f:	c1 f8 03             	sar    $0x3,%eax
ffff800000102212:	89 c1                	mov    %eax,%ecx
ffff800000102214:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102218:	48 63 c1             	movslq %ecx,%rax
ffff80000010221b:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff800000102222:	00 
ffff800000102223:	89 c2                	mov    %eax,%edx
ffff800000102225:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102228:	09 d0                	or     %edx,%eax
ffff80000010222a:	89 c6                	mov    %eax,%esi
ffff80000010222c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102230:	48 63 c1             	movslq %ecx,%rax
ffff800000102233:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff80000010223a:	00 
        log_write(bp);
ffff80000010223b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010223f:	48 89 c7             	mov    %rax,%rdi
ffff800000102242:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff800000102249:	80 ff ff 
ffff80000010224c:	ff d0                	call   *%rax
        brelse(bp);
ffff80000010224e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102252:	48 89 c7             	mov    %rax,%rdi
ffff800000102255:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010225c:	80 ff ff 
ffff80000010225f:	ff d0                	call   *%rax
        bzero(dev, b + bi);
ffff800000102261:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102264:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102267:	01 c2                	add    %eax,%edx
ffff800000102269:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010226c:	89 d6                	mov    %edx,%esi
ffff80000010226e:	89 c7                	mov    %eax,%edi
ffff800000102270:	48 b8 f6 20 10 00 00 	movabs $0xffff8000001020f6,%rax
ffff800000102277:	80 ff ff 
ffff80000010227a:	ff d0                	call   *%rax
        return b + bi;
ffff80000010227c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010227f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102282:	01 d0                	add    %edx,%eax
ffff800000102284:	eb 75                	jmp    ffff8000001022fb <balloc+0x191>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff800000102286:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010228a:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffff800000102291:	7f 1e                	jg     ffff8000001022b1 <balloc+0x147>
ffff800000102293:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102296:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102299:	01 d0                	add    %edx,%eax
ffff80000010229b:	89 c2                	mov    %eax,%edx
ffff80000010229d:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001022a4:	80 ff ff 
ffff8000001022a7:	8b 00                	mov    (%rax),%eax
ffff8000001022a9:	39 c2                	cmp    %eax,%edx
ffff8000001022ab:	0f 82 15 ff ff ff    	jb     ffff8000001021c6 <balloc+0x5c>
      }
    }
    brelse(bp);
ffff8000001022b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001022b5:	48 89 c7             	mov    %rax,%rdi
ffff8000001022b8:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001022bf:	80 ff ff 
ffff8000001022c2:	ff d0                	call   *%rax
  for(b = 0; b < sb.size; b += BPB){
ffff8000001022c4:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff8000001022cb:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001022d2:	80 ff ff 
ffff8000001022d5:	8b 00                	mov    (%rax),%eax
ffff8000001022d7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001022da:	39 c2                	cmp    %eax,%edx
ffff8000001022dc:	0f 82 9f fe ff ff    	jb     ffff800000102181 <balloc+0x17>
  }
  panic("balloc: out of blocks");
ffff8000001022e2:	48 b8 6d c8 10 00 00 	movabs $0xffff80000010c86d,%rax
ffff8000001022e9:	80 ff ff 
ffff8000001022ec:	48 89 c7             	mov    %rax,%rdi
ffff8000001022ef:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001022f6:	80 ff ff 
ffff8000001022f9:	ff d0                	call   *%rax
}
ffff8000001022fb:	c9                   	leave
ffff8000001022fc:	c3                   	ret

ffff8000001022fd <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffff8000001022fd:	55                   	push   %rbp
ffff8000001022fe:	48 89 e5             	mov    %rsp,%rbp
ffff800000102301:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102305:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102308:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int bi, m;

  readsb(dev, &sb);
ffff80000010230b:	48 ba 00 46 11 00 00 	movabs $0xffff800000114600,%rdx
ffff800000102312:	80 ff ff 
ffff800000102315:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102318:	48 89 d6             	mov    %rdx,%rsi
ffff80000010231b:	89 c7                	mov    %eax,%edi
ffff80000010231d:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff800000102324:	80 ff ff 
ffff800000102327:	ff d0                	call   *%rax
  struct buf *bp = bread(dev, BBLOCK(b, sb));
ffff800000102329:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010232c:	c1 e8 0c             	shr    $0xc,%eax
ffff80000010232f:	89 c2                	mov    %eax,%edx
ffff800000102331:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102338:	80 ff ff 
ffff80000010233b:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010233e:	01 c2                	add    %eax,%edx
ffff800000102340:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102343:	89 d6                	mov    %edx,%esi
ffff800000102345:	89 c7                	mov    %eax,%edi
ffff800000102347:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010234e:	80 ff ff 
ffff800000102351:	ff d0                	call   *%rax
ffff800000102353:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffff800000102357:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff80000010235a:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010235f:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffff800000102362:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000102365:	83 e0 07             	and    $0x7,%eax
ffff800000102368:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010236d:	89 c1                	mov    %eax,%ecx
ffff80000010236f:	d3 e2                	shl    %cl,%edx
ffff800000102371:	89 d0                	mov    %edx,%eax
ffff800000102373:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffff800000102376:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000102379:	8d 50 07             	lea    0x7(%rax),%edx
ffff80000010237c:	85 c0                	test   %eax,%eax
ffff80000010237e:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102381:	c1 f8 03             	sar    $0x3,%eax
ffff800000102384:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000102388:	48 98                	cltq
ffff80000010238a:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff800000102391:	00 
ffff800000102392:	0f b6 c0             	movzbl %al,%eax
ffff800000102395:	23 45 f0             	and    -0x10(%rbp),%eax
ffff800000102398:	85 c0                	test   %eax,%eax
ffff80000010239a:	75 19                	jne    ffff8000001023b5 <bfree+0xb8>
    panic("freeing free block");
ffff80000010239c:	48 b8 83 c8 10 00 00 	movabs $0xffff80000010c883,%rax
ffff8000001023a3:	80 ff ff 
ffff8000001023a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001023a9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001023b0:	80 ff ff 
ffff8000001023b3:	ff d0                	call   *%rax
  bp->data[bi/8] &= ~m;
ffff8000001023b5:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001023b8:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001023bb:	85 c0                	test   %eax,%eax
ffff8000001023bd:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001023c0:	c1 f8 03             	sar    $0x3,%eax
ffff8000001023c3:	89 c1                	mov    %eax,%ecx
ffff8000001023c5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001023c9:	48 63 c1             	movslq %ecx,%rax
ffff8000001023cc:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001023d3:	00 
ffff8000001023d4:	89 c2                	mov    %eax,%edx
ffff8000001023d6:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff8000001023d9:	f7 d0                	not    %eax
ffff8000001023db:	21 d0                	and    %edx,%eax
ffff8000001023dd:	89 c6                	mov    %eax,%esi
ffff8000001023df:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001023e3:	48 63 c1             	movslq %ecx,%rax
ffff8000001023e6:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff8000001023ed:	00 
  log_write(bp);
ffff8000001023ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001023f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001023f5:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff8000001023fc:	80 ff ff 
ffff8000001023ff:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102405:	48 89 c7             	mov    %rax,%rdi
ffff800000102408:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010240f:	80 ff ff 
ffff800000102412:	ff d0                	call   *%rax
}
ffff800000102414:	90                   	nop
ffff800000102415:	c9                   	leave
ffff800000102416:	c3                   	ret

ffff800000102417 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
ffff800000102417:	55                   	push   %rbp
ffff800000102418:	48 89 e5             	mov    %rsp,%rbp
ffff80000010241b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010241f:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i = 0;
ffff800000102422:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  initlock(&icache.lock, "icache");
ffff800000102429:	48 ba 96 c8 10 00 00 	movabs $0xffff80000010c896,%rdx
ffff800000102430:	80 ff ff 
ffff800000102433:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010243a:	80 ff ff 
ffff80000010243d:	48 89 d6             	mov    %rdx,%rsi
ffff800000102440:	48 89 c7             	mov    %rax,%rdi
ffff800000102443:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff80000010244a:	80 ff ff 
ffff80000010244d:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff80000010244f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102456:	eb 41                	jmp    ffff800000102499 <iinit+0x82>
    initsleeplock(&icache.inode[i].lock, "inode");
ffff800000102458:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010245b:	48 98                	cltq
ffff80000010245d:	48 69 c0 d8 00 00 00 	imul   $0xd8,%rax,%rax
ffff800000102464:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff800000102468:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010246f:	80 ff ff 
ffff800000102472:	48 01 d0             	add    %rdx,%rax
ffff800000102475:	48 83 c0 08          	add    $0x8,%rax
ffff800000102479:	48 ba 9d c8 10 00 00 	movabs $0xffff80000010c89d,%rdx
ffff800000102480:	80 ff ff 
ffff800000102483:	48 89 d6             	mov    %rdx,%rsi
ffff800000102486:	48 89 c7             	mov    %rax,%rdi
ffff800000102489:	48 b8 da 74 10 00 00 	movabs $0xffff8000001074da,%rax
ffff800000102490:	80 ff ff 
ffff800000102493:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff800000102495:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102499:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
ffff80000010249d:	7e b9                	jle    ffff800000102458 <iinit+0x41>
  }

  readsb(dev, &sb);
ffff80000010249f:	48 ba 00 46 11 00 00 	movabs $0xffff800000114600,%rdx
ffff8000001024a6:	80 ff ff 
ffff8000001024a9:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001024ac:	48 89 d6             	mov    %rdx,%rsi
ffff8000001024af:	89 c7                	mov    %eax,%edi
ffff8000001024b1:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff8000001024b8:	80 ff ff 
ffff8000001024bb:	ff d0                	call   *%rax
  /*cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);*/
}
ffff8000001024bd:	90                   	nop
ffff8000001024be:	c9                   	leave
ffff8000001024bf:	c3                   	ret

ffff8000001024c0 <ialloc>:

// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffff8000001024c0:	55                   	push   %rbp
ffff8000001024c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001024c4:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001024c8:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff8000001024cb:	89 f0                	mov    %esi,%eax
ffff8000001024cd:	66 89 45 d8          	mov    %ax,-0x28(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001024d1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff8000001024d8:	e9 d8 00 00 00       	jmp    ffff8000001025b5 <ialloc+0xf5>
    bp = bread(dev, IBLOCK(inum, sb));
ffff8000001024dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001024e0:	48 98                	cltq
ffff8000001024e2:	48 c1 e8 03          	shr    $0x3,%rax
ffff8000001024e6:	89 c2                	mov    %eax,%edx
ffff8000001024e8:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001024ef:	80 ff ff 
ffff8000001024f2:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001024f5:	01 c2                	add    %eax,%edx
ffff8000001024f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001024fa:	89 d6                	mov    %edx,%esi
ffff8000001024fc:	89 c7                	mov    %eax,%edi
ffff8000001024fe:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102505:	80 ff ff 
ffff800000102508:	ff d0                	call   *%rax
ffff80000010250a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffff80000010250e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102512:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102519:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010251c:	48 98                	cltq
ffff80000010251e:	83 e0 07             	and    $0x7,%eax
ffff800000102521:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102525:	48 01 d0             	add    %rdx,%rax
ffff800000102528:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffff80000010252c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102530:	0f b7 00             	movzwl (%rax),%eax
ffff800000102533:	66 85 c0             	test   %ax,%ax
ffff800000102536:	75 66                	jne    ffff80000010259e <ialloc+0xde>
      memset(dip, 0, sizeof(*dip));
ffff800000102538:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010253c:	ba 40 00 00 00       	mov    $0x40,%edx
ffff800000102541:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000102546:	48 89 c7             	mov    %rax,%rdi
ffff800000102549:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000102550:	80 ff ff 
ffff800000102553:	ff d0                	call   *%rax
      dip->type = type;
ffff800000102555:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102559:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff80000010255d:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffff800000102560:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102564:	48 89 c7             	mov    %rax,%rdi
ffff800000102567:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff80000010256e:	80 ff ff 
ffff800000102571:	ff d0                	call   *%rax
      brelse(bp);
ffff800000102573:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102577:	48 89 c7             	mov    %rax,%rdi
ffff80000010257a:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102581:	80 ff ff 
ffff800000102584:	ff d0                	call   *%rax
      return iget(dev, inum);
ffff800000102586:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102589:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010258c:	89 d6                	mov    %edx,%esi
ffff80000010258e:	89 c7                	mov    %eax,%edi
ffff800000102590:	48 b8 fa 26 10 00 00 	movabs $0xffff8000001026fa,%rax
ffff800000102597:	80 ff ff 
ffff80000010259a:	ff d0                	call   *%rax
ffff80000010259c:	eb 48                	jmp    ffff8000001025e6 <ialloc+0x126>
    }
    brelse(bp);
ffff80000010259e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001025a2:	48 89 c7             	mov    %rax,%rdi
ffff8000001025a5:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001025ac:	80 ff ff 
ffff8000001025af:	ff d0                	call   *%rax
  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001025b1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001025b5:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff8000001025bc:	80 ff ff 
ffff8000001025bf:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001025c2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001025c5:	39 c2                	cmp    %eax,%edx
ffff8000001025c7:	0f 82 10 ff ff ff    	jb     ffff8000001024dd <ialloc+0x1d>
  }
  panic("ialloc: no inodes");
ffff8000001025cd:	48 b8 a3 c8 10 00 00 	movabs $0xffff80000010c8a3,%rax
ffff8000001025d4:	80 ff ff 
ffff8000001025d7:	48 89 c7             	mov    %rax,%rdi
ffff8000001025da:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001025e1:	80 ff ff 
ffff8000001025e4:	ff d0                	call   *%rax
}
ffff8000001025e6:	c9                   	leave
ffff8000001025e7:	c3                   	ret

ffff8000001025e8 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffff8000001025e8:	55                   	push   %rbp
ffff8000001025e9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001025ec:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001025f0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff8000001025f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001025f8:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001025fb:	c1 e8 03             	shr    $0x3,%eax
ffff8000001025fe:	89 c2                	mov    %eax,%edx
ffff800000102600:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102607:	80 ff ff 
ffff80000010260a:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010260d:	01 c2                	add    %eax,%edx
ffff80000010260f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102613:	8b 00                	mov    (%rax),%eax
ffff800000102615:	89 d6                	mov    %edx,%esi
ffff800000102617:	89 c7                	mov    %eax,%edi
ffff800000102619:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102620:	80 ff ff 
ffff800000102623:	ff d0                	call   *%rax
ffff800000102625:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102629:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010262d:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102634:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102638:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010263b:	89 c0                	mov    %eax,%eax
ffff80000010263d:	83 e0 07             	and    $0x7,%eax
ffff800000102640:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102644:	48 01 d0             	add    %rdx,%rax
ffff800000102647:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffff80000010264b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010264f:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102656:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010265a:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffff80000010265d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102661:	0f b7 90 96 00 00 00 	movzwl 0x96(%rax),%edx
ffff800000102668:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010266c:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffff800000102670:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102674:	0f b7 90 98 00 00 00 	movzwl 0x98(%rax),%edx
ffff80000010267b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010267f:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffff800000102683:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102687:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff80000010268e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102692:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffff800000102696:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010269a:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff8000001026a0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026a4:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffff8000001026a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001026ab:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff8000001026b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026b6:	48 83 c0 0c          	add    $0xc,%rax
ffff8000001026ba:	ba 34 00 00 00       	mov    $0x34,%edx
ffff8000001026bf:	48 89 ce             	mov    %rcx,%rsi
ffff8000001026c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001026c5:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff8000001026cc:	80 ff ff 
ffff8000001026cf:	ff d0                	call   *%rax
  log_write(bp);
ffff8000001026d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001026d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001026d8:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff8000001026df:	80 ff ff 
ffff8000001026e2:	ff d0                	call   *%rax
  brelse(bp);
ffff8000001026e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001026e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001026eb:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001026f2:	80 ff ff 
ffff8000001026f5:	ff d0                	call   *%rax
}
ffff8000001026f7:	90                   	nop
ffff8000001026f8:	c9                   	leave
ffff8000001026f9:	c3                   	ret

ffff8000001026fa <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffff8000001026fa:	55                   	push   %rbp
ffff8000001026fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001026fe:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102702:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102705:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffff800000102708:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010270f:	80 ff ff 
ffff800000102712:	48 89 c7             	mov    %rax,%rdi
ffff800000102715:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010271c:	80 ff ff 
ffff80000010271f:	ff d0                	call   *%rax

  // Is the inode already cached?
  empty = 0;
ffff800000102721:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff800000102728:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff800000102729:	48 b8 88 46 11 00 00 	movabs $0xffff800000114688,%rax
ffff800000102730:	80 ff ff 
ffff800000102733:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000102737:	eb 77                	jmp    ffff8000001027b0 <iget+0xb6>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffff800000102739:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010273d:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102740:	85 c0                	test   %eax,%eax
ffff800000102742:	7e 4a                	jle    ffff80000010278e <iget+0x94>
ffff800000102744:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102748:	8b 00                	mov    (%rax),%eax
ffff80000010274a:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff80000010274d:	75 3f                	jne    ffff80000010278e <iget+0x94>
ffff80000010274f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102753:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102756:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff800000102759:	75 33                	jne    ffff80000010278e <iget+0x94>
      ip->ref++;
ffff80000010275b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010275f:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102762:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000102765:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102769:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffff80000010276c:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102773:	80 ff ff 
ffff800000102776:	48 89 c7             	mov    %rax,%rdi
ffff800000102779:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000102780:	80 ff ff 
ffff800000102783:	ff d0                	call   *%rax
      return ip;
ffff800000102785:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102789:	e9 a7 00 00 00       	jmp    ffff800000102835 <iget+0x13b>
    }
    if(empty == 0 && ip->ref == 0) // Remember empty slot.
ffff80000010278e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000102793:	75 13                	jne    ffff8000001027a8 <iget+0xae>
ffff800000102795:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102799:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010279c:	85 c0                	test   %eax,%eax
ffff80000010279e:	75 08                	jne    ffff8000001027a8 <iget+0xae>
      empty = ip;
ffff8000001027a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027a4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff8000001027a8:	48 81 45 f8 d8 00 00 	addq   $0xd8,-0x8(%rbp)
ffff8000001027af:	00 
ffff8000001027b0:	48 b8 b8 70 11 00 00 	movabs $0xffff8000001170b8,%rax
ffff8000001027b7:	80 ff ff 
ffff8000001027ba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001027be:	0f 82 75 ff ff ff    	jb     ffff800000102739 <iget+0x3f>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffff8000001027c4:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001027c9:	75 19                	jne    ffff8000001027e4 <iget+0xea>
    panic("iget: no inodes");
ffff8000001027cb:	48 b8 b5 c8 10 00 00 	movabs $0xffff80000010c8b5,%rax
ffff8000001027d2:	80 ff ff 
ffff8000001027d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001027d8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001027df:	80 ff ff 
ffff8000001027e2:	ff d0                	call   *%rax

  ip = empty;
ffff8000001027e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027e8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffff8000001027ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027f0:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001027f3:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffff8000001027f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027f9:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001027fc:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffff8000001027ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102803:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffff80000010280a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010280e:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102815:	00 00 00 
  release(&icache.lock);
ffff800000102818:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010281f:	80 ff ff 
ffff800000102822:	48 89 c7             	mov    %rax,%rdi
ffff800000102825:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010282c:	80 ff ff 
ffff80000010282f:	ff d0                	call   *%rax

  return ip;
ffff800000102831:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000102835:	c9                   	leave
ffff800000102836:	c3                   	ret

ffff800000102837 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffff800000102837:	55                   	push   %rbp
ffff800000102838:	48 89 e5             	mov    %rsp,%rbp
ffff80000010283b:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010283f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102843:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010284a:	80 ff ff 
ffff80000010284d:	48 89 c7             	mov    %rax,%rdi
ffff800000102850:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000102857:	80 ff ff 
ffff80000010285a:	ff d0                	call   *%rax
  ip->ref++;
ffff80000010285c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102860:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102863:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000102866:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010286a:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff80000010286d:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102874:	80 ff ff 
ffff800000102877:	48 89 c7             	mov    %rax,%rdi
ffff80000010287a:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000102881:	80 ff ff 
ffff800000102884:	ff d0                	call   *%rax
  return ip;
ffff800000102886:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010288a:	c9                   	leave
ffff80000010288b:	c3                   	ret

ffff80000010288c <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffff80000010288c:	55                   	push   %rbp
ffff80000010288d:	48 89 e5             	mov    %rsp,%rbp
ffff800000102890:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102894:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffff800000102898:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010289d:	74 0b                	je     ffff8000001028aa <ilock+0x1e>
ffff80000010289f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028a3:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001028a6:	85 c0                	test   %eax,%eax
ffff8000001028a8:	7f 19                	jg     ffff8000001028c3 <ilock+0x37>
    panic("ilock");
ffff8000001028aa:	48 b8 c5 c8 10 00 00 	movabs $0xffff80000010c8c5,%rax
ffff8000001028b1:	80 ff ff 
ffff8000001028b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001028b7:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001028be:	80 ff ff 
ffff8000001028c1:	ff d0                	call   *%rax

  acquiresleep(&ip->lock);
ffff8000001028c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028c7:	48 83 c0 10          	add    $0x10,%rax
ffff8000001028cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001028ce:	48 b8 32 75 10 00 00 	movabs $0xffff800000107532,%rax
ffff8000001028d5:	80 ff ff 
ffff8000001028d8:	ff d0                	call   *%rax

  if(!(ip->flags & I_VALID)){
ffff8000001028da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028de:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001028e4:	83 e0 02             	and    $0x2,%eax
ffff8000001028e7:	85 c0                	test   %eax,%eax
ffff8000001028e9:	0f 85 31 01 00 00    	jne    ffff800000102a20 <ilock+0x194>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff8000001028ef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028f3:	8b 40 04             	mov    0x4(%rax),%eax
ffff8000001028f6:	c1 e8 03             	shr    $0x3,%eax
ffff8000001028f9:	89 c2                	mov    %eax,%edx
ffff8000001028fb:	48 b8 00 46 11 00 00 	movabs $0xffff800000114600,%rax
ffff800000102902:	80 ff ff 
ffff800000102905:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000102908:	01 c2                	add    %eax,%edx
ffff80000010290a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010290e:	8b 00                	mov    (%rax),%eax
ffff800000102910:	89 d6                	mov    %edx,%esi
ffff800000102912:	89 c7                	mov    %eax,%edi
ffff800000102914:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010291b:	80 ff ff 
ffff80000010291e:	ff d0                	call   *%rax
ffff800000102920:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102924:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102928:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010292f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102933:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102936:	89 c0                	mov    %eax,%eax
ffff800000102938:	83 e0 07             	and    $0x7,%eax
ffff80000010293b:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010293f:	48 01 d0             	add    %rdx,%rax
ffff800000102942:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffff800000102946:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010294a:	0f b7 10             	movzwl (%rax),%edx
ffff80000010294d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102951:	66 89 90 94 00 00 00 	mov    %dx,0x94(%rax)
    ip->major = dip->major;
ffff800000102958:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010295c:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffff800000102960:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102964:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
    ip->minor = dip->minor;
ffff80000010296b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010296f:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffff800000102973:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102977:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
    ip->nlink = dip->nlink;
ffff80000010297e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102982:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffff800000102986:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010298a:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    ip->size = dip->size;
ffff800000102991:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102995:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000102998:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010299c:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffff8000001029a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001029a6:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffff8000001029aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029ae:	48 05 a0 00 00 00    	add    $0xa0,%rax
ffff8000001029b4:	ba 34 00 00 00       	mov    $0x34,%edx
ffff8000001029b9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001029bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001029bf:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff8000001029c6:	80 ff ff 
ffff8000001029c9:	ff d0                	call   *%rax
    brelse(bp);
ffff8000001029cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001029cf:	48 89 c7             	mov    %rax,%rdi
ffff8000001029d2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001029d9:	80 ff ff 
ffff8000001029dc:	ff d0                	call   *%rax
    ip->flags |= I_VALID;
ffff8000001029de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029e2:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001029e8:	83 c8 02             	or     $0x2,%eax
ffff8000001029eb:	89 c2                	mov    %eax,%edx
ffff8000001029ed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029f1:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
    if(ip->type == 0)
ffff8000001029f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029fb:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102a02:	66 85 c0             	test   %ax,%ax
ffff800000102a05:	75 19                	jne    ffff800000102a20 <ilock+0x194>
      panic("ilock: no type");
ffff800000102a07:	48 b8 cb c8 10 00 00 	movabs $0xffff80000010c8cb,%rax
ffff800000102a0e:	80 ff ff 
ffff800000102a11:	48 89 c7             	mov    %rax,%rdi
ffff800000102a14:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102a1b:	80 ff ff 
ffff800000102a1e:	ff d0                	call   *%rax
  }
}
ffff800000102a20:	90                   	nop
ffff800000102a21:	c9                   	leave
ffff800000102a22:	c3                   	ret

ffff800000102a23 <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffff800000102a23:	55                   	push   %rbp
ffff800000102a24:	48 89 e5             	mov    %rsp,%rbp
ffff800000102a27:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102a2b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
ffff800000102a2f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000102a34:	74 26                	je     ffff800000102a5c <iunlock+0x39>
ffff800000102a36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a3a:	48 83 c0 10          	add    $0x10,%rax
ffff800000102a3e:	48 89 c7             	mov    %rax,%rdi
ffff800000102a41:	48 b8 1d 76 10 00 00 	movabs $0xffff80000010761d,%rax
ffff800000102a48:	80 ff ff 
ffff800000102a4b:	ff d0                	call   *%rax
ffff800000102a4d:	85 c0                	test   %eax,%eax
ffff800000102a4f:	74 0b                	je     ffff800000102a5c <iunlock+0x39>
ffff800000102a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a55:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102a58:	85 c0                	test   %eax,%eax
ffff800000102a5a:	7f 19                	jg     ffff800000102a75 <iunlock+0x52>
    panic("iunlock");
ffff800000102a5c:	48 b8 da c8 10 00 00 	movabs $0xffff80000010c8da,%rax
ffff800000102a63:	80 ff ff 
ffff800000102a66:	48 89 c7             	mov    %rax,%rdi
ffff800000102a69:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102a70:	80 ff ff 
ffff800000102a73:	ff d0                	call   *%rax

  releasesleep(&ip->lock);
ffff800000102a75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a79:	48 83 c0 10          	add    $0x10,%rax
ffff800000102a7d:	48 89 c7             	mov    %rax,%rdi
ffff800000102a80:	48 b8 b8 75 10 00 00 	movabs $0xffff8000001075b8,%rax
ffff800000102a87:	80 ff ff 
ffff800000102a8a:	ff d0                	call   *%rax
}
ffff800000102a8c:	90                   	nop
ffff800000102a8d:	c9                   	leave
ffff800000102a8e:	c3                   	ret

ffff800000102a8f <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
ffff800000102a8f:	55                   	push   %rbp
ffff800000102a90:	48 89 e5             	mov    %rsp,%rbp
ffff800000102a93:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102a97:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102a9b:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102aa2:	80 ff ff 
ffff800000102aa5:	48 89 c7             	mov    %rax,%rdi
ffff800000102aa8:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000102aaf:	80 ff ff 
ffff800000102ab2:	ff d0                	call   *%rax
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffff800000102ab4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ab8:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102abb:	83 f8 01             	cmp    $0x1,%eax
ffff800000102abe:	0f 85 98 00 00 00    	jne    ffff800000102b5c <iput+0xcd>
ffff800000102ac4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ac8:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102ace:	83 e0 02             	and    $0x2,%eax
ffff800000102ad1:	85 c0                	test   %eax,%eax
ffff800000102ad3:	0f 84 83 00 00 00    	je     ffff800000102b5c <iput+0xcd>
ffff800000102ad9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102add:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000102ae4:	66 85 c0             	test   %ax,%ax
ffff800000102ae7:	75 73                	jne    ffff800000102b5c <iput+0xcd>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
ffff800000102ae9:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102af0:	80 ff ff 
ffff800000102af3:	48 89 c7             	mov    %rax,%rdi
ffff800000102af6:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000102afd:	80 ff ff 
ffff800000102b00:	ff d0                	call   *%rax
    itrunc(ip);
ffff800000102b02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b06:	48 89 c7             	mov    %rax,%rdi
ffff800000102b09:	48 b8 1b 2d 10 00 00 	movabs $0xffff800000102d1b,%rax
ffff800000102b10:	80 ff ff 
ffff800000102b13:	ff d0                	call   *%rax
    ip->type = 0;
ffff800000102b15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b19:	66 c7 80 94 00 00 00 	movw   $0x0,0x94(%rax)
ffff800000102b20:	00 00 
    iupdate(ip);
ffff800000102b22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b26:	48 89 c7             	mov    %rax,%rdi
ffff800000102b29:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000102b30:	80 ff ff 
ffff800000102b33:	ff d0                	call   *%rax
    acquire(&icache.lock);
ffff800000102b35:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102b3c:	80 ff ff 
ffff800000102b3f:	48 89 c7             	mov    %rax,%rdi
ffff800000102b42:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000102b49:	80 ff ff 
ffff800000102b4c:	ff d0                	call   *%rax
    ip->flags = 0;
ffff800000102b4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b52:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102b59:	00 00 00 
  }
  ip->ref--;
ffff800000102b5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b60:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102b63:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000102b66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b6a:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102b6d:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff800000102b74:	80 ff ff 
ffff800000102b77:	48 89 c7             	mov    %rax,%rdi
ffff800000102b7a:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000102b81:	80 ff ff 
ffff800000102b84:	ff d0                	call   *%rax
}
ffff800000102b86:	90                   	nop
ffff800000102b87:	c9                   	leave
ffff800000102b88:	c3                   	ret

ffff800000102b89 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffff800000102b89:	55                   	push   %rbp
ffff800000102b8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b8d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b91:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffff800000102b95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b99:	48 89 c7             	mov    %rax,%rdi
ffff800000102b9c:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000102ba3:	80 ff ff 
ffff800000102ba6:	ff d0                	call   *%rax
  iput(ip);
ffff800000102ba8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bac:	48 89 c7             	mov    %rax,%rdi
ffff800000102baf:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000102bb6:	80 ff ff 
ffff800000102bb9:	ff d0                	call   *%rax
}
ffff800000102bbb:	90                   	nop
ffff800000102bbc:	c9                   	leave
ffff800000102bbd:	c3                   	ret

ffff800000102bbe <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffff800000102bbe:	55                   	push   %rbp
ffff800000102bbf:	48 89 e5             	mov    %rsp,%rbp
ffff800000102bc2:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102bc6:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102bca:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffff800000102bcd:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffff800000102bd1:	77 47                	ja     ffff800000102c1a <bmap+0x5c>
    if((addr = ip->addrs[bn]) == 0)
ffff800000102bd3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102bd7:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102bda:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102bde:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102be1:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102be4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102be8:	75 28                	jne    ffff800000102c12 <bmap+0x54>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffff800000102bea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102bee:	8b 00                	mov    (%rax),%eax
ffff800000102bf0:	89 c7                	mov    %eax,%edi
ffff800000102bf2:	48 b8 6a 21 10 00 00 	movabs $0xffff80000010216a,%rax
ffff800000102bf9:	80 ff ff 
ffff800000102bfc:	ff d0                	call   *%rax
ffff800000102bfe:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102c01:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c05:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102c08:	48 8d 4a 28          	lea    0x28(%rdx),%rcx
ffff800000102c0c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102c0f:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    return addr;
ffff800000102c12:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102c15:	e9 ff 00 00 00       	jmp    ffff800000102d19 <bmap+0x15b>
  }
  bn -= NDIRECT;
ffff800000102c1a:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffff800000102c1e:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffff800000102c22:	0f 87 d8 00 00 00    	ja     ffff800000102d00 <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffff800000102c28:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c2c:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102c32:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102c35:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102c39:	75 24                	jne    ffff800000102c5f <bmap+0xa1>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffff800000102c3b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c3f:	8b 00                	mov    (%rax),%eax
ffff800000102c41:	89 c7                	mov    %eax,%edi
ffff800000102c43:	48 b8 6a 21 10 00 00 	movabs $0xffff80000010216a,%rax
ffff800000102c4a:	80 ff ff 
ffff800000102c4d:	ff d0                	call   *%rax
ffff800000102c4f:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102c52:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c56:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102c59:	89 90 d0 00 00 00    	mov    %edx,0xd0(%rax)
    bp = bread(ip->dev, addr);
ffff800000102c5f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102c63:	8b 00                	mov    (%rax),%eax
ffff800000102c65:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102c68:	89 d6                	mov    %edx,%esi
ffff800000102c6a:	89 c7                	mov    %eax,%edi
ffff800000102c6c:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102c73:	80 ff ff 
ffff800000102c76:	ff d0                	call   *%rax
ffff800000102c78:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102c7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102c80:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102c86:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffff800000102c8a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102c8d:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102c94:	00 
ffff800000102c95:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102c99:	48 01 d0             	add    %rdx,%rax
ffff800000102c9c:	8b 00                	mov    (%rax),%eax
ffff800000102c9e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102ca1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102ca5:	75 41                	jne    ffff800000102ce8 <bmap+0x12a>
      a[bn] = addr = balloc(ip->dev);
ffff800000102ca7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cab:	8b 00                	mov    (%rax),%eax
ffff800000102cad:	89 c7                	mov    %eax,%edi
ffff800000102caf:	48 b8 6a 21 10 00 00 	movabs $0xffff80000010216a,%rax
ffff800000102cb6:	80 ff ff 
ffff800000102cb9:	ff d0                	call   *%rax
ffff800000102cbb:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102cbe:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102cc1:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102cc8:	00 
ffff800000102cc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ccd:	48 01 c2             	add    %rax,%rdx
ffff800000102cd0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102cd3:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffff800000102cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102cd9:	48 89 c7             	mov    %rax,%rdi
ffff800000102cdc:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff800000102ce3:	80 ff ff 
ffff800000102ce6:	ff d0                	call   *%rax
    }
    brelse(bp);
ffff800000102ce8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102cec:	48 89 c7             	mov    %rax,%rdi
ffff800000102cef:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102cf6:	80 ff ff 
ffff800000102cf9:	ff d0                	call   *%rax
    return addr;
ffff800000102cfb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102cfe:	eb 19                	jmp    ffff800000102d19 <bmap+0x15b>
  }

  panic("bmap: out of range");
ffff800000102d00:	48 b8 e2 c8 10 00 00 	movabs $0xffff80000010c8e2,%rax
ffff800000102d07:	80 ff ff 
ffff800000102d0a:	48 89 c7             	mov    %rax,%rdi
ffff800000102d0d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102d14:	80 ff ff 
ffff800000102d17:	ff d0                	call   *%rax
}
ffff800000102d19:	c9                   	leave
ffff800000102d1a:	c3                   	ret

ffff800000102d1b <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffff800000102d1b:	55                   	push   %rbp
ffff800000102d1c:	48 89 e5             	mov    %rsp,%rbp
ffff800000102d1f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102d23:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffff800000102d27:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102d2e:	eb 55                	jmp    ffff800000102d85 <itrunc+0x6a>
    if(ip->addrs[i]){
ffff800000102d30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d34:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d37:	48 63 d2             	movslq %edx,%rdx
ffff800000102d3a:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d3e:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d41:	85 c0                	test   %eax,%eax
ffff800000102d43:	74 3c                	je     ffff800000102d81 <itrunc+0x66>
      bfree(ip->dev, ip->addrs[i]);
ffff800000102d45:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d49:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d4c:	48 63 d2             	movslq %edx,%rdx
ffff800000102d4f:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d53:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d56:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102d5a:	8b 12                	mov    (%rdx),%edx
ffff800000102d5c:	89 c6                	mov    %eax,%esi
ffff800000102d5e:	89 d7                	mov    %edx,%edi
ffff800000102d60:	48 b8 fd 22 10 00 00 	movabs $0xffff8000001022fd,%rax
ffff800000102d67:	80 ff ff 
ffff800000102d6a:	ff d0                	call   *%rax
      ip->addrs[i] = 0;
ffff800000102d6c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d70:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d73:	48 63 d2             	movslq %edx,%rdx
ffff800000102d76:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d7a:	c7 04 90 00 00 00 00 	movl   $0x0,(%rax,%rdx,4)
  for(i = 0; i < NDIRECT; i++){
ffff800000102d81:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102d85:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffff800000102d89:	7e a5                	jle    ffff800000102d30 <itrunc+0x15>
    }
  }

  if(ip->addrs[NDIRECT]){
ffff800000102d8b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d8f:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102d95:	85 c0                	test   %eax,%eax
ffff800000102d97:	0f 84 ce 00 00 00    	je     ffff800000102e6b <itrunc+0x150>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffff800000102d9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102da1:	8b 90 d0 00 00 00    	mov    0xd0(%rax),%edx
ffff800000102da7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102dab:	8b 00                	mov    (%rax),%eax
ffff800000102dad:	89 d6                	mov    %edx,%esi
ffff800000102daf:	89 c7                	mov    %eax,%edi
ffff800000102db1:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102db8:	80 ff ff 
ffff800000102dbb:	ff d0                	call   *%rax
ffff800000102dbd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102dc1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102dc5:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102dcb:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffff800000102dcf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102dd6:	eb 4a                	jmp    ffff800000102e22 <itrunc+0x107>
      if(a[j])
ffff800000102dd8:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102ddb:	48 98                	cltq
ffff800000102ddd:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102de4:	00 
ffff800000102de5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102de9:	48 01 d0             	add    %rdx,%rax
ffff800000102dec:	8b 00                	mov    (%rax),%eax
ffff800000102dee:	85 c0                	test   %eax,%eax
ffff800000102df0:	74 2c                	je     ffff800000102e1e <itrunc+0x103>
        bfree(ip->dev, a[j]);
ffff800000102df2:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102df5:	48 98                	cltq
ffff800000102df7:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102dfe:	00 
ffff800000102dff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102e03:	48 01 d0             	add    %rdx,%rax
ffff800000102e06:	8b 00                	mov    (%rax),%eax
ffff800000102e08:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102e0c:	8b 12                	mov    (%rdx),%edx
ffff800000102e0e:	89 c6                	mov    %eax,%esi
ffff800000102e10:	89 d7                	mov    %edx,%edi
ffff800000102e12:	48 b8 fd 22 10 00 00 	movabs $0xffff8000001022fd,%rax
ffff800000102e19:	80 ff ff 
ffff800000102e1c:	ff d0                	call   *%rax
    for(j = 0; j < NINDIRECT; j++){
ffff800000102e1e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff800000102e22:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102e25:	83 f8 7f             	cmp    $0x7f,%eax
ffff800000102e28:	76 ae                	jbe    ffff800000102dd8 <itrunc+0xbd>
    }
    brelse(bp);
ffff800000102e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e2e:	48 89 c7             	mov    %rax,%rdi
ffff800000102e31:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102e38:	80 ff ff 
ffff800000102e3b:	ff d0                	call   *%rax
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffff800000102e3d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e41:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102e47:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102e4b:	8b 12                	mov    (%rdx),%edx
ffff800000102e4d:	89 c6                	mov    %eax,%esi
ffff800000102e4f:	89 d7                	mov    %edx,%edi
ffff800000102e51:	48 b8 fd 22 10 00 00 	movabs $0xffff8000001022fd,%rax
ffff800000102e58:	80 ff ff 
ffff800000102e5b:	ff d0                	call   *%rax
    ip->addrs[NDIRECT] = 0;
ffff800000102e5d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e61:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%rax)
ffff800000102e68:	00 00 00 
  }

  ip->size = 0;
ffff800000102e6b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e6f:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%rax)
ffff800000102e76:	00 00 00 
  iupdate(ip);
ffff800000102e79:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e7d:	48 89 c7             	mov    %rax,%rdi
ffff800000102e80:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000102e87:	80 ff ff 
ffff800000102e8a:	ff d0                	call   *%rax
}
ffff800000102e8c:	90                   	nop
ffff800000102e8d:	c9                   	leave
ffff800000102e8e:	c3                   	ret

ffff800000102e8f <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffff800000102e8f:	55                   	push   %rbp
ffff800000102e90:	48 89 e5             	mov    %rsp,%rbp
ffff800000102e93:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102e97:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102e9b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffff800000102e9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ea3:	8b 00                	mov    (%rax),%eax
ffff800000102ea5:	89 c2                	mov    %eax,%edx
ffff800000102ea7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eab:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffff800000102eae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102eb2:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000102eb5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eb9:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffff800000102ebc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ec0:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102ec7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ecb:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffff800000102ece:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ed2:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000102ed9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102edd:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffff800000102ee1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ee5:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000102eeb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eef:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000102ef2:	90                   	nop
ffff800000102ef3:	c9                   	leave
ffff800000102ef4:	c3                   	ret

ffff800000102ef5 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffff800000102ef5:	55                   	push   %rbp
ffff800000102ef6:	48 89 e5             	mov    %rsp,%rbp
ffff800000102ef9:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000102efd:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102f01:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000102f05:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff800000102f08:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff800000102f0b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f0f:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102f16:	66 83 f8 03          	cmp    $0x3,%ax
ffff800000102f1a:	0f 85 8d 00 00 00    	jne    ffff800000102fad <readi+0xb8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffff800000102f20:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f24:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f2b:	66 85 c0             	test   %ax,%ax
ffff800000102f2e:	78 38                	js     ffff800000102f68 <readi+0x73>
ffff800000102f30:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f34:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f3b:	66 83 f8 09          	cmp    $0x9,%ax
ffff800000102f3f:	7f 27                	jg     ffff800000102f68 <readi+0x73>
ffff800000102f41:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f45:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f4c:	98                   	cwtl
ffff800000102f4d:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000102f54:	80 ff ff 
ffff800000102f57:	48 98                	cltq
ffff800000102f59:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000102f5d:	48 01 d0             	add    %rdx,%rax
ffff800000102f60:	48 8b 00             	mov    (%rax),%rax
ffff800000102f63:	48 85 c0             	test   %rax,%rax
ffff800000102f66:	75 0a                	jne    ffff800000102f72 <readi+0x7d>
      return -1;
ffff800000102f68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102f6d:	e9 4e 01 00 00       	jmp    ffff8000001030c0 <readi+0x1cb>
    return devsw[ip->major].read(ip, off, dst, n);
ffff800000102f72:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f76:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000102f7d:	98                   	cwtl
ffff800000102f7e:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000102f85:	80 ff ff 
ffff800000102f88:	48 98                	cltq
ffff800000102f8a:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000102f8e:	48 01 d0             	add    %rdx,%rax
ffff800000102f91:	4c 8b 00             	mov    (%rax),%r8
ffff800000102f94:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff800000102f97:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000102f9b:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000102f9e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fa2:	48 89 c7             	mov    %rax,%rdi
ffff800000102fa5:	41 ff d0             	call   *%r8
ffff800000102fa8:	e9 13 01 00 00       	jmp    ffff8000001030c0 <readi+0x1cb>
  }

  if(off > ip->size || off + n < off)
ffff800000102fad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fb1:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000102fb7:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000102fba:	72 0d                	jb     ffff800000102fc9 <readi+0xd4>
ffff800000102fbc:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000102fbf:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000102fc2:	01 d0                	add    %edx,%eax
ffff800000102fc4:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff800000102fc7:	73 0a                	jae    ffff800000102fd3 <readi+0xde>
    return -1;
ffff800000102fc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000102fce:	e9 ed 00 00 00       	jmp    ffff8000001030c0 <readi+0x1cb>
  if(off + n > ip->size)
ffff800000102fd3:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000102fd6:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000102fd9:	01 c2                	add    %eax,%edx
ffff800000102fdb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fdf:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000102fe5:	39 d0                	cmp    %edx,%eax
ffff800000102fe7:	73 10                	jae    ffff800000102ff9 <readi+0x104>
    n = ip->size - off;
ffff800000102fe9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fed:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000102ff3:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffff800000102ff6:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff800000102ff9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103000:	e9 ac 00 00 00       	jmp    ffff8000001030b1 <readi+0x1bc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff800000103005:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103008:	c1 e8 09             	shr    $0x9,%eax
ffff80000010300b:	89 c2                	mov    %eax,%edx
ffff80000010300d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103011:	89 d6                	mov    %edx,%esi
ffff800000103013:	48 89 c7             	mov    %rax,%rdi
ffff800000103016:	48 b8 be 2b 10 00 00 	movabs $0xffff800000102bbe,%rax
ffff80000010301d:	80 ff ff 
ffff800000103020:	ff d0                	call   *%rax
ffff800000103022:	89 c2                	mov    %eax,%edx
ffff800000103024:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103028:	8b 00                	mov    (%rax),%eax
ffff80000010302a:	89 d6                	mov    %edx,%esi
ffff80000010302c:	89 c7                	mov    %eax,%edi
ffff80000010302e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000103035:	80 ff ff 
ffff800000103038:	ff d0                	call   *%rax
ffff80000010303a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff80000010303e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103041:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103046:	ba 00 02 00 00       	mov    $0x200,%edx
ffff80000010304b:	29 c2                	sub    %eax,%edx
ffff80000010304d:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103050:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000103053:	39 c2                	cmp    %eax,%edx
ffff800000103055:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103058:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffff80000010305b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010305f:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000103066:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103069:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010306e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff800000103072:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000103075:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103079:	48 89 ce             	mov    %rcx,%rsi
ffff80000010307c:	48 89 c7             	mov    %rax,%rdi
ffff80000010307f:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff800000103086:	80 ff ff 
ffff800000103089:	ff d0                	call   *%rax
    brelse(bp);
ffff80000010308b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010308f:	48 89 c7             	mov    %rax,%rdi
ffff800000103092:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000103099:	80 ff ff 
ffff80000010309c:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff80000010309e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001030a1:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001030a4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001030a7:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001030aa:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001030ad:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001030b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001030b4:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001030b7:	0f 82 48 ff ff ff    	jb     ffff800000103005 <readi+0x110>
  }
  return n;
ffff8000001030bd:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001030c0:	c9                   	leave
ffff8000001030c1:	c3                   	ret

ffff8000001030c2 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffff8000001030c2:	55                   	push   %rbp
ffff8000001030c3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001030c6:	48 83 ec 40          	sub    $0x40,%rsp
ffff8000001030ca:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001030ce:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001030d2:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff8000001030d5:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff8000001030d8:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030dc:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001030e3:	66 83 f8 03          	cmp    $0x3,%ax
ffff8000001030e7:	0f 85 95 00 00 00    	jne    ffff800000103182 <writei+0xc0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffff8000001030ed:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030f1:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001030f8:	66 85 c0             	test   %ax,%ax
ffff8000001030fb:	78 3c                	js     ffff800000103139 <writei+0x77>
ffff8000001030fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103101:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103108:	66 83 f8 09          	cmp    $0x9,%ax
ffff80000010310c:	7f 2b                	jg     ffff800000103139 <writei+0x77>
ffff80000010310e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103112:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103119:	98                   	cwtl
ffff80000010311a:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000103121:	80 ff ff 
ffff800000103124:	48 98                	cltq
ffff800000103126:	48 c1 e0 04          	shl    $0x4,%rax
ffff80000010312a:	48 01 d0             	add    %rdx,%rax
ffff80000010312d:	48 83 c0 08          	add    $0x8,%rax
ffff800000103131:	48 8b 00             	mov    (%rax),%rax
ffff800000103134:	48 85 c0             	test   %rax,%rax
ffff800000103137:	75 0a                	jne    ffff800000103143 <writei+0x81>
      return -1;
ffff800000103139:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010313e:	e9 8d 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>
    return devsw[ip->major].write(ip, off, src, n);
ffff800000103143:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103147:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff80000010314e:	98                   	cwtl
ffff80000010314f:	48 ba 40 35 11 00 00 	movabs $0xffff800000113540,%rdx
ffff800000103156:	80 ff ff 
ffff800000103159:	48 98                	cltq
ffff80000010315b:	48 c1 e0 04          	shl    $0x4,%rax
ffff80000010315f:	48 01 d0             	add    %rdx,%rax
ffff800000103162:	48 83 c0 08          	add    $0x8,%rax
ffff800000103166:	4c 8b 00             	mov    (%rax),%r8
ffff800000103169:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff80000010316c:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000103170:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff800000103173:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103177:	48 89 c7             	mov    %rax,%rdi
ffff80000010317a:	41 ff d0             	call   *%r8
ffff80000010317d:	e9 4e 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>
  }

  if(off > ip->size || off + n < off)
ffff800000103182:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103186:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010318c:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010318f:	72 0d                	jb     ffff80000010319e <writei+0xdc>
ffff800000103191:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff800000103194:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103197:	01 d0                	add    %edx,%eax
ffff800000103199:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff80000010319c:	73 0a                	jae    ffff8000001031a8 <writei+0xe6>
    return -1;
ffff80000010319e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001031a3:	e9 28 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>
  if(off + n > MAXFILE*BSIZE)
ffff8000001031a8:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001031ab:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001031ae:	01 d0                	add    %edx,%eax
ffff8000001031b0:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffff8000001031b5:	76 0a                	jbe    ffff8000001031c1 <writei+0xff>
    return -1;
ffff8000001031b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001031bc:	e9 0f 01 00 00       	jmp    ffff8000001032d0 <writei+0x20e>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff8000001031c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001031c8:	e9 bf 00 00 00       	jmp    ffff80000010328c <writei+0x1ca>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff8000001031cd:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001031d0:	c1 e8 09             	shr    $0x9,%eax
ffff8000001031d3:	89 c2                	mov    %eax,%edx
ffff8000001031d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031d9:	89 d6                	mov    %edx,%esi
ffff8000001031db:	48 89 c7             	mov    %rax,%rdi
ffff8000001031de:	48 b8 be 2b 10 00 00 	movabs $0xffff800000102bbe,%rax
ffff8000001031e5:	80 ff ff 
ffff8000001031e8:	ff d0                	call   *%rax
ffff8000001031ea:	89 c2                	mov    %eax,%edx
ffff8000001031ec:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001031f0:	8b 00                	mov    (%rax),%eax
ffff8000001031f2:	89 d6                	mov    %edx,%esi
ffff8000001031f4:	89 c7                	mov    %eax,%edi
ffff8000001031f6:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001031fd:	80 ff ff 
ffff800000103200:	ff d0                	call   *%rax
ffff800000103202:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff800000103206:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103209:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010320e:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103213:	29 c2                	sub    %eax,%edx
ffff800000103215:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103218:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010321b:	39 c2                	cmp    %eax,%edx
ffff80000010321d:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103220:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffff800000103223:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103227:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010322e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103231:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103236:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010323a:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010323d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103241:	48 89 c6             	mov    %rax,%rsi
ffff800000103244:	48 89 cf             	mov    %rcx,%rdi
ffff800000103247:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff80000010324e:	80 ff ff 
ffff800000103251:	ff d0                	call   *%rax
    log_write(bp);
ffff800000103253:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103257:	48 89 c7             	mov    %rax,%rdi
ffff80000010325a:	48 b8 88 52 10 00 00 	movabs $0xffff800000105288,%rax
ffff800000103261:	80 ff ff 
ffff800000103264:	ff d0                	call   *%rax
    brelse(bp);
ffff800000103266:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010326a:	48 89 c7             	mov    %rax,%rdi
ffff80000010326d:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000103274:	80 ff ff 
ffff800000103277:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff800000103279:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010327c:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff80000010327f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103282:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff800000103285:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000103288:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff80000010328c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010328f:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff800000103292:	0f 82 35 ff ff ff    	jb     ffff8000001031cd <writei+0x10b>
  }

  if(n > 0 && off > ip->size){
ffff800000103298:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffff80000010329c:	74 2f                	je     ffff8000001032cd <writei+0x20b>
ffff80000010329e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032a2:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001032a8:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001032ab:	73 20                	jae    ffff8000001032cd <writei+0x20b>
    ip->size = off;
ffff8000001032ad:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032b1:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032b4:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    iupdate(ip);
ffff8000001032ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032be:	48 89 c7             	mov    %rax,%rdi
ffff8000001032c1:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff8000001032c8:	80 ff ff 
ffff8000001032cb:	ff d0                	call   *%rax
  }
  return n;
ffff8000001032cd:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001032d0:	c9                   	leave
ffff8000001032d1:	c3                   	ret

ffff8000001032d2 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffff8000001032d2:	55                   	push   %rbp
ffff8000001032d3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001032d6:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001032da:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001032de:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffff8000001032e2:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001032e6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001032ea:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001032ef:	48 89 ce             	mov    %rcx,%rsi
ffff8000001032f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001032f5:	48 b8 53 7c 10 00 00 	movabs $0xffff800000107c53,%rax
ffff8000001032fc:	80 ff ff 
ffff8000001032ff:	ff d0                	call   *%rax
}
ffff800000103301:	c9                   	leave
ffff800000103302:	c3                   	ret

ffff800000103303 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffff800000103303:	55                   	push   %rbp
ffff800000103304:	48 89 e5             	mov    %rsp,%rbp
ffff800000103307:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010330b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010330f:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103313:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffff800000103317:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010331b:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103322:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000103326:	74 19                	je     ffff800000103341 <dirlookup+0x3e>
    panic("dirlookup not DIR");
ffff800000103328:	48 b8 f5 c8 10 00 00 	movabs $0xffff80000010c8f5,%rax
ffff80000010332f:	80 ff ff 
ffff800000103332:	48 89 c7             	mov    %rax,%rdi
ffff800000103335:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010333c:	80 ff ff 
ffff80000010333f:	ff d0                	call   *%rax

  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103348:	e9 a2 00 00 00       	jmp    ffff8000001033ef <dirlookup+0xec>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010334d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103350:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103354:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103358:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010335d:	48 89 c7             	mov    %rax,%rdi
ffff800000103360:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000103367:	80 ff ff 
ffff80000010336a:	ff d0                	call   *%rax
ffff80000010336c:	83 f8 10             	cmp    $0x10,%eax
ffff80000010336f:	74 19                	je     ffff80000010338a <dirlookup+0x87>
      panic("dirlookup read");
ffff800000103371:	48 b8 07 c9 10 00 00 	movabs $0xffff80000010c907,%rax
ffff800000103378:	80 ff ff 
ffff80000010337b:	48 89 c7             	mov    %rax,%rdi
ffff80000010337e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103385:	80 ff ff 
ffff800000103388:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff80000010338a:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010338e:	66 85 c0             	test   %ax,%ax
ffff800000103391:	74 57                	je     ffff8000001033ea <dirlookup+0xe7>
      continue;
    if(namecmp(name, de.name) == 0){
ffff800000103393:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000103397:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffff80000010339b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010339f:	48 89 d6             	mov    %rdx,%rsi
ffff8000001033a2:	48 89 c7             	mov    %rax,%rdi
ffff8000001033a5:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff8000001033ac:	80 ff ff 
ffff8000001033af:	ff d0                	call   *%rax
ffff8000001033b1:	85 c0                	test   %eax,%eax
ffff8000001033b3:	75 36                	jne    ffff8000001033eb <dirlookup+0xe8>
      // entry matches path element
      if(poff)
ffff8000001033b5:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001033ba:	74 09                	je     ffff8000001033c5 <dirlookup+0xc2>
        *poff = off;
ffff8000001033bc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001033c0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001033c3:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffff8000001033c5:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001033c9:	0f b7 c0             	movzwl %ax,%eax
ffff8000001033cc:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffff8000001033cf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033d3:	8b 00                	mov    (%rax),%eax
ffff8000001033d5:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001033d8:	89 d6                	mov    %edx,%esi
ffff8000001033da:	89 c7                	mov    %eax,%edi
ffff8000001033dc:	48 b8 fa 26 10 00 00 	movabs $0xffff8000001026fa,%rax
ffff8000001033e3:	80 ff ff 
ffff8000001033e6:	ff d0                	call   *%rax
ffff8000001033e8:	eb 1d                	jmp    ffff800000103407 <dirlookup+0x104>
      continue;
ffff8000001033ea:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001033eb:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffff8000001033ef:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033f3:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001033f9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001033fc:	0f 82 4b ff ff ff    	jb     ffff80000010334d <dirlookup+0x4a>
    }
  }

  return 0;
ffff800000103402:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103407:	c9                   	leave
ffff800000103408:	c3                   	ret

ffff800000103409 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffff800000103409:	55                   	push   %rbp
ffff80000010340a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010340d:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103411:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103415:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103419:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffff80000010341c:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff800000103420:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103424:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000103429:	48 89 ce             	mov    %rcx,%rsi
ffff80000010342c:	48 89 c7             	mov    %rax,%rdi
ffff80000010342f:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff800000103436:	80 ff ff 
ffff800000103439:	ff d0                	call   *%rax
ffff80000010343b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010343f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000103444:	74 1d                	je     ffff800000103463 <dirlink+0x5a>
    iput(ip);
ffff800000103446:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010344a:	48 89 c7             	mov    %rax,%rdi
ffff80000010344d:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000103454:	80 ff ff 
ffff800000103457:	ff d0                	call   *%rax
    return -1;
ffff800000103459:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010345e:	e9 d8 00 00 00       	jmp    ffff80000010353b <dirlink+0x132>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103463:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010346a:	eb 4f                	jmp    ffff8000001034bb <dirlink+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010346c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010346f:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103473:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103477:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010347c:	48 89 c7             	mov    %rax,%rdi
ffff80000010347f:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000103486:	80 ff ff 
ffff800000103489:	ff d0                	call   *%rax
ffff80000010348b:	83 f8 10             	cmp    $0x10,%eax
ffff80000010348e:	74 19                	je     ffff8000001034a9 <dirlink+0xa0>
      panic("dirlink read");
ffff800000103490:	48 b8 16 c9 10 00 00 	movabs $0xffff80000010c916,%rax
ffff800000103497:	80 ff ff 
ffff80000010349a:	48 89 c7             	mov    %rax,%rdi
ffff80000010349d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001034a4:	80 ff ff 
ffff8000001034a7:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff8000001034a9:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034ad:	66 85 c0             	test   %ax,%ax
ffff8000001034b0:	74 1c                	je     ffff8000001034ce <dirlink+0xc5>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001034b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001034b5:	83 c0 10             	add    $0x10,%eax
ffff8000001034b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001034bb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034bf:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001034c5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034c8:	39 c2                	cmp    %eax,%edx
ffff8000001034ca:	72 a0                	jb     ffff80000010346c <dirlink+0x63>
ffff8000001034cc:	eb 01                	jmp    ffff8000001034cf <dirlink+0xc6>
      break;
ffff8000001034ce:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffff8000001034cf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001034d3:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001034d7:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffff8000001034db:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001034e0:	48 89 c6             	mov    %rax,%rsi
ffff8000001034e3:	48 89 cf             	mov    %rcx,%rdi
ffff8000001034e6:	48 b8 c0 7c 10 00 00 	movabs $0xffff800000107cc0,%rax
ffff8000001034ed:	80 ff ff 
ffff8000001034f0:	ff d0                	call   *%rax
  de.inum = inum;
ffff8000001034f2:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001034f5:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001034f9:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034fc:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103500:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103504:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103509:	48 89 c7             	mov    %rax,%rdi
ffff80000010350c:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff800000103513:	80 ff ff 
ffff800000103516:	ff d0                	call   *%rax
ffff800000103518:	83 f8 10             	cmp    $0x10,%eax
ffff80000010351b:	74 19                	je     ffff800000103536 <dirlink+0x12d>
    panic("dirlink");
ffff80000010351d:	48 b8 23 c9 10 00 00 	movabs $0xffff80000010c923,%rax
ffff800000103524:	80 ff ff 
ffff800000103527:	48 89 c7             	mov    %rax,%rdi
ffff80000010352a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103531:	80 ff ff 
ffff800000103534:	ff d0                	call   *%rax

  return 0;
ffff800000103536:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010353b:	c9                   	leave
ffff80000010353c:	c3                   	ret

ffff80000010353d <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffff80000010353d:	55                   	push   %rbp
ffff80000010353e:	48 89 e5             	mov    %rsp,%rbp
ffff800000103541:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103545:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103549:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffff80000010354d:	eb 05                	jmp    ffff800000103554 <skipelem+0x17>
    path++;
ffff80000010354f:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff800000103554:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103558:	0f b6 00             	movzbl (%rax),%eax
ffff80000010355b:	3c 2f                	cmp    $0x2f,%al
ffff80000010355d:	74 f0                	je     ffff80000010354f <skipelem+0x12>
  if(*path == 0)
ffff80000010355f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103563:	0f b6 00             	movzbl (%rax),%eax
ffff800000103566:	84 c0                	test   %al,%al
ffff800000103568:	75 0a                	jne    ffff800000103574 <skipelem+0x37>
    return 0;
ffff80000010356a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010356f:	e9 9a 00 00 00       	jmp    ffff80000010360e <skipelem+0xd1>
  s = path;
ffff800000103574:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103578:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffff80000010357c:	eb 05                	jmp    ffff800000103583 <skipelem+0x46>
    path++;
ffff80000010357e:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffff800000103583:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103587:	0f b6 00             	movzbl (%rax),%eax
ffff80000010358a:	3c 2f                	cmp    $0x2f,%al
ffff80000010358c:	74 0b                	je     ffff800000103599 <skipelem+0x5c>
ffff80000010358e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103592:	0f b6 00             	movzbl (%rax),%eax
ffff800000103595:	84 c0                	test   %al,%al
ffff800000103597:	75 e5                	jne    ffff80000010357e <skipelem+0x41>
  len = path - s;
ffff800000103599:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010359d:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffff8000001035a1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffff8000001035a4:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffff8000001035a8:	7e 21                	jle    ffff8000001035cb <skipelem+0x8e>
    memmove(name, s, DIRSIZ);
ffff8000001035aa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001035ae:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001035b2:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001035b7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001035ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001035bd:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff8000001035c4:	80 ff ff 
ffff8000001035c7:	ff d0                	call   *%rax
ffff8000001035c9:	eb 34                	jmp    ffff8000001035ff <skipelem+0xc2>
  else {
    memmove(name, s, len);
ffff8000001035cb:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001035ce:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001035d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001035d6:	48 89 ce             	mov    %rcx,%rsi
ffff8000001035d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001035dc:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff8000001035e3:	80 ff ff 
ffff8000001035e6:	ff d0                	call   *%rax
    name[len] = 0;
ffff8000001035e8:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001035eb:	48 63 d0             	movslq %eax,%rdx
ffff8000001035ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001035f2:	48 01 d0             	add    %rdx,%rax
ffff8000001035f5:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffff8000001035f8:	eb 05                	jmp    ffff8000001035ff <skipelem+0xc2>
    path++;
ffff8000001035fa:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff8000001035ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103603:	0f b6 00             	movzbl (%rax),%eax
ffff800000103606:	3c 2f                	cmp    $0x2f,%al
ffff800000103608:	74 f0                	je     ffff8000001035fa <skipelem+0xbd>
  return path;
ffff80000010360a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff80000010360e:	c9                   	leave
ffff80000010360f:	c3                   	ret

ffff800000103610 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffff800000103610:	55                   	push   %rbp
ffff800000103611:	48 89 e5             	mov    %rsp,%rbp
ffff800000103614:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000103618:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010361c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010361f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffff800000103623:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103627:	0f b6 00             	movzbl (%rax),%eax
ffff80000010362a:	3c 2f                	cmp    $0x2f,%al
ffff80000010362c:	75 1f                	jne    ffff80000010364d <namex+0x3d>
    ip = iget(ROOTDEV, ROOTINO);
ffff80000010362e:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000103633:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103638:	48 b8 fa 26 10 00 00 	movabs $0xffff8000001026fa,%rax
ffff80000010363f:	80 ff ff 
ffff800000103642:	ff d0                	call   *%rax
ffff800000103644:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103648:	e9 f7 00 00 00       	jmp    ffff800000103744 <namex+0x134>
  else
    ip = idup(proc->cwd);
ffff80000010364d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000103654:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000103658:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010365f:	48 89 c7             	mov    %rax,%rdi
ffff800000103662:	48 b8 37 28 10 00 00 	movabs $0xffff800000102837,%rax
ffff800000103669:	80 ff ff 
ffff80000010366c:	ff d0                	call   *%rax
ffff80000010366e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffff800000103672:	e9 cd 00 00 00       	jmp    ffff800000103744 <namex+0x134>
    ilock(ip);
ffff800000103677:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010367b:	48 89 c7             	mov    %rax,%rdi
ffff80000010367e:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000103685:	80 ff ff 
ffff800000103688:	ff d0                	call   *%rax
    if(ip->type != T_DIR){
ffff80000010368a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010368e:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000103695:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000103699:	74 1d                	je     ffff8000001036b8 <namex+0xa8>
      iunlockput(ip);
ffff80000010369b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010369f:	48 89 c7             	mov    %rax,%rdi
ffff8000001036a2:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001036a9:	80 ff ff 
ffff8000001036ac:	ff d0                	call   *%rax
      return 0;
ffff8000001036ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001036b3:	e9 d9 00 00 00       	jmp    ffff800000103791 <namex+0x181>
    }
    if(nameiparent && *path == '\0'){
ffff8000001036b8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff8000001036bc:	74 27                	je     ffff8000001036e5 <namex+0xd5>
ffff8000001036be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036c2:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036c5:	84 c0                	test   %al,%al
ffff8000001036c7:	75 1c                	jne    ffff8000001036e5 <namex+0xd5>
      iunlock(ip);  // Stop one level early.
ffff8000001036c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001036cd:	48 89 c7             	mov    %rax,%rdi
ffff8000001036d0:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff8000001036d7:	80 ff ff 
ffff8000001036da:	ff d0                	call   *%rax
      return ip;
ffff8000001036dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001036e0:	e9 ac 00 00 00       	jmp    ffff800000103791 <namex+0x181>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffff8000001036e5:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001036e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001036ed:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001036f2:	48 89 ce             	mov    %rcx,%rsi
ffff8000001036f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001036f8:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff8000001036ff:	80 ff ff 
ffff800000103702:	ff d0                	call   *%rax
ffff800000103704:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000103708:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010370d:	75 1a                	jne    ffff800000103729 <namex+0x119>
      iunlockput(ip);
ffff80000010370f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103713:	48 89 c7             	mov    %rax,%rdi
ffff800000103716:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff80000010371d:	80 ff ff 
ffff800000103720:	ff d0                	call   *%rax
      return 0;
ffff800000103722:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103727:	eb 68                	jmp    ffff800000103791 <namex+0x181>
    }
    iunlockput(ip);
ffff800000103729:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010372d:	48 89 c7             	mov    %rax,%rdi
ffff800000103730:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000103737:	80 ff ff 
ffff80000010373a:	ff d0                	call   *%rax
    ip = next;
ffff80000010373c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103740:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffff800000103744:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000103748:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010374c:	48 89 d6             	mov    %rdx,%rsi
ffff80000010374f:	48 89 c7             	mov    %rax,%rdi
ffff800000103752:	48 b8 3d 35 10 00 00 	movabs $0xffff80000010353d,%rax
ffff800000103759:	80 ff ff 
ffff80000010375c:	ff d0                	call   *%rax
ffff80000010375e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000103762:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103767:	0f 85 0a ff ff ff    	jne    ffff800000103677 <namex+0x67>
  }
  if(nameiparent){
ffff80000010376d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff800000103771:	74 1a                	je     ffff80000010378d <namex+0x17d>
    iput(ip);
ffff800000103773:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103777:	48 89 c7             	mov    %rax,%rdi
ffff80000010377a:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000103781:	80 ff ff 
ffff800000103784:	ff d0                	call   *%rax
    return 0;
ffff800000103786:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010378b:	eb 04                	jmp    ffff800000103791 <namex+0x181>
  }
  return ip;
ffff80000010378d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000103791:	c9                   	leave
ffff800000103792:	c3                   	ret

ffff800000103793 <namei>:

struct inode*
namei(char *path)
{
ffff800000103793:	55                   	push   %rbp
ffff800000103794:	48 89 e5             	mov    %rsp,%rbp
ffff800000103797:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010379b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffff80000010379f:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffff8000001037a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001037a7:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001037ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001037af:	48 b8 10 36 10 00 00 	movabs $0xffff800000103610,%rax
ffff8000001037b6:	80 ff ff 
ffff8000001037b9:	ff d0                	call   *%rax
}
ffff8000001037bb:	c9                   	leave
ffff8000001037bc:	c3                   	ret

ffff8000001037bd <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffff8000001037bd:	55                   	push   %rbp
ffff8000001037be:	48 89 e5             	mov    %rsp,%rbp
ffff8000001037c1:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001037c5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001037c9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffff8000001037cd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001037d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037d5:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001037da:	48 89 c7             	mov    %rax,%rdi
ffff8000001037dd:	48 b8 10 36 10 00 00 	movabs $0xffff800000103610,%rax
ffff8000001037e4:	80 ff ff 
ffff8000001037e7:	ff d0                	call   *%rax
}
ffff8000001037e9:	c9                   	leave
ffff8000001037ea:	c3                   	ret

ffff8000001037eb <inb>:
{
ffff8000001037eb:	55                   	push   %rbp
ffff8000001037ec:	48 89 e5             	mov    %rsp,%rbp
ffff8000001037ef:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001037f3:	89 f8                	mov    %edi,%eax
ffff8000001037f5:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff8000001037f9:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001037fd:	89 c2                	mov    %eax,%edx
ffff8000001037ff:	ec                   	in     (%dx),%al
ffff800000103800:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000103803:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000103807:	c9                   	leave
ffff800000103808:	c3                   	ret

ffff800000103809 <insl>:
{
ffff800000103809:	55                   	push   %rbp
ffff80000010380a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010380d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103811:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103814:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103818:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep insl" :
ffff80000010381b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010381e:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103822:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103825:	48 89 ce             	mov    %rcx,%rsi
ffff800000103828:	48 89 f7             	mov    %rsi,%rdi
ffff80000010382b:	89 c1                	mov    %eax,%ecx
ffff80000010382d:	fc                   	cld
ffff80000010382e:	f3 6d                	rep insl (%dx),(%rdi)
ffff800000103830:	89 c8                	mov    %ecx,%eax
ffff800000103832:	48 89 fe             	mov    %rdi,%rsi
ffff800000103835:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103839:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffff80000010383c:	90                   	nop
ffff80000010383d:	c9                   	leave
ffff80000010383e:	c3                   	ret

ffff80000010383f <outb>:
{
ffff80000010383f:	55                   	push   %rbp
ffff800000103840:	48 89 e5             	mov    %rsp,%rbp
ffff800000103843:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103847:	89 fa                	mov    %edi,%edx
ffff800000103849:	89 f0                	mov    %esi,%eax
ffff80000010384b:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010384f:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000103852:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000103856:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010385a:	ee                   	out    %al,(%dx)
}
ffff80000010385b:	90                   	nop
ffff80000010385c:	c9                   	leave
ffff80000010385d:	c3                   	ret

ffff80000010385e <outsl>:
{
ffff80000010385e:	55                   	push   %rbp
ffff80000010385f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103862:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103866:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103869:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff80000010386d:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep outsl" :
ffff800000103870:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103873:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000103877:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010387a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010387d:	89 c1                	mov    %eax,%ecx
ffff80000010387f:	fc                   	cld
ffff800000103880:	f3 6f                	rep outsl (%rsi),(%dx)
ffff800000103882:	89 c8                	mov    %ecx,%eax
ffff800000103884:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103888:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffff80000010388b:	90                   	nop
ffff80000010388c:	c9                   	leave
ffff80000010388d:	c3                   	ret

ffff80000010388e <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffff80000010388e:	55                   	push   %rbp
ffff80000010388f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103892:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000103896:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
ffff800000103899:	90                   	nop
ffff80000010389a:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff80000010389f:	48 b8 eb 37 10 00 00 	movabs $0xffff8000001037eb,%rax
ffff8000001038a6:	80 ff ff 
ffff8000001038a9:	ff d0                	call   *%rax
ffff8000001038ab:	0f b6 c0             	movzbl %al,%eax
ffff8000001038ae:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001038b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001038b4:	25 c0 00 00 00       	and    $0xc0,%eax
ffff8000001038b9:	83 f8 40             	cmp    $0x40,%eax
ffff8000001038bc:	75 dc                	jne    ffff80000010389a <idewait+0xc>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffff8000001038be:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff8000001038c2:	74 11                	je     ffff8000001038d5 <idewait+0x47>
ffff8000001038c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001038c7:	83 e0 21             	and    $0x21,%eax
ffff8000001038ca:	85 c0                	test   %eax,%eax
ffff8000001038cc:	74 07                	je     ffff8000001038d5 <idewait+0x47>
    return -1;
ffff8000001038ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001038d3:	eb 05                	jmp    ffff8000001038da <idewait+0x4c>
  return 0;
ffff8000001038d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001038da:	c9                   	leave
ffff8000001038db:	c3                   	ret

ffff8000001038dc <ideinit>:

void
ideinit(void)
{
ffff8000001038dc:	55                   	push   %rbp
ffff8000001038dd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038e0:	48 83 ec 10          	sub    $0x10,%rsp
  initlock(&idelock, "ide");
ffff8000001038e4:	48 ba 2b c9 10 00 00 	movabs $0xffff80000010c92b,%rdx
ffff8000001038eb:	80 ff ff 
ffff8000001038ee:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff8000001038f5:	80 ff ff 
ffff8000001038f8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001038fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001038fe:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000103905:	80 ff ff 
ffff800000103908:	ff d0                	call   *%rax
  ioapicenable(IRQ_IDE, ncpu - 1);
ffff80000010390a:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000103911:	80 ff ff 
ffff800000103914:	8b 00                	mov    (%rax),%eax
ffff800000103916:	83 e8 01             	sub    $0x1,%eax
ffff800000103919:	89 c6                	mov    %eax,%esi
ffff80000010391b:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff800000103920:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff800000103927:	80 ff ff 
ffff80000010392a:	ff d0                	call   *%rax
  idewait(0);
ffff80000010392c:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103931:	48 b8 8e 38 10 00 00 	movabs $0xffff80000010388e,%rax
ffff800000103938:	80 ff ff 
ffff80000010393b:	ff d0                	call   *%rax

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffff80000010393d:	be f0 00 00 00       	mov    $0xf0,%esi
ffff800000103942:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103947:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff80000010394e:	80 ff ff 
ffff800000103951:	ff d0                	call   *%rax
  for(int i=0; i<1000; i++){
ffff800000103953:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010395a:	eb 2b                	jmp    ffff800000103987 <ideinit+0xab>
    if(inb(0x1f7) != 0){
ffff80000010395c:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103961:	48 b8 eb 37 10 00 00 	movabs $0xffff8000001037eb,%rax
ffff800000103968:	80 ff ff 
ffff80000010396b:	ff d0                	call   *%rax
ffff80000010396d:	84 c0                	test   %al,%al
ffff80000010396f:	74 12                	je     ffff800000103983 <ideinit+0xa7>
      havedisk1 = 1;
ffff800000103971:	48 b8 30 71 11 00 00 	movabs $0xffff800000117130,%rax
ffff800000103978:	80 ff ff 
ffff80000010397b:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      break;
ffff800000103981:	eb 0d                	jmp    ffff800000103990 <ideinit+0xb4>
  for(int i=0; i<1000; i++){
ffff800000103983:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103987:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffff80000010398e:	7e cc                	jle    ffff80000010395c <ideinit+0x80>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffff800000103990:	be e0 00 00 00       	mov    $0xe0,%esi
ffff800000103995:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff80000010399a:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff8000001039a1:	80 ff ff 
ffff8000001039a4:	ff d0                	call   *%rax
}
ffff8000001039a6:	90                   	nop
ffff8000001039a7:	c9                   	leave
ffff8000001039a8:	c3                   	ret

ffff8000001039a9 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffff8000001039a9:	55                   	push   %rbp
ffff8000001039aa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039ad:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001039b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  if(b == 0)
ffff8000001039b5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001039ba:	75 19                	jne    ffff8000001039d5 <idestart+0x2c>
    panic("idestart");
ffff8000001039bc:	48 b8 2f c9 10 00 00 	movabs $0xffff80000010c92f,%rax
ffff8000001039c3:	80 ff ff 
ffff8000001039c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001039c9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001039d0:	80 ff ff 
ffff8000001039d3:	ff d0                	call   *%rax
  if(b->blockno >= FSSIZE)
ffff8000001039d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001039d9:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001039dc:	3d e7 03 00 00       	cmp    $0x3e7,%eax
ffff8000001039e1:	76 19                	jbe    ffff8000001039fc <idestart+0x53>
    panic("incorrect blockno");
ffff8000001039e3:	48 b8 38 c9 10 00 00 	movabs $0xffff80000010c938,%rax
ffff8000001039ea:	80 ff ff 
ffff8000001039ed:	48 89 c7             	mov    %rax,%rdi
ffff8000001039f0:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001039f7:	80 ff ff 
ffff8000001039fa:	ff d0                	call   *%rax
  int sector_per_block =  BSIZE/SECTOR_SIZE;
ffff8000001039fc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
  int sector = b->blockno * sector_per_block;
ffff800000103a03:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103a07:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000103a0a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103a0d:	0f af c2             	imul   %edx,%eax
ffff800000103a10:	89 45 f0             	mov    %eax,-0x10(%rbp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
ffff800000103a13:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103a17:	75 09                	jne    ffff800000103a22 <idestart+0x79>
ffff800000103a19:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff800000103a20:	eb 07                	jmp    ffff800000103a29 <idestart+0x80>
ffff800000103a22:	c7 45 fc c4 00 00 00 	movl   $0xc4,-0x4(%rbp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
ffff800000103a29:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103a2d:	75 09                	jne    ffff800000103a38 <idestart+0x8f>
ffff800000103a2f:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
ffff800000103a36:	eb 07                	jmp    ffff800000103a3f <idestart+0x96>
ffff800000103a38:	c7 45 f8 c5 00 00 00 	movl   $0xc5,-0x8(%rbp)

  if (sector_per_block > 7) panic("idestart");
ffff800000103a3f:	83 7d f4 07          	cmpl   $0x7,-0xc(%rbp)
ffff800000103a43:	7e 19                	jle    ffff800000103a5e <idestart+0xb5>
ffff800000103a45:	48 b8 2f c9 10 00 00 	movabs $0xffff80000010c92f,%rax
ffff800000103a4c:	80 ff ff 
ffff800000103a4f:	48 89 c7             	mov    %rax,%rdi
ffff800000103a52:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103a59:	80 ff ff 
ffff800000103a5c:	ff d0                	call   *%rax

  idewait(0);
ffff800000103a5e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103a63:	48 b8 8e 38 10 00 00 	movabs $0xffff80000010388e,%rax
ffff800000103a6a:	80 ff ff 
ffff800000103a6d:	ff d0                	call   *%rax
  outb(0x3f6, 0);  // generate interrupt
ffff800000103a6f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103a74:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffff800000103a79:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103a80:	80 ff ff 
ffff800000103a83:	ff d0                	call   *%rax
  outb(0x1f2, sector_per_block);  // number of sectors
ffff800000103a85:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103a88:	0f b6 c0             	movzbl %al,%eax
ffff800000103a8b:	89 c6                	mov    %eax,%esi
ffff800000103a8d:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffff800000103a92:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103a99:	80 ff ff 
ffff800000103a9c:	ff d0                	call   *%rax
  outb(0x1f3, sector & 0xff);
ffff800000103a9e:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103aa1:	0f b6 c0             	movzbl %al,%eax
ffff800000103aa4:	89 c6                	mov    %eax,%esi
ffff800000103aa6:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffff800000103aab:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103ab2:	80 ff ff 
ffff800000103ab5:	ff d0                	call   *%rax
  outb(0x1f4, (sector >> 8) & 0xff);
ffff800000103ab7:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103aba:	c1 f8 08             	sar    $0x8,%eax
ffff800000103abd:	0f b6 c0             	movzbl %al,%eax
ffff800000103ac0:	89 c6                	mov    %eax,%esi
ffff800000103ac2:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffff800000103ac7:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103ace:	80 ff ff 
ffff800000103ad1:	ff d0                	call   *%rax
  outb(0x1f5, (sector >> 16) & 0xff);
ffff800000103ad3:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103ad6:	c1 f8 10             	sar    $0x10,%eax
ffff800000103ad9:	0f b6 c0             	movzbl %al,%eax
ffff800000103adc:	89 c6                	mov    %eax,%esi
ffff800000103ade:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffff800000103ae3:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103aea:	80 ff ff 
ffff800000103aed:	ff d0                	call   *%rax
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
ffff800000103aef:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103af3:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103af6:	c1 e0 04             	shl    $0x4,%eax
ffff800000103af9:	83 e0 10             	and    $0x10,%eax
ffff800000103afc:	89 c2                	mov    %eax,%edx
ffff800000103afe:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103b01:	c1 f8 18             	sar    $0x18,%eax
ffff800000103b04:	83 e0 0f             	and    $0xf,%eax
ffff800000103b07:	09 d0                	or     %edx,%eax
ffff800000103b09:	83 c8 e0             	or     $0xffffffe0,%eax
ffff800000103b0c:	0f b6 c0             	movzbl %al,%eax
ffff800000103b0f:	89 c6                	mov    %eax,%esi
ffff800000103b11:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103b16:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103b1d:	80 ff ff 
ffff800000103b20:	ff d0                	call   *%rax
  if(b->flags & B_DIRTY){
ffff800000103b22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b26:	8b 00                	mov    (%rax),%eax
ffff800000103b28:	83 e0 04             	and    $0x4,%eax
ffff800000103b2b:	85 c0                	test   %eax,%eax
ffff800000103b2d:	74 3e                	je     ffff800000103b6d <idestart+0x1c4>
    outb(0x1f7, write_cmd);
ffff800000103b2f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103b32:	0f b6 c0             	movzbl %al,%eax
ffff800000103b35:	89 c6                	mov    %eax,%esi
ffff800000103b37:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103b3c:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103b43:	80 ff ff 
ffff800000103b46:	ff d0                	call   *%rax
    outsl(0x1f0, b->data, BSIZE/4);
ffff800000103b48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b4c:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103b52:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103b57:	48 89 c6             	mov    %rax,%rsi
ffff800000103b5a:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103b5f:	48 b8 5e 38 10 00 00 	movabs $0xffff80000010385e,%rax
ffff800000103b66:	80 ff ff 
ffff800000103b69:	ff d0                	call   *%rax
  } else {
    outb(0x1f7, read_cmd);
  }
}
ffff800000103b6b:	eb 19                	jmp    ffff800000103b86 <idestart+0x1dd>
    outb(0x1f7, read_cmd);
ffff800000103b6d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103b70:	0f b6 c0             	movzbl %al,%eax
ffff800000103b73:	89 c6                	mov    %eax,%esi
ffff800000103b75:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103b7a:	48 b8 3f 38 10 00 00 	movabs $0xffff80000010383f,%rax
ffff800000103b81:	80 ff ff 
ffff800000103b84:	ff d0                	call   *%rax
}
ffff800000103b86:	90                   	nop
ffff800000103b87:	c9                   	leave
ffff800000103b88:	c3                   	ret

ffff800000103b89 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffff800000103b89:	55                   	push   %rbp
ffff800000103b8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000103b8d:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffff800000103b91:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103b98:	80 ff ff 
ffff800000103b9b:	48 89 c7             	mov    %rax,%rdi
ffff800000103b9e:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000103ba5:	80 ff ff 
ffff800000103ba8:	ff d0                	call   *%rax
  if((b = idequeue) == 0){
ffff800000103baa:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103bb1:	80 ff ff 
ffff800000103bb4:	48 8b 00             	mov    (%rax),%rax
ffff800000103bb7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103bbb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000103bc0:	75 1e                	jne    ffff800000103be0 <ideintr+0x57>
    release(&idelock);
ffff800000103bc2:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103bc9:	80 ff ff 
ffff800000103bcc:	48 89 c7             	mov    %rax,%rdi
ffff800000103bcf:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000103bd6:	80 ff ff 
ffff800000103bd9:	ff d0                	call   *%rax
    // cprintf("spurious IDE interrupt\n");
    return;
ffff800000103bdb:	e9 d9 00 00 00       	jmp    ffff800000103cb9 <ideintr+0x130>
  }
  idequeue = b->qnext;
ffff800000103be0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103be4:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
ffff800000103beb:	48 ba 28 71 11 00 00 	movabs $0xffff800000117128,%rdx
ffff800000103bf2:	80 ff ff 
ffff800000103bf5:	48 89 02             	mov    %rax,(%rdx)

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffff800000103bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103bfc:	8b 00                	mov    (%rax),%eax
ffff800000103bfe:	83 e0 04             	and    $0x4,%eax
ffff800000103c01:	85 c0                	test   %eax,%eax
ffff800000103c03:	75 38                	jne    ffff800000103c3d <ideintr+0xb4>
ffff800000103c05:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103c0a:	48 b8 8e 38 10 00 00 	movabs $0xffff80000010388e,%rax
ffff800000103c11:	80 ff ff 
ffff800000103c14:	ff d0                	call   *%rax
ffff800000103c16:	85 c0                	test   %eax,%eax
ffff800000103c18:	78 23                	js     ffff800000103c3d <ideintr+0xb4>
    insl(0x1f0, b->data, BSIZE/4);
ffff800000103c1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c1e:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103c24:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103c29:	48 89 c6             	mov    %rax,%rsi
ffff800000103c2c:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103c31:	48 b8 09 38 10 00 00 	movabs $0xffff800000103809,%rax
ffff800000103c38:	80 ff ff 
ffff800000103c3b:	ff d0                	call   *%rax

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffff800000103c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c41:	8b 00                	mov    (%rax),%eax
ffff800000103c43:	83 c8 02             	or     $0x2,%eax
ffff800000103c46:	89 c2                	mov    %eax,%edx
ffff800000103c48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c4c:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffff800000103c4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c52:	8b 00                	mov    (%rax),%eax
ffff800000103c54:	83 e0 fb             	and    $0xfffffffb,%eax
ffff800000103c57:	89 c2                	mov    %eax,%edx
ffff800000103c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c5d:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffff800000103c5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103c63:	48 89 c7             	mov    %rax,%rdi
ffff800000103c66:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000103c6d:	80 ff ff 
ffff800000103c70:	ff d0                	call   *%rax

  // Start disk on next buf in queue.
  if(idequeue != 0)
ffff800000103c72:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103c79:	80 ff ff 
ffff800000103c7c:	48 8b 00             	mov    (%rax),%rax
ffff800000103c7f:	48 85 c0             	test   %rax,%rax
ffff800000103c82:	74 1c                	je     ffff800000103ca0 <ideintr+0x117>
    idestart(idequeue);
ffff800000103c84:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103c8b:	80 ff ff 
ffff800000103c8e:	48 8b 00             	mov    (%rax),%rax
ffff800000103c91:	48 89 c7             	mov    %rax,%rdi
ffff800000103c94:	48 b8 a9 39 10 00 00 	movabs $0xffff8000001039a9,%rax
ffff800000103c9b:	80 ff ff 
ffff800000103c9e:	ff d0                	call   *%rax

  release(&idelock);
ffff800000103ca0:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103ca7:	80 ff ff 
ffff800000103caa:	48 89 c7             	mov    %rax,%rdi
ffff800000103cad:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000103cb4:	80 ff ff 
ffff800000103cb7:	ff d0                	call   *%rax
}
ffff800000103cb9:	c9                   	leave
ffff800000103cba:	c3                   	ret

ffff800000103cbb <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffff800000103cbb:	55                   	push   %rbp
ffff800000103cbc:	48 89 e5             	mov    %rsp,%rbp
ffff800000103cbf:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103cc3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!holdingsleep(&b->lock))
ffff800000103cc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103ccb:	48 83 c0 10          	add    $0x10,%rax
ffff800000103ccf:	48 89 c7             	mov    %rax,%rdi
ffff800000103cd2:	48 b8 1d 76 10 00 00 	movabs $0xffff80000010761d,%rax
ffff800000103cd9:	80 ff ff 
ffff800000103cdc:	ff d0                	call   *%rax
ffff800000103cde:	85 c0                	test   %eax,%eax
ffff800000103ce0:	75 19                	jne    ffff800000103cfb <iderw+0x40>
    panic("iderw: buf not locked");
ffff800000103ce2:	48 b8 4a c9 10 00 00 	movabs $0xffff80000010c94a,%rax
ffff800000103ce9:	80 ff ff 
ffff800000103cec:	48 89 c7             	mov    %rax,%rdi
ffff800000103cef:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103cf6:	80 ff ff 
ffff800000103cf9:	ff d0                	call   *%rax
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffff800000103cfb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103cff:	8b 00                	mov    (%rax),%eax
ffff800000103d01:	83 e0 06             	and    $0x6,%eax
ffff800000103d04:	83 f8 02             	cmp    $0x2,%eax
ffff800000103d07:	75 19                	jne    ffff800000103d22 <iderw+0x67>
    panic("iderw: nothing to do");
ffff800000103d09:	48 b8 60 c9 10 00 00 	movabs $0xffff80000010c960,%rax
ffff800000103d10:	80 ff ff 
ffff800000103d13:	48 89 c7             	mov    %rax,%rdi
ffff800000103d16:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103d1d:	80 ff ff 
ffff800000103d20:	ff d0                	call   *%rax
  if(b->dev != 0 && !havedisk1)
ffff800000103d22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103d26:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103d29:	85 c0                	test   %eax,%eax
ffff800000103d2b:	74 29                	je     ffff800000103d56 <iderw+0x9b>
ffff800000103d2d:	48 b8 30 71 11 00 00 	movabs $0xffff800000117130,%rax
ffff800000103d34:	80 ff ff 
ffff800000103d37:	8b 00                	mov    (%rax),%eax
ffff800000103d39:	85 c0                	test   %eax,%eax
ffff800000103d3b:	75 19                	jne    ffff800000103d56 <iderw+0x9b>
    panic("iderw: ide disk 1 not present");
ffff800000103d3d:	48 b8 75 c9 10 00 00 	movabs $0xffff80000010c975,%rax
ffff800000103d44:	80 ff ff 
ffff800000103d47:	48 89 c7             	mov    %rax,%rdi
ffff800000103d4a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103d51:	80 ff ff 
ffff800000103d54:	ff d0                	call   *%rax

  acquire(&idelock);  //DOC:acquire-lock
ffff800000103d56:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103d5d:	80 ff ff 
ffff800000103d60:	48 89 c7             	mov    %rax,%rdi
ffff800000103d63:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000103d6a:	80 ff ff 
ffff800000103d6d:	ff d0                	call   *%rax

  // Append b to idequeue.
  b->qnext = 0;
ffff800000103d6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103d73:	48 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%rax)
ffff800000103d7a:	00 00 00 00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffff800000103d7e:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103d85:	80 ff ff 
ffff800000103d88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103d8c:	eb 11                	jmp    ffff800000103d9f <iderw+0xe4>
ffff800000103d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d92:	48 8b 00             	mov    (%rax),%rax
ffff800000103d95:	48 05 a8 00 00 00    	add    $0xa8,%rax
ffff800000103d9b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103d9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103da3:	48 8b 00             	mov    (%rax),%rax
ffff800000103da6:	48 85 c0             	test   %rax,%rax
ffff800000103da9:	75 e3                	jne    ffff800000103d8e <iderw+0xd3>
    ;
  *pp = b;
ffff800000103dab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103daf:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000103db3:	48 89 10             	mov    %rdx,(%rax)

  // Start disk if necessary.
  if(idequeue == b)
ffff800000103db6:	48 b8 28 71 11 00 00 	movabs $0xffff800000117128,%rax
ffff800000103dbd:	80 ff ff 
ffff800000103dc0:	48 8b 00             	mov    (%rax),%rax
ffff800000103dc3:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000103dc7:	75 35                	jne    ffff800000103dfe <iderw+0x143>
    idestart(b);
ffff800000103dc9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103dcd:	48 89 c7             	mov    %rax,%rdi
ffff800000103dd0:	48 b8 a9 39 10 00 00 	movabs $0xffff8000001039a9,%rax
ffff800000103dd7:	80 ff ff 
ffff800000103dda:	ff d0                	call   *%rax

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103ddc:	eb 20                	jmp    ffff800000103dfe <iderw+0x143>
    sleep(b, &idelock);
ffff800000103dde:	48 ba c0 70 11 00 00 	movabs $0xffff8000001170c0,%rdx
ffff800000103de5:	80 ff ff 
ffff800000103de8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103dec:	48 89 d6             	mov    %rdx,%rsi
ffff800000103def:	48 89 c7             	mov    %rax,%rdi
ffff800000103df2:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000103df9:	80 ff ff 
ffff800000103dfc:	ff d0                	call   *%rax
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103dfe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e02:	8b 00                	mov    (%rax),%eax
ffff800000103e04:	83 e0 06             	and    $0x6,%eax
ffff800000103e07:	83 f8 02             	cmp    $0x2,%eax
ffff800000103e0a:	75 d2                	jne    ffff800000103dde <iderw+0x123>
  }

  release(&idelock);
ffff800000103e0c:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103e13:	80 ff ff 
ffff800000103e16:	48 89 c7             	mov    %rax,%rdi
ffff800000103e19:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000103e20:	80 ff ff 
ffff800000103e23:	ff d0                	call   *%rax
}
ffff800000103e25:	90                   	nop
ffff800000103e26:	c9                   	leave
ffff800000103e27:	c3                   	ret

ffff800000103e28 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffff800000103e28:	55                   	push   %rbp
ffff800000103e29:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e2c:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103e30:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffff800000103e33:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e3a:	80 ff ff 
ffff800000103e3d:	48 8b 00             	mov    (%rax),%rax
ffff800000103e40:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103e43:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffff800000103e45:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e4c:	80 ff ff 
ffff800000103e4f:	48 8b 00             	mov    (%rax),%rax
ffff800000103e52:	8b 40 10             	mov    0x10(%rax),%eax
}
ffff800000103e55:	c9                   	leave
ffff800000103e56:	c3                   	ret

ffff800000103e57 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffff800000103e57:	55                   	push   %rbp
ffff800000103e58:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e5b:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103e5f:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103e62:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffff800000103e65:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e6c:	80 ff ff 
ffff800000103e6f:	48 8b 00             	mov    (%rax),%rax
ffff800000103e72:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103e75:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffff800000103e77:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e7e:	80 ff ff 
ffff800000103e81:	48 8b 00             	mov    (%rax),%rax
ffff800000103e84:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103e87:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000103e8a:	90                   	nop
ffff800000103e8b:	c9                   	leave
ffff800000103e8c:	c3                   	ret

ffff800000103e8d <ioapicinit>:

void
ioapicinit(void)
{
ffff800000103e8d:	55                   	push   %rbp
ffff800000103e8e:	48 89 e5             	mov    %rsp,%rbp
ffff800000103e91:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  ioapic = P2V((volatile struct ioapic*)IOAPIC);
ffff800000103e95:	48 b8 38 71 11 00 00 	movabs $0xffff800000117138,%rax
ffff800000103e9c:	80 ff ff 
ffff800000103e9f:	48 b9 00 00 c0 fe 00 	movabs $0xffff8000fec00000,%rcx
ffff800000103ea6:	80 ff ff 
ffff800000103ea9:	48 89 08             	mov    %rcx,(%rax)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffff800000103eac:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103eb1:	48 b8 28 3e 10 00 00 	movabs $0xffff800000103e28,%rax
ffff800000103eb8:	80 ff ff 
ffff800000103ebb:	ff d0                	call   *%rax
ffff800000103ebd:	c1 e8 10             	shr    $0x10,%eax
ffff800000103ec0:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000103ec5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffff800000103ec8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103ecd:	48 b8 28 3e 10 00 00 	movabs $0xffff800000103e28,%rax
ffff800000103ed4:	80 ff ff 
ffff800000103ed7:	ff d0                	call   *%rax
ffff800000103ed9:	c1 e8 18             	shr    $0x18,%eax
ffff800000103edc:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffff800000103edf:	48 b8 24 74 11 00 00 	movabs $0xffff800000117424,%rax
ffff800000103ee6:	80 ff ff 
ffff800000103ee9:	0f b6 00             	movzbl (%rax),%eax
ffff800000103eec:	0f b6 c0             	movzbl %al,%eax
ffff800000103eef:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffff800000103ef2:	74 1e                	je     ffff800000103f12 <ioapicinit+0x85>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffff800000103ef4:	48 b8 98 c9 10 00 00 	movabs $0xffff80000010c998,%rax
ffff800000103efb:	80 ff ff 
ffff800000103efe:	48 89 c7             	mov    %rax,%rdi
ffff800000103f01:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103f06:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000103f0d:	80 ff ff 
ffff800000103f10:	ff d2                	call   *%rdx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffff800000103f12:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103f19:	eb 47                	jmp    ffff800000103f62 <ioapicinit+0xd5>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffff800000103f1b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f1e:	83 c0 20             	add    $0x20,%eax
ffff800000103f21:	0d 00 00 01 00       	or     $0x10000,%eax
ffff800000103f26:	89 c2                	mov    %eax,%edx
ffff800000103f28:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f2b:	83 c0 08             	add    $0x8,%eax
ffff800000103f2e:	01 c0                	add    %eax,%eax
ffff800000103f30:	89 d6                	mov    %edx,%esi
ffff800000103f32:	89 c7                	mov    %eax,%edi
ffff800000103f34:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103f3b:	80 ff ff 
ffff800000103f3e:	ff d0                	call   *%rax
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffff800000103f40:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f43:	83 c0 08             	add    $0x8,%eax
ffff800000103f46:	01 c0                	add    %eax,%eax
ffff800000103f48:	83 c0 01             	add    $0x1,%eax
ffff800000103f4b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103f50:	89 c7                	mov    %eax,%edi
ffff800000103f52:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103f59:	80 ff ff 
ffff800000103f5c:	ff d0                	call   *%rax
  for(i = 0; i <= maxintr; i++){
ffff800000103f5e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103f62:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f65:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000103f68:	7e b1                	jle    ffff800000103f1b <ioapicinit+0x8e>
  }
}
ffff800000103f6a:	90                   	nop
ffff800000103f6b:	90                   	nop
ffff800000103f6c:	c9                   	leave
ffff800000103f6d:	c3                   	ret

ffff800000103f6e <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffff800000103f6e:	55                   	push   %rbp
ffff800000103f6f:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f72:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f76:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103f79:	89 75 f8             	mov    %esi,-0x8(%rbp)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffff800000103f7c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f7f:	83 c0 20             	add    $0x20,%eax
ffff800000103f82:	89 c2                	mov    %eax,%edx
ffff800000103f84:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103f87:	83 c0 08             	add    $0x8,%eax
ffff800000103f8a:	01 c0                	add    %eax,%eax
ffff800000103f8c:	89 d6                	mov    %edx,%esi
ffff800000103f8e:	89 c7                	mov    %eax,%edi
ffff800000103f90:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103f97:	80 ff ff 
ffff800000103f9a:	ff d0                	call   *%rax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffff800000103f9c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103f9f:	c1 e0 18             	shl    $0x18,%eax
ffff800000103fa2:	89 c2                	mov    %eax,%edx
ffff800000103fa4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103fa7:	83 c0 08             	add    $0x8,%eax
ffff800000103faa:	01 c0                	add    %eax,%eax
ffff800000103fac:	83 c0 01             	add    $0x1,%eax
ffff800000103faf:	89 d6                	mov    %edx,%esi
ffff800000103fb1:	89 c7                	mov    %eax,%edi
ffff800000103fb3:	48 b8 57 3e 10 00 00 	movabs $0xffff800000103e57,%rax
ffff800000103fba:	80 ff ff 
ffff800000103fbd:	ff d0                	call   *%rax
}
ffff800000103fbf:	90                   	nop
ffff800000103fc0:	c9                   	leave
ffff800000103fc1:	c3                   	ret

ffff800000103fc2 <kinit1>:
  struct run *freelist;
} kmem;

void
kinit1(void *vstart, void *vend)
{
ffff800000103fc2:	55                   	push   %rbp
ffff800000103fc3:	48 89 e5             	mov    %rsp,%rbp
ffff800000103fc6:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103fca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000103fce:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffff800000103fd2:	48 ba ca c9 10 00 00 	movabs $0xffff80000010c9ca,%rdx
ffff800000103fd9:	80 ff ff 
ffff800000103fdc:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000103fe3:	80 ff ff 
ffff800000103fe6:	48 89 d6             	mov    %rdx,%rsi
ffff800000103fe9:	48 89 c7             	mov    %rax,%rdi
ffff800000103fec:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000103ff3:	80 ff ff 
ffff800000103ff6:	ff d0                	call   *%rax
  kmem.use_lock = 0;
ffff800000103ff8:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000103fff:	80 ff ff 
ffff800000104002:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  kmem.freelist = 0; // empty
ffff800000104009:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104010:	80 ff ff 
ffff800000104013:	48 c7 40 70 00 00 00 	movq   $0x0,0x70(%rax)
ffff80000010401a:	00 
  freerange(vstart, vend);
ffff80000010401b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010401f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104023:	48 89 d6             	mov    %rdx,%rsi
ffff800000104026:	48 89 c7             	mov    %rax,%rdi
ffff800000104029:	48 b8 50 40 10 00 00 	movabs $0xffff800000104050,%rax
ffff800000104030:	80 ff ff 
ffff800000104033:	ff d0                	call   *%rax
}
ffff800000104035:	90                   	nop
ffff800000104036:	c9                   	leave
ffff800000104037:	c3                   	ret

ffff800000104038 <kinit2>:

void
kinit2()
{
ffff800000104038:	55                   	push   %rbp
ffff800000104039:	48 89 e5             	mov    %rsp,%rbp
  kmem.use_lock = 1;
ffff80000010403c:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104043:	80 ff ff 
ffff800000104046:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
}
ffff80000010404d:	90                   	nop
ffff80000010404e:	5d                   	pop    %rbp
ffff80000010404f:	c3                   	ret

ffff800000104050 <freerange>:

void
freerange(void *vstart, void *vend)
{
ffff800000104050:	55                   	push   %rbp
ffff800000104051:	48 89 e5             	mov    %rsp,%rbp
ffff800000104054:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104058:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010405c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((addr_t)vstart);
ffff800000104060:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104064:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010406a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000104070:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff800000104074:	eb 1b                	jmp    ffff800000104091 <freerange+0x41>
    kfree(p);
ffff800000104076:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010407a:	48 89 c7             	mov    %rax,%rdi
ffff80000010407d:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000104084:	80 ff ff 
ffff800000104087:	ff d0                	call   *%rax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff800000104089:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff800000104090:	00 
ffff800000104091:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104095:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010409b:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffff80000010409f:	73 d5                	jae    ffff800000104076 <freerange+0x26>
}
ffff8000001040a1:	90                   	nop
ffff8000001040a2:	90                   	nop
ffff8000001040a3:	c9                   	leave
ffff8000001040a4:	c3                   	ret

ffff8000001040a5 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffff8000001040a5:	55                   	push   %rbp
ffff8000001040a6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001040a9:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001040ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((addr_t)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
ffff8000001040b1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001040b5:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff8000001040ba:	48 85 c0             	test   %rax,%rax
ffff8000001040bd:	75 29                	jne    ffff8000001040e8 <kfree+0x43>
ffff8000001040bf:	48 b8 00 10 12 00 00 	movabs $0xffff800000121000,%rax
ffff8000001040c6:	80 ff ff 
ffff8000001040c9:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001040cd:	72 19                	jb     ffff8000001040e8 <kfree+0x43>
ffff8000001040cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001040d3:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001040da:	80 00 00 
ffff8000001040dd:	48 01 d0             	add    %rdx,%rax
ffff8000001040e0:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffff8000001040e6:	76 19                	jbe    ffff800000104101 <kfree+0x5c>
    panic("kfree");
ffff8000001040e8:	48 b8 cf c9 10 00 00 	movabs $0xffff80000010c9cf,%rax
ffff8000001040ef:	80 ff ff 
ffff8000001040f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001040f5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001040fc:	80 ff ff 
ffff8000001040ff:	ff d0                	call   *%rax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffff800000104101:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104105:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010410a:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010410f:	48 89 c7             	mov    %rax,%rdi
ffff800000104112:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000104119:	80 ff ff 
ffff80000010411c:	ff d0                	call   *%rax

  if(kmem.use_lock)
ffff80000010411e:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104125:	80 ff ff 
ffff800000104128:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010412b:	85 c0                	test   %eax,%eax
ffff80000010412d:	74 19                	je     ffff800000104148 <kfree+0xa3>
    acquire(&kmem.lock);
ffff80000010412f:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104136:	80 ff ff 
ffff800000104139:	48 89 c7             	mov    %rax,%rdi
ffff80000010413c:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000104143:	80 ff ff 
ffff800000104146:	ff d0                	call   *%rax
  r = (struct run*)v;
ffff800000104148:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010414c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffff800000104150:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104157:	80 ff ff 
ffff80000010415a:	48 8b 50 70          	mov    0x70(%rax),%rdx
ffff80000010415e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104162:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffff800000104165:	48 ba 40 71 11 00 00 	movabs $0xffff800000117140,%rdx
ffff80000010416c:	80 ff ff 
ffff80000010416f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104173:	48 89 42 70          	mov    %rax,0x70(%rdx)
  if(kmem.use_lock)
ffff800000104177:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010417e:	80 ff ff 
ffff800000104181:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104184:	85 c0                	test   %eax,%eax
ffff800000104186:	74 19                	je     ffff8000001041a1 <kfree+0xfc>
    release(&kmem.lock);
ffff800000104188:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010418f:	80 ff ff 
ffff800000104192:	48 89 c7             	mov    %rax,%rdi
ffff800000104195:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010419c:	80 ff ff 
ffff80000010419f:	ff d0                	call   *%rax
}
ffff8000001041a1:	90                   	nop
ffff8000001041a2:	c9                   	leave
ffff8000001041a3:	c3                   	ret

ffff8000001041a4 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffff8000001041a4:	55                   	push   %rbp
ffff8000001041a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001041a8:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffff8000001041ac:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001041b3:	80 ff ff 
ffff8000001041b6:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001041b9:	85 c0                	test   %eax,%eax
ffff8000001041bb:	74 19                	je     ffff8000001041d6 <kalloc+0x32>
    acquire(&kmem.lock);
ffff8000001041bd:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001041c4:	80 ff ff 
ffff8000001041c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001041ca:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001041d1:	80 ff ff 
ffff8000001041d4:	ff d0                	call   *%rax
  r = kmem.freelist;
ffff8000001041d6:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff8000001041dd:	80 ff ff 
ffff8000001041e0:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff8000001041e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffff8000001041e8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001041ed:	74 28                	je     ffff800000104217 <kalloc+0x73>
    kmem.freelist = r->next;
ffff8000001041ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041f3:	48 8b 00             	mov    (%rax),%rax
ffff8000001041f6:	48 ba 40 71 11 00 00 	movabs $0xffff800000117140,%rdx
ffff8000001041fd:	80 ff ff 
ffff800000104200:	48 89 42 70          	mov    %rax,0x70(%rdx)
  else {
    panic("Out of memory!");
  }
  
  if(kmem.use_lock)
ffff800000104204:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff80000010420b:	80 ff ff 
ffff80000010420e:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104211:	85 c0                	test   %eax,%eax
ffff800000104213:	74 34                	je     ffff800000104249 <kalloc+0xa5>
ffff800000104215:	eb 19                	jmp    ffff800000104230 <kalloc+0x8c>
    panic("Out of memory!");
ffff800000104217:	48 b8 d5 c9 10 00 00 	movabs $0xffff80000010c9d5,%rax
ffff80000010421e:	80 ff ff 
ffff800000104221:	48 89 c7             	mov    %rax,%rdi
ffff800000104224:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010422b:	80 ff ff 
ffff80000010422e:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff800000104230:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104237:	80 ff ff 
ffff80000010423a:	48 89 c7             	mov    %rax,%rdi
ffff80000010423d:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000104244:	80 ff ff 
ffff800000104247:	ff d0                	call   *%rax
  return (char*)r;
ffff800000104249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010424d:	c9                   	leave
ffff80000010424e:	c3                   	ret

ffff80000010424f <kfreepagecount>:

int kfreepagecount() {
ffff80000010424f:	55                   	push   %rbp
ffff800000104250:	48 89 e5             	mov    %rsp,%rbp
ffff800000104253:	48 83 ec 10          	sub    $0x10,%rsp
  int i=0;
ffff800000104257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct run *list = kmem.freelist;
ffff80000010425e:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104265:	80 ff ff 
ffff800000104268:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff80000010426c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(list->next) {
ffff800000104270:	eb 0f                	jmp    ffff800000104281 <kfreepagecount+0x32>
    i++;
ffff800000104272:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    list=list->next;
ffff800000104276:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010427a:	48 8b 00             	mov    (%rax),%rax
ffff80000010427d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(list->next) {
ffff800000104281:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104285:	48 8b 00             	mov    (%rax),%rax
ffff800000104288:	48 85 c0             	test   %rax,%rax
ffff80000010428b:	75 e5                	jne    ffff800000104272 <kfreepagecount+0x23>
  }
  return i;
ffff80000010428d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000104290:	c9                   	leave
ffff800000104291:	c3                   	ret

ffff800000104292 <inb>:
{
ffff800000104292:	55                   	push   %rbp
ffff800000104293:	48 89 e5             	mov    %rsp,%rbp
ffff800000104296:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010429a:	89 f8                	mov    %edi,%eax
ffff80000010429c:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff8000001042a0:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001042a4:	89 c2                	mov    %eax,%edx
ffff8000001042a6:	ec                   	in     (%dx),%al
ffff8000001042a7:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff8000001042aa:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff8000001042ae:	c9                   	leave
ffff8000001042af:	c3                   	ret

ffff8000001042b0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
ffff8000001042b0:	55                   	push   %rbp
ffff8000001042b1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001042b4:	48 83 ec 10          	sub    $0x10,%rsp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffff8000001042b8:	bf 64 00 00 00       	mov    $0x64,%edi
ffff8000001042bd:	48 b8 92 42 10 00 00 	movabs $0xffff800000104292,%rax
ffff8000001042c4:	80 ff ff 
ffff8000001042c7:	ff d0                	call   *%rax
ffff8000001042c9:	0f b6 c0             	movzbl %al,%eax
ffff8000001042cc:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffff8000001042cf:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001042d2:	83 e0 01             	and    $0x1,%eax
ffff8000001042d5:	85 c0                	test   %eax,%eax
ffff8000001042d7:	75 0a                	jne    ffff8000001042e3 <kbdgetc+0x33>
    return -1;
ffff8000001042d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001042de:	e9 a4 01 00 00       	jmp    ffff800000104487 <kbdgetc+0x1d7>
  data = inb(KBDATAP);
ffff8000001042e3:	bf 60 00 00 00       	mov    $0x60,%edi
ffff8000001042e8:	48 b8 92 42 10 00 00 	movabs $0xffff800000104292,%rax
ffff8000001042ef:	80 ff ff 
ffff8000001042f2:	ff d0                	call   *%rax
ffff8000001042f4:	0f b6 c0             	movzbl %al,%eax
ffff8000001042f7:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffff8000001042fa:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff800000104301:	75 27                	jne    ffff80000010432a <kbdgetc+0x7a>
    shift |= E0ESC;
ffff800000104303:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010430a:	80 ff ff 
ffff80000010430d:	8b 00                	mov    (%rax),%eax
ffff80000010430f:	83 c8 40             	or     $0x40,%eax
ffff800000104312:	89 c2                	mov    %eax,%edx
ffff800000104314:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010431b:	80 ff ff 
ffff80000010431e:	89 10                	mov    %edx,(%rax)
    return 0;
ffff800000104320:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104325:	e9 5d 01 00 00       	jmp    ffff800000104487 <kbdgetc+0x1d7>
  } else if(data & 0x80){
ffff80000010432a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010432d:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104332:	85 c0                	test   %eax,%eax
ffff800000104334:	74 56                	je     ffff80000010438c <kbdgetc+0xdc>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffff800000104336:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010433d:	80 ff ff 
ffff800000104340:	8b 00                	mov    (%rax),%eax
ffff800000104342:	83 e0 40             	and    $0x40,%eax
ffff800000104345:	85 c0                	test   %eax,%eax
ffff800000104347:	75 04                	jne    ffff80000010434d <kbdgetc+0x9d>
ffff800000104349:	83 65 fc 7f          	andl   $0x7f,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffff80000010434d:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104354:	80 ff ff 
ffff800000104357:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010435a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff80000010435e:	83 c8 40             	or     $0x40,%eax
ffff800000104361:	0f b6 c0             	movzbl %al,%eax
ffff800000104364:	f7 d0                	not    %eax
ffff800000104366:	89 c2                	mov    %eax,%edx
ffff800000104368:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010436f:	80 ff ff 
ffff800000104372:	8b 00                	mov    (%rax),%eax
ffff800000104374:	21 c2                	and    %eax,%edx
ffff800000104376:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010437d:	80 ff ff 
ffff800000104380:	89 10                	mov    %edx,(%rax)
    return 0;
ffff800000104382:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104387:	e9 fb 00 00 00       	jmp    ffff800000104487 <kbdgetc+0x1d7>
  } else if(shift & E0ESC){
ffff80000010438c:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104393:	80 ff ff 
ffff800000104396:	8b 00                	mov    (%rax),%eax
ffff800000104398:	83 e0 40             	and    $0x40,%eax
ffff80000010439b:	85 c0                	test   %eax,%eax
ffff80000010439d:	74 24                	je     ffff8000001043c3 <kbdgetc+0x113>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffff80000010439f:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffff8000001043a6:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043ad:	80 ff ff 
ffff8000001043b0:	8b 00                	mov    (%rax),%eax
ffff8000001043b2:	83 e0 bf             	and    $0xffffffbf,%eax
ffff8000001043b5:	89 c2                	mov    %eax,%edx
ffff8000001043b7:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043be:	80 ff ff 
ffff8000001043c1:	89 10                	mov    %edx,(%rax)
  }

  shift |= shiftcode[data];
ffff8000001043c3:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff8000001043ca:	80 ff ff 
ffff8000001043cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001043d0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001043d4:	0f b6 d0             	movzbl %al,%edx
ffff8000001043d7:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043de:	80 ff ff 
ffff8000001043e1:	8b 00                	mov    (%rax),%eax
ffff8000001043e3:	09 c2                	or     %eax,%edx
ffff8000001043e5:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043ec:	80 ff ff 
ffff8000001043ef:	89 10                	mov    %edx,(%rax)
  shift ^= togglecode[data];
ffff8000001043f1:	48 ba 20 d1 10 00 00 	movabs $0xffff80000010d120,%rdx
ffff8000001043f8:	80 ff ff 
ffff8000001043fb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001043fe:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104402:	0f b6 d0             	movzbl %al,%edx
ffff800000104405:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010440c:	80 ff ff 
ffff80000010440f:	8b 00                	mov    (%rax),%eax
ffff800000104411:	31 c2                	xor    %eax,%edx
ffff800000104413:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010441a:	80 ff ff 
ffff80000010441d:	89 10                	mov    %edx,(%rax)
  c = charcode[shift & (CTL | SHIFT)][data];
ffff80000010441f:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104426:	80 ff ff 
ffff800000104429:	8b 00                	mov    (%rax),%eax
ffff80000010442b:	83 e0 03             	and    $0x3,%eax
ffff80000010442e:	89 c2                	mov    %eax,%edx
ffff800000104430:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff800000104437:	80 ff ff 
ffff80000010443a:	89 d2                	mov    %edx,%edx
ffff80000010443c:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff800000104440:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104443:	48 01 d0             	add    %rdx,%rax
ffff800000104446:	0f b6 00             	movzbl (%rax),%eax
ffff800000104449:	0f b6 c0             	movzbl %al,%eax
ffff80000010444c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffff80000010444f:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104456:	80 ff ff 
ffff800000104459:	8b 00                	mov    (%rax),%eax
ffff80000010445b:	83 e0 08             	and    $0x8,%eax
ffff80000010445e:	85 c0                	test   %eax,%eax
ffff800000104460:	74 22                	je     ffff800000104484 <kbdgetc+0x1d4>
    if('a' <= c && c <= 'z')
ffff800000104462:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff800000104466:	76 0c                	jbe    ffff800000104474 <kbdgetc+0x1c4>
ffff800000104468:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff80000010446c:	77 06                	ja     ffff800000104474 <kbdgetc+0x1c4>
      c += 'A' - 'a';
ffff80000010446e:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff800000104472:	eb 10                	jmp    ffff800000104484 <kbdgetc+0x1d4>
    else if('A' <= c && c <= 'Z')
ffff800000104474:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff800000104478:	76 0a                	jbe    ffff800000104484 <kbdgetc+0x1d4>
ffff80000010447a:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff80000010447e:	77 04                	ja     ffff800000104484 <kbdgetc+0x1d4>
      c += 'a' - 'A';
ffff800000104480:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffff800000104484:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000104487:	c9                   	leave
ffff800000104488:	c3                   	ret

ffff800000104489 <kbdintr>:

void
kbdintr(void)
{
ffff800000104489:	55                   	push   %rbp
ffff80000010448a:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffff80000010448d:	48 b8 b0 42 10 00 00 	movabs $0xffff8000001042b0,%rax
ffff800000104494:	80 ff ff 
ffff800000104497:	48 89 c7             	mov    %rax,%rdi
ffff80000010449a:	48 b8 6f 0f 10 00 00 	movabs $0xffff800000100f6f,%rax
ffff8000001044a1:	80 ff ff 
ffff8000001044a4:	ff d0                	call   *%rax
}
ffff8000001044a6:	90                   	nop
ffff8000001044a7:	5d                   	pop    %rbp
ffff8000001044a8:	c3                   	ret

ffff8000001044a9 <inb>:
{
ffff8000001044a9:	55                   	push   %rbp
ffff8000001044aa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044ad:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001044b1:	89 f8                	mov    %edi,%eax
ffff8000001044b3:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff8000001044b7:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001044bb:	89 c2                	mov    %eax,%edx
ffff8000001044bd:	ec                   	in     (%dx),%al
ffff8000001044be:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff8000001044c1:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff8000001044c5:	c9                   	leave
ffff8000001044c6:	c3                   	ret

ffff8000001044c7 <outb>:
{
ffff8000001044c7:	55                   	push   %rbp
ffff8000001044c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044cb:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001044cf:	89 fa                	mov    %edi,%edx
ffff8000001044d1:	89 f0                	mov    %esi,%eax
ffff8000001044d3:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff8000001044d7:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff8000001044da:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff8000001044de:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff8000001044e2:	ee                   	out    %al,(%dx)
}
ffff8000001044e3:	90                   	nop
ffff8000001044e4:	c9                   	leave
ffff8000001044e5:	c3                   	ret

ffff8000001044e6 <readeflags>:
{
ffff8000001044e6:	55                   	push   %rbp
ffff8000001044e7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044ea:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff8000001044ee:	9c                   	pushf
ffff8000001044ef:	58                   	pop    %rax
ffff8000001044f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff8000001044f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001044f8:	c9                   	leave
ffff8000001044f9:	c3                   	ret

ffff8000001044fa <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
ffff8000001044fa:	55                   	push   %rbp
ffff8000001044fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044fe:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104502:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000104505:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffff800000104508:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010450f:	80 ff ff 
ffff800000104512:	48 8b 00             	mov    (%rax),%rax
ffff800000104515:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104518:	48 63 d2             	movslq %edx,%rdx
ffff80000010451b:	48 c1 e2 02          	shl    $0x2,%rdx
ffff80000010451f:	48 01 c2             	add    %rax,%rdx
ffff800000104522:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000104525:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffff800000104527:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010452e:	80 ff ff 
ffff800000104531:	48 8b 00             	mov    (%rax),%rax
ffff800000104534:	48 83 c0 20          	add    $0x20,%rax
ffff800000104538:	8b 00                	mov    (%rax),%eax
}
ffff80000010453a:	90                   	nop
ffff80000010453b:	c9                   	leave
ffff80000010453c:	c3                   	ret

ffff80000010453d <lapicinit>:

void
lapicinit(void)
{
ffff80000010453d:	55                   	push   %rbp
ffff80000010453e:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic)
ffff800000104541:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104548:	80 ff ff 
ffff80000010454b:	48 8b 00             	mov    (%rax),%rax
ffff80000010454e:	48 85 c0             	test   %rax,%rax
ffff800000104551:	0f 84 71 01 00 00    	je     ffff8000001046c8 <lapicinit+0x18b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffff800000104557:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff80000010455c:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff800000104561:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104568:	80 ff ff 
ffff80000010456b:	ff d0                	call   *%rax

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
ffff80000010456d:	be 0b 00 00 00       	mov    $0xb,%esi
ffff800000104572:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff800000104577:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010457e:	80 ff ff 
ffff800000104581:	ff d0                	call   *%rax
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffff800000104583:	be 20 00 02 00       	mov    $0x20020,%esi
ffff800000104588:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff80000010458d:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104594:	80 ff ff 
ffff800000104597:	ff d0                	call   *%rax
  lapicw(TICR, 10000000);
ffff800000104599:	be 80 96 98 00       	mov    $0x989680,%esi
ffff80000010459e:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff8000001045a3:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001045aa:	80 ff ff 
ffff8000001045ad:	ff d0                	call   *%rax

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
ffff8000001045af:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001045b4:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff8000001045b9:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001045c0:	80 ff ff 
ffff8000001045c3:	ff d0                	call   *%rax
  lapicw(LINT1, MASKED);
ffff8000001045c5:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001045ca:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff8000001045cf:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001045d6:	80 ff ff 
ffff8000001045d9:	ff d0                	call   *%rax

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffff8000001045db:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001045e2:	80 ff ff 
ffff8000001045e5:	48 8b 00             	mov    (%rax),%rax
ffff8000001045e8:	48 83 c0 30          	add    $0x30,%rax
ffff8000001045ec:	8b 00                	mov    (%rax),%eax
ffff8000001045ee:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff8000001045f3:	85 c0                	test   %eax,%eax
ffff8000001045f5:	74 16                	je     ffff80000010460d <lapicinit+0xd0>
    lapicw(PCINT, MASKED);
ffff8000001045f7:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001045fc:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff800000104601:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104608:	80 ff ff 
ffff80000010460b:	ff d0                	call   *%rax

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffff80000010460d:	be 33 00 00 00       	mov    $0x33,%esi
ffff800000104612:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff800000104617:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010461e:	80 ff ff 
ffff800000104621:	ff d0                	call   *%rax

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
ffff800000104623:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104628:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff80000010462d:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104634:	80 ff ff 
ffff800000104637:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff800000104639:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010463e:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff800000104643:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010464a:	80 ff ff 
ffff80000010464d:	ff d0                	call   *%rax

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
ffff80000010464f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104654:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff800000104659:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104660:	80 ff ff 
ffff800000104663:	ff d0                	call   *%rax

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
ffff800000104665:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010466a:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff80000010466f:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104676:	80 ff ff 
ffff800000104679:	ff d0                	call   *%rax
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffff80000010467b:	be 00 85 08 00       	mov    $0x88500,%esi
ffff800000104680:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104685:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010468c:	80 ff ff 
ffff80000010468f:	ff d0                	call   *%rax
  while(lapic[ICRLO] & DELIVS)
ffff800000104691:	90                   	nop
ffff800000104692:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104699:	80 ff ff 
ffff80000010469c:	48 8b 00             	mov    (%rax),%rax
ffff80000010469f:	48 05 00 03 00 00    	add    $0x300,%rax
ffff8000001046a5:	8b 00                	mov    (%rax),%eax
ffff8000001046a7:	25 00 10 00 00       	and    $0x1000,%eax
ffff8000001046ac:	85 c0                	test   %eax,%eax
ffff8000001046ae:	75 e2                	jne    ffff800000104692 <lapicinit+0x155>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
ffff8000001046b0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001046b5:	bf 20 00 00 00       	mov    $0x20,%edi
ffff8000001046ba:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001046c1:	80 ff ff 
ffff8000001046c4:	ff d0                	call   *%rax
ffff8000001046c6:	eb 01                	jmp    ffff8000001046c9 <lapicinit+0x18c>
    return;
ffff8000001046c8:	90                   	nop
}
ffff8000001046c9:	5d                   	pop    %rbp
ffff8000001046ca:	c3                   	ret

ffff8000001046cb <cpunum>:

int
cpunum(void)
{
ffff8000001046cb:	55                   	push   %rbp
ffff8000001046cc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046cf:	48 83 ec 10          	sub    $0x10,%rsp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
ffff8000001046d3:	48 b8 e6 44 10 00 00 	movabs $0xffff8000001044e6,%rax
ffff8000001046da:	80 ff ff 
ffff8000001046dd:	ff d0                	call   *%rax
ffff8000001046df:	25 00 02 00 00       	and    $0x200,%eax
ffff8000001046e4:	48 85 c0             	test   %rax,%rax
ffff8000001046e7:	74 47                	je     ffff800000104730 <cpunum+0x65>
    static int n;
    if(n++ == 0)
ffff8000001046e9:	48 b8 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rax
ffff8000001046f0:	80 ff ff 
ffff8000001046f3:	8b 00                	mov    (%rax),%eax
ffff8000001046f5:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001046f8:	48 b9 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rcx
ffff8000001046ff:	80 ff ff 
ffff800000104702:	89 11                	mov    %edx,(%rcx)
ffff800000104704:	85 c0                	test   %eax,%eax
ffff800000104706:	75 28                	jne    ffff800000104730 <cpunum+0x65>
      cprintf("cpu called from %x with interrupts enabled\n",
ffff800000104708:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff80000010470c:	48 89 c2             	mov    %rax,%rdx
ffff80000010470f:	48 b8 e8 c9 10 00 00 	movabs $0xffff80000010c9e8,%rax
ffff800000104716:	80 ff ff 
ffff800000104719:	48 89 d6             	mov    %rdx,%rsi
ffff80000010471c:	48 89 c7             	mov    %rax,%rdi
ffff80000010471f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104724:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010472b:	80 ff ff 
ffff80000010472e:	ff d2                	call   *%rdx
        __builtin_return_address(0));
  }

  if (!lapic)
ffff800000104730:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104737:	80 ff ff 
ffff80000010473a:	48 8b 00             	mov    (%rax),%rax
ffff80000010473d:	48 85 c0             	test   %rax,%rax
ffff800000104740:	75 0a                	jne    ffff80000010474c <cpunum+0x81>
    return 0;
ffff800000104742:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104747:	e9 85 00 00 00       	jmp    ffff8000001047d1 <cpunum+0x106>

  apicid = lapic[ID] >> 24;
ffff80000010474c:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104753:	80 ff ff 
ffff800000104756:	48 8b 00             	mov    (%rax),%rax
ffff800000104759:	48 83 c0 20          	add    $0x20,%rax
ffff80000010475d:	8b 00                	mov    (%rax),%eax
ffff80000010475f:	c1 e8 18             	shr    $0x18,%eax
ffff800000104762:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < ncpu; ++i) {
ffff800000104765:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010476c:	eb 39                	jmp    ffff8000001047a7 <cpunum+0xdc>
    if (cpus[i].apicid == apicid)
ffff80000010476e:	48 b9 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rcx
ffff800000104775:	80 ff ff 
ffff800000104778:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010477b:	48 63 d0             	movslq %eax,%rdx
ffff80000010477e:	48 89 d0             	mov    %rdx,%rax
ffff800000104781:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000104785:	48 01 d0             	add    %rdx,%rax
ffff800000104788:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010478c:	48 01 c8             	add    %rcx,%rax
ffff80000010478f:	48 83 c0 01          	add    $0x1,%rax
ffff800000104793:	0f b6 00             	movzbl (%rax),%eax
ffff800000104796:	0f b6 c0             	movzbl %al,%eax
ffff800000104799:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010479c:	75 05                	jne    ffff8000001047a3 <cpunum+0xd8>
      return i;
ffff80000010479e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001047a1:	eb 2e                	jmp    ffff8000001047d1 <cpunum+0x106>
  for (i = 0; i < ncpu; ++i) {
ffff8000001047a3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001047a7:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff8000001047ae:	80 ff ff 
ffff8000001047b1:	8b 00                	mov    (%rax),%eax
ffff8000001047b3:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001047b6:	7c b6                	jl     ffff80000010476e <cpunum+0xa3>
  }
  panic("unknown apicid\n");
ffff8000001047b8:	48 b8 14 ca 10 00 00 	movabs $0xffff80000010ca14,%rax
ffff8000001047bf:	80 ff ff 
ffff8000001047c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001047c5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001047cc:	80 ff ff 
ffff8000001047cf:	ff d0                	call   *%rax
}
ffff8000001047d1:	c9                   	leave
ffff8000001047d2:	c3                   	ret

ffff8000001047d3 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffff8000001047d3:	55                   	push   %rbp
ffff8000001047d4:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffff8000001047d7:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001047de:	80 ff ff 
ffff8000001047e1:	48 8b 00             	mov    (%rax),%rax
ffff8000001047e4:	48 85 c0             	test   %rax,%rax
ffff8000001047e7:	74 16                	je     ffff8000001047ff <lapiceoi+0x2c>
    lapicw(EOI, 0);
ffff8000001047e9:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047ee:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001047f3:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001047fa:	80 ff ff 
ffff8000001047fd:	ff d0                	call   *%rax
}
ffff8000001047ff:	90                   	nop
ffff800000104800:	5d                   	pop    %rbp
ffff800000104801:	c3                   	ret

ffff800000104802 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffff800000104802:	55                   	push   %rbp
ffff800000104803:	48 89 e5             	mov    %rsp,%rbp
ffff800000104806:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010480a:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffff80000010480d:	90                   	nop
ffff80000010480e:	c9                   	leave
ffff80000010480f:	c3                   	ret

ffff800000104810 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffff800000104810:	55                   	push   %rbp
ffff800000104811:	48 89 e5             	mov    %rsp,%rbp
ffff800000104814:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104818:	89 f8                	mov    %edi,%eax
ffff80000010481a:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff80000010481d:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
ffff800000104820:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000104825:	bf 70 00 00 00       	mov    $0x70,%edi
ffff80000010482a:	48 b8 c7 44 10 00 00 	movabs $0xffff8000001044c7,%rax
ffff800000104831:	80 ff ff 
ffff800000104834:	ff d0                	call   *%rax
  outb(CMOS_PORT+1, 0x0A);
ffff800000104836:	be 0a 00 00 00       	mov    $0xa,%esi
ffff80000010483b:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104840:	48 b8 c7 44 10 00 00 	movabs $0xffff8000001044c7,%rax
ffff800000104847:	80 ff ff 
ffff80000010484a:	ff d0                	call   *%rax
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffff80000010484c:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff800000104853:	80 ff ff 
ffff800000104856:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  wrv[0] = 0;
ffff80000010485a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010485e:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffff800000104863:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104866:	c1 e8 04             	shr    $0x4,%eax
ffff800000104869:	89 c2                	mov    %eax,%edx
ffff80000010486b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010486f:	48 83 c0 02          	add    $0x2,%rax
ffff800000104873:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffff800000104876:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff80000010487a:	c1 e0 18             	shl    $0x18,%eax
ffff80000010487d:	89 c6                	mov    %eax,%esi
ffff80000010487f:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104884:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010488b:	80 ff ff 
ffff80000010488e:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffff800000104890:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff800000104895:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff80000010489a:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001048a1:	80 ff ff 
ffff8000001048a4:	ff d0                	call   *%rax
  microdelay(200);
ffff8000001048a6:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff8000001048ab:	48 b8 02 48 10 00 00 	movabs $0xffff800000104802,%rax
ffff8000001048b2:	80 ff ff 
ffff8000001048b5:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL);
ffff8000001048b7:	be 00 85 00 00       	mov    $0x8500,%esi
ffff8000001048bc:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff8000001048c1:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001048c8:	80 ff ff 
ffff8000001048cb:	ff d0                	call   *%rax
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffff8000001048cd:	bf 64 00 00 00       	mov    $0x64,%edi
ffff8000001048d2:	48 b8 02 48 10 00 00 	movabs $0xffff800000104802,%rax
ffff8000001048d9:	80 ff ff 
ffff8000001048dc:	ff d0                	call   *%rax
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffff8000001048de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001048e5:	eb 4b                	jmp    ffff800000104932 <lapicstartap+0x122>
    lapicw(ICRHI, apicid<<24);
ffff8000001048e7:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff8000001048eb:	c1 e0 18             	shl    $0x18,%eax
ffff8000001048ee:	89 c6                	mov    %eax,%esi
ffff8000001048f0:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff8000001048f5:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff8000001048fc:	80 ff ff 
ffff8000001048ff:	ff d0                	call   *%rax
    lapicw(ICRLO, STARTUP | (addr>>12));
ffff800000104901:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104904:	c1 e8 0c             	shr    $0xc,%eax
ffff800000104907:	80 cc 06             	or     $0x6,%ah
ffff80000010490a:	89 c6                	mov    %eax,%esi
ffff80000010490c:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104911:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff800000104918:	80 ff ff 
ffff80000010491b:	ff d0                	call   *%rax
    microdelay(200);
ffff80000010491d:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104922:	48 b8 02 48 10 00 00 	movabs $0xffff800000104802,%rax
ffff800000104929:	80 ff ff 
ffff80000010492c:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
ffff80000010492e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104932:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000104936:	7e af                	jle    ffff8000001048e7 <lapicstartap+0xd7>
  }
}
ffff800000104938:	90                   	nop
ffff800000104939:	90                   	nop
ffff80000010493a:	c9                   	leave
ffff80000010493b:	c3                   	ret

ffff80000010493c <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
ffff80000010493c:	55                   	push   %rbp
ffff80000010493d:	48 89 e5             	mov    %rsp,%rbp
ffff800000104940:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104944:	89 7d fc             	mov    %edi,-0x4(%rbp)
  outb(CMOS_PORT,  reg);
ffff800000104947:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010494a:	0f b6 c0             	movzbl %al,%eax
ffff80000010494d:	89 c6                	mov    %eax,%esi
ffff80000010494f:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104954:	48 b8 c7 44 10 00 00 	movabs $0xffff8000001044c7,%rax
ffff80000010495b:	80 ff ff 
ffff80000010495e:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104960:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104965:	48 b8 02 48 10 00 00 	movabs $0xffff800000104802,%rax
ffff80000010496c:	80 ff ff 
ffff80000010496f:	ff d0                	call   *%rax

  return inb(CMOS_RETURN);
ffff800000104971:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104976:	48 b8 a9 44 10 00 00 	movabs $0xffff8000001044a9,%rax
ffff80000010497d:	80 ff ff 
ffff800000104980:	ff d0                	call   *%rax
ffff800000104982:	0f b6 c0             	movzbl %al,%eax
}
ffff800000104985:	c9                   	leave
ffff800000104986:	c3                   	ret

ffff800000104987 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
ffff800000104987:	55                   	push   %rbp
ffff800000104988:	48 89 e5             	mov    %rsp,%rbp
ffff80000010498b:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010498f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  r->second = cmos_read(SECS);
ffff800000104993:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104998:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff80000010499f:	80 ff ff 
ffff8000001049a2:	ff d0                	call   *%rax
ffff8000001049a4:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049a8:	89 02                	mov    %eax,(%rdx)
  r->minute = cmos_read(MINS);
ffff8000001049aa:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001049af:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff8000001049b6:	80 ff ff 
ffff8000001049b9:	ff d0                	call   *%rax
ffff8000001049bb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049bf:	89 42 04             	mov    %eax,0x4(%rdx)
  r->hour   = cmos_read(HOURS);
ffff8000001049c2:	bf 04 00 00 00       	mov    $0x4,%edi
ffff8000001049c7:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff8000001049ce:	80 ff ff 
ffff8000001049d1:	ff d0                	call   *%rax
ffff8000001049d3:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049d7:	89 42 08             	mov    %eax,0x8(%rdx)
  r->day    = cmos_read(DAY);
ffff8000001049da:	bf 07 00 00 00       	mov    $0x7,%edi
ffff8000001049df:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff8000001049e6:	80 ff ff 
ffff8000001049e9:	ff d0                	call   *%rax
ffff8000001049eb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049ef:	89 42 0c             	mov    %eax,0xc(%rdx)
  r->month  = cmos_read(MONTH);
ffff8000001049f2:	bf 08 00 00 00       	mov    $0x8,%edi
ffff8000001049f7:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff8000001049fe:	80 ff ff 
ffff800000104a01:	ff d0                	call   *%rax
ffff800000104a03:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104a07:	89 42 10             	mov    %eax,0x10(%rdx)
  r->year   = cmos_read(YEAR);
ffff800000104a0a:	bf 09 00 00 00       	mov    $0x9,%edi
ffff800000104a0f:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff800000104a16:	80 ff ff 
ffff800000104a19:	ff d0                	call   *%rax
ffff800000104a1b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104a1f:	89 42 14             	mov    %eax,0x14(%rdx)
}
ffff800000104a22:	90                   	nop
ffff800000104a23:	c9                   	leave
ffff800000104a24:	c3                   	ret

ffff800000104a25 <cmostime>:
//PAGEBREAK!

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
ffff800000104a25:	55                   	push   %rbp
ffff800000104a26:	48 89 e5             	mov    %rsp,%rbp
ffff800000104a29:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000104a2d:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
ffff800000104a31:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff800000104a36:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff800000104a3d:	80 ff ff 
ffff800000104a40:	ff d0                	call   *%rax
ffff800000104a42:	89 45 fc             	mov    %eax,-0x4(%rbp)

  bcd = (sb & (1 << 2)) == 0;
ffff800000104a45:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104a48:	83 e0 04             	and    $0x4,%eax
ffff800000104a4b:	c1 e8 02             	shr    $0x2,%eax
ffff800000104a4e:	83 e0 01             	and    $0x1,%eax
ffff800000104a51:	83 f0 01             	xor    $0x1,%eax
ffff800000104a54:	0f b6 c0             	movzbl %al,%eax
ffff800000104a57:	89 45 f8             	mov    %eax,-0x8(%rbp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
ffff800000104a5a:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104a5e:	48 89 c7             	mov    %rax,%rdi
ffff800000104a61:	48 b8 87 49 10 00 00 	movabs $0xffff800000104987,%rax
ffff800000104a68:	80 ff ff 
ffff800000104a6b:	ff d0                	call   *%rax
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
ffff800000104a6d:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104a72:	48 b8 3c 49 10 00 00 	movabs $0xffff80000010493c,%rax
ffff800000104a79:	80 ff ff 
ffff800000104a7c:	ff d0                	call   *%rax
ffff800000104a7e:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104a83:	85 c0                	test   %eax,%eax
ffff800000104a85:	75 38                	jne    ffff800000104abf <cmostime+0x9a>
        continue;
    fill_rtcdate(&t2);
ffff800000104a87:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104a8b:	48 89 c7             	mov    %rax,%rdi
ffff800000104a8e:	48 b8 87 49 10 00 00 	movabs $0xffff800000104987,%rax
ffff800000104a95:	80 ff ff 
ffff800000104a98:	ff d0                	call   *%rax
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
ffff800000104a9a:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104a9e:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104aa2:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104aa7:	48 89 ce             	mov    %rcx,%rsi
ffff800000104aaa:	48 89 c7             	mov    %rax,%rdi
ffff800000104aad:	48 b8 0f 7b 10 00 00 	movabs $0xffff800000107b0f,%rax
ffff800000104ab4:	80 ff ff 
ffff800000104ab7:	ff d0                	call   *%rax
ffff800000104ab9:	85 c0                	test   %eax,%eax
ffff800000104abb:	74 05                	je     ffff800000104ac2 <cmostime+0x9d>
ffff800000104abd:	eb 9b                	jmp    ffff800000104a5a <cmostime+0x35>
        continue;
ffff800000104abf:	90                   	nop
    fill_rtcdate(&t1);
ffff800000104ac0:	eb 98                	jmp    ffff800000104a5a <cmostime+0x35>
      break;
ffff800000104ac2:	90                   	nop
  }

  // convert
  if(bcd) {
ffff800000104ac3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104ac7:	0f 84 b4 00 00 00    	je     ffff800000104b81 <cmostime+0x15c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
ffff800000104acd:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104ad0:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ad3:	89 c2                	mov    %eax,%edx
ffff800000104ad5:	89 d0                	mov    %edx,%eax
ffff800000104ad7:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ada:	01 d0                	add    %edx,%eax
ffff800000104adc:	01 c0                	add    %eax,%eax
ffff800000104ade:	89 c2                	mov    %eax,%edx
ffff800000104ae0:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104ae3:	83 e0 0f             	and    $0xf,%eax
ffff800000104ae6:	01 d0                	add    %edx,%eax
ffff800000104ae8:	89 45 e0             	mov    %eax,-0x20(%rbp)
    CONV(minute);
ffff800000104aeb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104aee:	c1 e8 04             	shr    $0x4,%eax
ffff800000104af1:	89 c2                	mov    %eax,%edx
ffff800000104af3:	89 d0                	mov    %edx,%eax
ffff800000104af5:	c1 e0 02             	shl    $0x2,%eax
ffff800000104af8:	01 d0                	add    %edx,%eax
ffff800000104afa:	01 c0                	add    %eax,%eax
ffff800000104afc:	89 c2                	mov    %eax,%edx
ffff800000104afe:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104b01:	83 e0 0f             	and    $0xf,%eax
ffff800000104b04:	01 d0                	add    %edx,%eax
ffff800000104b06:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    CONV(hour  );
ffff800000104b09:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104b0c:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b0f:	89 c2                	mov    %eax,%edx
ffff800000104b11:	89 d0                	mov    %edx,%eax
ffff800000104b13:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b16:	01 d0                	add    %edx,%eax
ffff800000104b18:	01 c0                	add    %eax,%eax
ffff800000104b1a:	89 c2                	mov    %eax,%edx
ffff800000104b1c:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104b1f:	83 e0 0f             	and    $0xf,%eax
ffff800000104b22:	01 d0                	add    %edx,%eax
ffff800000104b24:	89 45 e8             	mov    %eax,-0x18(%rbp)
    CONV(day   );
ffff800000104b27:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104b2a:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b2d:	89 c2                	mov    %eax,%edx
ffff800000104b2f:	89 d0                	mov    %edx,%eax
ffff800000104b31:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b34:	01 d0                	add    %edx,%eax
ffff800000104b36:	01 c0                	add    %eax,%eax
ffff800000104b38:	89 c2                	mov    %eax,%edx
ffff800000104b3a:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104b3d:	83 e0 0f             	and    $0xf,%eax
ffff800000104b40:	01 d0                	add    %edx,%eax
ffff800000104b42:	89 45 ec             	mov    %eax,-0x14(%rbp)
    CONV(month );
ffff800000104b45:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104b48:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b4b:	89 c2                	mov    %eax,%edx
ffff800000104b4d:	89 d0                	mov    %edx,%eax
ffff800000104b4f:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b52:	01 d0                	add    %edx,%eax
ffff800000104b54:	01 c0                	add    %eax,%eax
ffff800000104b56:	89 c2                	mov    %eax,%edx
ffff800000104b58:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104b5b:	83 e0 0f             	and    $0xf,%eax
ffff800000104b5e:	01 d0                	add    %edx,%eax
ffff800000104b60:	89 45 f0             	mov    %eax,-0x10(%rbp)
    CONV(year  );
ffff800000104b63:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104b66:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b69:	89 c2                	mov    %eax,%edx
ffff800000104b6b:	89 d0                	mov    %edx,%eax
ffff800000104b6d:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b70:	01 d0                	add    %edx,%eax
ffff800000104b72:	01 c0                	add    %eax,%eax
ffff800000104b74:	89 c2                	mov    %eax,%edx
ffff800000104b76:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104b79:	83 e0 0f             	and    $0xf,%eax
ffff800000104b7c:	01 d0                	add    %edx,%eax
ffff800000104b7e:	89 45 f4             	mov    %eax,-0xc(%rbp)
#undef     CONV
  }

  *r = t1;
ffff800000104b81:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104b85:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104b89:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104b8d:	48 89 01             	mov    %rax,(%rcx)
ffff800000104b90:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104b94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104b98:	48 89 41 10          	mov    %rax,0x10(%rcx)
  r->year += 2000;
ffff800000104b9c:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104ba0:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104ba3:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104ba9:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104bad:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000104bb0:	90                   	nop
ffff800000104bb1:	c9                   	leave
ffff800000104bb2:	c3                   	ret

ffff800000104bb3 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
ffff800000104bb3:	55                   	push   %rbp
ffff800000104bb4:	48 89 e5             	mov    %rsp,%rbp
ffff800000104bb7:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104bbb:	89 7d dc             	mov    %edi,-0x24(%rbp)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffff800000104bbe:	48 ba 24 ca 10 00 00 	movabs $0xffff80000010ca24,%rdx
ffff800000104bc5:	80 ff ff 
ffff800000104bc8:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104bcf:	80 ff ff 
ffff800000104bd2:	48 89 d6             	mov    %rdx,%rsi
ffff800000104bd5:	48 89 c7             	mov    %rax,%rdi
ffff800000104bd8:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000104bdf:	80 ff ff 
ffff800000104be2:	ff d0                	call   *%rax
  readsb(dev, &sb);
ffff800000104be4:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104be8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104beb:	48 89 d6             	mov    %rdx,%rsi
ffff800000104bee:	89 c7                	mov    %eax,%edi
ffff800000104bf0:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff800000104bf7:	80 ff ff 
ffff800000104bfa:	ff d0                	call   *%rax
  log.start = sb.logstart;
ffff800000104bfc:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104bff:	89 c2                	mov    %eax,%edx
ffff800000104c01:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c08:	80 ff ff 
ffff800000104c0b:	89 50 68             	mov    %edx,0x68(%rax)
  log.size = sb.nlog;
ffff800000104c0e:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104c11:	89 c2                	mov    %eax,%edx
ffff800000104c13:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c1a:	80 ff ff 
ffff800000104c1d:	89 50 6c             	mov    %edx,0x6c(%rax)
  log.dev = dev;
ffff800000104c20:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104c27:	80 ff ff 
ffff800000104c2a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104c2d:	89 42 78             	mov    %eax,0x78(%rdx)
  recover_from_log();
ffff800000104c30:	48 b8 c4 4e 10 00 00 	movabs $0xffff800000104ec4,%rax
ffff800000104c37:	80 ff ff 
ffff800000104c3a:	ff d0                	call   *%rax
}
ffff800000104c3c:	90                   	nop
ffff800000104c3d:	c9                   	leave
ffff800000104c3e:	c3                   	ret

ffff800000104c3f <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
ffff800000104c3f:	55                   	push   %rbp
ffff800000104c40:	48 89 e5             	mov    %rsp,%rbp
ffff800000104c43:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104c47:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104c4e:	e9 dc 00 00 00       	jmp    ffff800000104d2f <install_trans+0xf0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffff800000104c53:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c5a:	80 ff ff 
ffff800000104c5d:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104c60:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104c63:	01 d0                	add    %edx,%eax
ffff800000104c65:	83 c0 01             	add    $0x1,%eax
ffff800000104c68:	89 c2                	mov    %eax,%edx
ffff800000104c6a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c71:	80 ff ff 
ffff800000104c74:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104c77:	89 d6                	mov    %edx,%esi
ffff800000104c79:	89 c7                	mov    %eax,%edi
ffff800000104c7b:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104c82:	80 ff ff 
ffff800000104c85:	ff d0                	call   *%rax
ffff800000104c87:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
ffff800000104c8b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c92:	80 ff ff 
ffff800000104c95:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104c98:	48 63 d2             	movslq %edx,%rdx
ffff800000104c9b:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104c9f:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104ca3:	89 c2                	mov    %eax,%edx
ffff800000104ca5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104cac:	80 ff ff 
ffff800000104caf:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104cb2:	89 d6                	mov    %edx,%esi
ffff800000104cb4:	89 c7                	mov    %eax,%edi
ffff800000104cb6:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104cbd:	80 ff ff 
ffff800000104cc0:	ff d0                	call   *%rax
ffff800000104cc2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffff800000104cc6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104cca:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104cd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104cd5:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104cdb:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104ce0:	48 89 ce             	mov    %rcx,%rsi
ffff800000104ce3:	48 89 c7             	mov    %rax,%rdi
ffff800000104ce6:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff800000104ced:	80 ff ff 
ffff800000104cf0:	ff d0                	call   *%rax
    bwrite(dbuf);  // write dst to disk
ffff800000104cf2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104cf6:	48 89 c7             	mov    %rax,%rdi
ffff800000104cf9:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104d00:	80 ff ff 
ffff800000104d03:	ff d0                	call   *%rax
    brelse(lbuf);
ffff800000104d05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d09:	48 89 c7             	mov    %rax,%rdi
ffff800000104d0c:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104d13:	80 ff ff 
ffff800000104d16:	ff d0                	call   *%rax
    brelse(dbuf);
ffff800000104d18:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104d1c:	48 89 c7             	mov    %rax,%rdi
ffff800000104d1f:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104d26:	80 ff ff 
ffff800000104d29:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104d2b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104d2f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d36:	80 ff ff 
ffff800000104d39:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104d3c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104d3f:	0f 8c 0e ff ff ff    	jl     ffff800000104c53 <install_trans+0x14>
  }
}
ffff800000104d45:	90                   	nop
ffff800000104d46:	90                   	nop
ffff800000104d47:	c9                   	leave
ffff800000104d48:	c3                   	ret

ffff800000104d49 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffff800000104d49:	55                   	push   %rbp
ffff800000104d4a:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d4d:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104d51:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d58:	80 ff ff 
ffff800000104d5b:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104d5e:	89 c2                	mov    %eax,%edx
ffff800000104d60:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d67:	80 ff ff 
ffff800000104d6a:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104d6d:	89 d6                	mov    %edx,%esi
ffff800000104d6f:	89 c7                	mov    %eax,%edi
ffff800000104d71:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104d78:	80 ff ff 
ffff800000104d7b:	ff d0                	call   *%rax
ffff800000104d7d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffff800000104d81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d85:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104d8b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffff800000104d8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104d93:	8b 00                	mov    (%rax),%eax
ffff800000104d95:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104d9c:	80 ff ff 
ffff800000104d9f:	89 42 7c             	mov    %eax,0x7c(%rdx)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104da2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104da9:	eb 2a                	jmp    ffff800000104dd5 <read_head+0x8c>
    log.lh.block[i] = lh->block[i];
ffff800000104dab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104daf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104db2:	48 63 d2             	movslq %edx,%rdx
ffff800000104db5:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104db9:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104dc0:	80 ff ff 
ffff800000104dc3:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104dc6:	48 63 c9             	movslq %ecx,%rcx
ffff800000104dc9:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104dcd:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104dd1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104dd5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ddc:	80 ff ff 
ffff800000104ddf:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104de2:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104de5:	7c c4                	jl     ffff800000104dab <read_head+0x62>
  }
  brelse(buf);
ffff800000104de7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104deb:	48 89 c7             	mov    %rax,%rdi
ffff800000104dee:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104df5:	80 ff ff 
ffff800000104df8:	ff d0                	call   *%rax
}
ffff800000104dfa:	90                   	nop
ffff800000104dfb:	c9                   	leave
ffff800000104dfc:	c3                   	ret

ffff800000104dfd <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffff800000104dfd:	55                   	push   %rbp
ffff800000104dfe:	48 89 e5             	mov    %rsp,%rbp
ffff800000104e01:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104e05:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e0c:	80 ff ff 
ffff800000104e0f:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104e12:	89 c2                	mov    %eax,%edx
ffff800000104e14:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e1b:	80 ff ff 
ffff800000104e1e:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e21:	89 d6                	mov    %edx,%esi
ffff800000104e23:	89 c7                	mov    %eax,%edi
ffff800000104e25:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104e2c:	80 ff ff 
ffff800000104e2f:	ff d0                	call   *%rax
ffff800000104e31:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffff800000104e35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e39:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104e3f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffff800000104e43:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e4a:	80 ff ff 
ffff800000104e4d:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000104e50:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e54:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104e56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104e5d:	eb 2a                	jmp    ffff800000104e89 <write_head+0x8c>
    hb->block[i] = log.lh.block[i];
ffff800000104e5f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e66:	80 ff ff 
ffff800000104e69:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e6c:	48 63 d2             	movslq %edx,%rdx
ffff800000104e6f:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e73:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff800000104e77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e7b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e7e:	48 63 d2             	movslq %edx,%rdx
ffff800000104e81:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104e85:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104e89:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e90:	80 ff ff 
ffff800000104e93:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104e96:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104e99:	7c c4                	jl     ffff800000104e5f <write_head+0x62>
  }
  bwrite(buf);
ffff800000104e9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e9f:	48 89 c7             	mov    %rax,%rdi
ffff800000104ea2:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104ea9:	80 ff ff 
ffff800000104eac:	ff d0                	call   *%rax
  brelse(buf);
ffff800000104eae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104eb2:	48 89 c7             	mov    %rax,%rdi
ffff800000104eb5:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ebc:	80 ff ff 
ffff800000104ebf:	ff d0                	call   *%rax
}
ffff800000104ec1:	90                   	nop
ffff800000104ec2:	c9                   	leave
ffff800000104ec3:	c3                   	ret

ffff800000104ec4 <recover_from_log>:

static void
recover_from_log(void)
{
ffff800000104ec4:	55                   	push   %rbp
ffff800000104ec5:	48 89 e5             	mov    %rsp,%rbp
  read_head();
ffff800000104ec8:	48 b8 49 4d 10 00 00 	movabs $0xffff800000104d49,%rax
ffff800000104ecf:	80 ff ff 
ffff800000104ed2:	ff d0                	call   *%rax
  install_trans(); // if committed, copy from log to disk
ffff800000104ed4:	48 b8 3f 4c 10 00 00 	movabs $0xffff800000104c3f,%rax
ffff800000104edb:	80 ff ff 
ffff800000104ede:	ff d0                	call   *%rax
  log.lh.n = 0;
ffff800000104ee0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ee7:	80 ff ff 
ffff800000104eea:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
  write_head(); // clear the log
ffff800000104ef1:	48 b8 fd 4d 10 00 00 	movabs $0xffff800000104dfd,%rax
ffff800000104ef8:	80 ff ff 
ffff800000104efb:	ff d0                	call   *%rax
}
ffff800000104efd:	90                   	nop
ffff800000104efe:	5d                   	pop    %rbp
ffff800000104eff:	c3                   	ret

ffff800000104f00 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
ffff800000104f00:	55                   	push   %rbp
ffff800000104f01:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffff800000104f04:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f0b:	80 ff ff 
ffff800000104f0e:	48 89 c7             	mov    %rax,%rdi
ffff800000104f11:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000104f18:	80 ff ff 
ffff800000104f1b:	ff d0                	call   *%rax
  while(1){
    if(log.committing){
ffff800000104f1d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f24:	80 ff ff 
ffff800000104f27:	8b 40 74             	mov    0x74(%rax),%eax
ffff800000104f2a:	85 c0                	test   %eax,%eax
ffff800000104f2c:	74 28                	je     ffff800000104f56 <begin_op+0x56>
      sleep(&log, &log.lock);
ffff800000104f2e:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104f35:	80 ff ff 
ffff800000104f38:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f3f:	80 ff ff 
ffff800000104f42:	48 89 d6             	mov    %rdx,%rsi
ffff800000104f45:	48 89 c7             	mov    %rax,%rdi
ffff800000104f48:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000104f4f:	80 ff ff 
ffff800000104f52:	ff d0                	call   *%rax
ffff800000104f54:	eb c7                	jmp    ffff800000104f1d <begin_op+0x1d>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
ffff800000104f56:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f5d:	80 ff ff 
ffff800000104f60:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff800000104f63:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f6a:	80 ff ff 
ffff800000104f6d:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104f70:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104f73:	89 d0                	mov    %edx,%eax
ffff800000104f75:	c1 e0 02             	shl    $0x2,%eax
ffff800000104f78:	01 d0                	add    %edx,%eax
ffff800000104f7a:	01 c0                	add    %eax,%eax
ffff800000104f7c:	01 c8                	add    %ecx,%eax
ffff800000104f7e:	83 f8 1e             	cmp    $0x1e,%eax
ffff800000104f81:	7e 2b                	jle    ffff800000104fae <begin_op+0xae>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
ffff800000104f83:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104f8a:	80 ff ff 
ffff800000104f8d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f94:	80 ff ff 
ffff800000104f97:	48 89 d6             	mov    %rdx,%rsi
ffff800000104f9a:	48 89 c7             	mov    %rax,%rdi
ffff800000104f9d:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000104fa4:	80 ff ff 
ffff800000104fa7:	ff d0                	call   *%rax
ffff800000104fa9:	e9 6f ff ff ff       	jmp    ffff800000104f1d <begin_op+0x1d>
    } else {
      log.outstanding += 1;
ffff800000104fae:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fb5:	80 ff ff 
ffff800000104fb8:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104fbb:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104fbe:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fc5:	80 ff ff 
ffff800000104fc8:	89 50 70             	mov    %edx,0x70(%rax)
      release(&log.lock);
ffff800000104fcb:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fd2:	80 ff ff 
ffff800000104fd5:	48 89 c7             	mov    %rax,%rdi
ffff800000104fd8:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000104fdf:	80 ff ff 
ffff800000104fe2:	ff d0                	call   *%rax
      break;
ffff800000104fe4:	90                   	nop
    }
  }
}
ffff800000104fe5:	90                   	nop
ffff800000104fe6:	5d                   	pop    %rbp
ffff800000104fe7:	c3                   	ret

ffff800000104fe8 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
ffff800000104fe8:	55                   	push   %rbp
ffff800000104fe9:	48 89 e5             	mov    %rsp,%rbp
ffff800000104fec:	48 83 ec 10          	sub    $0x10,%rsp
  int do_commit = 0;
ffff800000104ff0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  acquire(&log.lock);
ffff800000104ff7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ffe:	80 ff ff 
ffff800000105001:	48 89 c7             	mov    %rax,%rdi
ffff800000105004:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010500b:	80 ff ff 
ffff80000010500e:	ff d0                	call   *%rax
  log.outstanding -= 1;
ffff800000105010:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105017:	80 ff ff 
ffff80000010501a:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010501d:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000105020:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105027:	80 ff ff 
ffff80000010502a:	89 50 70             	mov    %edx,0x70(%rax)
  if(log.committing)
ffff80000010502d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105034:	80 ff ff 
ffff800000105037:	8b 40 74             	mov    0x74(%rax),%eax
ffff80000010503a:	85 c0                	test   %eax,%eax
ffff80000010503c:	74 19                	je     ffff800000105057 <end_op+0x6f>
    panic("log.committing");
ffff80000010503e:	48 b8 28 ca 10 00 00 	movabs $0xffff80000010ca28,%rax
ffff800000105045:	80 ff ff 
ffff800000105048:	48 89 c7             	mov    %rax,%rdi
ffff80000010504b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105052:	80 ff ff 
ffff800000105055:	ff d0                	call   *%rax
  if(log.outstanding == 0){
ffff800000105057:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010505e:	80 ff ff 
ffff800000105061:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105064:	85 c0                	test   %eax,%eax
ffff800000105066:	75 1a                	jne    ffff800000105082 <end_op+0x9a>
    do_commit = 1;
ffff800000105068:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    log.committing = 1;
ffff80000010506f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105076:	80 ff ff 
ffff800000105079:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff800000105080:	eb 19                	jmp    ffff80000010509b <end_op+0xb3>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
ffff800000105082:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105089:	80 ff ff 
ffff80000010508c:	48 89 c7             	mov    %rax,%rdi
ffff80000010508f:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000105096:	80 ff ff 
ffff800000105099:	ff d0                	call   *%rax
  }
  release(&log.lock);
ffff80000010509b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050a2:	80 ff ff 
ffff8000001050a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001050a8:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001050af:	80 ff ff 
ffff8000001050b2:	ff d0                	call   *%rax

  if(do_commit){
ffff8000001050b4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001050b8:	74 68                	je     ffff800000105122 <end_op+0x13a>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
ffff8000001050ba:	48 b8 2f 52 10 00 00 	movabs $0xffff80000010522f,%rax
ffff8000001050c1:	80 ff ff 
ffff8000001050c4:	ff d0                	call   *%rax
    acquire(&log.lock);
ffff8000001050c6:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050cd:	80 ff ff 
ffff8000001050d0:	48 89 c7             	mov    %rax,%rdi
ffff8000001050d3:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001050da:	80 ff ff 
ffff8000001050dd:	ff d0                	call   *%rax
    log.committing = 0;
ffff8000001050df:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050e6:	80 ff ff 
ffff8000001050e9:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
    wakeup(&log);
ffff8000001050f0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050f7:	80 ff ff 
ffff8000001050fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001050fd:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000105104:	80 ff ff 
ffff800000105107:	ff d0                	call   *%rax
    release(&log.lock);
ffff800000105109:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105110:	80 ff ff 
ffff800000105113:	48 89 c7             	mov    %rax,%rdi
ffff800000105116:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010511d:	80 ff ff 
ffff800000105120:	ff d0                	call   *%rax
  }
}
ffff800000105122:	90                   	nop
ffff800000105123:	c9                   	leave
ffff800000105124:	c3                   	ret

ffff800000105125 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
ffff800000105125:	55                   	push   %rbp
ffff800000105126:	48 89 e5             	mov    %rsp,%rbp
ffff800000105129:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff80000010512d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105134:	e9 dc 00 00 00       	jmp    ffff800000105215 <write_log+0xf0>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
ffff800000105139:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105140:	80 ff ff 
ffff800000105143:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000105146:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105149:	01 d0                	add    %edx,%eax
ffff80000010514b:	83 c0 01             	add    $0x1,%eax
ffff80000010514e:	89 c2                	mov    %eax,%edx
ffff800000105150:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105157:	80 ff ff 
ffff80000010515a:	8b 40 78             	mov    0x78(%rax),%eax
ffff80000010515d:	89 d6                	mov    %edx,%esi
ffff80000010515f:	89 c7                	mov    %eax,%edi
ffff800000105161:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105168:	80 ff ff 
ffff80000010516b:	ff d0                	call   *%rax
ffff80000010516d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
ffff800000105171:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105178:	80 ff ff 
ffff80000010517b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010517e:	48 63 d2             	movslq %edx,%rdx
ffff800000105181:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105185:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105189:	89 c2                	mov    %eax,%edx
ffff80000010518b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105192:	80 ff ff 
ffff800000105195:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105198:	89 d6                	mov    %edx,%esi
ffff80000010519a:	89 c7                	mov    %eax,%edi
ffff80000010519c:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001051a3:	80 ff ff 
ffff8000001051a6:	ff d0                	call   *%rax
ffff8000001051a8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(to->data, from->data, BSIZE);
ffff8000001051ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001051b0:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001051b7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001051bb:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff8000001051c1:	ba 00 02 00 00       	mov    $0x200,%edx
ffff8000001051c6:	48 89 ce             	mov    %rcx,%rsi
ffff8000001051c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001051cc:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff8000001051d3:	80 ff ff 
ffff8000001051d6:	ff d0                	call   *%rax
    bwrite(to);  // write the log
ffff8000001051d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001051dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001051df:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff8000001051e6:	80 ff ff 
ffff8000001051e9:	ff d0                	call   *%rax
    brelse(from);
ffff8000001051eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001051ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001051f2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001051f9:	80 ff ff 
ffff8000001051fc:	ff d0                	call   *%rax
    brelse(to);
ffff8000001051fe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105202:	48 89 c7             	mov    %rax,%rdi
ffff800000105205:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010520c:	80 ff ff 
ffff80000010520f:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000105211:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105215:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010521c:	80 ff ff 
ffff80000010521f:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105222:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105225:	0f 8c 0e ff ff ff    	jl     ffff800000105139 <write_log+0x14>
  }
}
ffff80000010522b:	90                   	nop
ffff80000010522c:	90                   	nop
ffff80000010522d:	c9                   	leave
ffff80000010522e:	c3                   	ret

ffff80000010522f <commit>:

static void
commit()
{
ffff80000010522f:	55                   	push   %rbp
ffff800000105230:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffff800000105233:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010523a:	80 ff ff 
ffff80000010523d:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105240:	85 c0                	test   %eax,%eax
ffff800000105242:	7e 41                	jle    ffff800000105285 <commit+0x56>
    write_log();     // Write modified blocks from cache to log
ffff800000105244:	48 b8 25 51 10 00 00 	movabs $0xffff800000105125,%rax
ffff80000010524b:	80 ff ff 
ffff80000010524e:	ff d0                	call   *%rax
    write_head();    // Write header to disk -- the real commit
ffff800000105250:	48 b8 fd 4d 10 00 00 	movabs $0xffff800000104dfd,%rax
ffff800000105257:	80 ff ff 
ffff80000010525a:	ff d0                	call   *%rax
    install_trans(); // Now install writes to home locations
ffff80000010525c:	48 b8 3f 4c 10 00 00 	movabs $0xffff800000104c3f,%rax
ffff800000105263:	80 ff ff 
ffff800000105266:	ff d0                	call   *%rax
    log.lh.n = 0;
ffff800000105268:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010526f:	80 ff ff 
ffff800000105272:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
    write_head();    // Erase the transaction from the log
ffff800000105279:	48 b8 fd 4d 10 00 00 	movabs $0xffff800000104dfd,%rax
ffff800000105280:	80 ff ff 
ffff800000105283:	ff d0                	call   *%rax
  }
}
ffff800000105285:	90                   	nop
ffff800000105286:	5d                   	pop    %rbp
ffff800000105287:	c3                   	ret

ffff800000105288 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffff800000105288:	55                   	push   %rbp
ffff800000105289:	48 89 e5             	mov    %rsp,%rbp
ffff80000010528c:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105290:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffff800000105294:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010529b:	80 ff ff 
ffff80000010529e:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001052a1:	83 f8 1d             	cmp    $0x1d,%eax
ffff8000001052a4:	7f 21                	jg     ffff8000001052c7 <log_write+0x3f>
ffff8000001052a6:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052ad:	80 ff ff 
ffff8000001052b0:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff8000001052b3:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052ba:	80 ff ff 
ffff8000001052bd:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff8000001052c0:	83 e8 01             	sub    $0x1,%eax
ffff8000001052c3:	39 c2                	cmp    %eax,%edx
ffff8000001052c5:	7c 19                	jl     ffff8000001052e0 <log_write+0x58>
    panic("too big a transaction");
ffff8000001052c7:	48 b8 37 ca 10 00 00 	movabs $0xffff80000010ca37,%rax
ffff8000001052ce:	80 ff ff 
ffff8000001052d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001052d4:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001052db:	80 ff ff 
ffff8000001052de:	ff d0                	call   *%rax
  if (log.outstanding < 1)
ffff8000001052e0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052e7:	80 ff ff 
ffff8000001052ea:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001052ed:	85 c0                	test   %eax,%eax
ffff8000001052ef:	7f 19                	jg     ffff80000010530a <log_write+0x82>
    panic("log_write outside of trans");
ffff8000001052f1:	48 b8 4d ca 10 00 00 	movabs $0xffff80000010ca4d,%rax
ffff8000001052f8:	80 ff ff 
ffff8000001052fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001052fe:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105305:	80 ff ff 
ffff800000105308:	ff d0                	call   *%rax

  acquire(&log.lock);
ffff80000010530a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105311:	80 ff ff 
ffff800000105314:	48 89 c7             	mov    %rax,%rdi
ffff800000105317:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010531e:	80 ff ff 
ffff800000105321:	ff d0                	call   *%rax
  for (i = 0; i < log.lh.n; i++) {
ffff800000105323:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010532a:	eb 29                	jmp    ffff800000105355 <log_write+0xcd>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
ffff80000010532c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105333:	80 ff ff 
ffff800000105336:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105339:	48 63 d2             	movslq %edx,%rdx
ffff80000010533c:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105340:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105344:	89 c2                	mov    %eax,%edx
ffff800000105346:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010534a:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010534d:	39 c2                	cmp    %eax,%edx
ffff80000010534f:	74 18                	je     ffff800000105369 <log_write+0xe1>
  for (i = 0; i < log.lh.n; i++) {
ffff800000105351:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105355:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010535c:	80 ff ff 
ffff80000010535f:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105362:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105365:	7c c5                	jl     ffff80000010532c <log_write+0xa4>
ffff800000105367:	eb 01                	jmp    ffff80000010536a <log_write+0xe2>
      break;
ffff800000105369:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
ffff80000010536a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010536e:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000105371:	89 c1                	mov    %eax,%ecx
ffff800000105373:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010537a:	80 ff ff 
ffff80000010537d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105380:	48 63 d2             	movslq %edx,%rdx
ffff800000105383:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105387:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
  if (i == log.lh.n)
ffff80000010538b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105392:	80 ff ff 
ffff800000105395:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105398:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010539b:	75 1d                	jne    ffff8000001053ba <log_write+0x132>
    log.lh.n++;
ffff80000010539d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001053a4:	80 ff ff 
ffff8000001053a7:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053aa:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001053ad:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001053b4:	80 ff ff 
ffff8000001053b7:	89 50 7c             	mov    %edx,0x7c(%rax)
  b->flags |= B_DIRTY; // prevent eviction
ffff8000001053ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053be:	8b 00                	mov    (%rax),%eax
ffff8000001053c0:	83 c8 04             	or     $0x4,%eax
ffff8000001053c3:	89 c2                	mov    %eax,%edx
ffff8000001053c5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053c9:	89 10                	mov    %edx,(%rax)
  release(&log.lock);
ffff8000001053cb:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001053d2:	80 ff ff 
ffff8000001053d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001053d8:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001053df:	80 ff ff 
ffff8000001053e2:	ff d0                	call   *%rax
}
ffff8000001053e4:	90                   	nop
ffff8000001053e5:	c9                   	leave
ffff8000001053e6:	c3                   	ret

ffff8000001053e7 <v2p>:


#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__
static inline addr_t v2p(void *a) {
ffff8000001053e7:	55                   	push   %rbp
ffff8000001053e8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001053eb:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001053ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff8000001053f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001053f7:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001053fe:	80 00 00 
ffff800000105401:	48 01 d0             	add    %rdx,%rax
}
ffff800000105404:	c9                   	leave
ffff800000105405:	c3                   	ret

ffff800000105406 <xchg>:

static inline uint
xchg(volatile uint *addr, addr_t newval)
{
ffff800000105406:	55                   	push   %rbp
ffff800000105407:	48 89 e5             	mov    %rsp,%rbp
ffff80000010540a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010540e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105412:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffff800000105416:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010541a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010541e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000105422:	f0 87 02             	lock xchg %eax,(%rdx)
ffff800000105425:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffff800000105428:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff80000010542b:	c9                   	leave
ffff80000010542c:	c3                   	ret

ffff80000010542d <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffff80000010542d:	55                   	push   %rbp
ffff80000010542e:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffff800000105431:	48 b8 86 a6 10 00 00 	movabs $0xffff80000010a686,%rax
ffff800000105438:	80 ff ff 
ffff80000010543b:	ff d0                	call   *%rax
  kinit1(end, P2V(PHYSTOP)); // phys page allocator
ffff80000010543d:	48 ba 00 00 00 0e 00 	movabs $0xffff80000e000000,%rdx
ffff800000105444:	80 ff ff 
ffff800000105447:	48 b8 00 10 12 00 00 	movabs $0xffff800000121000,%rax
ffff80000010544e:	80 ff ff 
ffff800000105451:	48 89 d6             	mov    %rdx,%rsi
ffff800000105454:	48 89 c7             	mov    %rax,%rdi
ffff800000105457:	48 b8 c2 3f 10 00 00 	movabs $0xffff800000103fc2,%rax
ffff80000010545e:	80 ff ff 
ffff800000105461:	ff d0                	call   *%rax
  kvmalloc();      // kernel page table
ffff800000105463:	48 b8 0e b9 10 00 00 	movabs $0xffff80000010b90e,%rax
ffff80000010546a:	80 ff ff 
ffff80000010546d:	ff d0                	call   *%rax
  mpinit();        // detect other processors
ffff80000010546f:	48 b8 31 5a 10 00 00 	movabs $0xffff800000105a31,%rax
ffff800000105476:	80 ff ff 
ffff800000105479:	ff d0                	call   *%rax
  lapicinit();     // interrupt controller
ffff80000010547b:	48 b8 3d 45 10 00 00 	movabs $0xffff80000010453d,%rax
ffff800000105482:	80 ff ff 
ffff800000105485:	ff d0                	call   *%rax
  tvinit();        // trap vectors
ffff800000105487:	48 b8 74 a1 10 00 00 	movabs $0xffff80000010a174,%rax
ffff80000010548e:	80 ff ff 
ffff800000105491:	ff d0                	call   *%rax
  seginit();       // segment descriptors
ffff800000105493:	48 b8 53 b4 10 00 00 	movabs $0xffff80000010b453,%rax
ffff80000010549a:	80 ff ff 
ffff80000010549d:	ff d0                	call   *%rax
  cprintf("\ncpu%d: starting Spring 2026 xv6\n\n", cpunum());
ffff80000010549f:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff8000001054a6:	80 ff ff 
ffff8000001054a9:	ff d0                	call   *%rax
ffff8000001054ab:	89 c2                	mov    %eax,%edx
ffff8000001054ad:	48 b8 68 ca 10 00 00 	movabs $0xffff80000010ca68,%rax
ffff8000001054b4:	80 ff ff 
ffff8000001054b7:	89 d6                	mov    %edx,%esi
ffff8000001054b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001054bc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001054c1:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001054c8:	80 ff ff 
ffff8000001054cb:	ff d2                	call   *%rdx
  ioapicinit();    // another interrupt controller
ffff8000001054cd:	48 b8 8d 3e 10 00 00 	movabs $0xffff800000103e8d,%rax
ffff8000001054d4:	80 ff ff 
ffff8000001054d7:	ff d0                	call   *%rax
  consoleinit();   // console hardware
ffff8000001054d9:	48 b8 99 14 10 00 00 	movabs $0xffff800000101499,%rax
ffff8000001054e0:	80 ff ff 
ffff8000001054e3:	ff d0                	call   *%rax
  uartinit();      // serial port
ffff8000001054e5:	48 b8 8a a7 10 00 00 	movabs $0xffff80000010a78a,%rax
ffff8000001054ec:	80 ff ff 
ffff8000001054ef:	ff d0                	call   *%rax
  pinit();         // process table
ffff8000001054f1:	48 b8 71 61 10 00 00 	movabs $0xffff800000106171,%rax
ffff8000001054f8:	80 ff ff 
ffff8000001054fb:	ff d0                	call   *%rax
  binit();         // buffer cache
ffff8000001054fd:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff800000105504:	80 ff ff 
ffff800000105507:	ff d0                	call   *%rax
  fileinit();      // file table
ffff800000105509:	48 b8 1d 1b 10 00 00 	movabs $0xffff800000101b1d,%rax
ffff800000105510:	80 ff ff 
ffff800000105513:	ff d0                	call   *%rax
  ideinit();       // disk
ffff800000105515:	48 b8 dc 38 10 00 00 	movabs $0xffff8000001038dc,%rax
ffff80000010551c:	80 ff ff 
ffff80000010551f:	ff d0                	call   *%rax
  startothers();   // start other processors
ffff800000105521:	48 b8 fe 55 10 00 00 	movabs $0xffff8000001055fe,%rax
ffff800000105528:	80 ff ff 
ffff80000010552b:	ff d0                	call   *%rax
  kinit2();
ffff80000010552d:	48 b8 38 40 10 00 00 	movabs $0xffff800000104038,%rax
ffff800000105534:	80 ff ff 
ffff800000105537:	ff d0                	call   *%rax
  userinit();      // first user process
ffff800000105539:	48 b8 62 63 10 00 00 	movabs $0xffff800000106362,%rax
ffff800000105540:	80 ff ff 
ffff800000105543:	ff d0                	call   *%rax
  mpmain();        // finish this processor's setup
ffff800000105545:	48 b8 85 55 10 00 00 	movabs $0xffff800000105585,%rax
ffff80000010554c:	80 ff ff 
ffff80000010554f:	ff d0                	call   *%rax

ffff800000105551 <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffff800000105551:	55                   	push   %rbp
ffff800000105552:	48 89 e5             	mov    %rsp,%rbp
  switchkvm();
ffff800000105555:	48 b8 0f bd 10 00 00 	movabs $0xffff80000010bd0f,%rax
ffff80000010555c:	80 ff ff 
ffff80000010555f:	ff d0                	call   *%rax
  seginit();
ffff800000105561:	48 b8 53 b4 10 00 00 	movabs $0xffff80000010b453,%rax
ffff800000105568:	80 ff ff 
ffff80000010556b:	ff d0                	call   *%rax
  lapicinit();
ffff80000010556d:	48 b8 3d 45 10 00 00 	movabs $0xffff80000010453d,%rax
ffff800000105574:	80 ff ff 
ffff800000105577:	ff d0                	call   *%rax
  mpmain();
ffff800000105579:	48 b8 85 55 10 00 00 	movabs $0xffff800000105585,%rax
ffff800000105580:	80 ff ff 
ffff800000105583:	ff d0                	call   *%rax

ffff800000105585 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffff800000105585:	55                   	push   %rbp
ffff800000105586:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpunum());
ffff800000105589:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff800000105590:	80 ff ff 
ffff800000105593:	ff d0                	call   *%rax
ffff800000105595:	89 c2                	mov    %eax,%edx
ffff800000105597:	48 b8 8b ca 10 00 00 	movabs $0xffff80000010ca8b,%rax
ffff80000010559e:	80 ff ff 
ffff8000001055a1:	89 d6                	mov    %edx,%esi
ffff8000001055a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001055a6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001055ab:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001055b2:	80 ff ff 
ffff8000001055b5:	ff d2                	call   *%rdx
  idtinit();       // load idt register
ffff8000001055b7:	48 b8 4c a1 10 00 00 	movabs $0xffff80000010a14c,%rax
ffff8000001055be:	80 ff ff 
ffff8000001055c1:	ff d0                	call   *%rax
  syscallinit();   // syscall set up
ffff8000001055c3:	48 b8 dc b3 10 00 00 	movabs $0xffff80000010b3dc,%rax
ffff8000001055ca:	80 ff ff 
ffff8000001055cd:	ff d0                	call   *%rax
  xchg(&cpu->started, 1); // tell startothers() we're up
ffff8000001055cf:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001055d6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001055da:	48 83 c0 10          	add    $0x10,%rax
ffff8000001055de:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001055e3:	48 89 c7             	mov    %rax,%rdi
ffff8000001055e6:	48 b8 06 54 10 00 00 	movabs $0xffff800000105406,%rax
ffff8000001055ed:	80 ff ff 
ffff8000001055f0:	ff d0                	call   *%rax
  scheduler();     // start running processes
ffff8000001055f2:	48 b8 b0 6d 10 00 00 	movabs $0xffff800000106db0,%rax
ffff8000001055f9:	80 ff ff 
ffff8000001055fc:	ff d0                	call   *%rax

ffff8000001055fe <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffff8000001055fe:	55                   	push   %rbp
ffff8000001055ff:	48 89 e5             	mov    %rsp,%rbp
ffff800000105602:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
ffff800000105606:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff80000010560d:	80 ff ff 
ffff800000105610:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_entryother_start,
ffff800000105614:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff80000010561b:	00 00 00 
ffff80000010561e:	89 c2                	mov    %eax,%edx
ffff800000105620:	48 b9 98 de 10 00 00 	movabs $0xffff80000010de98,%rcx
ffff800000105627:	80 ff ff 
ffff80000010562a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010562e:	48 89 ce             	mov    %rcx,%rsi
ffff800000105631:	48 89 c7             	mov    %rax,%rdi
ffff800000105634:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff80000010563b:	80 ff ff 
ffff80000010563e:	ff d0                	call   *%rax
          (addr_t)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
ffff800000105640:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105647:	80 ff ff 
ffff80000010564a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010564e:	e9 c6 00 00 00       	jmp    ffff800000105719 <startothers+0x11b>
    if(c == cpus+cpunum())  // We've started already.
ffff800000105653:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff80000010565a:	80 ff ff 
ffff80000010565d:	ff d0                	call   *%rax
ffff80000010565f:	48 63 d0             	movslq %eax,%rdx
ffff800000105662:	48 89 d0             	mov    %rdx,%rax
ffff800000105665:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105669:	48 01 d0             	add    %rdx,%rax
ffff80000010566c:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105670:	48 89 c2             	mov    %rax,%rdx
ffff800000105673:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff80000010567a:	80 ff ff 
ffff80000010567d:	48 01 d0             	add    %rdx,%rax
ffff800000105680:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105684:	0f 84 89 00 00 00    	je     ffff800000105713 <startothers+0x115>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffff80000010568a:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000105691:	80 ff ff 
ffff800000105694:	ff d0                	call   *%rax
ffff800000105696:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    *(uint32*)(code-4) = 0x8000; // enough stack to get us to entry64mp
ffff80000010569a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010569e:	48 83 e8 04          	sub    $0x4,%rax
ffff8000001056a2:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffff8000001056a8:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff8000001056af:	80 ff ff 
ffff8000001056b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001056b5:	48 b8 e7 53 10 00 00 	movabs $0xffff8000001053e7,%rax
ffff8000001056bc:	80 ff ff 
ffff8000001056bf:	ff d0                	call   *%rax
ffff8000001056c1:	48 89 c2             	mov    %rax,%rdx
ffff8000001056c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001056c8:	48 83 e8 08          	sub    $0x8,%rax
ffff8000001056cc:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffff8000001056ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001056d2:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff8000001056d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001056dd:	48 83 e8 10          	sub    $0x10,%rax
ffff8000001056e1:	48 89 10             	mov    %rdx,(%rax)

    lapicstartap(c->apicid, V2P(code));
ffff8000001056e4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001056e8:	89 c2                	mov    %eax,%edx
ffff8000001056ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001056ee:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff8000001056f2:	0f b6 c0             	movzbl %al,%eax
ffff8000001056f5:	89 d6                	mov    %edx,%esi
ffff8000001056f7:	89 c7                	mov    %eax,%edi
ffff8000001056f9:	48 b8 10 48 10 00 00 	movabs $0xffff800000104810,%rax
ffff800000105700:	80 ff ff 
ffff800000105703:	ff d0                	call   *%rax

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffff800000105705:	90                   	nop
ffff800000105706:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010570a:	8b 40 10             	mov    0x10(%rax),%eax
ffff80000010570d:	85 c0                	test   %eax,%eax
ffff80000010570f:	74 f5                	je     ffff800000105706 <startothers+0x108>
ffff800000105711:	eb 01                	jmp    ffff800000105714 <startothers+0x116>
      continue;
ffff800000105713:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffff800000105714:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000105719:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105720:	80 ff ff 
ffff800000105723:	8b 00                	mov    (%rax),%eax
ffff800000105725:	48 63 d0             	movslq %eax,%rdx
ffff800000105728:	48 89 d0             	mov    %rdx,%rax
ffff80000010572b:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010572f:	48 01 d0             	add    %rdx,%rax
ffff800000105732:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105736:	48 89 c2             	mov    %rax,%rdx
ffff800000105739:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105740:	80 ff ff 
ffff800000105743:	48 01 d0             	add    %rdx,%rax
ffff800000105746:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010574a:	0f 82 03 ff ff ff    	jb     ffff800000105653 <startothers+0x55>
      ;
  }
}
ffff800000105750:	90                   	nop
ffff800000105751:	90                   	nop
ffff800000105752:	c9                   	leave
ffff800000105753:	c3                   	ret

ffff800000105754 <inb>:
{
ffff800000105754:	55                   	push   %rbp
ffff800000105755:	48 89 e5             	mov    %rsp,%rbp
ffff800000105758:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010575c:	89 f8                	mov    %edi,%eax
ffff80000010575e:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000105762:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000105766:	89 c2                	mov    %eax,%edx
ffff800000105768:	ec                   	in     (%dx),%al
ffff800000105769:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010576c:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000105770:	c9                   	leave
ffff800000105771:	c3                   	ret

ffff800000105772 <outb>:
{
ffff800000105772:	55                   	push   %rbp
ffff800000105773:	48 89 e5             	mov    %rsp,%rbp
ffff800000105776:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010577a:	89 fa                	mov    %edi,%edx
ffff80000010577c:	89 f0                	mov    %esi,%eax
ffff80000010577e:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000105782:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000105785:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000105789:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010578d:	ee                   	out    %al,(%dx)
}
ffff80000010578e:	90                   	nop
ffff80000010578f:	c9                   	leave
ffff800000105790:	c3                   	ret

ffff800000105791 <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
ffff800000105791:	55                   	push   %rbp
ffff800000105792:	48 89 e5             	mov    %rsp,%rbp
ffff800000105795:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105799:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010579d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, sum;

  sum = 0;
ffff8000001057a0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff8000001057a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001057ae:	eb 1a                	jmp    ffff8000001057ca <sum+0x39>
    sum += addr[i];
ffff8000001057b0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001057b3:	48 63 d0             	movslq %eax,%rdx
ffff8000001057b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001057ba:	48 01 d0             	add    %rdx,%rax
ffff8000001057bd:	0f b6 00             	movzbl (%rax),%eax
ffff8000001057c0:	0f b6 c0             	movzbl %al,%eax
ffff8000001057c3:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff8000001057c6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001057ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001057cd:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff8000001057d0:	7c de                	jl     ffff8000001057b0 <sum+0x1f>
  return sum;
ffff8000001057d2:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff8000001057d5:	c9                   	leave
ffff8000001057d6:	c3                   	ret

ffff8000001057d7 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(addr_t a, int len)
{
ffff8000001057d7:	55                   	push   %rbp
ffff8000001057d8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001057db:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001057df:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001057e3:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uchar *e, *p, *addr;
  addr = P2V(a);
ffff8000001057e6:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff8000001057ed:	80 ff ff 
ffff8000001057f0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001057f4:	48 01 d0             	add    %rdx,%rax
ffff8000001057f7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffff8000001057fb:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001057fe:	48 63 d0             	movslq %eax,%rdx
ffff800000105801:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105805:	48 01 d0             	add    %rdx,%rax
ffff800000105808:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffff80000010580c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105810:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105814:	eb 50                	jmp    ffff800000105866 <mpsearch1+0x8f>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffff800000105816:	48 b9 a0 ca 10 00 00 	movabs $0xffff80000010caa0,%rcx
ffff80000010581d:	80 ff ff 
ffff800000105820:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105824:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105829:	48 89 ce             	mov    %rcx,%rsi
ffff80000010582c:	48 89 c7             	mov    %rax,%rdi
ffff80000010582f:	48 b8 0f 7b 10 00 00 	movabs $0xffff800000107b0f,%rax
ffff800000105836:	80 ff ff 
ffff800000105839:	ff d0                	call   *%rax
ffff80000010583b:	85 c0                	test   %eax,%eax
ffff80000010583d:	75 22                	jne    ffff800000105861 <mpsearch1+0x8a>
ffff80000010583f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105843:	be 10 00 00 00       	mov    $0x10,%esi
ffff800000105848:	48 89 c7             	mov    %rax,%rdi
ffff80000010584b:	48 b8 91 57 10 00 00 	movabs $0xffff800000105791,%rax
ffff800000105852:	80 ff ff 
ffff800000105855:	ff d0                	call   *%rax
ffff800000105857:	84 c0                	test   %al,%al
ffff800000105859:	75 06                	jne    ffff800000105861 <mpsearch1+0x8a>
      return (struct mp*)p;
ffff80000010585b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010585f:	eb 14                	jmp    ffff800000105875 <mpsearch1+0x9e>
  for(p = addr; p < e; p += sizeof(struct mp))
ffff800000105861:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff800000105866:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010586a:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff80000010586e:	72 a6                	jb     ffff800000105816 <mpsearch1+0x3f>
  return 0;
ffff800000105870:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000105875:	c9                   	leave
ffff800000105876:	c3                   	ret

ffff800000105877 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffff800000105877:	55                   	push   %rbp
ffff800000105878:	48 89 e5             	mov    %rsp,%rbp
ffff80000010587b:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffff80000010587f:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff800000105886:	80 ff ff 
ffff800000105889:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffff80000010588d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105891:	48 83 c0 0f          	add    $0xf,%rax
ffff800000105895:	0f b6 00             	movzbl (%rax),%eax
ffff800000105898:	0f b6 c0             	movzbl %al,%eax
ffff80000010589b:	c1 e0 08             	shl    $0x8,%eax
ffff80000010589e:	89 c2                	mov    %eax,%edx
ffff8000001058a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058a4:	48 83 c0 0e          	add    $0xe,%rax
ffff8000001058a8:	0f b6 00             	movzbl (%rax),%eax
ffff8000001058ab:	0f b6 c0             	movzbl %al,%eax
ffff8000001058ae:	09 d0                	or     %edx,%eax
ffff8000001058b0:	c1 e0 04             	shl    $0x4,%eax
ffff8000001058b3:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff8000001058b6:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff8000001058ba:	74 28                	je     ffff8000001058e4 <mpsearch+0x6d>
    if((mp = mpsearch1(p, 1024)))
ffff8000001058bc:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001058bf:	be 00 04 00 00       	mov    $0x400,%esi
ffff8000001058c4:	48 89 c7             	mov    %rax,%rdi
ffff8000001058c7:	48 b8 d7 57 10 00 00 	movabs $0xffff8000001057d7,%rax
ffff8000001058ce:	80 ff ff 
ffff8000001058d1:	ff d0                	call   *%rax
ffff8000001058d3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001058d7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001058dc:	74 5e                	je     ffff80000010593c <mpsearch+0xc5>
      return mp;
ffff8000001058de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001058e2:	eb 6e                	jmp    ffff800000105952 <mpsearch+0xdb>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffff8000001058e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058e8:	48 83 c0 14          	add    $0x14,%rax
ffff8000001058ec:	0f b6 00             	movzbl (%rax),%eax
ffff8000001058ef:	0f b6 c0             	movzbl %al,%eax
ffff8000001058f2:	c1 e0 08             	shl    $0x8,%eax
ffff8000001058f5:	89 c2                	mov    %eax,%edx
ffff8000001058f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058fb:	48 83 c0 13          	add    $0x13,%rax
ffff8000001058ff:	0f b6 00             	movzbl (%rax),%eax
ffff800000105902:	0f b6 c0             	movzbl %al,%eax
ffff800000105905:	09 d0                	or     %edx,%eax
ffff800000105907:	c1 e0 0a             	shl    $0xa,%eax
ffff80000010590a:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffff80000010590d:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105910:	2d 00 04 00 00       	sub    $0x400,%eax
ffff800000105915:	89 c0                	mov    %eax,%eax
ffff800000105917:	be 00 04 00 00       	mov    $0x400,%esi
ffff80000010591c:	48 89 c7             	mov    %rax,%rdi
ffff80000010591f:	48 b8 d7 57 10 00 00 	movabs $0xffff8000001057d7,%rax
ffff800000105926:	80 ff ff 
ffff800000105929:	ff d0                	call   *%rax
ffff80000010592b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010592f:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105934:	74 06                	je     ffff80000010593c <mpsearch+0xc5>
      return mp;
ffff800000105936:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010593a:	eb 16                	jmp    ffff800000105952 <mpsearch+0xdb>
  }
  return mpsearch1(0xF0000, 0x10000);
ffff80000010593c:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000105941:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff800000105946:	48 b8 d7 57 10 00 00 	movabs $0xffff8000001057d7,%rax
ffff80000010594d:	80 ff ff 
ffff800000105950:	ff d0                	call   *%rax
}
ffff800000105952:	c9                   	leave
ffff800000105953:	c3                   	ret

ffff800000105954 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffff800000105954:	55                   	push   %rbp
ffff800000105955:	48 89 e5             	mov    %rsp,%rbp
ffff800000105958:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010595c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffff800000105960:	48 b8 77 58 10 00 00 	movabs $0xffff800000105877,%rax
ffff800000105967:	80 ff ff 
ffff80000010596a:	ff d0                	call   *%rax
ffff80000010596c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105970:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105975:	74 0b                	je     ffff800000105982 <mpconfig+0x2e>
ffff800000105977:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010597b:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010597e:	85 c0                	test   %eax,%eax
ffff800000105980:	75 0a                	jne    ffff80000010598c <mpconfig+0x38>
    return 0;
ffff800000105982:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105987:	e9 a3 00 00 00       	jmp    ffff800000105a2f <mpconfig+0xdb>
  conf = (struct mpconf*) P2V((addr_t) mp->physaddr);
ffff80000010598c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105990:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105993:	89 c2                	mov    %eax,%edx
ffff800000105995:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010599c:	80 ff ff 
ffff80000010599f:	48 01 d0             	add    %rdx,%rax
ffff8000001059a2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffff8000001059a6:	48 b9 a5 ca 10 00 00 	movabs $0xffff80000010caa5,%rcx
ffff8000001059ad:	80 ff ff 
ffff8000001059b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059b4:	ba 04 00 00 00       	mov    $0x4,%edx
ffff8000001059b9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001059bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001059bf:	48 b8 0f 7b 10 00 00 	movabs $0xffff800000107b0f,%rax
ffff8000001059c6:	80 ff ff 
ffff8000001059c9:	ff d0                	call   *%rax
ffff8000001059cb:	85 c0                	test   %eax,%eax
ffff8000001059cd:	74 07                	je     ffff8000001059d6 <mpconfig+0x82>
    return 0;
ffff8000001059cf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001059d4:	eb 59                	jmp    ffff800000105a2f <mpconfig+0xdb>
  if(conf->version != 1 && conf->version != 4)
ffff8000001059d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059da:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff8000001059de:	3c 01                	cmp    $0x1,%al
ffff8000001059e0:	74 13                	je     ffff8000001059f5 <mpconfig+0xa1>
ffff8000001059e2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059e6:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff8000001059ea:	3c 04                	cmp    $0x4,%al
ffff8000001059ec:	74 07                	je     ffff8000001059f5 <mpconfig+0xa1>
    return 0;
ffff8000001059ee:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001059f3:	eb 3a                	jmp    ffff800000105a2f <mpconfig+0xdb>
  if(sum((uchar*)conf, conf->length) != 0)
ffff8000001059f5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059f9:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff8000001059fd:	0f b7 d0             	movzwl %ax,%edx
ffff800000105a00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a04:	89 d6                	mov    %edx,%esi
ffff800000105a06:	48 89 c7             	mov    %rax,%rdi
ffff800000105a09:	48 b8 91 57 10 00 00 	movabs $0xffff800000105791,%rax
ffff800000105a10:	80 ff ff 
ffff800000105a13:	ff d0                	call   *%rax
ffff800000105a15:	84 c0                	test   %al,%al
ffff800000105a17:	74 07                	je     ffff800000105a20 <mpconfig+0xcc>
    return 0;
ffff800000105a19:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105a1e:	eb 0f                	jmp    ffff800000105a2f <mpconfig+0xdb>
  *pmp = mp;
ffff800000105a20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105a24:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105a28:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffff800000105a2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000105a2f:	c9                   	leave
ffff800000105a30:	c3                   	ret

ffff800000105a31 <mpinit>:

void
mpinit(void)
{
ffff800000105a31:	55                   	push   %rbp
ffff800000105a32:	48 89 e5             	mov    %rsp,%rbp
ffff800000105a35:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0) {
ffff800000105a39:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000105a3d:	48 89 c7             	mov    %rax,%rdi
ffff800000105a40:	48 b8 54 59 10 00 00 	movabs $0xffff800000105954,%rax
ffff800000105a47:	80 ff ff 
ffff800000105a4a:	ff d0                	call   *%rax
ffff800000105a4c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105a50:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105a55:	75 23                	jne    ffff800000105a7a <mpinit+0x49>
    cprintf("No other CPUs found.\n");
ffff800000105a57:	48 b8 aa ca 10 00 00 	movabs $0xffff80000010caaa,%rax
ffff800000105a5e:	80 ff ff 
ffff800000105a61:	48 89 c7             	mov    %rax,%rdi
ffff800000105a64:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105a69:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105a70:	80 ff ff 
ffff800000105a73:	ff d2                	call   *%rdx
ffff800000105a75:	e9 c9 01 00 00       	jmp    ffff800000105c43 <mpinit+0x212>
    return;
  }
  lapic = P2V((addr_t)conf->lapicaddr_p);
ffff800000105a7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a7e:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105a81:	89 c2                	mov    %eax,%edx
ffff800000105a83:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105a8a:	80 ff ff 
ffff800000105a8d:	48 01 d0             	add    %rdx,%rax
ffff800000105a90:	48 89 c2             	mov    %rax,%rdx
ffff800000105a93:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000105a9a:	80 ff ff 
ffff800000105a9d:	48 89 10             	mov    %rdx,(%rax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105aa0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105aa4:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105aa8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105aac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105ab0:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105ab4:	0f b7 d0             	movzwl %ax,%edx
ffff800000105ab7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105abb:	48 01 d0             	add    %rdx,%rax
ffff800000105abe:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105ac2:	e9 f6 00 00 00       	jmp    ffff800000105bbd <mpinit+0x18c>
    switch(*p){
ffff800000105ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105acb:	0f b6 00             	movzbl (%rax),%eax
ffff800000105ace:	0f b6 c0             	movzbl %al,%eax
ffff800000105ad1:	83 f8 04             	cmp    $0x4,%eax
ffff800000105ad4:	0f 8f ca 00 00 00    	jg     ffff800000105ba4 <mpinit+0x173>
ffff800000105ada:	83 f8 03             	cmp    $0x3,%eax
ffff800000105add:	0f 8d ba 00 00 00    	jge    ffff800000105b9d <mpinit+0x16c>
ffff800000105ae3:	83 f8 02             	cmp    $0x2,%eax
ffff800000105ae6:	0f 84 8e 00 00 00    	je     ffff800000105b7a <mpinit+0x149>
ffff800000105aec:	83 f8 02             	cmp    $0x2,%eax
ffff800000105aef:	0f 8f af 00 00 00    	jg     ffff800000105ba4 <mpinit+0x173>
ffff800000105af5:	85 c0                	test   %eax,%eax
ffff800000105af7:	74 0e                	je     ffff800000105b07 <mpinit+0xd6>
ffff800000105af9:	83 f8 01             	cmp    $0x1,%eax
ffff800000105afc:	0f 84 9b 00 00 00    	je     ffff800000105b9d <mpinit+0x16c>
ffff800000105b02:	e9 9d 00 00 00       	jmp    ffff800000105ba4 <mpinit+0x173>
    case MPPROC:
      proc = (struct mpproc*)p;
ffff800000105b07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b0b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      if(ncpu < NCPU) {
ffff800000105b0f:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b16:	80 ff ff 
ffff800000105b19:	8b 00                	mov    (%rax),%eax
ffff800000105b1b:	83 f8 07             	cmp    $0x7,%eax
ffff800000105b1e:	7f 53                	jg     ffff800000105b73 <mpinit+0x142>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
ffff800000105b20:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b27:	80 ff ff 
ffff800000105b2a:	8b 10                	mov    (%rax),%edx
ffff800000105b2c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105b30:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105b34:	48 be e0 72 11 00 00 	movabs $0xffff8000001172e0,%rsi
ffff800000105b3b:	80 ff ff 
ffff800000105b3e:	48 63 d2             	movslq %edx,%rdx
ffff800000105b41:	48 89 d0             	mov    %rdx,%rax
ffff800000105b44:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105b48:	48 01 d0             	add    %rdx,%rax
ffff800000105b4b:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105b4f:	48 01 f0             	add    %rsi,%rax
ffff800000105b52:	48 83 c0 01          	add    $0x1,%rax
ffff800000105b56:	88 08                	mov    %cl,(%rax)
        ncpu++;
ffff800000105b58:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b5f:	80 ff ff 
ffff800000105b62:	8b 00                	mov    (%rax),%eax
ffff800000105b64:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105b67:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b6e:	80 ff ff 
ffff800000105b71:	89 10                	mov    %edx,(%rax)
      }
      p += sizeof(struct mpproc);
ffff800000105b73:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffff800000105b78:	eb 43                	jmp    ffff800000105bbd <mpinit+0x18c>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffff800000105b7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b7e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffff800000105b82:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105b86:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105b8a:	48 ba 24 74 11 00 00 	movabs $0xffff800000117424,%rdx
ffff800000105b91:	80 ff ff 
ffff800000105b94:	88 02                	mov    %al,(%rdx)
      p += sizeof(struct mpioapic);
ffff800000105b96:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105b9b:	eb 20                	jmp    ffff800000105bbd <mpinit+0x18c>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffff800000105b9d:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105ba2:	eb 19                	jmp    ffff800000105bbd <mpinit+0x18c>
    default:
      panic("Major problem parsing mp config.");
ffff800000105ba4:	48 b8 c0 ca 10 00 00 	movabs $0xffff80000010cac0,%rax
ffff800000105bab:	80 ff ff 
ffff800000105bae:	48 89 c7             	mov    %rax,%rdi
ffff800000105bb1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105bb8:	80 ff ff 
ffff800000105bbb:	ff d0                	call   *%rax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105bbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105bc1:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105bc5:	0f 82 fc fe ff ff    	jb     ffff800000105ac7 <mpinit+0x96>
      break;
    }
  }
  cprintf("Seems we are SMP, ncpu = %d\n",ncpu);
ffff800000105bcb:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105bd2:	80 ff ff 
ffff800000105bd5:	8b 00                	mov    (%rax),%eax
ffff800000105bd7:	48 ba e1 ca 10 00 00 	movabs $0xffff80000010cae1,%rdx
ffff800000105bde:	80 ff ff 
ffff800000105be1:	89 c6                	mov    %eax,%esi
ffff800000105be3:	48 89 d7             	mov    %rdx,%rdi
ffff800000105be6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105beb:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105bf2:	80 ff ff 
ffff800000105bf5:	ff d2                	call   *%rdx
  if(mp->imcrp){
ffff800000105bf7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105bfb:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105bff:	84 c0                	test   %al,%al
ffff800000105c01:	74 40                	je     ffff800000105c43 <mpinit+0x212>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffff800000105c03:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105c08:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105c0d:	48 b8 72 57 10 00 00 	movabs $0xffff800000105772,%rax
ffff800000105c14:	80 ff ff 
ffff800000105c17:	ff d0                	call   *%rax
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffff800000105c19:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105c1e:	48 b8 54 57 10 00 00 	movabs $0xffff800000105754,%rax
ffff800000105c25:	80 ff ff 
ffff800000105c28:	ff d0                	call   *%rax
ffff800000105c2a:	83 c8 01             	or     $0x1,%eax
ffff800000105c2d:	0f b6 c0             	movzbl %al,%eax
ffff800000105c30:	89 c6                	mov    %eax,%esi
ffff800000105c32:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105c37:	48 b8 72 57 10 00 00 	movabs $0xffff800000105772,%rax
ffff800000105c3e:	80 ff ff 
ffff800000105c41:	ff d0                	call   *%rax
  }
}
ffff800000105c43:	c9                   	leave
ffff800000105c44:	c3                   	ret

ffff800000105c45 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffff800000105c45:	55                   	push   %rbp
ffff800000105c46:	48 89 e5             	mov    %rsp,%rbp
ffff800000105c49:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105c4d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105c51:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffff800000105c55:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105c5c:	00 
  *f0 = *f1 = 0;
ffff800000105c5d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c61:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105c68:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c6c:	48 8b 10             	mov    (%rax),%rdx
ffff800000105c6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c73:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffff800000105c76:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000105c7d:	80 ff ff 
ffff800000105c80:	ff d0                	call   *%rax
ffff800000105c82:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105c86:	48 89 02             	mov    %rax,(%rdx)
ffff800000105c89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c8d:	48 8b 00             	mov    (%rax),%rax
ffff800000105c90:	48 85 c0             	test   %rax,%rax
ffff800000105c93:	0f 84 01 01 00 00    	je     ffff800000105d9a <pipealloc+0x155>
ffff800000105c99:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000105ca0:	80 ff ff 
ffff800000105ca3:	ff d0                	call   *%rax
ffff800000105ca5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105ca9:	48 89 02             	mov    %rax,(%rdx)
ffff800000105cac:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105cb0:	48 8b 00             	mov    (%rax),%rax
ffff800000105cb3:	48 85 c0             	test   %rax,%rax
ffff800000105cb6:	0f 84 de 00 00 00    	je     ffff800000105d9a <pipealloc+0x155>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffff800000105cbc:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000105cc3:	80 ff ff 
ffff800000105cc6:	ff d0                	call   *%rax
ffff800000105cc8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105ccc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105cd1:	0f 84 c6 00 00 00    	je     ffff800000105d9d <pipealloc+0x158>
    goto bad;
  p->readopen = 1;
ffff800000105cd7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cdb:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105ce2:	00 00 00 
  p->writeopen = 1;
ffff800000105ce5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ce9:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105cf0:	00 00 00 
  p->nwrite = 0;
ffff800000105cf3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cf7:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105cfe:	00 00 00 
  p->nread = 0;
ffff800000105d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d05:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105d0c:	00 00 00 
  initlock(&p->lock, "pipe");
ffff800000105d0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d13:	48 ba fe ca 10 00 00 	movabs $0xffff80000010cafe,%rdx
ffff800000105d1a:	80 ff ff 
ffff800000105d1d:	48 89 d6             	mov    %rdx,%rsi
ffff800000105d20:	48 89 c7             	mov    %rax,%rdi
ffff800000105d23:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000105d2a:	80 ff ff 
ffff800000105d2d:	ff d0                	call   *%rax
  (*f0)->type = FD_PIPE;
ffff800000105d2f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d33:	48 8b 00             	mov    (%rax),%rax
ffff800000105d36:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffff800000105d3c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d40:	48 8b 00             	mov    (%rax),%rax
ffff800000105d43:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffff800000105d47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d4b:	48 8b 00             	mov    (%rax),%rax
ffff800000105d4e:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffff800000105d52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d56:	48 8b 00             	mov    (%rax),%rax
ffff800000105d59:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105d5d:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffff800000105d61:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d65:	48 8b 00             	mov    (%rax),%rax
ffff800000105d68:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffff800000105d6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d72:	48 8b 00             	mov    (%rax),%rax
ffff800000105d75:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffff800000105d79:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d7d:	48 8b 00             	mov    (%rax),%rax
ffff800000105d80:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffff800000105d84:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d88:	48 8b 00             	mov    (%rax),%rax
ffff800000105d8b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105d8f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffff800000105d93:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105d98:	eb 67                	jmp    ffff800000105e01 <pipealloc+0x1bc>
    goto bad;
ffff800000105d9a:	90                   	nop
ffff800000105d9b:	eb 01                	jmp    ffff800000105d9e <pipealloc+0x159>
    goto bad;
ffff800000105d9d:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffff800000105d9e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105da3:	74 13                	je     ffff800000105db8 <pipealloc+0x173>
    kfree((char*)p);
ffff800000105da5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105da9:	48 89 c7             	mov    %rax,%rdi
ffff800000105dac:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000105db3:	80 ff ff 
ffff800000105db6:	ff d0                	call   *%rax
  if(*f0)
ffff800000105db8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105dbc:	48 8b 00             	mov    (%rax),%rax
ffff800000105dbf:	48 85 c0             	test   %rax,%rax
ffff800000105dc2:	74 16                	je     ffff800000105dda <pipealloc+0x195>
    fileclose(*f0);
ffff800000105dc4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105dc8:	48 8b 00             	mov    (%rax),%rax
ffff800000105dcb:	48 89 c7             	mov    %rax,%rdi
ffff800000105dce:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000105dd5:	80 ff ff 
ffff800000105dd8:	ff d0                	call   *%rax
  if(*f1)
ffff800000105dda:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105dde:	48 8b 00             	mov    (%rax),%rax
ffff800000105de1:	48 85 c0             	test   %rax,%rax
ffff800000105de4:	74 16                	je     ffff800000105dfc <pipealloc+0x1b7>
    fileclose(*f1);
ffff800000105de6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105dea:	48 8b 00             	mov    (%rax),%rax
ffff800000105ded:	48 89 c7             	mov    %rax,%rdi
ffff800000105df0:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000105df7:	80 ff ff 
ffff800000105dfa:	ff d0                	call   *%rax
  return -1;
ffff800000105dfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000105e01:	c9                   	leave
ffff800000105e02:	c3                   	ret

ffff800000105e03 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffff800000105e03:	55                   	push   %rbp
ffff800000105e04:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e07:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000105e0b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105e0f:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffff800000105e12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e16:	48 89 c7             	mov    %rax,%rdi
ffff800000105e19:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000105e20:	80 ff ff 
ffff800000105e23:	ff d0                	call   *%rax
  if(writable){
ffff800000105e25:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105e29:	74 29                	je     ffff800000105e54 <pipeclose+0x51>
    p->writeopen = 0;
ffff800000105e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e2f:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000105e36:	00 00 00 
    wakeup(&p->nread);
ffff800000105e39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e3d:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105e43:	48 89 c7             	mov    %rax,%rdi
ffff800000105e46:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000105e4d:	80 ff ff 
ffff800000105e50:	ff d0                	call   *%rax
ffff800000105e52:	eb 27                	jmp    ffff800000105e7b <pipeclose+0x78>
  } else {
    p->readopen = 0;
ffff800000105e54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e58:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff800000105e5f:	00 00 00 
    wakeup(&p->nwrite);
ffff800000105e62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e66:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff800000105e6c:	48 89 c7             	mov    %rax,%rdi
ffff800000105e6f:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000105e76:	80 ff ff 
ffff800000105e79:	ff d0                	call   *%rax
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffff800000105e7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e7f:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000105e85:	85 c0                	test   %eax,%eax
ffff800000105e87:	75 36                	jne    ffff800000105ebf <pipeclose+0xbc>
ffff800000105e89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e8d:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff800000105e93:	85 c0                	test   %eax,%eax
ffff800000105e95:	75 28                	jne    ffff800000105ebf <pipeclose+0xbc>
    release(&p->lock);
ffff800000105e97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e9b:	48 89 c7             	mov    %rax,%rdi
ffff800000105e9e:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000105ea5:	80 ff ff 
ffff800000105ea8:	ff d0                	call   *%rax
    kfree((char*)p);
ffff800000105eaa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105eae:	48 89 c7             	mov    %rax,%rdi
ffff800000105eb1:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000105eb8:	80 ff ff 
ffff800000105ebb:	ff d0                	call   *%rax
ffff800000105ebd:	eb 14                	jmp    ffff800000105ed3 <pipeclose+0xd0>
  } else
    release(&p->lock);
ffff800000105ebf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ec3:	48 89 c7             	mov    %rax,%rdi
ffff800000105ec6:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000105ecd:	80 ff ff 
ffff800000105ed0:	ff d0                	call   *%rax
}
ffff800000105ed2:	90                   	nop
ffff800000105ed3:	90                   	nop
ffff800000105ed4:	c9                   	leave
ffff800000105ed5:	c3                   	ret

ffff800000105ed6 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffff800000105ed6:	55                   	push   %rbp
ffff800000105ed7:	48 89 e5             	mov    %rsp,%rbp
ffff800000105eda:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105ede:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105ee2:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000105ee6:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff800000105ee9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105eed:	48 89 c7             	mov    %rax,%rdi
ffff800000105ef0:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000105ef7:	80 ff ff 
ffff800000105efa:	ff d0                	call   *%rax
  for(i = 0; i < n; i++){
ffff800000105efc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105f03:	e9 d5 00 00 00       	jmp    ffff800000105fdd <pipewrite+0x107>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffff800000105f08:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f0c:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000105f12:	85 c0                	test   %eax,%eax
ffff800000105f14:	74 12                	je     ffff800000105f28 <pipewrite+0x52>
ffff800000105f16:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000105f1d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000105f21:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000105f24:	85 c0                	test   %eax,%eax
ffff800000105f26:	74 1d                	je     ffff800000105f45 <pipewrite+0x6f>
        release(&p->lock);
ffff800000105f28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f2c:	48 89 c7             	mov    %rax,%rdi
ffff800000105f2f:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000105f36:	80 ff ff 
ffff800000105f39:	ff d0                	call   *%rax
        return -1;
ffff800000105f3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000105f40:	e9 cf 00 00 00       	jmp    ffff800000106014 <pipewrite+0x13e>
      }
      wakeup(&p->nread);
ffff800000105f45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f49:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105f4f:	48 89 c7             	mov    %rax,%rdi
ffff800000105f52:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000105f59:	80 ff ff 
ffff800000105f5c:	ff d0                	call   *%rax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffff800000105f5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f62:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105f66:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff800000105f6d:	48 89 c6             	mov    %rax,%rsi
ffff800000105f70:	48 89 d7             	mov    %rdx,%rdi
ffff800000105f73:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000105f7a:	80 ff ff 
ffff800000105f7d:	ff d0                	call   *%rax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffff800000105f7f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f83:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff800000105f89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f8d:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff800000105f93:	05 00 02 00 00       	add    $0x200,%eax
ffff800000105f98:	39 c2                	cmp    %eax,%edx
ffff800000105f9a:	0f 84 68 ff ff ff    	je     ffff800000105f08 <pipewrite+0x32>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffff800000105fa0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105fa3:	48 63 d0             	movslq %eax,%rdx
ffff800000105fa6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105faa:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff800000105fae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fb2:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000105fb8:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000105fbb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105fbf:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff800000105fc5:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000105fca:	89 c1                	mov    %eax,%ecx
ffff800000105fcc:	0f b6 16             	movzbl (%rsi),%edx
ffff800000105fcf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fd3:	89 c9                	mov    %ecx,%ecx
ffff800000105fd5:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffff800000105fd9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105fdd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105fe0:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000105fe3:	7c 9a                	jl     ffff800000105f7f <pipewrite+0xa9>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffff800000105fe5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fe9:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105fef:	48 89 c7             	mov    %rax,%rdi
ffff800000105ff2:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000105ff9:	80 ff ff 
ffff800000105ffc:	ff d0                	call   *%rax
  release(&p->lock);
ffff800000105ffe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106002:	48 89 c7             	mov    %rax,%rdi
ffff800000106005:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010600c:	80 ff ff 
ffff80000010600f:	ff d0                	call   *%rax
  return n;
ffff800000106011:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000106014:	c9                   	leave
ffff800000106015:	c3                   	ret

ffff800000106016 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffff800000106016:	55                   	push   %rbp
ffff800000106017:	48 89 e5             	mov    %rsp,%rbp
ffff80000010601a:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010601e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000106022:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000106026:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff800000106029:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010602d:	48 89 c7             	mov    %rax,%rdi
ffff800000106030:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000106037:	80 ff ff 
ffff80000010603a:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff80000010603c:	eb 50                	jmp    ffff80000010608e <piperead+0x78>
    if(proc->killed){
ffff80000010603e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106045:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106049:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010604c:	85 c0                	test   %eax,%eax
ffff80000010604e:	74 1d                	je     ffff80000010606d <piperead+0x57>
      release(&p->lock);
ffff800000106050:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106054:	48 89 c7             	mov    %rax,%rdi
ffff800000106057:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010605e:	80 ff ff 
ffff800000106061:	ff d0                	call   *%rax
      return -1;
ffff800000106063:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106068:	e9 de 00 00 00       	jmp    ffff80000010614b <piperead+0x135>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffff80000010606d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106071:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106075:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff80000010607c:	48 89 c6             	mov    %rax,%rsi
ffff80000010607f:	48 89 d7             	mov    %rdx,%rdi
ffff800000106082:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000106089:	80 ff ff 
ffff80000010608c:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff80000010608e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106092:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106098:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010609c:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff8000001060a2:	39 c2                	cmp    %eax,%edx
ffff8000001060a4:	75 0e                	jne    ffff8000001060b4 <piperead+0x9e>
ffff8000001060a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060aa:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff8000001060b0:	85 c0                	test   %eax,%eax
ffff8000001060b2:	75 8a                	jne    ffff80000010603e <piperead+0x28>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff8000001060b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001060bb:	eb 54                	jmp    ffff800000106111 <piperead+0xfb>
    if(p->nread == p->nwrite)
ffff8000001060bd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060c1:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff8000001060c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060cb:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff8000001060d1:	39 c2                	cmp    %eax,%edx
ffff8000001060d3:	74 46                	je     ffff80000010611b <piperead+0x105>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffff8000001060d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060d9:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff8000001060df:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001060e2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001060e6:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff8000001060ec:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001060f1:	89 c1                	mov    %eax,%ecx
ffff8000001060f3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001060f6:	48 63 d0             	movslq %eax,%rdx
ffff8000001060f9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001060fd:	48 01 c2             	add    %rax,%rdx
ffff800000106100:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106104:	89 c9                	mov    %ecx,%ecx
ffff800000106106:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff80000010610b:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff80000010610d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000106111:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000106114:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000106117:	7c a4                	jl     ffff8000001060bd <piperead+0xa7>
ffff800000106119:	eb 01                	jmp    ffff80000010611c <piperead+0x106>
      break;
ffff80000010611b:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffff80000010611c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106120:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff800000106126:	48 89 c7             	mov    %rax,%rdi
ffff800000106129:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff800000106130:	80 ff ff 
ffff800000106133:	ff d0                	call   *%rax
  release(&p->lock);
ffff800000106135:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106139:	48 89 c7             	mov    %rax,%rdi
ffff80000010613c:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000106143:	80 ff ff 
ffff800000106146:	ff d0                	call   *%rax
  return i;
ffff800000106148:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff80000010614b:	c9                   	leave
ffff80000010614c:	c3                   	ret

ffff80000010614d <readeflags>:
{
ffff80000010614d:	55                   	push   %rbp
ffff80000010614e:	48 89 e5             	mov    %rsp,%rbp
ffff800000106151:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff800000106155:	9c                   	pushf
ffff800000106156:	58                   	pop    %rax
ffff800000106157:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff80000010615b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010615f:	c9                   	leave
ffff800000106160:	c3                   	ret

ffff800000106161 <sti>:
{
ffff800000106161:	55                   	push   %rbp
ffff800000106162:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff800000106165:	fb                   	sti
}
ffff800000106166:	90                   	nop
ffff800000106167:	5d                   	pop    %rbp
ffff800000106168:	c3                   	ret

ffff800000106169 <hlt>:
{
ffff800000106169:	55                   	push   %rbp
ffff80000010616a:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff80000010616d:	f4                   	hlt
}
ffff80000010616e:	90                   	nop
ffff80000010616f:	5d                   	pop    %rbp
ffff800000106170:	c3                   	ret

ffff800000106171 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffff800000106171:	55                   	push   %rbp
ffff800000106172:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff800000106175:	48 ba 08 cb 10 00 00 	movabs $0xffff80000010cb08,%rdx
ffff80000010617c:	80 ff ff 
ffff80000010617f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106186:	80 ff ff 
ffff800000106189:	48 89 d6             	mov    %rdx,%rsi
ffff80000010618c:	48 89 c7             	mov    %rax,%rdi
ffff80000010618f:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000106196:	80 ff ff 
ffff800000106199:	ff d0                	call   *%rax
}
ffff80000010619b:	90                   	nop
ffff80000010619c:	5d                   	pop    %rbp
ffff80000010619d:	c3                   	ret

ffff80000010619e <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffff80000010619e:	55                   	push   %rbp
ffff80000010619f:	48 89 e5             	mov    %rsp,%rbp
ffff8000001061a2:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffff8000001061a6:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001061ad:	80 ff ff 
ffff8000001061b0:	48 89 c7             	mov    %rax,%rdi
ffff8000001061b3:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001061ba:	80 ff ff 
ffff8000001061bd:	ff d0                	call   *%rax

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001061bf:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001061c6:	80 ff ff 
ffff8000001061c9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001061cd:	eb 13                	jmp    ffff8000001061e2 <allocproc+0x44>
    if(p->state == UNUSED)
ffff8000001061cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001061d3:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001061d6:	85 c0                	test   %eax,%eax
ffff8000001061d8:	74 3b                	je     ffff800000106215 <allocproc+0x77>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001061da:	48 81 45 f8 30 02 00 	addq   $0x230,-0x8(%rbp)
ffff8000001061e1:	00 
ffff8000001061e2:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff8000001061e9:	80 ff ff 
ffff8000001061ec:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001061f0:	72 dd                	jb     ffff8000001061cf <allocproc+0x31>
      goto found;

  release(&ptable.lock);
ffff8000001061f2:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001061f9:	80 ff ff 
ffff8000001061fc:	48 89 c7             	mov    %rax,%rdi
ffff8000001061ff:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000106206:	80 ff ff 
ffff800000106209:	ff d0                	call   *%rax
  return 0;
ffff80000010620b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106210:	e9 4b 01 00 00       	jmp    ffff800000106360 <allocproc+0x1c2>
      goto found;
ffff800000106215:	90                   	nop

found:
  p->state = EMBRYO;
ffff800000106216:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010621a:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff800000106221:	48 b8 40 d5 10 00 00 	movabs $0xffff80000010d540,%rax
ffff800000106228:	80 ff ff 
ffff80000010622b:	8b 00                	mov    (%rax),%eax
ffff80000010622d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000106230:	48 b9 40 d5 10 00 00 	movabs $0xffff80000010d540,%rcx
ffff800000106237:	80 ff ff 
ffff80000010623a:	89 11                	mov    %edx,(%rcx)
ffff80000010623c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106240:	89 42 1c             	mov    %eax,0x1c(%rdx)

  release(&ptable.lock);
ffff800000106243:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010624a:	80 ff ff 
ffff80000010624d:	48 89 c7             	mov    %rax,%rdi
ffff800000106250:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000106257:	80 ff ff 
ffff80000010625a:	ff d0                	call   *%rax

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffff80000010625c:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000106263:	80 ff ff 
ffff800000106266:	ff d0                	call   *%rax
ffff800000106268:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010626c:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff800000106270:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106274:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106278:	48 85 c0             	test   %rax,%rax
ffff80000010627b:	75 15                	jne    ffff800000106292 <allocproc+0xf4>
    p->state = UNUSED;
ffff80000010627d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106281:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff800000106288:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010628d:	e9 ce 00 00 00       	jmp    ffff800000106360 <allocproc+0x1c2>
  }
  sp = p->kstack + KSTACKSIZE;
ffff800000106292:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106296:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010629a:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff8000001062a0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffff8000001062a4:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff8000001062ab:	00 
  p->tf = (struct trapframe*)sp;
ffff8000001062ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062b0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001062b4:	48 89 50 28          	mov    %rdx,0x28(%rax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(addr_t);
ffff8000001062b8:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff8000001062bd:	48 ba 01 a0 10 00 00 	movabs $0xffff80000010a001,%rdx
ffff8000001062c4:	80 ff ff 
ffff8000001062c7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001062cb:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffff8000001062ce:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff8000001062d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062d7:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001062db:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff8000001062df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062e3:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001062e7:	ba 38 00 00 00       	mov    $0x38,%edx
ffff8000001062ec:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001062f1:	48 89 c7             	mov    %rax,%rdi
ffff8000001062f4:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff8000001062fb:	80 ff ff 
ffff8000001062fe:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff800000106300:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106304:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106308:	48 ba 54 70 10 00 00 	movabs $0xffff800000107054,%rdx
ffff80000010630f:	80 ff ff 
ffff800000106312:	48 89 50 30          	mov    %rdx,0x30(%rax)

  // init metadata here
  p->mmaptop = (char*)MMAPBASE;
ffff800000106316:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010631a:	48 b9 00 00 00 00 00 	movabs $0x400000000000,%rcx
ffff800000106321:	40 00 00 
ffff800000106324:	48 89 88 e0 00 00 00 	mov    %rcx,0xe0(%rax)
  p->mmapcount = 0;
ffff80000010632b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010632f:	c7 80 e8 00 00 00 00 	movl   $0x0,0xe8(%rax)
ffff800000106336:	00 00 00 
  memset(p->mmaps, 0, sizeof(p->mmaps));
ffff800000106339:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010633d:	48 05 f0 00 00 00    	add    $0xf0,%rax
ffff800000106343:	ba 40 01 00 00       	mov    $0x140,%edx
ffff800000106348:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010634d:	48 89 c7             	mov    %rax,%rdi
ffff800000106350:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000106357:	80 ff ff 
ffff80000010635a:	ff d0                	call   *%rax

  return p;
ffff80000010635c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000106360:	c9                   	leave
ffff800000106361:	c3                   	ret

ffff800000106362 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffff800000106362:	55                   	push   %rbp
ffff800000106363:	48 89 e5             	mov    %rsp,%rbp
ffff800000106366:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  p = allocproc();
ffff80000010636a:	48 b8 9e 61 10 00 00 	movabs $0xffff80000010619e,%rax
ffff800000106371:	80 ff ff 
ffff800000106374:	ff d0                	call   *%rax
ffff800000106376:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  initproc = p;
ffff80000010637a:	48 ba a8 00 12 00 00 	movabs $0xffff8000001200a8,%rdx
ffff800000106381:	80 ff ff 
ffff800000106384:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106388:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff80000010638b:	48 b8 a5 b8 10 00 00 	movabs $0xffff80000010b8a5,%rax
ffff800000106392:	80 ff ff 
ffff800000106395:	ff d0                	call   *%rax
ffff800000106397:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010639b:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff80000010639f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063a3:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001063a7:	48 85 c0             	test   %rax,%rax
ffff8000001063aa:	75 19                	jne    ffff8000001063c5 <userinit+0x63>
    panic("userinit: out of memory?");
ffff8000001063ac:	48 b8 0f cb 10 00 00 	movabs $0xffff80000010cb0f,%rax
ffff8000001063b3:	80 ff ff 
ffff8000001063b6:	48 89 c7             	mov    %rax,%rdi
ffff8000001063b9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001063c0:	80 ff ff 
ffff8000001063c3:	ff d0                	call   *%rax

  inituvm(p->pgdir, _binary_initcode_start,
ffff8000001063c5:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff8000001063cc:	00 00 00 
ffff8000001063cf:	89 c2                	mov    %eax,%edx
ffff8000001063d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063d5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001063d9:	48 b9 58 de 10 00 00 	movabs $0xffff80000010de58,%rcx
ffff8000001063e0:	80 ff ff 
ffff8000001063e3:	48 89 ce             	mov    %rcx,%rsi
ffff8000001063e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001063e9:	48 b8 1b be 10 00 00 	movabs $0xffff80000010be1b,%rax
ffff8000001063f0:	80 ff ff 
ffff8000001063f3:	ff d0                	call   *%rax
          (addr_t)_binary_initcode_size);
  p->sz = PGSIZE * 2;
ffff8000001063f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063f9:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff800000106400:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106404:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106408:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff80000010640d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106412:	48 89 c7             	mov    %rax,%rdi
ffff800000106415:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010641c:	80 ff ff 
ffff80000010641f:	ff d0                	call   *%rax

  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff800000106421:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106425:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106429:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff800000106430:	00 
  p->tf->rsp = p->sz;
ffff800000106431:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106435:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106439:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010643d:	48 8b 12             	mov    (%rdx),%rdx
ffff800000106440:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff800000106447:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010644b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010644f:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff800000106456:	00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff800000106457:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010645b:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff800000106461:	48 b9 28 cb 10 00 00 	movabs $0xffff80000010cb28,%rcx
ffff800000106468:	80 ff ff 
ffff80000010646b:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000106470:	48 89 ce             	mov    %rcx,%rsi
ffff800000106473:	48 89 c7             	mov    %rax,%rdi
ffff800000106476:	48 b8 31 7d 10 00 00 	movabs $0xffff800000107d31,%rax
ffff80000010647d:	80 ff ff 
ffff800000106480:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff800000106482:	48 b8 31 cb 10 00 00 	movabs $0xffff80000010cb31,%rax
ffff800000106489:	80 ff ff 
ffff80000010648c:	48 89 c7             	mov    %rax,%rdi
ffff80000010648f:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000106496:	80 ff ff 
ffff800000106499:	ff d0                	call   *%rax
ffff80000010649b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010649f:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  __sync_synchronize();
ffff8000001064a6:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff8000001064ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064b0:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff8000001064b7:	90                   	nop
ffff8000001064b8:	c9                   	leave
ffff8000001064b9:	c3                   	ret

ffff8000001064ba <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int64 n)
{
ffff8000001064ba:	55                   	push   %rbp
ffff8000001064bb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001064be:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001064c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  addr_t sz;

  sz = proc->sz;
ffff8000001064c6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064cd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064d1:	48 8b 00             	mov    (%rax),%rax
ffff8000001064d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff8000001064d8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001064dd:	7e 42                	jle    ffff800000106521 <growproc+0x67>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff8000001064df:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001064e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064e7:	48 01 c2             	add    %rax,%rdx
ffff8000001064ea:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064f1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064f5:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001064f9:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001064fd:	48 89 ce             	mov    %rcx,%rsi
ffff800000106500:	48 89 c7             	mov    %rax,%rdi
ffff800000106503:	48 b8 fc bf 10 00 00 	movabs $0xffff80000010bffc,%rax
ffff80000010650a:	80 ff ff 
ffff80000010650d:	ff d0                	call   *%rax
ffff80000010650f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106513:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000106518:	75 50                	jne    ffff80000010656a <growproc+0xb0>
      return -1;
ffff80000010651a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010651f:	eb 7a                	jmp    ffff80000010659b <growproc+0xe1>
  } else if(n < 0){
ffff800000106521:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106526:	79 42                	jns    ffff80000010656a <growproc+0xb0>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106528:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010652c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106530:	48 01 c2             	add    %rax,%rdx
ffff800000106533:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010653a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010653e:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106542:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000106546:	48 89 ce             	mov    %rcx,%rsi
ffff800000106549:	48 89 c7             	mov    %rax,%rdi
ffff80000010654c:	48 b8 40 c1 10 00 00 	movabs $0xffff80000010c140,%rax
ffff800000106553:	80 ff ff 
ffff800000106556:	ff d0                	call   *%rax
ffff800000106558:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010655c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000106561:	75 07                	jne    ffff80000010656a <growproc+0xb0>
      return -1;
ffff800000106563:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106568:	eb 31                	jmp    ffff80000010659b <growproc+0xe1>
  }
  proc->sz = sz;
ffff80000010656a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106571:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106575:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106579:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff80000010657c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106583:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106587:	48 89 c7             	mov    %rax,%rdi
ffff80000010658a:	48 b8 03 ba 10 00 00 	movabs $0xffff80000010ba03,%rax
ffff800000106591:	80 ff ff 
ffff800000106594:	ff d0                	call   *%rax
  return 0;
ffff800000106596:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010659b:	c9                   	leave
ffff80000010659c:	c3                   	ret

ffff80000010659d <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff80000010659d:	55                   	push   %rbp
ffff80000010659e:	48 89 e5             	mov    %rsp,%rbp
ffff8000001065a1:	53                   	push   %rbx
ffff8000001065a2:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff8000001065a6:	48 b8 9e 61 10 00 00 	movabs $0xffff80000010619e,%rax
ffff8000001065ad:	80 ff ff 
ffff8000001065b0:	ff d0                	call   *%rax
ffff8000001065b2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff8000001065b6:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff8000001065bb:	75 0a                	jne    ffff8000001065c7 <fork+0x2a>
    return -1;
ffff8000001065bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001065c2:	e9 8b 03 00 00       	jmp    ffff800000106952 <fork+0x3b5>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff8000001065c7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065ce:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001065d2:	48 8b 00             	mov    (%rax),%rax
ffff8000001065d5:	89 c2                	mov    %eax,%edx
ffff8000001065d7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065de:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001065e2:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001065e6:	89 d6                	mov    %edx,%esi
ffff8000001065e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001065eb:	48 b8 db c4 10 00 00 	movabs $0xffff80000010c4db,%rax
ffff8000001065f2:	80 ff ff 
ffff8000001065f5:	ff d0                	call   *%rax
ffff8000001065f7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001065fb:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff8000001065ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106603:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106607:	48 85 c0             	test   %rax,%rax
ffff80000010660a:	75 38                	jne    ffff800000106644 <fork+0xa7>
    kfree(np->kstack);
ffff80000010660c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106610:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106614:	48 89 c7             	mov    %rax,%rdi
ffff800000106617:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010661e:	80 ff ff 
ffff800000106621:	ff d0                	call   *%rax
    np->kstack = 0;
ffff800000106623:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106627:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff80000010662e:	00 
    np->state = UNUSED;
ffff80000010662f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106633:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff80000010663a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010663f:	e9 0e 03 00 00       	jmp    ffff800000106952 <fork+0x3b5>
  }
  np->sz = proc->sz;
ffff800000106644:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010664b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010664f:	48 8b 10             	mov    (%rax),%rdx
ffff800000106652:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106656:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff800000106659:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106660:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000106664:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106668:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff80000010666c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106673:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106677:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff80000010667b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010667f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106683:	48 8b 0a             	mov    (%rdx),%rcx
ffff800000106686:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff80000010668a:	48 89 08             	mov    %rcx,(%rax)
ffff80000010668d:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff800000106691:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff800000106695:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff800000106699:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff80000010669d:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff8000001066a1:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff8000001066a5:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff8000001066a9:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff8000001066ad:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff8000001066b1:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff8000001066b5:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff8000001066b9:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff8000001066bd:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff8000001066c1:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff8000001066c5:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff8000001066c9:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff8000001066cd:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff8000001066d1:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff8000001066d5:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff8000001066d9:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff8000001066dd:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff8000001066e1:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff8000001066e5:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff8000001066e9:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff8000001066ed:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff8000001066f1:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff8000001066f5:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff8000001066f9:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff8000001066fd:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff800000106701:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff800000106708:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff80000010670f:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff800000106716:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff80000010671d:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff800000106724:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff80000010672b:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff800000106732:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff800000106739:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff800000106740:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff800000106747:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff80000010674e:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff800000106755:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106759:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010675d:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff800000106764:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff80000010676b:	eb 5f                	jmp    ffff8000001067cc <fork+0x22f>
    if(proc->ofile[i])
ffff80000010676d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106774:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106778:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010677b:	48 63 d2             	movslq %edx,%rdx
ffff80000010677e:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106782:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106787:	48 85 c0             	test   %rax,%rax
ffff80000010678a:	74 3c                	je     ffff8000001067c8 <fork+0x22b>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff80000010678c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106793:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106797:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010679a:	48 63 d2             	movslq %edx,%rdx
ffff80000010679d:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001067a1:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001067a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001067a9:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff8000001067b0:	80 ff ff 
ffff8000001067b3:	ff d0                	call   *%rax
ffff8000001067b5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001067b9:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff8000001067bc:	48 63 c9             	movslq %ecx,%rcx
ffff8000001067bf:	48 83 c1 08          	add    $0x8,%rcx
ffff8000001067c3:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff8000001067c8:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff8000001067cc:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff8000001067d0:	7e 9b                	jle    ffff80000010676d <fork+0x1d0>
  np->cwd = idup(proc->cwd);
ffff8000001067d2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067d9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067dd:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff8000001067e4:	48 89 c7             	mov    %rax,%rdi
ffff8000001067e7:	48 b8 37 28 10 00 00 	movabs $0xffff800000102837,%rax
ffff8000001067ee:	80 ff ff 
ffff8000001067f1:	ff d0                	call   *%rax
ffff8000001067f3:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001067f7:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  np->mmapcount = proc->mmapcount;
ffff8000001067fe:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106805:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106809:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff80000010680f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106813:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
  np->mmaptop = proc->mmaptop;
ffff800000106819:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106820:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106824:	48 8b 90 e0 00 00 00 	mov    0xe0(%rax),%rdx
ffff80000010682b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010682f:	48 89 90 e0 00 00 00 	mov    %rdx,0xe0(%rax)
  for(i = 0; i < proc->mmapcount; i++){
ffff800000106836:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff80000010683d:	e9 a5 00 00 00       	jmp    ffff8000001068e7 <fork+0x34a>
    np->mmaps[i] = proc->mmaps[i];
ffff800000106842:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106849:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010684d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106851:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff800000106854:	48 63 c9             	movslq %ecx,%rcx
ffff800000106857:	48 c1 e1 05          	shl    $0x5,%rcx
ffff80000010685b:	48 01 ca             	add    %rcx,%rdx
ffff80000010685e:	48 8d 8a f0 00 00 00 	lea    0xf0(%rdx),%rcx
ffff800000106865:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000106868:	48 63 d2             	movslq %edx,%rdx
ffff80000010686b:	48 c1 e2 05          	shl    $0x5,%rdx
ffff80000010686f:	48 01 d0             	add    %rdx,%rax
ffff800000106872:	48 8d b0 f0 00 00 00 	lea    0xf0(%rax),%rsi
ffff800000106879:	48 8b 06             	mov    (%rsi),%rax
ffff80000010687c:	48 8b 56 08          	mov    0x8(%rsi),%rdx
ffff800000106880:	48 89 01             	mov    %rax,(%rcx)
ffff800000106883:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000106887:	48 8b 46 10          	mov    0x10(%rsi),%rax
ffff80000010688b:	48 8b 56 18          	mov    0x18(%rsi),%rdx
ffff80000010688f:	48 89 41 10          	mov    %rax,0x10(%rcx)
ffff800000106893:	48 89 51 18          	mov    %rdx,0x18(%rcx)
    if(np->mmaps[i].f)
ffff800000106897:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010689b:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010689e:	48 63 d2             	movslq %edx,%rdx
ffff8000001068a1:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001068a5:	48 c1 e2 05          	shl    $0x5,%rdx
ffff8000001068a9:	48 01 d0             	add    %rdx,%rax
ffff8000001068ac:	48 83 c0 08          	add    $0x8,%rax
ffff8000001068b0:	48 8b 00             	mov    (%rax),%rax
ffff8000001068b3:	48 85 c0             	test   %rax,%rax
ffff8000001068b6:	74 2b                	je     ffff8000001068e3 <fork+0x346>
      filedup(np->mmaps[i].f);
ffff8000001068b8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001068bc:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001068bf:	48 63 d2             	movslq %edx,%rdx
ffff8000001068c2:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001068c6:	48 c1 e2 05          	shl    $0x5,%rdx
ffff8000001068ca:	48 01 d0             	add    %rdx,%rax
ffff8000001068cd:	48 83 c0 08          	add    $0x8,%rax
ffff8000001068d1:	48 8b 00             	mov    (%rax),%rax
ffff8000001068d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001068d7:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff8000001068de:	80 ff ff 
ffff8000001068e1:	ff d0                	call   *%rax
  for(i = 0; i < proc->mmapcount; i++){
ffff8000001068e3:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff8000001068e7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068ee:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068f2:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001068f8:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001068fb:	0f 8c 41 ff ff ff    	jl     ffff800000106842 <fork+0x2a5>
  }

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff800000106901:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106908:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010690c:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000106913:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106917:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff80000010691d:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000106922:	48 89 ce             	mov    %rcx,%rsi
ffff800000106925:	48 89 c7             	mov    %rax,%rdi
ffff800000106928:	48 b8 31 7d 10 00 00 	movabs $0xffff800000107d31,%rax
ffff80000010692f:	80 ff ff 
ffff800000106932:	ff d0                	call   *%rax

  pid = np->pid;
ffff800000106934:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106938:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010693b:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff80000010693e:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff800000106944:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106948:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  return pid;
ffff80000010694f:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000106952:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000106956:	c9                   	leave
ffff800000106957:	c3                   	ret

ffff800000106958 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff800000106958:	55                   	push   %rbp
ffff800000106959:	48 89 e5             	mov    %rsp,%rbp
ffff80000010695c:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd, i;
  cprintf("Exiting process. System free pages is %d\n",kfreepagecount());
ffff800000106960:	48 b8 4f 42 10 00 00 	movabs $0xffff80000010424f,%rax
ffff800000106967:	80 ff ff 
ffff80000010696a:	ff d0                	call   *%rax
ffff80000010696c:	89 c2                	mov    %eax,%edx
ffff80000010696e:	48 b8 38 cb 10 00 00 	movabs $0xffff80000010cb38,%rax
ffff800000106975:	80 ff ff 
ffff800000106978:	89 d6                	mov    %edx,%esi
ffff80000010697a:	48 89 c7             	mov    %rax,%rdi
ffff80000010697d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106982:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000106989:	80 ff ff 
ffff80000010698c:	ff d2                	call   *%rdx

  if(proc == initproc)
ffff80000010698e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106995:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000106999:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff8000001069a0:	80 ff ff 
ffff8000001069a3:	48 8b 00             	mov    (%rax),%rax
ffff8000001069a6:	48 39 c2             	cmp    %rax,%rdx
ffff8000001069a9:	75 19                	jne    ffff8000001069c4 <exit+0x6c>
    panic("init exiting");
ffff8000001069ab:	48 b8 62 cb 10 00 00 	movabs $0xffff80000010cb62,%rax
ffff8000001069b2:	80 ff ff 
ffff8000001069b5:	48 89 c7             	mov    %rax,%rdi
ffff8000001069b8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001069bf:	80 ff ff 
ffff8000001069c2:	ff d0                	call   *%rax

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff8000001069c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff8000001069cb:	eb 6a                	jmp    ffff800000106a37 <exit+0xdf>
    if(proc->ofile[fd]){
ffff8000001069cd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069d4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069d8:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001069db:	48 63 d2             	movslq %edx,%rdx
ffff8000001069de:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001069e2:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001069e7:	48 85 c0             	test   %rax,%rax
ffff8000001069ea:	74 47                	je     ffff800000106a33 <exit+0xdb>
      fileclose(proc->ofile[fd]);
ffff8000001069ec:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069f3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069f7:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001069fa:	48 63 d2             	movslq %edx,%rdx
ffff8000001069fd:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a01:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106a06:	48 89 c7             	mov    %rax,%rdi
ffff800000106a09:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000106a10:	80 ff ff 
ffff800000106a13:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff800000106a15:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a1c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a20:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106a23:	48 63 d2             	movslq %edx,%rdx
ffff800000106a26:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a2a:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106a31:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106a33:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff800000106a37:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff800000106a3b:	7e 90                	jle    ffff8000001069cd <exit+0x75>
    }
  }

  // Close all mmaped files
  for(i = 0; i < proc->mmapcount; i++){
ffff800000106a3d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff800000106a44:	e9 85 00 00 00       	jmp    ffff800000106ace <exit+0x176>
    if(proc->mmaps[i].f){
ffff800000106a49:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a50:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a54:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000106a57:	48 63 d2             	movslq %edx,%rdx
ffff800000106a5a:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a5e:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000106a62:	48 01 d0             	add    %rdx,%rax
ffff800000106a65:	48 83 c0 08          	add    $0x8,%rax
ffff800000106a69:	48 8b 00             	mov    (%rax),%rax
ffff800000106a6c:	48 85 c0             	test   %rax,%rax
ffff800000106a6f:	74 59                	je     ffff800000106aca <exit+0x172>
      fileclose(proc->mmaps[i].f);
ffff800000106a71:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a78:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a7c:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000106a7f:	48 63 d2             	movslq %edx,%rdx
ffff800000106a82:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a86:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000106a8a:	48 01 d0             	add    %rdx,%rax
ffff800000106a8d:	48 83 c0 08          	add    $0x8,%rax
ffff800000106a91:	48 8b 00             	mov    (%rax),%rax
ffff800000106a94:	48 89 c7             	mov    %rax,%rdi
ffff800000106a97:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000106a9e:	80 ff ff 
ffff800000106aa1:	ff d0                	call   *%rax
      proc->mmaps[i].f = 0;
ffff800000106aa3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106aaa:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106aae:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000106ab1:	48 63 d2             	movslq %edx,%rdx
ffff800000106ab4:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106ab8:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000106abc:	48 01 d0             	add    %rdx,%rax
ffff800000106abf:	48 83 c0 08          	add    $0x8,%rax
ffff800000106ac3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(i = 0; i < proc->mmapcount; i++){
ffff800000106aca:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff800000106ace:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ad5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ad9:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000106adf:	39 45 f0             	cmp    %eax,-0x10(%rbp)
ffff800000106ae2:	0f 8c 61 ff ff ff    	jl     ffff800000106a49 <exit+0xf1>
    }
  }

  begin_op();
ffff800000106ae8:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000106aef:	80 ff ff 
ffff800000106af2:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff800000106af4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106afb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106aff:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106b06:	48 89 c7             	mov    %rax,%rdi
ffff800000106b09:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000106b10:	80 ff ff 
ffff800000106b13:	ff d0                	call   *%rax
  end_op();
ffff800000106b15:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000106b1c:	80 ff ff 
ffff800000106b1f:	ff d0                	call   *%rax
  proc->cwd = 0;
ffff800000106b21:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b28:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b2c:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff800000106b33:	00 00 00 00 

  acquire(&ptable.lock);
ffff800000106b37:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106b3e:	80 ff ff 
ffff800000106b41:	48 89 c7             	mov    %rax,%rdi
ffff800000106b44:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000106b4b:	80 ff ff 
ffff800000106b4e:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff800000106b50:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b5b:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000106b5f:	48 89 c7             	mov    %rax,%rdi
ffff800000106b62:	48 b8 ce 71 10 00 00 	movabs $0xffff8000001071ce,%rax
ffff800000106b69:	80 ff ff 
ffff800000106b6c:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106b6e:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106b75:	80 ff ff 
ffff800000106b78:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106b7c:	eb 5d                	jmp    ffff800000106bdb <exit+0x283>
    if(p->parent == proc){
ffff800000106b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106b82:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106b86:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b8d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b91:	48 39 c2             	cmp    %rax,%rdx
ffff800000106b94:	75 3d                	jne    ffff800000106bd3 <exit+0x27b>
      p->parent = initproc;
ffff800000106b96:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff800000106b9d:	80 ff ff 
ffff800000106ba0:	48 8b 10             	mov    (%rax),%rdx
ffff800000106ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ba7:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106bab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106baf:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106bb2:	83 f8 05             	cmp    $0x5,%eax
ffff800000106bb5:	75 1c                	jne    ffff800000106bd3 <exit+0x27b>
        wakeup1(initproc);
ffff800000106bb7:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff800000106bbe:	80 ff ff 
ffff800000106bc1:	48 8b 00             	mov    (%rax),%rax
ffff800000106bc4:	48 89 c7             	mov    %rax,%rdi
ffff800000106bc7:	48 b8 ce 71 10 00 00 	movabs $0xffff8000001071ce,%rax
ffff800000106bce:	80 ff ff 
ffff800000106bd1:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106bd3:	48 81 45 f8 30 02 00 	addq   $0x230,-0x8(%rbp)
ffff800000106bda:	00 
ffff800000106bdb:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff800000106be2:	80 ff ff 
ffff800000106be5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106be9:	72 93                	jb     ffff800000106b7e <exit+0x226>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106beb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bf2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106bf6:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff800000106bfd:	48 b8 e3 6e 10 00 00 	movabs $0xffff800000106ee3,%rax
ffff800000106c04:	80 ff ff 
ffff800000106c07:	ff d0                	call   *%rax
  panic("zombie exit");
ffff800000106c09:	48 b8 6f cb 10 00 00 	movabs $0xffff80000010cb6f,%rax
ffff800000106c10:	80 ff ff 
ffff800000106c13:	48 89 c7             	mov    %rax,%rdi
ffff800000106c16:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106c1d:	80 ff ff 
ffff800000106c20:	ff d0                	call   *%rax

ffff800000106c22 <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff800000106c22:	55                   	push   %rbp
ffff800000106c23:	48 89 e5             	mov    %rsp,%rbp
ffff800000106c26:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff800000106c2a:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106c31:	80 ff ff 
ffff800000106c34:	48 89 c7             	mov    %rax,%rdi
ffff800000106c37:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000106c3e:	80 ff ff 
ffff800000106c41:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff800000106c43:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106c4a:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106c51:	80 ff ff 
ffff800000106c54:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106c58:	e9 d9 00 00 00       	jmp    ffff800000106d36 <wait+0x114>
      if(p->parent != proc)
ffff800000106c5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c61:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106c65:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c6c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c70:	48 39 c2             	cmp    %rax,%rdx
ffff800000106c73:	0f 85 b4 00 00 00    	jne    ffff800000106d2d <wait+0x10b>
        continue;
      havekids = 1;
ffff800000106c79:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106c80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c84:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106c87:	83 f8 05             	cmp    $0x5,%eax
ffff800000106c8a:	0f 85 9e 00 00 00    	jne    ffff800000106d2e <wait+0x10c>
        // Found one.
        pid = p->pid;
ffff800000106c90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c94:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106c97:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106c9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c9e:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106ca2:	48 89 c7             	mov    %rax,%rdi
ffff800000106ca5:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000106cac:	80 ff ff 
ffff800000106caf:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cb5:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106cbc:	00 
        freevm(p->pgdir);
ffff800000106cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cc1:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106cc5:	48 89 c7             	mov    %rax,%rdi
ffff800000106cc8:	48 b8 39 c2 10 00 00 	movabs $0xffff80000010c239,%rax
ffff800000106ccf:	80 ff ff 
ffff800000106cd2:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106cd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cd8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106cdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ce3:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106cea:	00 
        p->name[0] = 0;
ffff800000106ceb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cef:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cfa:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        p->state = UNUSED;
ffff800000106d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d05:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106d0c:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106d13:	80 ff ff 
ffff800000106d16:	48 89 c7             	mov    %rax,%rdi
ffff800000106d19:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000106d20:	80 ff ff 
ffff800000106d23:	ff d0                	call   *%rax
        return pid;
ffff800000106d25:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106d28:	e9 81 00 00 00       	jmp    ffff800000106dae <wait+0x18c>
        continue;
ffff800000106d2d:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106d2e:	48 81 45 f8 30 02 00 	addq   $0x230,-0x8(%rbp)
ffff800000106d35:	00 
ffff800000106d36:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff800000106d3d:	80 ff ff 
ffff800000106d40:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106d44:	0f 82 13 ff ff ff    	jb     ffff800000106c5d <wait+0x3b>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106d4a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106d4e:	74 12                	je     ffff800000106d62 <wait+0x140>
ffff800000106d50:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d5b:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106d5e:	85 c0                	test   %eax,%eax
ffff800000106d60:	74 20                	je     ffff800000106d82 <wait+0x160>
      release(&ptable.lock);
ffff800000106d62:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106d69:	80 ff ff 
ffff800000106d6c:	48 89 c7             	mov    %rax,%rdi
ffff800000106d6f:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000106d76:	80 ff ff 
ffff800000106d79:	ff d0                	call   *%rax
      return -1;
ffff800000106d7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106d80:	eb 2c                	jmp    ffff800000106dae <wait+0x18c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106d82:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d89:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d8d:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff800000106d94:	80 ff ff 
ffff800000106d97:	48 89 d6             	mov    %rdx,%rsi
ffff800000106d9a:	48 89 c7             	mov    %rax,%rdi
ffff800000106d9d:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000106da4:	80 ff ff 
ffff800000106da7:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106da9:	e9 95 fe ff ff       	jmp    ffff800000106c43 <wait+0x21>
  }
}
ffff800000106dae:	c9                   	leave
ffff800000106daf:	c3                   	ret

ffff800000106db0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106db0:	55                   	push   %rbp
ffff800000106db1:	48 89 e5             	mov    %rsp,%rbp
ffff800000106db4:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106db8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106dbf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106dc6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106dca:	48 b8 61 61 10 00 00 	movabs $0xffff800000106161,%rax
ffff800000106dd1:	80 ff ff 
ffff800000106dd4:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106dd6:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ddd:	80 ff ff 
ffff800000106de0:	48 89 c7             	mov    %rax,%rdi
ffff800000106de3:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000106dea:	80 ff ff 
ffff800000106ded:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106def:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106df6:	80 ff ff 
ffff800000106df9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106dfd:	e9 92 00 00 00       	jmp    ffff800000106e94 <scheduler+0xe4>
      if(p->state != RUNNABLE) {
ffff800000106e02:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e06:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106e09:	83 f8 03             	cmp    $0x3,%eax
ffff800000106e0c:	74 06                	je     ffff800000106e14 <scheduler+0x64>
        skipped++;
ffff800000106e0e:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106e12:	eb 78                	jmp    ffff800000106e8c <scheduler+0xdc>
      }
      skipped = 0;
ffff800000106e14:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106e1b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e22:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106e26:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106e2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e2e:	48 89 c7             	mov    %rax,%rdi
ffff800000106e31:	48 b8 03 ba 10 00 00 	movabs $0xffff80000010ba03,%rax
ffff800000106e38:	80 ff ff 
ffff800000106e3b:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000106e3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e41:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000106e48:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e4c:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106e50:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000106e57:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106e5b:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106e5f:	48 89 c6             	mov    %rax,%rsi
ffff800000106e62:	48 89 d7             	mov    %rdx,%rdi
ffff800000106e65:	48 b8 c6 7d 10 00 00 	movabs $0xffff800000107dc6,%rax
ffff800000106e6c:	80 ff ff 
ffff800000106e6f:	ff d0                	call   *%rax
      switchkvm();
ffff800000106e71:	48 b8 0f bd 10 00 00 	movabs $0xffff80000010bd0f,%rax
ffff800000106e78:	80 ff ff 
ffff800000106e7b:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000106e7d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e84:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000106e8b:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106e8c:	48 81 45 f0 30 02 00 	addq   $0x230,-0x10(%rbp)
ffff800000106e93:	00 
ffff800000106e94:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff800000106e9b:	80 ff ff 
ffff800000106e9e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106ea2:	0f 82 5a ff ff ff    	jb     ffff800000106e02 <scheduler+0x52>
    }
    release(&ptable.lock);
ffff800000106ea8:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106eaf:	80 ff ff 
ffff800000106eb2:	48 89 c7             	mov    %rax,%rdi
ffff800000106eb5:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000106ebc:	80 ff ff 
ffff800000106ebf:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000106ec1:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff800000106ec5:	0f 8e fb fe ff ff    	jle    ffff800000106dc6 <scheduler+0x16>
      hlt();
ffff800000106ecb:	48 b8 69 61 10 00 00 	movabs $0xffff800000106169,%rax
ffff800000106ed2:	80 ff ff 
ffff800000106ed5:	ff d0                	call   *%rax
      skipped = 0;
ffff800000106ed7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff800000106ede:	e9 e3 fe ff ff       	jmp    ffff800000106dc6 <scheduler+0x16>

ffff800000106ee3 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff800000106ee3:	55                   	push   %rbp
ffff800000106ee4:	48 89 e5             	mov    %rsp,%rbp
ffff800000106ee7:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff800000106eeb:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ef2:	80 ff ff 
ffff800000106ef5:	48 89 c7             	mov    %rax,%rdi
ffff800000106ef8:	48 b8 c9 78 10 00 00 	movabs $0xffff8000001078c9,%rax
ffff800000106eff:	80 ff ff 
ffff800000106f02:	ff d0                	call   *%rax
ffff800000106f04:	85 c0                	test   %eax,%eax
ffff800000106f06:	75 19                	jne    ffff800000106f21 <sched+0x3e>
    panic("sched ptable.lock");
ffff800000106f08:	48 b8 7b cb 10 00 00 	movabs $0xffff80000010cb7b,%rax
ffff800000106f0f:	80 ff ff 
ffff800000106f12:	48 89 c7             	mov    %rax,%rdi
ffff800000106f15:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f1c:	80 ff ff 
ffff800000106f1f:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff800000106f21:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106f28:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f2c:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000106f2f:	83 f8 01             	cmp    $0x1,%eax
ffff800000106f32:	74 19                	je     ffff800000106f4d <sched+0x6a>
    panic("sched locks");
ffff800000106f34:	48 b8 8d cb 10 00 00 	movabs $0xffff80000010cb8d,%rax
ffff800000106f3b:	80 ff ff 
ffff800000106f3e:	48 89 c7             	mov    %rax,%rdi
ffff800000106f41:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f48:	80 ff ff 
ffff800000106f4b:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000106f4d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f54:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f58:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f5b:	83 f8 04             	cmp    $0x4,%eax
ffff800000106f5e:	75 19                	jne    ffff800000106f79 <sched+0x96>
    panic("sched running");
ffff800000106f60:	48 b8 99 cb 10 00 00 	movabs $0xffff80000010cb99,%rax
ffff800000106f67:	80 ff ff 
ffff800000106f6a:	48 89 c7             	mov    %rax,%rdi
ffff800000106f6d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f74:	80 ff ff 
ffff800000106f77:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000106f79:	48 b8 4d 61 10 00 00 	movabs $0xffff80000010614d,%rax
ffff800000106f80:	80 ff ff 
ffff800000106f83:	ff d0                	call   *%rax
ffff800000106f85:	25 00 02 00 00       	and    $0x200,%eax
ffff800000106f8a:	48 85 c0             	test   %rax,%rax
ffff800000106f8d:	74 19                	je     ffff800000106fa8 <sched+0xc5>
    panic("sched interruptible");
ffff800000106f8f:	48 b8 a7 cb 10 00 00 	movabs $0xffff80000010cba7,%rax
ffff800000106f96:	80 ff ff 
ffff800000106f99:	48 89 c7             	mov    %rax,%rdi
ffff800000106f9c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106fa3:	80 ff ff 
ffff800000106fa6:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000106fa8:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106faf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fb3:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106fb6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000106fb9:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fc0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fc4:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106fc8:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff800000106fcf:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106fd3:	48 83 c2 30          	add    $0x30,%rdx
ffff800000106fd7:	48 89 c6             	mov    %rax,%rsi
ffff800000106fda:	48 89 d7             	mov    %rdx,%rdi
ffff800000106fdd:	48 b8 c6 7d 10 00 00 	movabs $0xffff800000107dc6,%rax
ffff800000106fe4:	80 ff ff 
ffff800000106fe7:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff800000106fe9:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106ff0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ff4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000106ff7:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff800000106ffa:	90                   	nop
ffff800000106ffb:	c9                   	leave
ffff800000106ffc:	c3                   	ret

ffff800000106ffd <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff800000106ffd:	55                   	push   %rbp
ffff800000106ffe:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff800000107001:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107008:	80 ff ff 
ffff80000010700b:	48 89 c7             	mov    %rax,%rdi
ffff80000010700e:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000107015:	80 ff ff 
ffff800000107018:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff80000010701a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107021:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107025:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff80000010702c:	48 b8 e3 6e 10 00 00 	movabs $0xffff800000106ee3,%rax
ffff800000107033:	80 ff ff 
ffff800000107036:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107038:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010703f:	80 ff ff 
ffff800000107042:	48 89 c7             	mov    %rax,%rdi
ffff800000107045:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010704c:	80 ff ff 
ffff80000010704f:	ff d0                	call   *%rax
}
ffff800000107051:	90                   	nop
ffff800000107052:	5d                   	pop    %rbp
ffff800000107053:	c3                   	ret

ffff800000107054 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff800000107054:	55                   	push   %rbp
ffff800000107055:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff800000107058:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010705f:	80 ff ff 
ffff800000107062:	48 89 c7             	mov    %rax,%rdi
ffff800000107065:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010706c:	80 ff ff 
ffff80000010706f:	ff d0                	call   *%rax

  if (first) {
ffff800000107071:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000107078:	80 ff ff 
ffff80000010707b:	8b 00                	mov    (%rax),%eax
ffff80000010707d:	85 c0                	test   %eax,%eax
ffff80000010707f:	74 32                	je     ffff8000001070b3 <forkret+0x5f>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff800000107081:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000107088:	80 ff ff 
ffff80000010708b:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff800000107091:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000107096:	48 b8 17 24 10 00 00 	movabs $0xffff800000102417,%rax
ffff80000010709d:	80 ff ff 
ffff8000001070a0:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff8000001070a2:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001070a7:	48 b8 b3 4b 10 00 00 	movabs $0xffff800000104bb3,%rax
ffff8000001070ae:	80 ff ff 
ffff8000001070b1:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff8000001070b3:	90                   	nop
ffff8000001070b4:	5d                   	pop    %rbp
ffff8000001070b5:	c3                   	ret

ffff8000001070b6 <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff8000001070b6:	55                   	push   %rbp
ffff8000001070b7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070ba:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001070be:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001070c2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff8000001070c6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001070cd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001070d1:	48 85 c0             	test   %rax,%rax
ffff8000001070d4:	75 19                	jne    ffff8000001070ef <sleep+0x39>
    panic("sleep");
ffff8000001070d6:	48 b8 bb cb 10 00 00 	movabs $0xffff80000010cbbb,%rax
ffff8000001070dd:	80 ff ff 
ffff8000001070e0:	48 89 c7             	mov    %rax,%rdi
ffff8000001070e3:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001070ea:	80 ff ff 
ffff8000001070ed:	ff d0                	call   *%rax

  if(lk == 0)
ffff8000001070ef:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001070f4:	75 19                	jne    ffff80000010710f <sleep+0x59>
    panic("sleep without lk");
ffff8000001070f6:	48 b8 c1 cb 10 00 00 	movabs $0xffff80000010cbc1,%rax
ffff8000001070fd:	80 ff ff 
ffff800000107100:	48 89 c7             	mov    %rax,%rdi
ffff800000107103:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010710a:	80 ff ff 
ffff80000010710d:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff80000010710f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107116:	80 ff ff 
ffff800000107119:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010711d:	74 2c                	je     ffff80000010714b <sleep+0x95>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff80000010711f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107126:	80 ff ff 
ffff800000107129:	48 89 c7             	mov    %rax,%rdi
ffff80000010712c:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000107133:	80 ff ff 
ffff800000107136:	ff d0                	call   *%rax
    release(lk);
ffff800000107138:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010713c:	48 89 c7             	mov    %rax,%rdi
ffff80000010713f:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000107146:	80 ff ff 
ffff800000107149:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff80000010714b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107152:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107156:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010715a:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff80000010715e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107165:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107169:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff800000107170:	48 b8 e3 6e 10 00 00 	movabs $0xffff800000106ee3,%rax
ffff800000107177:	80 ff ff 
ffff80000010717a:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff80000010717c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107183:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107187:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff80000010718e:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff80000010718f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107196:	80 ff ff 
ffff800000107199:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010719d:	74 2c                	je     ffff8000001071cb <sleep+0x115>
    release(&ptable.lock);
ffff80000010719f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001071a6:	80 ff ff 
ffff8000001071a9:	48 89 c7             	mov    %rax,%rdi
ffff8000001071ac:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001071b3:	80 ff ff 
ffff8000001071b6:	ff d0                	call   *%rax
    acquire(lk);
ffff8000001071b8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001071bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001071bf:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001071c6:	80 ff ff 
ffff8000001071c9:	ff d0                	call   *%rax
  }
}
ffff8000001071cb:	90                   	nop
ffff8000001071cc:	c9                   	leave
ffff8000001071cd:	c3                   	ret

ffff8000001071ce <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff8000001071ce:	55                   	push   %rbp
ffff8000001071cf:	48 89 e5             	mov    %rsp,%rbp
ffff8000001071d2:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001071d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001071da:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001071e1:	80 ff ff 
ffff8000001071e4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001071e8:	eb 2d                	jmp    ffff800000107217 <wakeup1+0x49>
    if(p->state == SLEEPING && p->chan == chan)
ffff8000001071ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001071ee:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001071f1:	83 f8 02             	cmp    $0x2,%eax
ffff8000001071f4:	75 19                	jne    ffff80000010720f <wakeup1+0x41>
ffff8000001071f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001071fa:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff8000001071fe:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107202:	75 0b                	jne    ffff80000010720f <wakeup1+0x41>
      p->state = RUNNABLE;
ffff800000107204:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107208:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff80000010720f:	48 81 45 f8 30 02 00 	addq   $0x230,-0x8(%rbp)
ffff800000107216:	00 
ffff800000107217:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff80000010721e:	80 ff ff 
ffff800000107221:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107225:	72 c3                	jb     ffff8000001071ea <wakeup1+0x1c>
}
ffff800000107227:	90                   	nop
ffff800000107228:	90                   	nop
ffff800000107229:	c9                   	leave
ffff80000010722a:	c3                   	ret

ffff80000010722b <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff80000010722b:	55                   	push   %rbp
ffff80000010722c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010722f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107233:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000107237:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010723e:	80 ff ff 
ffff800000107241:	48 89 c7             	mov    %rax,%rdi
ffff800000107244:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010724b:	80 ff ff 
ffff80000010724e:	ff d0                	call   *%rax
  wakeup1(chan);
ffff800000107250:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107254:	48 89 c7             	mov    %rax,%rdi
ffff800000107257:	48 b8 ce 71 10 00 00 	movabs $0xffff8000001071ce,%rax
ffff80000010725e:	80 ff ff 
ffff800000107261:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107263:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010726a:	80 ff ff 
ffff80000010726d:	48 89 c7             	mov    %rax,%rdi
ffff800000107270:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000107277:	80 ff ff 
ffff80000010727a:	ff d0                	call   *%rax
}
ffff80000010727c:	90                   	nop
ffff80000010727d:	c9                   	leave
ffff80000010727e:	c3                   	ret

ffff80000010727f <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff80000010727f:	55                   	push   %rbp
ffff800000107280:	48 89 e5             	mov    %rsp,%rbp
ffff800000107283:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107287:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff80000010728a:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107291:	80 ff ff 
ffff800000107294:	48 89 c7             	mov    %rax,%rdi
ffff800000107297:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010729e:	80 ff ff 
ffff8000001072a1:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001072a3:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001072aa:	80 ff ff 
ffff8000001072ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001072b1:	eb 56                	jmp    ffff800000107309 <kill+0x8a>
    if(p->pid == pid){
ffff8000001072b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072b7:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001072ba:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001072bd:	75 42                	jne    ffff800000107301 <kill+0x82>
      p->killed = 1;
ffff8000001072bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072c3:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff8000001072ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072ce:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001072d1:	83 f8 02             	cmp    $0x2,%eax
ffff8000001072d4:	75 0b                	jne    ffff8000001072e1 <kill+0x62>
        p->state = RUNNABLE;
ffff8000001072d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072da:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff8000001072e1:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001072e8:	80 ff ff 
ffff8000001072eb:	48 89 c7             	mov    %rax,%rdi
ffff8000001072ee:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001072f5:	80 ff ff 
ffff8000001072f8:	ff d0                	call   *%rax
      return 0;
ffff8000001072fa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001072ff:	eb 36                	jmp    ffff800000107337 <kill+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107301:	48 81 45 f8 30 02 00 	addq   $0x230,-0x8(%rbp)
ffff800000107308:	00 
ffff800000107309:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff800000107310:	80 ff ff 
ffff800000107313:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107317:	72 9a                	jb     ffff8000001072b3 <kill+0x34>
    }
  }
  release(&ptable.lock);
ffff800000107319:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107320:	80 ff ff 
ffff800000107323:	48 89 c7             	mov    %rax,%rdi
ffff800000107326:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010732d:	80 ff ff 
ffff800000107330:	ff d0                	call   *%rax
  return -1;
ffff800000107332:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107337:	c9                   	leave
ffff800000107338:	c3                   	ret

ffff800000107339 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff800000107339:	55                   	push   %rbp
ffff80000010733a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010733d:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107341:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000107348:	80 ff ff 
ffff80000010734b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010734f:	e9 41 01 00 00       	jmp    ffff800000107495 <procdump+0x15c>
    if(p->state == UNUSED)
ffff800000107354:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107358:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010735b:	85 c0                	test   %eax,%eax
ffff80000010735d:	0f 84 29 01 00 00    	je     ffff80000010748c <procdump+0x153>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff800000107363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107367:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010736a:	83 f8 05             	cmp    $0x5,%eax
ffff80000010736d:	77 39                	ja     ffff8000001073a8 <procdump+0x6f>
ffff80000010736f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107373:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107376:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff80000010737d:	80 ff ff 
ffff800000107380:	89 d2                	mov    %edx,%edx
ffff800000107382:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff800000107386:	48 85 c0             	test   %rax,%rax
ffff800000107389:	74 1d                	je     ffff8000001073a8 <procdump+0x6f>
      state = states[p->state];
ffff80000010738b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010738f:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107392:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff800000107399:	80 ff ff 
ffff80000010739c:	89 d2                	mov    %edx,%edx
ffff80000010739e:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff8000001073a2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001073a6:	eb 0e                	jmp    ffff8000001073b6 <procdump+0x7d>
    else
      state = "???";
ffff8000001073a8:	48 b8 d2 cb 10 00 00 	movabs $0xffff80000010cbd2,%rax
ffff8000001073af:	80 ff ff 
ffff8000001073b2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff8000001073b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073ba:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001073c1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073c5:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001073c8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001073cc:	48 bf d6 cb 10 00 00 	movabs $0xffff80000010cbd6,%rdi
ffff8000001073d3:	80 ff ff 
ffff8000001073d6:	89 c6                	mov    %eax,%esi
ffff8000001073d8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001073dd:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff8000001073e4:	80 ff ff 
ffff8000001073e7:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff8000001073ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073ee:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001073f1:	83 f8 02             	cmp    $0x2,%eax
ffff8000001073f4:	75 76                	jne    ffff80000010746c <procdump+0x133>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff8000001073f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073fa:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001073fe:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107402:	48 83 c0 10          	add    $0x10,%rax
ffff800000107406:	48 89 c2             	mov    %rax,%rdx
ffff800000107409:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff80000010740d:	48 89 c6             	mov    %rax,%rsi
ffff800000107410:	48 89 d7             	mov    %rdx,%rdi
ffff800000107413:	48 b8 2f 78 10 00 00 	movabs $0xffff80000010782f,%rax
ffff80000010741a:	80 ff ff 
ffff80000010741d:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff80000010741f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107426:	eb 2f                	jmp    ffff800000107457 <procdump+0x11e>
        cprintf(" %p", pc[i]);
ffff800000107428:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010742b:	48 98                	cltq
ffff80000010742d:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107432:	48 ba df cb 10 00 00 	movabs $0xffff80000010cbdf,%rdx
ffff800000107439:	80 ff ff 
ffff80000010743c:	48 89 c6             	mov    %rax,%rsi
ffff80000010743f:	48 89 d7             	mov    %rdx,%rdi
ffff800000107442:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107447:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010744e:	80 ff ff 
ffff800000107451:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff800000107453:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107457:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff80000010745b:	7f 0f                	jg     ffff80000010746c <procdump+0x133>
ffff80000010745d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107460:	48 98                	cltq
ffff800000107462:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107467:	48 85 c0             	test   %rax,%rax
ffff80000010746a:	75 bc                	jne    ffff800000107428 <procdump+0xef>
    }
    cprintf("\n");
ffff80000010746c:	48 b8 e3 cb 10 00 00 	movabs $0xffff80000010cbe3,%rax
ffff800000107473:	80 ff ff 
ffff800000107476:	48 89 c7             	mov    %rax,%rdi
ffff800000107479:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010747e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000107485:	80 ff ff 
ffff800000107488:	ff d2                	call   *%rdx
ffff80000010748a:	eb 01                	jmp    ffff80000010748d <procdump+0x154>
      continue;
ffff80000010748c:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010748d:	48 81 45 f0 30 02 00 	addq   $0x230,-0x10(%rbp)
ffff800000107494:	00 
ffff800000107495:	48 b8 a8 00 12 00 00 	movabs $0xffff8000001200a8,%rax
ffff80000010749c:	80 ff ff 
ffff80000010749f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001074a3:	0f 82 ab fe ff ff    	jb     ffff800000107354 <procdump+0x1b>
  }

  cprintf("Free pages: %d\n",kfreepagecount());
ffff8000001074a9:	48 b8 4f 42 10 00 00 	movabs $0xffff80000010424f,%rax
ffff8000001074b0:	80 ff ff 
ffff8000001074b3:	ff d0                	call   *%rax
ffff8000001074b5:	89 c2                	mov    %eax,%edx
ffff8000001074b7:	48 b8 e5 cb 10 00 00 	movabs $0xffff80000010cbe5,%rax
ffff8000001074be:	80 ff ff 
ffff8000001074c1:	89 d6                	mov    %edx,%esi
ffff8000001074c3:	48 89 c7             	mov    %rax,%rdi
ffff8000001074c6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001074cb:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001074d2:	80 ff ff 
ffff8000001074d5:	ff d2                	call   *%rdx
  
}
ffff8000001074d7:	90                   	nop
ffff8000001074d8:	c9                   	leave
ffff8000001074d9:	c3                   	ret

ffff8000001074da <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
ffff8000001074da:	55                   	push   %rbp
ffff8000001074db:	48 89 e5             	mov    %rsp,%rbp
ffff8000001074de:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001074e2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001074e6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&lk->lk, "sleep lock");
ffff8000001074ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074ee:	48 83 c0 08          	add    $0x8,%rax
ffff8000001074f2:	48 ba 1f cc 10 00 00 	movabs $0xffff80000010cc1f,%rdx
ffff8000001074f9:	80 ff ff 
ffff8000001074fc:	48 89 d6             	mov    %rdx,%rsi
ffff8000001074ff:	48 89 c7             	mov    %rax,%rdi
ffff800000107502:	48 b8 b0 76 10 00 00 	movabs $0xffff8000001076b0,%rax
ffff800000107509:	80 ff ff 
ffff80000010750c:	ff d0                	call   *%rax
  lk->name = name;
ffff80000010750e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107512:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000107516:	48 89 50 70          	mov    %rdx,0x70(%rax)
  lk->locked = 0;
ffff80000010751a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010751e:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff800000107524:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107528:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
}
ffff80000010752f:	90                   	nop
ffff800000107530:	c9                   	leave
ffff800000107531:	c3                   	ret

ffff800000107532 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
ffff800000107532:	55                   	push   %rbp
ffff800000107533:	48 89 e5             	mov    %rsp,%rbp
ffff800000107536:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010753a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff80000010753e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107542:	48 83 c0 08          	add    $0x8,%rax
ffff800000107546:	48 89 c7             	mov    %rax,%rdi
ffff800000107549:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff800000107550:	80 ff ff 
ffff800000107553:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107555:	eb 1e                	jmp    ffff800000107575 <acquiresleep+0x43>
    sleep(lk, &lk->lk);
ffff800000107557:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010755b:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff80000010755f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107563:	48 89 d6             	mov    %rdx,%rsi
ffff800000107566:	48 89 c7             	mov    %rax,%rdi
ffff800000107569:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000107570:	80 ff ff 
ffff800000107573:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107575:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107579:	8b 00                	mov    (%rax),%eax
ffff80000010757b:	85 c0                	test   %eax,%eax
ffff80000010757d:	75 d8                	jne    ffff800000107557 <acquiresleep+0x25>
  lk->locked = 1;
ffff80000010757f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107583:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  lk->pid = proc->pid;
ffff800000107589:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107590:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107594:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000107597:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010759b:	89 50 78             	mov    %edx,0x78(%rax)
  release(&lk->lk);
ffff80000010759e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075a2:	48 83 c0 08          	add    $0x8,%rax
ffff8000001075a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001075a9:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001075b0:	80 ff ff 
ffff8000001075b3:	ff d0                	call   *%rax
}
ffff8000001075b5:	90                   	nop
ffff8000001075b6:	c9                   	leave
ffff8000001075b7:	c3                   	ret

ffff8000001075b8 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
ffff8000001075b8:	55                   	push   %rbp
ffff8000001075b9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001075bc:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001075c0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff8000001075c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075c8:	48 83 c0 08          	add    $0x8,%rax
ffff8000001075cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001075cf:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001075d6:	80 ff ff 
ffff8000001075d9:	ff d0                	call   *%rax
  lk->locked = 0;
ffff8000001075db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075df:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff8000001075e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075e9:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
  wakeup(lk);
ffff8000001075f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001075f7:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff8000001075fe:	80 ff ff 
ffff800000107601:	ff d0                	call   *%rax
  release(&lk->lk);
ffff800000107603:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107607:	48 83 c0 08          	add    $0x8,%rax
ffff80000010760b:	48 89 c7             	mov    %rax,%rdi
ffff80000010760e:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000107615:	80 ff ff 
ffff800000107618:	ff d0                	call   *%rax
}
ffff80000010761a:	90                   	nop
ffff80000010761b:	c9                   	leave
ffff80000010761c:	c3                   	ret

ffff80000010761d <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
ffff80000010761d:	55                   	push   %rbp
ffff80000010761e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107621:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107625:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  acquire(&lk->lk);
ffff800000107629:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010762d:	48 83 c0 08          	add    $0x8,%rax
ffff800000107631:	48 89 c7             	mov    %rax,%rdi
ffff800000107634:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010763b:	80 ff ff 
ffff80000010763e:	ff d0                	call   *%rax
  int r = lk->locked;
ffff800000107640:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107644:	8b 00                	mov    (%rax),%eax
ffff800000107646:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&lk->lk);
ffff800000107649:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010764d:	48 83 c0 08          	add    $0x8,%rax
ffff800000107651:	48 89 c7             	mov    %rax,%rdi
ffff800000107654:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010765b:	80 ff ff 
ffff80000010765e:	ff d0                	call   *%rax
  return r;
ffff800000107660:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107663:	c9                   	leave
ffff800000107664:	c3                   	ret

ffff800000107665 <readeflags>:
{
ffff800000107665:	55                   	push   %rbp
ffff800000107666:	48 89 e5             	mov    %rsp,%rbp
ffff800000107669:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff80000010766d:	9c                   	pushf
ffff80000010766e:	58                   	pop    %rax
ffff80000010766f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff800000107673:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107677:	c9                   	leave
ffff800000107678:	c3                   	ret

ffff800000107679 <cli>:
{
ffff800000107679:	55                   	push   %rbp
ffff80000010767a:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffff80000010767d:	fa                   	cli
}
ffff80000010767e:	90                   	nop
ffff80000010767f:	5d                   	pop    %rbp
ffff800000107680:	c3                   	ret

ffff800000107681 <sti>:
{
ffff800000107681:	55                   	push   %rbp
ffff800000107682:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff800000107685:	fb                   	sti
}
ffff800000107686:	90                   	nop
ffff800000107687:	5d                   	pop    %rbp
ffff800000107688:	c3                   	ret

ffff800000107689 <xchg>:
{
ffff800000107689:	55                   	push   %rbp
ffff80000010768a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010768d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107691:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107695:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("lock; xchgl %0, %1" :
ffff800000107699:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010769d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001076a1:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001076a5:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001076a8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  return result;
ffff8000001076ab:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001076ae:	c9                   	leave
ffff8000001076af:	c3                   	ret

ffff8000001076b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
ffff8000001076b0:	55                   	push   %rbp
ffff8000001076b1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076b4:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001076b8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001076bc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffff8000001076c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076c4:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001076c8:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffff8000001076cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076d0:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffff8000001076d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076da:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001076e1:	00 
}
ffff8000001076e2:	90                   	nop
ffff8000001076e3:	c9                   	leave
ffff8000001076e4:	c3                   	ret

ffff8000001076e5 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
ffff8000001076e5:	55                   	push   %rbp
ffff8000001076e6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076e9:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001076ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffff8000001076f1:	48 b8 05 79 10 00 00 	movabs $0xffff800000107905,%rax
ffff8000001076f8:	80 ff ff 
ffff8000001076fb:	ff d0                	call   *%rax
  if(holding(lk))
ffff8000001076fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107701:	48 89 c7             	mov    %rax,%rdi
ffff800000107704:	48 b8 c9 78 10 00 00 	movabs $0xffff8000001078c9,%rax
ffff80000010770b:	80 ff ff 
ffff80000010770e:	ff d0                	call   *%rax
ffff800000107710:	85 c0                	test   %eax,%eax
ffff800000107712:	74 19                	je     ffff80000010772d <acquire+0x48>
    panic("acquire");
ffff800000107714:	48 b8 2a cc 10 00 00 	movabs $0xffff80000010cc2a,%rax
ffff80000010771b:	80 ff ff 
ffff80000010771e:	48 89 c7             	mov    %rax,%rdi
ffff800000107721:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107728:	80 ff ff 
ffff80000010772b:	ff d0                	call   *%rax

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
ffff80000010772d:	90                   	nop
ffff80000010772e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107732:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000107737:	48 89 c7             	mov    %rax,%rdi
ffff80000010773a:	48 b8 89 76 10 00 00 	movabs $0xffff800000107689,%rax
ffff800000107741:	80 ff ff 
ffff800000107744:	ff d0                	call   *%rax
ffff800000107746:	85 c0                	test   %eax,%eax
ffff800000107748:	75 e4                	jne    ffff80000010772e <acquire+0x49>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
ffff80000010774a:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
ffff800000107750:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107754:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff80000010775b:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff80000010775f:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffff800000107763:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107767:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff80000010776b:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010776f:	48 89 d6             	mov    %rdx,%rsi
ffff800000107772:	48 89 c7             	mov    %rax,%rdi
ffff800000107775:	48 b8 fb 77 10 00 00 	movabs $0xffff8000001077fb,%rax
ffff80000010777c:	80 ff ff 
ffff80000010777f:	ff d0                	call   *%rax
}
ffff800000107781:	90                   	nop
ffff800000107782:	c9                   	leave
ffff800000107783:	c3                   	ret

ffff800000107784 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
ffff800000107784:	55                   	push   %rbp
ffff800000107785:	48 89 e5             	mov    %rsp,%rbp
ffff800000107788:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010778c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffff800000107790:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107794:	48 89 c7             	mov    %rax,%rdi
ffff800000107797:	48 b8 c9 78 10 00 00 	movabs $0xffff8000001078c9,%rax
ffff80000010779e:	80 ff ff 
ffff8000001077a1:	ff d0                	call   *%rax
ffff8000001077a3:	85 c0                	test   %eax,%eax
ffff8000001077a5:	75 19                	jne    ffff8000001077c0 <release+0x3c>
    panic("release");
ffff8000001077a7:	48 b8 32 cc 10 00 00 	movabs $0xffff80000010cc32,%rax
ffff8000001077ae:	80 ff ff 
ffff8000001077b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001077b4:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001077bb:	80 ff ff 
ffff8000001077be:	ff d0                	call   *%rax

  lk->pcs[0] = 0;
ffff8000001077c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077c4:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff8000001077cb:	00 
  lk->cpu = 0;
ffff8000001077cc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077d0:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001077d7:	00 
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
ffff8000001077d8:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
ffff8000001077de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077e2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001077e6:	c7 00 00 00 00 00    	movl   $0x0,(%rax)

  popcli();
ffff8000001077ec:	48 b8 73 79 10 00 00 	movabs $0xffff800000107973,%rax
ffff8000001077f3:	80 ff ff 
ffff8000001077f6:	ff d0                	call   *%rax
}
ffff8000001077f8:	90                   	nop
ffff8000001077f9:	c9                   	leave
ffff8000001077fa:	c3                   	ret

ffff8000001077fb <getcallerpcs>:

// Record the current call stack in pcs[] by following the %rbp chain.
void
getcallerpcs(void *v, addr_t pcs[])
{
ffff8000001077fb:	55                   	push   %rbp
ffff8000001077fc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077ff:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107803:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107807:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  addr_t *rbp;

  asm volatile("mov %%rbp, %0" : "=r" (rbp));
ffff80000010780b:	48 89 e8             	mov    %rbp,%rax
ffff80000010780e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  getstackpcs(rbp, pcs);
ffff800000107812:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107816:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010781a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010781d:	48 89 c7             	mov    %rax,%rdi
ffff800000107820:	48 b8 2f 78 10 00 00 	movabs $0xffff80000010782f,%rax
ffff800000107827:	80 ff ff 
ffff80000010782a:	ff d0                	call   *%rax
}
ffff80000010782c:	90                   	nop
ffff80000010782d:	c9                   	leave
ffff80000010782e:	c3                   	ret

ffff80000010782f <getstackpcs>:

void
getstackpcs(addr_t *rbp, addr_t pcs[])
{
ffff80000010782f:	55                   	push   %rbp
ffff800000107830:	48 89 e5             	mov    %rsp,%rbp
ffff800000107833:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107837:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010783b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 0; i < 10; i++){
ffff80000010783f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107846:	eb 50                	jmp    ffff800000107898 <getstackpcs+0x69>
    if(rbp == 0 || rbp < (addr_t*)KERNBASE || rbp == (addr_t*)0xffffffff)
ffff800000107848:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010784d:	74 70                	je     ffff8000001078bf <getstackpcs+0x90>
ffff80000010784f:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff800000107856:	7f ff ff 
ffff800000107859:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff80000010785d:	73 60                	jae    ffff8000001078bf <getstackpcs+0x90>
ffff80000010785f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107864:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107868:	74 55                	je     ffff8000001078bf <getstackpcs+0x90>
      break;
    pcs[i] = rbp[1];     // saved %rip
ffff80000010786a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010786d:	48 98                	cltq
ffff80000010786f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107876:	00 
ffff800000107877:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010787b:	48 01 c2             	add    %rax,%rdx
ffff80000010787e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107882:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107886:	48 89 02             	mov    %rax,(%rdx)
    rbp = (addr_t*)rbp[0]; // saved %rbp
ffff800000107889:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010788d:	48 8b 00             	mov    (%rax),%rax
ffff800000107890:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffff800000107894:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107898:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff80000010789c:	7e aa                	jle    ffff800000107848 <getstackpcs+0x19>
  }
  for(; i < 10; i++)
ffff80000010789e:	eb 1f                	jmp    ffff8000001078bf <getstackpcs+0x90>
    pcs[i] = 0;
ffff8000001078a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001078a3:	48 98                	cltq
ffff8000001078a5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001078ac:	00 
ffff8000001078ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001078b1:	48 01 d0             	add    %rdx,%rax
ffff8000001078b4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffff8000001078bb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001078bf:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff8000001078c3:	7e db                	jle    ffff8000001078a0 <getstackpcs+0x71>
}
ffff8000001078c5:	90                   	nop
ffff8000001078c6:	90                   	nop
ffff8000001078c7:	c9                   	leave
ffff8000001078c8:	c3                   	ret

ffff8000001078c9 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
ffff8000001078c9:	55                   	push   %rbp
ffff8000001078ca:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078cd:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001078d1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffff8000001078d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078d9:	8b 00                	mov    (%rax),%eax
ffff8000001078db:	85 c0                	test   %eax,%eax
ffff8000001078dd:	74 1f                	je     ffff8000001078fe <holding+0x35>
ffff8000001078df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078e3:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001078e7:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001078ee:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001078f2:	48 39 c2             	cmp    %rax,%rdx
ffff8000001078f5:	75 07                	jne    ffff8000001078fe <holding+0x35>
ffff8000001078f7:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001078fc:	eb 05                	jmp    ffff800000107903 <holding+0x3a>
ffff8000001078fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107903:	c9                   	leave
ffff800000107904:	c3                   	ret

ffff800000107905 <pushcli>:
// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.
void
pushcli(void)
{
ffff800000107905:	55                   	push   %rbp
ffff800000107906:	48 89 e5             	mov    %rsp,%rbp
ffff800000107909:	48 83 ec 10          	sub    $0x10,%rsp
  int eflags;

  eflags = readeflags();
ffff80000010790d:	48 b8 65 76 10 00 00 	movabs $0xffff800000107665,%rax
ffff800000107914:	80 ff ff 
ffff800000107917:	ff d0                	call   *%rax
ffff800000107919:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffff80000010791c:	48 b8 79 76 10 00 00 	movabs $0xffff800000107679,%rax
ffff800000107923:	80 ff ff 
ffff800000107926:	ff d0                	call   *%rax
  if(cpu->ncli == 0)
ffff800000107928:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010792f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107933:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107936:	85 c0                	test   %eax,%eax
ffff800000107938:	75 17                	jne    ffff800000107951 <pushcli+0x4c>
    cpu->intena = eflags & FL_IF;
ffff80000010793a:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107941:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107945:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000107948:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff80000010794e:	89 50 18             	mov    %edx,0x18(%rax)
  cpu->ncli += 1;
ffff800000107951:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107958:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010795c:	8b 50 14             	mov    0x14(%rax),%edx
ffff80000010795f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107966:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010796a:	83 c2 01             	add    $0x1,%edx
ffff80000010796d:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000107970:	90                   	nop
ffff800000107971:	c9                   	leave
ffff800000107972:	c3                   	ret

ffff800000107973 <popcli>:

void
popcli(void)
{
ffff800000107973:	55                   	push   %rbp
ffff800000107974:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffff800000107977:	48 b8 65 76 10 00 00 	movabs $0xffff800000107665,%rax
ffff80000010797e:	80 ff ff 
ffff800000107981:	ff d0                	call   *%rax
ffff800000107983:	25 00 02 00 00       	and    $0x200,%eax
ffff800000107988:	48 85 c0             	test   %rax,%rax
ffff80000010798b:	74 19                	je     ffff8000001079a6 <popcli+0x33>
    panic("popcli - interruptible");
ffff80000010798d:	48 b8 3a cc 10 00 00 	movabs $0xffff80000010cc3a,%rax
ffff800000107994:	80 ff ff 
ffff800000107997:	48 89 c7             	mov    %rax,%rdi
ffff80000010799a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001079a1:	80 ff ff 
ffff8000001079a4:	ff d0                	call   *%rax
  if(--cpu->ncli < 0)
ffff8000001079a6:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079ad:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079b1:	8b 50 14             	mov    0x14(%rax),%edx
ffff8000001079b4:	83 ea 01             	sub    $0x1,%edx
ffff8000001079b7:	89 50 14             	mov    %edx,0x14(%rax)
ffff8000001079ba:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001079bd:	85 c0                	test   %eax,%eax
ffff8000001079bf:	79 19                	jns    ffff8000001079da <popcli+0x67>
    panic("popcli");
ffff8000001079c1:	48 b8 51 cc 10 00 00 	movabs $0xffff80000010cc51,%rax
ffff8000001079c8:	80 ff ff 
ffff8000001079cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001079ce:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001079d5:	80 ff ff 
ffff8000001079d8:	ff d0                	call   *%rax
  if(cpu->ncli == 0 && cpu->intena)
ffff8000001079da:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079e1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079e5:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001079e8:	85 c0                	test   %eax,%eax
ffff8000001079ea:	75 1e                	jne    ffff800000107a0a <popcli+0x97>
ffff8000001079ec:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079f3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079f7:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001079fa:	85 c0                	test   %eax,%eax
ffff8000001079fc:	74 0c                	je     ffff800000107a0a <popcli+0x97>
    sti();
ffff8000001079fe:	48 b8 81 76 10 00 00 	movabs $0xffff800000107681,%rax
ffff800000107a05:	80 ff ff 
ffff800000107a08:	ff d0                	call   *%rax
}
ffff800000107a0a:	90                   	nop
ffff800000107a0b:	5d                   	pop    %rbp
ffff800000107a0c:	c3                   	ret

ffff800000107a0d <stosb>:
{
ffff800000107a0d:	55                   	push   %rbp
ffff800000107a0e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a11:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a15:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a19:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a1c:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
ffff800000107a1f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a23:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a26:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a29:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a2c:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a2f:	89 d1                	mov    %edx,%ecx
ffff800000107a31:	fc                   	cld
ffff800000107a32:	f3 aa                	rep stos %al,(%rdi)
ffff800000107a34:	89 ca                	mov    %ecx,%edx
ffff800000107a36:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a39:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a3d:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffff800000107a40:	90                   	nop
ffff800000107a41:	c9                   	leave
ffff800000107a42:	c3                   	ret

ffff800000107a43 <stosl>:
{
ffff800000107a43:	55                   	push   %rbp
ffff800000107a44:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a47:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a4b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a4f:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a52:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosl" :
ffff800000107a55:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a59:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a5c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a5f:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a62:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a65:	89 d1                	mov    %edx,%ecx
ffff800000107a67:	fc                   	cld
ffff800000107a68:	f3 ab                	rep stos %eax,(%rdi)
ffff800000107a6a:	89 ca                	mov    %ecx,%edx
ffff800000107a6c:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a6f:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a73:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffff800000107a76:	90                   	nop
ffff800000107a77:	c9                   	leave
ffff800000107a78:	c3                   	ret

ffff800000107a79 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint64 n)
{
ffff800000107a79:	55                   	push   %rbp
ffff800000107a7a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a7d:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107a81:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a85:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a88:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  if ((addr_t)dst%4 == 0 && n%4 == 0){
ffff800000107a8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a90:	83 e0 03             	and    $0x3,%eax
ffff800000107a93:	48 85 c0             	test   %rax,%rax
ffff800000107a96:	75 53                	jne    ffff800000107aeb <memset+0x72>
ffff800000107a98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a9c:	83 e0 03             	and    $0x3,%eax
ffff800000107a9f:	48 85 c0             	test   %rax,%rax
ffff800000107aa2:	75 47                	jne    ffff800000107aeb <memset+0x72>
    c &= 0xFF;
ffff800000107aa4:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffff800000107aab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107aaf:	48 c1 e8 02          	shr    $0x2,%rax
ffff800000107ab3:	89 c6                	mov    %eax,%esi
ffff800000107ab5:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107ab8:	c1 e0 18             	shl    $0x18,%eax
ffff800000107abb:	89 c2                	mov    %eax,%edx
ffff800000107abd:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107ac0:	c1 e0 10             	shl    $0x10,%eax
ffff800000107ac3:	09 c2                	or     %eax,%edx
ffff800000107ac5:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107ac8:	c1 e0 08             	shl    $0x8,%eax
ffff800000107acb:	09 d0                	or     %edx,%eax
ffff800000107acd:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff800000107ad0:	89 c1                	mov    %eax,%ecx
ffff800000107ad2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ad6:	89 f2                	mov    %esi,%edx
ffff800000107ad8:	89 ce                	mov    %ecx,%esi
ffff800000107ada:	48 89 c7             	mov    %rax,%rdi
ffff800000107add:	48 b8 43 7a 10 00 00 	movabs $0xffff800000107a43,%rax
ffff800000107ae4:	80 ff ff 
ffff800000107ae7:	ff d0                	call   *%rax
ffff800000107ae9:	eb 1e                	jmp    ffff800000107b09 <memset+0x90>
  } else
    stosb(dst, c, n);
ffff800000107aeb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107aef:	89 c2                	mov    %eax,%edx
ffff800000107af1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff800000107af4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107af8:	89 ce                	mov    %ecx,%esi
ffff800000107afa:	48 89 c7             	mov    %rax,%rdi
ffff800000107afd:	48 b8 0d 7a 10 00 00 	movabs $0xffff800000107a0d,%rax
ffff800000107b04:	80 ff ff 
ffff800000107b07:	ff d0                	call   *%rax
  return dst;
ffff800000107b09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107b0d:	c9                   	leave
ffff800000107b0e:	c3                   	ret

ffff800000107b0f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
ffff800000107b0f:	55                   	push   %rbp
ffff800000107b10:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b13:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107b17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b1b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107b1f:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const uchar *s1, *s2;

  s1 = v1;
ffff800000107b22:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b26:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffff800000107b2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b2e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffff800000107b32:	eb 34                	jmp    ffff800000107b68 <memcmp+0x59>
    if(*s1 != *s2)
ffff800000107b34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b38:	0f b6 10             	movzbl (%rax),%edx
ffff800000107b3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b3f:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b42:	38 c2                	cmp    %al,%dl
ffff800000107b44:	74 18                	je     ffff800000107b5e <memcmp+0x4f>
      return *s1 - *s2;
ffff800000107b46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b4a:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b4d:	0f b6 d0             	movzbl %al,%edx
ffff800000107b50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b54:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b57:	0f b6 c0             	movzbl %al,%eax
ffff800000107b5a:	29 c2                	sub    %eax,%edx
ffff800000107b5c:	eb 1c                	jmp    ffff800000107b7a <memcmp+0x6b>
    s1++, s2++;
ffff800000107b5e:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107b63:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffff800000107b68:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107b6b:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107b6e:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107b71:	85 c0                	test   %eax,%eax
ffff800000107b73:	75 bf                	jne    ffff800000107b34 <memcmp+0x25>
  }

  return 0;
ffff800000107b75:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffff800000107b7a:	89 d0                	mov    %edx,%eax
ffff800000107b7c:	c9                   	leave
ffff800000107b7d:	c3                   	ret

ffff800000107b7e <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
ffff800000107b7e:	55                   	push   %rbp
ffff800000107b7f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b82:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107b86:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b8a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107b8e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const char *s;
  char *d;

  s = src;
ffff800000107b91:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffff800000107b99:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b9d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffff800000107ba1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ba5:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107ba9:	73 63                	jae    ffff800000107c0e <memmove+0x90>
ffff800000107bab:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000107bae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bb2:	48 01 d0             	add    %rdx,%rax
ffff800000107bb5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107bb9:	73 53                	jae    ffff800000107c0e <memmove+0x90>
    s += n;
ffff800000107bbb:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bbe:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffff800000107bc2:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bc5:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffff800000107bc9:	eb 17                	jmp    ffff800000107be2 <memmove+0x64>
      *--d = *--s;
ffff800000107bcb:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff800000107bd0:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff800000107bd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bd9:	0f b6 10             	movzbl (%rax),%edx
ffff800000107bdc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107be0:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107be2:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107be5:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107be8:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107beb:	85 c0                	test   %eax,%eax
ffff800000107bed:	75 dc                	jne    ffff800000107bcb <memmove+0x4d>
  if(s < d && s + n > d){
ffff800000107bef:	eb 2a                	jmp    ffff800000107c1b <memmove+0x9d>
  } else
    while(n-- > 0)
      *d++ = *s++;
ffff800000107bf1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107bf5:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107bf9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107bfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c01:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107c05:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff800000107c09:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107c0c:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107c0e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107c11:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107c14:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107c17:	85 c0                	test   %eax,%eax
ffff800000107c19:	75 d6                	jne    ffff800000107bf1 <memmove+0x73>

  return dst;
ffff800000107c1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff800000107c1f:	c9                   	leave
ffff800000107c20:	c3                   	ret

ffff800000107c21 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
ffff800000107c21:	55                   	push   %rbp
ffff800000107c22:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c25:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c29:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c2d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c31:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffff800000107c34:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000107c37:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000107c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c3f:	48 89 ce             	mov    %rcx,%rsi
ffff800000107c42:	48 89 c7             	mov    %rax,%rdi
ffff800000107c45:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff800000107c4c:	80 ff ff 
ffff800000107c4f:	ff d0                	call   *%rax
}
ffff800000107c51:	c9                   	leave
ffff800000107c52:	c3                   	ret

ffff800000107c53 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
ffff800000107c53:	55                   	push   %rbp
ffff800000107c54:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c57:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c5b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c5f:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c63:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107c66:	eb 0e                	jmp    ffff800000107c76 <strncmp+0x23>
    n--, p++, q++;
ffff800000107c68:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff800000107c6c:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107c71:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107c76:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107c7a:	74 1d                	je     ffff800000107c99 <strncmp+0x46>
ffff800000107c7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c80:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c83:	84 c0                	test   %al,%al
ffff800000107c85:	74 12                	je     ffff800000107c99 <strncmp+0x46>
ffff800000107c87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c8b:	0f b6 10             	movzbl (%rax),%edx
ffff800000107c8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c92:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c95:	38 c2                	cmp    %al,%dl
ffff800000107c97:	74 cf                	je     ffff800000107c68 <strncmp+0x15>
  if(n == 0)
ffff800000107c99:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107c9d:	75 07                	jne    ffff800000107ca6 <strncmp+0x53>
    return 0;
ffff800000107c9f:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107ca4:	eb 16                	jmp    ffff800000107cbc <strncmp+0x69>
  return (uchar)*p - (uchar)*q;
ffff800000107ca6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107caa:	0f b6 00             	movzbl (%rax),%eax
ffff800000107cad:	0f b6 d0             	movzbl %al,%edx
ffff800000107cb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107cb4:	0f b6 00             	movzbl (%rax),%eax
ffff800000107cb7:	0f b6 c0             	movzbl %al,%eax
ffff800000107cba:	29 c2                	sub    %eax,%edx
}
ffff800000107cbc:	89 d0                	mov    %edx,%eax
ffff800000107cbe:	c9                   	leave
ffff800000107cbf:	c3                   	ret

ffff800000107cc0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffff800000107cc0:	55                   	push   %rbp
ffff800000107cc1:	48 89 e5             	mov    %rsp,%rbp
ffff800000107cc4:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107cc8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107ccc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107cd0:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107cd3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107cd7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffff800000107cdb:	90                   	nop
ffff800000107cdc:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107cdf:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107ce2:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107ce5:	85 c0                	test   %eax,%eax
ffff800000107ce7:	7e 35                	jle    ffff800000107d1e <strncpy+0x5e>
ffff800000107ce9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107ced:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107cf1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107cf5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107cf9:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107cfd:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107d01:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107d04:	88 10                	mov    %dl,(%rax)
ffff800000107d06:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d09:	84 c0                	test   %al,%al
ffff800000107d0b:	75 cf                	jne    ffff800000107cdc <strncpy+0x1c>
    ;
  while(n-- > 0)
ffff800000107d0d:	eb 0f                	jmp    ffff800000107d1e <strncpy+0x5e>
    *s++ = 0;
ffff800000107d0f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d13:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000107d17:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107d1b:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffff800000107d1e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107d21:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107d24:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107d27:	85 c0                	test   %eax,%eax
ffff800000107d29:	7f e4                	jg     ffff800000107d0f <strncpy+0x4f>
  return os;
ffff800000107d2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107d2f:	c9                   	leave
ffff800000107d30:	c3                   	ret

ffff800000107d31 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffff800000107d31:	55                   	push   %rbp
ffff800000107d32:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d35:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107d39:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107d3d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107d41:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107d44:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffff800000107d4c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107d50:	7f 06                	jg     ffff800000107d58 <safestrcpy+0x27>
    return os;
ffff800000107d52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d56:	eb 3a                	jmp    ffff800000107d92 <safestrcpy+0x61>
  while(--n > 0 && (*s++ = *t++) != 0)
ffff800000107d58:	90                   	nop
ffff800000107d59:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000107d5d:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107d61:	7e 24                	jle    ffff800000107d87 <safestrcpy+0x56>
ffff800000107d63:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107d67:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107d6b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107d6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d73:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107d77:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107d7b:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107d7e:	88 10                	mov    %dl,(%rax)
ffff800000107d80:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d83:	84 c0                	test   %al,%al
ffff800000107d85:	75 d2                	jne    ffff800000107d59 <safestrcpy+0x28>
    ;
  *s = 0;
ffff800000107d87:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d8b:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffff800000107d8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107d92:	c9                   	leave
ffff800000107d93:	c3                   	ret

ffff800000107d94 <strlen>:

int
strlen(const char *s)
{
ffff800000107d94:	55                   	push   %rbp
ffff800000107d95:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d98:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107d9c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffff800000107da0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107da7:	eb 04                	jmp    ffff800000107dad <strlen+0x19>
ffff800000107da9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107dad:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107db0:	48 63 d0             	movslq %eax,%rdx
ffff800000107db3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107db7:	48 01 d0             	add    %rdx,%rax
ffff800000107dba:	0f b6 00             	movzbl (%rax),%eax
ffff800000107dbd:	84 c0                	test   %al,%al
ffff800000107dbf:	75 e8                	jne    ffff800000107da9 <strlen+0x15>
    ;
  return n;
ffff800000107dc1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107dc4:	c9                   	leave
ffff800000107dc5:	c3                   	ret

ffff800000107dc6 <swtch>:
# and then load register context from new.

.global swtch
swtch:
  # Save old callee-save registers
  pushq   %rbp
ffff800000107dc6:	55                   	push   %rbp
  pushq   %rbx
ffff800000107dc7:	53                   	push   %rbx
  pushq   %r12
ffff800000107dc8:	41 54                	push   %r12
  pushq   %r13
ffff800000107dca:	41 55                	push   %r13
  pushq   %r14
ffff800000107dcc:	41 56                	push   %r14
  pushq   %r15
ffff800000107dce:	41 57                	push   %r15

  # Switch stacks
  movq    %rsp, (%rdi)
ffff800000107dd0:	48 89 27             	mov    %rsp,(%rdi)
  movq    %rsi, %rsp
ffff800000107dd3:	48 89 f4             	mov    %rsi,%rsp

  # Load new callee-save registers
  popq    %r15
ffff800000107dd6:	41 5f                	pop    %r15
  popq    %r14
ffff800000107dd8:	41 5e                	pop    %r14
  popq    %r13
ffff800000107dda:	41 5d                	pop    %r13
  popq    %r12
ffff800000107ddc:	41 5c                	pop    %r12
  popq    %rbx
ffff800000107dde:	5b                   	pop    %rbx
  popq    %rbp
ffff800000107ddf:	5d                   	pop    %rbp

  retq #??
ffff800000107de0:	c3                   	ret

ffff800000107de1 <fetchint>:
#include "syscall.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff800000107de1:	55                   	push   %rbp
ffff800000107de2:	48 89 e5             	mov    %rsp,%rbp
ffff800000107de5:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107de9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107ded:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff800000107df1:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107df8:	00 
ffff800000107df9:	76 2f                	jbe    ffff800000107e2a <fetchint+0x49>
ffff800000107dfb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e02:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e06:	48 8b 00             	mov    (%rax),%rax
ffff800000107e09:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107e0d:	73 1b                	jae    ffff800000107e2a <fetchint+0x49>
ffff800000107e0f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e13:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000107e17:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e1e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e22:	48 8b 00             	mov    (%rax),%rax
ffff800000107e25:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e28:	73 07                	jae    ffff800000107e31 <fetchint+0x50>
    return -1;
ffff800000107e2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e2f:	eb 11                	jmp    ffff800000107e42 <fetchint+0x61>
  *ip = *(int*)(addr);
ffff800000107e31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e35:	8b 10                	mov    (%rax),%edx
ffff800000107e37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e3b:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000107e3d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e42:	c9                   	leave
ffff800000107e43:	c3                   	ret

ffff800000107e44 <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff800000107e44:	55                   	push   %rbp
ffff800000107e45:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e48:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107e4c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107e50:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff800000107e54:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107e5b:	00 
ffff800000107e5c:	76 2f                	jbe    ffff800000107e8d <fetchaddr+0x49>
ffff800000107e5e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e65:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e69:	48 8b 00             	mov    (%rax),%rax
ffff800000107e6c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107e70:	73 1b                	jae    ffff800000107e8d <fetchaddr+0x49>
ffff800000107e72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e76:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107e7a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e81:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e85:	48 8b 00             	mov    (%rax),%rax
ffff800000107e88:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e8b:	73 07                	jae    ffff800000107e94 <fetchaddr+0x50>
    return -1;
ffff800000107e8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e92:	eb 13                	jmp    ffff800000107ea7 <fetchaddr+0x63>
  *ip = *(addr_t*)(addr);
ffff800000107e94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e98:	48 8b 10             	mov    (%rax),%rdx
ffff800000107e9b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e9f:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000107ea2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107ea7:	c9                   	leave
ffff800000107ea8:	c3                   	ret

ffff800000107ea9 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff800000107ea9:	55                   	push   %rbp
ffff800000107eaa:	48 89 e5             	mov    %rsp,%rbp
ffff800000107ead:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107eb1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107eb5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff800000107eb9:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff800000107ec0:	00 
ffff800000107ec1:	76 14                	jbe    ffff800000107ed7 <fetchstr+0x2e>
ffff800000107ec3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107eca:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ece:	48 8b 00             	mov    (%rax),%rax
ffff800000107ed1:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107ed5:	72 07                	jb     ffff800000107ede <fetchstr+0x35>
    return -1;
ffff800000107ed7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107edc:	eb 5b                	jmp    ffff800000107f39 <fetchstr+0x90>
  *pp = (char*)addr;
ffff800000107ede:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107ee2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107ee6:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff800000107ee9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ef0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ef4:	48 8b 00             	mov    (%rax),%rax
ffff800000107ef7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff800000107efb:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107eff:	48 8b 00             	mov    (%rax),%rax
ffff800000107f02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107f06:	eb 22                	jmp    ffff800000107f2a <fetchstr+0x81>
    if(*s == 0)
ffff800000107f08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f0c:	0f b6 00             	movzbl (%rax),%eax
ffff800000107f0f:	84 c0                	test   %al,%al
ffff800000107f11:	75 12                	jne    ffff800000107f25 <fetchstr+0x7c>
      return s - *pp;
ffff800000107f13:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107f17:	48 8b 00             	mov    (%rax),%rax
ffff800000107f1a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107f1e:	48 29 c2             	sub    %rax,%rdx
ffff800000107f21:	89 d0                	mov    %edx,%eax
ffff800000107f23:	eb 14                	jmp    ffff800000107f39 <fetchstr+0x90>
  for(s = *pp; s < ep; s++)
ffff800000107f25:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107f2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f2e:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107f32:	72 d4                	jb     ffff800000107f08 <fetchstr+0x5f>
  return -1;
ffff800000107f34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107f39:	c9                   	leave
ffff800000107f3a:	c3                   	ret

ffff800000107f3b <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff800000107f3b:	55                   	push   %rbp
ffff800000107f3c:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f3f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107f43:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff800000107f46:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f4a:	0f 84 bb 00 00 00    	je     ffff80000010800b <fetcharg+0xd0>
ffff800000107f50:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f54:	0f 8f c6 00 00 00    	jg     ffff800000108020 <fetcharg+0xe5>
ffff800000107f5a:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107f5e:	0f 84 92 00 00 00    	je     ffff800000107ff6 <fetcharg+0xbb>
ffff800000107f64:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107f68:	0f 8f b2 00 00 00    	jg     ffff800000108020 <fetcharg+0xe5>
ffff800000107f6e:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107f72:	74 6d                	je     ffff800000107fe1 <fetcharg+0xa6>
ffff800000107f74:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107f78:	0f 8f a2 00 00 00    	jg     ffff800000108020 <fetcharg+0xe5>
ffff800000107f7e:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107f82:	74 48                	je     ffff800000107fcc <fetcharg+0x91>
ffff800000107f84:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107f88:	0f 8f 92 00 00 00    	jg     ffff800000108020 <fetcharg+0xe5>
ffff800000107f8e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000107f92:	74 0b                	je     ffff800000107f9f <fetcharg+0x64>
ffff800000107f94:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000107f98:	74 1d                	je     ffff800000107fb7 <fetcharg+0x7c>
ffff800000107f9a:	e9 81 00 00 00       	jmp    ffff800000108020 <fetcharg+0xe5>
  case 0: return proc->tf->rdi;
ffff800000107f9f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fa6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107faa:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fae:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107fb2:	e9 82 00 00 00       	jmp    ffff800000108039 <fetcharg+0xfe>
  case 1: return proc->tf->rsi;
ffff800000107fb7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fbe:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fc2:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fc6:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fca:	eb 6d                	jmp    ffff800000108039 <fetcharg+0xfe>
  case 2: return proc->tf->rdx;
ffff800000107fcc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fd3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fd7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fdb:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000107fdf:	eb 58                	jmp    ffff800000108039 <fetcharg+0xfe>
  case 3: return proc->tf->r10;
ffff800000107fe1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fe8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fec:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107ff0:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff800000107ff4:	eb 43                	jmp    ffff800000108039 <fetcharg+0xfe>
  case 4: return proc->tf->r8;
ffff800000107ff6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ffd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108001:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108005:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000108009:	eb 2e                	jmp    ffff800000108039 <fetcharg+0xfe>
  case 5: return proc->tf->r9;
ffff80000010800b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108012:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108016:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010801a:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff80000010801e:	eb 19                	jmp    ffff800000108039 <fetcharg+0xfe>
  }
  panic("failed fetch");
ffff800000108020:	48 b8 58 cc 10 00 00 	movabs $0xffff80000010cc58,%rax
ffff800000108027:	80 ff ff 
ffff80000010802a:	48 89 c7             	mov    %rax,%rdi
ffff80000010802d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108034:	80 ff ff 
ffff800000108037:	ff d0                	call   *%rax
}
ffff800000108039:	c9                   	leave
ffff80000010803a:	c3                   	ret

ffff80000010803b <argint>:

int
argint(int n, int *ip)
{
ffff80000010803b:	55                   	push   %rbp
ffff80000010803c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010803f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108043:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108046:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff80000010804a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010804d:	89 c7                	mov    %eax,%edi
ffff80000010804f:	48 b8 3b 7f 10 00 00 	movabs $0xffff800000107f3b,%rax
ffff800000108056:	80 ff ff 
ffff800000108059:	ff d0                	call   *%rax
ffff80000010805b:	89 c2                	mov    %eax,%edx
ffff80000010805d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108061:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000108063:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108068:	c9                   	leave
ffff800000108069:	c3                   	ret

ffff80000010806a <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff80000010806a:	55                   	push   %rbp
ffff80000010806b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010806e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108072:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108075:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000108079:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010807c:	89 c7                	mov    %eax,%edi
ffff80000010807e:	48 b8 3b 7f 10 00 00 	movabs $0xffff800000107f3b,%rax
ffff800000108085:	80 ff ff 
ffff800000108088:	ff d0                	call   *%rax
ffff80000010808a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010808e:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff800000108091:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108096:	c9                   	leave
ffff800000108097:	c3                   	ret

ffff800000108098 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff800000108098:	55                   	push   %rbp
ffff800000108099:	48 89 e5             	mov    %rsp,%rbp
ffff80000010809c:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001080a0:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001080a3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001080a7:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff8000001080aa:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff8000001080ae:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001080b1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001080b4:	89 c7                	mov    %eax,%edi
ffff8000001080b6:	48 b8 6a 80 10 00 00 	movabs $0xffff80000010806a,%rax
ffff8000001080bd:	80 ff ff 
ffff8000001080c0:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff8000001080c2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff8000001080c6:	78 39                	js     ffff800000108101 <argptr+0x69>
ffff8000001080c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080cc:	89 c2                	mov    %eax,%edx
ffff8000001080ce:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080d5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080d9:	48 8b 00             	mov    (%rax),%rax
ffff8000001080dc:	48 39 c2             	cmp    %rax,%rdx
ffff8000001080df:	73 20                	jae    ffff800000108101 <argptr+0x69>
ffff8000001080e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080e5:	89 c2                	mov    %eax,%edx
ffff8000001080e7:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001080ea:	01 d0                	add    %edx,%eax
ffff8000001080ec:	89 c2                	mov    %eax,%edx
ffff8000001080ee:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080f5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080f9:	48 8b 00             	mov    (%rax),%rax
ffff8000001080fc:	48 39 d0             	cmp    %rdx,%rax
ffff8000001080ff:	73 09                	jae    ffff80000010810a <argptr+0x72>
    return -1;
ffff800000108101:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000108108:	eb 13                	jmp    ffff80000010811d <argptr+0x85>
  *pp = (char*)i;
ffff80000010810a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010810e:	48 89 c2             	mov    %rax,%rdx
ffff800000108111:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108115:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000108118:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010811d:	c9                   	leave
ffff80000010811e:	c3                   	ret

ffff80000010811f <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff80000010811f:	55                   	push   %rbp
ffff800000108120:	48 89 e5             	mov    %rsp,%rbp
ffff800000108123:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108127:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010812a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff80000010812e:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff800000108132:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108135:	48 89 d6             	mov    %rdx,%rsi
ffff800000108138:	89 c7                	mov    %eax,%edi
ffff80000010813a:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff800000108141:	80 ff ff 
ffff800000108144:	ff d0                	call   *%rax
ffff800000108146:	85 c0                	test   %eax,%eax
ffff800000108148:	79 07                	jns    ffff800000108151 <argstr+0x32>
    return -1;
ffff80000010814a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010814f:	eb 1b                	jmp    ffff80000010816c <argstr+0x4d>
  return fetchstr(addr, pp);
ffff800000108151:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108154:	48 98                	cltq
ffff800000108156:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010815a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010815d:	48 89 c7             	mov    %rax,%rdi
ffff800000108160:	48 b8 a9 7e 10 00 00 	movabs $0xffff800000107ea9,%rax
ffff800000108167:	80 ff ff 
ffff80000010816a:	ff d0                	call   *%rax
}
ffff80000010816c:	c9                   	leave
ffff80000010816d:	c3                   	ret

ffff80000010816e <syscall>:
[SYS_mmap]    sys_mmap,
};

void
syscall(struct trapframe *tf)
{
ffff80000010816e:	55                   	push   %rbp
ffff80000010816f:	48 89 e5             	mov    %rsp,%rbp
ffff800000108172:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108176:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  proc->tf = tf;
ffff80000010817a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108181:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108185:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108189:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff80000010818d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108194:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108198:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010819c:	48 8b 00             	mov    (%rax),%rax
ffff80000010819f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff8000001081a3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001081a8:	74 3b                	je     ffff8000001081e5 <syscall+0x77>
ffff8000001081aa:	48 83 7d f8 16       	cmpq   $0x16,-0x8(%rbp)
ffff8000001081af:	77 34                	ja     ffff8000001081e5 <syscall+0x77>
ffff8000001081b1:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001081b8:	80 ff ff 
ffff8000001081bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081bf:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001081c3:	48 85 c0             	test   %rax,%rax
ffff8000001081c6:	74 1d                	je     ffff8000001081e5 <syscall+0x77>
    tf->rax = syscalls[num]();
ffff8000001081c8:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001081cf:	80 ff ff 
ffff8000001081d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081d6:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001081da:	ff d0                	call   *%rax
ffff8000001081dc:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001081e0:	48 89 02             	mov    %rax,(%rdx)
ffff8000001081e3:	eb 53                	jmp    ffff800000108238 <syscall+0xca>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff8000001081e5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001081ec:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001081f0:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff8000001081f7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001081fe:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff800000108202:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000108205:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108209:	48 bf 65 cc 10 00 00 	movabs $0xffff80000010cc65,%rdi
ffff800000108210:	80 ff ff 
ffff800000108213:	48 89 d1             	mov    %rdx,%rcx
ffff800000108216:	48 89 f2             	mov    %rsi,%rdx
ffff800000108219:	89 c6                	mov    %eax,%esi
ffff80000010821b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108220:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000108227:	80 ff ff 
ffff80000010822a:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff80000010822d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108231:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
  if (proc->killed)
ffff800000108238:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010823f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108243:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000108246:	85 c0                	test   %eax,%eax
ffff800000108248:	74 0c                	je     ffff800000108256 <syscall+0xe8>
    exit();
ffff80000010824a:	48 b8 58 69 10 00 00 	movabs $0xffff800000106958,%rax
ffff800000108251:	80 ff ff 
ffff800000108254:	ff d0                	call   *%rax
}
ffff800000108256:	90                   	nop
ffff800000108257:	c9                   	leave
ffff800000108258:	c3                   	ret

ffff800000108259 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffff800000108259:	55                   	push   %rbp
ffff80000010825a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010825d:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108261:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108264:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108268:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffff80000010826c:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff800000108270:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108273:	48 89 d6             	mov    %rdx,%rsi
ffff800000108276:	89 c7                	mov    %eax,%edi
ffff800000108278:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff80000010827f:	80 ff ff 
ffff800000108282:	ff d0                	call   *%rax
ffff800000108284:	85 c0                	test   %eax,%eax
ffff800000108286:	79 07                	jns    ffff80000010828f <argfd+0x36>
    return -1;
ffff800000108288:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010828d:	eb 62                	jmp    ffff8000001082f1 <argfd+0x98>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffff80000010828f:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108292:	85 c0                	test   %eax,%eax
ffff800000108294:	78 2d                	js     ffff8000001082c3 <argfd+0x6a>
ffff800000108296:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108299:	83 f8 0f             	cmp    $0xf,%eax
ffff80000010829c:	7f 25                	jg     ffff8000001082c3 <argfd+0x6a>
ffff80000010829e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082a5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082a9:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001082ac:	48 63 d2             	movslq %edx,%rdx
ffff8000001082af:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001082b3:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001082b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001082bc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001082c1:	75 07                	jne    ffff8000001082ca <argfd+0x71>
    return -1;
ffff8000001082c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001082c8:	eb 27                	jmp    ffff8000001082f1 <argfd+0x98>
  if(pfd)
ffff8000001082ca:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff8000001082cf:	74 09                	je     ffff8000001082da <argfd+0x81>
    *pfd = fd;
ffff8000001082d1:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001082d4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001082d8:	89 10                	mov    %edx,(%rax)
  if(pf)
ffff8000001082da:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001082df:	74 0b                	je     ffff8000001082ec <argfd+0x93>
    *pf = f;
ffff8000001082e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001082e5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001082e9:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff8000001082ec:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001082f1:	c9                   	leave
ffff8000001082f2:	c3                   	ret

ffff8000001082f3 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffff8000001082f3:	55                   	push   %rbp
ffff8000001082f4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001082f7:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001082fb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffff8000001082ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000108306:	eb 46                	jmp    ffff80000010834e <fdalloc+0x5b>
    if(proc->ofile[fd] == 0){
ffff800000108308:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010830f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108313:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108316:	48 63 d2             	movslq %edx,%rdx
ffff800000108319:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010831d:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000108322:	48 85 c0             	test   %rax,%rax
ffff800000108325:	75 23                	jne    ffff80000010834a <fdalloc+0x57>
      proc->ofile[fd] = f;
ffff800000108327:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010832e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108332:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108335:	48 63 d2             	movslq %edx,%rdx
ffff800000108338:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff80000010833c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108340:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffff800000108345:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108348:	eb 0f                	jmp    ffff800000108359 <fdalloc+0x66>
  for(fd = 0; fd < NOFILE; fd++){
ffff80000010834a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010834e:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff800000108352:	7e b4                	jle    ffff800000108308 <fdalloc+0x15>
    }
  }
  return -1;
ffff800000108354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108359:	c9                   	leave
ffff80000010835a:	c3                   	ret

ffff80000010835b <sys_dup>:

int
sys_dup(void)
{
ffff80000010835b:	55                   	push   %rbp
ffff80000010835c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010835f:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
ffff800000108363:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108367:	48 89 c2             	mov    %rax,%rdx
ffff80000010836a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010836f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108374:	48 b8 59 82 10 00 00 	movabs $0xffff800000108259,%rax
ffff80000010837b:	80 ff ff 
ffff80000010837e:	ff d0                	call   *%rax
ffff800000108380:	85 c0                	test   %eax,%eax
ffff800000108382:	79 07                	jns    ffff80000010838b <sys_dup+0x30>
    return -1;
ffff800000108384:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108389:	eb 39                	jmp    ffff8000001083c4 <sys_dup+0x69>
  if((fd=fdalloc(f)) < 0)
ffff80000010838b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010838f:	48 89 c7             	mov    %rax,%rdi
ffff800000108392:	48 b8 f3 82 10 00 00 	movabs $0xffff8000001082f3,%rax
ffff800000108399:	80 ff ff 
ffff80000010839c:	ff d0                	call   *%rax
ffff80000010839e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001083a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001083a5:	79 07                	jns    ffff8000001083ae <sys_dup+0x53>
    return -1;
ffff8000001083a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001083ac:	eb 16                	jmp    ffff8000001083c4 <sys_dup+0x69>
  filedup(f);
ffff8000001083ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001083b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001083b5:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff8000001083bc:	80 ff ff 
ffff8000001083bf:	ff d0                	call   *%rax
  return fd;
ffff8000001083c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001083c4:	c9                   	leave
ffff8000001083c5:	c3                   	ret

ffff8000001083c6 <sys_read>:

int
sys_read(void)
{
ffff8000001083c6:	55                   	push   %rbp
ffff8000001083c7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001083ca:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff8000001083ce:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001083d2:	48 89 c2             	mov    %rax,%rdx
ffff8000001083d5:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001083da:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001083df:	48 b8 59 82 10 00 00 	movabs $0xffff800000108259,%rax
ffff8000001083e6:	80 ff ff 
ffff8000001083e9:	ff d0                	call   *%rax
ffff8000001083eb:	85 c0                	test   %eax,%eax
ffff8000001083ed:	78 56                	js     ffff800000108445 <sys_read+0x7f>
ffff8000001083ef:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff8000001083f3:	48 89 c6             	mov    %rax,%rsi
ffff8000001083f6:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001083fb:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff800000108402:	80 ff ff 
ffff800000108405:	ff d0                	call   *%rax
ffff800000108407:	85 c0                	test   %eax,%eax
ffff800000108409:	78 3a                	js     ffff800000108445 <sys_read+0x7f>
ffff80000010840b:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010840e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000108412:	48 89 c6             	mov    %rax,%rsi
ffff800000108415:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010841a:	48 b8 98 80 10 00 00 	movabs $0xffff800000108098,%rax
ffff800000108421:	80 ff ff 
ffff800000108424:	ff d0                	call   *%rax
    return -1;
  return fileread(f, p, n);
ffff800000108426:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108429:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff80000010842d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108431:	48 89 ce             	mov    %rcx,%rsi
ffff800000108434:	48 89 c7             	mov    %rax,%rdi
ffff800000108437:	48 b8 0f 1e 10 00 00 	movabs $0xffff800000101e0f,%rax
ffff80000010843e:	80 ff ff 
ffff800000108441:	ff d0                	call   *%rax
ffff800000108443:	eb 05                	jmp    ffff80000010844a <sys_read+0x84>
    return -1;
ffff800000108445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010844a:	c9                   	leave
ffff80000010844b:	c3                   	ret

ffff80000010844c <sys_write>:

int
sys_write(void)
{
ffff80000010844c:	55                   	push   %rbp
ffff80000010844d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108450:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff800000108454:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108458:	48 89 c2             	mov    %rax,%rdx
ffff80000010845b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108460:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108465:	48 b8 59 82 10 00 00 	movabs $0xffff800000108259,%rax
ffff80000010846c:	80 ff ff 
ffff80000010846f:	ff d0                	call   *%rax
ffff800000108471:	85 c0                	test   %eax,%eax
ffff800000108473:	78 56                	js     ffff8000001084cb <sys_write+0x7f>
ffff800000108475:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff800000108479:	48 89 c6             	mov    %rax,%rsi
ffff80000010847c:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108481:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff800000108488:	80 ff ff 
ffff80000010848b:	ff d0                	call   *%rax
ffff80000010848d:	85 c0                	test   %eax,%eax
ffff80000010848f:	78 3a                	js     ffff8000001084cb <sys_write+0x7f>
ffff800000108491:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108494:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000108498:	48 89 c6             	mov    %rax,%rsi
ffff80000010849b:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001084a0:	48 b8 98 80 10 00 00 	movabs $0xffff800000108098,%rax
ffff8000001084a7:	80 ff ff 
ffff8000001084aa:	ff d0                	call   *%rax
    return -1;
  return filewrite(f, p, n);
ffff8000001084ac:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001084af:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001084b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084b7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001084ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001084bd:	48 b8 03 1f 10 00 00 	movabs $0xffff800000101f03,%rax
ffff8000001084c4:	80 ff ff 
ffff8000001084c7:	ff d0                	call   *%rax
ffff8000001084c9:	eb 05                	jmp    ffff8000001084d0 <sys_write+0x84>
    return -1;
ffff8000001084cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001084d0:	c9                   	leave
ffff8000001084d1:	c3                   	ret

ffff8000001084d2 <sys_close>:

int
sys_close(void)
{
ffff8000001084d2:	55                   	push   %rbp
ffff8000001084d3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001084d6:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
ffff8000001084da:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff8000001084de:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff8000001084e2:	48 89 c6             	mov    %rax,%rsi
ffff8000001084e5:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001084ea:	48 b8 59 82 10 00 00 	movabs $0xffff800000108259,%rax
ffff8000001084f1:	80 ff ff 
ffff8000001084f4:	ff d0                	call   *%rax
ffff8000001084f6:	85 c0                	test   %eax,%eax
ffff8000001084f8:	79 07                	jns    ffff800000108501 <sys_close+0x2f>
    return -1;
ffff8000001084fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001084ff:	eb 36                	jmp    ffff800000108537 <sys_close+0x65>
  proc->ofile[fd] = 0;
ffff800000108501:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108508:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010850c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010850f:	48 63 d2             	movslq %edx,%rdx
ffff800000108512:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108516:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff80000010851d:	00 00 
  fileclose(f);
ffff80000010851f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108523:	48 89 c7             	mov    %rax,%rdi
ffff800000108526:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff80000010852d:	80 ff ff 
ffff800000108530:	ff d0                	call   *%rax
  return 0;
ffff800000108532:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108537:	c9                   	leave
ffff800000108538:	c3                   	ret

ffff800000108539 <sys_fstat>:

int
sys_fstat(void)
{
ffff800000108539:	55                   	push   %rbp
ffff80000010853a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010853d:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffff800000108541:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108545:	48 89 c2             	mov    %rax,%rdx
ffff800000108548:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010854d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108552:	48 b8 59 82 10 00 00 	movabs $0xffff800000108259,%rax
ffff800000108559:	80 ff ff 
ffff80000010855c:	ff d0                	call   *%rax
ffff80000010855e:	85 c0                	test   %eax,%eax
ffff800000108560:	78 39                	js     ffff80000010859b <sys_fstat+0x62>
ffff800000108562:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108566:	ba 14 00 00 00       	mov    $0x14,%edx
ffff80000010856b:	48 89 c6             	mov    %rax,%rsi
ffff80000010856e:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108573:	48 b8 98 80 10 00 00 	movabs $0xffff800000108098,%rax
ffff80000010857a:	80 ff ff 
ffff80000010857d:	ff d0                	call   *%rax
    return -1;
  return filestat(f, st);
ffff80000010857f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108583:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108587:	48 89 d6             	mov    %rdx,%rsi
ffff80000010858a:	48 89 c7             	mov    %rax,%rdi
ffff80000010858d:	48 b8 9a 1d 10 00 00 	movabs $0xffff800000101d9a,%rax
ffff800000108594:	80 ff ff 
ffff800000108597:	ff d0                	call   *%rax
ffff800000108599:	eb 05                	jmp    ffff8000001085a0 <sys_fstat+0x67>
    return -1;
ffff80000010859b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001085a0:	c9                   	leave
ffff8000001085a1:	c3                   	ret

ffff8000001085a2 <isdirempty>:

static int
isdirempty(struct inode *dp)
{
ffff8000001085a2:	55                   	push   %rbp
ffff8000001085a3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001085a6:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001085aa:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff8000001085ae:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff8000001085b5:	eb 56                	jmp    ffff80000010860d <isdirempty+0x6b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001085b7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001085ba:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff8000001085be:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001085c2:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff8000001085c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001085ca:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff8000001085d1:	80 ff ff 
ffff8000001085d4:	ff d0                	call   *%rax
ffff8000001085d6:	83 f8 10             	cmp    $0x10,%eax
ffff8000001085d9:	74 19                	je     ffff8000001085f4 <isdirempty+0x52>
      panic("isdirempty: readi");
ffff8000001085db:	48 b8 81 cc 10 00 00 	movabs $0xffff80000010cc81,%rax
ffff8000001085e2:	80 ff ff 
ffff8000001085e5:	48 89 c7             	mov    %rax,%rdi
ffff8000001085e8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001085ef:	80 ff ff 
ffff8000001085f2:	ff d0                	call   *%rax
    if(de.inum != 0)
ffff8000001085f4:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001085f8:	66 85 c0             	test   %ax,%ax
ffff8000001085fb:	74 07                	je     ffff800000108604 <isdirempty+0x62>
      return 0;
ffff8000001085fd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108602:	eb 1f                	jmp    ffff800000108623 <isdirempty+0x81>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000108604:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108607:	83 c0 10             	add    $0x10,%eax
ffff80000010860a:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010860d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108611:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000108617:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010861a:	39 c2                	cmp    %eax,%edx
ffff80000010861c:	72 99                	jb     ffff8000001085b7 <isdirempty+0x15>
  }
  return 1;
ffff80000010861e:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffff800000108623:	c9                   	leave
ffff800000108624:	c3                   	ret

ffff800000108625 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffff800000108625:	55                   	push   %rbp
ffff800000108626:	48 89 e5             	mov    %rsp,%rbp
ffff800000108629:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffff80000010862d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000108631:	48 89 c6             	mov    %rax,%rsi
ffff800000108634:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108639:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff800000108640:	80 ff ff 
ffff800000108643:	ff d0                	call   *%rax
ffff800000108645:	85 c0                	test   %eax,%eax
ffff800000108647:	78 1c                	js     ffff800000108665 <sys_link+0x40>
ffff800000108649:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff80000010864d:	48 89 c6             	mov    %rax,%rsi
ffff800000108650:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108655:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff80000010865c:	80 ff ff 
ffff80000010865f:	ff d0                	call   *%rax
ffff800000108661:	85 c0                	test   %eax,%eax
ffff800000108663:	79 0a                	jns    ffff80000010866f <sys_link+0x4a>
    return -1;
ffff800000108665:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010866a:	e9 f3 01 00 00       	jmp    ffff800000108862 <sys_link+0x23d>

  begin_op();
ffff80000010866f:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000108676:	80 ff ff 
ffff800000108679:	ff d0                	call   *%rax
  if((ip = namei(old)) == 0){
ffff80000010867b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010867f:	48 89 c7             	mov    %rax,%rdi
ffff800000108682:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000108689:	80 ff ff 
ffff80000010868c:	ff d0                	call   *%rax
ffff80000010868e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108692:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108697:	75 16                	jne    ffff8000001086af <sys_link+0x8a>
    end_op();
ffff800000108699:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001086a0:	80 ff ff 
ffff8000001086a3:	ff d0                	call   *%rax
    return -1;
ffff8000001086a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086aa:	e9 b3 01 00 00       	jmp    ffff800000108862 <sys_link+0x23d>
  }

  ilock(ip);
ffff8000001086af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001086b3:	48 89 c7             	mov    %rax,%rdi
ffff8000001086b6:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001086bd:	80 ff ff 
ffff8000001086c0:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff8000001086c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001086c6:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001086cd:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001086d1:	75 29                	jne    ffff8000001086fc <sys_link+0xd7>
    iunlockput(ip);
ffff8000001086d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001086d7:	48 89 c7             	mov    %rax,%rdi
ffff8000001086da:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001086e1:	80 ff ff 
ffff8000001086e4:	ff d0                	call   *%rax
    end_op();
ffff8000001086e6:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001086ed:	80 ff ff 
ffff8000001086f0:	ff d0                	call   *%rax
    return -1;
ffff8000001086f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086f7:	e9 66 01 00 00       	jmp    ffff800000108862 <sys_link+0x23d>
  }

  ip->nlink++;
ffff8000001086fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108700:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108707:	83 c0 01             	add    $0x1,%eax
ffff80000010870a:	89 c2                	mov    %eax,%edx
ffff80000010870c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108710:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108717:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010871b:	48 89 c7             	mov    %rax,%rdi
ffff80000010871e:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108725:	80 ff ff 
ffff800000108728:	ff d0                	call   *%rax
  iunlock(ip);
ffff80000010872a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010872e:	48 89 c7             	mov    %rax,%rdi
ffff800000108731:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000108738:	80 ff ff 
ffff80000010873b:	ff d0                	call   *%rax

  if((dp = nameiparent(new, name)) == 0)
ffff80000010873d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108741:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff800000108745:	48 89 d6             	mov    %rdx,%rsi
ffff800000108748:	48 89 c7             	mov    %rax,%rdi
ffff80000010874b:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108752:	80 ff ff 
ffff800000108755:	ff d0                	call   *%rax
ffff800000108757:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010875b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108760:	0f 84 96 00 00 00    	je     ffff8000001087fc <sys_link+0x1d7>
    goto bad;
  ilock(dp);
ffff800000108766:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010876a:	48 89 c7             	mov    %rax,%rdi
ffff80000010876d:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108774:	80 ff ff 
ffff800000108777:	ff d0                	call   *%rax
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffff800000108779:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010877d:	8b 10                	mov    (%rax),%edx
ffff80000010877f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108783:	8b 00                	mov    (%rax),%eax
ffff800000108785:	39 c2                	cmp    %eax,%edx
ffff800000108787:	75 25                	jne    ffff8000001087ae <sys_link+0x189>
ffff800000108789:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010878d:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108790:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff800000108794:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108798:	48 89 ce             	mov    %rcx,%rsi
ffff80000010879b:	48 89 c7             	mov    %rax,%rdi
ffff80000010879e:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff8000001087a5:	80 ff ff 
ffff8000001087a8:	ff d0                	call   *%rax
ffff8000001087aa:	85 c0                	test   %eax,%eax
ffff8000001087ac:	79 15                	jns    ffff8000001087c3 <sys_link+0x19e>
    iunlockput(dp);
ffff8000001087ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001087b5:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001087bc:	80 ff ff 
ffff8000001087bf:	ff d0                	call   *%rax
    goto bad;
ffff8000001087c1:	eb 3a                	jmp    ffff8000001087fd <sys_link+0x1d8>
  }
  iunlockput(dp);
ffff8000001087c3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001087ca:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001087d1:	80 ff ff 
ffff8000001087d4:	ff d0                	call   *%rax
  iput(ip);
ffff8000001087d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087da:	48 89 c7             	mov    %rax,%rdi
ffff8000001087dd:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff8000001087e4:	80 ff ff 
ffff8000001087e7:	ff d0                	call   *%rax

  end_op();
ffff8000001087e9:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001087f0:	80 ff ff 
ffff8000001087f3:	ff d0                	call   *%rax

  return 0;
ffff8000001087f5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001087fa:	eb 66                	jmp    ffff800000108862 <sys_link+0x23d>
    goto bad;
ffff8000001087fc:	90                   	nop

bad:
  ilock(ip);
ffff8000001087fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108801:	48 89 c7             	mov    %rax,%rdi
ffff800000108804:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010880b:	80 ff ff 
ffff80000010880e:	ff d0                	call   *%rax
  ip->nlink--;
ffff800000108810:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108814:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010881b:	83 e8 01             	sub    $0x1,%eax
ffff80000010881e:	89 c2                	mov    %eax,%edx
ffff800000108820:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108824:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff80000010882b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010882f:	48 89 c7             	mov    %rax,%rdi
ffff800000108832:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108839:	80 ff ff 
ffff80000010883c:	ff d0                	call   *%rax
  iunlockput(ip);
ffff80000010883e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108842:	48 89 c7             	mov    %rax,%rdi
ffff800000108845:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff80000010884c:	80 ff ff 
ffff80000010884f:	ff d0                	call   *%rax
  end_op();
ffff800000108851:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108858:	80 ff ff 
ffff80000010885b:	ff d0                	call   *%rax
  return -1;
ffff80000010885d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108862:	c9                   	leave
ffff800000108863:	c3                   	ret

ffff800000108864 <sys_unlink>:
//PAGEBREAK!

int
sys_unlink(void)
{
ffff800000108864:	55                   	push   %rbp
ffff800000108865:	48 89 e5             	mov    %rsp,%rbp
ffff800000108868:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffff80000010886c:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff800000108870:	48 89 c6             	mov    %rax,%rsi
ffff800000108873:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108878:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff80000010887f:	80 ff ff 
ffff800000108882:	ff d0                	call   *%rax
ffff800000108884:	85 c0                	test   %eax,%eax
ffff800000108886:	79 0a                	jns    ffff800000108892 <sys_unlink+0x2e>
    return -1;
ffff800000108888:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010888d:	e9 7b 02 00 00       	jmp    ffff800000108b0d <sys_unlink+0x2a9>

  begin_op();
ffff800000108892:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000108899:	80 ff ff 
ffff80000010889c:	ff d0                	call   *%rax
  if((dp = nameiparent(path, name)) == 0){
ffff80000010889e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001088a2:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff8000001088a6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001088a9:	48 89 c7             	mov    %rax,%rdi
ffff8000001088ac:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff8000001088b3:	80 ff ff 
ffff8000001088b6:	ff d0                	call   *%rax
ffff8000001088b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001088bc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001088c1:	75 16                	jne    ffff8000001088d9 <sys_unlink+0x75>
    end_op();
ffff8000001088c3:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001088ca:	80 ff ff 
ffff8000001088cd:	ff d0                	call   *%rax
    return -1;
ffff8000001088cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001088d4:	e9 34 02 00 00       	jmp    ffff800000108b0d <sys_unlink+0x2a9>
  }

  ilock(dp);
ffff8000001088d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001088e0:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001088e7:	80 ff ff 
ffff8000001088ea:	ff d0                	call   *%rax

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffff8000001088ec:	48 ba 93 cc 10 00 00 	movabs $0xffff80000010cc93,%rdx
ffff8000001088f3:	80 ff ff 
ffff8000001088f6:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff8000001088fa:	48 89 d6             	mov    %rdx,%rsi
ffff8000001088fd:	48 89 c7             	mov    %rax,%rdi
ffff800000108900:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff800000108907:	80 ff ff 
ffff80000010890a:	ff d0                	call   *%rax
ffff80000010890c:	85 c0                	test   %eax,%eax
ffff80000010890e:	0f 84 d1 01 00 00    	je     ffff800000108ae5 <sys_unlink+0x281>
ffff800000108914:	48 ba 95 cc 10 00 00 	movabs $0xffff80000010cc95,%rdx
ffff80000010891b:	80 ff ff 
ffff80000010891e:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000108922:	48 89 d6             	mov    %rdx,%rsi
ffff800000108925:	48 89 c7             	mov    %rax,%rdi
ffff800000108928:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff80000010892f:	80 ff ff 
ffff800000108932:	ff d0                	call   *%rax
ffff800000108934:	85 c0                	test   %eax,%eax
ffff800000108936:	0f 84 a9 01 00 00    	je     ffff800000108ae5 <sys_unlink+0x281>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffff80000010893c:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff800000108940:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff800000108944:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108948:	48 89 ce             	mov    %rcx,%rsi
ffff80000010894b:	48 89 c7             	mov    %rax,%rdi
ffff80000010894e:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff800000108955:	80 ff ff 
ffff800000108958:	ff d0                	call   *%rax
ffff80000010895a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010895e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108963:	0f 84 7f 01 00 00    	je     ffff800000108ae8 <sys_unlink+0x284>
    goto bad;
  ilock(ip);
ffff800000108969:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010896d:	48 89 c7             	mov    %rax,%rdi
ffff800000108970:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108977:	80 ff ff 
ffff80000010897a:	ff d0                	call   *%rax

  if(ip->nlink < 1)
ffff80000010897c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108980:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108987:	66 85 c0             	test   %ax,%ax
ffff80000010898a:	7f 19                	jg     ffff8000001089a5 <sys_unlink+0x141>
    panic("unlink: nlink < 1");
ffff80000010898c:	48 b8 98 cc 10 00 00 	movabs $0xffff80000010cc98,%rax
ffff800000108993:	80 ff ff 
ffff800000108996:	48 89 c7             	mov    %rax,%rdi
ffff800000108999:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001089a0:	80 ff ff 
ffff8000001089a3:	ff d0                	call   *%rax
  if(ip->type == T_DIR && !isdirempty(ip)){
ffff8000001089a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089a9:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001089b0:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001089b4:	75 2f                	jne    ffff8000001089e5 <sys_unlink+0x181>
ffff8000001089b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001089bd:	48 b8 a2 85 10 00 00 	movabs $0xffff8000001085a2,%rax
ffff8000001089c4:	80 ff ff 
ffff8000001089c7:	ff d0                	call   *%rax
ffff8000001089c9:	85 c0                	test   %eax,%eax
ffff8000001089cb:	75 18                	jne    ffff8000001089e5 <sys_unlink+0x181>
    iunlockput(ip);
ffff8000001089cd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001089d4:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001089db:	80 ff ff 
ffff8000001089de:	ff d0                	call   *%rax
    goto bad;
ffff8000001089e0:	e9 04 01 00 00       	jmp    ffff800000108ae9 <sys_unlink+0x285>
  }

  memset(&de, 0, sizeof(de));
ffff8000001089e5:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff8000001089e9:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001089ee:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001089f3:	48 89 c7             	mov    %rax,%rdi
ffff8000001089f6:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff8000001089fd:	80 ff ff 
ffff800000108a00:	ff d0                	call   *%rax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000108a02:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000108a05:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108a09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a0d:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000108a12:	48 89 c7             	mov    %rax,%rdi
ffff800000108a15:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff800000108a1c:	80 ff ff 
ffff800000108a1f:	ff d0                	call   *%rax
ffff800000108a21:	83 f8 10             	cmp    $0x10,%eax
ffff800000108a24:	74 19                	je     ffff800000108a3f <sys_unlink+0x1db>
    panic("unlink: writei");
ffff800000108a26:	48 b8 aa cc 10 00 00 	movabs $0xffff80000010ccaa,%rax
ffff800000108a2d:	80 ff ff 
ffff800000108a30:	48 89 c7             	mov    %rax,%rdi
ffff800000108a33:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108a3a:	80 ff ff 
ffff800000108a3d:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108a3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a43:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108a4a:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108a4e:	75 2e                	jne    ffff800000108a7e <sys_unlink+0x21a>
    dp->nlink--;
ffff800000108a50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a54:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108a5b:	83 e8 01             	sub    $0x1,%eax
ffff800000108a5e:	89 c2                	mov    %eax,%edx
ffff800000108a60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a64:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108a6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a6f:	48 89 c7             	mov    %rax,%rdi
ffff800000108a72:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108a79:	80 ff ff 
ffff800000108a7c:	ff d0                	call   *%rax
  }
  iunlockput(dp);
ffff800000108a7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a82:	48 89 c7             	mov    %rax,%rdi
ffff800000108a85:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108a8c:	80 ff ff 
ffff800000108a8f:	ff d0                	call   *%rax

  ip->nlink--;
ffff800000108a91:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a95:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108a9c:	83 e8 01             	sub    $0x1,%eax
ffff800000108a9f:	89 c2                	mov    %eax,%edx
ffff800000108aa1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108aa5:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108aac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ab0:	48 89 c7             	mov    %rax,%rdi
ffff800000108ab3:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108aba:	80 ff ff 
ffff800000108abd:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108abf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ac3:	48 89 c7             	mov    %rax,%rdi
ffff800000108ac6:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108acd:	80 ff ff 
ffff800000108ad0:	ff d0                	call   *%rax

  end_op();
ffff800000108ad2:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108ad9:	80 ff ff 
ffff800000108adc:	ff d0                	call   *%rax

  return 0;
ffff800000108ade:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108ae3:	eb 28                	jmp    ffff800000108b0d <sys_unlink+0x2a9>
    goto bad;
ffff800000108ae5:	90                   	nop
ffff800000108ae6:	eb 01                	jmp    ffff800000108ae9 <sys_unlink+0x285>
    goto bad;
ffff800000108ae8:	90                   	nop

bad:
  iunlockput(dp);
ffff800000108ae9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108aed:	48 89 c7             	mov    %rax,%rdi
ffff800000108af0:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108af7:	80 ff ff 
ffff800000108afa:	ff d0                	call   *%rax
  end_op();
ffff800000108afc:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108b03:	80 ff ff 
ffff800000108b06:	ff d0                	call   *%rax
  return -1;
ffff800000108b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108b0d:	c9                   	leave
ffff800000108b0e:	c3                   	ret

ffff800000108b0f <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffff800000108b0f:	55                   	push   %rbp
ffff800000108b10:	48 89 e5             	mov    %rsp,%rbp
ffff800000108b13:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000108b17:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000108b1b:	89 c8                	mov    %ecx,%eax
ffff800000108b1d:	89 f1                	mov    %esi,%ecx
ffff800000108b1f:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff800000108b23:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff800000108b27:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffff800000108b2b:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff800000108b2f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108b33:	48 89 d6             	mov    %rdx,%rsi
ffff800000108b36:	48 89 c7             	mov    %rax,%rdi
ffff800000108b39:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108b40:	80 ff ff 
ffff800000108b43:	ff d0                	call   *%rax
ffff800000108b45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108b49:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108b4e:	75 0a                	jne    ffff800000108b5a <create+0x4b>
    return 0;
ffff800000108b50:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b55:	e9 2c 02 00 00       	jmp    ffff800000108d86 <create+0x277>
  ilock(dp);
ffff800000108b5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b5e:	48 89 c7             	mov    %rax,%rdi
ffff800000108b61:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108b68:	80 ff ff 
ffff800000108b6b:	ff d0                	call   *%rax

  if((ip = dirlookup(dp, name, &off)) != 0){
ffff800000108b6d:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff800000108b71:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108b75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b79:	48 89 ce             	mov    %rcx,%rsi
ffff800000108b7c:	48 89 c7             	mov    %rax,%rdi
ffff800000108b7f:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff800000108b86:	80 ff ff 
ffff800000108b89:	ff d0                	call   *%rax
ffff800000108b8b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108b8f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108b94:	74 64                	je     ffff800000108bfa <create+0xeb>
    iunlockput(dp);
ffff800000108b96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b9a:	48 89 c7             	mov    %rax,%rdi
ffff800000108b9d:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108ba4:	80 ff ff 
ffff800000108ba7:	ff d0                	call   *%rax
    ilock(ip);
ffff800000108ba9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108bad:	48 89 c7             	mov    %rax,%rdi
ffff800000108bb0:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108bb7:	80 ff ff 
ffff800000108bba:	ff d0                	call   *%rax
    if(type == T_FILE && ip->type == T_FILE)
ffff800000108bbc:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff800000108bc1:	75 1a                	jne    ffff800000108bdd <create+0xce>
ffff800000108bc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108bc7:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108bce:	66 83 f8 02          	cmp    $0x2,%ax
ffff800000108bd2:	75 09                	jne    ffff800000108bdd <create+0xce>
      return ip;
ffff800000108bd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108bd8:	e9 a9 01 00 00       	jmp    ffff800000108d86 <create+0x277>
    iunlockput(ip);
ffff800000108bdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108be1:	48 89 c7             	mov    %rax,%rdi
ffff800000108be4:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108beb:	80 ff ff 
ffff800000108bee:	ff d0                	call   *%rax
    return 0;
ffff800000108bf0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108bf5:	e9 8c 01 00 00       	jmp    ffff800000108d86 <create+0x277>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffff800000108bfa:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff800000108bfe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c02:	8b 00                	mov    (%rax),%eax
ffff800000108c04:	89 d6                	mov    %edx,%esi
ffff800000108c06:	89 c7                	mov    %eax,%edi
ffff800000108c08:	48 b8 c0 24 10 00 00 	movabs $0xffff8000001024c0,%rax
ffff800000108c0f:	80 ff ff 
ffff800000108c12:	ff d0                	call   *%rax
ffff800000108c14:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108c18:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108c1d:	75 19                	jne    ffff800000108c38 <create+0x129>
    panic("create: ialloc");
ffff800000108c1f:	48 b8 b9 cc 10 00 00 	movabs $0xffff80000010ccb9,%rax
ffff800000108c26:	80 ff ff 
ffff800000108c29:	48 89 c7             	mov    %rax,%rdi
ffff800000108c2c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108c33:	80 ff ff 
ffff800000108c36:	ff d0                	call   *%rax

  ilock(ip);
ffff800000108c38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c3c:	48 89 c7             	mov    %rax,%rdi
ffff800000108c3f:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108c46:	80 ff ff 
ffff800000108c49:	ff d0                	call   *%rax
  ip->major = major;
ffff800000108c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c4f:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff800000108c53:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
  ip->minor = minor;
ffff800000108c5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c5e:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff800000108c62:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
  ip->nlink = 1;
ffff800000108c69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c6d:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff800000108c74:	01 00 
  iupdate(ip);
ffff800000108c76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c7a:	48 89 c7             	mov    %rax,%rdi
ffff800000108c7d:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108c84:	80 ff ff 
ffff800000108c87:	ff d0                	call   *%rax

  if(type == T_DIR){  // Create . and .. entries.
ffff800000108c89:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff800000108c8e:	0f 85 9d 00 00 00    	jne    ffff800000108d31 <create+0x222>
    dp->nlink++;  // for ".."
ffff800000108c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c98:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108c9f:	83 c0 01             	add    $0x1,%eax
ffff800000108ca2:	89 c2                	mov    %eax,%edx
ffff800000108ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ca8:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108caf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cb3:	48 89 c7             	mov    %rax,%rdi
ffff800000108cb6:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108cbd:	80 ff ff 
ffff800000108cc0:	ff d0                	call   *%rax
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffff800000108cc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cc6:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108cc9:	48 b9 93 cc 10 00 00 	movabs $0xffff80000010cc93,%rcx
ffff800000108cd0:	80 ff ff 
ffff800000108cd3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cd7:	48 89 ce             	mov    %rcx,%rsi
ffff800000108cda:	48 89 c7             	mov    %rax,%rdi
ffff800000108cdd:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108ce4:	80 ff ff 
ffff800000108ce7:	ff d0                	call   *%rax
ffff800000108ce9:	85 c0                	test   %eax,%eax
ffff800000108ceb:	78 2b                	js     ffff800000108d18 <create+0x209>
ffff800000108ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cf1:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108cf4:	48 b9 95 cc 10 00 00 	movabs $0xffff80000010cc95,%rcx
ffff800000108cfb:	80 ff ff 
ffff800000108cfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d02:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d05:	48 89 c7             	mov    %rax,%rdi
ffff800000108d08:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108d0f:	80 ff ff 
ffff800000108d12:	ff d0                	call   *%rax
ffff800000108d14:	85 c0                	test   %eax,%eax
ffff800000108d16:	79 19                	jns    ffff800000108d31 <create+0x222>
      panic("create dots");
ffff800000108d18:	48 b8 c8 cc 10 00 00 	movabs $0xffff80000010ccc8,%rax
ffff800000108d1f:	80 ff ff 
ffff800000108d22:	48 89 c7             	mov    %rax,%rdi
ffff800000108d25:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108d2c:	80 ff ff 
ffff800000108d2f:	ff d0                	call   *%rax
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffff800000108d31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d35:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d38:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108d3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d40:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d43:	48 89 c7             	mov    %rax,%rdi
ffff800000108d46:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108d4d:	80 ff ff 
ffff800000108d50:	ff d0                	call   *%rax
ffff800000108d52:	85 c0                	test   %eax,%eax
ffff800000108d54:	79 19                	jns    ffff800000108d6f <create+0x260>
    panic("create: dirlink");
ffff800000108d56:	48 b8 d4 cc 10 00 00 	movabs $0xffff80000010ccd4,%rax
ffff800000108d5d:	80 ff ff 
ffff800000108d60:	48 89 c7             	mov    %rax,%rdi
ffff800000108d63:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108d6a:	80 ff ff 
ffff800000108d6d:	ff d0                	call   *%rax

  iunlockput(dp);
ffff800000108d6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d73:	48 89 c7             	mov    %rax,%rdi
ffff800000108d76:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108d7d:	80 ff ff 
ffff800000108d80:	ff d0                	call   *%rax

  return ip;
ffff800000108d82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000108d86:	c9                   	leave
ffff800000108d87:	c3                   	ret

ffff800000108d88 <sys_open>:

int
sys_open(void)
{
ffff800000108d88:	55                   	push   %rbp
ffff800000108d89:	48 89 e5             	mov    %rsp,%rbp
ffff800000108d8c:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffff800000108d90:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108d94:	48 89 c6             	mov    %rax,%rsi
ffff800000108d97:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108d9c:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff800000108da3:	80 ff ff 
ffff800000108da6:	ff d0                	call   *%rax
ffff800000108da8:	85 c0                	test   %eax,%eax
ffff800000108daa:	78 1c                	js     ffff800000108dc8 <sys_open+0x40>
ffff800000108dac:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000108db0:	48 89 c6             	mov    %rax,%rsi
ffff800000108db3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108db8:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff800000108dbf:	80 ff ff 
ffff800000108dc2:	ff d0                	call   *%rax
ffff800000108dc4:	85 c0                	test   %eax,%eax
ffff800000108dc6:	79 0a                	jns    ffff800000108dd2 <sys_open+0x4a>
    return -1;
ffff800000108dc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108dcd:	e9 de 01 00 00       	jmp    ffff800000108fb0 <sys_open+0x228>

  begin_op();
ffff800000108dd2:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000108dd9:	80 ff ff 
ffff800000108ddc:	ff d0                	call   *%rax

  if(omode & O_CREATE){
ffff800000108dde:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108de1:	25 00 02 00 00       	and    $0x200,%eax
ffff800000108de6:	85 c0                	test   %eax,%eax
ffff800000108de8:	74 47                	je     ffff800000108e31 <sys_open+0xa9>
    ip = create(path, T_FILE, 0, 0);
ffff800000108dea:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108dee:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108df3:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108df8:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000108dfd:	48 89 c7             	mov    %rax,%rdi
ffff800000108e00:	48 b8 0f 8b 10 00 00 	movabs $0xffff800000108b0f,%rax
ffff800000108e07:	80 ff ff 
ffff800000108e0a:	ff d0                	call   *%rax
ffff800000108e0c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(ip == 0){
ffff800000108e10:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108e15:	0f 85 9e 00 00 00    	jne    ffff800000108eb9 <sys_open+0x131>
      end_op();
ffff800000108e1b:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108e22:	80 ff ff 
ffff800000108e25:	ff d0                	call   *%rax
      return -1;
ffff800000108e27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e2c:	e9 7f 01 00 00       	jmp    ffff800000108fb0 <sys_open+0x228>
    }
  } else {
    if((ip = namei(path)) == 0){
ffff800000108e31:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108e35:	48 89 c7             	mov    %rax,%rdi
ffff800000108e38:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000108e3f:	80 ff ff 
ffff800000108e42:	ff d0                	call   *%rax
ffff800000108e44:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108e48:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108e4d:	75 16                	jne    ffff800000108e65 <sys_open+0xdd>
      end_op();
ffff800000108e4f:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108e56:	80 ff ff 
ffff800000108e59:	ff d0                	call   *%rax
      return -1;
ffff800000108e5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e60:	e9 4b 01 00 00       	jmp    ffff800000108fb0 <sys_open+0x228>
    }
    ilock(ip);
ffff800000108e65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108e69:	48 89 c7             	mov    %rax,%rdi
ffff800000108e6c:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108e73:	80 ff ff 
ffff800000108e76:	ff d0                	call   *%rax
    if(ip->type == T_DIR && omode != O_RDONLY){
ffff800000108e78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108e7c:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108e83:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108e87:	75 30                	jne    ffff800000108eb9 <sys_open+0x131>
ffff800000108e89:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108e8c:	85 c0                	test   %eax,%eax
ffff800000108e8e:	74 29                	je     ffff800000108eb9 <sys_open+0x131>
      iunlockput(ip);
ffff800000108e90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108e94:	48 89 c7             	mov    %rax,%rdi
ffff800000108e97:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108e9e:	80 ff ff 
ffff800000108ea1:	ff d0                	call   *%rax
      end_op();
ffff800000108ea3:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108eaa:	80 ff ff 
ffff800000108ead:	ff d0                	call   *%rax
      return -1;
ffff800000108eaf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108eb4:	e9 f7 00 00 00       	jmp    ffff800000108fb0 <sys_open+0x228>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff800000108eb9:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000108ec0:	80 ff ff 
ffff800000108ec3:	ff d0                	call   *%rax
ffff800000108ec5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108ec9:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108ece:	74 1c                	je     ffff800000108eec <sys_open+0x164>
ffff800000108ed0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ed4:	48 89 c7             	mov    %rax,%rdi
ffff800000108ed7:	48 b8 f3 82 10 00 00 	movabs $0xffff8000001082f3,%rax
ffff800000108ede:	80 ff ff 
ffff800000108ee1:	ff d0                	call   *%rax
ffff800000108ee3:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000108ee6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108eea:	79 43                	jns    ffff800000108f2f <sys_open+0x1a7>
    if(f)
ffff800000108eec:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108ef1:	74 13                	je     ffff800000108f06 <sys_open+0x17e>
      fileclose(f);
ffff800000108ef3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ef7:	48 89 c7             	mov    %rax,%rdi
ffff800000108efa:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000108f01:	80 ff ff 
ffff800000108f04:	ff d0                	call   *%rax
    iunlockput(ip);
ffff800000108f06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f0a:	48 89 c7             	mov    %rax,%rdi
ffff800000108f0d:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108f14:	80 ff ff 
ffff800000108f17:	ff d0                	call   *%rax
    end_op();
ffff800000108f19:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108f20:	80 ff ff 
ffff800000108f23:	ff d0                	call   *%rax
    return -1;
ffff800000108f25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f2a:	e9 81 00 00 00       	jmp    ffff800000108fb0 <sys_open+0x228>
  }
  iunlock(ip);
ffff800000108f2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f33:	48 89 c7             	mov    %rax,%rdi
ffff800000108f36:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000108f3d:	80 ff ff 
ffff800000108f40:	ff d0                	call   *%rax
  end_op();
ffff800000108f42:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000108f49:	80 ff ff 
ffff800000108f4c:	ff d0                	call   *%rax

  f->type = FD_INODE;
ffff800000108f4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f52:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffff800000108f58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f5c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108f60:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffff800000108f64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f68:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffff800000108f6f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108f72:	83 e0 01             	and    $0x1,%eax
ffff800000108f75:	83 e0 01             	and    $0x1,%eax
ffff800000108f78:	83 f0 01             	xor    $0x1,%eax
ffff800000108f7b:	89 c2                	mov    %eax,%edx
ffff800000108f7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f81:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000108f84:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108f87:	83 e0 01             	and    $0x1,%eax
ffff800000108f8a:	85 c0                	test   %eax,%eax
ffff800000108f8c:	75 0a                	jne    ffff800000108f98 <sys_open+0x210>
ffff800000108f8e:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108f91:	83 e0 02             	and    $0x2,%eax
ffff800000108f94:	85 c0                	test   %eax,%eax
ffff800000108f96:	74 07                	je     ffff800000108f9f <sys_open+0x217>
ffff800000108f98:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000108f9d:	eb 05                	jmp    ffff800000108fa4 <sys_open+0x21c>
ffff800000108f9f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108fa4:	89 c2                	mov    %eax,%edx
ffff800000108fa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108faa:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffff800000108fad:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffff800000108fb0:	c9                   	leave
ffff800000108fb1:	c3                   	ret

ffff800000108fb2 <sys_mkdir>:

int
sys_mkdir(void)
{
ffff800000108fb2:	55                   	push   %rbp
ffff800000108fb3:	48 89 e5             	mov    %rsp,%rbp
ffff800000108fb6:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000108fba:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000108fc1:	80 ff ff 
ffff800000108fc4:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffff800000108fc6:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108fca:	48 89 c6             	mov    %rax,%rsi
ffff800000108fcd:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108fd2:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff800000108fd9:	80 ff ff 
ffff800000108fdc:	ff d0                	call   *%rax
ffff800000108fde:	85 c0                	test   %eax,%eax
ffff800000108fe0:	78 2d                	js     ffff80000010900f <sys_mkdir+0x5d>
ffff800000108fe2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fe6:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108feb:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108ff0:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000108ff5:	48 89 c7             	mov    %rax,%rdi
ffff800000108ff8:	48 b8 0f 8b 10 00 00 	movabs $0xffff800000108b0f,%rax
ffff800000108fff:	80 ff ff 
ffff800000109002:	ff d0                	call   *%rax
ffff800000109004:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109008:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010900d:	75 13                	jne    ffff800000109022 <sys_mkdir+0x70>
    end_op();
ffff80000010900f:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000109016:	80 ff ff 
ffff800000109019:	ff d0                	call   *%rax
    return -1;
ffff80000010901b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109020:	eb 24                	jmp    ffff800000109046 <sys_mkdir+0x94>
  }
  iunlockput(ip);
ffff800000109022:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109026:	48 89 c7             	mov    %rax,%rdi
ffff800000109029:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000109030:	80 ff ff 
ffff800000109033:	ff d0                	call   *%rax
  end_op();
ffff800000109035:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff80000010903c:	80 ff ff 
ffff80000010903f:	ff d0                	call   *%rax
  return 0;
ffff800000109041:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109046:	c9                   	leave
ffff800000109047:	c3                   	ret

ffff800000109048 <sys_mknod>:

int
sys_mknod(void)
{
ffff800000109048:	55                   	push   %rbp
ffff800000109049:	48 89 e5             	mov    %rsp,%rbp
ffff80000010904c:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
ffff800000109050:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000109057:	80 ff ff 
ffff80000010905a:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff80000010905c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109060:	48 89 c6             	mov    %rax,%rsi
ffff800000109063:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109068:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff80000010906f:	80 ff ff 
ffff800000109072:	ff d0                	call   *%rax
ffff800000109074:	85 c0                	test   %eax,%eax
ffff800000109076:	78 67                	js     ffff8000001090df <sys_mknod+0x97>
     argint(1, &major) < 0 ||
ffff800000109078:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff80000010907c:	48 89 c6             	mov    %rax,%rsi
ffff80000010907f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109084:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff80000010908b:	80 ff ff 
ffff80000010908e:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff800000109090:	85 c0                	test   %eax,%eax
ffff800000109092:	78 4b                	js     ffff8000001090df <sys_mknod+0x97>
     argint(2, &minor) < 0 ||
ffff800000109094:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109098:	48 89 c6             	mov    %rax,%rsi
ffff80000010909b:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001090a0:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff8000001090a7:	80 ff ff 
ffff8000001090aa:	ff d0                	call   *%rax
     argint(1, &major) < 0 ||
ffff8000001090ac:	85 c0                	test   %eax,%eax
ffff8000001090ae:	78 2f                	js     ffff8000001090df <sys_mknod+0x97>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffff8000001090b0:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001090b3:	0f bf c8             	movswl %ax,%ecx
ffff8000001090b6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001090b9:	0f bf d0             	movswl %ax,%edx
ffff8000001090bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001090c0:	be 03 00 00 00       	mov    $0x3,%esi
ffff8000001090c5:	48 89 c7             	mov    %rax,%rdi
ffff8000001090c8:	48 b8 0f 8b 10 00 00 	movabs $0xffff800000108b0f,%rax
ffff8000001090cf:	80 ff ff 
ffff8000001090d2:	ff d0                	call   *%rax
ffff8000001090d4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     argint(2, &minor) < 0 ||
ffff8000001090d8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001090dd:	75 13                	jne    ffff8000001090f2 <sys_mknod+0xaa>
    end_op();
ffff8000001090df:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001090e6:	80 ff ff 
ffff8000001090e9:	ff d0                	call   *%rax
    return -1;
ffff8000001090eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001090f0:	eb 24                	jmp    ffff800000109116 <sys_mknod+0xce>
  }
  iunlockput(ip);
ffff8000001090f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001090f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001090f9:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000109100:	80 ff ff 
ffff800000109103:	ff d0                	call   *%rax
  end_op();
ffff800000109105:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff80000010910c:	80 ff ff 
ffff80000010910f:	ff d0                	call   *%rax
  return 0;
ffff800000109111:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109116:	c9                   	leave
ffff800000109117:	c3                   	ret

ffff800000109118 <sys_chdir>:

int
sys_chdir(void)
{
ffff800000109118:	55                   	push   %rbp
ffff800000109119:	48 89 e5             	mov    %rsp,%rbp
ffff80000010911c:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000109120:	48 b8 00 4f 10 00 00 	movabs $0xffff800000104f00,%rax
ffff800000109127:	80 ff ff 
ffff80000010912a:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
ffff80000010912c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109130:	48 89 c6             	mov    %rax,%rsi
ffff800000109133:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109138:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff80000010913f:	80 ff ff 
ffff800000109142:	ff d0                	call   *%rax
ffff800000109144:	85 c0                	test   %eax,%eax
ffff800000109146:	78 1e                	js     ffff800000109166 <sys_chdir+0x4e>
ffff800000109148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010914c:	48 89 c7             	mov    %rax,%rdi
ffff80000010914f:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000109156:	80 ff ff 
ffff800000109159:	ff d0                	call   *%rax
ffff80000010915b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010915f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109164:	75 16                	jne    ffff80000010917c <sys_chdir+0x64>
    end_op();
ffff800000109166:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff80000010916d:	80 ff ff 
ffff800000109170:	ff d0                	call   *%rax
    return -1;
ffff800000109172:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109177:	e9 a5 00 00 00       	jmp    ffff800000109221 <sys_chdir+0x109>
  }
  ilock(ip);
ffff80000010917c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109180:	48 89 c7             	mov    %rax,%rdi
ffff800000109183:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010918a:	80 ff ff 
ffff80000010918d:	ff d0                	call   *%rax
  if(ip->type != T_DIR){
ffff80000010918f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109193:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010919a:	66 83 f8 01          	cmp    $0x1,%ax
ffff80000010919e:	74 26                	je     ffff8000001091c6 <sys_chdir+0xae>
    iunlockput(ip);
ffff8000001091a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091a4:	48 89 c7             	mov    %rax,%rdi
ffff8000001091a7:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001091ae:	80 ff ff 
ffff8000001091b1:	ff d0                	call   *%rax
    end_op();
ffff8000001091b3:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff8000001091ba:	80 ff ff 
ffff8000001091bd:	ff d0                	call   *%rax
    return -1;
ffff8000001091bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001091c4:	eb 5b                	jmp    ffff800000109221 <sys_chdir+0x109>
  }
  iunlock(ip);
ffff8000001091c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001091cd:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff8000001091d4:	80 ff ff 
ffff8000001091d7:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff8000001091d9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001091e0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001091e4:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff8000001091eb:	48 89 c7             	mov    %rax,%rdi
ffff8000001091ee:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff8000001091f5:	80 ff ff 
ffff8000001091f8:	ff d0                	call   *%rax
  end_op();
ffff8000001091fa:	48 b8 e8 4f 10 00 00 	movabs $0xffff800000104fe8,%rax
ffff800000109201:	80 ff ff 
ffff800000109204:	ff d0                	call   *%rax
  proc->cwd = ip;
ffff800000109206:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010920d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109211:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000109215:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffff80000010921c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109221:	c9                   	leave
ffff800000109222:	c3                   	ret

ffff800000109223 <sys_exec>:

int
sys_exec(void)
{
ffff800000109223:	55                   	push   %rbp
ffff800000109224:	48 89 e5             	mov    %rsp,%rbp
ffff800000109227:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
ffff80000010922e:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109232:	48 89 c6             	mov    %rax,%rsi
ffff800000109235:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010923a:	48 b8 1f 81 10 00 00 	movabs $0xffff80000010811f,%rax
ffff800000109241:	80 ff ff 
ffff800000109244:	ff d0                	call   *%rax
ffff800000109246:	85 c0                	test   %eax,%eax
ffff800000109248:	78 44                	js     ffff80000010928e <sys_exec+0x6b>
ffff80000010924a:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff800000109251:	48 89 c6             	mov    %rax,%rsi
ffff800000109254:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109259:	48 b8 6a 80 10 00 00 	movabs $0xffff80000010806a,%rax
ffff800000109260:	80 ff ff 
ffff800000109263:	ff d0                	call   *%rax
    return -1;
  }
  memset(argv, 0, sizeof(argv));
ffff800000109265:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff80000010926c:	ba 00 01 00 00       	mov    $0x100,%edx
ffff800000109271:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109276:	48 89 c7             	mov    %rax,%rdi
ffff800000109279:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000109280:	80 ff ff 
ffff800000109283:	ff d0                	call   *%rax
  for(i=0;; i++){
ffff800000109285:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010928c:	eb 0a                	jmp    ffff800000109298 <sys_exec+0x75>
    return -1;
ffff80000010928e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109293:	e9 cb 00 00 00       	jmp    ffff800000109363 <sys_exec+0x140>
    if(i >= NELEM(argv))
ffff800000109298:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010929b:	83 f8 1f             	cmp    $0x1f,%eax
ffff80000010929e:	76 0a                	jbe    ffff8000001092aa <sys_exec+0x87>
      return -1;
ffff8000001092a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092a5:	e9 b9 00 00 00       	jmp    ffff800000109363 <sys_exec+0x140>
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
ffff8000001092aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001092ad:	48 98                	cltq
ffff8000001092af:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001092b6:	00 
ffff8000001092b7:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff8000001092be:	48 01 c2             	add    %rax,%rdx
ffff8000001092c1:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff8000001092c8:	48 89 c6             	mov    %rax,%rsi
ffff8000001092cb:	48 89 d7             	mov    %rdx,%rdi
ffff8000001092ce:	48 b8 44 7e 10 00 00 	movabs $0xffff800000107e44,%rax
ffff8000001092d5:	80 ff ff 
ffff8000001092d8:	ff d0                	call   *%rax
ffff8000001092da:	85 c0                	test   %eax,%eax
ffff8000001092dc:	79 07                	jns    ffff8000001092e5 <sys_exec+0xc2>
      return -1;
ffff8000001092de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092e3:	eb 7e                	jmp    ffff800000109363 <sys_exec+0x140>
    if(uarg == 0){
ffff8000001092e5:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff8000001092ec:	48 85 c0             	test   %rax,%rax
ffff8000001092ef:	75 31                	jne    ffff800000109322 <sys_exec+0xff>
      argv[i] = 0;
ffff8000001092f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001092f4:	48 98                	cltq
ffff8000001092f6:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff8000001092fd:	ff 00 00 00 00 
      break;
ffff800000109302:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffff800000109303:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109307:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff80000010930e:	48 89 d6             	mov    %rdx,%rsi
ffff800000109311:	48 89 c7             	mov    %rax,%rdi
ffff800000109314:	48 b8 43 15 10 00 00 	movabs $0xffff800000101543,%rax
ffff80000010931b:	80 ff ff 
ffff80000010931e:	ff d0                	call   *%rax
ffff800000109320:	eb 41                	jmp    ffff800000109363 <sys_exec+0x140>
    if(fetchstr(uarg, &argv[i]) < 0)
ffff800000109322:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff800000109329:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010932c:	48 63 d2             	movslq %edx,%rdx
ffff80000010932f:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000109333:	48 01 c2             	add    %rax,%rdx
ffff800000109336:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff80000010933d:	48 89 d6             	mov    %rdx,%rsi
ffff800000109340:	48 89 c7             	mov    %rax,%rdi
ffff800000109343:	48 b8 a9 7e 10 00 00 	movabs $0xffff800000107ea9,%rax
ffff80000010934a:	80 ff ff 
ffff80000010934d:	ff d0                	call   *%rax
ffff80000010934f:	85 c0                	test   %eax,%eax
ffff800000109351:	79 07                	jns    ffff80000010935a <sys_exec+0x137>
      return -1;
ffff800000109353:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109358:	eb 09                	jmp    ffff800000109363 <sys_exec+0x140>
  for(i=0;; i++){
ffff80000010935a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffff80000010935e:	e9 35 ff ff ff       	jmp    ffff800000109298 <sys_exec+0x75>
}
ffff800000109363:	c9                   	leave
ffff800000109364:	c3                   	ret

ffff800000109365 <sys_pipe>:

int
sys_pipe(void)
{
ffff800000109365:	55                   	push   %rbp
ffff800000109366:	48 89 e5             	mov    %rsp,%rbp
ffff800000109369:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffff80000010936d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109371:	ba 08 00 00 00       	mov    $0x8,%edx
ffff800000109376:	48 89 c6             	mov    %rax,%rsi
ffff800000109379:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010937e:	48 b8 98 80 10 00 00 	movabs $0xffff800000108098,%rax
ffff800000109385:	80 ff ff 
ffff800000109388:	ff d0                	call   *%rax
    return -1;
  if(pipealloc(&rf, &wf) < 0)
ffff80000010938a:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff80000010938e:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109392:	48 89 d6             	mov    %rdx,%rsi
ffff800000109395:	48 89 c7             	mov    %rax,%rdi
ffff800000109398:	48 b8 45 5c 10 00 00 	movabs $0xffff800000105c45,%rax
ffff80000010939f:	80 ff ff 
ffff8000001093a2:	ff d0                	call   *%rax
ffff8000001093a4:	85 c0                	test   %eax,%eax
ffff8000001093a6:	79 0a                	jns    ffff8000001093b2 <sys_pipe+0x4d>
    return -1;
ffff8000001093a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001093ad:	e9 ab 00 00 00       	jmp    ffff80000010945d <sys_pipe+0xf8>
  fd0 = -1;
ffff8000001093b2:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffff8000001093b9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001093bd:	48 89 c7             	mov    %rax,%rdi
ffff8000001093c0:	48 b8 f3 82 10 00 00 	movabs $0xffff8000001082f3,%rax
ffff8000001093c7:	80 ff ff 
ffff8000001093ca:	ff d0                	call   *%rax
ffff8000001093cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001093cf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001093d3:	78 1c                	js     ffff8000001093f1 <sys_pipe+0x8c>
ffff8000001093d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001093d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001093dc:	48 b8 f3 82 10 00 00 	movabs $0xffff8000001082f3,%rax
ffff8000001093e3:	80 ff ff 
ffff8000001093e6:	ff d0                	call   *%rax
ffff8000001093e8:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff8000001093eb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff8000001093ef:	79 51                	jns    ffff800000109442 <sys_pipe+0xdd>
    if(fd0 >= 0)
ffff8000001093f1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001093f5:	78 1e                	js     ffff800000109415 <sys_pipe+0xb0>
      proc->ofile[fd0] = 0;
ffff8000001093f7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001093fe:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109402:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109405:	48 63 d2             	movslq %edx,%rdx
ffff800000109408:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010940c:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000109413:	00 00 
    fileclose(rf);
ffff800000109415:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109419:	48 89 c7             	mov    %rax,%rdi
ffff80000010941c:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000109423:	80 ff ff 
ffff800000109426:	ff d0                	call   *%rax
    fileclose(wf);
ffff800000109428:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010942c:	48 89 c7             	mov    %rax,%rdi
ffff80000010942f:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000109436:	80 ff ff 
ffff800000109439:	ff d0                	call   *%rax
    return -1;
ffff80000010943b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109440:	eb 1b                	jmp    ffff80000010945d <sys_pipe+0xf8>
  }
  fd[0] = fd0;
ffff800000109442:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109446:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109449:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffff80000010944b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010944f:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000109453:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000109456:	89 02                	mov    %eax,(%rdx)
  return 0;
ffff800000109458:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010945d:	c9                   	leave
ffff80000010945e:	c3                   	ret

ffff80000010945f <lcr3>:
  return val;
}

static inline void
lcr3(addr_t val)
{
ffff80000010945f:	55                   	push   %rbp
ffff800000109460:	48 89 e5             	mov    %rsp,%rbp
ffff800000109463:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000109467:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffff80000010946b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010946f:	0f 22 d8             	mov    %rax,%cr3
}
ffff800000109472:	90                   	nop
ffff800000109473:	c9                   	leave
ffff800000109474:	c3                   	ret

ffff800000109475 <v2p>:
static inline addr_t v2p(void *a) {
ffff800000109475:	55                   	push   %rbp
ffff800000109476:	48 89 e5             	mov    %rsp,%rbp
ffff800000109479:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010947d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff800000109481:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109485:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010948c:	80 00 00 
ffff80000010948f:	48 01 d0             	add    %rdx,%rax
}
ffff800000109492:	c9                   	leave
ffff800000109493:	c3                   	ret

ffff800000109494 <sys_fork>:
#include "fs.h"
#include "file.h"

int
sys_fork(void)
{
ffff800000109494:	55                   	push   %rbp
ffff800000109495:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff800000109498:	48 b8 9d 65 10 00 00 	movabs $0xffff80000010659d,%rax
ffff80000010949f:	80 ff ff 
ffff8000001094a2:	ff d0                	call   *%rax
}
ffff8000001094a4:	5d                   	pop    %rbp
ffff8000001094a5:	c3                   	ret

ffff8000001094a6 <sys_exit>:

int
sys_exit(void)
{
ffff8000001094a6:	55                   	push   %rbp
ffff8000001094a7:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff8000001094aa:	48 b8 58 69 10 00 00 	movabs $0xffff800000106958,%rax
ffff8000001094b1:	80 ff ff 
ffff8000001094b4:	ff d0                	call   *%rax
  return 0;  // not reached
ffff8000001094b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001094bb:	5d                   	pop    %rbp
ffff8000001094bc:	c3                   	ret

ffff8000001094bd <sys_wait>:

int
sys_wait(void)
{
ffff8000001094bd:	55                   	push   %rbp
ffff8000001094be:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff8000001094c1:	48 b8 22 6c 10 00 00 	movabs $0xffff800000106c22,%rax
ffff8000001094c8:	80 ff ff 
ffff8000001094cb:	ff d0                	call   *%rax
}
ffff8000001094cd:	5d                   	pop    %rbp
ffff8000001094ce:	c3                   	ret

ffff8000001094cf <sys_kill>:

int
sys_kill(void)
{
ffff8000001094cf:	55                   	push   %rbp
ffff8000001094d0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001094d3:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff8000001094d7:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff8000001094db:	48 89 c6             	mov    %rax,%rsi
ffff8000001094de:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001094e3:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff8000001094ea:	80 ff ff 
ffff8000001094ed:	ff d0                	call   *%rax
ffff8000001094ef:	85 c0                	test   %eax,%eax
ffff8000001094f1:	79 07                	jns    ffff8000001094fa <sys_kill+0x2b>
    return -1;
ffff8000001094f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001094f8:	eb 11                	jmp    ffff80000010950b <sys_kill+0x3c>
  return kill(pid);
ffff8000001094fa:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001094fd:	89 c7                	mov    %eax,%edi
ffff8000001094ff:	48 b8 7f 72 10 00 00 	movabs $0xffff80000010727f,%rax
ffff800000109506:	80 ff ff 
ffff800000109509:	ff d0                	call   *%rax
}
ffff80000010950b:	c9                   	leave
ffff80000010950c:	c3                   	ret

ffff80000010950d <sys_getpid>:

int
sys_getpid(void)
{
ffff80000010950d:	55                   	push   %rbp
ffff80000010950e:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff800000109511:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109518:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010951c:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff80000010951f:	5d                   	pop    %rbp
ffff800000109520:	c3                   	ret

ffff800000109521 <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff800000109521:	55                   	push   %rbp
ffff800000109522:	48 89 e5             	mov    %rsp,%rbp
ffff800000109525:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff800000109529:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010952d:	48 89 c6             	mov    %rax,%rsi
ffff800000109530:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109535:	48 b8 6a 80 10 00 00 	movabs $0xffff80000010806a,%rax
ffff80000010953c:	80 ff ff 
ffff80000010953f:	ff d0                	call   *%rax
  addr = proc->sz;
ffff800000109541:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109548:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010954c:	48 8b 00             	mov    (%rax),%rax
ffff80000010954f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff800000109553:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109557:	48 89 c7             	mov    %rax,%rdi
ffff80000010955a:	48 b8 ba 64 10 00 00 	movabs $0xffff8000001064ba,%rax
ffff800000109561:	80 ff ff 
ffff800000109564:	ff d0                	call   *%rax
ffff800000109566:	85 c0                	test   %eax,%eax
ffff800000109568:	79 09                	jns    ffff800000109573 <sys_sbrk+0x52>
    return -1;
ffff80000010956a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109571:	eb 04                	jmp    ffff800000109577 <sys_sbrk+0x56>
  return addr;
ffff800000109573:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000109577:	c9                   	leave
ffff800000109578:	c3                   	ret

ffff800000109579 <sys_sleep>:

int
sys_sleep(void)
{
ffff800000109579:	55                   	push   %rbp
ffff80000010957a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010957d:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff800000109581:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109585:	48 89 c6             	mov    %rax,%rsi
ffff800000109588:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010958d:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff800000109594:	80 ff ff 
ffff800000109597:	ff d0                	call   *%rax
ffff800000109599:	85 c0                	test   %eax,%eax
ffff80000010959b:	79 0a                	jns    ffff8000001095a7 <sys_sleep+0x2e>
    return -1;
ffff80000010959d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001095a2:	e9 b6 00 00 00       	jmp    ffff80000010965d <sys_sleep+0xe4>
  acquire(&tickslock);
ffff8000001095a7:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff8000001095ae:	80 ff ff 
ffff8000001095b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001095b4:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff8000001095bb:	80 ff ff 
ffff8000001095be:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff8000001095c0:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff8000001095c7:	80 ff ff 
ffff8000001095ca:	8b 00                	mov    (%rax),%eax
ffff8000001095cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff8000001095cf:	eb 58                	jmp    ffff800000109629 <sys_sleep+0xb0>
    if(proc->killed){
ffff8000001095d1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001095d8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001095dc:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001095df:	85 c0                	test   %eax,%eax
ffff8000001095e1:	74 20                	je     ffff800000109603 <sys_sleep+0x8a>
      release(&tickslock);
ffff8000001095e3:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff8000001095ea:	80 ff ff 
ffff8000001095ed:	48 89 c7             	mov    %rax,%rdi
ffff8000001095f0:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001095f7:	80 ff ff 
ffff8000001095fa:	ff d0                	call   *%rax
      return -1;
ffff8000001095fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109601:	eb 5a                	jmp    ffff80000010965d <sys_sleep+0xe4>
    }
    sleep(&ticks, &tickslock);
ffff800000109603:	48 ba e0 00 12 00 00 	movabs $0xffff8000001200e0,%rdx
ffff80000010960a:	80 ff ff 
ffff80000010960d:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff800000109614:	80 ff ff 
ffff800000109617:	48 89 d6             	mov    %rdx,%rsi
ffff80000010961a:	48 89 c7             	mov    %rax,%rdi
ffff80000010961d:	48 b8 b6 70 10 00 00 	movabs $0xffff8000001070b6,%rax
ffff800000109624:	80 ff ff 
ffff800000109627:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff800000109629:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff800000109630:	80 ff ff 
ffff800000109633:	8b 00                	mov    (%rax),%eax
ffff800000109635:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000109638:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010963b:	39 d0                	cmp    %edx,%eax
ffff80000010963d:	72 92                	jb     ffff8000001095d1 <sys_sleep+0x58>
  }
  release(&tickslock);
ffff80000010963f:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff800000109646:	80 ff ff 
ffff800000109649:	48 89 c7             	mov    %rax,%rdi
ffff80000010964c:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff800000109653:	80 ff ff 
ffff800000109656:	ff d0                	call   *%rax
  return 0;
ffff800000109658:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010965d:	c9                   	leave
ffff80000010965e:	c3                   	ret

ffff80000010965f <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff80000010965f:	55                   	push   %rbp
ffff800000109660:	48 89 e5             	mov    %rsp,%rbp
ffff800000109663:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff800000109667:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff80000010966e:	80 ff ff 
ffff800000109671:	48 89 c7             	mov    %rax,%rdi
ffff800000109674:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010967b:	80 ff ff 
ffff80000010967e:	ff d0                	call   *%rax
  xticks = ticks;
ffff800000109680:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff800000109687:	80 ff ff 
ffff80000010968a:	8b 00                	mov    (%rax),%eax
ffff80000010968c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff80000010968f:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff800000109696:	80 ff ff 
ffff800000109699:	48 89 c7             	mov    %rax,%rdi
ffff80000010969c:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff8000001096a3:	80 ff ff 
ffff8000001096a6:	ff d0                	call   *%rax
  return xticks;
ffff8000001096a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001096ab:	c9                   	leave
ffff8000001096ac:	c3                   	ret

ffff8000001096ad <sys_mmap>:

#define MMAP_FAILED ((~0lu))
addr_t
sys_mmap(void)
{
ffff8000001096ad:	55                   	push   %rbp
ffff8000001096ae:	48 89 e5             	mov    %rsp,%rbp
ffff8000001096b1:	41 54                	push   %r12
ffff8000001096b3:	53                   	push   %rbx
ffff8000001096b4:	48 83 ec 40          	sub    $0x40,%rsp
  struct file *f;
  uint64 sz, i, n;
  char *mem;
  addr_t start_va;

  if(argint(0,&fd) < 0 || argint(1,&flags) < 0)
ffff8000001096b8:	48 8d 45 bc          	lea    -0x44(%rbp),%rax
ffff8000001096bc:	48 89 c6             	mov    %rax,%rsi
ffff8000001096bf:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001096c4:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff8000001096cb:	80 ff ff 
ffff8000001096ce:	ff d0                	call   *%rax
ffff8000001096d0:	85 c0                	test   %eax,%eax
ffff8000001096d2:	78 1c                	js     ffff8000001096f0 <sys_mmap+0x43>
ffff8000001096d4:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
ffff8000001096d8:	48 89 c6             	mov    %rax,%rsi
ffff8000001096db:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001096e0:	48 b8 3b 80 10 00 00 	movabs $0xffff80000010803b,%rax
ffff8000001096e7:	80 ff ff 
ffff8000001096ea:	ff d0                	call   *%rax
ffff8000001096ec:	85 c0                	test   %eax,%eax
ffff8000001096ee:	79 0c                	jns    ffff8000001096fc <sys_mmap+0x4f>
    return MMAP_FAILED;
ffff8000001096f0:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff8000001096f7:	e9 4a 05 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>

  if (fd < 0 || fd >= NOFILE || (f = proc->ofile[fd]) == 0 || f->type != FD_INODE)
ffff8000001096fc:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff8000001096ff:	85 c0                	test   %eax,%eax
ffff800000109701:	78 38                	js     ffff80000010973b <sys_mmap+0x8e>
ffff800000109703:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff800000109706:	83 f8 0f             	cmp    $0xf,%eax
ffff800000109709:	7f 30                	jg     ffff80000010973b <sys_mmap+0x8e>
ffff80000010970b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109712:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109716:	8b 55 bc             	mov    -0x44(%rbp),%edx
ffff800000109719:	48 63 d2             	movslq %edx,%rdx
ffff80000010971c:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109720:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000109725:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff800000109729:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff80000010972e:	74 0b                	je     ffff80000010973b <sys_mmap+0x8e>
ffff800000109730:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109734:	8b 00                	mov    (%rax),%eax
ffff800000109736:	83 f8 02             	cmp    $0x2,%eax
ffff800000109739:	74 0c                	je     ffff800000109747 <sys_mmap+0x9a>
    return MMAP_FAILED;
ffff80000010973b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109742:	e9 ff 04 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>

  if (proc->mmapcount >= 10)
ffff800000109747:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010974e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109752:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000109758:	83 f8 09             	cmp    $0x9,%eax
ffff80000010975b:	7e 0c                	jle    ffff800000109769 <sys_mmap+0xbc>
    return MMAP_FAILED;
ffff80000010975d:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109764:	e9 dd 04 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>

  if (flags == 0) {
ffff800000109769:	8b 45 b8             	mov    -0x48(%rbp),%eax
ffff80000010976c:	85 c0                	test   %eax,%eax
ffff80000010976e:	0f 85 33 03 00 00    	jne    ffff800000109aa7 <sys_mmap+0x3fa>
    // Eager
    ilock(f->ip);
ffff800000109774:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109778:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff80000010977c:	48 89 c7             	mov    %rax,%rdi
ffff80000010977f:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000109786:	80 ff ff 
ffff800000109789:	ff d0                	call   *%rax
    sz = f->ip->size;
ffff80000010978b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010978f:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109793:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000109799:	89 c0                	mov    %eax,%eax
ffff80000010979b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    start_va = (addr_t)proc->mmaptop;
ffff80000010979f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001097a6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001097aa:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
ffff8000001097b1:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

    for (i = 0; i < sz; i += PGSIZE) {
ffff8000001097b5:	48 c7 45 e8 00 00 00 	movq   $0x0,-0x18(%rbp)
ffff8000001097bc:	00 
ffff8000001097bd:	e9 5c 01 00 00       	jmp    ffff80000010991e <sys_mmap+0x271>
      if ((mem = kalloc()) == 0) {
ffff8000001097c2:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff8000001097c9:	80 ff ff 
ffff8000001097cc:	ff d0                	call   *%rax
ffff8000001097ce:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff8000001097d2:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff8000001097d7:	75 23                	jne    ffff8000001097fc <sys_mmap+0x14f>
        iunlock(f->ip);
ffff8000001097d9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001097dd:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001097e1:	48 89 c7             	mov    %rax,%rdi
ffff8000001097e4:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff8000001097eb:	80 ff ff 
ffff8000001097ee:	ff d0                	call   *%rax
        return MMAP_FAILED;
ffff8000001097f0:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff8000001097f7:	e9 4a 04 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>
      }
      memset(mem, 0, PGSIZE);
ffff8000001097fc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000109800:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109805:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010980a:	48 89 c7             	mov    %rax,%rdi
ffff80000010980d:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000109814:	80 ff ff 
ffff800000109817:	ff d0                	call   *%rax
      if (mappages(proc->pgdir, (char*)(start_va + i), PGSIZE, V2P(mem), PTE_W | PTE_U) < 0) {
ffff800000109819:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010981d:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff800000109824:	80 00 00 
ffff800000109827:	48 01 c2             	add    %rax,%rdx
ffff80000010982a:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
ffff80000010982e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109832:	48 01 c8             	add    %rcx,%rax
ffff800000109835:	48 89 c6             	mov    %rax,%rsi
ffff800000109838:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010983f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109843:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000109847:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010984d:	48 89 d1             	mov    %rdx,%rcx
ffff800000109850:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109855:	48 89 c7             	mov    %rax,%rdi
ffff800000109858:	48 b8 41 bd 10 00 00 	movabs $0xffff80000010bd41,%rax
ffff80000010985f:	80 ff ff 
ffff800000109862:	ff d0                	call   *%rax
ffff800000109864:	85 c0                	test   %eax,%eax
ffff800000109866:	79 36                	jns    ffff80000010989e <sys_mmap+0x1f1>
        kfree(mem);
ffff800000109868:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010986c:	48 89 c7             	mov    %rax,%rdi
ffff80000010986f:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000109876:	80 ff ff 
ffff800000109879:	ff d0                	call   *%rax
        iunlock(f->ip);
ffff80000010987b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010987f:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109883:	48 89 c7             	mov    %rax,%rdi
ffff800000109886:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff80000010988d:	80 ff ff 
ffff800000109890:	ff d0                	call   *%rax
        return MMAP_FAILED;
ffff800000109892:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109899:	e9 a8 03 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>
      }
      if (sz - i < PGSIZE) {
ffff80000010989e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001098a2:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff8000001098a6:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
ffff8000001098ac:	77 0e                	ja     ffff8000001098bc <sys_mmap+0x20f>
        n = sz - i;
ffff8000001098ae:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001098b2:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff8000001098b6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff8000001098ba:	eb 08                	jmp    ffff8000001098c4 <sys_mmap+0x217>
      } else {
        n = PGSIZE;
ffff8000001098bc:	48 c7 45 e0 00 10 00 	movq   $0x1000,-0x20(%rbp)
ffff8000001098c3:	00 
      }
      if (readi(f->ip, mem, i, n) != n) {
ffff8000001098c4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001098c8:	89 c1                	mov    %eax,%ecx
ffff8000001098ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001098ce:	89 c2                	mov    %eax,%edx
ffff8000001098d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001098d4:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001098d8:	48 8b 75 c0          	mov    -0x40(%rbp),%rsi
ffff8000001098dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001098df:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff8000001098e6:	80 ff ff 
ffff8000001098e9:	ff d0                	call   *%rax
ffff8000001098eb:	48 98                	cltq
ffff8000001098ed:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffff8000001098f1:	74 23                	je     ffff800000109916 <sys_mmap+0x269>
        iunlock(f->ip);
ffff8000001098f3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001098f7:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001098fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001098fe:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000109905:	80 ff ff 
ffff800000109908:	ff d0                	call   *%rax
        return MMAP_FAILED;
ffff80000010990a:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109911:	e9 30 03 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>
    for (i = 0; i < sz; i += PGSIZE) {
ffff800000109916:	48 81 45 e8 00 10 00 	addq   $0x1000,-0x18(%rbp)
ffff80000010991d:	00 
ffff80000010991e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109922:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff800000109926:	0f 82 96 fe ff ff    	jb     ffff8000001097c2 <sys_mmap+0x115>
      }
    }
    iunlock(f->ip);
ffff80000010992c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109930:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109934:	48 89 c7             	mov    %rax,%rdi
ffff800000109937:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff80000010993e:	80 ff ff 
ffff800000109941:	ff d0                	call   *%rax
    // Record mmap metadata
    proc->mmaps[proc->mmapcount].fd = fd;
ffff800000109943:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010994a:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff80000010994e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109955:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109959:	8b 88 e8 00 00 00    	mov    0xe8(%rax),%ecx
ffff80000010995f:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff800000109962:	48 63 c9             	movslq %ecx,%rcx
ffff800000109965:	48 c1 e1 05          	shl    $0x5,%rcx
ffff800000109969:	48 01 ca             	add    %rcx,%rdx
ffff80000010996c:	48 81 c2 f0 00 00 00 	add    $0xf0,%rdx
ffff800000109973:	89 02                	mov    %eax,(%rdx)
    proc->mmaps[proc->mmapcount].start = start_va;
ffff800000109975:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010997c:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000109980:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109987:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010998b:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000109991:	48 98                	cltq
ffff800000109993:	48 c1 e0 05          	shl    $0x5,%rax
ffff800000109997:	48 01 d0             	add    %rdx,%rax
ffff80000010999a:	48 8d 90 f8 00 00 00 	lea    0xf8(%rax),%rdx
ffff8000001099a1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001099a5:	48 89 02             	mov    %rax,(%rdx)
    proc->mmaps[proc->mmapcount].size = sz;
ffff8000001099a8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001099af:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001099b3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001099ba:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001099be:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001099c4:	48 98                	cltq
ffff8000001099c6:	48 83 c0 08          	add    $0x8,%rax
ffff8000001099ca:	48 c1 e0 05          	shl    $0x5,%rax
ffff8000001099ce:	48 01 c2             	add    %rax,%rdx
ffff8000001099d1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001099d5:	48 89 02             	mov    %rax,(%rdx)
    proc->mmaps[proc->mmapcount].f = filedup(f);
ffff8000001099d8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001099df:	64 48 8b 18          	mov    %fs:(%rax),%rbx
ffff8000001099e3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001099ea:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001099ee:	44 8b a0 e8 00 00 00 	mov    0xe8(%rax),%r12d
ffff8000001099f5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001099f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001099fc:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff800000109a03:	80 ff ff 
ffff800000109a06:	ff d0                	call   *%rax
ffff800000109a08:	49 63 d4             	movslq %r12d,%rdx
ffff800000109a0b:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109a0f:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109a13:	48 01 da             	add    %rbx,%rdx
ffff800000109a16:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109a1a:	48 89 02             	mov    %rax,(%rdx)
    proc->mmapcount++;
ffff800000109a1d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a24:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a28:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000109a2e:	83 c2 01             	add    $0x1,%edx
ffff800000109a31:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
    proc->mmaptop += PGROUNDUP(sz);
ffff800000109a37:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a3e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a42:	48 8b 90 e0 00 00 00 	mov    0xe0(%rax),%rdx
ffff800000109a49:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109a4d:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000109a53:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000109a59:	48 89 c1             	mov    %rax,%rcx
ffff800000109a5c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a63:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a67:	48 01 ca             	add    %rcx,%rdx
ffff800000109a6a:	48 89 90 e0 00 00 00 	mov    %rdx,0xe0(%rax)

    lcr3(v2p(proc->pgdir));
ffff800000109a71:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a78:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a7c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000109a80:	48 89 c7             	mov    %rax,%rdi
ffff800000109a83:	48 b8 75 94 10 00 00 	movabs $0xffff800000109475,%rax
ffff800000109a8a:	80 ff ff 
ffff800000109a8d:	ff d0                	call   *%rax
ffff800000109a8f:	48 89 c7             	mov    %rax,%rdi
ffff800000109a92:	48 b8 5f 94 10 00 00 	movabs $0xffff80000010945f,%rax
ffff800000109a99:	80 ff ff 
ffff800000109a9c:	ff d0                	call   *%rax

    return start_va;
ffff800000109a9e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000109aa2:	e9 9f 01 00 00       	jmp    ffff800000109c46 <sys_mmap+0x599>
  } else if (flags == 1) {
ffff800000109aa7:	8b 45 b8             	mov    -0x48(%rbp),%eax
ffff800000109aaa:	83 f8 01             	cmp    $0x1,%eax
ffff800000109aad:	0f 85 8c 01 00 00    	jne    ffff800000109c3f <sys_mmap+0x592>
    // Lazy
    ilock(f->ip);
ffff800000109ab3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109ab7:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109abb:	48 89 c7             	mov    %rax,%rdi
ffff800000109abe:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000109ac5:	80 ff ff 
ffff800000109ac8:	ff d0                	call   *%rax
    sz = f->ip->size;
ffff800000109aca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109ace:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109ad2:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000109ad8:	89 c0                	mov    %eax,%eax
ffff800000109ada:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    iunlock(f->ip);
ffff800000109ade:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109ae2:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109ae6:	48 89 c7             	mov    %rax,%rdi
ffff800000109ae9:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000109af0:	80 ff ff 
ffff800000109af3:	ff d0                	call   *%rax
    start_va = (addr_t)proc->mmaptop;
ffff800000109af5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109afc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109b00:	48 8b 80 e0 00 00 00 	mov    0xe0(%rax),%rax
ffff800000109b07:	48 89 45 c8          	mov    %rax,-0x38(%rbp)

    // Record mmap metadata
    proc->mmaps[proc->mmapcount].fd = fd;
ffff800000109b0b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109b12:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000109b16:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109b1d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109b21:	8b 88 e8 00 00 00    	mov    0xe8(%rax),%ecx
ffff800000109b27:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff800000109b2a:	48 63 c9             	movslq %ecx,%rcx
ffff800000109b2d:	48 c1 e1 05          	shl    $0x5,%rcx
ffff800000109b31:	48 01 ca             	add    %rcx,%rdx
ffff800000109b34:	48 81 c2 f0 00 00 00 	add    $0xf0,%rdx
ffff800000109b3b:	89 02                	mov    %eax,(%rdx)
    proc->mmaps[proc->mmapcount].start = start_va;
ffff800000109b3d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109b44:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000109b48:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109b4f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109b53:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000109b59:	48 98                	cltq
ffff800000109b5b:	48 c1 e0 05          	shl    $0x5,%rax
ffff800000109b5f:	48 01 d0             	add    %rdx,%rax
ffff800000109b62:	48 8d 90 f8 00 00 00 	lea    0xf8(%rax),%rdx
ffff800000109b69:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000109b6d:	48 89 02             	mov    %rax,(%rdx)
    proc->mmaps[proc->mmapcount].size = sz;
ffff800000109b70:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109b77:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000109b7b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109b82:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109b86:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000109b8c:	48 98                	cltq
ffff800000109b8e:	48 83 c0 08          	add    $0x8,%rax
ffff800000109b92:	48 c1 e0 05          	shl    $0x5,%rax
ffff800000109b96:	48 01 c2             	add    %rax,%rdx
ffff800000109b99:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109b9d:	48 89 02             	mov    %rax,(%rdx)
    proc->mmaps[proc->mmapcount].f = filedup(f);
ffff800000109ba0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ba7:	64 48 8b 18          	mov    %fs:(%rax),%rbx
ffff800000109bab:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109bb2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109bb6:	44 8b a0 e8 00 00 00 	mov    0xe8(%rax),%r12d
ffff800000109bbd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109bc1:	48 89 c7             	mov    %rax,%rdi
ffff800000109bc4:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff800000109bcb:	80 ff ff 
ffff800000109bce:	ff d0                	call   *%rax
ffff800000109bd0:	49 63 d4             	movslq %r12d,%rdx
ffff800000109bd3:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109bd7:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109bdb:	48 01 da             	add    %rbx,%rdx
ffff800000109bde:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109be2:	48 89 02             	mov    %rax,(%rdx)
    proc->mmapcount++;
ffff800000109be5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109bec:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109bf0:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000109bf6:	83 c2 01             	add    $0x1,%edx
ffff800000109bf9:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
    proc->mmaptop += PGROUNDUP(sz);
ffff800000109bff:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109c06:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109c0a:	48 8b 90 e0 00 00 00 	mov    0xe0(%rax),%rdx
ffff800000109c11:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109c15:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000109c1b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000109c21:	48 89 c1             	mov    %rax,%rcx
ffff800000109c24:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109c2b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109c2f:	48 01 ca             	add    %rcx,%rdx
ffff800000109c32:	48 89 90 e0 00 00 00 	mov    %rdx,0xe0(%rax)

    return start_va;
ffff800000109c39:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000109c3d:	eb 07                	jmp    ffff800000109c46 <sys_mmap+0x599>
  }

  return MMAP_FAILED;
ffff800000109c3f:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
}
ffff800000109c46:	48 83 c4 40          	add    $0x40,%rsp
ffff800000109c4a:	5b                   	pop    %rbx
ffff800000109c4b:	41 5c                	pop    %r12
ffff800000109c4d:	5d                   	pop    %rbp
ffff800000109c4e:	c3                   	ret

ffff800000109c4f <handle_pagefault>:

int
handle_pagefault(addr_t va)
{
ffff800000109c4f:	55                   	push   %rbp
ffff800000109c50:	48 89 e5             	mov    %rsp,%rbp
ffff800000109c53:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000109c57:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  int i;
  uint64 offset, n;
  char *mem;
  struct file *f;

  if (proc == 0)
ffff800000109c5b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109c62:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109c66:	48 85 c0             	test   %rax,%rax
ffff800000109c69:	75 0a                	jne    ffff800000109c75 <handle_pagefault+0x26>
    return 0;
ffff800000109c6b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109c70:	e9 fb 02 00 00       	jmp    ffff800000109f70 <handle_pagefault+0x321>

  for (i = 0; i < proc->mmapcount; i++) {
ffff800000109c75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109c7c:	e9 d0 02 00 00       	jmp    ffff800000109f51 <handle_pagefault+0x302>
    if (va >= proc->mmaps[i].start && va < proc->mmaps[i].start + PGROUNDUP(proc->mmaps[i].size)) {
ffff800000109c81:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109c88:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109c8c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109c8f:	48 63 d2             	movslq %edx,%rdx
ffff800000109c92:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109c96:	48 01 d0             	add    %rdx,%rax
ffff800000109c99:	48 05 f8 00 00 00    	add    $0xf8,%rax
ffff800000109c9f:	48 8b 00             	mov    (%rax),%rax
ffff800000109ca2:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
ffff800000109ca6:	0f 82 a1 02 00 00    	jb     ffff800000109f4d <handle_pagefault+0x2fe>
ffff800000109cac:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109cb3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109cb7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109cba:	48 63 d2             	movslq %edx,%rdx
ffff800000109cbd:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109cc1:	48 01 d0             	add    %rdx,%rax
ffff800000109cc4:	48 05 f8 00 00 00    	add    $0xf8,%rax
ffff800000109cca:	48 8b 10             	mov    (%rax),%rdx
ffff800000109ccd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109cd4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109cd8:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000109cdb:	48 63 c9             	movslq %ecx,%rcx
ffff800000109cde:	48 83 c1 08          	add    $0x8,%rcx
ffff800000109ce2:	48 c1 e1 05          	shl    $0x5,%rcx
ffff800000109ce6:	48 01 c8             	add    %rcx,%rax
ffff800000109ce9:	48 8b 00             	mov    (%rax),%rax
ffff800000109cec:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000109cf2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000109cf8:	48 01 d0             	add    %rdx,%rax
ffff800000109cfb:	48 39 45 c8          	cmp    %rax,-0x38(%rbp)
ffff800000109cff:	0f 83 48 02 00 00    	jae    ffff800000109f4d <handle_pagefault+0x2fe>
      // Found the mmap region
      f = proc->mmaps[i].f;
ffff800000109d05:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d0c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d10:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109d13:	48 63 d2             	movslq %edx,%rdx
ffff800000109d16:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109d1a:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109d1e:	48 01 d0             	add    %rdx,%rax
ffff800000109d21:	48 83 c0 08          	add    $0x8,%rax
ffff800000109d25:	48 8b 00             	mov    (%rax),%rax
ffff800000109d28:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      addr_t fault_page = PGROUNDDOWN(va);
ffff800000109d2c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000109d30:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000109d36:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      offset = fault_page - proc->mmaps[i].start;
ffff800000109d3a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d41:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d45:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109d48:	48 63 d2             	movslq %edx,%rdx
ffff800000109d4b:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109d4f:	48 01 d0             	add    %rdx,%rax
ffff800000109d52:	48 05 f8 00 00 00    	add    $0xf8,%rax
ffff800000109d58:	48 8b 00             	mov    (%rax),%rax
ffff800000109d5b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000109d5f:	48 29 c2             	sub    %rax,%rdx
ffff800000109d62:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)

      if ((mem = kalloc()) == 0)
ffff800000109d66:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000109d6d:	80 ff ff 
ffff800000109d70:	ff d0                	call   *%rax
ffff800000109d72:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff800000109d76:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff800000109d7b:	75 0a                	jne    ffff800000109d87 <handle_pagefault+0x138>
        return 0;
ffff800000109d7d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d82:	e9 e9 01 00 00       	jmp    ffff800000109f70 <handle_pagefault+0x321>
      memset(mem, 0, PGSIZE);
ffff800000109d87:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109d8b:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109d90:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109d95:	48 89 c7             	mov    %rax,%rdi
ffff800000109d98:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff800000109d9f:	80 ff ff 
ffff800000109da2:	ff d0                	call   *%rax

      ilock(f->ip);
ffff800000109da4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109da8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109dac:	48 89 c7             	mov    %rax,%rdi
ffff800000109daf:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000109db6:	80 ff ff 
ffff800000109db9:	ff d0                	call   *%rax
      if (offset < proc->mmaps[i].size) {
ffff800000109dbb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109dc2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109dc6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109dc9:	48 63 d2             	movslq %edx,%rdx
ffff800000109dcc:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109dd0:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109dd4:	48 01 d0             	add    %rdx,%rax
ffff800000109dd7:	48 8b 00             	mov    (%rax),%rax
ffff800000109dda:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
ffff800000109dde:	0f 83 bf 00 00 00    	jae    ffff800000109ea3 <handle_pagefault+0x254>
        if (proc->mmaps[i].size - offset < PGSIZE) {
ffff800000109de4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109deb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109def:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109df2:	48 63 d2             	movslq %edx,%rdx
ffff800000109df5:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109df9:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109dfd:	48 01 d0             	add    %rdx,%rax
ffff800000109e00:	48 8b 00             	mov    (%rax),%rax
ffff800000109e03:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
ffff800000109e07:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
ffff800000109e0d:	77 29                	ja     ffff800000109e38 <handle_pagefault+0x1e9>
          n = proc->mmaps[i].size - offset;
ffff800000109e0f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e16:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109e1a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109e1d:	48 63 d2             	movslq %edx,%rdx
ffff800000109e20:	48 83 c2 08          	add    $0x8,%rdx
ffff800000109e24:	48 c1 e2 05          	shl    $0x5,%rdx
ffff800000109e28:	48 01 d0             	add    %rdx,%rax
ffff800000109e2b:	48 8b 00             	mov    (%rax),%rax
ffff800000109e2e:	48 2b 45 d8          	sub    -0x28(%rbp),%rax
ffff800000109e32:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000109e36:	eb 08                	jmp    ffff800000109e40 <handle_pagefault+0x1f1>
        } else {
          n = PGSIZE;
ffff800000109e38:	48 c7 45 f0 00 10 00 	movq   $0x1000,-0x10(%rbp)
ffff800000109e3f:	00 
        }
        if (readi(f->ip, mem, offset, n) != n) {
ffff800000109e40:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109e44:	89 c1                	mov    %eax,%ecx
ffff800000109e46:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109e4a:	89 c2                	mov    %eax,%edx
ffff800000109e4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e50:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109e54:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff800000109e58:	48 89 c7             	mov    %rax,%rdi
ffff800000109e5b:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff800000109e62:	80 ff ff 
ffff800000109e65:	ff d0                	call   *%rax
ffff800000109e67:	48 98                	cltq
ffff800000109e69:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000109e6d:	74 34                	je     ffff800000109ea3 <handle_pagefault+0x254>
          iunlock(f->ip);
ffff800000109e6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e73:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109e77:	48 89 c7             	mov    %rax,%rdi
ffff800000109e7a:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000109e81:	80 ff ff 
ffff800000109e84:	ff d0                	call   *%rax
          kfree(mem);
ffff800000109e86:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109e8a:	48 89 c7             	mov    %rax,%rdi
ffff800000109e8d:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000109e94:	80 ff ff 
ffff800000109e97:	ff d0                	call   *%rax
          return 0;
ffff800000109e99:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e9e:	e9 cd 00 00 00       	jmp    ffff800000109f70 <handle_pagefault+0x321>
        }
      }
      iunlock(f->ip);
ffff800000109ea3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ea7:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000109eab:	48 89 c7             	mov    %rax,%rdi
ffff800000109eae:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000109eb5:	80 ff ff 
ffff800000109eb8:	ff d0                	call   *%rax
      if (mappages(proc->pgdir, (char*)fault_page, PGSIZE, V2P(mem), PTE_W | PTE_U) < 0) {
ffff800000109eba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109ebe:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff800000109ec5:	80 00 00 
ffff800000109ec8:	48 01 c2             	add    %rax,%rdx
ffff800000109ecb:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffff800000109ecf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ed6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109eda:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000109ede:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff800000109ee4:	48 89 d1             	mov    %rdx,%rcx
ffff800000109ee7:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109eec:	48 89 c7             	mov    %rax,%rdi
ffff800000109eef:	48 b8 41 bd 10 00 00 	movabs $0xffff80000010bd41,%rax
ffff800000109ef6:	80 ff ff 
ffff800000109ef9:	ff d0                	call   *%rax
ffff800000109efb:	85 c0                	test   %eax,%eax
ffff800000109efd:	79 1a                	jns    ffff800000109f19 <handle_pagefault+0x2ca>
        kfree(mem);
ffff800000109eff:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000109f03:	48 89 c7             	mov    %rax,%rdi
ffff800000109f06:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000109f0d:	80 ff ff 
ffff800000109f10:	ff d0                	call   *%rax
        return 0;
ffff800000109f12:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109f17:	eb 57                	jmp    ffff800000109f70 <handle_pagefault+0x321>
      }

      lcr3(v2p(proc->pgdir));
ffff800000109f19:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f20:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f24:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000109f28:	48 89 c7             	mov    %rax,%rdi
ffff800000109f2b:	48 b8 75 94 10 00 00 	movabs $0xffff800000109475,%rax
ffff800000109f32:	80 ff ff 
ffff800000109f35:	ff d0                	call   *%rax
ffff800000109f37:	48 89 c7             	mov    %rax,%rdi
ffff800000109f3a:	48 b8 5f 94 10 00 00 	movabs $0xffff80000010945f,%rax
ffff800000109f41:	80 ff ff 
ffff800000109f44:	ff d0                	call   *%rax
      return 1;
ffff800000109f46:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109f4b:	eb 23                	jmp    ffff800000109f70 <handle_pagefault+0x321>
  for (i = 0; i < proc->mmapcount; i++) {
ffff800000109f4d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109f51:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f58:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f5c:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000109f62:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000109f65:	0f 8c 16 fd ff ff    	jl     ffff800000109c81 <handle_pagefault+0x32>
    }
  }

  return 0;
ffff800000109f6b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109f70:	c9                   	leave
ffff800000109f71:	c3                   	ret

ffff800000109f72 <alltraps>:
# vectors.S sends all traps here.
.global alltraps
alltraps:
  # Build trap frame.
  pushq   %r15
ffff800000109f72:	41 57                	push   %r15
  pushq   %r14
ffff800000109f74:	41 56                	push   %r14
  pushq   %r13
ffff800000109f76:	41 55                	push   %r13
  pushq   %r12
ffff800000109f78:	41 54                	push   %r12
  pushq   %r11
ffff800000109f7a:	41 53                	push   %r11
  pushq   %r10
ffff800000109f7c:	41 52                	push   %r10
  pushq   %r9
ffff800000109f7e:	41 51                	push   %r9
  pushq   %r8
ffff800000109f80:	41 50                	push   %r8
  pushq   %rdi
ffff800000109f82:	57                   	push   %rdi
  pushq   %rsi
ffff800000109f83:	56                   	push   %rsi
  pushq   %rbp
ffff800000109f84:	55                   	push   %rbp
  pushq   %rdx
ffff800000109f85:	52                   	push   %rdx
  pushq   %rcx
ffff800000109f86:	51                   	push   %rcx
  pushq   %rbx
ffff800000109f87:	53                   	push   %rbx
  pushq   %rax
ffff800000109f88:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff800000109f89:	48 89 e7             	mov    %rsp,%rdi
  callq   trap
ffff800000109f8c:	e8 7b 02 00 00       	call   ffff80000010a20c <trap>

ffff800000109f91 <trapret>:
# Return falls through to trapret...

.global trapret
trapret:
  popq    %rax
ffff800000109f91:	58                   	pop    %rax
  popq    %rbx
ffff800000109f92:	5b                   	pop    %rbx
  popq    %rcx
ffff800000109f93:	59                   	pop    %rcx
  popq    %rdx
ffff800000109f94:	5a                   	pop    %rdx
  popq    %rbp
ffff800000109f95:	5d                   	pop    %rbp
  popq    %rsi
ffff800000109f96:	5e                   	pop    %rsi
  popq    %rdi
ffff800000109f97:	5f                   	pop    %rdi
  popq    %r8
ffff800000109f98:	41 58                	pop    %r8
  popq    %r9
ffff800000109f9a:	41 59                	pop    %r9
  popq    %r10
ffff800000109f9c:	41 5a                	pop    %r10
  popq    %r11
ffff800000109f9e:	41 5b                	pop    %r11
  popq    %r12
ffff800000109fa0:	41 5c                	pop    %r12
  popq    %r13
ffff800000109fa2:	41 5d                	pop    %r13
  popq    %r14
ffff800000109fa4:	41 5e                	pop    %r14
  popq    %r15
ffff800000109fa6:	41 5f                	pop    %r15

  addq    $16, %rsp  # discard trapnum and errorcode
ffff800000109fa8:	48 83 c4 10          	add    $0x10,%rsp
  iretq
ffff800000109fac:	48 cf                	iretq

ffff800000109fae <syscall_entry>:
.global syscall_entry
syscall_entry:
  # switch to kernel stack. With the syscall instruction,
  # this is a kernel resposibility
  # store %rsp on the top of proc->kstack,
  movq    %rax, %fs:(0)      # save %rax above __thread vars
ffff800000109fae:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff800000109fb5:	00 00 
  movq    %fs:(-8), %rax     # %fs:(-8) is proc (the last __thread)
ffff800000109fb7:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff800000109fbe:	ff ff 
  movq    0x10(%rax), %rax   # get proc->kstack (see struct proc)
ffff800000109fc0:	48 8b 40 10          	mov    0x10(%rax),%rax
  addq    $(4096-16), %rax   # %rax points to tf->rsp
ffff800000109fc4:	48 05 f0 0f 00 00    	add    $0xff0,%rax
  movq    %rsp, (%rax)       # save user rsp to tf->rsp
ffff800000109fca:	48 89 20             	mov    %rsp,(%rax)
  movq    %rax, %rsp         # switch to the kstack
ffff800000109fcd:	48 89 c4             	mov    %rax,%rsp
  movq    %fs:(0), %rax      # restore %rax
ffff800000109fd0:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff800000109fd7:	00 00 

  pushq   %r11         # rflags
ffff800000109fd9:	41 53                	push   %r11
  pushq   $0           # cs is ignored
ffff800000109fdb:	6a 00                	push   $0x0
  pushq   %rcx         # rip (next user insn)
ffff800000109fdd:	51                   	push   %rcx

  pushq   $0           # err
ffff800000109fde:	6a 00                	push   $0x0
  pushq   $0           # trapno ignored
ffff800000109fe0:	6a 00                	push   $0x0

  pushq   %r15
ffff800000109fe2:	41 57                	push   %r15
  pushq   %r14
ffff800000109fe4:	41 56                	push   %r14
  pushq   %r13
ffff800000109fe6:	41 55                	push   %r13
  pushq   %r12
ffff800000109fe8:	41 54                	push   %r12
  pushq   %r11
ffff800000109fea:	41 53                	push   %r11
  pushq   %r10
ffff800000109fec:	41 52                	push   %r10
  pushq   %r9
ffff800000109fee:	41 51                	push   %r9
  pushq   %r8
ffff800000109ff0:	41 50                	push   %r8
  pushq   %rdi
ffff800000109ff2:	57                   	push   %rdi
  pushq   %rsi
ffff800000109ff3:	56                   	push   %rsi
  pushq   %rbp
ffff800000109ff4:	55                   	push   %rbp
  pushq   %rdx
ffff800000109ff5:	52                   	push   %rdx
  pushq   %rcx
ffff800000109ff6:	51                   	push   %rcx
  pushq   %rbx
ffff800000109ff7:	53                   	push   %rbx
  pushq   %rax
ffff800000109ff8:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff800000109ff9:	48 89 e7             	mov    %rsp,%rdi
  callq   syscall
ffff800000109ffc:	e8 6d e1 ff ff       	call   ffff80000010816e <syscall>

ffff80000010a001 <syscall_trapret>:
# Return falls through to syscall_trapret...
#PAGEBREAK!

.global syscall_trapret
syscall_trapret:
  popq    %rax
ffff80000010a001:	58                   	pop    %rax
  popq    %rbx
ffff80000010a002:	5b                   	pop    %rbx
  popq    %rcx
ffff80000010a003:	59                   	pop    %rcx
  popq    %rdx
ffff80000010a004:	5a                   	pop    %rdx
  popq    %rbp
ffff80000010a005:	5d                   	pop    %rbp
  popq    %rsi
ffff80000010a006:	5e                   	pop    %rsi
  popq    %rdi
ffff80000010a007:	5f                   	pop    %rdi
  popq    %r8
ffff80000010a008:	41 58                	pop    %r8
  popq    %r9
ffff80000010a00a:	41 59                	pop    %r9
  popq    %r10
ffff80000010a00c:	41 5a                	pop    %r10
  popq    %r11
ffff80000010a00e:	41 5b                	pop    %r11
  popq    %r12
ffff80000010a010:	41 5c                	pop    %r12
  popq    %r13
ffff80000010a012:	41 5d                	pop    %r13
  popq    %r14
ffff80000010a014:	41 5e                	pop    %r14
  popq    %r15
ffff80000010a016:	41 5f                	pop    %r15

  addq    $40, %rsp  # discard trapnum, errorcode, rip, cs and rflags
ffff80000010a018:	48 83 c4 28          	add    $0x28,%rsp

  # to make sure we don't get any interrupts on the user stack while in
  # supervisor mode. this is actually slightly unsafe still,
  # since some interrupts are nonmaskable.
  # See https://www.felixcloutier.com/x86/sysret
  cli
ffff80000010a01c:	fa                   	cli
  movq    (%rsp), %rsp  # restore the user stack
ffff80000010a01d:	48 8b 24 24          	mov    (%rsp),%rsp
  sysretq
ffff80000010a021:	48 0f 07             	sysretq

ffff80000010a024 <lidt>:
{
ffff80000010a024:	55                   	push   %rbp
ffff80000010a025:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a028:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010a02c:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010a030:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010a033:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a037:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff80000010a03b:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010a03e:	83 e8 01             	sub    $0x1,%eax
ffff80000010a041:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010a045:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a049:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff80000010a04d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a051:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010a055:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff80000010a059:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a05d:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010a061:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010a065:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a069:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010a06d:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffff80000010a071:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010a075:	0f 01 18             	lidt   (%rax)
}
ffff80000010a078:	90                   	nop
ffff80000010a079:	c9                   	leave
ffff80000010a07a:	c3                   	ret

ffff80000010a07b <rcr2>:
{
ffff80000010a07b:	55                   	push   %rbp
ffff80000010a07c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a07f:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffff80000010a083:	0f 20 d0             	mov    %cr2,%rax
ffff80000010a086:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffff80000010a08a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010a08e:	c9                   	leave
ffff80000010a08f:	c3                   	ret

ffff80000010a090 <mkgate>:
struct spinlock tickslock;
uint ticks;

static void
mkgate(uint *idt, uint n, addr_t kva, uint pl)
{
ffff80000010a090:	55                   	push   %rbp
ffff80000010a091:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a094:	48 83 ec 28          	sub    $0x28,%rsp
ffff80000010a098:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010a09c:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010a09f:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010a0a3:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff80000010a0a6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a0aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  n *= 4;
ffff80000010a0ae:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff80000010a0b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a0b6:	0f b7 d0             	movzwl %ax,%edx
ffff80000010a0b9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a0bc:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff80000010a0c3:	00 
ffff80000010a0c4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a0c8:	48 01 c8             	add    %rcx,%rax
ffff80000010a0cb:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff80000010a0d1:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff80000010a0d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a0d7:	66 b8 00 00          	mov    $0x0,%ax
ffff80000010a0db:	89 c2                	mov    %eax,%edx
ffff80000010a0dd:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff80000010a0e0:	c1 e0 0d             	shl    $0xd,%eax
ffff80000010a0e3:	25 00 60 00 00       	and    $0x6000,%eax
ffff80000010a0e8:	09 c2                	or     %eax,%edx
ffff80000010a0ea:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a0ed:	83 c0 01             	add    $0x1,%eax
ffff80000010a0f0:	89 c0                	mov    %eax,%eax
ffff80000010a0f2:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff80000010a0f9:	00 
ffff80000010a0fa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a0fe:	48 01 c8             	add    %rcx,%rax
ffff80000010a101:	80 ce 8e             	or     $0x8e,%dh
ffff80000010a104:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff80000010a106:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a10a:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010a10e:	48 89 c1             	mov    %rax,%rcx
ffff80000010a111:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a114:	83 c0 02             	add    $0x2,%eax
ffff80000010a117:	89 c0                	mov    %eax,%eax
ffff80000010a119:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff80000010a120:	00 
ffff80000010a121:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a125:	48 01 d0             	add    %rdx,%rax
ffff80000010a128:	89 ca                	mov    %ecx,%edx
ffff80000010a12a:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff80000010a12c:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff80000010a12f:	83 c0 03             	add    $0x3,%eax
ffff80000010a132:	89 c0                	mov    %eax,%eax
ffff80000010a134:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff80000010a13b:	00 
ffff80000010a13c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a140:	48 01 d0             	add    %rdx,%rax
ffff80000010a143:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff80000010a149:	90                   	nop
ffff80000010a14a:	c9                   	leave
ffff80000010a14b:	c3                   	ret

ffff80000010a14c <idtinit>:

void idtinit(void)
{
ffff80000010a14c:	55                   	push   %rbp
ffff80000010a14d:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff80000010a150:	48 b8 c0 00 12 00 00 	movabs $0xffff8000001200c0,%rax
ffff80000010a157:	80 ff ff 
ffff80000010a15a:	48 8b 00             	mov    (%rax),%rax
ffff80000010a15d:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010a162:	48 89 c7             	mov    %rax,%rdi
ffff80000010a165:	48 b8 24 a0 10 00 00 	movabs $0xffff80000010a024,%rax
ffff80000010a16c:	80 ff ff 
ffff80000010a16f:	ff d0                	call   *%rax
}
ffff80000010a171:	90                   	nop
ffff80000010a172:	5d                   	pop    %rbp
ffff80000010a173:	c3                   	ret

ffff80000010a174 <tvinit>:

void tvinit(void)
{
ffff80000010a174:	55                   	push   %rbp
ffff80000010a175:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a178:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  idt = (uint*) kalloc();
ffff80000010a17c:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010a183:	80 ff ff 
ffff80000010a186:	ff d0                	call   *%rax
ffff80000010a188:	48 ba c0 00 12 00 00 	movabs $0xffff8000001200c0,%rdx
ffff80000010a18f:	80 ff ff 
ffff80000010a192:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff80000010a195:	48 b8 c0 00 12 00 00 	movabs $0xffff8000001200c0,%rax
ffff80000010a19c:	80 ff ff 
ffff80000010a19f:	48 8b 00             	mov    (%rax),%rax
ffff80000010a1a2:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010a1a7:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a1ac:	48 89 c7             	mov    %rax,%rdi
ffff80000010a1af:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010a1b6:	80 ff ff 
ffff80000010a1b9:	ff d0                	call   *%rax

  for (n = 0; n < 256; n++)
ffff80000010a1bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a1c2:	eb 3b                	jmp    ffff80000010a1ff <tvinit+0x8b>
    mkgate(idt, n, vectors[n], 0);
ffff80000010a1c4:	48 ba 58 d6 10 00 00 	movabs $0xffff80000010d658,%rdx
ffff80000010a1cb:	80 ff ff 
ffff80000010a1ce:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010a1d1:	48 98                	cltq
ffff80000010a1d3:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff80000010a1d7:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff80000010a1da:	48 b8 c0 00 12 00 00 	movabs $0xffff8000001200c0,%rax
ffff80000010a1e1:	80 ff ff 
ffff80000010a1e4:	48 8b 00             	mov    (%rax),%rax
ffff80000010a1e7:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff80000010a1ec:	48 89 c7             	mov    %rax,%rdi
ffff80000010a1ef:	48 b8 90 a0 10 00 00 	movabs $0xffff80000010a090,%rax
ffff80000010a1f6:	80 ff ff 
ffff80000010a1f9:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff80000010a1fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010a1ff:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010a206:	7e bc                	jle    ffff80000010a1c4 <tvinit+0x50>
}
ffff80000010a208:	90                   	nop
ffff80000010a209:	90                   	nop
ffff80000010a20a:	c9                   	leave
ffff80000010a20b:	c3                   	ret

ffff80000010a20c <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffff80000010a20c:	55                   	push   %rbp
ffff80000010a20d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a210:	41 54                	push   %r12
ffff80000010a212:	53                   	push   %rbx
ffff80000010a213:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010a217:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff80000010a21b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a21f:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010a223:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff80000010a227:	0f 84 60 01 00 00    	je     ffff80000010a38d <trap+0x181>
ffff80000010a22d:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff80000010a231:	0f 87 d3 01 00 00    	ja     ffff80000010a40a <trap+0x1fe>
ffff80000010a237:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff80000010a23b:	0f 84 39 03 00 00    	je     ffff80000010a57a <trap+0x36e>
ffff80000010a241:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff80000010a245:	0f 87 bf 01 00 00    	ja     ffff80000010a40a <trap+0x1fe>
ffff80000010a24b:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff80000010a24f:	0f 84 e1 00 00 00    	je     ffff80000010a336 <trap+0x12a>
ffff80000010a255:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff80000010a259:	0f 87 ab 01 00 00    	ja     ffff80000010a40a <trap+0x1fe>
ffff80000010a25f:	48 83 f8 27          	cmp    $0x27,%rax
ffff80000010a263:	0f 84 24 01 00 00    	je     ffff80000010a38d <trap+0x181>
ffff80000010a269:	48 83 f8 27          	cmp    $0x27,%rax
ffff80000010a26d:	0f 87 97 01 00 00    	ja     ffff80000010a40a <trap+0x1fe>
ffff80000010a273:	48 83 f8 24          	cmp    $0x24,%rax
ffff80000010a277:	0f 84 f3 00 00 00    	je     ffff80000010a370 <trap+0x164>
ffff80000010a27d:	48 83 f8 24          	cmp    $0x24,%rax
ffff80000010a281:	0f 87 83 01 00 00    	ja     ffff80000010a40a <trap+0x1fe>
ffff80000010a287:	48 83 f8 21          	cmp    $0x21,%rax
ffff80000010a28b:	0f 84 c2 00 00 00    	je     ffff80000010a353 <trap+0x147>
ffff80000010a291:	48 83 f8 21          	cmp    $0x21,%rax
ffff80000010a295:	0f 87 6f 01 00 00    	ja     ffff80000010a40a <trap+0x1fe>
ffff80000010a29b:	48 83 f8 0e          	cmp    $0xe,%rax
ffff80000010a29f:	0f 84 42 01 00 00    	je     ffff80000010a3e7 <trap+0x1db>
ffff80000010a2a5:	48 83 f8 20          	cmp    $0x20,%rax
ffff80000010a2a9:	0f 85 5b 01 00 00    	jne    ffff80000010a40a <trap+0x1fe>
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
ffff80000010a2af:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff80000010a2b6:	80 ff ff 
ffff80000010a2b9:	ff d0                	call   *%rax
ffff80000010a2bb:	85 c0                	test   %eax,%eax
ffff80000010a2bd:	75 66                	jne    ffff80000010a325 <trap+0x119>
      acquire(&tickslock);
ffff80000010a2bf:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff80000010a2c6:	80 ff ff 
ffff80000010a2c9:	48 89 c7             	mov    %rax,%rdi
ffff80000010a2cc:	48 b8 e5 76 10 00 00 	movabs $0xffff8000001076e5,%rax
ffff80000010a2d3:	80 ff ff 
ffff80000010a2d6:	ff d0                	call   *%rax
      ticks++;
ffff80000010a2d8:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff80000010a2df:	80 ff ff 
ffff80000010a2e2:	8b 00                	mov    (%rax),%eax
ffff80000010a2e4:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010a2e7:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff80000010a2ee:	80 ff ff 
ffff80000010a2f1:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff80000010a2f3:	48 b8 48 01 12 00 00 	movabs $0xffff800000120148,%rax
ffff80000010a2fa:	80 ff ff 
ffff80000010a2fd:	48 89 c7             	mov    %rax,%rdi
ffff80000010a300:	48 b8 2b 72 10 00 00 	movabs $0xffff80000010722b,%rax
ffff80000010a307:	80 ff ff 
ffff80000010a30a:	ff d0                	call   *%rax
      release(&tickslock);
ffff80000010a30c:	48 b8 e0 00 12 00 00 	movabs $0xffff8000001200e0,%rax
ffff80000010a313:	80 ff ff 
ffff80000010a316:	48 89 c7             	mov    %rax,%rdi
ffff80000010a319:	48 b8 84 77 10 00 00 	movabs $0xffff800000107784,%rax
ffff80000010a320:	80 ff ff 
ffff80000010a323:	ff d0                	call   *%rax
    }
    lapiceoi();
ffff80000010a325:	48 b8 d3 47 10 00 00 	movabs $0xffff8000001047d3,%rax
ffff80000010a32c:	80 ff ff 
ffff80000010a32f:	ff d0                	call   *%rax
    break;
ffff80000010a331:	e9 48 02 00 00       	jmp    ffff80000010a57e <trap+0x372>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffff80000010a336:	48 b8 89 3b 10 00 00 	movabs $0xffff800000103b89,%rax
ffff80000010a33d:	80 ff ff 
ffff80000010a340:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a342:	48 b8 d3 47 10 00 00 	movabs $0xffff8000001047d3,%rax
ffff80000010a349:	80 ff ff 
ffff80000010a34c:	ff d0                	call   *%rax
    break;
ffff80000010a34e:	e9 2b 02 00 00       	jmp    ffff80000010a57e <trap+0x372>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffff80000010a353:	48 b8 89 44 10 00 00 	movabs $0xffff800000104489,%rax
ffff80000010a35a:	80 ff ff 
ffff80000010a35d:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a35f:	48 b8 d3 47 10 00 00 	movabs $0xffff8000001047d3,%rax
ffff80000010a366:	80 ff ff 
ffff80000010a369:	ff d0                	call   *%rax
    break;
ffff80000010a36b:	e9 0e 02 00 00       	jmp    ffff80000010a57e <trap+0x372>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffff80000010a370:	48 b8 a6 a8 10 00 00 	movabs $0xffff80000010a8a6,%rax
ffff80000010a377:	80 ff ff 
ffff80000010a37a:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010a37c:	48 b8 d3 47 10 00 00 	movabs $0xffff8000001047d3,%rax
ffff80000010a383:	80 ff ff 
ffff80000010a386:	ff d0                	call   *%rax
    break;
ffff80000010a388:	e9 f1 01 00 00       	jmp    ffff80000010a57e <trap+0x372>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff80000010a38d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a391:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff80000010a398:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a39c:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff80000010a3a3:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff80000010a3aa:	80 ff ff 
ffff80000010a3ad:	ff d0                	call   *%rax
ffff80000010a3af:	89 c6                	mov    %eax,%esi
ffff80000010a3b1:	48 b8 e8 cc 10 00 00 	movabs $0xffff80000010cce8,%rax
ffff80000010a3b8:	80 ff ff 
ffff80000010a3bb:	4c 89 e1             	mov    %r12,%rcx
ffff80000010a3be:	48 89 da             	mov    %rbx,%rdx
ffff80000010a3c1:	48 89 c7             	mov    %rax,%rdi
ffff80000010a3c4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a3c9:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff80000010a3d0:	80 ff ff 
ffff80000010a3d3:	41 ff d0             	call   *%r8
            cpunum(), tf->cs, tf->rip);
    lapiceoi();
ffff80000010a3d6:	48 b8 d3 47 10 00 00 	movabs $0xffff8000001047d3,%rax
ffff80000010a3dd:	80 ff ff 
ffff80000010a3e0:	ff d0                	call   *%rax
    break;
ffff80000010a3e2:	e9 97 01 00 00       	jmp    ffff80000010a57e <trap+0x372>

  case T_PGFLT:
    if (handle_pagefault(rcr2()))
ffff80000010a3e7:	48 b8 7b a0 10 00 00 	movabs $0xffff80000010a07b,%rax
ffff80000010a3ee:	80 ff ff 
ffff80000010a3f1:	ff d0                	call   *%rax
ffff80000010a3f3:	48 89 c7             	mov    %rax,%rdi
ffff80000010a3f6:	48 b8 4f 9c 10 00 00 	movabs $0xffff800000109c4f,%rax
ffff80000010a3fd:	80 ff ff 
ffff80000010a400:	ff d0                	call   *%rax
ffff80000010a402:	85 c0                	test   %eax,%eax
ffff80000010a404:	0f 85 73 01 00 00    	jne    ffff80000010a57d <trap+0x371>
      break;
    // fall-through to default

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff80000010a40a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a411:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a415:	48 85 c0             	test   %rax,%rax
ffff80000010a418:	74 17                	je     ffff80000010a431 <trap+0x225>
ffff80000010a41a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a41e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010a425:	83 e0 03             	and    $0x3,%eax
ffff80000010a428:	48 85 c0             	test   %rax,%rax
ffff80000010a42b:	0f 85 ac 00 00 00    	jne    ffff80000010a4dd <trap+0x2d1>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff80000010a431:	48 b8 7b a0 10 00 00 	movabs $0xffff80000010a07b,%rax
ffff80000010a438:	80 ff ff 
ffff80000010a43b:	ff d0                	call   *%rax
ffff80000010a43d:	49 89 c4             	mov    %rax,%r12
ffff80000010a440:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a444:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff80000010a44b:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff80000010a452:	80 ff ff 
ffff80000010a455:	ff d0                	call   *%rax
ffff80000010a457:	89 c2                	mov    %eax,%edx
ffff80000010a459:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a45d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010a461:	48 bf 10 cd 10 00 00 	movabs $0xffff80000010cd10,%rdi
ffff80000010a468:	80 ff ff 
ffff80000010a46b:	4d 89 e0             	mov    %r12,%r8
ffff80000010a46e:	48 89 d9             	mov    %rbx,%rcx
ffff80000010a471:	48 89 c6             	mov    %rax,%rsi
ffff80000010a474:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a479:	49 b9 04 08 10 00 00 	movabs $0xffff800000100804,%r9
ffff80000010a480:	80 ff ff 
ffff80000010a483:	41 ff d1             	call   *%r9
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff80000010a486:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a48d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a491:	48 85 c0             	test   %rax,%rax
ffff80000010a494:	74 2e                	je     ffff80000010a4c4 <trap+0x2b8>
        cprintf("proc id: %d\n", proc->pid);
ffff80000010a496:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a49d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a4a1:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010a4a4:	48 ba 42 cd 10 00 00 	movabs $0xffff80000010cd42,%rdx
ffff80000010a4ab:	80 ff ff 
ffff80000010a4ae:	89 c6                	mov    %eax,%esi
ffff80000010a4b0:	48 89 d7             	mov    %rdx,%rdi
ffff80000010a4b3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a4b8:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010a4bf:	80 ff ff 
ffff80000010a4c2:	ff d2                	call   *%rdx
      panic("trap");
ffff80000010a4c4:	48 b8 4f cd 10 00 00 	movabs $0xffff80000010cd4f,%rax
ffff80000010a4cb:	80 ff ff 
ffff80000010a4ce:	48 89 c7             	mov    %rax,%rdi
ffff80000010a4d1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010a4d8:	80 ff ff 
ffff80000010a4db:	ff d0                	call   *%rax
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff80000010a4dd:	48 b8 7b a0 10 00 00 	movabs $0xffff80000010a07b,%rax
ffff80000010a4e4:	80 ff ff 
ffff80000010a4e7:	ff d0                	call   *%rax
ffff80000010a4e9:	48 89 c3             	mov    %rax,%rbx
ffff80000010a4ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a4f0:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff80000010a4f7:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff80000010a4fe:	80 ff ff 
ffff80000010a501:	ff d0                	call   *%rax
ffff80000010a503:	89 c1                	mov    %eax,%ecx
ffff80000010a505:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a509:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffff80000010a510:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a514:	48 8b 50 78          	mov    0x78(%rax),%rdx
            "rip 0x%p addr 0x%p--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff80000010a518:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a51f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a523:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff80000010a52a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a531:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff80000010a535:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010a538:	48 bf 58 cd 10 00 00 	movabs $0xffff80000010cd58,%rdi
ffff80000010a53f:	80 ff ff 
ffff80000010a542:	53                   	push   %rbx
ffff80000010a543:	41 54                	push   %r12
ffff80000010a545:	41 89 c9             	mov    %ecx,%r9d
ffff80000010a548:	48 89 d1             	mov    %rdx,%rcx
ffff80000010a54b:	48 89 f2             	mov    %rsi,%rdx
ffff80000010a54e:	89 c6                	mov    %eax,%esi
ffff80000010a550:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010a555:	49 ba 04 08 10 00 00 	movabs $0xffff800000100804,%r10
ffff80000010a55c:	80 ff ff 
ffff80000010a55f:	41 ff d2             	call   *%r10
ffff80000010a562:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
    proc->killed = 1;
ffff80000010a566:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a56d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a571:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff80000010a578:	eb 04                	jmp    ffff80000010a57e <trap+0x372>
    break;
ffff80000010a57a:	90                   	nop
ffff80000010a57b:	eb 01                	jmp    ffff80000010a57e <trap+0x372>
      break;
ffff80000010a57d:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff80000010a57e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a585:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a589:	48 85 c0             	test   %rax,%rax
ffff80000010a58c:	74 32                	je     ffff80000010a5c0 <trap+0x3b4>
ffff80000010a58e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a595:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a599:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010a59c:	85 c0                	test   %eax,%eax
ffff80000010a59e:	74 20                	je     ffff80000010a5c0 <trap+0x3b4>
ffff80000010a5a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a5a4:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010a5ab:	83 e0 03             	and    $0x3,%eax
ffff80000010a5ae:	48 83 f8 03          	cmp    $0x3,%rax
ffff80000010a5b2:	75 0c                	jne    ffff80000010a5c0 <trap+0x3b4>
    exit();
ffff80000010a5b4:	48 b8 58 69 10 00 00 	movabs $0xffff800000106958,%rax
ffff80000010a5bb:	80 ff ff 
ffff80000010a5be:	ff d0                	call   *%rax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff80000010a5c0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a5c7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a5cb:	48 85 c0             	test   %rax,%rax
ffff80000010a5ce:	74 2d                	je     ffff80000010a5fd <trap+0x3f1>
ffff80000010a5d0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a5d7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a5db:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010a5de:	83 f8 04             	cmp    $0x4,%eax
ffff80000010a5e1:	75 1a                	jne    ffff80000010a5fd <trap+0x3f1>
ffff80000010a5e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a5e7:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010a5eb:	48 83 f8 20          	cmp    $0x20,%rax
ffff80000010a5ef:	75 0c                	jne    ffff80000010a5fd <trap+0x3f1>
    yield();
ffff80000010a5f1:	48 b8 fd 6f 10 00 00 	movabs $0xffff800000106ffd,%rax
ffff80000010a5f8:	80 ff ff 
ffff80000010a5fb:	ff d0                	call   *%rax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff80000010a5fd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a604:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a608:	48 85 c0             	test   %rax,%rax
ffff80000010a60b:	74 32                	je     ffff80000010a63f <trap+0x433>
ffff80000010a60d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010a614:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010a618:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010a61b:	85 c0                	test   %eax,%eax
ffff80000010a61d:	74 20                	je     ffff80000010a63f <trap+0x433>
ffff80000010a61f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a623:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff80000010a62a:	83 e0 03             	and    $0x3,%eax
ffff80000010a62d:	48 83 f8 03          	cmp    $0x3,%rax
ffff80000010a631:	75 0c                	jne    ffff80000010a63f <trap+0x433>
    exit();
ffff80000010a633:	48 b8 58 69 10 00 00 	movabs $0xffff800000106958,%rax
ffff80000010a63a:	80 ff ff 
ffff80000010a63d:	ff d0                	call   *%rax
}
ffff80000010a63f:	90                   	nop
ffff80000010a640:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff80000010a644:	5b                   	pop    %rbx
ffff80000010a645:	41 5c                	pop    %r12
ffff80000010a647:	5d                   	pop    %rbp
ffff80000010a648:	c3                   	ret

ffff80000010a649 <inb>:
{
ffff80000010a649:	55                   	push   %rbp
ffff80000010a64a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a64d:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010a651:	89 f8                	mov    %edi,%eax
ffff80000010a653:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff80000010a657:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010a65b:	89 c2                	mov    %eax,%edx
ffff80000010a65d:	ec                   	in     (%dx),%al
ffff80000010a65e:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010a661:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff80000010a665:	c9                   	leave
ffff80000010a666:	c3                   	ret

ffff80000010a667 <outb>:
{
ffff80000010a667:	55                   	push   %rbp
ffff80000010a668:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a66b:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010a66f:	89 fa                	mov    %edi,%edx
ffff80000010a671:	89 f0                	mov    %esi,%eax
ffff80000010a673:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010a677:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff80000010a67a:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010a67e:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010a682:	ee                   	out    %al,(%dx)
}
ffff80000010a683:	90                   	nop
ffff80000010a684:	c9                   	leave
ffff80000010a685:	c3                   	ret

ffff80000010a686 <uartearlyinit>:

static int uart;    // is there a uart?

void
uartearlyinit(void)
{
ffff80000010a686:	55                   	push   %rbp
ffff80000010a687:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a68a:	48 83 ec 10          	sub    $0x10,%rsp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
ffff80000010a68e:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a693:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a698:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a69f:	80 ff ff 
ffff80000010a6a2:	ff d0                	call   *%rax

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffff80000010a6a4:	be 80 00 00 00       	mov    $0x80,%esi
ffff80000010a6a9:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a6ae:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a6b5:	80 ff ff 
ffff80000010a6b8:	ff d0                	call   *%rax
  outb(COM1+0, 115200/9600);
ffff80000010a6ba:	be 0c 00 00 00       	mov    $0xc,%esi
ffff80000010a6bf:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a6c4:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a6cb:	80 ff ff 
ffff80000010a6ce:	ff d0                	call   *%rax
  outb(COM1+1, 0);
ffff80000010a6d0:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a6d5:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a6da:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a6e1:	80 ff ff 
ffff80000010a6e4:	ff d0                	call   *%rax
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffff80000010a6e6:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010a6eb:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a6f0:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a6f7:	80 ff ff 
ffff80000010a6fa:	ff d0                	call   *%rax
  outb(COM1+4, 0);
ffff80000010a6fc:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a701:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff80000010a706:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a70d:	80 ff ff 
ffff80000010a710:	ff d0                	call   *%rax
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffff80000010a712:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010a717:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a71c:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a723:	80 ff ff 
ffff80000010a726:	ff d0                	call   *%rax

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffff80000010a728:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a72d:	48 b8 49 a6 10 00 00 	movabs $0xffff80000010a649,%rax
ffff80000010a734:	80 ff ff 
ffff80000010a737:	ff d0                	call   *%rax
ffff80000010a739:	3c ff                	cmp    $0xff,%al
ffff80000010a73b:	74 4a                	je     ffff80000010a787 <uartearlyinit+0x101>
    return;
  uart = 1;
ffff80000010a73d:	48 b8 4c 01 12 00 00 	movabs $0xffff80000012014c,%rax
ffff80000010a744:	80 ff ff 
ffff80000010a747:	c7 00 01 00 00 00    	movl   $0x1,(%rax)



  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffff80000010a74d:	48 b8 9b cd 10 00 00 	movabs $0xffff80000010cd9b,%rax
ffff80000010a754:	80 ff ff 
ffff80000010a757:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010a75b:	eb 1d                	jmp    ffff80000010a77a <uartearlyinit+0xf4>
    uartputc(*p);
ffff80000010a75d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a761:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a764:	0f be c0             	movsbl %al,%eax
ffff80000010a767:	89 c7                	mov    %eax,%edi
ffff80000010a769:	48 b8 db a7 10 00 00 	movabs $0xffff80000010a7db,%rax
ffff80000010a770:	80 ff ff 
ffff80000010a773:	ff d0                	call   *%rax
  for(p="xv6...\n"; *p; p++)
ffff80000010a775:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010a77a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a77e:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a781:	84 c0                	test   %al,%al
ffff80000010a783:	75 d8                	jne    ffff80000010a75d <uartearlyinit+0xd7>
ffff80000010a785:	eb 01                	jmp    ffff80000010a788 <uartearlyinit+0x102>
    return;
ffff80000010a787:	90                   	nop
}
ffff80000010a788:	c9                   	leave
ffff80000010a789:	c3                   	ret

ffff80000010a78a <uartinit>:

void
uartinit(void)
{
ffff80000010a78a:	55                   	push   %rbp
ffff80000010a78b:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a78e:	48 b8 4c 01 12 00 00 	movabs $0xffff80000012014c,%rax
ffff80000010a795:	80 ff ff 
ffff80000010a798:	8b 00                	mov    (%rax),%eax
ffff80000010a79a:	85 c0                	test   %eax,%eax
ffff80000010a79c:	74 3a                	je     ffff80000010a7d8 <uartinit+0x4e>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffff80000010a79e:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a7a3:	48 b8 49 a6 10 00 00 	movabs $0xffff80000010a649,%rax
ffff80000010a7aa:	80 ff ff 
ffff80000010a7ad:	ff d0                	call   *%rax
  inb(COM1+0);
ffff80000010a7af:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a7b4:	48 b8 49 a6 10 00 00 	movabs $0xffff80000010a649,%rax
ffff80000010a7bb:	80 ff ff 
ffff80000010a7be:	ff d0                	call   *%rax
  ioapicenable(IRQ_COM1, 0);
ffff80000010a7c0:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a7c5:	bf 04 00 00 00       	mov    $0x4,%edi
ffff80000010a7ca:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff80000010a7d1:	80 ff ff 
ffff80000010a7d4:	ff d0                	call   *%rax
ffff80000010a7d6:	eb 01                	jmp    ffff80000010a7d9 <uartinit+0x4f>
    return;
ffff80000010a7d8:	90                   	nop

}
ffff80000010a7d9:	5d                   	pop    %rbp
ffff80000010a7da:	c3                   	ret

ffff80000010a7db <uartputc>:
void
uartputc(int c)
{
ffff80000010a7db:	55                   	push   %rbp
ffff80000010a7dc:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a7df:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010a7e3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffff80000010a7e6:	48 b8 4c 01 12 00 00 	movabs $0xffff80000012014c,%rax
ffff80000010a7ed:	80 ff ff 
ffff80000010a7f0:	8b 00                	mov    (%rax),%eax
ffff80000010a7f2:	85 c0                	test   %eax,%eax
ffff80000010a7f4:	74 5a                	je     ffff80000010a850 <uartputc+0x75>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010a7f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a7fd:	eb 15                	jmp    ffff80000010a814 <uartputc+0x39>
    microdelay(10);
ffff80000010a7ff:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff80000010a804:	48 b8 02 48 10 00 00 	movabs $0xffff800000104802,%rax
ffff80000010a80b:	80 ff ff 
ffff80000010a80e:	ff d0                	call   *%rax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010a810:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010a814:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff80000010a818:	7f 1b                	jg     ffff80000010a835 <uartputc+0x5a>
ffff80000010a81a:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a81f:	48 b8 49 a6 10 00 00 	movabs $0xffff80000010a649,%rax
ffff80000010a826:	80 ff ff 
ffff80000010a829:	ff d0                	call   *%rax
ffff80000010a82b:	0f b6 c0             	movzbl %al,%eax
ffff80000010a82e:	83 e0 20             	and    $0x20,%eax
ffff80000010a831:	85 c0                	test   %eax,%eax
ffff80000010a833:	74 ca                	je     ffff80000010a7ff <uartputc+0x24>
  outb(COM1+0, c);
ffff80000010a835:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010a838:	0f b6 c0             	movzbl %al,%eax
ffff80000010a83b:	89 c6                	mov    %eax,%esi
ffff80000010a83d:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a842:	48 b8 67 a6 10 00 00 	movabs $0xffff80000010a667,%rax
ffff80000010a849:	80 ff ff 
ffff80000010a84c:	ff d0                	call   *%rax
ffff80000010a84e:	eb 01                	jmp    ffff80000010a851 <uartputc+0x76>
    return;
ffff80000010a850:	90                   	nop
}
ffff80000010a851:	c9                   	leave
ffff80000010a852:	c3                   	ret

ffff80000010a853 <uartgetc>:

static int
uartgetc(void)
{
ffff80000010a853:	55                   	push   %rbp
ffff80000010a854:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a857:	48 b8 4c 01 12 00 00 	movabs $0xffff80000012014c,%rax
ffff80000010a85e:	80 ff ff 
ffff80000010a861:	8b 00                	mov    (%rax),%eax
ffff80000010a863:	85 c0                	test   %eax,%eax
ffff80000010a865:	75 07                	jne    ffff80000010a86e <uartgetc+0x1b>
    return -1;
ffff80000010a867:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a86c:	eb 36                	jmp    ffff80000010a8a4 <uartgetc+0x51>
  if(!(inb(COM1+5) & 0x01))
ffff80000010a86e:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a873:	48 b8 49 a6 10 00 00 	movabs $0xffff80000010a649,%rax
ffff80000010a87a:	80 ff ff 
ffff80000010a87d:	ff d0                	call   *%rax
ffff80000010a87f:	0f b6 c0             	movzbl %al,%eax
ffff80000010a882:	83 e0 01             	and    $0x1,%eax
ffff80000010a885:	85 c0                	test   %eax,%eax
ffff80000010a887:	75 07                	jne    ffff80000010a890 <uartgetc+0x3d>
    return -1;
ffff80000010a889:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a88e:	eb 14                	jmp    ffff80000010a8a4 <uartgetc+0x51>
  return inb(COM1+0);
ffff80000010a890:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a895:	48 b8 49 a6 10 00 00 	movabs $0xffff80000010a649,%rax
ffff80000010a89c:	80 ff ff 
ffff80000010a89f:	ff d0                	call   *%rax
ffff80000010a8a1:	0f b6 c0             	movzbl %al,%eax
}
ffff80000010a8a4:	5d                   	pop    %rbp
ffff80000010a8a5:	c3                   	ret

ffff80000010a8a6 <uartintr>:

void
uartintr(void)
{
ffff80000010a8a6:	55                   	push   %rbp
ffff80000010a8a7:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffff80000010a8aa:	48 b8 53 a8 10 00 00 	movabs $0xffff80000010a853,%rax
ffff80000010a8b1:	80 ff ff 
ffff80000010a8b4:	48 89 c7             	mov    %rax,%rdi
ffff80000010a8b7:	48 b8 6f 0f 10 00 00 	movabs $0xffff800000100f6f,%rax
ffff80000010a8be:	80 ff ff 
ffff80000010a8c1:	ff d0                	call   *%rax
}
ffff80000010a8c3:	90                   	nop
ffff80000010a8c4:	5d                   	pop    %rbp
ffff80000010a8c5:	c3                   	ret

ffff80000010a8c6 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.global alltraps
vector0:
  push $0
ffff80000010a8c6:	6a 00                	push   $0x0
  push $0
ffff80000010a8c8:	6a 00                	push   $0x0
  jmp alltraps
ffff80000010a8ca:	e9 a3 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a8cf <vector1>:
vector1:
  push $0
ffff80000010a8cf:	6a 00                	push   $0x0
  push $1
ffff80000010a8d1:	6a 01                	push   $0x1
  jmp alltraps
ffff80000010a8d3:	e9 9a f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a8d8 <vector2>:
vector2:
  push $0
ffff80000010a8d8:	6a 00                	push   $0x0
  push $2
ffff80000010a8da:	6a 02                	push   $0x2
  jmp alltraps
ffff80000010a8dc:	e9 91 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a8e1 <vector3>:
vector3:
  push $0
ffff80000010a8e1:	6a 00                	push   $0x0
  push $3
ffff80000010a8e3:	6a 03                	push   $0x3
  jmp alltraps
ffff80000010a8e5:	e9 88 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a8ea <vector4>:
vector4:
  push $0
ffff80000010a8ea:	6a 00                	push   $0x0
  push $4
ffff80000010a8ec:	6a 04                	push   $0x4
  jmp alltraps
ffff80000010a8ee:	e9 7f f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a8f3 <vector5>:
vector5:
  push $0
ffff80000010a8f3:	6a 00                	push   $0x0
  push $5
ffff80000010a8f5:	6a 05                	push   $0x5
  jmp alltraps
ffff80000010a8f7:	e9 76 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a8fc <vector6>:
vector6:
  push $0
ffff80000010a8fc:	6a 00                	push   $0x0
  push $6
ffff80000010a8fe:	6a 06                	push   $0x6
  jmp alltraps
ffff80000010a900:	e9 6d f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a905 <vector7>:
vector7:
  push $0
ffff80000010a905:	6a 00                	push   $0x0
  push $7
ffff80000010a907:	6a 07                	push   $0x7
  jmp alltraps
ffff80000010a909:	e9 64 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a90e <vector8>:
vector8:
  push $8
ffff80000010a90e:	6a 08                	push   $0x8
  jmp alltraps
ffff80000010a910:	e9 5d f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a915 <vector9>:
vector9:
  push $0
ffff80000010a915:	6a 00                	push   $0x0
  push $9
ffff80000010a917:	6a 09                	push   $0x9
  jmp alltraps
ffff80000010a919:	e9 54 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a91e <vector10>:
vector10:
  push $10
ffff80000010a91e:	6a 0a                	push   $0xa
  jmp alltraps
ffff80000010a920:	e9 4d f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a925 <vector11>:
vector11:
  push $11
ffff80000010a925:	6a 0b                	push   $0xb
  jmp alltraps
ffff80000010a927:	e9 46 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a92c <vector12>:
vector12:
  push $12
ffff80000010a92c:	6a 0c                	push   $0xc
  jmp alltraps
ffff80000010a92e:	e9 3f f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a933 <vector13>:
vector13:
  push $13
ffff80000010a933:	6a 0d                	push   $0xd
  jmp alltraps
ffff80000010a935:	e9 38 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a93a <vector14>:
vector14:
  push $14
ffff80000010a93a:	6a 0e                	push   $0xe
  jmp alltraps
ffff80000010a93c:	e9 31 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a941 <vector15>:
vector15:
  push $0
ffff80000010a941:	6a 00                	push   $0x0
  push $15
ffff80000010a943:	6a 0f                	push   $0xf
  jmp alltraps
ffff80000010a945:	e9 28 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a94a <vector16>:
vector16:
  push $0
ffff80000010a94a:	6a 00                	push   $0x0
  push $16
ffff80000010a94c:	6a 10                	push   $0x10
  jmp alltraps
ffff80000010a94e:	e9 1f f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a953 <vector17>:
vector17:
  push $17
ffff80000010a953:	6a 11                	push   $0x11
  jmp alltraps
ffff80000010a955:	e9 18 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a95a <vector18>:
vector18:
  push $0
ffff80000010a95a:	6a 00                	push   $0x0
  push $18
ffff80000010a95c:	6a 12                	push   $0x12
  jmp alltraps
ffff80000010a95e:	e9 0f f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a963 <vector19>:
vector19:
  push $0
ffff80000010a963:	6a 00                	push   $0x0
  push $19
ffff80000010a965:	6a 13                	push   $0x13
  jmp alltraps
ffff80000010a967:	e9 06 f6 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a96c <vector20>:
vector20:
  push $0
ffff80000010a96c:	6a 00                	push   $0x0
  push $20
ffff80000010a96e:	6a 14                	push   $0x14
  jmp alltraps
ffff80000010a970:	e9 fd f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a975 <vector21>:
vector21:
  push $0
ffff80000010a975:	6a 00                	push   $0x0
  push $21
ffff80000010a977:	6a 15                	push   $0x15
  jmp alltraps
ffff80000010a979:	e9 f4 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a97e <vector22>:
vector22:
  push $0
ffff80000010a97e:	6a 00                	push   $0x0
  push $22
ffff80000010a980:	6a 16                	push   $0x16
  jmp alltraps
ffff80000010a982:	e9 eb f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a987 <vector23>:
vector23:
  push $0
ffff80000010a987:	6a 00                	push   $0x0
  push $23
ffff80000010a989:	6a 17                	push   $0x17
  jmp alltraps
ffff80000010a98b:	e9 e2 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a990 <vector24>:
vector24:
  push $0
ffff80000010a990:	6a 00                	push   $0x0
  push $24
ffff80000010a992:	6a 18                	push   $0x18
  jmp alltraps
ffff80000010a994:	e9 d9 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a999 <vector25>:
vector25:
  push $0
ffff80000010a999:	6a 00                	push   $0x0
  push $25
ffff80000010a99b:	6a 19                	push   $0x19
  jmp alltraps
ffff80000010a99d:	e9 d0 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9a2 <vector26>:
vector26:
  push $0
ffff80000010a9a2:	6a 00                	push   $0x0
  push $26
ffff80000010a9a4:	6a 1a                	push   $0x1a
  jmp alltraps
ffff80000010a9a6:	e9 c7 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9ab <vector27>:
vector27:
  push $0
ffff80000010a9ab:	6a 00                	push   $0x0
  push $27
ffff80000010a9ad:	6a 1b                	push   $0x1b
  jmp alltraps
ffff80000010a9af:	e9 be f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9b4 <vector28>:
vector28:
  push $0
ffff80000010a9b4:	6a 00                	push   $0x0
  push $28
ffff80000010a9b6:	6a 1c                	push   $0x1c
  jmp alltraps
ffff80000010a9b8:	e9 b5 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9bd <vector29>:
vector29:
  push $0
ffff80000010a9bd:	6a 00                	push   $0x0
  push $29
ffff80000010a9bf:	6a 1d                	push   $0x1d
  jmp alltraps
ffff80000010a9c1:	e9 ac f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9c6 <vector30>:
vector30:
  push $0
ffff80000010a9c6:	6a 00                	push   $0x0
  push $30
ffff80000010a9c8:	6a 1e                	push   $0x1e
  jmp alltraps
ffff80000010a9ca:	e9 a3 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9cf <vector31>:
vector31:
  push $0
ffff80000010a9cf:	6a 00                	push   $0x0
  push $31
ffff80000010a9d1:	6a 1f                	push   $0x1f
  jmp alltraps
ffff80000010a9d3:	e9 9a f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9d8 <vector32>:
vector32:
  push $0
ffff80000010a9d8:	6a 00                	push   $0x0
  push $32
ffff80000010a9da:	6a 20                	push   $0x20
  jmp alltraps
ffff80000010a9dc:	e9 91 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9e1 <vector33>:
vector33:
  push $0
ffff80000010a9e1:	6a 00                	push   $0x0
  push $33
ffff80000010a9e3:	6a 21                	push   $0x21
  jmp alltraps
ffff80000010a9e5:	e9 88 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9ea <vector34>:
vector34:
  push $0
ffff80000010a9ea:	6a 00                	push   $0x0
  push $34
ffff80000010a9ec:	6a 22                	push   $0x22
  jmp alltraps
ffff80000010a9ee:	e9 7f f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9f3 <vector35>:
vector35:
  push $0
ffff80000010a9f3:	6a 00                	push   $0x0
  push $35
ffff80000010a9f5:	6a 23                	push   $0x23
  jmp alltraps
ffff80000010a9f7:	e9 76 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010a9fc <vector36>:
vector36:
  push $0
ffff80000010a9fc:	6a 00                	push   $0x0
  push $36
ffff80000010a9fe:	6a 24                	push   $0x24
  jmp alltraps
ffff80000010aa00:	e9 6d f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa05 <vector37>:
vector37:
  push $0
ffff80000010aa05:	6a 00                	push   $0x0
  push $37
ffff80000010aa07:	6a 25                	push   $0x25
  jmp alltraps
ffff80000010aa09:	e9 64 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa0e <vector38>:
vector38:
  push $0
ffff80000010aa0e:	6a 00                	push   $0x0
  push $38
ffff80000010aa10:	6a 26                	push   $0x26
  jmp alltraps
ffff80000010aa12:	e9 5b f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa17 <vector39>:
vector39:
  push $0
ffff80000010aa17:	6a 00                	push   $0x0
  push $39
ffff80000010aa19:	6a 27                	push   $0x27
  jmp alltraps
ffff80000010aa1b:	e9 52 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa20 <vector40>:
vector40:
  push $0
ffff80000010aa20:	6a 00                	push   $0x0
  push $40
ffff80000010aa22:	6a 28                	push   $0x28
  jmp alltraps
ffff80000010aa24:	e9 49 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa29 <vector41>:
vector41:
  push $0
ffff80000010aa29:	6a 00                	push   $0x0
  push $41
ffff80000010aa2b:	6a 29                	push   $0x29
  jmp alltraps
ffff80000010aa2d:	e9 40 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa32 <vector42>:
vector42:
  push $0
ffff80000010aa32:	6a 00                	push   $0x0
  push $42
ffff80000010aa34:	6a 2a                	push   $0x2a
  jmp alltraps
ffff80000010aa36:	e9 37 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa3b <vector43>:
vector43:
  push $0
ffff80000010aa3b:	6a 00                	push   $0x0
  push $43
ffff80000010aa3d:	6a 2b                	push   $0x2b
  jmp alltraps
ffff80000010aa3f:	e9 2e f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa44 <vector44>:
vector44:
  push $0
ffff80000010aa44:	6a 00                	push   $0x0
  push $44
ffff80000010aa46:	6a 2c                	push   $0x2c
  jmp alltraps
ffff80000010aa48:	e9 25 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa4d <vector45>:
vector45:
  push $0
ffff80000010aa4d:	6a 00                	push   $0x0
  push $45
ffff80000010aa4f:	6a 2d                	push   $0x2d
  jmp alltraps
ffff80000010aa51:	e9 1c f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa56 <vector46>:
vector46:
  push $0
ffff80000010aa56:	6a 00                	push   $0x0
  push $46
ffff80000010aa58:	6a 2e                	push   $0x2e
  jmp alltraps
ffff80000010aa5a:	e9 13 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa5f <vector47>:
vector47:
  push $0
ffff80000010aa5f:	6a 00                	push   $0x0
  push $47
ffff80000010aa61:	6a 2f                	push   $0x2f
  jmp alltraps
ffff80000010aa63:	e9 0a f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa68 <vector48>:
vector48:
  push $0
ffff80000010aa68:	6a 00                	push   $0x0
  push $48
ffff80000010aa6a:	6a 30                	push   $0x30
  jmp alltraps
ffff80000010aa6c:	e9 01 f5 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa71 <vector49>:
vector49:
  push $0
ffff80000010aa71:	6a 00                	push   $0x0
  push $49
ffff80000010aa73:	6a 31                	push   $0x31
  jmp alltraps
ffff80000010aa75:	e9 f8 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa7a <vector50>:
vector50:
  push $0
ffff80000010aa7a:	6a 00                	push   $0x0
  push $50
ffff80000010aa7c:	6a 32                	push   $0x32
  jmp alltraps
ffff80000010aa7e:	e9 ef f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa83 <vector51>:
vector51:
  push $0
ffff80000010aa83:	6a 00                	push   $0x0
  push $51
ffff80000010aa85:	6a 33                	push   $0x33
  jmp alltraps
ffff80000010aa87:	e9 e6 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa8c <vector52>:
vector52:
  push $0
ffff80000010aa8c:	6a 00                	push   $0x0
  push $52
ffff80000010aa8e:	6a 34                	push   $0x34
  jmp alltraps
ffff80000010aa90:	e9 dd f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa95 <vector53>:
vector53:
  push $0
ffff80000010aa95:	6a 00                	push   $0x0
  push $53
ffff80000010aa97:	6a 35                	push   $0x35
  jmp alltraps
ffff80000010aa99:	e9 d4 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aa9e <vector54>:
vector54:
  push $0
ffff80000010aa9e:	6a 00                	push   $0x0
  push $54
ffff80000010aaa0:	6a 36                	push   $0x36
  jmp alltraps
ffff80000010aaa2:	e9 cb f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aaa7 <vector55>:
vector55:
  push $0
ffff80000010aaa7:	6a 00                	push   $0x0
  push $55
ffff80000010aaa9:	6a 37                	push   $0x37
  jmp alltraps
ffff80000010aaab:	e9 c2 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aab0 <vector56>:
vector56:
  push $0
ffff80000010aab0:	6a 00                	push   $0x0
  push $56
ffff80000010aab2:	6a 38                	push   $0x38
  jmp alltraps
ffff80000010aab4:	e9 b9 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aab9 <vector57>:
vector57:
  push $0
ffff80000010aab9:	6a 00                	push   $0x0
  push $57
ffff80000010aabb:	6a 39                	push   $0x39
  jmp alltraps
ffff80000010aabd:	e9 b0 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aac2 <vector58>:
vector58:
  push $0
ffff80000010aac2:	6a 00                	push   $0x0
  push $58
ffff80000010aac4:	6a 3a                	push   $0x3a
  jmp alltraps
ffff80000010aac6:	e9 a7 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aacb <vector59>:
vector59:
  push $0
ffff80000010aacb:	6a 00                	push   $0x0
  push $59
ffff80000010aacd:	6a 3b                	push   $0x3b
  jmp alltraps
ffff80000010aacf:	e9 9e f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aad4 <vector60>:
vector60:
  push $0
ffff80000010aad4:	6a 00                	push   $0x0
  push $60
ffff80000010aad6:	6a 3c                	push   $0x3c
  jmp alltraps
ffff80000010aad8:	e9 95 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aadd <vector61>:
vector61:
  push $0
ffff80000010aadd:	6a 00                	push   $0x0
  push $61
ffff80000010aadf:	6a 3d                	push   $0x3d
  jmp alltraps
ffff80000010aae1:	e9 8c f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aae6 <vector62>:
vector62:
  push $0
ffff80000010aae6:	6a 00                	push   $0x0
  push $62
ffff80000010aae8:	6a 3e                	push   $0x3e
  jmp alltraps
ffff80000010aaea:	e9 83 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aaef <vector63>:
vector63:
  push $0
ffff80000010aaef:	6a 00                	push   $0x0
  push $63
ffff80000010aaf1:	6a 3f                	push   $0x3f
  jmp alltraps
ffff80000010aaf3:	e9 7a f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aaf8 <vector64>:
vector64:
  push $0
ffff80000010aaf8:	6a 00                	push   $0x0
  push $64
ffff80000010aafa:	6a 40                	push   $0x40
  jmp alltraps
ffff80000010aafc:	e9 71 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab01 <vector65>:
vector65:
  push $0
ffff80000010ab01:	6a 00                	push   $0x0
  push $65
ffff80000010ab03:	6a 41                	push   $0x41
  jmp alltraps
ffff80000010ab05:	e9 68 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab0a <vector66>:
vector66:
  push $0
ffff80000010ab0a:	6a 00                	push   $0x0
  push $66
ffff80000010ab0c:	6a 42                	push   $0x42
  jmp alltraps
ffff80000010ab0e:	e9 5f f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab13 <vector67>:
vector67:
  push $0
ffff80000010ab13:	6a 00                	push   $0x0
  push $67
ffff80000010ab15:	6a 43                	push   $0x43
  jmp alltraps
ffff80000010ab17:	e9 56 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab1c <vector68>:
vector68:
  push $0
ffff80000010ab1c:	6a 00                	push   $0x0
  push $68
ffff80000010ab1e:	6a 44                	push   $0x44
  jmp alltraps
ffff80000010ab20:	e9 4d f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab25 <vector69>:
vector69:
  push $0
ffff80000010ab25:	6a 00                	push   $0x0
  push $69
ffff80000010ab27:	6a 45                	push   $0x45
  jmp alltraps
ffff80000010ab29:	e9 44 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab2e <vector70>:
vector70:
  push $0
ffff80000010ab2e:	6a 00                	push   $0x0
  push $70
ffff80000010ab30:	6a 46                	push   $0x46
  jmp alltraps
ffff80000010ab32:	e9 3b f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab37 <vector71>:
vector71:
  push $0
ffff80000010ab37:	6a 00                	push   $0x0
  push $71
ffff80000010ab39:	6a 47                	push   $0x47
  jmp alltraps
ffff80000010ab3b:	e9 32 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab40 <vector72>:
vector72:
  push $0
ffff80000010ab40:	6a 00                	push   $0x0
  push $72
ffff80000010ab42:	6a 48                	push   $0x48
  jmp alltraps
ffff80000010ab44:	e9 29 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab49 <vector73>:
vector73:
  push $0
ffff80000010ab49:	6a 00                	push   $0x0
  push $73
ffff80000010ab4b:	6a 49                	push   $0x49
  jmp alltraps
ffff80000010ab4d:	e9 20 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab52 <vector74>:
vector74:
  push $0
ffff80000010ab52:	6a 00                	push   $0x0
  push $74
ffff80000010ab54:	6a 4a                	push   $0x4a
  jmp alltraps
ffff80000010ab56:	e9 17 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab5b <vector75>:
vector75:
  push $0
ffff80000010ab5b:	6a 00                	push   $0x0
  push $75
ffff80000010ab5d:	6a 4b                	push   $0x4b
  jmp alltraps
ffff80000010ab5f:	e9 0e f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab64 <vector76>:
vector76:
  push $0
ffff80000010ab64:	6a 00                	push   $0x0
  push $76
ffff80000010ab66:	6a 4c                	push   $0x4c
  jmp alltraps
ffff80000010ab68:	e9 05 f4 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab6d <vector77>:
vector77:
  push $0
ffff80000010ab6d:	6a 00                	push   $0x0
  push $77
ffff80000010ab6f:	6a 4d                	push   $0x4d
  jmp alltraps
ffff80000010ab71:	e9 fc f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab76 <vector78>:
vector78:
  push $0
ffff80000010ab76:	6a 00                	push   $0x0
  push $78
ffff80000010ab78:	6a 4e                	push   $0x4e
  jmp alltraps
ffff80000010ab7a:	e9 f3 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab7f <vector79>:
vector79:
  push $0
ffff80000010ab7f:	6a 00                	push   $0x0
  push $79
ffff80000010ab81:	6a 4f                	push   $0x4f
  jmp alltraps
ffff80000010ab83:	e9 ea f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab88 <vector80>:
vector80:
  push $0
ffff80000010ab88:	6a 00                	push   $0x0
  push $80
ffff80000010ab8a:	6a 50                	push   $0x50
  jmp alltraps
ffff80000010ab8c:	e9 e1 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab91 <vector81>:
vector81:
  push $0
ffff80000010ab91:	6a 00                	push   $0x0
  push $81
ffff80000010ab93:	6a 51                	push   $0x51
  jmp alltraps
ffff80000010ab95:	e9 d8 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ab9a <vector82>:
vector82:
  push $0
ffff80000010ab9a:	6a 00                	push   $0x0
  push $82
ffff80000010ab9c:	6a 52                	push   $0x52
  jmp alltraps
ffff80000010ab9e:	e9 cf f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aba3 <vector83>:
vector83:
  push $0
ffff80000010aba3:	6a 00                	push   $0x0
  push $83
ffff80000010aba5:	6a 53                	push   $0x53
  jmp alltraps
ffff80000010aba7:	e9 c6 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abac <vector84>:
vector84:
  push $0
ffff80000010abac:	6a 00                	push   $0x0
  push $84
ffff80000010abae:	6a 54                	push   $0x54
  jmp alltraps
ffff80000010abb0:	e9 bd f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abb5 <vector85>:
vector85:
  push $0
ffff80000010abb5:	6a 00                	push   $0x0
  push $85
ffff80000010abb7:	6a 55                	push   $0x55
  jmp alltraps
ffff80000010abb9:	e9 b4 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abbe <vector86>:
vector86:
  push $0
ffff80000010abbe:	6a 00                	push   $0x0
  push $86
ffff80000010abc0:	6a 56                	push   $0x56
  jmp alltraps
ffff80000010abc2:	e9 ab f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abc7 <vector87>:
vector87:
  push $0
ffff80000010abc7:	6a 00                	push   $0x0
  push $87
ffff80000010abc9:	6a 57                	push   $0x57
  jmp alltraps
ffff80000010abcb:	e9 a2 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abd0 <vector88>:
vector88:
  push $0
ffff80000010abd0:	6a 00                	push   $0x0
  push $88
ffff80000010abd2:	6a 58                	push   $0x58
  jmp alltraps
ffff80000010abd4:	e9 99 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abd9 <vector89>:
vector89:
  push $0
ffff80000010abd9:	6a 00                	push   $0x0
  push $89
ffff80000010abdb:	6a 59                	push   $0x59
  jmp alltraps
ffff80000010abdd:	e9 90 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abe2 <vector90>:
vector90:
  push $0
ffff80000010abe2:	6a 00                	push   $0x0
  push $90
ffff80000010abe4:	6a 5a                	push   $0x5a
  jmp alltraps
ffff80000010abe6:	e9 87 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abeb <vector91>:
vector91:
  push $0
ffff80000010abeb:	6a 00                	push   $0x0
  push $91
ffff80000010abed:	6a 5b                	push   $0x5b
  jmp alltraps
ffff80000010abef:	e9 7e f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abf4 <vector92>:
vector92:
  push $0
ffff80000010abf4:	6a 00                	push   $0x0
  push $92
ffff80000010abf6:	6a 5c                	push   $0x5c
  jmp alltraps
ffff80000010abf8:	e9 75 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010abfd <vector93>:
vector93:
  push $0
ffff80000010abfd:	6a 00                	push   $0x0
  push $93
ffff80000010abff:	6a 5d                	push   $0x5d
  jmp alltraps
ffff80000010ac01:	e9 6c f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac06 <vector94>:
vector94:
  push $0
ffff80000010ac06:	6a 00                	push   $0x0
  push $94
ffff80000010ac08:	6a 5e                	push   $0x5e
  jmp alltraps
ffff80000010ac0a:	e9 63 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac0f <vector95>:
vector95:
  push $0
ffff80000010ac0f:	6a 00                	push   $0x0
  push $95
ffff80000010ac11:	6a 5f                	push   $0x5f
  jmp alltraps
ffff80000010ac13:	e9 5a f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac18 <vector96>:
vector96:
  push $0
ffff80000010ac18:	6a 00                	push   $0x0
  push $96
ffff80000010ac1a:	6a 60                	push   $0x60
  jmp alltraps
ffff80000010ac1c:	e9 51 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac21 <vector97>:
vector97:
  push $0
ffff80000010ac21:	6a 00                	push   $0x0
  push $97
ffff80000010ac23:	6a 61                	push   $0x61
  jmp alltraps
ffff80000010ac25:	e9 48 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac2a <vector98>:
vector98:
  push $0
ffff80000010ac2a:	6a 00                	push   $0x0
  push $98
ffff80000010ac2c:	6a 62                	push   $0x62
  jmp alltraps
ffff80000010ac2e:	e9 3f f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac33 <vector99>:
vector99:
  push $0
ffff80000010ac33:	6a 00                	push   $0x0
  push $99
ffff80000010ac35:	6a 63                	push   $0x63
  jmp alltraps
ffff80000010ac37:	e9 36 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac3c <vector100>:
vector100:
  push $0
ffff80000010ac3c:	6a 00                	push   $0x0
  push $100
ffff80000010ac3e:	6a 64                	push   $0x64
  jmp alltraps
ffff80000010ac40:	e9 2d f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac45 <vector101>:
vector101:
  push $0
ffff80000010ac45:	6a 00                	push   $0x0
  push $101
ffff80000010ac47:	6a 65                	push   $0x65
  jmp alltraps
ffff80000010ac49:	e9 24 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac4e <vector102>:
vector102:
  push $0
ffff80000010ac4e:	6a 00                	push   $0x0
  push $102
ffff80000010ac50:	6a 66                	push   $0x66
  jmp alltraps
ffff80000010ac52:	e9 1b f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac57 <vector103>:
vector103:
  push $0
ffff80000010ac57:	6a 00                	push   $0x0
  push $103
ffff80000010ac59:	6a 67                	push   $0x67
  jmp alltraps
ffff80000010ac5b:	e9 12 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac60 <vector104>:
vector104:
  push $0
ffff80000010ac60:	6a 00                	push   $0x0
  push $104
ffff80000010ac62:	6a 68                	push   $0x68
  jmp alltraps
ffff80000010ac64:	e9 09 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac69 <vector105>:
vector105:
  push $0
ffff80000010ac69:	6a 00                	push   $0x0
  push $105
ffff80000010ac6b:	6a 69                	push   $0x69
  jmp alltraps
ffff80000010ac6d:	e9 00 f3 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac72 <vector106>:
vector106:
  push $0
ffff80000010ac72:	6a 00                	push   $0x0
  push $106
ffff80000010ac74:	6a 6a                	push   $0x6a
  jmp alltraps
ffff80000010ac76:	e9 f7 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac7b <vector107>:
vector107:
  push $0
ffff80000010ac7b:	6a 00                	push   $0x0
  push $107
ffff80000010ac7d:	6a 6b                	push   $0x6b
  jmp alltraps
ffff80000010ac7f:	e9 ee f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac84 <vector108>:
vector108:
  push $0
ffff80000010ac84:	6a 00                	push   $0x0
  push $108
ffff80000010ac86:	6a 6c                	push   $0x6c
  jmp alltraps
ffff80000010ac88:	e9 e5 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac8d <vector109>:
vector109:
  push $0
ffff80000010ac8d:	6a 00                	push   $0x0
  push $109
ffff80000010ac8f:	6a 6d                	push   $0x6d
  jmp alltraps
ffff80000010ac91:	e9 dc f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac96 <vector110>:
vector110:
  push $0
ffff80000010ac96:	6a 00                	push   $0x0
  push $110
ffff80000010ac98:	6a 6e                	push   $0x6e
  jmp alltraps
ffff80000010ac9a:	e9 d3 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ac9f <vector111>:
vector111:
  push $0
ffff80000010ac9f:	6a 00                	push   $0x0
  push $111
ffff80000010aca1:	6a 6f                	push   $0x6f
  jmp alltraps
ffff80000010aca3:	e9 ca f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aca8 <vector112>:
vector112:
  push $0
ffff80000010aca8:	6a 00                	push   $0x0
  push $112
ffff80000010acaa:	6a 70                	push   $0x70
  jmp alltraps
ffff80000010acac:	e9 c1 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acb1 <vector113>:
vector113:
  push $0
ffff80000010acb1:	6a 00                	push   $0x0
  push $113
ffff80000010acb3:	6a 71                	push   $0x71
  jmp alltraps
ffff80000010acb5:	e9 b8 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acba <vector114>:
vector114:
  push $0
ffff80000010acba:	6a 00                	push   $0x0
  push $114
ffff80000010acbc:	6a 72                	push   $0x72
  jmp alltraps
ffff80000010acbe:	e9 af f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acc3 <vector115>:
vector115:
  push $0
ffff80000010acc3:	6a 00                	push   $0x0
  push $115
ffff80000010acc5:	6a 73                	push   $0x73
  jmp alltraps
ffff80000010acc7:	e9 a6 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010accc <vector116>:
vector116:
  push $0
ffff80000010accc:	6a 00                	push   $0x0
  push $116
ffff80000010acce:	6a 74                	push   $0x74
  jmp alltraps
ffff80000010acd0:	e9 9d f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acd5 <vector117>:
vector117:
  push $0
ffff80000010acd5:	6a 00                	push   $0x0
  push $117
ffff80000010acd7:	6a 75                	push   $0x75
  jmp alltraps
ffff80000010acd9:	e9 94 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acde <vector118>:
vector118:
  push $0
ffff80000010acde:	6a 00                	push   $0x0
  push $118
ffff80000010ace0:	6a 76                	push   $0x76
  jmp alltraps
ffff80000010ace2:	e9 8b f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ace7 <vector119>:
vector119:
  push $0
ffff80000010ace7:	6a 00                	push   $0x0
  push $119
ffff80000010ace9:	6a 77                	push   $0x77
  jmp alltraps
ffff80000010aceb:	e9 82 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acf0 <vector120>:
vector120:
  push $0
ffff80000010acf0:	6a 00                	push   $0x0
  push $120
ffff80000010acf2:	6a 78                	push   $0x78
  jmp alltraps
ffff80000010acf4:	e9 79 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010acf9 <vector121>:
vector121:
  push $0
ffff80000010acf9:	6a 00                	push   $0x0
  push $121
ffff80000010acfb:	6a 79                	push   $0x79
  jmp alltraps
ffff80000010acfd:	e9 70 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad02 <vector122>:
vector122:
  push $0
ffff80000010ad02:	6a 00                	push   $0x0
  push $122
ffff80000010ad04:	6a 7a                	push   $0x7a
  jmp alltraps
ffff80000010ad06:	e9 67 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad0b <vector123>:
vector123:
  push $0
ffff80000010ad0b:	6a 00                	push   $0x0
  push $123
ffff80000010ad0d:	6a 7b                	push   $0x7b
  jmp alltraps
ffff80000010ad0f:	e9 5e f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad14 <vector124>:
vector124:
  push $0
ffff80000010ad14:	6a 00                	push   $0x0
  push $124
ffff80000010ad16:	6a 7c                	push   $0x7c
  jmp alltraps
ffff80000010ad18:	e9 55 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad1d <vector125>:
vector125:
  push $0
ffff80000010ad1d:	6a 00                	push   $0x0
  push $125
ffff80000010ad1f:	6a 7d                	push   $0x7d
  jmp alltraps
ffff80000010ad21:	e9 4c f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad26 <vector126>:
vector126:
  push $0
ffff80000010ad26:	6a 00                	push   $0x0
  push $126
ffff80000010ad28:	6a 7e                	push   $0x7e
  jmp alltraps
ffff80000010ad2a:	e9 43 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad2f <vector127>:
vector127:
  push $0
ffff80000010ad2f:	6a 00                	push   $0x0
  push $127
ffff80000010ad31:	6a 7f                	push   $0x7f
  jmp alltraps
ffff80000010ad33:	e9 3a f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad38 <vector128>:
vector128:
  push $0
ffff80000010ad38:	6a 00                	push   $0x0
  push $128
ffff80000010ad3a:	68 80 00 00 00       	push   $0x80
  jmp alltraps
ffff80000010ad3f:	e9 2e f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad44 <vector129>:
vector129:
  push $0
ffff80000010ad44:	6a 00                	push   $0x0
  push $129
ffff80000010ad46:	68 81 00 00 00       	push   $0x81
  jmp alltraps
ffff80000010ad4b:	e9 22 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad50 <vector130>:
vector130:
  push $0
ffff80000010ad50:	6a 00                	push   $0x0
  push $130
ffff80000010ad52:	68 82 00 00 00       	push   $0x82
  jmp alltraps
ffff80000010ad57:	e9 16 f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad5c <vector131>:
vector131:
  push $0
ffff80000010ad5c:	6a 00                	push   $0x0
  push $131
ffff80000010ad5e:	68 83 00 00 00       	push   $0x83
  jmp alltraps
ffff80000010ad63:	e9 0a f2 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad68 <vector132>:
vector132:
  push $0
ffff80000010ad68:	6a 00                	push   $0x0
  push $132
ffff80000010ad6a:	68 84 00 00 00       	push   $0x84
  jmp alltraps
ffff80000010ad6f:	e9 fe f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad74 <vector133>:
vector133:
  push $0
ffff80000010ad74:	6a 00                	push   $0x0
  push $133
ffff80000010ad76:	68 85 00 00 00       	push   $0x85
  jmp alltraps
ffff80000010ad7b:	e9 f2 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad80 <vector134>:
vector134:
  push $0
ffff80000010ad80:	6a 00                	push   $0x0
  push $134
ffff80000010ad82:	68 86 00 00 00       	push   $0x86
  jmp alltraps
ffff80000010ad87:	e9 e6 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad8c <vector135>:
vector135:
  push $0
ffff80000010ad8c:	6a 00                	push   $0x0
  push $135
ffff80000010ad8e:	68 87 00 00 00       	push   $0x87
  jmp alltraps
ffff80000010ad93:	e9 da f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ad98 <vector136>:
vector136:
  push $0
ffff80000010ad98:	6a 00                	push   $0x0
  push $136
ffff80000010ad9a:	68 88 00 00 00       	push   $0x88
  jmp alltraps
ffff80000010ad9f:	e9 ce f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ada4 <vector137>:
vector137:
  push $0
ffff80000010ada4:	6a 00                	push   $0x0
  push $137
ffff80000010ada6:	68 89 00 00 00       	push   $0x89
  jmp alltraps
ffff80000010adab:	e9 c2 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010adb0 <vector138>:
vector138:
  push $0
ffff80000010adb0:	6a 00                	push   $0x0
  push $138
ffff80000010adb2:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
ffff80000010adb7:	e9 b6 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010adbc <vector139>:
vector139:
  push $0
ffff80000010adbc:	6a 00                	push   $0x0
  push $139
ffff80000010adbe:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
ffff80000010adc3:	e9 aa f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010adc8 <vector140>:
vector140:
  push $0
ffff80000010adc8:	6a 00                	push   $0x0
  push $140
ffff80000010adca:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
ffff80000010adcf:	e9 9e f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010add4 <vector141>:
vector141:
  push $0
ffff80000010add4:	6a 00                	push   $0x0
  push $141
ffff80000010add6:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
ffff80000010addb:	e9 92 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ade0 <vector142>:
vector142:
  push $0
ffff80000010ade0:	6a 00                	push   $0x0
  push $142
ffff80000010ade2:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
ffff80000010ade7:	e9 86 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010adec <vector143>:
vector143:
  push $0
ffff80000010adec:	6a 00                	push   $0x0
  push $143
ffff80000010adee:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
ffff80000010adf3:	e9 7a f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010adf8 <vector144>:
vector144:
  push $0
ffff80000010adf8:	6a 00                	push   $0x0
  push $144
ffff80000010adfa:	68 90 00 00 00       	push   $0x90
  jmp alltraps
ffff80000010adff:	e9 6e f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae04 <vector145>:
vector145:
  push $0
ffff80000010ae04:	6a 00                	push   $0x0
  push $145
ffff80000010ae06:	68 91 00 00 00       	push   $0x91
  jmp alltraps
ffff80000010ae0b:	e9 62 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae10 <vector146>:
vector146:
  push $0
ffff80000010ae10:	6a 00                	push   $0x0
  push $146
ffff80000010ae12:	68 92 00 00 00       	push   $0x92
  jmp alltraps
ffff80000010ae17:	e9 56 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae1c <vector147>:
vector147:
  push $0
ffff80000010ae1c:	6a 00                	push   $0x0
  push $147
ffff80000010ae1e:	68 93 00 00 00       	push   $0x93
  jmp alltraps
ffff80000010ae23:	e9 4a f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae28 <vector148>:
vector148:
  push $0
ffff80000010ae28:	6a 00                	push   $0x0
  push $148
ffff80000010ae2a:	68 94 00 00 00       	push   $0x94
  jmp alltraps
ffff80000010ae2f:	e9 3e f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae34 <vector149>:
vector149:
  push $0
ffff80000010ae34:	6a 00                	push   $0x0
  push $149
ffff80000010ae36:	68 95 00 00 00       	push   $0x95
  jmp alltraps
ffff80000010ae3b:	e9 32 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae40 <vector150>:
vector150:
  push $0
ffff80000010ae40:	6a 00                	push   $0x0
  push $150
ffff80000010ae42:	68 96 00 00 00       	push   $0x96
  jmp alltraps
ffff80000010ae47:	e9 26 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae4c <vector151>:
vector151:
  push $0
ffff80000010ae4c:	6a 00                	push   $0x0
  push $151
ffff80000010ae4e:	68 97 00 00 00       	push   $0x97
  jmp alltraps
ffff80000010ae53:	e9 1a f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae58 <vector152>:
vector152:
  push $0
ffff80000010ae58:	6a 00                	push   $0x0
  push $152
ffff80000010ae5a:	68 98 00 00 00       	push   $0x98
  jmp alltraps
ffff80000010ae5f:	e9 0e f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae64 <vector153>:
vector153:
  push $0
ffff80000010ae64:	6a 00                	push   $0x0
  push $153
ffff80000010ae66:	68 99 00 00 00       	push   $0x99
  jmp alltraps
ffff80000010ae6b:	e9 02 f1 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae70 <vector154>:
vector154:
  push $0
ffff80000010ae70:	6a 00                	push   $0x0
  push $154
ffff80000010ae72:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
ffff80000010ae77:	e9 f6 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae7c <vector155>:
vector155:
  push $0
ffff80000010ae7c:	6a 00                	push   $0x0
  push $155
ffff80000010ae7e:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
ffff80000010ae83:	e9 ea f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae88 <vector156>:
vector156:
  push $0
ffff80000010ae88:	6a 00                	push   $0x0
  push $156
ffff80000010ae8a:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
ffff80000010ae8f:	e9 de f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010ae94 <vector157>:
vector157:
  push $0
ffff80000010ae94:	6a 00                	push   $0x0
  push $157
ffff80000010ae96:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
ffff80000010ae9b:	e9 d2 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aea0 <vector158>:
vector158:
  push $0
ffff80000010aea0:	6a 00                	push   $0x0
  push $158
ffff80000010aea2:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
ffff80000010aea7:	e9 c6 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aeac <vector159>:
vector159:
  push $0
ffff80000010aeac:	6a 00                	push   $0x0
  push $159
ffff80000010aeae:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
ffff80000010aeb3:	e9 ba f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aeb8 <vector160>:
vector160:
  push $0
ffff80000010aeb8:	6a 00                	push   $0x0
  push $160
ffff80000010aeba:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
ffff80000010aebf:	e9 ae f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aec4 <vector161>:
vector161:
  push $0
ffff80000010aec4:	6a 00                	push   $0x0
  push $161
ffff80000010aec6:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
ffff80000010aecb:	e9 a2 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aed0 <vector162>:
vector162:
  push $0
ffff80000010aed0:	6a 00                	push   $0x0
  push $162
ffff80000010aed2:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
ffff80000010aed7:	e9 96 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aedc <vector163>:
vector163:
  push $0
ffff80000010aedc:	6a 00                	push   $0x0
  push $163
ffff80000010aede:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
ffff80000010aee3:	e9 8a f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aee8 <vector164>:
vector164:
  push $0
ffff80000010aee8:	6a 00                	push   $0x0
  push $164
ffff80000010aeea:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
ffff80000010aeef:	e9 7e f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aef4 <vector165>:
vector165:
  push $0
ffff80000010aef4:	6a 00                	push   $0x0
  push $165
ffff80000010aef6:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
ffff80000010aefb:	e9 72 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af00 <vector166>:
vector166:
  push $0
ffff80000010af00:	6a 00                	push   $0x0
  push $166
ffff80000010af02:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
ffff80000010af07:	e9 66 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af0c <vector167>:
vector167:
  push $0
ffff80000010af0c:	6a 00                	push   $0x0
  push $167
ffff80000010af0e:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
ffff80000010af13:	e9 5a f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af18 <vector168>:
vector168:
  push $0
ffff80000010af18:	6a 00                	push   $0x0
  push $168
ffff80000010af1a:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
ffff80000010af1f:	e9 4e f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af24 <vector169>:
vector169:
  push $0
ffff80000010af24:	6a 00                	push   $0x0
  push $169
ffff80000010af26:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
ffff80000010af2b:	e9 42 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af30 <vector170>:
vector170:
  push $0
ffff80000010af30:	6a 00                	push   $0x0
  push $170
ffff80000010af32:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
ffff80000010af37:	e9 36 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af3c <vector171>:
vector171:
  push $0
ffff80000010af3c:	6a 00                	push   $0x0
  push $171
ffff80000010af3e:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
ffff80000010af43:	e9 2a f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af48 <vector172>:
vector172:
  push $0
ffff80000010af48:	6a 00                	push   $0x0
  push $172
ffff80000010af4a:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
ffff80000010af4f:	e9 1e f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af54 <vector173>:
vector173:
  push $0
ffff80000010af54:	6a 00                	push   $0x0
  push $173
ffff80000010af56:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
ffff80000010af5b:	e9 12 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af60 <vector174>:
vector174:
  push $0
ffff80000010af60:	6a 00                	push   $0x0
  push $174
ffff80000010af62:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
ffff80000010af67:	e9 06 f0 ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af6c <vector175>:
vector175:
  push $0
ffff80000010af6c:	6a 00                	push   $0x0
  push $175
ffff80000010af6e:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
ffff80000010af73:	e9 fa ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af78 <vector176>:
vector176:
  push $0
ffff80000010af78:	6a 00                	push   $0x0
  push $176
ffff80000010af7a:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
ffff80000010af7f:	e9 ee ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af84 <vector177>:
vector177:
  push $0
ffff80000010af84:	6a 00                	push   $0x0
  push $177
ffff80000010af86:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
ffff80000010af8b:	e9 e2 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af90 <vector178>:
vector178:
  push $0
ffff80000010af90:	6a 00                	push   $0x0
  push $178
ffff80000010af92:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
ffff80000010af97:	e9 d6 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010af9c <vector179>:
vector179:
  push $0
ffff80000010af9c:	6a 00                	push   $0x0
  push $179
ffff80000010af9e:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
ffff80000010afa3:	e9 ca ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010afa8 <vector180>:
vector180:
  push $0
ffff80000010afa8:	6a 00                	push   $0x0
  push $180
ffff80000010afaa:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
ffff80000010afaf:	e9 be ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010afb4 <vector181>:
vector181:
  push $0
ffff80000010afb4:	6a 00                	push   $0x0
  push $181
ffff80000010afb6:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
ffff80000010afbb:	e9 b2 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010afc0 <vector182>:
vector182:
  push $0
ffff80000010afc0:	6a 00                	push   $0x0
  push $182
ffff80000010afc2:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
ffff80000010afc7:	e9 a6 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010afcc <vector183>:
vector183:
  push $0
ffff80000010afcc:	6a 00                	push   $0x0
  push $183
ffff80000010afce:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
ffff80000010afd3:	e9 9a ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010afd8 <vector184>:
vector184:
  push $0
ffff80000010afd8:	6a 00                	push   $0x0
  push $184
ffff80000010afda:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
ffff80000010afdf:	e9 8e ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010afe4 <vector185>:
vector185:
  push $0
ffff80000010afe4:	6a 00                	push   $0x0
  push $185
ffff80000010afe6:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
ffff80000010afeb:	e9 82 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010aff0 <vector186>:
vector186:
  push $0
ffff80000010aff0:	6a 00                	push   $0x0
  push $186
ffff80000010aff2:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
ffff80000010aff7:	e9 76 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010affc <vector187>:
vector187:
  push $0
ffff80000010affc:	6a 00                	push   $0x0
  push $187
ffff80000010affe:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
ffff80000010b003:	e9 6a ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b008 <vector188>:
vector188:
  push $0
ffff80000010b008:	6a 00                	push   $0x0
  push $188
ffff80000010b00a:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
ffff80000010b00f:	e9 5e ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b014 <vector189>:
vector189:
  push $0
ffff80000010b014:	6a 00                	push   $0x0
  push $189
ffff80000010b016:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
ffff80000010b01b:	e9 52 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b020 <vector190>:
vector190:
  push $0
ffff80000010b020:	6a 00                	push   $0x0
  push $190
ffff80000010b022:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
ffff80000010b027:	e9 46 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b02c <vector191>:
vector191:
  push $0
ffff80000010b02c:	6a 00                	push   $0x0
  push $191
ffff80000010b02e:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
ffff80000010b033:	e9 3a ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b038 <vector192>:
vector192:
  push $0
ffff80000010b038:	6a 00                	push   $0x0
  push $192
ffff80000010b03a:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
ffff80000010b03f:	e9 2e ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b044 <vector193>:
vector193:
  push $0
ffff80000010b044:	6a 00                	push   $0x0
  push $193
ffff80000010b046:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
ffff80000010b04b:	e9 22 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b050 <vector194>:
vector194:
  push $0
ffff80000010b050:	6a 00                	push   $0x0
  push $194
ffff80000010b052:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
ffff80000010b057:	e9 16 ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b05c <vector195>:
vector195:
  push $0
ffff80000010b05c:	6a 00                	push   $0x0
  push $195
ffff80000010b05e:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
ffff80000010b063:	e9 0a ef ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b068 <vector196>:
vector196:
  push $0
ffff80000010b068:	6a 00                	push   $0x0
  push $196
ffff80000010b06a:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
ffff80000010b06f:	e9 fe ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b074 <vector197>:
vector197:
  push $0
ffff80000010b074:	6a 00                	push   $0x0
  push $197
ffff80000010b076:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
ffff80000010b07b:	e9 f2 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b080 <vector198>:
vector198:
  push $0
ffff80000010b080:	6a 00                	push   $0x0
  push $198
ffff80000010b082:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
ffff80000010b087:	e9 e6 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b08c <vector199>:
vector199:
  push $0
ffff80000010b08c:	6a 00                	push   $0x0
  push $199
ffff80000010b08e:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
ffff80000010b093:	e9 da ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b098 <vector200>:
vector200:
  push $0
ffff80000010b098:	6a 00                	push   $0x0
  push $200
ffff80000010b09a:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
ffff80000010b09f:	e9 ce ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0a4 <vector201>:
vector201:
  push $0
ffff80000010b0a4:	6a 00                	push   $0x0
  push $201
ffff80000010b0a6:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
ffff80000010b0ab:	e9 c2 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0b0 <vector202>:
vector202:
  push $0
ffff80000010b0b0:	6a 00                	push   $0x0
  push $202
ffff80000010b0b2:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
ffff80000010b0b7:	e9 b6 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0bc <vector203>:
vector203:
  push $0
ffff80000010b0bc:	6a 00                	push   $0x0
  push $203
ffff80000010b0be:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
ffff80000010b0c3:	e9 aa ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0c8 <vector204>:
vector204:
  push $0
ffff80000010b0c8:	6a 00                	push   $0x0
  push $204
ffff80000010b0ca:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
ffff80000010b0cf:	e9 9e ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0d4 <vector205>:
vector205:
  push $0
ffff80000010b0d4:	6a 00                	push   $0x0
  push $205
ffff80000010b0d6:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
ffff80000010b0db:	e9 92 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0e0 <vector206>:
vector206:
  push $0
ffff80000010b0e0:	6a 00                	push   $0x0
  push $206
ffff80000010b0e2:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
ffff80000010b0e7:	e9 86 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0ec <vector207>:
vector207:
  push $0
ffff80000010b0ec:	6a 00                	push   $0x0
  push $207
ffff80000010b0ee:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
ffff80000010b0f3:	e9 7a ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b0f8 <vector208>:
vector208:
  push $0
ffff80000010b0f8:	6a 00                	push   $0x0
  push $208
ffff80000010b0fa:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
ffff80000010b0ff:	e9 6e ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b104 <vector209>:
vector209:
  push $0
ffff80000010b104:	6a 00                	push   $0x0
  push $209
ffff80000010b106:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
ffff80000010b10b:	e9 62 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b110 <vector210>:
vector210:
  push $0
ffff80000010b110:	6a 00                	push   $0x0
  push $210
ffff80000010b112:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
ffff80000010b117:	e9 56 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b11c <vector211>:
vector211:
  push $0
ffff80000010b11c:	6a 00                	push   $0x0
  push $211
ffff80000010b11e:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
ffff80000010b123:	e9 4a ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b128 <vector212>:
vector212:
  push $0
ffff80000010b128:	6a 00                	push   $0x0
  push $212
ffff80000010b12a:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
ffff80000010b12f:	e9 3e ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b134 <vector213>:
vector213:
  push $0
ffff80000010b134:	6a 00                	push   $0x0
  push $213
ffff80000010b136:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
ffff80000010b13b:	e9 32 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b140 <vector214>:
vector214:
  push $0
ffff80000010b140:	6a 00                	push   $0x0
  push $214
ffff80000010b142:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
ffff80000010b147:	e9 26 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b14c <vector215>:
vector215:
  push $0
ffff80000010b14c:	6a 00                	push   $0x0
  push $215
ffff80000010b14e:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
ffff80000010b153:	e9 1a ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b158 <vector216>:
vector216:
  push $0
ffff80000010b158:	6a 00                	push   $0x0
  push $216
ffff80000010b15a:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
ffff80000010b15f:	e9 0e ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b164 <vector217>:
vector217:
  push $0
ffff80000010b164:	6a 00                	push   $0x0
  push $217
ffff80000010b166:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
ffff80000010b16b:	e9 02 ee ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b170 <vector218>:
vector218:
  push $0
ffff80000010b170:	6a 00                	push   $0x0
  push $218
ffff80000010b172:	68 da 00 00 00       	push   $0xda
  jmp alltraps
ffff80000010b177:	e9 f6 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b17c <vector219>:
vector219:
  push $0
ffff80000010b17c:	6a 00                	push   $0x0
  push $219
ffff80000010b17e:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
ffff80000010b183:	e9 ea ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b188 <vector220>:
vector220:
  push $0
ffff80000010b188:	6a 00                	push   $0x0
  push $220
ffff80000010b18a:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
ffff80000010b18f:	e9 de ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b194 <vector221>:
vector221:
  push $0
ffff80000010b194:	6a 00                	push   $0x0
  push $221
ffff80000010b196:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
ffff80000010b19b:	e9 d2 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1a0 <vector222>:
vector222:
  push $0
ffff80000010b1a0:	6a 00                	push   $0x0
  push $222
ffff80000010b1a2:	68 de 00 00 00       	push   $0xde
  jmp alltraps
ffff80000010b1a7:	e9 c6 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1ac <vector223>:
vector223:
  push $0
ffff80000010b1ac:	6a 00                	push   $0x0
  push $223
ffff80000010b1ae:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
ffff80000010b1b3:	e9 ba ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1b8 <vector224>:
vector224:
  push $0
ffff80000010b1b8:	6a 00                	push   $0x0
  push $224
ffff80000010b1ba:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
ffff80000010b1bf:	e9 ae ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1c4 <vector225>:
vector225:
  push $0
ffff80000010b1c4:	6a 00                	push   $0x0
  push $225
ffff80000010b1c6:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
ffff80000010b1cb:	e9 a2 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1d0 <vector226>:
vector226:
  push $0
ffff80000010b1d0:	6a 00                	push   $0x0
  push $226
ffff80000010b1d2:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
ffff80000010b1d7:	e9 96 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1dc <vector227>:
vector227:
  push $0
ffff80000010b1dc:	6a 00                	push   $0x0
  push $227
ffff80000010b1de:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
ffff80000010b1e3:	e9 8a ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1e8 <vector228>:
vector228:
  push $0
ffff80000010b1e8:	6a 00                	push   $0x0
  push $228
ffff80000010b1ea:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
ffff80000010b1ef:	e9 7e ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b1f4 <vector229>:
vector229:
  push $0
ffff80000010b1f4:	6a 00                	push   $0x0
  push $229
ffff80000010b1f6:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
ffff80000010b1fb:	e9 72 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b200 <vector230>:
vector230:
  push $0
ffff80000010b200:	6a 00                	push   $0x0
  push $230
ffff80000010b202:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
ffff80000010b207:	e9 66 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b20c <vector231>:
vector231:
  push $0
ffff80000010b20c:	6a 00                	push   $0x0
  push $231
ffff80000010b20e:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
ffff80000010b213:	e9 5a ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b218 <vector232>:
vector232:
  push $0
ffff80000010b218:	6a 00                	push   $0x0
  push $232
ffff80000010b21a:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
ffff80000010b21f:	e9 4e ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b224 <vector233>:
vector233:
  push $0
ffff80000010b224:	6a 00                	push   $0x0
  push $233
ffff80000010b226:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
ffff80000010b22b:	e9 42 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b230 <vector234>:
vector234:
  push $0
ffff80000010b230:	6a 00                	push   $0x0
  push $234
ffff80000010b232:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
ffff80000010b237:	e9 36 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b23c <vector235>:
vector235:
  push $0
ffff80000010b23c:	6a 00                	push   $0x0
  push $235
ffff80000010b23e:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
ffff80000010b243:	e9 2a ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b248 <vector236>:
vector236:
  push $0
ffff80000010b248:	6a 00                	push   $0x0
  push $236
ffff80000010b24a:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
ffff80000010b24f:	e9 1e ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b254 <vector237>:
vector237:
  push $0
ffff80000010b254:	6a 00                	push   $0x0
  push $237
ffff80000010b256:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
ffff80000010b25b:	e9 12 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b260 <vector238>:
vector238:
  push $0
ffff80000010b260:	6a 00                	push   $0x0
  push $238
ffff80000010b262:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
ffff80000010b267:	e9 06 ed ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b26c <vector239>:
vector239:
  push $0
ffff80000010b26c:	6a 00                	push   $0x0
  push $239
ffff80000010b26e:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
ffff80000010b273:	e9 fa ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b278 <vector240>:
vector240:
  push $0
ffff80000010b278:	6a 00                	push   $0x0
  push $240
ffff80000010b27a:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
ffff80000010b27f:	e9 ee ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b284 <vector241>:
vector241:
  push $0
ffff80000010b284:	6a 00                	push   $0x0
  push $241
ffff80000010b286:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
ffff80000010b28b:	e9 e2 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b290 <vector242>:
vector242:
  push $0
ffff80000010b290:	6a 00                	push   $0x0
  push $242
ffff80000010b292:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
ffff80000010b297:	e9 d6 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b29c <vector243>:
vector243:
  push $0
ffff80000010b29c:	6a 00                	push   $0x0
  push $243
ffff80000010b29e:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
ffff80000010b2a3:	e9 ca ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2a8 <vector244>:
vector244:
  push $0
ffff80000010b2a8:	6a 00                	push   $0x0
  push $244
ffff80000010b2aa:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
ffff80000010b2af:	e9 be ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2b4 <vector245>:
vector245:
  push $0
ffff80000010b2b4:	6a 00                	push   $0x0
  push $245
ffff80000010b2b6:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
ffff80000010b2bb:	e9 b2 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2c0 <vector246>:
vector246:
  push $0
ffff80000010b2c0:	6a 00                	push   $0x0
  push $246
ffff80000010b2c2:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
ffff80000010b2c7:	e9 a6 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2cc <vector247>:
vector247:
  push $0
ffff80000010b2cc:	6a 00                	push   $0x0
  push $247
ffff80000010b2ce:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
ffff80000010b2d3:	e9 9a ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2d8 <vector248>:
vector248:
  push $0
ffff80000010b2d8:	6a 00                	push   $0x0
  push $248
ffff80000010b2da:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
ffff80000010b2df:	e9 8e ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2e4 <vector249>:
vector249:
  push $0
ffff80000010b2e4:	6a 00                	push   $0x0
  push $249
ffff80000010b2e6:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
ffff80000010b2eb:	e9 82 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2f0 <vector250>:
vector250:
  push $0
ffff80000010b2f0:	6a 00                	push   $0x0
  push $250
ffff80000010b2f2:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
ffff80000010b2f7:	e9 76 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b2fc <vector251>:
vector251:
  push $0
ffff80000010b2fc:	6a 00                	push   $0x0
  push $251
ffff80000010b2fe:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
ffff80000010b303:	e9 6a ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b308 <vector252>:
vector252:
  push $0
ffff80000010b308:	6a 00                	push   $0x0
  push $252
ffff80000010b30a:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
ffff80000010b30f:	e9 5e ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b314 <vector253>:
vector253:
  push $0
ffff80000010b314:	6a 00                	push   $0x0
  push $253
ffff80000010b316:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
ffff80000010b31b:	e9 52 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b320 <vector254>:
vector254:
  push $0
ffff80000010b320:	6a 00                	push   $0x0
  push $254
ffff80000010b322:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
ffff80000010b327:	e9 46 ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b32c <vector255>:
vector255:
  push $0
ffff80000010b32c:	6a 00                	push   $0x0
  push $255
ffff80000010b32e:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
ffff80000010b333:	e9 3a ec ff ff       	jmp    ffff800000109f72 <alltraps>

ffff80000010b338 <lgdt>:
{
ffff80000010b338:	55                   	push   %rbp
ffff80000010b339:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b33c:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b340:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b344:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010b347:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b34b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff80000010b34f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010b352:	83 e8 01             	sub    $0x1,%eax
ffff80000010b355:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010b359:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b35d:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff80000010b361:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b365:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010b369:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff80000010b36d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b371:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010b375:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010b379:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b37d:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010b381:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lgdt (%0)" : : "r" (pd));
ffff80000010b385:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010b389:	0f 01 10             	lgdt   (%rax)
}
ffff80000010b38c:	90                   	nop
ffff80000010b38d:	c9                   	leave
ffff80000010b38e:	c3                   	ret

ffff80000010b38f <ltr>:
{
ffff80000010b38f:	55                   	push   %rbp
ffff80000010b390:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b393:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010b397:	89 f8                	mov    %edi,%eax
ffff80000010b399:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  asm volatile("ltr %0" : : "r" (sel));
ffff80000010b39d:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010b3a1:	0f 00 d8             	ltr    %eax
}
ffff80000010b3a4:	90                   	nop
ffff80000010b3a5:	c9                   	leave
ffff80000010b3a6:	c3                   	ret

ffff80000010b3a7 <lcr3>:
{
ffff80000010b3a7:	55                   	push   %rbp
ffff80000010b3a8:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b3ab:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010b3af:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffff80000010b3b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b3b7:	0f 22 d8             	mov    %rax,%cr3
}
ffff80000010b3ba:	90                   	nop
ffff80000010b3bb:	c9                   	leave
ffff80000010b3bc:	c3                   	ret

ffff80000010b3bd <v2p>:
static inline addr_t v2p(void *a) {
ffff80000010b3bd:	55                   	push   %rbp
ffff80000010b3be:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b3c1:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010b3c5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff80000010b3c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b3cd:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b3d4:	80 00 00 
ffff80000010b3d7:	48 01 d0             	add    %rdx,%rax
}
ffff80000010b3da:	c9                   	leave
ffff80000010b3db:	c3                   	ret

ffff80000010b3dc <syscallinit>:
static pml4e_t *kpml4;
static pdpe_t *kpdpt;

void
syscallinit(void)
{
ffff80000010b3dc:	55                   	push   %rbp
ffff80000010b3dd:	48 89 e5             	mov    %rsp,%rbp
  // the MSR/SYSRET wants the segment for 32-bit user data
  // next up is 64-bit user data, then code
  // This is simply the way the sysret instruction
  // is designed to work (it assumes they follow).
  wrmsr(MSR_STAR,
ffff80000010b3e0:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010b3e7:	00 1b 00 
ffff80000010b3ea:	48 89 c6             	mov    %rax,%rsi
ffff80000010b3ed:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010b3f2:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010b3f9:	80 ff ff 
ffff80000010b3fc:	ff d0                	call   *%rax
    ((((uint64)USER32_CS) << 48) | ((uint64)KERNEL_CS << 32)));
  wrmsr(MSR_LSTAR, (addr_t)syscall_entry);
ffff80000010b3fe:	48 b8 ae 9f 10 00 00 	movabs $0xffff800000109fae,%rax
ffff80000010b405:	80 ff ff 
ffff80000010b408:	48 89 c6             	mov    %rax,%rsi
ffff80000010b40b:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010b410:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010b417:	80 ff ff 
ffff80000010b41a:	ff d0                	call   *%rax
  wrmsr(MSR_CSTAR, (addr_t)ignore_sysret);
ffff80000010b41c:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010b423:	80 ff ff 
ffff80000010b426:	48 89 c6             	mov    %rax,%rsi
ffff80000010b429:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010b42e:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010b435:	80 ff ff 
ffff80000010b438:	ff d0                	call   *%rax

  wrmsr(MSR_SFMASK, FL_TF|FL_DF|FL_IF|FL_IOPL_3|FL_AC|FL_NT);
ffff80000010b43a:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010b43f:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010b444:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010b44b:	80 ff ff 
ffff80000010b44e:	ff d0                	call   *%rax
}
ffff80000010b450:	90                   	nop
ffff80000010b451:	5d                   	pop    %rbp
ffff80000010b452:	c3                   	ret

ffff80000010b453 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
ffff80000010b453:	55                   	push   %rbp
ffff80000010b454:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b457:	48 83 ec 30          	sub    $0x30,%rsp
  uint64 addr;
  void *local;
  struct cpu *c;

  // create a page for cpu local storage
  local = kalloc();
ffff80000010b45b:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b462:	80 ff ff 
ffff80000010b465:	ff d0                	call   *%rax
ffff80000010b467:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(local, 0, PGSIZE);
ffff80000010b46b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b46f:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b474:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b479:	48 89 c7             	mov    %rax,%rdi
ffff80000010b47c:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010b483:	80 ff ff 
ffff80000010b486:	ff d0                	call   *%rax

  gdt = (struct segdesc*) local;
ffff80000010b488:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b48c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffff80000010b490:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b494:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010b49a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffff80000010b49e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b4a2:	48 83 c0 40          	add    $0x40,%rax
ffff80000010b4a6:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)

  // point FS smack in the middle of our local storage page
  wrmsr(0xC0000100, ((uint64) local) + 2048);
ffff80000010b4ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b4b0:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010b4b6:	48 89 c6             	mov    %rax,%rsi
ffff80000010b4b9:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010b4be:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010b4c5:	80 ff ff 
ffff80000010b4c8:	ff d0                	call   *%rax

  c = &cpus[cpunum()];
ffff80000010b4ca:	48 b8 cb 46 10 00 00 	movabs $0xffff8000001046cb,%rax
ffff80000010b4d1:	80 ff ff 
ffff80000010b4d4:	ff d0                	call   *%rax
ffff80000010b4d6:	48 63 d0             	movslq %eax,%rdx
ffff80000010b4d9:	48 89 d0             	mov    %rdx,%rax
ffff80000010b4dc:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010b4e0:	48 01 d0             	add    %rdx,%rax
ffff80000010b4e3:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010b4e7:	48 ba e0 72 11 00 00 	movabs $0xffff8000001172e0,%rdx
ffff80000010b4ee:	80 ff ff 
ffff80000010b4f1:	48 01 d0             	add    %rdx,%rax
ffff80000010b4f4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  c->local = local;
ffff80000010b4f8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b4fc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b500:	48 89 50 20          	mov    %rdx,0x20(%rax)

  cpu = c;
ffff80000010b504:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b508:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010b50f:	ff ff 
  proc = 0;
ffff80000010b511:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010b518:	ff ff 00 00 00 00 

  addr = (uint64) tss;
ffff80000010b51e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b522:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  gdt[0] =  (struct segdesc) {};
ffff80000010b526:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b52a:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
ffff80000010b531:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b535:	48 83 c0 08          	add    $0x8,%rax
ffff80000010b539:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b53e:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b544:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b548:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b54c:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b54f:	83 ca 0a             	or     $0xa,%edx
ffff80000010b552:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b555:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b559:	83 ca 10             	or     $0x10,%edx
ffff80000010b55c:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b55f:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b563:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010b566:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b569:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b56d:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b570:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b573:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b577:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b57a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b57d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b581:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b584:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b587:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b58b:	83 ca 20             	or     $0x20,%edx
ffff80000010b58e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b591:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b595:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b598:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b59b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b59f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b5a2:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b5a5:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010b5a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b5ad:	48 83 c0 10          	add    $0x10,%rax
ffff80000010b5b1:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b5b6:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b5bc:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b5c0:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b5c4:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b5c7:	83 ca 02             	or     $0x2,%edx
ffff80000010b5ca:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b5cd:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b5d1:	83 ca 10             	or     $0x10,%edx
ffff80000010b5d4:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b5d7:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b5db:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010b5de:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b5e1:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b5e5:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b5e8:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b5eb:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b5ef:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b5f2:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b5f5:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b5f9:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b5fc:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b5ff:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b603:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b606:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b609:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b60d:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b610:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b613:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b617:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b61a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b61d:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
ffff80000010b621:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b625:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b629:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010b630:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b634:	48 83 c0 20          	add    $0x20,%rax
ffff80000010b638:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b63d:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b643:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b647:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b64b:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b64e:	83 ca 02             	or     $0x2,%edx
ffff80000010b651:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b654:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b658:	83 ca 10             	or     $0x10,%edx
ffff80000010b65b:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b65e:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b662:	83 ca 60             	or     $0x60,%edx
ffff80000010b665:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b668:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b66c:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b66f:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b672:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b676:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b679:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b67c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b680:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b683:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b686:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b68a:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b68d:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b690:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b694:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b697:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b69a:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b69e:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b6a1:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b6a4:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
ffff80000010b6a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b6ac:	48 83 c0 28          	add    $0x28,%rax
ffff80000010b6b0:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b6b5:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b6bb:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b6bf:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b6c3:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b6c6:	83 ca 0a             	or     $0xa,%edx
ffff80000010b6c9:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b6cc:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b6d0:	83 ca 10             	or     $0x10,%edx
ffff80000010b6d3:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b6d6:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b6da:	83 ca 60             	or     $0x60,%edx
ffff80000010b6dd:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b6e0:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b6e4:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b6e7:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b6ea:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b6ee:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b6f1:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b6f4:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b6f8:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b6fb:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b6fe:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b702:	83 ca 20             	or     $0x20,%edx
ffff80000010b705:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b708:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b70c:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b70f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b712:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b716:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b719:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b71c:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010b720:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b724:	48 83 c0 30          	add    $0x30,%rax
ffff80000010b728:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  // TSS: See IA32 SDM Figure 7-4
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010b72f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b733:	48 83 c0 38          	add    $0x38,%rax
ffff80000010b737:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b73b:	89 d7                	mov    %edx,%edi
ffff80000010b73d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b741:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b745:	89 d6                	mov    %edx,%esi
ffff80000010b747:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b74b:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010b74f:	89 d1                	mov    %edx,%ecx
ffff80000010b751:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010b756:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010b75a:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010b75e:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b762:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b765:	83 ca 09             	or     $0x9,%edx
ffff80000010b768:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b76b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b76f:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b772:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b775:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b779:	83 ca 60             	or     $0x60,%edx
ffff80000010b77c:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b77f:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b783:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b786:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b789:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b78d:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b790:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b793:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b797:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b79a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b79d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b7a1:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b7a4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b7a7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b7ab:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b7ae:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b7b1:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b7b5:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b7b8:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b7bb:	88 48 07             	mov    %cl,0x7(%rax)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010b7be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b7c2:	48 83 c0 40          	add    $0x40,%rax
ffff80000010b7c6:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b7ca:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b7ce:	41 89 d1             	mov    %edx,%r9d
ffff80000010b7d1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b7d5:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b7d9:	41 89 d0             	mov    %edx,%r8d
ffff80000010b7dc:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b7e0:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b7e4:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b7e8:	89 d7                	mov    %edx,%edi
ffff80000010b7ea:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b7ee:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b7f2:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010b7f6:	83 e2 0f             	and    $0xf,%edx
ffff80000010b7f9:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b7fd:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010b801:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010b805:	89 ce                	mov    %ecx,%esi
ffff80000010b807:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010b80b:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010b810:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010b814:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b818:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010b81b:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b81e:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b822:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010b825:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b828:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b82c:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010b82f:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b832:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b836:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010b839:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b83c:	89 d1                	mov    %edx,%ecx
ffff80000010b83e:	83 e1 0f             	and    $0xf,%ecx
ffff80000010b841:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b845:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b848:	09 ca                	or     %ecx,%edx
ffff80000010b84a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b84d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b851:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b854:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b857:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b85b:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b85e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b861:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b865:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b868:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b86b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b86f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b872:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b875:	40 88 70 07          	mov    %sil,0x7(%rax)

  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));
ffff80000010b879:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b87d:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010b882:	48 89 c7             	mov    %rax,%rdi
ffff80000010b885:	48 b8 38 b3 10 00 00 	movabs $0xffff80000010b338,%rax
ffff80000010b88c:	80 ff ff 
ffff80000010b88f:	ff d0                	call   *%rax

  ltr(SEG_TSS << 3);
ffff80000010b891:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010b896:	48 b8 8f b3 10 00 00 	movabs $0xffff80000010b38f,%rax
ffff80000010b89d:	80 ff ff 
ffff80000010b8a0:	ff d0                	call   *%rax
};
ffff80000010b8a2:	90                   	nop
ffff80000010b8a3:	c9                   	leave
ffff80000010b8a4:	c3                   	ret

ffff80000010b8a5 <setupkvm>:
// (directly addressable from end..P2V(PHYSTOP)).


pml4e_t*
setupkvm(void)
{
ffff80000010b8a5:	55                   	push   %rbp
ffff80000010b8a6:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b8a9:	48 83 ec 10          	sub    $0x10,%rsp
  pml4e_t *pml4 = (pml4e_t*) kalloc();
ffff80000010b8ad:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b8b4:	80 ff ff 
ffff80000010b8b7:	ff d0                	call   *%rax
ffff80000010b8b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(pml4, 0, PGSIZE);
ffff80000010b8bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b8c1:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b8c6:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b8cb:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8ce:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010b8d5:	80 ff ff 
ffff80000010b8d8:	ff d0                	call   *%rax
  pml4[256] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b8da:	48 b8 60 01 12 00 00 	movabs $0xffff800000120160,%rax
ffff80000010b8e1:	80 ff ff 
ffff80000010b8e4:	48 8b 00             	mov    (%rax),%rax
ffff80000010b8e7:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8ea:	48 b8 bd b3 10 00 00 	movabs $0xffff80000010b3bd,%rax
ffff80000010b8f1:	80 ff ff 
ffff80000010b8f4:	ff d0                	call   *%rax
ffff80000010b8f6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b8fa:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b901:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b905:	48 89 02             	mov    %rax,(%rdx)
  return pml4;
ffff80000010b908:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
};
ffff80000010b90c:	c9                   	leave
ffff80000010b90d:	c3                   	ret

ffff80000010b90e <kvmalloc>:
//
// linear map the first 4GB of physical memory starting
// at 0xFFFF800000000000
void
kvmalloc(void)
{
ffff80000010b90e:	55                   	push   %rbp
ffff80000010b90f:	48 89 e5             	mov    %rsp,%rbp
  kpml4 = (pml4e_t*) kalloc();
ffff80000010b912:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b919:	80 ff ff 
ffff80000010b91c:	ff d0                	call   *%rax
ffff80000010b91e:	48 ba 58 01 12 00 00 	movabs $0xffff800000120158,%rdx
ffff80000010b925:	80 ff ff 
ffff80000010b928:	48 89 02             	mov    %rax,(%rdx)
  memset(kpml4, 0, PGSIZE);
ffff80000010b92b:	48 b8 58 01 12 00 00 	movabs $0xffff800000120158,%rax
ffff80000010b932:	80 ff ff 
ffff80000010b935:	48 8b 00             	mov    (%rax),%rax
ffff80000010b938:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b93d:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b942:	48 89 c7             	mov    %rax,%rdi
ffff80000010b945:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010b94c:	80 ff ff 
ffff80000010b94f:	ff d0                	call   *%rax

  // the kernel memory region starts at KERNBASE and up
  // allocate one PDPT at the bottom of that range.
  kpdpt = (pde_t*) kalloc();
ffff80000010b951:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b958:	80 ff ff 
ffff80000010b95b:	ff d0                	call   *%rax
ffff80000010b95d:	48 ba 60 01 12 00 00 	movabs $0xffff800000120160,%rdx
ffff80000010b964:	80 ff ff 
ffff80000010b967:	48 89 02             	mov    %rax,(%rdx)
  memset(kpdpt, 0, PGSIZE);
ffff80000010b96a:	48 b8 60 01 12 00 00 	movabs $0xffff800000120160,%rax
ffff80000010b971:	80 ff ff 
ffff80000010b974:	48 8b 00             	mov    (%rax),%rax
ffff80000010b977:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b97c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b981:	48 89 c7             	mov    %rax,%rdi
ffff80000010b984:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010b98b:	80 ff ff 
ffff80000010b98e:	ff d0                	call   *%rax
  kpml4[PMX(KERNBASE)] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b990:	48 b8 60 01 12 00 00 	movabs $0xffff800000120160,%rax
ffff80000010b997:	80 ff ff 
ffff80000010b99a:	48 8b 00             	mov    (%rax),%rax
ffff80000010b99d:	48 89 c7             	mov    %rax,%rdi
ffff80000010b9a0:	48 b8 bd b3 10 00 00 	movabs $0xffff80000010b3bd,%rax
ffff80000010b9a7:	80 ff ff 
ffff80000010b9aa:	ff d0                	call   *%rax
ffff80000010b9ac:	48 ba 58 01 12 00 00 	movabs $0xffff800000120158,%rdx
ffff80000010b9b3:	80 ff ff 
ffff80000010b9b6:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010b9b9:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b9c0:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b9c4:	48 89 02             	mov    %rax,(%rdx)

  // direct map first GB of physical addresses to KERNBASE
  kpdpt[0] = 0 | PTE_PS | PTE_P | PTE_W;
ffff80000010b9c7:	48 b8 60 01 12 00 00 	movabs $0xffff800000120160,%rax
ffff80000010b9ce:	80 ff ff 
ffff80000010b9d1:	48 8b 00             	mov    (%rax),%rax
ffff80000010b9d4:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)

  // direct map 4th GB of physical addresses to KERNBASE+3GB
  // this is a very lazy way to map IO memory (for lapic and ioapic)
  // PTE_PWT and PTE_PCD for memory mapped I/O correctness.
  kpdpt[3] = 0xC0000000 | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffff80000010b9db:	48 b8 60 01 12 00 00 	movabs $0xffff800000120160,%rax
ffff80000010b9e2:	80 ff ff 
ffff80000010b9e5:	48 8b 00             	mov    (%rax),%rax
ffff80000010b9e8:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b9ec:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010b9f1:	48 89 08             	mov    %rcx,(%rax)

  switchkvm();
ffff80000010b9f4:	48 b8 0f bd 10 00 00 	movabs $0xffff80000010bd0f,%rax
ffff80000010b9fb:	80 ff ff 
ffff80000010b9fe:	ff d0                	call   *%rax
}
ffff80000010ba00:	90                   	nop
ffff80000010ba01:	5d                   	pop    %rbp
ffff80000010ba02:	c3                   	ret

ffff80000010ba03 <switchuvm>:

void
switchuvm(struct proc *p)
{
ffff80000010ba03:	55                   	push   %rbp
ffff80000010ba04:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ba07:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010ba0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli();
ffff80000010ba0f:	48 b8 05 79 10 00 00 	movabs $0xffff800000107905,%rax
ffff80000010ba16:	80 ff ff 
ffff80000010ba19:	ff d0                	call   *%rax
  if(p->pgdir == 0)
ffff80000010ba1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba1f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010ba23:	48 85 c0             	test   %rax,%rax
ffff80000010ba26:	75 19                	jne    ffff80000010ba41 <switchuvm+0x3e>
    panic("switchuvm: no pgdir");
ffff80000010ba28:	48 b8 a8 cd 10 00 00 	movabs $0xffff80000010cda8,%rax
ffff80000010ba2f:	80 ff ff 
ffff80000010ba32:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba35:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010ba3c:	80 ff ff 
ffff80000010ba3f:	ff d0                	call   *%rax
  uint *tss = (uint*) (((char*) cpu->local) + 1024);
ffff80000010ba41:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010ba48:	ff ff 
ffff80000010ba4a:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010ba4e:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010ba54:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
ffff80000010ba58:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba5c:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010ba60:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010ba66:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
ffff80000010ba6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba6e:	48 83 c0 04          	add    $0x4,%rax
ffff80000010ba72:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010ba76:	89 10                	mov    %edx,(%rax)
  tss[2] = (uint)(stktop >> 32);
ffff80000010ba78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ba7c:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010ba80:	48 89 c2             	mov    %rax,%rdx
ffff80000010ba83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba87:	48 83 c0 08          	add    $0x8,%rax
ffff80000010ba8b:	89 10                	mov    %edx,(%rax)
  lcr3(v2p(p->pgdir));
ffff80000010ba8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba91:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010ba95:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba98:	48 b8 bd b3 10 00 00 	movabs $0xffff80000010b3bd,%rax
ffff80000010ba9f:	80 ff ff 
ffff80000010baa2:	ff d0                	call   *%rax
ffff80000010baa4:	48 89 c7             	mov    %rax,%rdi
ffff80000010baa7:	48 b8 a7 b3 10 00 00 	movabs $0xffff80000010b3a7,%rax
ffff80000010baae:	80 ff ff 
ffff80000010bab1:	ff d0                	call   *%rax
  popcli();
ffff80000010bab3:	48 b8 73 79 10 00 00 	movabs $0xffff800000107973,%rax
ffff80000010baba:	80 ff ff 
ffff80000010babd:	ff d0                	call   *%rax
}
ffff80000010babf:	90                   	nop
ffff80000010bac0:	c9                   	leave
ffff80000010bac1:	c3                   	ret

ffff80000010bac2 <walkpgdir>:
// In 64-bit mode, the page table has four levels: PML4, PDPT, PD and PT
// For each level, we dereference the correct entry, or allocate and
// initialize entry if the PTE_P bit is not set
static pte_t *
walkpgdir(pde_t *pml4, const void *va, int alloc)
{
ffff80000010bac2:	55                   	push   %rbp
ffff80000010bac3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bac6:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010baca:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010bace:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010bad2:	89 55 bc             	mov    %edx,-0x44(%rbp)
  pml4e_t *pml4e;
  pdpe_t *pdp, *pdpe;
  pde_t *pde, *pd, *pgtab;

  // from the PML4, find or allocate the appropriate PDP table
  pml4e = &pml4[PMX(va)];
ffff80000010bad5:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010bad9:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010badd:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010bae2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bae9:	00 
ffff80000010baea:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010baee:	48 01 d0             	add    %rdx,%rax
ffff80000010baf1:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  if(*pml4e & PTE_P)
ffff80000010baf5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010baf9:	48 8b 00             	mov    (%rax),%rax
ffff80000010bafc:	83 e0 01             	and    $0x1,%eax
ffff80000010baff:	48 85 c0             	test   %rax,%rax
ffff80000010bb02:	74 23                	je     ffff80000010bb27 <walkpgdir+0x65>
    pdp = (pdpe_t*)P2V(PTE_ADDR(*pml4e));
ffff80000010bb04:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb08:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb0b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb11:	48 89 c2             	mov    %rax,%rdx
ffff80000010bb14:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bb1b:	80 ff ff 
ffff80000010bb1e:	48 01 d0             	add    %rdx,%rax
ffff80000010bb21:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010bb25:	eb 63                	jmp    ffff80000010bb8a <walkpgdir+0xc8>
  else {
    if(!alloc || (pdp = (pdpe_t*)kalloc()) == 0)
ffff80000010bb27:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010bb2b:	74 17                	je     ffff80000010bb44 <walkpgdir+0x82>
ffff80000010bb2d:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010bb34:	80 ff ff 
ffff80000010bb37:	ff d0                	call   *%rax
ffff80000010bb39:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010bb3d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010bb42:	75 0a                	jne    ffff80000010bb4e <walkpgdir+0x8c>
      return 0;
ffff80000010bb44:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bb49:	e9 bf 01 00 00       	jmp    ffff80000010bd0d <walkpgdir+0x24b>
    memset(pdp, 0, PGSIZE);
ffff80000010bb4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb52:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bb57:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bb5c:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb5f:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010bb66:	80 ff ff 
ffff80000010bb69:	ff d0                	call   *%rax
    *pml4e = V2P(pdp) | PTE_P | PTE_W | PTE_U;
ffff80000010bb6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb6f:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bb76:	80 00 00 
ffff80000010bb79:	48 01 d0             	add    %rdx,%rax
ffff80000010bb7c:	48 83 c8 07          	or     $0x7,%rax
ffff80000010bb80:	48 89 c2             	mov    %rax,%rdx
ffff80000010bb83:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb87:	48 89 10             	mov    %rdx,(%rax)
  }

  //from the PDP, find or allocate the appropriate PD (page directory)
  pdpe = &pdp[PDPX(va)];
ffff80000010bb8a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010bb8e:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010bb92:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010bb97:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bb9e:	00 
ffff80000010bb9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bba3:	48 01 d0             	add    %rdx,%rax
ffff80000010bba6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(*pdpe & PTE_P)
ffff80000010bbaa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bbae:	48 8b 00             	mov    (%rax),%rax
ffff80000010bbb1:	83 e0 01             	and    $0x1,%eax
ffff80000010bbb4:	48 85 c0             	test   %rax,%rax
ffff80000010bbb7:	74 23                	je     ffff80000010bbdc <walkpgdir+0x11a>
    pd = (pde_t*)P2V(PTE_ADDR(*pdpe));
ffff80000010bbb9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bbbd:	48 8b 00             	mov    (%rax),%rax
ffff80000010bbc0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bbc6:	48 89 c2             	mov    %rax,%rdx
ffff80000010bbc9:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bbd0:	80 ff ff 
ffff80000010bbd3:	48 01 d0             	add    %rdx,%rax
ffff80000010bbd6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010bbda:	eb 63                	jmp    ffff80000010bc3f <walkpgdir+0x17d>
  else {
    if(!alloc || (pd = (pde_t*)kalloc()) == 0)//allocate page table
ffff80000010bbdc:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010bbe0:	74 17                	je     ffff80000010bbf9 <walkpgdir+0x137>
ffff80000010bbe2:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010bbe9:	80 ff ff 
ffff80000010bbec:	ff d0                	call   *%rax
ffff80000010bbee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010bbf2:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bbf7:	75 0a                	jne    ffff80000010bc03 <walkpgdir+0x141>
      return 0;
ffff80000010bbf9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bbfe:	e9 0a 01 00 00       	jmp    ffff80000010bd0d <walkpgdir+0x24b>
    memset(pd, 0, PGSIZE);
ffff80000010bc03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc07:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bc0c:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bc11:	48 89 c7             	mov    %rax,%rdi
ffff80000010bc14:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010bc1b:	80 ff ff 
ffff80000010bc1e:	ff d0                	call   *%rax
    *pdpe = V2P(pd) | PTE_P | PTE_W | PTE_U;
ffff80000010bc20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc24:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bc2b:	80 00 00 
ffff80000010bc2e:	48 01 d0             	add    %rdx,%rax
ffff80000010bc31:	48 83 c8 07          	or     $0x7,%rax
ffff80000010bc35:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc38:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bc3c:	48 89 10             	mov    %rdx,(%rax)
  }

  // from the PD, find or allocate the appropriate page table
  pde = &pd[PDX(va)];
ffff80000010bc3f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010bc43:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010bc47:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010bc4c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc53:	00 
ffff80000010bc54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc58:	48 01 d0             	add    %rdx,%rax
ffff80000010bc5b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  if(*pde & PTE_P)
ffff80000010bc5f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bc63:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc66:	83 e0 01             	and    $0x1,%eax
ffff80000010bc69:	48 85 c0             	test   %rax,%rax
ffff80000010bc6c:	74 23                	je     ffff80000010bc91 <walkpgdir+0x1cf>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
ffff80000010bc6e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bc72:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc75:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bc7b:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc7e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bc85:	80 ff ff 
ffff80000010bc88:	48 01 d0             	add    %rdx,%rax
ffff80000010bc8b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bc8f:	eb 60                	jmp    ffff80000010bcf1 <walkpgdir+0x22f>
  else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)//allocate page table
ffff80000010bc91:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010bc95:	74 17                	je     ffff80000010bcae <walkpgdir+0x1ec>
ffff80000010bc97:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010bc9e:	80 ff ff 
ffff80000010bca1:	ff d0                	call   *%rax
ffff80000010bca3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bca7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010bcac:	75 07                	jne    ffff80000010bcb5 <walkpgdir+0x1f3>
      return 0;
ffff80000010bcae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bcb3:	eb 58                	jmp    ffff80000010bd0d <walkpgdir+0x24b>
    memset(pgtab, 0, PGSIZE);
ffff80000010bcb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bcb9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bcbe:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bcc3:	48 89 c7             	mov    %rax,%rdi
ffff80000010bcc6:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010bccd:	80 ff ff 
ffff80000010bcd0:	ff d0                	call   *%rax
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
ffff80000010bcd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bcd6:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bcdd:	80 00 00 
ffff80000010bce0:	48 01 d0             	add    %rdx,%rax
ffff80000010bce3:	48 83 c8 07          	or     $0x7,%rax
ffff80000010bce7:	48 89 c2             	mov    %rax,%rdx
ffff80000010bcea:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bcee:	48 89 10             	mov    %rdx,(%rax)
  }

  return &pgtab[PTX(va)];
ffff80000010bcf1:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010bcf5:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010bcf9:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010bcfe:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bd05:	00 
ffff80000010bd06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bd0a:	48 01 d0             	add    %rdx,%rax
}
ffff80000010bd0d:	c9                   	leave
ffff80000010bd0e:	c3                   	ret

ffff80000010bd0f <switchkvm>:

void
switchkvm(void)
{
ffff80000010bd0f:	55                   	push   %rbp
ffff80000010bd10:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffff80000010bd13:	48 b8 58 01 12 00 00 	movabs $0xffff800000120158,%rax
ffff80000010bd1a:	80 ff ff 
ffff80000010bd1d:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd20:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd23:	48 b8 bd b3 10 00 00 	movabs $0xffff80000010b3bd,%rax
ffff80000010bd2a:	80 ff ff 
ffff80000010bd2d:	ff d0                	call   *%rax
ffff80000010bd2f:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd32:	48 b8 a7 b3 10 00 00 	movabs $0xffff80000010b3a7,%rax
ffff80000010bd39:	80 ff ff 
ffff80000010bd3c:	ff d0                	call   *%rax
}
ffff80000010bd3e:	90                   	nop
ffff80000010bd3f:	5d                   	pop    %rbp
ffff80000010bd40:	c3                   	ret

ffff80000010bd41 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, addr_t size, addr_t pa, int perm)
{
ffff80000010bd41:	55                   	push   %rbp
ffff80000010bd42:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bd45:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010bd49:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010bd4d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010bd51:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010bd55:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010bd59:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((addr_t)va);
ffff80000010bd5d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bd61:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bd67:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((addr_t)va) + size - 1);
ffff80000010bd6b:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010bd6f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bd73:	48 01 d0             	add    %rdx,%rax
ffff80000010bd76:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010bd7a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bd80:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010bd84:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010bd88:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bd8c:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010bd91:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bd94:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd97:	48 b8 c2 ba 10 00 00 	movabs $0xffff80000010bac2,%rax
ffff80000010bd9e:	80 ff ff 
ffff80000010bda1:	ff d0                	call   *%rax
ffff80000010bda3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bda7:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010bdac:	75 07                	jne    ffff80000010bdb5 <mappages+0x74>
      return -1;
ffff80000010bdae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010bdb3:	eb 64                	jmp    ffff80000010be19 <mappages+0xd8>
    if(*pte & PTE_P)
ffff80000010bdb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bdb9:	48 8b 00             	mov    (%rax),%rax
ffff80000010bdbc:	83 e0 01             	and    $0x1,%eax
ffff80000010bdbf:	48 85 c0             	test   %rax,%rax
ffff80000010bdc2:	74 19                	je     ffff80000010bddd <mappages+0x9c>
      panic("remap");
ffff80000010bdc4:	48 b8 bc cd 10 00 00 	movabs $0xffff80000010cdbc,%rax
ffff80000010bdcb:	80 ff ff 
ffff80000010bdce:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdd1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bdd8:	80 ff ff 
ffff80000010bddb:	ff d0                	call   *%rax
    *pte = pa | perm | PTE_P;
ffff80000010bddd:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010bde0:	48 98                	cltq
ffff80000010bde2:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010bde6:	48 83 c8 01          	or     $0x1,%rax
ffff80000010bdea:	48 89 c2             	mov    %rax,%rdx
ffff80000010bded:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bdf1:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffff80000010bdf4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdf8:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010bdfc:	74 15                	je     ffff80000010be13 <mappages+0xd2>
      break;
    a += PGSIZE;
ffff80000010bdfe:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010be05:	00 
    pa += PGSIZE;
ffff80000010be06:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010be0d:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010be0e:	e9 71 ff ff ff       	jmp    ffff80000010bd84 <mappages+0x43>
      break;
ffff80000010be13:	90                   	nop
  }
  return 0;
ffff80000010be14:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010be19:	c9                   	leave
ffff80000010be1a:	c3                   	ret

ffff80000010be1b <inituvm>:

// Load the initcode into address 0x1000 (4KB) of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffff80000010be1b:	55                   	push   %rbp
ffff80000010be1c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010be1f:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010be23:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010be27:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010be2b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;

  if(sz >= PGSIZE)
ffff80000010be2e:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010be35:	76 19                	jbe    ffff80000010be50 <inituvm+0x35>
    panic("inituvm: more than a page");
ffff80000010be37:	48 b8 c2 cd 10 00 00 	movabs $0xffff80000010cdc2,%rax
ffff80000010be3e:	80 ff ff 
ffff80000010be41:	48 89 c7             	mov    %rax,%rdi
ffff80000010be44:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010be4b:	80 ff ff 
ffff80000010be4e:	ff d0                	call   *%rax

  mem = kalloc();
ffff80000010be50:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010be57:	80 ff ff 
ffff80000010be5a:	ff d0                	call   *%rax
ffff80000010be5c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffff80000010be60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be64:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010be69:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010be6e:	48 89 c7             	mov    %rax,%rdi
ffff80000010be71:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010be78:	80 ff ff 
ffff80000010be7b:	ff d0                	call   *%rax
  mappages(pgdir, (void *)PGSIZE, PGSIZE, V2P(mem), PTE_W|PTE_U);
ffff80000010be7d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be81:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010be88:	80 00 00 
ffff80000010be8b:	48 01 c2             	add    %rax,%rdx
ffff80000010be8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010be92:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010be98:	48 89 d1             	mov    %rdx,%rcx
ffff80000010be9b:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bea0:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010bea5:	48 89 c7             	mov    %rax,%rdi
ffff80000010bea8:	48 b8 41 bd 10 00 00 	movabs $0xffff80000010bd41,%rax
ffff80000010beaf:	80 ff ff 
ffff80000010beb2:	ff d0                	call   *%rax

  memmove(mem, init, sz);
ffff80000010beb4:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010beb7:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010bebb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bebf:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bec2:	48 89 c7             	mov    %rax,%rdi
ffff80000010bec5:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff80000010becc:	80 ff ff 
ffff80000010becf:	ff d0                	call   *%rax
}
ffff80000010bed1:	90                   	nop
ffff80000010bed2:	c9                   	leave
ffff80000010bed3:	c3                   	ret

ffff80000010bed4 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffff80000010bed4:	55                   	push   %rbp
ffff80000010bed5:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bed8:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bedc:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010bee0:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010bee4:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010bee8:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010beeb:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
  uint i, n;
  addr_t pa;
  pte_t *pte;

  if((addr_t) addr % PGSIZE != 0)
ffff80000010beef:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bef3:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010bef8:	48 85 c0             	test   %rax,%rax
ffff80000010befb:	74 19                	je     ffff80000010bf16 <loaduvm+0x42>
    panic("loaduvm: addr must be page aligned");
ffff80000010befd:	48 b8 e0 cd 10 00 00 	movabs $0xffff80000010cde0,%rax
ffff80000010bf04:	80 ff ff 
ffff80000010bf07:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf0a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bf11:	80 ff ff 
ffff80000010bf14:	ff d0                	call   *%rax
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010bf16:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010bf1d:	e9 c7 00 00 00       	jmp    ffff80000010bfe9 <loaduvm+0x115>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffff80000010bf22:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010bf25:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf29:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010bf2d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bf31:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bf36:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bf39:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf3c:	48 b8 c2 ba 10 00 00 	movabs $0xffff80000010bac2,%rax
ffff80000010bf43:	80 ff ff 
ffff80000010bf46:	ff d0                	call   *%rax
ffff80000010bf48:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010bf4c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bf51:	75 19                	jne    ffff80000010bf6c <loaduvm+0x98>
      panic("loaduvm: address should exist");
ffff80000010bf53:	48 b8 03 ce 10 00 00 	movabs $0xffff80000010ce03,%rax
ffff80000010bf5a:	80 ff ff 
ffff80000010bf5d:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf60:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bf67:	80 ff ff 
ffff80000010bf6a:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010bf6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf70:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf73:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bf79:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(sz - i < PGSIZE)
ffff80000010bf7d:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010bf80:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010bf83:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010bf88:	77 0b                	ja     ffff80000010bf95 <loaduvm+0xc1>
      n = sz - i;
ffff80000010bf8a:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010bf8d:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010bf90:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010bf93:	eb 07                	jmp    ffff80000010bf9c <loaduvm+0xc8>
    else
      n = PGSIZE;
ffff80000010bf95:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
ffff80000010bf9c:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010bf9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bfa2:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010bfa5:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bfac:	80 ff ff 
ffff80000010bfaf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bfb3:	48 01 d0             	add    %rdx,%rax
ffff80000010bfb6:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfb9:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010bfbc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bfc0:	89 d1                	mov    %edx,%ecx
ffff80000010bfc2:	89 f2                	mov    %esi,%edx
ffff80000010bfc4:	48 89 fe             	mov    %rdi,%rsi
ffff80000010bfc7:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfca:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff80000010bfd1:	80 ff ff 
ffff80000010bfd4:	ff d0                	call   *%rax
ffff80000010bfd6:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010bfd9:	74 07                	je     ffff80000010bfe2 <loaduvm+0x10e>
      return -1;
ffff80000010bfdb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010bfe0:	eb 18                	jmp    ffff80000010bffa <loaduvm+0x126>
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010bfe2:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010bfe9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bfec:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010bfef:	0f 82 2d ff ff ff    	jb     ffff80000010bf22 <loaduvm+0x4e>
  }
  return 0;
ffff80000010bff5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010bffa:	c9                   	leave
ffff80000010bffb:	c3                   	ret

ffff80000010bffc <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
allocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010bffc:	55                   	push   %rbp
ffff80000010bffd:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c000:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010c004:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c008:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010c00c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *mem;
  addr_t a;

  if(newsz >= KERNBASE)
ffff80000010c010:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010c017:	7f ff ff 
ffff80000010c01a:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010c01e:	73 0a                	jae    ffff80000010c02a <allocuvm+0x2e>
    return 0;
ffff80000010c020:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c025:	e9 14 01 00 00       	jmp    ffff80000010c13e <allocuvm+0x142>
  if(newsz < oldsz)
ffff80000010c02a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c02e:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010c032:	73 09                	jae    ffff80000010c03d <allocuvm+0x41>
    return oldsz;
ffff80000010c034:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c038:	e9 01 01 00 00       	jmp    ffff80000010c13e <allocuvm+0x142>

  a = PGROUNDUP(oldsz);
ffff80000010c03d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c041:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010c047:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c04d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffff80000010c051:	e9 d6 00 00 00       	jmp    ffff80000010c12c <allocuvm+0x130>
    mem = kalloc();
ffff80000010c056:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010c05d:	80 ff ff 
ffff80000010c060:	ff d0                	call   *%rax
ffff80000010c062:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffff80000010c066:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c06b:	75 28                	jne    ffff80000010c095 <allocuvm+0x99>
      //cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010c06d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010c071:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010c075:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c079:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c07c:	48 89 c7             	mov    %rax,%rdi
ffff80000010c07f:	48 b8 40 c1 10 00 00 	movabs $0xffff80000010c140,%rax
ffff80000010c086:	80 ff ff 
ffff80000010c089:	ff d0                	call   *%rax
      return 0;
ffff80000010c08b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c090:	e9 a9 00 00 00       	jmp    ffff80000010c13e <allocuvm+0x142>
    }
    memset(mem, 0, PGSIZE);
ffff80000010c095:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c099:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c09e:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c0a3:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0a6:	48 b8 79 7a 10 00 00 	movabs $0xffff800000107a79,%rax
ffff80000010c0ad:	80 ff ff 
ffff80000010c0b0:	ff d0                	call   *%rax
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
ffff80000010c0b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c0b6:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c0bd:	80 00 00 
ffff80000010c0c0:	48 01 c2             	add    %rax,%rdx
ffff80000010c0c3:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010c0c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c0cb:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010c0d1:	48 89 d1             	mov    %rdx,%rcx
ffff80000010c0d4:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c0d9:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0dc:	48 b8 41 bd 10 00 00 	movabs $0xffff80000010bd41,%rax
ffff80000010c0e3:	80 ff ff 
ffff80000010c0e6:	ff d0                	call   *%rax
ffff80000010c0e8:	85 c0                	test   %eax,%eax
ffff80000010c0ea:	79 38                	jns    ffff80000010c124 <allocuvm+0x128>
      //cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010c0ec:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010c0f0:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010c0f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c0f8:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c0fb:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0fe:	48 b8 40 c1 10 00 00 	movabs $0xffff80000010c140,%rax
ffff80000010c105:	80 ff ff 
ffff80000010c108:	ff d0                	call   *%rax
      kfree(mem);
ffff80000010c10a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c10e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c111:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c118:	80 ff ff 
ffff80000010c11b:	ff d0                	call   *%rax
      return 0;
ffff80000010c11d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c122:	eb 1a                	jmp    ffff80000010c13e <allocuvm+0x142>
  for(; a < newsz; a += PGSIZE){
ffff80000010c124:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c12b:	00 
ffff80000010c12c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c130:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010c134:	0f 82 1c ff ff ff    	jb     ffff80000010c056 <allocuvm+0x5a>
    }
  }
  return newsz;
ffff80000010c13a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
ffff80000010c13e:	c9                   	leave
ffff80000010c13f:	c3                   	ret

ffff80000010c140 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
deallocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010c140:	55                   	push   %rbp
ffff80000010c141:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c144:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c148:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c14c:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c150:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  addr_t a, pa;

  if(newsz >= oldsz)
ffff80000010c154:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c158:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010c15c:	72 09                	jb     ffff80000010c167 <deallocuvm+0x27>
    return oldsz;
ffff80000010c15e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c162:	e9 d0 00 00 00       	jmp    ffff80000010c237 <deallocuvm+0xf7>

  a = PGROUNDUP(newsz);
ffff80000010c167:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c16b:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010c171:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c177:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010c17b:	e9 a5 00 00 00       	jmp    ffff80000010c225 <deallocuvm+0xe5>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffff80000010c180:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010c184:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c188:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c18d:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c190:	48 89 c7             	mov    %rax,%rdi
ffff80000010c193:	48 b8 c2 ba 10 00 00 	movabs $0xffff80000010bac2,%rax
ffff80000010c19a:	80 ff ff 
ffff80000010c19d:	ff d0                	call   *%rax
ffff80000010c19f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(pte && (*pte & PTE_P) != 0){
ffff80000010c1a3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c1a8:	74 73                	je     ffff80000010c21d <deallocuvm+0xdd>
ffff80000010c1aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c1ae:	48 8b 00             	mov    (%rax),%rax
ffff80000010c1b1:	83 e0 01             	and    $0x1,%eax
ffff80000010c1b4:	48 85 c0             	test   %rax,%rax
ffff80000010c1b7:	74 64                	je     ffff80000010c21d <deallocuvm+0xdd>
      pa = PTE_ADDR(*pte);
ffff80000010c1b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c1bd:	48 8b 00             	mov    (%rax),%rax
ffff80000010c1c0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c1c6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffff80000010c1ca:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010c1cf:	75 19                	jne    ffff80000010c1ea <deallocuvm+0xaa>
        panic("kfree");
ffff80000010c1d1:	48 b8 21 ce 10 00 00 	movabs $0xffff80000010ce21,%rax
ffff80000010c1d8:	80 ff ff 
ffff80000010c1db:	48 89 c7             	mov    %rax,%rdi
ffff80000010c1de:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010c1e5:	80 ff ff 
ffff80000010c1e8:	ff d0                	call   *%rax
      char *v = P2V(pa);
ffff80000010c1ea:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010c1f1:	80 ff ff 
ffff80000010c1f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c1f8:	48 01 d0             	add    %rdx,%rax
ffff80000010c1fb:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffff80000010c1ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c203:	48 89 c7             	mov    %rax,%rdi
ffff80000010c206:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c20d:	80 ff ff 
ffff80000010c210:	ff d0                	call   *%rax
      *pte = 0;
ffff80000010c212:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c216:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010c21d:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c224:	00 
ffff80000010c225:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c229:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010c22d:	0f 82 4d ff ff ff    	jb     ffff80000010c180 <deallocuvm+0x40>
    }
  }
  return newsz;
ffff80000010c233:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffff80000010c237:	c9                   	leave
ffff80000010c238:	c3                   	ret

ffff80000010c239 <freevm>:

// Free all the pages mapped by, and all the memory used for,
// this page table
void
freevm(pml4e_t *pml4)
{
ffff80000010c239:	55                   	push   %rbp
ffff80000010c23a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c23d:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c241:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  uint i, j, k, l;
  pde_t *pdp, *pd, *pt;

  if(pml4 == 0)
ffff80000010c245:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010c24a:	75 19                	jne    ffff80000010c265 <freevm+0x2c>
    panic("freevm: no pgdir");
ffff80000010c24c:	48 b8 27 ce 10 00 00 	movabs $0xffff80000010ce27,%rax
ffff80000010c253:	80 ff ff 
ffff80000010c256:	48 89 c7             	mov    %rax,%rdi
ffff80000010c259:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010c260:	80 ff ff 
ffff80000010c263:	ff d0                	call   *%rax

  // then need to loop through pml4 entry
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010c265:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010c26c:	e9 dc 01 00 00       	jmp    ffff80000010c44d <freevm+0x214>
    if(pml4[i] & PTE_P){
ffff80000010c271:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c274:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c27b:	00 
ffff80000010c27c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c280:	48 01 d0             	add    %rdx,%rax
ffff80000010c283:	48 8b 00             	mov    (%rax),%rax
ffff80000010c286:	83 e0 01             	and    $0x1,%eax
ffff80000010c289:	48 85 c0             	test   %rax,%rax
ffff80000010c28c:	0f 84 b7 01 00 00    	je     ffff80000010c449 <freevm+0x210>
      pdp = (pdpe_t*)P2V(PTE_ADDR(pml4[i]));
ffff80000010c292:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010c295:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c29c:	00 
ffff80000010c29d:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c2a1:	48 01 d0             	add    %rdx,%rax
ffff80000010c2a4:	48 8b 00             	mov    (%rax),%rax
ffff80000010c2a7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c2ad:	48 89 c2             	mov    %rax,%rdx
ffff80000010c2b0:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c2b7:	80 ff ff 
ffff80000010c2ba:	48 01 d0             	add    %rdx,%rax
ffff80000010c2bd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

      // and every entry in the corresponding pdpt
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010c2c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010c2c8:	e9 5c 01 00 00       	jmp    ffff80000010c429 <freevm+0x1f0>
        if(pdp[j] & PTE_P){
ffff80000010c2cd:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c2d0:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c2d7:	00 
ffff80000010c2d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c2dc:	48 01 d0             	add    %rdx,%rax
ffff80000010c2df:	48 8b 00             	mov    (%rax),%rax
ffff80000010c2e2:	83 e0 01             	and    $0x1,%eax
ffff80000010c2e5:	48 85 c0             	test   %rax,%rax
ffff80000010c2e8:	0f 84 37 01 00 00    	je     ffff80000010c425 <freevm+0x1ec>
          pd = (pde_t*)P2V(PTE_ADDR(pdp[j]));
ffff80000010c2ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010c2f1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c2f8:	00 
ffff80000010c2f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c2fd:	48 01 d0             	add    %rdx,%rax
ffff80000010c300:	48 8b 00             	mov    (%rax),%rax
ffff80000010c303:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c309:	48 89 c2             	mov    %rax,%rdx
ffff80000010c30c:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c313:	80 ff ff 
ffff80000010c316:	48 01 d0             	add    %rdx,%rax
ffff80000010c319:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

          // and every entry in the corresponding page directory
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010c31d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010c324:	e9 dc 00 00 00       	jmp    ffff80000010c405 <freevm+0x1cc>
            if(pd[k] & PTE_P) {
ffff80000010c329:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010c32c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c333:	00 
ffff80000010c334:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c338:	48 01 d0             	add    %rdx,%rax
ffff80000010c33b:	48 8b 00             	mov    (%rax),%rax
ffff80000010c33e:	83 e0 01             	and    $0x1,%eax
ffff80000010c341:	48 85 c0             	test   %rax,%rax
ffff80000010c344:	0f 84 b7 00 00 00    	je     ffff80000010c401 <freevm+0x1c8>
              pt = (pde_t*)P2V(PTE_ADDR(pd[k]));
ffff80000010c34a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010c34d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c354:	00 
ffff80000010c355:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c359:	48 01 d0             	add    %rdx,%rax
ffff80000010c35c:	48 8b 00             	mov    (%rax),%rax
ffff80000010c35f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c365:	48 89 c2             	mov    %rax,%rdx
ffff80000010c368:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c36f:	80 ff ff 
ffff80000010c372:	48 01 d0             	add    %rdx,%rax
ffff80000010c375:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

              // and every entry in the corresponding page table
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010c379:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010c380:	eb 63                	jmp    ffff80000010c3e5 <freevm+0x1ac>
                if(pt[l] & PTE_P) {
ffff80000010c382:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010c385:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c38c:	00 
ffff80000010c38d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c391:	48 01 d0             	add    %rdx,%rax
ffff80000010c394:	48 8b 00             	mov    (%rax),%rax
ffff80000010c397:	83 e0 01             	and    $0x1,%eax
ffff80000010c39a:	48 85 c0             	test   %rax,%rax
ffff80000010c39d:	74 42                	je     ffff80000010c3e1 <freevm+0x1a8>
                  char * v = P2V(PTE_ADDR(pt[l]));
ffff80000010c39f:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010c3a2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010c3a9:	00 
ffff80000010c3aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c3ae:	48 01 d0             	add    %rdx,%rax
ffff80000010c3b1:	48 8b 00             	mov    (%rax),%rax
ffff80000010c3b4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c3ba:	48 89 c2             	mov    %rax,%rdx
ffff80000010c3bd:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c3c4:	80 ff ff 
ffff80000010c3c7:	48 01 d0             	add    %rdx,%rax
ffff80000010c3ca:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                  kfree((char*)v);
ffff80000010c3ce:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c3d2:	48 89 c7             	mov    %rax,%rdi
ffff80000010c3d5:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c3dc:	80 ff ff 
ffff80000010c3df:	ff d0                	call   *%rax
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010c3e1:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010c3e5:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010c3ec:	76 94                	jbe    ffff80000010c382 <freevm+0x149>
                }
              }
              //freeing every page table
              kfree((char*)pt);
ffff80000010c3ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c3f2:	48 89 c7             	mov    %rax,%rdi
ffff80000010c3f5:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c3fc:	80 ff ff 
ffff80000010c3ff:	ff d0                	call   *%rax
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010c401:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010c405:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010c40c:	0f 86 17 ff ff ff    	jbe    ffff80000010c329 <freevm+0xf0>
            }
          }
          // freeing every page directory
          kfree((char*)pd);
ffff80000010c412:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c416:	48 89 c7             	mov    %rax,%rdi
ffff80000010c419:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c420:	80 ff ff 
ffff80000010c423:	ff d0                	call   *%rax
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010c425:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010c429:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010c430:	0f 86 97 fe ff ff    	jbe    ffff80000010c2cd <freevm+0x94>
        }
      }
      // freeing every page directory pointer table
      kfree((char*)pdp);
ffff80000010c436:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c43a:	48 89 c7             	mov    %rax,%rdi
ffff80000010c43d:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c444:	80 ff ff 
ffff80000010c447:	ff d0                	call   *%rax
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010c449:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010c44d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010c454:	0f 86 17 fe ff ff    	jbe    ffff80000010c271 <freevm+0x38>
    }
  }
  // freeing the pml4
  kfree((char*)pml4);
ffff80000010c45a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c45e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c461:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010c468:	80 ff ff 
ffff80000010c46b:	ff d0                	call   *%rax
}
ffff80000010c46d:	90                   	nop
ffff80000010c46e:	c9                   	leave
ffff80000010c46f:	c3                   	ret

ffff80000010c470 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pml4e_t *pgdir, char *uva)
{
ffff80000010c470:	55                   	push   %rbp
ffff80000010c471:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c474:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010c478:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c47c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010c480:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010c484:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c488:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c48d:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c490:	48 89 c7             	mov    %rax,%rdi
ffff80000010c493:	48 b8 c2 ba 10 00 00 	movabs $0xffff80000010bac2,%rax
ffff80000010c49a:	80 ff ff 
ffff80000010c49d:	ff d0                	call   *%rax
ffff80000010c49f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffff80000010c4a3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010c4a8:	75 19                	jne    ffff80000010c4c3 <clearpteu+0x53>
    panic("clearpteu");
ffff80000010c4aa:	48 b8 38 ce 10 00 00 	movabs $0xffff80000010ce38,%rax
ffff80000010c4b1:	80 ff ff 
ffff80000010c4b4:	48 89 c7             	mov    %rax,%rdi
ffff80000010c4b7:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010c4be:	80 ff ff 
ffff80000010c4c1:	ff d0                	call   *%rax
  *pte &= ~PTE_U;
ffff80000010c4c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c4c7:	48 8b 00             	mov    (%rax),%rax
ffff80000010c4ca:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010c4ce:	48 89 c2             	mov    %rax,%rdx
ffff80000010c4d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c4d5:	48 89 10             	mov    %rdx,(%rax)
}
ffff80000010c4d8:	90                   	nop
ffff80000010c4d9:	c9                   	leave
ffff80000010c4da:	c3                   	ret

ffff80000010c4db <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pml4e_t *pgdir, uint sz)
{
ffff80000010c4db:	55                   	push   %rbp
ffff80000010c4dc:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c4df:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c4e3:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010c4e7:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  pde_t *d;
  pte_t *pte;
  addr_t pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffff80000010c4ea:	48 b8 a5 b8 10 00 00 	movabs $0xffff80000010b8a5,%rax
ffff80000010c4f1:	80 ff ff 
ffff80000010c4f4:	ff d0                	call   *%rax
ffff80000010c4f6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c4fa:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010c4ff:	75 0a                	jne    ffff80000010c50b <copyuvm+0x30>
    return 0;
ffff80000010c501:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c506:	e9 57 01 00 00       	jmp    ffff80000010c662 <copyuvm+0x187>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010c50b:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010c512:	00 
ffff80000010c513:	e9 1b 01 00 00       	jmp    ffff80000010c633 <copyuvm+0x158>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffff80000010c518:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010c51c:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c520:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c525:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c528:	48 89 c7             	mov    %rax,%rdi
ffff80000010c52b:	48 b8 c2 ba 10 00 00 	movabs $0xffff80000010bac2,%rax
ffff80000010c532:	80 ff ff 
ffff80000010c535:	ff d0                	call   *%rax
ffff80000010c537:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010c53b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010c540:	75 19                	jne    ffff80000010c55b <copyuvm+0x80>
      panic("copyuvm: pte should exist");
ffff80000010c542:	48 b8 42 ce 10 00 00 	movabs $0xffff80000010ce42,%rax
ffff80000010c549:	80 ff ff 
ffff80000010c54c:	48 89 c7             	mov    %rax,%rdi
ffff80000010c54f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010c556:	80 ff ff 
ffff80000010c559:	ff d0                	call   *%rax
    if(!(*pte & PTE_P))
ffff80000010c55b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c55f:	48 8b 00             	mov    (%rax),%rax
ffff80000010c562:	83 e0 01             	and    $0x1,%eax
ffff80000010c565:	48 85 c0             	test   %rax,%rax
ffff80000010c568:	75 19                	jne    ffff80000010c583 <copyuvm+0xa8>
      panic("copyuvm: page not present");
ffff80000010c56a:	48 b8 5c ce 10 00 00 	movabs $0xffff80000010ce5c,%rax
ffff80000010c571:	80 ff ff 
ffff80000010c574:	48 89 c7             	mov    %rax,%rdi
ffff80000010c577:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010c57e:	80 ff ff 
ffff80000010c581:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010c583:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c587:	48 8b 00             	mov    (%rax),%rax
ffff80000010c58a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c590:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    flags = PTE_FLAGS(*pte);
ffff80000010c594:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c598:	48 8b 00             	mov    (%rax),%rax
ffff80000010c59b:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010c5a0:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if((mem = kalloc()) == 0)
ffff80000010c5a4:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010c5ab:	80 ff ff 
ffff80000010c5ae:	ff d0                	call   *%rax
ffff80000010c5b0:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010c5b4:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010c5b9:	0f 84 87 00 00 00    	je     ffff80000010c646 <copyuvm+0x16b>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
ffff80000010c5bf:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010c5c6:	80 ff ff 
ffff80000010c5c9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c5cd:	48 01 d0             	add    %rdx,%rax
ffff80000010c5d0:	48 89 c1             	mov    %rax,%rcx
ffff80000010c5d3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c5d7:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c5dc:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c5df:	48 89 c7             	mov    %rax,%rdi
ffff80000010c5e2:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff80000010c5e9:	80 ff ff 
ffff80000010c5ec:	ff d0                	call   *%rax
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
ffff80000010c5ee:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c5f2:	89 c1                	mov    %eax,%ecx
ffff80000010c5f4:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c5f8:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010c5ff:	80 00 00 
ffff80000010c602:	48 01 c2             	add    %rax,%rdx
ffff80000010c605:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010c609:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c60d:	41 89 c8             	mov    %ecx,%r8d
ffff80000010c610:	48 89 d1             	mov    %rdx,%rcx
ffff80000010c613:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010c618:	48 89 c7             	mov    %rax,%rdi
ffff80000010c61b:	48 b8 41 bd 10 00 00 	movabs $0xffff80000010bd41,%rax
ffff80000010c622:	80 ff ff 
ffff80000010c625:	ff d0                	call   *%rax
ffff80000010c627:	85 c0                	test   %eax,%eax
ffff80000010c629:	78 1e                	js     ffff80000010c649 <copyuvm+0x16e>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010c62b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010c632:	00 
ffff80000010c633:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010c636:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010c63a:	0f 82 d8 fe ff ff    	jb     ffff80000010c518 <copyuvm+0x3d>
      goto bad;
  }
  return d;
ffff80000010c640:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c644:	eb 1c                	jmp    ffff80000010c662 <copyuvm+0x187>
      goto bad;
ffff80000010c646:	90                   	nop
ffff80000010c647:	eb 01                	jmp    ffff80000010c64a <copyuvm+0x16f>
      goto bad;
ffff80000010c649:	90                   	nop

bad:
  freevm(d);
ffff80000010c64a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c64e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c651:	48 b8 39 c2 10 00 00 	movabs $0xffff80000010c239,%rax
ffff80000010c658:	80 ff ff 
ffff80000010c65b:	ff d0                	call   *%rax
  return 0;
ffff80000010c65d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c662:	c9                   	leave
ffff80000010c663:	c3                   	ret

ffff80000010c664 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pml4e_t *pgdir, char *uva)
{
ffff80000010c664:	55                   	push   %rbp
ffff80000010c665:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c668:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010c66c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010c670:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010c674:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010c678:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c67c:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c681:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c684:	48 89 c7             	mov    %rax,%rdi
ffff80000010c687:	48 b8 c2 ba 10 00 00 	movabs $0xffff80000010bac2,%rax
ffff80000010c68e:	80 ff ff 
ffff80000010c691:	ff d0                	call   *%rax
ffff80000010c693:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffff80000010c697:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c69b:	48 8b 00             	mov    (%rax),%rax
ffff80000010c69e:	83 e0 01             	and    $0x1,%eax
ffff80000010c6a1:	48 85 c0             	test   %rax,%rax
ffff80000010c6a4:	75 07                	jne    ffff80000010c6ad <uva2ka+0x49>
    return 0;
ffff80000010c6a6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c6ab:	eb 33                	jmp    ffff80000010c6e0 <uva2ka+0x7c>
  if((*pte & PTE_U) == 0)
ffff80000010c6ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c6b1:	48 8b 00             	mov    (%rax),%rax
ffff80000010c6b4:	83 e0 04             	and    $0x4,%eax
ffff80000010c6b7:	48 85 c0             	test   %rax,%rax
ffff80000010c6ba:	75 07                	jne    ffff80000010c6c3 <uva2ka+0x5f>
    return 0;
ffff80000010c6bc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c6c1:	eb 1d                	jmp    ffff80000010c6e0 <uva2ka+0x7c>
  return (char*)P2V(PTE_ADDR(*pte));
ffff80000010c6c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c6c7:	48 8b 00             	mov    (%rax),%rax
ffff80000010c6ca:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c6d0:	48 89 c2             	mov    %rax,%rdx
ffff80000010c6d3:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c6da:	80 ff ff 
ffff80000010c6dd:	48 01 d0             	add    %rdx,%rax
}
ffff80000010c6e0:	c9                   	leave
ffff80000010c6e1:	c3                   	ret

ffff80000010c6e2 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pml4e_t *pgdir, addr_t va, void *p, uint64 len)
{
ffff80000010c6e2:	55                   	push   %rbp
ffff80000010c6e3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c6e6:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c6ea:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c6ee:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c6f2:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010c6f6:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  char *buf, *pa0;
  addr_t n, va0;

  buf = (char*)p;
ffff80000010c6fa:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c6fe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffff80000010c702:	e9 b0 00 00 00       	jmp    ffff80000010c7b7 <copyout+0xd5>
    va0 = PGROUNDDOWN(va);
ffff80000010c707:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c70b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c711:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010c715:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010c719:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c71d:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c720:	48 89 c7             	mov    %rax,%rdi
ffff80000010c723:	48 b8 64 c6 10 00 00 	movabs $0xffff80000010c664,%rax
ffff80000010c72a:	80 ff ff 
ffff80000010c72d:	ff d0                	call   *%rax
ffff80000010c72f:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffff80000010c733:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010c738:	75 0a                	jne    ffff80000010c744 <copyout+0x62>
      return -1;
ffff80000010c73a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c73f:	e9 83 00 00 00       	jmp    ffff80000010c7c7 <copyout+0xe5>
    n = PGSIZE - (va - va0);
ffff80000010c744:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c748:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010c74c:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c752:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffff80000010c756:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c75a:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010c75e:	73 08                	jae    ffff80000010c768 <copyout+0x86>
      n = len;
ffff80000010c760:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c764:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffff80000010c768:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c76c:	89 c6                	mov    %eax,%esi
ffff80000010c76e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c772:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010c776:	48 89 c2             	mov    %rax,%rdx
ffff80000010c779:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c77d:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c781:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c785:	89 f2                	mov    %esi,%edx
ffff80000010c787:	48 89 c6             	mov    %rax,%rsi
ffff80000010c78a:	48 89 cf             	mov    %rcx,%rdi
ffff80000010c78d:	48 b8 7e 7b 10 00 00 	movabs $0xffff800000107b7e,%rax
ffff80000010c794:	80 ff ff 
ffff80000010c797:	ff d0                	call   *%rax
    len -= n;
ffff80000010c799:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c79d:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
    buf += n;
ffff80000010c7a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c7a5:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffff80000010c7a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c7ad:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c7b3:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  while(len > 0){
ffff80000010c7b7:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010c7bc:	0f 85 45 ff ff ff    	jne    ffff80000010c707 <copyout+0x25>
  }
  return 0;
ffff80000010c7c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c7c7:	c9                   	leave
ffff80000010c7c8:	c3                   	ret
