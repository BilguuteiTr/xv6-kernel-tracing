
_zombie:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
  if(fork() > 0)
    1004:	48 b8 3f 13 00 00 00 	movabs $0x133f,%rax
    100b:	00 00 00 
    100e:	ff d0                	call   *%rax
    1010:	85 c0                	test   %eax,%eax
    1012:	7e 11                	jle    1025 <main+0x25>
    sleep(5);  // Let child exit before parent.
    1014:	bf 05 00 00 00       	mov    $0x5,%edi
    1019:	48 b8 36 14 00 00 00 	movabs $0x1436,%rax
    1020:	00 00 00 
    1023:	ff d0                	call   *%rax
  exit();
    1025:	48 b8 4c 13 00 00 00 	movabs $0x134c,%rax
    102c:	00 00 00 
    102f:	ff d0                	call   *%rax

0000000000001031 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1031:	55                   	push   %rbp
    1032:	48 89 e5             	mov    %rsp,%rbp
    1035:	48 83 ec 10          	sub    $0x10,%rsp
    1039:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    103d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1040:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    1043:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1047:	8b 55 f0             	mov    -0x10(%rbp),%edx
    104a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    104d:	48 89 ce             	mov    %rcx,%rsi
    1050:	48 89 f7             	mov    %rsi,%rdi
    1053:	89 d1                	mov    %edx,%ecx
    1055:	fc                   	cld
    1056:	f3 aa                	rep stos %al,(%rdi)
    1058:	89 ca                	mov    %ecx,%edx
    105a:	48 89 fe             	mov    %rdi,%rsi
    105d:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1061:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1064:	90                   	nop
    1065:	c9                   	leave
    1066:	c3                   	ret

0000000000001067 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1067:	55                   	push   %rbp
    1068:	48 89 e5             	mov    %rsp,%rbp
    106b:	48 83 ec 20          	sub    $0x20,%rsp
    106f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1073:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    1077:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    107b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    107f:	90                   	nop
    1080:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1084:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1088:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    108c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1090:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1094:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1098:	0f b6 12             	movzbl (%rdx),%edx
    109b:	88 10                	mov    %dl,(%rax)
    109d:	0f b6 00             	movzbl (%rax),%eax
    10a0:	84 c0                	test   %al,%al
    10a2:	75 dc                	jne    1080 <strcpy+0x19>
    ;
  return os;
    10a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    10a8:	c9                   	leave
    10a9:	c3                   	ret

00000000000010aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10aa:	55                   	push   %rbp
    10ab:	48 89 e5             	mov    %rsp,%rbp
    10ae:	48 83 ec 10          	sub    $0x10,%rsp
    10b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    10ba:	eb 0a                	jmp    10c6 <strcmp+0x1c>
    p++, q++;
    10bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    10c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    10c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10ca:	0f b6 00             	movzbl (%rax),%eax
    10cd:	84 c0                	test   %al,%al
    10cf:	74 12                	je     10e3 <strcmp+0x39>
    10d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10d5:	0f b6 10             	movzbl (%rax),%edx
    10d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10dc:	0f b6 00             	movzbl (%rax),%eax
    10df:	38 c2                	cmp    %al,%dl
    10e1:	74 d9                	je     10bc <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    10e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10e7:	0f b6 00             	movzbl (%rax),%eax
    10ea:	0f b6 d0             	movzbl %al,%edx
    10ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10f1:	0f b6 00             	movzbl (%rax),%eax
    10f4:	0f b6 c0             	movzbl %al,%eax
    10f7:	29 c2                	sub    %eax,%edx
    10f9:	89 d0                	mov    %edx,%eax
}
    10fb:	c9                   	leave
    10fc:	c3                   	ret

00000000000010fd <strlen>:

uint
strlen(char *s)
{
    10fd:	55                   	push   %rbp
    10fe:	48 89 e5             	mov    %rsp,%rbp
    1101:	48 83 ec 18          	sub    $0x18,%rsp
    1105:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1109:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1110:	eb 04                	jmp    1116 <strlen+0x19>
    1112:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1116:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1119:	48 63 d0             	movslq %eax,%rdx
    111c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1120:	48 01 d0             	add    %rdx,%rax
    1123:	0f b6 00             	movzbl (%rax),%eax
    1126:	84 c0                	test   %al,%al
    1128:	75 e8                	jne    1112 <strlen+0x15>
    ;
  return n;
    112a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    112d:	c9                   	leave
    112e:	c3                   	ret

000000000000112f <memset>:

void*
memset(void *dst, int c, uint n)
{
    112f:	55                   	push   %rbp
    1130:	48 89 e5             	mov    %rsp,%rbp
    1133:	48 83 ec 10          	sub    $0x10,%rsp
    1137:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    113b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    113e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1141:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1144:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1147:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    114b:	89 ce                	mov    %ecx,%esi
    114d:	48 89 c7             	mov    %rax,%rdi
    1150:	48 b8 31 10 00 00 00 	movabs $0x1031,%rax
    1157:	00 00 00 
    115a:	ff d0                	call   *%rax
  return dst;
    115c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1160:	c9                   	leave
    1161:	c3                   	ret

0000000000001162 <strchr>:

char*
strchr(const char *s, char c)
{
    1162:	55                   	push   %rbp
    1163:	48 89 e5             	mov    %rsp,%rbp
    1166:	48 83 ec 10          	sub    $0x10,%rsp
    116a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    116e:	89 f0                	mov    %esi,%eax
    1170:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1173:	eb 17                	jmp    118c <strchr+0x2a>
    if(*s == c)
    1175:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1179:	0f b6 00             	movzbl (%rax),%eax
    117c:	38 45 f4             	cmp    %al,-0xc(%rbp)
    117f:	75 06                	jne    1187 <strchr+0x25>
      return (char*)s;
    1181:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1185:	eb 15                	jmp    119c <strchr+0x3a>
  for(; *s; s++)
    1187:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    118c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1190:	0f b6 00             	movzbl (%rax),%eax
    1193:	84 c0                	test   %al,%al
    1195:	75 de                	jne    1175 <strchr+0x13>
  return 0;
    1197:	b8 00 00 00 00       	mov    $0x0,%eax
}
    119c:	c9                   	leave
    119d:	c3                   	ret

000000000000119e <gets>:

char*
gets(char *buf, int max)
{
    119e:	55                   	push   %rbp
    119f:	48 89 e5             	mov    %rsp,%rbp
    11a2:	48 83 ec 20          	sub    $0x20,%rsp
    11a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11aa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11b4:	eb 4f                	jmp    1205 <gets+0x67>
    cc = read(0, &c, 1);
    11b6:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    11ba:	ba 01 00 00 00       	mov    $0x1,%edx
    11bf:	48 89 c6             	mov    %rax,%rsi
    11c2:	bf 00 00 00 00       	mov    $0x0,%edi
    11c7:	48 b8 73 13 00 00 00 	movabs $0x1373,%rax
    11ce:	00 00 00 
    11d1:	ff d0                	call   *%rax
    11d3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    11d6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    11da:	7e 36                	jle    1212 <gets+0x74>
      break;
    buf[i++] = c;
    11dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11df:	8d 50 01             	lea    0x1(%rax),%edx
    11e2:	89 55 fc             	mov    %edx,-0x4(%rbp)
    11e5:	48 63 d0             	movslq %eax,%rdx
    11e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11ec:	48 01 c2             	add    %rax,%rdx
    11ef:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    11f3:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    11f5:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    11f9:	3c 0a                	cmp    $0xa,%al
    11fb:	74 16                	je     1213 <gets+0x75>
    11fd:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1201:	3c 0d                	cmp    $0xd,%al
    1203:	74 0e                	je     1213 <gets+0x75>
  for(i=0; i+1 < max; ){
    1205:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1208:	83 c0 01             	add    $0x1,%eax
    120b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    120e:	7f a6                	jg     11b6 <gets+0x18>
    1210:	eb 01                	jmp    1213 <gets+0x75>
      break;
    1212:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1213:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1216:	48 63 d0             	movslq %eax,%rdx
    1219:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    121d:	48 01 d0             	add    %rdx,%rax
    1220:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1223:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1227:	c9                   	leave
    1228:	c3                   	ret

0000000000001229 <stat>:

int
stat(char *n, struct stat *st)
{
    1229:	55                   	push   %rbp
    122a:	48 89 e5             	mov    %rsp,%rbp
    122d:	48 83 ec 20          	sub    $0x20,%rsp
    1231:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1235:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1239:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    123d:	be 00 00 00 00       	mov    $0x0,%esi
    1242:	48 89 c7             	mov    %rax,%rdi
    1245:	48 b8 b4 13 00 00 00 	movabs $0x13b4,%rax
    124c:	00 00 00 
    124f:	ff d0                	call   *%rax
    1251:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1254:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1258:	79 07                	jns    1261 <stat+0x38>
    return -1;
    125a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    125f:	eb 2f                	jmp    1290 <stat+0x67>
  r = fstat(fd, st);
    1261:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1265:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1268:	48 89 d6             	mov    %rdx,%rsi
    126b:	89 c7                	mov    %eax,%edi
    126d:	48 b8 db 13 00 00 00 	movabs $0x13db,%rax
    1274:	00 00 00 
    1277:	ff d0                	call   *%rax
    1279:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    127c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    127f:	89 c7                	mov    %eax,%edi
    1281:	48 b8 8d 13 00 00 00 	movabs $0x138d,%rax
    1288:	00 00 00 
    128b:	ff d0                	call   *%rax
  return r;
    128d:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1290:	c9                   	leave
    1291:	c3                   	ret

0000000000001292 <atoi>:

int
atoi(const char *s)
{
    1292:	55                   	push   %rbp
    1293:	48 89 e5             	mov    %rsp,%rbp
    1296:	48 83 ec 18          	sub    $0x18,%rsp
    129a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    129e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12a5:	eb 28                	jmp    12cf <atoi+0x3d>
    n = n*10 + *s++ - '0';
    12a7:	8b 55 fc             	mov    -0x4(%rbp),%edx
    12aa:	89 d0                	mov    %edx,%eax
    12ac:	c1 e0 02             	shl    $0x2,%eax
    12af:	01 d0                	add    %edx,%eax
    12b1:	01 c0                	add    %eax,%eax
    12b3:	89 c1                	mov    %eax,%ecx
    12b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12b9:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12bd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    12c1:	0f b6 00             	movzbl (%rax),%eax
    12c4:	0f be c0             	movsbl %al,%eax
    12c7:	01 c8                	add    %ecx,%eax
    12c9:	83 e8 30             	sub    $0x30,%eax
    12cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12d3:	0f b6 00             	movzbl (%rax),%eax
    12d6:	3c 2f                	cmp    $0x2f,%al
    12d8:	7e 0b                	jle    12e5 <atoi+0x53>
    12da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12de:	0f b6 00             	movzbl (%rax),%eax
    12e1:	3c 39                	cmp    $0x39,%al
    12e3:	7e c2                	jle    12a7 <atoi+0x15>
  return n;
    12e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12e8:	c9                   	leave
    12e9:	c3                   	ret

00000000000012ea <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    12ea:	55                   	push   %rbp
    12eb:	48 89 e5             	mov    %rsp,%rbp
    12ee:	48 83 ec 28          	sub    $0x28,%rsp
    12f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    12fa:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    12fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1301:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1305:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1309:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    130d:	eb 1d                	jmp    132c <memmove+0x42>
    *dst++ = *src++;
    130f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1313:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1317:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    131b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    131f:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1323:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1327:	0f b6 12             	movzbl (%rdx),%edx
    132a:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    132c:	8b 45 dc             	mov    -0x24(%rbp),%eax
    132f:	8d 50 ff             	lea    -0x1(%rax),%edx
    1332:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1335:	85 c0                	test   %eax,%eax
    1337:	7f d6                	jg     130f <memmove+0x25>
  return vdst;
    1339:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    133d:	c9                   	leave
    133e:	c3                   	ret

000000000000133f <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    133f:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1346:	49 89 ca             	mov    %rcx,%r10
    1349:	0f 05                	syscall
    134b:	c3                   	ret

000000000000134c <exit>:
SYSCALL(exit)
    134c:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1353:	49 89 ca             	mov    %rcx,%r10
    1356:	0f 05                	syscall
    1358:	c3                   	ret

0000000000001359 <wait>:
SYSCALL(wait)
    1359:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1360:	49 89 ca             	mov    %rcx,%r10
    1363:	0f 05                	syscall
    1365:	c3                   	ret

0000000000001366 <pipe>:
SYSCALL(pipe)
    1366:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    136d:	49 89 ca             	mov    %rcx,%r10
    1370:	0f 05                	syscall
    1372:	c3                   	ret

0000000000001373 <read>:
SYSCALL(read)
    1373:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    137a:	49 89 ca             	mov    %rcx,%r10
    137d:	0f 05                	syscall
    137f:	c3                   	ret

0000000000001380 <write>:
SYSCALL(write)
    1380:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1387:	49 89 ca             	mov    %rcx,%r10
    138a:	0f 05                	syscall
    138c:	c3                   	ret

000000000000138d <close>:
SYSCALL(close)
    138d:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1394:	49 89 ca             	mov    %rcx,%r10
    1397:	0f 05                	syscall
    1399:	c3                   	ret

000000000000139a <kill>:
SYSCALL(kill)
    139a:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    13a1:	49 89 ca             	mov    %rcx,%r10
    13a4:	0f 05                	syscall
    13a6:	c3                   	ret

00000000000013a7 <exec>:
SYSCALL(exec)
    13a7:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    13ae:	49 89 ca             	mov    %rcx,%r10
    13b1:	0f 05                	syscall
    13b3:	c3                   	ret

00000000000013b4 <open>:
SYSCALL(open)
    13b4:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    13bb:	49 89 ca             	mov    %rcx,%r10
    13be:	0f 05                	syscall
    13c0:	c3                   	ret

00000000000013c1 <mknod>:
SYSCALL(mknod)
    13c1:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    13c8:	49 89 ca             	mov    %rcx,%r10
    13cb:	0f 05                	syscall
    13cd:	c3                   	ret

00000000000013ce <unlink>:
SYSCALL(unlink)
    13ce:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    13d5:	49 89 ca             	mov    %rcx,%r10
    13d8:	0f 05                	syscall
    13da:	c3                   	ret

00000000000013db <fstat>:
SYSCALL(fstat)
    13db:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    13e2:	49 89 ca             	mov    %rcx,%r10
    13e5:	0f 05                	syscall
    13e7:	c3                   	ret

00000000000013e8 <link>:
SYSCALL(link)
    13e8:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    13ef:	49 89 ca             	mov    %rcx,%r10
    13f2:	0f 05                	syscall
    13f4:	c3                   	ret

00000000000013f5 <mkdir>:
SYSCALL(mkdir)
    13f5:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    13fc:	49 89 ca             	mov    %rcx,%r10
    13ff:	0f 05                	syscall
    1401:	c3                   	ret

0000000000001402 <chdir>:
SYSCALL(chdir)
    1402:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1409:	49 89 ca             	mov    %rcx,%r10
    140c:	0f 05                	syscall
    140e:	c3                   	ret

000000000000140f <dup>:
SYSCALL(dup)
    140f:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1416:	49 89 ca             	mov    %rcx,%r10
    1419:	0f 05                	syscall
    141b:	c3                   	ret

000000000000141c <getpid>:
SYSCALL(getpid)
    141c:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1423:	49 89 ca             	mov    %rcx,%r10
    1426:	0f 05                	syscall
    1428:	c3                   	ret

0000000000001429 <sbrk>:
SYSCALL(sbrk)
    1429:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1430:	49 89 ca             	mov    %rcx,%r10
    1433:	0f 05                	syscall
    1435:	c3                   	ret

0000000000001436 <sleep>:
SYSCALL(sleep)
    1436:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    143d:	49 89 ca             	mov    %rcx,%r10
    1440:	0f 05                	syscall
    1442:	c3                   	ret

0000000000001443 <uptime>:
SYSCALL(uptime)
    1443:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    144a:	49 89 ca             	mov    %rcx,%r10
    144d:	0f 05                	syscall
    144f:	c3                   	ret

0000000000001450 <mmap>:
SYSCALL(mmap)
    1450:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1457:	49 89 ca             	mov    %rcx,%r10
    145a:	0f 05                	syscall
    145c:	c3                   	ret

000000000000145d <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    145d:	55                   	push   %rbp
    145e:	48 89 e5             	mov    %rsp,%rbp
    1461:	48 83 ec 10          	sub    $0x10,%rsp
    1465:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1468:	89 f0                	mov    %esi,%eax
    146a:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    146d:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1471:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1474:	ba 01 00 00 00       	mov    $0x1,%edx
    1479:	48 89 ce             	mov    %rcx,%rsi
    147c:	89 c7                	mov    %eax,%edi
    147e:	48 b8 80 13 00 00 00 	movabs $0x1380,%rax
    1485:	00 00 00 
    1488:	ff d0                	call   *%rax
}
    148a:	90                   	nop
    148b:	c9                   	leave
    148c:	c3                   	ret

000000000000148d <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    148d:	55                   	push   %rbp
    148e:	48 89 e5             	mov    %rsp,%rbp
    1491:	48 83 ec 20          	sub    $0x20,%rsp
    1495:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1498:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    149c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14a3:	eb 35                	jmp    14da <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    14a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14a9:	48 c1 e8 3c          	shr    $0x3c,%rax
    14ad:	48 ba 60 1d 00 00 00 	movabs $0x1d60,%rdx
    14b4:	00 00 00 
    14b7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    14bb:	0f be d0             	movsbl %al,%edx
    14be:	8b 45 ec             	mov    -0x14(%rbp),%eax
    14c1:	89 d6                	mov    %edx,%esi
    14c3:	89 c7                	mov    %eax,%edi
    14c5:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    14cc:	00 00 00 
    14cf:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    14d5:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    14da:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14dd:	83 f8 0f             	cmp    $0xf,%eax
    14e0:	76 c3                	jbe    14a5 <print_x64+0x18>
}
    14e2:	90                   	nop
    14e3:	90                   	nop
    14e4:	c9                   	leave
    14e5:	c3                   	ret

00000000000014e6 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    14e6:	55                   	push   %rbp
    14e7:	48 89 e5             	mov    %rsp,%rbp
    14ea:	48 83 ec 20          	sub    $0x20,%rsp
    14ee:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14f1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    14f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14fb:	eb 36                	jmp    1533 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    14fd:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1500:	c1 e8 1c             	shr    $0x1c,%eax
    1503:	89 c2                	mov    %eax,%edx
    1505:	48 b8 60 1d 00 00 00 	movabs $0x1d60,%rax
    150c:	00 00 00 
    150f:	89 d2                	mov    %edx,%edx
    1511:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1515:	0f be d0             	movsbl %al,%edx
    1518:	8b 45 ec             	mov    -0x14(%rbp),%eax
    151b:	89 d6                	mov    %edx,%esi
    151d:	89 c7                	mov    %eax,%edi
    151f:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    1526:	00 00 00 
    1529:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    152b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    152f:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1533:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1536:	83 f8 07             	cmp    $0x7,%eax
    1539:	76 c2                	jbe    14fd <print_x32+0x17>
}
    153b:	90                   	nop
    153c:	90                   	nop
    153d:	c9                   	leave
    153e:	c3                   	ret

000000000000153f <print_d>:

  static void
print_d(int fd, int v)
{
    153f:	55                   	push   %rbp
    1540:	48 89 e5             	mov    %rsp,%rbp
    1543:	48 83 ec 30          	sub    $0x30,%rsp
    1547:	89 7d dc             	mov    %edi,-0x24(%rbp)
    154a:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    154d:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1550:	48 98                	cltq
    1552:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1556:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    155a:	79 04                	jns    1560 <print_d+0x21>
    x = -x;
    155c:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1560:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1567:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    156b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1572:	66 66 66 
    1575:	48 89 c8             	mov    %rcx,%rax
    1578:	48 f7 ea             	imul   %rdx
    157b:	48 c1 fa 02          	sar    $0x2,%rdx
    157f:	48 89 c8             	mov    %rcx,%rax
    1582:	48 c1 f8 3f          	sar    $0x3f,%rax
    1586:	48 29 c2             	sub    %rax,%rdx
    1589:	48 89 d0             	mov    %rdx,%rax
    158c:	48 c1 e0 02          	shl    $0x2,%rax
    1590:	48 01 d0             	add    %rdx,%rax
    1593:	48 01 c0             	add    %rax,%rax
    1596:	48 29 c1             	sub    %rax,%rcx
    1599:	48 89 ca             	mov    %rcx,%rdx
    159c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    159f:	8d 48 01             	lea    0x1(%rax),%ecx
    15a2:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    15a5:	48 b9 60 1d 00 00 00 	movabs $0x1d60,%rcx
    15ac:	00 00 00 
    15af:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    15b3:	48 98                	cltq
    15b5:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    15b9:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15bd:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15c4:	66 66 66 
    15c7:	48 89 c8             	mov    %rcx,%rax
    15ca:	48 f7 ea             	imul   %rdx
    15cd:	48 89 d0             	mov    %rdx,%rax
    15d0:	48 c1 f8 02          	sar    $0x2,%rax
    15d4:	48 c1 f9 3f          	sar    $0x3f,%rcx
    15d8:	48 89 ca             	mov    %rcx,%rdx
    15db:	48 29 d0             	sub    %rdx,%rax
    15de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    15e2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    15e7:	0f 85 7a ff ff ff    	jne    1567 <print_d+0x28>

  if (v < 0)
    15ed:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15f1:	79 32                	jns    1625 <print_d+0xe6>
    buf[i++] = '-';
    15f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    15f6:	8d 50 01             	lea    0x1(%rax),%edx
    15f9:	89 55 f4             	mov    %edx,-0xc(%rbp)
    15fc:	48 98                	cltq
    15fe:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1603:	eb 20                	jmp    1625 <print_d+0xe6>
    putc(fd, buf[i]);
    1605:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1608:	48 98                	cltq
    160a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    160f:	0f be d0             	movsbl %al,%edx
    1612:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1615:	89 d6                	mov    %edx,%esi
    1617:	89 c7                	mov    %eax,%edi
    1619:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    1620:	00 00 00 
    1623:	ff d0                	call   *%rax
  while (--i >= 0)
    1625:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1629:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    162d:	79 d6                	jns    1605 <print_d+0xc6>
}
    162f:	90                   	nop
    1630:	90                   	nop
    1631:	c9                   	leave
    1632:	c3                   	ret

0000000000001633 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1633:	55                   	push   %rbp
    1634:	48 89 e5             	mov    %rsp,%rbp
    1637:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    163e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1644:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    164b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1652:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1659:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1660:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1667:	84 c0                	test   %al,%al
    1669:	74 20                	je     168b <printf+0x58>
    166b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    166f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1673:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1677:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    167b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    167f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1683:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1687:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    168b:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1692:	00 00 00 
    1695:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    169c:	00 00 00 
    169f:	48 8d 45 10          	lea    0x10(%rbp),%rax
    16a3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    16aa:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    16b1:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    16b8:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    16bf:	00 00 00 
    16c2:	e9 60 03 00 00       	jmp    1a27 <printf+0x3f4>
    if (c != '%') {
    16c7:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    16ce:	74 24                	je     16f4 <printf+0xc1>
      putc(fd, c);
    16d0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    16d6:	0f be d0             	movsbl %al,%edx
    16d9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    16df:	89 d6                	mov    %edx,%esi
    16e1:	89 c7                	mov    %eax,%edi
    16e3:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    16ea:	00 00 00 
    16ed:	ff d0                	call   *%rax
      continue;
    16ef:	e9 2c 03 00 00       	jmp    1a20 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    16f4:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    16fb:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1701:	48 63 d0             	movslq %eax,%rdx
    1704:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    170b:	48 01 d0             	add    %rdx,%rax
    170e:	0f b6 00             	movzbl (%rax),%eax
    1711:	0f be c0             	movsbl %al,%eax
    1714:	25 ff 00 00 00       	and    $0xff,%eax
    1719:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    171f:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1726:	0f 84 2e 03 00 00    	je     1a5a <printf+0x427>
      break;
    switch(c) {
    172c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1733:	0f 84 32 01 00 00    	je     186b <printf+0x238>
    1739:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1740:	0f 8f a1 02 00 00    	jg     19e7 <printf+0x3b4>
    1746:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    174d:	0f 84 d4 01 00 00    	je     1927 <printf+0x2f4>
    1753:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    175a:	0f 8f 87 02 00 00    	jg     19e7 <printf+0x3b4>
    1760:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1767:	0f 84 5b 01 00 00    	je     18c8 <printf+0x295>
    176d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1774:	0f 8f 6d 02 00 00    	jg     19e7 <printf+0x3b4>
    177a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1781:	0f 84 87 00 00 00    	je     180e <printf+0x1db>
    1787:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    178e:	0f 8f 53 02 00 00    	jg     19e7 <printf+0x3b4>
    1794:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    179b:	0f 84 2b 02 00 00    	je     19cc <printf+0x399>
    17a1:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    17a8:	0f 85 39 02 00 00    	jne    19e7 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    17ae:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    17b4:	83 f8 2f             	cmp    $0x2f,%eax
    17b7:	77 23                	ja     17dc <printf+0x1a9>
    17b9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    17c0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    17c6:	89 d2                	mov    %edx,%edx
    17c8:	48 01 d0             	add    %rdx,%rax
    17cb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    17d1:	83 c2 08             	add    $0x8,%edx
    17d4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    17da:	eb 12                	jmp    17ee <printf+0x1bb>
    17dc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    17e3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    17e7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    17ee:	8b 00                	mov    (%rax),%eax
    17f0:	0f be d0             	movsbl %al,%edx
    17f3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17f9:	89 d6                	mov    %edx,%esi
    17fb:	89 c7                	mov    %eax,%edi
    17fd:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    1804:	00 00 00 
    1807:	ff d0                	call   *%rax
      break;
    1809:	e9 12 02 00 00       	jmp    1a20 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    180e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1814:	83 f8 2f             	cmp    $0x2f,%eax
    1817:	77 23                	ja     183c <printf+0x209>
    1819:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1820:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1826:	89 d2                	mov    %edx,%edx
    1828:	48 01 d0             	add    %rdx,%rax
    182b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1831:	83 c2 08             	add    $0x8,%edx
    1834:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    183a:	eb 12                	jmp    184e <printf+0x21b>
    183c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1843:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1847:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    184e:	8b 10                	mov    (%rax),%edx
    1850:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1856:	89 d6                	mov    %edx,%esi
    1858:	89 c7                	mov    %eax,%edi
    185a:	48 b8 3f 15 00 00 00 	movabs $0x153f,%rax
    1861:	00 00 00 
    1864:	ff d0                	call   *%rax
      break;
    1866:	e9 b5 01 00 00       	jmp    1a20 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    186b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1871:	83 f8 2f             	cmp    $0x2f,%eax
    1874:	77 23                	ja     1899 <printf+0x266>
    1876:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    187d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1883:	89 d2                	mov    %edx,%edx
    1885:	48 01 d0             	add    %rdx,%rax
    1888:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    188e:	83 c2 08             	add    $0x8,%edx
    1891:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1897:	eb 12                	jmp    18ab <printf+0x278>
    1899:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18a0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18a4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18ab:	8b 10                	mov    (%rax),%edx
    18ad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18b3:	89 d6                	mov    %edx,%esi
    18b5:	89 c7                	mov    %eax,%edi
    18b7:	48 b8 e6 14 00 00 00 	movabs $0x14e6,%rax
    18be:	00 00 00 
    18c1:	ff d0                	call   *%rax
      break;
    18c3:	e9 58 01 00 00       	jmp    1a20 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    18c8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18ce:	83 f8 2f             	cmp    $0x2f,%eax
    18d1:	77 23                	ja     18f6 <printf+0x2c3>
    18d3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18da:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18e0:	89 d2                	mov    %edx,%edx
    18e2:	48 01 d0             	add    %rdx,%rax
    18e5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18eb:	83 c2 08             	add    $0x8,%edx
    18ee:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18f4:	eb 12                	jmp    1908 <printf+0x2d5>
    18f6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18fd:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1901:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1908:	48 8b 10             	mov    (%rax),%rdx
    190b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1911:	48 89 d6             	mov    %rdx,%rsi
    1914:	89 c7                	mov    %eax,%edi
    1916:	48 b8 8d 14 00 00 00 	movabs $0x148d,%rax
    191d:	00 00 00 
    1920:	ff d0                	call   *%rax
      break;
    1922:	e9 f9 00 00 00       	jmp    1a20 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1927:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    192d:	83 f8 2f             	cmp    $0x2f,%eax
    1930:	77 23                	ja     1955 <printf+0x322>
    1932:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1939:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    193f:	89 d2                	mov    %edx,%edx
    1941:	48 01 d0             	add    %rdx,%rax
    1944:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    194a:	83 c2 08             	add    $0x8,%edx
    194d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1953:	eb 12                	jmp    1967 <printf+0x334>
    1955:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    195c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1960:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1967:	48 8b 00             	mov    (%rax),%rax
    196a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1971:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1978:	00 
    1979:	75 41                	jne    19bc <printf+0x389>
        s = "(null)";
    197b:	48 b8 55 1d 00 00 00 	movabs $0x1d55,%rax
    1982:	00 00 00 
    1985:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    198c:	eb 2e                	jmp    19bc <printf+0x389>
        putc(fd, *(s++));
    198e:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1995:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1999:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    19a0:	0f b6 00             	movzbl (%rax),%eax
    19a3:	0f be d0             	movsbl %al,%edx
    19a6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19ac:	89 d6                	mov    %edx,%esi
    19ae:	89 c7                	mov    %eax,%edi
    19b0:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    19b7:	00 00 00 
    19ba:	ff d0                	call   *%rax
      while (*s)
    19bc:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19c3:	0f b6 00             	movzbl (%rax),%eax
    19c6:	84 c0                	test   %al,%al
    19c8:	75 c4                	jne    198e <printf+0x35b>
      break;
    19ca:	eb 54                	jmp    1a20 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    19cc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19d2:	be 25 00 00 00       	mov    $0x25,%esi
    19d7:	89 c7                	mov    %eax,%edi
    19d9:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    19e0:	00 00 00 
    19e3:	ff d0                	call   *%rax
      break;
    19e5:	eb 39                	jmp    1a20 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    19e7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19ed:	be 25 00 00 00       	mov    $0x25,%esi
    19f2:	89 c7                	mov    %eax,%edi
    19f4:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    19fb:	00 00 00 
    19fe:	ff d0                	call   *%rax
      putc(fd, c);
    1a00:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a06:	0f be d0             	movsbl %al,%edx
    1a09:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a0f:	89 d6                	mov    %edx,%esi
    1a11:	89 c7                	mov    %eax,%edi
    1a13:	48 b8 5d 14 00 00 00 	movabs $0x145d,%rax
    1a1a:	00 00 00 
    1a1d:	ff d0                	call   *%rax
      break;
    1a1f:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a20:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a27:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a2d:	48 63 d0             	movslq %eax,%rdx
    1a30:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a37:	48 01 d0             	add    %rdx,%rax
    1a3a:	0f b6 00             	movzbl (%rax),%eax
    1a3d:	0f be c0             	movsbl %al,%eax
    1a40:	25 ff 00 00 00       	and    $0xff,%eax
    1a45:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1a4b:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1a52:	0f 85 6f fc ff ff    	jne    16c7 <printf+0x94>
    }
  }
}
    1a58:	eb 01                	jmp    1a5b <printf+0x428>
      break;
    1a5a:	90                   	nop
}
    1a5b:	90                   	nop
    1a5c:	c9                   	leave
    1a5d:	c3                   	ret

0000000000001a5e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a5e:	55                   	push   %rbp
    1a5f:	48 89 e5             	mov    %rsp,%rbp
    1a62:	48 83 ec 18          	sub    $0x18,%rsp
    1a66:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1a6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1a6e:	48 83 e8 10          	sub    $0x10,%rax
    1a72:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a76:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1a7d:	00 00 00 
    1a80:	48 8b 00             	mov    (%rax),%rax
    1a83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1a87:	eb 2f                	jmp    1ab8 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1a89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1a8d:	48 8b 00             	mov    (%rax),%rax
    1a90:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1a94:	72 17                	jb     1aad <free+0x4f>
    1a96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1a9a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1a9e:	72 2f                	jb     1acf <free+0x71>
    1aa0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1aa4:	48 8b 00             	mov    (%rax),%rax
    1aa7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1aab:	72 22                	jb     1acf <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1aad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ab1:	48 8b 00             	mov    (%rax),%rax
    1ab4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ab8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1abc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ac0:	73 c7                	jae    1a89 <free+0x2b>
    1ac2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ac6:	48 8b 00             	mov    (%rax),%rax
    1ac9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1acd:	73 ba                	jae    1a89 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1acf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ad3:	8b 40 08             	mov    0x8(%rax),%eax
    1ad6:	89 c0                	mov    %eax,%eax
    1ad8:	48 c1 e0 04          	shl    $0x4,%rax
    1adc:	48 89 c2             	mov    %rax,%rdx
    1adf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ae3:	48 01 c2             	add    %rax,%rdx
    1ae6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1aea:	48 8b 00             	mov    (%rax),%rax
    1aed:	48 39 c2             	cmp    %rax,%rdx
    1af0:	75 2d                	jne    1b1f <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1af2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1af6:	8b 50 08             	mov    0x8(%rax),%edx
    1af9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1afd:	48 8b 00             	mov    (%rax),%rax
    1b00:	8b 40 08             	mov    0x8(%rax),%eax
    1b03:	01 c2                	add    %eax,%edx
    1b05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b09:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b10:	48 8b 00             	mov    (%rax),%rax
    1b13:	48 8b 10             	mov    (%rax),%rdx
    1b16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b1a:	48 89 10             	mov    %rdx,(%rax)
    1b1d:	eb 0e                	jmp    1b2d <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1b1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b23:	48 8b 10             	mov    (%rax),%rdx
    1b26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b2a:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1b2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b31:	8b 40 08             	mov    0x8(%rax),%eax
    1b34:	89 c0                	mov    %eax,%eax
    1b36:	48 c1 e0 04          	shl    $0x4,%rax
    1b3a:	48 89 c2             	mov    %rax,%rdx
    1b3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b41:	48 01 d0             	add    %rdx,%rax
    1b44:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b48:	75 27                	jne    1b71 <free+0x113>
    p->s.size += bp->s.size;
    1b4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b4e:	8b 50 08             	mov    0x8(%rax),%edx
    1b51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b55:	8b 40 08             	mov    0x8(%rax),%eax
    1b58:	01 c2                	add    %eax,%edx
    1b5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b5e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1b61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b65:	48 8b 10             	mov    (%rax),%rdx
    1b68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6c:	48 89 10             	mov    %rdx,(%rax)
    1b6f:	eb 0b                	jmp    1b7c <free+0x11e>
  } else
    p->s.ptr = bp;
    1b71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b75:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1b79:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1b7c:	48 ba 90 1d 00 00 00 	movabs $0x1d90,%rdx
    1b83:	00 00 00 
    1b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8a:	48 89 02             	mov    %rax,(%rdx)
}
    1b8d:	90                   	nop
    1b8e:	c9                   	leave
    1b8f:	c3                   	ret

