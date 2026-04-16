
_cat:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <cat>:

char buf[512];

void
cat(int fd)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 20          	sub    $0x20,%rsp
    1008:	89 7d ec             	mov    %edi,-0x14(%rbp)
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    100b:	eb 57                	jmp    1064 <cat+0x64>
    if (write(1, buf, n) != n) {
    100d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1010:	48 b9 60 1f 00 00 00 	movabs $0x1f60,%rcx
    1017:	00 00 00 
    101a:	89 c2                	mov    %eax,%edx
    101c:	48 89 ce             	mov    %rcx,%rsi
    101f:	bf 01 00 00 00       	mov    $0x1,%edi
    1024:	48 b8 14 15 00 00 00 	movabs $0x1514,%rax
    102b:	00 00 00 
    102e:	ff d0                	call   *%rax
    1030:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    1033:	74 2f                	je     1064 <cat+0x64>
      printf(1, "cat: write error\n");
    1035:	48 b8 e9 1e 00 00 00 	movabs $0x1ee9,%rax
    103c:	00 00 00 
    103f:	48 89 c6             	mov    %rax,%rsi
    1042:	bf 01 00 00 00       	mov    $0x1,%edi
    1047:	b8 00 00 00 00       	mov    $0x0,%eax
    104c:	48 ba c7 17 00 00 00 	movabs $0x17c7,%rdx
    1053:	00 00 00 
    1056:	ff d2                	call   *%rdx
      exit();
    1058:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    105f:	00 00 00 
    1062:	ff d0                	call   *%rax
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    1064:	48 b9 60 1f 00 00 00 	movabs $0x1f60,%rcx
    106b:	00 00 00 
    106e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1071:	ba 00 02 00 00       	mov    $0x200,%edx
    1076:	48 89 ce             	mov    %rcx,%rsi
    1079:	89 c7                	mov    %eax,%edi
    107b:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1082:	00 00 00 
    1085:	ff d0                	call   *%rax
    1087:	89 45 fc             	mov    %eax,-0x4(%rbp)
    108a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    108e:	0f 8f 79 ff ff ff    	jg     100d <cat+0xd>
    }
  }
  if(n < 0){
    1094:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1098:	79 2f                	jns    10c9 <cat+0xc9>
    printf(1, "cat: read error\n");
    109a:	48 b8 fb 1e 00 00 00 	movabs $0x1efb,%rax
    10a1:	00 00 00 
    10a4:	48 89 c6             	mov    %rax,%rsi
    10a7:	bf 01 00 00 00       	mov    $0x1,%edi
    10ac:	b8 00 00 00 00       	mov    $0x0,%eax
    10b1:	48 ba c7 17 00 00 00 	movabs $0x17c7,%rdx
    10b8:	00 00 00 
    10bb:	ff d2                	call   *%rdx
    exit();
    10bd:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    10c4:	00 00 00 
    10c7:	ff d0                	call   *%rax
  }
}
    10c9:	90                   	nop
    10ca:	c9                   	leave
    10cb:	c3                   	ret

00000000000010cc <main>:

