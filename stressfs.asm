
_stressfs:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    100b:	89 bd dc fd ff ff    	mov    %edi,-0x224(%rbp)
    1011:	48 89 b5 d0 fd ff ff 	mov    %rsi,-0x230(%rbp)
  int fd, i;
  char path[] = "stressfs0";
    1018:	48 b8 73 74 72 65 73 	movabs $0x7366737365727473,%rax
    101f:	73 66 73 
    1022:	48 89 45 ee          	mov    %rax,-0x12(%rbp)
    1026:	66 c7 45 f6 30 00    	movw   $0x30,-0xa(%rbp)
  char data[512];

  printf(1, "stressfs starting\n");
    102c:	48 b8 e8 1e 00 00 00 	movabs $0x1ee8,%rax
    1033:	00 00 00 
    1036:	48 89 c6             	mov    %rax,%rsi
    1039:	bf 01 00 00 00       	mov    $0x1,%edi
    103e:	b8 00 00 00 00       	mov    $0x0,%eax
    1043:	48 ba c6 17 00 00 00 	movabs $0x17c6,%rdx
    104a:	00 00 00 
    104d:	ff d2                	call   *%rdx
  memset(data, 'a', sizeof(data));
    104f:	48 8d 85 e0 fd ff ff 	lea    -0x220(%rbp),%rax
    1056:	ba 00 02 00 00       	mov    $0x200,%edx
    105b:	be 61 00 00 00       	mov    $0x61,%esi
    1060:	48 89 c7             	mov    %rax,%rdi
    1063:	48 b8 c2 12 00 00 00 	movabs $0x12c2,%rax
    106a:	00 00 00 
    106d:	ff d0                	call   *%rax

  for(i = 0; i < 4; i++)
    106f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1076:	eb 14                	jmp    108c <main+0x8c>
    if(fork() > 0)
    1078:	48 b8 d2 14 00 00 00 	movabs $0x14d2,%rax
    107f:	00 00 00 
    1082:	ff d0                	call   *%rax
    1084:	85 c0                	test   %eax,%eax
    1086:	7f 0c                	jg     1094 <main+0x94>
  for(i = 0; i < 4; i++)
    1088:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    108c:	83 7d fc 03          	cmpl   $0x3,-0x4(%rbp)
    1090:	7e e6                	jle    1078 <main+0x78>
    1092:	eb 01                	jmp    1095 <main+0x95>
      break;
    1094:	90                   	nop

  printf(1, "write %d\n", i);
    1095:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1098:	48 b9 fb 1e 00 00 00 	movabs $0x1efb,%rcx
    109f:	00 00 00 
    10a2:	89 c2                	mov    %eax,%edx
    10a4:	48 89 ce             	mov    %rcx,%rsi
    10a7:	bf 01 00 00 00       	mov    $0x1,%edi
    10ac:	b8 00 00 00 00       	mov    $0x0,%eax
    10b1:	48 b9 c6 17 00 00 00 	movabs $0x17c6,%rcx
    10b8:	00 00 00 
    10bb:	ff d1                	call   *%rcx

  path[8] += i;
    10bd:	0f b6 45 f6          	movzbl -0xa(%rbp),%eax
    10c1:	89 c2                	mov    %eax,%edx
    10c3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10c6:	01 d0                	add    %edx,%eax
    10c8:	88 45 f6             	mov    %al,-0xa(%rbp)
  fd = open(path, O_CREATE | O_RDWR);
    10cb:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    10cf:	be 02 02 00 00       	mov    $0x202,%esi
    10d4:	48 89 c7             	mov    %rax,%rdi
    10d7:	48 b8 47 15 00 00 00 	movabs $0x1547,%rax
    10de:	00 00 00 
    10e1:	ff d0                	call   *%rax
    10e3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for(i = 0; i < 20; i++)
    10e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    10ed:	eb 24                	jmp    1113 <main+0x113>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
    10ef:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
    10f6:	8b 45 f8             	mov    -0x8(%rbp),%eax
    10f9:	ba 00 02 00 00       	mov    $0x200,%edx
    10fe:	48 89 ce             	mov    %rcx,%rsi
    1101:	89 c7                	mov    %eax,%edi
    1103:	48 b8 13 15 00 00 00 	movabs $0x1513,%rax
    110a:	00 00 00 
    110d:	ff d0                	call   *%rax
  for(i = 0; i < 20; i++)
    110f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1113:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1117:	7e d6                	jle    10ef <main+0xef>
  close(fd);
    1119:	8b 45 f8             	mov    -0x8(%rbp),%eax
    111c:	89 c7                	mov    %eax,%edi
    111e:	48 b8 20 15 00 00 00 	movabs $0x1520,%rax
    1125:	00 00 00 
    1128:	ff d0                	call   *%rax

  printf(1, "read\n");
    112a:	48 b8 05 1f 00 00 00 	movabs $0x1f05,%rax
    1131:	00 00 00 
    1134:	48 89 c6             	mov    %rax,%rsi
    1137:	bf 01 00 00 00       	mov    $0x1,%edi
    113c:	b8 00 00 00 00       	mov    $0x0,%eax
    1141:	48 ba c6 17 00 00 00 	movabs $0x17c6,%rdx
    1148:	00 00 00 
    114b:	ff d2                	call   *%rdx

  fd = open(path, O_RDONLY);
    114d:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    1151:	be 00 00 00 00       	mov    $0x0,%esi
    1156:	48 89 c7             	mov    %rax,%rdi
    1159:	48 b8 47 15 00 00 00 	movabs $0x1547,%rax
    1160:	00 00 00 
    1163:	ff d0                	call   *%rax
    1165:	89 45 f8             	mov    %eax,-0x8(%rbp)
  for (i = 0; i < 20; i++)
    1168:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    116f:	eb 24                	jmp    1195 <main+0x195>
    read(fd, data, sizeof(data));
    1171:	48 8d 8d e0 fd ff ff 	lea    -0x220(%rbp),%rcx
    1178:	8b 45 f8             	mov    -0x8(%rbp),%eax
    117b:	ba 00 02 00 00       	mov    $0x200,%edx
    1180:	48 89 ce             	mov    %rcx,%rsi
    1183:	89 c7                	mov    %eax,%edi
    1185:	48 b8 06 15 00 00 00 	movabs $0x1506,%rax
    118c:	00 00 00 
    118f:	ff d0                	call   *%rax
  for (i = 0; i < 20; i++)
    1191:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1195:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    1199:	7e d6                	jle    1171 <main+0x171>
  close(fd);
    119b:	8b 45 f8             	mov    -0x8(%rbp),%eax
    119e:	89 c7                	mov    %eax,%edi
    11a0:	48 b8 20 15 00 00 00 	movabs $0x1520,%rax
    11a7:	00 00 00 
    11aa:	ff d0                	call   *%rax

  wait();
    11ac:	48 b8 ec 14 00 00 00 	movabs $0x14ec,%rax
    11b3:	00 00 00 
    11b6:	ff d0                	call   *%rax

  exit();
    11b8:	48 b8 df 14 00 00 00 	movabs $0x14df,%rax
    11bf:	00 00 00 
    11c2:	ff d0                	call   *%rax

