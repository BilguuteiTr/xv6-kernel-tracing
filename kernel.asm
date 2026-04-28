
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
ffff800000100015:	f0 10 00             	lock adc %al,(%rax)
ffff800000100018:	00 e0                	add    %ah,%al
ffff80000010001a:	11 00                	adc    %eax,(%rax)
ffff80000010001c:	20 00                	and    %al,(%rax)
ffff80000010001e:	10 00                	adc    %al,(%rax)

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
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xe20e8>

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
ffff8000001000ea:	e9 f0 54 00 00       	jmp    ffff8000001055df <main>

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
ffff8000001000fc:	e9 0e 56 00 00       	jmp    ffff80000010570f <mpenter>

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
ffff800000100123:	48 ba 38 c4 10 00 00 	movabs $0xffff80000010c438,%rdx
ffff80000010012a:	80 ff ff 
ffff80000010012d:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100134:	80 ff ff 
ffff800000100137:	48 89 d6             	mov    %rdx,%rsi
ffff80000010013a:	48 89 c7             	mov    %rax,%rdi
ffff80000010013d:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000100144:	80 ff ff 
ffff800000100147:	ff d0                	call   *%rax
//PAGEBREAK!

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
ffff800000100149:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100150:	80 ff ff 
ffff800000100153:	48 b9 08 41 11 00 00 	movabs $0xffff800000114108,%rcx
ffff80000010015a:	80 ff ff 
ffff80000010015d:	48 89 88 a0 51 00 00 	mov    %rcx,0x51a0(%rax)
  bcache.head.next = &bcache.head;
ffff800000100164:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010016b:	80 ff ff 
ffff80000010016e:	48 89 88 a8 51 00 00 	mov    %rcx,0x51a8(%rax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff800000100175:	48 b8 68 f0 10 00 00 	movabs $0xffff80000010f068,%rax
ffff80000010017c:	80 ff ff 
ffff80000010017f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100183:	e9 8e 00 00 00       	jmp    ffff800000100216 <binit+0xfb>
    b->next = bcache.head.next;
ffff800000100188:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010018f:	80 ff ff 
ffff800000100192:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010019d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff8000001001a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001a8:	48 be 08 41 11 00 00 	movabs $0xffff800000114108,%rsi
ffff8000001001af:	80 ff ff 
ffff8000001001b2:	48 89 b0 98 00 00 00 	mov    %rsi,0x98(%rax)
    initsleeplock(&b->lock, "buffer");
ffff8000001001b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001bd:	48 83 c0 10          	add    $0x10,%rax
ffff8000001001c1:	48 ba 3f c4 10 00 00 	movabs $0xffff80000010c43f,%rdx
ffff8000001001c8:	80 ff ff 
ffff8000001001cb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d1:	48 b8 b7 74 10 00 00 	movabs $0xffff8000001074b7,%rax
ffff8000001001d8:	80 ff ff 
ffff8000001001db:	ff d0                	call   *%rax
    bcache.head.next->prev = b;
ffff8000001001dd:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001001e4:	80 ff ff 
ffff8000001001e7:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001001ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001001f2:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001001f9:	48 ba 00 f0 10 00 00 	movabs $0xffff80000010f000,%rdx
ffff800000100200:	80 ff ff 
ffff800000100203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100207:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
ffff80000010020e:	48 81 45 f8 b0 02 00 	addq   $0x2b0,-0x8(%rbp)
ffff800000100215:	00 
ffff800000100216:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
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
ffff80000010023c:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100243:	80 ff ff 
ffff800000100246:	48 89 c7             	mov    %rax,%rdi
ffff800000100249:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000100250:	80 ff ff 
ffff800000100253:	ff d0                	call   *%rax

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff800000100255:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
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
ffff80000010029b:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001002a2:	80 ff ff 
ffff8000001002a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001002a8:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001002af:	80 ff ff 
ffff8000001002b2:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff8000001002b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002b8:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001002bf:	48 b8 0f 75 10 00 00 	movabs $0xffff80000010750f,%rax
ffff8000001002c6:	80 ff ff 
ffff8000001002c9:	ff d0                	call   *%rax
      return b;
ffff8000001002cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002cf:	e9 f6 00 00 00       	jmp    ffff8000001003ca <bget+0x19c>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
ffff8000001002d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002d8:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff8000001002df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001002e3:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff8000001002ea:	80 ff ff 
ffff8000001002ed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001002f1:	0f 85 75 ff ff ff    	jne    ffff80000010026c <bget+0x3e>
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff8000001002f7:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
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
ffff800000100358:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010035f:	80 ff ff 
ffff800000100362:	48 89 c7             	mov    %rax,%rdi
ffff800000100365:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010036c:	80 ff ff 
ffff80000010036f:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff800000100371:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100375:	48 83 c0 10          	add    $0x10,%rax
ffff800000100379:	48 89 c7             	mov    %rax,%rdi
ffff80000010037c:	48 b8 0f 75 10 00 00 	movabs $0xffff80000010750f,%rax
ffff800000100383:	80 ff ff 
ffff800000100386:	ff d0                	call   *%rax
      return b;
ffff800000100388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010038c:	eb 3c                	jmp    ffff8000001003ca <bget+0x19c>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
ffff80000010038e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100392:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100399:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010039d:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff8000001003a4:	80 ff ff 
ffff8000001003a7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001003ab:	0f 85 60 ff ff ff    	jne    ffff800000100311 <bget+0xe3>
    }
  }
  panic("bget: no buffers");
ffff8000001003b1:	48 b8 46 c4 10 00 00 	movabs $0xffff80000010c446,%rax
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
ffff800000100408:	48 b8 e3 3d 10 00 00 	movabs $0xffff800000103de3,%rax
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
ffff800000100431:	48 b8 fa 75 10 00 00 	movabs $0xffff8000001075fa,%rax
ffff800000100438:	80 ff ff 
ffff80000010043b:	ff d0                	call   *%rax
ffff80000010043d:	85 c0                	test   %eax,%eax
ffff80000010043f:	75 19                	jne    ffff80000010045a <bwrite+0x40>
    panic("bwrite");
ffff800000100441:	48 b8 57 c4 10 00 00 	movabs $0xffff80000010c457,%rax
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
ffff800000100472:	48 b8 e3 3d 10 00 00 	movabs $0xffff800000103de3,%rax
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
ffff800000100498:	48 b8 fa 75 10 00 00 	movabs $0xffff8000001075fa,%rax
ffff80000010049f:	80 ff ff 
ffff8000001004a2:	ff d0                	call   *%rax
ffff8000001004a4:	85 c0                	test   %eax,%eax
ffff8000001004a6:	75 19                	jne    ffff8000001004c1 <brelse+0x40>
    panic("brelse");
ffff8000001004a8:	48 b8 5e c4 10 00 00 	movabs $0xffff80000010c45e,%rax
ffff8000001004af:	80 ff ff 
ffff8000001004b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004b5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001004bc:	80 ff ff 
ffff8000001004bf:	ff d0                	call   *%rax

  releasesleep(&b->lock);
ffff8000001004c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004c5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001004cc:	48 b8 95 75 10 00 00 	movabs $0xffff800000107595,%rax
ffff8000001004d3:	80 ff ff 
ffff8000001004d6:	ff d0                	call   *%rax

  acquire(&bcache.lock);
ffff8000001004d8:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001004df:	80 ff ff 
ffff8000001004e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e5:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
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
ffff800000100554:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010055b:	80 ff ff 
ffff80000010055e:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100569:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
    b->prev = &bcache.head;
ffff800000100570:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100574:	48 b9 08 41 11 00 00 	movabs $0xffff800000114108,%rcx
ffff80000010057b:	80 ff ff 
ffff80000010057e:	48 89 88 98 00 00 00 	mov    %rcx,0x98(%rax)
    bcache.head.next->prev = b;
ffff800000100585:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010058c:	80 ff ff 
ffff80000010058f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100596:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010059a:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
    bcache.head.next = b;
ffff8000001005a1:	48 ba 00 f0 10 00 00 	movabs $0xffff80000010f000,%rdx
ffff8000001005a8:	80 ff ff 
ffff8000001005ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001005af:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
  }

  release(&bcache.lock);
ffff8000001005b6:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001005bd:	80 ff ff 
ffff8000001005c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001005c3:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
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
ffff8000001006a6:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
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
ffff8000001006f8:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
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
ffff8000001007ea:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
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
ffff80000010088a:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100891:	80 ff ff 
ffff800000100894:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000100897:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
  if (locking)
ffff80000010089d:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff8000001008a4:	74 19                	je     ffff8000001008bf <cprintf+0xbb>
    acquire(&cons.lock);
ffff8000001008a6:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001008ad:	80 ff ff 
ffff8000001008b0:	48 89 c7             	mov    %rax,%rdi
ffff8000001008b3:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001008ba:	80 ff ff 
ffff8000001008bd:	ff d0                	call   *%rax

  if (fmt == 0)
ffff8000001008bf:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008c6:	00 
ffff8000001008c7:	75 19                	jne    ffff8000001008e2 <cprintf+0xde>
    panic("null fmt");
ffff8000001008c9:	48 b8 65 c4 10 00 00 	movabs $0xffff80000010c465,%rax
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
ffff800000100902:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
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
ffff800000100b08:	48 b8 6e c4 10 00 00 	movabs $0xffff80000010c46e,%rax
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
ffff800000100b35:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
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
ffff800000100b56:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100b5d:	80 ff ff 
ffff800000100b60:	ff d0                	call   *%rax
      break;
ffff800000100b62:	eb 26                	jmp    ffff800000100b8a <cprintf+0x386>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
ffff800000100b64:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b69:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100b70:	80 ff ff 
ffff800000100b73:	ff d0                	call   *%rax
      consputc(c);
ffff800000100b75:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100b7b:	89 c7                	mov    %eax,%edi
ffff800000100b7d:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
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
ffff800000100bce:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100bd5:	80 ff ff 
ffff800000100bd8:	48 89 c7             	mov    %rax,%rdi
ffff800000100bdb:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
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
ffff800000100c02:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100c09:	80 ff ff 
ffff800000100c0c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  cprintf("cpu%d: panic: ", cpu->id);
ffff800000100c13:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000100c1a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000100c1e:	0f b6 00             	movzbl (%rax),%eax
ffff800000100c21:	0f b6 c0             	movzbl %al,%eax
ffff800000100c24:	48 ba 75 c4 10 00 00 	movabs $0xffff80000010c475,%rdx
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
ffff800000100c5c:	48 b8 84 c4 10 00 00 	movabs $0xffff80000010c484,%rax
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
ffff800000100c88:	48 b8 d8 77 10 00 00 	movabs $0xffff8000001077d8,%rax
ffff800000100c8f:	80 ff ff 
ffff800000100c92:	ff d0                	call   *%rax
  for (i=0; i<10; i++)
ffff800000100c94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100c9b:	eb 2f                	jmp    ffff800000100ccc <panic+0xe2>
    cprintf(" %p\n", pcs[i]);
ffff800000100c9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ca0:	48 98                	cltq
ffff800000100ca2:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffff800000100ca7:	48 ba 86 c4 10 00 00 	movabs $0xffff80000010c486,%rdx
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
ffff800000100cd2:	48 b8 b8 44 11 00 00 	movabs $0xffff8000001144b8,%rax
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
ffff800000100e0d:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
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
ffff800000100e49:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
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

ffff800000100ed7 <vidclear>:

void 
vidclear(void){
ffff800000100ed7:	55                   	push   %rbp
ffff800000100ed8:	48 89 e5             	mov    %rsp,%rbp
ffff800000100edb:	48 83 ec 10          	sub    $0x10,%rsp
  int i;
  for(i = 0; i < 80 * 25; i++)
ffff800000100edf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100ee6:	eb 22                	jmp    ffff800000100f0a <vidclear+0x33>
    crt[i] = ' ' | 0x0700;
ffff800000100ee8:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100eef:	80 ff ff 
ffff800000100ef2:	48 8b 00             	mov    (%rax),%rax
ffff800000100ef5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100ef8:	48 63 d2             	movslq %edx,%rdx
ffff800000100efb:	48 01 d2             	add    %rdx,%rdx
ffff800000100efe:	48 01 d0             	add    %rdx,%rax
ffff800000100f01:	66 c7 00 20 07       	movw   $0x720,(%rax)
  for(i = 0; i < 80 * 25; i++)
ffff800000100f06:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100f0a:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
ffff800000100f11:	7e d5                	jle    ffff800000100ee8 <vidclear+0x11>
}
ffff800000100f13:	90                   	nop
ffff800000100f14:	90                   	nop
ffff800000100f15:	c9                   	leave
ffff800000100f16:	c3                   	ret

ffff800000100f17 <vidputc>:

void
vidputc(int row, int col, int ch, int color){
ffff800000100f17:	55                   	push   %rbp
ffff800000100f18:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f1b:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100f1f:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000100f22:	89 75 f8             	mov    %esi,-0x8(%rbp)
ffff800000100f25:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff800000100f28:	89 4d f0             	mov    %ecx,-0x10(%rbp)
  if(row < 0 || row >= 25)
ffff800000100f2b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000100f2f:	78 52                	js     ffff800000100f83 <vidputc+0x6c>
ffff800000100f31:	83 7d fc 18          	cmpl   $0x18,-0x4(%rbp)
ffff800000100f35:	7f 4c                	jg     ffff800000100f83 <vidputc+0x6c>
    return;
  if(col < 0 || col >= 80)
ffff800000100f37:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000100f3b:	78 49                	js     ffff800000100f86 <vidputc+0x6f>
ffff800000100f3d:	83 7d f8 4f          	cmpl   $0x4f,-0x8(%rbp)
ffff800000100f41:	7f 43                	jg     ffff800000100f86 <vidputc+0x6f>
    return;

  crt[row * 80 + col] = (ch & 0xff) | ((color & 0xff) << 8);
ffff800000100f43:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000100f46:	0f b6 c0             	movzbl %al,%eax
ffff800000100f49:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000100f4c:	c1 e2 08             	shl    $0x8,%edx
ffff800000100f4f:	09 d0                	or     %edx,%eax
ffff800000100f51:	89 c6                	mov    %eax,%esi
ffff800000100f53:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100f5a:	80 ff ff 
ffff800000100f5d:	48 8b 08             	mov    (%rax),%rcx
ffff800000100f60:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100f63:	89 d0                	mov    %edx,%eax
ffff800000100f65:	c1 e0 02             	shl    $0x2,%eax
ffff800000100f68:	01 d0                	add    %edx,%eax
ffff800000100f6a:	c1 e0 04             	shl    $0x4,%eax
ffff800000100f6d:	89 c2                	mov    %eax,%edx
ffff800000100f6f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000100f72:	01 d0                	add    %edx,%eax
ffff800000100f74:	48 98                	cltq
ffff800000100f76:	48 01 c0             	add    %rax,%rax
ffff800000100f79:	48 01 c8             	add    %rcx,%rax
ffff800000100f7c:	89 f2                	mov    %esi,%edx
ffff800000100f7e:	66 89 10             	mov    %dx,(%rax)
ffff800000100f81:	eb 04                	jmp    ffff800000100f87 <vidputc+0x70>
    return;
ffff800000100f83:	90                   	nop
ffff800000100f84:	eb 01                	jmp    ffff800000100f87 <vidputc+0x70>
    return;
ffff800000100f86:	90                   	nop
}
ffff800000100f87:	c9                   	leave
ffff800000100f88:	c3                   	ret

ffff800000100f89 <vidputs>:

void 
vidputs(int row, int col, char *s, int color){
ffff800000100f89:	55                   	push   %rbp
ffff800000100f8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f8d:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000100f91:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100f94:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff800000100f97:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffff800000100f9b:	89 4d dc             	mov    %ecx,-0x24(%rbp)
  int i;
  for(i = 0; s[i] != 0 && col + i < 80; i++)
ffff800000100f9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100fa5:	eb 34                	jmp    ffff800000100fdb <vidputs+0x52>
    vidputc(row, col + i, s[i], color);
ffff800000100fa7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100faa:	48 63 d0             	movslq %eax,%rdx
ffff800000100fad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000100fb1:	48 01 d0             	add    %rdx,%rax
ffff800000100fb4:	0f b6 00             	movzbl (%rax),%eax
ffff800000100fb7:	0f be d0             	movsbl %al,%edx
ffff800000100fba:	8b 4d e8             	mov    -0x18(%rbp),%ecx
ffff800000100fbd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100fc0:	8d 34 01             	lea    (%rcx,%rax,1),%esi
ffff800000100fc3:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffff800000100fc6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000100fc9:	89 c7                	mov    %eax,%edi
ffff800000100fcb:	48 b8 17 0f 10 00 00 	movabs $0xffff800000100f17,%rax
ffff800000100fd2:	80 ff ff 
ffff800000100fd5:	ff d0                	call   *%rax
  for(i = 0; s[i] != 0 && col + i < 80; i++)
ffff800000100fd7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100fdb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100fde:	48 63 d0             	movslq %eax,%rdx
ffff800000100fe1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000100fe5:	48 01 d0             	add    %rdx,%rax
ffff800000100fe8:	0f b6 00             	movzbl (%rax),%eax
ffff800000100feb:	84 c0                	test   %al,%al
ffff800000100fed:	74 0d                	je     ffff800000100ffc <vidputs+0x73>
ffff800000100fef:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000100ff2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ff5:	01 d0                	add    %edx,%eax
ffff800000100ff7:	83 f8 4f             	cmp    $0x4f,%eax
ffff800000100ffa:	7e ab                	jle    ffff800000100fa7 <vidputs+0x1e>
}
ffff800000100ffc:	90                   	nop
ffff800000100ffd:	c9                   	leave
ffff800000100ffe:	c3                   	ret

ffff800000100fff <consputc>:

  void
consputc(int c)
{
ffff800000100fff:	55                   	push   %rbp
ffff800000101000:	48 89 e5             	mov    %rsp,%rbp
ffff800000101003:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101007:	89 7d fc             	mov    %edi,-0x4(%rbp)
  if (panicked) {
ffff80000010100a:	48 b8 b8 44 11 00 00 	movabs $0xffff8000001144b8,%rax
ffff800000101011:	80 ff ff 
ffff800000101014:	8b 00                	mov    (%rax),%eax
ffff800000101016:	85 c0                	test   %eax,%eax
ffff800000101018:	74 1a                	je     ffff800000101034 <consputc+0x35>
    cli();
ffff80000010101a:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000101021:	80 ff ff 
ffff800000101024:	ff d0                	call   *%rax
    for(;;)
      hlt();
ffff800000101026:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff80000010102d:	80 ff ff 
ffff800000101030:	ff d0                	call   *%rax
ffff800000101032:	eb f2                	jmp    ffff800000101026 <consputc+0x27>
  }

  if (c == BACKSPACE) {
ffff800000101034:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffff80000010103b:	75 35                	jne    ffff800000101072 <consputc+0x73>
    uartputc('\b'); uartputc(' '); uartputc('\b');
ffff80000010103d:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000101042:	48 b8 18 a1 10 00 00 	movabs $0xffff80000010a118,%rax
ffff800000101049:	80 ff ff 
ffff80000010104c:	ff d0                	call   *%rax
ffff80000010104e:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000101053:	48 b8 18 a1 10 00 00 	movabs $0xffff80000010a118,%rax
ffff80000010105a:	80 ff ff 
ffff80000010105d:	ff d0                	call   *%rax
ffff80000010105f:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000101064:	48 b8 18 a1 10 00 00 	movabs $0xffff80000010a118,%rax
ffff80000010106b:	80 ff ff 
ffff80000010106e:	ff d0                	call   *%rax
ffff800000101070:	eb 11                	jmp    ffff800000101083 <consputc+0x84>
  } else
    uartputc(c);
ffff800000101072:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101075:	89 c7                	mov    %eax,%edi
ffff800000101077:	48 b8 18 a1 10 00 00 	movabs $0xffff80000010a118,%rax
ffff80000010107e:	80 ff ff 
ffff800000101081:	ff d0                	call   *%rax
  cgaputc(c);
ffff800000101083:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101086:	89 c7                	mov    %eax,%edi
ffff800000101088:	48 b8 f0 0c 10 00 00 	movabs $0xffff800000100cf0,%rax
ffff80000010108f:	80 ff ff 
ffff800000101092:	ff d0                	call   *%rax
}
ffff800000101094:	90                   	nop
ffff800000101095:	c9                   	leave
ffff800000101096:	c3                   	ret

ffff800000101097 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

  void
consoleintr(int (*getc)(void))
{
ffff800000101097:	55                   	push   %rbp
ffff800000101098:	48 89 e5             	mov    %rsp,%rbp
ffff80000010109b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010109f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int c;

  acquire(&input.lock);
ffff8000001010a3:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001010aa:	80 ff ff 
ffff8000001010ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001010b0:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001010b7:	80 ff ff 
ffff8000001010ba:	ff d0                	call   *%rax
  while((c = getc()) >= 0){
ffff8000001010bc:	e9 6d 02 00 00       	jmp    ffff80000010132e <consoleintr+0x297>
    switch(c){
ffff8000001010c1:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff8000001010c5:	0f 84 fd 00 00 00    	je     ffff8000001011c8 <consoleintr+0x131>
ffff8000001010cb:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff8000001010cf:	0f 8f 54 01 00 00    	jg     ffff800000101229 <consoleintr+0x192>
ffff8000001010d5:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff8000001010d9:	74 2f                	je     ffff80000010110a <consoleintr+0x73>
ffff8000001010db:	83 7d fc 1a          	cmpl   $0x1a,-0x4(%rbp)
ffff8000001010df:	0f 8f 44 01 00 00    	jg     ffff800000101229 <consoleintr+0x192>
ffff8000001010e5:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff8000001010e9:	74 7f                	je     ffff80000010116a <consoleintr+0xd3>
ffff8000001010eb:	83 7d fc 15          	cmpl   $0x15,-0x4(%rbp)
ffff8000001010ef:	0f 8f 34 01 00 00    	jg     ffff800000101229 <consoleintr+0x192>
ffff8000001010f5:	83 7d fc 08          	cmpl   $0x8,-0x4(%rbp)
ffff8000001010f9:	0f 84 c9 00 00 00    	je     ffff8000001011c8 <consoleintr+0x131>
ffff8000001010ff:	83 7d fc 10          	cmpl   $0x10,-0x4(%rbp)
ffff800000101103:	74 20                	je     ffff800000101125 <consoleintr+0x8e>
ffff800000101105:	e9 1f 01 00 00       	jmp    ffff800000101229 <consoleintr+0x192>
    case C('Z'): // reboot
      lidt(0,0);
ffff80000010110a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010110f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000101114:	48 b8 0f 06 10 00 00 	movabs $0xffff80000010060f,%rax
ffff80000010111b:	80 ff ff 
ffff80000010111e:	ff d0                	call   *%rax
      break;
ffff800000101120:	e9 09 02 00 00       	jmp    ffff80000010132e <consoleintr+0x297>
    case C('P'):  // Process listing.
      procdump();
ffff800000101125:	48 b8 43 73 10 00 00 	movabs $0xffff800000107343,%rax
ffff80000010112c:	80 ff ff 
ffff80000010112f:	ff d0                	call   *%rax
      break;
ffff800000101131:	e9 f8 01 00 00       	jmp    ffff80000010132e <consoleintr+0x297>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
ffff800000101136:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010113d:	80 ff ff 
ffff800000101140:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101146:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101149:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101150:	80 ff ff 
ffff800000101153:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff800000101159:	bf 00 01 00 00       	mov    $0x100,%edi
ffff80000010115e:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000101165:	80 ff ff 
ffff800000101168:	ff d0                	call   *%rax
      while(input.e != input.w &&
ffff80000010116a:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101171:	80 ff ff 
ffff800000101174:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff80000010117a:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101181:	80 ff ff 
ffff800000101184:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff80000010118a:	39 c2                	cmp    %eax,%edx
ffff80000010118c:	0f 84 95 01 00 00    	je     ffff800000101327 <consoleintr+0x290>
          input.buf[(input.e-1) % INPUT_BUF] != '\n'){
ffff800000101192:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101199:	80 ff ff 
ffff80000010119c:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001011a2:	83 e8 01             	sub    $0x1,%eax
ffff8000001011a5:	83 e0 7f             	and    $0x7f,%eax
ffff8000001011a8:	89 c2                	mov    %eax,%edx
ffff8000001011aa:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011b1:	80 ff ff 
ffff8000001011b4:	89 d2                	mov    %edx,%edx
ffff8000001011b6:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
      while(input.e != input.w &&
ffff8000001011bb:	3c 0a                	cmp    $0xa,%al
ffff8000001011bd:	0f 85 73 ff ff ff    	jne    ffff800000101136 <consoleintr+0x9f>
      }
      break;
ffff8000001011c3:	e9 5f 01 00 00       	jmp    ffff800000101327 <consoleintr+0x290>
    case C('H'): case '\x7f':  // Backspace
      if (input.e != input.w) {
ffff8000001011c8:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011cf:	80 ff ff 
ffff8000001011d2:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001011d8:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011df:	80 ff ff 
ffff8000001011e2:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff8000001011e8:	39 c2                	cmp    %eax,%edx
ffff8000001011ea:	0f 84 3a 01 00 00    	je     ffff80000010132a <consoleintr+0x293>
        input.e--;
ffff8000001011f0:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011f7:	80 ff ff 
ffff8000001011fa:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101200:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101203:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010120a:	80 ff ff 
ffff80000010120d:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
        consputc(BACKSPACE);
ffff800000101213:	bf 00 01 00 00       	mov    $0x100,%edi
ffff800000101218:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff80000010121f:	80 ff ff 
ffff800000101222:	ff d0                	call   *%rax
      }
      break;
ffff800000101224:	e9 01 01 00 00       	jmp    ffff80000010132a <consoleintr+0x293>
    default:
      if (c != 0 && input.e-input.r < INPUT_BUF) {
ffff800000101229:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010122d:	0f 84 fa 00 00 00    	je     ffff80000010132d <consoleintr+0x296>
ffff800000101233:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010123a:	80 ff ff 
ffff80000010123d:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff800000101243:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010124a:	80 ff ff 
ffff80000010124d:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101253:	29 c2                	sub    %eax,%edx
ffff800000101255:	83 fa 7f             	cmp    $0x7f,%edx
ffff800000101258:	0f 87 cf 00 00 00    	ja     ffff80000010132d <consoleintr+0x296>
        c = (c == '\r') ? '\n' : c;
ffff80000010125e:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffff800000101262:	75 07                	jne    ffff80000010126b <consoleintr+0x1d4>
ffff800000101264:	c7 45 fc 0a 00 00 00 	movl   $0xa,-0x4(%rbp)
        input.buf[input.e++ % INPUT_BUF] = c;
ffff80000010126b:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101272:	80 ff ff 
ffff800000101275:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff80000010127b:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010127e:	48 b9 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rcx
ffff800000101285:	80 ff ff 
ffff800000101288:	89 91 f0 00 00 00    	mov    %edx,0xf0(%rcx)
ffff80000010128e:	83 e0 7f             	and    $0x7f,%eax
ffff800000101291:	89 c2                	mov    %eax,%edx
ffff800000101293:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101296:	89 c1                	mov    %eax,%ecx
ffff800000101298:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010129f:	80 ff ff 
ffff8000001012a2:	89 d2                	mov    %edx,%edx
ffff8000001012a4:	88 4c 10 68          	mov    %cl,0x68(%rax,%rdx,1)
        consputc(c);
ffff8000001012a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001012ab:	89 c7                	mov    %eax,%edi
ffff8000001012ad:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff8000001012b4:	80 ff ff 
ffff8000001012b7:	ff d0                	call   *%rax
        if (c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF) {
ffff8000001012b9:	83 7d fc 0a          	cmpl   $0xa,-0x4(%rbp)
ffff8000001012bd:	74 2d                	je     ffff8000001012ec <consoleintr+0x255>
ffff8000001012bf:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff8000001012c3:	74 27                	je     ffff8000001012ec <consoleintr+0x255>
ffff8000001012c5:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001012cc:	80 ff ff 
ffff8000001012cf:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001012d5:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001012dc:	80 ff ff 
ffff8000001012df:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff8000001012e5:	83 e8 80             	sub    $0xffffff80,%eax
ffff8000001012e8:	39 c2                	cmp    %eax,%edx
ffff8000001012ea:	75 41                	jne    ffff80000010132d <consoleintr+0x296>
          input.w = input.e;
ffff8000001012ec:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001012f3:	80 ff ff 
ffff8000001012f6:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001012fc:	48 ba c0 43 11 00 00 	movabs $0xffff8000001143c0,%rdx
ffff800000101303:	80 ff ff 
ffff800000101306:	89 82 ec 00 00 00    	mov    %eax,0xec(%rdx)
          wakeup(&input.r);
ffff80000010130c:	48 b8 a8 44 11 00 00 	movabs $0xffff8000001144a8,%rax
ffff800000101313:	80 ff ff 
ffff800000101316:	48 89 c7             	mov    %rax,%rdi
ffff800000101319:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff800000101320:	80 ff ff 
ffff800000101323:	ff d0                	call   *%rax
        }
      }
      break;
ffff800000101325:	eb 06                	jmp    ffff80000010132d <consoleintr+0x296>
      break;
ffff800000101327:	90                   	nop
ffff800000101328:	eb 04                	jmp    ffff80000010132e <consoleintr+0x297>
      break;
ffff80000010132a:	90                   	nop
ffff80000010132b:	eb 01                	jmp    ffff80000010132e <consoleintr+0x297>
      break;
ffff80000010132d:	90                   	nop
  while((c = getc()) >= 0){
ffff80000010132e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101332:	ff d0                	call   *%rax
ffff800000101334:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101337:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010133b:	0f 89 80 fd ff ff    	jns    ffff8000001010c1 <consoleintr+0x2a>
    }
  }
  release(&input.lock);
ffff800000101341:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101348:	80 ff ff 
ffff80000010134b:	48 89 c7             	mov    %rax,%rdi
ffff80000010134e:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000101355:	80 ff ff 
ffff800000101358:	ff d0                	call   *%rax
}
ffff80000010135a:	90                   	nop
ffff80000010135b:	c9                   	leave
ffff80000010135c:	c3                   	ret

ffff80000010135d <consoleread>:

  int
consoleread(struct inode *ip, uint off, char *dst, int n)
{
ffff80000010135d:	55                   	push   %rbp
ffff80000010135e:	48 89 e5             	mov    %rsp,%rbp
ffff800000101361:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101365:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101369:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010136c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101370:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint target;
  int c;

  iunlock(ip);
ffff800000101373:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101377:	48 89 c7             	mov    %rax,%rdi
ffff80000010137a:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000101381:	80 ff ff 
ffff800000101384:	ff d0                	call   *%rax
  target = n;
ffff800000101386:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101389:	89 45 fc             	mov    %eax,-0x4(%rbp)
  acquire(&input.lock);
ffff80000010138c:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101393:	80 ff ff 
ffff800000101396:	48 89 c7             	mov    %rax,%rdi
ffff800000101399:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001013a0:	80 ff ff 
ffff8000001013a3:	ff d0                	call   *%rax
  while(n > 0){
ffff8000001013a5:	e9 23 01 00 00       	jmp    ffff8000001014cd <consoleread+0x170>
    while(input.r == input.w){
      if (proc->killed) {
ffff8000001013aa:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001013b1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001013b5:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001013b8:	85 c0                	test   %eax,%eax
ffff8000001013ba:	74 36                	je     ffff8000001013f2 <consoleread+0x95>
        release(&input.lock);
ffff8000001013bc:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001013c3:	80 ff ff 
ffff8000001013c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001013c9:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001013d0:	80 ff ff 
ffff8000001013d3:	ff d0                	call   *%rax
        ilock(ip);
ffff8000001013d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001013d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001013dc:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001013e3:	80 ff ff 
ffff8000001013e6:	ff d0                	call   *%rax
        return -1;
ffff8000001013e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001013ed:	e9 21 01 00 00       	jmp    ffff800000101513 <consoleread+0x1b6>
      }
      sleep(&input.r, &input.lock);
ffff8000001013f2:	48 ba c0 43 11 00 00 	movabs $0xffff8000001143c0,%rdx
ffff8000001013f9:	80 ff ff 
ffff8000001013fc:	48 b8 a8 44 11 00 00 	movabs $0xffff8000001144a8,%rax
ffff800000101403:	80 ff ff 
ffff800000101406:	48 89 d6             	mov    %rdx,%rsi
ffff800000101409:	48 89 c7             	mov    %rax,%rdi
ffff80000010140c:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000101413:	80 ff ff 
ffff800000101416:	ff d0                	call   *%rax
    while(input.r == input.w){
ffff800000101418:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010141f:	80 ff ff 
ffff800000101422:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000101428:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010142f:	80 ff ff 
ffff800000101432:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101438:	39 c2                	cmp    %eax,%edx
ffff80000010143a:	0f 84 6a ff ff ff    	je     ffff8000001013aa <consoleread+0x4d>
    }
    c = input.buf[input.r++ % INPUT_BUF];
ffff800000101440:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101447:	80 ff ff 
ffff80000010144a:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff800000101450:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101453:	48 b9 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rcx
ffff80000010145a:	80 ff ff 
ffff80000010145d:	89 91 e8 00 00 00    	mov    %edx,0xe8(%rcx)
ffff800000101463:	83 e0 7f             	and    $0x7f,%eax
ffff800000101466:	89 c2                	mov    %eax,%edx
ffff800000101468:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010146f:	80 ff ff 
ffff800000101472:	89 d2                	mov    %edx,%edx
ffff800000101474:	0f b6 44 10 68       	movzbl 0x68(%rax,%rdx,1),%eax
ffff800000101479:	0f be c0             	movsbl %al,%eax
ffff80000010147c:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if (c == C('D')) {  // EOF
ffff80000010147f:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffff800000101483:	75 2d                	jne    ffff8000001014b2 <consoleread+0x155>
      if (n < target) {
ffff800000101485:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101488:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffff80000010148b:	73 4c                	jae    ffff8000001014d9 <consoleread+0x17c>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
ffff80000010148d:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101494:	80 ff ff 
ffff800000101497:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010149d:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001014a0:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001014a7:	80 ff ff 
ffff8000001014aa:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
      }
      break;
ffff8000001014b0:	eb 27                	jmp    ffff8000001014d9 <consoleread+0x17c>
    }
    *dst++ = c;
ffff8000001014b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001014b6:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001014ba:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001014be:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001014c1:	88 10                	mov    %dl,(%rax)
    --n;
ffff8000001014c3:	83 6d e0 01          	subl   $0x1,-0x20(%rbp)
    if (c == '\n')
ffff8000001014c7:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffff8000001014cb:	74 0f                	je     ffff8000001014dc <consoleread+0x17f>
  while(n > 0){
ffff8000001014cd:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
ffff8000001014d1:	0f 8f 41 ff ff ff    	jg     ffff800000101418 <consoleread+0xbb>
ffff8000001014d7:	eb 04                	jmp    ffff8000001014dd <consoleread+0x180>
      break;
ffff8000001014d9:	90                   	nop
ffff8000001014da:	eb 01                	jmp    ffff8000001014dd <consoleread+0x180>
      break;
ffff8000001014dc:	90                   	nop
  }
  release(&input.lock);
ffff8000001014dd:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001014e4:	80 ff ff 
ffff8000001014e7:	48 89 c7             	mov    %rax,%rdi
ffff8000001014ea:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001014f1:	80 ff ff 
ffff8000001014f4:	ff d0                	call   *%rax
  ilock(ip);
ffff8000001014f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001014fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001014fd:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000101504:	80 ff ff 
ffff800000101507:	ff d0                	call   *%rax

  return target - n;
ffff800000101509:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff80000010150c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010150f:	29 c2                	sub    %eax,%edx
ffff800000101511:	89 d0                	mov    %edx,%eax
}
ffff800000101513:	c9                   	leave
ffff800000101514:	c3                   	ret

ffff800000101515 <consolewrite>:

  int
consolewrite(struct inode *ip, uint off, char *buf, int n)
{
ffff800000101515:	55                   	push   %rbp
ffff800000101516:	48 89 e5             	mov    %rsp,%rbp
ffff800000101519:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010151d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101521:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000101524:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101528:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  int i;

  iunlock(ip);
ffff80000010152b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010152f:	48 89 c7             	mov    %rax,%rdi
ffff800000101532:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000101539:	80 ff ff 
ffff80000010153c:	ff d0                	call   *%rax
  acquire(&cons.lock);
ffff80000010153e:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101545:	80 ff ff 
ffff800000101548:	48 89 c7             	mov    %rax,%rdi
ffff80000010154b:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000101552:	80 ff ff 
ffff800000101555:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff800000101557:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010155e:	eb 28                	jmp    ffff800000101588 <consolewrite+0x73>
    consputc(buf[i] & 0xff);
ffff800000101560:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101563:	48 63 d0             	movslq %eax,%rdx
ffff800000101566:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010156a:	48 01 d0             	add    %rdx,%rax
ffff80000010156d:	0f b6 00             	movzbl (%rax),%eax
ffff800000101570:	0f be c0             	movsbl %al,%eax
ffff800000101573:	0f b6 c0             	movzbl %al,%eax
ffff800000101576:	89 c7                	mov    %eax,%edi
ffff800000101578:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff80000010157f:	80 ff ff 
ffff800000101582:	ff d0                	call   *%rax
  for(i = 0; i < n; i++)
ffff800000101584:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000101588:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010158b:	3b 45 e0             	cmp    -0x20(%rbp),%eax
ffff80000010158e:	7c d0                	jl     ffff800000101560 <consolewrite+0x4b>
  release(&cons.lock);
ffff800000101590:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101597:	80 ff ff 
ffff80000010159a:	48 89 c7             	mov    %rax,%rdi
ffff80000010159d:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001015a4:	80 ff ff 
ffff8000001015a7:	ff d0                	call   *%rax
  ilock(ip);
ffff8000001015a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001015ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001015b0:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001015b7:	80 ff ff 
ffff8000001015ba:	ff d0                	call   *%rax

  return n;
ffff8000001015bc:	8b 45 e0             	mov    -0x20(%rbp),%eax
}
ffff8000001015bf:	c9                   	leave
ffff8000001015c0:	c3                   	ret

ffff8000001015c1 <consoleinit>:

  void
consoleinit(void)
{
ffff8000001015c1:	55                   	push   %rbp
ffff8000001015c2:	48 89 e5             	mov    %rsp,%rbp
  initlock(&cons.lock, "console");
ffff8000001015c5:	48 ba 8b c4 10 00 00 	movabs $0xffff80000010c48b,%rdx
ffff8000001015cc:	80 ff ff 
ffff8000001015cf:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001015d6:	80 ff ff 
ffff8000001015d9:	48 89 d6             	mov    %rdx,%rsi
ffff8000001015dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001015df:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff8000001015e6:	80 ff ff 
ffff8000001015e9:	ff d0                	call   *%rax
  initlock(&input.lock, "input");
ffff8000001015eb:	48 ba 93 c4 10 00 00 	movabs $0xffff80000010c493,%rdx
ffff8000001015f2:	80 ff ff 
ffff8000001015f5:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001015fc:	80 ff ff 
ffff8000001015ff:	48 89 d6             	mov    %rdx,%rsi
ffff800000101602:	48 89 c7             	mov    %rax,%rdi
ffff800000101605:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff80000010160c:	80 ff ff 
ffff80000010160f:	ff d0                	call   *%rax

  devsw[CONSOLE].write = consolewrite;
ffff800000101611:	48 b8 40 45 11 00 00 	movabs $0xffff800000114540,%rax
ffff800000101618:	80 ff ff 
ffff80000010161b:	48 b9 15 15 10 00 00 	movabs $0xffff800000101515,%rcx
ffff800000101622:	80 ff ff 
ffff800000101625:	48 89 48 18          	mov    %rcx,0x18(%rax)
  devsw[CONSOLE].read = consoleread;
ffff800000101629:	48 b8 40 45 11 00 00 	movabs $0xffff800000114540,%rax
ffff800000101630:	80 ff ff 
ffff800000101633:	48 b9 5d 13 10 00 00 	movabs $0xffff80000010135d,%rcx
ffff80000010163a:	80 ff ff 
ffff80000010163d:	48 89 48 10          	mov    %rcx,0x10(%rax)
  cons.locking = 1;
ffff800000101641:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101648:	80 ff ff 
ffff80000010164b:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)

  ioapicenable(IRQ_KBD, 0);
ffff800000101652:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000101657:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010165c:	48 b8 96 40 10 00 00 	movabs $0xffff800000104096,%rax
ffff800000101663:	80 ff ff 
ffff800000101666:	ff d0                	call   *%rax
}
ffff800000101668:	90                   	nop
ffff800000101669:	5d                   	pop    %rbp
ffff80000010166a:	c3                   	ret

ffff80000010166b <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
ffff80000010166b:	55                   	push   %rbp
ffff80000010166c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010166f:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffff800000101676:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffff80000010167d:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  oldpgdir = proc->pgdir;
ffff800000101684:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010168b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010168f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000101693:	48 89 45 b8          	mov    %rax,-0x48(%rbp)

  begin_op();
ffff800000101697:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff80000010169e:	80 ff ff 
ffff8000001016a1:	ff d0                	call   *%rax

  if((ip = namei(path)) == 0){
ffff8000001016a3:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff8000001016aa:	48 89 c7             	mov    %rax,%rdi
ffff8000001016ad:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff8000001016b4:	80 ff ff 
ffff8000001016b7:	ff d0                	call   *%rax
ffff8000001016b9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff8000001016bd:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001016c2:	75 16                	jne    ffff8000001016da <exec+0x6f>
    end_op();
ffff8000001016c4:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff8000001016cb:	80 ff ff 
ffff8000001016ce:	ff d0                	call   *%rax
    return -1;
ffff8000001016d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001016d5:	e9 69 05 00 00       	jmp    ffff800000101c43 <exec+0x5d8>
  }
  ilock(ip);
ffff8000001016da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001016de:	48 89 c7             	mov    %rax,%rdi
ffff8000001016e1:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001016e8:	80 ff ff 
ffff8000001016eb:	ff d0                	call   *%rax
  pgdir = 0;
ffff8000001016ed:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffff8000001016f4:	00 

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
ffff8000001016f5:	48 8d b5 50 fe ff ff 	lea    -0x1b0(%rbp),%rsi
ffff8000001016fc:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101700:	b9 40 00 00 00       	mov    $0x40,%ecx
ffff800000101705:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010170a:	48 89 c7             	mov    %rax,%rdi
ffff80000010170d:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff800000101714:	80 ff ff 
ffff800000101717:	ff d0                	call   *%rax
ffff800000101719:	83 f8 40             	cmp    $0x40,%eax
ffff80000010171c:	0f 85 b7 04 00 00    	jne    ffff800000101bd9 <exec+0x56e>
    goto bad;
  if(elf.magic != ELF_MAGIC)
ffff800000101722:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffff800000101728:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffff80000010172d:	0f 85 a9 04 00 00    	jne    ffff800000101bdc <exec+0x571>
    goto bad;

  if((pgdir = setupkvm()) == 0)
ffff800000101733:	48 b8 e2 b1 10 00 00 	movabs $0xffff80000010b1e2,%rax
ffff80000010173a:	80 ff ff 
ffff80000010173d:	ff d0                	call   *%rax
ffff80000010173f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff800000101743:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101748:	0f 84 91 04 00 00    	je     ffff800000101bdf <exec+0x574>
    goto bad;

  // Load program into memory.
  sz = PGSIZE; // skip the first page
ffff80000010174e:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
ffff800000101755:	00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff800000101756:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff80000010175d:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffff800000101764:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff800000101767:	e9 0f 01 00 00       	jmp    ffff80000010187b <exec+0x210>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
ffff80000010176c:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010176f:	48 8d b5 10 fe ff ff 	lea    -0x1f0(%rbp),%rsi
ffff800000101776:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010177a:	b9 38 00 00 00       	mov    $0x38,%ecx
ffff80000010177f:	48 89 c7             	mov    %rax,%rdi
ffff800000101782:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff800000101789:	80 ff ff 
ffff80000010178c:	ff d0                	call   *%rax
ffff80000010178e:	83 f8 38             	cmp    $0x38,%eax
ffff800000101791:	0f 85 4b 04 00 00    	jne    ffff800000101be2 <exec+0x577>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
ffff800000101797:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffff80000010179d:	83 f8 01             	cmp    $0x1,%eax
ffff8000001017a0:	0f 85 c7 00 00 00    	jne    ffff80000010186d <exec+0x202>
      continue;
    if(ph.memsz < ph.filesz)
ffff8000001017a6:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffff8000001017ad:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff8000001017b4:	48 39 c2             	cmp    %rax,%rdx
ffff8000001017b7:	0f 82 28 04 00 00    	jb     ffff800000101be5 <exec+0x57a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
ffff8000001017bd:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff8000001017c4:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001017cb:	48 01 c2             	add    %rax,%rdx
ffff8000001017ce:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff8000001017d5:	48 39 c2             	cmp    %rax,%rdx
ffff8000001017d8:	0f 82 0a 04 00 00    	jb     ffff800000101be8 <exec+0x57d>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
ffff8000001017de:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff8000001017e5:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001017ec:	48 01 c2             	add    %rax,%rdx
ffff8000001017ef:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001017f3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001017f7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001017fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001017fd:	48 b8 39 b9 10 00 00 	movabs $0xffff80000010b939,%rax
ffff800000101804:	80 ff ff 
ffff800000101807:	ff d0                	call   *%rax
ffff800000101809:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010180d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000101812:	0f 84 d3 03 00 00    	je     ffff800000101beb <exec+0x580>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
ffff800000101818:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff80000010181f:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000101824:	48 85 c0             	test   %rax,%rax
ffff800000101827:	0f 85 c1 03 00 00    	jne    ffff800000101bee <exec+0x583>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
ffff80000010182d:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff800000101834:	89 c7                	mov    %eax,%edi
ffff800000101836:	48 8b 85 18 fe ff ff 	mov    -0x1e8(%rbp),%rax
ffff80000010183d:	89 c1                	mov    %eax,%ecx
ffff80000010183f:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff800000101846:	48 89 c6             	mov    %rax,%rsi
ffff800000101849:	48 8b 55 c8          	mov    -0x38(%rbp),%rdx
ffff80000010184d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101851:	41 89 f8             	mov    %edi,%r8d
ffff800000101854:	48 89 c7             	mov    %rax,%rdi
ffff800000101857:	48 b8 11 b8 10 00 00 	movabs $0xffff80000010b811,%rax
ffff80000010185e:	80 ff ff 
ffff800000101861:	ff d0                	call   *%rax
ffff800000101863:	85 c0                	test   %eax,%eax
ffff800000101865:	0f 88 86 03 00 00    	js     ffff800000101bf1 <exec+0x586>
ffff80000010186b:	eb 01                	jmp    ffff80000010186e <exec+0x203>
      continue;
ffff80000010186d:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
ffff80000010186e:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000101872:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000101875:	83 c0 38             	add    $0x38,%eax
ffff800000101878:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff80000010187b:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffff800000101882:	0f b7 c0             	movzwl %ax,%eax
ffff800000101885:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000101888:	0f 8c de fe ff ff    	jl     ffff80000010176c <exec+0x101>
      goto bad;
  }
  iunlockput(ip);
ffff80000010188e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101892:	48 89 c7             	mov    %rax,%rdi
ffff800000101895:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010189c:	80 ff ff 
ffff80000010189f:	ff d0                	call   *%rax
  end_op();
ffff8000001018a1:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff8000001018a8:	80 ff ff 
ffff8000001018ab:	ff d0                	call   *%rax
  ip = 0;
ffff8000001018ad:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffff8000001018b4:	00 

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
ffff8000001018b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001018b9:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff8000001018bf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff8000001018c5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
ffff8000001018c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001018cd:	48 8d 90 00 20 00 00 	lea    0x2000(%rax),%rdx
ffff8000001018d4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001018d8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001018dc:	48 89 ce             	mov    %rcx,%rsi
ffff8000001018df:	48 89 c7             	mov    %rax,%rdi
ffff8000001018e2:	48 b8 39 b9 10 00 00 	movabs $0xffff80000010b939,%rax
ffff8000001018e9:	80 ff ff 
ffff8000001018ec:	ff d0                	call   *%rax
ffff8000001018ee:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001018f2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001018f7:	0f 84 f7 02 00 00    	je     ffff800000101bf4 <exec+0x589>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
ffff8000001018fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101901:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffff800000101907:	48 89 c2             	mov    %rax,%rdx
ffff80000010190a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010190e:	48 89 d6             	mov    %rdx,%rsi
ffff800000101911:	48 89 c7             	mov    %rax,%rdi
ffff800000101914:	48 b8 ad bd 10 00 00 	movabs $0xffff80000010bdad,%rax
ffff80000010191b:	80 ff ff 
ffff80000010191e:	ff d0                	call   *%rax
  sp = sz;
ffff800000101920:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101924:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
ffff800000101928:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff80000010192f:	00 
ffff800000101930:	e9 c9 00 00 00       	jmp    ffff8000001019fe <exec+0x393>
    if(argc >= MAXARG)
ffff800000101935:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffff80000010193a:	0f 87 b7 02 00 00    	ja     ffff800000101bf7 <exec+0x58c>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~(sizeof(addr_t)-1);
ffff800000101940:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101944:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010194b:	00 
ffff80000010194c:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101953:	48 01 d0             	add    %rdx,%rax
ffff800000101956:	48 8b 00             	mov    (%rax),%rax
ffff800000101959:	48 89 c7             	mov    %rax,%rdi
ffff80000010195c:	48 b8 71 7d 10 00 00 	movabs $0xffff800000107d71,%rax
ffff800000101963:	80 ff ff 
ffff800000101966:	ff d0                	call   *%rax
ffff800000101968:	83 c0 01             	add    $0x1,%eax
ffff80000010196b:	48 98                	cltq
ffff80000010196d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101971:	48 29 c2             	sub    %rax,%rdx
ffff800000101974:	48 89 d0             	mov    %rdx,%rax
ffff800000101977:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff80000010197b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
ffff80000010197f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101983:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010198a:	00 
ffff80000010198b:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101992:	48 01 d0             	add    %rdx,%rax
ffff800000101995:	48 8b 00             	mov    (%rax),%rax
ffff800000101998:	48 89 c7             	mov    %rax,%rdi
ffff80000010199b:	48 b8 71 7d 10 00 00 	movabs $0xffff800000107d71,%rax
ffff8000001019a2:	80 ff ff 
ffff8000001019a5:	ff d0                	call   *%rax
ffff8000001019a7:	83 c0 01             	add    $0x1,%eax
ffff8000001019aa:	48 63 c8             	movslq %eax,%rcx
ffff8000001019ad:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001019b1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001019b8:	00 
ffff8000001019b9:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff8000001019c0:	48 01 d0             	add    %rdx,%rax
ffff8000001019c3:	48 8b 10             	mov    (%rax),%rdx
ffff8000001019c6:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff8000001019ca:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001019ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001019d1:	48 b8 1f c0 10 00 00 	movabs $0xffff80000010c01f,%rax
ffff8000001019d8:	80 ff ff 
ffff8000001019db:	ff d0                	call   *%rax
ffff8000001019dd:	85 c0                	test   %eax,%eax
ffff8000001019df:	0f 88 15 02 00 00    	js     ffff800000101bfa <exec+0x58f>
      goto bad;
    ustack[1+argc] = sp;
ffff8000001019e5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001019e9:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001019ed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001019f1:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffff8000001019f8:	ff 
  for(argc = 0; argv[argc]; argc++) {
ffff8000001019f9:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffff8000001019fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a02:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101a09:	00 
ffff800000101a0a:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101a11:	48 01 d0             	add    %rdx,%rax
ffff800000101a14:	48 8b 00             	mov    (%rax),%rax
ffff800000101a17:	48 85 c0             	test   %rax,%rax
ffff800000101a1a:	0f 85 15 ff ff ff    	jne    ffff800000101935 <exec+0x2ca>
  }
  ustack[1+argc] = 0;
ffff800000101a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a24:	48 83 c0 01          	add    $0x1,%rax
ffff800000101a28:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffff800000101a2f:	ff 00 00 00 00 

  ustack[0] = 0xffffffffffffffff;  // fake return PC
ffff800000101a34:	48 c7 85 90 fe ff ff 	movq   $0xffffffffffffffff,-0x170(%rbp)
ffff800000101a3b:	ff ff ff ff 

	// argc and argv for main() entry point
  proc->tf->rdi = argc;
ffff800000101a3f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a46:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a4a:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a4e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000101a52:	48 89 50 30          	mov    %rdx,0x30(%rax)
  proc->tf->rsi = sp - (argc+1)*sizeof(addr_t);
ffff800000101a56:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a5a:	48 83 c0 01          	add    $0x1,%rax
ffff800000101a5e:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff800000101a65:	00 
ffff800000101a66:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a6d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a71:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a75:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101a79:	48 29 ca             	sub    %rcx,%rdx
ffff800000101a7c:	48 89 50 28          	mov    %rdx,0x28(%rax)

  sp -= (1+argc+1) * sizeof(addr_t);
ffff800000101a80:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a84:	48 83 c0 02          	add    $0x2,%rax
ffff800000101a88:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000101a8c:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
  if(copyout(pgdir, sp, ustack, (1+argc+1)*sizeof(addr_t)) < 0)
ffff800000101a90:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a94:	48 83 c0 02          	add    $0x2,%rax
ffff800000101a98:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff800000101a9f:	00 
ffff800000101aa0:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffff800000101aa7:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff800000101aab:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101aaf:	48 89 c7             	mov    %rax,%rdi
ffff800000101ab2:	48 b8 1f c0 10 00 00 	movabs $0xffff80000010c01f,%rax
ffff800000101ab9:	80 ff ff 
ffff800000101abc:	ff d0                	call   *%rax
ffff800000101abe:	85 c0                	test   %eax,%eax
ffff800000101ac0:	0f 88 37 01 00 00    	js     ffff800000101bfd <exec+0x592>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
ffff800000101ac6:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff800000101acd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ad5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000101ad9:	eb 1c                	jmp    ffff800000101af7 <exec+0x48c>
    if(*s == '/')
ffff800000101adb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101adf:	0f b6 00             	movzbl (%rax),%eax
ffff800000101ae2:	3c 2f                	cmp    $0x2f,%al
ffff800000101ae4:	75 0c                	jne    ffff800000101af2 <exec+0x487>
      last = s+1;
ffff800000101ae6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101aea:	48 83 c0 01          	add    $0x1,%rax
ffff800000101aee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(last=s=path; *s; s++)
ffff800000101af2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000101af7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101afb:	0f b6 00             	movzbl (%rax),%eax
ffff800000101afe:	84 c0                	test   %al,%al
ffff800000101b00:	75 d9                	jne    ffff800000101adb <exec+0x470>
  safestrcpy(proc->name, last, sizeof(proc->name));
ffff800000101b02:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b09:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b0d:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000101b14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000101b18:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000101b1d:	48 89 c6             	mov    %rax,%rsi
ffff800000101b20:	48 89 cf             	mov    %rcx,%rdi
ffff800000101b23:	48 b8 0e 7d 10 00 00 	movabs $0xffff800000107d0e,%rax
ffff800000101b2a:	80 ff ff 
ffff800000101b2d:	ff d0                	call   *%rax

  // Commit to the user image.
  proc->pgdir = pgdir;
ffff800000101b2f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b36:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b3a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffff800000101b3e:	48 89 50 08          	mov    %rdx,0x8(%rax)
  proc->sz = sz;
ffff800000101b42:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b49:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b4d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000101b51:	48 89 10             	mov    %rdx,(%rax)
  proc->tf->rip = elf.entry;  // main
ffff800000101b54:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b5b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b5f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101b63:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101b6a:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
  proc->tf->rcx = elf.entry;
ffff800000101b71:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b78:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b7c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101b80:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101b87:	48 89 50 10          	mov    %rdx,0x10(%rax)
  proc->tf->rsp = sp;
ffff800000101b8b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b92:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b96:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101b9a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101b9e:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  switchuvm(proc);
ffff800000101ba5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101bac:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101bb0:	48 89 c7             	mov    %rax,%rdi
ffff800000101bb3:	48 b8 40 b3 10 00 00 	movabs $0xffff80000010b340,%rax
ffff800000101bba:	80 ff ff 
ffff800000101bbd:	ff d0                	call   *%rax
  freevm(oldpgdir);
ffff800000101bbf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101bc3:	48 89 c7             	mov    %rax,%rdi
ffff800000101bc6:	48 b8 76 bb 10 00 00 	movabs $0xffff80000010bb76,%rax
ffff800000101bcd:	80 ff ff 
ffff800000101bd0:	ff d0                	call   *%rax
  return 0;
ffff800000101bd2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101bd7:	eb 6a                	jmp    ffff800000101c43 <exec+0x5d8>
    goto bad;
ffff800000101bd9:	90                   	nop
ffff800000101bda:	eb 22                	jmp    ffff800000101bfe <exec+0x593>
    goto bad;
ffff800000101bdc:	90                   	nop
ffff800000101bdd:	eb 1f                	jmp    ffff800000101bfe <exec+0x593>
    goto bad;
ffff800000101bdf:	90                   	nop
ffff800000101be0:	eb 1c                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101be2:	90                   	nop
ffff800000101be3:	eb 19                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101be5:	90                   	nop
ffff800000101be6:	eb 16                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101be8:	90                   	nop
ffff800000101be9:	eb 13                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101beb:	90                   	nop
ffff800000101bec:	eb 10                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101bee:	90                   	nop
ffff800000101bef:	eb 0d                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101bf1:	90                   	nop
ffff800000101bf2:	eb 0a                	jmp    ffff800000101bfe <exec+0x593>
    goto bad;
ffff800000101bf4:	90                   	nop
ffff800000101bf5:	eb 07                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101bf7:	90                   	nop
ffff800000101bf8:	eb 04                	jmp    ffff800000101bfe <exec+0x593>
      goto bad;
ffff800000101bfa:	90                   	nop
ffff800000101bfb:	eb 01                	jmp    ffff800000101bfe <exec+0x593>
    goto bad;
ffff800000101bfd:	90                   	nop

 bad:
  if(pgdir)
ffff800000101bfe:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101c03:	74 13                	je     ffff800000101c18 <exec+0x5ad>
    freevm(pgdir);
ffff800000101c05:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101c09:	48 89 c7             	mov    %rax,%rdi
ffff800000101c0c:	48 b8 76 bb 10 00 00 	movabs $0xffff80000010bb76,%rax
ffff800000101c13:	80 ff ff 
ffff800000101c16:	ff d0                	call   *%rax
  if(ip){
ffff800000101c18:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000101c1d:	74 1f                	je     ffff800000101c3e <exec+0x5d3>
    iunlockput(ip);
ffff800000101c1f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101c23:	48 89 c7             	mov    %rax,%rdi
ffff800000101c26:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000101c2d:	80 ff ff 
ffff800000101c30:	ff d0                	call   *%rax
    end_op();
ffff800000101c32:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000101c39:	80 ff ff 
ffff800000101c3c:	ff d0                	call   *%rax
  }
  return -1;
ffff800000101c3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101c43:	c9                   	leave
ffff800000101c44:	c3                   	ret

ffff800000101c45 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
ffff800000101c45:	55                   	push   %rbp
ffff800000101c46:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ftable.lock, "ftable");
ffff800000101c49:	48 ba 99 c4 10 00 00 	movabs $0xffff80000010c499,%rdx
ffff800000101c50:	80 ff ff 
ffff800000101c53:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101c5a:	80 ff ff 
ffff800000101c5d:	48 89 d6             	mov    %rdx,%rsi
ffff800000101c60:	48 89 c7             	mov    %rax,%rdi
ffff800000101c63:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000101c6a:	80 ff ff 
ffff800000101c6d:	ff d0                	call   *%rax
}
ffff800000101c6f:	90                   	nop
ffff800000101c70:	5d                   	pop    %rbp
ffff800000101c71:	c3                   	ret

ffff800000101c72 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
ffff800000101c72:	55                   	push   %rbp
ffff800000101c73:	48 89 e5             	mov    %rsp,%rbp
ffff800000101c76:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;

  acquire(&ftable.lock);
ffff800000101c7a:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101c81:	80 ff ff 
ffff800000101c84:	48 89 c7             	mov    %rax,%rdi
ffff800000101c87:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000101c8e:	80 ff ff 
ffff800000101c91:	ff d0                	call   *%rax
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101c93:	48 b8 48 46 11 00 00 	movabs $0xffff800000114648,%rax
ffff800000101c9a:	80 ff ff 
ffff800000101c9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101ca1:	eb 3a                	jmp    ffff800000101cdd <filealloc+0x6b>
    if(f->ref == 0){
ffff800000101ca3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ca7:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101caa:	85 c0                	test   %eax,%eax
ffff800000101cac:	75 2a                	jne    ffff800000101cd8 <filealloc+0x66>
      f->ref = 1;
ffff800000101cae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101cb2:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
      release(&ftable.lock);
ffff800000101cb9:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101cc0:	80 ff ff 
ffff800000101cc3:	48 89 c7             	mov    %rax,%rdi
ffff800000101cc6:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000101ccd:	80 ff ff 
ffff800000101cd0:	ff d0                	call   *%rax
      return f;
ffff800000101cd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101cd6:	eb 33                	jmp    ffff800000101d0b <filealloc+0x99>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
ffff800000101cd8:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000101cdd:	48 b8 e8 55 11 00 00 	movabs $0xffff8000001155e8,%rax
ffff800000101ce4:	80 ff ff 
ffff800000101ce7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000101ceb:	72 b6                	jb     ffff800000101ca3 <filealloc+0x31>
    }
  }
  release(&ftable.lock);
ffff800000101ced:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101cf4:	80 ff ff 
ffff800000101cf7:	48 89 c7             	mov    %rax,%rdi
ffff800000101cfa:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000101d01:	80 ff ff 
ffff800000101d04:	ff d0                	call   *%rax
  return 0;
ffff800000101d06:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000101d0b:	c9                   	leave
ffff800000101d0c:	c3                   	ret

ffff800000101d0d <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
ffff800000101d0d:	55                   	push   %rbp
ffff800000101d0e:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d11:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101d15:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ftable.lock);
ffff800000101d19:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d20:	80 ff ff 
ffff800000101d23:	48 89 c7             	mov    %rax,%rdi
ffff800000101d26:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000101d2d:	80 ff ff 
ffff800000101d30:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d36:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d39:	85 c0                	test   %eax,%eax
ffff800000101d3b:	7f 19                	jg     ffff800000101d56 <filedup+0x49>
    panic("filedup");
ffff800000101d3d:	48 b8 a0 c4 10 00 00 	movabs $0xffff80000010c4a0,%rax
ffff800000101d44:	80 ff ff 
ffff800000101d47:	48 89 c7             	mov    %rax,%rdi
ffff800000101d4a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101d51:	80 ff ff 
ffff800000101d54:	ff d0                	call   *%rax
  f->ref++;
ffff800000101d56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d5a:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d5d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101d60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d64:	89 50 04             	mov    %edx,0x4(%rax)
  release(&ftable.lock);
ffff800000101d67:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d6e:	80 ff ff 
ffff800000101d71:	48 89 c7             	mov    %rax,%rdi
ffff800000101d74:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000101d7b:	80 ff ff 
ffff800000101d7e:	ff d0                	call   *%rax
  return f;
ffff800000101d80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000101d84:	c9                   	leave
ffff800000101d85:	c3                   	ret

ffff800000101d86 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
ffff800000101d86:	55                   	push   %rbp
ffff800000101d87:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d8a:	53                   	push   %rbx
ffff800000101d8b:	48 83 ec 48          	sub    $0x48,%rsp
ffff800000101d8f:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct file ff;

  acquire(&ftable.lock);
ffff800000101d93:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d9a:	80 ff ff 
ffff800000101d9d:	48 89 c7             	mov    %rax,%rdi
ffff800000101da0:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000101da7:	80 ff ff 
ffff800000101daa:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101dac:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101db0:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101db3:	85 c0                	test   %eax,%eax
ffff800000101db5:	7f 19                	jg     ffff800000101dd0 <fileclose+0x4a>
    panic("fileclose");
ffff800000101db7:	48 b8 a8 c4 10 00 00 	movabs $0xffff80000010c4a8,%rax
ffff800000101dbe:	80 ff ff 
ffff800000101dc1:	48 89 c7             	mov    %rax,%rdi
ffff800000101dc4:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101dcb:	80 ff ff 
ffff800000101dce:	ff d0                	call   *%rax
  if(--f->ref > 0){
ffff800000101dd0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101dd4:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101dd7:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101dda:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101dde:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101de1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101de5:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101de8:	85 c0                	test   %eax,%eax
ffff800000101dea:	7e 1e                	jle    ffff800000101e0a <fileclose+0x84>
    release(&ftable.lock);
ffff800000101dec:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101df3:	80 ff ff 
ffff800000101df6:	48 89 c7             	mov    %rax,%rdi
ffff800000101df9:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000101e00:	80 ff ff 
ffff800000101e03:	ff d0                	call   *%rax
ffff800000101e05:	e9 b2 00 00 00       	jmp    ffff800000101ebc <fileclose+0x136>
    return;
  }
  ff = *f;
ffff800000101e0a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e0e:	48 8b 08             	mov    (%rax),%rcx
ffff800000101e11:	48 8b 58 08          	mov    0x8(%rax),%rbx
ffff800000101e15:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff800000101e19:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff800000101e1d:	48 8b 48 10          	mov    0x10(%rax),%rcx
ffff800000101e21:	48 8b 58 18          	mov    0x18(%rax),%rbx
ffff800000101e25:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff800000101e29:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff800000101e2d:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000101e31:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  f->ref = 0;
ffff800000101e35:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e39:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
  f->type = FD_NONE;
ffff800000101e40:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e44:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  release(&ftable.lock);
ffff800000101e4a:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101e51:	80 ff ff 
ffff800000101e54:	48 89 c7             	mov    %rax,%rdi
ffff800000101e57:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000101e5e:	80 ff ff 
ffff800000101e61:	ff d0                	call   *%rax

  if(ff.type == FD_PIPE)
ffff800000101e63:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101e66:	83 f8 01             	cmp    $0x1,%eax
ffff800000101e69:	75 1e                	jne    ffff800000101e89 <fileclose+0x103>
    pipeclose(ff.pipe, ff.writable);
ffff800000101e6b:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffff800000101e6f:	0f be d0             	movsbl %al,%edx
ffff800000101e72:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101e76:	89 d6                	mov    %edx,%esi
ffff800000101e78:	48 89 c7             	mov    %rax,%rdi
ffff800000101e7b:	48 b8 c1 5f 10 00 00 	movabs $0xffff800000105fc1,%rax
ffff800000101e82:	80 ff ff 
ffff800000101e85:	ff d0                	call   *%rax
ffff800000101e87:	eb 33                	jmp    ffff800000101ebc <fileclose+0x136>
  else if(ff.type == FD_INODE){
ffff800000101e89:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101e8c:	83 f8 02             	cmp    $0x2,%eax
ffff800000101e8f:	75 2b                	jne    ffff800000101ebc <fileclose+0x136>
    begin_op();
ffff800000101e91:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff800000101e98:	80 ff ff 
ffff800000101e9b:	ff d0                	call   *%rax
    iput(ff.ip);
ffff800000101e9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101ea1:	48 89 c7             	mov    %rax,%rdi
ffff800000101ea4:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000101eab:	80 ff ff 
ffff800000101eae:	ff d0                	call   *%rax
    end_op();
ffff800000101eb0:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000101eb7:	80 ff ff 
ffff800000101eba:	ff d0                	call   *%rax
  }
}
ffff800000101ebc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000101ec0:	c9                   	leave
ffff800000101ec1:	c3                   	ret

ffff800000101ec2 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
ffff800000101ec2:	55                   	push   %rbp
ffff800000101ec3:	48 89 e5             	mov    %rsp,%rbp
ffff800000101ec6:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101eca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101ece:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(f->type == FD_INODE){
ffff800000101ed2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ed6:	8b 00                	mov    (%rax),%eax
ffff800000101ed8:	83 f8 02             	cmp    $0x2,%eax
ffff800000101edb:	75 53                	jne    ffff800000101f30 <filestat+0x6e>
    ilock(f->ip);
ffff800000101edd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ee1:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ee5:	48 89 c7             	mov    %rax,%rdi
ffff800000101ee8:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000101eef:	80 ff ff 
ffff800000101ef2:	ff d0                	call   *%rax
    stati(f->ip, st);
ffff800000101ef4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ef8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101efc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000101f00:	48 89 d6             	mov    %rdx,%rsi
ffff800000101f03:	48 89 c7             	mov    %rax,%rdi
ffff800000101f06:	48 b8 b7 2f 10 00 00 	movabs $0xffff800000102fb7,%rax
ffff800000101f0d:	80 ff ff 
ffff800000101f10:	ff d0                	call   *%rax
    iunlock(f->ip);
ffff800000101f12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101f16:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101f1a:	48 89 c7             	mov    %rax,%rdi
ffff800000101f1d:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000101f24:	80 ff ff 
ffff800000101f27:	ff d0                	call   *%rax
    return 0;
ffff800000101f29:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101f2e:	eb 05                	jmp    ffff800000101f35 <filestat+0x73>
  }
  return -1;
ffff800000101f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000101f35:	c9                   	leave
ffff800000101f36:	c3                   	ret

ffff800000101f37 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
ffff800000101f37:	55                   	push   %rbp
ffff800000101f38:	48 89 e5             	mov    %rsp,%rbp
ffff800000101f3b:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101f3f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101f43:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101f47:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->readable == 0)
ffff800000101f4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f4e:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffff800000101f52:	84 c0                	test   %al,%al
ffff800000101f54:	75 0a                	jne    ffff800000101f60 <fileread+0x29>
    return -1;
ffff800000101f56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101f5b:	e9 c9 00 00 00       	jmp    ffff800000102029 <fileread+0xf2>
  if(f->type == FD_PIPE)
ffff800000101f60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f64:	8b 00                	mov    (%rax),%eax
ffff800000101f66:	83 f8 01             	cmp    $0x1,%eax
ffff800000101f69:	75 26                	jne    ffff800000101f91 <fileread+0x5a>
    return piperead(f->pipe, addr, n);
ffff800000101f6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f6f:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101f73:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101f76:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101f7a:	48 89 ce             	mov    %rcx,%rsi
ffff800000101f7d:	48 89 c7             	mov    %rax,%rdi
ffff800000101f80:	48 b8 d4 61 10 00 00 	movabs $0xffff8000001061d4,%rax
ffff800000101f87:	80 ff ff 
ffff800000101f8a:	ff d0                	call   *%rax
ffff800000101f8c:	e9 98 00 00 00       	jmp    ffff800000102029 <fileread+0xf2>
  if(f->type == FD_INODE){
ffff800000101f91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f95:	8b 00                	mov    (%rax),%eax
ffff800000101f97:	83 f8 02             	cmp    $0x2,%eax
ffff800000101f9a:	75 74                	jne    ffff800000102010 <fileread+0xd9>
    ilock(f->ip);
ffff800000101f9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fa0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fa4:	48 89 c7             	mov    %rax,%rdi
ffff800000101fa7:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000101fae:	80 ff ff 
ffff800000101fb1:	ff d0                	call   *%rax
    if((r = readi(f->ip, addr, f->off, n)) > 0)
ffff800000101fb3:	8b 4d dc             	mov    -0x24(%rbp),%ecx
ffff800000101fb6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fba:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fc1:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fc5:	48 8b 75 e0          	mov    -0x20(%rbp),%rsi
ffff800000101fc9:	48 89 c7             	mov    %rax,%rdi
ffff800000101fcc:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff800000101fd3:	80 ff ff 
ffff800000101fd6:	ff d0                	call   *%rax
ffff800000101fd8:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101fdb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000101fdf:	7e 13                	jle    ffff800000101ff4 <fileread+0xbd>
      f->off += r;
ffff800000101fe1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fe5:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fe8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101feb:	01 c2                	add    %eax,%edx
ffff800000101fed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ff1:	89 50 20             	mov    %edx,0x20(%rax)
    iunlock(f->ip);
ffff800000101ff4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ff8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ffc:	48 89 c7             	mov    %rax,%rdi
ffff800000101fff:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000102006:	80 ff ff 
ffff800000102009:	ff d0                	call   *%rax
    return r;
ffff80000010200b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010200e:	eb 19                	jmp    ffff800000102029 <fileread+0xf2>
  }
  panic("fileread");
ffff800000102010:	48 b8 b2 c4 10 00 00 	movabs $0xffff80000010c4b2,%rax
ffff800000102017:	80 ff ff 
ffff80000010201a:	48 89 c7             	mov    %rax,%rdi
ffff80000010201d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102024:	80 ff ff 
ffff800000102027:	ff d0                	call   *%rax
}
ffff800000102029:	c9                   	leave
ffff80000010202a:	c3                   	ret

ffff80000010202b <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
ffff80000010202b:	55                   	push   %rbp
ffff80000010202c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010202f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102033:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000102037:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010203b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int r;

  if(f->writable == 0)
ffff80000010203e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102042:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffff800000102046:	84 c0                	test   %al,%al
ffff800000102048:	75 0a                	jne    ffff800000102054 <filewrite+0x29>
    return -1;
ffff80000010204a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010204f:	e9 63 01 00 00       	jmp    ffff8000001021b7 <filewrite+0x18c>
  if(f->type == FD_PIPE)
ffff800000102054:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102058:	8b 00                	mov    (%rax),%eax
ffff80000010205a:	83 f8 01             	cmp    $0x1,%eax
ffff80000010205d:	75 26                	jne    ffff800000102085 <filewrite+0x5a>
    return pipewrite(f->pipe, addr, n);
ffff80000010205f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102063:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000102067:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010206a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010206e:	48 89 ce             	mov    %rcx,%rsi
ffff800000102071:	48 89 c7             	mov    %rax,%rdi
ffff800000102074:	48 b8 94 60 10 00 00 	movabs $0xffff800000106094,%rax
ffff80000010207b:	80 ff ff 
ffff80000010207e:	ff d0                	call   *%rax
ffff800000102080:	e9 32 01 00 00       	jmp    ffff8000001021b7 <filewrite+0x18c>
  if(f->type == FD_INODE){
ffff800000102085:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102089:	8b 00                	mov    (%rax),%eax
ffff80000010208b:	83 f8 02             	cmp    $0x2,%eax
ffff80000010208e:	0f 85 0a 01 00 00    	jne    ffff80000010219e <filewrite+0x173>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
ffff800000102094:	c7 45 f4 00 1a 00 00 	movl   $0x1a00,-0xc(%rbp)
    int i = 0;
ffff80000010209b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    while(i < n){
ffff8000001020a2:	e9 d4 00 00 00       	jmp    ffff80000010217b <filewrite+0x150>
      int n1 = n - i;
ffff8000001020a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001020aa:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff8000001020ad:	89 45 f8             	mov    %eax,-0x8(%rbp)
      if(n1 > max)
ffff8000001020b0:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001020b3:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffff8000001020b6:	7e 06                	jle    ffff8000001020be <filewrite+0x93>
        n1 = max;
ffff8000001020b8:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001020bb:	89 45 f8             	mov    %eax,-0x8(%rbp)

      begin_op();
ffff8000001020be:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff8000001020c5:	80 ff ff 
ffff8000001020c8:	ff d0                	call   *%rax
      ilock(f->ip);
ffff8000001020ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020ce:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001020d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001020d5:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001020dc:	80 ff ff 
ffff8000001020df:	ff d0                	call   *%rax
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
ffff8000001020e1:	8b 4d f8             	mov    -0x8(%rbp),%ecx
ffff8000001020e4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020e8:	8b 50 20             	mov    0x20(%rax),%edx
ffff8000001020eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001020ee:	48 63 f0             	movslq %eax,%rsi
ffff8000001020f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001020f5:	48 01 c6             	add    %rax,%rsi
ffff8000001020f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020fc:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000102100:	48 89 c7             	mov    %rax,%rdi
ffff800000102103:	48 b8 ea 31 10 00 00 	movabs $0xffff8000001031ea,%rax
ffff80000010210a:	80 ff ff 
ffff80000010210d:	ff d0                	call   *%rax
ffff80000010210f:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000102112:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000102116:	7e 13                	jle    ffff80000010212b <filewrite+0x100>
        f->off += r;
ffff800000102118:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010211c:	8b 50 20             	mov    0x20(%rax),%edx
ffff80000010211f:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102122:	01 c2                	add    %eax,%edx
ffff800000102124:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102128:	89 50 20             	mov    %edx,0x20(%rax)
      iunlock(f->ip);
ffff80000010212b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010212f:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000102133:	48 89 c7             	mov    %rax,%rdi
ffff800000102136:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff80000010213d:	80 ff ff 
ffff800000102140:	ff d0                	call   *%rax
      end_op();
ffff800000102142:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000102149:	80 ff ff 
ffff80000010214c:	ff d0                	call   *%rax

      if(r < 0)
ffff80000010214e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000102152:	78 35                	js     ffff800000102189 <filewrite+0x15e>
        break;
      if(r != n1)
ffff800000102154:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102157:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff80000010215a:	74 19                	je     ffff800000102175 <filewrite+0x14a>
        panic("short filewrite");
ffff80000010215c:	48 b8 bb c4 10 00 00 	movabs $0xffff80000010c4bb,%rax
ffff800000102163:	80 ff ff 
ffff800000102166:	48 89 c7             	mov    %rax,%rdi
ffff800000102169:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102170:	80 ff ff 
ffff800000102173:	ff d0                	call   *%rax
      i += r;
ffff800000102175:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102178:	01 45 fc             	add    %eax,-0x4(%rbp)
    while(i < n){
ffff80000010217b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010217e:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102181:	0f 8c 20 ff ff ff    	jl     ffff8000001020a7 <filewrite+0x7c>
ffff800000102187:	eb 01                	jmp    ffff80000010218a <filewrite+0x15f>
        break;
ffff800000102189:	90                   	nop
    }
    return i == n ? n : -1;
ffff80000010218a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010218d:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102190:	75 05                	jne    ffff800000102197 <filewrite+0x16c>
ffff800000102192:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102195:	eb 20                	jmp    ffff8000001021b7 <filewrite+0x18c>
ffff800000102197:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010219c:	eb 19                	jmp    ffff8000001021b7 <filewrite+0x18c>
  }
  panic("filewrite");
ffff80000010219e:	48 b8 cb c4 10 00 00 	movabs $0xffff80000010c4cb,%rax
ffff8000001021a5:	80 ff ff 
ffff8000001021a8:	48 89 c7             	mov    %rax,%rdi
ffff8000001021ab:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001021b2:	80 ff ff 
ffff8000001021b5:	ff d0                	call   *%rax
}
ffff8000001021b7:	c9                   	leave
ffff8000001021b8:	c3                   	ret

ffff8000001021b9 <readsb>:
struct superblock sb;

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
ffff8000001021b9:	55                   	push   %rbp
ffff8000001021ba:	48 89 e5             	mov    %rsp,%rbp
ffff8000001021bd:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001021c1:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001021c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct buf *bp = bread(dev, 1);
ffff8000001021c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001021cb:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001021d0:	89 c7                	mov    %eax,%edi
ffff8000001021d2:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001021d9:	80 ff ff 
ffff8000001021dc:	ff d0                	call   *%rax
ffff8000001021de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memmove(sb, bp->data, sizeof(*sb));
ffff8000001021e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001021e6:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001021ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001021f1:	ba 1c 00 00 00       	mov    $0x1c,%edx
ffff8000001021f6:	48 89 ce             	mov    %rcx,%rsi
ffff8000001021f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001021fc:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff800000102203:	80 ff ff 
ffff800000102206:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010220c:	48 89 c7             	mov    %rax,%rdi
ffff80000010220f:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102216:	80 ff ff 
ffff800000102219:	ff d0                	call   *%rax
}
ffff80000010221b:	90                   	nop
ffff80000010221c:	c9                   	leave
ffff80000010221d:	c3                   	ret

ffff80000010221e <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
ffff80000010221e:	55                   	push   %rbp
ffff80000010221f:	48 89 e5             	mov    %rsp,%rbp
ffff800000102222:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102226:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102229:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct buf *bp = bread(dev, bno);
ffff80000010222c:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010222f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102232:	89 d6                	mov    %edx,%esi
ffff800000102234:	89 c7                	mov    %eax,%edi
ffff800000102236:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010223d:	80 ff ff 
ffff800000102240:	ff d0                	call   *%rax
ffff800000102242:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(bp->data, 0, BSIZE);
ffff800000102246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010224a:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102250:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000102255:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010225a:	48 89 c7             	mov    %rax,%rdi
ffff80000010225d:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff800000102264:	80 ff ff 
ffff800000102267:	ff d0                	call   *%rax
  log_write(bp);
ffff800000102269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010226d:	48 89 c7             	mov    %rax,%rdi
ffff800000102270:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000102277:	80 ff ff 
ffff80000010227a:	ff d0                	call   *%rax
  brelse(bp);
ffff80000010227c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102280:	48 89 c7             	mov    %rax,%rdi
ffff800000102283:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010228a:	80 ff ff 
ffff80000010228d:	ff d0                	call   *%rax
}
ffff80000010228f:	90                   	nop
ffff800000102290:	c9                   	leave
ffff800000102291:	c3                   	ret

ffff800000102292 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
ffff800000102292:	55                   	push   %rbp
ffff800000102293:	48 89 e5             	mov    %rsp,%rbp
ffff800000102296:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010229a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  int b, bi, m;
  struct buf *bp;
  for(b = 0; b < sb.size; b += BPB){
ffff80000010229d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001022a4:	e9 4a 01 00 00       	jmp    ffff8000001023f3 <balloc+0x161>
    bp = bread(dev, BBLOCK(b, sb));
ffff8000001022a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001022ac:	8d 90 ff 0f 00 00    	lea    0xfff(%rax),%edx
ffff8000001022b2:	85 c0                	test   %eax,%eax
ffff8000001022b4:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001022b7:	c1 f8 0c             	sar    $0xc,%eax
ffff8000001022ba:	89 c2                	mov    %eax,%edx
ffff8000001022bc:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff8000001022c3:	80 ff ff 
ffff8000001022c6:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001022c9:	01 c2                	add    %eax,%edx
ffff8000001022cb:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001022ce:	89 d6                	mov    %edx,%esi
ffff8000001022d0:	89 c7                	mov    %eax,%edi
ffff8000001022d2:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001022d9:	80 ff ff 
ffff8000001022dc:	ff d0                	call   *%rax
ffff8000001022de:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff8000001022e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff8000001022e9:	e9 c4 00 00 00       	jmp    ffff8000001023b2 <balloc+0x120>
      m = 1 << (bi % 8);
ffff8000001022ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001022f1:	83 e0 07             	and    $0x7,%eax
ffff8000001022f4:	ba 01 00 00 00       	mov    $0x1,%edx
ffff8000001022f9:	89 c1                	mov    %eax,%ecx
ffff8000001022fb:	d3 e2                	shl    %cl,%edx
ffff8000001022fd:	89 d0                	mov    %edx,%eax
ffff8000001022ff:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
ffff800000102302:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102305:	8d 50 07             	lea    0x7(%rax),%edx
ffff800000102308:	85 c0                	test   %eax,%eax
ffff80000010230a:	0f 48 c2             	cmovs  %edx,%eax
ffff80000010230d:	c1 f8 03             	sar    $0x3,%eax
ffff800000102310:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102314:	48 98                	cltq
ffff800000102316:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff80000010231d:	00 
ffff80000010231e:	0f b6 c0             	movzbl %al,%eax
ffff800000102321:	23 45 ec             	and    -0x14(%rbp),%eax
ffff800000102324:	85 c0                	test   %eax,%eax
ffff800000102326:	0f 85 82 00 00 00    	jne    ffff8000001023ae <balloc+0x11c>
        bp->data[bi/8] |= m;  // Mark block in use.
ffff80000010232c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010232f:	8d 50 07             	lea    0x7(%rax),%edx
ffff800000102332:	85 c0                	test   %eax,%eax
ffff800000102334:	0f 48 c2             	cmovs  %edx,%eax
ffff800000102337:	c1 f8 03             	sar    $0x3,%eax
ffff80000010233a:	89 c1                	mov    %eax,%ecx
ffff80000010233c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102340:	48 63 c1             	movslq %ecx,%rax
ffff800000102343:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff80000010234a:	00 
ffff80000010234b:	89 c2                	mov    %eax,%edx
ffff80000010234d:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102350:	09 d0                	or     %edx,%eax
ffff800000102352:	89 c6                	mov    %eax,%esi
ffff800000102354:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000102358:	48 63 c1             	movslq %ecx,%rax
ffff80000010235b:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff800000102362:	00 
        log_write(bp);
ffff800000102363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102367:	48 89 c7             	mov    %rax,%rdi
ffff80000010236a:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000102371:	80 ff ff 
ffff800000102374:	ff d0                	call   *%rax
        brelse(bp);
ffff800000102376:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010237a:	48 89 c7             	mov    %rax,%rdi
ffff80000010237d:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102384:	80 ff ff 
ffff800000102387:	ff d0                	call   *%rax
        bzero(dev, b + bi);
ffff800000102389:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010238c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010238f:	01 c2                	add    %eax,%edx
ffff800000102391:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102394:	89 d6                	mov    %edx,%esi
ffff800000102396:	89 c7                	mov    %eax,%edi
ffff800000102398:	48 b8 1e 22 10 00 00 	movabs $0xffff80000010221e,%rax
ffff80000010239f:	80 ff ff 
ffff8000001023a2:	ff d0                	call   *%rax
        return b + bi;
ffff8000001023a4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001023a7:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001023aa:	01 d0                	add    %edx,%eax
ffff8000001023ac:	eb 75                	jmp    ffff800000102423 <balloc+0x191>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
ffff8000001023ae:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff8000001023b2:	81 7d f8 ff 0f 00 00 	cmpl   $0xfff,-0x8(%rbp)
ffff8000001023b9:	7f 1e                	jg     ffff8000001023d9 <balloc+0x147>
ffff8000001023bb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001023be:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001023c1:	01 d0                	add    %edx,%eax
ffff8000001023c3:	89 c2                	mov    %eax,%edx
ffff8000001023c5:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff8000001023cc:	80 ff ff 
ffff8000001023cf:	8b 00                	mov    (%rax),%eax
ffff8000001023d1:	39 c2                	cmp    %eax,%edx
ffff8000001023d3:	0f 82 15 ff ff ff    	jb     ffff8000001022ee <balloc+0x5c>
      }
    }
    brelse(bp);
ffff8000001023d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001023dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001023e0:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001023e7:	80 ff ff 
ffff8000001023ea:	ff d0                	call   *%rax
  for(b = 0; b < sb.size; b += BPB){
ffff8000001023ec:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff8000001023f3:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff8000001023fa:	80 ff ff 
ffff8000001023fd:	8b 00                	mov    (%rax),%eax
ffff8000001023ff:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102402:	39 c2                	cmp    %eax,%edx
ffff800000102404:	0f 82 9f fe ff ff    	jb     ffff8000001022a9 <balloc+0x17>
  }
  panic("balloc: out of blocks");
ffff80000010240a:	48 b8 d5 c4 10 00 00 	movabs $0xffff80000010c4d5,%rax
ffff800000102411:	80 ff ff 
ffff800000102414:	48 89 c7             	mov    %rax,%rdi
ffff800000102417:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010241e:	80 ff ff 
ffff800000102421:	ff d0                	call   *%rax
}
ffff800000102423:	c9                   	leave
ffff800000102424:	c3                   	ret

ffff800000102425 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
ffff800000102425:	55                   	push   %rbp
ffff800000102426:	48 89 e5             	mov    %rsp,%rbp
ffff800000102429:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010242d:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102430:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int bi, m;

  readsb(dev, &sb);
ffff800000102433:	48 ba 00 56 11 00 00 	movabs $0xffff800000115600,%rdx
ffff80000010243a:	80 ff ff 
ffff80000010243d:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102440:	48 89 d6             	mov    %rdx,%rsi
ffff800000102443:	89 c7                	mov    %eax,%edi
ffff800000102445:	48 b8 b9 21 10 00 00 	movabs $0xffff8000001021b9,%rax
ffff80000010244c:	80 ff ff 
ffff80000010244f:	ff d0                	call   *%rax
  struct buf *bp = bread(dev, BBLOCK(b, sb));
ffff800000102451:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000102454:	c1 e8 0c             	shr    $0xc,%eax
ffff800000102457:	89 c2                	mov    %eax,%edx
ffff800000102459:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff800000102460:	80 ff ff 
ffff800000102463:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000102466:	01 c2                	add    %eax,%edx
ffff800000102468:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010246b:	89 d6                	mov    %edx,%esi
ffff80000010246d:	89 c7                	mov    %eax,%edi
ffff80000010246f:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102476:	80 ff ff 
ffff800000102479:	ff d0                	call   *%rax
ffff80000010247b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  bi = b % BPB;
ffff80000010247f:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000102482:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000102487:	89 45 f4             	mov    %eax,-0xc(%rbp)
  m = 1 << (bi % 8);
ffff80000010248a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010248d:	83 e0 07             	and    $0x7,%eax
ffff800000102490:	ba 01 00 00 00       	mov    $0x1,%edx
ffff800000102495:	89 c1                	mov    %eax,%ecx
ffff800000102497:	d3 e2                	shl    %cl,%edx
ffff800000102499:	89 d0                	mov    %edx,%eax
ffff80000010249b:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if((bp->data[bi/8] & m) == 0)
ffff80000010249e:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001024a1:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001024a4:	85 c0                	test   %eax,%eax
ffff8000001024a6:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001024a9:	c1 f8 03             	sar    $0x3,%eax
ffff8000001024ac:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001024b0:	48 98                	cltq
ffff8000001024b2:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001024b9:	00 
ffff8000001024ba:	0f b6 c0             	movzbl %al,%eax
ffff8000001024bd:	23 45 f0             	and    -0x10(%rbp),%eax
ffff8000001024c0:	85 c0                	test   %eax,%eax
ffff8000001024c2:	75 19                	jne    ffff8000001024dd <bfree+0xb8>
    panic("freeing free block");
ffff8000001024c4:	48 b8 eb c4 10 00 00 	movabs $0xffff80000010c4eb,%rax
ffff8000001024cb:	80 ff ff 
ffff8000001024ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001024d1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001024d8:	80 ff ff 
ffff8000001024db:	ff d0                	call   *%rax
  bp->data[bi/8] &= ~m;
ffff8000001024dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001024e0:	8d 50 07             	lea    0x7(%rax),%edx
ffff8000001024e3:	85 c0                	test   %eax,%eax
ffff8000001024e5:	0f 48 c2             	cmovs  %edx,%eax
ffff8000001024e8:	c1 f8 03             	sar    $0x3,%eax
ffff8000001024eb:	89 c1                	mov    %eax,%ecx
ffff8000001024ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001024f1:	48 63 c1             	movslq %ecx,%rax
ffff8000001024f4:	0f b6 84 02 b0 00 00 	movzbl 0xb0(%rdx,%rax,1),%eax
ffff8000001024fb:	00 
ffff8000001024fc:	89 c2                	mov    %eax,%edx
ffff8000001024fe:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102501:	f7 d0                	not    %eax
ffff800000102503:	21 d0                	and    %edx,%eax
ffff800000102505:	89 c6                	mov    %eax,%esi
ffff800000102507:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010250b:	48 63 c1             	movslq %ecx,%rax
ffff80000010250e:	40 88 b4 02 b0 00 00 	mov    %sil,0xb0(%rdx,%rax,1)
ffff800000102515:	00 
  log_write(bp);
ffff800000102516:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010251a:	48 89 c7             	mov    %rax,%rdi
ffff80000010251d:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000102524:	80 ff ff 
ffff800000102527:	ff d0                	call   *%rax
  brelse(bp);
ffff800000102529:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010252d:	48 89 c7             	mov    %rax,%rdi
ffff800000102530:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102537:	80 ff ff 
ffff80000010253a:	ff d0                	call   *%rax
}
ffff80000010253c:	90                   	nop
ffff80000010253d:	c9                   	leave
ffff80000010253e:	c3                   	ret

ffff80000010253f <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
ffff80000010253f:	55                   	push   %rbp
ffff800000102540:	48 89 e5             	mov    %rsp,%rbp
ffff800000102543:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102547:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i = 0;
ffff80000010254a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  initlock(&icache.lock, "icache");
ffff800000102551:	48 ba fe c4 10 00 00 	movabs $0xffff80000010c4fe,%rdx
ffff800000102558:	80 ff ff 
ffff80000010255b:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102562:	80 ff ff 
ffff800000102565:	48 89 d6             	mov    %rdx,%rsi
ffff800000102568:	48 89 c7             	mov    %rax,%rdi
ffff80000010256b:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000102572:	80 ff ff 
ffff800000102575:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff800000102577:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010257e:	eb 41                	jmp    ffff8000001025c1 <iinit+0x82>
    initsleeplock(&icache.inode[i].lock, "inode");
ffff800000102580:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102583:	48 98                	cltq
ffff800000102585:	48 69 c0 d8 00 00 00 	imul   $0xd8,%rax,%rax
ffff80000010258c:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff800000102590:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102597:	80 ff ff 
ffff80000010259a:	48 01 d0             	add    %rdx,%rax
ffff80000010259d:	48 83 c0 08          	add    $0x8,%rax
ffff8000001025a1:	48 ba 05 c5 10 00 00 	movabs $0xffff80000010c505,%rdx
ffff8000001025a8:	80 ff ff 
ffff8000001025ab:	48 89 d6             	mov    %rdx,%rsi
ffff8000001025ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001025b1:	48 b8 b7 74 10 00 00 	movabs $0xffff8000001074b7,%rax
ffff8000001025b8:	80 ff ff 
ffff8000001025bb:	ff d0                	call   *%rax
  for(i = 0; i < NINODE; i++) {
ffff8000001025bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001025c1:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
ffff8000001025c5:	7e b9                	jle    ffff800000102580 <iinit+0x41>
  }

  readsb(dev, &sb);
ffff8000001025c7:	48 ba 00 56 11 00 00 	movabs $0xffff800000115600,%rdx
ffff8000001025ce:	80 ff ff 
ffff8000001025d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001025d4:	48 89 d6             	mov    %rdx,%rsi
ffff8000001025d7:	89 c7                	mov    %eax,%edi
ffff8000001025d9:	48 b8 b9 21 10 00 00 	movabs $0xffff8000001021b9,%rax
ffff8000001025e0:	80 ff ff 
ffff8000001025e3:	ff d0                	call   *%rax
  /*cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);*/
}
ffff8000001025e5:	90                   	nop
ffff8000001025e6:	c9                   	leave
ffff8000001025e7:	c3                   	ret

ffff8000001025e8 <ialloc>:

// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
ffff8000001025e8:	55                   	push   %rbp
ffff8000001025e9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001025ec:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001025f0:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff8000001025f3:	89 f0                	mov    %esi,%eax
ffff8000001025f5:	66 89 45 d8          	mov    %ax,-0x28(%rbp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001025f9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff800000102600:	e9 d8 00 00 00       	jmp    ffff8000001026dd <ialloc+0xf5>
    bp = bread(dev, IBLOCK(inum, sb));
ffff800000102605:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102608:	48 98                	cltq
ffff80000010260a:	48 c1 e8 03          	shr    $0x3,%rax
ffff80000010260e:	89 c2                	mov    %eax,%edx
ffff800000102610:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff800000102617:	80 ff ff 
ffff80000010261a:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010261d:	01 c2                	add    %eax,%edx
ffff80000010261f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102622:	89 d6                	mov    %edx,%esi
ffff800000102624:	89 c7                	mov    %eax,%edi
ffff800000102626:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010262d:	80 ff ff 
ffff800000102630:	ff d0                	call   *%rax
ffff800000102632:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    dip = (struct dinode*)bp->data + inum%IPB;
ffff800000102636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010263a:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102641:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102644:	48 98                	cltq
ffff800000102646:	83 e0 07             	and    $0x7,%eax
ffff800000102649:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010264d:	48 01 d0             	add    %rdx,%rax
ffff800000102650:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(dip->type == 0){  // a free inode
ffff800000102654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102658:	0f b7 00             	movzwl (%rax),%eax
ffff80000010265b:	66 85 c0             	test   %ax,%ax
ffff80000010265e:	75 66                	jne    ffff8000001026c6 <ialloc+0xde>
      memset(dip, 0, sizeof(*dip));
ffff800000102660:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102664:	ba 40 00 00 00       	mov    $0x40,%edx
ffff800000102669:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010266e:	48 89 c7             	mov    %rax,%rdi
ffff800000102671:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff800000102678:	80 ff ff 
ffff80000010267b:	ff d0                	call   *%rax
      dip->type = type;
ffff80000010267d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102681:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff800000102685:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffff800000102688:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010268c:	48 89 c7             	mov    %rax,%rdi
ffff80000010268f:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000102696:	80 ff ff 
ffff800000102699:	ff d0                	call   *%rax
      brelse(bp);
ffff80000010269b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010269f:	48 89 c7             	mov    %rax,%rdi
ffff8000001026a2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001026a9:	80 ff ff 
ffff8000001026ac:	ff d0                	call   *%rax
      return iget(dev, inum);
ffff8000001026ae:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001026b1:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001026b4:	89 d6                	mov    %edx,%esi
ffff8000001026b6:	89 c7                	mov    %eax,%edi
ffff8000001026b8:	48 b8 22 28 10 00 00 	movabs $0xffff800000102822,%rax
ffff8000001026bf:	80 ff ff 
ffff8000001026c2:	ff d0                	call   *%rax
ffff8000001026c4:	eb 48                	jmp    ffff80000010270e <ialloc+0x126>
    }
    brelse(bp);
ffff8000001026c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001026cd:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001026d4:	80 ff ff 
ffff8000001026d7:	ff d0                	call   *%rax
  for(inum = 1; inum < sb.ninodes; inum++){
ffff8000001026d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001026dd:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff8000001026e4:	80 ff ff 
ffff8000001026e7:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001026ea:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001026ed:	39 c2                	cmp    %eax,%edx
ffff8000001026ef:	0f 82 10 ff ff ff    	jb     ffff800000102605 <ialloc+0x1d>
  }
  panic("ialloc: no inodes");
ffff8000001026f5:	48 b8 0b c5 10 00 00 	movabs $0xffff80000010c50b,%rax
ffff8000001026fc:	80 ff ff 
ffff8000001026ff:	48 89 c7             	mov    %rax,%rdi
ffff800000102702:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102709:	80 ff ff 
ffff80000010270c:	ff d0                	call   *%rax
}
ffff80000010270e:	c9                   	leave
ffff80000010270f:	c3                   	ret

ffff800000102710 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
ffff800000102710:	55                   	push   %rbp
ffff800000102711:	48 89 e5             	mov    %rsp,%rbp
ffff800000102714:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102718:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff80000010271c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102720:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102723:	c1 e8 03             	shr    $0x3,%eax
ffff800000102726:	89 c2                	mov    %eax,%edx
ffff800000102728:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff80000010272f:	80 ff ff 
ffff800000102732:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000102735:	01 c2                	add    %eax,%edx
ffff800000102737:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010273b:	8b 00                	mov    (%rax),%eax
ffff80000010273d:	89 d6                	mov    %edx,%esi
ffff80000010273f:	89 c7                	mov    %eax,%edi
ffff800000102741:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102748:	80 ff ff 
ffff80000010274b:	ff d0                	call   *%rax
ffff80000010274d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102751:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102755:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010275c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102760:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102763:	89 c0                	mov    %eax,%eax
ffff800000102765:	83 e0 07             	and    $0x7,%eax
ffff800000102768:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010276c:	48 01 d0             	add    %rdx,%rax
ffff80000010276f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  dip->type = ip->type;
ffff800000102773:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102777:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff80000010277e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102782:	66 89 10             	mov    %dx,(%rax)
  dip->major = ip->major;
ffff800000102785:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102789:	0f b7 90 96 00 00 00 	movzwl 0x96(%rax),%edx
ffff800000102790:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102794:	66 89 50 02          	mov    %dx,0x2(%rax)
  dip->minor = ip->minor;
ffff800000102798:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010279c:	0f b7 90 98 00 00 00 	movzwl 0x98(%rax),%edx
ffff8000001027a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027a7:	66 89 50 04          	mov    %dx,0x4(%rax)
  dip->nlink = ip->nlink;
ffff8000001027ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027af:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff8000001027b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027ba:	66 89 50 06          	mov    %dx,0x6(%rax)
  dip->size = ip->size;
ffff8000001027be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027c2:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff8000001027c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027cc:	89 50 08             	mov    %edx,0x8(%rax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffff8000001027cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027d3:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff8000001027da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027de:	48 83 c0 0c          	add    $0xc,%rax
ffff8000001027e2:	ba 34 00 00 00       	mov    $0x34,%edx
ffff8000001027e7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001027ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001027ed:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff8000001027f4:	80 ff ff 
ffff8000001027f7:	ff d0                	call   *%rax
  log_write(bp);
ffff8000001027f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027fd:	48 89 c7             	mov    %rax,%rdi
ffff800000102800:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000102807:	80 ff ff 
ffff80000010280a:	ff d0                	call   *%rax
  brelse(bp);
ffff80000010280c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102810:	48 89 c7             	mov    %rax,%rdi
ffff800000102813:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010281a:	80 ff ff 
ffff80000010281d:	ff d0                	call   *%rax
}
ffff80000010281f:	90                   	nop
ffff800000102820:	c9                   	leave
ffff800000102821:	c3                   	ret

ffff800000102822 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
ffff800000102822:	55                   	push   %rbp
ffff800000102823:	48 89 e5             	mov    %rsp,%rbp
ffff800000102826:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010282a:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010282d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
ffff800000102830:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102837:	80 ff ff 
ffff80000010283a:	48 89 c7             	mov    %rax,%rdi
ffff80000010283d:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000102844:	80 ff ff 
ffff800000102847:	ff d0                	call   *%rax

  // Is the inode already cached?
  empty = 0;
ffff800000102849:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff800000102850:	00 
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff800000102851:	48 b8 88 56 11 00 00 	movabs $0xffff800000115688,%rax
ffff800000102858:	80 ff ff 
ffff80000010285b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010285f:	eb 77                	jmp    ffff8000001028d8 <iget+0xb6>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
ffff800000102861:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102865:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102868:	85 c0                	test   %eax,%eax
ffff80000010286a:	7e 4a                	jle    ffff8000001028b6 <iget+0x94>
ffff80000010286c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102870:	8b 00                	mov    (%rax),%eax
ffff800000102872:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000102875:	75 3f                	jne    ffff8000001028b6 <iget+0x94>
ffff800000102877:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010287b:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010287e:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff800000102881:	75 33                	jne    ffff8000001028b6 <iget+0x94>
      ip->ref++;
ffff800000102883:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102887:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010288a:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010288d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102891:	89 50 08             	mov    %edx,0x8(%rax)
      release(&icache.lock);
ffff800000102894:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff80000010289b:	80 ff ff 
ffff80000010289e:	48 89 c7             	mov    %rax,%rdi
ffff8000001028a1:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001028a8:	80 ff ff 
ffff8000001028ab:	ff d0                	call   *%rax
      return ip;
ffff8000001028ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028b1:	e9 a7 00 00 00       	jmp    ffff80000010295d <iget+0x13b>
    }
    if(empty == 0 && ip->ref == 0) // Remember empty slot.
ffff8000001028b6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001028bb:	75 13                	jne    ffff8000001028d0 <iget+0xae>
ffff8000001028bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028c1:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001028c4:	85 c0                	test   %eax,%eax
ffff8000001028c6:	75 08                	jne    ffff8000001028d0 <iget+0xae>
      empty = ip;
ffff8000001028c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
ffff8000001028d0:	48 81 45 f8 d8 00 00 	addq   $0xd8,-0x8(%rbp)
ffff8000001028d7:	00 
ffff8000001028d8:	48 b8 b8 80 11 00 00 	movabs $0xffff8000001180b8,%rax
ffff8000001028df:	80 ff ff 
ffff8000001028e2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001028e6:	0f 82 75 ff ff ff    	jb     ffff800000102861 <iget+0x3f>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
ffff8000001028ec:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001028f1:	75 19                	jne    ffff80000010290c <iget+0xea>
    panic("iget: no inodes");
ffff8000001028f3:	48 b8 1d c5 10 00 00 	movabs $0xffff80000010c51d,%rax
ffff8000001028fa:	80 ff ff 
ffff8000001028fd:	48 89 c7             	mov    %rax,%rdi
ffff800000102900:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102907:	80 ff ff 
ffff80000010290a:	ff d0                	call   *%rax

  ip = empty;
ffff80000010290c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102910:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  ip->dev = dev;
ffff800000102914:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102918:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010291b:	89 10                	mov    %edx,(%rax)
  ip->inum = inum;
ffff80000010291d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102921:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000102924:	89 50 04             	mov    %edx,0x4(%rax)
  ip->ref = 1;
ffff800000102927:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010292b:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
  ip->flags = 0;
ffff800000102932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102936:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff80000010293d:	00 00 00 
  release(&icache.lock);
ffff800000102940:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102947:	80 ff ff 
ffff80000010294a:	48 89 c7             	mov    %rax,%rdi
ffff80000010294d:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000102954:	80 ff ff 
ffff800000102957:	ff d0                	call   *%rax

  return ip;
ffff800000102959:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010295d:	c9                   	leave
ffff80000010295e:	c3                   	ret

ffff80000010295f <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
ffff80000010295f:	55                   	push   %rbp
ffff800000102960:	48 89 e5             	mov    %rsp,%rbp
ffff800000102963:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102967:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff80000010296b:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102972:	80 ff ff 
ffff800000102975:	48 89 c7             	mov    %rax,%rdi
ffff800000102978:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010297f:	80 ff ff 
ffff800000102982:	ff d0                	call   *%rax
  ip->ref++;
ffff800000102984:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102988:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010298b:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010298e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102992:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102995:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff80000010299c:	80 ff ff 
ffff80000010299f:	48 89 c7             	mov    %rax,%rdi
ffff8000001029a2:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001029a9:	80 ff ff 
ffff8000001029ac:	ff d0                	call   *%rax
  return ip;
ffff8000001029ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001029b2:	c9                   	leave
ffff8000001029b3:	c3                   	ret

ffff8000001029b4 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
ffff8000001029b4:	55                   	push   %rbp
ffff8000001029b5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001029b8:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001029bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
ffff8000001029c0:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001029c5:	74 0b                	je     ffff8000001029d2 <ilock+0x1e>
ffff8000001029c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029cb:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001029ce:	85 c0                	test   %eax,%eax
ffff8000001029d0:	7f 19                	jg     ffff8000001029eb <ilock+0x37>
    panic("ilock");
ffff8000001029d2:	48 b8 2d c5 10 00 00 	movabs $0xffff80000010c52d,%rax
ffff8000001029d9:	80 ff ff 
ffff8000001029dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001029df:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001029e6:	80 ff ff 
ffff8000001029e9:	ff d0                	call   *%rax

  acquiresleep(&ip->lock);
ffff8000001029eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029ef:	48 83 c0 10          	add    $0x10,%rax
ffff8000001029f3:	48 89 c7             	mov    %rax,%rdi
ffff8000001029f6:	48 b8 0f 75 10 00 00 	movabs $0xffff80000010750f,%rax
ffff8000001029fd:	80 ff ff 
ffff800000102a00:	ff d0                	call   *%rax

  if(!(ip->flags & I_VALID)){
ffff800000102a02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a06:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102a0c:	83 e0 02             	and    $0x2,%eax
ffff800000102a0f:	85 c0                	test   %eax,%eax
ffff800000102a11:	0f 85 31 01 00 00    	jne    ffff800000102b48 <ilock+0x194>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
ffff800000102a17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a1b:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102a1e:	c1 e8 03             	shr    $0x3,%eax
ffff800000102a21:	89 c2                	mov    %eax,%edx
ffff800000102a23:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff800000102a2a:	80 ff ff 
ffff800000102a2d:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000102a30:	01 c2                	add    %eax,%edx
ffff800000102a32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a36:	8b 00                	mov    (%rax),%eax
ffff800000102a38:	89 d6                	mov    %edx,%esi
ffff800000102a3a:	89 c7                	mov    %eax,%edi
ffff800000102a3c:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102a43:	80 ff ff 
ffff800000102a46:	ff d0                	call   *%rax
ffff800000102a48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
ffff800000102a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a50:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102a57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a5b:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102a5e:	89 c0                	mov    %eax,%eax
ffff800000102a60:	83 e0 07             	and    $0x7,%eax
ffff800000102a63:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102a67:	48 01 d0             	add    %rdx,%rax
ffff800000102a6a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    ip->type = dip->type;
ffff800000102a6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a72:	0f b7 10             	movzwl (%rax),%edx
ffff800000102a75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a79:	66 89 90 94 00 00 00 	mov    %dx,0x94(%rax)
    ip->major = dip->major;
ffff800000102a80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a84:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffff800000102a88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a8c:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
    ip->minor = dip->minor;
ffff800000102a93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a97:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffff800000102a9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a9f:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
    ip->nlink = dip->nlink;
ffff800000102aa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102aaa:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffff800000102aae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ab2:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    ip->size = dip->size;
ffff800000102ab9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102abd:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000102ac0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ac4:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffff800000102aca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ace:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffff800000102ad2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ad6:	48 05 a0 00 00 00    	add    $0xa0,%rax
ffff800000102adc:	ba 34 00 00 00       	mov    $0x34,%edx
ffff800000102ae1:	48 89 ce             	mov    %rcx,%rsi
ffff800000102ae4:	48 89 c7             	mov    %rax,%rdi
ffff800000102ae7:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff800000102aee:	80 ff ff 
ffff800000102af1:	ff d0                	call   *%rax
    brelse(bp);
ffff800000102af3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102af7:	48 89 c7             	mov    %rax,%rdi
ffff800000102afa:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102b01:	80 ff ff 
ffff800000102b04:	ff d0                	call   *%rax
    ip->flags |= I_VALID;
ffff800000102b06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b0a:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102b10:	83 c8 02             	or     $0x2,%eax
ffff800000102b13:	89 c2                	mov    %eax,%edx
ffff800000102b15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b19:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
    if(ip->type == 0)
ffff800000102b1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b23:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102b2a:	66 85 c0             	test   %ax,%ax
ffff800000102b2d:	75 19                	jne    ffff800000102b48 <ilock+0x194>
      panic("ilock: no type");
ffff800000102b2f:	48 b8 33 c5 10 00 00 	movabs $0xffff80000010c533,%rax
ffff800000102b36:	80 ff ff 
ffff800000102b39:	48 89 c7             	mov    %rax,%rdi
ffff800000102b3c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102b43:	80 ff ff 
ffff800000102b46:	ff d0                	call   *%rax
  }
}
ffff800000102b48:	90                   	nop
ffff800000102b49:	c9                   	leave
ffff800000102b4a:	c3                   	ret

ffff800000102b4b <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
ffff800000102b4b:	55                   	push   %rbp
ffff800000102b4c:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b4f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b53:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
ffff800000102b57:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000102b5c:	74 26                	je     ffff800000102b84 <iunlock+0x39>
ffff800000102b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b62:	48 83 c0 10          	add    $0x10,%rax
ffff800000102b66:	48 89 c7             	mov    %rax,%rdi
ffff800000102b69:	48 b8 fa 75 10 00 00 	movabs $0xffff8000001075fa,%rax
ffff800000102b70:	80 ff ff 
ffff800000102b73:	ff d0                	call   *%rax
ffff800000102b75:	85 c0                	test   %eax,%eax
ffff800000102b77:	74 0b                	je     ffff800000102b84 <iunlock+0x39>
ffff800000102b79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b7d:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102b80:	85 c0                	test   %eax,%eax
ffff800000102b82:	7f 19                	jg     ffff800000102b9d <iunlock+0x52>
    panic("iunlock");
ffff800000102b84:	48 b8 42 c5 10 00 00 	movabs $0xffff80000010c542,%rax
ffff800000102b8b:	80 ff ff 
ffff800000102b8e:	48 89 c7             	mov    %rax,%rdi
ffff800000102b91:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102b98:	80 ff ff 
ffff800000102b9b:	ff d0                	call   *%rax

  releasesleep(&ip->lock);
ffff800000102b9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ba1:	48 83 c0 10          	add    $0x10,%rax
ffff800000102ba5:	48 89 c7             	mov    %rax,%rdi
ffff800000102ba8:	48 b8 95 75 10 00 00 	movabs $0xffff800000107595,%rax
ffff800000102baf:	80 ff ff 
ffff800000102bb2:	ff d0                	call   *%rax
}
ffff800000102bb4:	90                   	nop
ffff800000102bb5:	c9                   	leave
ffff800000102bb6:	c3                   	ret

ffff800000102bb7 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
ffff800000102bb7:	55                   	push   %rbp
ffff800000102bb8:	48 89 e5             	mov    %rsp,%rbp
ffff800000102bbb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102bbf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&icache.lock);
ffff800000102bc3:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102bca:	80 ff ff 
ffff800000102bcd:	48 89 c7             	mov    %rax,%rdi
ffff800000102bd0:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000102bd7:	80 ff ff 
ffff800000102bda:	ff d0                	call   *%rax
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
ffff800000102bdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102be0:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102be3:	83 f8 01             	cmp    $0x1,%eax
ffff800000102be6:	0f 85 98 00 00 00    	jne    ffff800000102c84 <iput+0xcd>
ffff800000102bec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102bf0:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102bf6:	83 e0 02             	and    $0x2,%eax
ffff800000102bf9:	85 c0                	test   %eax,%eax
ffff800000102bfb:	0f 84 83 00 00 00    	je     ffff800000102c84 <iput+0xcd>
ffff800000102c01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c05:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000102c0c:	66 85 c0             	test   %ax,%ax
ffff800000102c0f:	75 73                	jne    ffff800000102c84 <iput+0xcd>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
ffff800000102c11:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102c18:	80 ff ff 
ffff800000102c1b:	48 89 c7             	mov    %rax,%rdi
ffff800000102c1e:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000102c25:	80 ff ff 
ffff800000102c28:	ff d0                	call   *%rax
    itrunc(ip);
ffff800000102c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c2e:	48 89 c7             	mov    %rax,%rdi
ffff800000102c31:	48 b8 43 2e 10 00 00 	movabs $0xffff800000102e43,%rax
ffff800000102c38:	80 ff ff 
ffff800000102c3b:	ff d0                	call   *%rax
    ip->type = 0;
ffff800000102c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c41:	66 c7 80 94 00 00 00 	movw   $0x0,0x94(%rax)
ffff800000102c48:	00 00 
    iupdate(ip);
ffff800000102c4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c4e:	48 89 c7             	mov    %rax,%rdi
ffff800000102c51:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000102c58:	80 ff ff 
ffff800000102c5b:	ff d0                	call   *%rax
    acquire(&icache.lock);
ffff800000102c5d:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102c64:	80 ff ff 
ffff800000102c67:	48 89 c7             	mov    %rax,%rdi
ffff800000102c6a:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000102c71:	80 ff ff 
ffff800000102c74:	ff d0                	call   *%rax
    ip->flags = 0;
ffff800000102c76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c7a:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102c81:	00 00 00 
  }
  ip->ref--;
ffff800000102c84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c88:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102c8b:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000102c8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c92:	89 50 08             	mov    %edx,0x8(%rax)
  release(&icache.lock);
ffff800000102c95:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102c9c:	80 ff ff 
ffff800000102c9f:	48 89 c7             	mov    %rax,%rdi
ffff800000102ca2:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000102ca9:	80 ff ff 
ffff800000102cac:	ff d0                	call   *%rax
}
ffff800000102cae:	90                   	nop
ffff800000102caf:	c9                   	leave
ffff800000102cb0:	c3                   	ret

ffff800000102cb1 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
ffff800000102cb1:	55                   	push   %rbp
ffff800000102cb2:	48 89 e5             	mov    %rsp,%rbp
ffff800000102cb5:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102cb9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  iunlock(ip);
ffff800000102cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cc1:	48 89 c7             	mov    %rax,%rdi
ffff800000102cc4:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000102ccb:	80 ff ff 
ffff800000102cce:	ff d0                	call   *%rax
  iput(ip);
ffff800000102cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cd4:	48 89 c7             	mov    %rax,%rdi
ffff800000102cd7:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000102cde:	80 ff ff 
ffff800000102ce1:	ff d0                	call   *%rax
}
ffff800000102ce3:	90                   	nop
ffff800000102ce4:	c9                   	leave
ffff800000102ce5:	c3                   	ret

ffff800000102ce6 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
ffff800000102ce6:	55                   	push   %rbp
ffff800000102ce7:	48 89 e5             	mov    %rsp,%rbp
ffff800000102cea:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102cee:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102cf2:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
ffff800000102cf5:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffff800000102cf9:	77 47                	ja     ffff800000102d42 <bmap+0x5c>
    if((addr = ip->addrs[bn]) == 0)
ffff800000102cfb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cff:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102d02:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d06:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d09:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d10:	75 28                	jne    ffff800000102d3a <bmap+0x54>
      ip->addrs[bn] = addr = balloc(ip->dev);
ffff800000102d12:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d16:	8b 00                	mov    (%rax),%eax
ffff800000102d18:	89 c7                	mov    %eax,%edi
ffff800000102d1a:	48 b8 92 22 10 00 00 	movabs $0xffff800000102292,%rax
ffff800000102d21:	80 ff ff 
ffff800000102d24:	ff d0                	call   *%rax
ffff800000102d26:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d29:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d2d:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102d30:	48 8d 4a 28          	lea    0x28(%rdx),%rcx
ffff800000102d34:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d37:	89 14 88             	mov    %edx,(%rax,%rcx,4)
    return addr;
ffff800000102d3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102d3d:	e9 ff 00 00 00       	jmp    ffff800000102e41 <bmap+0x15b>
  }
  bn -= NDIRECT;
ffff800000102d42:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)

  if(bn < NINDIRECT){
ffff800000102d46:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffff800000102d4a:	0f 87 d8 00 00 00    	ja     ffff800000102e28 <bmap+0x142>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
ffff800000102d50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d54:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102d5a:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d5d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d61:	75 24                	jne    ffff800000102d87 <bmap+0xa1>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffff800000102d63:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d67:	8b 00                	mov    (%rax),%eax
ffff800000102d69:	89 c7                	mov    %eax,%edi
ffff800000102d6b:	48 b8 92 22 10 00 00 	movabs $0xffff800000102292,%rax
ffff800000102d72:	80 ff ff 
ffff800000102d75:	ff d0                	call   *%rax
ffff800000102d77:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d7a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d7e:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d81:	89 90 d0 00 00 00    	mov    %edx,0xd0(%rax)
    bp = bread(ip->dev, addr);
ffff800000102d87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d8b:	8b 00                	mov    (%rax),%eax
ffff800000102d8d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d90:	89 d6                	mov    %edx,%esi
ffff800000102d92:	89 c7                	mov    %eax,%edi
ffff800000102d94:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102d9b:	80 ff ff 
ffff800000102d9e:	ff d0                	call   *%rax
ffff800000102da0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102da8:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102dae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if((addr = a[bn]) == 0){
ffff800000102db2:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102db5:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102dbc:	00 
ffff800000102dbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102dc1:	48 01 d0             	add    %rdx,%rax
ffff800000102dc4:	8b 00                	mov    (%rax),%eax
ffff800000102dc6:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102dc9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102dcd:	75 41                	jne    ffff800000102e10 <bmap+0x12a>
      a[bn] = addr = balloc(ip->dev);
ffff800000102dcf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102dd3:	8b 00                	mov    (%rax),%eax
ffff800000102dd5:	89 c7                	mov    %eax,%edi
ffff800000102dd7:	48 b8 92 22 10 00 00 	movabs $0xffff800000102292,%rax
ffff800000102dde:	80 ff ff 
ffff800000102de1:	ff d0                	call   *%rax
ffff800000102de3:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102de6:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102de9:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102df0:	00 
ffff800000102df1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102df5:	48 01 c2             	add    %rax,%rdx
ffff800000102df8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102dfb:	89 02                	mov    %eax,(%rdx)
      log_write(bp);
ffff800000102dfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e01:	48 89 c7             	mov    %rax,%rdi
ffff800000102e04:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000102e0b:	80 ff ff 
ffff800000102e0e:	ff d0                	call   *%rax
    }
    brelse(bp);
ffff800000102e10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e14:	48 89 c7             	mov    %rax,%rdi
ffff800000102e17:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102e1e:	80 ff ff 
ffff800000102e21:	ff d0                	call   *%rax
    return addr;
ffff800000102e23:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102e26:	eb 19                	jmp    ffff800000102e41 <bmap+0x15b>
  }

  panic("bmap: out of range");
ffff800000102e28:	48 b8 4a c5 10 00 00 	movabs $0xffff80000010c54a,%rax
ffff800000102e2f:	80 ff ff 
ffff800000102e32:	48 89 c7             	mov    %rax,%rdi
ffff800000102e35:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102e3c:	80 ff ff 
ffff800000102e3f:	ff d0                	call   *%rax
}
ffff800000102e41:	c9                   	leave
ffff800000102e42:	c3                   	ret

ffff800000102e43 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
ffff800000102e43:	55                   	push   %rbp
ffff800000102e44:	48 89 e5             	mov    %rsp,%rbp
ffff800000102e47:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102e4b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
ffff800000102e4f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102e56:	eb 55                	jmp    ffff800000102ead <itrunc+0x6a>
    if(ip->addrs[i]){
ffff800000102e58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e5c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e5f:	48 63 d2             	movslq %edx,%rdx
ffff800000102e62:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102e66:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102e69:	85 c0                	test   %eax,%eax
ffff800000102e6b:	74 3c                	je     ffff800000102ea9 <itrunc+0x66>
      bfree(ip->dev, ip->addrs[i]);
ffff800000102e6d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e71:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e74:	48 63 d2             	movslq %edx,%rdx
ffff800000102e77:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102e7b:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102e7e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102e82:	8b 12                	mov    (%rdx),%edx
ffff800000102e84:	89 c6                	mov    %eax,%esi
ffff800000102e86:	89 d7                	mov    %edx,%edi
ffff800000102e88:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102e8f:	80 ff ff 
ffff800000102e92:	ff d0                	call   *%rax
      ip->addrs[i] = 0;
ffff800000102e94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e98:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e9b:	48 63 d2             	movslq %edx,%rdx
ffff800000102e9e:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102ea2:	c7 04 90 00 00 00 00 	movl   $0x0,(%rax,%rdx,4)
  for(i = 0; i < NDIRECT; i++){
ffff800000102ea9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102ead:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffff800000102eb1:	7e a5                	jle    ffff800000102e58 <itrunc+0x15>
    }
  }

  if(ip->addrs[NDIRECT]){
ffff800000102eb3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102eb7:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102ebd:	85 c0                	test   %eax,%eax
ffff800000102ebf:	0f 84 ce 00 00 00    	je     ffff800000102f93 <itrunc+0x150>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffff800000102ec5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102ec9:	8b 90 d0 00 00 00    	mov    0xd0(%rax),%edx
ffff800000102ecf:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102ed3:	8b 00                	mov    (%rax),%eax
ffff800000102ed5:	89 d6                	mov    %edx,%esi
ffff800000102ed7:	89 c7                	mov    %eax,%edi
ffff800000102ed9:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102ee0:	80 ff ff 
ffff800000102ee3:	ff d0                	call   *%rax
ffff800000102ee5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    a = (uint*)bp->data;
ffff800000102ee9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eed:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102ef3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    for(j = 0; j < NINDIRECT; j++){
ffff800000102ef7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102efe:	eb 4a                	jmp    ffff800000102f4a <itrunc+0x107>
      if(a[j])
ffff800000102f00:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f03:	48 98                	cltq
ffff800000102f05:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102f0c:	00 
ffff800000102f0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102f11:	48 01 d0             	add    %rdx,%rax
ffff800000102f14:	8b 00                	mov    (%rax),%eax
ffff800000102f16:	85 c0                	test   %eax,%eax
ffff800000102f18:	74 2c                	je     ffff800000102f46 <itrunc+0x103>
        bfree(ip->dev, a[j]);
ffff800000102f1a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f1d:	48 98                	cltq
ffff800000102f1f:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102f26:	00 
ffff800000102f27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102f2b:	48 01 d0             	add    %rdx,%rax
ffff800000102f2e:	8b 00                	mov    (%rax),%eax
ffff800000102f30:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102f34:	8b 12                	mov    (%rdx),%edx
ffff800000102f36:	89 c6                	mov    %eax,%esi
ffff800000102f38:	89 d7                	mov    %edx,%edi
ffff800000102f3a:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102f41:	80 ff ff 
ffff800000102f44:	ff d0                	call   *%rax
    for(j = 0; j < NINDIRECT; j++){
ffff800000102f46:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff800000102f4a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f4d:	83 f8 7f             	cmp    $0x7f,%eax
ffff800000102f50:	76 ae                	jbe    ffff800000102f00 <itrunc+0xbd>
    }
    brelse(bp);
ffff800000102f52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102f56:	48 89 c7             	mov    %rax,%rdi
ffff800000102f59:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102f60:	80 ff ff 
ffff800000102f63:	ff d0                	call   *%rax
    bfree(ip->dev, ip->addrs[NDIRECT]);
ffff800000102f65:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f69:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102f6f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102f73:	8b 12                	mov    (%rdx),%edx
ffff800000102f75:	89 c6                	mov    %eax,%esi
ffff800000102f77:	89 d7                	mov    %edx,%edi
ffff800000102f79:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102f80:	80 ff ff 
ffff800000102f83:	ff d0                	call   *%rax
    ip->addrs[NDIRECT] = 0;
ffff800000102f85:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f89:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%rax)
ffff800000102f90:	00 00 00 
  }

  ip->size = 0;
ffff800000102f93:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f97:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%rax)
ffff800000102f9e:	00 00 00 
  iupdate(ip);
ffff800000102fa1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fa5:	48 89 c7             	mov    %rax,%rdi
ffff800000102fa8:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000102faf:	80 ff ff 
ffff800000102fb2:	ff d0                	call   *%rax
}
ffff800000102fb4:	90                   	nop
ffff800000102fb5:	c9                   	leave
ffff800000102fb6:	c3                   	ret

ffff800000102fb7 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
ffff800000102fb7:	55                   	push   %rbp
ffff800000102fb8:	48 89 e5             	mov    %rsp,%rbp
ffff800000102fbb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102fbf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102fc3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  st->dev = ip->dev;
ffff800000102fc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fcb:	8b 00                	mov    (%rax),%eax
ffff800000102fcd:	89 c2                	mov    %eax,%edx
ffff800000102fcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fd3:	89 50 04             	mov    %edx,0x4(%rax)
  st->ino = ip->inum;
ffff800000102fd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fda:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000102fdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fe1:	89 50 08             	mov    %edx,0x8(%rax)
  st->type = ip->type;
ffff800000102fe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fe8:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102fef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ff3:	66 89 10             	mov    %dx,(%rax)
  st->nlink = ip->nlink;
ffff800000102ff6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ffa:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000103001:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103005:	66 89 50 0c          	mov    %dx,0xc(%rax)
  st->size = ip->size;
ffff800000103009:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010300d:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000103013:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103017:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff80000010301a:	90                   	nop
ffff80000010301b:	c9                   	leave
ffff80000010301c:	c3                   	ret

ffff80000010301d <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
ffff80000010301d:	55                   	push   %rbp
ffff80000010301e:	48 89 e5             	mov    %rsp,%rbp
ffff800000103021:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103025:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103029:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010302d:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff800000103030:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff800000103033:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103037:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010303e:	66 83 f8 03          	cmp    $0x3,%ax
ffff800000103042:	0f 85 8d 00 00 00    	jne    ffff8000001030d5 <readi+0xb8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
ffff800000103048:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010304c:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103053:	66 85 c0             	test   %ax,%ax
ffff800000103056:	78 38                	js     ffff800000103090 <readi+0x73>
ffff800000103058:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010305c:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103063:	66 83 f8 09          	cmp    $0x9,%ax
ffff800000103067:	7f 27                	jg     ffff800000103090 <readi+0x73>
ffff800000103069:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010306d:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103074:	98                   	cwtl
ffff800000103075:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff80000010307c:	80 ff ff 
ffff80000010307f:	48 98                	cltq
ffff800000103081:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103085:	48 01 d0             	add    %rdx,%rax
ffff800000103088:	48 8b 00             	mov    (%rax),%rax
ffff80000010308b:	48 85 c0             	test   %rax,%rax
ffff80000010308e:	75 0a                	jne    ffff80000010309a <readi+0x7d>
      return -1;
ffff800000103090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103095:	e9 4e 01 00 00       	jmp    ffff8000001031e8 <readi+0x1cb>
    return devsw[ip->major].read(ip, off, dst, n);
ffff80000010309a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010309e:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff8000001030a5:	98                   	cwtl
ffff8000001030a6:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff8000001030ad:	80 ff ff 
ffff8000001030b0:	48 98                	cltq
ffff8000001030b2:	48 c1 e0 04          	shl    $0x4,%rax
ffff8000001030b6:	48 01 d0             	add    %rdx,%rax
ffff8000001030b9:	4c 8b 00             	mov    (%rax),%r8
ffff8000001030bc:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff8000001030bf:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff8000001030c3:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff8000001030c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001030cd:	41 ff d0             	call   *%r8
ffff8000001030d0:	e9 13 01 00 00       	jmp    ffff8000001031e8 <readi+0x1cb>
  }

  if(off > ip->size || off + n < off)
ffff8000001030d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030d9:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001030df:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001030e2:	72 0d                	jb     ffff8000001030f1 <readi+0xd4>
ffff8000001030e4:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001030e7:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001030ea:	01 d0                	add    %edx,%eax
ffff8000001030ec:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001030ef:	73 0a                	jae    ffff8000001030fb <readi+0xde>
    return -1;
ffff8000001030f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001030f6:	e9 ed 00 00 00       	jmp    ffff8000001031e8 <readi+0x1cb>
  if(off + n > ip->size)
ffff8000001030fb:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001030fe:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103101:	01 c2                	add    %eax,%edx
ffff800000103103:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103107:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010310d:	39 d0                	cmp    %edx,%eax
ffff80000010310f:	73 10                	jae    ffff800000103121 <readi+0x104>
    n = ip->size - off;
ffff800000103111:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103115:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010311b:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffff80000010311e:	89 45 c8             	mov    %eax,-0x38(%rbp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff800000103121:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103128:	e9 ac 00 00 00       	jmp    ffff8000001031d9 <readi+0x1bc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff80000010312d:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103130:	c1 e8 09             	shr    $0x9,%eax
ffff800000103133:	89 c2                	mov    %eax,%edx
ffff800000103135:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103139:	89 d6                	mov    %edx,%esi
ffff80000010313b:	48 89 c7             	mov    %rax,%rdi
ffff80000010313e:	48 b8 e6 2c 10 00 00 	movabs $0xffff800000102ce6,%rax
ffff800000103145:	80 ff ff 
ffff800000103148:	ff d0                	call   *%rax
ffff80000010314a:	89 c2                	mov    %eax,%edx
ffff80000010314c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103150:	8b 00                	mov    (%rax),%eax
ffff800000103152:	89 d6                	mov    %edx,%esi
ffff800000103154:	89 c7                	mov    %eax,%edi
ffff800000103156:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010315d:	80 ff ff 
ffff800000103160:	ff d0                	call   *%rax
ffff800000103162:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff800000103166:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103169:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010316e:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103173:	29 c2                	sub    %eax,%edx
ffff800000103175:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103178:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010317b:	39 c2                	cmp    %eax,%edx
ffff80000010317d:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103180:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(dst, bp->data + off%BSIZE, m);
ffff800000103183:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103187:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010318e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103191:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103196:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010319a:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010319d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001031a1:	48 89 ce             	mov    %rcx,%rsi
ffff8000001031a4:	48 89 c7             	mov    %rax,%rdi
ffff8000001031a7:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff8000001031ae:	80 ff ff 
ffff8000001031b1:	ff d0                	call   *%rax
    brelse(bp);
ffff8000001031b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001031b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001031ba:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001031c1:	80 ff ff 
ffff8000001031c4:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
ffff8000001031c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031c9:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001031cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031cf:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001031d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031d5:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001031d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001031dc:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001031df:	0f 82 48 ff ff ff    	jb     ffff80000010312d <readi+0x110>
  }
  return n;
ffff8000001031e5:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001031e8:	c9                   	leave
ffff8000001031e9:	c3                   	ret

ffff8000001031ea <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
ffff8000001031ea:	55                   	push   %rbp
ffff8000001031eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001031ee:	48 83 ec 40          	sub    $0x40,%rsp
ffff8000001031f2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001031f6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001031fa:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff8000001031fd:	89 4d c8             	mov    %ecx,-0x38(%rbp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
ffff800000103200:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103204:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010320b:	66 83 f8 03          	cmp    $0x3,%ax
ffff80000010320f:	0f 85 95 00 00 00    	jne    ffff8000001032aa <writei+0xc0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
ffff800000103215:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103219:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103220:	66 85 c0             	test   %ax,%ax
ffff800000103223:	78 3c                	js     ffff800000103261 <writei+0x77>
ffff800000103225:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103229:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103230:	66 83 f8 09          	cmp    $0x9,%ax
ffff800000103234:	7f 2b                	jg     ffff800000103261 <writei+0x77>
ffff800000103236:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010323a:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103241:	98                   	cwtl
ffff800000103242:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff800000103249:	80 ff ff 
ffff80000010324c:	48 98                	cltq
ffff80000010324e:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103252:	48 01 d0             	add    %rdx,%rax
ffff800000103255:	48 83 c0 08          	add    $0x8,%rax
ffff800000103259:	48 8b 00             	mov    (%rax),%rax
ffff80000010325c:	48 85 c0             	test   %rax,%rax
ffff80000010325f:	75 0a                	jne    ffff80000010326b <writei+0x81>
      return -1;
ffff800000103261:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103266:	e9 8d 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>
    return devsw[ip->major].write(ip, off, src, n);
ffff80000010326b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010326f:	0f b7 80 96 00 00 00 	movzwl 0x96(%rax),%eax
ffff800000103276:	98                   	cwtl
ffff800000103277:	48 ba 40 45 11 00 00 	movabs $0xffff800000114540,%rdx
ffff80000010327e:	80 ff ff 
ffff800000103281:	48 98                	cltq
ffff800000103283:	48 c1 e0 04          	shl    $0x4,%rax
ffff800000103287:	48 01 d0             	add    %rdx,%rax
ffff80000010328a:	48 83 c0 08          	add    $0x8,%rax
ffff80000010328e:	4c 8b 00             	mov    (%rax),%r8
ffff800000103291:	8b 4d c8             	mov    -0x38(%rbp),%ecx
ffff800000103294:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000103298:	8b 75 cc             	mov    -0x34(%rbp),%esi
ffff80000010329b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010329f:	48 89 c7             	mov    %rax,%rdi
ffff8000001032a2:	41 ff d0             	call   *%r8
ffff8000001032a5:	e9 4e 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>
  }

  if(off > ip->size || off + n < off)
ffff8000001032aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032ae:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001032b4:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001032b7:	72 0d                	jb     ffff8000001032c6 <writei+0xdc>
ffff8000001032b9:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032bc:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001032bf:	01 d0                	add    %edx,%eax
ffff8000001032c1:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001032c4:	73 0a                	jae    ffff8000001032d0 <writei+0xe6>
    return -1;
ffff8000001032c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032cb:	e9 28 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>
  if(off + n > MAXFILE*BSIZE)
ffff8000001032d0:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032d3:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001032d6:	01 d0                	add    %edx,%eax
ffff8000001032d8:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffff8000001032dd:	76 0a                	jbe    ffff8000001032e9 <writei+0xff>
    return -1;
ffff8000001032df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032e4:	e9 0f 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff8000001032e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001032f0:	e9 bf 00 00 00       	jmp    ffff8000001033b4 <writei+0x1ca>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
ffff8000001032f5:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff8000001032f8:	c1 e8 09             	shr    $0x9,%eax
ffff8000001032fb:	89 c2                	mov    %eax,%edx
ffff8000001032fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103301:	89 d6                	mov    %edx,%esi
ffff800000103303:	48 89 c7             	mov    %rax,%rdi
ffff800000103306:	48 b8 e6 2c 10 00 00 	movabs $0xffff800000102ce6,%rax
ffff80000010330d:	80 ff ff 
ffff800000103310:	ff d0                	call   *%rax
ffff800000103312:	89 c2                	mov    %eax,%edx
ffff800000103314:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103318:	8b 00                	mov    (%rax),%eax
ffff80000010331a:	89 d6                	mov    %edx,%esi
ffff80000010331c:	89 c7                	mov    %eax,%edi
ffff80000010331e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000103325:	80 ff ff 
ffff800000103328:	ff d0                	call   *%rax
ffff80000010332a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    m = min(n - tot, BSIZE - off%BSIZE);
ffff80000010332e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103331:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103336:	ba 00 02 00 00       	mov    $0x200,%edx
ffff80000010333b:	29 c2                	sub    %eax,%edx
ffff80000010333d:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103340:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000103343:	39 c2                	cmp    %eax,%edx
ffff800000103345:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103348:	89 45 ec             	mov    %eax,-0x14(%rbp)
    memmove(bp->data + off%BSIZE, src, m);
ffff80000010334b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010334f:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000103356:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103359:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010335e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff800000103362:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000103365:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103369:	48 89 c6             	mov    %rax,%rsi
ffff80000010336c:	48 89 cf             	mov    %rcx,%rdi
ffff80000010336f:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff800000103376:	80 ff ff 
ffff800000103379:	ff d0                	call   *%rax
    log_write(bp);
ffff80000010337b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010337f:	48 89 c7             	mov    %rax,%rdi
ffff800000103382:	48 b8 3a 54 10 00 00 	movabs $0xffff80000010543a,%rax
ffff800000103389:	80 ff ff 
ffff80000010338c:	ff d0                	call   *%rax
    brelse(bp);
ffff80000010338e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103392:	48 89 c7             	mov    %rax,%rdi
ffff800000103395:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010339c:	80 ff ff 
ffff80000010339f:	ff d0                	call   *%rax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
ffff8000001033a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033a4:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001033a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033aa:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001033ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033b0:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001033b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001033b7:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001033ba:	0f 82 35 ff ff ff    	jb     ffff8000001032f5 <writei+0x10b>
  }

  if(n > 0 && off > ip->size){
ffff8000001033c0:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffff8000001033c4:	74 2f                	je     ffff8000001033f5 <writei+0x20b>
ffff8000001033c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033ca:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001033d0:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001033d3:	73 20                	jae    ffff8000001033f5 <writei+0x20b>
    ip->size = off;
ffff8000001033d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033d9:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001033dc:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
    iupdate(ip);
ffff8000001033e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001033e9:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff8000001033f0:	80 ff ff 
ffff8000001033f3:	ff d0                	call   *%rax
  }
  return n;
ffff8000001033f5:	8b 45 c8             	mov    -0x38(%rbp),%eax
}
ffff8000001033f8:	c9                   	leave
ffff8000001033f9:	c3                   	ret

ffff8000001033fa <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
ffff8000001033fa:	55                   	push   %rbp
ffff8000001033fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001033fe:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103402:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000103406:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return strncmp(s, t, DIRSIZ);
ffff80000010340a:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff80000010340e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103412:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff800000103417:	48 89 ce             	mov    %rcx,%rsi
ffff80000010341a:	48 89 c7             	mov    %rax,%rdi
ffff80000010341d:	48 b8 30 7c 10 00 00 	movabs $0xffff800000107c30,%rax
ffff800000103424:	80 ff ff 
ffff800000103427:	ff d0                	call   *%rax
}
ffff800000103429:	c9                   	leave
ffff80000010342a:	c3                   	ret

ffff80000010342b <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
ffff80000010342b:	55                   	push   %rbp
ffff80000010342c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010342f:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103433:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103437:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010343b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
ffff80000010343f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103443:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010344a:	66 83 f8 01          	cmp    $0x1,%ax
ffff80000010344e:	74 19                	je     ffff800000103469 <dirlookup+0x3e>
    panic("dirlookup not DIR");
ffff800000103450:	48 b8 5d c5 10 00 00 	movabs $0xffff80000010c55d,%rax
ffff800000103457:	80 ff ff 
ffff80000010345a:	48 89 c7             	mov    %rax,%rdi
ffff80000010345d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103464:	80 ff ff 
ffff800000103467:	ff d0                	call   *%rax

  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103469:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103470:	e9 a2 00 00 00       	jmp    ffff800000103517 <dirlookup+0xec>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000103475:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103478:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff80000010347c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103480:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103485:	48 89 c7             	mov    %rax,%rdi
ffff800000103488:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff80000010348f:	80 ff ff 
ffff800000103492:	ff d0                	call   *%rax
ffff800000103494:	83 f8 10             	cmp    $0x10,%eax
ffff800000103497:	74 19                	je     ffff8000001034b2 <dirlookup+0x87>
      panic("dirlookup read");
ffff800000103499:	48 b8 6f c5 10 00 00 	movabs $0xffff80000010c56f,%rax
ffff8000001034a0:	80 ff ff 
ffff8000001034a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001034a6:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001034ad:	80 ff ff 
ffff8000001034b0:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff8000001034b2:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034b6:	66 85 c0             	test   %ax,%ax
ffff8000001034b9:	74 57                	je     ffff800000103512 <dirlookup+0xe7>
      continue;
    if(namecmp(name, de.name) == 0){
ffff8000001034bb:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff8000001034bf:	48 8d 50 02          	lea    0x2(%rax),%rdx
ffff8000001034c3:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001034c7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001034ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001034cd:	48 b8 fa 33 10 00 00 	movabs $0xffff8000001033fa,%rax
ffff8000001034d4:	80 ff ff 
ffff8000001034d7:	ff d0                	call   *%rax
ffff8000001034d9:	85 c0                	test   %eax,%eax
ffff8000001034db:	75 36                	jne    ffff800000103513 <dirlookup+0xe8>
      // entry matches path element
      if(poff)
ffff8000001034dd:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001034e2:	74 09                	je     ffff8000001034ed <dirlookup+0xc2>
        *poff = off;
ffff8000001034e4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001034e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034eb:	89 10                	mov    %edx,(%rax)
      inum = de.inum;
ffff8000001034ed:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034f1:	0f b7 c0             	movzwl %ax,%eax
ffff8000001034f4:	89 45 f8             	mov    %eax,-0x8(%rbp)
      return iget(dp->dev, inum);
ffff8000001034f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034fb:	8b 00                	mov    (%rax),%eax
ffff8000001034fd:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103500:	89 d6                	mov    %edx,%esi
ffff800000103502:	89 c7                	mov    %eax,%edi
ffff800000103504:	48 b8 22 28 10 00 00 	movabs $0xffff800000102822,%rax
ffff80000010350b:	80 ff ff 
ffff80000010350e:	ff d0                	call   *%rax
ffff800000103510:	eb 1d                	jmp    ffff80000010352f <dirlookup+0x104>
      continue;
ffff800000103512:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff800000103513:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffff800000103517:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010351b:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103521:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000103524:	0f 82 4b ff ff ff    	jb     ffff800000103475 <dirlookup+0x4a>
    }
  }

  return 0;
ffff80000010352a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010352f:	c9                   	leave
ffff800000103530:	c3                   	ret

ffff800000103531 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
ffff800000103531:	55                   	push   %rbp
ffff800000103532:	48 89 e5             	mov    %rsp,%rbp
ffff800000103535:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103539:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010353d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103541:	89 55 cc             	mov    %edx,-0x34(%rbp)
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
ffff800000103544:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
ffff800000103548:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010354c:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000103551:	48 89 ce             	mov    %rcx,%rsi
ffff800000103554:	48 89 c7             	mov    %rax,%rdi
ffff800000103557:	48 b8 2b 34 10 00 00 	movabs $0xffff80000010342b,%rax
ffff80000010355e:	80 ff ff 
ffff800000103561:	ff d0                	call   *%rax
ffff800000103563:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000103567:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010356c:	74 1d                	je     ffff80000010358b <dirlink+0x5a>
    iput(ip);
ffff80000010356e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103572:	48 89 c7             	mov    %rax,%rdi
ffff800000103575:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff80000010357c:	80 ff ff 
ffff80000010357f:	ff d0                	call   *%rax
    return -1;
ffff800000103581:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103586:	e9 d8 00 00 00       	jmp    ffff800000103663 <dirlink+0x132>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff80000010358b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103592:	eb 4f                	jmp    ffff8000001035e3 <dirlink+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000103594:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103597:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff80000010359b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010359f:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff8000001035a4:	48 89 c7             	mov    %rax,%rdi
ffff8000001035a7:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff8000001035ae:	80 ff ff 
ffff8000001035b1:	ff d0                	call   *%rax
ffff8000001035b3:	83 f8 10             	cmp    $0x10,%eax
ffff8000001035b6:	74 19                	je     ffff8000001035d1 <dirlink+0xa0>
      panic("dirlink read");
ffff8000001035b8:	48 b8 7e c5 10 00 00 	movabs $0xffff80000010c57e,%rax
ffff8000001035bf:	80 ff ff 
ffff8000001035c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001035c5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001035cc:	80 ff ff 
ffff8000001035cf:	ff d0                	call   *%rax
    if(de.inum == 0)
ffff8000001035d1:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001035d5:	66 85 c0             	test   %ax,%ax
ffff8000001035d8:	74 1c                	je     ffff8000001035f6 <dirlink+0xc5>
  for(off = 0; off < dp->size; off += sizeof(de)){
ffff8000001035da:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001035dd:	83 c0 10             	add    $0x10,%eax
ffff8000001035e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001035e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001035e7:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001035ed:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001035f0:	39 c2                	cmp    %eax,%edx
ffff8000001035f2:	72 a0                	jb     ffff800000103594 <dirlink+0x63>
ffff8000001035f4:	eb 01                	jmp    ffff8000001035f7 <dirlink+0xc6>
      break;
ffff8000001035f6:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
ffff8000001035f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001035fb:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001035ff:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffff800000103603:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff800000103608:	48 89 c6             	mov    %rax,%rsi
ffff80000010360b:	48 89 cf             	mov    %rcx,%rdi
ffff80000010360e:	48 b8 9d 7c 10 00 00 	movabs $0xffff800000107c9d,%rax
ffff800000103615:	80 ff ff 
ffff800000103618:	ff d0                	call   *%rax
  de.inum = inum;
ffff80000010361a:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff80000010361d:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000103621:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103624:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000103628:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010362c:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000103631:	48 89 c7             	mov    %rax,%rdi
ffff800000103634:	48 b8 ea 31 10 00 00 	movabs $0xffff8000001031ea,%rax
ffff80000010363b:	80 ff ff 
ffff80000010363e:	ff d0                	call   *%rax
ffff800000103640:	83 f8 10             	cmp    $0x10,%eax
ffff800000103643:	74 19                	je     ffff80000010365e <dirlink+0x12d>
    panic("dirlink");
ffff800000103645:	48 b8 8b c5 10 00 00 	movabs $0xffff80000010c58b,%rax
ffff80000010364c:	80 ff ff 
ffff80000010364f:	48 89 c7             	mov    %rax,%rdi
ffff800000103652:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103659:	80 ff ff 
ffff80000010365c:	ff d0                	call   *%rax

  return 0;
ffff80000010365e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103663:	c9                   	leave
ffff800000103664:	c3                   	ret

ffff800000103665 <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
ffff800000103665:	55                   	push   %rbp
ffff800000103666:	48 89 e5             	mov    %rsp,%rbp
ffff800000103669:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010366d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103671:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s;
  int len;

  while(*path == '/')
ffff800000103675:	eb 05                	jmp    ffff80000010367c <skipelem+0x17>
    path++;
ffff800000103677:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff80000010367c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103680:	0f b6 00             	movzbl (%rax),%eax
ffff800000103683:	3c 2f                	cmp    $0x2f,%al
ffff800000103685:	74 f0                	je     ffff800000103677 <skipelem+0x12>
  if(*path == 0)
ffff800000103687:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010368b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010368e:	84 c0                	test   %al,%al
ffff800000103690:	75 0a                	jne    ffff80000010369c <skipelem+0x37>
    return 0;
ffff800000103692:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103697:	e9 9a 00 00 00       	jmp    ffff800000103736 <skipelem+0xd1>
  s = path;
ffff80000010369c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(*path != '/' && *path != 0)
ffff8000001036a4:	eb 05                	jmp    ffff8000001036ab <skipelem+0x46>
    path++;
ffff8000001036a6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path != '/' && *path != 0)
ffff8000001036ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036af:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036b2:	3c 2f                	cmp    $0x2f,%al
ffff8000001036b4:	74 0b                	je     ffff8000001036c1 <skipelem+0x5c>
ffff8000001036b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036ba:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036bd:	84 c0                	test   %al,%al
ffff8000001036bf:	75 e5                	jne    ffff8000001036a6 <skipelem+0x41>
  len = path - s;
ffff8000001036c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036c5:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffff8000001036c9:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(len >= DIRSIZ)
ffff8000001036cc:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffff8000001036d0:	7e 21                	jle    ffff8000001036f3 <skipelem+0x8e>
    memmove(name, s, DIRSIZ);
ffff8000001036d2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001036d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001036da:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001036df:	48 89 ce             	mov    %rcx,%rsi
ffff8000001036e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001036e5:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff8000001036ec:	80 ff ff 
ffff8000001036ef:	ff d0                	call   *%rax
ffff8000001036f1:	eb 34                	jmp    ffff800000103727 <skipelem+0xc2>
  else {
    memmove(name, s, len);
ffff8000001036f3:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001036f6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001036fa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001036fe:	48 89 ce             	mov    %rcx,%rsi
ffff800000103701:	48 89 c7             	mov    %rax,%rdi
ffff800000103704:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff80000010370b:	80 ff ff 
ffff80000010370e:	ff d0                	call   *%rax
    name[len] = 0;
ffff800000103710:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103713:	48 63 d0             	movslq %eax,%rdx
ffff800000103716:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010371a:	48 01 d0             	add    %rdx,%rax
ffff80000010371d:	c6 00 00             	movb   $0x0,(%rax)
  }
  while(*path == '/')
ffff800000103720:	eb 05                	jmp    ffff800000103727 <skipelem+0xc2>
    path++;
ffff800000103722:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
  while(*path == '/')
ffff800000103727:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010372b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010372e:	3c 2f                	cmp    $0x2f,%al
ffff800000103730:	74 f0                	je     ffff800000103722 <skipelem+0xbd>
  return path;
ffff800000103732:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff800000103736:	c9                   	leave
ffff800000103737:	c3                   	ret

ffff800000103738 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
ffff800000103738:	55                   	push   %rbp
ffff800000103739:	48 89 e5             	mov    %rsp,%rbp
ffff80000010373c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000103740:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103744:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000103747:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  struct inode *ip, *next;

  if(*path == '/')
ffff80000010374b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010374f:	0f b6 00             	movzbl (%rax),%eax
ffff800000103752:	3c 2f                	cmp    $0x2f,%al
ffff800000103754:	75 1f                	jne    ffff800000103775 <namex+0x3d>
    ip = iget(ROOTDEV, ROOTINO);
ffff800000103756:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010375b:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103760:	48 b8 22 28 10 00 00 	movabs $0xffff800000102822,%rax
ffff800000103767:	80 ff ff 
ffff80000010376a:	ff d0                	call   *%rax
ffff80000010376c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103770:	e9 f7 00 00 00       	jmp    ffff80000010386c <namex+0x134>
  else
    ip = idup(proc->cwd);
ffff800000103775:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010377c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000103780:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000103787:	48 89 c7             	mov    %rax,%rdi
ffff80000010378a:	48 b8 5f 29 10 00 00 	movabs $0xffff80000010295f,%rax
ffff800000103791:	80 ff ff 
ffff800000103794:	ff d0                	call   *%rax
ffff800000103796:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  while((path = skipelem(path, name)) != 0){
ffff80000010379a:	e9 cd 00 00 00       	jmp    ffff80000010386c <namex+0x134>
    ilock(ip);
ffff80000010379f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001037a6:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001037ad:	80 ff ff 
ffff8000001037b0:	ff d0                	call   *%rax
    if(ip->type != T_DIR){
ffff8000001037b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037b6:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001037bd:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001037c1:	74 1d                	je     ffff8000001037e0 <namex+0xa8>
      iunlockput(ip);
ffff8000001037c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001037ca:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff8000001037d1:	80 ff ff 
ffff8000001037d4:	ff d0                	call   *%rax
      return 0;
ffff8000001037d6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001037db:	e9 d9 00 00 00       	jmp    ffff8000001038b9 <namex+0x181>
    }
    if(nameiparent && *path == '\0'){
ffff8000001037e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff8000001037e4:	74 27                	je     ffff80000010380d <namex+0xd5>
ffff8000001037e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001037ea:	0f b6 00             	movzbl (%rax),%eax
ffff8000001037ed:	84 c0                	test   %al,%al
ffff8000001037ef:	75 1c                	jne    ffff80000010380d <namex+0xd5>
      iunlock(ip);  // Stop one level early.
ffff8000001037f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001037f8:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff8000001037ff:	80 ff ff 
ffff800000103802:	ff d0                	call   *%rax
      return ip;
ffff800000103804:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103808:	e9 ac 00 00 00       	jmp    ffff8000001038b9 <namex+0x181>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
ffff80000010380d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff800000103811:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103815:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010381a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010381d:	48 89 c7             	mov    %rax,%rdi
ffff800000103820:	48 b8 2b 34 10 00 00 	movabs $0xffff80000010342b,%rax
ffff800000103827:	80 ff ff 
ffff80000010382a:	ff d0                	call   *%rax
ffff80000010382c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000103830:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000103835:	75 1a                	jne    ffff800000103851 <namex+0x119>
      iunlockput(ip);
ffff800000103837:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010383b:	48 89 c7             	mov    %rax,%rdi
ffff80000010383e:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000103845:	80 ff ff 
ffff800000103848:	ff d0                	call   *%rax
      return 0;
ffff80000010384a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010384f:	eb 68                	jmp    ffff8000001038b9 <namex+0x181>
    }
    iunlockput(ip);
ffff800000103851:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103855:	48 89 c7             	mov    %rax,%rdi
ffff800000103858:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010385f:	80 ff ff 
ffff800000103862:	ff d0                	call   *%rax
    ip = next;
ffff800000103864:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103868:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((path = skipelem(path, name)) != 0){
ffff80000010386c:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000103870:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103874:	48 89 d6             	mov    %rdx,%rsi
ffff800000103877:	48 89 c7             	mov    %rax,%rdi
ffff80000010387a:	48 b8 65 36 10 00 00 	movabs $0xffff800000103665,%rax
ffff800000103881:	80 ff ff 
ffff800000103884:	ff d0                	call   *%rax
ffff800000103886:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010388a:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010388f:	0f 85 0a ff ff ff    	jne    ffff80000010379f <namex+0x67>
  }
  if(nameiparent){
ffff800000103895:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff800000103899:	74 1a                	je     ffff8000001038b5 <namex+0x17d>
    iput(ip);
ffff80000010389b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010389f:	48 89 c7             	mov    %rax,%rdi
ffff8000001038a2:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff8000001038a9:	80 ff ff 
ffff8000001038ac:	ff d0                	call   *%rax
    return 0;
ffff8000001038ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001038b3:	eb 04                	jmp    ffff8000001038b9 <namex+0x181>
  }
  return ip;
ffff8000001038b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001038b9:	c9                   	leave
ffff8000001038ba:	c3                   	ret

ffff8000001038bb <namei>:

struct inode*
namei(char *path)
{
ffff8000001038bb:	55                   	push   %rbp
ffff8000001038bc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038bf:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001038c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  char name[DIRSIZ];
  return namex(path, 0, name);
ffff8000001038c7:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffff8000001038cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001038cf:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001038d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001038d7:	48 b8 38 37 10 00 00 	movabs $0xffff800000103738,%rax
ffff8000001038de:	80 ff ff 
ffff8000001038e1:	ff d0                	call   *%rax
}
ffff8000001038e3:	c9                   	leave
ffff8000001038e4:	c3                   	ret

ffff8000001038e5 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
ffff8000001038e5:	55                   	push   %rbp
ffff8000001038e6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038e9:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001038ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001038f1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  return namex(path, 1, name);
ffff8000001038f5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001038f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001038fd:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000103902:	48 89 c7             	mov    %rax,%rdi
ffff800000103905:	48 b8 38 37 10 00 00 	movabs $0xffff800000103738,%rax
ffff80000010390c:	80 ff ff 
ffff80000010390f:	ff d0                	call   *%rax
}
ffff800000103911:	c9                   	leave
ffff800000103912:	c3                   	ret

ffff800000103913 <inb>:
{
ffff800000103913:	55                   	push   %rbp
ffff800000103914:	48 89 e5             	mov    %rsp,%rbp
ffff800000103917:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010391b:	89 f8                	mov    %edi,%eax
ffff80000010391d:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000103921:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000103925:	89 c2                	mov    %eax,%edx
ffff800000103927:	ec                   	in     (%dx),%al
ffff800000103928:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010392b:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff80000010392f:	c9                   	leave
ffff800000103930:	c3                   	ret

ffff800000103931 <insl>:
{
ffff800000103931:	55                   	push   %rbp
ffff800000103932:	48 89 e5             	mov    %rsp,%rbp
ffff800000103935:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103939:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010393c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103940:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep insl" :
ffff800000103943:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103946:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff80000010394a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010394d:	48 89 ce             	mov    %rcx,%rsi
ffff800000103950:	48 89 f7             	mov    %rsi,%rdi
ffff800000103953:	89 c1                	mov    %eax,%ecx
ffff800000103955:	fc                   	cld
ffff800000103956:	f3 6d                	rep insl (%dx),(%rdi)
ffff800000103958:	89 c8                	mov    %ecx,%eax
ffff80000010395a:	48 89 fe             	mov    %rdi,%rsi
ffff80000010395d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103961:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffff800000103964:	90                   	nop
ffff800000103965:	c9                   	leave
ffff800000103966:	c3                   	ret

ffff800000103967 <outb>:
{
ffff800000103967:	55                   	push   %rbp
ffff800000103968:	48 89 e5             	mov    %rsp,%rbp
ffff80000010396b:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010396f:	89 fa                	mov    %edi,%edx
ffff800000103971:	89 f0                	mov    %esi,%eax
ffff800000103973:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000103977:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff80000010397a:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010397e:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000103982:	ee                   	out    %al,(%dx)
}
ffff800000103983:	90                   	nop
ffff800000103984:	c9                   	leave
ffff800000103985:	c3                   	ret

ffff800000103986 <outsl>:
{
ffff800000103986:	55                   	push   %rbp
ffff800000103987:	48 89 e5             	mov    %rsp,%rbp
ffff80000010398a:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010398e:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103991:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103995:	89 55 f8             	mov    %edx,-0x8(%rbp)
  asm volatile("cld; rep outsl" :
ffff800000103998:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010399b:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff80000010399f:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001039a2:	48 89 ce             	mov    %rcx,%rsi
ffff8000001039a5:	89 c1                	mov    %eax,%ecx
ffff8000001039a7:	fc                   	cld
ffff8000001039a8:	f3 6f                	rep outsl (%rsi),(%dx)
ffff8000001039aa:	89 c8                	mov    %ecx,%eax
ffff8000001039ac:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001039b0:	89 45 f8             	mov    %eax,-0x8(%rbp)
}
ffff8000001039b3:	90                   	nop
ffff8000001039b4:	c9                   	leave
ffff8000001039b5:	c3                   	ret

ffff8000001039b6 <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
ffff8000001039b6:	55                   	push   %rbp
ffff8000001039b7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039ba:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001039be:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
ffff8000001039c1:	90                   	nop
ffff8000001039c2:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff8000001039c7:	48 b8 13 39 10 00 00 	movabs $0xffff800000103913,%rax
ffff8000001039ce:	80 ff ff 
ffff8000001039d1:	ff d0                	call   *%rax
ffff8000001039d3:	0f b6 c0             	movzbl %al,%eax
ffff8000001039d6:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001039d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001039dc:	25 c0 00 00 00       	and    $0xc0,%eax
ffff8000001039e1:	83 f8 40             	cmp    $0x40,%eax
ffff8000001039e4:	75 dc                	jne    ffff8000001039c2 <idewait+0xc>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
ffff8000001039e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff8000001039ea:	74 11                	je     ffff8000001039fd <idewait+0x47>
ffff8000001039ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001039ef:	83 e0 21             	and    $0x21,%eax
ffff8000001039f2:	85 c0                	test   %eax,%eax
ffff8000001039f4:	74 07                	je     ffff8000001039fd <idewait+0x47>
    return -1;
ffff8000001039f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001039fb:	eb 05                	jmp    ffff800000103a02 <idewait+0x4c>
  return 0;
ffff8000001039fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000103a02:	c9                   	leave
ffff800000103a03:	c3                   	ret

ffff800000103a04 <ideinit>:

void
ideinit(void)
{
ffff800000103a04:	55                   	push   %rbp
ffff800000103a05:	48 89 e5             	mov    %rsp,%rbp
ffff800000103a08:	48 83 ec 10          	sub    $0x10,%rsp
  initlock(&idelock, "ide");
ffff800000103a0c:	48 ba 93 c5 10 00 00 	movabs $0xffff80000010c593,%rdx
ffff800000103a13:	80 ff ff 
ffff800000103a16:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103a1d:	80 ff ff 
ffff800000103a20:	48 89 d6             	mov    %rdx,%rsi
ffff800000103a23:	48 89 c7             	mov    %rax,%rdi
ffff800000103a26:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000103a2d:	80 ff ff 
ffff800000103a30:	ff d0                	call   *%rax
  ioapicenable(IRQ_IDE, ncpu - 1);
ffff800000103a32:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000103a39:	80 ff ff 
ffff800000103a3c:	8b 00                	mov    (%rax),%eax
ffff800000103a3e:	83 e8 01             	sub    $0x1,%eax
ffff800000103a41:	89 c6                	mov    %eax,%esi
ffff800000103a43:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff800000103a48:	48 b8 96 40 10 00 00 	movabs $0xffff800000104096,%rax
ffff800000103a4f:	80 ff ff 
ffff800000103a52:	ff d0                	call   *%rax
  idewait(0);
ffff800000103a54:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103a59:	48 b8 b6 39 10 00 00 	movabs $0xffff8000001039b6,%rax
ffff800000103a60:	80 ff ff 
ffff800000103a63:	ff d0                	call   *%rax

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
ffff800000103a65:	be f0 00 00 00       	mov    $0xf0,%esi
ffff800000103a6a:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103a6f:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103a76:	80 ff ff 
ffff800000103a79:	ff d0                	call   *%rax
  for(int i=0; i<1000; i++){
ffff800000103a7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103a82:	eb 2b                	jmp    ffff800000103aaf <ideinit+0xab>
    if(inb(0x1f7) != 0){
ffff800000103a84:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103a89:	48 b8 13 39 10 00 00 	movabs $0xffff800000103913,%rax
ffff800000103a90:	80 ff ff 
ffff800000103a93:	ff d0                	call   *%rax
ffff800000103a95:	84 c0                	test   %al,%al
ffff800000103a97:	74 12                	je     ffff800000103aab <ideinit+0xa7>
      havedisk1 = 1;
ffff800000103a99:	48 b8 30 81 11 00 00 	movabs $0xffff800000118130,%rax
ffff800000103aa0:	80 ff ff 
ffff800000103aa3:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
      break;
ffff800000103aa9:	eb 0d                	jmp    ffff800000103ab8 <ideinit+0xb4>
  for(int i=0; i<1000; i++){
ffff800000103aab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103aaf:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffff800000103ab6:	7e cc                	jle    ffff800000103a84 <ideinit+0x80>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
ffff800000103ab8:	be e0 00 00 00       	mov    $0xe0,%esi
ffff800000103abd:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103ac2:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103ac9:	80 ff ff 
ffff800000103acc:	ff d0                	call   *%rax
}
ffff800000103ace:	90                   	nop
ffff800000103acf:	c9                   	leave
ffff800000103ad0:	c3                   	ret

ffff800000103ad1 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
ffff800000103ad1:	55                   	push   %rbp
ffff800000103ad2:	48 89 e5             	mov    %rsp,%rbp
ffff800000103ad5:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103ad9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  if(b == 0)
ffff800000103add:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103ae2:	75 19                	jne    ffff800000103afd <idestart+0x2c>
    panic("idestart");
ffff800000103ae4:	48 b8 97 c5 10 00 00 	movabs $0xffff80000010c597,%rax
ffff800000103aeb:	80 ff ff 
ffff800000103aee:	48 89 c7             	mov    %rax,%rdi
ffff800000103af1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103af8:	80 ff ff 
ffff800000103afb:	ff d0                	call   *%rax
  if(b->blockno >= FSSIZE)
ffff800000103afd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b01:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000103b04:	3d e7 03 00 00       	cmp    $0x3e7,%eax
ffff800000103b09:	76 19                	jbe    ffff800000103b24 <idestart+0x53>
    panic("incorrect blockno");
ffff800000103b0b:	48 b8 a0 c5 10 00 00 	movabs $0xffff80000010c5a0,%rax
ffff800000103b12:	80 ff ff 
ffff800000103b15:	48 89 c7             	mov    %rax,%rdi
ffff800000103b18:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103b1f:	80 ff ff 
ffff800000103b22:	ff d0                	call   *%rax
  int sector_per_block =  BSIZE/SECTOR_SIZE;
ffff800000103b24:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
  int sector = b->blockno * sector_per_block;
ffff800000103b2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b2f:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000103b32:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103b35:	0f af c2             	imul   %edx,%eax
ffff800000103b38:	89 45 f0             	mov    %eax,-0x10(%rbp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
ffff800000103b3b:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103b3f:	75 09                	jne    ffff800000103b4a <idestart+0x79>
ffff800000103b41:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff800000103b48:	eb 07                	jmp    ffff800000103b51 <idestart+0x80>
ffff800000103b4a:	c7 45 fc c4 00 00 00 	movl   $0xc4,-0x4(%rbp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
ffff800000103b51:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103b55:	75 09                	jne    ffff800000103b60 <idestart+0x8f>
ffff800000103b57:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
ffff800000103b5e:	eb 07                	jmp    ffff800000103b67 <idestart+0x96>
ffff800000103b60:	c7 45 f8 c5 00 00 00 	movl   $0xc5,-0x8(%rbp)

  if (sector_per_block > 7) panic("idestart");
ffff800000103b67:	83 7d f4 07          	cmpl   $0x7,-0xc(%rbp)
ffff800000103b6b:	7e 19                	jle    ffff800000103b86 <idestart+0xb5>
ffff800000103b6d:	48 b8 97 c5 10 00 00 	movabs $0xffff80000010c597,%rax
ffff800000103b74:	80 ff ff 
ffff800000103b77:	48 89 c7             	mov    %rax,%rdi
ffff800000103b7a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103b81:	80 ff ff 
ffff800000103b84:	ff d0                	call   *%rax

  idewait(0);
ffff800000103b86:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103b8b:	48 b8 b6 39 10 00 00 	movabs $0xffff8000001039b6,%rax
ffff800000103b92:	80 ff ff 
ffff800000103b95:	ff d0                	call   *%rax
  outb(0x3f6, 0);  // generate interrupt
ffff800000103b97:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103b9c:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffff800000103ba1:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103ba8:	80 ff ff 
ffff800000103bab:	ff d0                	call   *%rax
  outb(0x1f2, sector_per_block);  // number of sectors
ffff800000103bad:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103bb0:	0f b6 c0             	movzbl %al,%eax
ffff800000103bb3:	89 c6                	mov    %eax,%esi
ffff800000103bb5:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffff800000103bba:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103bc1:	80 ff ff 
ffff800000103bc4:	ff d0                	call   *%rax
  outb(0x1f3, sector & 0xff);
ffff800000103bc6:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103bc9:	0f b6 c0             	movzbl %al,%eax
ffff800000103bcc:	89 c6                	mov    %eax,%esi
ffff800000103bce:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffff800000103bd3:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103bda:	80 ff ff 
ffff800000103bdd:	ff d0                	call   *%rax
  outb(0x1f4, (sector >> 8) & 0xff);
ffff800000103bdf:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103be2:	c1 f8 08             	sar    $0x8,%eax
ffff800000103be5:	0f b6 c0             	movzbl %al,%eax
ffff800000103be8:	89 c6                	mov    %eax,%esi
ffff800000103bea:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffff800000103bef:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103bf6:	80 ff ff 
ffff800000103bf9:	ff d0                	call   *%rax
  outb(0x1f5, (sector >> 16) & 0xff);
ffff800000103bfb:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103bfe:	c1 f8 10             	sar    $0x10,%eax
ffff800000103c01:	0f b6 c0             	movzbl %al,%eax
ffff800000103c04:	89 c6                	mov    %eax,%esi
ffff800000103c06:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffff800000103c0b:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103c12:	80 ff ff 
ffff800000103c15:	ff d0                	call   *%rax
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
ffff800000103c17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c1b:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103c1e:	c1 e0 04             	shl    $0x4,%eax
ffff800000103c21:	83 e0 10             	and    $0x10,%eax
ffff800000103c24:	89 c2                	mov    %eax,%edx
ffff800000103c26:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103c29:	c1 f8 18             	sar    $0x18,%eax
ffff800000103c2c:	83 e0 0f             	and    $0xf,%eax
ffff800000103c2f:	09 d0                	or     %edx,%eax
ffff800000103c31:	83 c8 e0             	or     $0xffffffe0,%eax
ffff800000103c34:	0f b6 c0             	movzbl %al,%eax
ffff800000103c37:	89 c6                	mov    %eax,%esi
ffff800000103c39:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103c3e:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103c45:	80 ff ff 
ffff800000103c48:	ff d0                	call   *%rax
  if(b->flags & B_DIRTY){
ffff800000103c4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c4e:	8b 00                	mov    (%rax),%eax
ffff800000103c50:	83 e0 04             	and    $0x4,%eax
ffff800000103c53:	85 c0                	test   %eax,%eax
ffff800000103c55:	74 3e                	je     ffff800000103c95 <idestart+0x1c4>
    outb(0x1f7, write_cmd);
ffff800000103c57:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c5a:	0f b6 c0             	movzbl %al,%eax
ffff800000103c5d:	89 c6                	mov    %eax,%esi
ffff800000103c5f:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103c64:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103c6b:	80 ff ff 
ffff800000103c6e:	ff d0                	call   *%rax
    outsl(0x1f0, b->data, BSIZE/4);
ffff800000103c70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c74:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103c7a:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103c7f:	48 89 c6             	mov    %rax,%rsi
ffff800000103c82:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103c87:	48 b8 86 39 10 00 00 	movabs $0xffff800000103986,%rax
ffff800000103c8e:	80 ff ff 
ffff800000103c91:	ff d0                	call   *%rax
  } else {
    outb(0x1f7, read_cmd);
  }
}
ffff800000103c93:	eb 19                	jmp    ffff800000103cae <idestart+0x1dd>
    outb(0x1f7, read_cmd);
ffff800000103c95:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103c98:	0f b6 c0             	movzbl %al,%eax
ffff800000103c9b:	89 c6                	mov    %eax,%esi
ffff800000103c9d:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103ca2:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103ca9:	80 ff ff 
ffff800000103cac:	ff d0                	call   *%rax
}
ffff800000103cae:	90                   	nop
ffff800000103caf:	c9                   	leave
ffff800000103cb0:	c3                   	ret

ffff800000103cb1 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
ffff800000103cb1:	55                   	push   %rbp
ffff800000103cb2:	48 89 e5             	mov    %rsp,%rbp
ffff800000103cb5:	48 83 ec 10          	sub    $0x10,%rsp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
ffff800000103cb9:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103cc0:	80 ff ff 
ffff800000103cc3:	48 89 c7             	mov    %rax,%rdi
ffff800000103cc6:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000103ccd:	80 ff ff 
ffff800000103cd0:	ff d0                	call   *%rax
  if((b = idequeue) == 0){
ffff800000103cd2:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103cd9:	80 ff ff 
ffff800000103cdc:	48 8b 00             	mov    (%rax),%rax
ffff800000103cdf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103ce3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000103ce8:	75 1e                	jne    ffff800000103d08 <ideintr+0x57>
    release(&idelock);
ffff800000103cea:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103cf1:	80 ff ff 
ffff800000103cf4:	48 89 c7             	mov    %rax,%rdi
ffff800000103cf7:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000103cfe:	80 ff ff 
ffff800000103d01:	ff d0                	call   *%rax
    // cprintf("spurious IDE interrupt\n");
    return;
ffff800000103d03:	e9 d9 00 00 00       	jmp    ffff800000103de1 <ideintr+0x130>
  }
  idequeue = b->qnext;
ffff800000103d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d0c:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
ffff800000103d13:	48 ba 28 81 11 00 00 	movabs $0xffff800000118128,%rdx
ffff800000103d1a:	80 ff ff 
ffff800000103d1d:	48 89 02             	mov    %rax,(%rdx)

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
ffff800000103d20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d24:	8b 00                	mov    (%rax),%eax
ffff800000103d26:	83 e0 04             	and    $0x4,%eax
ffff800000103d29:	85 c0                	test   %eax,%eax
ffff800000103d2b:	75 38                	jne    ffff800000103d65 <ideintr+0xb4>
ffff800000103d2d:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103d32:	48 b8 b6 39 10 00 00 	movabs $0xffff8000001039b6,%rax
ffff800000103d39:	80 ff ff 
ffff800000103d3c:	ff d0                	call   *%rax
ffff800000103d3e:	85 c0                	test   %eax,%eax
ffff800000103d40:	78 23                	js     ffff800000103d65 <ideintr+0xb4>
    insl(0x1f0, b->data, BSIZE/4);
ffff800000103d42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d46:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103d4c:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103d51:	48 89 c6             	mov    %rax,%rsi
ffff800000103d54:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103d59:	48 b8 31 39 10 00 00 	movabs $0xffff800000103931,%rax
ffff800000103d60:	80 ff ff 
ffff800000103d63:	ff d0                	call   *%rax

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
ffff800000103d65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d69:	8b 00                	mov    (%rax),%eax
ffff800000103d6b:	83 c8 02             	or     $0x2,%eax
ffff800000103d6e:	89 c2                	mov    %eax,%edx
ffff800000103d70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d74:	89 10                	mov    %edx,(%rax)
  b->flags &= ~B_DIRTY;
ffff800000103d76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d7a:	8b 00                	mov    (%rax),%eax
ffff800000103d7c:	83 e0 fb             	and    $0xfffffffb,%eax
ffff800000103d7f:	89 c2                	mov    %eax,%edx
ffff800000103d81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d85:	89 10                	mov    %edx,(%rax)
  wakeup(b);
ffff800000103d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d8b:	48 89 c7             	mov    %rax,%rdi
ffff800000103d8e:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff800000103d95:	80 ff ff 
ffff800000103d98:	ff d0                	call   *%rax

  // Start disk on next buf in queue.
  if(idequeue != 0)
ffff800000103d9a:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103da1:	80 ff ff 
ffff800000103da4:	48 8b 00             	mov    (%rax),%rax
ffff800000103da7:	48 85 c0             	test   %rax,%rax
ffff800000103daa:	74 1c                	je     ffff800000103dc8 <ideintr+0x117>
    idestart(idequeue);
ffff800000103dac:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103db3:	80 ff ff 
ffff800000103db6:	48 8b 00             	mov    (%rax),%rax
ffff800000103db9:	48 89 c7             	mov    %rax,%rdi
ffff800000103dbc:	48 b8 d1 3a 10 00 00 	movabs $0xffff800000103ad1,%rax
ffff800000103dc3:	80 ff ff 
ffff800000103dc6:	ff d0                	call   *%rax

  release(&idelock);
ffff800000103dc8:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103dcf:	80 ff ff 
ffff800000103dd2:	48 89 c7             	mov    %rax,%rdi
ffff800000103dd5:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000103ddc:	80 ff ff 
ffff800000103ddf:	ff d0                	call   *%rax
}
ffff800000103de1:	c9                   	leave
ffff800000103de2:	c3                   	ret

ffff800000103de3 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
ffff800000103de3:	55                   	push   %rbp
ffff800000103de4:	48 89 e5             	mov    %rsp,%rbp
ffff800000103de7:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103deb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct buf **pp;

  if(!holdingsleep(&b->lock))
ffff800000103def:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103df3:	48 83 c0 10          	add    $0x10,%rax
ffff800000103df7:	48 89 c7             	mov    %rax,%rdi
ffff800000103dfa:	48 b8 fa 75 10 00 00 	movabs $0xffff8000001075fa,%rax
ffff800000103e01:	80 ff ff 
ffff800000103e04:	ff d0                	call   *%rax
ffff800000103e06:	85 c0                	test   %eax,%eax
ffff800000103e08:	75 19                	jne    ffff800000103e23 <iderw+0x40>
    panic("iderw: buf not locked");
ffff800000103e0a:	48 b8 b2 c5 10 00 00 	movabs $0xffff80000010c5b2,%rax
ffff800000103e11:	80 ff ff 
ffff800000103e14:	48 89 c7             	mov    %rax,%rdi
ffff800000103e17:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103e1e:	80 ff ff 
ffff800000103e21:	ff d0                	call   *%rax
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
ffff800000103e23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e27:	8b 00                	mov    (%rax),%eax
ffff800000103e29:	83 e0 06             	and    $0x6,%eax
ffff800000103e2c:	83 f8 02             	cmp    $0x2,%eax
ffff800000103e2f:	75 19                	jne    ffff800000103e4a <iderw+0x67>
    panic("iderw: nothing to do");
ffff800000103e31:	48 b8 c8 c5 10 00 00 	movabs $0xffff80000010c5c8,%rax
ffff800000103e38:	80 ff ff 
ffff800000103e3b:	48 89 c7             	mov    %rax,%rdi
ffff800000103e3e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103e45:	80 ff ff 
ffff800000103e48:	ff d0                	call   *%rax
  if(b->dev != 0 && !havedisk1)
ffff800000103e4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e4e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103e51:	85 c0                	test   %eax,%eax
ffff800000103e53:	74 29                	je     ffff800000103e7e <iderw+0x9b>
ffff800000103e55:	48 b8 30 81 11 00 00 	movabs $0xffff800000118130,%rax
ffff800000103e5c:	80 ff ff 
ffff800000103e5f:	8b 00                	mov    (%rax),%eax
ffff800000103e61:	85 c0                	test   %eax,%eax
ffff800000103e63:	75 19                	jne    ffff800000103e7e <iderw+0x9b>
    panic("iderw: ide disk 1 not present");
ffff800000103e65:	48 b8 dd c5 10 00 00 	movabs $0xffff80000010c5dd,%rax
ffff800000103e6c:	80 ff ff 
ffff800000103e6f:	48 89 c7             	mov    %rax,%rdi
ffff800000103e72:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103e79:	80 ff ff 
ffff800000103e7c:	ff d0                	call   *%rax

  acquire(&idelock);  //DOC:acquire-lock
ffff800000103e7e:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103e85:	80 ff ff 
ffff800000103e88:	48 89 c7             	mov    %rax,%rdi
ffff800000103e8b:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000103e92:	80 ff ff 
ffff800000103e95:	ff d0                	call   *%rax

  // Append b to idequeue.
  b->qnext = 0;
ffff800000103e97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e9b:	48 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%rax)
ffff800000103ea2:	00 00 00 00 
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
ffff800000103ea6:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103ead:	80 ff ff 
ffff800000103eb0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103eb4:	eb 11                	jmp    ffff800000103ec7 <iderw+0xe4>
ffff800000103eb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103eba:	48 8b 00             	mov    (%rax),%rax
ffff800000103ebd:	48 05 a8 00 00 00    	add    $0xa8,%rax
ffff800000103ec3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103ec7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103ecb:	48 8b 00             	mov    (%rax),%rax
ffff800000103ece:	48 85 c0             	test   %rax,%rax
ffff800000103ed1:	75 e3                	jne    ffff800000103eb6 <iderw+0xd3>
    ;
  *pp = b;
ffff800000103ed3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103ed7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000103edb:	48 89 10             	mov    %rdx,(%rax)

  // Start disk if necessary.
  if(idequeue == b)
ffff800000103ede:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103ee5:	80 ff ff 
ffff800000103ee8:	48 8b 00             	mov    (%rax),%rax
ffff800000103eeb:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000103eef:	75 35                	jne    ffff800000103f26 <iderw+0x143>
    idestart(b);
ffff800000103ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103ef5:	48 89 c7             	mov    %rax,%rdi
ffff800000103ef8:	48 b8 d1 3a 10 00 00 	movabs $0xffff800000103ad1,%rax
ffff800000103eff:	80 ff ff 
ffff800000103f02:	ff d0                	call   *%rax

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103f04:	eb 20                	jmp    ffff800000103f26 <iderw+0x143>
    sleep(b, &idelock);
ffff800000103f06:	48 ba c0 80 11 00 00 	movabs $0xffff8000001180c0,%rdx
ffff800000103f0d:	80 ff ff 
ffff800000103f10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f14:	48 89 d6             	mov    %rdx,%rsi
ffff800000103f17:	48 89 c7             	mov    %rax,%rdi
ffff800000103f1a:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000103f21:	80 ff ff 
ffff800000103f24:	ff d0                	call   *%rax
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
ffff800000103f26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f2a:	8b 00                	mov    (%rax),%eax
ffff800000103f2c:	83 e0 06             	and    $0x6,%eax
ffff800000103f2f:	83 f8 02             	cmp    $0x2,%eax
ffff800000103f32:	75 d2                	jne    ffff800000103f06 <iderw+0x123>
  }

  release(&idelock);
ffff800000103f34:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103f3b:	80 ff ff 
ffff800000103f3e:	48 89 c7             	mov    %rax,%rdi
ffff800000103f41:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000103f48:	80 ff ff 
ffff800000103f4b:	ff d0                	call   *%rax
}
ffff800000103f4d:	90                   	nop
ffff800000103f4e:	c9                   	leave
ffff800000103f4f:	c3                   	ret

ffff800000103f50 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
ffff800000103f50:	55                   	push   %rbp
ffff800000103f51:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f54:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f58:	89 7d fc             	mov    %edi,-0x4(%rbp)
  ioapic->reg = reg;
ffff800000103f5b:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103f62:	80 ff ff 
ffff800000103f65:	48 8b 00             	mov    (%rax),%rax
ffff800000103f68:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103f6b:	89 10                	mov    %edx,(%rax)
  return ioapic->data;
ffff800000103f6d:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103f74:	80 ff ff 
ffff800000103f77:	48 8b 00             	mov    (%rax),%rax
ffff800000103f7a:	8b 40 10             	mov    0x10(%rax),%eax
}
ffff800000103f7d:	c9                   	leave
ffff800000103f7e:	c3                   	ret

ffff800000103f7f <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
ffff800000103f7f:	55                   	push   %rbp
ffff800000103f80:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f83:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f87:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103f8a:	89 75 f8             	mov    %esi,-0x8(%rbp)
  ioapic->reg = reg;
ffff800000103f8d:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103f94:	80 ff ff 
ffff800000103f97:	48 8b 00             	mov    (%rax),%rax
ffff800000103f9a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103f9d:	89 10                	mov    %edx,(%rax)
  ioapic->data = data;
ffff800000103f9f:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103fa6:	80 ff ff 
ffff800000103fa9:	48 8b 00             	mov    (%rax),%rax
ffff800000103fac:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103faf:	89 50 10             	mov    %edx,0x10(%rax)
}
ffff800000103fb2:	90                   	nop
ffff800000103fb3:	c9                   	leave
ffff800000103fb4:	c3                   	ret

ffff800000103fb5 <ioapicinit>:

void
ioapicinit(void)
{
ffff800000103fb5:	55                   	push   %rbp
ffff800000103fb6:	48 89 e5             	mov    %rsp,%rbp
ffff800000103fb9:	48 83 ec 10          	sub    $0x10,%rsp
  int i, id, maxintr;

  ioapic = P2V((volatile struct ioapic*)IOAPIC);
ffff800000103fbd:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103fc4:	80 ff ff 
ffff800000103fc7:	48 b9 00 00 c0 fe 00 	movabs $0xffff8000fec00000,%rcx
ffff800000103fce:	80 ff ff 
ffff800000103fd1:	48 89 08             	mov    %rcx,(%rax)
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
ffff800000103fd4:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103fd9:	48 b8 50 3f 10 00 00 	movabs $0xffff800000103f50,%rax
ffff800000103fe0:	80 ff ff 
ffff800000103fe3:	ff d0                	call   *%rax
ffff800000103fe5:	c1 e8 10             	shr    $0x10,%eax
ffff800000103fe8:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000103fed:	89 45 f8             	mov    %eax,-0x8(%rbp)
  id = ioapicread(REG_ID) >> 24;
ffff800000103ff0:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103ff5:	48 b8 50 3f 10 00 00 	movabs $0xffff800000103f50,%rax
ffff800000103ffc:	80 ff ff 
ffff800000103fff:	ff d0                	call   *%rax
ffff800000104001:	c1 e8 18             	shr    $0x18,%eax
ffff800000104004:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(id != ioapicid)
ffff800000104007:	48 b8 24 84 11 00 00 	movabs $0xffff800000118424,%rax
ffff80000010400e:	80 ff ff 
ffff800000104011:	0f b6 00             	movzbl (%rax),%eax
ffff800000104014:	0f b6 c0             	movzbl %al,%eax
ffff800000104017:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffff80000010401a:	74 1e                	je     ffff80000010403a <ioapicinit+0x85>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
ffff80000010401c:	48 b8 00 c6 10 00 00 	movabs $0xffff80000010c600,%rax
ffff800000104023:	80 ff ff 
ffff800000104026:	48 89 c7             	mov    %rax,%rdi
ffff800000104029:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010402e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000104035:	80 ff ff 
ffff800000104038:	ff d2                	call   *%rdx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
ffff80000010403a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104041:	eb 47                	jmp    ffff80000010408a <ioapicinit+0xd5>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
ffff800000104043:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104046:	83 c0 20             	add    $0x20,%eax
ffff800000104049:	0d 00 00 01 00       	or     $0x10000,%eax
ffff80000010404e:	89 c2                	mov    %eax,%edx
ffff800000104050:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104053:	83 c0 08             	add    $0x8,%eax
ffff800000104056:	01 c0                	add    %eax,%eax
ffff800000104058:	89 d6                	mov    %edx,%esi
ffff80000010405a:	89 c7                	mov    %eax,%edi
ffff80000010405c:	48 b8 7f 3f 10 00 00 	movabs $0xffff800000103f7f,%rax
ffff800000104063:	80 ff ff 
ffff800000104066:	ff d0                	call   *%rax
    ioapicwrite(REG_TABLE+2*i+1, 0);
ffff800000104068:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010406b:	83 c0 08             	add    $0x8,%eax
ffff80000010406e:	01 c0                	add    %eax,%eax
ffff800000104070:	83 c0 01             	add    $0x1,%eax
ffff800000104073:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104078:	89 c7                	mov    %eax,%edi
ffff80000010407a:	48 b8 7f 3f 10 00 00 	movabs $0xffff800000103f7f,%rax
ffff800000104081:	80 ff ff 
ffff800000104084:	ff d0                	call   *%rax
  for(i = 0; i <= maxintr; i++){
ffff800000104086:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010408a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010408d:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000104090:	7e b1                	jle    ffff800000104043 <ioapicinit+0x8e>
  }
}
ffff800000104092:	90                   	nop
ffff800000104093:	90                   	nop
ffff800000104094:	c9                   	leave
ffff800000104095:	c3                   	ret

ffff800000104096 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
ffff800000104096:	55                   	push   %rbp
ffff800000104097:	48 89 e5             	mov    %rsp,%rbp
ffff80000010409a:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010409e:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001040a1:	89 75 f8             	mov    %esi,-0x8(%rbp)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
ffff8000001040a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040a7:	83 c0 20             	add    $0x20,%eax
ffff8000001040aa:	89 c2                	mov    %eax,%edx
ffff8000001040ac:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040af:	83 c0 08             	add    $0x8,%eax
ffff8000001040b2:	01 c0                	add    %eax,%eax
ffff8000001040b4:	89 d6                	mov    %edx,%esi
ffff8000001040b6:	89 c7                	mov    %eax,%edi
ffff8000001040b8:	48 b8 7f 3f 10 00 00 	movabs $0xffff800000103f7f,%rax
ffff8000001040bf:	80 ff ff 
ffff8000001040c2:	ff d0                	call   *%rax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
ffff8000001040c4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001040c7:	c1 e0 18             	shl    $0x18,%eax
ffff8000001040ca:	89 c2                	mov    %eax,%edx
ffff8000001040cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001040cf:	83 c0 08             	add    $0x8,%eax
ffff8000001040d2:	01 c0                	add    %eax,%eax
ffff8000001040d4:	83 c0 01             	add    $0x1,%eax
ffff8000001040d7:	89 d6                	mov    %edx,%esi
ffff8000001040d9:	89 c7                	mov    %eax,%edi
ffff8000001040db:	48 b8 7f 3f 10 00 00 	movabs $0xffff800000103f7f,%rax
ffff8000001040e2:	80 ff ff 
ffff8000001040e5:	ff d0                	call   *%rax
}
ffff8000001040e7:	90                   	nop
ffff8000001040e8:	c9                   	leave
ffff8000001040e9:	c3                   	ret

ffff8000001040ea <kinit1>:
  struct run *freelist;
} kmem;

void
kinit1(void *vstart, void *vend)
{
ffff8000001040ea:	55                   	push   %rbp
ffff8000001040eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001040ee:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001040f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001040f6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&kmem.lock, "kmem");
ffff8000001040fa:	48 ba 32 c6 10 00 00 	movabs $0xffff80000010c632,%rdx
ffff800000104101:	80 ff ff 
ffff800000104104:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010410b:	80 ff ff 
ffff80000010410e:	48 89 d6             	mov    %rdx,%rsi
ffff800000104111:	48 89 c7             	mov    %rax,%rdi
ffff800000104114:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff80000010411b:	80 ff ff 
ffff80000010411e:	ff d0                	call   *%rax
  kmem.use_lock = 0;
ffff800000104120:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff800000104127:	80 ff ff 
ffff80000010412a:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
  kmem.freelist = 0; // empty
ffff800000104131:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff800000104138:	80 ff ff 
ffff80000010413b:	48 c7 40 70 00 00 00 	movq   $0x0,0x70(%rax)
ffff800000104142:	00 
  freerange(vstart, vend);
ffff800000104143:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000104147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010414b:	48 89 d6             	mov    %rdx,%rsi
ffff80000010414e:	48 89 c7             	mov    %rax,%rdi
ffff800000104151:	48 b8 78 41 10 00 00 	movabs $0xffff800000104178,%rax
ffff800000104158:	80 ff ff 
ffff80000010415b:	ff d0                	call   *%rax
}
ffff80000010415d:	90                   	nop
ffff80000010415e:	c9                   	leave
ffff80000010415f:	c3                   	ret

ffff800000104160 <kinit2>:

void
kinit2()
{
ffff800000104160:	55                   	push   %rbp
ffff800000104161:	48 89 e5             	mov    %rsp,%rbp
  kmem.use_lock = 1;
ffff800000104164:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010416b:	80 ff ff 
ffff80000010416e:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
}
ffff800000104175:	90                   	nop
ffff800000104176:	5d                   	pop    %rbp
ffff800000104177:	c3                   	ret

ffff800000104178 <freerange>:

void
freerange(void *vstart, void *vend)
{
ffff800000104178:	55                   	push   %rbp
ffff800000104179:	48 89 e5             	mov    %rsp,%rbp
ffff80000010417c:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104180:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000104184:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *p;
  p = (char*)PGROUNDUP((addr_t)vstart);
ffff800000104188:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010418c:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff800000104192:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff800000104198:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff80000010419c:	eb 1b                	jmp    ffff8000001041b9 <freerange+0x41>
    kfree(p);
ffff80000010419e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041a2:	48 89 c7             	mov    %rax,%rdi
ffff8000001041a5:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff8000001041ac:	80 ff ff 
ffff8000001041af:	ff d0                	call   *%rax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
ffff8000001041b1:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff8000001041b8:	00 
ffff8000001041b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001041bd:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff8000001041c3:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
ffff8000001041c7:	73 d5                	jae    ffff80000010419e <freerange+0x26>
}
ffff8000001041c9:	90                   	nop
ffff8000001041ca:	90                   	nop
ffff8000001041cb:	c9                   	leave
ffff8000001041cc:	c3                   	ret

ffff8000001041cd <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
ffff8000001041cd:	55                   	push   %rbp
ffff8000001041ce:	48 89 e5             	mov    %rsp,%rbp
ffff8000001041d1:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001041d5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct run *r;

  if((addr_t)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
ffff8000001041d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001041dd:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff8000001041e2:	48 85 c0             	test   %rax,%rax
ffff8000001041e5:	75 29                	jne    ffff800000104210 <kfree+0x43>
ffff8000001041e7:	48 b8 00 e0 11 00 00 	movabs $0xffff80000011e000,%rax
ffff8000001041ee:	80 ff ff 
ffff8000001041f1:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001041f5:	72 19                	jb     ffff800000104210 <kfree+0x43>
ffff8000001041f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001041fb:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff800000104202:	80 00 00 
ffff800000104205:	48 01 d0             	add    %rdx,%rax
ffff800000104208:	48 3d ff ff ff 0d    	cmp    $0xdffffff,%rax
ffff80000010420e:	76 19                	jbe    ffff800000104229 <kfree+0x5c>
    panic("kfree");
ffff800000104210:	48 b8 37 c6 10 00 00 	movabs $0xffff80000010c637,%rax
ffff800000104217:	80 ff ff 
ffff80000010421a:	48 89 c7             	mov    %rax,%rdi
ffff80000010421d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000104224:	80 ff ff 
ffff800000104227:	ff d0                	call   *%rax

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
ffff800000104229:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010422d:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000104232:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000104237:	48 89 c7             	mov    %rax,%rdi
ffff80000010423a:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff800000104241:	80 ff ff 
ffff800000104244:	ff d0                	call   *%rax

  if(kmem.use_lock)
ffff800000104246:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010424d:	80 ff ff 
ffff800000104250:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104253:	85 c0                	test   %eax,%eax
ffff800000104255:	74 19                	je     ffff800000104270 <kfree+0xa3>
    acquire(&kmem.lock);
ffff800000104257:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010425e:	80 ff ff 
ffff800000104261:	48 89 c7             	mov    %rax,%rdi
ffff800000104264:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010426b:	80 ff ff 
ffff80000010426e:	ff d0                	call   *%rax
  r = (struct run*)v;
ffff800000104270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104274:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  r->next = kmem.freelist;
ffff800000104278:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010427f:	80 ff ff 
ffff800000104282:	48 8b 50 70          	mov    0x70(%rax),%rdx
ffff800000104286:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010428a:	48 89 10             	mov    %rdx,(%rax)
  kmem.freelist = r;
ffff80000010428d:	48 ba 40 81 11 00 00 	movabs $0xffff800000118140,%rdx
ffff800000104294:	80 ff ff 
ffff800000104297:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010429b:	48 89 42 70          	mov    %rax,0x70(%rdx)
  if(kmem.use_lock)
ffff80000010429f:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001042a6:	80 ff ff 
ffff8000001042a9:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001042ac:	85 c0                	test   %eax,%eax
ffff8000001042ae:	74 19                	je     ffff8000001042c9 <kfree+0xfc>
    release(&kmem.lock);
ffff8000001042b0:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001042b7:	80 ff ff 
ffff8000001042ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001042bd:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001042c4:	80 ff ff 
ffff8000001042c7:	ff d0                	call   *%rax
  if(kmem.use_lock)
ffff8000001042c9:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001042d0:	80 ff ff 
ffff8000001042d3:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001042d6:	85 c0                	test   %eax,%eax
ffff8000001042d8:	74 52                	je     ffff80000010432c <kfree+0x15f>
    traceevent(TRACE_TYPE_MEM, proc ? proc->pid : 0, V2P(v), 0, "kfree");
ffff8000001042da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001042de:	89 c6                	mov    %eax,%esi
ffff8000001042e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001042e7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001042eb:	48 85 c0             	test   %rax,%rax
ffff8000001042ee:	74 10                	je     ffff800000104300 <kfree+0x133>
ffff8000001042f0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001042f7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001042fb:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001042fe:	eb 05                	jmp    ffff800000104305 <kfree+0x138>
ffff800000104300:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104305:	48 ba 37 c6 10 00 00 	movabs $0xffff80000010c637,%rdx
ffff80000010430c:	80 ff ff 
ffff80000010430f:	49 89 d0             	mov    %rdx,%r8
ffff800000104312:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000104317:	89 f2                	mov    %esi,%edx
ffff800000104319:	89 c6                	mov    %eax,%esi
ffff80000010431b:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104320:	48 b8 66 c1 10 00 00 	movabs $0xffff80000010c166,%rax
ffff800000104327:	80 ff ff 
ffff80000010432a:	ff d0                	call   *%rax
}
ffff80000010432c:	90                   	nop
ffff80000010432d:	c9                   	leave
ffff80000010432e:	c3                   	ret

ffff80000010432f <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffff80000010432f:	55                   	push   %rbp
ffff800000104330:	48 89 e5             	mov    %rsp,%rbp
ffff800000104333:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffff800000104337:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010433e:	80 ff ff 
ffff800000104341:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104344:	85 c0                	test   %eax,%eax
ffff800000104346:	74 19                	je     ffff800000104361 <kalloc+0x32>
    acquire(&kmem.lock);
ffff800000104348:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010434f:	80 ff ff 
ffff800000104352:	48 89 c7             	mov    %rax,%rdi
ffff800000104355:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010435c:	80 ff ff 
ffff80000010435f:	ff d0                	call   *%rax
  r = kmem.freelist;
ffff800000104361:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff800000104368:	80 ff ff 
ffff80000010436b:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff80000010436f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffff800000104373:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000104378:	74 28                	je     ffff8000001043a2 <kalloc+0x73>
    kmem.freelist = r->next;
ffff80000010437a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010437e:	48 8b 00             	mov    (%rax),%rax
ffff800000104381:	48 ba 40 81 11 00 00 	movabs $0xffff800000118140,%rdx
ffff800000104388:	80 ff ff 
ffff80000010438b:	48 89 42 70          	mov    %rax,0x70(%rdx)
  else {
    panic("Out of memory!");
  }
  
  if(kmem.use_lock)
ffff80000010438f:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff800000104396:	80 ff ff 
ffff800000104399:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010439c:	85 c0                	test   %eax,%eax
ffff80000010439e:	74 34                	je     ffff8000001043d4 <kalloc+0xa5>
ffff8000001043a0:	eb 19                	jmp    ffff8000001043bb <kalloc+0x8c>
    panic("Out of memory!");
ffff8000001043a2:	48 b8 3d c6 10 00 00 	movabs $0xffff80000010c63d,%rax
ffff8000001043a9:	80 ff ff 
ffff8000001043ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001043af:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001043b6:	80 ff ff 
ffff8000001043b9:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff8000001043bb:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001043c2:	80 ff ff 
ffff8000001043c5:	48 89 c7             	mov    %rax,%rdi
ffff8000001043c8:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001043cf:	80 ff ff 
ffff8000001043d2:	ff d0                	call   *%rax
  //need to call this conditional again because it uses a lock
  if(kmem.use_lock && r)
ffff8000001043d4:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001043db:	80 ff ff 
ffff8000001043de:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001043e1:	85 c0                	test   %eax,%eax
ffff8000001043e3:	74 59                	je     ffff80000010443e <kalloc+0x10f>
ffff8000001043e5:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001043ea:	74 52                	je     ffff80000010443e <kalloc+0x10f>
    traceevent(TRACE_TYPE_MEM, proc ? proc->pid : 0, V2P((char*)r), 0, "kalloc");
ffff8000001043ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001043f0:	89 c6                	mov    %eax,%esi
ffff8000001043f2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001043f9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001043fd:	48 85 c0             	test   %rax,%rax
ffff800000104400:	74 10                	je     ffff800000104412 <kalloc+0xe3>
ffff800000104402:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000104409:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010440d:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000104410:	eb 05                	jmp    ffff800000104417 <kalloc+0xe8>
ffff800000104412:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104417:	48 ba 4c c6 10 00 00 	movabs $0xffff80000010c64c,%rdx
ffff80000010441e:	80 ff ff 
ffff800000104421:	49 89 d0             	mov    %rdx,%r8
ffff800000104424:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000104429:	89 f2                	mov    %esi,%edx
ffff80000010442b:	89 c6                	mov    %eax,%esi
ffff80000010442d:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104432:	48 b8 66 c1 10 00 00 	movabs $0xffff80000010c166,%rax
ffff800000104439:	80 ff ff 
ffff80000010443c:	ff d0                	call   *%rax

  return (char*)r;
ffff80000010443e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000104442:	c9                   	leave
ffff800000104443:	c3                   	ret

ffff800000104444 <inb>:
{
ffff800000104444:	55                   	push   %rbp
ffff800000104445:	48 89 e5             	mov    %rsp,%rbp
ffff800000104448:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010444c:	89 f8                	mov    %edi,%eax
ffff80000010444e:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000104452:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104456:	89 c2                	mov    %eax,%edx
ffff800000104458:	ec                   	in     (%dx),%al
ffff800000104459:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010445c:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000104460:	c9                   	leave
ffff800000104461:	c3                   	ret

ffff800000104462 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
ffff800000104462:	55                   	push   %rbp
ffff800000104463:	48 89 e5             	mov    %rsp,%rbp
ffff800000104466:	48 83 ec 10          	sub    $0x10,%rsp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffff80000010446a:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010446f:	48 b8 44 44 10 00 00 	movabs $0xffff800000104444,%rax
ffff800000104476:	80 ff ff 
ffff800000104479:	ff d0                	call   *%rax
ffff80000010447b:	0f b6 c0             	movzbl %al,%eax
ffff80000010447e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffff800000104481:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104484:	83 e0 01             	and    $0x1,%eax
ffff800000104487:	85 c0                	test   %eax,%eax
ffff800000104489:	75 0a                	jne    ffff800000104495 <kbdgetc+0x33>
    return -1;
ffff80000010448b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000104490:	e9 a4 01 00 00       	jmp    ffff800000104639 <kbdgetc+0x1d7>
  data = inb(KBDATAP);
ffff800000104495:	bf 60 00 00 00       	mov    $0x60,%edi
ffff80000010449a:	48 b8 44 44 10 00 00 	movabs $0xffff800000104444,%rax
ffff8000001044a1:	80 ff ff 
ffff8000001044a4:	ff d0                	call   *%rax
ffff8000001044a6:	0f b6 c0             	movzbl %al,%eax
ffff8000001044a9:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffff8000001044ac:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff8000001044b3:	75 27                	jne    ffff8000001044dc <kbdgetc+0x7a>
    shift |= E0ESC;
ffff8000001044b5:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001044bc:	80 ff ff 
ffff8000001044bf:	8b 00                	mov    (%rax),%eax
ffff8000001044c1:	83 c8 40             	or     $0x40,%eax
ffff8000001044c4:	89 c2                	mov    %eax,%edx
ffff8000001044c6:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001044cd:	80 ff ff 
ffff8000001044d0:	89 10                	mov    %edx,(%rax)
    return 0;
ffff8000001044d2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001044d7:	e9 5d 01 00 00       	jmp    ffff800000104639 <kbdgetc+0x1d7>
  } else if(data & 0x80){
ffff8000001044dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001044df:	25 80 00 00 00       	and    $0x80,%eax
ffff8000001044e4:	85 c0                	test   %eax,%eax
ffff8000001044e6:	74 56                	je     ffff80000010453e <kbdgetc+0xdc>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffff8000001044e8:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001044ef:	80 ff ff 
ffff8000001044f2:	8b 00                	mov    (%rax),%eax
ffff8000001044f4:	83 e0 40             	and    $0x40,%eax
ffff8000001044f7:	85 c0                	test   %eax,%eax
ffff8000001044f9:	75 04                	jne    ffff8000001044ff <kbdgetc+0x9d>
ffff8000001044fb:	83 65 fc 7f          	andl   $0x7f,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffff8000001044ff:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104506:	80 ff ff 
ffff800000104509:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010450c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104510:	83 c8 40             	or     $0x40,%eax
ffff800000104513:	0f b6 c0             	movzbl %al,%eax
ffff800000104516:	f7 d0                	not    %eax
ffff800000104518:	89 c2                	mov    %eax,%edx
ffff80000010451a:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104521:	80 ff ff 
ffff800000104524:	8b 00                	mov    (%rax),%eax
ffff800000104526:	21 c2                	and    %eax,%edx
ffff800000104528:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010452f:	80 ff ff 
ffff800000104532:	89 10                	mov    %edx,(%rax)
    return 0;
ffff800000104534:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104539:	e9 fb 00 00 00       	jmp    ffff800000104639 <kbdgetc+0x1d7>
  } else if(shift & E0ESC){
ffff80000010453e:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104545:	80 ff ff 
ffff800000104548:	8b 00                	mov    (%rax),%eax
ffff80000010454a:	83 e0 40             	and    $0x40,%eax
ffff80000010454d:	85 c0                	test   %eax,%eax
ffff80000010454f:	74 24                	je     ffff800000104575 <kbdgetc+0x113>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffff800000104551:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffff800000104558:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010455f:	80 ff ff 
ffff800000104562:	8b 00                	mov    (%rax),%eax
ffff800000104564:	83 e0 bf             	and    $0xffffffbf,%eax
ffff800000104567:	89 c2                	mov    %eax,%edx
ffff800000104569:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104570:	80 ff ff 
ffff800000104573:	89 10                	mov    %edx,(%rax)
  }

  shift |= shiftcode[data];
ffff800000104575:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff80000010457c:	80 ff ff 
ffff80000010457f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104582:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104586:	0f b6 d0             	movzbl %al,%edx
ffff800000104589:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104590:	80 ff ff 
ffff800000104593:	8b 00                	mov    (%rax),%eax
ffff800000104595:	09 c2                	or     %eax,%edx
ffff800000104597:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010459e:	80 ff ff 
ffff8000001045a1:	89 10                	mov    %edx,(%rax)
  shift ^= togglecode[data];
ffff8000001045a3:	48 ba 20 d1 10 00 00 	movabs $0xffff80000010d120,%rdx
ffff8000001045aa:	80 ff ff 
ffff8000001045ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001045b0:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001045b4:	0f b6 d0             	movzbl %al,%edx
ffff8000001045b7:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045be:	80 ff ff 
ffff8000001045c1:	8b 00                	mov    (%rax),%eax
ffff8000001045c3:	31 c2                	xor    %eax,%edx
ffff8000001045c5:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045cc:	80 ff ff 
ffff8000001045cf:	89 10                	mov    %edx,(%rax)
  c = charcode[shift & (CTL | SHIFT)][data];
ffff8000001045d1:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045d8:	80 ff ff 
ffff8000001045db:	8b 00                	mov    (%rax),%eax
ffff8000001045dd:	83 e0 03             	and    $0x3,%eax
ffff8000001045e0:	89 c2                	mov    %eax,%edx
ffff8000001045e2:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff8000001045e9:	80 ff ff 
ffff8000001045ec:	89 d2                	mov    %edx,%edx
ffff8000001045ee:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff8000001045f2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001045f5:	48 01 d0             	add    %rdx,%rax
ffff8000001045f8:	0f b6 00             	movzbl (%rax),%eax
ffff8000001045fb:	0f b6 c0             	movzbl %al,%eax
ffff8000001045fe:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffff800000104601:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104608:	80 ff ff 
ffff80000010460b:	8b 00                	mov    (%rax),%eax
ffff80000010460d:	83 e0 08             	and    $0x8,%eax
ffff800000104610:	85 c0                	test   %eax,%eax
ffff800000104612:	74 22                	je     ffff800000104636 <kbdgetc+0x1d4>
    if('a' <= c && c <= 'z')
ffff800000104614:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff800000104618:	76 0c                	jbe    ffff800000104626 <kbdgetc+0x1c4>
ffff80000010461a:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff80000010461e:	77 06                	ja     ffff800000104626 <kbdgetc+0x1c4>
      c += 'A' - 'a';
ffff800000104620:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff800000104624:	eb 10                	jmp    ffff800000104636 <kbdgetc+0x1d4>
    else if('A' <= c && c <= 'Z')
ffff800000104626:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff80000010462a:	76 0a                	jbe    ffff800000104636 <kbdgetc+0x1d4>
ffff80000010462c:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff800000104630:	77 04                	ja     ffff800000104636 <kbdgetc+0x1d4>
      c += 'a' - 'A';
ffff800000104632:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffff800000104636:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000104639:	c9                   	leave
ffff80000010463a:	c3                   	ret

ffff80000010463b <kbdintr>:

void
kbdintr(void)
{
ffff80000010463b:	55                   	push   %rbp
ffff80000010463c:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffff80000010463f:	48 b8 62 44 10 00 00 	movabs $0xffff800000104462,%rax
ffff800000104646:	80 ff ff 
ffff800000104649:	48 89 c7             	mov    %rax,%rdi
ffff80000010464c:	48 b8 97 10 10 00 00 	movabs $0xffff800000101097,%rax
ffff800000104653:	80 ff ff 
ffff800000104656:	ff d0                	call   *%rax
}
ffff800000104658:	90                   	nop
ffff800000104659:	5d                   	pop    %rbp
ffff80000010465a:	c3                   	ret

ffff80000010465b <inb>:
{
ffff80000010465b:	55                   	push   %rbp
ffff80000010465c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010465f:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104663:	89 f8                	mov    %edi,%eax
ffff800000104665:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000104669:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010466d:	89 c2                	mov    %eax,%edx
ffff80000010466f:	ec                   	in     (%dx),%al
ffff800000104670:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000104673:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000104677:	c9                   	leave
ffff800000104678:	c3                   	ret

ffff800000104679 <outb>:
{
ffff800000104679:	55                   	push   %rbp
ffff80000010467a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010467d:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104681:	89 fa                	mov    %edi,%edx
ffff800000104683:	89 f0                	mov    %esi,%eax
ffff800000104685:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000104689:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff80000010468c:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000104690:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000104694:	ee                   	out    %al,(%dx)
}
ffff800000104695:	90                   	nop
ffff800000104696:	c9                   	leave
ffff800000104697:	c3                   	ret

ffff800000104698 <readeflags>:
{
ffff800000104698:	55                   	push   %rbp
ffff800000104699:	48 89 e5             	mov    %rsp,%rbp
ffff80000010469c:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff8000001046a0:	9c                   	pushf
ffff8000001046a1:	58                   	pop    %rax
ffff8000001046a2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff8000001046a6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001046aa:	c9                   	leave
ffff8000001046ab:	c3                   	ret

ffff8000001046ac <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
ffff8000001046ac:	55                   	push   %rbp
ffff8000001046ad:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046b0:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001046b4:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001046b7:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffff8000001046ba:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001046c1:	80 ff ff 
ffff8000001046c4:	48 8b 00             	mov    (%rax),%rax
ffff8000001046c7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001046ca:	48 63 d2             	movslq %edx,%rdx
ffff8000001046cd:	48 c1 e2 02          	shl    $0x2,%rdx
ffff8000001046d1:	48 01 c2             	add    %rax,%rdx
ffff8000001046d4:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001046d7:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffff8000001046d9:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001046e0:	80 ff ff 
ffff8000001046e3:	48 8b 00             	mov    (%rax),%rax
ffff8000001046e6:	48 83 c0 20          	add    $0x20,%rax
ffff8000001046ea:	8b 00                	mov    (%rax),%eax
}
ffff8000001046ec:	90                   	nop
ffff8000001046ed:	c9                   	leave
ffff8000001046ee:	c3                   	ret

ffff8000001046ef <lapicinit>:

void
lapicinit(void)
{
ffff8000001046ef:	55                   	push   %rbp
ffff8000001046f0:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic)
ffff8000001046f3:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001046fa:	80 ff ff 
ffff8000001046fd:	48 8b 00             	mov    (%rax),%rax
ffff800000104700:	48 85 c0             	test   %rax,%rax
ffff800000104703:	0f 84 71 01 00 00    	je     ffff80000010487a <lapicinit+0x18b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffff800000104709:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff80000010470e:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff800000104713:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff80000010471a:	80 ff ff 
ffff80000010471d:	ff d0                	call   *%rax

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
ffff80000010471f:	be 0b 00 00 00       	mov    $0xb,%esi
ffff800000104724:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff800000104729:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104730:	80 ff ff 
ffff800000104733:	ff d0                	call   *%rax
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffff800000104735:	be 20 00 02 00       	mov    $0x20020,%esi
ffff80000010473a:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff80000010473f:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104746:	80 ff ff 
ffff800000104749:	ff d0                	call   *%rax
  lapicw(TICR, 10000000);
ffff80000010474b:	be 80 96 98 00       	mov    $0x989680,%esi
ffff800000104750:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff800000104755:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff80000010475c:	80 ff ff 
ffff80000010475f:	ff d0                	call   *%rax

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
ffff800000104761:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104766:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff80000010476b:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104772:	80 ff ff 
ffff800000104775:	ff d0                	call   *%rax
  lapicw(LINT1, MASKED);
ffff800000104777:	be 00 00 01 00       	mov    $0x10000,%esi
ffff80000010477c:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff800000104781:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104788:	80 ff ff 
ffff80000010478b:	ff d0                	call   *%rax

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffff80000010478d:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000104794:	80 ff ff 
ffff800000104797:	48 8b 00             	mov    (%rax),%rax
ffff80000010479a:	48 83 c0 30          	add    $0x30,%rax
ffff80000010479e:	8b 00                	mov    (%rax),%eax
ffff8000001047a0:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff8000001047a5:	85 c0                	test   %eax,%eax
ffff8000001047a7:	74 16                	je     ffff8000001047bf <lapicinit+0xd0>
    lapicw(PCINT, MASKED);
ffff8000001047a9:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001047ae:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff8000001047b3:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff8000001047ba:	80 ff ff 
ffff8000001047bd:	ff d0                	call   *%rax

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffff8000001047bf:	be 33 00 00 00       	mov    $0x33,%esi
ffff8000001047c4:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff8000001047c9:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff8000001047d0:	80 ff ff 
ffff8000001047d3:	ff d0                	call   *%rax

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
ffff8000001047d5:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047da:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff8000001047df:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff8000001047e6:	80 ff ff 
ffff8000001047e9:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff8000001047eb:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047f0:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff8000001047f5:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff8000001047fc:	80 ff ff 
ffff8000001047ff:	ff d0                	call   *%rax

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
ffff800000104801:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104806:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff80000010480b:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104812:	80 ff ff 
ffff800000104815:	ff d0                	call   *%rax

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
ffff800000104817:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010481c:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104821:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104828:	80 ff ff 
ffff80000010482b:	ff d0                	call   *%rax
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffff80000010482d:	be 00 85 08 00       	mov    $0x88500,%esi
ffff800000104832:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104837:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff80000010483e:	80 ff ff 
ffff800000104841:	ff d0                	call   *%rax
  while(lapic[ICRLO] & DELIVS)
ffff800000104843:	90                   	nop
ffff800000104844:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff80000010484b:	80 ff ff 
ffff80000010484e:	48 8b 00             	mov    (%rax),%rax
ffff800000104851:	48 05 00 03 00 00    	add    $0x300,%rax
ffff800000104857:	8b 00                	mov    (%rax),%eax
ffff800000104859:	25 00 10 00 00       	and    $0x1000,%eax
ffff80000010485e:	85 c0                	test   %eax,%eax
ffff800000104860:	75 e2                	jne    ffff800000104844 <lapicinit+0x155>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
ffff800000104862:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104867:	bf 20 00 00 00       	mov    $0x20,%edi
ffff80000010486c:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104873:	80 ff ff 
ffff800000104876:	ff d0                	call   *%rax
ffff800000104878:	eb 01                	jmp    ffff80000010487b <lapicinit+0x18c>
    return;
ffff80000010487a:	90                   	nop
}
ffff80000010487b:	5d                   	pop    %rbp
ffff80000010487c:	c3                   	ret

ffff80000010487d <cpunum>:

int
cpunum(void)
{
ffff80000010487d:	55                   	push   %rbp
ffff80000010487e:	48 89 e5             	mov    %rsp,%rbp
ffff800000104881:	48 83 ec 10          	sub    $0x10,%rsp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
ffff800000104885:	48 b8 98 46 10 00 00 	movabs $0xffff800000104698,%rax
ffff80000010488c:	80 ff ff 
ffff80000010488f:	ff d0                	call   *%rax
ffff800000104891:	25 00 02 00 00       	and    $0x200,%eax
ffff800000104896:	48 85 c0             	test   %rax,%rax
ffff800000104899:	74 47                	je     ffff8000001048e2 <cpunum+0x65>
    static int n;
    if(n++ == 0)
ffff80000010489b:	48 b8 c8 81 11 00 00 	movabs $0xffff8000001181c8,%rax
ffff8000001048a2:	80 ff ff 
ffff8000001048a5:	8b 00                	mov    (%rax),%eax
ffff8000001048a7:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001048aa:	48 b9 c8 81 11 00 00 	movabs $0xffff8000001181c8,%rcx
ffff8000001048b1:	80 ff ff 
ffff8000001048b4:	89 11                	mov    %edx,(%rcx)
ffff8000001048b6:	85 c0                	test   %eax,%eax
ffff8000001048b8:	75 28                	jne    ffff8000001048e2 <cpunum+0x65>
      cprintf("cpu called from %x with interrupts enabled\n",
ffff8000001048ba:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff8000001048be:	48 89 c2             	mov    %rax,%rdx
ffff8000001048c1:	48 b8 58 c6 10 00 00 	movabs $0xffff80000010c658,%rax
ffff8000001048c8:	80 ff ff 
ffff8000001048cb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001048ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001048d1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001048d6:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001048dd:	80 ff ff 
ffff8000001048e0:	ff d2                	call   *%rdx
        __builtin_return_address(0));
  }

  if (!lapic)
ffff8000001048e2:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001048e9:	80 ff ff 
ffff8000001048ec:	48 8b 00             	mov    (%rax),%rax
ffff8000001048ef:	48 85 c0             	test   %rax,%rax
ffff8000001048f2:	75 0a                	jne    ffff8000001048fe <cpunum+0x81>
    return 0;
ffff8000001048f4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001048f9:	e9 85 00 00 00       	jmp    ffff800000104983 <cpunum+0x106>

  apicid = lapic[ID] >> 24;
ffff8000001048fe:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000104905:	80 ff ff 
ffff800000104908:	48 8b 00             	mov    (%rax),%rax
ffff80000010490b:	48 83 c0 20          	add    $0x20,%rax
ffff80000010490f:	8b 00                	mov    (%rax),%eax
ffff800000104911:	c1 e8 18             	shr    $0x18,%eax
ffff800000104914:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < ncpu; ++i) {
ffff800000104917:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010491e:	eb 39                	jmp    ffff800000104959 <cpunum+0xdc>
    if (cpus[i].apicid == apicid)
ffff800000104920:	48 b9 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rcx
ffff800000104927:	80 ff ff 
ffff80000010492a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010492d:	48 63 d0             	movslq %eax,%rdx
ffff800000104930:	48 89 d0             	mov    %rdx,%rax
ffff800000104933:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000104937:	48 01 d0             	add    %rdx,%rax
ffff80000010493a:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010493e:	48 01 c8             	add    %rcx,%rax
ffff800000104941:	48 83 c0 01          	add    $0x1,%rax
ffff800000104945:	0f b6 00             	movzbl (%rax),%eax
ffff800000104948:	0f b6 c0             	movzbl %al,%eax
ffff80000010494b:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010494e:	75 05                	jne    ffff800000104955 <cpunum+0xd8>
      return i;
ffff800000104950:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104953:	eb 2e                	jmp    ffff800000104983 <cpunum+0x106>
  for (i = 0; i < ncpu; ++i) {
ffff800000104955:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104959:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000104960:	80 ff ff 
ffff800000104963:	8b 00                	mov    (%rax),%eax
ffff800000104965:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104968:	7c b6                	jl     ffff800000104920 <cpunum+0xa3>
  }
  panic("unknown apicid\n");
ffff80000010496a:	48 b8 84 c6 10 00 00 	movabs $0xffff80000010c684,%rax
ffff800000104971:	80 ff ff 
ffff800000104974:	48 89 c7             	mov    %rax,%rdi
ffff800000104977:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010497e:	80 ff ff 
ffff800000104981:	ff d0                	call   *%rax
}
ffff800000104983:	c9                   	leave
ffff800000104984:	c3                   	ret

ffff800000104985 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffff800000104985:	55                   	push   %rbp
ffff800000104986:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffff800000104989:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000104990:	80 ff ff 
ffff800000104993:	48 8b 00             	mov    (%rax),%rax
ffff800000104996:	48 85 c0             	test   %rax,%rax
ffff800000104999:	74 16                	je     ffff8000001049b1 <lapiceoi+0x2c>
    lapicw(EOI, 0);
ffff80000010499b:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001049a0:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001049a5:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff8000001049ac:	80 ff ff 
ffff8000001049af:	ff d0                	call   *%rax
}
ffff8000001049b1:	90                   	nop
ffff8000001049b2:	5d                   	pop    %rbp
ffff8000001049b3:	c3                   	ret

ffff8000001049b4 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffff8000001049b4:	55                   	push   %rbp
ffff8000001049b5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049b8:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001049bc:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffff8000001049bf:	90                   	nop
ffff8000001049c0:	c9                   	leave
ffff8000001049c1:	c3                   	ret

ffff8000001049c2 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffff8000001049c2:	55                   	push   %rbp
ffff8000001049c3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049c6:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001049ca:	89 f8                	mov    %edi,%eax
ffff8000001049cc:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff8000001049cf:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
ffff8000001049d2:	be 0f 00 00 00       	mov    $0xf,%esi
ffff8000001049d7:	bf 70 00 00 00       	mov    $0x70,%edi
ffff8000001049dc:	48 b8 79 46 10 00 00 	movabs $0xffff800000104679,%rax
ffff8000001049e3:	80 ff ff 
ffff8000001049e6:	ff d0                	call   *%rax
  outb(CMOS_PORT+1, 0x0A);
ffff8000001049e8:	be 0a 00 00 00       	mov    $0xa,%esi
ffff8000001049ed:	bf 71 00 00 00       	mov    $0x71,%edi
ffff8000001049f2:	48 b8 79 46 10 00 00 	movabs $0xffff800000104679,%rax
ffff8000001049f9:	80 ff ff 
ffff8000001049fc:	ff d0                	call   *%rax
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffff8000001049fe:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff800000104a05:	80 ff ff 
ffff800000104a08:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  wrv[0] = 0;
ffff800000104a0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104a10:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffff800000104a15:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104a18:	c1 e8 04             	shr    $0x4,%eax
ffff800000104a1b:	89 c2                	mov    %eax,%edx
ffff800000104a1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104a21:	48 83 c0 02          	add    $0x2,%rax
ffff800000104a25:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffff800000104a28:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104a2c:	c1 e0 18             	shl    $0x18,%eax
ffff800000104a2f:	89 c6                	mov    %eax,%esi
ffff800000104a31:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104a36:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104a3d:	80 ff ff 
ffff800000104a40:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffff800000104a42:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff800000104a47:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a4c:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104a53:	80 ff ff 
ffff800000104a56:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104a58:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104a5d:	48 b8 b4 49 10 00 00 	movabs $0xffff8000001049b4,%rax
ffff800000104a64:	80 ff ff 
ffff800000104a67:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL);
ffff800000104a69:	be 00 85 00 00       	mov    $0x8500,%esi
ffff800000104a6e:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a73:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104a7a:	80 ff ff 
ffff800000104a7d:	ff d0                	call   *%rax
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffff800000104a7f:	bf 64 00 00 00       	mov    $0x64,%edi
ffff800000104a84:	48 b8 b4 49 10 00 00 	movabs $0xffff8000001049b4,%rax
ffff800000104a8b:	80 ff ff 
ffff800000104a8e:	ff d0                	call   *%rax
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffff800000104a90:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104a97:	eb 4b                	jmp    ffff800000104ae4 <lapicstartap+0x122>
    lapicw(ICRHI, apicid<<24);
ffff800000104a99:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104a9d:	c1 e0 18             	shl    $0x18,%eax
ffff800000104aa0:	89 c6                	mov    %eax,%esi
ffff800000104aa2:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104aa7:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104aae:	80 ff ff 
ffff800000104ab1:	ff d0                	call   *%rax
    lapicw(ICRLO, STARTUP | (addr>>12));
ffff800000104ab3:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104ab6:	c1 e8 0c             	shr    $0xc,%eax
ffff800000104ab9:	80 cc 06             	or     $0x6,%ah
ffff800000104abc:	89 c6                	mov    %eax,%esi
ffff800000104abe:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104ac3:	48 b8 ac 46 10 00 00 	movabs $0xffff8000001046ac,%rax
ffff800000104aca:	80 ff ff 
ffff800000104acd:	ff d0                	call   *%rax
    microdelay(200);
ffff800000104acf:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104ad4:	48 b8 b4 49 10 00 00 	movabs $0xffff8000001049b4,%rax
ffff800000104adb:	80 ff ff 
ffff800000104ade:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
ffff800000104ae0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104ae4:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000104ae8:	7e af                	jle    ffff800000104a99 <lapicstartap+0xd7>
  }
}
ffff800000104aea:	90                   	nop
ffff800000104aeb:	90                   	nop
ffff800000104aec:	c9                   	leave
ffff800000104aed:	c3                   	ret

ffff800000104aee <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
ffff800000104aee:	55                   	push   %rbp
ffff800000104aef:	48 89 e5             	mov    %rsp,%rbp
ffff800000104af2:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104af6:	89 7d fc             	mov    %edi,-0x4(%rbp)
  outb(CMOS_PORT,  reg);
ffff800000104af9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104afc:	0f b6 c0             	movzbl %al,%eax
ffff800000104aff:	89 c6                	mov    %eax,%esi
ffff800000104b01:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104b06:	48 b8 79 46 10 00 00 	movabs $0xffff800000104679,%rax
ffff800000104b0d:	80 ff ff 
ffff800000104b10:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104b12:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104b17:	48 b8 b4 49 10 00 00 	movabs $0xffff8000001049b4,%rax
ffff800000104b1e:	80 ff ff 
ffff800000104b21:	ff d0                	call   *%rax

  return inb(CMOS_RETURN);
ffff800000104b23:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104b28:	48 b8 5b 46 10 00 00 	movabs $0xffff80000010465b,%rax
ffff800000104b2f:	80 ff ff 
ffff800000104b32:	ff d0                	call   *%rax
ffff800000104b34:	0f b6 c0             	movzbl %al,%eax
}
ffff800000104b37:	c9                   	leave
ffff800000104b38:	c3                   	ret

ffff800000104b39 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
ffff800000104b39:	55                   	push   %rbp
ffff800000104b3a:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b3d:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104b41:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  r->second = cmos_read(SECS);
ffff800000104b45:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104b4a:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104b51:	80 ff ff 
ffff800000104b54:	ff d0                	call   *%rax
ffff800000104b56:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b5a:	89 02                	mov    %eax,(%rdx)
  r->minute = cmos_read(MINS);
ffff800000104b5c:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000104b61:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104b68:	80 ff ff 
ffff800000104b6b:	ff d0                	call   *%rax
ffff800000104b6d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b71:	89 42 04             	mov    %eax,0x4(%rdx)
  r->hour   = cmos_read(HOURS);
ffff800000104b74:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104b79:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104b80:	80 ff ff 
ffff800000104b83:	ff d0                	call   *%rax
ffff800000104b85:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b89:	89 42 08             	mov    %eax,0x8(%rdx)
  r->day    = cmos_read(DAY);
ffff800000104b8c:	bf 07 00 00 00       	mov    $0x7,%edi
ffff800000104b91:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104b98:	80 ff ff 
ffff800000104b9b:	ff d0                	call   *%rax
ffff800000104b9d:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104ba1:	89 42 0c             	mov    %eax,0xc(%rdx)
  r->month  = cmos_read(MONTH);
ffff800000104ba4:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000104ba9:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104bb0:	80 ff ff 
ffff800000104bb3:	ff d0                	call   *%rax
ffff800000104bb5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bb9:	89 42 10             	mov    %eax,0x10(%rdx)
  r->year   = cmos_read(YEAR);
ffff800000104bbc:	bf 09 00 00 00       	mov    $0x9,%edi
ffff800000104bc1:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104bc8:	80 ff ff 
ffff800000104bcb:	ff d0                	call   *%rax
ffff800000104bcd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bd1:	89 42 14             	mov    %eax,0x14(%rdx)
}
ffff800000104bd4:	90                   	nop
ffff800000104bd5:	c9                   	leave
ffff800000104bd6:	c3                   	ret

ffff800000104bd7 <cmostime>:
//PAGEBREAK!

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
ffff800000104bd7:	55                   	push   %rbp
ffff800000104bd8:	48 89 e5             	mov    %rsp,%rbp
ffff800000104bdb:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000104bdf:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
ffff800000104be3:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff800000104be8:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104bef:	80 ff ff 
ffff800000104bf2:	ff d0                	call   *%rax
ffff800000104bf4:	89 45 fc             	mov    %eax,-0x4(%rbp)

  bcd = (sb & (1 << 2)) == 0;
ffff800000104bf7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104bfa:	83 e0 04             	and    $0x4,%eax
ffff800000104bfd:	c1 e8 02             	shr    $0x2,%eax
ffff800000104c00:	83 e0 01             	and    $0x1,%eax
ffff800000104c03:	83 f0 01             	xor    $0x1,%eax
ffff800000104c06:	0f b6 c0             	movzbl %al,%eax
ffff800000104c09:	89 45 f8             	mov    %eax,-0x8(%rbp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
ffff800000104c0c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104c10:	48 89 c7             	mov    %rax,%rdi
ffff800000104c13:	48 b8 39 4b 10 00 00 	movabs $0xffff800000104b39,%rax
ffff800000104c1a:	80 ff ff 
ffff800000104c1d:	ff d0                	call   *%rax
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
ffff800000104c1f:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104c24:	48 b8 ee 4a 10 00 00 	movabs $0xffff800000104aee,%rax
ffff800000104c2b:	80 ff ff 
ffff800000104c2e:	ff d0                	call   *%rax
ffff800000104c30:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104c35:	85 c0                	test   %eax,%eax
ffff800000104c37:	75 38                	jne    ffff800000104c71 <cmostime+0x9a>
        continue;
    fill_rtcdate(&t2);
ffff800000104c39:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104c3d:	48 89 c7             	mov    %rax,%rdi
ffff800000104c40:	48 b8 39 4b 10 00 00 	movabs $0xffff800000104b39,%rax
ffff800000104c47:	80 ff ff 
ffff800000104c4a:	ff d0                	call   *%rax
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
ffff800000104c4c:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104c50:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104c54:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104c59:	48 89 ce             	mov    %rcx,%rsi
ffff800000104c5c:	48 89 c7             	mov    %rax,%rdi
ffff800000104c5f:	48 b8 ec 7a 10 00 00 	movabs $0xffff800000107aec,%rax
ffff800000104c66:	80 ff ff 
ffff800000104c69:	ff d0                	call   *%rax
ffff800000104c6b:	85 c0                	test   %eax,%eax
ffff800000104c6d:	74 05                	je     ffff800000104c74 <cmostime+0x9d>
ffff800000104c6f:	eb 9b                	jmp    ffff800000104c0c <cmostime+0x35>
        continue;
ffff800000104c71:	90                   	nop
    fill_rtcdate(&t1);
ffff800000104c72:	eb 98                	jmp    ffff800000104c0c <cmostime+0x35>
      break;
ffff800000104c74:	90                   	nop
  }

  // convert
  if(bcd) {
ffff800000104c75:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104c79:	0f 84 b4 00 00 00    	je     ffff800000104d33 <cmostime+0x15c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
ffff800000104c7f:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104c82:	c1 e8 04             	shr    $0x4,%eax
ffff800000104c85:	89 c2                	mov    %eax,%edx
ffff800000104c87:	89 d0                	mov    %edx,%eax
ffff800000104c89:	c1 e0 02             	shl    $0x2,%eax
ffff800000104c8c:	01 d0                	add    %edx,%eax
ffff800000104c8e:	01 c0                	add    %eax,%eax
ffff800000104c90:	89 c2                	mov    %eax,%edx
ffff800000104c92:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104c95:	83 e0 0f             	and    $0xf,%eax
ffff800000104c98:	01 d0                	add    %edx,%eax
ffff800000104c9a:	89 45 e0             	mov    %eax,-0x20(%rbp)
    CONV(minute);
ffff800000104c9d:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104ca0:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ca3:	89 c2                	mov    %eax,%edx
ffff800000104ca5:	89 d0                	mov    %edx,%eax
ffff800000104ca7:	c1 e0 02             	shl    $0x2,%eax
ffff800000104caa:	01 d0                	add    %edx,%eax
ffff800000104cac:	01 c0                	add    %eax,%eax
ffff800000104cae:	89 c2                	mov    %eax,%edx
ffff800000104cb0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104cb3:	83 e0 0f             	and    $0xf,%eax
ffff800000104cb6:	01 d0                	add    %edx,%eax
ffff800000104cb8:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    CONV(hour  );
ffff800000104cbb:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104cbe:	c1 e8 04             	shr    $0x4,%eax
ffff800000104cc1:	89 c2                	mov    %eax,%edx
ffff800000104cc3:	89 d0                	mov    %edx,%eax
ffff800000104cc5:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cc8:	01 d0                	add    %edx,%eax
ffff800000104cca:	01 c0                	add    %eax,%eax
ffff800000104ccc:	89 c2                	mov    %eax,%edx
ffff800000104cce:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104cd1:	83 e0 0f             	and    $0xf,%eax
ffff800000104cd4:	01 d0                	add    %edx,%eax
ffff800000104cd6:	89 45 e8             	mov    %eax,-0x18(%rbp)
    CONV(day   );
ffff800000104cd9:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104cdc:	c1 e8 04             	shr    $0x4,%eax
ffff800000104cdf:	89 c2                	mov    %eax,%edx
ffff800000104ce1:	89 d0                	mov    %edx,%eax
ffff800000104ce3:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ce6:	01 d0                	add    %edx,%eax
ffff800000104ce8:	01 c0                	add    %eax,%eax
ffff800000104cea:	89 c2                	mov    %eax,%edx
ffff800000104cec:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104cef:	83 e0 0f             	and    $0xf,%eax
ffff800000104cf2:	01 d0                	add    %edx,%eax
ffff800000104cf4:	89 45 ec             	mov    %eax,-0x14(%rbp)
    CONV(month );
ffff800000104cf7:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104cfa:	c1 e8 04             	shr    $0x4,%eax
ffff800000104cfd:	89 c2                	mov    %eax,%edx
ffff800000104cff:	89 d0                	mov    %edx,%eax
ffff800000104d01:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d04:	01 d0                	add    %edx,%eax
ffff800000104d06:	01 c0                	add    %eax,%eax
ffff800000104d08:	89 c2                	mov    %eax,%edx
ffff800000104d0a:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104d0d:	83 e0 0f             	and    $0xf,%eax
ffff800000104d10:	01 d0                	add    %edx,%eax
ffff800000104d12:	89 45 f0             	mov    %eax,-0x10(%rbp)
    CONV(year  );
ffff800000104d15:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104d18:	c1 e8 04             	shr    $0x4,%eax
ffff800000104d1b:	89 c2                	mov    %eax,%edx
ffff800000104d1d:	89 d0                	mov    %edx,%eax
ffff800000104d1f:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d22:	01 d0                	add    %edx,%eax
ffff800000104d24:	01 c0                	add    %eax,%eax
ffff800000104d26:	89 c2                	mov    %eax,%edx
ffff800000104d28:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104d2b:	83 e0 0f             	and    $0xf,%eax
ffff800000104d2e:	01 d0                	add    %edx,%eax
ffff800000104d30:	89 45 f4             	mov    %eax,-0xc(%rbp)
#undef     CONV
  }

  *r = t1;
ffff800000104d33:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104d37:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104d3b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104d3f:	48 89 01             	mov    %rax,(%rcx)
ffff800000104d42:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104d46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d4a:	48 89 41 10          	mov    %rax,0x10(%rcx)
  r->year += 2000;
ffff800000104d4e:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d52:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104d55:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104d5b:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d5f:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000104d62:	90                   	nop
ffff800000104d63:	c9                   	leave
ffff800000104d64:	c3                   	ret

ffff800000104d65 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
ffff800000104d65:	55                   	push   %rbp
ffff800000104d66:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d69:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104d6d:	89 7d dc             	mov    %edi,-0x24(%rbp)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffff800000104d70:	48 ba 94 c6 10 00 00 	movabs $0xffff80000010c694,%rdx
ffff800000104d77:	80 ff ff 
ffff800000104d7a:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104d81:	80 ff ff 
ffff800000104d84:	48 89 d6             	mov    %rdx,%rsi
ffff800000104d87:	48 89 c7             	mov    %rax,%rdi
ffff800000104d8a:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000104d91:	80 ff ff 
ffff800000104d94:	ff d0                	call   *%rax
  readsb(dev, &sb);
ffff800000104d96:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104d9a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104d9d:	48 89 d6             	mov    %rdx,%rsi
ffff800000104da0:	89 c7                	mov    %eax,%edi
ffff800000104da2:	48 b8 b9 21 10 00 00 	movabs $0xffff8000001021b9,%rax
ffff800000104da9:	80 ff ff 
ffff800000104dac:	ff d0                	call   *%rax
  log.start = sb.logstart;
ffff800000104dae:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104db1:	89 c2                	mov    %eax,%edx
ffff800000104db3:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104dba:	80 ff ff 
ffff800000104dbd:	89 50 68             	mov    %edx,0x68(%rax)
  log.size = sb.nlog;
ffff800000104dc0:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104dc3:	89 c2                	mov    %eax,%edx
ffff800000104dc5:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104dcc:	80 ff ff 
ffff800000104dcf:	89 50 6c             	mov    %edx,0x6c(%rax)
  log.dev = dev;
ffff800000104dd2:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000104dd9:	80 ff ff 
ffff800000104ddc:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104ddf:	89 42 78             	mov    %eax,0x78(%rdx)
  recover_from_log();
ffff800000104de2:	48 b8 76 50 10 00 00 	movabs $0xffff800000105076,%rax
ffff800000104de9:	80 ff ff 
ffff800000104dec:	ff d0                	call   *%rax
}
ffff800000104dee:	90                   	nop
ffff800000104def:	c9                   	leave
ffff800000104df0:	c3                   	ret

ffff800000104df1 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
ffff800000104df1:	55                   	push   %rbp
ffff800000104df2:	48 89 e5             	mov    %rsp,%rbp
ffff800000104df5:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104df9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104e00:	e9 dc 00 00 00       	jmp    ffff800000104ee1 <install_trans+0xf0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffff800000104e05:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e0c:	80 ff ff 
ffff800000104e0f:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104e12:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104e15:	01 d0                	add    %edx,%eax
ffff800000104e17:	83 c0 01             	add    $0x1,%eax
ffff800000104e1a:	89 c2                	mov    %eax,%edx
ffff800000104e1c:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e23:	80 ff ff 
ffff800000104e26:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e29:	89 d6                	mov    %edx,%esi
ffff800000104e2b:	89 c7                	mov    %eax,%edi
ffff800000104e2d:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104e34:	80 ff ff 
ffff800000104e37:	ff d0                	call   *%rax
ffff800000104e39:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
ffff800000104e3d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e44:	80 ff ff 
ffff800000104e47:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e4a:	48 63 d2             	movslq %edx,%rdx
ffff800000104e4d:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e51:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104e55:	89 c2                	mov    %eax,%edx
ffff800000104e57:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e5e:	80 ff ff 
ffff800000104e61:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e64:	89 d6                	mov    %edx,%esi
ffff800000104e66:	89 c7                	mov    %eax,%edi
ffff800000104e68:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104e6f:	80 ff ff 
ffff800000104e72:	ff d0                	call   *%rax
ffff800000104e74:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffff800000104e78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e7c:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104e83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e87:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104e8d:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104e92:	48 89 ce             	mov    %rcx,%rsi
ffff800000104e95:	48 89 c7             	mov    %rax,%rdi
ffff800000104e98:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff800000104e9f:	80 ff ff 
ffff800000104ea2:	ff d0                	call   *%rax
    bwrite(dbuf);  // write dst to disk
ffff800000104ea4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104ea8:	48 89 c7             	mov    %rax,%rdi
ffff800000104eab:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104eb2:	80 ff ff 
ffff800000104eb5:	ff d0                	call   *%rax
    brelse(lbuf);
ffff800000104eb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104ebb:	48 89 c7             	mov    %rax,%rdi
ffff800000104ebe:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ec5:	80 ff ff 
ffff800000104ec8:	ff d0                	call   *%rax
    brelse(dbuf);
ffff800000104eca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104ece:	48 89 c7             	mov    %rax,%rdi
ffff800000104ed1:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ed8:	80 ff ff 
ffff800000104edb:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104edd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104ee1:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104ee8:	80 ff ff 
ffff800000104eeb:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104eee:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104ef1:	0f 8c 0e ff ff ff    	jl     ffff800000104e05 <install_trans+0x14>
  }
}
ffff800000104ef7:	90                   	nop
ffff800000104ef8:	90                   	nop
ffff800000104ef9:	c9                   	leave
ffff800000104efa:	c3                   	ret

ffff800000104efb <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffff800000104efb:	55                   	push   %rbp
ffff800000104efc:	48 89 e5             	mov    %rsp,%rbp
ffff800000104eff:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104f03:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104f0a:	80 ff ff 
ffff800000104f0d:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104f10:	89 c2                	mov    %eax,%edx
ffff800000104f12:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104f19:	80 ff ff 
ffff800000104f1c:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104f1f:	89 d6                	mov    %edx,%esi
ffff800000104f21:	89 c7                	mov    %eax,%edi
ffff800000104f23:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104f2a:	80 ff ff 
ffff800000104f2d:	ff d0                	call   *%rax
ffff800000104f2f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffff800000104f33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104f37:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104f3d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffff800000104f41:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f45:	8b 00                	mov    (%rax),%eax
ffff800000104f47:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000104f4e:	80 ff ff 
ffff800000104f51:	89 42 7c             	mov    %eax,0x7c(%rdx)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104f54:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104f5b:	eb 2a                	jmp    ffff800000104f87 <read_head+0x8c>
    log.lh.block[i] = lh->block[i];
ffff800000104f5d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f61:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104f64:	48 63 d2             	movslq %edx,%rdx
ffff800000104f67:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104f6b:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000104f72:	80 ff ff 
ffff800000104f75:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104f78:	48 63 c9             	movslq %ecx,%rcx
ffff800000104f7b:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104f7f:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104f83:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104f87:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104f8e:	80 ff ff 
ffff800000104f91:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104f94:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104f97:	7c c4                	jl     ffff800000104f5d <read_head+0x62>
  }
  brelse(buf);
ffff800000104f99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104f9d:	48 89 c7             	mov    %rax,%rdi
ffff800000104fa0:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104fa7:	80 ff ff 
ffff800000104faa:	ff d0                	call   *%rax
}
ffff800000104fac:	90                   	nop
ffff800000104fad:	c9                   	leave
ffff800000104fae:	c3                   	ret

ffff800000104faf <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffff800000104faf:	55                   	push   %rbp
ffff800000104fb0:	48 89 e5             	mov    %rsp,%rbp
ffff800000104fb3:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104fb7:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104fbe:	80 ff ff 
ffff800000104fc1:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104fc4:	89 c2                	mov    %eax,%edx
ffff800000104fc6:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104fcd:	80 ff ff 
ffff800000104fd0:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104fd3:	89 d6                	mov    %edx,%esi
ffff800000104fd5:	89 c7                	mov    %eax,%edi
ffff800000104fd7:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104fde:	80 ff ff 
ffff800000104fe1:	ff d0                	call   *%rax
ffff800000104fe3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffff800000104fe7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104feb:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104ff1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffff800000104ff5:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104ffc:	80 ff ff 
ffff800000104fff:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000105002:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105006:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffff800000105008:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010500f:	eb 2a                	jmp    ffff80000010503b <write_head+0x8c>
    hb->block[i] = log.lh.block[i];
ffff800000105011:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105018:	80 ff ff 
ffff80000010501b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010501e:	48 63 d2             	movslq %edx,%rdx
ffff800000105021:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105025:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff800000105029:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010502d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105030:	48 63 d2             	movslq %edx,%rdx
ffff800000105033:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000105037:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010503b:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105042:	80 ff ff 
ffff800000105045:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105048:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010504b:	7c c4                	jl     ffff800000105011 <write_head+0x62>
  }
  bwrite(buf);
ffff80000010504d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105051:	48 89 c7             	mov    %rax,%rdi
ffff800000105054:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff80000010505b:	80 ff ff 
ffff80000010505e:	ff d0                	call   *%rax
  brelse(buf);
ffff800000105060:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105064:	48 89 c7             	mov    %rax,%rdi
ffff800000105067:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010506e:	80 ff ff 
ffff800000105071:	ff d0                	call   *%rax
}
ffff800000105073:	90                   	nop
ffff800000105074:	c9                   	leave
ffff800000105075:	c3                   	ret

ffff800000105076 <recover_from_log>:

static void
recover_from_log(void)
{
ffff800000105076:	55                   	push   %rbp
ffff800000105077:	48 89 e5             	mov    %rsp,%rbp
  read_head();
ffff80000010507a:	48 b8 fb 4e 10 00 00 	movabs $0xffff800000104efb,%rax
ffff800000105081:	80 ff ff 
ffff800000105084:	ff d0                	call   *%rax
  install_trans(); // if committed, copy from log to disk
ffff800000105086:	48 b8 f1 4d 10 00 00 	movabs $0xffff800000104df1,%rax
ffff80000010508d:	80 ff ff 
ffff800000105090:	ff d0                	call   *%rax
  log.lh.n = 0;
ffff800000105092:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105099:	80 ff ff 
ffff80000010509c:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
  write_head(); // clear the log
ffff8000001050a3:	48 b8 af 4f 10 00 00 	movabs $0xffff800000104faf,%rax
ffff8000001050aa:	80 ff ff 
ffff8000001050ad:	ff d0                	call   *%rax
}
ffff8000001050af:	90                   	nop
ffff8000001050b0:	5d                   	pop    %rbp
ffff8000001050b1:	c3                   	ret

ffff8000001050b2 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
ffff8000001050b2:	55                   	push   %rbp
ffff8000001050b3:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffff8000001050b6:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050bd:	80 ff ff 
ffff8000001050c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001050c3:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001050ca:	80 ff ff 
ffff8000001050cd:	ff d0                	call   *%rax
  while(1){
    if(log.committing){
ffff8000001050cf:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050d6:	80 ff ff 
ffff8000001050d9:	8b 40 74             	mov    0x74(%rax),%eax
ffff8000001050dc:	85 c0                	test   %eax,%eax
ffff8000001050de:	74 28                	je     ffff800000105108 <begin_op+0x56>
      sleep(&log, &log.lock);
ffff8000001050e0:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff8000001050e7:	80 ff ff 
ffff8000001050ea:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050f1:	80 ff ff 
ffff8000001050f4:	48 89 d6             	mov    %rdx,%rsi
ffff8000001050f7:	48 89 c7             	mov    %rax,%rdi
ffff8000001050fa:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000105101:	80 ff ff 
ffff800000105104:	ff d0                	call   *%rax
ffff800000105106:	eb c7                	jmp    ffff8000001050cf <begin_op+0x1d>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
ffff800000105108:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010510f:	80 ff ff 
ffff800000105112:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff800000105115:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010511c:	80 ff ff 
ffff80000010511f:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105122:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105125:	89 d0                	mov    %edx,%eax
ffff800000105127:	c1 e0 02             	shl    $0x2,%eax
ffff80000010512a:	01 d0                	add    %edx,%eax
ffff80000010512c:	01 c0                	add    %eax,%eax
ffff80000010512e:	01 c8                	add    %ecx,%eax
ffff800000105130:	83 f8 1e             	cmp    $0x1e,%eax
ffff800000105133:	7e 2b                	jle    ffff800000105160 <begin_op+0xae>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
ffff800000105135:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff80000010513c:	80 ff ff 
ffff80000010513f:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105146:	80 ff ff 
ffff800000105149:	48 89 d6             	mov    %rdx,%rsi
ffff80000010514c:	48 89 c7             	mov    %rax,%rdi
ffff80000010514f:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000105156:	80 ff ff 
ffff800000105159:	ff d0                	call   *%rax
ffff80000010515b:	e9 6f ff ff ff       	jmp    ffff8000001050cf <begin_op+0x1d>
    } else {
      log.outstanding += 1;
ffff800000105160:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105167:	80 ff ff 
ffff80000010516a:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010516d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105170:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105177:	80 ff ff 
ffff80000010517a:	89 50 70             	mov    %edx,0x70(%rax)
      release(&log.lock);
ffff80000010517d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105184:	80 ff ff 
ffff800000105187:	48 89 c7             	mov    %rax,%rdi
ffff80000010518a:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000105191:	80 ff ff 
ffff800000105194:	ff d0                	call   *%rax
      break;
ffff800000105196:	90                   	nop
    }
  }
}
ffff800000105197:	90                   	nop
ffff800000105198:	5d                   	pop    %rbp
ffff800000105199:	c3                   	ret

ffff80000010519a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
ffff80000010519a:	55                   	push   %rbp
ffff80000010519b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010519e:	48 83 ec 10          	sub    $0x10,%rsp
  int do_commit = 0;
ffff8000001051a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  acquire(&log.lock);
ffff8000001051a9:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051b0:	80 ff ff 
ffff8000001051b3:	48 89 c7             	mov    %rax,%rdi
ffff8000001051b6:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001051bd:	80 ff ff 
ffff8000001051c0:	ff d0                	call   *%rax
  log.outstanding -= 1;
ffff8000001051c2:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051c9:	80 ff ff 
ffff8000001051cc:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001051cf:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001051d2:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051d9:	80 ff ff 
ffff8000001051dc:	89 50 70             	mov    %edx,0x70(%rax)
  if(log.committing)
ffff8000001051df:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051e6:	80 ff ff 
ffff8000001051e9:	8b 40 74             	mov    0x74(%rax),%eax
ffff8000001051ec:	85 c0                	test   %eax,%eax
ffff8000001051ee:	74 19                	je     ffff800000105209 <end_op+0x6f>
    panic("log.committing");
ffff8000001051f0:	48 b8 98 c6 10 00 00 	movabs $0xffff80000010c698,%rax
ffff8000001051f7:	80 ff ff 
ffff8000001051fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001051fd:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105204:	80 ff ff 
ffff800000105207:	ff d0                	call   *%rax
  if(log.outstanding == 0){
ffff800000105209:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105210:	80 ff ff 
ffff800000105213:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105216:	85 c0                	test   %eax,%eax
ffff800000105218:	75 1a                	jne    ffff800000105234 <end_op+0x9a>
    do_commit = 1;
ffff80000010521a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    log.committing = 1;
ffff800000105221:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105228:	80 ff ff 
ffff80000010522b:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff800000105232:	eb 19                	jmp    ffff80000010524d <end_op+0xb3>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
ffff800000105234:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010523b:	80 ff ff 
ffff80000010523e:	48 89 c7             	mov    %rax,%rdi
ffff800000105241:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff800000105248:	80 ff ff 
ffff80000010524b:	ff d0                	call   *%rax
  }
  release(&log.lock);
ffff80000010524d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105254:	80 ff ff 
ffff800000105257:	48 89 c7             	mov    %rax,%rdi
ffff80000010525a:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000105261:	80 ff ff 
ffff800000105264:	ff d0                	call   *%rax

  if(do_commit){
ffff800000105266:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010526a:	74 68                	je     ffff8000001052d4 <end_op+0x13a>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
ffff80000010526c:	48 b8 e1 53 10 00 00 	movabs $0xffff8000001053e1,%rax
ffff800000105273:	80 ff ff 
ffff800000105276:	ff d0                	call   *%rax
    acquire(&log.lock);
ffff800000105278:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010527f:	80 ff ff 
ffff800000105282:	48 89 c7             	mov    %rax,%rdi
ffff800000105285:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010528c:	80 ff ff 
ffff80000010528f:	ff d0                	call   *%rax
    log.committing = 0;
ffff800000105291:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105298:	80 ff ff 
ffff80000010529b:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
    wakeup(&log);
ffff8000001052a2:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052a9:	80 ff ff 
ffff8000001052ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001052af:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff8000001052b6:	80 ff ff 
ffff8000001052b9:	ff d0                	call   *%rax
    release(&log.lock);
ffff8000001052bb:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052c2:	80 ff ff 
ffff8000001052c5:	48 89 c7             	mov    %rax,%rdi
ffff8000001052c8:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001052cf:	80 ff ff 
ffff8000001052d2:	ff d0                	call   *%rax
  }
}
ffff8000001052d4:	90                   	nop
ffff8000001052d5:	c9                   	leave
ffff8000001052d6:	c3                   	ret

ffff8000001052d7 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
ffff8000001052d7:	55                   	push   %rbp
ffff8000001052d8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001052db:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001052df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001052e6:	e9 dc 00 00 00       	jmp    ffff8000001053c7 <write_log+0xf0>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
ffff8000001052eb:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052f2:	80 ff ff 
ffff8000001052f5:	8b 50 68             	mov    0x68(%rax),%edx
ffff8000001052f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001052fb:	01 d0                	add    %edx,%eax
ffff8000001052fd:	83 c0 01             	add    $0x1,%eax
ffff800000105300:	89 c2                	mov    %eax,%edx
ffff800000105302:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105309:	80 ff ff 
ffff80000010530c:	8b 40 78             	mov    0x78(%rax),%eax
ffff80000010530f:	89 d6                	mov    %edx,%esi
ffff800000105311:	89 c7                	mov    %eax,%edi
ffff800000105313:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010531a:	80 ff ff 
ffff80000010531d:	ff d0                	call   *%rax
ffff80000010531f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
ffff800000105323:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010532a:	80 ff ff 
ffff80000010532d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105330:	48 63 d2             	movslq %edx,%rdx
ffff800000105333:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105337:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff80000010533b:	89 c2                	mov    %eax,%edx
ffff80000010533d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105344:	80 ff ff 
ffff800000105347:	8b 40 78             	mov    0x78(%rax),%eax
ffff80000010534a:	89 d6                	mov    %edx,%esi
ffff80000010534c:	89 c7                	mov    %eax,%edi
ffff80000010534e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105355:	80 ff ff 
ffff800000105358:	ff d0                	call   *%rax
ffff80000010535a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(to->data, from->data, BSIZE);
ffff80000010535e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105362:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000105369:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010536d:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000105373:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000105378:	48 89 ce             	mov    %rcx,%rsi
ffff80000010537b:	48 89 c7             	mov    %rax,%rdi
ffff80000010537e:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff800000105385:	80 ff ff 
ffff800000105388:	ff d0                	call   *%rax
    bwrite(to);  // write the log
ffff80000010538a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010538e:	48 89 c7             	mov    %rax,%rdi
ffff800000105391:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000105398:	80 ff ff 
ffff80000010539b:	ff d0                	call   *%rax
    brelse(from);
ffff80000010539d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001053a4:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001053ab:	80 ff ff 
ffff8000001053ae:	ff d0                	call   *%rax
    brelse(to);
ffff8000001053b0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001053b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001053b7:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001053be:	80 ff ff 
ffff8000001053c1:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001053c3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001053c7:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001053ce:	80 ff ff 
ffff8000001053d1:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053d4:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001053d7:	0f 8c 0e ff ff ff    	jl     ffff8000001052eb <write_log+0x14>
  }
}
ffff8000001053dd:	90                   	nop
ffff8000001053de:	90                   	nop
ffff8000001053df:	c9                   	leave
ffff8000001053e0:	c3                   	ret

ffff8000001053e1 <commit>:

static void
commit()
{
ffff8000001053e1:	55                   	push   %rbp
ffff8000001053e2:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffff8000001053e5:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001053ec:	80 ff ff 
ffff8000001053ef:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053f2:	85 c0                	test   %eax,%eax
ffff8000001053f4:	7e 41                	jle    ffff800000105437 <commit+0x56>
    write_log();     // Write modified blocks from cache to log
ffff8000001053f6:	48 b8 d7 52 10 00 00 	movabs $0xffff8000001052d7,%rax
ffff8000001053fd:	80 ff ff 
ffff800000105400:	ff d0                	call   *%rax
    write_head();    // Write header to disk -- the real commit
ffff800000105402:	48 b8 af 4f 10 00 00 	movabs $0xffff800000104faf,%rax
ffff800000105409:	80 ff ff 
ffff80000010540c:	ff d0                	call   *%rax
    install_trans(); // Now install writes to home locations
ffff80000010540e:	48 b8 f1 4d 10 00 00 	movabs $0xffff800000104df1,%rax
ffff800000105415:	80 ff ff 
ffff800000105418:	ff d0                	call   *%rax
    log.lh.n = 0;
ffff80000010541a:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105421:	80 ff ff 
ffff800000105424:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
    write_head();    // Erase the transaction from the log
ffff80000010542b:	48 b8 af 4f 10 00 00 	movabs $0xffff800000104faf,%rax
ffff800000105432:	80 ff ff 
ffff800000105435:	ff d0                	call   *%rax
  }
}
ffff800000105437:	90                   	nop
ffff800000105438:	5d                   	pop    %rbp
ffff800000105439:	c3                   	ret

ffff80000010543a <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffff80000010543a:	55                   	push   %rbp
ffff80000010543b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010543e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105442:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffff800000105446:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010544d:	80 ff ff 
ffff800000105450:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105453:	83 f8 1d             	cmp    $0x1d,%eax
ffff800000105456:	7f 21                	jg     ffff800000105479 <log_write+0x3f>
ffff800000105458:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010545f:	80 ff ff 
ffff800000105462:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000105465:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010546c:	80 ff ff 
ffff80000010546f:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff800000105472:	83 e8 01             	sub    $0x1,%eax
ffff800000105475:	39 c2                	cmp    %eax,%edx
ffff800000105477:	7c 19                	jl     ffff800000105492 <log_write+0x58>
    panic("too big a transaction");
ffff800000105479:	48 b8 a7 c6 10 00 00 	movabs $0xffff80000010c6a7,%rax
ffff800000105480:	80 ff ff 
ffff800000105483:	48 89 c7             	mov    %rax,%rdi
ffff800000105486:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010548d:	80 ff ff 
ffff800000105490:	ff d0                	call   *%rax
  if (log.outstanding < 1)
ffff800000105492:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105499:	80 ff ff 
ffff80000010549c:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010549f:	85 c0                	test   %eax,%eax
ffff8000001054a1:	7f 19                	jg     ffff8000001054bc <log_write+0x82>
    panic("log_write outside of trans");
ffff8000001054a3:	48 b8 bd c6 10 00 00 	movabs $0xffff80000010c6bd,%rax
ffff8000001054aa:	80 ff ff 
ffff8000001054ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001054b0:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001054b7:	80 ff ff 
ffff8000001054ba:	ff d0                	call   *%rax

  acquire(&log.lock);
ffff8000001054bc:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001054c3:	80 ff ff 
ffff8000001054c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001054c9:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001054d0:	80 ff ff 
ffff8000001054d3:	ff d0                	call   *%rax
  for (i = 0; i < log.lh.n; i++) {
ffff8000001054d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001054dc:	eb 29                	jmp    ffff800000105507 <log_write+0xcd>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
ffff8000001054de:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001054e5:	80 ff ff 
ffff8000001054e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001054eb:	48 63 d2             	movslq %edx,%rdx
ffff8000001054ee:	48 83 c2 1c          	add    $0x1c,%rdx
ffff8000001054f2:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff8000001054f6:	89 c2                	mov    %eax,%edx
ffff8000001054f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001054fc:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001054ff:	39 c2                	cmp    %eax,%edx
ffff800000105501:	74 18                	je     ffff80000010551b <log_write+0xe1>
  for (i = 0; i < log.lh.n; i++) {
ffff800000105503:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105507:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010550e:	80 ff ff 
ffff800000105511:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105514:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105517:	7c c5                	jl     ffff8000001054de <log_write+0xa4>
ffff800000105519:	eb 01                	jmp    ffff80000010551c <log_write+0xe2>
      break;
ffff80000010551b:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
ffff80000010551c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105520:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000105523:	89 c1                	mov    %eax,%ecx
ffff800000105525:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010552c:	80 ff ff 
ffff80000010552f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000105532:	48 63 d2             	movslq %edx,%rdx
ffff800000105535:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105539:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
  if (i == log.lh.n)
ffff80000010553d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105544:	80 ff ff 
ffff800000105547:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010554a:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff80000010554d:	75 1d                	jne    ffff80000010556c <log_write+0x132>
    log.lh.n++;
ffff80000010554f:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105556:	80 ff ff 
ffff800000105559:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010555c:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010555f:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105566:	80 ff ff 
ffff800000105569:	89 50 7c             	mov    %edx,0x7c(%rax)
  b->flags |= B_DIRTY; // prevent eviction
ffff80000010556c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105570:	8b 00                	mov    (%rax),%eax
ffff800000105572:	83 c8 04             	or     $0x4,%eax
ffff800000105575:	89 c2                	mov    %eax,%edx
ffff800000105577:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010557b:	89 10                	mov    %edx,(%rax)
  release(&log.lock);
ffff80000010557d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105584:	80 ff ff 
ffff800000105587:	48 89 c7             	mov    %rax,%rdi
ffff80000010558a:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000105591:	80 ff ff 
ffff800000105594:	ff d0                	call   *%rax
}
ffff800000105596:	90                   	nop
ffff800000105597:	c9                   	leave
ffff800000105598:	c3                   	ret

ffff800000105599 <v2p>:
#define KERNBASE 0xFFFF800000000000 // First kernel virtual address

#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__
static inline addr_t v2p(void *a) {
ffff800000105599:	55                   	push   %rbp
ffff80000010559a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010559d:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001055a1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff8000001055a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001055a9:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001055b0:	80 00 00 
ffff8000001055b3:	48 01 d0             	add    %rdx,%rax
}
ffff8000001055b6:	c9                   	leave
ffff8000001055b7:	c3                   	ret

ffff8000001055b8 <xchg>:

static inline uint
xchg(volatile uint *addr, addr_t newval)
{
ffff8000001055b8:	55                   	push   %rbp
ffff8000001055b9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055bc:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001055c0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001055c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffff8000001055c8:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001055cc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001055d0:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001055d4:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001055d7:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffff8000001055da:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001055dd:	c9                   	leave
ffff8000001055de:	c3                   	ret

ffff8000001055df <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffff8000001055df:	55                   	push   %rbp
ffff8000001055e0:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffff8000001055e3:	48 b8 c3 9f 10 00 00 	movabs $0xffff800000109fc3,%rax
ffff8000001055ea:	80 ff ff 
ffff8000001055ed:	ff d0                	call   *%rax
  kinit1(end, P2V(PHYSTOP)); // phys page allocator
ffff8000001055ef:	48 ba 00 00 00 0e 00 	movabs $0xffff80000e000000,%rdx
ffff8000001055f6:	80 ff ff 
ffff8000001055f9:	48 b8 00 e0 11 00 00 	movabs $0xffff80000011e000,%rax
ffff800000105600:	80 ff ff 
ffff800000105603:	48 89 d6             	mov    %rdx,%rsi
ffff800000105606:	48 89 c7             	mov    %rax,%rdi
ffff800000105609:	48 b8 ea 40 10 00 00 	movabs $0xffff8000001040ea,%rax
ffff800000105610:	80 ff ff 
ffff800000105613:	ff d0                	call   *%rax
  kvmalloc();      // kernel page table
ffff800000105615:	48 b8 4b b2 10 00 00 	movabs $0xffff80000010b24b,%rax
ffff80000010561c:	80 ff ff 
ffff80000010561f:	ff d0                	call   *%rax
  mpinit();        // detect other processors
ffff800000105621:	48 b8 ef 5b 10 00 00 	movabs $0xffff800000105bef,%rax
ffff800000105628:	80 ff ff 
ffff80000010562b:	ff d0                	call   *%rax
  lapicinit();     // interrupt controller
ffff80000010562d:	48 b8 ef 46 10 00 00 	movabs $0xffff8000001046ef,%rax
ffff800000105634:	80 ff ff 
ffff800000105637:	ff d0                	call   *%rax
  tvinit();        // trap vectors
ffff800000105639:	48 b8 9b 9a 10 00 00 	movabs $0xffff800000109a9b,%rax
ffff800000105640:	80 ff ff 
ffff800000105643:	ff d0                	call   *%rax
  seginit();       // segment descriptors
ffff800000105645:	48 b8 90 ad 10 00 00 	movabs $0xffff80000010ad90,%rax
ffff80000010564c:	80 ff ff 
ffff80000010564f:	ff d0                	call   *%rax
  cprintf("\ncpu%d: starting Spring 2026 xv6\n\n", cpunum());
ffff800000105651:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff800000105658:	80 ff ff 
ffff80000010565b:	ff d0                	call   *%rax
ffff80000010565d:	89 c2                	mov    %eax,%edx
ffff80000010565f:	48 b8 d8 c6 10 00 00 	movabs $0xffff80000010c6d8,%rax
ffff800000105666:	80 ff ff 
ffff800000105669:	89 d6                	mov    %edx,%esi
ffff80000010566b:	48 89 c7             	mov    %rax,%rdi
ffff80000010566e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105673:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010567a:	80 ff ff 
ffff80000010567d:	ff d2                	call   *%rdx
  ioapicinit();    // another interrupt controller
ffff80000010567f:	48 b8 b5 3f 10 00 00 	movabs $0xffff800000103fb5,%rax
ffff800000105686:	80 ff ff 
ffff800000105689:	ff d0                	call   *%rax
  consoleinit();   // console hardware
ffff80000010568b:	48 b8 c1 15 10 00 00 	movabs $0xffff8000001015c1,%rax
ffff800000105692:	80 ff ff 
ffff800000105695:	ff d0                	call   *%rax
  uartinit();      // serial port
ffff800000105697:	48 b8 c7 a0 10 00 00 	movabs $0xffff80000010a0c7,%rax
ffff80000010569e:	80 ff ff 
ffff8000001056a1:	ff d0                	call   *%rax
  
  traceinit();     // trace buffer
ffff8000001056a3:	48 b8 06 c1 10 00 00 	movabs $0xffff80000010c106,%rax
ffff8000001056aa:	80 ff ff 
ffff8000001056ad:	ff d0                	call   *%rax

  pinit();         // process table
ffff8000001056af:	48 b8 2f 63 10 00 00 	movabs $0xffff80000010632f,%rax
ffff8000001056b6:	80 ff ff 
ffff8000001056b9:	ff d0                	call   *%rax
  binit();         // buffer cache
ffff8000001056bb:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff8000001056c2:	80 ff ff 
ffff8000001056c5:	ff d0                	call   *%rax
  fileinit();      // file table
ffff8000001056c7:	48 b8 45 1c 10 00 00 	movabs $0xffff800000101c45,%rax
ffff8000001056ce:	80 ff ff 
ffff8000001056d1:	ff d0                	call   *%rax
  ideinit();       // disk
ffff8000001056d3:	48 b8 04 3a 10 00 00 	movabs $0xffff800000103a04,%rax
ffff8000001056da:	80 ff ff 
ffff8000001056dd:	ff d0                	call   *%rax
  startothers();   // start other processors
ffff8000001056df:	48 b8 bc 57 10 00 00 	movabs $0xffff8000001057bc,%rax
ffff8000001056e6:	80 ff ff 
ffff8000001056e9:	ff d0                	call   *%rax
  kinit2();
ffff8000001056eb:	48 b8 60 41 10 00 00 	movabs $0xffff800000104160,%rax
ffff8000001056f2:	80 ff ff 
ffff8000001056f5:	ff d0                	call   *%rax
  userinit();      // first user process
ffff8000001056f7:	48 b8 da 64 10 00 00 	movabs $0xffff8000001064da,%rax
ffff8000001056fe:	80 ff ff 
ffff800000105701:	ff d0                	call   *%rax
  mpmain();        // finish this processor's setup
ffff800000105703:	48 b8 43 57 10 00 00 	movabs $0xffff800000105743,%rax
ffff80000010570a:	80 ff ff 
ffff80000010570d:	ff d0                	call   *%rax

ffff80000010570f <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffff80000010570f:	55                   	push   %rbp
ffff800000105710:	48 89 e5             	mov    %rsp,%rbp
  switchkvm();
ffff800000105713:	48 b8 4c b6 10 00 00 	movabs $0xffff80000010b64c,%rax
ffff80000010571a:	80 ff ff 
ffff80000010571d:	ff d0                	call   *%rax
  seginit();
ffff80000010571f:	48 b8 90 ad 10 00 00 	movabs $0xffff80000010ad90,%rax
ffff800000105726:	80 ff ff 
ffff800000105729:	ff d0                	call   *%rax
  lapicinit();
ffff80000010572b:	48 b8 ef 46 10 00 00 	movabs $0xffff8000001046ef,%rax
ffff800000105732:	80 ff ff 
ffff800000105735:	ff d0                	call   *%rax
  mpmain();
ffff800000105737:	48 b8 43 57 10 00 00 	movabs $0xffff800000105743,%rax
ffff80000010573e:	80 ff ff 
ffff800000105741:	ff d0                	call   *%rax

ffff800000105743 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffff800000105743:	55                   	push   %rbp
ffff800000105744:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpunum());
ffff800000105747:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff80000010574e:	80 ff ff 
ffff800000105751:	ff d0                	call   *%rax
ffff800000105753:	89 c2                	mov    %eax,%edx
ffff800000105755:	48 b8 fb c6 10 00 00 	movabs $0xffff80000010c6fb,%rax
ffff80000010575c:	80 ff ff 
ffff80000010575f:	89 d6                	mov    %edx,%esi
ffff800000105761:	48 89 c7             	mov    %rax,%rdi
ffff800000105764:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105769:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105770:	80 ff ff 
ffff800000105773:	ff d2                	call   *%rdx
  idtinit();       // load idt register
ffff800000105775:	48 b8 73 9a 10 00 00 	movabs $0xffff800000109a73,%rax
ffff80000010577c:	80 ff ff 
ffff80000010577f:	ff d0                	call   *%rax
  syscallinit();   // syscall set up
ffff800000105781:	48 b8 19 ad 10 00 00 	movabs $0xffff80000010ad19,%rax
ffff800000105788:	80 ff ff 
ffff80000010578b:	ff d0                	call   *%rax
  xchg(&cpu->started, 1); // tell startothers() we're up
ffff80000010578d:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000105794:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000105798:	48 83 c0 10          	add    $0x10,%rax
ffff80000010579c:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001057a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001057a4:	48 b8 b8 55 10 00 00 	movabs $0xffff8000001055b8,%rax
ffff8000001057ab:	80 ff ff 
ffff8000001057ae:	ff d0                	call   *%rax
  scheduler();     // start running processes
ffff8000001057b0:	48 b8 ba 6d 10 00 00 	movabs $0xffff800000106dba,%rax
ffff8000001057b7:	80 ff ff 
ffff8000001057ba:	ff d0                	call   *%rax

ffff8000001057bc <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffff8000001057bc:	55                   	push   %rbp
ffff8000001057bd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001057c0:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
ffff8000001057c4:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff8000001057cb:	80 ff ff 
ffff8000001057ce:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_entryother_start,
ffff8000001057d2:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff8000001057d9:	00 00 00 
ffff8000001057dc:	89 c2                	mov    %eax,%edx
ffff8000001057de:	48 b9 90 df 10 00 00 	movabs $0xffff80000010df90,%rcx
ffff8000001057e5:	80 ff ff 
ffff8000001057e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057ec:	48 89 ce             	mov    %rcx,%rsi
ffff8000001057ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001057f2:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff8000001057f9:	80 ff ff 
ffff8000001057fc:	ff d0                	call   *%rax
          (addr_t)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001057fe:	48 b8 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rax
ffff800000105805:	80 ff ff 
ffff800000105808:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010580c:	e9 c6 00 00 00       	jmp    ffff8000001058d7 <startothers+0x11b>
    if(c == cpus+cpunum())  // We've started already.
ffff800000105811:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff800000105818:	80 ff ff 
ffff80000010581b:	ff d0                	call   *%rax
ffff80000010581d:	48 63 d0             	movslq %eax,%rdx
ffff800000105820:	48 89 d0             	mov    %rdx,%rax
ffff800000105823:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105827:	48 01 d0             	add    %rdx,%rax
ffff80000010582a:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010582e:	48 89 c2             	mov    %rax,%rdx
ffff800000105831:	48 b8 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rax
ffff800000105838:	80 ff ff 
ffff80000010583b:	48 01 d0             	add    %rdx,%rax
ffff80000010583e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105842:	0f 84 89 00 00 00    	je     ffff8000001058d1 <startothers+0x115>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffff800000105848:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010584f:	80 ff ff 
ffff800000105852:	ff d0                	call   *%rax
ffff800000105854:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    *(uint32*)(code-4) = 0x8000; // enough stack to get us to entry64mp
ffff800000105858:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010585c:	48 83 e8 04          	sub    $0x4,%rax
ffff800000105860:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffff800000105866:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff80000010586d:	80 ff ff 
ffff800000105870:	48 89 c7             	mov    %rax,%rdi
ffff800000105873:	48 b8 99 55 10 00 00 	movabs $0xffff800000105599,%rax
ffff80000010587a:	80 ff ff 
ffff80000010587d:	ff d0                	call   *%rax
ffff80000010587f:	48 89 c2             	mov    %rax,%rdx
ffff800000105882:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105886:	48 83 e8 08          	sub    $0x8,%rax
ffff80000010588a:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffff80000010588c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105890:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff800000105897:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010589b:	48 83 e8 10          	sub    $0x10,%rax
ffff80000010589f:	48 89 10             	mov    %rdx,(%rax)

    lapicstartap(c->apicid, V2P(code));
ffff8000001058a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001058a6:	89 c2                	mov    %eax,%edx
ffff8000001058a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058ac:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff8000001058b0:	0f b6 c0             	movzbl %al,%eax
ffff8000001058b3:	89 d6                	mov    %edx,%esi
ffff8000001058b5:	89 c7                	mov    %eax,%edi
ffff8000001058b7:	48 b8 c2 49 10 00 00 	movabs $0xffff8000001049c2,%rax
ffff8000001058be:	80 ff ff 
ffff8000001058c1:	ff d0                	call   *%rax

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffff8000001058c3:	90                   	nop
ffff8000001058c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058c8:	8b 40 10             	mov    0x10(%rax),%eax
ffff8000001058cb:	85 c0                	test   %eax,%eax
ffff8000001058cd:	74 f5                	je     ffff8000001058c4 <startothers+0x108>
ffff8000001058cf:	eb 01                	jmp    ffff8000001058d2 <startothers+0x116>
      continue;
ffff8000001058d1:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001058d2:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff8000001058d7:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff8000001058de:	80 ff ff 
ffff8000001058e1:	8b 00                	mov    (%rax),%eax
ffff8000001058e3:	48 63 d0             	movslq %eax,%rdx
ffff8000001058e6:	48 89 d0             	mov    %rdx,%rax
ffff8000001058e9:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001058ed:	48 01 d0             	add    %rdx,%rax
ffff8000001058f0:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001058f4:	48 89 c2             	mov    %rax,%rdx
ffff8000001058f7:	48 b8 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rax
ffff8000001058fe:	80 ff ff 
ffff800000105901:	48 01 d0             	add    %rdx,%rax
ffff800000105904:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105908:	0f 82 03 ff ff ff    	jb     ffff800000105811 <startothers+0x55>
      ;
  }
}
ffff80000010590e:	90                   	nop
ffff80000010590f:	90                   	nop
ffff800000105910:	c9                   	leave
ffff800000105911:	c3                   	ret

ffff800000105912 <inb>:
{
ffff800000105912:	55                   	push   %rbp
ffff800000105913:	48 89 e5             	mov    %rsp,%rbp
ffff800000105916:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010591a:	89 f8                	mov    %edi,%eax
ffff80000010591c:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000105920:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000105924:	89 c2                	mov    %eax,%edx
ffff800000105926:	ec                   	in     (%dx),%al
ffff800000105927:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010592a:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff80000010592e:	c9                   	leave
ffff80000010592f:	c3                   	ret

ffff800000105930 <outb>:
{
ffff800000105930:	55                   	push   %rbp
ffff800000105931:	48 89 e5             	mov    %rsp,%rbp
ffff800000105934:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000105938:	89 fa                	mov    %edi,%edx
ffff80000010593a:	89 f0                	mov    %esi,%eax
ffff80000010593c:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000105940:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000105943:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000105947:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010594b:	ee                   	out    %al,(%dx)
}
ffff80000010594c:	90                   	nop
ffff80000010594d:	c9                   	leave
ffff80000010594e:	c3                   	ret

ffff80000010594f <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
ffff80000010594f:	55                   	push   %rbp
ffff800000105950:	48 89 e5             	mov    %rsp,%rbp
ffff800000105953:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105957:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010595b:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, sum;

  sum = 0;
ffff80000010595e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105965:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010596c:	eb 1a                	jmp    ffff800000105988 <sum+0x39>
    sum += addr[i];
ffff80000010596e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105971:	48 63 d0             	movslq %eax,%rdx
ffff800000105974:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105978:	48 01 d0             	add    %rdx,%rax
ffff80000010597b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010597e:	0f b6 c0             	movzbl %al,%eax
ffff800000105981:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105984:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105988:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010598b:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff80000010598e:	7c de                	jl     ffff80000010596e <sum+0x1f>
  return sum;
ffff800000105990:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000105993:	c9                   	leave
ffff800000105994:	c3                   	ret

ffff800000105995 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(addr_t a, int len)
{
ffff800000105995:	55                   	push   %rbp
ffff800000105996:	48 89 e5             	mov    %rsp,%rbp
ffff800000105999:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010599d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001059a1:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uchar *e, *p, *addr;
  addr = P2V(a);
ffff8000001059a4:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff8000001059ab:	80 ff ff 
ffff8000001059ae:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001059b2:	48 01 d0             	add    %rdx,%rax
ffff8000001059b5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffff8000001059b9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001059bc:	48 63 d0             	movslq %eax,%rdx
ffff8000001059bf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059c3:	48 01 d0             	add    %rdx,%rax
ffff8000001059c6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffff8000001059ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059ce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001059d2:	eb 50                	jmp    ffff800000105a24 <mpsearch1+0x8f>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffff8000001059d4:	48 b9 10 c7 10 00 00 	movabs $0xffff80000010c710,%rcx
ffff8000001059db:	80 ff ff 
ffff8000001059de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001059e2:	ba 04 00 00 00       	mov    $0x4,%edx
ffff8000001059e7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001059ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001059ed:	48 b8 ec 7a 10 00 00 	movabs $0xffff800000107aec,%rax
ffff8000001059f4:	80 ff ff 
ffff8000001059f7:	ff d0                	call   *%rax
ffff8000001059f9:	85 c0                	test   %eax,%eax
ffff8000001059fb:	75 22                	jne    ffff800000105a1f <mpsearch1+0x8a>
ffff8000001059fd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a01:	be 10 00 00 00       	mov    $0x10,%esi
ffff800000105a06:	48 89 c7             	mov    %rax,%rdi
ffff800000105a09:	48 b8 4f 59 10 00 00 	movabs $0xffff80000010594f,%rax
ffff800000105a10:	80 ff ff 
ffff800000105a13:	ff d0                	call   *%rax
ffff800000105a15:	84 c0                	test   %al,%al
ffff800000105a17:	75 06                	jne    ffff800000105a1f <mpsearch1+0x8a>
      return (struct mp*)p;
ffff800000105a19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a1d:	eb 14                	jmp    ffff800000105a33 <mpsearch1+0x9e>
  for(p = addr; p < e; p += sizeof(struct mp))
ffff800000105a1f:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff800000105a24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a28:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105a2c:	72 a6                	jb     ffff8000001059d4 <mpsearch1+0x3f>
  return 0;
ffff800000105a2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000105a33:	c9                   	leave
ffff800000105a34:	c3                   	ret

ffff800000105a35 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffff800000105a35:	55                   	push   %rbp
ffff800000105a36:	48 89 e5             	mov    %rsp,%rbp
ffff800000105a39:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffff800000105a3d:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff800000105a44:	80 ff ff 
ffff800000105a47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffff800000105a4b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a4f:	48 83 c0 0f          	add    $0xf,%rax
ffff800000105a53:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a56:	0f b6 c0             	movzbl %al,%eax
ffff800000105a59:	c1 e0 08             	shl    $0x8,%eax
ffff800000105a5c:	89 c2                	mov    %eax,%edx
ffff800000105a5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a62:	48 83 c0 0e          	add    $0xe,%rax
ffff800000105a66:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a69:	0f b6 c0             	movzbl %al,%eax
ffff800000105a6c:	09 d0                	or     %edx,%eax
ffff800000105a6e:	c1 e0 04             	shl    $0x4,%eax
ffff800000105a71:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000105a74:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105a78:	74 28                	je     ffff800000105aa2 <mpsearch+0x6d>
    if((mp = mpsearch1(p, 1024)))
ffff800000105a7a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105a7d:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105a82:	48 89 c7             	mov    %rax,%rdi
ffff800000105a85:	48 b8 95 59 10 00 00 	movabs $0xffff800000105995,%rax
ffff800000105a8c:	80 ff ff 
ffff800000105a8f:	ff d0                	call   *%rax
ffff800000105a91:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105a95:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105a9a:	74 5e                	je     ffff800000105afa <mpsearch+0xc5>
      return mp;
ffff800000105a9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105aa0:	eb 6e                	jmp    ffff800000105b10 <mpsearch+0xdb>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffff800000105aa2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105aa6:	48 83 c0 14          	add    $0x14,%rax
ffff800000105aaa:	0f b6 00             	movzbl (%rax),%eax
ffff800000105aad:	0f b6 c0             	movzbl %al,%eax
ffff800000105ab0:	c1 e0 08             	shl    $0x8,%eax
ffff800000105ab3:	89 c2                	mov    %eax,%edx
ffff800000105ab5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ab9:	48 83 c0 13          	add    $0x13,%rax
ffff800000105abd:	0f b6 00             	movzbl (%rax),%eax
ffff800000105ac0:	0f b6 c0             	movzbl %al,%eax
ffff800000105ac3:	09 d0                	or     %edx,%eax
ffff800000105ac5:	c1 e0 0a             	shl    $0xa,%eax
ffff800000105ac8:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffff800000105acb:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105ace:	2d 00 04 00 00       	sub    $0x400,%eax
ffff800000105ad3:	89 c0                	mov    %eax,%eax
ffff800000105ad5:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105ada:	48 89 c7             	mov    %rax,%rdi
ffff800000105add:	48 b8 95 59 10 00 00 	movabs $0xffff800000105995,%rax
ffff800000105ae4:	80 ff ff 
ffff800000105ae7:	ff d0                	call   *%rax
ffff800000105ae9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105aed:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105af2:	74 06                	je     ffff800000105afa <mpsearch+0xc5>
      return mp;
ffff800000105af4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105af8:	eb 16                	jmp    ffff800000105b10 <mpsearch+0xdb>
  }
  return mpsearch1(0xF0000, 0x10000);
ffff800000105afa:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000105aff:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff800000105b04:	48 b8 95 59 10 00 00 	movabs $0xffff800000105995,%rax
ffff800000105b0b:	80 ff ff 
ffff800000105b0e:	ff d0                	call   *%rax
}
ffff800000105b10:	c9                   	leave
ffff800000105b11:	c3                   	ret

ffff800000105b12 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffff800000105b12:	55                   	push   %rbp
ffff800000105b13:	48 89 e5             	mov    %rsp,%rbp
ffff800000105b16:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105b1a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffff800000105b1e:	48 b8 35 5a 10 00 00 	movabs $0xffff800000105a35,%rax
ffff800000105b25:	80 ff ff 
ffff800000105b28:	ff d0                	call   *%rax
ffff800000105b2a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105b2e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105b33:	74 0b                	je     ffff800000105b40 <mpconfig+0x2e>
ffff800000105b35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b39:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105b3c:	85 c0                	test   %eax,%eax
ffff800000105b3e:	75 0a                	jne    ffff800000105b4a <mpconfig+0x38>
    return 0;
ffff800000105b40:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105b45:	e9 a3 00 00 00       	jmp    ffff800000105bed <mpconfig+0xdb>
  conf = (struct mpconf*) P2V((addr_t) mp->physaddr);
ffff800000105b4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b4e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105b51:	89 c2                	mov    %eax,%edx
ffff800000105b53:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105b5a:	80 ff ff 
ffff800000105b5d:	48 01 d0             	add    %rdx,%rax
ffff800000105b60:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffff800000105b64:	48 b9 15 c7 10 00 00 	movabs $0xffff80000010c715,%rcx
ffff800000105b6b:	80 ff ff 
ffff800000105b6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105b72:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105b77:	48 89 ce             	mov    %rcx,%rsi
ffff800000105b7a:	48 89 c7             	mov    %rax,%rdi
ffff800000105b7d:	48 b8 ec 7a 10 00 00 	movabs $0xffff800000107aec,%rax
ffff800000105b84:	80 ff ff 
ffff800000105b87:	ff d0                	call   *%rax
ffff800000105b89:	85 c0                	test   %eax,%eax
ffff800000105b8b:	74 07                	je     ffff800000105b94 <mpconfig+0x82>
    return 0;
ffff800000105b8d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105b92:	eb 59                	jmp    ffff800000105bed <mpconfig+0xdb>
  if(conf->version != 1 && conf->version != 4)
ffff800000105b94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105b98:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105b9c:	3c 01                	cmp    $0x1,%al
ffff800000105b9e:	74 13                	je     ffff800000105bb3 <mpconfig+0xa1>
ffff800000105ba0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105ba4:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105ba8:	3c 04                	cmp    $0x4,%al
ffff800000105baa:	74 07                	je     ffff800000105bb3 <mpconfig+0xa1>
    return 0;
ffff800000105bac:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bb1:	eb 3a                	jmp    ffff800000105bed <mpconfig+0xdb>
  if(sum((uchar*)conf, conf->length) != 0)
ffff800000105bb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bb7:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105bbb:	0f b7 d0             	movzwl %ax,%edx
ffff800000105bbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bc2:	89 d6                	mov    %edx,%esi
ffff800000105bc4:	48 89 c7             	mov    %rax,%rdi
ffff800000105bc7:	48 b8 4f 59 10 00 00 	movabs $0xffff80000010594f,%rax
ffff800000105bce:	80 ff ff 
ffff800000105bd1:	ff d0                	call   *%rax
ffff800000105bd3:	84 c0                	test   %al,%al
ffff800000105bd5:	74 07                	je     ffff800000105bde <mpconfig+0xcc>
    return 0;
ffff800000105bd7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bdc:	eb 0f                	jmp    ffff800000105bed <mpconfig+0xdb>
  *pmp = mp;
ffff800000105bde:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105be2:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105be6:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffff800000105be9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000105bed:	c9                   	leave
ffff800000105bee:	c3                   	ret

ffff800000105bef <mpinit>:

void
mpinit(void)
{
ffff800000105bef:	55                   	push   %rbp
ffff800000105bf0:	48 89 e5             	mov    %rsp,%rbp
ffff800000105bf3:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0) {
ffff800000105bf7:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000105bfb:	48 89 c7             	mov    %rax,%rdi
ffff800000105bfe:	48 b8 12 5b 10 00 00 	movabs $0xffff800000105b12,%rax
ffff800000105c05:	80 ff ff 
ffff800000105c08:	ff d0                	call   *%rax
ffff800000105c0a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105c0e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105c13:	75 23                	jne    ffff800000105c38 <mpinit+0x49>
    cprintf("No other CPUs found.\n");
ffff800000105c15:	48 b8 1a c7 10 00 00 	movabs $0xffff80000010c71a,%rax
ffff800000105c1c:	80 ff ff 
ffff800000105c1f:	48 89 c7             	mov    %rax,%rdi
ffff800000105c22:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c27:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105c2e:	80 ff ff 
ffff800000105c31:	ff d2                	call   *%rdx
ffff800000105c33:	e9 c9 01 00 00       	jmp    ffff800000105e01 <mpinit+0x212>
    return;
  }
  lapic = P2V((addr_t)conf->lapicaddr_p);
ffff800000105c38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c3c:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105c3f:	89 c2                	mov    %eax,%edx
ffff800000105c41:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105c48:	80 ff ff 
ffff800000105c4b:	48 01 d0             	add    %rdx,%rax
ffff800000105c4e:	48 89 c2             	mov    %rax,%rdx
ffff800000105c51:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000105c58:	80 ff ff 
ffff800000105c5b:	48 89 10             	mov    %rdx,(%rax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105c5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c62:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105c66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105c6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c6e:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105c72:	0f b7 d0             	movzwl %ax,%edx
ffff800000105c75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c79:	48 01 d0             	add    %rdx,%rax
ffff800000105c7c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105c80:	e9 f6 00 00 00       	jmp    ffff800000105d7b <mpinit+0x18c>
    switch(*p){
ffff800000105c85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105c89:	0f b6 00             	movzbl (%rax),%eax
ffff800000105c8c:	0f b6 c0             	movzbl %al,%eax
ffff800000105c8f:	83 f8 04             	cmp    $0x4,%eax
ffff800000105c92:	0f 8f ca 00 00 00    	jg     ffff800000105d62 <mpinit+0x173>
ffff800000105c98:	83 f8 03             	cmp    $0x3,%eax
ffff800000105c9b:	0f 8d ba 00 00 00    	jge    ffff800000105d5b <mpinit+0x16c>
ffff800000105ca1:	83 f8 02             	cmp    $0x2,%eax
ffff800000105ca4:	0f 84 8e 00 00 00    	je     ffff800000105d38 <mpinit+0x149>
ffff800000105caa:	83 f8 02             	cmp    $0x2,%eax
ffff800000105cad:	0f 8f af 00 00 00    	jg     ffff800000105d62 <mpinit+0x173>
ffff800000105cb3:	85 c0                	test   %eax,%eax
ffff800000105cb5:	74 0e                	je     ffff800000105cc5 <mpinit+0xd6>
ffff800000105cb7:	83 f8 01             	cmp    $0x1,%eax
ffff800000105cba:	0f 84 9b 00 00 00    	je     ffff800000105d5b <mpinit+0x16c>
ffff800000105cc0:	e9 9d 00 00 00       	jmp    ffff800000105d62 <mpinit+0x173>
    case MPPROC:
      proc = (struct mpproc*)p;
ffff800000105cc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cc9:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      if(ncpu < NCPU) {
ffff800000105ccd:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105cd4:	80 ff ff 
ffff800000105cd7:	8b 00                	mov    (%rax),%eax
ffff800000105cd9:	83 f8 07             	cmp    $0x7,%eax
ffff800000105cdc:	7f 53                	jg     ffff800000105d31 <mpinit+0x142>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
ffff800000105cde:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105ce5:	80 ff ff 
ffff800000105ce8:	8b 10                	mov    (%rax),%edx
ffff800000105cea:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105cee:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105cf2:	48 be e0 82 11 00 00 	movabs $0xffff8000001182e0,%rsi
ffff800000105cf9:	80 ff ff 
ffff800000105cfc:	48 63 d2             	movslq %edx,%rdx
ffff800000105cff:	48 89 d0             	mov    %rdx,%rax
ffff800000105d02:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105d06:	48 01 d0             	add    %rdx,%rax
ffff800000105d09:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105d0d:	48 01 f0             	add    %rsi,%rax
ffff800000105d10:	48 83 c0 01          	add    $0x1,%rax
ffff800000105d14:	88 08                	mov    %cl,(%rax)
        ncpu++;
ffff800000105d16:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105d1d:	80 ff ff 
ffff800000105d20:	8b 00                	mov    (%rax),%eax
ffff800000105d22:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105d25:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105d2c:	80 ff ff 
ffff800000105d2f:	89 10                	mov    %edx,(%rax)
      }
      p += sizeof(struct mpproc);
ffff800000105d31:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffff800000105d36:	eb 43                	jmp    ffff800000105d7b <mpinit+0x18c>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffff800000105d38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d3c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffff800000105d40:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d44:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105d48:	48 ba 24 84 11 00 00 	movabs $0xffff800000118424,%rdx
ffff800000105d4f:	80 ff ff 
ffff800000105d52:	88 02                	mov    %al,(%rdx)
      p += sizeof(struct mpioapic);
ffff800000105d54:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105d59:	eb 20                	jmp    ffff800000105d7b <mpinit+0x18c>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffff800000105d5b:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105d60:	eb 19                	jmp    ffff800000105d7b <mpinit+0x18c>
    default:
      panic("Major problem parsing mp config.");
ffff800000105d62:	48 b8 30 c7 10 00 00 	movabs $0xffff80000010c730,%rax
ffff800000105d69:	80 ff ff 
ffff800000105d6c:	48 89 c7             	mov    %rax,%rdi
ffff800000105d6f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105d76:	80 ff ff 
ffff800000105d79:	ff d0                	call   *%rax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105d7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d7f:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105d83:	0f 82 fc fe ff ff    	jb     ffff800000105c85 <mpinit+0x96>
      break;
    }
  }
  cprintf("Seems we are SMP, ncpu = %d\n",ncpu);
ffff800000105d89:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105d90:	80 ff ff 
ffff800000105d93:	8b 00                	mov    (%rax),%eax
ffff800000105d95:	48 ba 51 c7 10 00 00 	movabs $0xffff80000010c751,%rdx
ffff800000105d9c:	80 ff ff 
ffff800000105d9f:	89 c6                	mov    %eax,%esi
ffff800000105da1:	48 89 d7             	mov    %rdx,%rdi
ffff800000105da4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105da9:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105db0:	80 ff ff 
ffff800000105db3:	ff d2                	call   *%rdx
  if(mp->imcrp){
ffff800000105db5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105db9:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105dbd:	84 c0                	test   %al,%al
ffff800000105dbf:	74 40                	je     ffff800000105e01 <mpinit+0x212>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffff800000105dc1:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105dc6:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105dcb:	48 b8 30 59 10 00 00 	movabs $0xffff800000105930,%rax
ffff800000105dd2:	80 ff ff 
ffff800000105dd5:	ff d0                	call   *%rax
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffff800000105dd7:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105ddc:	48 b8 12 59 10 00 00 	movabs $0xffff800000105912,%rax
ffff800000105de3:	80 ff ff 
ffff800000105de6:	ff d0                	call   *%rax
ffff800000105de8:	83 c8 01             	or     $0x1,%eax
ffff800000105deb:	0f b6 c0             	movzbl %al,%eax
ffff800000105dee:	89 c6                	mov    %eax,%esi
ffff800000105df0:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105df5:	48 b8 30 59 10 00 00 	movabs $0xffff800000105930,%rax
ffff800000105dfc:	80 ff ff 
ffff800000105dff:	ff d0                	call   *%rax
  }
}
ffff800000105e01:	c9                   	leave
ffff800000105e02:	c3                   	ret

ffff800000105e03 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffff800000105e03:	55                   	push   %rbp
ffff800000105e04:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e07:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105e0b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105e0f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffff800000105e13:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105e1a:	00 
  *f0 = *f1 = 0;
ffff800000105e1b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e1f:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105e26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e2a:	48 8b 10             	mov    (%rax),%rdx
ffff800000105e2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105e31:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffff800000105e34:	48 b8 72 1c 10 00 00 	movabs $0xffff800000101c72,%rax
ffff800000105e3b:	80 ff ff 
ffff800000105e3e:	ff d0                	call   *%rax
ffff800000105e40:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105e44:	48 89 02             	mov    %rax,(%rdx)
ffff800000105e47:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105e4b:	48 8b 00             	mov    (%rax),%rax
ffff800000105e4e:	48 85 c0             	test   %rax,%rax
ffff800000105e51:	0f 84 01 01 00 00    	je     ffff800000105f58 <pipealloc+0x155>
ffff800000105e57:	48 b8 72 1c 10 00 00 	movabs $0xffff800000101c72,%rax
ffff800000105e5e:	80 ff ff 
ffff800000105e61:	ff d0                	call   *%rax
ffff800000105e63:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105e67:	48 89 02             	mov    %rax,(%rdx)
ffff800000105e6a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e6e:	48 8b 00             	mov    (%rax),%rax
ffff800000105e71:	48 85 c0             	test   %rax,%rax
ffff800000105e74:	0f 84 de 00 00 00    	je     ffff800000105f58 <pipealloc+0x155>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffff800000105e7a:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff800000105e81:	80 ff ff 
ffff800000105e84:	ff d0                	call   *%rax
ffff800000105e86:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105e8a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105e8f:	0f 84 c6 00 00 00    	je     ffff800000105f5b <pipealloc+0x158>
    goto bad;
  p->readopen = 1;
ffff800000105e95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e99:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105ea0:	00 00 00 
  p->writeopen = 1;
ffff800000105ea3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ea7:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105eae:	00 00 00 
  p->nwrite = 0;
ffff800000105eb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105eb5:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105ebc:	00 00 00 
  p->nread = 0;
ffff800000105ebf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ec3:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105eca:	00 00 00 
  initlock(&p->lock, "pipe");
ffff800000105ecd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ed1:	48 ba 6e c7 10 00 00 	movabs $0xffff80000010c76e,%rdx
ffff800000105ed8:	80 ff ff 
ffff800000105edb:	48 89 d6             	mov    %rdx,%rsi
ffff800000105ede:	48 89 c7             	mov    %rax,%rdi
ffff800000105ee1:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000105ee8:	80 ff ff 
ffff800000105eeb:	ff d0                	call   *%rax
  (*f0)->type = FD_PIPE;
ffff800000105eed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ef1:	48 8b 00             	mov    (%rax),%rax
ffff800000105ef4:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffff800000105efa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105efe:	48 8b 00             	mov    (%rax),%rax
ffff800000105f01:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffff800000105f05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f09:	48 8b 00             	mov    (%rax),%rax
ffff800000105f0c:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffff800000105f10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f14:	48 8b 00             	mov    (%rax),%rax
ffff800000105f17:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f1b:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffff800000105f1f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f23:	48 8b 00             	mov    (%rax),%rax
ffff800000105f26:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffff800000105f2c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f30:	48 8b 00             	mov    (%rax),%rax
ffff800000105f33:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffff800000105f37:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f3b:	48 8b 00             	mov    (%rax),%rax
ffff800000105f3e:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffff800000105f42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f46:	48 8b 00             	mov    (%rax),%rax
ffff800000105f49:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f4d:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffff800000105f51:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105f56:	eb 67                	jmp    ffff800000105fbf <pipealloc+0x1bc>
    goto bad;
ffff800000105f58:	90                   	nop
ffff800000105f59:	eb 01                	jmp    ffff800000105f5c <pipealloc+0x159>
    goto bad;
ffff800000105f5b:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffff800000105f5c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105f61:	74 13                	je     ffff800000105f76 <pipealloc+0x173>
    kfree((char*)p);
ffff800000105f63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f67:	48 89 c7             	mov    %rax,%rdi
ffff800000105f6a:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000105f71:	80 ff ff 
ffff800000105f74:	ff d0                	call   *%rax
  if(*f0)
ffff800000105f76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f7a:	48 8b 00             	mov    (%rax),%rax
ffff800000105f7d:	48 85 c0             	test   %rax,%rax
ffff800000105f80:	74 16                	je     ffff800000105f98 <pipealloc+0x195>
    fileclose(*f0);
ffff800000105f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f86:	48 8b 00             	mov    (%rax),%rax
ffff800000105f89:	48 89 c7             	mov    %rax,%rdi
ffff800000105f8c:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000105f93:	80 ff ff 
ffff800000105f96:	ff d0                	call   *%rax
  if(*f1)
ffff800000105f98:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f9c:	48 8b 00             	mov    (%rax),%rax
ffff800000105f9f:	48 85 c0             	test   %rax,%rax
ffff800000105fa2:	74 16                	je     ffff800000105fba <pipealloc+0x1b7>
    fileclose(*f1);
ffff800000105fa4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fa8:	48 8b 00             	mov    (%rax),%rax
ffff800000105fab:	48 89 c7             	mov    %rax,%rdi
ffff800000105fae:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000105fb5:	80 ff ff 
ffff800000105fb8:	ff d0                	call   *%rax
  return -1;
ffff800000105fba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000105fbf:	c9                   	leave
ffff800000105fc0:	c3                   	ret

ffff800000105fc1 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffff800000105fc1:	55                   	push   %rbp
ffff800000105fc2:	48 89 e5             	mov    %rsp,%rbp
ffff800000105fc5:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000105fc9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105fcd:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffff800000105fd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105fd4:	48 89 c7             	mov    %rax,%rdi
ffff800000105fd7:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000105fde:	80 ff ff 
ffff800000105fe1:	ff d0                	call   *%rax
  if(writable){
ffff800000105fe3:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105fe7:	74 29                	je     ffff800000106012 <pipeclose+0x51>
    p->writeopen = 0;
ffff800000105fe9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105fed:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000105ff4:	00 00 00 
    wakeup(&p->nread);
ffff800000105ff7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ffb:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106001:	48 89 c7             	mov    %rax,%rdi
ffff800000106004:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff80000010600b:	80 ff ff 
ffff80000010600e:	ff d0                	call   *%rax
ffff800000106010:	eb 27                	jmp    ffff800000106039 <pipeclose+0x78>
  } else {
    p->readopen = 0;
ffff800000106012:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106016:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff80000010601d:	00 00 00 
    wakeup(&p->nwrite);
ffff800000106020:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106024:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff80000010602a:	48 89 c7             	mov    %rax,%rdi
ffff80000010602d:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff800000106034:	80 ff ff 
ffff800000106037:	ff d0                	call   *%rax
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffff800000106039:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010603d:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000106043:	85 c0                	test   %eax,%eax
ffff800000106045:	75 36                	jne    ffff80000010607d <pipeclose+0xbc>
ffff800000106047:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010604b:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff800000106051:	85 c0                	test   %eax,%eax
ffff800000106053:	75 28                	jne    ffff80000010607d <pipeclose+0xbc>
    release(&p->lock);
ffff800000106055:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106059:	48 89 c7             	mov    %rax,%rdi
ffff80000010605c:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000106063:	80 ff ff 
ffff800000106066:	ff d0                	call   *%rax
    kfree((char*)p);
ffff800000106068:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010606c:	48 89 c7             	mov    %rax,%rdi
ffff80000010606f:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000106076:	80 ff ff 
ffff800000106079:	ff d0                	call   *%rax
ffff80000010607b:	eb 14                	jmp    ffff800000106091 <pipeclose+0xd0>
  } else
    release(&p->lock);
ffff80000010607d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106081:	48 89 c7             	mov    %rax,%rdi
ffff800000106084:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010608b:	80 ff ff 
ffff80000010608e:	ff d0                	call   *%rax
}
ffff800000106090:	90                   	nop
ffff800000106091:	90                   	nop
ffff800000106092:	c9                   	leave
ffff800000106093:	c3                   	ret

ffff800000106094 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffff800000106094:	55                   	push   %rbp
ffff800000106095:	48 89 e5             	mov    %rsp,%rbp
ffff800000106098:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010609c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001060a0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001060a4:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff8000001060a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001060ae:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001060b5:	80 ff ff 
ffff8000001060b8:	ff d0                	call   *%rax
  for(i = 0; i < n; i++){
ffff8000001060ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001060c1:	e9 d5 00 00 00       	jmp    ffff80000010619b <pipewrite+0x107>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffff8000001060c6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060ca:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff8000001060d0:	85 c0                	test   %eax,%eax
ffff8000001060d2:	74 12                	je     ffff8000001060e6 <pipewrite+0x52>
ffff8000001060d4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001060db:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001060df:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001060e2:	85 c0                	test   %eax,%eax
ffff8000001060e4:	74 1d                	je     ffff800000106103 <pipewrite+0x6f>
        release(&p->lock);
ffff8000001060e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001060ed:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001060f4:	80 ff ff 
ffff8000001060f7:	ff d0                	call   *%rax
        return -1;
ffff8000001060f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001060fe:	e9 cf 00 00 00       	jmp    ffff8000001061d2 <pipewrite+0x13e>
      }
      wakeup(&p->nread);
ffff800000106103:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106107:	48 05 68 02 00 00    	add    $0x268,%rax
ffff80000010610d:	48 89 c7             	mov    %rax,%rdi
ffff800000106110:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff800000106117:	80 ff ff 
ffff80000010611a:	ff d0                	call   *%rax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffff80000010611c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106120:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106124:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff80000010612b:	48 89 c6             	mov    %rax,%rsi
ffff80000010612e:	48 89 d7             	mov    %rdx,%rdi
ffff800000106131:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000106138:	80 ff ff 
ffff80000010613b:	ff d0                	call   *%rax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffff80000010613d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106141:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff800000106147:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010614b:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff800000106151:	05 00 02 00 00       	add    $0x200,%eax
ffff800000106156:	39 c2                	cmp    %eax,%edx
ffff800000106158:	0f 84 68 ff ff ff    	je     ffff8000001060c6 <pipewrite+0x32>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffff80000010615e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000106161:	48 63 d0             	movslq %eax,%rdx
ffff800000106164:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106168:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff80000010616c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106170:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000106176:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000106179:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010617d:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff800000106183:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000106188:	89 c1                	mov    %eax,%ecx
ffff80000010618a:	0f b6 16             	movzbl (%rsi),%edx
ffff80000010618d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106191:	89 c9                	mov    %ecx,%ecx
ffff800000106193:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffff800000106197:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010619b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010619e:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001061a1:	7c 9a                	jl     ffff80000010613d <pipewrite+0xa9>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffff8000001061a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061a7:	48 05 68 02 00 00    	add    $0x268,%rax
ffff8000001061ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001061b0:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff8000001061b7:	80 ff ff 
ffff8000001061ba:	ff d0                	call   *%rax
  release(&p->lock);
ffff8000001061bc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001061c3:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001061ca:	80 ff ff 
ffff8000001061cd:	ff d0                	call   *%rax
  return n;
ffff8000001061cf:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff8000001061d2:	c9                   	leave
ffff8000001061d3:	c3                   	ret

ffff8000001061d4 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffff8000001061d4:	55                   	push   %rbp
ffff8000001061d5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001061d8:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001061dc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001061e0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001061e4:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff8000001061e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061eb:	48 89 c7             	mov    %rax,%rdi
ffff8000001061ee:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001061f5:	80 ff ff 
ffff8000001061f8:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff8000001061fa:	eb 50                	jmp    ffff80000010624c <piperead+0x78>
    if(proc->killed){
ffff8000001061fc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106203:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106207:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010620a:	85 c0                	test   %eax,%eax
ffff80000010620c:	74 1d                	je     ffff80000010622b <piperead+0x57>
      release(&p->lock);
ffff80000010620e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106212:	48 89 c7             	mov    %rax,%rdi
ffff800000106215:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010621c:	80 ff ff 
ffff80000010621f:	ff d0                	call   *%rax
      return -1;
ffff800000106221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106226:	e9 de 00 00 00       	jmp    ffff800000106309 <piperead+0x135>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffff80000010622b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010622f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106233:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff80000010623a:	48 89 c6             	mov    %rax,%rsi
ffff80000010623d:	48 89 d7             	mov    %rdx,%rdi
ffff800000106240:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000106247:	80 ff ff 
ffff80000010624a:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff80000010624c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106250:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106256:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010625a:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000106260:	39 c2                	cmp    %eax,%edx
ffff800000106262:	75 0e                	jne    ffff800000106272 <piperead+0x9e>
ffff800000106264:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106268:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff80000010626e:	85 c0                	test   %eax,%eax
ffff800000106270:	75 8a                	jne    ffff8000001061fc <piperead+0x28>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff800000106272:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106279:	eb 54                	jmp    ffff8000001062cf <piperead+0xfb>
    if(p->nread == p->nwrite)
ffff80000010627b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010627f:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106285:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106289:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010628f:	39 c2                	cmp    %eax,%edx
ffff800000106291:	74 46                	je     ffff8000001062d9 <piperead+0x105>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffff800000106293:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106297:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff80000010629d:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001062a0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001062a4:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff8000001062aa:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001062af:	89 c1                	mov    %eax,%ecx
ffff8000001062b1:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001062b4:	48 63 d0             	movslq %eax,%rdx
ffff8000001062b7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001062bb:	48 01 c2             	add    %rax,%rdx
ffff8000001062be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062c2:	89 c9                	mov    %ecx,%ecx
ffff8000001062c4:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff8000001062c9:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff8000001062cb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001062cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001062d2:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001062d5:	7c a4                	jl     ffff80000010627b <piperead+0xa7>
ffff8000001062d7:	eb 01                	jmp    ffff8000001062da <piperead+0x106>
      break;
ffff8000001062d9:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffff8000001062da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062de:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff8000001062e4:	48 89 c7             	mov    %rax,%rdi
ffff8000001062e7:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff8000001062ee:	80 ff ff 
ffff8000001062f1:	ff d0                	call   *%rax
  release(&p->lock);
ffff8000001062f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062f7:	48 89 c7             	mov    %rax,%rdi
ffff8000001062fa:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000106301:	80 ff ff 
ffff800000106304:	ff d0                	call   *%rax
  return i;
ffff800000106306:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000106309:	c9                   	leave
ffff80000010630a:	c3                   	ret

ffff80000010630b <readeflags>:
{
ffff80000010630b:	55                   	push   %rbp
ffff80000010630c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010630f:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff800000106313:	9c                   	pushf
ffff800000106314:	58                   	pop    %rax
ffff800000106315:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff800000106319:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010631d:	c9                   	leave
ffff80000010631e:	c3                   	ret

ffff80000010631f <sti>:
{
ffff80000010631f:	55                   	push   %rbp
ffff800000106320:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff800000106323:	fb                   	sti
}
ffff800000106324:	90                   	nop
ffff800000106325:	5d                   	pop    %rbp
ffff800000106326:	c3                   	ret

ffff800000106327 <hlt>:
{
ffff800000106327:	55                   	push   %rbp
ffff800000106328:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff80000010632b:	f4                   	hlt
}
ffff80000010632c:	90                   	nop
ffff80000010632d:	5d                   	pop    %rbp
ffff80000010632e:	c3                   	ret

ffff80000010632f <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffff80000010632f:	55                   	push   %rbp
ffff800000106330:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff800000106333:	48 ba 73 c7 10 00 00 	movabs $0xffff80000010c773,%rdx
ffff80000010633a:	80 ff ff 
ffff80000010633d:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106344:	80 ff ff 
ffff800000106347:	48 89 d6             	mov    %rdx,%rsi
ffff80000010634a:	48 89 c7             	mov    %rax,%rdi
ffff80000010634d:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff800000106354:	80 ff ff 
ffff800000106357:	ff d0                	call   *%rax
}
ffff800000106359:	90                   	nop
ffff80000010635a:	5d                   	pop    %rbp
ffff80000010635b:	c3                   	ret

ffff80000010635c <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffff80000010635c:	55                   	push   %rbp
ffff80000010635d:	48 89 e5             	mov    %rsp,%rbp
ffff800000106360:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffff800000106364:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff80000010636b:	80 ff ff 
ffff80000010636e:	48 89 c7             	mov    %rax,%rdi
ffff800000106371:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000106378:	80 ff ff 
ffff80000010637b:	ff d0                	call   *%rax

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff80000010637d:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106384:	80 ff ff 
ffff800000106387:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010638b:	eb 13                	jmp    ffff8000001063a0 <allocproc+0x44>
    if(p->state == UNUSED)
ffff80000010638d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106391:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106394:	85 c0                	test   %eax,%eax
ffff800000106396:	74 3b                	je     ffff8000001063d3 <allocproc+0x77>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106398:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff80000010639f:	00 
ffff8000001063a0:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff8000001063a7:	80 ff ff 
ffff8000001063aa:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001063ae:	72 dd                	jb     ffff80000010638d <allocproc+0x31>
      goto found;

  release(&ptable.lock);
ffff8000001063b0:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001063b7:	80 ff ff 
ffff8000001063ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001063bd:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001063c4:	80 ff ff 
ffff8000001063c7:	ff d0                	call   *%rax
  return 0;
ffff8000001063c9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001063ce:	e9 05 01 00 00       	jmp    ffff8000001064d8 <allocproc+0x17c>
      goto found;
ffff8000001063d3:	90                   	nop

found:
  p->state = EMBRYO;
ffff8000001063d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063d8:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff8000001063df:	48 b8 40 d5 10 00 00 	movabs $0xffff80000010d540,%rax
ffff8000001063e6:	80 ff ff 
ffff8000001063e9:	8b 00                	mov    (%rax),%eax
ffff8000001063eb:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001063ee:	48 b9 40 d5 10 00 00 	movabs $0xffff80000010d540,%rcx
ffff8000001063f5:	80 ff ff 
ffff8000001063f8:	89 11                	mov    %edx,(%rcx)
ffff8000001063fa:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001063fe:	89 42 1c             	mov    %eax,0x1c(%rdx)

  release(&ptable.lock);
ffff800000106401:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106408:	80 ff ff 
ffff80000010640b:	48 89 c7             	mov    %rax,%rdi
ffff80000010640e:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000106415:	80 ff ff 
ffff800000106418:	ff d0                	call   *%rax

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffff80000010641a:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff800000106421:	80 ff ff 
ffff800000106424:	ff d0                	call   *%rax
ffff800000106426:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010642a:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff80000010642e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106432:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106436:	48 85 c0             	test   %rax,%rax
ffff800000106439:	75 15                	jne    ffff800000106450 <allocproc+0xf4>
    p->state = UNUSED;
ffff80000010643b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010643f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff800000106446:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010644b:	e9 88 00 00 00       	jmp    ffff8000001064d8 <allocproc+0x17c>
  }
  sp = p->kstack + KSTACKSIZE;
ffff800000106450:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106454:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106458:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010645e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffff800000106462:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff800000106469:	00 
  p->tf = (struct trapframe*)sp;
ffff80000010646a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010646e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106472:	48 89 50 28          	mov    %rdx,0x28(%rax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(addr_t);
ffff800000106476:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff80000010647b:	48 ba 28 99 10 00 00 	movabs $0xffff800000109928,%rdx
ffff800000106482:	80 ff ff 
ffff800000106485:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106489:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffff80000010648c:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff800000106491:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106495:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106499:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff80000010649d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064a1:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001064a5:	ba 38 00 00 00       	mov    $0x38,%edx
ffff8000001064aa:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001064af:	48 89 c7             	mov    %rax,%rdi
ffff8000001064b2:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff8000001064b9:	80 ff ff 
ffff8000001064bc:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff8000001064be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064c2:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001064c6:	48 ba 5e 70 10 00 00 	movabs $0xffff80000010705e,%rdx
ffff8000001064cd:	80 ff ff 
ffff8000001064d0:	48 89 50 30          	mov    %rdx,0x30(%rax)

  return p;
ffff8000001064d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001064d8:	c9                   	leave
ffff8000001064d9:	c3                   	ret

ffff8000001064da <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffff8000001064da:	55                   	push   %rbp
ffff8000001064db:	48 89 e5             	mov    %rsp,%rbp
ffff8000001064de:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  p = allocproc();
ffff8000001064e2:	48 b8 5c 63 10 00 00 	movabs $0xffff80000010635c,%rax
ffff8000001064e9:	80 ff ff 
ffff8000001064ec:	ff d0                	call   *%rax
ffff8000001064ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  initproc = p;
ffff8000001064f2:	48 ba a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rdx
ffff8000001064f9:	80 ff ff 
ffff8000001064fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106500:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff800000106503:	48 b8 e2 b1 10 00 00 	movabs $0xffff80000010b1e2,%rax
ffff80000010650a:	80 ff ff 
ffff80000010650d:	ff d0                	call   *%rax
ffff80000010650f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106513:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106517:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010651b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010651f:	48 85 c0             	test   %rax,%rax
ffff800000106522:	75 19                	jne    ffff80000010653d <userinit+0x63>
    panic("userinit: out of memory?");
ffff800000106524:	48 b8 7a c7 10 00 00 	movabs $0xffff80000010c77a,%rax
ffff80000010652b:	80 ff ff 
ffff80000010652e:	48 89 c7             	mov    %rax,%rdi
ffff800000106531:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106538:	80 ff ff 
ffff80000010653b:	ff d0                	call   *%rax

  inituvm(p->pgdir, _binary_initcode_start,
ffff80000010653d:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff800000106544:	00 00 00 
ffff800000106547:	89 c2                	mov    %eax,%edx
ffff800000106549:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010654d:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106551:	48 b9 50 df 10 00 00 	movabs $0xffff80000010df50,%rcx
ffff800000106558:	80 ff ff 
ffff80000010655b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010655e:	48 89 c7             	mov    %rax,%rdi
ffff800000106561:	48 b8 58 b7 10 00 00 	movabs $0xffff80000010b758,%rax
ffff800000106568:	80 ff ff 
ffff80000010656b:	ff d0                	call   *%rax
          (addr_t)_binary_initcode_size);
  p->sz = PGSIZE * 2;
ffff80000010656d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106571:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff800000106578:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010657c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106580:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff800000106585:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010658a:	48 89 c7             	mov    %rax,%rdi
ffff80000010658d:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff800000106594:	80 ff ff 
ffff800000106597:	ff d0                	call   *%rax

  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff800000106599:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010659d:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065a1:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff8000001065a8:	00 
  p->tf->rsp = p->sz;
ffff8000001065a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065ad:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065b1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001065b5:	48 8b 12             	mov    (%rdx),%rdx
ffff8000001065b8:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff8000001065bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065c3:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065c7:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff8000001065ce:	00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001065cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065d3:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff8000001065d9:	48 b9 93 c7 10 00 00 	movabs $0xffff80000010c793,%rcx
ffff8000001065e0:	80 ff ff 
ffff8000001065e3:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001065e8:	48 89 ce             	mov    %rcx,%rsi
ffff8000001065eb:	48 89 c7             	mov    %rax,%rdi
ffff8000001065ee:	48 b8 0e 7d 10 00 00 	movabs $0xffff800000107d0e,%rax
ffff8000001065f5:	80 ff ff 
ffff8000001065f8:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff8000001065fa:	48 b8 9c c7 10 00 00 	movabs $0xffff80000010c79c,%rax
ffff800000106601:	80 ff ff 
ffff800000106604:	48 89 c7             	mov    %rax,%rdi
ffff800000106607:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff80000010660e:	80 ff ff 
ffff800000106611:	ff d0                	call   *%rax
ffff800000106613:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106617:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  __sync_synchronize();
ffff80000010661e:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff800000106624:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106628:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff80000010662f:	90                   	nop
ffff800000106630:	c9                   	leave
ffff800000106631:	c3                   	ret

ffff800000106632 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int64 n)
{
ffff800000106632:	55                   	push   %rbp
ffff800000106633:	48 89 e5             	mov    %rsp,%rbp
ffff800000106636:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010663a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  addr_t sz;

  sz = proc->sz;
ffff80000010663e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106645:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106649:	48 8b 00             	mov    (%rax),%rax
ffff80000010664c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff800000106650:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106655:	7e 42                	jle    ffff800000106699 <growproc+0x67>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106657:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010665b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010665f:	48 01 c2             	add    %rax,%rdx
ffff800000106662:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106669:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010666d:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106671:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000106675:	48 89 ce             	mov    %rcx,%rsi
ffff800000106678:	48 89 c7             	mov    %rax,%rdi
ffff80000010667b:	48 b8 39 b9 10 00 00 	movabs $0xffff80000010b939,%rax
ffff800000106682:	80 ff ff 
ffff800000106685:	ff d0                	call   *%rax
ffff800000106687:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010668b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000106690:	75 50                	jne    ffff8000001066e2 <growproc+0xb0>
      return -1;
ffff800000106692:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106697:	eb 7a                	jmp    ffff800000106713 <growproc+0xe1>
  } else if(n < 0){
ffff800000106699:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010669e:	79 42                	jns    ffff8000001066e2 <growproc+0xb0>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff8000001066a0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001066a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001066a8:	48 01 c2             	add    %rax,%rdx
ffff8000001066ab:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066b2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066b6:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001066ba:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001066be:	48 89 ce             	mov    %rcx,%rsi
ffff8000001066c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001066c4:	48 b8 7d ba 10 00 00 	movabs $0xffff80000010ba7d,%rax
ffff8000001066cb:	80 ff ff 
ffff8000001066ce:	ff d0                	call   *%rax
ffff8000001066d0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001066d4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001066d9:	75 07                	jne    ffff8000001066e2 <growproc+0xb0>
      return -1;
ffff8000001066db:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001066e0:	eb 31                	jmp    ffff800000106713 <growproc+0xe1>
  }
  proc->sz = sz;
ffff8000001066e2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066e9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001066f1:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff8000001066f4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066fb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066ff:	48 89 c7             	mov    %rax,%rdi
ffff800000106702:	48 b8 40 b3 10 00 00 	movabs $0xffff80000010b340,%rax
ffff800000106709:	80 ff ff 
ffff80000010670c:	ff d0                	call   *%rax
  return 0;
ffff80000010670e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000106713:	c9                   	leave
ffff800000106714:	c3                   	ret

ffff800000106715 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff800000106715:	55                   	push   %rbp
ffff800000106716:	48 89 e5             	mov    %rsp,%rbp
ffff800000106719:	53                   	push   %rbx
ffff80000010671a:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff80000010671e:	48 b8 5c 63 10 00 00 	movabs $0xffff80000010635c,%rax
ffff800000106725:	80 ff ff 
ffff800000106728:	ff d0                	call   *%rax
ffff80000010672a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010672e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000106733:	75 0a                	jne    ffff80000010673f <fork+0x2a>
    return -1;
ffff800000106735:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010673a:	e9 be 02 00 00       	jmp    ffff8000001069fd <fork+0x2e8>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff80000010673f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106746:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010674a:	48 8b 00             	mov    (%rax),%rax
ffff80000010674d:	89 c2                	mov    %eax,%edx
ffff80000010674f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106756:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010675a:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010675e:	89 d6                	mov    %edx,%esi
ffff800000106760:	48 89 c7             	mov    %rax,%rdi
ffff800000106763:	48 b8 18 be 10 00 00 	movabs $0xffff80000010be18,%rax
ffff80000010676a:	80 ff ff 
ffff80000010676d:	ff d0                	call   *%rax
ffff80000010676f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106773:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106777:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010677b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010677f:	48 85 c0             	test   %rax,%rax
ffff800000106782:	75 38                	jne    ffff8000001067bc <fork+0xa7>
    kfree(np->kstack);
ffff800000106784:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106788:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010678c:	48 89 c7             	mov    %rax,%rdi
ffff80000010678f:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000106796:	80 ff ff 
ffff800000106799:	ff d0                	call   *%rax
    np->kstack = 0;
ffff80000010679b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010679f:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001067a6:	00 
    np->state = UNUSED;
ffff8000001067a7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067ab:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff8000001067b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001067b7:	e9 41 02 00 00       	jmp    ffff8000001069fd <fork+0x2e8>
  }
  np->sz = proc->sz;
ffff8000001067bc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067c3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067c7:	48 8b 10             	mov    (%rax),%rdx
ffff8000001067ca:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067ce:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff8000001067d1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067d8:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001067dc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067e0:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff8000001067e4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067eb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067ef:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff8000001067f3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067f7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001067fb:	48 8b 0a             	mov    (%rdx),%rcx
ffff8000001067fe:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff800000106802:	48 89 08             	mov    %rcx,(%rax)
ffff800000106805:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff800000106809:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff80000010680d:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff800000106811:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff800000106815:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff800000106819:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff80000010681d:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff800000106821:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff800000106825:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff800000106829:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff80000010682d:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff800000106831:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff800000106835:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff800000106839:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff80000010683d:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff800000106841:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff800000106845:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff800000106849:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff80000010684d:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff800000106851:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff800000106855:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff800000106859:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff80000010685d:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff800000106861:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff800000106865:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff800000106869:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff80000010686d:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff800000106871:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff800000106875:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff800000106879:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff800000106880:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff800000106887:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff80000010688e:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff800000106895:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff80000010689c:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff8000001068a3:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff8000001068aa:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff8000001068b1:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff8000001068b8:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff8000001068bf:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff8000001068c6:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff8000001068cd:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001068d1:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001068d5:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff8000001068dc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff8000001068e3:	eb 5f                	jmp    ffff800000106944 <fork+0x22f>
    if(proc->ofile[i])
ffff8000001068e5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068ec:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068f0:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001068f3:	48 63 d2             	movslq %edx,%rdx
ffff8000001068f6:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001068fa:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001068ff:	48 85 c0             	test   %rax,%rax
ffff800000106902:	74 3c                	je     ffff800000106940 <fork+0x22b>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff800000106904:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010690b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010690f:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000106912:	48 63 d2             	movslq %edx,%rdx
ffff800000106915:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106919:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010691e:	48 89 c7             	mov    %rax,%rdi
ffff800000106921:	48 b8 0d 1d 10 00 00 	movabs $0xffff800000101d0d,%rax
ffff800000106928:	80 ff ff 
ffff80000010692b:	ff d0                	call   *%rax
ffff80000010692d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000106931:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff800000106934:	48 63 c9             	movslq %ecx,%rcx
ffff800000106937:	48 83 c1 08          	add    $0x8,%rcx
ffff80000010693b:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff800000106940:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000106944:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff800000106948:	7e 9b                	jle    ffff8000001068e5 <fork+0x1d0>
  np->cwd = idup(proc->cwd);
ffff80000010694a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106951:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106955:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010695c:	48 89 c7             	mov    %rax,%rdi
ffff80000010695f:	48 b8 5f 29 10 00 00 	movabs $0xffff80000010295f,%rax
ffff800000106966:	80 ff ff 
ffff800000106969:	ff d0                	call   *%rax
ffff80000010696b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010696f:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff800000106976:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010697d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106981:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000106988:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010698c:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff800000106992:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000106997:	48 89 ce             	mov    %rcx,%rsi
ffff80000010699a:	48 89 c7             	mov    %rax,%rdi
ffff80000010699d:	48 b8 0e 7d 10 00 00 	movabs $0xffff800000107d0e,%rax
ffff8000001069a4:	80 ff ff 
ffff8000001069a7:	ff d0                	call   *%rax

  pid = np->pid;
ffff8000001069a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069ad:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001069b0:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff8000001069b3:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff8000001069b9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069bd:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  // Trace the event
  traceevent(TRACE_TYPE_PROC, pid, proc->pid, 0, "fork");
ffff8000001069c4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069cb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069cf:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff8000001069d2:	48 b9 9e c7 10 00 00 	movabs $0xffff80000010c79e,%rcx
ffff8000001069d9:	80 ff ff 
ffff8000001069dc:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001069df:	49 89 c8             	mov    %rcx,%r8
ffff8000001069e2:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff8000001069e7:	89 c6                	mov    %eax,%esi
ffff8000001069e9:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001069ee:	48 b8 66 c1 10 00 00 	movabs $0xffff80000010c166,%rax
ffff8000001069f5:	80 ff ff 
ffff8000001069f8:	ff d0                	call   *%rax

  return pid;
ffff8000001069fa:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff8000001069fd:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000106a01:	c9                   	leave
ffff800000106a02:	c3                   	ret

ffff800000106a03 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff800000106a03:	55                   	push   %rbp
ffff800000106a04:	48 89 e5             	mov    %rsp,%rbp
ffff800000106a07:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffff800000106a0b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a12:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000106a16:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106a1d:	80 ff ff 
ffff800000106a20:	48 8b 00             	mov    (%rax),%rax
ffff800000106a23:	48 39 c2             	cmp    %rax,%rdx
ffff800000106a26:	75 19                	jne    ffff800000106a41 <exit+0x3e>
    panic("init exiting");
ffff800000106a28:	48 b8 a3 c7 10 00 00 	movabs $0xffff80000010c7a3,%rax
ffff800000106a2f:	80 ff ff 
ffff800000106a32:	48 89 c7             	mov    %rax,%rdi
ffff800000106a35:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106a3c:	80 ff ff 
ffff800000106a3f:	ff d0                	call   *%rax

  traceevent(TRACE_TYPE_PROC, proc->pid, 0, 0, "exit");
ffff800000106a41:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a48:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a4c:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106a4f:	48 ba b0 c7 10 00 00 	movabs $0xffff80000010c7b0,%rdx
ffff800000106a56:	80 ff ff 
ffff800000106a59:	49 89 d0             	mov    %rdx,%r8
ffff800000106a5c:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000106a61:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000106a66:	89 c6                	mov    %eax,%esi
ffff800000106a68:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000106a6d:	48 b8 66 c1 10 00 00 	movabs $0xffff80000010c166,%rax
ffff800000106a74:	80 ff ff 
ffff800000106a77:	ff d0                	call   *%rax

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106a79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff800000106a80:	eb 6a                	jmp    ffff800000106aec <exit+0xe9>
    if(proc->ofile[fd]){
ffff800000106a82:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a89:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a8d:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106a90:	48 63 d2             	movslq %edx,%rdx
ffff800000106a93:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106a97:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106a9c:	48 85 c0             	test   %rax,%rax
ffff800000106a9f:	74 47                	je     ffff800000106ae8 <exit+0xe5>
      fileclose(proc->ofile[fd]);
ffff800000106aa1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106aa8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106aac:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106aaf:	48 63 d2             	movslq %edx,%rdx
ffff800000106ab2:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106ab6:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106abb:	48 89 c7             	mov    %rax,%rdi
ffff800000106abe:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000106ac5:	80 ff ff 
ffff800000106ac8:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff800000106aca:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ad1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ad5:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106ad8:	48 63 d2             	movslq %edx,%rdx
ffff800000106adb:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106adf:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106ae6:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106ae8:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff800000106aec:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff800000106af0:	7e 90                	jle    ffff800000106a82 <exit+0x7f>
    }
  }

  begin_op();
ffff800000106af2:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff800000106af9:	80 ff ff 
ffff800000106afc:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff800000106afe:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b05:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b09:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106b10:	48 89 c7             	mov    %rax,%rdi
ffff800000106b13:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000106b1a:	80 ff ff 
ffff800000106b1d:	ff d0                	call   *%rax
  end_op();
ffff800000106b1f:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000106b26:	80 ff ff 
ffff800000106b29:	ff d0                	call   *%rax
  proc->cwd = 0;
ffff800000106b2b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b32:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b36:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff800000106b3d:	00 00 00 00 

  acquire(&ptable.lock);
ffff800000106b41:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106b48:	80 ff ff 
ffff800000106b4b:	48 89 c7             	mov    %rax,%rdi
ffff800000106b4e:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000106b55:	80 ff ff 
ffff800000106b58:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff800000106b5a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b61:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b65:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000106b69:	48 89 c7             	mov    %rax,%rdi
ffff800000106b6c:	48 b8 d8 71 10 00 00 	movabs $0xffff8000001071d8,%rax
ffff800000106b73:	80 ff ff 
ffff800000106b76:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106b78:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106b7f:	80 ff ff 
ffff800000106b82:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106b86:	eb 5d                	jmp    ffff800000106be5 <exit+0x1e2>
    if(p->parent == proc){
ffff800000106b88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106b8c:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106b90:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b97:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b9b:	48 39 c2             	cmp    %rax,%rdx
ffff800000106b9e:	75 3d                	jne    ffff800000106bdd <exit+0x1da>
      p->parent = initproc;
ffff800000106ba0:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106ba7:	80 ff ff 
ffff800000106baa:	48 8b 10             	mov    (%rax),%rdx
ffff800000106bad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106bb1:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106bb5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106bb9:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106bbc:	83 f8 05             	cmp    $0x5,%eax
ffff800000106bbf:	75 1c                	jne    ffff800000106bdd <exit+0x1da>
        wakeup1(initproc);
ffff800000106bc1:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106bc8:	80 ff ff 
ffff800000106bcb:	48 8b 00             	mov    (%rax),%rax
ffff800000106bce:	48 89 c7             	mov    %rax,%rdi
ffff800000106bd1:	48 b8 d8 71 10 00 00 	movabs $0xffff8000001071d8,%rax
ffff800000106bd8:	80 ff ff 
ffff800000106bdb:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106bdd:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106be4:	00 
ffff800000106be5:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106bec:	80 ff ff 
ffff800000106bef:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106bf3:	72 93                	jb     ffff800000106b88 <exit+0x185>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106bf5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bfc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c00:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff800000106c07:	48 b8 ed 6e 10 00 00 	movabs $0xffff800000106eed,%rax
ffff800000106c0e:	80 ff ff 
ffff800000106c11:	ff d0                	call   *%rax
  panic("zombie exit");
ffff800000106c13:	48 b8 b5 c7 10 00 00 	movabs $0xffff80000010c7b5,%rax
ffff800000106c1a:	80 ff ff 
ffff800000106c1d:	48 89 c7             	mov    %rax,%rdi
ffff800000106c20:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106c27:	80 ff ff 
ffff800000106c2a:	ff d0                	call   *%rax

ffff800000106c2c <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff800000106c2c:	55                   	push   %rbp
ffff800000106c2d:	48 89 e5             	mov    %rsp,%rbp
ffff800000106c30:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff800000106c34:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106c3b:	80 ff ff 
ffff800000106c3e:	48 89 c7             	mov    %rax,%rdi
ffff800000106c41:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000106c48:	80 ff ff 
ffff800000106c4b:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff800000106c4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106c54:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106c5b:	80 ff ff 
ffff800000106c5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106c62:	e9 d9 00 00 00       	jmp    ffff800000106d40 <wait+0x114>
      if(p->parent != proc)
ffff800000106c67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c6b:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106c6f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c76:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c7a:	48 39 c2             	cmp    %rax,%rdx
ffff800000106c7d:	0f 85 b4 00 00 00    	jne    ffff800000106d37 <wait+0x10b>
        continue;
      havekids = 1;
ffff800000106c83:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106c8a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c8e:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106c91:	83 f8 05             	cmp    $0x5,%eax
ffff800000106c94:	0f 85 9e 00 00 00    	jne    ffff800000106d38 <wait+0x10c>
        // Found one.
        pid = p->pid;
ffff800000106c9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c9e:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106ca1:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ca8:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106cac:	48 89 c7             	mov    %rax,%rdi
ffff800000106caf:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000106cb6:	80 ff ff 
ffff800000106cb9:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106cbb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cbf:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106cc6:	00 
        freevm(p->pgdir);
ffff800000106cc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ccb:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106ccf:	48 89 c7             	mov    %rax,%rdi
ffff800000106cd2:	48 b8 76 bb 10 00 00 	movabs $0xffff80000010bb76,%rax
ffff800000106cd9:	80 ff ff 
ffff800000106cdc:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ce2:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106ce9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ced:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106cf4:	00 
        p->name[0] = 0;
ffff800000106cf5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cf9:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106d00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d04:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        p->state = UNUSED;
ffff800000106d0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d0f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106d16:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106d1d:	80 ff ff 
ffff800000106d20:	48 89 c7             	mov    %rax,%rdi
ffff800000106d23:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000106d2a:	80 ff ff 
ffff800000106d2d:	ff d0                	call   *%rax
        return pid;
ffff800000106d2f:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106d32:	e9 81 00 00 00       	jmp    ffff800000106db8 <wait+0x18c>
        continue;
ffff800000106d37:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106d38:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106d3f:	00 
ffff800000106d40:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106d47:	80 ff ff 
ffff800000106d4a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106d4e:	0f 82 13 ff ff ff    	jb     ffff800000106c67 <wait+0x3b>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106d54:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106d58:	74 12                	je     ffff800000106d6c <wait+0x140>
ffff800000106d5a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d61:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d65:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106d68:	85 c0                	test   %eax,%eax
ffff800000106d6a:	74 20                	je     ffff800000106d8c <wait+0x160>
      release(&ptable.lock);
ffff800000106d6c:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106d73:	80 ff ff 
ffff800000106d76:	48 89 c7             	mov    %rax,%rdi
ffff800000106d79:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000106d80:	80 ff ff 
ffff800000106d83:	ff d0                	call   *%rax
      return -1;
ffff800000106d85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106d8a:	eb 2c                	jmp    ffff800000106db8 <wait+0x18c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106d8c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d93:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d97:	48 ba 40 84 11 00 00 	movabs $0xffff800000118440,%rdx
ffff800000106d9e:	80 ff ff 
ffff800000106da1:	48 89 d6             	mov    %rdx,%rsi
ffff800000106da4:	48 89 c7             	mov    %rax,%rdi
ffff800000106da7:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff800000106dae:	80 ff ff 
ffff800000106db1:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106db3:	e9 95 fe ff ff       	jmp    ffff800000106c4d <wait+0x21>
  }
}
ffff800000106db8:	c9                   	leave
ffff800000106db9:	c3                   	ret

ffff800000106dba <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106dba:	55                   	push   %rbp
ffff800000106dbb:	48 89 e5             	mov    %rsp,%rbp
ffff800000106dbe:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106dc2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106dc9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106dd0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106dd4:	48 b8 1f 63 10 00 00 	movabs $0xffff80000010631f,%rax
ffff800000106ddb:	80 ff ff 
ffff800000106dde:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106de0:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106de7:	80 ff ff 
ffff800000106dea:	48 89 c7             	mov    %rax,%rdi
ffff800000106ded:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000106df4:	80 ff ff 
ffff800000106df7:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106df9:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106e00:	80 ff ff 
ffff800000106e03:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106e07:	e9 92 00 00 00       	jmp    ffff800000106e9e <scheduler+0xe4>
      if(p->state != RUNNABLE) {
ffff800000106e0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e10:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106e13:	83 f8 03             	cmp    $0x3,%eax
ffff800000106e16:	74 06                	je     ffff800000106e1e <scheduler+0x64>
        skipped++;
ffff800000106e18:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106e1c:	eb 78                	jmp    ffff800000106e96 <scheduler+0xdc>
      }
      skipped = 0;
ffff800000106e1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106e25:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e2c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106e30:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106e34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e38:	48 89 c7             	mov    %rax,%rdi
ffff800000106e3b:	48 b8 40 b3 10 00 00 	movabs $0xffff80000010b340,%rax
ffff800000106e42:	80 ff ff 
ffff800000106e45:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000106e47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e4b:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000106e52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e56:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106e5a:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000106e61:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106e65:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106e69:	48 89 c6             	mov    %rax,%rsi
ffff800000106e6c:	48 89 d7             	mov    %rdx,%rdi
ffff800000106e6f:	48 b8 a3 7d 10 00 00 	movabs $0xffff800000107da3,%rax
ffff800000106e76:	80 ff ff 
ffff800000106e79:	ff d0                	call   *%rax
      switchkvm();
ffff800000106e7b:	48 b8 4c b6 10 00 00 	movabs $0xffff80000010b64c,%rax
ffff800000106e82:	80 ff ff 
ffff800000106e85:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000106e87:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e8e:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000106e95:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106e96:	48 81 45 f0 e0 00 00 	addq   $0xe0,-0x10(%rbp)
ffff800000106e9d:	00 
ffff800000106e9e:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106ea5:	80 ff ff 
ffff800000106ea8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106eac:	0f 82 5a ff ff ff    	jb     ffff800000106e0c <scheduler+0x52>
    }
    release(&ptable.lock);
ffff800000106eb2:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106eb9:	80 ff ff 
ffff800000106ebc:	48 89 c7             	mov    %rax,%rdi
ffff800000106ebf:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000106ec6:	80 ff ff 
ffff800000106ec9:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000106ecb:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff800000106ecf:	0f 8e fb fe ff ff    	jle    ffff800000106dd0 <scheduler+0x16>
      hlt();
ffff800000106ed5:	48 b8 27 63 10 00 00 	movabs $0xffff800000106327,%rax
ffff800000106edc:	80 ff ff 
ffff800000106edf:	ff d0                	call   *%rax
      skipped = 0;
ffff800000106ee1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff800000106ee8:	e9 e3 fe ff ff       	jmp    ffff800000106dd0 <scheduler+0x16>

ffff800000106eed <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff800000106eed:	55                   	push   %rbp
ffff800000106eee:	48 89 e5             	mov    %rsp,%rbp
ffff800000106ef1:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff800000106ef5:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106efc:	80 ff ff 
ffff800000106eff:	48 89 c7             	mov    %rax,%rdi
ffff800000106f02:	48 b8 a6 78 10 00 00 	movabs $0xffff8000001078a6,%rax
ffff800000106f09:	80 ff ff 
ffff800000106f0c:	ff d0                	call   *%rax
ffff800000106f0e:	85 c0                	test   %eax,%eax
ffff800000106f10:	75 19                	jne    ffff800000106f2b <sched+0x3e>
    panic("sched ptable.lock");
ffff800000106f12:	48 b8 c1 c7 10 00 00 	movabs $0xffff80000010c7c1,%rax
ffff800000106f19:	80 ff ff 
ffff800000106f1c:	48 89 c7             	mov    %rax,%rdi
ffff800000106f1f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f26:	80 ff ff 
ffff800000106f29:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff800000106f2b:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106f32:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f36:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000106f39:	83 f8 01             	cmp    $0x1,%eax
ffff800000106f3c:	74 19                	je     ffff800000106f57 <sched+0x6a>
    panic("sched locks");
ffff800000106f3e:	48 b8 d3 c7 10 00 00 	movabs $0xffff80000010c7d3,%rax
ffff800000106f45:	80 ff ff 
ffff800000106f48:	48 89 c7             	mov    %rax,%rdi
ffff800000106f4b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f52:	80 ff ff 
ffff800000106f55:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000106f57:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f5e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f62:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f65:	83 f8 04             	cmp    $0x4,%eax
ffff800000106f68:	75 19                	jne    ffff800000106f83 <sched+0x96>
    panic("sched running");
ffff800000106f6a:	48 b8 df c7 10 00 00 	movabs $0xffff80000010c7df,%rax
ffff800000106f71:	80 ff ff 
ffff800000106f74:	48 89 c7             	mov    %rax,%rdi
ffff800000106f77:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f7e:	80 ff ff 
ffff800000106f81:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000106f83:	48 b8 0b 63 10 00 00 	movabs $0xffff80000010630b,%rax
ffff800000106f8a:	80 ff ff 
ffff800000106f8d:	ff d0                	call   *%rax
ffff800000106f8f:	25 00 02 00 00       	and    $0x200,%eax
ffff800000106f94:	48 85 c0             	test   %rax,%rax
ffff800000106f97:	74 19                	je     ffff800000106fb2 <sched+0xc5>
    panic("sched interruptible");
ffff800000106f99:	48 b8 ed c7 10 00 00 	movabs $0xffff80000010c7ed,%rax
ffff800000106fa0:	80 ff ff 
ffff800000106fa3:	48 89 c7             	mov    %rax,%rdi
ffff800000106fa6:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106fad:	80 ff ff 
ffff800000106fb0:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000106fb2:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fb9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fbd:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106fc0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000106fc3:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fca:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fce:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106fd2:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff800000106fd9:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106fdd:	48 83 c2 30          	add    $0x30,%rdx
ffff800000106fe1:	48 89 c6             	mov    %rax,%rsi
ffff800000106fe4:	48 89 d7             	mov    %rdx,%rdi
ffff800000106fe7:	48 b8 a3 7d 10 00 00 	movabs $0xffff800000107da3,%rax
ffff800000106fee:	80 ff ff 
ffff800000106ff1:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff800000106ff3:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106ffa:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ffe:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000107001:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff800000107004:	90                   	nop
ffff800000107005:	c9                   	leave
ffff800000107006:	c3                   	ret

ffff800000107007 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff800000107007:	55                   	push   %rbp
ffff800000107008:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff80000010700b:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107012:	80 ff ff 
ffff800000107015:	48 89 c7             	mov    %rax,%rdi
ffff800000107018:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010701f:	80 ff ff 
ffff800000107022:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff800000107024:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010702b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010702f:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff800000107036:	48 b8 ed 6e 10 00 00 	movabs $0xffff800000106eed,%rax
ffff80000010703d:	80 ff ff 
ffff800000107040:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107042:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107049:	80 ff ff 
ffff80000010704c:	48 89 c7             	mov    %rax,%rdi
ffff80000010704f:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000107056:	80 ff ff 
ffff800000107059:	ff d0                	call   *%rax
}
ffff80000010705b:	90                   	nop
ffff80000010705c:	5d                   	pop    %rbp
ffff80000010705d:	c3                   	ret

ffff80000010705e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff80000010705e:	55                   	push   %rbp
ffff80000010705f:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff800000107062:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107069:	80 ff ff 
ffff80000010706c:	48 89 c7             	mov    %rax,%rdi
ffff80000010706f:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000107076:	80 ff ff 
ffff800000107079:	ff d0                	call   *%rax

  if (first) {
ffff80000010707b:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000107082:	80 ff ff 
ffff800000107085:	8b 00                	mov    (%rax),%eax
ffff800000107087:	85 c0                	test   %eax,%eax
ffff800000107089:	74 32                	je     ffff8000001070bd <forkret+0x5f>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff80000010708b:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000107092:	80 ff ff 
ffff800000107095:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff80000010709b:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001070a0:	48 b8 3f 25 10 00 00 	movabs $0xffff80000010253f,%rax
ffff8000001070a7:	80 ff ff 
ffff8000001070aa:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff8000001070ac:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001070b1:	48 b8 65 4d 10 00 00 	movabs $0xffff800000104d65,%rax
ffff8000001070b8:	80 ff ff 
ffff8000001070bb:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff8000001070bd:	90                   	nop
ffff8000001070be:	5d                   	pop    %rbp
ffff8000001070bf:	c3                   	ret

ffff8000001070c0 <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff8000001070c0:	55                   	push   %rbp
ffff8000001070c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070c4:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001070c8:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001070cc:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff8000001070d0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001070d7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001070db:	48 85 c0             	test   %rax,%rax
ffff8000001070de:	75 19                	jne    ffff8000001070f9 <sleep+0x39>
    panic("sleep");
ffff8000001070e0:	48 b8 01 c8 10 00 00 	movabs $0xffff80000010c801,%rax
ffff8000001070e7:	80 ff ff 
ffff8000001070ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001070ed:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001070f4:	80 ff ff 
ffff8000001070f7:	ff d0                	call   *%rax

  if(lk == 0)
ffff8000001070f9:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001070fe:	75 19                	jne    ffff800000107119 <sleep+0x59>
    panic("sleep without lk");
ffff800000107100:	48 b8 07 c8 10 00 00 	movabs $0xffff80000010c807,%rax
ffff800000107107:	80 ff ff 
ffff80000010710a:	48 89 c7             	mov    %rax,%rdi
ffff80000010710d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107114:	80 ff ff 
ffff800000107117:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff800000107119:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107120:	80 ff ff 
ffff800000107123:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107127:	74 2c                	je     ffff800000107155 <sleep+0x95>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff800000107129:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107130:	80 ff ff 
ffff800000107133:	48 89 c7             	mov    %rax,%rdi
ffff800000107136:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010713d:	80 ff ff 
ffff800000107140:	ff d0                	call   *%rax
    release(lk);
ffff800000107142:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107146:	48 89 c7             	mov    %rax,%rdi
ffff800000107149:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000107150:	80 ff ff 
ffff800000107153:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff800000107155:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010715c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107160:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107164:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff800000107168:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010716f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107173:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff80000010717a:	48 b8 ed 6e 10 00 00 	movabs $0xffff800000106eed,%rax
ffff800000107181:	80 ff ff 
ffff800000107184:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff800000107186:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010718d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107191:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff800000107198:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff800000107199:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001071a0:	80 ff ff 
ffff8000001071a3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001071a7:	74 2c                	je     ffff8000001071d5 <sleep+0x115>
    release(&ptable.lock);
ffff8000001071a9:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001071b0:	80 ff ff 
ffff8000001071b3:	48 89 c7             	mov    %rax,%rdi
ffff8000001071b6:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001071bd:	80 ff ff 
ffff8000001071c0:	ff d0                	call   *%rax
    acquire(lk);
ffff8000001071c2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001071c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001071c9:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001071d0:	80 ff ff 
ffff8000001071d3:	ff d0                	call   *%rax
  }
}
ffff8000001071d5:	90                   	nop
ffff8000001071d6:	c9                   	leave
ffff8000001071d7:	c3                   	ret

ffff8000001071d8 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff8000001071d8:	55                   	push   %rbp
ffff8000001071d9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001071dc:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001071e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001071e4:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff8000001071eb:	80 ff ff 
ffff8000001071ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001071f2:	eb 2d                	jmp    ffff800000107221 <wakeup1+0x49>
    if(p->state == SLEEPING && p->chan == chan)
ffff8000001071f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001071f8:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001071fb:	83 f8 02             	cmp    $0x2,%eax
ffff8000001071fe:	75 19                	jne    ffff800000107219 <wakeup1+0x41>
ffff800000107200:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107204:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000107208:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff80000010720c:	75 0b                	jne    ffff800000107219 <wakeup1+0x41>
      p->state = RUNNABLE;
ffff80000010720e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107212:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000107219:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000107220:	00 
ffff800000107221:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000107228:	80 ff ff 
ffff80000010722b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010722f:	72 c3                	jb     ffff8000001071f4 <wakeup1+0x1c>
}
ffff800000107231:	90                   	nop
ffff800000107232:	90                   	nop
ffff800000107233:	c9                   	leave
ffff800000107234:	c3                   	ret

ffff800000107235 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff800000107235:	55                   	push   %rbp
ffff800000107236:	48 89 e5             	mov    %rsp,%rbp
ffff800000107239:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010723d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000107241:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107248:	80 ff ff 
ffff80000010724b:	48 89 c7             	mov    %rax,%rdi
ffff80000010724e:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000107255:	80 ff ff 
ffff800000107258:	ff d0                	call   *%rax
  wakeup1(chan);
ffff80000010725a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010725e:	48 89 c7             	mov    %rax,%rdi
ffff800000107261:	48 b8 d8 71 10 00 00 	movabs $0xffff8000001071d8,%rax
ffff800000107268:	80 ff ff 
ffff80000010726b:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff80000010726d:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107274:	80 ff ff 
ffff800000107277:	48 89 c7             	mov    %rax,%rdi
ffff80000010727a:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000107281:	80 ff ff 
ffff800000107284:	ff d0                	call   *%rax
}
ffff800000107286:	90                   	nop
ffff800000107287:	c9                   	leave
ffff800000107288:	c3                   	ret

ffff800000107289 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff800000107289:	55                   	push   %rbp
ffff80000010728a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010728d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107291:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff800000107294:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff80000010729b:	80 ff ff 
ffff80000010729e:	48 89 c7             	mov    %rax,%rdi
ffff8000001072a1:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001072a8:	80 ff ff 
ffff8000001072ab:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001072ad:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff8000001072b4:	80 ff ff 
ffff8000001072b7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001072bb:	eb 56                	jmp    ffff800000107313 <kill+0x8a>
    if(p->pid == pid){
ffff8000001072bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072c1:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001072c4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001072c7:	75 42                	jne    ffff80000010730b <kill+0x82>
      p->killed = 1;
ffff8000001072c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072cd:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff8000001072d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072d8:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001072db:	83 f8 02             	cmp    $0x2,%eax
ffff8000001072de:	75 0b                	jne    ffff8000001072eb <kill+0x62>
        p->state = RUNNABLE;
ffff8000001072e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072e4:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff8000001072eb:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001072f2:	80 ff ff 
ffff8000001072f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001072f8:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001072ff:	80 ff ff 
ffff800000107302:	ff d0                	call   *%rax
      return 0;
ffff800000107304:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107309:	eb 36                	jmp    ffff800000107341 <kill+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010730b:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000107312:	00 
ffff800000107313:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff80000010731a:	80 ff ff 
ffff80000010731d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107321:	72 9a                	jb     ffff8000001072bd <kill+0x34>
    }
  }
  release(&ptable.lock);
ffff800000107323:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff80000010732a:	80 ff ff 
ffff80000010732d:	48 89 c7             	mov    %rax,%rdi
ffff800000107330:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000107337:	80 ff ff 
ffff80000010733a:	ff d0                	call   *%rax
  return -1;
ffff80000010733c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107341:	c9                   	leave
ffff800000107342:	c3                   	ret

ffff800000107343 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff800000107343:	55                   	push   %rbp
ffff800000107344:	48 89 e5             	mov    %rsp,%rbp
ffff800000107347:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010734b:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000107352:	80 ff ff 
ffff800000107355:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000107359:	e9 41 01 00 00       	jmp    ffff80000010749f <procdump+0x15c>
    if(p->state == UNUSED)
ffff80000010735e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107362:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107365:	85 c0                	test   %eax,%eax
ffff800000107367:	0f 84 29 01 00 00    	je     ffff800000107496 <procdump+0x153>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff80000010736d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107371:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107374:	83 f8 05             	cmp    $0x5,%eax
ffff800000107377:	77 39                	ja     ffff8000001073b2 <procdump+0x6f>
ffff800000107379:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010737d:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107380:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff800000107387:	80 ff ff 
ffff80000010738a:	89 d2                	mov    %edx,%edx
ffff80000010738c:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff800000107390:	48 85 c0             	test   %rax,%rax
ffff800000107393:	74 1d                	je     ffff8000001073b2 <procdump+0x6f>
      state = states[p->state];
ffff800000107395:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107399:	8b 50 18             	mov    0x18(%rax),%edx
ffff80000010739c:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff8000001073a3:	80 ff ff 
ffff8000001073a6:	89 d2                	mov    %edx,%edx
ffff8000001073a8:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff8000001073ac:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001073b0:	eb 0e                	jmp    ffff8000001073c0 <procdump+0x7d>
    else
      state = "???";
ffff8000001073b2:	48 b8 18 c8 10 00 00 	movabs $0xffff80000010c818,%rax
ffff8000001073b9:	80 ff ff 
ffff8000001073bc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff8000001073c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073c4:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001073cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073cf:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001073d2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001073d6:	48 bf 1c c8 10 00 00 	movabs $0xffff80000010c81c,%rdi
ffff8000001073dd:	80 ff ff 
ffff8000001073e0:	89 c6                	mov    %eax,%esi
ffff8000001073e2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001073e7:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff8000001073ee:	80 ff ff 
ffff8000001073f1:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff8000001073f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073f8:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001073fb:	83 f8 02             	cmp    $0x2,%eax
ffff8000001073fe:	75 76                	jne    ffff800000107476 <procdump+0x133>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff800000107400:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107404:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107408:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010740c:	48 83 c0 10          	add    $0x10,%rax
ffff800000107410:	48 89 c2             	mov    %rax,%rdx
ffff800000107413:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff800000107417:	48 89 c6             	mov    %rax,%rsi
ffff80000010741a:	48 89 d7             	mov    %rdx,%rdi
ffff80000010741d:	48 b8 0c 78 10 00 00 	movabs $0xffff80000010780c,%rax
ffff800000107424:	80 ff ff 
ffff800000107427:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff800000107429:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107430:	eb 2f                	jmp    ffff800000107461 <procdump+0x11e>
        cprintf(" %p", pc[i]);
ffff800000107432:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107435:	48 98                	cltq
ffff800000107437:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff80000010743c:	48 ba 25 c8 10 00 00 	movabs $0xffff80000010c825,%rdx
ffff800000107443:	80 ff ff 
ffff800000107446:	48 89 c6             	mov    %rax,%rsi
ffff800000107449:	48 89 d7             	mov    %rdx,%rdi
ffff80000010744c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107451:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000107458:	80 ff ff 
ffff80000010745b:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff80000010745d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107461:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107465:	7f 0f                	jg     ffff800000107476 <procdump+0x133>
ffff800000107467:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010746a:	48 98                	cltq
ffff80000010746c:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107471:	48 85 c0             	test   %rax,%rax
ffff800000107474:	75 bc                	jne    ffff800000107432 <procdump+0xef>
    }
    cprintf("\n");
ffff800000107476:	48 b8 29 c8 10 00 00 	movabs $0xffff80000010c829,%rax
ffff80000010747d:	80 ff ff 
ffff800000107480:	48 89 c7             	mov    %rax,%rdi
ffff800000107483:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107488:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010748f:	80 ff ff 
ffff800000107492:	ff d2                	call   *%rdx
ffff800000107494:	eb 01                	jmp    ffff800000107497 <procdump+0x154>
      continue;
ffff800000107496:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107497:	48 81 45 f0 e0 00 00 	addq   $0xe0,-0x10(%rbp)
ffff80000010749e:	00 
ffff80000010749f:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff8000001074a6:	80 ff ff 
ffff8000001074a9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001074ad:	0f 82 ab fe ff ff    	jb     ffff80000010735e <procdump+0x1b>
  }
}
ffff8000001074b3:	90                   	nop
ffff8000001074b4:	90                   	nop
ffff8000001074b5:	c9                   	leave
ffff8000001074b6:	c3                   	ret

ffff8000001074b7 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
ffff8000001074b7:	55                   	push   %rbp
ffff8000001074b8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001074bb:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001074bf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001074c3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&lk->lk, "sleep lock");
ffff8000001074c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074cb:	48 83 c0 08          	add    $0x8,%rax
ffff8000001074cf:	48 ba 55 c8 10 00 00 	movabs $0xffff80000010c855,%rdx
ffff8000001074d6:	80 ff ff 
ffff8000001074d9:	48 89 d6             	mov    %rdx,%rsi
ffff8000001074dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001074df:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff8000001074e6:	80 ff ff 
ffff8000001074e9:	ff d0                	call   *%rax
  lk->name = name;
ffff8000001074eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074ef:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001074f3:	48 89 50 70          	mov    %rdx,0x70(%rax)
  lk->locked = 0;
ffff8000001074f7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074fb:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff800000107501:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107505:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
}
ffff80000010750c:	90                   	nop
ffff80000010750d:	c9                   	leave
ffff80000010750e:	c3                   	ret

ffff80000010750f <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
ffff80000010750f:	55                   	push   %rbp
ffff800000107510:	48 89 e5             	mov    %rsp,%rbp
ffff800000107513:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107517:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff80000010751b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010751f:	48 83 c0 08          	add    $0x8,%rax
ffff800000107523:	48 89 c7             	mov    %rax,%rdi
ffff800000107526:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010752d:	80 ff ff 
ffff800000107530:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107532:	eb 1e                	jmp    ffff800000107552 <acquiresleep+0x43>
    sleep(lk, &lk->lk);
ffff800000107534:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107538:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff80000010753c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107540:	48 89 d6             	mov    %rdx,%rsi
ffff800000107543:	48 89 c7             	mov    %rax,%rdi
ffff800000107546:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff80000010754d:	80 ff ff 
ffff800000107550:	ff d0                	call   *%rax
  while (lk->locked)
ffff800000107552:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107556:	8b 00                	mov    (%rax),%eax
ffff800000107558:	85 c0                	test   %eax,%eax
ffff80000010755a:	75 d8                	jne    ffff800000107534 <acquiresleep+0x25>
  lk->locked = 1;
ffff80000010755c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107560:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  lk->pid = proc->pid;
ffff800000107566:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010756d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107571:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000107574:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107578:	89 50 78             	mov    %edx,0x78(%rax)
  release(&lk->lk);
ffff80000010757b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010757f:	48 83 c0 08          	add    $0x8,%rax
ffff800000107583:	48 89 c7             	mov    %rax,%rdi
ffff800000107586:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010758d:	80 ff ff 
ffff800000107590:	ff d0                	call   *%rax
}
ffff800000107592:	90                   	nop
ffff800000107593:	c9                   	leave
ffff800000107594:	c3                   	ret

ffff800000107595 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
ffff800000107595:	55                   	push   %rbp
ffff800000107596:	48 89 e5             	mov    %rsp,%rbp
ffff800000107599:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010759d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff8000001075a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075a5:	48 83 c0 08          	add    $0x8,%rax
ffff8000001075a9:	48 89 c7             	mov    %rax,%rdi
ffff8000001075ac:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001075b3:	80 ff ff 
ffff8000001075b6:	ff d0                	call   *%rax
  lk->locked = 0;
ffff8000001075b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075bc:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff8000001075c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075c6:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
  wakeup(lk);
ffff8000001075cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001075d4:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff8000001075db:	80 ff ff 
ffff8000001075de:	ff d0                	call   *%rax
  release(&lk->lk);
ffff8000001075e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075e4:	48 83 c0 08          	add    $0x8,%rax
ffff8000001075e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001075eb:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001075f2:	80 ff ff 
ffff8000001075f5:	ff d0                	call   *%rax
}
ffff8000001075f7:	90                   	nop
ffff8000001075f8:	c9                   	leave
ffff8000001075f9:	c3                   	ret

ffff8000001075fa <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
ffff8000001075fa:	55                   	push   %rbp
ffff8000001075fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001075fe:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107602:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  acquire(&lk->lk);
ffff800000107606:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010760a:	48 83 c0 08          	add    $0x8,%rax
ffff80000010760e:	48 89 c7             	mov    %rax,%rdi
ffff800000107611:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000107618:	80 ff ff 
ffff80000010761b:	ff d0                	call   *%rax
  int r = lk->locked;
ffff80000010761d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107621:	8b 00                	mov    (%rax),%eax
ffff800000107623:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&lk->lk);
ffff800000107626:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010762a:	48 83 c0 08          	add    $0x8,%rax
ffff80000010762e:	48 89 c7             	mov    %rax,%rdi
ffff800000107631:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000107638:	80 ff ff 
ffff80000010763b:	ff d0                	call   *%rax
  return r;
ffff80000010763d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107640:	c9                   	leave
ffff800000107641:	c3                   	ret

ffff800000107642 <readeflags>:
{
ffff800000107642:	55                   	push   %rbp
ffff800000107643:	48 89 e5             	mov    %rsp,%rbp
ffff800000107646:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff80000010764a:	9c                   	pushf
ffff80000010764b:	58                   	pop    %rax
ffff80000010764c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff800000107650:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107654:	c9                   	leave
ffff800000107655:	c3                   	ret

ffff800000107656 <cli>:
{
ffff800000107656:	55                   	push   %rbp
ffff800000107657:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffff80000010765a:	fa                   	cli
}
ffff80000010765b:	90                   	nop
ffff80000010765c:	5d                   	pop    %rbp
ffff80000010765d:	c3                   	ret

ffff80000010765e <sti>:
{
ffff80000010765e:	55                   	push   %rbp
ffff80000010765f:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff800000107662:	fb                   	sti
}
ffff800000107663:	90                   	nop
ffff800000107664:	5d                   	pop    %rbp
ffff800000107665:	c3                   	ret

ffff800000107666 <xchg>:
{
ffff800000107666:	55                   	push   %rbp
ffff800000107667:	48 89 e5             	mov    %rsp,%rbp
ffff80000010766a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010766e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107672:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("lock; xchgl %0, %1" :
ffff800000107676:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010767a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010767e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000107682:	f0 87 02             	lock xchg %eax,(%rdx)
ffff800000107685:	89 45 fc             	mov    %eax,-0x4(%rbp)
  return result;
ffff800000107688:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff80000010768b:	c9                   	leave
ffff80000010768c:	c3                   	ret

ffff80000010768d <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
ffff80000010768d:	55                   	push   %rbp
ffff80000010768e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107691:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107695:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107699:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffff80000010769d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076a1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001076a5:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffff8000001076a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076ad:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffff8000001076b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076b7:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001076be:	00 
}
ffff8000001076bf:	90                   	nop
ffff8000001076c0:	c9                   	leave
ffff8000001076c1:	c3                   	ret

ffff8000001076c2 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
ffff8000001076c2:	55                   	push   %rbp
ffff8000001076c3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076c6:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001076ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffff8000001076ce:	48 b8 e2 78 10 00 00 	movabs $0xffff8000001078e2,%rax
ffff8000001076d5:	80 ff ff 
ffff8000001076d8:	ff d0                	call   *%rax
  if(holding(lk))
ffff8000001076da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076de:	48 89 c7             	mov    %rax,%rdi
ffff8000001076e1:	48 b8 a6 78 10 00 00 	movabs $0xffff8000001078a6,%rax
ffff8000001076e8:	80 ff ff 
ffff8000001076eb:	ff d0                	call   *%rax
ffff8000001076ed:	85 c0                	test   %eax,%eax
ffff8000001076ef:	74 19                	je     ffff80000010770a <acquire+0x48>
    panic("acquire");
ffff8000001076f1:	48 b8 60 c8 10 00 00 	movabs $0xffff80000010c860,%rax
ffff8000001076f8:	80 ff ff 
ffff8000001076fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001076fe:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107705:	80 ff ff 
ffff800000107708:	ff d0                	call   *%rax

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
ffff80000010770a:	90                   	nop
ffff80000010770b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010770f:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000107714:	48 89 c7             	mov    %rax,%rdi
ffff800000107717:	48 b8 66 76 10 00 00 	movabs $0xffff800000107666,%rax
ffff80000010771e:	80 ff ff 
ffff800000107721:	ff d0                	call   *%rax
ffff800000107723:	85 c0                	test   %eax,%eax
ffff800000107725:	75 e4                	jne    ffff80000010770b <acquire+0x49>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
ffff800000107727:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
ffff80000010772d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107731:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000107738:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff80000010773c:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffff800000107740:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107744:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff800000107748:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010774c:	48 89 d6             	mov    %rdx,%rsi
ffff80000010774f:	48 89 c7             	mov    %rax,%rdi
ffff800000107752:	48 b8 d8 77 10 00 00 	movabs $0xffff8000001077d8,%rax
ffff800000107759:	80 ff ff 
ffff80000010775c:	ff d0                	call   *%rax
}
ffff80000010775e:	90                   	nop
ffff80000010775f:	c9                   	leave
ffff800000107760:	c3                   	ret

ffff800000107761 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
ffff800000107761:	55                   	push   %rbp
ffff800000107762:	48 89 e5             	mov    %rsp,%rbp
ffff800000107765:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107769:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffff80000010776d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107771:	48 89 c7             	mov    %rax,%rdi
ffff800000107774:	48 b8 a6 78 10 00 00 	movabs $0xffff8000001078a6,%rax
ffff80000010777b:	80 ff ff 
ffff80000010777e:	ff d0                	call   *%rax
ffff800000107780:	85 c0                	test   %eax,%eax
ffff800000107782:	75 19                	jne    ffff80000010779d <release+0x3c>
    panic("release");
ffff800000107784:	48 b8 68 c8 10 00 00 	movabs $0xffff80000010c868,%rax
ffff80000010778b:	80 ff ff 
ffff80000010778e:	48 89 c7             	mov    %rax,%rdi
ffff800000107791:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107798:	80 ff ff 
ffff80000010779b:	ff d0                	call   *%rax

  lk->pcs[0] = 0;
ffff80000010779d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077a1:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff8000001077a8:	00 
  lk->cpu = 0;
ffff8000001077a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077ad:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001077b4:	00 
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
ffff8000001077b5:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
ffff8000001077bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077bf:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001077c3:	c7 00 00 00 00 00    	movl   $0x0,(%rax)

  popcli();
ffff8000001077c9:	48 b8 50 79 10 00 00 	movabs $0xffff800000107950,%rax
ffff8000001077d0:	80 ff ff 
ffff8000001077d3:	ff d0                	call   *%rax
}
ffff8000001077d5:	90                   	nop
ffff8000001077d6:	c9                   	leave
ffff8000001077d7:	c3                   	ret

ffff8000001077d8 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %rbp chain.
void
getcallerpcs(void *v, addr_t pcs[])
{
ffff8000001077d8:	55                   	push   %rbp
ffff8000001077d9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077dc:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001077e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001077e4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  addr_t *rbp;

  asm volatile("mov %%rbp, %0" : "=r" (rbp));
ffff8000001077e8:	48 89 e8             	mov    %rbp,%rax
ffff8000001077eb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  getstackpcs(rbp, pcs);
ffff8000001077ef:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff8000001077f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077f7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001077fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001077fd:	48 b8 0c 78 10 00 00 	movabs $0xffff80000010780c,%rax
ffff800000107804:	80 ff ff 
ffff800000107807:	ff d0                	call   *%rax
}
ffff800000107809:	90                   	nop
ffff80000010780a:	c9                   	leave
ffff80000010780b:	c3                   	ret

ffff80000010780c <getstackpcs>:

void
getstackpcs(addr_t *rbp, addr_t pcs[])
{
ffff80000010780c:	55                   	push   %rbp
ffff80000010780d:	48 89 e5             	mov    %rsp,%rbp
ffff800000107810:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107814:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107818:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 0; i < 10; i++){
ffff80000010781c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107823:	eb 50                	jmp    ffff800000107875 <getstackpcs+0x69>
    if(rbp == 0 || rbp < (addr_t*)KERNBASE || rbp == (addr_t*)0xffffffff)
ffff800000107825:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010782a:	74 70                	je     ffff80000010789c <getstackpcs+0x90>
ffff80000010782c:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff800000107833:	7f ff ff 
ffff800000107836:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff80000010783a:	73 60                	jae    ffff80000010789c <getstackpcs+0x90>
ffff80000010783c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107841:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107845:	74 55                	je     ffff80000010789c <getstackpcs+0x90>
      break;
    pcs[i] = rbp[1];     // saved %rip
ffff800000107847:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010784a:	48 98                	cltq
ffff80000010784c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107853:	00 
ffff800000107854:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107858:	48 01 c2             	add    %rax,%rdx
ffff80000010785b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010785f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107863:	48 89 02             	mov    %rax,(%rdx)
    rbp = (addr_t*)rbp[0]; // saved %rbp
ffff800000107866:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010786a:	48 8b 00             	mov    (%rax),%rax
ffff80000010786d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffff800000107871:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107875:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107879:	7e aa                	jle    ffff800000107825 <getstackpcs+0x19>
  }
  for(; i < 10; i++)
ffff80000010787b:	eb 1f                	jmp    ffff80000010789c <getstackpcs+0x90>
    pcs[i] = 0;
ffff80000010787d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107880:	48 98                	cltq
ffff800000107882:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107889:	00 
ffff80000010788a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010788e:	48 01 d0             	add    %rdx,%rax
ffff800000107891:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffff800000107898:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010789c:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff8000001078a0:	7e db                	jle    ffff80000010787d <getstackpcs+0x71>
}
ffff8000001078a2:	90                   	nop
ffff8000001078a3:	90                   	nop
ffff8000001078a4:	c9                   	leave
ffff8000001078a5:	c3                   	ret

ffff8000001078a6 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
ffff8000001078a6:	55                   	push   %rbp
ffff8000001078a7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078aa:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001078ae:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffff8000001078b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078b6:	8b 00                	mov    (%rax),%eax
ffff8000001078b8:	85 c0                	test   %eax,%eax
ffff8000001078ba:	74 1f                	je     ffff8000001078db <holding+0x35>
ffff8000001078bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078c0:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001078c4:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001078cb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001078cf:	48 39 c2             	cmp    %rax,%rdx
ffff8000001078d2:	75 07                	jne    ffff8000001078db <holding+0x35>
ffff8000001078d4:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001078d9:	eb 05                	jmp    ffff8000001078e0 <holding+0x3a>
ffff8000001078db:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001078e0:	c9                   	leave
ffff8000001078e1:	c3                   	ret

ffff8000001078e2 <pushcli>:
// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.
void
pushcli(void)
{
ffff8000001078e2:	55                   	push   %rbp
ffff8000001078e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078e6:	48 83 ec 10          	sub    $0x10,%rsp
  int eflags;

  eflags = readeflags();
ffff8000001078ea:	48 b8 42 76 10 00 00 	movabs $0xffff800000107642,%rax
ffff8000001078f1:	80 ff ff 
ffff8000001078f4:	ff d0                	call   *%rax
ffff8000001078f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffff8000001078f9:	48 b8 56 76 10 00 00 	movabs $0xffff800000107656,%rax
ffff800000107900:	80 ff ff 
ffff800000107903:	ff d0                	call   *%rax
  if(cpu->ncli == 0)
ffff800000107905:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010790c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107910:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107913:	85 c0                	test   %eax,%eax
ffff800000107915:	75 17                	jne    ffff80000010792e <pushcli+0x4c>
    cpu->intena = eflags & FL_IF;
ffff800000107917:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010791e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107922:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000107925:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff80000010792b:	89 50 18             	mov    %edx,0x18(%rax)
  cpu->ncli += 1;
ffff80000010792e:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107935:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107939:	8b 50 14             	mov    0x14(%rax),%edx
ffff80000010793c:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107943:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107947:	83 c2 01             	add    $0x1,%edx
ffff80000010794a:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff80000010794d:	90                   	nop
ffff80000010794e:	c9                   	leave
ffff80000010794f:	c3                   	ret

ffff800000107950 <popcli>:

void
popcli(void)
{
ffff800000107950:	55                   	push   %rbp
ffff800000107951:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffff800000107954:	48 b8 42 76 10 00 00 	movabs $0xffff800000107642,%rax
ffff80000010795b:	80 ff ff 
ffff80000010795e:	ff d0                	call   *%rax
ffff800000107960:	25 00 02 00 00       	and    $0x200,%eax
ffff800000107965:	48 85 c0             	test   %rax,%rax
ffff800000107968:	74 19                	je     ffff800000107983 <popcli+0x33>
    panic("popcli - interruptible");
ffff80000010796a:	48 b8 70 c8 10 00 00 	movabs $0xffff80000010c870,%rax
ffff800000107971:	80 ff ff 
ffff800000107974:	48 89 c7             	mov    %rax,%rdi
ffff800000107977:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010797e:	80 ff ff 
ffff800000107981:	ff d0                	call   *%rax
  if(--cpu->ncli < 0)
ffff800000107983:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010798a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010798e:	8b 50 14             	mov    0x14(%rax),%edx
ffff800000107991:	83 ea 01             	sub    $0x1,%edx
ffff800000107994:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000107997:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010799a:	85 c0                	test   %eax,%eax
ffff80000010799c:	79 19                	jns    ffff8000001079b7 <popcli+0x67>
    panic("popcli");
ffff80000010799e:	48 b8 87 c8 10 00 00 	movabs $0xffff80000010c887,%rax
ffff8000001079a5:	80 ff ff 
ffff8000001079a8:	48 89 c7             	mov    %rax,%rdi
ffff8000001079ab:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001079b2:	80 ff ff 
ffff8000001079b5:	ff d0                	call   *%rax
  if(cpu->ncli == 0 && cpu->intena)
ffff8000001079b7:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079be:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079c2:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001079c5:	85 c0                	test   %eax,%eax
ffff8000001079c7:	75 1e                	jne    ffff8000001079e7 <popcli+0x97>
ffff8000001079c9:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079d0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079d4:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001079d7:	85 c0                	test   %eax,%eax
ffff8000001079d9:	74 0c                	je     ffff8000001079e7 <popcli+0x97>
    sti();
ffff8000001079db:	48 b8 5e 76 10 00 00 	movabs $0xffff80000010765e,%rax
ffff8000001079e2:	80 ff ff 
ffff8000001079e5:	ff d0                	call   *%rax
}
ffff8000001079e7:	90                   	nop
ffff8000001079e8:	5d                   	pop    %rbp
ffff8000001079e9:	c3                   	ret

ffff8000001079ea <stosb>:
{
ffff8000001079ea:	55                   	push   %rbp
ffff8000001079eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001079ee:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001079f2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001079f6:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff8000001079f9:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
ffff8000001079fc:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a00:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a03:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a06:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a09:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a0c:	89 d1                	mov    %edx,%ecx
ffff800000107a0e:	fc                   	cld
ffff800000107a0f:	f3 aa                	rep stos %al,(%rdi)
ffff800000107a11:	89 ca                	mov    %ecx,%edx
ffff800000107a13:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a16:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a1a:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffff800000107a1d:	90                   	nop
ffff800000107a1e:	c9                   	leave
ffff800000107a1f:	c3                   	ret

ffff800000107a20 <stosl>:
{
ffff800000107a20:	55                   	push   %rbp
ffff800000107a21:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a24:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a28:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a2c:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a2f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosl" :
ffff800000107a32:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a36:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a39:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a3c:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a3f:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a42:	89 d1                	mov    %edx,%ecx
ffff800000107a44:	fc                   	cld
ffff800000107a45:	f3 ab                	rep stos %eax,(%rdi)
ffff800000107a47:	89 ca                	mov    %ecx,%edx
ffff800000107a49:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a4c:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a50:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
ffff800000107a53:	90                   	nop
ffff800000107a54:	c9                   	leave
ffff800000107a55:	c3                   	ret

ffff800000107a56 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint64 n)
{
ffff800000107a56:	55                   	push   %rbp
ffff800000107a57:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a5a:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107a5e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a62:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a65:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  if ((addr_t)dst%4 == 0 && n%4 == 0){
ffff800000107a69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a6d:	83 e0 03             	and    $0x3,%eax
ffff800000107a70:	48 85 c0             	test   %rax,%rax
ffff800000107a73:	75 53                	jne    ffff800000107ac8 <memset+0x72>
ffff800000107a75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a79:	83 e0 03             	and    $0x3,%eax
ffff800000107a7c:	48 85 c0             	test   %rax,%rax
ffff800000107a7f:	75 47                	jne    ffff800000107ac8 <memset+0x72>
    c &= 0xFF;
ffff800000107a81:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
ffff800000107a88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a8c:	48 c1 e8 02          	shr    $0x2,%rax
ffff800000107a90:	89 c6                	mov    %eax,%esi
ffff800000107a92:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a95:	c1 e0 18             	shl    $0x18,%eax
ffff800000107a98:	89 c2                	mov    %eax,%edx
ffff800000107a9a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a9d:	c1 e0 10             	shl    $0x10,%eax
ffff800000107aa0:	09 c2                	or     %eax,%edx
ffff800000107aa2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107aa5:	c1 e0 08             	shl    $0x8,%eax
ffff800000107aa8:	09 d0                	or     %edx,%eax
ffff800000107aaa:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff800000107aad:	89 c1                	mov    %eax,%ecx
ffff800000107aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ab3:	89 f2                	mov    %esi,%edx
ffff800000107ab5:	89 ce                	mov    %ecx,%esi
ffff800000107ab7:	48 89 c7             	mov    %rax,%rdi
ffff800000107aba:	48 b8 20 7a 10 00 00 	movabs $0xffff800000107a20,%rax
ffff800000107ac1:	80 ff ff 
ffff800000107ac4:	ff d0                	call   *%rax
ffff800000107ac6:	eb 1e                	jmp    ffff800000107ae6 <memset+0x90>
  } else
    stosb(dst, c, n);
ffff800000107ac8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107acc:	89 c2                	mov    %eax,%edx
ffff800000107ace:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff800000107ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ad5:	89 ce                	mov    %ecx,%esi
ffff800000107ad7:	48 89 c7             	mov    %rax,%rdi
ffff800000107ada:	48 b8 ea 79 10 00 00 	movabs $0xffff8000001079ea,%rax
ffff800000107ae1:	80 ff ff 
ffff800000107ae4:	ff d0                	call   *%rax
  return dst;
ffff800000107ae6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107aea:	c9                   	leave
ffff800000107aeb:	c3                   	ret

ffff800000107aec <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
ffff800000107aec:	55                   	push   %rbp
ffff800000107aed:	48 89 e5             	mov    %rsp,%rbp
ffff800000107af0:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107af4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107af8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107afc:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const uchar *s1, *s2;

  s1 = v1;
ffff800000107aff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b03:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  s2 = v2;
ffff800000107b07:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b0b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0){
ffff800000107b0f:	eb 34                	jmp    ffff800000107b45 <memcmp+0x59>
    if(*s1 != *s2)
ffff800000107b11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b15:	0f b6 10             	movzbl (%rax),%edx
ffff800000107b18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b1c:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b1f:	38 c2                	cmp    %al,%dl
ffff800000107b21:	74 18                	je     ffff800000107b3b <memcmp+0x4f>
      return *s1 - *s2;
ffff800000107b23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b27:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b2a:	0f b6 d0             	movzbl %al,%edx
ffff800000107b2d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b31:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b34:	0f b6 c0             	movzbl %al,%eax
ffff800000107b37:	29 c2                	sub    %eax,%edx
ffff800000107b39:	eb 1c                	jmp    ffff800000107b57 <memcmp+0x6b>
    s1++, s2++;
ffff800000107b3b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107b40:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n-- > 0){
ffff800000107b45:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107b48:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107b4b:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107b4e:	85 c0                	test   %eax,%eax
ffff800000107b50:	75 bf                	jne    ffff800000107b11 <memcmp+0x25>
  }

  return 0;
ffff800000107b52:	ba 00 00 00 00       	mov    $0x0,%edx
}
ffff800000107b57:	89 d0                	mov    %edx,%eax
ffff800000107b59:	c9                   	leave
ffff800000107b5a:	c3                   	ret

ffff800000107b5b <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
ffff800000107b5b:	55                   	push   %rbp
ffff800000107b5c:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b5f:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107b63:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b67:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107b6b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  const char *s;
  char *d;

  s = src;
ffff800000107b6e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b72:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  d = dst;
ffff800000107b76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b7a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(s < d && s + n > d){
ffff800000107b7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b82:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107b86:	73 63                	jae    ffff800000107beb <memmove+0x90>
ffff800000107b88:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000107b8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b8f:	48 01 d0             	add    %rdx,%rax
ffff800000107b92:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107b96:	73 53                	jae    ffff800000107beb <memmove+0x90>
    s += n;
ffff800000107b98:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107b9b:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    d += n;
ffff800000107b9f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107ba2:	48 01 45 f0          	add    %rax,-0x10(%rbp)
    while(n-- > 0)
ffff800000107ba6:	eb 17                	jmp    ffff800000107bbf <memmove+0x64>
      *--d = *--s;
ffff800000107ba8:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff800000107bad:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff800000107bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bb6:	0f b6 10             	movzbl (%rax),%edx
ffff800000107bb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107bbd:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107bbf:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bc2:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107bc5:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107bc8:	85 c0                	test   %eax,%eax
ffff800000107bca:	75 dc                	jne    ffff800000107ba8 <memmove+0x4d>
  if(s < d && s + n > d){
ffff800000107bcc:	eb 2a                	jmp    ffff800000107bf8 <memmove+0x9d>
  } else
    while(n-- > 0)
      *d++ = *s++;
ffff800000107bce:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107bd2:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107bd6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107bda:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107bde:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107be2:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff800000107be6:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107be9:	88 10                	mov    %dl,(%rax)
    while(n-- > 0)
ffff800000107beb:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bee:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107bf1:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107bf4:	85 c0                	test   %eax,%eax
ffff800000107bf6:	75 d6                	jne    ffff800000107bce <memmove+0x73>

  return dst;
ffff800000107bf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
ffff800000107bfc:	c9                   	leave
ffff800000107bfd:	c3                   	ret

ffff800000107bfe <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
ffff800000107bfe:	55                   	push   %rbp
ffff800000107bff:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c02:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c06:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c0a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c0e:	89 55 ec             	mov    %edx,-0x14(%rbp)
  return memmove(dst, src, n);
ffff800000107c11:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000107c14:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000107c18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c1c:	48 89 ce             	mov    %rcx,%rsi
ffff800000107c1f:	48 89 c7             	mov    %rax,%rdi
ffff800000107c22:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff800000107c29:	80 ff ff 
ffff800000107c2c:	ff d0                	call   *%rax
}
ffff800000107c2e:	c9                   	leave
ffff800000107c2f:	c3                   	ret

ffff800000107c30 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
ffff800000107c30:	55                   	push   %rbp
ffff800000107c31:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c34:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c38:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c3c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c40:	89 55 ec             	mov    %edx,-0x14(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107c43:	eb 0e                	jmp    ffff800000107c53 <strncmp+0x23>
    n--, p++, q++;
ffff800000107c45:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff800000107c49:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107c4e:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(n > 0 && *p && *p == *q)
ffff800000107c53:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107c57:	74 1d                	je     ffff800000107c76 <strncmp+0x46>
ffff800000107c59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c5d:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c60:	84 c0                	test   %al,%al
ffff800000107c62:	74 12                	je     ffff800000107c76 <strncmp+0x46>
ffff800000107c64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c68:	0f b6 10             	movzbl (%rax),%edx
ffff800000107c6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c6f:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c72:	38 c2                	cmp    %al,%dl
ffff800000107c74:	74 cf                	je     ffff800000107c45 <strncmp+0x15>
  if(n == 0)
ffff800000107c76:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107c7a:	75 07                	jne    ffff800000107c83 <strncmp+0x53>
    return 0;
ffff800000107c7c:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107c81:	eb 16                	jmp    ffff800000107c99 <strncmp+0x69>
  return (uchar)*p - (uchar)*q;
ffff800000107c83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c87:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c8a:	0f b6 d0             	movzbl %al,%edx
ffff800000107c8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c91:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c94:	0f b6 c0             	movzbl %al,%eax
ffff800000107c97:	29 c2                	sub    %eax,%edx
}
ffff800000107c99:	89 d0                	mov    %edx,%eax
ffff800000107c9b:	c9                   	leave
ffff800000107c9c:	c3                   	ret

ffff800000107c9d <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
ffff800000107c9d:	55                   	push   %rbp
ffff800000107c9e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107ca1:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107ca5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107ca9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107cad:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107cb0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107cb4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(n-- > 0 && (*s++ = *t++) != 0)
ffff800000107cb8:	90                   	nop
ffff800000107cb9:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107cbc:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107cbf:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107cc2:	85 c0                	test   %eax,%eax
ffff800000107cc4:	7e 35                	jle    ffff800000107cfb <strncpy+0x5e>
ffff800000107cc6:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107cca:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107cce:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107cd2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107cd6:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107cda:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107cde:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107ce1:	88 10                	mov    %dl,(%rax)
ffff800000107ce3:	0f b6 00             	movzbl (%rax),%eax
ffff800000107ce6:	84 c0                	test   %al,%al
ffff800000107ce8:	75 cf                	jne    ffff800000107cb9 <strncpy+0x1c>
    ;
  while(n-- > 0)
ffff800000107cea:	eb 0f                	jmp    ffff800000107cfb <strncpy+0x5e>
    *s++ = 0;
ffff800000107cec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107cf0:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000107cf4:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107cf8:	c6 00 00             	movb   $0x0,(%rax)
  while(n-- > 0)
ffff800000107cfb:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107cfe:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107d01:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107d04:	85 c0                	test   %eax,%eax
ffff800000107d06:	7f e4                	jg     ffff800000107cec <strncpy+0x4f>
  return os;
ffff800000107d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107d0c:	c9                   	leave
ffff800000107d0d:	c3                   	ret

ffff800000107d0e <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
ffff800000107d0e:	55                   	push   %rbp
ffff800000107d0f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d12:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107d16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107d1a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107d1e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *os = s;
ffff800000107d21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n <= 0)
ffff800000107d29:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107d2d:	7f 06                	jg     ffff800000107d35 <safestrcpy+0x27>
    return os;
ffff800000107d2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d33:	eb 3a                	jmp    ffff800000107d6f <safestrcpy+0x61>
  while(--n > 0 && (*s++ = *t++) != 0)
ffff800000107d35:	90                   	nop
ffff800000107d36:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000107d3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107d3e:	7e 24                	jle    ffff800000107d64 <safestrcpy+0x56>
ffff800000107d40:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107d44:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107d48:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107d4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d50:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107d54:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107d58:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107d5b:	88 10                	mov    %dl,(%rax)
ffff800000107d5d:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d60:	84 c0                	test   %al,%al
ffff800000107d62:	75 d2                	jne    ffff800000107d36 <safestrcpy+0x28>
    ;
  *s = 0;
ffff800000107d64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d68:	c6 00 00             	movb   $0x0,(%rax)
  return os;
ffff800000107d6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000107d6f:	c9                   	leave
ffff800000107d70:	c3                   	ret

ffff800000107d71 <strlen>:

int
strlen(const char *s)
{
ffff800000107d71:	55                   	push   %rbp
ffff800000107d72:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d75:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107d79:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
ffff800000107d7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107d84:	eb 04                	jmp    ffff800000107d8a <strlen+0x19>
ffff800000107d86:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107d8a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107d8d:	48 63 d0             	movslq %eax,%rdx
ffff800000107d90:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d94:	48 01 d0             	add    %rdx,%rax
ffff800000107d97:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d9a:	84 c0                	test   %al,%al
ffff800000107d9c:	75 e8                	jne    ffff800000107d86 <strlen+0x15>
    ;
  return n;
ffff800000107d9e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107da1:	c9                   	leave
ffff800000107da2:	c3                   	ret

ffff800000107da3 <swtch>:
# and then load register context from new.

.global swtch
swtch:
  # Save old callee-save registers
  pushq   %rbp
ffff800000107da3:	55                   	push   %rbp
  pushq   %rbx
ffff800000107da4:	53                   	push   %rbx
  pushq   %r12
ffff800000107da5:	41 54                	push   %r12
  pushq   %r13
ffff800000107da7:	41 55                	push   %r13
  pushq   %r14
ffff800000107da9:	41 56                	push   %r14
  pushq   %r15
ffff800000107dab:	41 57                	push   %r15

  # Switch stacks
  movq    %rsp, (%rdi)
ffff800000107dad:	48 89 27             	mov    %rsp,(%rdi)
  movq    %rsi, %rsp
ffff800000107db0:	48 89 f4             	mov    %rsi,%rsp

  # Load new callee-save registers
  popq    %r15
ffff800000107db3:	41 5f                	pop    %r15
  popq    %r14
ffff800000107db5:	41 5e                	pop    %r14
  popq    %r13
ffff800000107db7:	41 5d                	pop    %r13
  popq    %r12
ffff800000107db9:	41 5c                	pop    %r12
  popq    %rbx
ffff800000107dbb:	5b                   	pop    %rbx
  popq    %rbp
ffff800000107dbc:	5d                   	pop    %rbp

  retq #??
ffff800000107dbd:	c3                   	ret

ffff800000107dbe <fetchint>:
#include "trace.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff800000107dbe:	55                   	push   %rbp
ffff800000107dbf:	48 89 e5             	mov    %rsp,%rbp
ffff800000107dc2:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107dc6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107dca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff800000107dce:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107dd5:	00 
ffff800000107dd6:	76 2f                	jbe    ffff800000107e07 <fetchint+0x49>
ffff800000107dd8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ddf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107de3:	48 8b 00             	mov    (%rax),%rax
ffff800000107de6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107dea:	73 1b                	jae    ffff800000107e07 <fetchint+0x49>
ffff800000107dec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107df0:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000107df4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107dfb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107dff:	48 8b 00             	mov    (%rax),%rax
ffff800000107e02:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e05:	73 07                	jae    ffff800000107e0e <fetchint+0x50>
    return -1;
ffff800000107e07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e0c:	eb 11                	jmp    ffff800000107e1f <fetchint+0x61>
  *ip = *(int*)(addr);
ffff800000107e0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e12:	8b 10                	mov    (%rax),%edx
ffff800000107e14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e18:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000107e1a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e1f:	c9                   	leave
ffff800000107e20:	c3                   	ret

ffff800000107e21 <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff800000107e21:	55                   	push   %rbp
ffff800000107e22:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e25:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107e29:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107e2d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff800000107e31:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107e38:	00 
ffff800000107e39:	76 2f                	jbe    ffff800000107e6a <fetchaddr+0x49>
ffff800000107e3b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e42:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e46:	48 8b 00             	mov    (%rax),%rax
ffff800000107e49:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107e4d:	73 1b                	jae    ffff800000107e6a <fetchaddr+0x49>
ffff800000107e4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e53:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107e57:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e5e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e62:	48 8b 00             	mov    (%rax),%rax
ffff800000107e65:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e68:	73 07                	jae    ffff800000107e71 <fetchaddr+0x50>
    return -1;
ffff800000107e6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e6f:	eb 13                	jmp    ffff800000107e84 <fetchaddr+0x63>
  *ip = *(addr_t*)(addr);
ffff800000107e71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e75:	48 8b 10             	mov    (%rax),%rdx
ffff800000107e78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e7c:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000107e7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e84:	c9                   	leave
ffff800000107e85:	c3                   	ret

ffff800000107e86 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff800000107e86:	55                   	push   %rbp
ffff800000107e87:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e8a:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107e8e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107e92:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff800000107e96:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff800000107e9d:	00 
ffff800000107e9e:	76 14                	jbe    ffff800000107eb4 <fetchstr+0x2e>
ffff800000107ea0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ea7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107eab:	48 8b 00             	mov    (%rax),%rax
ffff800000107eae:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107eb2:	72 07                	jb     ffff800000107ebb <fetchstr+0x35>
    return -1;
ffff800000107eb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107eb9:	eb 5b                	jmp    ffff800000107f16 <fetchstr+0x90>
  *pp = (char*)addr;
ffff800000107ebb:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107ebf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107ec3:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff800000107ec6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ecd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ed1:	48 8b 00             	mov    (%rax),%rax
ffff800000107ed4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff800000107ed8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107edc:	48 8b 00             	mov    (%rax),%rax
ffff800000107edf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107ee3:	eb 22                	jmp    ffff800000107f07 <fetchstr+0x81>
    if(*s == 0)
ffff800000107ee5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ee9:	0f b6 00             	movzbl (%rax),%eax
ffff800000107eec:	84 c0                	test   %al,%al
ffff800000107eee:	75 12                	jne    ffff800000107f02 <fetchstr+0x7c>
      return s - *pp;
ffff800000107ef0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107ef4:	48 8b 00             	mov    (%rax),%rax
ffff800000107ef7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107efb:	48 29 c2             	sub    %rax,%rdx
ffff800000107efe:	89 d0                	mov    %edx,%eax
ffff800000107f00:	eb 14                	jmp    ffff800000107f16 <fetchstr+0x90>
  for(s = *pp; s < ep; s++)
ffff800000107f02:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107f07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f0b:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107f0f:	72 d4                	jb     ffff800000107ee5 <fetchstr+0x5f>
  return -1;
ffff800000107f11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107f16:	c9                   	leave
ffff800000107f17:	c3                   	ret

ffff800000107f18 <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff800000107f18:	55                   	push   %rbp
ffff800000107f19:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f1c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107f20:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff800000107f23:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f27:	0f 84 bb 00 00 00    	je     ffff800000107fe8 <fetcharg+0xd0>
ffff800000107f2d:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f31:	0f 8f c6 00 00 00    	jg     ffff800000107ffd <fetcharg+0xe5>
ffff800000107f37:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107f3b:	0f 84 92 00 00 00    	je     ffff800000107fd3 <fetcharg+0xbb>
ffff800000107f41:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107f45:	0f 8f b2 00 00 00    	jg     ffff800000107ffd <fetcharg+0xe5>
ffff800000107f4b:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107f4f:	74 6d                	je     ffff800000107fbe <fetcharg+0xa6>
ffff800000107f51:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107f55:	0f 8f a2 00 00 00    	jg     ffff800000107ffd <fetcharg+0xe5>
ffff800000107f5b:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107f5f:	74 48                	je     ffff800000107fa9 <fetcharg+0x91>
ffff800000107f61:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107f65:	0f 8f 92 00 00 00    	jg     ffff800000107ffd <fetcharg+0xe5>
ffff800000107f6b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000107f6f:	74 0b                	je     ffff800000107f7c <fetcharg+0x64>
ffff800000107f71:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000107f75:	74 1d                	je     ffff800000107f94 <fetcharg+0x7c>
ffff800000107f77:	e9 81 00 00 00       	jmp    ffff800000107ffd <fetcharg+0xe5>
  case 0: return proc->tf->rdi;
ffff800000107f7c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f83:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f87:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107f8b:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107f8f:	e9 82 00 00 00       	jmp    ffff800000108016 <fetcharg+0xfe>
  case 1: return proc->tf->rsi;
ffff800000107f94:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f9b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f9f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fa3:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fa7:	eb 6d                	jmp    ffff800000108016 <fetcharg+0xfe>
  case 2: return proc->tf->rdx;
ffff800000107fa9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fb0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fb4:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fb8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000107fbc:	eb 58                	jmp    ffff800000108016 <fetcharg+0xfe>
  case 3: return proc->tf->r10;
ffff800000107fbe:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fc5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fc9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fcd:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff800000107fd1:	eb 43                	jmp    ffff800000108016 <fetcharg+0xfe>
  case 4: return proc->tf->r8;
ffff800000107fd3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fda:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fde:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fe2:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000107fe6:	eb 2e                	jmp    ffff800000108016 <fetcharg+0xfe>
  case 5: return proc->tf->r9;
ffff800000107fe8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ff3:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107ff7:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff800000107ffb:	eb 19                	jmp    ffff800000108016 <fetcharg+0xfe>
  }
  panic("failed fetch");
ffff800000107ffd:	48 b8 8e c8 10 00 00 	movabs $0xffff80000010c88e,%rax
ffff800000108004:	80 ff ff 
ffff800000108007:	48 89 c7             	mov    %rax,%rdi
ffff80000010800a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108011:	80 ff ff 
ffff800000108014:	ff d0                	call   *%rax
}
ffff800000108016:	c9                   	leave
ffff800000108017:	c3                   	ret

ffff800000108018 <argint>:

int
argint(int n, int *ip)
{
ffff800000108018:	55                   	push   %rbp
ffff800000108019:	48 89 e5             	mov    %rsp,%rbp
ffff80000010801c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108020:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108023:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000108027:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010802a:	89 c7                	mov    %eax,%edi
ffff80000010802c:	48 b8 18 7f 10 00 00 	movabs $0xffff800000107f18,%rax
ffff800000108033:	80 ff ff 
ffff800000108036:	ff d0                	call   *%rax
ffff800000108038:	89 c2                	mov    %eax,%edx
ffff80000010803a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010803e:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000108040:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108045:	c9                   	leave
ffff800000108046:	c3                   	ret

ffff800000108047 <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff800000108047:	55                   	push   %rbp
ffff800000108048:	48 89 e5             	mov    %rsp,%rbp
ffff80000010804b:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010804f:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000108052:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000108056:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108059:	89 c7                	mov    %eax,%edi
ffff80000010805b:	48 b8 18 7f 10 00 00 	movabs $0xffff800000107f18,%rax
ffff800000108062:	80 ff ff 
ffff800000108065:	ff d0                	call   *%rax
ffff800000108067:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010806b:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff80000010806e:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108073:	c9                   	leave
ffff800000108074:	c3                   	ret

ffff800000108075 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff800000108075:	55                   	push   %rbp
ffff800000108076:	48 89 e5             	mov    %rsp,%rbp
ffff800000108079:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010807d:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108080:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000108084:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff800000108087:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff80000010808b:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010808e:	48 89 d6             	mov    %rdx,%rsi
ffff800000108091:	89 c7                	mov    %eax,%edi
ffff800000108093:	48 b8 47 80 10 00 00 	movabs $0xffff800000108047,%rax
ffff80000010809a:	80 ff ff 
ffff80000010809d:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff80000010809f:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff8000001080a3:	78 39                	js     ffff8000001080de <argptr+0x69>
ffff8000001080a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080a9:	89 c2                	mov    %eax,%edx
ffff8000001080ab:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080b2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080b6:	48 8b 00             	mov    (%rax),%rax
ffff8000001080b9:	48 39 c2             	cmp    %rax,%rdx
ffff8000001080bc:	73 20                	jae    ffff8000001080de <argptr+0x69>
ffff8000001080be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080c2:	89 c2                	mov    %eax,%edx
ffff8000001080c4:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001080c7:	01 d0                	add    %edx,%eax
ffff8000001080c9:	89 c2                	mov    %eax,%edx
ffff8000001080cb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080d2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080d6:	48 8b 00             	mov    (%rax),%rax
ffff8000001080d9:	48 39 d0             	cmp    %rdx,%rax
ffff8000001080dc:	73 09                	jae    ffff8000001080e7 <argptr+0x72>
    return -1;
ffff8000001080de:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff8000001080e5:	eb 13                	jmp    ffff8000001080fa <argptr+0x85>
  *pp = (char*)i;
ffff8000001080e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080eb:	48 89 c2             	mov    %rax,%rdx
ffff8000001080ee:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001080f2:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff8000001080f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001080fa:	c9                   	leave
ffff8000001080fb:	c3                   	ret

ffff8000001080fc <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff8000001080fc:	55                   	push   %rbp
ffff8000001080fd:	48 89 e5             	mov    %rsp,%rbp
ffff800000108100:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108104:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108107:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff80000010810b:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff80000010810f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108112:	48 89 d6             	mov    %rdx,%rsi
ffff800000108115:	89 c7                	mov    %eax,%edi
ffff800000108117:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff80000010811e:	80 ff ff 
ffff800000108121:	ff d0                	call   *%rax
ffff800000108123:	85 c0                	test   %eax,%eax
ffff800000108125:	79 07                	jns    ffff80000010812e <argstr+0x32>
    return -1;
ffff800000108127:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010812c:	eb 1b                	jmp    ffff800000108149 <argstr+0x4d>
  return fetchstr(addr, pp);
ffff80000010812e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108131:	48 98                	cltq
ffff800000108133:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000108137:	48 89 d6             	mov    %rdx,%rsi
ffff80000010813a:	48 89 c7             	mov    %rax,%rdi
ffff80000010813d:	48 b8 86 7e 10 00 00 	movabs $0xffff800000107e86,%rax
ffff800000108144:	80 ff ff 
ffff800000108147:	ff d0                	call   *%rax
}
ffff800000108149:	c9                   	leave
ffff80000010814a:	c3                   	ret

ffff80000010814b <syscall>:
  [SYS_vidputs] "vidputs",
};

void
syscall(struct trapframe *tf)
{
ffff80000010814b:	55                   	push   %rbp
ffff80000010814c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010814f:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108153:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  proc->tf = tf;
ffff800000108157:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010815e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108162:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108166:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff80000010816a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108171:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108175:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108179:	48 8b 00             	mov    (%rax),%rax
ffff80000010817c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff800000108180:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108185:	0f 84 b6 00 00 00    	je     ffff800000108241 <syscall+0xf6>
ffff80000010818b:	48 83 7d f8 19       	cmpq   $0x19,-0x8(%rbp)
ffff800000108190:	0f 87 ab 00 00 00    	ja     ffff800000108241 <syscall+0xf6>
ffff800000108196:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff80000010819d:	80 ff ff 
ffff8000001081a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081a4:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001081a8:	48 85 c0             	test   %rax,%rax
ffff8000001081ab:	0f 84 90 00 00 00    	je     ffff800000108241 <syscall+0xf6>
    tf->rax = syscalls[num]();
ffff8000001081b1:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001081b8:	80 ff ff 
ffff8000001081bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081bf:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001081c3:	ff d0                	call   *%rax
ffff8000001081c5:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001081c9:	48 89 02             	mov    %rax,(%rdx)

    //call trace event function 
    if(num != SYS_traceread && num != SYS_vidclear && num != SYS_vidputc && num != SYS_vidputs)
ffff8000001081cc:	48 83 7d f8 16       	cmpq   $0x16,-0x8(%rbp)
ffff8000001081d1:	0f 84 bf 00 00 00    	je     ffff800000108296 <syscall+0x14b>
ffff8000001081d7:	48 83 7d f8 17       	cmpq   $0x17,-0x8(%rbp)
ffff8000001081dc:	0f 84 b4 00 00 00    	je     ffff800000108296 <syscall+0x14b>
ffff8000001081e2:	48 83 7d f8 18       	cmpq   $0x18,-0x8(%rbp)
ffff8000001081e7:	0f 84 a9 00 00 00    	je     ffff800000108296 <syscall+0x14b>
ffff8000001081ed:	48 83 7d f8 19       	cmpq   $0x19,-0x8(%rbp)
ffff8000001081f2:	0f 84 9e 00 00 00    	je     ffff800000108296 <syscall+0x14b>
      traceevent(TRACE_TYPE_SYSCALL, proc->pid, num, tf->rax, syscallnames[num]);
ffff8000001081f8:	48 ba 80 d6 10 00 00 	movabs $0xffff80000010d680,%rdx
ffff8000001081ff:	80 ff ff 
ffff800000108202:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108206:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff80000010820a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010820e:	48 8b 00             	mov    (%rax),%rax
ffff800000108211:	89 c1                	mov    %eax,%ecx
ffff800000108213:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108217:	89 c6                	mov    %eax,%esi
ffff800000108219:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108220:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108224:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000108227:	49 89 d0             	mov    %rdx,%r8
ffff80000010822a:	89 f2                	mov    %esi,%edx
ffff80000010822c:	89 c6                	mov    %eax,%esi
ffff80000010822e:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108233:	48 b8 66 c1 10 00 00 	movabs $0xffff80000010c166,%rax
ffff80000010823a:	80 ff ff 
ffff80000010823d:	ff d0                	call   *%rax
    if(num != SYS_traceread && num != SYS_vidclear && num != SYS_vidputc && num != SYS_vidputs)
ffff80000010823f:	eb 55                	jmp    ffff800000108296 <syscall+0x14b>

    // DEBUG: Print the PID, system call number, and the return value from the syscall
    // cprintf("trace: pid %d syscall %s(%d) -> %d\n", proc->pid, syscallnames[num], num, tf->rax);
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff800000108241:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108248:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010824c:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000108253:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010825a:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff80000010825e:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000108261:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108265:	48 bf 33 c9 10 00 00 	movabs $0xffff80000010c933,%rdi
ffff80000010826c:	80 ff ff 
ffff80000010826f:	48 89 d1             	mov    %rdx,%rcx
ffff800000108272:	48 89 f2             	mov    %rsi,%rdx
ffff800000108275:	89 c6                	mov    %eax,%esi
ffff800000108277:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010827c:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000108283:	80 ff ff 
ffff800000108286:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff800000108289:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010828d:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
ffff800000108294:	eb 01                	jmp    ffff800000108297 <syscall+0x14c>
    if(num != SYS_traceread && num != SYS_vidclear && num != SYS_vidputc && num != SYS_vidputs)
ffff800000108296:	90                   	nop
  }
  if (proc->killed)
ffff800000108297:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010829e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082a2:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001082a5:	85 c0                	test   %eax,%eax
ffff8000001082a7:	74 0c                	je     ffff8000001082b5 <syscall+0x16a>
    exit();
ffff8000001082a9:	48 b8 03 6a 10 00 00 	movabs $0xffff800000106a03,%rax
ffff8000001082b0:	80 ff ff 
ffff8000001082b3:	ff d0                	call   *%rax
}
ffff8000001082b5:	90                   	nop
ffff8000001082b6:	c9                   	leave
ffff8000001082b7:	c3                   	ret

ffff8000001082b8 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffff8000001082b8:	55                   	push   %rbp
ffff8000001082b9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001082bc:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001082c0:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001082c3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001082c7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffff8000001082cb:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff8000001082cf:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001082d2:	48 89 d6             	mov    %rdx,%rsi
ffff8000001082d5:	89 c7                	mov    %eax,%edi
ffff8000001082d7:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff8000001082de:	80 ff ff 
ffff8000001082e1:	ff d0                	call   *%rax
ffff8000001082e3:	85 c0                	test   %eax,%eax
ffff8000001082e5:	79 07                	jns    ffff8000001082ee <argfd+0x36>
    return -1;
ffff8000001082e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001082ec:	eb 62                	jmp    ffff800000108350 <argfd+0x98>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffff8000001082ee:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001082f1:	85 c0                	test   %eax,%eax
ffff8000001082f3:	78 2d                	js     ffff800000108322 <argfd+0x6a>
ffff8000001082f5:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001082f8:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001082fb:	7f 25                	jg     ffff800000108322 <argfd+0x6a>
ffff8000001082fd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108304:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108308:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010830b:	48 63 d2             	movslq %edx,%rdx
ffff80000010830e:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108312:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000108317:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010831b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108320:	75 07                	jne    ffff800000108329 <argfd+0x71>
    return -1;
ffff800000108322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108327:	eb 27                	jmp    ffff800000108350 <argfd+0x98>
  if(pfd)
ffff800000108329:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010832e:	74 09                	je     ffff800000108339 <argfd+0x81>
    *pfd = fd;
ffff800000108330:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108333:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108337:	89 10                	mov    %edx,(%rax)
  if(pf)
ffff800000108339:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff80000010833e:	74 0b                	je     ffff80000010834b <argfd+0x93>
    *pf = f;
ffff800000108340:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108344:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108348:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff80000010834b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108350:	c9                   	leave
ffff800000108351:	c3                   	ret

ffff800000108352 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffff800000108352:	55                   	push   %rbp
ffff800000108353:	48 89 e5             	mov    %rsp,%rbp
ffff800000108356:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010835a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffff80000010835e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000108365:	eb 46                	jmp    ffff8000001083ad <fdalloc+0x5b>
    if(proc->ofile[fd] == 0){
ffff800000108367:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010836e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108372:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108375:	48 63 d2             	movslq %edx,%rdx
ffff800000108378:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010837c:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000108381:	48 85 c0             	test   %rax,%rax
ffff800000108384:	75 23                	jne    ffff8000001083a9 <fdalloc+0x57>
      proc->ofile[fd] = f;
ffff800000108386:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010838d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108391:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108394:	48 63 d2             	movslq %edx,%rdx
ffff800000108397:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff80000010839b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010839f:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffff8000001083a4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001083a7:	eb 0f                	jmp    ffff8000001083b8 <fdalloc+0x66>
  for(fd = 0; fd < NOFILE; fd++){
ffff8000001083a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001083ad:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff8000001083b1:	7e b4                	jle    ffff800000108367 <fdalloc+0x15>
    }
  }
  return -1;
ffff8000001083b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001083b8:	c9                   	leave
ffff8000001083b9:	c3                   	ret

ffff8000001083ba <sys_dup>:

int
sys_dup(void)
{
ffff8000001083ba:	55                   	push   %rbp
ffff8000001083bb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001083be:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
ffff8000001083c2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001083c6:	48 89 c2             	mov    %rax,%rdx
ffff8000001083c9:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001083ce:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001083d3:	48 b8 b8 82 10 00 00 	movabs $0xffff8000001082b8,%rax
ffff8000001083da:	80 ff ff 
ffff8000001083dd:	ff d0                	call   *%rax
ffff8000001083df:	85 c0                	test   %eax,%eax
ffff8000001083e1:	79 07                	jns    ffff8000001083ea <sys_dup+0x30>
    return -1;
ffff8000001083e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001083e8:	eb 39                	jmp    ffff800000108423 <sys_dup+0x69>
  if((fd=fdalloc(f)) < 0)
ffff8000001083ea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001083ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001083f1:	48 b8 52 83 10 00 00 	movabs $0xffff800000108352,%rax
ffff8000001083f8:	80 ff ff 
ffff8000001083fb:	ff d0                	call   *%rax
ffff8000001083fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000108400:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108404:	79 07                	jns    ffff80000010840d <sys_dup+0x53>
    return -1;
ffff800000108406:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010840b:	eb 16                	jmp    ffff800000108423 <sys_dup+0x69>
  filedup(f);
ffff80000010840d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108411:	48 89 c7             	mov    %rax,%rdi
ffff800000108414:	48 b8 0d 1d 10 00 00 	movabs $0xffff800000101d0d,%rax
ffff80000010841b:	80 ff ff 
ffff80000010841e:	ff d0                	call   *%rax
  return fd;
ffff800000108420:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000108423:	c9                   	leave
ffff800000108424:	c3                   	ret

ffff800000108425 <sys_read>:

int
sys_read(void)
{
ffff800000108425:	55                   	push   %rbp
ffff800000108426:	48 89 e5             	mov    %rsp,%rbp
ffff800000108429:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff80000010842d:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108431:	48 89 c2             	mov    %rax,%rdx
ffff800000108434:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108439:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010843e:	48 b8 b8 82 10 00 00 	movabs $0xffff8000001082b8,%rax
ffff800000108445:	80 ff ff 
ffff800000108448:	ff d0                	call   *%rax
ffff80000010844a:	85 c0                	test   %eax,%eax
ffff80000010844c:	78 56                	js     ffff8000001084a4 <sys_read+0x7f>
ffff80000010844e:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff800000108452:	48 89 c6             	mov    %rax,%rsi
ffff800000108455:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010845a:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000108461:	80 ff ff 
ffff800000108464:	ff d0                	call   *%rax
ffff800000108466:	85 c0                	test   %eax,%eax
ffff800000108468:	78 3a                	js     ffff8000001084a4 <sys_read+0x7f>
ffff80000010846a:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010846d:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000108471:	48 89 c6             	mov    %rax,%rsi
ffff800000108474:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108479:	48 b8 75 80 10 00 00 	movabs $0xffff800000108075,%rax
ffff800000108480:	80 ff ff 
ffff800000108483:	ff d0                	call   *%rax
    return -1;
  return fileread(f, p, n);
ffff800000108485:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108488:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff80000010848c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108490:	48 89 ce             	mov    %rcx,%rsi
ffff800000108493:	48 89 c7             	mov    %rax,%rdi
ffff800000108496:	48 b8 37 1f 10 00 00 	movabs $0xffff800000101f37,%rax
ffff80000010849d:	80 ff ff 
ffff8000001084a0:	ff d0                	call   *%rax
ffff8000001084a2:	eb 05                	jmp    ffff8000001084a9 <sys_read+0x84>
    return -1;
ffff8000001084a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001084a9:	c9                   	leave
ffff8000001084aa:	c3                   	ret

ffff8000001084ab <sys_write>:

int
sys_write(void)
{
ffff8000001084ab:	55                   	push   %rbp
ffff8000001084ac:	48 89 e5             	mov    %rsp,%rbp
ffff8000001084af:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff8000001084b3:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001084b7:	48 89 c2             	mov    %rax,%rdx
ffff8000001084ba:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001084bf:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001084c4:	48 b8 b8 82 10 00 00 	movabs $0xffff8000001082b8,%rax
ffff8000001084cb:	80 ff ff 
ffff8000001084ce:	ff d0                	call   *%rax
ffff8000001084d0:	85 c0                	test   %eax,%eax
ffff8000001084d2:	78 56                	js     ffff80000010852a <sys_write+0x7f>
ffff8000001084d4:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff8000001084d8:	48 89 c6             	mov    %rax,%rsi
ffff8000001084db:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001084e0:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff8000001084e7:	80 ff ff 
ffff8000001084ea:	ff d0                	call   *%rax
ffff8000001084ec:	85 c0                	test   %eax,%eax
ffff8000001084ee:	78 3a                	js     ffff80000010852a <sys_write+0x7f>
ffff8000001084f0:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001084f3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001084f7:	48 89 c6             	mov    %rax,%rsi
ffff8000001084fa:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001084ff:	48 b8 75 80 10 00 00 	movabs $0xffff800000108075,%rax
ffff800000108506:	80 ff ff 
ffff800000108509:	ff d0                	call   *%rax
    return -1;
  return filewrite(f, p, n);
ffff80000010850b:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010850e:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108512:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108516:	48 89 ce             	mov    %rcx,%rsi
ffff800000108519:	48 89 c7             	mov    %rax,%rdi
ffff80000010851c:	48 b8 2b 20 10 00 00 	movabs $0xffff80000010202b,%rax
ffff800000108523:	80 ff ff 
ffff800000108526:	ff d0                	call   *%rax
ffff800000108528:	eb 05                	jmp    ffff80000010852f <sys_write+0x84>
    return -1;
ffff80000010852a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010852f:	c9                   	leave
ffff800000108530:	c3                   	ret

ffff800000108531 <sys_close>:

int
sys_close(void)
{
ffff800000108531:	55                   	push   %rbp
ffff800000108532:	48 89 e5             	mov    %rsp,%rbp
ffff800000108535:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
ffff800000108539:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff80000010853d:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000108541:	48 89 c6             	mov    %rax,%rsi
ffff800000108544:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108549:	48 b8 b8 82 10 00 00 	movabs $0xffff8000001082b8,%rax
ffff800000108550:	80 ff ff 
ffff800000108553:	ff d0                	call   *%rax
ffff800000108555:	85 c0                	test   %eax,%eax
ffff800000108557:	79 07                	jns    ffff800000108560 <sys_close+0x2f>
    return -1;
ffff800000108559:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010855e:	eb 36                	jmp    ffff800000108596 <sys_close+0x65>
  proc->ofile[fd] = 0;
ffff800000108560:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108567:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010856b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010856e:	48 63 d2             	movslq %edx,%rdx
ffff800000108571:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108575:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff80000010857c:	00 00 
  fileclose(f);
ffff80000010857e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108582:	48 89 c7             	mov    %rax,%rdi
ffff800000108585:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff80000010858c:	80 ff ff 
ffff80000010858f:	ff d0                	call   *%rax
  return 0;
ffff800000108591:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108596:	c9                   	leave
ffff800000108597:	c3                   	ret

ffff800000108598 <sys_fstat>:

int
sys_fstat(void)
{
ffff800000108598:	55                   	push   %rbp
ffff800000108599:	48 89 e5             	mov    %rsp,%rbp
ffff80000010859c:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffff8000001085a0:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001085a4:	48 89 c2             	mov    %rax,%rdx
ffff8000001085a7:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001085ac:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001085b1:	48 b8 b8 82 10 00 00 	movabs $0xffff8000001082b8,%rax
ffff8000001085b8:	80 ff ff 
ffff8000001085bb:	ff d0                	call   *%rax
ffff8000001085bd:	85 c0                	test   %eax,%eax
ffff8000001085bf:	78 39                	js     ffff8000001085fa <sys_fstat+0x62>
ffff8000001085c1:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001085c5:	ba 14 00 00 00       	mov    $0x14,%edx
ffff8000001085ca:	48 89 c6             	mov    %rax,%rsi
ffff8000001085cd:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001085d2:	48 b8 75 80 10 00 00 	movabs $0xffff800000108075,%rax
ffff8000001085d9:	80 ff ff 
ffff8000001085dc:	ff d0                	call   *%rax
    return -1;
  return filestat(f, st);
ffff8000001085de:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001085e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085e6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001085e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001085ec:	48 b8 c2 1e 10 00 00 	movabs $0xffff800000101ec2,%rax
ffff8000001085f3:	80 ff ff 
ffff8000001085f6:	ff d0                	call   *%rax
ffff8000001085f8:	eb 05                	jmp    ffff8000001085ff <sys_fstat+0x67>
    return -1;
ffff8000001085fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001085ff:	c9                   	leave
ffff800000108600:	c3                   	ret

ffff800000108601 <isdirempty>:

static int
isdirempty(struct inode *dp)
{
ffff800000108601:	55                   	push   %rbp
ffff800000108602:	48 89 e5             	mov    %rsp,%rbp
ffff800000108605:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108609:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff80000010860d:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff800000108614:	eb 56                	jmp    ffff80000010866c <isdirempty+0x6b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000108616:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108619:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff80000010861d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108621:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000108626:	48 89 c7             	mov    %rax,%rdi
ffff800000108629:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff800000108630:	80 ff ff 
ffff800000108633:	ff d0                	call   *%rax
ffff800000108635:	83 f8 10             	cmp    $0x10,%eax
ffff800000108638:	74 19                	je     ffff800000108653 <isdirempty+0x52>
      panic("isdirempty: readi");
ffff80000010863a:	48 b8 4f c9 10 00 00 	movabs $0xffff80000010c94f,%rax
ffff800000108641:	80 ff ff 
ffff800000108644:	48 89 c7             	mov    %rax,%rdi
ffff800000108647:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010864e:	80 ff ff 
ffff800000108651:	ff d0                	call   *%rax
    if(de.inum != 0)
ffff800000108653:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff800000108657:	66 85 c0             	test   %ax,%ax
ffff80000010865a:	74 07                	je     ffff800000108663 <isdirempty+0x62>
      return 0;
ffff80000010865c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108661:	eb 1f                	jmp    ffff800000108682 <isdirempty+0x81>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000108663:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108666:	83 c0 10             	add    $0x10,%eax
ffff800000108669:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010866c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108670:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000108676:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108679:	39 c2                	cmp    %eax,%edx
ffff80000010867b:	72 99                	jb     ffff800000108616 <isdirempty+0x15>
  }
  return 1;
ffff80000010867d:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffff800000108682:	c9                   	leave
ffff800000108683:	c3                   	ret

ffff800000108684 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffff800000108684:	55                   	push   %rbp
ffff800000108685:	48 89 e5             	mov    %rsp,%rbp
ffff800000108688:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffff80000010868c:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000108690:	48 89 c6             	mov    %rax,%rsi
ffff800000108693:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108698:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff80000010869f:	80 ff ff 
ffff8000001086a2:	ff d0                	call   *%rax
ffff8000001086a4:	85 c0                	test   %eax,%eax
ffff8000001086a6:	78 1c                	js     ffff8000001086c4 <sys_link+0x40>
ffff8000001086a8:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff8000001086ac:	48 89 c6             	mov    %rax,%rsi
ffff8000001086af:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001086b4:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff8000001086bb:	80 ff ff 
ffff8000001086be:	ff d0                	call   *%rax
ffff8000001086c0:	85 c0                	test   %eax,%eax
ffff8000001086c2:	79 0a                	jns    ffff8000001086ce <sys_link+0x4a>
    return -1;
ffff8000001086c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086c9:	e9 f3 01 00 00       	jmp    ffff8000001088c1 <sys_link+0x23d>

  begin_op();
ffff8000001086ce:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff8000001086d5:	80 ff ff 
ffff8000001086d8:	ff d0                	call   *%rax
  if((ip = namei(old)) == 0){
ffff8000001086da:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001086de:	48 89 c7             	mov    %rax,%rdi
ffff8000001086e1:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff8000001086e8:	80 ff ff 
ffff8000001086eb:	ff d0                	call   *%rax
ffff8000001086ed:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001086f1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001086f6:	75 16                	jne    ffff80000010870e <sys_link+0x8a>
    end_op();
ffff8000001086f8:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff8000001086ff:	80 ff ff 
ffff800000108702:	ff d0                	call   *%rax
    return -1;
ffff800000108704:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108709:	e9 b3 01 00 00       	jmp    ffff8000001088c1 <sys_link+0x23d>
  }

  ilock(ip);
ffff80000010870e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108712:	48 89 c7             	mov    %rax,%rdi
ffff800000108715:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff80000010871c:	80 ff ff 
ffff80000010871f:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108721:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108725:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010872c:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108730:	75 29                	jne    ffff80000010875b <sys_link+0xd7>
    iunlockput(ip);
ffff800000108732:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108736:	48 89 c7             	mov    %rax,%rdi
ffff800000108739:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108740:	80 ff ff 
ffff800000108743:	ff d0                	call   *%rax
    end_op();
ffff800000108745:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff80000010874c:	80 ff ff 
ffff80000010874f:	ff d0                	call   *%rax
    return -1;
ffff800000108751:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108756:	e9 66 01 00 00       	jmp    ffff8000001088c1 <sys_link+0x23d>
  }

  ip->nlink++;
ffff80000010875b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010875f:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108766:	83 c0 01             	add    $0x1,%eax
ffff800000108769:	89 c2                	mov    %eax,%edx
ffff80000010876b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010876f:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108776:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010877a:	48 89 c7             	mov    %rax,%rdi
ffff80000010877d:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108784:	80 ff ff 
ffff800000108787:	ff d0                	call   *%rax
  iunlock(ip);
ffff800000108789:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010878d:	48 89 c7             	mov    %rax,%rdi
ffff800000108790:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000108797:	80 ff ff 
ffff80000010879a:	ff d0                	call   *%rax

  if((dp = nameiparent(new, name)) == 0)
ffff80000010879c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001087a0:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff8000001087a4:	48 89 d6             	mov    %rdx,%rsi
ffff8000001087a7:	48 89 c7             	mov    %rax,%rdi
ffff8000001087aa:	48 b8 e5 38 10 00 00 	movabs $0xffff8000001038e5,%rax
ffff8000001087b1:	80 ff ff 
ffff8000001087b4:	ff d0                	call   *%rax
ffff8000001087b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001087ba:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001087bf:	0f 84 96 00 00 00    	je     ffff80000010885b <sys_link+0x1d7>
    goto bad;
  ilock(dp);
ffff8000001087c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001087cc:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001087d3:	80 ff ff 
ffff8000001087d6:	ff d0                	call   *%rax
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffff8000001087d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087dc:	8b 10                	mov    (%rax),%edx
ffff8000001087de:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087e2:	8b 00                	mov    (%rax),%eax
ffff8000001087e4:	39 c2                	cmp    %eax,%edx
ffff8000001087e6:	75 25                	jne    ffff80000010880d <sys_link+0x189>
ffff8000001087e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087ec:	8b 50 04             	mov    0x4(%rax),%edx
ffff8000001087ef:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff8000001087f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087f7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001087fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001087fd:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108804:	80 ff ff 
ffff800000108807:	ff d0                	call   *%rax
ffff800000108809:	85 c0                	test   %eax,%eax
ffff80000010880b:	79 15                	jns    ffff800000108822 <sys_link+0x19e>
    iunlockput(dp);
ffff80000010880d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108811:	48 89 c7             	mov    %rax,%rdi
ffff800000108814:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010881b:	80 ff ff 
ffff80000010881e:	ff d0                	call   *%rax
    goto bad;
ffff800000108820:	eb 3a                	jmp    ffff80000010885c <sys_link+0x1d8>
  }
  iunlockput(dp);
ffff800000108822:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108826:	48 89 c7             	mov    %rax,%rdi
ffff800000108829:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108830:	80 ff ff 
ffff800000108833:	ff d0                	call   *%rax
  iput(ip);
ffff800000108835:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108839:	48 89 c7             	mov    %rax,%rdi
ffff80000010883c:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000108843:	80 ff ff 
ffff800000108846:	ff d0                	call   *%rax

  end_op();
ffff800000108848:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff80000010884f:	80 ff ff 
ffff800000108852:	ff d0                	call   *%rax

  return 0;
ffff800000108854:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108859:	eb 66                	jmp    ffff8000001088c1 <sys_link+0x23d>
    goto bad;
ffff80000010885b:	90                   	nop

bad:
  ilock(ip);
ffff80000010885c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108860:	48 89 c7             	mov    %rax,%rdi
ffff800000108863:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff80000010886a:	80 ff ff 
ffff80000010886d:	ff d0                	call   *%rax
  ip->nlink--;
ffff80000010886f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108873:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010887a:	83 e8 01             	sub    $0x1,%eax
ffff80000010887d:	89 c2                	mov    %eax,%edx
ffff80000010887f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108883:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff80000010888a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010888e:	48 89 c7             	mov    %rax,%rdi
ffff800000108891:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108898:	80 ff ff 
ffff80000010889b:	ff d0                	call   *%rax
  iunlockput(ip);
ffff80000010889d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088a1:	48 89 c7             	mov    %rax,%rdi
ffff8000001088a4:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff8000001088ab:	80 ff ff 
ffff8000001088ae:	ff d0                	call   *%rax
  end_op();
ffff8000001088b0:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff8000001088b7:	80 ff ff 
ffff8000001088ba:	ff d0                	call   *%rax
  return -1;
ffff8000001088bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001088c1:	c9                   	leave
ffff8000001088c2:	c3                   	ret

ffff8000001088c3 <sys_unlink>:
//PAGEBREAK!

int
sys_unlink(void)
{
ffff8000001088c3:	55                   	push   %rbp
ffff8000001088c4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001088c7:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffff8000001088cb:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff8000001088cf:	48 89 c6             	mov    %rax,%rsi
ffff8000001088d2:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001088d7:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff8000001088de:	80 ff ff 
ffff8000001088e1:	ff d0                	call   *%rax
ffff8000001088e3:	85 c0                	test   %eax,%eax
ffff8000001088e5:	79 0a                	jns    ffff8000001088f1 <sys_unlink+0x2e>
    return -1;
ffff8000001088e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001088ec:	e9 7b 02 00 00       	jmp    ffff800000108b6c <sys_unlink+0x2a9>

  begin_op();
ffff8000001088f1:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff8000001088f8:	80 ff ff 
ffff8000001088fb:	ff d0                	call   *%rax
  if((dp = nameiparent(path, name)) == 0){
ffff8000001088fd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108901:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff800000108905:	48 89 d6             	mov    %rdx,%rsi
ffff800000108908:	48 89 c7             	mov    %rax,%rdi
ffff80000010890b:	48 b8 e5 38 10 00 00 	movabs $0xffff8000001038e5,%rax
ffff800000108912:	80 ff ff 
ffff800000108915:	ff d0                	call   *%rax
ffff800000108917:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010891b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108920:	75 16                	jne    ffff800000108938 <sys_unlink+0x75>
    end_op();
ffff800000108922:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108929:	80 ff ff 
ffff80000010892c:	ff d0                	call   *%rax
    return -1;
ffff80000010892e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108933:	e9 34 02 00 00       	jmp    ffff800000108b6c <sys_unlink+0x2a9>
  }

  ilock(dp);
ffff800000108938:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010893c:	48 89 c7             	mov    %rax,%rdi
ffff80000010893f:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108946:	80 ff ff 
ffff800000108949:	ff d0                	call   *%rax

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffff80000010894b:	48 ba 61 c9 10 00 00 	movabs $0xffff80000010c961,%rdx
ffff800000108952:	80 ff ff 
ffff800000108955:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000108959:	48 89 d6             	mov    %rdx,%rsi
ffff80000010895c:	48 89 c7             	mov    %rax,%rdi
ffff80000010895f:	48 b8 fa 33 10 00 00 	movabs $0xffff8000001033fa,%rax
ffff800000108966:	80 ff ff 
ffff800000108969:	ff d0                	call   *%rax
ffff80000010896b:	85 c0                	test   %eax,%eax
ffff80000010896d:	0f 84 d1 01 00 00    	je     ffff800000108b44 <sys_unlink+0x281>
ffff800000108973:	48 ba 63 c9 10 00 00 	movabs $0xffff80000010c963,%rdx
ffff80000010897a:	80 ff ff 
ffff80000010897d:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff800000108981:	48 89 d6             	mov    %rdx,%rsi
ffff800000108984:	48 89 c7             	mov    %rax,%rdi
ffff800000108987:	48 b8 fa 33 10 00 00 	movabs $0xffff8000001033fa,%rax
ffff80000010898e:	80 ff ff 
ffff800000108991:	ff d0                	call   *%rax
ffff800000108993:	85 c0                	test   %eax,%eax
ffff800000108995:	0f 84 a9 01 00 00    	je     ffff800000108b44 <sys_unlink+0x281>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffff80000010899b:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff80000010899f:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff8000001089a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001089a7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001089aa:	48 89 c7             	mov    %rax,%rdi
ffff8000001089ad:	48 b8 2b 34 10 00 00 	movabs $0xffff80000010342b,%rax
ffff8000001089b4:	80 ff ff 
ffff8000001089b7:	ff d0                	call   *%rax
ffff8000001089b9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001089bd:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001089c2:	0f 84 7f 01 00 00    	je     ffff800000108b47 <sys_unlink+0x284>
    goto bad;
  ilock(ip);
ffff8000001089c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001089cf:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001089d6:	80 ff ff 
ffff8000001089d9:	ff d0                	call   *%rax

  if(ip->nlink < 1)
ffff8000001089db:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089df:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001089e6:	66 85 c0             	test   %ax,%ax
ffff8000001089e9:	7f 19                	jg     ffff800000108a04 <sys_unlink+0x141>
    panic("unlink: nlink < 1");
ffff8000001089eb:	48 b8 66 c9 10 00 00 	movabs $0xffff80000010c966,%rax
ffff8000001089f2:	80 ff ff 
ffff8000001089f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001089f8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001089ff:	80 ff ff 
ffff800000108a02:	ff d0                	call   *%rax
  if(ip->type == T_DIR && !isdirempty(ip)){
ffff800000108a04:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a08:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108a0f:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108a13:	75 2f                	jne    ffff800000108a44 <sys_unlink+0x181>
ffff800000108a15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a19:	48 89 c7             	mov    %rax,%rdi
ffff800000108a1c:	48 b8 01 86 10 00 00 	movabs $0xffff800000108601,%rax
ffff800000108a23:	80 ff ff 
ffff800000108a26:	ff d0                	call   *%rax
ffff800000108a28:	85 c0                	test   %eax,%eax
ffff800000108a2a:	75 18                	jne    ffff800000108a44 <sys_unlink+0x181>
    iunlockput(ip);
ffff800000108a2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a30:	48 89 c7             	mov    %rax,%rdi
ffff800000108a33:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108a3a:	80 ff ff 
ffff800000108a3d:	ff d0                	call   *%rax
    goto bad;
ffff800000108a3f:	e9 04 01 00 00       	jmp    ffff800000108b48 <sys_unlink+0x285>
  }

  memset(&de, 0, sizeof(de));
ffff800000108a44:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108a48:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000108a4d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108a52:	48 89 c7             	mov    %rax,%rdi
ffff800000108a55:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff800000108a5c:	80 ff ff 
ffff800000108a5f:	ff d0                	call   *%rax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff800000108a61:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000108a64:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a6c:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000108a71:	48 89 c7             	mov    %rax,%rdi
ffff800000108a74:	48 b8 ea 31 10 00 00 	movabs $0xffff8000001031ea,%rax
ffff800000108a7b:	80 ff ff 
ffff800000108a7e:	ff d0                	call   *%rax
ffff800000108a80:	83 f8 10             	cmp    $0x10,%eax
ffff800000108a83:	74 19                	je     ffff800000108a9e <sys_unlink+0x1db>
    panic("unlink: writei");
ffff800000108a85:	48 b8 78 c9 10 00 00 	movabs $0xffff80000010c978,%rax
ffff800000108a8c:	80 ff ff 
ffff800000108a8f:	48 89 c7             	mov    %rax,%rdi
ffff800000108a92:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108a99:	80 ff ff 
ffff800000108a9c:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108a9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108aa2:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108aa9:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108aad:	75 2e                	jne    ffff800000108add <sys_unlink+0x21a>
    dp->nlink--;
ffff800000108aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ab3:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108aba:	83 e8 01             	sub    $0x1,%eax
ffff800000108abd:	89 c2                	mov    %eax,%edx
ffff800000108abf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ac3:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108aca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ace:	48 89 c7             	mov    %rax,%rdi
ffff800000108ad1:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108ad8:	80 ff ff 
ffff800000108adb:	ff d0                	call   *%rax
  }
  iunlockput(dp);
ffff800000108add:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ae1:	48 89 c7             	mov    %rax,%rdi
ffff800000108ae4:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108aeb:	80 ff ff 
ffff800000108aee:	ff d0                	call   *%rax

  ip->nlink--;
ffff800000108af0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108af4:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108afb:	83 e8 01             	sub    $0x1,%eax
ffff800000108afe:	89 c2                	mov    %eax,%edx
ffff800000108b00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b04:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108b0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b0f:	48 89 c7             	mov    %rax,%rdi
ffff800000108b12:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108b19:	80 ff ff 
ffff800000108b1c:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108b1e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b22:	48 89 c7             	mov    %rax,%rdi
ffff800000108b25:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108b2c:	80 ff ff 
ffff800000108b2f:	ff d0                	call   *%rax

  end_op();
ffff800000108b31:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108b38:	80 ff ff 
ffff800000108b3b:	ff d0                	call   *%rax

  return 0;
ffff800000108b3d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b42:	eb 28                	jmp    ffff800000108b6c <sys_unlink+0x2a9>
    goto bad;
ffff800000108b44:	90                   	nop
ffff800000108b45:	eb 01                	jmp    ffff800000108b48 <sys_unlink+0x285>
    goto bad;
ffff800000108b47:	90                   	nop

bad:
  iunlockput(dp);
ffff800000108b48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b4c:	48 89 c7             	mov    %rax,%rdi
ffff800000108b4f:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108b56:	80 ff ff 
ffff800000108b59:	ff d0                	call   *%rax
  end_op();
ffff800000108b5b:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108b62:	80 ff ff 
ffff800000108b65:	ff d0                	call   *%rax
  return -1;
ffff800000108b67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108b6c:	c9                   	leave
ffff800000108b6d:	c3                   	ret

ffff800000108b6e <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffff800000108b6e:	55                   	push   %rbp
ffff800000108b6f:	48 89 e5             	mov    %rsp,%rbp
ffff800000108b72:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000108b76:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000108b7a:	89 c8                	mov    %ecx,%eax
ffff800000108b7c:	89 f1                	mov    %esi,%ecx
ffff800000108b7e:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff800000108b82:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff800000108b86:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffff800000108b8a:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff800000108b8e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108b92:	48 89 d6             	mov    %rdx,%rsi
ffff800000108b95:	48 89 c7             	mov    %rax,%rdi
ffff800000108b98:	48 b8 e5 38 10 00 00 	movabs $0xffff8000001038e5,%rax
ffff800000108b9f:	80 ff ff 
ffff800000108ba2:	ff d0                	call   *%rax
ffff800000108ba4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108ba8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108bad:	75 0a                	jne    ffff800000108bb9 <create+0x4b>
    return 0;
ffff800000108baf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108bb4:	e9 2c 02 00 00       	jmp    ffff800000108de5 <create+0x277>
  ilock(dp);
ffff800000108bb9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bbd:	48 89 c7             	mov    %rax,%rdi
ffff800000108bc0:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108bc7:	80 ff ff 
ffff800000108bca:	ff d0                	call   *%rax

  if((ip = dirlookup(dp, name, &off)) != 0){
ffff800000108bcc:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff800000108bd0:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108bd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bd8:	48 89 ce             	mov    %rcx,%rsi
ffff800000108bdb:	48 89 c7             	mov    %rax,%rdi
ffff800000108bde:	48 b8 2b 34 10 00 00 	movabs $0xffff80000010342b,%rax
ffff800000108be5:	80 ff ff 
ffff800000108be8:	ff d0                	call   *%rax
ffff800000108bea:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108bee:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108bf3:	74 64                	je     ffff800000108c59 <create+0xeb>
    iunlockput(dp);
ffff800000108bf5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108bf9:	48 89 c7             	mov    %rax,%rdi
ffff800000108bfc:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108c03:	80 ff ff 
ffff800000108c06:	ff d0                	call   *%rax
    ilock(ip);
ffff800000108c08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c0c:	48 89 c7             	mov    %rax,%rdi
ffff800000108c0f:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108c16:	80 ff ff 
ffff800000108c19:	ff d0                	call   *%rax
    if(type == T_FILE && ip->type == T_FILE)
ffff800000108c1b:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff800000108c20:	75 1a                	jne    ffff800000108c3c <create+0xce>
ffff800000108c22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c26:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108c2d:	66 83 f8 02          	cmp    $0x2,%ax
ffff800000108c31:	75 09                	jne    ffff800000108c3c <create+0xce>
      return ip;
ffff800000108c33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c37:	e9 a9 01 00 00       	jmp    ffff800000108de5 <create+0x277>
    iunlockput(ip);
ffff800000108c3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c40:	48 89 c7             	mov    %rax,%rdi
ffff800000108c43:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108c4a:	80 ff ff 
ffff800000108c4d:	ff d0                	call   *%rax
    return 0;
ffff800000108c4f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108c54:	e9 8c 01 00 00       	jmp    ffff800000108de5 <create+0x277>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffff800000108c59:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff800000108c5d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c61:	8b 00                	mov    (%rax),%eax
ffff800000108c63:	89 d6                	mov    %edx,%esi
ffff800000108c65:	89 c7                	mov    %eax,%edi
ffff800000108c67:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108c6e:	80 ff ff 
ffff800000108c71:	ff d0                	call   *%rax
ffff800000108c73:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108c77:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108c7c:	75 19                	jne    ffff800000108c97 <create+0x129>
    panic("create: ialloc");
ffff800000108c7e:	48 b8 87 c9 10 00 00 	movabs $0xffff80000010c987,%rax
ffff800000108c85:	80 ff ff 
ffff800000108c88:	48 89 c7             	mov    %rax,%rdi
ffff800000108c8b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108c92:	80 ff ff 
ffff800000108c95:	ff d0                	call   *%rax

  ilock(ip);
ffff800000108c97:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c9b:	48 89 c7             	mov    %rax,%rdi
ffff800000108c9e:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108ca5:	80 ff ff 
ffff800000108ca8:	ff d0                	call   *%rax
  ip->major = major;
ffff800000108caa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cae:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff800000108cb2:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
  ip->minor = minor;
ffff800000108cb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cbd:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff800000108cc1:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
  ip->nlink = 1;
ffff800000108cc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ccc:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff800000108cd3:	01 00 
  iupdate(ip);
ffff800000108cd5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cd9:	48 89 c7             	mov    %rax,%rdi
ffff800000108cdc:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108ce3:	80 ff ff 
ffff800000108ce6:	ff d0                	call   *%rax

  if(type == T_DIR){  // Create . and .. entries.
ffff800000108ce8:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff800000108ced:	0f 85 9d 00 00 00    	jne    ffff800000108d90 <create+0x222>
    dp->nlink++;  // for ".."
ffff800000108cf3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cf7:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108cfe:	83 c0 01             	add    $0x1,%eax
ffff800000108d01:	89 c2                	mov    %eax,%edx
ffff800000108d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d07:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108d0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d12:	48 89 c7             	mov    %rax,%rdi
ffff800000108d15:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108d1c:	80 ff ff 
ffff800000108d1f:	ff d0                	call   *%rax
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffff800000108d21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d25:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d28:	48 b9 61 c9 10 00 00 	movabs $0xffff80000010c961,%rcx
ffff800000108d2f:	80 ff ff 
ffff800000108d32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d36:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d39:	48 89 c7             	mov    %rax,%rdi
ffff800000108d3c:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108d43:	80 ff ff 
ffff800000108d46:	ff d0                	call   *%rax
ffff800000108d48:	85 c0                	test   %eax,%eax
ffff800000108d4a:	78 2b                	js     ffff800000108d77 <create+0x209>
ffff800000108d4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d50:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d53:	48 b9 63 c9 10 00 00 	movabs $0xffff80000010c963,%rcx
ffff800000108d5a:	80 ff ff 
ffff800000108d5d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d61:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d64:	48 89 c7             	mov    %rax,%rdi
ffff800000108d67:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108d6e:	80 ff ff 
ffff800000108d71:	ff d0                	call   *%rax
ffff800000108d73:	85 c0                	test   %eax,%eax
ffff800000108d75:	79 19                	jns    ffff800000108d90 <create+0x222>
      panic("create dots");
ffff800000108d77:	48 b8 96 c9 10 00 00 	movabs $0xffff80000010c996,%rax
ffff800000108d7e:	80 ff ff 
ffff800000108d81:	48 89 c7             	mov    %rax,%rdi
ffff800000108d84:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108d8b:	80 ff ff 
ffff800000108d8e:	ff d0                	call   *%rax
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffff800000108d90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d94:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d97:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108d9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d9f:	48 89 ce             	mov    %rcx,%rsi
ffff800000108da2:	48 89 c7             	mov    %rax,%rdi
ffff800000108da5:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108dac:	80 ff ff 
ffff800000108daf:	ff d0                	call   *%rax
ffff800000108db1:	85 c0                	test   %eax,%eax
ffff800000108db3:	79 19                	jns    ffff800000108dce <create+0x260>
    panic("create: dirlink");
ffff800000108db5:	48 b8 a2 c9 10 00 00 	movabs $0xffff80000010c9a2,%rax
ffff800000108dbc:	80 ff ff 
ffff800000108dbf:	48 89 c7             	mov    %rax,%rdi
ffff800000108dc2:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108dc9:	80 ff ff 
ffff800000108dcc:	ff d0                	call   *%rax

  iunlockput(dp);
ffff800000108dce:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108dd2:	48 89 c7             	mov    %rax,%rdi
ffff800000108dd5:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108ddc:	80 ff ff 
ffff800000108ddf:	ff d0                	call   *%rax

  return ip;
ffff800000108de1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000108de5:	c9                   	leave
ffff800000108de6:	c3                   	ret

ffff800000108de7 <sys_open>:

int
sys_open(void)
{
ffff800000108de7:	55                   	push   %rbp
ffff800000108de8:	48 89 e5             	mov    %rsp,%rbp
ffff800000108deb:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffff800000108def:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108df3:	48 89 c6             	mov    %rax,%rsi
ffff800000108df6:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108dfb:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff800000108e02:	80 ff ff 
ffff800000108e05:	ff d0                	call   *%rax
ffff800000108e07:	85 c0                	test   %eax,%eax
ffff800000108e09:	78 1c                	js     ffff800000108e27 <sys_open+0x40>
ffff800000108e0b:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000108e0f:	48 89 c6             	mov    %rax,%rsi
ffff800000108e12:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108e17:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000108e1e:	80 ff ff 
ffff800000108e21:	ff d0                	call   *%rax
ffff800000108e23:	85 c0                	test   %eax,%eax
ffff800000108e25:	79 0a                	jns    ffff800000108e31 <sys_open+0x4a>
    return -1;
ffff800000108e27:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e2c:	e9 de 01 00 00       	jmp    ffff80000010900f <sys_open+0x228>

  begin_op();
ffff800000108e31:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff800000108e38:	80 ff ff 
ffff800000108e3b:	ff d0                	call   *%rax

  if(omode & O_CREATE){
ffff800000108e3d:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108e40:	25 00 02 00 00       	and    $0x200,%eax
ffff800000108e45:	85 c0                	test   %eax,%eax
ffff800000108e47:	74 47                	je     ffff800000108e90 <sys_open+0xa9>
    ip = create(path, T_FILE, 0, 0);
ffff800000108e49:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108e4d:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108e52:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108e57:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000108e5c:	48 89 c7             	mov    %rax,%rdi
ffff800000108e5f:	48 b8 6e 8b 10 00 00 	movabs $0xffff800000108b6e,%rax
ffff800000108e66:	80 ff ff 
ffff800000108e69:	ff d0                	call   *%rax
ffff800000108e6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(ip == 0){
ffff800000108e6f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108e74:	0f 85 9e 00 00 00    	jne    ffff800000108f18 <sys_open+0x131>
      end_op();
ffff800000108e7a:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108e81:	80 ff ff 
ffff800000108e84:	ff d0                	call   *%rax
      return -1;
ffff800000108e86:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e8b:	e9 7f 01 00 00       	jmp    ffff80000010900f <sys_open+0x228>
    }
  } else {
    if((ip = namei(path)) == 0){
ffff800000108e90:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108e94:	48 89 c7             	mov    %rax,%rdi
ffff800000108e97:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff800000108e9e:	80 ff ff 
ffff800000108ea1:	ff d0                	call   *%rax
ffff800000108ea3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108ea7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108eac:	75 16                	jne    ffff800000108ec4 <sys_open+0xdd>
      end_op();
ffff800000108eae:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108eb5:	80 ff ff 
ffff800000108eb8:	ff d0                	call   *%rax
      return -1;
ffff800000108eba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108ebf:	e9 4b 01 00 00       	jmp    ffff80000010900f <sys_open+0x228>
    }
    ilock(ip);
ffff800000108ec4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ec8:	48 89 c7             	mov    %rax,%rdi
ffff800000108ecb:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108ed2:	80 ff ff 
ffff800000108ed5:	ff d0                	call   *%rax
    if(ip->type == T_DIR && omode != O_RDONLY){
ffff800000108ed7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108edb:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108ee2:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108ee6:	75 30                	jne    ffff800000108f18 <sys_open+0x131>
ffff800000108ee8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108eeb:	85 c0                	test   %eax,%eax
ffff800000108eed:	74 29                	je     ffff800000108f18 <sys_open+0x131>
      iunlockput(ip);
ffff800000108eef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ef3:	48 89 c7             	mov    %rax,%rdi
ffff800000108ef6:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108efd:	80 ff ff 
ffff800000108f00:	ff d0                	call   *%rax
      end_op();
ffff800000108f02:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108f09:	80 ff ff 
ffff800000108f0c:	ff d0                	call   *%rax
      return -1;
ffff800000108f0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f13:	e9 f7 00 00 00       	jmp    ffff80000010900f <sys_open+0x228>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff800000108f18:	48 b8 72 1c 10 00 00 	movabs $0xffff800000101c72,%rax
ffff800000108f1f:	80 ff ff 
ffff800000108f22:	ff d0                	call   *%rax
ffff800000108f24:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108f28:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f2d:	74 1c                	je     ffff800000108f4b <sys_open+0x164>
ffff800000108f2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f33:	48 89 c7             	mov    %rax,%rdi
ffff800000108f36:	48 b8 52 83 10 00 00 	movabs $0xffff800000108352,%rax
ffff800000108f3d:	80 ff ff 
ffff800000108f40:	ff d0                	call   *%rax
ffff800000108f42:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000108f45:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108f49:	79 43                	jns    ffff800000108f8e <sys_open+0x1a7>
    if(f)
ffff800000108f4b:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f50:	74 13                	je     ffff800000108f65 <sys_open+0x17e>
      fileclose(f);
ffff800000108f52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f56:	48 89 c7             	mov    %rax,%rdi
ffff800000108f59:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000108f60:	80 ff ff 
ffff800000108f63:	ff d0                	call   *%rax
    iunlockput(ip);
ffff800000108f65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f69:	48 89 c7             	mov    %rax,%rdi
ffff800000108f6c:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108f73:	80 ff ff 
ffff800000108f76:	ff d0                	call   *%rax
    end_op();
ffff800000108f78:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108f7f:	80 ff ff 
ffff800000108f82:	ff d0                	call   *%rax
    return -1;
ffff800000108f84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f89:	e9 81 00 00 00       	jmp    ffff80000010900f <sys_open+0x228>
  }
  iunlock(ip);
ffff800000108f8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f92:	48 89 c7             	mov    %rax,%rdi
ffff800000108f95:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000108f9c:	80 ff ff 
ffff800000108f9f:	ff d0                	call   *%rax
  end_op();
ffff800000108fa1:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000108fa8:	80 ff ff 
ffff800000108fab:	ff d0                	call   *%rax

  f->type = FD_INODE;
ffff800000108fad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fb1:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffff800000108fb7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fbb:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108fbf:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffff800000108fc3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fc7:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffff800000108fce:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108fd1:	83 e0 01             	and    $0x1,%eax
ffff800000108fd4:	83 e0 01             	and    $0x1,%eax
ffff800000108fd7:	83 f0 01             	xor    $0x1,%eax
ffff800000108fda:	89 c2                	mov    %eax,%edx
ffff800000108fdc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108fe0:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000108fe3:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108fe6:	83 e0 01             	and    $0x1,%eax
ffff800000108fe9:	85 c0                	test   %eax,%eax
ffff800000108feb:	75 0a                	jne    ffff800000108ff7 <sys_open+0x210>
ffff800000108fed:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108ff0:	83 e0 02             	and    $0x2,%eax
ffff800000108ff3:	85 c0                	test   %eax,%eax
ffff800000108ff5:	74 07                	je     ffff800000108ffe <sys_open+0x217>
ffff800000108ff7:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000108ffc:	eb 05                	jmp    ffff800000109003 <sys_open+0x21c>
ffff800000108ffe:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109003:	89 c2                	mov    %eax,%edx
ffff800000109005:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109009:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffff80000010900c:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffff80000010900f:	c9                   	leave
ffff800000109010:	c3                   	ret

ffff800000109011 <sys_mkdir>:

int
sys_mkdir(void)
{
ffff800000109011:	55                   	push   %rbp
ffff800000109012:	48 89 e5             	mov    %rsp,%rbp
ffff800000109015:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000109019:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff800000109020:	80 ff ff 
ffff800000109023:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffff800000109025:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109029:	48 89 c6             	mov    %rax,%rsi
ffff80000010902c:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109031:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff800000109038:	80 ff ff 
ffff80000010903b:	ff d0                	call   *%rax
ffff80000010903d:	85 c0                	test   %eax,%eax
ffff80000010903f:	78 2d                	js     ffff80000010906e <sys_mkdir+0x5d>
ffff800000109041:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109045:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff80000010904a:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010904f:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000109054:	48 89 c7             	mov    %rax,%rdi
ffff800000109057:	48 b8 6e 8b 10 00 00 	movabs $0xffff800000108b6e,%rax
ffff80000010905e:	80 ff ff 
ffff800000109061:	ff d0                	call   *%rax
ffff800000109063:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109067:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010906c:	75 13                	jne    ffff800000109081 <sys_mkdir+0x70>
    end_op();
ffff80000010906e:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000109075:	80 ff ff 
ffff800000109078:	ff d0                	call   *%rax
    return -1;
ffff80000010907a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010907f:	eb 24                	jmp    ffff8000001090a5 <sys_mkdir+0x94>
  }
  iunlockput(ip);
ffff800000109081:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109085:	48 89 c7             	mov    %rax,%rdi
ffff800000109088:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010908f:	80 ff ff 
ffff800000109092:	ff d0                	call   *%rax
  end_op();
ffff800000109094:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff80000010909b:	80 ff ff 
ffff80000010909e:	ff d0                	call   *%rax
  return 0;
ffff8000001090a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001090a5:	c9                   	leave
ffff8000001090a6:	c3                   	ret

ffff8000001090a7 <sys_mknod>:

int
sys_mknod(void)
{
ffff8000001090a7:	55                   	push   %rbp
ffff8000001090a8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001090ab:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
ffff8000001090af:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff8000001090b6:	80 ff ff 
ffff8000001090b9:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff8000001090bb:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001090bf:	48 89 c6             	mov    %rax,%rsi
ffff8000001090c2:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001090c7:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff8000001090ce:	80 ff ff 
ffff8000001090d1:	ff d0                	call   *%rax
ffff8000001090d3:	85 c0                	test   %eax,%eax
ffff8000001090d5:	78 67                	js     ffff80000010913e <sys_mknod+0x97>
     argint(1, &major) < 0 ||
ffff8000001090d7:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff8000001090db:	48 89 c6             	mov    %rax,%rsi
ffff8000001090de:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001090e3:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff8000001090ea:	80 ff ff 
ffff8000001090ed:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff8000001090ef:	85 c0                	test   %eax,%eax
ffff8000001090f1:	78 4b                	js     ffff80000010913e <sys_mknod+0x97>
     argint(2, &minor) < 0 ||
ffff8000001090f3:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001090f7:	48 89 c6             	mov    %rax,%rsi
ffff8000001090fa:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001090ff:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000109106:	80 ff ff 
ffff800000109109:	ff d0                	call   *%rax
     argint(1, &major) < 0 ||
ffff80000010910b:	85 c0                	test   %eax,%eax
ffff80000010910d:	78 2f                	js     ffff80000010913e <sys_mknod+0x97>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffff80000010910f:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000109112:	0f bf c8             	movswl %ax,%ecx
ffff800000109115:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109118:	0f bf d0             	movswl %ax,%edx
ffff80000010911b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010911f:	be 03 00 00 00       	mov    $0x3,%esi
ffff800000109124:	48 89 c7             	mov    %rax,%rdi
ffff800000109127:	48 b8 6e 8b 10 00 00 	movabs $0xffff800000108b6e,%rax
ffff80000010912e:	80 ff ff 
ffff800000109131:	ff d0                	call   *%rax
ffff800000109133:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     argint(2, &minor) < 0 ||
ffff800000109137:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010913c:	75 13                	jne    ffff800000109151 <sys_mknod+0xaa>
    end_op();
ffff80000010913e:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000109145:	80 ff ff 
ffff800000109148:	ff d0                	call   *%rax
    return -1;
ffff80000010914a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010914f:	eb 24                	jmp    ffff800000109175 <sys_mknod+0xce>
  }
  iunlockput(ip);
ffff800000109151:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109155:	48 89 c7             	mov    %rax,%rdi
ffff800000109158:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010915f:	80 ff ff 
ffff800000109162:	ff d0                	call   *%rax
  end_op();
ffff800000109164:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff80000010916b:	80 ff ff 
ffff80000010916e:	ff d0                	call   *%rax
  return 0;
ffff800000109170:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109175:	c9                   	leave
ffff800000109176:	c3                   	ret

ffff800000109177 <sys_chdir>:

int
sys_chdir(void)
{
ffff800000109177:	55                   	push   %rbp
ffff800000109178:	48 89 e5             	mov    %rsp,%rbp
ffff80000010917b:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff80000010917f:	48 b8 b2 50 10 00 00 	movabs $0xffff8000001050b2,%rax
ffff800000109186:	80 ff ff 
ffff800000109189:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
ffff80000010918b:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010918f:	48 89 c6             	mov    %rax,%rsi
ffff800000109192:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109197:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff80000010919e:	80 ff ff 
ffff8000001091a1:	ff d0                	call   *%rax
ffff8000001091a3:	85 c0                	test   %eax,%eax
ffff8000001091a5:	78 1e                	js     ffff8000001091c5 <sys_chdir+0x4e>
ffff8000001091a7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001091ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001091ae:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff8000001091b5:	80 ff ff 
ffff8000001091b8:	ff d0                	call   *%rax
ffff8000001091ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001091be:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001091c3:	75 16                	jne    ffff8000001091db <sys_chdir+0x64>
    end_op();
ffff8000001091c5:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff8000001091cc:	80 ff ff 
ffff8000001091cf:	ff d0                	call   *%rax
    return -1;
ffff8000001091d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001091d6:	e9 a5 00 00 00       	jmp    ffff800000109280 <sys_chdir+0x109>
  }
  ilock(ip);
ffff8000001091db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091df:	48 89 c7             	mov    %rax,%rdi
ffff8000001091e2:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001091e9:	80 ff ff 
ffff8000001091ec:	ff d0                	call   *%rax
  if(ip->type != T_DIR){
ffff8000001091ee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001091f2:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001091f9:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001091fd:	74 26                	je     ffff800000109225 <sys_chdir+0xae>
    iunlockput(ip);
ffff8000001091ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109203:	48 89 c7             	mov    %rax,%rdi
ffff800000109206:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010920d:	80 ff ff 
ffff800000109210:	ff d0                	call   *%rax
    end_op();
ffff800000109212:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000109219:	80 ff ff 
ffff80000010921c:	ff d0                	call   *%rax
    return -1;
ffff80000010921e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109223:	eb 5b                	jmp    ffff800000109280 <sys_chdir+0x109>
  }
  iunlock(ip);
ffff800000109225:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109229:	48 89 c7             	mov    %rax,%rdi
ffff80000010922c:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000109233:	80 ff ff 
ffff800000109236:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff800000109238:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010923f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109243:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff80000010924a:	48 89 c7             	mov    %rax,%rdi
ffff80000010924d:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000109254:	80 ff ff 
ffff800000109257:	ff d0                	call   *%rax
  end_op();
ffff800000109259:	48 b8 9a 51 10 00 00 	movabs $0xffff80000010519a,%rax
ffff800000109260:	80 ff ff 
ffff800000109263:	ff d0                	call   *%rax
  proc->cwd = ip;
ffff800000109265:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010926c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109270:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000109274:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffff80000010927b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109280:	c9                   	leave
ffff800000109281:	c3                   	ret

ffff800000109282 <sys_exec>:

int
sys_exec(void)
{
ffff800000109282:	55                   	push   %rbp
ffff800000109283:	48 89 e5             	mov    %rsp,%rbp
ffff800000109286:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
ffff80000010928d:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109291:	48 89 c6             	mov    %rax,%rsi
ffff800000109294:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109299:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff8000001092a0:	80 ff ff 
ffff8000001092a3:	ff d0                	call   *%rax
ffff8000001092a5:	85 c0                	test   %eax,%eax
ffff8000001092a7:	78 44                	js     ffff8000001092ed <sys_exec+0x6b>
ffff8000001092a9:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff8000001092b0:	48 89 c6             	mov    %rax,%rsi
ffff8000001092b3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001092b8:	48 b8 47 80 10 00 00 	movabs $0xffff800000108047,%rax
ffff8000001092bf:	80 ff ff 
ffff8000001092c2:	ff d0                	call   *%rax
    return -1;
  }
  memset(argv, 0, sizeof(argv));
ffff8000001092c4:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff8000001092cb:	ba 00 01 00 00       	mov    $0x100,%edx
ffff8000001092d0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001092d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001092d8:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff8000001092df:	80 ff ff 
ffff8000001092e2:	ff d0                	call   *%rax
  for(i=0;; i++){
ffff8000001092e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001092eb:	eb 0a                	jmp    ffff8000001092f7 <sys_exec+0x75>
    return -1;
ffff8000001092ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001092f2:	e9 cb 00 00 00       	jmp    ffff8000001093c2 <sys_exec+0x140>
    if(i >= NELEM(argv))
ffff8000001092f7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001092fa:	83 f8 1f             	cmp    $0x1f,%eax
ffff8000001092fd:	76 0a                	jbe    ffff800000109309 <sys_exec+0x87>
      return -1;
ffff8000001092ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109304:	e9 b9 00 00 00       	jmp    ffff8000001093c2 <sys_exec+0x140>
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
ffff800000109309:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010930c:	48 98                	cltq
ffff80000010930e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000109315:	00 
ffff800000109316:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff80000010931d:	48 01 c2             	add    %rax,%rdx
ffff800000109320:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff800000109327:	48 89 c6             	mov    %rax,%rsi
ffff80000010932a:	48 89 d7             	mov    %rdx,%rdi
ffff80000010932d:	48 b8 21 7e 10 00 00 	movabs $0xffff800000107e21,%rax
ffff800000109334:	80 ff ff 
ffff800000109337:	ff d0                	call   *%rax
ffff800000109339:	85 c0                	test   %eax,%eax
ffff80000010933b:	79 07                	jns    ffff800000109344 <sys_exec+0xc2>
      return -1;
ffff80000010933d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109342:	eb 7e                	jmp    ffff8000001093c2 <sys_exec+0x140>
    if(uarg == 0){
ffff800000109344:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff80000010934b:	48 85 c0             	test   %rax,%rax
ffff80000010934e:	75 31                	jne    ffff800000109381 <sys_exec+0xff>
      argv[i] = 0;
ffff800000109350:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109353:	48 98                	cltq
ffff800000109355:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff80000010935c:	ff 00 00 00 00 
      break;
ffff800000109361:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffff800000109362:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109366:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff80000010936d:	48 89 d6             	mov    %rdx,%rsi
ffff800000109370:	48 89 c7             	mov    %rax,%rdi
ffff800000109373:	48 b8 6b 16 10 00 00 	movabs $0xffff80000010166b,%rax
ffff80000010937a:	80 ff ff 
ffff80000010937d:	ff d0                	call   *%rax
ffff80000010937f:	eb 41                	jmp    ffff8000001093c2 <sys_exec+0x140>
    if(fetchstr(uarg, &argv[i]) < 0)
ffff800000109381:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff800000109388:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010938b:	48 63 d2             	movslq %edx,%rdx
ffff80000010938e:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000109392:	48 01 c2             	add    %rax,%rdx
ffff800000109395:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff80000010939c:	48 89 d6             	mov    %rdx,%rsi
ffff80000010939f:	48 89 c7             	mov    %rax,%rdi
ffff8000001093a2:	48 b8 86 7e 10 00 00 	movabs $0xffff800000107e86,%rax
ffff8000001093a9:	80 ff ff 
ffff8000001093ac:	ff d0                	call   *%rax
ffff8000001093ae:	85 c0                	test   %eax,%eax
ffff8000001093b0:	79 07                	jns    ffff8000001093b9 <sys_exec+0x137>
      return -1;
ffff8000001093b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001093b7:	eb 09                	jmp    ffff8000001093c2 <sys_exec+0x140>
  for(i=0;; i++){
ffff8000001093b9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffff8000001093bd:	e9 35 ff ff ff       	jmp    ffff8000001092f7 <sys_exec+0x75>
}
ffff8000001093c2:	c9                   	leave
ffff8000001093c3:	c3                   	ret

ffff8000001093c4 <sys_pipe>:

int
sys_pipe(void)
{
ffff8000001093c4:	55                   	push   %rbp
ffff8000001093c5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001093c8:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffff8000001093cc:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001093d0:	ba 08 00 00 00       	mov    $0x8,%edx
ffff8000001093d5:	48 89 c6             	mov    %rax,%rsi
ffff8000001093d8:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001093dd:	48 b8 75 80 10 00 00 	movabs $0xffff800000108075,%rax
ffff8000001093e4:	80 ff ff 
ffff8000001093e7:	ff d0                	call   *%rax
    return -1;
  if(pipealloc(&rf, &wf) < 0)
ffff8000001093e9:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001093ed:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001093f1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001093f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001093f7:	48 b8 03 5e 10 00 00 	movabs $0xffff800000105e03,%rax
ffff8000001093fe:	80 ff ff 
ffff800000109401:	ff d0                	call   *%rax
ffff800000109403:	85 c0                	test   %eax,%eax
ffff800000109405:	79 0a                	jns    ffff800000109411 <sys_pipe+0x4d>
    return -1;
ffff800000109407:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010940c:	e9 ab 00 00 00       	jmp    ffff8000001094bc <sys_pipe+0xf8>
  fd0 = -1;
ffff800000109411:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffff800000109418:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010941c:	48 89 c7             	mov    %rax,%rdi
ffff80000010941f:	48 b8 52 83 10 00 00 	movabs $0xffff800000108352,%rax
ffff800000109426:	80 ff ff 
ffff800000109429:	ff d0                	call   *%rax
ffff80000010942b:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010942e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000109432:	78 1c                	js     ffff800000109450 <sys_pipe+0x8c>
ffff800000109434:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109438:	48 89 c7             	mov    %rax,%rdi
ffff80000010943b:	48 b8 52 83 10 00 00 	movabs $0xffff800000108352,%rax
ffff800000109442:	80 ff ff 
ffff800000109445:	ff d0                	call   *%rax
ffff800000109447:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010944a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff80000010944e:	79 51                	jns    ffff8000001094a1 <sys_pipe+0xdd>
    if(fd0 >= 0)
ffff800000109450:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000109454:	78 1e                	js     ffff800000109474 <sys_pipe+0xb0>
      proc->ofile[fd0] = 0;
ffff800000109456:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010945d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109461:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109464:	48 63 d2             	movslq %edx,%rdx
ffff800000109467:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010946b:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000109472:	00 00 
    fileclose(rf);
ffff800000109474:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109478:	48 89 c7             	mov    %rax,%rdi
ffff80000010947b:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000109482:	80 ff ff 
ffff800000109485:	ff d0                	call   *%rax
    fileclose(wf);
ffff800000109487:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010948b:	48 89 c7             	mov    %rax,%rdi
ffff80000010948e:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000109495:	80 ff ff 
ffff800000109498:	ff d0                	call   *%rax
    return -1;
ffff80000010949a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010949f:	eb 1b                	jmp    ffff8000001094bc <sys_pipe+0xf8>
  }
  fd[0] = fd0;
ffff8000001094a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001094a5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001094a8:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffff8000001094aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001094ae:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff8000001094b2:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001094b5:	89 02                	mov    %eax,(%rdx)
  return 0;
ffff8000001094b7:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001094bc:	c9                   	leave
ffff8000001094bd:	c3                   	ret

ffff8000001094be <sys_fork>:
#include "proc.h"
#include "trace.h"

int
sys_fork(void)
{
ffff8000001094be:	55                   	push   %rbp
ffff8000001094bf:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff8000001094c2:	48 b8 15 67 10 00 00 	movabs $0xffff800000106715,%rax
ffff8000001094c9:	80 ff ff 
ffff8000001094cc:	ff d0                	call   *%rax
}
ffff8000001094ce:	5d                   	pop    %rbp
ffff8000001094cf:	c3                   	ret

ffff8000001094d0 <sys_exit>:

int
sys_exit(void)
{
ffff8000001094d0:	55                   	push   %rbp
ffff8000001094d1:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff8000001094d4:	48 b8 03 6a 10 00 00 	movabs $0xffff800000106a03,%rax
ffff8000001094db:	80 ff ff 
ffff8000001094de:	ff d0                	call   *%rax
  return 0;  // not reached
ffff8000001094e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001094e5:	5d                   	pop    %rbp
ffff8000001094e6:	c3                   	ret

ffff8000001094e7 <sys_wait>:

int
sys_wait(void)
{
ffff8000001094e7:	55                   	push   %rbp
ffff8000001094e8:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff8000001094eb:	48 b8 2c 6c 10 00 00 	movabs $0xffff800000106c2c,%rax
ffff8000001094f2:	80 ff ff 
ffff8000001094f5:	ff d0                	call   *%rax
}
ffff8000001094f7:	5d                   	pop    %rbp
ffff8000001094f8:	c3                   	ret

ffff8000001094f9 <sys_kill>:

int
sys_kill(void)
{
ffff8000001094f9:	55                   	push   %rbp
ffff8000001094fa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001094fd:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff800000109501:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000109505:	48 89 c6             	mov    %rax,%rsi
ffff800000109508:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010950d:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000109514:	80 ff ff 
ffff800000109517:	ff d0                	call   *%rax
ffff800000109519:	85 c0                	test   %eax,%eax
ffff80000010951b:	79 07                	jns    ffff800000109524 <sys_kill+0x2b>
    return -1;
ffff80000010951d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109522:	eb 11                	jmp    ffff800000109535 <sys_kill+0x3c>
  return kill(pid);
ffff800000109524:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109527:	89 c7                	mov    %eax,%edi
ffff800000109529:	48 b8 89 72 10 00 00 	movabs $0xffff800000107289,%rax
ffff800000109530:	80 ff ff 
ffff800000109533:	ff d0                	call   *%rax
}
ffff800000109535:	c9                   	leave
ffff800000109536:	c3                   	ret

ffff800000109537 <sys_getpid>:

int
sys_getpid(void)
{
ffff800000109537:	55                   	push   %rbp
ffff800000109538:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff80000010953b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109542:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109546:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff800000109549:	5d                   	pop    %rbp
ffff80000010954a:	c3                   	ret

ffff80000010954b <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff80000010954b:	55                   	push   %rbp
ffff80000010954c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010954f:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff800000109553:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109557:	48 89 c6             	mov    %rax,%rsi
ffff80000010955a:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010955f:	48 b8 47 80 10 00 00 	movabs $0xffff800000108047,%rax
ffff800000109566:	80 ff ff 
ffff800000109569:	ff d0                	call   *%rax
  addr = proc->sz;
ffff80000010956b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109572:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109576:	48 8b 00             	mov    (%rax),%rax
ffff800000109579:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff80000010957d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109581:	48 89 c7             	mov    %rax,%rdi
ffff800000109584:	48 b8 32 66 10 00 00 	movabs $0xffff800000106632,%rax
ffff80000010958b:	80 ff ff 
ffff80000010958e:	ff d0                	call   *%rax
ffff800000109590:	85 c0                	test   %eax,%eax
ffff800000109592:	79 09                	jns    ffff80000010959d <sys_sbrk+0x52>
    return -1;
ffff800000109594:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff80000010959b:	eb 04                	jmp    ffff8000001095a1 <sys_sbrk+0x56>
  return addr;
ffff80000010959d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001095a1:	c9                   	leave
ffff8000001095a2:	c3                   	ret

ffff8000001095a3 <sys_sleep>:

int
sys_sleep(void)
{
ffff8000001095a3:	55                   	push   %rbp
ffff8000001095a4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001095a7:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff8000001095ab:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001095af:	48 89 c6             	mov    %rax,%rsi
ffff8000001095b2:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001095b7:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff8000001095be:	80 ff ff 
ffff8000001095c1:	ff d0                	call   *%rax
ffff8000001095c3:	85 c0                	test   %eax,%eax
ffff8000001095c5:	79 0a                	jns    ffff8000001095d1 <sys_sleep+0x2e>
    return -1;
ffff8000001095c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001095cc:	e9 b6 00 00 00       	jmp    ffff800000109687 <sys_sleep+0xe4>
  acquire(&tickslock);
ffff8000001095d1:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff8000001095d8:	80 ff ff 
ffff8000001095db:	48 89 c7             	mov    %rax,%rdi
ffff8000001095de:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001095e5:	80 ff ff 
ffff8000001095e8:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff8000001095ea:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff8000001095f1:	80 ff ff 
ffff8000001095f4:	8b 00                	mov    (%rax),%eax
ffff8000001095f6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff8000001095f9:	eb 58                	jmp    ffff800000109653 <sys_sleep+0xb0>
    if(proc->killed){
ffff8000001095fb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109602:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109606:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109609:	85 c0                	test   %eax,%eax
ffff80000010960b:	74 20                	je     ffff80000010962d <sys_sleep+0x8a>
      release(&tickslock);
ffff80000010960d:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109614:	80 ff ff 
ffff800000109617:	48 89 c7             	mov    %rax,%rdi
ffff80000010961a:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000109621:	80 ff ff 
ffff800000109624:	ff d0                	call   *%rax
      return -1;
ffff800000109626:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010962b:	eb 5a                	jmp    ffff800000109687 <sys_sleep+0xe4>
    }
    sleep(&ticks, &tickslock);
ffff80000010962d:	48 ba e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rdx
ffff800000109634:	80 ff ff 
ffff800000109637:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff80000010963e:	80 ff ff 
ffff800000109641:	48 89 d6             	mov    %rdx,%rsi
ffff800000109644:	48 89 c7             	mov    %rax,%rdi
ffff800000109647:	48 b8 c0 70 10 00 00 	movabs $0xffff8000001070c0,%rax
ffff80000010964e:	80 ff ff 
ffff800000109651:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff800000109653:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff80000010965a:	80 ff ff 
ffff80000010965d:	8b 00                	mov    (%rax),%eax
ffff80000010965f:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000109662:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000109665:	39 d0                	cmp    %edx,%eax
ffff800000109667:	72 92                	jb     ffff8000001095fb <sys_sleep+0x58>
  }
  release(&tickslock);
ffff800000109669:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109670:	80 ff ff 
ffff800000109673:	48 89 c7             	mov    %rax,%rdi
ffff800000109676:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010967d:	80 ff ff 
ffff800000109680:	ff d0                	call   *%rax
  return 0;
ffff800000109682:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109687:	c9                   	leave
ffff800000109688:	c3                   	ret

ffff800000109689 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff800000109689:	55                   	push   %rbp
ffff80000010968a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010968d:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff800000109691:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109698:	80 ff ff 
ffff80000010969b:	48 89 c7             	mov    %rax,%rdi
ffff80000010969e:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff8000001096a5:	80 ff ff 
ffff8000001096a8:	ff d0                	call   *%rax
  xticks = ticks;
ffff8000001096aa:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff8000001096b1:	80 ff ff 
ffff8000001096b4:	8b 00                	mov    (%rax),%eax
ffff8000001096b6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff8000001096b9:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff8000001096c0:	80 ff ff 
ffff8000001096c3:	48 89 c7             	mov    %rax,%rdi
ffff8000001096c6:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff8000001096cd:	80 ff ff 
ffff8000001096d0:	ff d0                	call   *%rax
  return xticks;
ffff8000001096d2:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001096d5:	c9                   	leave
ffff8000001096d6:	c3                   	ret

ffff8000001096d7 <sys_traceread>:


int
sys_traceread(void){
ffff8000001096d7:	55                   	push   %rbp
ffff8000001096d8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001096db:	48 83 ec 10          	sub    $0x10,%rsp
  struct trace_event *event;

  // Get the first argument to grab the first event
  if(argptr(0, (char**)&event, sizeof(*event)) < 0)
ffff8000001096df:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001096e3:	ba 28 00 00 00       	mov    $0x28,%edx
ffff8000001096e8:	48 89 c6             	mov    %rax,%rsi
ffff8000001096eb:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001096f0:	48 b8 75 80 10 00 00 	movabs $0xffff800000108075,%rax
ffff8000001096f7:	80 ff ff 
ffff8000001096fa:	ff d0                	call   *%rax
    return -1;

  return traceread(event);
ffff8000001096fc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109700:	48 89 c7             	mov    %rax,%rdi
ffff800000109703:	48 b8 fa c2 10 00 00 	movabs $0xffff80000010c2fa,%rax
ffff80000010970a:	80 ff ff 
ffff80000010970d:	ff d0                	call   *%rax
}
ffff80000010970f:	c9                   	leave
ffff800000109710:	c3                   	ret

ffff800000109711 <sys_vidclear>:


int sys_vidclear(void){
ffff800000109711:	55                   	push   %rbp
ffff800000109712:	48 89 e5             	mov    %rsp,%rbp
  vidclear();
ffff800000109715:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff80000010971c:	80 ff ff 
ffff80000010971f:	ff d0                	call   *%rax
  return 0;
ffff800000109721:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109726:	5d                   	pop    %rbp
ffff800000109727:	c3                   	ret

ffff800000109728 <sys_vidputc>:

int
sys_vidputc(void){
ffff800000109728:	55                   	push   %rbp
ffff800000109729:	48 89 e5             	mov    %rsp,%rbp
ffff80000010972c:	48 83 ec 10          	sub    $0x10,%rsp
  int row, col, ch, color;

  if(argint(0, &row) < 0)
ffff800000109730:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000109734:	48 89 c6             	mov    %rax,%rsi
ffff800000109737:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010973c:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000109743:	80 ff ff 
ffff800000109746:	ff d0                	call   *%rax
ffff800000109748:	85 c0                	test   %eax,%eax
ffff80000010974a:	79 0a                	jns    ffff800000109756 <sys_vidputc+0x2e>
    return -1;
ffff80000010974c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109751:	e9 88 00 00 00       	jmp    ffff8000001097de <sys_vidputc+0xb6>
  if(argint(1, &col) < 0)
ffff800000109756:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010975a:	48 89 c6             	mov    %rax,%rsi
ffff80000010975d:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109762:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000109769:	80 ff ff 
ffff80000010976c:	ff d0                	call   *%rax
ffff80000010976e:	85 c0                	test   %eax,%eax
ffff800000109770:	79 07                	jns    ffff800000109779 <sys_vidputc+0x51>
    return -1;
ffff800000109772:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109777:	eb 65                	jmp    ffff8000001097de <sys_vidputc+0xb6>
  if(argint(2, &ch) < 0)
ffff800000109779:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff80000010977d:	48 89 c6             	mov    %rax,%rsi
ffff800000109780:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000109785:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff80000010978c:	80 ff ff 
ffff80000010978f:	ff d0                	call   *%rax
ffff800000109791:	85 c0                	test   %eax,%eax
ffff800000109793:	79 07                	jns    ffff80000010979c <sys_vidputc+0x74>
    return -1;
ffff800000109795:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010979a:	eb 42                	jmp    ffff8000001097de <sys_vidputc+0xb6>
  if(argint(3, &color) < 0)
ffff80000010979c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001097a0:	48 89 c6             	mov    %rax,%rsi
ffff8000001097a3:	bf 03 00 00 00       	mov    $0x3,%edi
ffff8000001097a8:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff8000001097af:	80 ff ff 
ffff8000001097b2:	ff d0                	call   *%rax
ffff8000001097b4:	85 c0                	test   %eax,%eax
ffff8000001097b6:	79 07                	jns    ffff8000001097bf <sys_vidputc+0x97>
    return -1;
ffff8000001097b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001097bd:	eb 1f                	jmp    ffff8000001097de <sys_vidputc+0xb6>

  vidputc(row, col, ch, color);
ffff8000001097bf:	8b 4d f0             	mov    -0x10(%rbp),%ecx
ffff8000001097c2:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001097c5:	8b 75 f8             	mov    -0x8(%rbp),%esi
ffff8000001097c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001097cb:	89 c7                	mov    %eax,%edi
ffff8000001097cd:	48 b8 17 0f 10 00 00 	movabs $0xffff800000100f17,%rax
ffff8000001097d4:	80 ff ff 
ffff8000001097d7:	ff d0                	call   *%rax
  return 0;
ffff8000001097d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001097de:	c9                   	leave
ffff8000001097df:	c3                   	ret

ffff8000001097e0 <sys_vidputs>:

int sys_vidputs(void){
ffff8000001097e0:	55                   	push   %rbp
ffff8000001097e1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001097e4:	48 83 ec 20          	sub    $0x20,%rsp
  int row, col, color;
  char *s;

  if(argint(0, &row) < 0)
ffff8000001097e8:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff8000001097ec:	48 89 c6             	mov    %rax,%rsi
ffff8000001097ef:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001097f4:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff8000001097fb:	80 ff ff 
ffff8000001097fe:	ff d0                	call   *%rax
ffff800000109800:	85 c0                	test   %eax,%eax
ffff800000109802:	79 0a                	jns    ffff80000010980e <sys_vidputs+0x2e>
    return -1;
ffff800000109804:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109809:	e9 89 00 00 00       	jmp    ffff800000109897 <sys_vidputs+0xb7>
  if(argint(1, &col) < 0)
ffff80000010980e:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109812:	48 89 c6             	mov    %rax,%rsi
ffff800000109815:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010981a:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000109821:	80 ff ff 
ffff800000109824:	ff d0                	call   *%rax
ffff800000109826:	85 c0                	test   %eax,%eax
ffff800000109828:	79 07                	jns    ffff800000109831 <sys_vidputs+0x51>
    return -1;
ffff80000010982a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010982f:	eb 66                	jmp    ffff800000109897 <sys_vidputs+0xb7>
  if(argstr(2, &s) < 0)
ffff800000109831:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109835:	48 89 c6             	mov    %rax,%rsi
ffff800000109838:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010983d:	48 b8 fc 80 10 00 00 	movabs $0xffff8000001080fc,%rax
ffff800000109844:	80 ff ff 
ffff800000109847:	ff d0                	call   *%rax
ffff800000109849:	85 c0                	test   %eax,%eax
ffff80000010984b:	79 07                	jns    ffff800000109854 <sys_vidputs+0x74>
    return -1;
ffff80000010984d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109852:	eb 43                	jmp    ffff800000109897 <sys_vidputs+0xb7>
  if(argint(3, &color) < 0)
ffff800000109854:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff800000109858:	48 89 c6             	mov    %rax,%rsi
ffff80000010985b:	bf 03 00 00 00       	mov    $0x3,%edi
ffff800000109860:	48 b8 18 80 10 00 00 	movabs $0xffff800000108018,%rax
ffff800000109867:	80 ff ff 
ffff80000010986a:	ff d0                	call   *%rax
ffff80000010986c:	85 c0                	test   %eax,%eax
ffff80000010986e:	79 07                	jns    ffff800000109877 <sys_vidputs+0x97>
    return -1;
ffff800000109870:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109875:	eb 20                	jmp    ffff800000109897 <sys_vidputs+0xb7>

  vidputs(row, col, s, color);
ffff800000109877:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff80000010987a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010987e:	8b 75 f8             	mov    -0x8(%rbp),%esi
ffff800000109881:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109884:	89 c7                	mov    %eax,%edi
ffff800000109886:	48 b8 89 0f 10 00 00 	movabs $0xffff800000100f89,%rax
ffff80000010988d:	80 ff ff 
ffff800000109890:	ff d0                	call   *%rax
  return 0;
ffff800000109892:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109897:	c9                   	leave
ffff800000109898:	c3                   	ret

ffff800000109899 <alltraps>:
# vectors.S sends all traps here.
.global alltraps
alltraps:
  # Build trap frame.
  pushq   %r15
ffff800000109899:	41 57                	push   %r15
  pushq   %r14
ffff80000010989b:	41 56                	push   %r14
  pushq   %r13
ffff80000010989d:	41 55                	push   %r13
  pushq   %r12
ffff80000010989f:	41 54                	push   %r12
  pushq   %r11
ffff8000001098a1:	41 53                	push   %r11
  pushq   %r10
ffff8000001098a3:	41 52                	push   %r10
  pushq   %r9
ffff8000001098a5:	41 51                	push   %r9
  pushq   %r8
ffff8000001098a7:	41 50                	push   %r8
  pushq   %rdi
ffff8000001098a9:	57                   	push   %rdi
  pushq   %rsi
ffff8000001098aa:	56                   	push   %rsi
  pushq   %rbp
ffff8000001098ab:	55                   	push   %rbp
  pushq   %rdx
ffff8000001098ac:	52                   	push   %rdx
  pushq   %rcx
ffff8000001098ad:	51                   	push   %rcx
  pushq   %rbx
ffff8000001098ae:	53                   	push   %rbx
  pushq   %rax
ffff8000001098af:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff8000001098b0:	48 89 e7             	mov    %rsp,%rdi
  callq   trap
ffff8000001098b3:	e8 7b 02 00 00       	call   ffff800000109b33 <trap>

ffff8000001098b8 <trapret>:
# Return falls through to trapret...

.global trapret
trapret:
  popq    %rax
ffff8000001098b8:	58                   	pop    %rax
  popq    %rbx
ffff8000001098b9:	5b                   	pop    %rbx
  popq    %rcx
ffff8000001098ba:	59                   	pop    %rcx
  popq    %rdx
ffff8000001098bb:	5a                   	pop    %rdx
  popq    %rbp
ffff8000001098bc:	5d                   	pop    %rbp
  popq    %rsi
ffff8000001098bd:	5e                   	pop    %rsi
  popq    %rdi
ffff8000001098be:	5f                   	pop    %rdi
  popq    %r8
ffff8000001098bf:	41 58                	pop    %r8
  popq    %r9
ffff8000001098c1:	41 59                	pop    %r9
  popq    %r10
ffff8000001098c3:	41 5a                	pop    %r10
  popq    %r11
ffff8000001098c5:	41 5b                	pop    %r11
  popq    %r12
ffff8000001098c7:	41 5c                	pop    %r12
  popq    %r13
ffff8000001098c9:	41 5d                	pop    %r13
  popq    %r14
ffff8000001098cb:	41 5e                	pop    %r14
  popq    %r15
ffff8000001098cd:	41 5f                	pop    %r15

  addq    $16, %rsp  # discard trapnum and errorcode
ffff8000001098cf:	48 83 c4 10          	add    $0x10,%rsp
  iretq
ffff8000001098d3:	48 cf                	iretq

ffff8000001098d5 <syscall_entry>:
.global syscall_entry
syscall_entry:
  # switch to kernel stack. With the syscall instruction,
  # this is a kernel resposibility
  # store %rsp on the top of proc->kstack,
  movq    %rax, %fs:(0)      # save %rax above __thread vars
ffff8000001098d5:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff8000001098dc:	00 00 
  movq    %fs:(-8), %rax     # %fs:(-8) is proc (the last __thread)
ffff8000001098de:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff8000001098e5:	ff ff 
  movq    0x10(%rax), %rax   # get proc->kstack (see struct proc)
ffff8000001098e7:	48 8b 40 10          	mov    0x10(%rax),%rax
  addq    $(4096-16), %rax   # %rax points to tf->rsp
ffff8000001098eb:	48 05 f0 0f 00 00    	add    $0xff0,%rax
  movq    %rsp, (%rax)       # save user rsp to tf->rsp
ffff8000001098f1:	48 89 20             	mov    %rsp,(%rax)
  movq    %rax, %rsp         # switch to the kstack
ffff8000001098f4:	48 89 c4             	mov    %rax,%rsp
  movq    %fs:(0), %rax      # restore %rax
ffff8000001098f7:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff8000001098fe:	00 00 

  pushq   %r11         # rflags
ffff800000109900:	41 53                	push   %r11
  pushq   $0           # cs is ignored
ffff800000109902:	6a 00                	push   $0x0
  pushq   %rcx         # rip (next user insn)
ffff800000109904:	51                   	push   %rcx

  pushq   $0           # err
ffff800000109905:	6a 00                	push   $0x0
  pushq   $0           # trapno ignored
ffff800000109907:	6a 00                	push   $0x0

  pushq   %r15
ffff800000109909:	41 57                	push   %r15
  pushq   %r14
ffff80000010990b:	41 56                	push   %r14
  pushq   %r13
ffff80000010990d:	41 55                	push   %r13
  pushq   %r12
ffff80000010990f:	41 54                	push   %r12
  pushq   %r11
ffff800000109911:	41 53                	push   %r11
  pushq   %r10
ffff800000109913:	41 52                	push   %r10
  pushq   %r9
ffff800000109915:	41 51                	push   %r9
  pushq   %r8
ffff800000109917:	41 50                	push   %r8
  pushq   %rdi
ffff800000109919:	57                   	push   %rdi
  pushq   %rsi
ffff80000010991a:	56                   	push   %rsi
  pushq   %rbp
ffff80000010991b:	55                   	push   %rbp
  pushq   %rdx
ffff80000010991c:	52                   	push   %rdx
  pushq   %rcx
ffff80000010991d:	51                   	push   %rcx
  pushq   %rbx
ffff80000010991e:	53                   	push   %rbx
  pushq   %rax
ffff80000010991f:	50                   	push   %rax

  movq    %rsp, %rdi  # frame in arg1
ffff800000109920:	48 89 e7             	mov    %rsp,%rdi
  callq   syscall
ffff800000109923:	e8 23 e8 ff ff       	call   ffff80000010814b <syscall>

ffff800000109928 <syscall_trapret>:
# Return falls through to syscall_trapret...
#PAGEBREAK!

.global syscall_trapret
syscall_trapret:
  popq    %rax
ffff800000109928:	58                   	pop    %rax
  popq    %rbx
ffff800000109929:	5b                   	pop    %rbx
  popq    %rcx
ffff80000010992a:	59                   	pop    %rcx
  popq    %rdx
ffff80000010992b:	5a                   	pop    %rdx
  popq    %rbp
ffff80000010992c:	5d                   	pop    %rbp
  popq    %rsi
ffff80000010992d:	5e                   	pop    %rsi
  popq    %rdi
ffff80000010992e:	5f                   	pop    %rdi
  popq    %r8
ffff80000010992f:	41 58                	pop    %r8
  popq    %r9
ffff800000109931:	41 59                	pop    %r9
  popq    %r10
ffff800000109933:	41 5a                	pop    %r10
  popq    %r11
ffff800000109935:	41 5b                	pop    %r11
  popq    %r12
ffff800000109937:	41 5c                	pop    %r12
  popq    %r13
ffff800000109939:	41 5d                	pop    %r13
  popq    %r14
ffff80000010993b:	41 5e                	pop    %r14
  popq    %r15
ffff80000010993d:	41 5f                	pop    %r15

  addq    $40, %rsp  # discard trapnum, errorcode, rip, cs and rflags
ffff80000010993f:	48 83 c4 28          	add    $0x28,%rsp

  # to make sure we don't get any interrupts on the user stack while in
  # supervisor mode. this is actually slightly unsafe still,
  # since some interrupts are nonmaskable.
  # See https://www.felixcloutier.com/x86/sysret
  cli
ffff800000109943:	fa                   	cli
  movq    (%rsp), %rsp  # restore the user stack
ffff800000109944:	48 8b 24 24          	mov    (%rsp),%rsp
  sysretq
ffff800000109948:	48 0f 07             	sysretq

ffff80000010994b <lidt>:
{
ffff80000010994b:	55                   	push   %rbp
ffff80000010994c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010994f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000109953:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000109957:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010995a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010995e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff800000109962:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000109965:	83 e8 01             	sub    $0x1,%eax
ffff800000109968:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010996c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109970:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff800000109974:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109978:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010997c:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff800000109980:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109984:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109988:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010998c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109990:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000109994:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffff800000109998:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010999c:	0f 01 18             	lidt   (%rax)
}
ffff80000010999f:	90                   	nop
ffff8000001099a0:	c9                   	leave
ffff8000001099a1:	c3                   	ret

ffff8000001099a2 <rcr2>:

static inline addr_t
rcr2(void)
{
ffff8000001099a2:	55                   	push   %rbp
ffff8000001099a3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001099a6:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t val;
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffff8000001099aa:	0f 20 d0             	mov    %cr2,%rax
ffff8000001099ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffff8000001099b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001099b5:	c9                   	leave
ffff8000001099b6:	c3                   	ret

ffff8000001099b7 <mkgate>:
struct spinlock tickslock;
uint ticks;

static void
mkgate(uint *idt, uint n, addr_t kva, uint pl)
{
ffff8000001099b7:	55                   	push   %rbp
ffff8000001099b8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001099bb:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001099bf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001099c3:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff8000001099c6:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001099ca:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff8000001099cd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001099d1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  n *= 4;
ffff8000001099d5:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff8000001099d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099dd:	0f b7 d0             	movzwl %ax,%edx
ffff8000001099e0:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff8000001099e3:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff8000001099ea:	00 
ffff8000001099eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001099ef:	48 01 c8             	add    %rcx,%rax
ffff8000001099f2:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff8000001099f8:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff8000001099fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099fe:	66 b8 00 00          	mov    $0x0,%ax
ffff800000109a02:	89 c2                	mov    %eax,%edx
ffff800000109a04:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000109a07:	c1 e0 0d             	shl    $0xd,%eax
ffff800000109a0a:	25 00 60 00 00       	and    $0x6000,%eax
ffff800000109a0f:	09 c2                	or     %eax,%edx
ffff800000109a11:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a14:	83 c0 01             	add    $0x1,%eax
ffff800000109a17:	89 c0                	mov    %eax,%eax
ffff800000109a19:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff800000109a20:	00 
ffff800000109a21:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a25:	48 01 c8             	add    %rcx,%rax
ffff800000109a28:	80 ce 8e             	or     $0x8e,%dh
ffff800000109a2b:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff800000109a2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109a31:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109a35:	48 89 c1             	mov    %rax,%rcx
ffff800000109a38:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a3b:	83 c0 02             	add    $0x2,%eax
ffff800000109a3e:	89 c0                	mov    %eax,%eax
ffff800000109a40:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109a47:	00 
ffff800000109a48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a4c:	48 01 d0             	add    %rdx,%rax
ffff800000109a4f:	89 ca                	mov    %ecx,%edx
ffff800000109a51:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff800000109a53:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a56:	83 c0 03             	add    $0x3,%eax
ffff800000109a59:	89 c0                	mov    %eax,%eax
ffff800000109a5b:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109a62:	00 
ffff800000109a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a67:	48 01 d0             	add    %rdx,%rax
ffff800000109a6a:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff800000109a70:	90                   	nop
ffff800000109a71:	c9                   	leave
ffff800000109a72:	c3                   	ret

ffff800000109a73 <idtinit>:

void idtinit(void)
{
ffff800000109a73:	55                   	push   %rbp
ffff800000109a74:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff800000109a77:	48 b8 c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rax
ffff800000109a7e:	80 ff ff 
ffff800000109a81:	48 8b 00             	mov    (%rax),%rax
ffff800000109a84:	be 00 10 00 00       	mov    $0x1000,%esi
ffff800000109a89:	48 89 c7             	mov    %rax,%rdi
ffff800000109a8c:	48 b8 4b 99 10 00 00 	movabs $0xffff80000010994b,%rax
ffff800000109a93:	80 ff ff 
ffff800000109a96:	ff d0                	call   *%rax
}
ffff800000109a98:	90                   	nop
ffff800000109a99:	5d                   	pop    %rbp
ffff800000109a9a:	c3                   	ret

ffff800000109a9b <tvinit>:

void tvinit(void)
{
ffff800000109a9b:	55                   	push   %rbp
ffff800000109a9c:	48 89 e5             	mov    %rsp,%rbp
ffff800000109a9f:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  idt = (uint*) kalloc();
ffff800000109aa3:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff800000109aaa:	80 ff ff 
ffff800000109aad:	ff d0                	call   *%rax
ffff800000109aaf:	48 ba c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rdx
ffff800000109ab6:	80 ff ff 
ffff800000109ab9:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff800000109abc:	48 b8 c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rax
ffff800000109ac3:	80 ff ff 
ffff800000109ac6:	48 8b 00             	mov    (%rax),%rax
ffff800000109ac9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109ace:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109ad3:	48 89 c7             	mov    %rax,%rdi
ffff800000109ad6:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff800000109add:	80 ff ff 
ffff800000109ae0:	ff d0                	call   *%rax

  for (n = 0; n < 256; n++)
ffff800000109ae2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109ae9:	eb 3b                	jmp    ffff800000109b26 <tvinit+0x8b>
    mkgate(idt, n, vectors[n], 0);
ffff800000109aeb:	48 ba 50 d7 10 00 00 	movabs $0xffff80000010d750,%rdx
ffff800000109af2:	80 ff ff 
ffff800000109af5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109af8:	48 98                	cltq
ffff800000109afa:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff800000109afe:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff800000109b01:	48 b8 c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rax
ffff800000109b08:	80 ff ff 
ffff800000109b0b:	48 8b 00             	mov    (%rax),%rax
ffff800000109b0e:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109b13:	48 89 c7             	mov    %rax,%rdi
ffff800000109b16:	48 b8 b7 99 10 00 00 	movabs $0xffff8000001099b7,%rax
ffff800000109b1d:	80 ff ff 
ffff800000109b20:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff800000109b22:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109b26:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff800000109b2d:	7e bc                	jle    ffff800000109aeb <tvinit+0x50>
}
ffff800000109b2f:	90                   	nop
ffff800000109b30:	90                   	nop
ffff800000109b31:	c9                   	leave
ffff800000109b32:	c3                   	ret

ffff800000109b33 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffff800000109b33:	55                   	push   %rbp
ffff800000109b34:	48 89 e5             	mov    %rsp,%rbp
ffff800000109b37:	41 54                	push   %r12
ffff800000109b39:	53                   	push   %rbx
ffff800000109b3a:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109b3e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff800000109b42:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109b46:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109b4a:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109b4e:	0f 84 4d 01 00 00    	je     ffff800000109ca1 <trap+0x16e>
ffff800000109b54:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109b58:	0f 87 9d 01 00 00    	ja     ffff800000109cfb <trap+0x1c8>
ffff800000109b5e:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109b62:	0f 84 52 03 00 00    	je     ffff800000109eba <trap+0x387>
ffff800000109b68:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109b6c:	0f 87 89 01 00 00    	ja     ffff800000109cfb <trap+0x1c8>
ffff800000109b72:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109b76:	0f 84 ce 00 00 00    	je     ffff800000109c4a <trap+0x117>
ffff800000109b7c:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109b80:	0f 87 75 01 00 00    	ja     ffff800000109cfb <trap+0x1c8>
ffff800000109b86:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109b8a:	0f 84 11 01 00 00    	je     ffff800000109ca1 <trap+0x16e>
ffff800000109b90:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109b94:	0f 87 61 01 00 00    	ja     ffff800000109cfb <trap+0x1c8>
ffff800000109b9a:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109b9e:	0f 84 e0 00 00 00    	je     ffff800000109c84 <trap+0x151>
ffff800000109ba4:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109ba8:	0f 87 4d 01 00 00    	ja     ffff800000109cfb <trap+0x1c8>
ffff800000109bae:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109bb2:	74 0f                	je     ffff800000109bc3 <trap+0x90>
ffff800000109bb4:	48 83 f8 21          	cmp    $0x21,%rax
ffff800000109bb8:	0f 84 a9 00 00 00    	je     ffff800000109c67 <trap+0x134>
ffff800000109bbe:	e9 38 01 00 00       	jmp    ffff800000109cfb <trap+0x1c8>
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
ffff800000109bc3:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff800000109bca:	80 ff ff 
ffff800000109bcd:	ff d0                	call   *%rax
ffff800000109bcf:	85 c0                	test   %eax,%eax
ffff800000109bd1:	75 66                	jne    ffff800000109c39 <trap+0x106>
      acquire(&tickslock);
ffff800000109bd3:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109bda:	80 ff ff 
ffff800000109bdd:	48 89 c7             	mov    %rax,%rdi
ffff800000109be0:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff800000109be7:	80 ff ff 
ffff800000109bea:	ff d0                	call   *%rax
      ticks++;
ffff800000109bec:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109bf3:	80 ff ff 
ffff800000109bf6:	8b 00                	mov    (%rax),%eax
ffff800000109bf8:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000109bfb:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109c02:	80 ff ff 
ffff800000109c05:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff800000109c07:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109c0e:	80 ff ff 
ffff800000109c11:	48 89 c7             	mov    %rax,%rdi
ffff800000109c14:	48 b8 35 72 10 00 00 	movabs $0xffff800000107235,%rax
ffff800000109c1b:	80 ff ff 
ffff800000109c1e:	ff d0                	call   *%rax
      release(&tickslock);
ffff800000109c20:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109c27:	80 ff ff 
ffff800000109c2a:	48 89 c7             	mov    %rax,%rdi
ffff800000109c2d:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff800000109c34:	80 ff ff 
ffff800000109c37:	ff d0                	call   *%rax
    }
    lapiceoi();
ffff800000109c39:	48 b8 85 49 10 00 00 	movabs $0xffff800000104985,%rax
ffff800000109c40:	80 ff ff 
ffff800000109c43:	ff d0                	call   *%rax
    break;
ffff800000109c45:	e9 71 02 00 00       	jmp    ffff800000109ebb <trap+0x388>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffff800000109c4a:	48 b8 b1 3c 10 00 00 	movabs $0xffff800000103cb1,%rax
ffff800000109c51:	80 ff ff 
ffff800000109c54:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109c56:	48 b8 85 49 10 00 00 	movabs $0xffff800000104985,%rax
ffff800000109c5d:	80 ff ff 
ffff800000109c60:	ff d0                	call   *%rax
    break;
ffff800000109c62:	e9 54 02 00 00       	jmp    ffff800000109ebb <trap+0x388>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffff800000109c67:	48 b8 3b 46 10 00 00 	movabs $0xffff80000010463b,%rax
ffff800000109c6e:	80 ff ff 
ffff800000109c71:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109c73:	48 b8 85 49 10 00 00 	movabs $0xffff800000104985,%rax
ffff800000109c7a:	80 ff ff 
ffff800000109c7d:	ff d0                	call   *%rax
    break;
ffff800000109c7f:	e9 37 02 00 00       	jmp    ffff800000109ebb <trap+0x388>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffff800000109c84:	48 b8 e3 a1 10 00 00 	movabs $0xffff80000010a1e3,%rax
ffff800000109c8b:	80 ff ff 
ffff800000109c8e:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109c90:	48 b8 85 49 10 00 00 	movabs $0xffff800000104985,%rax
ffff800000109c97:	80 ff ff 
ffff800000109c9a:	ff d0                	call   *%rax
    break;
ffff800000109c9c:	e9 1a 02 00 00       	jmp    ffff800000109ebb <trap+0x388>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff800000109ca1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ca5:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109cac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cb0:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff800000109cb7:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff800000109cbe:	80 ff ff 
ffff800000109cc1:	ff d0                	call   *%rax
ffff800000109cc3:	89 c6                	mov    %eax,%esi
ffff800000109cc5:	48 b8 b8 c9 10 00 00 	movabs $0xffff80000010c9b8,%rax
ffff800000109ccc:	80 ff ff 
ffff800000109ccf:	4c 89 e1             	mov    %r12,%rcx
ffff800000109cd2:	48 89 da             	mov    %rbx,%rdx
ffff800000109cd5:	48 89 c7             	mov    %rax,%rdi
ffff800000109cd8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109cdd:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000109ce4:	80 ff ff 
ffff800000109ce7:	41 ff d0             	call   *%r8
            cpunum(), tf->cs, tf->rip);
    lapiceoi();
ffff800000109cea:	48 b8 85 49 10 00 00 	movabs $0xffff800000104985,%rax
ffff800000109cf1:	80 ff ff 
ffff800000109cf4:	ff d0                	call   *%rax
    break;
ffff800000109cf6:	e9 c0 01 00 00       	jmp    ffff800000109ebb <trap+0x388>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff800000109cfb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d02:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d06:	48 85 c0             	test   %rax,%rax
ffff800000109d09:	74 17                	je     ffff800000109d22 <trap+0x1ef>
ffff800000109d0b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d0f:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109d16:	83 e0 03             	and    $0x3,%eax
ffff800000109d19:	48 85 c0             	test   %rax,%rax
ffff800000109d1c:	0f 85 ac 00 00 00    	jne    ffff800000109dce <trap+0x29b>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff800000109d22:	48 b8 a2 99 10 00 00 	movabs $0xffff8000001099a2,%rax
ffff800000109d29:	80 ff ff 
ffff800000109d2c:	ff d0                	call   *%rax
ffff800000109d2e:	49 89 c4             	mov    %rax,%r12
ffff800000109d31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d35:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff800000109d3c:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff800000109d43:	80 ff ff 
ffff800000109d46:	ff d0                	call   *%rax
ffff800000109d48:	89 c2                	mov    %eax,%edx
ffff800000109d4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d4e:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109d52:	48 bf e0 c9 10 00 00 	movabs $0xffff80000010c9e0,%rdi
ffff800000109d59:	80 ff ff 
ffff800000109d5c:	4d 89 e0             	mov    %r12,%r8
ffff800000109d5f:	48 89 d9             	mov    %rbx,%rcx
ffff800000109d62:	48 89 c6             	mov    %rax,%rsi
ffff800000109d65:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d6a:	49 b9 04 08 10 00 00 	movabs $0xffff800000100804,%r9
ffff800000109d71:	80 ff ff 
ffff800000109d74:	41 ff d1             	call   *%r9
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff800000109d77:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d7e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d82:	48 85 c0             	test   %rax,%rax
ffff800000109d85:	74 2e                	je     ffff800000109db5 <trap+0x282>
        cprintf("proc id: %d\n", proc->pid);
ffff800000109d87:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d8e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d92:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109d95:	48 ba 12 ca 10 00 00 	movabs $0xffff80000010ca12,%rdx
ffff800000109d9c:	80 ff ff 
ffff800000109d9f:	89 c6                	mov    %eax,%esi
ffff800000109da1:	48 89 d7             	mov    %rdx,%rdi
ffff800000109da4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109da9:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000109db0:	80 ff ff 
ffff800000109db3:	ff d2                	call   *%rdx
      panic("trap");
ffff800000109db5:	48 b8 1f ca 10 00 00 	movabs $0xffff80000010ca1f,%rax
ffff800000109dbc:	80 ff ff 
ffff800000109dbf:	48 89 c7             	mov    %rax,%rdi
ffff800000109dc2:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000109dc9:	80 ff ff 
ffff800000109dcc:	ff d0                	call   *%rax
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109dce:	48 b8 a2 99 10 00 00 	movabs $0xffff8000001099a2,%rax
ffff800000109dd5:	80 ff ff 
ffff800000109dd8:	ff d0                	call   *%rax
ffff800000109dda:	48 89 c3             	mov    %rax,%rbx
ffff800000109ddd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109de1:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109de8:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff800000109def:	80 ff ff 
ffff800000109df2:	ff d0                	call   *%rax
ffff800000109df4:	89 c1                	mov    %eax,%ecx
ffff800000109df6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109dfa:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffff800000109e01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e05:	48 8b 50 78          	mov    0x78(%rax),%rdx
            "rip 0x%p addr 0x%p--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff800000109e09:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e10:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109e14:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000109e1b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e22:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109e26:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109e29:	48 bf 28 ca 10 00 00 	movabs $0xffff80000010ca28,%rdi
ffff800000109e30:	80 ff ff 
ffff800000109e33:	53                   	push   %rbx
ffff800000109e34:	41 54                	push   %r12
ffff800000109e36:	41 89 c9             	mov    %ecx,%r9d
ffff800000109e39:	48 89 d1             	mov    %rdx,%rcx
ffff800000109e3c:	48 89 f2             	mov    %rsi,%rdx
ffff800000109e3f:	89 c6                	mov    %eax,%esi
ffff800000109e41:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e46:	49 ba 04 08 10 00 00 	movabs $0xffff800000100804,%r10
ffff800000109e4d:	80 ff ff 
ffff800000109e50:	41 ff d2             	call   *%r10
ffff800000109e53:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
            
    // cprintf("debug: recording trap event\n");
    traceevent(TRACE_TYPE_TRAP, proc->pid, tf->trapno, tf->err, proc->name);
ffff800000109e57:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e5e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109e62:	48 8d 90 d0 00 00 00 	lea    0xd0(%rax),%rdx
ffff800000109e69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e6d:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
ffff800000109e74:	89 c1                	mov    %eax,%ecx
ffff800000109e76:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e7a:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109e7e:	89 c6                	mov    %eax,%esi
ffff800000109e80:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e87:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109e8b:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109e8e:	49 89 d0             	mov    %rdx,%r8
ffff800000109e91:	89 f2                	mov    %esi,%edx
ffff800000109e93:	89 c6                	mov    %eax,%esi
ffff800000109e95:	bf 03 00 00 00       	mov    $0x3,%edi
ffff800000109e9a:	48 b8 66 c1 10 00 00 	movabs $0xffff80000010c166,%rax
ffff800000109ea1:	80 ff ff 
ffff800000109ea4:	ff d0                	call   *%rax
    proc->killed = 1;
ffff800000109ea6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ead:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109eb1:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff800000109eb8:	eb 01                	jmp    ffff800000109ebb <trap+0x388>
    break;
ffff800000109eba:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109ebb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ec2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ec6:	48 85 c0             	test   %rax,%rax
ffff800000109ec9:	74 32                	je     ffff800000109efd <trap+0x3ca>
ffff800000109ecb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ed2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ed6:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109ed9:	85 c0                	test   %eax,%eax
ffff800000109edb:	74 20                	je     ffff800000109efd <trap+0x3ca>
ffff800000109edd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ee1:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109ee8:	83 e0 03             	and    $0x3,%eax
ffff800000109eeb:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109eef:	75 0c                	jne    ffff800000109efd <trap+0x3ca>
    exit();
ffff800000109ef1:	48 b8 03 6a 10 00 00 	movabs $0xffff800000106a03,%rax
ffff800000109ef8:	80 ff ff 
ffff800000109efb:	ff d0                	call   *%rax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff800000109efd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f04:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f08:	48 85 c0             	test   %rax,%rax
ffff800000109f0b:	74 2d                	je     ffff800000109f3a <trap+0x407>
ffff800000109f0d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f14:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f18:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000109f1b:	83 f8 04             	cmp    $0x4,%eax
ffff800000109f1e:	75 1a                	jne    ffff800000109f3a <trap+0x407>
ffff800000109f20:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f24:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109f28:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109f2c:	75 0c                	jne    ffff800000109f3a <trap+0x407>
    yield();
ffff800000109f2e:	48 b8 07 70 10 00 00 	movabs $0xffff800000107007,%rax
ffff800000109f35:	80 ff ff 
ffff800000109f38:	ff d0                	call   *%rax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109f3a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f41:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f45:	48 85 c0             	test   %rax,%rax
ffff800000109f48:	74 32                	je     ffff800000109f7c <trap+0x449>
ffff800000109f4a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f51:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f55:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109f58:	85 c0                	test   %eax,%eax
ffff800000109f5a:	74 20                	je     ffff800000109f7c <trap+0x449>
ffff800000109f5c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f60:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109f67:	83 e0 03             	and    $0x3,%eax
ffff800000109f6a:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109f6e:	75 0c                	jne    ffff800000109f7c <trap+0x449>
    exit();
ffff800000109f70:	48 b8 03 6a 10 00 00 	movabs $0xffff800000106a03,%rax
ffff800000109f77:	80 ff ff 
ffff800000109f7a:	ff d0                	call   *%rax
}
ffff800000109f7c:	90                   	nop
ffff800000109f7d:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff800000109f81:	5b                   	pop    %rbx
ffff800000109f82:	41 5c                	pop    %r12
ffff800000109f84:	5d                   	pop    %rbp
ffff800000109f85:	c3                   	ret

ffff800000109f86 <inb>:
{
ffff800000109f86:	55                   	push   %rbp
ffff800000109f87:	48 89 e5             	mov    %rsp,%rbp
ffff800000109f8a:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000109f8e:	89 f8                	mov    %edi,%eax
ffff800000109f90:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000109f94:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000109f98:	89 c2                	mov    %eax,%edx
ffff800000109f9a:	ec                   	in     (%dx),%al
ffff800000109f9b:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000109f9e:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000109fa2:	c9                   	leave
ffff800000109fa3:	c3                   	ret

ffff800000109fa4 <outb>:
{
ffff800000109fa4:	55                   	push   %rbp
ffff800000109fa5:	48 89 e5             	mov    %rsp,%rbp
ffff800000109fa8:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000109fac:	89 fa                	mov    %edi,%edx
ffff800000109fae:	89 f0                	mov    %esi,%eax
ffff800000109fb0:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000109fb4:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000109fb7:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000109fbb:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000109fbf:	ee                   	out    %al,(%dx)
}
ffff800000109fc0:	90                   	nop
ffff800000109fc1:	c9                   	leave
ffff800000109fc2:	c3                   	ret

ffff800000109fc3 <uartearlyinit>:

static int uart;    // is there a uart?

void
uartearlyinit(void)
{
ffff800000109fc3:	55                   	push   %rbp
ffff800000109fc4:	48 89 e5             	mov    %rsp,%rbp
ffff800000109fc7:	48 83 ec 10          	sub    $0x10,%rsp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
ffff800000109fcb:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109fd0:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff800000109fd5:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff800000109fdc:	80 ff ff 
ffff800000109fdf:	ff d0                	call   *%rax

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffff800000109fe1:	be 80 00 00 00       	mov    $0x80,%esi
ffff800000109fe6:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff800000109feb:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff800000109ff2:	80 ff ff 
ffff800000109ff5:	ff d0                	call   *%rax
  outb(COM1+0, 115200/9600);
ffff800000109ff7:	be 0c 00 00 00       	mov    $0xc,%esi
ffff800000109ffc:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a001:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff80000010a008:	80 ff ff 
ffff80000010a00b:	ff d0                	call   *%rax
  outb(COM1+1, 0);
ffff80000010a00d:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a012:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a017:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff80000010a01e:	80 ff ff 
ffff80000010a021:	ff d0                	call   *%rax
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffff80000010a023:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010a028:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a02d:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff80000010a034:	80 ff ff 
ffff80000010a037:	ff d0                	call   *%rax
  outb(COM1+4, 0);
ffff80000010a039:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a03e:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff80000010a043:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff80000010a04a:	80 ff ff 
ffff80000010a04d:	ff d0                	call   *%rax
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffff80000010a04f:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010a054:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a059:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff80000010a060:	80 ff ff 
ffff80000010a063:	ff d0                	call   *%rax

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffff80000010a065:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a06a:	48 b8 86 9f 10 00 00 	movabs $0xffff800000109f86,%rax
ffff80000010a071:	80 ff ff 
ffff80000010a074:	ff d0                	call   *%rax
ffff80000010a076:	3c ff                	cmp    $0xff,%al
ffff80000010a078:	74 4a                	je     ffff80000010a0c4 <uartearlyinit+0x101>
    return;
  uart = 1;
ffff80000010a07a:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a081:	80 ff ff 
ffff80000010a084:	c7 00 01 00 00 00    	movl   $0x1,(%rax)



  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffff80000010a08a:	48 b8 6b ca 10 00 00 	movabs $0xffff80000010ca6b,%rax
ffff80000010a091:	80 ff ff 
ffff80000010a094:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010a098:	eb 1d                	jmp    ffff80000010a0b7 <uartearlyinit+0xf4>
    uartputc(*p);
ffff80000010a09a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a09e:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a0a1:	0f be c0             	movsbl %al,%eax
ffff80000010a0a4:	89 c7                	mov    %eax,%edi
ffff80000010a0a6:	48 b8 18 a1 10 00 00 	movabs $0xffff80000010a118,%rax
ffff80000010a0ad:	80 ff ff 
ffff80000010a0b0:	ff d0                	call   *%rax
  for(p="xv6...\n"; *p; p++)
ffff80000010a0b2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010a0b7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a0bb:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a0be:	84 c0                	test   %al,%al
ffff80000010a0c0:	75 d8                	jne    ffff80000010a09a <uartearlyinit+0xd7>
ffff80000010a0c2:	eb 01                	jmp    ffff80000010a0c5 <uartearlyinit+0x102>
    return;
ffff80000010a0c4:	90                   	nop
}
ffff80000010a0c5:	c9                   	leave
ffff80000010a0c6:	c3                   	ret

ffff80000010a0c7 <uartinit>:

void
uartinit(void)
{
ffff80000010a0c7:	55                   	push   %rbp
ffff80000010a0c8:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a0cb:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a0d2:	80 ff ff 
ffff80000010a0d5:	8b 00                	mov    (%rax),%eax
ffff80000010a0d7:	85 c0                	test   %eax,%eax
ffff80000010a0d9:	74 3a                	je     ffff80000010a115 <uartinit+0x4e>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffff80000010a0db:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a0e0:	48 b8 86 9f 10 00 00 	movabs $0xffff800000109f86,%rax
ffff80000010a0e7:	80 ff ff 
ffff80000010a0ea:	ff d0                	call   *%rax
  inb(COM1+0);
ffff80000010a0ec:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a0f1:	48 b8 86 9f 10 00 00 	movabs $0xffff800000109f86,%rax
ffff80000010a0f8:	80 ff ff 
ffff80000010a0fb:	ff d0                	call   *%rax
  ioapicenable(IRQ_COM1, 0);
ffff80000010a0fd:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a102:	bf 04 00 00 00       	mov    $0x4,%edi
ffff80000010a107:	48 b8 96 40 10 00 00 	movabs $0xffff800000104096,%rax
ffff80000010a10e:	80 ff ff 
ffff80000010a111:	ff d0                	call   *%rax
ffff80000010a113:	eb 01                	jmp    ffff80000010a116 <uartinit+0x4f>
    return;
ffff80000010a115:	90                   	nop

}
ffff80000010a116:	5d                   	pop    %rbp
ffff80000010a117:	c3                   	ret

ffff80000010a118 <uartputc>:
void
uartputc(int c)
{
ffff80000010a118:	55                   	push   %rbp
ffff80000010a119:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a11c:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010a120:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffff80000010a123:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a12a:	80 ff ff 
ffff80000010a12d:	8b 00                	mov    (%rax),%eax
ffff80000010a12f:	85 c0                	test   %eax,%eax
ffff80000010a131:	74 5a                	je     ffff80000010a18d <uartputc+0x75>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010a133:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a13a:	eb 15                	jmp    ffff80000010a151 <uartputc+0x39>
    microdelay(10);
ffff80000010a13c:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff80000010a141:	48 b8 b4 49 10 00 00 	movabs $0xffff8000001049b4,%rax
ffff80000010a148:	80 ff ff 
ffff80000010a14b:	ff d0                	call   *%rax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff80000010a14d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010a151:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff80000010a155:	7f 1b                	jg     ffff80000010a172 <uartputc+0x5a>
ffff80000010a157:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a15c:	48 b8 86 9f 10 00 00 	movabs $0xffff800000109f86,%rax
ffff80000010a163:	80 ff ff 
ffff80000010a166:	ff d0                	call   *%rax
ffff80000010a168:	0f b6 c0             	movzbl %al,%eax
ffff80000010a16b:	83 e0 20             	and    $0x20,%eax
ffff80000010a16e:	85 c0                	test   %eax,%eax
ffff80000010a170:	74 ca                	je     ffff80000010a13c <uartputc+0x24>
  outb(COM1+0, c);
ffff80000010a172:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010a175:	0f b6 c0             	movzbl %al,%eax
ffff80000010a178:	89 c6                	mov    %eax,%esi
ffff80000010a17a:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a17f:	48 b8 a4 9f 10 00 00 	movabs $0xffff800000109fa4,%rax
ffff80000010a186:	80 ff ff 
ffff80000010a189:	ff d0                	call   *%rax
ffff80000010a18b:	eb 01                	jmp    ffff80000010a18e <uartputc+0x76>
    return;
ffff80000010a18d:	90                   	nop
}
ffff80000010a18e:	c9                   	leave
ffff80000010a18f:	c3                   	ret

ffff80000010a190 <uartgetc>:

static int
uartgetc(void)
{
ffff80000010a190:	55                   	push   %rbp
ffff80000010a191:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff80000010a194:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a19b:	80 ff ff 
ffff80000010a19e:	8b 00                	mov    (%rax),%eax
ffff80000010a1a0:	85 c0                	test   %eax,%eax
ffff80000010a1a2:	75 07                	jne    ffff80000010a1ab <uartgetc+0x1b>
    return -1;
ffff80000010a1a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a1a9:	eb 36                	jmp    ffff80000010a1e1 <uartgetc+0x51>
  if(!(inb(COM1+5) & 0x01))
ffff80000010a1ab:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a1b0:	48 b8 86 9f 10 00 00 	movabs $0xffff800000109f86,%rax
ffff80000010a1b7:	80 ff ff 
ffff80000010a1ba:	ff d0                	call   *%rax
ffff80000010a1bc:	0f b6 c0             	movzbl %al,%eax
ffff80000010a1bf:	83 e0 01             	and    $0x1,%eax
ffff80000010a1c2:	85 c0                	test   %eax,%eax
ffff80000010a1c4:	75 07                	jne    ffff80000010a1cd <uartgetc+0x3d>
    return -1;
ffff80000010a1c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a1cb:	eb 14                	jmp    ffff80000010a1e1 <uartgetc+0x51>
  return inb(COM1+0);
ffff80000010a1cd:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a1d2:	48 b8 86 9f 10 00 00 	movabs $0xffff800000109f86,%rax
ffff80000010a1d9:	80 ff ff 
ffff80000010a1dc:	ff d0                	call   *%rax
ffff80000010a1de:	0f b6 c0             	movzbl %al,%eax
}
ffff80000010a1e1:	5d                   	pop    %rbp
ffff80000010a1e2:	c3                   	ret

ffff80000010a1e3 <uartintr>:

void
uartintr(void)
{
ffff80000010a1e3:	55                   	push   %rbp
ffff80000010a1e4:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffff80000010a1e7:	48 b8 90 a1 10 00 00 	movabs $0xffff80000010a190,%rax
ffff80000010a1ee:	80 ff ff 
ffff80000010a1f1:	48 89 c7             	mov    %rax,%rdi
ffff80000010a1f4:	48 b8 97 10 10 00 00 	movabs $0xffff800000101097,%rax
ffff80000010a1fb:	80 ff ff 
ffff80000010a1fe:	ff d0                	call   *%rax
}
ffff80000010a200:	90                   	nop
ffff80000010a201:	5d                   	pop    %rbp
ffff80000010a202:	c3                   	ret

ffff80000010a203 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.global alltraps
vector0:
  push $0
ffff80000010a203:	6a 00                	push   $0x0
  push $0
ffff80000010a205:	6a 00                	push   $0x0
  jmp alltraps
ffff80000010a207:	e9 8d f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a20c <vector1>:
vector1:
  push $0
ffff80000010a20c:	6a 00                	push   $0x0
  push $1
ffff80000010a20e:	6a 01                	push   $0x1
  jmp alltraps
ffff80000010a210:	e9 84 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a215 <vector2>:
vector2:
  push $0
ffff80000010a215:	6a 00                	push   $0x0
  push $2
ffff80000010a217:	6a 02                	push   $0x2
  jmp alltraps
ffff80000010a219:	e9 7b f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a21e <vector3>:
vector3:
  push $0
ffff80000010a21e:	6a 00                	push   $0x0
  push $3
ffff80000010a220:	6a 03                	push   $0x3
  jmp alltraps
ffff80000010a222:	e9 72 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a227 <vector4>:
vector4:
  push $0
ffff80000010a227:	6a 00                	push   $0x0
  push $4
ffff80000010a229:	6a 04                	push   $0x4
  jmp alltraps
ffff80000010a22b:	e9 69 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a230 <vector5>:
vector5:
  push $0
ffff80000010a230:	6a 00                	push   $0x0
  push $5
ffff80000010a232:	6a 05                	push   $0x5
  jmp alltraps
ffff80000010a234:	e9 60 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a239 <vector6>:
vector6:
  push $0
ffff80000010a239:	6a 00                	push   $0x0
  push $6
ffff80000010a23b:	6a 06                	push   $0x6
  jmp alltraps
ffff80000010a23d:	e9 57 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a242 <vector7>:
vector7:
  push $0
ffff80000010a242:	6a 00                	push   $0x0
  push $7
ffff80000010a244:	6a 07                	push   $0x7
  jmp alltraps
ffff80000010a246:	e9 4e f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a24b <vector8>:
vector8:
  push $8
ffff80000010a24b:	6a 08                	push   $0x8
  jmp alltraps
ffff80000010a24d:	e9 47 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a252 <vector9>:
vector9:
  push $0
ffff80000010a252:	6a 00                	push   $0x0
  push $9
ffff80000010a254:	6a 09                	push   $0x9
  jmp alltraps
ffff80000010a256:	e9 3e f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a25b <vector10>:
vector10:
  push $10
ffff80000010a25b:	6a 0a                	push   $0xa
  jmp alltraps
ffff80000010a25d:	e9 37 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a262 <vector11>:
vector11:
  push $11
ffff80000010a262:	6a 0b                	push   $0xb
  jmp alltraps
ffff80000010a264:	e9 30 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a269 <vector12>:
vector12:
  push $12
ffff80000010a269:	6a 0c                	push   $0xc
  jmp alltraps
ffff80000010a26b:	e9 29 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a270 <vector13>:
vector13:
  push $13
ffff80000010a270:	6a 0d                	push   $0xd
  jmp alltraps
ffff80000010a272:	e9 22 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a277 <vector14>:
vector14:
  push $14
ffff80000010a277:	6a 0e                	push   $0xe
  jmp alltraps
ffff80000010a279:	e9 1b f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a27e <vector15>:
vector15:
  push $0
ffff80000010a27e:	6a 00                	push   $0x0
  push $15
ffff80000010a280:	6a 0f                	push   $0xf
  jmp alltraps
ffff80000010a282:	e9 12 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a287 <vector16>:
vector16:
  push $0
ffff80000010a287:	6a 00                	push   $0x0
  push $16
ffff80000010a289:	6a 10                	push   $0x10
  jmp alltraps
ffff80000010a28b:	e9 09 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a290 <vector17>:
vector17:
  push $17
ffff80000010a290:	6a 11                	push   $0x11
  jmp alltraps
ffff80000010a292:	e9 02 f6 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a297 <vector18>:
vector18:
  push $0
ffff80000010a297:	6a 00                	push   $0x0
  push $18
ffff80000010a299:	6a 12                	push   $0x12
  jmp alltraps
ffff80000010a29b:	e9 f9 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2a0 <vector19>:
vector19:
  push $0
ffff80000010a2a0:	6a 00                	push   $0x0
  push $19
ffff80000010a2a2:	6a 13                	push   $0x13
  jmp alltraps
ffff80000010a2a4:	e9 f0 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2a9 <vector20>:
vector20:
  push $0
ffff80000010a2a9:	6a 00                	push   $0x0
  push $20
ffff80000010a2ab:	6a 14                	push   $0x14
  jmp alltraps
ffff80000010a2ad:	e9 e7 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2b2 <vector21>:
vector21:
  push $0
ffff80000010a2b2:	6a 00                	push   $0x0
  push $21
ffff80000010a2b4:	6a 15                	push   $0x15
  jmp alltraps
ffff80000010a2b6:	e9 de f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2bb <vector22>:
vector22:
  push $0
ffff80000010a2bb:	6a 00                	push   $0x0
  push $22
ffff80000010a2bd:	6a 16                	push   $0x16
  jmp alltraps
ffff80000010a2bf:	e9 d5 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2c4 <vector23>:
vector23:
  push $0
ffff80000010a2c4:	6a 00                	push   $0x0
  push $23
ffff80000010a2c6:	6a 17                	push   $0x17
  jmp alltraps
ffff80000010a2c8:	e9 cc f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2cd <vector24>:
vector24:
  push $0
ffff80000010a2cd:	6a 00                	push   $0x0
  push $24
ffff80000010a2cf:	6a 18                	push   $0x18
  jmp alltraps
ffff80000010a2d1:	e9 c3 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2d6 <vector25>:
vector25:
  push $0
ffff80000010a2d6:	6a 00                	push   $0x0
  push $25
ffff80000010a2d8:	6a 19                	push   $0x19
  jmp alltraps
ffff80000010a2da:	e9 ba f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2df <vector26>:
vector26:
  push $0
ffff80000010a2df:	6a 00                	push   $0x0
  push $26
ffff80000010a2e1:	6a 1a                	push   $0x1a
  jmp alltraps
ffff80000010a2e3:	e9 b1 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2e8 <vector27>:
vector27:
  push $0
ffff80000010a2e8:	6a 00                	push   $0x0
  push $27
ffff80000010a2ea:	6a 1b                	push   $0x1b
  jmp alltraps
ffff80000010a2ec:	e9 a8 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2f1 <vector28>:
vector28:
  push $0
ffff80000010a2f1:	6a 00                	push   $0x0
  push $28
ffff80000010a2f3:	6a 1c                	push   $0x1c
  jmp alltraps
ffff80000010a2f5:	e9 9f f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a2fa <vector29>:
vector29:
  push $0
ffff80000010a2fa:	6a 00                	push   $0x0
  push $29
ffff80000010a2fc:	6a 1d                	push   $0x1d
  jmp alltraps
ffff80000010a2fe:	e9 96 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a303 <vector30>:
vector30:
  push $0
ffff80000010a303:	6a 00                	push   $0x0
  push $30
ffff80000010a305:	6a 1e                	push   $0x1e
  jmp alltraps
ffff80000010a307:	e9 8d f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a30c <vector31>:
vector31:
  push $0
ffff80000010a30c:	6a 00                	push   $0x0
  push $31
ffff80000010a30e:	6a 1f                	push   $0x1f
  jmp alltraps
ffff80000010a310:	e9 84 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a315 <vector32>:
vector32:
  push $0
ffff80000010a315:	6a 00                	push   $0x0
  push $32
ffff80000010a317:	6a 20                	push   $0x20
  jmp alltraps
ffff80000010a319:	e9 7b f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a31e <vector33>:
vector33:
  push $0
ffff80000010a31e:	6a 00                	push   $0x0
  push $33
ffff80000010a320:	6a 21                	push   $0x21
  jmp alltraps
ffff80000010a322:	e9 72 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a327 <vector34>:
vector34:
  push $0
ffff80000010a327:	6a 00                	push   $0x0
  push $34
ffff80000010a329:	6a 22                	push   $0x22
  jmp alltraps
ffff80000010a32b:	e9 69 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a330 <vector35>:
vector35:
  push $0
ffff80000010a330:	6a 00                	push   $0x0
  push $35
ffff80000010a332:	6a 23                	push   $0x23
  jmp alltraps
ffff80000010a334:	e9 60 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a339 <vector36>:
vector36:
  push $0
ffff80000010a339:	6a 00                	push   $0x0
  push $36
ffff80000010a33b:	6a 24                	push   $0x24
  jmp alltraps
ffff80000010a33d:	e9 57 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a342 <vector37>:
vector37:
  push $0
ffff80000010a342:	6a 00                	push   $0x0
  push $37
ffff80000010a344:	6a 25                	push   $0x25
  jmp alltraps
ffff80000010a346:	e9 4e f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a34b <vector38>:
vector38:
  push $0
ffff80000010a34b:	6a 00                	push   $0x0
  push $38
ffff80000010a34d:	6a 26                	push   $0x26
  jmp alltraps
ffff80000010a34f:	e9 45 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a354 <vector39>:
vector39:
  push $0
ffff80000010a354:	6a 00                	push   $0x0
  push $39
ffff80000010a356:	6a 27                	push   $0x27
  jmp alltraps
ffff80000010a358:	e9 3c f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a35d <vector40>:
vector40:
  push $0
ffff80000010a35d:	6a 00                	push   $0x0
  push $40
ffff80000010a35f:	6a 28                	push   $0x28
  jmp alltraps
ffff80000010a361:	e9 33 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a366 <vector41>:
vector41:
  push $0
ffff80000010a366:	6a 00                	push   $0x0
  push $41
ffff80000010a368:	6a 29                	push   $0x29
  jmp alltraps
ffff80000010a36a:	e9 2a f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a36f <vector42>:
vector42:
  push $0
ffff80000010a36f:	6a 00                	push   $0x0
  push $42
ffff80000010a371:	6a 2a                	push   $0x2a
  jmp alltraps
ffff80000010a373:	e9 21 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a378 <vector43>:
vector43:
  push $0
ffff80000010a378:	6a 00                	push   $0x0
  push $43
ffff80000010a37a:	6a 2b                	push   $0x2b
  jmp alltraps
ffff80000010a37c:	e9 18 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a381 <vector44>:
vector44:
  push $0
ffff80000010a381:	6a 00                	push   $0x0
  push $44
ffff80000010a383:	6a 2c                	push   $0x2c
  jmp alltraps
ffff80000010a385:	e9 0f f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a38a <vector45>:
vector45:
  push $0
ffff80000010a38a:	6a 00                	push   $0x0
  push $45
ffff80000010a38c:	6a 2d                	push   $0x2d
  jmp alltraps
ffff80000010a38e:	e9 06 f5 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a393 <vector46>:
vector46:
  push $0
ffff80000010a393:	6a 00                	push   $0x0
  push $46
ffff80000010a395:	6a 2e                	push   $0x2e
  jmp alltraps
ffff80000010a397:	e9 fd f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a39c <vector47>:
vector47:
  push $0
ffff80000010a39c:	6a 00                	push   $0x0
  push $47
ffff80000010a39e:	6a 2f                	push   $0x2f
  jmp alltraps
ffff80000010a3a0:	e9 f4 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3a5 <vector48>:
vector48:
  push $0
ffff80000010a3a5:	6a 00                	push   $0x0
  push $48
ffff80000010a3a7:	6a 30                	push   $0x30
  jmp alltraps
ffff80000010a3a9:	e9 eb f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3ae <vector49>:
vector49:
  push $0
ffff80000010a3ae:	6a 00                	push   $0x0
  push $49
ffff80000010a3b0:	6a 31                	push   $0x31
  jmp alltraps
ffff80000010a3b2:	e9 e2 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3b7 <vector50>:
vector50:
  push $0
ffff80000010a3b7:	6a 00                	push   $0x0
  push $50
ffff80000010a3b9:	6a 32                	push   $0x32
  jmp alltraps
ffff80000010a3bb:	e9 d9 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3c0 <vector51>:
vector51:
  push $0
ffff80000010a3c0:	6a 00                	push   $0x0
  push $51
ffff80000010a3c2:	6a 33                	push   $0x33
  jmp alltraps
ffff80000010a3c4:	e9 d0 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3c9 <vector52>:
vector52:
  push $0
ffff80000010a3c9:	6a 00                	push   $0x0
  push $52
ffff80000010a3cb:	6a 34                	push   $0x34
  jmp alltraps
ffff80000010a3cd:	e9 c7 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3d2 <vector53>:
vector53:
  push $0
ffff80000010a3d2:	6a 00                	push   $0x0
  push $53
ffff80000010a3d4:	6a 35                	push   $0x35
  jmp alltraps
ffff80000010a3d6:	e9 be f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3db <vector54>:
vector54:
  push $0
ffff80000010a3db:	6a 00                	push   $0x0
  push $54
ffff80000010a3dd:	6a 36                	push   $0x36
  jmp alltraps
ffff80000010a3df:	e9 b5 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3e4 <vector55>:
vector55:
  push $0
ffff80000010a3e4:	6a 00                	push   $0x0
  push $55
ffff80000010a3e6:	6a 37                	push   $0x37
  jmp alltraps
ffff80000010a3e8:	e9 ac f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3ed <vector56>:
vector56:
  push $0
ffff80000010a3ed:	6a 00                	push   $0x0
  push $56
ffff80000010a3ef:	6a 38                	push   $0x38
  jmp alltraps
ffff80000010a3f1:	e9 a3 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3f6 <vector57>:
vector57:
  push $0
ffff80000010a3f6:	6a 00                	push   $0x0
  push $57
ffff80000010a3f8:	6a 39                	push   $0x39
  jmp alltraps
ffff80000010a3fa:	e9 9a f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a3ff <vector58>:
vector58:
  push $0
ffff80000010a3ff:	6a 00                	push   $0x0
  push $58
ffff80000010a401:	6a 3a                	push   $0x3a
  jmp alltraps
ffff80000010a403:	e9 91 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a408 <vector59>:
vector59:
  push $0
ffff80000010a408:	6a 00                	push   $0x0
  push $59
ffff80000010a40a:	6a 3b                	push   $0x3b
  jmp alltraps
ffff80000010a40c:	e9 88 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a411 <vector60>:
vector60:
  push $0
ffff80000010a411:	6a 00                	push   $0x0
  push $60
ffff80000010a413:	6a 3c                	push   $0x3c
  jmp alltraps
ffff80000010a415:	e9 7f f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a41a <vector61>:
vector61:
  push $0
ffff80000010a41a:	6a 00                	push   $0x0
  push $61
ffff80000010a41c:	6a 3d                	push   $0x3d
  jmp alltraps
ffff80000010a41e:	e9 76 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a423 <vector62>:
vector62:
  push $0
ffff80000010a423:	6a 00                	push   $0x0
  push $62
ffff80000010a425:	6a 3e                	push   $0x3e
  jmp alltraps
ffff80000010a427:	e9 6d f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a42c <vector63>:
vector63:
  push $0
ffff80000010a42c:	6a 00                	push   $0x0
  push $63
ffff80000010a42e:	6a 3f                	push   $0x3f
  jmp alltraps
ffff80000010a430:	e9 64 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a435 <vector64>:
vector64:
  push $0
ffff80000010a435:	6a 00                	push   $0x0
  push $64
ffff80000010a437:	6a 40                	push   $0x40
  jmp alltraps
ffff80000010a439:	e9 5b f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a43e <vector65>:
vector65:
  push $0
ffff80000010a43e:	6a 00                	push   $0x0
  push $65
ffff80000010a440:	6a 41                	push   $0x41
  jmp alltraps
ffff80000010a442:	e9 52 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a447 <vector66>:
vector66:
  push $0
ffff80000010a447:	6a 00                	push   $0x0
  push $66
ffff80000010a449:	6a 42                	push   $0x42
  jmp alltraps
ffff80000010a44b:	e9 49 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a450 <vector67>:
vector67:
  push $0
ffff80000010a450:	6a 00                	push   $0x0
  push $67
ffff80000010a452:	6a 43                	push   $0x43
  jmp alltraps
ffff80000010a454:	e9 40 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a459 <vector68>:
vector68:
  push $0
ffff80000010a459:	6a 00                	push   $0x0
  push $68
ffff80000010a45b:	6a 44                	push   $0x44
  jmp alltraps
ffff80000010a45d:	e9 37 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a462 <vector69>:
vector69:
  push $0
ffff80000010a462:	6a 00                	push   $0x0
  push $69
ffff80000010a464:	6a 45                	push   $0x45
  jmp alltraps
ffff80000010a466:	e9 2e f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a46b <vector70>:
vector70:
  push $0
ffff80000010a46b:	6a 00                	push   $0x0
  push $70
ffff80000010a46d:	6a 46                	push   $0x46
  jmp alltraps
ffff80000010a46f:	e9 25 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a474 <vector71>:
vector71:
  push $0
ffff80000010a474:	6a 00                	push   $0x0
  push $71
ffff80000010a476:	6a 47                	push   $0x47
  jmp alltraps
ffff80000010a478:	e9 1c f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a47d <vector72>:
vector72:
  push $0
ffff80000010a47d:	6a 00                	push   $0x0
  push $72
ffff80000010a47f:	6a 48                	push   $0x48
  jmp alltraps
ffff80000010a481:	e9 13 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a486 <vector73>:
vector73:
  push $0
ffff80000010a486:	6a 00                	push   $0x0
  push $73
ffff80000010a488:	6a 49                	push   $0x49
  jmp alltraps
ffff80000010a48a:	e9 0a f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a48f <vector74>:
vector74:
  push $0
ffff80000010a48f:	6a 00                	push   $0x0
  push $74
ffff80000010a491:	6a 4a                	push   $0x4a
  jmp alltraps
ffff80000010a493:	e9 01 f4 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a498 <vector75>:
vector75:
  push $0
ffff80000010a498:	6a 00                	push   $0x0
  push $75
ffff80000010a49a:	6a 4b                	push   $0x4b
  jmp alltraps
ffff80000010a49c:	e9 f8 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4a1 <vector76>:
vector76:
  push $0
ffff80000010a4a1:	6a 00                	push   $0x0
  push $76
ffff80000010a4a3:	6a 4c                	push   $0x4c
  jmp alltraps
ffff80000010a4a5:	e9 ef f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4aa <vector77>:
vector77:
  push $0
ffff80000010a4aa:	6a 00                	push   $0x0
  push $77
ffff80000010a4ac:	6a 4d                	push   $0x4d
  jmp alltraps
ffff80000010a4ae:	e9 e6 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4b3 <vector78>:
vector78:
  push $0
ffff80000010a4b3:	6a 00                	push   $0x0
  push $78
ffff80000010a4b5:	6a 4e                	push   $0x4e
  jmp alltraps
ffff80000010a4b7:	e9 dd f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4bc <vector79>:
vector79:
  push $0
ffff80000010a4bc:	6a 00                	push   $0x0
  push $79
ffff80000010a4be:	6a 4f                	push   $0x4f
  jmp alltraps
ffff80000010a4c0:	e9 d4 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4c5 <vector80>:
vector80:
  push $0
ffff80000010a4c5:	6a 00                	push   $0x0
  push $80
ffff80000010a4c7:	6a 50                	push   $0x50
  jmp alltraps
ffff80000010a4c9:	e9 cb f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4ce <vector81>:
vector81:
  push $0
ffff80000010a4ce:	6a 00                	push   $0x0
  push $81
ffff80000010a4d0:	6a 51                	push   $0x51
  jmp alltraps
ffff80000010a4d2:	e9 c2 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4d7 <vector82>:
vector82:
  push $0
ffff80000010a4d7:	6a 00                	push   $0x0
  push $82
ffff80000010a4d9:	6a 52                	push   $0x52
  jmp alltraps
ffff80000010a4db:	e9 b9 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4e0 <vector83>:
vector83:
  push $0
ffff80000010a4e0:	6a 00                	push   $0x0
  push $83
ffff80000010a4e2:	6a 53                	push   $0x53
  jmp alltraps
ffff80000010a4e4:	e9 b0 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4e9 <vector84>:
vector84:
  push $0
ffff80000010a4e9:	6a 00                	push   $0x0
  push $84
ffff80000010a4eb:	6a 54                	push   $0x54
  jmp alltraps
ffff80000010a4ed:	e9 a7 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4f2 <vector85>:
vector85:
  push $0
ffff80000010a4f2:	6a 00                	push   $0x0
  push $85
ffff80000010a4f4:	6a 55                	push   $0x55
  jmp alltraps
ffff80000010a4f6:	e9 9e f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a4fb <vector86>:
vector86:
  push $0
ffff80000010a4fb:	6a 00                	push   $0x0
  push $86
ffff80000010a4fd:	6a 56                	push   $0x56
  jmp alltraps
ffff80000010a4ff:	e9 95 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a504 <vector87>:
vector87:
  push $0
ffff80000010a504:	6a 00                	push   $0x0
  push $87
ffff80000010a506:	6a 57                	push   $0x57
  jmp alltraps
ffff80000010a508:	e9 8c f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a50d <vector88>:
vector88:
  push $0
ffff80000010a50d:	6a 00                	push   $0x0
  push $88
ffff80000010a50f:	6a 58                	push   $0x58
  jmp alltraps
ffff80000010a511:	e9 83 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a516 <vector89>:
vector89:
  push $0
ffff80000010a516:	6a 00                	push   $0x0
  push $89
ffff80000010a518:	6a 59                	push   $0x59
  jmp alltraps
ffff80000010a51a:	e9 7a f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a51f <vector90>:
vector90:
  push $0
ffff80000010a51f:	6a 00                	push   $0x0
  push $90
ffff80000010a521:	6a 5a                	push   $0x5a
  jmp alltraps
ffff80000010a523:	e9 71 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a528 <vector91>:
vector91:
  push $0
ffff80000010a528:	6a 00                	push   $0x0
  push $91
ffff80000010a52a:	6a 5b                	push   $0x5b
  jmp alltraps
ffff80000010a52c:	e9 68 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a531 <vector92>:
vector92:
  push $0
ffff80000010a531:	6a 00                	push   $0x0
  push $92
ffff80000010a533:	6a 5c                	push   $0x5c
  jmp alltraps
ffff80000010a535:	e9 5f f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a53a <vector93>:
vector93:
  push $0
ffff80000010a53a:	6a 00                	push   $0x0
  push $93
ffff80000010a53c:	6a 5d                	push   $0x5d
  jmp alltraps
ffff80000010a53e:	e9 56 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a543 <vector94>:
vector94:
  push $0
ffff80000010a543:	6a 00                	push   $0x0
  push $94
ffff80000010a545:	6a 5e                	push   $0x5e
  jmp alltraps
ffff80000010a547:	e9 4d f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a54c <vector95>:
vector95:
  push $0
ffff80000010a54c:	6a 00                	push   $0x0
  push $95
ffff80000010a54e:	6a 5f                	push   $0x5f
  jmp alltraps
ffff80000010a550:	e9 44 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a555 <vector96>:
vector96:
  push $0
ffff80000010a555:	6a 00                	push   $0x0
  push $96
ffff80000010a557:	6a 60                	push   $0x60
  jmp alltraps
ffff80000010a559:	e9 3b f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a55e <vector97>:
vector97:
  push $0
ffff80000010a55e:	6a 00                	push   $0x0
  push $97
ffff80000010a560:	6a 61                	push   $0x61
  jmp alltraps
ffff80000010a562:	e9 32 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a567 <vector98>:
vector98:
  push $0
ffff80000010a567:	6a 00                	push   $0x0
  push $98
ffff80000010a569:	6a 62                	push   $0x62
  jmp alltraps
ffff80000010a56b:	e9 29 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a570 <vector99>:
vector99:
  push $0
ffff80000010a570:	6a 00                	push   $0x0
  push $99
ffff80000010a572:	6a 63                	push   $0x63
  jmp alltraps
ffff80000010a574:	e9 20 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a579 <vector100>:
vector100:
  push $0
ffff80000010a579:	6a 00                	push   $0x0
  push $100
ffff80000010a57b:	6a 64                	push   $0x64
  jmp alltraps
ffff80000010a57d:	e9 17 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a582 <vector101>:
vector101:
  push $0
ffff80000010a582:	6a 00                	push   $0x0
  push $101
ffff80000010a584:	6a 65                	push   $0x65
  jmp alltraps
ffff80000010a586:	e9 0e f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a58b <vector102>:
vector102:
  push $0
ffff80000010a58b:	6a 00                	push   $0x0
  push $102
ffff80000010a58d:	6a 66                	push   $0x66
  jmp alltraps
ffff80000010a58f:	e9 05 f3 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a594 <vector103>:
vector103:
  push $0
ffff80000010a594:	6a 00                	push   $0x0
  push $103
ffff80000010a596:	6a 67                	push   $0x67
  jmp alltraps
ffff80000010a598:	e9 fc f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a59d <vector104>:
vector104:
  push $0
ffff80000010a59d:	6a 00                	push   $0x0
  push $104
ffff80000010a59f:	6a 68                	push   $0x68
  jmp alltraps
ffff80000010a5a1:	e9 f3 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5a6 <vector105>:
vector105:
  push $0
ffff80000010a5a6:	6a 00                	push   $0x0
  push $105
ffff80000010a5a8:	6a 69                	push   $0x69
  jmp alltraps
ffff80000010a5aa:	e9 ea f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5af <vector106>:
vector106:
  push $0
ffff80000010a5af:	6a 00                	push   $0x0
  push $106
ffff80000010a5b1:	6a 6a                	push   $0x6a
  jmp alltraps
ffff80000010a5b3:	e9 e1 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5b8 <vector107>:
vector107:
  push $0
ffff80000010a5b8:	6a 00                	push   $0x0
  push $107
ffff80000010a5ba:	6a 6b                	push   $0x6b
  jmp alltraps
ffff80000010a5bc:	e9 d8 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5c1 <vector108>:
vector108:
  push $0
ffff80000010a5c1:	6a 00                	push   $0x0
  push $108
ffff80000010a5c3:	6a 6c                	push   $0x6c
  jmp alltraps
ffff80000010a5c5:	e9 cf f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5ca <vector109>:
vector109:
  push $0
ffff80000010a5ca:	6a 00                	push   $0x0
  push $109
ffff80000010a5cc:	6a 6d                	push   $0x6d
  jmp alltraps
ffff80000010a5ce:	e9 c6 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5d3 <vector110>:
vector110:
  push $0
ffff80000010a5d3:	6a 00                	push   $0x0
  push $110
ffff80000010a5d5:	6a 6e                	push   $0x6e
  jmp alltraps
ffff80000010a5d7:	e9 bd f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5dc <vector111>:
vector111:
  push $0
ffff80000010a5dc:	6a 00                	push   $0x0
  push $111
ffff80000010a5de:	6a 6f                	push   $0x6f
  jmp alltraps
ffff80000010a5e0:	e9 b4 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5e5 <vector112>:
vector112:
  push $0
ffff80000010a5e5:	6a 00                	push   $0x0
  push $112
ffff80000010a5e7:	6a 70                	push   $0x70
  jmp alltraps
ffff80000010a5e9:	e9 ab f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5ee <vector113>:
vector113:
  push $0
ffff80000010a5ee:	6a 00                	push   $0x0
  push $113
ffff80000010a5f0:	6a 71                	push   $0x71
  jmp alltraps
ffff80000010a5f2:	e9 a2 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a5f7 <vector114>:
vector114:
  push $0
ffff80000010a5f7:	6a 00                	push   $0x0
  push $114
ffff80000010a5f9:	6a 72                	push   $0x72
  jmp alltraps
ffff80000010a5fb:	e9 99 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a600 <vector115>:
vector115:
  push $0
ffff80000010a600:	6a 00                	push   $0x0
  push $115
ffff80000010a602:	6a 73                	push   $0x73
  jmp alltraps
ffff80000010a604:	e9 90 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a609 <vector116>:
vector116:
  push $0
ffff80000010a609:	6a 00                	push   $0x0
  push $116
ffff80000010a60b:	6a 74                	push   $0x74
  jmp alltraps
ffff80000010a60d:	e9 87 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a612 <vector117>:
vector117:
  push $0
ffff80000010a612:	6a 00                	push   $0x0
  push $117
ffff80000010a614:	6a 75                	push   $0x75
  jmp alltraps
ffff80000010a616:	e9 7e f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a61b <vector118>:
vector118:
  push $0
ffff80000010a61b:	6a 00                	push   $0x0
  push $118
ffff80000010a61d:	6a 76                	push   $0x76
  jmp alltraps
ffff80000010a61f:	e9 75 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a624 <vector119>:
vector119:
  push $0
ffff80000010a624:	6a 00                	push   $0x0
  push $119
ffff80000010a626:	6a 77                	push   $0x77
  jmp alltraps
ffff80000010a628:	e9 6c f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a62d <vector120>:
vector120:
  push $0
ffff80000010a62d:	6a 00                	push   $0x0
  push $120
ffff80000010a62f:	6a 78                	push   $0x78
  jmp alltraps
ffff80000010a631:	e9 63 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a636 <vector121>:
vector121:
  push $0
ffff80000010a636:	6a 00                	push   $0x0
  push $121
ffff80000010a638:	6a 79                	push   $0x79
  jmp alltraps
ffff80000010a63a:	e9 5a f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a63f <vector122>:
vector122:
  push $0
ffff80000010a63f:	6a 00                	push   $0x0
  push $122
ffff80000010a641:	6a 7a                	push   $0x7a
  jmp alltraps
ffff80000010a643:	e9 51 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a648 <vector123>:
vector123:
  push $0
ffff80000010a648:	6a 00                	push   $0x0
  push $123
ffff80000010a64a:	6a 7b                	push   $0x7b
  jmp alltraps
ffff80000010a64c:	e9 48 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a651 <vector124>:
vector124:
  push $0
ffff80000010a651:	6a 00                	push   $0x0
  push $124
ffff80000010a653:	6a 7c                	push   $0x7c
  jmp alltraps
ffff80000010a655:	e9 3f f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a65a <vector125>:
vector125:
  push $0
ffff80000010a65a:	6a 00                	push   $0x0
  push $125
ffff80000010a65c:	6a 7d                	push   $0x7d
  jmp alltraps
ffff80000010a65e:	e9 36 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a663 <vector126>:
vector126:
  push $0
ffff80000010a663:	6a 00                	push   $0x0
  push $126
ffff80000010a665:	6a 7e                	push   $0x7e
  jmp alltraps
ffff80000010a667:	e9 2d f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a66c <vector127>:
vector127:
  push $0
ffff80000010a66c:	6a 00                	push   $0x0
  push $127
ffff80000010a66e:	6a 7f                	push   $0x7f
  jmp alltraps
ffff80000010a670:	e9 24 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a675 <vector128>:
vector128:
  push $0
ffff80000010a675:	6a 00                	push   $0x0
  push $128
ffff80000010a677:	68 80 00 00 00       	push   $0x80
  jmp alltraps
ffff80000010a67c:	e9 18 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a681 <vector129>:
vector129:
  push $0
ffff80000010a681:	6a 00                	push   $0x0
  push $129
ffff80000010a683:	68 81 00 00 00       	push   $0x81
  jmp alltraps
ffff80000010a688:	e9 0c f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a68d <vector130>:
vector130:
  push $0
ffff80000010a68d:	6a 00                	push   $0x0
  push $130
ffff80000010a68f:	68 82 00 00 00       	push   $0x82
  jmp alltraps
ffff80000010a694:	e9 00 f2 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a699 <vector131>:
vector131:
  push $0
ffff80000010a699:	6a 00                	push   $0x0
  push $131
ffff80000010a69b:	68 83 00 00 00       	push   $0x83
  jmp alltraps
ffff80000010a6a0:	e9 f4 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6a5 <vector132>:
vector132:
  push $0
ffff80000010a6a5:	6a 00                	push   $0x0
  push $132
ffff80000010a6a7:	68 84 00 00 00       	push   $0x84
  jmp alltraps
ffff80000010a6ac:	e9 e8 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6b1 <vector133>:
vector133:
  push $0
ffff80000010a6b1:	6a 00                	push   $0x0
  push $133
ffff80000010a6b3:	68 85 00 00 00       	push   $0x85
  jmp alltraps
ffff80000010a6b8:	e9 dc f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6bd <vector134>:
vector134:
  push $0
ffff80000010a6bd:	6a 00                	push   $0x0
  push $134
ffff80000010a6bf:	68 86 00 00 00       	push   $0x86
  jmp alltraps
ffff80000010a6c4:	e9 d0 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6c9 <vector135>:
vector135:
  push $0
ffff80000010a6c9:	6a 00                	push   $0x0
  push $135
ffff80000010a6cb:	68 87 00 00 00       	push   $0x87
  jmp alltraps
ffff80000010a6d0:	e9 c4 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6d5 <vector136>:
vector136:
  push $0
ffff80000010a6d5:	6a 00                	push   $0x0
  push $136
ffff80000010a6d7:	68 88 00 00 00       	push   $0x88
  jmp alltraps
ffff80000010a6dc:	e9 b8 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6e1 <vector137>:
vector137:
  push $0
ffff80000010a6e1:	6a 00                	push   $0x0
  push $137
ffff80000010a6e3:	68 89 00 00 00       	push   $0x89
  jmp alltraps
ffff80000010a6e8:	e9 ac f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6ed <vector138>:
vector138:
  push $0
ffff80000010a6ed:	6a 00                	push   $0x0
  push $138
ffff80000010a6ef:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
ffff80000010a6f4:	e9 a0 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a6f9 <vector139>:
vector139:
  push $0
ffff80000010a6f9:	6a 00                	push   $0x0
  push $139
ffff80000010a6fb:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
ffff80000010a700:	e9 94 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a705 <vector140>:
vector140:
  push $0
ffff80000010a705:	6a 00                	push   $0x0
  push $140
ffff80000010a707:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
ffff80000010a70c:	e9 88 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a711 <vector141>:
vector141:
  push $0
ffff80000010a711:	6a 00                	push   $0x0
  push $141
ffff80000010a713:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
ffff80000010a718:	e9 7c f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a71d <vector142>:
vector142:
  push $0
ffff80000010a71d:	6a 00                	push   $0x0
  push $142
ffff80000010a71f:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
ffff80000010a724:	e9 70 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a729 <vector143>:
vector143:
  push $0
ffff80000010a729:	6a 00                	push   $0x0
  push $143
ffff80000010a72b:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
ffff80000010a730:	e9 64 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a735 <vector144>:
vector144:
  push $0
ffff80000010a735:	6a 00                	push   $0x0
  push $144
ffff80000010a737:	68 90 00 00 00       	push   $0x90
  jmp alltraps
ffff80000010a73c:	e9 58 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a741 <vector145>:
vector145:
  push $0
ffff80000010a741:	6a 00                	push   $0x0
  push $145
ffff80000010a743:	68 91 00 00 00       	push   $0x91
  jmp alltraps
ffff80000010a748:	e9 4c f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a74d <vector146>:
vector146:
  push $0
ffff80000010a74d:	6a 00                	push   $0x0
  push $146
ffff80000010a74f:	68 92 00 00 00       	push   $0x92
  jmp alltraps
ffff80000010a754:	e9 40 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a759 <vector147>:
vector147:
  push $0
ffff80000010a759:	6a 00                	push   $0x0
  push $147
ffff80000010a75b:	68 93 00 00 00       	push   $0x93
  jmp alltraps
ffff80000010a760:	e9 34 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a765 <vector148>:
vector148:
  push $0
ffff80000010a765:	6a 00                	push   $0x0
  push $148
ffff80000010a767:	68 94 00 00 00       	push   $0x94
  jmp alltraps
ffff80000010a76c:	e9 28 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a771 <vector149>:
vector149:
  push $0
ffff80000010a771:	6a 00                	push   $0x0
  push $149
ffff80000010a773:	68 95 00 00 00       	push   $0x95
  jmp alltraps
ffff80000010a778:	e9 1c f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a77d <vector150>:
vector150:
  push $0
ffff80000010a77d:	6a 00                	push   $0x0
  push $150
ffff80000010a77f:	68 96 00 00 00       	push   $0x96
  jmp alltraps
ffff80000010a784:	e9 10 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a789 <vector151>:
vector151:
  push $0
ffff80000010a789:	6a 00                	push   $0x0
  push $151
ffff80000010a78b:	68 97 00 00 00       	push   $0x97
  jmp alltraps
ffff80000010a790:	e9 04 f1 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a795 <vector152>:
vector152:
  push $0
ffff80000010a795:	6a 00                	push   $0x0
  push $152
ffff80000010a797:	68 98 00 00 00       	push   $0x98
  jmp alltraps
ffff80000010a79c:	e9 f8 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7a1 <vector153>:
vector153:
  push $0
ffff80000010a7a1:	6a 00                	push   $0x0
  push $153
ffff80000010a7a3:	68 99 00 00 00       	push   $0x99
  jmp alltraps
ffff80000010a7a8:	e9 ec f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7ad <vector154>:
vector154:
  push $0
ffff80000010a7ad:	6a 00                	push   $0x0
  push $154
ffff80000010a7af:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
ffff80000010a7b4:	e9 e0 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7b9 <vector155>:
vector155:
  push $0
ffff80000010a7b9:	6a 00                	push   $0x0
  push $155
ffff80000010a7bb:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
ffff80000010a7c0:	e9 d4 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7c5 <vector156>:
vector156:
  push $0
ffff80000010a7c5:	6a 00                	push   $0x0
  push $156
ffff80000010a7c7:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
ffff80000010a7cc:	e9 c8 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7d1 <vector157>:
vector157:
  push $0
ffff80000010a7d1:	6a 00                	push   $0x0
  push $157
ffff80000010a7d3:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
ffff80000010a7d8:	e9 bc f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7dd <vector158>:
vector158:
  push $0
ffff80000010a7dd:	6a 00                	push   $0x0
  push $158
ffff80000010a7df:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
ffff80000010a7e4:	e9 b0 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7e9 <vector159>:
vector159:
  push $0
ffff80000010a7e9:	6a 00                	push   $0x0
  push $159
ffff80000010a7eb:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
ffff80000010a7f0:	e9 a4 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a7f5 <vector160>:
vector160:
  push $0
ffff80000010a7f5:	6a 00                	push   $0x0
  push $160
ffff80000010a7f7:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
ffff80000010a7fc:	e9 98 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a801 <vector161>:
vector161:
  push $0
ffff80000010a801:	6a 00                	push   $0x0
  push $161
ffff80000010a803:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
ffff80000010a808:	e9 8c f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a80d <vector162>:
vector162:
  push $0
ffff80000010a80d:	6a 00                	push   $0x0
  push $162
ffff80000010a80f:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
ffff80000010a814:	e9 80 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a819 <vector163>:
vector163:
  push $0
ffff80000010a819:	6a 00                	push   $0x0
  push $163
ffff80000010a81b:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
ffff80000010a820:	e9 74 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a825 <vector164>:
vector164:
  push $0
ffff80000010a825:	6a 00                	push   $0x0
  push $164
ffff80000010a827:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
ffff80000010a82c:	e9 68 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a831 <vector165>:
vector165:
  push $0
ffff80000010a831:	6a 00                	push   $0x0
  push $165
ffff80000010a833:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
ffff80000010a838:	e9 5c f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a83d <vector166>:
vector166:
  push $0
ffff80000010a83d:	6a 00                	push   $0x0
  push $166
ffff80000010a83f:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
ffff80000010a844:	e9 50 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a849 <vector167>:
vector167:
  push $0
ffff80000010a849:	6a 00                	push   $0x0
  push $167
ffff80000010a84b:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
ffff80000010a850:	e9 44 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a855 <vector168>:
vector168:
  push $0
ffff80000010a855:	6a 00                	push   $0x0
  push $168
ffff80000010a857:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
ffff80000010a85c:	e9 38 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a861 <vector169>:
vector169:
  push $0
ffff80000010a861:	6a 00                	push   $0x0
  push $169
ffff80000010a863:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
ffff80000010a868:	e9 2c f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a86d <vector170>:
vector170:
  push $0
ffff80000010a86d:	6a 00                	push   $0x0
  push $170
ffff80000010a86f:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
ffff80000010a874:	e9 20 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a879 <vector171>:
vector171:
  push $0
ffff80000010a879:	6a 00                	push   $0x0
  push $171
ffff80000010a87b:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
ffff80000010a880:	e9 14 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a885 <vector172>:
vector172:
  push $0
ffff80000010a885:	6a 00                	push   $0x0
  push $172
ffff80000010a887:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
ffff80000010a88c:	e9 08 f0 ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a891 <vector173>:
vector173:
  push $0
ffff80000010a891:	6a 00                	push   $0x0
  push $173
ffff80000010a893:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
ffff80000010a898:	e9 fc ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a89d <vector174>:
vector174:
  push $0
ffff80000010a89d:	6a 00                	push   $0x0
  push $174
ffff80000010a89f:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
ffff80000010a8a4:	e9 f0 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8a9 <vector175>:
vector175:
  push $0
ffff80000010a8a9:	6a 00                	push   $0x0
  push $175
ffff80000010a8ab:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
ffff80000010a8b0:	e9 e4 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8b5 <vector176>:
vector176:
  push $0
ffff80000010a8b5:	6a 00                	push   $0x0
  push $176
ffff80000010a8b7:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
ffff80000010a8bc:	e9 d8 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8c1 <vector177>:
vector177:
  push $0
ffff80000010a8c1:	6a 00                	push   $0x0
  push $177
ffff80000010a8c3:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
ffff80000010a8c8:	e9 cc ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8cd <vector178>:
vector178:
  push $0
ffff80000010a8cd:	6a 00                	push   $0x0
  push $178
ffff80000010a8cf:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
ffff80000010a8d4:	e9 c0 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8d9 <vector179>:
vector179:
  push $0
ffff80000010a8d9:	6a 00                	push   $0x0
  push $179
ffff80000010a8db:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
ffff80000010a8e0:	e9 b4 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8e5 <vector180>:
vector180:
  push $0
ffff80000010a8e5:	6a 00                	push   $0x0
  push $180
ffff80000010a8e7:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
ffff80000010a8ec:	e9 a8 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8f1 <vector181>:
vector181:
  push $0
ffff80000010a8f1:	6a 00                	push   $0x0
  push $181
ffff80000010a8f3:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
ffff80000010a8f8:	e9 9c ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a8fd <vector182>:
vector182:
  push $0
ffff80000010a8fd:	6a 00                	push   $0x0
  push $182
ffff80000010a8ff:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
ffff80000010a904:	e9 90 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a909 <vector183>:
vector183:
  push $0
ffff80000010a909:	6a 00                	push   $0x0
  push $183
ffff80000010a90b:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
ffff80000010a910:	e9 84 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a915 <vector184>:
vector184:
  push $0
ffff80000010a915:	6a 00                	push   $0x0
  push $184
ffff80000010a917:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
ffff80000010a91c:	e9 78 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a921 <vector185>:
vector185:
  push $0
ffff80000010a921:	6a 00                	push   $0x0
  push $185
ffff80000010a923:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
ffff80000010a928:	e9 6c ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a92d <vector186>:
vector186:
  push $0
ffff80000010a92d:	6a 00                	push   $0x0
  push $186
ffff80000010a92f:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
ffff80000010a934:	e9 60 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a939 <vector187>:
vector187:
  push $0
ffff80000010a939:	6a 00                	push   $0x0
  push $187
ffff80000010a93b:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
ffff80000010a940:	e9 54 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a945 <vector188>:
vector188:
  push $0
ffff80000010a945:	6a 00                	push   $0x0
  push $188
ffff80000010a947:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
ffff80000010a94c:	e9 48 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a951 <vector189>:
vector189:
  push $0
ffff80000010a951:	6a 00                	push   $0x0
  push $189
ffff80000010a953:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
ffff80000010a958:	e9 3c ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a95d <vector190>:
vector190:
  push $0
ffff80000010a95d:	6a 00                	push   $0x0
  push $190
ffff80000010a95f:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
ffff80000010a964:	e9 30 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a969 <vector191>:
vector191:
  push $0
ffff80000010a969:	6a 00                	push   $0x0
  push $191
ffff80000010a96b:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
ffff80000010a970:	e9 24 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a975 <vector192>:
vector192:
  push $0
ffff80000010a975:	6a 00                	push   $0x0
  push $192
ffff80000010a977:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
ffff80000010a97c:	e9 18 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a981 <vector193>:
vector193:
  push $0
ffff80000010a981:	6a 00                	push   $0x0
  push $193
ffff80000010a983:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
ffff80000010a988:	e9 0c ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a98d <vector194>:
vector194:
  push $0
ffff80000010a98d:	6a 00                	push   $0x0
  push $194
ffff80000010a98f:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
ffff80000010a994:	e9 00 ef ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a999 <vector195>:
vector195:
  push $0
ffff80000010a999:	6a 00                	push   $0x0
  push $195
ffff80000010a99b:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
ffff80000010a9a0:	e9 f4 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9a5 <vector196>:
vector196:
  push $0
ffff80000010a9a5:	6a 00                	push   $0x0
  push $196
ffff80000010a9a7:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
ffff80000010a9ac:	e9 e8 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9b1 <vector197>:
vector197:
  push $0
ffff80000010a9b1:	6a 00                	push   $0x0
  push $197
ffff80000010a9b3:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
ffff80000010a9b8:	e9 dc ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9bd <vector198>:
vector198:
  push $0
ffff80000010a9bd:	6a 00                	push   $0x0
  push $198
ffff80000010a9bf:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
ffff80000010a9c4:	e9 d0 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9c9 <vector199>:
vector199:
  push $0
ffff80000010a9c9:	6a 00                	push   $0x0
  push $199
ffff80000010a9cb:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
ffff80000010a9d0:	e9 c4 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9d5 <vector200>:
vector200:
  push $0
ffff80000010a9d5:	6a 00                	push   $0x0
  push $200
ffff80000010a9d7:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
ffff80000010a9dc:	e9 b8 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9e1 <vector201>:
vector201:
  push $0
ffff80000010a9e1:	6a 00                	push   $0x0
  push $201
ffff80000010a9e3:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
ffff80000010a9e8:	e9 ac ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9ed <vector202>:
vector202:
  push $0
ffff80000010a9ed:	6a 00                	push   $0x0
  push $202
ffff80000010a9ef:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
ffff80000010a9f4:	e9 a0 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010a9f9 <vector203>:
vector203:
  push $0
ffff80000010a9f9:	6a 00                	push   $0x0
  push $203
ffff80000010a9fb:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
ffff80000010aa00:	e9 94 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa05 <vector204>:
vector204:
  push $0
ffff80000010aa05:	6a 00                	push   $0x0
  push $204
ffff80000010aa07:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
ffff80000010aa0c:	e9 88 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa11 <vector205>:
vector205:
  push $0
ffff80000010aa11:	6a 00                	push   $0x0
  push $205
ffff80000010aa13:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
ffff80000010aa18:	e9 7c ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa1d <vector206>:
vector206:
  push $0
ffff80000010aa1d:	6a 00                	push   $0x0
  push $206
ffff80000010aa1f:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
ffff80000010aa24:	e9 70 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa29 <vector207>:
vector207:
  push $0
ffff80000010aa29:	6a 00                	push   $0x0
  push $207
ffff80000010aa2b:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
ffff80000010aa30:	e9 64 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa35 <vector208>:
vector208:
  push $0
ffff80000010aa35:	6a 00                	push   $0x0
  push $208
ffff80000010aa37:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
ffff80000010aa3c:	e9 58 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa41 <vector209>:
vector209:
  push $0
ffff80000010aa41:	6a 00                	push   $0x0
  push $209
ffff80000010aa43:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
ffff80000010aa48:	e9 4c ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa4d <vector210>:
vector210:
  push $0
ffff80000010aa4d:	6a 00                	push   $0x0
  push $210
ffff80000010aa4f:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
ffff80000010aa54:	e9 40 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa59 <vector211>:
vector211:
  push $0
ffff80000010aa59:	6a 00                	push   $0x0
  push $211
ffff80000010aa5b:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
ffff80000010aa60:	e9 34 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa65 <vector212>:
vector212:
  push $0
ffff80000010aa65:	6a 00                	push   $0x0
  push $212
ffff80000010aa67:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
ffff80000010aa6c:	e9 28 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa71 <vector213>:
vector213:
  push $0
ffff80000010aa71:	6a 00                	push   $0x0
  push $213
ffff80000010aa73:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
ffff80000010aa78:	e9 1c ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa7d <vector214>:
vector214:
  push $0
ffff80000010aa7d:	6a 00                	push   $0x0
  push $214
ffff80000010aa7f:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
ffff80000010aa84:	e9 10 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa89 <vector215>:
vector215:
  push $0
ffff80000010aa89:	6a 00                	push   $0x0
  push $215
ffff80000010aa8b:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
ffff80000010aa90:	e9 04 ee ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aa95 <vector216>:
vector216:
  push $0
ffff80000010aa95:	6a 00                	push   $0x0
  push $216
ffff80000010aa97:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
ffff80000010aa9c:	e9 f8 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aaa1 <vector217>:
vector217:
  push $0
ffff80000010aaa1:	6a 00                	push   $0x0
  push $217
ffff80000010aaa3:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
ffff80000010aaa8:	e9 ec ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aaad <vector218>:
vector218:
  push $0
ffff80000010aaad:	6a 00                	push   $0x0
  push $218
ffff80000010aaaf:	68 da 00 00 00       	push   $0xda
  jmp alltraps
ffff80000010aab4:	e9 e0 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aab9 <vector219>:
vector219:
  push $0
ffff80000010aab9:	6a 00                	push   $0x0
  push $219
ffff80000010aabb:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
ffff80000010aac0:	e9 d4 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aac5 <vector220>:
vector220:
  push $0
ffff80000010aac5:	6a 00                	push   $0x0
  push $220
ffff80000010aac7:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
ffff80000010aacc:	e9 c8 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aad1 <vector221>:
vector221:
  push $0
ffff80000010aad1:	6a 00                	push   $0x0
  push $221
ffff80000010aad3:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
ffff80000010aad8:	e9 bc ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aadd <vector222>:
vector222:
  push $0
ffff80000010aadd:	6a 00                	push   $0x0
  push $222
ffff80000010aadf:	68 de 00 00 00       	push   $0xde
  jmp alltraps
ffff80000010aae4:	e9 b0 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aae9 <vector223>:
vector223:
  push $0
ffff80000010aae9:	6a 00                	push   $0x0
  push $223
ffff80000010aaeb:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
ffff80000010aaf0:	e9 a4 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aaf5 <vector224>:
vector224:
  push $0
ffff80000010aaf5:	6a 00                	push   $0x0
  push $224
ffff80000010aaf7:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
ffff80000010aafc:	e9 98 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab01 <vector225>:
vector225:
  push $0
ffff80000010ab01:	6a 00                	push   $0x0
  push $225
ffff80000010ab03:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
ffff80000010ab08:	e9 8c ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab0d <vector226>:
vector226:
  push $0
ffff80000010ab0d:	6a 00                	push   $0x0
  push $226
ffff80000010ab0f:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
ffff80000010ab14:	e9 80 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab19 <vector227>:
vector227:
  push $0
ffff80000010ab19:	6a 00                	push   $0x0
  push $227
ffff80000010ab1b:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
ffff80000010ab20:	e9 74 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab25 <vector228>:
vector228:
  push $0
ffff80000010ab25:	6a 00                	push   $0x0
  push $228
ffff80000010ab27:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
ffff80000010ab2c:	e9 68 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab31 <vector229>:
vector229:
  push $0
ffff80000010ab31:	6a 00                	push   $0x0
  push $229
ffff80000010ab33:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
ffff80000010ab38:	e9 5c ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab3d <vector230>:
vector230:
  push $0
ffff80000010ab3d:	6a 00                	push   $0x0
  push $230
ffff80000010ab3f:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
ffff80000010ab44:	e9 50 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab49 <vector231>:
vector231:
  push $0
ffff80000010ab49:	6a 00                	push   $0x0
  push $231
ffff80000010ab4b:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
ffff80000010ab50:	e9 44 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab55 <vector232>:
vector232:
  push $0
ffff80000010ab55:	6a 00                	push   $0x0
  push $232
ffff80000010ab57:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
ffff80000010ab5c:	e9 38 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab61 <vector233>:
vector233:
  push $0
ffff80000010ab61:	6a 00                	push   $0x0
  push $233
ffff80000010ab63:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
ffff80000010ab68:	e9 2c ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab6d <vector234>:
vector234:
  push $0
ffff80000010ab6d:	6a 00                	push   $0x0
  push $234
ffff80000010ab6f:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
ffff80000010ab74:	e9 20 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab79 <vector235>:
vector235:
  push $0
ffff80000010ab79:	6a 00                	push   $0x0
  push $235
ffff80000010ab7b:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
ffff80000010ab80:	e9 14 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab85 <vector236>:
vector236:
  push $0
ffff80000010ab85:	6a 00                	push   $0x0
  push $236
ffff80000010ab87:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
ffff80000010ab8c:	e9 08 ed ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab91 <vector237>:
vector237:
  push $0
ffff80000010ab91:	6a 00                	push   $0x0
  push $237
ffff80000010ab93:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
ffff80000010ab98:	e9 fc ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ab9d <vector238>:
vector238:
  push $0
ffff80000010ab9d:	6a 00                	push   $0x0
  push $238
ffff80000010ab9f:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
ffff80000010aba4:	e9 f0 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010aba9 <vector239>:
vector239:
  push $0
ffff80000010aba9:	6a 00                	push   $0x0
  push $239
ffff80000010abab:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
ffff80000010abb0:	e9 e4 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abb5 <vector240>:
vector240:
  push $0
ffff80000010abb5:	6a 00                	push   $0x0
  push $240
ffff80000010abb7:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
ffff80000010abbc:	e9 d8 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abc1 <vector241>:
vector241:
  push $0
ffff80000010abc1:	6a 00                	push   $0x0
  push $241
ffff80000010abc3:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
ffff80000010abc8:	e9 cc ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abcd <vector242>:
vector242:
  push $0
ffff80000010abcd:	6a 00                	push   $0x0
  push $242
ffff80000010abcf:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
ffff80000010abd4:	e9 c0 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abd9 <vector243>:
vector243:
  push $0
ffff80000010abd9:	6a 00                	push   $0x0
  push $243
ffff80000010abdb:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
ffff80000010abe0:	e9 b4 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abe5 <vector244>:
vector244:
  push $0
ffff80000010abe5:	6a 00                	push   $0x0
  push $244
ffff80000010abe7:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
ffff80000010abec:	e9 a8 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abf1 <vector245>:
vector245:
  push $0
ffff80000010abf1:	6a 00                	push   $0x0
  push $245
ffff80000010abf3:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
ffff80000010abf8:	e9 9c ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010abfd <vector246>:
vector246:
  push $0
ffff80000010abfd:	6a 00                	push   $0x0
  push $246
ffff80000010abff:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
ffff80000010ac04:	e9 90 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac09 <vector247>:
vector247:
  push $0
ffff80000010ac09:	6a 00                	push   $0x0
  push $247
ffff80000010ac0b:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
ffff80000010ac10:	e9 84 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac15 <vector248>:
vector248:
  push $0
ffff80000010ac15:	6a 00                	push   $0x0
  push $248
ffff80000010ac17:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
ffff80000010ac1c:	e9 78 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac21 <vector249>:
vector249:
  push $0
ffff80000010ac21:	6a 00                	push   $0x0
  push $249
ffff80000010ac23:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
ffff80000010ac28:	e9 6c ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac2d <vector250>:
vector250:
  push $0
ffff80000010ac2d:	6a 00                	push   $0x0
  push $250
ffff80000010ac2f:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
ffff80000010ac34:	e9 60 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac39 <vector251>:
vector251:
  push $0
ffff80000010ac39:	6a 00                	push   $0x0
  push $251
ffff80000010ac3b:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
ffff80000010ac40:	e9 54 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac45 <vector252>:
vector252:
  push $0
ffff80000010ac45:	6a 00                	push   $0x0
  push $252
ffff80000010ac47:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
ffff80000010ac4c:	e9 48 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac51 <vector253>:
vector253:
  push $0
ffff80000010ac51:	6a 00                	push   $0x0
  push $253
ffff80000010ac53:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
ffff80000010ac58:	e9 3c ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac5d <vector254>:
vector254:
  push $0
ffff80000010ac5d:	6a 00                	push   $0x0
  push $254
ffff80000010ac5f:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
ffff80000010ac64:	e9 30 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac69 <vector255>:
vector255:
  push $0
ffff80000010ac69:	6a 00                	push   $0x0
  push $255
ffff80000010ac6b:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
ffff80000010ac70:	e9 24 ec ff ff       	jmp    ffff800000109899 <alltraps>

ffff80000010ac75 <lgdt>:
{
ffff80000010ac75:	55                   	push   %rbp
ffff80000010ac76:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ac79:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010ac7d:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010ac81:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010ac84:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010ac88:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff80000010ac8c:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010ac8f:	83 e8 01             	sub    $0x1,%eax
ffff80000010ac92:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010ac96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ac9a:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff80000010ac9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010aca2:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010aca6:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff80000010acaa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010acae:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010acb2:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010acb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010acba:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010acbe:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lgdt (%0)" : : "r" (pd));
ffff80000010acc2:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010acc6:	0f 01 10             	lgdt   (%rax)
}
ffff80000010acc9:	90                   	nop
ffff80000010acca:	c9                   	leave
ffff80000010accb:	c3                   	ret

ffff80000010accc <ltr>:
{
ffff80000010accc:	55                   	push   %rbp
ffff80000010accd:	48 89 e5             	mov    %rsp,%rbp
ffff80000010acd0:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010acd4:	89 f8                	mov    %edi,%eax
ffff80000010acd6:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  asm volatile("ltr %0" : : "r" (sel));
ffff80000010acda:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010acde:	0f 00 d8             	ltr    %eax
}
ffff80000010ace1:	90                   	nop
ffff80000010ace2:	c9                   	leave
ffff80000010ace3:	c3                   	ret

ffff80000010ace4 <lcr3>:

static inline void
lcr3(addr_t val)
{
ffff80000010ace4:	55                   	push   %rbp
ffff80000010ace5:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ace8:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010acec:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffff80000010acf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010acf4:	0f 22 d8             	mov    %rax,%cr3
}
ffff80000010acf7:	90                   	nop
ffff80000010acf8:	c9                   	leave
ffff80000010acf9:	c3                   	ret

ffff80000010acfa <v2p>:
static inline addr_t v2p(void *a) {
ffff80000010acfa:	55                   	push   %rbp
ffff80000010acfb:	48 89 e5             	mov    %rsp,%rbp
ffff80000010acfe:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ad02:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff80000010ad06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ad0a:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ad11:	80 00 00 
ffff80000010ad14:	48 01 d0             	add    %rdx,%rax
}
ffff80000010ad17:	c9                   	leave
ffff80000010ad18:	c3                   	ret

ffff80000010ad19 <syscallinit>:
static pml4e_t *kpml4;
static pdpe_t *kpdpt;

void
syscallinit(void)
{
ffff80000010ad19:	55                   	push   %rbp
ffff80000010ad1a:	48 89 e5             	mov    %rsp,%rbp
  // the MSR/SYSRET wants the segment for 32-bit user data
  // next up is 64-bit user data, then code
  // This is simply the way the sysret instruction
  // is designed to work (it assumes they follow).
  wrmsr(MSR_STAR,
ffff80000010ad1d:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010ad24:	00 1b 00 
ffff80000010ad27:	48 89 c6             	mov    %rax,%rsi
ffff80000010ad2a:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010ad2f:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ad36:	80 ff ff 
ffff80000010ad39:	ff d0                	call   *%rax
    ((((uint64)USER32_CS) << 48) | ((uint64)KERNEL_CS << 32)));
  wrmsr(MSR_LSTAR, (addr_t)syscall_entry);
ffff80000010ad3b:	48 b8 d5 98 10 00 00 	movabs $0xffff8000001098d5,%rax
ffff80000010ad42:	80 ff ff 
ffff80000010ad45:	48 89 c6             	mov    %rax,%rsi
ffff80000010ad48:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010ad4d:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ad54:	80 ff ff 
ffff80000010ad57:	ff d0                	call   *%rax
  wrmsr(MSR_CSTAR, (addr_t)ignore_sysret);
ffff80000010ad59:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010ad60:	80 ff ff 
ffff80000010ad63:	48 89 c6             	mov    %rax,%rsi
ffff80000010ad66:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010ad6b:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ad72:	80 ff ff 
ffff80000010ad75:	ff d0                	call   *%rax

  wrmsr(MSR_SFMASK, FL_TF|FL_DF|FL_IF|FL_IOPL_3|FL_AC|FL_NT);
ffff80000010ad77:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010ad7c:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010ad81:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ad88:	80 ff ff 
ffff80000010ad8b:	ff d0                	call   *%rax
}
ffff80000010ad8d:	90                   	nop
ffff80000010ad8e:	5d                   	pop    %rbp
ffff80000010ad8f:	c3                   	ret

ffff80000010ad90 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
ffff80000010ad90:	55                   	push   %rbp
ffff80000010ad91:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ad94:	48 83 ec 30          	sub    $0x30,%rsp
  uint64 addr;
  void *local;
  struct cpu *c;

  // create a page for cpu local storage
  local = kalloc();
ffff80000010ad98:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010ad9f:	80 ff ff 
ffff80000010ada2:	ff d0                	call   *%rax
ffff80000010ada4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(local, 0, PGSIZE);
ffff80000010ada8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010adac:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010adb1:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010adb6:	48 89 c7             	mov    %rax,%rdi
ffff80000010adb9:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010adc0:	80 ff ff 
ffff80000010adc3:	ff d0                	call   *%rax

  gdt = (struct segdesc*) local;
ffff80000010adc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010adc9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffff80000010adcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010add1:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010add7:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffff80000010addb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010addf:	48 83 c0 40          	add    $0x40,%rax
ffff80000010ade3:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)

  // point FS smack in the middle of our local storage page
  wrmsr(0xC0000100, ((uint64) local) + 2048);
ffff80000010ade9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010aded:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010adf3:	48 89 c6             	mov    %rax,%rsi
ffff80000010adf6:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010adfb:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ae02:	80 ff ff 
ffff80000010ae05:	ff d0                	call   *%rax

  c = &cpus[cpunum()];
ffff80000010ae07:	48 b8 7d 48 10 00 00 	movabs $0xffff80000010487d,%rax
ffff80000010ae0e:	80 ff ff 
ffff80000010ae11:	ff d0                	call   *%rax
ffff80000010ae13:	48 63 d0             	movslq %eax,%rdx
ffff80000010ae16:	48 89 d0             	mov    %rdx,%rax
ffff80000010ae19:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010ae1d:	48 01 d0             	add    %rdx,%rax
ffff80000010ae20:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010ae24:	48 ba e0 82 11 00 00 	movabs $0xffff8000001182e0,%rdx
ffff80000010ae2b:	80 ff ff 
ffff80000010ae2e:	48 01 d0             	add    %rdx,%rax
ffff80000010ae31:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  c->local = local;
ffff80000010ae35:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010ae39:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010ae3d:	48 89 50 20          	mov    %rdx,0x20(%rax)

  cpu = c;
ffff80000010ae41:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010ae45:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010ae4c:	ff ff 
  proc = 0;
ffff80000010ae4e:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010ae55:	ff ff 00 00 00 00 

  addr = (uint64) tss;
ffff80000010ae5b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ae5f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  gdt[0] =  (struct segdesc) {};
ffff80000010ae63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ae67:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
ffff80000010ae6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ae72:	48 83 c0 08          	add    $0x8,%rax
ffff80000010ae76:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010ae7b:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ae81:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ae85:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae89:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ae8c:	83 ca 0a             	or     $0xa,%edx
ffff80000010ae8f:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae92:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ae96:	83 ca 10             	or     $0x10,%edx
ffff80000010ae99:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ae9c:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aea0:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010aea3:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aea6:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aeaa:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aead:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aeb0:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aeb4:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aeb7:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aeba:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aebe:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010aec1:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aec4:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aec8:	83 ca 20             	or     $0x20,%edx
ffff80000010aecb:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aece:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aed2:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010aed5:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aed8:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aedc:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aedf:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aee2:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010aee6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aeea:	48 83 c0 10          	add    $0x10,%rax
ffff80000010aeee:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010aef3:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010aef9:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010aefd:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af01:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af04:	83 ca 02             	or     $0x2,%edx
ffff80000010af07:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af0a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af0e:	83 ca 10             	or     $0x10,%edx
ffff80000010af11:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af14:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af18:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010af1b:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af1e:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af22:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010af25:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af28:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af2c:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af2f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af32:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af36:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010af39:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af3c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af40:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010af43:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af46:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af4a:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010af4d:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af50:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af54:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010af57:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af5a:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
ffff80000010af5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010af62:	48 83 c0 18          	add    $0x18,%rax
ffff80000010af66:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010af6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010af71:	48 83 c0 20          	add    $0x20,%rax
ffff80000010af75:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010af7a:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010af80:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010af84:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af88:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af8b:	83 ca 02             	or     $0x2,%edx
ffff80000010af8e:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af91:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af95:	83 ca 10             	or     $0x10,%edx
ffff80000010af98:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af9b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af9f:	83 ca 60             	or     $0x60,%edx
ffff80000010afa2:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010afa5:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010afa9:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010afac:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010afaf:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010afb3:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010afb6:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010afb9:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010afbd:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010afc0:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010afc3:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010afc7:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010afca:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010afcd:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010afd1:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010afd4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010afd7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010afdb:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010afde:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010afe1:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
ffff80000010afe5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010afe9:	48 83 c0 28          	add    $0x28,%rax
ffff80000010afed:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010aff2:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010aff8:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010affc:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b000:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b003:	83 ca 0a             	or     $0xa,%edx
ffff80000010b006:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b009:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b00d:	83 ca 10             	or     $0x10,%edx
ffff80000010b010:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b013:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b017:	83 ca 60             	or     $0x60,%edx
ffff80000010b01a:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b01d:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b021:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b024:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b027:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b02b:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b02e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b031:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b035:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b038:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b03b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b03f:	83 ca 20             	or     $0x20,%edx
ffff80000010b042:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b045:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b049:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b04c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b04f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b053:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b056:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b059:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010b05d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b061:	48 83 c0 30          	add    $0x30,%rax
ffff80000010b065:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  // TSS: See IA32 SDM Figure 7-4
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010b06c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b070:	48 83 c0 38          	add    $0x38,%rax
ffff80000010b074:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b078:	89 d7                	mov    %edx,%edi
ffff80000010b07a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b07e:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b082:	89 d6                	mov    %edx,%esi
ffff80000010b084:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b088:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010b08c:	89 d1                	mov    %edx,%ecx
ffff80000010b08e:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010b093:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010b097:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010b09b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b09f:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b0a2:	83 ca 09             	or     $0x9,%edx
ffff80000010b0a5:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0a8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0ac:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b0af:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0b2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0b6:	83 ca 60             	or     $0x60,%edx
ffff80000010b0b9:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0bc:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0c0:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b0c3:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0c6:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0ca:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b0cd:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0d0:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0d4:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b0d7:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0da:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0de:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b0e1:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0e4:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0e8:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b0eb:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0ee:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0f2:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b0f5:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0f8:	88 48 07             	mov    %cl,0x7(%rax)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010b0fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0ff:	48 83 c0 40          	add    $0x40,%rax
ffff80000010b103:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b107:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b10b:	41 89 d1             	mov    %edx,%r9d
ffff80000010b10e:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b112:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b116:	41 89 d0             	mov    %edx,%r8d
ffff80000010b119:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b11d:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b121:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b125:	89 d7                	mov    %edx,%edi
ffff80000010b127:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b12b:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b12f:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010b133:	83 e2 0f             	and    $0xf,%edx
ffff80000010b136:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b13a:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010b13e:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010b142:	89 ce                	mov    %ecx,%esi
ffff80000010b144:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010b148:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010b14d:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010b151:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b155:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010b158:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b15b:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b15f:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010b162:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b165:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b169:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010b16c:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b16f:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b173:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010b176:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b179:	89 d1                	mov    %edx,%ecx
ffff80000010b17b:	83 e1 0f             	and    $0xf,%ecx
ffff80000010b17e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b182:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b185:	09 ca                	or     %ecx,%edx
ffff80000010b187:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b18a:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b18e:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b191:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b194:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b198:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b19b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b19e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1a2:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b1a5:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1a8:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1ac:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b1af:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1b2:	40 88 70 07          	mov    %sil,0x7(%rax)

  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));
ffff80000010b1b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b1ba:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010b1bf:	48 89 c7             	mov    %rax,%rdi
ffff80000010b1c2:	48 b8 75 ac 10 00 00 	movabs $0xffff80000010ac75,%rax
ffff80000010b1c9:	80 ff ff 
ffff80000010b1cc:	ff d0                	call   *%rax

  ltr(SEG_TSS << 3);
ffff80000010b1ce:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010b1d3:	48 b8 cc ac 10 00 00 	movabs $0xffff80000010accc,%rax
ffff80000010b1da:	80 ff ff 
ffff80000010b1dd:	ff d0                	call   *%rax
};
ffff80000010b1df:	90                   	nop
ffff80000010b1e0:	c9                   	leave
ffff80000010b1e1:	c3                   	ret

ffff80000010b1e2 <setupkvm>:
// (directly addressable from end..P2V(PHYSTOP)).


pml4e_t*
setupkvm(void)
{
ffff80000010b1e2:	55                   	push   %rbp
ffff80000010b1e3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b1e6:	48 83 ec 10          	sub    $0x10,%rsp
  pml4e_t *pml4 = (pml4e_t*) kalloc();
ffff80000010b1ea:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b1f1:	80 ff ff 
ffff80000010b1f4:	ff d0                	call   *%rax
ffff80000010b1f6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(pml4, 0, PGSIZE);
ffff80000010b1fa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b1fe:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b203:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b208:	48 89 c7             	mov    %rax,%rdi
ffff80000010b20b:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b212:	80 ff ff 
ffff80000010b215:	ff d0                	call   *%rax
  pml4[256] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b217:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b21e:	80 ff ff 
ffff80000010b221:	48 8b 00             	mov    (%rax),%rax
ffff80000010b224:	48 89 c7             	mov    %rax,%rdi
ffff80000010b227:	48 b8 fa ac 10 00 00 	movabs $0xffff80000010acfa,%rax
ffff80000010b22e:	80 ff ff 
ffff80000010b231:	ff d0                	call   *%rax
ffff80000010b233:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b237:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b23e:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b242:	48 89 02             	mov    %rax,(%rdx)
  return pml4;
ffff80000010b245:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
};
ffff80000010b249:	c9                   	leave
ffff80000010b24a:	c3                   	ret

ffff80000010b24b <kvmalloc>:
//
// linear map the first 4GB of physical memory starting
// at 0xFFFF800000000000
void
kvmalloc(void)
{
ffff80000010b24b:	55                   	push   %rbp
ffff80000010b24c:	48 89 e5             	mov    %rsp,%rbp
  kpml4 = (pml4e_t*) kalloc();
ffff80000010b24f:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b256:	80 ff ff 
ffff80000010b259:	ff d0                	call   *%rax
ffff80000010b25b:	48 ba 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rdx
ffff80000010b262:	80 ff ff 
ffff80000010b265:	48 89 02             	mov    %rax,(%rdx)
  memset(kpml4, 0, PGSIZE);
ffff80000010b268:	48 b8 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rax
ffff80000010b26f:	80 ff ff 
ffff80000010b272:	48 8b 00             	mov    (%rax),%rax
ffff80000010b275:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b27a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b27f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b282:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b289:	80 ff ff 
ffff80000010b28c:	ff d0                	call   *%rax

  // the kernel memory region starts at KERNBASE and up
  // allocate one PDPT at the bottom of that range.
  kpdpt = (pde_t*) kalloc();
ffff80000010b28e:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b295:	80 ff ff 
ffff80000010b298:	ff d0                	call   *%rax
ffff80000010b29a:	48 ba 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rdx
ffff80000010b2a1:	80 ff ff 
ffff80000010b2a4:	48 89 02             	mov    %rax,(%rdx)
  memset(kpdpt, 0, PGSIZE);
ffff80000010b2a7:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b2ae:	80 ff ff 
ffff80000010b2b1:	48 8b 00             	mov    (%rax),%rax
ffff80000010b2b4:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b2b9:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b2be:	48 89 c7             	mov    %rax,%rdi
ffff80000010b2c1:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b2c8:	80 ff ff 
ffff80000010b2cb:	ff d0                	call   *%rax
  kpml4[PMX(KERNBASE)] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010b2cd:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b2d4:	80 ff ff 
ffff80000010b2d7:	48 8b 00             	mov    (%rax),%rax
ffff80000010b2da:	48 89 c7             	mov    %rax,%rdi
ffff80000010b2dd:	48 b8 fa ac 10 00 00 	movabs $0xffff80000010acfa,%rax
ffff80000010b2e4:	80 ff ff 
ffff80000010b2e7:	ff d0                	call   *%rax
ffff80000010b2e9:	48 ba 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rdx
ffff80000010b2f0:	80 ff ff 
ffff80000010b2f3:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010b2f6:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b2fd:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b301:	48 89 02             	mov    %rax,(%rdx)

  // direct map first GB of physical addresses to KERNBASE
  kpdpt[0] = 0 | PTE_PS | PTE_P | PTE_W;
ffff80000010b304:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b30b:	80 ff ff 
ffff80000010b30e:	48 8b 00             	mov    (%rax),%rax
ffff80000010b311:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)

  // direct map 4th GB of physical addresses to KERNBASE+3GB
  // this is a very lazy way to map IO memory (for lapic and ioapic)
  // PTE_PWT and PTE_PCD for memory mapped I/O correctness.
  kpdpt[3] = 0xC0000000 | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffff80000010b318:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b31f:	80 ff ff 
ffff80000010b322:	48 8b 00             	mov    (%rax),%rax
ffff80000010b325:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b329:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010b32e:	48 89 08             	mov    %rcx,(%rax)

  switchkvm();
ffff80000010b331:	48 b8 4c b6 10 00 00 	movabs $0xffff80000010b64c,%rax
ffff80000010b338:	80 ff ff 
ffff80000010b33b:	ff d0                	call   *%rax
}
ffff80000010b33d:	90                   	nop
ffff80000010b33e:	5d                   	pop    %rbp
ffff80000010b33f:	c3                   	ret

ffff80000010b340 <switchuvm>:

void
switchuvm(struct proc *p)
{
ffff80000010b340:	55                   	push   %rbp
ffff80000010b341:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b344:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010b348:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli();
ffff80000010b34c:	48 b8 e2 78 10 00 00 	movabs $0xffff8000001078e2,%rax
ffff80000010b353:	80 ff ff 
ffff80000010b356:	ff d0                	call   *%rax
  if(p->pgdir == 0)
ffff80000010b358:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b35c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b360:	48 85 c0             	test   %rax,%rax
ffff80000010b363:	75 19                	jne    ffff80000010b37e <switchuvm+0x3e>
    panic("switchuvm: no pgdir");
ffff80000010b365:	48 b8 78 ca 10 00 00 	movabs $0xffff80000010ca78,%rax
ffff80000010b36c:	80 ff ff 
ffff80000010b36f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b372:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b379:	80 ff ff 
ffff80000010b37c:	ff d0                	call   *%rax
  uint *tss = (uint*) (((char*) cpu->local) + 1024);
ffff80000010b37e:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010b385:	ff ff 
ffff80000010b387:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010b38b:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010b391:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
ffff80000010b395:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b399:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010b39d:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010b3a3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
ffff80000010b3a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b3ab:	48 83 c0 04          	add    $0x4,%rax
ffff80000010b3af:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010b3b3:	89 10                	mov    %edx,(%rax)
  tss[2] = (uint)(stktop >> 32);
ffff80000010b3b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b3b9:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010b3bd:	48 89 c2             	mov    %rax,%rdx
ffff80000010b3c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b3c4:	48 83 c0 08          	add    $0x8,%rax
ffff80000010b3c8:	89 10                	mov    %edx,(%rax)
  lcr3(v2p(p->pgdir));
ffff80000010b3ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b3ce:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b3d2:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3d5:	48 b8 fa ac 10 00 00 	movabs $0xffff80000010acfa,%rax
ffff80000010b3dc:	80 ff ff 
ffff80000010b3df:	ff d0                	call   *%rax
ffff80000010b3e1:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3e4:	48 b8 e4 ac 10 00 00 	movabs $0xffff80000010ace4,%rax
ffff80000010b3eb:	80 ff ff 
ffff80000010b3ee:	ff d0                	call   *%rax
  popcli();
ffff80000010b3f0:	48 b8 50 79 10 00 00 	movabs $0xffff800000107950,%rax
ffff80000010b3f7:	80 ff ff 
ffff80000010b3fa:	ff d0                	call   *%rax
}
ffff80000010b3fc:	90                   	nop
ffff80000010b3fd:	c9                   	leave
ffff80000010b3fe:	c3                   	ret

ffff80000010b3ff <walkpgdir>:
// In 64-bit mode, the page table has four levels: PML4, PDPT, PD and PT
// For each level, we dereference the correct entry, or allocate and
// initialize entry if the PTE_P bit is not set
static pte_t *
walkpgdir(pde_t *pml4, const void *va, int alloc)
{
ffff80000010b3ff:	55                   	push   %rbp
ffff80000010b400:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b403:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b407:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010b40b:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010b40f:	89 55 bc             	mov    %edx,-0x44(%rbp)
  pml4e_t *pml4e;
  pdpe_t *pdp, *pdpe;
  pde_t *pde, *pd, *pgtab;

  // from the PML4, find or allocate the appropriate PDP table
  pml4e = &pml4[PMX(va)];
ffff80000010b412:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b416:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010b41a:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b41f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b426:	00 
ffff80000010b427:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b42b:	48 01 d0             	add    %rdx,%rax
ffff80000010b42e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  if(*pml4e & PTE_P)
ffff80000010b432:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b436:	48 8b 00             	mov    (%rax),%rax
ffff80000010b439:	83 e0 01             	and    $0x1,%eax
ffff80000010b43c:	48 85 c0             	test   %rax,%rax
ffff80000010b43f:	74 23                	je     ffff80000010b464 <walkpgdir+0x65>
    pdp = (pdpe_t*)P2V(PTE_ADDR(*pml4e));
ffff80000010b441:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b445:	48 8b 00             	mov    (%rax),%rax
ffff80000010b448:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b44e:	48 89 c2             	mov    %rax,%rdx
ffff80000010b451:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b458:	80 ff ff 
ffff80000010b45b:	48 01 d0             	add    %rdx,%rax
ffff80000010b45e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b462:	eb 63                	jmp    ffff80000010b4c7 <walkpgdir+0xc8>
  else {
    if(!alloc || (pdp = (pdpe_t*)kalloc()) == 0)
ffff80000010b464:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b468:	74 17                	je     ffff80000010b481 <walkpgdir+0x82>
ffff80000010b46a:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b471:	80 ff ff 
ffff80000010b474:	ff d0                	call   *%rax
ffff80000010b476:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b47a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010b47f:	75 0a                	jne    ffff80000010b48b <walkpgdir+0x8c>
      return 0;
ffff80000010b481:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b486:	e9 bf 01 00 00       	jmp    ffff80000010b64a <walkpgdir+0x24b>
    memset(pdp, 0, PGSIZE);
ffff80000010b48b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b48f:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b494:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b499:	48 89 c7             	mov    %rax,%rdi
ffff80000010b49c:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b4a3:	80 ff ff 
ffff80000010b4a6:	ff d0                	call   *%rax
    *pml4e = V2P(pdp) | PTE_P | PTE_W | PTE_U;
ffff80000010b4a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b4ac:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b4b3:	80 00 00 
ffff80000010b4b6:	48 01 d0             	add    %rdx,%rax
ffff80000010b4b9:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b4bd:	48 89 c2             	mov    %rax,%rdx
ffff80000010b4c0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b4c4:	48 89 10             	mov    %rdx,(%rax)
  }

  //from the PDP, find or allocate the appropriate PD (page directory)
  pdpe = &pdp[PDPX(va)];
ffff80000010b4c7:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b4cb:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010b4cf:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b4d4:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b4db:	00 
ffff80000010b4dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b4e0:	48 01 d0             	add    %rdx,%rax
ffff80000010b4e3:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(*pdpe & PTE_P)
ffff80000010b4e7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b4eb:	48 8b 00             	mov    (%rax),%rax
ffff80000010b4ee:	83 e0 01             	and    $0x1,%eax
ffff80000010b4f1:	48 85 c0             	test   %rax,%rax
ffff80000010b4f4:	74 23                	je     ffff80000010b519 <walkpgdir+0x11a>
    pd = (pde_t*)P2V(PTE_ADDR(*pdpe));
ffff80000010b4f6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b4fa:	48 8b 00             	mov    (%rax),%rax
ffff80000010b4fd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b503:	48 89 c2             	mov    %rax,%rdx
ffff80000010b506:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b50d:	80 ff ff 
ffff80000010b510:	48 01 d0             	add    %rdx,%rax
ffff80000010b513:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b517:	eb 63                	jmp    ffff80000010b57c <walkpgdir+0x17d>
  else {
    if(!alloc || (pd = (pde_t*)kalloc()) == 0)//allocate page table
ffff80000010b519:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b51d:	74 17                	je     ffff80000010b536 <walkpgdir+0x137>
ffff80000010b51f:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b526:	80 ff ff 
ffff80000010b529:	ff d0                	call   *%rax
ffff80000010b52b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b52f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b534:	75 0a                	jne    ffff80000010b540 <walkpgdir+0x141>
      return 0;
ffff80000010b536:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b53b:	e9 0a 01 00 00       	jmp    ffff80000010b64a <walkpgdir+0x24b>
    memset(pd, 0, PGSIZE);
ffff80000010b540:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b544:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b549:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b54e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b551:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b558:	80 ff ff 
ffff80000010b55b:	ff d0                	call   *%rax
    *pdpe = V2P(pd) | PTE_P | PTE_W | PTE_U;
ffff80000010b55d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b561:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b568:	80 00 00 
ffff80000010b56b:	48 01 d0             	add    %rdx,%rax
ffff80000010b56e:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b572:	48 89 c2             	mov    %rax,%rdx
ffff80000010b575:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b579:	48 89 10             	mov    %rdx,(%rax)
  }

  // from the PD, find or allocate the appropriate page table
  pde = &pd[PDX(va)];
ffff80000010b57c:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b580:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010b584:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b589:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b590:	00 
ffff80000010b591:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b595:	48 01 d0             	add    %rdx,%rax
ffff80000010b598:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  if(*pde & PTE_P)
ffff80000010b59c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b5a0:	48 8b 00             	mov    (%rax),%rax
ffff80000010b5a3:	83 e0 01             	and    $0x1,%eax
ffff80000010b5a6:	48 85 c0             	test   %rax,%rax
ffff80000010b5a9:	74 23                	je     ffff80000010b5ce <walkpgdir+0x1cf>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
ffff80000010b5ab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b5af:	48 8b 00             	mov    (%rax),%rax
ffff80000010b5b2:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b5b8:	48 89 c2             	mov    %rax,%rdx
ffff80000010b5bb:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b5c2:	80 ff ff 
ffff80000010b5c5:	48 01 d0             	add    %rdx,%rax
ffff80000010b5c8:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b5cc:	eb 60                	jmp    ffff80000010b62e <walkpgdir+0x22f>
  else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)//allocate page table
ffff80000010b5ce:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b5d2:	74 17                	je     ffff80000010b5eb <walkpgdir+0x1ec>
ffff80000010b5d4:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b5db:	80 ff ff 
ffff80000010b5de:	ff d0                	call   *%rax
ffff80000010b5e0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b5e4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b5e9:	75 07                	jne    ffff80000010b5f2 <walkpgdir+0x1f3>
      return 0;
ffff80000010b5eb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b5f0:	eb 58                	jmp    ffff80000010b64a <walkpgdir+0x24b>
    memset(pgtab, 0, PGSIZE);
ffff80000010b5f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b5f6:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b5fb:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b600:	48 89 c7             	mov    %rax,%rdi
ffff80000010b603:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b60a:	80 ff ff 
ffff80000010b60d:	ff d0                	call   *%rax
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
ffff80000010b60f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b613:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b61a:	80 00 00 
ffff80000010b61d:	48 01 d0             	add    %rdx,%rax
ffff80000010b620:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b624:	48 89 c2             	mov    %rax,%rdx
ffff80000010b627:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b62b:	48 89 10             	mov    %rdx,(%rax)
  }

  return &pgtab[PTX(va)];
ffff80000010b62e:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b632:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010b636:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b63b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b642:	00 
ffff80000010b643:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b647:	48 01 d0             	add    %rdx,%rax
}
ffff80000010b64a:	c9                   	leave
ffff80000010b64b:	c3                   	ret

ffff80000010b64c <switchkvm>:

void
switchkvm(void)
{
ffff80000010b64c:	55                   	push   %rbp
ffff80000010b64d:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffff80000010b650:	48 b8 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rax
ffff80000010b657:	80 ff ff 
ffff80000010b65a:	48 8b 00             	mov    (%rax),%rax
ffff80000010b65d:	48 89 c7             	mov    %rax,%rdi
ffff80000010b660:	48 b8 fa ac 10 00 00 	movabs $0xffff80000010acfa,%rax
ffff80000010b667:	80 ff ff 
ffff80000010b66a:	ff d0                	call   *%rax
ffff80000010b66c:	48 89 c7             	mov    %rax,%rdi
ffff80000010b66f:	48 b8 e4 ac 10 00 00 	movabs $0xffff80000010ace4,%rax
ffff80000010b676:	80 ff ff 
ffff80000010b679:	ff d0                	call   *%rax
}
ffff80000010b67b:	90                   	nop
ffff80000010b67c:	5d                   	pop    %rbp
ffff80000010b67d:	c3                   	ret

ffff80000010b67e <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, addr_t size, addr_t pa, int perm)
{
ffff80000010b67e:	55                   	push   %rbp
ffff80000010b67f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b682:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b686:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b68a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b68e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b692:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010b696:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((addr_t)va);
ffff80000010b69a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b69e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b6a4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((addr_t)va) + size - 1);
ffff80000010b6a8:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010b6ac:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b6b0:	48 01 d0             	add    %rdx,%rax
ffff80000010b6b3:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010b6b7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b6bd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b6c1:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b6c5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b6c9:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010b6ce:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b6d1:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6d4:	48 b8 ff b3 10 00 00 	movabs $0xffff80000010b3ff,%rax
ffff80000010b6db:	80 ff ff 
ffff80000010b6de:	ff d0                	call   *%rax
ffff80000010b6e0:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b6e4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b6e9:	75 07                	jne    ffff80000010b6f2 <mappages+0x74>
      return -1;
ffff80000010b6eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b6f0:	eb 64                	jmp    ffff80000010b756 <mappages+0xd8>
    if(*pte & PTE_P)
ffff80000010b6f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b6f6:	48 8b 00             	mov    (%rax),%rax
ffff80000010b6f9:	83 e0 01             	and    $0x1,%eax
ffff80000010b6fc:	48 85 c0             	test   %rax,%rax
ffff80000010b6ff:	74 19                	je     ffff80000010b71a <mappages+0x9c>
      panic("remap");
ffff80000010b701:	48 b8 8c ca 10 00 00 	movabs $0xffff80000010ca8c,%rax
ffff80000010b708:	80 ff ff 
ffff80000010b70b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b70e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b715:	80 ff ff 
ffff80000010b718:	ff d0                	call   *%rax
    *pte = pa | perm | PTE_P;
ffff80000010b71a:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010b71d:	48 98                	cltq
ffff80000010b71f:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010b723:	48 83 c8 01          	or     $0x1,%rax
ffff80000010b727:	48 89 c2             	mov    %rax,%rdx
ffff80000010b72a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b72e:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffff80000010b731:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b735:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010b739:	74 15                	je     ffff80000010b750 <mappages+0xd2>
      break;
    a += PGSIZE;
ffff80000010b73b:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b742:	00 
    pa += PGSIZE;
ffff80000010b743:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010b74a:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b74b:	e9 71 ff ff ff       	jmp    ffff80000010b6c1 <mappages+0x43>
      break;
ffff80000010b750:	90                   	nop
  }
  return 0;
ffff80000010b751:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b756:	c9                   	leave
ffff80000010b757:	c3                   	ret

ffff80000010b758 <inituvm>:

// Load the initcode into address 0x1000 (4KB) of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffff80000010b758:	55                   	push   %rbp
ffff80000010b759:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b75c:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b760:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b764:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b768:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;

  if(sz >= PGSIZE)
ffff80000010b76b:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010b772:	76 19                	jbe    ffff80000010b78d <inituvm+0x35>
    panic("inituvm: more than a page");
ffff80000010b774:	48 b8 92 ca 10 00 00 	movabs $0xffff80000010ca92,%rax
ffff80000010b77b:	80 ff ff 
ffff80000010b77e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b781:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b788:	80 ff ff 
ffff80000010b78b:	ff d0                	call   *%rax

  mem = kalloc();
ffff80000010b78d:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b794:	80 ff ff 
ffff80000010b797:	ff d0                	call   *%rax
ffff80000010b799:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffff80000010b79d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b7a1:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b7a6:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b7ab:	48 89 c7             	mov    %rax,%rdi
ffff80000010b7ae:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b7b5:	80 ff ff 
ffff80000010b7b8:	ff d0                	call   *%rax
  mappages(pgdir, (void *)PGSIZE, PGSIZE, V2P(mem), PTE_W|PTE_U);
ffff80000010b7ba:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b7be:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b7c5:	80 00 00 
ffff80000010b7c8:	48 01 c2             	add    %rax,%rdx
ffff80000010b7cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b7cf:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010b7d5:	48 89 d1             	mov    %rdx,%rcx
ffff80000010b7d8:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b7dd:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010b7e2:	48 89 c7             	mov    %rax,%rdi
ffff80000010b7e5:	48 b8 7e b6 10 00 00 	movabs $0xffff80000010b67e,%rax
ffff80000010b7ec:	80 ff ff 
ffff80000010b7ef:	ff d0                	call   *%rax

  memmove(mem, init, sz);
ffff80000010b7f1:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010b7f4:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010b7f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b7fc:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b7ff:	48 89 c7             	mov    %rax,%rdi
ffff80000010b802:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff80000010b809:	80 ff ff 
ffff80000010b80c:	ff d0                	call   *%rax
}
ffff80000010b80e:	90                   	nop
ffff80000010b80f:	c9                   	leave
ffff80000010b810:	c3                   	ret

ffff80000010b811 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffff80000010b811:	55                   	push   %rbp
ffff80000010b812:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b815:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b819:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b81d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b821:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b825:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010b828:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
  uint i, n;
  addr_t pa;
  pte_t *pte;

  if((addr_t) addr % PGSIZE != 0)
ffff80000010b82c:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b830:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010b835:	48 85 c0             	test   %rax,%rax
ffff80000010b838:	74 19                	je     ffff80000010b853 <loaduvm+0x42>
    panic("loaduvm: addr must be page aligned");
ffff80000010b83a:	48 b8 b0 ca 10 00 00 	movabs $0xffff80000010cab0,%rax
ffff80000010b841:	80 ff ff 
ffff80000010b844:	48 89 c7             	mov    %rax,%rdi
ffff80000010b847:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b84e:	80 ff ff 
ffff80000010b851:	ff d0                	call   *%rax
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010b853:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010b85a:	e9 c7 00 00 00       	jmp    ffff80000010b926 <loaduvm+0x115>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffff80000010b85f:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010b862:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b866:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010b86a:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b86e:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b873:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b876:	48 89 c7             	mov    %rax,%rdi
ffff80000010b879:	48 b8 ff b3 10 00 00 	movabs $0xffff80000010b3ff,%rax
ffff80000010b880:	80 ff ff 
ffff80000010b883:	ff d0                	call   *%rax
ffff80000010b885:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b889:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b88e:	75 19                	jne    ffff80000010b8a9 <loaduvm+0x98>
      panic("loaduvm: address should exist");
ffff80000010b890:	48 b8 d3 ca 10 00 00 	movabs $0xffff80000010cad3,%rax
ffff80000010b897:	80 ff ff 
ffff80000010b89a:	48 89 c7             	mov    %rax,%rdi
ffff80000010b89d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b8a4:	80 ff ff 
ffff80000010b8a7:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010b8a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b8ad:	48 8b 00             	mov    (%rax),%rax
ffff80000010b8b0:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b8b6:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(sz - i < PGSIZE)
ffff80000010b8ba:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b8bd:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b8c0:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010b8c5:	77 0b                	ja     ffff80000010b8d2 <loaduvm+0xc1>
      n = sz - i;
ffff80000010b8c7:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b8ca:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b8cd:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010b8d0:	eb 07                	jmp    ffff80000010b8d9 <loaduvm+0xc8>
    else
      n = PGSIZE;
ffff80000010b8d2:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
ffff80000010b8d9:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010b8dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b8df:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010b8e2:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010b8e9:	80 ff ff 
ffff80000010b8ec:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b8f0:	48 01 d0             	add    %rdx,%rax
ffff80000010b8f3:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8f6:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010b8f9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b8fd:	89 d1                	mov    %edx,%ecx
ffff80000010b8ff:	89 f2                	mov    %esi,%edx
ffff80000010b901:	48 89 fe             	mov    %rdi,%rsi
ffff80000010b904:	48 89 c7             	mov    %rax,%rdi
ffff80000010b907:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff80000010b90e:	80 ff ff 
ffff80000010b911:	ff d0                	call   *%rax
ffff80000010b913:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010b916:	74 07                	je     ffff80000010b91f <loaduvm+0x10e>
      return -1;
ffff80000010b918:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b91d:	eb 18                	jmp    ffff80000010b937 <loaduvm+0x126>
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010b91f:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010b926:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b929:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010b92c:	0f 82 2d ff ff ff    	jb     ffff80000010b85f <loaduvm+0x4e>
  }
  return 0;
ffff80000010b932:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b937:	c9                   	leave
ffff80000010b938:	c3                   	ret

ffff80000010b939 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
allocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010b939:	55                   	push   %rbp
ffff80000010b93a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b93d:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b941:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b945:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b949:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *mem;
  addr_t a;

  if(newsz >= KERNBASE)
ffff80000010b94d:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010b954:	7f ff ff 
ffff80000010b957:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010b95b:	73 0a                	jae    ffff80000010b967 <allocuvm+0x2e>
    return 0;
ffff80000010b95d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b962:	e9 14 01 00 00       	jmp    ffff80000010ba7b <allocuvm+0x142>
  if(newsz < oldsz)
ffff80000010b967:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b96b:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010b96f:	73 09                	jae    ffff80000010b97a <allocuvm+0x41>
    return oldsz;
ffff80000010b971:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b975:	e9 01 01 00 00       	jmp    ffff80000010ba7b <allocuvm+0x142>

  a = PGROUNDUP(oldsz);
ffff80000010b97a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b97e:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010b984:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b98a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffff80000010b98e:	e9 d6 00 00 00       	jmp    ffff80000010ba69 <allocuvm+0x130>
    mem = kalloc();
ffff80000010b993:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010b99a:	80 ff ff 
ffff80000010b99d:	ff d0                	call   *%rax
ffff80000010b99f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffff80000010b9a3:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b9a8:	75 28                	jne    ffff80000010b9d2 <allocuvm+0x99>
      //cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010b9aa:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010b9ae:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b9b2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b9b6:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b9b9:	48 89 c7             	mov    %rax,%rdi
ffff80000010b9bc:	48 b8 7d ba 10 00 00 	movabs $0xffff80000010ba7d,%rax
ffff80000010b9c3:	80 ff ff 
ffff80000010b9c6:	ff d0                	call   *%rax
      return 0;
ffff80000010b9c8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b9cd:	e9 a9 00 00 00       	jmp    ffff80000010ba7b <allocuvm+0x142>
    }
    memset(mem, 0, PGSIZE);
ffff80000010b9d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b9d6:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b9db:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b9e0:	48 89 c7             	mov    %rax,%rdi
ffff80000010b9e3:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010b9ea:	80 ff ff 
ffff80000010b9ed:	ff d0                	call   *%rax
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
ffff80000010b9ef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b9f3:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b9fa:	80 00 00 
ffff80000010b9fd:	48 01 c2             	add    %rax,%rdx
ffff80000010ba00:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010ba04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba08:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010ba0e:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ba11:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ba16:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba19:	48 b8 7e b6 10 00 00 	movabs $0xffff80000010b67e,%rax
ffff80000010ba20:	80 ff ff 
ffff80000010ba23:	ff d0                	call   *%rax
ffff80000010ba25:	85 c0                	test   %eax,%eax
ffff80000010ba27:	79 38                	jns    ffff80000010ba61 <allocuvm+0x128>
      //cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010ba29:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010ba2d:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010ba31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba35:	48 89 ce             	mov    %rcx,%rsi
ffff80000010ba38:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba3b:	48 b8 7d ba 10 00 00 	movabs $0xffff80000010ba7d,%rax
ffff80000010ba42:	80 ff ff 
ffff80000010ba45:	ff d0                	call   *%rax
      kfree(mem);
ffff80000010ba47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ba4b:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba4e:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010ba55:	80 ff ff 
ffff80000010ba58:	ff d0                	call   *%rax
      return 0;
ffff80000010ba5a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ba5f:	eb 1a                	jmp    ffff80000010ba7b <allocuvm+0x142>
  for(; a < newsz; a += PGSIZE){
ffff80000010ba61:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010ba68:	00 
ffff80000010ba69:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ba6d:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010ba71:	0f 82 1c ff ff ff    	jb     ffff80000010b993 <allocuvm+0x5a>
    }
  }
  return newsz;
ffff80000010ba77:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
ffff80000010ba7b:	c9                   	leave
ffff80000010ba7c:	c3                   	ret

ffff80000010ba7d <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
deallocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010ba7d:	55                   	push   %rbp
ffff80000010ba7e:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ba81:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010ba85:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010ba89:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010ba8d:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  addr_t a, pa;

  if(newsz >= oldsz)
ffff80000010ba91:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010ba95:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010ba99:	72 09                	jb     ffff80000010baa4 <deallocuvm+0x27>
    return oldsz;
ffff80000010ba9b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010ba9f:	e9 d0 00 00 00       	jmp    ffff80000010bb74 <deallocuvm+0xf7>

  a = PGROUNDUP(newsz);
ffff80000010baa4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010baa8:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010baae:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bab4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010bab8:	e9 a5 00 00 00       	jmp    ffff80000010bb62 <deallocuvm+0xe5>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffff80000010babd:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010bac1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bac5:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010baca:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bacd:	48 89 c7             	mov    %rax,%rdi
ffff80000010bad0:	48 b8 ff b3 10 00 00 	movabs $0xffff80000010b3ff,%rax
ffff80000010bad7:	80 ff ff 
ffff80000010bada:	ff d0                	call   *%rax
ffff80000010badc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(pte && (*pte & PTE_P) != 0){
ffff80000010bae0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bae5:	74 73                	je     ffff80000010bb5a <deallocuvm+0xdd>
ffff80000010bae7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010baeb:	48 8b 00             	mov    (%rax),%rax
ffff80000010baee:	83 e0 01             	and    $0x1,%eax
ffff80000010baf1:	48 85 c0             	test   %rax,%rax
ffff80000010baf4:	74 64                	je     ffff80000010bb5a <deallocuvm+0xdd>
      pa = PTE_ADDR(*pte);
ffff80000010baf6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bafa:	48 8b 00             	mov    (%rax),%rax
ffff80000010bafd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb03:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffff80000010bb07:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010bb0c:	75 19                	jne    ffff80000010bb27 <deallocuvm+0xaa>
        panic("kfree");
ffff80000010bb0e:	48 b8 f1 ca 10 00 00 	movabs $0xffff80000010caf1,%rax
ffff80000010bb15:	80 ff ff 
ffff80000010bb18:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb1b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bb22:	80 ff ff 
ffff80000010bb25:	ff d0                	call   *%rax
      char *v = P2V(pa);
ffff80000010bb27:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bb2e:	80 ff ff 
ffff80000010bb31:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bb35:	48 01 d0             	add    %rdx,%rax
ffff80000010bb38:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffff80000010bb3c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb40:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb43:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bb4a:	80 ff ff 
ffff80000010bb4d:	ff d0                	call   *%rax
      *pte = 0;
ffff80000010bb4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bb53:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010bb5a:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bb61:	00 
ffff80000010bb62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb66:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010bb6a:	0f 82 4d ff ff ff    	jb     ffff80000010babd <deallocuvm+0x40>
    }
  }
  return newsz;
ffff80000010bb70:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffff80000010bb74:	c9                   	leave
ffff80000010bb75:	c3                   	ret

ffff80000010bb76 <freevm>:

// Free all the pages mapped by, and all the memory used for,
// this page table
void
freevm(pml4e_t *pml4)
{
ffff80000010bb76:	55                   	push   %rbp
ffff80000010bb77:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bb7a:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bb7e:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  uint i, j, k, l;
  pde_t *pdp, *pd, *pt;

  if(pml4 == 0)
ffff80000010bb82:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010bb87:	75 19                	jne    ffff80000010bba2 <freevm+0x2c>
    panic("freevm: no pgdir");
ffff80000010bb89:	48 b8 f7 ca 10 00 00 	movabs $0xffff80000010caf7,%rax
ffff80000010bb90:	80 ff ff 
ffff80000010bb93:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb96:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bb9d:	80 ff ff 
ffff80000010bba0:	ff d0                	call   *%rax

  // then need to loop through pml4 entry
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010bba2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010bba9:	e9 dc 01 00 00       	jmp    ffff80000010bd8a <freevm+0x214>
    if(pml4[i] & PTE_P){
ffff80000010bbae:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bbb1:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bbb8:	00 
ffff80000010bbb9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bbbd:	48 01 d0             	add    %rdx,%rax
ffff80000010bbc0:	48 8b 00             	mov    (%rax),%rax
ffff80000010bbc3:	83 e0 01             	and    $0x1,%eax
ffff80000010bbc6:	48 85 c0             	test   %rax,%rax
ffff80000010bbc9:	0f 84 b7 01 00 00    	je     ffff80000010bd86 <freevm+0x210>
      pdp = (pdpe_t*)P2V(PTE_ADDR(pml4[i]));
ffff80000010bbcf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bbd2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bbd9:	00 
ffff80000010bbda:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bbde:	48 01 d0             	add    %rdx,%rax
ffff80000010bbe1:	48 8b 00             	mov    (%rax),%rax
ffff80000010bbe4:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bbea:	48 89 c2             	mov    %rax,%rdx
ffff80000010bbed:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bbf4:	80 ff ff 
ffff80000010bbf7:	48 01 d0             	add    %rdx,%rax
ffff80000010bbfa:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

      // and every entry in the corresponding pdpt
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010bbfe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010bc05:	e9 5c 01 00 00       	jmp    ffff80000010bd66 <freevm+0x1f0>
        if(pdp[j] & PTE_P){
ffff80000010bc0a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010bc0d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc14:	00 
ffff80000010bc15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc19:	48 01 d0             	add    %rdx,%rax
ffff80000010bc1c:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc1f:	83 e0 01             	and    $0x1,%eax
ffff80000010bc22:	48 85 c0             	test   %rax,%rax
ffff80000010bc25:	0f 84 37 01 00 00    	je     ffff80000010bd62 <freevm+0x1ec>
          pd = (pde_t*)P2V(PTE_ADDR(pdp[j]));
ffff80000010bc2b:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010bc2e:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc35:	00 
ffff80000010bc36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc3a:	48 01 d0             	add    %rdx,%rax
ffff80000010bc3d:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc40:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bc46:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc49:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bc50:	80 ff ff 
ffff80000010bc53:	48 01 d0             	add    %rdx,%rax
ffff80000010bc56:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

          // and every entry in the corresponding page directory
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010bc5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010bc61:	e9 dc 00 00 00       	jmp    ffff80000010bd42 <freevm+0x1cc>
            if(pd[k] & PTE_P) {
ffff80000010bc66:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bc69:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc70:	00 
ffff80000010bc71:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bc75:	48 01 d0             	add    %rdx,%rax
ffff80000010bc78:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc7b:	83 e0 01             	and    $0x1,%eax
ffff80000010bc7e:	48 85 c0             	test   %rax,%rax
ffff80000010bc81:	0f 84 b7 00 00 00    	je     ffff80000010bd3e <freevm+0x1c8>
              pt = (pde_t*)P2V(PTE_ADDR(pd[k]));
ffff80000010bc87:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bc8a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc91:	00 
ffff80000010bc92:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bc96:	48 01 d0             	add    %rdx,%rax
ffff80000010bc99:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc9c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bca2:	48 89 c2             	mov    %rax,%rdx
ffff80000010bca5:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bcac:	80 ff ff 
ffff80000010bcaf:	48 01 d0             	add    %rdx,%rax
ffff80000010bcb2:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

              // and every entry in the corresponding page table
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010bcb6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010bcbd:	eb 63                	jmp    ffff80000010bd22 <freevm+0x1ac>
                if(pt[l] & PTE_P) {
ffff80000010bcbf:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bcc2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bcc9:	00 
ffff80000010bcca:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bcce:	48 01 d0             	add    %rdx,%rax
ffff80000010bcd1:	48 8b 00             	mov    (%rax),%rax
ffff80000010bcd4:	83 e0 01             	and    $0x1,%eax
ffff80000010bcd7:	48 85 c0             	test   %rax,%rax
ffff80000010bcda:	74 42                	je     ffff80000010bd1e <freevm+0x1a8>
                  char * v = P2V(PTE_ADDR(pt[l]));
ffff80000010bcdc:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bcdf:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bce6:	00 
ffff80000010bce7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bceb:	48 01 d0             	add    %rdx,%rax
ffff80000010bcee:	48 8b 00             	mov    (%rax),%rax
ffff80000010bcf1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bcf7:	48 89 c2             	mov    %rax,%rdx
ffff80000010bcfa:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bd01:	80 ff ff 
ffff80000010bd04:	48 01 d0             	add    %rdx,%rax
ffff80000010bd07:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                  kfree((char*)v);
ffff80000010bd0b:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bd0f:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd12:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bd19:	80 ff ff 
ffff80000010bd1c:	ff d0                	call   *%rax
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010bd1e:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010bd22:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010bd29:	76 94                	jbe    ffff80000010bcbf <freevm+0x149>
                }
              }
              //freeing every page table
              kfree((char*)pt);
ffff80000010bd2b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bd2f:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd32:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bd39:	80 ff ff 
ffff80000010bd3c:	ff d0                	call   *%rax
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010bd3e:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010bd42:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010bd49:	0f 86 17 ff ff ff    	jbe    ffff80000010bc66 <freevm+0xf0>
            }
          }
          // freeing every page directory
          kfree((char*)pd);
ffff80000010bd4f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bd53:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd56:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bd5d:	80 ff ff 
ffff80000010bd60:	ff d0                	call   *%rax
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010bd62:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010bd66:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010bd6d:	0f 86 97 fe ff ff    	jbe    ffff80000010bc0a <freevm+0x94>
        }
      }
      // freeing every page directory pointer table
      kfree((char*)pdp);
ffff80000010bd73:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bd77:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd7a:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bd81:	80 ff ff 
ffff80000010bd84:	ff d0                	call   *%rax
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010bd86:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010bd8a:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010bd91:	0f 86 17 fe ff ff    	jbe    ffff80000010bbae <freevm+0x38>
    }
  }
  // freeing the pml4
  kfree((char*)pml4);
ffff80000010bd97:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bd9b:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd9e:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bda5:	80 ff ff 
ffff80000010bda8:	ff d0                	call   *%rax
}
ffff80000010bdaa:	90                   	nop
ffff80000010bdab:	c9                   	leave
ffff80000010bdac:	c3                   	ret

ffff80000010bdad <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pml4e_t *pgdir, char *uva)
{
ffff80000010bdad:	55                   	push   %rbp
ffff80000010bdae:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bdb1:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010bdb5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bdb9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010bdbd:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010bdc1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bdc5:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bdca:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bdcd:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdd0:	48 b8 ff b3 10 00 00 	movabs $0xffff80000010b3ff,%rax
ffff80000010bdd7:	80 ff ff 
ffff80000010bdda:	ff d0                	call   *%rax
ffff80000010bddc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffff80000010bde0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010bde5:	75 19                	jne    ffff80000010be00 <clearpteu+0x53>
    panic("clearpteu");
ffff80000010bde7:	48 b8 08 cb 10 00 00 	movabs $0xffff80000010cb08,%rax
ffff80000010bdee:	80 ff ff 
ffff80000010bdf1:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdf4:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bdfb:	80 ff ff 
ffff80000010bdfe:	ff d0                	call   *%rax
  *pte &= ~PTE_U;
ffff80000010be00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be04:	48 8b 00             	mov    (%rax),%rax
ffff80000010be07:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010be0b:	48 89 c2             	mov    %rax,%rdx
ffff80000010be0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be12:	48 89 10             	mov    %rdx,(%rax)
}
ffff80000010be15:	90                   	nop
ffff80000010be16:	c9                   	leave
ffff80000010be17:	c3                   	ret

ffff80000010be18 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pml4e_t *pgdir, uint sz)
{
ffff80000010be18:	55                   	push   %rbp
ffff80000010be19:	48 89 e5             	mov    %rsp,%rbp
ffff80000010be1c:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010be20:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010be24:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  pde_t *d;
  pte_t *pte;
  addr_t pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffff80000010be27:	48 b8 e2 b1 10 00 00 	movabs $0xffff80000010b1e2,%rax
ffff80000010be2e:	80 ff ff 
ffff80000010be31:	ff d0                	call   *%rax
ffff80000010be33:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010be37:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010be3c:	75 0a                	jne    ffff80000010be48 <copyuvm+0x30>
    return 0;
ffff80000010be3e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010be43:	e9 57 01 00 00       	jmp    ffff80000010bf9f <copyuvm+0x187>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010be48:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010be4f:	00 
ffff80000010be50:	e9 1b 01 00 00       	jmp    ffff80000010bf70 <copyuvm+0x158>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffff80000010be55:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010be59:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010be5d:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010be62:	48 89 ce             	mov    %rcx,%rsi
ffff80000010be65:	48 89 c7             	mov    %rax,%rdi
ffff80000010be68:	48 b8 ff b3 10 00 00 	movabs $0xffff80000010b3ff,%rax
ffff80000010be6f:	80 ff ff 
ffff80000010be72:	ff d0                	call   *%rax
ffff80000010be74:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010be78:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010be7d:	75 19                	jne    ffff80000010be98 <copyuvm+0x80>
      panic("copyuvm: pte should exist");
ffff80000010be7f:	48 b8 12 cb 10 00 00 	movabs $0xffff80000010cb12,%rax
ffff80000010be86:	80 ff ff 
ffff80000010be89:	48 89 c7             	mov    %rax,%rdi
ffff80000010be8c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010be93:	80 ff ff 
ffff80000010be96:	ff d0                	call   *%rax
    if(!(*pte & PTE_P))
ffff80000010be98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010be9c:	48 8b 00             	mov    (%rax),%rax
ffff80000010be9f:	83 e0 01             	and    $0x1,%eax
ffff80000010bea2:	48 85 c0             	test   %rax,%rax
ffff80000010bea5:	75 19                	jne    ffff80000010bec0 <copyuvm+0xa8>
      panic("copyuvm: page not present");
ffff80000010bea7:	48 b8 2c cb 10 00 00 	movabs $0xffff80000010cb2c,%rax
ffff80000010beae:	80 ff ff 
ffff80000010beb1:	48 89 c7             	mov    %rax,%rdi
ffff80000010beb4:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bebb:	80 ff ff 
ffff80000010bebe:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010bec0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bec4:	48 8b 00             	mov    (%rax),%rax
ffff80000010bec7:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010becd:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    flags = PTE_FLAGS(*pte);
ffff80000010bed1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bed5:	48 8b 00             	mov    (%rax),%rax
ffff80000010bed8:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010bedd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if((mem = kalloc()) == 0)
ffff80000010bee1:	48 b8 2f 43 10 00 00 	movabs $0xffff80000010432f,%rax
ffff80000010bee8:	80 ff ff 
ffff80000010beeb:	ff d0                	call   *%rax
ffff80000010beed:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010bef1:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010bef6:	0f 84 87 00 00 00    	je     ffff80000010bf83 <copyuvm+0x16b>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
ffff80000010befc:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bf03:	80 ff ff 
ffff80000010bf06:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bf0a:	48 01 d0             	add    %rdx,%rax
ffff80000010bf0d:	48 89 c1             	mov    %rax,%rcx
ffff80000010bf10:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf14:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bf19:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bf1c:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf1f:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff80000010bf26:	80 ff ff 
ffff80000010bf29:	ff d0                	call   *%rax
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
ffff80000010bf2b:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bf2f:	89 c1                	mov    %eax,%ecx
ffff80000010bf31:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf35:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bf3c:	80 00 00 
ffff80000010bf3f:	48 01 c2             	add    %rax,%rdx
ffff80000010bf42:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010bf46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf4a:	41 89 c8             	mov    %ecx,%r8d
ffff80000010bf4d:	48 89 d1             	mov    %rdx,%rcx
ffff80000010bf50:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bf55:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf58:	48 b8 7e b6 10 00 00 	movabs $0xffff80000010b67e,%rax
ffff80000010bf5f:	80 ff ff 
ffff80000010bf62:	ff d0                	call   *%rax
ffff80000010bf64:	85 c0                	test   %eax,%eax
ffff80000010bf66:	78 1e                	js     ffff80000010bf86 <copyuvm+0x16e>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010bf68:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bf6f:	00 
ffff80000010bf70:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010bf73:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010bf77:	0f 82 d8 fe ff ff    	jb     ffff80000010be55 <copyuvm+0x3d>
      goto bad;
  }
  return d;
ffff80000010bf7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf81:	eb 1c                	jmp    ffff80000010bf9f <copyuvm+0x187>
      goto bad;
ffff80000010bf83:	90                   	nop
ffff80000010bf84:	eb 01                	jmp    ffff80000010bf87 <copyuvm+0x16f>
      goto bad;
ffff80000010bf86:	90                   	nop

bad:
  freevm(d);
ffff80000010bf87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf8b:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf8e:	48 b8 76 bb 10 00 00 	movabs $0xffff80000010bb76,%rax
ffff80000010bf95:	80 ff ff 
ffff80000010bf98:	ff d0                	call   *%rax
  return 0;
ffff80000010bf9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010bf9f:	c9                   	leave
ffff80000010bfa0:	c3                   	ret

ffff80000010bfa1 <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pml4e_t *pgdir, char *uva)
{
ffff80000010bfa1:	55                   	push   %rbp
ffff80000010bfa2:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bfa5:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010bfa9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bfad:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010bfb1:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010bfb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bfb9:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bfbe:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bfc1:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfc4:	48 b8 ff b3 10 00 00 	movabs $0xffff80000010b3ff,%rax
ffff80000010bfcb:	80 ff ff 
ffff80000010bfce:	ff d0                	call   *%rax
ffff80000010bfd0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffff80000010bfd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bfd8:	48 8b 00             	mov    (%rax),%rax
ffff80000010bfdb:	83 e0 01             	and    $0x1,%eax
ffff80000010bfde:	48 85 c0             	test   %rax,%rax
ffff80000010bfe1:	75 07                	jne    ffff80000010bfea <uva2ka+0x49>
    return 0;
ffff80000010bfe3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bfe8:	eb 33                	jmp    ffff80000010c01d <uva2ka+0x7c>
  if((*pte & PTE_U) == 0)
ffff80000010bfea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bfee:	48 8b 00             	mov    (%rax),%rax
ffff80000010bff1:	83 e0 04             	and    $0x4,%eax
ffff80000010bff4:	48 85 c0             	test   %rax,%rax
ffff80000010bff7:	75 07                	jne    ffff80000010c000 <uva2ka+0x5f>
    return 0;
ffff80000010bff9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bffe:	eb 1d                	jmp    ffff80000010c01d <uva2ka+0x7c>
  return (char*)P2V(PTE_ADDR(*pte));
ffff80000010c000:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c004:	48 8b 00             	mov    (%rax),%rax
ffff80000010c007:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c00d:	48 89 c2             	mov    %rax,%rdx
ffff80000010c010:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c017:	80 ff ff 
ffff80000010c01a:	48 01 d0             	add    %rdx,%rax
}
ffff80000010c01d:	c9                   	leave
ffff80000010c01e:	c3                   	ret

ffff80000010c01f <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pml4e_t *pgdir, addr_t va, void *p, uint64 len)
{
ffff80000010c01f:	55                   	push   %rbp
ffff80000010c020:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c023:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c027:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c02b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c02f:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010c033:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  char *buf, *pa0;
  addr_t n, va0;

  buf = (char*)p;
ffff80000010c037:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c03b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffff80000010c03f:	e9 b0 00 00 00       	jmp    ffff80000010c0f4 <copyout+0xd5>
    va0 = PGROUNDDOWN(va);
ffff80000010c044:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c048:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c04e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010c052:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010c056:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c05a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c05d:	48 89 c7             	mov    %rax,%rdi
ffff80000010c060:	48 b8 a1 bf 10 00 00 	movabs $0xffff80000010bfa1,%rax
ffff80000010c067:	80 ff ff 
ffff80000010c06a:	ff d0                	call   *%rax
ffff80000010c06c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffff80000010c070:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010c075:	75 0a                	jne    ffff80000010c081 <copyout+0x62>
      return -1;
ffff80000010c077:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c07c:	e9 83 00 00 00       	jmp    ffff80000010c104 <copyout+0xe5>
    n = PGSIZE - (va - va0);
ffff80000010c081:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c085:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010c089:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c08f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffff80000010c093:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c097:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010c09b:	73 08                	jae    ffff80000010c0a5 <copyout+0x86>
      n = len;
ffff80000010c09d:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c0a1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffff80000010c0a5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c0a9:	89 c6                	mov    %eax,%esi
ffff80000010c0ab:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c0af:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010c0b3:	48 89 c2             	mov    %rax,%rdx
ffff80000010c0b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c0ba:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c0be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c0c2:	89 f2                	mov    %esi,%edx
ffff80000010c0c4:	48 89 c6             	mov    %rax,%rsi
ffff80000010c0c7:	48 89 cf             	mov    %rcx,%rdi
ffff80000010c0ca:	48 b8 5b 7b 10 00 00 	movabs $0xffff800000107b5b,%rax
ffff80000010c0d1:	80 ff ff 
ffff80000010c0d4:	ff d0                	call   *%rax
    len -= n;
ffff80000010c0d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c0da:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
    buf += n;
ffff80000010c0de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c0e2:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffff80000010c0e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c0ea:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c0f0:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  while(len > 0){
ffff80000010c0f4:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010c0f9:	0f 85 45 ff ff ff    	jne    ffff80000010c044 <copyout+0x25>
  }
  return 0;
ffff80000010c0ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010c104:	c9                   	leave
ffff80000010c105:	c3                   	ret

ffff80000010c106 <traceinit>:
    struct trace_event events[TRACE_BUF_SIZE];  // Ring buffer
} traceBuffer;

// Initalize the tracing event
void 
traceinit(void){
ffff80000010c106:	55                   	push   %rbp
ffff80000010c107:	48 89 e5             	mov    %rsp,%rbp
    initlock(&traceBuffer.lock, "trace");
ffff80000010c10a:	48 ba 46 cb 10 00 00 	movabs $0xffff80000010cb46,%rdx
ffff80000010c111:	80 ff ff 
ffff80000010c114:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c11b:	80 ff ff 
ffff80000010c11e:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c121:	48 89 c7             	mov    %rax,%rdi
ffff80000010c124:	48 b8 8d 76 10 00 00 	movabs $0xffff80000010768d,%rax
ffff80000010c12b:	80 ff ff 
ffff80000010c12e:	ff d0                	call   *%rax
    traceBuffer.enabled = 1;
ffff80000010c130:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c137:	80 ff ff 
ffff80000010c13a:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
    traceBuffer.seq = 0;
ffff80000010c141:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c148:	80 ff ff 
ffff80000010c14b:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%rax)
    traceBuffer.readseq = 0;
ffff80000010c152:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c159:	80 ff ff 
ffff80000010c15c:	c7 40 70 00 00 00 00 	movl   $0x0,0x70(%rax)
}
ffff80000010c163:	90                   	nop
ffff80000010c164:	5d                   	pop    %rbp
ffff80000010c165:	c3                   	ret

ffff80000010c166 <traceevent>:

// trace the current event
void 
traceevent(int type, int pid, int arg0, int arg1, char *name){
ffff80000010c166:	55                   	push   %rbp
ffff80000010c167:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c16a:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010c16e:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010c171:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff80000010c174:	89 55 e4             	mov    %edx,-0x1c(%rbp)
ffff80000010c177:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffff80000010c17a:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    struct trace_event *event;

    // if the trace buffer is not enabled, then return nothing
    if(!traceBuffer.enabled)
ffff80000010c17e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c185:	80 ff ff 
ffff80000010c188:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010c18b:	85 c0                	test   %eax,%eax
ffff80000010c18d:	0f 84 64 01 00 00    	je     ffff80000010c2f7 <traceevent+0x191>
        return;

    //aquire the lock
    acquire(&traceBuffer.lock);
ffff80000010c193:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c19a:	80 ff ff 
ffff80000010c19d:	48 89 c7             	mov    %rax,%rdi
ffff80000010c1a0:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010c1a7:	80 ff ff 
ffff80000010c1aa:	ff d0                	call   *%rax
    // debug
    //cprintf("debug: traceevent type %d pid %d name %s\n", type, pid, name);


    event = &traceBuffer.events[traceBuffer.seq % TRACE_BUF_SIZE]; // Allows ring to wrap
ffff80000010c1ac:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1b3:	80 ff ff 
ffff80000010c1b6:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c1b9:	83 e0 7f             	and    $0x7f,%eax
ffff80000010c1bc:	89 c2                	mov    %eax,%edx
ffff80000010c1be:	48 89 d0             	mov    %rdx,%rax
ffff80000010c1c1:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010c1c5:	48 01 d0             	add    %rdx,%rax
ffff80000010c1c8:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010c1cc:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff80000010c1d0:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1d7:	80 ff ff 
ffff80000010c1da:	48 01 d0             	add    %rdx,%rax
ffff80000010c1dd:	48 83 c0 04          	add    $0x4,%rax
ffff80000010c1e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    // Set the event metadata
    event->seq = traceBuffer.seq;
ffff80000010c1e5:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1ec:	80 ff ff 
ffff80000010c1ef:	8b 50 6c             	mov    0x6c(%rax),%edx
ffff80000010c1f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c1f6:	89 10                	mov    %edx,(%rax)
    event->ticks = ticks;
ffff80000010c1f8:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff80000010c1ff:	80 ff ff 
ffff80000010c202:	8b 10                	mov    (%rax),%edx
ffff80000010c204:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c208:	89 50 04             	mov    %edx,0x4(%rax)
    event->type = type;
ffff80000010c20b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c20f:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010c212:	89 50 08             	mov    %edx,0x8(%rax)
    event->pid = pid;
ffff80000010c215:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c219:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010c21c:	89 50 0c             	mov    %edx,0xc(%rax)
    event->arg0 = arg0;
ffff80000010c21f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c223:	8b 55 e4             	mov    -0x1c(%rbp),%edx
ffff80000010c226:	89 50 10             	mov    %edx,0x10(%rax)
    event->arg1 = arg1;
ffff80000010c229:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c22d:	8b 55 e0             	mov    -0x20(%rbp),%edx
ffff80000010c230:	89 50 14             	mov    %edx,0x14(%rax)

    memset(event->name, 0, sizeof(event->name));
ffff80000010c233:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c237:	48 83 c0 18          	add    $0x18,%rax
ffff80000010c23b:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c240:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c245:	48 89 c7             	mov    %rax,%rdi
ffff80000010c248:	48 b8 56 7a 10 00 00 	movabs $0xffff800000107a56,%rax
ffff80000010c24f:	80 ff ff 
ffff80000010c252:	ff d0                	call   *%rax

    if(name)
ffff80000010c254:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff80000010c259:	74 23                	je     ffff80000010c27e <traceevent+0x118>
        safestrcpy(event->name, name, sizeof(event->name));
ffff80000010c25b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c25f:	48 8d 48 18          	lea    0x18(%rax),%rcx
ffff80000010c263:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c267:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c26c:	48 89 c6             	mov    %rax,%rsi
ffff80000010c26f:	48 89 cf             	mov    %rcx,%rdi
ffff80000010c272:	48 b8 0e 7d 10 00 00 	movabs $0xffff800000107d0e,%rax
ffff80000010c279:	80 ff ff 
ffff80000010c27c:	ff d0                	call   *%rax

    traceBuffer.seq++; // Update sequence number
ffff80000010c27e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c285:	80 ff ff 
ffff80000010c288:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c28b:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010c28e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c295:	80 ff ff 
ffff80000010c298:	89 50 6c             	mov    %edx,0x6c(%rax)

    // If the writer gets more than 128 events ahead, old events are gone, move readseq  foreward to the oldest event still available
    if(traceBuffer.seq - traceBuffer.readseq > TRACE_BUF_SIZE)
ffff80000010c29b:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c2a2:	80 ff ff 
ffff80000010c2a5:	8b 50 6c             	mov    0x6c(%rax),%edx
ffff80000010c2a8:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c2af:	80 ff ff 
ffff80000010c2b2:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010c2b5:	29 c2                	sub    %eax,%edx
ffff80000010c2b7:	81 fa 80 00 00 00    	cmp    $0x80,%edx
ffff80000010c2bd:	76 1d                	jbe    ffff80000010c2dc <traceevent+0x176>
        traceBuffer.readseq = traceBuffer.seq - TRACE_BUF_SIZE;
ffff80000010c2bf:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c2c6:	80 ff ff 
ffff80000010c2c9:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c2cc:	8d 50 80             	lea    -0x80(%rax),%edx
ffff80000010c2cf:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c2d6:	80 ff ff 
ffff80000010c2d9:	89 50 70             	mov    %edx,0x70(%rax)

    // Release the lock
    release(&traceBuffer.lock);
ffff80000010c2dc:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c2e3:	80 ff ff 
ffff80000010c2e6:	48 89 c7             	mov    %rax,%rdi
ffff80000010c2e9:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010c2f0:	80 ff ff 
ffff80000010c2f3:	ff d0                	call   *%rax
ffff80000010c2f5:	eb 01                	jmp    ffff80000010c2f8 <traceevent+0x192>
        return;
ffff80000010c2f7:	90                   	nop
}
ffff80000010c2f8:	c9                   	leave
ffff80000010c2f9:	c3                   	ret

ffff80000010c2fa <traceread>:

int
traceread(struct trace_event *dst){
ffff80000010c2fa:	55                   	push   %rbp
ffff80000010c2fb:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c2fe:	53                   	push   %rbx
ffff80000010c2ff:	48 83 ec 48          	sub    $0x48,%rsp
ffff80000010c303:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    struct trace_event event;

    acquire(&traceBuffer.lock);
ffff80000010c307:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c30e:	80 ff ff 
ffff80000010c311:	48 89 c7             	mov    %rax,%rdi
ffff80000010c314:	48 b8 c2 76 10 00 00 	movabs $0xffff8000001076c2,%rax
ffff80000010c31b:	80 ff ff 
ffff80000010c31e:	ff d0                	call   *%rax

    // No unread events available, return 0
    if(traceBuffer.readseq == traceBuffer.seq){
ffff80000010c320:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c327:	80 ff ff 
ffff80000010c32a:	8b 50 70             	mov    0x70(%rax),%edx
ffff80000010c32d:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c334:	80 ff ff 
ffff80000010c337:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c33a:	39 c2                	cmp    %eax,%edx
ffff80000010c33c:	75 23                	jne    ffff80000010c361 <traceread+0x67>
        release(&traceBuffer.lock); // Release the lock
ffff80000010c33e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c345:	80 ff ff 
ffff80000010c348:	48 89 c7             	mov    %rax,%rdi
ffff80000010c34b:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010c352:	80 ff ff 
ffff80000010c355:	ff d0                	call   *%rax
        return 0;
ffff80000010c357:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c35c:	e9 ca 00 00 00       	jmp    ffff80000010c42b <traceread+0x131>
    }

    event = traceBuffer.events[traceBuffer.readseq % TRACE_BUF_SIZE];
ffff80000010c361:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c368:	80 ff ff 
ffff80000010c36b:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010c36e:	83 e0 7f             	and    $0x7f,%eax
ffff80000010c371:	48 ba 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rdx
ffff80000010c378:	80 ff ff 
ffff80000010c37b:	89 c1                	mov    %eax,%ecx
ffff80000010c37d:	48 89 c8             	mov    %rcx,%rax
ffff80000010c380:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010c384:	48 01 c8             	add    %rcx,%rax
ffff80000010c387:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010c38b:	48 01 d0             	add    %rdx,%rax
ffff80000010c38e:	48 83 c0 70          	add    $0x70,%rax
ffff80000010c392:	48 8b 48 04          	mov    0x4(%rax),%rcx
ffff80000010c396:	48 8b 58 0c          	mov    0xc(%rax),%rbx
ffff80000010c39a:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010c39e:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff80000010c3a2:	48 8b 48 14          	mov    0x14(%rax),%rcx
ffff80000010c3a6:	48 8b 58 1c          	mov    0x1c(%rax),%rbx
ffff80000010c3aa:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff80000010c3ae:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff80000010c3b2:	48 8b 40 24          	mov    0x24(%rax),%rax
ffff80000010c3b6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    traceBuffer.readseq++; // Increment
ffff80000010c3ba:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3c1:	80 ff ff 
ffff80000010c3c4:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010c3c7:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010c3ca:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3d1:	80 ff ff 
ffff80000010c3d4:	89 50 70             	mov    %edx,0x70(%rax)

    release(&traceBuffer.lock);
ffff80000010c3d7:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3de:	80 ff ff 
ffff80000010c3e1:	48 89 c7             	mov    %rax,%rdi
ffff80000010c3e4:	48 b8 61 77 10 00 00 	movabs $0xffff800000107761,%rax
ffff80000010c3eb:	80 ff ff 
ffff80000010c3ee:	ff d0                	call   *%rax

    if(copyout(proc->pgdir, (addr_t)dst, &event, sizeof(event)) < 0)
ffff80000010c3f0:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
ffff80000010c3f4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010c3fb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010c3ff:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010c403:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
ffff80000010c407:	b9 28 00 00 00       	mov    $0x28,%ecx
ffff80000010c40c:	48 89 c7             	mov    %rax,%rdi
ffff80000010c40f:	48 b8 1f c0 10 00 00 	movabs $0xffff80000010c01f,%rax
ffff80000010c416:	80 ff ff 
ffff80000010c419:	ff d0                	call   *%rax
ffff80000010c41b:	85 c0                	test   %eax,%eax
ffff80000010c41d:	79 07                	jns    ffff80000010c426 <traceread+0x12c>
        return -1;
ffff80000010c41f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c424:	eb 05                	jmp    ffff80000010c42b <traceread+0x131>

    return 1;
ffff80000010c426:	b8 01 00 00 00       	mov    $0x1,%eax
ffff80000010c42b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff80000010c42f:	c9                   	leave
ffff80000010c430:	c3                   	ret