int
main(int argc, char *argv[])
{
    10cc:	55                   	push   %rbp
    10cd:	48 89 e5             	mov    %rsp,%rbp
    10d0:	48 83 ec 20          	sub    $0x20,%rsp
    10d4:	89 7d ec             	mov    %edi,-0x14(%rbp)
    10d7:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd, i;

  if(argc <= 1){
    10db:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    10df:	7f 1d                	jg     10fe <main+0x32>
    cat(0);
    10e1:	bf 00 00 00 00       	mov    $0x0,%edi
    10e6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10ed:	00 00 00 
    10f0:	ff d0                	call   *%rax
    exit();
    10f2:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    10f9:	00 00 00 
    10fc:	ff d0                	call   *%rax
  }

  for(i = 1; i < argc; i++){
    10fe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    1105:	e9 a3 00 00 00       	jmp    11ad <main+0xe1>
    if((fd = open(argv[i], 0)) < 0){
    110a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    110d:	48 98                	cltq
    110f:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1116:	00 
    1117:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    111b:	48 01 d0             	add    %rdx,%rax
    111e:	48 8b 00             	mov    (%rax),%rax
    1121:	be 00 00 00 00       	mov    $0x0,%esi
    1126:	48 89 c7             	mov    %rax,%rdi
    1129:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    1130:	00 00 00 
    1133:	ff d0                	call   *%rax
    1135:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1138:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    113c:	79 49                	jns    1187 <main+0xbb>
      printf(1, "cat: cannot open %s\n", argv[i]);
    113e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1141:	48 98                	cltq
    1143:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    114a:	00 
    114b:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    114f:	48 01 d0             	add    %rdx,%rax
    1152:	48 8b 00             	mov    (%rax),%rax
    1155:	48 b9 0c 1f 00 00 00 	movabs $0x1f0c,%rcx
    115c:	00 00 00 
    115f:	48 89 c2             	mov    %rax,%rdx
    1162:	48 89 ce             	mov    %rcx,%rsi
    1165:	bf 01 00 00 00       	mov    $0x1,%edi
    116a:	b8 00 00 00 00       	mov    $0x0,%eax
    116f:	48 b9 c7 17 00 00 00 	movabs $0x17c7,%rcx
    1176:	00 00 00 
    1179:	ff d1                	call   *%rcx
      exit();
    117b:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    1182:	00 00 00 
    1185:	ff d0                	call   *%rax
    }
    cat(fd);
    1187:	8b 45 f8             	mov    -0x8(%rbp),%eax
    118a:	89 c7                	mov    %eax,%edi
    118c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1193:	00 00 00 
    1196:	ff d0                	call   *%rax
    close(fd);
    1198:	8b 45 f8             	mov    -0x8(%rbp),%eax
    119b:	89 c7                	mov    %eax,%edi
    119d:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    11a4:	00 00 00 
    11a7:	ff d0                	call   *%rax
  for(i = 1; i < argc; i++){
    11a9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11ad:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11b0:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    11b3:	0f 8c 51 ff ff ff    	jl     110a <main+0x3e>
  }
  exit();
    11b9:	48 b8 e0 14 00 00 00 	movabs $0x14e0,%rax
    11c0:	00 00 00 
    11c3:	ff d0                	call   *%rax

00000000000011c5 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11c5:	55                   	push   %rbp
    11c6:	48 89 e5             	mov    %rsp,%rbp
    11c9:	48 83 ec 10          	sub    $0x10,%rsp
    11cd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d1:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11d4:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    11d7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11db:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11de:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11e1:	48 89 ce             	mov    %rcx,%rsi
    11e4:	48 89 f7             	mov    %rsi,%rdi
    11e7:	89 d1                	mov    %edx,%ecx
    11e9:	fc                   	cld
    11ea:	f3 aa                	rep stos %al,(%rdi)
    11ec:	89 ca                	mov    %ecx,%edx
    11ee:	48 89 fe             	mov    %rdi,%rsi
    11f1:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11f5:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11f8:	90                   	nop
    11f9:	c9                   	leave
    11fa:	c3                   	ret

00000000000011fb <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11fb:	55                   	push   %rbp
    11fc:	48 89 e5             	mov    %rsp,%rbp
    11ff:	48 83 ec 20          	sub    $0x20,%rsp
    1203:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1207:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    120b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    120f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1213:	90                   	nop
    1214:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1218:	48 8d 42 01          	lea    0x1(%rdx),%rax
    121c:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1220:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1224:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1228:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    122c:	0f b6 12             	movzbl (%rdx),%edx
    122f:	88 10                	mov    %dl,(%rax)
    1231:	0f b6 00             	movzbl (%rax),%eax
    1234:	84 c0                	test   %al,%al
    1236:	75 dc                	jne    1214 <strcpy+0x19>
    ;
  return os;
    1238:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    123c:	c9                   	leave
    123d:	c3                   	ret

000000000000123e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    123e:	55                   	push   %rbp
    123f:	48 89 e5             	mov    %rsp,%rbp
    1242:	48 83 ec 10          	sub    $0x10,%rsp
    1246:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    124a:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    124e:	eb 0a                	jmp    125a <strcmp+0x1c>
    p++, q++;
    1250:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1255:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    125a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    125e:	0f b6 00             	movzbl (%rax),%eax
    1261:	84 c0                	test   %al,%al
    1263:	74 12                	je     1277 <strcmp+0x39>
    1265:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1269:	0f b6 10             	movzbl (%rax),%edx
    126c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1270:	0f b6 00             	movzbl (%rax),%eax
    1273:	38 c2                	cmp    %al,%dl
    1275:	74 d9                	je     1250 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1277:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    127b:	0f b6 00             	movzbl (%rax),%eax
    127e:	0f b6 d0             	movzbl %al,%edx
    1281:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1285:	0f b6 00             	movzbl (%rax),%eax
    1288:	0f b6 c0             	movzbl %al,%eax
    128b:	29 c2                	sub    %eax,%edx
    128d:	89 d0                	mov    %edx,%eax
}
    128f:	c9                   	leave
    1290:	c3                   	ret

0000000000001291 <strlen>:

uint
strlen(char *s)
{
    1291:	55                   	push   %rbp
    1292:	48 89 e5             	mov    %rsp,%rbp
    1295:	48 83 ec 18          	sub    $0x18,%rsp
    1299:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    129d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12a4:	eb 04                	jmp    12aa <strlen+0x19>
    12a6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12aa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12ad:	48 63 d0             	movslq %eax,%rdx
    12b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12b4:	48 01 d0             	add    %rdx,%rax
    12b7:	0f b6 00             	movzbl (%rax),%eax
    12ba:	84 c0                	test   %al,%al
    12bc:	75 e8                	jne    12a6 <strlen+0x15>
    ;
  return n;
    12be:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12c1:	c9                   	leave
    12c2:	c3                   	ret

00000000000012c3 <memset>:

void*
memset(void *dst, int c, uint n)
{
    12c3:	55                   	push   %rbp
    12c4:	48 89 e5             	mov    %rsp,%rbp
    12c7:	48 83 ec 10          	sub    $0x10,%rsp
    12cb:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12cf:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12d2:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12d5:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12d8:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12db:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12df:	89 ce                	mov    %ecx,%esi
    12e1:	48 89 c7             	mov    %rax,%rdi
    12e4:	48 b8 c5 11 00 00 00 	movabs $0x11c5,%rax
    12eb:	00 00 00 
    12ee:	ff d0                	call   *%rax
  return dst;
    12f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12f4:	c9                   	leave
    12f5:	c3                   	ret

00000000000012f6 <strchr>:

char*
strchr(const char *s, char c)
{
    12f6:	55                   	push   %rbp
    12f7:	48 89 e5             	mov    %rsp,%rbp
    12fa:	48 83 ec 10          	sub    $0x10,%rsp
    12fe:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1302:	89 f0                	mov    %esi,%eax
    1304:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1307:	eb 17                	jmp    1320 <strchr+0x2a>
    if(*s == c)
    1309:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    130d:	0f b6 00             	movzbl (%rax),%eax
    1310:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1313:	75 06                	jne    131b <strchr+0x25>
      return (char*)s;
    1315:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1319:	eb 15                	jmp    1330 <strchr+0x3a>
  for(; *s; s++)
    131b:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1320:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1324:	0f b6 00             	movzbl (%rax),%eax
    1327:	84 c0                	test   %al,%al
    1329:	75 de                	jne    1309 <strchr+0x13>
  return 0;
    132b:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1330:	c9                   	leave
    1331:	c3                   	ret

0000000000001332 <gets>:

char*
gets(char *buf, int max)
{
    1332:	55                   	push   %rbp
    1333:	48 89 e5             	mov    %rsp,%rbp
    1336:	48 83 ec 20          	sub    $0x20,%rsp
    133a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    133e:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1341:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1348:	eb 4f                	jmp    1399 <gets+0x67>
    cc = read(0, &c, 1);
    134a:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    134e:	ba 01 00 00 00       	mov    $0x1,%edx
    1353:	48 89 c6             	mov    %rax,%rsi
    1356:	bf 00 00 00 00       	mov    $0x0,%edi
    135b:	48 b8 07 15 00 00 00 	movabs $0x1507,%rax
    1362:	00 00 00 
    1365:	ff d0                	call   *%rax
    1367:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    136a:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    136e:	7e 36                	jle    13a6 <gets+0x74>
      break;
    buf[i++] = c;
    1370:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1373:	8d 50 01             	lea    0x1(%rax),%edx
    1376:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1379:	48 63 d0             	movslq %eax,%rdx
    137c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1380:	48 01 c2             	add    %rax,%rdx
    1383:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1387:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1389:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    138d:	3c 0a                	cmp    $0xa,%al
    138f:	74 16                	je     13a7 <gets+0x75>
    1391:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1395:	3c 0d                	cmp    $0xd,%al
    1397:	74 0e                	je     13a7 <gets+0x75>
  for(i=0; i+1 < max; ){
    1399:	8b 45 fc             	mov    -0x4(%rbp),%eax
    139c:	83 c0 01             	add    $0x1,%eax
    139f:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13a2:	7f a6                	jg     134a <gets+0x18>
    13a4:	eb 01                	jmp    13a7 <gets+0x75>
      break;
    13a6:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13a7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13aa:	48 63 d0             	movslq %eax,%rdx
    13ad:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13b1:	48 01 d0             	add    %rdx,%rax
    13b4:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13b7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13bb:	c9                   	leave
    13bc:	c3                   	ret

00000000000013bd <stat>:

int
stat(char *n, struct stat *st)
{
    13bd:	55                   	push   %rbp
    13be:	48 89 e5             	mov    %rsp,%rbp
    13c1:	48 83 ec 20          	sub    $0x20,%rsp
    13c5:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13c9:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13d1:	be 00 00 00 00       	mov    $0x0,%esi
    13d6:	48 89 c7             	mov    %rax,%rdi
    13d9:	48 b8 48 15 00 00 00 	movabs $0x1548,%rax
    13e0:	00 00 00 
    13e3:	ff d0                	call   *%rax
    13e5:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    13e8:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    13ec:	79 07                	jns    13f5 <stat+0x38>
    return -1;
    13ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13f3:	eb 2f                	jmp    1424 <stat+0x67>
  r = fstat(fd, st);
    13f5:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    13f9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13fc:	48 89 d6             	mov    %rdx,%rsi
    13ff:	89 c7                	mov    %eax,%edi
    1401:	48 b8 6f 15 00 00 00 	movabs $0x156f,%rax
    1408:	00 00 00 
    140b:	ff d0                	call   *%rax
    140d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1410:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1413:	89 c7                	mov    %eax,%edi
    1415:	48 b8 21 15 00 00 00 	movabs $0x1521,%rax
    141c:	00 00 00 
    141f:	ff d0                	call   *%rax
  return r;
    1421:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1424:	c9                   	leave
    1425:	c3                   	ret

0000000000001426 <atoi>:

int
atoi(const char *s)
{
    1426:	55                   	push   %rbp
    1427:	48 89 e5             	mov    %rsp,%rbp
    142a:	48 83 ec 18          	sub    $0x18,%rsp
    142e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1432:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1439:	eb 28                	jmp    1463 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    143b:	8b 55 fc             	mov    -0x4(%rbp),%edx
    143e:	89 d0                	mov    %edx,%eax
    1440:	c1 e0 02             	shl    $0x2,%eax
    1443:	01 d0                	add    %edx,%eax
    1445:	01 c0                	add    %eax,%eax
    1447:	89 c1                	mov    %eax,%ecx
    1449:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    144d:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1451:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1455:	0f b6 00             	movzbl (%rax),%eax
    1458:	0f be c0             	movsbl %al,%eax
    145b:	01 c8                	add    %ecx,%eax
    145d:	83 e8 30             	sub    $0x30,%eax
    1460:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1463:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1467:	0f b6 00             	movzbl (%rax),%eax
    146a:	3c 2f                	cmp    $0x2f,%al
    146c:	7e 0b                	jle    1479 <atoi+0x53>
    146e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1472:	0f b6 00             	movzbl (%rax),%eax
    1475:	3c 39                	cmp    $0x39,%al
    1477:	7e c2                	jle    143b <atoi+0x15>
  return n;
    1479:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    147c:	c9                   	leave
    147d:	c3                   	ret

000000000000147e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    147e:	55                   	push   %rbp
    147f:	48 89 e5             	mov    %rsp,%rbp
    1482:	48 83 ec 28          	sub    $0x28,%rsp
    1486:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    148a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    148e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1491:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1495:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1499:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    149d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14a1:	eb 1d                	jmp    14c0 <memmove+0x42>
    *dst++ = *src++;
    14a3:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14a7:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14ab:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14b3:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14b7:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14bb:	0f b6 12             	movzbl (%rdx),%edx
    14be:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14c0:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14c3:	8d 50 ff             	lea    -0x1(%rax),%edx
    14c6:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14c9:	85 c0                	test   %eax,%eax
    14cb:	7f d6                	jg     14a3 <memmove+0x25>
  return vdst;
    14cd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14d1:	c9                   	leave
    14d2:	c3                   	ret

00000000000014d3 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    14d3:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    14da:	49 89 ca             	mov    %rcx,%r10
    14dd:	0f 05                	syscall
    14df:	c3                   	ret

00000000000014e0 <exit>:
SYSCALL(exit)
    14e0:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    14e7:	49 89 ca             	mov    %rcx,%r10
    14ea:	0f 05                	syscall
    14ec:	c3                   	ret

00000000000014ed <wait>:
SYSCALL(wait)
    14ed:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    14f4:	49 89 ca             	mov    %rcx,%r10
    14f7:	0f 05                	syscall
    14f9:	c3                   	ret

00000000000014fa <pipe>:
SYSCALL(pipe)
    14fa:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1501:	49 89 ca             	mov    %rcx,%r10
    1504:	0f 05                	syscall
    1506:	c3                   	ret

0000000000001507 <read>:
SYSCALL(read)
    1507:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    150e:	49 89 ca             	mov    %rcx,%r10
    1511:	0f 05                	syscall
    1513:	c3                   	ret

0000000000001514 <write>:
SYSCALL(write)
    1514:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    151b:	49 89 ca             	mov    %rcx,%r10
    151e:	0f 05                	syscall
    1520:	c3                   	ret

0000000000001521 <close>:
SYSCALL(close)
    1521:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1528:	49 89 ca             	mov    %rcx,%r10
    152b:	0f 05                	syscall
    152d:	c3                   	ret

000000000000152e <kill>:
SYSCALL(kill)
    152e:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1535:	49 89 ca             	mov    %rcx,%r10
    1538:	0f 05                	syscall
    153a:	c3                   	ret

000000000000153b <exec>:
SYSCALL(exec)
    153b:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1542:	49 89 ca             	mov    %rcx,%r10
    1545:	0f 05                	syscall
    1547:	c3                   	ret

0000000000001548 <open>:
SYSCALL(open)
    1548:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    154f:	49 89 ca             	mov    %rcx,%r10
    1552:	0f 05                	syscall
    1554:	c3                   	ret

0000000000001555 <mknod>:
SYSCALL(mknod)
    1555:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    155c:	49 89 ca             	mov    %rcx,%r10
    155f:	0f 05                	syscall
    1561:	c3                   	ret

0000000000001562 <unlink>:
SYSCALL(unlink)
    1562:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1569:	49 89 ca             	mov    %rcx,%r10
    156c:	0f 05                	syscall
    156e:	c3                   	ret

000000000000156f <fstat>:
SYSCALL(fstat)
    156f:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1576:	49 89 ca             	mov    %rcx,%r10
    1579:	0f 05                	syscall
    157b:	c3                   	ret

000000000000157c <link>:
SYSCALL(link)
    157c:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1583:	49 89 ca             	mov    %rcx,%r10
    1586:	0f 05                	syscall
    1588:	c3                   	ret

0000000000001589 <mkdir>:
SYSCALL(mkdir)
    1589:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1590:	49 89 ca             	mov    %rcx,%r10
    1593:	0f 05                	syscall
    1595:	c3                   	ret

0000000000001596 <chdir>:
SYSCALL(chdir)
    1596:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    159d:	49 89 ca             	mov    %rcx,%r10
    15a0:	0f 05                	syscall
    15a2:	c3                   	ret

00000000000015a3 <dup>:
SYSCALL(dup)
    15a3:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15aa:	49 89 ca             	mov    %rcx,%r10
    15ad:	0f 05                	syscall
    15af:	c3                   	ret

00000000000015b0 <getpid>:
SYSCALL(getpid)
    15b0:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15b7:	49 89 ca             	mov    %rcx,%r10
    15ba:	0f 05                	syscall
    15bc:	c3                   	ret

00000000000015bd <sbrk>:
SYSCALL(sbrk)
    15bd:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15c4:	49 89 ca             	mov    %rcx,%r10
    15c7:	0f 05                	syscall
    15c9:	c3                   	ret

00000000000015ca <sleep>:
SYSCALL(sleep)
    15ca:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15d1:	49 89 ca             	mov    %rcx,%r10
    15d4:	0f 05                	syscall
    15d6:	c3                   	ret

00000000000015d7 <uptime>:
SYSCALL(uptime)
    15d7:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    15de:	49 89 ca             	mov    %rcx,%r10
    15e1:	0f 05                	syscall
    15e3:	c3                   	ret

00000000000015e4 <mmap>:
SYSCALL(mmap)
    15e4:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    15eb:	49 89 ca             	mov    %rcx,%r10
    15ee:	0f 05                	syscall
    15f0:	c3                   	ret

00000000000015f1 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    15f1:	55                   	push   %rbp
    15f2:	48 89 e5             	mov    %rsp,%rbp
    15f5:	48 83 ec 10          	sub    $0x10,%rsp
    15f9:	89 7d fc             	mov    %edi,-0x4(%rbp)
    15fc:	89 f0                	mov    %esi,%eax
    15fe:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1601:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1605:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1608:	ba 01 00 00 00       	mov    $0x1,%edx
    160d:	48 89 ce             	mov    %rcx,%rsi
    1610:	89 c7                	mov    %eax,%edi
    1612:	48 b8 14 15 00 00 00 	movabs $0x1514,%rax
    1619:	00 00 00 
    161c:	ff d0                	call   *%rax
}
    161e:	90                   	nop
    161f:	c9                   	leave
    1620:	c3                   	ret

0000000000001621 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1621:	55                   	push   %rbp
    1622:	48 89 e5             	mov    %rsp,%rbp
    1625:	48 83 ec 20          	sub    $0x20,%rsp
    1629:	89 7d ec             	mov    %edi,-0x14(%rbp)
    162c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1630:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1637:	eb 35                	jmp    166e <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1639:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    163d:	48 c1 e8 3c          	shr    $0x3c,%rax
    1641:	48 ba 30 1f 00 00 00 	movabs $0x1f30,%rdx
    1648:	00 00 00 
    164b:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    164f:	0f be d0             	movsbl %al,%edx
    1652:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1655:	89 d6                	mov    %edx,%esi
    1657:	89 c7                	mov    %eax,%edi
    1659:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    1660:	00 00 00 
    1663:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1665:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1669:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    166e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1671:	83 f8 0f             	cmp    $0xf,%eax
    1674:	76 c3                	jbe    1639 <print_x64+0x18>
}
    1676:	90                   	nop
    1677:	90                   	nop
    1678:	c9                   	leave
    1679:	c3                   	ret

000000000000167a <print_x32>:

  static void
print_x32(int fd, uint x)
{
    167a:	55                   	push   %rbp
    167b:	48 89 e5             	mov    %rsp,%rbp
    167e:	48 83 ec 20          	sub    $0x20,%rsp
    1682:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1685:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1688:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    168f:	eb 36                	jmp    16c7 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1691:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1694:	c1 e8 1c             	shr    $0x1c,%eax
    1697:	89 c2                	mov    %eax,%edx
    1699:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    16a0:	00 00 00 
    16a3:	89 d2                	mov    %edx,%edx
    16a5:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16a9:	0f be d0             	movsbl %al,%edx
    16ac:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16af:	89 d6                	mov    %edx,%esi
    16b1:	89 c7                	mov    %eax,%edi
    16b3:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    16ba:	00 00 00 
    16bd:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16bf:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16c3:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    16c7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16ca:	83 f8 07             	cmp    $0x7,%eax
    16cd:	76 c2                	jbe    1691 <print_x32+0x17>
}
    16cf:	90                   	nop
    16d0:	90                   	nop
    16d1:	c9                   	leave
    16d2:	c3                   	ret

00000000000016d3 <print_d>:

  static void
print_d(int fd, int v)
{
    16d3:	55                   	push   %rbp
    16d4:	48 89 e5             	mov    %rsp,%rbp
    16d7:	48 83 ec 30          	sub    $0x30,%rsp
    16db:	89 7d dc             	mov    %edi,-0x24(%rbp)
    16de:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    16e1:	8b 45 d8             	mov    -0x28(%rbp),%eax
    16e4:	48 98                	cltq
    16e6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    16ea:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16ee:	79 04                	jns    16f4 <print_d+0x21>
    x = -x;
    16f0:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    16f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    16fb:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16ff:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1706:	66 66 66 
    1709:	48 89 c8             	mov    %rcx,%rax
    170c:	48 f7 ea             	imul   %rdx
    170f:	48 c1 fa 02          	sar    $0x2,%rdx
    1713:	48 89 c8             	mov    %rcx,%rax
    1716:	48 c1 f8 3f          	sar    $0x3f,%rax
    171a:	48 29 c2             	sub    %rax,%rdx
    171d:	48 89 d0             	mov    %rdx,%rax
    1720:	48 c1 e0 02          	shl    $0x2,%rax
    1724:	48 01 d0             	add    %rdx,%rax
    1727:	48 01 c0             	add    %rax,%rax
    172a:	48 29 c1             	sub    %rax,%rcx
    172d:	48 89 ca             	mov    %rcx,%rdx
    1730:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1733:	8d 48 01             	lea    0x1(%rax),%ecx
    1736:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1739:	48 b9 30 1f 00 00 00 	movabs $0x1f30,%rcx
    1740:	00 00 00 
    1743:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1747:	48 98                	cltq
    1749:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    174d:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1751:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1758:	66 66 66 
    175b:	48 89 c8             	mov    %rcx,%rax
    175e:	48 f7 ea             	imul   %rdx
    1761:	48 89 d0             	mov    %rdx,%rax
    1764:	48 c1 f8 02          	sar    $0x2,%rax
    1768:	48 c1 f9 3f          	sar    $0x3f,%rcx
    176c:	48 89 ca             	mov    %rcx,%rdx
    176f:	48 29 d0             	sub    %rdx,%rax
    1772:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1776:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    177b:	0f 85 7a ff ff ff    	jne    16fb <print_d+0x28>

  if (v < 0)
    1781:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1785:	79 32                	jns    17b9 <print_d+0xe6>
    buf[i++] = '-';
    1787:	8b 45 f4             	mov    -0xc(%rbp),%eax
    178a:	8d 50 01             	lea    0x1(%rax),%edx
    178d:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1790:	48 98                	cltq
    1792:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1797:	eb 20                	jmp    17b9 <print_d+0xe6>
    putc(fd, buf[i]);
    1799:	8b 45 f4             	mov    -0xc(%rbp),%eax
    179c:	48 98                	cltq
    179e:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17a3:	0f be d0             	movsbl %al,%edx
    17a6:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17a9:	89 d6                	mov    %edx,%esi
    17ab:	89 c7                	mov    %eax,%edi
    17ad:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    17b4:	00 00 00 
    17b7:	ff d0                	call   *%rax
  while (--i >= 0)
    17b9:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    17bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17c1:	79 d6                	jns    1799 <print_d+0xc6>
}
    17c3:	90                   	nop
    17c4:	90                   	nop
    17c5:	c9                   	leave
    17c6:	c3                   	ret

00000000000017c7 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    17c7:	55                   	push   %rbp
    17c8:	48 89 e5             	mov    %rsp,%rbp
    17cb:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    17d2:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    17d8:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    17df:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    17e6:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    17ed:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    17f4:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    17fb:	84 c0                	test   %al,%al
    17fd:	74 20                	je     181f <printf+0x58>
    17ff:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1803:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1807:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    180b:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    180f:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1813:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1817:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    181b:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    181f:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1826:	00 00 00 
    1829:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1830:	00 00 00 
    1833:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1837:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    183e:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1845:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    184c:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1853:	00 00 00 
    1856:	e9 60 03 00 00       	jmp    1bbb <printf+0x3f4>
    if (c != '%') {
    185b:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1862:	74 24                	je     1888 <printf+0xc1>
      putc(fd, c);
    1864:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    186a:	0f be d0             	movsbl %al,%edx
    186d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1873:	89 d6                	mov    %edx,%esi
    1875:	89 c7                	mov    %eax,%edi
    1877:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    187e:	00 00 00 
    1881:	ff d0                	call   *%rax
      continue;
    1883:	e9 2c 03 00 00       	jmp    1bb4 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1888:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    188f:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1895:	48 63 d0             	movslq %eax,%rdx
    1898:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    189f:	48 01 d0             	add    %rdx,%rax
    18a2:	0f b6 00             	movzbl (%rax),%eax
    18a5:	0f be c0             	movsbl %al,%eax
    18a8:	25 ff 00 00 00       	and    $0xff,%eax
    18ad:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18b3:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    18ba:	0f 84 2e 03 00 00    	je     1bee <printf+0x427>
      break;
    switch(c) {
    18c0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18c7:	0f 84 32 01 00 00    	je     19ff <printf+0x238>
    18cd:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18d4:	0f 8f a1 02 00 00    	jg     1b7b <printf+0x3b4>
    18da:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18e1:	0f 84 d4 01 00 00    	je     1abb <printf+0x2f4>
    18e7:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18ee:	0f 8f 87 02 00 00    	jg     1b7b <printf+0x3b4>
    18f4:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    18fb:	0f 84 5b 01 00 00    	je     1a5c <printf+0x295>
    1901:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1908:	0f 8f 6d 02 00 00    	jg     1b7b <printf+0x3b4>
    190e:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1915:	0f 84 87 00 00 00    	je     19a2 <printf+0x1db>
    191b:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1922:	0f 8f 53 02 00 00    	jg     1b7b <printf+0x3b4>
    1928:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    192f:	0f 84 2b 02 00 00    	je     1b60 <printf+0x399>
    1935:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    193c:	0f 85 39 02 00 00    	jne    1b7b <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1942:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1948:	83 f8 2f             	cmp    $0x2f,%eax
    194b:	77 23                	ja     1970 <printf+0x1a9>
    194d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1954:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    195a:	89 d2                	mov    %edx,%edx
    195c:	48 01 d0             	add    %rdx,%rax
    195f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1965:	83 c2 08             	add    $0x8,%edx
    1968:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    196e:	eb 12                	jmp    1982 <printf+0x1bb>
    1970:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1977:	48 8d 50 08          	lea    0x8(%rax),%rdx
    197b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1982:	8b 00                	mov    (%rax),%eax
    1984:	0f be d0             	movsbl %al,%edx
    1987:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    198d:	89 d6                	mov    %edx,%esi
    198f:	89 c7                	mov    %eax,%edi
    1991:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    1998:	00 00 00 
    199b:	ff d0                	call   *%rax
      break;
    199d:	e9 12 02 00 00       	jmp    1bb4 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19a2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19a8:	83 f8 2f             	cmp    $0x2f,%eax
    19ab:	77 23                	ja     19d0 <printf+0x209>
    19ad:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19b4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ba:	89 d2                	mov    %edx,%edx
    19bc:	48 01 d0             	add    %rdx,%rax
    19bf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c5:	83 c2 08             	add    $0x8,%edx
    19c8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19ce:	eb 12                	jmp    19e2 <printf+0x21b>
    19d0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19d7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19db:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19e2:	8b 10                	mov    (%rax),%edx
    19e4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19ea:	89 d6                	mov    %edx,%esi
    19ec:	89 c7                	mov    %eax,%edi
    19ee:	48 b8 d3 16 00 00 00 	movabs $0x16d3,%rax
    19f5:	00 00 00 
    19f8:	ff d0                	call   *%rax
      break;
    19fa:	e9 b5 01 00 00       	jmp    1bb4 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    19ff:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a05:	83 f8 2f             	cmp    $0x2f,%eax
    1a08:	77 23                	ja     1a2d <printf+0x266>
    1a0a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a11:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a17:	89 d2                	mov    %edx,%edx
    1a19:	48 01 d0             	add    %rdx,%rax
    1a1c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a22:	83 c2 08             	add    $0x8,%edx
    1a25:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a2b:	eb 12                	jmp    1a3f <printf+0x278>
    1a2d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a34:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a38:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a3f:	8b 10                	mov    (%rax),%edx
    1a41:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a47:	89 d6                	mov    %edx,%esi
    1a49:	89 c7                	mov    %eax,%edi
    1a4b:	48 b8 7a 16 00 00 00 	movabs $0x167a,%rax
    1a52:	00 00 00 
    1a55:	ff d0                	call   *%rax
      break;
    1a57:	e9 58 01 00 00       	jmp    1bb4 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a5c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a62:	83 f8 2f             	cmp    $0x2f,%eax
    1a65:	77 23                	ja     1a8a <printf+0x2c3>
    1a67:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a6e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a74:	89 d2                	mov    %edx,%edx
    1a76:	48 01 d0             	add    %rdx,%rax
    1a79:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a7f:	83 c2 08             	add    $0x8,%edx
    1a82:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a88:	eb 12                	jmp    1a9c <printf+0x2d5>
    1a8a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a91:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a95:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a9c:	48 8b 10             	mov    (%rax),%rdx
    1a9f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa5:	48 89 d6             	mov    %rdx,%rsi
    1aa8:	89 c7                	mov    %eax,%edi
    1aaa:	48 b8 21 16 00 00 00 	movabs $0x1621,%rax
    1ab1:	00 00 00 
    1ab4:	ff d0                	call   *%rax
      break;
    1ab6:	e9 f9 00 00 00       	jmp    1bb4 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1abb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ac1:	83 f8 2f             	cmp    $0x2f,%eax
    1ac4:	77 23                	ja     1ae9 <printf+0x322>
    1ac6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1acd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ad3:	89 d2                	mov    %edx,%edx
    1ad5:	48 01 d0             	add    %rdx,%rax
    1ad8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ade:	83 c2 08             	add    $0x8,%edx
    1ae1:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ae7:	eb 12                	jmp    1afb <printf+0x334>
    1ae9:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1af0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1af4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1afb:	48 8b 00             	mov    (%rax),%rax
    1afe:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b05:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b0c:	00 
    1b0d:	75 41                	jne    1b50 <printf+0x389>
        s = "(null)";
    1b0f:	48 b8 21 1f 00 00 00 	movabs $0x1f21,%rax
    1b16:	00 00 00 
    1b19:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b20:	eb 2e                	jmp    1b50 <printf+0x389>
        putc(fd, *(s++));
    1b22:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b29:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b2d:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b34:	0f b6 00             	movzbl (%rax),%eax
    1b37:	0f be d0             	movsbl %al,%edx
    1b3a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b40:	89 d6                	mov    %edx,%esi
    1b42:	89 c7                	mov    %eax,%edi
    1b44:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    1b4b:	00 00 00 
    1b4e:	ff d0                	call   *%rax
      while (*s)
    1b50:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b57:	0f b6 00             	movzbl (%rax),%eax
    1b5a:	84 c0                	test   %al,%al
    1b5c:	75 c4                	jne    1b22 <printf+0x35b>
      break;
    1b5e:	eb 54                	jmp    1bb4 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1b60:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b66:	be 25 00 00 00       	mov    $0x25,%esi
    1b6b:	89 c7                	mov    %eax,%edi
    1b6d:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    1b74:	00 00 00 
    1b77:	ff d0                	call   *%rax
      break;
    1b79:	eb 39                	jmp    1bb4 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b7b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b81:	be 25 00 00 00       	mov    $0x25,%esi
    1b86:	89 c7                	mov    %eax,%edi
    1b88:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    1b8f:	00 00 00 
    1b92:	ff d0                	call   *%rax
      putc(fd, c);
    1b94:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b9a:	0f be d0             	movsbl %al,%edx
    1b9d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ba3:	89 d6                	mov    %edx,%esi
    1ba5:	89 c7                	mov    %eax,%edi
    1ba7:	48 b8 f1 15 00 00 00 	movabs $0x15f1,%rax
    1bae:	00 00 00 
    1bb1:	ff d0                	call   *%rax
      break;
    1bb3:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bb4:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bbb:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bc1:	48 63 d0             	movslq %eax,%rdx
    1bc4:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bcb:	48 01 d0             	add    %rdx,%rax
    1bce:	0f b6 00             	movzbl (%rax),%eax
    1bd1:	0f be c0             	movsbl %al,%eax
    1bd4:	25 ff 00 00 00       	and    $0xff,%eax
    1bd9:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1bdf:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1be6:	0f 85 6f fc ff ff    	jne    185b <printf+0x94>
    }
  }
}
    1bec:	eb 01                	jmp    1bef <printf+0x428>
      break;
    1bee:	90                   	nop
}
    1bef:	90                   	nop
    1bf0:	c9                   	leave
    1bf1:	c3                   	ret

0000000000001bf2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1bf2:	55                   	push   %rbp
    1bf3:	48 89 e5             	mov    %rsp,%rbp
    1bf6:	48 83 ec 18          	sub    $0x18,%rsp
    1bfa:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1bfe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c02:	48 83 e8 10          	sub    $0x10,%rax
    1c06:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c0a:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1c11:	00 00 00 
    1c14:	48 8b 00             	mov    (%rax),%rax
    1c17:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c1b:	eb 2f                	jmp    1c4c <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c1d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c21:	48 8b 00             	mov    (%rax),%rax
    1c24:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c28:	72 17                	jb     1c41 <free+0x4f>
    1c2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c2e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c32:	72 2f                	jb     1c63 <free+0x71>
    1c34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c38:	48 8b 00             	mov    (%rax),%rax
    1c3b:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c3f:	72 22                	jb     1c63 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c41:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c45:	48 8b 00             	mov    (%rax),%rax
    1c48:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c50:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c54:	73 c7                	jae    1c1d <free+0x2b>
    1c56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c5a:	48 8b 00             	mov    (%rax),%rax
    1c5d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c61:	73 ba                	jae    1c1d <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c67:	8b 40 08             	mov    0x8(%rax),%eax
    1c6a:	89 c0                	mov    %eax,%eax
    1c6c:	48 c1 e0 04          	shl    $0x4,%rax
    1c70:	48 89 c2             	mov    %rax,%rdx
    1c73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c77:	48 01 c2             	add    %rax,%rdx
    1c7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c7e:	48 8b 00             	mov    (%rax),%rax
    1c81:	48 39 c2             	cmp    %rax,%rdx
    1c84:	75 2d                	jne    1cb3 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1c86:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c8a:	8b 50 08             	mov    0x8(%rax),%edx
    1c8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c91:	48 8b 00             	mov    (%rax),%rax
    1c94:	8b 40 08             	mov    0x8(%rax),%eax
    1c97:	01 c2                	add    %eax,%edx
    1c99:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c9d:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca4:	48 8b 00             	mov    (%rax),%rax
    1ca7:	48 8b 10             	mov    (%rax),%rdx
    1caa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cae:	48 89 10             	mov    %rdx,(%rax)
    1cb1:	eb 0e                	jmp    1cc1 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1cb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb7:	48 8b 10             	mov    (%rax),%rdx
    1cba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbe:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc5:	8b 40 08             	mov    0x8(%rax),%eax
    1cc8:	89 c0                	mov    %eax,%eax
    1cca:	48 c1 e0 04          	shl    $0x4,%rax
    1cce:	48 89 c2             	mov    %rax,%rdx
    1cd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd5:	48 01 d0             	add    %rdx,%rax
    1cd8:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cdc:	75 27                	jne    1d05 <free+0x113>
    p->s.size += bp->s.size;
    1cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce2:	8b 50 08             	mov    0x8(%rax),%edx
    1ce5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce9:	8b 40 08             	mov    0x8(%rax),%eax
    1cec:	01 c2                	add    %eax,%edx
    1cee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf2:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1cf5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf9:	48 8b 10             	mov    (%rax),%rdx
    1cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d00:	48 89 10             	mov    %rdx,(%rax)
    1d03:	eb 0b                	jmp    1d10 <free+0x11e>
  } else
    p->s.ptr = bp;
    1d05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d09:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d0d:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d10:	48 ba 70 21 00 00 00 	movabs $0x2170,%rdx
    1d17:	00 00 00 
    1d1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1e:	48 89 02             	mov    %rax,(%rdx)
}
    1d21:	90                   	nop
    1d22:	c9                   	leave
    1d23:	c3                   	ret

0000000000001d24 <morecore>:

static Header*
morecore(uint nu)
{
    1d24:	55                   	push   %rbp
    1d25:	48 89 e5             	mov    %rsp,%rbp
    1d28:	48 83 ec 20          	sub    $0x20,%rsp
    1d2c:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d2f:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d36:	77 07                	ja     1d3f <morecore+0x1b>
    nu = 4096;
    1d38:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d3f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d42:	48 c1 e0 04          	shl    $0x4,%rax
    1d46:	48 89 c7             	mov    %rax,%rdi
    1d49:	48 b8 bd 15 00 00 00 	movabs $0x15bd,%rax
    1d50:	00 00 00 
    1d53:	ff d0                	call   *%rax
    1d55:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d59:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d5e:	75 07                	jne    1d67 <morecore+0x43>
    return 0;
    1d60:	b8 00 00 00 00       	mov    $0x0,%eax
    1d65:	eb 36                	jmp    1d9d <morecore+0x79>
  hp = (Header*)p;
    1d67:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1d6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d73:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d76:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1d79:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d7d:	48 83 c0 10          	add    $0x10,%rax
    1d81:	48 89 c7             	mov    %rax,%rdi
    1d84:	48 b8 f2 1b 00 00 00 	movabs $0x1bf2,%rax
    1d8b:	00 00 00 
    1d8e:	ff d0                	call   *%rax
  return freep;
    1d90:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1d97:	00 00 00 
    1d9a:	48 8b 00             	mov    (%rax),%rax
}
    1d9d:	c9                   	leave
    1d9e:	c3                   	ret

0000000000001d9f <malloc>:

void*
malloc(uint nbytes)
{
    1d9f:	55                   	push   %rbp
    1da0:	48 89 e5             	mov    %rsp,%rbp
    1da3:	48 83 ec 30          	sub    $0x30,%rsp
    1da7:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1daa:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1dad:	48 83 c0 0f          	add    $0xf,%rax
    1db1:	48 c1 e8 04          	shr    $0x4,%rax
    1db5:	83 c0 01             	add    $0x1,%eax
    1db8:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1dbb:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1dc2:	00 00 00 
    1dc5:	48 8b 00             	mov    (%rax),%rax
    1dc8:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dcc:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1dd1:	75 4a                	jne    1e1d <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1dd3:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1dda:	00 00 00 
    1ddd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1de1:	48 ba 70 21 00 00 00 	movabs $0x2170,%rdx
    1de8:	00 00 00 
    1deb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1def:	48 89 02             	mov    %rax,(%rdx)
    1df2:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1df9:	00 00 00 
    1dfc:	48 8b 00             	mov    (%rax),%rax
    1dff:	48 ba 60 21 00 00 00 	movabs $0x2160,%rdx
    1e06:	00 00 00 
    1e09:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e0c:	48 b8 60 21 00 00 00 	movabs $0x2160,%rax
    1e13:	00 00 00 
    1e16:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e1d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e21:	48 8b 00             	mov    (%rax),%rax
    1e24:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2c:	8b 40 08             	mov    0x8(%rax),%eax
    1e2f:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e32:	72 65                	jb     1e99 <malloc+0xfa>
      if(p->s.size == nunits)
    1e34:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e38:	8b 40 08             	mov    0x8(%rax),%eax
    1e3b:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e3e:	75 10                	jne    1e50 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1e40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e44:	48 8b 10             	mov    (%rax),%rdx
    1e47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e4b:	48 89 10             	mov    %rdx,(%rax)
    1e4e:	eb 2e                	jmp    1e7e <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1e50:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e54:	8b 40 08             	mov    0x8(%rax),%eax
    1e57:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e5a:	89 c2                	mov    %eax,%edx
    1e5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e60:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1e63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e67:	8b 40 08             	mov    0x8(%rax),%eax
    1e6a:	89 c0                	mov    %eax,%eax
    1e6c:	48 c1 e0 04          	shl    $0x4,%rax
    1e70:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1e74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e78:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e7b:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1e7e:	48 ba 70 21 00 00 00 	movabs $0x2170,%rdx
    1e85:	00 00 00 
    1e88:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e8c:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1e8f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e93:	48 83 c0 10          	add    $0x10,%rax
    1e97:	eb 4e                	jmp    1ee7 <malloc+0x148>
    }
    if(p == freep)
    1e99:	48 b8 70 21 00 00 00 	movabs $0x2170,%rax
    1ea0:	00 00 00 
    1ea3:	48 8b 00             	mov    (%rax),%rax
    1ea6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1eaa:	75 23                	jne    1ecf <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1eac:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1eaf:	89 c7                	mov    %eax,%edi
    1eb1:	48 b8 24 1d 00 00 00 	movabs $0x1d24,%rax
    1eb8:	00 00 00 
    1ebb:	ff d0                	call   *%rax
    1ebd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ec1:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ec6:	75 07                	jne    1ecf <malloc+0x130>
        return 0;
    1ec8:	b8 00 00 00 00       	mov    $0x0,%eax
    1ecd:	eb 18                	jmp    1ee7 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ecf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ed3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ed7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1edb:	48 8b 00             	mov    (%rax),%rax
    1ede:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ee2:	e9 41 ff ff ff       	jmp    1e28 <malloc+0x89>
  }
}
    1ee7:	c9                   	leave
    1ee8:	c3                   	ret
