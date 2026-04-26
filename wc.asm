
_wc:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 30          	sub    $0x30,%rsp
    1008:	89 7d dc             	mov    %edi,-0x24(%rbp)
    100b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
    100f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    1016:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1019:	89 45 f4             	mov    %eax,-0xc(%rbp)
    101c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    101f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  inword = 0;
    1022:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    1029:	e9 84 00 00 00       	jmp    10b2 <wc+0xb2>
    for(i=0; i<n; i++){
    102e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1035:	eb 73                	jmp    10aa <wc+0xaa>
      c++;
    1037:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
      if(buf[i] == '\n')
    103b:	48 ba 00 20 00 00 00 	movabs $0x2000,%rdx
    1042:	00 00 00 
    1045:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1048:	48 98                	cltq
    104a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    104e:	3c 0a                	cmp    $0xa,%al
    1050:	75 04                	jne    1056 <wc+0x56>
        l++;
    1052:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(strchr(" \r\t\n\v", buf[i]))
    1056:	48 ba 00 20 00 00 00 	movabs $0x2000,%rdx
    105d:	00 00 00 
    1060:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1063:	48 98                	cltq
    1065:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1069:	0f be c0             	movsbl %al,%eax
    106c:	48 ba 96 1f 00 00 00 	movabs $0x1f96,%rdx
    1073:	00 00 00 
    1076:	89 c6                	mov    %eax,%esi
    1078:	48 89 d7             	mov    %rdx,%rdi
    107b:	48 b8 a3 13 00 00 00 	movabs $0x13a3,%rax
    1082:	00 00 00 
    1085:	ff d0                	call   *%rax
    1087:	48 85 c0             	test   %rax,%rax
    108a:	74 09                	je     1095 <wc+0x95>
        inword = 0;
    108c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    1093:	eb 11                	jmp    10a6 <wc+0xa6>
      else if(!inword){
    1095:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1099:	75 0b                	jne    10a6 <wc+0xa6>
        w++;
    109b:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
        inword = 1;
    109f:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%rbp)
    for(i=0; i<n; i++){
    10a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    10aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10ad:	3b 45 e8             	cmp    -0x18(%rbp),%eax
    10b0:	7c 85                	jl     1037 <wc+0x37>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    10b2:	48 b9 00 20 00 00 00 	movabs $0x2000,%rcx
    10b9:	00 00 00 
    10bc:	8b 45 dc             	mov    -0x24(%rbp),%eax
    10bf:	ba 00 02 00 00       	mov    $0x200,%edx
    10c4:	48 89 ce             	mov    %rcx,%rsi
    10c7:	89 c7                	mov    %eax,%edi
    10c9:	48 b8 b4 15 00 00 00 	movabs $0x15b4,%rax
    10d0:	00 00 00 
    10d3:	ff d0                	call   *%rax
    10d5:	89 45 e8             	mov    %eax,-0x18(%rbp)
    10d8:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10dc:	0f 8f 4c ff ff ff    	jg     102e <wc+0x2e>
      }
    }
  }
  if(n < 0){
    10e2:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    10e6:	79 2f                	jns    1117 <wc+0x117>
    printf(1, "wc: read error\n");
    10e8:	48 b8 9c 1f 00 00 00 	movabs $0x1f9c,%rax
    10ef:	00 00 00 
    10f2:	48 89 c6             	mov    %rax,%rsi
    10f5:	bf 01 00 00 00       	mov    $0x1,%edi
    10fa:	b8 00 00 00 00       	mov    $0x0,%eax
    10ff:	48 ba 74 18 00 00 00 	movabs $0x1874,%rdx
    1106:	00 00 00 
    1109:	ff d2                	call   *%rdx
    exit();
    110b:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    1112:	00 00 00 
    1115:	ff d0                	call   *%rax
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
    1117:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    111b:	8b 4d f0             	mov    -0x10(%rbp),%ecx
    111e:	8b 55 f4             	mov    -0xc(%rbp),%edx
    1121:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1124:	48 be ac 1f 00 00 00 	movabs $0x1fac,%rsi
    112b:	00 00 00 
    112e:	49 89 f9             	mov    %rdi,%r9
    1131:	41 89 c8             	mov    %ecx,%r8d
    1134:	89 d1                	mov    %edx,%ecx
    1136:	89 c2                	mov    %eax,%edx
    1138:	bf 01 00 00 00       	mov    $0x1,%edi
    113d:	b8 00 00 00 00       	mov    $0x0,%eax
    1142:	49 ba 74 18 00 00 00 	movabs $0x1874,%r10
    1149:	00 00 00 
    114c:	41 ff d2             	call   *%r10
}
    114f:	90                   	nop
    1150:	c9                   	leave
    1151:	c3                   	ret

0000000000001152 <main>:

int
main(int argc, char *argv[])
{
    1152:	55                   	push   %rbp
    1153:	48 89 e5             	mov    %rsp,%rbp
    1156:	48 83 ec 20          	sub    $0x20,%rsp
    115a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    115d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
    1161:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1165:	7f 2a                	jg     1191 <main+0x3f>
    wc(0, "");
    1167:	48 b8 b9 1f 00 00 00 	movabs $0x1fb9,%rax
    116e:	00 00 00 
    1171:	48 89 c6             	mov    %rax,%rsi
    1174:	bf 00 00 00 00       	mov    $0x0,%edi
    1179:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1180:	00 00 00 
    1183:	ff d0                	call   *%rax
    exit();
    1185:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    118c:	00 00 00 
    118f:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    1191:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    1198:	e9 bd 00 00 00       	jmp    125a <main+0x108>
    if((fd = open(argv[i], 0)) < 0){
    119d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11a0:	48 98                	cltq
    11a2:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11a9:	00 
    11aa:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11ae:	48 01 d0             	add    %rdx,%rax
    11b1:	48 8b 00             	mov    (%rax),%rax
    11b4:	be 00 00 00 00       	mov    $0x0,%esi
    11b9:	48 89 c7             	mov    %rax,%rdi
    11bc:	48 b8 f5 15 00 00 00 	movabs $0x15f5,%rax
    11c3:	00 00 00 
    11c6:	ff d0                	call   *%rax
    11c8:	89 45 f8             	mov    %eax,-0x8(%rbp)
    11cb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11cf:	79 49                	jns    121a <main+0xc8>
      printf(1, "wc: cannot open %s\n", argv[i]);
    11d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11d4:	48 98                	cltq
    11d6:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11dd:	00 
    11de:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11e2:	48 01 d0             	add    %rdx,%rax
    11e5:	48 8b 00             	mov    (%rax),%rax
    11e8:	48 b9 ba 1f 00 00 00 	movabs $0x1fba,%rcx
    11ef:	00 00 00 
    11f2:	48 89 c2             	mov    %rax,%rdx
    11f5:	48 89 ce             	mov    %rcx,%rsi
    11f8:	bf 01 00 00 00       	mov    $0x1,%edi
    11fd:	b8 00 00 00 00       	mov    $0x0,%eax
    1202:	48 b9 74 18 00 00 00 	movabs $0x1874,%rcx
    1209:	00 00 00 
    120c:	ff d1                	call   *%rcx
      exit();
    120e:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    1215:	00 00 00 
    1218:	ff d0                	call   *%rax
    }
    wc(fd, argv[i]);
    121a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    121d:	48 98                	cltq
    121f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1226:	00 
    1227:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    122b:	48 01 d0             	add    %rdx,%rax
    122e:	48 8b 10             	mov    (%rax),%rdx
    1231:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1234:	48 89 d6             	mov    %rdx,%rsi
    1237:	89 c7                	mov    %eax,%edi
    1239:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1240:	00 00 00 
    1243:	ff d0                	call   *%rax
    close(fd);
    1245:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1248:	89 c7                	mov    %eax,%edi
    124a:	48 b8 ce 15 00 00 00 	movabs $0x15ce,%rax
    1251:	00 00 00 
    1254:	ff d0                	call   *%rax
  for(i = 1; i < argc; i++){
    1256:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    125a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    125d:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1260:	0f 8c 37 ff ff ff    	jl     119d <main+0x4b>
  }
  exit();
    1266:	48 b8 8d 15 00 00 00 	movabs $0x158d,%rax
    126d:	00 00 00 
    1270:	ff d0                	call   *%rax

0000000000001272 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1272:	55                   	push   %rbp
    1273:	48 89 e5             	mov    %rsp,%rbp
    1276:	48 83 ec 10          	sub    $0x10,%rsp
    127a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    127e:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1281:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    1284:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1288:	8b 55 f0             	mov    -0x10(%rbp),%edx
    128b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    128e:	48 89 ce             	mov    %rcx,%rsi
    1291:	48 89 f7             	mov    %rsi,%rdi
    1294:	89 d1                	mov    %edx,%ecx
    1296:	fc                   	cld
    1297:	f3 aa                	rep stos %al,(%rdi)
    1299:	89 ca                	mov    %ecx,%edx
    129b:	48 89 fe             	mov    %rdi,%rsi
    129e:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    12a2:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    12a5:	90                   	nop
    12a6:	c9                   	leave
    12a7:	c3                   	ret

00000000000012a8 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    12a8:	55                   	push   %rbp
    12a9:	48 89 e5             	mov    %rsp,%rbp
    12ac:	48 83 ec 20          	sub    $0x20,%rsp
    12b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    12b8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12bc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    12c0:	90                   	nop
    12c1:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12c5:	48 8d 42 01          	lea    0x1(%rdx),%rax
    12c9:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    12cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12d1:	48 8d 48 01          	lea    0x1(%rax),%rcx
    12d5:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    12d9:	0f b6 12             	movzbl (%rdx),%edx
    12dc:	88 10                	mov    %dl,(%rax)
    12de:	0f b6 00             	movzbl (%rax),%eax
    12e1:	84 c0                	test   %al,%al
    12e3:	75 dc                	jne    12c1 <strcpy+0x19>
    ;
  return os;
    12e5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12e9:	c9                   	leave
    12ea:	c3                   	ret

00000000000012eb <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12eb:	55                   	push   %rbp
    12ec:	48 89 e5             	mov    %rsp,%rbp
    12ef:	48 83 ec 10          	sub    $0x10,%rsp
    12f3:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12f7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    12fb:	eb 0a                	jmp    1307 <strcmp+0x1c>
    p++, q++;
    12fd:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1302:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1307:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    130b:	0f b6 00             	movzbl (%rax),%eax
    130e:	84 c0                	test   %al,%al
    1310:	74 12                	je     1324 <strcmp+0x39>
    1312:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1316:	0f b6 10             	movzbl (%rax),%edx
    1319:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    131d:	0f b6 00             	movzbl (%rax),%eax
    1320:	38 c2                	cmp    %al,%dl
    1322:	74 d9                	je     12fd <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1324:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1328:	0f b6 00             	movzbl (%rax),%eax
    132b:	0f b6 d0             	movzbl %al,%edx
    132e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1332:	0f b6 00             	movzbl (%rax),%eax
    1335:	0f b6 c0             	movzbl %al,%eax
    1338:	29 c2                	sub    %eax,%edx
    133a:	89 d0                	mov    %edx,%eax
}
    133c:	c9                   	leave
    133d:	c3                   	ret

000000000000133e <strlen>:

uint
strlen(char *s)
{
    133e:	55                   	push   %rbp
    133f:	48 89 e5             	mov    %rsp,%rbp
    1342:	48 83 ec 18          	sub    $0x18,%rsp
    1346:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    134a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1351:	eb 04                	jmp    1357 <strlen+0x19>
    1353:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1357:	8b 45 fc             	mov    -0x4(%rbp),%eax
    135a:	48 63 d0             	movslq %eax,%rdx
    135d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1361:	48 01 d0             	add    %rdx,%rax
    1364:	0f b6 00             	movzbl (%rax),%eax
    1367:	84 c0                	test   %al,%al
    1369:	75 e8                	jne    1353 <strlen+0x15>
    ;
  return n;
    136b:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    136e:	c9                   	leave
    136f:	c3                   	ret

0000000000001370 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1370:	55                   	push   %rbp
    1371:	48 89 e5             	mov    %rsp,%rbp
    1374:	48 83 ec 10          	sub    $0x10,%rsp
    1378:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    137c:	89 75 f4             	mov    %esi,-0xc(%rbp)
    137f:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1382:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1385:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1388:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    138c:	89 ce                	mov    %ecx,%esi
    138e:	48 89 c7             	mov    %rax,%rdi
    1391:	48 b8 72 12 00 00 00 	movabs $0x1272,%rax
    1398:	00 00 00 
    139b:	ff d0                	call   *%rax
  return dst;
    139d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    13a1:	c9                   	leave
    13a2:	c3                   	ret

00000000000013a3 <strchr>:

char*
strchr(const char *s, char c)
{
    13a3:	55                   	push   %rbp
    13a4:	48 89 e5             	mov    %rsp,%rbp
    13a7:	48 83 ec 10          	sub    $0x10,%rsp
    13ab:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    13af:	89 f0                	mov    %esi,%eax
    13b1:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    13b4:	eb 17                	jmp    13cd <strchr+0x2a>
    if(*s == c)
    13b6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13ba:	0f b6 00             	movzbl (%rax),%eax
    13bd:	38 45 f4             	cmp    %al,-0xc(%rbp)
    13c0:	75 06                	jne    13c8 <strchr+0x25>
      return (char*)s;
    13c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13c6:	eb 15                	jmp    13dd <strchr+0x3a>
  for(; *s; s++)
    13c8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    13cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13d1:	0f b6 00             	movzbl (%rax),%eax
    13d4:	84 c0                	test   %al,%al
    13d6:	75 de                	jne    13b6 <strchr+0x13>
  return 0;
    13d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13dd:	c9                   	leave
    13de:	c3                   	ret

00000000000013df <gets>:

char*
gets(char *buf, int max)
{
    13df:	55                   	push   %rbp
    13e0:	48 89 e5             	mov    %rsp,%rbp
    13e3:	48 83 ec 20          	sub    $0x20,%rsp
    13e7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13eb:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    13f5:	eb 4f                	jmp    1446 <gets+0x67>
    cc = read(0, &c, 1);
    13f7:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    13fb:	ba 01 00 00 00       	mov    $0x1,%edx
    1400:	48 89 c6             	mov    %rax,%rsi
    1403:	bf 00 00 00 00       	mov    $0x0,%edi
    1408:	48 b8 b4 15 00 00 00 	movabs $0x15b4,%rax
    140f:	00 00 00 
    1412:	ff d0                	call   *%rax
    1414:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1417:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    141b:	7e 36                	jle    1453 <gets+0x74>
      break;
    buf[i++] = c;
    141d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1420:	8d 50 01             	lea    0x1(%rax),%edx
    1423:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1426:	48 63 d0             	movslq %eax,%rdx
    1429:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    142d:	48 01 c2             	add    %rax,%rdx
    1430:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1434:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1436:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    143a:	3c 0a                	cmp    $0xa,%al
    143c:	74 16                	je     1454 <gets+0x75>
    143e:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1442:	3c 0d                	cmp    $0xd,%al
    1444:	74 0e                	je     1454 <gets+0x75>
  for(i=0; i+1 < max; ){
    1446:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1449:	83 c0 01             	add    $0x1,%eax
    144c:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    144f:	7f a6                	jg     13f7 <gets+0x18>
    1451:	eb 01                	jmp    1454 <gets+0x75>
      break;
    1453:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1454:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1457:	48 63 d0             	movslq %eax,%rdx
    145a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    145e:	48 01 d0             	add    %rdx,%rax
    1461:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1464:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1468:	c9                   	leave
    1469:	c3                   	ret

000000000000146a <stat>:

int
stat(char *n, struct stat *st)
{
    146a:	55                   	push   %rbp
    146b:	48 89 e5             	mov    %rsp,%rbp
    146e:	48 83 ec 20          	sub    $0x20,%rsp
    1472:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1476:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    147a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    147e:	be 00 00 00 00       	mov    $0x0,%esi
    1483:	48 89 c7             	mov    %rax,%rdi
    1486:	48 b8 f5 15 00 00 00 	movabs $0x15f5,%rax
    148d:	00 00 00 
    1490:	ff d0                	call   *%rax
    1492:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1495:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1499:	79 07                	jns    14a2 <stat+0x38>
    return -1;
    149b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14a0:	eb 2f                	jmp    14d1 <stat+0x67>
  r = fstat(fd, st);
    14a2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    14a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14a9:	48 89 d6             	mov    %rdx,%rsi
    14ac:	89 c7                	mov    %eax,%edi
    14ae:	48 b8 1c 16 00 00 00 	movabs $0x161c,%rax
    14b5:	00 00 00 
    14b8:	ff d0                	call   *%rax
    14ba:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    14bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14c0:	89 c7                	mov    %eax,%edi
    14c2:	48 b8 ce 15 00 00 00 	movabs $0x15ce,%rax
    14c9:	00 00 00 
    14cc:	ff d0                	call   *%rax
  return r;
    14ce:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    14d1:	c9                   	leave
    14d2:	c3                   	ret

00000000000014d3 <atoi>:

int
atoi(const char *s)
{
    14d3:	55                   	push   %rbp
    14d4:	48 89 e5             	mov    %rsp,%rbp
    14d7:	48 83 ec 18          	sub    $0x18,%rsp
    14db:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    14df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14e6:	eb 28                	jmp    1510 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    14e8:	8b 55 fc             	mov    -0x4(%rbp),%edx
    14eb:	89 d0                	mov    %edx,%eax
    14ed:	c1 e0 02             	shl    $0x2,%eax
    14f0:	01 d0                	add    %edx,%eax
    14f2:	01 c0                	add    %eax,%eax
    14f4:	89 c1                	mov    %eax,%ecx
    14f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14fa:	48 8d 50 01          	lea    0x1(%rax),%rdx
    14fe:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1502:	0f b6 00             	movzbl (%rax),%eax
    1505:	0f be c0             	movsbl %al,%eax
    1508:	01 c8                	add    %ecx,%eax
    150a:	83 e8 30             	sub    $0x30,%eax
    150d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1510:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1514:	0f b6 00             	movzbl (%rax),%eax
    1517:	3c 2f                	cmp    $0x2f,%al
    1519:	7e 0b                	jle    1526 <atoi+0x53>
    151b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    151f:	0f b6 00             	movzbl (%rax),%eax
    1522:	3c 39                	cmp    $0x39,%al
    1524:	7e c2                	jle    14e8 <atoi+0x15>
  return n;
    1526:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1529:	c9                   	leave
    152a:	c3                   	ret

000000000000152b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    152b:	55                   	push   %rbp
    152c:	48 89 e5             	mov    %rsp,%rbp
    152f:	48 83 ec 28          	sub    $0x28,%rsp
    1533:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1537:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    153b:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    153e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1542:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1546:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    154a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    154e:	eb 1d                	jmp    156d <memmove+0x42>
    *dst++ = *src++;
    1550:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1554:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1558:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    155c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1560:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1564:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1568:	0f b6 12             	movzbl (%rdx),%edx
    156b:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    156d:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1570:	8d 50 ff             	lea    -0x1(%rax),%edx
    1573:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1576:	85 c0                	test   %eax,%eax
    1578:	7f d6                	jg     1550 <memmove+0x25>
  return vdst;
    157a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    157e:	c9                   	leave
    157f:	c3                   	ret

0000000000001580 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1580:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1587:	49 89 ca             	mov    %rcx,%r10
    158a:	0f 05                	syscall
    158c:	c3                   	ret

000000000000158d <exit>:
SYSCALL(exit)
    158d:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1594:	49 89 ca             	mov    %rcx,%r10
    1597:	0f 05                	syscall
    1599:	c3                   	ret

000000000000159a <wait>:
SYSCALL(wait)
    159a:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    15a1:	49 89 ca             	mov    %rcx,%r10
    15a4:	0f 05                	syscall
    15a6:	c3                   	ret

00000000000015a7 <pipe>:
SYSCALL(pipe)
    15a7:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    15ae:	49 89 ca             	mov    %rcx,%r10
    15b1:	0f 05                	syscall
    15b3:	c3                   	ret

00000000000015b4 <read>:
SYSCALL(read)
    15b4:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    15bb:	49 89 ca             	mov    %rcx,%r10
    15be:	0f 05                	syscall
    15c0:	c3                   	ret

00000000000015c1 <write>:
SYSCALL(write)
    15c1:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    15c8:	49 89 ca             	mov    %rcx,%r10
    15cb:	0f 05                	syscall
    15cd:	c3                   	ret

00000000000015ce <close>:
SYSCALL(close)
    15ce:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    15d5:	49 89 ca             	mov    %rcx,%r10
    15d8:	0f 05                	syscall
    15da:	c3                   	ret

00000000000015db <kill>:
SYSCALL(kill)
    15db:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    15e2:	49 89 ca             	mov    %rcx,%r10
    15e5:	0f 05                	syscall
    15e7:	c3                   	ret

00000000000015e8 <exec>:
SYSCALL(exec)
    15e8:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    15ef:	49 89 ca             	mov    %rcx,%r10
    15f2:	0f 05                	syscall
    15f4:	c3                   	ret

00000000000015f5 <open>:
SYSCALL(open)
    15f5:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    15fc:	49 89 ca             	mov    %rcx,%r10
    15ff:	0f 05                	syscall
    1601:	c3                   	ret

0000000000001602 <mknod>:
SYSCALL(mknod)
    1602:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1609:	49 89 ca             	mov    %rcx,%r10
    160c:	0f 05                	syscall
    160e:	c3                   	ret

000000000000160f <unlink>:
SYSCALL(unlink)
    160f:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1616:	49 89 ca             	mov    %rcx,%r10
    1619:	0f 05                	syscall
    161b:	c3                   	ret

000000000000161c <fstat>:
SYSCALL(fstat)
    161c:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1623:	49 89 ca             	mov    %rcx,%r10
    1626:	0f 05                	syscall
    1628:	c3                   	ret

0000000000001629 <link>:
SYSCALL(link)
    1629:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1630:	49 89 ca             	mov    %rcx,%r10
    1633:	0f 05                	syscall
    1635:	c3                   	ret

0000000000001636 <mkdir>:
SYSCALL(mkdir)
    1636:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    163d:	49 89 ca             	mov    %rcx,%r10
    1640:	0f 05                	syscall
    1642:	c3                   	ret

0000000000001643 <chdir>:
SYSCALL(chdir)
    1643:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    164a:	49 89 ca             	mov    %rcx,%r10
    164d:	0f 05                	syscall
    164f:	c3                   	ret

0000000000001650 <dup>:
SYSCALL(dup)
    1650:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1657:	49 89 ca             	mov    %rcx,%r10
    165a:	0f 05                	syscall
    165c:	c3                   	ret

000000000000165d <getpid>:
SYSCALL(getpid)
    165d:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1664:	49 89 ca             	mov    %rcx,%r10
    1667:	0f 05                	syscall
    1669:	c3                   	ret

000000000000166a <sbrk>:
SYSCALL(sbrk)
    166a:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1671:	49 89 ca             	mov    %rcx,%r10
    1674:	0f 05                	syscall
    1676:	c3                   	ret

0000000000001677 <sleep>:
SYSCALL(sleep)
    1677:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    167e:	49 89 ca             	mov    %rcx,%r10
    1681:	0f 05                	syscall
    1683:	c3                   	ret

0000000000001684 <uptime>:
SYSCALL(uptime)
    1684:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    168b:	49 89 ca             	mov    %rcx,%r10
    168e:	0f 05                	syscall
    1690:	c3                   	ret

0000000000001691 <traceread>:
SYSCALL(traceread)
    1691:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1698:	49 89 ca             	mov    %rcx,%r10
    169b:	0f 05                	syscall
    169d:	c3                   	ret

000000000000169e <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    169e:	55                   	push   %rbp
    169f:	48 89 e5             	mov    %rsp,%rbp
    16a2:	48 83 ec 10          	sub    $0x10,%rsp
    16a6:	89 7d fc             	mov    %edi,-0x4(%rbp)
    16a9:	89 f0                	mov    %esi,%eax
    16ab:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    16ae:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    16b2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16b5:	ba 01 00 00 00       	mov    $0x1,%edx
    16ba:	48 89 ce             	mov    %rcx,%rsi
    16bd:	89 c7                	mov    %eax,%edi
    16bf:	48 b8 c1 15 00 00 00 	movabs $0x15c1,%rax
    16c6:	00 00 00 
    16c9:	ff d0                	call   *%rax
}
    16cb:	90                   	nop
    16cc:	c9                   	leave
    16cd:	c3                   	ret

00000000000016ce <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    16ce:	55                   	push   %rbp
    16cf:	48 89 e5             	mov    %rsp,%rbp
    16d2:	48 83 ec 20          	sub    $0x20,%rsp
    16d6:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16d9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16e4:	eb 35                	jmp    171b <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    16e6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    16ea:	48 c1 e8 3c          	shr    $0x3c,%rax
    16ee:	48 ba e0 1f 00 00 00 	movabs $0x1fe0,%rdx
    16f5:	00 00 00 
    16f8:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    16fc:	0f be d0             	movsbl %al,%edx
    16ff:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1702:	89 d6                	mov    %edx,%esi
    1704:	89 c7                	mov    %eax,%edi
    1706:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    170d:	00 00 00 
    1710:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1712:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1716:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    171b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    171e:	83 f8 0f             	cmp    $0xf,%eax
    1721:	76 c3                	jbe    16e6 <print_x64+0x18>
}
    1723:	90                   	nop
    1724:	90                   	nop
    1725:	c9                   	leave
    1726:	c3                   	ret

0000000000001727 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1727:	55                   	push   %rbp
    1728:	48 89 e5             	mov    %rsp,%rbp
    172b:	48 83 ec 20          	sub    $0x20,%rsp
    172f:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1732:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1735:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    173c:	eb 36                	jmp    1774 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    173e:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1741:	c1 e8 1c             	shr    $0x1c,%eax
    1744:	89 c2                	mov    %eax,%edx
    1746:	48 b8 e0 1f 00 00 00 	movabs $0x1fe0,%rax
    174d:	00 00 00 
    1750:	89 d2                	mov    %edx,%edx
    1752:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1756:	0f be d0             	movsbl %al,%edx
    1759:	8b 45 ec             	mov    -0x14(%rbp),%eax
    175c:	89 d6                	mov    %edx,%esi
    175e:	89 c7                	mov    %eax,%edi
    1760:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1767:	00 00 00 
    176a:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    176c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1770:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1774:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1777:	83 f8 07             	cmp    $0x7,%eax
    177a:	76 c2                	jbe    173e <print_x32+0x17>
}
    177c:	90                   	nop
    177d:	90                   	nop
    177e:	c9                   	leave
    177f:	c3                   	ret

0000000000001780 <print_d>:

  static void
print_d(int fd, int v)
{
    1780:	55                   	push   %rbp
    1781:	48 89 e5             	mov    %rsp,%rbp
    1784:	48 83 ec 30          	sub    $0x30,%rsp
    1788:	89 7d dc             	mov    %edi,-0x24(%rbp)
    178b:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    178e:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1791:	48 98                	cltq
    1793:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1797:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    179b:	79 04                	jns    17a1 <print_d+0x21>
    x = -x;
    179d:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    17a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    17a8:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17ac:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17b3:	66 66 66 
    17b6:	48 89 c8             	mov    %rcx,%rax
    17b9:	48 f7 ea             	imul   %rdx
    17bc:	48 c1 fa 02          	sar    $0x2,%rdx
    17c0:	48 89 c8             	mov    %rcx,%rax
    17c3:	48 c1 f8 3f          	sar    $0x3f,%rax
    17c7:	48 29 c2             	sub    %rax,%rdx
    17ca:	48 89 d0             	mov    %rdx,%rax
    17cd:	48 c1 e0 02          	shl    $0x2,%rax
    17d1:	48 01 d0             	add    %rdx,%rax
    17d4:	48 01 c0             	add    %rax,%rax
    17d7:	48 29 c1             	sub    %rax,%rcx
    17da:	48 89 ca             	mov    %rcx,%rdx
    17dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17e0:	8d 48 01             	lea    0x1(%rax),%ecx
    17e3:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    17e6:	48 b9 e0 1f 00 00 00 	movabs $0x1fe0,%rcx
    17ed:	00 00 00 
    17f0:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    17f4:	48 98                	cltq
    17f6:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    17fa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17fe:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1805:	66 66 66 
    1808:	48 89 c8             	mov    %rcx,%rax
    180b:	48 f7 ea             	imul   %rdx
    180e:	48 89 d0             	mov    %rdx,%rax
    1811:	48 c1 f8 02          	sar    $0x2,%rax
    1815:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1819:	48 89 ca             	mov    %rcx,%rdx
    181c:	48 29 d0             	sub    %rdx,%rax
    181f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1823:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1828:	0f 85 7a ff ff ff    	jne    17a8 <print_d+0x28>

  if (v < 0)
    182e:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1832:	79 32                	jns    1866 <print_d+0xe6>
    buf[i++] = '-';
    1834:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1837:	8d 50 01             	lea    0x1(%rax),%edx
    183a:	89 55 f4             	mov    %edx,-0xc(%rbp)
    183d:	48 98                	cltq
    183f:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1844:	eb 20                	jmp    1866 <print_d+0xe6>
    putc(fd, buf[i]);
    1846:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1849:	48 98                	cltq
    184b:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1850:	0f be d0             	movsbl %al,%edx
    1853:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1856:	89 d6                	mov    %edx,%esi
    1858:	89 c7                	mov    %eax,%edi
    185a:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1861:	00 00 00 
    1864:	ff d0                	call   *%rax
  while (--i >= 0)
    1866:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    186a:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    186e:	79 d6                	jns    1846 <print_d+0xc6>
}
    1870:	90                   	nop
    1871:	90                   	nop
    1872:	c9                   	leave
    1873:	c3                   	ret

0000000000001874 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1874:	55                   	push   %rbp
    1875:	48 89 e5             	mov    %rsp,%rbp
    1878:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    187f:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1885:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    188c:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1893:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    189a:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    18a1:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    18a8:	84 c0                	test   %al,%al
    18aa:	74 20                	je     18cc <printf+0x58>
    18ac:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    18b0:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    18b4:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    18b8:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    18bc:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    18c0:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    18c4:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    18c8:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    18cc:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    18d3:	00 00 00 
    18d6:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    18dd:	00 00 00 
    18e0:	48 8d 45 10          	lea    0x10(%rbp),%rax
    18e4:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    18eb:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    18f2:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    18f9:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1900:	00 00 00 
    1903:	e9 60 03 00 00       	jmp    1c68 <printf+0x3f4>
    if (c != '%') {
    1908:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    190f:	74 24                	je     1935 <printf+0xc1>
      putc(fd, c);
    1911:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1917:	0f be d0             	movsbl %al,%edx
    191a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1920:	89 d6                	mov    %edx,%esi
    1922:	89 c7                	mov    %eax,%edi
    1924:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    192b:	00 00 00 
    192e:	ff d0                	call   *%rax
      continue;
    1930:	e9 2c 03 00 00       	jmp    1c61 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1935:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    193c:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1942:	48 63 d0             	movslq %eax,%rdx
    1945:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    194c:	48 01 d0             	add    %rdx,%rax
    194f:	0f b6 00             	movzbl (%rax),%eax
    1952:	0f be c0             	movsbl %al,%eax
    1955:	25 ff 00 00 00       	and    $0xff,%eax
    195a:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1960:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1967:	0f 84 2e 03 00 00    	je     1c9b <printf+0x427>
      break;
    switch(c) {
    196d:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1974:	0f 84 32 01 00 00    	je     1aac <printf+0x238>
    197a:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1981:	0f 8f a1 02 00 00    	jg     1c28 <printf+0x3b4>
    1987:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    198e:	0f 84 d4 01 00 00    	je     1b68 <printf+0x2f4>
    1994:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    199b:	0f 8f 87 02 00 00    	jg     1c28 <printf+0x3b4>
    19a1:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    19a8:	0f 84 5b 01 00 00    	je     1b09 <printf+0x295>
    19ae:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    19b5:	0f 8f 6d 02 00 00    	jg     1c28 <printf+0x3b4>
    19bb:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    19c2:	0f 84 87 00 00 00    	je     1a4f <printf+0x1db>
    19c8:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    19cf:	0f 8f 53 02 00 00    	jg     1c28 <printf+0x3b4>
    19d5:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19dc:	0f 84 2b 02 00 00    	je     1c0d <printf+0x399>
    19e2:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    19e9:	0f 85 39 02 00 00    	jne    1c28 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    19ef:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19f5:	83 f8 2f             	cmp    $0x2f,%eax
    19f8:	77 23                	ja     1a1d <printf+0x1a9>
    19fa:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a01:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a07:	89 d2                	mov    %edx,%edx
    1a09:	48 01 d0             	add    %rdx,%rax
    1a0c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a12:	83 c2 08             	add    $0x8,%edx
    1a15:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a1b:	eb 12                	jmp    1a2f <printf+0x1bb>
    1a1d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a24:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a28:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a2f:	8b 00                	mov    (%rax),%eax
    1a31:	0f be d0             	movsbl %al,%edx
    1a34:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a3a:	89 d6                	mov    %edx,%esi
    1a3c:	89 c7                	mov    %eax,%edi
    1a3e:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1a45:	00 00 00 
    1a48:	ff d0                	call   *%rax
      break;
    1a4a:	e9 12 02 00 00       	jmp    1c61 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1a4f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a55:	83 f8 2f             	cmp    $0x2f,%eax
    1a58:	77 23                	ja     1a7d <printf+0x209>
    1a5a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a61:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a67:	89 d2                	mov    %edx,%edx
    1a69:	48 01 d0             	add    %rdx,%rax
    1a6c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a72:	83 c2 08             	add    $0x8,%edx
    1a75:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a7b:	eb 12                	jmp    1a8f <printf+0x21b>
    1a7d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a84:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a88:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a8f:	8b 10                	mov    (%rax),%edx
    1a91:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a97:	89 d6                	mov    %edx,%esi
    1a99:	89 c7                	mov    %eax,%edi
    1a9b:	48 b8 80 17 00 00 00 	movabs $0x1780,%rax
    1aa2:	00 00 00 
    1aa5:	ff d0                	call   *%rax
      break;
    1aa7:	e9 b5 01 00 00       	jmp    1c61 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1aac:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ab2:	83 f8 2f             	cmp    $0x2f,%eax
    1ab5:	77 23                	ja     1ada <printf+0x266>
    1ab7:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1abe:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ac4:	89 d2                	mov    %edx,%edx
    1ac6:	48 01 d0             	add    %rdx,%rax
    1ac9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1acf:	83 c2 08             	add    $0x8,%edx
    1ad2:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ad8:	eb 12                	jmp    1aec <printf+0x278>
    1ada:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ae1:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ae5:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1aec:	8b 10                	mov    (%rax),%edx
    1aee:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1af4:	89 d6                	mov    %edx,%esi
    1af6:	89 c7                	mov    %eax,%edi
    1af8:	48 b8 27 17 00 00 00 	movabs $0x1727,%rax
    1aff:	00 00 00 
    1b02:	ff d0                	call   *%rax
      break;
    1b04:	e9 58 01 00 00       	jmp    1c61 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1b09:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b0f:	83 f8 2f             	cmp    $0x2f,%eax
    1b12:	77 23                	ja     1b37 <printf+0x2c3>
    1b14:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b1b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b21:	89 d2                	mov    %edx,%edx
    1b23:	48 01 d0             	add    %rdx,%rax
    1b26:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b2c:	83 c2 08             	add    $0x8,%edx
    1b2f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b35:	eb 12                	jmp    1b49 <printf+0x2d5>
    1b37:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b3e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b42:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b49:	48 8b 10             	mov    (%rax),%rdx
    1b4c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b52:	48 89 d6             	mov    %rdx,%rsi
    1b55:	89 c7                	mov    %eax,%edi
    1b57:	48 b8 ce 16 00 00 00 	movabs $0x16ce,%rax
    1b5e:	00 00 00 
    1b61:	ff d0                	call   *%rax
      break;
    1b63:	e9 f9 00 00 00       	jmp    1c61 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1b68:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b6e:	83 f8 2f             	cmp    $0x2f,%eax
    1b71:	77 23                	ja     1b96 <printf+0x322>
    1b73:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b7a:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b80:	89 d2                	mov    %edx,%edx
    1b82:	48 01 d0             	add    %rdx,%rax
    1b85:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b8b:	83 c2 08             	add    $0x8,%edx
    1b8e:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b94:	eb 12                	jmp    1ba8 <printf+0x334>
    1b96:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b9d:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ba1:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ba8:	48 8b 00             	mov    (%rax),%rax
    1bab:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1bb2:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1bb9:	00 
    1bba:	75 41                	jne    1bfd <printf+0x389>
        s = "(null)";
    1bbc:	48 b8 ce 1f 00 00 00 	movabs $0x1fce,%rax
    1bc3:	00 00 00 
    1bc6:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1bcd:	eb 2e                	jmp    1bfd <printf+0x389>
        putc(fd, *(s++));
    1bcf:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1bd6:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1bda:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1be1:	0f b6 00             	movzbl (%rax),%eax
    1be4:	0f be d0             	movsbl %al,%edx
    1be7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bed:	89 d6                	mov    %edx,%esi
    1bef:	89 c7                	mov    %eax,%edi
    1bf1:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1bf8:	00 00 00 
    1bfb:	ff d0                	call   *%rax
      while (*s)
    1bfd:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1c04:	0f b6 00             	movzbl (%rax),%eax
    1c07:	84 c0                	test   %al,%al
    1c09:	75 c4                	jne    1bcf <printf+0x35b>
      break;
    1c0b:	eb 54                	jmp    1c61 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1c0d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c13:	be 25 00 00 00       	mov    $0x25,%esi
    1c18:	89 c7                	mov    %eax,%edi
    1c1a:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1c21:	00 00 00 
    1c24:	ff d0                	call   *%rax
      break;
    1c26:	eb 39                	jmp    1c61 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1c28:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c2e:	be 25 00 00 00       	mov    $0x25,%esi
    1c33:	89 c7                	mov    %eax,%edi
    1c35:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1c3c:	00 00 00 
    1c3f:	ff d0                	call   *%rax
      putc(fd, c);
    1c41:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c47:	0f be d0             	movsbl %al,%edx
    1c4a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c50:	89 d6                	mov    %edx,%esi
    1c52:	89 c7                	mov    %eax,%edi
    1c54:	48 b8 9e 16 00 00 00 	movabs $0x169e,%rax
    1c5b:	00 00 00 
    1c5e:	ff d0                	call   *%rax
      break;
    1c60:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1c61:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1c68:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1c6e:	48 63 d0             	movslq %eax,%rdx
    1c71:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1c78:	48 01 d0             	add    %rdx,%rax
    1c7b:	0f b6 00             	movzbl (%rax),%eax
    1c7e:	0f be c0             	movsbl %al,%eax
    1c81:	25 ff 00 00 00       	and    $0xff,%eax
    1c86:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c8c:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c93:	0f 85 6f fc ff ff    	jne    1908 <printf+0x94>
    }
  }
}
    1c99:	eb 01                	jmp    1c9c <printf+0x428>
      break;
    1c9b:	90                   	nop
}
    1c9c:	90                   	nop
    1c9d:	c9                   	leave
    1c9e:	c3                   	ret

0000000000001c9f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c9f:	55                   	push   %rbp
    1ca0:	48 89 e5             	mov    %rsp,%rbp
    1ca3:	48 83 ec 18          	sub    $0x18,%rsp
    1ca7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1cab:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1caf:	48 83 e8 10          	sub    $0x10,%rax
    1cb3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cb7:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    1cbe:	00 00 00 
    1cc1:	48 8b 00             	mov    (%rax),%rax
    1cc4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1cc8:	eb 2f                	jmp    1cf9 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1cca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cce:	48 8b 00             	mov    (%rax),%rax
    1cd1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cd5:	72 17                	jb     1cee <free+0x4f>
    1cd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cdb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cdf:	72 2f                	jb     1d10 <free+0x71>
    1ce1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce5:	48 8b 00             	mov    (%rax),%rax
    1ce8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cec:	72 22                	jb     1d10 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf2:	48 8b 00             	mov    (%rax),%rax
    1cf5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1cf9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cfd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d01:	73 c7                	jae    1cca <free+0x2b>
    1d03:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d07:	48 8b 00             	mov    (%rax),%rax
    1d0a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d0e:	73 ba                	jae    1cca <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1d10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d14:	8b 40 08             	mov    0x8(%rax),%eax
    1d17:	89 c0                	mov    %eax,%eax
    1d19:	48 c1 e0 04          	shl    $0x4,%rax
    1d1d:	48 89 c2             	mov    %rax,%rdx
    1d20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d24:	48 01 c2             	add    %rax,%rdx
    1d27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2b:	48 8b 00             	mov    (%rax),%rax
    1d2e:	48 39 c2             	cmp    %rax,%rdx
    1d31:	75 2d                	jne    1d60 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1d33:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d37:	8b 50 08             	mov    0x8(%rax),%edx
    1d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3e:	48 8b 00             	mov    (%rax),%rax
    1d41:	8b 40 08             	mov    0x8(%rax),%eax
    1d44:	01 c2                	add    %eax,%edx
    1d46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d4a:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1d4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d51:	48 8b 00             	mov    (%rax),%rax
    1d54:	48 8b 10             	mov    (%rax),%rdx
    1d57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d5b:	48 89 10             	mov    %rdx,(%rax)
    1d5e:	eb 0e                	jmp    1d6e <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1d60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d64:	48 8b 10             	mov    (%rax),%rdx
    1d67:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d6b:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1d6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d72:	8b 40 08             	mov    0x8(%rax),%eax
    1d75:	89 c0                	mov    %eax,%eax
    1d77:	48 c1 e0 04          	shl    $0x4,%rax
    1d7b:	48 89 c2             	mov    %rax,%rdx
    1d7e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d82:	48 01 d0             	add    %rdx,%rax
    1d85:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d89:	75 27                	jne    1db2 <free+0x113>
    p->s.size += bp->s.size;
    1d8b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d8f:	8b 50 08             	mov    0x8(%rax),%edx
    1d92:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d96:	8b 40 08             	mov    0x8(%rax),%eax
    1d99:	01 c2                	add    %eax,%edx
    1d9b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9f:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1da2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da6:	48 8b 10             	mov    (%rax),%rdx
    1da9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dad:	48 89 10             	mov    %rdx,(%rax)
    1db0:	eb 0b                	jmp    1dbd <free+0x11e>
  } else
    p->s.ptr = bp;
    1db2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db6:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1dba:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1dbd:	48 ba 10 22 00 00 00 	movabs $0x2210,%rdx
    1dc4:	00 00 00 
    1dc7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dcb:	48 89 02             	mov    %rax,(%rdx)
}
    1dce:	90                   	nop
    1dcf:	c9                   	leave
    1dd0:	c3                   	ret