0000000000001b90 <morecore>:

static Header*
morecore(uint nu)
{
    1b90:	55                   	push   %rbp
    1b91:	48 89 e5             	mov    %rsp,%rbp
    1b94:	48 83 ec 20          	sub    $0x20,%rsp
    1b98:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1b9b:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1ba2:	77 07                	ja     1bab <morecore+0x1b>
    nu = 4096;
    1ba4:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1bab:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1bae:	48 c1 e0 04          	shl    $0x4,%rax
    1bb2:	48 89 c7             	mov    %rax,%rdi
    1bb5:	48 b8 29 14 00 00 00 	movabs $0x1429,%rax
    1bbc:	00 00 00 
    1bbf:	ff d0                	call   *%rax
    1bc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1bc5:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1bca:	75 07                	jne    1bd3 <morecore+0x43>
    return 0;
    1bcc:	b8 00 00 00 00       	mov    $0x0,%eax
    1bd1:	eb 36                	jmp    1c09 <morecore+0x79>
  hp = (Header*)p;
    1bd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1bdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bdf:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1be2:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1be5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be9:	48 83 c0 10          	add    $0x10,%rax
    1bed:	48 89 c7             	mov    %rax,%rdi
    1bf0:	48 b8 5e 1a 00 00 00 	movabs $0x1a5e,%rax
    1bf7:	00 00 00 
    1bfa:	ff d0                	call   *%rax
  return freep;
    1bfc:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1c03:	00 00 00 
    1c06:	48 8b 00             	mov    (%rax),%rax
}
    1c09:	c9                   	leave
    1c0a:	c3                   	ret

