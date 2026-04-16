
_bad:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include"types.h"
#include"user.h"
int main(int argc, char** argv) {
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 30          	sub    $0x30,%rsp
    1008:	89 7d dc             	mov    %edi,-0x24(%rbp)
    100b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  printf(1,"About to make first mmap. Next, you should see the first sentence from README\n");
    100f:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1016:	00 00 00 
    1019:	48 89 c6             	mov    %rax,%rsi
    101c:	bf 01 00 00 00       	mov    $0x1,%edi
    1021:	b8 00 00 00 00       	mov    $0x0,%eax
    1026:	48 ba 0e 18 00 00 00 	movabs $0x180e,%rdx
    102d:	00 00 00 
    1030:	ff d2                	call   *%rdx
  int fd = open("README",0);
    1032:	48 b8 7f 1f 00 00 00 	movabs $0x1f7f,%rax
    1039:	00 00 00 
    103c:	be 00 00 00 00       	mov    $0x0,%esi
    1041:	48 89 c7             	mov    %rax,%rdi
    1044:	48 b8 8f 15 00 00 00 	movabs $0x158f,%rax
    104b:	00 00 00 
    104e:	ff d0                	call   *%rax
    1050:	89 45 fc             	mov    %eax,-0x4(%rbp)
  char* text = mmap(fd,1);
    1053:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1056:	be 01 00 00 00       	mov    $0x1,%esi
    105b:	89 c7                	mov    %eax,%edi
    105d:	48 b8 2b 16 00 00 00 	movabs $0x162b,%rax
    1064:	00 00 00 
    1067:	ff d0                	call   *%rax
    1069:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  text[85]=0;
    106d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1071:	48 83 c0 55          	add    $0x55,%rax
    1075:	c6 00 00             	movb   $0x0,(%rax)
  if(text!=(void*)0x400000000000lu)
    1078:	48 b8 00 00 00 00 00 	movabs $0x400000000000,%rax
    107f:	40 00 00 
    1082:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1086:	74 2a                	je     10b2 <main+0xb2>
    printf(1,"Returned pointer is %d, should be 1073741824 (0x40000000)\n",text);
    1088:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    108c:	48 b9 88 1f 00 00 00 	movabs $0x1f88,%rcx
    1093:	00 00 00 
    1096:	48 89 c2             	mov    %rax,%rdx
    1099:	48 89 ce             	mov    %rcx,%rsi
    109c:	bf 01 00 00 00       	mov    $0x1,%edi
    10a1:	b8 00 00 00 00       	mov    $0x0,%eax
    10a6:	48 b9 0e 18 00 00 00 	movabs $0x180e,%rcx
    10ad:	00 00 00 
    10b0:	ff d1                	call   *%rcx
  printf(1,"%s\n",text);
    10b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10b6:	48 b9 c3 1f 00 00 00 	movabs $0x1fc3,%rcx
    10bd:	00 00 00 
    10c0:	48 89 c2             	mov    %rax,%rdx
    10c3:	48 89 ce             	mov    %rcx,%rsi
    10c6:	bf 01 00 00 00       	mov    $0x1,%edi
    10cb:	b8 00 00 00 00       	mov    $0x0,%eax
    10d0:	48 b9 0e 18 00 00 00 	movabs $0x180e,%rcx
    10d7:	00 00 00 
    10da:	ff d1                	call   *%rcx

  printf(1,"\nSecond mmap coming\n");
    10dc:	48 b8 c7 1f 00 00 00 	movabs $0x1fc7,%rax
    10e3:	00 00 00 
    10e6:	48 89 c6             	mov    %rax,%rsi
    10e9:	bf 01 00 00 00       	mov    $0x1,%edi
    10ee:	b8 00 00 00 00       	mov    $0x0,%eax
    10f3:	48 ba 0e 18 00 00 00 	movabs $0x180e,%rdx
    10fa:	00 00 00 
    10fd:	ff d2                	call   *%rdx
  int fd2 = open("LARGE",0);
    10ff:	48 b8 dc 1f 00 00 00 	movabs $0x1fdc,%rax
    1106:	00 00 00 
    1109:	be 00 00 00 00       	mov    $0x0,%esi
    110e:	48 89 c7             	mov    %rax,%rdi
    1111:	48 b8 8f 15 00 00 00 	movabs $0x158f,%rax
    1118:	00 00 00 
    111b:	ff d0                	call   *%rax
    111d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  char* text2 = mmap(fd2,1);
    1120:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1123:	be 01 00 00 00       	mov    $0x1,%esi
    1128:	89 c7                	mov    %eax,%edi
    112a:	48 b8 2b 16 00 00 00 	movabs $0x162b,%rax
    1131:	00 00 00 
    1134:	ff d0                	call   *%rax
    1136:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

  text2[71680]=0;
    113a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    113e:	48 05 00 18 01 00    	add    $0x11800,%rax
    1144:	c6 00 00             	movb   $0x0,(%rax)
  if(text2!=(void*)0x400000001000lu)
    1147:	48 b8 00 10 00 00 00 	movabs $0x400000001000,%rax
    114e:	40 00 00 
    1151:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
    1155:	74 2a                	je     1181 <main+0x181>
    printf(1,"Returned pointer is %d, should be 1073741824+4069 (0x40001000)\n",text2);
    1157:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    115b:	48 b9 e8 1f 00 00 00 	movabs $0x1fe8,%rcx
    1162:	00 00 00 
    1165:	48 89 c2             	mov    %rax,%rdx
    1168:	48 89 ce             	mov    %rcx,%rsi
    116b:	bf 01 00 00 00       	mov    $0x1,%edi
    1170:	b8 00 00 00 00       	mov    $0x0,%eax
    1175:	48 b9 0e 18 00 00 00 	movabs $0x180e,%rcx
    117c:	00 00 00 
    117f:	ff d1                	call   *%rcx
  printf(1,"%s\n",text2+71661);
    1181:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1185:	48 8d 90 ed 17 01 00 	lea    0x117ed(%rax),%rdx
    118c:	48 b8 c3 1f 00 00 00 	movabs $0x1fc3,%rax
    1193:	00 00 00 
    1196:	48 89 c6             	mov    %rax,%rsi
    1199:	bf 01 00 00 00       	mov    $0x1,%edi
    119e:	b8 00 00 00 00       	mov    $0x0,%eax
    11a3:	48 b9 0e 18 00 00 00 	movabs $0x180e,%rcx
    11aa:	00 00 00 
    11ad:	ff d1                	call   *%rcx

  printf(1,"Now trying to access a page I shouldn't be accessing... ought to crash with trap 14.\n");
    11af:	48 b8 28 20 00 00 00 	movabs $0x2028,%rax
    11b6:	00 00 00 
    11b9:	48 89 c6             	mov    %rax,%rsi
    11bc:	bf 01 00 00 00       	mov    $0x1,%edi
    11c1:	b8 00 00 00 00       	mov    $0x0,%eax
    11c6:	48 ba 0e 18 00 00 00 	movabs $0x180e,%rdx
    11cd:	00 00 00 
    11d0:	ff d2                	call   *%rdx
  printf(1,"%s\n",text2+80000);
    11d2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    11d6:	48 8d 90 80 38 01 00 	lea    0x13880(%rax),%rdx
    11dd:	48 b8 c3 1f 00 00 00 	movabs $0x1fc3,%rax
    11e4:	00 00 00 
    11e7:	48 89 c6             	mov    %rax,%rsi
    11ea:	bf 01 00 00 00       	mov    $0x1,%edi
    11ef:	b8 00 00 00 00       	mov    $0x0,%eax
    11f4:	48 b9 0e 18 00 00 00 	movabs $0x180e,%rcx
    11fb:	00 00 00 
    11fe:	ff d1                	call   *%rcx

  exit();
    1200:	48 b8 27 15 00 00 00 	movabs $0x1527,%rax
    1207:	00 00 00 
    120a:	ff d0                	call   *%rax

000000000000120c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    120c:	55                   	push   %rbp
    120d:	48 89 e5             	mov    %rsp,%rbp
    1210:	48 83 ec 10          	sub    $0x10,%rsp
    1214:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1218:	89 75 f4             	mov    %esi,-0xc(%rbp)
    121b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    121e:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1222:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1225:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1228:	48 89 ce             	mov    %rcx,%rsi
    122b:	48 89 f7             	mov    %rsi,%rdi
    122e:	89 d1                	mov    %edx,%ecx
    1230:	fc                   	cld
    1231:	f3 aa                	rep stos %al,(%rdi)
    1233:	89 ca                	mov    %ecx,%edx
    1235:	48 89 fe             	mov    %rdi,%rsi
    1238:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    123c:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    123f:	90                   	nop
    1240:	c9                   	leave
    1241:	c3                   	ret

0000000000001242 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1242:	55                   	push   %rbp
    1243:	48 89 e5             	mov    %rsp,%rbp
    1246:	48 83 ec 20          	sub    $0x20,%rsp
    124a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    124e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    1252:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1256:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    125a:	90                   	nop
    125b:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    125f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1263:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    1267:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    126b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    126f:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1273:	0f b6 12             	movzbl (%rdx),%edx
    1276:	88 10                	mov    %dl,(%rax)
    1278:	0f b6 00             	movzbl (%rax),%eax
    127b:	84 c0                	test   %al,%al
    127d:	75 dc                	jne    125b <strcpy+0x19>
    ;
  return os;
    127f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1283:	c9                   	leave
    1284:	c3                   	ret

0000000000001285 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1285:	55                   	push   %rbp
    1286:	48 89 e5             	mov    %rsp,%rbp
    1289:	48 83 ec 10          	sub    $0x10,%rsp
    128d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1291:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1295:	eb 0a                	jmp    12a1 <strcmp+0x1c>
    p++, q++;
    1297:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    129c:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    12a1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12a5:	0f b6 00             	movzbl (%rax),%eax
    12a8:	84 c0                	test   %al,%al
    12aa:	74 12                	je     12be <strcmp+0x39>
    12ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12b0:	0f b6 10             	movzbl (%rax),%edx
    12b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12b7:	0f b6 00             	movzbl (%rax),%eax
    12ba:	38 c2                	cmp    %al,%dl
    12bc:	74 d9                	je     1297 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    12be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12c2:	0f b6 00             	movzbl (%rax),%eax
    12c5:	0f b6 d0             	movzbl %al,%edx
    12c8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12cc:	0f b6 00             	movzbl (%rax),%eax
    12cf:	0f b6 c0             	movzbl %al,%eax
    12d2:	29 c2                	sub    %eax,%edx
    12d4:	89 d0                	mov    %edx,%eax
}
    12d6:	c9                   	leave
    12d7:	c3                   	ret

