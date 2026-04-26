
_eager:     file format elf64-x86-64


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
    100f:	48 b8 78 1f 00 00 00 	movabs $0x1f78,%rax
    1016:	00 00 00 
    1019:	48 89 c6             	mov    %rax,%rsi
    101c:	bf 01 00 00 00       	mov    $0x1,%edi
    1021:	b8 00 00 00 00       	mov    $0x0,%eax
    1026:	48 ba 4f 18 00 00 00 	movabs $0x184f,%rdx
    102d:	00 00 00 
    1030:	ff d2                	call   *%rdx
  int fd = open("README",0);
    1032:	48 b8 c7 1f 00 00 00 	movabs $0x1fc7,%rax
    1039:	00 00 00 
    103c:	be 00 00 00 00       	mov    $0x0,%esi
    1041:	48 89 c7             	mov    %rax,%rdi
    1044:	48 b8 d0 15 00 00 00 	movabs $0x15d0,%rax
    104b:	00 00 00 
    104e:	ff d0                	call   *%rax
    1050:	89 45 fc             	mov    %eax,-0x4(%rbp)
  char* text = mmap(fd,0);
    1053:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1056:	be 00 00 00 00       	mov    $0x0,%esi
    105b:	89 c7                	mov    %eax,%edi
    105d:	48 b8 6c 16 00 00 00 	movabs $0x166c,%rax
    1064:	00 00 00 
    1067:	ff d0                	call   *%rax
    1069:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  text[85]=0;
    106d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1071:	48 83 c0 55          	add    $0x55,%rax
    1075:	c6 00 00             	movb   $0x0,(%rax)
  if(text!=(void*)0x0000400000000000)
    1078:	48 b8 00 00 00 00 00 	movabs $0x400000000000,%rax
    107f:	40 00 00 
    1082:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1086:	74 2a                	je     10b2 <main+0xb2>
    printf(1,"Returned pointer is %p, should be 0x0000400000000000\n",text);
    1088:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    108c:	48 b9 d0 1f 00 00 00 	movabs $0x1fd0,%rcx
    1093:	00 00 00 
    1096:	48 89 c2             	mov    %rax,%rdx
    1099:	48 89 ce             	mov    %rcx,%rsi
    109c:	bf 01 00 00 00       	mov    $0x1,%edi
    10a1:	b8 00 00 00 00       	mov    $0x0,%eax
    10a6:	48 b9 4f 18 00 00 00 	movabs $0x184f,%rcx
    10ad:	00 00 00 
    10b0:	ff d1                	call   *%rcx
  printf(1,"%s\n",text);
    10b2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10b6:	48 b9 06 20 00 00 00 	movabs $0x2006,%rcx
    10bd:	00 00 00 
    10c0:	48 89 c2             	mov    %rax,%rdx
    10c3:	48 89 ce             	mov    %rcx,%rsi
    10c6:	bf 01 00 00 00       	mov    $0x1,%edi
    10cb:	b8 00 00 00 00       	mov    $0x0,%eax
    10d0:	48 b9 4f 18 00 00 00 	movabs $0x184f,%rcx
    10d7:	00 00 00 
    10da:	ff d1                	call   *%rcx

  printf(1,"\nSecond mmap coming\n");
    10dc:	48 b8 0a 20 00 00 00 	movabs $0x200a,%rax
    10e3:	00 00 00 
    10e6:	48 89 c6             	mov    %rax,%rsi
    10e9:	bf 01 00 00 00       	mov    $0x1,%edi
    10ee:	b8 00 00 00 00       	mov    $0x0,%eax
    10f3:	48 ba 4f 18 00 00 00 	movabs $0x184f,%rdx
    10fa:	00 00 00 
    10fd:	ff d2                	call   *%rdx
  int fd2 = open("LARGE",0);
    10ff:	48 b8 1f 20 00 00 00 	movabs $0x201f,%rax
    1106:	00 00 00 
    1109:	be 00 00 00 00       	mov    $0x0,%esi
    110e:	48 89 c7             	mov    %rax,%rdi
    1111:	48 b8 d0 15 00 00 00 	movabs $0x15d0,%rax
    1118:	00 00 00 
    111b:	ff d0                	call   *%rax
    111d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  char* text2 = mmap(fd2,0);
    1120:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1123:	be 00 00 00 00       	mov    $0x0,%esi
    1128:	89 c7                	mov    %eax,%edi
    112a:	48 b8 6c 16 00 00 00 	movabs $0x166c,%rax
    1131:	00 00 00 
    1134:	ff d0                	call   *%rax
    1136:	48 89 45 e0          	mov    %rax,-0x20(%rbp)

  text2[71680]=0;
    113a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    113e:	48 05 00 18 01 00    	add    $0x11800,%rax
    1144:	c6 00 00             	movb   $0x0,(%rax)
  if(text2!=(void*)0x0000400000001000)
    1147:	48 b8 00 10 00 00 00 	movabs $0x400000001000,%rax
    114e:	40 00 00 
    1151:	48 39 45 e0          	cmp    %rax,-0x20(%rbp)
    1155:	74 2a                	je     1181 <main+0x181>
    printf(1,"Returned pointer is %p, should be 0x0000400000001000\n",text2);
    1157:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    115b:	48 b9 28 20 00 00 00 	movabs $0x2028,%rcx
    1162:	00 00 00 
    1165:	48 89 c2             	mov    %rax,%rdx
    1168:	48 89 ce             	mov    %rcx,%rsi
    116b:	bf 01 00 00 00       	mov    $0x1,%edi
    1170:	b8 00 00 00 00       	mov    $0x0,%eax
    1175:	48 b9 4f 18 00 00 00 	movabs $0x184f,%rcx
    117c:	00 00 00 
    117f:	ff d1                	call   *%rcx
  printf(1,"%s\n",text2+71661);
    1181:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1185:	48 8d 90 ed 17 01 00 	lea    0x117ed(%rax),%rdx
    118c:	48 b8 06 20 00 00 00 	movabs $0x2006,%rax
    1193:	00 00 00 
    1196:	48 89 c6             	mov    %rax,%rsi
    1199:	bf 01 00 00 00       	mov    $0x1,%edi
    119e:	b8 00 00 00 00       	mov    $0x0,%eax
    11a3:	48 b9 4f 18 00 00 00 	movabs $0x184f,%rcx
    11aa:	00 00 00 
    11ad:	ff d1                	call   *%rcx

  printf(1,"Checking that first mmap is still ok, you should see the first sentence from README\n");
    11af:	48 b8 60 20 00 00 00 	movabs $0x2060,%rax
    11b6:	00 00 00 
    11b9:	48 89 c6             	mov    %rax,%rsi
    11bc:	bf 01 00 00 00       	mov    $0x1,%edi
    11c1:	b8 00 00 00 00       	mov    $0x0,%eax
    11c6:	48 ba 4f 18 00 00 00 	movabs $0x184f,%rdx
    11cd:	00 00 00 
    11d0:	ff d2                	call   *%rdx
  text[85]=0;
    11d2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    11d6:	48 83 c0 55          	add    $0x55,%rax
    11da:	c6 00 00             	movb   $0x0,(%rax)
  if(text!=(void*)0x0000400000000000)
    11dd:	48 b8 00 00 00 00 00 	movabs $0x400000000000,%rax
    11e4:	40 00 00 
    11e7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    11eb:	74 2a                	je     1217 <main+0x217>
    printf(1,"Returned pointer is %p, should be 0x0000400000000000\n",text);
    11ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    11f1:	48 b9 d0 1f 00 00 00 	movabs $0x1fd0,%rcx
    11f8:	00 00 00 
    11fb:	48 89 c2             	mov    %rax,%rdx
    11fe:	48 89 ce             	mov    %rcx,%rsi
    1201:	bf 01 00 00 00       	mov    $0x1,%edi
    1206:	b8 00 00 00 00       	mov    $0x0,%eax
    120b:	48 b9 4f 18 00 00 00 	movabs $0x184f,%rcx
    1212:	00 00 00 
    1215:	ff d1                	call   *%rcx
  printf(1,"%s\n",text);
    1217:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    121b:	48 b9 06 20 00 00 00 	movabs $0x2006,%rcx
    1222:	00 00 00 
    1225:	48 89 c2             	mov    %rax,%rdx
    1228:	48 89 ce             	mov    %rcx,%rsi
    122b:	bf 01 00 00 00       	mov    $0x1,%edi
    1230:	b8 00 00 00 00       	mov    $0x0,%eax
    1235:	48 b9 4f 18 00 00 00 	movabs $0x184f,%rcx
    123c:	00 00 00 
    123f:	ff d1                	call   *%rcx

  exit();
    1241:	48 b8 68 15 00 00 00 	movabs $0x1568,%rax
    1248:	00 00 00 
    124b:	ff d0                	call   *%rax

