
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
ffff800000100051:	0f 01 15 90 00 10 00 	lgdt   0x100090(%rip)        # ffff8000002000e8 <end+0xe20e8>
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
ffff8000001000ea:	e9 fc 54 00 00       	jmp    ffff8000001055eb <main>

ffff8000001000ef <__deadloop>:
ffff8000001000ef:	eb fe                	jmp    ffff8000001000ef <__deadloop>

ffff8000001000f1 <entry64mp>:
ffff8000001000f1:	48 c7 c0 00 70 00 00 	mov    $0x7000,%rax
ffff8000001000f8:	48 8b 60 f0          	mov    -0x10(%rax),%rsp
ffff8000001000fc:	e9 1a 56 00 00       	jmp    ffff80000010571b <mpenter>

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
ffff80000010011b:	55                   	push   %rbp
ffff80000010011c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010011f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100123:	48 ba 78 c5 10 00 00 	movabs $0xffff80000010c578,%rdx
ffff80000010012a:	80 ff ff 
ffff80000010012d:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100134:	80 ff ff 
ffff800000100137:	48 89 d6             	mov    %rdx,%rsi
ffff80000010013a:	48 89 c7             	mov    %rax,%rdi
ffff80000010013d:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000100144:	80 ff ff 
ffff800000100147:	ff d0                	call   *%rax
ffff800000100149:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100150:	80 ff ff 
ffff800000100153:	48 b9 08 41 11 00 00 	movabs $0xffff800000114108,%rcx
ffff80000010015a:	80 ff ff 
ffff80000010015d:	48 89 88 a0 51 00 00 	mov    %rcx,0x51a0(%rax)
ffff800000100164:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010016b:	80 ff ff 
ffff80000010016e:	48 89 88 a8 51 00 00 	mov    %rcx,0x51a8(%rax)
ffff800000100175:	48 b8 68 f0 10 00 00 	movabs $0xffff80000010f068,%rax
ffff80000010017c:	80 ff ff 
ffff80000010017f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100183:	e9 8e 00 00 00       	jmp    ffff800000100216 <binit+0xfb>
ffff800000100188:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010018f:	80 ff ff 
ffff800000100192:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100199:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010019d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
ffff8000001001a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001a8:	48 be 08 41 11 00 00 	movabs $0xffff800000114108,%rsi
ffff8000001001af:	80 ff ff 
ffff8000001001b2:	48 89 b0 98 00 00 00 	mov    %rsi,0x98(%rax)
ffff8000001001b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001001bd:	48 83 c0 10          	add    $0x10,%rax
ffff8000001001c1:	48 ba 7f c5 10 00 00 	movabs $0xffff80000010c57f,%rdx
ffff8000001001c8:	80 ff ff 
ffff8000001001cb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001001ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001001d1:	48 b8 cf 74 10 00 00 	movabs $0xffff8000001074cf,%rax
ffff8000001001d8:	80 ff ff 
ffff8000001001db:	ff d0                	call   *%rax
ffff8000001001dd:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001001e4:	80 ff ff 
ffff8000001001e7:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff8000001001ee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001001f2:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
ffff8000001001f9:	48 ba 00 f0 10 00 00 	movabs $0xffff80000010f000,%rdx
ffff800000100200:	80 ff ff 
ffff800000100203:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100207:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
ffff80000010020e:	48 81 45 f8 b0 02 00 	addq   $0x2b0,-0x8(%rbp)
ffff800000100215:	00 
ffff800000100216:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff80000010021d:	80 ff ff 
ffff800000100220:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000100224:	0f 82 5e ff ff ff    	jb     ffff800000100188 <binit+0x6d>
ffff80000010022a:	90                   	nop
ffff80000010022b:	90                   	nop
ffff80000010022c:	c9                   	leave
ffff80000010022d:	c3                   	ret

ffff80000010022e <bget>:
ffff80000010022e:	55                   	push   %rbp
ffff80000010022f:	48 89 e5             	mov    %rsp,%rbp
ffff800000100232:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100236:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100239:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff80000010023c:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff800000100243:	80 ff ff 
ffff800000100246:	48 89 c7             	mov    %rax,%rdi
ffff800000100249:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000100250:	80 ff ff 
ffff800000100253:	ff d0                	call   *%rax
ffff800000100255:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010025c:	80 ff ff 
ffff80000010025f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100266:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010026a:	eb 77                	jmp    ffff8000001002e3 <bget+0xb5>
ffff80000010026c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100270:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000100273:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000100276:	75 5c                	jne    ffff8000001002d4 <bget+0xa6>
ffff800000100278:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010027c:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010027f:	39 45 e8             	cmp    %eax,-0x18(%rbp)
ffff800000100282:	75 50                	jne    ffff8000001002d4 <bget+0xa6>
ffff800000100284:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100288:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010028e:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000100291:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100295:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
ffff80000010029b:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001002a2:	80 ff ff 
ffff8000001002a5:	48 89 c7             	mov    %rax,%rdi
ffff8000001002a8:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001002af:	80 ff ff 
ffff8000001002b2:	ff d0                	call   *%rax
ffff8000001002b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002b8:	48 83 c0 10          	add    $0x10,%rax
ffff8000001002bc:	48 89 c7             	mov    %rax,%rdi
ffff8000001002bf:	48 b8 27 75 10 00 00 	movabs $0xffff800000107527,%rax
ffff8000001002c6:	80 ff ff 
ffff8000001002c9:	ff d0                	call   *%rax
ffff8000001002cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002cf:	e9 f6 00 00 00       	jmp    ffff8000001003ca <bget+0x19c>
ffff8000001002d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001002d8:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff8000001002df:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001002e3:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff8000001002ea:	80 ff ff 
ffff8000001002ed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001002f1:	0f 85 75 ff ff ff    	jne    ffff80000010026c <bget+0x3e>
ffff8000001002f7:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001002fe:	80 ff ff 
ffff800000100301:	48 8b 80 a0 51 00 00 	mov    0x51a0(%rax),%rax
ffff800000100308:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010030c:	e9 8c 00 00 00       	jmp    ffff80000010039d <bget+0x16f>
ffff800000100311:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100315:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff80000010031b:	85 c0                	test   %eax,%eax
ffff80000010031d:	75 6f                	jne    ffff80000010038e <bget+0x160>
ffff80000010031f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100323:	8b 00                	mov    (%rax),%eax
ffff800000100325:	83 e0 04             	and    $0x4,%eax
ffff800000100328:	85 c0                	test   %eax,%eax
ffff80000010032a:	75 62                	jne    ffff80000010038e <bget+0x160>
ffff80000010032c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100330:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000100333:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000100336:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010033a:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010033d:	89 50 08             	mov    %edx,0x8(%rax)
ffff800000100340:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100344:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
ffff80000010034a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010034e:	c7 80 90 00 00 00 01 	movl   $0x1,0x90(%rax)
ffff800000100355:	00 00 00 
ffff800000100358:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010035f:	80 ff ff 
ffff800000100362:	48 89 c7             	mov    %rax,%rdi
ffff800000100365:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010036c:	80 ff ff 
ffff80000010036f:	ff d0                	call   *%rax
ffff800000100371:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100375:	48 83 c0 10          	add    $0x10,%rax
ffff800000100379:	48 89 c7             	mov    %rax,%rdi
ffff80000010037c:	48 b8 27 75 10 00 00 	movabs $0xffff800000107527,%rax
ffff800000100383:	80 ff ff 
ffff800000100386:	ff d0                	call   *%rax
ffff800000100388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010038c:	eb 3c                	jmp    ffff8000001003ca <bget+0x19c>
ffff80000010038e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100392:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100399:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010039d:	48 b8 08 41 11 00 00 	movabs $0xffff800000114108,%rax
ffff8000001003a4:	80 ff ff 
ffff8000001003a7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001003ab:	0f 85 60 ff ff ff    	jne    ffff800000100311 <bget+0xe3>
ffff8000001003b1:	48 b8 86 c5 10 00 00 	movabs $0xffff80000010c586,%rax
ffff8000001003b8:	80 ff ff 
ffff8000001003bb:	48 89 c7             	mov    %rax,%rdi
ffff8000001003be:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001003c5:	80 ff ff 
ffff8000001003c8:	ff d0                	call   *%rax
ffff8000001003ca:	c9                   	leave
ffff8000001003cb:	c3                   	ret

ffff8000001003cc <bread>:
ffff8000001003cc:	55                   	push   %rbp
ffff8000001003cd:	48 89 e5             	mov    %rsp,%rbp
ffff8000001003d0:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001003d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001003d7:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff8000001003da:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff8000001003dd:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001003e0:	89 d6                	mov    %edx,%esi
ffff8000001003e2:	89 c7                	mov    %eax,%edi
ffff8000001003e4:	48 b8 2e 02 10 00 00 	movabs $0xffff80000010022e,%rax
ffff8000001003eb:	80 ff ff 
ffff8000001003ee:	ff d0                	call   *%rax
ffff8000001003f0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001003f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001003f8:	8b 00                	mov    (%rax),%eax
ffff8000001003fa:	83 e0 02             	and    $0x2,%eax
ffff8000001003fd:	85 c0                	test   %eax,%eax
ffff8000001003ff:	75 13                	jne    ffff800000100414 <bread+0x48>
ffff800000100401:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100405:	48 89 c7             	mov    %rax,%rdi
ffff800000100408:	48 b8 e3 3d 10 00 00 	movabs $0xffff800000103de3,%rax
ffff80000010040f:	80 ff ff 
ffff800000100412:	ff d0                	call   *%rax
ffff800000100414:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100418:	c9                   	leave
ffff800000100419:	c3                   	ret

ffff80000010041a <bwrite>:
ffff80000010041a:	55                   	push   %rbp
ffff80000010041b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010041e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100422:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000100426:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010042a:	48 83 c0 10          	add    $0x10,%rax
ffff80000010042e:	48 89 c7             	mov    %rax,%rdi
ffff800000100431:	48 b8 12 76 10 00 00 	movabs $0xffff800000107612,%rax
ffff800000100438:	80 ff ff 
ffff80000010043b:	ff d0                	call   *%rax
ffff80000010043d:	85 c0                	test   %eax,%eax
ffff80000010043f:	75 19                	jne    ffff80000010045a <bwrite+0x40>
ffff800000100441:	48 b8 97 c5 10 00 00 	movabs $0xffff80000010c597,%rax
ffff800000100448:	80 ff ff 
ffff80000010044b:	48 89 c7             	mov    %rax,%rdi
ffff80000010044e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000100455:	80 ff ff 
ffff800000100458:	ff d0                	call   *%rax
ffff80000010045a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010045e:	8b 00                	mov    (%rax),%eax
ffff800000100460:	83 c8 04             	or     $0x4,%eax
ffff800000100463:	89 c2                	mov    %eax,%edx
ffff800000100465:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100469:	89 10                	mov    %edx,(%rax)
ffff80000010046b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010046f:	48 89 c7             	mov    %rax,%rdi
ffff800000100472:	48 b8 e3 3d 10 00 00 	movabs $0xffff800000103de3,%rax
ffff800000100479:	80 ff ff 
ffff80000010047c:	ff d0                	call   *%rax
ffff80000010047e:	90                   	nop
ffff80000010047f:	c9                   	leave
ffff800000100480:	c3                   	ret

ffff800000100481 <brelse>:
ffff800000100481:	55                   	push   %rbp
ffff800000100482:	48 89 e5             	mov    %rsp,%rbp
ffff800000100485:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100489:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010048d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100491:	48 83 c0 10          	add    $0x10,%rax
ffff800000100495:	48 89 c7             	mov    %rax,%rdi
ffff800000100498:	48 b8 12 76 10 00 00 	movabs $0xffff800000107612,%rax
ffff80000010049f:	80 ff ff 
ffff8000001004a2:	ff d0                	call   *%rax
ffff8000001004a4:	85 c0                	test   %eax,%eax
ffff8000001004a6:	75 19                	jne    ffff8000001004c1 <brelse+0x40>
ffff8000001004a8:	48 b8 9e c5 10 00 00 	movabs $0xffff80000010c59e,%rax
ffff8000001004af:	80 ff ff 
ffff8000001004b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004b5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001004bc:	80 ff ff 
ffff8000001004bf:	ff d0                	call   *%rax
ffff8000001004c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004c5:	48 83 c0 10          	add    $0x10,%rax
ffff8000001004c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001004cc:	48 b8 ad 75 10 00 00 	movabs $0xffff8000001075ad,%rax
ffff8000001004d3:	80 ff ff 
ffff8000001004d6:	ff d0                	call   *%rax
ffff8000001004d8:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001004df:	80 ff ff 
ffff8000001004e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001004e5:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001004ec:	80 ff ff 
ffff8000001004ef:	ff d0                	call   *%rax
ffff8000001004f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001004f5:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff8000001004fb:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001004fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100502:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
ffff800000100508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010050c:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000100512:	85 c0                	test   %eax,%eax
ffff800000100514:	0f 85 9c 00 00 00    	jne    ffff8000001005b6 <brelse+0x135>
ffff80000010051a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010051e:	48 8b 80 a0 00 00 00 	mov    0xa0(%rax),%rax
ffff800000100525:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000100529:	48 8b 92 98 00 00 00 	mov    0x98(%rdx),%rdx
ffff800000100530:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
ffff800000100537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010053b:	48 8b 80 98 00 00 00 	mov    0x98(%rax),%rax
ffff800000100542:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000100546:	48 8b 92 a0 00 00 00 	mov    0xa0(%rdx),%rdx
ffff80000010054d:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
ffff800000100554:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010055b:	80 ff ff 
ffff80000010055e:	48 8b 90 a8 51 00 00 	mov    0x51a8(%rax),%rdx
ffff800000100565:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100569:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
ffff800000100570:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100574:	48 b9 08 41 11 00 00 	movabs $0xffff800000114108,%rcx
ffff80000010057b:	80 ff ff 
ffff80000010057e:	48 89 88 98 00 00 00 	mov    %rcx,0x98(%rax)
ffff800000100585:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff80000010058c:	80 ff ff 
ffff80000010058f:	48 8b 80 a8 51 00 00 	mov    0x51a8(%rax),%rax
ffff800000100596:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010059a:	48 89 90 98 00 00 00 	mov    %rdx,0x98(%rax)
ffff8000001005a1:	48 ba 00 f0 10 00 00 	movabs $0xffff80000010f000,%rdx
ffff8000001005a8:	80 ff ff 
ffff8000001005ab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001005af:	48 89 82 a8 51 00 00 	mov    %rax,0x51a8(%rdx)
ffff8000001005b6:	48 b8 00 f0 10 00 00 	movabs $0xffff80000010f000,%rax
ffff8000001005bd:	80 ff ff 
ffff8000001005c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001005c3:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001005ca:	80 ff ff 
ffff8000001005cd:	ff d0                	call   *%rax
ffff8000001005cf:	90                   	nop
ffff8000001005d0:	c9                   	leave
ffff8000001005d1:	c3                   	ret

ffff8000001005d2 <inb>:
ffff8000001005d2:	55                   	push   %rbp
ffff8000001005d3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005d6:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001005da:	89 f8                	mov    %edi,%eax
ffff8000001005dc:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff8000001005e0:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff8000001005e4:	89 c2                	mov    %eax,%edx
ffff8000001005e6:	ec                   	in     (%dx),%al
ffff8000001005e7:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff8000001005ea:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff8000001005ee:	c9                   	leave
ffff8000001005ef:	c3                   	ret

ffff8000001005f0 <outb>:
ffff8000001005f0:	55                   	push   %rbp
ffff8000001005f1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001005f4:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001005f8:	89 fa                	mov    %edi,%edx
ffff8000001005fa:	89 f0                	mov    %esi,%eax
ffff8000001005fc:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000100600:	88 45 f8             	mov    %al,-0x8(%rbp)
ffff800000100603:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000100607:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010060b:	ee                   	out    %al,(%dx)
ffff80000010060c:	90                   	nop
ffff80000010060d:	c9                   	leave
ffff80000010060e:	c3                   	ret

ffff80000010060f <lidt>:
ffff80000010060f:	55                   	push   %rbp
ffff800000100610:	48 89 e5             	mov    %rsp,%rbp
ffff800000100613:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100617:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010061b:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffff80000010061e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000100622:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000100626:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000100629:	83 e8 01             	sub    $0x1,%eax
ffff80000010062c:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
ffff800000100630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100634:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
ffff800000100638:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010063c:	48 c1 e8 10          	shr    $0x10,%rax
ffff800000100640:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
ffff800000100644:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100648:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010064c:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
ffff800000100650:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000100654:	48 c1 e8 30          	shr    $0x30,%rax
ffff800000100658:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
ffff80000010065c:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff800000100660:	0f 01 18             	lidt   (%rax)
ffff800000100663:	90                   	nop
ffff800000100664:	c9                   	leave
ffff800000100665:	c3                   	ret

ffff800000100666 <cli>:
ffff800000100666:	55                   	push   %rbp
ffff800000100667:	48 89 e5             	mov    %rsp,%rbp
ffff80000010066a:	fa                   	cli
ffff80000010066b:	90                   	nop
ffff80000010066c:	5d                   	pop    %rbp
ffff80000010066d:	c3                   	ret

ffff80000010066e <hlt>:
ffff80000010066e:	55                   	push   %rbp
ffff80000010066f:	48 89 e5             	mov    %rsp,%rbp
ffff800000100672:	f4                   	hlt
ffff800000100673:	90                   	nop
ffff800000100674:	5d                   	pop    %rbp
ffff800000100675:	c3                   	ret

ffff800000100676 <print_x64>:
ffff800000100676:	55                   	push   %rbp
ffff800000100677:	48 89 e5             	mov    %rsp,%rbp
ffff80000010067a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010067e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000100682:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100689:	eb 30                	jmp    ffff8000001006bb <print_x64+0x45>
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
ffff8000001006b2:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001006b6:	48 c1 65 e8 04       	shlq   $0x4,-0x18(%rbp)
ffff8000001006bb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001006be:	83 f8 0f             	cmp    $0xf,%eax
ffff8000001006c1:	76 c8                	jbe    ffff80000010068b <print_x64+0x15>
ffff8000001006c3:	90                   	nop
ffff8000001006c4:	90                   	nop
ffff8000001006c5:	c9                   	leave
ffff8000001006c6:	c3                   	ret

ffff8000001006c7 <print_x32>:
ffff8000001006c7:	55                   	push   %rbp
ffff8000001006c8:	48 89 e5             	mov    %rsp,%rbp
ffff8000001006cb:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001006cf:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001006d2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001006d9:	eb 31                	jmp    ffff80000010070c <print_x32+0x45>
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
ffff800000100704:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100708:	c1 65 ec 04          	shll   $0x4,-0x14(%rbp)
ffff80000010070c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010070f:	83 f8 07             	cmp    $0x7,%eax
ffff800000100712:	76 c7                	jbe    ffff8000001006db <print_x32+0x14>
ffff800000100714:	90                   	nop
ffff800000100715:	90                   	nop
ffff800000100716:	c9                   	leave
ffff800000100717:	c3                   	ret

ffff800000100718 <print_d>:
ffff800000100718:	55                   	push   %rbp
ffff800000100719:	48 89 e5             	mov    %rsp,%rbp
ffff80000010071c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000100720:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff800000100723:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000100726:	48 98                	cltq
ffff800000100728:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010072c:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000100730:	79 04                	jns    ffff800000100736 <print_d+0x1e>
ffff800000100732:	48 f7 5d f8          	negq   -0x8(%rbp)
ffff800000100736:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
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
ffff8000001007b8:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001007bd:	0f 85 7a ff ff ff    	jne    ffff80000010073d <print_d+0x25>
ffff8000001007c3:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff8000001007c7:	79 2d                	jns    ffff8000001007f6 <print_d+0xde>
ffff8000001007c9:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007cc:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001007cf:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff8000001007d2:	48 98                	cltq
ffff8000001007d4:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)
ffff8000001007d9:	eb 1b                	jmp    ffff8000001007f6 <print_d+0xde>
ffff8000001007db:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001007de:	48 98                	cltq
ffff8000001007e0:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
ffff8000001007e5:	0f be c0             	movsbl %al,%eax
ffff8000001007e8:	89 c7                	mov    %eax,%edi
ffff8000001007ea:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff8000001007f1:	80 ff ff 
ffff8000001007f4:	ff d0                	call   *%rax
ffff8000001007f6:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
ffff8000001007fa:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff8000001007fe:	79 db                	jns    ffff8000001007db <print_d+0xc3>
ffff800000100800:	90                   	nop
ffff800000100801:	90                   	nop
ffff800000100802:	c9                   	leave
ffff800000100803:	c3                   	ret

ffff800000100804 <cprintf>:
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
ffff80000010085d:	c7 85 20 ff ff ff 08 	movl   $0x8,-0xe0(%rbp)
ffff800000100864:	00 00 00 
ffff800000100867:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
ffff80000010086e:	00 00 00 
ffff800000100871:	48 8d 45 10          	lea    0x10(%rbp),%rax
ffff800000100875:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
ffff80000010087c:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
ffff800000100883:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
ffff80000010088a:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100891:	80 ff ff 
ffff800000100894:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000100897:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
ffff80000010089d:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff8000001008a4:	74 19                	je     ffff8000001008bf <cprintf+0xbb>
ffff8000001008a6:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001008ad:	80 ff ff 
ffff8000001008b0:	48 89 c7             	mov    %rax,%rdi
ffff8000001008b3:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001008ba:	80 ff ff 
ffff8000001008bd:	ff d0                	call   *%rax
ffff8000001008bf:	48 83 bd 18 ff ff ff 	cmpq   $0x0,-0xe8(%rbp)
ffff8000001008c6:	00 
ffff8000001008c7:	75 19                	jne    ffff8000001008e2 <cprintf+0xde>
ffff8000001008c9:	48 b8 a5 c5 10 00 00 	movabs $0xffff80000010c5a5,%rax
ffff8000001008d0:	80 ff ff 
ffff8000001008d3:	48 89 c7             	mov    %rax,%rdi
ffff8000001008d6:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001008dd:	80 ff ff 
ffff8000001008e0:	ff d0                	call   *%rax
ffff8000001008e2:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
ffff8000001008e9:	00 00 00 
ffff8000001008ec:	e9 a0 02 00 00       	jmp    ffff800000100b91 <cprintf+0x38d>
ffff8000001008f1:	83 bd 38 ff ff ff 25 	cmpl   $0x25,-0xc8(%rbp)
ffff8000001008f8:	74 19                	je     ffff800000100913 <cprintf+0x10f>
ffff8000001008fa:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100900:	89 c7                	mov    %eax,%edi
ffff800000100902:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100909:	80 ff ff 
ffff80000010090c:	ff d0                	call   *%rax
ffff80000010090e:	e9 77 02 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
ffff800000100913:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
ffff80000010091a:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
ffff800000100920:	48 63 d0             	movslq %eax,%rdx
ffff800000100923:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
ffff80000010092a:	48 01 d0             	add    %rdx,%rax
ffff80000010092d:	0f b6 00             	movzbl (%rax),%eax
ffff800000100930:	0f be c0             	movsbl %al,%eax
ffff800000100933:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000100938:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%rbp)
ffff80000010093e:	83 bd 38 ff ff ff 00 	cmpl   $0x0,-0xc8(%rbp)
ffff800000100945:	0f 84 79 02 00 00    	je     ffff800000100bc4 <cprintf+0x3c0>
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
ffff800000100a03:	e9 82 01 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
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
ffff800000100a58:	e9 2d 01 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
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
ffff800000100aaf:	e9 d6 00 00 00       	jmp    ffff800000100b8a <cprintf+0x386>
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
ffff800000100b08:	48 b8 ae c5 10 00 00 	movabs $0xffff80000010c5ae,%rax
ffff800000100b0f:	80 ff ff 
ffff800000100b12:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
ffff800000100b19:	eb 26                	jmp    ffff800000100b41 <cprintf+0x33d>
ffff800000100b1b:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b22:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000100b26:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
ffff800000100b2d:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b30:	0f be c0             	movsbl %al,%eax
ffff800000100b33:	89 c7                	mov    %eax,%edi
ffff800000100b35:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100b3c:	80 ff ff 
ffff800000100b3f:	ff d0                	call   *%rax
ffff800000100b41:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
ffff800000100b48:	0f b6 00             	movzbl (%rax),%eax
ffff800000100b4b:	84 c0                	test   %al,%al
ffff800000100b4d:	75 cc                	jne    ffff800000100b1b <cprintf+0x317>
ffff800000100b4f:	eb 39                	jmp    ffff800000100b8a <cprintf+0x386>
ffff800000100b51:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b56:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100b5d:	80 ff ff 
ffff800000100b60:	ff d0                	call   *%rax
ffff800000100b62:	eb 26                	jmp    ffff800000100b8a <cprintf+0x386>
ffff800000100b64:	bf 25 00 00 00       	mov    $0x25,%edi
ffff800000100b69:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100b70:	80 ff ff 
ffff800000100b73:	ff d0                	call   *%rax
ffff800000100b75:	8b 85 38 ff ff ff    	mov    -0xc8(%rbp),%eax
ffff800000100b7b:	89 c7                	mov    %eax,%edi
ffff800000100b7d:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000100b84:	80 ff ff 
ffff800000100b87:	ff d0                	call   *%rax
ffff800000100b89:	90                   	nop
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
ffff800000100bc4:	90                   	nop
ffff800000100bc5:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
ffff800000100bcc:	74 19                	je     ffff800000100be7 <cprintf+0x3e3>
ffff800000100bce:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100bd5:	80 ff ff 
ffff800000100bd8:	48 89 c7             	mov    %rax,%rdi
ffff800000100bdb:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000100be2:	80 ff ff 
ffff800000100be5:	ff d0                	call   *%rax
ffff800000100be7:	90                   	nop
ffff800000100be8:	c9                   	leave
ffff800000100be9:	c3                   	ret

ffff800000100bea <panic>:
ffff800000100bea:	55                   	push   %rbp
ffff800000100beb:	48 89 e5             	mov    %rsp,%rbp
ffff800000100bee:	48 83 ec 70          	sub    $0x70,%rsp
ffff800000100bf2:	48 89 7d 98          	mov    %rdi,-0x68(%rbp)
ffff800000100bf6:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000100bfd:	80 ff ff 
ffff800000100c00:	ff d0                	call   *%rax
ffff800000100c02:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000100c09:	80 ff ff 
ffff800000100c0c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%rax)
ffff800000100c13:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000100c1a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000100c1e:	0f b6 00             	movzbl (%rax),%eax
ffff800000100c21:	0f b6 c0             	movzbl %al,%eax
ffff800000100c24:	48 ba b5 c5 10 00 00 	movabs $0xffff80000010c5b5,%rdx
ffff800000100c2b:	80 ff ff 
ffff800000100c2e:	89 c6                	mov    %eax,%esi
ffff800000100c30:	48 89 d7             	mov    %rdx,%rdi
ffff800000100c33:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c38:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c3f:	80 ff ff 
ffff800000100c42:	ff d2                	call   *%rdx
ffff800000100c44:	48 8b 45 98          	mov    -0x68(%rbp),%rax
ffff800000100c48:	48 89 c7             	mov    %rax,%rdi
ffff800000100c4b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c50:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c57:	80 ff ff 
ffff800000100c5a:	ff d2                	call   *%rdx
ffff800000100c5c:	48 b8 c4 c5 10 00 00 	movabs $0xffff80000010c5c4,%rax
ffff800000100c63:	80 ff ff 
ffff800000100c66:	48 89 c7             	mov    %rax,%rdi
ffff800000100c69:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100c6e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100c75:	80 ff ff 
ffff800000100c78:	ff d2                	call   *%rdx
ffff800000100c7a:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
ffff800000100c7e:	48 8d 45 98          	lea    -0x68(%rbp),%rax
ffff800000100c82:	48 89 d6             	mov    %rdx,%rsi
ffff800000100c85:	48 89 c7             	mov    %rax,%rdi
ffff800000100c88:	48 b8 f0 77 10 00 00 	movabs $0xffff8000001077f0,%rax
ffff800000100c8f:	80 ff ff 
ffff800000100c92:	ff d0                	call   *%rax
ffff800000100c94:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100c9b:	eb 2f                	jmp    ffff800000100ccc <panic+0xe2>
ffff800000100c9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ca0:	48 98                	cltq
ffff800000100ca2:	48 8b 44 c5 a0       	mov    -0x60(%rbp,%rax,8),%rax
ffff800000100ca7:	48 ba c6 c5 10 00 00 	movabs $0xffff80000010c5c6,%rdx
ffff800000100cae:	80 ff ff 
ffff800000100cb1:	48 89 c6             	mov    %rax,%rsi
ffff800000100cb4:	48 89 d7             	mov    %rdx,%rdi
ffff800000100cb7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000100cbc:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000100cc3:	80 ff ff 
ffff800000100cc6:	ff d2                	call   *%rdx
ffff800000100cc8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100ccc:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000100cd0:	7e cb                	jle    ffff800000100c9d <panic+0xb3>
ffff800000100cd2:	48 b8 b8 44 11 00 00 	movabs $0xffff8000001144b8,%rax
ffff800000100cd9:	80 ff ff 
ffff800000100cdc:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
ffff800000100ce2:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff800000100ce9:	80 ff ff 
ffff800000100cec:	ff d0                	call   *%rax
ffff800000100cee:	eb f2                	jmp    ffff800000100ce2 <panic+0xf8>

ffff800000100cf0 <cgaputc>:
ffff800000100cf0:	55                   	push   %rbp
ffff800000100cf1:	48 89 e5             	mov    %rsp,%rbp
ffff800000100cf4:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000100cf8:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100cfb:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100d00:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d05:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100d0c:	80 ff ff 
ffff800000100d0f:	ff d0                	call   *%rax
ffff800000100d11:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d16:	48 b8 d2 05 10 00 00 	movabs $0xffff8000001005d2,%rax
ffff800000100d1d:	80 ff ff 
ffff800000100d20:	ff d0                	call   *%rax
ffff800000100d22:	0f b6 c0             	movzbl %al,%eax
ffff800000100d25:	c1 e0 08             	shl    $0x8,%eax
ffff800000100d28:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000100d2b:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100d30:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100d35:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100d3c:	80 ff ff 
ffff800000100d3f:	ff d0                	call   *%rax
ffff800000100d41:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100d46:	48 b8 d2 05 10 00 00 	movabs $0xffff8000001005d2,%rax
ffff800000100d4d:	80 ff ff 
ffff800000100d50:	ff d0                	call   *%rax
ffff800000100d52:	0f b6 c0             	movzbl %al,%eax
ffff800000100d55:	09 45 fc             	or     %eax,-0x4(%rbp)
ffff800000100d58:	83 7d ec 0a          	cmpl   $0xa,-0x14(%rbp)
ffff800000100d5c:	75 37                	jne    ffff800000100d95 <cgaputc+0xa5>
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
ffff800000100d95:	81 7d ec 00 01 00 00 	cmpl   $0x100,-0x14(%rbp)
ffff800000100d9c:	75 0c                	jne    ffff800000100daa <cgaputc+0xba>
ffff800000100d9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000100da2:	7e 34                	jle    ffff800000100dd8 <cgaputc+0xe8>
ffff800000100da4:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
ffff800000100da8:	eb 2e                	jmp    ffff800000100dd8 <cgaputc+0xe8>
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
ffff800000100dd8:	81 7d fc 7f 07 00 00 	cmpl   $0x77f,-0x4(%rbp)
ffff800000100ddf:	7e 74                	jle    ffff800000100e55 <cgaputc+0x165>
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
ffff800000100e0d:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000100e14:	80 ff ff 
ffff800000100e17:	ff d0                	call   *%rax
ffff800000100e19:	83 6d fc 50          	subl   $0x50,-0x4(%rbp)
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
ffff800000100e49:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff800000100e50:	80 ff ff 
ffff800000100e53:	ff d0                	call   *%rax
ffff800000100e55:	be 0e 00 00 00       	mov    $0xe,%esi
ffff800000100e5a:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100e5f:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e66:	80 ff ff 
ffff800000100e69:	ff d0                	call   *%rax
ffff800000100e6b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100e6e:	c1 f8 08             	sar    $0x8,%eax
ffff800000100e71:	0f b6 c0             	movzbl %al,%eax
ffff800000100e74:	89 c6                	mov    %eax,%esi
ffff800000100e76:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100e7b:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e82:	80 ff ff 
ffff800000100e85:	ff d0                	call   *%rax
ffff800000100e87:	be 0f 00 00 00       	mov    $0xf,%esi
ffff800000100e8c:	bf d4 03 00 00       	mov    $0x3d4,%edi
ffff800000100e91:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100e98:	80 ff ff 
ffff800000100e9b:	ff d0                	call   *%rax
ffff800000100e9d:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000100ea0:	0f b6 c0             	movzbl %al,%eax
ffff800000100ea3:	89 c6                	mov    %eax,%esi
ffff800000100ea5:	bf d5 03 00 00       	mov    $0x3d5,%edi
ffff800000100eaa:	48 b8 f0 05 10 00 00 	movabs $0xffff8000001005f0,%rax
ffff800000100eb1:	80 ff ff 
ffff800000100eb4:	ff d0                	call   *%rax
ffff800000100eb6:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100ebd:	80 ff ff 
ffff800000100ec0:	48 8b 00             	mov    (%rax),%rax
ffff800000100ec3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100ec6:	48 63 d2             	movslq %edx,%rdx
ffff800000100ec9:	48 01 d2             	add    %rdx,%rdx
ffff800000100ecc:	48 01 d0             	add    %rdx,%rax
ffff800000100ecf:	66 c7 00 20 07       	movw   $0x720,(%rax)
ffff800000100ed4:	90                   	nop
ffff800000100ed5:	c9                   	leave
ffff800000100ed6:	c3                   	ret

ffff800000100ed7 <vidclear>:
ffff800000100ed7:	55                   	push   %rbp
ffff800000100ed8:	48 89 e5             	mov    %rsp,%rbp
ffff800000100edb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100edf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100ee6:	eb 22                	jmp    ffff800000100f0a <vidclear+0x33>
ffff800000100ee8:	48 b8 18 d0 10 00 00 	movabs $0xffff80000010d018,%rax
ffff800000100eef:	80 ff ff 
ffff800000100ef2:	48 8b 00             	mov    (%rax),%rax
ffff800000100ef5:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000100ef8:	48 63 d2             	movslq %edx,%rdx
ffff800000100efb:	48 01 d2             	add    %rdx,%rdx
ffff800000100efe:	48 01 d0             	add    %rdx,%rax
ffff800000100f01:	66 c7 00 20 07       	movw   $0x720,(%rax)
ffff800000100f06:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000100f0a:	81 7d fc cf 07 00 00 	cmpl   $0x7cf,-0x4(%rbp)
ffff800000100f11:	7e d5                	jle    ffff800000100ee8 <vidclear+0x11>
ffff800000100f13:	90                   	nop
ffff800000100f14:	90                   	nop
ffff800000100f15:	c9                   	leave
ffff800000100f16:	c3                   	ret

ffff800000100f17 <vidputc>:
ffff800000100f17:	55                   	push   %rbp
ffff800000100f18:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f1b:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000100f1f:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000100f22:	89 75 f8             	mov    %esi,-0x8(%rbp)
ffff800000100f25:	89 55 f4             	mov    %edx,-0xc(%rbp)
ffff800000100f28:	89 4d f0             	mov    %ecx,-0x10(%rbp)
ffff800000100f2b:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000100f2f:	78 52                	js     ffff800000100f83 <vidputc+0x6c>
ffff800000100f31:	83 7d fc 18          	cmpl   $0x18,-0x4(%rbp)
ffff800000100f35:	7f 4c                	jg     ffff800000100f83 <vidputc+0x6c>
ffff800000100f37:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000100f3b:	78 49                	js     ffff800000100f86 <vidputc+0x6f>
ffff800000100f3d:	83 7d f8 4f          	cmpl   $0x4f,-0x8(%rbp)
ffff800000100f41:	7f 43                	jg     ffff800000100f86 <vidputc+0x6f>
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
ffff800000100f83:	90                   	nop
ffff800000100f84:	eb 01                	jmp    ffff800000100f87 <vidputc+0x70>
ffff800000100f86:	90                   	nop
ffff800000100f87:	c9                   	leave
ffff800000100f88:	c3                   	ret

ffff800000100f89 <vidputs>:
ffff800000100f89:	55                   	push   %rbp
ffff800000100f8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000100f8d:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000100f91:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000100f94:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff800000100f97:	48 89 55 e0          	mov    %rdx,-0x20(%rbp)
ffff800000100f9b:	89 4d dc             	mov    %ecx,-0x24(%rbp)
ffff800000100f9e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000100fa5:	eb 34                	jmp    ffff800000100fdb <vidputs+0x52>
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
ffff800000100ffc:	90                   	nop
ffff800000100ffd:	c9                   	leave
ffff800000100ffe:	c3                   	ret

ffff800000100fff <consputc>:
ffff800000100fff:	55                   	push   %rbp
ffff800000101000:	48 89 e5             	mov    %rsp,%rbp
ffff800000101003:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101007:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010100a:	48 b8 b8 44 11 00 00 	movabs $0xffff8000001144b8,%rax
ffff800000101011:	80 ff ff 
ffff800000101014:	8b 00                	mov    (%rax),%eax
ffff800000101016:	85 c0                	test   %eax,%eax
ffff800000101018:	74 1a                	je     ffff800000101034 <consputc+0x35>
ffff80000010101a:	48 b8 66 06 10 00 00 	movabs $0xffff800000100666,%rax
ffff800000101021:	80 ff ff 
ffff800000101024:	ff d0                	call   *%rax
ffff800000101026:	48 b8 6e 06 10 00 00 	movabs $0xffff80000010066e,%rax
ffff80000010102d:	80 ff ff 
ffff800000101030:	ff d0                	call   *%rax
ffff800000101032:	eb f2                	jmp    ffff800000101026 <consputc+0x27>
ffff800000101034:	81 7d fc 00 01 00 00 	cmpl   $0x100,-0x4(%rbp)
ffff80000010103b:	75 35                	jne    ffff800000101072 <consputc+0x73>
ffff80000010103d:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000101042:	48 b8 65 a1 10 00 00 	movabs $0xffff80000010a165,%rax
ffff800000101049:	80 ff ff 
ffff80000010104c:	ff d0                	call   *%rax
ffff80000010104e:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000101053:	48 b8 65 a1 10 00 00 	movabs $0xffff80000010a165,%rax
ffff80000010105a:	80 ff ff 
ffff80000010105d:	ff d0                	call   *%rax
ffff80000010105f:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000101064:	48 b8 65 a1 10 00 00 	movabs $0xffff80000010a165,%rax
ffff80000010106b:	80 ff ff 
ffff80000010106e:	ff d0                	call   *%rax
ffff800000101070:	eb 11                	jmp    ffff800000101083 <consputc+0x84>
ffff800000101072:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101075:	89 c7                	mov    %eax,%edi
ffff800000101077:	48 b8 65 a1 10 00 00 	movabs $0xffff80000010a165,%rax
ffff80000010107e:	80 ff ff 
ffff800000101081:	ff d0                	call   *%rax
ffff800000101083:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101086:	89 c7                	mov    %eax,%edi
ffff800000101088:	48 b8 f0 0c 10 00 00 	movabs $0xffff800000100cf0,%rax
ffff80000010108f:	80 ff ff 
ffff800000101092:	ff d0                	call   *%rax
ffff800000101094:	90                   	nop
ffff800000101095:	c9                   	leave
ffff800000101096:	c3                   	ret

ffff800000101097 <consoleintr>:
ffff800000101097:	55                   	push   %rbp
ffff800000101098:	48 89 e5             	mov    %rsp,%rbp
ffff80000010109b:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010109f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001010a3:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001010aa:	80 ff ff 
ffff8000001010ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001010b0:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001010b7:	80 ff ff 
ffff8000001010ba:	ff d0                	call   *%rax
ffff8000001010bc:	e9 6d 02 00 00       	jmp    ffff80000010132e <consoleintr+0x297>
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
ffff80000010110a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010110f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000101114:	48 b8 0f 06 10 00 00 	movabs $0xffff80000010060f,%rax
ffff80000010111b:	80 ff ff 
ffff80000010111e:	ff d0                	call   *%rax
ffff800000101120:	e9 09 02 00 00       	jmp    ffff80000010132e <consoleintr+0x297>
ffff800000101125:	48 b8 5b 73 10 00 00 	movabs $0xffff80000010735b,%rax
ffff80000010112c:	80 ff ff 
ffff80000010112f:	ff d0                	call   *%rax
ffff800000101131:	e9 f8 01 00 00       	jmp    ffff80000010132e <consoleintr+0x297>
ffff800000101136:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010113d:	80 ff ff 
ffff800000101140:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101146:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101149:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101150:	80 ff ff 
ffff800000101153:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
ffff800000101159:	bf 00 01 00 00       	mov    $0x100,%edi
ffff80000010115e:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff800000101165:	80 ff ff 
ffff800000101168:	ff d0                	call   *%rax
ffff80000010116a:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101171:	80 ff ff 
ffff800000101174:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff80000010117a:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101181:	80 ff ff 
ffff800000101184:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff80000010118a:	39 c2                	cmp    %eax,%edx
ffff80000010118c:	0f 84 95 01 00 00    	je     ffff800000101327 <consoleintr+0x290>
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
ffff8000001011bb:	3c 0a                	cmp    $0xa,%al
ffff8000001011bd:	0f 85 73 ff ff ff    	jne    ffff800000101136 <consoleintr+0x9f>
ffff8000001011c3:	e9 5f 01 00 00       	jmp    ffff800000101327 <consoleintr+0x290>
ffff8000001011c8:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011cf:	80 ff ff 
ffff8000001011d2:	8b 90 f0 00 00 00    	mov    0xf0(%rax),%edx
ffff8000001011d8:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011df:	80 ff ff 
ffff8000001011e2:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff8000001011e8:	39 c2                	cmp    %eax,%edx
ffff8000001011ea:	0f 84 3a 01 00 00    	je     ffff80000010132a <consoleintr+0x293>
ffff8000001011f0:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001011f7:	80 ff ff 
ffff8000001011fa:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff800000101200:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101203:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010120a:	80 ff ff 
ffff80000010120d:	89 90 f0 00 00 00    	mov    %edx,0xf0(%rax)
ffff800000101213:	bf 00 01 00 00       	mov    $0x100,%edi
ffff800000101218:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff80000010121f:	80 ff ff 
ffff800000101222:	ff d0                	call   *%rax
ffff800000101224:	e9 01 01 00 00       	jmp    ffff80000010132a <consoleintr+0x293>
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
ffff80000010125e:	83 7d fc 0d          	cmpl   $0xd,-0x4(%rbp)
ffff800000101262:	75 07                	jne    ffff80000010126b <consoleintr+0x1d4>
ffff800000101264:	c7 45 fc 0a 00 00 00 	movl   $0xa,-0x4(%rbp)
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
ffff8000001012a8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001012ab:	89 c7                	mov    %eax,%edi
ffff8000001012ad:	48 b8 ff 0f 10 00 00 	movabs $0xffff800000100fff,%rax
ffff8000001012b4:	80 ff ff 
ffff8000001012b7:	ff d0                	call   *%rax
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
ffff8000001012ec:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001012f3:	80 ff ff 
ffff8000001012f6:	8b 80 f0 00 00 00    	mov    0xf0(%rax),%eax
ffff8000001012fc:	48 ba c0 43 11 00 00 	movabs $0xffff8000001143c0,%rdx
ffff800000101303:	80 ff ff 
ffff800000101306:	89 82 ec 00 00 00    	mov    %eax,0xec(%rdx)
ffff80000010130c:	48 b8 a8 44 11 00 00 	movabs $0xffff8000001144a8,%rax
ffff800000101313:	80 ff ff 
ffff800000101316:	48 89 c7             	mov    %rax,%rdi
ffff800000101319:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000101320:	80 ff ff 
ffff800000101323:	ff d0                	call   *%rax
ffff800000101325:	eb 06                	jmp    ffff80000010132d <consoleintr+0x296>
ffff800000101327:	90                   	nop
ffff800000101328:	eb 04                	jmp    ffff80000010132e <consoleintr+0x297>
ffff80000010132a:	90                   	nop
ffff80000010132b:	eb 01                	jmp    ffff80000010132e <consoleintr+0x297>
ffff80000010132d:	90                   	nop
ffff80000010132e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101332:	ff d0                	call   *%rax
ffff800000101334:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000101337:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010133b:	0f 89 80 fd ff ff    	jns    ffff8000001010c1 <consoleintr+0x2a>
ffff800000101341:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101348:	80 ff ff 
ffff80000010134b:	48 89 c7             	mov    %rax,%rdi
ffff80000010134e:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000101355:	80 ff ff 
ffff800000101358:	ff d0                	call   *%rax
ffff80000010135a:	90                   	nop
ffff80000010135b:	c9                   	leave
ffff80000010135c:	c3                   	ret

ffff80000010135d <consoleread>:
ffff80000010135d:	55                   	push   %rbp
ffff80000010135e:	48 89 e5             	mov    %rsp,%rbp
ffff800000101361:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101365:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101369:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010136c:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101370:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffff800000101373:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101377:	48 89 c7             	mov    %rax,%rdi
ffff80000010137a:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000101381:	80 ff ff 
ffff800000101384:	ff d0                	call   *%rax
ffff800000101386:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101389:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010138c:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101393:	80 ff ff 
ffff800000101396:	48 89 c7             	mov    %rax,%rdi
ffff800000101399:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001013a0:	80 ff ff 
ffff8000001013a3:	ff d0                	call   *%rax
ffff8000001013a5:	e9 23 01 00 00       	jmp    ffff8000001014cd <consoleread+0x170>
ffff8000001013aa:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001013b1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001013b5:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001013b8:	85 c0                	test   %eax,%eax
ffff8000001013ba:	74 36                	je     ffff8000001013f2 <consoleread+0x95>
ffff8000001013bc:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001013c3:	80 ff ff 
ffff8000001013c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001013c9:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001013d0:	80 ff ff 
ffff8000001013d3:	ff d0                	call   *%rax
ffff8000001013d5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001013d9:	48 89 c7             	mov    %rax,%rdi
ffff8000001013dc:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001013e3:	80 ff ff 
ffff8000001013e6:	ff d0                	call   *%rax
ffff8000001013e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001013ed:	e9 21 01 00 00       	jmp    ffff800000101513 <consoleread+0x1b6>
ffff8000001013f2:	48 ba c0 43 11 00 00 	movabs $0xffff8000001143c0,%rdx
ffff8000001013f9:	80 ff ff 
ffff8000001013fc:	48 b8 a8 44 11 00 00 	movabs $0xffff8000001144a8,%rax
ffff800000101403:	80 ff ff 
ffff800000101406:	48 89 d6             	mov    %rdx,%rsi
ffff800000101409:	48 89 c7             	mov    %rax,%rdi
ffff80000010140c:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000101413:	80 ff ff 
ffff800000101416:	ff d0                	call   *%rax
ffff800000101418:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010141f:	80 ff ff 
ffff800000101422:	8b 90 e8 00 00 00    	mov    0xe8(%rax),%edx
ffff800000101428:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff80000010142f:	80 ff ff 
ffff800000101432:	8b 80 ec 00 00 00    	mov    0xec(%rax),%eax
ffff800000101438:	39 c2                	cmp    %eax,%edx
ffff80000010143a:	0f 84 6a ff ff ff    	je     ffff8000001013aa <consoleread+0x4d>
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
ffff80000010147f:	83 7d f8 04          	cmpl   $0x4,-0x8(%rbp)
ffff800000101483:	75 2d                	jne    ffff8000001014b2 <consoleread+0x155>
ffff800000101485:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000101488:	3b 45 fc             	cmp    -0x4(%rbp),%eax
ffff80000010148b:	73 4c                	jae    ffff8000001014d9 <consoleread+0x17c>
ffff80000010148d:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff800000101494:	80 ff ff 
ffff800000101497:	8b 80 e8 00 00 00    	mov    0xe8(%rax),%eax
ffff80000010149d:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001014a0:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001014a7:	80 ff ff 
ffff8000001014aa:	89 90 e8 00 00 00    	mov    %edx,0xe8(%rax)
ffff8000001014b0:	eb 27                	jmp    ffff8000001014d9 <consoleread+0x17c>
ffff8000001014b2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001014b6:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001014ba:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff8000001014be:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001014c1:	88 10                	mov    %dl,(%rax)
ffff8000001014c3:	83 6d e0 01          	subl   $0x1,-0x20(%rbp)
ffff8000001014c7:	83 7d f8 0a          	cmpl   $0xa,-0x8(%rbp)
ffff8000001014cb:	74 0f                	je     ffff8000001014dc <consoleread+0x17f>
ffff8000001014cd:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
ffff8000001014d1:	0f 8f 41 ff ff ff    	jg     ffff800000101418 <consoleread+0xbb>
ffff8000001014d7:	eb 04                	jmp    ffff8000001014dd <consoleread+0x180>
ffff8000001014d9:	90                   	nop
ffff8000001014da:	eb 01                	jmp    ffff8000001014dd <consoleread+0x180>
ffff8000001014dc:	90                   	nop
ffff8000001014dd:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001014e4:	80 ff ff 
ffff8000001014e7:	48 89 c7             	mov    %rax,%rdi
ffff8000001014ea:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001014f1:	80 ff ff 
ffff8000001014f4:	ff d0                	call   *%rax
ffff8000001014f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001014fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001014fd:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000101504:	80 ff ff 
ffff800000101507:	ff d0                	call   *%rax
ffff800000101509:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff80000010150c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010150f:	29 c2                	sub    %eax,%edx
ffff800000101511:	89 d0                	mov    %edx,%eax
ffff800000101513:	c9                   	leave
ffff800000101514:	c3                   	ret

ffff800000101515 <consolewrite>:
ffff800000101515:	55                   	push   %rbp
ffff800000101516:	48 89 e5             	mov    %rsp,%rbp
ffff800000101519:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010151d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101521:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000101524:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000101528:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffff80000010152b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010152f:	48 89 c7             	mov    %rax,%rdi
ffff800000101532:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000101539:	80 ff ff 
ffff80000010153c:	ff d0                	call   *%rax
ffff80000010153e:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101545:	80 ff ff 
ffff800000101548:	48 89 c7             	mov    %rax,%rdi
ffff80000010154b:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000101552:	80 ff ff 
ffff800000101555:	ff d0                	call   *%rax
ffff800000101557:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010155e:	eb 28                	jmp    ffff800000101588 <consolewrite+0x73>
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
ffff800000101584:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000101588:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010158b:	3b 45 e0             	cmp    -0x20(%rbp),%eax
ffff80000010158e:	7c d0                	jl     ffff800000101560 <consolewrite+0x4b>
ffff800000101590:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101597:	80 ff ff 
ffff80000010159a:	48 89 c7             	mov    %rax,%rdi
ffff80000010159d:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001015a4:	80 ff ff 
ffff8000001015a7:	ff d0                	call   *%rax
ffff8000001015a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001015ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001015b0:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001015b7:	80 ff ff 
ffff8000001015ba:	ff d0                	call   *%rax
ffff8000001015bc:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff8000001015bf:	c9                   	leave
ffff8000001015c0:	c3                   	ret

ffff8000001015c1 <consoleinit>:
ffff8000001015c1:	55                   	push   %rbp
ffff8000001015c2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001015c5:	48 ba cb c5 10 00 00 	movabs $0xffff80000010c5cb,%rdx
ffff8000001015cc:	80 ff ff 
ffff8000001015cf:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff8000001015d6:	80 ff ff 
ffff8000001015d9:	48 89 d6             	mov    %rdx,%rsi
ffff8000001015dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001015df:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff8000001015e6:	80 ff ff 
ffff8000001015e9:	ff d0                	call   *%rax
ffff8000001015eb:	48 ba d3 c5 10 00 00 	movabs $0xffff80000010c5d3,%rdx
ffff8000001015f2:	80 ff ff 
ffff8000001015f5:	48 b8 c0 43 11 00 00 	movabs $0xffff8000001143c0,%rax
ffff8000001015fc:	80 ff ff 
ffff8000001015ff:	48 89 d6             	mov    %rdx,%rsi
ffff800000101602:	48 89 c7             	mov    %rax,%rdi
ffff800000101605:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff80000010160c:	80 ff ff 
ffff80000010160f:	ff d0                	call   *%rax
ffff800000101611:	48 b8 40 45 11 00 00 	movabs $0xffff800000114540,%rax
ffff800000101618:	80 ff ff 
ffff80000010161b:	48 b9 15 15 10 00 00 	movabs $0xffff800000101515,%rcx
ffff800000101622:	80 ff ff 
ffff800000101625:	48 89 48 18          	mov    %rcx,0x18(%rax)
ffff800000101629:	48 b8 40 45 11 00 00 	movabs $0xffff800000114540,%rax
ffff800000101630:	80 ff ff 
ffff800000101633:	48 b9 5d 13 10 00 00 	movabs $0xffff80000010135d,%rcx
ffff80000010163a:	80 ff ff 
ffff80000010163d:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff800000101641:	48 b8 c0 44 11 00 00 	movabs $0xffff8000001144c0,%rax
ffff800000101648:	80 ff ff 
ffff80000010164b:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
ffff800000101652:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000101657:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010165c:	48 b8 96 40 10 00 00 	movabs $0xffff800000104096,%rax
ffff800000101663:	80 ff ff 
ffff800000101666:	ff d0                	call   *%rax
ffff800000101668:	90                   	nop
ffff800000101669:	5d                   	pop    %rbp
ffff80000010166a:	c3                   	ret

ffff80000010166b <exec>:
ffff80000010166b:	55                   	push   %rbp
ffff80000010166c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010166f:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
ffff800000101676:	48 89 bd 08 fe ff ff 	mov    %rdi,-0x1f8(%rbp)
ffff80000010167d:	48 89 b5 00 fe ff ff 	mov    %rsi,-0x200(%rbp)
ffff800000101684:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010168b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010168f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000101693:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
ffff800000101697:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff80000010169e:	80 ff ff 
ffff8000001016a1:	ff d0                	call   *%rax
ffff8000001016a3:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff8000001016aa:	48 89 c7             	mov    %rax,%rdi
ffff8000001016ad:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff8000001016b4:	80 ff ff 
ffff8000001016b7:	ff d0                	call   *%rax
ffff8000001016b9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
ffff8000001016bd:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001016c2:	75 16                	jne    ffff8000001016da <exec+0x6f>
ffff8000001016c4:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001016cb:	80 ff ff 
ffff8000001016ce:	ff d0                	call   *%rax
ffff8000001016d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001016d5:	e9 69 05 00 00       	jmp    ffff800000101c43 <exec+0x5d8>
ffff8000001016da:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001016de:	48 89 c7             	mov    %rax,%rdi
ffff8000001016e1:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001016e8:	80 ff ff 
ffff8000001016eb:	ff d0                	call   *%rax
ffff8000001016ed:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
ffff8000001016f4:	00 
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
ffff800000101722:	8b 85 50 fe ff ff    	mov    -0x1b0(%rbp),%eax
ffff800000101728:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
ffff80000010172d:	0f 85 a9 04 00 00    	jne    ffff800000101bdc <exec+0x571>
ffff800000101733:	48 b8 2f b2 10 00 00 	movabs $0xffff80000010b22f,%rax
ffff80000010173a:	80 ff ff 
ffff80000010173d:	ff d0                	call   *%rax
ffff80000010173f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
ffff800000101743:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101748:	0f 84 91 04 00 00    	je     ffff800000101bdf <exec+0x574>
ffff80000010174e:	48 c7 45 d8 00 10 00 	movq   $0x1000,-0x28(%rbp)
ffff800000101755:	00 
ffff800000101756:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff80000010175d:	48 8b 85 70 fe ff ff 	mov    -0x190(%rbp),%rax
ffff800000101764:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff800000101767:	e9 0f 01 00 00       	jmp    ffff80000010187b <exec+0x210>
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
ffff800000101797:	8b 85 10 fe ff ff    	mov    -0x1f0(%rbp),%eax
ffff80000010179d:	83 f8 01             	cmp    $0x1,%eax
ffff8000001017a0:	0f 85 c7 00 00 00    	jne    ffff80000010186d <exec+0x202>
ffff8000001017a6:	48 8b 95 38 fe ff ff 	mov    -0x1c8(%rbp),%rdx
ffff8000001017ad:	48 8b 85 30 fe ff ff 	mov    -0x1d0(%rbp),%rax
ffff8000001017b4:	48 39 c2             	cmp    %rax,%rdx
ffff8000001017b7:	0f 82 28 04 00 00    	jb     ffff800000101be5 <exec+0x57a>
ffff8000001017bd:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff8000001017c4:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001017cb:	48 01 c2             	add    %rax,%rdx
ffff8000001017ce:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff8000001017d5:	48 39 c2             	cmp    %rax,%rdx
ffff8000001017d8:	0f 82 0a 04 00 00    	jb     ffff800000101be8 <exec+0x57d>
ffff8000001017de:	48 8b 95 20 fe ff ff 	mov    -0x1e0(%rbp),%rdx
ffff8000001017e5:	48 8b 85 38 fe ff ff 	mov    -0x1c8(%rbp),%rax
ffff8000001017ec:	48 01 c2             	add    %rax,%rdx
ffff8000001017ef:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001017f3:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001017f7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001017fa:	48 89 c7             	mov    %rax,%rdi
ffff8000001017fd:	48 b8 86 b9 10 00 00 	movabs $0xffff80000010b986,%rax
ffff800000101804:	80 ff ff 
ffff800000101807:	ff d0                	call   *%rax
ffff800000101809:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010180d:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000101812:	0f 84 d3 03 00 00    	je     ffff800000101beb <exec+0x580>
ffff800000101818:	48 8b 85 20 fe ff ff 	mov    -0x1e0(%rbp),%rax
ffff80000010181f:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000101824:	48 85 c0             	test   %rax,%rax
ffff800000101827:	0f 85 c1 03 00 00    	jne    ffff800000101bee <exec+0x583>
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
ffff800000101857:	48 b8 5e b8 10 00 00 	movabs $0xffff80000010b85e,%rax
ffff80000010185e:	80 ff ff 
ffff800000101861:	ff d0                	call   *%rax
ffff800000101863:	85 c0                	test   %eax,%eax
ffff800000101865:	0f 88 86 03 00 00    	js     ffff800000101bf1 <exec+0x586>
ffff80000010186b:	eb 01                	jmp    ffff80000010186e <exec+0x203>
ffff80000010186d:	90                   	nop
ffff80000010186e:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000101872:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000101875:	83 c0 38             	add    $0x38,%eax
ffff800000101878:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff80000010187b:	0f b7 85 88 fe ff ff 	movzwl -0x178(%rbp),%eax
ffff800000101882:	0f b7 c0             	movzwl %ax,%eax
ffff800000101885:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff800000101888:	0f 8c de fe ff ff    	jl     ffff80000010176c <exec+0x101>
ffff80000010188e:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101892:	48 89 c7             	mov    %rax,%rdi
ffff800000101895:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010189c:	80 ff ff 
ffff80000010189f:	ff d0                	call   *%rax
ffff8000001018a1:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001018a8:	80 ff ff 
ffff8000001018ab:	ff d0                	call   *%rax
ffff8000001018ad:	48 c7 45 c8 00 00 00 	movq   $0x0,-0x38(%rbp)
ffff8000001018b4:	00 
ffff8000001018b5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001018b9:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff8000001018bf:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff8000001018c5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001018c9:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001018cd:	48 8d 90 00 20 00 00 	lea    0x2000(%rax),%rdx
ffff8000001018d4:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff8000001018d8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff8000001018dc:	48 89 ce             	mov    %rcx,%rsi
ffff8000001018df:	48 89 c7             	mov    %rax,%rdi
ffff8000001018e2:	48 b8 86 b9 10 00 00 	movabs $0xffff80000010b986,%rax
ffff8000001018e9:	80 ff ff 
ffff8000001018ec:	ff d0                	call   *%rax
ffff8000001018ee:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff8000001018f2:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff8000001018f7:	0f 84 f7 02 00 00    	je     ffff800000101bf4 <exec+0x589>
ffff8000001018fd:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101901:	48 2d 00 20 00 00    	sub    $0x2000,%rax
ffff800000101907:	48 89 c2             	mov    %rax,%rdx
ffff80000010190a:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010190e:	48 89 d6             	mov    %rdx,%rsi
ffff800000101911:	48 89 c7             	mov    %rax,%rdi
ffff800000101914:	48 b8 fa bd 10 00 00 	movabs $0xffff80000010bdfa,%rax
ffff80000010191b:	80 ff ff 
ffff80000010191e:	ff d0                	call   *%rax
ffff800000101920:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101924:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff800000101928:	48 c7 45 e0 00 00 00 	movq   $0x0,-0x20(%rbp)
ffff80000010192f:	00 
ffff800000101930:	e9 c9 00 00 00       	jmp    ffff8000001019fe <exec+0x393>
ffff800000101935:	48 83 7d e0 1f       	cmpq   $0x1f,-0x20(%rbp)
ffff80000010193a:	0f 87 b7 02 00 00    	ja     ffff800000101bf7 <exec+0x58c>
ffff800000101940:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101944:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010194b:	00 
ffff80000010194c:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101953:	48 01 d0             	add    %rdx,%rax
ffff800000101956:	48 8b 00             	mov    (%rax),%rax
ffff800000101959:	48 89 c7             	mov    %rax,%rdi
ffff80000010195c:	48 b8 89 7d 10 00 00 	movabs $0xffff800000107d89,%rax
ffff800000101963:	80 ff ff 
ffff800000101966:	ff d0                	call   *%rax
ffff800000101968:	83 c0 01             	add    $0x1,%eax
ffff80000010196b:	48 98                	cltq
ffff80000010196d:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101971:	48 29 c2             	sub    %rax,%rdx
ffff800000101974:	48 89 d0             	mov    %rdx,%rax
ffff800000101977:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
ffff80000010197b:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010197f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101983:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010198a:	00 
ffff80000010198b:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101992:	48 01 d0             	add    %rdx,%rax
ffff800000101995:	48 8b 00             	mov    (%rax),%rax
ffff800000101998:	48 89 c7             	mov    %rax,%rdi
ffff80000010199b:	48 b8 89 7d 10 00 00 	movabs $0xffff800000107d89,%rax
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
ffff8000001019d1:	48 b8 6c c0 10 00 00 	movabs $0xffff80000010c06c,%rax
ffff8000001019d8:	80 ff ff 
ffff8000001019db:	ff d0                	call   *%rax
ffff8000001019dd:	85 c0                	test   %eax,%eax
ffff8000001019df:	0f 88 15 02 00 00    	js     ffff800000101bfa <exec+0x58f>
ffff8000001019e5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001019e9:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff8000001019ed:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001019f1:	48 89 84 d5 90 fe ff 	mov    %rax,-0x170(%rbp,%rdx,8)
ffff8000001019f8:	ff 
ffff8000001019f9:	48 83 45 e0 01       	addq   $0x1,-0x20(%rbp)
ffff8000001019fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a02:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff800000101a09:	00 
ffff800000101a0a:	48 8b 85 00 fe ff ff 	mov    -0x200(%rbp),%rax
ffff800000101a11:	48 01 d0             	add    %rdx,%rax
ffff800000101a14:	48 8b 00             	mov    (%rax),%rax
ffff800000101a17:	48 85 c0             	test   %rax,%rax
ffff800000101a1a:	0f 85 15 ff ff ff    	jne    ffff800000101935 <exec+0x2ca>
ffff800000101a20:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a24:	48 83 c0 01          	add    $0x1,%rax
ffff800000101a28:	48 c7 84 c5 90 fe ff 	movq   $0x0,-0x170(%rbp,%rax,8)
ffff800000101a2f:	ff 00 00 00 00 
ffff800000101a34:	48 c7 85 90 fe ff ff 	movq   $0xffffffffffffffff,-0x170(%rbp)
ffff800000101a3b:	ff ff ff ff 
ffff800000101a3f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101a46:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101a4a:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101a4e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000101a52:	48 89 50 30          	mov    %rdx,0x30(%rax)
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
ffff800000101a80:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a84:	48 83 c0 02          	add    $0x2,%rax
ffff800000101a88:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000101a8c:	48 29 45 d0          	sub    %rax,-0x30(%rbp)
ffff800000101a90:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000101a94:	48 83 c0 02          	add    $0x2,%rax
ffff800000101a98:	48 8d 0c c5 00 00 00 	lea    0x0(,%rax,8),%rcx
ffff800000101a9f:	00 
ffff800000101aa0:	48 8d 95 90 fe ff ff 	lea    -0x170(%rbp),%rdx
ffff800000101aa7:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
ffff800000101aab:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101aaf:	48 89 c7             	mov    %rax,%rdi
ffff800000101ab2:	48 b8 6c c0 10 00 00 	movabs $0xffff80000010c06c,%rax
ffff800000101ab9:	80 ff ff 
ffff800000101abc:	ff d0                	call   *%rax
ffff800000101abe:	85 c0                	test   %eax,%eax
ffff800000101ac0:	0f 88 37 01 00 00    	js     ffff800000101bfd <exec+0x592>
ffff800000101ac6:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
ffff800000101acd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101ad1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ad5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000101ad9:	eb 1c                	jmp    ffff800000101af7 <exec+0x48c>
ffff800000101adb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101adf:	0f b6 00             	movzbl (%rax),%eax
ffff800000101ae2:	3c 2f                	cmp    $0x2f,%al
ffff800000101ae4:	75 0c                	jne    ffff800000101af2 <exec+0x487>
ffff800000101ae6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101aea:	48 83 c0 01          	add    $0x1,%rax
ffff800000101aee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000101af2:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000101af7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101afb:	0f b6 00             	movzbl (%rax),%eax
ffff800000101afe:	84 c0                	test   %al,%al
ffff800000101b00:	75 d9                	jne    ffff800000101adb <exec+0x470>
ffff800000101b02:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b09:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b0d:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000101b14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000101b18:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000101b1d:	48 89 c6             	mov    %rax,%rsi
ffff800000101b20:	48 89 cf             	mov    %rcx,%rdi
ffff800000101b23:	48 b8 26 7d 10 00 00 	movabs $0xffff800000107d26,%rax
ffff800000101b2a:	80 ff ff 
ffff800000101b2d:	ff d0                	call   *%rax
ffff800000101b2f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b36:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b3a:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
ffff800000101b3e:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff800000101b42:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b49:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b4d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000101b51:	48 89 10             	mov    %rdx,(%rax)
ffff800000101b54:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b5b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b5f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101b63:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101b6a:	48 89 90 88 00 00 00 	mov    %rdx,0x88(%rax)
ffff800000101b71:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b78:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b7c:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101b80:	48 8b 95 68 fe ff ff 	mov    -0x198(%rbp),%rdx
ffff800000101b87:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000101b8b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101b92:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101b96:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000101b9a:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff800000101b9e:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
ffff800000101ba5:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000101bac:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000101bb0:	48 89 c7             	mov    %rax,%rdi
ffff800000101bb3:	48 b8 8d b3 10 00 00 	movabs $0xffff80000010b38d,%rax
ffff800000101bba:	80 ff ff 
ffff800000101bbd:	ff d0                	call   *%rax
ffff800000101bbf:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101bc3:	48 89 c7             	mov    %rax,%rdi
ffff800000101bc6:	48 b8 c3 bb 10 00 00 	movabs $0xffff80000010bbc3,%rax
ffff800000101bcd:	80 ff ff 
ffff800000101bd0:	ff d0                	call   *%rax
ffff800000101bd2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101bd7:	eb 6a                	jmp    ffff800000101c43 <exec+0x5d8>
ffff800000101bd9:	90                   	nop
ffff800000101bda:	eb 22                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bdc:	90                   	nop
ffff800000101bdd:	eb 1f                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bdf:	90                   	nop
ffff800000101be0:	eb 1c                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101be2:	90                   	nop
ffff800000101be3:	eb 19                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101be5:	90                   	nop
ffff800000101be6:	eb 16                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101be8:	90                   	nop
ffff800000101be9:	eb 13                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101beb:	90                   	nop
ffff800000101bec:	eb 10                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bee:	90                   	nop
ffff800000101bef:	eb 0d                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bf1:	90                   	nop
ffff800000101bf2:	eb 0a                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bf4:	90                   	nop
ffff800000101bf5:	eb 07                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bf7:	90                   	nop
ffff800000101bf8:	eb 04                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bfa:	90                   	nop
ffff800000101bfb:	eb 01                	jmp    ffff800000101bfe <exec+0x593>
ffff800000101bfd:	90                   	nop
ffff800000101bfe:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff800000101c03:	74 13                	je     ffff800000101c18 <exec+0x5ad>
ffff800000101c05:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff800000101c09:	48 89 c7             	mov    %rax,%rdi
ffff800000101c0c:	48 b8 c3 bb 10 00 00 	movabs $0xffff80000010bbc3,%rax
ffff800000101c13:	80 ff ff 
ffff800000101c16:	ff d0                	call   *%rax
ffff800000101c18:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff800000101c1d:	74 1f                	je     ffff800000101c3e <exec+0x5d3>
ffff800000101c1f:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000101c23:	48 89 c7             	mov    %rax,%rdi
ffff800000101c26:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000101c2d:	80 ff ff 
ffff800000101c30:	ff d0                	call   *%rax
ffff800000101c32:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000101c39:	80 ff ff 
ffff800000101c3c:	ff d0                	call   *%rax
ffff800000101c3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101c43:	c9                   	leave
ffff800000101c44:	c3                   	ret

ffff800000101c45 <fileinit>:
ffff800000101c45:	55                   	push   %rbp
ffff800000101c46:	48 89 e5             	mov    %rsp,%rbp
ffff800000101c49:	48 ba d9 c5 10 00 00 	movabs $0xffff80000010c5d9,%rdx
ffff800000101c50:	80 ff ff 
ffff800000101c53:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101c5a:	80 ff ff 
ffff800000101c5d:	48 89 d6             	mov    %rdx,%rsi
ffff800000101c60:	48 89 c7             	mov    %rax,%rdi
ffff800000101c63:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000101c6a:	80 ff ff 
ffff800000101c6d:	ff d0                	call   *%rax
ffff800000101c6f:	90                   	nop
ffff800000101c70:	5d                   	pop    %rbp
ffff800000101c71:	c3                   	ret

ffff800000101c72 <filealloc>:
ffff800000101c72:	55                   	push   %rbp
ffff800000101c73:	48 89 e5             	mov    %rsp,%rbp
ffff800000101c76:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101c7a:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101c81:	80 ff ff 
ffff800000101c84:	48 89 c7             	mov    %rax,%rdi
ffff800000101c87:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000101c8e:	80 ff ff 
ffff800000101c91:	ff d0                	call   *%rax
ffff800000101c93:	48 b8 48 46 11 00 00 	movabs $0xffff800000114648,%rax
ffff800000101c9a:	80 ff ff 
ffff800000101c9d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000101ca1:	eb 3a                	jmp    ffff800000101cdd <filealloc+0x6b>
ffff800000101ca3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ca7:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101caa:	85 c0                	test   %eax,%eax
ffff800000101cac:	75 2a                	jne    ffff800000101cd8 <filealloc+0x66>
ffff800000101cae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101cb2:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%rax)
ffff800000101cb9:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101cc0:	80 ff ff 
ffff800000101cc3:	48 89 c7             	mov    %rax,%rdi
ffff800000101cc6:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000101ccd:	80 ff ff 
ffff800000101cd0:	ff d0                	call   *%rax
ffff800000101cd2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101cd6:	eb 33                	jmp    ffff800000101d0b <filealloc+0x99>
ffff800000101cd8:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff800000101cdd:	48 b8 e8 55 11 00 00 	movabs $0xffff8000001155e8,%rax
ffff800000101ce4:	80 ff ff 
ffff800000101ce7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000101ceb:	72 b6                	jb     ffff800000101ca3 <filealloc+0x31>
ffff800000101ced:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101cf4:	80 ff ff 
ffff800000101cf7:	48 89 c7             	mov    %rax,%rdi
ffff800000101cfa:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000101d01:	80 ff ff 
ffff800000101d04:	ff d0                	call   *%rax
ffff800000101d06:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101d0b:	c9                   	leave
ffff800000101d0c:	c3                   	ret

ffff800000101d0d <filedup>:
ffff800000101d0d:	55                   	push   %rbp
ffff800000101d0e:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d11:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101d15:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101d19:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d20:	80 ff ff 
ffff800000101d23:	48 89 c7             	mov    %rax,%rdi
ffff800000101d26:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000101d2d:	80 ff ff 
ffff800000101d30:	ff d0                	call   *%rax
ffff800000101d32:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d36:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d39:	85 c0                	test   %eax,%eax
ffff800000101d3b:	7f 19                	jg     ffff800000101d56 <filedup+0x49>
ffff800000101d3d:	48 b8 e0 c5 10 00 00 	movabs $0xffff80000010c5e0,%rax
ffff800000101d44:	80 ff ff 
ffff800000101d47:	48 89 c7             	mov    %rax,%rdi
ffff800000101d4a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101d51:	80 ff ff 
ffff800000101d54:	ff d0                	call   *%rax
ffff800000101d56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d5a:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101d5d:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000101d60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d64:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101d67:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d6e:	80 ff ff 
ffff800000101d71:	48 89 c7             	mov    %rax,%rdi
ffff800000101d74:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000101d7b:	80 ff ff 
ffff800000101d7e:	ff d0                	call   *%rax
ffff800000101d80:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101d84:	c9                   	leave
ffff800000101d85:	c3                   	ret

ffff800000101d86 <fileclose>:
ffff800000101d86:	55                   	push   %rbp
ffff800000101d87:	48 89 e5             	mov    %rsp,%rbp
ffff800000101d8a:	53                   	push   %rbx
ffff800000101d8b:	48 83 ec 48          	sub    $0x48,%rsp
ffff800000101d8f:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
ffff800000101d93:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101d9a:	80 ff ff 
ffff800000101d9d:	48 89 c7             	mov    %rax,%rdi
ffff800000101da0:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000101da7:	80 ff ff 
ffff800000101daa:	ff d0                	call   *%rax
ffff800000101dac:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101db0:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101db3:	85 c0                	test   %eax,%eax
ffff800000101db5:	7f 19                	jg     ffff800000101dd0 <fileclose+0x4a>
ffff800000101db7:	48 b8 e8 c5 10 00 00 	movabs $0xffff80000010c5e8,%rax
ffff800000101dbe:	80 ff ff 
ffff800000101dc1:	48 89 c7             	mov    %rax,%rdi
ffff800000101dc4:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000101dcb:	80 ff ff 
ffff800000101dce:	ff d0                	call   *%rax
ffff800000101dd0:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101dd4:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101dd7:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000101dda:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101dde:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000101de1:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101de5:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000101de8:	85 c0                	test   %eax,%eax
ffff800000101dea:	7e 1e                	jle    ffff800000101e0a <fileclose+0x84>
ffff800000101dec:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101df3:	80 ff ff 
ffff800000101df6:	48 89 c7             	mov    %rax,%rdi
ffff800000101df9:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000101e00:	80 ff ff 
ffff800000101e03:	ff d0                	call   *%rax
ffff800000101e05:	e9 b2 00 00 00       	jmp    ffff800000101ebc <fileclose+0x136>
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
ffff800000101e35:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e39:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
ffff800000101e40:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000101e44:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
ffff800000101e4a:	48 b8 e0 45 11 00 00 	movabs $0xffff8000001145e0,%rax
ffff800000101e51:	80 ff ff 
ffff800000101e54:	48 89 c7             	mov    %rax,%rdi
ffff800000101e57:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000101e5e:	80 ff ff 
ffff800000101e61:	ff d0                	call   *%rax
ffff800000101e63:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101e66:	83 f8 01             	cmp    $0x1,%eax
ffff800000101e69:	75 1e                	jne    ffff800000101e89 <fileclose+0x103>
ffff800000101e6b:	0f b6 45 c9          	movzbl -0x37(%rbp),%eax
ffff800000101e6f:	0f be d0             	movsbl %al,%edx
ffff800000101e72:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000101e76:	89 d6                	mov    %edx,%esi
ffff800000101e78:	48 89 c7             	mov    %rax,%rdi
ffff800000101e7b:	48 b8 cd 5f 10 00 00 	movabs $0xffff800000105fcd,%rax
ffff800000101e82:	80 ff ff 
ffff800000101e85:	ff d0                	call   *%rax
ffff800000101e87:	eb 33                	jmp    ffff800000101ebc <fileclose+0x136>
ffff800000101e89:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff800000101e8c:	83 f8 02             	cmp    $0x2,%eax
ffff800000101e8f:	75 2b                	jne    ffff800000101ebc <fileclose+0x136>
ffff800000101e91:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff800000101e98:	80 ff ff 
ffff800000101e9b:	ff d0                	call   *%rax
ffff800000101e9d:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000101ea1:	48 89 c7             	mov    %rax,%rdi
ffff800000101ea4:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000101eab:	80 ff ff 
ffff800000101eae:	ff d0                	call   *%rax
ffff800000101eb0:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000101eb7:	80 ff ff 
ffff800000101eba:	ff d0                	call   *%rax
ffff800000101ebc:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000101ec0:	c9                   	leave
ffff800000101ec1:	c3                   	ret

ffff800000101ec2 <filestat>:
ffff800000101ec2:	55                   	push   %rbp
ffff800000101ec3:	48 89 e5             	mov    %rsp,%rbp
ffff800000101ec6:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000101eca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000101ece:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000101ed2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ed6:	8b 00                	mov    (%rax),%eax
ffff800000101ed8:	83 f8 02             	cmp    $0x2,%eax
ffff800000101edb:	75 53                	jne    ffff800000101f30 <filestat+0x6e>
ffff800000101edd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ee1:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ee5:	48 89 c7             	mov    %rax,%rdi
ffff800000101ee8:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000101eef:	80 ff ff 
ffff800000101ef2:	ff d0                	call   *%rax
ffff800000101ef4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101ef8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101efc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000101f00:	48 89 d6             	mov    %rdx,%rsi
ffff800000101f03:	48 89 c7             	mov    %rax,%rdi
ffff800000101f06:	48 b8 b7 2f 10 00 00 	movabs $0xffff800000102fb7,%rax
ffff800000101f0d:	80 ff ff 
ffff800000101f10:	ff d0                	call   *%rax
ffff800000101f12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000101f16:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101f1a:	48 89 c7             	mov    %rax,%rdi
ffff800000101f1d:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000101f24:	80 ff ff 
ffff800000101f27:	ff d0                	call   *%rax
ffff800000101f29:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000101f2e:	eb 05                	jmp    ffff800000101f35 <filestat+0x73>
ffff800000101f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101f35:	c9                   	leave
ffff800000101f36:	c3                   	ret

ffff800000101f37 <fileread>:
ffff800000101f37:	55                   	push   %rbp
ffff800000101f38:	48 89 e5             	mov    %rsp,%rbp
ffff800000101f3b:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000101f3f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000101f43:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000101f47:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000101f4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f4e:	0f b6 40 08          	movzbl 0x8(%rax),%eax
ffff800000101f52:	84 c0                	test   %al,%al
ffff800000101f54:	75 0a                	jne    ffff800000101f60 <fileread+0x29>
ffff800000101f56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000101f5b:	e9 c9 00 00 00       	jmp    ffff800000102029 <fileread+0xf2>
ffff800000101f60:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f64:	8b 00                	mov    (%rax),%eax
ffff800000101f66:	83 f8 01             	cmp    $0x1,%eax
ffff800000101f69:	75 26                	jne    ffff800000101f91 <fileread+0x5a>
ffff800000101f6b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f6f:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000101f73:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000101f76:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff800000101f7a:	48 89 ce             	mov    %rcx,%rsi
ffff800000101f7d:	48 89 c7             	mov    %rax,%rdi
ffff800000101f80:	48 b8 e0 61 10 00 00 	movabs $0xffff8000001061e0,%rax
ffff800000101f87:	80 ff ff 
ffff800000101f8a:	ff d0                	call   *%rax
ffff800000101f8c:	e9 98 00 00 00       	jmp    ffff800000102029 <fileread+0xf2>
ffff800000101f91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101f95:	8b 00                	mov    (%rax),%eax
ffff800000101f97:	83 f8 02             	cmp    $0x2,%eax
ffff800000101f9a:	75 74                	jne    ffff800000102010 <fileread+0xd9>
ffff800000101f9c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fa0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101fa4:	48 89 c7             	mov    %rax,%rdi
ffff800000101fa7:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000101fae:	80 ff ff 
ffff800000101fb1:	ff d0                	call   *%rax
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
ffff800000101fe1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101fe5:	8b 50 20             	mov    0x20(%rax),%edx
ffff800000101fe8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000101feb:	01 c2                	add    %eax,%edx
ffff800000101fed:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ff1:	89 50 20             	mov    %edx,0x20(%rax)
ffff800000101ff4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000101ff8:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000101ffc:	48 89 c7             	mov    %rax,%rdi
ffff800000101fff:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000102006:	80 ff ff 
ffff800000102009:	ff d0                	call   *%rax
ffff80000010200b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010200e:	eb 19                	jmp    ffff800000102029 <fileread+0xf2>
ffff800000102010:	48 b8 f2 c5 10 00 00 	movabs $0xffff80000010c5f2,%rax
ffff800000102017:	80 ff ff 
ffff80000010201a:	48 89 c7             	mov    %rax,%rdi
ffff80000010201d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102024:	80 ff ff 
ffff800000102027:	ff d0                	call   *%rax
ffff800000102029:	c9                   	leave
ffff80000010202a:	c3                   	ret

ffff80000010202b <filewrite>:
ffff80000010202b:	55                   	push   %rbp
ffff80000010202c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010202f:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102033:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000102037:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010203b:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff80000010203e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102042:	0f b6 40 09          	movzbl 0x9(%rax),%eax
ffff800000102046:	84 c0                	test   %al,%al
ffff800000102048:	75 0a                	jne    ffff800000102054 <filewrite+0x29>
ffff80000010204a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010204f:	e9 63 01 00 00       	jmp    ffff8000001021b7 <filewrite+0x18c>
ffff800000102054:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102058:	8b 00                	mov    (%rax),%eax
ffff80000010205a:	83 f8 01             	cmp    $0x1,%eax
ffff80000010205d:	75 26                	jne    ffff800000102085 <filewrite+0x5a>
ffff80000010205f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102063:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000102067:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010206a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010206e:	48 89 ce             	mov    %rcx,%rsi
ffff800000102071:	48 89 c7             	mov    %rax,%rdi
ffff800000102074:	48 b8 a0 60 10 00 00 	movabs $0xffff8000001060a0,%rax
ffff80000010207b:	80 ff ff 
ffff80000010207e:	ff d0                	call   *%rax
ffff800000102080:	e9 32 01 00 00       	jmp    ffff8000001021b7 <filewrite+0x18c>
ffff800000102085:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102089:	8b 00                	mov    (%rax),%eax
ffff80000010208b:	83 f8 02             	cmp    $0x2,%eax
ffff80000010208e:	0f 85 0a 01 00 00    	jne    ffff80000010219e <filewrite+0x173>
ffff800000102094:	c7 45 f4 00 1a 00 00 	movl   $0x1a00,-0xc(%rbp)
ffff80000010209b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001020a2:	e9 d4 00 00 00       	jmp    ffff80000010217b <filewrite+0x150>
ffff8000001020a7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001020aa:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff8000001020ad:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff8000001020b0:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001020b3:	3b 45 f4             	cmp    -0xc(%rbp),%eax
ffff8000001020b6:	7e 06                	jle    ffff8000001020be <filewrite+0x93>
ffff8000001020b8:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff8000001020bb:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff8000001020be:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff8000001020c5:	80 ff ff 
ffff8000001020c8:	ff d0                	call   *%rax
ffff8000001020ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001020ce:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff8000001020d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001020d5:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001020dc:	80 ff ff 
ffff8000001020df:	ff d0                	call   *%rax
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
ffff800000102118:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010211c:	8b 50 20             	mov    0x20(%rax),%edx
ffff80000010211f:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102122:	01 c2                	add    %eax,%edx
ffff800000102124:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102128:	89 50 20             	mov    %edx,0x20(%rax)
ffff80000010212b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010212f:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000102133:	48 89 c7             	mov    %rax,%rdi
ffff800000102136:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff80000010213d:	80 ff ff 
ffff800000102140:	ff d0                	call   *%rax
ffff800000102142:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000102149:	80 ff ff 
ffff80000010214c:	ff d0                	call   *%rax
ffff80000010214e:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
ffff800000102152:	78 35                	js     ffff800000102189 <filewrite+0x15e>
ffff800000102154:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102157:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff80000010215a:	74 19                	je     ffff800000102175 <filewrite+0x14a>
ffff80000010215c:	48 b8 fb c5 10 00 00 	movabs $0xffff80000010c5fb,%rax
ffff800000102163:	80 ff ff 
ffff800000102166:	48 89 c7             	mov    %rax,%rdi
ffff800000102169:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102170:	80 ff ff 
ffff800000102173:	ff d0                	call   *%rax
ffff800000102175:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000102178:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff80000010217b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010217e:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102181:	0f 8c 20 ff ff ff    	jl     ffff8000001020a7 <filewrite+0x7c>
ffff800000102187:	eb 01                	jmp    ffff80000010218a <filewrite+0x15f>
ffff800000102189:	90                   	nop
ffff80000010218a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010218d:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff800000102190:	75 05                	jne    ffff800000102197 <filewrite+0x16c>
ffff800000102192:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102195:	eb 20                	jmp    ffff8000001021b7 <filewrite+0x18c>
ffff800000102197:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010219c:	eb 19                	jmp    ffff8000001021b7 <filewrite+0x18c>
ffff80000010219e:	48 b8 0b c6 10 00 00 	movabs $0xffff80000010c60b,%rax
ffff8000001021a5:	80 ff ff 
ffff8000001021a8:	48 89 c7             	mov    %rax,%rdi
ffff8000001021ab:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001021b2:	80 ff ff 
ffff8000001021b5:	ff d0                	call   *%rax
ffff8000001021b7:	c9                   	leave
ffff8000001021b8:	c3                   	ret

ffff8000001021b9 <readsb>:
ffff8000001021b9:	55                   	push   %rbp
ffff8000001021ba:	48 89 e5             	mov    %rsp,%rbp
ffff8000001021bd:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001021c1:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff8000001021c4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001021c8:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001021cb:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001021d0:	89 c7                	mov    %eax,%edi
ffff8000001021d2:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff8000001021d9:	80 ff ff 
ffff8000001021dc:	ff d0                	call   *%rax
ffff8000001021de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001021e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001021e6:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff8000001021ed:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001021f1:	ba 1c 00 00 00       	mov    $0x1c,%edx
ffff8000001021f6:	48 89 ce             	mov    %rcx,%rsi
ffff8000001021f9:	48 89 c7             	mov    %rax,%rdi
ffff8000001021fc:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000102203:	80 ff ff 
ffff800000102206:	ff d0                	call   *%rax
ffff800000102208:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010220c:	48 89 c7             	mov    %rax,%rdi
ffff80000010220f:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102216:	80 ff ff 
ffff800000102219:	ff d0                	call   *%rax
ffff80000010221b:	90                   	nop
ffff80000010221c:	c9                   	leave
ffff80000010221d:	c3                   	ret

ffff80000010221e <bzero>:
ffff80000010221e:	55                   	push   %rbp
ffff80000010221f:	48 89 e5             	mov    %rsp,%rbp
ffff800000102222:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102226:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102229:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff80000010222c:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010222f:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102232:	89 d6                	mov    %edx,%esi
ffff800000102234:	89 c7                	mov    %eax,%edi
ffff800000102236:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff80000010223d:	80 ff ff 
ffff800000102240:	ff d0                	call   *%rax
ffff800000102242:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000102246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010224a:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102250:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000102255:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010225a:	48 89 c7             	mov    %rax,%rdi
ffff80000010225d:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff800000102264:	80 ff ff 
ffff800000102267:	ff d0                	call   *%rax
ffff800000102269:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010226d:	48 89 c7             	mov    %rax,%rdi
ffff800000102270:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000102277:	80 ff ff 
ffff80000010227a:	ff d0                	call   *%rax
ffff80000010227c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102280:	48 89 c7             	mov    %rax,%rdi
ffff800000102283:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010228a:	80 ff ff 
ffff80000010228d:	ff d0                	call   *%rax
ffff80000010228f:	90                   	nop
ffff800000102290:	c9                   	leave
ffff800000102291:	c3                   	ret

ffff800000102292 <balloc>:
ffff800000102292:	55                   	push   %rbp
ffff800000102293:	48 89 e5             	mov    %rsp,%rbp
ffff800000102296:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010229a:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff80000010229d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001022a4:	e9 4a 01 00 00       	jmp    ffff8000001023f3 <balloc+0x161>
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
ffff8000001022e2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff8000001022e9:	e9 c4 00 00 00       	jmp    ffff8000001023b2 <balloc+0x120>
ffff8000001022ee:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001022f1:	83 e0 07             	and    $0x7,%eax
ffff8000001022f4:	ba 01 00 00 00       	mov    $0x1,%edx
ffff8000001022f9:	89 c1                	mov    %eax,%ecx
ffff8000001022fb:	d3 e2                	shl    %cl,%edx
ffff8000001022fd:	89 d0                	mov    %edx,%eax
ffff8000001022ff:	89 45 ec             	mov    %eax,-0x14(%rbp)
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
ffff800000102363:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102367:	48 89 c7             	mov    %rax,%rdi
ffff80000010236a:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000102371:	80 ff ff 
ffff800000102374:	ff d0                	call   *%rax
ffff800000102376:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010237a:	48 89 c7             	mov    %rax,%rdi
ffff80000010237d:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102384:	80 ff ff 
ffff800000102387:	ff d0                	call   *%rax
ffff800000102389:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010238c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010238f:	01 c2                	add    %eax,%edx
ffff800000102391:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000102394:	89 d6                	mov    %edx,%esi
ffff800000102396:	89 c7                	mov    %eax,%edi
ffff800000102398:	48 b8 1e 22 10 00 00 	movabs $0xffff80000010221e,%rax
ffff80000010239f:	80 ff ff 
ffff8000001023a2:	ff d0                	call   *%rax
ffff8000001023a4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001023a7:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001023aa:	01 d0                	add    %edx,%eax
ffff8000001023ac:	eb 75                	jmp    ffff800000102423 <balloc+0x191>
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
ffff8000001023d9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001023dd:	48 89 c7             	mov    %rax,%rdi
ffff8000001023e0:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001023e7:	80 ff ff 
ffff8000001023ea:	ff d0                	call   *%rax
ffff8000001023ec:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff8000001023f3:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff8000001023fa:	80 ff ff 
ffff8000001023fd:	8b 00                	mov    (%rax),%eax
ffff8000001023ff:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102402:	39 c2                	cmp    %eax,%edx
ffff800000102404:	0f 82 9f fe ff ff    	jb     ffff8000001022a9 <balloc+0x17>
ffff80000010240a:	48 b8 15 c6 10 00 00 	movabs $0xffff80000010c615,%rax
ffff800000102411:	80 ff ff 
ffff800000102414:	48 89 c7             	mov    %rax,%rdi
ffff800000102417:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010241e:	80 ff ff 
ffff800000102421:	ff d0                	call   *%rax
ffff800000102423:	c9                   	leave
ffff800000102424:	c3                   	ret

ffff800000102425 <bfree>:
ffff800000102425:	55                   	push   %rbp
ffff800000102426:	48 89 e5             	mov    %rsp,%rbp
ffff800000102429:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010242d:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000102430:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff800000102433:	48 ba 00 56 11 00 00 	movabs $0xffff800000115600,%rdx
ffff80000010243a:	80 ff ff 
ffff80000010243d:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000102440:	48 89 d6             	mov    %rdx,%rsi
ffff800000102443:	89 c7                	mov    %eax,%edi
ffff800000102445:	48 b8 b9 21 10 00 00 	movabs $0xffff8000001021b9,%rax
ffff80000010244c:	80 ff ff 
ffff80000010244f:	ff d0                	call   *%rax
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
ffff80000010247f:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000102482:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff800000102487:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff80000010248a:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010248d:	83 e0 07             	and    $0x7,%eax
ffff800000102490:	ba 01 00 00 00       	mov    $0x1,%edx
ffff800000102495:	89 c1                	mov    %eax,%ecx
ffff800000102497:	d3 e2                	shl    %cl,%edx
ffff800000102499:	89 d0                	mov    %edx,%eax
ffff80000010249b:	89 45 f0             	mov    %eax,-0x10(%rbp)
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
ffff8000001024c4:	48 b8 2b c6 10 00 00 	movabs $0xffff80000010c62b,%rax
ffff8000001024cb:	80 ff ff 
ffff8000001024ce:	48 89 c7             	mov    %rax,%rdi
ffff8000001024d1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001024d8:	80 ff ff 
ffff8000001024db:	ff d0                	call   *%rax
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
ffff800000102516:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010251a:	48 89 c7             	mov    %rax,%rdi
ffff80000010251d:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000102524:	80 ff ff 
ffff800000102527:	ff d0                	call   *%rax
ffff800000102529:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010252d:	48 89 c7             	mov    %rax,%rdi
ffff800000102530:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102537:	80 ff ff 
ffff80000010253a:	ff d0                	call   *%rax
ffff80000010253c:	90                   	nop
ffff80000010253d:	c9                   	leave
ffff80000010253e:	c3                   	ret

ffff80000010253f <iinit>:
ffff80000010253f:	55                   	push   %rbp
ffff800000102540:	48 89 e5             	mov    %rsp,%rbp
ffff800000102543:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102547:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010254a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102551:	48 ba 3e c6 10 00 00 	movabs $0xffff80000010c63e,%rdx
ffff800000102558:	80 ff ff 
ffff80000010255b:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102562:	80 ff ff 
ffff800000102565:	48 89 d6             	mov    %rdx,%rsi
ffff800000102568:	48 89 c7             	mov    %rax,%rdi
ffff80000010256b:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000102572:	80 ff ff 
ffff800000102575:	ff d0                	call   *%rax
ffff800000102577:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010257e:	eb 41                	jmp    ffff8000001025c1 <iinit+0x82>
ffff800000102580:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102583:	48 98                	cltq
ffff800000102585:	48 69 c0 d8 00 00 00 	imul   $0xd8,%rax,%rax
ffff80000010258c:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff800000102590:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102597:	80 ff ff 
ffff80000010259a:	48 01 d0             	add    %rdx,%rax
ffff80000010259d:	48 83 c0 08          	add    $0x8,%rax
ffff8000001025a1:	48 ba 45 c6 10 00 00 	movabs $0xffff80000010c645,%rdx
ffff8000001025a8:	80 ff ff 
ffff8000001025ab:	48 89 d6             	mov    %rdx,%rsi
ffff8000001025ae:	48 89 c7             	mov    %rax,%rdi
ffff8000001025b1:	48 b8 cf 74 10 00 00 	movabs $0xffff8000001074cf,%rax
ffff8000001025b8:	80 ff ff 
ffff8000001025bb:	ff d0                	call   *%rax
ffff8000001025bd:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001025c1:	83 7d fc 31          	cmpl   $0x31,-0x4(%rbp)
ffff8000001025c5:	7e b9                	jle    ffff800000102580 <iinit+0x41>
ffff8000001025c7:	48 ba 00 56 11 00 00 	movabs $0xffff800000115600,%rdx
ffff8000001025ce:	80 ff ff 
ffff8000001025d1:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001025d4:	48 89 d6             	mov    %rdx,%rsi
ffff8000001025d7:	89 c7                	mov    %eax,%edi
ffff8000001025d9:	48 b8 b9 21 10 00 00 	movabs $0xffff8000001021b9,%rax
ffff8000001025e0:	80 ff ff 
ffff8000001025e3:	ff d0                	call   *%rax
ffff8000001025e5:	90                   	nop
ffff8000001025e6:	c9                   	leave
ffff8000001025e7:	c3                   	ret

ffff8000001025e8 <ialloc>:
ffff8000001025e8:	55                   	push   %rbp
ffff8000001025e9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001025ec:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001025f0:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff8000001025f3:	89 f0                	mov    %esi,%eax
ffff8000001025f5:	66 89 45 d8          	mov    %ax,-0x28(%rbp)
ffff8000001025f9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff800000102600:	e9 d8 00 00 00       	jmp    ffff8000001026dd <ialloc+0xf5>
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
ffff800000102636:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010263a:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102641:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102644:	48 98                	cltq
ffff800000102646:	83 e0 07             	and    $0x7,%eax
ffff800000102649:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010264d:	48 01 d0             	add    %rdx,%rax
ffff800000102650:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000102654:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102658:	0f b7 00             	movzwl (%rax),%eax
ffff80000010265b:	66 85 c0             	test   %ax,%ax
ffff80000010265e:	75 66                	jne    ffff8000001026c6 <ialloc+0xde>
ffff800000102660:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102664:	ba 40 00 00 00       	mov    $0x40,%edx
ffff800000102669:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010266e:	48 89 c7             	mov    %rax,%rdi
ffff800000102671:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff800000102678:	80 ff ff 
ffff80000010267b:	ff d0                	call   *%rax
ffff80000010267d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102681:	0f b7 55 d8          	movzwl -0x28(%rbp),%edx
ffff800000102685:	66 89 10             	mov    %dx,(%rax)
ffff800000102688:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010268c:	48 89 c7             	mov    %rax,%rdi
ffff80000010268f:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000102696:	80 ff ff 
ffff800000102699:	ff d0                	call   *%rax
ffff80000010269b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010269f:	48 89 c7             	mov    %rax,%rdi
ffff8000001026a2:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001026a9:	80 ff ff 
ffff8000001026ac:	ff d0                	call   *%rax
ffff8000001026ae:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001026b1:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001026b4:	89 d6                	mov    %edx,%esi
ffff8000001026b6:	89 c7                	mov    %eax,%edi
ffff8000001026b8:	48 b8 22 28 10 00 00 	movabs $0xffff800000102822,%rax
ffff8000001026bf:	80 ff ff 
ffff8000001026c2:	ff d0                	call   *%rax
ffff8000001026c4:	eb 48                	jmp    ffff80000010270e <ialloc+0x126>
ffff8000001026c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001026ca:	48 89 c7             	mov    %rax,%rdi
ffff8000001026cd:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001026d4:	80 ff ff 
ffff8000001026d7:	ff d0                	call   *%rax
ffff8000001026d9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001026dd:	48 b8 00 56 11 00 00 	movabs $0xffff800000115600,%rax
ffff8000001026e4:	80 ff ff 
ffff8000001026e7:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001026ea:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001026ed:	39 c2                	cmp    %eax,%edx
ffff8000001026ef:	0f 82 10 ff ff ff    	jb     ffff800000102605 <ialloc+0x1d>
ffff8000001026f5:	48 b8 4b c6 10 00 00 	movabs $0xffff80000010c64b,%rax
ffff8000001026fc:	80 ff ff 
ffff8000001026ff:	48 89 c7             	mov    %rax,%rdi
ffff800000102702:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102709:	80 ff ff 
ffff80000010270c:	ff d0                	call   *%rax
ffff80000010270e:	c9                   	leave
ffff80000010270f:	c3                   	ret

ffff800000102710 <iupdate>:
ffff800000102710:	55                   	push   %rbp
ffff800000102711:	48 89 e5             	mov    %rsp,%rbp
ffff800000102714:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000102718:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
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
ffff800000102751:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102755:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010275c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102760:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102763:	89 c0                	mov    %eax,%eax
ffff800000102765:	83 e0 07             	and    $0x7,%eax
ffff800000102768:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010276c:	48 01 d0             	add    %rdx,%rax
ffff80000010276f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000102773:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102777:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff80000010277e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102782:	66 89 10             	mov    %dx,(%rax)
ffff800000102785:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102789:	0f b7 90 96 00 00 00 	movzwl 0x96(%rax),%edx
ffff800000102790:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102794:	66 89 50 02          	mov    %dx,0x2(%rax)
ffff800000102798:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010279c:	0f b7 90 98 00 00 00 	movzwl 0x98(%rax),%edx
ffff8000001027a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027a7:	66 89 50 04          	mov    %dx,0x4(%rax)
ffff8000001027ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027af:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff8000001027b6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027ba:	66 89 50 06          	mov    %dx,0x6(%rax)
ffff8000001027be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027c2:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff8000001027c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027cc:	89 50 08             	mov    %edx,0x8(%rax)
ffff8000001027cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001027d3:	48 8d 88 a0 00 00 00 	lea    0xa0(%rax),%rcx
ffff8000001027da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001027de:	48 83 c0 0c          	add    $0xc,%rax
ffff8000001027e2:	ba 34 00 00 00       	mov    $0x34,%edx
ffff8000001027e7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001027ea:	48 89 c7             	mov    %rax,%rdi
ffff8000001027ed:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff8000001027f4:	80 ff ff 
ffff8000001027f7:	ff d0                	call   *%rax
ffff8000001027f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001027fd:	48 89 c7             	mov    %rax,%rdi
ffff800000102800:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000102807:	80 ff ff 
ffff80000010280a:	ff d0                	call   *%rax
ffff80000010280c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102810:	48 89 c7             	mov    %rax,%rdi
ffff800000102813:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010281a:	80 ff ff 
ffff80000010281d:	ff d0                	call   *%rax
ffff80000010281f:	90                   	nop
ffff800000102820:	c9                   	leave
ffff800000102821:	c3                   	ret

ffff800000102822 <iget>:
ffff800000102822:	55                   	push   %rbp
ffff800000102823:	48 89 e5             	mov    %rsp,%rbp
ffff800000102826:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010282a:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010282d:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff800000102830:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102837:	80 ff ff 
ffff80000010283a:	48 89 c7             	mov    %rax,%rdi
ffff80000010283d:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000102844:	80 ff ff 
ffff800000102847:	ff d0                	call   *%rax
ffff800000102849:	48 c7 45 f0 00 00 00 	movq   $0x0,-0x10(%rbp)
ffff800000102850:	00 
ffff800000102851:	48 b8 88 56 11 00 00 	movabs $0xffff800000115688,%rax
ffff800000102858:	80 ff ff 
ffff80000010285b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010285f:	eb 77                	jmp    ffff8000001028d8 <iget+0xb6>
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
ffff800000102883:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102887:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010288a:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010288d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102891:	89 50 08             	mov    %edx,0x8(%rax)
ffff800000102894:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff80000010289b:	80 ff ff 
ffff80000010289e:	48 89 c7             	mov    %rax,%rdi
ffff8000001028a1:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001028a8:	80 ff ff 
ffff8000001028ab:	ff d0                	call   *%rax
ffff8000001028ad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028b1:	e9 a7 00 00 00       	jmp    ffff80000010295d <iget+0x13b>
ffff8000001028b6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001028bb:	75 13                	jne    ffff8000001028d0 <iget+0xae>
ffff8000001028bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028c1:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001028c4:	85 c0                	test   %eax,%eax
ffff8000001028c6:	75 08                	jne    ffff8000001028d0 <iget+0xae>
ffff8000001028c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001028cc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001028d0:	48 81 45 f8 d8 00 00 	addq   $0xd8,-0x8(%rbp)
ffff8000001028d7:	00 
ffff8000001028d8:	48 b8 b8 80 11 00 00 	movabs $0xffff8000001180b8,%rax
ffff8000001028df:	80 ff ff 
ffff8000001028e2:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001028e6:	0f 82 75 ff ff ff    	jb     ffff800000102861 <iget+0x3f>
ffff8000001028ec:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff8000001028f1:	75 19                	jne    ffff80000010290c <iget+0xea>
ffff8000001028f3:	48 b8 5d c6 10 00 00 	movabs $0xffff80000010c65d,%rax
ffff8000001028fa:	80 ff ff 
ffff8000001028fd:	48 89 c7             	mov    %rax,%rdi
ffff800000102900:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102907:	80 ff ff 
ffff80000010290a:	ff d0                	call   *%rax
ffff80000010290c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102910:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000102914:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102918:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010291b:	89 10                	mov    %edx,(%rax)
ffff80000010291d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102921:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff800000102924:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000102927:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010292b:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%rax)
ffff800000102932:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102936:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff80000010293d:	00 00 00 
ffff800000102940:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102947:	80 ff ff 
ffff80000010294a:	48 89 c7             	mov    %rax,%rdi
ffff80000010294d:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000102954:	80 ff ff 
ffff800000102957:	ff d0                	call   *%rax
ffff800000102959:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010295d:	c9                   	leave
ffff80000010295e:	c3                   	ret

ffff80000010295f <idup>:
ffff80000010295f:	55                   	push   %rbp
ffff800000102960:	48 89 e5             	mov    %rsp,%rbp
ffff800000102963:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102967:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010296b:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102972:	80 ff ff 
ffff800000102975:	48 89 c7             	mov    %rax,%rdi
ffff800000102978:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff80000010297f:	80 ff ff 
ffff800000102982:	ff d0                	call   *%rax
ffff800000102984:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102988:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010298b:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010298e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102992:	89 50 08             	mov    %edx,0x8(%rax)
ffff800000102995:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff80000010299c:	80 ff ff 
ffff80000010299f:	48 89 c7             	mov    %rax,%rdi
ffff8000001029a2:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001029a9:	80 ff ff 
ffff8000001029ac:	ff d0                	call   *%rax
ffff8000001029ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001029b2:	c9                   	leave
ffff8000001029b3:	c3                   	ret

ffff8000001029b4 <ilock>:
ffff8000001029b4:	55                   	push   %rbp
ffff8000001029b5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001029b8:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001029bc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001029c0:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001029c5:	74 0b                	je     ffff8000001029d2 <ilock+0x1e>
ffff8000001029c7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029cb:	8b 40 08             	mov    0x8(%rax),%eax
ffff8000001029ce:	85 c0                	test   %eax,%eax
ffff8000001029d0:	7f 19                	jg     ffff8000001029eb <ilock+0x37>
ffff8000001029d2:	48 b8 6d c6 10 00 00 	movabs $0xffff80000010c66d,%rax
ffff8000001029d9:	80 ff ff 
ffff8000001029dc:	48 89 c7             	mov    %rax,%rdi
ffff8000001029df:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001029e6:	80 ff ff 
ffff8000001029e9:	ff d0                	call   *%rax
ffff8000001029eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001029ef:	48 83 c0 10          	add    $0x10,%rax
ffff8000001029f3:	48 89 c7             	mov    %rax,%rdi
ffff8000001029f6:	48 b8 27 75 10 00 00 	movabs $0xffff800000107527,%rax
ffff8000001029fd:	80 ff ff 
ffff800000102a00:	ff d0                	call   *%rax
ffff800000102a02:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a06:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102a0c:	83 e0 02             	and    $0x2,%eax
ffff800000102a0f:	85 c0                	test   %eax,%eax
ffff800000102a11:	0f 85 31 01 00 00    	jne    ffff800000102b48 <ilock+0x194>
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
ffff800000102a4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102a50:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000102a57:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a5b:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000102a5e:	89 c0                	mov    %eax,%eax
ffff800000102a60:	83 e0 07             	and    $0x7,%eax
ffff800000102a63:	48 c1 e0 06          	shl    $0x6,%rax
ffff800000102a67:	48 01 d0             	add    %rdx,%rax
ffff800000102a6a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000102a6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a72:	0f b7 10             	movzwl (%rax),%edx
ffff800000102a75:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a79:	66 89 90 94 00 00 00 	mov    %dx,0x94(%rax)
ffff800000102a80:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a84:	0f b7 50 02          	movzwl 0x2(%rax),%edx
ffff800000102a88:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a8c:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
ffff800000102a93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102a97:	0f b7 50 04          	movzwl 0x4(%rax),%edx
ffff800000102a9b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102a9f:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
ffff800000102aa6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102aaa:	0f b7 50 06          	movzwl 0x6(%rax),%edx
ffff800000102aae:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ab2:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
ffff800000102ab9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102abd:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000102ac0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ac4:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
ffff800000102aca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ace:	48 8d 48 0c          	lea    0xc(%rax),%rcx
ffff800000102ad2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102ad6:	48 05 a0 00 00 00    	add    $0xa0,%rax
ffff800000102adc:	ba 34 00 00 00       	mov    $0x34,%edx
ffff800000102ae1:	48 89 ce             	mov    %rcx,%rsi
ffff800000102ae4:	48 89 c7             	mov    %rax,%rdi
ffff800000102ae7:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000102aee:	80 ff ff 
ffff800000102af1:	ff d0                	call   *%rax
ffff800000102af3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102af7:	48 89 c7             	mov    %rax,%rdi
ffff800000102afa:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102b01:	80 ff ff 
ffff800000102b04:	ff d0                	call   *%rax
ffff800000102b06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b0a:	8b 80 90 00 00 00    	mov    0x90(%rax),%eax
ffff800000102b10:	83 c8 02             	or     $0x2,%eax
ffff800000102b13:	89 c2                	mov    %eax,%edx
ffff800000102b15:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b19:	89 90 90 00 00 00    	mov    %edx,0x90(%rax)
ffff800000102b1f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102b23:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000102b2a:	66 85 c0             	test   %ax,%ax
ffff800000102b2d:	75 19                	jne    ffff800000102b48 <ilock+0x194>
ffff800000102b2f:	48 b8 73 c6 10 00 00 	movabs $0xffff80000010c673,%rax
ffff800000102b36:	80 ff ff 
ffff800000102b39:	48 89 c7             	mov    %rax,%rdi
ffff800000102b3c:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102b43:	80 ff ff 
ffff800000102b46:	ff d0                	call   *%rax
ffff800000102b48:	90                   	nop
ffff800000102b49:	c9                   	leave
ffff800000102b4a:	c3                   	ret

ffff800000102b4b <iunlock>:
ffff800000102b4b:	55                   	push   %rbp
ffff800000102b4c:	48 89 e5             	mov    %rsp,%rbp
ffff800000102b4f:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102b53:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102b57:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000102b5c:	74 26                	je     ffff800000102b84 <iunlock+0x39>
ffff800000102b5e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b62:	48 83 c0 10          	add    $0x10,%rax
ffff800000102b66:	48 89 c7             	mov    %rax,%rdi
ffff800000102b69:	48 b8 12 76 10 00 00 	movabs $0xffff800000107612,%rax
ffff800000102b70:	80 ff ff 
ffff800000102b73:	ff d0                	call   *%rax
ffff800000102b75:	85 c0                	test   %eax,%eax
ffff800000102b77:	74 0b                	je     ffff800000102b84 <iunlock+0x39>
ffff800000102b79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102b7d:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102b80:	85 c0                	test   %eax,%eax
ffff800000102b82:	7f 19                	jg     ffff800000102b9d <iunlock+0x52>
ffff800000102b84:	48 b8 82 c6 10 00 00 	movabs $0xffff80000010c682,%rax
ffff800000102b8b:	80 ff ff 
ffff800000102b8e:	48 89 c7             	mov    %rax,%rdi
ffff800000102b91:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102b98:	80 ff ff 
ffff800000102b9b:	ff d0                	call   *%rax
ffff800000102b9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ba1:	48 83 c0 10          	add    $0x10,%rax
ffff800000102ba5:	48 89 c7             	mov    %rax,%rdi
ffff800000102ba8:	48 b8 ad 75 10 00 00 	movabs $0xffff8000001075ad,%rax
ffff800000102baf:	80 ff ff 
ffff800000102bb2:	ff d0                	call   *%rax
ffff800000102bb4:	90                   	nop
ffff800000102bb5:	c9                   	leave
ffff800000102bb6:	c3                   	ret

ffff800000102bb7 <iput>:
ffff800000102bb7:	55                   	push   %rbp
ffff800000102bb8:	48 89 e5             	mov    %rsp,%rbp
ffff800000102bbb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102bbf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102bc3:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102bca:	80 ff ff 
ffff800000102bcd:	48 89 c7             	mov    %rax,%rdi
ffff800000102bd0:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000102bd7:	80 ff ff 
ffff800000102bda:	ff d0                	call   *%rax
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
ffff800000102c11:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102c18:	80 ff ff 
ffff800000102c1b:	48 89 c7             	mov    %rax,%rdi
ffff800000102c1e:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000102c25:	80 ff ff 
ffff800000102c28:	ff d0                	call   *%rax
ffff800000102c2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c2e:	48 89 c7             	mov    %rax,%rdi
ffff800000102c31:	48 b8 43 2e 10 00 00 	movabs $0xffff800000102e43,%rax
ffff800000102c38:	80 ff ff 
ffff800000102c3b:	ff d0                	call   *%rax
ffff800000102c3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c41:	66 c7 80 94 00 00 00 	movw   $0x0,0x94(%rax)
ffff800000102c48:	00 00 
ffff800000102c4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c4e:	48 89 c7             	mov    %rax,%rdi
ffff800000102c51:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000102c58:	80 ff ff 
ffff800000102c5b:	ff d0                	call   *%rax
ffff800000102c5d:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102c64:	80 ff ff 
ffff800000102c67:	48 89 c7             	mov    %rax,%rdi
ffff800000102c6a:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000102c71:	80 ff ff 
ffff800000102c74:	ff d0                	call   *%rax
ffff800000102c76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c7a:	c7 80 90 00 00 00 00 	movl   $0x0,0x90(%rax)
ffff800000102c81:	00 00 00 
ffff800000102c84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c88:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000102c8b:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000102c8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102c92:	89 50 08             	mov    %edx,0x8(%rax)
ffff800000102c95:	48 b8 20 56 11 00 00 	movabs $0xffff800000115620,%rax
ffff800000102c9c:	80 ff ff 
ffff800000102c9f:	48 89 c7             	mov    %rax,%rdi
ffff800000102ca2:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000102ca9:	80 ff ff 
ffff800000102cac:	ff d0                	call   *%rax
ffff800000102cae:	90                   	nop
ffff800000102caf:	c9                   	leave
ffff800000102cb0:	c3                   	ret

ffff800000102cb1 <iunlockput>:
ffff800000102cb1:	55                   	push   %rbp
ffff800000102cb2:	48 89 e5             	mov    %rsp,%rbp
ffff800000102cb5:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102cb9:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102cbd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cc1:	48 89 c7             	mov    %rax,%rdi
ffff800000102cc4:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000102ccb:	80 ff ff 
ffff800000102cce:	ff d0                	call   *%rax
ffff800000102cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102cd4:	48 89 c7             	mov    %rax,%rdi
ffff800000102cd7:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000102cde:	80 ff ff 
ffff800000102ce1:	ff d0                	call   *%rax
ffff800000102ce3:	90                   	nop
ffff800000102ce4:	c9                   	leave
ffff800000102ce5:	c3                   	ret

ffff800000102ce6 <bmap>:
ffff800000102ce6:	55                   	push   %rbp
ffff800000102ce7:	48 89 e5             	mov    %rsp,%rbp
ffff800000102cea:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102cee:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102cf2:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffff800000102cf5:	83 7d d4 0b          	cmpl   $0xb,-0x2c(%rbp)
ffff800000102cf9:	77 47                	ja     ffff800000102d42 <bmap+0x5c>
ffff800000102cfb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102cff:	8b 55 d4             	mov    -0x2c(%rbp),%edx
ffff800000102d02:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102d06:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102d09:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d10:	75 28                	jne    ffff800000102d3a <bmap+0x54>
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
ffff800000102d3a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102d3d:	e9 ff 00 00 00       	jmp    ffff800000102e41 <bmap+0x15b>
ffff800000102d42:	83 6d d4 0c          	subl   $0xc,-0x2c(%rbp)
ffff800000102d46:	83 7d d4 7f          	cmpl   $0x7f,-0x2c(%rbp)
ffff800000102d4a:	0f 87 d8 00 00 00    	ja     ffff800000102e28 <bmap+0x142>
ffff800000102d50:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d54:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102d5a:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102d5d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102d61:	75 24                	jne    ffff800000102d87 <bmap+0xa1>
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
ffff800000102d87:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102d8b:	8b 00                	mov    (%rax),%eax
ffff800000102d8d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102d90:	89 d6                	mov    %edx,%esi
ffff800000102d92:	89 c7                	mov    %eax,%edi
ffff800000102d94:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000102d9b:	80 ff ff 
ffff800000102d9e:	ff d0                	call   *%rax
ffff800000102da0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000102da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102da8:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102dae:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000102db2:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff800000102db5:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102dbc:	00 
ffff800000102dbd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102dc1:	48 01 d0             	add    %rdx,%rax
ffff800000102dc4:	8b 00                	mov    (%rax),%eax
ffff800000102dc6:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000102dc9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000102dcd:	75 41                	jne    ffff800000102e10 <bmap+0x12a>
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
ffff800000102dfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e01:	48 89 c7             	mov    %rax,%rdi
ffff800000102e04:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000102e0b:	80 ff ff 
ffff800000102e0e:	ff d0                	call   *%rax
ffff800000102e10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102e14:	48 89 c7             	mov    %rax,%rdi
ffff800000102e17:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102e1e:	80 ff ff 
ffff800000102e21:	ff d0                	call   *%rax
ffff800000102e23:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000102e26:	eb 19                	jmp    ffff800000102e41 <bmap+0x15b>
ffff800000102e28:	48 b8 8a c6 10 00 00 	movabs $0xffff80000010c68a,%rax
ffff800000102e2f:	80 ff ff 
ffff800000102e32:	48 89 c7             	mov    %rax,%rdi
ffff800000102e35:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000102e3c:	80 ff ff 
ffff800000102e3f:	ff d0                	call   *%rax
ffff800000102e41:	c9                   	leave
ffff800000102e42:	c3                   	ret

ffff800000102e43 <itrunc>:
ffff800000102e43:	55                   	push   %rbp
ffff800000102e44:	48 89 e5             	mov    %rsp,%rbp
ffff800000102e47:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000102e4b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000102e4f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000102e56:	eb 55                	jmp    ffff800000102ead <itrunc+0x6a>
ffff800000102e58:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e5c:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e5f:	48 63 d2             	movslq %edx,%rdx
ffff800000102e62:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102e66:	8b 04 90             	mov    (%rax,%rdx,4),%eax
ffff800000102e69:	85 c0                	test   %eax,%eax
ffff800000102e6b:	74 3c                	je     ffff800000102ea9 <itrunc+0x66>
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
ffff800000102e94:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102e98:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000102e9b:	48 63 d2             	movslq %edx,%rdx
ffff800000102e9e:	48 83 c2 28          	add    $0x28,%rdx
ffff800000102ea2:	c7 04 90 00 00 00 00 	movl   $0x0,(%rax,%rdx,4)
ffff800000102ea9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000102ead:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
ffff800000102eb1:	7e a5                	jle    ffff800000102e58 <itrunc+0x15>
ffff800000102eb3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102eb7:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102ebd:	85 c0                	test   %eax,%eax
ffff800000102ebf:	0f 84 ce 00 00 00    	je     ffff800000102f93 <itrunc+0x150>
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
ffff800000102ee9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102eed:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000102ef3:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000102ef7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000102efe:	eb 4a                	jmp    ffff800000102f4a <itrunc+0x107>
ffff800000102f00:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f03:	48 98                	cltq
ffff800000102f05:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000102f0c:	00 
ffff800000102f0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000102f11:	48 01 d0             	add    %rdx,%rax
ffff800000102f14:	8b 00                	mov    (%rax),%eax
ffff800000102f16:	85 c0                	test   %eax,%eax
ffff800000102f18:	74 2c                	je     ffff800000102f46 <itrunc+0x103>
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
ffff800000102f46:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff800000102f4a:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000102f4d:	83 f8 7f             	cmp    $0x7f,%eax
ffff800000102f50:	76 ae                	jbe    ffff800000102f00 <itrunc+0xbd>
ffff800000102f52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102f56:	48 89 c7             	mov    %rax,%rdi
ffff800000102f59:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000102f60:	80 ff ff 
ffff800000102f63:	ff d0                	call   *%rax
ffff800000102f65:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f69:	8b 80 d0 00 00 00    	mov    0xd0(%rax),%eax
ffff800000102f6f:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff800000102f73:	8b 12                	mov    (%rdx),%edx
ffff800000102f75:	89 c6                	mov    %eax,%esi
ffff800000102f77:	89 d7                	mov    %edx,%edi
ffff800000102f79:	48 b8 25 24 10 00 00 	movabs $0xffff800000102425,%rax
ffff800000102f80:	80 ff ff 
ffff800000102f83:	ff d0                	call   *%rax
ffff800000102f85:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f89:	c7 80 d0 00 00 00 00 	movl   $0x0,0xd0(%rax)
ffff800000102f90:	00 00 00 
ffff800000102f93:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102f97:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%rax)
ffff800000102f9e:	00 00 00 
ffff800000102fa1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000102fa5:	48 89 c7             	mov    %rax,%rdi
ffff800000102fa8:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000102faf:	80 ff ff 
ffff800000102fb2:	ff d0                	call   *%rax
ffff800000102fb4:	90                   	nop
ffff800000102fb5:	c9                   	leave
ffff800000102fb6:	c3                   	ret

ffff800000102fb7 <stati>:
ffff800000102fb7:	55                   	push   %rbp
ffff800000102fb8:	48 89 e5             	mov    %rsp,%rbp
ffff800000102fbb:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000102fbf:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000102fc3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000102fc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fcb:	8b 00                	mov    (%rax),%eax
ffff800000102fcd:	89 c2                	mov    %eax,%edx
ffff800000102fcf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fd3:	89 50 04             	mov    %edx,0x4(%rax)
ffff800000102fd6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fda:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000102fdd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102fe1:	89 50 08             	mov    %edx,0x8(%rax)
ffff800000102fe4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102fe8:	0f b7 90 94 00 00 00 	movzwl 0x94(%rax),%edx
ffff800000102fef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000102ff3:	66 89 10             	mov    %dx,(%rax)
ffff800000102ff6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000102ffa:	0f b7 90 9a 00 00 00 	movzwl 0x9a(%rax),%edx
ffff800000103001:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103005:	66 89 50 0c          	mov    %dx,0xc(%rax)
ffff800000103009:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010300d:	8b 90 9c 00 00 00    	mov    0x9c(%rax),%edx
ffff800000103013:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103017:	89 50 10             	mov    %edx,0x10(%rax)
ffff80000010301a:	90                   	nop
ffff80000010301b:	c9                   	leave
ffff80000010301c:	c3                   	ret

ffff80000010301d <readi>:
ffff80000010301d:	55                   	push   %rbp
ffff80000010301e:	48 89 e5             	mov    %rsp,%rbp
ffff800000103021:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103025:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103029:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010302d:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff800000103030:	89 4d c8             	mov    %ecx,-0x38(%rbp)
ffff800000103033:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103037:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010303e:	66 83 f8 03          	cmp    $0x3,%ax
ffff800000103042:	0f 85 8d 00 00 00    	jne    ffff8000001030d5 <readi+0xb8>
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
ffff800000103090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103095:	e9 4e 01 00 00       	jmp    ffff8000001031e8 <readi+0x1cb>
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
ffff8000001030d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001030d9:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001030df:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001030e2:	72 0d                	jb     ffff8000001030f1 <readi+0xd4>
ffff8000001030e4:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001030e7:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001030ea:	01 d0                	add    %edx,%eax
ffff8000001030ec:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001030ef:	73 0a                	jae    ffff8000001030fb <readi+0xde>
ffff8000001030f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001030f6:	e9 ed 00 00 00       	jmp    ffff8000001031e8 <readi+0x1cb>
ffff8000001030fb:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001030fe:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103101:	01 c2                	add    %eax,%edx
ffff800000103103:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103107:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010310d:	39 d0                	cmp    %edx,%eax
ffff80000010310f:	73 10                	jae    ffff800000103121 <readi+0x104>
ffff800000103111:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103115:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff80000010311b:	2b 45 cc             	sub    -0x34(%rbp),%eax
ffff80000010311e:	89 45 c8             	mov    %eax,-0x38(%rbp)
ffff800000103121:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103128:	e9 ac 00 00 00       	jmp    ffff8000001031d9 <readi+0x1bc>
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
ffff800000103166:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103169:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010316e:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000103173:	29 c2                	sub    %eax,%edx
ffff800000103175:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103178:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010317b:	39 c2                	cmp    %eax,%edx
ffff80000010317d:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103180:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000103183:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103187:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff80000010318e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103191:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103196:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010319a:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010319d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001031a1:	48 89 ce             	mov    %rcx,%rsi
ffff8000001031a4:	48 89 c7             	mov    %rax,%rdi
ffff8000001031a7:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff8000001031ae:	80 ff ff 
ffff8000001031b1:	ff d0                	call   *%rax
ffff8000001031b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001031b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001031ba:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001031c1:	80 ff ff 
ffff8000001031c4:	ff d0                	call   *%rax
ffff8000001031c6:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031c9:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001031cc:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031cf:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001031d2:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001031d5:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001031d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001031dc:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001031df:	0f 82 48 ff ff ff    	jb     ffff80000010312d <readi+0x110>
ffff8000001031e5:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001031e8:	c9                   	leave
ffff8000001031e9:	c3                   	ret

ffff8000001031ea <writei>:
ffff8000001031ea:	55                   	push   %rbp
ffff8000001031eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001031ee:	48 83 ec 40          	sub    $0x40,%rsp
ffff8000001031f2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001031f6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff8000001031fa:	89 55 cc             	mov    %edx,-0x34(%rbp)
ffff8000001031fd:	89 4d c8             	mov    %ecx,-0x38(%rbp)
ffff800000103200:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103204:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010320b:	66 83 f8 03          	cmp    $0x3,%ax
ffff80000010320f:	0f 85 95 00 00 00    	jne    ffff8000001032aa <writei+0xc0>
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
ffff800000103261:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103266:	e9 8d 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>
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
ffff8000001032aa:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001032ae:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001032b4:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001032b7:	72 0d                	jb     ffff8000001032c6 <writei+0xdc>
ffff8000001032b9:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032bc:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001032bf:	01 d0                	add    %edx,%eax
ffff8000001032c1:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001032c4:	73 0a                	jae    ffff8000001032d0 <writei+0xe6>
ffff8000001032c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032cb:	e9 28 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>
ffff8000001032d0:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001032d3:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001032d6:	01 d0                	add    %edx,%eax
ffff8000001032d8:	3d 00 18 01 00       	cmp    $0x11800,%eax
ffff8000001032dd:	76 0a                	jbe    ffff8000001032e9 <writei+0xff>
ffff8000001032df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001032e4:	e9 0f 01 00 00       	jmp    ffff8000001033f8 <writei+0x20e>
ffff8000001032e9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001032f0:	e9 bf 00 00 00       	jmp    ffff8000001033b4 <writei+0x1ca>
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
ffff80000010332e:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103331:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000103336:	ba 00 02 00 00       	mov    $0x200,%edx
ffff80000010333b:	29 c2                	sub    %eax,%edx
ffff80000010333d:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff800000103340:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff800000103343:	39 c2                	cmp    %eax,%edx
ffff800000103345:	0f 46 c2             	cmovbe %edx,%eax
ffff800000103348:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff80000010334b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010334f:	48 8d 90 b0 00 00 00 	lea    0xb0(%rax),%rdx
ffff800000103356:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff800000103359:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010335e:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff800000103362:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000103365:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000103369:	48 89 c6             	mov    %rax,%rsi
ffff80000010336c:	48 89 cf             	mov    %rcx,%rdi
ffff80000010336f:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000103376:	80 ff ff 
ffff800000103379:	ff d0                	call   *%rax
ffff80000010337b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010337f:	48 89 c7             	mov    %rax,%rdi
ffff800000103382:	48 b8 46 54 10 00 00 	movabs $0xffff800000105446,%rax
ffff800000103389:	80 ff ff 
ffff80000010338c:	ff d0                	call   *%rax
ffff80000010338e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103392:	48 89 c7             	mov    %rax,%rdi
ffff800000103395:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010339c:	80 ff ff 
ffff80000010339f:	ff d0                	call   *%rax
ffff8000001033a1:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033a4:	01 45 fc             	add    %eax,-0x4(%rbp)
ffff8000001033a7:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033aa:	01 45 cc             	add    %eax,-0x34(%rbp)
ffff8000001033ad:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001033b0:	48 01 45 d0          	add    %rax,-0x30(%rbp)
ffff8000001033b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001033b7:	3b 45 c8             	cmp    -0x38(%rbp),%eax
ffff8000001033ba:	0f 82 35 ff ff ff    	jb     ffff8000001032f5 <writei+0x10b>
ffff8000001033c0:	83 7d c8 00          	cmpl   $0x0,-0x38(%rbp)
ffff8000001033c4:	74 2f                	je     ffff8000001033f5 <writei+0x20b>
ffff8000001033c6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033ca:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001033d0:	3b 45 cc             	cmp    -0x34(%rbp),%eax
ffff8000001033d3:	73 20                	jae    ffff8000001033f5 <writei+0x20b>
ffff8000001033d5:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033d9:	8b 55 cc             	mov    -0x34(%rbp),%edx
ffff8000001033dc:	89 90 9c 00 00 00    	mov    %edx,0x9c(%rax)
ffff8000001033e2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001033e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001033e9:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff8000001033f0:	80 ff ff 
ffff8000001033f3:	ff d0                	call   *%rax
ffff8000001033f5:	8b 45 c8             	mov    -0x38(%rbp),%eax
ffff8000001033f8:	c9                   	leave
ffff8000001033f9:	c3                   	ret

ffff8000001033fa <namecmp>:
ffff8000001033fa:	55                   	push   %rbp
ffff8000001033fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001033fe:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103402:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000103406:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff80000010340a:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff80000010340e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103412:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff800000103417:	48 89 ce             	mov    %rcx,%rsi
ffff80000010341a:	48 89 c7             	mov    %rax,%rdi
ffff80000010341d:	48 b8 48 7c 10 00 00 	movabs $0xffff800000107c48,%rax
ffff800000103424:	80 ff ff 
ffff800000103427:	ff d0                	call   *%rax
ffff800000103429:	c9                   	leave
ffff80000010342a:	c3                   	ret

ffff80000010342b <dirlookup>:
ffff80000010342b:	55                   	push   %rbp
ffff80000010342c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010342f:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103433:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000103437:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010343b:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010343f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000103443:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff80000010344a:	66 83 f8 01          	cmp    $0x1,%ax
ffff80000010344e:	74 19                	je     ffff800000103469 <dirlookup+0x3e>
ffff800000103450:	48 b8 9d c6 10 00 00 	movabs $0xffff80000010c69d,%rax
ffff800000103457:	80 ff ff 
ffff80000010345a:	48 89 c7             	mov    %rax,%rdi
ffff80000010345d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103464:	80 ff ff 
ffff800000103467:	ff d0                	call   *%rax
ffff800000103469:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103470:	e9 a2 00 00 00       	jmp    ffff800000103517 <dirlookup+0xec>
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
ffff800000103499:	48 b8 af c6 10 00 00 	movabs $0xffff80000010c6af,%rax
ffff8000001034a0:	80 ff ff 
ffff8000001034a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001034a6:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001034ad:	80 ff ff 
ffff8000001034b0:	ff d0                	call   *%rax
ffff8000001034b2:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034b6:	66 85 c0             	test   %ax,%ax
ffff8000001034b9:	74 57                	je     ffff800000103512 <dirlookup+0xe7>
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
ffff8000001034dd:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff8000001034e2:	74 09                	je     ffff8000001034ed <dirlookup+0xc2>
ffff8000001034e4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff8000001034e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001034eb:	89 10                	mov    %edx,(%rax)
ffff8000001034ed:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001034f1:	0f b7 c0             	movzwl %ax,%eax
ffff8000001034f4:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff8000001034f7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001034fb:	8b 00                	mov    (%rax),%eax
ffff8000001034fd:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103500:	89 d6                	mov    %edx,%esi
ffff800000103502:	89 c7                	mov    %eax,%edi
ffff800000103504:	48 b8 22 28 10 00 00 	movabs $0xffff800000102822,%rax
ffff80000010350b:	80 ff ff 
ffff80000010350e:	ff d0                	call   *%rax
ffff800000103510:	eb 1d                	jmp    ffff80000010352f <dirlookup+0x104>
ffff800000103512:	90                   	nop
ffff800000103513:	83 45 fc 10          	addl   $0x10,-0x4(%rbp)
ffff800000103517:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010351b:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff800000103521:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000103524:	0f 82 4b ff ff ff    	jb     ffff800000103475 <dirlookup+0x4a>
ffff80000010352a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010352f:	c9                   	leave
ffff800000103530:	c3                   	ret

ffff800000103531 <dirlink>:
ffff800000103531:	55                   	push   %rbp
ffff800000103532:	48 89 e5             	mov    %rsp,%rbp
ffff800000103535:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000103539:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010353d:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff800000103541:	89 55 cc             	mov    %edx,-0x34(%rbp)
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
ffff80000010356e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103572:	48 89 c7             	mov    %rax,%rdi
ffff800000103575:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff80000010357c:	80 ff ff 
ffff80000010357f:	ff d0                	call   *%rax
ffff800000103581:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000103586:	e9 d8 00 00 00       	jmp    ffff800000103663 <dirlink+0x132>
ffff80000010358b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103592:	eb 4f                	jmp    ffff8000001035e3 <dirlink+0xb2>
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
ffff8000001035b8:	48 b8 be c6 10 00 00 	movabs $0xffff80000010c6be,%rax
ffff8000001035bf:	80 ff ff 
ffff8000001035c2:	48 89 c7             	mov    %rax,%rdi
ffff8000001035c5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001035cc:	80 ff ff 
ffff8000001035cf:	ff d0                	call   *%rax
ffff8000001035d1:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff8000001035d5:	66 85 c0             	test   %ax,%ax
ffff8000001035d8:	74 1c                	je     ffff8000001035f6 <dirlink+0xc5>
ffff8000001035da:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001035dd:	83 c0 10             	add    $0x10,%eax
ffff8000001035e0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001035e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001035e7:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001035ed:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001035f0:	39 c2                	cmp    %eax,%edx
ffff8000001035f2:	72 a0                	jb     ffff800000103594 <dirlink+0x63>
ffff8000001035f4:	eb 01                	jmp    ffff8000001035f7 <dirlink+0xc6>
ffff8000001035f6:	90                   	nop
ffff8000001035f7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff8000001035fb:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff8000001035ff:	48 8d 4a 02          	lea    0x2(%rdx),%rcx
ffff800000103603:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff800000103608:	48 89 c6             	mov    %rax,%rsi
ffff80000010360b:	48 89 cf             	mov    %rcx,%rdi
ffff80000010360e:	48 b8 b5 7c 10 00 00 	movabs $0xffff800000107cb5,%rax
ffff800000103615:	80 ff ff 
ffff800000103618:	ff d0                	call   *%rax
ffff80000010361a:	8b 45 cc             	mov    -0x34(%rbp),%eax
ffff80000010361d:	66 89 45 e0          	mov    %ax,-0x20(%rbp)
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
ffff800000103645:	48 b8 cb c6 10 00 00 	movabs $0xffff80000010c6cb,%rax
ffff80000010364c:	80 ff ff 
ffff80000010364f:	48 89 c7             	mov    %rax,%rdi
ffff800000103652:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103659:	80 ff ff 
ffff80000010365c:	ff d0                	call   *%rax
ffff80000010365e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103663:	c9                   	leave
ffff800000103664:	c3                   	ret

ffff800000103665 <skipelem>:
ffff800000103665:	55                   	push   %rbp
ffff800000103666:	48 89 e5             	mov    %rsp,%rbp
ffff800000103669:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010366d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103671:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000103675:	eb 05                	jmp    ffff80000010367c <skipelem+0x17>
ffff800000103677:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
ffff80000010367c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103680:	0f b6 00             	movzbl (%rax),%eax
ffff800000103683:	3c 2f                	cmp    $0x2f,%al
ffff800000103685:	74 f0                	je     ffff800000103677 <skipelem+0x12>
ffff800000103687:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010368b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010368e:	84 c0                	test   %al,%al
ffff800000103690:	75 0a                	jne    ffff80000010369c <skipelem+0x37>
ffff800000103692:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103697:	e9 9a 00 00 00       	jmp    ffff800000103736 <skipelem+0xd1>
ffff80000010369c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036a0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001036a4:	eb 05                	jmp    ffff8000001036ab <skipelem+0x46>
ffff8000001036a6:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
ffff8000001036ab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036af:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036b2:	3c 2f                	cmp    $0x2f,%al
ffff8000001036b4:	74 0b                	je     ffff8000001036c1 <skipelem+0x5c>
ffff8000001036b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036ba:	0f b6 00             	movzbl (%rax),%eax
ffff8000001036bd:	84 c0                	test   %al,%al
ffff8000001036bf:	75 e5                	jne    ffff8000001036a6 <skipelem+0x41>
ffff8000001036c1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001036c5:	48 2b 45 f8          	sub    -0x8(%rbp),%rax
ffff8000001036c9:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff8000001036cc:	83 7d f4 0d          	cmpl   $0xd,-0xc(%rbp)
ffff8000001036d0:	7e 21                	jle    ffff8000001036f3 <skipelem+0x8e>
ffff8000001036d2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001036d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001036da:	ba 0e 00 00 00       	mov    $0xe,%edx
ffff8000001036df:	48 89 ce             	mov    %rcx,%rsi
ffff8000001036e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001036e5:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff8000001036ec:	80 ff ff 
ffff8000001036ef:	ff d0                	call   *%rax
ffff8000001036f1:	eb 34                	jmp    ffff800000103727 <skipelem+0xc2>
ffff8000001036f3:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001036f6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001036fa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001036fe:	48 89 ce             	mov    %rcx,%rsi
ffff800000103701:	48 89 c7             	mov    %rax,%rdi
ffff800000103704:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff80000010370b:	80 ff ff 
ffff80000010370e:	ff d0                	call   *%rax
ffff800000103710:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103713:	48 63 d0             	movslq %eax,%rdx
ffff800000103716:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010371a:	48 01 d0             	add    %rdx,%rax
ffff80000010371d:	c6 00 00             	movb   $0x0,(%rax)
ffff800000103720:	eb 05                	jmp    ffff800000103727 <skipelem+0xc2>
ffff800000103722:	48 83 45 e8 01       	addq   $0x1,-0x18(%rbp)
ffff800000103727:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010372b:	0f b6 00             	movzbl (%rax),%eax
ffff80000010372e:	3c 2f                	cmp    $0x2f,%al
ffff800000103730:	74 f0                	je     ffff800000103722 <skipelem+0xbd>
ffff800000103732:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103736:	c9                   	leave
ffff800000103737:	c3                   	ret

ffff800000103738 <namex>:
ffff800000103738:	55                   	push   %rbp
ffff800000103739:	48 89 e5             	mov    %rsp,%rbp
ffff80000010373c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000103740:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103744:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000103747:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010374b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010374f:	0f b6 00             	movzbl (%rax),%eax
ffff800000103752:	3c 2f                	cmp    $0x2f,%al
ffff800000103754:	75 1f                	jne    ffff800000103775 <namex+0x3d>
ffff800000103756:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010375b:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103760:	48 b8 22 28 10 00 00 	movabs $0xffff800000102822,%rax
ffff800000103767:	80 ff ff 
ffff80000010376a:	ff d0                	call   *%rax
ffff80000010376c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103770:	e9 f7 00 00 00       	jmp    ffff80000010386c <namex+0x134>
ffff800000103775:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010377c:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000103780:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000103787:	48 89 c7             	mov    %rax,%rdi
ffff80000010378a:	48 b8 5f 29 10 00 00 	movabs $0xffff80000010295f,%rax
ffff800000103791:	80 ff ff 
ffff800000103794:	ff d0                	call   *%rax
ffff800000103796:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010379a:	e9 cd 00 00 00       	jmp    ffff80000010386c <namex+0x134>
ffff80000010379f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001037a6:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001037ad:	80 ff ff 
ffff8000001037b0:	ff d0                	call   *%rax
ffff8000001037b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037b6:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff8000001037bd:	66 83 f8 01          	cmp    $0x1,%ax
ffff8000001037c1:	74 1d                	je     ffff8000001037e0 <namex+0xa8>
ffff8000001037c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037c7:	48 89 c7             	mov    %rax,%rdi
ffff8000001037ca:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff8000001037d1:	80 ff ff 
ffff8000001037d4:	ff d0                	call   *%rax
ffff8000001037d6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001037db:	e9 d9 00 00 00       	jmp    ffff8000001038b9 <namex+0x181>
ffff8000001037e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff8000001037e4:	74 27                	je     ffff80000010380d <namex+0xd5>
ffff8000001037e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001037ea:	0f b6 00             	movzbl (%rax),%eax
ffff8000001037ed:	84 c0                	test   %al,%al
ffff8000001037ef:	75 1c                	jne    ffff80000010380d <namex+0xd5>
ffff8000001037f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001037f5:	48 89 c7             	mov    %rax,%rdi
ffff8000001037f8:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff8000001037ff:	80 ff ff 
ffff800000103802:	ff d0                	call   *%rax
ffff800000103804:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103808:	e9 ac 00 00 00       	jmp    ffff8000001038b9 <namex+0x181>
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
ffff800000103837:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010383b:	48 89 c7             	mov    %rax,%rdi
ffff80000010383e:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000103845:	80 ff ff 
ffff800000103848:	ff d0                	call   *%rax
ffff80000010384a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010384f:	eb 68                	jmp    ffff8000001038b9 <namex+0x181>
ffff800000103851:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103855:	48 89 c7             	mov    %rax,%rdi
ffff800000103858:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff80000010385f:	80 ff ff 
ffff800000103862:	ff d0                	call   *%rax
ffff800000103864:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000103868:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
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
ffff800000103895:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
ffff800000103899:	74 1a                	je     ffff8000001038b5 <namex+0x17d>
ffff80000010389b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010389f:	48 89 c7             	mov    %rax,%rdi
ffff8000001038a2:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff8000001038a9:	80 ff ff 
ffff8000001038ac:	ff d0                	call   *%rax
ffff8000001038ae:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001038b3:	eb 04                	jmp    ffff8000001038b9 <namex+0x181>
ffff8000001038b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001038b9:	c9                   	leave
ffff8000001038ba:	c3                   	ret

ffff8000001038bb <namei>:
ffff8000001038bb:	55                   	push   %rbp
ffff8000001038bc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038bf:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001038c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001038c7:	48 8d 55 f2          	lea    -0xe(%rbp),%rdx
ffff8000001038cb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001038cf:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001038d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001038d7:	48 b8 38 37 10 00 00 	movabs $0xffff800000103738,%rax
ffff8000001038de:	80 ff ff 
ffff8000001038e1:	ff d0                	call   *%rax
ffff8000001038e3:	c9                   	leave
ffff8000001038e4:	c3                   	ret

ffff8000001038e5 <nameiparent>:
ffff8000001038e5:	55                   	push   %rbp
ffff8000001038e6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001038e9:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001038ed:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001038f1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001038f5:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001038f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001038fd:	be 01 00 00 00       	mov    $0x1,%esi
ffff800000103902:	48 89 c7             	mov    %rax,%rdi
ffff800000103905:	48 b8 38 37 10 00 00 	movabs $0xffff800000103738,%rax
ffff80000010390c:	80 ff ff 
ffff80000010390f:	ff d0                	call   *%rax
ffff800000103911:	c9                   	leave
ffff800000103912:	c3                   	ret

ffff800000103913 <inb>:
ffff800000103913:	55                   	push   %rbp
ffff800000103914:	48 89 e5             	mov    %rsp,%rbp
ffff800000103917:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010391b:	89 f8                	mov    %edi,%eax
ffff80000010391d:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff800000103921:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000103925:	89 c2                	mov    %eax,%edx
ffff800000103927:	ec                   	in     (%dx),%al
ffff800000103928:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff80000010392b:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff80000010392f:	c9                   	leave
ffff800000103930:	c3                   	ret

ffff800000103931 <insl>:
ffff800000103931:	55                   	push   %rbp
ffff800000103932:	48 89 e5             	mov    %rsp,%rbp
ffff800000103935:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103939:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010393c:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103940:	89 55 f8             	mov    %edx,-0x8(%rbp)
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
ffff800000103964:	90                   	nop
ffff800000103965:	c9                   	leave
ffff800000103966:	c3                   	ret

ffff800000103967 <outb>:
ffff800000103967:	55                   	push   %rbp
ffff800000103968:	48 89 e5             	mov    %rsp,%rbp
ffff80000010396b:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010396f:	89 fa                	mov    %edi,%edx
ffff800000103971:	89 f0                	mov    %esi,%eax
ffff800000103973:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000103977:	88 45 f8             	mov    %al,-0x8(%rbp)
ffff80000010397a:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010397e:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000103982:	ee                   	out    %al,(%dx)
ffff800000103983:	90                   	nop
ffff800000103984:	c9                   	leave
ffff800000103985:	c3                   	ret

ffff800000103986 <outsl>:
ffff800000103986:	55                   	push   %rbp
ffff800000103987:	48 89 e5             	mov    %rsp,%rbp
ffff80000010398a:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010398e:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103991:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000103995:	89 55 f8             	mov    %edx,-0x8(%rbp)
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
ffff8000001039b3:	90                   	nop
ffff8000001039b4:	c9                   	leave
ffff8000001039b5:	c3                   	ret

ffff8000001039b6 <idewait>:
ffff8000001039b6:	55                   	push   %rbp
ffff8000001039b7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001039ba:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001039be:	89 7d ec             	mov    %edi,-0x14(%rbp)
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
ffff8000001039e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff8000001039ea:	74 11                	je     ffff8000001039fd <idewait+0x47>
ffff8000001039ec:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001039ef:	83 e0 21             	and    $0x21,%eax
ffff8000001039f2:	85 c0                	test   %eax,%eax
ffff8000001039f4:	74 07                	je     ffff8000001039fd <idewait+0x47>
ffff8000001039f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001039fb:	eb 05                	jmp    ffff800000103a02 <idewait+0x4c>
ffff8000001039fd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000103a02:	c9                   	leave
ffff800000103a03:	c3                   	ret

ffff800000103a04 <ideinit>:
ffff800000103a04:	55                   	push   %rbp
ffff800000103a05:	48 89 e5             	mov    %rsp,%rbp
ffff800000103a08:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103a0c:	48 ba d3 c6 10 00 00 	movabs $0xffff80000010c6d3,%rdx
ffff800000103a13:	80 ff ff 
ffff800000103a16:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103a1d:	80 ff ff 
ffff800000103a20:	48 89 d6             	mov    %rdx,%rsi
ffff800000103a23:	48 89 c7             	mov    %rax,%rdi
ffff800000103a26:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000103a2d:	80 ff ff 
ffff800000103a30:	ff d0                	call   *%rax
ffff800000103a32:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000103a39:	80 ff ff 
ffff800000103a3c:	8b 00                	mov    (%rax),%eax
ffff800000103a3e:	83 e8 01             	sub    $0x1,%eax
ffff800000103a41:	89 c6                	mov    %eax,%esi
ffff800000103a43:	bf 0e 00 00 00       	mov    $0xe,%edi
ffff800000103a48:	48 b8 96 40 10 00 00 	movabs $0xffff800000104096,%rax
ffff800000103a4f:	80 ff ff 
ffff800000103a52:	ff d0                	call   *%rax
ffff800000103a54:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103a59:	48 b8 b6 39 10 00 00 	movabs $0xffff8000001039b6,%rax
ffff800000103a60:	80 ff ff 
ffff800000103a63:	ff d0                	call   *%rax
ffff800000103a65:	be f0 00 00 00       	mov    $0xf0,%esi
ffff800000103a6a:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103a6f:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103a76:	80 ff ff 
ffff800000103a79:	ff d0                	call   *%rax
ffff800000103a7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000103a82:	eb 2b                	jmp    ffff800000103aaf <ideinit+0xab>
ffff800000103a84:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103a89:	48 b8 13 39 10 00 00 	movabs $0xffff800000103913,%rax
ffff800000103a90:	80 ff ff 
ffff800000103a93:	ff d0                	call   *%rax
ffff800000103a95:	84 c0                	test   %al,%al
ffff800000103a97:	74 12                	je     ffff800000103aab <ideinit+0xa7>
ffff800000103a99:	48 b8 30 81 11 00 00 	movabs $0xffff800000118130,%rax
ffff800000103aa0:	80 ff ff 
ffff800000103aa3:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
ffff800000103aa9:	eb 0d                	jmp    ffff800000103ab8 <ideinit+0xb4>
ffff800000103aab:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000103aaf:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
ffff800000103ab6:	7e cc                	jle    ffff800000103a84 <ideinit+0x80>
ffff800000103ab8:	be e0 00 00 00       	mov    $0xe0,%esi
ffff800000103abd:	bf f6 01 00 00       	mov    $0x1f6,%edi
ffff800000103ac2:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103ac9:	80 ff ff 
ffff800000103acc:	ff d0                	call   *%rax
ffff800000103ace:	90                   	nop
ffff800000103acf:	c9                   	leave
ffff800000103ad0:	c3                   	ret

ffff800000103ad1 <idestart>:
ffff800000103ad1:	55                   	push   %rbp
ffff800000103ad2:	48 89 e5             	mov    %rsp,%rbp
ffff800000103ad5:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103ad9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103add:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000103ae2:	75 19                	jne    ffff800000103afd <idestart+0x2c>
ffff800000103ae4:	48 b8 d7 c6 10 00 00 	movabs $0xffff80000010c6d7,%rax
ffff800000103aeb:	80 ff ff 
ffff800000103aee:	48 89 c7             	mov    %rax,%rdi
ffff800000103af1:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103af8:	80 ff ff 
ffff800000103afb:	ff d0                	call   *%rax
ffff800000103afd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b01:	8b 40 08             	mov    0x8(%rax),%eax
ffff800000103b04:	3d e7 03 00 00       	cmp    $0x3e7,%eax
ffff800000103b09:	76 19                	jbe    ffff800000103b24 <idestart+0x53>
ffff800000103b0b:	48 b8 e0 c6 10 00 00 	movabs $0xffff80000010c6e0,%rax
ffff800000103b12:	80 ff ff 
ffff800000103b15:	48 89 c7             	mov    %rax,%rdi
ffff800000103b18:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103b1f:	80 ff ff 
ffff800000103b22:	ff d0                	call   *%rax
ffff800000103b24:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
ffff800000103b2b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103b2f:	8b 50 08             	mov    0x8(%rax),%edx
ffff800000103b32:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103b35:	0f af c2             	imul   %edx,%eax
ffff800000103b38:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000103b3b:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103b3f:	75 09                	jne    ffff800000103b4a <idestart+0x79>
ffff800000103b41:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff800000103b48:	eb 07                	jmp    ffff800000103b51 <idestart+0x80>
ffff800000103b4a:	c7 45 fc c4 00 00 00 	movl   $0xc4,-0x4(%rbp)
ffff800000103b51:	83 7d f4 01          	cmpl   $0x1,-0xc(%rbp)
ffff800000103b55:	75 09                	jne    ffff800000103b60 <idestart+0x8f>
ffff800000103b57:	c7 45 f8 30 00 00 00 	movl   $0x30,-0x8(%rbp)
ffff800000103b5e:	eb 07                	jmp    ffff800000103b67 <idestart+0x96>
ffff800000103b60:	c7 45 f8 c5 00 00 00 	movl   $0xc5,-0x8(%rbp)
ffff800000103b67:	83 7d f4 07          	cmpl   $0x7,-0xc(%rbp)
ffff800000103b6b:	7e 19                	jle    ffff800000103b86 <idestart+0xb5>
ffff800000103b6d:	48 b8 d7 c6 10 00 00 	movabs $0xffff80000010c6d7,%rax
ffff800000103b74:	80 ff ff 
ffff800000103b77:	48 89 c7             	mov    %rax,%rdi
ffff800000103b7a:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103b81:	80 ff ff 
ffff800000103b84:	ff d0                	call   *%rax
ffff800000103b86:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103b8b:	48 b8 b6 39 10 00 00 	movabs $0xffff8000001039b6,%rax
ffff800000103b92:	80 ff ff 
ffff800000103b95:	ff d0                	call   *%rax
ffff800000103b97:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000103b9c:	bf f6 03 00 00       	mov    $0x3f6,%edi
ffff800000103ba1:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103ba8:	80 ff ff 
ffff800000103bab:	ff d0                	call   *%rax
ffff800000103bad:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000103bb0:	0f b6 c0             	movzbl %al,%eax
ffff800000103bb3:	89 c6                	mov    %eax,%esi
ffff800000103bb5:	bf f2 01 00 00       	mov    $0x1f2,%edi
ffff800000103bba:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103bc1:	80 ff ff 
ffff800000103bc4:	ff d0                	call   *%rax
ffff800000103bc6:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103bc9:	0f b6 c0             	movzbl %al,%eax
ffff800000103bcc:	89 c6                	mov    %eax,%esi
ffff800000103bce:	bf f3 01 00 00       	mov    $0x1f3,%edi
ffff800000103bd3:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103bda:	80 ff ff 
ffff800000103bdd:	ff d0                	call   *%rax
ffff800000103bdf:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103be2:	c1 f8 08             	sar    $0x8,%eax
ffff800000103be5:	0f b6 c0             	movzbl %al,%eax
ffff800000103be8:	89 c6                	mov    %eax,%esi
ffff800000103bea:	bf f4 01 00 00       	mov    $0x1f4,%edi
ffff800000103bef:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103bf6:	80 ff ff 
ffff800000103bf9:	ff d0                	call   *%rax
ffff800000103bfb:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000103bfe:	c1 f8 10             	sar    $0x10,%eax
ffff800000103c01:	0f b6 c0             	movzbl %al,%eax
ffff800000103c04:	89 c6                	mov    %eax,%esi
ffff800000103c06:	bf f5 01 00 00       	mov    $0x1f5,%edi
ffff800000103c0b:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103c12:	80 ff ff 
ffff800000103c15:	ff d0                	call   *%rax
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
ffff800000103c4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c4e:	8b 00                	mov    (%rax),%eax
ffff800000103c50:	83 e0 04             	and    $0x4,%eax
ffff800000103c53:	85 c0                	test   %eax,%eax
ffff800000103c55:	74 3e                	je     ffff800000103c95 <idestart+0x1c4>
ffff800000103c57:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000103c5a:	0f b6 c0             	movzbl %al,%eax
ffff800000103c5d:	89 c6                	mov    %eax,%esi
ffff800000103c5f:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103c64:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103c6b:	80 ff ff 
ffff800000103c6e:	ff d0                	call   *%rax
ffff800000103c70:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103c74:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103c7a:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103c7f:	48 89 c6             	mov    %rax,%rsi
ffff800000103c82:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103c87:	48 b8 86 39 10 00 00 	movabs $0xffff800000103986,%rax
ffff800000103c8e:	80 ff ff 
ffff800000103c91:	ff d0                	call   *%rax
ffff800000103c93:	eb 19                	jmp    ffff800000103cae <idestart+0x1dd>
ffff800000103c95:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000103c98:	0f b6 c0             	movzbl %al,%eax
ffff800000103c9b:	89 c6                	mov    %eax,%esi
ffff800000103c9d:	bf f7 01 00 00       	mov    $0x1f7,%edi
ffff800000103ca2:	48 b8 67 39 10 00 00 	movabs $0xffff800000103967,%rax
ffff800000103ca9:	80 ff ff 
ffff800000103cac:	ff d0                	call   *%rax
ffff800000103cae:	90                   	nop
ffff800000103caf:	c9                   	leave
ffff800000103cb0:	c3                   	ret

ffff800000103cb1 <ideintr>:
ffff800000103cb1:	55                   	push   %rbp
ffff800000103cb2:	48 89 e5             	mov    %rsp,%rbp
ffff800000103cb5:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103cb9:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103cc0:	80 ff ff 
ffff800000103cc3:	48 89 c7             	mov    %rax,%rdi
ffff800000103cc6:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000103ccd:	80 ff ff 
ffff800000103cd0:	ff d0                	call   *%rax
ffff800000103cd2:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103cd9:	80 ff ff 
ffff800000103cdc:	48 8b 00             	mov    (%rax),%rax
ffff800000103cdf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000103ce3:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000103ce8:	75 1e                	jne    ffff800000103d08 <ideintr+0x57>
ffff800000103cea:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103cf1:	80 ff ff 
ffff800000103cf4:	48 89 c7             	mov    %rax,%rdi
ffff800000103cf7:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000103cfe:	80 ff ff 
ffff800000103d01:	ff d0                	call   *%rax
ffff800000103d03:	e9 d9 00 00 00       	jmp    ffff800000103de1 <ideintr+0x130>
ffff800000103d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d0c:	48 8b 80 a8 00 00 00 	mov    0xa8(%rax),%rax
ffff800000103d13:	48 ba 28 81 11 00 00 	movabs $0xffff800000118128,%rdx
ffff800000103d1a:	80 ff ff 
ffff800000103d1d:	48 89 02             	mov    %rax,(%rdx)
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
ffff800000103d42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d46:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000103d4c:	ba 80 00 00 00       	mov    $0x80,%edx
ffff800000103d51:	48 89 c6             	mov    %rax,%rsi
ffff800000103d54:	bf f0 01 00 00       	mov    $0x1f0,%edi
ffff800000103d59:	48 b8 31 39 10 00 00 	movabs $0xffff800000103931,%rax
ffff800000103d60:	80 ff ff 
ffff800000103d63:	ff d0                	call   *%rax
ffff800000103d65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d69:	8b 00                	mov    (%rax),%eax
ffff800000103d6b:	83 c8 02             	or     $0x2,%eax
ffff800000103d6e:	89 c2                	mov    %eax,%edx
ffff800000103d70:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d74:	89 10                	mov    %edx,(%rax)
ffff800000103d76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d7a:	8b 00                	mov    (%rax),%eax
ffff800000103d7c:	83 e0 fb             	and    $0xfffffffb,%eax
ffff800000103d7f:	89 c2                	mov    %eax,%edx
ffff800000103d81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d85:	89 10                	mov    %edx,(%rax)
ffff800000103d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103d8b:	48 89 c7             	mov    %rax,%rdi
ffff800000103d8e:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000103d95:	80 ff ff 
ffff800000103d98:	ff d0                	call   *%rax
ffff800000103d9a:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103da1:	80 ff ff 
ffff800000103da4:	48 8b 00             	mov    (%rax),%rax
ffff800000103da7:	48 85 c0             	test   %rax,%rax
ffff800000103daa:	74 1c                	je     ffff800000103dc8 <ideintr+0x117>
ffff800000103dac:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103db3:	80 ff ff 
ffff800000103db6:	48 8b 00             	mov    (%rax),%rax
ffff800000103db9:	48 89 c7             	mov    %rax,%rdi
ffff800000103dbc:	48 b8 d1 3a 10 00 00 	movabs $0xffff800000103ad1,%rax
ffff800000103dc3:	80 ff ff 
ffff800000103dc6:	ff d0                	call   *%rax
ffff800000103dc8:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103dcf:	80 ff ff 
ffff800000103dd2:	48 89 c7             	mov    %rax,%rdi
ffff800000103dd5:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000103ddc:	80 ff ff 
ffff800000103ddf:	ff d0                	call   *%rax
ffff800000103de1:	c9                   	leave
ffff800000103de2:	c3                   	ret

ffff800000103de3 <iderw>:
ffff800000103de3:	55                   	push   %rbp
ffff800000103de4:	48 89 e5             	mov    %rsp,%rbp
ffff800000103de7:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000103deb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000103def:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103df3:	48 83 c0 10          	add    $0x10,%rax
ffff800000103df7:	48 89 c7             	mov    %rax,%rdi
ffff800000103dfa:	48 b8 12 76 10 00 00 	movabs $0xffff800000107612,%rax
ffff800000103e01:	80 ff ff 
ffff800000103e04:	ff d0                	call   *%rax
ffff800000103e06:	85 c0                	test   %eax,%eax
ffff800000103e08:	75 19                	jne    ffff800000103e23 <iderw+0x40>
ffff800000103e0a:	48 b8 f2 c6 10 00 00 	movabs $0xffff80000010c6f2,%rax
ffff800000103e11:	80 ff ff 
ffff800000103e14:	48 89 c7             	mov    %rax,%rdi
ffff800000103e17:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103e1e:	80 ff ff 
ffff800000103e21:	ff d0                	call   *%rax
ffff800000103e23:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e27:	8b 00                	mov    (%rax),%eax
ffff800000103e29:	83 e0 06             	and    $0x6,%eax
ffff800000103e2c:	83 f8 02             	cmp    $0x2,%eax
ffff800000103e2f:	75 19                	jne    ffff800000103e4a <iderw+0x67>
ffff800000103e31:	48 b8 08 c7 10 00 00 	movabs $0xffff80000010c708,%rax
ffff800000103e38:	80 ff ff 
ffff800000103e3b:	48 89 c7             	mov    %rax,%rdi
ffff800000103e3e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103e45:	80 ff ff 
ffff800000103e48:	ff d0                	call   *%rax
ffff800000103e4a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e4e:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000103e51:	85 c0                	test   %eax,%eax
ffff800000103e53:	74 29                	je     ffff800000103e7e <iderw+0x9b>
ffff800000103e55:	48 b8 30 81 11 00 00 	movabs $0xffff800000118130,%rax
ffff800000103e5c:	80 ff ff 
ffff800000103e5f:	8b 00                	mov    (%rax),%eax
ffff800000103e61:	85 c0                	test   %eax,%eax
ffff800000103e63:	75 19                	jne    ffff800000103e7e <iderw+0x9b>
ffff800000103e65:	48 b8 1d c7 10 00 00 	movabs $0xffff80000010c71d,%rax
ffff800000103e6c:	80 ff ff 
ffff800000103e6f:	48 89 c7             	mov    %rax,%rdi
ffff800000103e72:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000103e79:	80 ff ff 
ffff800000103e7c:	ff d0                	call   *%rax
ffff800000103e7e:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103e85:	80 ff ff 
ffff800000103e88:	48 89 c7             	mov    %rax,%rdi
ffff800000103e8b:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000103e92:	80 ff ff 
ffff800000103e95:	ff d0                	call   *%rax
ffff800000103e97:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103e9b:	48 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%rax)
ffff800000103ea2:	00 00 00 00 
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
ffff800000103ed3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000103ed7:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000103edb:	48 89 10             	mov    %rdx,(%rax)
ffff800000103ede:	48 b8 28 81 11 00 00 	movabs $0xffff800000118128,%rax
ffff800000103ee5:	80 ff ff 
ffff800000103ee8:	48 8b 00             	mov    (%rax),%rax
ffff800000103eeb:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000103eef:	75 35                	jne    ffff800000103f26 <iderw+0x143>
ffff800000103ef1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103ef5:	48 89 c7             	mov    %rax,%rdi
ffff800000103ef8:	48 b8 d1 3a 10 00 00 	movabs $0xffff800000103ad1,%rax
ffff800000103eff:	80 ff ff 
ffff800000103f02:	ff d0                	call   *%rax
ffff800000103f04:	eb 20                	jmp    ffff800000103f26 <iderw+0x143>
ffff800000103f06:	48 ba c0 80 11 00 00 	movabs $0xffff8000001180c0,%rdx
ffff800000103f0d:	80 ff ff 
ffff800000103f10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f14:	48 89 d6             	mov    %rdx,%rsi
ffff800000103f17:	48 89 c7             	mov    %rax,%rdi
ffff800000103f1a:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000103f21:	80 ff ff 
ffff800000103f24:	ff d0                	call   *%rax
ffff800000103f26:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000103f2a:	8b 00                	mov    (%rax),%eax
ffff800000103f2c:	83 e0 06             	and    $0x6,%eax
ffff800000103f2f:	83 f8 02             	cmp    $0x2,%eax
ffff800000103f32:	75 d2                	jne    ffff800000103f06 <iderw+0x123>
ffff800000103f34:	48 b8 c0 80 11 00 00 	movabs $0xffff8000001180c0,%rax
ffff800000103f3b:	80 ff ff 
ffff800000103f3e:	48 89 c7             	mov    %rax,%rdi
ffff800000103f41:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000103f48:	80 ff ff 
ffff800000103f4b:	ff d0                	call   *%rax
ffff800000103f4d:	90                   	nop
ffff800000103f4e:	c9                   	leave
ffff800000103f4f:	c3                   	ret

ffff800000103f50 <ioapicread>:
ffff800000103f50:	55                   	push   %rbp
ffff800000103f51:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f54:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f58:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103f5b:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103f62:	80 ff ff 
ffff800000103f65:	48 8b 00             	mov    (%rax),%rax
ffff800000103f68:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103f6b:	89 10                	mov    %edx,(%rax)
ffff800000103f6d:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103f74:	80 ff ff 
ffff800000103f77:	48 8b 00             	mov    (%rax),%rax
ffff800000103f7a:	8b 40 10             	mov    0x10(%rax),%eax
ffff800000103f7d:	c9                   	leave
ffff800000103f7e:	c3                   	ret

ffff800000103f7f <ioapicwrite>:
ffff800000103f7f:	55                   	push   %rbp
ffff800000103f80:	48 89 e5             	mov    %rsp,%rbp
ffff800000103f83:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000103f87:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000103f8a:	89 75 f8             	mov    %esi,-0x8(%rbp)
ffff800000103f8d:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103f94:	80 ff ff 
ffff800000103f97:	48 8b 00             	mov    (%rax),%rax
ffff800000103f9a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000103f9d:	89 10                	mov    %edx,(%rax)
ffff800000103f9f:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103fa6:	80 ff ff 
ffff800000103fa9:	48 8b 00             	mov    (%rax),%rax
ffff800000103fac:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff800000103faf:	89 50 10             	mov    %edx,0x10(%rax)
ffff800000103fb2:	90                   	nop
ffff800000103fb3:	c9                   	leave
ffff800000103fb4:	c3                   	ret

ffff800000103fb5 <ioapicinit>:
ffff800000103fb5:	55                   	push   %rbp
ffff800000103fb6:	48 89 e5             	mov    %rsp,%rbp
ffff800000103fb9:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000103fbd:	48 b8 38 81 11 00 00 	movabs $0xffff800000118138,%rax
ffff800000103fc4:	80 ff ff 
ffff800000103fc7:	48 b9 00 00 c0 fe 00 	movabs $0xffff8000fec00000,%rcx
ffff800000103fce:	80 ff ff 
ffff800000103fd1:	48 89 08             	mov    %rcx,(%rax)
ffff800000103fd4:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000103fd9:	48 b8 50 3f 10 00 00 	movabs $0xffff800000103f50,%rax
ffff800000103fe0:	80 ff ff 
ffff800000103fe3:	ff d0                	call   *%rax
ffff800000103fe5:	c1 e8 10             	shr    $0x10,%eax
ffff800000103fe8:	25 ff 00 00 00       	and    $0xff,%eax
ffff800000103fed:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff800000103ff0:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000103ff5:	48 b8 50 3f 10 00 00 	movabs $0xffff800000103f50,%rax
ffff800000103ffc:	80 ff ff 
ffff800000103fff:	ff d0                	call   *%rax
ffff800000104001:	c1 e8 18             	shr    $0x18,%eax
ffff800000104004:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000104007:	48 b8 24 84 11 00 00 	movabs $0xffff800000118424,%rax
ffff80000010400e:	80 ff ff 
ffff800000104011:	0f b6 00             	movzbl (%rax),%eax
ffff800000104014:	0f b6 c0             	movzbl %al,%eax
ffff800000104017:	39 45 f4             	cmp    %eax,-0xc(%rbp)
ffff80000010401a:	74 1e                	je     ffff80000010403a <ioapicinit+0x85>
ffff80000010401c:	48 b8 40 c7 10 00 00 	movabs $0xffff80000010c740,%rax
ffff800000104023:	80 ff ff 
ffff800000104026:	48 89 c7             	mov    %rax,%rdi
ffff800000104029:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010402e:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000104035:	80 ff ff 
ffff800000104038:	ff d2                	call   *%rdx
ffff80000010403a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104041:	eb 47                	jmp    ffff80000010408a <ioapicinit+0xd5>
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
ffff800000104068:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010406b:	83 c0 08             	add    $0x8,%eax
ffff80000010406e:	01 c0                	add    %eax,%eax
ffff800000104070:	83 c0 01             	add    $0x1,%eax
ffff800000104073:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104078:	89 c7                	mov    %eax,%edi
ffff80000010407a:	48 b8 7f 3f 10 00 00 	movabs $0xffff800000103f7f,%rax
ffff800000104081:	80 ff ff 
ffff800000104084:	ff d0                	call   *%rax
ffff800000104086:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010408a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010408d:	3b 45 f8             	cmp    -0x8(%rbp),%eax
ffff800000104090:	7e b1                	jle    ffff800000104043 <ioapicinit+0x8e>
ffff800000104092:	90                   	nop
ffff800000104093:	90                   	nop
ffff800000104094:	c9                   	leave
ffff800000104095:	c3                   	ret

ffff800000104096 <ioapicenable>:
ffff800000104096:	55                   	push   %rbp
ffff800000104097:	48 89 e5             	mov    %rsp,%rbp
ffff80000010409a:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010409e:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001040a1:	89 75 f8             	mov    %esi,-0x8(%rbp)
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
ffff8000001040fa:	48 ba 72 c7 10 00 00 	movabs $0xffff80000010c772,%rdx
ffff800000104101:	80 ff ff 
ffff800000104104:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010410b:	80 ff ff 
ffff80000010410e:	48 89 d6             	mov    %rdx,%rsi
ffff800000104111:	48 89 c7             	mov    %rax,%rdi
ffff800000104114:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
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
ffff800000104210:	48 b8 77 c7 10 00 00 	movabs $0xffff80000010c777,%rax
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
ffff80000010423a:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
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
ffff800000104264:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
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
ffff8000001042bd:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001042c4:	80 ff ff 
ffff8000001042c7:	ff d0                	call   *%rax
  if(kmem.use_lock)
ffff8000001042c9:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001042d0:	80 ff ff 
ffff8000001042d3:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001042d6:	85 c0                	test   %eax,%eax
ffff8000001042d8:	74 58                	je     ffff800000104332 <kfree+0x165>
    traceevent(TRACE_TYPE_MEM, proc ? proc->pid : 0, V2P(v), 0, 0, "kfree");
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
ffff800000104305:	48 ba 77 c7 10 00 00 	movabs $0xffff80000010c777,%rdx
ffff80000010430c:	80 ff ff 
ffff80000010430f:	49 89 d1             	mov    %rdx,%r9
ffff800000104312:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffff800000104318:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff80000010431d:	89 f2                	mov    %esi,%edx
ffff80000010431f:	89 c6                	mov    %eax,%esi
ffff800000104321:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104326:	48 b8 c4 c1 10 00 00 	movabs $0xffff80000010c1c4,%rax
ffff80000010432d:	80 ff ff 
ffff800000104330:	ff d0                	call   *%rax
}
ffff800000104332:	90                   	nop
ffff800000104333:	c9                   	leave
ffff800000104334:	c3                   	ret

ffff800000104335 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
ffff800000104335:	55                   	push   %rbp
ffff800000104336:	48 89 e5             	mov    %rsp,%rbp
ffff800000104339:	48 83 ec 10          	sub    $0x10,%rsp
  struct run *r;

  if(kmem.use_lock)
ffff80000010433d:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff800000104344:	80 ff ff 
ffff800000104347:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010434a:	85 c0                	test   %eax,%eax
ffff80000010434c:	74 19                	je     ffff800000104367 <kalloc+0x32>
    acquire(&kmem.lock);
ffff80000010434e:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff800000104355:	80 ff ff 
ffff800000104358:	48 89 c7             	mov    %rax,%rdi
ffff80000010435b:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000104362:	80 ff ff 
ffff800000104365:	ff d0                	call   *%rax
  r = kmem.freelist;
ffff800000104367:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010436e:	80 ff ff 
ffff800000104371:	48 8b 40 70          	mov    0x70(%rax),%rax
ffff800000104375:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(r)
ffff800000104379:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010437e:	74 28                	je     ffff8000001043a8 <kalloc+0x73>
    kmem.freelist = r->next;
ffff800000104380:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000104384:	48 8b 00             	mov    (%rax),%rax
ffff800000104387:	48 ba 40 81 11 00 00 	movabs $0xffff800000118140,%rdx
ffff80000010438e:	80 ff ff 
ffff800000104391:	48 89 42 70          	mov    %rax,0x70(%rdx)
  else {
    panic("Out of memory!");
  }
  
  if(kmem.use_lock)
ffff800000104395:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff80000010439c:	80 ff ff 
ffff80000010439f:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001043a2:	85 c0                	test   %eax,%eax
ffff8000001043a4:	74 34                	je     ffff8000001043da <kalloc+0xa5>
ffff8000001043a6:	eb 19                	jmp    ffff8000001043c1 <kalloc+0x8c>
    panic("Out of memory!");
ffff8000001043a8:	48 b8 7d c7 10 00 00 	movabs $0xffff80000010c77d,%rax
ffff8000001043af:	80 ff ff 
ffff8000001043b2:	48 89 c7             	mov    %rax,%rdi
ffff8000001043b5:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001043bc:	80 ff ff 
ffff8000001043bf:	ff d0                	call   *%rax
    release(&kmem.lock);
ffff8000001043c1:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001043c8:	80 ff ff 
ffff8000001043cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001043ce:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001043d5:	80 ff ff 
ffff8000001043d8:	ff d0                	call   *%rax
  //need to call this conditional again because it uses a lock
  if(kmem.use_lock && r)
ffff8000001043da:	48 b8 40 81 11 00 00 	movabs $0xffff800000118140,%rax
ffff8000001043e1:	80 ff ff 
ffff8000001043e4:	8b 40 68             	mov    0x68(%rax),%eax
ffff8000001043e7:	85 c0                	test   %eax,%eax
ffff8000001043e9:	74 5f                	je     ffff80000010444a <kalloc+0x115>
ffff8000001043eb:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001043f0:	74 58                	je     ffff80000010444a <kalloc+0x115>
    traceevent(TRACE_TYPE_MEM, proc ? proc->pid : 0, V2P((char*)r), 0, 0, "kalloc");
ffff8000001043f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001043f6:	89 c6                	mov    %eax,%esi
ffff8000001043f8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001043ff:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000104403:	48 85 c0             	test   %rax,%rax
ffff800000104406:	74 10                	je     ffff800000104418 <kalloc+0xe3>
ffff800000104408:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010440f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000104413:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000104416:	eb 05                	jmp    ffff80000010441d <kalloc+0xe8>
ffff800000104418:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010441d:	48 ba 8c c7 10 00 00 	movabs $0xffff80000010c78c,%rdx
ffff800000104424:	80 ff ff 
ffff800000104427:	49 89 d1             	mov    %rdx,%r9
ffff80000010442a:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffff800000104430:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000104435:	89 f2                	mov    %esi,%edx
ffff800000104437:	89 c6                	mov    %eax,%esi
ffff800000104439:	bf 04 00 00 00       	mov    $0x4,%edi
ffff80000010443e:	48 b8 c4 c1 10 00 00 	movabs $0xffff80000010c1c4,%rax
ffff800000104445:	80 ff ff 
ffff800000104448:	ff d0                	call   *%rax

  return (char*)r;
ffff80000010444a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff80000010444e:	c9                   	leave
ffff80000010444f:	c3                   	ret

ffff800000104450 <inb>:
ffff800000104450:	55                   	push   %rbp
ffff800000104451:	48 89 e5             	mov    %rsp,%rbp
ffff800000104454:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000104458:	89 f8                	mov    %edi,%eax
ffff80000010445a:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff80000010445e:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104462:	89 c2                	mov    %eax,%edx
ffff800000104464:	ec                   	in     (%dx),%al
ffff800000104465:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff800000104468:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff80000010446c:	c9                   	leave
ffff80000010446d:	c3                   	ret

ffff80000010446e <kbdgetc>:
ffff80000010446e:	55                   	push   %rbp
ffff80000010446f:	48 89 e5             	mov    %rsp,%rbp
ffff800000104472:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000104476:	bf 64 00 00 00       	mov    $0x64,%edi
ffff80000010447b:	48 b8 50 44 10 00 00 	movabs $0xffff800000104450,%rax
ffff800000104482:	80 ff ff 
ffff800000104485:	ff d0                	call   *%rax
ffff800000104487:	0f b6 c0             	movzbl %al,%eax
ffff80000010448a:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff80000010448d:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104490:	83 e0 01             	and    $0x1,%eax
ffff800000104493:	85 c0                	test   %eax,%eax
ffff800000104495:	75 0a                	jne    ffff8000001044a1 <kbdgetc+0x33>
ffff800000104497:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010449c:	e9 a4 01 00 00       	jmp    ffff800000104645 <kbdgetc+0x1d7>
ffff8000001044a1:	bf 60 00 00 00       	mov    $0x60,%edi
ffff8000001044a6:	48 b8 50 44 10 00 00 	movabs $0xffff800000104450,%rax
ffff8000001044ad:	80 ff ff 
ffff8000001044b0:	ff d0                	call   *%rax
ffff8000001044b2:	0f b6 c0             	movzbl %al,%eax
ffff8000001044b5:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001044b8:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%rbp)
ffff8000001044bf:	75 27                	jne    ffff8000001044e8 <kbdgetc+0x7a>
ffff8000001044c1:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001044c8:	80 ff ff 
ffff8000001044cb:	8b 00                	mov    (%rax),%eax
ffff8000001044cd:	83 c8 40             	or     $0x40,%eax
ffff8000001044d0:	89 c2                	mov    %eax,%edx
ffff8000001044d2:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001044d9:	80 ff ff 
ffff8000001044dc:	89 10                	mov    %edx,(%rax)
ffff8000001044de:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001044e3:	e9 5d 01 00 00       	jmp    ffff800000104645 <kbdgetc+0x1d7>
ffff8000001044e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001044eb:	25 80 00 00 00       	and    $0x80,%eax
ffff8000001044f0:	85 c0                	test   %eax,%eax
ffff8000001044f2:	74 56                	je     ffff80000010454a <kbdgetc+0xdc>
ffff8000001044f4:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001044fb:	80 ff ff 
ffff8000001044fe:	8b 00                	mov    (%rax),%eax
ffff800000104500:	83 e0 40             	and    $0x40,%eax
ffff800000104503:	85 c0                	test   %eax,%eax
ffff800000104505:	75 04                	jne    ffff80000010450b <kbdgetc+0x9d>
ffff800000104507:	83 65 fc 7f          	andl   $0x7f,-0x4(%rbp)
ffff80000010450b:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104512:	80 ff ff 
ffff800000104515:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104518:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff80000010451c:	83 c8 40             	or     $0x40,%eax
ffff80000010451f:	0f b6 c0             	movzbl %al,%eax
ffff800000104522:	f7 d0                	not    %eax
ffff800000104524:	89 c2                	mov    %eax,%edx
ffff800000104526:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010452d:	80 ff ff 
ffff800000104530:	8b 00                	mov    (%rax),%eax
ffff800000104532:	21 c2                	and    %eax,%edx
ffff800000104534:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010453b:	80 ff ff 
ffff80000010453e:	89 10                	mov    %edx,(%rax)
ffff800000104540:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104545:	e9 fb 00 00 00       	jmp    ffff800000104645 <kbdgetc+0x1d7>
ffff80000010454a:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104551:	80 ff ff 
ffff800000104554:	8b 00                	mov    (%rax),%eax
ffff800000104556:	83 e0 40             	and    $0x40,%eax
ffff800000104559:	85 c0                	test   %eax,%eax
ffff80000010455b:	74 24                	je     ffff800000104581 <kbdgetc+0x113>
ffff80000010455d:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%rbp)
ffff800000104564:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010456b:	80 ff ff 
ffff80000010456e:	8b 00                	mov    (%rax),%eax
ffff800000104570:	83 e0 bf             	and    $0xffffffbf,%eax
ffff800000104573:	89 c2                	mov    %eax,%edx
ffff800000104575:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010457c:	80 ff ff 
ffff80000010457f:	89 10                	mov    %edx,(%rax)
ffff800000104581:	48 ba 20 d0 10 00 00 	movabs $0xffff80000010d020,%rdx
ffff800000104588:	80 ff ff 
ffff80000010458b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010458e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff800000104592:	0f b6 d0             	movzbl %al,%edx
ffff800000104595:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff80000010459c:	80 ff ff 
ffff80000010459f:	8b 00                	mov    (%rax),%eax
ffff8000001045a1:	09 c2                	or     %eax,%edx
ffff8000001045a3:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045aa:	80 ff ff 
ffff8000001045ad:	89 10                	mov    %edx,(%rax)
ffff8000001045af:	48 ba 20 d1 10 00 00 	movabs $0xffff80000010d120,%rdx
ffff8000001045b6:	80 ff ff 
ffff8000001045b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001045bc:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
ffff8000001045c0:	0f b6 d0             	movzbl %al,%edx
ffff8000001045c3:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045ca:	80 ff ff 
ffff8000001045cd:	8b 00                	mov    (%rax),%eax
ffff8000001045cf:	31 c2                	xor    %eax,%edx
ffff8000001045d1:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045d8:	80 ff ff 
ffff8000001045db:	89 10                	mov    %edx,(%rax)
ffff8000001045dd:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff8000001045e4:	80 ff ff 
ffff8000001045e7:	8b 00                	mov    (%rax),%eax
ffff8000001045e9:	83 e0 03             	and    $0x3,%eax
ffff8000001045ec:	89 c2                	mov    %eax,%edx
ffff8000001045ee:	48 b8 20 d5 10 00 00 	movabs $0xffff80000010d520,%rax
ffff8000001045f5:	80 ff ff 
ffff8000001045f8:	89 d2                	mov    %edx,%edx
ffff8000001045fa:	48 8b 14 d0          	mov    (%rax,%rdx,8),%rdx
ffff8000001045fe:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104601:	48 01 d0             	add    %rdx,%rax
ffff800000104604:	0f b6 00             	movzbl (%rax),%eax
ffff800000104607:	0f b6 c0             	movzbl %al,%eax
ffff80000010460a:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010460d:	48 b8 b8 81 11 00 00 	movabs $0xffff8000001181b8,%rax
ffff800000104614:	80 ff ff 
ffff800000104617:	8b 00                	mov    (%rax),%eax
ffff800000104619:	83 e0 08             	and    $0x8,%eax
ffff80000010461c:	85 c0                	test   %eax,%eax
ffff80000010461e:	74 22                	je     ffff800000104642 <kbdgetc+0x1d4>
ffff800000104620:	83 7d f8 60          	cmpl   $0x60,-0x8(%rbp)
ffff800000104624:	76 0c                	jbe    ffff800000104632 <kbdgetc+0x1c4>
ffff800000104626:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%rbp)
ffff80000010462a:	77 06                	ja     ffff800000104632 <kbdgetc+0x1c4>
ffff80000010462c:	83 6d f8 20          	subl   $0x20,-0x8(%rbp)
ffff800000104630:	eb 10                	jmp    ffff800000104642 <kbdgetc+0x1d4>
ffff800000104632:	83 7d f8 40          	cmpl   $0x40,-0x8(%rbp)
ffff800000104636:	76 0a                	jbe    ffff800000104642 <kbdgetc+0x1d4>
ffff800000104638:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%rbp)
ffff80000010463c:	77 04                	ja     ffff800000104642 <kbdgetc+0x1d4>
ffff80000010463e:	83 45 f8 20          	addl   $0x20,-0x8(%rbp)
ffff800000104642:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff800000104645:	c9                   	leave
ffff800000104646:	c3                   	ret

ffff800000104647 <kbdintr>:
ffff800000104647:	55                   	push   %rbp
ffff800000104648:	48 89 e5             	mov    %rsp,%rbp
ffff80000010464b:	48 b8 6e 44 10 00 00 	movabs $0xffff80000010446e,%rax
ffff800000104652:	80 ff ff 
ffff800000104655:	48 89 c7             	mov    %rax,%rdi
ffff800000104658:	48 b8 97 10 10 00 00 	movabs $0xffff800000101097,%rax
ffff80000010465f:	80 ff ff 
ffff800000104662:	ff d0                	call   *%rax
ffff800000104664:	90                   	nop
ffff800000104665:	5d                   	pop    %rbp
ffff800000104666:	c3                   	ret

ffff800000104667 <inb>:
ffff800000104667:	55                   	push   %rbp
ffff800000104668:	48 89 e5             	mov    %rsp,%rbp
ffff80000010466b:	48 83 ec 18          	sub    $0x18,%rsp
ffff80000010466f:	89 f8                	mov    %edi,%eax
ffff800000104671:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff800000104675:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000104679:	89 c2                	mov    %eax,%edx
ffff80000010467b:	ec                   	in     (%dx),%al
ffff80000010467c:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff80000010467f:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff800000104683:	c9                   	leave
ffff800000104684:	c3                   	ret

ffff800000104685 <outb>:
ffff800000104685:	55                   	push   %rbp
ffff800000104686:	48 89 e5             	mov    %rsp,%rbp
ffff800000104689:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010468d:	89 fa                	mov    %edi,%edx
ffff80000010468f:	89 f0                	mov    %esi,%eax
ffff800000104691:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff800000104695:	88 45 f8             	mov    %al,-0x8(%rbp)
ffff800000104698:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010469c:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff8000001046a0:	ee                   	out    %al,(%dx)
ffff8000001046a1:	90                   	nop
ffff8000001046a2:	c9                   	leave
ffff8000001046a3:	c3                   	ret

ffff8000001046a4 <readeflags>:
ffff8000001046a4:	55                   	push   %rbp
ffff8000001046a5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046a8:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001046ac:	9c                   	pushf
ffff8000001046ad:	58                   	pop    %rax
ffff8000001046ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001046b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001046b6:	c9                   	leave
ffff8000001046b7:	c3                   	ret

ffff8000001046b8 <lapicw>:
ffff8000001046b8:	55                   	push   %rbp
ffff8000001046b9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046bc:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001046c0:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001046c3:	89 75 f8             	mov    %esi,-0x8(%rbp)
ffff8000001046c6:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001046cd:	80 ff ff 
ffff8000001046d0:	48 8b 00             	mov    (%rax),%rax
ffff8000001046d3:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001046d6:	48 63 d2             	movslq %edx,%rdx
ffff8000001046d9:	48 c1 e2 02          	shl    $0x2,%rdx
ffff8000001046dd:	48 01 c2             	add    %rax,%rdx
ffff8000001046e0:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001046e3:	89 02                	mov    %eax,(%rdx)
ffff8000001046e5:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001046ec:	80 ff ff 
ffff8000001046ef:	48 8b 00             	mov    (%rax),%rax
ffff8000001046f2:	48 83 c0 20          	add    $0x20,%rax
ffff8000001046f6:	8b 00                	mov    (%rax),%eax
ffff8000001046f8:	90                   	nop
ffff8000001046f9:	c9                   	leave
ffff8000001046fa:	c3                   	ret

ffff8000001046fb <lapicinit>:
ffff8000001046fb:	55                   	push   %rbp
ffff8000001046fc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001046ff:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000104706:	80 ff ff 
ffff800000104709:	48 8b 00             	mov    (%rax),%rax
ffff80000010470c:	48 85 c0             	test   %rax,%rax
ffff80000010470f:	0f 84 71 01 00 00    	je     ffff800000104886 <lapicinit+0x18b>
ffff800000104715:	be 3f 01 00 00       	mov    $0x13f,%esi
ffff80000010471a:	bf 3c 00 00 00       	mov    $0x3c,%edi
ffff80000010471f:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104726:	80 ff ff 
ffff800000104729:	ff d0                	call   *%rax
ffff80000010472b:	be 0b 00 00 00       	mov    $0xb,%esi
ffff800000104730:	bf f8 00 00 00       	mov    $0xf8,%edi
ffff800000104735:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff80000010473c:	80 ff ff 
ffff80000010473f:	ff d0                	call   *%rax
ffff800000104741:	be 20 00 02 00       	mov    $0x20020,%esi
ffff800000104746:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff80000010474b:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104752:	80 ff ff 
ffff800000104755:	ff d0                	call   *%rax
ffff800000104757:	be 80 96 98 00       	mov    $0x989680,%esi
ffff80000010475c:	bf e0 00 00 00       	mov    $0xe0,%edi
ffff800000104761:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104768:	80 ff ff 
ffff80000010476b:	ff d0                	call   *%rax
ffff80000010476d:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104772:	bf d4 00 00 00       	mov    $0xd4,%edi
ffff800000104777:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff80000010477e:	80 ff ff 
ffff800000104781:	ff d0                	call   *%rax
ffff800000104783:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000104788:	bf d8 00 00 00       	mov    $0xd8,%edi
ffff80000010478d:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104794:	80 ff ff 
ffff800000104797:	ff d0                	call   *%rax
ffff800000104799:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001047a0:	80 ff ff 
ffff8000001047a3:	48 8b 00             	mov    (%rax),%rax
ffff8000001047a6:	48 83 c0 30          	add    $0x30,%rax
ffff8000001047aa:	8b 00                	mov    (%rax),%eax
ffff8000001047ac:	25 00 00 fc 00       	and    $0xfc0000,%eax
ffff8000001047b1:	85 c0                	test   %eax,%eax
ffff8000001047b3:	74 16                	je     ffff8000001047cb <lapicinit+0xd0>
ffff8000001047b5:	be 00 00 01 00       	mov    $0x10000,%esi
ffff8000001047ba:	bf d0 00 00 00       	mov    $0xd0,%edi
ffff8000001047bf:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff8000001047c6:	80 ff ff 
ffff8000001047c9:	ff d0                	call   *%rax
ffff8000001047cb:	be 33 00 00 00       	mov    $0x33,%esi
ffff8000001047d0:	bf dc 00 00 00       	mov    $0xdc,%edi
ffff8000001047d5:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff8000001047dc:	80 ff ff 
ffff8000001047df:	ff d0                	call   *%rax
ffff8000001047e1:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047e6:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff8000001047eb:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff8000001047f2:	80 ff ff 
ffff8000001047f5:	ff d0                	call   *%rax
ffff8000001047f7:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001047fc:	bf a0 00 00 00       	mov    $0xa0,%edi
ffff800000104801:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104808:	80 ff ff 
ffff80000010480b:	ff d0                	call   *%rax
ffff80000010480d:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104812:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff800000104817:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff80000010481e:	80 ff ff 
ffff800000104821:	ff d0                	call   *%rax
ffff800000104823:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104828:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff80000010482d:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104834:	80 ff ff 
ffff800000104837:	ff d0                	call   *%rax
ffff800000104839:	be 00 85 08 00       	mov    $0x88500,%esi
ffff80000010483e:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104843:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff80000010484a:	80 ff ff 
ffff80000010484d:	ff d0                	call   *%rax
ffff80000010484f:	90                   	nop
ffff800000104850:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000104857:	80 ff ff 
ffff80000010485a:	48 8b 00             	mov    (%rax),%rax
ffff80000010485d:	48 05 00 03 00 00    	add    $0x300,%rax
ffff800000104863:	8b 00                	mov    (%rax),%eax
ffff800000104865:	25 00 10 00 00       	and    $0x1000,%eax
ffff80000010486a:	85 c0                	test   %eax,%eax
ffff80000010486c:	75 e2                	jne    ffff800000104850 <lapicinit+0x155>
ffff80000010486e:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000104873:	bf 20 00 00 00       	mov    $0x20,%edi
ffff800000104878:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff80000010487f:	80 ff ff 
ffff800000104882:	ff d0                	call   *%rax
ffff800000104884:	eb 01                	jmp    ffff800000104887 <lapicinit+0x18c>
ffff800000104886:	90                   	nop
ffff800000104887:	5d                   	pop    %rbp
ffff800000104888:	c3                   	ret

ffff800000104889 <cpunum>:
ffff800000104889:	55                   	push   %rbp
ffff80000010488a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010488d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000104891:	48 b8 a4 46 10 00 00 	movabs $0xffff8000001046a4,%rax
ffff800000104898:	80 ff ff 
ffff80000010489b:	ff d0                	call   *%rax
ffff80000010489d:	25 00 02 00 00       	and    $0x200,%eax
ffff8000001048a2:	48 85 c0             	test   %rax,%rax
ffff8000001048a5:	74 47                	je     ffff8000001048ee <cpunum+0x65>
ffff8000001048a7:	48 b8 c8 81 11 00 00 	movabs $0xffff8000001181c8,%rax
ffff8000001048ae:	80 ff ff 
ffff8000001048b1:	8b 00                	mov    (%rax),%eax
ffff8000001048b3:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001048b6:	48 b9 c8 81 11 00 00 	movabs $0xffff8000001181c8,%rcx
ffff8000001048bd:	80 ff ff 
ffff8000001048c0:	89 11                	mov    %edx,(%rcx)
ffff8000001048c2:	85 c0                	test   %eax,%eax
ffff8000001048c4:	75 28                	jne    ffff8000001048ee <cpunum+0x65>
ffff8000001048c6:	48 8b 45 08          	mov    0x8(%rbp),%rax
ffff8000001048ca:	48 89 c2             	mov    %rax,%rdx
ffff8000001048cd:	48 b8 98 c7 10 00 00 	movabs $0xffff80000010c798,%rax
ffff8000001048d4:	80 ff ff 
ffff8000001048d7:	48 89 d6             	mov    %rdx,%rsi
ffff8000001048da:	48 89 c7             	mov    %rax,%rdi
ffff8000001048dd:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001048e2:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001048e9:	80 ff ff 
ffff8000001048ec:	ff d2                	call   *%rdx
ffff8000001048ee:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff8000001048f5:	80 ff ff 
ffff8000001048f8:	48 8b 00             	mov    (%rax),%rax
ffff8000001048fb:	48 85 c0             	test   %rax,%rax
ffff8000001048fe:	75 0a                	jne    ffff80000010490a <cpunum+0x81>
ffff800000104900:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000104905:	e9 85 00 00 00       	jmp    ffff80000010498f <cpunum+0x106>
ffff80000010490a:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000104911:	80 ff ff 
ffff800000104914:	48 8b 00             	mov    (%rax),%rax
ffff800000104917:	48 83 c0 20          	add    $0x20,%rax
ffff80000010491b:	8b 00                	mov    (%rax),%eax
ffff80000010491d:	c1 e8 18             	shr    $0x18,%eax
ffff800000104920:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff800000104923:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010492a:	eb 39                	jmp    ffff800000104965 <cpunum+0xdc>
ffff80000010492c:	48 b9 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rcx
ffff800000104933:	80 ff ff 
ffff800000104936:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104939:	48 63 d0             	movslq %eax,%rdx
ffff80000010493c:	48 89 d0             	mov    %rdx,%rax
ffff80000010493f:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000104943:	48 01 d0             	add    %rdx,%rax
ffff800000104946:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010494a:	48 01 c8             	add    %rcx,%rax
ffff80000010494d:	48 83 c0 01          	add    $0x1,%rax
ffff800000104951:	0f b6 00             	movzbl (%rax),%eax
ffff800000104954:	0f b6 c0             	movzbl %al,%eax
ffff800000104957:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010495a:	75 05                	jne    ffff800000104961 <cpunum+0xd8>
ffff80000010495c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010495f:	eb 2e                	jmp    ffff80000010498f <cpunum+0x106>
ffff800000104961:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104965:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff80000010496c:	80 ff ff 
ffff80000010496f:	8b 00                	mov    (%rax),%eax
ffff800000104971:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104974:	7c b6                	jl     ffff80000010492c <cpunum+0xa3>
ffff800000104976:	48 b8 c4 c7 10 00 00 	movabs $0xffff80000010c7c4,%rax
ffff80000010497d:	80 ff ff 
ffff800000104980:	48 89 c7             	mov    %rax,%rdi
ffff800000104983:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010498a:	80 ff ff 
ffff80000010498d:	ff d0                	call   *%rax
ffff80000010498f:	c9                   	leave
ffff800000104990:	c3                   	ret

ffff800000104991 <lapiceoi>:
ffff800000104991:	55                   	push   %rbp
ffff800000104992:	48 89 e5             	mov    %rsp,%rbp
ffff800000104995:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff80000010499c:	80 ff ff 
ffff80000010499f:	48 8b 00             	mov    (%rax),%rax
ffff8000001049a2:	48 85 c0             	test   %rax,%rax
ffff8000001049a5:	74 16                	je     ffff8000001049bd <lapiceoi+0x2c>
ffff8000001049a7:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001049ac:	bf 2c 00 00 00       	mov    $0x2c,%edi
ffff8000001049b1:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff8000001049b8:	80 ff ff 
ffff8000001049bb:	ff d0                	call   *%rax
ffff8000001049bd:	90                   	nop
ffff8000001049be:	5d                   	pop    %rbp
ffff8000001049bf:	c3                   	ret

ffff8000001049c0 <microdelay>:
ffff8000001049c0:	55                   	push   %rbp
ffff8000001049c1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049c4:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001049c8:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff8000001049cb:	90                   	nop
ffff8000001049cc:	c9                   	leave
ffff8000001049cd:	c3                   	ret

ffff8000001049ce <lapicstartap>:
ffff8000001049ce:	55                   	push   %rbp
ffff8000001049cf:	48 89 e5             	mov    %rsp,%rbp
ffff8000001049d2:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001049d6:	89 f8                	mov    %edi,%eax
ffff8000001049d8:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff8000001049db:	88 45 ec             	mov    %al,-0x14(%rbp)
ffff8000001049de:	be 0f 00 00 00       	mov    $0xf,%esi
ffff8000001049e3:	bf 70 00 00 00       	mov    $0x70,%edi
ffff8000001049e8:	48 b8 85 46 10 00 00 	movabs $0xffff800000104685,%rax
ffff8000001049ef:	80 ff ff 
ffff8000001049f2:	ff d0                	call   *%rax
ffff8000001049f4:	be 0a 00 00 00       	mov    $0xa,%esi
ffff8000001049f9:	bf 71 00 00 00       	mov    $0x71,%edi
ffff8000001049fe:	48 b8 85 46 10 00 00 	movabs $0xffff800000104685,%rax
ffff800000104a05:	80 ff ff 
ffff800000104a08:	ff d0                	call   *%rax
ffff800000104a0a:	48 b8 67 04 00 00 00 	movabs $0xffff800000000467,%rax
ffff800000104a11:	80 ff ff 
ffff800000104a14:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000104a18:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104a1c:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff800000104a21:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104a24:	c1 e8 04             	shr    $0x4,%eax
ffff800000104a27:	89 c2                	mov    %eax,%edx
ffff800000104a29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104a2d:	48 83 c0 02          	add    $0x2,%rax
ffff800000104a31:	66 89 10             	mov    %dx,(%rax)
ffff800000104a34:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104a38:	c1 e0 18             	shl    $0x18,%eax
ffff800000104a3b:	89 c6                	mov    %eax,%esi
ffff800000104a3d:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104a42:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104a49:	80 ff ff 
ffff800000104a4c:	ff d0                	call   *%rax
ffff800000104a4e:	be 00 c5 00 00       	mov    $0xc500,%esi
ffff800000104a53:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a58:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104a5f:	80 ff ff 
ffff800000104a62:	ff d0                	call   *%rax
ffff800000104a64:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104a69:	48 b8 c0 49 10 00 00 	movabs $0xffff8000001049c0,%rax
ffff800000104a70:	80 ff ff 
ffff800000104a73:	ff d0                	call   *%rax
ffff800000104a75:	be 00 85 00 00       	mov    $0x8500,%esi
ffff800000104a7a:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104a7f:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104a86:	80 ff ff 
ffff800000104a89:	ff d0                	call   *%rax
ffff800000104a8b:	bf 64 00 00 00       	mov    $0x64,%edi
ffff800000104a90:	48 b8 c0 49 10 00 00 	movabs $0xffff8000001049c0,%rax
ffff800000104a97:	80 ff ff 
ffff800000104a9a:	ff d0                	call   *%rax
ffff800000104a9c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104aa3:	eb 4b                	jmp    ffff800000104af0 <lapicstartap+0x122>
ffff800000104aa5:	0f b6 45 ec          	movzbl -0x14(%rbp),%eax
ffff800000104aa9:	c1 e0 18             	shl    $0x18,%eax
ffff800000104aac:	89 c6                	mov    %eax,%esi
ffff800000104aae:	bf c4 00 00 00       	mov    $0xc4,%edi
ffff800000104ab3:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104aba:	80 ff ff 
ffff800000104abd:	ff d0                	call   *%rax
ffff800000104abf:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104ac2:	c1 e8 0c             	shr    $0xc,%eax
ffff800000104ac5:	80 cc 06             	or     $0x6,%ah
ffff800000104ac8:	89 c6                	mov    %eax,%esi
ffff800000104aca:	bf c0 00 00 00       	mov    $0xc0,%edi
ffff800000104acf:	48 b8 b8 46 10 00 00 	movabs $0xffff8000001046b8,%rax
ffff800000104ad6:	80 ff ff 
ffff800000104ad9:	ff d0                	call   *%rax
ffff800000104adb:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104ae0:	48 b8 c0 49 10 00 00 	movabs $0xffff8000001049c0,%rax
ffff800000104ae7:	80 ff ff 
ffff800000104aea:	ff d0                	call   *%rax
ffff800000104aec:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104af0:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000104af4:	7e af                	jle    ffff800000104aa5 <lapicstartap+0xd7>
ffff800000104af6:	90                   	nop
ffff800000104af7:	90                   	nop
ffff800000104af8:	c9                   	leave
ffff800000104af9:	c3                   	ret

ffff800000104afa <cmos_read>:
ffff800000104afa:	55                   	push   %rbp
ffff800000104afb:	48 89 e5             	mov    %rsp,%rbp
ffff800000104afe:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104b02:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff800000104b05:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104b08:	0f b6 c0             	movzbl %al,%eax
ffff800000104b0b:	89 c6                	mov    %eax,%esi
ffff800000104b0d:	bf 70 00 00 00       	mov    $0x70,%edi
ffff800000104b12:	48 b8 85 46 10 00 00 	movabs $0xffff800000104685,%rax
ffff800000104b19:	80 ff ff 
ffff800000104b1c:	ff d0                	call   *%rax
ffff800000104b1e:	bf c8 00 00 00       	mov    $0xc8,%edi
ffff800000104b23:	48 b8 c0 49 10 00 00 	movabs $0xffff8000001049c0,%rax
ffff800000104b2a:	80 ff ff 
ffff800000104b2d:	ff d0                	call   *%rax
ffff800000104b2f:	bf 71 00 00 00       	mov    $0x71,%edi
ffff800000104b34:	48 b8 67 46 10 00 00 	movabs $0xffff800000104667,%rax
ffff800000104b3b:	80 ff ff 
ffff800000104b3e:	ff d0                	call   *%rax
ffff800000104b40:	0f b6 c0             	movzbl %al,%eax
ffff800000104b43:	c9                   	leave
ffff800000104b44:	c3                   	ret

ffff800000104b45 <fill_rtcdate>:
ffff800000104b45:	55                   	push   %rbp
ffff800000104b46:	48 89 e5             	mov    %rsp,%rbp
ffff800000104b49:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000104b4d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000104b51:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000104b56:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104b5d:	80 ff ff 
ffff800000104b60:	ff d0                	call   *%rax
ffff800000104b62:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b66:	89 02                	mov    %eax,(%rdx)
ffff800000104b68:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000104b6d:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104b74:	80 ff ff 
ffff800000104b77:	ff d0                	call   *%rax
ffff800000104b79:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b7d:	89 42 04             	mov    %eax,0x4(%rdx)
ffff800000104b80:	bf 04 00 00 00       	mov    $0x4,%edi
ffff800000104b85:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104b8c:	80 ff ff 
ffff800000104b8f:	ff d0                	call   *%rax
ffff800000104b91:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104b95:	89 42 08             	mov    %eax,0x8(%rdx)
ffff800000104b98:	bf 07 00 00 00       	mov    $0x7,%edi
ffff800000104b9d:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104ba4:	80 ff ff 
ffff800000104ba7:	ff d0                	call   *%rax
ffff800000104ba9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bad:	89 42 0c             	mov    %eax,0xc(%rdx)
ffff800000104bb0:	bf 08 00 00 00       	mov    $0x8,%edi
ffff800000104bb5:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104bbc:	80 ff ff 
ffff800000104bbf:	ff d0                	call   *%rax
ffff800000104bc1:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bc5:	89 42 10             	mov    %eax,0x10(%rdx)
ffff800000104bc8:	bf 09 00 00 00       	mov    $0x9,%edi
ffff800000104bcd:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104bd4:	80 ff ff 
ffff800000104bd7:	ff d0                	call   *%rax
ffff800000104bd9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000104bdd:	89 42 14             	mov    %eax,0x14(%rdx)
ffff800000104be0:	90                   	nop
ffff800000104be1:	c9                   	leave
ffff800000104be2:	c3                   	ret

ffff800000104be3 <cmostime>:
ffff800000104be3:	55                   	push   %rbp
ffff800000104be4:	48 89 e5             	mov    %rsp,%rbp
ffff800000104be7:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000104beb:	48 89 7d b8          	mov    %rdi,-0x48(%rbp)
ffff800000104bef:	bf 0b 00 00 00       	mov    $0xb,%edi
ffff800000104bf4:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104bfb:	80 ff ff 
ffff800000104bfe:	ff d0                	call   *%rax
ffff800000104c00:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000104c03:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104c06:	83 e0 04             	and    $0x4,%eax
ffff800000104c09:	c1 e8 02             	shr    $0x2,%eax
ffff800000104c0c:	83 e0 01             	and    $0x1,%eax
ffff800000104c0f:	83 f0 01             	xor    $0x1,%eax
ffff800000104c12:	0f b6 c0             	movzbl %al,%eax
ffff800000104c15:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff800000104c18:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104c1c:	48 89 c7             	mov    %rax,%rdi
ffff800000104c1f:	48 b8 45 4b 10 00 00 	movabs $0xffff800000104b45,%rax
ffff800000104c26:	80 ff ff 
ffff800000104c29:	ff d0                	call   *%rax
ffff800000104c2b:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff800000104c30:	48 b8 fa 4a 10 00 00 	movabs $0xffff800000104afa,%rax
ffff800000104c37:	80 ff ff 
ffff800000104c3a:	ff d0                	call   *%rax
ffff800000104c3c:	25 80 00 00 00       	and    $0x80,%eax
ffff800000104c41:	85 c0                	test   %eax,%eax
ffff800000104c43:	75 38                	jne    ffff800000104c7d <cmostime+0x9a>
ffff800000104c45:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
ffff800000104c49:	48 89 c7             	mov    %rax,%rdi
ffff800000104c4c:	48 b8 45 4b 10 00 00 	movabs $0xffff800000104b45,%rax
ffff800000104c53:	80 ff ff 
ffff800000104c56:	ff d0                	call   *%rax
ffff800000104c58:	48 8d 4d c0          	lea    -0x40(%rbp),%rcx
ffff800000104c5c:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000104c60:	ba 18 00 00 00       	mov    $0x18,%edx
ffff800000104c65:	48 89 ce             	mov    %rcx,%rsi
ffff800000104c68:	48 89 c7             	mov    %rax,%rdi
ffff800000104c6b:	48 b8 04 7b 10 00 00 	movabs $0xffff800000107b04,%rax
ffff800000104c72:	80 ff ff 
ffff800000104c75:	ff d0                	call   *%rax
ffff800000104c77:	85 c0                	test   %eax,%eax
ffff800000104c79:	74 05                	je     ffff800000104c80 <cmostime+0x9d>
ffff800000104c7b:	eb 9b                	jmp    ffff800000104c18 <cmostime+0x35>
ffff800000104c7d:	90                   	nop
ffff800000104c7e:	eb 98                	jmp    ffff800000104c18 <cmostime+0x35>
ffff800000104c80:	90                   	nop
ffff800000104c81:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000104c85:	0f 84 b4 00 00 00    	je     ffff800000104d3f <cmostime+0x15c>
ffff800000104c8b:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104c8e:	c1 e8 04             	shr    $0x4,%eax
ffff800000104c91:	89 c2                	mov    %eax,%edx
ffff800000104c93:	89 d0                	mov    %edx,%eax
ffff800000104c95:	c1 e0 02             	shl    $0x2,%eax
ffff800000104c98:	01 d0                	add    %edx,%eax
ffff800000104c9a:	01 c0                	add    %eax,%eax
ffff800000104c9c:	89 c2                	mov    %eax,%edx
ffff800000104c9e:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000104ca1:	83 e0 0f             	and    $0xf,%eax
ffff800000104ca4:	01 d0                	add    %edx,%eax
ffff800000104ca6:	89 45 e0             	mov    %eax,-0x20(%rbp)
ffff800000104ca9:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104cac:	c1 e8 04             	shr    $0x4,%eax
ffff800000104caf:	89 c2                	mov    %eax,%edx
ffff800000104cb1:	89 d0                	mov    %edx,%eax
ffff800000104cb3:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cb6:	01 d0                	add    %edx,%eax
ffff800000104cb8:	01 c0                	add    %eax,%eax
ffff800000104cba:	89 c2                	mov    %eax,%edx
ffff800000104cbc:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000104cbf:	83 e0 0f             	and    $0xf,%eax
ffff800000104cc2:	01 d0                	add    %edx,%eax
ffff800000104cc4:	89 45 e4             	mov    %eax,-0x1c(%rbp)
ffff800000104cc7:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104cca:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ccd:	89 c2                	mov    %eax,%edx
ffff800000104ccf:	89 d0                	mov    %edx,%eax
ffff800000104cd1:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cd4:	01 d0                	add    %edx,%eax
ffff800000104cd6:	01 c0                	add    %eax,%eax
ffff800000104cd8:	89 c2                	mov    %eax,%edx
ffff800000104cda:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000104cdd:	83 e0 0f             	and    $0xf,%eax
ffff800000104ce0:	01 d0                	add    %edx,%eax
ffff800000104ce2:	89 45 e8             	mov    %eax,-0x18(%rbp)
ffff800000104ce5:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104ce8:	c1 e8 04             	shr    $0x4,%eax
ffff800000104ceb:	89 c2                	mov    %eax,%edx
ffff800000104ced:	89 d0                	mov    %edx,%eax
ffff800000104cef:	c1 e0 02             	shl    $0x2,%eax
ffff800000104cf2:	01 d0                	add    %edx,%eax
ffff800000104cf4:	01 c0                	add    %eax,%eax
ffff800000104cf6:	89 c2                	mov    %eax,%edx
ffff800000104cf8:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104cfb:	83 e0 0f             	and    $0xf,%eax
ffff800000104cfe:	01 d0                	add    %edx,%eax
ffff800000104d00:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000104d03:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104d06:	c1 e8 04             	shr    $0x4,%eax
ffff800000104d09:	89 c2                	mov    %eax,%edx
ffff800000104d0b:	89 d0                	mov    %edx,%eax
ffff800000104d0d:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d10:	01 d0                	add    %edx,%eax
ffff800000104d12:	01 c0                	add    %eax,%eax
ffff800000104d14:	89 c2                	mov    %eax,%edx
ffff800000104d16:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104d19:	83 e0 0f             	and    $0xf,%eax
ffff800000104d1c:	01 d0                	add    %edx,%eax
ffff800000104d1e:	89 45 f0             	mov    %eax,-0x10(%rbp)
ffff800000104d21:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104d24:	c1 e8 04             	shr    $0x4,%eax
ffff800000104d27:	89 c2                	mov    %eax,%edx
ffff800000104d29:	89 d0                	mov    %edx,%eax
ffff800000104d2b:	c1 e0 02             	shl    $0x2,%eax
ffff800000104d2e:	01 d0                	add    %edx,%eax
ffff800000104d30:	01 c0                	add    %eax,%eax
ffff800000104d32:	89 c2                	mov    %eax,%edx
ffff800000104d34:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000104d37:	83 e0 0f             	and    $0xf,%eax
ffff800000104d3a:	01 d0                	add    %edx,%eax
ffff800000104d3c:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000104d3f:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
ffff800000104d43:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000104d47:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000104d4b:	48 89 01             	mov    %rax,(%rcx)
ffff800000104d4e:	48 89 51 08          	mov    %rdx,0x8(%rcx)
ffff800000104d52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104d56:	48 89 41 10          	mov    %rax,0x10(%rcx)
ffff800000104d5a:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d5e:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000104d61:	8d 90 d0 07 00 00    	lea    0x7d0(%rax),%edx
ffff800000104d67:	48 8b 45 b8          	mov    -0x48(%rbp),%rax
ffff800000104d6b:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000104d6e:	90                   	nop
ffff800000104d6f:	c9                   	leave
ffff800000104d70:	c3                   	ret

ffff800000104d71 <initlog>:
ffff800000104d71:	55                   	push   %rbp
ffff800000104d72:	48 89 e5             	mov    %rsp,%rbp
ffff800000104d75:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000104d79:	89 7d dc             	mov    %edi,-0x24(%rbp)
ffff800000104d7c:	48 ba d4 c7 10 00 00 	movabs $0xffff80000010c7d4,%rdx
ffff800000104d83:	80 ff ff 
ffff800000104d86:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104d8d:	80 ff ff 
ffff800000104d90:	48 89 d6             	mov    %rdx,%rsi
ffff800000104d93:	48 89 c7             	mov    %rax,%rdi
ffff800000104d96:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000104d9d:	80 ff ff 
ffff800000104da0:	ff d0                	call   *%rax
ffff800000104da2:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000104da6:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104da9:	48 89 d6             	mov    %rdx,%rsi
ffff800000104dac:	89 c7                	mov    %eax,%edi
ffff800000104dae:	48 b8 b9 21 10 00 00 	movabs $0xffff8000001021b9,%rax
ffff800000104db5:	80 ff ff 
ffff800000104db8:	ff d0                	call   *%rax
ffff800000104dba:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000104dbd:	89 c2                	mov    %eax,%edx
ffff800000104dbf:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104dc6:	80 ff ff 
ffff800000104dc9:	89 50 68             	mov    %edx,0x68(%rax)
ffff800000104dcc:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000104dcf:	89 c2                	mov    %eax,%edx
ffff800000104dd1:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104dd8:	80 ff ff 
ffff800000104ddb:	89 50 6c             	mov    %edx,0x6c(%rax)
ffff800000104dde:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000104de5:	80 ff ff 
ffff800000104de8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000104deb:	89 42 78             	mov    %eax,0x78(%rdx)
ffff800000104dee:	48 b8 82 50 10 00 00 	movabs $0xffff800000105082,%rax
ffff800000104df5:	80 ff ff 
ffff800000104df8:	ff d0                	call   *%rax
ffff800000104dfa:	90                   	nop
ffff800000104dfb:	c9                   	leave
ffff800000104dfc:	c3                   	ret

ffff800000104dfd <install_trans>:
ffff800000104dfd:	55                   	push   %rbp
ffff800000104dfe:	48 89 e5             	mov    %rsp,%rbp
ffff800000104e01:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104e05:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104e0c:	e9 dc 00 00 00       	jmp    ffff800000104eed <install_trans+0xf0>
ffff800000104e11:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e18:	80 ff ff 
ffff800000104e1b:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000104e1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000104e21:	01 d0                	add    %edx,%eax
ffff800000104e23:	83 c0 01             	add    $0x1,%eax
ffff800000104e26:	89 c2                	mov    %eax,%edx
ffff800000104e28:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e2f:	80 ff ff 
ffff800000104e32:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e35:	89 d6                	mov    %edx,%esi
ffff800000104e37:	89 c7                	mov    %eax,%edi
ffff800000104e39:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104e40:	80 ff ff 
ffff800000104e43:	ff d0                	call   *%rax
ffff800000104e45:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000104e49:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e50:	80 ff ff 
ffff800000104e53:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104e56:	48 63 d2             	movslq %edx,%rdx
ffff800000104e59:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000104e5d:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000104e61:	89 c2                	mov    %eax,%edx
ffff800000104e63:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104e6a:	80 ff ff 
ffff800000104e6d:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104e70:	89 d6                	mov    %edx,%esi
ffff800000104e72:	89 c7                	mov    %eax,%edi
ffff800000104e74:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104e7b:	80 ff ff 
ffff800000104e7e:	ff d0                	call   *%rax
ffff800000104e80:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000104e84:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104e88:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000104e8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104e93:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104e99:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000104e9e:	48 89 ce             	mov    %rcx,%rsi
ffff800000104ea1:	48 89 c7             	mov    %rax,%rdi
ffff800000104ea4:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000104eab:	80 ff ff 
ffff800000104eae:	ff d0                	call   *%rax
ffff800000104eb0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104eb4:	48 89 c7             	mov    %rax,%rdi
ffff800000104eb7:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000104ebe:	80 ff ff 
ffff800000104ec1:	ff d0                	call   *%rax
ffff800000104ec3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104ec7:	48 89 c7             	mov    %rax,%rdi
ffff800000104eca:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ed1:	80 ff ff 
ffff800000104ed4:	ff d0                	call   *%rax
ffff800000104ed6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104eda:	48 89 c7             	mov    %rax,%rdi
ffff800000104edd:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104ee4:	80 ff ff 
ffff800000104ee7:	ff d0                	call   *%rax
ffff800000104ee9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104eed:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104ef4:	80 ff ff 
ffff800000104ef7:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104efa:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104efd:	0f 8c 0e ff ff ff    	jl     ffff800000104e11 <install_trans+0x14>
ffff800000104f03:	90                   	nop
ffff800000104f04:	90                   	nop
ffff800000104f05:	c9                   	leave
ffff800000104f06:	c3                   	ret

ffff800000104f07 <read_head>:
ffff800000104f07:	55                   	push   %rbp
ffff800000104f08:	48 89 e5             	mov    %rsp,%rbp
ffff800000104f0b:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104f0f:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104f16:	80 ff ff 
ffff800000104f19:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104f1c:	89 c2                	mov    %eax,%edx
ffff800000104f1e:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104f25:	80 ff ff 
ffff800000104f28:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104f2b:	89 d6                	mov    %edx,%esi
ffff800000104f2d:	89 c7                	mov    %eax,%edi
ffff800000104f2f:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104f36:	80 ff ff 
ffff800000104f39:	ff d0                	call   *%rax
ffff800000104f3b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000104f3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104f43:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104f49:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000104f4d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f51:	8b 00                	mov    (%rax),%eax
ffff800000104f53:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000104f5a:	80 ff ff 
ffff800000104f5d:	89 42 7c             	mov    %eax,0x7c(%rdx)
ffff800000104f60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000104f67:	eb 2a                	jmp    ffff800000104f93 <read_head+0x8c>
ffff800000104f69:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000104f6d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000104f70:	48 63 d2             	movslq %edx,%rdx
ffff800000104f73:	8b 44 90 04          	mov    0x4(%rax,%rdx,4),%eax
ffff800000104f77:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000104f7e:	80 ff ff 
ffff800000104f81:	8b 4d fc             	mov    -0x4(%rbp),%ecx
ffff800000104f84:	48 63 c9             	movslq %ecx,%rcx
ffff800000104f87:	48 83 c1 1c          	add    $0x1c,%rcx
ffff800000104f8b:	89 44 8a 10          	mov    %eax,0x10(%rdx,%rcx,4)
ffff800000104f8f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000104f93:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104f9a:	80 ff ff 
ffff800000104f9d:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000104fa0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000104fa3:	7c c4                	jl     ffff800000104f69 <read_head+0x62>
ffff800000104fa5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104fa9:	48 89 c7             	mov    %rax,%rdi
ffff800000104fac:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff800000104fb3:	80 ff ff 
ffff800000104fb6:	ff d0                	call   *%rax
ffff800000104fb8:	90                   	nop
ffff800000104fb9:	c9                   	leave
ffff800000104fba:	c3                   	ret

ffff800000104fbb <write_head>:
ffff800000104fbb:	55                   	push   %rbp
ffff800000104fbc:	48 89 e5             	mov    %rsp,%rbp
ffff800000104fbf:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000104fc3:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104fca:	80 ff ff 
ffff800000104fcd:	8b 40 68             	mov    0x68(%rax),%eax
ffff800000104fd0:	89 c2                	mov    %eax,%edx
ffff800000104fd2:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000104fd9:	80 ff ff 
ffff800000104fdc:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000104fdf:	89 d6                	mov    %edx,%esi
ffff800000104fe1:	89 c7                	mov    %eax,%edi
ffff800000104fe3:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000104fea:	80 ff ff 
ffff800000104fed:	ff d0                	call   *%rax
ffff800000104fef:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000104ff3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000104ff7:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff800000104ffd:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105001:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105008:	80 ff ff 
ffff80000010500b:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff80000010500e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105012:	89 10                	mov    %edx,(%rax)
ffff800000105014:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010501b:	eb 2a                	jmp    ffff800000105047 <write_head+0x8c>
ffff80000010501d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105024:	80 ff ff 
ffff800000105027:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010502a:	48 63 d2             	movslq %edx,%rdx
ffff80000010502d:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105031:	8b 4c 90 10          	mov    0x10(%rax,%rdx,4),%ecx
ffff800000105035:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105039:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010503c:	48 63 d2             	movslq %edx,%rdx
ffff80000010503f:	89 4c 90 04          	mov    %ecx,0x4(%rax,%rdx,4)
ffff800000105043:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105047:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010504e:	80 ff ff 
ffff800000105051:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105054:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105057:	7c c4                	jl     ffff80000010501d <write_head+0x62>
ffff800000105059:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010505d:	48 89 c7             	mov    %rax,%rdi
ffff800000105060:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff800000105067:	80 ff ff 
ffff80000010506a:	ff d0                	call   *%rax
ffff80000010506c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105070:	48 89 c7             	mov    %rax,%rdi
ffff800000105073:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff80000010507a:	80 ff ff 
ffff80000010507d:	ff d0                	call   *%rax
ffff80000010507f:	90                   	nop
ffff800000105080:	c9                   	leave
ffff800000105081:	c3                   	ret

ffff800000105082 <recover_from_log>:
ffff800000105082:	55                   	push   %rbp
ffff800000105083:	48 89 e5             	mov    %rsp,%rbp
ffff800000105086:	48 b8 07 4f 10 00 00 	movabs $0xffff800000104f07,%rax
ffff80000010508d:	80 ff ff 
ffff800000105090:	ff d0                	call   *%rax
ffff800000105092:	48 b8 fd 4d 10 00 00 	movabs $0xffff800000104dfd,%rax
ffff800000105099:	80 ff ff 
ffff80000010509c:	ff d0                	call   *%rax
ffff80000010509e:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050a5:	80 ff ff 
ffff8000001050a8:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
ffff8000001050af:	48 b8 bb 4f 10 00 00 	movabs $0xffff800000104fbb,%rax
ffff8000001050b6:	80 ff ff 
ffff8000001050b9:	ff d0                	call   *%rax
ffff8000001050bb:	90                   	nop
ffff8000001050bc:	5d                   	pop    %rbp
ffff8000001050bd:	c3                   	ret

ffff8000001050be <begin_op>:
ffff8000001050be:	55                   	push   %rbp
ffff8000001050bf:	48 89 e5             	mov    %rsp,%rbp
ffff8000001050c2:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050c9:	80 ff ff 
ffff8000001050cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001050cf:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001050d6:	80 ff ff 
ffff8000001050d9:	ff d0                	call   *%rax
ffff8000001050db:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050e2:	80 ff ff 
ffff8000001050e5:	8b 40 74             	mov    0x74(%rax),%eax
ffff8000001050e8:	85 c0                	test   %eax,%eax
ffff8000001050ea:	74 28                	je     ffff800000105114 <begin_op+0x56>
ffff8000001050ec:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff8000001050f3:	80 ff ff 
ffff8000001050f6:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001050fd:	80 ff ff 
ffff800000105100:	48 89 d6             	mov    %rdx,%rsi
ffff800000105103:	48 89 c7             	mov    %rax,%rdi
ffff800000105106:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff80000010510d:	80 ff ff 
ffff800000105110:	ff d0                	call   *%rax
ffff800000105112:	eb c7                	jmp    ffff8000001050db <begin_op+0x1d>
ffff800000105114:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010511b:	80 ff ff 
ffff80000010511e:	8b 48 7c             	mov    0x7c(%rax),%ecx
ffff800000105121:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105128:	80 ff ff 
ffff80000010512b:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010512e:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105131:	89 d0                	mov    %edx,%eax
ffff800000105133:	c1 e0 02             	shl    $0x2,%eax
ffff800000105136:	01 d0                	add    %edx,%eax
ffff800000105138:	01 c0                	add    %eax,%eax
ffff80000010513a:	01 c8                	add    %ecx,%eax
ffff80000010513c:	83 f8 1e             	cmp    $0x1e,%eax
ffff80000010513f:	7e 2b                	jle    ffff80000010516c <begin_op+0xae>
ffff800000105141:	48 ba e0 81 11 00 00 	movabs $0xffff8000001181e0,%rdx
ffff800000105148:	80 ff ff 
ffff80000010514b:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105152:	80 ff ff 
ffff800000105155:	48 89 d6             	mov    %rdx,%rsi
ffff800000105158:	48 89 c7             	mov    %rax,%rdi
ffff80000010515b:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000105162:	80 ff ff 
ffff800000105165:	ff d0                	call   *%rax
ffff800000105167:	e9 6f ff ff ff       	jmp    ffff8000001050db <begin_op+0x1d>
ffff80000010516c:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105173:	80 ff ff 
ffff800000105176:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105179:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010517c:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105183:	80 ff ff 
ffff800000105186:	89 50 70             	mov    %edx,0x70(%rax)
ffff800000105189:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105190:	80 ff ff 
ffff800000105193:	48 89 c7             	mov    %rax,%rdi
ffff800000105196:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010519d:	80 ff ff 
ffff8000001051a0:	ff d0                	call   *%rax
ffff8000001051a2:	90                   	nop
ffff8000001051a3:	90                   	nop
ffff8000001051a4:	5d                   	pop    %rbp
ffff8000001051a5:	c3                   	ret

ffff8000001051a6 <end_op>:
ffff8000001051a6:	55                   	push   %rbp
ffff8000001051a7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001051aa:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001051ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001051b5:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051bc:	80 ff ff 
ffff8000001051bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001051c2:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001051c9:	80 ff ff 
ffff8000001051cc:	ff d0                	call   *%rax
ffff8000001051ce:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051d5:	80 ff ff 
ffff8000001051d8:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001051db:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff8000001051de:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051e5:	80 ff ff 
ffff8000001051e8:	89 50 70             	mov    %edx,0x70(%rax)
ffff8000001051eb:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001051f2:	80 ff ff 
ffff8000001051f5:	8b 40 74             	mov    0x74(%rax),%eax
ffff8000001051f8:	85 c0                	test   %eax,%eax
ffff8000001051fa:	74 19                	je     ffff800000105215 <end_op+0x6f>
ffff8000001051fc:	48 b8 d8 c7 10 00 00 	movabs $0xffff80000010c7d8,%rax
ffff800000105203:	80 ff ff 
ffff800000105206:	48 89 c7             	mov    %rax,%rdi
ffff800000105209:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105210:	80 ff ff 
ffff800000105213:	ff d0                	call   *%rax
ffff800000105215:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010521c:	80 ff ff 
ffff80000010521f:	8b 40 70             	mov    0x70(%rax),%eax
ffff800000105222:	85 c0                	test   %eax,%eax
ffff800000105224:	75 1a                	jne    ffff800000105240 <end_op+0x9a>
ffff800000105226:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
ffff80000010522d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105234:	80 ff ff 
ffff800000105237:	c7 40 74 01 00 00 00 	movl   $0x1,0x74(%rax)
ffff80000010523e:	eb 19                	jmp    ffff800000105259 <end_op+0xb3>
ffff800000105240:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105247:	80 ff ff 
ffff80000010524a:	48 89 c7             	mov    %rax,%rdi
ffff80000010524d:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000105254:	80 ff ff 
ffff800000105257:	ff d0                	call   *%rax
ffff800000105259:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105260:	80 ff ff 
ffff800000105263:	48 89 c7             	mov    %rax,%rdi
ffff800000105266:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010526d:	80 ff ff 
ffff800000105270:	ff d0                	call   *%rax
ffff800000105272:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000105276:	74 68                	je     ffff8000001052e0 <end_op+0x13a>
ffff800000105278:	48 b8 ed 53 10 00 00 	movabs $0xffff8000001053ed,%rax
ffff80000010527f:	80 ff ff 
ffff800000105282:	ff d0                	call   *%rax
ffff800000105284:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010528b:	80 ff ff 
ffff80000010528e:	48 89 c7             	mov    %rax,%rdi
ffff800000105291:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000105298:	80 ff ff 
ffff80000010529b:	ff d0                	call   *%rax
ffff80000010529d:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052a4:	80 ff ff 
ffff8000001052a7:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
ffff8000001052ae:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052b5:	80 ff ff 
ffff8000001052b8:	48 89 c7             	mov    %rax,%rdi
ffff8000001052bb:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff8000001052c2:	80 ff ff 
ffff8000001052c5:	ff d0                	call   *%rax
ffff8000001052c7:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052ce:	80 ff ff 
ffff8000001052d1:	48 89 c7             	mov    %rax,%rdi
ffff8000001052d4:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001052db:	80 ff ff 
ffff8000001052de:	ff d0                	call   *%rax
ffff8000001052e0:	90                   	nop
ffff8000001052e1:	c9                   	leave
ffff8000001052e2:	c3                   	ret

ffff8000001052e3 <write_log>:
ffff8000001052e3:	55                   	push   %rbp
ffff8000001052e4:	48 89 e5             	mov    %rsp,%rbp
ffff8000001052e7:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001052eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001052f2:	e9 dc 00 00 00       	jmp    ffff8000001053d3 <write_log+0xf0>
ffff8000001052f7:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001052fe:	80 ff ff 
ffff800000105301:	8b 50 68             	mov    0x68(%rax),%edx
ffff800000105304:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105307:	01 d0                	add    %edx,%eax
ffff800000105309:	83 c0 01             	add    $0x1,%eax
ffff80000010530c:	89 c2                	mov    %eax,%edx
ffff80000010530e:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105315:	80 ff ff 
ffff800000105318:	8b 40 78             	mov    0x78(%rax),%eax
ffff80000010531b:	89 d6                	mov    %edx,%esi
ffff80000010531d:	89 c7                	mov    %eax,%edi
ffff80000010531f:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105326:	80 ff ff 
ffff800000105329:	ff d0                	call   *%rax
ffff80000010532b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010532f:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105336:	80 ff ff 
ffff800000105339:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010533c:	48 63 d2             	movslq %edx,%rdx
ffff80000010533f:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105343:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105347:	89 c2                	mov    %eax,%edx
ffff800000105349:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105350:	80 ff ff 
ffff800000105353:	8b 40 78             	mov    0x78(%rax),%eax
ffff800000105356:	89 d6                	mov    %edx,%esi
ffff800000105358:	89 c7                	mov    %eax,%edi
ffff80000010535a:	48 b8 cc 03 10 00 00 	movabs $0xffff8000001003cc,%rax
ffff800000105361:	80 ff ff 
ffff800000105364:	ff d0                	call   *%rax
ffff800000105366:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010536a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010536e:	48 8d 88 b0 00 00 00 	lea    0xb0(%rax),%rcx
ffff800000105375:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105379:	48 05 b0 00 00 00    	add    $0xb0,%rax
ffff80000010537f:	ba 00 02 00 00       	mov    $0x200,%edx
ffff800000105384:	48 89 ce             	mov    %rcx,%rsi
ffff800000105387:	48 89 c7             	mov    %rax,%rdi
ffff80000010538a:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000105391:	80 ff ff 
ffff800000105394:	ff d0                	call   *%rax
ffff800000105396:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010539a:	48 89 c7             	mov    %rax,%rdi
ffff80000010539d:	48 b8 1a 04 10 00 00 	movabs $0xffff80000010041a,%rax
ffff8000001053a4:	80 ff ff 
ffff8000001053a7:	ff d0                	call   *%rax
ffff8000001053a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001053ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001053b0:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001053b7:	80 ff ff 
ffff8000001053ba:	ff d0                	call   *%rax
ffff8000001053bc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001053c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001053c3:	48 b8 81 04 10 00 00 	movabs $0xffff800000100481,%rax
ffff8000001053ca:	80 ff ff 
ffff8000001053cd:	ff d0                	call   *%rax
ffff8000001053cf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001053d3:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001053da:	80 ff ff 
ffff8000001053dd:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053e0:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff8000001053e3:	0f 8c 0e ff ff ff    	jl     ffff8000001052f7 <write_log+0x14>
ffff8000001053e9:	90                   	nop
ffff8000001053ea:	90                   	nop
ffff8000001053eb:	c9                   	leave
ffff8000001053ec:	c3                   	ret

ffff8000001053ed <commit>:
ffff8000001053ed:	55                   	push   %rbp
ffff8000001053ee:	48 89 e5             	mov    %rsp,%rbp
ffff8000001053f1:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001053f8:	80 ff ff 
ffff8000001053fb:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff8000001053fe:	85 c0                	test   %eax,%eax
ffff800000105400:	7e 41                	jle    ffff800000105443 <commit+0x56>
ffff800000105402:	48 b8 e3 52 10 00 00 	movabs $0xffff8000001052e3,%rax
ffff800000105409:	80 ff ff 
ffff80000010540c:	ff d0                	call   *%rax
ffff80000010540e:	48 b8 bb 4f 10 00 00 	movabs $0xffff800000104fbb,%rax
ffff800000105415:	80 ff ff 
ffff800000105418:	ff d0                	call   *%rax
ffff80000010541a:	48 b8 fd 4d 10 00 00 	movabs $0xffff800000104dfd,%rax
ffff800000105421:	80 ff ff 
ffff800000105424:	ff d0                	call   *%rax
ffff800000105426:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010542d:	80 ff ff 
ffff800000105430:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%rax)
ffff800000105437:	48 b8 bb 4f 10 00 00 	movabs $0xffff800000104fbb,%rax
ffff80000010543e:	80 ff ff 
ffff800000105441:	ff d0                	call   *%rax
ffff800000105443:	90                   	nop
ffff800000105444:	5d                   	pop    %rbp
ffff800000105445:	c3                   	ret

ffff800000105446 <log_write>:
ffff800000105446:	55                   	push   %rbp
ffff800000105447:	48 89 e5             	mov    %rsp,%rbp
ffff80000010544a:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010544e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105452:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105459:	80 ff ff 
ffff80000010545c:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff80000010545f:	83 f8 1d             	cmp    $0x1d,%eax
ffff800000105462:	7f 21                	jg     ffff800000105485 <log_write+0x3f>
ffff800000105464:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010546b:	80 ff ff 
ffff80000010546e:	8b 50 7c             	mov    0x7c(%rax),%edx
ffff800000105471:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105478:	80 ff ff 
ffff80000010547b:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010547e:	83 e8 01             	sub    $0x1,%eax
ffff800000105481:	39 c2                	cmp    %eax,%edx
ffff800000105483:	7c 19                	jl     ffff80000010549e <log_write+0x58>
ffff800000105485:	48 b8 e7 c7 10 00 00 	movabs $0xffff80000010c7e7,%rax
ffff80000010548c:	80 ff ff 
ffff80000010548f:	48 89 c7             	mov    %rax,%rdi
ffff800000105492:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105499:	80 ff ff 
ffff80000010549c:	ff d0                	call   *%rax
ffff80000010549e:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001054a5:	80 ff ff 
ffff8000001054a8:	8b 40 70             	mov    0x70(%rax),%eax
ffff8000001054ab:	85 c0                	test   %eax,%eax
ffff8000001054ad:	7f 19                	jg     ffff8000001054c8 <log_write+0x82>
ffff8000001054af:	48 b8 fd c7 10 00 00 	movabs $0xffff80000010c7fd,%rax
ffff8000001054b6:	80 ff ff 
ffff8000001054b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001054bc:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001054c3:	80 ff ff 
ffff8000001054c6:	ff d0                	call   *%rax
ffff8000001054c8:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001054cf:	80 ff ff 
ffff8000001054d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001054d5:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001054dc:	80 ff ff 
ffff8000001054df:	ff d0                	call   *%rax
ffff8000001054e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001054e8:	eb 29                	jmp    ffff800000105513 <log_write+0xcd>
ffff8000001054ea:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff8000001054f1:	80 ff ff 
ffff8000001054f4:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001054f7:	48 63 d2             	movslq %edx,%rdx
ffff8000001054fa:	48 83 c2 1c          	add    $0x1c,%rdx
ffff8000001054fe:	8b 44 90 10          	mov    0x10(%rax,%rdx,4),%eax
ffff800000105502:	89 c2                	mov    %eax,%edx
ffff800000105504:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105508:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010550b:	39 c2                	cmp    %eax,%edx
ffff80000010550d:	74 18                	je     ffff800000105527 <log_write+0xe1>
ffff80000010550f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105513:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff80000010551a:	80 ff ff 
ffff80000010551d:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105520:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105523:	7c c5                	jl     ffff8000001054ea <log_write+0xa4>
ffff800000105525:	eb 01                	jmp    ffff800000105528 <log_write+0xe2>
ffff800000105527:	90                   	nop
ffff800000105528:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010552c:	8b 40 08             	mov    0x8(%rax),%eax
ffff80000010552f:	89 c1                	mov    %eax,%ecx
ffff800000105531:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105538:	80 ff ff 
ffff80000010553b:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010553e:	48 63 d2             	movslq %edx,%rdx
ffff800000105541:	48 83 c2 1c          	add    $0x1c,%rdx
ffff800000105545:	89 4c 90 10          	mov    %ecx,0x10(%rax,%rdx,4)
ffff800000105549:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105550:	80 ff ff 
ffff800000105553:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105556:	39 45 fc             	cmp    %eax,-0x4(%rbp)
ffff800000105559:	75 1d                	jne    ffff800000105578 <log_write+0x132>
ffff80000010555b:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105562:	80 ff ff 
ffff800000105565:	8b 40 7c             	mov    0x7c(%rax),%eax
ffff800000105568:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010556b:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105572:	80 ff ff 
ffff800000105575:	89 50 7c             	mov    %edx,0x7c(%rax)
ffff800000105578:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010557c:	8b 00                	mov    (%rax),%eax
ffff80000010557e:	83 c8 04             	or     $0x4,%eax
ffff800000105581:	89 c2                	mov    %eax,%edx
ffff800000105583:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105587:	89 10                	mov    %edx,(%rax)
ffff800000105589:	48 b8 e0 81 11 00 00 	movabs $0xffff8000001181e0,%rax
ffff800000105590:	80 ff ff 
ffff800000105593:	48 89 c7             	mov    %rax,%rdi
ffff800000105596:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010559d:	80 ff ff 
ffff8000001055a0:	ff d0                	call   *%rax
ffff8000001055a2:	90                   	nop
ffff8000001055a3:	c9                   	leave
ffff8000001055a4:	c3                   	ret

ffff8000001055a5 <v2p>:
ffff8000001055a5:	55                   	push   %rbp
ffff8000001055a6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055a9:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001055ad:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001055b1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001055b5:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff8000001055bc:	80 00 00 
ffff8000001055bf:	48 01 d0             	add    %rdx,%rax
ffff8000001055c2:	c9                   	leave
ffff8000001055c3:	c3                   	ret

ffff8000001055c4 <xchg>:
ffff8000001055c4:	55                   	push   %rbp
ffff8000001055c5:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055c8:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001055cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001055d0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001055d4:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001055d8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001055dc:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001055e0:	f0 87 02             	lock xchg %eax,(%rdx)
ffff8000001055e3:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001055e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001055e9:	c9                   	leave
ffff8000001055ea:	c3                   	ret

ffff8000001055eb <main>:
ffff8000001055eb:	55                   	push   %rbp
ffff8000001055ec:	48 89 e5             	mov    %rsp,%rbp
ffff8000001055ef:	48 b8 10 a0 10 00 00 	movabs $0xffff80000010a010,%rax
ffff8000001055f6:	80 ff ff 
ffff8000001055f9:	ff d0                	call   *%rax
ffff8000001055fb:	48 ba 00 00 00 0e 00 	movabs $0xffff80000e000000,%rdx
ffff800000105602:	80 ff ff 
ffff800000105605:	48 b8 00 e0 11 00 00 	movabs $0xffff80000011e000,%rax
ffff80000010560c:	80 ff ff 
ffff80000010560f:	48 89 d6             	mov    %rdx,%rsi
ffff800000105612:	48 89 c7             	mov    %rax,%rdi
ffff800000105615:	48 b8 ea 40 10 00 00 	movabs $0xffff8000001040ea,%rax
ffff80000010561c:	80 ff ff 
ffff80000010561f:	ff d0                	call   *%rax
ffff800000105621:	48 b8 98 b2 10 00 00 	movabs $0xffff80000010b298,%rax
ffff800000105628:	80 ff ff 
ffff80000010562b:	ff d0                	call   *%rax
ffff80000010562d:	48 b8 fb 5b 10 00 00 	movabs $0xffff800000105bfb,%rax
ffff800000105634:	80 ff ff 
ffff800000105637:	ff d0                	call   *%rax
ffff800000105639:	48 b8 fb 46 10 00 00 	movabs $0xffff8000001046fb,%rax
ffff800000105640:	80 ff ff 
ffff800000105643:	ff d0                	call   *%rax
ffff800000105645:	48 b8 e2 9a 10 00 00 	movabs $0xffff800000109ae2,%rax
ffff80000010564c:	80 ff ff 
ffff80000010564f:	ff d0                	call   *%rax
ffff800000105651:	48 b8 dd ad 10 00 00 	movabs $0xffff80000010addd,%rax
ffff800000105658:	80 ff ff 
ffff80000010565b:	ff d0                	call   *%rax
ffff80000010565d:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff800000105664:	80 ff ff 
ffff800000105667:	ff d0                	call   *%rax
ffff800000105669:	89 c2                	mov    %eax,%edx
ffff80000010566b:	48 b8 18 c8 10 00 00 	movabs $0xffff80000010c818,%rax
ffff800000105672:	80 ff ff 
ffff800000105675:	89 d6                	mov    %edx,%esi
ffff800000105677:	48 89 c7             	mov    %rax,%rdi
ffff80000010567a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010567f:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105686:	80 ff ff 
ffff800000105689:	ff d2                	call   *%rdx
ffff80000010568b:	48 b8 b5 3f 10 00 00 	movabs $0xffff800000103fb5,%rax
ffff800000105692:	80 ff ff 
ffff800000105695:	ff d0                	call   *%rax
ffff800000105697:	48 b8 c1 15 10 00 00 	movabs $0xffff8000001015c1,%rax
ffff80000010569e:	80 ff ff 
ffff8000001056a1:	ff d0                	call   *%rax
ffff8000001056a3:	48 b8 14 a1 10 00 00 	movabs $0xffff80000010a114,%rax
ffff8000001056aa:	80 ff ff 
ffff8000001056ad:	ff d0                	call   *%rax
ffff8000001056af:	48 b8 53 c1 10 00 00 	movabs $0xffff80000010c153,%rax
ffff8000001056b6:	80 ff ff 
ffff8000001056b9:	ff d0                	call   *%rax
ffff8000001056bb:	48 b8 3b 63 10 00 00 	movabs $0xffff80000010633b,%rax
ffff8000001056c2:	80 ff ff 
ffff8000001056c5:	ff d0                	call   *%rax
ffff8000001056c7:	48 b8 1b 01 10 00 00 	movabs $0xffff80000010011b,%rax
ffff8000001056ce:	80 ff ff 
ffff8000001056d1:	ff d0                	call   *%rax
ffff8000001056d3:	48 b8 45 1c 10 00 00 	movabs $0xffff800000101c45,%rax
ffff8000001056da:	80 ff ff 
ffff8000001056dd:	ff d0                	call   *%rax
ffff8000001056df:	48 b8 04 3a 10 00 00 	movabs $0xffff800000103a04,%rax
ffff8000001056e6:	80 ff ff 
ffff8000001056e9:	ff d0                	call   *%rax
ffff8000001056eb:	48 b8 c8 57 10 00 00 	movabs $0xffff8000001057c8,%rax
ffff8000001056f2:	80 ff ff 
ffff8000001056f5:	ff d0                	call   *%rax
ffff8000001056f7:	48 b8 60 41 10 00 00 	movabs $0xffff800000104160,%rax
ffff8000001056fe:	80 ff ff 
ffff800000105701:	ff d0                	call   *%rax
ffff800000105703:	48 b8 e6 64 10 00 00 	movabs $0xffff8000001064e6,%rax
ffff80000010570a:	80 ff ff 
ffff80000010570d:	ff d0                	call   *%rax
ffff80000010570f:	48 b8 4f 57 10 00 00 	movabs $0xffff80000010574f,%rax
ffff800000105716:	80 ff ff 
ffff800000105719:	ff d0                	call   *%rax

ffff80000010571b <mpenter>:
ffff80000010571b:	55                   	push   %rbp
ffff80000010571c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010571f:	48 b8 99 b6 10 00 00 	movabs $0xffff80000010b699,%rax
ffff800000105726:	80 ff ff 
ffff800000105729:	ff d0                	call   *%rax
ffff80000010572b:	48 b8 dd ad 10 00 00 	movabs $0xffff80000010addd,%rax
ffff800000105732:	80 ff ff 
ffff800000105735:	ff d0                	call   *%rax
ffff800000105737:	48 b8 fb 46 10 00 00 	movabs $0xffff8000001046fb,%rax
ffff80000010573e:	80 ff ff 
ffff800000105741:	ff d0                	call   *%rax
ffff800000105743:	48 b8 4f 57 10 00 00 	movabs $0xffff80000010574f,%rax
ffff80000010574a:	80 ff ff 
ffff80000010574d:	ff d0                	call   *%rax

ffff80000010574f <mpmain>:
ffff80000010574f:	55                   	push   %rbp
ffff800000105750:	48 89 e5             	mov    %rsp,%rbp
ffff800000105753:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff80000010575a:	80 ff ff 
ffff80000010575d:	ff d0                	call   *%rax
ffff80000010575f:	89 c2                	mov    %eax,%edx
ffff800000105761:	48 b8 3b c8 10 00 00 	movabs $0xffff80000010c83b,%rax
ffff800000105768:	80 ff ff 
ffff80000010576b:	89 d6                	mov    %edx,%esi
ffff80000010576d:	48 89 c7             	mov    %rax,%rdi
ffff800000105770:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105775:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff80000010577c:	80 ff ff 
ffff80000010577f:	ff d2                	call   *%rdx
ffff800000105781:	48 b8 ba 9a 10 00 00 	movabs $0xffff800000109aba,%rax
ffff800000105788:	80 ff ff 
ffff80000010578b:	ff d0                	call   *%rax
ffff80000010578d:	48 b8 66 ad 10 00 00 	movabs $0xffff80000010ad66,%rax
ffff800000105794:	80 ff ff 
ffff800000105797:	ff d0                	call   *%rax
ffff800000105799:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001057a0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001057a4:	48 83 c0 10          	add    $0x10,%rax
ffff8000001057a8:	be 01 00 00 00       	mov    $0x1,%esi
ffff8000001057ad:	48 89 c7             	mov    %rax,%rdi
ffff8000001057b0:	48 b8 c4 55 10 00 00 	movabs $0xffff8000001055c4,%rax
ffff8000001057b7:	80 ff ff 
ffff8000001057ba:	ff d0                	call   *%rax
ffff8000001057bc:	48 b8 d2 6d 10 00 00 	movabs $0xffff800000106dd2,%rax
ffff8000001057c3:	80 ff ff 
ffff8000001057c6:	ff d0                	call   *%rax

ffff8000001057c8 <startothers>:
ffff8000001057c8:	55                   	push   %rbp
ffff8000001057c9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001057cc:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001057d0:	48 b8 00 70 00 00 00 	movabs $0xffff800000007000,%rax
ffff8000001057d7:	80 ff ff 
ffff8000001057da:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001057de:	48 b8 72 00 00 00 00 	movabs $0x72,%rax
ffff8000001057e5:	00 00 00 
ffff8000001057e8:	89 c2                	mov    %eax,%edx
ffff8000001057ea:	48 b9 90 df 10 00 00 	movabs $0xffff80000010df90,%rcx
ffff8000001057f1:	80 ff ff 
ffff8000001057f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001057f8:	48 89 ce             	mov    %rcx,%rsi
ffff8000001057fb:	48 89 c7             	mov    %rax,%rdi
ffff8000001057fe:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000105805:	80 ff ff 
ffff800000105808:	ff d0                	call   *%rax
ffff80000010580a:	48 b8 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rax
ffff800000105811:	80 ff ff 
ffff800000105814:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105818:	e9 c6 00 00 00       	jmp    ffff8000001058e3 <startothers+0x11b>
ffff80000010581d:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff800000105824:	80 ff ff 
ffff800000105827:	ff d0                	call   *%rax
ffff800000105829:	48 63 d0             	movslq %eax,%rdx
ffff80000010582c:	48 89 d0             	mov    %rdx,%rax
ffff80000010582f:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105833:	48 01 d0             	add    %rdx,%rax
ffff800000105836:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010583a:	48 89 c2             	mov    %rax,%rdx
ffff80000010583d:	48 b8 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rax
ffff800000105844:	80 ff ff 
ffff800000105847:	48 01 d0             	add    %rdx,%rax
ffff80000010584a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010584e:	0f 84 89 00 00 00    	je     ffff8000001058dd <startothers+0x115>
ffff800000105854:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010585b:	80 ff ff 
ffff80000010585e:	ff d0                	call   *%rax
ffff800000105860:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105864:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105868:	48 83 e8 04          	sub    $0x4,%rax
ffff80000010586c:	c7 00 00 80 00 00    	movl   $0x8000,(%rax)
ffff800000105872:	48 b8 49 00 10 00 00 	movabs $0xffff800000100049,%rax
ffff800000105879:	80 ff ff 
ffff80000010587c:	48 89 c7             	mov    %rax,%rdi
ffff80000010587f:	48 b8 a5 55 10 00 00 	movabs $0xffff8000001055a5,%rax
ffff800000105886:	80 ff ff 
ffff800000105889:	ff d0                	call   *%rax
ffff80000010588b:	48 89 c2             	mov    %rax,%rdx
ffff80000010588e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105892:	48 83 e8 08          	sub    $0x8,%rax
ffff800000105896:	89 10                	mov    %edx,(%rax)
ffff800000105898:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010589c:	48 8d 90 00 10 00 00 	lea    0x1000(%rax),%rdx
ffff8000001058a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001058a7:	48 83 e8 10          	sub    $0x10,%rax
ffff8000001058ab:	48 89 10             	mov    %rdx,(%rax)
ffff8000001058ae:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001058b2:	89 c2                	mov    %eax,%edx
ffff8000001058b4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058b8:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff8000001058bc:	0f b6 c0             	movzbl %al,%eax
ffff8000001058bf:	89 d6                	mov    %edx,%esi
ffff8000001058c1:	89 c7                	mov    %eax,%edi
ffff8000001058c3:	48 b8 ce 49 10 00 00 	movabs $0xffff8000001049ce,%rax
ffff8000001058ca:	80 ff ff 
ffff8000001058cd:	ff d0                	call   *%rax
ffff8000001058cf:	90                   	nop
ffff8000001058d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001058d4:	8b 40 10             	mov    0x10(%rax),%eax
ffff8000001058d7:	85 c0                	test   %eax,%eax
ffff8000001058d9:	74 f5                	je     ffff8000001058d0 <startothers+0x108>
ffff8000001058db:	eb 01                	jmp    ffff8000001058de <startothers+0x116>
ffff8000001058dd:	90                   	nop
ffff8000001058de:	48 83 45 f8 28       	addq   $0x28,-0x8(%rbp)
ffff8000001058e3:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff8000001058ea:	80 ff ff 
ffff8000001058ed:	8b 00                	mov    (%rax),%eax
ffff8000001058ef:	48 63 d0             	movslq %eax,%rdx
ffff8000001058f2:	48 89 d0             	mov    %rdx,%rax
ffff8000001058f5:	48 c1 e0 02          	shl    $0x2,%rax
ffff8000001058f9:	48 01 d0             	add    %rdx,%rax
ffff8000001058fc:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105900:	48 89 c2             	mov    %rax,%rdx
ffff800000105903:	48 b8 e0 82 11 00 00 	movabs $0xffff8000001182e0,%rax
ffff80000010590a:	80 ff ff 
ffff80000010590d:	48 01 d0             	add    %rdx,%rax
ffff800000105910:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000105914:	0f 82 03 ff ff ff    	jb     ffff80000010581d <startothers+0x55>
ffff80000010591a:	90                   	nop
ffff80000010591b:	90                   	nop
ffff80000010591c:	c9                   	leave
ffff80000010591d:	c3                   	ret

ffff80000010591e <inb>:
ffff80000010591e:	55                   	push   %rbp
ffff80000010591f:	48 89 e5             	mov    %rsp,%rbp
ffff800000105922:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000105926:	89 f8                	mov    %edi,%eax
ffff800000105928:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff80000010592c:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000105930:	89 c2                	mov    %eax,%edx
ffff800000105932:	ec                   	in     (%dx),%al
ffff800000105933:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff800000105936:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff80000010593a:	c9                   	leave
ffff80000010593b:	c3                   	ret

ffff80000010593c <outb>:
ffff80000010593c:	55                   	push   %rbp
ffff80000010593d:	48 89 e5             	mov    %rsp,%rbp
ffff800000105940:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000105944:	89 fa                	mov    %edi,%edx
ffff800000105946:	89 f0                	mov    %esi,%eax
ffff800000105948:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010594c:	88 45 f8             	mov    %al,-0x8(%rbp)
ffff80000010594f:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff800000105953:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff800000105957:	ee                   	out    %al,(%dx)
ffff800000105958:	90                   	nop
ffff800000105959:	c9                   	leave
ffff80000010595a:	c3                   	ret

ffff80000010595b <sum>:
ffff80000010595b:	55                   	push   %rbp
ffff80000010595c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010595f:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105963:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105967:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff80000010596a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff800000105971:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000105978:	eb 1a                	jmp    ffff800000105994 <sum+0x39>
ffff80000010597a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010597d:	48 63 d0             	movslq %eax,%rdx
ffff800000105980:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105984:	48 01 d0             	add    %rdx,%rax
ffff800000105987:	0f b6 00             	movzbl (%rax),%eax
ffff80000010598a:	0f b6 c0             	movzbl %al,%eax
ffff80000010598d:	01 45 f8             	add    %eax,-0x8(%rbp)
ffff800000105990:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000105994:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000105997:	3b 45 e4             	cmp    -0x1c(%rbp),%eax
ffff80000010599a:	7c de                	jl     ffff80000010597a <sum+0x1f>
ffff80000010599c:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010599f:	c9                   	leave
ffff8000001059a0:	c3                   	ret

ffff8000001059a1 <mpsearch1>:
ffff8000001059a1:	55                   	push   %rbp
ffff8000001059a2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001059a5:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001059a9:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff8000001059ad:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffff8000001059b0:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff8000001059b7:	80 ff ff 
ffff8000001059ba:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001059be:	48 01 d0             	add    %rdx,%rax
ffff8000001059c1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff8000001059c5:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001059c8:	48 63 d0             	movslq %eax,%rdx
ffff8000001059cb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059cf:	48 01 d0             	add    %rdx,%rax
ffff8000001059d2:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001059d6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001059da:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001059de:	eb 50                	jmp    ffff800000105a30 <mpsearch1+0x8f>
ffff8000001059e0:	48 b9 50 c8 10 00 00 	movabs $0xffff80000010c850,%rcx
ffff8000001059e7:	80 ff ff 
ffff8000001059ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001059ee:	ba 04 00 00 00       	mov    $0x4,%edx
ffff8000001059f3:	48 89 ce             	mov    %rcx,%rsi
ffff8000001059f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001059f9:	48 b8 04 7b 10 00 00 	movabs $0xffff800000107b04,%rax
ffff800000105a00:	80 ff ff 
ffff800000105a03:	ff d0                	call   *%rax
ffff800000105a05:	85 c0                	test   %eax,%eax
ffff800000105a07:	75 22                	jne    ffff800000105a2b <mpsearch1+0x8a>
ffff800000105a09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a0d:	be 10 00 00 00       	mov    $0x10,%esi
ffff800000105a12:	48 89 c7             	mov    %rax,%rdi
ffff800000105a15:	48 b8 5b 59 10 00 00 	movabs $0xffff80000010595b,%rax
ffff800000105a1c:	80 ff ff 
ffff800000105a1f:	ff d0                	call   *%rax
ffff800000105a21:	84 c0                	test   %al,%al
ffff800000105a23:	75 06                	jne    ffff800000105a2b <mpsearch1+0x8a>
ffff800000105a25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a29:	eb 14                	jmp    ffff800000105a3f <mpsearch1+0x9e>
ffff800000105a2b:	48 83 45 f8 10       	addq   $0x10,-0x8(%rbp)
ffff800000105a30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a34:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105a38:	72 a6                	jb     ffff8000001059e0 <mpsearch1+0x3f>
ffff800000105a3a:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105a3f:	c9                   	leave
ffff800000105a40:	c3                   	ret

ffff800000105a41 <mpsearch>:
ffff800000105a41:	55                   	push   %rbp
ffff800000105a42:	48 89 e5             	mov    %rsp,%rbp
ffff800000105a45:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105a49:	48 b8 00 04 00 00 00 	movabs $0xffff800000000400,%rax
ffff800000105a50:	80 ff ff 
ffff800000105a53:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105a57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a5b:	48 83 c0 0f          	add    $0xf,%rax
ffff800000105a5f:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a62:	0f b6 c0             	movzbl %al,%eax
ffff800000105a65:	c1 e0 08             	shl    $0x8,%eax
ffff800000105a68:	89 c2                	mov    %eax,%edx
ffff800000105a6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105a6e:	48 83 c0 0e          	add    $0xe,%rax
ffff800000105a72:	0f b6 00             	movzbl (%rax),%eax
ffff800000105a75:	0f b6 c0             	movzbl %al,%eax
ffff800000105a78:	09 d0                	or     %edx,%eax
ffff800000105a7a:	c1 e0 04             	shl    $0x4,%eax
ffff800000105a7d:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000105a80:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105a84:	74 28                	je     ffff800000105aae <mpsearch+0x6d>
ffff800000105a86:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105a89:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105a8e:	48 89 c7             	mov    %rax,%rdi
ffff800000105a91:	48 b8 a1 59 10 00 00 	movabs $0xffff8000001059a1,%rax
ffff800000105a98:	80 ff ff 
ffff800000105a9b:	ff d0                	call   *%rax
ffff800000105a9d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105aa1:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105aa6:	74 5e                	je     ffff800000105b06 <mpsearch+0xc5>
ffff800000105aa8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105aac:	eb 6e                	jmp    ffff800000105b1c <mpsearch+0xdb>
ffff800000105aae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ab2:	48 83 c0 14          	add    $0x14,%rax
ffff800000105ab6:	0f b6 00             	movzbl (%rax),%eax
ffff800000105ab9:	0f b6 c0             	movzbl %al,%eax
ffff800000105abc:	c1 e0 08             	shl    $0x8,%eax
ffff800000105abf:	89 c2                	mov    %eax,%edx
ffff800000105ac1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ac5:	48 83 c0 13          	add    $0x13,%rax
ffff800000105ac9:	0f b6 00             	movzbl (%rax),%eax
ffff800000105acc:	0f b6 c0             	movzbl %al,%eax
ffff800000105acf:	09 d0                	or     %edx,%eax
ffff800000105ad1:	c1 e0 0a             	shl    $0xa,%eax
ffff800000105ad4:	89 45 f4             	mov    %eax,-0xc(%rbp)
ffff800000105ad7:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000105ada:	2d 00 04 00 00       	sub    $0x400,%eax
ffff800000105adf:	89 c0                	mov    %eax,%eax
ffff800000105ae1:	be 00 04 00 00       	mov    $0x400,%esi
ffff800000105ae6:	48 89 c7             	mov    %rax,%rdi
ffff800000105ae9:	48 b8 a1 59 10 00 00 	movabs $0xffff8000001059a1,%rax
ffff800000105af0:	80 ff ff 
ffff800000105af3:	ff d0                	call   *%rax
ffff800000105af5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105af9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000105afe:	74 06                	je     ffff800000105b06 <mpsearch+0xc5>
ffff800000105b00:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105b04:	eb 16                	jmp    ffff800000105b1c <mpsearch+0xdb>
ffff800000105b06:	be 00 00 01 00       	mov    $0x10000,%esi
ffff800000105b0b:	bf 00 00 0f 00       	mov    $0xf0000,%edi
ffff800000105b10:	48 b8 a1 59 10 00 00 	movabs $0xffff8000001059a1,%rax
ffff800000105b17:	80 ff ff 
ffff800000105b1a:	ff d0                	call   *%rax
ffff800000105b1c:	c9                   	leave
ffff800000105b1d:	c3                   	ret

ffff800000105b1e <mpconfig>:
ffff800000105b1e:	55                   	push   %rbp
ffff800000105b1f:	48 89 e5             	mov    %rsp,%rbp
ffff800000105b22:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105b26:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105b2a:	48 b8 41 5a 10 00 00 	movabs $0xffff800000105a41,%rax
ffff800000105b31:	80 ff ff 
ffff800000105b34:	ff d0                	call   *%rax
ffff800000105b36:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105b3a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105b3f:	74 0b                	je     ffff800000105b4c <mpconfig+0x2e>
ffff800000105b41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b45:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105b48:	85 c0                	test   %eax,%eax
ffff800000105b4a:	75 0a                	jne    ffff800000105b56 <mpconfig+0x38>
ffff800000105b4c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105b51:	e9 a3 00 00 00       	jmp    ffff800000105bf9 <mpconfig+0xdb>
ffff800000105b56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105b5a:	8b 40 04             	mov    0x4(%rax),%eax
ffff800000105b5d:	89 c2                	mov    %eax,%edx
ffff800000105b5f:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105b66:	80 ff ff 
ffff800000105b69:	48 01 d0             	add    %rdx,%rax
ffff800000105b6c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105b70:	48 b9 55 c8 10 00 00 	movabs $0xffff80000010c855,%rcx
ffff800000105b77:	80 ff ff 
ffff800000105b7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105b7e:	ba 04 00 00 00       	mov    $0x4,%edx
ffff800000105b83:	48 89 ce             	mov    %rcx,%rsi
ffff800000105b86:	48 89 c7             	mov    %rax,%rdi
ffff800000105b89:	48 b8 04 7b 10 00 00 	movabs $0xffff800000107b04,%rax
ffff800000105b90:	80 ff ff 
ffff800000105b93:	ff d0                	call   *%rax
ffff800000105b95:	85 c0                	test   %eax,%eax
ffff800000105b97:	74 07                	je     ffff800000105ba0 <mpconfig+0x82>
ffff800000105b99:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105b9e:	eb 59                	jmp    ffff800000105bf9 <mpconfig+0xdb>
ffff800000105ba0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105ba4:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105ba8:	3c 01                	cmp    $0x1,%al
ffff800000105baa:	74 13                	je     ffff800000105bbf <mpconfig+0xa1>
ffff800000105bac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bb0:	0f b6 40 06          	movzbl 0x6(%rax),%eax
ffff800000105bb4:	3c 04                	cmp    $0x4,%al
ffff800000105bb6:	74 07                	je     ffff800000105bbf <mpconfig+0xa1>
ffff800000105bb8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105bbd:	eb 3a                	jmp    ffff800000105bf9 <mpconfig+0xdb>
ffff800000105bbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bc3:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105bc7:	0f b7 d0             	movzwl %ax,%edx
ffff800000105bca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bce:	89 d6                	mov    %edx,%esi
ffff800000105bd0:	48 89 c7             	mov    %rax,%rdi
ffff800000105bd3:	48 b8 5b 59 10 00 00 	movabs $0xffff80000010595b,%rax
ffff800000105bda:	80 ff ff 
ffff800000105bdd:	ff d0                	call   *%rax
ffff800000105bdf:	84 c0                	test   %al,%al
ffff800000105be1:	74 07                	je     ffff800000105bea <mpconfig+0xcc>
ffff800000105be3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105be8:	eb 0f                	jmp    ffff800000105bf9 <mpconfig+0xdb>
ffff800000105bea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105bee:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105bf2:	48 89 10             	mov    %rdx,(%rax)
ffff800000105bf5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105bf9:	c9                   	leave
ffff800000105bfa:	c3                   	ret

ffff800000105bfb <mpinit>:
ffff800000105bfb:	55                   	push   %rbp
ffff800000105bfc:	48 89 e5             	mov    %rsp,%rbp
ffff800000105bff:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000105c03:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff800000105c07:	48 89 c7             	mov    %rax,%rdi
ffff800000105c0a:	48 b8 1e 5b 10 00 00 	movabs $0xffff800000105b1e,%rax
ffff800000105c11:	80 ff ff 
ffff800000105c14:	ff d0                	call   *%rax
ffff800000105c16:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000105c1a:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000105c1f:	75 23                	jne    ffff800000105c44 <mpinit+0x49>
ffff800000105c21:	48 b8 5a c8 10 00 00 	movabs $0xffff80000010c85a,%rax
ffff800000105c28:	80 ff ff 
ffff800000105c2b:	48 89 c7             	mov    %rax,%rdi
ffff800000105c2e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105c33:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105c3a:	80 ff ff 
ffff800000105c3d:	ff d2                	call   *%rdx
ffff800000105c3f:	e9 c9 01 00 00       	jmp    ffff800000105e0d <mpinit+0x212>
ffff800000105c44:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c48:	8b 40 24             	mov    0x24(%rax),%eax
ffff800000105c4b:	89 c2                	mov    %eax,%edx
ffff800000105c4d:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff800000105c54:	80 ff ff 
ffff800000105c57:	48 01 d0             	add    %rdx,%rax
ffff800000105c5a:	48 89 c2             	mov    %rax,%rdx
ffff800000105c5d:	48 b8 c0 81 11 00 00 	movabs $0xffff8000001181c0,%rax
ffff800000105c64:	80 ff ff 
ffff800000105c67:	48 89 10             	mov    %rdx,(%rax)
ffff800000105c6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c6e:	48 83 c0 2c          	add    $0x2c,%rax
ffff800000105c72:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105c76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c7a:	0f b7 40 04          	movzwl 0x4(%rax),%eax
ffff800000105c7e:	0f b7 d0             	movzwl %ax,%edx
ffff800000105c81:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000105c85:	48 01 d0             	add    %rdx,%rax
ffff800000105c88:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000105c8c:	e9 f6 00 00 00       	jmp    ffff800000105d87 <mpinit+0x18c>
ffff800000105c91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105c95:	0f b6 00             	movzbl (%rax),%eax
ffff800000105c98:	0f b6 c0             	movzbl %al,%eax
ffff800000105c9b:	83 f8 04             	cmp    $0x4,%eax
ffff800000105c9e:	0f 8f ca 00 00 00    	jg     ffff800000105d6e <mpinit+0x173>
ffff800000105ca4:	83 f8 03             	cmp    $0x3,%eax
ffff800000105ca7:	0f 8d ba 00 00 00    	jge    ffff800000105d67 <mpinit+0x16c>
ffff800000105cad:	83 f8 02             	cmp    $0x2,%eax
ffff800000105cb0:	0f 84 8e 00 00 00    	je     ffff800000105d44 <mpinit+0x149>
ffff800000105cb6:	83 f8 02             	cmp    $0x2,%eax
ffff800000105cb9:	0f 8f af 00 00 00    	jg     ffff800000105d6e <mpinit+0x173>
ffff800000105cbf:	85 c0                	test   %eax,%eax
ffff800000105cc1:	74 0e                	je     ffff800000105cd1 <mpinit+0xd6>
ffff800000105cc3:	83 f8 01             	cmp    $0x1,%eax
ffff800000105cc6:	0f 84 9b 00 00 00    	je     ffff800000105d67 <mpinit+0x16c>
ffff800000105ccc:	e9 9d 00 00 00       	jmp    ffff800000105d6e <mpinit+0x173>
ffff800000105cd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105cd5:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff800000105cd9:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105ce0:	80 ff ff 
ffff800000105ce3:	8b 00                	mov    (%rax),%eax
ffff800000105ce5:	83 f8 07             	cmp    $0x7,%eax
ffff800000105ce8:	7f 53                	jg     ffff800000105d3d <mpinit+0x142>
ffff800000105cea:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105cf1:	80 ff ff 
ffff800000105cf4:	8b 10                	mov    (%rax),%edx
ffff800000105cf6:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000105cfa:	0f b6 48 01          	movzbl 0x1(%rax),%ecx
ffff800000105cfe:	48 be e0 82 11 00 00 	movabs $0xffff8000001182e0,%rsi
ffff800000105d05:	80 ff ff 
ffff800000105d08:	48 63 d2             	movslq %edx,%rdx
ffff800000105d0b:	48 89 d0             	mov    %rdx,%rax
ffff800000105d0e:	48 c1 e0 02          	shl    $0x2,%rax
ffff800000105d12:	48 01 d0             	add    %rdx,%rax
ffff800000105d15:	48 c1 e0 03          	shl    $0x3,%rax
ffff800000105d19:	48 01 f0             	add    %rsi,%rax
ffff800000105d1c:	48 83 c0 01          	add    $0x1,%rax
ffff800000105d20:	88 08                	mov    %cl,(%rax)
ffff800000105d22:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105d29:	80 ff ff 
ffff800000105d2c:	8b 00                	mov    (%rax),%eax
ffff800000105d2e:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000105d31:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105d38:	80 ff ff 
ffff800000105d3b:	89 10                	mov    %edx,(%rax)
ffff800000105d3d:	48 83 45 f8 14       	addq   $0x14,-0x8(%rbp)
ffff800000105d42:	eb 43                	jmp    ffff800000105d87 <mpinit+0x18c>
ffff800000105d44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d48:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000105d4c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105d50:	0f b6 40 01          	movzbl 0x1(%rax),%eax
ffff800000105d54:	48 ba 24 84 11 00 00 	movabs $0xffff800000118424,%rdx
ffff800000105d5b:	80 ff ff 
ffff800000105d5e:	88 02                	mov    %al,(%rdx)
ffff800000105d60:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
ffff800000105d65:	eb 20                	jmp    ffff800000105d87 <mpinit+0x18c>
ffff800000105d67:	48 83 45 f8 08       	addq   $0x8,-0x8(%rbp)
ffff800000105d6c:	eb 19                	jmp    ffff800000105d87 <mpinit+0x18c>
ffff800000105d6e:	48 b8 70 c8 10 00 00 	movabs $0xffff80000010c870,%rax
ffff800000105d75:	80 ff ff 
ffff800000105d78:	48 89 c7             	mov    %rax,%rdi
ffff800000105d7b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000105d82:	80 ff ff 
ffff800000105d85:	ff d0                	call   *%rax
ffff800000105d87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105d8b:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000105d8f:	0f 82 fc fe ff ff    	jb     ffff800000105c91 <mpinit+0x96>
ffff800000105d95:	48 b8 20 84 11 00 00 	movabs $0xffff800000118420,%rax
ffff800000105d9c:	80 ff ff 
ffff800000105d9f:	8b 00                	mov    (%rax),%eax
ffff800000105da1:	48 ba 91 c8 10 00 00 	movabs $0xffff80000010c891,%rdx
ffff800000105da8:	80 ff ff 
ffff800000105dab:	89 c6                	mov    %eax,%esi
ffff800000105dad:	48 89 d7             	mov    %rdx,%rdi
ffff800000105db0:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105db5:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000105dbc:	80 ff ff 
ffff800000105dbf:	ff d2                	call   *%rdx
ffff800000105dc1:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000105dc5:	0f b6 40 0c          	movzbl 0xc(%rax),%eax
ffff800000105dc9:	84 c0                	test   %al,%al
ffff800000105dcb:	74 40                	je     ffff800000105e0d <mpinit+0x212>
ffff800000105dcd:	be 70 00 00 00       	mov    $0x70,%esi
ffff800000105dd2:	bf 22 00 00 00       	mov    $0x22,%edi
ffff800000105dd7:	48 b8 3c 59 10 00 00 	movabs $0xffff80000010593c,%rax
ffff800000105dde:	80 ff ff 
ffff800000105de1:	ff d0                	call   *%rax
ffff800000105de3:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105de8:	48 b8 1e 59 10 00 00 	movabs $0xffff80000010591e,%rax
ffff800000105def:	80 ff ff 
ffff800000105df2:	ff d0                	call   *%rax
ffff800000105df4:	83 c8 01             	or     $0x1,%eax
ffff800000105df7:	0f b6 c0             	movzbl %al,%eax
ffff800000105dfa:	89 c6                	mov    %eax,%esi
ffff800000105dfc:	bf 23 00 00 00       	mov    $0x23,%edi
ffff800000105e01:	48 b8 3c 59 10 00 00 	movabs $0xffff80000010593c,%rax
ffff800000105e08:	80 ff ff 
ffff800000105e0b:	ff d0                	call   *%rax
ffff800000105e0d:	c9                   	leave
ffff800000105e0e:	c3                   	ret

ffff800000105e0f <pipealloc>:
ffff800000105e0f:	55                   	push   %rbp
ffff800000105e10:	48 89 e5             	mov    %rsp,%rbp
ffff800000105e13:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000105e17:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000105e1b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000105e1f:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
ffff800000105e26:	00 
ffff800000105e27:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e2b:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff800000105e32:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e36:	48 8b 10             	mov    (%rax),%rdx
ffff800000105e39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105e3d:	48 89 10             	mov    %rdx,(%rax)
ffff800000105e40:	48 b8 72 1c 10 00 00 	movabs $0xffff800000101c72,%rax
ffff800000105e47:	80 ff ff 
ffff800000105e4a:	ff d0                	call   *%rax
ffff800000105e4c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000105e50:	48 89 02             	mov    %rax,(%rdx)
ffff800000105e53:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105e57:	48 8b 00             	mov    (%rax),%rax
ffff800000105e5a:	48 85 c0             	test   %rax,%rax
ffff800000105e5d:	0f 84 01 01 00 00    	je     ffff800000105f64 <pipealloc+0x155>
ffff800000105e63:	48 b8 72 1c 10 00 00 	movabs $0xffff800000101c72,%rax
ffff800000105e6a:	80 ff ff 
ffff800000105e6d:	ff d0                	call   *%rax
ffff800000105e6f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000105e73:	48 89 02             	mov    %rax,(%rdx)
ffff800000105e76:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105e7a:	48 8b 00             	mov    (%rax),%rax
ffff800000105e7d:	48 85 c0             	test   %rax,%rax
ffff800000105e80:	0f 84 de 00 00 00    	je     ffff800000105f64 <pipealloc+0x155>
ffff800000105e86:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff800000105e8d:	80 ff ff 
ffff800000105e90:	ff d0                	call   *%rax
ffff800000105e92:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000105e96:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105e9b:	0f 84 c6 00 00 00    	je     ffff800000105f67 <pipealloc+0x158>
ffff800000105ea1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ea5:	c7 80 70 02 00 00 01 	movl   $0x1,0x270(%rax)
ffff800000105eac:	00 00 00 
ffff800000105eaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105eb3:	c7 80 74 02 00 00 01 	movl   $0x1,0x274(%rax)
ffff800000105eba:	00 00 00 
ffff800000105ebd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ec1:	c7 80 6c 02 00 00 00 	movl   $0x0,0x26c(%rax)
ffff800000105ec8:	00 00 00 
ffff800000105ecb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ecf:	c7 80 68 02 00 00 00 	movl   $0x0,0x268(%rax)
ffff800000105ed6:	00 00 00 
ffff800000105ed9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105edd:	48 ba ae c8 10 00 00 	movabs $0xffff80000010c8ae,%rdx
ffff800000105ee4:	80 ff ff 
ffff800000105ee7:	48 89 d6             	mov    %rdx,%rsi
ffff800000105eea:	48 89 c7             	mov    %rax,%rdi
ffff800000105eed:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000105ef4:	80 ff ff 
ffff800000105ef7:	ff d0                	call   *%rax
ffff800000105ef9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105efd:	48 8b 00             	mov    (%rax),%rax
ffff800000105f00:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
ffff800000105f06:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f0a:	48 8b 00             	mov    (%rax),%rax
ffff800000105f0d:	c6 40 08 01          	movb   $0x1,0x8(%rax)
ffff800000105f11:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f15:	48 8b 00             	mov    (%rax),%rax
ffff800000105f18:	c6 40 09 00          	movb   $0x0,0x9(%rax)
ffff800000105f1c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f20:	48 8b 00             	mov    (%rax),%rax
ffff800000105f23:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f27:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000105f2b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f2f:	48 8b 00             	mov    (%rax),%rax
ffff800000105f32:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
ffff800000105f38:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f3c:	48 8b 00             	mov    (%rax),%rax
ffff800000105f3f:	c6 40 08 00          	movb   $0x0,0x8(%rax)
ffff800000105f43:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f47:	48 8b 00             	mov    (%rax),%rax
ffff800000105f4a:	c6 40 09 01          	movb   $0x1,0x9(%rax)
ffff800000105f4e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105f52:	48 8b 00             	mov    (%rax),%rax
ffff800000105f55:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000105f59:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000105f5d:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000105f62:	eb 67                	jmp    ffff800000105fcb <pipealloc+0x1bc>
ffff800000105f64:	90                   	nop
ffff800000105f65:	eb 01                	jmp    ffff800000105f68 <pipealloc+0x159>
ffff800000105f67:	90                   	nop
ffff800000105f68:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000105f6d:	74 13                	je     ffff800000105f82 <pipealloc+0x173>
ffff800000105f6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105f73:	48 89 c7             	mov    %rax,%rdi
ffff800000105f76:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000105f7d:	80 ff ff 
ffff800000105f80:	ff d0                	call   *%rax
ffff800000105f82:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f86:	48 8b 00             	mov    (%rax),%rax
ffff800000105f89:	48 85 c0             	test   %rax,%rax
ffff800000105f8c:	74 16                	je     ffff800000105fa4 <pipealloc+0x195>
ffff800000105f8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000105f92:	48 8b 00             	mov    (%rax),%rax
ffff800000105f95:	48 89 c7             	mov    %rax,%rdi
ffff800000105f98:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000105f9f:	80 ff ff 
ffff800000105fa2:	ff d0                	call   *%rax
ffff800000105fa4:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fa8:	48 8b 00             	mov    (%rax),%rax
ffff800000105fab:	48 85 c0             	test   %rax,%rax
ffff800000105fae:	74 16                	je     ffff800000105fc6 <pipealloc+0x1b7>
ffff800000105fb0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000105fb4:	48 8b 00             	mov    (%rax),%rax
ffff800000105fb7:	48 89 c7             	mov    %rax,%rdi
ffff800000105fba:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000105fc1:	80 ff ff 
ffff800000105fc4:	ff d0                	call   *%rax
ffff800000105fc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000105fcb:	c9                   	leave
ffff800000105fcc:	c3                   	ret

ffff800000105fcd <pipeclose>:
ffff800000105fcd:	55                   	push   %rbp
ffff800000105fce:	48 89 e5             	mov    %rsp,%rbp
ffff800000105fd1:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000105fd5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000105fd9:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000105fdc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105fe0:	48 89 c7             	mov    %rax,%rdi
ffff800000105fe3:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000105fea:	80 ff ff 
ffff800000105fed:	ff d0                	call   *%rax
ffff800000105fef:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000105ff3:	74 29                	je     ffff80000010601e <pipeclose+0x51>
ffff800000105ff5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000105ff9:	c7 80 74 02 00 00 00 	movl   $0x0,0x274(%rax)
ffff800000106000:	00 00 00 
ffff800000106003:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106007:	48 05 68 02 00 00    	add    $0x268,%rax
ffff80000010600d:	48 89 c7             	mov    %rax,%rdi
ffff800000106010:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000106017:	80 ff ff 
ffff80000010601a:	ff d0                	call   *%rax
ffff80000010601c:	eb 27                	jmp    ffff800000106045 <pipeclose+0x78>
ffff80000010601e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106022:	c7 80 70 02 00 00 00 	movl   $0x0,0x270(%rax)
ffff800000106029:	00 00 00 
ffff80000010602c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106030:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff800000106036:	48 89 c7             	mov    %rax,%rdi
ffff800000106039:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000106040:	80 ff ff 
ffff800000106043:	ff d0                	call   *%rax
ffff800000106045:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106049:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff80000010604f:	85 c0                	test   %eax,%eax
ffff800000106051:	75 36                	jne    ffff800000106089 <pipeclose+0xbc>
ffff800000106053:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106057:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff80000010605d:	85 c0                	test   %eax,%eax
ffff80000010605f:	75 28                	jne    ffff800000106089 <pipeclose+0xbc>
ffff800000106061:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106065:	48 89 c7             	mov    %rax,%rdi
ffff800000106068:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010606f:	80 ff ff 
ffff800000106072:	ff d0                	call   *%rax
ffff800000106074:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106078:	48 89 c7             	mov    %rax,%rdi
ffff80000010607b:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000106082:	80 ff ff 
ffff800000106085:	ff d0                	call   *%rax
ffff800000106087:	eb 14                	jmp    ffff80000010609d <pipeclose+0xd0>
ffff800000106089:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010608d:	48 89 c7             	mov    %rax,%rdi
ffff800000106090:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106097:	80 ff ff 
ffff80000010609a:	ff d0                	call   *%rax
ffff80000010609c:	90                   	nop
ffff80000010609d:	90                   	nop
ffff80000010609e:	c9                   	leave
ffff80000010609f:	c3                   	ret

ffff8000001060a0 <pipewrite>:
ffff8000001060a0:	55                   	push   %rbp
ffff8000001060a1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001060a4:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001060a8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001060ac:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001060b0:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff8000001060b3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001060ba:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001060c1:	80 ff ff 
ffff8000001060c4:	ff d0                	call   *%rax
ffff8000001060c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001060cd:	e9 d5 00 00 00       	jmp    ffff8000001061a7 <pipewrite+0x107>
ffff8000001060d2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060d6:	8b 80 70 02 00 00    	mov    0x270(%rax),%eax
ffff8000001060dc:	85 c0                	test   %eax,%eax
ffff8000001060de:	74 12                	je     ffff8000001060f2 <pipewrite+0x52>
ffff8000001060e0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001060e7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001060eb:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001060ee:	85 c0                	test   %eax,%eax
ffff8000001060f0:	74 1d                	je     ffff80000010610f <pipewrite+0x6f>
ffff8000001060f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001060f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001060f9:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106100:	80 ff ff 
ffff800000106103:	ff d0                	call   *%rax
ffff800000106105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010610a:	e9 cf 00 00 00       	jmp    ffff8000001061de <pipewrite+0x13e>
ffff80000010610f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106113:	48 05 68 02 00 00    	add    $0x268,%rax
ffff800000106119:	48 89 c7             	mov    %rax,%rdi
ffff80000010611c:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000106123:	80 ff ff 
ffff800000106126:	ff d0                	call   *%rax
ffff800000106128:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010612c:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106130:	48 81 c2 6c 02 00 00 	add    $0x26c,%rdx
ffff800000106137:	48 89 c6             	mov    %rax,%rsi
ffff80000010613a:	48 89 d7             	mov    %rdx,%rdi
ffff80000010613d:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000106144:	80 ff ff 
ffff800000106147:	ff d0                	call   *%rax
ffff800000106149:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010614d:	8b 90 6c 02 00 00    	mov    0x26c(%rax),%edx
ffff800000106153:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106157:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff80000010615d:	05 00 02 00 00       	add    $0x200,%eax
ffff800000106162:	39 c2                	cmp    %eax,%edx
ffff800000106164:	0f 84 68 ff ff ff    	je     ffff8000001060d2 <pipewrite+0x32>
ffff80000010616a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010616d:	48 63 d0             	movslq %eax,%rdx
ffff800000106170:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106174:	48 8d 34 02          	lea    (%rdx,%rax,1),%rsi
ffff800000106178:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010617c:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff800000106182:	8d 48 01             	lea    0x1(%rax),%ecx
ffff800000106185:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106189:	89 8a 6c 02 00 00    	mov    %ecx,0x26c(%rdx)
ffff80000010618f:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff800000106194:	89 c1                	mov    %eax,%ecx
ffff800000106196:	0f b6 16             	movzbl (%rsi),%edx
ffff800000106199:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010619d:	89 c9                	mov    %ecx,%ecx
ffff80000010619f:	88 54 08 68          	mov    %dl,0x68(%rax,%rcx,1)
ffff8000001061a3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001061a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001061aa:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001061ad:	7c 9a                	jl     ffff800000106149 <pipewrite+0xa9>
ffff8000001061af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061b3:	48 05 68 02 00 00    	add    $0x268,%rax
ffff8000001061b9:	48 89 c7             	mov    %rax,%rdi
ffff8000001061bc:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff8000001061c3:	80 ff ff 
ffff8000001061c6:	ff d0                	call   *%rax
ffff8000001061c8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001061cf:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001061d6:	80 ff ff 
ffff8000001061d9:	ff d0                	call   *%rax
ffff8000001061db:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001061de:	c9                   	leave
ffff8000001061df:	c3                   	ret

ffff8000001061e0 <piperead>:
ffff8000001061e0:	55                   	push   %rbp
ffff8000001061e1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001061e4:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001061e8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001061ec:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff8000001061f0:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff8000001061f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001061f7:	48 89 c7             	mov    %rax,%rdi
ffff8000001061fa:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000106201:	80 ff ff 
ffff800000106204:	ff d0                	call   *%rax
ffff800000106206:	eb 50                	jmp    ffff800000106258 <piperead+0x78>
ffff800000106208:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010620f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106213:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106216:	85 c0                	test   %eax,%eax
ffff800000106218:	74 1d                	je     ffff800000106237 <piperead+0x57>
ffff80000010621a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010621e:	48 89 c7             	mov    %rax,%rdi
ffff800000106221:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106228:	80 ff ff 
ffff80000010622b:	ff d0                	call   *%rax
ffff80000010622d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106232:	e9 de 00 00 00       	jmp    ffff800000106315 <piperead+0x135>
ffff800000106237:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010623b:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010623f:	48 81 c2 68 02 00 00 	add    $0x268,%rdx
ffff800000106246:	48 89 c6             	mov    %rax,%rsi
ffff800000106249:	48 89 d7             	mov    %rdx,%rdi
ffff80000010624c:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000106253:	80 ff ff 
ffff800000106256:	ff d0                	call   *%rax
ffff800000106258:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010625c:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106262:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106266:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010626c:	39 c2                	cmp    %eax,%edx
ffff80000010626e:	75 0e                	jne    ffff80000010627e <piperead+0x9e>
ffff800000106270:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106274:	8b 80 74 02 00 00    	mov    0x274(%rax),%eax
ffff80000010627a:	85 c0                	test   %eax,%eax
ffff80000010627c:	75 8a                	jne    ffff800000106208 <piperead+0x28>
ffff80000010627e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000106285:	eb 54                	jmp    ffff8000001062db <piperead+0xfb>
ffff800000106287:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010628b:	8b 90 68 02 00 00    	mov    0x268(%rax),%edx
ffff800000106291:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106295:	8b 80 6c 02 00 00    	mov    0x26c(%rax),%eax
ffff80000010629b:	39 c2                	cmp    %eax,%edx
ffff80000010629d:	74 46                	je     ffff8000001062e5 <piperead+0x105>
ffff80000010629f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062a3:	8b 80 68 02 00 00    	mov    0x268(%rax),%eax
ffff8000001062a9:	8d 48 01             	lea    0x1(%rax),%ecx
ffff8000001062ac:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001062b0:	89 8a 68 02 00 00    	mov    %ecx,0x268(%rdx)
ffff8000001062b6:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff8000001062bb:	89 c1                	mov    %eax,%ecx
ffff8000001062bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001062c0:	48 63 d0             	movslq %eax,%rdx
ffff8000001062c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001062c7:	48 01 c2             	add    %rax,%rdx
ffff8000001062ca:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062ce:	89 c9                	mov    %ecx,%ecx
ffff8000001062d0:	0f b6 44 08 68       	movzbl 0x68(%rax,%rcx,1),%eax
ffff8000001062d5:	88 02                	mov    %al,(%rdx)
ffff8000001062d7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001062db:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001062de:	3b 45 dc             	cmp    -0x24(%rbp),%eax
ffff8000001062e1:	7c a4                	jl     ffff800000106287 <piperead+0xa7>
ffff8000001062e3:	eb 01                	jmp    ffff8000001062e6 <piperead+0x106>
ffff8000001062e5:	90                   	nop
ffff8000001062e6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001062ea:	48 05 6c 02 00 00    	add    $0x26c,%rax
ffff8000001062f0:	48 89 c7             	mov    %rax,%rdi
ffff8000001062f3:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff8000001062fa:	80 ff ff 
ffff8000001062fd:	ff d0                	call   *%rax
ffff8000001062ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000106303:	48 89 c7             	mov    %rax,%rdi
ffff800000106306:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010630d:	80 ff ff 
ffff800000106310:	ff d0                	call   *%rax
ffff800000106312:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000106315:	c9                   	leave
ffff800000106316:	c3                   	ret

ffff800000106317 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline addr_t
readeflags(void)
{
ffff800000106317:	55                   	push   %rbp
ffff800000106318:	48 89 e5             	mov    %rsp,%rbp
ffff80000010631b:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t eflags;
  asm volatile("pushf; pop %0" : "=r" (eflags));
ffff80000010631f:	9c                   	pushf
ffff800000106320:	58                   	pop    %rax
ffff800000106321:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return eflags;
ffff800000106325:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff800000106329:	c9                   	leave
ffff80000010632a:	c3                   	ret

ffff80000010632b <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
ffff80000010632b:	55                   	push   %rbp
ffff80000010632c:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("sti");
ffff80000010632f:	fb                   	sti
}
ffff800000106330:	90                   	nop
ffff800000106331:	5d                   	pop    %rbp
ffff800000106332:	c3                   	ret

ffff800000106333 <hlt>:

static inline void
hlt(void)
{
ffff800000106333:	55                   	push   %rbp
ffff800000106334:	48 89 e5             	mov    %rsp,%rbp
  asm volatile("hlt");
ffff800000106337:	f4                   	hlt
}
ffff800000106338:	90                   	nop
ffff800000106339:	5d                   	pop    %rbp
ffff80000010633a:	c3                   	ret

ffff80000010633b <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
ffff80000010633b:	55                   	push   %rbp
ffff80000010633c:	48 89 e5             	mov    %rsp,%rbp
  initlock(&ptable.lock, "ptable");
ffff80000010633f:	48 ba b3 c8 10 00 00 	movabs $0xffff80000010c8b3,%rdx
ffff800000106346:	80 ff ff 
ffff800000106349:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106350:	80 ff ff 
ffff800000106353:	48 89 d6             	mov    %rdx,%rsi
ffff800000106356:	48 89 c7             	mov    %rax,%rdi
ffff800000106359:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff800000106360:	80 ff ff 
ffff800000106363:	ff d0                	call   *%rax
}
ffff800000106365:	90                   	nop
ffff800000106366:	5d                   	pop    %rbp
ffff800000106367:	c3                   	ret

ffff800000106368 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
ffff800000106368:	55                   	push   %rbp
ffff800000106369:	48 89 e5             	mov    %rsp,%rbp
ffff80000010636c:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
ffff800000106370:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106377:	80 ff ff 
ffff80000010637a:	48 89 c7             	mov    %rax,%rdi
ffff80000010637d:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000106384:	80 ff ff 
ffff800000106387:	ff d0                	call   *%rax

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000106389:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106390:	80 ff ff 
ffff800000106393:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106397:	eb 13                	jmp    ffff8000001063ac <allocproc+0x44>
    if(p->state == UNUSED)
ffff800000106399:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010639d:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001063a0:	85 c0                	test   %eax,%eax
ffff8000001063a2:	74 3b                	je     ffff8000001063df <allocproc+0x77>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001063a4:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff8000001063ab:	00 
ffff8000001063ac:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff8000001063b3:	80 ff ff 
ffff8000001063b6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff8000001063ba:	72 dd                	jb     ffff800000106399 <allocproc+0x31>
      goto found;

  release(&ptable.lock);
ffff8000001063bc:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001063c3:	80 ff ff 
ffff8000001063c6:	48 89 c7             	mov    %rax,%rdi
ffff8000001063c9:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001063d0:	80 ff ff 
ffff8000001063d3:	ff d0                	call   *%rax
  return 0;
ffff8000001063d5:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001063da:	e9 05 01 00 00       	jmp    ffff8000001064e4 <allocproc+0x17c>
      goto found;
ffff8000001063df:	90                   	nop

found:
  p->state = EMBRYO;
ffff8000001063e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001063e4:	c7 40 18 01 00 00 00 	movl   $0x1,0x18(%rax)
  p->pid = nextpid++;
ffff8000001063eb:	48 b8 40 d5 10 00 00 	movabs $0xffff80000010d540,%rax
ffff8000001063f2:	80 ff ff 
ffff8000001063f5:	8b 00                	mov    (%rax),%eax
ffff8000001063f7:	8d 50 01             	lea    0x1(%rax),%edx
ffff8000001063fa:	48 b9 40 d5 10 00 00 	movabs $0xffff80000010d540,%rcx
ffff800000106401:	80 ff ff 
ffff800000106404:	89 11                	mov    %edx,(%rcx)
ffff800000106406:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010640a:	89 42 1c             	mov    %eax,0x1c(%rdx)

  release(&ptable.lock);
ffff80000010640d:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106414:	80 ff ff 
ffff800000106417:	48 89 c7             	mov    %rax,%rdi
ffff80000010641a:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106421:	80 ff ff 
ffff800000106424:	ff d0                	call   *%rax

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
ffff800000106426:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010642d:	80 ff ff 
ffff800000106430:	ff d0                	call   *%rax
ffff800000106432:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106436:	48 89 42 10          	mov    %rax,0x10(%rdx)
ffff80000010643a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010643e:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106442:	48 85 c0             	test   %rax,%rax
ffff800000106445:	75 15                	jne    ffff80000010645c <allocproc+0xf4>
    p->state = UNUSED;
ffff800000106447:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010644b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return 0;
ffff800000106452:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000106457:	e9 88 00 00 00       	jmp    ffff8000001064e4 <allocproc+0x17c>
  }
  sp = p->kstack + KSTACKSIZE;
ffff80000010645c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106460:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106464:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010646a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
ffff80000010646e:	48 81 6d f0 b0 00 00 	subq   $0xb0,-0x10(%rbp)
ffff800000106475:	00 
  p->tf = (struct trapframe*)sp;
ffff800000106476:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010647a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010647e:	48 89 50 28          	mov    %rdx,0x28(%rax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= sizeof(addr_t);
ffff800000106482:	48 83 6d f0 08       	subq   $0x8,-0x10(%rbp)
  *(addr_t*)sp = (addr_t)syscall_trapret;
ffff800000106487:	48 ba 6f 99 10 00 00 	movabs $0xffff80000010996f,%rdx
ffff80000010648e:	80 ff ff 
ffff800000106491:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106495:	48 89 10             	mov    %rdx,(%rax)

  sp -= sizeof *p->context;
ffff800000106498:	48 83 6d f0 38       	subq   $0x38,-0x10(%rbp)
  p->context = (struct context*)sp;
ffff80000010649d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064a1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001064a5:	48 89 50 30          	mov    %rdx,0x30(%rax)
  memset(p->context, 0, sizeof *p->context);
ffff8000001064a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064ad:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001064b1:	ba 38 00 00 00       	mov    $0x38,%edx
ffff8000001064b6:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001064bb:	48 89 c7             	mov    %rax,%rdi
ffff8000001064be:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff8000001064c5:	80 ff ff 
ffff8000001064c8:	ff d0                	call   *%rax
  p->context->rip = (addr_t)forkret;
ffff8000001064ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001064ce:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff8000001064d2:	48 ba 76 70 10 00 00 	movabs $0xffff800000107076,%rdx
ffff8000001064d9:	80 ff ff 
ffff8000001064dc:	48 89 50 30          	mov    %rdx,0x30(%rax)

  return p;
ffff8000001064e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001064e4:	c9                   	leave
ffff8000001064e5:	c3                   	ret

ffff8000001064e6 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
ffff8000001064e6:	55                   	push   %rbp
ffff8000001064e7:	48 89 e5             	mov    %rsp,%rbp
ffff8000001064ea:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];
  p = allocproc();
ffff8000001064ee:	48 b8 68 63 10 00 00 	movabs $0xffff800000106368,%rax
ffff8000001064f5:	80 ff ff 
ffff8000001064f8:	ff d0                	call   *%rax
ffff8000001064fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  initproc = p;
ffff8000001064fe:	48 ba a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rdx
ffff800000106505:	80 ff ff 
ffff800000106508:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010650c:	48 89 02             	mov    %rax,(%rdx)
  if((p->pgdir = setupkvm()) == 0)
ffff80000010650f:	48 b8 2f b2 10 00 00 	movabs $0xffff80000010b22f,%rax
ffff800000106516:	80 ff ff 
ffff800000106519:	ff d0                	call   *%rax
ffff80000010651b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010651f:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106523:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106527:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010652b:	48 85 c0             	test   %rax,%rax
ffff80000010652e:	75 19                	jne    ffff800000106549 <userinit+0x63>
    panic("userinit: out of memory?");
ffff800000106530:	48 b8 ba c8 10 00 00 	movabs $0xffff80000010c8ba,%rax
ffff800000106537:	80 ff ff 
ffff80000010653a:	48 89 c7             	mov    %rax,%rdi
ffff80000010653d:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106544:	80 ff ff 
ffff800000106547:	ff d0                	call   *%rax

  inituvm(p->pgdir, _binary_initcode_start,
ffff800000106549:	48 b8 40 00 00 00 00 	movabs $0x40,%rax
ffff800000106550:	00 00 00 
ffff800000106553:	89 c2                	mov    %eax,%edx
ffff800000106555:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106559:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010655d:	48 b9 50 df 10 00 00 	movabs $0xffff80000010df50,%rcx
ffff800000106564:	80 ff ff 
ffff800000106567:	48 89 ce             	mov    %rcx,%rsi
ffff80000010656a:	48 89 c7             	mov    %rax,%rdi
ffff80000010656d:	48 b8 a5 b7 10 00 00 	movabs $0xffff80000010b7a5,%rax
ffff800000106574:	80 ff ff 
ffff800000106577:	ff d0                	call   *%rax
          (addr_t)_binary_initcode_size);
  p->sz = PGSIZE * 2;
ffff800000106579:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010657d:	48 c7 00 00 20 00 00 	movq   $0x2000,(%rax)
  memset(p->tf, 0, sizeof(*p->tf));
ffff800000106584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106588:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010658c:	ba b0 00 00 00       	mov    $0xb0,%edx
ffff800000106591:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000106596:	48 89 c7             	mov    %rax,%rdi
ffff800000106599:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff8000001065a0:	80 ff ff 
ffff8000001065a3:	ff d0                	call   *%rax

  p->tf->r11 = FL_IF;  // with SYSRET, EFLAGS is in R11
ffff8000001065a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065a9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065ad:	48 c7 40 50 00 02 00 	movq   $0x200,0x50(%rax)
ffff8000001065b4:	00 
  p->tf->rsp = p->sz;
ffff8000001065b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065b9:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065bd:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001065c1:	48 8b 12             	mov    (%rdx),%rdx
ffff8000001065c4:	48 89 90 a0 00 00 00 	mov    %rdx,0xa0(%rax)
  p->tf->rcx = PGSIZE;  // with SYSRET, RIP is in RCX
ffff8000001065cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065cf:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001065d3:	48 c7 40 10 00 10 00 	movq   $0x1000,0x10(%rax)
ffff8000001065da:	00 

  safestrcpy(p->name, "initcode", sizeof(p->name));
ffff8000001065db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001065df:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff8000001065e5:	48 b9 d3 c8 10 00 00 	movabs $0xffff80000010c8d3,%rcx
ffff8000001065ec:	80 ff ff 
ffff8000001065ef:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001065f4:	48 89 ce             	mov    %rcx,%rsi
ffff8000001065f7:	48 89 c7             	mov    %rax,%rdi
ffff8000001065fa:	48 b8 26 7d 10 00 00 	movabs $0xffff800000107d26,%rax
ffff800000106601:	80 ff ff 
ffff800000106604:	ff d0                	call   *%rax
  p->cwd = namei("/");
ffff800000106606:	48 b8 dc c8 10 00 00 	movabs $0xffff80000010c8dc,%rax
ffff80000010660d:	80 ff ff 
ffff800000106610:	48 89 c7             	mov    %rax,%rdi
ffff800000106613:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff80000010661a:	80 ff ff 
ffff80000010661d:	ff d0                	call   *%rax
ffff80000010661f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000106623:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  __sync_synchronize();
ffff80000010662a:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  p->state = RUNNABLE;
ffff800000106630:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106634:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
}
ffff80000010663b:	90                   	nop
ffff80000010663c:	c9                   	leave
ffff80000010663d:	c3                   	ret

ffff80000010663e <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int64 n)
{
ffff80000010663e:	55                   	push   %rbp
ffff80000010663f:	48 89 e5             	mov    %rsp,%rbp
ffff800000106642:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000106646:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  addr_t sz;

  sz = proc->sz;
ffff80000010664a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106651:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106655:	48 8b 00             	mov    (%rax),%rax
ffff800000106658:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(n > 0){
ffff80000010665c:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000106661:	7e 42                	jle    ffff8000001066a5 <growproc+0x67>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff800000106663:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000106667:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010666b:	48 01 c2             	add    %rax,%rdx
ffff80000010666e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106675:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106679:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010667d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000106681:	48 89 ce             	mov    %rcx,%rsi
ffff800000106684:	48 89 c7             	mov    %rax,%rdi
ffff800000106687:	48 b8 86 b9 10 00 00 	movabs $0xffff80000010b986,%rax
ffff80000010668e:	80 ff ff 
ffff800000106691:	ff d0                	call   *%rax
ffff800000106693:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106697:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010669c:	75 50                	jne    ffff8000001066ee <growproc+0xb0>
      return -1;
ffff80000010669e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001066a3:	eb 7a                	jmp    ffff80000010671f <growproc+0xe1>
  } else if(n < 0){
ffff8000001066a5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff8000001066aa:	79 42                	jns    ffff8000001066ee <growproc+0xb0>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
ffff8000001066ac:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001066b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001066b4:	48 01 c2             	add    %rax,%rdx
ffff8000001066b7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066be:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066c2:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff8000001066c6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff8000001066ca:	48 89 ce             	mov    %rcx,%rsi
ffff8000001066cd:	48 89 c7             	mov    %rax,%rdi
ffff8000001066d0:	48 b8 ca ba 10 00 00 	movabs $0xffff80000010baca,%rax
ffff8000001066d7:	80 ff ff 
ffff8000001066da:	ff d0                	call   *%rax
ffff8000001066dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001066e0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001066e5:	75 07                	jne    ffff8000001066ee <growproc+0xb0>
      return -1;
ffff8000001066e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001066ec:	eb 31                	jmp    ffff80000010671f <growproc+0xe1>
  }
  proc->sz = sz;
ffff8000001066ee:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001066f5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001066f9:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001066fd:	48 89 10             	mov    %rdx,(%rax)
  switchuvm(proc);
ffff800000106700:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106707:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010670b:	48 89 c7             	mov    %rax,%rdi
ffff80000010670e:	48 b8 8d b3 10 00 00 	movabs $0xffff80000010b38d,%rax
ffff800000106715:	80 ff ff 
ffff800000106718:	ff d0                	call   *%rax
  return 0;
ffff80000010671a:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010671f:	c9                   	leave
ffff800000106720:	c3                   	ret

ffff800000106721 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
ffff800000106721:	55                   	push   %rbp
ffff800000106722:	48 89 e5             	mov    %rsp,%rbp
ffff800000106725:	53                   	push   %rbx
ffff800000106726:	48 83 ec 28          	sub    $0x28,%rsp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
ffff80000010672a:	48 b8 68 63 10 00 00 	movabs $0xffff800000106368,%rax
ffff800000106731:	80 ff ff 
ffff800000106734:	ff d0                	call   *%rax
ffff800000106736:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010673a:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010673f:	75 0a                	jne    ffff80000010674b <fork+0x2a>
    return -1;
ffff800000106741:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106746:	e9 c4 02 00 00       	jmp    ffff800000106a0f <fork+0x2ee>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffff80000010674b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106752:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106756:	48 8b 00             	mov    (%rax),%rax
ffff800000106759:	89 c2                	mov    %eax,%edx
ffff80000010675b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106762:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106766:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010676a:	89 d6                	mov    %edx,%esi
ffff80000010676c:	48 89 c7             	mov    %rax,%rdi
ffff80000010676f:	48 b8 65 be 10 00 00 	movabs $0xffff80000010be65,%rax
ffff800000106776:	80 ff ff 
ffff800000106779:	ff d0                	call   *%rax
ffff80000010677b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010677f:	48 89 42 08          	mov    %rax,0x8(%rdx)
ffff800000106783:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106787:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010678b:	48 85 c0             	test   %rax,%rax
ffff80000010678e:	75 38                	jne    ffff8000001067c8 <fork+0xa7>
    kfree(np->kstack);
ffff800000106790:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106794:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106798:	48 89 c7             	mov    %rax,%rdi
ffff80000010679b:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff8000001067a2:	80 ff ff 
ffff8000001067a5:	ff d0                	call   *%rax
    np->kstack = 0;
ffff8000001067a7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067ab:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001067b2:	00 
    np->state = UNUSED;
ffff8000001067b3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067b7:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
    return -1;
ffff8000001067be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001067c3:	e9 47 02 00 00       	jmp    ffff800000106a0f <fork+0x2ee>
  }
  np->sz = proc->sz;
ffff8000001067c8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067cf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067d3:	48 8b 10             	mov    (%rax),%rdx
ffff8000001067d6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067da:	48 89 10             	mov    %rdx,(%rax)
  np->parent = proc;
ffff8000001067dd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067e4:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff8000001067e8:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001067ec:	48 89 50 20          	mov    %rdx,0x20(%rax)
  *np->tf = *proc->tf;
ffff8000001067f0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001067f7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001067fb:	48 8b 50 28          	mov    0x28(%rax),%rdx
ffff8000001067ff:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106803:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000106807:	48 8b 0a             	mov    (%rdx),%rcx
ffff80000010680a:	48 8b 5a 08          	mov    0x8(%rdx),%rbx
ffff80000010680e:	48 89 08             	mov    %rcx,(%rax)
ffff800000106811:	48 89 58 08          	mov    %rbx,0x8(%rax)
ffff800000106815:	48 8b 4a 10          	mov    0x10(%rdx),%rcx
ffff800000106819:	48 8b 5a 18          	mov    0x18(%rdx),%rbx
ffff80000010681d:	48 89 48 10          	mov    %rcx,0x10(%rax)
ffff800000106821:	48 89 58 18          	mov    %rbx,0x18(%rax)
ffff800000106825:	48 8b 4a 20          	mov    0x20(%rdx),%rcx
ffff800000106829:	48 8b 5a 28          	mov    0x28(%rdx),%rbx
ffff80000010682d:	48 89 48 20          	mov    %rcx,0x20(%rax)
ffff800000106831:	48 89 58 28          	mov    %rbx,0x28(%rax)
ffff800000106835:	48 8b 4a 30          	mov    0x30(%rdx),%rcx
ffff800000106839:	48 8b 5a 38          	mov    0x38(%rdx),%rbx
ffff80000010683d:	48 89 48 30          	mov    %rcx,0x30(%rax)
ffff800000106841:	48 89 58 38          	mov    %rbx,0x38(%rax)
ffff800000106845:	48 8b 4a 40          	mov    0x40(%rdx),%rcx
ffff800000106849:	48 8b 5a 48          	mov    0x48(%rdx),%rbx
ffff80000010684d:	48 89 48 40          	mov    %rcx,0x40(%rax)
ffff800000106851:	48 89 58 48          	mov    %rbx,0x48(%rax)
ffff800000106855:	48 8b 4a 50          	mov    0x50(%rdx),%rcx
ffff800000106859:	48 8b 5a 58          	mov    0x58(%rdx),%rbx
ffff80000010685d:	48 89 48 50          	mov    %rcx,0x50(%rax)
ffff800000106861:	48 89 58 58          	mov    %rbx,0x58(%rax)
ffff800000106865:	48 8b 4a 60          	mov    0x60(%rdx),%rcx
ffff800000106869:	48 8b 5a 68          	mov    0x68(%rdx),%rbx
ffff80000010686d:	48 89 48 60          	mov    %rcx,0x60(%rax)
ffff800000106871:	48 89 58 68          	mov    %rbx,0x68(%rax)
ffff800000106875:	48 8b 4a 70          	mov    0x70(%rdx),%rcx
ffff800000106879:	48 8b 5a 78          	mov    0x78(%rdx),%rbx
ffff80000010687d:	48 89 48 70          	mov    %rcx,0x70(%rax)
ffff800000106881:	48 89 58 78          	mov    %rbx,0x78(%rax)
ffff800000106885:	48 8b 8a 80 00 00 00 	mov    0x80(%rdx),%rcx
ffff80000010688c:	48 8b 9a 88 00 00 00 	mov    0x88(%rdx),%rbx
ffff800000106893:	48 89 88 80 00 00 00 	mov    %rcx,0x80(%rax)
ffff80000010689a:	48 89 98 88 00 00 00 	mov    %rbx,0x88(%rax)
ffff8000001068a1:	48 8b 8a 90 00 00 00 	mov    0x90(%rdx),%rcx
ffff8000001068a8:	48 8b 9a 98 00 00 00 	mov    0x98(%rdx),%rbx
ffff8000001068af:	48 89 88 90 00 00 00 	mov    %rcx,0x90(%rax)
ffff8000001068b6:	48 89 98 98 00 00 00 	mov    %rbx,0x98(%rax)
ffff8000001068bd:	48 8b 8a a0 00 00 00 	mov    0xa0(%rdx),%rcx
ffff8000001068c4:	48 8b 9a a8 00 00 00 	mov    0xa8(%rdx),%rbx
ffff8000001068cb:	48 89 88 a0 00 00 00 	mov    %rcx,0xa0(%rax)
ffff8000001068d2:	48 89 98 a8 00 00 00 	mov    %rbx,0xa8(%rax)

  // Clear %rax so that fork returns 0 in the child.
  np->tf->rax = 0;
ffff8000001068d9:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001068dd:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff8000001068e1:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)

  for(i = 0; i < NOFILE; i++)
ffff8000001068e8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
ffff8000001068ef:	eb 5f                	jmp    ffff800000106950 <fork+0x22f>
    if(proc->ofile[i])
ffff8000001068f1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001068f8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001068fc:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff8000001068ff:	48 63 d2             	movslq %edx,%rdx
ffff800000106902:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106906:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010690b:	48 85 c0             	test   %rax,%rax
ffff80000010690e:	74 3c                	je     ffff80000010694c <fork+0x22b>
      np->ofile[i] = filedup(proc->ofile[i]);
ffff800000106910:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106917:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010691b:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010691e:	48 63 d2             	movslq %edx,%rdx
ffff800000106921:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106925:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010692a:	48 89 c7             	mov    %rax,%rdi
ffff80000010692d:	48 b8 0d 1d 10 00 00 	movabs $0xffff800000101d0d,%rax
ffff800000106934:	80 ff ff 
ffff800000106937:	ff d0                	call   *%rax
ffff800000106939:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010693d:	8b 4d ec             	mov    -0x14(%rbp),%ecx
ffff800000106940:	48 63 c9             	movslq %ecx,%rcx
ffff800000106943:	48 83 c1 08          	add    $0x8,%rcx
ffff800000106947:	48 89 44 ca 08       	mov    %rax,0x8(%rdx,%rcx,8)
  for(i = 0; i < NOFILE; i++)
ffff80000010694c:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
ffff800000106950:	83 7d ec 0f          	cmpl   $0xf,-0x14(%rbp)
ffff800000106954:	7e 9b                	jle    ffff8000001068f1 <fork+0x1d0>
  np->cwd = idup(proc->cwd);
ffff800000106956:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010695d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106961:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106968:	48 89 c7             	mov    %rax,%rdi
ffff80000010696b:	48 b8 5f 29 10 00 00 	movabs $0xffff80000010295f,%rax
ffff800000106972:	80 ff ff 
ffff800000106975:	ff d0                	call   *%rax
ffff800000106977:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010697b:	48 89 82 c8 00 00 00 	mov    %rax,0xc8(%rdx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
ffff800000106982:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106989:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010698d:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff800000106994:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000106998:	48 05 d0 00 00 00    	add    $0xd0,%rax
ffff80000010699e:	ba 10 00 00 00       	mov    $0x10,%edx
ffff8000001069a3:	48 89 ce             	mov    %rcx,%rsi
ffff8000001069a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001069a9:	48 b8 26 7d 10 00 00 	movabs $0xffff800000107d26,%rax
ffff8000001069b0:	80 ff ff 
ffff8000001069b3:	ff d0                	call   *%rax

  pid = np->pid;
ffff8000001069b5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069b9:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001069bc:	89 45 dc             	mov    %eax,-0x24(%rbp)

  __sync_synchronize();
ffff8000001069bf:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
  np->state = RUNNABLE;
ffff8000001069c5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001069c9:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)

  // Trace the event
  traceevent(TRACE_TYPE_PROC, pid, proc->pid, 0, 0, "fork");
ffff8000001069d0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001069d7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001069db:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff8000001069de:	48 b9 de c8 10 00 00 	movabs $0xffff80000010c8de,%rcx
ffff8000001069e5:	80 ff ff 
ffff8000001069e8:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff8000001069eb:	49 89 c9             	mov    %rcx,%r9
ffff8000001069ee:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffff8000001069f4:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff8000001069f9:	89 c6                	mov    %eax,%esi
ffff8000001069fb:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000106a00:	48 b8 c4 c1 10 00 00 	movabs $0xffff80000010c1c4,%rax
ffff800000106a07:	80 ff ff 
ffff800000106a0a:	ff d0                	call   *%rax

  return pid;
ffff800000106a0c:	8b 45 dc             	mov    -0x24(%rbp),%eax
}
ffff800000106a0f:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff800000106a13:	c9                   	leave
ffff800000106a14:	c3                   	ret

ffff800000106a15 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
ffff800000106a15:	55                   	push   %rbp
ffff800000106a16:	48 89 e5             	mov    %rsp,%rbp
ffff800000106a19:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int fd;

  if(proc == initproc)
ffff800000106a1d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a24:	64 48 8b 10          	mov    %fs:(%rax),%rdx
ffff800000106a28:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106a2f:	80 ff ff 
ffff800000106a32:	48 8b 00             	mov    (%rax),%rax
ffff800000106a35:	48 39 c2             	cmp    %rax,%rdx
ffff800000106a38:	75 19                	jne    ffff800000106a53 <exit+0x3e>
    panic("init exiting");
ffff800000106a3a:	48 b8 e3 c8 10 00 00 	movabs $0xffff80000010c8e3,%rax
ffff800000106a41:	80 ff ff 
ffff800000106a44:	48 89 c7             	mov    %rax,%rdi
ffff800000106a47:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106a4e:	80 ff ff 
ffff800000106a51:	ff d0                	call   *%rax

  traceevent(TRACE_TYPE_PROC, proc->pid, 0, 0, 0, "exit");
ffff800000106a53:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106a5a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106a5e:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106a61:	48 ba f0 c8 10 00 00 	movabs $0xffff80000010c8f0,%rdx
ffff800000106a68:	80 ff ff 
ffff800000106a6b:	49 89 d1             	mov    %rdx,%r9
ffff800000106a6e:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffff800000106a74:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000106a79:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000106a7e:	89 c6                	mov    %eax,%esi
ffff800000106a80:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000106a85:	48 b8 c4 c1 10 00 00 	movabs $0xffff80000010c1c4,%rax
ffff800000106a8c:	80 ff ff 
ffff800000106a8f:	ff d0                	call   *%rax

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106a91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff800000106a98:	eb 6a                	jmp    ffff800000106b04 <exit+0xef>
    if(proc->ofile[fd]){
ffff800000106a9a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106aa1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106aa5:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106aa8:	48 63 d2             	movslq %edx,%rdx
ffff800000106aab:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106aaf:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106ab4:	48 85 c0             	test   %rax,%rax
ffff800000106ab7:	74 47                	je     ffff800000106b00 <exit+0xeb>
      fileclose(proc->ofile[fd]);
ffff800000106ab9:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ac0:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106ac4:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106ac7:	48 63 d2             	movslq %edx,%rdx
ffff800000106aca:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106ace:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff800000106ad3:	48 89 c7             	mov    %rax,%rdi
ffff800000106ad6:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000106add:	80 ff ff 
ffff800000106ae0:	ff d0                	call   *%rax
      proc->ofile[fd] = 0;
ffff800000106ae2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ae9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106aed:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000106af0:	48 63 d2             	movslq %edx,%rdx
ffff800000106af3:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106af7:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff800000106afe:	00 00 
  for(fd = 0; fd < NOFILE; fd++){
ffff800000106b00:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff800000106b04:	83 7d f4 0f          	cmpl   $0xf,-0xc(%rbp)
ffff800000106b08:	7e 90                	jle    ffff800000106a9a <exit+0x85>
    }
  }

  begin_op();
ffff800000106b0a:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff800000106b11:	80 ff ff 
ffff800000106b14:	ff d0                	call   *%rax
  iput(proc->cwd);
ffff800000106b16:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b1d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b21:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000106b28:	48 89 c7             	mov    %rax,%rdi
ffff800000106b2b:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff800000106b32:	80 ff ff 
ffff800000106b35:	ff d0                	call   *%rax
  end_op();
ffff800000106b37:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000106b3e:	80 ff ff 
ffff800000106b41:	ff d0                	call   *%rax
  proc->cwd = 0;
ffff800000106b43:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b4a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b4e:	48 c7 80 c8 00 00 00 	movq   $0x0,0xc8(%rax)
ffff800000106b55:	00 00 00 00 

  acquire(&ptable.lock);
ffff800000106b59:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106b60:	80 ff ff 
ffff800000106b63:	48 89 c7             	mov    %rax,%rdi
ffff800000106b66:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000106b6d:	80 ff ff 
ffff800000106b70:	ff d0                	call   *%rax

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
ffff800000106b72:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106b79:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106b7d:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff800000106b81:	48 89 c7             	mov    %rax,%rdi
ffff800000106b84:	48 b8 f0 71 10 00 00 	movabs $0xffff8000001071f0,%rax
ffff800000106b8b:	80 ff ff 
ffff800000106b8e:	ff d0                	call   *%rax

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106b90:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106b97:	80 ff ff 
ffff800000106b9a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106b9e:	eb 5d                	jmp    ffff800000106bfd <exit+0x1e8>
    if(p->parent == proc){
ffff800000106ba0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ba4:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106ba8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106baf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106bb3:	48 39 c2             	cmp    %rax,%rdx
ffff800000106bb6:	75 3d                	jne    ffff800000106bf5 <exit+0x1e0>
      p->parent = initproc;
ffff800000106bb8:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106bbf:	80 ff ff 
ffff800000106bc2:	48 8b 10             	mov    (%rax),%rdx
ffff800000106bc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106bc9:	48 89 50 20          	mov    %rdx,0x20(%rax)
      if(p->state == ZOMBIE)
ffff800000106bcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106bd1:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106bd4:	83 f8 05             	cmp    $0x5,%eax
ffff800000106bd7:	75 1c                	jne    ffff800000106bf5 <exit+0x1e0>
        wakeup1(initproc);
ffff800000106bd9:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106be0:	80 ff ff 
ffff800000106be3:	48 8b 00             	mov    (%rax),%rax
ffff800000106be6:	48 89 c7             	mov    %rax,%rdi
ffff800000106be9:	48 b8 f0 71 10 00 00 	movabs $0xffff8000001071f0,%rax
ffff800000106bf0:	80 ff ff 
ffff800000106bf3:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106bf5:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106bfc:	00 
ffff800000106bfd:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106c04:	80 ff ff 
ffff800000106c07:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106c0b:	72 93                	jb     ffff800000106ba0 <exit+0x18b>
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
ffff800000106c0d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c14:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c18:	c7 40 18 05 00 00 00 	movl   $0x5,0x18(%rax)
  sched();
ffff800000106c1f:	48 b8 05 6f 10 00 00 	movabs $0xffff800000106f05,%rax
ffff800000106c26:	80 ff ff 
ffff800000106c29:	ff d0                	call   *%rax
  panic("zombie exit");
ffff800000106c2b:	48 b8 f5 c8 10 00 00 	movabs $0xffff80000010c8f5,%rax
ffff800000106c32:	80 ff ff 
ffff800000106c35:	48 89 c7             	mov    %rax,%rdi
ffff800000106c38:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106c3f:	80 ff ff 
ffff800000106c42:	ff d0                	call   *%rax

ffff800000106c44 <wait>:
//PAGEBREAK!
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
ffff800000106c44:	55                   	push   %rbp
ffff800000106c45:	48 89 e5             	mov    %rsp,%rbp
ffff800000106c48:	48 83 ec 10          	sub    $0x10,%rsp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
ffff800000106c4c:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106c53:	80 ff ff 
ffff800000106c56:	48 89 c7             	mov    %rax,%rdi
ffff800000106c59:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000106c60:	80 ff ff 
ffff800000106c63:	ff d0                	call   *%rax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
ffff800000106c65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106c6c:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106c73:	80 ff ff 
ffff800000106c76:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000106c7a:	e9 d9 00 00 00       	jmp    ffff800000106d58 <wait+0x114>
      if(p->parent != proc)
ffff800000106c7f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106c83:	48 8b 50 20          	mov    0x20(%rax),%rdx
ffff800000106c87:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106c8e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106c92:	48 39 c2             	cmp    %rax,%rdx
ffff800000106c95:	0f 85 b4 00 00 00    	jne    ffff800000106d4f <wait+0x10b>
        continue;
      havekids = 1;
ffff800000106c9b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%rbp)
      if(p->state == ZOMBIE){
ffff800000106ca2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ca6:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106ca9:	83 f8 05             	cmp    $0x5,%eax
ffff800000106cac:	0f 85 9e 00 00 00    	jne    ffff800000106d50 <wait+0x10c>
        // Found one.
        pid = p->pid;
ffff800000106cb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cb6:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000106cb9:	89 45 f0             	mov    %eax,-0x10(%rbp)
        kfree(p->kstack);
ffff800000106cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cc0:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000106cc4:	48 89 c7             	mov    %rax,%rdi
ffff800000106cc7:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff800000106cce:	80 ff ff 
ffff800000106cd1:	ff d0                	call   *%rax
        p->kstack = 0;
ffff800000106cd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cd7:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff800000106cde:	00 
        freevm(p->pgdir);
ffff800000106cdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106ce3:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106ce7:	48 89 c7             	mov    %rax,%rdi
ffff800000106cea:	48 b8 c3 bb 10 00 00 	movabs $0xffff80000010bbc3,%rax
ffff800000106cf1:	80 ff ff 
ffff800000106cf4:	ff d0                	call   *%rax
        p->pid = 0;
ffff800000106cf6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106cfa:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%rax)
        p->parent = 0;
ffff800000106d01:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d05:	48 c7 40 20 00 00 00 	movq   $0x0,0x20(%rax)
ffff800000106d0c:	00 
        p->name[0] = 0;
ffff800000106d0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d11:	c6 80 d0 00 00 00 00 	movb   $0x0,0xd0(%rax)
        p->killed = 0;
ffff800000106d18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d1c:	c7 40 40 00 00 00 00 	movl   $0x0,0x40(%rax)
        p->state = UNUSED;
ffff800000106d23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000106d27:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%rax)
        release(&ptable.lock);
ffff800000106d2e:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106d35:	80 ff ff 
ffff800000106d38:	48 89 c7             	mov    %rax,%rdi
ffff800000106d3b:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106d42:	80 ff ff 
ffff800000106d45:	ff d0                	call   *%rax
        return pid;
ffff800000106d47:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000106d4a:	e9 81 00 00 00       	jmp    ffff800000106dd0 <wait+0x18c>
        continue;
ffff800000106d4f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106d50:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000106d57:	00 
ffff800000106d58:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106d5f:	80 ff ff 
ffff800000106d62:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000106d66:	0f 82 13 ff ff ff    	jb     ffff800000106c7f <wait+0x3b>
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
ffff800000106d6c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
ffff800000106d70:	74 12                	je     ffff800000106d84 <wait+0x140>
ffff800000106d72:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106d79:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106d7d:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000106d80:	85 c0                	test   %eax,%eax
ffff800000106d82:	74 20                	je     ffff800000106da4 <wait+0x160>
      release(&ptable.lock);
ffff800000106d84:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106d8b:	80 ff ff 
ffff800000106d8e:	48 89 c7             	mov    %rax,%rdi
ffff800000106d91:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106d98:	80 ff ff 
ffff800000106d9b:	ff d0                	call   *%rax
      return -1;
ffff800000106d9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000106da2:	eb 2c                	jmp    ffff800000106dd0 <wait+0x18c>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffff800000106da4:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106dab:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106daf:	48 ba 40 84 11 00 00 	movabs $0xffff800000118440,%rdx
ffff800000106db6:	80 ff ff 
ffff800000106db9:	48 89 d6             	mov    %rdx,%rsi
ffff800000106dbc:	48 89 c7             	mov    %rax,%rdi
ffff800000106dbf:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000106dc6:	80 ff ff 
ffff800000106dc9:	ff d0                	call   *%rax
    havekids = 0;
ffff800000106dcb:	e9 95 fe ff ff       	jmp    ffff800000106c65 <wait+0x21>
  }
}
ffff800000106dd0:	c9                   	leave
ffff800000106dd1:	c3                   	ret

ffff800000106dd2 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
ffff800000106dd2:	55                   	push   %rbp
ffff800000106dd3:	48 89 e5             	mov    %rsp,%rbp
ffff800000106dd6:	48 83 ec 20          	sub    $0x20,%rsp
  int i = 0;
ffff800000106dda:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  struct proc *p;
  int skipped = 0;
ffff800000106de1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  for(;;){
    ++i;
ffff800000106de8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    // Enable interrupts on this processor.
    sti();
ffff800000106dec:	48 b8 2b 63 10 00 00 	movabs $0xffff80000010632b,%rax
ffff800000106df3:	80 ff ff 
ffff800000106df6:	ff d0                	call   *%rax
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
ffff800000106df8:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106dff:	80 ff ff 
ffff800000106e02:	48 89 c7             	mov    %rax,%rdi
ffff800000106e05:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000106e0c:	80 ff ff 
ffff800000106e0f:	ff d0                	call   *%rax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106e11:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000106e18:	80 ff ff 
ffff800000106e1b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000106e1f:	e9 92 00 00 00       	jmp    ffff800000106eb6 <scheduler+0xe4>
      if(p->state != RUNNABLE) {
ffff800000106e24:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e28:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106e2b:	83 f8 03             	cmp    $0x3,%eax
ffff800000106e2e:	74 06                	je     ffff800000106e36 <scheduler+0x64>
        skipped++;
ffff800000106e30:	83 45 ec 01          	addl   $0x1,-0x14(%rbp)
        continue;
ffff800000106e34:	eb 78                	jmp    ffff800000106eae <scheduler+0xdc>
      }
      skipped = 0;
ffff800000106e36:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
ffff800000106e3d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106e44:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000106e48:	64 48 89 10          	mov    %rdx,%fs:(%rax)
      switchuvm(p);
ffff800000106e4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e50:	48 89 c7             	mov    %rax,%rdi
ffff800000106e53:	48 b8 8d b3 10 00 00 	movabs $0xffff80000010b38d,%rax
ffff800000106e5a:	80 ff ff 
ffff800000106e5d:	ff d0                	call   *%rax
      p->state = RUNNING;
ffff800000106e5f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e63:	c7 40 18 04 00 00 00 	movl   $0x4,0x18(%rax)
      swtch(&cpu->scheduler, p->context);
ffff800000106e6a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000106e6e:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000106e72:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000106e79:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106e7d:	48 83 c2 08          	add    $0x8,%rdx
ffff800000106e81:	48 89 c6             	mov    %rax,%rsi
ffff800000106e84:	48 89 d7             	mov    %rdx,%rdi
ffff800000106e87:	48 b8 bb 7d 10 00 00 	movabs $0xffff800000107dbb,%rax
ffff800000106e8e:	80 ff ff 
ffff800000106e91:	ff d0                	call   *%rax
      switchkvm();
ffff800000106e93:	48 b8 99 b6 10 00 00 	movabs $0xffff80000010b699,%rax
ffff800000106e9a:	80 ff ff 
ffff800000106e9d:	ff d0                	call   *%rax

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
ffff800000106e9f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106ea6:	64 48 c7 00 00 00 00 	movq   $0x0,%fs:(%rax)
ffff800000106ead:	00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000106eae:	48 81 45 f0 e0 00 00 	addq   $0xe0,-0x10(%rbp)
ffff800000106eb5:	00 
ffff800000106eb6:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000106ebd:	80 ff ff 
ffff800000106ec0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000106ec4:	0f 82 5a ff ff ff    	jb     ffff800000106e24 <scheduler+0x52>
    }
    release(&ptable.lock);
ffff800000106eca:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106ed1:	80 ff ff 
ffff800000106ed4:	48 89 c7             	mov    %rax,%rdi
ffff800000106ed7:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000106ede:	80 ff ff 
ffff800000106ee1:	ff d0                	call   *%rax
    if (skipped > NPROC) {
ffff800000106ee3:	83 7d ec 40          	cmpl   $0x40,-0x14(%rbp)
ffff800000106ee7:	0f 8e fb fe ff ff    	jle    ffff800000106de8 <scheduler+0x16>
      hlt();
ffff800000106eed:	48 b8 33 63 10 00 00 	movabs $0xffff800000106333,%rax
ffff800000106ef4:	80 ff ff 
ffff800000106ef7:	ff d0                	call   *%rax
      skipped = 0;
ffff800000106ef9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    ++i;
ffff800000106f00:	e9 e3 fe ff ff       	jmp    ffff800000106de8 <scheduler+0x16>

ffff800000106f05 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
ffff800000106f05:	55                   	push   %rbp
ffff800000106f06:	48 89 e5             	mov    %rsp,%rbp
ffff800000106f09:	48 83 ec 10          	sub    $0x10,%rsp
  int intena;


  if(!holding(&ptable.lock))
ffff800000106f0d:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000106f14:	80 ff ff 
ffff800000106f17:	48 89 c7             	mov    %rax,%rdi
ffff800000106f1a:	48 b8 be 78 10 00 00 	movabs $0xffff8000001078be,%rax
ffff800000106f21:	80 ff ff 
ffff800000106f24:	ff d0                	call   *%rax
ffff800000106f26:	85 c0                	test   %eax,%eax
ffff800000106f28:	75 19                	jne    ffff800000106f43 <sched+0x3e>
    panic("sched ptable.lock");
ffff800000106f2a:	48 b8 01 c9 10 00 00 	movabs $0xffff80000010c901,%rax
ffff800000106f31:	80 ff ff 
ffff800000106f34:	48 89 c7             	mov    %rax,%rdi
ffff800000106f37:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f3e:	80 ff ff 
ffff800000106f41:	ff d0                	call   *%rax
  if(cpu->ncli != 1)
ffff800000106f43:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106f4a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f4e:	8b 40 14             	mov    0x14(%rax),%eax
ffff800000106f51:	83 f8 01             	cmp    $0x1,%eax
ffff800000106f54:	74 19                	je     ffff800000106f6f <sched+0x6a>
    panic("sched locks");
ffff800000106f56:	48 b8 13 c9 10 00 00 	movabs $0xffff80000010c913,%rax
ffff800000106f5d:	80 ff ff 
ffff800000106f60:	48 89 c7             	mov    %rax,%rdi
ffff800000106f63:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f6a:	80 ff ff 
ffff800000106f6d:	ff d0                	call   *%rax
  if(proc->state == RUNNING)
ffff800000106f6f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000106f76:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106f7a:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106f7d:	83 f8 04             	cmp    $0x4,%eax
ffff800000106f80:	75 19                	jne    ffff800000106f9b <sched+0x96>
    panic("sched running");
ffff800000106f82:	48 b8 1f c9 10 00 00 	movabs $0xffff80000010c91f,%rax
ffff800000106f89:	80 ff ff 
ffff800000106f8c:	48 89 c7             	mov    %rax,%rdi
ffff800000106f8f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106f96:	80 ff ff 
ffff800000106f99:	ff d0                	call   *%rax
  if(readeflags()&FL_IF)
ffff800000106f9b:	48 b8 17 63 10 00 00 	movabs $0xffff800000106317,%rax
ffff800000106fa2:	80 ff ff 
ffff800000106fa5:	ff d0                	call   *%rax
ffff800000106fa7:	25 00 02 00 00       	and    $0x200,%eax
ffff800000106fac:	48 85 c0             	test   %rax,%rax
ffff800000106faf:	74 19                	je     ffff800000106fca <sched+0xc5>
    panic("sched interruptible");
ffff800000106fb1:	48 b8 2d c9 10 00 00 	movabs $0xffff80000010c92d,%rax
ffff800000106fb8:	80 ff ff 
ffff800000106fbb:	48 89 c7             	mov    %rax,%rdi
ffff800000106fbe:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000106fc5:	80 ff ff 
ffff800000106fc8:	ff d0                	call   *%rax
  intena = cpu->intena;
ffff800000106fca:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fd1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fd5:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000106fd8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  swtch(&proc->context, cpu->scheduler);
ffff800000106fdb:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000106fe2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000106fe6:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff800000106fea:	48 c7 c2 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rdx
ffff800000106ff1:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000106ff5:	48 83 c2 30          	add    $0x30,%rdx
ffff800000106ff9:	48 89 c6             	mov    %rax,%rsi
ffff800000106ffc:	48 89 d7             	mov    %rdx,%rdi
ffff800000106fff:	48 b8 bb 7d 10 00 00 	movabs $0xffff800000107dbb,%rax
ffff800000107006:	80 ff ff 
ffff800000107009:	ff d0                	call   *%rax
  cpu->intena = intena;
ffff80000010700b:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107012:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107016:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000107019:	89 50 18             	mov    %edx,0x18(%rax)
}
ffff80000010701c:	90                   	nop
ffff80000010701d:	c9                   	leave
ffff80000010701e:	c3                   	ret

ffff80000010701f <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
ffff80000010701f:	55                   	push   %rbp
ffff800000107020:	48 89 e5             	mov    %rsp,%rbp
  acquire(&ptable.lock);  //DOC: yieldlock
ffff800000107023:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff80000010702a:	80 ff ff 
ffff80000010702d:	48 89 c7             	mov    %rax,%rdi
ffff800000107030:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000107037:	80 ff ff 
ffff80000010703a:	ff d0                	call   *%rax
  proc->state = RUNNABLE;
ffff80000010703c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107043:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107047:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  sched();
ffff80000010704e:	48 b8 05 6f 10 00 00 	movabs $0xffff800000106f05,%rax
ffff800000107055:	80 ff ff 
ffff800000107058:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff80000010705a:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107061:	80 ff ff 
ffff800000107064:	48 89 c7             	mov    %rax,%rdi
ffff800000107067:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010706e:	80 ff ff 
ffff800000107071:	ff d0                	call   *%rax
}
ffff800000107073:	90                   	nop
ffff800000107074:	5d                   	pop    %rbp
ffff800000107075:	c3                   	ret

ffff800000107076 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
ffff800000107076:	55                   	push   %rbp
ffff800000107077:	48 89 e5             	mov    %rsp,%rbp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
ffff80000010707a:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107081:	80 ff ff 
ffff800000107084:	48 89 c7             	mov    %rax,%rdi
ffff800000107087:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010708e:	80 ff ff 
ffff800000107091:	ff d0                	call   *%rax

  if (first) {
ffff800000107093:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff80000010709a:	80 ff ff 
ffff80000010709d:	8b 00                	mov    (%rax),%eax
ffff80000010709f:	85 c0                	test   %eax,%eax
ffff8000001070a1:	74 32                	je     ffff8000001070d5 <forkret+0x5f>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
ffff8000001070a3:	48 b8 44 d5 10 00 00 	movabs $0xffff80000010d544,%rax
ffff8000001070aa:	80 ff ff 
ffff8000001070ad:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
    iinit(ROOTDEV);
ffff8000001070b3:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001070b8:	48 b8 3f 25 10 00 00 	movabs $0xffff80000010253f,%rax
ffff8000001070bf:	80 ff ff 
ffff8000001070c2:	ff d0                	call   *%rax
    initlog(ROOTDEV);
ffff8000001070c4:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001070c9:	48 b8 71 4d 10 00 00 	movabs $0xffff800000104d71,%rax
ffff8000001070d0:	80 ff ff 
ffff8000001070d3:	ff d0                	call   *%rax
  }

  // Return to "caller", actually trapret (see allocproc).
}
ffff8000001070d5:	90                   	nop
ffff8000001070d6:	5d                   	pop    %rbp
ffff8000001070d7:	c3                   	ret

ffff8000001070d8 <sleep>:
//PAGEBREAK!
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
ffff8000001070d8:	55                   	push   %rbp
ffff8000001070d9:	48 89 e5             	mov    %rsp,%rbp
ffff8000001070dc:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001070e0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001070e4:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(proc == 0)
ffff8000001070e8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001070ef:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001070f3:	48 85 c0             	test   %rax,%rax
ffff8000001070f6:	75 19                	jne    ffff800000107111 <sleep+0x39>
    panic("sleep");
ffff8000001070f8:	48 b8 41 c9 10 00 00 	movabs $0xffff80000010c941,%rax
ffff8000001070ff:	80 ff ff 
ffff800000107102:	48 89 c7             	mov    %rax,%rdi
ffff800000107105:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010710c:	80 ff ff 
ffff80000010710f:	ff d0                	call   *%rax

  if(lk == 0)
ffff800000107111:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000107116:	75 19                	jne    ffff800000107131 <sleep+0x59>
    panic("sleep without lk");
ffff800000107118:	48 b8 47 c9 10 00 00 	movabs $0xffff80000010c947,%rax
ffff80000010711f:	80 ff ff 
ffff800000107122:	48 89 c7             	mov    %rax,%rdi
ffff800000107125:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010712c:	80 ff ff 
ffff80000010712f:	ff d0                	call   *%rax
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
ffff800000107131:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107138:	80 ff ff 
ffff80000010713b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff80000010713f:	74 2c                	je     ffff80000010716d <sleep+0x95>
    acquire(&ptable.lock);  //DOC: sleeplock1
ffff800000107141:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107148:	80 ff ff 
ffff80000010714b:	48 89 c7             	mov    %rax,%rdi
ffff80000010714e:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000107155:	80 ff ff 
ffff800000107158:	ff d0                	call   *%rax
    release(lk);
ffff80000010715a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010715e:	48 89 c7             	mov    %rax,%rdi
ffff800000107161:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000107168:	80 ff ff 
ffff80000010716b:	ff d0                	call   *%rax
  }

  // Go to sleep.
  proc->chan = chan;
ffff80000010716d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107174:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107178:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010717c:	48 89 50 38          	mov    %rdx,0x38(%rax)
  proc->state = SLEEPING;
ffff800000107180:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107187:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010718b:	c7 40 18 02 00 00 00 	movl   $0x2,0x18(%rax)
  sched();
ffff800000107192:	48 b8 05 6f 10 00 00 	movabs $0xffff800000106f05,%rax
ffff800000107199:	80 ff ff 
ffff80000010719c:	ff d0                	call   *%rax

  // Tidy up.
  proc->chan = 0;
ffff80000010719e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001071a5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001071a9:	48 c7 40 38 00 00 00 	movq   $0x0,0x38(%rax)
ffff8000001071b0:	00 

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
ffff8000001071b1:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001071b8:	80 ff ff 
ffff8000001071bb:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001071bf:	74 2c                	je     ffff8000001071ed <sleep+0x115>
    release(&ptable.lock);
ffff8000001071c1:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001071c8:	80 ff ff 
ffff8000001071cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001071ce:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001071d5:	80 ff ff 
ffff8000001071d8:	ff d0                	call   *%rax
    acquire(lk);
ffff8000001071da:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001071de:	48 89 c7             	mov    %rax,%rdi
ffff8000001071e1:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001071e8:	80 ff ff 
ffff8000001071eb:	ff d0                	call   *%rax
  }
}
ffff8000001071ed:	90                   	nop
ffff8000001071ee:	c9                   	leave
ffff8000001071ef:	c3                   	ret

ffff8000001071f0 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
ffff8000001071f0:	55                   	push   %rbp
ffff8000001071f1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001071f4:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001071f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff8000001071fc:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff800000107203:	80 ff ff 
ffff800000107206:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010720a:	eb 2d                	jmp    ffff800000107239 <wakeup1+0x49>
    if(p->state == SLEEPING && p->chan == chan)
ffff80000010720c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107210:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107213:	83 f8 02             	cmp    $0x2,%eax
ffff800000107216:	75 19                	jne    ffff800000107231 <wakeup1+0x41>
ffff800000107218:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010721c:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000107220:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107224:	75 0b                	jne    ffff800000107231 <wakeup1+0x41>
      p->state = RUNNABLE;
ffff800000107226:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010722a:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
ffff800000107231:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff800000107238:	00 
ffff800000107239:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000107240:	80 ff ff 
ffff800000107243:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107247:	72 c3                	jb     ffff80000010720c <wakeup1+0x1c>
}
ffff800000107249:	90                   	nop
ffff80000010724a:	90                   	nop
ffff80000010724b:	c9                   	leave
ffff80000010724c:	c3                   	ret

ffff80000010724d <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
ffff80000010724d:	55                   	push   %rbp
ffff80000010724e:	48 89 e5             	mov    %rsp,%rbp
ffff800000107251:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107255:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  acquire(&ptable.lock);
ffff800000107259:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107260:	80 ff ff 
ffff800000107263:	48 89 c7             	mov    %rax,%rdi
ffff800000107266:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff80000010726d:	80 ff ff 
ffff800000107270:	ff d0                	call   *%rax
  wakeup1(chan);
ffff800000107272:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107276:	48 89 c7             	mov    %rax,%rdi
ffff800000107279:	48 b8 f0 71 10 00 00 	movabs $0xffff8000001071f0,%rax
ffff800000107280:	80 ff ff 
ffff800000107283:	ff d0                	call   *%rax
  release(&ptable.lock);
ffff800000107285:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff80000010728c:	80 ff ff 
ffff80000010728f:	48 89 c7             	mov    %rax,%rdi
ffff800000107292:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000107299:	80 ff ff 
ffff80000010729c:	ff d0                	call   *%rax
}
ffff80000010729e:	90                   	nop
ffff80000010729f:	c9                   	leave
ffff8000001072a0:	c3                   	ret

ffff8000001072a1 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
ffff8000001072a1:	55                   	push   %rbp
ffff8000001072a2:	48 89 e5             	mov    %rsp,%rbp
ffff8000001072a5:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001072a9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  struct proc *p;

  acquire(&ptable.lock);
ffff8000001072ac:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff8000001072b3:	80 ff ff 
ffff8000001072b6:	48 89 c7             	mov    %rax,%rdi
ffff8000001072b9:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001072c0:	80 ff ff 
ffff8000001072c3:	ff d0                	call   *%rax
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001072c5:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff8000001072cc:	80 ff ff 
ffff8000001072cf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001072d3:	eb 56                	jmp    ffff80000010732b <kill+0x8a>
    if(p->pid == pid){
ffff8000001072d5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072d9:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001072dc:	39 45 ec             	cmp    %eax,-0x14(%rbp)
ffff8000001072df:	75 42                	jne    ffff800000107323 <kill+0x82>
      p->killed = 1;
ffff8000001072e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072e5:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
ffff8000001072ec:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072f0:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001072f3:	83 f8 02             	cmp    $0x2,%eax
ffff8000001072f6:	75 0b                	jne    ffff800000107303 <kill+0x62>
        p->state = RUNNABLE;
ffff8000001072f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001072fc:	c7 40 18 03 00 00 00 	movl   $0x3,0x18(%rax)
      release(&ptable.lock);
ffff800000107303:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff80000010730a:	80 ff ff 
ffff80000010730d:	48 89 c7             	mov    %rax,%rdi
ffff800000107310:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000107317:	80 ff ff 
ffff80000010731a:	ff d0                	call   *%rax
      return 0;
ffff80000010731c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107321:	eb 36                	jmp    ffff800000107359 <kill+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107323:	48 81 45 f8 e0 00 00 	addq   $0xe0,-0x8(%rbp)
ffff80000010732a:	00 
ffff80000010732b:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff800000107332:	80 ff ff 
ffff800000107335:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107339:	72 9a                	jb     ffff8000001072d5 <kill+0x34>
    }
  }
  release(&ptable.lock);
ffff80000010733b:	48 b8 40 84 11 00 00 	movabs $0xffff800000118440,%rax
ffff800000107342:	80 ff ff 
ffff800000107345:	48 89 c7             	mov    %rax,%rdi
ffff800000107348:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010734f:	80 ff ff 
ffff800000107352:	ff d0                	call   *%rax
  return -1;
ffff800000107354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107359:	c9                   	leave
ffff80000010735a:	c3                   	ret

ffff80000010735b <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
ffff80000010735b:	55                   	push   %rbp
ffff80000010735c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010735f:	48 83 ec 70          	sub    $0x70,%rsp
  int i;
  struct proc *p;
  char *state;
  addr_t pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff800000107363:	48 b8 a8 84 11 00 00 	movabs $0xffff8000001184a8,%rax
ffff80000010736a:	80 ff ff 
ffff80000010736d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000107371:	e9 41 01 00 00       	jmp    ffff8000001074b7 <procdump+0x15c>
    if(p->state == UNUSED)
ffff800000107376:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010737a:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010737d:	85 c0                	test   %eax,%eax
ffff80000010737f:	0f 84 29 01 00 00    	je     ffff8000001074ae <procdump+0x153>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
ffff800000107385:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107389:	8b 40 18             	mov    0x18(%rax),%eax
ffff80000010738c:	83 f8 05             	cmp    $0x5,%eax
ffff80000010738f:	77 39                	ja     ffff8000001073ca <procdump+0x6f>
ffff800000107391:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107395:	8b 50 18             	mov    0x18(%rax),%edx
ffff800000107398:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff80000010739f:	80 ff ff 
ffff8000001073a2:	89 d2                	mov    %edx,%edx
ffff8000001073a4:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff8000001073a8:	48 85 c0             	test   %rax,%rax
ffff8000001073ab:	74 1d                	je     ffff8000001073ca <procdump+0x6f>
      state = states[p->state];
ffff8000001073ad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073b1:	8b 50 18             	mov    0x18(%rax),%edx
ffff8000001073b4:	48 b8 60 d5 10 00 00 	movabs $0xffff80000010d560,%rax
ffff8000001073bb:	80 ff ff 
ffff8000001073be:	89 d2                	mov    %edx,%edx
ffff8000001073c0:	48 8b 04 d0          	mov    (%rax,%rdx,8),%rax
ffff8000001073c4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff8000001073c8:	eb 0e                	jmp    ffff8000001073d8 <procdump+0x7d>
    else
      state = "???";
ffff8000001073ca:	48 b8 58 c9 10 00 00 	movabs $0xffff80000010c958,%rax
ffff8000001073d1:	80 ff ff 
ffff8000001073d4:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    cprintf("%d %s %s", p->pid, state, p->name);
ffff8000001073d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073dc:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff8000001073e3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001073e7:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001073ea:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001073ee:	48 bf 5c c9 10 00 00 	movabs $0xffff80000010c95c,%rdi
ffff8000001073f5:	80 ff ff 
ffff8000001073f8:	89 c6                	mov    %eax,%esi
ffff8000001073fa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001073ff:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000107406:	80 ff ff 
ffff800000107409:	41 ff d0             	call   *%r8
    if(p->state == SLEEPING){
ffff80000010740c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107410:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000107413:	83 f8 02             	cmp    $0x2,%eax
ffff800000107416:	75 76                	jne    ffff80000010748e <procdump+0x133>
      getstackpcs((addr_t*)p->context->rbp+2, pc);
ffff800000107418:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010741c:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107420:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107424:	48 83 c0 10          	add    $0x10,%rax
ffff800000107428:	48 89 c2             	mov    %rax,%rdx
ffff80000010742b:	48 8d 45 90          	lea    -0x70(%rbp),%rax
ffff80000010742f:	48 89 c6             	mov    %rax,%rsi
ffff800000107432:	48 89 d7             	mov    %rdx,%rdi
ffff800000107435:	48 b8 24 78 10 00 00 	movabs $0xffff800000107824,%rax
ffff80000010743c:	80 ff ff 
ffff80000010743f:	ff d0                	call   *%rax
      for(i=0; i<10 && pc[i] != 0; i++)
ffff800000107441:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107448:	eb 2f                	jmp    ffff800000107479 <procdump+0x11e>
        cprintf(" %p", pc[i]);
ffff80000010744a:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010744d:	48 98                	cltq
ffff80000010744f:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107454:	48 ba 65 c9 10 00 00 	movabs $0xffff80000010c965,%rdx
ffff80000010745b:	80 ff ff 
ffff80000010745e:	48 89 c6             	mov    %rax,%rsi
ffff800000107461:	48 89 d7             	mov    %rdx,%rdi
ffff800000107464:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000107469:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000107470:	80 ff ff 
ffff800000107473:	ff d2                	call   *%rdx
      for(i=0; i<10 && pc[i] != 0; i++)
ffff800000107475:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107479:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff80000010747d:	7f 0f                	jg     ffff80000010748e <procdump+0x133>
ffff80000010747f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107482:	48 98                	cltq
ffff800000107484:	48 8b 44 c5 90       	mov    -0x70(%rbp,%rax,8),%rax
ffff800000107489:	48 85 c0             	test   %rax,%rax
ffff80000010748c:	75 bc                	jne    ffff80000010744a <procdump+0xef>
    }
    cprintf("\n");
ffff80000010748e:	48 b8 69 c9 10 00 00 	movabs $0xffff80000010c969,%rax
ffff800000107495:	80 ff ff 
ffff800000107498:	48 89 c7             	mov    %rax,%rdi
ffff80000010749b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001074a0:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff8000001074a7:	80 ff ff 
ffff8000001074aa:	ff d2                	call   *%rdx
ffff8000001074ac:	eb 01                	jmp    ffff8000001074af <procdump+0x154>
      continue;
ffff8000001074ae:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffff8000001074af:	48 81 45 f0 e0 00 00 	addq   $0xe0,-0x10(%rbp)
ffff8000001074b6:	00 
ffff8000001074b7:	48 b8 a8 bc 11 00 00 	movabs $0xffff80000011bca8,%rax
ffff8000001074be:	80 ff ff 
ffff8000001074c1:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff8000001074c5:	0f 82 ab fe ff ff    	jb     ffff800000107376 <procdump+0x1b>
  }
}
ffff8000001074cb:	90                   	nop
ffff8000001074cc:	90                   	nop
ffff8000001074cd:	c9                   	leave
ffff8000001074ce:	c3                   	ret

ffff8000001074cf <initsleeplock>:
ffff8000001074cf:	55                   	push   %rbp
ffff8000001074d0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001074d3:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001074d7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001074db:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001074df:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001074e3:	48 83 c0 08          	add    $0x8,%rax
ffff8000001074e7:	48 ba 95 c9 10 00 00 	movabs $0xffff80000010c995,%rdx
ffff8000001074ee:	80 ff ff 
ffff8000001074f1:	48 89 d6             	mov    %rdx,%rsi
ffff8000001074f4:	48 89 c7             	mov    %rax,%rdi
ffff8000001074f7:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff8000001074fe:	80 ff ff 
ffff800000107501:	ff d0                	call   *%rax
ffff800000107503:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107507:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010750b:	48 89 50 70          	mov    %rdx,0x70(%rax)
ffff80000010750f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107513:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
ffff800000107519:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010751d:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
ffff800000107524:	90                   	nop
ffff800000107525:	c9                   	leave
ffff800000107526:	c3                   	ret

ffff800000107527 <acquiresleep>:
ffff800000107527:	55                   	push   %rbp
ffff800000107528:	48 89 e5             	mov    %rsp,%rbp
ffff80000010752b:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010752f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107533:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107537:	48 83 c0 08          	add    $0x8,%rax
ffff80000010753b:	48 89 c7             	mov    %rax,%rdi
ffff80000010753e:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000107545:	80 ff ff 
ffff800000107548:	ff d0                	call   *%rax
ffff80000010754a:	eb 1e                	jmp    ffff80000010756a <acquiresleep+0x43>
ffff80000010754c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107550:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107554:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107558:	48 89 d6             	mov    %rdx,%rsi
ffff80000010755b:	48 89 c7             	mov    %rax,%rdi
ffff80000010755e:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000107565:	80 ff ff 
ffff800000107568:	ff d0                	call   *%rax
ffff80000010756a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010756e:	8b 00                	mov    (%rax),%eax
ffff800000107570:	85 c0                	test   %eax,%eax
ffff800000107572:	75 d8                	jne    ffff80000010754c <acquiresleep+0x25>
ffff800000107574:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107578:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
ffff80000010757e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107585:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107589:	8b 50 1c             	mov    0x1c(%rax),%edx
ffff80000010758c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107590:	89 50 78             	mov    %edx,0x78(%rax)
ffff800000107593:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107597:	48 83 c0 08          	add    $0x8,%rax
ffff80000010759b:	48 89 c7             	mov    %rax,%rdi
ffff80000010759e:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001075a5:	80 ff ff 
ffff8000001075a8:	ff d0                	call   *%rax
ffff8000001075aa:	90                   	nop
ffff8000001075ab:	c9                   	leave
ffff8000001075ac:	c3                   	ret

ffff8000001075ad <releasesleep>:
ffff8000001075ad:	55                   	push   %rbp
ffff8000001075ae:	48 89 e5             	mov    %rsp,%rbp
ffff8000001075b1:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001075b5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001075b9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075bd:	48 83 c0 08          	add    $0x8,%rax
ffff8000001075c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001075c4:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001075cb:	80 ff ff 
ffff8000001075ce:	ff d0                	call   *%rax
ffff8000001075d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075d4:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
ffff8000001075da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075de:	c7 40 78 00 00 00 00 	movl   $0x0,0x78(%rax)
ffff8000001075e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075e9:	48 89 c7             	mov    %rax,%rdi
ffff8000001075ec:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff8000001075f3:	80 ff ff 
ffff8000001075f6:	ff d0                	call   *%rax
ffff8000001075f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001075fc:	48 83 c0 08          	add    $0x8,%rax
ffff800000107600:	48 89 c7             	mov    %rax,%rdi
ffff800000107603:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010760a:	80 ff ff 
ffff80000010760d:	ff d0                	call   *%rax
ffff80000010760f:	90                   	nop
ffff800000107610:	c9                   	leave
ffff800000107611:	c3                   	ret

ffff800000107612 <holdingsleep>:
ffff800000107612:	55                   	push   %rbp
ffff800000107613:	48 89 e5             	mov    %rsp,%rbp
ffff800000107616:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010761a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010761e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107622:	48 83 c0 08          	add    $0x8,%rax
ffff800000107626:	48 89 c7             	mov    %rax,%rdi
ffff800000107629:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000107630:	80 ff ff 
ffff800000107633:	ff d0                	call   *%rax
ffff800000107635:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107639:	8b 00                	mov    (%rax),%eax
ffff80000010763b:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff80000010763e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107642:	48 83 c0 08          	add    $0x8,%rax
ffff800000107646:	48 89 c7             	mov    %rax,%rdi
ffff800000107649:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000107650:	80 ff ff 
ffff800000107653:	ff d0                	call   *%rax
ffff800000107655:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107658:	c9                   	leave
ffff800000107659:	c3                   	ret

ffff80000010765a <readeflags>:
ffff80000010765a:	55                   	push   %rbp
ffff80000010765b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010765e:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107662:	9c                   	pushf
ffff800000107663:	58                   	pop    %rax
ffff800000107664:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107668:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010766c:	c9                   	leave
ffff80000010766d:	c3                   	ret

ffff80000010766e <cli>:
ffff80000010766e:	55                   	push   %rbp
ffff80000010766f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107672:	fa                   	cli
ffff800000107673:	90                   	nop
ffff800000107674:	5d                   	pop    %rbp
ffff800000107675:	c3                   	ret

ffff800000107676 <sti>:
ffff800000107676:	55                   	push   %rbp
ffff800000107677:	48 89 e5             	mov    %rsp,%rbp
ffff80000010767a:	fb                   	sti
ffff80000010767b:	90                   	nop
ffff80000010767c:	5d                   	pop    %rbp
ffff80000010767d:	c3                   	ret

ffff80000010767e <xchg>:
ffff80000010767e:	55                   	push   %rbp
ffff80000010767f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107682:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107686:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010768a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010768e:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107692:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107696:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff80000010769a:	f0 87 02             	lock xchg %eax,(%rdx)
ffff80000010769d:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001076a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001076a3:	c9                   	leave
ffff8000001076a4:	c3                   	ret

ffff8000001076a5 <initlock>:
ffff8000001076a5:	55                   	push   %rbp
ffff8000001076a6:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076a9:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001076ad:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001076b1:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff8000001076b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076b9:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff8000001076bd:	48 89 50 08          	mov    %rdx,0x8(%rax)
ffff8000001076c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076c5:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
ffff8000001076cb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076cf:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001076d6:	00 
ffff8000001076d7:	90                   	nop
ffff8000001076d8:	c9                   	leave
ffff8000001076d9:	c3                   	ret

ffff8000001076da <acquire>:
ffff8000001076da:	55                   	push   %rbp
ffff8000001076db:	48 89 e5             	mov    %rsp,%rbp
ffff8000001076de:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001076e2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001076e6:	48 b8 fa 78 10 00 00 	movabs $0xffff8000001078fa,%rax
ffff8000001076ed:	80 ff ff 
ffff8000001076f0:	ff d0                	call   *%rax
ffff8000001076f2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001076f6:	48 89 c7             	mov    %rax,%rdi
ffff8000001076f9:	48 b8 be 78 10 00 00 	movabs $0xffff8000001078be,%rax
ffff800000107700:	80 ff ff 
ffff800000107703:	ff d0                	call   *%rax
ffff800000107705:	85 c0                	test   %eax,%eax
ffff800000107707:	74 19                	je     ffff800000107722 <acquire+0x48>
ffff800000107709:	48 b8 a0 c9 10 00 00 	movabs $0xffff80000010c9a0,%rax
ffff800000107710:	80 ff ff 
ffff800000107713:	48 89 c7             	mov    %rax,%rdi
ffff800000107716:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010771d:	80 ff ff 
ffff800000107720:	ff d0                	call   *%rax
ffff800000107722:	90                   	nop
ffff800000107723:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107727:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010772c:	48 89 c7             	mov    %rax,%rdi
ffff80000010772f:	48 b8 7e 76 10 00 00 	movabs $0xffff80000010767e,%rax
ffff800000107736:	80 ff ff 
ffff800000107739:	ff d0                	call   *%rax
ffff80000010773b:	85 c0                	test   %eax,%eax
ffff80000010773d:	75 e4                	jne    ffff800000107723 <acquire+0x49>
ffff80000010773f:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
ffff800000107745:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107749:	48 c7 c2 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rdx
ffff800000107750:	64 48 8b 12          	mov    %fs:(%rdx),%rdx
ffff800000107754:	48 89 50 10          	mov    %rdx,0x10(%rax)
ffff800000107758:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010775c:	48 8d 50 18          	lea    0x18(%rax),%rdx
ffff800000107760:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000107764:	48 89 d6             	mov    %rdx,%rsi
ffff800000107767:	48 89 c7             	mov    %rax,%rdi
ffff80000010776a:	48 b8 f0 77 10 00 00 	movabs $0xffff8000001077f0,%rax
ffff800000107771:	80 ff ff 
ffff800000107774:	ff d0                	call   *%rax
ffff800000107776:	90                   	nop
ffff800000107777:	c9                   	leave
ffff800000107778:	c3                   	ret

ffff800000107779 <release>:
ffff800000107779:	55                   	push   %rbp
ffff80000010777a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010777d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107781:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107785:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107789:	48 89 c7             	mov    %rax,%rdi
ffff80000010778c:	48 b8 be 78 10 00 00 	movabs $0xffff8000001078be,%rax
ffff800000107793:	80 ff ff 
ffff800000107796:	ff d0                	call   *%rax
ffff800000107798:	85 c0                	test   %eax,%eax
ffff80000010779a:	75 19                	jne    ffff8000001077b5 <release+0x3c>
ffff80000010779c:	48 b8 a8 c9 10 00 00 	movabs $0xffff80000010c9a8,%rax
ffff8000001077a3:	80 ff ff 
ffff8000001077a6:	48 89 c7             	mov    %rax,%rdi
ffff8000001077a9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001077b0:	80 ff ff 
ffff8000001077b3:	ff d0                	call   *%rax
ffff8000001077b5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077b9:	48 c7 40 18 00 00 00 	movq   $0x0,0x18(%rax)
ffff8000001077c0:	00 
ffff8000001077c1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077c5:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
ffff8000001077cc:	00 
ffff8000001077cd:	f0 48 83 0c 24 00    	lock orq $0x0,(%rsp)
ffff8000001077d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001077d7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001077db:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
ffff8000001077e1:	48 b8 68 79 10 00 00 	movabs $0xffff800000107968,%rax
ffff8000001077e8:	80 ff ff 
ffff8000001077eb:	ff d0                	call   *%rax
ffff8000001077ed:	90                   	nop
ffff8000001077ee:	c9                   	leave
ffff8000001077ef:	c3                   	ret

ffff8000001077f0 <getcallerpcs>:
ffff8000001077f0:	55                   	push   %rbp
ffff8000001077f1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001077f4:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001077f8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001077fc:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107800:	48 89 e8             	mov    %rbp,%rax
ffff800000107803:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107807:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010780b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010780f:	48 89 d6             	mov    %rdx,%rsi
ffff800000107812:	48 89 c7             	mov    %rax,%rdi
ffff800000107815:	48 b8 24 78 10 00 00 	movabs $0xffff800000107824,%rax
ffff80000010781c:	80 ff ff 
ffff80000010781f:	ff d0                	call   *%rax
ffff800000107821:	90                   	nop
ffff800000107822:	c9                   	leave
ffff800000107823:	c3                   	ret

ffff800000107824 <getstackpcs>:
ffff800000107824:	55                   	push   %rbp
ffff800000107825:	48 89 e5             	mov    %rsp,%rbp
ffff800000107828:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010782c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107830:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107834:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010783b:	eb 50                	jmp    ffff80000010788d <getstackpcs+0x69>
ffff80000010783d:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff800000107842:	74 70                	je     ffff8000001078b4 <getstackpcs+0x90>
ffff800000107844:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010784b:	7f ff ff 
ffff80000010784e:	48 3b 45 e8          	cmp    -0x18(%rbp),%rax
ffff800000107852:	73 60                	jae    ffff8000001078b4 <getstackpcs+0x90>
ffff800000107854:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107859:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff80000010785d:	74 55                	je     ffff8000001078b4 <getstackpcs+0x90>
ffff80000010785f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107862:	48 98                	cltq
ffff800000107864:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010786b:	00 
ffff80000010786c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107870:	48 01 c2             	add    %rax,%rdx
ffff800000107873:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107877:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010787b:	48 89 02             	mov    %rax,(%rdx)
ffff80000010787e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107882:	48 8b 00             	mov    (%rax),%rax
ffff800000107885:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff800000107889:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010788d:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff800000107891:	7e aa                	jle    ffff80000010783d <getstackpcs+0x19>
ffff800000107893:	eb 1f                	jmp    ffff8000001078b4 <getstackpcs+0x90>
ffff800000107895:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107898:	48 98                	cltq
ffff80000010789a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff8000001078a1:	00 
ffff8000001078a2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001078a6:	48 01 d0             	add    %rdx,%rax
ffff8000001078a9:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff8000001078b0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001078b4:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
ffff8000001078b8:	7e db                	jle    ffff800000107895 <getstackpcs+0x71>
ffff8000001078ba:	90                   	nop
ffff8000001078bb:	90                   	nop
ffff8000001078bc:	c9                   	leave
ffff8000001078bd:	c3                   	ret

ffff8000001078be <holding>:
ffff8000001078be:	55                   	push   %rbp
ffff8000001078bf:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078c2:	48 83 ec 08          	sub    $0x8,%rsp
ffff8000001078c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff8000001078ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078ce:	8b 00                	mov    (%rax),%eax
ffff8000001078d0:	85 c0                	test   %eax,%eax
ffff8000001078d2:	74 1f                	je     ffff8000001078f3 <holding+0x35>
ffff8000001078d4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001078d8:	48 8b 50 10          	mov    0x10(%rax),%rdx
ffff8000001078dc:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001078e3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001078e7:	48 39 c2             	cmp    %rax,%rdx
ffff8000001078ea:	75 07                	jne    ffff8000001078f3 <holding+0x35>
ffff8000001078ec:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001078f1:	eb 05                	jmp    ffff8000001078f8 <holding+0x3a>
ffff8000001078f3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001078f8:	c9                   	leave
ffff8000001078f9:	c3                   	ret

ffff8000001078fa <pushcli>:
ffff8000001078fa:	55                   	push   %rbp
ffff8000001078fb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001078fe:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107902:	48 b8 5a 76 10 00 00 	movabs $0xffff80000010765a,%rax
ffff800000107909:	80 ff ff 
ffff80000010790c:	ff d0                	call   *%rax
ffff80000010790e:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000107911:	48 b8 6e 76 10 00 00 	movabs $0xffff80000010766e,%rax
ffff800000107918:	80 ff ff 
ffff80000010791b:	ff d0                	call   *%rax
ffff80000010791d:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107924:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107928:	8b 40 14             	mov    0x14(%rax),%eax
ffff80000010792b:	85 c0                	test   %eax,%eax
ffff80000010792d:	75 17                	jne    ffff800000107946 <pushcli+0x4c>
ffff80000010792f:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff800000107936:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010793a:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010793d:	81 e2 00 02 00 00    	and    $0x200,%edx
ffff800000107943:	89 50 18             	mov    %edx,0x18(%rax)
ffff800000107946:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010794d:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107951:	8b 50 14             	mov    0x14(%rax),%edx
ffff800000107954:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff80000010795b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010795f:	83 c2 01             	add    $0x1,%edx
ffff800000107962:	89 50 14             	mov    %edx,0x14(%rax)
ffff800000107965:	90                   	nop
ffff800000107966:	c9                   	leave
ffff800000107967:	c3                   	ret

ffff800000107968 <popcli>:
ffff800000107968:	55                   	push   %rbp
ffff800000107969:	48 89 e5             	mov    %rsp,%rbp
ffff80000010796c:	48 b8 5a 76 10 00 00 	movabs $0xffff80000010765a,%rax
ffff800000107973:	80 ff ff 
ffff800000107976:	ff d0                	call   *%rax
ffff800000107978:	25 00 02 00 00       	and    $0x200,%eax
ffff80000010797d:	48 85 c0             	test   %rax,%rax
ffff800000107980:	74 19                	je     ffff80000010799b <popcli+0x33>
ffff800000107982:	48 b8 b0 c9 10 00 00 	movabs $0xffff80000010c9b0,%rax
ffff800000107989:	80 ff ff 
ffff80000010798c:	48 89 c7             	mov    %rax,%rdi
ffff80000010798f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000107996:	80 ff ff 
ffff800000107999:	ff d0                	call   *%rax
ffff80000010799b:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079a2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079a6:	8b 50 14             	mov    0x14(%rax),%edx
ffff8000001079a9:	83 ea 01             	sub    $0x1,%edx
ffff8000001079ac:	89 50 14             	mov    %edx,0x14(%rax)
ffff8000001079af:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001079b2:	85 c0                	test   %eax,%eax
ffff8000001079b4:	79 19                	jns    ffff8000001079cf <popcli+0x67>
ffff8000001079b6:	48 b8 c7 c9 10 00 00 	movabs $0xffff80000010c9c7,%rax
ffff8000001079bd:	80 ff ff 
ffff8000001079c0:	48 89 c7             	mov    %rax,%rdi
ffff8000001079c3:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff8000001079ca:	80 ff ff 
ffff8000001079cd:	ff d0                	call   *%rax
ffff8000001079cf:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079d6:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079da:	8b 40 14             	mov    0x14(%rax),%eax
ffff8000001079dd:	85 c0                	test   %eax,%eax
ffff8000001079df:	75 1e                	jne    ffff8000001079ff <popcli+0x97>
ffff8000001079e1:	48 c7 c0 f0 ff ff ff 	mov    $0xfffffffffffffff0,%rax
ffff8000001079e8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001079ec:	8b 40 18             	mov    0x18(%rax),%eax
ffff8000001079ef:	85 c0                	test   %eax,%eax
ffff8000001079f1:	74 0c                	je     ffff8000001079ff <popcli+0x97>
ffff8000001079f3:	48 b8 76 76 10 00 00 	movabs $0xffff800000107676,%rax
ffff8000001079fa:	80 ff ff 
ffff8000001079fd:	ff d0                	call   *%rax
ffff8000001079ff:	90                   	nop
ffff800000107a00:	5d                   	pop    %rbp
ffff800000107a01:	c3                   	ret

ffff800000107a02 <stosb>:
ffff800000107a02:	55                   	push   %rbp
ffff800000107a03:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a06:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a0a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a0e:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a11:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff800000107a14:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a18:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a1b:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a1e:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a21:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a24:	89 d1                	mov    %edx,%ecx
ffff800000107a26:	fc                   	cld
ffff800000107a27:	f3 aa                	rep stos %al,(%rdi)
ffff800000107a29:	89 ca                	mov    %ecx,%edx
ffff800000107a2b:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a2e:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a32:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff800000107a35:	90                   	nop
ffff800000107a36:	c9                   	leave
ffff800000107a37:	c3                   	ret

ffff800000107a38 <stosl>:
ffff800000107a38:	55                   	push   %rbp
ffff800000107a39:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a3c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107a40:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a44:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a47:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff800000107a4a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff800000107a4e:	8b 55 f0             	mov    -0x10(%rbp),%edx
ffff800000107a51:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107a54:	48 89 ce             	mov    %rcx,%rsi
ffff800000107a57:	48 89 f7             	mov    %rsi,%rdi
ffff800000107a5a:	89 d1                	mov    %edx,%ecx
ffff800000107a5c:	fc                   	cld
ffff800000107a5d:	f3 ab                	rep stos %eax,(%rdi)
ffff800000107a5f:	89 ca                	mov    %ecx,%edx
ffff800000107a61:	48 89 fe             	mov    %rdi,%rsi
ffff800000107a64:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
ffff800000107a68:	89 55 f0             	mov    %edx,-0x10(%rbp)
ffff800000107a6b:	90                   	nop
ffff800000107a6c:	c9                   	leave
ffff800000107a6d:	c3                   	ret

ffff800000107a6e <memset>:
ffff800000107a6e:	55                   	push   %rbp
ffff800000107a6f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107a72:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107a76:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107a7a:	89 75 f4             	mov    %esi,-0xc(%rbp)
ffff800000107a7d:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107a81:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107a85:	83 e0 03             	and    $0x3,%eax
ffff800000107a88:	48 85 c0             	test   %rax,%rax
ffff800000107a8b:	75 53                	jne    ffff800000107ae0 <memset+0x72>
ffff800000107a8d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107a91:	83 e0 03             	and    $0x3,%eax
ffff800000107a94:	48 85 c0             	test   %rax,%rax
ffff800000107a97:	75 47                	jne    ffff800000107ae0 <memset+0x72>
ffff800000107a99:	81 65 f4 ff 00 00 00 	andl   $0xff,-0xc(%rbp)
ffff800000107aa0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107aa4:	48 c1 e8 02          	shr    $0x2,%rax
ffff800000107aa8:	89 c6                	mov    %eax,%esi
ffff800000107aaa:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107aad:	c1 e0 18             	shl    $0x18,%eax
ffff800000107ab0:	89 c2                	mov    %eax,%edx
ffff800000107ab2:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107ab5:	c1 e0 10             	shl    $0x10,%eax
ffff800000107ab8:	09 c2                	or     %eax,%edx
ffff800000107aba:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000107abd:	c1 e0 08             	shl    $0x8,%eax
ffff800000107ac0:	09 d0                	or     %edx,%eax
ffff800000107ac2:	0b 45 f4             	or     -0xc(%rbp),%eax
ffff800000107ac5:	89 c1                	mov    %eax,%ecx
ffff800000107ac7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107acb:	89 f2                	mov    %esi,%edx
ffff800000107acd:	89 ce                	mov    %ecx,%esi
ffff800000107acf:	48 89 c7             	mov    %rax,%rdi
ffff800000107ad2:	48 b8 38 7a 10 00 00 	movabs $0xffff800000107a38,%rax
ffff800000107ad9:	80 ff ff 
ffff800000107adc:	ff d0                	call   *%rax
ffff800000107ade:	eb 1e                	jmp    ffff800000107afe <memset+0x90>
ffff800000107ae0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107ae4:	89 c2                	mov    %eax,%edx
ffff800000107ae6:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff800000107ae9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107aed:	89 ce                	mov    %ecx,%esi
ffff800000107aef:	48 89 c7             	mov    %rax,%rdi
ffff800000107af2:	48 b8 02 7a 10 00 00 	movabs $0xffff800000107a02,%rax
ffff800000107af9:	80 ff ff 
ffff800000107afc:	ff d0                	call   *%rax
ffff800000107afe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b02:	c9                   	leave
ffff800000107b03:	c3                   	ret

ffff800000107b04 <memcmp>:
ffff800000107b04:	55                   	push   %rbp
ffff800000107b05:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b08:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107b0c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b10:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107b14:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107b17:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107b1f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b23:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000107b27:	eb 34                	jmp    ffff800000107b5d <memcmp+0x59>
ffff800000107b29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b2d:	0f b6 10             	movzbl (%rax),%edx
ffff800000107b30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b34:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b37:	38 c2                	cmp    %al,%dl
ffff800000107b39:	74 18                	je     ffff800000107b53 <memcmp+0x4f>
ffff800000107b3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b3f:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b42:	0f b6 d0             	movzbl %al,%edx
ffff800000107b45:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107b49:	0f b6 00             	movzbl (%rax),%eax
ffff800000107b4c:	0f b6 c0             	movzbl %al,%eax
ffff800000107b4f:	29 c2                	sub    %eax,%edx
ffff800000107b51:	eb 1c                	jmp    ffff800000107b6f <memcmp+0x6b>
ffff800000107b53:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107b58:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
ffff800000107b5d:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107b60:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107b63:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107b66:	85 c0                	test   %eax,%eax
ffff800000107b68:	75 bf                	jne    ffff800000107b29 <memcmp+0x25>
ffff800000107b6a:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107b6f:	89 d0                	mov    %edx,%eax
ffff800000107b71:	c9                   	leave
ffff800000107b72:	c3                   	ret

ffff800000107b73 <memmove>:
ffff800000107b73:	55                   	push   %rbp
ffff800000107b74:	48 89 e5             	mov    %rsp,%rbp
ffff800000107b77:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107b7b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107b7f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107b83:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107b86:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107b8a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107b8e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107b92:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000107b96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107b9a:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107b9e:	73 63                	jae    ffff800000107c03 <memmove+0x90>
ffff800000107ba0:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff800000107ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107ba7:	48 01 d0             	add    %rdx,%rax
ffff800000107baa:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
ffff800000107bae:	73 53                	jae    ffff800000107c03 <memmove+0x90>
ffff800000107bb0:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bb3:	48 01 45 f8          	add    %rax,-0x8(%rbp)
ffff800000107bb7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bba:	48 01 45 f0          	add    %rax,-0x10(%rbp)
ffff800000107bbe:	eb 17                	jmp    ffff800000107bd7 <memmove+0x64>
ffff800000107bc0:	48 83 6d f8 01       	subq   $0x1,-0x8(%rbp)
ffff800000107bc5:	48 83 6d f0 01       	subq   $0x1,-0x10(%rbp)
ffff800000107bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107bce:	0f b6 10             	movzbl (%rax),%edx
ffff800000107bd1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107bd5:	88 10                	mov    %dl,(%rax)
ffff800000107bd7:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107bda:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107bdd:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107be0:	85 c0                	test   %eax,%eax
ffff800000107be2:	75 dc                	jne    ffff800000107bc0 <memmove+0x4d>
ffff800000107be4:	eb 2a                	jmp    ffff800000107c10 <memmove+0x9d>
ffff800000107be6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107bea:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107bee:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107bf2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107bf6:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107bfa:	48 89 4d f0          	mov    %rcx,-0x10(%rbp)
ffff800000107bfe:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107c01:	88 10                	mov    %dl,(%rax)
ffff800000107c03:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107c06:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107c09:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107c0c:	85 c0                	test   %eax,%eax
ffff800000107c0e:	75 d6                	jne    ffff800000107be6 <memmove+0x73>
ffff800000107c10:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107c14:	c9                   	leave
ffff800000107c15:	c3                   	ret

ffff800000107c16 <memcpy>:
ffff800000107c16:	55                   	push   %rbp
ffff800000107c17:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c1a:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c1e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c22:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c26:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff800000107c29:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff800000107c2c:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
ffff800000107c30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c34:	48 89 ce             	mov    %rcx,%rsi
ffff800000107c37:	48 89 c7             	mov    %rax,%rdi
ffff800000107c3a:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff800000107c41:	80 ff ff 
ffff800000107c44:	ff d0                	call   *%rax
ffff800000107c46:	c9                   	leave
ffff800000107c47:	c3                   	ret

ffff800000107c48 <strncmp>:
ffff800000107c48:	55                   	push   %rbp
ffff800000107c49:	48 89 e5             	mov    %rsp,%rbp
ffff800000107c4c:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107c50:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107c54:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
ffff800000107c58:	89 55 ec             	mov    %edx,-0x14(%rbp)
ffff800000107c5b:	eb 0e                	jmp    ffff800000107c6b <strncmp+0x23>
ffff800000107c5d:	83 6d ec 01          	subl   $0x1,-0x14(%rbp)
ffff800000107c61:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107c66:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
ffff800000107c6b:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107c6f:	74 1d                	je     ffff800000107c8e <strncmp+0x46>
ffff800000107c71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c75:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c78:	84 c0                	test   %al,%al
ffff800000107c7a:	74 12                	je     ffff800000107c8e <strncmp+0x46>
ffff800000107c7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c80:	0f b6 10             	movzbl (%rax),%edx
ffff800000107c83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107c87:	0f b6 00             	movzbl (%rax),%eax
ffff800000107c8a:	38 c2                	cmp    %al,%dl
ffff800000107c8c:	74 cf                	je     ffff800000107c5d <strncmp+0x15>
ffff800000107c8e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000107c92:	75 07                	jne    ffff800000107c9b <strncmp+0x53>
ffff800000107c94:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000107c99:	eb 16                	jmp    ffff800000107cb1 <strncmp+0x69>
ffff800000107c9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107c9f:	0f b6 00             	movzbl (%rax),%eax
ffff800000107ca2:	0f b6 d0             	movzbl %al,%edx
ffff800000107ca5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107ca9:	0f b6 00             	movzbl (%rax),%eax
ffff800000107cac:	0f b6 c0             	movzbl %al,%eax
ffff800000107caf:	29 c2                	sub    %eax,%edx
ffff800000107cb1:	89 d0                	mov    %edx,%eax
ffff800000107cb3:	c9                   	leave
ffff800000107cb4:	c3                   	ret

ffff800000107cb5 <strncpy>:
ffff800000107cb5:	55                   	push   %rbp
ffff800000107cb6:	48 89 e5             	mov    %rsp,%rbp
ffff800000107cb9:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107cbd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107cc1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107cc5:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107cc8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107ccc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107cd0:	90                   	nop
ffff800000107cd1:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107cd4:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107cd7:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107cda:	85 c0                	test   %eax,%eax
ffff800000107cdc:	7e 35                	jle    ffff800000107d13 <strncpy+0x5e>
ffff800000107cde:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107ce2:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107ce6:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107cea:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107cee:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107cf2:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107cf6:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107cf9:	88 10                	mov    %dl,(%rax)
ffff800000107cfb:	0f b6 00             	movzbl (%rax),%eax
ffff800000107cfe:	84 c0                	test   %al,%al
ffff800000107d00:	75 cf                	jne    ffff800000107cd1 <strncpy+0x1c>
ffff800000107d02:	eb 0f                	jmp    ffff800000107d13 <strncpy+0x5e>
ffff800000107d04:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d08:	48 8d 50 01          	lea    0x1(%rax),%rdx
ffff800000107d0c:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
ffff800000107d10:	c6 00 00             	movb   $0x0,(%rax)
ffff800000107d13:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000107d16:	8d 50 ff             	lea    -0x1(%rax),%edx
ffff800000107d19:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107d1c:	85 c0                	test   %eax,%eax
ffff800000107d1e:	7f e4                	jg     ffff800000107d04 <strncpy+0x4f>
ffff800000107d20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d24:	c9                   	leave
ffff800000107d25:	c3                   	ret

ffff800000107d26 <safestrcpy>:
ffff800000107d26:	55                   	push   %rbp
ffff800000107d27:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d2a:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000107d2e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107d32:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff800000107d36:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff800000107d39:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d3d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107d41:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107d45:	7f 06                	jg     ffff800000107d4d <safestrcpy+0x27>
ffff800000107d47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d4b:	eb 3a                	jmp    ffff800000107d87 <safestrcpy+0x61>
ffff800000107d4d:	90                   	nop
ffff800000107d4e:	83 6d dc 01          	subl   $0x1,-0x24(%rbp)
ffff800000107d52:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
ffff800000107d56:	7e 24                	jle    ffff800000107d7c <safestrcpy+0x56>
ffff800000107d58:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff800000107d5c:	48 8d 42 01          	lea    0x1(%rdx),%rax
ffff800000107d60:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff800000107d64:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d68:	48 8d 48 01          	lea    0x1(%rax),%rcx
ffff800000107d6c:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
ffff800000107d70:	0f b6 12             	movzbl (%rdx),%edx
ffff800000107d73:	88 10                	mov    %dl,(%rax)
ffff800000107d75:	0f b6 00             	movzbl (%rax),%eax
ffff800000107d78:	84 c0                	test   %al,%al
ffff800000107d7a:	75 d2                	jne    ffff800000107d4e <safestrcpy+0x28>
ffff800000107d7c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107d80:	c6 00 00             	movb   $0x0,(%rax)
ffff800000107d83:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107d87:	c9                   	leave
ffff800000107d88:	c3                   	ret

ffff800000107d89 <strlen>:
ffff800000107d89:	55                   	push   %rbp
ffff800000107d8a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107d8d:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000107d91:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107d95:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000107d9c:	eb 04                	jmp    ffff800000107da2 <strlen+0x19>
ffff800000107d9e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000107da2:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107da5:	48 63 d0             	movslq %eax,%rdx
ffff800000107da8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000107dac:	48 01 d0             	add    %rdx,%rax
ffff800000107daf:	0f b6 00             	movzbl (%rax),%eax
ffff800000107db2:	84 c0                	test   %al,%al
ffff800000107db4:	75 e8                	jne    ffff800000107d9e <strlen+0x15>
ffff800000107db6:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000107db9:	c9                   	leave
ffff800000107dba:	c3                   	ret

ffff800000107dbb <swtch>:
ffff800000107dbb:	55                   	push   %rbp
ffff800000107dbc:	53                   	push   %rbx
ffff800000107dbd:	41 54                	push   %r12
ffff800000107dbf:	41 55                	push   %r13
ffff800000107dc1:	41 56                	push   %r14
ffff800000107dc3:	41 57                	push   %r15
ffff800000107dc5:	48 89 27             	mov    %rsp,(%rdi)
ffff800000107dc8:	48 89 f4             	mov    %rsi,%rsp
ffff800000107dcb:	41 5f                	pop    %r15
ffff800000107dcd:	41 5e                	pop    %r14
ffff800000107dcf:	41 5d                	pop    %r13
ffff800000107dd1:	41 5c                	pop    %r12
ffff800000107dd3:	5b                   	pop    %rbx
ffff800000107dd4:	5d                   	pop    %rbp
ffff800000107dd5:	c3                   	ret

ffff800000107dd6 <fetchint>:
#include "trace.h"

// Fetch the int at addr from the current process.
int
fetchint(addr_t addr, int *ip)
{
ffff800000107dd6:	55                   	push   %rbp
ffff800000107dd7:	48 89 e5             	mov    %rsp,%rbp
ffff800000107dda:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107dde:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107de2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(int) > proc->sz)
ffff800000107de6:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107ded:	00 
ffff800000107dee:	76 2f                	jbe    ffff800000107e1f <fetchint+0x49>
ffff800000107df0:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107df7:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107dfb:	48 8b 00             	mov    (%rax),%rax
ffff800000107dfe:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107e02:	73 1b                	jae    ffff800000107e1f <fetchint+0x49>
ffff800000107e04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e08:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff800000107e0c:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e13:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e17:	48 8b 00             	mov    (%rax),%rax
ffff800000107e1a:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e1d:	73 07                	jae    ffff800000107e26 <fetchint+0x50>
    return -1;
ffff800000107e1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e24:	eb 11                	jmp    ffff800000107e37 <fetchint+0x61>
  *ip = *(int*)(addr);
ffff800000107e26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e2a:	8b 10                	mov    (%rax),%edx
ffff800000107e2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e30:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000107e32:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e37:	c9                   	leave
ffff800000107e38:	c3                   	ret

ffff800000107e39 <fetchaddr>:

int
fetchaddr(addr_t addr, addr_t *ip)
{
ffff800000107e39:	55                   	push   %rbp
ffff800000107e3a:	48 89 e5             	mov    %rsp,%rbp
ffff800000107e3d:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107e41:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff800000107e45:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(addr < PGSIZE || addr >= proc->sz || addr+sizeof(addr_t) > proc->sz)
ffff800000107e49:	48 81 7d f8 ff 0f 00 	cmpq   $0xfff,-0x8(%rbp)
ffff800000107e50:	00 
ffff800000107e51:	76 2f                	jbe    ffff800000107e82 <fetchaddr+0x49>
ffff800000107e53:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e5a:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e5e:	48 8b 00             	mov    (%rax),%rax
ffff800000107e61:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff800000107e65:	73 1b                	jae    ffff800000107e82 <fetchaddr+0x49>
ffff800000107e67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e6b:	48 8d 50 08          	lea    0x8(%rax),%rdx
ffff800000107e6f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107e76:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107e7a:	48 8b 00             	mov    (%rax),%rax
ffff800000107e7d:	48 39 d0             	cmp    %rdx,%rax
ffff800000107e80:	73 07                	jae    ffff800000107e89 <fetchaddr+0x50>
    return -1;
ffff800000107e82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107e87:	eb 13                	jmp    ffff800000107e9c <fetchaddr+0x63>
  *ip = *(addr_t*)(addr);
ffff800000107e89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107e8d:	48 8b 10             	mov    (%rax),%rdx
ffff800000107e90:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000107e94:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff800000107e97:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000107e9c:	c9                   	leave
ffff800000107e9d:	c3                   	ret

ffff800000107e9e <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(addr_t addr, char **pp)
{
ffff800000107e9e:	55                   	push   %rbp
ffff800000107e9f:	48 89 e5             	mov    %rsp,%rbp
ffff800000107ea2:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000107ea6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000107eaa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *s, *ep;

  if(addr < PGSIZE || addr >= proc->sz)
ffff800000107eae:	48 81 7d e8 ff 0f 00 	cmpq   $0xfff,-0x18(%rbp)
ffff800000107eb5:	00 
ffff800000107eb6:	76 14                	jbe    ffff800000107ecc <fetchstr+0x2e>
ffff800000107eb8:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ebf:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ec3:	48 8b 00             	mov    (%rax),%rax
ffff800000107ec6:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
ffff800000107eca:	72 07                	jb     ffff800000107ed3 <fetchstr+0x35>
    return -1;
ffff800000107ecc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000107ed1:	eb 5b                	jmp    ffff800000107f2e <fetchstr+0x90>
  *pp = (char*)addr;
ffff800000107ed3:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff800000107ed7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107edb:	48 89 10             	mov    %rdx,(%rax)
  ep = (char*)proc->sz;
ffff800000107ede:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ee5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ee9:	48 8b 00             	mov    (%rax),%rax
ffff800000107eec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(s = *pp; s < ep; s++)
ffff800000107ef0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107ef4:	48 8b 00             	mov    (%rax),%rax
ffff800000107ef7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000107efb:	eb 22                	jmp    ffff800000107f1f <fetchstr+0x81>
    if(*s == 0)
ffff800000107efd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f01:	0f b6 00             	movzbl (%rax),%eax
ffff800000107f04:	84 c0                	test   %al,%al
ffff800000107f06:	75 12                	jne    ffff800000107f1a <fetchstr+0x7c>
      return s - *pp;
ffff800000107f08:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000107f0c:	48 8b 00             	mov    (%rax),%rax
ffff800000107f0f:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000107f13:	48 29 c2             	sub    %rax,%rdx
ffff800000107f16:	89 d0                	mov    %edx,%eax
ffff800000107f18:	eb 14                	jmp    ffff800000107f2e <fetchstr+0x90>
  for(s = *pp; s < ep; s++)
ffff800000107f1a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff800000107f1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000107f23:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff800000107f27:	72 d4                	jb     ffff800000107efd <fetchstr+0x5f>
  return -1;
ffff800000107f29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
ffff800000107f2e:	c9                   	leave
ffff800000107f2f:	c3                   	ret

ffff800000107f30 <fetcharg>:

static addr_t
fetcharg(int n)
{
ffff800000107f30:	55                   	push   %rbp
ffff800000107f31:	48 89 e5             	mov    %rsp,%rbp
ffff800000107f34:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000107f38:	89 7d fc             	mov    %edi,-0x4(%rbp)
  switch (n) {
ffff800000107f3b:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f3f:	0f 84 bb 00 00 00    	je     ffff800000108000 <fetcharg+0xd0>
ffff800000107f45:	83 7d fc 05          	cmpl   $0x5,-0x4(%rbp)
ffff800000107f49:	0f 8f c6 00 00 00    	jg     ffff800000108015 <fetcharg+0xe5>
ffff800000107f4f:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107f53:	0f 84 92 00 00 00    	je     ffff800000107feb <fetcharg+0xbb>
ffff800000107f59:	83 7d fc 04          	cmpl   $0x4,-0x4(%rbp)
ffff800000107f5d:	0f 8f b2 00 00 00    	jg     ffff800000108015 <fetcharg+0xe5>
ffff800000107f63:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107f67:	74 6d                	je     ffff800000107fd6 <fetcharg+0xa6>
ffff800000107f69:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
ffff800000107f6d:	0f 8f a2 00 00 00    	jg     ffff800000108015 <fetcharg+0xe5>
ffff800000107f73:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107f77:	74 48                	je     ffff800000107fc1 <fetcharg+0x91>
ffff800000107f79:	83 7d fc 02          	cmpl   $0x2,-0x4(%rbp)
ffff800000107f7d:	0f 8f 92 00 00 00    	jg     ffff800000108015 <fetcharg+0xe5>
ffff800000107f83:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000107f87:	74 0b                	je     ffff800000107f94 <fetcharg+0x64>
ffff800000107f89:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
ffff800000107f8d:	74 1d                	je     ffff800000107fac <fetcharg+0x7c>
ffff800000107f8f:	e9 81 00 00 00       	jmp    ffff800000108015 <fetcharg+0xe5>
  case 0: return proc->tf->rdi;
ffff800000107f94:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107f9b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107f9f:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fa3:	48 8b 40 30          	mov    0x30(%rax),%rax
ffff800000107fa7:	e9 82 00 00 00       	jmp    ffff80000010802e <fetcharg+0xfe>
  case 1: return proc->tf->rsi;
ffff800000107fac:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fb3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fb7:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fbb:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fbf:	eb 6d                	jmp    ffff80000010802e <fetcharg+0xfe>
  case 2: return proc->tf->rdx;
ffff800000107fc1:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fc8:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fcc:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fd0:	48 8b 40 18          	mov    0x18(%rax),%rax
ffff800000107fd4:	eb 58                	jmp    ffff80000010802e <fetcharg+0xfe>
  case 3: return proc->tf->r10;
ffff800000107fd6:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107fdd:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107fe1:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107fe5:	48 8b 40 48          	mov    0x48(%rax),%rax
ffff800000107fe9:	eb 43                	jmp    ffff80000010802e <fetcharg+0xfe>
  case 4: return proc->tf->r8;
ffff800000107feb:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000107ff2:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000107ff6:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000107ffa:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff800000107ffe:	eb 2e                	jmp    ffff80000010802e <fetcharg+0xfe>
  case 5: return proc->tf->r9;
ffff800000108000:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108007:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010800b:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff80000010800f:	48 8b 40 40          	mov    0x40(%rax),%rax
ffff800000108013:	eb 19                	jmp    ffff80000010802e <fetcharg+0xfe>
  }
  panic("failed fetch");
ffff800000108015:	48 b8 ce c9 10 00 00 	movabs $0xffff80000010c9ce,%rax
ffff80000010801c:	80 ff ff 
ffff80000010801f:	48 89 c7             	mov    %rax,%rdi
ffff800000108022:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108029:	80 ff ff 
ffff80000010802c:	ff d0                	call   *%rax
}
ffff80000010802e:	c9                   	leave
ffff80000010802f:	c3                   	ret

ffff800000108030 <argint>:

int
argint(int n, int *ip)
{
ffff800000108030:	55                   	push   %rbp
ffff800000108031:	48 89 e5             	mov    %rsp,%rbp
ffff800000108034:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108038:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010803b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff80000010803f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108042:	89 c7                	mov    %eax,%edi
ffff800000108044:	48 b8 30 7f 10 00 00 	movabs $0xffff800000107f30,%rax
ffff80000010804b:	80 ff ff 
ffff80000010804e:	ff d0                	call   *%rax
ffff800000108050:	89 c2                	mov    %eax,%edx
ffff800000108052:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108056:	89 10                	mov    %edx,(%rax)
  return 0;
ffff800000108058:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010805d:	c9                   	leave
ffff80000010805e:	c3                   	ret

ffff80000010805f <argaddr>:

addr_t
argaddr(int n, addr_t *ip)
{
ffff80000010805f:	55                   	push   %rbp
ffff800000108060:	48 89 e5             	mov    %rsp,%rbp
ffff800000108063:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108067:	89 7d fc             	mov    %edi,-0x4(%rbp)
ffff80000010806a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  *ip = fetcharg(n);
ffff80000010806e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108071:	89 c7                	mov    %eax,%edi
ffff800000108073:	48 b8 30 7f 10 00 00 	movabs $0xffff800000107f30,%rax
ffff80000010807a:	80 ff ff 
ffff80000010807d:	ff d0                	call   *%rax
ffff80000010807f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108083:	48 89 02             	mov    %rax,(%rdx)
  return 0;
ffff800000108086:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010808b:	c9                   	leave
ffff80000010808c:	c3                   	ret

ffff80000010808d <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
addr_t
argptr(int n, char **pp, int size)
{
ffff80000010808d:	55                   	push   %rbp
ffff80000010808e:	48 89 e5             	mov    %rsp,%rbp
ffff800000108091:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108095:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff800000108098:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010809c:	89 55 e8             	mov    %edx,-0x18(%rbp)
  addr_t i;

  if(argaddr(n, &i) < 0)
ffff80000010809f:	48 8d 55 f8          	lea    -0x8(%rbp),%rdx
ffff8000001080a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff8000001080a6:	48 89 d6             	mov    %rdx,%rsi
ffff8000001080a9:	89 c7                	mov    %eax,%edi
ffff8000001080ab:	48 b8 5f 80 10 00 00 	movabs $0xffff80000010805f,%rax
ffff8000001080b2:	80 ff ff 
ffff8000001080b5:	ff d0                	call   *%rax
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
ffff8000001080b7:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
ffff8000001080bb:	78 39                	js     ffff8000001080f6 <argptr+0x69>
ffff8000001080bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080c1:	89 c2                	mov    %eax,%edx
ffff8000001080c3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080ca:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080ce:	48 8b 00             	mov    (%rax),%rax
ffff8000001080d1:	48 39 c2             	cmp    %rax,%rdx
ffff8000001080d4:	73 20                	jae    ffff8000001080f6 <argptr+0x69>
ffff8000001080d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001080da:	89 c2                	mov    %eax,%edx
ffff8000001080dc:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff8000001080df:	01 d0                	add    %edx,%eax
ffff8000001080e1:	89 c2                	mov    %eax,%edx
ffff8000001080e3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001080ea:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001080ee:	48 8b 00             	mov    (%rax),%rax
ffff8000001080f1:	48 39 d0             	cmp    %rdx,%rax
ffff8000001080f4:	73 09                	jae    ffff8000001080ff <argptr+0x72>
    return -1;
ffff8000001080f6:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff8000001080fd:	eb 13                	jmp    ffff800000108112 <argptr+0x85>
  *pp = (char*)i;
ffff8000001080ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108103:	48 89 c2             	mov    %rax,%rdx
ffff800000108106:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010810a:	48 89 10             	mov    %rdx,(%rax)
  return 0;
ffff80000010810d:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000108112:	c9                   	leave
ffff800000108113:	c3                   	ret

ffff800000108114 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
ffff800000108114:	55                   	push   %rbp
ffff800000108115:	48 89 e5             	mov    %rsp,%rbp
ffff800000108118:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010811c:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010811f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int addr;
  if(argint(n, &addr) < 0)
ffff800000108123:	48 8d 55 fc          	lea    -0x4(%rbp),%rdx
ffff800000108127:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010812a:	48 89 d6             	mov    %rdx,%rsi
ffff80000010812d:	89 c7                	mov    %eax,%edi
ffff80000010812f:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000108136:	80 ff ff 
ffff800000108139:	ff d0                	call   *%rax
ffff80000010813b:	85 c0                	test   %eax,%eax
ffff80000010813d:	79 07                	jns    ffff800000108146 <argstr+0x32>
    return -1;
ffff80000010813f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108144:	eb 1b                	jmp    ffff800000108161 <argstr+0x4d>
  return fetchstr(addr, pp);
ffff800000108146:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000108149:	48 98                	cltq
ffff80000010814b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010814f:	48 89 d6             	mov    %rdx,%rsi
ffff800000108152:	48 89 c7             	mov    %rax,%rdi
ffff800000108155:	48 b8 9e 7e 10 00 00 	movabs $0xffff800000107e9e,%rax
ffff80000010815c:	80 ff ff 
ffff80000010815f:	ff d0                	call   *%rax
}
ffff800000108161:	c9                   	leave
ffff800000108162:	c3                   	ret

ffff800000108163 <syscall>:
  [SYS_vidputs] "vidputs",
};

void
syscall(struct trapframe *tf)
{
ffff800000108163:	55                   	push   %rbp
ffff800000108164:	48 89 e5             	mov    %rsp,%rbp
ffff800000108167:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010816b:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
  proc->tf = tf;
ffff80000010816f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108176:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010817a:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010817e:	48 89 50 28          	mov    %rdx,0x28(%rax)
  uint64 num = proc->tf->rax;
ffff800000108182:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108189:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010818d:	48 8b 40 28          	mov    0x28(%rax),%rax
ffff800000108191:	48 8b 00             	mov    (%rax),%rax
ffff800000108194:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  uint start_ticks, end_ticks, latency;

  


  if (num > 0 && num < NELEM(syscalls) && syscalls[num]) {
ffff800000108198:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010819d:	0f 84 e5 00 00 00    	je     ffff800000108288 <syscall+0x125>
ffff8000001081a3:	48 83 7d f8 19       	cmpq   $0x19,-0x8(%rbp)
ffff8000001081a8:	0f 87 da 00 00 00    	ja     ffff800000108288 <syscall+0x125>
ffff8000001081ae:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001081b5:	80 ff ff 
ffff8000001081b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081bc:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001081c0:	48 85 c0             	test   %rax,%rax
ffff8000001081c3:	0f 84 bf 00 00 00    	je     ffff800000108288 <syscall+0x125>
    start_ticks = ticks;
ffff8000001081c9:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff8000001081d0:	80 ff ff 
ffff8000001081d3:	8b 00                	mov    (%rax),%eax
ffff8000001081d5:	89 45 f4             	mov    %eax,-0xc(%rbp)
    tf->rax = syscalls[num]();
ffff8000001081d8:	48 ba a0 d5 10 00 00 	movabs $0xffff80000010d5a0,%rdx
ffff8000001081df:	80 ff ff 
ffff8000001081e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001081e6:	48 8b 04 c2          	mov    (%rdx,%rax,8),%rax
ffff8000001081ea:	ff d0                	call   *%rax
ffff8000001081ec:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff8000001081f0:	48 89 02             	mov    %rax,(%rdx)
    end_ticks = ticks;
ffff8000001081f3:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff8000001081fa:	80 ff ff 
ffff8000001081fd:	8b 00                	mov    (%rax),%eax
ffff8000001081ff:	89 45 f0             	mov    %eax,-0x10(%rbp)
    latency = end_ticks - start_ticks;
ffff800000108202:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff800000108205:	2b 45 f4             	sub    -0xc(%rbp),%eax
ffff800000108208:	89 45 ec             	mov    %eax,-0x14(%rbp)

    //call trace event function 
    if(num != SYS_traceread && num != SYS_vidclear && num != SYS_vidputc && num != SYS_vidputs)
ffff80000010820b:	48 83 7d f8 16       	cmpq   $0x16,-0x8(%rbp)
ffff800000108210:	0f 84 c7 00 00 00    	je     ffff8000001082dd <syscall+0x17a>
ffff800000108216:	48 83 7d f8 17       	cmpq   $0x17,-0x8(%rbp)
ffff80000010821b:	0f 84 bc 00 00 00    	je     ffff8000001082dd <syscall+0x17a>
ffff800000108221:	48 83 7d f8 18       	cmpq   $0x18,-0x8(%rbp)
ffff800000108226:	0f 84 b1 00 00 00    	je     ffff8000001082dd <syscall+0x17a>
ffff80000010822c:	48 83 7d f8 19       	cmpq   $0x19,-0x8(%rbp)
ffff800000108231:	0f 84 a6 00 00 00    	je     ffff8000001082dd <syscall+0x17a>
      traceevent(TRACE_TYPE_SYSCALL, proc->pid, num, tf->rax, latency, syscallnames[num]);
ffff800000108237:	48 ba 80 d6 10 00 00 	movabs $0xffff80000010d680,%rdx
ffff80000010823e:	80 ff ff 
ffff800000108241:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108245:	48 8b 0c c2          	mov    (%rdx,%rax,8),%rcx
ffff800000108249:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010824c:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108250:	48 8b 00             	mov    (%rax),%rax
ffff800000108253:	89 c7                	mov    %eax,%edi
ffff800000108255:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108259:	89 c6                	mov    %eax,%esi
ffff80000010825b:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000108262:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108266:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000108269:	49 89 c9             	mov    %rcx,%r9
ffff80000010826c:	41 89 d0             	mov    %edx,%r8d
ffff80000010826f:	89 f9                	mov    %edi,%ecx
ffff800000108271:	89 f2                	mov    %esi,%edx
ffff800000108273:	89 c6                	mov    %eax,%esi
ffff800000108275:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010827a:	48 b8 c4 c1 10 00 00 	movabs $0xffff80000010c1c4,%rax
ffff800000108281:	80 ff ff 
ffff800000108284:	ff d0                	call   *%rax
    if(num != SYS_traceread && num != SYS_vidclear && num != SYS_vidputc && num != SYS_vidputs)
ffff800000108286:	eb 55                	jmp    ffff8000001082dd <syscall+0x17a>

    // DEBUG: Print the PID, system call number, and the return value from the syscall
    // cprintf("trace: pid %d syscall %s(%d) -> %d\n", proc->pid, syscallnames[num], num, tf->rax);
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
ffff800000108288:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010828f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000108293:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff80000010829a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082a1:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("%d %s: unknown sys call %d\n",
ffff8000001082a5:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff8000001082a8:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001082ac:	48 bf 73 ca 10 00 00 	movabs $0xffff80000010ca73,%rdi
ffff8000001082b3:	80 ff ff 
ffff8000001082b6:	48 89 d1             	mov    %rdx,%rcx
ffff8000001082b9:	48 89 f2             	mov    %rsi,%rdx
ffff8000001082bc:	89 c6                	mov    %eax,%esi
ffff8000001082be:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001082c3:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff8000001082ca:	80 ff ff 
ffff8000001082cd:	41 ff d0             	call   *%r8
    tf->rax = -1;
ffff8000001082d0:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001082d4:	48 c7 00 ff ff ff ff 	movq   $0xffffffffffffffff,(%rax)
ffff8000001082db:	eb 01                	jmp    ffff8000001082de <syscall+0x17b>
    if(num != SYS_traceread && num != SYS_vidclear && num != SYS_vidputc && num != SYS_vidputs)
ffff8000001082dd:	90                   	nop
  }
  if (proc->killed)
ffff8000001082de:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001082e5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001082e9:	8b 40 40             	mov    0x40(%rax),%eax
ffff8000001082ec:	85 c0                	test   %eax,%eax
ffff8000001082ee:	74 0c                	je     ffff8000001082fc <syscall+0x199>
    exit();
ffff8000001082f0:	48 b8 15 6a 10 00 00 	movabs $0xffff800000106a15,%rax
ffff8000001082f7:	80 ff ff 
ffff8000001082fa:	ff d0                	call   *%rax
}
ffff8000001082fc:	90                   	nop
ffff8000001082fd:	c9                   	leave
ffff8000001082fe:	c3                   	ret

ffff8000001082ff <argfd>:
ffff8000001082ff:	55                   	push   %rbp
ffff800000108300:	48 89 e5             	mov    %rsp,%rbp
ffff800000108303:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108307:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010830a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010830e:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000108312:	48 8d 55 f4          	lea    -0xc(%rbp),%rdx
ffff800000108316:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000108319:	48 89 d6             	mov    %rdx,%rsi
ffff80000010831c:	89 c7                	mov    %eax,%edi
ffff80000010831e:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000108325:	80 ff ff 
ffff800000108328:	ff d0                	call   *%rax
ffff80000010832a:	85 c0                	test   %eax,%eax
ffff80000010832c:	79 07                	jns    ffff800000108335 <argfd+0x36>
ffff80000010832e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108333:	eb 62                	jmp    ffff800000108397 <argfd+0x98>
ffff800000108335:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff800000108338:	85 c0                	test   %eax,%eax
ffff80000010833a:	78 2d                	js     ffff800000108369 <argfd+0x6a>
ffff80000010833c:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010833f:	83 f8 0f             	cmp    $0xf,%eax
ffff800000108342:	7f 25                	jg     ffff800000108369 <argfd+0x6a>
ffff800000108344:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010834b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010834f:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108352:	48 63 d2             	movslq %edx,%rdx
ffff800000108355:	48 83 c2 08          	add    $0x8,%rdx
ffff800000108359:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff80000010835e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108362:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108367:	75 07                	jne    ffff800000108370 <argfd+0x71>
ffff800000108369:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010836e:	eb 27                	jmp    ffff800000108397 <argfd+0x98>
ffff800000108370:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff800000108375:	74 09                	je     ffff800000108380 <argfd+0x81>
ffff800000108377:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010837a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010837e:	89 10                	mov    %edx,(%rax)
ffff800000108380:	48 83 7d d8 00       	cmpq   $0x0,-0x28(%rbp)
ffff800000108385:	74 0b                	je     ffff800000108392 <argfd+0x93>
ffff800000108387:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010838b:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010838f:	48 89 10             	mov    %rdx,(%rax)
ffff800000108392:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108397:	c9                   	leave
ffff800000108398:	c3                   	ret

ffff800000108399 <fdalloc>:
ffff800000108399:	55                   	push   %rbp
ffff80000010839a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010839d:	48 83 ec 18          	sub    $0x18,%rsp
ffff8000001083a1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff8000001083a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff8000001083ac:	eb 46                	jmp    ffff8000001083f4 <fdalloc+0x5b>
ffff8000001083ae:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001083b5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001083b9:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001083bc:	48 63 d2             	movslq %edx,%rdx
ffff8000001083bf:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001083c3:	48 8b 44 d0 08       	mov    0x8(%rax,%rdx,8),%rax
ffff8000001083c8:	48 85 c0             	test   %rax,%rax
ffff8000001083cb:	75 23                	jne    ffff8000001083f0 <fdalloc+0x57>
ffff8000001083cd:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001083d4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001083d8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001083db:	48 63 d2             	movslq %edx,%rdx
ffff8000001083de:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
ffff8000001083e2:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001083e6:	48 89 54 c8 08       	mov    %rdx,0x8(%rax,%rcx,8)
ffff8000001083eb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001083ee:	eb 0f                	jmp    ffff8000001083ff <fdalloc+0x66>
ffff8000001083f0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff8000001083f4:	83 7d fc 0f          	cmpl   $0xf,-0x4(%rbp)
ffff8000001083f8:	7e b4                	jle    ffff8000001083ae <fdalloc+0x15>
ffff8000001083fa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001083ff:	c9                   	leave
ffff800000108400:	c3                   	ret

ffff800000108401 <sys_dup>:
ffff800000108401:	55                   	push   %rbp
ffff800000108402:	48 89 e5             	mov    %rsp,%rbp
ffff800000108405:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108409:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010840d:	48 89 c2             	mov    %rax,%rdx
ffff800000108410:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108415:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010841a:	48 b8 ff 82 10 00 00 	movabs $0xffff8000001082ff,%rax
ffff800000108421:	80 ff ff 
ffff800000108424:	ff d0                	call   *%rax
ffff800000108426:	85 c0                	test   %eax,%eax
ffff800000108428:	79 07                	jns    ffff800000108431 <sys_dup+0x30>
ffff80000010842a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010842f:	eb 39                	jmp    ffff80000010846a <sys_dup+0x69>
ffff800000108431:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108435:	48 89 c7             	mov    %rax,%rdi
ffff800000108438:	48 b8 99 83 10 00 00 	movabs $0xffff800000108399,%rax
ffff80000010843f:	80 ff ff 
ffff800000108442:	ff d0                	call   *%rax
ffff800000108444:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000108447:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010844b:	79 07                	jns    ffff800000108454 <sys_dup+0x53>
ffff80000010844d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108452:	eb 16                	jmp    ffff80000010846a <sys_dup+0x69>
ffff800000108454:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108458:	48 89 c7             	mov    %rax,%rdi
ffff80000010845b:	48 b8 0d 1d 10 00 00 	movabs $0xffff800000101d0d,%rax
ffff800000108462:	80 ff ff 
ffff800000108465:	ff d0                	call   *%rax
ffff800000108467:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010846a:	c9                   	leave
ffff80000010846b:	c3                   	ret

ffff80000010846c <sys_read>:
ffff80000010846c:	55                   	push   %rbp
ffff80000010846d:	48 89 e5             	mov    %rsp,%rbp
ffff800000108470:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000108474:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000108478:	48 89 c2             	mov    %rax,%rdx
ffff80000010847b:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108480:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108485:	48 b8 ff 82 10 00 00 	movabs $0xffff8000001082ff,%rax
ffff80000010848c:	80 ff ff 
ffff80000010848f:	ff d0                	call   *%rax
ffff800000108491:	85 c0                	test   %eax,%eax
ffff800000108493:	78 56                	js     ffff8000001084eb <sys_read+0x7f>
ffff800000108495:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff800000108499:	48 89 c6             	mov    %rax,%rsi
ffff80000010849c:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001084a1:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff8000001084a8:	80 ff ff 
ffff8000001084ab:	ff d0                	call   *%rax
ffff8000001084ad:	85 c0                	test   %eax,%eax
ffff8000001084af:	78 3a                	js     ffff8000001084eb <sys_read+0x7f>
ffff8000001084b1:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001084b4:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff8000001084b8:	48 89 c6             	mov    %rax,%rsi
ffff8000001084bb:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001084c0:	48 b8 8d 80 10 00 00 	movabs $0xffff80000010808d,%rax
ffff8000001084c7:	80 ff ff 
ffff8000001084ca:	ff d0                	call   *%rax
ffff8000001084cc:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff8000001084cf:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff8000001084d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001084d7:	48 89 ce             	mov    %rcx,%rsi
ffff8000001084da:	48 89 c7             	mov    %rax,%rdi
ffff8000001084dd:	48 b8 37 1f 10 00 00 	movabs $0xffff800000101f37,%rax
ffff8000001084e4:	80 ff ff 
ffff8000001084e7:	ff d0                	call   *%rax
ffff8000001084e9:	eb 05                	jmp    ffff8000001084f0 <sys_read+0x84>
ffff8000001084eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001084f0:	c9                   	leave
ffff8000001084f1:	c3                   	ret

ffff8000001084f2 <sys_write>:
ffff8000001084f2:	55                   	push   %rbp
ffff8000001084f3:	48 89 e5             	mov    %rsp,%rbp
ffff8000001084f6:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001084fa:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001084fe:	48 89 c2             	mov    %rax,%rdx
ffff800000108501:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108506:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010850b:	48 b8 ff 82 10 00 00 	movabs $0xffff8000001082ff,%rax
ffff800000108512:	80 ff ff 
ffff800000108515:	ff d0                	call   *%rax
ffff800000108517:	85 c0                	test   %eax,%eax
ffff800000108519:	78 56                	js     ffff800000108571 <sys_write+0x7f>
ffff80000010851b:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff80000010851f:	48 89 c6             	mov    %rax,%rsi
ffff800000108522:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000108527:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff80000010852e:	80 ff ff 
ffff800000108531:	ff d0                	call   *%rax
ffff800000108533:	85 c0                	test   %eax,%eax
ffff800000108535:	78 3a                	js     ffff800000108571 <sys_write+0x7f>
ffff800000108537:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010853a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff80000010853e:	48 89 c6             	mov    %rax,%rsi
ffff800000108541:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108546:	48 b8 8d 80 10 00 00 	movabs $0xffff80000010808d,%rax
ffff80000010854d:	80 ff ff 
ffff800000108550:	ff d0                	call   *%rax
ffff800000108552:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff800000108555:	48 8b 4d e8          	mov    -0x18(%rbp),%rcx
ffff800000108559:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010855d:	48 89 ce             	mov    %rcx,%rsi
ffff800000108560:	48 89 c7             	mov    %rax,%rdi
ffff800000108563:	48 b8 2b 20 10 00 00 	movabs $0xffff80000010202b,%rax
ffff80000010856a:	80 ff ff 
ffff80000010856d:	ff d0                	call   *%rax
ffff80000010856f:	eb 05                	jmp    ffff800000108576 <sys_write+0x84>
ffff800000108571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108576:	c9                   	leave
ffff800000108577:	c3                   	ret

ffff800000108578 <sys_close>:
ffff800000108578:	55                   	push   %rbp
ffff800000108579:	48 89 e5             	mov    %rsp,%rbp
ffff80000010857c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000108580:	48 8d 55 f0          	lea    -0x10(%rbp),%rdx
ffff800000108584:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000108588:	48 89 c6             	mov    %rax,%rsi
ffff80000010858b:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108590:	48 b8 ff 82 10 00 00 	movabs $0xffff8000001082ff,%rax
ffff800000108597:	80 ff ff 
ffff80000010859a:	ff d0                	call   *%rax
ffff80000010859c:	85 c0                	test   %eax,%eax
ffff80000010859e:	79 07                	jns    ffff8000001085a7 <sys_close+0x2f>
ffff8000001085a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001085a5:	eb 36                	jmp    ffff8000001085dd <sys_close+0x65>
ffff8000001085a7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001085ae:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001085b2:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001085b5:	48 63 d2             	movslq %edx,%rdx
ffff8000001085b8:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001085bc:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff8000001085c3:	00 00 
ffff8000001085c5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001085c9:	48 89 c7             	mov    %rax,%rdi
ffff8000001085cc:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff8000001085d3:	80 ff ff 
ffff8000001085d6:	ff d0                	call   *%rax
ffff8000001085d8:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001085dd:	c9                   	leave
ffff8000001085de:	c3                   	ret

ffff8000001085df <sys_fstat>:
ffff8000001085df:	55                   	push   %rbp
ffff8000001085e0:	48 89 e5             	mov    %rsp,%rbp
ffff8000001085e3:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001085e7:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001085eb:	48 89 c2             	mov    %rax,%rdx
ffff8000001085ee:	be 00 00 00 00       	mov    $0x0,%esi
ffff8000001085f3:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001085f8:	48 b8 ff 82 10 00 00 	movabs $0xffff8000001082ff,%rax
ffff8000001085ff:	80 ff ff 
ffff800000108602:	ff d0                	call   *%rax
ffff800000108604:	85 c0                	test   %eax,%eax
ffff800000108606:	78 39                	js     ffff800000108641 <sys_fstat+0x62>
ffff800000108608:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010860c:	ba 14 00 00 00       	mov    $0x14,%edx
ffff800000108611:	48 89 c6             	mov    %rax,%rsi
ffff800000108614:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108619:	48 b8 8d 80 10 00 00 	movabs $0xffff80000010808d,%rax
ffff800000108620:	80 ff ff 
ffff800000108623:	ff d0                	call   *%rax
ffff800000108625:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff800000108629:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010862d:	48 89 d6             	mov    %rdx,%rsi
ffff800000108630:	48 89 c7             	mov    %rax,%rdi
ffff800000108633:	48 b8 c2 1e 10 00 00 	movabs $0xffff800000101ec2,%rax
ffff80000010863a:	80 ff ff 
ffff80000010863d:	ff d0                	call   *%rax
ffff80000010863f:	eb 05                	jmp    ffff800000108646 <sys_fstat+0x67>
ffff800000108641:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108646:	c9                   	leave
ffff800000108647:	c3                   	ret

ffff800000108648 <isdirempty>:
ffff800000108648:	55                   	push   %rbp
ffff800000108649:	48 89 e5             	mov    %rsp,%rbp
ffff80000010864c:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108650:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff800000108654:	c7 45 fc 20 00 00 00 	movl   $0x20,-0x4(%rbp)
ffff80000010865b:	eb 56                	jmp    ffff8000001086b3 <isdirempty+0x6b>
ffff80000010865d:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff800000108660:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108664:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000108668:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff80000010866d:	48 89 c7             	mov    %rax,%rdi
ffff800000108670:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff800000108677:	80 ff ff 
ffff80000010867a:	ff d0                	call   *%rax
ffff80000010867c:	83 f8 10             	cmp    $0x10,%eax
ffff80000010867f:	74 19                	je     ffff80000010869a <isdirempty+0x52>
ffff800000108681:	48 b8 8f ca 10 00 00 	movabs $0xffff80000010ca8f,%rax
ffff800000108688:	80 ff ff 
ffff80000010868b:	48 89 c7             	mov    %rax,%rdi
ffff80000010868e:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108695:	80 ff ff 
ffff800000108698:	ff d0                	call   *%rax
ffff80000010869a:	0f b7 45 e0          	movzwl -0x20(%rbp),%eax
ffff80000010869e:	66 85 c0             	test   %ax,%ax
ffff8000001086a1:	74 07                	je     ffff8000001086aa <isdirempty+0x62>
ffff8000001086a3:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001086a8:	eb 1f                	jmp    ffff8000001086c9 <isdirempty+0x81>
ffff8000001086aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001086ad:	83 c0 10             	add    $0x10,%eax
ffff8000001086b0:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff8000001086b3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001086b7:	8b 80 9c 00 00 00    	mov    0x9c(%rax),%eax
ffff8000001086bd:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001086c0:	39 c2                	cmp    %eax,%edx
ffff8000001086c2:	72 99                	jb     ffff80000010865d <isdirempty+0x15>
ffff8000001086c4:	b8 01 00 00 00       	mov    $0x1,%eax
ffff8000001086c9:	c9                   	leave
ffff8000001086ca:	c3                   	ret

ffff8000001086cb <sys_link>:
ffff8000001086cb:	55                   	push   %rbp
ffff8000001086cc:	48 89 e5             	mov    %rsp,%rbp
ffff8000001086cf:	48 83 ec 30          	sub    $0x30,%rsp
ffff8000001086d3:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
ffff8000001086d7:	48 89 c6             	mov    %rax,%rsi
ffff8000001086da:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001086df:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff8000001086e6:	80 ff ff 
ffff8000001086e9:	ff d0                	call   *%rax
ffff8000001086eb:	85 c0                	test   %eax,%eax
ffff8000001086ed:	78 1c                	js     ffff80000010870b <sys_link+0x40>
ffff8000001086ef:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
ffff8000001086f3:	48 89 c6             	mov    %rax,%rsi
ffff8000001086f6:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001086fb:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff800000108702:	80 ff ff 
ffff800000108705:	ff d0                	call   *%rax
ffff800000108707:	85 c0                	test   %eax,%eax
ffff800000108709:	79 0a                	jns    ffff800000108715 <sys_link+0x4a>
ffff80000010870b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108710:	e9 f3 01 00 00       	jmp    ffff800000108908 <sys_link+0x23d>
ffff800000108715:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff80000010871c:	80 ff ff 
ffff80000010871f:	ff d0                	call   *%rax
ffff800000108721:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff800000108725:	48 89 c7             	mov    %rax,%rdi
ffff800000108728:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff80000010872f:	80 ff ff 
ffff800000108732:	ff d0                	call   *%rax
ffff800000108734:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108738:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010873d:	75 16                	jne    ffff800000108755 <sys_link+0x8a>
ffff80000010873f:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108746:	80 ff ff 
ffff800000108749:	ff d0                	call   *%rax
ffff80000010874b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108750:	e9 b3 01 00 00       	jmp    ffff800000108908 <sys_link+0x23d>
ffff800000108755:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108759:	48 89 c7             	mov    %rax,%rdi
ffff80000010875c:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108763:	80 ff ff 
ffff800000108766:	ff d0                	call   *%rax
ffff800000108768:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010876c:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108773:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108777:	75 29                	jne    ffff8000001087a2 <sys_link+0xd7>
ffff800000108779:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010877d:	48 89 c7             	mov    %rax,%rdi
ffff800000108780:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108787:	80 ff ff 
ffff80000010878a:	ff d0                	call   *%rax
ffff80000010878c:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108793:	80 ff ff 
ffff800000108796:	ff d0                	call   *%rax
ffff800000108798:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010879d:	e9 66 01 00 00       	jmp    ffff800000108908 <sys_link+0x23d>
ffff8000001087a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087a6:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001087ad:	83 c0 01             	add    $0x1,%eax
ffff8000001087b0:	89 c2                	mov    %eax,%edx
ffff8000001087b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087b6:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
ffff8000001087bd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087c1:	48 89 c7             	mov    %rax,%rdi
ffff8000001087c4:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff8000001087cb:	80 ff ff 
ffff8000001087ce:	ff d0                	call   *%rax
ffff8000001087d0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001087d4:	48 89 c7             	mov    %rax,%rdi
ffff8000001087d7:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff8000001087de:	80 ff ff 
ffff8000001087e1:	ff d0                	call   *%rax
ffff8000001087e3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001087e7:	48 8d 55 e2          	lea    -0x1e(%rbp),%rdx
ffff8000001087eb:	48 89 d6             	mov    %rdx,%rsi
ffff8000001087ee:	48 89 c7             	mov    %rax,%rdi
ffff8000001087f1:	48 b8 e5 38 10 00 00 	movabs $0xffff8000001038e5,%rax
ffff8000001087f8:	80 ff ff 
ffff8000001087fb:	ff d0                	call   *%rax
ffff8000001087fd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108801:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108806:	0f 84 96 00 00 00    	je     ffff8000001088a2 <sys_link+0x1d7>
ffff80000010880c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108810:	48 89 c7             	mov    %rax,%rdi
ffff800000108813:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff80000010881a:	80 ff ff 
ffff80000010881d:	ff d0                	call   *%rax
ffff80000010881f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108823:	8b 10                	mov    (%rax),%edx
ffff800000108825:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108829:	8b 00                	mov    (%rax),%eax
ffff80000010882b:	39 c2                	cmp    %eax,%edx
ffff80000010882d:	75 25                	jne    ffff800000108854 <sys_link+0x189>
ffff80000010882f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108833:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108836:	48 8d 4d e2          	lea    -0x1e(%rbp),%rcx
ffff80000010883a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010883e:	48 89 ce             	mov    %rcx,%rsi
ffff800000108841:	48 89 c7             	mov    %rax,%rdi
ffff800000108844:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff80000010884b:	80 ff ff 
ffff80000010884e:	ff d0                	call   *%rax
ffff800000108850:	85 c0                	test   %eax,%eax
ffff800000108852:	79 15                	jns    ffff800000108869 <sys_link+0x19e>
ffff800000108854:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108858:	48 89 c7             	mov    %rax,%rdi
ffff80000010885b:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108862:	80 ff ff 
ffff800000108865:	ff d0                	call   *%rax
ffff800000108867:	eb 3a                	jmp    ffff8000001088a3 <sys_link+0x1d8>
ffff800000108869:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010886d:	48 89 c7             	mov    %rax,%rdi
ffff800000108870:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108877:	80 ff ff 
ffff80000010887a:	ff d0                	call   *%rax
ffff80000010887c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108880:	48 89 c7             	mov    %rax,%rdi
ffff800000108883:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff80000010888a:	80 ff ff 
ffff80000010888d:	ff d0                	call   *%rax
ffff80000010888f:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108896:	80 ff ff 
ffff800000108899:	ff d0                	call   *%rax
ffff80000010889b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001088a0:	eb 66                	jmp    ffff800000108908 <sys_link+0x23d>
ffff8000001088a2:	90                   	nop
ffff8000001088a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088a7:	48 89 c7             	mov    %rax,%rdi
ffff8000001088aa:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff8000001088b1:	80 ff ff 
ffff8000001088b4:	ff d0                	call   *%rax
ffff8000001088b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088ba:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff8000001088c1:	83 e8 01             	sub    $0x1,%eax
ffff8000001088c4:	89 c2                	mov    %eax,%edx
ffff8000001088c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088ca:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
ffff8000001088d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088d5:	48 89 c7             	mov    %rax,%rdi
ffff8000001088d8:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff8000001088df:	80 ff ff 
ffff8000001088e2:	ff d0                	call   *%rax
ffff8000001088e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001088e8:	48 89 c7             	mov    %rax,%rdi
ffff8000001088eb:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff8000001088f2:	80 ff ff 
ffff8000001088f5:	ff d0                	call   *%rax
ffff8000001088f7:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001088fe:	80 ff ff 
ffff800000108901:	ff d0                	call   *%rax
ffff800000108903:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108908:	c9                   	leave
ffff800000108909:	c3                   	ret

ffff80000010890a <sys_unlink>:
ffff80000010890a:	55                   	push   %rbp
ffff80000010890b:	48 89 e5             	mov    %rsp,%rbp
ffff80000010890e:	48 83 ec 40          	sub    $0x40,%rsp
ffff800000108912:	48 8d 45 c8          	lea    -0x38(%rbp),%rax
ffff800000108916:	48 89 c6             	mov    %rax,%rsi
ffff800000108919:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010891e:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff800000108925:	80 ff ff 
ffff800000108928:	ff d0                	call   *%rax
ffff80000010892a:	85 c0                	test   %eax,%eax
ffff80000010892c:	79 0a                	jns    ffff800000108938 <sys_unlink+0x2e>
ffff80000010892e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108933:	e9 7b 02 00 00       	jmp    ffff800000108bb3 <sys_unlink+0x2a9>
ffff800000108938:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff80000010893f:	80 ff ff 
ffff800000108942:	ff d0                	call   *%rax
ffff800000108944:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108948:	48 8d 55 d2          	lea    -0x2e(%rbp),%rdx
ffff80000010894c:	48 89 d6             	mov    %rdx,%rsi
ffff80000010894f:	48 89 c7             	mov    %rax,%rdi
ffff800000108952:	48 b8 e5 38 10 00 00 	movabs $0xffff8000001038e5,%rax
ffff800000108959:	80 ff ff 
ffff80000010895c:	ff d0                	call   *%rax
ffff80000010895e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108962:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108967:	75 16                	jne    ffff80000010897f <sys_unlink+0x75>
ffff800000108969:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108970:	80 ff ff 
ffff800000108973:	ff d0                	call   *%rax
ffff800000108975:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010897a:	e9 34 02 00 00       	jmp    ffff800000108bb3 <sys_unlink+0x2a9>
ffff80000010897f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108983:	48 89 c7             	mov    %rax,%rdi
ffff800000108986:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff80000010898d:	80 ff ff 
ffff800000108990:	ff d0                	call   *%rax
ffff800000108992:	48 ba a1 ca 10 00 00 	movabs $0xffff80000010caa1,%rdx
ffff800000108999:	80 ff ff 
ffff80000010899c:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff8000001089a0:	48 89 d6             	mov    %rdx,%rsi
ffff8000001089a3:	48 89 c7             	mov    %rax,%rdi
ffff8000001089a6:	48 b8 fa 33 10 00 00 	movabs $0xffff8000001033fa,%rax
ffff8000001089ad:	80 ff ff 
ffff8000001089b0:	ff d0                	call   *%rax
ffff8000001089b2:	85 c0                	test   %eax,%eax
ffff8000001089b4:	0f 84 d1 01 00 00    	je     ffff800000108b8b <sys_unlink+0x281>
ffff8000001089ba:	48 ba a3 ca 10 00 00 	movabs $0xffff80000010caa3,%rdx
ffff8000001089c1:	80 ff ff 
ffff8000001089c4:	48 8d 45 d2          	lea    -0x2e(%rbp),%rax
ffff8000001089c8:	48 89 d6             	mov    %rdx,%rsi
ffff8000001089cb:	48 89 c7             	mov    %rax,%rdi
ffff8000001089ce:	48 b8 fa 33 10 00 00 	movabs $0xffff8000001033fa,%rax
ffff8000001089d5:	80 ff ff 
ffff8000001089d8:	ff d0                	call   *%rax
ffff8000001089da:	85 c0                	test   %eax,%eax
ffff8000001089dc:	0f 84 a9 01 00 00    	je     ffff800000108b8b <sys_unlink+0x281>
ffff8000001089e2:	48 8d 55 c4          	lea    -0x3c(%rbp),%rdx
ffff8000001089e6:	48 8d 4d d2          	lea    -0x2e(%rbp),%rcx
ffff8000001089ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001089ee:	48 89 ce             	mov    %rcx,%rsi
ffff8000001089f1:	48 89 c7             	mov    %rax,%rdi
ffff8000001089f4:	48 b8 2b 34 10 00 00 	movabs $0xffff80000010342b,%rax
ffff8000001089fb:	80 ff ff 
ffff8000001089fe:	ff d0                	call   *%rax
ffff800000108a00:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108a04:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108a09:	0f 84 7f 01 00 00    	je     ffff800000108b8e <sys_unlink+0x284>
ffff800000108a0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a13:	48 89 c7             	mov    %rax,%rdi
ffff800000108a16:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108a1d:	80 ff ff 
ffff800000108a20:	ff d0                	call   *%rax
ffff800000108a22:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a26:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108a2d:	66 85 c0             	test   %ax,%ax
ffff800000108a30:	7f 19                	jg     ffff800000108a4b <sys_unlink+0x141>
ffff800000108a32:	48 b8 a6 ca 10 00 00 	movabs $0xffff80000010caa6,%rax
ffff800000108a39:	80 ff ff 
ffff800000108a3c:	48 89 c7             	mov    %rax,%rdi
ffff800000108a3f:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108a46:	80 ff ff 
ffff800000108a49:	ff d0                	call   *%rax
ffff800000108a4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a4f:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108a56:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108a5a:	75 2f                	jne    ffff800000108a8b <sys_unlink+0x181>
ffff800000108a5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a60:	48 89 c7             	mov    %rax,%rdi
ffff800000108a63:	48 b8 48 86 10 00 00 	movabs $0xffff800000108648,%rax
ffff800000108a6a:	80 ff ff 
ffff800000108a6d:	ff d0                	call   *%rax
ffff800000108a6f:	85 c0                	test   %eax,%eax
ffff800000108a71:	75 18                	jne    ffff800000108a8b <sys_unlink+0x181>
ffff800000108a73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108a77:	48 89 c7             	mov    %rax,%rdi
ffff800000108a7a:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108a81:	80 ff ff 
ffff800000108a84:	ff d0                	call   *%rax
ffff800000108a86:	e9 04 01 00 00       	jmp    ffff800000108b8f <sys_unlink+0x285>
ffff800000108a8b:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108a8f:	ba 10 00 00 00       	mov    $0x10,%edx
ffff800000108a94:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000108a99:	48 89 c7             	mov    %rax,%rdi
ffff800000108a9c:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff800000108aa3:	80 ff ff 
ffff800000108aa6:	ff d0                	call   *%rax
ffff800000108aa8:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff800000108aab:	48 8d 75 e0          	lea    -0x20(%rbp),%rsi
ffff800000108aaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ab3:	b9 10 00 00 00       	mov    $0x10,%ecx
ffff800000108ab8:	48 89 c7             	mov    %rax,%rdi
ffff800000108abb:	48 b8 ea 31 10 00 00 	movabs $0xffff8000001031ea,%rax
ffff800000108ac2:	80 ff ff 
ffff800000108ac5:	ff d0                	call   *%rax
ffff800000108ac7:	83 f8 10             	cmp    $0x10,%eax
ffff800000108aca:	74 19                	je     ffff800000108ae5 <sys_unlink+0x1db>
ffff800000108acc:	48 b8 b8 ca 10 00 00 	movabs $0xffff80000010cab8,%rax
ffff800000108ad3:	80 ff ff 
ffff800000108ad6:	48 89 c7             	mov    %rax,%rdi
ffff800000108ad9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108ae0:	80 ff ff 
ffff800000108ae3:	ff d0                	call   *%rax
ffff800000108ae5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ae9:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108af0:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108af4:	75 2e                	jne    ffff800000108b24 <sys_unlink+0x21a>
ffff800000108af6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108afa:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108b01:	83 e8 01             	sub    $0x1,%eax
ffff800000108b04:	89 c2                	mov    %eax,%edx
ffff800000108b06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b0a:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
ffff800000108b11:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b15:	48 89 c7             	mov    %rax,%rdi
ffff800000108b18:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108b1f:	80 ff ff 
ffff800000108b22:	ff d0                	call   *%rax
ffff800000108b24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b28:	48 89 c7             	mov    %rax,%rdi
ffff800000108b2b:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108b32:	80 ff ff 
ffff800000108b35:	ff d0                	call   *%rax
ffff800000108b37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b3b:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108b42:	83 e8 01             	sub    $0x1,%eax
ffff800000108b45:	89 c2                	mov    %eax,%edx
ffff800000108b47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b4b:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
ffff800000108b52:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b56:	48 89 c7             	mov    %rax,%rdi
ffff800000108b59:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108b60:	80 ff ff 
ffff800000108b63:	ff d0                	call   *%rax
ffff800000108b65:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108b69:	48 89 c7             	mov    %rax,%rdi
ffff800000108b6c:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108b73:	80 ff ff 
ffff800000108b76:	ff d0                	call   *%rax
ffff800000108b78:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108b7f:	80 ff ff 
ffff800000108b82:	ff d0                	call   *%rax
ffff800000108b84:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108b89:	eb 28                	jmp    ffff800000108bb3 <sys_unlink+0x2a9>
ffff800000108b8b:	90                   	nop
ffff800000108b8c:	eb 01                	jmp    ffff800000108b8f <sys_unlink+0x285>
ffff800000108b8e:	90                   	nop
ffff800000108b8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108b93:	48 89 c7             	mov    %rax,%rdi
ffff800000108b96:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108b9d:	80 ff ff 
ffff800000108ba0:	ff d0                	call   *%rax
ffff800000108ba2:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108ba9:	80 ff ff 
ffff800000108bac:	ff d0                	call   *%rax
ffff800000108bae:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108bb3:	c9                   	leave
ffff800000108bb4:	c3                   	ret

ffff800000108bb5 <create>:
ffff800000108bb5:	55                   	push   %rbp
ffff800000108bb6:	48 89 e5             	mov    %rsp,%rbp
ffff800000108bb9:	48 83 ec 50          	sub    $0x50,%rsp
ffff800000108bbd:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff800000108bc1:	89 c8                	mov    %ecx,%eax
ffff800000108bc3:	89 f1                	mov    %esi,%ecx
ffff800000108bc5:	66 89 4d c4          	mov    %cx,-0x3c(%rbp)
ffff800000108bc9:	66 89 55 c0          	mov    %dx,-0x40(%rbp)
ffff800000108bcd:	66 89 45 bc          	mov    %ax,-0x44(%rbp)
ffff800000108bd1:	48 8d 55 de          	lea    -0x22(%rbp),%rdx
ffff800000108bd5:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff800000108bd9:	48 89 d6             	mov    %rdx,%rsi
ffff800000108bdc:	48 89 c7             	mov    %rax,%rdi
ffff800000108bdf:	48 b8 e5 38 10 00 00 	movabs $0xffff8000001038e5,%rax
ffff800000108be6:	80 ff ff 
ffff800000108be9:	ff d0                	call   *%rax
ffff800000108beb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108bef:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108bf4:	75 0a                	jne    ffff800000108c00 <create+0x4b>
ffff800000108bf6:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108bfb:	e9 2c 02 00 00       	jmp    ffff800000108e2c <create+0x277>
ffff800000108c00:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c04:	48 89 c7             	mov    %rax,%rdi
ffff800000108c07:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108c0e:	80 ff ff 
ffff800000108c11:	ff d0                	call   *%rax
ffff800000108c13:	48 8d 55 ec          	lea    -0x14(%rbp),%rdx
ffff800000108c17:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108c1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c1f:	48 89 ce             	mov    %rcx,%rsi
ffff800000108c22:	48 89 c7             	mov    %rax,%rdi
ffff800000108c25:	48 b8 2b 34 10 00 00 	movabs $0xffff80000010342b,%rax
ffff800000108c2c:	80 ff ff 
ffff800000108c2f:	ff d0                	call   *%rax
ffff800000108c31:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108c35:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108c3a:	74 64                	je     ffff800000108ca0 <create+0xeb>
ffff800000108c3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108c40:	48 89 c7             	mov    %rax,%rdi
ffff800000108c43:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108c4a:	80 ff ff 
ffff800000108c4d:	ff d0                	call   *%rax
ffff800000108c4f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c53:	48 89 c7             	mov    %rax,%rdi
ffff800000108c56:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108c5d:	80 ff ff 
ffff800000108c60:	ff d0                	call   *%rax
ffff800000108c62:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%rbp)
ffff800000108c67:	75 1a                	jne    ffff800000108c83 <create+0xce>
ffff800000108c69:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c6d:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108c74:	66 83 f8 02          	cmp    $0x2,%ax
ffff800000108c78:	75 09                	jne    ffff800000108c83 <create+0xce>
ffff800000108c7a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c7e:	e9 a9 01 00 00       	jmp    ffff800000108e2c <create+0x277>
ffff800000108c83:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108c87:	48 89 c7             	mov    %rax,%rdi
ffff800000108c8a:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108c91:	80 ff ff 
ffff800000108c94:	ff d0                	call   *%rax
ffff800000108c96:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000108c9b:	e9 8c 01 00 00       	jmp    ffff800000108e2c <create+0x277>
ffff800000108ca0:	0f bf 55 c4          	movswl -0x3c(%rbp),%edx
ffff800000108ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108ca8:	8b 00                	mov    (%rax),%eax
ffff800000108caa:	89 d6                	mov    %edx,%esi
ffff800000108cac:	89 c7                	mov    %eax,%edi
ffff800000108cae:	48 b8 e8 25 10 00 00 	movabs $0xffff8000001025e8,%rax
ffff800000108cb5:	80 ff ff 
ffff800000108cb8:	ff d0                	call   *%rax
ffff800000108cba:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108cbe:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108cc3:	75 19                	jne    ffff800000108cde <create+0x129>
ffff800000108cc5:	48 b8 c7 ca 10 00 00 	movabs $0xffff80000010cac7,%rax
ffff800000108ccc:	80 ff ff 
ffff800000108ccf:	48 89 c7             	mov    %rax,%rdi
ffff800000108cd2:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108cd9:	80 ff ff 
ffff800000108cdc:	ff d0                	call   *%rax
ffff800000108cde:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ce2:	48 89 c7             	mov    %rax,%rdi
ffff800000108ce5:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108cec:	80 ff ff 
ffff800000108cef:	ff d0                	call   *%rax
ffff800000108cf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108cf5:	0f b7 55 c0          	movzwl -0x40(%rbp),%edx
ffff800000108cf9:	66 89 90 96 00 00 00 	mov    %dx,0x96(%rax)
ffff800000108d00:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d04:	0f b7 55 bc          	movzwl -0x44(%rbp),%edx
ffff800000108d08:	66 89 90 98 00 00 00 	mov    %dx,0x98(%rax)
ffff800000108d0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d13:	66 c7 80 9a 00 00 00 	movw   $0x1,0x9a(%rax)
ffff800000108d1a:	01 00 
ffff800000108d1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d20:	48 89 c7             	mov    %rax,%rdi
ffff800000108d23:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108d2a:	80 ff ff 
ffff800000108d2d:	ff d0                	call   *%rax
ffff800000108d2f:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%rbp)
ffff800000108d34:	0f 85 9d 00 00 00    	jne    ffff800000108dd7 <create+0x222>
ffff800000108d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d3e:	0f b7 80 9a 00 00 00 	movzwl 0x9a(%rax),%eax
ffff800000108d45:	83 c0 01             	add    $0x1,%eax
ffff800000108d48:	89 c2                	mov    %eax,%edx
ffff800000108d4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d4e:	66 89 90 9a 00 00 00 	mov    %dx,0x9a(%rax)
ffff800000108d55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d59:	48 89 c7             	mov    %rax,%rdi
ffff800000108d5c:	48 b8 10 27 10 00 00 	movabs $0xffff800000102710,%rax
ffff800000108d63:	80 ff ff 
ffff800000108d66:	ff d0                	call   *%rax
ffff800000108d68:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d6c:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d6f:	48 b9 a1 ca 10 00 00 	movabs $0xffff80000010caa1,%rcx
ffff800000108d76:	80 ff ff 
ffff800000108d79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108d7d:	48 89 ce             	mov    %rcx,%rsi
ffff800000108d80:	48 89 c7             	mov    %rax,%rdi
ffff800000108d83:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108d8a:	80 ff ff 
ffff800000108d8d:	ff d0                	call   *%rax
ffff800000108d8f:	85 c0                	test   %eax,%eax
ffff800000108d91:	78 2b                	js     ffff800000108dbe <create+0x209>
ffff800000108d93:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108d97:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108d9a:	48 b9 a3 ca 10 00 00 	movabs $0xffff80000010caa3,%rcx
ffff800000108da1:	80 ff ff 
ffff800000108da4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108da8:	48 89 ce             	mov    %rcx,%rsi
ffff800000108dab:	48 89 c7             	mov    %rax,%rdi
ffff800000108dae:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108db5:	80 ff ff 
ffff800000108db8:	ff d0                	call   *%rax
ffff800000108dba:	85 c0                	test   %eax,%eax
ffff800000108dbc:	79 19                	jns    ffff800000108dd7 <create+0x222>
ffff800000108dbe:	48 b8 d6 ca 10 00 00 	movabs $0xffff80000010cad6,%rax
ffff800000108dc5:	80 ff ff 
ffff800000108dc8:	48 89 c7             	mov    %rax,%rdi
ffff800000108dcb:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108dd2:	80 ff ff 
ffff800000108dd5:	ff d0                	call   *%rax
ffff800000108dd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ddb:	8b 50 04             	mov    0x4(%rax),%edx
ffff800000108dde:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
ffff800000108de2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108de6:	48 89 ce             	mov    %rcx,%rsi
ffff800000108de9:	48 89 c7             	mov    %rax,%rdi
ffff800000108dec:	48 b8 31 35 10 00 00 	movabs $0xffff800000103531,%rax
ffff800000108df3:	80 ff ff 
ffff800000108df6:	ff d0                	call   *%rax
ffff800000108df8:	85 c0                	test   %eax,%eax
ffff800000108dfa:	79 19                	jns    ffff800000108e15 <create+0x260>
ffff800000108dfc:	48 b8 e2 ca 10 00 00 	movabs $0xffff80000010cae2,%rax
ffff800000108e03:	80 ff ff 
ffff800000108e06:	48 89 c7             	mov    %rax,%rdi
ffff800000108e09:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000108e10:	80 ff ff 
ffff800000108e13:	ff d0                	call   *%rax
ffff800000108e15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108e19:	48 89 c7             	mov    %rax,%rdi
ffff800000108e1c:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108e23:	80 ff ff 
ffff800000108e26:	ff d0                	call   *%rax
ffff800000108e28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108e2c:	c9                   	leave
ffff800000108e2d:	c3                   	ret

ffff800000108e2e <sys_open>:
ffff800000108e2e:	55                   	push   %rbp
ffff800000108e2f:	48 89 e5             	mov    %rsp,%rbp
ffff800000108e32:	48 83 ec 30          	sub    $0x30,%rsp
ffff800000108e36:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
ffff800000108e3a:	48 89 c6             	mov    %rax,%rsi
ffff800000108e3d:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000108e42:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff800000108e49:	80 ff ff 
ffff800000108e4c:	ff d0                	call   *%rax
ffff800000108e4e:	85 c0                	test   %eax,%eax
ffff800000108e50:	78 1c                	js     ffff800000108e6e <sys_open+0x40>
ffff800000108e52:	48 8d 45 dc          	lea    -0x24(%rbp),%rax
ffff800000108e56:	48 89 c6             	mov    %rax,%rsi
ffff800000108e59:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000108e5e:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000108e65:	80 ff ff 
ffff800000108e68:	ff d0                	call   *%rax
ffff800000108e6a:	85 c0                	test   %eax,%eax
ffff800000108e6c:	79 0a                	jns    ffff800000108e78 <sys_open+0x4a>
ffff800000108e6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108e73:	e9 de 01 00 00       	jmp    ffff800000109056 <sys_open+0x228>
ffff800000108e78:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff800000108e7f:	80 ff ff 
ffff800000108e82:	ff d0                	call   *%rax
ffff800000108e84:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108e87:	25 00 02 00 00       	and    $0x200,%eax
ffff800000108e8c:	85 c0                	test   %eax,%eax
ffff800000108e8e:	74 47                	je     ffff800000108ed7 <sys_open+0xa9>
ffff800000108e90:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108e94:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000108e99:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000108e9e:	be 02 00 00 00       	mov    $0x2,%esi
ffff800000108ea3:	48 89 c7             	mov    %rax,%rdi
ffff800000108ea6:	48 b8 b5 8b 10 00 00 	movabs $0xffff800000108bb5,%rax
ffff800000108ead:	80 ff ff 
ffff800000108eb0:	ff d0                	call   *%rax
ffff800000108eb2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108eb6:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108ebb:	0f 85 9e 00 00 00    	jne    ffff800000108f5f <sys_open+0x131>
ffff800000108ec1:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108ec8:	80 ff ff 
ffff800000108ecb:	ff d0                	call   *%rax
ffff800000108ecd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108ed2:	e9 7f 01 00 00       	jmp    ffff800000109056 <sys_open+0x228>
ffff800000108ed7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff800000108edb:	48 89 c7             	mov    %rax,%rdi
ffff800000108ede:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff800000108ee5:	80 ff ff 
ffff800000108ee8:	ff d0                	call   *%rax
ffff800000108eea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000108eee:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000108ef3:	75 16                	jne    ffff800000108f0b <sys_open+0xdd>
ffff800000108ef5:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108efc:	80 ff ff 
ffff800000108eff:	ff d0                	call   *%rax
ffff800000108f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f06:	e9 4b 01 00 00       	jmp    ffff800000109056 <sys_open+0x228>
ffff800000108f0b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f0f:	48 89 c7             	mov    %rax,%rdi
ffff800000108f12:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000108f19:	80 ff ff 
ffff800000108f1c:	ff d0                	call   *%rax
ffff800000108f1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f22:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000108f29:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000108f2d:	75 30                	jne    ffff800000108f5f <sys_open+0x131>
ffff800000108f2f:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000108f32:	85 c0                	test   %eax,%eax
ffff800000108f34:	74 29                	je     ffff800000108f5f <sys_open+0x131>
ffff800000108f36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108f3a:	48 89 c7             	mov    %rax,%rdi
ffff800000108f3d:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108f44:	80 ff ff 
ffff800000108f47:	ff d0                	call   *%rax
ffff800000108f49:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108f50:	80 ff ff 
ffff800000108f53:	ff d0                	call   *%rax
ffff800000108f55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108f5a:	e9 f7 00 00 00       	jmp    ffff800000109056 <sys_open+0x228>
ffff800000108f5f:	48 b8 72 1c 10 00 00 	movabs $0xffff800000101c72,%rax
ffff800000108f66:	80 ff ff 
ffff800000108f69:	ff d0                	call   *%rax
ffff800000108f6b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff800000108f6f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f74:	74 1c                	je     ffff800000108f92 <sys_open+0x164>
ffff800000108f76:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f7a:	48 89 c7             	mov    %rax,%rdi
ffff800000108f7d:	48 b8 99 83 10 00 00 	movabs $0xffff800000108399,%rax
ffff800000108f84:	80 ff ff 
ffff800000108f87:	ff d0                	call   *%rax
ffff800000108f89:	89 45 ec             	mov    %eax,-0x14(%rbp)
ffff800000108f8c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
ffff800000108f90:	79 43                	jns    ffff800000108fd5 <sys_open+0x1a7>
ffff800000108f92:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff800000108f97:	74 13                	je     ffff800000108fac <sys_open+0x17e>
ffff800000108f99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108f9d:	48 89 c7             	mov    %rax,%rdi
ffff800000108fa0:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff800000108fa7:	80 ff ff 
ffff800000108faa:	ff d0                	call   *%rax
ffff800000108fac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108fb0:	48 89 c7             	mov    %rax,%rdi
ffff800000108fb3:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000108fba:	80 ff ff 
ffff800000108fbd:	ff d0                	call   *%rax
ffff800000108fbf:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108fc6:	80 ff ff 
ffff800000108fc9:	ff d0                	call   *%rax
ffff800000108fcb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000108fd0:	e9 81 00 00 00       	jmp    ffff800000109056 <sys_open+0x228>
ffff800000108fd5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000108fd9:	48 89 c7             	mov    %rax,%rdi
ffff800000108fdc:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff800000108fe3:	80 ff ff 
ffff800000108fe6:	ff d0                	call   *%rax
ffff800000108fe8:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000108fef:	80 ff ff 
ffff800000108ff2:	ff d0                	call   *%rax
ffff800000108ff4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000108ff8:	c7 00 02 00 00 00    	movl   $0x2,(%rax)
ffff800000108ffe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109002:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff800000109006:	48 89 50 18          	mov    %rdx,0x18(%rax)
ffff80000010900a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010900e:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%rax)
ffff800000109015:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109018:	83 e0 01             	and    $0x1,%eax
ffff80000010901b:	83 e0 01             	and    $0x1,%eax
ffff80000010901e:	83 f0 01             	xor    $0x1,%eax
ffff800000109021:	89 c2                	mov    %eax,%edx
ffff800000109023:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109027:	88 50 08             	mov    %dl,0x8(%rax)
ffff80000010902a:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff80000010902d:	83 e0 01             	and    $0x1,%eax
ffff800000109030:	85 c0                	test   %eax,%eax
ffff800000109032:	75 0a                	jne    ffff80000010903e <sys_open+0x210>
ffff800000109034:	8b 45 dc             	mov    -0x24(%rbp),%eax
ffff800000109037:	83 e0 02             	and    $0x2,%eax
ffff80000010903a:	85 c0                	test   %eax,%eax
ffff80000010903c:	74 07                	je     ffff800000109045 <sys_open+0x217>
ffff80000010903e:	b8 01 00 00 00       	mov    $0x1,%eax
ffff800000109043:	eb 05                	jmp    ffff80000010904a <sys_open+0x21c>
ffff800000109045:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010904a:	89 c2                	mov    %eax,%edx
ffff80000010904c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109050:	88 50 09             	mov    %dl,0x9(%rax)
ffff800000109053:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff800000109056:	c9                   	leave
ffff800000109057:	c3                   	ret

ffff800000109058 <sys_mkdir>:
ffff800000109058:	55                   	push   %rbp
ffff800000109059:	48 89 e5             	mov    %rsp,%rbp
ffff80000010905c:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109060:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff800000109067:	80 ff ff 
ffff80000010906a:	ff d0                	call   *%rax
ffff80000010906c:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109070:	48 89 c6             	mov    %rax,%rsi
ffff800000109073:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109078:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff80000010907f:	80 ff ff 
ffff800000109082:	ff d0                	call   *%rax
ffff800000109084:	85 c0                	test   %eax,%eax
ffff800000109086:	78 2d                	js     ffff8000001090b5 <sys_mkdir+0x5d>
ffff800000109088:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010908c:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109091:	ba 00 00 00 00       	mov    $0x0,%edx
ffff800000109096:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010909b:	48 89 c7             	mov    %rax,%rdi
ffff80000010909e:	48 b8 b5 8b 10 00 00 	movabs $0xffff800000108bb5,%rax
ffff8000001090a5:	80 ff ff 
ffff8000001090a8:	ff d0                	call   *%rax
ffff8000001090aa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff8000001090ae:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff8000001090b3:	75 13                	jne    ffff8000001090c8 <sys_mkdir+0x70>
ffff8000001090b5:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001090bc:	80 ff ff 
ffff8000001090bf:	ff d0                	call   *%rax
ffff8000001090c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001090c6:	eb 24                	jmp    ffff8000001090ec <sys_mkdir+0x94>
ffff8000001090c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001090cc:	48 89 c7             	mov    %rax,%rdi
ffff8000001090cf:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff8000001090d6:	80 ff ff 
ffff8000001090d9:	ff d0                	call   *%rax
ffff8000001090db:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001090e2:	80 ff ff 
ffff8000001090e5:	ff d0                	call   *%rax
ffff8000001090e7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001090ec:	c9                   	leave
ffff8000001090ed:	c3                   	ret

ffff8000001090ee <sys_mknod>:
ffff8000001090ee:	55                   	push   %rbp
ffff8000001090ef:	48 89 e5             	mov    %rsp,%rbp
ffff8000001090f2:	48 83 ec 20          	sub    $0x20,%rsp
ffff8000001090f6:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff8000001090fd:	80 ff ff 
ffff800000109100:	ff d0                	call   *%rax
ffff800000109102:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109106:	48 89 c6             	mov    %rax,%rsi
ffff800000109109:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010910e:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff800000109115:	80 ff ff 
ffff800000109118:	ff d0                	call   *%rax
ffff80000010911a:	85 c0                	test   %eax,%eax
ffff80000010911c:	78 67                	js     ffff800000109185 <sys_mknod+0x97>
ffff80000010911e:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
ffff800000109122:	48 89 c6             	mov    %rax,%rsi
ffff800000109125:	bf 01 00 00 00       	mov    $0x1,%edi
ffff80000010912a:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000109131:	80 ff ff 
ffff800000109134:	ff d0                	call   *%rax
ffff800000109136:	85 c0                	test   %eax,%eax
ffff800000109138:	78 4b                	js     ffff800000109185 <sys_mknod+0x97>
ffff80000010913a:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff80000010913e:	48 89 c6             	mov    %rax,%rsi
ffff800000109141:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000109146:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff80000010914d:	80 ff ff 
ffff800000109150:	ff d0                	call   *%rax
ffff800000109152:	85 c0                	test   %eax,%eax
ffff800000109154:	78 2f                	js     ffff800000109185 <sys_mknod+0x97>
ffff800000109156:	8b 45 e8             	mov    -0x18(%rbp),%eax
ffff800000109159:	0f bf c8             	movswl %ax,%ecx
ffff80000010915c:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010915f:	0f bf d0             	movswl %ax,%edx
ffff800000109162:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff800000109166:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010916b:	48 89 c7             	mov    %rax,%rdi
ffff80000010916e:	48 b8 b5 8b 10 00 00 	movabs $0xffff800000108bb5,%rax
ffff800000109175:	80 ff ff 
ffff800000109178:	ff d0                	call   *%rax
ffff80000010917a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010917e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff800000109183:	75 13                	jne    ffff800000109198 <sys_mknod+0xaa>
ffff800000109185:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff80000010918c:	80 ff ff 
ffff80000010918f:	ff d0                	call   *%rax
ffff800000109191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109196:	eb 24                	jmp    ffff8000001091bc <sys_mknod+0xce>
ffff800000109198:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010919c:	48 89 c7             	mov    %rax,%rdi
ffff80000010919f:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff8000001091a6:	80 ff ff 
ffff8000001091a9:	ff d0                	call   *%rax
ffff8000001091ab:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001091b2:	80 ff ff 
ffff8000001091b5:	ff d0                	call   *%rax
ffff8000001091b7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001091bc:	c9                   	leave
ffff8000001091bd:	c3                   	ret

ffff8000001091be <sys_chdir>:
ffff8000001091be:	55                   	push   %rbp
ffff8000001091bf:	48 89 e5             	mov    %rsp,%rbp
ffff8000001091c2:	48 83 ec 10          	sub    $0x10,%rsp
ffff8000001091c6:	48 b8 be 50 10 00 00 	movabs $0xffff8000001050be,%rax
ffff8000001091cd:	80 ff ff 
ffff8000001091d0:	ff d0                	call   *%rax
ffff8000001091d2:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001091d6:	48 89 c6             	mov    %rax,%rsi
ffff8000001091d9:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001091de:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff8000001091e5:	80 ff ff 
ffff8000001091e8:	ff d0                	call   *%rax
ffff8000001091ea:	85 c0                	test   %eax,%eax
ffff8000001091ec:	78 1e                	js     ffff80000010920c <sys_chdir+0x4e>
ffff8000001091ee:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001091f2:	48 89 c7             	mov    %rax,%rdi
ffff8000001091f5:	48 b8 bb 38 10 00 00 	movabs $0xffff8000001038bb,%rax
ffff8000001091fc:	80 ff ff 
ffff8000001091ff:	ff d0                	call   *%rax
ffff800000109201:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff800000109205:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010920a:	75 16                	jne    ffff800000109222 <sys_chdir+0x64>
ffff80000010920c:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000109213:	80 ff ff 
ffff800000109216:	ff d0                	call   *%rax
ffff800000109218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010921d:	e9 a5 00 00 00       	jmp    ffff8000001092c7 <sys_chdir+0x109>
ffff800000109222:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109226:	48 89 c7             	mov    %rax,%rdi
ffff800000109229:	48 b8 b4 29 10 00 00 	movabs $0xffff8000001029b4,%rax
ffff800000109230:	80 ff ff 
ffff800000109233:	ff d0                	call   *%rax
ffff800000109235:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109239:	0f b7 80 94 00 00 00 	movzwl 0x94(%rax),%eax
ffff800000109240:	66 83 f8 01          	cmp    $0x1,%ax
ffff800000109244:	74 26                	je     ffff80000010926c <sys_chdir+0xae>
ffff800000109246:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010924a:	48 89 c7             	mov    %rax,%rdi
ffff80000010924d:	48 b8 b1 2c 10 00 00 	movabs $0xffff800000102cb1,%rax
ffff800000109254:	80 ff ff 
ffff800000109257:	ff d0                	call   *%rax
ffff800000109259:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff800000109260:	80 ff ff 
ffff800000109263:	ff d0                	call   *%rax
ffff800000109265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010926a:	eb 5b                	jmp    ffff8000001092c7 <sys_chdir+0x109>
ffff80000010926c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109270:	48 89 c7             	mov    %rax,%rdi
ffff800000109273:	48 b8 4b 2b 10 00 00 	movabs $0xffff800000102b4b,%rax
ffff80000010927a:	80 ff ff 
ffff80000010927d:	ff d0                	call   *%rax
ffff80000010927f:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109286:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010928a:	48 8b 80 c8 00 00 00 	mov    0xc8(%rax),%rax
ffff800000109291:	48 89 c7             	mov    %rax,%rdi
ffff800000109294:	48 b8 b7 2b 10 00 00 	movabs $0xffff800000102bb7,%rax
ffff80000010929b:	80 ff ff 
ffff80000010929e:	ff d0                	call   *%rax
ffff8000001092a0:	48 b8 a6 51 10 00 00 	movabs $0xffff8000001051a6,%rax
ffff8000001092a7:	80 ff ff 
ffff8000001092aa:	ff d0                	call   *%rax
ffff8000001092ac:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001092b3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001092b7:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff8000001092bb:	48 89 90 c8 00 00 00 	mov    %rdx,0xc8(%rax)
ffff8000001092c2:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001092c7:	c9                   	leave
ffff8000001092c8:	c3                   	ret

ffff8000001092c9 <sys_exec>:
ffff8000001092c9:	55                   	push   %rbp
ffff8000001092ca:	48 89 e5             	mov    %rsp,%rbp
ffff8000001092cd:	48 81 ec 20 01 00 00 	sub    $0x120,%rsp
ffff8000001092d4:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001092d8:	48 89 c6             	mov    %rax,%rsi
ffff8000001092db:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001092e0:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff8000001092e7:	80 ff ff 
ffff8000001092ea:	ff d0                	call   *%rax
ffff8000001092ec:	85 c0                	test   %eax,%eax
ffff8000001092ee:	78 44                	js     ffff800000109334 <sys_exec+0x6b>
ffff8000001092f0:	48 8d 85 e8 fe ff ff 	lea    -0x118(%rbp),%rax
ffff8000001092f7:	48 89 c6             	mov    %rax,%rsi
ffff8000001092fa:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001092ff:	48 b8 5f 80 10 00 00 	movabs $0xffff80000010805f,%rax
ffff800000109306:	80 ff ff 
ffff800000109309:	ff d0                	call   *%rax
ffff80000010930b:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff800000109312:	ba 00 01 00 00       	mov    $0x100,%edx
ffff800000109317:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010931c:	48 89 c7             	mov    %rax,%rdi
ffff80000010931f:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff800000109326:	80 ff ff 
ffff800000109329:	ff d0                	call   *%rax
ffff80000010932b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109332:	eb 0a                	jmp    ffff80000010933e <sys_exec+0x75>
ffff800000109334:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109339:	e9 cb 00 00 00       	jmp    ffff800000109409 <sys_exec+0x140>
ffff80000010933e:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109341:	83 f8 1f             	cmp    $0x1f,%eax
ffff800000109344:	76 0a                	jbe    ffff800000109350 <sys_exec+0x87>
ffff800000109346:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010934b:	e9 b9 00 00 00       	jmp    ffff800000109409 <sys_exec+0x140>
ffff800000109350:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109353:	48 98                	cltq
ffff800000109355:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010935c:	00 
ffff80000010935d:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
ffff800000109364:	48 01 c2             	add    %rax,%rdx
ffff800000109367:	48 8d 85 e0 fe ff ff 	lea    -0x120(%rbp),%rax
ffff80000010936e:	48 89 c6             	mov    %rax,%rsi
ffff800000109371:	48 89 d7             	mov    %rdx,%rdi
ffff800000109374:	48 b8 39 7e 10 00 00 	movabs $0xffff800000107e39,%rax
ffff80000010937b:	80 ff ff 
ffff80000010937e:	ff d0                	call   *%rax
ffff800000109380:	85 c0                	test   %eax,%eax
ffff800000109382:	79 07                	jns    ffff80000010938b <sys_exec+0xc2>
ffff800000109384:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109389:	eb 7e                	jmp    ffff800000109409 <sys_exec+0x140>
ffff80000010938b:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff800000109392:	48 85 c0             	test   %rax,%rax
ffff800000109395:	75 31                	jne    ffff8000001093c8 <sys_exec+0xff>
ffff800000109397:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010939a:	48 98                	cltq
ffff80000010939c:	48 c7 84 c5 f0 fe ff 	movq   $0x0,-0x110(%rbp,%rax,8)
ffff8000001093a3:	ff 00 00 00 00 
ffff8000001093a8:	90                   	nop
ffff8000001093a9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001093ad:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
ffff8000001093b4:	48 89 d6             	mov    %rdx,%rsi
ffff8000001093b7:	48 89 c7             	mov    %rax,%rdi
ffff8000001093ba:	48 b8 6b 16 10 00 00 	movabs $0xffff80000010166b,%rax
ffff8000001093c1:	80 ff ff 
ffff8000001093c4:	ff d0                	call   *%rax
ffff8000001093c6:	eb 41                	jmp    ffff800000109409 <sys_exec+0x140>
ffff8000001093c8:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
ffff8000001093cf:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001093d2:	48 63 d2             	movslq %edx,%rdx
ffff8000001093d5:	48 c1 e2 03          	shl    $0x3,%rdx
ffff8000001093d9:	48 01 c2             	add    %rax,%rdx
ffff8000001093dc:	48 8b 85 e0 fe ff ff 	mov    -0x120(%rbp),%rax
ffff8000001093e3:	48 89 d6             	mov    %rdx,%rsi
ffff8000001093e6:	48 89 c7             	mov    %rax,%rdi
ffff8000001093e9:	48 b8 9e 7e 10 00 00 	movabs $0xffff800000107e9e,%rax
ffff8000001093f0:	80 ff ff 
ffff8000001093f3:	ff d0                	call   *%rax
ffff8000001093f5:	85 c0                	test   %eax,%eax
ffff8000001093f7:	79 07                	jns    ffff800000109400 <sys_exec+0x137>
ffff8000001093f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001093fe:	eb 09                	jmp    ffff800000109409 <sys_exec+0x140>
ffff800000109400:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109404:	e9 35 ff ff ff       	jmp    ffff80000010933e <sys_exec+0x75>
ffff800000109409:	c9                   	leave
ffff80000010940a:	c3                   	ret

ffff80000010940b <sys_pipe>:
ffff80000010940b:	55                   	push   %rbp
ffff80000010940c:	48 89 e5             	mov    %rsp,%rbp
ffff80000010940f:	48 83 ec 20          	sub    $0x20,%rsp
ffff800000109413:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff800000109417:	ba 08 00 00 00       	mov    $0x8,%edx
ffff80000010941c:	48 89 c6             	mov    %rax,%rsi
ffff80000010941f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109424:	48 b8 8d 80 10 00 00 	movabs $0xffff80000010808d,%rax
ffff80000010942b:	80 ff ff 
ffff80000010942e:	ff d0                	call   *%rax
ffff800000109430:	48 8d 55 e0          	lea    -0x20(%rbp),%rdx
ffff800000109434:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff800000109438:	48 89 d6             	mov    %rdx,%rsi
ffff80000010943b:	48 89 c7             	mov    %rax,%rdi
ffff80000010943e:	48 b8 0f 5e 10 00 00 	movabs $0xffff800000105e0f,%rax
ffff800000109445:	80 ff ff 
ffff800000109448:	ff d0                	call   *%rax
ffff80000010944a:	85 c0                	test   %eax,%eax
ffff80000010944c:	79 0a                	jns    ffff800000109458 <sys_pipe+0x4d>
ffff80000010944e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109453:	e9 ab 00 00 00       	jmp    ffff800000109503 <sys_pipe+0xf8>
ffff800000109458:	c7 45 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%rbp)
ffff80000010945f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109463:	48 89 c7             	mov    %rax,%rdi
ffff800000109466:	48 b8 99 83 10 00 00 	movabs $0xffff800000108399,%rax
ffff80000010946d:	80 ff ff 
ffff800000109470:	ff d0                	call   *%rax
ffff800000109472:	89 45 fc             	mov    %eax,-0x4(%rbp)
ffff800000109475:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff800000109479:	78 1c                	js     ffff800000109497 <sys_pipe+0x8c>
ffff80000010947b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010947f:	48 89 c7             	mov    %rax,%rdi
ffff800000109482:	48 b8 99 83 10 00 00 	movabs $0xffff800000108399,%rax
ffff800000109489:	80 ff ff 
ffff80000010948c:	ff d0                	call   *%rax
ffff80000010948e:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff800000109491:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
ffff800000109495:	79 51                	jns    ffff8000001094e8 <sys_pipe+0xdd>
ffff800000109497:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
ffff80000010949b:	78 1e                	js     ffff8000001094bb <sys_pipe+0xb0>
ffff80000010949d:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001094a4:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001094a8:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001094ab:	48 63 d2             	movslq %edx,%rdx
ffff8000001094ae:	48 83 c2 08          	add    $0x8,%rdx
ffff8000001094b2:	48 c7 44 d0 08 00 00 	movq   $0x0,0x8(%rax,%rdx,8)
ffff8000001094b9:	00 00 
ffff8000001094bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff8000001094bf:	48 89 c7             	mov    %rax,%rdi
ffff8000001094c2:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff8000001094c9:	80 ff ff 
ffff8000001094cc:	ff d0                	call   *%rax
ffff8000001094ce:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff8000001094d2:	48 89 c7             	mov    %rax,%rdi
ffff8000001094d5:	48 b8 86 1d 10 00 00 	movabs $0xffff800000101d86,%rax
ffff8000001094dc:	80 ff ff 
ffff8000001094df:	ff d0                	call   *%rax
ffff8000001094e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001094e6:	eb 1b                	jmp    ffff800000109503 <sys_pipe+0xf8>
ffff8000001094e8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001094ec:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff8000001094ef:	89 10                	mov    %edx,(%rax)
ffff8000001094f1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001094f5:	48 8d 50 04          	lea    0x4(%rax),%rdx
ffff8000001094f9:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff8000001094fc:	89 02                	mov    %eax,(%rdx)
ffff8000001094fe:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109503:	c9                   	leave
ffff800000109504:	c3                   	ret

ffff800000109505 <sys_fork>:
#include "proc.h"
#include "trace.h"

int
sys_fork(void)
{
ffff800000109505:	55                   	push   %rbp
ffff800000109506:	48 89 e5             	mov    %rsp,%rbp
  return fork();
ffff800000109509:	48 b8 21 67 10 00 00 	movabs $0xffff800000106721,%rax
ffff800000109510:	80 ff ff 
ffff800000109513:	ff d0                	call   *%rax
}
ffff800000109515:	5d                   	pop    %rbp
ffff800000109516:	c3                   	ret

ffff800000109517 <sys_exit>:

int
sys_exit(void)
{
ffff800000109517:	55                   	push   %rbp
ffff800000109518:	48 89 e5             	mov    %rsp,%rbp
  exit();
ffff80000010951b:	48 b8 15 6a 10 00 00 	movabs $0xffff800000106a15,%rax
ffff800000109522:	80 ff ff 
ffff800000109525:	ff d0                	call   *%rax
  return 0;  // not reached
ffff800000109527:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010952c:	5d                   	pop    %rbp
ffff80000010952d:	c3                   	ret

ffff80000010952e <sys_wait>:

int
sys_wait(void)
{
ffff80000010952e:	55                   	push   %rbp
ffff80000010952f:	48 89 e5             	mov    %rsp,%rbp
  return wait();
ffff800000109532:	48 b8 44 6c 10 00 00 	movabs $0xffff800000106c44,%rax
ffff800000109539:	80 ff ff 
ffff80000010953c:	ff d0                	call   *%rax
}
ffff80000010953e:	5d                   	pop    %rbp
ffff80000010953f:	c3                   	ret

ffff800000109540 <sys_kill>:

int
sys_kill(void)
{
ffff800000109540:	55                   	push   %rbp
ffff800000109541:	48 89 e5             	mov    %rsp,%rbp
ffff800000109544:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  if(argint(0, &pid) < 0)
ffff800000109548:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010954c:	48 89 c6             	mov    %rax,%rsi
ffff80000010954f:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109554:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff80000010955b:	80 ff ff 
ffff80000010955e:	ff d0                	call   *%rax
ffff800000109560:	85 c0                	test   %eax,%eax
ffff800000109562:	79 07                	jns    ffff80000010956b <sys_kill+0x2b>
    return -1;
ffff800000109564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109569:	eb 11                	jmp    ffff80000010957c <sys_kill+0x3c>
  return kill(pid);
ffff80000010956b:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010956e:	89 c7                	mov    %eax,%edi
ffff800000109570:	48 b8 a1 72 10 00 00 	movabs $0xffff8000001072a1,%rax
ffff800000109577:	80 ff ff 
ffff80000010957a:	ff d0                	call   *%rax
}
ffff80000010957c:	c9                   	leave
ffff80000010957d:	c3                   	ret

ffff80000010957e <sys_getpid>:

int
sys_getpid(void)
{
ffff80000010957e:	55                   	push   %rbp
ffff80000010957f:	48 89 e5             	mov    %rsp,%rbp
  return proc->pid;
ffff800000109582:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109589:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010958d:	8b 40 1c             	mov    0x1c(%rax),%eax
}
ffff800000109590:	5d                   	pop    %rbp
ffff800000109591:	c3                   	ret

ffff800000109592 <sys_sbrk>:

addr_t
sys_sbrk(void)
{
ffff800000109592:	55                   	push   %rbp
ffff800000109593:	48 89 e5             	mov    %rsp,%rbp
ffff800000109596:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t addr;
  addr_t n;

  argaddr(0, &n);
ffff80000010959a:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff80000010959e:	48 89 c6             	mov    %rax,%rsi
ffff8000001095a1:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001095a6:	48 b8 5f 80 10 00 00 	movabs $0xffff80000010805f,%rax
ffff8000001095ad:	80 ff ff 
ffff8000001095b0:	ff d0                	call   *%rax
  addr = proc->sz;
ffff8000001095b2:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff8000001095b9:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff8000001095bd:	48 8b 00             	mov    (%rax),%rax
ffff8000001095c0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(growproc(n) < 0)
ffff8000001095c4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff8000001095c8:	48 89 c7             	mov    %rax,%rdi
ffff8000001095cb:	48 b8 3e 66 10 00 00 	movabs $0xffff80000010663e,%rax
ffff8000001095d2:	80 ff ff 
ffff8000001095d5:	ff d0                	call   *%rax
ffff8000001095d7:	85 c0                	test   %eax,%eax
ffff8000001095d9:	79 09                	jns    ffff8000001095e4 <sys_sbrk+0x52>
    return -1;
ffff8000001095db:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
ffff8000001095e2:	eb 04                	jmp    ffff8000001095e8 <sys_sbrk+0x56>
  return addr;
ffff8000001095e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001095e8:	c9                   	leave
ffff8000001095e9:	c3                   	ret

ffff8000001095ea <sys_sleep>:

int
sys_sleep(void)
{
ffff8000001095ea:	55                   	push   %rbp
ffff8000001095eb:	48 89 e5             	mov    %rsp,%rbp
ffff8000001095ee:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
ffff8000001095f2:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001095f6:	48 89 c6             	mov    %rax,%rsi
ffff8000001095f9:	bf 00 00 00 00       	mov    $0x0,%edi
ffff8000001095fe:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000109605:	80 ff ff 
ffff800000109608:	ff d0                	call   *%rax
ffff80000010960a:	85 c0                	test   %eax,%eax
ffff80000010960c:	79 0a                	jns    ffff800000109618 <sys_sleep+0x2e>
    return -1;
ffff80000010960e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109613:	e9 b6 00 00 00       	jmp    ffff8000001096ce <sys_sleep+0xe4>
  acquire(&tickslock);
ffff800000109618:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff80000010961f:	80 ff ff 
ffff800000109622:	48 89 c7             	mov    %rax,%rdi
ffff800000109625:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff80000010962c:	80 ff ff 
ffff80000010962f:	ff d0                	call   *%rax
  ticks0 = ticks;
ffff800000109631:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109638:	80 ff ff 
ffff80000010963b:	8b 00                	mov    (%rax),%eax
ffff80000010963d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while(ticks - ticks0 < n){
ffff800000109640:	eb 58                	jmp    ffff80000010969a <sys_sleep+0xb0>
    if(proc->killed){
ffff800000109642:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109649:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010964d:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109650:	85 c0                	test   %eax,%eax
ffff800000109652:	74 20                	je     ffff800000109674 <sys_sleep+0x8a>
      release(&tickslock);
ffff800000109654:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff80000010965b:	80 ff ff 
ffff80000010965e:	48 89 c7             	mov    %rax,%rdi
ffff800000109661:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000109668:	80 ff ff 
ffff80000010966b:	ff d0                	call   *%rax
      return -1;
ffff80000010966d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109672:	eb 5a                	jmp    ffff8000001096ce <sys_sleep+0xe4>
    }
    sleep(&ticks, &tickslock);
ffff800000109674:	48 ba e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rdx
ffff80000010967b:	80 ff ff 
ffff80000010967e:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109685:	80 ff ff 
ffff800000109688:	48 89 d6             	mov    %rdx,%rsi
ffff80000010968b:	48 89 c7             	mov    %rax,%rdi
ffff80000010968e:	48 b8 d8 70 10 00 00 	movabs $0xffff8000001070d8,%rax
ffff800000109695:	80 ff ff 
ffff800000109698:	ff d0                	call   *%rax
  while(ticks - ticks0 < n){
ffff80000010969a:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff8000001096a1:	80 ff ff 
ffff8000001096a4:	8b 00                	mov    (%rax),%eax
ffff8000001096a6:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff8000001096a9:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff8000001096ac:	39 d0                	cmp    %edx,%eax
ffff8000001096ae:	72 92                	jb     ffff800000109642 <sys_sleep+0x58>
  }
  release(&tickslock);
ffff8000001096b0:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff8000001096b7:	80 ff ff 
ffff8000001096ba:	48 89 c7             	mov    %rax,%rdi
ffff8000001096bd:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff8000001096c4:	80 ff ff 
ffff8000001096c7:	ff d0                	call   *%rax
  return 0;
ffff8000001096c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff8000001096ce:	c9                   	leave
ffff8000001096cf:	c3                   	ret

ffff8000001096d0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
ffff8000001096d0:	55                   	push   %rbp
ffff8000001096d1:	48 89 e5             	mov    %rsp,%rbp
ffff8000001096d4:	48 83 ec 10          	sub    $0x10,%rsp
  uint xticks;

  acquire(&tickslock);
ffff8000001096d8:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff8000001096df:	80 ff ff 
ffff8000001096e2:	48 89 c7             	mov    %rax,%rdi
ffff8000001096e5:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff8000001096ec:	80 ff ff 
ffff8000001096ef:	ff d0                	call   *%rax
  xticks = ticks;
ffff8000001096f1:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff8000001096f8:	80 ff ff 
ffff8000001096fb:	8b 00                	mov    (%rax),%eax
ffff8000001096fd:	89 45 fc             	mov    %eax,-0x4(%rbp)
  release(&tickslock);
ffff800000109700:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109707:	80 ff ff 
ffff80000010970a:	48 89 c7             	mov    %rax,%rdi
ffff80000010970d:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000109714:	80 ff ff 
ffff800000109717:	ff d0                	call   *%rax
  return xticks;
ffff800000109719:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
ffff80000010971c:	c9                   	leave
ffff80000010971d:	c3                   	ret

ffff80000010971e <sys_traceread>:


int
sys_traceread(void){
ffff80000010971e:	55                   	push   %rbp
ffff80000010971f:	48 89 e5             	mov    %rsp,%rbp
ffff800000109722:	48 83 ec 10          	sub    $0x10,%rsp
  struct trace_event *event;

  // Get the first argument to grab the first event
  if(argptr(0, (char**)&event, sizeof(*event)) < 0)
ffff800000109726:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff80000010972a:	ba 40 00 00 00       	mov    $0x40,%edx
ffff80000010972f:	48 89 c6             	mov    %rax,%rsi
ffff800000109732:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109737:	48 b8 8d 80 10 00 00 	movabs $0xffff80000010808d,%rax
ffff80000010973e:	80 ff ff 
ffff800000109741:	ff d0                	call   *%rax
    return -1;

  return traceread(event);
ffff800000109743:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109747:	48 89 c7             	mov    %rax,%rdi
ffff80000010974a:	48 b8 2c c4 10 00 00 	movabs $0xffff80000010c42c,%rax
ffff800000109751:	80 ff ff 
ffff800000109754:	ff d0                	call   *%rax
}
ffff800000109756:	c9                   	leave
ffff800000109757:	c3                   	ret

ffff800000109758 <sys_vidclear>:


int sys_vidclear(void){
ffff800000109758:	55                   	push   %rbp
ffff800000109759:	48 89 e5             	mov    %rsp,%rbp
  vidclear();
ffff80000010975c:	48 b8 d7 0e 10 00 00 	movabs $0xffff800000100ed7,%rax
ffff800000109763:	80 ff ff 
ffff800000109766:	ff d0                	call   *%rax
  return 0;
ffff800000109768:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff80000010976d:	5d                   	pop    %rbp
ffff80000010976e:	c3                   	ret

ffff80000010976f <sys_vidputc>:

int
sys_vidputc(void){
ffff80000010976f:	55                   	push   %rbp
ffff800000109770:	48 89 e5             	mov    %rsp,%rbp
ffff800000109773:	48 83 ec 10          	sub    $0x10,%rsp
  int row, col, ch, color;

  if(argint(0, &row) < 0)
ffff800000109777:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff80000010977b:	48 89 c6             	mov    %rax,%rsi
ffff80000010977e:	bf 00 00 00 00       	mov    $0x0,%edi
ffff800000109783:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff80000010978a:	80 ff ff 
ffff80000010978d:	ff d0                	call   *%rax
ffff80000010978f:	85 c0                	test   %eax,%eax
ffff800000109791:	79 0a                	jns    ffff80000010979d <sys_vidputc+0x2e>
    return -1;
ffff800000109793:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109798:	e9 88 00 00 00       	jmp    ffff800000109825 <sys_vidputc+0xb6>
  if(argint(1, &col) < 0)
ffff80000010979d:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff8000001097a1:	48 89 c6             	mov    %rax,%rsi
ffff8000001097a4:	bf 01 00 00 00       	mov    $0x1,%edi
ffff8000001097a9:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff8000001097b0:	80 ff ff 
ffff8000001097b3:	ff d0                	call   *%rax
ffff8000001097b5:	85 c0                	test   %eax,%eax
ffff8000001097b7:	79 07                	jns    ffff8000001097c0 <sys_vidputc+0x51>
    return -1;
ffff8000001097b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001097be:	eb 65                	jmp    ffff800000109825 <sys_vidputc+0xb6>
  if(argint(2, &ch) < 0)
ffff8000001097c0:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff8000001097c4:	48 89 c6             	mov    %rax,%rsi
ffff8000001097c7:	bf 02 00 00 00       	mov    $0x2,%edi
ffff8000001097cc:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff8000001097d3:	80 ff ff 
ffff8000001097d6:	ff d0                	call   *%rax
ffff8000001097d8:	85 c0                	test   %eax,%eax
ffff8000001097da:	79 07                	jns    ffff8000001097e3 <sys_vidputc+0x74>
    return -1;
ffff8000001097dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001097e1:	eb 42                	jmp    ffff800000109825 <sys_vidputc+0xb6>
  if(argint(3, &color) < 0)
ffff8000001097e3:	48 8d 45 f0          	lea    -0x10(%rbp),%rax
ffff8000001097e7:	48 89 c6             	mov    %rax,%rsi
ffff8000001097ea:	bf 03 00 00 00       	mov    $0x3,%edi
ffff8000001097ef:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff8000001097f6:	80 ff ff 
ffff8000001097f9:	ff d0                	call   *%rax
ffff8000001097fb:	85 c0                	test   %eax,%eax
ffff8000001097fd:	79 07                	jns    ffff800000109806 <sys_vidputc+0x97>
    return -1;
ffff8000001097ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109804:	eb 1f                	jmp    ffff800000109825 <sys_vidputc+0xb6>

  vidputc(row, col, ch, color);
ffff800000109806:	8b 4d f0             	mov    -0x10(%rbp),%ecx
ffff800000109809:	8b 55 f4             	mov    -0xc(%rbp),%edx
ffff80000010980c:	8b 75 f8             	mov    -0x8(%rbp),%esi
ffff80000010980f:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109812:	89 c7                	mov    %eax,%edi
ffff800000109814:	48 b8 17 0f 10 00 00 	movabs $0xffff800000100f17,%rax
ffff80000010981b:	80 ff ff 
ffff80000010981e:	ff d0                	call   *%rax
  return 0;
ffff800000109820:	b8 00 00 00 00       	mov    $0x0,%eax
}
ffff800000109825:	c9                   	leave
ffff800000109826:	c3                   	ret

ffff800000109827 <sys_vidputs>:

int sys_vidputs(void){
ffff800000109827:	55                   	push   %rbp
ffff800000109828:	48 89 e5             	mov    %rsp,%rbp
ffff80000010982b:	48 83 ec 20          	sub    $0x20,%rsp
  int row, col, color;
  char *s;

  if(argint(0, &row) < 0)
ffff80000010982f:	48 8d 45 fc          	lea    -0x4(%rbp),%rax
ffff800000109833:	48 89 c6             	mov    %rax,%rsi
ffff800000109836:	bf 00 00 00 00       	mov    $0x0,%edi
ffff80000010983b:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000109842:	80 ff ff 
ffff800000109845:	ff d0                	call   *%rax
ffff800000109847:	85 c0                	test   %eax,%eax
ffff800000109849:	79 0a                	jns    ffff800000109855 <sys_vidputs+0x2e>
    return -1;
ffff80000010984b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109850:	e9 89 00 00 00       	jmp    ffff8000001098de <sys_vidputs+0xb7>
  if(argint(1, &col) < 0)
ffff800000109855:	48 8d 45 f8          	lea    -0x8(%rbp),%rax
ffff800000109859:	48 89 c6             	mov    %rax,%rsi
ffff80000010985c:	bf 01 00 00 00       	mov    $0x1,%edi
ffff800000109861:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff800000109868:	80 ff ff 
ffff80000010986b:	ff d0                	call   *%rax
ffff80000010986d:	85 c0                	test   %eax,%eax
ffff80000010986f:	79 07                	jns    ffff800000109878 <sys_vidputs+0x51>
    return -1;
ffff800000109871:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109876:	eb 66                	jmp    ffff8000001098de <sys_vidputs+0xb7>
  if(argstr(2, &s) < 0)
ffff800000109878:	48 8d 45 e8          	lea    -0x18(%rbp),%rax
ffff80000010987c:	48 89 c6             	mov    %rax,%rsi
ffff80000010987f:	bf 02 00 00 00       	mov    $0x2,%edi
ffff800000109884:	48 b8 14 81 10 00 00 	movabs $0xffff800000108114,%rax
ffff80000010988b:	80 ff ff 
ffff80000010988e:	ff d0                	call   *%rax
ffff800000109890:	85 c0                	test   %eax,%eax
ffff800000109892:	79 07                	jns    ffff80000010989b <sys_vidputs+0x74>
    return -1;
ffff800000109894:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff800000109899:	eb 43                	jmp    ffff8000001098de <sys_vidputs+0xb7>
  if(argint(3, &color) < 0)
ffff80000010989b:	48 8d 45 f4          	lea    -0xc(%rbp),%rax
ffff80000010989f:	48 89 c6             	mov    %rax,%rsi
ffff8000001098a2:	bf 03 00 00 00       	mov    $0x3,%edi
ffff8000001098a7:	48 b8 30 80 10 00 00 	movabs $0xffff800000108030,%rax
ffff8000001098ae:	80 ff ff 
ffff8000001098b1:	ff d0                	call   *%rax
ffff8000001098b3:	85 c0                	test   %eax,%eax
ffff8000001098b5:	79 07                	jns    ffff8000001098be <sys_vidputs+0x97>
    return -1;
ffff8000001098b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff8000001098bc:	eb 20                	jmp    ffff8000001098de <sys_vidputs+0xb7>

  vidputs(row, col, s, color);
ffff8000001098be:	8b 4d f4             	mov    -0xc(%rbp),%ecx
ffff8000001098c1:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff8000001098c5:	8b 75 f8             	mov    -0x8(%rbp),%esi
ffff8000001098c8:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff8000001098cb:	89 c7                	mov    %eax,%edi
ffff8000001098cd:	48 b8 89 0f 10 00 00 	movabs $0xffff800000100f89,%rax
ffff8000001098d4:	80 ff ff 
ffff8000001098d7:	ff d0                	call   *%rax
  return 0;
ffff8000001098d9:	b8 00 00 00 00       	mov    $0x0,%eax
ffff8000001098de:	c9                   	leave
ffff8000001098df:	c3                   	ret

ffff8000001098e0 <alltraps>:
ffff8000001098e0:	41 57                	push   %r15
ffff8000001098e2:	41 56                	push   %r14
ffff8000001098e4:	41 55                	push   %r13
ffff8000001098e6:	41 54                	push   %r12
ffff8000001098e8:	41 53                	push   %r11
ffff8000001098ea:	41 52                	push   %r10
ffff8000001098ec:	41 51                	push   %r9
ffff8000001098ee:	41 50                	push   %r8
ffff8000001098f0:	57                   	push   %rdi
ffff8000001098f1:	56                   	push   %rsi
ffff8000001098f2:	55                   	push   %rbp
ffff8000001098f3:	52                   	push   %rdx
ffff8000001098f4:	51                   	push   %rcx
ffff8000001098f5:	53                   	push   %rbx
ffff8000001098f6:	50                   	push   %rax
ffff8000001098f7:	48 89 e7             	mov    %rsp,%rdi
ffff8000001098fa:	e8 7b 02 00 00       	call   ffff800000109b7a <trap>

ffff8000001098ff <trapret>:
ffff8000001098ff:	58                   	pop    %rax
ffff800000109900:	5b                   	pop    %rbx
ffff800000109901:	59                   	pop    %rcx
ffff800000109902:	5a                   	pop    %rdx
ffff800000109903:	5d                   	pop    %rbp
ffff800000109904:	5e                   	pop    %rsi
ffff800000109905:	5f                   	pop    %rdi
ffff800000109906:	41 58                	pop    %r8
ffff800000109908:	41 59                	pop    %r9
ffff80000010990a:	41 5a                	pop    %r10
ffff80000010990c:	41 5b                	pop    %r11
ffff80000010990e:	41 5c                	pop    %r12
ffff800000109910:	41 5d                	pop    %r13
ffff800000109912:	41 5e                	pop    %r14
ffff800000109914:	41 5f                	pop    %r15
ffff800000109916:	48 83 c4 10          	add    $0x10,%rsp
ffff80000010991a:	48 cf                	iretq

ffff80000010991c <syscall_entry>:
ffff80000010991c:	64 48 89 04 25 00 00 	mov    %rax,%fs:0x0
ffff800000109923:	00 00 
ffff800000109925:	64 48 8b 04 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rax
ffff80000010992c:	ff ff 
ffff80000010992e:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff800000109932:	48 05 f0 0f 00 00    	add    $0xff0,%rax
ffff800000109938:	48 89 20             	mov    %rsp,(%rax)
ffff80000010993b:	48 89 c4             	mov    %rax,%rsp
ffff80000010993e:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
ffff800000109945:	00 00 
ffff800000109947:	41 53                	push   %r11
ffff800000109949:	6a 00                	push   $0x0
ffff80000010994b:	51                   	push   %rcx
ffff80000010994c:	6a 00                	push   $0x0
ffff80000010994e:	6a 00                	push   $0x0
ffff800000109950:	41 57                	push   %r15
ffff800000109952:	41 56                	push   %r14
ffff800000109954:	41 55                	push   %r13
ffff800000109956:	41 54                	push   %r12
ffff800000109958:	41 53                	push   %r11
ffff80000010995a:	41 52                	push   %r10
ffff80000010995c:	41 51                	push   %r9
ffff80000010995e:	41 50                	push   %r8
ffff800000109960:	57                   	push   %rdi
ffff800000109961:	56                   	push   %rsi
ffff800000109962:	55                   	push   %rbp
ffff800000109963:	52                   	push   %rdx
ffff800000109964:	51                   	push   %rcx
ffff800000109965:	53                   	push   %rbx
ffff800000109966:	50                   	push   %rax
ffff800000109967:	48 89 e7             	mov    %rsp,%rdi
ffff80000010996a:	e8 f4 e7 ff ff       	call   ffff800000108163 <syscall>

ffff80000010996f <syscall_trapret>:
ffff80000010996f:	58                   	pop    %rax
ffff800000109970:	5b                   	pop    %rbx
ffff800000109971:	59                   	pop    %rcx
ffff800000109972:	5a                   	pop    %rdx
ffff800000109973:	5d                   	pop    %rbp
ffff800000109974:	5e                   	pop    %rsi
ffff800000109975:	5f                   	pop    %rdi
ffff800000109976:	41 58                	pop    %r8
ffff800000109978:	41 59                	pop    %r9
ffff80000010997a:	41 5a                	pop    %r10
ffff80000010997c:	41 5b                	pop    %r11
ffff80000010997e:	41 5c                	pop    %r12
ffff800000109980:	41 5d                	pop    %r13
ffff800000109982:	41 5e                	pop    %r14
ffff800000109984:	41 5f                	pop    %r15
ffff800000109986:	48 83 c4 28          	add    $0x28,%rsp
ffff80000010998a:	fa                   	cli
ffff80000010998b:	48 8b 24 24          	mov    (%rsp),%rsp
ffff80000010998f:	48 0f 07             	sysretq

ffff800000109992 <lidt>:
{
ffff800000109992:	55                   	push   %rbp
ffff800000109993:	48 89 e5             	mov    %rsp,%rbp
ffff800000109996:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010999a:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010999e:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  addr_t addr = (addr_t)p;
ffff8000001099a1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff8000001099a5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  pd[0] = size-1;
ffff8000001099a9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff8000001099ac:	83 e8 01             	sub    $0x1,%eax
ffff8000001099af:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
  pd[1] = addr;
ffff8000001099b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099b7:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
  pd[2] = addr >> 16;
ffff8000001099bb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099bf:	48 c1 e8 10          	shr    $0x10,%rax
ffff8000001099c3:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
  pd[3] = addr >> 32;
ffff8000001099c7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099cb:	48 c1 e8 20          	shr    $0x20,%rax
ffff8000001099cf:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
  pd[4] = addr >> 48;
ffff8000001099d3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff8000001099d7:	48 c1 e8 30          	shr    $0x30,%rax
ffff8000001099db:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
  asm volatile("lidt (%0)" : : "r" (pd));
ffff8000001099df:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff8000001099e3:	0f 01 18             	lidt   (%rax)
}
ffff8000001099e6:	90                   	nop
ffff8000001099e7:	c9                   	leave
ffff8000001099e8:	c3                   	ret

ffff8000001099e9 <rcr2>:
  return result;
}

static inline addr_t
rcr2(void)
{
ffff8000001099e9:	55                   	push   %rbp
ffff8000001099ea:	48 89 e5             	mov    %rsp,%rbp
ffff8000001099ed:	48 83 ec 10          	sub    $0x10,%rsp
  addr_t val;
  asm volatile("mov %%cr2,%0" : "=r" (val));
ffff8000001099f1:	0f 20 d0             	mov    %cr2,%rax
ffff8000001099f4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  return val;
ffff8000001099f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
ffff8000001099fc:	c9                   	leave
ffff8000001099fd:	c3                   	ret

ffff8000001099fe <mkgate>:
struct spinlock tickslock;
uint ticks;

static void
mkgate(uint *idt, uint n, addr_t kva, uint pl)
{
ffff8000001099fe:	55                   	push   %rbp
ffff8000001099ff:	48 89 e5             	mov    %rsp,%rbp
ffff800000109a02:	48 83 ec 28          	sub    $0x28,%rsp
ffff800000109a06:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff800000109a0a:	89 75 e4             	mov    %esi,-0x1c(%rbp)
ffff800000109a0d:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff800000109a11:	89 4d e0             	mov    %ecx,-0x20(%rbp)
  uint64 addr = (uint64) kva;
ffff800000109a14:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff800000109a18:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  n *= 4;
ffff800000109a1c:	c1 65 e4 02          	shll   $0x2,-0x1c(%rbp)
  idt[n+0] = (addr & 0xFFFF) | (KERNEL_CS << 16);
ffff800000109a20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109a24:	0f b7 d0             	movzwl %ax,%edx
ffff800000109a27:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a2a:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff800000109a31:	00 
ffff800000109a32:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a36:	48 01 c8             	add    %rcx,%rax
ffff800000109a39:	81 ca 00 00 08 00    	or     $0x80000,%edx
ffff800000109a3f:	89 10                	mov    %edx,(%rax)
  idt[n+1] = (addr & 0xFFFF0000) | 0x8E00 | ((pl & 3) << 13);
ffff800000109a41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109a45:	66 b8 00 00          	mov    $0x0,%ax
ffff800000109a49:	89 c2                	mov    %eax,%edx
ffff800000109a4b:	8b 45 e0             	mov    -0x20(%rbp),%eax
ffff800000109a4e:	c1 e0 0d             	shl    $0xd,%eax
ffff800000109a51:	25 00 60 00 00       	and    $0x6000,%eax
ffff800000109a56:	09 c2                	or     %eax,%edx
ffff800000109a58:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a5b:	83 c0 01             	add    $0x1,%eax
ffff800000109a5e:	89 c0                	mov    %eax,%eax
ffff800000109a60:	48 8d 0c 85 00 00 00 	lea    0x0(,%rax,4),%rcx
ffff800000109a67:	00 
ffff800000109a68:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a6c:	48 01 c8             	add    %rcx,%rax
ffff800000109a6f:	80 ce 8e             	or     $0x8e,%dh
ffff800000109a72:	89 10                	mov    %edx,(%rax)
  idt[n+2] = addr >> 32;
ffff800000109a74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff800000109a78:	48 c1 e8 20          	shr    $0x20,%rax
ffff800000109a7c:	48 89 c1             	mov    %rax,%rcx
ffff800000109a7f:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a82:	83 c0 02             	add    $0x2,%eax
ffff800000109a85:	89 c0                	mov    %eax,%eax
ffff800000109a87:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109a8e:	00 
ffff800000109a8f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109a93:	48 01 d0             	add    %rdx,%rax
ffff800000109a96:	89 ca                	mov    %ecx,%edx
ffff800000109a98:	89 10                	mov    %edx,(%rax)
  idt[n+3] = 0;
ffff800000109a9a:	8b 45 e4             	mov    -0x1c(%rbp),%eax
ffff800000109a9d:	83 c0 03             	add    $0x3,%eax
ffff800000109aa0:	89 c0                	mov    %eax,%eax
ffff800000109aa2:	48 8d 14 85 00 00 00 	lea    0x0(,%rax,4),%rdx
ffff800000109aa9:	00 
ffff800000109aaa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109aae:	48 01 d0             	add    %rdx,%rax
ffff800000109ab1:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
}
ffff800000109ab7:	90                   	nop
ffff800000109ab8:	c9                   	leave
ffff800000109ab9:	c3                   	ret

ffff800000109aba <idtinit>:

void idtinit(void)
{
ffff800000109aba:	55                   	push   %rbp
ffff800000109abb:	48 89 e5             	mov    %rsp,%rbp
  lidt((void*) idt, PGSIZE);
ffff800000109abe:	48 b8 c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rax
ffff800000109ac5:	80 ff ff 
ffff800000109ac8:	48 8b 00             	mov    (%rax),%rax
ffff800000109acb:	be 00 10 00 00       	mov    $0x1000,%esi
ffff800000109ad0:	48 89 c7             	mov    %rax,%rdi
ffff800000109ad3:	48 b8 92 99 10 00 00 	movabs $0xffff800000109992,%rax
ffff800000109ada:	80 ff ff 
ffff800000109add:	ff d0                	call   *%rax
}
ffff800000109adf:	90                   	nop
ffff800000109ae0:	5d                   	pop    %rbp
ffff800000109ae1:	c3                   	ret

ffff800000109ae2 <tvinit>:

void tvinit(void)
{
ffff800000109ae2:	55                   	push   %rbp
ffff800000109ae3:	48 89 e5             	mov    %rsp,%rbp
ffff800000109ae6:	48 83 ec 10          	sub    $0x10,%rsp
  int n;
  idt = (uint*) kalloc();
ffff800000109aea:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff800000109af1:	80 ff ff 
ffff800000109af4:	ff d0                	call   *%rax
ffff800000109af6:	48 ba c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rdx
ffff800000109afd:	80 ff ff 
ffff800000109b00:	48 89 02             	mov    %rax,(%rdx)
  memset(idt, 0, PGSIZE);
ffff800000109b03:	48 b8 c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rax
ffff800000109b0a:	80 ff ff 
ffff800000109b0d:	48 8b 00             	mov    (%rax),%rax
ffff800000109b10:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff800000109b15:	be 00 00 00 00       	mov    $0x0,%esi
ffff800000109b1a:	48 89 c7             	mov    %rax,%rdi
ffff800000109b1d:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff800000109b24:	80 ff ff 
ffff800000109b27:	ff d0                	call   *%rax

  for (n = 0; n < 256; n++)
ffff800000109b29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff800000109b30:	eb 3b                	jmp    ffff800000109b6d <tvinit+0x8b>
    mkgate(idt, n, vectors[n], 0);
ffff800000109b32:	48 ba 50 d7 10 00 00 	movabs $0xffff80000010d750,%rdx
ffff800000109b39:	80 ff ff 
ffff800000109b3c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff800000109b3f:	48 98                	cltq
ffff800000109b41:	48 8b 14 c2          	mov    (%rdx,%rax,8),%rdx
ffff800000109b45:	8b 75 fc             	mov    -0x4(%rbp),%esi
ffff800000109b48:	48 b8 c0 bc 11 00 00 	movabs $0xffff80000011bcc0,%rax
ffff800000109b4f:	80 ff ff 
ffff800000109b52:	48 8b 00             	mov    (%rax),%rax
ffff800000109b55:	b9 00 00 00 00       	mov    $0x0,%ecx
ffff800000109b5a:	48 89 c7             	mov    %rax,%rdi
ffff800000109b5d:	48 b8 fe 99 10 00 00 	movabs $0xffff8000001099fe,%rax
ffff800000109b64:	80 ff ff 
ffff800000109b67:	ff d0                	call   *%rax
  for (n = 0; n < 256; n++)
ffff800000109b69:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff800000109b6d:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff800000109b74:	7e bc                	jle    ffff800000109b32 <tvinit+0x50>
}
ffff800000109b76:	90                   	nop
ffff800000109b77:	90                   	nop
ffff800000109b78:	c9                   	leave
ffff800000109b79:	c3                   	ret

ffff800000109b7a <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
ffff800000109b7a:	55                   	push   %rbp
ffff800000109b7b:	48 89 e5             	mov    %rsp,%rbp
ffff800000109b7e:	41 54                	push   %r12
ffff800000109b80:	53                   	push   %rbx
ffff800000109b81:	48 83 ec 10          	sub    $0x10,%rsp
ffff800000109b85:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  switch(tf->trapno){
ffff800000109b89:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109b8d:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109b91:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109b95:	0f 84 4d 01 00 00    	je     ffff800000109ce8 <trap+0x16e>
ffff800000109b9b:	48 83 f8 3f          	cmp    $0x3f,%rax
ffff800000109b9f:	0f 87 9d 01 00 00    	ja     ffff800000109d42 <trap+0x1c8>
ffff800000109ba5:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109ba9:	0f 84 58 03 00 00    	je     ffff800000109f07 <trap+0x38d>
ffff800000109baf:	48 83 f8 2f          	cmp    $0x2f,%rax
ffff800000109bb3:	0f 87 89 01 00 00    	ja     ffff800000109d42 <trap+0x1c8>
ffff800000109bb9:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109bbd:	0f 84 ce 00 00 00    	je     ffff800000109c91 <trap+0x117>
ffff800000109bc3:	48 83 f8 2e          	cmp    $0x2e,%rax
ffff800000109bc7:	0f 87 75 01 00 00    	ja     ffff800000109d42 <trap+0x1c8>
ffff800000109bcd:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109bd1:	0f 84 11 01 00 00    	je     ffff800000109ce8 <trap+0x16e>
ffff800000109bd7:	48 83 f8 27          	cmp    $0x27,%rax
ffff800000109bdb:	0f 87 61 01 00 00    	ja     ffff800000109d42 <trap+0x1c8>
ffff800000109be1:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109be5:	0f 84 e0 00 00 00    	je     ffff800000109ccb <trap+0x151>
ffff800000109beb:	48 83 f8 24          	cmp    $0x24,%rax
ffff800000109bef:	0f 87 4d 01 00 00    	ja     ffff800000109d42 <trap+0x1c8>
ffff800000109bf5:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109bf9:	74 0f                	je     ffff800000109c0a <trap+0x90>
ffff800000109bfb:	48 83 f8 21          	cmp    $0x21,%rax
ffff800000109bff:	0f 84 a9 00 00 00    	je     ffff800000109cae <trap+0x134>
ffff800000109c05:	e9 38 01 00 00       	jmp    ffff800000109d42 <trap+0x1c8>
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
ffff800000109c0a:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff800000109c11:	80 ff ff 
ffff800000109c14:	ff d0                	call   *%rax
ffff800000109c16:	85 c0                	test   %eax,%eax
ffff800000109c18:	75 66                	jne    ffff800000109c80 <trap+0x106>
      acquire(&tickslock);
ffff800000109c1a:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109c21:	80 ff ff 
ffff800000109c24:	48 89 c7             	mov    %rax,%rdi
ffff800000109c27:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff800000109c2e:	80 ff ff 
ffff800000109c31:	ff d0                	call   *%rax
      ticks++;
ffff800000109c33:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109c3a:	80 ff ff 
ffff800000109c3d:	8b 00                	mov    (%rax),%eax
ffff800000109c3f:	8d 50 01             	lea    0x1(%rax),%edx
ffff800000109c42:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109c49:	80 ff ff 
ffff800000109c4c:	89 10                	mov    %edx,(%rax)
      wakeup(&ticks);
ffff800000109c4e:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff800000109c55:	80 ff ff 
ffff800000109c58:	48 89 c7             	mov    %rax,%rdi
ffff800000109c5b:	48 b8 4d 72 10 00 00 	movabs $0xffff80000010724d,%rax
ffff800000109c62:	80 ff ff 
ffff800000109c65:	ff d0                	call   *%rax
      release(&tickslock);
ffff800000109c67:	48 b8 e0 bc 11 00 00 	movabs $0xffff80000011bce0,%rax
ffff800000109c6e:	80 ff ff 
ffff800000109c71:	48 89 c7             	mov    %rax,%rdi
ffff800000109c74:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff800000109c7b:	80 ff ff 
ffff800000109c7e:	ff d0                	call   *%rax
    }
    lapiceoi();
ffff800000109c80:	48 b8 91 49 10 00 00 	movabs $0xffff800000104991,%rax
ffff800000109c87:	80 ff ff 
ffff800000109c8a:	ff d0                	call   *%rax
    break;
ffff800000109c8c:	e9 77 02 00 00       	jmp    ffff800000109f08 <trap+0x38e>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
ffff800000109c91:	48 b8 b1 3c 10 00 00 	movabs $0xffff800000103cb1,%rax
ffff800000109c98:	80 ff ff 
ffff800000109c9b:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109c9d:	48 b8 91 49 10 00 00 	movabs $0xffff800000104991,%rax
ffff800000109ca4:	80 ff ff 
ffff800000109ca7:	ff d0                	call   *%rax
    break;
ffff800000109ca9:	e9 5a 02 00 00       	jmp    ffff800000109f08 <trap+0x38e>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
ffff800000109cae:	48 b8 47 46 10 00 00 	movabs $0xffff800000104647,%rax
ffff800000109cb5:	80 ff ff 
ffff800000109cb8:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109cba:	48 b8 91 49 10 00 00 	movabs $0xffff800000104991,%rax
ffff800000109cc1:	80 ff ff 
ffff800000109cc4:	ff d0                	call   *%rax
    break;
ffff800000109cc6:	e9 3d 02 00 00       	jmp    ffff800000109f08 <trap+0x38e>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
ffff800000109ccb:	48 b8 30 a2 10 00 00 	movabs $0xffff80000010a230,%rax
ffff800000109cd2:	80 ff ff 
ffff800000109cd5:	ff d0                	call   *%rax
    lapiceoi();
ffff800000109cd7:	48 b8 91 49 10 00 00 	movabs $0xffff800000104991,%rax
ffff800000109cde:	80 ff ff 
ffff800000109ce1:	ff d0                	call   *%rax
    break;
ffff800000109ce3:	e9 20 02 00 00       	jmp    ffff800000109f08 <trap+0x38e>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %p:%p\n",
ffff800000109ce8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cec:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109cf3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109cf7:	48 8b 98 90 00 00 00 	mov    0x90(%rax),%rbx
ffff800000109cfe:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff800000109d05:	80 ff ff 
ffff800000109d08:	ff d0                	call   *%rax
ffff800000109d0a:	89 c6                	mov    %eax,%esi
ffff800000109d0c:	48 b8 f8 ca 10 00 00 	movabs $0xffff80000010caf8,%rax
ffff800000109d13:	80 ff ff 
ffff800000109d16:	4c 89 e1             	mov    %r12,%rcx
ffff800000109d19:	48 89 da             	mov    %rbx,%rdx
ffff800000109d1c:	48 89 c7             	mov    %rax,%rdi
ffff800000109d1f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109d24:	49 b8 04 08 10 00 00 	movabs $0xffff800000100804,%r8
ffff800000109d2b:	80 ff ff 
ffff800000109d2e:	41 ff d0             	call   *%r8
            cpunum(), tf->cs, tf->rip);
    lapiceoi();
ffff800000109d31:	48 b8 91 49 10 00 00 	movabs $0xffff800000104991,%rax
ffff800000109d38:	80 ff ff 
ffff800000109d3b:	ff d0                	call   *%rax
    break;
ffff800000109d3d:	e9 c6 01 00 00       	jmp    ffff800000109f08 <trap+0x38e>

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
ffff800000109d42:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109d49:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109d4d:	48 85 c0             	test   %rax,%rax
ffff800000109d50:	74 17                	je     ffff800000109d69 <trap+0x1ef>
ffff800000109d52:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d56:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109d5d:	83 e0 03             	and    $0x3,%eax
ffff800000109d60:	48 85 c0             	test   %rax,%rax
ffff800000109d63:	0f 85 ac 00 00 00    	jne    ffff800000109e15 <trap+0x29b>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d rip %p (cr2=0x%p)\n",
ffff800000109d69:	48 b8 e9 99 10 00 00 	movabs $0xffff8000001099e9,%rax
ffff800000109d70:	80 ff ff 
ffff800000109d73:	ff d0                	call   *%rax
ffff800000109d75:	49 89 c4             	mov    %rax,%r12
ffff800000109d78:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d7c:	48 8b 98 88 00 00 00 	mov    0x88(%rax),%rbx
ffff800000109d83:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff800000109d8a:	80 ff ff 
ffff800000109d8d:	ff d0                	call   *%rax
ffff800000109d8f:	89 c2                	mov    %eax,%edx
ffff800000109d91:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109d95:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109d99:	48 bf 20 cb 10 00 00 	movabs $0xffff80000010cb20,%rdi
ffff800000109da0:	80 ff ff 
ffff800000109da3:	4d 89 e0             	mov    %r12,%r8
ffff800000109da6:	48 89 d9             	mov    %rbx,%rcx
ffff800000109da9:	48 89 c6             	mov    %rax,%rsi
ffff800000109dac:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109db1:	49 b9 04 08 10 00 00 	movabs $0xffff800000100804,%r9
ffff800000109db8:	80 ff ff 
ffff800000109dbb:	41 ff d1             	call   *%r9
              tf->trapno, cpunum(), tf->rip, rcr2());
      if (proc)
ffff800000109dbe:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109dc5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109dc9:	48 85 c0             	test   %rax,%rax
ffff800000109dcc:	74 2e                	je     ffff800000109dfc <trap+0x282>
        cprintf("proc id: %d\n", proc->pid);
ffff800000109dce:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109dd5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109dd9:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109ddc:	48 ba 52 cb 10 00 00 	movabs $0xffff80000010cb52,%rdx
ffff800000109de3:	80 ff ff 
ffff800000109de6:	89 c6                	mov    %eax,%esi
ffff800000109de8:	48 89 d7             	mov    %rdx,%rdi
ffff800000109deb:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109df0:	48 ba 04 08 10 00 00 	movabs $0xffff800000100804,%rdx
ffff800000109df7:	80 ff ff 
ffff800000109dfa:	ff d2                	call   *%rdx
      panic("trap");
ffff800000109dfc:	48 b8 5f cb 10 00 00 	movabs $0xffff80000010cb5f,%rax
ffff800000109e03:	80 ff ff 
ffff800000109e06:	48 89 c7             	mov    %rax,%rdi
ffff800000109e09:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff800000109e10:	80 ff ff 
ffff800000109e13:	ff d0                	call   *%rax
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109e15:	48 b8 e9 99 10 00 00 	movabs $0xffff8000001099e9,%rax
ffff800000109e1c:	80 ff ff 
ffff800000109e1f:	ff d0                	call   *%rax
ffff800000109e21:	48 89 c3             	mov    %rax,%rbx
ffff800000109e24:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e28:	4c 8b a0 88 00 00 00 	mov    0x88(%rax),%r12
ffff800000109e2f:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff800000109e36:	80 ff ff 
ffff800000109e39:	ff d0                	call   *%rax
ffff800000109e3b:	89 c1                	mov    %eax,%ecx
ffff800000109e3d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e41:	4c 8b 80 80 00 00 00 	mov    0x80(%rax),%r8
ffff800000109e48:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109e4c:	48 8b 50 78          	mov    0x78(%rax),%rdx
            "rip 0x%p addr 0x%p--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->rip,
ffff800000109e50:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e57:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109e5b:	48 8d b0 d0 00 00 00 	lea    0xd0(%rax),%rsi
ffff800000109e62:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109e69:	64 48 8b 00          	mov    %fs:(%rax),%rax
    cprintf("pid %d %s: trap %d err %d on cpu %d "
ffff800000109e6d:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109e70:	48 bf 68 cb 10 00 00 	movabs $0xffff80000010cb68,%rdi
ffff800000109e77:	80 ff ff 
ffff800000109e7a:	53                   	push   %rbx
ffff800000109e7b:	41 54                	push   %r12
ffff800000109e7d:	41 89 c9             	mov    %ecx,%r9d
ffff800000109e80:	48 89 d1             	mov    %rdx,%rcx
ffff800000109e83:	48 89 f2             	mov    %rsi,%rdx
ffff800000109e86:	89 c6                	mov    %eax,%esi
ffff800000109e88:	b8 00 00 00 00       	mov    $0x0,%eax
ffff800000109e8d:	49 ba 04 08 10 00 00 	movabs $0xffff800000100804,%r10
ffff800000109e94:	80 ff ff 
ffff800000109e97:	41 ff d2             	call   *%r10
ffff800000109e9a:	48 83 c4 10          	add    $0x10,%rsp
            rcr2());
            
    // cprintf("debug: recording trap event\n");
    traceevent(TRACE_TYPE_TRAP, proc->pid, tf->trapno, tf->err, 0, proc->name);
ffff800000109e9e:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ea5:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ea9:	48 8d 90 d0 00 00 00 	lea    0xd0(%rax),%rdx
ffff800000109eb0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109eb4:	48 8b 80 80 00 00 00 	mov    0x80(%rax),%rax
ffff800000109ebb:	89 c1                	mov    %eax,%ecx
ffff800000109ebd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109ec1:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109ec5:	89 c6                	mov    %eax,%esi
ffff800000109ec7:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109ece:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109ed2:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff800000109ed5:	49 89 d1             	mov    %rdx,%r9
ffff800000109ed8:	41 b8 00 00 00 00    	mov    $0x0,%r8d
ffff800000109ede:	89 f2                	mov    %esi,%edx
ffff800000109ee0:	89 c6                	mov    %eax,%esi
ffff800000109ee2:	bf 03 00 00 00       	mov    $0x3,%edi
ffff800000109ee7:	48 b8 c4 c1 10 00 00 	movabs $0xffff80000010c1c4,%rax
ffff800000109eee:	80 ff ff 
ffff800000109ef1:	ff d0                	call   *%rax
    proc->killed = 1;
ffff800000109ef3:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109efa:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109efe:	c7 40 40 01 00 00 00 	movl   $0x1,0x40(%rax)
ffff800000109f05:	eb 01                	jmp    ffff800000109f08 <trap+0x38e>
    break;
ffff800000109f07:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109f08:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f0f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f13:	48 85 c0             	test   %rax,%rax
ffff800000109f16:	74 32                	je     ffff800000109f4a <trap+0x3d0>
ffff800000109f18:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f1f:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f23:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109f26:	85 c0                	test   %eax,%eax
ffff800000109f28:	74 20                	je     ffff800000109f4a <trap+0x3d0>
ffff800000109f2a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f2e:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109f35:	83 e0 03             	and    $0x3,%eax
ffff800000109f38:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109f3c:	75 0c                	jne    ffff800000109f4a <trap+0x3d0>
    exit();
ffff800000109f3e:	48 b8 15 6a 10 00 00 	movabs $0xffff800000106a15,%rax
ffff800000109f45:	80 ff ff 
ffff800000109f48:	ff d0                	call   *%rax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
ffff800000109f4a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f51:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f55:	48 85 c0             	test   %rax,%rax
ffff800000109f58:	74 2d                	je     ffff800000109f87 <trap+0x40d>
ffff800000109f5a:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f61:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f65:	8b 40 18             	mov    0x18(%rax),%eax
ffff800000109f68:	83 f8 04             	cmp    $0x4,%eax
ffff800000109f6b:	75 1a                	jne    ffff800000109f87 <trap+0x40d>
ffff800000109f6d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109f71:	48 8b 40 78          	mov    0x78(%rax),%rax
ffff800000109f75:	48 83 f8 20          	cmp    $0x20,%rax
ffff800000109f79:	75 0c                	jne    ffff800000109f87 <trap+0x40d>
    yield();
ffff800000109f7b:	48 b8 1f 70 10 00 00 	movabs $0xffff80000010701f,%rax
ffff800000109f82:	80 ff ff 
ffff800000109f85:	ff d0                	call   *%rax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
ffff800000109f87:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f8e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109f92:	48 85 c0             	test   %rax,%rax
ffff800000109f95:	74 32                	je     ffff800000109fc9 <trap+0x44f>
ffff800000109f97:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff800000109f9e:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff800000109fa2:	8b 40 40             	mov    0x40(%rax),%eax
ffff800000109fa5:	85 c0                	test   %eax,%eax
ffff800000109fa7:	74 20                	je     ffff800000109fc9 <trap+0x44f>
ffff800000109fa9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff800000109fad:	48 8b 80 90 00 00 00 	mov    0x90(%rax),%rax
ffff800000109fb4:	83 e0 03             	and    $0x3,%eax
ffff800000109fb7:	48 83 f8 03          	cmp    $0x3,%rax
ffff800000109fbb:	75 0c                	jne    ffff800000109fc9 <trap+0x44f>
    exit();
ffff800000109fbd:	48 b8 15 6a 10 00 00 	movabs $0xffff800000106a15,%rax
ffff800000109fc4:	80 ff ff 
ffff800000109fc7:	ff d0                	call   *%rax
}
ffff800000109fc9:	90                   	nop
ffff800000109fca:	48 8d 65 f0          	lea    -0x10(%rbp),%rsp
ffff800000109fce:	5b                   	pop    %rbx
ffff800000109fcf:	41 5c                	pop    %r12
ffff800000109fd1:	5d                   	pop    %rbp
ffff800000109fd2:	c3                   	ret

ffff800000109fd3 <inb>:
ffff800000109fd3:	55                   	push   %rbp
ffff800000109fd4:	48 89 e5             	mov    %rsp,%rbp
ffff800000109fd7:	48 83 ec 18          	sub    $0x18,%rsp
ffff800000109fdb:	89 f8                	mov    %edi,%eax
ffff800000109fdd:	66 89 45 ec          	mov    %ax,-0x14(%rbp)
ffff800000109fe1:	0f b7 45 ec          	movzwl -0x14(%rbp),%eax
ffff800000109fe5:	89 c2                	mov    %eax,%edx
ffff800000109fe7:	ec                   	in     (%dx),%al
ffff800000109fe8:	88 45 ff             	mov    %al,-0x1(%rbp)
ffff800000109feb:	0f b6 45 ff          	movzbl -0x1(%rbp),%eax
ffff800000109fef:	c9                   	leave
ffff800000109ff0:	c3                   	ret

ffff800000109ff1 <outb>:
ffff800000109ff1:	55                   	push   %rbp
ffff800000109ff2:	48 89 e5             	mov    %rsp,%rbp
ffff800000109ff5:	48 83 ec 08          	sub    $0x8,%rsp
ffff800000109ff9:	89 fa                	mov    %edi,%edx
ffff800000109ffb:	89 f0                	mov    %esi,%eax
ffff800000109ffd:	66 89 55 fc          	mov    %dx,-0x4(%rbp)
ffff80000010a001:	88 45 f8             	mov    %al,-0x8(%rbp)
ffff80000010a004:	0f b6 45 f8          	movzbl -0x8(%rbp),%eax
ffff80000010a008:	0f b7 55 fc          	movzwl -0x4(%rbp),%edx
ffff80000010a00c:	ee                   	out    %al,(%dx)
ffff80000010a00d:	90                   	nop
ffff80000010a00e:	c9                   	leave
ffff80000010a00f:	c3                   	ret

ffff80000010a010 <uartearlyinit>:
ffff80000010a010:	55                   	push   %rbp
ffff80000010a011:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a014:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010a018:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a01d:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a022:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a029:	80 ff ff 
ffff80000010a02c:	ff d0                	call   *%rax
ffff80000010a02e:	be 80 00 00 00       	mov    $0x80,%esi
ffff80000010a033:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a038:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a03f:	80 ff ff 
ffff80000010a042:	ff d0                	call   *%rax
ffff80000010a044:	be 0c 00 00 00       	mov    $0xc,%esi
ffff80000010a049:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a04e:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a055:	80 ff ff 
ffff80000010a058:	ff d0                	call   *%rax
ffff80000010a05a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a05f:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a064:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a06b:	80 ff ff 
ffff80000010a06e:	ff d0                	call   *%rax
ffff80000010a070:	be 03 00 00 00       	mov    $0x3,%esi
ffff80000010a075:	bf fb 03 00 00       	mov    $0x3fb,%edi
ffff80000010a07a:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a081:	80 ff ff 
ffff80000010a084:	ff d0                	call   *%rax
ffff80000010a086:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a08b:	bf fc 03 00 00       	mov    $0x3fc,%edi
ffff80000010a090:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a097:	80 ff ff 
ffff80000010a09a:	ff d0                	call   *%rax
ffff80000010a09c:	be 01 00 00 00       	mov    $0x1,%esi
ffff80000010a0a1:	bf f9 03 00 00       	mov    $0x3f9,%edi
ffff80000010a0a6:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a0ad:	80 ff ff 
ffff80000010a0b0:	ff d0                	call   *%rax
ffff80000010a0b2:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a0b7:	48 b8 d3 9f 10 00 00 	movabs $0xffff800000109fd3,%rax
ffff80000010a0be:	80 ff ff 
ffff80000010a0c1:	ff d0                	call   *%rax
ffff80000010a0c3:	3c ff                	cmp    $0xff,%al
ffff80000010a0c5:	74 4a                	je     ffff80000010a111 <uartearlyinit+0x101>
ffff80000010a0c7:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a0ce:	80 ff ff 
ffff80000010a0d1:	c7 00 01 00 00 00    	movl   $0x1,(%rax)
ffff80000010a0d7:	48 b8 ab cb 10 00 00 	movabs $0xffff80000010cbab,%rax
ffff80000010a0de:	80 ff ff 
ffff80000010a0e1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010a0e5:	eb 1d                	jmp    ffff80000010a104 <uartearlyinit+0xf4>
ffff80000010a0e7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a0eb:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a0ee:	0f be c0             	movsbl %al,%eax
ffff80000010a0f1:	89 c7                	mov    %eax,%edi
ffff80000010a0f3:	48 b8 65 a1 10 00 00 	movabs $0xffff80000010a165,%rax
ffff80000010a0fa:	80 ff ff 
ffff80000010a0fd:	ff d0                	call   *%rax
ffff80000010a0ff:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
ffff80000010a104:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010a108:	0f b6 00             	movzbl (%rax),%eax
ffff80000010a10b:	84 c0                	test   %al,%al
ffff80000010a10d:	75 d8                	jne    ffff80000010a0e7 <uartearlyinit+0xd7>
ffff80000010a10f:	eb 01                	jmp    ffff80000010a112 <uartearlyinit+0x102>
ffff80000010a111:	90                   	nop
ffff80000010a112:	c9                   	leave
ffff80000010a113:	c3                   	ret

ffff80000010a114 <uartinit>:
ffff80000010a114:	55                   	push   %rbp
ffff80000010a115:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a118:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a11f:	80 ff ff 
ffff80000010a122:	8b 00                	mov    (%rax),%eax
ffff80000010a124:	85 c0                	test   %eax,%eax
ffff80000010a126:	74 3a                	je     ffff80000010a162 <uartinit+0x4e>
ffff80000010a128:	bf fa 03 00 00       	mov    $0x3fa,%edi
ffff80000010a12d:	48 b8 d3 9f 10 00 00 	movabs $0xffff800000109fd3,%rax
ffff80000010a134:	80 ff ff 
ffff80000010a137:	ff d0                	call   *%rax
ffff80000010a139:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a13e:	48 b8 d3 9f 10 00 00 	movabs $0xffff800000109fd3,%rax
ffff80000010a145:	80 ff ff 
ffff80000010a148:	ff d0                	call   *%rax
ffff80000010a14a:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010a14f:	bf 04 00 00 00       	mov    $0x4,%edi
ffff80000010a154:	48 b8 96 40 10 00 00 	movabs $0xffff800000104096,%rax
ffff80000010a15b:	80 ff ff 
ffff80000010a15e:	ff d0                	call   *%rax
ffff80000010a160:	eb 01                	jmp    ffff80000010a163 <uartinit+0x4f>
ffff80000010a162:	90                   	nop
ffff80000010a163:	5d                   	pop    %rbp
ffff80000010a164:	c3                   	ret

ffff80000010a165 <uartputc>:
ffff80000010a165:	55                   	push   %rbp
ffff80000010a166:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a169:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010a16d:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010a170:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a177:	80 ff ff 
ffff80000010a17a:	8b 00                	mov    (%rax),%eax
ffff80000010a17c:	85 c0                	test   %eax,%eax
ffff80000010a17e:	74 5a                	je     ffff80000010a1da <uartputc+0x75>
ffff80000010a180:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010a187:	eb 15                	jmp    ffff80000010a19e <uartputc+0x39>
ffff80000010a189:	bf 0a 00 00 00       	mov    $0xa,%edi
ffff80000010a18e:	48 b8 c0 49 10 00 00 	movabs $0xffff8000001049c0,%rax
ffff80000010a195:	80 ff ff 
ffff80000010a198:	ff d0                	call   *%rax
ffff80000010a19a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010a19e:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%rbp)
ffff80000010a1a2:	7f 1b                	jg     ffff80000010a1bf <uartputc+0x5a>
ffff80000010a1a4:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a1a9:	48 b8 d3 9f 10 00 00 	movabs $0xffff800000109fd3,%rax
ffff80000010a1b0:	80 ff ff 
ffff80000010a1b3:	ff d0                	call   *%rax
ffff80000010a1b5:	0f b6 c0             	movzbl %al,%eax
ffff80000010a1b8:	83 e0 20             	and    $0x20,%eax
ffff80000010a1bb:	85 c0                	test   %eax,%eax
ffff80000010a1bd:	74 ca                	je     ffff80000010a189 <uartputc+0x24>
ffff80000010a1bf:	8b 45 ec             	mov    -0x14(%rbp),%eax
ffff80000010a1c2:	0f b6 c0             	movzbl %al,%eax
ffff80000010a1c5:	89 c6                	mov    %eax,%esi
ffff80000010a1c7:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a1cc:	48 b8 f1 9f 10 00 00 	movabs $0xffff800000109ff1,%rax
ffff80000010a1d3:	80 ff ff 
ffff80000010a1d6:	ff d0                	call   *%rax
ffff80000010a1d8:	eb 01                	jmp    ffff80000010a1db <uartputc+0x76>
ffff80000010a1da:	90                   	nop
ffff80000010a1db:	c9                   	leave
ffff80000010a1dc:	c3                   	ret

ffff80000010a1dd <uartgetc>:
ffff80000010a1dd:	55                   	push   %rbp
ffff80000010a1de:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a1e1:	48 b8 4c bd 11 00 00 	movabs $0xffff80000011bd4c,%rax
ffff80000010a1e8:	80 ff ff 
ffff80000010a1eb:	8b 00                	mov    (%rax),%eax
ffff80000010a1ed:	85 c0                	test   %eax,%eax
ffff80000010a1ef:	75 07                	jne    ffff80000010a1f8 <uartgetc+0x1b>
ffff80000010a1f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a1f6:	eb 36                	jmp    ffff80000010a22e <uartgetc+0x51>
ffff80000010a1f8:	bf fd 03 00 00       	mov    $0x3fd,%edi
ffff80000010a1fd:	48 b8 d3 9f 10 00 00 	movabs $0xffff800000109fd3,%rax
ffff80000010a204:	80 ff ff 
ffff80000010a207:	ff d0                	call   *%rax
ffff80000010a209:	0f b6 c0             	movzbl %al,%eax
ffff80000010a20c:	83 e0 01             	and    $0x1,%eax
ffff80000010a20f:	85 c0                	test   %eax,%eax
ffff80000010a211:	75 07                	jne    ffff80000010a21a <uartgetc+0x3d>
ffff80000010a213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010a218:	eb 14                	jmp    ffff80000010a22e <uartgetc+0x51>
ffff80000010a21a:	bf f8 03 00 00       	mov    $0x3f8,%edi
ffff80000010a21f:	48 b8 d3 9f 10 00 00 	movabs $0xffff800000109fd3,%rax
ffff80000010a226:	80 ff ff 
ffff80000010a229:	ff d0                	call   *%rax
ffff80000010a22b:	0f b6 c0             	movzbl %al,%eax
ffff80000010a22e:	5d                   	pop    %rbp
ffff80000010a22f:	c3                   	ret

ffff80000010a230 <uartintr>:
ffff80000010a230:	55                   	push   %rbp
ffff80000010a231:	48 89 e5             	mov    %rsp,%rbp
ffff80000010a234:	48 b8 dd a1 10 00 00 	movabs $0xffff80000010a1dd,%rax
ffff80000010a23b:	80 ff ff 
ffff80000010a23e:	48 89 c7             	mov    %rax,%rdi
ffff80000010a241:	48 b8 97 10 10 00 00 	movabs $0xffff800000101097,%rax
ffff80000010a248:	80 ff ff 
ffff80000010a24b:	ff d0                	call   *%rax
ffff80000010a24d:	90                   	nop
ffff80000010a24e:	5d                   	pop    %rbp
ffff80000010a24f:	c3                   	ret

ffff80000010a250 <vector0>:
ffff80000010a250:	6a 00                	push   $0x0
ffff80000010a252:	6a 00                	push   $0x0
ffff80000010a254:	e9 87 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a259 <vector1>:
ffff80000010a259:	6a 00                	push   $0x0
ffff80000010a25b:	6a 01                	push   $0x1
ffff80000010a25d:	e9 7e f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a262 <vector2>:
ffff80000010a262:	6a 00                	push   $0x0
ffff80000010a264:	6a 02                	push   $0x2
ffff80000010a266:	e9 75 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a26b <vector3>:
ffff80000010a26b:	6a 00                	push   $0x0
ffff80000010a26d:	6a 03                	push   $0x3
ffff80000010a26f:	e9 6c f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a274 <vector4>:
ffff80000010a274:	6a 00                	push   $0x0
ffff80000010a276:	6a 04                	push   $0x4
ffff80000010a278:	e9 63 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a27d <vector5>:
ffff80000010a27d:	6a 00                	push   $0x0
ffff80000010a27f:	6a 05                	push   $0x5
ffff80000010a281:	e9 5a f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a286 <vector6>:
ffff80000010a286:	6a 00                	push   $0x0
ffff80000010a288:	6a 06                	push   $0x6
ffff80000010a28a:	e9 51 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a28f <vector7>:
ffff80000010a28f:	6a 00                	push   $0x0
ffff80000010a291:	6a 07                	push   $0x7
ffff80000010a293:	e9 48 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a298 <vector8>:
ffff80000010a298:	6a 08                	push   $0x8
ffff80000010a29a:	e9 41 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a29f <vector9>:
ffff80000010a29f:	6a 00                	push   $0x0
ffff80000010a2a1:	6a 09                	push   $0x9
ffff80000010a2a3:	e9 38 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2a8 <vector10>:
ffff80000010a2a8:	6a 0a                	push   $0xa
ffff80000010a2aa:	e9 31 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2af <vector11>:
ffff80000010a2af:	6a 0b                	push   $0xb
ffff80000010a2b1:	e9 2a f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2b6 <vector12>:
ffff80000010a2b6:	6a 0c                	push   $0xc
ffff80000010a2b8:	e9 23 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2bd <vector13>:
ffff80000010a2bd:	6a 0d                	push   $0xd
ffff80000010a2bf:	e9 1c f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2c4 <vector14>:
ffff80000010a2c4:	6a 0e                	push   $0xe
ffff80000010a2c6:	e9 15 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2cb <vector15>:
ffff80000010a2cb:	6a 00                	push   $0x0
ffff80000010a2cd:	6a 0f                	push   $0xf
ffff80000010a2cf:	e9 0c f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2d4 <vector16>:
ffff80000010a2d4:	6a 00                	push   $0x0
ffff80000010a2d6:	6a 10                	push   $0x10
ffff80000010a2d8:	e9 03 f6 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2dd <vector17>:
ffff80000010a2dd:	6a 11                	push   $0x11
ffff80000010a2df:	e9 fc f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2e4 <vector18>:
ffff80000010a2e4:	6a 00                	push   $0x0
ffff80000010a2e6:	6a 12                	push   $0x12
ffff80000010a2e8:	e9 f3 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2ed <vector19>:
ffff80000010a2ed:	6a 00                	push   $0x0
ffff80000010a2ef:	6a 13                	push   $0x13
ffff80000010a2f1:	e9 ea f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2f6 <vector20>:
ffff80000010a2f6:	6a 00                	push   $0x0
ffff80000010a2f8:	6a 14                	push   $0x14
ffff80000010a2fa:	e9 e1 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a2ff <vector21>:
ffff80000010a2ff:	6a 00                	push   $0x0
ffff80000010a301:	6a 15                	push   $0x15
ffff80000010a303:	e9 d8 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a308 <vector22>:
ffff80000010a308:	6a 00                	push   $0x0
ffff80000010a30a:	6a 16                	push   $0x16
ffff80000010a30c:	e9 cf f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a311 <vector23>:
ffff80000010a311:	6a 00                	push   $0x0
ffff80000010a313:	6a 17                	push   $0x17
ffff80000010a315:	e9 c6 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a31a <vector24>:
ffff80000010a31a:	6a 00                	push   $0x0
ffff80000010a31c:	6a 18                	push   $0x18
ffff80000010a31e:	e9 bd f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a323 <vector25>:
ffff80000010a323:	6a 00                	push   $0x0
ffff80000010a325:	6a 19                	push   $0x19
ffff80000010a327:	e9 b4 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a32c <vector26>:
ffff80000010a32c:	6a 00                	push   $0x0
ffff80000010a32e:	6a 1a                	push   $0x1a
ffff80000010a330:	e9 ab f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a335 <vector27>:
ffff80000010a335:	6a 00                	push   $0x0
ffff80000010a337:	6a 1b                	push   $0x1b
ffff80000010a339:	e9 a2 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a33e <vector28>:
ffff80000010a33e:	6a 00                	push   $0x0
ffff80000010a340:	6a 1c                	push   $0x1c
ffff80000010a342:	e9 99 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a347 <vector29>:
ffff80000010a347:	6a 00                	push   $0x0
ffff80000010a349:	6a 1d                	push   $0x1d
ffff80000010a34b:	e9 90 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a350 <vector30>:
ffff80000010a350:	6a 00                	push   $0x0
ffff80000010a352:	6a 1e                	push   $0x1e
ffff80000010a354:	e9 87 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a359 <vector31>:
ffff80000010a359:	6a 00                	push   $0x0
ffff80000010a35b:	6a 1f                	push   $0x1f
ffff80000010a35d:	e9 7e f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a362 <vector32>:
ffff80000010a362:	6a 00                	push   $0x0
ffff80000010a364:	6a 20                	push   $0x20
ffff80000010a366:	e9 75 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a36b <vector33>:
ffff80000010a36b:	6a 00                	push   $0x0
ffff80000010a36d:	6a 21                	push   $0x21
ffff80000010a36f:	e9 6c f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a374 <vector34>:
ffff80000010a374:	6a 00                	push   $0x0
ffff80000010a376:	6a 22                	push   $0x22
ffff80000010a378:	e9 63 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a37d <vector35>:
ffff80000010a37d:	6a 00                	push   $0x0
ffff80000010a37f:	6a 23                	push   $0x23
ffff80000010a381:	e9 5a f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a386 <vector36>:
ffff80000010a386:	6a 00                	push   $0x0
ffff80000010a388:	6a 24                	push   $0x24
ffff80000010a38a:	e9 51 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a38f <vector37>:
ffff80000010a38f:	6a 00                	push   $0x0
ffff80000010a391:	6a 25                	push   $0x25
ffff80000010a393:	e9 48 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a398 <vector38>:
ffff80000010a398:	6a 00                	push   $0x0
ffff80000010a39a:	6a 26                	push   $0x26
ffff80000010a39c:	e9 3f f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3a1 <vector39>:
ffff80000010a3a1:	6a 00                	push   $0x0
ffff80000010a3a3:	6a 27                	push   $0x27
ffff80000010a3a5:	e9 36 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3aa <vector40>:
ffff80000010a3aa:	6a 00                	push   $0x0
ffff80000010a3ac:	6a 28                	push   $0x28
ffff80000010a3ae:	e9 2d f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3b3 <vector41>:
ffff80000010a3b3:	6a 00                	push   $0x0
ffff80000010a3b5:	6a 29                	push   $0x29
ffff80000010a3b7:	e9 24 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3bc <vector42>:
ffff80000010a3bc:	6a 00                	push   $0x0
ffff80000010a3be:	6a 2a                	push   $0x2a
ffff80000010a3c0:	e9 1b f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3c5 <vector43>:
ffff80000010a3c5:	6a 00                	push   $0x0
ffff80000010a3c7:	6a 2b                	push   $0x2b
ffff80000010a3c9:	e9 12 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3ce <vector44>:
ffff80000010a3ce:	6a 00                	push   $0x0
ffff80000010a3d0:	6a 2c                	push   $0x2c
ffff80000010a3d2:	e9 09 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3d7 <vector45>:
ffff80000010a3d7:	6a 00                	push   $0x0
ffff80000010a3d9:	6a 2d                	push   $0x2d
ffff80000010a3db:	e9 00 f5 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3e0 <vector46>:
ffff80000010a3e0:	6a 00                	push   $0x0
ffff80000010a3e2:	6a 2e                	push   $0x2e
ffff80000010a3e4:	e9 f7 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3e9 <vector47>:
ffff80000010a3e9:	6a 00                	push   $0x0
ffff80000010a3eb:	6a 2f                	push   $0x2f
ffff80000010a3ed:	e9 ee f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3f2 <vector48>:
ffff80000010a3f2:	6a 00                	push   $0x0
ffff80000010a3f4:	6a 30                	push   $0x30
ffff80000010a3f6:	e9 e5 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a3fb <vector49>:
ffff80000010a3fb:	6a 00                	push   $0x0
ffff80000010a3fd:	6a 31                	push   $0x31
ffff80000010a3ff:	e9 dc f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a404 <vector50>:
ffff80000010a404:	6a 00                	push   $0x0
ffff80000010a406:	6a 32                	push   $0x32
ffff80000010a408:	e9 d3 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a40d <vector51>:
ffff80000010a40d:	6a 00                	push   $0x0
ffff80000010a40f:	6a 33                	push   $0x33
ffff80000010a411:	e9 ca f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a416 <vector52>:
ffff80000010a416:	6a 00                	push   $0x0
ffff80000010a418:	6a 34                	push   $0x34
ffff80000010a41a:	e9 c1 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a41f <vector53>:
ffff80000010a41f:	6a 00                	push   $0x0
ffff80000010a421:	6a 35                	push   $0x35
ffff80000010a423:	e9 b8 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a428 <vector54>:
ffff80000010a428:	6a 00                	push   $0x0
ffff80000010a42a:	6a 36                	push   $0x36
ffff80000010a42c:	e9 af f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a431 <vector55>:
ffff80000010a431:	6a 00                	push   $0x0
ffff80000010a433:	6a 37                	push   $0x37
ffff80000010a435:	e9 a6 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a43a <vector56>:
ffff80000010a43a:	6a 00                	push   $0x0
ffff80000010a43c:	6a 38                	push   $0x38
ffff80000010a43e:	e9 9d f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a443 <vector57>:
ffff80000010a443:	6a 00                	push   $0x0
ffff80000010a445:	6a 39                	push   $0x39
ffff80000010a447:	e9 94 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a44c <vector58>:
ffff80000010a44c:	6a 00                	push   $0x0
ffff80000010a44e:	6a 3a                	push   $0x3a
ffff80000010a450:	e9 8b f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a455 <vector59>:
ffff80000010a455:	6a 00                	push   $0x0
ffff80000010a457:	6a 3b                	push   $0x3b
ffff80000010a459:	e9 82 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a45e <vector60>:
ffff80000010a45e:	6a 00                	push   $0x0
ffff80000010a460:	6a 3c                	push   $0x3c
ffff80000010a462:	e9 79 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a467 <vector61>:
ffff80000010a467:	6a 00                	push   $0x0
ffff80000010a469:	6a 3d                	push   $0x3d
ffff80000010a46b:	e9 70 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a470 <vector62>:
ffff80000010a470:	6a 00                	push   $0x0
ffff80000010a472:	6a 3e                	push   $0x3e
ffff80000010a474:	e9 67 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a479 <vector63>:
ffff80000010a479:	6a 00                	push   $0x0
ffff80000010a47b:	6a 3f                	push   $0x3f
ffff80000010a47d:	e9 5e f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a482 <vector64>:
ffff80000010a482:	6a 00                	push   $0x0
ffff80000010a484:	6a 40                	push   $0x40
ffff80000010a486:	e9 55 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a48b <vector65>:
ffff80000010a48b:	6a 00                	push   $0x0
ffff80000010a48d:	6a 41                	push   $0x41
ffff80000010a48f:	e9 4c f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a494 <vector66>:
ffff80000010a494:	6a 00                	push   $0x0
ffff80000010a496:	6a 42                	push   $0x42
ffff80000010a498:	e9 43 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a49d <vector67>:
ffff80000010a49d:	6a 00                	push   $0x0
ffff80000010a49f:	6a 43                	push   $0x43
ffff80000010a4a1:	e9 3a f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4a6 <vector68>:
ffff80000010a4a6:	6a 00                	push   $0x0
ffff80000010a4a8:	6a 44                	push   $0x44
ffff80000010a4aa:	e9 31 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4af <vector69>:
ffff80000010a4af:	6a 00                	push   $0x0
ffff80000010a4b1:	6a 45                	push   $0x45
ffff80000010a4b3:	e9 28 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4b8 <vector70>:
ffff80000010a4b8:	6a 00                	push   $0x0
ffff80000010a4ba:	6a 46                	push   $0x46
ffff80000010a4bc:	e9 1f f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4c1 <vector71>:
ffff80000010a4c1:	6a 00                	push   $0x0
ffff80000010a4c3:	6a 47                	push   $0x47
ffff80000010a4c5:	e9 16 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4ca <vector72>:
ffff80000010a4ca:	6a 00                	push   $0x0
ffff80000010a4cc:	6a 48                	push   $0x48
ffff80000010a4ce:	e9 0d f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4d3 <vector73>:
ffff80000010a4d3:	6a 00                	push   $0x0
ffff80000010a4d5:	6a 49                	push   $0x49
ffff80000010a4d7:	e9 04 f4 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4dc <vector74>:
ffff80000010a4dc:	6a 00                	push   $0x0
ffff80000010a4de:	6a 4a                	push   $0x4a
ffff80000010a4e0:	e9 fb f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4e5 <vector75>:
ffff80000010a4e5:	6a 00                	push   $0x0
ffff80000010a4e7:	6a 4b                	push   $0x4b
ffff80000010a4e9:	e9 f2 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4ee <vector76>:
ffff80000010a4ee:	6a 00                	push   $0x0
ffff80000010a4f0:	6a 4c                	push   $0x4c
ffff80000010a4f2:	e9 e9 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a4f7 <vector77>:
ffff80000010a4f7:	6a 00                	push   $0x0
ffff80000010a4f9:	6a 4d                	push   $0x4d
ffff80000010a4fb:	e9 e0 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a500 <vector78>:
ffff80000010a500:	6a 00                	push   $0x0
ffff80000010a502:	6a 4e                	push   $0x4e
ffff80000010a504:	e9 d7 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a509 <vector79>:
ffff80000010a509:	6a 00                	push   $0x0
ffff80000010a50b:	6a 4f                	push   $0x4f
ffff80000010a50d:	e9 ce f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a512 <vector80>:
ffff80000010a512:	6a 00                	push   $0x0
ffff80000010a514:	6a 50                	push   $0x50
ffff80000010a516:	e9 c5 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a51b <vector81>:
ffff80000010a51b:	6a 00                	push   $0x0
ffff80000010a51d:	6a 51                	push   $0x51
ffff80000010a51f:	e9 bc f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a524 <vector82>:
ffff80000010a524:	6a 00                	push   $0x0
ffff80000010a526:	6a 52                	push   $0x52
ffff80000010a528:	e9 b3 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a52d <vector83>:
ffff80000010a52d:	6a 00                	push   $0x0
ffff80000010a52f:	6a 53                	push   $0x53
ffff80000010a531:	e9 aa f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a536 <vector84>:
ffff80000010a536:	6a 00                	push   $0x0
ffff80000010a538:	6a 54                	push   $0x54
ffff80000010a53a:	e9 a1 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a53f <vector85>:
ffff80000010a53f:	6a 00                	push   $0x0
ffff80000010a541:	6a 55                	push   $0x55
ffff80000010a543:	e9 98 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a548 <vector86>:
ffff80000010a548:	6a 00                	push   $0x0
ffff80000010a54a:	6a 56                	push   $0x56
ffff80000010a54c:	e9 8f f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a551 <vector87>:
ffff80000010a551:	6a 00                	push   $0x0
ffff80000010a553:	6a 57                	push   $0x57
ffff80000010a555:	e9 86 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a55a <vector88>:
ffff80000010a55a:	6a 00                	push   $0x0
ffff80000010a55c:	6a 58                	push   $0x58
ffff80000010a55e:	e9 7d f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a563 <vector89>:
ffff80000010a563:	6a 00                	push   $0x0
ffff80000010a565:	6a 59                	push   $0x59
ffff80000010a567:	e9 74 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a56c <vector90>:
ffff80000010a56c:	6a 00                	push   $0x0
ffff80000010a56e:	6a 5a                	push   $0x5a
ffff80000010a570:	e9 6b f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a575 <vector91>:
ffff80000010a575:	6a 00                	push   $0x0
ffff80000010a577:	6a 5b                	push   $0x5b
ffff80000010a579:	e9 62 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a57e <vector92>:
ffff80000010a57e:	6a 00                	push   $0x0
ffff80000010a580:	6a 5c                	push   $0x5c
ffff80000010a582:	e9 59 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a587 <vector93>:
ffff80000010a587:	6a 00                	push   $0x0
ffff80000010a589:	6a 5d                	push   $0x5d
ffff80000010a58b:	e9 50 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a590 <vector94>:
ffff80000010a590:	6a 00                	push   $0x0
ffff80000010a592:	6a 5e                	push   $0x5e
ffff80000010a594:	e9 47 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a599 <vector95>:
ffff80000010a599:	6a 00                	push   $0x0
ffff80000010a59b:	6a 5f                	push   $0x5f
ffff80000010a59d:	e9 3e f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5a2 <vector96>:
ffff80000010a5a2:	6a 00                	push   $0x0
ffff80000010a5a4:	6a 60                	push   $0x60
ffff80000010a5a6:	e9 35 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5ab <vector97>:
ffff80000010a5ab:	6a 00                	push   $0x0
ffff80000010a5ad:	6a 61                	push   $0x61
ffff80000010a5af:	e9 2c f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5b4 <vector98>:
ffff80000010a5b4:	6a 00                	push   $0x0
ffff80000010a5b6:	6a 62                	push   $0x62
ffff80000010a5b8:	e9 23 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5bd <vector99>:
ffff80000010a5bd:	6a 00                	push   $0x0
ffff80000010a5bf:	6a 63                	push   $0x63
ffff80000010a5c1:	e9 1a f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5c6 <vector100>:
ffff80000010a5c6:	6a 00                	push   $0x0
ffff80000010a5c8:	6a 64                	push   $0x64
ffff80000010a5ca:	e9 11 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5cf <vector101>:
ffff80000010a5cf:	6a 00                	push   $0x0
ffff80000010a5d1:	6a 65                	push   $0x65
ffff80000010a5d3:	e9 08 f3 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5d8 <vector102>:
ffff80000010a5d8:	6a 00                	push   $0x0
ffff80000010a5da:	6a 66                	push   $0x66
ffff80000010a5dc:	e9 ff f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5e1 <vector103>:
ffff80000010a5e1:	6a 00                	push   $0x0
ffff80000010a5e3:	6a 67                	push   $0x67
ffff80000010a5e5:	e9 f6 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5ea <vector104>:
ffff80000010a5ea:	6a 00                	push   $0x0
ffff80000010a5ec:	6a 68                	push   $0x68
ffff80000010a5ee:	e9 ed f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5f3 <vector105>:
ffff80000010a5f3:	6a 00                	push   $0x0
ffff80000010a5f5:	6a 69                	push   $0x69
ffff80000010a5f7:	e9 e4 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a5fc <vector106>:
ffff80000010a5fc:	6a 00                	push   $0x0
ffff80000010a5fe:	6a 6a                	push   $0x6a
ffff80000010a600:	e9 db f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a605 <vector107>:
ffff80000010a605:	6a 00                	push   $0x0
ffff80000010a607:	6a 6b                	push   $0x6b
ffff80000010a609:	e9 d2 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a60e <vector108>:
ffff80000010a60e:	6a 00                	push   $0x0
ffff80000010a610:	6a 6c                	push   $0x6c
ffff80000010a612:	e9 c9 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a617 <vector109>:
ffff80000010a617:	6a 00                	push   $0x0
ffff80000010a619:	6a 6d                	push   $0x6d
ffff80000010a61b:	e9 c0 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a620 <vector110>:
ffff80000010a620:	6a 00                	push   $0x0
ffff80000010a622:	6a 6e                	push   $0x6e
ffff80000010a624:	e9 b7 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a629 <vector111>:
ffff80000010a629:	6a 00                	push   $0x0
ffff80000010a62b:	6a 6f                	push   $0x6f
ffff80000010a62d:	e9 ae f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a632 <vector112>:
ffff80000010a632:	6a 00                	push   $0x0
ffff80000010a634:	6a 70                	push   $0x70
ffff80000010a636:	e9 a5 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a63b <vector113>:
ffff80000010a63b:	6a 00                	push   $0x0
ffff80000010a63d:	6a 71                	push   $0x71
ffff80000010a63f:	e9 9c f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a644 <vector114>:
ffff80000010a644:	6a 00                	push   $0x0
ffff80000010a646:	6a 72                	push   $0x72
ffff80000010a648:	e9 93 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a64d <vector115>:
ffff80000010a64d:	6a 00                	push   $0x0
ffff80000010a64f:	6a 73                	push   $0x73
ffff80000010a651:	e9 8a f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a656 <vector116>:
ffff80000010a656:	6a 00                	push   $0x0
ffff80000010a658:	6a 74                	push   $0x74
ffff80000010a65a:	e9 81 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a65f <vector117>:
ffff80000010a65f:	6a 00                	push   $0x0
ffff80000010a661:	6a 75                	push   $0x75
ffff80000010a663:	e9 78 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a668 <vector118>:
ffff80000010a668:	6a 00                	push   $0x0
ffff80000010a66a:	6a 76                	push   $0x76
ffff80000010a66c:	e9 6f f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a671 <vector119>:
ffff80000010a671:	6a 00                	push   $0x0
ffff80000010a673:	6a 77                	push   $0x77
ffff80000010a675:	e9 66 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a67a <vector120>:
ffff80000010a67a:	6a 00                	push   $0x0
ffff80000010a67c:	6a 78                	push   $0x78
ffff80000010a67e:	e9 5d f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a683 <vector121>:
ffff80000010a683:	6a 00                	push   $0x0
ffff80000010a685:	6a 79                	push   $0x79
ffff80000010a687:	e9 54 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a68c <vector122>:
ffff80000010a68c:	6a 00                	push   $0x0
ffff80000010a68e:	6a 7a                	push   $0x7a
ffff80000010a690:	e9 4b f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a695 <vector123>:
ffff80000010a695:	6a 00                	push   $0x0
ffff80000010a697:	6a 7b                	push   $0x7b
ffff80000010a699:	e9 42 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a69e <vector124>:
ffff80000010a69e:	6a 00                	push   $0x0
ffff80000010a6a0:	6a 7c                	push   $0x7c
ffff80000010a6a2:	e9 39 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6a7 <vector125>:
ffff80000010a6a7:	6a 00                	push   $0x0
ffff80000010a6a9:	6a 7d                	push   $0x7d
ffff80000010a6ab:	e9 30 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6b0 <vector126>:
ffff80000010a6b0:	6a 00                	push   $0x0
ffff80000010a6b2:	6a 7e                	push   $0x7e
ffff80000010a6b4:	e9 27 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6b9 <vector127>:
ffff80000010a6b9:	6a 00                	push   $0x0
ffff80000010a6bb:	6a 7f                	push   $0x7f
ffff80000010a6bd:	e9 1e f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6c2 <vector128>:
ffff80000010a6c2:	6a 00                	push   $0x0
ffff80000010a6c4:	68 80 00 00 00       	push   $0x80
ffff80000010a6c9:	e9 12 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6ce <vector129>:
ffff80000010a6ce:	6a 00                	push   $0x0
ffff80000010a6d0:	68 81 00 00 00       	push   $0x81
ffff80000010a6d5:	e9 06 f2 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6da <vector130>:
ffff80000010a6da:	6a 00                	push   $0x0
ffff80000010a6dc:	68 82 00 00 00       	push   $0x82
ffff80000010a6e1:	e9 fa f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6e6 <vector131>:
ffff80000010a6e6:	6a 00                	push   $0x0
ffff80000010a6e8:	68 83 00 00 00       	push   $0x83
ffff80000010a6ed:	e9 ee f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6f2 <vector132>:
ffff80000010a6f2:	6a 00                	push   $0x0
ffff80000010a6f4:	68 84 00 00 00       	push   $0x84
ffff80000010a6f9:	e9 e2 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a6fe <vector133>:
ffff80000010a6fe:	6a 00                	push   $0x0
ffff80000010a700:	68 85 00 00 00       	push   $0x85
ffff80000010a705:	e9 d6 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a70a <vector134>:
ffff80000010a70a:	6a 00                	push   $0x0
ffff80000010a70c:	68 86 00 00 00       	push   $0x86
ffff80000010a711:	e9 ca f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a716 <vector135>:
ffff80000010a716:	6a 00                	push   $0x0
ffff80000010a718:	68 87 00 00 00       	push   $0x87
ffff80000010a71d:	e9 be f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a722 <vector136>:
ffff80000010a722:	6a 00                	push   $0x0
ffff80000010a724:	68 88 00 00 00       	push   $0x88
ffff80000010a729:	e9 b2 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a72e <vector137>:
ffff80000010a72e:	6a 00                	push   $0x0
ffff80000010a730:	68 89 00 00 00       	push   $0x89
ffff80000010a735:	e9 a6 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a73a <vector138>:
ffff80000010a73a:	6a 00                	push   $0x0
ffff80000010a73c:	68 8a 00 00 00       	push   $0x8a
ffff80000010a741:	e9 9a f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a746 <vector139>:
ffff80000010a746:	6a 00                	push   $0x0
ffff80000010a748:	68 8b 00 00 00       	push   $0x8b
ffff80000010a74d:	e9 8e f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a752 <vector140>:
ffff80000010a752:	6a 00                	push   $0x0
ffff80000010a754:	68 8c 00 00 00       	push   $0x8c
ffff80000010a759:	e9 82 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a75e <vector141>:
ffff80000010a75e:	6a 00                	push   $0x0
ffff80000010a760:	68 8d 00 00 00       	push   $0x8d
ffff80000010a765:	e9 76 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a76a <vector142>:
ffff80000010a76a:	6a 00                	push   $0x0
ffff80000010a76c:	68 8e 00 00 00       	push   $0x8e
ffff80000010a771:	e9 6a f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a776 <vector143>:
ffff80000010a776:	6a 00                	push   $0x0
ffff80000010a778:	68 8f 00 00 00       	push   $0x8f
ffff80000010a77d:	e9 5e f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a782 <vector144>:
ffff80000010a782:	6a 00                	push   $0x0
ffff80000010a784:	68 90 00 00 00       	push   $0x90
ffff80000010a789:	e9 52 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a78e <vector145>:
ffff80000010a78e:	6a 00                	push   $0x0
ffff80000010a790:	68 91 00 00 00       	push   $0x91
ffff80000010a795:	e9 46 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a79a <vector146>:
ffff80000010a79a:	6a 00                	push   $0x0
ffff80000010a79c:	68 92 00 00 00       	push   $0x92
ffff80000010a7a1:	e9 3a f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7a6 <vector147>:
ffff80000010a7a6:	6a 00                	push   $0x0
ffff80000010a7a8:	68 93 00 00 00       	push   $0x93
ffff80000010a7ad:	e9 2e f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7b2 <vector148>:
ffff80000010a7b2:	6a 00                	push   $0x0
ffff80000010a7b4:	68 94 00 00 00       	push   $0x94
ffff80000010a7b9:	e9 22 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7be <vector149>:
ffff80000010a7be:	6a 00                	push   $0x0
ffff80000010a7c0:	68 95 00 00 00       	push   $0x95
ffff80000010a7c5:	e9 16 f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7ca <vector150>:
ffff80000010a7ca:	6a 00                	push   $0x0
ffff80000010a7cc:	68 96 00 00 00       	push   $0x96
ffff80000010a7d1:	e9 0a f1 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7d6 <vector151>:
ffff80000010a7d6:	6a 00                	push   $0x0
ffff80000010a7d8:	68 97 00 00 00       	push   $0x97
ffff80000010a7dd:	e9 fe f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7e2 <vector152>:
ffff80000010a7e2:	6a 00                	push   $0x0
ffff80000010a7e4:	68 98 00 00 00       	push   $0x98
ffff80000010a7e9:	e9 f2 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7ee <vector153>:
ffff80000010a7ee:	6a 00                	push   $0x0
ffff80000010a7f0:	68 99 00 00 00       	push   $0x99
ffff80000010a7f5:	e9 e6 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a7fa <vector154>:
ffff80000010a7fa:	6a 00                	push   $0x0
ffff80000010a7fc:	68 9a 00 00 00       	push   $0x9a
ffff80000010a801:	e9 da f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a806 <vector155>:
ffff80000010a806:	6a 00                	push   $0x0
ffff80000010a808:	68 9b 00 00 00       	push   $0x9b
ffff80000010a80d:	e9 ce f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a812 <vector156>:
ffff80000010a812:	6a 00                	push   $0x0
ffff80000010a814:	68 9c 00 00 00       	push   $0x9c
ffff80000010a819:	e9 c2 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a81e <vector157>:
ffff80000010a81e:	6a 00                	push   $0x0
ffff80000010a820:	68 9d 00 00 00       	push   $0x9d
ffff80000010a825:	e9 b6 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a82a <vector158>:
ffff80000010a82a:	6a 00                	push   $0x0
ffff80000010a82c:	68 9e 00 00 00       	push   $0x9e
ffff80000010a831:	e9 aa f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a836 <vector159>:
ffff80000010a836:	6a 00                	push   $0x0
ffff80000010a838:	68 9f 00 00 00       	push   $0x9f
ffff80000010a83d:	e9 9e f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a842 <vector160>:
ffff80000010a842:	6a 00                	push   $0x0
ffff80000010a844:	68 a0 00 00 00       	push   $0xa0
ffff80000010a849:	e9 92 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a84e <vector161>:
ffff80000010a84e:	6a 00                	push   $0x0
ffff80000010a850:	68 a1 00 00 00       	push   $0xa1
ffff80000010a855:	e9 86 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a85a <vector162>:
ffff80000010a85a:	6a 00                	push   $0x0
ffff80000010a85c:	68 a2 00 00 00       	push   $0xa2
ffff80000010a861:	e9 7a f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a866 <vector163>:
ffff80000010a866:	6a 00                	push   $0x0
ffff80000010a868:	68 a3 00 00 00       	push   $0xa3
ffff80000010a86d:	e9 6e f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a872 <vector164>:
ffff80000010a872:	6a 00                	push   $0x0
ffff80000010a874:	68 a4 00 00 00       	push   $0xa4
ffff80000010a879:	e9 62 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a87e <vector165>:
ffff80000010a87e:	6a 00                	push   $0x0
ffff80000010a880:	68 a5 00 00 00       	push   $0xa5
ffff80000010a885:	e9 56 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a88a <vector166>:
ffff80000010a88a:	6a 00                	push   $0x0
ffff80000010a88c:	68 a6 00 00 00       	push   $0xa6
ffff80000010a891:	e9 4a f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a896 <vector167>:
ffff80000010a896:	6a 00                	push   $0x0
ffff80000010a898:	68 a7 00 00 00       	push   $0xa7
ffff80000010a89d:	e9 3e f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8a2 <vector168>:
ffff80000010a8a2:	6a 00                	push   $0x0
ffff80000010a8a4:	68 a8 00 00 00       	push   $0xa8
ffff80000010a8a9:	e9 32 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8ae <vector169>:
ffff80000010a8ae:	6a 00                	push   $0x0
ffff80000010a8b0:	68 a9 00 00 00       	push   $0xa9
ffff80000010a8b5:	e9 26 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8ba <vector170>:
ffff80000010a8ba:	6a 00                	push   $0x0
ffff80000010a8bc:	68 aa 00 00 00       	push   $0xaa
ffff80000010a8c1:	e9 1a f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8c6 <vector171>:
ffff80000010a8c6:	6a 00                	push   $0x0
ffff80000010a8c8:	68 ab 00 00 00       	push   $0xab
ffff80000010a8cd:	e9 0e f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8d2 <vector172>:
ffff80000010a8d2:	6a 00                	push   $0x0
ffff80000010a8d4:	68 ac 00 00 00       	push   $0xac
ffff80000010a8d9:	e9 02 f0 ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8de <vector173>:
ffff80000010a8de:	6a 00                	push   $0x0
ffff80000010a8e0:	68 ad 00 00 00       	push   $0xad
ffff80000010a8e5:	e9 f6 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8ea <vector174>:
ffff80000010a8ea:	6a 00                	push   $0x0
ffff80000010a8ec:	68 ae 00 00 00       	push   $0xae
ffff80000010a8f1:	e9 ea ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a8f6 <vector175>:
ffff80000010a8f6:	6a 00                	push   $0x0
ffff80000010a8f8:	68 af 00 00 00       	push   $0xaf
ffff80000010a8fd:	e9 de ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a902 <vector176>:
ffff80000010a902:	6a 00                	push   $0x0
ffff80000010a904:	68 b0 00 00 00       	push   $0xb0
ffff80000010a909:	e9 d2 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a90e <vector177>:
ffff80000010a90e:	6a 00                	push   $0x0
ffff80000010a910:	68 b1 00 00 00       	push   $0xb1
ffff80000010a915:	e9 c6 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a91a <vector178>:
ffff80000010a91a:	6a 00                	push   $0x0
ffff80000010a91c:	68 b2 00 00 00       	push   $0xb2
ffff80000010a921:	e9 ba ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a926 <vector179>:
ffff80000010a926:	6a 00                	push   $0x0
ffff80000010a928:	68 b3 00 00 00       	push   $0xb3
ffff80000010a92d:	e9 ae ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a932 <vector180>:
ffff80000010a932:	6a 00                	push   $0x0
ffff80000010a934:	68 b4 00 00 00       	push   $0xb4
ffff80000010a939:	e9 a2 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a93e <vector181>:
ffff80000010a93e:	6a 00                	push   $0x0
ffff80000010a940:	68 b5 00 00 00       	push   $0xb5
ffff80000010a945:	e9 96 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a94a <vector182>:
ffff80000010a94a:	6a 00                	push   $0x0
ffff80000010a94c:	68 b6 00 00 00       	push   $0xb6
ffff80000010a951:	e9 8a ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a956 <vector183>:
ffff80000010a956:	6a 00                	push   $0x0
ffff80000010a958:	68 b7 00 00 00       	push   $0xb7
ffff80000010a95d:	e9 7e ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a962 <vector184>:
ffff80000010a962:	6a 00                	push   $0x0
ffff80000010a964:	68 b8 00 00 00       	push   $0xb8
ffff80000010a969:	e9 72 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a96e <vector185>:
ffff80000010a96e:	6a 00                	push   $0x0
ffff80000010a970:	68 b9 00 00 00       	push   $0xb9
ffff80000010a975:	e9 66 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a97a <vector186>:
ffff80000010a97a:	6a 00                	push   $0x0
ffff80000010a97c:	68 ba 00 00 00       	push   $0xba
ffff80000010a981:	e9 5a ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a986 <vector187>:
ffff80000010a986:	6a 00                	push   $0x0
ffff80000010a988:	68 bb 00 00 00       	push   $0xbb
ffff80000010a98d:	e9 4e ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a992 <vector188>:
ffff80000010a992:	6a 00                	push   $0x0
ffff80000010a994:	68 bc 00 00 00       	push   $0xbc
ffff80000010a999:	e9 42 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a99e <vector189>:
ffff80000010a99e:	6a 00                	push   $0x0
ffff80000010a9a0:	68 bd 00 00 00       	push   $0xbd
ffff80000010a9a5:	e9 36 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9aa <vector190>:
ffff80000010a9aa:	6a 00                	push   $0x0
ffff80000010a9ac:	68 be 00 00 00       	push   $0xbe
ffff80000010a9b1:	e9 2a ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9b6 <vector191>:
ffff80000010a9b6:	6a 00                	push   $0x0
ffff80000010a9b8:	68 bf 00 00 00       	push   $0xbf
ffff80000010a9bd:	e9 1e ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9c2 <vector192>:
ffff80000010a9c2:	6a 00                	push   $0x0
ffff80000010a9c4:	68 c0 00 00 00       	push   $0xc0
ffff80000010a9c9:	e9 12 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9ce <vector193>:
ffff80000010a9ce:	6a 00                	push   $0x0
ffff80000010a9d0:	68 c1 00 00 00       	push   $0xc1
ffff80000010a9d5:	e9 06 ef ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9da <vector194>:
ffff80000010a9da:	6a 00                	push   $0x0
ffff80000010a9dc:	68 c2 00 00 00       	push   $0xc2
ffff80000010a9e1:	e9 fa ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9e6 <vector195>:
ffff80000010a9e6:	6a 00                	push   $0x0
ffff80000010a9e8:	68 c3 00 00 00       	push   $0xc3
ffff80000010a9ed:	e9 ee ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9f2 <vector196>:
ffff80000010a9f2:	6a 00                	push   $0x0
ffff80000010a9f4:	68 c4 00 00 00       	push   $0xc4
ffff80000010a9f9:	e9 e2 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010a9fe <vector197>:
ffff80000010a9fe:	6a 00                	push   $0x0
ffff80000010aa00:	68 c5 00 00 00       	push   $0xc5
ffff80000010aa05:	e9 d6 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa0a <vector198>:
ffff80000010aa0a:	6a 00                	push   $0x0
ffff80000010aa0c:	68 c6 00 00 00       	push   $0xc6
ffff80000010aa11:	e9 ca ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa16 <vector199>:
ffff80000010aa16:	6a 00                	push   $0x0
ffff80000010aa18:	68 c7 00 00 00       	push   $0xc7
ffff80000010aa1d:	e9 be ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa22 <vector200>:
ffff80000010aa22:	6a 00                	push   $0x0
ffff80000010aa24:	68 c8 00 00 00       	push   $0xc8
ffff80000010aa29:	e9 b2 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa2e <vector201>:
ffff80000010aa2e:	6a 00                	push   $0x0
ffff80000010aa30:	68 c9 00 00 00       	push   $0xc9
ffff80000010aa35:	e9 a6 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa3a <vector202>:
ffff80000010aa3a:	6a 00                	push   $0x0
ffff80000010aa3c:	68 ca 00 00 00       	push   $0xca
ffff80000010aa41:	e9 9a ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa46 <vector203>:
ffff80000010aa46:	6a 00                	push   $0x0
ffff80000010aa48:	68 cb 00 00 00       	push   $0xcb
ffff80000010aa4d:	e9 8e ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa52 <vector204>:
ffff80000010aa52:	6a 00                	push   $0x0
ffff80000010aa54:	68 cc 00 00 00       	push   $0xcc
ffff80000010aa59:	e9 82 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa5e <vector205>:
ffff80000010aa5e:	6a 00                	push   $0x0
ffff80000010aa60:	68 cd 00 00 00       	push   $0xcd
ffff80000010aa65:	e9 76 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa6a <vector206>:
ffff80000010aa6a:	6a 00                	push   $0x0
ffff80000010aa6c:	68 ce 00 00 00       	push   $0xce
ffff80000010aa71:	e9 6a ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa76 <vector207>:
ffff80000010aa76:	6a 00                	push   $0x0
ffff80000010aa78:	68 cf 00 00 00       	push   $0xcf
ffff80000010aa7d:	e9 5e ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa82 <vector208>:
ffff80000010aa82:	6a 00                	push   $0x0
ffff80000010aa84:	68 d0 00 00 00       	push   $0xd0
ffff80000010aa89:	e9 52 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa8e <vector209>:
ffff80000010aa8e:	6a 00                	push   $0x0
ffff80000010aa90:	68 d1 00 00 00       	push   $0xd1
ffff80000010aa95:	e9 46 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aa9a <vector210>:
ffff80000010aa9a:	6a 00                	push   $0x0
ffff80000010aa9c:	68 d2 00 00 00       	push   $0xd2
ffff80000010aaa1:	e9 3a ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aaa6 <vector211>:
ffff80000010aaa6:	6a 00                	push   $0x0
ffff80000010aaa8:	68 d3 00 00 00       	push   $0xd3
ffff80000010aaad:	e9 2e ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aab2 <vector212>:
ffff80000010aab2:	6a 00                	push   $0x0
ffff80000010aab4:	68 d4 00 00 00       	push   $0xd4
ffff80000010aab9:	e9 22 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aabe <vector213>:
ffff80000010aabe:	6a 00                	push   $0x0
ffff80000010aac0:	68 d5 00 00 00       	push   $0xd5
ffff80000010aac5:	e9 16 ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aaca <vector214>:
ffff80000010aaca:	6a 00                	push   $0x0
ffff80000010aacc:	68 d6 00 00 00       	push   $0xd6
ffff80000010aad1:	e9 0a ee ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aad6 <vector215>:
ffff80000010aad6:	6a 00                	push   $0x0
ffff80000010aad8:	68 d7 00 00 00       	push   $0xd7
ffff80000010aadd:	e9 fe ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aae2 <vector216>:
ffff80000010aae2:	6a 00                	push   $0x0
ffff80000010aae4:	68 d8 00 00 00       	push   $0xd8
ffff80000010aae9:	e9 f2 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aaee <vector217>:
ffff80000010aaee:	6a 00                	push   $0x0
ffff80000010aaf0:	68 d9 00 00 00       	push   $0xd9
ffff80000010aaf5:	e9 e6 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aafa <vector218>:
ffff80000010aafa:	6a 00                	push   $0x0
ffff80000010aafc:	68 da 00 00 00       	push   $0xda
ffff80000010ab01:	e9 da ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab06 <vector219>:
ffff80000010ab06:	6a 00                	push   $0x0
ffff80000010ab08:	68 db 00 00 00       	push   $0xdb
ffff80000010ab0d:	e9 ce ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab12 <vector220>:
ffff80000010ab12:	6a 00                	push   $0x0
ffff80000010ab14:	68 dc 00 00 00       	push   $0xdc
ffff80000010ab19:	e9 c2 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab1e <vector221>:
ffff80000010ab1e:	6a 00                	push   $0x0
ffff80000010ab20:	68 dd 00 00 00       	push   $0xdd
ffff80000010ab25:	e9 b6 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab2a <vector222>:
ffff80000010ab2a:	6a 00                	push   $0x0
ffff80000010ab2c:	68 de 00 00 00       	push   $0xde
ffff80000010ab31:	e9 aa ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab36 <vector223>:
ffff80000010ab36:	6a 00                	push   $0x0
ffff80000010ab38:	68 df 00 00 00       	push   $0xdf
ffff80000010ab3d:	e9 9e ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab42 <vector224>:
ffff80000010ab42:	6a 00                	push   $0x0
ffff80000010ab44:	68 e0 00 00 00       	push   $0xe0
ffff80000010ab49:	e9 92 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab4e <vector225>:
ffff80000010ab4e:	6a 00                	push   $0x0
ffff80000010ab50:	68 e1 00 00 00       	push   $0xe1
ffff80000010ab55:	e9 86 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab5a <vector226>:
ffff80000010ab5a:	6a 00                	push   $0x0
ffff80000010ab5c:	68 e2 00 00 00       	push   $0xe2
ffff80000010ab61:	e9 7a ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab66 <vector227>:
ffff80000010ab66:	6a 00                	push   $0x0
ffff80000010ab68:	68 e3 00 00 00       	push   $0xe3
ffff80000010ab6d:	e9 6e ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab72 <vector228>:
ffff80000010ab72:	6a 00                	push   $0x0
ffff80000010ab74:	68 e4 00 00 00       	push   $0xe4
ffff80000010ab79:	e9 62 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab7e <vector229>:
ffff80000010ab7e:	6a 00                	push   $0x0
ffff80000010ab80:	68 e5 00 00 00       	push   $0xe5
ffff80000010ab85:	e9 56 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab8a <vector230>:
ffff80000010ab8a:	6a 00                	push   $0x0
ffff80000010ab8c:	68 e6 00 00 00       	push   $0xe6
ffff80000010ab91:	e9 4a ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ab96 <vector231>:
ffff80000010ab96:	6a 00                	push   $0x0
ffff80000010ab98:	68 e7 00 00 00       	push   $0xe7
ffff80000010ab9d:	e9 3e ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010aba2 <vector232>:
ffff80000010aba2:	6a 00                	push   $0x0
ffff80000010aba4:	68 e8 00 00 00       	push   $0xe8
ffff80000010aba9:	e9 32 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abae <vector233>:
ffff80000010abae:	6a 00                	push   $0x0
ffff80000010abb0:	68 e9 00 00 00       	push   $0xe9
ffff80000010abb5:	e9 26 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abba <vector234>:
ffff80000010abba:	6a 00                	push   $0x0
ffff80000010abbc:	68 ea 00 00 00       	push   $0xea
ffff80000010abc1:	e9 1a ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abc6 <vector235>:
ffff80000010abc6:	6a 00                	push   $0x0
ffff80000010abc8:	68 eb 00 00 00       	push   $0xeb
ffff80000010abcd:	e9 0e ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abd2 <vector236>:
ffff80000010abd2:	6a 00                	push   $0x0
ffff80000010abd4:	68 ec 00 00 00       	push   $0xec
ffff80000010abd9:	e9 02 ed ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abde <vector237>:
ffff80000010abde:	6a 00                	push   $0x0
ffff80000010abe0:	68 ed 00 00 00       	push   $0xed
ffff80000010abe5:	e9 f6 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abea <vector238>:
ffff80000010abea:	6a 00                	push   $0x0
ffff80000010abec:	68 ee 00 00 00       	push   $0xee
ffff80000010abf1:	e9 ea ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010abf6 <vector239>:
ffff80000010abf6:	6a 00                	push   $0x0
ffff80000010abf8:	68 ef 00 00 00       	push   $0xef
ffff80000010abfd:	e9 de ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac02 <vector240>:
ffff80000010ac02:	6a 00                	push   $0x0
ffff80000010ac04:	68 f0 00 00 00       	push   $0xf0
ffff80000010ac09:	e9 d2 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac0e <vector241>:
ffff80000010ac0e:	6a 00                	push   $0x0
ffff80000010ac10:	68 f1 00 00 00       	push   $0xf1
ffff80000010ac15:	e9 c6 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac1a <vector242>:
ffff80000010ac1a:	6a 00                	push   $0x0
ffff80000010ac1c:	68 f2 00 00 00       	push   $0xf2
ffff80000010ac21:	e9 ba ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac26 <vector243>:
ffff80000010ac26:	6a 00                	push   $0x0
ffff80000010ac28:	68 f3 00 00 00       	push   $0xf3
ffff80000010ac2d:	e9 ae ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac32 <vector244>:
ffff80000010ac32:	6a 00                	push   $0x0
ffff80000010ac34:	68 f4 00 00 00       	push   $0xf4
ffff80000010ac39:	e9 a2 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac3e <vector245>:
ffff80000010ac3e:	6a 00                	push   $0x0
ffff80000010ac40:	68 f5 00 00 00       	push   $0xf5
ffff80000010ac45:	e9 96 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac4a <vector246>:
ffff80000010ac4a:	6a 00                	push   $0x0
ffff80000010ac4c:	68 f6 00 00 00       	push   $0xf6
ffff80000010ac51:	e9 8a ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac56 <vector247>:
ffff80000010ac56:	6a 00                	push   $0x0
ffff80000010ac58:	68 f7 00 00 00       	push   $0xf7
ffff80000010ac5d:	e9 7e ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac62 <vector248>:
ffff80000010ac62:	6a 00                	push   $0x0
ffff80000010ac64:	68 f8 00 00 00       	push   $0xf8
ffff80000010ac69:	e9 72 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac6e <vector249>:
ffff80000010ac6e:	6a 00                	push   $0x0
ffff80000010ac70:	68 f9 00 00 00       	push   $0xf9
ffff80000010ac75:	e9 66 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac7a <vector250>:
ffff80000010ac7a:	6a 00                	push   $0x0
ffff80000010ac7c:	68 fa 00 00 00       	push   $0xfa
ffff80000010ac81:	e9 5a ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac86 <vector251>:
ffff80000010ac86:	6a 00                	push   $0x0
ffff80000010ac88:	68 fb 00 00 00       	push   $0xfb
ffff80000010ac8d:	e9 4e ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac92 <vector252>:
ffff80000010ac92:	6a 00                	push   $0x0
ffff80000010ac94:	68 fc 00 00 00       	push   $0xfc
ffff80000010ac99:	e9 42 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010ac9e <vector253>:
ffff80000010ac9e:	6a 00                	push   $0x0
ffff80000010aca0:	68 fd 00 00 00       	push   $0xfd
ffff80000010aca5:	e9 36 ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010acaa <vector254>:
ffff80000010acaa:	6a 00                	push   $0x0
ffff80000010acac:	68 fe 00 00 00       	push   $0xfe
ffff80000010acb1:	e9 2a ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010acb6 <vector255>:
ffff80000010acb6:	6a 00                	push   $0x0
ffff80000010acb8:	68 ff 00 00 00       	push   $0xff
ffff80000010acbd:	e9 1e ec ff ff       	jmp    ffff8000001098e0 <alltraps>

ffff80000010acc2 <lgdt>:
ffff80000010acc2:	55                   	push   %rbp
ffff80000010acc3:	48 89 e5             	mov    %rsp,%rbp
ffff80000010acc6:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010acca:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010acce:	89 75 d4             	mov    %esi,-0x2c(%rbp)
ffff80000010acd1:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010acd5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010acd9:	8b 45 d4             	mov    -0x2c(%rbp),%eax
ffff80000010acdc:	83 e8 01             	sub    $0x1,%eax
ffff80000010acdf:	66 89 45 ee          	mov    %ax,-0x12(%rbp)
ffff80000010ace3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ace7:	66 89 45 f0          	mov    %ax,-0x10(%rbp)
ffff80000010aceb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010acef:	48 c1 e8 10          	shr    $0x10,%rax
ffff80000010acf3:	66 89 45 f2          	mov    %ax,-0xe(%rbp)
ffff80000010acf7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010acfb:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010acff:	66 89 45 f4          	mov    %ax,-0xc(%rbp)
ffff80000010ad03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ad07:	48 c1 e8 30          	shr    $0x30,%rax
ffff80000010ad0b:	66 89 45 f6          	mov    %ax,-0xa(%rbp)
ffff80000010ad0f:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
ffff80000010ad13:	0f 01 10             	lgdt   (%rax)
ffff80000010ad16:	90                   	nop
ffff80000010ad17:	c9                   	leave
ffff80000010ad18:	c3                   	ret

ffff80000010ad19 <ltr>:
ffff80000010ad19:	55                   	push   %rbp
ffff80000010ad1a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ad1d:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ad21:	89 f8                	mov    %edi,%eax
ffff80000010ad23:	66 89 45 fc          	mov    %ax,-0x4(%rbp)
ffff80000010ad27:	0f b7 45 fc          	movzwl -0x4(%rbp),%eax
ffff80000010ad2b:	0f 00 d8             	ltr    %eax
ffff80000010ad2e:	90                   	nop
ffff80000010ad2f:	c9                   	leave
ffff80000010ad30:	c3                   	ret

ffff80000010ad31 <lcr3>:
ffff80000010ad31:	55                   	push   %rbp
ffff80000010ad32:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ad35:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ad39:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010ad3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ad41:	0f 22 d8             	mov    %rax,%cr3
ffff80000010ad44:	90                   	nop
ffff80000010ad45:	c9                   	leave
ffff80000010ad46:	c3                   	ret

ffff80000010ad47 <v2p>:
ffff80000010ad47:	55                   	push   %rbp
ffff80000010ad48:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ad4b:	48 83 ec 08          	sub    $0x8,%rsp
ffff80000010ad4f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
ffff80000010ad53:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ad57:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ad5e:	80 00 00 
ffff80000010ad61:	48 01 d0             	add    %rdx,%rax
ffff80000010ad64:	c9                   	leave
ffff80000010ad65:	c3                   	ret

ffff80000010ad66 <syscallinit>:
ffff80000010ad66:	55                   	push   %rbp
ffff80000010ad67:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ad6a:	48 b8 00 00 00 00 08 	movabs $0x1b000800000000,%rax
ffff80000010ad71:	00 1b 00 
ffff80000010ad74:	48 89 c6             	mov    %rax,%rsi
ffff80000010ad77:	bf 81 00 00 c0       	mov    $0xc0000081,%edi
ffff80000010ad7c:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ad83:	80 ff ff 
ffff80000010ad86:	ff d0                	call   *%rax
ffff80000010ad88:	48 b8 1c 99 10 00 00 	movabs $0xffff80000010991c,%rax
ffff80000010ad8f:	80 ff ff 
ffff80000010ad92:	48 89 c6             	mov    %rax,%rsi
ffff80000010ad95:	bf 82 00 00 c0       	mov    $0xc0000082,%edi
ffff80000010ad9a:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ada1:	80 ff ff 
ffff80000010ada4:	ff d0                	call   *%rax
ffff80000010ada6:	48 b8 11 01 10 00 00 	movabs $0xffff800000100111,%rax
ffff80000010adad:	80 ff ff 
ffff80000010adb0:	48 89 c6             	mov    %rax,%rsi
ffff80000010adb3:	bf 83 00 00 c0       	mov    $0xc0000083,%edi
ffff80000010adb8:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010adbf:	80 ff ff 
ffff80000010adc2:	ff d0                	call   *%rax
ffff80000010adc4:	be 00 77 04 00       	mov    $0x47700,%esi
ffff80000010adc9:	bf 84 00 00 c0       	mov    $0xc0000084,%edi
ffff80000010adce:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010add5:	80 ff ff 
ffff80000010add8:	ff d0                	call   *%rax
ffff80000010adda:	90                   	nop
ffff80000010addb:	5d                   	pop    %rbp
ffff80000010addc:	c3                   	ret

ffff80000010addd <seginit>:
ffff80000010addd:	55                   	push   %rbp
ffff80000010adde:	48 89 e5             	mov    %rsp,%rbp
ffff80000010ade1:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010ade5:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010adec:	80 ff ff 
ffff80000010adef:	ff d0                	call   *%rax
ffff80000010adf1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010adf5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010adf9:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010adfe:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ae03:	48 89 c7             	mov    %rax,%rdi
ffff80000010ae06:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010ae0d:	80 ff ff 
ffff80000010ae10:	ff d0                	call   *%rax
ffff80000010ae12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ae16:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010ae1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ae1e:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010ae24:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010ae28:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ae2c:	48 83 c0 40          	add    $0x40,%rax
ffff80000010ae30:	c7 00 00 00 68 00    	movl   $0x680000,(%rax)
ffff80000010ae36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010ae3a:	48 05 00 08 00 00    	add    $0x800,%rax
ffff80000010ae40:	48 89 c6             	mov    %rax,%rsi
ffff80000010ae43:	bf 00 01 00 c0       	mov    $0xc0000100,%edi
ffff80000010ae48:	48 b8 01 01 10 00 00 	movabs $0xffff800000100101,%rax
ffff80000010ae4f:	80 ff ff 
ffff80000010ae52:	ff d0                	call   *%rax
ffff80000010ae54:	48 b8 89 48 10 00 00 	movabs $0xffff800000104889,%rax
ffff80000010ae5b:	80 ff ff 
ffff80000010ae5e:	ff d0                	call   *%rax
ffff80000010ae60:	48 63 d0             	movslq %eax,%rdx
ffff80000010ae63:	48 89 d0             	mov    %rdx,%rax
ffff80000010ae66:	48 c1 e0 02          	shl    $0x2,%rax
ffff80000010ae6a:	48 01 d0             	add    %rdx,%rax
ffff80000010ae6d:	48 c1 e0 03          	shl    $0x3,%rax
ffff80000010ae71:	48 ba e0 82 11 00 00 	movabs $0xffff8000001182e0,%rdx
ffff80000010ae78:	80 ff ff 
ffff80000010ae7b:	48 01 d0             	add    %rdx,%rax
ffff80000010ae7e:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010ae82:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010ae86:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010ae8a:	48 89 50 20          	mov    %rdx,0x20(%rax)
ffff80000010ae8e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010ae92:	64 48 89 04 25 f0 ff 	mov    %rax,%fs:0xfffffffffffffff0
ffff80000010ae99:	ff ff 
ffff80000010ae9b:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
ffff80000010aea2:	ff ff 00 00 00 00 
ffff80000010aea8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010aeac:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010aeb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aeb4:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff80000010aebb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010aebf:	48 83 c0 08          	add    $0x8,%rax
ffff80000010aec3:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010aec8:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010aece:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010aed2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aed6:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010aed9:	83 ca 0a             	or     $0xa,%edx
ffff80000010aedc:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aedf:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aee3:	83 ca 10             	or     $0x10,%edx
ffff80000010aee6:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aee9:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aeed:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010aef0:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aef3:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aef7:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aefa:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aefd:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af01:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af04:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af07:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af0b:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010af0e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af11:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af15:	83 ca 20             	or     $0x20,%edx
ffff80000010af18:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af1b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af1f:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010af22:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af25:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af29:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010af2c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af2f:	c6 40 07 00          	movb   $0x0,0x7(%rax)
ffff80000010af33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010af37:	48 83 c0 10          	add    $0x10,%rax
ffff80000010af3b:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010af40:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010af46:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010af4a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af4e:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af51:	83 ca 02             	or     $0x2,%edx
ffff80000010af54:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af57:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af5b:	83 ca 10             	or     $0x10,%edx
ffff80000010af5e:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af61:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af65:	83 e2 9f             	and    $0xffffff9f,%edx
ffff80000010af68:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af6b:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010af6f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010af72:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010af75:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af79:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010af7c:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af7f:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af83:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010af86:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af89:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af8d:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010af90:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af93:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010af97:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010af9a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010af9d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010afa1:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010afa4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010afa7:	c6 40 07 00          	movb   $0x0,0x7(%rax)
ffff80000010afab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010afaf:	48 83 c0 18          	add    $0x18,%rax
ffff80000010afb3:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff80000010afba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010afbe:	48 83 c0 20          	add    $0x20,%rax
ffff80000010afc2:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010afc7:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010afcd:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010afd1:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010afd5:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010afd8:	83 ca 02             	or     $0x2,%edx
ffff80000010afdb:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010afde:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010afe2:	83 ca 10             	or     $0x10,%edx
ffff80000010afe5:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010afe8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010afec:	83 ca 60             	or     $0x60,%edx
ffff80000010afef:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010aff2:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010aff6:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010aff9:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010affc:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b000:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b003:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b006:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b00a:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b00d:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b010:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b014:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b017:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b01a:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b01e:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b021:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b024:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b028:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b02b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b02e:	c6 40 07 00          	movb   $0x0,0x7(%rax)
ffff80000010b032:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b036:	48 83 c0 28          	add    $0x28,%rax
ffff80000010b03a:	66 c7 00 00 00       	movw   $0x0,(%rax)
ffff80000010b03f:	66 c7 40 02 00 00    	movw   $0x0,0x2(%rax)
ffff80000010b045:	c6 40 04 00          	movb   $0x0,0x4(%rax)
ffff80000010b049:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b04d:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b050:	83 ca 0a             	or     $0xa,%edx
ffff80000010b053:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b056:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b05a:	83 ca 10             	or     $0x10,%edx
ffff80000010b05d:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b060:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b064:	83 ca 60             	or     $0x60,%edx
ffff80000010b067:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b06a:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b06e:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b071:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b074:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b078:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b07b:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b07e:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b082:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b085:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b088:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b08c:	83 ca 20             	or     $0x20,%edx
ffff80000010b08f:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b092:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b096:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b099:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b09c:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b0a0:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b0a3:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b0a6:	c6 40 07 00          	movb   $0x0,0x7(%rax)
ffff80000010b0aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0ae:	48 83 c0 30          	add    $0x30,%rax
ffff80000010b0b2:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff80000010b0b9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b0bd:	48 83 c0 38          	add    $0x38,%rax
ffff80000010b0c1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b0c5:	89 d7                	mov    %edx,%edi
ffff80000010b0c7:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b0cb:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b0cf:	89 d6                	mov    %edx,%esi
ffff80000010b0d1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b0d5:	48 c1 ea 18          	shr    $0x18,%rdx
ffff80000010b0d9:	89 d1                	mov    %edx,%ecx
ffff80000010b0db:	66 c7 00 0b 00       	movw   $0xb,(%rax)
ffff80000010b0e0:	66 89 78 02          	mov    %di,0x2(%rax)
ffff80000010b0e4:	40 88 70 04          	mov    %sil,0x4(%rax)
ffff80000010b0e8:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0ec:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b0ef:	83 ca 09             	or     $0x9,%edx
ffff80000010b0f2:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0f5:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b0f9:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b0fc:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b0ff:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b103:	83 ca 60             	or     $0x60,%edx
ffff80000010b106:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b109:	0f b6 50 05          	movzbl 0x5(%rax),%edx
ffff80000010b10d:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b110:	88 50 05             	mov    %dl,0x5(%rax)
ffff80000010b113:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b117:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b11a:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b11d:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b121:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b124:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b127:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b12b:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b12e:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b131:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b135:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b138:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b13b:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b13f:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b142:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b145:	88 48 07             	mov    %cl,0x7(%rax)
ffff80000010b148:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b14c:	48 83 c0 40          	add    $0x40,%rax
ffff80000010b150:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b154:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b158:	41 89 d1             	mov    %edx,%r9d
ffff80000010b15b:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b15f:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b163:	41 89 d0             	mov    %edx,%r8d
ffff80000010b166:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b16a:	48 c1 ea 30          	shr    $0x30,%rdx
ffff80000010b16e:	48 c1 ea 10          	shr    $0x10,%rdx
ffff80000010b172:	89 d7                	mov    %edx,%edi
ffff80000010b174:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
ffff80000010b178:	48 c1 ea 20          	shr    $0x20,%rdx
ffff80000010b17c:	48 c1 ea 3c          	shr    $0x3c,%rdx
ffff80000010b180:	83 e2 0f             	and    $0xf,%edx
ffff80000010b183:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b187:	48 c1 e9 30          	shr    $0x30,%rcx
ffff80000010b18b:	48 c1 e9 18          	shr    $0x18,%rcx
ffff80000010b18f:	89 ce                	mov    %ecx,%esi
ffff80000010b191:	66 44 89 08          	mov    %r9w,(%rax)
ffff80000010b195:	66 44 89 40 02       	mov    %r8w,0x2(%rax)
ffff80000010b19a:	40 88 78 04          	mov    %dil,0x4(%rax)
ffff80000010b19e:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b1a2:	83 e1 f0             	and    $0xfffffff0,%ecx
ffff80000010b1a5:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b1a8:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b1ac:	83 e1 ef             	and    $0xffffffef,%ecx
ffff80000010b1af:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b1b2:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b1b6:	83 e1 9f             	and    $0xffffff9f,%ecx
ffff80000010b1b9:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b1bc:	0f b6 48 05          	movzbl 0x5(%rax),%ecx
ffff80000010b1c0:	83 c9 80             	or     $0xffffff80,%ecx
ffff80000010b1c3:	88 48 05             	mov    %cl,0x5(%rax)
ffff80000010b1c6:	89 d1                	mov    %edx,%ecx
ffff80000010b1c8:	83 e1 0f             	and    $0xf,%ecx
ffff80000010b1cb:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1cf:	83 e2 f0             	and    $0xfffffff0,%edx
ffff80000010b1d2:	09 ca                	or     %ecx,%edx
ffff80000010b1d4:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1d7:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1db:	83 e2 ef             	and    $0xffffffef,%edx
ffff80000010b1de:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1e1:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1e5:	83 e2 df             	and    $0xffffffdf,%edx
ffff80000010b1e8:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1eb:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1ef:	83 e2 bf             	and    $0xffffffbf,%edx
ffff80000010b1f2:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1f5:	0f b6 50 06          	movzbl 0x6(%rax),%edx
ffff80000010b1f9:	83 ca 80             	or     $0xffffff80,%edx
ffff80000010b1fc:	88 50 06             	mov    %dl,0x6(%rax)
ffff80000010b1ff:	40 88 70 07          	mov    %sil,0x7(%rax)
ffff80000010b203:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b207:	be 48 00 00 00       	mov    $0x48,%esi
ffff80000010b20c:	48 89 c7             	mov    %rax,%rdi
ffff80000010b20f:	48 b8 c2 ac 10 00 00 	movabs $0xffff80000010acc2,%rax
ffff80000010b216:	80 ff ff 
ffff80000010b219:	ff d0                	call   *%rax
ffff80000010b21b:	bf 38 00 00 00       	mov    $0x38,%edi
ffff80000010b220:	48 b8 19 ad 10 00 00 	movabs $0xffff80000010ad19,%rax
ffff80000010b227:	80 ff ff 
ffff80000010b22a:	ff d0                	call   *%rax
ffff80000010b22c:	90                   	nop
ffff80000010b22d:	c9                   	leave
ffff80000010b22e:	c3                   	ret

ffff80000010b22f <setupkvm>:
ffff80000010b22f:	55                   	push   %rbp
ffff80000010b230:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b233:	48 83 ec 10          	sub    $0x10,%rsp
ffff80000010b237:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b23e:	80 ff ff 
ffff80000010b241:	ff d0                	call   *%rax
ffff80000010b243:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b247:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b24b:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b250:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b255:	48 89 c7             	mov    %rax,%rdi
ffff80000010b258:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b25f:	80 ff ff 
ffff80000010b262:	ff d0                	call   *%rax
ffff80000010b264:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b26b:	80 ff ff 
ffff80000010b26e:	48 8b 00             	mov    (%rax),%rax
ffff80000010b271:	48 89 c7             	mov    %rax,%rdi
ffff80000010b274:	48 b8 47 ad 10 00 00 	movabs $0xffff80000010ad47,%rax
ffff80000010b27b:	80 ff ff 
ffff80000010b27e:	ff d0                	call   *%rax
ffff80000010b280:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
ffff80000010b284:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b28b:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b28f:	48 89 02             	mov    %rax,(%rdx)
ffff80000010b292:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b296:	c9                   	leave
ffff80000010b297:	c3                   	ret

ffff80000010b298 <kvmalloc>:
ffff80000010b298:	55                   	push   %rbp
ffff80000010b299:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b29c:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b2a3:	80 ff ff 
ffff80000010b2a6:	ff d0                	call   *%rax
ffff80000010b2a8:	48 ba 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rdx
ffff80000010b2af:	80 ff ff 
ffff80000010b2b2:	48 89 02             	mov    %rax,(%rdx)
ffff80000010b2b5:	48 b8 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rax
ffff80000010b2bc:	80 ff ff 
ffff80000010b2bf:	48 8b 00             	mov    (%rax),%rax
ffff80000010b2c2:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b2c7:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b2cc:	48 89 c7             	mov    %rax,%rdi
ffff80000010b2cf:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b2d6:	80 ff ff 
ffff80000010b2d9:	ff d0                	call   *%rax
ffff80000010b2db:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b2e2:	80 ff ff 
ffff80000010b2e5:	ff d0                	call   *%rax
ffff80000010b2e7:	48 ba 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rdx
ffff80000010b2ee:	80 ff ff 
ffff80000010b2f1:	48 89 02             	mov    %rax,(%rdx)
ffff80000010b2f4:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b2fb:	80 ff ff 
ffff80000010b2fe:	48 8b 00             	mov    (%rax),%rax
ffff80000010b301:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b306:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b30b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b30e:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b315:	80 ff ff 
ffff80000010b318:	ff d0                	call   *%rax
ffff80000010b31a:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b321:	80 ff ff 
ffff80000010b324:	48 8b 00             	mov    (%rax),%rax
ffff80000010b327:	48 89 c7             	mov    %rax,%rdi
ffff80000010b32a:	48 b8 47 ad 10 00 00 	movabs $0xffff80000010ad47,%rax
ffff80000010b331:	80 ff ff 
ffff80000010b334:	ff d0                	call   *%rax
ffff80000010b336:	48 ba 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rdx
ffff80000010b33d:	80 ff ff 
ffff80000010b340:	48 8b 12             	mov    (%rdx),%rdx
ffff80000010b343:	48 81 c2 00 08 00 00 	add    $0x800,%rdx
ffff80000010b34a:	48 83 c8 03          	or     $0x3,%rax
ffff80000010b34e:	48 89 02             	mov    %rax,(%rdx)
ffff80000010b351:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b358:	80 ff ff 
ffff80000010b35b:	48 8b 00             	mov    (%rax),%rax
ffff80000010b35e:	48 c7 00 83 00 00 00 	movq   $0x83,(%rax)
ffff80000010b365:	48 b8 60 bd 11 00 00 	movabs $0xffff80000011bd60,%rax
ffff80000010b36c:	80 ff ff 
ffff80000010b36f:	48 8b 00             	mov    (%rax),%rax
ffff80000010b372:	48 83 c0 18          	add    $0x18,%rax
ffff80000010b376:	b9 9b 00 00 c0       	mov    $0xc000009b,%ecx
ffff80000010b37b:	48 89 08             	mov    %rcx,(%rax)
ffff80000010b37e:	48 b8 99 b6 10 00 00 	movabs $0xffff80000010b699,%rax
ffff80000010b385:	80 ff ff 
ffff80000010b388:	ff d0                	call   *%rax
ffff80000010b38a:	90                   	nop
ffff80000010b38b:	5d                   	pop    %rbp
ffff80000010b38c:	c3                   	ret

ffff80000010b38d <switchuvm>:
ffff80000010b38d:	55                   	push   %rbp
ffff80000010b38e:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b391:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010b395:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b399:	48 b8 fa 78 10 00 00 	movabs $0xffff8000001078fa,%rax
ffff80000010b3a0:	80 ff ff 
ffff80000010b3a3:	ff d0                	call   *%rax
ffff80000010b3a5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b3a9:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b3ad:	48 85 c0             	test   %rax,%rax
ffff80000010b3b0:	75 19                	jne    ffff80000010b3cb <switchuvm+0x3e>
ffff80000010b3b2:	48 b8 b8 cb 10 00 00 	movabs $0xffff80000010cbb8,%rax
ffff80000010b3b9:	80 ff ff 
ffff80000010b3bc:	48 89 c7             	mov    %rax,%rdi
ffff80000010b3bf:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b3c6:	80 ff ff 
ffff80000010b3c9:	ff d0                	call   *%rax
ffff80000010b3cb:	64 48 8b 04 25 f0 ff 	mov    %fs:0xfffffffffffffff0,%rax
ffff80000010b3d2:	ff ff 
ffff80000010b3d4:	48 8b 40 20          	mov    0x20(%rax),%rax
ffff80000010b3d8:	48 05 00 04 00 00    	add    $0x400,%rax
ffff80000010b3de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b3e2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b3e6:	48 8b 40 10          	mov    0x10(%rax),%rax
ffff80000010b3ea:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010b3f0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b3f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b3f8:	48 83 c0 04          	add    $0x4,%rax
ffff80000010b3fc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
ffff80000010b400:	89 10                	mov    %edx,(%rax)
ffff80000010b402:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b406:	48 c1 e8 20          	shr    $0x20,%rax
ffff80000010b40a:	48 89 c2             	mov    %rax,%rdx
ffff80000010b40d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b411:	48 83 c0 08          	add    $0x8,%rax
ffff80000010b415:	89 10                	mov    %edx,(%rax)
ffff80000010b417:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b41b:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010b41f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b422:	48 b8 47 ad 10 00 00 	movabs $0xffff80000010ad47,%rax
ffff80000010b429:	80 ff ff 
ffff80000010b42c:	ff d0                	call   *%rax
ffff80000010b42e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b431:	48 b8 31 ad 10 00 00 	movabs $0xffff80000010ad31,%rax
ffff80000010b438:	80 ff ff 
ffff80000010b43b:	ff d0                	call   *%rax
ffff80000010b43d:	48 b8 68 79 10 00 00 	movabs $0xffff800000107968,%rax
ffff80000010b444:	80 ff ff 
ffff80000010b447:	ff d0                	call   *%rax
ffff80000010b449:	90                   	nop
ffff80000010b44a:	c9                   	leave
ffff80000010b44b:	c3                   	ret

ffff80000010b44c <walkpgdir>:
ffff80000010b44c:	55                   	push   %rbp
ffff80000010b44d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b450:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b454:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010b458:	48 89 75 c0          	mov    %rsi,-0x40(%rbp)
ffff80000010b45c:	89 55 bc             	mov    %edx,-0x44(%rbp)
ffff80000010b45f:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b463:	48 c1 e8 27          	shr    $0x27,%rax
ffff80000010b467:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b46c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b473:	00 
ffff80000010b474:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b478:	48 01 d0             	add    %rdx,%rax
ffff80000010b47b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010b47f:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b483:	48 8b 00             	mov    (%rax),%rax
ffff80000010b486:	83 e0 01             	and    $0x1,%eax
ffff80000010b489:	48 85 c0             	test   %rax,%rax
ffff80000010b48c:	74 23                	je     ffff80000010b4b1 <walkpgdir+0x65>
ffff80000010b48e:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b492:	48 8b 00             	mov    (%rax),%rax
ffff80000010b495:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b49b:	48 89 c2             	mov    %rax,%rdx
ffff80000010b49e:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b4a5:	80 ff ff 
ffff80000010b4a8:	48 01 d0             	add    %rdx,%rax
ffff80000010b4ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b4af:	eb 63                	jmp    ffff80000010b514 <walkpgdir+0xc8>
ffff80000010b4b1:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b4b5:	74 17                	je     ffff80000010b4ce <walkpgdir+0x82>
ffff80000010b4b7:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b4be:	80 ff ff 
ffff80000010b4c1:	ff d0                	call   *%rax
ffff80000010b4c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b4c7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010b4cc:	75 0a                	jne    ffff80000010b4d8 <walkpgdir+0x8c>
ffff80000010b4ce:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b4d3:	e9 bf 01 00 00       	jmp    ffff80000010b697 <walkpgdir+0x24b>
ffff80000010b4d8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b4dc:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b4e1:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b4e6:	48 89 c7             	mov    %rax,%rdi
ffff80000010b4e9:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b4f0:	80 ff ff 
ffff80000010b4f3:	ff d0                	call   *%rax
ffff80000010b4f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b4f9:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b500:	80 00 00 
ffff80000010b503:	48 01 d0             	add    %rdx,%rax
ffff80000010b506:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b50a:	48 89 c2             	mov    %rax,%rdx
ffff80000010b50d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b511:	48 89 10             	mov    %rdx,(%rax)
ffff80000010b514:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b518:	48 c1 e8 1e          	shr    $0x1e,%rax
ffff80000010b51c:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b521:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b528:	00 
ffff80000010b529:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b52d:	48 01 d0             	add    %rdx,%rax
ffff80000010b530:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010b534:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b538:	48 8b 00             	mov    (%rax),%rax
ffff80000010b53b:	83 e0 01             	and    $0x1,%eax
ffff80000010b53e:	48 85 c0             	test   %rax,%rax
ffff80000010b541:	74 23                	je     ffff80000010b566 <walkpgdir+0x11a>
ffff80000010b543:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b547:	48 8b 00             	mov    (%rax),%rax
ffff80000010b54a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b550:	48 89 c2             	mov    %rax,%rdx
ffff80000010b553:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b55a:	80 ff ff 
ffff80000010b55d:	48 01 d0             	add    %rdx,%rax
ffff80000010b560:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b564:	eb 63                	jmp    ffff80000010b5c9 <walkpgdir+0x17d>
ffff80000010b566:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b56a:	74 17                	je     ffff80000010b583 <walkpgdir+0x137>
ffff80000010b56c:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b573:	80 ff ff 
ffff80000010b576:	ff d0                	call   *%rax
ffff80000010b578:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b57c:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b581:	75 0a                	jne    ffff80000010b58d <walkpgdir+0x141>
ffff80000010b583:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b588:	e9 0a 01 00 00       	jmp    ffff80000010b697 <walkpgdir+0x24b>
ffff80000010b58d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b591:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b596:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b59b:	48 89 c7             	mov    %rax,%rdi
ffff80000010b59e:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b5a5:	80 ff ff 
ffff80000010b5a8:	ff d0                	call   *%rax
ffff80000010b5aa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b5ae:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b5b5:	80 00 00 
ffff80000010b5b8:	48 01 d0             	add    %rdx,%rax
ffff80000010b5bb:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b5bf:	48 89 c2             	mov    %rax,%rdx
ffff80000010b5c2:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b5c6:	48 89 10             	mov    %rdx,(%rax)
ffff80000010b5c9:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b5cd:	48 c1 e8 15          	shr    $0x15,%rax
ffff80000010b5d1:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b5d6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b5dd:	00 
ffff80000010b5de:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b5e2:	48 01 d0             	add    %rdx,%rax
ffff80000010b5e5:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010b5e9:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b5ed:	48 8b 00             	mov    (%rax),%rax
ffff80000010b5f0:	83 e0 01             	and    $0x1,%eax
ffff80000010b5f3:	48 85 c0             	test   %rax,%rax
ffff80000010b5f6:	74 23                	je     ffff80000010b61b <walkpgdir+0x1cf>
ffff80000010b5f8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b5fc:	48 8b 00             	mov    (%rax),%rax
ffff80000010b5ff:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b605:	48 89 c2             	mov    %rax,%rdx
ffff80000010b608:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010b60f:	80 ff ff 
ffff80000010b612:	48 01 d0             	add    %rdx,%rax
ffff80000010b615:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b619:	eb 60                	jmp    ffff80000010b67b <walkpgdir+0x22f>
ffff80000010b61b:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
ffff80000010b61f:	74 17                	je     ffff80000010b638 <walkpgdir+0x1ec>
ffff80000010b621:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b628:	80 ff ff 
ffff80000010b62b:	ff d0                	call   *%rax
ffff80000010b62d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b631:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b636:	75 07                	jne    ffff80000010b63f <walkpgdir+0x1f3>
ffff80000010b638:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b63d:	eb 58                	jmp    ffff80000010b697 <walkpgdir+0x24b>
ffff80000010b63f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b643:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b648:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b64d:	48 89 c7             	mov    %rax,%rdi
ffff80000010b650:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b657:	80 ff ff 
ffff80000010b65a:	ff d0                	call   *%rax
ffff80000010b65c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b660:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b667:	80 00 00 
ffff80000010b66a:	48 01 d0             	add    %rdx,%rax
ffff80000010b66d:	48 83 c8 07          	or     $0x7,%rax
ffff80000010b671:	48 89 c2             	mov    %rax,%rdx
ffff80000010b674:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b678:	48 89 10             	mov    %rdx,(%rax)
ffff80000010b67b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010b67f:	48 c1 e8 0c          	shr    $0xc,%rax
ffff80000010b683:	25 ff 01 00 00       	and    $0x1ff,%eax
ffff80000010b688:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010b68f:	00 
ffff80000010b690:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b694:	48 01 d0             	add    %rdx,%rax
ffff80000010b697:	c9                   	leave
ffff80000010b698:	c3                   	ret

ffff80000010b699 <switchkvm>:
ffff80000010b699:	55                   	push   %rbp
ffff80000010b69a:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b69d:	48 b8 58 bd 11 00 00 	movabs $0xffff80000011bd58,%rax
ffff80000010b6a4:	80 ff ff 
ffff80000010b6a7:	48 8b 00             	mov    (%rax),%rax
ffff80000010b6aa:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6ad:	48 b8 47 ad 10 00 00 	movabs $0xffff80000010ad47,%rax
ffff80000010b6b4:	80 ff ff 
ffff80000010b6b7:	ff d0                	call   *%rax
ffff80000010b6b9:	48 89 c7             	mov    %rax,%rdi
ffff80000010b6bc:	48 b8 31 ad 10 00 00 	movabs $0xffff80000010ad31,%rax
ffff80000010b6c3:	80 ff ff 
ffff80000010b6c6:	ff d0                	call   *%rax
ffff80000010b6c8:	90                   	nop
ffff80000010b6c9:	5d                   	pop    %rbp
ffff80000010b6ca:	c3                   	ret

ffff80000010b6cb <mappages>:
ffff80000010b6cb:	55                   	push   %rbp
ffff80000010b6cc:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b6cf:	48 83 ec 50          	sub    $0x50,%rsp
ffff80000010b6d3:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b6d7:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b6db:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b6df:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010b6e3:	44 89 45 bc          	mov    %r8d,-0x44(%rbp)
ffff80000010b6e7:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b6eb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b6f1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b6f5:	48 8b 55 d0          	mov    -0x30(%rbp),%rdx
ffff80000010b6f9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b6fd:	48 01 d0             	add    %rdx,%rax
ffff80000010b700:	48 83 e8 01          	sub    $0x1,%rax
ffff80000010b704:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b70a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b70e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010b712:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b716:	ba 01 00 00 00       	mov    $0x1,%edx
ffff80000010b71b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b71e:	48 89 c7             	mov    %rax,%rdi
ffff80000010b721:	48 b8 4c b4 10 00 00 	movabs $0xffff80000010b44c,%rax
ffff80000010b728:	80 ff ff 
ffff80000010b72b:	ff d0                	call   *%rax
ffff80000010b72d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b731:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010b736:	75 07                	jne    ffff80000010b73f <mappages+0x74>
ffff80000010b738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b73d:	eb 64                	jmp    ffff80000010b7a3 <mappages+0xd8>
ffff80000010b73f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b743:	48 8b 00             	mov    (%rax),%rax
ffff80000010b746:	83 e0 01             	and    $0x1,%eax
ffff80000010b749:	48 85 c0             	test   %rax,%rax
ffff80000010b74c:	74 19                	je     ffff80000010b767 <mappages+0x9c>
ffff80000010b74e:	48 b8 cc cb 10 00 00 	movabs $0xffff80000010cbcc,%rax
ffff80000010b755:	80 ff ff 
ffff80000010b758:	48 89 c7             	mov    %rax,%rdi
ffff80000010b75b:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b762:	80 ff ff 
ffff80000010b765:	ff d0                	call   *%rax
ffff80000010b767:	8b 45 bc             	mov    -0x44(%rbp),%eax
ffff80000010b76a:	48 98                	cltq
ffff80000010b76c:	48 0b 45 c0          	or     -0x40(%rbp),%rax
ffff80000010b770:	48 83 c8 01          	or     $0x1,%rax
ffff80000010b774:	48 89 c2             	mov    %rax,%rdx
ffff80000010b777:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b77b:	48 89 10             	mov    %rdx,(%rax)
ffff80000010b77e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b782:	48 3b 45 f0          	cmp    -0x10(%rbp),%rax
ffff80000010b786:	74 15                	je     ffff80000010b79d <mappages+0xd2>
ffff80000010b788:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010b78f:	00 
ffff80000010b790:	48 81 45 c0 00 10 00 	addq   $0x1000,-0x40(%rbp)
ffff80000010b797:	00 
ffff80000010b798:	e9 71 ff ff ff       	jmp    ffff80000010b70e <mappages+0x43>
ffff80000010b79d:	90                   	nop
ffff80000010b79e:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b7a3:	c9                   	leave
ffff80000010b7a4:	c3                   	ret

ffff80000010b7a5 <inituvm>:
ffff80000010b7a5:	55                   	push   %rbp
ffff80000010b7a6:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b7a9:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b7ad:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b7b1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b7b5:	89 55 dc             	mov    %edx,-0x24(%rbp)
ffff80000010b7b8:	81 7d dc ff 0f 00 00 	cmpl   $0xfff,-0x24(%rbp)
ffff80000010b7bf:	76 19                	jbe    ffff80000010b7da <inituvm+0x35>
ffff80000010b7c1:	48 b8 d2 cb 10 00 00 	movabs $0xffff80000010cbd2,%rax
ffff80000010b7c8:	80 ff ff 
ffff80000010b7cb:	48 89 c7             	mov    %rax,%rdi
ffff80000010b7ce:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b7d5:	80 ff ff 
ffff80000010b7d8:	ff d0                	call   *%rax
ffff80000010b7da:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b7e1:	80 ff ff 
ffff80000010b7e4:	ff d0                	call   *%rax
ffff80000010b7e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b7ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b7ee:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b7f3:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010b7f8:	48 89 c7             	mov    %rax,%rdi
ffff80000010b7fb:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010b802:	80 ff ff 
ffff80000010b805:	ff d0                	call   *%rax
ffff80000010b807:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b80b:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010b812:	80 00 00 
ffff80000010b815:	48 01 c2             	add    %rax,%rdx
ffff80000010b818:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b81c:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010b822:	48 89 d1             	mov    %rdx,%rcx
ffff80000010b825:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010b82a:	be 00 10 00 00       	mov    $0x1000,%esi
ffff80000010b82f:	48 89 c7             	mov    %rax,%rdi
ffff80000010b832:	48 b8 cb b6 10 00 00 	movabs $0xffff80000010b6cb,%rax
ffff80000010b839:	80 ff ff 
ffff80000010b83c:	ff d0                	call   *%rax
ffff80000010b83e:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010b841:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010b845:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010b849:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b84c:	48 89 c7             	mov    %rax,%rdi
ffff80000010b84f:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff80000010b856:	80 ff ff 
ffff80000010b859:	ff d0                	call   *%rax
ffff80000010b85b:	90                   	nop
ffff80000010b85c:	c9                   	leave
ffff80000010b85d:	c3                   	ret

ffff80000010b85e <loaduvm>:
ffff80000010b85e:	55                   	push   %rbp
ffff80000010b85f:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b862:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010b866:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010b86a:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010b86e:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010b872:	89 4d c4             	mov    %ecx,-0x3c(%rbp)
ffff80000010b875:	44 89 45 c0          	mov    %r8d,-0x40(%rbp)
ffff80000010b879:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b87d:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010b882:	48 85 c0             	test   %rax,%rax
ffff80000010b885:	74 19                	je     ffff80000010b8a0 <loaduvm+0x42>
ffff80000010b887:	48 b8 f0 cb 10 00 00 	movabs $0xffff80000010cbf0,%rax
ffff80000010b88e:	80 ff ff 
ffff80000010b891:	48 89 c7             	mov    %rax,%rdi
ffff80000010b894:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b89b:	80 ff ff 
ffff80000010b89e:	ff d0                	call   *%rax
ffff80000010b8a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010b8a7:	e9 c7 00 00 00       	jmp    ffff80000010b973 <loaduvm+0x115>
ffff80000010b8ac:	8b 55 fc             	mov    -0x4(%rbp),%edx
ffff80000010b8af:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010b8b3:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010b8b7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b8bb:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010b8c0:	48 89 ce             	mov    %rcx,%rsi
ffff80000010b8c3:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8c6:	48 b8 4c b4 10 00 00 	movabs $0xffff80000010b44c,%rax
ffff80000010b8cd:	80 ff ff 
ffff80000010b8d0:	ff d0                	call   *%rax
ffff80000010b8d2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b8d6:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b8db:	75 19                	jne    ffff80000010b8f6 <loaduvm+0x98>
ffff80000010b8dd:	48 b8 13 cc 10 00 00 	movabs $0xffff80000010cc13,%rax
ffff80000010b8e4:	80 ff ff 
ffff80000010b8e7:	48 89 c7             	mov    %rax,%rdi
ffff80000010b8ea:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010b8f1:	80 ff ff 
ffff80000010b8f4:	ff d0                	call   *%rax
ffff80000010b8f6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010b8fa:	48 8b 00             	mov    (%rax),%rax
ffff80000010b8fd:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b903:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010b907:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b90a:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b90d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
ffff80000010b912:	77 0b                	ja     ffff80000010b91f <loaduvm+0xc1>
ffff80000010b914:	8b 45 c0             	mov    -0x40(%rbp),%eax
ffff80000010b917:	2b 45 fc             	sub    -0x4(%rbp),%eax
ffff80000010b91a:	89 45 f8             	mov    %eax,-0x8(%rbp)
ffff80000010b91d:	eb 07                	jmp    ffff80000010b926 <loaduvm+0xc8>
ffff80000010b91f:	c7 45 f8 00 10 00 00 	movl   $0x1000,-0x8(%rbp)
ffff80000010b926:	8b 55 c4             	mov    -0x3c(%rbp),%edx
ffff80000010b929:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b92c:	8d 34 02             	lea    (%rdx,%rax,1),%esi
ffff80000010b92f:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010b936:	80 ff ff 
ffff80000010b939:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010b93d:	48 01 d0             	add    %rdx,%rax
ffff80000010b940:	48 89 c7             	mov    %rax,%rdi
ffff80000010b943:	8b 55 f8             	mov    -0x8(%rbp),%edx
ffff80000010b946:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010b94a:	89 d1                	mov    %edx,%ecx
ffff80000010b94c:	89 f2                	mov    %esi,%edx
ffff80000010b94e:	48 89 fe             	mov    %rdi,%rsi
ffff80000010b951:	48 89 c7             	mov    %rax,%rdi
ffff80000010b954:	48 b8 1d 30 10 00 00 	movabs $0xffff80000010301d,%rax
ffff80000010b95b:	80 ff ff 
ffff80000010b95e:	ff d0                	call   *%rax
ffff80000010b960:	39 45 f8             	cmp    %eax,-0x8(%rbp)
ffff80000010b963:	74 07                	je     ffff80000010b96c <loaduvm+0x10e>
ffff80000010b965:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010b96a:	eb 18                	jmp    ffff80000010b984 <loaduvm+0x126>
ffff80000010b96c:	81 45 fc 00 10 00 00 	addl   $0x1000,-0x4(%rbp)
ffff80000010b973:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010b976:	3b 45 c0             	cmp    -0x40(%rbp),%eax
ffff80000010b979:	0f 82 2d ff ff ff    	jb     ffff80000010b8ac <loaduvm+0x4e>
ffff80000010b97f:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b984:	c9                   	leave
ffff80000010b985:	c3                   	ret

ffff80000010b986 <allocuvm>:
ffff80000010b986:	55                   	push   %rbp
ffff80000010b987:	48 89 e5             	mov    %rsp,%rbp
ffff80000010b98a:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010b98e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010b992:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010b996:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
ffff80000010b99a:	48 b8 ff ff ff ff ff 	movabs $0xffff7fffffffffff,%rax
ffff80000010b9a1:	7f ff ff 
ffff80000010b9a4:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010b9a8:	73 0a                	jae    ffff80000010b9b4 <allocuvm+0x2e>
ffff80000010b9aa:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010b9af:	e9 14 01 00 00       	jmp    ffff80000010bac8 <allocuvm+0x142>
ffff80000010b9b4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010b9b8:	48 3b 45 e0          	cmp    -0x20(%rbp),%rax
ffff80000010b9bc:	73 09                	jae    ffff80000010b9c7 <allocuvm+0x41>
ffff80000010b9be:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b9c2:	e9 01 01 00 00       	jmp    ffff80000010bac8 <allocuvm+0x142>
ffff80000010b9c7:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010b9cb:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010b9d1:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010b9d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010b9db:	e9 d6 00 00 00       	jmp    ffff80000010bab6 <allocuvm+0x130>
ffff80000010b9e0:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010b9e7:	80 ff ff 
ffff80000010b9ea:	ff d0                	call   *%rax
ffff80000010b9ec:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010b9f0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010b9f5:	75 28                	jne    ffff80000010ba1f <allocuvm+0x99>
ffff80000010b9f7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010b9fb:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010b9ff:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba03:	48 89 ce             	mov    %rcx,%rsi
ffff80000010ba06:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba09:	48 b8 ca ba 10 00 00 	movabs $0xffff80000010baca,%rax
ffff80000010ba10:	80 ff ff 
ffff80000010ba13:	ff d0                	call   *%rax
ffff80000010ba15:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010ba1a:	e9 a9 00 00 00       	jmp    ffff80000010bac8 <allocuvm+0x142>
ffff80000010ba1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ba23:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ba28:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010ba2d:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba30:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010ba37:	80 ff ff 
ffff80000010ba3a:	ff d0                	call   *%rax
ffff80000010ba3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ba40:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010ba47:	80 00 00 
ffff80000010ba4a:	48 01 c2             	add    %rax,%rdx
ffff80000010ba4d:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010ba51:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba55:	41 b8 06 00 00 00    	mov    $0x6,%r8d
ffff80000010ba5b:	48 89 d1             	mov    %rdx,%rcx
ffff80000010ba5e:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010ba63:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba66:	48 b8 cb b6 10 00 00 	movabs $0xffff80000010b6cb,%rax
ffff80000010ba6d:	80 ff ff 
ffff80000010ba70:	ff d0                	call   *%rax
ffff80000010ba72:	85 c0                	test   %eax,%eax
ffff80000010ba74:	79 38                	jns    ffff80000010baae <allocuvm+0x128>
ffff80000010ba76:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
ffff80000010ba7a:	48 8b 4d d8          	mov    -0x28(%rbp),%rcx
ffff80000010ba7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010ba82:	48 89 ce             	mov    %rcx,%rsi
ffff80000010ba85:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba88:	48 b8 ca ba 10 00 00 	movabs $0xffff80000010baca,%rax
ffff80000010ba8f:	80 ff ff 
ffff80000010ba92:	ff d0                	call   *%rax
ffff80000010ba94:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010ba98:	48 89 c7             	mov    %rax,%rdi
ffff80000010ba9b:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010baa2:	80 ff ff 
ffff80000010baa5:	ff d0                	call   *%rax
ffff80000010baa7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010baac:	eb 1a                	jmp    ffff80000010bac8 <allocuvm+0x142>
ffff80000010baae:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bab5:	00 
ffff80000010bab6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010baba:	48 3b 45 d8          	cmp    -0x28(%rbp),%rax
ffff80000010babe:	0f 82 1c ff ff ff    	jb     ffff80000010b9e0 <allocuvm+0x5a>
ffff80000010bac4:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bac8:	c9                   	leave
ffff80000010bac9:	c3                   	ret

ffff80000010baca <deallocuvm>:
ffff80000010baca:	55                   	push   %rbp
ffff80000010bacb:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bace:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bad2:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010bad6:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010bada:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010bade:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bae2:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010bae6:	72 09                	jb     ffff80000010baf1 <deallocuvm+0x27>
ffff80000010bae8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010baec:	e9 d0 00 00 00       	jmp    ffff80000010bbc1 <deallocuvm+0xf7>
ffff80000010baf1:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010baf5:	48 05 ff 0f 00 00    	add    $0xfff,%rax
ffff80000010bafb:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb01:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010bb05:	e9 a5 00 00 00       	jmp    ffff80000010bbaf <deallocuvm+0xe5>
ffff80000010bb0a:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010bb0e:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bb12:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010bb17:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bb1a:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb1d:	48 b8 4c b4 10 00 00 	movabs $0xffff80000010b44c,%rax
ffff80000010bb24:	80 ff ff 
ffff80000010bb27:	ff d0                	call   *%rax
ffff80000010bb29:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010bb2d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010bb32:	74 73                	je     ffff80000010bba7 <deallocuvm+0xdd>
ffff80000010bb34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bb38:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb3b:	83 e0 01             	and    $0x1,%eax
ffff80000010bb3e:	48 85 c0             	test   %rax,%rax
ffff80000010bb41:	74 64                	je     ffff80000010bba7 <deallocuvm+0xdd>
ffff80000010bb43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bb47:	48 8b 00             	mov    (%rax),%rax
ffff80000010bb4a:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bb50:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bb54:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010bb59:	75 19                	jne    ffff80000010bb74 <deallocuvm+0xaa>
ffff80000010bb5b:	48 b8 31 cc 10 00 00 	movabs $0xffff80000010cc31,%rax
ffff80000010bb62:	80 ff ff 
ffff80000010bb65:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb68:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bb6f:	80 ff ff 
ffff80000010bb72:	ff d0                	call   *%rax
ffff80000010bb74:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bb7b:	80 ff ff 
ffff80000010bb7e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bb82:	48 01 d0             	add    %rdx,%rax
ffff80000010bb85:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010bb89:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bb8d:	48 89 c7             	mov    %rax,%rdi
ffff80000010bb90:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bb97:	80 ff ff 
ffff80000010bb9a:	ff d0                	call   *%rax
ffff80000010bb9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bba0:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
ffff80000010bba7:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bbae:	00 
ffff80000010bbaf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010bbb3:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
ffff80000010bbb7:	0f 82 4d ff ff ff    	jb     ffff80000010bb0a <deallocuvm+0x40>
ffff80000010bbbd:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bbc1:	c9                   	leave
ffff80000010bbc2:	c3                   	ret

ffff80000010bbc3 <freevm>:
ffff80000010bbc3:	55                   	push   %rbp
ffff80000010bbc4:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bbc7:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010bbcb:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010bbcf:	48 83 7d c8 00       	cmpq   $0x0,-0x38(%rbp)
ffff80000010bbd4:	75 19                	jne    ffff80000010bbef <freevm+0x2c>
ffff80000010bbd6:	48 b8 37 cc 10 00 00 	movabs $0xffff80000010cc37,%rax
ffff80000010bbdd:	80 ff ff 
ffff80000010bbe0:	48 89 c7             	mov    %rax,%rdi
ffff80000010bbe3:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bbea:	80 ff ff 
ffff80000010bbed:	ff d0                	call   *%rax
ffff80000010bbef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
ffff80000010bbf6:	e9 dc 01 00 00       	jmp    ffff80000010bdd7 <freevm+0x214>
ffff80000010bbfb:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bbfe:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc05:	00 
ffff80000010bc06:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bc0a:	48 01 d0             	add    %rdx,%rax
ffff80000010bc0d:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc10:	83 e0 01             	and    $0x1,%eax
ffff80000010bc13:	48 85 c0             	test   %rax,%rax
ffff80000010bc16:	0f 84 b7 01 00 00    	je     ffff80000010bdd3 <freevm+0x210>
ffff80000010bc1c:	8b 45 fc             	mov    -0x4(%rbp),%eax
ffff80000010bc1f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc26:	00 
ffff80000010bc27:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bc2b:	48 01 d0             	add    %rdx,%rax
ffff80000010bc2e:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc31:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bc37:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc3a:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bc41:	80 ff ff 
ffff80000010bc44:	48 01 d0             	add    %rdx,%rax
ffff80000010bc47:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bc4b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
ffff80000010bc52:	e9 5c 01 00 00       	jmp    ffff80000010bdb3 <freevm+0x1f0>
ffff80000010bc57:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010bc5a:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc61:	00 
ffff80000010bc62:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc66:	48 01 d0             	add    %rdx,%rax
ffff80000010bc69:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc6c:	83 e0 01             	and    $0x1,%eax
ffff80000010bc6f:	48 85 c0             	test   %rax,%rax
ffff80000010bc72:	0f 84 37 01 00 00    	je     ffff80000010bdaf <freevm+0x1ec>
ffff80000010bc78:	8b 45 f8             	mov    -0x8(%rbp),%eax
ffff80000010bc7b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bc82:	00 
ffff80000010bc83:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bc87:	48 01 d0             	add    %rdx,%rax
ffff80000010bc8a:	48 8b 00             	mov    (%rax),%rax
ffff80000010bc8d:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bc93:	48 89 c2             	mov    %rax,%rdx
ffff80000010bc96:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bc9d:	80 ff ff 
ffff80000010bca0:	48 01 d0             	add    %rdx,%rax
ffff80000010bca3:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010bca7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
ffff80000010bcae:	e9 dc 00 00 00       	jmp    ffff80000010bd8f <freevm+0x1cc>
ffff80000010bcb3:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bcb6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bcbd:	00 
ffff80000010bcbe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bcc2:	48 01 d0             	add    %rdx,%rax
ffff80000010bcc5:	48 8b 00             	mov    (%rax),%rax
ffff80000010bcc8:	83 e0 01             	and    $0x1,%eax
ffff80000010bccb:	48 85 c0             	test   %rax,%rax
ffff80000010bcce:	0f 84 b7 00 00 00    	je     ffff80000010bd8b <freevm+0x1c8>
ffff80000010bcd4:	8b 45 f4             	mov    -0xc(%rbp),%eax
ffff80000010bcd7:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bcde:	00 
ffff80000010bcdf:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bce3:	48 01 d0             	add    %rdx,%rax
ffff80000010bce6:	48 8b 00             	mov    (%rax),%rax
ffff80000010bce9:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bcef:	48 89 c2             	mov    %rax,%rdx
ffff80000010bcf2:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bcf9:	80 ff ff 
ffff80000010bcfc:	48 01 d0             	add    %rdx,%rax
ffff80000010bcff:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010bd03:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
ffff80000010bd0a:	eb 63                	jmp    ffff80000010bd6f <freevm+0x1ac>
ffff80000010bd0c:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bd0f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bd16:	00 
ffff80000010bd17:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bd1b:	48 01 d0             	add    %rdx,%rax
ffff80000010bd1e:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd21:	83 e0 01             	and    $0x1,%eax
ffff80000010bd24:	48 85 c0             	test   %rax,%rax
ffff80000010bd27:	74 42                	je     ffff80000010bd6b <freevm+0x1a8>
ffff80000010bd29:	8b 45 f0             	mov    -0x10(%rbp),%eax
ffff80000010bd2c:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
ffff80000010bd33:	00 
ffff80000010bd34:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bd38:	48 01 d0             	add    %rdx,%rax
ffff80000010bd3b:	48 8b 00             	mov    (%rax),%rax
ffff80000010bd3e:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bd44:	48 89 c2             	mov    %rax,%rdx
ffff80000010bd47:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010bd4e:	80 ff ff 
ffff80000010bd51:	48 01 d0             	add    %rdx,%rax
ffff80000010bd54:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010bd58:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bd5c:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd5f:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bd66:	80 ff ff 
ffff80000010bd69:	ff d0                	call   *%rax
ffff80000010bd6b:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
ffff80000010bd6f:	81 7d f0 ff 01 00 00 	cmpl   $0x1ff,-0x10(%rbp)
ffff80000010bd76:	76 94                	jbe    ffff80000010bd0c <freevm+0x149>
ffff80000010bd78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bd7c:	48 89 c7             	mov    %rax,%rdi
ffff80000010bd7f:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bd86:	80 ff ff 
ffff80000010bd89:	ff d0                	call   *%rax
ffff80000010bd8b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
ffff80000010bd8f:	81 7d f4 ff 01 00 00 	cmpl   $0x1ff,-0xc(%rbp)
ffff80000010bd96:	0f 86 17 ff ff ff    	jbe    ffff80000010bcb3 <freevm+0xf0>
ffff80000010bd9c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bda0:	48 89 c7             	mov    %rax,%rdi
ffff80000010bda3:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bdaa:	80 ff ff 
ffff80000010bdad:	ff d0                	call   *%rax
ffff80000010bdaf:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
ffff80000010bdb3:	81 7d f8 ff 01 00 00 	cmpl   $0x1ff,-0x8(%rbp)
ffff80000010bdba:	0f 86 97 fe ff ff    	jbe    ffff80000010bc57 <freevm+0x94>
ffff80000010bdc0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bdc4:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdc7:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bdce:	80 ff ff 
ffff80000010bdd1:	ff d0                	call   *%rax
ffff80000010bdd3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
ffff80000010bdd7:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%rbp)
ffff80000010bdde:	0f 86 17 fe ff ff    	jbe    ffff80000010bbfb <freevm+0x38>
ffff80000010bde4:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010bde8:	48 89 c7             	mov    %rax,%rdi
ffff80000010bdeb:	48 b8 cd 41 10 00 00 	movabs $0xffff8000001041cd,%rax
ffff80000010bdf2:	80 ff ff 
ffff80000010bdf5:	ff d0                	call   *%rax
ffff80000010bdf7:	90                   	nop
ffff80000010bdf8:	c9                   	leave
ffff80000010bdf9:	c3                   	ret

ffff80000010bdfa <clearpteu>:
ffff80000010bdfa:	55                   	push   %rbp
ffff80000010bdfb:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bdfe:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010be02:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010be06:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010be0a:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010be0e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010be12:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010be17:	48 89 ce             	mov    %rcx,%rsi
ffff80000010be1a:	48 89 c7             	mov    %rax,%rdi
ffff80000010be1d:	48 b8 4c b4 10 00 00 	movabs $0xffff80000010b44c,%rax
ffff80000010be24:	80 ff ff 
ffff80000010be27:	ff d0                	call   *%rax
ffff80000010be29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010be2d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
ffff80000010be32:	75 19                	jne    ffff80000010be4d <clearpteu+0x53>
ffff80000010be34:	48 b8 48 cc 10 00 00 	movabs $0xffff80000010cc48,%rax
ffff80000010be3b:	80 ff ff 
ffff80000010be3e:	48 89 c7             	mov    %rax,%rdi
ffff80000010be41:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010be48:	80 ff ff 
ffff80000010be4b:	ff d0                	call   *%rax
ffff80000010be4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be51:	48 8b 00             	mov    (%rax),%rax
ffff80000010be54:	48 83 e0 fb          	and    $0xfffffffffffffffb,%rax
ffff80000010be58:	48 89 c2             	mov    %rax,%rdx
ffff80000010be5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010be5f:	48 89 10             	mov    %rdx,(%rax)
ffff80000010be62:	90                   	nop
ffff80000010be63:	c9                   	leave
ffff80000010be64:	c3                   	ret

ffff80000010be65 <copyuvm>:
ffff80000010be65:	55                   	push   %rbp
ffff80000010be66:	48 89 e5             	mov    %rsp,%rbp
ffff80000010be69:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010be6d:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
ffff80000010be71:	89 75 c4             	mov    %esi,-0x3c(%rbp)
ffff80000010be74:	48 b8 2f b2 10 00 00 	movabs $0xffff80000010b22f,%rax
ffff80000010be7b:	80 ff ff 
ffff80000010be7e:	ff d0                	call   *%rax
ffff80000010be80:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010be84:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
ffff80000010be89:	75 0a                	jne    ffff80000010be95 <copyuvm+0x30>
ffff80000010be8b:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010be90:	e9 57 01 00 00       	jmp    ffff80000010bfec <copyuvm+0x187>
ffff80000010be95:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
ffff80000010be9c:	00 
ffff80000010be9d:	e9 1b 01 00 00       	jmp    ffff80000010bfbd <copyuvm+0x158>
ffff80000010bea2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
ffff80000010bea6:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010beaa:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010beaf:	48 89 ce             	mov    %rcx,%rsi
ffff80000010beb2:	48 89 c7             	mov    %rax,%rdi
ffff80000010beb5:	48 b8 4c b4 10 00 00 	movabs $0xffff80000010b44c,%rax
ffff80000010bebc:	80 ff ff 
ffff80000010bebf:	ff d0                	call   *%rax
ffff80000010bec1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010bec5:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
ffff80000010beca:	75 19                	jne    ffff80000010bee5 <copyuvm+0x80>
ffff80000010becc:	48 b8 52 cc 10 00 00 	movabs $0xffff80000010cc52,%rax
ffff80000010bed3:	80 ff ff 
ffff80000010bed6:	48 89 c7             	mov    %rax,%rdi
ffff80000010bed9:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bee0:	80 ff ff 
ffff80000010bee3:	ff d0                	call   *%rax
ffff80000010bee5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bee9:	48 8b 00             	mov    (%rax),%rax
ffff80000010beec:	83 e0 01             	and    $0x1,%eax
ffff80000010beef:	48 85 c0             	test   %rax,%rax
ffff80000010bef2:	75 19                	jne    ffff80000010bf0d <copyuvm+0xa8>
ffff80000010bef4:	48 b8 6c cc 10 00 00 	movabs $0xffff80000010cc6c,%rax
ffff80000010befb:	80 ff ff 
ffff80000010befe:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf01:	48 b8 ea 0b 10 00 00 	movabs $0xffff800000100bea,%rax
ffff80000010bf08:	80 ff ff 
ffff80000010bf0b:	ff d0                	call   *%rax
ffff80000010bf0d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bf11:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf14:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010bf1a:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010bf1e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010bf22:	48 8b 00             	mov    (%rax),%rax
ffff80000010bf25:	25 ff 0f 00 00       	and    $0xfff,%eax
ffff80000010bf2a:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
ffff80000010bf2e:	48 b8 35 43 10 00 00 	movabs $0xffff800000104335,%rax
ffff80000010bf35:	80 ff ff 
ffff80000010bf38:	ff d0                	call   *%rax
ffff80000010bf3a:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010bf3e:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010bf43:	0f 84 87 00 00 00    	je     ffff80000010bfd0 <copyuvm+0x16b>
ffff80000010bf49:	48 ba 00 00 00 00 00 	movabs $0xffff800000000000,%rdx
ffff80000010bf50:	80 ff ff 
ffff80000010bf53:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010bf57:	48 01 d0             	add    %rdx,%rax
ffff80000010bf5a:	48 89 c1             	mov    %rax,%rcx
ffff80000010bf5d:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf61:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bf66:	48 89 ce             	mov    %rcx,%rsi
ffff80000010bf69:	48 89 c7             	mov    %rax,%rdi
ffff80000010bf6c:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff80000010bf73:	80 ff ff 
ffff80000010bf76:	ff d0                	call   *%rax
ffff80000010bf78:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010bf7c:	89 c1                	mov    %eax,%ecx
ffff80000010bf7e:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010bf82:	48 ba 00 00 00 00 00 	movabs $0x800000000000,%rdx
ffff80000010bf89:	80 00 00 
ffff80000010bf8c:	48 01 c2             	add    %rax,%rdx
ffff80000010bf8f:	48 8b 75 f8          	mov    -0x8(%rbp),%rsi
ffff80000010bf93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bf97:	41 89 c8             	mov    %ecx,%r8d
ffff80000010bf9a:	48 89 d1             	mov    %rdx,%rcx
ffff80000010bf9d:	ba 00 10 00 00       	mov    $0x1000,%edx
ffff80000010bfa2:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfa5:	48 b8 cb b6 10 00 00 	movabs $0xffff80000010b6cb,%rax
ffff80000010bfac:	80 ff ff 
ffff80000010bfaf:	ff d0                	call   *%rax
ffff80000010bfb1:	85 c0                	test   %eax,%eax
ffff80000010bfb3:	78 1e                	js     ffff80000010bfd3 <copyuvm+0x16e>
ffff80000010bfb5:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
ffff80000010bfbc:	00 
ffff80000010bfbd:	8b 45 c4             	mov    -0x3c(%rbp),%eax
ffff80000010bfc0:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
ffff80000010bfc4:	0f 82 d8 fe ff ff    	jb     ffff80000010bea2 <copyuvm+0x3d>
ffff80000010bfca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bfce:	eb 1c                	jmp    ffff80000010bfec <copyuvm+0x187>
ffff80000010bfd0:	90                   	nop
ffff80000010bfd1:	eb 01                	jmp    ffff80000010bfd4 <copyuvm+0x16f>
ffff80000010bfd3:	90                   	nop
ffff80000010bfd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010bfd8:	48 89 c7             	mov    %rax,%rdi
ffff80000010bfdb:	48 b8 c3 bb 10 00 00 	movabs $0xffff80000010bbc3,%rax
ffff80000010bfe2:	80 ff ff 
ffff80000010bfe5:	ff d0                	call   *%rax
ffff80000010bfe7:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010bfec:	c9                   	leave
ffff80000010bfed:	c3                   	ret

ffff80000010bfee <uva2ka>:
ffff80000010bfee:	55                   	push   %rbp
ffff80000010bfef:	48 89 e5             	mov    %rsp,%rbp
ffff80000010bff2:	48 83 ec 20          	sub    $0x20,%rsp
ffff80000010bff6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
ffff80000010bffa:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
ffff80000010bffe:	48 8b 4d e0          	mov    -0x20(%rbp),%rcx
ffff80000010c002:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c006:	ba 00 00 00 00       	mov    $0x0,%edx
ffff80000010c00b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c00e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c011:	48 b8 4c b4 10 00 00 	movabs $0xffff80000010b44c,%rax
ffff80000010c018:	80 ff ff 
ffff80000010c01b:	ff d0                	call   *%rax
ffff80000010c01d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010c021:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c025:	48 8b 00             	mov    (%rax),%rax
ffff80000010c028:	83 e0 01             	and    $0x1,%eax
ffff80000010c02b:	48 85 c0             	test   %rax,%rax
ffff80000010c02e:	75 07                	jne    ffff80000010c037 <uva2ka+0x49>
ffff80000010c030:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c035:	eb 33                	jmp    ffff80000010c06a <uva2ka+0x7c>
ffff80000010c037:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c03b:	48 8b 00             	mov    (%rax),%rax
ffff80000010c03e:	83 e0 04             	and    $0x4,%eax
ffff80000010c041:	48 85 c0             	test   %rax,%rax
ffff80000010c044:	75 07                	jne    ffff80000010c04d <uva2ka+0x5f>
ffff80000010c046:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c04b:	eb 1d                	jmp    ffff80000010c06a <uva2ka+0x7c>
ffff80000010c04d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c051:	48 8b 00             	mov    (%rax),%rax
ffff80000010c054:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c05a:	48 89 c2             	mov    %rax,%rdx
ffff80000010c05d:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
ffff80000010c064:	80 ff ff 
ffff80000010c067:	48 01 d0             	add    %rdx,%rax
ffff80000010c06a:	c9                   	leave
ffff80000010c06b:	c3                   	ret

ffff80000010c06c <copyout>:
ffff80000010c06c:	55                   	push   %rbp
ffff80000010c06d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c070:	48 83 ec 40          	sub    $0x40,%rsp
ffff80000010c074:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
ffff80000010c078:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
ffff80000010c07c:	48 89 55 c8          	mov    %rdx,-0x38(%rbp)
ffff80000010c080:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010c084:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
ffff80000010c088:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
ffff80000010c08c:	e9 b0 00 00 00       	jmp    ffff80000010c141 <copyout+0xd5>
ffff80000010c091:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c095:	48 25 00 f0 ff ff    	and    $0xfffffffffffff000,%rax
ffff80000010c09b:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
ffff80000010c09f:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
ffff80000010c0a3:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
ffff80000010c0a7:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c0aa:	48 89 c7             	mov    %rax,%rdi
ffff80000010c0ad:	48 b8 ee bf 10 00 00 	movabs $0xffff80000010bfee,%rax
ffff80000010c0b4:	80 ff ff 
ffff80000010c0b7:	ff d0                	call   *%rax
ffff80000010c0b9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010c0bd:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
ffff80000010c0c2:	75 0a                	jne    ffff80000010c0ce <copyout+0x62>
ffff80000010c0c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c0c9:	e9 83 00 00 00       	jmp    ffff80000010c151 <copyout+0xe5>
ffff80000010c0ce:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c0d2:	48 2b 45 d0          	sub    -0x30(%rbp),%rax
ffff80000010c0d6:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c0dc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c0e0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c0e4:	48 39 45 c0          	cmp    %rax,-0x40(%rbp)
ffff80000010c0e8:	73 08                	jae    ffff80000010c0f2 <copyout+0x86>
ffff80000010c0ea:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
ffff80000010c0ee:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
ffff80000010c0f2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c0f6:	89 c6                	mov    %eax,%esi
ffff80000010c0f8:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c0fc:	48 2b 45 e8          	sub    -0x18(%rbp),%rax
ffff80000010c100:	48 89 c2             	mov    %rax,%rdx
ffff80000010c103:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
ffff80000010c107:	48 8d 0c 02          	lea    (%rdx,%rax,1),%rcx
ffff80000010c10b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c10f:	89 f2                	mov    %esi,%edx
ffff80000010c111:	48 89 c6             	mov    %rax,%rsi
ffff80000010c114:	48 89 cf             	mov    %rcx,%rdi
ffff80000010c117:	48 b8 73 7b 10 00 00 	movabs $0xffff800000107b73,%rax
ffff80000010c11e:	80 ff ff 
ffff80000010c121:	ff d0                	call   *%rax
ffff80000010c123:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c127:	48 29 45 c0          	sub    %rax,-0x40(%rbp)
ffff80000010c12b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
ffff80000010c12f:	48 01 45 f8          	add    %rax,-0x8(%rbp)
ffff80000010c133:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
ffff80000010c137:	48 05 00 10 00 00    	add    $0x1000,%rax
ffff80000010c13d:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
ffff80000010c141:	48 83 7d c0 00       	cmpq   $0x0,-0x40(%rbp)
ffff80000010c146:	0f 85 45 ff ff ff    	jne    ffff80000010c091 <copyout+0x25>
ffff80000010c14c:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c151:	c9                   	leave
ffff80000010c152:	c3                   	ret

ffff80000010c153 <traceinit>:
    struct trace_event events[TRACE_BUF_SIZE];  // Ring buffer
} traceBuffer;

// Initalize the tracing event
void 
traceinit(void){
ffff80000010c153:	55                   	push   %rbp
ffff80000010c154:	48 89 e5             	mov    %rsp,%rbp
    initlock(&traceBuffer.lock, "trace");
ffff80000010c157:	48 ba 86 cc 10 00 00 	movabs $0xffff80000010cc86,%rdx
ffff80000010c15e:	80 ff ff 
ffff80000010c161:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c168:	80 ff ff 
ffff80000010c16b:	48 89 d6             	mov    %rdx,%rsi
ffff80000010c16e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c171:	48 b8 a5 76 10 00 00 	movabs $0xffff8000001076a5,%rax
ffff80000010c178:	80 ff ff 
ffff80000010c17b:	ff d0                	call   *%rax
    traceBuffer.enabled = 1;
ffff80000010c17d:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c184:	80 ff ff 
ffff80000010c187:	c7 40 68 01 00 00 00 	movl   $0x1,0x68(%rax)
    traceBuffer.seq = 0;
ffff80000010c18e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c195:	80 ff ff 
ffff80000010c198:	c7 40 6c 00 00 00 00 	movl   $0x0,0x6c(%rax)
    traceBuffer.readseq = 0;
ffff80000010c19f:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1a6:	80 ff ff 
ffff80000010c1a9:	c7 40 70 00 00 00 00 	movl   $0x0,0x70(%rax)
    traceBuffer.overwritten = 0;
ffff80000010c1b0:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1b7:	80 ff ff 
ffff80000010c1ba:	c7 40 74 00 00 00 00 	movl   $0x0,0x74(%rax)
}
ffff80000010c1c1:	90                   	nop
ffff80000010c1c2:	5d                   	pop    %rbp
ffff80000010c1c3:	c3                   	ret

ffff80000010c1c4 <traceevent>:

// trace the current event
void 
traceevent(int type, int pid, int arg0, int arg1, int arg2, char *name){
ffff80000010c1c4:	55                   	push   %rbp
ffff80000010c1c5:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c1c8:	48 83 ec 30          	sub    $0x30,%rsp
ffff80000010c1cc:	89 7d ec             	mov    %edi,-0x14(%rbp)
ffff80000010c1cf:	89 75 e8             	mov    %esi,-0x18(%rbp)
ffff80000010c1d2:	89 55 e4             	mov    %edx,-0x1c(%rbp)
ffff80000010c1d5:	89 4d e0             	mov    %ecx,-0x20(%rbp)
ffff80000010c1d8:	44 89 45 dc          	mov    %r8d,-0x24(%rbp)
ffff80000010c1dc:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
    struct trace_event *event;

    // if the trace buffer is not enabled, then return nothing
    if(!traceBuffer.enabled)
ffff80000010c1e0:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1e7:	80 ff ff 
ffff80000010c1ea:	8b 40 68             	mov    0x68(%rax),%eax
ffff80000010c1ed:	85 c0                	test   %eax,%eax
ffff80000010c1ef:	0f 84 34 02 00 00    	je     ffff80000010c429 <traceevent+0x265>
        return;

    //aquire the lock
    acquire(&traceBuffer.lock);
ffff80000010c1f5:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c1fc:	80 ff ff 
ffff80000010c1ff:	48 89 c7             	mov    %rax,%rdi
ffff80000010c202:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff80000010c209:	80 ff ff 
ffff80000010c20c:	ff d0                	call   *%rax
    // debug
    //cprintf("debug: traceevent type %d pid %d name %s\n", type, pid, name);


    event = &traceBuffer.events[traceBuffer.seq % TRACE_BUF_SIZE]; // Allows ring to wrap
ffff80000010c20e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c215:	80 ff ff 
ffff80000010c218:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c21b:	83 e0 7f             	and    $0x7f,%eax
ffff80000010c21e:	89 c0                	mov    %eax,%eax
ffff80000010c220:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010c224:	48 8d 50 70          	lea    0x70(%rax),%rdx
ffff80000010c228:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c22f:	80 ff ff 
ffff80000010c232:	48 01 d0             	add    %rdx,%rax
ffff80000010c235:	48 83 c0 08          	add    $0x8,%rax
ffff80000010c239:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

    // Set the event metadata
    event->seq = traceBuffer.seq;
ffff80000010c23d:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c244:	80 ff ff 
ffff80000010c247:	8b 50 6c             	mov    0x6c(%rax),%edx
ffff80000010c24a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c24e:	89 10                	mov    %edx,(%rax)
    event->ticks = ticks;
ffff80000010c250:	48 b8 48 bd 11 00 00 	movabs $0xffff80000011bd48,%rax
ffff80000010c257:	80 ff ff 
ffff80000010c25a:	8b 10                	mov    (%rax),%edx
ffff80000010c25c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c260:	89 50 04             	mov    %edx,0x4(%rax)
    event->type = type;
ffff80000010c263:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c267:	8b 55 ec             	mov    -0x14(%rbp),%edx
ffff80000010c26a:	89 50 08             	mov    %edx,0x8(%rax)
    event->pid = pid;
ffff80000010c26d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c271:	8b 55 e8             	mov    -0x18(%rbp),%edx
ffff80000010c274:	89 50 0c             	mov    %edx,0xc(%rax)
    event->arg0 = arg0;
ffff80000010c277:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c27b:	8b 55 e4             	mov    -0x1c(%rbp),%edx
ffff80000010c27e:	89 50 10             	mov    %edx,0x10(%rax)
    event->arg1 = arg1;
ffff80000010c281:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c285:	8b 55 e0             	mov    -0x20(%rbp),%edx
ffff80000010c288:	89 50 14             	mov    %edx,0x14(%rax)
    event->arg2 = arg2;
ffff80000010c28b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c28f:	8b 55 dc             	mov    -0x24(%rbp),%edx
ffff80000010c292:	89 50 18             	mov    %edx,0x18(%rax)
    event->overwritten = traceBuffer.overwritten;
ffff80000010c295:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c29c:	80 ff ff 
ffff80000010c29f:	8b 50 74             	mov    0x74(%rax),%edx
ffff80000010c2a2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c2a6:	89 50 3c             	mov    %edx,0x3c(%rax)

    memset(event->comm, 0, sizeof(event->comm));
ffff80000010c2a9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c2ad:	48 83 c0 1c          	add    $0x1c,%rax
ffff80000010c2b1:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c2b6:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c2bb:	48 89 c7             	mov    %rax,%rdi
ffff80000010c2be:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010c2c5:	80 ff ff 
ffff80000010c2c8:	ff d0                	call   *%rax
    if(proc && proc->pid > 0) {
ffff80000010c2ca:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010c2d1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010c2d5:	48 85 c0             	test   %rax,%rax
ffff80000010c2d8:	74 45                	je     ffff80000010c31f <traceevent+0x15b>
ffff80000010c2da:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010c2e1:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010c2e5:	8b 40 1c             	mov    0x1c(%rax),%eax
ffff80000010c2e8:	85 c0                	test   %eax,%eax
ffff80000010c2ea:	7e 33                	jle    ffff80000010c31f <traceevent+0x15b>
        safestrcpy(event->comm, proc->name, sizeof(event->comm));
ffff80000010c2ec:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010c2f3:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010c2f7:	48 8d 88 d0 00 00 00 	lea    0xd0(%rax),%rcx
ffff80000010c2fe:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c302:	48 83 c0 1c          	add    $0x1c,%rax
ffff80000010c306:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c30b:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c30e:	48 89 c7             	mov    %rax,%rdi
ffff80000010c311:	48 b8 26 7d 10 00 00 	movabs $0xffff800000107d26,%rax
ffff80000010c318:	80 ff ff 
ffff80000010c31b:	ff d0                	call   *%rax
ffff80000010c31d:	eb 29                	jmp    ffff80000010c348 <traceevent+0x184>
    } else {
        safestrcpy(event->comm, "kernel", sizeof(event->comm));
ffff80000010c31f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c323:	48 83 c0 1c          	add    $0x1c,%rax
ffff80000010c327:	48 b9 8c cc 10 00 00 	movabs $0xffff80000010cc8c,%rcx
ffff80000010c32e:	80 ff ff 
ffff80000010c331:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c336:	48 89 ce             	mov    %rcx,%rsi
ffff80000010c339:	48 89 c7             	mov    %rax,%rdi
ffff80000010c33c:	48 b8 26 7d 10 00 00 	movabs $0xffff800000107d26,%rax
ffff80000010c343:	80 ff ff 
ffff80000010c346:	ff d0                	call   *%rax
    }

    memset(event->event, 0, sizeof(event->event));
ffff80000010c348:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c34c:	48 83 c0 2c          	add    $0x2c,%rax
ffff80000010c350:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c355:	be 00 00 00 00       	mov    $0x0,%esi
ffff80000010c35a:	48 89 c7             	mov    %rax,%rdi
ffff80000010c35d:	48 b8 6e 7a 10 00 00 	movabs $0xffff800000107a6e,%rax
ffff80000010c364:	80 ff ff 
ffff80000010c367:	ff d0                	call   *%rax
    if(name)
ffff80000010c369:	48 83 7d d0 00       	cmpq   $0x0,-0x30(%rbp)
ffff80000010c36e:	74 23                	je     ffff80000010c393 <traceevent+0x1cf>
        safestrcpy(event->event, name, sizeof(event->event));
ffff80000010c370:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
ffff80000010c374:	48 8d 48 2c          	lea    0x2c(%rax),%rcx
ffff80000010c378:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
ffff80000010c37c:	ba 10 00 00 00       	mov    $0x10,%edx
ffff80000010c381:	48 89 c6             	mov    %rax,%rsi
ffff80000010c384:	48 89 cf             	mov    %rcx,%rdi
ffff80000010c387:	48 b8 26 7d 10 00 00 	movabs $0xffff800000107d26,%rax
ffff80000010c38e:	80 ff ff 
ffff80000010c391:	ff d0                	call   *%rax

    traceBuffer.seq++; // Update sequence number
ffff80000010c393:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c39a:	80 ff ff 
ffff80000010c39d:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c3a0:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010c3a3:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3aa:	80 ff ff 
ffff80000010c3ad:	89 50 6c             	mov    %edx,0x6c(%rax)

    // If the writer gets more than 128 events ahead, old events are gone, move readseq  foreward to the oldest event still available
    if(traceBuffer.seq - traceBuffer.readseq > TRACE_BUF_SIZE) {
ffff80000010c3b0:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3b7:	80 ff ff 
ffff80000010c3ba:	8b 50 6c             	mov    0x6c(%rax),%edx
ffff80000010c3bd:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3c4:	80 ff ff 
ffff80000010c3c7:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010c3ca:	29 c2                	sub    %eax,%edx
ffff80000010c3cc:	81 fa 80 00 00 00    	cmp    $0x80,%edx
ffff80000010c3d2:	76 3a                	jbe    ffff80000010c40e <traceevent+0x24a>
        traceBuffer.readseq = traceBuffer.seq - TRACE_BUF_SIZE;
ffff80000010c3d4:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3db:	80 ff ff 
ffff80000010c3de:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c3e1:	8d 50 80             	lea    -0x80(%rax),%edx
ffff80000010c3e4:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3eb:	80 ff ff 
ffff80000010c3ee:	89 50 70             	mov    %edx,0x70(%rax)
        traceBuffer.overwritten++;
ffff80000010c3f1:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c3f8:	80 ff ff 
ffff80000010c3fb:	8b 40 74             	mov    0x74(%rax),%eax
ffff80000010c3fe:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010c401:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c408:	80 ff ff 
ffff80000010c40b:	89 50 74             	mov    %edx,0x74(%rax)
    }

    // Release the lock
    release(&traceBuffer.lock);
ffff80000010c40e:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c415:	80 ff ff 
ffff80000010c418:	48 89 c7             	mov    %rax,%rdi
ffff80000010c41b:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010c422:	80 ff ff 
ffff80000010c425:	ff d0                	call   *%rax
ffff80000010c427:	eb 01                	jmp    ffff80000010c42a <traceevent+0x266>
        return;
ffff80000010c429:	90                   	nop
}
ffff80000010c42a:	c9                   	leave
ffff80000010c42b:	c3                   	ret

ffff80000010c42c <traceread>:

int
traceread(struct trace_event *dst){
ffff80000010c42c:	55                   	push   %rbp
ffff80000010c42d:	48 89 e5             	mov    %rsp,%rbp
ffff80000010c430:	53                   	push   %rbx
ffff80000010c431:	48 83 ec 58          	sub    $0x58,%rsp
ffff80000010c435:	48 89 7d a8          	mov    %rdi,-0x58(%rbp)
    struct trace_event event;

    acquire(&traceBuffer.lock);
ffff80000010c439:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c440:	80 ff ff 
ffff80000010c443:	48 89 c7             	mov    %rax,%rdi
ffff80000010c446:	48 b8 da 76 10 00 00 	movabs $0xffff8000001076da,%rax
ffff80000010c44d:	80 ff ff 
ffff80000010c450:	ff d0                	call   *%rax

    // No unread events available, return 0
    if(traceBuffer.readseq == traceBuffer.seq){
ffff80000010c452:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c459:	80 ff ff 
ffff80000010c45c:	8b 50 70             	mov    0x70(%rax),%edx
ffff80000010c45f:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c466:	80 ff ff 
ffff80000010c469:	8b 40 6c             	mov    0x6c(%rax),%eax
ffff80000010c46c:	39 c2                	cmp    %eax,%edx
ffff80000010c46e:	75 23                	jne    ffff80000010c493 <traceread+0x67>
        release(&traceBuffer.lock); // Release the lock
ffff80000010c470:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c477:	80 ff ff 
ffff80000010c47a:	48 89 c7             	mov    %rax,%rdi
ffff80000010c47d:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010c484:	80 ff ff 
ffff80000010c487:	ff d0                	call   *%rax
        return 0;
ffff80000010c489:	b8 00 00 00 00       	mov    $0x0,%eax
ffff80000010c48e:	e9 d8 00 00 00       	jmp    ffff80000010c56b <traceread+0x13f>
    }

    event = traceBuffer.events[traceBuffer.readseq % TRACE_BUF_SIZE];
ffff80000010c493:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c49a:	80 ff ff 
ffff80000010c49d:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010c4a0:	83 e0 7f             	and    $0x7f,%eax
ffff80000010c4a3:	48 ba 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rdx
ffff80000010c4aa:	80 ff ff 
ffff80000010c4ad:	89 c0                	mov    %eax,%eax
ffff80000010c4af:	48 c1 e0 06          	shl    $0x6,%rax
ffff80000010c4b3:	48 01 d0             	add    %rdx,%rax
ffff80000010c4b6:	48 83 c0 70          	add    $0x70,%rax
ffff80000010c4ba:	48 8b 48 08          	mov    0x8(%rax),%rcx
ffff80000010c4be:	48 8b 58 10          	mov    0x10(%rax),%rbx
ffff80000010c4c2:	48 89 4d b0          	mov    %rcx,-0x50(%rbp)
ffff80000010c4c6:	48 89 5d b8          	mov    %rbx,-0x48(%rbp)
ffff80000010c4ca:	48 8b 48 18          	mov    0x18(%rax),%rcx
ffff80000010c4ce:	48 8b 58 20          	mov    0x20(%rax),%rbx
ffff80000010c4d2:	48 89 4d c0          	mov    %rcx,-0x40(%rbp)
ffff80000010c4d6:	48 89 5d c8          	mov    %rbx,-0x38(%rbp)
ffff80000010c4da:	48 8b 48 28          	mov    0x28(%rax),%rcx
ffff80000010c4de:	48 8b 58 30          	mov    0x30(%rax),%rbx
ffff80000010c4e2:	48 89 4d d0          	mov    %rcx,-0x30(%rbp)
ffff80000010c4e6:	48 89 5d d8          	mov    %rbx,-0x28(%rbp)
ffff80000010c4ea:	48 8b 50 40          	mov    0x40(%rax),%rdx
ffff80000010c4ee:	48 8b 40 38          	mov    0x38(%rax),%rax
ffff80000010c4f2:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
ffff80000010c4f6:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    traceBuffer.readseq++; // Increment
ffff80000010c4fa:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c501:	80 ff ff 
ffff80000010c504:	8b 40 70             	mov    0x70(%rax),%eax
ffff80000010c507:	8d 50 01             	lea    0x1(%rax),%edx
ffff80000010c50a:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c511:	80 ff ff 
ffff80000010c514:	89 50 70             	mov    %edx,0x70(%rax)

    release(&traceBuffer.lock);
ffff80000010c517:	48 b8 80 bd 11 00 00 	movabs $0xffff80000011bd80,%rax
ffff80000010c51e:	80 ff ff 
ffff80000010c521:	48 89 c7             	mov    %rax,%rdi
ffff80000010c524:	48 b8 79 77 10 00 00 	movabs $0xffff800000107779,%rax
ffff80000010c52b:	80 ff ff 
ffff80000010c52e:	ff d0                	call   *%rax

    if(copyout(proc->pgdir, (addr_t)dst, &event, sizeof(event)) < 0)
ffff80000010c530:	48 8b 75 a8          	mov    -0x58(%rbp),%rsi
ffff80000010c534:	48 c7 c0 f8 ff ff ff 	mov    $0xfffffffffffffff8,%rax
ffff80000010c53b:	64 48 8b 00          	mov    %fs:(%rax),%rax
ffff80000010c53f:	48 8b 40 08          	mov    0x8(%rax),%rax
ffff80000010c543:	48 8d 55 b0          	lea    -0x50(%rbp),%rdx
ffff80000010c547:	b9 40 00 00 00       	mov    $0x40,%ecx
ffff80000010c54c:	48 89 c7             	mov    %rax,%rdi
ffff80000010c54f:	48 b8 6c c0 10 00 00 	movabs $0xffff80000010c06c,%rax
ffff80000010c556:	80 ff ff 
ffff80000010c559:	ff d0                	call   *%rax
ffff80000010c55b:	85 c0                	test   %eax,%eax
ffff80000010c55d:	79 07                	jns    ffff80000010c566 <traceread+0x13a>
        return -1;
ffff80000010c55f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
ffff80000010c564:	eb 05                	jmp    ffff80000010c56b <traceread+0x13f>

    return 1;
ffff80000010c566:	b8 01 00 00 00       	mov    $0x1,%eax
ffff80000010c56b:	48 8b 5d f8          	mov    -0x8(%rbp),%rbx
ffff80000010c56f:	c9                   	leave
ffff80000010c570:	c3                   	ret
