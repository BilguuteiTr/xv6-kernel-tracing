
_alarmtest2:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char **argv)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 20          	sub    $0x20,%rsp
    1008:	89 7d ec             	mov    %edi,-0x14(%rbp)
    100b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  fgproc();
    100f:	48 b8 35 15 00 00 00 	movabs $0x1535,%rax
    1016:	00 00 00 
    1019:	ff d0                	call   *%rax
  signal(14, (void (*)(int))1); // ignore alarm signal this time
    101b:	be 01 00 00 00       	mov    $0x1,%esi
    1020:	bf 0e 00 00 00       	mov    $0xe,%edi
    1025:	48 b8 1b 15 00 00 00 	movabs $0x151b,%rax
    102c:	00 00 00 
    102f:	ff d0                	call   *%rax
  alarm(2);
    1031:	bf 02 00 00 00       	mov    $0x2,%edi
    1036:	48 b8 0e 15 00 00 00 	movabs $0x150e,%rax
    103d:	00 00 00 
    1040:	ff d0                	call   *%rax
  int i = 5;
    1042:	c7 45 fc 05 00 00 00 	movl   $0x5,-0x4(%rbp)
  while (i--)
    1049:	eb 39                	jmp    1084 <main+0x84>
  {
    printf(1, "Still looping... %d\n", i);
    104b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    104e:	48 b9 40 1e 00 00 00 	movabs $0x1e40,%rcx
    1055:	00 00 00 
    1058:	89 c2                	mov    %eax,%edx
    105a:	48 89 ce             	mov    %rcx,%rsi
    105d:	bf 01 00 00 00       	mov    $0x1,%edi
    1062:	b8 00 00 00 00       	mov    $0x0,%eax
    1067:	48 b9 18 17 00 00 00 	movabs $0x1718,%rcx
    106e:	00 00 00 
    1071:	ff d1                	call   *%rcx
    sleep(100);
    1073:	bf 64 00 00 00       	mov    $0x64,%edi
    1078:	48 b8 f4 14 00 00 00 	movabs $0x14f4,%rax
    107f:	00 00 00 
    1082:	ff d0                	call   *%rax
  while (i--)
    1084:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1087:	8d 50 ff             	lea    -0x1(%rax),%edx
    108a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    108d:	85 c0                	test   %eax,%eax
    108f:	75 ba                	jne    104b <main+0x4b>
  }

  signal(14, 0); // stop ignoring alarms
    1091:	be 00 00 00 00       	mov    $0x0,%esi
    1096:	bf 0e 00 00 00       	mov    $0xe,%edi
    109b:	48 b8 1b 15 00 00 00 	movabs $0x151b,%rax
    10a2:	00 00 00 
    10a5:	ff d0                	call   *%rax
  alarm(5);      //
    10a7:	bf 05 00 00 00       	mov    $0x5,%edi
    10ac:	48 b8 0e 15 00 00 00 	movabs $0x150e,%rax
    10b3:	00 00 00 
    10b6:	ff d0                	call   *%rax

  while (1)
  {
    printf(1, "Still waiting for that alarm... \n");
    10b8:	48 b8 58 1e 00 00 00 	movabs $0x1e58,%rax
    10bf:	00 00 00 
    10c2:	48 89 c6             	mov    %rax,%rsi
    10c5:	bf 01 00 00 00       	mov    $0x1,%edi
    10ca:	b8 00 00 00 00       	mov    $0x0,%eax
    10cf:	48 ba 18 17 00 00 00 	movabs $0x1718,%rdx
    10d6:	00 00 00 
    10d9:	ff d2                	call   *%rdx
    sleep(100);
    10db:	bf 64 00 00 00       	mov    $0x64,%edi
    10e0:	48 b8 f4 14 00 00 00 	movabs $0x14f4,%rax
    10e7:	00 00 00 
    10ea:	ff d0                	call   *%rax
    printf(1, "Still waiting for that alarm... \n");
    10ec:	90                   	nop
    10ed:	eb c9                	jmp    10b8 <main+0xb8>

00000000000010ef <stosb>:
  asm volatile("cld; rep outsl" : "=S"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    10ef:	55                   	push   %rbp
    10f0:	48 89 e5             	mov    %rsp,%rbp
    10f3:	48 83 ec 10          	sub    $0x10,%rsp
    10f7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10fb:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10fe:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
    1101:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1105:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1108:	8b 45 f4             	mov    -0xc(%rbp),%eax
    110b:	48 89 ce             	mov    %rcx,%rsi
    110e:	48 89 f7             	mov    %rsi,%rdi
    1111:	89 d1                	mov    %edx,%ecx
    1113:	fc                   	cld
    1114:	f3 aa                	rep stos %al,(%rdi)
    1116:	89 ca                	mov    %ecx,%edx
    1118:	48 89 fe             	mov    %rdi,%rsi
    111b:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    111f:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
    1122:	90                   	nop
    1123:	c9                   	leave
    1124:	c3                   	ret

0000000000001125 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1125:	55                   	push   %rbp
    1126:	48 89 e5             	mov    %rsp,%rbp
    1129:	48 83 ec 20          	sub    $0x20,%rsp
    112d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1131:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    1135:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1139:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    113d:	90                   	nop
    113e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1142:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1146:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    114a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    114e:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1152:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1156:	0f b6 12             	movzbl (%rdx),%edx
    1159:	88 10                	mov    %dl,(%rax)
    115b:	0f b6 00             	movzbl (%rax),%eax
    115e:	84 c0                	test   %al,%al
    1160:	75 dc                	jne    113e <strcpy+0x19>
    ;
  return os;
    1162:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1166:	c9                   	leave
    1167:	c3                   	ret

0000000000001168 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1168:	55                   	push   %rbp
    1169:	48 89 e5             	mov    %rsp,%rbp
    116c:	48 83 ec 10          	sub    $0x10,%rsp
    1170:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1174:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1178:	eb 0a                	jmp    1184 <strcmp+0x1c>
    p++, q++;
    117a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    117f:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1184:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1188:	0f b6 00             	movzbl (%rax),%eax
    118b:	84 c0                	test   %al,%al
    118d:	74 12                	je     11a1 <strcmp+0x39>
    118f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1193:	0f b6 10             	movzbl (%rax),%edx
    1196:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    119a:	0f b6 00             	movzbl (%rax),%eax
    119d:	38 c2                	cmp    %al,%dl
    119f:	74 d9                	je     117a <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    11a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11a5:	0f b6 00             	movzbl (%rax),%eax
    11a8:	0f b6 d0             	movzbl %al,%edx
    11ab:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    11af:	0f b6 00             	movzbl (%rax),%eax
    11b2:	0f b6 c0             	movzbl %al,%eax
    11b5:	29 c2                	sub    %eax,%edx
    11b7:	89 d0                	mov    %edx,%eax
}
    11b9:	c9                   	leave
    11ba:	c3                   	ret

00000000000011bb <strlen>:

uint
strlen(char *s)
{
    11bb:	55                   	push   %rbp
    11bc:	48 89 e5             	mov    %rsp,%rbp
    11bf:	48 83 ec 18          	sub    $0x18,%rsp
    11c3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    11c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11ce:	eb 04                	jmp    11d4 <strlen+0x19>
    11d0:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    11d4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11d7:	48 63 d0             	movslq %eax,%rdx
    11da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11de:	48 01 d0             	add    %rdx,%rax
    11e1:	0f b6 00             	movzbl (%rax),%eax
    11e4:	84 c0                	test   %al,%al
    11e6:	75 e8                	jne    11d0 <strlen+0x15>
    ;
  return n;
    11e8:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    11eb:	c9                   	leave
    11ec:	c3                   	ret

00000000000011ed <memset>:

void*
memset(void *dst, int c, uint n)
{
    11ed:	55                   	push   %rbp
    11ee:	48 89 e5             	mov    %rsp,%rbp
    11f1:	48 83 ec 10          	sub    $0x10,%rsp
    11f5:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11f9:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11fc:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11ff:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1202:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1205:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1209:	89 ce                	mov    %ecx,%esi
    120b:	48 89 c7             	mov    %rax,%rdi
    120e:	48 b8 ef 10 00 00 00 	movabs $0x10ef,%rax
    1215:	00 00 00 
    1218:	ff d0                	call   *%rax
  return dst;
    121a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    121e:	c9                   	leave
    121f:	c3                   	ret

0000000000001220 <strchr>:

char*
strchr(const char *s, char c)
{
    1220:	55                   	push   %rbp
    1221:	48 89 e5             	mov    %rsp,%rbp
    1224:	48 83 ec 10          	sub    $0x10,%rsp
    1228:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    122c:	89 f0                	mov    %esi,%eax
    122e:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1231:	eb 17                	jmp    124a <strchr+0x2a>
    if(*s == c)
    1233:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1237:	0f b6 00             	movzbl (%rax),%eax
    123a:	38 45 f4             	cmp    %al,-0xc(%rbp)
    123d:	75 06                	jne    1245 <strchr+0x25>
      return (char*)s;
    123f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1243:	eb 15                	jmp    125a <strchr+0x3a>
  for(; *s; s++)
    1245:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    124a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    124e:	0f b6 00             	movzbl (%rax),%eax
    1251:	84 c0                	test   %al,%al
    1253:	75 de                	jne    1233 <strchr+0x13>
  return 0;
    1255:	b8 00 00 00 00       	mov    $0x0,%eax
}
    125a:	c9                   	leave
    125b:	c3                   	ret

000000000000125c <gets>:

char*
gets(char *buf, int max)
{
    125c:	55                   	push   %rbp
    125d:	48 89 e5             	mov    %rsp,%rbp
    1260:	48 83 ec 20          	sub    $0x20,%rsp
    1264:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1268:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    126b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1272:	eb 4f                	jmp    12c3 <gets+0x67>
    cc = read(0, &c, 1);
    1274:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1278:	ba 01 00 00 00       	mov    $0x1,%edx
    127d:	48 89 c6             	mov    %rax,%rsi
    1280:	bf 00 00 00 00       	mov    $0x0,%edi
    1285:	48 b8 31 14 00 00 00 	movabs $0x1431,%rax
    128c:	00 00 00 
    128f:	ff d0                	call   *%rax
    1291:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1294:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1298:	7e 36                	jle    12d0 <gets+0x74>
      break;
    buf[i++] = c;
    129a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129d:	8d 50 01             	lea    0x1(%rax),%edx
    12a0:	89 55 fc             	mov    %edx,-0x4(%rbp)
    12a3:	48 63 d0             	movslq %eax,%rdx
    12a6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12aa:	48 01 c2             	add    %rax,%rdx
    12ad:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12b1:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    12b3:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12b7:	3c 0a                	cmp    $0xa,%al
    12b9:	74 16                	je     12d1 <gets+0x75>
    12bb:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    12bf:	3c 0d                	cmp    $0xd,%al
    12c1:	74 0e                	je     12d1 <gets+0x75>
  for(i=0; i+1 < max; ){
    12c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12c6:	83 c0 01             	add    $0x1,%eax
    12c9:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    12cc:	7f a6                	jg     1274 <gets+0x18>
    12ce:	eb 01                	jmp    12d1 <gets+0x75>
      break;
    12d0:	90                   	nop
      break;
  }
  buf[i] = '\0';
    12d1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12d4:	48 63 d0             	movslq %eax,%rdx
    12d7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12db:	48 01 d0             	add    %rdx,%rax
    12de:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    12e1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    12e5:	c9                   	leave
    12e6:	c3                   	ret

00000000000012e7 <stat>:

int
stat(char *n, struct stat *st)
{
    12e7:	55                   	push   %rbp
    12e8:	48 89 e5             	mov    %rsp,%rbp
    12eb:	48 83 ec 20          	sub    $0x20,%rsp
    12ef:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12f3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12fb:	be 00 00 00 00       	mov    $0x0,%esi
    1300:	48 89 c7             	mov    %rax,%rdi
    1303:	48 b8 72 14 00 00 00 	movabs $0x1472,%rax
    130a:	00 00 00 
    130d:	ff d0                	call   *%rax
    130f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1312:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1316:	79 07                	jns    131f <stat+0x38>
    return -1;
    1318:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    131d:	eb 2f                	jmp    134e <stat+0x67>
  r = fstat(fd, st);
    131f:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1323:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1326:	48 89 d6             	mov    %rdx,%rsi
    1329:	89 c7                	mov    %eax,%edi
    132b:	48 b8 99 14 00 00 00 	movabs $0x1499,%rax
    1332:	00 00 00 
    1335:	ff d0                	call   *%rax
    1337:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    133a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    133d:	89 c7                	mov    %eax,%edi
    133f:	48 b8 4b 14 00 00 00 	movabs $0x144b,%rax
    1346:	00 00 00 
    1349:	ff d0                	call   *%rax
  return r;
    134b:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    134e:	c9                   	leave
    134f:	c3                   	ret

0000000000001350 <atoi>:

int
atoi(const char *s)
{
    1350:	55                   	push   %rbp
    1351:	48 89 e5             	mov    %rsp,%rbp
    1354:	48 83 ec 18          	sub    $0x18,%rsp
    1358:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    135c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1363:	eb 28                	jmp    138d <atoi+0x3d>
    n = n*10 + *s++ - '0';
    1365:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1368:	89 d0                	mov    %edx,%eax
    136a:	c1 e0 02             	shl    $0x2,%eax
    136d:	01 d0                	add    %edx,%eax
    136f:	01 c0                	add    %eax,%eax
    1371:	89 c1                	mov    %eax,%ecx
    1373:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1377:	48 8d 50 01          	lea    0x1(%rax),%rdx
    137b:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    137f:	0f b6 00             	movzbl (%rax),%eax
    1382:	0f be c0             	movsbl %al,%eax
    1385:	01 c8                	add    %ecx,%eax
    1387:	83 e8 30             	sub    $0x30,%eax
    138a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    138d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1391:	0f b6 00             	movzbl (%rax),%eax
    1394:	3c 2f                	cmp    $0x2f,%al
    1396:	7e 0b                	jle    13a3 <atoi+0x53>
    1398:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    139c:	0f b6 00             	movzbl (%rax),%eax
    139f:	3c 39                	cmp    $0x39,%al
    13a1:	7e c2                	jle    1365 <atoi+0x15>
  return n;
    13a3:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    13a6:	c9                   	leave
    13a7:	c3                   	ret

00000000000013a8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    13a8:	55                   	push   %rbp
    13a9:	48 89 e5             	mov    %rsp,%rbp
    13ac:	48 83 ec 28          	sub    $0x28,%rsp
    13b0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    13b8:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    13bb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13bf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    13c3:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    13c7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    13cb:	eb 1d                	jmp    13ea <memmove+0x42>
    *dst++ = *src++;
    13cd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    13d1:	48 8d 42 01          	lea    0x1(%rdx),%rax
    13d5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    13d9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13dd:	48 8d 48 01          	lea    0x1(%rax),%rcx
    13e1:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    13e5:	0f b6 12             	movzbl (%rdx),%edx
    13e8:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    13ea:	8b 45 dc             	mov    -0x24(%rbp),%eax
    13ed:	8d 50 ff             	lea    -0x1(%rax),%edx
    13f0:	89 55 dc             	mov    %edx,-0x24(%rbp)
    13f3:	85 c0                	test   %eax,%eax
    13f5:	7f d6                	jg     13cd <memmove+0x25>
  return vdst;
    13f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13fb:	c9                   	leave
    13fc:	c3                   	ret

00000000000013fd <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13fd:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1404:	49 89 ca             	mov    %rcx,%r10
    1407:	0f 05                	syscall
    1409:	c3                   	ret

000000000000140a <exit>:
SYSCALL(exit)
    140a:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1411:	49 89 ca             	mov    %rcx,%r10
    1414:	0f 05                	syscall
    1416:	c3                   	ret

0000000000001417 <wait>:
SYSCALL(wait)
    1417:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    141e:	49 89 ca             	mov    %rcx,%r10
    1421:	0f 05                	syscall
    1423:	c3                   	ret

0000000000001424 <pipe>:
SYSCALL(pipe)
    1424:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    142b:	49 89 ca             	mov    %rcx,%r10
    142e:	0f 05                	syscall
    1430:	c3                   	ret

0000000000001431 <read>:
SYSCALL(read)
    1431:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1438:	49 89 ca             	mov    %rcx,%r10
    143b:	0f 05                	syscall
    143d:	c3                   	ret

000000000000143e <write>:
SYSCALL(write)
    143e:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1445:	49 89 ca             	mov    %rcx,%r10
    1448:	0f 05                	syscall
    144a:	c3                   	ret

000000000000144b <close>:
SYSCALL(close)
    144b:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1452:	49 89 ca             	mov    %rcx,%r10
    1455:	0f 05                	syscall
    1457:	c3                   	ret

0000000000001458 <kill>:
SYSCALL(kill)
    1458:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    145f:	49 89 ca             	mov    %rcx,%r10
    1462:	0f 05                	syscall
    1464:	c3                   	ret

0000000000001465 <exec>:
SYSCALL(exec)
    1465:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    146c:	49 89 ca             	mov    %rcx,%r10
    146f:	0f 05                	syscall
    1471:	c3                   	ret

0000000000001472 <open>:
SYSCALL(open)
    1472:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1479:	49 89 ca             	mov    %rcx,%r10
    147c:	0f 05                	syscall
    147e:	c3                   	ret

000000000000147f <mknod>:
SYSCALL(mknod)
    147f:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1486:	49 89 ca             	mov    %rcx,%r10
    1489:	0f 05                	syscall
    148b:	c3                   	ret

000000000000148c <unlink>:
SYSCALL(unlink)
    148c:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1493:	49 89 ca             	mov    %rcx,%r10
    1496:	0f 05                	syscall
    1498:	c3                   	ret

0000000000001499 <fstat>:
SYSCALL(fstat)
    1499:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    14a0:	49 89 ca             	mov    %rcx,%r10
    14a3:	0f 05                	syscall
    14a5:	c3                   	ret

00000000000014a6 <link>:
SYSCALL(link)
    14a6:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    14ad:	49 89 ca             	mov    %rcx,%r10
    14b0:	0f 05                	syscall
    14b2:	c3                   	ret

00000000000014b3 <mkdir>:
SYSCALL(mkdir)
    14b3:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    14ba:	49 89 ca             	mov    %rcx,%r10
    14bd:	0f 05                	syscall
    14bf:	c3                   	ret

00000000000014c0 <chdir>:
SYSCALL(chdir)
    14c0:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    14c7:	49 89 ca             	mov    %rcx,%r10
    14ca:	0f 05                	syscall
    14cc:	c3                   	ret

00000000000014cd <dup>:
SYSCALL(dup)
    14cd:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    14d4:	49 89 ca             	mov    %rcx,%r10
    14d7:	0f 05                	syscall
    14d9:	c3                   	ret

00000000000014da <getpid>:
SYSCALL(getpid)
    14da:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    14e1:	49 89 ca             	mov    %rcx,%r10
    14e4:	0f 05                	syscall
    14e6:	c3                   	ret

00000000000014e7 <sbrk>:
SYSCALL(sbrk)
    14e7:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    14ee:	49 89 ca             	mov    %rcx,%r10
    14f1:	0f 05                	syscall
    14f3:	c3                   	ret

00000000000014f4 <sleep>:
SYSCALL(sleep)
    14f4:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14fb:	49 89 ca             	mov    %rcx,%r10
    14fe:	0f 05                	syscall
    1500:	c3                   	ret

0000000000001501 <uptime>:
SYSCALL(uptime)
    1501:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1508:	49 89 ca             	mov    %rcx,%r10
    150b:	0f 05                	syscall
    150d:	c3                   	ret

000000000000150e <alarm>:

SYSCALL(alarm)
    150e:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1515:	49 89 ca             	mov    %rcx,%r10
    1518:	0f 05                	syscall
    151a:	c3                   	ret

000000000000151b <signal>:
SYSCALL(signal)
    151b:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1522:	49 89 ca             	mov    %rcx,%r10
    1525:	0f 05                	syscall
    1527:	c3                   	ret

0000000000001528 <sigret>:
SYSCALL(sigret)
    1528:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    152f:	49 89 ca             	mov    %rcx,%r10
    1532:	0f 05                	syscall
    1534:	c3                   	ret

0000000000001535 <fgproc>:
SYSCALL(fgproc)
    1535:	48 c7 c0 19 00 00 00 	mov    $0x19,%rax
    153c:	49 89 ca             	mov    %rcx,%r10
    153f:	0f 05                	syscall
    1541:	c3                   	ret

0000000000001542 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1542:	55                   	push   %rbp
    1543:	48 89 e5             	mov    %rsp,%rbp
    1546:	48 83 ec 10          	sub    $0x10,%rsp
    154a:	89 7d fc             	mov    %edi,-0x4(%rbp)
    154d:	89 f0                	mov    %esi,%eax
    154f:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1552:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1556:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1559:	ba 01 00 00 00       	mov    $0x1,%edx
    155e:	48 89 ce             	mov    %rcx,%rsi
    1561:	89 c7                	mov    %eax,%edi
    1563:	48 b8 3e 14 00 00 00 	movabs $0x143e,%rax
    156a:	00 00 00 
    156d:	ff d0                	call   *%rax
}
    156f:	90                   	nop
    1570:	c9                   	leave
    1571:	c3                   	ret

0000000000001572 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1572:	55                   	push   %rbp
    1573:	48 89 e5             	mov    %rsp,%rbp
    1576:	48 83 ec 20          	sub    $0x20,%rsp
    157a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    157d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1581:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1588:	eb 35                	jmp    15bf <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    158a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    158e:	48 c1 e8 3c          	shr    $0x3c,%rax
    1592:	48 ba 90 1e 00 00 00 	movabs $0x1e90,%rdx
    1599:	00 00 00 
    159c:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    15a0:	0f be d0             	movsbl %al,%edx
    15a3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    15a6:	89 d6                	mov    %edx,%esi
    15a8:	89 c7                	mov    %eax,%edi
    15aa:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    15b1:	00 00 00 
    15b4:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    15b6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    15ba:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    15bf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15c2:	83 f8 0f             	cmp    $0xf,%eax
    15c5:	76 c3                	jbe    158a <print_x64+0x18>
}
    15c7:	90                   	nop
    15c8:	90                   	nop
    15c9:	c9                   	leave
    15ca:	c3                   	ret

00000000000015cb <print_x32>:

  static void
print_x32(int fd, uint x)
{
    15cb:	55                   	push   %rbp
    15cc:	48 89 e5             	mov    %rsp,%rbp
    15cf:	48 83 ec 20          	sub    $0x20,%rsp
    15d3:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15d6:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    15d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15e0:	eb 36                	jmp    1618 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    15e2:	8b 45 e8             	mov    -0x18(%rbp),%eax
    15e5:	c1 e8 1c             	shr    $0x1c,%eax
    15e8:	89 c2                	mov    %eax,%edx
    15ea:	48 b8 90 1e 00 00 00 	movabs $0x1e90,%rax
    15f1:	00 00 00 
    15f4:	89 d2                	mov    %edx,%edx
    15f6:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    15fa:	0f be d0             	movsbl %al,%edx
    15fd:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1600:	89 d6                	mov    %edx,%esi
    1602:	89 c7                	mov    %eax,%edi
    1604:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    160b:	00 00 00 
    160e:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1610:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1614:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1618:	8b 45 fc             	mov    -0x4(%rbp),%eax
    161b:	83 f8 07             	cmp    $0x7,%eax
    161e:	76 c2                	jbe    15e2 <print_x32+0x17>
}
    1620:	90                   	nop
    1621:	90                   	nop
    1622:	c9                   	leave
    1623:	c3                   	ret

0000000000001624 <print_d>:

  static void
print_d(int fd, int v)
{
    1624:	55                   	push   %rbp
    1625:	48 89 e5             	mov    %rsp,%rbp
    1628:	48 83 ec 30          	sub    $0x30,%rsp
    162c:	89 7d dc             	mov    %edi,-0x24(%rbp)
    162f:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1632:	8b 45 d8             	mov    -0x28(%rbp),%eax
    1635:	48 98                	cltq
    1637:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    163b:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    163f:	79 04                	jns    1645 <print_d+0x21>
    x = -x;
    1641:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    1645:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    164c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1650:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1657:	66 66 66 
    165a:	48 89 c8             	mov    %rcx,%rax
    165d:	48 f7 ea             	imul   %rdx
    1660:	48 c1 fa 02          	sar    $0x2,%rdx
    1664:	48 89 c8             	mov    %rcx,%rax
    1667:	48 c1 f8 3f          	sar    $0x3f,%rax
    166b:	48 29 c2             	sub    %rax,%rdx
    166e:	48 89 d0             	mov    %rdx,%rax
    1671:	48 c1 e0 02          	shl    $0x2,%rax
    1675:	48 01 d0             	add    %rdx,%rax
    1678:	48 01 c0             	add    %rax,%rax
    167b:	48 29 c1             	sub    %rax,%rcx
    167e:	48 89 ca             	mov    %rcx,%rdx
    1681:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1684:	8d 48 01             	lea    0x1(%rax),%ecx
    1687:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    168a:	48 b9 90 1e 00 00 00 	movabs $0x1e90,%rcx
    1691:	00 00 00 
    1694:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1698:	48 98                	cltq
    169a:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    169e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16a2:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    16a9:	66 66 66 
    16ac:	48 89 c8             	mov    %rcx,%rax
    16af:	48 f7 ea             	imul   %rdx
    16b2:	48 89 d0             	mov    %rdx,%rax
    16b5:	48 c1 f8 02          	sar    $0x2,%rax
    16b9:	48 c1 f9 3f          	sar    $0x3f,%rcx
    16bd:	48 89 ca             	mov    %rcx,%rdx
    16c0:	48 29 d0             	sub    %rdx,%rax
    16c3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    16c7:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    16cc:	0f 85 7a ff ff ff    	jne    164c <print_d+0x28>

  if (v < 0)
    16d2:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16d6:	79 32                	jns    170a <print_d+0xe6>
    buf[i++] = '-';
    16d8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16db:	8d 50 01             	lea    0x1(%rax),%edx
    16de:	89 55 f4             	mov    %edx,-0xc(%rbp)
    16e1:	48 98                	cltq
    16e3:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    16e8:	eb 20                	jmp    170a <print_d+0xe6>
    putc(fd, buf[i]);
    16ea:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16ed:	48 98                	cltq
    16ef:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    16f4:	0f be d0             	movsbl %al,%edx
    16f7:	8b 45 dc             	mov    -0x24(%rbp),%eax
    16fa:	89 d6                	mov    %edx,%esi
    16fc:	89 c7                	mov    %eax,%edi
    16fe:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    1705:	00 00 00 
    1708:	ff d0                	call   *%rax
  while (--i >= 0)
    170a:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    170e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1712:	79 d6                	jns    16ea <print_d+0xc6>
}
    1714:	90                   	nop
    1715:	90                   	nop
    1716:	c9                   	leave
    1717:	c3                   	ret

0000000000001718 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1718:	55                   	push   %rbp
    1719:	48 89 e5             	mov    %rsp,%rbp
    171c:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1723:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1729:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1730:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1737:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    173e:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1745:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    174c:	84 c0                	test   %al,%al
    174e:	74 20                	je     1770 <printf+0x58>
    1750:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1754:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1758:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    175c:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1760:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1764:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1768:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    176c:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1770:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1777:	00 00 00 
    177a:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1781:	00 00 00 
    1784:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1788:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    178f:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1796:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    179d:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    17a4:	00 00 00 
    17a7:	e9 60 03 00 00       	jmp    1b0c <printf+0x3f4>
    if (c != '%') {
    17ac:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17b3:	74 24                	je     17d9 <printf+0xc1>
      putc(fd, c);
    17b5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    17bb:	0f be d0             	movsbl %al,%edx
    17be:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    17c4:	89 d6                	mov    %edx,%esi
    17c6:	89 c7                	mov    %eax,%edi
    17c8:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    17cf:	00 00 00 
    17d2:	ff d0                	call   *%rax
      continue;
    17d4:	e9 2c 03 00 00       	jmp    1b05 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    17d9:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    17e0:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    17e6:	48 63 d0             	movslq %eax,%rdx
    17e9:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    17f0:	48 01 d0             	add    %rdx,%rax
    17f3:	0f b6 00             	movzbl (%rax),%eax
    17f6:	0f be c0             	movsbl %al,%eax
    17f9:	25 ff 00 00 00       	and    $0xff,%eax
    17fe:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1804:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    180b:	0f 84 2e 03 00 00    	je     1b3f <printf+0x427>
      break;
    switch(c) {
    1811:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1818:	0f 84 32 01 00 00    	je     1950 <printf+0x238>
    181e:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1825:	0f 8f a1 02 00 00    	jg     1acc <printf+0x3b4>
    182b:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1832:	0f 84 d4 01 00 00    	je     1a0c <printf+0x2f4>
    1838:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    183f:	0f 8f 87 02 00 00    	jg     1acc <printf+0x3b4>
    1845:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    184c:	0f 84 5b 01 00 00    	je     19ad <printf+0x295>
    1852:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1859:	0f 8f 6d 02 00 00    	jg     1acc <printf+0x3b4>
    185f:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1866:	0f 84 87 00 00 00    	je     18f3 <printf+0x1db>
    186c:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1873:	0f 8f 53 02 00 00    	jg     1acc <printf+0x3b4>
    1879:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1880:	0f 84 2b 02 00 00    	je     1ab1 <printf+0x399>
    1886:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    188d:	0f 85 39 02 00 00    	jne    1acc <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1893:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1899:	83 f8 2f             	cmp    $0x2f,%eax
    189c:	77 23                	ja     18c1 <printf+0x1a9>
    189e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18a5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18ab:	89 d2                	mov    %edx,%edx
    18ad:	48 01 d0             	add    %rdx,%rax
    18b0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18b6:	83 c2 08             	add    $0x8,%edx
    18b9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18bf:	eb 12                	jmp    18d3 <printf+0x1bb>
    18c1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18c8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18cc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18d3:	8b 00                	mov    (%rax),%eax
    18d5:	0f be d0             	movsbl %al,%edx
    18d8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18de:	89 d6                	mov    %edx,%esi
    18e0:	89 c7                	mov    %eax,%edi
    18e2:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    18e9:	00 00 00 
    18ec:	ff d0                	call   *%rax
      break;
    18ee:	e9 12 02 00 00       	jmp    1b05 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    18f3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18f9:	83 f8 2f             	cmp    $0x2f,%eax
    18fc:	77 23                	ja     1921 <printf+0x209>
    18fe:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1905:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    190b:	89 d2                	mov    %edx,%edx
    190d:	48 01 d0             	add    %rdx,%rax
    1910:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1916:	83 c2 08             	add    $0x8,%edx
    1919:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    191f:	eb 12                	jmp    1933 <printf+0x21b>
    1921:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1928:	48 8d 50 08          	lea    0x8(%rax),%rdx
    192c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1933:	8b 10                	mov    (%rax),%edx
    1935:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    193b:	89 d6                	mov    %edx,%esi
    193d:	89 c7                	mov    %eax,%edi
    193f:	48 b8 24 16 00 00 00 	movabs $0x1624,%rax
    1946:	00 00 00 
    1949:	ff d0                	call   *%rax
      break;
    194b:	e9 b5 01 00 00       	jmp    1b05 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1950:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1956:	83 f8 2f             	cmp    $0x2f,%eax
    1959:	77 23                	ja     197e <printf+0x266>
    195b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1962:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1968:	89 d2                	mov    %edx,%edx
    196a:	48 01 d0             	add    %rdx,%rax
    196d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1973:	83 c2 08             	add    $0x8,%edx
    1976:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    197c:	eb 12                	jmp    1990 <printf+0x278>
    197e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1985:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1989:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1990:	8b 10                	mov    (%rax),%edx
    1992:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1998:	89 d6                	mov    %edx,%esi
    199a:	89 c7                	mov    %eax,%edi
    199c:	48 b8 cb 15 00 00 00 	movabs $0x15cb,%rax
    19a3:	00 00 00 
    19a6:	ff d0                	call   *%rax
      break;
    19a8:	e9 58 01 00 00       	jmp    1b05 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    19ad:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19b3:	83 f8 2f             	cmp    $0x2f,%eax
    19b6:	77 23                	ja     19db <printf+0x2c3>
    19b8:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19bf:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c5:	89 d2                	mov    %edx,%edx
    19c7:	48 01 d0             	add    %rdx,%rax
    19ca:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d0:	83 c2 08             	add    $0x8,%edx
    19d3:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19d9:	eb 12                	jmp    19ed <printf+0x2d5>
    19db:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19e2:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19e6:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19ed:	48 8b 10             	mov    (%rax),%rdx
    19f0:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19f6:	48 89 d6             	mov    %rdx,%rsi
    19f9:	89 c7                	mov    %eax,%edi
    19fb:	48 b8 72 15 00 00 00 	movabs $0x1572,%rax
    1a02:	00 00 00 
    1a05:	ff d0                	call   *%rax
      break;
    1a07:	e9 f9 00 00 00       	jmp    1b05 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1a0c:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a12:	83 f8 2f             	cmp    $0x2f,%eax
    1a15:	77 23                	ja     1a3a <printf+0x322>
    1a17:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a1e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a24:	89 d2                	mov    %edx,%edx
    1a26:	48 01 d0             	add    %rdx,%rax
    1a29:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a2f:	83 c2 08             	add    $0x8,%edx
    1a32:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a38:	eb 12                	jmp    1a4c <printf+0x334>
    1a3a:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a41:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a45:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a4c:	48 8b 00             	mov    (%rax),%rax
    1a4f:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1a56:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1a5d:	00 
    1a5e:	75 41                	jne    1aa1 <printf+0x389>
        s = "(null)";
    1a60:	48 b8 7a 1e 00 00 00 	movabs $0x1e7a,%rax
    1a67:	00 00 00 
    1a6a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1a71:	eb 2e                	jmp    1aa1 <printf+0x389>
        putc(fd, *(s++));
    1a73:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a7a:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a7e:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a85:	0f b6 00             	movzbl (%rax),%eax
    1a88:	0f be d0             	movsbl %al,%edx
    1a8b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a91:	89 d6                	mov    %edx,%esi
    1a93:	89 c7                	mov    %eax,%edi
    1a95:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    1a9c:	00 00 00 
    1a9f:	ff d0                	call   *%rax
      while (*s)
    1aa1:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1aa8:	0f b6 00             	movzbl (%rax),%eax
    1aab:	84 c0                	test   %al,%al
    1aad:	75 c4                	jne    1a73 <printf+0x35b>
      break;
    1aaf:	eb 54                	jmp    1b05 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1ab1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ab7:	be 25 00 00 00       	mov    $0x25,%esi
    1abc:	89 c7                	mov    %eax,%edi
    1abe:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    1ac5:	00 00 00 
    1ac8:	ff d0                	call   *%rax
      break;
    1aca:	eb 39                	jmp    1b05 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1acc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ad2:	be 25 00 00 00       	mov    $0x25,%esi
    1ad7:	89 c7                	mov    %eax,%edi
    1ad9:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    1ae0:	00 00 00 
    1ae3:	ff d0                	call   *%rax
      putc(fd, c);
    1ae5:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1aeb:	0f be d0             	movsbl %al,%edx
    1aee:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1af4:	89 d6                	mov    %edx,%esi
    1af6:	89 c7                	mov    %eax,%edi
    1af8:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    1aff:	00 00 00 
    1b02:	ff d0                	call   *%rax
      break;
    1b04:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1b05:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1b0c:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1b12:	48 63 d0             	movslq %eax,%rdx
    1b15:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1b1c:	48 01 d0             	add    %rdx,%rax
    1b1f:	0f b6 00             	movzbl (%rax),%eax
    1b22:	0f be c0             	movsbl %al,%eax
    1b25:	25 ff 00 00 00       	and    $0xff,%eax
    1b2a:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1b30:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b37:	0f 85 6f fc ff ff    	jne    17ac <printf+0x94>
    }
  }
}
    1b3d:	eb 01                	jmp    1b40 <printf+0x428>
      break;
    1b3f:	90                   	nop
}
    1b40:	90                   	nop
    1b41:	c9                   	leave
    1b42:	c3                   	ret

0000000000001b43 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b43:	55                   	push   %rbp
    1b44:	48 89 e5             	mov    %rsp,%rbp
    1b47:	48 83 ec 18          	sub    $0x18,%rsp
    1b4b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b4f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1b53:	48 83 e8 10          	sub    $0x10,%rax
    1b57:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b5b:	48 b8 c0 1e 00 00 00 	movabs $0x1ec0,%rax
    1b62:	00 00 00 
    1b65:	48 8b 00             	mov    (%rax),%rax
    1b68:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b6c:	eb 2f                	jmp    1b9d <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b6e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b72:	48 8b 00             	mov    (%rax),%rax
    1b75:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b79:	72 17                	jb     1b92 <free+0x4f>
    1b7b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b7f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b83:	72 2f                	jb     1bb4 <free+0x71>
    1b85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b89:	48 8b 00             	mov    (%rax),%rax
    1b8c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b90:	72 22                	jb     1bb4 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b92:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b96:	48 8b 00             	mov    (%rax),%rax
    1b99:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b9d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ba1:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ba5:	73 c7                	jae    1b6e <free+0x2b>
    1ba7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bab:	48 8b 00             	mov    (%rax),%rax
    1bae:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bb2:	73 ba                	jae    1b6e <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1bb4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb8:	8b 40 08             	mov    0x8(%rax),%eax
    1bbb:	89 c0                	mov    %eax,%eax
    1bbd:	48 c1 e0 04          	shl    $0x4,%rax
    1bc1:	48 89 c2             	mov    %rax,%rdx
    1bc4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc8:	48 01 c2             	add    %rax,%rdx
    1bcb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bcf:	48 8b 00             	mov    (%rax),%rax
    1bd2:	48 39 c2             	cmp    %rax,%rdx
    1bd5:	75 2d                	jne    1c04 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1bd7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bdb:	8b 50 08             	mov    0x8(%rax),%edx
    1bde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be2:	48 8b 00             	mov    (%rax),%rax
    1be5:	8b 40 08             	mov    0x8(%rax),%eax
    1be8:	01 c2                	add    %eax,%edx
    1bea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bee:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1bf1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf5:	48 8b 00             	mov    (%rax),%rax
    1bf8:	48 8b 10             	mov    (%rax),%rdx
    1bfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bff:	48 89 10             	mov    %rdx,(%rax)
    1c02:	eb 0e                	jmp    1c12 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1c04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c08:	48 8b 10             	mov    (%rax),%rdx
    1c0b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c0f:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1c12:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c16:	8b 40 08             	mov    0x8(%rax),%eax
    1c19:	89 c0                	mov    %eax,%eax
    1c1b:	48 c1 e0 04          	shl    $0x4,%rax
    1c1f:	48 89 c2             	mov    %rax,%rdx
    1c22:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c26:	48 01 d0             	add    %rdx,%rax
    1c29:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c2d:	75 27                	jne    1c56 <free+0x113>
    p->s.size += bp->s.size;
    1c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c33:	8b 50 08             	mov    0x8(%rax),%edx
    1c36:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c3a:	8b 40 08             	mov    0x8(%rax),%eax
    1c3d:	01 c2                	add    %eax,%edx
    1c3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c43:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1c46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c4a:	48 8b 10             	mov    (%rax),%rdx
    1c4d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c51:	48 89 10             	mov    %rdx,(%rax)
    1c54:	eb 0b                	jmp    1c61 <free+0x11e>
  } else
    p->s.ptr = bp;
    1c56:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c5a:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1c5e:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1c61:	48 ba c0 1e 00 00 00 	movabs $0x1ec0,%rdx
    1c68:	00 00 00 
    1c6b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6f:	48 89 02             	mov    %rax,(%rdx)
}
    1c72:	90                   	nop
    1c73:	c9                   	leave
    1c74:	c3                   	ret