00000000000011c4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11c4:	55                   	push   %rbp
    11c5:	48 89 e5             	mov    %rsp,%rbp
    11c8:	48 83 ec 10          	sub    $0x10,%rsp
    11cc:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d0:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11d3:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    11d6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    11da:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11dd:	8b 45 f4             	mov    -0xc(%rbp),%eax
    11e0:	48 89 ce             	mov    %rcx,%rsi
    11e3:	48 89 f7             	mov    %rsi,%rdi
    11e6:	89 d1                	mov    %edx,%ecx
    11e8:	fc                   	cld
    11e9:	f3 aa                	rep stos %al,(%rdi)
    11eb:	89 ca                	mov    %ecx,%edx
    11ed:	48 89 fe             	mov    %rdi,%rsi
    11f0:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    11f4:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11f7:	90                   	nop
    11f8:	c9                   	leave
    11f9:	c3                   	ret

00000000000011fa <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11fa:	55                   	push   %rbp
    11fb:	48 89 e5             	mov    %rsp,%rbp
    11fe:	48 83 ec 20          	sub    $0x20,%rsp
    1202:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1206:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    120a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    120e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    1212:	90                   	nop
    1213:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1217:	48 8d 42 01          	lea    0x1(%rdx),%rax
    121b:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    121f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1223:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1227:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    122b:	0f b6 12             	movzbl (%rdx),%edx
    122e:	88 10                	mov    %dl,(%rax)
    1230:	0f b6 00             	movzbl (%rax),%eax
    1233:	84 c0                	test   %al,%al
    1235:	75 dc                	jne    1213 <strcpy+0x19>
    ;
  return os;
    1237:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    123b:	c9                   	leave
    123c:	c3                   	ret

000000000000123d <strcmp>:

int
strcmp(const char *p, const char *q)
{
    123d:	55                   	push   %rbp
    123e:	48 89 e5             	mov    %rsp,%rbp
    1241:	48 83 ec 10          	sub    $0x10,%rsp
    1245:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1249:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    124d:	eb 0a                	jmp    1259 <strcmp+0x1c>
    p++, q++;
    124f:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1254:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1259:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    125d:	0f b6 00             	movzbl (%rax),%eax
    1260:	84 c0                	test   %al,%al
    1262:	74 12                	je     1276 <strcmp+0x39>
    1264:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1268:	0f b6 10             	movzbl (%rax),%edx
    126b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    126f:	0f b6 00             	movzbl (%rax),%eax
    1272:	38 c2                	cmp    %al,%dl
    1274:	74 d9                	je     124f <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1276:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    127a:	0f b6 00             	movzbl (%rax),%eax
    127d:	0f b6 d0             	movzbl %al,%edx
    1280:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1284:	0f b6 00             	movzbl (%rax),%eax
    1287:	0f b6 c0             	movzbl %al,%eax
    128a:	29 c2                	sub    %eax,%edx
    128c:	89 d0                	mov    %edx,%eax
}
    128e:	c9                   	leave
    128f:	c3                   	ret

0000000000001290 <strlen>:

uint
strlen(char *s)
{
    1290:	55                   	push   %rbp
    1291:	48 89 e5             	mov    %rsp,%rbp
    1294:	48 83 ec 18          	sub    $0x18,%rsp
    1298:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    129c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12a3:	eb 04                	jmp    12a9 <strlen+0x19>
    12a5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    12a9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12ac:	48 63 d0             	movslq %eax,%rdx
    12af:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12b3:	48 01 d0             	add    %rdx,%rax
    12b6:	0f b6 00             	movzbl (%rax),%eax
    12b9:	84 c0                	test   %al,%al
    12bb:	75 e8                	jne    12a5 <strlen+0x15>
    ;
  return n;
    12bd:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    12c0:	c9                   	leave
    12c1:	c3                   	ret

00000000000012c2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    12c2:	55                   	push   %rbp
    12c3:	48 89 e5             	mov    %rsp,%rbp
    12c6:	48 83 ec 10          	sub    $0x10,%rsp
    12ca:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12ce:	89 75 f4             	mov    %esi,-0xc(%rbp)
    12d1:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    12d4:	8b 55 f0             	mov    -0x10(%rbp),%edx
    12d7:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    12da:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12de:	89 ce                	mov    %ecx,%esi
    12e0:	48 89 c7             	mov    %rax,%rdi
    12e3:	48 b8 c4 11 00 00 00 	movabs $0x11c4,%rax
    12ea:	00 00 00 
    12ed:	ff d0                	call   *%rax
  return dst;
    12ef:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    12f3:	c9                   	leave
    12f4:	c3                   	ret

00000000000012f5 <strchr>:

char*
strchr(const char *s, char c)
{
    12f5:	55                   	push   %rbp
    12f6:	48 89 e5             	mov    %rsp,%rbp
    12f9:	48 83 ec 10          	sub    $0x10,%rsp
    12fd:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1301:	89 f0                	mov    %esi,%eax
    1303:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1306:	eb 17                	jmp    131f <strchr+0x2a>
    if(*s == c)
    1308:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    130c:	0f b6 00             	movzbl (%rax),%eax
    130f:	38 45 f4             	cmp    %al,-0xc(%rbp)
    1312:	75 06                	jne    131a <strchr+0x25>
      return (char*)s;
    1314:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1318:	eb 15                	jmp    132f <strchr+0x3a>
  for(; *s; s++)
    131a:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    131f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1323:	0f b6 00             	movzbl (%rax),%eax
    1326:	84 c0                	test   %al,%al
    1328:	75 de                	jne    1308 <strchr+0x13>
  return 0;
    132a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    132f:	c9                   	leave
    1330:	c3                   	ret

0000000000001331 <gets>:

char*
gets(char *buf, int max)
{
    1331:	55                   	push   %rbp
    1332:	48 89 e5             	mov    %rsp,%rbp
    1335:	48 83 ec 20          	sub    $0x20,%rsp
    1339:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    133d:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1340:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1347:	eb 4f                	jmp    1398 <gets+0x67>
    cc = read(0, &c, 1);
    1349:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    134d:	ba 01 00 00 00       	mov    $0x1,%edx
    1352:	48 89 c6             	mov    %rax,%rsi
    1355:	bf 00 00 00 00       	mov    $0x0,%edi
    135a:	48 b8 06 15 00 00 00 	movabs $0x1506,%rax
    1361:	00 00 00 
    1364:	ff d0                	call   *%rax
    1366:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1369:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    136d:	7e 36                	jle    13a5 <gets+0x74>
      break;
    buf[i++] = c;
    136f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1372:	8d 50 01             	lea    0x1(%rax),%edx
    1375:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1378:	48 63 d0             	movslq %eax,%rdx
    137b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    137f:	48 01 c2             	add    %rax,%rdx
    1382:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1386:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1388:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    138c:	3c 0a                	cmp    $0xa,%al
    138e:	74 16                	je     13a6 <gets+0x75>
    1390:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1394:	3c 0d                	cmp    $0xd,%al
    1396:	74 0e                	je     13a6 <gets+0x75>
  for(i=0; i+1 < max; ){
    1398:	8b 45 fc             	mov    -0x4(%rbp),%eax
    139b:	83 c0 01             	add    $0x1,%eax
    139e:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    13a1:	7f a6                	jg     1349 <gets+0x18>
    13a3:	eb 01                	jmp    13a6 <gets+0x75>
      break;
    13a5:	90                   	nop
      break;
  }
  buf[i] = '\0';
    13a6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13a9:	48 63 d0             	movslq %eax,%rdx
    13ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13b0:	48 01 d0             	add    %rdx,%rax
    13b3:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    13b6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13ba:	c9                   	leave
    13bb:	c3                   	ret

00000000000013bc <stat>:

int
stat(char *n, struct stat *st)
{
    13bc:	55                   	push   %rbp
    13bd:	48 89 e5             	mov    %rsp,%rbp
    13c0:	48 83 ec 20          	sub    $0x20,%rsp
    13c4:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    13c8:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    13cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13d0:	be 00 00 00 00       	mov    $0x0,%esi
    13d5:	48 89 c7             	mov    %rax,%rdi
    13d8:	48 b8 47 15 00 00 00 	movabs $0x1547,%rax
    13df:	00 00 00 
    13e2:	ff d0                	call   *%rax
    13e4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    13e7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    13eb:	79 07                	jns    13f4 <stat+0x38>
    return -1;
    13ed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13f2:	eb 2f                	jmp    1423 <stat+0x67>
  r = fstat(fd, st);
    13f4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    13f8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13fb:	48 89 d6             	mov    %rdx,%rsi
    13fe:	89 c7                	mov    %eax,%edi
    1400:	48 b8 6e 15 00 00 00 	movabs $0x156e,%rax
    1407:	00 00 00 
    140a:	ff d0                	call   *%rax
    140c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    140f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1412:	89 c7                	mov    %eax,%edi
    1414:	48 b8 20 15 00 00 00 	movabs $0x1520,%rax
    141b:	00 00 00 
    141e:	ff d0                	call   *%rax
  return r;
    1420:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    1423:	c9                   	leave
    1424:	c3                   	ret

0000000000001425 <atoi>:

int
atoi(const char *s)
{
    1425:	55                   	push   %rbp
    1426:	48 89 e5             	mov    %rsp,%rbp
    1429:	48 83 ec 18          	sub    $0x18,%rsp
    142d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1431:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1438:	eb 28                	jmp    1462 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    143a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    143d:	89 d0                	mov    %edx,%eax
    143f:	c1 e0 02             	shl    $0x2,%eax
    1442:	01 d0                	add    %edx,%eax
    1444:	01 c0                	add    %eax,%eax
    1446:	89 c1                	mov    %eax,%ecx
    1448:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    144c:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1450:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1454:	0f b6 00             	movzbl (%rax),%eax
    1457:	0f be c0             	movsbl %al,%eax
    145a:	01 c8                	add    %ecx,%eax
    145c:	83 e8 30             	sub    $0x30,%eax
    145f:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1462:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1466:	0f b6 00             	movzbl (%rax),%eax
    1469:	3c 2f                	cmp    $0x2f,%al
    146b:	7e 0b                	jle    1478 <atoi+0x53>
    146d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1471:	0f b6 00             	movzbl (%rax),%eax
    1474:	3c 39                	cmp    $0x39,%al
    1476:	7e c2                	jle    143a <atoi+0x15>
  return n;
    1478:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    147b:	c9                   	leave
    147c:	c3                   	ret

000000000000147d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    147d:	55                   	push   %rbp
    147e:	48 89 e5             	mov    %rsp,%rbp
    1481:	48 83 ec 28          	sub    $0x28,%rsp
    1485:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1489:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    148d:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1490:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1494:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1498:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    149c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    14a0:	eb 1d                	jmp    14bf <memmove+0x42>
    *dst++ = *src++;
    14a2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    14a6:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14aa:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    14ae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    14b2:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14b6:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    14ba:	0f b6 12             	movzbl (%rdx),%edx
    14bd:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    14bf:	8b 45 dc             	mov    -0x24(%rbp),%eax
    14c2:	8d 50 ff             	lea    -0x1(%rax),%edx
    14c5:	89 55 dc             	mov    %edx,-0x24(%rbp)
    14c8:	85 c0                	test   %eax,%eax
    14ca:	7f d6                	jg     14a2 <memmove+0x25>
  return vdst;
    14cc:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    14d0:	c9                   	leave
    14d1:	c3                   	ret

00000000000014d2 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    14d2:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    14d9:	49 89 ca             	mov    %rcx,%r10
    14dc:	0f 05                	syscall
    14de:	c3                   	ret

00000000000014df <exit>:
SYSCALL(exit)
    14df:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    14e6:	49 89 ca             	mov    %rcx,%r10
    14e9:	0f 05                	syscall
    14eb:	c3                   	ret

00000000000014ec <wait>:
SYSCALL(wait)
    14ec:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    14f3:	49 89 ca             	mov    %rcx,%r10
    14f6:	0f 05                	syscall
    14f8:	c3                   	ret

00000000000014f9 <pipe>:
SYSCALL(pipe)
    14f9:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1500:	49 89 ca             	mov    %rcx,%r10
    1503:	0f 05                	syscall
    1505:	c3                   	ret

0000000000001506 <read>:
SYSCALL(read)
    1506:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    150d:	49 89 ca             	mov    %rcx,%r10
    1510:	0f 05                	syscall
    1512:	c3                   	ret

0000000000001513 <write>:
SYSCALL(write)
    1513:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    151a:	49 89 ca             	mov    %rcx,%r10
    151d:	0f 05                	syscall
    151f:	c3                   	ret

0000000000001520 <close>:
SYSCALL(close)
    1520:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    1527:	49 89 ca             	mov    %rcx,%r10
    152a:	0f 05                	syscall
    152c:	c3                   	ret

000000000000152d <kill>:
SYSCALL(kill)
    152d:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1534:	49 89 ca             	mov    %rcx,%r10
    1537:	0f 05                	syscall
    1539:	c3                   	ret

000000000000153a <exec>:
SYSCALL(exec)
    153a:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1541:	49 89 ca             	mov    %rcx,%r10
    1544:	0f 05                	syscall
    1546:	c3                   	ret

0000000000001547 <open>:
SYSCALL(open)
    1547:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    154e:	49 89 ca             	mov    %rcx,%r10
    1551:	0f 05                	syscall
    1553:	c3                   	ret

0000000000001554 <mknod>:
SYSCALL(mknod)
    1554:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    155b:	49 89 ca             	mov    %rcx,%r10
    155e:	0f 05                	syscall
    1560:	c3                   	ret

0000000000001561 <unlink>:
SYSCALL(unlink)
    1561:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1568:	49 89 ca             	mov    %rcx,%r10
    156b:	0f 05                	syscall
    156d:	c3                   	ret

000000000000156e <fstat>:
SYSCALL(fstat)
    156e:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1575:	49 89 ca             	mov    %rcx,%r10
    1578:	0f 05                	syscall
    157a:	c3                   	ret

000000000000157b <link>:
SYSCALL(link)
    157b:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1582:	49 89 ca             	mov    %rcx,%r10
    1585:	0f 05                	syscall
    1587:	c3                   	ret

0000000000001588 <mkdir>:
SYSCALL(mkdir)
    1588:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    158f:	49 89 ca             	mov    %rcx,%r10
    1592:	0f 05                	syscall
    1594:	c3                   	ret

0000000000001595 <chdir>:
SYSCALL(chdir)
    1595:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    159c:	49 89 ca             	mov    %rcx,%r10
    159f:	0f 05                	syscall
    15a1:	c3                   	ret

00000000000015a2 <dup>:
SYSCALL(dup)
    15a2:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    15a9:	49 89 ca             	mov    %rcx,%r10
    15ac:	0f 05                	syscall
    15ae:	c3                   	ret

00000000000015af <getpid>:
SYSCALL(getpid)
    15af:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    15b6:	49 89 ca             	mov    %rcx,%r10
    15b9:	0f 05                	syscall
    15bb:	c3                   	ret

00000000000015bc <sbrk>:
SYSCALL(sbrk)
    15bc:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    15c3:	49 89 ca             	mov    %rcx,%r10
    15c6:	0f 05                	syscall
    15c8:	c3                   	ret

00000000000015c9 <sleep>:
SYSCALL(sleep)
    15c9:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    15d0:	49 89 ca             	mov    %rcx,%r10
    15d3:	0f 05                	syscall
    15d5:	c3                   	ret

00000000000015d6 <uptime>:
SYSCALL(uptime)
    15d6:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    15dd:	49 89 ca             	mov    %rcx,%r10
    15e0:	0f 05                	syscall
    15e2:	c3                   	ret

00000000000015e3 <mmap>:
SYSCALL(mmap)
    15e3:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    15ea:	49 89 ca             	mov    %rcx,%r10
    15ed:	0f 05                	syscall
    15ef:	c3                   	ret

00000000000015f0 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    15f0:	55                   	push   %rbp
    15f1:	48 89 e5             	mov    %rsp,%rbp
    15f4:	48 83 ec 10          	sub    $0x10,%rsp
    15f8:	89 7d fc             	mov    %edi,-0x4(%rbp)
    15fb:	89 f0                	mov    %esi,%eax
    15fd:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    1600:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    1604:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1607:	ba 01 00 00 00       	mov    $0x1,%edx
    160c:	48 89 ce             	mov    %rcx,%rsi
    160f:	89 c7                	mov    %eax,%edi
    1611:	48 b8 13 15 00 00 00 	movabs $0x1513,%rax
    1618:	00 00 00 
    161b:	ff d0                	call   *%rax
}
    161d:	90                   	nop
    161e:	c9                   	leave
    161f:	c3                   	ret

0000000000001620 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    1620:	55                   	push   %rbp
    1621:	48 89 e5             	mov    %rsp,%rbp
    1624:	48 83 ec 20          	sub    $0x20,%rsp
    1628:	89 7d ec             	mov    %edi,-0x14(%rbp)
    162b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    162f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1636:	eb 35                	jmp    166d <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1638:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    163c:	48 c1 e8 3c          	shr    $0x3c,%rax
    1640:	48 ba 20 1f 00 00 00 	movabs $0x1f20,%rdx
    1647:	00 00 00 
    164a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    164e:	0f be d0             	movsbl %al,%edx
    1651:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1654:	89 d6                	mov    %edx,%esi
    1656:	89 c7                	mov    %eax,%edi
    1658:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    165f:	00 00 00 
    1662:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1664:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1668:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    166d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1670:	83 f8 0f             	cmp    $0xf,%eax
    1673:	76 c3                	jbe    1638 <print_x64+0x18>
}
    1675:	90                   	nop
    1676:	90                   	nop
    1677:	c9                   	leave
    1678:	c3                   	ret

0000000000001679 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1679:	55                   	push   %rbp
    167a:	48 89 e5             	mov    %rsp,%rbp
    167d:	48 83 ec 20          	sub    $0x20,%rsp
    1681:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1684:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1687:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    168e:	eb 36                	jmp    16c6 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1690:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1693:	c1 e8 1c             	shr    $0x1c,%eax
    1696:	89 c2                	mov    %eax,%edx
    1698:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    169f:	00 00 00 
    16a2:	89 d2                	mov    %edx,%edx
    16a4:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    16a8:	0f be d0             	movsbl %al,%edx
    16ab:	8b 45 ec             	mov    -0x14(%rbp),%eax
    16ae:	89 d6                	mov    %edx,%esi
    16b0:	89 c7                	mov    %eax,%edi
    16b2:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    16b9:	00 00 00 
    16bc:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    16be:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    16c2:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    16c6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16c9:	83 f8 07             	cmp    $0x7,%eax
    16cc:	76 c2                	jbe    1690 <print_x32+0x17>
}
    16ce:	90                   	nop
    16cf:	90                   	nop
    16d0:	c9                   	leave
    16d1:	c3                   	ret

00000000000016d2 <print_d>:

  static void
print_d(int fd, int v)
{
    16d2:	55                   	push   %rbp
    16d3:	48 89 e5             	mov    %rsp,%rbp
    16d6:	48 83 ec 30          	sub    $0x30,%rsp
    16da:	89 7d dc             	mov    %edi,-0x24(%rbp)
    16dd:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    16e0:	8b 45 d8             	mov    -0x28(%rbp),%eax
    16e3:	48 98                	cltq
    16e5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    16e9:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16ed:	79 04                	jns    16f3 <print_d+0x21>
    x = -x;
    16ef:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    16f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    16fa:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16fe:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1705:	66 66 66 
    1708:	48 89 c8             	mov    %rcx,%rax
    170b:	48 f7 ea             	imul   %rdx
    170e:	48 c1 fa 02          	sar    $0x2,%rdx
    1712:	48 89 c8             	mov    %rcx,%rax
    1715:	48 c1 f8 3f          	sar    $0x3f,%rax
    1719:	48 29 c2             	sub    %rax,%rdx
    171c:	48 89 d0             	mov    %rdx,%rax
    171f:	48 c1 e0 02          	shl    $0x2,%rax
    1723:	48 01 d0             	add    %rdx,%rax
    1726:	48 01 c0             	add    %rax,%rax
    1729:	48 29 c1             	sub    %rax,%rcx
    172c:	48 89 ca             	mov    %rcx,%rdx
    172f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1732:	8d 48 01             	lea    0x1(%rax),%ecx
    1735:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1738:	48 b9 20 1f 00 00 00 	movabs $0x1f20,%rcx
    173f:	00 00 00 
    1742:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    1746:	48 98                	cltq
    1748:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    174c:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1750:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1757:	66 66 66 
    175a:	48 89 c8             	mov    %rcx,%rax
    175d:	48 f7 ea             	imul   %rdx
    1760:	48 89 d0             	mov    %rdx,%rax
    1763:	48 c1 f8 02          	sar    $0x2,%rax
    1767:	48 c1 f9 3f          	sar    $0x3f,%rcx
    176b:	48 89 ca             	mov    %rcx,%rdx
    176e:	48 29 d0             	sub    %rdx,%rax
    1771:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1775:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    177a:	0f 85 7a ff ff ff    	jne    16fa <print_d+0x28>

  if (v < 0)
    1780:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1784:	79 32                	jns    17b8 <print_d+0xe6>
    buf[i++] = '-';
    1786:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1789:	8d 50 01             	lea    0x1(%rax),%edx
    178c:	89 55 f4             	mov    %edx,-0xc(%rbp)
    178f:	48 98                	cltq
    1791:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1796:	eb 20                	jmp    17b8 <print_d+0xe6>
    putc(fd, buf[i]);
    1798:	8b 45 f4             	mov    -0xc(%rbp),%eax
    179b:	48 98                	cltq
    179d:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    17a2:	0f be d0             	movsbl %al,%edx
    17a5:	8b 45 dc             	mov    -0x24(%rbp),%eax
    17a8:	89 d6                	mov    %edx,%esi
    17aa:	89 c7                	mov    %eax,%edi
    17ac:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    17b3:	00 00 00 
    17b6:	ff d0                	call   *%rax
  while (--i >= 0)
    17b8:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    17bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    17c0:	79 d6                	jns    1798 <print_d+0xc6>
}
    17c2:	90                   	nop
    17c3:	90                   	nop
    17c4:	c9                   	leave
    17c5:	c3                   	ret

00000000000017c6 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    17c6:	55                   	push   %rbp
    17c7:	48 89 e5             	mov    %rsp,%rbp
    17ca:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    17d1:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    17d7:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    17de:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    17e5:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    17ec:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    17f3:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    17fa:	84 c0                	test   %al,%al
    17fc:	74 20                	je     181e <printf+0x58>
    17fe:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1802:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1806:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    180a:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    180e:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1812:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1816:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    181a:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    181e:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1825:	00 00 00 
    1828:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    182f:	00 00 00 
    1832:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1836:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    183d:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1844:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    184b:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1852:	00 00 00 
    1855:	e9 60 03 00 00       	jmp    1bba <printf+0x3f4>
    if (c != '%') {
    185a:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1861:	74 24                	je     1887 <printf+0xc1>
      putc(fd, c);
    1863:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1869:	0f be d0             	movsbl %al,%edx
    186c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1872:	89 d6                	mov    %edx,%esi
    1874:	89 c7                	mov    %eax,%edi
    1876:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    187d:	00 00 00 
    1880:	ff d0                	call   *%rax
      continue;
    1882:	e9 2c 03 00 00       	jmp    1bb3 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1887:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    188e:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1894:	48 63 d0             	movslq %eax,%rdx
    1897:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    189e:	48 01 d0             	add    %rdx,%rax
    18a1:	0f b6 00             	movzbl (%rax),%eax
    18a4:	0f be c0             	movsbl %al,%eax
    18a7:	25 ff 00 00 00       	and    $0xff,%eax
    18ac:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    18b2:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    18b9:	0f 84 2e 03 00 00    	je     1bed <printf+0x427>
      break;
    switch(c) {
    18bf:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18c6:	0f 84 32 01 00 00    	je     19fe <printf+0x238>
    18cc:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    18d3:	0f 8f a1 02 00 00    	jg     1b7a <printf+0x3b4>
    18d9:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18e0:	0f 84 d4 01 00 00    	je     1aba <printf+0x2f4>
    18e6:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18ed:	0f 8f 87 02 00 00    	jg     1b7a <printf+0x3b4>
    18f3:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    18fa:	0f 84 5b 01 00 00    	je     1a5b <printf+0x295>
    1900:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1907:	0f 8f 6d 02 00 00    	jg     1b7a <printf+0x3b4>
    190d:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1914:	0f 84 87 00 00 00    	je     19a1 <printf+0x1db>
    191a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1921:	0f 8f 53 02 00 00    	jg     1b7a <printf+0x3b4>
    1927:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    192e:	0f 84 2b 02 00 00    	je     1b5f <printf+0x399>
    1934:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    193b:	0f 85 39 02 00 00    	jne    1b7a <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1941:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1947:	83 f8 2f             	cmp    $0x2f,%eax
    194a:	77 23                	ja     196f <printf+0x1a9>
    194c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1953:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1959:	89 d2                	mov    %edx,%edx
    195b:	48 01 d0             	add    %rdx,%rax
    195e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1964:	83 c2 08             	add    $0x8,%edx
    1967:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    196d:	eb 12                	jmp    1981 <printf+0x1bb>
    196f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1976:	48 8d 50 08          	lea    0x8(%rax),%rdx
    197a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1981:	8b 00                	mov    (%rax),%eax
    1983:	0f be d0             	movsbl %al,%edx
    1986:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    198c:	89 d6                	mov    %edx,%esi
    198e:	89 c7                	mov    %eax,%edi
    1990:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    1997:	00 00 00 
    199a:	ff d0                	call   *%rax
      break;
    199c:	e9 12 02 00 00       	jmp    1bb3 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    19a1:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19a7:	83 f8 2f             	cmp    $0x2f,%eax
    19aa:	77 23                	ja     19cf <printf+0x209>
    19ac:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19b3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19b9:	89 d2                	mov    %edx,%edx
    19bb:	48 01 d0             	add    %rdx,%rax
    19be:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19c4:	83 c2 08             	add    $0x8,%edx
    19c7:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19cd:	eb 12                	jmp    19e1 <printf+0x21b>
    19cf:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19d6:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19da:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19e1:	8b 10                	mov    (%rax),%edx
    19e3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19e9:	89 d6                	mov    %edx,%esi
    19eb:	89 c7                	mov    %eax,%edi
    19ed:	48 b8 d2 16 00 00 00 	movabs $0x16d2,%rax
    19f4:	00 00 00 
    19f7:	ff d0                	call   *%rax
      break;
    19f9:	e9 b5 01 00 00       	jmp    1bb3 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    19fe:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a04:	83 f8 2f             	cmp    $0x2f,%eax
    1a07:	77 23                	ja     1a2c <printf+0x266>
    1a09:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a10:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a16:	89 d2                	mov    %edx,%edx
    1a18:	48 01 d0             	add    %rdx,%rax
    1a1b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a21:	83 c2 08             	add    $0x8,%edx
    1a24:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a2a:	eb 12                	jmp    1a3e <printf+0x278>
    1a2c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a33:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a37:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a3e:	8b 10                	mov    (%rax),%edx
    1a40:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a46:	89 d6                	mov    %edx,%esi
    1a48:	89 c7                	mov    %eax,%edi
    1a4a:	48 b8 79 16 00 00 00 	movabs $0x1679,%rax
    1a51:	00 00 00 
    1a54:	ff d0                	call   *%rax
      break;
    1a56:	e9 58 01 00 00       	jmp    1bb3 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a5b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a61:	83 f8 2f             	cmp    $0x2f,%eax
    1a64:	77 23                	ja     1a89 <printf+0x2c3>
    1a66:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a6d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a73:	89 d2                	mov    %edx,%edx
    1a75:	48 01 d0             	add    %rdx,%rax
    1a78:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a7e:	83 c2 08             	add    $0x8,%edx
    1a81:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a87:	eb 12                	jmp    1a9b <printf+0x2d5>
    1a89:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a90:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a94:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a9b:	48 8b 10             	mov    (%rax),%rdx
    1a9e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1aa4:	48 89 d6             	mov    %rdx,%rsi
    1aa7:	89 c7                	mov    %eax,%edi
    1aa9:	48 b8 20 16 00 00 00 	movabs $0x1620,%rax
    1ab0:	00 00 00 
    1ab3:	ff d0                	call   *%rax
      break;
    1ab5:	e9 f9 00 00 00       	jmp    1bb3 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1aba:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1ac0:	83 f8 2f             	cmp    $0x2f,%eax
    1ac3:	77 23                	ja     1ae8 <printf+0x322>
    1ac5:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1acc:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ad2:	89 d2                	mov    %edx,%edx
    1ad4:	48 01 d0             	add    %rdx,%rax
    1ad7:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1add:	83 c2 08             	add    $0x8,%edx
    1ae0:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1ae6:	eb 12                	jmp    1afa <printf+0x334>
    1ae8:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1aef:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1af3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1afa:	48 8b 00             	mov    (%rax),%rax
    1afd:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1b04:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1b0b:	00 
    1b0c:	75 41                	jne    1b4f <printf+0x389>
        s = "(null)";
    1b0e:	48 b8 0b 1f 00 00 00 	movabs $0x1f0b,%rax
    1b15:	00 00 00 
    1b18:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1b1f:	eb 2e                	jmp    1b4f <printf+0x389>
        putc(fd, *(s++));
    1b21:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b28:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1b2c:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1b33:	0f b6 00             	movzbl (%rax),%eax
    1b36:	0f be d0             	movsbl %al,%edx
    1b39:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b3f:	89 d6                	mov    %edx,%esi
    1b41:	89 c7                	mov    %eax,%edi
    1b43:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    1b4a:	00 00 00 
    1b4d:	ff d0                	call   *%rax
      while (*s)
    1b4f:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b56:	0f b6 00             	movzbl (%rax),%eax
    1b59:	84 c0                	test   %al,%al
    1b5b:	75 c4                	jne    1b21 <printf+0x35b>
      break;
    1b5d:	eb 54                	jmp    1bb3 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1b5f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b65:	be 25 00 00 00       	mov    $0x25,%esi
    1b6a:	89 c7                	mov    %eax,%edi
    1b6c:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    1b73:	00 00 00 
    1b76:	ff d0                	call   *%rax
      break;
    1b78:	eb 39                	jmp    1bb3 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b7a:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b80:	be 25 00 00 00       	mov    $0x25,%esi
    1b85:	89 c7                	mov    %eax,%edi
    1b87:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    1b8e:	00 00 00 
    1b91:	ff d0                	call   *%rax
      putc(fd, c);
    1b93:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b99:	0f be d0             	movsbl %al,%edx
    1b9c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1ba2:	89 d6                	mov    %edx,%esi
    1ba4:	89 c7                	mov    %eax,%edi
    1ba6:	48 b8 f0 15 00 00 00 	movabs $0x15f0,%rax
    1bad:	00 00 00 
    1bb0:	ff d0                	call   *%rax
      break;
    1bb2:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1bb3:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1bba:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1bc0:	48 63 d0             	movslq %eax,%rdx
    1bc3:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1bca:	48 01 d0             	add    %rdx,%rax
    1bcd:	0f b6 00             	movzbl (%rax),%eax
    1bd0:	0f be c0             	movsbl %al,%eax
    1bd3:	25 ff 00 00 00       	and    $0xff,%eax
    1bd8:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1bde:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1be5:	0f 85 6f fc ff ff    	jne    185a <printf+0x94>
    }
  }
}
    1beb:	eb 01                	jmp    1bee <printf+0x428>
      break;
    1bed:	90                   	nop
}
    1bee:	90                   	nop
    1bef:	c9                   	leave
    1bf0:	c3                   	ret

