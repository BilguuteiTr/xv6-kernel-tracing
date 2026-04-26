
_init:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
    1008:	48 b8 bf 1e 00 00 00 	movabs $0x1ebf,%rax
    100f:	00 00 00 
    1012:	be 02 00 00 00       	mov    $0x2,%esi
    1017:	48 89 c7             	mov    %rax,%rdi
    101a:	48 b8 1b 15 00 00 00 	movabs $0x151b,%rax
    1021:	00 00 00 
    1024:	ff d0                	call   *%rax
    1026:	85 c0                	test   %eax,%eax
    1028:	79 41                	jns    106b <main+0x6b>
    mknod("console", 1, 1);
    102a:	48 b8 bf 1e 00 00 00 	movabs $0x1ebf,%rax
    1031:	00 00 00 
    1034:	ba 01 00 00 00       	mov    $0x1,%edx
    1039:	be 01 00 00 00       	mov    $0x1,%esi
    103e:	48 89 c7             	mov    %rax,%rdi
    1041:	48 b8 28 15 00 00 00 	movabs $0x1528,%rax
    1048:	00 00 00 
    104b:	ff d0                	call   *%rax
    open("console", O_RDWR);
    104d:	48 b8 bf 1e 00 00 00 	movabs $0x1ebf,%rax
    1054:	00 00 00 
    1057:	be 02 00 00 00       	mov    $0x2,%esi
    105c:	48 89 c7             	mov    %rax,%rdi
    105f:	48 b8 1b 15 00 00 00 	movabs $0x151b,%rax
    1066:	00 00 00 
    1069:	ff d0                	call   *%rax
  }
  dup(0);  // stdout
    106b:	bf 00 00 00 00       	mov    $0x0,%edi
    1070:	48 b8 76 15 00 00 00 	movabs $0x1576,%rax
    1077:	00 00 00 
    107a:	ff d0                	call   *%rax
  dup(0);  // stderr
    107c:	bf 00 00 00 00       	mov    $0x0,%edi
    1081:	48 b8 76 15 00 00 00 	movabs $0x1576,%rax
    1088:	00 00 00 
    108b:	ff d0                	call   *%rax

  for(;;){
    printf(1, "init: starting sh\n");
    108d:	48 b8 c7 1e 00 00 00 	movabs $0x1ec7,%rax
    1094:	00 00 00 
    1097:	48 89 c6             	mov    %rax,%rsi
    109a:	bf 01 00 00 00       	mov    $0x1,%edi
    109f:	b8 00 00 00 00       	mov    $0x0,%eax
    10a4:	48 ba 9a 17 00 00 00 	movabs $0x179a,%rdx
    10ab:	00 00 00 
    10ae:	ff d2                	call   *%rdx
    pid = fork();
    10b0:	48 b8 a6 14 00 00 00 	movabs $0x14a6,%rax
    10b7:	00 00 00 
    10ba:	ff d0                	call   *%rax
    10bc:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(pid < 0){
    10bf:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10c3:	79 2f                	jns    10f4 <main+0xf4>
      printf(1, "init: fork failed\n");
    10c5:	48 b8 da 1e 00 00 00 	movabs $0x1eda,%rax
    10cc:	00 00 00 
    10cf:	48 89 c6             	mov    %rax,%rsi
    10d2:	bf 01 00 00 00       	mov    $0x1,%edi
    10d7:	b8 00 00 00 00       	mov    $0x0,%eax
    10dc:	48 ba 9a 17 00 00 00 	movabs $0x179a,%rdx
    10e3:	00 00 00 
    10e6:	ff d2                	call   *%rdx
      exit();
    10e8:	48 b8 b3 14 00 00 00 	movabs $0x14b3,%rax
    10ef:	00 00 00 
    10f2:	ff d0                	call   *%rax
    }
    if(pid == 0){
    10f4:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10f8:	75 78                	jne    1172 <main+0x172>
      exec("sh", argv);
    10fa:	48 ba 20 1f 00 00 00 	movabs $0x1f20,%rdx
    1101:	00 00 00 
    1104:	48 b8 bc 1e 00 00 00 	movabs $0x1ebc,%rax
    110b:	00 00 00 
    110e:	48 89 d6             	mov    %rdx,%rsi
    1111:	48 89 c7             	mov    %rax,%rdi
    1114:	48 b8 0e 15 00 00 00 	movabs $0x150e,%rax
    111b:	00 00 00 
    111e:	ff d0                	call   *%rax
      printf(1, "init: exec sh failed\n");
    1120:	48 b8 ed 1e 00 00 00 	movabs $0x1eed,%rax
    1127:	00 00 00 
    112a:	48 89 c6             	mov    %rax,%rsi
    112d:	bf 01 00 00 00       	mov    $0x1,%edi
    1132:	b8 00 00 00 00       	mov    $0x0,%eax
    1137:	48 ba 9a 17 00 00 00 	movabs $0x179a,%rdx
    113e:	00 00 00 
    1141:	ff d2                	call   *%rdx
      exit();
    1143:	48 b8 b3 14 00 00 00 	movabs $0x14b3,%rax
    114a:	00 00 00 
    114d:	ff d0                	call   *%rax
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
    114f:	48 b8 03 1f 00 00 00 	movabs $0x1f03,%rax
    1156:	00 00 00 
    1159:	48 89 c6             	mov    %rax,%rsi
    115c:	bf 01 00 00 00       	mov    $0x1,%edi
    1161:	b8 00 00 00 00       	mov    $0x0,%eax
    1166:	48 ba 9a 17 00 00 00 	movabs $0x179a,%rdx
    116d:	00 00 00 
    1170:	ff d2                	call   *%rdx
    while((wpid=wait()) >= 0 && wpid != pid)
    1172:	48 b8 c0 14 00 00 00 	movabs $0x14c0,%rax
    1179:	00 00 00 
    117c:	ff d0                	call   *%rax
    117e:	89 45 f8             	mov    %eax,-0x8(%rbp)
    1181:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1185:	0f 88 02 ff ff ff    	js     108d <main+0x8d>
    118b:	8b 45 f8             	mov    -0x8(%rbp),%eax
    118e:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    1191:	75 bc                	jne    114f <main+0x14f>
    printf(1, "init: starting sh\n");
    1193:	e9 f5 fe ff ff       	jmp    108d <main+0x8d>

0000000000001198 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1198:	55                   	push   %rbp
    1199:	48 89 e5             	mov    %rsp,%rbp
    119c:	48 83 ec 10          	sub    $0x10,%rsp
    11a0:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11a4:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11a7:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    11aa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11ae:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11b1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11b4:	48 89 ce             	mov    %rcx,%rsi
    11b7:	48 89 f7             	mov    %rsi,%rdi
    11ba:	89 d1                	mov    %edx,%ecx
    11bc:	fc                   	cld
    11bd:	f3 aa                	rep stos %al,(%rdi)
    11bf:	89 ca                	mov    %ecx,%edx
    11c1:	48 89 fe             	mov    %rdi,%rsi
    11c4:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11c8:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11cb:	90                   	nop
    11cc:	c9                   	leave
    11cd:	c3                   	ret

00000000000011ce <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11ce:	55                   	push   %rbp
    11cf:	48 89 e5             	mov    %rsp,%rbp
    11d2:	48 83 ec 20          	sub    $0x20,%rsp
    11d6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11da:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    11de:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11e2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    11e6:	90                   	nop
    11e7:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    11eb:	48 8d 42 01          	lea    0x1(%rdx),%rax
    11ef:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    11f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11f7:	48 8d 48 01          	lea    0x1(%rax),%rcx
    11fb:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    11ff:	0f b6 12             	movzbl (%rdx),%edx
    1202:	88 10                	mov    %dl,(%rax)
    1204:	0f b6 00             	movzbl (%rax),%eax
    1207:	84 c0                	test   %al,%al
    1209:	75 dc                	jne    11e7 <strcpy+0x19>
    ;
  return os;
    120b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    120f:	c9                   	leave
    1210:	c3                   	ret

0000000000001211 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1211:	55                   	push   %rbp
    1212:	48 89 e5             	mov    %rsp,%rbp
    1215:	48 83 ec 10          	sub    $0x10,%rsp
    1219:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    121d:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1221:	eb 0a                	jmp    122d <strcmp+0x1c>
    p++, q++;
    1223:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1228:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    122d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1231:	0f b6 00             	movzbl (%rax),%eax
    1234:	84 c0                	test   %al,%al
    1236:	74 12                	je     124a <strcmp+0x39>
    1238:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    123c:	0f b6 10             	movzbl (%rax),%edx
    123f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1243:	0f b6 00             	movzbl (%rax),%eax
    1246:	38 c2                	cmp    %al,%dl
    1248:	74 d9                	je     1223 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    124a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    124e:	0f b6 00             	movzbl (%rax),%eax
    1251:	0f b6 d0             	movzbl %al,%edx
    1254:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1258:	0f b6 00             	movzbl (%rax),%eax
    125b:	0f b6 c0             	movzbl %al,%eax
    125e:	29 c2                	sub    %eax,%edx
    1260:	89 d0                	mov    %edx,%eax
}
    1262:	c9                   	leave
    1263:	c3                   	ret

0000000000001264 <strlen>:

uint
strlen(char *s)
{
    1264:	55                   	push   %rbp
    1265:	48 89 e5             	mov    %rsp,%rbp
    1268:	48 83 ec 18          	sub    $0x18,%rsp
    126c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1270:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1277:	eb 04                	jmp    127d <strlen+0x19>
    1279:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    127d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1280:	48 63 d0             	movslq %eax,%rdx
    1283:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1287:	48 01 d0             	add    %rdx,%rax
    128a:	0f b6 00             	movzbl (%rax),%eax
    128d:	84 c0                	test   %al,%al
    128f:	75 e8                	jne    1279 <strlen+0x15>
    ;
  return n;
    1291:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1294:	c9                   	leave
    1295:	c3                   	ret

0000000000001296 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1296:	55                   	push   %rbp
    1297:	48 89 e5             	mov    %rsp,%rbp
    129a:	48 83 ec 10          	sub    $0x10,%rsp
    129e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12a2:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12a5:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12a8:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12ab:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12b2:	89 ce                	mov    %ecx,%esi
    12b4:	48 89 c7             	mov    %rax,%rdi
    12b7:	48 b8 98 11 00 00 00 	movabs $0x1198,%rax
    12be:	00 00 00 
    12c1:	ff d0                	call   *%rax
  return dst;
    12c3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12c7:	c9                   	leave
    12c8:	c3                   	ret

00000000000012c9 <strchr>:

char*
strchr(const char *s, char c)
{
    12c9:	55                   	push   %rbp
    12ca:	48 89 e5             	mov    %rsp,%rbp
    12cd:	48 83 ec 10          	sub    $0x10,%rsp
    12d1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12d5:	89 f0                	mov    %esi,%eax
    12d7:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    12da:	eb 17                	jmp    12f3 <strchr+0x2a>
    if(*s == c)
    12dc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12e0:	0f b6 00             	movzbl (%rax),%eax
    12e3:	38 45 f4             	cmp    %al,-0xc(%rbp)
    12e6:	75 06                	jne    12ee <strchr+0x25>
      return (char*)s;
    12e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12ec:	eb 15                	jmp    1303 <strchr+0x3a>
  for(; *s; s++)
    12ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    12f3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12f7:	0f b6 00             	movzbl (%rax),%eax
    12fa:	84 c0                	test   %al,%al
    12fc:	75 de                	jne    12dc <strchr+0x13>
  return 0;
    12fe:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1303:	c9                   	leave
    1304:	c3                   	ret

0000000000001305 <gets>:

char*
gets(char *buf, int max)
{
    1305:	55                   	push   %rbp
    1306:	48 89 e5             	mov    %rsp,%rbp
    1309:	48 83 ec 20          	sub    $0x20,%rsp
    130d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1311:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1314:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    131b:	eb 4f                	jmp    136c <gets+0x67>
    cc = read(0, &c, 1);
    131d:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1321:	ba 01 00 00 00       	mov    $0x1,%edx
    1326:	48 89 c6             	mov    %rax,%rsi
    1329:	bf 00 00 00 00       	mov    $0x0,%edi
    132e:	48 b8 da 14 00 00 00 	movabs $0x14da,%rax
    1335:	00 00 00 
    1338:	ff d0                	call   *%rax
    133a:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    133d:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1341:	7e 36                	jle    1379 <gets+0x74>
      break;
    buf[i++] = c;
    1343:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1346:	8d 50 01             	lea    0x1(%rax),%edx
    1349:	89 55 fc             	mov    %edx,-0x4(%rbp)
    134c:	48 63 d0             	movslq %eax,%rdx
    134f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1353:	48 01 c2             	add    %rax,%rdx
    1356:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    135a:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    135c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1360:	3c 0a                	cmp    $0xa,%al
    1362:	74 16                	je     137a <gets+0x75>
    1364:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1368:	3c 0d                	cmp    $0xd,%al
    136a:	74 0e                	je     137a <gets+0x75>
  for(i=0; i+1 < max; ){
    136c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    136f:	83 c0 01             	add    $0x1,%eax
    1372:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1375:	7f a6                	jg     131d <gets+0x18>
    1377:	eb 01                	jmp    137a <gets+0x75>
      break;
    1379:	90                   	nop
      break;
  }
  buf[i] = '\0';
    137a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    137d:	48 63 d0             	movslq %eax,%rdx
    1380:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1384:	48 01 d0             	add    %rdx,%rax
    1387:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    138a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    138e:	c9                   	leave
    138f:	c3                   	ret

0000000000001390 <stat>:

int
stat(char *n, struct stat *st)
{
    1390:	55                   	push   %rbp
    1391:	48 89 e5             	mov    %rsp,%rbp
    1394:	48 83 ec 20          	sub    $0x20,%rsp
    1398:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    139c:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13a4:	be 00 00 00 00       	mov    $0x0,%esi
    13a9:	48 89 c7             	mov    %rax,%rdi
    13ac:	48 b8 1b 15 00 00 00 	movabs $0x151b,%rax
    13b3:	00 00 00 
    13b6:	ff d0                	call   *%rax
    13b8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    13bb:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    13bf:	79 07                	jns    13c8 <stat+0x38>
    return -1;
    13c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13c6:	eb 2f                	jmp    13f7 <stat+0x67>
  r = fstat(fd, st);
    13c8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    13cc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13cf:	48 89 d6             	mov    %rdx,%rsi
    13d2:	89 c7                	mov    %eax,%edi
    13d4:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    13db:	00 00 00 
    13de:	ff d0                	call   *%rax
    13e0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    13e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13e6:	89 c7                	mov    %eax,%edi
    13e8:	48 b8 f4 14 00 00 00 	movabs $0x14f4,%rax
    13ef:	00 00 00 
    13f2:	ff d0                	call   *%rax
  return r;
    13f4:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    13f7:	c9                   	leave
    13f8:	c3                   	ret

00000000000013f9 <atoi>:

int
atoi(const char *s)
{
    13f9:	55                   	push   %rbp
    13fa:	48 89 e5             	mov    %rsp,%rbp
    13fd:	48 83 ec 18          	sub    $0x18,%rsp
    1401:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1405:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    140c:	eb 28                	jmp    1436 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    140e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1411:	89 d0                	mov    %edx,%eax
    1413:	c1 e0 02             	shl    $0x2,%eax
    1416:	01 d0                	add    %edx,%eax
    1418:	01 c0                	add    %eax,%eax
    141a:	89 c1                	mov    %eax,%ecx
    141c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1420:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1424:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1428:	0f b6 00             	movzbl (%rax),%eax
    142b:	0f be c0             	movsbl %al,%eax
    142e:	01 c8                	add    %ecx,%eax
    1430:	83 e8 30             	sub    $0x30,%eax
    1433:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1436:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    143a:	0f b6 00             	movzbl (%rax),%eax
    143d:	3c 2f                	cmp    $0x2f,%al
    143f:	7e 0b                	jle    144c <atoi+0x53>
    1441:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1445:	0f b6 00             	movzbl (%rax),%eax
    1448:	3c 39                	cmp    $0x39,%al
    144a:	7e c2                	jle    140e <atoi+0x15>
  return n;
    144c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    144f:	c9                   	leave
    1450:	c3                   	ret

0000000000001451 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1451:	55                   	push   %rbp
    1452:	48 89 e5             	mov    %rsp,%rbp
    1455:	48 83 ec 28          	sub    $0x28,%rsp
    1459:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    145d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1461:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1464:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1468:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    146c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1470:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1474:	eb 1d                	jmp    1493 <memmove+0x42>
    *dst++ = *src++;
    1476:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    147a:	48 8d 42 01          	lea    0x1(%rdx),%rax
    147e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1482:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1486:	48 8d 48 01          	lea    0x1(%rax),%rcx
    148a:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    148e:	0f b6 12             	movzbl (%rdx),%edx
    1491:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1493:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1496:	8d 50 ff             	lea    -0x1(%rax),%edx
    1499:	89 55 dc             	mov    %edx,-0x24(%rbp)
    149c:	85 c0                	test   %eax,%eax
    149e:	7f d6                	jg     1476 <memmove+0x25>
  return vdst;
    14a0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14a4:	c9                   	leave
    14a5:	c3                   	ret

00000000000014a6 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    14a6:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    14ad:	49 89 ca             	mov    %rcx,%r10
    14b0:	0f 05                	syscall
    14b2:	c3                   	ret

00000000000014b3 <exit>:
SYSCALL(exit)
    14b3:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    14ba:	49 89 ca             	mov    %rcx,%r10
    14bd:	0f 05                	syscall
    14bf:	c3                   	ret

00000000000014c0 <wait>:
SYSCALL(wait)
    14c0:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    14c7:	49 89 ca             	mov    %rcx,%r10
    14ca:	0f 05                	syscall
    14cc:	c3                   	ret

00000000000014cd <pipe>:
SYSCALL(pipe)
    14cd:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    14d4:	49 89 ca             	mov    %rcx,%r10
    14d7:	0f 05                	syscall
    14d9:	c3                   	ret

00000000000014da <read>:
SYSCALL(read)
    14da:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    14e1:	49 89 ca             	mov    %rcx,%r10
    14e4:	0f 05                	syscall
    14e6:	c3                   	ret

00000000000014e7 <write>:
SYSCALL(write)
    14e7:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    14ee:	49 89 ca             	mov    %rcx,%r10
    14f1:	0f 05                	syscall
    14f3:	c3                   	ret

00000000000014f4 <close>:
SYSCALL(close)
    14f4:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    14fb:	49 89 ca             	mov    %rcx,%r10
    14fe:	0f 05                	syscall
    1500:	c3                   	ret

0000000000001501 <kill>:
SYSCALL(kill)
    1501:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1508:	49 89 ca             	mov    %rcx,%r10
    150b:	0f 05                	syscall
    150d:	c3                   	ret

000000000000150e <exec>:
SYSCALL(exec)
    150e:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1515:	49 89 ca             	mov    %rcx,%r10
    1518:	0f 05                	syscall
    151a:	c3                   	ret

000000000000151b <open>:
SYSCALL(open)
    151b:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1522:	49 89 ca             	mov    %rcx,%r10
    1525:	0f 05                	syscall
    1527:	c3                   	ret

0000000000001528 <mknod>:
SYSCALL(mknod)
    1528:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    152f:	49 89 ca             	mov    %rcx,%r10
    1532:	0f 05                	syscall
    1534:	c3                   	ret

0000000000001535 <unlink>:
SYSCALL(unlink)
    1535:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    153c:	49 89 ca             	mov    %rcx,%r10
    153f:	0f 05                	syscall
    1541:	c3                   	ret

0000000000001542 <fstat>:
SYSCALL(fstat)
    1542:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1549:	49 89 ca             	mov    %rcx,%r10
    154c:	0f 05                	syscall
    154e:	c3                   	ret

000000000000154f <link>:
SYSCALL(link)
    154f:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1556:	49 89 ca             	mov    %rcx,%r10
    1559:	0f 05                	syscall
    155b:	c3                   	ret

000000000000155c <mkdir>:
SYSCALL(mkdir)
    155c:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1563:	49 89 ca             	mov    %rcx,%r10
    1566:	0f 05                	syscall
    1568:	c3                   	ret

0000000000001569 <chdir>:
SYSCALL(chdir)
    1569:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1570:	49 89 ca             	mov    %rcx,%r10
    1573:	0f 05                	syscall
    1575:	c3                   	ret

0000000000001576 <dup>:
SYSCALL(dup)
    1576:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    157d:	49 89 ca             	mov    %rcx,%r10
    1580:	0f 05                	syscall
    1582:	c3                   	ret

0000000000001583 <getpid>:
SYSCALL(getpid)
    1583:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    158a:	49 89 ca             	mov    %rcx,%r10
    158d:	0f 05                	syscall
    158f:	c3                   	ret

0000000000001590 <sbrk>:
SYSCALL(sbrk)
    1590:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1597:	49 89 ca             	mov    %rcx,%r10
    159a:	0f 05                	syscall
    159c:	c3                   	ret

000000000000159d <sleep>:
SYSCALL(sleep)
    159d:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15a4:	49 89 ca             	mov    %rcx,%r10
    15a7:	0f 05                	syscall
    15a9:	c3                   	ret

00000000000015aa <uptime>:
SYSCALL(uptime)
    15aa:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    15b1:	49 89 ca             	mov    %rcx,%r10
    15b4:	0f 05                	syscall
    15b6:	c3                   	ret

00000000000015b7 <traceread>:
SYSCALL(traceread)
    15b7:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    15be:	49 89 ca             	mov    %rcx,%r10
    15c1:	0f 05                	syscall
    15c3:	c3                   	ret

00000000000015c4 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    15c4:	55                   	push   %rbp
    15c5:	48 89 e5             	mov    %rsp,%rbp
    15c8:	48 83 ec 10          	sub    $0x10,%rsp
    15cc:	89 7d fc             	mov    %edi,-0x4(%rbp)
    15cf:	89 f0                	mov    %esi,%eax
    15d1:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    15d4:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    15d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15db:	ba 01 00 00 00       	mov    $0x1,%edx
    15e0:	48 89 ce             	mov    %rcx,%rsi
    15e3:	89 c7                	mov    %eax,%edi
    15e5:	48 b8 e7 14 00 00 00 	movabs $0x14e7,%rax
    15ec:	00 00 00 
    15ef:	ff d0                	call   *%rax
}
    15f1:	90                   	nop
    15f2:	c9                   	leave
    15f3:	c3                   	ret

00000000000015f4 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    15f4:	55                   	push   %rbp
    15f5:	48 89 e5             	mov    %rsp,%rbp
    15f8:	48 83 ec 20          	sub    $0x20,%rsp
    15fc:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15ff:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1603:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    160a:	eb 35                	jmp    1641 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    160c:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1610:	48 c1 e8 3c          	shr    $0x3c,%rax
    1614:	48 ba 30 1f 00 00 00 	movabs $0x1f30,%rdx
    161b:	00 00 00 
    161e:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1622:	0f be d0             	movsbl %al,%edx
    1625:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1628:	89 d6                	mov    %edx,%esi
    162a:	89 c7                	mov    %eax,%edi
    162c:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1633:	00 00 00 
    1636:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1638:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    163c:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1641:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1644:	83 f8 0f             	cmp    $0xf,%eax
    1647:	76 c3                	jbe    160c <print_x64+0x18>
}
    1649:	90                   	nop
    164a:	90                   	nop
    164b:	c9                   	leave
    164c:	c3                   	ret

000000000000164d <print_x32>:

  static void
print_x32(int fd, uint x)
{
    164d:	55                   	push   %rbp
    164e:	48 89 e5             	mov    %rsp,%rbp
    1651:	48 83 ec 20          	sub    $0x20,%rsp
    1655:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1658:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    165b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1662:	eb 36                	jmp    169a <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1664:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1667:	c1 e8 1c             	shr    $0x1c,%eax
    166a:	89 c2                	mov    %eax,%edx
    166c:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1673:	00 00 00 
    1676:	89 d2                	mov    %edx,%edx
    1678:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    167c:	0f be d0             	movsbl %al,%edx
    167f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1682:	89 d6                	mov    %edx,%esi
    1684:	89 c7                	mov    %eax,%edi
    1686:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    168d:	00 00 00 
    1690:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1692:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1696:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    169a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    169d:	83 f8 07             	cmp    $0x7,%eax
    16a0:	76 c2                	jbe    1664 <print_x32+0x17>
}
    16a2:	90                   	nop
    16a3:	90                   	nop
    16a4:	c9                   	leave
    16a5:	c3                   	ret

00000000000016a6 <print_d>:

  static void
print_d(int fd, int v)
{
    16a6:	55                   	push   %rbp
    16a7:	48 89 e5             	mov    %rsp,%rbp
    16aa:	48 83 ec 30          	sub    $0x30,%rsp
    16ae:	89 7d dc             	mov    %edi,-0x24(%rbp)
    16b1:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    16b4:	8b 45 d8             	mov    -0x28(%rbp),%eax
    16b7:	48 98                	cltq
    16b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    16bd:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16c1:	79 04                	jns    16c7 <print_d+0x21>
    x = -x;
    16c3:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    16c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    16ce:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16d2:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    16d9:	66 66 66 
    16dc:	48 89 c8             	mov    %rcx,%rax
    16df:	48 f7 ea             	imul   %rdx
    16e2:	48 c1 fa 02          	sar    $0x2,%rdx
    16e6:	48 89 c8             	mov    %rcx,%rax
    16e9:	48 c1 f8 3f          	sar    $0x3f,%rax
    16ed:	48 29 c2             	sub    %rax,%rdx
    16f0:	48 89 d0             	mov    %rdx,%rax
    16f3:	48 c1 e0 02          	shl    $0x2,%rax
    16f7:	48 01 d0             	add    %rdx,%rax
    16fa:	48 01 c0             	add    %rax,%rax
    16fd:	48 29 c1             	sub    %rax,%rcx
    1700:	48 89 ca             	mov    %rcx,%rdx
    1703:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1706:	8d 48 01             	lea    0x1(%rax),%ecx
    1709:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    170c:	48 b9 30 1f 00 00 00 	movabs $0x1f30,%rcx
    1713:	00 00 00 
    1716:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    171a:	48 98                	cltq
    171c:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1720:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1724:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    172b:	66 66 66 
    172e:	48 89 c8             	mov    %rcx,%rax
    1731:	48 f7 ea             	imul   %rdx
    1734:	48 89 d0             	mov    %rdx,%rax
    1737:	48 c1 f8 02          	sar    $0x2,%rax
    173b:	48 c1 f9 3f          	sar    $0x3f,%rcx
    173f:	48 89 ca             	mov    %rcx,%rdx
    1742:	48 29 d0             	sub    %rdx,%rax
    1745:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1749:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    174e:	0f 85 7a ff ff ff    	jne    16ce <print_d+0x28>

  if (v < 0)
    1754:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1758:	79 32                	jns    178c <print_d+0xe6>
    buf[i++] = '-';
    175a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    175d:	8d 50 01             	lea    0x1(%rax),%edx
    1760:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1763:	48 98                	cltq
    1765:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    176a:	eb 20                	jmp    178c <print_d+0xe6>
    putc(fd, buf[i]);
    176c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    176f:	48 98                	cltq
    1771:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1776:	0f be d0             	movsbl %al,%edx
    1779:	8b 45 dc             	mov    -0x24(%rbp),%eax
    177c:	89 d6                	mov    %edx,%esi
    177e:	89 c7                	mov    %eax,%edi
    1780:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1787:	00 00 00 
    178a:	ff d0                	call   *%rax
  while (--i >= 0)
    178c:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1790:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1794:	79 d6                	jns    176c <print_d+0xc6>
}
    1796:	90                   	nop
    1797:	90                   	nop
    1798:	c9                   	leave
    1799:	c3                   	ret

000000000000179a <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    179a:	55                   	push   %rbp
    179b:	48 89 e5             	mov    %rsp,%rbp
    179e:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    17a5:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    17ab:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    17b2:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    17b9:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    17c0:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    17c7:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    17ce:	84 c0                	test   %al,%al
    17d0:	74 20                	je     17f2 <printf+0x58>
    17d2:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    17d6:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    17da:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    17de:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    17e2:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    17e6:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    17ea:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    17ee:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    17f2:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    17f9:	00 00 00 
    17fc:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1803:	00 00 00 
    1806:	48 8d 45 10          	lea    0x10(%rbp),%rax
    180a:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1811:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1818:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    181f:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1826:	00 00 00 
    1829:	e9 60 03 00 00       	jmp    1b8e <printf+0x3f4>
    if (c != '%') {
    182e:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1835:	74 24                	je     185b <printf+0xc1>
      putc(fd, c);
    1837:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    183d:	0f be d0             	movsbl %al,%edx
    1840:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1846:	89 d6                	mov    %edx,%esi
    1848:	89 c7                	mov    %eax,%edi
    184a:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1851:	00 00 00 
    1854:	ff d0                	call   *%rax
      continue;
    1856:	e9 2c 03 00 00       	jmp    1b87 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    185b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1862:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1868:	48 63 d0             	movslq %eax,%rdx
    186b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1872:	48 01 d0             	add    %rdx,%rax
    1875:	0f b6 00             	movzbl (%rax),%eax
    1878:	0f be c0             	movsbl %al,%eax
    187b:	25 ff 00 00 00       	and    $0xff,%eax
    1880:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1886:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    188d:	0f 84 2e 03 00 00    	je     1bc1 <printf+0x427>
      break;
    switch(c) {
    1893:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    189a:	0f 84 32 01 00 00    	je     19d2 <printf+0x238>
    18a0:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18a7:	0f 8f a1 02 00 00    	jg     1b4e <printf+0x3b4>
    18ad:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18b4:	0f 84 d4 01 00 00    	je     1a8e <printf+0x2f4>
    18ba:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18c1:	0f 8f 87 02 00 00    	jg     1b4e <printf+0x3b4>
    18c7:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    18ce:	0f 84 5b 01 00 00    	je     1a2f <printf+0x295>
    18d4:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    18db:	0f 8f 6d 02 00 00    	jg     1b4e <printf+0x3b4>
    18e1:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    18e8:	0f 84 87 00 00 00    	je     1975 <printf+0x1db>
    18ee:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    18f5:	0f 8f 53 02 00 00    	jg     1b4e <printf+0x3b4>
    18fb:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1902:	0f 84 2b 02 00 00    	je     1b33 <printf+0x399>
    1908:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    190f:	0f 85 39 02 00 00    	jne    1b4e <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1915:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    191b:	83 f8 2f             	cmp    $0x2f,%eax
    191e:	77 23                	ja     1943 <printf+0x1a9>
    1920:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1927:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    192d:	89 d2                	mov    %edx,%edx
    192f:	48 01 d0             	add    %rdx,%rax
    1932:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1938:	83 c2 08             	add    $0x8,%edx
    193b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1941:	eb 12                	jmp    1955 <printf+0x1bb>
    1943:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    194a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    194e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1955:	8b 00                	mov    (%rax),%eax
    1957:	0f be d0             	movsbl %al,%edx
    195a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1960:	89 d6                	mov    %edx,%esi
    1962:	89 c7                	mov    %eax,%edi
    1964:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    196b:	00 00 00 
    196e:	ff d0                	call   *%rax
      break;
    1970:	e9 12 02 00 00       	jmp    1b87 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1975:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    197b:	83 f8 2f             	cmp    $0x2f,%eax
    197e:	77 23                	ja     19a3 <printf+0x209>
    1980:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1987:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    198d:	89 d2                	mov    %edx,%edx
    198f:	48 01 d0             	add    %rdx,%rax
    1992:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1998:	83 c2 08             	add    $0x8,%edx
    199b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19a1:	eb 12                	jmp    19b5 <printf+0x21b>
    19a3:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19aa:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ae:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19b5:	8b 10                	mov    (%rax),%edx
    19b7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19bd:	89 d6                	mov    %edx,%esi
    19bf:	89 c7                	mov    %eax,%edi
    19c1:	48 b8 a6 16 00 00 00 	movabs $0x16a6,%rax
    19c8:	00 00 00 
    19cb:	ff d0                	call   *%rax
      break;
    19cd:	e9 b5 01 00 00       	jmp    1b87 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    19d2:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19d8:	83 f8 2f             	cmp    $0x2f,%eax
    19db:	77 23                	ja     1a00 <printf+0x266>
    19dd:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ea:	89 d2                	mov    %edx,%edx
    19ec:	48 01 d0             	add    %rdx,%rax
    19ef:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19f5:	83 c2 08             	add    $0x8,%edx
    19f8:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19fe:	eb 12                	jmp    1a12 <printf+0x278>
    1a00:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a07:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a0b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a12:	8b 10                	mov    (%rax),%edx
    1a14:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a1a:	89 d6                	mov    %edx,%esi
    1a1c:	89 c7                	mov    %eax,%edi
    1a1e:	48 b8 4d 16 00 00 00 	movabs $0x164d,%rax
    1a25:	00 00 00 
    1a28:	ff d0                	call   *%rax
      break;
    1a2a:	e9 58 01 00 00       	jmp    1b87 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a2f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a35:	83 f8 2f             	cmp    $0x2f,%eax
    1a38:	77 23                	ja     1a5d <printf+0x2c3>
    1a3a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a41:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a47:	89 d2                	mov    %edx,%edx
    1a49:	48 01 d0             	add    %rdx,%rax
    1a4c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a52:	83 c2 08             	add    $0x8,%edx
    1a55:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a5b:	eb 12                	jmp    1a6f <printf+0x2d5>
    1a5d:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a64:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a68:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a6f:	48 8b 10             	mov    (%rax),%rdx
    1a72:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a78:	48 89 d6             	mov    %rdx,%rsi
    1a7b:	89 c7                	mov    %eax,%edi
    1a7d:	48 b8 f4 15 00 00 00 	movabs $0x15f4,%rax
    1a84:	00 00 00 
    1a87:	ff d0                	call   *%rax
      break;
    1a89:	e9 f9 00 00 00       	jmp    1b87 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1a8e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a94:	83 f8 2f             	cmp    $0x2f,%eax
    1a97:	77 23                	ja     1abc <printf+0x322>
    1a99:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1aa0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aa6:	89 d2                	mov    %edx,%edx
    1aa8:	48 01 d0             	add    %rdx,%rax
    1aab:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ab1:	83 c2 08             	add    $0x8,%edx
    1ab4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1aba:	eb 12                	jmp    1ace <printf+0x334>
    1abc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ac3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ac7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ace:	48 8b 00             	mov    (%rax),%rax
    1ad1:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1ad8:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1adf:	00 
    1ae0:	75 41                	jne    1b23 <printf+0x389>
        s = "(null)";
    1ae2:	48 b8 0c 1f 00 00 00 	movabs $0x1f0c,%rax
    1ae9:	00 00 00 
    1aec:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1af3:	eb 2e                	jmp    1b23 <printf+0x389>
        putc(fd, *(s++));
    1af5:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1afc:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b00:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b07:	0f b6 00             	movzbl (%rax),%eax
    1b0a:	0f be d0             	movsbl %al,%edx
    1b0d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b13:	89 d6                	mov    %edx,%esi
    1b15:	89 c7                	mov    %eax,%edi
    1b17:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1b1e:	00 00 00 
    1b21:	ff d0                	call   *%rax
      while (*s)
    1b23:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b2a:	0f b6 00             	movzbl (%rax),%eax
    1b2d:	84 c0                	test   %al,%al
    1b2f:	75 c4                	jne    1af5 <printf+0x35b>
      break;
    1b31:	eb 54                	jmp    1b87 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1b33:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b39:	be 25 00 00 00       	mov    $0x25,%esi
    1b3e:	89 c7                	mov    %eax,%edi
    1b40:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1b47:	00 00 00 
    1b4a:	ff d0                	call   *%rax
      break;
    1b4c:	eb 39                	jmp    1b87 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b4e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b54:	be 25 00 00 00       	mov    $0x25,%esi
    1b59:	89 c7                	mov    %eax,%edi
    1b5b:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1b62:	00 00 00 
    1b65:	ff d0                	call   *%rax
      putc(fd, c);
    1b67:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b6d:	0f be d0             	movsbl %al,%edx
    1b70:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b76:	89 d6                	mov    %edx,%esi
    1b78:	89 c7                	mov    %eax,%edi
    1b7a:	48 b8 c4 15 00 00 00 	movabs $0x15c4,%rax
    1b81:	00 00 00 
    1b84:	ff d0                	call   *%rax
      break;
    1b86:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1b87:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1b8e:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1b94:	48 63 d0             	movslq %eax,%rdx
    1b97:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1b9e:	48 01 d0             	add    %rdx,%rax
    1ba1:	0f b6 00             	movzbl (%rax),%eax
    1ba4:	0f be c0             	movsbl %al,%eax
    1ba7:	25 ff 00 00 00       	and    $0xff,%eax
    1bac:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1bb2:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1bb9:	0f 85 6f fc ff ff    	jne    182e <printf+0x94>
    }
  }
}
    1bbf:	eb 01                	jmp    1bc2 <printf+0x428>
      break;
    1bc1:	90                   	nop
}
    1bc2:	90                   	nop
    1bc3:	c9                   	leave
    1bc4:	c3                   	ret

0000000000001bc5 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1bc5:	55                   	push   %rbp
    1bc6:	48 89 e5             	mov    %rsp,%rbp
    1bc9:	48 83 ec 18          	sub    $0x18,%rsp
    1bcd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1bd1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bd5:	48 83 e8 10          	sub    $0x10,%rax
    1bd9:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1bdd:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1be4:	00 00 00 
    1be7:	48 8b 00             	mov    (%rax),%rax
    1bea:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1bee:	eb 2f                	jmp    1c1f <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1bf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf4:	48 8b 00             	mov    (%rax),%rax
    1bf7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1bfb:	72 17                	jb     1c14 <free+0x4f>
    1bfd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c01:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c05:	72 2f                	jb     1c36 <free+0x71>
    1c07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c0b:	48 8b 00             	mov    (%rax),%rax
    1c0e:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c12:	72 22                	jb     1c36 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c18:	48 8b 00             	mov    (%rax),%rax
    1c1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c1f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c23:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c27:	73 c7                	jae    1bf0 <free+0x2b>
    1c29:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c2d:	48 8b 00             	mov    (%rax),%rax
    1c30:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c34:	73 ba                	jae    1bf0 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c3a:	8b 40 08             	mov    0x8(%rax),%eax
    1c3d:	89 c0                	mov    %eax,%eax
    1c3f:	48 c1 e0 04          	shl    $0x4,%rax
    1c43:	48 89 c2             	mov    %rax,%rdx
    1c46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c4a:	48 01 c2             	add    %rax,%rdx
    1c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c51:	48 8b 00             	mov    (%rax),%rax
    1c54:	48 39 c2             	cmp    %rax,%rdx
    1c57:	75 2d                	jne    1c86 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1c59:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c5d:	8b 50 08             	mov    0x8(%rax),%edx
    1c60:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c64:	48 8b 00             	mov    (%rax),%rax
    1c67:	8b 40 08             	mov    0x8(%rax),%eax
    1c6a:	01 c2                	add    %eax,%edx
    1c6c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c70:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1c73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c77:	48 8b 00             	mov    (%rax),%rax
    1c7a:	48 8b 10             	mov    (%rax),%rdx
    1c7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c81:	48 89 10             	mov    %rdx,(%rax)
    1c84:	eb 0e                	jmp    1c94 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1c86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c8a:	48 8b 10             	mov    (%rax),%rdx
    1c8d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c91:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c98:	8b 40 08             	mov    0x8(%rax),%eax
    1c9b:	89 c0                	mov    %eax,%eax
    1c9d:	48 c1 e0 04          	shl    $0x4,%rax
    1ca1:	48 89 c2             	mov    %rax,%rdx
    1ca4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca8:	48 01 d0             	add    %rdx,%rax
    1cab:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1caf:	75 27                	jne    1cd8 <free+0x113>
    p->s.size += bp->s.size;
    1cb1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb5:	8b 50 08             	mov    0x8(%rax),%edx
    1cb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbc:	8b 40 08             	mov    0x8(%rax),%eax
    1cbf:	01 c2                	add    %eax,%edx
    1cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc5:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1cc8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ccc:	48 8b 10             	mov    (%rax),%rdx
    1ccf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd3:	48 89 10             	mov    %rdx,(%rax)
    1cd6:	eb 0b                	jmp    1ce3 <free+0x11e>
  } else
    p->s.ptr = bp;
    1cd8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cdc:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1ce0:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1ce3:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1cea:	00 00 00 
    1ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf1:	48 89 02             	mov    %rax,(%rdx)
}
    1cf4:	90                   	nop
    1cf5:	c9                   	leave
    1cf6:	c3                   	ret