0000000000001c75 <morecore>:

static Header*
morecore(uint nu)
{
    1c75:	55                   	push   %rbp
    1c76:	48 89 e5             	mov    %rsp,%rbp
    1c79:	48 83 ec 20          	sub    $0x20,%rsp
    1c7d:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c80:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c87:	77 07                	ja     1c90 <morecore+0x1b>
    nu = 4096;
    1c89:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c90:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c93:	48 c1 e0 04          	shl    $0x4,%rax
    1c97:	48 89 c7             	mov    %rax,%rdi
    1c9a:	48 b8 e7 14 00 00 00 	movabs $0x14e7,%rax
    1ca1:	00 00 00 
    1ca4:	ff d0                	call   *%rax
    1ca6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1caa:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1caf:	75 07                	jne    1cb8 <morecore+0x43>
    return 0;
    1cb1:	b8 00 00 00 00       	mov    $0x0,%eax
    1cb6:	eb 36                	jmp    1cee <morecore+0x79>
  hp = (Header*)p;
    1cb8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cbc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1cc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc4:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1cc7:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1cca:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cce:	48 83 c0 10          	add    $0x10,%rax
    1cd2:	48 89 c7             	mov    %rax,%rdi
    1cd5:	48 b8 43 1b 00 00 00 	movabs $0x1b43,%rax
    1cdc:	00 00 00 
    1cdf:	ff d0                	call   *%rax
  return freep;
    1ce1:	48 b8 c0 1e 00 00 00 	movabs $0x1ec0,%rax
    1ce8:	00 00 00 
    1ceb:	48 8b 00             	mov    (%rax),%rax
}
    1cee:	c9                   	leave
    1cef:	c3                   	ret