0000000000001bf1 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1bf1:	55                   	push   %rbp
    1bf2:	48 89 e5             	mov    %rsp,%rbp
    1bf5:	48 83 ec 18          	sub    $0x18,%rsp
    1bf9:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1bfd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1c01:	48 83 e8 10          	sub    $0x10,%rax
    1c05:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c09:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1c10:	00 00 00 
    1c13:	48 8b 00             	mov    (%rax),%rax
    1c16:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c1a:	eb 2f                	jmp    1c4b <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c1c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c20:	48 8b 00             	mov    (%rax),%rax
    1c23:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c27:	72 17                	jb     1c40 <free+0x4f>
    1c29:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c2d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c31:	72 2f                	jb     1c62 <free+0x71>
    1c33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c37:	48 8b 00             	mov    (%rax),%rax
    1c3a:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c3e:	72 22                	jb     1c62 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c40:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c44:	48 8b 00             	mov    (%rax),%rax
    1c47:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c4f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c53:	73 c7                	jae    1c1c <free+0x2b>
    1c55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c59:	48 8b 00             	mov    (%rax),%rax
    1c5c:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c60:	73 ba                	jae    1c1c <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c62:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c66:	8b 40 08             	mov    0x8(%rax),%eax
    1c69:	89 c0                	mov    %eax,%eax
    1c6b:	48 c1 e0 04          	shl    $0x4,%rax
    1c6f:	48 89 c2             	mov    %rax,%rdx
    1c72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c76:	48 01 c2             	add    %rax,%rdx
    1c79:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c7d:	48 8b 00             	mov    (%rax),%rax
    1c80:	48 39 c2             	cmp    %rax,%rdx
    1c83:	75 2d                	jne    1cb2 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1c85:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c89:	8b 50 08             	mov    0x8(%rax),%edx
    1c8c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c90:	48 8b 00             	mov    (%rax),%rax
    1c93:	8b 40 08             	mov    0x8(%rax),%eax
    1c96:	01 c2                	add    %eax,%edx
    1c98:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c9c:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1c9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca3:	48 8b 00             	mov    (%rax),%rax
    1ca6:	48 8b 10             	mov    (%rax),%rdx
    1ca9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cad:	48 89 10             	mov    %rdx,(%rax)
    1cb0:	eb 0e                	jmp    1cc0 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1cb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb6:	48 8b 10             	mov    (%rax),%rdx
    1cb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cbd:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1cc0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc4:	8b 40 08             	mov    0x8(%rax),%eax
    1cc7:	89 c0                	mov    %eax,%eax
    1cc9:	48 c1 e0 04          	shl    $0x4,%rax
    1ccd:	48 89 c2             	mov    %rax,%rdx
    1cd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd4:	48 01 d0             	add    %rdx,%rax
    1cd7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1cdb:	75 27                	jne    1d04 <free+0x113>
    p->s.size += bp->s.size;
    1cdd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ce1:	8b 50 08             	mov    0x8(%rax),%edx
    1ce4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce8:	8b 40 08             	mov    0x8(%rax),%eax
    1ceb:	01 c2                	add    %eax,%edx
    1ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf1:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1cf4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf8:	48 8b 10             	mov    (%rax),%rdx
    1cfb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cff:	48 89 10             	mov    %rdx,(%rax)
    1d02:	eb 0b                	jmp    1d0f <free+0x11e>
  } else
    p->s.ptr = bp;
    1d04:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d08:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1d0c:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1d0f:	48 ba 50 1f 00 00 00 	movabs $0x1f50,%rdx
    1d16:	00 00 00 
    1d19:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1d:	48 89 02             	mov    %rax,(%rdx)
}
    1d20:	90                   	nop
    1d21:	c9                   	leave
    1d22:	c3                   	ret