00000000000012d8 <strlen>:

uint
strlen(char *s)
{
    12d8:	55                   	push   %rbp
    12d9:	48 89 e5             	mov    %rsp,%rbp
    12dc:	48 83 ec 18          	sub    $0x18,%rsp
    12e0:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    12e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12eb:	eb 04                	jmp    12f1 <strlen+0x19>
    12ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12f1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12f4:	48 63 d0             	movslq %eax,%rdx
    12f7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12fb:	48 01 d0             	add    %rdx,%rax
    12fe:	0f b6 00             	movzbl (%rax),%eax
    1301:	84 c0                	test   %al,%al
    1303:	75 e8                	jne    12ed <strlen+0x15>
    ;
  return n;
    1305:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1308:	c9                   	leave
    1309:	c3                   	ret

000000000000130a <memset>:

void*
memset(void *dst, int c, uint n)
{
    130a:	55                   	push   %rbp
    130b:	48 89 e5             	mov    %rsp,%rbp
    130e:	48 83 ec 10          	sub    $0x10,%rsp
    1312:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1316:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1319:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    131c:	8b 55 f0             	mov    -0x10(%rbp),%edx
    131f:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1322:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1326:	89 ce                	mov    %ecx,%esi
    1328:	48 89 c7             	mov    %rax,%rdi
    132b:	48 b8 0c 12 00 00 00 	movabs $0x120c,%rax
    1332:	00 00 00 
    1335:	ff d0                	call   *%rax
  return dst;
    1337:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    133b:	c9                   	leave
    133c:	c3                   	ret

000000000000133d <strchr>:

char*
strchr(const char *s, char c)
{
    133d:	55                   	push   %rbp
    133e:	48 89 e5             	mov    %rsp,%rbp
    1341:	48 83 ec 10          	sub    $0x10,%rsp
    1345:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1349:	89 f0                	mov    %esi,%eax
    134b:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    134e:	eb 17                	jmp    1367 <strchr+0x2a>
    if(*s == c)
    1350:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1354:	0f b6 00             	movzbl (%rax),%eax
    1357:	38 45 f4             	cmp    %al,-0xc(%rbp)
    135a:	75 06                	jne    1362 <strchr+0x25>
      return (char*)s;
    135c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1360:	eb 15                	jmp    1377 <strchr+0x3a>
  for(; *s; s++)
    1362:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1367:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    136b:	0f b6 00             	movzbl (%rax),%eax
    136e:	84 c0                	test   %al,%al
    1370:	75 de                	jne    1350 <strchr+0x13>
  return 0;
    1372:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1377:	c9                   	leave
    1378:	c3                   	ret

0000000000001379 <gets>:

char*
gets(char *buf, int max)
{
    1379:	55                   	push   %rbp
    137a:	48 89 e5             	mov    %rsp,%rbp
    137d:	48 83 ec 20          	sub    $0x20,%rsp
    1381:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1385:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    138f:	eb 4f                	jmp    13e0 <gets+0x67>
    cc = read(0, &c, 1);
    1391:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1395:	ba 01 00 00 00       	mov    $0x1,%edx
    139a:	48 89 c6             	mov    %rax,%rsi
    139d:	bf 00 00 00 00       	mov    $0x0,%edi
    13a2:	48 b8 4e 15 00 00 00 	movabs $0x154e,%rax
    13a9:	00 00 00 
    13ac:	ff d0                	call   *%rax
    13ae:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    13b1:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    13b5:	7e 36                	jle    13ed <gets+0x74>
      break;
    buf[i++] = c;
    13b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13ba:	8d 50 01             	lea    0x1(%rax),%edx
    13bd:	89 55 fc             	mov    %edx,-0x4(%rbp)
    13c0:	48 63 d0             	movslq %eax,%rdx
    13c3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13c7:	48 01 c2             	add    %rax,%rdx
    13ca:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13ce:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    13d0:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13d4:	3c 0a                	cmp    $0xa,%al
    13d6:	74 16                	je     13ee <gets+0x75>
    13d8:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    13dc:	3c 0d                	cmp    $0xd,%al
    13de:	74 0e                	je     13ee <gets+0x75>
  for(i=0; i+1 < max; ){
    13e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13e3:	83 c0 01             	add    $0x1,%eax
    13e6:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13e9:	7f a6                	jg     1391 <gets+0x18>
    13eb:	eb 01                	jmp    13ee <gets+0x75>
      break;
    13ed:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13f1:	48 63 d0             	movslq %eax,%rdx
    13f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13f8:	48 01 d0             	add    %rdx,%rax
    13fb:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1402:	c9                   	leave
    1403:	c3                   	ret

0000000000001404 <stat>:

int
stat(char *n, struct stat *st)
{
    1404:	55                   	push   %rbp
    1405:	48 89 e5             	mov    %rsp,%rbp
    1408:	48 83 ec 20          	sub    $0x20,%rsp
    140c:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1410:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1414:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1418:	be 00 00 00 00       	mov    $0x0,%esi
    141d:	48 89 c7             	mov    %rax,%rdi
    1420:	48 b8 8f 15 00 00 00 	movabs $0x158f,%rax
    1427:	00 00 00 
    142a:	ff d0                	call   *%rax
    142c:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    142f:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1433:	79 07                	jns    143c <stat+0x38>
    return -1;
    1435:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    143a:	eb 2f                	jmp    146b <stat+0x67>
  r = fstat(fd, st);
    143c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1440:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1443:	48 89 d6             	mov    %rdx,%rsi
    1446:	89 c7                	mov    %eax,%edi
    1448:	48 b8 b6 15 00 00 00 	movabs $0x15b6,%rax
    144f:	00 00 00 
    1452:	ff d0                	call   *%rax
    1454:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1457:	8b 45 fc             	mov    -0x4(%rbp),%eax
    145a:	89 c7                	mov    %eax,%edi
    145c:	48 b8 68 15 00 00 00 	movabs $0x1568,%rax
    1463:	00 00 00 
    1466:	ff d0                	call   *%rax
  return r;
    1468:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    146b:	c9                   	leave
    146c:	c3                   	ret

000000000000146d <atoi>:

int
atoi(const char *s)
{
    146d:	55                   	push   %rbp
    146e:	48 89 e5             	mov    %rsp,%rbp
    1471:	48 83 ec 18          	sub    $0x18,%rsp
    1475:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1480:	eb 28                	jmp    14aa <atoi+0x3d>
    n = n*10 + *s++ - '0';
    1482:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1485:	89 d0                	mov    %edx,%eax
    1487:	c1 e0 02             	shl    $0x2,%eax
    148a:	01 d0                	add    %edx,%eax
    148c:	01 c0                	add    %eax,%eax
    148e:	89 c1                	mov    %eax,%ecx
    1490:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1494:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1498:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    149c:	0f b6 00             	movzbl (%rax),%eax
    149f:	0f be c0             	movsbl %al,%eax
    14a2:	01 c8                	add    %ecx,%eax
    14a4:	83 e8 30             	sub    $0x30,%eax
    14a7:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14aa:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14ae:	0f b6 00             	movzbl (%rax),%eax
    14b1:	3c 2f                	cmp    $0x2f,%al
    14b3:	7e 0b                	jle    14c0 <atoi+0x53>
    14b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14b9:	0f b6 00             	movzbl (%rax),%eax
    14bc:	3c 39                	cmp    $0x39,%al
    14be:	7e c2                	jle    1482 <atoi+0x15>
  return n;
    14c0:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    14c3:	c9                   	leave
    14c4:	c3                   	ret

00000000000014c5 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    14c5:	55                   	push   %rbp
    14c6:	48 89 e5             	mov    %rsp,%rbp
    14c9:	48 83 ec 28          	sub    $0x28,%rsp
    14cd:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14d1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    14d5:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    14d8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14dc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    14e0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    14e4:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14e8:	eb 1d                	jmp    1507 <memmove+0x42>
    *dst++ = *src++;
    14ea:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14ee:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14f2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14fa:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14fe:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1502:	0f b6 12             	movzbl (%rdx),%edx
    1505:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1507:	8b 45 dc             	mov    -0x24(%rbp),%eax
    150a:	8d 50 ff             	lea    -0x1(%rax),%edx
    150d:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1510:	85 c0                	test   %eax,%eax
    1512:	7f d6                	jg     14ea <memmove+0x25>
  return vdst;
    1514:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1518:	c9                   	leave
    1519:	c3                   	ret

000000000000151a <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    151a:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1521:	49 89 ca             	mov    %rcx,%r10
    1524:	0f 05                	syscall
    1526:	c3                   	ret

0000000000001527 <exit>:
SYSCALL(exit)
    1527:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    152e:	49 89 ca             	mov    %rcx,%r10
    1531:	0f 05                	syscall
    1533:	c3                   	ret

0000000000001534 <wait>:
SYSCALL(wait)
    1534:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    153b:	49 89 ca             	mov    %rcx,%r10
    153e:	0f 05                	syscall
    1540:	c3                   	ret

0000000000001541 <pipe>:
SYSCALL(pipe)
    1541:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1548:	49 89 ca             	mov    %rcx,%r10
    154b:	0f 05                	syscall
    154d:	c3                   	ret

000000000000154e <read>:
SYSCALL(read)
    154e:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1555:	49 89 ca             	mov    %rcx,%r10
    1558:	0f 05                	syscall
    155a:	c3                   	ret

000000000000155b <write>:
SYSCALL(write)
    155b:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    1562:	49 89 ca             	mov    %rcx,%r10
    1565:	0f 05                	syscall
    1567:	c3                   	ret

0000000000001568 <close>:
SYSCALL(close)
    1568:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    156f:	49 89 ca             	mov    %rcx,%r10
    1572:	0f 05                	syscall
    1574:	c3                   	ret

0000000000001575 <kill>:
SYSCALL(kill)
    1575:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    157c:	49 89 ca             	mov    %rcx,%r10
    157f:	0f 05                	syscall
    1581:	c3                   	ret

0000000000001582 <exec>:
SYSCALL(exec)
    1582:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1589:	49 89 ca             	mov    %rcx,%r10
    158c:	0f 05                	syscall
    158e:	c3                   	ret

000000000000158f <open>:
SYSCALL(open)
    158f:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1596:	49 89 ca             	mov    %rcx,%r10
    1599:	0f 05                	syscall
    159b:	c3                   	ret

000000000000159c <mknod>:
SYSCALL(mknod)
    159c:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    15a3:	49 89 ca             	mov    %rcx,%r10
    15a6:	0f 05                	syscall
    15a8:	c3                   	ret

00000000000015a9 <unlink>:
SYSCALL(unlink)
    15a9:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    15b0:	49 89 ca             	mov    %rcx,%r10
    15b3:	0f 05                	syscall
    15b5:	c3                   	ret

00000000000015b6 <fstat>:
SYSCALL(fstat)
    15b6:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    15bd:	49 89 ca             	mov    %rcx,%r10
    15c0:	0f 05                	syscall
    15c2:	c3                   	ret

00000000000015c3 <link>:
SYSCALL(link)
    15c3:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    15ca:	49 89 ca             	mov    %rcx,%r10
    15cd:	0f 05                	syscall
    15cf:	c3                   	ret

00000000000015d0 <mkdir>:
SYSCALL(mkdir)
    15d0:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    15d7:	49 89 ca             	mov    %rcx,%r10
    15da:	0f 05                	syscall
    15dc:	c3                   	ret

00000000000015dd <chdir>:
SYSCALL(chdir)
    15dd:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    15e4:	49 89 ca             	mov    %rcx,%r10
    15e7:	0f 05                	syscall
    15e9:	c3                   	ret

00000000000015ea <dup>:
SYSCALL(dup)
    15ea:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15f1:	49 89 ca             	mov    %rcx,%r10
    15f4:	0f 05                	syscall
    15f6:	c3                   	ret

00000000000015f7 <getpid>:
SYSCALL(getpid)
    15f7:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15fe:	49 89 ca             	mov    %rcx,%r10
    1601:	0f 05                	syscall
    1603:	c3                   	ret

0000000000001604 <sbrk>:
SYSCALL(sbrk)
    1604:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    160b:	49 89 ca             	mov    %rcx,%r10
    160e:	0f 05                	syscall
    1610:	c3                   	ret

0000000000001611 <sleep>:
SYSCALL(sleep)
    1611:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1618:	49 89 ca             	mov    %rcx,%r10
    161b:	0f 05                	syscall
    161d:	c3                   	ret

000000000000161e <uptime>:
SYSCALL(uptime)
    161e:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1625:	49 89 ca             	mov    %rcx,%r10
    1628:	0f 05                	syscall
    162a:	c3                   	ret

000000000000162b <mmap>:
SYSCALL(mmap)
    162b:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1632:	49 89 ca             	mov    %rcx,%r10
    1635:	0f 05                	syscall
    1637:	c3                   	ret

0000000000001638 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1638:	55                   	push   %rbp
    1639:	48 89 e5             	mov    %rsp,%rbp
    163c:	48 83 ec 10          	sub    $0x10,%rsp
    1640:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1643:	89 f0                	mov    %esi,%eax
    1645:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1648:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    164c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    164f:	ba 01 00 00 00       	mov    $0x1,%edx
    1654:	48 89 ce             	mov    %rcx,%rsi
    1657:	89 c7                	mov    %eax,%edi
    1659:	48 b8 5b 15 00 00 00 	movabs $0x155b,%rax
    1660:	00 00 00 
    1663:	ff d0                	call   *%rax
}
    1665:	90                   	nop
    1666:	c9                   	leave
    1667:	c3                   	ret

0000000000001668 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1668:	55                   	push   %rbp
    1669:	48 89 e5             	mov    %rsp,%rbp
    166c:	48 83 ec 20          	sub    $0x20,%rsp
    1670:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1673:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1677:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    167e:	eb 35                	jmp    16b5 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1680:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1684:	48 c1 e8 3c          	shr    $0x3c,%rax
    1688:	48 ba 90 20 00 00 00 	movabs $0x2090,%rdx
    168f:	00 00 00 
    1692:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1696:	0f be d0             	movsbl %al,%edx
    1699:	8b 45 ec             	mov    -0x14(%rbp),%eax
    169c:	89 d6                	mov    %edx,%esi
    169e:	89 c7                	mov    %eax,%edi
    16a0:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    16a7:	00 00 00 
    16aa:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16ac:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16b0:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    16b5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16b8:	83 f8 0f             	cmp    $0xf,%eax
    16bb:	76 c3                	jbe    1680 <print_x64+0x18>
}
    16bd:	90                   	nop
    16be:	90                   	nop
    16bf:	c9                   	leave
    16c0:	c3                   	ret

00000000000016c1 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    16c1:	55                   	push   %rbp
    16c2:	48 89 e5             	mov    %rsp,%rbp
    16c5:	48 83 ec 20          	sub    $0x20,%rsp
    16c9:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16cc:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16d6:	eb 36                	jmp    170e <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    16d8:	8b 45 e8             	mov    -0x18(%rbp),%eax
    16db:	c1 e8 1c             	shr    $0x1c,%eax
    16de:	89 c2                	mov    %eax,%edx
    16e0:	48 b8 90 20 00 00 00 	movabs $0x2090,%rax
    16e7:	00 00 00 
    16ea:	89 d2                	mov    %edx,%edx
    16ec:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16f0:	0f be d0             	movsbl %al,%edx
    16f3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16f6:	89 d6                	mov    %edx,%esi
    16f8:	89 c7                	mov    %eax,%edi
    16fa:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    1701:	00 00 00 
    1704:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1706:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    170a:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    170e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1711:	83 f8 07             	cmp    $0x7,%eax
    1714:	76 c2                	jbe    16d8 <print_x32+0x17>
}
    1716:	90                   	nop
    1717:	90                   	nop
    1718:	c9                   	leave
    1719:	c3                   	ret

000000000000171a <print_d>:

  static void
print_d(int fd, int v)
{
    171a:	55                   	push   %rbp
    171b:	48 89 e5             	mov    %rsp,%rbp
    171e:	48 83 ec 30          	sub    $0x30,%rsp
    1722:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1725:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1728:	8b 45 d8             	mov    -0x28(%rbp),%eax
    172b:	48 98                	cltq
    172d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1731:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1735:	79 04                	jns    173b <print_d+0x21>
    x = -x;
    1737:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    173b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1742:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1746:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    174d:	66 66 66 
    1750:	48 89 c8             	mov    %rcx,%rax
    1753:	48 f7 ea             	imul   %rdx
    1756:	48 c1 fa 02          	sar    $0x2,%rdx
    175a:	48 89 c8             	mov    %rcx,%rax
    175d:	48 c1 f8 3f          	sar    $0x3f,%rax
    1761:	48 29 c2             	sub    %rax,%rdx
    1764:	48 89 d0             	mov    %rdx,%rax
    1767:	48 c1 e0 02          	shl    $0x2,%rax
    176b:	48 01 d0             	add    %rdx,%rax
    176e:	48 01 c0             	add    %rax,%rax
    1771:	48 29 c1             	sub    %rax,%rcx
    1774:	48 89 ca             	mov    %rcx,%rdx
    1777:	8b 45 f4             	mov    -0xc(%rbp),%eax
    177a:	8d 48 01             	lea    0x1(%rax),%ecx
    177d:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1780:	48 b9 90 20 00 00 00 	movabs $0x2090,%rcx
    1787:	00 00 00 
    178a:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    178e:	48 98                	cltq
    1790:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1794:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1798:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    179f:	66 66 66 
    17a2:	48 89 c8             	mov    %rcx,%rax
    17a5:	48 f7 ea             	imul   %rdx
    17a8:	48 89 d0             	mov    %rdx,%rax
    17ab:	48 c1 f8 02          	sar    $0x2,%rax
    17af:	48 c1 f9 3f          	sar    $0x3f,%rcx
    17b3:	48 89 ca             	mov    %rcx,%rdx
    17b6:	48 29 d0             	sub    %rdx,%rax
    17b9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    17bd:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    17c2:	0f 85 7a ff ff ff    	jne    1742 <print_d+0x28>

  if (v < 0)
    17c8:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    17cc:	79 32                	jns    1800 <print_d+0xe6>
    buf[i++] = '-';
    17ce:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17d1:	8d 50 01             	lea    0x1(%rax),%edx
    17d4:	89 55 f4             	mov    %edx,-0xc(%rbp)
    17d7:	48 98                	cltq
    17d9:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    17de:	eb 20                	jmp    1800 <print_d+0xe6>
    putc(fd, buf[i]);
    17e0:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17e3:	48 98                	cltq
    17e5:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17ea:	0f be d0             	movsbl %al,%edx
    17ed:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17f0:	89 d6                	mov    %edx,%esi
    17f2:	89 c7                	mov    %eax,%edi
    17f4:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    17fb:	00 00 00 
    17fe:	ff d0                	call   *%rax
  while (--i >= 0)
    1800:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1804:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1808:	79 d6                	jns    17e0 <print_d+0xc6>
}
    180a:	90                   	nop
    180b:	90                   	nop
    180c:	c9                   	leave
    180d:	c3                   	ret

000000000000180e <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    180e:	55                   	push   %rbp
    180f:	48 89 e5             	mov    %rsp,%rbp
    1812:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1819:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    181f:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1826:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    182d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1834:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    183b:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1842:	84 c0                	test   %al,%al
    1844:	74 20                	je     1866 <printf+0x58>
    1846:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    184a:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    184e:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1852:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1856:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    185a:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    185e:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1862:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1866:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    186d:	00 00 00 
    1870:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1877:	00 00 00 
    187a:	48 8d 45 10          	lea    0x10(%rbp),%rax
    187e:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1885:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    188c:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1893:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    189a:	00 00 00 
    189d:	e9 60 03 00 00       	jmp    1c02 <printf+0x3f4>
    if (c != '%') {
    18a2:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18a9:	74 24                	je     18cf <printf+0xc1>
      putc(fd, c);
    18ab:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    18b1:	0f be d0             	movsbl %al,%edx
    18b4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18ba:	89 d6                	mov    %edx,%esi
    18bc:	89 c7                	mov    %eax,%edi
    18be:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    18c5:	00 00 00 
    18c8:	ff d0                	call   *%rax
      continue;
    18ca:	e9 2c 03 00 00       	jmp    1bfb <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    18cf:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    18d6:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    18dc:	48 63 d0             	movslq %eax,%rdx
    18df:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    18e6:	48 01 d0             	add    %rdx,%rax
    18e9:	0f b6 00             	movzbl (%rax),%eax
    18ec:	0f be c0             	movsbl %al,%eax
    18ef:	25 ff 00 00 00       	and    $0xff,%eax
    18f4:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18fa:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1901:	0f 84 2e 03 00 00    	je     1c35 <printf+0x427>
      break;
    switch(c) {
    1907:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    190e:	0f 84 32 01 00 00    	je     1a46 <printf+0x238>
    1914:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    191b:	0f 8f a1 02 00 00    	jg     1bc2 <printf+0x3b4>
    1921:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1928:	0f 84 d4 01 00 00    	je     1b02 <printf+0x2f4>
    192e:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1935:	0f 8f 87 02 00 00    	jg     1bc2 <printf+0x3b4>
    193b:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1942:	0f 84 5b 01 00 00    	je     1aa3 <printf+0x295>
    1948:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    194f:	0f 8f 6d 02 00 00    	jg     1bc2 <printf+0x3b4>
    1955:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    195c:	0f 84 87 00 00 00    	je     19e9 <printf+0x1db>
    1962:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1969:	0f 8f 53 02 00 00    	jg     1bc2 <printf+0x3b4>
    196f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1976:	0f 84 2b 02 00 00    	je     1ba7 <printf+0x399>
    197c:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1983:	0f 85 39 02 00 00    	jne    1bc2 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1989:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    198f:	83 f8 2f             	cmp    $0x2f,%eax
    1992:	77 23                	ja     19b7 <printf+0x1a9>
    1994:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    199b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a1:	89 d2                	mov    %edx,%edx
    19a3:	48 01 d0             	add    %rdx,%rax
    19a6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ac:	83 c2 08             	add    $0x8,%edx
    19af:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19b5:	eb 12                	jmp    19c9 <printf+0x1bb>
    19b7:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19be:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19c2:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19c9:	8b 00                	mov    (%rax),%eax
    19cb:	0f be d0             	movsbl %al,%edx
    19ce:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19d4:	89 d6                	mov    %edx,%esi
    19d6:	89 c7                	mov    %eax,%edi
    19d8:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    19df:	00 00 00 
    19e2:	ff d0                	call   *%rax
      break;
    19e4:	e9 12 02 00 00       	jmp    1bfb <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19e9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19ef:	83 f8 2f             	cmp    $0x2f,%eax
    19f2:	77 23                	ja     1a17 <printf+0x209>
    19f4:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19fb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a01:	89 d2                	mov    %edx,%edx
    1a03:	48 01 d0             	add    %rdx,%rax
    1a06:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a0c:	83 c2 08             	add    $0x8,%edx
    1a0f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a15:	eb 12                	jmp    1a29 <printf+0x21b>
    1a17:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a1e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a22:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a29:	8b 10                	mov    (%rax),%edx
    1a2b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a31:	89 d6                	mov    %edx,%esi
    1a33:	89 c7                	mov    %eax,%edi
    1a35:	48 b8 1a 17 00 00 00 	movabs $0x171a,%rax
    1a3c:	00 00 00 
    1a3f:	ff d0                	call   *%rax
      break;
    1a41:	e9 b5 01 00 00       	jmp    1bfb <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a46:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a4c:	83 f8 2f             	cmp    $0x2f,%eax
    1a4f:	77 23                	ja     1a74 <printf+0x266>
    1a51:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a58:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a5e:	89 d2                	mov    %edx,%edx
    1a60:	48 01 d0             	add    %rdx,%rax
    1a63:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a69:	83 c2 08             	add    $0x8,%edx
    1a6c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a72:	eb 12                	jmp    1a86 <printf+0x278>
    1a74:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a7b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a7f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a86:	8b 10                	mov    (%rax),%edx
    1a88:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a8e:	89 d6                	mov    %edx,%esi
    1a90:	89 c7                	mov    %eax,%edi
    1a92:	48 b8 c1 16 00 00 00 	movabs $0x16c1,%rax
    1a99:	00 00 00 
    1a9c:	ff d0                	call   *%rax
      break;
    1a9e:	e9 58 01 00 00       	jmp    1bfb <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1aa3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1aa9:	83 f8 2f             	cmp    $0x2f,%eax
    1aac:	77 23                	ja     1ad1 <printf+0x2c3>
    1aae:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1ab5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1abb:	89 d2                	mov    %edx,%edx
    1abd:	48 01 d0             	add    %rdx,%rax
    1ac0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ac6:	83 c2 08             	add    $0x8,%edx
    1ac9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1acf:	eb 12                	jmp    1ae3 <printf+0x2d5>
    1ad1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1ad8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1adc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ae3:	48 8b 10             	mov    (%rax),%rdx
    1ae6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aec:	48 89 d6             	mov    %rdx,%rsi
    1aef:	89 c7                	mov    %eax,%edi
    1af1:	48 b8 68 16 00 00 00 	movabs $0x1668,%rax
    1af8:	00 00 00 
    1afb:	ff d0                	call   *%rax
      break;
    1afd:	e9 f9 00 00 00       	jmp    1bfb <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1b02:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b08:	83 f8 2f             	cmp    $0x2f,%eax
    1b0b:	77 23                	ja     1b30 <printf+0x322>
    1b0d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b14:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b1a:	89 d2                	mov    %edx,%edx
    1b1c:	48 01 d0             	add    %rdx,%rax
    1b1f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b25:	83 c2 08             	add    $0x8,%edx
    1b28:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b2e:	eb 12                	jmp    1b42 <printf+0x334>
    1b30:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b37:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b3b:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b42:	48 8b 00             	mov    (%rax),%rax
    1b45:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b4c:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b53:	00 
    1b54:	75 41                	jne    1b97 <printf+0x389>
        s = "(null)";
    1b56:	48 b8 7e 20 00 00 00 	movabs $0x207e,%rax
    1b5d:	00 00 00 
    1b60:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b67:	eb 2e                	jmp    1b97 <printf+0x389>
        putc(fd, *(s++));
    1b69:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b70:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b74:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b7b:	0f b6 00             	movzbl (%rax),%eax
    1b7e:	0f be d0             	movsbl %al,%edx
    1b81:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b87:	89 d6                	mov    %edx,%esi
    1b89:	89 c7                	mov    %eax,%edi
    1b8b:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    1b92:	00 00 00 
    1b95:	ff d0                	call   *%rax
      while (*s)
    1b97:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b9e:	0f b6 00             	movzbl (%rax),%eax
    1ba1:	84 c0                	test   %al,%al
    1ba3:	75 c4                	jne    1b69 <printf+0x35b>
      break;
    1ba5:	eb 54                	jmp    1bfb <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1ba7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bad:	be 25 00 00 00       	mov    $0x25,%esi
    1bb2:	89 c7                	mov    %eax,%edi
    1bb4:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    1bbb:	00 00 00 
    1bbe:	ff d0                	call   *%rax
      break;
    1bc0:	eb 39                	jmp    1bfb <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1bc2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bc8:	be 25 00 00 00       	mov    $0x25,%esi
    1bcd:	89 c7                	mov    %eax,%edi
    1bcf:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    1bd6:	00 00 00 
    1bd9:	ff d0                	call   *%rax
      putc(fd, c);
    1bdb:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1be1:	0f be d0             	movsbl %al,%edx
    1be4:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bea:	89 d6                	mov    %edx,%esi
    1bec:	89 c7                	mov    %eax,%edi
    1bee:	48 b8 38 16 00 00 00 	movabs $0x1638,%rax
    1bf5:	00 00 00 
    1bf8:	ff d0                	call   *%rax
      break;
    1bfa:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bfb:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1c02:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1c08:	48 63 d0             	movslq %eax,%rdx
    1c0b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1c12:	48 01 d0             	add    %rdx,%rax
    1c15:	0f b6 00             	movzbl (%rax),%eax
    1c18:	0f be c0             	movsbl %al,%eax
    1c1b:	25 ff 00 00 00       	and    $0xff,%eax
    1c20:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c26:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c2d:	0f 85 6f fc ff ff    	jne    18a2 <printf+0x94>
    }
  }
}
    1c33:	eb 01                	jmp    1c36 <printf+0x428>
      break;
    1c35:	90                   	nop
}
    1c36:	90                   	nop
    1c37:	c9                   	leave
    1c38:	c3                   	ret

0000000000001c39 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c39:	55                   	push   %rbp
    1c3a:	48 89 e5             	mov    %rsp,%rbp
    1c3d:	48 83 ec 18          	sub    $0x18,%rsp
    1c41:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c45:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c49:	48 83 e8 10          	sub    $0x10,%rax
    1c4d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c51:	48 b8 c0 20 00 00 00 	movabs $0x20c0,%rax
    1c58:	00 00 00 
    1c5b:	48 8b 00             	mov    (%rax),%rax
    1c5e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c62:	eb 2f                	jmp    1c93 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c64:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c68:	48 8b 00             	mov    (%rax),%rax
    1c6b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c6f:	72 17                	jb     1c88 <free+0x4f>
    1c71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c75:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c79:	72 2f                	jb     1caa <free+0x71>
    1c7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c7f:	48 8b 00             	mov    (%rax),%rax
    1c82:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c86:	72 22                	jb     1caa <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c8c:	48 8b 00             	mov    (%rax),%rax
    1c8f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c93:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c97:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c9b:	73 c7                	jae    1c64 <free+0x2b>
    1c9d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca1:	48 8b 00             	mov    (%rax),%rax
    1ca4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ca8:	73 ba                	jae    1c64 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1caa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cae:	8b 40 08             	mov    0x8(%rax),%eax
    1cb1:	89 c0                	mov    %eax,%eax
    1cb3:	48 c1 e0 04          	shl    $0x4,%rax
    1cb7:	48 89 c2             	mov    %rax,%rdx
    1cba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbe:	48 01 c2             	add    %rax,%rdx
    1cc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc5:	48 8b 00             	mov    (%rax),%rax
    1cc8:	48 39 c2             	cmp    %rax,%rdx
    1ccb:	75 2d                	jne    1cfa <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1ccd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cd1:	8b 50 08             	mov    0x8(%rax),%edx
    1cd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd8:	48 8b 00             	mov    (%rax),%rax
    1cdb:	8b 40 08             	mov    0x8(%rax),%eax
    1cde:	01 c2                	add    %eax,%edx
    1ce0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce4:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ce7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ceb:	48 8b 00             	mov    (%rax),%rax
    1cee:	48 8b 10             	mov    (%rax),%rdx
    1cf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf5:	48 89 10             	mov    %rdx,(%rax)
    1cf8:	eb 0e                	jmp    1d08 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1cfa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cfe:	48 8b 10             	mov    (%rax),%rdx
    1d01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d05:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0c:	8b 40 08             	mov    0x8(%rax),%eax
    1d0f:	89 c0                	mov    %eax,%eax
    1d11:	48 c1 e0 04          	shl    $0x4,%rax
    1d15:	48 89 c2             	mov    %rax,%rdx
    1d18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1c:	48 01 d0             	add    %rdx,%rax
    1d1f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d23:	75 27                	jne    1d4c <free+0x113>
    p->s.size += bp->s.size;
    1d25:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d29:	8b 50 08             	mov    0x8(%rax),%edx
    1d2c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d30:	8b 40 08             	mov    0x8(%rax),%eax
    1d33:	01 c2                	add    %eax,%edx
    1d35:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d39:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1d3c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d40:	48 8b 10             	mov    (%rax),%rdx
    1d43:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d47:	48 89 10             	mov    %rdx,(%rax)
    1d4a:	eb 0b                	jmp    1d57 <free+0x11e>
  } else
    p->s.ptr = bp;
    1d4c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d50:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d54:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d57:	48 ba c0 20 00 00 00 	movabs $0x20c0,%rdx
    1d5e:	00 00 00 
    1d61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d65:	48 89 02             	mov    %rax,(%rdx)
}
    1d68:	90                   	nop
    1d69:	c9                   	leave
    1d6a:	c3                   	ret