0000000000001c0b <malloc>:

void*
malloc(uint nbytes)
{
    1c0b:	55                   	push   %rbp
    1c0c:	48 89 e5             	mov    %rsp,%rbp
    1c0f:	48 83 ec 30          	sub    $0x30,%rsp
    1c13:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c16:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c19:	48 83 c0 0f          	add    $0xf,%rax
    1c1d:	48 c1 e8 04          	shr    $0x4,%rax
    1c21:	83 c0 01             	add    $0x1,%eax
    1c24:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c27:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1c2e:	00 00 00 
    1c31:	48 8b 00             	mov    (%rax),%rax
    1c34:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c38:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c3d:	75 4a                	jne    1c89 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1c3f:	48 b8 80 1d 00 00 00 	movabs $0x1d80,%rax
    1c46:	00 00 00 
    1c49:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c4d:	48 ba 90 1d 00 00 00 	movabs $0x1d90,%rdx
    1c54:	00 00 00 
    1c57:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c5b:	48 89 02             	mov    %rax,(%rdx)
    1c5e:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1c65:	00 00 00 
    1c68:	48 8b 00             	mov    (%rax),%rax
    1c6b:	48 ba 80 1d 00 00 00 	movabs $0x1d80,%rdx
    1c72:	00 00 00 
    1c75:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1c78:	48 b8 80 1d 00 00 00 	movabs $0x1d80,%rax
    1c7f:	00 00 00 
    1c82:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c89:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c8d:	48 8b 00             	mov    (%rax),%rax
    1c90:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1c94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c98:	8b 40 08             	mov    0x8(%rax),%eax
    1c9b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1c9e:	72 65                	jb     1d05 <malloc+0xfa>
      if(p->s.size == nunits)
    1ca0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca4:	8b 40 08             	mov    0x8(%rax),%eax
    1ca7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1caa:	75 10                	jne    1cbc <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1cac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb0:	48 8b 10             	mov    (%rax),%rdx
    1cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb7:	48 89 10             	mov    %rdx,(%rax)
    1cba:	eb 2e                	jmp    1cea <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc0:	8b 40 08             	mov    0x8(%rax),%eax
    1cc3:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1cc6:	89 c2                	mov    %eax,%edx
    1cc8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ccc:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1ccf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd3:	8b 40 08             	mov    0x8(%rax),%eax
    1cd6:	89 c0                	mov    %eax,%eax
    1cd8:	48 c1 e0 04          	shl    $0x4,%rax
    1cdc:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1ce0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce4:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1ce7:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1cea:	48 ba 90 1d 00 00 00 	movabs $0x1d90,%rdx
    1cf1:	00 00 00 
    1cf4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf8:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cff:	48 83 c0 10          	add    $0x10,%rax
    1d03:	eb 4e                	jmp    1d53 <malloc+0x148>
    }
    if(p == freep)
    1d05:	48 b8 90 1d 00 00 00 	movabs $0x1d90,%rax
    1d0c:	00 00 00 
    1d0f:	48 8b 00             	mov    (%rax),%rax
    1d12:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d16:	75 23                	jne    1d3b <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1d18:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d1b:	89 c7                	mov    %eax,%edi
    1d1d:	48 b8 90 1b 00 00 00 	movabs $0x1b90,%rax
    1d24:	00 00 00 
    1d27:	ff d0                	call   *%rax
    1d29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d2d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d32:	75 07                	jne    1d3b <malloc+0x130>
        return 0;
    1d34:	b8 00 00 00 00       	mov    $0x0,%eax
    1d39:	eb 18                	jmp    1d53 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d47:	48 8b 00             	mov    (%rax),%rax
    1d4a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d4e:	e9 41 ff ff ff       	jmp    1c94 <malloc+0x89>
  }
}
    1d53:	c9                   	leave
    1d54:	c3                   	ret