0000000000001d23 <morecore>:

static Header*
morecore(uint nu)
{
    1d23:	55                   	push   %rbp
    1d24:	48 89 e5             	mov    %rsp,%rbp
    1d27:	48 83 ec 20          	sub    $0x20,%rsp
    1d2b:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1d2e:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1d35:	77 07                	ja     1d3e <morecore+0x1b>
    nu = 4096;
    1d37:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1d3e:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d41:	48 c1 e0 04          	shl    $0x4,%rax
    1d45:	48 89 c7             	mov    %rax,%rdi
    1d48:	48 b8 bc 15 00 00 00 	movabs $0x15bc,%rax
    1d4f:	00 00 00 
    1d52:	ff d0                	call   *%rax
    1d54:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d58:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d5d:	75 07                	jne    1d66 <morecore+0x43>
    return 0;
    1d5f:	b8 00 00 00 00       	mov    $0x0,%eax
    1d64:	eb 36                	jmp    1d9c <morecore+0x79>
  hp = (Header*)p;
    1d66:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d6a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1d6e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d72:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d75:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1d78:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d7c:	48 83 c0 10          	add    $0x10,%rax
    1d80:	48 89 c7             	mov    %rax,%rdi
    1d83:	48 b8 f1 1b 00 00 00 	movabs $0x1bf1,%rax
    1d8a:	00 00 00 
    1d8d:	ff d0                	call   *%rax
  return freep;
    1d8f:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1d96:	00 00 00 
    1d99:	48 8b 00             	mov    (%rax),%rax
}
    1d9c:	c9                   	leave
    1d9d:	c3                   	ret