0000000000001dd1 <morecore>:

static Header*
morecore(uint nu)
{
    1dd1:	55                   	push   %rbp
    1dd2:	48 89 e5             	mov    %rsp,%rbp
    1dd5:	48 83 ec 20          	sub    $0x20,%rsp
    1dd9:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1ddc:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1de3:	77 07                	ja     1dec <morecore+0x1b>
    nu = 4096;
    1de5:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1dec:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1def:	48 c1 e0 04          	shl    $0x4,%rax
    1df3:	48 89 c7             	mov    %rax,%rdi
    1df6:	48 b8 6a 16 00 00 00 	movabs $0x166a,%rax
    1dfd:	00 00 00 
    1e00:	ff d0                	call   *%rax
    1e02:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1e06:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1e0b:	75 07                	jne    1e14 <morecore+0x43>
    return 0;
    1e0d:	b8 00 00 00 00       	mov    $0x0,%eax
    1e12:	eb 36                	jmp    1e4a <morecore+0x79>
  hp = (Header*)p;
    1e14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e18:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1e1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e20:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e23:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1e26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e2a:	48 83 c0 10          	add    $0x10,%rax
    1e2e:	48 89 c7             	mov    %rax,%rdi
    1e31:	48 b8 9f 1c 00 00 00 	movabs $0x1c9f,%rax
    1e38:	00 00 00 
    1e3b:	ff d0                	call   *%rax
  return freep;
    1e3d:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    1e44:	00 00 00 
    1e47:	48 8b 00             	mov    (%rax),%rax
}
    1e4a:	c9                   	leave
    1e4b:	c3                   	ret