0000000000001d6b <morecore>:

static Header*
morecore(uint nu)
{
    1d6b:	55                   	push   %rbp
    1d6c:	48 89 e5             	mov    %rsp,%rbp
    1d6f:	48 83 ec 20          	sub    $0x20,%rsp
    1d73:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d76:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d7d:	77 07                	ja     1d86 <morecore+0x1b>
    nu = 4096;
    1d7f:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d86:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d89:	48 c1 e0 04          	shl    $0x4,%rax
    1d8d:	48 89 c7             	mov    %rax,%rdi
    1d90:	48 b8 04 16 00 00 00 	movabs $0x1604,%rax
    1d97:	00 00 00 
    1d9a:	ff d0                	call   *%rax
    1d9c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1da0:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1da5:	75 07                	jne    1dae <morecore+0x43>
    return 0;
    1da7:	b8 00 00 00 00       	mov    $0x0,%eax
    1dac:	eb 36                	jmp    1de4 <morecore+0x79>
  hp = (Header*)p;
    1dae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1db2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1db6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dba:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1dbd:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1dc0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dc4:	48 83 c0 10          	add    $0x10,%rax
    1dc8:	48 89 c7             	mov    %rax,%rdi
    1dcb:	48 b8 39 1c 00 00 00 	movabs $0x1c39,%rax
    1dd2:	00 00 00 
    1dd5:	ff d0                	call   *%rax
  return freep;
    1dd7:	48 b8 c0 20 00 00 00 	movabs $0x20c0,%rax
    1dde:	00 00 00 
    1de1:	48 8b 00             	mov    (%rax),%rax
}
    1de4:	c9                   	leave
    1de5:	c3                   	ret

