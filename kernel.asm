
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
ffff800000100019:	d0 11                	rclb   $1,(%rcx)
ffff80000010001b:	00 20                	add    %ah,(%rax)
ffff80000010001d:	00 10                	add    %dl,(%rax)
	...

ffff800000100020 <mboot_entry>:
ffff800000100020:	31 c0                	xor    %eax,%eax
ffff800000100022:	bf 00 10 00 00       	mov    $0x1000,%edi
ffff800000100027:	b9 00 20 00 00       	mov    $0x2000,%ecx
ffff80000010002c:	f3 aa                	rep stos %al,(%rdi)
ffff80000010002e:	b8 03 20 00 00       	mov    $0x2003,%eax
ffff800000100033:	a3 00 10 00 00 a3 00 	movabs %eax,0x1800a300001000
ffff80000010003a:	18 00 
ffff80000010003c:	00 b8 83 00 00 00    	add    %bh,0x83(%rax)
ffff800000100042:	a3                   	.byte 0xa3
ffff800000100043:	00 20                	add    %ah,(%rax)
ffff800000100045:	00 00                	add    %al,(%rax)
ffff800000100047:	31 db                	xor    %ebx,%ebx

ffff800000100049 <entry32mp>:
ffff800000100049:	b8 00 10 00 00       	mov    $0x1000,%eax
ffff80000010004e:	0f 22 d8             	mov    %rax,%cr3
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xe30e8>
ffff800000100058:	0f 20 e0             	mov    %cr4,%rax
ffff80000010005b:	0f ba e8 05          	bts    $0x5,%eax
ffff80000010005f:	0f 22 e0             	mov    %rax,%cr4
ffff800000100062:	b9 80 00 00 c0       	mov    $0xc0000080,%ecx
ffff800000100067:	0f 32                	rdmsr
ffff800000100069:	0f ba e8 00          	bts    $0x0,%eax
ffff80000010006d:	0f ba e8 08          	bts    $0x8,%eax
ffff800000100071:	0f 30                	wrmsr
ffff800000100073:	0f 20 c0             	mov    %cr0,%rax
ffff800000100076:	0d 02 00 01 80       	or     $0x80010002,%eax
ffff80000010007b:	0f 22 c0             	mov    %rax,%cr0
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
ffff8000001000c0:	48 b8 cc 00 10 00 00 	movabs $0xffff8000001000cc,%rax
ffff8000001000c7:	80 ff ff 
ffff8000001000ca:	ff e0                	jmp    *%rax

ffff8000001000cc <_start>:
ffff8000001000cc:	48 31 c0             	xor    %rax,%rax
ffff8000001000cf:	8e d0                	mov    %eax,%ss
ffff8000001000d1:	8e d8                	mov    %eax,%ds
ffff8000001000d3:	8e c0                	mov    %eax,%es
ffff8000001000d5:	8e e0                	mov    %eax,%fs
ffff8000001000d7:	8e e8                	mov    %eax,%gs
ffff8000001000d9:	85 db                	test   %ebx,%ebx
ffff8000001000db:	75 14                	jne    ffff8000001000f1 <entry64mp>
ffff8000001000dd:	48 b8 00 00 01 00 00 	movabs $0xffff800000010000,%rax
ffff8000001000e4:	80 ff ff 
ffff8000001000e7:	48 89 c4             	mov    %rax,%rsp
ffff8000001000ea:	e9 fb 52 00 00       	jmp    ffff8000001053ea <main>

ffff8000001000ef <__deadloop>:
ffff8000001000ef:	eb fe                	jmp    ffff8000001000ef <__deadloop>

ffff8000001000f1 <entry64mp>:
ffff8000001000f1:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
ffff8000001000f8:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
ffff8000001000fc:	e9 19 54 00 00       	jmp    ffff80000010551a <mpenter>

ffff800000100101 <wrmsr>:
ffff800000100101:	48 89 f9             	mov    %rdi,%rcx
ffff800000100104:	48 89 f0             	mov    %rsi,%rax
ffff800000100107:	48 c1 ee 20          	shr    $0x20,%rsi
ffff80000010010b:	48 89 f2             	mov    %rsi,%rdx
ffff80000010010e:	0f 30                	wrmsr
ffff800000100110:	c3                   	ret

ffff800000100111 <ignore_sysret>:
ffff800000100111:	48 c7 c0 da ff ff ff 	mov    $0xffffffffffffffda,%rax
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
ffff800000100123:	48 ba a0 bf 10 00 00 	movabs $0xffff80000010bfa0,%rdx
ffff80000010012a:	80 ff ff 
ffff80000010012d:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff800000100134:	80 ff ff 
ffff800000100137:	48 89 d6             	mov    %rdx,%rsi
ffff80000010013a:	48 89 c7             	mov    %rax,%rdi
ffff80000010013d:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
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
ffff8000001001c1:	48 ba a7 bf 10 00 00 	movabs $0xffff80000010bfa7,%rdx
ffff8000001001c8:	80 ff ff 
ffff8000001001cb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d1:	48 b8 54 72 10 00 00 	movabs $0xffff800000107254,%rax
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
ffff800000100249:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff8000001002a8:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff8000001002af:	80 ff ff 
ffff8000001002b2:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff8000001002b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002b8:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001002bf:	48 b8 ac 72 10 00 00 	movabs $0xffff8000001072ac,%rax
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
ffff800000100365:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010036c:	80 ff ff 
ffff80000010036f:	ff d0                	call   *%rax
      acquiresleep(&b->lock);
ffff800000100371:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100375:	48 83 c0 10          	add    $0x10,%rax
ffff800000100379:	48 89 c7             	mov    %rax,%rdi
ffff80000010037c:	48 b8 ac 72 10 00 00 	movabs $0xffff8000001072ac,%rax
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
ffff8000001003b1:	48 b8 ae bf 10 00 00 	movabs $0xffff80000010bfae,%rax
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
ffff800000100431:	48 b8 97 73 10 00 00 	movabs $0xffff800000107397,%rax
ffff800000100438:	80 ff ff 
ffff80000010043b:	ff d0                	call   *%rax
ffff80000010043d:	85 c0                	test   %eax,%eax
ffff80000010043f:	75 19                	jne    ffff80000010045a <bwrite+0x40>
    panic("bwrite");
ffff800000100441:	48 b8 bf bf 10 00 00 	movabs $0xffff80000010bfbf,%rax
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
ffff800000100498:	48 b8 97 73 10 00 00 	movabs $0xffff800000107397,%rax
ffff80000010049f:	80 ff ff 
ffff8000001004a2:	ff d0                	call   *%rax
ffff8000001004a4:	85 c0                	test   %eax,%eax
ffff8000001004a6:	75 19                	jne    ffff8000001004c1 <brelse+0x40>
    panic("brelse");
ffff8000001004a8:	48 b8 c6 bf 10 00 00 	movabs $0xffff80000010bfc6,%rax
ffff8000001004af:	80 ff ff 
ffff8000001004b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004b5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001004bc:	80 ff ff 
ffff8000001004bf:	ff d0                	call   *%rax

  releasesleep(&b->lock);
ffff8000001004c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004c5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001004cc:	48 b8 32 73 10 00 00 	movabs $0xffff800000107332,%rax
ffff8000001004d3:	80 ff ff 
ffff8000001004d6:	ff d0                	call   *%rax

  acquire(&bcache.lock);
ffff8000001004d8:	48 b8 00 e0 10 00 00 	movabs $0xffff80000010e000,%rax
ffff8000001004df:	80 ff ff 
ffff8000001004e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e5:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff8000001005c3:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff8000001008b3:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001008ba:	80 ff ff 
ffff8000001008bd:	ff d0                	call   *%rax

  if (fmt == 0)
ffff8000001008bf:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008c6:	00 
ffff8000001008c7:	75 19                	jne    ffff8000001008e2 <cprintf+0xde>
    panic("null fmt");
ffff8000001008c9:	48 b8 cd bf 10 00 00 	movabs $0xffff80000010bfcd,%rax
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
ffff800000100b08:	48 b8 d6 bf 10 00 00 	movabs $0xffff80000010bfd6,%rax
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
ffff800000100bdb:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000100c24:	48 ba dd bf 10 00 00 	movabs $0xffff80000010bfdd,%rdx
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
ffff800000100c5c:	48 b8 ec bf 10 00 00 	movabs $0xffff80000010bfec,%rax
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
ffff800000100c88:	48 b8 75 75 10 00 00 	movabs $0xffff800000107575,%rax
ffff800000100c8f:	80 ff ff 
ffff800000100c92:	ff d0                	call   *%rax
  for (i=0; i<10; i++)
ffff800000100c94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100c9b:	eb 2f                	jmp    ffff800000100ccc <panic+0xe2>
    cprintf(" %p\n", pcs[i]);
ffff800000100c9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ca0:	48 98                	cltq
ffff800000100ca2:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffff800000100ca7:	48 ba ee bf 10 00 00 	movabs $0xffff80000010bfee,%rdx
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
ffff800000100e0d:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
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
ffff800000100e49:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
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
ffff800000100f1a:	48 b8 b6 9c 10 00 00 	movabs $0xffff800000109cb6,%rax
ffff800000100f21:	80 ff ff 
ffff800000100f24:	ff d0                	call   *%rax
ffff800000100f26:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000100f2b:	48 b8 b6 9c 10 00 00 	movabs $0xffff800000109cb6,%rax
ffff800000100f32:	80 ff ff 
ffff800000100f35:	ff d0                	call   *%rax
ffff800000100f37:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000100f3c:	48 b8 b6 9c 10 00 00 	movabs $0xffff800000109cb6,%rax
ffff800000100f43:	80 ff ff 
ffff800000100f46:	ff d0                	call   *%rax
ffff800000100f48:	eb 11                	jmp    ffff800000100f5b <consputc+0x84>
  } else
    uartputc(c);
ffff800000100f4a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100f4d:	89 c7                	mov    %eax,%edi
ffff800000100f4f:	48 b8 b6 9c 10 00 00 	movabs $0xffff800000109cb6,%rax
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
ffff800000100f88:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000100ffd:	48 b8 e0 70 10 00 00 	movabs $0xffff8000001070e0,%rax
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
ffff8000001011f1:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
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
ffff800000101226:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101271:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff8000001012a1:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff8000001012e4:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
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
ffff8000001013c2:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101423:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000101475:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff80000010149d:	48 ba f3 bf 10 00 00 	movabs $0xffff80000010bff3,%rdx
ffff8000001014a4:	80 ff ff 
ffff8000001014a7:	48 b8 c0 34 11 00 00 	movabs $0xffff8000001134c0,%rax
ffff8000001014ae:	80 ff ff 
ffff8000001014b1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001014b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001014b7:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
ffff8000001014be:	80 ff ff 
ffff8000001014c1:	ff d0                	call   *%rax
  initlock(&input.lock, "input");
ffff8000001014c3:	48 ba fb bf 10 00 00 	movabs $0xffff80000010bffb,%rdx
ffff8000001014ca:	80 ff ff 
ffff8000001014cd:	48 b8 c0 33 11 00 00 	movabs $0xffff8000001133c0,%rax
ffff8000001014d4:	80 ff ff 
ffff8000001014d7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001014da:	48 89 c7             	mov    %rax,%rdi
ffff8000001014dd:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
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
ffff80000010156f:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
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
ffff80000010159c:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
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
ffff80000010160b:	48 b8 80 ad 10 00 00 	movabs $0xffff80000010ad80,%rax
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
ffff8000001016d5:	48 b8 d7 b4 10 00 00 	movabs $0xffff80000010b4d7,%rax
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
ffff80000010172f:	48 b8 af b3 10 00 00 	movabs $0xffff80000010b3af,%rax
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
ffff800000101779:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
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
ffff8000001017ba:	48 b8 d7 b4 10 00 00 	movabs $0xffff80000010b4d7,%rax
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
ffff8000001017ec:	48 b8 4b b9 10 00 00 	movabs $0xffff80000010b94b,%rax
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
ffff800000101834:	48 b8 0e 7b 10 00 00 	movabs $0xffff800000107b0e,%rax
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
ffff800000101873:	48 b8 0e 7b 10 00 00 	movabs $0xffff800000107b0e,%rax
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
ffff8000001018a9:	48 b8 bd bb 10 00 00 	movabs $0xffff80000010bbbd,%rax
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
ffff80000010198a:	48 b8 bd bb 10 00 00 	movabs $0xffff80000010bbbd,%rax
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
ffff8000001019fb:	48 b8 ab 7a 10 00 00 	movabs $0xffff800000107aab,%rax
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
ffff800000101a8b:	48 b8 de ae 10 00 00 	movabs $0xffff80000010aede,%rax
ffff800000101a92:	80 ff ff 
ffff800000101a95:	ff d0                	call   *%rax
  freevm(oldpgdir);
ffff800000101a97:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101a9b:	48 89 c7             	mov    %rax,%rdi
ffff800000101a9e:	48 b8 14 b7 10 00 00 	movabs $0xffff80000010b714,%rax
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
ffff800000101ae4:	48 b8 14 b7 10 00 00 	movabs $0xffff80000010b714,%rax
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
ffff800000101b0a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
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
ffff800000101b21:	48 ba 01 c0 10 00 00 	movabs $0xffff80000010c001,%rdx
ffff800000101b28:	80 ff ff 
ffff800000101b2b:	48 b8 e0 35 11 00 00 	movabs $0xffff8000001135e0,%rax
ffff800000101b32:	80 ff ff 
ffff800000101b35:	48 89 d6             	mov    %rdx,%rsi
ffff800000101b38:	48 89 c7             	mov    %rax,%rdi
ffff800000101b3b:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
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
ffff800000101b5f:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000101b9e:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101bd2:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101bfe:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000101c05:	80 ff ff 
ffff800000101c08:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c0a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101c0e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c11:	85 c0                	test   %eax,%eax
ffff800000101c13:	7f 19                	jg     ffff800000101c2e <filedup+0x49>
    panic("filedup");
ffff800000101c15:	48 b8 08 c0 10 00 00 	movabs $0xffff80000010c008,%rax
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
ffff800000101c4c:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101c78:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000101c7f:	80 ff ff 
ffff800000101c82:	ff d0                	call   *%rax
  if(f->ref < 1)
ffff800000101c84:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101c88:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101c8b:	85 c0                	test   %eax,%eax
ffff800000101c8d:	7f 19                	jg     ffff800000101ca8 <fileclose+0x4a>
    panic("fileclose");
ffff800000101c8f:	48 b8 10 c0 10 00 00 	movabs $0xffff80000010c010,%rax
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
ffff800000101cd1:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101d2f:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000101d53:	48 b8 cc 5d 10 00 00 	movabs $0xffff800000105dcc,%rax
ffff800000101d5a:	80 ff ff 
ffff800000101d5d:	ff d0                	call   *%rax
ffff800000101d5f:	eb 33                	jmp    ffff800000101d94 <fileclose+0x136>
  else if(ff.type == FD_INODE){
ffff800000101d61:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101d64:	83 f8 02             	cmp    $0x2,%eax
ffff800000101d67:	75 2b                	jne    ffff800000101d94 <fileclose+0x136>
    begin_op();
ffff800000101d69:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000101d70:	80 ff ff 
ffff800000101d73:	ff d0                	call   *%rax
    iput(ff.ip);
ffff800000101d75:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101d79:	48 89 c7             	mov    %rax,%rdi
ffff800000101d7c:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000101d83:	80 ff ff 
ffff800000101d86:	ff d0                	call   *%rax
    end_op();
ffff800000101d88:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
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
ffff800000101e58:	48 b8 df 5f 10 00 00 	movabs $0xffff800000105fdf,%rax
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
ffff800000101ee8:	48 b8 1a c0 10 00 00 	movabs $0xffff80000010c01a,%rax
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
ffff800000101f4c:	48 b8 9f 5e 10 00 00 	movabs $0xffff800000105e9f,%rax
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
ffff800000101f96:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
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
ffff80000010201a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
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
ffff800000102034:	48 b8 23 c0 10 00 00 	movabs $0xffff80000010c023,%rax
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
ffff800000102076:	48 b8 33 c0 10 00 00 	movabs $0xffff80000010c033,%rax
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
ffff8000001020d4:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
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
ffff800000102135:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010213c:	80 ff ff 
ffff80000010213f:	ff d0                	call   *%rax
  log_write(bp);
ffff800000102141:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102145:	48 89 c7             	mov    %rax,%rdi
ffff800000102148:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff800000102242:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff8000001022e2:	48 b8 3d c0 10 00 00 	movabs $0xffff80000010c03d,%rax
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
ffff80000010239c:	48 b8 53 c0 10 00 00 	movabs $0xffff80000010c053,%rax
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
ffff8000001023f5:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff800000102429:	48 ba 66 c0 10 00 00 	movabs $0xffff80000010c066,%rdx
ffff800000102430:	80 ff ff 
ffff800000102433:	48 b8 20 46 11 00 00 	movabs $0xffff800000114620,%rax
ffff80000010243a:	80 ff ff 
ffff80000010243d:	48 89 d6             	mov    %rdx,%rsi
ffff800000102440:	48 89 c7             	mov    %rax,%rdi
ffff800000102443:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
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
ffff800000102479:	48 ba 6d c0 10 00 00 	movabs $0xffff80000010c06d,%rdx
ffff800000102480:	80 ff ff 
ffff800000102483:	48 89 d6             	mov    %rdx,%rsi
ffff800000102486:	48 89 c7             	mov    %rax,%rdi
ffff800000102489:	48 b8 54 72 10 00 00 	movabs $0xffff800000107254,%rax
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
ffff800000102549:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff800000102550:	80 ff ff 
ffff800000102553:	ff d0                	call   *%rax
      dip->type = type;
ffff800000102555:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102559:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff80000010255d:	66 89 10             	mov    %dx,(%rax)
      log_write(bp);   // mark it allocated on the disk
ffff800000102560:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102564:	48 89 c7             	mov    %rax,%rdi
ffff800000102567:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff8000001025cd:	48 b8 73 c0 10 00 00 	movabs $0xffff80000010c073,%rax
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
ffff8000001026c5:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff8000001026cc:	80 ff ff 
ffff8000001026cf:	ff d0                	call   *%rax
  log_write(bp);
ffff8000001026d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001026d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001026d8:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff800000102715:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000102779:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff8000001027cb:	48 b8 85 c0 10 00 00 	movabs $0xffff80000010c085,%rax
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
ffff800000102825:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000102850:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff80000010287a:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff8000001028aa:	48 b8 95 c0 10 00 00 	movabs $0xffff80000010c095,%rax
ffff8000001028b1:	80 ff ff 
ffff8000001028b4:	48 89 c7             	mov    %rax,%rdi
ffff8000001028b7:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001028be:	80 ff ff 
ffff8000001028c1:	ff d0                	call   *%rax

  acquiresleep(&ip->lock);
ffff8000001028c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001028c7:	48 83 c0 10          	add    $0x10,%rax
ffff8000001028cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001028ce:	48 b8 ac 72 10 00 00 	movabs $0xffff8000001072ac,%rax
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
ffff8000001029bf:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
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
ffff800000102a07:	48 b8 9b c0 10 00 00 	movabs $0xffff80000010c09b,%rax
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
ffff800000102a41:	48 b8 97 73 10 00 00 	movabs $0xffff800000107397,%rax
ffff800000102a48:	80 ff ff 
ffff800000102a4b:	ff d0                	call   *%rax
ffff800000102a4d:	85 c0                	test   %eax,%eax
ffff800000102a4f:	74 0b                	je     ffff800000102a5c <iunlock+0x39>
ffff800000102a51:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a55:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102a58:	85 c0                	test   %eax,%eax
ffff800000102a5a:	7f 19                	jg     ffff800000102a75 <iunlock+0x52>
    panic("iunlock");
ffff800000102a5c:	48 b8 aa c0 10 00 00 	movabs $0xffff80000010c0aa,%rax
ffff800000102a63:	80 ff ff 
ffff800000102a66:	48 89 c7             	mov    %rax,%rdi
ffff800000102a69:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102a70:	80 ff ff 
ffff800000102a73:	ff d0                	call   *%rax

  releasesleep(&ip->lock);
ffff800000102a75:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a79:	48 83 c0 10          	add    $0x10,%rax
ffff800000102a7d:	48 89 c7             	mov    %rax,%rdi
ffff800000102a80:	48 b8 32 73 10 00 00 	movabs $0xffff800000107332,%rax
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
ffff800000102aa8:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000102af6:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000102b42:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000102b7a:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000102cdc:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff800000102d00:	48 b8 b2 c0 10 00 00 	movabs $0xffff80000010c0b2,%rax
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
ffff80000010307f:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
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
ffff800000103247:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff80000010324e:	80 ff ff 
ffff800000103251:	ff d0                	call   *%rax
    log_write(bp);
ffff800000103253:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103257:	48 89 c7             	mov    %rax,%rdi
ffff80000010325a:	48 b8 45 52 10 00 00 	movabs $0xffff800000105245,%rax
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
ffff8000001032f5:	48 b8 cd 79 10 00 00 	movabs $0xffff8000001079cd,%rax
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
ffff800000103328:	48 b8 c5 c0 10 00 00 	movabs $0xffff80000010c0c5,%rax
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
ffff800000103371:	48 b8 d7 c0 10 00 00 	movabs $0xffff80000010c0d7,%rax
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
ffff800000103490:	48 b8 e6 c0 10 00 00 	movabs $0xffff80000010c0e6,%rax
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
ffff8000001034e6:	48 b8 3a 7a 10 00 00 	movabs $0xffff800000107a3a,%rax
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
ffff80000010351d:	48 b8 f3 c0 10 00 00 	movabs $0xffff80000010c0f3,%rax
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
ffff8000001035bd:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
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
ffff8000001035dc:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
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
ffff8000001038e4:	48 ba fb c0 10 00 00 	movabs $0xffff80000010c0fb,%rdx
ffff8000001038eb:	80 ff ff 
ffff8000001038ee:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff8000001038f5:	80 ff ff 
ffff8000001038f8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001038fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001038fe:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
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
ffff8000001039bc:	48 b8 ff c0 10 00 00 	movabs $0xffff80000010c0ff,%rax
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
ffff8000001039e3:	48 b8 08 c1 10 00 00 	movabs $0xffff80000010c108,%rax
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
ffff800000103a45:	48 b8 ff c0 10 00 00 	movabs $0xffff80000010c0ff,%rax
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
ffff800000103b9e:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000103bcf:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000103c66:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
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
ffff800000103cad:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000103cd2:	48 b8 97 73 10 00 00 	movabs $0xffff800000107397,%rax
ffff800000103cd9:	80 ff ff 
ffff800000103cdc:	ff d0                	call   *%rax
ffff800000103cde:	85 c0                	test   %eax,%eax
ffff800000103ce0:	75 19                	jne    ffff800000103cfb <iderw+0x40>
    panic("iderw: buf not locked");
ffff800000103ce2:	48 b8 1a c1 10 00 00 	movabs $0xffff80000010c11a,%rax
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
ffff800000103d09:	48 b8 30 c1 10 00 00 	movabs $0xffff80000010c130,%rax
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
ffff800000103d3d:	48 b8 45 c1 10 00 00 	movabs $0xffff80000010c145,%rax
ffff800000103d44:	80 ff ff 
ffff800000103d47:	48 89 c7             	mov    %rax,%rdi
ffff800000103d4a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103d51:	80 ff ff 
ffff800000103d54:	ff d0                	call   *%rax

  acquire(&idelock);  //DOC:acquire-lock
ffff800000103d56:	48 b8 c0 70 11 00 00 	movabs $0xffff8000001170c0,%rax
ffff800000103d5d:	80 ff ff 
ffff800000103d60:	48 89 c7             	mov    %rax,%rdi
ffff800000103d63:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000103df2:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
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
ffff800000103e19:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff800000103ef4:	48 b8 68 c1 10 00 00 	movabs $0xffff80000010c168,%rax
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
ffff800000103fd2:	48 ba 9a c1 10 00 00 	movabs $0xffff80000010c19a,%rdx
ffff800000103fd9:	80 ff ff 
ffff800000103fdc:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000103fe3:	80 ff ff 
ffff800000103fe6:	48 89 d6             	mov    %rdx,%rsi
ffff800000103fe9:	48 89 c7             	mov    %rax,%rdi
ffff800000103fec:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
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
ffff8000001040bf:	48 b8 00 d0 11 00 00 	movabs $0xffff80000011d000,%rax
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
ffff8000001040e8:	48 b8 9f c1 10 00 00 	movabs $0xffff80000010c19f,%rax
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
ffff800000104112:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
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
ffff80000010413c:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000104195:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
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
ffff8000001041ca:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
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
ffff800000104217:	48 b8 a5 c1 10 00 00 	movabs $0xffff80000010c1a5,%rax
ffff80000010421e:	80 ff ff 
ffff800000104221:	48 89 c7             	mov    %rax,%rdi
ffff800000104224:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010422b:	80 ff ff 
ffff80000010422e:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff800000104230:	48 b8 40 71 11 00 00 	movabs $0xffff800000117140,%rax
ffff800000104237:	80 ff ff 
ffff80000010423a:	48 89 c7             	mov    %rax,%rdi
ffff80000010423d:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000104244:	80 ff ff 
ffff800000104247:	ff d0                	call   *%rax
  return (char*)r;
ffff800000104249:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010424d:	c9                   	leave
ffff80000010424e:	c3                   	ret

ffff80000010424f <inb>:
{
ffff80000010424f:	55                   	push   %rbp
ffff800000104250:	48 89 e5             	mov    %rsp,%rbp
ffff800000104253:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104257:	89 f8                	mov    %edi,%eax
ffff800000104259:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff80000010425d:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104261:	89 c2                	mov    %eax,%edx
ffff800000104263:	ec                   	in     (%dx),%al
ffff800000104264:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000104267:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff80000010426b:	c9                   	leave
ffff80000010426c:	c3                   	ret

ffff80000010426d <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
ffff80000010426d:	55                   	push   %rbp
ffff80000010426e:	48 89 e5             	mov    %rsp,%rbp
ffff800000104271:	48 83 ec 10          	sub    $0x10,%rsp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
ffff800000104275:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010427a:	48 b8 4f 42 10 00 00 	movabs $0xffff80000010424f,%rax
ffff800000104281:	80 ff ff 
ffff800000104284:	ff d0                	call   *%rax
ffff800000104286:	0f b6 c0             	movzbl %al,%eax
ffff800000104289:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((st & KBS_DIB) == 0)
ffff80000010428c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010428f:	83 e0 01             	and    $0x1,%eax
ffff800000104292:	85 c0                	test   %eax,%eax
ffff800000104294:	75 0a                	jne    ffff8000001042a0 <kbdgetc+0x33>
    return -1;
ffff800000104296:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010429b:	e9 a4 01 00 00       	jmp    ffff800000104444 <kbdgetc+0x1d7>
  data = inb(KBDATAP);
ffff8000001042a0:	bf 60 00 00 00       	mov    $0x60,%edi
ffff8000001042a5:	48 b8 4f 42 10 00 00 	movabs $0xffff80000010424f,%rax
ffff8000001042ac:	80 ff ff 
ffff8000001042af:	ff d0                	call   *%rax
ffff8000001042b1:	0f b6 c0             	movzbl %al,%eax
ffff8000001042b4:	89 45 fc             	mov    %eax,-0x4(%rbp)

  if(data == 0xE0){
ffff8000001042b7:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff8000001042be:	75 27                	jne    ffff8000001042e7 <kbdgetc+0x7a>
    shift |= E0ESC;
ffff8000001042c0:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001042c7:	80 ff ff 
ffff8000001042ca:	8b 00                	mov    (%rax),%eax
ffff8000001042cc:	83 c8 40             	or     $0x40,%eax
ffff8000001042cf:	89 c2                	mov    %eax,%edx
ffff8000001042d1:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001042d8:	80 ff ff 
ffff8000001042db:	89 10                	mov    %edx,(%rax)
    return 0;
ffff8000001042dd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001042e2:	e9 5d 01 00 00       	jmp    ffff800000104444 <kbdgetc+0x1d7>
  } else if(data & 0x80){
ffff8000001042e7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001042ea:	25 80 00 00 00       	and    $0x80,%eax
ffff8000001042ef:	85 c0                	test   %eax,%eax
ffff8000001042f1:	74 56                	je     ffff800000104349 <kbdgetc+0xdc>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
ffff8000001042f3:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001042fa:	80 ff ff 
ffff8000001042fd:	8b 00                	mov    (%rax),%eax
ffff8000001042ff:	83 e0 40             	and    $0x40,%eax
ffff800000104302:	85 c0                	test   %eax,%eax
ffff800000104304:	75 04                	jne    ffff80000010430a <kbdgetc+0x9d>
ffff800000104306:	83 65 fc 7f          	andl   $0x7f,-0x4(%rbp)
    shift &= ~(shiftcode[data] | E0ESC);
ffff80000010430a:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104311:	80 ff ff 
ffff800000104314:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104317:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff80000010431b:	83 c8 40             	or     $0x40,%eax
ffff80000010431e:	0f b6 c0             	movzbl %al,%eax
ffff800000104321:	f7 d0                	not    %eax
ffff800000104323:	89 c2                	mov    %eax,%edx
ffff800000104325:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010432c:	80 ff ff 
ffff80000010432f:	8b 00                	mov    (%rax),%eax
ffff800000104331:	21 c2                	and    %eax,%edx
ffff800000104333:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010433a:	80 ff ff 
ffff80000010433d:	89 10                	mov    %edx,(%rax)
    return 0;
ffff80000010433f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104344:	e9 fb 00 00 00       	jmp    ffff800000104444 <kbdgetc+0x1d7>
  } else if(shift & E0ESC){
ffff800000104349:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104350:	80 ff ff 
ffff800000104353:	8b 00                	mov    (%rax),%eax
ffff800000104355:	83 e0 40             	and    $0x40,%eax
ffff800000104358:	85 c0                	test   %eax,%eax
ffff80000010435a:	74 24                	je     ffff800000104380 <kbdgetc+0x113>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
ffff80000010435c:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
    shift &= ~E0ESC;
ffff800000104363:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010436a:	80 ff ff 
ffff80000010436d:	8b 00                	mov    (%rax),%eax
ffff80000010436f:	83 e0 bf             	and    $0xffffffbf,%eax
ffff800000104372:	89 c2                	mov    %eax,%edx
ffff800000104374:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010437b:	80 ff ff 
ffff80000010437e:	89 10                	mov    %edx,(%rax)
  }

  shift |= shiftcode[data];
ffff800000104380:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104387:	80 ff ff 
ffff80000010438a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010438d:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104391:	0f b6 d0             	movzbl %al,%edx
ffff800000104394:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff80000010439b:	80 ff ff 
ffff80000010439e:	8b 00                	mov    (%rax),%eax
ffff8000001043a0:	09 c2                	or     %eax,%edx
ffff8000001043a2:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043a9:	80 ff ff 
ffff8000001043ac:	89 10                	mov    %edx,(%rax)
  shift ^= togglecode[data];
ffff8000001043ae:	48 ba 20 d1 10 00 00 	movabs $0xffff80000010d120,%rdx
ffff8000001043b5:	80 ff ff 
ffff8000001043b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001043bb:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001043bf:	0f b6 d0             	movzbl %al,%edx
ffff8000001043c2:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043c9:	80 ff ff 
ffff8000001043cc:	8b 00                	mov    (%rax),%eax
ffff8000001043ce:	31 c2                	xor    %eax,%edx
ffff8000001043d0:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043d7:	80 ff ff 
ffff8000001043da:	89 10                	mov    %edx,(%rax)
  c = charcode[shift & (CTL | SHIFT)][data];
ffff8000001043dc:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff8000001043e3:	80 ff ff 
ffff8000001043e6:	8b 00                	mov    (%rax),%eax
ffff8000001043e8:	83 e0 03             	and    $0x3,%eax
ffff8000001043eb:	89 c2                	mov    %eax,%edx
ffff8000001043ed:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff8000001043f4:	80 ff ff 
ffff8000001043f7:	89 d2                	mov    %edx,%edx
ffff8000001043f9:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff8000001043fd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104400:	48 01 d0             	add    %rdx,%rax
ffff800000104403:	0f b6 00             	movzbl (%rax),%eax
ffff800000104406:	0f b6 c0             	movzbl %al,%eax
ffff800000104409:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(shift & CAPSLOCK){
ffff80000010440c:	48 b8 b8 71 11 00 00 	movabs $0xffff8000001171b8,%rax
ffff800000104413:	80 ff ff 
ffff800000104416:	8b 00                	mov    (%rax),%eax
ffff800000104418:	83 e0 08             	and    $0x8,%eax
ffff80000010441b:	85 c0                	test   %eax,%eax
ffff80000010441d:	74 22                	je     ffff800000104441 <kbdgetc+0x1d4>
    if('a' <= c && c <= 'z')
ffff80000010441f:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff800000104423:	76 0c                	jbe    ffff800000104431 <kbdgetc+0x1c4>
ffff800000104425:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff800000104429:	77 06                	ja     ffff800000104431 <kbdgetc+0x1c4>
      c += 'A' - 'a';
ffff80000010442b:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff80000010442f:	eb 10                	jmp    ffff800000104441 <kbdgetc+0x1d4>
    else if('A' <= c && c <= 'Z')
ffff800000104431:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff800000104435:	76 0a                	jbe    ffff800000104441 <kbdgetc+0x1d4>
ffff800000104437:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff80000010443b:	77 04                	ja     ffff800000104441 <kbdgetc+0x1d4>
      c += 'a' - 'A';
ffff80000010443d:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
  }
  return c;
ffff800000104441:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff800000104444:	c9                   	leave
ffff800000104445:	c3                   	ret

ffff800000104446 <kbdintr>:

void
kbdintr(void)
{
ffff800000104446:	55                   	push   %rbp
ffff800000104447:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(kbdgetc);
ffff80000010444a:	48 b8 6d 42 10 00 00 	movabs $0xffff80000010426d,%rax
ffff800000104451:	80 ff ff 
ffff800000104454:	48 89 c7             	mov    %rax,%rdi
ffff800000104457:	48 b8 6f 0f 10 00 00 	movabs $0xffff800000100f6f,%rax
ffff80000010445e:	80 ff ff 
ffff800000104461:	ff d0                	call   *%rax
}
ffff800000104463:	90                   	nop
ffff800000104464:	5d                   	pop    %rbp
ffff800000104465:	c3                   	ret

ffff800000104466 <inb>:
{
ffff800000104466:	55                   	push   %rbp
ffff800000104467:	48 89 e5             	mov    %rsp,%rbp
ffff80000010446a:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010446e:	89 f8                	mov    %edi,%eax
ffff800000104470:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000104474:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104478:	89 c2                	mov    %eax,%edx
ffff80000010447a:	ec                   	in     (%dx),%al
ffff80000010447b:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff80000010447e:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000104482:	c9                   	leave
ffff800000104483:	c3                   	ret

ffff800000104484 <outb>:
{
ffff800000104484:	55                   	push   %rbp
ffff800000104485:	48 89 e5             	mov    %rsp,%rbp
ffff800000104488:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010448c:	89 fa                	mov    %edi,%edx
ffff80000010448e:	89 f0                	mov    %esi,%eax
ffff800000104490:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000104494:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000104497:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010449b:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010449f:	ee                   	out    %al,(%dx)
}
ffff8000001044a0:	90                   	nop
ffff8000001044a1:	c9                   	leave
ffff8000001044a2:	c3                   	ret

ffff8000001044a3 <readeflags>:
{
ffff8000001044a3:	55                   	push   %rbp
ffff8000001044a4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044a7:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff8000001044ab:	9c                   	pushf
ffff8000001044ac:	58                   	pop    %rax
ffff8000001044ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff8000001044b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001044b5:	c9                   	leave
ffff8000001044b6:	c3                   	ret

ffff8000001044b7 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
ffff8000001044b7:	55                   	push   %rbp
ffff8000001044b8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001044bb:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001044bf:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001044c2:	89 75 f8             	mov    %esi,-0x8(%rbp)
  lapic[index] = value;
ffff8000001044c5:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001044cc:	80 ff ff 
ffff8000001044cf:	48 8b 00             	mov    (%rax),%rax
ffff8000001044d2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001044d5:	48 63 d2             	movslq %edx,%rdx
ffff8000001044d8:	48 c1 e2 02          	shl    $0x2,%rdx
ffff8000001044dc:	48 01 c2             	add    %rax,%rdx
ffff8000001044df:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001044e2:	89 02                	mov    %eax,(%rdx)
  lapic[ID];  // wait for write to finish, by reading
ffff8000001044e4:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001044eb:	80 ff ff 
ffff8000001044ee:	48 8b 00             	mov    (%rax),%rax
ffff8000001044f1:	48 83 c0 20          	add    $0x20,%rax
ffff8000001044f5:	8b 00                	mov    (%rax),%eax
}
ffff8000001044f7:	90                   	nop
ffff8000001044f8:	c9                   	leave
ffff8000001044f9:	c3                   	ret

ffff8000001044fa <lapicinit>:

void
lapicinit(void)
{
ffff8000001044fa:	55                   	push   %rbp
ffff8000001044fb:	48 89 e5             	mov    %rsp,%rbp
  if(!lapic)
ffff8000001044fe:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104505:	80 ff ff 
ffff800000104508:	48 8b 00             	mov    (%rax),%rax
ffff80000010450b:	48 85 c0             	test   %rax,%rax
ffff80000010450e:	0f 84 71 01 00 00    	je     ffff800000104685 <lapicinit+0x18b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
ffff800000104514:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff800000104519:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff80000010451e:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104525:	80 ff ff 
ffff800000104528:	ff d0                	call   *%rax

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
ffff80000010452a:	be 0b 00 00 00       	mov    $0xb,%esi
ffff80000010452f:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff800000104534:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010453b:	80 ff ff 
ffff80000010453e:	ff d0                	call   *%rax
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
ffff800000104540:	be 20 00 02 00       	mov    $0x20020,%esi
ffff800000104545:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff80000010454a:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104551:	80 ff ff 
ffff800000104554:	ff d0                	call   *%rax
  lapicw(TICR, 10000000);
ffff800000104556:	be 80 96 98 00       	mov    $0x989680,%esi
ffff80000010455b:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff800000104560:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104567:	80 ff ff 
ffff80000010456a:	ff d0                	call   *%rax

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
ffff80000010456c:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104571:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff800000104576:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010457d:	80 ff ff 
ffff800000104580:	ff d0                	call   *%rax
  lapicw(LINT1, MASKED);
ffff800000104582:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104587:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff80000010458c:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104593:	80 ff ff 
ffff800000104596:	ff d0                	call   *%rax

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
ffff800000104598:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010459f:	80 ff ff 
ffff8000001045a2:	48 8b 00             	mov    (%rax),%rax
ffff8000001045a5:	48 83 c0 30          	add    $0x30,%rax
ffff8000001045a9:	8b 00                	mov    (%rax),%eax
ffff8000001045ab:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff8000001045b0:	85 c0                	test   %eax,%eax
ffff8000001045b2:	74 16                	je     ffff8000001045ca <lapicinit+0xd0>
    lapicw(PCINT, MASKED);
ffff8000001045b4:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001045b9:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff8000001045be:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001045c5:	80 ff ff 
ffff8000001045c8:	ff d0                	call   *%rax

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
ffff8000001045ca:	be 33 00 00 00       	mov    $0x33,%esi
ffff8000001045cf:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff8000001045d4:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001045db:	80 ff ff 
ffff8000001045de:	ff d0                	call   *%rax

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
ffff8000001045e0:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001045e5:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff8000001045ea:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001045f1:	80 ff ff 
ffff8000001045f4:	ff d0                	call   *%rax
  lapicw(ESR, 0);
ffff8000001045f6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001045fb:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff800000104600:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104607:	80 ff ff 
ffff80000010460a:	ff d0                	call   *%rax

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
ffff80000010460c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104611:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff800000104616:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010461d:	80 ff ff 
ffff800000104620:	ff d0                	call   *%rax

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
ffff800000104622:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104627:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff80000010462c:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104633:	80 ff ff 
ffff800000104636:	ff d0                	call   *%rax
  lapicw(ICRLO, BCAST | INIT | LEVEL);
ffff800000104638:	be 00 85 08 00       	mov    $0x88500,%esi
ffff80000010463d:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104642:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104649:	80 ff ff 
ffff80000010464c:	ff d0                	call   *%rax
  while(lapic[ICRLO] & DELIVS)
ffff80000010464e:	90                   	nop
ffff80000010464f:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104656:	80 ff ff 
ffff800000104659:	48 8b 00             	mov    (%rax),%rax
ffff80000010465c:	48 05 00 03 00 00    	add    $0x300,%rax
ffff800000104662:	8b 00                	mov    (%rax),%eax
ffff800000104664:	25 00 10 00 00       	and    $0x1000,%eax
ffff800000104669:	85 c0                	test   %eax,%eax
ffff80000010466b:	75 e2                	jne    ffff80000010464f <lapicinit+0x155>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
ffff80000010466d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104672:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000104677:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010467e:	80 ff ff 
ffff800000104681:	ff d0                	call   *%rax
ffff800000104683:	eb 01                	jmp    ffff800000104686 <lapicinit+0x18c>
    return;
ffff800000104685:	90                   	nop
}
ffff800000104686:	5d                   	pop    %rbp
ffff800000104687:	c3                   	ret

ffff800000104688 <cpunum>:

int
cpunum(void)
{
ffff800000104688:	55                   	push   %rbp
ffff800000104689:	48 89 e5             	mov    %rsp,%rbp
ffff80000010468c:	48 83 ec 10          	sub    $0x10,%rsp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
ffff800000104690:	48 b8 a3 44 10 00 00 	movabs $0xffff8000001044a3,%rax
ffff800000104697:	80 ff ff 
ffff80000010469a:	ff d0                	call   *%rax
ffff80000010469c:	25 00 02 00 00       	and    $0x200,%eax
ffff8000001046a1:	48 85 c0             	test   %rax,%rax
ffff8000001046a4:	74 47                	je     ffff8000001046ed <cpunum+0x65>
    static int n;
    if(n++ == 0)
ffff8000001046a6:	48 b8 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rax
ffff8000001046ad:	80 ff ff 
ffff8000001046b0:	8b 00                	mov    (%rax),%eax
ffff8000001046b2:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001046b5:	48 b9 c8 71 11 00 00 	movabs $0xffff8000001171c8,%rcx
ffff8000001046bc:	80 ff ff 
ffff8000001046bf:	89 11                	mov    %edx,(%rcx)
ffff8000001046c1:	85 c0                	test   %eax,%eax
ffff8000001046c3:	75 28                	jne    ffff8000001046ed <cpunum+0x65>
      cprintf("cpu called from %x with interrupts enabled\n",
ffff8000001046c5:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff8000001046c9:	48 89 c2             	mov    %rax,%rdx
ffff8000001046cc:	48 b8 b8 c1 10 00 00 	movabs $0xffff80000010c1b8,%rax
ffff8000001046d3:	80 ff ff 
ffff8000001046d6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001046d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001046dc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001046e1:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001046e8:	80 ff ff 
ffff8000001046eb:	ff d2                	call   *%rdx
        __builtin_return_address(0));
  }

  if (!lapic)
ffff8000001046ed:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff8000001046f4:	80 ff ff 
ffff8000001046f7:	48 8b 00             	mov    (%rax),%rax
ffff8000001046fa:	48 85 c0             	test   %rax,%rax
ffff8000001046fd:	75 0a                	jne    ffff800000104709 <cpunum+0x81>
    return 0;
ffff8000001046ff:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104704:	e9 85 00 00 00       	jmp    ffff80000010478e <cpunum+0x106>

  apicid = lapic[ID] >> 24;
ffff800000104709:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000104710:	80 ff ff 
ffff800000104713:	48 8b 00             	mov    (%rax),%rax
ffff800000104716:	48 83 c0 20          	add    $0x20,%rax
ffff80000010471a:	8b 00                	mov    (%rax),%eax
ffff80000010471c:	c1 e8 18             	shr    $0x18,%eax
ffff80000010471f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < ncpu; ++i) {
ffff800000104722:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104729:	eb 39                	jmp    ffff800000104764 <cpunum+0xdc>
    if (cpus[i].apicid == apicid)
ffff80000010472b:	48 b9 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rcx
ffff800000104732:	80 ff ff 
ffff800000104735:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104738:	48 63 d0             	movslq %eax,%rdx
ffff80000010473b:	48 89 d0             	mov    %rdx,%rax
ffff80000010473e:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000104742:	48 01 d0             	add    %rdx,%rax
ffff800000104745:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000104749:	48 01 c8             	add    %rcx,%rax
ffff80000010474c:	48 83 c0 01          	add    $0x1,%rax
ffff800000104750:	0f b6 00             	movzbl (%rax),%eax
ffff800000104753:	0f b6 c0             	movzbl %al,%eax
ffff800000104756:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff800000104759:	75 05                	jne    ffff800000104760 <cpunum+0xd8>
      return i;
ffff80000010475b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010475e:	eb 2e                	jmp    ffff80000010478e <cpunum+0x106>
  for (i = 0; i < ncpu; ++i) {
ffff800000104760:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104764:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff80000010476b:	80 ff ff 
ffff80000010476e:	8b 00                	mov    (%rax),%eax
ffff800000104770:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104773:	7c b6                	jl     ffff80000010472b <cpunum+0xa3>
  }
  panic("unknown apicid\n");
ffff800000104775:	48 b8 e4 c1 10 00 00 	movabs $0xffff80000010c1e4,%rax
ffff80000010477c:	80 ff ff 
ffff80000010477f:	48 89 c7             	mov    %rax,%rdi
ffff800000104782:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000104789:	80 ff ff 
ffff80000010478c:	ff d0                	call   *%rax
}
ffff80000010478e:	c9                   	leave
ffff80000010478f:	c3                   	ret

ffff800000104790 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
ffff800000104790:	55                   	push   %rbp
ffff800000104791:	48 89 e5             	mov    %rsp,%rbp
  if(lapic)
ffff800000104794:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff80000010479b:	80 ff ff 
ffff80000010479e:	48 8b 00             	mov    (%rax),%rax
ffff8000001047a1:	48 85 c0             	test   %rax,%rax
ffff8000001047a4:	74 16                	je     ffff8000001047bc <lapiceoi+0x2c>
    lapicw(EOI, 0);
ffff8000001047a6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047ab:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001047b0:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001047b7:	80 ff ff 
ffff8000001047ba:	ff d0                	call   *%rax
}
ffff8000001047bc:	90                   	nop
ffff8000001047bd:	5d                   	pop    %rbp
ffff8000001047be:	c3                   	ret

ffff8000001047bf <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
ffff8000001047bf:	55                   	push   %rbp
ffff8000001047c0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001047c3:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001047c7:	89 7d fc             	mov    %edi,-0x4(%rbp)
}
ffff8000001047ca:	90                   	nop
ffff8000001047cb:	c9                   	leave
ffff8000001047cc:	c3                   	ret

ffff8000001047cd <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
ffff8000001047cd:	55                   	push   %rbp
ffff8000001047ce:	48 89 e5             	mov    %rsp,%rbp
ffff8000001047d1:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001047d5:	89 f8                	mov    %edi,%eax
ffff8000001047d7:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff8000001047da:	88 45 ec             	mov    %al,-0x14(%rbp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
ffff8000001047dd:	be 0f 00 00 00       	mov    $0xf,%esi
ffff8000001047e2:	bf 70 00 00 00       	mov    $0x70,%edi
ffff8000001047e7:	48 b8 84 44 10 00 00 	movabs $0xffff800000104484,%rax
ffff8000001047ee:	80 ff ff 
ffff8000001047f1:	ff d0                	call   *%rax
  outb(CMOS_PORT+1, 0x0A);
ffff8000001047f3:	be 0a 00 00 00       	mov    $0xa,%esi
ffff8000001047f8:	bf 71 00 00 00       	mov    $0x71,%edi
ffff8000001047fd:	48 b8 84 44 10 00 00 	movabs $0xffff800000104484,%rax
ffff800000104804:	80 ff ff 
ffff800000104807:	ff d0                	call   *%rax
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
ffff800000104809:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff800000104810:	80 ff ff 
ffff800000104813:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  wrv[0] = 0;
ffff800000104817:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010481b:	66 c7 00 00 00       	movw   $0x0,(%rax)
  wrv[1] = addr >> 4;
ffff800000104820:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104823:	c1 e8 04             	shr    $0x4,%eax
ffff800000104826:	89 c2                	mov    %eax,%edx
ffff800000104828:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010482c:	48 83 c0 02          	add    $0x2,%rax
ffff800000104830:	66 89 10             	mov    %dx,(%rax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
ffff800000104833:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104837:	c1 e0 18             	shl    $0x18,%eax
ffff80000010483a:	89 c6                	mov    %eax,%esi
ffff80000010483c:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104841:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104848:	80 ff ff 
ffff80000010484b:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
ffff80000010484d:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff800000104852:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104857:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff80000010485e:	80 ff ff 
ffff800000104861:	ff d0                	call   *%rax
  microdelay(200);
ffff800000104863:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104868:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff80000010486f:	80 ff ff 
ffff800000104872:	ff d0                	call   *%rax
  lapicw(ICRLO, INIT | LEVEL);
ffff800000104874:	be 00 85 00 00       	mov    $0x8500,%esi
ffff800000104879:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff80000010487e:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff800000104885:	80 ff ff 
ffff800000104888:	ff d0                	call   *%rax
  microdelay(100);    // should be 10ms, but too slow in Bochs!
ffff80000010488a:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010488f:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff800000104896:	80 ff ff 
ffff800000104899:	ff d0                	call   *%rax
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
ffff80000010489b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001048a2:	eb 4b                	jmp    ffff8000001048ef <lapicstartap+0x122>
    lapicw(ICRHI, apicid<<24);
ffff8000001048a4:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff8000001048a8:	c1 e0 18             	shl    $0x18,%eax
ffff8000001048ab:	89 c6                	mov    %eax,%esi
ffff8000001048ad:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff8000001048b2:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001048b9:	80 ff ff 
ffff8000001048bc:	ff d0                	call   *%rax
    lapicw(ICRLO, STARTUP | (addr>>12));
ffff8000001048be:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001048c1:	c1 e8 0c             	shr    $0xc,%eax
ffff8000001048c4:	80 cc 06             	or     $0x6,%ah
ffff8000001048c7:	89 c6                	mov    %eax,%esi
ffff8000001048c9:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff8000001048ce:	48 b8 b7 44 10 00 00 	movabs $0xffff8000001044b7,%rax
ffff8000001048d5:	80 ff ff 
ffff8000001048d8:	ff d0                	call   *%rax
    microdelay(200);
ffff8000001048da:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff8000001048df:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff8000001048e6:	80 ff ff 
ffff8000001048e9:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
ffff8000001048eb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001048ef:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff8000001048f3:	7e af                	jle    ffff8000001048a4 <lapicstartap+0xd7>
  }
}
ffff8000001048f5:	90                   	nop
ffff8000001048f6:	90                   	nop
ffff8000001048f7:	c9                   	leave
ffff8000001048f8:	c3                   	ret

ffff8000001048f9 <cmos_read>:
#define DAY     0x07
#define MONTH   0x08
#define YEAR    0x09

static uint cmos_read(uint reg)
{
ffff8000001048f9:	55                   	push   %rbp
ffff8000001048fa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001048fd:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104901:	89 7d fc             	mov    %edi,-0x4(%rbp)
  outb(CMOS_PORT,  reg);
ffff800000104904:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104907:	0f b6 c0             	movzbl %al,%eax
ffff80000010490a:	89 c6                	mov    %eax,%esi
ffff80000010490c:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104911:	48 b8 84 44 10 00 00 	movabs $0xffff800000104484,%rax
ffff800000104918:	80 ff ff 
ffff80000010491b:	ff d0                	call   *%rax
  microdelay(200);
ffff80000010491d:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104922:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff800000104929:	80 ff ff 
ffff80000010492c:	ff d0                	call   *%rax

  return inb(CMOS_RETURN);
ffff80000010492e:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104933:	48 b8 66 44 10 00 00 	movabs $0xffff800000104466,%rax
ffff80000010493a:	80 ff ff 
ffff80000010493d:	ff d0                	call   *%rax
ffff80000010493f:	0f b6 c0             	movzbl %al,%eax
}
ffff800000104942:	c9                   	leave
ffff800000104943:	c3                   	ret

ffff800000104944 <fill_rtcdate>:

static void fill_rtcdate(struct rtcdate *r)
{
ffff800000104944:	55                   	push   %rbp
ffff800000104945:	48 89 e5             	mov    %rsp,%rbp
ffff800000104948:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010494c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  r->second = cmos_read(SECS);
ffff800000104950:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104955:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff80000010495c:	80 ff ff 
ffff80000010495f:	ff d0                	call   *%rax
ffff800000104961:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104965:	89 02                	mov    %eax,(%rdx)
  r->minute = cmos_read(MINS);
ffff800000104967:	bf 02 00 00 00       	mov    $0x2,%edi
ffff80000010496c:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff800000104973:	80 ff ff 
ffff800000104976:	ff d0                	call   *%rax
ffff800000104978:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010497c:	89 42 04             	mov    %eax,0x4(%rdx)
  r->hour   = cmos_read(HOURS);
ffff80000010497f:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104984:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff80000010498b:	80 ff ff 
ffff80000010498e:	ff d0                	call   *%rax
ffff800000104990:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104994:	89 42 08             	mov    %eax,0x8(%rdx)
  r->day    = cmos_read(DAY);
ffff800000104997:	bf 07 00 00 00       	mov    $0x7,%edi
ffff80000010499c:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049a3:	80 ff ff 
ffff8000001049a6:	ff d0                	call   *%rax
ffff8000001049a8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049ac:	89 42 0c             	mov    %eax,0xc(%rdx)
  r->month  = cmos_read(MONTH);
ffff8000001049af:	bf 08 00 00 00       	mov    $0x8,%edi
ffff8000001049b4:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049bb:	80 ff ff 
ffff8000001049be:	ff d0                	call   *%rax
ffff8000001049c0:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049c4:	89 42 10             	mov    %eax,0x10(%rdx)
  r->year   = cmos_read(YEAR);
ffff8000001049c7:	bf 09 00 00 00       	mov    $0x9,%edi
ffff8000001049cc:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049d3:	80 ff ff 
ffff8000001049d6:	ff d0                	call   *%rax
ffff8000001049d8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001049dc:	89 42 14             	mov    %eax,0x14(%rdx)
}
ffff8000001049df:	90                   	nop
ffff8000001049e0:	c9                   	leave
ffff8000001049e1:	c3                   	ret

ffff8000001049e2 <cmostime>:
//PAGEBREAK!

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
ffff8000001049e2:	55                   	push   %rbp
ffff8000001049e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049e6:	48 83 ec 50          	sub    $0x50,%rsp
ffff8000001049ea:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
ffff8000001049ee:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff8000001049f3:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff8000001049fa:	80 ff ff 
ffff8000001049fd:	ff d0                	call   *%rax
ffff8000001049ff:	89 45 fc             	mov    %eax,-0x4(%rbp)

  bcd = (sb & (1 << 2)) == 0;
ffff800000104a02:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104a05:	83 e0 04             	and    $0x4,%eax
ffff800000104a08:	c1 e8 02             	shr    $0x2,%eax
ffff800000104a0b:	83 e0 01             	and    $0x1,%eax
ffff800000104a0e:	83 f0 01             	xor    $0x1,%eax
ffff800000104a11:	0f b6 c0             	movzbl %al,%eax
ffff800000104a14:	89 45 f8             	mov    %eax,-0x8(%rbp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
ffff800000104a17:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104a1b:	48 89 c7             	mov    %rax,%rdi
ffff800000104a1e:	48 b8 44 49 10 00 00 	movabs $0xffff800000104944,%rax
ffff800000104a25:	80 ff ff 
ffff800000104a28:	ff d0                	call   *%rax
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
ffff800000104a2a:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104a2f:	48 b8 f9 48 10 00 00 	movabs $0xffff8000001048f9,%rax
ffff800000104a36:	80 ff ff 
ffff800000104a39:	ff d0                	call   *%rax
ffff800000104a3b:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104a40:	85 c0                	test   %eax,%eax
ffff800000104a42:	75 38                	jne    ffff800000104a7c <cmostime+0x9a>
        continue;
    fill_rtcdate(&t2);
ffff800000104a44:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104a48:	48 89 c7             	mov    %rax,%rdi
ffff800000104a4b:	48 b8 44 49 10 00 00 	movabs $0xffff800000104944,%rax
ffff800000104a52:	80 ff ff 
ffff800000104a55:	ff d0                	call   *%rax
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
ffff800000104a57:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104a5b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104a5f:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104a64:	48 89 ce             	mov    %rcx,%rsi
ffff800000104a67:	48 89 c7             	mov    %rax,%rdi
ffff800000104a6a:	48 b8 89 78 10 00 00 	movabs $0xffff800000107889,%rax
ffff800000104a71:	80 ff ff 
ffff800000104a74:	ff d0                	call   *%rax
ffff800000104a76:	85 c0                	test   %eax,%eax
ffff800000104a78:	74 05                	je     ffff800000104a7f <cmostime+0x9d>
ffff800000104a7a:	eb 9b                	jmp    ffff800000104a17 <cmostime+0x35>
        continue;
ffff800000104a7c:	90                   	nop
    fill_rtcdate(&t1);
ffff800000104a7d:	eb 98                	jmp    ffff800000104a17 <cmostime+0x35>
      break;
ffff800000104a7f:	90                   	nop
  }

  // convert
  if(bcd) {
ffff800000104a80:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104a84:	0f 84 b4 00 00 00    	je     ffff800000104b3e <cmostime+0x15c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
ffff800000104a8a:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104a8d:	c1 e8 04             	shr    $0x4,%eax
ffff800000104a90:	89 c2                	mov    %eax,%edx
ffff800000104a92:	89 d0                	mov    %edx,%eax
ffff800000104a94:	c1 e0 02             	shl    $0x2,%eax
ffff800000104a97:	01 d0                	add    %edx,%eax
ffff800000104a99:	01 c0                	add    %eax,%eax
ffff800000104a9b:	89 c2                	mov    %eax,%edx
ffff800000104a9d:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104aa0:	83 e0 0f             	and    $0xf,%eax
ffff800000104aa3:	01 d0                	add    %edx,%eax
ffff800000104aa5:	89 45 e0             	mov    %eax,-0x20(%rbp)
    CONV(minute);
ffff800000104aa8:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104aab:	c1 e8 04             	shr    $0x4,%eax
ffff800000104aae:	89 c2                	mov    %eax,%edx
ffff800000104ab0:	89 d0                	mov    %edx,%eax
ffff800000104ab2:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ab5:	01 d0                	add    %edx,%eax
ffff800000104ab7:	01 c0                	add    %eax,%eax
ffff800000104ab9:	89 c2                	mov    %eax,%edx
ffff800000104abb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104abe:	83 e0 0f             	and    $0xf,%eax
ffff800000104ac1:	01 d0                	add    %edx,%eax
ffff800000104ac3:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    CONV(hour  );
ffff800000104ac6:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104ac9:	c1 e8 04             	shr    $0x4,%eax
ffff800000104acc:	89 c2                	mov    %eax,%edx
ffff800000104ace:	89 d0                	mov    %edx,%eax
ffff800000104ad0:	c1 e0 02             	shl    $0x2,%eax
ffff800000104ad3:	01 d0                	add    %edx,%eax
ffff800000104ad5:	01 c0                	add    %eax,%eax
ffff800000104ad7:	89 c2                	mov    %eax,%edx
ffff800000104ad9:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104adc:	83 e0 0f             	and    $0xf,%eax
ffff800000104adf:	01 d0                	add    %edx,%eax
ffff800000104ae1:	89 45 e8             	mov    %eax,-0x18(%rbp)
    CONV(day   );
ffff800000104ae4:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104ae7:	c1 e8 04             	shr    $0x4,%eax
ffff800000104aea:	89 c2                	mov    %eax,%edx
ffff800000104aec:	89 d0                	mov    %edx,%eax
ffff800000104aee:	c1 e0 02             	shl    $0x2,%eax
ffff800000104af1:	01 d0                	add    %edx,%eax
ffff800000104af3:	01 c0                	add    %eax,%eax
ffff800000104af5:	89 c2                	mov    %eax,%edx
ffff800000104af7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104afa:	83 e0 0f             	and    $0xf,%eax
ffff800000104afd:	01 d0                	add    %edx,%eax
ffff800000104aff:	89 45 ec             	mov    %eax,-0x14(%rbp)
    CONV(month );
ffff800000104b02:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104b05:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b08:	89 c2                	mov    %eax,%edx
ffff800000104b0a:	89 d0                	mov    %edx,%eax
ffff800000104b0c:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b0f:	01 d0                	add    %edx,%eax
ffff800000104b11:	01 c0                	add    %eax,%eax
ffff800000104b13:	89 c2                	mov    %eax,%edx
ffff800000104b15:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104b18:	83 e0 0f             	and    $0xf,%eax
ffff800000104b1b:	01 d0                	add    %edx,%eax
ffff800000104b1d:	89 45 f0             	mov    %eax,-0x10(%rbp)
    CONV(year  );
ffff800000104b20:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104b23:	c1 e8 04             	shr    $0x4,%eax
ffff800000104b26:	89 c2                	mov    %eax,%edx
ffff800000104b28:	89 d0                	mov    %edx,%eax
ffff800000104b2a:	c1 e0 02             	shl    $0x2,%eax
ffff800000104b2d:	01 d0                	add    %edx,%eax
ffff800000104b2f:	01 c0                	add    %eax,%eax
ffff800000104b31:	89 c2                	mov    %eax,%edx
ffff800000104b33:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104b36:	83 e0 0f             	and    $0xf,%eax
ffff800000104b39:	01 d0                	add    %edx,%eax
ffff800000104b3b:	89 45 f4             	mov    %eax,-0xc(%rbp)
#undef     CONV
  }

  *r = t1;
ffff800000104b3e:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104b42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104b46:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104b4a:	48 89 01             	mov    %rax,(%rcx)
ffff800000104b4d:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104b51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104b55:	48 89 41 10          	mov    %rax,0x10(%rcx)
  r->year += 2000;
ffff800000104b59:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104b5d:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104b60:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104b66:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104b6a:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff800000104b6d:	90                   	nop
ffff800000104b6e:	c9                   	leave
ffff800000104b6f:	c3                   	ret

ffff800000104b70 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
ffff800000104b70:	55                   	push   %rbp
ffff800000104b71:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b74:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104b78:	89 7d dc             	mov    %edi,-0x24(%rbp)
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
ffff800000104b7b:	48 ba f4 c1 10 00 00 	movabs $0xffff80000010c1f4,%rdx
ffff800000104b82:	80 ff ff 
ffff800000104b85:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104b8c:	80 ff ff 
ffff800000104b8f:	48 89 d6             	mov    %rdx,%rsi
ffff800000104b92:	48 89 c7             	mov    %rax,%rdi
ffff800000104b95:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
ffff800000104b9c:	80 ff ff 
ffff800000104b9f:	ff d0                	call   *%rax
  readsb(dev, &sb);
ffff800000104ba1:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104ba5:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104ba8:	48 89 d6             	mov    %rdx,%rsi
ffff800000104bab:	89 c7                	mov    %eax,%edi
ffff800000104bad:	48 b8 91 20 10 00 00 	movabs $0xffff800000102091,%rax
ffff800000104bb4:	80 ff ff 
ffff800000104bb7:	ff d0                	call   *%rax
  log.start = sb.logstart;
ffff800000104bb9:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104bbc:	89 c2                	mov    %eax,%edx
ffff800000104bbe:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104bc5:	80 ff ff 
ffff800000104bc8:	89 50 68             	mov    %edx,0x68(%rax)
  log.size = sb.nlog;
ffff800000104bcb:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104bce:	89 c2                	mov    %eax,%edx
ffff800000104bd0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104bd7:	80 ff ff 
ffff800000104bda:	89 50 6c             	mov    %edx,0x6c(%rax)
  log.dev = dev;
ffff800000104bdd:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104be4:	80 ff ff 
ffff800000104be7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104bea:	89 42 78             	mov    %eax,0x78(%rdx)
  recover_from_log();
ffff800000104bed:	48 b8 81 4e 10 00 00 	movabs $0xffff800000104e81,%rax
ffff800000104bf4:	80 ff ff 
ffff800000104bf7:	ff d0                	call   *%rax
}
ffff800000104bf9:	90                   	nop
ffff800000104bfa:	c9                   	leave
ffff800000104bfb:	c3                   	ret

ffff800000104bfc <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
ffff800000104bfc:	55                   	push   %rbp
ffff800000104bfd:	48 89 e5             	mov    %rsp,%rbp
ffff800000104c00:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104c04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104c0b:	e9 dc 00 00 00       	jmp    ffff800000104cec <install_trans+0xf0>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
ffff800000104c10:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c17:	80 ff ff 
ffff800000104c1a:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104c1d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104c20:	01 d0                	add    %edx,%eax
ffff800000104c22:	83 c0 01             	add    $0x1,%eax
ffff800000104c25:	89 c2                	mov    %eax,%edx
ffff800000104c27:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c2e:	80 ff ff 
ffff800000104c31:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104c34:	89 d6                	mov    %edx,%esi
ffff800000104c36:	89 c7                	mov    %eax,%edi
ffff800000104c38:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104c3f:	80 ff ff 
ffff800000104c42:	ff d0                	call   *%rax
ffff800000104c44:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
ffff800000104c48:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c4f:	80 ff ff 
ffff800000104c52:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104c55:	48 63 d2             	movslq %edx,%rdx
ffff800000104c58:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104c5c:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104c60:	89 c2                	mov    %eax,%edx
ffff800000104c62:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104c69:	80 ff ff 
ffff800000104c6c:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104c6f:	89 d6                	mov    %edx,%esi
ffff800000104c71:	89 c7                	mov    %eax,%edi
ffff800000104c73:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104c7a:	80 ff ff 
ffff800000104c7d:	ff d0                	call   *%rax
ffff800000104c7f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffff800000104c83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104c87:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104c8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104c92:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104c98:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104c9d:	48 89 ce             	mov    %rcx,%rsi
ffff800000104ca0:	48 89 c7             	mov    %rax,%rdi
ffff800000104ca3:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff800000104caa:	80 ff ff 
ffff800000104cad:	ff d0                	call   *%rax
    bwrite(dbuf);  // write dst to disk
ffff800000104caf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104cb3:	48 89 c7             	mov    %rax,%rdi
ffff800000104cb6:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104cbd:	80 ff ff 
ffff800000104cc0:	ff d0                	call   *%rax
    brelse(lbuf);
ffff800000104cc2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104cc6:	48 89 c7             	mov    %rax,%rdi
ffff800000104cc9:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104cd0:	80 ff ff 
ffff800000104cd3:	ff d0                	call   *%rax
    brelse(dbuf);
ffff800000104cd5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104cd9:	48 89 c7             	mov    %rax,%rdi
ffff800000104cdc:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ce3:	80 ff ff 
ffff800000104ce6:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff800000104ce8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104cec:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104cf3:	80 ff ff 
ffff800000104cf6:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104cf9:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104cfc:	0f 8c 0e ff ff ff    	jl     ffff800000104c10 <install_trans+0x14>
  }
}
ffff800000104d02:	90                   	nop
ffff800000104d03:	90                   	nop
ffff800000104d04:	c9                   	leave
ffff800000104d05:	c3                   	ret

ffff800000104d06 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
ffff800000104d06:	55                   	push   %rbp
ffff800000104d07:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d0a:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104d0e:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d15:	80 ff ff 
ffff800000104d18:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104d1b:	89 c2                	mov    %eax,%edx
ffff800000104d1d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d24:	80 ff ff 
ffff800000104d27:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104d2a:	89 d6                	mov    %edx,%esi
ffff800000104d2c:	89 c7                	mov    %eax,%edi
ffff800000104d2e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104d35:	80 ff ff 
ffff800000104d38:	ff d0                	call   *%rax
ffff800000104d3a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *lh = (struct logheader *) (buf->data);
ffff800000104d3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d42:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104d48:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  log.lh.n = lh->n;
ffff800000104d4c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104d50:	8b 00                	mov    (%rax),%eax
ffff800000104d52:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104d59:	80 ff ff 
ffff800000104d5c:	89 42 7c             	mov    %eax,0x7c(%rdx)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104d5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104d66:	eb 2a                	jmp    ffff800000104d92 <read_head+0x8c>
    log.lh.block[i] = lh->block[i];
ffff800000104d68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104d6c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104d6f:	48 63 d2             	movslq %edx,%rdx
ffff800000104d72:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104d76:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104d7d:	80 ff ff 
ffff800000104d80:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104d83:	48 63 c9             	movslq %ecx,%rcx
ffff800000104d86:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104d8a:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104d8e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104d92:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104d99:	80 ff ff 
ffff800000104d9c:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104d9f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104da2:	7c c4                	jl     ffff800000104d68 <read_head+0x62>
  }
  brelse(buf);
ffff800000104da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104da8:	48 89 c7             	mov    %rax,%rdi
ffff800000104dab:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104db2:	80 ff ff 
ffff800000104db5:	ff d0                	call   *%rax
}
ffff800000104db7:	90                   	nop
ffff800000104db8:	c9                   	leave
ffff800000104db9:	c3                   	ret

ffff800000104dba <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
ffff800000104dba:	55                   	push   %rbp
ffff800000104dbb:	48 89 e5             	mov    %rsp,%rbp
ffff800000104dbe:	48 83 ec 20          	sub    $0x20,%rsp
  struct buf *buf = bread(log.dev, log.start);
ffff800000104dc2:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104dc9:	80 ff ff 
ffff800000104dcc:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104dcf:	89 c2                	mov    %eax,%edx
ffff800000104dd1:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104dd8:	80 ff ff 
ffff800000104ddb:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104dde:	89 d6                	mov    %edx,%esi
ffff800000104de0:	89 c7                	mov    %eax,%edi
ffff800000104de2:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104de9:	80 ff ff 
ffff800000104dec:	ff d0                	call   *%rax
ffff800000104dee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  struct logheader *hb = (struct logheader *) (buf->data);
ffff800000104df2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104df6:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104dfc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  int i;
  hb->n = log.lh.n;
ffff800000104e00:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e07:	80 ff ff 
ffff800000104e0a:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000104e0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e11:	89 10                	mov    %edx,(%rax)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104e13:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104e1a:	eb 2a                	jmp    ffff800000104e46 <write_head+0x8c>
    hb->block[i] = log.lh.block[i];
ffff800000104e1c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e23:	80 ff ff 
ffff800000104e26:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e29:	48 63 d2             	movslq %edx,%rdx
ffff800000104e2c:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e30:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff800000104e34:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e38:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e3b:	48 63 d2             	movslq %edx,%rdx
ffff800000104e3e:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
  for (i = 0; i < log.lh.n; i++) {
ffff800000104e42:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104e46:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104e4d:	80 ff ff 
ffff800000104e50:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104e53:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104e56:	7c c4                	jl     ffff800000104e1c <write_head+0x62>
  }
  bwrite(buf);
ffff800000104e58:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e5c:	48 89 c7             	mov    %rax,%rdi
ffff800000104e5f:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104e66:	80 ff ff 
ffff800000104e69:	ff d0                	call   *%rax
  brelse(buf);
ffff800000104e6b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e6f:	48 89 c7             	mov    %rax,%rdi
ffff800000104e72:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104e79:	80 ff ff 
ffff800000104e7c:	ff d0                	call   *%rax
}
ffff800000104e7e:	90                   	nop
ffff800000104e7f:	c9                   	leave
ffff800000104e80:	c3                   	ret

ffff800000104e81 <recover_from_log>:

static void
recover_from_log(void)
{
ffff800000104e81:	55                   	push   %rbp
ffff800000104e82:	48 89 e5             	mov    %rsp,%rbp
  read_head();
ffff800000104e85:	48 b8 06 4d 10 00 00 	movabs $0xffff800000104d06,%rax
ffff800000104e8c:	80 ff ff 
ffff800000104e8f:	ff d0                	call   *%rax
  install_trans(); // if committed, copy from log to disk
ffff800000104e91:	48 b8 fc 4b 10 00 00 	movabs $0xffff800000104bfc,%rax
ffff800000104e98:	80 ff ff 
ffff800000104e9b:	ff d0                	call   *%rax
  log.lh.n = 0;
ffff800000104e9d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ea4:	80 ff ff 
ffff800000104ea7:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
  write_head(); // clear the log
ffff800000104eae:	48 b8 ba 4d 10 00 00 	movabs $0xffff800000104dba,%rax
ffff800000104eb5:	80 ff ff 
ffff800000104eb8:	ff d0                	call   *%rax
}
ffff800000104eba:	90                   	nop
ffff800000104ebb:	5d                   	pop    %rbp
ffff800000104ebc:	c3                   	ret

ffff800000104ebd <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
ffff800000104ebd:	55                   	push   %rbp
ffff800000104ebe:	48 89 e5             	mov    %rsp,%rbp
  acquire(&log.lock);
ffff800000104ec1:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ec8:	80 ff ff 
ffff800000104ecb:	48 89 c7             	mov    %rax,%rdi
ffff800000104ece:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000104ed5:	80 ff ff 
ffff800000104ed8:	ff d0                	call   *%rax
  while(1){
    if(log.committing){
ffff800000104eda:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ee1:	80 ff ff 
ffff800000104ee4:	8b 40 74             	mov    0x74(%rax),%eax
ffff800000104ee7:	85 c0                	test   %eax,%eax
ffff800000104ee9:	74 28                	je     ffff800000104f13 <begin_op+0x56>
      sleep(&log, &log.lock);
ffff800000104eeb:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104ef2:	80 ff ff 
ffff800000104ef5:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104efc:	80 ff ff 
ffff800000104eff:	48 89 d6             	mov    %rdx,%rsi
ffff800000104f02:	48 89 c7             	mov    %rax,%rdi
ffff800000104f05:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff800000104f0c:	80 ff ff 
ffff800000104f0f:	ff d0                	call   *%rax
ffff800000104f11:	eb c7                	jmp    ffff800000104eda <begin_op+0x1d>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
ffff800000104f13:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f1a:	80 ff ff 
ffff800000104f1d:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff800000104f20:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f27:	80 ff ff 
ffff800000104f2a:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104f2d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104f30:	89 d0                	mov    %edx,%eax
ffff800000104f32:	c1 e0 02             	shl    $0x2,%eax
ffff800000104f35:	01 d0                	add    %edx,%eax
ffff800000104f37:	01 c0                	add    %eax,%eax
ffff800000104f39:	01 c8                	add    %ecx,%eax
ffff800000104f3b:	83 f8 1e             	cmp    $0x1e,%eax
ffff800000104f3e:	7e 2b                	jle    ffff800000104f6b <begin_op+0xae>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
ffff800000104f40:	48 ba e0 71 11 00 00 	movabs $0xffff8000001171e0,%rdx
ffff800000104f47:	80 ff ff 
ffff800000104f4a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f51:	80 ff ff 
ffff800000104f54:	48 89 d6             	mov    %rdx,%rsi
ffff800000104f57:	48 89 c7             	mov    %rax,%rdi
ffff800000104f5a:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff800000104f61:	80 ff ff 
ffff800000104f64:	ff d0                	call   *%rax
ffff800000104f66:	e9 6f ff ff ff       	jmp    ffff800000104eda <begin_op+0x1d>
    } else {
      log.outstanding += 1;
ffff800000104f6b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f72:	80 ff ff 
ffff800000104f75:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104f78:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000104f7b:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f82:	80 ff ff 
ffff800000104f85:	89 50 70             	mov    %edx,0x70(%rax)
      release(&log.lock);
ffff800000104f88:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104f8f:	80 ff ff 
ffff800000104f92:	48 89 c7             	mov    %rax,%rdi
ffff800000104f95:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000104f9c:	80 ff ff 
ffff800000104f9f:	ff d0                	call   *%rax
      break;
ffff800000104fa1:	90                   	nop
    }
  }
}
ffff800000104fa2:	90                   	nop
ffff800000104fa3:	5d                   	pop    %rbp
ffff800000104fa4:	c3                   	ret

ffff800000104fa5 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
ffff800000104fa5:	55                   	push   %rbp
ffff800000104fa6:	48 89 e5             	mov    %rsp,%rbp
ffff800000104fa9:	48 83 ec 10          	sub    $0x10,%rsp
  int do_commit = 0;
ffff800000104fad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)

  acquire(&log.lock);
ffff800000104fb4:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fbb:	80 ff ff 
ffff800000104fbe:	48 89 c7             	mov    %rax,%rdi
ffff800000104fc1:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000104fc8:	80 ff ff 
ffff800000104fcb:	ff d0                	call   *%rax
  log.outstanding -= 1;
ffff800000104fcd:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fd4:	80 ff ff 
ffff800000104fd7:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000104fda:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000104fdd:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104fe4:	80 ff ff 
ffff800000104fe7:	89 50 70             	mov    %edx,0x70(%rax)
  if(log.committing)
ffff800000104fea:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000104ff1:	80 ff ff 
ffff800000104ff4:	8b 40 74             	mov    0x74(%rax),%eax
ffff800000104ff7:	85 c0                	test   %eax,%eax
ffff800000104ff9:	74 19                	je     ffff800000105014 <end_op+0x6f>
    panic("log.committing");
ffff800000104ffb:	48 b8 f8 c1 10 00 00 	movabs $0xffff80000010c1f8,%rax
ffff800000105002:	80 ff ff 
ffff800000105005:	48 89 c7             	mov    %rax,%rdi
ffff800000105008:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010500f:	80 ff ff 
ffff800000105012:	ff d0                	call   *%rax
  if(log.outstanding == 0){
ffff800000105014:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010501b:	80 ff ff 
ffff80000010501e:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105021:	85 c0                	test   %eax,%eax
ffff800000105023:	75 1a                	jne    ffff80000010503f <end_op+0x9a>
    do_commit = 1;
ffff800000105025:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    log.committing = 1;
ffff80000010502c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105033:	80 ff ff 
ffff800000105036:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff80000010503d:	eb 19                	jmp    ffff800000105058 <end_op+0xb3>
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
ffff80000010503f:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105046:	80 ff ff 
ffff800000105049:	48 89 c7             	mov    %rax,%rdi
ffff80000010504c:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000105053:	80 ff ff 
ffff800000105056:	ff d0                	call   *%rax
  }
  release(&log.lock);
ffff800000105058:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010505f:	80 ff ff 
ffff800000105062:	48 89 c7             	mov    %rax,%rdi
ffff800000105065:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010506c:	80 ff ff 
ffff80000010506f:	ff d0                	call   *%rax

  if(do_commit){
ffff800000105071:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000105075:	74 68                	je     ffff8000001050df <end_op+0x13a>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
ffff800000105077:	48 b8 ec 51 10 00 00 	movabs $0xffff8000001051ec,%rax
ffff80000010507e:	80 ff ff 
ffff800000105081:	ff d0                	call   *%rax
    acquire(&log.lock);
ffff800000105083:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010508a:	80 ff ff 
ffff80000010508d:	48 89 c7             	mov    %rax,%rdi
ffff800000105090:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000105097:	80 ff ff 
ffff80000010509a:	ff d0                	call   *%rax
    log.committing = 0;
ffff80000010509c:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050a3:	80 ff ff 
ffff8000001050a6:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
    wakeup(&log);
ffff8000001050ad:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050b4:	80 ff ff 
ffff8000001050b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001050ba:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff8000001050c1:	80 ff ff 
ffff8000001050c4:	ff d0                	call   *%rax
    release(&log.lock);
ffff8000001050c6:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050cd:	80 ff ff 
ffff8000001050d0:	48 89 c7             	mov    %rax,%rdi
ffff8000001050d3:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff8000001050da:	80 ff ff 
ffff8000001050dd:	ff d0                	call   *%rax
  }
}
ffff8000001050df:	90                   	nop
ffff8000001050e0:	c9                   	leave
ffff8000001050e1:	c3                   	ret

ffff8000001050e2 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
ffff8000001050e2:	55                   	push   %rbp
ffff8000001050e3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001050e6:	48 83 ec 20          	sub    $0x20,%rsp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001050ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001050f1:	e9 dc 00 00 00       	jmp    ffff8000001051d2 <write_log+0xf0>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
ffff8000001050f6:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001050fd:	80 ff ff 
ffff800000105100:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000105103:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105106:	01 d0                	add    %edx,%eax
ffff800000105108:	83 c0 01             	add    $0x1,%eax
ffff80000010510b:	89 c2                	mov    %eax,%edx
ffff80000010510d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105114:	80 ff ff 
ffff800000105117:	8b 40 78             	mov    0x78(%rax),%eax
ffff80000010511a:	89 d6                	mov    %edx,%esi
ffff80000010511c:	89 c7                	mov    %eax,%edi
ffff80000010511e:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105125:	80 ff ff 
ffff800000105128:	ff d0                	call   *%rax
ffff80000010512a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
ffff80000010512e:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105135:	80 ff ff 
ffff800000105138:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010513b:	48 63 d2             	movslq %edx,%rdx
ffff80000010513e:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105142:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105146:	89 c2                	mov    %eax,%edx
ffff800000105148:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010514f:	80 ff ff 
ffff800000105152:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105155:	89 d6                	mov    %edx,%esi
ffff800000105157:	89 c7                	mov    %eax,%edi
ffff800000105159:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105160:	80 ff ff 
ffff800000105163:	ff d0                	call   *%rax
ffff800000105165:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    memmove(to->data, from->data, BSIZE);
ffff800000105169:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010516d:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000105174:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105178:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff80000010517e:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000105183:	48 89 ce             	mov    %rcx,%rsi
ffff800000105186:	48 89 c7             	mov    %rax,%rdi
ffff800000105189:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff800000105190:	80 ff ff 
ffff800000105193:	ff d0                	call   *%rax
    bwrite(to);  // write the log
ffff800000105195:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105199:	48 89 c7             	mov    %rax,%rdi
ffff80000010519c:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff8000001051a3:	80 ff ff 
ffff8000001051a6:	ff d0                	call   *%rax
    brelse(from);
ffff8000001051a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001051ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001051af:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001051b6:	80 ff ff 
ffff8000001051b9:	ff d0                	call   *%rax
    brelse(to);
ffff8000001051bb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001051bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001051c2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001051c9:	80 ff ff 
ffff8000001051cc:	ff d0                	call   *%rax
  for (tail = 0; tail < log.lh.n; tail++) {
ffff8000001051ce:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001051d2:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051d9:	80 ff ff 
ffff8000001051dc:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001051df:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001051e2:	0f 8c 0e ff ff ff    	jl     ffff8000001050f6 <write_log+0x14>
  }
}
ffff8000001051e8:	90                   	nop
ffff8000001051e9:	90                   	nop
ffff8000001051ea:	c9                   	leave
ffff8000001051eb:	c3                   	ret

ffff8000001051ec <commit>:

static void
commit()
{
ffff8000001051ec:	55                   	push   %rbp
ffff8000001051ed:	48 89 e5             	mov    %rsp,%rbp
  if (log.lh.n > 0) {
ffff8000001051f0:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001051f7:	80 ff ff 
ffff8000001051fa:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001051fd:	85 c0                	test   %eax,%eax
ffff8000001051ff:	7e 41                	jle    ffff800000105242 <commit+0x56>
    write_log();     // Write modified blocks from cache to log
ffff800000105201:	48 b8 e2 50 10 00 00 	movabs $0xffff8000001050e2,%rax
ffff800000105208:	80 ff ff 
ffff80000010520b:	ff d0                	call   *%rax
    write_head();    // Write header to disk -- the real commit
ffff80000010520d:	48 b8 ba 4d 10 00 00 	movabs $0xffff800000104dba,%rax
ffff800000105214:	80 ff ff 
ffff800000105217:	ff d0                	call   *%rax
    install_trans(); // Now install writes to home locations
ffff800000105219:	48 b8 fc 4b 10 00 00 	movabs $0xffff800000104bfc,%rax
ffff800000105220:	80 ff ff 
ffff800000105223:	ff d0                	call   *%rax
    log.lh.n = 0;
ffff800000105225:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010522c:	80 ff ff 
ffff80000010522f:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
    write_head();    // Erase the transaction from the log
ffff800000105236:	48 b8 ba 4d 10 00 00 	movabs $0xffff800000104dba,%rax
ffff80000010523d:	80 ff ff 
ffff800000105240:	ff d0                	call   *%rax
  }
}
ffff800000105242:	90                   	nop
ffff800000105243:	5d                   	pop    %rbp
ffff800000105244:	c3                   	ret

ffff800000105245 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
ffff800000105245:	55                   	push   %rbp
ffff800000105246:	48 89 e5             	mov    %rsp,%rbp
ffff800000105249:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010524d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
ffff800000105251:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105258:	80 ff ff 
ffff80000010525b:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010525e:	83 f8 1d             	cmp    $0x1d,%eax
ffff800000105261:	7f 21                	jg     ffff800000105284 <log_write+0x3f>
ffff800000105263:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010526a:	80 ff ff 
ffff80000010526d:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000105270:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105277:	80 ff ff 
ffff80000010527a:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010527d:	83 e8 01             	sub    $0x1,%eax
ffff800000105280:	39 c2                	cmp    %eax,%edx
ffff800000105282:	7c 19                	jl     ffff80000010529d <log_write+0x58>
    panic("too big a transaction");
ffff800000105284:	48 b8 07 c2 10 00 00 	movabs $0xffff80000010c207,%rax
ffff80000010528b:	80 ff ff 
ffff80000010528e:	48 89 c7             	mov    %rax,%rdi
ffff800000105291:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105298:	80 ff ff 
ffff80000010529b:	ff d0                	call   *%rax
  if (log.outstanding < 1)
ffff80000010529d:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052a4:	80 ff ff 
ffff8000001052a7:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001052aa:	85 c0                	test   %eax,%eax
ffff8000001052ac:	7f 19                	jg     ffff8000001052c7 <log_write+0x82>
    panic("log_write outside of trans");
ffff8000001052ae:	48 b8 1d c2 10 00 00 	movabs $0xffff80000010c21d,%rax
ffff8000001052b5:	80 ff ff 
ffff8000001052b8:	48 89 c7             	mov    %rax,%rdi
ffff8000001052bb:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001052c2:	80 ff ff 
ffff8000001052c5:	ff d0                	call   *%rax

  acquire(&log.lock);
ffff8000001052c7:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052ce:	80 ff ff 
ffff8000001052d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001052d4:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001052db:	80 ff ff 
ffff8000001052de:	ff d0                	call   *%rax
  for (i = 0; i < log.lh.n; i++) {
ffff8000001052e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001052e7:	eb 29                	jmp    ffff800000105312 <log_write+0xcd>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
ffff8000001052e9:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff8000001052f0:	80 ff ff 
ffff8000001052f3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001052f6:	48 63 d2             	movslq %edx,%rdx
ffff8000001052f9:	48 83 c2 1c          	add    $0x1c,%rdx
ffff8000001052fd:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105301:	89 c2                	mov    %eax,%edx
ffff800000105303:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105307:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010530a:	39 c2                	cmp    %eax,%edx
ffff80000010530c:	74 18                	je     ffff800000105326 <log_write+0xe1>
  for (i = 0; i < log.lh.n; i++) {
ffff80000010530e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105312:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105319:	80 ff ff 
ffff80000010531c:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010531f:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105322:	7c c5                	jl     ffff8000001052e9 <log_write+0xa4>
ffff800000105324:	eb 01                	jmp    ffff800000105327 <log_write+0xe2>
      break;
ffff800000105326:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
ffff800000105327:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010532b:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010532e:	89 c1                	mov    %eax,%ecx
ffff800000105330:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105337:	80 ff ff 
ffff80000010533a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010533d:	48 63 d2             	movslq %edx,%rdx
ffff800000105340:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105344:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
  if (i == log.lh.n)
ffff800000105348:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010534f:	80 ff ff 
ffff800000105352:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105355:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105358:	75 1d                	jne    ffff800000105377 <log_write+0x132>
    log.lh.n++;
ffff80000010535a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105361:	80 ff ff 
ffff800000105364:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105367:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010536a:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff800000105371:	80 ff ff 
ffff800000105374:	89 50 7c             	mov    %edx,0x7c(%rax)
  b->flags |= B_DIRTY; // prevent eviction
ffff800000105377:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010537b:	8b 00                	mov    (%rax),%eax
ffff80000010537d:	83 c8 04             	or     $0x4,%eax
ffff800000105380:	89 c2                	mov    %eax,%edx
ffff800000105382:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105386:	89 10                	mov    %edx,(%rax)
  release(&log.lock);
ffff800000105388:	48 b8 e0 71 11 00 00 	movabs $0xffff8000001171e0,%rax
ffff80000010538f:	80 ff ff 
ffff800000105392:	48 89 c7             	mov    %rax,%rdi
ffff800000105395:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010539c:	80 ff ff 
ffff80000010539f:	ff d0                	call   *%rax
}
ffff8000001053a1:	90                   	nop
ffff8000001053a2:	c9                   	leave
ffff8000001053a3:	c3                   	ret

ffff8000001053a4 <v2p>:
#define KERNBASE 0xFFFF800000000000 // First kernel virtual address

#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__
static inline addr_t v2p(void *a) {
ffff8000001053a4:	55                   	push   %rbp
ffff8000001053a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001053a8:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001053ac:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff8000001053b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001053b4:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001053bb:	80 00 00 
ffff8000001053be:	48 01 d0             	add    %rdx,%rax
}
ffff8000001053c1:	c9                   	leave
ffff8000001053c2:	c3                   	ret

ffff8000001053c3 <xchg>:

static inline uint
xchg(volatile uint *addr, addr_t newval)
{
ffff8000001053c3:	55                   	push   %rbp
ffff8000001053c4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001053c7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001053cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001053cf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
ffff8000001053d3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001053d7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001053db:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001053df:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001053e2:	89 45 fc             	mov    %eax,-0x4(%rbp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
ffff8000001053e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001053e8:	c9                   	leave
ffff8000001053e9:	c3                   	ret

ffff8000001053ea <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
ffff8000001053ea:	55                   	push   %rbp
ffff8000001053eb:	48 89 e5             	mov    %rsp,%rbp
  uartearlyinit();
ffff8000001053ee:	48 b8 61 9b 10 00 00 	movabs $0xffff800000109b61,%rax
ffff8000001053f5:	80 ff ff 
ffff8000001053f8:	ff d0                	call   *%rax
  kinit1(end, P2V(PHYSTOP)); // phys page allocator
ffff8000001053fa:	48 ba 00 00 00 0e 00 	movabs $0xffff80000e000000,%rdx
ffff800000105401:	80 ff ff 
ffff800000105404:	48 b8 00 d0 11 00 00 	movabs $0xffff80000011d000,%rax
ffff80000010540b:	80 ff ff 
ffff80000010540e:	48 89 d6             	mov    %rdx,%rsi
ffff800000105411:	48 89 c7             	mov    %rax,%rdi
ffff800000105414:	48 b8 c2 3f 10 00 00 	movabs $0xffff800000103fc2,%rax
ffff80000010541b:	80 ff ff 
ffff80000010541e:	ff d0                	call   *%rax
  kvmalloc();      // kernel page table
ffff800000105420:	48 b8 e9 ad 10 00 00 	movabs $0xffff80000010ade9,%rax
ffff800000105427:	80 ff ff 
ffff80000010542a:	ff d0                	call   *%rax
  mpinit();        // detect other processors
ffff80000010542c:	48 b8 fa 59 10 00 00 	movabs $0xffff8000001059fa,%rax
ffff800000105433:	80 ff ff 
ffff800000105436:	ff d0                	call   *%rax
  lapicinit();     // interrupt controller
ffff800000105438:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010543f:	80 ff ff 
ffff800000105442:	ff d0                	call   *%rax
  tvinit();        // trap vectors
ffff800000105444:	48 b8 88 96 10 00 00 	movabs $0xffff800000109688,%rax
ffff80000010544b:	80 ff ff 
ffff80000010544e:	ff d0                	call   *%rax
  seginit();       // segment descriptors
ffff800000105450:	48 b8 2e a9 10 00 00 	movabs $0xffff80000010a92e,%rax
ffff800000105457:	80 ff ff 
ffff80000010545a:	ff d0                	call   *%rax
  cprintf("\ncpu%d: starting Spring 2026 xv6\n\n", cpunum());
ffff80000010545c:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000105463:	80 ff ff 
ffff800000105466:	ff d0                	call   *%rax
ffff800000105468:	89 c2                	mov    %eax,%edx
ffff80000010546a:	48 b8 38 c2 10 00 00 	movabs $0xffff80000010c238,%rax
ffff800000105471:	80 ff ff 
ffff800000105474:	89 d6                	mov    %edx,%esi
ffff800000105476:	48 89 c7             	mov    %rax,%rdi
ffff800000105479:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010547e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105485:	80 ff ff 
ffff800000105488:	ff d2                	call   *%rdx
  ioapicinit();    // another interrupt controller
ffff80000010548a:	48 b8 8d 3e 10 00 00 	movabs $0xffff800000103e8d,%rax
ffff800000105491:	80 ff ff 
ffff800000105494:	ff d0                	call   *%rax
  consoleinit();   // console hardware
ffff800000105496:	48 b8 99 14 10 00 00 	movabs $0xffff800000101499,%rax
ffff80000010549d:	80 ff ff 
ffff8000001054a0:	ff d0                	call   *%rax
  uartinit();      // serial port
ffff8000001054a2:	48 b8 65 9c 10 00 00 	movabs $0xffff800000109c65,%rax
ffff8000001054a9:	80 ff ff 
ffff8000001054ac:	ff d0                	call   *%rax
  
  traceinit();     // trace buffer
ffff8000001054ae:	48 b8 a4 bc 10 00 00 	movabs $0xffff80000010bca4,%rax
ffff8000001054b5:	80 ff ff 
ffff8000001054b8:	ff d0                	call   *%rax

  pinit();         // process table
ffff8000001054ba:	48 b8 3a 61 10 00 00 	movabs $0xffff80000010613a,%rax
ffff8000001054c1:	80 ff ff 
ffff8000001054c4:	ff d0                	call   *%rax
  binit();         // buffer cache
ffff8000001054c6:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff8000001054cd:	80 ff ff 
ffff8000001054d0:	ff d0                	call   *%rax
  fileinit();      // file table
ffff8000001054d2:	48 b8 1d 1b 10 00 00 	movabs $0xffff800000101b1d,%rax
ffff8000001054d9:	80 ff ff 
ffff8000001054dc:	ff d0                	call   *%rax
  ideinit();       // disk
ffff8000001054de:	48 b8 dc 38 10 00 00 	movabs $0xffff8000001038dc,%rax
ffff8000001054e5:	80 ff ff 
ffff8000001054e8:	ff d0                	call   *%rax
  startothers();   // start other processors
ffff8000001054ea:	48 b8 c7 55 10 00 00 	movabs $0xffff8000001055c7,%rax
ffff8000001054f1:	80 ff ff 
ffff8000001054f4:	ff d0                	call   *%rax
  kinit2();
ffff8000001054f6:	48 b8 38 40 10 00 00 	movabs $0xffff800000104038,%rax
ffff8000001054fd:	80 ff ff 
ffff800000105500:	ff d0                	call   *%rax
  userinit();      // first user process
ffff800000105502:	48 b8 e5 62 10 00 00 	movabs $0xffff8000001062e5,%rax
ffff800000105509:	80 ff ff 
ffff80000010550c:	ff d0                	call   *%rax
  mpmain();        // finish this processor's setup
ffff80000010550e:	48 b8 4e 55 10 00 00 	movabs $0xffff80000010554e,%rax
ffff800000105515:	80 ff ff 
ffff800000105518:	ff d0                	call   *%rax

ffff80000010551a <mpenter>:
}

// Other CPUs jump here from entryother.S.
void
mpenter(void)
{
ffff80000010551a:	55                   	push   %rbp
ffff80000010551b:	48 89 e5             	mov    %rsp,%rbp
  switchkvm();
ffff80000010551e:	48 b8 ea b1 10 00 00 	movabs $0xffff80000010b1ea,%rax
ffff800000105525:	80 ff ff 
ffff800000105528:	ff d0                	call   *%rax
  seginit();
ffff80000010552a:	48 b8 2e a9 10 00 00 	movabs $0xffff80000010a92e,%rax
ffff800000105531:	80 ff ff 
ffff800000105534:	ff d0                	call   *%rax
  lapicinit();
ffff800000105536:	48 b8 fa 44 10 00 00 	movabs $0xffff8000001044fa,%rax
ffff80000010553d:	80 ff ff 
ffff800000105540:	ff d0                	call   *%rax
  mpmain();
ffff800000105542:	48 b8 4e 55 10 00 00 	movabs $0xffff80000010554e,%rax
ffff800000105549:	80 ff ff 
ffff80000010554c:	ff d0                	call   *%rax

ffff80000010554e <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
ffff80000010554e:	55                   	push   %rbp
ffff80000010554f:	48 89 e5             	mov    %rsp,%rbp
  cprintf("cpu%d: starting\n", cpunum());
ffff800000105552:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000105559:	80 ff ff 
ffff80000010555c:	ff d0                	call   *%rax
ffff80000010555e:	89 c2                	mov    %eax,%edx
ffff800000105560:	48 b8 5b c2 10 00 00 	movabs $0xffff80000010c25b,%rax
ffff800000105567:	80 ff ff 
ffff80000010556a:	89 d6                	mov    %edx,%esi
ffff80000010556c:	48 89 c7             	mov    %rax,%rdi
ffff80000010556f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105574:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010557b:	80 ff ff 
ffff80000010557e:	ff d2                	call   *%rdx
  idtinit();       // load idt register
ffff800000105580:	48 b8 60 96 10 00 00 	movabs $0xffff800000109660,%rax
ffff800000105587:	80 ff ff 
ffff80000010558a:	ff d0                	call   *%rax
  syscallinit();   // syscall set up
ffff80000010558c:	48 b8 b7 a8 10 00 00 	movabs $0xffff80000010a8b7,%rax
ffff800000105593:	80 ff ff 
ffff800000105596:	ff d0                	call   *%rax
  xchg(&cpu->started, 1); // tell startothers() we're up
ffff800000105598:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010559f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001055a3:	48 83 c0 10          	add    $0x10,%rax
ffff8000001055a7:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001055ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001055af:	48 b8 c3 53 10 00 00 	movabs $0xffff8000001053c3,%rax
ffff8000001055b6:	80 ff ff 
ffff8000001055b9:	ff d0                	call   *%rax
  scheduler();     // start running processes
ffff8000001055bb:	48 b8 57 6b 10 00 00 	movabs $0xffff800000106b57,%rax
ffff8000001055c2:	80 ff ff 
ffff8000001055c5:	ff d0                	call   *%rax

ffff8000001055c7 <startothers>:
void entry32mp(void);

// Start the non-boot (AP) processors.
static void
startothers(void)
{
ffff8000001055c7:	55                   	push   %rbp
ffff8000001055c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055cb:	48 83 ec 20          	sub    $0x20,%rsp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
ffff8000001055cf:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff8000001055d6:	80 ff ff 
ffff8000001055d9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  memmove(code, _binary_entryother_start,
ffff8000001055dd:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff8000001055e4:	00 00 00 
ffff8000001055e7:	89 c2                	mov    %eax,%edx
ffff8000001055e9:	48 b9 58 df 10 00 00 	movabs $0xffff80000010df58,%rcx
ffff8000001055f0:	80 ff ff 
ffff8000001055f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001055f7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001055fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001055fd:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff800000105604:	80 ff ff 
ffff800000105607:	ff d0                	call   *%rax
          (addr_t)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
ffff800000105609:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105610:	80 ff ff 
ffff800000105613:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105617:	e9 c6 00 00 00       	jmp    ffff8000001056e2 <startothers+0x11b>
    if(c == cpus+cpunum())  // We've started already.
ffff80000010561c:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000105623:	80 ff ff 
ffff800000105626:	ff d0                	call   *%rax
ffff800000105628:	48 63 d0             	movslq %eax,%rdx
ffff80000010562b:	48 89 d0             	mov    %rdx,%rax
ffff80000010562e:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105632:	48 01 d0             	add    %rdx,%rax
ffff800000105635:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105639:	48 89 c2             	mov    %rax,%rdx
ffff80000010563c:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105643:	80 ff ff 
ffff800000105646:	48 01 d0             	add    %rdx,%rax
ffff800000105649:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010564d:	0f 84 89 00 00 00    	je     ffff8000001056dc <startothers+0x115>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
ffff800000105653:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010565a:	80 ff ff 
ffff80000010565d:	ff d0                	call   *%rax
ffff80000010565f:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    *(uint32*)(code-4) = 0x8000; // enough stack to get us to entry64mp
ffff800000105663:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105667:	48 83 e8 04          	sub    $0x4,%rax
ffff80000010566b:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
    *(uint32*)(code-8) = v2p(entry32mp);
ffff800000105671:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff800000105678:	80 ff ff 
ffff80000010567b:	48 89 c7             	mov    %rax,%rdi
ffff80000010567e:	48 b8 a4 53 10 00 00 	movabs $0xffff8000001053a4,%rax
ffff800000105685:	80 ff ff 
ffff800000105688:	ff d0                	call   *%rax
ffff80000010568a:	48 89 c2             	mov    %rax,%rdx
ffff80000010568d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105691:	48 83 e8 08          	sub    $0x8,%rax
ffff800000105695:	89 10                	mov    %edx,(%rax)
    *(uint64*)(code-16) = (uint64) (stack + KSTACKSIZE);
ffff800000105697:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010569b:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff8000001056a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001056a6:	48 83 e8 10          	sub    $0x10,%rax
ffff8000001056aa:	48 89 10             	mov    %rdx,(%rax)

    lapicstartap(c->apicid, V2P(code));
ffff8000001056ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001056b1:	89 c2                	mov    %eax,%edx
ffff8000001056b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001056b7:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff8000001056bb:	0f b6 c0             	movzbl %al,%eax
ffff8000001056be:	89 d6                	mov    %edx,%esi
ffff8000001056c0:	89 c7                	mov    %eax,%edi
ffff8000001056c2:	48 b8 cd 47 10 00 00 	movabs $0xffff8000001047cd,%rax
ffff8000001056c9:	80 ff ff 
ffff8000001056cc:	ff d0                	call   *%rax

    // wait for cpu to finish mpmain()
    while(c->started == 0)
ffff8000001056ce:	90                   	nop
ffff8000001056cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001056d3:	8b 40 10             	mov    0x10(%rax),%eax
ffff8000001056d6:	85 c0                	test   %eax,%eax
ffff8000001056d8:	74 f5                	je     ffff8000001056cf <startothers+0x108>
ffff8000001056da:	eb 01                	jmp    ffff8000001056dd <startothers+0x116>
      continue;
ffff8000001056dc:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
ffff8000001056dd:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff8000001056e2:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff8000001056e9:	80 ff ff 
ffff8000001056ec:	8b 00                	mov    (%rax),%eax
ffff8000001056ee:	48 63 d0             	movslq %eax,%rdx
ffff8000001056f1:	48 89 d0             	mov    %rdx,%rax
ffff8000001056f4:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001056f8:	48 01 d0             	add    %rdx,%rax
ffff8000001056fb:	48 c1 e0 03          	shl    $0x3,%rax
ffff8000001056ff:	48 89 c2             	mov    %rax,%rdx
ffff800000105702:	48 b8 e0 72 11 00 00 	movabs $0xffff8000001172e0,%rax
ffff800000105709:	80 ff ff 
ffff80000010570c:	48 01 d0             	add    %rdx,%rax
ffff80000010570f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105713:	0f 82 03 ff ff ff    	jb     ffff80000010561c <startothers+0x55>
      ;
  }
}
ffff800000105719:	90                   	nop
ffff80000010571a:	90                   	nop
ffff80000010571b:	c9                   	leave
ffff80000010571c:	c3                   	ret

ffff80000010571d <inb>:
{
ffff80000010571d:	55                   	push   %rbp
ffff80000010571e:	48 89 e5             	mov    %rsp,%rbp
ffff800000105721:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000105725:	89 f8                	mov    %edi,%eax
ffff800000105727:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff80000010572b:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff80000010572f:	89 c2                	mov    %eax,%edx
ffff800000105731:	ec                   	in     (%dx),%al
ffff800000105732:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000105735:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000105739:	c9                   	leave
ffff80000010573a:	c3                   	ret

ffff80000010573b <outb>:
{
ffff80000010573b:	55                   	push   %rbp
ffff80000010573c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010573f:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000105743:	89 fa                	mov    %edi,%edx
ffff800000105745:	89 f0                	mov    %esi,%eax
ffff800000105747:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010574b:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff80000010574e:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000105752:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000105756:	ee                   	out    %al,(%dx)
}
ffff800000105757:	90                   	nop
ffff800000105758:	c9                   	leave
ffff800000105759:	c3                   	ret

ffff80000010575a <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
ffff80000010575a:	55                   	push   %rbp
ffff80000010575b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010575e:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105762:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105766:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, sum;

  sum = 0;
ffff800000105769:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff800000105770:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105777:	eb 1a                	jmp    ffff800000105793 <sum+0x39>
    sum += addr[i];
ffff800000105779:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010577c:	48 63 d0             	movslq %eax,%rdx
ffff80000010577f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105783:	48 01 d0             	add    %rdx,%rax
ffff800000105786:	0f b6 00             	movzbl (%rax),%eax
ffff800000105789:	0f b6 c0             	movzbl %al,%eax
ffff80000010578c:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i=0; i<len; i++)
ffff80000010578f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105793:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105796:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff800000105799:	7c de                	jl     ffff800000105779 <sum+0x1f>
  return sum;
ffff80000010579b:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
ffff80000010579e:	c9                   	leave
ffff80000010579f:	c3                   	ret

ffff8000001057a0 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(addr_t a, int len)
{
ffff8000001057a0:	55                   	push   %rbp
ffff8000001057a1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001057a4:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001057a8:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001057ac:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  uchar *e, *p, *addr;
  addr = P2V(a);
ffff8000001057af:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff8000001057b6:	80 ff ff 
ffff8000001057b9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001057bd:	48 01 d0             	add    %rdx,%rax
ffff8000001057c0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  e = addr+len;
ffff8000001057c4:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001057c7:	48 63 d0             	movslq %eax,%rdx
ffff8000001057ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057ce:	48 01 d0             	add    %rdx,%rax
ffff8000001057d1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(p = addr; p < e; p += sizeof(struct mp))
ffff8000001057d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057d9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001057dd:	eb 50                	jmp    ffff80000010582f <mpsearch1+0x8f>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
ffff8000001057df:	48 b9 70 c2 10 00 00 	movabs $0xffff80000010c270,%rcx
ffff8000001057e6:	80 ff ff 
ffff8000001057e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001057ed:	ba 04 00 00 00       	mov    $0x4,%edx
ffff8000001057f2:	48 89 ce             	mov    %rcx,%rsi
ffff8000001057f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001057f8:	48 b8 89 78 10 00 00 	movabs $0xffff800000107889,%rax
ffff8000001057ff:	80 ff ff 
ffff800000105802:	ff d0                	call   *%rax
ffff800000105804:	85 c0                	test   %eax,%eax
ffff800000105806:	75 22                	jne    ffff80000010582a <mpsearch1+0x8a>
ffff800000105808:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010580c:	be 10 00 00 00       	mov    $0x10,%esi
ffff800000105811:	48 89 c7             	mov    %rax,%rdi
ffff800000105814:	48 b8 5a 57 10 00 00 	movabs $0xffff80000010575a,%rax
ffff80000010581b:	80 ff ff 
ffff80000010581e:	ff d0                	call   *%rax
ffff800000105820:	84 c0                	test   %al,%al
ffff800000105822:	75 06                	jne    ffff80000010582a <mpsearch1+0x8a>
      return (struct mp*)p;
ffff800000105824:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105828:	eb 14                	jmp    ffff80000010583e <mpsearch1+0x9e>
  for(p = addr; p < e; p += sizeof(struct mp))
ffff80000010582a:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff80000010582f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105833:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105837:	72 a6                	jb     ffff8000001057df <mpsearch1+0x3f>
  return 0;
ffff800000105839:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010583e:	c9                   	leave
ffff80000010583f:	c3                   	ret

ffff800000105840 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
ffff800000105840:	55                   	push   %rbp
ffff800000105841:	48 89 e5             	mov    %rsp,%rbp
ffff800000105844:	48 83 ec 20          	sub    $0x20,%rsp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
ffff800000105848:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff80000010584f:	80 ff ff 
ffff800000105852:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
ffff800000105856:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010585a:	48 83 c0 0f          	add    $0xf,%rax
ffff80000010585e:	0f b6 00             	movzbl (%rax),%eax
ffff800000105861:	0f b6 c0             	movzbl %al,%eax
ffff800000105864:	c1 e0 08             	shl    $0x8,%eax
ffff800000105867:	89 c2                	mov    %eax,%edx
ffff800000105869:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010586d:	48 83 c0 0e          	add    $0xe,%rax
ffff800000105871:	0f b6 00             	movzbl (%rax),%eax
ffff800000105874:	0f b6 c0             	movzbl %al,%eax
ffff800000105877:	09 d0                	or     %edx,%eax
ffff800000105879:	c1 e0 04             	shl    $0x4,%eax
ffff80000010587c:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff80000010587f:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105883:	74 28                	je     ffff8000001058ad <mpsearch+0x6d>
    if((mp = mpsearch1(p, 1024)))
ffff800000105885:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105888:	be 00 04 00 00       	mov    $0x400,%esi
ffff80000010588d:	48 89 c7             	mov    %rax,%rdi
ffff800000105890:	48 b8 a0 57 10 00 00 	movabs $0xffff8000001057a0,%rax
ffff800000105897:	80 ff ff 
ffff80000010589a:	ff d0                	call   *%rax
ffff80000010589c:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001058a0:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001058a5:	74 5e                	je     ffff800000105905 <mpsearch+0xc5>
      return mp;
ffff8000001058a7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001058ab:	eb 6e                	jmp    ffff80000010591b <mpsearch+0xdb>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
ffff8000001058ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058b1:	48 83 c0 14          	add    $0x14,%rax
ffff8000001058b5:	0f b6 00             	movzbl (%rax),%eax
ffff8000001058b8:	0f b6 c0             	movzbl %al,%eax
ffff8000001058bb:	c1 e0 08             	shl    $0x8,%eax
ffff8000001058be:	89 c2                	mov    %eax,%edx
ffff8000001058c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058c4:	48 83 c0 13          	add    $0x13,%rax
ffff8000001058c8:	0f b6 00             	movzbl (%rax),%eax
ffff8000001058cb:	0f b6 c0             	movzbl %al,%eax
ffff8000001058ce:	09 d0                	or     %edx,%eax
ffff8000001058d0:	c1 e0 0a             	shl    $0xa,%eax
ffff8000001058d3:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if((mp = mpsearch1(p-1024, 1024)))
ffff8000001058d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001058d9:	2d 00 04 00 00       	sub    $0x400,%eax
ffff8000001058de:	89 c0                	mov    %eax,%eax
ffff8000001058e0:	be 00 04 00 00       	mov    $0x400,%esi
ffff8000001058e5:	48 89 c7             	mov    %rax,%rdi
ffff8000001058e8:	48 b8 a0 57 10 00 00 	movabs $0xffff8000001057a0,%rax
ffff8000001058ef:	80 ff ff 
ffff8000001058f2:	ff d0                	call   *%rax
ffff8000001058f4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001058f8:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001058fd:	74 06                	je     ffff800000105905 <mpsearch+0xc5>
      return mp;
ffff8000001058ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105903:	eb 16                	jmp    ffff80000010591b <mpsearch+0xdb>
  }
  return mpsearch1(0xF0000, 0x10000);
ffff800000105905:	be 00 00 01 00       	mov    $0x10000,%esi
ffff80000010590a:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff80000010590f:	48 b8 a0 57 10 00 00 	movabs $0xffff8000001057a0,%rax
ffff800000105916:	80 ff ff 
ffff800000105919:	ff d0                	call   *%rax
}
ffff80000010591b:	c9                   	leave
ffff80000010591c:	c3                   	ret

ffff80000010591d <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
ffff80000010591d:	55                   	push   %rbp
ffff80000010591e:	48 89 e5             	mov    %rsp,%rbp
ffff800000105921:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105925:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
ffff800000105929:	48 b8 40 58 10 00 00 	movabs $0xffff800000105840,%rax
ffff800000105930:	80 ff ff 
ffff800000105933:	ff d0                	call   *%rax
ffff800000105935:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105939:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010593e:	74 0b                	je     ffff80000010594b <mpconfig+0x2e>
ffff800000105940:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105944:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105947:	85 c0                	test   %eax,%eax
ffff800000105949:	75 0a                	jne    ffff800000105955 <mpconfig+0x38>
    return 0;
ffff80000010594b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105950:	e9 a3 00 00 00       	jmp    ffff8000001059f8 <mpconfig+0xdb>
  conf = (struct mpconf*) P2V((addr_t) mp->physaddr);
ffff800000105955:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105959:	8b 40 04             	mov    0x4(%rax),%eax
ffff80000010595c:	89 c2                	mov    %eax,%edx
ffff80000010595e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105965:	80 ff ff 
ffff800000105968:	48 01 d0             	add    %rdx,%rax
ffff80000010596b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  if(memcmp(conf, "PCMP", 4) != 0)
ffff80000010596f:	48 b9 75 c2 10 00 00 	movabs $0xffff80000010c275,%rcx
ffff800000105976:	80 ff ff 
ffff800000105979:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010597d:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105982:	48 89 ce             	mov    %rcx,%rsi
ffff800000105985:	48 89 c7             	mov    %rax,%rdi
ffff800000105988:	48 b8 89 78 10 00 00 	movabs $0xffff800000107889,%rax
ffff80000010598f:	80 ff ff 
ffff800000105992:	ff d0                	call   *%rax
ffff800000105994:	85 c0                	test   %eax,%eax
ffff800000105996:	74 07                	je     ffff80000010599f <mpconfig+0x82>
    return 0;
ffff800000105998:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010599d:	eb 59                	jmp    ffff8000001059f8 <mpconfig+0xdb>
  if(conf->version != 1 && conf->version != 4)
ffff80000010599f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059a3:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff8000001059a7:	3c 01                	cmp    $0x1,%al
ffff8000001059a9:	74 13                	je     ffff8000001059be <mpconfig+0xa1>
ffff8000001059ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059af:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff8000001059b3:	3c 04                	cmp    $0x4,%al
ffff8000001059b5:	74 07                	je     ffff8000001059be <mpconfig+0xa1>
    return 0;
ffff8000001059b7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001059bc:	eb 3a                	jmp    ffff8000001059f8 <mpconfig+0xdb>
  if(sum((uchar*)conf, conf->length) != 0)
ffff8000001059be:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059c2:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff8000001059c6:	0f b7 d0             	movzwl %ax,%edx
ffff8000001059c9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059cd:	89 d6                	mov    %edx,%esi
ffff8000001059cf:	48 89 c7             	mov    %rax,%rdi
ffff8000001059d2:	48 b8 5a 57 10 00 00 	movabs $0xffff80000010575a,%rax
ffff8000001059d9:	80 ff ff 
ffff8000001059dc:	ff d0                	call   *%rax
ffff8000001059de:	84 c0                	test   %al,%al
ffff8000001059e0:	74 07                	je     ffff8000001059e9 <mpconfig+0xcc>
    return 0;
ffff8000001059e2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001059e7:	eb 0f                	jmp    ffff8000001059f8 <mpconfig+0xdb>
  *pmp = mp;
ffff8000001059e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001059ed:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001059f1:	48 89 10             	mov    %rdx,(%rax)
  return conf;
ffff8000001059f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff8000001059f8:	c9                   	leave
ffff8000001059f9:	c3                   	ret

ffff8000001059fa <mpinit>:

void
mpinit(void)
{
ffff8000001059fa:	55                   	push   %rbp
ffff8000001059fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001059fe:	48 83 ec 30          	sub    $0x30,%rsp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0) {
ffff800000105a02:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000105a06:	48 89 c7             	mov    %rax,%rdi
ffff800000105a09:	48 b8 1d 59 10 00 00 	movabs $0xffff80000010591d,%rax
ffff800000105a10:	80 ff ff 
ffff800000105a13:	ff d0                	call   *%rax
ffff800000105a15:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105a19:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105a1e:	75 23                	jne    ffff800000105a43 <mpinit+0x49>
    cprintf("No other CPUs found.\n");
ffff800000105a20:	48 b8 7a c2 10 00 00 	movabs $0xffff80000010c27a,%rax
ffff800000105a27:	80 ff ff 
ffff800000105a2a:	48 89 c7             	mov    %rax,%rdi
ffff800000105a2d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105a32:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105a39:	80 ff ff 
ffff800000105a3c:	ff d2                	call   *%rdx
ffff800000105a3e:	e9 c9 01 00 00       	jmp    ffff800000105c0c <mpinit+0x212>
    return;
  }
  lapic = P2V((addr_t)conf->lapicaddr_p);
ffff800000105a43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a47:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105a4a:	89 c2                	mov    %eax,%edx
ffff800000105a4c:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105a53:	80 ff ff 
ffff800000105a56:	48 01 d0             	add    %rdx,%rax
ffff800000105a59:	48 89 c2             	mov    %rax,%rdx
ffff800000105a5c:	48 b8 c0 71 11 00 00 	movabs $0xffff8000001171c0,%rax
ffff800000105a63:	80 ff ff 
ffff800000105a66:	48 89 10             	mov    %rdx,(%rax)
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105a69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a6d:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105a71:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105a75:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a79:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105a7d:	0f b7 d0             	movzwl %ax,%edx
ffff800000105a80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105a84:	48 01 d0             	add    %rdx,%rax
ffff800000105a87:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105a8b:	e9 f6 00 00 00       	jmp    ffff800000105b86 <mpinit+0x18c>
    switch(*p){
ffff800000105a90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a94:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a97:	0f b6 c0             	movzbl %al,%eax
ffff800000105a9a:	83 f8 04             	cmp    $0x4,%eax
ffff800000105a9d:	0f 8f ca 00 00 00    	jg     ffff800000105b6d <mpinit+0x173>
ffff800000105aa3:	83 f8 03             	cmp    $0x3,%eax
ffff800000105aa6:	0f 8d ba 00 00 00    	jge    ffff800000105b66 <mpinit+0x16c>
ffff800000105aac:	83 f8 02             	cmp    $0x2,%eax
ffff800000105aaf:	0f 84 8e 00 00 00    	je     ffff800000105b43 <mpinit+0x149>
ffff800000105ab5:	83 f8 02             	cmp    $0x2,%eax
ffff800000105ab8:	0f 8f af 00 00 00    	jg     ffff800000105b6d <mpinit+0x173>
ffff800000105abe:	85 c0                	test   %eax,%eax
ffff800000105ac0:	74 0e                	je     ffff800000105ad0 <mpinit+0xd6>
ffff800000105ac2:	83 f8 01             	cmp    $0x1,%eax
ffff800000105ac5:	0f 84 9b 00 00 00    	je     ffff800000105b66 <mpinit+0x16c>
ffff800000105acb:	e9 9d 00 00 00       	jmp    ffff800000105b6d <mpinit+0x173>
    case MPPROC:
      proc = (struct mpproc*)p;
ffff800000105ad0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ad4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
      if(ncpu < NCPU) {
ffff800000105ad8:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105adf:	80 ff ff 
ffff800000105ae2:	8b 00                	mov    (%rax),%eax
ffff800000105ae4:	83 f8 07             	cmp    $0x7,%eax
ffff800000105ae7:	7f 53                	jg     ffff800000105b3c <mpinit+0x142>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
ffff800000105ae9:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105af0:	80 ff ff 
ffff800000105af3:	8b 10                	mov    (%rax),%edx
ffff800000105af5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105af9:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105afd:	48 be e0 72 11 00 00 	movabs $0xffff8000001172e0,%rsi
ffff800000105b04:	80 ff ff 
ffff800000105b07:	48 63 d2             	movslq %edx,%rdx
ffff800000105b0a:	48 89 d0             	mov    %rdx,%rax
ffff800000105b0d:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105b11:	48 01 d0             	add    %rdx,%rax
ffff800000105b14:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105b18:	48 01 f0             	add    %rsi,%rax
ffff800000105b1b:	48 83 c0 01          	add    $0x1,%rax
ffff800000105b1f:	88 08                	mov    %cl,(%rax)
        ncpu++;
ffff800000105b21:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b28:	80 ff ff 
ffff800000105b2b:	8b 00                	mov    (%rax),%eax
ffff800000105b2d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105b30:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b37:	80 ff ff 
ffff800000105b3a:	89 10                	mov    %edx,(%rax)
      }
      p += sizeof(struct mpproc);
ffff800000105b3c:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
      continue;
ffff800000105b41:	eb 43                	jmp    ffff800000105b86 <mpinit+0x18c>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
ffff800000105b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b47:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      ioapicid = ioapic->apicno;
ffff800000105b4b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105b4f:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105b53:	48 ba 24 74 11 00 00 	movabs $0xffff800000117424,%rdx
ffff800000105b5a:	80 ff ff 
ffff800000105b5d:	88 02                	mov    %al,(%rdx)
      p += sizeof(struct mpioapic);
ffff800000105b5f:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105b64:	eb 20                	jmp    ffff800000105b86 <mpinit+0x18c>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
ffff800000105b66:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
      continue;
ffff800000105b6b:	eb 19                	jmp    ffff800000105b86 <mpinit+0x18c>
    default:
      panic("Major problem parsing mp config.");
ffff800000105b6d:	48 b8 90 c2 10 00 00 	movabs $0xffff80000010c290,%rax
ffff800000105b74:	80 ff ff 
ffff800000105b77:	48 89 c7             	mov    %rax,%rdi
ffff800000105b7a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105b81:	80 ff ff 
ffff800000105b84:	ff d0                	call   *%rax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
ffff800000105b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b8a:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105b8e:	0f 82 fc fe ff ff    	jb     ffff800000105a90 <mpinit+0x96>
      break;
    }
  }
  cprintf("Seems we are SMP, ncpu = %d\n",ncpu);
ffff800000105b94:	48 b8 20 74 11 00 00 	movabs $0xffff800000117420,%rax
ffff800000105b9b:	80 ff ff 
ffff800000105b9e:	8b 00                	mov    (%rax),%eax
ffff800000105ba0:	48 ba b1 c2 10 00 00 	movabs $0xffff80000010c2b1,%rdx
ffff800000105ba7:	80 ff ff 
ffff800000105baa:	89 c6                	mov    %eax,%esi
ffff800000105bac:	48 89 d7             	mov    %rdx,%rdi
ffff800000105baf:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bb4:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105bbb:	80 ff ff 
ffff800000105bbe:	ff d2                	call   *%rdx
  if(mp->imcrp){
ffff800000105bc0:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105bc4:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105bc8:	84 c0                	test   %al,%al
ffff800000105bca:	74 40                	je     ffff800000105c0c <mpinit+0x212>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
ffff800000105bcc:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105bd1:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105bd6:	48 b8 3b 57 10 00 00 	movabs $0xffff80000010573b,%rax
ffff800000105bdd:	80 ff ff 
ffff800000105be0:	ff d0                	call   *%rax
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
ffff800000105be2:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105be7:	48 b8 1d 57 10 00 00 	movabs $0xffff80000010571d,%rax
ffff800000105bee:	80 ff ff 
ffff800000105bf1:	ff d0                	call   *%rax
ffff800000105bf3:	83 c8 01             	or     $0x1,%eax
ffff800000105bf6:	0f b6 c0             	movzbl %al,%eax
ffff800000105bf9:	89 c6                	mov    %eax,%esi
ffff800000105bfb:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105c00:	48 b8 3b 57 10 00 00 	movabs $0xffff80000010573b,%rax
ffff800000105c07:	80 ff ff 
ffff800000105c0a:	ff d0                	call   *%rax
  }
}
ffff800000105c0c:	c9                   	leave
ffff800000105c0d:	c3                   	ret

ffff800000105c0e <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
ffff800000105c0e:	55                   	push   %rbp
ffff800000105c0f:	48 89 e5             	mov    %rsp,%rbp
ffff800000105c12:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105c16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105c1a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  struct pipe *p;

  p = 0;
ffff800000105c1e:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105c25:	00 
  *f0 = *f1 = 0;
ffff800000105c26:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c2a:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105c31:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c35:	48 8b 10             	mov    (%rax),%rdx
ffff800000105c38:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c3c:	48 89 10             	mov    %rdx,(%rax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
ffff800000105c3f:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000105c46:	80 ff ff 
ffff800000105c49:	ff d0                	call   *%rax
ffff800000105c4b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105c4f:	48 89 02             	mov    %rax,(%rdx)
ffff800000105c52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105c56:	48 8b 00             	mov    (%rax),%rax
ffff800000105c59:	48 85 c0             	test   %rax,%rax
ffff800000105c5c:	0f 84 01 01 00 00    	je     ffff800000105d63 <pipealloc+0x155>
ffff800000105c62:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000105c69:	80 ff ff 
ffff800000105c6c:	ff d0                	call   *%rax
ffff800000105c6e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105c72:	48 89 02             	mov    %rax,(%rdx)
ffff800000105c75:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105c79:	48 8b 00             	mov    (%rax),%rax
ffff800000105c7c:	48 85 c0             	test   %rax,%rax
ffff800000105c7f:	0f 84 de 00 00 00    	je     ffff800000105d63 <pipealloc+0x155>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
ffff800000105c85:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000105c8c:	80 ff ff 
ffff800000105c8f:	ff d0                	call   *%rax
ffff800000105c91:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105c95:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105c9a:	0f 84 c6 00 00 00    	je     ffff800000105d66 <pipealloc+0x158>
    goto bad;
  p->readopen = 1;
ffff800000105ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ca4:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105cab:	00 00 00 
  p->writeopen = 1;
ffff800000105cae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cb2:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105cb9:	00 00 00 
  p->nwrite = 0;
ffff800000105cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cc0:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105cc7:	00 00 00 
  p->nread = 0;
ffff800000105cca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cce:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105cd5:	00 00 00 
  initlock(&p->lock, "pipe");
ffff800000105cd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cdc:	48 ba ce c2 10 00 00 	movabs $0xffff80000010c2ce,%rdx
ffff800000105ce3:	80 ff ff 
ffff800000105ce6:	48 89 d6             	mov    %rdx,%rsi
ffff800000105ce9:	48 89 c7             	mov    %rax,%rdi
ffff800000105cec:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
ffff800000105cf3:	80 ff ff 
ffff800000105cf6:	ff d0                	call   *%rax
  (*f0)->type = FD_PIPE;
ffff800000105cf8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105cfc:	48 8b 00             	mov    (%rax),%rax
ffff800000105cff:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f0)->readable = 1;
ffff800000105d05:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d09:	48 8b 00             	mov    (%rax),%rax
ffff800000105d0c:	c6 40 08 01          	movb   $0x1,0x8(%rax)
  (*f0)->writable = 0;
ffff800000105d10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d14:	48 8b 00             	mov    (%rax),%rax
ffff800000105d17:	c6 40 09 00          	movb   $0x0,0x9(%rax)
  (*f0)->pipe = p;
ffff800000105d1b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d1f:	48 8b 00             	mov    (%rax),%rax
ffff800000105d22:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105d26:	48 89 50 10          	mov    %rdx,0x10(%rax)
  (*f1)->type = FD_PIPE;
ffff800000105d2a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d2e:	48 8b 00             	mov    (%rax),%rax
ffff800000105d31:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  (*f1)->readable = 0;
ffff800000105d37:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d3b:	48 8b 00             	mov    (%rax),%rax
ffff800000105d3e:	c6 40 08 00          	movb   $0x0,0x8(%rax)
  (*f1)->writable = 1;
ffff800000105d42:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d46:	48 8b 00             	mov    (%rax),%rax
ffff800000105d49:	c6 40 09 01          	movb   $0x1,0x9(%rax)
  (*f1)->pipe = p;
ffff800000105d4d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d51:	48 8b 00             	mov    (%rax),%rax
ffff800000105d54:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105d58:	48 89 50 10          	mov    %rdx,0x10(%rax)
  return 0;
ffff800000105d5c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105d61:	eb 67                	jmp    ffff800000105dca <pipealloc+0x1bc>
    goto bad;
ffff800000105d63:	90                   	nop
ffff800000105d64:	eb 01                	jmp    ffff800000105d67 <pipealloc+0x159>
    goto bad;
ffff800000105d66:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
ffff800000105d67:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105d6c:	74 13                	je     ffff800000105d81 <pipealloc+0x173>
    kfree((char*)p);
ffff800000105d6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d72:	48 89 c7             	mov    %rax,%rdi
ffff800000105d75:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000105d7c:	80 ff ff 
ffff800000105d7f:	ff d0                	call   *%rax
  if(*f0)
ffff800000105d81:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d85:	48 8b 00             	mov    (%rax),%rax
ffff800000105d88:	48 85 c0             	test   %rax,%rax
ffff800000105d8b:	74 16                	je     ffff800000105da3 <pipealloc+0x195>
    fileclose(*f0);
ffff800000105d8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105d91:	48 8b 00             	mov    (%rax),%rax
ffff800000105d94:	48 89 c7             	mov    %rax,%rdi
ffff800000105d97:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000105d9e:	80 ff ff 
ffff800000105da1:	ff d0                	call   *%rax
  if(*f1)
ffff800000105da3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105da7:	48 8b 00             	mov    (%rax),%rax
ffff800000105daa:	48 85 c0             	test   %rax,%rax
ffff800000105dad:	74 16                	je     ffff800000105dc5 <pipealloc+0x1b7>
    fileclose(*f1);
ffff800000105daf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105db3:	48 8b 00             	mov    (%rax),%rax
ffff800000105db6:	48 89 c7             	mov    %rax,%rdi
ffff800000105db9:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000105dc0:	80 ff ff 
ffff800000105dc3:	ff d0                	call   *%rax
  return -1;
ffff800000105dc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000105dca:	c9                   	leave
ffff800000105dcb:	c3                   	ret

ffff800000105dcc <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
ffff800000105dcc:	55                   	push   %rbp
ffff800000105dcd:	48 89 e5             	mov    %rsp,%rbp
ffff800000105dd0:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000105dd4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105dd8:	89 75 f4             	mov    %esi,-0xc(%rbp)
  acquire(&p->lock);
ffff800000105ddb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ddf:	48 89 c7             	mov    %rax,%rdi
ffff800000105de2:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000105de9:	80 ff ff 
ffff800000105dec:	ff d0                	call   *%rax
  if(writable){
ffff800000105dee:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105df2:	74 29                	je     ffff800000105e1d <pipeclose+0x51>
    p->writeopen = 0;
ffff800000105df4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105df8:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000105dff:	00 00 00 
    wakeup(&p->nread);
ffff800000105e02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e06:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105e0c:	48 89 c7             	mov    %rax,%rdi
ffff800000105e0f:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000105e16:	80 ff ff 
ffff800000105e19:	ff d0                	call   *%rax
ffff800000105e1b:	eb 27                	jmp    ffff800000105e44 <pipeclose+0x78>
  } else {
    p->readopen = 0;
ffff800000105e1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e21:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff800000105e28:	00 00 00 
    wakeup(&p->nwrite);
ffff800000105e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e2f:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff800000105e35:	48 89 c7             	mov    %rax,%rdi
ffff800000105e38:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000105e3f:	80 ff ff 
ffff800000105e42:	ff d0                	call   *%rax
  }
  if(p->readopen == 0 && p->writeopen == 0){
ffff800000105e44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e48:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000105e4e:	85 c0                	test   %eax,%eax
ffff800000105e50:	75 36                	jne    ffff800000105e88 <pipeclose+0xbc>
ffff800000105e52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e56:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff800000105e5c:	85 c0                	test   %eax,%eax
ffff800000105e5e:	75 28                	jne    ffff800000105e88 <pipeclose+0xbc>
    release(&p->lock);
ffff800000105e60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e64:	48 89 c7             	mov    %rax,%rdi
ffff800000105e67:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000105e6e:	80 ff ff 
ffff800000105e71:	ff d0                	call   *%rax
    kfree((char*)p);
ffff800000105e73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e77:	48 89 c7             	mov    %rax,%rdi
ffff800000105e7a:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000105e81:	80 ff ff 
ffff800000105e84:	ff d0                	call   *%rax
ffff800000105e86:	eb 14                	jmp    ffff800000105e9c <pipeclose+0xd0>
  } else
    release(&p->lock);
ffff800000105e88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105e8c:	48 89 c7             	mov    %rax,%rdi
ffff800000105e8f:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000105e96:	80 ff ff 
ffff800000105e99:	ff d0                	call   *%rax
}
ffff800000105e9b:	90                   	nop
ffff800000105e9c:	90                   	nop
ffff800000105e9d:	c9                   	leave
ffff800000105e9e:	c3                   	ret

ffff800000105e9f <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
ffff800000105e9f:	55                   	push   %rbp
ffff800000105ea0:	48 89 e5             	mov    %rsp,%rbp
ffff800000105ea3:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105ea7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105eab:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000105eaf:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff800000105eb2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105eb6:	48 89 c7             	mov    %rax,%rdi
ffff800000105eb9:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000105ec0:	80 ff ff 
ffff800000105ec3:	ff d0                	call   *%rax
  for(i = 0; i < n; i++){
ffff800000105ec5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105ecc:	e9 d5 00 00 00       	jmp    ffff800000105fa6 <pipewrite+0x107>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
ffff800000105ed1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ed5:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff800000105edb:	85 c0                	test   %eax,%eax
ffff800000105edd:	74 12                	je     ffff800000105ef1 <pipewrite+0x52>
ffff800000105edf:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000105ee6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000105eea:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000105eed:	85 c0                	test   %eax,%eax
ffff800000105eef:	74 1d                	je     ffff800000105f0e <pipewrite+0x6f>
        release(&p->lock);
ffff800000105ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ef5:	48 89 c7             	mov    %rax,%rdi
ffff800000105ef8:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000105eff:	80 ff ff 
ffff800000105f02:	ff d0                	call   *%rax
        return -1;
ffff800000105f04:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000105f09:	e9 cf 00 00 00       	jmp    ffff800000105fdd <pipewrite+0x13e>
      }
      wakeup(&p->nread);
ffff800000105f0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f12:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105f18:	48 89 c7             	mov    %rax,%rdi
ffff800000105f1b:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000105f22:	80 ff ff 
ffff800000105f25:	ff d0                	call   *%rax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffff800000105f27:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f2b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105f2f:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff800000105f36:	48 89 c6             	mov    %rax,%rsi
ffff800000105f39:	48 89 d7             	mov    %rdx,%rdi
ffff800000105f3c:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff800000105f43:	80 ff ff 
ffff800000105f46:	ff d0                	call   *%rax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffff800000105f48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f4c:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff800000105f52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f56:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff800000105f5c:	05 00 02 00 00       	add    $0x200,%eax
ffff800000105f61:	39 c2                	cmp    %eax,%edx
ffff800000105f63:	0f 84 68 ff ff ff    	je     ffff800000105ed1 <pipewrite+0x32>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffff800000105f69:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105f6c:	48 63 d0             	movslq %eax,%rdx
ffff800000105f6f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f73:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff800000105f77:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f7b:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000105f81:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000105f84:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105f88:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff800000105f8e:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000105f93:	89 c1                	mov    %eax,%ecx
ffff800000105f95:	0f b6 16             	movzbl (%rsi),%edx
ffff800000105f98:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f9c:	89 c9                	mov    %ecx,%ecx
ffff800000105f9e:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
  for(i = 0; i < n; i++){
ffff800000105fa2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105fa6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105fa9:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000105fac:	7c 9a                	jl     ffff800000105f48 <pipewrite+0xa9>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffff800000105fae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fb2:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000105fb8:	48 89 c7             	mov    %rax,%rdi
ffff800000105fbb:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000105fc2:	80 ff ff 
ffff800000105fc5:	ff d0                	call   *%rax
  release(&p->lock);
ffff800000105fc7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105fcb:	48 89 c7             	mov    %rax,%rdi
ffff800000105fce:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000105fd5:	80 ff ff 
ffff800000105fd8:	ff d0                	call   *%rax
  return n;
ffff800000105fda:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000105fdd:	c9                   	leave
ffff800000105fde:	c3                   	ret

ffff800000105fdf <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
ffff800000105fdf:	55                   	push   %rbp
ffff800000105fe0:	48 89 e5             	mov    %rsp,%rbp
ffff800000105fe3:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105fe7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105feb:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000105fef:	89 55 dc             	mov    %edx,-0x24(%rbp)
  int i;

  acquire(&p->lock);
ffff800000105ff2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105ff6:	48 89 c7             	mov    %rax,%rdi
ffff800000105ff9:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106000:	80 ff ff 
ffff800000106003:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff800000106005:	eb 50                	jmp    ffff800000106057 <piperead+0x78>
    if(proc->killed){
ffff800000106007:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010600e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106012:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106015:	85 c0                	test   %eax,%eax
ffff800000106017:	74 1d                	je     ffff800000106036 <piperead+0x57>
      release(&p->lock);
ffff800000106019:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010601d:	48 89 c7             	mov    %rax,%rdi
ffff800000106020:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106027:	80 ff ff 
ffff80000010602a:	ff d0                	call   *%rax
      return -1;
ffff80000010602c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106031:	e9 de 00 00 00       	jmp    ffff800000106114 <piperead+0x135>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
ffff800000106036:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010603a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010603e:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff800000106045:	48 89 c6             	mov    %rax,%rsi
ffff800000106048:	48 89 d7             	mov    %rdx,%rdi
ffff80000010604b:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff800000106052:	80 ff ff 
ffff800000106055:	ff d0                	call   *%rax
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffff800000106057:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010605b:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106061:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106065:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010606b:	39 c2                	cmp    %eax,%edx
ffff80000010606d:	75 0e                	jne    ffff80000010607d <piperead+0x9e>
ffff80000010606f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106073:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff800000106079:	85 c0                	test   %eax,%eax
ffff80000010607b:	75 8a                	jne    ffff800000106007 <piperead+0x28>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff80000010607d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106084:	eb 54                	jmp    ffff8000001060da <piperead+0xfb>
    if(p->nread == p->nwrite)
ffff800000106086:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010608a:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106090:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106094:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010609a:	39 c2                	cmp    %eax,%edx
ffff80000010609c:	74 46                	je     ffff8000001060e4 <piperead+0x105>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
ffff80000010609e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060a2:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff8000001060a8:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001060ab:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001060af:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff8000001060b5:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001060ba:	89 c1                	mov    %eax,%ecx
ffff8000001060bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001060bf:	48 63 d0             	movslq %eax,%rdx
ffff8000001060c2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001060c6:	48 01 c2             	add    %rax,%rdx
ffff8000001060c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060cd:	89 c9                	mov    %ecx,%ecx
ffff8000001060cf:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff8000001060d4:	88 02                	mov    %al,(%rdx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
ffff8000001060d6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001060da:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001060dd:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001060e0:	7c a4                	jl     ffff800000106086 <piperead+0xa7>
ffff8000001060e2:	eb 01                	jmp    ffff8000001060e5 <piperead+0x106>
      break;
ffff8000001060e4:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffff8000001060e5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060e9:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff8000001060ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001060f2:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff8000001060f9:	80 ff ff 
ffff8000001060fc:	ff d0                	call   *%rax
  release(&p->lock);
ffff8000001060fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106102:	48 89 c7             	mov    %rax,%rdi
ffff800000106105:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010610c:	80 ff ff 
ffff80000010610f:	ff d0                	call   *%rax
  return i;
ffff800000106111:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000106114:	c9                   	leave
ffff800000106115:	c3                   	ret

ffff800000106116 <readeflags>:
{
ffff800000106116:	55                   	push   %rbp
ffff800000106117:	48 89 e5             	mov    %rsp,%rbp
ffff80000010611a:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff80000010611e:	9c                   	pushf
ffff80000010611f:	58                   	pop    %rax
ffff800000106120:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff800000106124:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000106128:	c9                   	leave
ffff800000106129:	c3                   	ret

ffff80000010612a <sti>:
{
ffff80000010612a:	55                   	push   %rbp
ffff80000010612b:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff80000010612e:	fb                   	sti
}
ffff80000010612f:	90                   	nop
ffff800000106130:	5d                   	pop    %rbp
ffff800000106131:	c3                   	ret

ffff800000106132 <hlt>:
{
ffff800000106132:	55                   	push   %rbp
ffff800000106133:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff800000106136:	f4                   	hlt
}
ffff800000106137:	90                   	nop
ffff800000106138:	5d                   	pop    %rbp
ffff800000106139:	c3                   	ret

ffff80000010613a <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffff80000010613a:	55                   	push   %rbp
ffff80000010613b:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff80000010613e:	48 ba d3 c2 10 00 00 	movabs $0xffff80000010c2d3,%rdx
ffff800000106145:	80 ff ff 
ffff800000106148:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010614f:	80 ff ff 
ffff800000106152:	48 89 d6             	mov    %rdx,%rsi
ffff800000106155:	48 89 c7             	mov    %rax,%rdi
ffff800000106158:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
ffff80000010615f:	80 ff ff 
ffff800000106162:	ff d0                	call   *%rax
}
ffff800000106164:	90                   	nop
ffff800000106165:	5d                   	pop    %rbp
ffff800000106166:	c3                   	ret

ffff800000106167 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffff800000106167:	55                   	push   %rbp
ffff800000106168:	48 89 e5             	mov    %rsp,%rbp
ffff80000010616b:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffff80000010616f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106176:	80 ff ff 
ffff800000106179:	48 89 c7             	mov    %rax,%rdi
ffff80000010617c:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106183:	80 ff ff 
ffff800000106186:	ff d0                	call   *%rax

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106188:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff80000010618f:	80 ff ff 
ffff800000106192:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106196:	eb 13                	jmp    ffff8000001061ab <allocproc+0x44>
    if(p->state == UNUSED)
ffff800000106198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010619c:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010619f:	85 c0                	test   %eax,%eax
ffff8000001061a1:	74 3b                	je     ffff8000001061de <allocproc+0x77>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001061a3:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff8000001061aa:	00 
ffff8000001061ab:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff8000001061b2:	80 ff ff 
ffff8000001061b5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001061b9:	72 dd                	jb     ffff800000106198 <allocproc+0x31>
      goto found;

  release(&ptable.lock);
ffff8000001061bb:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001061c2:	80 ff ff 
ffff8000001061c5:	48 89 c7             	mov    %rax,%rdi
ffff8000001061c8:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff8000001061cf:	80 ff ff 
ffff8000001061d2:	ff d0                	call   *%rax
  return 0;
ffff8000001061d4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001061d9:	e9 05 01 00 00       	jmp    ffff8000001062e3 <allocproc+0x17c>
      goto found;
ffff8000001061de:	90                   	nop

found:
  p->state = EMBRYO;
ffff8000001061df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001061e3:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff8000001061ea:	48 b8 40 d5 10 00 00 	movabs $0xffff80000010d540,%rax
ffff8000001061f1:	80 ff ff 
ffff8000001061f4:	8b 00                	mov    (%rax),%eax
ffff8000001061f6:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001061f9:	48 b9 40 d5 10 00 00 	movabs $0xffff80000010d540,%rcx
ffff800000106200:	80 ff ff 
ffff800000106203:	89 11                	mov    %edx,(%rcx)
ffff800000106205:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106209:	89 42 1c             	mov    %eax,0x1c(%rdx)

  release(&ptable.lock);
ffff80000010620c:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106213:	80 ff ff 
ffff800000106216:	48 89 c7             	mov    %rax,%rdi
ffff800000106219:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106220:	80 ff ff 
ffff800000106223:	ff d0                	call   *%rax

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffff800000106225:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010622c:	80 ff ff 
ffff80000010622f:	ff d0                	call   *%rax
ffff800000106231:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106235:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff800000106239:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010623d:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106241:	48 85 c0             	test   %rax,%rax
ffff800000106244:	75 15                	jne    ffff80000010625b <allocproc+0xf4>
    p->state = UNUSED;
ffff800000106246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010624a:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff800000106251:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106256:	e9 88 00 00 00       	jmp    ffff8000001062e3 <allocproc+0x17c>
  }
  sp = p->kstack + KSTACKSIZE;
ffff80000010625b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010625f:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106263:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff800000106269:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffff80000010626d:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff800000106274:	00 
  p->tf = (struct trapframe*)sp;
ffff800000106275:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106279:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010627d:	48 89 50 28          	mov    %rdx,0x28(%rax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(addr_t);
ffff800000106281:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff800000106286:	48 ba 15 95 10 00 00 	movabs $0xffff800000109515,%rdx
ffff80000010628d:	80 ff ff 
ffff800000106290:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106294:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffff800000106297:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff80000010629c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062a0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001062a4:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff8000001062a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062ac:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001062b0:	ba 38 00 00 00       	mov    $0x38,%edx
ffff8000001062b5:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001062ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001062bd:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff8000001062c4:	80 ff ff 
ffff8000001062c7:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff8000001062c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001062cd:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001062d1:	48 ba fb 6d 10 00 00 	movabs $0xffff800000106dfb,%rdx
ffff8000001062d8:	80 ff ff 
ffff8000001062db:	48 89 50 30          	mov    %rdx,0x30(%rax)

  return p;
ffff8000001062df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001062e3:	c9                   	leave
ffff8000001062e4:	c3                   	ret

ffff8000001062e5 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffff8000001062e5:	55                   	push   %rbp
ffff8000001062e6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001062e9:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  p = allocproc();
ffff8000001062ed:	48 b8 67 61 10 00 00 	movabs $0xffff800000106167,%rax
ffff8000001062f4:	80 ff ff 
ffff8000001062f7:	ff d0                	call   *%rax
ffff8000001062f9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  initproc = p;
ffff8000001062fd:	48 ba a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rdx
ffff800000106304:	80 ff ff 
ffff800000106307:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010630b:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff80000010630e:	48 b8 80 ad 10 00 00 	movabs $0xffff80000010ad80,%rax
ffff800000106315:	80 ff ff 
ffff800000106318:	ff d0                	call   *%rax
ffff80000010631a:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010631e:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106322:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106326:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010632a:	48 85 c0             	test   %rax,%rax
ffff80000010632d:	75 19                	jne    ffff800000106348 <userinit+0x63>
    panic("userinit: out of memory?");
ffff80000010632f:	48 b8 da c2 10 00 00 	movabs $0xffff80000010c2da,%rax
ffff800000106336:	80 ff ff 
ffff800000106339:	48 89 c7             	mov    %rax,%rdi
ffff80000010633c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106343:	80 ff ff 
ffff800000106346:	ff d0                	call   *%rax

  inituvm(p->pgdir, _binary_initcode_start,
ffff800000106348:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff80000010634f:	00 00 00 
ffff800000106352:	89 c2                	mov    %eax,%edx
ffff800000106354:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106358:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010635c:	48 b9 18 df 10 00 00 	movabs $0xffff80000010df18,%rcx
ffff800000106363:	80 ff ff 
ffff800000106366:	48 89 ce             	mov    %rcx,%rsi
ffff800000106369:	48 89 c7             	mov    %rax,%rdi
ffff80000010636c:	48 b8 f6 b2 10 00 00 	movabs $0xffff80000010b2f6,%rax
ffff800000106373:	80 ff ff 
ffff800000106376:	ff d0                	call   *%rax
          (addr_t)_binary_initcode_size);
  p->sz = PGSIZE * 2;
ffff800000106378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010637c:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff800000106383:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106387:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010638b:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff800000106390:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106395:	48 89 c7             	mov    %rax,%rdi
ffff800000106398:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010639f:	80 ff ff 
ffff8000001063a2:	ff d0                	call   *%rax

  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff8000001063a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063a8:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001063ac:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff8000001063b3:	00 
  p->tf->rsp = p->sz;
ffff8000001063b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063b8:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001063bc:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001063c0:	48 8b 12             	mov    (%rdx),%rdx
ffff8000001063c3:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff8000001063ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063ce:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001063d2:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff8000001063d9:	00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001063da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063de:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff8000001063e4:	48 b9 f3 c2 10 00 00 	movabs $0xffff80000010c2f3,%rcx
ffff8000001063eb:	80 ff ff 
ffff8000001063ee:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001063f3:	48 89 ce             	mov    %rcx,%rsi
ffff8000001063f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001063f9:	48 b8 ab 7a 10 00 00 	movabs $0xffff800000107aab,%rax
ffff800000106400:	80 ff ff 
ffff800000106403:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff800000106405:	48 b8 fc c2 10 00 00 	movabs $0xffff80000010c2fc,%rax
ffff80000010640c:	80 ff ff 
ffff80000010640f:	48 89 c7             	mov    %rax,%rdi
ffff800000106412:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000106419:	80 ff ff 
ffff80000010641c:	ff d0                	call   *%rax
ffff80000010641e:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106422:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  __sync_synchronize();
ffff800000106429:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff80000010642f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106433:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff80000010643a:	90                   	nop
ffff80000010643b:	c9                   	leave
ffff80000010643c:	c3                   	ret

ffff80000010643d <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int64 n)
{
ffff80000010643d:	55                   	push   %rbp
ffff80000010643e:	48 89 e5             	mov    %rsp,%rbp
ffff800000106441:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106445:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  addr_t sz;

  sz = proc->sz;
ffff800000106449:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106450:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106454:	48 8b 00             	mov    (%rax),%rax
ffff800000106457:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff80000010645b:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106460:	7e 42                	jle    ffff8000001064a4 <growproc+0x67>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106462:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106466:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010646a:	48 01 c2             	add    %rax,%rdx
ffff80000010646d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106474:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106478:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010647c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000106480:	48 89 ce             	mov    %rcx,%rsi
ffff800000106483:	48 89 c7             	mov    %rax,%rdi
ffff800000106486:	48 b8 d7 b4 10 00 00 	movabs $0xffff80000010b4d7,%rax
ffff80000010648d:	80 ff ff 
ffff800000106490:	ff d0                	call   *%rax
ffff800000106492:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106496:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010649b:	75 50                	jne    ffff8000001064ed <growproc+0xb0>
      return -1;
ffff80000010649d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001064a2:	eb 7a                	jmp    ffff80000010651e <growproc+0xe1>
  } else if(n < 0){
ffff8000001064a4:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001064a9:	79 42                	jns    ffff8000001064ed <growproc+0xb0>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff8000001064ab:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001064af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064b3:	48 01 c2             	add    %rax,%rdx
ffff8000001064b6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064bd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064c1:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001064c5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001064c9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001064cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001064cf:	48 b8 1b b6 10 00 00 	movabs $0xffff80000010b61b,%rax
ffff8000001064d6:	80 ff ff 
ffff8000001064d9:	ff d0                	call   *%rax
ffff8000001064db:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001064df:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001064e4:	75 07                	jne    ffff8000001064ed <growproc+0xb0>
      return -1;
ffff8000001064e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001064eb:	eb 31                	jmp    ffff80000010651e <growproc+0xe1>
  }
  proc->sz = sz;
ffff8000001064ed:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001064f4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001064f8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001064fc:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff8000001064ff:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106506:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010650a:	48 89 c7             	mov    %rax,%rdi
ffff80000010650d:	48 b8 de ae 10 00 00 	movabs $0xffff80000010aede,%rax
ffff800000106514:	80 ff ff 
ffff800000106517:	ff d0                	call   *%rax
  return 0;
ffff800000106519:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010651e:	c9                   	leave
ffff80000010651f:	c3                   	ret

ffff800000106520 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff800000106520:	55                   	push   %rbp
ffff800000106521:	48 89 e5             	mov    %rsp,%rbp
ffff800000106524:	53                   	push   %rbx
ffff800000106525:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff800000106529:	48 b8 67 61 10 00 00 	movabs $0xffff800000106167,%rax
ffff800000106530:	80 ff ff 
ffff800000106533:	ff d0                	call   *%rax
ffff800000106535:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000106539:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010653e:	75 0a                	jne    ffff80000010654a <fork+0x2a>
    return -1;
ffff800000106540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106545:	e9 88 02 00 00       	jmp    ffff8000001067d2 <fork+0x2b2>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff80000010654a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106551:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106555:	48 8b 00             	mov    (%rax),%rax
ffff800000106558:	89 c2                	mov    %eax,%edx
ffff80000010655a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106561:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106565:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106569:	89 d6                	mov    %edx,%esi
ffff80000010656b:	48 89 c7             	mov    %rax,%rdi
ffff80000010656e:	48 b8 b6 b9 10 00 00 	movabs $0xffff80000010b9b6,%rax
ffff800000106575:	80 ff ff 
ffff800000106578:	ff d0                	call   *%rax
ffff80000010657a:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010657e:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106582:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106586:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010658a:	48 85 c0             	test   %rax,%rax
ffff80000010658d:	75 38                	jne    ffff8000001065c7 <fork+0xa7>
    kfree(np->kstack);
ffff80000010658f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106593:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106597:	48 89 c7             	mov    %rax,%rdi
ffff80000010659a:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff8000001065a1:	80 ff ff 
ffff8000001065a4:	ff d0                	call   *%rax
    np->kstack = 0;
ffff8000001065a6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065aa:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001065b1:	00 
    np->state = UNUSED;
ffff8000001065b2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065b6:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff8000001065bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001065c2:	e9 0b 02 00 00       	jmp    ffff8000001067d2 <fork+0x2b2>
  }
  np->sz = proc->sz;
ffff8000001065c7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065ce:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001065d2:	48 8b 10             	mov    (%rax),%rdx
ffff8000001065d5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065d9:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff8000001065dc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065e3:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001065e7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001065eb:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff8000001065ef:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001065f6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001065fa:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff8000001065fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106602:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106606:	48 8b 0a             	mov    (%rdx),%rcx
ffff800000106609:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff80000010660d:	48 89 08             	mov    %rcx,(%rax)
ffff800000106610:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff800000106614:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff800000106618:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff80000010661c:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff800000106620:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff800000106624:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff800000106628:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff80000010662c:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff800000106630:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff800000106634:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff800000106638:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff80000010663c:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff800000106640:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff800000106644:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff800000106648:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff80000010664c:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff800000106650:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff800000106654:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff800000106658:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff80000010665c:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff800000106660:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff800000106664:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff800000106668:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff80000010666c:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff800000106670:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff800000106674:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff800000106678:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff80000010667c:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff800000106680:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff800000106684:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff80000010668b:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff800000106692:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff800000106699:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff8000001066a0:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff8000001066a7:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff8000001066ae:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff8000001066b5:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff8000001066bc:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff8000001066c3:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff8000001066ca:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff8000001066d1:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff8000001066d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001066dc:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001066e0:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff8000001066e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff8000001066ee:	eb 5f                	jmp    ffff80000010674f <fork+0x22f>
    if(proc->ofile[i])
ffff8000001066f0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066f7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066fb:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001066fe:	48 63 d2             	movslq %edx,%rdx
ffff800000106701:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106705:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010670a:	48 85 c0             	test   %rax,%rax
ffff80000010670d:	74 3c                	je     ffff80000010674b <fork+0x22b>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff80000010670f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106716:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010671a:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010671d:	48 63 d2             	movslq %edx,%rdx
ffff800000106720:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106724:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106729:	48 89 c7             	mov    %rax,%rdi
ffff80000010672c:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff800000106733:	80 ff ff 
ffff800000106736:	ff d0                	call   *%rax
ffff800000106738:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010673c:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff80000010673f:	48 63 c9             	movslq %ecx,%rcx
ffff800000106742:	48 83 c1 08          	add    $0x8,%rcx
ffff800000106746:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff80000010674b:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff80000010674f:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff800000106753:	7e 9b                	jle    ffff8000001066f0 <fork+0x1d0>
  np->cwd = idup(proc->cwd);
ffff800000106755:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010675c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106760:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106767:	48 89 c7             	mov    %rax,%rdi
ffff80000010676a:	48 b8 37 28 10 00 00 	movabs $0xffff800000102837,%rax
ffff800000106771:	80 ff ff 
ffff800000106774:	ff d0                	call   *%rax
ffff800000106776:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010677a:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff800000106781:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106788:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010678c:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000106793:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106797:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff80000010679d:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001067a2:	48 89 ce             	mov    %rcx,%rsi
ffff8000001067a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001067a8:	48 b8 ab 7a 10 00 00 	movabs $0xffff800000107aab,%rax
ffff8000001067af:	80 ff ff 
ffff8000001067b2:	ff d0                	call   *%rax

  pid = np->pid;
ffff8000001067b4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067b8:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001067bb:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff8000001067be:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff8000001067c4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067c8:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  return pid;
ffff8000001067cf:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff8000001067d2:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff8000001067d6:	c9                   	leave
ffff8000001067d7:	c3                   	ret

ffff8000001067d8 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff8000001067d8:	55                   	push   %rbp
ffff8000001067d9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001067dc:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffff8000001067e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067e7:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001067eb:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff8000001067f2:	80 ff ff 
ffff8000001067f5:	48 8b 00             	mov    (%rax),%rax
ffff8000001067f8:	48 39 c2             	cmp    %rax,%rdx
ffff8000001067fb:	75 19                	jne    ffff800000106816 <exit+0x3e>
    panic("init exiting");
ffff8000001067fd:	48 b8 fe c2 10 00 00 	movabs $0xffff80000010c2fe,%rax
ffff800000106804:	80 ff ff 
ffff800000106807:	48 89 c7             	mov    %rax,%rdi
ffff80000010680a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106811:	80 ff ff 
ffff800000106814:	ff d0                	call   *%rax

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106816:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010681d:	eb 6a                	jmp    ffff800000106889 <exit+0xb1>
    if(proc->ofile[fd]){
ffff80000010681f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106826:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010682a:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010682d:	48 63 d2             	movslq %edx,%rdx
ffff800000106830:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106834:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106839:	48 85 c0             	test   %rax,%rax
ffff80000010683c:	74 47                	je     ffff800000106885 <exit+0xad>
      fileclose(proc->ofile[fd]);
ffff80000010683e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106845:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106849:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010684c:	48 63 d2             	movslq %edx,%rdx
ffff80000010684f:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106853:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106858:	48 89 c7             	mov    %rax,%rdi
ffff80000010685b:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000106862:	80 ff ff 
ffff800000106865:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff800000106867:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010686e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106872:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106875:	48 63 d2             	movslq %edx,%rdx
ffff800000106878:	48 83 c2 08          	add    $0x8,%rdx
ffff80000010687c:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106883:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106885:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff800000106889:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff80000010688d:	7e 90                	jle    ffff80000010681f <exit+0x47>
    }
  }

  begin_op();
ffff80000010688f:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000106896:	80 ff ff 
ffff800000106899:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff80000010689b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068a2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068a6:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff8000001068ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001068b0:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff8000001068b7:	80 ff ff 
ffff8000001068ba:	ff d0                	call   *%rax
  end_op();
ffff8000001068bc:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001068c3:	80 ff ff 
ffff8000001068c6:	ff d0                	call   *%rax
  proc->cwd = 0;
ffff8000001068c8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068cf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068d3:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff8000001068da:	00 00 00 00 

  acquire(&ptable.lock);
ffff8000001068de:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001068e5:	80 ff ff 
ffff8000001068e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001068eb:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001068f2:	80 ff ff 
ffff8000001068f5:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff8000001068f7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068fe:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106902:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000106906:	48 89 c7             	mov    %rax,%rdi
ffff800000106909:	48 b8 75 6f 10 00 00 	movabs $0xffff800000106f75,%rax
ffff800000106910:	80 ff ff 
ffff800000106913:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106915:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff80000010691c:	80 ff ff 
ffff80000010691f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106923:	eb 5d                	jmp    ffff800000106982 <exit+0x1aa>
    if(p->parent == proc){
ffff800000106925:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106929:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff80000010692d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106934:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106938:	48 39 c2             	cmp    %rax,%rdx
ffff80000010693b:	75 3d                	jne    ffff80000010697a <exit+0x1a2>
      p->parent = initproc;
ffff80000010693d:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000106944:	80 ff ff 
ffff800000106947:	48 8b 10             	mov    (%rax),%rdx
ffff80000010694a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010694e:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106952:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106956:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106959:	83 f8 05             	cmp    $0x5,%eax
ffff80000010695c:	75 1c                	jne    ffff80000010697a <exit+0x1a2>
        wakeup1(initproc);
ffff80000010695e:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000106965:	80 ff ff 
ffff800000106968:	48 8b 00             	mov    (%rax),%rax
ffff80000010696b:	48 89 c7             	mov    %rax,%rdi
ffff80000010696e:	48 b8 75 6f 10 00 00 	movabs $0xffff800000106f75,%rax
ffff800000106975:	80 ff ff 
ffff800000106978:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010697a:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106981:	00 
ffff800000106982:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000106989:	80 ff ff 
ffff80000010698c:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106990:	72 93                	jb     ffff800000106925 <exit+0x14d>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106992:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106999:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010699d:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff8000001069a4:	48 b8 8a 6c 10 00 00 	movabs $0xffff800000106c8a,%rax
ffff8000001069ab:	80 ff ff 
ffff8000001069ae:	ff d0                	call   *%rax
  panic("zombie exit");
ffff8000001069b0:	48 b8 0b c3 10 00 00 	movabs $0xffff80000010c30b,%rax
ffff8000001069b7:	80 ff ff 
ffff8000001069ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001069bd:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001069c4:	80 ff ff 
ffff8000001069c7:	ff d0                	call   *%rax

ffff8000001069c9 <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff8000001069c9:	55                   	push   %rbp
ffff8000001069ca:	48 89 e5             	mov    %rsp,%rbp
ffff8000001069cd:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff8000001069d1:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001069d8:	80 ff ff 
ffff8000001069db:	48 89 c7             	mov    %rax,%rdi
ffff8000001069de:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001069e5:	80 ff ff 
ffff8000001069e8:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff8000001069ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001069f1:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001069f8:	80 ff ff 
ffff8000001069fb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001069ff:	e9 d9 00 00 00       	jmp    ffff800000106add <wait+0x114>
      if(p->parent != proc)
ffff800000106a04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a08:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106a0c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a13:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a17:	48 39 c2             	cmp    %rax,%rdx
ffff800000106a1a:	0f 85 b4 00 00 00    	jne    ffff800000106ad4 <wait+0x10b>
        continue;
      havekids = 1;
ffff800000106a20:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106a27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a2b:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106a2e:	83 f8 05             	cmp    $0x5,%eax
ffff800000106a31:	0f 85 9e 00 00 00    	jne    ffff800000106ad5 <wait+0x10c>
        // Found one.
        pid = p->pid;
ffff800000106a37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a3b:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106a3e:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106a41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a45:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106a49:	48 89 c7             	mov    %rax,%rdi
ffff800000106a4c:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff800000106a53:	80 ff ff 
ffff800000106a56:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106a58:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a5c:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106a63:	00 
        freevm(p->pgdir);
ffff800000106a64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a68:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106a6c:	48 89 c7             	mov    %rax,%rdi
ffff800000106a6f:	48 b8 14 b7 10 00 00 	movabs $0xffff80000010b714,%rax
ffff800000106a76:	80 ff ff 
ffff800000106a79:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106a7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a7f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106a86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a8a:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106a91:	00 
        p->name[0] = 0;
ffff800000106a92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106a96:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106a9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106aa1:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        p->state = UNUSED;
ffff800000106aa8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106aac:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106ab3:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106aba:	80 ff ff 
ffff800000106abd:	48 89 c7             	mov    %rax,%rdi
ffff800000106ac0:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106ac7:	80 ff ff 
ffff800000106aca:	ff d0                	call   *%rax
        return pid;
ffff800000106acc:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106acf:	e9 81 00 00 00       	jmp    ffff800000106b55 <wait+0x18c>
        continue;
ffff800000106ad4:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106ad5:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106adc:	00 
ffff800000106add:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000106ae4:	80 ff ff 
ffff800000106ae7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106aeb:	0f 82 13 ff ff ff    	jb     ffff800000106a04 <wait+0x3b>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106af1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106af5:	74 12                	je     ffff800000106b09 <wait+0x140>
ffff800000106af7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106afe:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b02:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106b05:	85 c0                	test   %eax,%eax
ffff800000106b07:	74 20                	je     ffff800000106b29 <wait+0x160>
      release(&ptable.lock);
ffff800000106b09:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106b10:	80 ff ff 
ffff800000106b13:	48 89 c7             	mov    %rax,%rdi
ffff800000106b16:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106b1d:	80 ff ff 
ffff800000106b20:	ff d0                	call   *%rax
      return -1;
ffff800000106b22:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106b27:	eb 2c                	jmp    ffff800000106b55 <wait+0x18c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106b29:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b30:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b34:	48 ba 40 74 11 00 00 	movabs $0xffff800000117440,%rdx
ffff800000106b3b:	80 ff ff 
ffff800000106b3e:	48 89 d6             	mov    %rdx,%rsi
ffff800000106b41:	48 89 c7             	mov    %rax,%rdi
ffff800000106b44:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff800000106b4b:	80 ff ff 
ffff800000106b4e:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106b50:	e9 95 fe ff ff       	jmp    ffff8000001069ea <wait+0x21>
  }
}
ffff800000106b55:	c9                   	leave
ffff800000106b56:	c3                   	ret

ffff800000106b57 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106b57:	55                   	push   %rbp
ffff800000106b58:	48 89 e5             	mov    %rsp,%rbp
ffff800000106b5b:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106b5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106b66:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106b6d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106b71:	48 b8 2a 61 10 00 00 	movabs $0xffff80000010612a,%rax
ffff800000106b78:	80 ff ff 
ffff800000106b7b:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106b7d:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106b84:	80 ff ff 
ffff800000106b87:	48 89 c7             	mov    %rax,%rdi
ffff800000106b8a:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106b91:	80 ff ff 
ffff800000106b94:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106b96:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106b9d:	80 ff ff 
ffff800000106ba0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106ba4:	e9 92 00 00 00       	jmp    ffff800000106c3b <scheduler+0xe4>
      if(p->state != RUNNABLE) {
ffff800000106ba9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106bad:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106bb0:	83 f8 03             	cmp    $0x3,%eax
ffff800000106bb3:	74 06                	je     ffff800000106bbb <scheduler+0x64>
        skipped++;
ffff800000106bb5:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106bb9:	eb 78                	jmp    ffff800000106c33 <scheduler+0xdc>
      }
      skipped = 0;
ffff800000106bbb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106bc2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106bc9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106bcd:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106bd1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106bd5:	48 89 c7             	mov    %rax,%rdi
ffff800000106bd8:	48 b8 de ae 10 00 00 	movabs $0xffff80000010aede,%rax
ffff800000106bdf:	80 ff ff 
ffff800000106be2:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000106be4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106be8:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000106bef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106bf3:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106bf7:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000106bfe:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106c02:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106c06:	48 89 c6             	mov    %rax,%rsi
ffff800000106c09:	48 89 d7             	mov    %rdx,%rdi
ffff800000106c0c:	48 b8 40 7b 10 00 00 	movabs $0xffff800000107b40,%rax
ffff800000106c13:	80 ff ff 
ffff800000106c16:	ff d0                	call   *%rax
      switchkvm();
ffff800000106c18:	48 b8 ea b1 10 00 00 	movabs $0xffff80000010b1ea,%rax
ffff800000106c1f:	80 ff ff 
ffff800000106c22:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000106c24:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c2b:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000106c32:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106c33:	48 81 45 f0 e0 00 00 	addq   $0xe0,-0x10(%rbp)
ffff800000106c3a:	00 
ffff800000106c3b:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000106c42:	80 ff ff 
ffff800000106c45:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106c49:	0f 82 5a ff ff ff    	jb     ffff800000106ba9 <scheduler+0x52>
    }
    release(&ptable.lock);
ffff800000106c4f:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106c56:	80 ff ff 
ffff800000106c59:	48 89 c7             	mov    %rax,%rdi
ffff800000106c5c:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106c63:	80 ff ff 
ffff800000106c66:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000106c68:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff800000106c6c:	0f 8e fb fe ff ff    	jle    ffff800000106b6d <scheduler+0x16>
      hlt();
ffff800000106c72:	48 b8 32 61 10 00 00 	movabs $0xffff800000106132,%rax
ffff800000106c79:	80 ff ff 
ffff800000106c7c:	ff d0                	call   *%rax
      skipped = 0;
ffff800000106c7e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff800000106c85:	e9 e3 fe ff ff       	jmp    ffff800000106b6d <scheduler+0x16>

ffff800000106c8a <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff800000106c8a:	55                   	push   %rbp
ffff800000106c8b:	48 89 e5             	mov    %rsp,%rbp
ffff800000106c8e:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff800000106c92:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106c99:	80 ff ff 
ffff800000106c9c:	48 89 c7             	mov    %rax,%rdi
ffff800000106c9f:	48 b8 43 76 10 00 00 	movabs $0xffff800000107643,%rax
ffff800000106ca6:	80 ff ff 
ffff800000106ca9:	ff d0                	call   *%rax
ffff800000106cab:	85 c0                	test   %eax,%eax
ffff800000106cad:	75 19                	jne    ffff800000106cc8 <sched+0x3e>
    panic("sched ptable.lock");
ffff800000106caf:	48 b8 17 c3 10 00 00 	movabs $0xffff80000010c317,%rax
ffff800000106cb6:	80 ff ff 
ffff800000106cb9:	48 89 c7             	mov    %rax,%rdi
ffff800000106cbc:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106cc3:	80 ff ff 
ffff800000106cc6:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff800000106cc8:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106ccf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106cd3:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000106cd6:	83 f8 01             	cmp    $0x1,%eax
ffff800000106cd9:	74 19                	je     ffff800000106cf4 <sched+0x6a>
    panic("sched locks");
ffff800000106cdb:	48 b8 29 c3 10 00 00 	movabs $0xffff80000010c329,%rax
ffff800000106ce2:	80 ff ff 
ffff800000106ce5:	48 89 c7             	mov    %rax,%rdi
ffff800000106ce8:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106cef:	80 ff ff 
ffff800000106cf2:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000106cf4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106cfb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106cff:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106d02:	83 f8 04             	cmp    $0x4,%eax
ffff800000106d05:	75 19                	jne    ffff800000106d20 <sched+0x96>
    panic("sched running");
ffff800000106d07:	48 b8 35 c3 10 00 00 	movabs $0xffff80000010c335,%rax
ffff800000106d0e:	80 ff ff 
ffff800000106d11:	48 89 c7             	mov    %rax,%rdi
ffff800000106d14:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106d1b:	80 ff ff 
ffff800000106d1e:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000106d20:	48 b8 16 61 10 00 00 	movabs $0xffff800000106116,%rax
ffff800000106d27:	80 ff ff 
ffff800000106d2a:	ff d0                	call   *%rax
ffff800000106d2c:	25 00 02 00 00       	and    $0x200,%eax
ffff800000106d31:	48 85 c0             	test   %rax,%rax
ffff800000106d34:	74 19                	je     ffff800000106d4f <sched+0xc5>
    panic("sched interruptible");
ffff800000106d36:	48 b8 43 c3 10 00 00 	movabs $0xffff80000010c343,%rax
ffff800000106d3d:	80 ff ff 
ffff800000106d40:	48 89 c7             	mov    %rax,%rdi
ffff800000106d43:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106d4a:	80 ff ff 
ffff800000106d4d:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000106d4f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106d56:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d5a:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106d5d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000106d60:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106d67:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d6b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106d6f:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff800000106d76:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106d7a:	48 83 c2 30          	add    $0x30,%rdx
ffff800000106d7e:	48 89 c6             	mov    %rax,%rsi
ffff800000106d81:	48 89 d7             	mov    %rdx,%rdi
ffff800000106d84:	48 b8 40 7b 10 00 00 	movabs $0xffff800000107b40,%rax
ffff800000106d8b:	80 ff ff 
ffff800000106d8e:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff800000106d90:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106d97:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d9b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000106d9e:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff800000106da1:	90                   	nop
ffff800000106da2:	c9                   	leave
ffff800000106da3:	c3                   	ret

ffff800000106da4 <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff800000106da4:	55                   	push   %rbp
ffff800000106da5:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff800000106da8:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106daf:	80 ff ff 
ffff800000106db2:	48 89 c7             	mov    %rax,%rdi
ffff800000106db5:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106dbc:	80 ff ff 
ffff800000106dbf:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff800000106dc1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106dc8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106dcc:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff800000106dd3:	48 b8 8a 6c 10 00 00 	movabs $0xffff800000106c8a,%rax
ffff800000106dda:	80 ff ff 
ffff800000106ddd:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000106ddf:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106de6:	80 ff ff 
ffff800000106de9:	48 89 c7             	mov    %rax,%rdi
ffff800000106dec:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106df3:	80 ff ff 
ffff800000106df6:	ff d0                	call   *%rax
}
ffff800000106df8:	90                   	nop
ffff800000106df9:	5d                   	pop    %rbp
ffff800000106dfa:	c3                   	ret

ffff800000106dfb <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff800000106dfb:	55                   	push   %rbp
ffff800000106dfc:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff800000106dff:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106e06:	80 ff ff 
ffff800000106e09:	48 89 c7             	mov    %rax,%rdi
ffff800000106e0c:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106e13:	80 ff ff 
ffff800000106e16:	ff d0                	call   *%rax

  if (first) {
ffff800000106e18:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000106e1f:	80 ff ff 
ffff800000106e22:	8b 00                	mov    (%rax),%eax
ffff800000106e24:	85 c0                	test   %eax,%eax
ffff800000106e26:	74 32                	je     ffff800000106e5a <forkret+0x5f>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff800000106e28:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff800000106e2f:	80 ff ff 
ffff800000106e32:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff800000106e38:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000106e3d:	48 b8 17 24 10 00 00 	movabs $0xffff800000102417,%rax
ffff800000106e44:	80 ff ff 
ffff800000106e47:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff800000106e49:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000106e4e:	48 b8 70 4b 10 00 00 	movabs $0xffff800000104b70,%rax
ffff800000106e55:	80 ff ff 
ffff800000106e58:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff800000106e5a:	90                   	nop
ffff800000106e5b:	5d                   	pop    %rbp
ffff800000106e5c:	c3                   	ret

ffff800000106e5d <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff800000106e5d:	55                   	push   %rbp
ffff800000106e5e:	48 89 e5             	mov    %rsp,%rbp
ffff800000106e61:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000106e65:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000106e69:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff800000106e6d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e74:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106e78:	48 85 c0             	test   %rax,%rax
ffff800000106e7b:	75 19                	jne    ffff800000106e96 <sleep+0x39>
    panic("sleep");
ffff800000106e7d:	48 b8 57 c3 10 00 00 	movabs $0xffff80000010c357,%rax
ffff800000106e84:	80 ff ff 
ffff800000106e87:	48 89 c7             	mov    %rax,%rdi
ffff800000106e8a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106e91:	80 ff ff 
ffff800000106e94:	ff d0                	call   *%rax

  if(lk == 0)
ffff800000106e96:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000106e9b:	75 19                	jne    ffff800000106eb6 <sleep+0x59>
    panic("sleep without lk");
ffff800000106e9d:	48 b8 5d c3 10 00 00 	movabs $0xffff80000010c35d,%rax
ffff800000106ea4:	80 ff ff 
ffff800000106ea7:	48 89 c7             	mov    %rax,%rdi
ffff800000106eaa:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106eb1:	80 ff ff 
ffff800000106eb4:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff800000106eb6:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ebd:	80 ff ff 
ffff800000106ec0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106ec4:	74 2c                	je     ffff800000106ef2 <sleep+0x95>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff800000106ec6:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106ecd:	80 ff ff 
ffff800000106ed0:	48 89 c7             	mov    %rax,%rdi
ffff800000106ed3:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106eda:	80 ff ff 
ffff800000106edd:	ff d0                	call   *%rax
    release(lk);
ffff800000106edf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106ee3:	48 89 c7             	mov    %rax,%rdi
ffff800000106ee6:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106eed:	80 ff ff 
ffff800000106ef0:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff800000106ef2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ef9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106efd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106f01:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff800000106f05:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f0c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f10:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff800000106f17:	48 b8 8a 6c 10 00 00 	movabs $0xffff800000106c8a,%rax
ffff800000106f1e:	80 ff ff 
ffff800000106f21:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff800000106f23:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f2a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f2e:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff800000106f35:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff800000106f36:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106f3d:	80 ff ff 
ffff800000106f40:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106f44:	74 2c                	je     ffff800000106f72 <sleep+0x115>
    release(&ptable.lock);
ffff800000106f46:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106f4d:	80 ff ff 
ffff800000106f50:	48 89 c7             	mov    %rax,%rdi
ffff800000106f53:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000106f5a:	80 ff ff 
ffff800000106f5d:	ff d0                	call   *%rax
    acquire(lk);
ffff800000106f5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106f63:	48 89 c7             	mov    %rax,%rdi
ffff800000106f66:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106f6d:	80 ff ff 
ffff800000106f70:	ff d0                	call   *%rax
  }
}
ffff800000106f72:	90                   	nop
ffff800000106f73:	c9                   	leave
ffff800000106f74:	c3                   	ret

ffff800000106f75 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff800000106f75:	55                   	push   %rbp
ffff800000106f76:	48 89 e5             	mov    %rsp,%rbp
ffff800000106f79:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000106f7d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106f81:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000106f88:	80 ff ff 
ffff800000106f8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106f8f:	eb 2d                	jmp    ffff800000106fbe <wakeup1+0x49>
    if(p->state == SLEEPING && p->chan == chan)
ffff800000106f91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106f95:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f98:	83 f8 02             	cmp    $0x2,%eax
ffff800000106f9b:	75 19                	jne    ffff800000106fb6 <wakeup1+0x41>
ffff800000106f9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106fa1:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000106fa5:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000106fa9:	75 0b                	jne    ffff800000106fb6 <wakeup1+0x41>
      p->state = RUNNABLE;
ffff800000106fab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106faf:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106fb6:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106fbd:	00 
ffff800000106fbe:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000106fc5:	80 ff ff 
ffff800000106fc8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106fcc:	72 c3                	jb     ffff800000106f91 <wakeup1+0x1c>
}
ffff800000106fce:	90                   	nop
ffff800000106fcf:	90                   	nop
ffff800000106fd0:	c9                   	leave
ffff800000106fd1:	c3                   	ret

ffff800000106fd2 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff800000106fd2:	55                   	push   %rbp
ffff800000106fd3:	48 89 e5             	mov    %rsp,%rbp
ffff800000106fd6:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000106fda:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000106fde:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000106fe5:	80 ff ff 
ffff800000106fe8:	48 89 c7             	mov    %rax,%rdi
ffff800000106feb:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000106ff2:	80 ff ff 
ffff800000106ff5:	ff d0                	call   *%rax
  wakeup1(chan);
ffff800000106ff7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ffb:	48 89 c7             	mov    %rax,%rdi
ffff800000106ffe:	48 b8 75 6f 10 00 00 	movabs $0xffff800000106f75,%rax
ffff800000107005:	80 ff ff 
ffff800000107008:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff80000010700a:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107011:	80 ff ff 
ffff800000107014:	48 89 c7             	mov    %rax,%rdi
ffff800000107017:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010701e:	80 ff ff 
ffff800000107021:	ff d0                	call   *%rax
}
ffff800000107023:	90                   	nop
ffff800000107024:	c9                   	leave
ffff800000107025:	c3                   	ret

ffff800000107026 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff800000107026:	55                   	push   %rbp
ffff800000107027:	48 89 e5             	mov    %rsp,%rbp
ffff80000010702a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010702e:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff800000107031:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff800000107038:	80 ff ff 
ffff80000010703b:	48 89 c7             	mov    %rax,%rdi
ffff80000010703e:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000107045:	80 ff ff 
ffff800000107048:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff80000010704a:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff800000107051:	80 ff ff 
ffff800000107054:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107058:	eb 56                	jmp    ffff8000001070b0 <kill+0x8a>
    if(p->pid == pid){
ffff80000010705a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010705e:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000107061:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000107064:	75 42                	jne    ffff8000001070a8 <kill+0x82>
      p->killed = 1;
ffff800000107066:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010706a:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff800000107071:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107075:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107078:	83 f8 02             	cmp    $0x2,%eax
ffff80000010707b:	75 0b                	jne    ffff800000107088 <kill+0x62>
        p->state = RUNNABLE;
ffff80000010707d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107081:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff800000107088:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff80000010708f:	80 ff ff 
ffff800000107092:	48 89 c7             	mov    %rax,%rdi
ffff800000107095:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010709c:	80 ff ff 
ffff80000010709f:	ff d0                	call   *%rax
      return 0;
ffff8000001070a1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001070a6:	eb 36                	jmp    ffff8000001070de <kill+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001070a8:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff8000001070af:	00 
ffff8000001070b0:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff8000001070b7:	80 ff ff 
ffff8000001070ba:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001070be:	72 9a                	jb     ffff80000010705a <kill+0x34>
    }
  }
  release(&ptable.lock);
ffff8000001070c0:	48 b8 40 74 11 00 00 	movabs $0xffff800000117440,%rax
ffff8000001070c7:	80 ff ff 
ffff8000001070ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001070cd:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff8000001070d4:	80 ff ff 
ffff8000001070d7:	ff d0                	call   *%rax
  return -1;
ffff8000001070d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001070de:	c9                   	leave
ffff8000001070df:	c3                   	ret

ffff8000001070e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff8000001070e0:	55                   	push   %rbp
ffff8000001070e1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070e4:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001070e8:	48 b8 a8 74 11 00 00 	movabs $0xffff8000001174a8,%rax
ffff8000001070ef:	80 ff ff 
ffff8000001070f2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001070f6:	e9 41 01 00 00       	jmp    ffff80000010723c <procdump+0x15c>
    if(p->state == UNUSED)
ffff8000001070fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001070ff:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107102:	85 c0                	test   %eax,%eax
ffff800000107104:	0f 84 29 01 00 00    	je     ffff800000107233 <procdump+0x153>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff80000010710a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010710e:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107111:	83 f8 05             	cmp    $0x5,%eax
ffff800000107114:	77 39                	ja     ffff80000010714f <procdump+0x6f>
ffff800000107116:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010711a:	8b 50 18             	mov    0x18(%rax),%edx
ffff80000010711d:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff800000107124:	80 ff ff 
ffff800000107127:	89 d2                	mov    %edx,%edx
ffff800000107129:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff80000010712d:	48 85 c0             	test   %rax,%rax
ffff800000107130:	74 1d                	je     ffff80000010714f <procdump+0x6f>
      state = states[p->state];
ffff800000107132:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107136:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107139:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff800000107140:	80 ff ff 
ffff800000107143:	89 d2                	mov    %edx,%edx
ffff800000107145:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff800000107149:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010714d:	eb 0e                	jmp    ffff80000010715d <procdump+0x7d>
    else
      state = "???";
ffff80000010714f:	48 b8 6e c3 10 00 00 	movabs $0xffff80000010c36e,%rax
ffff800000107156:	80 ff ff 
ffff800000107159:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff80000010715d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107161:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000107168:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010716c:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010716f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107173:	48 bf 72 c3 10 00 00 	movabs $0xffff80000010c372,%rdi
ffff80000010717a:	80 ff ff 
ffff80000010717d:	89 c6                	mov    %eax,%esi
ffff80000010717f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107184:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff80000010718b:	80 ff ff 
ffff80000010718e:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff800000107191:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107195:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107198:	83 f8 02             	cmp    $0x2,%eax
ffff80000010719b:	75 76                	jne    ffff800000107213 <procdump+0x133>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff80000010719d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001071a1:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001071a5:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001071a9:	48 83 c0 10          	add    $0x10,%rax
ffff8000001071ad:	48 89 c2             	mov    %rax,%rdx
ffff8000001071b0:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff8000001071b4:	48 89 c6             	mov    %rax,%rsi
ffff8000001071b7:	48 89 d7             	mov    %rdx,%rdi
ffff8000001071ba:	48 b8 a9 75 10 00 00 	movabs $0xffff8000001075a9,%rax
ffff8000001071c1:	80 ff ff 
ffff8000001071c4:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff8000001071c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001071cd:	eb 2f                	jmp    ffff8000001071fe <procdump+0x11e>
        cprintf(" %p", pc[i]);
ffff8000001071cf:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001071d2:	48 98                	cltq
ffff8000001071d4:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff8000001071d9:	48 ba 7b c3 10 00 00 	movabs $0xffff80000010c37b,%rdx
ffff8000001071e0:	80 ff ff 
ffff8000001071e3:	48 89 c6             	mov    %rax,%rsi
ffff8000001071e6:	48 89 d7             	mov    %rdx,%rdi
ffff8000001071e9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001071ee:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001071f5:	80 ff ff 
ffff8000001071f8:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff8000001071fa:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001071fe:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107202:	7f 0f                	jg     ffff800000107213 <procdump+0x133>
ffff800000107204:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107207:	48 98                	cltq
ffff800000107209:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff80000010720e:	48 85 c0             	test   %rax,%rax
ffff800000107211:	75 bc                	jne    ffff8000001071cf <procdump+0xef>
    }
    cprintf("\n");
ffff800000107213:	48 b8 7f c3 10 00 00 	movabs $0xffff80000010c37f,%rax
ffff80000010721a:	80 ff ff 
ffff80000010721d:	48 89 c7             	mov    %rax,%rdi
ffff800000107220:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107225:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010722c:	80 ff ff 
ffff80000010722f:	ff d2                	call   *%rdx
ffff800000107231:	eb 01                	jmp    ffff800000107234 <procdump+0x154>
      continue;
ffff800000107233:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107234:	48 81 45 f0 e0 00 00 	addq   $0xe0,-0x10(%rbp)
ffff80000010723b:	00 
ffff80000010723c:	48 b8 a8 ac 11 00 00 	movabs $0xffff80000011aca8,%rax
ffff800000107243:	80 ff ff 
ffff800000107246:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010724a:	0f 82 ab fe ff ff    	jb     ffff8000001070fb <procdump+0x1b>
  }
}
ffff800000107250:	90                   	nop
ffff800000107251:	90                   	nop
ffff800000107252:	c9                   	leave
ffff800000107253:	c3                   	ret

ffff800000107254 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
ffff800000107254:	55                   	push   %rbp
ffff800000107255:	48 89 e5             	mov    %rsp,%rbp
ffff800000107258:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010725c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107260:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  initlock(&lk->lk, "sleep lock");
ffff800000107264:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107268:	48 83 c0 08          	add    $0x8,%rax
ffff80000010726c:	48 ba ab c3 10 00 00 	movabs $0xffff80000010c3ab,%rdx
ffff800000107273:	80 ff ff 
ffff800000107276:	48 89 d6             	mov    %rdx,%rsi
ffff800000107279:	48 89 c7             	mov    %rax,%rdi
ffff80000010727c:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
ffff800000107283:	80 ff ff 
ffff800000107286:	ff d0                	call   *%rax
  lk->name = name;
ffff800000107288:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010728c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000107290:	48 89 50 70          	mov    %rdx,0x70(%rax)
  lk->locked = 0;
ffff800000107294:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107298:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff80000010729e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072a2:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
}
ffff8000001072a9:	90                   	nop
ffff8000001072aa:	c9                   	leave
ffff8000001072ab:	c3                   	ret

ffff8000001072ac <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
ffff8000001072ac:	55                   	push   %rbp
ffff8000001072ad:	48 89 e5             	mov    %rsp,%rbp
ffff8000001072b0:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001072b4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff8000001072b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072bc:	48 83 c0 08          	add    $0x8,%rax
ffff8000001072c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001072c3:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001072ca:	80 ff ff 
ffff8000001072cd:	ff d0                	call   *%rax
  while (lk->locked)
ffff8000001072cf:	eb 1e                	jmp    ffff8000001072ef <acquiresleep+0x43>
    sleep(lk, &lk->lk);
ffff8000001072d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072d5:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff8000001072d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072dd:	48 89 d6             	mov    %rdx,%rsi
ffff8000001072e0:	48 89 c7             	mov    %rax,%rdi
ffff8000001072e3:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff8000001072ea:	80 ff ff 
ffff8000001072ed:	ff d0                	call   *%rax
  while (lk->locked)
ffff8000001072ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072f3:	8b 00                	mov    (%rax),%eax
ffff8000001072f5:	85 c0                	test   %eax,%eax
ffff8000001072f7:	75 d8                	jne    ffff8000001072d1 <acquiresleep+0x25>
  lk->locked = 1;
ffff8000001072f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072fd:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
  lk->pid = proc->pid;
ffff800000107303:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010730a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010730e:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff800000107311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107315:	89 50 78             	mov    %edx,0x78(%rax)
  release(&lk->lk);
ffff800000107318:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010731c:	48 83 c0 08          	add    $0x8,%rax
ffff800000107320:	48 89 c7             	mov    %rax,%rdi
ffff800000107323:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010732a:	80 ff ff 
ffff80000010732d:	ff d0                	call   *%rax
}
ffff80000010732f:	90                   	nop
ffff800000107330:	c9                   	leave
ffff800000107331:	c3                   	ret

ffff800000107332 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
ffff800000107332:	55                   	push   %rbp
ffff800000107333:	48 89 e5             	mov    %rsp,%rbp
ffff800000107336:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010733a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&lk->lk);
ffff80000010733e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107342:	48 83 c0 08          	add    $0x8,%rax
ffff800000107346:	48 89 c7             	mov    %rax,%rdi
ffff800000107349:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff800000107350:	80 ff ff 
ffff800000107353:	ff d0                	call   *%rax
  lk->locked = 0;
ffff800000107355:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107359:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->pid = 0;
ffff80000010735f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107363:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
  wakeup(lk);
ffff80000010736a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010736e:	48 89 c7             	mov    %rax,%rdi
ffff800000107371:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000107378:	80 ff ff 
ffff80000010737b:	ff d0                	call   *%rax
  release(&lk->lk);
ffff80000010737d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107381:	48 83 c0 08          	add    $0x8,%rax
ffff800000107385:	48 89 c7             	mov    %rax,%rdi
ffff800000107388:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010738f:	80 ff ff 
ffff800000107392:	ff d0                	call   *%rax
}
ffff800000107394:	90                   	nop
ffff800000107395:	c9                   	leave
ffff800000107396:	c3                   	ret

ffff800000107397 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
ffff800000107397:	55                   	push   %rbp
ffff800000107398:	48 89 e5             	mov    %rsp,%rbp
ffff80000010739b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010739f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  acquire(&lk->lk);
ffff8000001073a3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001073a7:	48 83 c0 08          	add    $0x8,%rax
ffff8000001073ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001073ae:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001073b5:	80 ff ff 
ffff8000001073b8:	ff d0                	call   *%rax
  int r = lk->locked;
ffff8000001073ba:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001073be:	8b 00                	mov    (%rax),%eax
ffff8000001073c0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&lk->lk);
ffff8000001073c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001073c7:	48 83 c0 08          	add    $0x8,%rax
ffff8000001073cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001073ce:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff8000001073d5:	80 ff ff 
ffff8000001073d8:	ff d0                	call   *%rax
  return r;
ffff8000001073da:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff8000001073dd:	c9                   	leave
ffff8000001073de:	c3                   	ret

ffff8000001073df <readeflags>:
{
ffff8000001073df:	55                   	push   %rbp
ffff8000001073e0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001073e3:	48 83 ec 10          	sub    $0x10,%rsp
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff8000001073e7:	9c                   	pushf
ffff8000001073e8:	58                   	pop    %rax
ffff8000001073e9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff8000001073ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001073f1:	c9                   	leave
ffff8000001073f2:	c3                   	ret

ffff8000001073f3 <cli>:
{
ffff8000001073f3:	55                   	push   %rbp
ffff8000001073f4:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("cli");
ffff8000001073f7:	fa                   	cli
}
ffff8000001073f8:	90                   	nop
ffff8000001073f9:	5d                   	pop    %rbp
ffff8000001073fa:	c3                   	ret

ffff8000001073fb <sti>:
{
ffff8000001073fb:	55                   	push   %rbp
ffff8000001073fc:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff8000001073ff:	fb                   	sti
}
ffff800000107400:	90                   	nop
ffff800000107401:	5d                   	pop    %rbp
ffff800000107402:	c3                   	ret

ffff800000107403 <xchg>:
{
ffff800000107403:	55                   	push   %rbp
ffff800000107404:	48 89 e5             	mov    %rsp,%rbp
ffff800000107407:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010740b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010740f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  asm volatile("lock; xchgl %0, %1" :
ffff800000107413:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107417:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010741b:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff80000010741f:	f0 87 02             	lock xchg %eax,(%rdx)
ffff800000107422:	89 45 fc             	mov    %eax,-0x4(%rbp)
  return result;
ffff800000107425:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000107428:	c9                   	leave
ffff800000107429:	c3                   	ret

ffff80000010742a <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
ffff80000010742a:	55                   	push   %rbp
ffff80000010742b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010742e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107432:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107436:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  lk->name = name;
ffff80000010743a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010743e:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000107442:	48 89 50 08          	mov    %rdx,0x8(%rax)
  lk->locked = 0;
ffff800000107446:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010744a:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
  lk->cpu = 0;
ffff800000107450:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107454:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff80000010745b:	00 
}
ffff80000010745c:	90                   	nop
ffff80000010745d:	c9                   	leave
ffff80000010745e:	c3                   	ret

ffff80000010745f <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
ffff80000010745f:	55                   	push   %rbp
ffff800000107460:	48 89 e5             	mov    %rsp,%rbp
ffff800000107463:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107467:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  pushcli(); // disable interrupts to avoid deadlock.
ffff80000010746b:	48 b8 7f 76 10 00 00 	movabs $0xffff80000010767f,%rax
ffff800000107472:	80 ff ff 
ffff800000107475:	ff d0                	call   *%rax
  if(holding(lk))
ffff800000107477:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010747b:	48 89 c7             	mov    %rax,%rdi
ffff80000010747e:	48 b8 43 76 10 00 00 	movabs $0xffff800000107643,%rax
ffff800000107485:	80 ff ff 
ffff800000107488:	ff d0                	call   *%rax
ffff80000010748a:	85 c0                	test   %eax,%eax
ffff80000010748c:	74 19                	je     ffff8000001074a7 <acquire+0x48>
    panic("acquire");
ffff80000010748e:	48 b8 b6 c3 10 00 00 	movabs $0xffff80000010c3b6,%rax
ffff800000107495:	80 ff ff 
ffff800000107498:	48 89 c7             	mov    %rax,%rdi
ffff80000010749b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001074a2:	80 ff ff 
ffff8000001074a5:	ff d0                	call   *%rax

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
ffff8000001074a7:	90                   	nop
ffff8000001074a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074ac:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001074b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001074b4:	48 b8 03 74 10 00 00 	movabs $0xffff800000107403,%rax
ffff8000001074bb:	80 ff ff 
ffff8000001074be:	ff d0                	call   *%rax
ffff8000001074c0:	85 c0                	test   %eax,%eax
ffff8000001074c2:	75 e4                	jne    ffff8000001074a8 <acquire+0x49>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
ffff8000001074c4:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
ffff8000001074ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074ce:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff8000001074d5:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff8000001074d9:	48 89 50 10          	mov    %rdx,0x10(%rax)
  getcallerpcs(&lk, lk->pcs);
ffff8000001074dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074e1:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff8000001074e5:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001074e9:	48 89 d6             	mov    %rdx,%rsi
ffff8000001074ec:	48 89 c7             	mov    %rax,%rdi
ffff8000001074ef:	48 b8 75 75 10 00 00 	movabs $0xffff800000107575,%rax
ffff8000001074f6:	80 ff ff 
ffff8000001074f9:	ff d0                	call   *%rax
}
ffff8000001074fb:	90                   	nop
ffff8000001074fc:	c9                   	leave
ffff8000001074fd:	c3                   	ret

ffff8000001074fe <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
ffff8000001074fe:	55                   	push   %rbp
ffff8000001074ff:	48 89 e5             	mov    %rsp,%rbp
ffff800000107502:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107506:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  if(!holding(lk))
ffff80000010750a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010750e:	48 89 c7             	mov    %rax,%rdi
ffff800000107511:	48 b8 43 76 10 00 00 	movabs $0xffff800000107643,%rax
ffff800000107518:	80 ff ff 
ffff80000010751b:	ff d0                	call   *%rax
ffff80000010751d:	85 c0                	test   %eax,%eax
ffff80000010751f:	75 19                	jne    ffff80000010753a <release+0x3c>
    panic("release");
ffff800000107521:	48 b8 be c3 10 00 00 	movabs $0xffff80000010c3be,%rax
ffff800000107528:	80 ff ff 
ffff80000010752b:	48 89 c7             	mov    %rax,%rdi
ffff80000010752e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107535:	80 ff ff 
ffff800000107538:	ff d0                	call   *%rax

  lk->pcs[0] = 0;
ffff80000010753a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010753e:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff800000107545:	00 
  lk->cpu = 0;
ffff800000107546:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010754a:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000107551:	00 
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
ffff800000107552:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
ffff800000107558:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010755c:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107560:	c7 00 00 00 00 00    	movl   $0x0,(%rax)

  popcli();
ffff800000107566:	48 b8 ed 76 10 00 00 	movabs $0xffff8000001076ed,%rax
ffff80000010756d:	80 ff ff 
ffff800000107570:	ff d0                	call   *%rax
}
ffff800000107572:	90                   	nop
ffff800000107573:	c9                   	leave
ffff800000107574:	c3                   	ret

ffff800000107575 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %rbp chain.
void
getcallerpcs(void *v, addr_t pcs[])
{
ffff800000107575:	55                   	push   %rbp
ffff800000107576:	48 89 e5             	mov    %rsp,%rbp
ffff800000107579:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010757d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107581:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  addr_t *rbp;

  asm volatile("mov %%rbp, %0" : "=r" (rbp));
ffff800000107585:	48 89 e8             	mov    %rbp,%rax
ffff800000107588:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  getstackpcs(rbp, pcs);
ffff80000010758c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107590:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107594:	48 89 d6             	mov    %rdx,%rsi
ffff800000107597:	48 89 c7             	mov    %rax,%rdi
ffff80000010759a:	48 b8 a9 75 10 00 00 	movabs $0xffff8000001075a9,%rax
ffff8000001075a1:	80 ff ff 
ffff8000001075a4:	ff d0                	call   *%rax
}
ffff8000001075a6:	90                   	nop
ffff8000001075a7:	c9                   	leave
ffff8000001075a8:	c3                   	ret

ffff8000001075a9 <getstackpcs>:

void
getstackpcs(addr_t *rbp, addr_t pcs[])
{
ffff8000001075a9:	55                   	push   %rbp
ffff8000001075aa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001075ad:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001075b1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001075b5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 0; i < 10; i++){
ffff8000001075b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001075c0:	eb 50                	jmp    ffff800000107612 <getstackpcs+0x69>
    if(rbp == 0 || rbp < (addr_t*)KERNBASE || rbp == (addr_t*)0xffffffff)
ffff8000001075c2:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001075c7:	74 70                	je     ffff800000107639 <getstackpcs+0x90>
ffff8000001075c9:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff8000001075d0:	7f ff ff 
ffff8000001075d3:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff8000001075d7:	73 60                	jae    ffff800000107639 <getstackpcs+0x90>
ffff8000001075d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001075de:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff8000001075e2:	74 55                	je     ffff800000107639 <getstackpcs+0x90>
      break;
    pcs[i] = rbp[1];     // saved %rip
ffff8000001075e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001075e7:	48 98                	cltq
ffff8000001075e9:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001075f0:	00 
ffff8000001075f1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001075f5:	48 01 c2             	add    %rax,%rdx
ffff8000001075f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001075fc:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000107600:	48 89 02             	mov    %rax,(%rdx)
    rbp = (addr_t*)rbp[0]; // saved %rbp
ffff800000107603:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107607:	48 8b 00             	mov    (%rax),%rax
ffff80000010760a:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  for(i = 0; i < 10; i++){
ffff80000010760e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107612:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107616:	7e aa                	jle    ffff8000001075c2 <getstackpcs+0x19>
  }
  for(; i < 10; i++)
ffff800000107618:	eb 1f                	jmp    ffff800000107639 <getstackpcs+0x90>
    pcs[i] = 0;
ffff80000010761a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010761d:	48 98                	cltq
ffff80000010761f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000107626:	00 
ffff800000107627:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010762b:	48 01 d0             	add    %rdx,%rax
ffff80000010762e:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; i < 10; i++)
ffff800000107635:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107639:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff80000010763d:	7e db                	jle    ffff80000010761a <getstackpcs+0x71>
}
ffff80000010763f:	90                   	nop
ffff800000107640:	90                   	nop
ffff800000107641:	c9                   	leave
ffff800000107642:	c3                   	ret

ffff800000107643 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
ffff800000107643:	55                   	push   %rbp
ffff800000107644:	48 89 e5             	mov    %rsp,%rbp
ffff800000107647:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010764b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return lock->locked && lock->cpu == cpu;
ffff80000010764f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107653:	8b 00                	mov    (%rax),%eax
ffff800000107655:	85 c0                	test   %eax,%eax
ffff800000107657:	74 1f                	je     ffff800000107678 <holding+0x35>
ffff800000107659:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010765d:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff800000107661:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107668:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010766c:	48 39 c2             	cmp    %rax,%rdx
ffff80000010766f:	75 07                	jne    ffff800000107678 <holding+0x35>
ffff800000107671:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000107676:	eb 05                	jmp    ffff80000010767d <holding+0x3a>
ffff800000107678:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010767d:	c9                   	leave
ffff80000010767e:	c3                   	ret

ffff80000010767f <pushcli>:
// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.
void
pushcli(void)
{
ffff80000010767f:	55                   	push   %rbp
ffff800000107680:	48 89 e5             	mov    %rsp,%rbp
ffff800000107683:	48 83 ec 10          	sub    $0x10,%rsp
  int eflags;

  eflags = readeflags();
ffff800000107687:	48 b8 df 73 10 00 00 	movabs $0xffff8000001073df,%rax
ffff80000010768e:	80 ff ff 
ffff800000107691:	ff d0                	call   *%rax
ffff800000107693:	89 45 fc             	mov    %eax,-0x4(%rbp)
  cli();
ffff800000107696:	48 b8 f3 73 10 00 00 	movabs $0xffff8000001073f3,%rax
ffff80000010769d:	80 ff ff 
ffff8000001076a0:	ff d0                	call   *%rax
  if(cpu->ncli == 0)
ffff8000001076a2:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001076a9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076ad:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001076b0:	85 c0                	test   %eax,%eax
ffff8000001076b2:	75 17                	jne    ffff8000001076cb <pushcli+0x4c>
    cpu->intena = eflags & FL_IF;
ffff8000001076b4:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001076bb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076bf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001076c2:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff8000001076c8:	89 50 18             	mov    %edx,0x18(%rax)
  cpu->ncli += 1;
ffff8000001076cb:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001076d2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076d6:	8b 50 14             	mov    0x14(%rax),%edx
ffff8000001076d9:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001076e0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001076e4:	83 c2 01             	add    $0x1,%edx
ffff8000001076e7:	89 50 14             	mov    %edx,0x14(%rax)
}
ffff8000001076ea:	90                   	nop
ffff8000001076eb:	c9                   	leave
ffff8000001076ec:	c3                   	ret

ffff8000001076ed <popcli>:

void
popcli(void)
{
ffff8000001076ed:	55                   	push   %rbp
ffff8000001076ee:	48 89 e5             	mov    %rsp,%rbp
  if(readeflags()&FL_IF)
ffff8000001076f1:	48 b8 df 73 10 00 00 	movabs $0xffff8000001073df,%rax
ffff8000001076f8:	80 ff ff 
ffff8000001076fb:	ff d0                	call   *%rax
ffff8000001076fd:	25 00 02 00 00       	and    $0x200,%eax
ffff800000107702:	48 85 c0             	test   %rax,%rax
ffff800000107705:	74 19                	je     ffff800000107720 <popcli+0x33>
    panic("popcli - interruptible");
ffff800000107707:	48 b8 c6 c3 10 00 00 	movabs $0xffff80000010c3c6,%rax
ffff80000010770e:	80 ff ff 
ffff800000107711:	48 89 c7             	mov    %rax,%rdi
ffff800000107714:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010771b:	80 ff ff 
ffff80000010771e:	ff d0                	call   *%rax
  if(--cpu->ncli < 0)
ffff800000107720:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107727:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010772b:	8b 50 14             	mov    0x14(%rax),%edx
ffff80000010772e:	83 ea 01             	sub    $0x1,%edx
ffff800000107731:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000107734:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107737:	85 c0                	test   %eax,%eax
ffff800000107739:	79 19                	jns    ffff800000107754 <popcli+0x67>
    panic("popcli");
ffff80000010773b:	48 b8 dd c3 10 00 00 	movabs $0xffff80000010c3dd,%rax
ffff800000107742:	80 ff ff 
ffff800000107745:	48 89 c7             	mov    %rax,%rdi
ffff800000107748:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010774f:	80 ff ff 
ffff800000107752:	ff d0                	call   *%rax
  if(cpu->ncli == 0 && cpu->intena)
ffff800000107754:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010775b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010775f:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000107762:	85 c0                	test   %eax,%eax
ffff800000107764:	75 1e                	jne    ffff800000107784 <popcli+0x97>
ffff800000107766:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010776d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107771:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107774:	85 c0                	test   %eax,%eax
ffff800000107776:	74 0c                	je     ffff800000107784 <popcli+0x97>
    sti();
ffff800000107778:	48 b8 fb 73 10 00 00 	movabs $0xffff8000001073fb,%rax
ffff80000010777f:	80 ff ff 
ffff800000107782:	ff d0                	call   *%rax
}
ffff800000107784:	90                   	nop
ffff800000107785:	5d                   	pop    %rbp
ffff800000107786:	c3                   	ret

ffff800000107787 <stosb>:
ffff800000107787:	55                   	push   %rbp
ffff800000107788:	48 89 e5             	mov    %rsp,%rbp
ffff80000010778b:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010778f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107793:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107796:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff800000107799:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010779d:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff8000001077a0:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001077a3:	48 89 ce             	mov    %rcx,%rsi
ffff8000001077a6:	48 89 f7             	mov    %rsi,%rdi
ffff8000001077a9:	89 d1                	mov    %edx,%ecx
ffff8000001077ab:	fc                   	cld
ffff8000001077ac:	f3 aa                	rep stos %al,(%rdi)
ffff8000001077ae:	89 ca                	mov    %ecx,%edx
ffff8000001077b0:	48 89 fe             	mov    %rdi,%rsi
ffff8000001077b3:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff8000001077b7:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff8000001077ba:	90                   	nop
ffff8000001077bb:	c9                   	leave
ffff8000001077bc:	c3                   	ret

ffff8000001077bd <stosl>:
ffff8000001077bd:	55                   	push   %rbp
ffff8000001077be:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077c1:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001077c5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001077c9:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff8000001077cc:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff8000001077cf:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001077d3:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff8000001077d6:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001077d9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001077dc:	48 89 f7             	mov    %rsi,%rdi
ffff8000001077df:	89 d1                	mov    %edx,%ecx
ffff8000001077e1:	fc                   	cld
ffff8000001077e2:	f3 ab                	rep stos %eax,(%rdi)
ffff8000001077e4:	89 ca                	mov    %ecx,%edx
ffff8000001077e6:	48 89 fe             	mov    %rdi,%rsi
ffff8000001077e9:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff8000001077ed:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff8000001077f0:	90                   	nop
ffff8000001077f1:	c9                   	leave
ffff8000001077f2:	c3                   	ret

ffff8000001077f3 <memset>:
ffff8000001077f3:	55                   	push   %rbp
ffff8000001077f4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077f7:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001077fb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001077ff:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107802:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107806:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010780a:	83 e0 03             	and    $0x3,%eax
ffff80000010780d:	48 85 c0             	test   %rax,%rax
ffff800000107810:	75 53                	jne    ffff800000107865 <memset+0x72>
ffff800000107812:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107816:	83 e0 03             	and    $0x3,%eax
ffff800000107819:	48 85 c0             	test   %rax,%rax
ffff80000010781c:	75 47                	jne    ffff800000107865 <memset+0x72>
ffff80000010781e:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
ffff800000107825:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107829:	48 c1 e8 02          	shr    $0x2,%rax
ffff80000010782d:	89 c6                	mov    %eax,%esi
ffff80000010782f:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107832:	c1 e0 18             	shl    $0x18,%eax
ffff800000107835:	89 c2                	mov    %eax,%edx
ffff800000107837:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010783a:	c1 e0 10             	shl    $0x10,%eax
ffff80000010783d:	09 c2                	or     %eax,%edx
ffff80000010783f:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107842:	c1 e0 08             	shl    $0x8,%eax
ffff800000107845:	09 d0                	or     %edx,%eax
ffff800000107847:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff80000010784a:	89 c1                	mov    %eax,%ecx
ffff80000010784c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107850:	89 f2                	mov    %esi,%edx
ffff800000107852:	89 ce                	mov    %ecx,%esi
ffff800000107854:	48 89 c7             	mov    %rax,%rdi
ffff800000107857:	48 b8 bd 77 10 00 00 	movabs $0xffff8000001077bd,%rax
ffff80000010785e:	80 ff ff 
ffff800000107861:	ff d0                	call   *%rax
ffff800000107863:	eb 1e                	jmp    ffff800000107883 <memset+0x90>
ffff800000107865:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107869:	89 c2                	mov    %eax,%edx
ffff80000010786b:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff80000010786e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107872:	89 ce                	mov    %ecx,%esi
ffff800000107874:	48 89 c7             	mov    %rax,%rdi
ffff800000107877:	48 b8 87 77 10 00 00 	movabs $0xffff800000107787,%rax
ffff80000010787e:	80 ff ff 
ffff800000107881:	ff d0                	call   *%rax
ffff800000107883:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107887:	c9                   	leave
ffff800000107888:	c3                   	ret

ffff800000107889 <memcmp>:
ffff800000107889:	55                   	push   %rbp
ffff80000010788a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010788d:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107891:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107895:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107899:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff80000010789c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001078a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001078a4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001078a8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001078ac:	eb 34                	jmp    ffff8000001078e2 <memcmp+0x59>
ffff8000001078ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078b2:	0f b6 10             	movzbl (%rax),%edx
ffff8000001078b5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001078b9:	0f b6 00             	movzbl (%rax),%eax
ffff8000001078bc:	38 c2                	cmp    %al,%dl
ffff8000001078be:	74 18                	je     ffff8000001078d8 <memcmp+0x4f>
ffff8000001078c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078c4:	0f b6 00             	movzbl (%rax),%eax
ffff8000001078c7:	0f b6 d0             	movzbl %al,%edx
ffff8000001078ca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001078ce:	0f b6 00             	movzbl (%rax),%eax
ffff8000001078d1:	0f b6 c0             	movzbl %al,%eax
ffff8000001078d4:	29 c2                	sub    %eax,%edx
ffff8000001078d6:	eb 1c                	jmp    ffff8000001078f4 <memcmp+0x6b>
ffff8000001078d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff8000001078dd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
ffff8000001078e2:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001078e5:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001078e8:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff8000001078eb:	85 c0                	test   %eax,%eax
ffff8000001078ed:	75 bf                	jne    ffff8000001078ae <memcmp+0x25>
ffff8000001078ef:	ba 00 00 00 00       	mov    $0x0,%edx
ffff8000001078f4:	89 d0                	mov    %edx,%eax
ffff8000001078f6:	c9                   	leave
ffff8000001078f7:	c3                   	ret

ffff8000001078f8 <memmove>:
ffff8000001078f8:	55                   	push   %rbp
ffff8000001078f9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078fc:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107900:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107904:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107908:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff80000010790b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010790f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107913:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107917:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010791b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010791f:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107923:	73 63                	jae    ffff800000107988 <memmove+0x90>
ffff800000107925:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000107928:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010792c:	48 01 d0             	add    %rdx,%rax
ffff80000010792f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107933:	73 53                	jae    ffff800000107988 <memmove+0x90>
ffff800000107935:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107938:	48 01 45 f8          	add    %rax,-0x8(%rbp)
ffff80000010793c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010793f:	48 01 45 f0          	add    %rax,-0x10(%rbp)
ffff800000107943:	eb 17                	jmp    ffff80000010795c <memmove+0x64>
ffff800000107945:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff80000010794a:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff80000010794f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107953:	0f b6 10             	movzbl (%rax),%edx
ffff800000107956:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010795a:	88 10                	mov    %dl,(%rax)
ffff80000010795c:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010795f:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107962:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107965:	85 c0                	test   %eax,%eax
ffff800000107967:	75 dc                	jne    ffff800000107945 <memmove+0x4d>
ffff800000107969:	eb 2a                	jmp    ffff800000107995 <memmove+0x9d>
ffff80000010796b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010796f:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107973:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107977:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010797b:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff80000010797f:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff800000107983:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107986:	88 10                	mov    %dl,(%rax)
ffff800000107988:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010798b:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff80000010798e:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107991:	85 c0                	test   %eax,%eax
ffff800000107993:	75 d6                	jne    ffff80000010796b <memmove+0x73>
ffff800000107995:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107999:	c9                   	leave
ffff80000010799a:	c3                   	ret

ffff80000010799b <memcpy>:
ffff80000010799b:	55                   	push   %rbp
ffff80000010799c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010799f:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001079a3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001079a7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001079ab:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff8000001079ae:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001079b1:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff8000001079b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079b9:	48 89 ce             	mov    %rcx,%rsi
ffff8000001079bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001079bf:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff8000001079c6:	80 ff ff 
ffff8000001079c9:	ff d0                	call   *%rax
ffff8000001079cb:	c9                   	leave
ffff8000001079cc:	c3                   	ret

ffff8000001079cd <strncmp>:
ffff8000001079cd:	55                   	push   %rbp
ffff8000001079ce:	48 89 e5             	mov    %rsp,%rbp
ffff8000001079d1:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001079d5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001079d9:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001079dd:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff8000001079e0:	eb 0e                	jmp    ffff8000001079f0 <strncmp+0x23>
ffff8000001079e2:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff8000001079e6:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff8000001079eb:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
ffff8000001079f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff8000001079f4:	74 1d                	je     ffff800000107a13 <strncmp+0x46>
ffff8000001079f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001079fa:	0f b6 00             	movzbl (%rax),%eax
ffff8000001079fd:	84 c0                	test   %al,%al
ffff8000001079ff:	74 12                	je     ffff800000107a13 <strncmp+0x46>
ffff800000107a01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a05:	0f b6 10             	movzbl (%rax),%edx
ffff800000107a08:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107a0c:	0f b6 00             	movzbl (%rax),%eax
ffff800000107a0f:	38 c2                	cmp    %al,%dl
ffff800000107a11:	74 cf                	je     ffff8000001079e2 <strncmp+0x15>
ffff800000107a13:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107a17:	75 07                	jne    ffff800000107a20 <strncmp+0x53>
ffff800000107a19:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107a1e:	eb 16                	jmp    ffff800000107a36 <strncmp+0x69>
ffff800000107a20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a24:	0f b6 00             	movzbl (%rax),%eax
ffff800000107a27:	0f b6 d0             	movzbl %al,%edx
ffff800000107a2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107a2e:	0f b6 00             	movzbl (%rax),%eax
ffff800000107a31:	0f b6 c0             	movzbl %al,%eax
ffff800000107a34:	29 c2                	sub    %eax,%edx
ffff800000107a36:	89 d0                	mov    %edx,%eax
ffff800000107a38:	c9                   	leave
ffff800000107a39:	c3                   	ret

ffff800000107a3a <strncpy>:
ffff800000107a3a:	55                   	push   %rbp
ffff800000107a3b:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a3e:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107a42:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107a46:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107a4a:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107a4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a51:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107a55:	90                   	nop
ffff800000107a56:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107a59:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107a5c:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107a5f:	85 c0                	test   %eax,%eax
ffff800000107a61:	7e 35                	jle    ffff800000107a98 <strncpy+0x5e>
ffff800000107a63:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107a67:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107a6b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107a6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a73:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107a77:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107a7b:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107a7e:	88 10                	mov    %dl,(%rax)
ffff800000107a80:	0f b6 00             	movzbl (%rax),%eax
ffff800000107a83:	84 c0                	test   %al,%al
ffff800000107a85:	75 cf                	jne    ffff800000107a56 <strncpy+0x1c>
ffff800000107a87:	eb 0f                	jmp    ffff800000107a98 <strncpy+0x5e>
ffff800000107a89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a8d:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000107a91:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107a95:	c6 00 00             	movb   $0x0,(%rax)
ffff800000107a98:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107a9b:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107a9e:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107aa1:	85 c0                	test   %eax,%eax
ffff800000107aa3:	7f e4                	jg     ffff800000107a89 <strncpy+0x4f>
ffff800000107aa5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107aa9:	c9                   	leave
ffff800000107aaa:	c3                   	ret

ffff800000107aab <safestrcpy>:
ffff800000107aab:	55                   	push   %rbp
ffff800000107aac:	48 89 e5             	mov    %rsp,%rbp
ffff800000107aaf:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107ab3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107ab7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107abb:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107abe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107ac2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107ac6:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107aca:	7f 06                	jg     ffff800000107ad2 <safestrcpy+0x27>
ffff800000107acc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ad0:	eb 3a                	jmp    ffff800000107b0c <safestrcpy+0x61>
ffff800000107ad2:	90                   	nop
ffff800000107ad3:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000107ad7:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107adb:	7e 24                	jle    ffff800000107b01 <safestrcpy+0x56>
ffff800000107add:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107ae1:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107ae5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107ae9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107aed:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107af1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107af5:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107af8:	88 10                	mov    %dl,(%rax)
ffff800000107afa:	0f b6 00             	movzbl (%rax),%eax
ffff800000107afd:	84 c0                	test   %al,%al
ffff800000107aff:	75 d2                	jne    ffff800000107ad3 <safestrcpy+0x28>
ffff800000107b01:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b05:	c6 00 00             	movb   $0x0,(%rax)
ffff800000107b08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b0c:	c9                   	leave
ffff800000107b0d:	c3                   	ret

ffff800000107b0e <strlen>:
ffff800000107b0e:	55                   	push   %rbp
ffff800000107b0f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b12:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107b16:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107b21:	eb 04                	jmp    ffff800000107b27 <strlen+0x19>
ffff800000107b23:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107b27:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107b2a:	48 63 d0             	movslq %eax,%rdx
ffff800000107b2d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b31:	48 01 d0             	add    %rdx,%rax
ffff800000107b34:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b37:	84 c0                	test   %al,%al
ffff800000107b39:	75 e8                	jne    ffff800000107b23 <strlen+0x15>
ffff800000107b3b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107b3e:	c9                   	leave
ffff800000107b3f:	c3                   	ret

ffff800000107b40 <swtch>:
ffff800000107b40:	55                   	push   %rbp
ffff800000107b41:	53                   	push   %rbx
ffff800000107b42:	41 54                	push   %r12
ffff800000107b44:	41 55                	push   %r13
ffff800000107b46:	41 56                	push   %r14
ffff800000107b48:	41 57                	push   %r15
ffff800000107b4a:	48 89 27             	mov    %rsp,(%rdi)
ffff800000107b4d:	48 89 f4             	mov    %rsi,%rsp
ffff800000107b50:	41 5f                	pop    %r15
ffff800000107b52:	41 5e                	pop    %r14
ffff800000107b54:	41 5d                	pop    %r13
ffff800000107b56:	41 5c                	pop    %r12
ffff800000107b58:	5b                   	pop    %rbx
ffff800000107b59:	5d                   	pop    %rbp
ffff800000107b5a:	c3                   	ret

ffff800000107b5b <fetchint>:
#include "trace.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff800000107b5b:	55                   	push   %rbp
ffff800000107b5c:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b5f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107b63:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107b67:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff800000107b6b:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107b72:	00 
ffff800000107b73:	76 2f                	jbe    ffff800000107ba4 <fetchint+0x49>
ffff800000107b75:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107b7c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b80:	48 8b 00             	mov    (%rax),%rax
ffff800000107b83:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107b87:	73 1b                	jae    ffff800000107ba4 <fetchint+0x49>
ffff800000107b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b8d:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000107b91:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107b98:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107b9c:	48 8b 00             	mov    (%rax),%rax
ffff800000107b9f:	48 39 d0             	cmp    %rdx,%rax
ffff800000107ba2:	73 07                	jae    ffff800000107bab <fetchint+0x50>
    return -1;
ffff800000107ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107ba9:	eb 11                	jmp    ffff800000107bbc <fetchint+0x61>
  *ip = *(int*)(addr);
ffff800000107bab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107baf:	8b 10                	mov    (%rax),%edx
ffff800000107bb1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107bb5:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000107bb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107bbc:	c9                   	leave
ffff800000107bbd:	c3                   	ret

ffff800000107bbe <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff800000107bbe:	55                   	push   %rbp
ffff800000107bbf:	48 89 e5             	mov    %rsp,%rbp
ffff800000107bc2:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107bc6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107bca:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff800000107bce:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107bd5:	00 
ffff800000107bd6:	76 2f                	jbe    ffff800000107c07 <fetchaddr+0x49>
ffff800000107bd8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107bdf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107be3:	48 8b 00             	mov    (%rax),%rax
ffff800000107be6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107bea:	73 1b                	jae    ffff800000107c07 <fetchaddr+0x49>
ffff800000107bec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bf0:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107bf4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107bfb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107bff:	48 8b 00             	mov    (%rax),%rax
ffff800000107c02:	48 39 d0             	cmp    %rdx,%rax
ffff800000107c05:	73 07                	jae    ffff800000107c0e <fetchaddr+0x50>
    return -1;
ffff800000107c07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107c0c:	eb 13                	jmp    ffff800000107c21 <fetchaddr+0x63>
  *ip = *(addr_t*)(addr);
ffff800000107c0e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c12:	48 8b 10             	mov    (%rax),%rdx
ffff800000107c15:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c19:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000107c1c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107c21:	c9                   	leave
ffff800000107c22:	c3                   	ret

ffff800000107c23 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff800000107c23:	55                   	push   %rbp
ffff800000107c24:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c27:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107c2b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107c2f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff800000107c33:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff800000107c3a:	00 
ffff800000107c3b:	76 14                	jbe    ffff800000107c51 <fetchstr+0x2e>
ffff800000107c3d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107c44:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c48:	48 8b 00             	mov    (%rax),%rax
ffff800000107c4b:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107c4f:	72 07                	jb     ffff800000107c58 <fetchstr+0x35>
    return -1;
ffff800000107c51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107c56:	eb 5b                	jmp    ffff800000107cb3 <fetchstr+0x90>
  *pp = (char*)addr;
ffff800000107c58:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107c5c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107c60:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff800000107c63:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107c6a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107c6e:	48 8b 00             	mov    (%rax),%rax
ffff800000107c71:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff800000107c75:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107c79:	48 8b 00             	mov    (%rax),%rax
ffff800000107c7c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107c80:	eb 22                	jmp    ffff800000107ca4 <fetchstr+0x81>
    if(*s == 0)
ffff800000107c82:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c86:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c89:	84 c0                	test   %al,%al
ffff800000107c8b:	75 12                	jne    ffff800000107c9f <fetchstr+0x7c>
      return s - *pp;
ffff800000107c8d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107c91:	48 8b 00             	mov    (%rax),%rax
ffff800000107c94:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107c98:	48 29 c2             	sub    %rax,%rdx
ffff800000107c9b:	89 d0                	mov    %edx,%eax
ffff800000107c9d:	eb 14                	jmp    ffff800000107cb3 <fetchstr+0x90>
  for(s = *pp; s < ep; s++)
ffff800000107c9f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ca8:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107cac:	72 d4                	jb     ffff800000107c82 <fetchstr+0x5f>
  return -1;
ffff800000107cae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107cb3:	c9                   	leave
ffff800000107cb4:	c3                   	ret

ffff800000107cb5 <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff800000107cb5:	55                   	push   %rbp
ffff800000107cb6:	48 89 e5             	mov    %rsp,%rbp
ffff800000107cb9:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107cbd:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff800000107cc0:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107cc4:	0f 84 bb 00 00 00    	je     ffff800000107d85 <fetcharg+0xd0>
ffff800000107cca:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107cce:	0f 8f c6 00 00 00    	jg     ffff800000107d9a <fetcharg+0xe5>
ffff800000107cd4:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107cd8:	0f 84 92 00 00 00    	je     ffff800000107d70 <fetcharg+0xbb>
ffff800000107cde:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107ce2:	0f 8f b2 00 00 00    	jg     ffff800000107d9a <fetcharg+0xe5>
ffff800000107ce8:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107cec:	74 6d                	je     ffff800000107d5b <fetcharg+0xa6>
ffff800000107cee:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107cf2:	0f 8f a2 00 00 00    	jg     ffff800000107d9a <fetcharg+0xe5>
ffff800000107cf8:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107cfc:	74 48                	je     ffff800000107d46 <fetcharg+0x91>
ffff800000107cfe:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107d02:	0f 8f 92 00 00 00    	jg     ffff800000107d9a <fetcharg+0xe5>
ffff800000107d08:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000107d0c:	74 0b                	je     ffff800000107d19 <fetcharg+0x64>
ffff800000107d0e:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000107d12:	74 1d                	je     ffff800000107d31 <fetcharg+0x7c>
ffff800000107d14:	e9 81 00 00 00       	jmp    ffff800000107d9a <fetcharg+0xe5>
  case 0: return proc->tf->rdi;
ffff800000107d19:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d20:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d24:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d28:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107d2c:	e9 82 00 00 00       	jmp    ffff800000107db3 <fetcharg+0xfe>
  case 1: return proc->tf->rsi;
ffff800000107d31:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d38:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d3c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d40:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d44:	eb 6d                	jmp    ffff800000107db3 <fetcharg+0xfe>
  case 2: return proc->tf->rdx;
ffff800000107d46:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d4d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d51:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d55:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000107d59:	eb 58                	jmp    ffff800000107db3 <fetcharg+0xfe>
  case 3: return proc->tf->r10;
ffff800000107d5b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d62:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d66:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d6a:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff800000107d6e:	eb 43                	jmp    ffff800000107db3 <fetcharg+0xfe>
  case 4: return proc->tf->r8;
ffff800000107d70:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d77:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d7b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d7f:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000107d83:	eb 2e                	jmp    ffff800000107db3 <fetcharg+0xfe>
  case 5: return proc->tf->r9;
ffff800000107d85:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107d8c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107d90:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107d94:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff800000107d98:	eb 19                	jmp    ffff800000107db3 <fetcharg+0xfe>
  }
  panic("failed fetch");
ffff800000107d9a:	48 b8 e4 c3 10 00 00 	movabs $0xffff80000010c3e4,%rax
ffff800000107da1:	80 ff ff 
ffff800000107da4:	48 89 c7             	mov    %rax,%rdi
ffff800000107da7:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107dae:	80 ff ff 
ffff800000107db1:	ff d0                	call   *%rax
}
ffff800000107db3:	c9                   	leave
ffff800000107db4:	c3                   	ret

ffff800000107db5 <argint>:

int
argint(int n, int *ip)
{
ffff800000107db5:	55                   	push   %rbp
ffff800000107db6:	48 89 e5             	mov    %rsp,%rbp
ffff800000107db9:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107dbd:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000107dc0:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000107dc4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107dc7:	89 c7                	mov    %eax,%edi
ffff800000107dc9:	48 b8 b5 7c 10 00 00 	movabs $0xffff800000107cb5,%rax
ffff800000107dd0:	80 ff ff 
ffff800000107dd3:	ff d0                	call   *%rax
ffff800000107dd5:	89 c2                	mov    %eax,%edx
ffff800000107dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107ddb:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000107ddd:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107de2:	c9                   	leave
ffff800000107de3:	c3                   	ret

ffff800000107de4 <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff800000107de4:	55                   	push   %rbp
ffff800000107de5:	48 89 e5             	mov    %rsp,%rbp
ffff800000107de8:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107dec:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000107def:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff800000107df3:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107df6:	89 c7                	mov    %eax,%edi
ffff800000107df8:	48 b8 b5 7c 10 00 00 	movabs $0xffff800000107cb5,%rax
ffff800000107dff:	80 ff ff 
ffff800000107e02:	ff d0                	call   *%rax
ffff800000107e04:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000107e08:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff800000107e0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e10:	c9                   	leave
ffff800000107e11:	c3                   	ret

ffff800000107e12 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff800000107e12:	55                   	push   %rbp
ffff800000107e13:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e16:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107e1a:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000107e1d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107e21:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff800000107e24:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff800000107e28:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000107e2b:	48 89 d6             	mov    %rdx,%rsi
ffff800000107e2e:	89 c7                	mov    %eax,%edi
ffff800000107e30:	48 b8 e4 7d 10 00 00 	movabs $0xffff800000107de4,%rax
ffff800000107e37:	80 ff ff 
ffff800000107e3a:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff800000107e3c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff800000107e40:	78 39                	js     ffff800000107e7b <argptr+0x69>
ffff800000107e42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e46:	89 c2                	mov    %eax,%edx
ffff800000107e48:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e4f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e53:	48 8b 00             	mov    (%rax),%rax
ffff800000107e56:	48 39 c2             	cmp    %rax,%rdx
ffff800000107e59:	73 20                	jae    ffff800000107e7b <argptr+0x69>
ffff800000107e5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e5f:	89 c2                	mov    %eax,%edx
ffff800000107e61:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000107e64:	01 d0                	add    %edx,%eax
ffff800000107e66:	89 c2                	mov    %eax,%edx
ffff800000107e68:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e6f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e73:	48 8b 00             	mov    (%rax),%rax
ffff800000107e76:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e79:	73 09                	jae    ffff800000107e84 <argptr+0x72>
    return -1;
ffff800000107e7b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000107e82:	eb 13                	jmp    ffff800000107e97 <argptr+0x85>
  *pp = (char*)i;
ffff800000107e84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e88:	48 89 c2             	mov    %rax,%rdx
ffff800000107e8b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107e8f:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000107e92:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e97:	c9                   	leave
ffff800000107e98:	c3                   	ret

ffff800000107e99 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff800000107e99:	55                   	push   %rbp
ffff800000107e9a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e9d:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107ea1:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000107ea4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff800000107ea8:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff800000107eac:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000107eaf:	48 89 d6             	mov    %rdx,%rsi
ffff800000107eb2:	89 c7                	mov    %eax,%edi
ffff800000107eb4:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000107ebb:	80 ff ff 
ffff800000107ebe:	ff d0                	call   *%rax
ffff800000107ec0:	85 c0                	test   %eax,%eax
ffff800000107ec2:	79 07                	jns    ffff800000107ecb <argstr+0x32>
    return -1;
ffff800000107ec4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107ec9:	eb 1b                	jmp    ffff800000107ee6 <argstr+0x4d>
  return fetchstr(addr, pp);
ffff800000107ecb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107ece:	48 98                	cltq
ffff800000107ed0:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107ed4:	48 89 d6             	mov    %rdx,%rsi
ffff800000107ed7:	48 89 c7             	mov    %rax,%rdi
ffff800000107eda:	48 b8 23 7c 10 00 00 	movabs $0xffff800000107c23,%rax
ffff800000107ee1:	80 ff ff 
ffff800000107ee4:	ff d0                	call   *%rax
}
ffff800000107ee6:	c9                   	leave
ffff800000107ee7:	c3                   	ret

ffff800000107ee8 <syscall>:
  [SYS_traceread] "traceread",
};

void
syscall(struct trapframe *tf)
{
ffff800000107ee8:	55                   	push   %rbp
ffff800000107ee9:	48 89 e5             	mov    %rsp,%rbp
ffff800000107eec:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107ef0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  proc->tf = tf;
ffff800000107ef4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107efb:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107eff:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107f03:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff800000107f07:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f0e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f12:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107f16:	48 8b 00             	mov    (%rax),%rax
ffff800000107f19:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff800000107f1d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000107f22:	0f 84 91 00 00 00    	je     ffff800000107fb9 <syscall+0xd1>
ffff800000107f28:	48 83 7d f8 16       	cmpq   $0x16,-0x8(%rbp)
ffff800000107f2d:	0f 87 86 00 00 00    	ja     ffff800000107fb9 <syscall+0xd1>
ffff800000107f33:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff800000107f3a:	80 ff ff 
ffff800000107f3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f41:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff800000107f45:	48 85 c0             	test   %rax,%rax
ffff800000107f48:	74 6f                	je     ffff800000107fb9 <syscall+0xd1>
    tf->rax = syscalls[num]();
ffff800000107f4a:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff800000107f51:	80 ff ff 
ffff800000107f54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f58:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff800000107f5c:	ff d0                	call   *%rax
ffff800000107f5e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107f62:	48 89 02             	mov    %rax,(%rdx)

    //call trace event function 
    if(num != SYS_traceread)
ffff800000107f65:	48 83 7d f8 16       	cmpq   $0x16,-0x8(%rbp)
ffff800000107f6a:	0f 84 9c 00 00 00    	je     ffff80000010800c <syscall+0x124>
      traceevent(TRACE_TYPE_SYSCALL, proc->pid, num, tf->rax, syscallnames[num]);
ffff800000107f70:	48 ba 60 d6 10 00 00 	movabs $0xffff80000010d660,%rdx
ffff800000107f77:	80 ff ff 
ffff800000107f7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f7e:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff800000107f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107f86:	48 8b 00             	mov    (%rax),%rax
ffff800000107f89:	89 c1                	mov    %eax,%ecx
ffff800000107f8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f8f:	89 c6                	mov    %eax,%esi
ffff800000107f91:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f98:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f9c:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000107f9f:	49 89 d0             	mov    %rdx,%r8
ffff800000107fa2:	89 f2                	mov    %esi,%edx
ffff800000107fa4:	89 c6                	mov    %eax,%esi
ffff800000107fa6:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000107fab:	48 b8 04 bd 10 00 00 	movabs $0xffff80000010bd04,%rax
ffff800000107fb2:	80 ff ff 
ffff800000107fb5:	ff d0                	call   *%rax
    if(num != SYS_traceread)
ffff800000107fb7:	eb 53                	jmp    ffff80000010800c <syscall+0x124>

    // DEBUG: Print the PID, system call number, and the return value from the syscall
    // cprintf("trace: pid %d syscall %s(%d) -> %d\n", proc->pid, syscallnames[num], num, tf->rax);
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff800000107fb9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fc0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fc4:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000107fcb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fd2:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff800000107fd6:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000107fd9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107fdd:	48 bf 70 c4 10 00 00 	movabs $0xffff80000010c470,%rdi
ffff800000107fe4:	80 ff ff 
ffff800000107fe7:	48 89 d1             	mov    %rdx,%rcx
ffff800000107fea:	48 89 f2             	mov    %rsi,%rdx
ffff800000107fed:	89 c6                	mov    %eax,%esi
ffff800000107fef:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107ff4:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000107ffb:	80 ff ff 
ffff800000107ffe:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff800000108001:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000108005:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
  }
  if (proc->killed)
ffff80000010800c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108013:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108017:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010801a:	85 c0                	test   %eax,%eax
ffff80000010801c:	74 0c                	je     ffff80000010802a <syscall+0x142>
    exit();
ffff80000010801e:	48 b8 d8 67 10 00 00 	movabs $0xffff8000001067d8,%rax
ffff800000108025:	80 ff ff 
ffff800000108028:	ff d0                	call   *%rax
}
ffff80000010802a:	90                   	nop
ffff80000010802b:	c9                   	leave
ffff80000010802c:	c3                   	ret

ffff80000010802d <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
ffff80000010802d:	55                   	push   %rbp
ffff80000010802e:	48 89 e5             	mov    %rsp,%rbp
ffff800000108031:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108035:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108038:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010803c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
ffff800000108040:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff800000108044:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108047:	48 89 d6             	mov    %rdx,%rsi
ffff80000010804a:	89 c7                	mov    %eax,%edi
ffff80000010804c:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000108053:	80 ff ff 
ffff800000108056:	ff d0                	call   *%rax
ffff800000108058:	85 c0                	test   %eax,%eax
ffff80000010805a:	79 07                	jns    ffff800000108063 <argfd+0x36>
    return -1;
ffff80000010805c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108061:	eb 62                	jmp    ffff8000001080c5 <argfd+0x98>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
ffff800000108063:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108066:	85 c0                	test   %eax,%eax
ffff800000108068:	78 2d                	js     ffff800000108097 <argfd+0x6a>
ffff80000010806a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010806d:	83 f8 0f             	cmp    $0xf,%eax
ffff800000108070:	7f 25                	jg     ffff800000108097 <argfd+0x6a>
ffff800000108072:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108079:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010807d:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108080:	48 63 d2             	movslq %edx,%rdx
ffff800000108083:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108087:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010808c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108090:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108095:	75 07                	jne    ffff80000010809e <argfd+0x71>
    return -1;
ffff800000108097:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010809c:	eb 27                	jmp    ffff8000001080c5 <argfd+0x98>
  if(pfd)
ffff80000010809e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff8000001080a3:	74 09                	je     ffff8000001080ae <argfd+0x81>
    *pfd = fd;
ffff8000001080a5:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001080a8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001080ac:	89 10                	mov    %edx,(%rax)
  if(pf)
ffff8000001080ae:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001080b3:	74 0b                	je     ffff8000001080c0 <argfd+0x93>
    *pf = f;
ffff8000001080b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001080b9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001080bd:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff8000001080c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001080c5:	c9                   	leave
ffff8000001080c6:	c3                   	ret

ffff8000001080c7 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
ffff8000001080c7:	55                   	push   %rbp
ffff8000001080c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001080cb:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001080cf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
ffff8000001080d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001080da:	eb 46                	jmp    ffff800000108122 <fdalloc+0x5b>
    if(proc->ofile[fd] == 0){
ffff8000001080dc:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080e3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080e7:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001080ea:	48 63 d2             	movslq %edx,%rdx
ffff8000001080ed:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001080f1:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001080f6:	48 85 c0             	test   %rax,%rax
ffff8000001080f9:	75 23                	jne    ffff80000010811e <fdalloc+0x57>
      proc->ofile[fd] = f;
ffff8000001080fb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108102:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108106:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108109:	48 63 d2             	movslq %edx,%rdx
ffff80000010810c:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff800000108110:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000108114:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
      return fd;
ffff800000108119:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010811c:	eb 0f                	jmp    ffff80000010812d <fdalloc+0x66>
  for(fd = 0; fd < NOFILE; fd++){
ffff80000010811e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000108122:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff800000108126:	7e b4                	jle    ffff8000001080dc <fdalloc+0x15>
    }
  }
  return -1;
ffff800000108128:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010812d:	c9                   	leave
ffff80000010812e:	c3                   	ret

ffff80000010812f <sys_dup>:

int
sys_dup(void)
{
ffff80000010812f:	55                   	push   %rbp
ffff800000108130:	48 89 e5             	mov    %rsp,%rbp
ffff800000108133:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
ffff800000108137:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010813b:	48 89 c2             	mov    %rax,%rdx
ffff80000010813e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108143:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108148:	48 b8 2d 80 10 00 00 	movabs $0xffff80000010802d,%rax
ffff80000010814f:	80 ff ff 
ffff800000108152:	ff d0                	call   *%rax
ffff800000108154:	85 c0                	test   %eax,%eax
ffff800000108156:	79 07                	jns    ffff80000010815f <sys_dup+0x30>
    return -1;
ffff800000108158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010815d:	eb 39                	jmp    ffff800000108198 <sys_dup+0x69>
  if((fd=fdalloc(f)) < 0)
ffff80000010815f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108163:	48 89 c7             	mov    %rax,%rdi
ffff800000108166:	48 b8 c7 80 10 00 00 	movabs $0xffff8000001080c7,%rax
ffff80000010816d:	80 ff ff 
ffff800000108170:	ff d0                	call   *%rax
ffff800000108172:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000108175:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000108179:	79 07                	jns    ffff800000108182 <sys_dup+0x53>
    return -1;
ffff80000010817b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108180:	eb 16                	jmp    ffff800000108198 <sys_dup+0x69>
  filedup(f);
ffff800000108182:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108186:	48 89 c7             	mov    %rax,%rdi
ffff800000108189:	48 b8 e5 1b 10 00 00 	movabs $0xffff800000101be5,%rax
ffff800000108190:	80 ff ff 
ffff800000108193:	ff d0                	call   *%rax
  return fd;
ffff800000108195:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff800000108198:	c9                   	leave
ffff800000108199:	c3                   	ret

ffff80000010819a <sys_read>:

int
sys_read(void)
{
ffff80000010819a:	55                   	push   %rbp
ffff80000010819b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010819e:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff8000001081a2:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001081a6:	48 89 c2             	mov    %rax,%rdx
ffff8000001081a9:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001081ae:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001081b3:	48 b8 2d 80 10 00 00 	movabs $0xffff80000010802d,%rax
ffff8000001081ba:	80 ff ff 
ffff8000001081bd:	ff d0                	call   *%rax
ffff8000001081bf:	85 c0                	test   %eax,%eax
ffff8000001081c1:	78 56                	js     ffff800000108219 <sys_read+0x7f>
ffff8000001081c3:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff8000001081c7:	48 89 c6             	mov    %rax,%rsi
ffff8000001081ca:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001081cf:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff8000001081d6:	80 ff ff 
ffff8000001081d9:	ff d0                	call   *%rax
ffff8000001081db:	85 c0                	test   %eax,%eax
ffff8000001081dd:	78 3a                	js     ffff800000108219 <sys_read+0x7f>
ffff8000001081df:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001081e2:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001081e6:	48 89 c6             	mov    %rax,%rsi
ffff8000001081e9:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001081ee:	48 b8 12 7e 10 00 00 	movabs $0xffff800000107e12,%rax
ffff8000001081f5:	80 ff ff 
ffff8000001081f8:	ff d0                	call   *%rax
    return -1;
  return fileread(f, p, n);
ffff8000001081fa:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001081fd:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108201:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108205:	48 89 ce             	mov    %rcx,%rsi
ffff800000108208:	48 89 c7             	mov    %rax,%rdi
ffff80000010820b:	48 b8 0f 1e 10 00 00 	movabs $0xffff800000101e0f,%rax
ffff800000108212:	80 ff ff 
ffff800000108215:	ff d0                	call   *%rax
ffff800000108217:	eb 05                	jmp    ffff80000010821e <sys_read+0x84>
    return -1;
ffff800000108219:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff80000010821e:	c9                   	leave
ffff80000010821f:	c3                   	ret

ffff800000108220 <sys_write>:

int
sys_write(void)
{
ffff800000108220:	55                   	push   %rbp
ffff800000108221:	48 89 e5             	mov    %rsp,%rbp
ffff800000108224:	48 83 ec 20          	sub    $0x20,%rsp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
ffff800000108228:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010822c:	48 89 c2             	mov    %rax,%rdx
ffff80000010822f:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108234:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108239:	48 b8 2d 80 10 00 00 	movabs $0xffff80000010802d,%rax
ffff800000108240:	80 ff ff 
ffff800000108243:	ff d0                	call   *%rax
ffff800000108245:	85 c0                	test   %eax,%eax
ffff800000108247:	78 56                	js     ffff80000010829f <sys_write+0x7f>
ffff800000108249:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff80000010824d:	48 89 c6             	mov    %rax,%rsi
ffff800000108250:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108255:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff80000010825c:	80 ff ff 
ffff80000010825f:	ff d0                	call   *%rax
ffff800000108261:	85 c0                	test   %eax,%eax
ffff800000108263:	78 3a                	js     ffff80000010829f <sys_write+0x7f>
ffff800000108265:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108268:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff80000010826c:	48 89 c6             	mov    %rax,%rsi
ffff80000010826f:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108274:	48 b8 12 7e 10 00 00 	movabs $0xffff800000107e12,%rax
ffff80000010827b:	80 ff ff 
ffff80000010827e:	ff d0                	call   *%rax
    return -1;
  return filewrite(f, p, n);
ffff800000108280:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108283:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108287:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010828b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010828e:	48 89 c7             	mov    %rax,%rdi
ffff800000108291:	48 b8 03 1f 10 00 00 	movabs $0xffff800000101f03,%rax
ffff800000108298:	80 ff ff 
ffff80000010829b:	ff d0                	call   *%rax
ffff80000010829d:	eb 05                	jmp    ffff8000001082a4 <sys_write+0x84>
    return -1;
ffff80000010829f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001082a4:	c9                   	leave
ffff8000001082a5:	c3                   	ret

ffff8000001082a6 <sys_close>:

int
sys_close(void)
{
ffff8000001082a6:	55                   	push   %rbp
ffff8000001082a7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001082aa:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
ffff8000001082ae:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff8000001082b2:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff8000001082b6:	48 89 c6             	mov    %rax,%rsi
ffff8000001082b9:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001082be:	48 b8 2d 80 10 00 00 	movabs $0xffff80000010802d,%rax
ffff8000001082c5:	80 ff ff 
ffff8000001082c8:	ff d0                	call   *%rax
ffff8000001082ca:	85 c0                	test   %eax,%eax
ffff8000001082cc:	79 07                	jns    ffff8000001082d5 <sys_close+0x2f>
    return -1;
ffff8000001082ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001082d3:	eb 36                	jmp    ffff80000010830b <sys_close+0x65>
  proc->ofile[fd] = 0;
ffff8000001082d5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082dc:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082e0:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001082e3:	48 63 d2             	movslq %edx,%rdx
ffff8000001082e6:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001082ea:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff8000001082f1:	00 00 
  fileclose(f);
ffff8000001082f3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001082f7:	48 89 c7             	mov    %rax,%rdi
ffff8000001082fa:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000108301:	80 ff ff 
ffff800000108304:	ff d0                	call   *%rax
  return 0;
ffff800000108306:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010830b:	c9                   	leave
ffff80000010830c:	c3                   	ret

ffff80000010830d <sys_fstat>:

int
sys_fstat(void)
{
ffff80000010830d:	55                   	push   %rbp
ffff80000010830e:	48 89 e5             	mov    %rsp,%rbp
ffff800000108311:	48 83 ec 10          	sub    $0x10,%rsp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
ffff800000108315:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108319:	48 89 c2             	mov    %rax,%rdx
ffff80000010831c:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108321:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108326:	48 b8 2d 80 10 00 00 	movabs $0xffff80000010802d,%rax
ffff80000010832d:	80 ff ff 
ffff800000108330:	ff d0                	call   *%rax
ffff800000108332:	85 c0                	test   %eax,%eax
ffff800000108334:	78 39                	js     ffff80000010836f <sys_fstat+0x62>
ffff800000108336:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010833a:	ba 14 00 00 00       	mov    $0x14,%edx
ffff80000010833f:	48 89 c6             	mov    %rax,%rsi
ffff800000108342:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108347:	48 b8 12 7e 10 00 00 	movabs $0xffff800000107e12,%rax
ffff80000010834e:	80 ff ff 
ffff800000108351:	ff d0                	call   *%rax
    return -1;
  return filestat(f, st);
ffff800000108353:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108357:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010835b:	48 89 d6             	mov    %rdx,%rsi
ffff80000010835e:	48 89 c7             	mov    %rax,%rdi
ffff800000108361:	48 b8 9a 1d 10 00 00 	movabs $0xffff800000101d9a,%rax
ffff800000108368:	80 ff ff 
ffff80000010836b:	ff d0                	call   *%rax
ffff80000010836d:	eb 05                	jmp    ffff800000108374 <sys_fstat+0x67>
    return -1;
ffff80000010836f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108374:	c9                   	leave
ffff800000108375:	c3                   	ret

ffff800000108376 <isdirempty>:

static int
isdirempty(struct inode *dp)
{
ffff800000108376:	55                   	push   %rbp
ffff800000108377:	48 89 e5             	mov    %rsp,%rbp
ffff80000010837a:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010837e:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  int off;
  struct dirent de;
  // Is the directory dp empty except for "." and ".." ?
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff800000108382:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff800000108389:	eb 56                	jmp    ffff8000001083e1 <isdirempty+0x6b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff80000010838b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010838e:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108392:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108396:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010839b:	48 89 c7             	mov    %rax,%rdi
ffff80000010839e:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff8000001083a5:	80 ff ff 
ffff8000001083a8:	ff d0                	call   *%rax
ffff8000001083aa:	83 f8 10             	cmp    $0x10,%eax
ffff8000001083ad:	74 19                	je     ffff8000001083c8 <isdirempty+0x52>
      panic("isdirempty: readi");
ffff8000001083af:	48 b8 8c c4 10 00 00 	movabs $0xffff80000010c48c,%rax
ffff8000001083b6:	80 ff ff 
ffff8000001083b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001083bc:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001083c3:	80 ff ff 
ffff8000001083c6:	ff d0                	call   *%rax
    if(de.inum != 0)
ffff8000001083c8:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001083cc:	66 85 c0             	test   %ax,%ax
ffff8000001083cf:	74 07                	je     ffff8000001083d8 <isdirempty+0x62>
      return 0;
ffff8000001083d1:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001083d6:	eb 1f                	jmp    ffff8000001083f7 <isdirempty+0x81>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffff8000001083d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001083db:	83 c0 10             	add    $0x10,%eax
ffff8000001083de:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001083e1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001083e5:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001083eb:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001083ee:	39 c2                	cmp    %eax,%edx
ffff8000001083f0:	72 99                	jb     ffff80000010838b <isdirempty+0x15>
  }
  return 1;
ffff8000001083f2:	b8 01 00 00 00       	mov    $0x1,%eax
}
ffff8000001083f7:	c9                   	leave
ffff8000001083f8:	c3                   	ret

ffff8000001083f9 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
ffff8000001083f9:	55                   	push   %rbp
ffff8000001083fa:	48 89 e5             	mov    %rsp,%rbp
ffff8000001083fd:	48 83 ec 30          	sub    $0x30,%rsp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
ffff800000108401:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000108405:	48 89 c6             	mov    %rax,%rsi
ffff800000108408:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010840d:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108414:	80 ff ff 
ffff800000108417:	ff d0                	call   *%rax
ffff800000108419:	85 c0                	test   %eax,%eax
ffff80000010841b:	78 1c                	js     ffff800000108439 <sys_link+0x40>
ffff80000010841d:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff800000108421:	48 89 c6             	mov    %rax,%rsi
ffff800000108424:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108429:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108430:	80 ff ff 
ffff800000108433:	ff d0                	call   *%rax
ffff800000108435:	85 c0                	test   %eax,%eax
ffff800000108437:	79 0a                	jns    ffff800000108443 <sys_link+0x4a>
    return -1;
ffff800000108439:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010843e:	e9 f3 01 00 00       	jmp    ffff800000108636 <sys_link+0x23d>

  begin_op();
ffff800000108443:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff80000010844a:	80 ff ff 
ffff80000010844d:	ff d0                	call   *%rax
  if((ip = namei(old)) == 0){
ffff80000010844f:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000108453:	48 89 c7             	mov    %rax,%rdi
ffff800000108456:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff80000010845d:	80 ff ff 
ffff800000108460:	ff d0                	call   *%rax
ffff800000108462:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108466:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010846b:	75 16                	jne    ffff800000108483 <sys_link+0x8a>
    end_op();
ffff80000010846d:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108474:	80 ff ff 
ffff800000108477:	ff d0                	call   *%rax
    return -1;
ffff800000108479:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010847e:	e9 b3 01 00 00       	jmp    ffff800000108636 <sys_link+0x23d>
  }

  ilock(ip);
ffff800000108483:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108487:	48 89 c7             	mov    %rax,%rdi
ffff80000010848a:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108491:	80 ff ff 
ffff800000108494:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108496:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010849a:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001084a1:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001084a5:	75 29                	jne    ffff8000001084d0 <sys_link+0xd7>
    iunlockput(ip);
ffff8000001084a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084ab:	48 89 c7             	mov    %rax,%rdi
ffff8000001084ae:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001084b5:	80 ff ff 
ffff8000001084b8:	ff d0                	call   *%rax
    end_op();
ffff8000001084ba:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001084c1:	80 ff ff 
ffff8000001084c4:	ff d0                	call   *%rax
    return -1;
ffff8000001084c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001084cb:	e9 66 01 00 00       	jmp    ffff800000108636 <sys_link+0x23d>
  }

  ip->nlink++;
ffff8000001084d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084d4:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001084db:	83 c0 01             	add    $0x1,%eax
ffff8000001084de:	89 c2                	mov    %eax,%edx
ffff8000001084e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084e4:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff8000001084eb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084ef:	48 89 c7             	mov    %rax,%rdi
ffff8000001084f2:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff8000001084f9:	80 ff ff 
ffff8000001084fc:	ff d0                	call   *%rax
  iunlock(ip);
ffff8000001084fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108502:	48 89 c7             	mov    %rax,%rdi
ffff800000108505:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff80000010850c:	80 ff ff 
ffff80000010850f:	ff d0                	call   *%rax

  if((dp = nameiparent(new, name)) == 0)
ffff800000108511:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108515:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff800000108519:	48 89 d6             	mov    %rdx,%rsi
ffff80000010851c:	48 89 c7             	mov    %rax,%rdi
ffff80000010851f:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108526:	80 ff ff 
ffff800000108529:	ff d0                	call   *%rax
ffff80000010852b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010852f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108534:	0f 84 96 00 00 00    	je     ffff8000001085d0 <sys_link+0x1d7>
    goto bad;
  ilock(dp);
ffff80000010853a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010853e:	48 89 c7             	mov    %rax,%rdi
ffff800000108541:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108548:	80 ff ff 
ffff80000010854b:	ff d0                	call   *%rax
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffff80000010854d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108551:	8b 10                	mov    (%rax),%edx
ffff800000108553:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108557:	8b 00                	mov    (%rax),%eax
ffff800000108559:	39 c2                	cmp    %eax,%edx
ffff80000010855b:	75 25                	jne    ffff800000108582 <sys_link+0x189>
ffff80000010855d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108561:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108564:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff800000108568:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010856c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010856f:	48 89 c7             	mov    %rax,%rdi
ffff800000108572:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108579:	80 ff ff 
ffff80000010857c:	ff d0                	call   *%rax
ffff80000010857e:	85 c0                	test   %eax,%eax
ffff800000108580:	79 15                	jns    ffff800000108597 <sys_link+0x19e>
    iunlockput(dp);
ffff800000108582:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108586:	48 89 c7             	mov    %rax,%rdi
ffff800000108589:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108590:	80 ff ff 
ffff800000108593:	ff d0                	call   *%rax
    goto bad;
ffff800000108595:	eb 3a                	jmp    ffff8000001085d1 <sys_link+0x1d8>
  }
  iunlockput(dp);
ffff800000108597:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010859b:	48 89 c7             	mov    %rax,%rdi
ffff80000010859e:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001085a5:	80 ff ff 
ffff8000001085a8:	ff d0                	call   *%rax
  iput(ip);
ffff8000001085aa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001085b1:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff8000001085b8:	80 ff ff 
ffff8000001085bb:	ff d0                	call   *%rax

  end_op();
ffff8000001085bd:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001085c4:	80 ff ff 
ffff8000001085c7:	ff d0                	call   *%rax

  return 0;
ffff8000001085c9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001085ce:	eb 66                	jmp    ffff800000108636 <sys_link+0x23d>
    goto bad;
ffff8000001085d0:	90                   	nop

bad:
  ilock(ip);
ffff8000001085d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001085d8:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001085df:	80 ff ff 
ffff8000001085e2:	ff d0                	call   *%rax
  ip->nlink--;
ffff8000001085e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085e8:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001085ef:	83 e8 01             	sub    $0x1,%eax
ffff8000001085f2:	89 c2                	mov    %eax,%edx
ffff8000001085f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001085f8:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff8000001085ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108603:	48 89 c7             	mov    %rax,%rdi
ffff800000108606:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff80000010860d:	80 ff ff 
ffff800000108610:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108612:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108616:	48 89 c7             	mov    %rax,%rdi
ffff800000108619:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108620:	80 ff ff 
ffff800000108623:	ff d0                	call   *%rax
  end_op();
ffff800000108625:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff80000010862c:	80 ff ff 
ffff80000010862f:	ff d0                	call   *%rax
  return -1;
ffff800000108631:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000108636:	c9                   	leave
ffff800000108637:	c3                   	ret

ffff800000108638 <sys_unlink>:
//PAGEBREAK!

int
sys_unlink(void)
{
ffff800000108638:	55                   	push   %rbp
ffff800000108639:	48 89 e5             	mov    %rsp,%rbp
ffff80000010863c:	48 83 ec 40          	sub    $0x40,%rsp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
ffff800000108640:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff800000108644:	48 89 c6             	mov    %rax,%rsi
ffff800000108647:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010864c:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108653:	80 ff ff 
ffff800000108656:	ff d0                	call   *%rax
ffff800000108658:	85 c0                	test   %eax,%eax
ffff80000010865a:	79 0a                	jns    ffff800000108666 <sys_unlink+0x2e>
    return -1;
ffff80000010865c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108661:	e9 7b 02 00 00       	jmp    ffff8000001088e1 <sys_unlink+0x2a9>

  begin_op();
ffff800000108666:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff80000010866d:	80 ff ff 
ffff800000108670:	ff d0                	call   *%rax
  if((dp = nameiparent(path, name)) == 0){
ffff800000108672:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108676:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff80000010867a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010867d:	48 89 c7             	mov    %rax,%rdi
ffff800000108680:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108687:	80 ff ff 
ffff80000010868a:	ff d0                	call   *%rax
ffff80000010868c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108690:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108695:	75 16                	jne    ffff8000001086ad <sys_unlink+0x75>
    end_op();
ffff800000108697:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff80000010869e:	80 ff ff 
ffff8000001086a1:	ff d0                	call   *%rax
    return -1;
ffff8000001086a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001086a8:	e9 34 02 00 00       	jmp    ffff8000001088e1 <sys_unlink+0x2a9>
  }

  ilock(dp);
ffff8000001086ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001086b1:	48 89 c7             	mov    %rax,%rdi
ffff8000001086b4:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff8000001086bb:	80 ff ff 
ffff8000001086be:	ff d0                	call   *%rax

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
ffff8000001086c0:	48 ba 9e c4 10 00 00 	movabs $0xffff80000010c49e,%rdx
ffff8000001086c7:	80 ff ff 
ffff8000001086ca:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff8000001086ce:	48 89 d6             	mov    %rdx,%rsi
ffff8000001086d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001086d4:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff8000001086db:	80 ff ff 
ffff8000001086de:	ff d0                	call   *%rax
ffff8000001086e0:	85 c0                	test   %eax,%eax
ffff8000001086e2:	0f 84 d1 01 00 00    	je     ffff8000001088b9 <sys_unlink+0x281>
ffff8000001086e8:	48 ba a0 c4 10 00 00 	movabs $0xffff80000010c4a0,%rdx
ffff8000001086ef:	80 ff ff 
ffff8000001086f2:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff8000001086f6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001086f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001086fc:	48 b8 d2 32 10 00 00 	movabs $0xffff8000001032d2,%rax
ffff800000108703:	80 ff ff 
ffff800000108706:	ff d0                	call   *%rax
ffff800000108708:	85 c0                	test   %eax,%eax
ffff80000010870a:	0f 84 a9 01 00 00    	je     ffff8000001088b9 <sys_unlink+0x281>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
ffff800000108710:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff800000108714:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff800000108718:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010871c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010871f:	48 89 c7             	mov    %rax,%rdi
ffff800000108722:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff800000108729:	80 ff ff 
ffff80000010872c:	ff d0                	call   *%rax
ffff80000010872e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108732:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108737:	0f 84 7f 01 00 00    	je     ffff8000001088bc <sys_unlink+0x284>
    goto bad;
  ilock(ip);
ffff80000010873d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108741:	48 89 c7             	mov    %rax,%rdi
ffff800000108744:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010874b:	80 ff ff 
ffff80000010874e:	ff d0                	call   *%rax

  if(ip->nlink < 1)
ffff800000108750:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108754:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010875b:	66 85 c0             	test   %ax,%ax
ffff80000010875e:	7f 19                	jg     ffff800000108779 <sys_unlink+0x141>
    panic("unlink: nlink < 1");
ffff800000108760:	48 b8 a3 c4 10 00 00 	movabs $0xffff80000010c4a3,%rax
ffff800000108767:	80 ff ff 
ffff80000010876a:	48 89 c7             	mov    %rax,%rdi
ffff80000010876d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108774:	80 ff ff 
ffff800000108777:	ff d0                	call   *%rax
  if(ip->type == T_DIR && !isdirempty(ip)){
ffff800000108779:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010877d:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108784:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108788:	75 2f                	jne    ffff8000001087b9 <sys_unlink+0x181>
ffff80000010878a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010878e:	48 89 c7             	mov    %rax,%rdi
ffff800000108791:	48 b8 76 83 10 00 00 	movabs $0xffff800000108376,%rax
ffff800000108798:	80 ff ff 
ffff80000010879b:	ff d0                	call   *%rax
ffff80000010879d:	85 c0                	test   %eax,%eax
ffff80000010879f:	75 18                	jne    ffff8000001087b9 <sys_unlink+0x181>
    iunlockput(ip);
ffff8000001087a1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001087a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001087a8:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001087af:	80 ff ff 
ffff8000001087b2:	ff d0                	call   *%rax
    goto bad;
ffff8000001087b4:	e9 04 01 00 00       	jmp    ffff8000001088bd <sys_unlink+0x285>
  }

  memset(&de, 0, sizeof(de));
ffff8000001087b9:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff8000001087bd:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001087c2:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001087c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001087ca:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff8000001087d1:	80 ff ff 
ffff8000001087d4:	ff d0                	call   *%rax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
ffff8000001087d6:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff8000001087d9:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff8000001087dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087e1:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff8000001087e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001087e9:	48 b8 c2 30 10 00 00 	movabs $0xffff8000001030c2,%rax
ffff8000001087f0:	80 ff ff 
ffff8000001087f3:	ff d0                	call   *%rax
ffff8000001087f5:	83 f8 10             	cmp    $0x10,%eax
ffff8000001087f8:	74 19                	je     ffff800000108813 <sys_unlink+0x1db>
    panic("unlink: writei");
ffff8000001087fa:	48 b8 b5 c4 10 00 00 	movabs $0xffff80000010c4b5,%rax
ffff800000108801:	80 ff ff 
ffff800000108804:	48 89 c7             	mov    %rax,%rdi
ffff800000108807:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010880e:	80 ff ff 
ffff800000108811:	ff d0                	call   *%rax
  if(ip->type == T_DIR){
ffff800000108813:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108817:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010881e:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108822:	75 2e                	jne    ffff800000108852 <sys_unlink+0x21a>
    dp->nlink--;
ffff800000108824:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108828:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff80000010882f:	83 e8 01             	sub    $0x1,%eax
ffff800000108832:	89 c2                	mov    %eax,%edx
ffff800000108834:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108838:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff80000010883f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108843:	48 89 c7             	mov    %rax,%rdi
ffff800000108846:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff80000010884d:	80 ff ff 
ffff800000108850:	ff d0                	call   *%rax
  }
  iunlockput(dp);
ffff800000108852:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108856:	48 89 c7             	mov    %rax,%rdi
ffff800000108859:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108860:	80 ff ff 
ffff800000108863:	ff d0                	call   *%rax

  ip->nlink--;
ffff800000108865:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108869:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108870:	83 e8 01             	sub    $0x1,%eax
ffff800000108873:	89 c2                	mov    %eax,%edx
ffff800000108875:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108879:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
  iupdate(ip);
ffff800000108880:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108884:	48 89 c7             	mov    %rax,%rdi
ffff800000108887:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff80000010888e:	80 ff ff 
ffff800000108891:	ff d0                	call   *%rax
  iunlockput(ip);
ffff800000108893:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108897:	48 89 c7             	mov    %rax,%rdi
ffff80000010889a:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001088a1:	80 ff ff 
ffff8000001088a4:	ff d0                	call   *%rax

  end_op();
ffff8000001088a6:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001088ad:	80 ff ff 
ffff8000001088b0:	ff d0                	call   *%rax

  return 0;
ffff8000001088b2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001088b7:	eb 28                	jmp    ffff8000001088e1 <sys_unlink+0x2a9>
    goto bad;
ffff8000001088b9:	90                   	nop
ffff8000001088ba:	eb 01                	jmp    ffff8000001088bd <sys_unlink+0x285>
    goto bad;
ffff8000001088bc:	90                   	nop

bad:
  iunlockput(dp);
ffff8000001088bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001088c4:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001088cb:	80 ff ff 
ffff8000001088ce:	ff d0                	call   *%rax
  end_op();
ffff8000001088d0:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff8000001088d7:	80 ff ff 
ffff8000001088da:	ff d0                	call   *%rax
  return -1;
ffff8000001088dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff8000001088e1:	c9                   	leave
ffff8000001088e2:	c3                   	ret

ffff8000001088e3 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
ffff8000001088e3:	55                   	push   %rbp
ffff8000001088e4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001088e7:	48 83 ec 50          	sub    $0x50,%rsp
ffff8000001088eb:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff8000001088ef:	89 c8                	mov    %ecx,%eax
ffff8000001088f1:	89 f1                	mov    %esi,%ecx
ffff8000001088f3:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff8000001088f7:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff8000001088fb:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
ffff8000001088ff:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff800000108903:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108907:	48 89 d6             	mov    %rdx,%rsi
ffff80000010890a:	48 89 c7             	mov    %rax,%rdi
ffff80000010890d:	48 b8 bd 37 10 00 00 	movabs $0xffff8000001037bd,%rax
ffff800000108914:	80 ff ff 
ffff800000108917:	ff d0                	call   *%rax
ffff800000108919:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010891d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108922:	75 0a                	jne    ffff80000010892e <create+0x4b>
    return 0;
ffff800000108924:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108929:	e9 2c 02 00 00       	jmp    ffff800000108b5a <create+0x277>
  ilock(dp);
ffff80000010892e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108932:	48 89 c7             	mov    %rax,%rdi
ffff800000108935:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010893c:	80 ff ff 
ffff80000010893f:	ff d0                	call   *%rax

  if((ip = dirlookup(dp, name, &off)) != 0){
ffff800000108941:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff800000108945:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108949:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010894d:	48 89 ce             	mov    %rcx,%rsi
ffff800000108950:	48 89 c7             	mov    %rax,%rdi
ffff800000108953:	48 b8 03 33 10 00 00 	movabs $0xffff800000103303,%rax
ffff80000010895a:	80 ff ff 
ffff80000010895d:	ff d0                	call   *%rax
ffff80000010895f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108963:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108968:	74 64                	je     ffff8000001089ce <create+0xeb>
    iunlockput(dp);
ffff80000010896a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010896e:	48 89 c7             	mov    %rax,%rdi
ffff800000108971:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108978:	80 ff ff 
ffff80000010897b:	ff d0                	call   *%rax
    ilock(ip);
ffff80000010897d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108981:	48 89 c7             	mov    %rax,%rdi
ffff800000108984:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff80000010898b:	80 ff ff 
ffff80000010898e:	ff d0                	call   *%rax
    if(type == T_FILE && ip->type == T_FILE)
ffff800000108990:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff800000108995:	75 1a                	jne    ffff8000001089b1 <create+0xce>
ffff800000108997:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010899b:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001089a2:	66 83 f8 02          	cmp    $0x2,%ax
ffff8000001089a6:	75 09                	jne    ffff8000001089b1 <create+0xce>
      return ip;
ffff8000001089a8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089ac:	e9 a9 01 00 00       	jmp    ffff800000108b5a <create+0x277>
    iunlockput(ip);
ffff8000001089b1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001089b5:	48 89 c7             	mov    %rax,%rdi
ffff8000001089b8:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff8000001089bf:	80 ff ff 
ffff8000001089c2:	ff d0                	call   *%rax
    return 0;
ffff8000001089c4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001089c9:	e9 8c 01 00 00       	jmp    ffff800000108b5a <create+0x277>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
ffff8000001089ce:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff8000001089d2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001089d6:	8b 00                	mov    (%rax),%eax
ffff8000001089d8:	89 d6                	mov    %edx,%esi
ffff8000001089da:	89 c7                	mov    %eax,%edi
ffff8000001089dc:	48 b8 c0 24 10 00 00 	movabs $0xffff8000001024c0,%rax
ffff8000001089e3:	80 ff ff 
ffff8000001089e6:	ff d0                	call   *%rax
ffff8000001089e8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001089ec:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001089f1:	75 19                	jne    ffff800000108a0c <create+0x129>
    panic("create: ialloc");
ffff8000001089f3:	48 b8 c4 c4 10 00 00 	movabs $0xffff80000010c4c4,%rax
ffff8000001089fa:	80 ff ff 
ffff8000001089fd:	48 89 c7             	mov    %rax,%rdi
ffff800000108a00:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108a07:	80 ff ff 
ffff800000108a0a:	ff d0                	call   *%rax

  ilock(ip);
ffff800000108a0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a10:	48 89 c7             	mov    %rax,%rdi
ffff800000108a13:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108a1a:	80 ff ff 
ffff800000108a1d:	ff d0                	call   *%rax
  ip->major = major;
ffff800000108a1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a23:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff800000108a27:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
  ip->minor = minor;
ffff800000108a2e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a32:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff800000108a36:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
  ip->nlink = 1;
ffff800000108a3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a41:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff800000108a48:	01 00 
  iupdate(ip);
ffff800000108a4a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a4e:	48 89 c7             	mov    %rax,%rdi
ffff800000108a51:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108a58:	80 ff ff 
ffff800000108a5b:	ff d0                	call   *%rax

  if(type == T_DIR){  // Create . and .. entries.
ffff800000108a5d:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff800000108a62:	0f 85 9d 00 00 00    	jne    ffff800000108b05 <create+0x222>
    dp->nlink++;  // for ".."
ffff800000108a68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a6c:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108a73:	83 c0 01             	add    $0x1,%eax
ffff800000108a76:	89 c2                	mov    %eax,%edx
ffff800000108a78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a7c:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
    iupdate(dp);
ffff800000108a83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108a87:	48 89 c7             	mov    %rax,%rdi
ffff800000108a8a:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108a91:	80 ff ff 
ffff800000108a94:	ff d0                	call   *%rax
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
ffff800000108a96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a9a:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108a9d:	48 b9 9e c4 10 00 00 	movabs $0xffff80000010c49e,%rcx
ffff800000108aa4:	80 ff ff 
ffff800000108aa7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108aab:	48 89 ce             	mov    %rcx,%rsi
ffff800000108aae:	48 89 c7             	mov    %rax,%rdi
ffff800000108ab1:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108ab8:	80 ff ff 
ffff800000108abb:	ff d0                	call   *%rax
ffff800000108abd:	85 c0                	test   %eax,%eax
ffff800000108abf:	78 2b                	js     ffff800000108aec <create+0x209>
ffff800000108ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ac5:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108ac8:	48 b9 a0 c4 10 00 00 	movabs $0xffff80000010c4a0,%rcx
ffff800000108acf:	80 ff ff 
ffff800000108ad2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ad6:	48 89 ce             	mov    %rcx,%rsi
ffff800000108ad9:	48 89 c7             	mov    %rax,%rdi
ffff800000108adc:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108ae3:	80 ff ff 
ffff800000108ae6:	ff d0                	call   *%rax
ffff800000108ae8:	85 c0                	test   %eax,%eax
ffff800000108aea:	79 19                	jns    ffff800000108b05 <create+0x222>
      panic("create dots");
ffff800000108aec:	48 b8 d3 c4 10 00 00 	movabs $0xffff80000010c4d3,%rax
ffff800000108af3:	80 ff ff 
ffff800000108af6:	48 89 c7             	mov    %rax,%rdi
ffff800000108af9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108b00:	80 ff ff 
ffff800000108b03:	ff d0                	call   *%rax
  }

  if(dirlink(dp, name, ip->inum) < 0)
ffff800000108b05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b09:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108b0c:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108b10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b14:	48 89 ce             	mov    %rcx,%rsi
ffff800000108b17:	48 89 c7             	mov    %rax,%rdi
ffff800000108b1a:	48 b8 09 34 10 00 00 	movabs $0xffff800000103409,%rax
ffff800000108b21:	80 ff ff 
ffff800000108b24:	ff d0                	call   *%rax
ffff800000108b26:	85 c0                	test   %eax,%eax
ffff800000108b28:	79 19                	jns    ffff800000108b43 <create+0x260>
    panic("create: dirlink");
ffff800000108b2a:	48 b8 df c4 10 00 00 	movabs $0xffff80000010c4df,%rax
ffff800000108b31:	80 ff ff 
ffff800000108b34:	48 89 c7             	mov    %rax,%rdi
ffff800000108b37:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108b3e:	80 ff ff 
ffff800000108b41:	ff d0                	call   *%rax

  iunlockput(dp);
ffff800000108b43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b47:	48 89 c7             	mov    %rax,%rdi
ffff800000108b4a:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108b51:	80 ff ff 
ffff800000108b54:	ff d0                	call   *%rax

  return ip;
ffff800000108b56:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
}
ffff800000108b5a:	c9                   	leave
ffff800000108b5b:	c3                   	ret

ffff800000108b5c <sys_open>:

int
sys_open(void)
{
ffff800000108b5c:	55                   	push   %rbp
ffff800000108b5d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108b60:	48 83 ec 30          	sub    $0x30,%rsp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
ffff800000108b64:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108b68:	48 89 c6             	mov    %rax,%rsi
ffff800000108b6b:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108b70:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108b77:	80 ff ff 
ffff800000108b7a:	ff d0                	call   *%rax
ffff800000108b7c:	85 c0                	test   %eax,%eax
ffff800000108b7e:	78 1c                	js     ffff800000108b9c <sys_open+0x40>
ffff800000108b80:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000108b84:	48 89 c6             	mov    %rax,%rsi
ffff800000108b87:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108b8c:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000108b93:	80 ff ff 
ffff800000108b96:	ff d0                	call   *%rax
ffff800000108b98:	85 c0                	test   %eax,%eax
ffff800000108b9a:	79 0a                	jns    ffff800000108ba6 <sys_open+0x4a>
    return -1;
ffff800000108b9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108ba1:	e9 de 01 00 00       	jmp    ffff800000108d84 <sys_open+0x228>

  begin_op();
ffff800000108ba6:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000108bad:	80 ff ff 
ffff800000108bb0:	ff d0                	call   *%rax

  if(omode & O_CREATE){
ffff800000108bb2:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108bb5:	25 00 02 00 00       	and    $0x200,%eax
ffff800000108bba:	85 c0                	test   %eax,%eax
ffff800000108bbc:	74 47                	je     ffff800000108c05 <sys_open+0xa9>
    ip = create(path, T_FILE, 0, 0);
ffff800000108bbe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108bc2:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108bc7:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108bcc:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000108bd1:	48 89 c7             	mov    %rax,%rdi
ffff800000108bd4:	48 b8 e3 88 10 00 00 	movabs $0xffff8000001088e3,%rax
ffff800000108bdb:	80 ff ff 
ffff800000108bde:	ff d0                	call   *%rax
ffff800000108be0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(ip == 0){
ffff800000108be4:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108be9:	0f 85 9e 00 00 00    	jne    ffff800000108c8d <sys_open+0x131>
      end_op();
ffff800000108bef:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108bf6:	80 ff ff 
ffff800000108bf9:	ff d0                	call   *%rax
      return -1;
ffff800000108bfb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c00:	e9 7f 01 00 00       	jmp    ffff800000108d84 <sys_open+0x228>
    }
  } else {
    if((ip = namei(path)) == 0){
ffff800000108c05:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108c09:	48 89 c7             	mov    %rax,%rdi
ffff800000108c0c:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000108c13:	80 ff ff 
ffff800000108c16:	ff d0                	call   *%rax
ffff800000108c18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108c1c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108c21:	75 16                	jne    ffff800000108c39 <sys_open+0xdd>
      end_op();
ffff800000108c23:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108c2a:	80 ff ff 
ffff800000108c2d:	ff d0                	call   *%rax
      return -1;
ffff800000108c2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c34:	e9 4b 01 00 00       	jmp    ffff800000108d84 <sys_open+0x228>
    }
    ilock(ip);
ffff800000108c39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c3d:	48 89 c7             	mov    %rax,%rdi
ffff800000108c40:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108c47:	80 ff ff 
ffff800000108c4a:	ff d0                	call   *%rax
    if(ip->type == T_DIR && omode != O_RDONLY){
ffff800000108c4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c50:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108c57:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108c5b:	75 30                	jne    ffff800000108c8d <sys_open+0x131>
ffff800000108c5d:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108c60:	85 c0                	test   %eax,%eax
ffff800000108c62:	74 29                	je     ffff800000108c8d <sys_open+0x131>
      iunlockput(ip);
ffff800000108c64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c68:	48 89 c7             	mov    %rax,%rdi
ffff800000108c6b:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108c72:	80 ff ff 
ffff800000108c75:	ff d0                	call   *%rax
      end_op();
ffff800000108c77:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108c7e:	80 ff ff 
ffff800000108c81:	ff d0                	call   *%rax
      return -1;
ffff800000108c83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108c88:	e9 f7 00 00 00       	jmp    ffff800000108d84 <sys_open+0x228>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffff800000108c8d:	48 b8 4a 1b 10 00 00 	movabs $0xffff800000101b4a,%rax
ffff800000108c94:	80 ff ff 
ffff800000108c97:	ff d0                	call   *%rax
ffff800000108c99:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108c9d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108ca2:	74 1c                	je     ffff800000108cc0 <sys_open+0x164>
ffff800000108ca4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ca8:	48 89 c7             	mov    %rax,%rdi
ffff800000108cab:	48 b8 c7 80 10 00 00 	movabs $0xffff8000001080c7,%rax
ffff800000108cb2:	80 ff ff 
ffff800000108cb5:	ff d0                	call   *%rax
ffff800000108cb7:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000108cba:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108cbe:	79 43                	jns    ffff800000108d03 <sys_open+0x1a7>
    if(f)
ffff800000108cc0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108cc5:	74 13                	je     ffff800000108cda <sys_open+0x17e>
      fileclose(f);
ffff800000108cc7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ccb:	48 89 c7             	mov    %rax,%rdi
ffff800000108cce:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff800000108cd5:	80 ff ff 
ffff800000108cd8:	ff d0                	call   *%rax
    iunlockput(ip);
ffff800000108cda:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108cde:	48 89 c7             	mov    %rax,%rdi
ffff800000108ce1:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108ce8:	80 ff ff 
ffff800000108ceb:	ff d0                	call   *%rax
    end_op();
ffff800000108ced:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108cf4:	80 ff ff 
ffff800000108cf7:	ff d0                	call   *%rax
    return -1;
ffff800000108cf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108cfe:	e9 81 00 00 00       	jmp    ffff800000108d84 <sys_open+0x228>
  }
  iunlock(ip);
ffff800000108d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d07:	48 89 c7             	mov    %rax,%rdi
ffff800000108d0a:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000108d11:	80 ff ff 
ffff800000108d14:	ff d0                	call   *%rax
  end_op();
ffff800000108d16:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108d1d:	80 ff ff 
ffff800000108d20:	ff d0                	call   *%rax

  f->type = FD_INODE;
ffff800000108d22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d26:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
  f->ip = ip;
ffff800000108d2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d30:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108d34:	48 89 50 18          	mov    %rdx,0x18(%rax)
  f->off = 0;
ffff800000108d38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d3c:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
  f->readable = !(omode & O_WRONLY);
ffff800000108d43:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108d46:	83 e0 01             	and    $0x1,%eax
ffff800000108d49:	83 e0 01             	and    $0x1,%eax
ffff800000108d4c:	83 f0 01             	xor    $0x1,%eax
ffff800000108d4f:	89 c2                	mov    %eax,%edx
ffff800000108d51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d55:	88 50 08             	mov    %dl,0x8(%rax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffff800000108d58:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108d5b:	83 e0 01             	and    $0x1,%eax
ffff800000108d5e:	85 c0                	test   %eax,%eax
ffff800000108d60:	75 0a                	jne    ffff800000108d6c <sys_open+0x210>
ffff800000108d62:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108d65:	83 e0 02             	and    $0x2,%eax
ffff800000108d68:	85 c0                	test   %eax,%eax
ffff800000108d6a:	74 07                	je     ffff800000108d73 <sys_open+0x217>
ffff800000108d6c:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000108d71:	eb 05                	jmp    ffff800000108d78 <sys_open+0x21c>
ffff800000108d73:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108d78:	89 c2                	mov    %eax,%edx
ffff800000108d7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d7e:	88 50 09             	mov    %dl,0x9(%rax)
  return fd;
ffff800000108d81:	8b 45 ec             	mov    -0x14(%rbp),%eax
}
ffff800000108d84:	c9                   	leave
ffff800000108d85:	c3                   	ret

ffff800000108d86 <sys_mkdir>:

int
sys_mkdir(void)
{
ffff800000108d86:	55                   	push   %rbp
ffff800000108d87:	48 89 e5             	mov    %rsp,%rbp
ffff800000108d8a:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000108d8e:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000108d95:	80 ff ff 
ffff800000108d98:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffff800000108d9a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108d9e:	48 89 c6             	mov    %rax,%rsi
ffff800000108da1:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108da6:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108dad:	80 ff ff 
ffff800000108db0:	ff d0                	call   *%rax
ffff800000108db2:	85 c0                	test   %eax,%eax
ffff800000108db4:	78 2d                	js     ffff800000108de3 <sys_mkdir+0x5d>
ffff800000108db6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108dba:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108dbf:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108dc4:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000108dc9:	48 89 c7             	mov    %rax,%rdi
ffff800000108dcc:	48 b8 e3 88 10 00 00 	movabs $0xffff8000001088e3,%rax
ffff800000108dd3:	80 ff ff 
ffff800000108dd6:	ff d0                	call   *%rax
ffff800000108dd8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108ddc:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108de1:	75 13                	jne    ffff800000108df6 <sys_mkdir+0x70>
    end_op();
ffff800000108de3:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108dea:	80 ff ff 
ffff800000108ded:	ff d0                	call   *%rax
    return -1;
ffff800000108def:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108df4:	eb 24                	jmp    ffff800000108e1a <sys_mkdir+0x94>
  }
  iunlockput(ip);
ffff800000108df6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108dfa:	48 89 c7             	mov    %rax,%rdi
ffff800000108dfd:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108e04:	80 ff ff 
ffff800000108e07:	ff d0                	call   *%rax
  end_op();
ffff800000108e09:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108e10:	80 ff ff 
ffff800000108e13:	ff d0                	call   *%rax
  return 0;
ffff800000108e15:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108e1a:	c9                   	leave
ffff800000108e1b:	c3                   	ret

ffff800000108e1c <sys_mknod>:

int
sys_mknod(void)
{
ffff800000108e1c:	55                   	push   %rbp
ffff800000108e1d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108e20:	48 83 ec 20          	sub    $0x20,%rsp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
ffff800000108e24:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000108e2b:	80 ff ff 
ffff800000108e2e:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff800000108e30:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108e34:	48 89 c6             	mov    %rax,%rsi
ffff800000108e37:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108e3c:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108e43:	80 ff ff 
ffff800000108e46:	ff d0                	call   *%rax
ffff800000108e48:	85 c0                	test   %eax,%eax
ffff800000108e4a:	78 67                	js     ffff800000108eb3 <sys_mknod+0x97>
     argint(1, &major) < 0 ||
ffff800000108e4c:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff800000108e50:	48 89 c6             	mov    %rax,%rsi
ffff800000108e53:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108e58:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000108e5f:	80 ff ff 
ffff800000108e62:	ff d0                	call   *%rax
  if((argstr(0, &path)) < 0 ||
ffff800000108e64:	85 c0                	test   %eax,%eax
ffff800000108e66:	78 4b                	js     ffff800000108eb3 <sys_mknod+0x97>
     argint(2, &minor) < 0 ||
ffff800000108e68:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000108e6c:	48 89 c6             	mov    %rax,%rsi
ffff800000108e6f:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108e74:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000108e7b:	80 ff ff 
ffff800000108e7e:	ff d0                	call   *%rax
     argint(1, &major) < 0 ||
ffff800000108e80:	85 c0                	test   %eax,%eax
ffff800000108e82:	78 2f                	js     ffff800000108eb3 <sys_mknod+0x97>
     (ip = create(path, T_DEV, major, minor)) == 0){
ffff800000108e84:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000108e87:	0f bf c8             	movswl %ax,%ecx
ffff800000108e8a:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108e8d:	0f bf d0             	movswl %ax,%edx
ffff800000108e90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e94:	be 03 00 00 00       	mov    $0x3,%esi
ffff800000108e99:	48 89 c7             	mov    %rax,%rdi
ffff800000108e9c:	48 b8 e3 88 10 00 00 	movabs $0xffff8000001088e3,%rax
ffff800000108ea3:	80 ff ff 
ffff800000108ea6:	ff d0                	call   *%rax
ffff800000108ea8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
     argint(2, &minor) < 0 ||
ffff800000108eac:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108eb1:	75 13                	jne    ffff800000108ec6 <sys_mknod+0xaa>
    end_op();
ffff800000108eb3:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108eba:	80 ff ff 
ffff800000108ebd:	ff d0                	call   *%rax
    return -1;
ffff800000108ebf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108ec4:	eb 24                	jmp    ffff800000108eea <sys_mknod+0xce>
  }
  iunlockput(ip);
ffff800000108ec6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108eca:	48 89 c7             	mov    %rax,%rdi
ffff800000108ecd:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108ed4:	80 ff ff 
ffff800000108ed7:	ff d0                	call   *%rax
  end_op();
ffff800000108ed9:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108ee0:	80 ff ff 
ffff800000108ee3:	ff d0                	call   *%rax
  return 0;
ffff800000108ee5:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108eea:	c9                   	leave
ffff800000108eeb:	c3                   	ret

ffff800000108eec <sys_chdir>:

int
sys_chdir(void)
{
ffff800000108eec:	55                   	push   %rbp
ffff800000108eed:	48 89 e5             	mov    %rsp,%rbp
ffff800000108ef0:	48 83 ec 10          	sub    $0x10,%rsp
  char *path;
  struct inode *ip;

  begin_op();
ffff800000108ef4:	48 b8 bd 4e 10 00 00 	movabs $0xffff800000104ebd,%rax
ffff800000108efb:	80 ff ff 
ffff800000108efe:	ff d0                	call   *%rax
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
ffff800000108f00:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000108f04:	48 89 c6             	mov    %rax,%rsi
ffff800000108f07:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108f0c:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000108f13:	80 ff ff 
ffff800000108f16:	ff d0                	call   *%rax
ffff800000108f18:	85 c0                	test   %eax,%eax
ffff800000108f1a:	78 1e                	js     ffff800000108f3a <sys_chdir+0x4e>
ffff800000108f1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f20:	48 89 c7             	mov    %rax,%rdi
ffff800000108f23:	48 b8 93 37 10 00 00 	movabs $0xffff800000103793,%rax
ffff800000108f2a:	80 ff ff 
ffff800000108f2d:	ff d0                	call   *%rax
ffff800000108f2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108f33:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108f38:	75 16                	jne    ffff800000108f50 <sys_chdir+0x64>
    end_op();
ffff800000108f3a:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108f41:	80 ff ff 
ffff800000108f44:	ff d0                	call   *%rax
    return -1;
ffff800000108f46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f4b:	e9 a5 00 00 00       	jmp    ffff800000108ff5 <sys_chdir+0x109>
  }
  ilock(ip);
ffff800000108f50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f54:	48 89 c7             	mov    %rax,%rdi
ffff800000108f57:	48 b8 8c 28 10 00 00 	movabs $0xffff80000010288c,%rax
ffff800000108f5e:	80 ff ff 
ffff800000108f61:	ff d0                	call   *%rax
  if(ip->type != T_DIR){
ffff800000108f63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f67:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108f6e:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108f72:	74 26                	je     ffff800000108f9a <sys_chdir+0xae>
    iunlockput(ip);
ffff800000108f74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f78:	48 89 c7             	mov    %rax,%rdi
ffff800000108f7b:	48 b8 89 2b 10 00 00 	movabs $0xffff800000102b89,%rax
ffff800000108f82:	80 ff ff 
ffff800000108f85:	ff d0                	call   *%rax
    end_op();
ffff800000108f87:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108f8e:	80 ff ff 
ffff800000108f91:	ff d0                	call   *%rax
    return -1;
ffff800000108f93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f98:	eb 5b                	jmp    ffff800000108ff5 <sys_chdir+0x109>
  }
  iunlock(ip);
ffff800000108f9a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f9e:	48 89 c7             	mov    %rax,%rdi
ffff800000108fa1:	48 b8 23 2a 10 00 00 	movabs $0xffff800000102a23,%rax
ffff800000108fa8:	80 ff ff 
ffff800000108fab:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff800000108fad:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108fb4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108fb8:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000108fbf:	48 89 c7             	mov    %rax,%rdi
ffff800000108fc2:	48 b8 8f 2a 10 00 00 	movabs $0xffff800000102a8f,%rax
ffff800000108fc9:	80 ff ff 
ffff800000108fcc:	ff d0                	call   *%rax
  end_op();
ffff800000108fce:	48 b8 a5 4f 10 00 00 	movabs $0xffff800000104fa5,%rax
ffff800000108fd5:	80 ff ff 
ffff800000108fd8:	ff d0                	call   *%rax
  proc->cwd = ip;
ffff800000108fda:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108fe1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108fe5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000108fe9:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
  return 0;
ffff800000108ff0:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108ff5:	c9                   	leave
ffff800000108ff6:	c3                   	ret

ffff800000108ff7 <sys_exec>:

int
sys_exec(void)
{
ffff800000108ff7:	55                   	push   %rbp
ffff800000108ff8:	48 89 e5             	mov    %rsp,%rbp
ffff800000108ffb:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
  char *path, *argv[MAXARG];
  int i;
  addr_t uargv, uarg;

  if(argstr(0, &path) < 0 || argaddr(1, &uargv) < 0){
ffff800000109002:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109006:	48 89 c6             	mov    %rax,%rsi
ffff800000109009:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010900e:	48 b8 99 7e 10 00 00 	movabs $0xffff800000107e99,%rax
ffff800000109015:	80 ff ff 
ffff800000109018:	ff d0                	call   *%rax
ffff80000010901a:	85 c0                	test   %eax,%eax
ffff80000010901c:	78 44                	js     ffff800000109062 <sys_exec+0x6b>
ffff80000010901e:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff800000109025:	48 89 c6             	mov    %rax,%rsi
ffff800000109028:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010902d:	48 b8 e4 7d 10 00 00 	movabs $0xffff800000107de4,%rax
ffff800000109034:	80 ff ff 
ffff800000109037:	ff d0                	call   *%rax
    return -1;
  }
  memset(argv, 0, sizeof(argv));
ffff800000109039:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff800000109040:	ba 00 01 00 00       	mov    $0x100,%edx
ffff800000109045:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010904a:	48 89 c7             	mov    %rax,%rdi
ffff80000010904d:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff800000109054:	80 ff ff 
ffff800000109057:	ff d0                	call   *%rax
  for(i=0;; i++){
ffff800000109059:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109060:	eb 0a                	jmp    ffff80000010906c <sys_exec+0x75>
    return -1;
ffff800000109062:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109067:	e9 cb 00 00 00       	jmp    ffff800000109137 <sys_exec+0x140>
    if(i >= NELEM(argv))
ffff80000010906c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010906f:	83 f8 1f             	cmp    $0x1f,%eax
ffff800000109072:	76 0a                	jbe    ffff80000010907e <sys_exec+0x87>
      return -1;
ffff800000109074:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109079:	e9 b9 00 00 00       	jmp    ffff800000109137 <sys_exec+0x140>
    if(fetchaddr(uargv+(sizeof(addr_t))*i, (addr_t*)&uarg) < 0)
ffff80000010907e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109081:	48 98                	cltq
ffff800000109083:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010908a:	00 
ffff80000010908b:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff800000109092:	48 01 c2             	add    %rax,%rdx
ffff800000109095:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff80000010909c:	48 89 c6             	mov    %rax,%rsi
ffff80000010909f:	48 89 d7             	mov    %rdx,%rdi
ffff8000001090a2:	48 b8 be 7b 10 00 00 	movabs $0xffff800000107bbe,%rax
ffff8000001090a9:	80 ff ff 
ffff8000001090ac:	ff d0                	call   *%rax
ffff8000001090ae:	85 c0                	test   %eax,%eax
ffff8000001090b0:	79 07                	jns    ffff8000001090b9 <sys_exec+0xc2>
      return -1;
ffff8000001090b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001090b7:	eb 7e                	jmp    ffff800000109137 <sys_exec+0x140>
    if(uarg == 0){
ffff8000001090b9:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff8000001090c0:	48 85 c0             	test   %rax,%rax
ffff8000001090c3:	75 31                	jne    ffff8000001090f6 <sys_exec+0xff>
      argv[i] = 0;
ffff8000001090c5:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001090c8:	48 98                	cltq
ffff8000001090ca:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff8000001090d1:	ff 00 00 00 00 
      break;
ffff8000001090d6:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
ffff8000001090d7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001090db:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff8000001090e2:	48 89 d6             	mov    %rdx,%rsi
ffff8000001090e5:	48 89 c7             	mov    %rax,%rdi
ffff8000001090e8:	48 b8 43 15 10 00 00 	movabs $0xffff800000101543,%rax
ffff8000001090ef:	80 ff ff 
ffff8000001090f2:	ff d0                	call   *%rax
ffff8000001090f4:	eb 41                	jmp    ffff800000109137 <sys_exec+0x140>
    if(fetchstr(uarg, &argv[i]) < 0)
ffff8000001090f6:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff8000001090fd:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000109100:	48 63 d2             	movslq %edx,%rdx
ffff800000109103:	48 c1 e2 03          	shl    $0x3,%rdx
ffff800000109107:	48 01 c2             	add    %rax,%rdx
ffff80000010910a:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff800000109111:	48 89 d6             	mov    %rdx,%rsi
ffff800000109114:	48 89 c7             	mov    %rax,%rdi
ffff800000109117:	48 b8 23 7c 10 00 00 	movabs $0xffff800000107c23,%rax
ffff80000010911e:	80 ff ff 
ffff800000109121:	ff d0                	call   *%rax
ffff800000109123:	85 c0                	test   %eax,%eax
ffff800000109125:	79 07                	jns    ffff80000010912e <sys_exec+0x137>
      return -1;
ffff800000109127:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010912c:	eb 09                	jmp    ffff800000109137 <sys_exec+0x140>
  for(i=0;; i++){
ffff80000010912e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    if(i >= NELEM(argv))
ffff800000109132:	e9 35 ff ff ff       	jmp    ffff80000010906c <sys_exec+0x75>
}
ffff800000109137:	c9                   	leave
ffff800000109138:	c3                   	ret

ffff800000109139 <sys_pipe>:

int
sys_pipe(void)
{
ffff800000109139:	55                   	push   %rbp
ffff80000010913a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010913d:	48 83 ec 20          	sub    $0x20,%rsp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
ffff800000109141:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109145:	ba 08 00 00 00       	mov    $0x8,%edx
ffff80000010914a:	48 89 c6             	mov    %rax,%rsi
ffff80000010914d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109152:	48 b8 12 7e 10 00 00 	movabs $0xffff800000107e12,%rax
ffff800000109159:	80 ff ff 
ffff80000010915c:	ff d0                	call   *%rax
    return -1;
  if(pipealloc(&rf, &wf) < 0)
ffff80000010915e:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000109162:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109166:	48 89 d6             	mov    %rdx,%rsi
ffff800000109169:	48 89 c7             	mov    %rax,%rdi
ffff80000010916c:	48 b8 0e 5c 10 00 00 	movabs $0xffff800000105c0e,%rax
ffff800000109173:	80 ff ff 
ffff800000109176:	ff d0                	call   *%rax
ffff800000109178:	85 c0                	test   %eax,%eax
ffff80000010917a:	79 0a                	jns    ffff800000109186 <sys_pipe+0x4d>
    return -1;
ffff80000010917c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109181:	e9 ab 00 00 00       	jmp    ffff800000109231 <sys_pipe+0xf8>
  fd0 = -1;
ffff800000109186:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffff80000010918d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109191:	48 89 c7             	mov    %rax,%rdi
ffff800000109194:	48 b8 c7 80 10 00 00 	movabs $0xffff8000001080c7,%rax
ffff80000010919b:	80 ff ff 
ffff80000010919e:	ff d0                	call   *%rax
ffff8000001091a0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001091a3:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001091a7:	78 1c                	js     ffff8000001091c5 <sys_pipe+0x8c>
ffff8000001091a9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001091ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001091b0:	48 b8 c7 80 10 00 00 	movabs $0xffff8000001080c7,%rax
ffff8000001091b7:	80 ff ff 
ffff8000001091ba:	ff d0                	call   *%rax
ffff8000001091bc:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff8000001091bf:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff8000001091c3:	79 51                	jns    ffff800000109216 <sys_pipe+0xdd>
    if(fd0 >= 0)
ffff8000001091c5:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff8000001091c9:	78 1e                	js     ffff8000001091e9 <sys_pipe+0xb0>
      proc->ofile[fd0] = 0;
ffff8000001091cb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001091d2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001091d6:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001091d9:	48 63 d2             	movslq %edx,%rdx
ffff8000001091dc:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001091e0:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff8000001091e7:	00 00 
    fileclose(rf);
ffff8000001091e9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001091ed:	48 89 c7             	mov    %rax,%rdi
ffff8000001091f0:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff8000001091f7:	80 ff ff 
ffff8000001091fa:	ff d0                	call   *%rax
    fileclose(wf);
ffff8000001091fc:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000109200:	48 89 c7             	mov    %rax,%rdi
ffff800000109203:	48 b8 5e 1c 10 00 00 	movabs $0xffff800000101c5e,%rax
ffff80000010920a:	80 ff ff 
ffff80000010920d:	ff d0                	call   *%rax
    return -1;
ffff80000010920f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109214:	eb 1b                	jmp    ffff800000109231 <sys_pipe+0xf8>
  }
  fd[0] = fd0;
ffff800000109216:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010921a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010921d:	89 10                	mov    %edx,(%rax)
  fd[1] = fd1;
ffff80000010921f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109223:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000109227:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010922a:	89 02                	mov    %eax,(%rdx)
  return 0;
ffff80000010922c:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109231:	c9                   	leave
ffff800000109232:	c3                   	ret

ffff800000109233 <sys_fork>:
#include "proc.h"
#include "trace.h"

int
sys_fork(void)
{
ffff800000109233:	55                   	push   %rbp
ffff800000109234:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff800000109237:	48 b8 20 65 10 00 00 	movabs $0xffff800000106520,%rax
ffff80000010923e:	80 ff ff 
ffff800000109241:	ff d0                	call   *%rax
}
ffff800000109243:	5d                   	pop    %rbp
ffff800000109244:	c3                   	ret

ffff800000109245 <sys_exit>:

int
sys_exit(void)
{
ffff800000109245:	55                   	push   %rbp
ffff800000109246:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff800000109249:	48 b8 d8 67 10 00 00 	movabs $0xffff8000001067d8,%rax
ffff800000109250:	80 ff ff 
ffff800000109253:	ff d0                	call   *%rax
  return 0;  // not reached
ffff800000109255:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010925a:	5d                   	pop    %rbp
ffff80000010925b:	c3                   	ret

ffff80000010925c <sys_wait>:

int
sys_wait(void)
{
ffff80000010925c:	55                   	push   %rbp
ffff80000010925d:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff800000109260:	48 b8 c9 69 10 00 00 	movabs $0xffff8000001069c9,%rax
ffff800000109267:	80 ff ff 
ffff80000010926a:	ff d0                	call   *%rax
}
ffff80000010926c:	5d                   	pop    %rbp
ffff80000010926d:	c3                   	ret

ffff80000010926e <sys_kill>:

int
sys_kill(void)
{
ffff80000010926e:	55                   	push   %rbp
ffff80000010926f:	48 89 e5             	mov    %rsp,%rbp
ffff800000109272:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff800000109276:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010927a:	48 89 c6             	mov    %rax,%rsi
ffff80000010927d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109282:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000109289:	80 ff ff 
ffff80000010928c:	ff d0                	call   *%rax
ffff80000010928e:	85 c0                	test   %eax,%eax
ffff800000109290:	79 07                	jns    ffff800000109299 <sys_kill+0x2b>
    return -1;
ffff800000109292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109297:	eb 11                	jmp    ffff8000001092aa <sys_kill+0x3c>
  return kill(pid);
ffff800000109299:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010929c:	89 c7                	mov    %eax,%edi
ffff80000010929e:	48 b8 26 70 10 00 00 	movabs $0xffff800000107026,%rax
ffff8000001092a5:	80 ff ff 
ffff8000001092a8:	ff d0                	call   *%rax
}
ffff8000001092aa:	c9                   	leave
ffff8000001092ab:	c3                   	ret

ffff8000001092ac <sys_getpid>:

int
sys_getpid(void)
{
ffff8000001092ac:	55                   	push   %rbp
ffff8000001092ad:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff8000001092b0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001092b7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001092bb:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff8000001092be:	5d                   	pop    %rbp
ffff8000001092bf:	c3                   	ret

ffff8000001092c0 <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff8000001092c0:	55                   	push   %rbp
ffff8000001092c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001092c4:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff8000001092c8:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001092cc:	48 89 c6             	mov    %rax,%rsi
ffff8000001092cf:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001092d4:	48 b8 e4 7d 10 00 00 	movabs $0xffff800000107de4,%rax
ffff8000001092db:	80 ff ff 
ffff8000001092de:	ff d0                	call   *%rax
  addr = proc->sz;
ffff8000001092e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001092e7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001092eb:	48 8b 00             	mov    (%rax),%rax
ffff8000001092ee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff8000001092f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001092f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001092f9:	48 b8 3d 64 10 00 00 	movabs $0xffff80000010643d,%rax
ffff800000109300:	80 ff ff 
ffff800000109303:	ff d0                	call   *%rax
ffff800000109305:	85 c0                	test   %eax,%eax
ffff800000109307:	79 09                	jns    ffff800000109312 <sys_sbrk+0x52>
    return -1;
ffff800000109309:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff800000109310:	eb 04                	jmp    ffff800000109316 <sys_sbrk+0x56>
  return addr;
ffff800000109312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000109316:	c9                   	leave
ffff800000109317:	c3                   	ret

ffff800000109318 <sys_sleep>:

int
sys_sleep(void)
{
ffff800000109318:	55                   	push   %rbp
ffff800000109319:	48 89 e5             	mov    %rsp,%rbp
ffff80000010931c:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff800000109320:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109324:	48 89 c6             	mov    %rax,%rsi
ffff800000109327:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010932c:	48 b8 b5 7d 10 00 00 	movabs $0xffff800000107db5,%rax
ffff800000109333:	80 ff ff 
ffff800000109336:	ff d0                	call   *%rax
ffff800000109338:	85 c0                	test   %eax,%eax
ffff80000010933a:	79 0a                	jns    ffff800000109346 <sys_sleep+0x2e>
    return -1;
ffff80000010933c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109341:	e9 b6 00 00 00       	jmp    ffff8000001093fc <sys_sleep+0xe4>
  acquire(&tickslock);
ffff800000109346:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff80000010934d:	80 ff ff 
ffff800000109350:	48 89 c7             	mov    %rax,%rdi
ffff800000109353:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff80000010935a:	80 ff ff 
ffff80000010935d:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff80000010935f:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff800000109366:	80 ff ff 
ffff800000109369:	8b 00                	mov    (%rax),%eax
ffff80000010936b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff80000010936e:	eb 58                	jmp    ffff8000001093c8 <sys_sleep+0xb0>
    if(proc->killed){
ffff800000109370:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109377:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010937b:	8b 40 40             	mov    0x40(%rax),%eax
ffff80000010937e:	85 c0                	test   %eax,%eax
ffff800000109380:	74 20                	je     ffff8000001093a2 <sys_sleep+0x8a>
      release(&tickslock);
ffff800000109382:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff800000109389:	80 ff ff 
ffff80000010938c:	48 89 c7             	mov    %rax,%rdi
ffff80000010938f:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000109396:	80 ff ff 
ffff800000109399:	ff d0                	call   *%rax
      return -1;
ffff80000010939b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001093a0:	eb 5a                	jmp    ffff8000001093fc <sys_sleep+0xe4>
    }
    sleep(&ticks, &tickslock);
ffff8000001093a2:	48 ba e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rdx
ffff8000001093a9:	80 ff ff 
ffff8000001093ac:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff8000001093b3:	80 ff ff 
ffff8000001093b6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001093b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001093bc:	48 b8 5d 6e 10 00 00 	movabs $0xffff800000106e5d,%rax
ffff8000001093c3:	80 ff ff 
ffff8000001093c6:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff8000001093c8:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff8000001093cf:	80 ff ff 
ffff8000001093d2:	8b 00                	mov    (%rax),%eax
ffff8000001093d4:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff8000001093d7:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001093da:	39 d0                	cmp    %edx,%eax
ffff8000001093dc:	72 92                	jb     ffff800000109370 <sys_sleep+0x58>
  }
  release(&tickslock);
ffff8000001093de:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff8000001093e5:	80 ff ff 
ffff8000001093e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001093eb:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff8000001093f2:	80 ff ff 
ffff8000001093f5:	ff d0                	call   *%rax
  return 0;
ffff8000001093f7:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001093fc:	c9                   	leave
ffff8000001093fd:	c3                   	ret

ffff8000001093fe <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff8000001093fe:	55                   	push   %rbp
ffff8000001093ff:	48 89 e5             	mov    %rsp,%rbp
ffff800000109402:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff800000109406:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff80000010940d:	80 ff ff 
ffff800000109410:	48 89 c7             	mov    %rax,%rdi
ffff800000109413:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff80000010941a:	80 ff ff 
ffff80000010941d:	ff d0                	call   *%rax
  xticks = ticks;
ffff80000010941f:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff800000109426:	80 ff ff 
ffff800000109429:	8b 00                	mov    (%rax),%eax
ffff80000010942b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff80000010942e:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff800000109435:	80 ff ff 
ffff800000109438:	48 89 c7             	mov    %rax,%rdi
ffff80000010943b:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000109442:	80 ff ff 
ffff800000109445:	ff d0                	call   *%rax
  return xticks;
ffff800000109447:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff80000010944a:	c9                   	leave
ffff80000010944b:	c3                   	ret

ffff80000010944c <sys_traceread>:


int
sys_traceread(void){
ffff80000010944c:	55                   	push   %rbp
ffff80000010944d:	48 89 e5             	mov    %rsp,%rbp
ffff800000109450:	48 83 ec 10          	sub    $0x10,%rsp
  struct trace_event *event;

  // Get the first argument to grab the first event
  if(argptr(0, (char**)&event, sizeof(*event)) < 0)
ffff800000109454:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109458:	ba 28 00 00 00       	mov    $0x28,%edx
ffff80000010945d:	48 89 c6             	mov    %rax,%rsi
ffff800000109460:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109465:	48 b8 12 7e 10 00 00 	movabs $0xffff800000107e12,%rax
ffff80000010946c:	80 ff ff 
ffff80000010946f:	ff d0                	call   *%rax
    return -1;

  return traceread(event);
ffff800000109471:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109475:	48 89 c7             	mov    %rax,%rdi
ffff800000109478:	48 b8 98 be 10 00 00 	movabs $0xffff80000010be98,%rax
ffff80000010947f:	80 ff ff 
ffff800000109482:	ff d0                	call   *%rax
}
ffff800000109484:	c9                   	leave
ffff800000109485:	c3                   	ret

ffff800000109486 <alltraps>:
ffff800000109486:	41 57                	push   %r15
ffff800000109488:	41 56                	push   %r14
ffff80000010948a:	41 55                	push   %r13
ffff80000010948c:	41 54                	push   %r12
ffff80000010948e:	41 53                	push   %r11
ffff800000109490:	41 52                	push   %r10
ffff800000109492:	41 51                	push   %r9
ffff800000109494:	41 50                	push   %r8
ffff800000109496:	57                   	push   %rdi
ffff800000109497:	56                   	push   %rsi
ffff800000109498:	55                   	push   %rbp
ffff800000109499:	52                   	push   %rdx
ffff80000010949a:	51                   	push   %rcx
ffff80000010949b:	53                   	push   %rbx
ffff80000010949c:	50                   	push   %rax
ffff80000010949d:	48 89 e7             	mov    %rsp,%rdi
ffff8000001094a0:	e8 7b 02 00 00       	call   ffff800000109720 <trap>

ffff8000001094a5 <trapret>:
ffff8000001094a5:	58                   	pop    %rax
ffff8000001094a6:	5b                   	pop    %rbx
ffff8000001094a7:	59                   	pop    %rcx
ffff8000001094a8:	5a                   	pop    %rdx
ffff8000001094a9:	5d                   	pop    %rbp
ffff8000001094aa:	5e                   	pop    %rsi
ffff8000001094ab:	5f                   	pop    %rdi
ffff8000001094ac:	41 58                	pop    %r8
ffff8000001094ae:	41 59                	pop    %r9
ffff8000001094b0:	41 5a                	pop    %r10
ffff8000001094b2:	41 5b                	pop    %r11
ffff8000001094b4:	41 5c                	pop    %r12
ffff8000001094b6:	41 5d                	pop    %r13
ffff8000001094b8:	41 5e                	pop    %r14
ffff8000001094ba:	41 5f                	pop    %r15
ffff8000001094bc:	48 83 c4 10          	add    $0x10,%rsp
ffff8000001094c0:	48 cf                	iretq

ffff8000001094c2 <syscall_entry>:
ffff8000001094c2:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff8000001094c9:	00 00 
ffff8000001094cb:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff8000001094d2:	ff ff 
ffff8000001094d4:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff8000001094d8:	48 05 f0 0f 00 00    	add    $0xff0,%rax
ffff8000001094de:	48 89 20             	mov    %rsp,(%rax)
ffff8000001094e1:	48 89 c4             	mov    %rax,%rsp
ffff8000001094e4:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff8000001094eb:	00 00 
ffff8000001094ed:	41 53                	push   %r11
ffff8000001094ef:	6a 00                	push   $0x0
ffff8000001094f1:	51                   	push   %rcx
ffff8000001094f2:	6a 00                	push   $0x0
ffff8000001094f4:	6a 00                	push   $0x0
ffff8000001094f6:	41 57                	push   %r15
ffff8000001094f8:	41 56                	push   %r14
ffff8000001094fa:	41 55                	push   %r13
ffff8000001094fc:	41 54                	push   %r12
ffff8000001094fe:	41 53                	push   %r11
ffff800000109500:	41 52                	push   %r10
ffff800000109502:	41 51                	push   %r9
ffff800000109504:	41 50                	push   %r8
ffff800000109506:	57                   	push   %rdi
ffff800000109507:	56                   	push   %rsi
ffff800000109508:	55                   	push   %rbp
ffff800000109509:	52                   	push   %rdx
ffff80000010950a:	51                   	push   %rcx
ffff80000010950b:	53                   	push   %rbx
ffff80000010950c:	50                   	push   %rax
ffff80000010950d:	48 89 e7             	mov    %rsp,%rdi
ffff800000109510:	e8 d3 e9 ff ff       	call   ffff800000107ee8 <syscall>

ffff800000109515 <syscall_trapret>:
ffff800000109515:	58                   	pop    %rax
ffff800000109516:	5b                   	pop    %rbx
ffff800000109517:	59                   	pop    %rcx
ffff800000109518:	5a                   	pop    %rdx
ffff800000109519:	5d                   	pop    %rbp
ffff80000010951a:	5e                   	pop    %rsi
ffff80000010951b:	5f                   	pop    %rdi
ffff80000010951c:	41 58                	pop    %r8
ffff80000010951e:	41 59                	pop    %r9
ffff800000109520:	41 5a                	pop    %r10
ffff800000109522:	41 5b                	pop    %r11
ffff800000109524:	41 5c                	pop    %r12
ffff800000109526:	41 5d                	pop    %r13
ffff800000109528:	41 5e                	pop    %r14
ffff80000010952a:	41 5f                	pop    %r15
ffff80000010952c:	48 83 c4 28          	add    $0x28,%rsp
ffff800000109530:	fa                   	cli
ffff800000109531:	48 8b 24 24          	mov    (%rsp),%rsp
ffff800000109535:	48 0f 07             	sysretq

ffff800000109538 <lidt>:
{
ffff800000109538:	55                   	push   %rbp
ffff800000109539:	48 89 e5             	mov    %rsp,%rbp
ffff80000010953c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000109540:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000109544:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff800000109547:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010954b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff80000010954f:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000109552:	83 e8 01             	sub    $0x1,%eax
ffff800000109555:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff800000109559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010955d:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff800000109561:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109565:	48 c1 e8 10          	shr    $0x10,%rax
ffff800000109569:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff80000010956d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109571:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109575:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff800000109579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010957d:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000109581:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffff800000109585:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff800000109589:	0f 01 18             	lidt   (%rax)
}
ffff80000010958c:	90                   	nop
ffff80000010958d:	c9                   	leave
ffff80000010958e:	c3                   	ret

ffff80000010958f <rcr2>:

static inline addr_t
rcr2(void)
{
ffff80000010958f:	55                   	push   %rbp
ffff800000109590:	48 89 e5             	mov    %rsp,%rbp
ffff800000109593:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t val;
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffff800000109597:	0f 20 d0             	mov    %cr2,%rax
ffff80000010959a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffff80000010959e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001095a2:	c9                   	leave
ffff8000001095a3:	c3                   	ret

ffff8000001095a4 <mkgate>:
struct spinlock tickslock;
uint ticks;

static void
mkgate(uint *idt, uint n, addr_t kva, uint pl)
{
ffff8000001095a4:	55                   	push   %rbp
ffff8000001095a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001095a8:	48 83 ec 28          	sub    $0x28,%rsp
ffff8000001095ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001095b0:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff8000001095b3:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001095b7:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff8000001095ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001095be:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  n *= 4;
ffff8000001095c2:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff8000001095c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001095ca:	0f b7 d0             	movzwl %ax,%edx
ffff8000001095cd:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff8000001095d0:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff8000001095d7:	00 
ffff8000001095d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001095dc:	48 01 c8             	add    %rcx,%rax
ffff8000001095df:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff8000001095e5:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff8000001095e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001095eb:	66 b8 00 00          	mov    $0x0,%ax
ffff8000001095ef:	89 c2                	mov    %eax,%edx
ffff8000001095f1:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001095f4:	c1 e0 0d             	shl    $0xd,%eax
ffff8000001095f7:	25 00 60 00 00       	and    $0x6000,%eax
ffff8000001095fc:	09 c2                	or     %eax,%edx
ffff8000001095fe:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109601:	83 c0 01             	add    $0x1,%eax
ffff800000109604:	89 c0                	mov    %eax,%eax
ffff800000109606:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff80000010960d:	00 
ffff80000010960e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109612:	48 01 c8             	add    %rcx,%rax
ffff800000109615:	80 ce 8e             	or     $0x8e,%dh
ffff800000109618:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff80000010961a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010961e:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109622:	48 89 c1             	mov    %rax,%rcx
ffff800000109625:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109628:	83 c0 02             	add    $0x2,%eax
ffff80000010962b:	89 c0                	mov    %eax,%eax
ffff80000010962d:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109634:	00 
ffff800000109635:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109639:	48 01 d0             	add    %rdx,%rax
ffff80000010963c:	89 ca                	mov    %ecx,%edx
ffff80000010963e:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff800000109640:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109643:	83 c0 03             	add    $0x3,%eax
ffff800000109646:	89 c0                	mov    %eax,%eax
ffff800000109648:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff80000010964f:	00 
ffff800000109650:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109654:	48 01 d0             	add    %rdx,%rax
ffff800000109657:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff80000010965d:	90                   	nop
ffff80000010965e:	c9                   	leave
ffff80000010965f:	c3                   	ret

ffff800000109660 <idtinit>:

void idtinit(void)
{
ffff800000109660:	55                   	push   %rbp
ffff800000109661:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff800000109664:	48 b8 c0 ac 11 00 00 	movabs $0xffff80000011acc0,%rax
ffff80000010966b:	80 ff ff 
ffff80000010966e:	48 8b 00             	mov    (%rax),%rax
ffff800000109671:	be 00 10 00 00       	mov    $0x1000,%esi
ffff800000109676:	48 89 c7             	mov    %rax,%rdi
ffff800000109679:	48 b8 38 95 10 00 00 	movabs $0xffff800000109538,%rax
ffff800000109680:	80 ff ff 
ffff800000109683:	ff d0                	call   *%rax
}
ffff800000109685:	90                   	nop
ffff800000109686:	5d                   	pop    %rbp
ffff800000109687:	c3                   	ret

ffff800000109688 <tvinit>:

void tvinit(void)
{
ffff800000109688:	55                   	push   %rbp
ffff800000109689:	48 89 e5             	mov    %rsp,%rbp
ffff80000010968c:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  idt = (uint*) kalloc();
ffff800000109690:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff800000109697:	80 ff ff 
ffff80000010969a:	ff d0                	call   *%rax
ffff80000010969c:	48 ba c0 ac 11 00 00 	movabs $0xffff80000011acc0,%rdx
ffff8000001096a3:	80 ff ff 
ffff8000001096a6:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff8000001096a9:	48 b8 c0 ac 11 00 00 	movabs $0xffff80000011acc0,%rax
ffff8000001096b0:	80 ff ff 
ffff8000001096b3:	48 8b 00             	mov    (%rax),%rax
ffff8000001096b6:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff8000001096bb:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001096c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001096c3:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff8000001096ca:	80 ff ff 
ffff8000001096cd:	ff d0                	call   *%rax

  for (n = 0; n < 256; n++)
ffff8000001096cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001096d6:	eb 3b                	jmp    ffff800000109713 <tvinit+0x8b>
    mkgate(idt, n, vectors[n], 0);
ffff8000001096d8:	48 ba 18 d7 10 00 00 	movabs $0xffff80000010d718,%rdx
ffff8000001096df:	80 ff ff 
ffff8000001096e2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001096e5:	48 98                	cltq
ffff8000001096e7:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff8000001096eb:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff8000001096ee:	48 b8 c0 ac 11 00 00 	movabs $0xffff80000011acc0,%rax
ffff8000001096f5:	80 ff ff 
ffff8000001096f8:	48 8b 00             	mov    (%rax),%rax
ffff8000001096fb:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109700:	48 89 c7             	mov    %rax,%rdi
ffff800000109703:	48 b8 a4 95 10 00 00 	movabs $0xffff8000001095a4,%rax
ffff80000010970a:	80 ff ff 
ffff80000010970d:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff80000010970f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109713:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010971a:	7e bc                	jle    ffff8000001096d8 <tvinit+0x50>
}
ffff80000010971c:	90                   	nop
ffff80000010971d:	90                   	nop
ffff80000010971e:	c9                   	leave
ffff80000010971f:	c3                   	ret

ffff800000109720 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffff800000109720:	55                   	push   %rbp
ffff800000109721:	48 89 e5             	mov    %rsp,%rbp
ffff800000109724:	41 54                	push   %r12
ffff800000109726:	53                   	push   %rbx
ffff800000109727:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010972b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff80000010972f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109733:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109737:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff80000010973b:	0f 84 4d 01 00 00    	je     ffff80000010988e <trap+0x16e>
ffff800000109741:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109745:	0f 87 9d 01 00 00    	ja     ffff8000001098e8 <trap+0x1c8>
ffff80000010974b:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff80000010974f:	0f 84 03 03 00 00    	je     ffff800000109a58 <trap+0x338>
ffff800000109755:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109759:	0f 87 89 01 00 00    	ja     ffff8000001098e8 <trap+0x1c8>
ffff80000010975f:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109763:	0f 84 ce 00 00 00    	je     ffff800000109837 <trap+0x117>
ffff800000109769:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff80000010976d:	0f 87 75 01 00 00    	ja     ffff8000001098e8 <trap+0x1c8>
ffff800000109773:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109777:	0f 84 11 01 00 00    	je     ffff80000010988e <trap+0x16e>
ffff80000010977d:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109781:	0f 87 61 01 00 00    	ja     ffff8000001098e8 <trap+0x1c8>
ffff800000109787:	48 83 f8 24          	cmp    $0x24,%rax
ffff80000010978b:	0f 84 e0 00 00 00    	je     ffff800000109871 <trap+0x151>
ffff800000109791:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109795:	0f 87 4d 01 00 00    	ja     ffff8000001098e8 <trap+0x1c8>
ffff80000010979b:	48 83 f8 20          	cmp    $0x20,%rax
ffff80000010979f:	74 0f                	je     ffff8000001097b0 <trap+0x90>
ffff8000001097a1:	48 83 f8 21          	cmp    $0x21,%rax
ffff8000001097a5:	0f 84 a9 00 00 00    	je     ffff800000109854 <trap+0x134>
ffff8000001097ab:	e9 38 01 00 00       	jmp    ffff8000001098e8 <trap+0x1c8>
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
ffff8000001097b0:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff8000001097b7:	80 ff ff 
ffff8000001097ba:	ff d0                	call   *%rax
ffff8000001097bc:	85 c0                	test   %eax,%eax
ffff8000001097be:	75 66                	jne    ffff800000109826 <trap+0x106>
      acquire(&tickslock);
ffff8000001097c0:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff8000001097c7:	80 ff ff 
ffff8000001097ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001097cd:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff8000001097d4:	80 ff ff 
ffff8000001097d7:	ff d0                	call   *%rax
      ticks++;
ffff8000001097d9:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff8000001097e0:	80 ff ff 
ffff8000001097e3:	8b 00                	mov    (%rax),%eax
ffff8000001097e5:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001097e8:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff8000001097ef:	80 ff ff 
ffff8000001097f2:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff8000001097f4:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff8000001097fb:	80 ff ff 
ffff8000001097fe:	48 89 c7             	mov    %rax,%rdi
ffff800000109801:	48 b8 d2 6f 10 00 00 	movabs $0xffff800000106fd2,%rax
ffff800000109808:	80 ff ff 
ffff80000010980b:	ff d0                	call   *%rax
      release(&tickslock);
ffff80000010980d:	48 b8 e0 ac 11 00 00 	movabs $0xffff80000011ace0,%rax
ffff800000109814:	80 ff ff 
ffff800000109817:	48 89 c7             	mov    %rax,%rdi
ffff80000010981a:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff800000109821:	80 ff ff 
ffff800000109824:	ff d0                	call   *%rax
    }
    lapiceoi();
ffff800000109826:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff80000010982d:	80 ff ff 
ffff800000109830:	ff d0                	call   *%rax
    break;
ffff800000109832:	e9 22 02 00 00       	jmp    ffff800000109a59 <trap+0x339>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffff800000109837:	48 b8 89 3b 10 00 00 	movabs $0xffff800000103b89,%rax
ffff80000010983e:	80 ff ff 
ffff800000109841:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109843:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff80000010984a:	80 ff ff 
ffff80000010984d:	ff d0                	call   *%rax
    break;
ffff80000010984f:	e9 05 02 00 00       	jmp    ffff800000109a59 <trap+0x339>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffff800000109854:	48 b8 46 44 10 00 00 	movabs $0xffff800000104446,%rax
ffff80000010985b:	80 ff ff 
ffff80000010985e:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109860:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109867:	80 ff ff 
ffff80000010986a:	ff d0                	call   *%rax
    break;
ffff80000010986c:	e9 e8 01 00 00       	jmp    ffff800000109a59 <trap+0x339>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffff800000109871:	48 b8 81 9d 10 00 00 	movabs $0xffff800000109d81,%rax
ffff800000109878:	80 ff ff 
ffff80000010987b:	ff d0                	call   *%rax
    lapiceoi();
ffff80000010987d:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff800000109884:	80 ff ff 
ffff800000109887:	ff d0                	call   *%rax
    break;
ffff800000109889:	e9 cb 01 00 00       	jmp    ffff800000109a59 <trap+0x339>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff80000010988e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109892:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109899:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010989d:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff8000001098a4:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff8000001098ab:	80 ff ff 
ffff8000001098ae:	ff d0                	call   *%rax
ffff8000001098b0:	89 c6                	mov    %eax,%esi
ffff8000001098b2:	48 b8 f0 c4 10 00 00 	movabs $0xffff80000010c4f0,%rax
ffff8000001098b9:	80 ff ff 
ffff8000001098bc:	4c 89 e1             	mov    %r12,%rcx
ffff8000001098bf:	48 89 da             	mov    %rbx,%rdx
ffff8000001098c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001098c5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001098ca:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff8000001098d1:	80 ff ff 
ffff8000001098d4:	41 ff d0             	call   *%r8
            cpunum(), tf->cs, tf->rip);
    lapiceoi();
ffff8000001098d7:	48 b8 90 47 10 00 00 	movabs $0xffff800000104790,%rax
ffff8000001098de:	80 ff ff 
ffff8000001098e1:	ff d0                	call   *%rax
    break;
ffff8000001098e3:	e9 71 01 00 00       	jmp    ffff800000109a59 <trap+0x339>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff8000001098e8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001098ef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001098f3:	48 85 c0             	test   %rax,%rax
ffff8000001098f6:	74 17                	je     ffff80000010990f <trap+0x1ef>
ffff8000001098f8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001098fc:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109903:	83 e0 03             	and    $0x3,%eax
ffff800000109906:	48 85 c0             	test   %rax,%rax
ffff800000109909:	0f 85 ac 00 00 00    	jne    ffff8000001099bb <trap+0x29b>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff80000010990f:	48 b8 8f 95 10 00 00 	movabs $0xffff80000010958f,%rax
ffff800000109916:	80 ff ff 
ffff800000109919:	ff d0                	call   *%rax
ffff80000010991b:	49 89 c4             	mov    %rax,%r12
ffff80000010991e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109922:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff800000109929:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff800000109930:	80 ff ff 
ffff800000109933:	ff d0                	call   *%rax
ffff800000109935:	89 c2                	mov    %eax,%edx
ffff800000109937:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010993b:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff80000010993f:	48 bf 18 c5 10 00 00 	movabs $0xffff80000010c518,%rdi
ffff800000109946:	80 ff ff 
ffff800000109949:	4d 89 e0             	mov    %r12,%r8
ffff80000010994c:	48 89 d9             	mov    %rbx,%rcx
ffff80000010994f:	48 89 c6             	mov    %rax,%rsi
ffff800000109952:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109957:	49 b9 04 08 10 00 00 	movabs $0xffff800000100804,%r9
ffff80000010995e:	80 ff ff 
ffff800000109961:	41 ff d1             	call   *%r9
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff800000109964:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010996b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010996f:	48 85 c0             	test   %rax,%rax
ffff800000109972:	74 2e                	je     ffff8000001099a2 <trap+0x282>
        cprintf("proc id: %d\n", proc->pid);
ffff800000109974:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010997b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010997f:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109982:	48 ba 4a c5 10 00 00 	movabs $0xffff80000010c54a,%rdx
ffff800000109989:	80 ff ff 
ffff80000010998c:	89 c6                	mov    %eax,%esi
ffff80000010998e:	48 89 d7             	mov    %rdx,%rdi
ffff800000109991:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109996:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010999d:	80 ff ff 
ffff8000001099a0:	ff d2                	call   *%rdx
      panic("trap");
ffff8000001099a2:	48 b8 57 c5 10 00 00 	movabs $0xffff80000010c557,%rax
ffff8000001099a9:	80 ff ff 
ffff8000001099ac:	48 89 c7             	mov    %rax,%rdi
ffff8000001099af:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001099b6:	80 ff ff 
ffff8000001099b9:	ff d0                	call   *%rax
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff8000001099bb:	48 b8 8f 95 10 00 00 	movabs $0xffff80000010958f,%rax
ffff8000001099c2:	80 ff ff 
ffff8000001099c5:	ff d0                	call   *%rax
ffff8000001099c7:	48 89 c3             	mov    %rax,%rbx
ffff8000001099ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001099ce:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff8000001099d5:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff8000001099dc:	80 ff ff 
ffff8000001099df:	ff d0                	call   *%rax
ffff8000001099e1:	89 c1                	mov    %eax,%ecx
ffff8000001099e3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001099e7:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffff8000001099ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001099f2:	48 8b 50 78          	mov    0x78(%rax),%rdx
            "rip 0x%p addr 0x%p--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff8000001099f6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001099fd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a01:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000109a08:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a0f:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109a13:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109a16:	48 bf 60 c5 10 00 00 	movabs $0xffff80000010c560,%rdi
ffff800000109a1d:	80 ff ff 
ffff800000109a20:	53                   	push   %rbx
ffff800000109a21:	41 54                	push   %r12
ffff800000109a23:	41 89 c9             	mov    %ecx,%r9d
ffff800000109a26:	48 89 d1             	mov    %rdx,%rcx
ffff800000109a29:	48 89 f2             	mov    %rsi,%rdx
ffff800000109a2c:	89 c6                	mov    %eax,%esi
ffff800000109a2e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109a33:	49 ba 04 08 10 00 00 	movabs $0xffff800000100804,%r10
ffff800000109a3a:	80 ff ff 
ffff800000109a3d:	41 ff d2             	call   *%r10
ffff800000109a40:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
    proc->killed = 1;
ffff800000109a44:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a4b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a4f:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff800000109a56:	eb 01                	jmp    ffff800000109a59 <trap+0x339>
    break;
ffff800000109a58:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109a59:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a60:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a64:	48 85 c0             	test   %rax,%rax
ffff800000109a67:	74 32                	je     ffff800000109a9b <trap+0x37b>
ffff800000109a69:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109a70:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109a74:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109a77:	85 c0                	test   %eax,%eax
ffff800000109a79:	74 20                	je     ffff800000109a9b <trap+0x37b>
ffff800000109a7b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a7f:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109a86:	83 e0 03             	and    $0x3,%eax
ffff800000109a89:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109a8d:	75 0c                	jne    ffff800000109a9b <trap+0x37b>
    exit();
ffff800000109a8f:	48 b8 d8 67 10 00 00 	movabs $0xffff8000001067d8,%rax
ffff800000109a96:	80 ff ff 
ffff800000109a99:	ff d0                	call   *%rax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff800000109a9b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109aa2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109aa6:	48 85 c0             	test   %rax,%rax
ffff800000109aa9:	74 2d                	je     ffff800000109ad8 <trap+0x3b8>
ffff800000109aab:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ab2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ab6:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000109ab9:	83 f8 04             	cmp    $0x4,%eax
ffff800000109abc:	75 1a                	jne    ffff800000109ad8 <trap+0x3b8>
ffff800000109abe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ac2:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109ac6:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109aca:	75 0c                	jne    ffff800000109ad8 <trap+0x3b8>
    yield();
ffff800000109acc:	48 b8 a4 6d 10 00 00 	movabs $0xffff800000106da4,%rax
ffff800000109ad3:	80 ff ff 
ffff800000109ad6:	ff d0                	call   *%rax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109ad8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109adf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ae3:	48 85 c0             	test   %rax,%rax
ffff800000109ae6:	74 32                	je     ffff800000109b1a <trap+0x3fa>
ffff800000109ae8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109aef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109af3:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109af6:	85 c0                	test   %eax,%eax
ffff800000109af8:	74 20                	je     ffff800000109b1a <trap+0x3fa>
ffff800000109afa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109afe:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109b05:	83 e0 03             	and    $0x3,%eax
ffff800000109b08:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109b0c:	75 0c                	jne    ffff800000109b1a <trap+0x3fa>
    exit();
ffff800000109b0e:	48 b8 d8 67 10 00 00 	movabs $0xffff8000001067d8,%rax
ffff800000109b15:	80 ff ff 
ffff800000109b18:	ff d0                	call   *%rax
}
ffff800000109b1a:	90                   	nop
ffff800000109b1b:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff800000109b1f:	5b                   	pop    %rbx
ffff800000109b20:	41 5c                	pop    %r12
ffff800000109b22:	5d                   	pop    %rbp
ffff800000109b23:	c3                   	ret

ffff800000109b24 <inb>:
{
ffff800000109b24:	55                   	push   %rbp
ffff800000109b25:	48 89 e5             	mov    %rsp,%rbp
ffff800000109b28:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000109b2c:	89 f8                	mov    %edi,%eax
ffff800000109b2e:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
ffff800000109b32:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000109b36:	89 c2                	mov    %eax,%edx
ffff800000109b38:	ec                   	in     (%dx),%al
ffff800000109b39:	88 45 ff             	mov    %al,-0x1(%rbp)
  return data;
ffff800000109b3c:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
}
ffff800000109b40:	c9                   	leave
ffff800000109b41:	c3                   	ret

ffff800000109b42 <outb>:
{
ffff800000109b42:	55                   	push   %rbp
ffff800000109b43:	48 89 e5             	mov    %rsp,%rbp
ffff800000109b46:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000109b4a:	89 fa                	mov    %edi,%edx
ffff800000109b4c:	89 f0                	mov    %esi,%eax
ffff800000109b4e:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000109b52:	88 45 f8             	mov    %al,-0x8(%rbp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
ffff800000109b55:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000109b59:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000109b5d:	ee                   	out    %al,(%dx)
}
ffff800000109b5e:	90                   	nop
ffff800000109b5f:	c9                   	leave
ffff800000109b60:	c3                   	ret

ffff800000109b61 <uartearlyinit>:

static int uart;    // is there a uart?

void
uartearlyinit(void)
{
ffff800000109b61:	55                   	push   %rbp
ffff800000109b62:	48 89 e5             	mov    %rsp,%rbp
ffff800000109b65:	48 83 ec 10          	sub    $0x10,%rsp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
ffff800000109b69:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109b6e:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff800000109b73:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109b7a:	80 ff ff 
ffff800000109b7d:	ff d0                	call   *%rax

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
ffff800000109b7f:	be 80 00 00 00       	mov    $0x80,%esi
ffff800000109b84:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff800000109b89:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109b90:	80 ff ff 
ffff800000109b93:	ff d0                	call   *%rax
  outb(COM1+0, 115200/9600);
ffff800000109b95:	be 0c 00 00 00       	mov    $0xc,%esi
ffff800000109b9a:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff800000109b9f:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109ba6:	80 ff ff 
ffff800000109ba9:	ff d0                	call   *%rax
  outb(COM1+1, 0);
ffff800000109bab:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109bb0:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff800000109bb5:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109bbc:	80 ff ff 
ffff800000109bbf:	ff d0                	call   *%rax
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
ffff800000109bc1:	be 03 00 00 00       	mov    $0x3,%esi
ffff800000109bc6:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff800000109bcb:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109bd2:	80 ff ff 
ffff800000109bd5:	ff d0                	call   *%rax
  outb(COM1+4, 0);
ffff800000109bd7:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109bdc:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff800000109be1:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109be8:	80 ff ff 
ffff800000109beb:	ff d0                	call   *%rax
  outb(COM1+1, 0x01);    // Enable receive interrupts.
ffff800000109bed:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000109bf2:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff800000109bf7:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109bfe:	80 ff ff 
ffff800000109c01:	ff d0                	call   *%rax

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
ffff800000109c03:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff800000109c08:	48 b8 24 9b 10 00 00 	movabs $0xffff800000109b24,%rax
ffff800000109c0f:	80 ff ff 
ffff800000109c12:	ff d0                	call   *%rax
ffff800000109c14:	3c ff                	cmp    $0xff,%al
ffff800000109c16:	74 4a                	je     ffff800000109c62 <uartearlyinit+0x101>
    return;
  uart = 1;
ffff800000109c18:	48 b8 4c ad 11 00 00 	movabs $0xffff80000011ad4c,%rax
ffff800000109c1f:	80 ff ff 
ffff800000109c22:	c7 00 01 00 00 00    	movl   $0x1,(%rax)



  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
ffff800000109c28:	48 b8 a3 c5 10 00 00 	movabs $0xffff80000010c5a3,%rax
ffff800000109c2f:	80 ff ff 
ffff800000109c32:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109c36:	eb 1d                	jmp    ffff800000109c55 <uartearlyinit+0xf4>
    uartputc(*p);
ffff800000109c38:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c3c:	0f b6 00             	movzbl (%rax),%eax
ffff800000109c3f:	0f be c0             	movsbl %al,%eax
ffff800000109c42:	89 c7                	mov    %eax,%edi
ffff800000109c44:	48 b8 b6 9c 10 00 00 	movabs $0xffff800000109cb6,%rax
ffff800000109c4b:	80 ff ff 
ffff800000109c4e:	ff d0                	call   *%rax
  for(p="xv6...\n"; *p; p++)
ffff800000109c50:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000109c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109c59:	0f b6 00             	movzbl (%rax),%eax
ffff800000109c5c:	84 c0                	test   %al,%al
ffff800000109c5e:	75 d8                	jne    ffff800000109c38 <uartearlyinit+0xd7>
ffff800000109c60:	eb 01                	jmp    ffff800000109c63 <uartearlyinit+0x102>
    return;
ffff800000109c62:	90                   	nop
}
ffff800000109c63:	c9                   	leave
ffff800000109c64:	c3                   	ret

ffff800000109c65 <uartinit>:

void
uartinit(void)
{
ffff800000109c65:	55                   	push   %rbp
ffff800000109c66:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff800000109c69:	48 b8 4c ad 11 00 00 	movabs $0xffff80000011ad4c,%rax
ffff800000109c70:	80 ff ff 
ffff800000109c73:	8b 00                	mov    (%rax),%eax
ffff800000109c75:	85 c0                	test   %eax,%eax
ffff800000109c77:	74 3a                	je     ffff800000109cb3 <uartinit+0x4e>
    return;

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
ffff800000109c79:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff800000109c7e:	48 b8 24 9b 10 00 00 	movabs $0xffff800000109b24,%rax
ffff800000109c85:	80 ff ff 
ffff800000109c88:	ff d0                	call   *%rax
  inb(COM1+0);
ffff800000109c8a:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff800000109c8f:	48 b8 24 9b 10 00 00 	movabs $0xffff800000109b24,%rax
ffff800000109c96:	80 ff ff 
ffff800000109c99:	ff d0                	call   *%rax
  ioapicenable(IRQ_COM1, 0);
ffff800000109c9b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109ca0:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000109ca5:	48 b8 6e 3f 10 00 00 	movabs $0xffff800000103f6e,%rax
ffff800000109cac:	80 ff ff 
ffff800000109caf:	ff d0                	call   *%rax
ffff800000109cb1:	eb 01                	jmp    ffff800000109cb4 <uartinit+0x4f>
    return;
ffff800000109cb3:	90                   	nop

}
ffff800000109cb4:	5d                   	pop    %rbp
ffff800000109cb5:	c3                   	ret

ffff800000109cb6 <uartputc>:
void
uartputc(int c)
{
ffff800000109cb6:	55                   	push   %rbp
ffff800000109cb7:	48 89 e5             	mov    %rsp,%rbp
ffff800000109cba:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000109cbe:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int i;

  if(!uart)
ffff800000109cc1:	48 b8 4c ad 11 00 00 	movabs $0xffff80000011ad4c,%rax
ffff800000109cc8:	80 ff ff 
ffff800000109ccb:	8b 00                	mov    (%rax),%eax
ffff800000109ccd:	85 c0                	test   %eax,%eax
ffff800000109ccf:	74 5a                	je     ffff800000109d2b <uartputc+0x75>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff800000109cd1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109cd8:	eb 15                	jmp    ffff800000109cef <uartputc+0x39>
    microdelay(10);
ffff800000109cda:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000109cdf:	48 b8 bf 47 10 00 00 	movabs $0xffff8000001047bf,%rax
ffff800000109ce6:	80 ff ff 
ffff800000109ce9:	ff d0                	call   *%rax
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
ffff800000109ceb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109cef:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff800000109cf3:	7f 1b                	jg     ffff800000109d10 <uartputc+0x5a>
ffff800000109cf5:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff800000109cfa:	48 b8 24 9b 10 00 00 	movabs $0xffff800000109b24,%rax
ffff800000109d01:	80 ff ff 
ffff800000109d04:	ff d0                	call   *%rax
ffff800000109d06:	0f b6 c0             	movzbl %al,%eax
ffff800000109d09:	83 e0 20             	and    $0x20,%eax
ffff800000109d0c:	85 c0                	test   %eax,%eax
ffff800000109d0e:	74 ca                	je     ffff800000109cda <uartputc+0x24>
  outb(COM1+0, c);
ffff800000109d10:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109d13:	0f b6 c0             	movzbl %al,%eax
ffff800000109d16:	89 c6                	mov    %eax,%esi
ffff800000109d18:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff800000109d1d:	48 b8 42 9b 10 00 00 	movabs $0xffff800000109b42,%rax
ffff800000109d24:	80 ff ff 
ffff800000109d27:	ff d0                	call   *%rax
ffff800000109d29:	eb 01                	jmp    ffff800000109d2c <uartputc+0x76>
    return;
ffff800000109d2b:	90                   	nop
}
ffff800000109d2c:	c9                   	leave
ffff800000109d2d:	c3                   	ret

ffff800000109d2e <uartgetc>:

static int
uartgetc(void)
{
ffff800000109d2e:	55                   	push   %rbp
ffff800000109d2f:	48 89 e5             	mov    %rsp,%rbp
  if(!uart)
ffff800000109d32:	48 b8 4c ad 11 00 00 	movabs $0xffff80000011ad4c,%rax
ffff800000109d39:	80 ff ff 
ffff800000109d3c:	8b 00                	mov    (%rax),%eax
ffff800000109d3e:	85 c0                	test   %eax,%eax
ffff800000109d40:	75 07                	jne    ffff800000109d49 <uartgetc+0x1b>
    return -1;
ffff800000109d42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109d47:	eb 36                	jmp    ffff800000109d7f <uartgetc+0x51>
  if(!(inb(COM1+5) & 0x01))
ffff800000109d49:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff800000109d4e:	48 b8 24 9b 10 00 00 	movabs $0xffff800000109b24,%rax
ffff800000109d55:	80 ff ff 
ffff800000109d58:	ff d0                	call   *%rax
ffff800000109d5a:	0f b6 c0             	movzbl %al,%eax
ffff800000109d5d:	83 e0 01             	and    $0x1,%eax
ffff800000109d60:	85 c0                	test   %eax,%eax
ffff800000109d62:	75 07                	jne    ffff800000109d6b <uartgetc+0x3d>
    return -1;
ffff800000109d64:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109d69:	eb 14                	jmp    ffff800000109d7f <uartgetc+0x51>
  return inb(COM1+0);
ffff800000109d6b:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff800000109d70:	48 b8 24 9b 10 00 00 	movabs $0xffff800000109b24,%rax
ffff800000109d77:	80 ff ff 
ffff800000109d7a:	ff d0                	call   *%rax
ffff800000109d7c:	0f b6 c0             	movzbl %al,%eax
}
ffff800000109d7f:	5d                   	pop    %rbp
ffff800000109d80:	c3                   	ret

ffff800000109d81 <uartintr>:

void
uartintr(void)
{
ffff800000109d81:	55                   	push   %rbp
ffff800000109d82:	48 89 e5             	mov    %rsp,%rbp
  consoleintr(uartgetc);
ffff800000109d85:	48 b8 2e 9d 10 00 00 	movabs $0xffff800000109d2e,%rax
ffff800000109d8c:	80 ff ff 
ffff800000109d8f:	48 89 c7             	mov    %rax,%rdi
ffff800000109d92:	48 b8 6f 0f 10 00 00 	movabs $0xffff800000100f6f,%rax
ffff800000109d99:	80 ff ff 
ffff800000109d9c:	ff d0                	call   *%rax
}
ffff800000109d9e:	90                   	nop
ffff800000109d9f:	5d                   	pop    %rbp
ffff800000109da0:	c3                   	ret

ffff800000109da1 <vector0>:
ffff800000109da1:	6a 00                	push   $0x0
ffff800000109da3:	6a 00                	push   $0x0
ffff800000109da5:	e9 dc f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109daa <vector1>:
ffff800000109daa:	6a 00                	push   $0x0
ffff800000109dac:	6a 01                	push   $0x1
ffff800000109dae:	e9 d3 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109db3 <vector2>:
ffff800000109db3:	6a 00                	push   $0x0
ffff800000109db5:	6a 02                	push   $0x2
ffff800000109db7:	e9 ca f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109dbc <vector3>:
ffff800000109dbc:	6a 00                	push   $0x0
ffff800000109dbe:	6a 03                	push   $0x3
ffff800000109dc0:	e9 c1 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109dc5 <vector4>:
ffff800000109dc5:	6a 00                	push   $0x0
ffff800000109dc7:	6a 04                	push   $0x4
ffff800000109dc9:	e9 b8 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109dce <vector5>:
ffff800000109dce:	6a 00                	push   $0x0
ffff800000109dd0:	6a 05                	push   $0x5
ffff800000109dd2:	e9 af f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109dd7 <vector6>:
ffff800000109dd7:	6a 00                	push   $0x0
ffff800000109dd9:	6a 06                	push   $0x6
ffff800000109ddb:	e9 a6 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109de0 <vector7>:
ffff800000109de0:	6a 00                	push   $0x0
ffff800000109de2:	6a 07                	push   $0x7
ffff800000109de4:	e9 9d f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109de9 <vector8>:
ffff800000109de9:	6a 08                	push   $0x8
ffff800000109deb:	e9 96 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109df0 <vector9>:
ffff800000109df0:	6a 00                	push   $0x0
ffff800000109df2:	6a 09                	push   $0x9
ffff800000109df4:	e9 8d f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109df9 <vector10>:
ffff800000109df9:	6a 0a                	push   $0xa
ffff800000109dfb:	e9 86 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e00 <vector11>:
ffff800000109e00:	6a 0b                	push   $0xb
ffff800000109e02:	e9 7f f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e07 <vector12>:
ffff800000109e07:	6a 0c                	push   $0xc
ffff800000109e09:	e9 78 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e0e <vector13>:
ffff800000109e0e:	6a 0d                	push   $0xd
ffff800000109e10:	e9 71 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e15 <vector14>:
ffff800000109e15:	6a 0e                	push   $0xe
ffff800000109e17:	e9 6a f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e1c <vector15>:
ffff800000109e1c:	6a 00                	push   $0x0
ffff800000109e1e:	6a 0f                	push   $0xf
ffff800000109e20:	e9 61 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e25 <vector16>:
ffff800000109e25:	6a 00                	push   $0x0
ffff800000109e27:	6a 10                	push   $0x10
ffff800000109e29:	e9 58 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e2e <vector17>:
ffff800000109e2e:	6a 11                	push   $0x11
ffff800000109e30:	e9 51 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e35 <vector18>:
ffff800000109e35:	6a 00                	push   $0x0
ffff800000109e37:	6a 12                	push   $0x12
ffff800000109e39:	e9 48 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e3e <vector19>:
ffff800000109e3e:	6a 00                	push   $0x0
ffff800000109e40:	6a 13                	push   $0x13
ffff800000109e42:	e9 3f f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e47 <vector20>:
ffff800000109e47:	6a 00                	push   $0x0
ffff800000109e49:	6a 14                	push   $0x14
ffff800000109e4b:	e9 36 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e50 <vector21>:
ffff800000109e50:	6a 00                	push   $0x0
ffff800000109e52:	6a 15                	push   $0x15
ffff800000109e54:	e9 2d f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e59 <vector22>:
ffff800000109e59:	6a 00                	push   $0x0
ffff800000109e5b:	6a 16                	push   $0x16
ffff800000109e5d:	e9 24 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e62 <vector23>:
ffff800000109e62:	6a 00                	push   $0x0
ffff800000109e64:	6a 17                	push   $0x17
ffff800000109e66:	e9 1b f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e6b <vector24>:
ffff800000109e6b:	6a 00                	push   $0x0
ffff800000109e6d:	6a 18                	push   $0x18
ffff800000109e6f:	e9 12 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e74 <vector25>:
ffff800000109e74:	6a 00                	push   $0x0
ffff800000109e76:	6a 19                	push   $0x19
ffff800000109e78:	e9 09 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e7d <vector26>:
ffff800000109e7d:	6a 00                	push   $0x0
ffff800000109e7f:	6a 1a                	push   $0x1a
ffff800000109e81:	e9 00 f6 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e86 <vector27>:
ffff800000109e86:	6a 00                	push   $0x0
ffff800000109e88:	6a 1b                	push   $0x1b
ffff800000109e8a:	e9 f7 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e8f <vector28>:
ffff800000109e8f:	6a 00                	push   $0x0
ffff800000109e91:	6a 1c                	push   $0x1c
ffff800000109e93:	e9 ee f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109e98 <vector29>:
ffff800000109e98:	6a 00                	push   $0x0
ffff800000109e9a:	6a 1d                	push   $0x1d
ffff800000109e9c:	e9 e5 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ea1 <vector30>:
ffff800000109ea1:	6a 00                	push   $0x0
ffff800000109ea3:	6a 1e                	push   $0x1e
ffff800000109ea5:	e9 dc f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109eaa <vector31>:
ffff800000109eaa:	6a 00                	push   $0x0
ffff800000109eac:	6a 1f                	push   $0x1f
ffff800000109eae:	e9 d3 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109eb3 <vector32>:
ffff800000109eb3:	6a 00                	push   $0x0
ffff800000109eb5:	6a 20                	push   $0x20
ffff800000109eb7:	e9 ca f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ebc <vector33>:
ffff800000109ebc:	6a 00                	push   $0x0
ffff800000109ebe:	6a 21                	push   $0x21
ffff800000109ec0:	e9 c1 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ec5 <vector34>:
ffff800000109ec5:	6a 00                	push   $0x0
ffff800000109ec7:	6a 22                	push   $0x22
ffff800000109ec9:	e9 b8 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ece <vector35>:
ffff800000109ece:	6a 00                	push   $0x0
ffff800000109ed0:	6a 23                	push   $0x23
ffff800000109ed2:	e9 af f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ed7 <vector36>:
ffff800000109ed7:	6a 00                	push   $0x0
ffff800000109ed9:	6a 24                	push   $0x24
ffff800000109edb:	e9 a6 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ee0 <vector37>:
ffff800000109ee0:	6a 00                	push   $0x0
ffff800000109ee2:	6a 25                	push   $0x25
ffff800000109ee4:	e9 9d f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ee9 <vector38>:
ffff800000109ee9:	6a 00                	push   $0x0
ffff800000109eeb:	6a 26                	push   $0x26
ffff800000109eed:	e9 94 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ef2 <vector39>:
ffff800000109ef2:	6a 00                	push   $0x0
ffff800000109ef4:	6a 27                	push   $0x27
ffff800000109ef6:	e9 8b f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109efb <vector40>:
ffff800000109efb:	6a 00                	push   $0x0
ffff800000109efd:	6a 28                	push   $0x28
ffff800000109eff:	e9 82 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f04 <vector41>:
ffff800000109f04:	6a 00                	push   $0x0
ffff800000109f06:	6a 29                	push   $0x29
ffff800000109f08:	e9 79 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f0d <vector42>:
ffff800000109f0d:	6a 00                	push   $0x0
ffff800000109f0f:	6a 2a                	push   $0x2a
ffff800000109f11:	e9 70 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f16 <vector43>:
ffff800000109f16:	6a 00                	push   $0x0
ffff800000109f18:	6a 2b                	push   $0x2b
ffff800000109f1a:	e9 67 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f1f <vector44>:
ffff800000109f1f:	6a 00                	push   $0x0
ffff800000109f21:	6a 2c                	push   $0x2c
ffff800000109f23:	e9 5e f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f28 <vector45>:
ffff800000109f28:	6a 00                	push   $0x0
ffff800000109f2a:	6a 2d                	push   $0x2d
ffff800000109f2c:	e9 55 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f31 <vector46>:
ffff800000109f31:	6a 00                	push   $0x0
ffff800000109f33:	6a 2e                	push   $0x2e
ffff800000109f35:	e9 4c f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f3a <vector47>:
ffff800000109f3a:	6a 00                	push   $0x0
ffff800000109f3c:	6a 2f                	push   $0x2f
ffff800000109f3e:	e9 43 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f43 <vector48>:
ffff800000109f43:	6a 00                	push   $0x0
ffff800000109f45:	6a 30                	push   $0x30
ffff800000109f47:	e9 3a f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f4c <vector49>:
ffff800000109f4c:	6a 00                	push   $0x0
ffff800000109f4e:	6a 31                	push   $0x31
ffff800000109f50:	e9 31 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f55 <vector50>:
ffff800000109f55:	6a 00                	push   $0x0
ffff800000109f57:	6a 32                	push   $0x32
ffff800000109f59:	e9 28 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f5e <vector51>:
ffff800000109f5e:	6a 00                	push   $0x0
ffff800000109f60:	6a 33                	push   $0x33
ffff800000109f62:	e9 1f f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f67 <vector52>:
ffff800000109f67:	6a 00                	push   $0x0
ffff800000109f69:	6a 34                	push   $0x34
ffff800000109f6b:	e9 16 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f70 <vector53>:
ffff800000109f70:	6a 00                	push   $0x0
ffff800000109f72:	6a 35                	push   $0x35
ffff800000109f74:	e9 0d f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f79 <vector54>:
ffff800000109f79:	6a 00                	push   $0x0
ffff800000109f7b:	6a 36                	push   $0x36
ffff800000109f7d:	e9 04 f5 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f82 <vector55>:
ffff800000109f82:	6a 00                	push   $0x0
ffff800000109f84:	6a 37                	push   $0x37
ffff800000109f86:	e9 fb f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f8b <vector56>:
ffff800000109f8b:	6a 00                	push   $0x0
ffff800000109f8d:	6a 38                	push   $0x38
ffff800000109f8f:	e9 f2 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f94 <vector57>:
ffff800000109f94:	6a 00                	push   $0x0
ffff800000109f96:	6a 39                	push   $0x39
ffff800000109f98:	e9 e9 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109f9d <vector58>:
ffff800000109f9d:	6a 00                	push   $0x0
ffff800000109f9f:	6a 3a                	push   $0x3a
ffff800000109fa1:	e9 e0 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fa6 <vector59>:
ffff800000109fa6:	6a 00                	push   $0x0
ffff800000109fa8:	6a 3b                	push   $0x3b
ffff800000109faa:	e9 d7 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109faf <vector60>:
ffff800000109faf:	6a 00                	push   $0x0
ffff800000109fb1:	6a 3c                	push   $0x3c
ffff800000109fb3:	e9 ce f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fb8 <vector61>:
ffff800000109fb8:	6a 00                	push   $0x0
ffff800000109fba:	6a 3d                	push   $0x3d
ffff800000109fbc:	e9 c5 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fc1 <vector62>:
ffff800000109fc1:	6a 00                	push   $0x0
ffff800000109fc3:	6a 3e                	push   $0x3e
ffff800000109fc5:	e9 bc f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fca <vector63>:
ffff800000109fca:	6a 00                	push   $0x0
ffff800000109fcc:	6a 3f                	push   $0x3f
ffff800000109fce:	e9 b3 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fd3 <vector64>:
ffff800000109fd3:	6a 00                	push   $0x0
ffff800000109fd5:	6a 40                	push   $0x40
ffff800000109fd7:	e9 aa f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fdc <vector65>:
ffff800000109fdc:	6a 00                	push   $0x0
ffff800000109fde:	6a 41                	push   $0x41
ffff800000109fe0:	e9 a1 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fe5 <vector66>:
ffff800000109fe5:	6a 00                	push   $0x0
ffff800000109fe7:	6a 42                	push   $0x42
ffff800000109fe9:	e9 98 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109fee <vector67>:
ffff800000109fee:	6a 00                	push   $0x0
ffff800000109ff0:	6a 43                	push   $0x43
ffff800000109ff2:	e9 8f f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff800000109ff7 <vector68>:
ffff800000109ff7:	6a 00                	push   $0x0
ffff800000109ff9:	6a 44                	push   $0x44
ffff800000109ffb:	e9 86 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a000 <vector69>:
ffff80000010a000:	6a 00                	push   $0x0
ffff80000010a002:	6a 45                	push   $0x45
ffff80000010a004:	e9 7d f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a009 <vector70>:
ffff80000010a009:	6a 00                	push   $0x0
ffff80000010a00b:	6a 46                	push   $0x46
ffff80000010a00d:	e9 74 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a012 <vector71>:
ffff80000010a012:	6a 00                	push   $0x0
ffff80000010a014:	6a 47                	push   $0x47
ffff80000010a016:	e9 6b f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a01b <vector72>:
ffff80000010a01b:	6a 00                	push   $0x0
ffff80000010a01d:	6a 48                	push   $0x48
ffff80000010a01f:	e9 62 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a024 <vector73>:
ffff80000010a024:	6a 00                	push   $0x0
ffff80000010a026:	6a 49                	push   $0x49
ffff80000010a028:	e9 59 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a02d <vector74>:
ffff80000010a02d:	6a 00                	push   $0x0
ffff80000010a02f:	6a 4a                	push   $0x4a
ffff80000010a031:	e9 50 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a036 <vector75>:
ffff80000010a036:	6a 00                	push   $0x0
ffff80000010a038:	6a 4b                	push   $0x4b
ffff80000010a03a:	e9 47 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a03f <vector76>:
ffff80000010a03f:	6a 00                	push   $0x0
ffff80000010a041:	6a 4c                	push   $0x4c
ffff80000010a043:	e9 3e f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a048 <vector77>:
ffff80000010a048:	6a 00                	push   $0x0
ffff80000010a04a:	6a 4d                	push   $0x4d
ffff80000010a04c:	e9 35 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a051 <vector78>:
ffff80000010a051:	6a 00                	push   $0x0
ffff80000010a053:	6a 4e                	push   $0x4e
ffff80000010a055:	e9 2c f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a05a <vector79>:
ffff80000010a05a:	6a 00                	push   $0x0
ffff80000010a05c:	6a 4f                	push   $0x4f
ffff80000010a05e:	e9 23 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a063 <vector80>:
ffff80000010a063:	6a 00                	push   $0x0
ffff80000010a065:	6a 50                	push   $0x50
ffff80000010a067:	e9 1a f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a06c <vector81>:
ffff80000010a06c:	6a 00                	push   $0x0
ffff80000010a06e:	6a 51                	push   $0x51
ffff80000010a070:	e9 11 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a075 <vector82>:
ffff80000010a075:	6a 00                	push   $0x0
ffff80000010a077:	6a 52                	push   $0x52
ffff80000010a079:	e9 08 f4 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a07e <vector83>:
ffff80000010a07e:	6a 00                	push   $0x0
ffff80000010a080:	6a 53                	push   $0x53
ffff80000010a082:	e9 ff f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a087 <vector84>:
ffff80000010a087:	6a 00                	push   $0x0
ffff80000010a089:	6a 54                	push   $0x54
ffff80000010a08b:	e9 f6 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a090 <vector85>:
ffff80000010a090:	6a 00                	push   $0x0
ffff80000010a092:	6a 55                	push   $0x55
ffff80000010a094:	e9 ed f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a099 <vector86>:
ffff80000010a099:	6a 00                	push   $0x0
ffff80000010a09b:	6a 56                	push   $0x56
ffff80000010a09d:	e9 e4 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0a2 <vector87>:
ffff80000010a0a2:	6a 00                	push   $0x0
ffff80000010a0a4:	6a 57                	push   $0x57
ffff80000010a0a6:	e9 db f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0ab <vector88>:
ffff80000010a0ab:	6a 00                	push   $0x0
ffff80000010a0ad:	6a 58                	push   $0x58
ffff80000010a0af:	e9 d2 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0b4 <vector89>:
ffff80000010a0b4:	6a 00                	push   $0x0
ffff80000010a0b6:	6a 59                	push   $0x59
ffff80000010a0b8:	e9 c9 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0bd <vector90>:
ffff80000010a0bd:	6a 00                	push   $0x0
ffff80000010a0bf:	6a 5a                	push   $0x5a
ffff80000010a0c1:	e9 c0 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0c6 <vector91>:
ffff80000010a0c6:	6a 00                	push   $0x0
ffff80000010a0c8:	6a 5b                	push   $0x5b
ffff80000010a0ca:	e9 b7 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0cf <vector92>:
ffff80000010a0cf:	6a 00                	push   $0x0
ffff80000010a0d1:	6a 5c                	push   $0x5c
ffff80000010a0d3:	e9 ae f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0d8 <vector93>:
ffff80000010a0d8:	6a 00                	push   $0x0
ffff80000010a0da:	6a 5d                	push   $0x5d
ffff80000010a0dc:	e9 a5 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0e1 <vector94>:
ffff80000010a0e1:	6a 00                	push   $0x0
ffff80000010a0e3:	6a 5e                	push   $0x5e
ffff80000010a0e5:	e9 9c f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0ea <vector95>:
ffff80000010a0ea:	6a 00                	push   $0x0
ffff80000010a0ec:	6a 5f                	push   $0x5f
ffff80000010a0ee:	e9 93 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0f3 <vector96>:
ffff80000010a0f3:	6a 00                	push   $0x0
ffff80000010a0f5:	6a 60                	push   $0x60
ffff80000010a0f7:	e9 8a f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a0fc <vector97>:
ffff80000010a0fc:	6a 00                	push   $0x0
ffff80000010a0fe:	6a 61                	push   $0x61
ffff80000010a100:	e9 81 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a105 <vector98>:
ffff80000010a105:	6a 00                	push   $0x0
ffff80000010a107:	6a 62                	push   $0x62
ffff80000010a109:	e9 78 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a10e <vector99>:
ffff80000010a10e:	6a 00                	push   $0x0
ffff80000010a110:	6a 63                	push   $0x63
ffff80000010a112:	e9 6f f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a117 <vector100>:
ffff80000010a117:	6a 00                	push   $0x0
ffff80000010a119:	6a 64                	push   $0x64
ffff80000010a11b:	e9 66 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a120 <vector101>:
ffff80000010a120:	6a 00                	push   $0x0
ffff80000010a122:	6a 65                	push   $0x65
ffff80000010a124:	e9 5d f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a129 <vector102>:
ffff80000010a129:	6a 00                	push   $0x0
ffff80000010a12b:	6a 66                	push   $0x66
ffff80000010a12d:	e9 54 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a132 <vector103>:
ffff80000010a132:	6a 00                	push   $0x0
ffff80000010a134:	6a 67                	push   $0x67
ffff80000010a136:	e9 4b f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a13b <vector104>:
ffff80000010a13b:	6a 00                	push   $0x0
ffff80000010a13d:	6a 68                	push   $0x68
ffff80000010a13f:	e9 42 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a144 <vector105>:
ffff80000010a144:	6a 00                	push   $0x0
ffff80000010a146:	6a 69                	push   $0x69
ffff80000010a148:	e9 39 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a14d <vector106>:
ffff80000010a14d:	6a 00                	push   $0x0
ffff80000010a14f:	6a 6a                	push   $0x6a
ffff80000010a151:	e9 30 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a156 <vector107>:
ffff80000010a156:	6a 00                	push   $0x0
ffff80000010a158:	6a 6b                	push   $0x6b
ffff80000010a15a:	e9 27 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a15f <vector108>:
ffff80000010a15f:	6a 00                	push   $0x0
ffff80000010a161:	6a 6c                	push   $0x6c
ffff80000010a163:	e9 1e f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a168 <vector109>:
ffff80000010a168:	6a 00                	push   $0x0
ffff80000010a16a:	6a 6d                	push   $0x6d
ffff80000010a16c:	e9 15 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a171 <vector110>:
ffff80000010a171:	6a 00                	push   $0x0
ffff80000010a173:	6a 6e                	push   $0x6e
ffff80000010a175:	e9 0c f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a17a <vector111>:
ffff80000010a17a:	6a 00                	push   $0x0
ffff80000010a17c:	6a 6f                	push   $0x6f
ffff80000010a17e:	e9 03 f3 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a183 <vector112>:
ffff80000010a183:	6a 00                	push   $0x0
ffff80000010a185:	6a 70                	push   $0x70
ffff80000010a187:	e9 fa f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a18c <vector113>:
ffff80000010a18c:	6a 00                	push   $0x0
ffff80000010a18e:	6a 71                	push   $0x71
ffff80000010a190:	e9 f1 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a195 <vector114>:
ffff80000010a195:	6a 00                	push   $0x0
ffff80000010a197:	6a 72                	push   $0x72
ffff80000010a199:	e9 e8 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a19e <vector115>:
ffff80000010a19e:	6a 00                	push   $0x0
ffff80000010a1a0:	6a 73                	push   $0x73
ffff80000010a1a2:	e9 df f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1a7 <vector116>:
ffff80000010a1a7:	6a 00                	push   $0x0
ffff80000010a1a9:	6a 74                	push   $0x74
ffff80000010a1ab:	e9 d6 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1b0 <vector117>:
ffff80000010a1b0:	6a 00                	push   $0x0
ffff80000010a1b2:	6a 75                	push   $0x75
ffff80000010a1b4:	e9 cd f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1b9 <vector118>:
ffff80000010a1b9:	6a 00                	push   $0x0
ffff80000010a1bb:	6a 76                	push   $0x76
ffff80000010a1bd:	e9 c4 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1c2 <vector119>:
ffff80000010a1c2:	6a 00                	push   $0x0
ffff80000010a1c4:	6a 77                	push   $0x77
ffff80000010a1c6:	e9 bb f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1cb <vector120>:
ffff80000010a1cb:	6a 00                	push   $0x0
ffff80000010a1cd:	6a 78                	push   $0x78
ffff80000010a1cf:	e9 b2 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1d4 <vector121>:
ffff80000010a1d4:	6a 00                	push   $0x0
ffff80000010a1d6:	6a 79                	push   $0x79
ffff80000010a1d8:	e9 a9 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1dd <vector122>:
ffff80000010a1dd:	6a 00                	push   $0x0
ffff80000010a1df:	6a 7a                	push   $0x7a
ffff80000010a1e1:	e9 a0 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1e6 <vector123>:
ffff80000010a1e6:	6a 00                	push   $0x0
ffff80000010a1e8:	6a 7b                	push   $0x7b
ffff80000010a1ea:	e9 97 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1ef <vector124>:
ffff80000010a1ef:	6a 00                	push   $0x0
ffff80000010a1f1:	6a 7c                	push   $0x7c
ffff80000010a1f3:	e9 8e f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a1f8 <vector125>:
ffff80000010a1f8:	6a 00                	push   $0x0
ffff80000010a1fa:	6a 7d                	push   $0x7d
ffff80000010a1fc:	e9 85 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a201 <vector126>:
ffff80000010a201:	6a 00                	push   $0x0
ffff80000010a203:	6a 7e                	push   $0x7e
ffff80000010a205:	e9 7c f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a20a <vector127>:
ffff80000010a20a:	6a 00                	push   $0x0
ffff80000010a20c:	6a 7f                	push   $0x7f
ffff80000010a20e:	e9 73 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a213 <vector128>:
ffff80000010a213:	6a 00                	push   $0x0
ffff80000010a215:	68 80 00 00 00       	push   $0x80
ffff80000010a21a:	e9 67 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a21f <vector129>:
ffff80000010a21f:	6a 00                	push   $0x0
ffff80000010a221:	68 81 00 00 00       	push   $0x81
ffff80000010a226:	e9 5b f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a22b <vector130>:
ffff80000010a22b:	6a 00                	push   $0x0
ffff80000010a22d:	68 82 00 00 00       	push   $0x82
ffff80000010a232:	e9 4f f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a237 <vector131>:
ffff80000010a237:	6a 00                	push   $0x0
ffff80000010a239:	68 83 00 00 00       	push   $0x83
ffff80000010a23e:	e9 43 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a243 <vector132>:
ffff80000010a243:	6a 00                	push   $0x0
ffff80000010a245:	68 84 00 00 00       	push   $0x84
ffff80000010a24a:	e9 37 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a24f <vector133>:
ffff80000010a24f:	6a 00                	push   $0x0
ffff80000010a251:	68 85 00 00 00       	push   $0x85
ffff80000010a256:	e9 2b f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a25b <vector134>:
ffff80000010a25b:	6a 00                	push   $0x0
ffff80000010a25d:	68 86 00 00 00       	push   $0x86
ffff80000010a262:	e9 1f f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a267 <vector135>:
ffff80000010a267:	6a 00                	push   $0x0
ffff80000010a269:	68 87 00 00 00       	push   $0x87
ffff80000010a26e:	e9 13 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a273 <vector136>:
ffff80000010a273:	6a 00                	push   $0x0
ffff80000010a275:	68 88 00 00 00       	push   $0x88
ffff80000010a27a:	e9 07 f2 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a27f <vector137>:
ffff80000010a27f:	6a 00                	push   $0x0
ffff80000010a281:	68 89 00 00 00       	push   $0x89
ffff80000010a286:	e9 fb f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a28b <vector138>:
ffff80000010a28b:	6a 00                	push   $0x0
ffff80000010a28d:	68 8a 00 00 00       	push   $0x8a
ffff80000010a292:	e9 ef f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a297 <vector139>:
ffff80000010a297:	6a 00                	push   $0x0
ffff80000010a299:	68 8b 00 00 00       	push   $0x8b
ffff80000010a29e:	e9 e3 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2a3 <vector140>:
ffff80000010a2a3:	6a 00                	push   $0x0
ffff80000010a2a5:	68 8c 00 00 00       	push   $0x8c
ffff80000010a2aa:	e9 d7 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2af <vector141>:
ffff80000010a2af:	6a 00                	push   $0x0
ffff80000010a2b1:	68 8d 00 00 00       	push   $0x8d
ffff80000010a2b6:	e9 cb f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2bb <vector142>:
ffff80000010a2bb:	6a 00                	push   $0x0
ffff80000010a2bd:	68 8e 00 00 00       	push   $0x8e
ffff80000010a2c2:	e9 bf f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2c7 <vector143>:
ffff80000010a2c7:	6a 00                	push   $0x0
ffff80000010a2c9:	68 8f 00 00 00       	push   $0x8f
ffff80000010a2ce:	e9 b3 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2d3 <vector144>:
ffff80000010a2d3:	6a 00                	push   $0x0
ffff80000010a2d5:	68 90 00 00 00       	push   $0x90
ffff80000010a2da:	e9 a7 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2df <vector145>:
ffff80000010a2df:	6a 00                	push   $0x0
ffff80000010a2e1:	68 91 00 00 00       	push   $0x91
ffff80000010a2e6:	e9 9b f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2eb <vector146>:
ffff80000010a2eb:	6a 00                	push   $0x0
ffff80000010a2ed:	68 92 00 00 00       	push   $0x92
ffff80000010a2f2:	e9 8f f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a2f7 <vector147>:
ffff80000010a2f7:	6a 00                	push   $0x0
ffff80000010a2f9:	68 93 00 00 00       	push   $0x93
ffff80000010a2fe:	e9 83 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a303 <vector148>:
ffff80000010a303:	6a 00                	push   $0x0
ffff80000010a305:	68 94 00 00 00       	push   $0x94
ffff80000010a30a:	e9 77 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a30f <vector149>:
ffff80000010a30f:	6a 00                	push   $0x0
ffff80000010a311:	68 95 00 00 00       	push   $0x95
ffff80000010a316:	e9 6b f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a31b <vector150>:
ffff80000010a31b:	6a 00                	push   $0x0
ffff80000010a31d:	68 96 00 00 00       	push   $0x96
ffff80000010a322:	e9 5f f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a327 <vector151>:
ffff80000010a327:	6a 00                	push   $0x0
ffff80000010a329:	68 97 00 00 00       	push   $0x97
ffff80000010a32e:	e9 53 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a333 <vector152>:
ffff80000010a333:	6a 00                	push   $0x0
ffff80000010a335:	68 98 00 00 00       	push   $0x98
ffff80000010a33a:	e9 47 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a33f <vector153>:
ffff80000010a33f:	6a 00                	push   $0x0
ffff80000010a341:	68 99 00 00 00       	push   $0x99
ffff80000010a346:	e9 3b f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a34b <vector154>:
ffff80000010a34b:	6a 00                	push   $0x0
ffff80000010a34d:	68 9a 00 00 00       	push   $0x9a
ffff80000010a352:	e9 2f f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a357 <vector155>:
ffff80000010a357:	6a 00                	push   $0x0
ffff80000010a359:	68 9b 00 00 00       	push   $0x9b
ffff80000010a35e:	e9 23 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a363 <vector156>:
ffff80000010a363:	6a 00                	push   $0x0
ffff80000010a365:	68 9c 00 00 00       	push   $0x9c
ffff80000010a36a:	e9 17 f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a36f <vector157>:
ffff80000010a36f:	6a 00                	push   $0x0
ffff80000010a371:	68 9d 00 00 00       	push   $0x9d
ffff80000010a376:	e9 0b f1 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a37b <vector158>:
ffff80000010a37b:	6a 00                	push   $0x0
ffff80000010a37d:	68 9e 00 00 00       	push   $0x9e
ffff80000010a382:	e9 ff f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a387 <vector159>:
ffff80000010a387:	6a 00                	push   $0x0
ffff80000010a389:	68 9f 00 00 00       	push   $0x9f
ffff80000010a38e:	e9 f3 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a393 <vector160>:
ffff80000010a393:	6a 00                	push   $0x0
ffff80000010a395:	68 a0 00 00 00       	push   $0xa0
ffff80000010a39a:	e9 e7 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a39f <vector161>:
ffff80000010a39f:	6a 00                	push   $0x0
ffff80000010a3a1:	68 a1 00 00 00       	push   $0xa1
ffff80000010a3a6:	e9 db f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3ab <vector162>:
ffff80000010a3ab:	6a 00                	push   $0x0
ffff80000010a3ad:	68 a2 00 00 00       	push   $0xa2
ffff80000010a3b2:	e9 cf f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3b7 <vector163>:
ffff80000010a3b7:	6a 00                	push   $0x0
ffff80000010a3b9:	68 a3 00 00 00       	push   $0xa3
ffff80000010a3be:	e9 c3 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3c3 <vector164>:
ffff80000010a3c3:	6a 00                	push   $0x0
ffff80000010a3c5:	68 a4 00 00 00       	push   $0xa4
ffff80000010a3ca:	e9 b7 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3cf <vector165>:
ffff80000010a3cf:	6a 00                	push   $0x0
ffff80000010a3d1:	68 a5 00 00 00       	push   $0xa5
ffff80000010a3d6:	e9 ab f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3db <vector166>:
ffff80000010a3db:	6a 00                	push   $0x0
ffff80000010a3dd:	68 a6 00 00 00       	push   $0xa6
ffff80000010a3e2:	e9 9f f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3e7 <vector167>:
ffff80000010a3e7:	6a 00                	push   $0x0
ffff80000010a3e9:	68 a7 00 00 00       	push   $0xa7
ffff80000010a3ee:	e9 93 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3f3 <vector168>:
ffff80000010a3f3:	6a 00                	push   $0x0
ffff80000010a3f5:	68 a8 00 00 00       	push   $0xa8
ffff80000010a3fa:	e9 87 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a3ff <vector169>:
ffff80000010a3ff:	6a 00                	push   $0x0
ffff80000010a401:	68 a9 00 00 00       	push   $0xa9
ffff80000010a406:	e9 7b f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a40b <vector170>:
ffff80000010a40b:	6a 00                	push   $0x0
ffff80000010a40d:	68 aa 00 00 00       	push   $0xaa
ffff80000010a412:	e9 6f f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a417 <vector171>:
ffff80000010a417:	6a 00                	push   $0x0
ffff80000010a419:	68 ab 00 00 00       	push   $0xab
ffff80000010a41e:	e9 63 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a423 <vector172>:
ffff80000010a423:	6a 00                	push   $0x0
ffff80000010a425:	68 ac 00 00 00       	push   $0xac
ffff80000010a42a:	e9 57 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a42f <vector173>:
ffff80000010a42f:	6a 00                	push   $0x0
ffff80000010a431:	68 ad 00 00 00       	push   $0xad
ffff80000010a436:	e9 4b f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a43b <vector174>:
ffff80000010a43b:	6a 00                	push   $0x0
ffff80000010a43d:	68 ae 00 00 00       	push   $0xae
ffff80000010a442:	e9 3f f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a447 <vector175>:
ffff80000010a447:	6a 00                	push   $0x0
ffff80000010a449:	68 af 00 00 00       	push   $0xaf
ffff80000010a44e:	e9 33 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a453 <vector176>:
ffff80000010a453:	6a 00                	push   $0x0
ffff80000010a455:	68 b0 00 00 00       	push   $0xb0
ffff80000010a45a:	e9 27 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a45f <vector177>:
ffff80000010a45f:	6a 00                	push   $0x0
ffff80000010a461:	68 b1 00 00 00       	push   $0xb1
ffff80000010a466:	e9 1b f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a46b <vector178>:
ffff80000010a46b:	6a 00                	push   $0x0
ffff80000010a46d:	68 b2 00 00 00       	push   $0xb2
ffff80000010a472:	e9 0f f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a477 <vector179>:
ffff80000010a477:	6a 00                	push   $0x0
ffff80000010a479:	68 b3 00 00 00       	push   $0xb3
ffff80000010a47e:	e9 03 f0 ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a483 <vector180>:
ffff80000010a483:	6a 00                	push   $0x0
ffff80000010a485:	68 b4 00 00 00       	push   $0xb4
ffff80000010a48a:	e9 f7 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a48f <vector181>:
ffff80000010a48f:	6a 00                	push   $0x0
ffff80000010a491:	68 b5 00 00 00       	push   $0xb5
ffff80000010a496:	e9 eb ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a49b <vector182>:
ffff80000010a49b:	6a 00                	push   $0x0
ffff80000010a49d:	68 b6 00 00 00       	push   $0xb6
ffff80000010a4a2:	e9 df ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4a7 <vector183>:
ffff80000010a4a7:	6a 00                	push   $0x0
ffff80000010a4a9:	68 b7 00 00 00       	push   $0xb7
ffff80000010a4ae:	e9 d3 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4b3 <vector184>:
ffff80000010a4b3:	6a 00                	push   $0x0
ffff80000010a4b5:	68 b8 00 00 00       	push   $0xb8
ffff80000010a4ba:	e9 c7 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4bf <vector185>:
ffff80000010a4bf:	6a 00                	push   $0x0
ffff80000010a4c1:	68 b9 00 00 00       	push   $0xb9
ffff80000010a4c6:	e9 bb ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4cb <vector186>:
ffff80000010a4cb:	6a 00                	push   $0x0
ffff80000010a4cd:	68 ba 00 00 00       	push   $0xba
ffff80000010a4d2:	e9 af ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4d7 <vector187>:
ffff80000010a4d7:	6a 00                	push   $0x0
ffff80000010a4d9:	68 bb 00 00 00       	push   $0xbb
ffff80000010a4de:	e9 a3 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4e3 <vector188>:
ffff80000010a4e3:	6a 00                	push   $0x0
ffff80000010a4e5:	68 bc 00 00 00       	push   $0xbc
ffff80000010a4ea:	e9 97 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4ef <vector189>:
ffff80000010a4ef:	6a 00                	push   $0x0
ffff80000010a4f1:	68 bd 00 00 00       	push   $0xbd
ffff80000010a4f6:	e9 8b ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a4fb <vector190>:
ffff80000010a4fb:	6a 00                	push   $0x0
ffff80000010a4fd:	68 be 00 00 00       	push   $0xbe
ffff80000010a502:	e9 7f ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a507 <vector191>:
ffff80000010a507:	6a 00                	push   $0x0
ffff80000010a509:	68 bf 00 00 00       	push   $0xbf
ffff80000010a50e:	e9 73 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a513 <vector192>:
ffff80000010a513:	6a 00                	push   $0x0
ffff80000010a515:	68 c0 00 00 00       	push   $0xc0
ffff80000010a51a:	e9 67 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a51f <vector193>:
ffff80000010a51f:	6a 00                	push   $0x0
ffff80000010a521:	68 c1 00 00 00       	push   $0xc1
ffff80000010a526:	e9 5b ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a52b <vector194>:
ffff80000010a52b:	6a 00                	push   $0x0
ffff80000010a52d:	68 c2 00 00 00       	push   $0xc2
ffff80000010a532:	e9 4f ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a537 <vector195>:
ffff80000010a537:	6a 00                	push   $0x0
ffff80000010a539:	68 c3 00 00 00       	push   $0xc3
ffff80000010a53e:	e9 43 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a543 <vector196>:
ffff80000010a543:	6a 00                	push   $0x0
ffff80000010a545:	68 c4 00 00 00       	push   $0xc4
ffff80000010a54a:	e9 37 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a54f <vector197>:
ffff80000010a54f:	6a 00                	push   $0x0
ffff80000010a551:	68 c5 00 00 00       	push   $0xc5
ffff80000010a556:	e9 2b ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a55b <vector198>:
ffff80000010a55b:	6a 00                	push   $0x0
ffff80000010a55d:	68 c6 00 00 00       	push   $0xc6
ffff80000010a562:	e9 1f ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a567 <vector199>:
ffff80000010a567:	6a 00                	push   $0x0
ffff80000010a569:	68 c7 00 00 00       	push   $0xc7
ffff80000010a56e:	e9 13 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a573 <vector200>:
ffff80000010a573:	6a 00                	push   $0x0
ffff80000010a575:	68 c8 00 00 00       	push   $0xc8
ffff80000010a57a:	e9 07 ef ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a57f <vector201>:
ffff80000010a57f:	6a 00                	push   $0x0
ffff80000010a581:	68 c9 00 00 00       	push   $0xc9
ffff80000010a586:	e9 fb ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a58b <vector202>:
ffff80000010a58b:	6a 00                	push   $0x0
ffff80000010a58d:	68 ca 00 00 00       	push   $0xca
ffff80000010a592:	e9 ef ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a597 <vector203>:
ffff80000010a597:	6a 00                	push   $0x0
ffff80000010a599:	68 cb 00 00 00       	push   $0xcb
ffff80000010a59e:	e9 e3 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5a3 <vector204>:
ffff80000010a5a3:	6a 00                	push   $0x0
ffff80000010a5a5:	68 cc 00 00 00       	push   $0xcc
ffff80000010a5aa:	e9 d7 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5af <vector205>:
ffff80000010a5af:	6a 00                	push   $0x0
ffff80000010a5b1:	68 cd 00 00 00       	push   $0xcd
ffff80000010a5b6:	e9 cb ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5bb <vector206>:
ffff80000010a5bb:	6a 00                	push   $0x0
ffff80000010a5bd:	68 ce 00 00 00       	push   $0xce
ffff80000010a5c2:	e9 bf ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5c7 <vector207>:
ffff80000010a5c7:	6a 00                	push   $0x0
ffff80000010a5c9:	68 cf 00 00 00       	push   $0xcf
ffff80000010a5ce:	e9 b3 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5d3 <vector208>:
ffff80000010a5d3:	6a 00                	push   $0x0
ffff80000010a5d5:	68 d0 00 00 00       	push   $0xd0
ffff80000010a5da:	e9 a7 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5df <vector209>:
ffff80000010a5df:	6a 00                	push   $0x0
ffff80000010a5e1:	68 d1 00 00 00       	push   $0xd1
ffff80000010a5e6:	e9 9b ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5eb <vector210>:
ffff80000010a5eb:	6a 00                	push   $0x0
ffff80000010a5ed:	68 d2 00 00 00       	push   $0xd2
ffff80000010a5f2:	e9 8f ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a5f7 <vector211>:
ffff80000010a5f7:	6a 00                	push   $0x0
ffff80000010a5f9:	68 d3 00 00 00       	push   $0xd3
ffff80000010a5fe:	e9 83 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a603 <vector212>:
ffff80000010a603:	6a 00                	push   $0x0
ffff80000010a605:	68 d4 00 00 00       	push   $0xd4
ffff80000010a60a:	e9 77 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a60f <vector213>:
ffff80000010a60f:	6a 00                	push   $0x0
ffff80000010a611:	68 d5 00 00 00       	push   $0xd5
ffff80000010a616:	e9 6b ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a61b <vector214>:
ffff80000010a61b:	6a 00                	push   $0x0
ffff80000010a61d:	68 d6 00 00 00       	push   $0xd6
ffff80000010a622:	e9 5f ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a627 <vector215>:
ffff80000010a627:	6a 00                	push   $0x0
ffff80000010a629:	68 d7 00 00 00       	push   $0xd7
ffff80000010a62e:	e9 53 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a633 <vector216>:
ffff80000010a633:	6a 00                	push   $0x0
ffff80000010a635:	68 d8 00 00 00       	push   $0xd8
ffff80000010a63a:	e9 47 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a63f <vector217>:
ffff80000010a63f:	6a 00                	push   $0x0
ffff80000010a641:	68 d9 00 00 00       	push   $0xd9
ffff80000010a646:	e9 3b ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a64b <vector218>:
ffff80000010a64b:	6a 00                	push   $0x0
ffff80000010a64d:	68 da 00 00 00       	push   $0xda
ffff80000010a652:	e9 2f ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a657 <vector219>:
ffff80000010a657:	6a 00                	push   $0x0
ffff80000010a659:	68 db 00 00 00       	push   $0xdb
ffff80000010a65e:	e9 23 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a663 <vector220>:
ffff80000010a663:	6a 00                	push   $0x0
ffff80000010a665:	68 dc 00 00 00       	push   $0xdc
ffff80000010a66a:	e9 17 ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a66f <vector221>:
ffff80000010a66f:	6a 00                	push   $0x0
ffff80000010a671:	68 dd 00 00 00       	push   $0xdd
ffff80000010a676:	e9 0b ee ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a67b <vector222>:
ffff80000010a67b:	6a 00                	push   $0x0
ffff80000010a67d:	68 de 00 00 00       	push   $0xde
ffff80000010a682:	e9 ff ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a687 <vector223>:
ffff80000010a687:	6a 00                	push   $0x0
ffff80000010a689:	68 df 00 00 00       	push   $0xdf
ffff80000010a68e:	e9 f3 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a693 <vector224>:
ffff80000010a693:	6a 00                	push   $0x0
ffff80000010a695:	68 e0 00 00 00       	push   $0xe0
ffff80000010a69a:	e9 e7 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a69f <vector225>:
ffff80000010a69f:	6a 00                	push   $0x0
ffff80000010a6a1:	68 e1 00 00 00       	push   $0xe1
ffff80000010a6a6:	e9 db ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6ab <vector226>:
ffff80000010a6ab:	6a 00                	push   $0x0
ffff80000010a6ad:	68 e2 00 00 00       	push   $0xe2
ffff80000010a6b2:	e9 cf ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6b7 <vector227>:
ffff80000010a6b7:	6a 00                	push   $0x0
ffff80000010a6b9:	68 e3 00 00 00       	push   $0xe3
ffff80000010a6be:	e9 c3 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6c3 <vector228>:
ffff80000010a6c3:	6a 00                	push   $0x0
ffff80000010a6c5:	68 e4 00 00 00       	push   $0xe4
ffff80000010a6ca:	e9 b7 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6cf <vector229>:
ffff80000010a6cf:	6a 00                	push   $0x0
ffff80000010a6d1:	68 e5 00 00 00       	push   $0xe5
ffff80000010a6d6:	e9 ab ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6db <vector230>:
ffff80000010a6db:	6a 00                	push   $0x0
ffff80000010a6dd:	68 e6 00 00 00       	push   $0xe6
ffff80000010a6e2:	e9 9f ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6e7 <vector231>:
ffff80000010a6e7:	6a 00                	push   $0x0
ffff80000010a6e9:	68 e7 00 00 00       	push   $0xe7
ffff80000010a6ee:	e9 93 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6f3 <vector232>:
ffff80000010a6f3:	6a 00                	push   $0x0
ffff80000010a6f5:	68 e8 00 00 00       	push   $0xe8
ffff80000010a6fa:	e9 87 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a6ff <vector233>:
ffff80000010a6ff:	6a 00                	push   $0x0
ffff80000010a701:	68 e9 00 00 00       	push   $0xe9
ffff80000010a706:	e9 7b ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a70b <vector234>:
ffff80000010a70b:	6a 00                	push   $0x0
ffff80000010a70d:	68 ea 00 00 00       	push   $0xea
ffff80000010a712:	e9 6f ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a717 <vector235>:
ffff80000010a717:	6a 00                	push   $0x0
ffff80000010a719:	68 eb 00 00 00       	push   $0xeb
ffff80000010a71e:	e9 63 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a723 <vector236>:
ffff80000010a723:	6a 00                	push   $0x0
ffff80000010a725:	68 ec 00 00 00       	push   $0xec
ffff80000010a72a:	e9 57 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a72f <vector237>:
ffff80000010a72f:	6a 00                	push   $0x0
ffff80000010a731:	68 ed 00 00 00       	push   $0xed
ffff80000010a736:	e9 4b ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a73b <vector238>:
ffff80000010a73b:	6a 00                	push   $0x0
ffff80000010a73d:	68 ee 00 00 00       	push   $0xee
ffff80000010a742:	e9 3f ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a747 <vector239>:
ffff80000010a747:	6a 00                	push   $0x0
ffff80000010a749:	68 ef 00 00 00       	push   $0xef
ffff80000010a74e:	e9 33 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a753 <vector240>:
ffff80000010a753:	6a 00                	push   $0x0
ffff80000010a755:	68 f0 00 00 00       	push   $0xf0
ffff80000010a75a:	e9 27 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a75f <vector241>:
ffff80000010a75f:	6a 00                	push   $0x0
ffff80000010a761:	68 f1 00 00 00       	push   $0xf1
ffff80000010a766:	e9 1b ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a76b <vector242>:
ffff80000010a76b:	6a 00                	push   $0x0
ffff80000010a76d:	68 f2 00 00 00       	push   $0xf2
ffff80000010a772:	e9 0f ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a777 <vector243>:
ffff80000010a777:	6a 00                	push   $0x0
ffff80000010a779:	68 f3 00 00 00       	push   $0xf3
ffff80000010a77e:	e9 03 ed ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a783 <vector244>:
ffff80000010a783:	6a 00                	push   $0x0
ffff80000010a785:	68 f4 00 00 00       	push   $0xf4
ffff80000010a78a:	e9 f7 ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a78f <vector245>:
ffff80000010a78f:	6a 00                	push   $0x0
ffff80000010a791:	68 f5 00 00 00       	push   $0xf5
ffff80000010a796:	e9 eb ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a79b <vector246>:
ffff80000010a79b:	6a 00                	push   $0x0
ffff80000010a79d:	68 f6 00 00 00       	push   $0xf6
ffff80000010a7a2:	e9 df ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7a7 <vector247>:
ffff80000010a7a7:	6a 00                	push   $0x0
ffff80000010a7a9:	68 f7 00 00 00       	push   $0xf7
ffff80000010a7ae:	e9 d3 ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7b3 <vector248>:
ffff80000010a7b3:	6a 00                	push   $0x0
ffff80000010a7b5:	68 f8 00 00 00       	push   $0xf8
ffff80000010a7ba:	e9 c7 ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7bf <vector249>:
ffff80000010a7bf:	6a 00                	push   $0x0
ffff80000010a7c1:	68 f9 00 00 00       	push   $0xf9
ffff80000010a7c6:	e9 bb ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7cb <vector250>:
ffff80000010a7cb:	6a 00                	push   $0x0
ffff80000010a7cd:	68 fa 00 00 00       	push   $0xfa
ffff80000010a7d2:	e9 af ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7d7 <vector251>:
ffff80000010a7d7:	6a 00                	push   $0x0
ffff80000010a7d9:	68 fb 00 00 00       	push   $0xfb
ffff80000010a7de:	e9 a3 ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7e3 <vector252>:
ffff80000010a7e3:	6a 00                	push   $0x0
ffff80000010a7e5:	68 fc 00 00 00       	push   $0xfc
ffff80000010a7ea:	e9 97 ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7ef <vector253>:
ffff80000010a7ef:	6a 00                	push   $0x0
ffff80000010a7f1:	68 fd 00 00 00       	push   $0xfd
ffff80000010a7f6:	e9 8b ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a7fb <vector254>:
ffff80000010a7fb:	6a 00                	push   $0x0
ffff80000010a7fd:	68 fe 00 00 00       	push   $0xfe
ffff80000010a802:	e9 7f ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a807 <vector255>:
ffff80000010a807:	6a 00                	push   $0x0
ffff80000010a809:	68 ff 00 00 00       	push   $0xff
ffff80000010a80e:	e9 73 ec ff ff       	jmp    ffff800000109486 <alltraps>

ffff80000010a813 <lgdt>:
{
ffff80000010a813:	55                   	push   %rbp
ffff80000010a814:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a817:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010a81b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010a81f:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff80000010a822:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010a826:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff80000010a82a:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010a82d:	83 e8 01             	sub    $0x1,%eax
ffff80000010a830:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff80000010a834:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a838:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff80000010a83c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a840:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010a844:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff80000010a848:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a84c:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010a850:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff80000010a854:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a858:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010a85c:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lgdt (%0)" : : "r" (pd));
ffff80000010a860:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010a864:	0f 01 10             	lgdt   (%rax)
}
ffff80000010a867:	90                   	nop
ffff80000010a868:	c9                   	leave
ffff80000010a869:	c3                   	ret

ffff80000010a86a <ltr>:
{
ffff80000010a86a:	55                   	push   %rbp
ffff80000010a86b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a86e:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010a872:	89 f8                	mov    %edi,%eax
ffff80000010a874:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
  asm volatile("ltr %0" : : "r" (sel));
ffff80000010a878:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010a87c:	0f 00 d8             	ltr    %eax
}
ffff80000010a87f:	90                   	nop
ffff80000010a880:	c9                   	leave
ffff80000010a881:	c3                   	ret

ffff80000010a882 <lcr3>:

static inline void
lcr3(addr_t val)
{
ffff80000010a882:	55                   	push   %rbp
ffff80000010a883:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a886:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010a88a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  asm volatile("mov %0,%%cr3" : : "r" (val));
ffff80000010a88e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a892:	0f 22 d8             	mov    %rax,%cr3
}
ffff80000010a895:	90                   	nop
ffff80000010a896:	c9                   	leave
ffff80000010a897:	c3                   	ret

ffff80000010a898 <v2p>:
static inline addr_t v2p(void *a) {
ffff80000010a898:	55                   	push   %rbp
ffff80000010a899:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a89c:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010a8a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  return ((addr_t) (a)) - ((addr_t)KERNBASE);
ffff80000010a8a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a8a8:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010a8af:	80 00 00 
ffff80000010a8b2:	48 01 d0             	add    %rdx,%rax
}
ffff80000010a8b5:	c9                   	leave
ffff80000010a8b6:	c3                   	ret

ffff80000010a8b7 <syscallinit>:
static pml4e_t *kpml4;
static pdpe_t *kpdpt;

void
syscallinit(void)
{
ffff80000010a8b7:	55                   	push   %rbp
ffff80000010a8b8:	48 89 e5             	mov    %rsp,%rbp
  // the MSR/SYSRET wants the segment for 32-bit user data
  // next up is 64-bit user data, then code
  // This is simply the way the sysret instruction
  // is designed to work (it assumes they follow).
  wrmsr(MSR_STAR,
ffff80000010a8bb:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010a8c2:	00 1b 00 
ffff80000010a8c5:	48 89 c6             	mov    %rax,%rsi
ffff80000010a8c8:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010a8cd:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010a8d4:	80 ff ff 
ffff80000010a8d7:	ff d0                	call   *%rax
    ((((uint64)USER32_CS) << 48) | ((uint64)KERNEL_CS << 32)));
  wrmsr(MSR_LSTAR, (addr_t)syscall_entry);
ffff80000010a8d9:	48 b8 c2 94 10 00 00 	movabs $0xffff8000001094c2,%rax
ffff80000010a8e0:	80 ff ff 
ffff80000010a8e3:	48 89 c6             	mov    %rax,%rsi
ffff80000010a8e6:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010a8eb:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010a8f2:	80 ff ff 
ffff80000010a8f5:	ff d0                	call   *%rax
  wrmsr(MSR_CSTAR, (addr_t)ignore_sysret);
ffff80000010a8f7:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010a8fe:	80 ff ff 
ffff80000010a901:	48 89 c6             	mov    %rax,%rsi
ffff80000010a904:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010a909:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010a910:	80 ff ff 
ffff80000010a913:	ff d0                	call   *%rax

  wrmsr(MSR_SFMASK, FL_TF|FL_DF|FL_IF|FL_IOPL_3|FL_AC|FL_NT);
ffff80000010a915:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010a91a:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010a91f:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010a926:	80 ff ff 
ffff80000010a929:	ff d0                	call   *%rax
}
ffff80000010a92b:	90                   	nop
ffff80000010a92c:	5d                   	pop    %rbp
ffff80000010a92d:	c3                   	ret

ffff80000010a92e <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
ffff80000010a92e:	55                   	push   %rbp
ffff80000010a92f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a932:	48 83 ec 30          	sub    $0x30,%rsp
  uint64 addr;
  void *local;
  struct cpu *c;

  // create a page for cpu local storage
  local = kalloc();
ffff80000010a936:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010a93d:	80 ff ff 
ffff80000010a940:	ff d0                	call   *%rax
ffff80000010a942:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(local, 0, PGSIZE);
ffff80000010a946:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a94a:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010a94f:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a954:	48 89 c7             	mov    %rax,%rdi
ffff80000010a957:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010a95e:	80 ff ff 
ffff80000010a961:	ff d0                	call   *%rax

  gdt = (struct segdesc*) local;
ffff80000010a963:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a967:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss = (uint*) (((char*) local) + 1024);
ffff80000010a96b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a96f:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010a975:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
  tss[16] = 0x00680000; // IO Map Base = End of TSS
ffff80000010a979:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a97d:	48 83 c0 40          	add    $0x40,%rax
ffff80000010a981:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)

  // point FS smack in the middle of our local storage page
  wrmsr(0xC0000100, ((uint64) local) + 2048);
ffff80000010a987:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a98b:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010a991:	48 89 c6             	mov    %rax,%rsi
ffff80000010a994:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010a999:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010a9a0:	80 ff ff 
ffff80000010a9a3:	ff d0                	call   *%rax

  c = &cpus[cpunum()];
ffff80000010a9a5:	48 b8 88 46 10 00 00 	movabs $0xffff800000104688,%rax
ffff80000010a9ac:	80 ff ff 
ffff80000010a9af:	ff d0                	call   *%rax
ffff80000010a9b1:	48 63 d0             	movslq %eax,%rdx
ffff80000010a9b4:	48 89 d0             	mov    %rdx,%rax
ffff80000010a9b7:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010a9bb:	48 01 d0             	add    %rdx,%rax
ffff80000010a9be:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010a9c2:	48 ba e0 72 11 00 00 	movabs $0xffff8000001172e0,%rdx
ffff80000010a9c9:	80 ff ff 
ffff80000010a9cc:	48 01 d0             	add    %rdx,%rax
ffff80000010a9cf:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  c->local = local;
ffff80000010a9d3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a9d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010a9db:	48 89 50 20          	mov    %rdx,0x20(%rax)

  cpu = c;
ffff80000010a9df:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010a9e3:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010a9ea:	ff ff 
  proc = 0;
ffff80000010a9ec:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010a9f3:	ff ff 00 00 00 00 

  addr = (uint64) tss;
ffff80000010a9f9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010a9fd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  gdt[0] =  (struct segdesc) {};
ffff80000010aa01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aa05:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  gdt[SEG_KCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, !DPL_USER, 1);
ffff80000010aa0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aa10:	48 83 c0 08          	add    $0x8,%rax
ffff80000010aa14:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010aa19:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010aa1f:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010aa23:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aa27:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aa2a:	83 ca 0a             	or     $0xa,%edx
ffff80000010aa2d:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aa30:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aa34:	83 ca 10             	or     $0x10,%edx
ffff80000010aa37:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aa3a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aa3e:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010aa41:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aa44:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aa48:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aa4b:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aa4e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aa52:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aa55:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aa58:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aa5c:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010aa5f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aa62:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aa66:	83 ca 20             	or     $0x20,%edx
ffff80000010aa69:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aa6c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aa70:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010aa73:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aa76:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aa7a:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aa7d:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aa80:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KDATA] = SEG(STA_W, 0, 0, APP_SEG, !DPL_USER, 0);
ffff80000010aa84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aa88:	48 83 c0 10          	add    $0x10,%rax
ffff80000010aa8c:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010aa91:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010aa97:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010aa9b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aa9f:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aaa2:	83 ca 02             	or     $0x2,%edx
ffff80000010aaa5:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aaa8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aaac:	83 ca 10             	or     $0x10,%edx
ffff80000010aaaf:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aab2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aab6:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010aab9:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aabc:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aac0:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aac3:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aac6:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aaca:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aacd:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aad0:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aad4:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010aad7:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aada:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aade:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010aae1:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aae4:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aae8:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010aaeb:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aaee:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010aaf2:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aaf5:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010aaf8:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE32] = (struct segdesc) {}; // required by syscall/sysret
ffff80000010aafc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ab00:	48 83 c0 18          	add    $0x18,%rax
ffff80000010ab04:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  gdt[SEG_UDATA] = SEG(STA_W, 0, 0, APP_SEG, DPL_USER, 0);
ffff80000010ab0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ab0f:	48 83 c0 20          	add    $0x20,%rax
ffff80000010ab13:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010ab18:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ab1e:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ab22:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ab26:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ab29:	83 ca 02             	or     $0x2,%edx
ffff80000010ab2c:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ab2f:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ab33:	83 ca 10             	or     $0x10,%edx
ffff80000010ab36:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ab39:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ab3d:	83 ca 60             	or     $0x60,%edx
ffff80000010ab40:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ab43:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ab47:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ab4a:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ab4d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ab51:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ab54:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ab57:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ab5b:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010ab5e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ab61:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ab65:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010ab68:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ab6b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ab6f:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010ab72:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ab75:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ab79:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ab7c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ab7f:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_UCODE] = SEG((STA_X|STA_R), 0, 0, APP_SEG, DPL_USER, 1);
ffff80000010ab83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ab87:	48 83 c0 28          	add    $0x28,%rax
ffff80000010ab8b:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010ab90:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010ab96:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010ab9a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ab9e:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aba1:	83 ca 0a             	or     $0xa,%edx
ffff80000010aba4:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aba7:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010abab:	83 ca 10             	or     $0x10,%edx
ffff80000010abae:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010abb1:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010abb5:	83 ca 60             	or     $0x60,%edx
ffff80000010abb8:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010abbb:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010abbf:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010abc2:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010abc5:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010abc9:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010abcc:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010abcf:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010abd3:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010abd6:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010abd9:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010abdd:	83 ca 20             	or     $0x20,%edx
ffff80000010abe0:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010abe3:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010abe7:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010abea:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010abed:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010abf1:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010abf4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010abf7:	c6 40 07 00          	movb   $0x0,0x7(%rax)
  gdt[SEG_KCPU]  = (struct segdesc) {};
ffff80000010abfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010abff:	48 83 c0 30          	add    $0x30,%rax
ffff80000010ac03:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  // TSS: See IA32 SDM Figure 7-4
  gdt[SEG_TSS]   = SEG(STS_T64A, 0xb, addr, !APP_SEG, DPL_USER, 0);
ffff80000010ac0a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ac0e:	48 83 c0 38          	add    $0x38,%rax
ffff80000010ac12:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010ac16:	89 d7                	mov    %edx,%edi
ffff80000010ac18:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010ac1c:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010ac20:	89 d6                	mov    %edx,%esi
ffff80000010ac22:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010ac26:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010ac2a:	89 d1                	mov    %edx,%ecx
ffff80000010ac2c:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010ac31:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010ac35:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010ac39:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ac3d:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ac40:	83 ca 09             	or     $0x9,%edx
ffff80000010ac43:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ac46:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ac4a:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010ac4d:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ac50:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ac54:	83 ca 60             	or     $0x60,%edx
ffff80000010ac57:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ac5a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010ac5e:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ac61:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010ac64:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ac68:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ac6b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ac6e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ac72:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010ac75:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ac78:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ac7c:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010ac7f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ac82:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ac86:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010ac89:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ac8c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ac90:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ac93:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ac96:	88 48 07             	mov    %cl,0x7(%rax)
  gdt[SEG_TSS+1] = SEG(0, addr >> 32, addr >> 48, 0, 0, 0);
ffff80000010ac99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ac9d:	48 83 c0 40          	add    $0x40,%rax
ffff80000010aca1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010aca5:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010aca9:	41 89 d1             	mov    %edx,%r9d
ffff80000010acac:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010acb0:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010acb4:	41 89 d0             	mov    %edx,%r8d
ffff80000010acb7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010acbb:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010acbf:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010acc3:	89 d7                	mov    %edx,%edi
ffff80000010acc5:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010acc9:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010accd:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010acd1:	83 e2 0f             	and    $0xf,%edx
ffff80000010acd4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010acd8:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010acdc:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010ace0:	89 ce                	mov    %ecx,%esi
ffff80000010ace2:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010ace6:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010aceb:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010acef:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010acf3:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010acf6:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010acf9:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010acfd:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010ad00:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010ad03:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010ad07:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010ad0a:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010ad0d:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010ad11:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010ad14:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010ad17:	89 d1                	mov    %edx,%ecx
ffff80000010ad19:	83 e1 0f             	and    $0xf,%ecx
ffff80000010ad1c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad20:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010ad23:	09 ca                	or     %ecx,%edx
ffff80000010ad25:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad28:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad2c:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010ad2f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad32:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad36:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010ad39:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad3c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad40:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010ad43:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad46:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010ad4a:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010ad4d:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010ad50:	40 88 70 07          	mov    %sil,0x7(%rax)

  lgdt((void*) gdt, (NSEGS+1) * sizeof(struct segdesc));
ffff80000010ad54:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ad58:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010ad5d:	48 89 c7             	mov    %rax,%rdi
ffff80000010ad60:	48 b8 13 a8 10 00 00 	movabs $0xffff80000010a813,%rax
ffff80000010ad67:	80 ff ff 
ffff80000010ad6a:	ff d0                	call   *%rax

  ltr(SEG_TSS << 3);
ffff80000010ad6c:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010ad71:	48 b8 6a a8 10 00 00 	movabs $0xffff80000010a86a,%rax
ffff80000010ad78:	80 ff ff 
ffff80000010ad7b:	ff d0                	call   *%rax
};
ffff80000010ad7d:	90                   	nop
ffff80000010ad7e:	c9                   	leave
ffff80000010ad7f:	c3                   	ret

ffff80000010ad80 <setupkvm>:
// (directly addressable from end..P2V(PHYSTOP)).


pml4e_t*
setupkvm(void)
{
ffff80000010ad80:	55                   	push   %rbp
ffff80000010ad81:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ad84:	48 83 ec 10          	sub    $0x10,%rsp
  pml4e_t *pml4 = (pml4e_t*) kalloc();
ffff80000010ad88:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010ad8f:	80 ff ff 
ffff80000010ad92:	ff d0                	call   *%rax
ffff80000010ad94:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(pml4, 0, PGSIZE);
ffff80000010ad98:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ad9c:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ada1:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ada6:	48 89 c7             	mov    %rax,%rdi
ffff80000010ada9:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010adb0:	80 ff ff 
ffff80000010adb3:	ff d0                	call   *%rax
  pml4[256] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010adb5:	48 b8 60 ad 11 00 00 	movabs $0xffff80000011ad60,%rax
ffff80000010adbc:	80 ff ff 
ffff80000010adbf:	48 8b 00             	mov    (%rax),%rax
ffff80000010adc2:	48 89 c7             	mov    %rax,%rdi
ffff80000010adc5:	48 b8 98 a8 10 00 00 	movabs $0xffff80000010a898,%rax
ffff80000010adcc:	80 ff ff 
ffff80000010adcf:	ff d0                	call   *%rax
ffff80000010add1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010add5:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010addc:	48 83 c8 03          	or     $0x3,%rax
ffff80000010ade0:	48 89 02             	mov    %rax,(%rdx)
  return pml4;
ffff80000010ade3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
};
ffff80000010ade7:	c9                   	leave
ffff80000010ade8:	c3                   	ret

ffff80000010ade9 <kvmalloc>:
//
// linear map the first 4GB of physical memory starting
// at 0xFFFF800000000000
void
kvmalloc(void)
{
ffff80000010ade9:	55                   	push   %rbp
ffff80000010adea:	48 89 e5             	mov    %rsp,%rbp
  kpml4 = (pml4e_t*) kalloc();
ffff80000010aded:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010adf4:	80 ff ff 
ffff80000010adf7:	ff d0                	call   *%rax
ffff80000010adf9:	48 ba 58 ad 11 00 00 	movabs $0xffff80000011ad58,%rdx
ffff80000010ae00:	80 ff ff 
ffff80000010ae03:	48 89 02             	mov    %rax,(%rdx)
  memset(kpml4, 0, PGSIZE);
ffff80000010ae06:	48 b8 58 ad 11 00 00 	movabs $0xffff80000011ad58,%rax
ffff80000010ae0d:	80 ff ff 
ffff80000010ae10:	48 8b 00             	mov    (%rax),%rax
ffff80000010ae13:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ae18:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ae1d:	48 89 c7             	mov    %rax,%rdi
ffff80000010ae20:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010ae27:	80 ff ff 
ffff80000010ae2a:	ff d0                	call   *%rax

  // the kernel memory region starts at KERNBASE and up
  // allocate one PDPT at the bottom of that range.
  kpdpt = (pde_t*) kalloc();
ffff80000010ae2c:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010ae33:	80 ff ff 
ffff80000010ae36:	ff d0                	call   *%rax
ffff80000010ae38:	48 ba 60 ad 11 00 00 	movabs $0xffff80000011ad60,%rdx
ffff80000010ae3f:	80 ff ff 
ffff80000010ae42:	48 89 02             	mov    %rax,(%rdx)
  memset(kpdpt, 0, PGSIZE);
ffff80000010ae45:	48 b8 60 ad 11 00 00 	movabs $0xffff80000011ad60,%rax
ffff80000010ae4c:	80 ff ff 
ffff80000010ae4f:	48 8b 00             	mov    (%rax),%rax
ffff80000010ae52:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ae57:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ae5c:	48 89 c7             	mov    %rax,%rdi
ffff80000010ae5f:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010ae66:	80 ff ff 
ffff80000010ae69:	ff d0                	call   *%rax
  kpml4[PMX(KERNBASE)] = v2p(kpdpt) | PTE_P | PTE_W;
ffff80000010ae6b:	48 b8 60 ad 11 00 00 	movabs $0xffff80000011ad60,%rax
ffff80000010ae72:	80 ff ff 
ffff80000010ae75:	48 8b 00             	mov    (%rax),%rax
ffff80000010ae78:	48 89 c7             	mov    %rax,%rdi
ffff80000010ae7b:	48 b8 98 a8 10 00 00 	movabs $0xffff80000010a898,%rax
ffff80000010ae82:	80 ff ff 
ffff80000010ae85:	ff d0                	call   *%rax
ffff80000010ae87:	48 ba 58 ad 11 00 00 	movabs $0xffff80000011ad58,%rdx
ffff80000010ae8e:	80 ff ff 
ffff80000010ae91:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010ae94:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010ae9b:	48 83 c8 03          	or     $0x3,%rax
ffff80000010ae9f:	48 89 02             	mov    %rax,(%rdx)

  // direct map first GB of physical addresses to KERNBASE
  kpdpt[0] = 0 | PTE_PS | PTE_P | PTE_W;
ffff80000010aea2:	48 b8 60 ad 11 00 00 	movabs $0xffff80000011ad60,%rax
ffff80000010aea9:	80 ff ff 
ffff80000010aeac:	48 8b 00             	mov    (%rax),%rax
ffff80000010aeaf:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)

  // direct map 4th GB of physical addresses to KERNBASE+3GB
  // this is a very lazy way to map IO memory (for lapic and ioapic)
  // PTE_PWT and PTE_PCD for memory mapped I/O correctness.
  kpdpt[3] = 0xC0000000 | PTE_PS | PTE_P | PTE_W | PTE_PWT | PTE_PCD;
ffff80000010aeb6:	48 b8 60 ad 11 00 00 	movabs $0xffff80000011ad60,%rax
ffff80000010aebd:	80 ff ff 
ffff80000010aec0:	48 8b 00             	mov    (%rax),%rax
ffff80000010aec3:	48 83 c0 18          	add    $0x18,%rax
ffff80000010aec7:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010aecc:	48 89 08             	mov    %rcx,(%rax)

  switchkvm();
ffff80000010aecf:	48 b8 ea b1 10 00 00 	movabs $0xffff80000010b1ea,%rax
ffff80000010aed6:	80 ff ff 
ffff80000010aed9:	ff d0                	call   *%rax
}
ffff80000010aedb:	90                   	nop
ffff80000010aedc:	5d                   	pop    %rbp
ffff80000010aedd:	c3                   	ret

ffff80000010aede <switchuvm>:

void
switchuvm(struct proc *p)
{
ffff80000010aede:	55                   	push   %rbp
ffff80000010aedf:	48 89 e5             	mov    %rsp,%rbp
ffff80000010aee2:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010aee6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  pushcli();
ffff80000010aeea:	48 b8 7f 76 10 00 00 	movabs $0xffff80000010767f,%rax
ffff80000010aef1:	80 ff ff 
ffff80000010aef4:	ff d0                	call   *%rax
  if(p->pgdir == 0)
ffff80000010aef6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010aefa:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010aefe:	48 85 c0             	test   %rax,%rax
ffff80000010af01:	75 19                	jne    ffff80000010af1c <switchuvm+0x3e>
    panic("switchuvm: no pgdir");
ffff80000010af03:	48 b8 b0 c5 10 00 00 	movabs $0xffff80000010c5b0,%rax
ffff80000010af0a:	80 ff ff 
ffff80000010af0d:	48 89 c7             	mov    %rax,%rdi
ffff80000010af10:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010af17:	80 ff ff 
ffff80000010af1a:	ff d0                	call   *%rax
  uint *tss = (uint*) (((char*) cpu->local) + 1024);
ffff80000010af1c:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010af23:	ff ff 
ffff80000010af25:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010af29:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010af2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  const addr_t stktop = (addr_t)p->kstack + KSTACKSIZE;
ffff80000010af33:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010af37:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010af3b:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010af41:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  tss[1] = (uint)stktop; // https://wiki.osdev.org/Task_State_Segment
ffff80000010af45:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010af49:	48 83 c0 04          	add    $0x4,%rax
ffff80000010af4d:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010af51:	89 10                	mov    %edx,(%rax)
  tss[2] = (uint)(stktop >> 32);
ffff80000010af53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010af57:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010af5b:	48 89 c2             	mov    %rax,%rdx
ffff80000010af5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010af62:	48 83 c0 08          	add    $0x8,%rax
ffff80000010af66:	89 10                	mov    %edx,(%rax)
  lcr3(v2p(p->pgdir));
ffff80000010af68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010af6c:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010af70:	48 89 c7             	mov    %rax,%rdi
ffff80000010af73:	48 b8 98 a8 10 00 00 	movabs $0xffff80000010a898,%rax
ffff80000010af7a:	80 ff ff 
ffff80000010af7d:	ff d0                	call   *%rax
ffff80000010af7f:	48 89 c7             	mov    %rax,%rdi
ffff80000010af82:	48 b8 82 a8 10 00 00 	movabs $0xffff80000010a882,%rax
ffff80000010af89:	80 ff ff 
ffff80000010af8c:	ff d0                	call   *%rax
  popcli();
ffff80000010af8e:	48 b8 ed 76 10 00 00 	movabs $0xffff8000001076ed,%rax
ffff80000010af95:	80 ff ff 
ffff80000010af98:	ff d0                	call   *%rax
}
ffff80000010af9a:	90                   	nop
ffff80000010af9b:	c9                   	leave
ffff80000010af9c:	c3                   	ret

ffff80000010af9d <walkpgdir>:
// In 64-bit mode, the page table has four levels: PML4, PDPT, PD and PT
// For each level, we dereference the correct entry, or allocate and
// initialize entry if the PTE_P bit is not set
static pte_t *
walkpgdir(pde_t *pml4, const void *va, int alloc)
{
ffff80000010af9d:	55                   	push   %rbp
ffff80000010af9e:	48 89 e5             	mov    %rsp,%rbp
ffff80000010afa1:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010afa5:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010afa9:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010afad:	89 55 bc             	mov    %edx,-0x44(%rbp)
  pml4e_t *pml4e;
  pdpe_t *pdp, *pdpe;
  pde_t *pde, *pd, *pgtab;

  // from the PML4, find or allocate the appropriate PDP table
  pml4e = &pml4[PMX(va)];
ffff80000010afb0:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010afb4:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010afb8:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010afbd:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010afc4:	00 
ffff80000010afc5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010afc9:	48 01 d0             	add    %rdx,%rax
ffff80000010afcc:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
  if(*pml4e & PTE_P)
ffff80000010afd0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010afd4:	48 8b 00             	mov    (%rax),%rax
ffff80000010afd7:	83 e0 01             	and    $0x1,%eax
ffff80000010afda:	48 85 c0             	test   %rax,%rax
ffff80000010afdd:	74 23                	je     ffff80000010b002 <walkpgdir+0x65>
    pdp = (pdpe_t*)P2V(PTE_ADDR(*pml4e));
ffff80000010afdf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010afe3:	48 8b 00             	mov    (%rax),%rax
ffff80000010afe6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010afec:	48 89 c2             	mov    %rax,%rdx
ffff80000010afef:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010aff6:	80 ff ff 
ffff80000010aff9:	48 01 d0             	add    %rdx,%rax
ffff80000010affc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b000:	eb 63                	jmp    ffff80000010b065 <walkpgdir+0xc8>
  else {
    if(!alloc || (pdp = (pdpe_t*)kalloc()) == 0)
ffff80000010b002:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b006:	74 17                	je     ffff80000010b01f <walkpgdir+0x82>
ffff80000010b008:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b00f:	80 ff ff 
ffff80000010b012:	ff d0                	call   *%rax
ffff80000010b014:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b018:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010b01d:	75 0a                	jne    ffff80000010b029 <walkpgdir+0x8c>
      return 0;
ffff80000010b01f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b024:	e9 bf 01 00 00       	jmp    ffff80000010b1e8 <walkpgdir+0x24b>
    memset(pdp, 0, PGSIZE);
ffff80000010b029:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b02d:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b032:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b037:	48 89 c7             	mov    %rax,%rdi
ffff80000010b03a:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010b041:	80 ff ff 
ffff80000010b044:	ff d0                	call   *%rax
    *pml4e = V2P(pdp) | PTE_P | PTE_W | PTE_U;
ffff80000010b046:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b04a:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b051:	80 00 00 
ffff80000010b054:	48 01 d0             	add    %rdx,%rax
ffff80000010b057:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b05b:	48 89 c2             	mov    %rax,%rdx
ffff80000010b05e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b062:	48 89 10             	mov    %rdx,(%rax)
  }

  //from the PDP, find or allocate the appropriate PD (page directory)
  pdpe = &pdp[PDPX(va)];
ffff80000010b065:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b069:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010b06d:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b072:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b079:	00 
ffff80000010b07a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b07e:	48 01 d0             	add    %rdx,%rax
ffff80000010b081:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(*pdpe & PTE_P)
ffff80000010b085:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b089:	48 8b 00             	mov    (%rax),%rax
ffff80000010b08c:	83 e0 01             	and    $0x1,%eax
ffff80000010b08f:	48 85 c0             	test   %rax,%rax
ffff80000010b092:	74 23                	je     ffff80000010b0b7 <walkpgdir+0x11a>
    pd = (pde_t*)P2V(PTE_ADDR(*pdpe));
ffff80000010b094:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b098:	48 8b 00             	mov    (%rax),%rax
ffff80000010b09b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b0a1:	48 89 c2             	mov    %rax,%rdx
ffff80000010b0a4:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b0ab:	80 ff ff 
ffff80000010b0ae:	48 01 d0             	add    %rdx,%rax
ffff80000010b0b1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b0b5:	eb 63                	jmp    ffff80000010b11a <walkpgdir+0x17d>
  else {
    if(!alloc || (pd = (pde_t*)kalloc()) == 0)//allocate page table
ffff80000010b0b7:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b0bb:	74 17                	je     ffff80000010b0d4 <walkpgdir+0x137>
ffff80000010b0bd:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b0c4:	80 ff ff 
ffff80000010b0c7:	ff d0                	call   *%rax
ffff80000010b0c9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b0cd:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b0d2:	75 0a                	jne    ffff80000010b0de <walkpgdir+0x141>
      return 0;
ffff80000010b0d4:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b0d9:	e9 0a 01 00 00       	jmp    ffff80000010b1e8 <walkpgdir+0x24b>
    memset(pd, 0, PGSIZE);
ffff80000010b0de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0e2:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b0e7:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b0ec:	48 89 c7             	mov    %rax,%rdi
ffff80000010b0ef:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010b0f6:	80 ff ff 
ffff80000010b0f9:	ff d0                	call   *%rax
    *pdpe = V2P(pd) | PTE_P | PTE_W | PTE_U;
ffff80000010b0fb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0ff:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b106:	80 00 00 
ffff80000010b109:	48 01 d0             	add    %rdx,%rax
ffff80000010b10c:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b110:	48 89 c2             	mov    %rax,%rdx
ffff80000010b113:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b117:	48 89 10             	mov    %rdx,(%rax)
  }

  // from the PD, find or allocate the appropriate page table
  pde = &pd[PDX(va)];
ffff80000010b11a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b11e:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010b122:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b127:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b12e:	00 
ffff80000010b12f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b133:	48 01 d0             	add    %rdx,%rax
ffff80000010b136:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  if(*pde & PTE_P)
ffff80000010b13a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b13e:	48 8b 00             	mov    (%rax),%rax
ffff80000010b141:	83 e0 01             	and    $0x1,%eax
ffff80000010b144:	48 85 c0             	test   %rax,%rax
ffff80000010b147:	74 23                	je     ffff80000010b16c <walkpgdir+0x1cf>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
ffff80000010b149:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b14d:	48 8b 00             	mov    (%rax),%rax
ffff80000010b150:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b156:	48 89 c2             	mov    %rax,%rdx
ffff80000010b159:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b160:	80 ff ff 
ffff80000010b163:	48 01 d0             	add    %rdx,%rax
ffff80000010b166:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b16a:	eb 60                	jmp    ffff80000010b1cc <walkpgdir+0x22f>
  else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)//allocate page table
ffff80000010b16c:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b170:	74 17                	je     ffff80000010b189 <walkpgdir+0x1ec>
ffff80000010b172:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b179:	80 ff ff 
ffff80000010b17c:	ff d0                	call   *%rax
ffff80000010b17e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b182:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b187:	75 07                	jne    ffff80000010b190 <walkpgdir+0x1f3>
      return 0;
ffff80000010b189:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b18e:	eb 58                	jmp    ffff80000010b1e8 <walkpgdir+0x24b>
    memset(pgtab, 0, PGSIZE);
ffff80000010b190:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b194:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b199:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b19e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b1a1:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010b1a8:	80 ff ff 
ffff80000010b1ab:	ff d0                	call   *%rax
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
ffff80000010b1ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b1b1:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b1b8:	80 00 00 
ffff80000010b1bb:	48 01 d0             	add    %rdx,%rax
ffff80000010b1be:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b1c2:	48 89 c2             	mov    %rax,%rdx
ffff80000010b1c5:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b1c9:	48 89 10             	mov    %rdx,(%rax)
  }

  return &pgtab[PTX(va)];
ffff80000010b1cc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b1d0:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010b1d4:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b1d9:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b1e0:	00 
ffff80000010b1e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b1e5:	48 01 d0             	add    %rdx,%rax
}
ffff80000010b1e8:	c9                   	leave
ffff80000010b1e9:	c3                   	ret

ffff80000010b1ea <switchkvm>:

void
switchkvm(void)
{
ffff80000010b1ea:	55                   	push   %rbp
ffff80000010b1eb:	48 89 e5             	mov    %rsp,%rbp
  lcr3(v2p(kpml4));
ffff80000010b1ee:	48 b8 58 ad 11 00 00 	movabs $0xffff80000011ad58,%rax
ffff80000010b1f5:	80 ff ff 
ffff80000010b1f8:	48 8b 00             	mov    (%rax),%rax
ffff80000010b1fb:	48 89 c7             	mov    %rax,%rdi
ffff80000010b1fe:	48 b8 98 a8 10 00 00 	movabs $0xffff80000010a898,%rax
ffff80000010b205:	80 ff ff 
ffff80000010b208:	ff d0                	call   *%rax
ffff80000010b20a:	48 89 c7             	mov    %rax,%rdi
ffff80000010b20d:	48 b8 82 a8 10 00 00 	movabs $0xffff80000010a882,%rax
ffff80000010b214:	80 ff ff 
ffff80000010b217:	ff d0                	call   *%rax
}
ffff80000010b219:	90                   	nop
ffff80000010b21a:	5d                   	pop    %rbp
ffff80000010b21b:	c3                   	ret

ffff80000010b21c <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
int
mappages(pde_t *pgdir, void *va, addr_t size, addr_t pa, int perm)
{
ffff80000010b21c:	55                   	push   %rbp
ffff80000010b21d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b220:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b224:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b228:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b22c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b230:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010b234:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((addr_t)va);
ffff80000010b238:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b23c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b242:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  last = (char*)PGROUNDDOWN(((addr_t)va) + size - 1);
ffff80000010b246:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010b24a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b24e:	48 01 d0             	add    %rdx,%rax
ffff80000010b251:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010b255:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b25b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b25f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b263:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b267:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010b26c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b26f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b272:	48 b8 9d af 10 00 00 	movabs $0xffff80000010af9d,%rax
ffff80000010b279:	80 ff ff 
ffff80000010b27c:	ff d0                	call   *%rax
ffff80000010b27e:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b282:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b287:	75 07                	jne    ffff80000010b290 <mappages+0x74>
      return -1;
ffff80000010b289:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b28e:	eb 64                	jmp    ffff80000010b2f4 <mappages+0xd8>
    if(*pte & PTE_P)
ffff80000010b290:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b294:	48 8b 00             	mov    (%rax),%rax
ffff80000010b297:	83 e0 01             	and    $0x1,%eax
ffff80000010b29a:	48 85 c0             	test   %rax,%rax
ffff80000010b29d:	74 19                	je     ffff80000010b2b8 <mappages+0x9c>
      panic("remap");
ffff80000010b29f:	48 b8 c4 c5 10 00 00 	movabs $0xffff80000010c5c4,%rax
ffff80000010b2a6:	80 ff ff 
ffff80000010b2a9:	48 89 c7             	mov    %rax,%rdi
ffff80000010b2ac:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b2b3:	80 ff ff 
ffff80000010b2b6:	ff d0                	call   *%rax
    *pte = pa | perm | PTE_P;
ffff80000010b2b8:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010b2bb:	48 98                	cltq
ffff80000010b2bd:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010b2c1:	48 83 c8 01          	or     $0x1,%rax
ffff80000010b2c5:	48 89 c2             	mov    %rax,%rdx
ffff80000010b2c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b2cc:	48 89 10             	mov    %rdx,(%rax)
    if(a == last)
ffff80000010b2cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b2d3:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010b2d7:	74 15                	je     ffff80000010b2ee <mappages+0xd2>
      break;
    a += PGSIZE;
ffff80000010b2d9:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b2e0:	00 
    pa += PGSIZE;
ffff80000010b2e1:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010b2e8:	00 
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
ffff80000010b2e9:	e9 71 ff ff ff       	jmp    ffff80000010b25f <mappages+0x43>
      break;
ffff80000010b2ee:	90                   	nop
  }
  return 0;
ffff80000010b2ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b2f4:	c9                   	leave
ffff80000010b2f5:	c3                   	ret

ffff80000010b2f6 <inituvm>:

// Load the initcode into address 0x1000 (4KB) of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
ffff80000010b2f6:	55                   	push   %rbp
ffff80000010b2f7:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b2fa:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b2fe:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b302:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b306:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *mem;

  if(sz >= PGSIZE)
ffff80000010b309:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010b310:	76 19                	jbe    ffff80000010b32b <inituvm+0x35>
    panic("inituvm: more than a page");
ffff80000010b312:	48 b8 ca c5 10 00 00 	movabs $0xffff80000010c5ca,%rax
ffff80000010b319:	80 ff ff 
ffff80000010b31c:	48 89 c7             	mov    %rax,%rdi
ffff80000010b31f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b326:	80 ff ff 
ffff80000010b329:	ff d0                	call   *%rax

  mem = kalloc();
ffff80000010b32b:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b332:	80 ff ff 
ffff80000010b335:	ff d0                	call   *%rax
ffff80000010b337:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  memset(mem, 0, PGSIZE);
ffff80000010b33b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b33f:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b344:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b349:	48 89 c7             	mov    %rax,%rdi
ffff80000010b34c:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010b353:	80 ff ff 
ffff80000010b356:	ff d0                	call   *%rax
  mappages(pgdir, (void *)PGSIZE, PGSIZE, V2P(mem), PTE_W|PTE_U);
ffff80000010b358:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b35c:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b363:	80 00 00 
ffff80000010b366:	48 01 c2             	add    %rax,%rdx
ffff80000010b369:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b36d:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010b373:	48 89 d1             	mov    %rdx,%rcx
ffff80000010b376:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b37b:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010b380:	48 89 c7             	mov    %rax,%rdi
ffff80000010b383:	48 b8 1c b2 10 00 00 	movabs $0xffff80000010b21c,%rax
ffff80000010b38a:	80 ff ff 
ffff80000010b38d:	ff d0                	call   *%rax

  memmove(mem, init, sz);
ffff80000010b38f:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010b392:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010b396:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b39a:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b39d:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3a0:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff80000010b3a7:	80 ff ff 
ffff80000010b3aa:	ff d0                	call   *%rax
}
ffff80000010b3ac:	90                   	nop
ffff80000010b3ad:	c9                   	leave
ffff80000010b3ae:	c3                   	ret

ffff80000010b3af <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffff80000010b3af:	55                   	push   %rbp
ffff80000010b3b0:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b3b3:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b3b7:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b3bb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b3bf:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b3c3:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010b3c6:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
  uint i, n;
  addr_t pa;
  pte_t *pte;

  if((addr_t) addr % PGSIZE != 0)
ffff80000010b3ca:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b3ce:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010b3d3:	48 85 c0             	test   %rax,%rax
ffff80000010b3d6:	74 19                	je     ffff80000010b3f1 <loaduvm+0x42>
    panic("loaduvm: addr must be page aligned");
ffff80000010b3d8:	48 b8 e8 c5 10 00 00 	movabs $0xffff80000010c5e8,%rax
ffff80000010b3df:	80 ff ff 
ffff80000010b3e2:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3e5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b3ec:	80 ff ff 
ffff80000010b3ef:	ff d0                	call   *%rax
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010b3f1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010b3f8:	e9 c7 00 00 00       	jmp    ffff80000010b4c4 <loaduvm+0x115>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
ffff80000010b3fd:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010b400:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b404:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010b408:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b40c:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b411:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b414:	48 89 c7             	mov    %rax,%rdi
ffff80000010b417:	48 b8 9d af 10 00 00 	movabs $0xffff80000010af9d,%rax
ffff80000010b41e:	80 ff ff 
ffff80000010b421:	ff d0                	call   *%rax
ffff80000010b423:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b427:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b42c:	75 19                	jne    ffff80000010b447 <loaduvm+0x98>
      panic("loaduvm: address should exist");
ffff80000010b42e:	48 b8 0b c6 10 00 00 	movabs $0xffff80000010c60b,%rax
ffff80000010b435:	80 ff ff 
ffff80000010b438:	48 89 c7             	mov    %rax,%rdi
ffff80000010b43b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b442:	80 ff ff 
ffff80000010b445:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010b447:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b44b:	48 8b 00             	mov    (%rax),%rax
ffff80000010b44e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b454:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    if(sz - i < PGSIZE)
ffff80000010b458:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b45b:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b45e:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010b463:	77 0b                	ja     ffff80000010b470 <loaduvm+0xc1>
      n = sz - i;
ffff80000010b465:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b468:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b46b:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010b46e:	eb 07                	jmp    ffff80000010b477 <loaduvm+0xc8>
    else
      n = PGSIZE;
ffff80000010b470:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
ffff80000010b477:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010b47a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b47d:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010b480:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010b487:	80 ff ff 
ffff80000010b48a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b48e:	48 01 d0             	add    %rdx,%rax
ffff80000010b491:	48 89 c7             	mov    %rax,%rdi
ffff80000010b494:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010b497:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b49b:	89 d1                	mov    %edx,%ecx
ffff80000010b49d:	89 f2                	mov    %esi,%edx
ffff80000010b49f:	48 89 fe             	mov    %rdi,%rsi
ffff80000010b4a2:	48 89 c7             	mov    %rax,%rdi
ffff80000010b4a5:	48 b8 f5 2e 10 00 00 	movabs $0xffff800000102ef5,%rax
ffff80000010b4ac:	80 ff ff 
ffff80000010b4af:	ff d0                	call   *%rax
ffff80000010b4b1:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010b4b4:	74 07                	je     ffff80000010b4bd <loaduvm+0x10e>
      return -1;
ffff80000010b4b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b4bb:	eb 18                	jmp    ffff80000010b4d5 <loaduvm+0x126>
  for(i = 0; i < sz; i += PGSIZE){
ffff80000010b4bd:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010b4c4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b4c7:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010b4ca:	0f 82 2d ff ff ff    	jb     ffff80000010b3fd <loaduvm+0x4e>
  }
  return 0;
ffff80000010b4d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010b4d5:	c9                   	leave
ffff80000010b4d6:	c3                   	ret

ffff80000010b4d7 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
uint64
allocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010b4d7:	55                   	push   %rbp
ffff80000010b4d8:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b4db:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b4df:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b4e3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b4e7:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
  char *mem;
  addr_t a;

  if(newsz >= KERNBASE)
ffff80000010b4eb:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010b4f2:	7f ff ff 
ffff80000010b4f5:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010b4f9:	73 0a                	jae    ffff80000010b505 <allocuvm+0x2e>
    return 0;
ffff80000010b4fb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b500:	e9 14 01 00 00       	jmp    ffff80000010b619 <allocuvm+0x142>
  if(newsz < oldsz)
ffff80000010b505:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b509:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010b50d:	73 09                	jae    ffff80000010b518 <allocuvm+0x41>
    return oldsz;
ffff80000010b50f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b513:	e9 01 01 00 00       	jmp    ffff80000010b619 <allocuvm+0x142>

  a = PGROUNDUP(oldsz);
ffff80000010b518:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b51c:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010b522:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b528:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a < newsz; a += PGSIZE){
ffff80000010b52c:	e9 d6 00 00 00       	jmp    ffff80000010b607 <allocuvm+0x130>
    mem = kalloc();
ffff80000010b531:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010b538:	80 ff ff 
ffff80000010b53b:	ff d0                	call   *%rax
ffff80000010b53d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(mem == 0){
ffff80000010b541:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b546:	75 28                	jne    ffff80000010b570 <allocuvm+0x99>
      //cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010b548:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010b54c:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b550:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b554:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b557:	48 89 c7             	mov    %rax,%rdi
ffff80000010b55a:	48 b8 1b b6 10 00 00 	movabs $0xffff80000010b61b,%rax
ffff80000010b561:	80 ff ff 
ffff80000010b564:	ff d0                	call   *%rax
      return 0;
ffff80000010b566:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b56b:	e9 a9 00 00 00       	jmp    ffff80000010b619 <allocuvm+0x142>
    }
    memset(mem, 0, PGSIZE);
ffff80000010b570:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b574:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b579:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b57e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b581:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010b588:	80 ff ff 
ffff80000010b58b:	ff d0                	call   *%rax
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
ffff80000010b58d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b591:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b598:	80 00 00 
ffff80000010b59b:	48 01 c2             	add    %rax,%rdx
ffff80000010b59e:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010b5a2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b5a6:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010b5ac:	48 89 d1             	mov    %rdx,%rcx
ffff80000010b5af:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b5b4:	48 89 c7             	mov    %rax,%rdi
ffff80000010b5b7:	48 b8 1c b2 10 00 00 	movabs $0xffff80000010b21c,%rax
ffff80000010b5be:	80 ff ff 
ffff80000010b5c1:	ff d0                	call   *%rax
ffff80000010b5c3:	85 c0                	test   %eax,%eax
ffff80000010b5c5:	79 38                	jns    ffff80000010b5ff <allocuvm+0x128>
      //cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
ffff80000010b5c7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010b5cb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b5cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b5d3:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b5d6:	48 89 c7             	mov    %rax,%rdi
ffff80000010b5d9:	48 b8 1b b6 10 00 00 	movabs $0xffff80000010b61b,%rax
ffff80000010b5e0:	80 ff ff 
ffff80000010b5e3:	ff d0                	call   *%rax
      kfree(mem);
ffff80000010b5e5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b5e9:	48 89 c7             	mov    %rax,%rdi
ffff80000010b5ec:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b5f3:	80 ff ff 
ffff80000010b5f6:	ff d0                	call   *%rax
      return 0;
ffff80000010b5f8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b5fd:	eb 1a                	jmp    ffff80000010b619 <allocuvm+0x142>
  for(; a < newsz; a += PGSIZE){
ffff80000010b5ff:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b606:	00 
ffff80000010b607:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b60b:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010b60f:	0f 82 1c ff ff ff    	jb     ffff80000010b531 <allocuvm+0x5a>
    }
  }
  return newsz;
ffff80000010b615:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
}
ffff80000010b619:	c9                   	leave
ffff80000010b61a:	c3                   	ret

ffff80000010b61b <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
deallocuvm(pde_t *pgdir, uint64 oldsz, uint64 newsz)
{
ffff80000010b61b:	55                   	push   %rbp
ffff80000010b61c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b61f:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b623:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b627:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b62b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
  pte_t *pte;
  addr_t a, pa;

  if(newsz >= oldsz)
ffff80000010b62f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b633:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010b637:	72 09                	jb     ffff80000010b642 <deallocuvm+0x27>
    return oldsz;
ffff80000010b639:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b63d:	e9 d0 00 00 00       	jmp    ffff80000010b712 <deallocuvm+0xf7>

  a = PGROUNDUP(newsz);
ffff80000010b642:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b646:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010b64c:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b652:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010b656:	e9 a5 00 00 00       	jmp    ffff80000010b700 <deallocuvm+0xe5>
    pte = walkpgdir(pgdir, (char*)a, 0);
ffff80000010b65b:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b65f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b663:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b668:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b66b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b66e:	48 b8 9d af 10 00 00 	movabs $0xffff80000010af9d,%rax
ffff80000010b675:	80 ff ff 
ffff80000010b678:	ff d0                	call   *%rax
ffff80000010b67a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(pte && (*pte & PTE_P) != 0){
ffff80000010b67e:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b683:	74 73                	je     ffff80000010b6f8 <deallocuvm+0xdd>
ffff80000010b685:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b689:	48 8b 00             	mov    (%rax),%rax
ffff80000010b68c:	83 e0 01             	and    $0x1,%eax
ffff80000010b68f:	48 85 c0             	test   %rax,%rax
ffff80000010b692:	74 64                	je     ffff80000010b6f8 <deallocuvm+0xdd>
      pa = PTE_ADDR(*pte);
ffff80000010b694:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b698:	48 8b 00             	mov    (%rax),%rax
ffff80000010b69b:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b6a1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      if(pa == 0)
ffff80000010b6a5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b6aa:	75 19                	jne    ffff80000010b6c5 <deallocuvm+0xaa>
        panic("kfree");
ffff80000010b6ac:	48 b8 29 c6 10 00 00 	movabs $0xffff80000010c629,%rax
ffff80000010b6b3:	80 ff ff 
ffff80000010b6b6:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6b9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b6c0:	80 ff ff 
ffff80000010b6c3:	ff d0                	call   *%rax
      char *v = P2V(pa);
ffff80000010b6c5:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010b6cc:	80 ff ff 
ffff80000010b6cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b6d3:	48 01 d0             	add    %rdx,%rax
ffff80000010b6d6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
      kfree(v);
ffff80000010b6da:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b6de:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6e1:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b6e8:	80 ff ff 
ffff80000010b6eb:	ff d0                	call   *%rax
      *pte = 0;
ffff80000010b6ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b6f1:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
  for(; a  < oldsz; a += PGSIZE){
ffff80000010b6f8:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b6ff:	00 
ffff80000010b700:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b704:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010b708:	0f 82 4d ff ff ff    	jb     ffff80000010b65b <deallocuvm+0x40>
    }
  }
  return newsz;
ffff80000010b70e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
}
ffff80000010b712:	c9                   	leave
ffff80000010b713:	c3                   	ret

ffff80000010b714 <freevm>:

// Free all the pages mapped by, and all the memory used for,
// this page table
void
freevm(pml4e_t *pml4)
{
ffff80000010b714:	55                   	push   %rbp
ffff80000010b715:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b718:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b71c:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
  uint i, j, k, l;
  pde_t *pdp, *pd, *pt;

  if(pml4 == 0)
ffff80000010b720:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010b725:	75 19                	jne    ffff80000010b740 <freevm+0x2c>
    panic("freevm: no pgdir");
ffff80000010b727:	48 b8 2f c6 10 00 00 	movabs $0xffff80000010c62f,%rax
ffff80000010b72e:	80 ff ff 
ffff80000010b731:	48 89 c7             	mov    %rax,%rdi
ffff80000010b734:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b73b:	80 ff ff 
ffff80000010b73e:	ff d0                	call   *%rax

  // then need to loop through pml4 entry
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010b740:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010b747:	e9 dc 01 00 00       	jmp    ffff80000010b928 <freevm+0x214>
    if(pml4[i] & PTE_P){
ffff80000010b74c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b74f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b756:	00 
ffff80000010b757:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b75b:	48 01 d0             	add    %rdx,%rax
ffff80000010b75e:	48 8b 00             	mov    (%rax),%rax
ffff80000010b761:	83 e0 01             	and    $0x1,%eax
ffff80000010b764:	48 85 c0             	test   %rax,%rax
ffff80000010b767:	0f 84 b7 01 00 00    	je     ffff80000010b924 <freevm+0x210>
      pdp = (pdpe_t*)P2V(PTE_ADDR(pml4[i]));
ffff80000010b76d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b770:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b777:	00 
ffff80000010b778:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b77c:	48 01 d0             	add    %rdx,%rax
ffff80000010b77f:	48 8b 00             	mov    (%rax),%rax
ffff80000010b782:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b788:	48 89 c2             	mov    %rax,%rdx
ffff80000010b78b:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b792:	80 ff ff 
ffff80000010b795:	48 01 d0             	add    %rdx,%rax
ffff80000010b798:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

      // and every entry in the corresponding pdpt
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010b79c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010b7a3:	e9 5c 01 00 00       	jmp    ffff80000010b904 <freevm+0x1f0>
        if(pdp[j] & PTE_P){
ffff80000010b7a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010b7ab:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b7b2:	00 
ffff80000010b7b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b7b7:	48 01 d0             	add    %rdx,%rax
ffff80000010b7ba:	48 8b 00             	mov    (%rax),%rax
ffff80000010b7bd:	83 e0 01             	and    $0x1,%eax
ffff80000010b7c0:	48 85 c0             	test   %rax,%rax
ffff80000010b7c3:	0f 84 37 01 00 00    	je     ffff80000010b900 <freevm+0x1ec>
          pd = (pde_t*)P2V(PTE_ADDR(pdp[j]));
ffff80000010b7c9:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010b7cc:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b7d3:	00 
ffff80000010b7d4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b7d8:	48 01 d0             	add    %rdx,%rax
ffff80000010b7db:	48 8b 00             	mov    (%rax),%rax
ffff80000010b7de:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b7e4:	48 89 c2             	mov    %rax,%rdx
ffff80000010b7e7:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b7ee:	80 ff ff 
ffff80000010b7f1:	48 01 d0             	add    %rdx,%rax
ffff80000010b7f4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

          // and every entry in the corresponding page directory
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010b7f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010b7ff:	e9 dc 00 00 00       	jmp    ffff80000010b8e0 <freevm+0x1cc>
            if(pd[k] & PTE_P) {
ffff80000010b804:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010b807:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b80e:	00 
ffff80000010b80f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b813:	48 01 d0             	add    %rdx,%rax
ffff80000010b816:	48 8b 00             	mov    (%rax),%rax
ffff80000010b819:	83 e0 01             	and    $0x1,%eax
ffff80000010b81c:	48 85 c0             	test   %rax,%rax
ffff80000010b81f:	0f 84 b7 00 00 00    	je     ffff80000010b8dc <freevm+0x1c8>
              pt = (pde_t*)P2V(PTE_ADDR(pd[k]));
ffff80000010b825:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010b828:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b82f:	00 
ffff80000010b830:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b834:	48 01 d0             	add    %rdx,%rax
ffff80000010b837:	48 8b 00             	mov    (%rax),%rax
ffff80000010b83a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b840:	48 89 c2             	mov    %rax,%rdx
ffff80000010b843:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b84a:	80 ff ff 
ffff80000010b84d:	48 01 d0             	add    %rdx,%rax
ffff80000010b850:	48 89 45 d8          	mov    %rax,-0x28(%rbp)

              // and every entry in the corresponding page table
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010b854:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010b85b:	eb 63                	jmp    ffff80000010b8c0 <freevm+0x1ac>
                if(pt[l] & PTE_P) {
ffff80000010b85d:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010b860:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b867:	00 
ffff80000010b868:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b86c:	48 01 d0             	add    %rdx,%rax
ffff80000010b86f:	48 8b 00             	mov    (%rax),%rax
ffff80000010b872:	83 e0 01             	and    $0x1,%eax
ffff80000010b875:	48 85 c0             	test   %rax,%rax
ffff80000010b878:	74 42                	je     ffff80000010b8bc <freevm+0x1a8>
                  char * v = P2V(PTE_ADDR(pt[l]));
ffff80000010b87a:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010b87d:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b884:	00 
ffff80000010b885:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b889:	48 01 d0             	add    %rdx,%rax
ffff80000010b88c:	48 8b 00             	mov    (%rax),%rax
ffff80000010b88f:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b895:	48 89 c2             	mov    %rax,%rdx
ffff80000010b898:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b89f:	80 ff ff 
ffff80000010b8a2:	48 01 d0             	add    %rdx,%rax
ffff80000010b8a5:	48 89 45 d0          	mov    %rax,-0x30(%rbp)

                  kfree((char*)v);
ffff80000010b8a9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b8ad:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8b0:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b8b7:	80 ff ff 
ffff80000010b8ba:	ff d0                	call   *%rax
              for(l = 0; l < (NPDENTRIES); l++){
ffff80000010b8bc:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010b8c0:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010b8c7:	76 94                	jbe    ffff80000010b85d <freevm+0x149>
                }
              }
              //freeing every page table
              kfree((char*)pt);
ffff80000010b8c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b8cd:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8d0:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b8d7:	80 ff ff 
ffff80000010b8da:	ff d0                	call   *%rax
          for(k = 0; k < (NPDENTRIES); k++){
ffff80000010b8dc:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010b8e0:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010b8e7:	0f 86 17 ff ff ff    	jbe    ffff80000010b804 <freevm+0xf0>
            }
          }
          // freeing every page directory
          kfree((char*)pd);
ffff80000010b8ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b8f1:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8f4:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b8fb:	80 ff ff 
ffff80000010b8fe:	ff d0                	call   *%rax
      for(j = 0; j < NPDENTRIES; j++){
ffff80000010b900:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010b904:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010b90b:	0f 86 97 fe ff ff    	jbe    ffff80000010b7a8 <freevm+0x94>
        }
      }
      // freeing every page directory pointer table
      kfree((char*)pdp);
ffff80000010b911:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b915:	48 89 c7             	mov    %rax,%rdi
ffff80000010b918:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b91f:	80 ff ff 
ffff80000010b922:	ff d0                	call   *%rax
  for(i = 0; i < (NPDENTRIES/2); i++){
ffff80000010b924:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010b928:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010b92f:	0f 86 17 fe ff ff    	jbe    ffff80000010b74c <freevm+0x38>
    }
  }
  // freeing the pml4
  kfree((char*)pml4);
ffff80000010b935:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b939:	48 89 c7             	mov    %rax,%rdi
ffff80000010b93c:	48 b8 a5 40 10 00 00 	movabs $0xffff8000001040a5,%rax
ffff80000010b943:	80 ff ff 
ffff80000010b946:	ff d0                	call   *%rax
}
ffff80000010b948:	90                   	nop
ffff80000010b949:	c9                   	leave
ffff80000010b94a:	c3                   	ret

ffff80000010b94b <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pml4e_t *pgdir, char *uva)
{
ffff80000010b94b:	55                   	push   %rbp
ffff80000010b94c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b94f:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010b953:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b957:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010b95b:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010b95f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b963:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b968:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b96b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b96e:	48 b8 9d af 10 00 00 	movabs $0xffff80000010af9d,%rax
ffff80000010b975:	80 ff ff 
ffff80000010b978:	ff d0                	call   *%rax
ffff80000010b97a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(pte == 0)
ffff80000010b97e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010b983:	75 19                	jne    ffff80000010b99e <clearpteu+0x53>
    panic("clearpteu");
ffff80000010b985:	48 b8 40 c6 10 00 00 	movabs $0xffff80000010c640,%rax
ffff80000010b98c:	80 ff ff 
ffff80000010b98f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b992:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b999:	80 ff ff 
ffff80000010b99c:	ff d0                	call   *%rax
  *pte &= ~PTE_U;
ffff80000010b99e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9a2:	48 8b 00             	mov    (%rax),%rax
ffff80000010b9a5:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010b9a9:	48 89 c2             	mov    %rax,%rdx
ffff80000010b9ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b9b0:	48 89 10             	mov    %rdx,(%rax)
}
ffff80000010b9b3:	90                   	nop
ffff80000010b9b4:	c9                   	leave
ffff80000010b9b5:	c3                   	ret

ffff80000010b9b6 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pml4e_t *pgdir, uint sz)
{
ffff80000010b9b6:	55                   	push   %rbp
ffff80000010b9b7:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b9ba:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b9be:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010b9c2:	89 75 c4             	mov    %esi,-0x3c(%rbp)
  pde_t *d;
  pte_t *pte;
  addr_t pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
ffff80000010b9c5:	48 b8 80 ad 10 00 00 	movabs $0xffff80000010ad80,%rax
ffff80000010b9cc:	80 ff ff 
ffff80000010b9cf:	ff d0                	call   *%rax
ffff80000010b9d1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b9d5:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b9da:	75 0a                	jne    ffff80000010b9e6 <copyuvm+0x30>
    return 0;
ffff80000010b9dc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b9e1:	e9 57 01 00 00       	jmp    ffff80000010bb3d <copyuvm+0x187>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010b9e6:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010b9ed:	00 
ffff80000010b9ee:	e9 1b 01 00 00       	jmp    ffff80000010bb0e <copyuvm+0x158>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
ffff80000010b9f3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b9f7:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b9fb:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010ba00:	48 89 ce             	mov    %rcx,%rsi
ffff80000010ba03:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba06:	48 b8 9d af 10 00 00 	movabs $0xffff80000010af9d,%rax
ffff80000010ba0d:	80 ff ff 
ffff80000010ba10:	ff d0                	call   *%rax
ffff80000010ba12:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010ba16:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010ba1b:	75 19                	jne    ffff80000010ba36 <copyuvm+0x80>
      panic("copyuvm: pte should exist");
ffff80000010ba1d:	48 b8 4a c6 10 00 00 	movabs $0xffff80000010c64a,%rax
ffff80000010ba24:	80 ff ff 
ffff80000010ba27:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba2a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010ba31:	80 ff ff 
ffff80000010ba34:	ff d0                	call   *%rax
    if(!(*pte & PTE_P))
ffff80000010ba36:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba3a:	48 8b 00             	mov    (%rax),%rax
ffff80000010ba3d:	83 e0 01             	and    $0x1,%eax
ffff80000010ba40:	48 85 c0             	test   %rax,%rax
ffff80000010ba43:	75 19                	jne    ffff80000010ba5e <copyuvm+0xa8>
      panic("copyuvm: page not present");
ffff80000010ba45:	48 b8 64 c6 10 00 00 	movabs $0xffff80000010c664,%rax
ffff80000010ba4c:	80 ff ff 
ffff80000010ba4f:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba52:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010ba59:	80 ff ff 
ffff80000010ba5c:	ff d0                	call   *%rax
    pa = PTE_ADDR(*pte);
ffff80000010ba5e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba62:	48 8b 00             	mov    (%rax),%rax
ffff80000010ba65:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010ba6b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    flags = PTE_FLAGS(*pte);
ffff80000010ba6f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba73:	48 8b 00             	mov    (%rax),%rax
ffff80000010ba76:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010ba7b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    if((mem = kalloc()) == 0)
ffff80000010ba7f:	48 b8 a4 41 10 00 00 	movabs $0xffff8000001041a4,%rax
ffff80000010ba86:	80 ff ff 
ffff80000010ba89:	ff d0                	call   *%rax
ffff80000010ba8b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010ba8f:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010ba94:	0f 84 87 00 00 00    	je     ffff80000010bb21 <copyuvm+0x16b>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
ffff80000010ba9a:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010baa1:	80 ff ff 
ffff80000010baa4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010baa8:	48 01 d0             	add    %rdx,%rax
ffff80000010baab:	48 89 c1             	mov    %rax,%rcx
ffff80000010baae:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bab2:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bab7:	48 89 ce             	mov    %rcx,%rsi
ffff80000010baba:	48 89 c7             	mov    %rax,%rdi
ffff80000010babd:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff80000010bac4:	80 ff ff 
ffff80000010bac7:	ff d0                	call   *%rax
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
ffff80000010bac9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bacd:	89 c1                	mov    %eax,%ecx
ffff80000010bacf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bad3:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bada:	80 00 00 
ffff80000010badd:	48 01 c2             	add    %rax,%rdx
ffff80000010bae0:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010bae4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bae8:	41 89 c8             	mov    %ecx,%r8d
ffff80000010baeb:	48 89 d1             	mov    %rdx,%rcx
ffff80000010baee:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010baf3:	48 89 c7             	mov    %rax,%rdi
ffff80000010baf6:	48 b8 1c b2 10 00 00 	movabs $0xffff80000010b21c,%rax
ffff80000010bafd:	80 ff ff 
ffff80000010bb00:	ff d0                	call   *%rax
ffff80000010bb02:	85 c0                	test   %eax,%eax
ffff80000010bb04:	78 1e                	js     ffff80000010bb24 <copyuvm+0x16e>
  for(i = PGSIZE; i < sz; i += PGSIZE){
ffff80000010bb06:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bb0d:	00 
ffff80000010bb0e:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010bb11:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010bb15:	0f 82 d8 fe ff ff    	jb     ffff80000010b9f3 <copyuvm+0x3d>
      goto bad;
  }
  return d;
ffff80000010bb1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bb1f:	eb 1c                	jmp    ffff80000010bb3d <copyuvm+0x187>
      goto bad;
ffff80000010bb21:	90                   	nop
ffff80000010bb22:	eb 01                	jmp    ffff80000010bb25 <copyuvm+0x16f>
      goto bad;
ffff80000010bb24:	90                   	nop

bad:
  freevm(d);
ffff80000010bb25:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bb29:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb2c:	48 b8 14 b7 10 00 00 	movabs $0xffff80000010b714,%rax
ffff80000010bb33:	80 ff ff 
ffff80000010bb36:	ff d0                	call   *%rax
  return 0;
ffff80000010bb38:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010bb3d:	c9                   	leave
ffff80000010bb3e:	c3                   	ret

ffff80000010bb3f <uva2ka>:

// Map user virtual address to kernel address.
char*
uva2ka(pml4e_t *pgdir, char *uva)
{
ffff80000010bb3f:	55                   	push   %rbp
ffff80000010bb40:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bb43:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010bb47:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bb4b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
ffff80000010bb4f:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010bb53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bb57:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bb5c:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bb5f:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb62:	48 b8 9d af 10 00 00 	movabs $0xffff80000010af9d,%rax
ffff80000010bb69:	80 ff ff 
ffff80000010bb6c:	ff d0                	call   *%rax
ffff80000010bb6e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if((*pte & PTE_P) == 0)
ffff80000010bb72:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb76:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb79:	83 e0 01             	and    $0x1,%eax
ffff80000010bb7c:	48 85 c0             	test   %rax,%rax
ffff80000010bb7f:	75 07                	jne    ffff80000010bb88 <uva2ka+0x49>
    return 0;
ffff80000010bb81:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bb86:	eb 33                	jmp    ffff80000010bbbb <uva2ka+0x7c>
  if((*pte & PTE_U) == 0)
ffff80000010bb88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bb8c:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb8f:	83 e0 04             	and    $0x4,%eax
ffff80000010bb92:	48 85 c0             	test   %rax,%rax
ffff80000010bb95:	75 07                	jne    ffff80000010bb9e <uva2ka+0x5f>
    return 0;
ffff80000010bb97:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bb9c:	eb 1d                	jmp    ffff80000010bbbb <uva2ka+0x7c>
  return (char*)P2V(PTE_ADDR(*pte));
ffff80000010bb9e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bba2:	48 8b 00             	mov    (%rax),%rax
ffff80000010bba5:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bbab:	48 89 c2             	mov    %rax,%rdx
ffff80000010bbae:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bbb5:	80 ff ff 
ffff80000010bbb8:	48 01 d0             	add    %rdx,%rax
}
ffff80000010bbbb:	c9                   	leave
ffff80000010bbbc:	c3                   	ret

ffff80000010bbbd <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pml4e_t *pgdir, addr_t va, void *p, uint64 len)
{
ffff80000010bbbd:	55                   	push   %rbp
ffff80000010bbbe:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bbc1:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bbc5:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010bbc9:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010bbcd:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010bbd1:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
  char *buf, *pa0;
  addr_t n, va0;

  buf = (char*)p;
ffff80000010bbd5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bbd9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while(len > 0){
ffff80000010bbdd:	e9 b0 00 00 00       	jmp    ffff80000010bc92 <copyout+0xd5>
    va0 = PGROUNDDOWN(va);
ffff80000010bbe2:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bbe6:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bbec:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    pa0 = uva2ka(pgdir, (char*)va0);
ffff80000010bbf0:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010bbf4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bbf8:	48 89 d6             	mov    %rdx,%rsi
ffff80000010bbfb:	48 89 c7             	mov    %rax,%rdi
ffff80000010bbfe:	48 b8 3f bb 10 00 00 	movabs $0xffff80000010bb3f,%rax
ffff80000010bc05:	80 ff ff 
ffff80000010bc08:	ff d0                	call   *%rax
ffff80000010bc0a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    if(pa0 == 0)
ffff80000010bc0e:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010bc13:	75 0a                	jne    ffff80000010bc1f <copyout+0x62>
      return -1;
ffff80000010bc15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010bc1a:	e9 83 00 00 00       	jmp    ffff80000010bca2 <copyout+0xe5>
    n = PGSIZE - (va - va0);
ffff80000010bc1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc23:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010bc27:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010bc2d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    if(n > len)
ffff80000010bc31:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc35:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010bc39:	73 08                	jae    ffff80000010bc43 <copyout+0x86>
      n = len;
ffff80000010bc3b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010bc3f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    memmove(pa0 + (va - va0), buf, n);
ffff80000010bc43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc47:	89 c6                	mov    %eax,%esi
ffff80000010bc49:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bc4d:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010bc51:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc54:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bc58:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010bc5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bc60:	89 f2                	mov    %esi,%edx
ffff80000010bc62:	48 89 c6             	mov    %rax,%rsi
ffff80000010bc65:	48 89 cf             	mov    %rcx,%rdi
ffff80000010bc68:	48 b8 f8 78 10 00 00 	movabs $0xffff8000001078f8,%rax
ffff80000010bc6f:	80 ff ff 
ffff80000010bc72:	ff d0                	call   *%rax
    len -= n;
ffff80000010bc74:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc78:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
    buf += n;
ffff80000010bc7c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bc80:	48 01 45 f8          	add    %rax,-0x8(%rbp)
    va = va0 + PGSIZE;
ffff80000010bc84:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc88:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010bc8e:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
  while(len > 0){
ffff80000010bc92:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010bc97:	0f 85 45 ff ff ff    	jne    ffff80000010bbe2 <copyout+0x25>
  }
  return 0;
ffff80000010bc9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010bca2:	c9                   	leave
ffff80000010bca3:	c3                   	ret

ffff80000010bca4 <traceinit>:
    struct trace_event events[TRACE_BUF_SIZE];  // Ring buffer
} traceBuffer;

// Initalize the tracing event
void 
traceinit(void){
ffff80000010bca4:	55                   	push   %rbp
ffff80000010bca5:	48 89 e5             	mov    %rsp,%rbp
    initlock(&traceBuffer.lock, "trace");
ffff80000010bca8:	48 ba 7e c6 10 00 00 	movabs $0xffff80000010c67e,%rdx
ffff80000010bcaf:	80 ff ff 
ffff80000010bcb2:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bcb9:	80 ff ff 
ffff80000010bcbc:	48 89 d6             	mov    %rdx,%rsi
ffff80000010bcbf:	48 89 c7             	mov    %rax,%rdi
ffff80000010bcc2:	48 b8 2a 74 10 00 00 	movabs $0xffff80000010742a,%rax
ffff80000010bcc9:	80 ff ff 
ffff80000010bccc:	ff d0                	call   *%rax
    traceBuffer.enabled = 1;
ffff80000010bcce:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bcd5:	80 ff ff 
ffff80000010bcd8:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
    traceBuffer.seq = 0;
ffff80000010bcdf:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bce6:	80 ff ff 
ffff80000010bce9:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%rax)
    traceBuffer.readseq = 0;
ffff80000010bcf0:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bcf7:	80 ff ff 
ffff80000010bcfa:	c7 40 70 00 00 00 00 	movl   $0x0,0x70(%rax)
}
ffff80000010bd01:	90                   	nop
ffff80000010bd02:	5d                   	pop    %rbp
ffff80000010bd03:	c3                   	ret

ffff80000010bd04 <traceevent>:

// trace the current event
void 
traceevent(int type, int pid, int arg0, int arg1, char *name){
ffff80000010bd04:	55                   	push   %rbp
ffff80000010bd05:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bd08:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010bd0c:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010bd0f:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff80000010bd12:	89 55 e4             	mov    %edx,-0x1c(%rbp)
ffff80000010bd15:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffff80000010bd18:	4c 89 45 d8          	mov    %r8,-0x28(%rbp)
    struct trace_event *event;

    // if the trace buffer is not enabled, then return nothing
    if(!traceBuffer.enabled)
ffff80000010bd1c:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bd23:	80 ff ff 
ffff80000010bd26:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010bd29:	85 c0                	test   %eax,%eax
ffff80000010bd2b:	0f 84 64 01 00 00    	je     ffff80000010be95 <traceevent+0x191>
        return;

    //aquire the lock
    acquire(&traceBuffer.lock);
ffff80000010bd31:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bd38:	80 ff ff 
ffff80000010bd3b:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd3e:	48 b8 5f 74 10 00 00 	movabs $0xffff80000010745f,%rax
ffff80000010bd45:	80 ff ff 
ffff80000010bd48:	ff d0                	call   *%rax

    event = &traceBuffer.events[traceBuffer.seq % TRACE_BUF_SIZE]; // Allows ring to wrap
ffff80000010bd4a:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bd51:	80 ff ff 
ffff80000010bd54:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010bd57:	83 e0 7f             	and    $0x7f,%eax
ffff80000010bd5a:	89 c2                	mov    %eax,%edx
ffff80000010bd5c:	48 89 d0             	mov    %rdx,%rax
ffff80000010bd5f:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010bd63:	48 01 d0             	add    %rdx,%rax
ffff80000010bd66:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010bd6a:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff80000010bd6e:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bd75:	80 ff ff 
ffff80000010bd78:	48 01 d0             	add    %rdx,%rax
ffff80000010bd7b:	48 83 c0 04          	add    $0x4,%rax
ffff80000010bd7f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    // Set the event metadata
    event->seq = traceBuffer.seq;
ffff80000010bd83:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bd8a:	80 ff ff 
ffff80000010bd8d:	8b 50 6c             	mov    0x6c(%rax),%edx
ffff80000010bd90:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bd94:	89 10                	mov    %edx,(%rax)
    event->ticks = ticks;
ffff80000010bd96:	48 b8 48 ad 11 00 00 	movabs $0xffff80000011ad48,%rax
ffff80000010bd9d:	80 ff ff 
ffff80000010bda0:	8b 10                	mov    (%rax),%edx
ffff80000010bda2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bda6:	89 50 04             	mov    %edx,0x4(%rax)
    event->type = type;
ffff80000010bda9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdad:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010bdb0:	89 50 08             	mov    %edx,0x8(%rax)
    event->pid = pid;
ffff80000010bdb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdb7:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010bdba:	89 50 0c             	mov    %edx,0xc(%rax)
    event->arg0 = arg0;
ffff80000010bdbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdc1:	8b 55 e4             	mov    -0x1c(%rbp),%edx
ffff80000010bdc4:	89 50 10             	mov    %edx,0x10(%rax)
    event->arg1 = arg1;
ffff80000010bdc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdcb:	8b 55 e0             	mov    -0x20(%rbp),%edx
ffff80000010bdce:	89 50 14             	mov    %edx,0x14(%rax)

    memset(event->name, 0, sizeof(event->name));
ffff80000010bdd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdd5:	48 83 c0 18          	add    $0x18,%rax
ffff80000010bdd9:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010bdde:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010bde3:	48 89 c7             	mov    %rax,%rdi
ffff80000010bde6:	48 b8 f3 77 10 00 00 	movabs $0xffff8000001077f3,%rax
ffff80000010bded:	80 ff ff 
ffff80000010bdf0:	ff d0                	call   *%rax

    if(name)
ffff80000010bdf2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff80000010bdf7:	74 23                	je     ffff80000010be1c <traceevent+0x118>
        safestrcpy(event->name, name, sizeof(event->name));
ffff80000010bdf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bdfd:	48 8d 48 18          	lea    0x18(%rax),%rcx
ffff80000010be01:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010be05:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010be0a:	48 89 c6             	mov    %rax,%rsi
ffff80000010be0d:	48 89 cf             	mov    %rcx,%rdi
ffff80000010be10:	48 b8 ab 7a 10 00 00 	movabs $0xffff800000107aab,%rax
ffff80000010be17:	80 ff ff 
ffff80000010be1a:	ff d0                	call   *%rax

    traceBuffer.seq++; // Update sequence number
ffff80000010be1c:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be23:	80 ff ff 
ffff80000010be26:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010be29:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010be2c:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be33:	80 ff ff 
ffff80000010be36:	89 50 6c             	mov    %edx,0x6c(%rax)

    // If the writer gets more than 128 events ahead, old events are gone, move readseq  foreward to the oldest event still available
    if(traceBuffer.seq - traceBuffer.readseq > TRACE_BUF_SIZE)
ffff80000010be39:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be40:	80 ff ff 
ffff80000010be43:	8b 50 6c             	mov    0x6c(%rax),%edx
ffff80000010be46:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be4d:	80 ff ff 
ffff80000010be50:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010be53:	29 c2                	sub    %eax,%edx
ffff80000010be55:	81 fa 80 00 00 00    	cmp    $0x80,%edx
ffff80000010be5b:	76 1d                	jbe    ffff80000010be7a <traceevent+0x176>
        traceBuffer.readseq = traceBuffer.seq - TRACE_BUF_SIZE;
ffff80000010be5d:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be64:	80 ff ff 
ffff80000010be67:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010be6a:	8d 50 80             	lea    -0x80(%rax),%edx
ffff80000010be6d:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be74:	80 ff ff 
ffff80000010be77:	89 50 70             	mov    %edx,0x70(%rax)

    // Release the lock
    release(&traceBuffer.lock);
ffff80000010be7a:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010be81:	80 ff ff 
ffff80000010be84:	48 89 c7             	mov    %rax,%rdi
ffff80000010be87:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010be8e:	80 ff ff 
ffff80000010be91:	ff d0                	call   *%rax
ffff80000010be93:	eb 01                	jmp    ffff80000010be96 <traceevent+0x192>
        return;
ffff80000010be95:	90                   	nop
}
ffff80000010be96:	c9                   	leave
ffff80000010be97:	c3                   	ret

ffff80000010be98 <traceread>:

int
traceread(struct trace_event *dst){
ffff80000010be98:	55                   	push   %rbp
ffff80000010be99:	48 89 e5             	mov    %rsp,%rbp
ffff80000010be9c:	53                   	push   %rbx
ffff80000010be9d:	48 83 ec 48          	sub    $0x48,%rsp
ffff80000010bea1:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
    struct trace_event event;

    // No unread events available, return 0
    if(traceBuffer.readseq == traceBuffer.seq){
ffff80000010bea5:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010beac:	80 ff ff 
ffff80000010beaf:	8b 50 70             	mov    0x70(%rax),%edx
ffff80000010beb2:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010beb9:	80 ff ff 
ffff80000010bebc:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010bebf:	39 c2                	cmp    %eax,%edx
ffff80000010bec1:	75 23                	jne    ffff80000010bee6 <traceread+0x4e>
        release(&traceBuffer.lock); // Release the lock
ffff80000010bec3:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010beca:	80 ff ff 
ffff80000010becd:	48 89 c7             	mov    %rax,%rdi
ffff80000010bed0:	48 b8 fe 74 10 00 00 	movabs $0xffff8000001074fe,%rax
ffff80000010bed7:	80 ff ff 
ffff80000010beda:	ff d0                	call   *%rax
        return 0;
ffff80000010bedc:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bee1:	e9 b1 00 00 00       	jmp    ffff80000010bf97 <traceread+0xff>
    }

    event = traceBuffer.events[traceBuffer.readseq % TRACE_BUF_SIZE];
ffff80000010bee6:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010beed:	80 ff ff 
ffff80000010bef0:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010bef3:	83 e0 7f             	and    $0x7f,%eax
ffff80000010bef6:	48 ba 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rdx
ffff80000010befd:	80 ff ff 
ffff80000010bf00:	89 c1                	mov    %eax,%ecx
ffff80000010bf02:	48 89 c8             	mov    %rcx,%rax
ffff80000010bf05:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010bf09:	48 01 c8             	add    %rcx,%rax
ffff80000010bf0c:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010bf10:	48 01 d0             	add    %rdx,%rax
ffff80000010bf13:	48 83 c0 70          	add    $0x70,%rax
ffff80000010bf17:	48 8b 48 04          	mov    0x4(%rax),%rcx
ffff80000010bf1b:	48 8b 58 0c          	mov    0xc(%rax),%rbx
ffff80000010bf1f:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010bf23:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff80000010bf27:	48 8b 48 14          	mov    0x14(%rax),%rcx
ffff80000010bf2b:	48 8b 58 1c          	mov    0x1c(%rax),%rbx
ffff80000010bf2f:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff80000010bf33:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff80000010bf37:	48 8b 40 24          	mov    0x24(%rax),%rax
ffff80000010bf3b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    traceBuffer.readseq++; // Increment
ffff80000010bf3f:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bf46:	80 ff ff 
ffff80000010bf49:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010bf4c:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010bf4f:	48 b8 80 ad 11 00 00 	movabs $0xffff80000011ad80,%rax
ffff80000010bf56:	80 ff ff 
ffff80000010bf59:	89 50 70             	mov    %edx,0x70(%rax)

    if(copyout(proc->pgdir, (addr_t)dst, &event, sizeof(event)) < 0)
ffff80000010bf5c:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
ffff80000010bf60:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010bf67:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010bf6b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010bf6f:	48 8d 55 c0          	lea    -0x40(%rbp),%rdx
ffff80000010bf73:	b9 28 00 00 00       	mov    $0x28,%ecx
ffff80000010bf78:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf7b:	48 b8 bd bb 10 00 00 	movabs $0xffff80000010bbbd,%rax
ffff80000010bf82:	80 ff ff 
ffff80000010bf85:	ff d0                	call   *%rax
ffff80000010bf87:	85 c0                	test   %eax,%eax
ffff80000010bf89:	79 07                	jns    ffff80000010bf92 <traceread+0xfa>
        return -1;
ffff80000010bf8b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010bf90:	eb 05                	jmp    ffff80000010bf97 <traceread+0xff>

    return 1;
ffff80000010bf92:	b8 01 00 00 00       	mov    $0x1,%eax
ffff80000010bf97:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff80000010bf9b:	c9                   	leave
ffff80000010bf9c:	c3                   	ret