000000000000124d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    124d:	55                   	push   %rbp
    124e:	48 89 e5             	mov    %rsp,%rbp
    1251:	48 83 ec 10          	sub    $0x10,%rsp
    1255:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1259:	89 75 f4             	mov    %esi,-0xc(%rbp)
    125c:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    125f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1263:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1266:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1269:	48 89 ce             	mov    %rcx,%rsi
    126c:	48 89 f7             	mov    %rsi,%rdi
    126f:	89 d1                	mov    %edx,%ecx
    1271:	fc                   	cld
    1272:	f3 aa                	rep stos %al,(%rdi)
    1274:	89 ca                	mov    %ecx,%edx
    1276:	48 89 fe             	mov    %rdi,%rsi
    1279:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    127d:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1280:	90                   	nop
    1281:	c9                   	leave
    1282:	c3                   	ret

0000000000001283 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1283:	55                   	push   %rbp
    1284:	48 89 e5             	mov    %rsp,%rbp
    1287:	48 83 ec 20          	sub    $0x20,%rsp
    128b:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    128f:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    1293:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1297:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    129b:	90                   	nop
    129c:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12a0:	48 8d 42 01          	lea    0x1(%rdx),%rax
    12a4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    12a8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12ac:	48 8d 48 01          	lea    0x1(%rax),%rcx
    12b0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    12b4:	0f b6 12             	movzbl (%rdx),%edx
    12b7:	88 10                	mov    %dl,(%rax)
    12b9:	0f b6 00             	movzbl (%rax),%eax
    12bc:	84 c0                	test   %al,%al
    12be:	75 dc                	jne    129c <strcpy+0x19>
    ;
  return os;
    12c0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12c4:	c9                   	leave
    12c5:	c3                   	ret

00000000000012c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    12c6:	55                   	push   %rbp
    12c7:	48 89 e5             	mov    %rsp,%rbp
    12ca:	48 83 ec 10          	sub    $0x10,%rsp
    12ce:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12d2:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    12d6:	eb 0a                	jmp    12e2 <strcmp+0x1c>
    p++, q++;
    12d8:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    12dd:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    12e2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12e6:	0f b6 00             	movzbl (%rax),%eax
    12e9:	84 c0                	test   %al,%al
    12eb:	74 12                	je     12ff <strcmp+0x39>
    12ed:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12f1:	0f b6 10             	movzbl (%rax),%edx
    12f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12f8:	0f b6 00             	movzbl (%rax),%eax
    12fb:	38 c2                	cmp    %al,%dl
    12fd:	74 d9                	je     12d8 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    12ff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1303:	0f b6 00             	movzbl (%rax),%eax
    1306:	0f b6 d0             	movzbl %al,%edx
    1309:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    130d:	0f b6 00             	movzbl (%rax),%eax
    1310:	0f b6 c0             	movzbl %al,%eax
    1313:	29 c2                	sub    %eax,%edx
    1315:	89 d0                	mov    %edx,%eax
}
    1317:	c9                   	leave
    1318:	c3                   	ret

0000000000001319 <strlen>:

uint
strlen(char *s)
{
    1319:	55                   	push   %rbp
    131a:	48 89 e5             	mov    %rsp,%rbp
    131d:	48 83 ec 18          	sub    $0x18,%rsp
    1321:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    132c:	eb 04                	jmp    1332 <strlen+0x19>
    132e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1332:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1335:	48 63 d0             	movslq %eax,%rdx
    1338:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    133c:	48 01 d0             	add    %rdx,%rax
    133f:	0f b6 00             	movzbl (%rax),%eax
    1342:	84 c0                	test   %al,%al
    1344:	75 e8                	jne    132e <strlen+0x15>
    ;
  return n;
    1346:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1349:	c9                   	leave
    134a:	c3                   	ret

000000000000134b <memset>:

void*
memset(void *dst, int c, uint n)
{
    134b:	55                   	push   %rbp
    134c:	48 89 e5             	mov    %rsp,%rbp
    134f:	48 83 ec 10          	sub    $0x10,%rsp
    1353:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1357:	89 75 f4             	mov    %esi,-0xc(%rbp)
    135a:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    135d:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1360:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1363:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1367:	89 ce                	mov    %ecx,%esi
    1369:	48 89 c7             	mov    %rax,%rdi
    136c:	48 b8 4d 12 00 00 00 	movabs $0x124d,%rax
    1373:	00 00 00 
    1376:	ff d0                	call   *%rax
  return dst;
    1378:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    137c:	c9                   	leave
    137d:	c3                   	ret

000000000000137e <strchr>:

char*
strchr(const char *s, char c)
{
    137e:	55                   	push   %rbp
    137f:	48 89 e5             	mov    %rsp,%rbp
    1382:	48 83 ec 10          	sub    $0x10,%rsp
    1386:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    138a:	89 f0                	mov    %esi,%eax
    138c:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    138f:	eb 17                	jmp    13a8 <strchr+0x2a>
    if(*s == c)
    1391:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1395:	0f b6 00             	movzbl (%rax),%eax
    1398:	38 45 f4             	cmp    %al,-0xc(%rbp)
    139b:	75 06                	jne    13a3 <strchr+0x25>
      return (char*)s;
    139d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13a1:	eb 15                	jmp    13b8 <strchr+0x3a>
  for(; *s; s++)
    13a3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    13a8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13ac:	0f b6 00             	movzbl (%rax),%eax
    13af:	84 c0                	test   %al,%al
    13b1:	75 de                	jne    1391 <strchr+0x13>
  return 0;
    13b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    13b8:	c9                   	leave
    13b9:	c3                   	ret

00000000000013ba <gets>:

char*
gets(char *buf, int max)
{
    13ba:	55                   	push   %rbp
    13bb:	48 89 e5             	mov    %rsp,%rbp
    13be:	48 83 ec 20          	sub    $0x20,%rsp
    13c2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13c6:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    13c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    13d0:	eb 4f                	jmp    1421 <gets+0x67>
    cc = read(0, &c, 1);
    13d2:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    13d6:	ba 01 00 00 00       	mov    $0x1,%edx
    13db:	48 89 c6             	mov    %rax,%rsi
    13de:	bf 00 00 00 00       	mov    $0x0,%edi
    13e3:	48 b8 8f 15 00 00 00 	movabs $0x158f,%rax
    13ea:	00 00 00 
    13ed:	ff d0                	call   *%rax
    13ef:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    13f2:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    13f6:	7e 36                	jle    142e <gets+0x74>
      break;
    buf[i++] = c;
    13f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13fb:	8d 50 01             	lea    0x1(%rax),%edx
    13fe:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1401:	48 63 d0             	movslq %eax,%rdx
    1404:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1408:	48 01 c2             	add    %rax,%rdx
    140b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    140f:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1411:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1415:	3c 0a                	cmp    $0xa,%al
    1417:	74 16                	je     142f <gets+0x75>
    1419:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    141d:	3c 0d                	cmp    $0xd,%al
    141f:	74 0e                	je     142f <gets+0x75>
  for(i=0; i+1 < max; ){
    1421:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1424:	83 c0 01             	add    $0x1,%eax
    1427:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    142a:	7f a6                	jg     13d2 <gets+0x18>
    142c:	eb 01                	jmp    142f <gets+0x75>
      break;
    142e:	90                   	nop
      break;
  }
  buf[i] = '\0';
    142f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1432:	48 63 d0             	movslq %eax,%rdx
    1435:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1439:	48 01 d0             	add    %rdx,%rax
    143c:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    143f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1443:	c9                   	leave
    1444:	c3                   	ret

0000000000001445 <stat>:

int
stat(char *n, struct stat *st)
{
    1445:	55                   	push   %rbp
    1446:	48 89 e5             	mov    %rsp,%rbp
    1449:	48 83 ec 20          	sub    $0x20,%rsp
    144d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1451:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1455:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1459:	be 00 00 00 00       	mov    $0x0,%esi
    145e:	48 89 c7             	mov    %rax,%rdi
    1461:	48 b8 d0 15 00 00 00 	movabs $0x15d0,%rax
    1468:	00 00 00 
    146b:	ff d0                	call   *%rax
    146d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1470:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1474:	79 07                	jns    147d <stat+0x38>
    return -1;
    1476:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    147b:	eb 2f                	jmp    14ac <stat+0x67>
  r = fstat(fd, st);
    147d:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1481:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1484:	48 89 d6             	mov    %rdx,%rsi
    1487:	89 c7                	mov    %eax,%edi
    1489:	48 b8 f7 15 00 00 00 	movabs $0x15f7,%rax
    1490:	00 00 00 
    1493:	ff d0                	call   *%rax
    1495:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    1498:	8b 45 fc             	mov    -0x4(%rbp),%eax
    149b:	89 c7                	mov    %eax,%edi
    149d:	48 b8 a9 15 00 00 00 	movabs $0x15a9,%rax
    14a4:	00 00 00 
    14a7:	ff d0                	call   *%rax
  return r;
    14a9:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    14ac:	c9                   	leave
    14ad:	c3                   	ret

00000000000014ae <atoi>:

int
atoi(const char *s)
{
    14ae:	55                   	push   %rbp
    14af:	48 89 e5             	mov    %rsp,%rbp
    14b2:	48 83 ec 18          	sub    $0x18,%rsp
    14b6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    14ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14c1:	eb 28                	jmp    14eb <atoi+0x3d>
    n = n*10 + *s++ - '0';
    14c3:	8b 55 fc             	mov    -0x4(%rbp),%edx
    14c6:	89 d0                	mov    %edx,%eax
    14c8:	c1 e0 02             	shl    $0x2,%eax
    14cb:	01 d0                	add    %edx,%eax
    14cd:	01 c0                	add    %eax,%eax
    14cf:	89 c1                	mov    %eax,%ecx
    14d1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14d5:	48 8d 50 01          	lea    0x1(%rax),%rdx
    14d9:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    14dd:	0f b6 00             	movzbl (%rax),%eax
    14e0:	0f be c0             	movsbl %al,%eax
    14e3:	01 c8                	add    %ecx,%eax
    14e5:	83 e8 30             	sub    $0x30,%eax
    14e8:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    14eb:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14ef:	0f b6 00             	movzbl (%rax),%eax
    14f2:	3c 2f                	cmp    $0x2f,%al
    14f4:	7e 0b                	jle    1501 <atoi+0x53>
    14f6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14fa:	0f b6 00             	movzbl (%rax),%eax
    14fd:	3c 39                	cmp    $0x39,%al
    14ff:	7e c2                	jle    14c3 <atoi+0x15>
  return n;
    1501:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1504:	c9                   	leave
    1505:	c3                   	ret

0000000000001506 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1506:	55                   	push   %rbp
    1507:	48 89 e5             	mov    %rsp,%rbp
    150a:	48 83 ec 28          	sub    $0x28,%rsp
    150e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1512:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1516:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1519:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    151d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1521:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1525:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1529:	eb 1d                	jmp    1548 <memmove+0x42>
    *dst++ = *src++;
    152b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    152f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1533:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1537:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    153b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    153f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1543:	0f b6 12             	movzbl (%rdx),%edx
    1546:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1548:	8b 45 dc             	mov    -0x24(%rbp),%eax
    154b:	8d 50 ff             	lea    -0x1(%rax),%edx
    154e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1551:	85 c0                	test   %eax,%eax
    1553:	7f d6                	jg     152b <memmove+0x25>
  return vdst;
    1555:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1559:	c9                   	leave
    155a:	c3                   	ret

000000000000155b <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    155b:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1562:	49 89 ca             	mov    %rcx,%r10
    1565:	0f 05                	syscall
    1567:	c3                   	ret

0000000000001568 <exit>:
SYSCALL(exit)
    1568:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    156f:	49 89 ca             	mov    %rcx,%r10
    1572:	0f 05                	syscall
    1574:	c3                   	ret

0000000000001575 <wait>:
SYSCALL(wait)
    1575:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    157c:	49 89 ca             	mov    %rcx,%r10
    157f:	0f 05                	syscall
    1581:	c3                   	ret

0000000000001582 <pipe>:
SYSCALL(pipe)
    1582:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1589:	49 89 ca             	mov    %rcx,%r10
    158c:	0f 05                	syscall
    158e:	c3                   	ret

000000000000158f <read>:
SYSCALL(read)
    158f:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    1596:	49 89 ca             	mov    %rcx,%r10
    1599:	0f 05                	syscall
    159b:	c3                   	ret

000000000000159c <write>:
SYSCALL(write)
    159c:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    15a3:	49 89 ca             	mov    %rcx,%r10
    15a6:	0f 05                	syscall
    15a8:	c3                   	ret

00000000000015a9 <close>:
SYSCALL(close)
    15a9:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    15b0:	49 89 ca             	mov    %rcx,%r10
    15b3:	0f 05                	syscall
    15b5:	c3                   	ret

00000000000015b6 <kill>:
SYSCALL(kill)
    15b6:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    15bd:	49 89 ca             	mov    %rcx,%r10
    15c0:	0f 05                	syscall
    15c2:	c3                   	ret

00000000000015c3 <exec>:
SYSCALL(exec)
    15c3:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    15ca:	49 89 ca             	mov    %rcx,%r10
    15cd:	0f 05                	syscall
    15cf:	c3                   	ret

00000000000015d0 <open>:
SYSCALL(open)
    15d0:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    15d7:	49 89 ca             	mov    %rcx,%r10
    15da:	0f 05                	syscall
    15dc:	c3                   	ret

00000000000015dd <mknod>:
SYSCALL(mknod)
    15dd:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    15e4:	49 89 ca             	mov    %rcx,%r10
    15e7:	0f 05                	syscall
    15e9:	c3                   	ret

00000000000015ea <unlink>:
SYSCALL(unlink)
    15ea:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    15f1:	49 89 ca             	mov    %rcx,%r10
    15f4:	0f 05                	syscall
    15f6:	c3                   	ret

00000000000015f7 <fstat>:
SYSCALL(fstat)
    15f7:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    15fe:	49 89 ca             	mov    %rcx,%r10
    1601:	0f 05                	syscall
    1603:	c3                   	ret

0000000000001604 <link>:
SYSCALL(link)
    1604:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    160b:	49 89 ca             	mov    %rcx,%r10
    160e:	0f 05                	syscall
    1610:	c3                   	ret

0000000000001611 <mkdir>:
SYSCALL(mkdir)
    1611:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1618:	49 89 ca             	mov    %rcx,%r10
    161b:	0f 05                	syscall
    161d:	c3                   	ret

000000000000161e <chdir>:
SYSCALL(chdir)
    161e:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1625:	49 89 ca             	mov    %rcx,%r10
    1628:	0f 05                	syscall
    162a:	c3                   	ret

000000000000162b <dup>:
SYSCALL(dup)
    162b:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1632:	49 89 ca             	mov    %rcx,%r10
    1635:	0f 05                	syscall
    1637:	c3                   	ret

0000000000001638 <getpid>:
SYSCALL(getpid)
    1638:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    163f:	49 89 ca             	mov    %rcx,%r10
    1642:	0f 05                	syscall
    1644:	c3                   	ret

0000000000001645 <sbrk>:
SYSCALL(sbrk)
    1645:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    164c:	49 89 ca             	mov    %rcx,%r10
    164f:	0f 05                	syscall
    1651:	c3                   	ret

0000000000001652 <sleep>:
SYSCALL(sleep)
    1652:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1659:	49 89 ca             	mov    %rcx,%r10
    165c:	0f 05                	syscall
    165e:	c3                   	ret

000000000000165f <uptime>:
SYSCALL(uptime)
    165f:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1666:	49 89 ca             	mov    %rcx,%r10
    1669:	0f 05                	syscall
    166b:	c3                   	ret

000000000000166c <mmap>:
SYSCALL(mmap)
    166c:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1673:	49 89 ca             	mov    %rcx,%r10
    1676:	0f 05                	syscall
    1678:	c3                   	ret

0000000000001679 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    1679:	55                   	push   %rbp
    167a:	48 89 e5             	mov    %rsp,%rbp
    167d:	48 83 ec 10          	sub    $0x10,%rsp
    1681:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1684:	89 f0                	mov    %esi,%eax
    1686:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1689:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    168d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1690:	ba 01 00 00 00       	mov    $0x1,%edx
    1695:	48 89 ce             	mov    %rcx,%rsi
    1698:	89 c7                	mov    %eax,%edi
    169a:	48 b8 9c 15 00 00 00 	movabs $0x159c,%rax
    16a1:	00 00 00 
    16a4:	ff d0                	call   *%rax
}
    16a6:	90                   	nop
    16a7:	c9                   	leave
    16a8:	c3                   	ret

00000000000016a9 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    16a9:	55                   	push   %rbp
    16aa:	48 89 e5             	mov    %rsp,%rbp
    16ad:	48 83 ec 20          	sub    $0x20,%rsp
    16b1:	89 7d ec             	mov    %edi,-0x14(%rbp)
    16b4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    16bf:	eb 35                	jmp    16f6 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    16c1:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    16c5:	48 c1 e8 3c          	shr    $0x3c,%rax
    16c9:	48 ba c0 20 00 00 00 	movabs $0x20c0,%rdx
    16d0:	00 00 00 
    16d3:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    16d7:	0f be d0             	movsbl %al,%edx
    16da:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16dd:	89 d6                	mov    %edx,%esi
    16df:	89 c7                	mov    %eax,%edi
    16e1:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    16e8:	00 00 00 
    16eb:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    16ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16f1:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    16f6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16f9:	83 f8 0f             	cmp    $0xf,%eax
    16fc:	76 c3                	jbe    16c1 <print_x64+0x18>
}
    16fe:	90                   	nop
    16ff:	90                   	nop
    1700:	c9                   	leave
    1701:	c3                   	ret

0000000000001702 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1702:	55                   	push   %rbp
    1703:	48 89 e5             	mov    %rsp,%rbp
    1706:	48 83 ec 20          	sub    $0x20,%rsp
    170a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    170d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1710:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1717:	eb 36                	jmp    174f <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1719:	8b 45 e8             	mov    -0x18(%rbp),%eax
    171c:	c1 e8 1c             	shr    $0x1c,%eax
    171f:	89 c2                	mov    %eax,%edx
    1721:	48 b8 c0 20 00 00 00 	movabs $0x20c0,%rax
    1728:	00 00 00 
    172b:	89 d2                	mov    %edx,%edx
    172d:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1731:	0f be d0             	movsbl %al,%edx
    1734:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1737:	89 d6                	mov    %edx,%esi
    1739:	89 c7                	mov    %eax,%edi
    173b:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1742:	00 00 00 
    1745:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1747:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    174b:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    174f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1752:	83 f8 07             	cmp    $0x7,%eax
    1755:	76 c2                	jbe    1719 <print_x32+0x17>
}
    1757:	90                   	nop
    1758:	90                   	nop
    1759:	c9                   	leave
    175a:	c3                   	ret

000000000000175b <print_d>:

  static void
print_d(int fd, int v)
{
    175b:	55                   	push   %rbp
    175c:	48 89 e5             	mov    %rsp,%rbp
    175f:	48 83 ec 30          	sub    $0x30,%rsp
    1763:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1766:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1769:	8b 45 d8             	mov    -0x28(%rbp),%eax
    176c:	48 98                	cltq
    176e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1772:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1776:	79 04                	jns    177c <print_d+0x21>
    x = -x;
    1778:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    177c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    1783:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1787:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    178e:	66 66 66 
    1791:	48 89 c8             	mov    %rcx,%rax
    1794:	48 f7 ea             	imul   %rdx
    1797:	48 c1 fa 02          	sar    $0x2,%rdx
    179b:	48 89 c8             	mov    %rcx,%rax
    179e:	48 c1 f8 3f          	sar    $0x3f,%rax
    17a2:	48 29 c2             	sub    %rax,%rdx
    17a5:	48 89 d0             	mov    %rdx,%rax
    17a8:	48 c1 e0 02          	shl    $0x2,%rax
    17ac:	48 01 d0             	add    %rdx,%rax
    17af:	48 01 c0             	add    %rax,%rax
    17b2:	48 29 c1             	sub    %rax,%rcx
    17b5:	48 89 ca             	mov    %rcx,%rdx
    17b8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17bb:	8d 48 01             	lea    0x1(%rax),%ecx
    17be:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    17c1:	48 b9 c0 20 00 00 00 	movabs $0x20c0,%rcx
    17c8:	00 00 00 
    17cb:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    17cf:	48 98                	cltq
    17d1:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    17d5:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    17d9:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    17e0:	66 66 66 
    17e3:	48 89 c8             	mov    %rcx,%rax
    17e6:	48 f7 ea             	imul   %rdx
    17e9:	48 89 d0             	mov    %rdx,%rax
    17ec:	48 c1 f8 02          	sar    $0x2,%rax
    17f0:	48 c1 f9 3f          	sar    $0x3f,%rcx
    17f4:	48 89 ca             	mov    %rcx,%rdx
    17f7:	48 29 d0             	sub    %rdx,%rax
    17fa:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    17fe:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1803:	0f 85 7a ff ff ff    	jne    1783 <print_d+0x28>

  if (v < 0)
    1809:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    180d:	79 32                	jns    1841 <print_d+0xe6>
    buf[i++] = '-';
    180f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1812:	8d 50 01             	lea    0x1(%rax),%edx
    1815:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1818:	48 98                	cltq
    181a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    181f:	eb 20                	jmp    1841 <print_d+0xe6>
    putc(fd, buf[i]);
    1821:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1824:	48 98                	cltq
    1826:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    182b:	0f be d0             	movsbl %al,%edx
    182e:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1831:	89 d6                	mov    %edx,%esi
    1833:	89 c7                	mov    %eax,%edi
    1835:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    183c:	00 00 00 
    183f:	ff d0                	call   *%rax
  while (--i >= 0)
    1841:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1845:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1849:	79 d6                	jns    1821 <print_d+0xc6>
}
    184b:	90                   	nop
    184c:	90                   	nop
    184d:	c9                   	leave
    184e:	c3                   	ret

000000000000184f <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    184f:	55                   	push   %rbp
    1850:	48 89 e5             	mov    %rsp,%rbp
    1853:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    185a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1860:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1867:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    186e:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1875:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    187c:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1883:	84 c0                	test   %al,%al
    1885:	74 20                	je     18a7 <printf+0x58>
    1887:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    188b:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    188f:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1893:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1897:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    189b:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    189f:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    18a3:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    18a7:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    18ae:	00 00 00 
    18b1:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    18b8:	00 00 00 
    18bb:	48 8d 45 10          	lea    0x10(%rbp),%rax
    18bf:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    18c6:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    18cd:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    18d4:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    18db:	00 00 00 
    18de:	e9 60 03 00 00       	jmp    1c43 <printf+0x3f4>
    if (c != '%') {
    18e3:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18ea:	74 24                	je     1910 <printf+0xc1>
      putc(fd, c);
    18ec:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    18f2:	0f be d0             	movsbl %al,%edx
    18f5:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18fb:	89 d6                	mov    %edx,%esi
    18fd:	89 c7                	mov    %eax,%edi
    18ff:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1906:	00 00 00 
    1909:	ff d0                	call   *%rax
      continue;
    190b:	e9 2c 03 00 00       	jmp    1c3c <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1910:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1917:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    191d:	48 63 d0             	movslq %eax,%rdx
    1920:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1927:	48 01 d0             	add    %rdx,%rax
    192a:	0f b6 00             	movzbl (%rax),%eax
    192d:	0f be c0             	movsbl %al,%eax
    1930:	25 ff 00 00 00       	and    $0xff,%eax
    1935:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    193b:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1942:	0f 84 2e 03 00 00    	je     1c76 <printf+0x427>
      break;
    switch(c) {
    1948:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    194f:	0f 84 32 01 00 00    	je     1a87 <printf+0x238>
    1955:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    195c:	0f 8f a1 02 00 00    	jg     1c03 <printf+0x3b4>
    1962:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1969:	0f 84 d4 01 00 00    	je     1b43 <printf+0x2f4>
    196f:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1976:	0f 8f 87 02 00 00    	jg     1c03 <printf+0x3b4>
    197c:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1983:	0f 84 5b 01 00 00    	je     1ae4 <printf+0x295>
    1989:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1990:	0f 8f 6d 02 00 00    	jg     1c03 <printf+0x3b4>
    1996:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    199d:	0f 84 87 00 00 00    	je     1a2a <printf+0x1db>
    19a3:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    19aa:	0f 8f 53 02 00 00    	jg     1c03 <printf+0x3b4>
    19b0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    19b7:	0f 84 2b 02 00 00    	je     1be8 <printf+0x399>
    19bd:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    19c4:	0f 85 39 02 00 00    	jne    1c03 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    19ca:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19d0:	83 f8 2f             	cmp    $0x2f,%eax
    19d3:	77 23                	ja     19f8 <printf+0x1a9>
    19d5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19dc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19e2:	89 d2                	mov    %edx,%edx
    19e4:	48 01 d0             	add    %rdx,%rax
    19e7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ed:	83 c2 08             	add    $0x8,%edx
    19f0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19f6:	eb 12                	jmp    1a0a <printf+0x1bb>
    19f8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19ff:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a03:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a0a:	8b 00                	mov    (%rax),%eax
    1a0c:	0f be d0             	movsbl %al,%edx
    1a0f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a15:	89 d6                	mov    %edx,%esi
    1a17:	89 c7                	mov    %eax,%edi
    1a19:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1a20:	00 00 00 
    1a23:	ff d0                	call   *%rax
      break;
    1a25:	e9 12 02 00 00       	jmp    1c3c <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1a2a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a30:	83 f8 2f             	cmp    $0x2f,%eax
    1a33:	77 23                	ja     1a58 <printf+0x209>
    1a35:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a3c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a42:	89 d2                	mov    %edx,%edx
    1a44:	48 01 d0             	add    %rdx,%rax
    1a47:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a4d:	83 c2 08             	add    $0x8,%edx
    1a50:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a56:	eb 12                	jmp    1a6a <printf+0x21b>
    1a58:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a5f:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a63:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a6a:	8b 10                	mov    (%rax),%edx
    1a6c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a72:	89 d6                	mov    %edx,%esi
    1a74:	89 c7                	mov    %eax,%edi
    1a76:	48 b8 5b 17 00 00 00 	movabs $0x175b,%rax
    1a7d:	00 00 00 
    1a80:	ff d0                	call   *%rax
      break;
    1a82:	e9 b5 01 00 00       	jmp    1c3c <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1a87:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a8d:	83 f8 2f             	cmp    $0x2f,%eax
    1a90:	77 23                	ja     1ab5 <printf+0x266>
    1a92:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a99:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a9f:	89 d2                	mov    %edx,%edx
    1aa1:	48 01 d0             	add    %rdx,%rax
    1aa4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1aaa:	83 c2 08             	add    $0x8,%edx
    1aad:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ab3:	eb 12                	jmp    1ac7 <printf+0x278>
    1ab5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1abc:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ac0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ac7:	8b 10                	mov    (%rax),%edx
    1ac9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1acf:	89 d6                	mov    %edx,%esi
    1ad1:	89 c7                	mov    %eax,%edi
    1ad3:	48 b8 02 17 00 00 00 	movabs $0x1702,%rax
    1ada:	00 00 00 
    1add:	ff d0                	call   *%rax
      break;
    1adf:	e9 58 01 00 00       	jmp    1c3c <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1ae4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1aea:	83 f8 2f             	cmp    $0x2f,%eax
    1aed:	77 23                	ja     1b12 <printf+0x2c3>
    1aef:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1af6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1afc:	89 d2                	mov    %edx,%edx
    1afe:	48 01 d0             	add    %rdx,%rax
    1b01:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b07:	83 c2 08             	add    $0x8,%edx
    1b0a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b10:	eb 12                	jmp    1b24 <printf+0x2d5>
    1b12:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b19:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b1d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b24:	48 8b 10             	mov    (%rax),%rdx
    1b27:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b2d:	48 89 d6             	mov    %rdx,%rsi
    1b30:	89 c7                	mov    %eax,%edi
    1b32:	48 b8 a9 16 00 00 00 	movabs $0x16a9,%rax
    1b39:	00 00 00 
    1b3c:	ff d0                	call   *%rax
      break;
    1b3e:	e9 f9 00 00 00       	jmp    1c3c <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1b43:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1b49:	83 f8 2f             	cmp    $0x2f,%eax
    1b4c:	77 23                	ja     1b71 <printf+0x322>
    1b4e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1b55:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b5b:	89 d2                	mov    %edx,%edx
    1b5d:	48 01 d0             	add    %rdx,%rax
    1b60:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1b66:	83 c2 08             	add    $0x8,%edx
    1b69:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1b6f:	eb 12                	jmp    1b83 <printf+0x334>
    1b71:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1b78:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1b7c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1b83:	48 8b 00             	mov    (%rax),%rax
    1b86:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b8d:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b94:	00 
    1b95:	75 41                	jne    1bd8 <printf+0x389>
        s = "(null)";
    1b97:	48 b8 b5 20 00 00 00 	movabs $0x20b5,%rax
    1b9e:	00 00 00 
    1ba1:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1ba8:	eb 2e                	jmp    1bd8 <printf+0x389>
        putc(fd, *(s++));
    1baa:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1bb1:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1bb5:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1bbc:	0f b6 00             	movzbl (%rax),%eax
    1bbf:	0f be d0             	movsbl %al,%edx
    1bc2:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bc8:	89 d6                	mov    %edx,%esi
    1bca:	89 c7                	mov    %eax,%edi
    1bcc:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1bd3:	00 00 00 
    1bd6:	ff d0                	call   *%rax
      while (*s)
    1bd8:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1bdf:	0f b6 00             	movzbl (%rax),%eax
    1be2:	84 c0                	test   %al,%al
    1be4:	75 c4                	jne    1baa <printf+0x35b>
      break;
    1be6:	eb 54                	jmp    1c3c <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1be8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1bee:	be 25 00 00 00       	mov    $0x25,%esi
    1bf3:	89 c7                	mov    %eax,%edi
    1bf5:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1bfc:	00 00 00 
    1bff:	ff d0                	call   *%rax
      break;
    1c01:	eb 39                	jmp    1c3c <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1c03:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c09:	be 25 00 00 00       	mov    $0x25,%esi
    1c0e:	89 c7                	mov    %eax,%edi
    1c10:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1c17:	00 00 00 
    1c1a:	ff d0                	call   *%rax
      putc(fd, c);
    1c1c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1c22:	0f be d0             	movsbl %al,%edx
    1c25:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c2b:	89 d6                	mov    %edx,%esi
    1c2d:	89 c7                	mov    %eax,%edi
    1c2f:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1c36:	00 00 00 
    1c39:	ff d0                	call   *%rax
      break;
    1c3b:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1c3c:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1c43:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1c49:	48 63 d0             	movslq %eax,%rdx
    1c4c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1c53:	48 01 d0             	add    %rdx,%rax
    1c56:	0f b6 00             	movzbl (%rax),%eax
    1c59:	0f be c0             	movsbl %al,%eax
    1c5c:	25 ff 00 00 00       	and    $0xff,%eax
    1c61:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1c67:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1c6e:	0f 85 6f fc ff ff    	jne    18e3 <printf+0x94>
    }
  }
}
    1c74:	eb 01                	jmp    1c77 <printf+0x428>
      break;
    1c76:	90                   	nop
}
    1c77:	90                   	nop
    1c78:	c9                   	leave
    1c79:	c3                   	ret

0000000000001c7a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c7a:	55                   	push   %rbp
    1c7b:	48 89 e5             	mov    %rsp,%rbp
    1c7e:	48 83 ec 18          	sub    $0x18,%rsp
    1c82:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c86:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c8a:	48 83 e8 10          	sub    $0x10,%rax
    1c8e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c92:	48 b8 f0 20 00 00 00 	movabs $0x20f0,%rax
    1c99:	00 00 00 
    1c9c:	48 8b 00             	mov    (%rax),%rax
    1c9f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ca3:	eb 2f                	jmp    1cd4 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ca5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca9:	48 8b 00             	mov    (%rax),%rax
    1cac:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cb0:	72 17                	jb     1cc9 <free+0x4f>
    1cb2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cba:	72 2f                	jb     1ceb <free+0x71>
    1cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc0:	48 8b 00             	mov    (%rax),%rax
    1cc3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cc7:	72 22                	jb     1ceb <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1cc9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ccd:	48 8b 00             	mov    (%rax),%rax
    1cd0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1cd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cd8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1cdc:	73 c7                	jae    1ca5 <free+0x2b>
    1cde:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce2:	48 8b 00             	mov    (%rax),%rax
    1ce5:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ce9:	73 ba                	jae    1ca5 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1ceb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cef:	8b 40 08             	mov    0x8(%rax),%eax
    1cf2:	89 c0                	mov    %eax,%eax
    1cf4:	48 c1 e0 04          	shl    $0x4,%rax
    1cf8:	48 89 c2             	mov    %rax,%rdx
    1cfb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cff:	48 01 c2             	add    %rax,%rdx
    1d02:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d06:	48 8b 00             	mov    (%rax),%rax
    1d09:	48 39 c2             	cmp    %rax,%rdx
    1d0c:	75 2d                	jne    1d3b <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1d0e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d12:	8b 50 08             	mov    0x8(%rax),%edx
    1d15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d19:	48 8b 00             	mov    (%rax),%rax
    1d1c:	8b 40 08             	mov    0x8(%rax),%eax
    1d1f:	01 c2                	add    %eax,%edx
    1d21:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d25:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1d28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2c:	48 8b 00             	mov    (%rax),%rax
    1d2f:	48 8b 10             	mov    (%rax),%rdx
    1d32:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d36:	48 89 10             	mov    %rdx,(%rax)
    1d39:	eb 0e                	jmp    1d49 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1d3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3f:	48 8b 10             	mov    (%rax),%rdx
    1d42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d46:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1d49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4d:	8b 40 08             	mov    0x8(%rax),%eax
    1d50:	89 c0                	mov    %eax,%eax
    1d52:	48 c1 e0 04          	shl    $0x4,%rax
    1d56:	48 89 c2             	mov    %rax,%rdx
    1d59:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5d:	48 01 d0             	add    %rdx,%rax
    1d60:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1d64:	75 27                	jne    1d8d <free+0x113>
    p->s.size += bp->s.size;
    1d66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6a:	8b 50 08             	mov    0x8(%rax),%edx
    1d6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d71:	8b 40 08             	mov    0x8(%rax),%eax
    1d74:	01 c2                	add    %eax,%edx
    1d76:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d7a:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1d7d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d81:	48 8b 10             	mov    (%rax),%rdx
    1d84:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d88:	48 89 10             	mov    %rdx,(%rax)
    1d8b:	eb 0b                	jmp    1d98 <free+0x11e>
  } else
    p->s.ptr = bp;
    1d8d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d91:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d95:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d98:	48 ba f0 20 00 00 00 	movabs $0x20f0,%rdx
    1d9f:	00 00 00 
    1da2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da6:	48 89 02             	mov    %rax,(%rdx)
}
    1da9:	90                   	nop
    1daa:	c9                   	leave
    1dab:	c3                   	ret