0000000000001de6 <malloc>:

void*
malloc(uint nbytes)
{
    1de6:	55                   	push   %rbp
    1de7:	48 89 e5             	mov    %rsp,%rbp
    1dea:	48 83 ec 30          	sub    $0x30,%rsp
    1dee:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1df1:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1df4:	48 83 c0 0f          	add    $0xf,%rax
    1df8:	48 c1 e8 04          	shr    $0x4,%rax
    1dfc:	83 c0 01             	add    $0x1,%eax
    1dff:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1e02:	48 b8 c0 20 00 00 00 	movabs $0x20c0,%rax
    1e09:	00 00 00 
    1e0c:	48 8b 00             	mov    (%rax),%rax
    1e0f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e13:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e18:	75 4a                	jne    1e64 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1e1a:	48 b8 b0 20 00 00 00 	movabs $0x20b0,%rax
    1e21:	00 00 00 
    1e24:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e28:	48 ba c0 20 00 00 00 	movabs $0x20c0,%rdx
    1e2f:	00 00 00 
    1e32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e36:	48 89 02             	mov    %rax,(%rdx)
    1e39:	48 b8 c0 20 00 00 00 	movabs $0x20c0,%rax
    1e40:	00 00 00 
    1e43:	48 8b 00             	mov    (%rax),%rax
    1e46:	48 ba b0 20 00 00 00 	movabs $0x20b0,%rdx
    1e4d:	00 00 00 
    1e50:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e53:	48 b8 b0 20 00 00 00 	movabs $0x20b0,%rax
    1e5a:	00 00 00 
    1e5d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e64:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e68:	48 8b 00             	mov    (%rax),%rax
    1e6b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e6f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e73:	8b 40 08             	mov    0x8(%rax),%eax
    1e76:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e79:	72 65                	jb     1ee0 <malloc+0xfa>
      if(p->s.size == nunits)
    1e7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e7f:	8b 40 08             	mov    0x8(%rax),%eax
    1e82:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e85:	75 10                	jne    1e97 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1e87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e8b:	48 8b 10             	mov    (%rax),%rdx
    1e8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e92:	48 89 10             	mov    %rdx,(%rax)
    1e95:	eb 2e                	jmp    1ec5 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1e97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e9b:	8b 40 08             	mov    0x8(%rax),%eax
    1e9e:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1ea1:	89 c2                	mov    %eax,%edx
    1ea3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ea7:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1eaa:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eae:	8b 40 08             	mov    0x8(%rax),%eax
    1eb1:	89 c0                	mov    %eax,%eax
    1eb3:	48 c1 e0 04          	shl    $0x4,%rax
    1eb7:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1ebb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ebf:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1ec2:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1ec5:	48 ba c0 20 00 00 00 	movabs $0x20c0,%rdx
    1ecc:	00 00 00 
    1ecf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ed3:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1ed6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eda:	48 83 c0 10          	add    $0x10,%rax
    1ede:	eb 4e                	jmp    1f2e <malloc+0x148>
    }
    if(p == freep)
    1ee0:	48 b8 c0 20 00 00 00 	movabs $0x20c0,%rax
    1ee7:	00 00 00 
    1eea:	48 8b 00             	mov    (%rax),%rax
    1eed:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ef1:	75 23                	jne    1f16 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1ef3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1ef6:	89 c7                	mov    %eax,%edi
    1ef8:	48 b8 6b 1d 00 00 00 	movabs $0x1d6b,%rax
    1eff:	00 00 00 
    1f02:	ff d0                	call   *%rax
    1f04:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f08:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f0d:	75 07                	jne    1f16 <malloc+0x130>
        return 0;
    1f0f:	b8 00 00 00 00       	mov    $0x0,%eax
    1f14:	eb 18                	jmp    1f2e <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f16:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f1a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f22:	48 8b 00             	mov    (%rax),%rax
    1f25:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f29:	e9 41 ff ff ff       	jmp    1e6f <malloc+0x89>
  }
}
    1f2e:	c9                   	leave
    1f2f:	c3                   	ret