0000000000001cf7 <morecore>:

static Header*
morecore(uint nu)
{
    1cf7:	55                   	push   %rbp
    1cf8:	48 89 e5             	mov    %rsp,%rbp
    1cfb:	48 83 ec 20          	sub    $0x20,%rsp
    1cff:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d02:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d09:	77 07                	ja     1d12 <morecore+0x1b>
    nu = 4096;
    1d0b:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d12:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d15:	48 c1 e0 04          	shl    $0x4,%rax
    1d19:	48 89 c7             	mov    %rax,%rdi
    1d1c:	48 b8 90 15 00 00 00 	movabs $0x1590,%rax
    1d23:	00 00 00 
    1d26:	ff d0                	call   *%rax
    1d28:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d2c:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d31:	75 07                	jne    1d3a <morecore+0x43>
    return 0;
    1d33:	b8 00 00 00 00       	mov    $0x0,%eax
    1d38:	eb 36                	jmp    1d70 <morecore+0x79>
  hp = (Header*)p;
    1d3a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1d42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d46:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d49:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1d4c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d50:	48 83 c0 10          	add    $0x10,%rax
    1d54:	48 89 c7             	mov    %rax,%rdi
    1d57:	48 b8 c5 1b 00 00 00 	movabs $0x1bc5,%rax
    1d5e:	00 00 00 
    1d61:	ff d0                	call   *%rax
  return freep;
    1d63:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1d6a:	00 00 00 
    1d6d:	48 8b 00             	mov    (%rax),%rax
}
    1d70:	c9                   	leave
    1d71:	c3                   	ret