0000000000001dac <morecore>:

static Header*
morecore(uint nu)
{
    1dac:	55                   	push   %rbp
    1dad:	48 89 e5             	mov    %rsp,%rbp
    1db0:	48 83 ec 20          	sub    $0x20,%rsp
    1db4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1db7:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1dbe:	77 07                	ja     1dc7 <morecore+0x1b>
    nu = 4096;
    1dc0:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1dc7:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1dca:	48 c1 e0 04          	shl    $0x4,%rax
    1dce:	48 89 c7             	mov    %rax,%rdi
    1dd1:	48 b8 45 16 00 00 00 	movabs $0x1645,%rax
    1dd8:	00 00 00 
    1ddb:	ff d0                	call   *%rax
    1ddd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1de1:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1de6:	75 07                	jne    1def <morecore+0x43>
    return 0;
    1de8:	b8 00 00 00 00       	mov    $0x0,%eax
    1ded:	eb 36                	jmp    1e25 <morecore+0x79>
  hp = (Header*)p;
    1def:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1df3:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1df7:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dfb:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1dfe:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1e01:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e05:	48 83 c0 10          	add    $0x10,%rax
    1e09:	48 89 c7             	mov    %rax,%rdi
    1e0c:	48 b8 7a 1c 00 00 00 	movabs $0x1c7a,%rax
    1e13:	00 00 00 
    1e16:	ff d0                	call   *%rax
  return freep;
    1e18:	48 b8 f0 20 00 00 00 	movabs $0x20f0,%rax
    1e1f:	00 00 00 
    1e22:	48 8b 00             	mov    (%rax),%rax
}
    1e25:	c9                   	leave
    1e26:	c3                   	ret