0000000000001e4c <malloc>:

void*
malloc(uint nbytes)
{
    1e4c:	55                   	push   %rbp
    1e4d:	48 89 e5             	mov    %rsp,%rbp
    1e50:	48 83 ec 30          	sub    $0x30,%rsp
    1e54:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1e57:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1e5a:	48 83 c0 0f          	add    $0xf,%rax
    1e5e:	48 c1 e8 04          	shr    $0x4,%rax
    1e62:	83 c0 01             	add    $0x1,%eax
    1e65:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1e68:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    1e6f:	00 00 00 
    1e72:	48 8b 00             	mov    (%rax),%rax
    1e75:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e79:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e7e:	75 4a                	jne    1eca <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1e80:	48 b8 00 22 00 00 00 	movabs $0x2200,%rax
    1e87:	00 00 00 
    1e8a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e8e:	48 ba 10 22 00 00 00 	movabs $0x2210,%rdx
    1e95:	00 00 00 
    1e98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e9c:	48 89 02             	mov    %rax,(%rdx)
    1e9f:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    1ea6:	00 00 00 
    1ea9:	48 8b 00             	mov    (%rax),%rax
    1eac:	48 ba 00 22 00 00 00 	movabs $0x2200,%rdx
    1eb3:	00 00 00 
    1eb6:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1eb9:	48 b8 00 22 00 00 00 	movabs $0x2200,%rax
    1ec0:	00 00 00 
    1ec3:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1eca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ece:	48 8b 00             	mov    (%rax),%rax
    1ed1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ed5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ed9:	8b 40 08             	mov    0x8(%rax),%eax
    1edc:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1edf:	72 65                	jb     1f46 <malloc+0xfa>
      if(p->s.size == nunits)
    1ee1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ee5:	8b 40 08             	mov    0x8(%rax),%eax
    1ee8:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1eeb:	75 10                	jne    1efd <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1eed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ef1:	48 8b 10             	mov    (%rax),%rdx
    1ef4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ef8:	48 89 10             	mov    %rdx,(%rax)
    1efb:	eb 2e                	jmp    1f2b <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1efd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f01:	8b 40 08             	mov    0x8(%rax),%eax
    1f04:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1f07:	89 c2                	mov    %eax,%edx
    1f09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f0d:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1f10:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f14:	8b 40 08             	mov    0x8(%rax),%eax
    1f17:	89 c0                	mov    %eax,%eax
    1f19:	48 c1 e0 04          	shl    $0x4,%rax
    1f1d:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1f21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f25:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1f28:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1f2b:	48 ba 10 22 00 00 00 	movabs $0x2210,%rdx
    1f32:	00 00 00 
    1f35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f39:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1f3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f40:	48 83 c0 10          	add    $0x10,%rax
    1f44:	eb 4e                	jmp    1f94 <malloc+0x148>
    }
    if(p == freep)
    1f46:	48 b8 10 22 00 00 00 	movabs $0x2210,%rax
    1f4d:	00 00 00 
    1f50:	48 8b 00             	mov    (%rax),%rax
    1f53:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f57:	75 23                	jne    1f7c <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1f59:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1f5c:	89 c7                	mov    %eax,%edi
    1f5e:	48 b8 d1 1d 00 00 00 	movabs $0x1dd1,%rax
    1f65:	00 00 00 
    1f68:	ff d0                	call   *%rax
    1f6a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f6e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f73:	75 07                	jne    1f7c <malloc+0x130>
        return 0;
    1f75:	b8 00 00 00 00       	mov    $0x0,%eax
    1f7a:	eb 18                	jmp    1f94 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f7c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f80:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f88:	48 8b 00             	mov    (%rax),%rax
    1f8b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f8f:	e9 41 ff ff ff       	jmp    1ed5 <malloc+0x89>
  }
}
    1f94:	c9                   	leave
    1f95:	c3                   	ret