0000000000001cf0 <malloc>:

void*
malloc(uint nbytes)
{
    1cf0:	55                   	push   %rbp
    1cf1:	48 89 e5             	mov    %rsp,%rbp
    1cf4:	48 83 ec 30          	sub    $0x30,%rsp
    1cf8:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1cfb:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1cfe:	48 83 c0 0f          	add    $0xf,%rax
    1d02:	48 c1 e8 04          	shr    $0x4,%rax
    1d06:	83 c0 01             	add    $0x1,%eax
    1d09:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1d0c:	48 b8 c0 1e 00 00 00 	movabs $0x1ec0,%rax
    1d13:	00 00 00 
    1d16:	48 8b 00             	mov    (%rax),%rax
    1d19:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d1d:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1d22:	75 4a                	jne    1d6e <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1d24:	48 b8 b0 1e 00 00 00 	movabs $0x1eb0,%rax
    1d2b:	00 00 00 
    1d2e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d32:	48 ba c0 1e 00 00 00 	movabs $0x1ec0,%rdx
    1d39:	00 00 00 
    1d3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d40:	48 89 02             	mov    %rax,(%rdx)
    1d43:	48 b8 c0 1e 00 00 00 	movabs $0x1ec0,%rax
    1d4a:	00 00 00 
    1d4d:	48 8b 00             	mov    (%rax),%rax
    1d50:	48 ba b0 1e 00 00 00 	movabs $0x1eb0,%rdx
    1d57:	00 00 00 
    1d5a:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1d5d:	48 b8 b0 1e 00 00 00 	movabs $0x1eb0,%rax
    1d64:	00 00 00 
    1d67:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d72:	48 8b 00             	mov    (%rax),%rax
    1d75:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1d79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7d:	8b 40 08             	mov    0x8(%rax),%eax
    1d80:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d83:	72 65                	jb     1dea <malloc+0xfa>
      if(p->s.size == nunits)
    1d85:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d89:	8b 40 08             	mov    0x8(%rax),%eax
    1d8c:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d8f:	75 10                	jne    1da1 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d91:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d95:	48 8b 10             	mov    (%rax),%rdx
    1d98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d9c:	48 89 10             	mov    %rdx,(%rax)
    1d9f:	eb 2e                	jmp    1dcf <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1da1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da5:	8b 40 08             	mov    0x8(%rax),%eax
    1da8:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1dab:	89 c2                	mov    %eax,%edx
    1dad:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db1:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1db4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db8:	8b 40 08             	mov    0x8(%rax),%eax
    1dbb:	89 c0                	mov    %eax,%eax
    1dbd:	48 c1 e0 04          	shl    $0x4,%rax
    1dc1:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1dc5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dc9:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1dcc:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1dcf:	48 ba c0 1e 00 00 00 	movabs $0x1ec0,%rdx
    1dd6:	00 00 00 
    1dd9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ddd:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1de0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de4:	48 83 c0 10          	add    $0x10,%rax
    1de8:	eb 4e                	jmp    1e38 <malloc+0x148>
    }
    if(p == freep)
    1dea:	48 b8 c0 1e 00 00 00 	movabs $0x1ec0,%rax
    1df1:	00 00 00 
    1df4:	48 8b 00             	mov    (%rax),%rax
    1df7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1dfb:	75 23                	jne    1e20 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1dfd:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e00:	89 c7                	mov    %eax,%edi
    1e02:	48 b8 75 1c 00 00 00 	movabs $0x1c75,%rax
    1e09:	00 00 00 
    1e0c:	ff d0                	call   *%rax
    1e0e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e12:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1e17:	75 07                	jne    1e20 <malloc+0x130>
        return 0;
    1e19:	b8 00 00 00 00       	mov    $0x0,%eax
    1e1e:	eb 18                	jmp    1e38 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e20:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e24:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2c:	48 8b 00             	mov    (%rax),%rax
    1e2f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e33:	e9 41 ff ff ff       	jmp    1d79 <malloc+0x89>
  }
}
    1e38:	c9                   	leave
    1e39:	c3                   	ret