0000000000001e27 <malloc>:

void*
malloc(uint nbytes)
{
    1e27:	55                   	push   %rbp
    1e28:	48 89 e5             	mov    %rsp,%rbp
    1e2b:	48 83 ec 30          	sub    $0x30,%rsp
    1e2f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1e32:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1e35:	48 83 c0 0f          	add    $0xf,%rax
    1e39:	48 c1 e8 04          	shr    $0x4,%rax
    1e3d:	83 c0 01             	add    $0x1,%eax
    1e40:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1e43:	48 b8 f0 20 00 00 00 	movabs $0x20f0,%rax
    1e4a:	00 00 00 
    1e4d:	48 8b 00             	mov    (%rax),%rax
    1e50:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e54:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1e59:	75 4a                	jne    1ea5 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1e5b:	48 b8 e0 20 00 00 00 	movabs $0x20e0,%rax
    1e62:	00 00 00 
    1e65:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e69:	48 ba f0 20 00 00 00 	movabs $0x20f0,%rdx
    1e70:	00 00 00 
    1e73:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e77:	48 89 02             	mov    %rax,(%rdx)
    1e7a:	48 b8 f0 20 00 00 00 	movabs $0x20f0,%rax
    1e81:	00 00 00 
    1e84:	48 8b 00             	mov    (%rax),%rax
    1e87:	48 ba e0 20 00 00 00 	movabs $0x20e0,%rdx
    1e8e:	00 00 00 
    1e91:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e94:	48 b8 e0 20 00 00 00 	movabs $0x20e0,%rax
    1e9b:	00 00 00 
    1e9e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ea5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ea9:	48 8b 00             	mov    (%rax),%rax
    1eac:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1eb0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eb4:	8b 40 08             	mov    0x8(%rax),%eax
    1eb7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1eba:	72 65                	jb     1f21 <malloc+0xfa>
      if(p->s.size == nunits)
    1ebc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ec0:	8b 40 08             	mov    0x8(%rax),%eax
    1ec3:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1ec6:	75 10                	jne    1ed8 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1ec8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ecc:	48 8b 10             	mov    (%rax),%rdx
    1ecf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ed3:	48 89 10             	mov    %rdx,(%rax)
    1ed6:	eb 2e                	jmp    1f06 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1ed8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1edc:	8b 40 08             	mov    0x8(%rax),%eax
    1edf:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1ee2:	89 c2                	mov    %eax,%edx
    1ee4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ee8:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1eeb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eef:	8b 40 08             	mov    0x8(%rax),%eax
    1ef2:	89 c0                	mov    %eax,%eax
    1ef4:	48 c1 e0 04          	shl    $0x4,%rax
    1ef8:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1efc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f00:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1f03:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1f06:	48 ba f0 20 00 00 00 	movabs $0x20f0,%rdx
    1f0d:	00 00 00 
    1f10:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f14:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1f17:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f1b:	48 83 c0 10          	add    $0x10,%rax
    1f1f:	eb 4e                	jmp    1f6f <malloc+0x148>
    }
    if(p == freep)
    1f21:	48 b8 f0 20 00 00 00 	movabs $0x20f0,%rax
    1f28:	00 00 00 
    1f2b:	48 8b 00             	mov    (%rax),%rax
    1f2e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1f32:	75 23                	jne    1f57 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1f34:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1f37:	89 c7                	mov    %eax,%edi
    1f39:	48 b8 ac 1d 00 00 00 	movabs $0x1dac,%rax
    1f40:	00 00 00 
    1f43:	ff d0                	call   *%rax
    1f45:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1f49:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1f4e:	75 07                	jne    1f57 <malloc+0x130>
        return 0;
    1f50:	b8 00 00 00 00       	mov    $0x0,%eax
    1f55:	eb 18                	jmp    1f6f <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1f57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f5b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1f5f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f63:	48 8b 00             	mov    (%rax),%rax
    1f66:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1f6a:	e9 41 ff ff ff       	jmp    1eb0 <malloc+0x89>
  }
}
    1f6f:	c9                   	leave
    1f70:	c3                   	ret