0000000000001d9e <malloc>:

void*
malloc(uint nbytes)
{
    1d9e:	55                   	push   %rbp
    1d9f:	48 89 e5             	mov    %rsp,%rbp
    1da2:	48 83 ec 30          	sub    $0x30,%rsp
    1da6:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1da9:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1dac:	48 83 c0 0f          	add    $0xf,%rax
    1db0:	48 c1 e8 04          	shr    $0x4,%rax
    1db4:	83 c0 01             	add    $0x1,%eax
    1db7:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1dba:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1dc1:	00 00 00 
    1dc4:	48 8b 00             	mov    (%rax),%rax
    1dc7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dcb:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1dd0:	75 4a                	jne    1e1c <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1dd2:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1dd9:	00 00 00 
    1ddc:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1de0:	48 ba 50 1f 00 00 00 	movabs $0x1f50,%rdx
    1de7:	00 00 00 
    1dea:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dee:	48 89 02             	mov    %rax,(%rdx)
    1df1:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1df8:	00 00 00 
    1dfb:	48 8b 00             	mov    (%rax),%rax
    1dfe:	48 ba 40 1f 00 00 00 	movabs $0x1f40,%rdx
    1e05:	00 00 00 
    1e08:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1e0b:	48 b8 40 1f 00 00 00 	movabs $0x1f40,%rax
    1e12:	00 00 00 
    1e15:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e20:	48 8b 00             	mov    (%rax),%rax
    1e23:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e27:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2b:	8b 40 08             	mov    0x8(%rax),%eax
    1e2e:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1e31:	72 65                	jb     1e98 <malloc+0xfa>
      if(p->s.size == nunits)
    1e33:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e37:	8b 40 08             	mov    0x8(%rax),%eax
    1e3a:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1e3d:	75 10                	jne    1e4f <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1e3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e43:	48 8b 10             	mov    (%rax),%rdx
    1e46:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e4a:	48 89 10             	mov    %rdx,(%rax)
    1e4d:	eb 2e                	jmp    1e7d <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1e4f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e53:	8b 40 08             	mov    0x8(%rax),%eax
    1e56:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e59:	89 c2                	mov    %eax,%edx
    1e5b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e5f:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1e62:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e66:	8b 40 08             	mov    0x8(%rax),%eax
    1e69:	89 c0                	mov    %eax,%eax
    1e6b:	48 c1 e0 04          	shl    $0x4,%rax
    1e6f:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1e73:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e77:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e7a:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1e7d:	48 ba 50 1f 00 00 00 	movabs $0x1f50,%rdx
    1e84:	00 00 00 
    1e87:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e8b:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1e8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e92:	48 83 c0 10          	add    $0x10,%rax
    1e96:	eb 4e                	jmp    1ee6 <malloc+0x148>
    }
    if(p == freep)
    1e98:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1e9f:	00 00 00 
    1ea2:	48 8b 00             	mov    (%rax),%rax
    1ea5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ea9:	75 23                	jne    1ece <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1eab:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1eae:	89 c7                	mov    %eax,%edi
    1eb0:	48 b8 23 1d 00 00 00 	movabs $0x1d23,%rax
    1eb7:	00 00 00 
    1eba:	ff d0                	call   *%rax
    1ebc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ec0:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1ec5:	75 07                	jne    1ece <malloc+0x130>
        return 0;
    1ec7:	b8 00 00 00 00       	mov    $0x0,%eax
    1ecc:	eb 18                	jmp    1ee6 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ece:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ed2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ed6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eda:	48 8b 00             	mov    (%rax),%rax
    1edd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ee1:	e9 41 ff ff ff       	jmp    1e27 <malloc+0x89>
  }
}
    1ee6:	c9                   	leave
    1ee7:	c3                   	ret