0000000000001d72 <malloc>:

void*
malloc(uint nbytes)
{
    1d72:	55                   	push   %rbp
    1d73:	48 89 e5             	mov    %rsp,%rbp
    1d76:	48 83 ec 30          	sub    $0x30,%rsp
    1d7a:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1d7d:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1d80:	48 83 c0 0f          	add    $0xf,%rax
    1d84:	48 c1 e8 04          	shr    $0x4,%rax
    1d88:	83 c0 01             	add    $0x1,%eax
    1d8b:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1d8e:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1d95:	00 00 00 
    1d98:	48 8b 00             	mov    (%rax),%rax
    1d9b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d9f:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1da4:	75 4a                	jne    1df0 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1da6:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1dad:	00 00 00 
    1db0:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1db4:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1dbb:	00 00 00 
    1dbe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dc2:	48 89 02             	mov    %rax,(%rdx)
    1dc5:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1dcc:	00 00 00 
    1dcf:	48 8b 00             	mov    (%rax),%rax
    1dd2:	48 ba 50 1f 00 00 00 	movabs $0x1f50,%rdx
    1dd9:	00 00 00 
    1ddc:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1ddf:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1de6:	00 00 00 
    1de9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1df0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1df4:	48 8b 00             	mov    (%rax),%rax
    1df7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1dfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dff:	8b 40 08             	mov    0x8(%rax),%eax
    1e02:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e05:	72 65                	jb     1e6c <malloc+0xfa>
      if(p->s.size == nunits)
    1e07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e0b:	8b 40 08             	mov    0x8(%rax),%eax
    1e0e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e11:	75 10                	jne    1e23 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1e13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e17:	48 8b 10             	mov    (%rax),%rdx
    1e1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e1e:	48 89 10             	mov    %rdx,(%rax)
    1e21:	eb 2e                	jmp    1e51 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1e23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e27:	8b 40 08             	mov    0x8(%rax),%eax
    1e2a:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e2d:	89 c2                	mov    %eax,%edx
    1e2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e33:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1e36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e3a:	8b 40 08             	mov    0x8(%rax),%eax
    1e3d:	89 c0                	mov    %eax,%eax
    1e3f:	48 c1 e0 04          	shl    $0x4,%rax
    1e43:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1e47:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e4b:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e4e:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1e51:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1e58:	00 00 00 
    1e5b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e5f:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1e62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e66:	48 83 c0 10          	add    $0x10,%rax
    1e6a:	eb 4e                	jmp    1eba <malloc+0x148>
    }
    if(p == freep)
    1e6c:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1e73:	00 00 00 
    1e76:	48 8b 00             	mov    (%rax),%rax
    1e79:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1e7d:	75 23                	jne    1ea2 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1e7f:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e82:	89 c7                	mov    %eax,%edi
    1e84:	48 b8 f7 1c 00 00 00 	movabs $0x1cf7,%rax
    1e8b:	00 00 00 
    1e8e:	ff d0                	call   *%rax
    1e90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e94:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1e99:	75 07                	jne    1ea2 <malloc+0x130>
        return 0;
    1e9b:	b8 00 00 00 00       	mov    $0x0,%eax
    1ea0:	eb 18                	jmp    1eba <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ea2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1eaa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eae:	48 8b 00             	mov    (%rax),%rax
    1eb1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1eb5:	e9 41 ff ff ff       	jmp    1dfb <malloc+0x89>
  }
}
    1eba:	c9                   	leave
    1ebb:	c3                   	ret
