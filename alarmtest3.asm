
_alarmtest3:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <dummy>:
#include "types.h"
#include "user.h"

int snoozetime = 5;
void dummy()
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "This function is only here so snooze doesn't end up at address 0!\n");
    1004:	48 b8 a0 1e 00 00 00 	movabs $0x1ea0,%rax
    100b:	00 00 00 
    100e:	48 89 c6             	mov    %rax,%rsi
    1011:	bf 01 00 00 00       	mov    $0x1,%edi
    1016:	b8 00 00 00 00       	mov    $0x0,%eax
    101b:	48 ba 7e 17 00 00 00 	movabs $0x177e,%rdx
    1022:	00 00 00 
    1025:	ff d2                	call   *%rdx
}
    1027:	90                   	nop
    1028:	5d                   	pop    %rbp
    1029:	c3                   	ret

000000000000102a <snooze>:

void snooze(int signum)
{
    102a:	55                   	push   %rbp
    102b:	48 89 e5             	mov    %rsp,%rbp
    102e:	48 83 ec 10          	sub    $0x10,%rsp
    1032:	89 7d fc             	mov    %edi,-0x4(%rbp)
  printf(1, "Yawn... another %d seconds?\n", snoozetime--);
    1035:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    103c:	00 00 00 
    103f:	8b 00                	mov    (%rax),%eax
    1041:	8d 50 ff             	lea    -0x1(%rax),%edx
    1044:	48 b9 20 1f 00 00 00 	movabs $0x1f20,%rcx
    104b:	00 00 00 
    104e:	89 11                	mov    %edx,(%rcx)
    1050:	48 b9 e3 1e 00 00 00 	movabs $0x1ee3,%rcx
    1057:	00 00 00 
    105a:	89 c2                	mov    %eax,%edx
    105c:	48 89 ce             	mov    %rcx,%rsi
    105f:	bf 01 00 00 00       	mov    $0x1,%edi
    1064:	b8 00 00 00 00       	mov    $0x0,%eax
    1069:	48 b9 7e 17 00 00 00 	movabs $0x177e,%rcx
    1070:	00 00 00 
    1073:	ff d1                	call   *%rcx
  if (snoozetime == 0)
    1075:	48 b8 20 1f 00 00 00 	movabs $0x1f20,%rax
    107c:	00 00 00 
    107f:	8b 00                	mov    (%rax),%eax
    1081:	85 c0                	test   %eax,%eax
    1083:	75 16                	jne    109b <snooze+0x71>
    signal(14, 0);
    1085:	be 00 00 00 00       	mov    $0x0,%esi
    108a:	bf 0e 00 00 00       	mov    $0xe,%edi
    108f:	48 b8 81 15 00 00 00 	movabs $0x1581,%rax
    1096:	00 00 00 
    1099:	ff d0                	call   *%rax
  alarm(1);
    109b:	bf 01 00 00 00       	mov    $0x1,%edi
    10a0:	48 b8 74 15 00 00 00 	movabs $0x1574,%rax
    10a7:	00 00 00 
    10aa:	ff d0                	call   *%rax
}
    10ac:	90                   	nop
    10ad:	c9                   	leave
    10ae:	c3                   	ret

00000000000010af <main>:

int main(int argc, char **argv)
{
    10af:	55                   	push   %rbp
    10b0:	48 89 e5             	mov    %rsp,%rbp
    10b3:	48 83 ec 20          	sub    $0x20,%rsp
    10b7:	89 7d ec             	mov    %edi,-0x14(%rbp)
    10ba:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  fgproc();
    10be:	48 b8 9b 15 00 00 00 	movabs $0x159b,%rax
    10c5:	00 00 00 
    10c8:	ff d0                	call   *%rax
  signal(14, snooze);
    10ca:	48 b8 2a 10 00 00 00 	movabs $0x102a,%rax
    10d1:	00 00 00 
    10d4:	48 89 c6             	mov    %rax,%rsi
    10d7:	bf 0e 00 00 00       	mov    $0xe,%edi
    10dc:	48 b8 81 15 00 00 00 	movabs $0x1581,%rax
    10e3:	00 00 00 
    10e6:	ff d0                	call   *%rax
  alarm(3);
    10e8:	bf 03 00 00 00       	mov    $0x3,%edi
    10ed:	48 b8 74 15 00 00 00 	movabs $0x1574,%rax
    10f4:	00 00 00 
    10f7:	ff d0                	call   *%rax

  int i = 0;
    10f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while (i++ < 100)
    1100:	eb 39                	jmp    113b <main+0x8c>
  {
    printf(1, "Looping... %d\n", i);
    1102:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1105:	48 b9 00 1f 00 00 00 	movabs $0x1f00,%rcx
    110c:	00 00 00 
    110f:	89 c2                	mov    %eax,%edx
    1111:	48 89 ce             	mov    %rcx,%rsi
    1114:	bf 01 00 00 00       	mov    $0x1,%edi
    1119:	b8 00 00 00 00       	mov    $0x0,%eax
    111e:	48 b9 7e 17 00 00 00 	movabs $0x177e,%rcx
    1125:	00 00 00 
    1128:	ff d1                	call   *%rcx
    sleep(100);
    112a:	bf 64 00 00 00       	mov    $0x64,%edi
    112f:	48 b8 5a 15 00 00 00 	movabs $0x155a,%rax
    1136:	00 00 00 
    1139:	ff d0                	call   *%rax
  while (i++ < 100)
    113b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    113e:	8d 50 01             	lea    0x1(%rax),%edx
    1141:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1144:	83 f8 63             	cmp    $0x63,%eax
    1147:	7e b9                	jle    1102 <main+0x53>
  }
  exit();
    1149:	48 b8 70 14 00 00 00 	movabs $0x1470,%rax
    1150:	00 00 00 
    1153:	ff d0                	call   *%rax

0000000000001155 <stosb>:
  asm volatile("cld; rep outsl" : "=S"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1155:	55                   	push   %rbp
    1156:	48 89 e5             	mov    %rsp,%rbp
    1159:	48 83 ec 10          	sub    $0x10,%rsp
    115d:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1161:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1164:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
    1167:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    116b:	8b 55 f0             	mov    -0x10(%rbp),%edx
    116e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1171:	48 89 ce             	mov    %rcx,%rsi
    1174:	48 89 f7             	mov    %rsi,%rdi
    1177:	89 d1                	mov    %edx,%ecx
    1179:	fc                   	cld
    117a:	f3 aa                	rep stos %al,(%rdi)
    117c:	89 ca                	mov    %ecx,%edx
    117e:	48 89 fe             	mov    %rdi,%rsi
    1181:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1185:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
    1188:	90                   	nop
    1189:	c9                   	leave
    118a:	c3                   	ret

000000000000118b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    118b:	55                   	push   %rbp
    118c:	48 89 e5             	mov    %rsp,%rbp
    118f:	48 83 ec 20          	sub    $0x20,%rsp
    1193:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1197:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    119b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    119f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    11a3:	90                   	nop
    11a4:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    11a8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    11ac:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    11b0:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    11b4:	48 8d 48 01          	lea    0x1(%rax),%rcx
    11b8:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    11bc:	0f b6 12             	movzbl (%rdx),%edx
    11bf:	88 10                	mov    %dl,(%rax)
    11c1:	0f b6 00             	movzbl (%rax),%eax
    11c4:	84 c0                	test   %al,%al
    11c6:	75 dc                	jne    11a4 <strcpy+0x19>
    ;
  return os;
    11c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11cc:	c9                   	leave
    11cd:	c3                   	ret

00000000000011ce <strcmp>:

int
strcmp(const char *p, const char *q)
{
    11ce:	55                   	push   %rbp
    11cf:	48 89 e5             	mov    %rsp,%rbp
    11d2:	48 83 ec 10          	sub    $0x10,%rsp
    11d6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11da:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    11de:	eb 0a                	jmp    11ea <strcmp+0x1c>
    p++, q++;
    11e0:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11e5:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    11ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ee:	0f b6 00             	movzbl (%rax),%eax
    11f1:	84 c0                	test   %al,%al
    11f3:	74 12                	je     1207 <strcmp+0x39>
    11f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11f9:	0f b6 10             	movzbl (%rax),%edx
    11fc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1200:	0f b6 00             	movzbl (%rax),%eax
    1203:	38 c2                	cmp    %al,%dl
    1205:	74 d9                	je     11e0 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1207:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    120b:	0f b6 00             	movzbl (%rax),%eax
    120e:	0f b6 d0             	movzbl %al,%edx
    1211:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1215:	0f b6 00             	movzbl (%rax),%eax
    1218:	0f b6 c0             	movzbl %al,%eax
    121b:	29 c2                	sub    %eax,%edx
    121d:	89 d0                	mov    %edx,%eax
}
    121f:	c9                   	leave
    1220:	c3                   	ret

0000000000001221 <strlen>:

uint
strlen(char *s)
{
    1221:	55                   	push   %rbp
    1222:	48 89 e5             	mov    %rsp,%rbp
    1225:	48 83 ec 18          	sub    $0x18,%rsp
    1229:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    122d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1234:	eb 04                	jmp    123a <strlen+0x19>
    1236:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    123a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    123d:	48 63 d0             	movslq %eax,%rdx
    1240:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1244:	48 01 d0             	add    %rdx,%rax
    1247:	0f b6 00             	movzbl (%rax),%eax
    124a:	84 c0                	test   %al,%al
    124c:	75 e8                	jne    1236 <strlen+0x15>
    ;
  return n;
    124e:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1251:	c9                   	leave
    1252:	c3                   	ret

0000000000001253 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1253:	55                   	push   %rbp
    1254:	48 89 e5             	mov    %rsp,%rbp
    1257:	48 83 ec 10          	sub    $0x10,%rsp
    125b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    125f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1262:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1265:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1268:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    126b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    126f:	89 ce                	mov    %ecx,%esi
    1271:	48 89 c7             	mov    %rax,%rdi
    1274:	48 b8 55 11 00 00 00 	movabs $0x1155,%rax
    127b:	00 00 00 
    127e:	ff d0                	call   *%rax
  return dst;
    1280:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1284:	c9                   	leave
    1285:	c3                   	ret

0000000000001286 <strchr>:

char*
strchr(const char *s, char c)
{
    1286:	55                   	push   %rbp
    1287:	48 89 e5             	mov    %rsp,%rbp
    128a:	48 83 ec 10          	sub    $0x10,%rsp
    128e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1292:	89 f0                	mov    %esi,%eax
    1294:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    1297:	eb 17                	jmp    12b0 <strchr+0x2a>
    if(*s == c)
    1299:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    129d:	0f b6 00             	movzbl (%rax),%eax
    12a0:	38 45 f4             	cmp    %al,-0xc(%rbp)
    12a3:	75 06                	jne    12ab <strchr+0x25>
      return (char*)s;
    12a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12a9:	eb 15                	jmp    12c0 <strchr+0x3a>
  for(; *s; s++)
    12ab:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    12b0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12b4:	0f b6 00             	movzbl (%rax),%eax
    12b7:	84 c0                	test   %al,%al
    12b9:	75 de                	jne    1299 <strchr+0x13>
  return 0;
    12bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12c0:	c9                   	leave
    12c1:	c3                   	ret

00000000000012c2 <gets>:

char*
gets(char *buf, int max)
{
    12c2:	55                   	push   %rbp
    12c3:	48 89 e5             	mov    %rsp,%rbp
    12c6:	48 83 ec 20          	sub    $0x20,%rsp
    12ca:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    12ce:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    12d8:	eb 4f                	jmp    1329 <gets+0x67>
    cc = read(0, &c, 1);
    12da:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    12de:	ba 01 00 00 00       	mov    $0x1,%edx
    12e3:	48 89 c6             	mov    %rax,%rsi
    12e6:	bf 00 00 00 00       	mov    $0x0,%edi
    12eb:	48 b8 97 14 00 00 00 	movabs $0x1497,%rax
    12f2:	00 00 00 
    12f5:	ff d0                	call   *%rax
    12f7:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    12fa:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    12fe:	7e 36                	jle    1336 <gets+0x74>
      break;
    buf[i++] = c;
    1300:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1303:	8d 50 01             	lea    0x1(%rax),%edx
    1306:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1309:	48 63 d0             	movslq %eax,%rdx
    130c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1310:	48 01 c2             	add    %rax,%rdx
    1313:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1317:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1319:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    131d:	3c 0a                	cmp    $0xa,%al
    131f:	74 16                	je     1337 <gets+0x75>
    1321:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1325:	3c 0d                	cmp    $0xd,%al
    1327:	74 0e                	je     1337 <gets+0x75>
  for(i=0; i+1 < max; ){
    1329:	8b 45 fc             	mov    -0x4(%rbp),%eax
    132c:	83 c0 01             	add    $0x1,%eax
    132f:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1332:	7f a6                	jg     12da <gets+0x18>
    1334:	eb 01                	jmp    1337 <gets+0x75>
      break;
    1336:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1337:	8b 45 fc             	mov    -0x4(%rbp),%eax
    133a:	48 63 d0             	movslq %eax,%rdx
    133d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1341:	48 01 d0             	add    %rdx,%rax
    1344:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1347:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    134b:	c9                   	leave
    134c:	c3                   	ret

000000000000134d <stat>:

int
stat(char *n, struct stat *st)
{
    134d:	55                   	push   %rbp
    134e:	48 89 e5             	mov    %rsp,%rbp
    1351:	48 83 ec 20          	sub    $0x20,%rsp
    1355:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1359:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    135d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1361:	be 00 00 00 00       	mov    $0x0,%esi
    1366:	48 89 c7             	mov    %rax,%rdi
    1369:	48 b8 d8 14 00 00 00 	movabs $0x14d8,%rax
    1370:	00 00 00 
    1373:	ff d0                	call   *%rax
    1375:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1378:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    137c:	79 07                	jns    1385 <stat+0x38>
    return -1;
    137e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1383:	eb 2f                	jmp    13b4 <stat+0x67>
  r = fstat(fd, st);
    1385:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1389:	8b 45 fc             	mov    -0x4(%rbp),%eax
    138c:	48 89 d6             	mov    %rdx,%rsi
    138f:	89 c7                	mov    %eax,%edi
    1391:	48 b8 ff 14 00 00 00 	movabs $0x14ff,%rax
    1398:	00 00 00 
    139b:	ff d0                	call   *%rax
    139d:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    13a0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    13a3:	89 c7                	mov    %eax,%edi
    13a5:	48 b8 b1 14 00 00 00 	movabs $0x14b1,%rax
    13ac:	00 00 00 
    13af:	ff d0                	call   *%rax
  return r;
    13b1:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    13b4:	c9                   	leave
    13b5:	c3                   	ret

00000000000013b6 <atoi>:

int
atoi(const char *s)
{
    13b6:	55                   	push   %rbp
    13b7:	48 89 e5             	mov    %rsp,%rbp
    13ba:	48 83 ec 18          	sub    $0x18,%rsp
    13be:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    13c2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    13c9:	eb 28                	jmp    13f3 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    13cb:	8b 55 fc             	mov    -0x4(%rbp),%edx
    13ce:	89 d0                	mov    %edx,%eax
    13d0:	c1 e0 02             	shl    $0x2,%eax
    13d3:	01 d0                	add    %edx,%eax
    13d5:	01 c0                	add    %eax,%eax
    13d7:	89 c1                	mov    %eax,%ecx
    13d9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13dd:	48 8d 50 01          	lea    0x1(%rax),%rdx
    13e1:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    13e5:	0f b6 00             	movzbl (%rax),%eax
    13e8:	0f be c0             	movsbl %al,%eax
    13eb:	01 c8                	add    %ecx,%eax
    13ed:	83 e8 30             	sub    $0x30,%eax
    13f0:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    13f3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    13f7:	0f b6 00             	movzbl (%rax),%eax
    13fa:	3c 2f                	cmp    $0x2f,%al
    13fc:	7e 0b                	jle    1409 <atoi+0x53>
    13fe:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1402:	0f b6 00             	movzbl (%rax),%eax
    1405:	3c 39                	cmp    $0x39,%al
    1407:	7e c2                	jle    13cb <atoi+0x15>
  return n;
    1409:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    140c:	c9                   	leave
    140d:	c3                   	ret

000000000000140e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    140e:	55                   	push   %rbp
    140f:	48 89 e5             	mov    %rsp,%rbp
    1412:	48 83 ec 28          	sub    $0x28,%rsp
    1416:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    141a:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    141e:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1421:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1425:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1429:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    142d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1431:	eb 1d                	jmp    1450 <memmove+0x42>
    *dst++ = *src++;
    1433:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1437:	48 8d 42 01          	lea    0x1(%rdx),%rax
    143b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    143f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1443:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1447:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    144b:	0f b6 12             	movzbl (%rdx),%edx
    144e:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1450:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1453:	8d 50 ff             	lea    -0x1(%rax),%edx
    1456:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1459:	85 c0                	test   %eax,%eax
    145b:	7f d6                	jg     1433 <memmove+0x25>
  return vdst;
    145d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1461:	c9                   	leave
    1462:	c3                   	ret

0000000000001463 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1463:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    146a:	49 89 ca             	mov    %rcx,%r10
    146d:	0f 05                	syscall
    146f:	c3                   	ret

0000000000001470 <exit>:
SYSCALL(exit)
    1470:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1477:	49 89 ca             	mov    %rcx,%r10
    147a:	0f 05                	syscall
    147c:	c3                   	ret

000000000000147d <wait>:
SYSCALL(wait)
    147d:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1484:	49 89 ca             	mov    %rcx,%r10
    1487:	0f 05                	syscall
    1489:	c3                   	ret

000000000000148a <pipe>:
SYSCALL(pipe)
    148a:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    1491:	49 89 ca             	mov    %rcx,%r10
    1494:	0f 05                	syscall
    1496:	c3                   	ret

0000000000001497 <read>:
SYSCALL(read)
    1497:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    149e:	49 89 ca             	mov    %rcx,%r10
    14a1:	0f 05                	syscall
    14a3:	c3                   	ret

00000000000014a4 <write>:
SYSCALL(write)
    14a4:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    14ab:	49 89 ca             	mov    %rcx,%r10
    14ae:	0f 05                	syscall
    14b0:	c3                   	ret

00000000000014b1 <close>:
SYSCALL(close)
    14b1:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    14b8:	49 89 ca             	mov    %rcx,%r10
    14bb:	0f 05                	syscall
    14bd:	c3                   	ret

00000000000014be <kill>:
SYSCALL(kill)
    14be:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    14c5:	49 89 ca             	mov    %rcx,%r10
    14c8:	0f 05                	syscall
    14ca:	c3                   	ret

00000000000014cb <exec>:
SYSCALL(exec)
    14cb:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    14d2:	49 89 ca             	mov    %rcx,%r10
    14d5:	0f 05                	syscall
    14d7:	c3                   	ret

00000000000014d8 <open>:
SYSCALL(open)
    14d8:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    14df:	49 89 ca             	mov    %rcx,%r10
    14e2:	0f 05                	syscall
    14e4:	c3                   	ret

00000000000014e5 <mknod>:
SYSCALL(mknod)
    14e5:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    14ec:	49 89 ca             	mov    %rcx,%r10
    14ef:	0f 05                	syscall
    14f1:	c3                   	ret

00000000000014f2 <unlink>:
SYSCALL(unlink)
    14f2:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    14f9:	49 89 ca             	mov    %rcx,%r10
    14fc:	0f 05                	syscall
    14fe:	c3                   	ret

00000000000014ff <fstat>:
SYSCALL(fstat)
    14ff:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1506:	49 89 ca             	mov    %rcx,%r10
    1509:	0f 05                	syscall
    150b:	c3                   	ret

000000000000150c <link>:
SYSCALL(link)
    150c:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1513:	49 89 ca             	mov    %rcx,%r10
    1516:	0f 05                	syscall
    1518:	c3                   	ret

0000000000001519 <mkdir>:
SYSCALL(mkdir)
    1519:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1520:	49 89 ca             	mov    %rcx,%r10
    1523:	0f 05                	syscall
    1525:	c3                   	ret

0000000000001526 <chdir>:
SYSCALL(chdir)
    1526:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    152d:	49 89 ca             	mov    %rcx,%r10
    1530:	0f 05                	syscall
    1532:	c3                   	ret

0000000000001533 <dup>:
SYSCALL(dup)
    1533:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    153a:	49 89 ca             	mov    %rcx,%r10
    153d:	0f 05                	syscall
    153f:	c3                   	ret

0000000000001540 <getpid>:
SYSCALL(getpid)
    1540:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1547:	49 89 ca             	mov    %rcx,%r10
    154a:	0f 05                	syscall
    154c:	c3                   	ret

000000000000154d <sbrk>:
SYSCALL(sbrk)
    154d:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1554:	49 89 ca             	mov    %rcx,%r10
    1557:	0f 05                	syscall
    1559:	c3                   	ret

000000000000155a <sleep>:
SYSCALL(sleep)
    155a:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1561:	49 89 ca             	mov    %rcx,%r10
    1564:	0f 05                	syscall
    1566:	c3                   	ret

0000000000001567 <uptime>:
SYSCALL(uptime)
    1567:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    156e:	49 89 ca             	mov    %rcx,%r10
    1571:	0f 05                	syscall
    1573:	c3                   	ret

0000000000001574 <alarm>:

SYSCALL(alarm)
    1574:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    157b:	49 89 ca             	mov    %rcx,%r10
    157e:	0f 05                	syscall
    1580:	c3                   	ret

0000000000001581 <signal>:
SYSCALL(signal)
    1581:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1588:	49 89 ca             	mov    %rcx,%r10
    158b:	0f 05                	syscall
    158d:	c3                   	ret

000000000000158e <sigret>:
SYSCALL(sigret)
    158e:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    1595:	49 89 ca             	mov    %rcx,%r10
    1598:	0f 05                	syscall
    159a:	c3                   	ret

000000000000159b <fgproc>:
SYSCALL(fgproc)
    159b:	48 c7 c0 19 00 00 00 	mov    $0x19,%rax
    15a2:	49 89 ca             	mov    %rcx,%r10
    15a5:	0f 05                	syscall
    15a7:	c3                   	ret

00000000000015a8 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    15a8:	55                   	push   %rbp
    15a9:	48 89 e5             	mov    %rsp,%rbp
    15ac:	48 83 ec 10          	sub    $0x10,%rsp
    15b0:	89 7d fc             	mov    %edi,-0x4(%rbp)
    15b3:	89 f0                	mov    %esi,%eax
    15b5:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    15b8:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    15bc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15bf:	ba 01 00 00 00       	mov    $0x1,%edx
    15c4:	48 89 ce             	mov    %rcx,%rsi
    15c7:	89 c7                	mov    %eax,%edi
    15c9:	48 b8 a4 14 00 00 00 	movabs $0x14a4,%rax
    15d0:	00 00 00 
    15d3:	ff d0                	call   *%rax
}
    15d5:	90                   	nop
    15d6:	c9                   	leave
    15d7:	c3                   	ret

00000000000015d8 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    15d8:	55                   	push   %rbp
    15d9:	48 89 e5             	mov    %rsp,%rbp
    15dc:	48 83 ec 20          	sub    $0x20,%rsp
    15e0:	89 7d ec             	mov    %edi,-0x14(%rbp)
    15e3:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    15e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15ee:	eb 35                	jmp    1625 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    15f0:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    15f4:	48 c1 e8 3c          	shr    $0x3c,%rax
    15f8:	48 ba 30 1f 00 00 00 	movabs $0x1f30,%rdx
    15ff:	00 00 00 
    1602:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1606:	0f be d0             	movsbl %al,%edx
    1609:	8b 45 ec             	mov    -0x14(%rbp),%eax
    160c:	89 d6                	mov    %edx,%esi
    160e:	89 c7                	mov    %eax,%edi
    1610:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1617:	00 00 00 
    161a:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    161c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1620:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1625:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1628:	83 f8 0f             	cmp    $0xf,%eax
    162b:	76 c3                	jbe    15f0 <print_x64+0x18>
}
    162d:	90                   	nop
    162e:	90                   	nop
    162f:	c9                   	leave
    1630:	c3                   	ret

0000000000001631 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1631:	55                   	push   %rbp
    1632:	48 89 e5             	mov    %rsp,%rbp
    1635:	48 83 ec 20          	sub    $0x20,%rsp
    1639:	89 7d ec             	mov    %edi,-0x14(%rbp)
    163c:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    163f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1646:	eb 36                	jmp    167e <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1648:	8b 45 e8             	mov    -0x18(%rbp),%eax
    164b:	c1 e8 1c             	shr    $0x1c,%eax
    164e:	89 c2                	mov    %eax,%edx
    1650:	48 b8 30 1f 00 00 00 	movabs $0x1f30,%rax
    1657:	00 00 00 
    165a:	89 d2                	mov    %edx,%edx
    165c:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1660:	0f be d0             	movsbl %al,%edx
    1663:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1666:	89 d6                	mov    %edx,%esi
    1668:	89 c7                	mov    %eax,%edi
    166a:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1671:	00 00 00 
    1674:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1676:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    167a:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    167e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1681:	83 f8 07             	cmp    $0x7,%eax
    1684:	76 c2                	jbe    1648 <print_x32+0x17>
}
    1686:	90                   	nop
    1687:	90                   	nop
    1688:	c9                   	leave
    1689:	c3                   	ret

000000000000168a <print_d>:

  static void
print_d(int fd, int v)
{
    168a:	55                   	push   %rbp
    168b:	48 89 e5             	mov    %rsp,%rbp
    168e:	48 83 ec 30          	sub    $0x30,%rsp
    1692:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1695:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    1698:	8b 45 d8             	mov    -0x28(%rbp),%eax
    169b:	48 98                	cltq
    169d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    16a1:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    16a5:	79 04                	jns    16ab <print_d+0x21>
    x = -x;
    16a7:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    16ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    16b2:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    16b6:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    16bd:	66 66 66 
    16c0:	48 89 c8             	mov    %rcx,%rax
    16c3:	48 f7 ea             	imul   %rdx
    16c6:	48 c1 fa 02          	sar    $0x2,%rdx
    16ca:	48 89 c8             	mov    %rcx,%rax
    16cd:	48 c1 f8 3f          	sar    $0x3f,%rax
    16d1:	48 29 c2             	sub    %rax,%rdx
    16d4:	48 89 d0             	mov    %rdx,%rax
    16d7:	48 c1 e0 02          	shl    $0x2,%rax
    16db:	48 01 d0             	add    %rdx,%rax
    16de:	48 01 c0             	add    %rax,%rax
    16e1:	48 29 c1             	sub    %rax,%rcx
    16e4:	48 89 ca             	mov    %rcx,%rdx
    16e7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    16ea:	8d 48 01             	lea    0x1(%rax),%ecx
    16ed:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    16f0:	48 b9 30 1f 00 00 00 	movabs $0x1f30,%rcx
    16f7:	00 00 00 
    16fa:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    16fe:	48 98                	cltq
    1700:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1704:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1708:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    170f:	66 66 66 
    1712:	48 89 c8             	mov    %rcx,%rax
    1715:	48 f7 ea             	imul   %rdx
    1718:	48 89 d0             	mov    %rdx,%rax
    171b:	48 c1 f8 02          	sar    $0x2,%rax
    171f:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1723:	48 89 ca             	mov    %rcx,%rdx
    1726:	48 29 d0             	sub    %rdx,%rax
    1729:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    172d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1732:	0f 85 7a ff ff ff    	jne    16b2 <print_d+0x28>

  if (v < 0)
    1738:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    173c:	79 32                	jns    1770 <print_d+0xe6>
    buf[i++] = '-';
    173e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1741:	8d 50 01             	lea    0x1(%rax),%edx
    1744:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1747:	48 98                	cltq
    1749:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    174e:	eb 20                	jmp    1770 <print_d+0xe6>
    putc(fd, buf[i]);
    1750:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1753:	48 98                	cltq
    1755:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    175a:	0f be d0             	movsbl %al,%edx
    175d:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1760:	89 d6                	mov    %edx,%esi
    1762:	89 c7                	mov    %eax,%edi
    1764:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    176b:	00 00 00 
    176e:	ff d0                	call   *%rax
  while (--i >= 0)
    1770:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1774:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1778:	79 d6                	jns    1750 <print_d+0xc6>
}
    177a:	90                   	nop
    177b:	90                   	nop
    177c:	c9                   	leave
    177d:	c3                   	ret

000000000000177e <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    177e:	55                   	push   %rbp
    177f:	48 89 e5             	mov    %rsp,%rbp
    1782:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1789:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    178f:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1796:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    179d:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    17a4:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    17ab:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    17b2:	84 c0                	test   %al,%al
    17b4:	74 20                	je     17d6 <printf+0x58>
    17b6:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    17ba:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    17be:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    17c2:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    17c6:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    17ca:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    17ce:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    17d2:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    17d6:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    17dd:	00 00 00 
    17e0:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    17e7:	00 00 00 
    17ea:	48 8d 45 10          	lea    0x10(%rbp),%rax
    17ee:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    17f5:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    17fc:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1803:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    180a:	00 00 00 
    180d:	e9 60 03 00 00       	jmp    1b72 <printf+0x3f4>
    if (c != '%') {
    1812:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1819:	74 24                	je     183f <printf+0xc1>
      putc(fd, c);
    181b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1821:	0f be d0             	movsbl %al,%edx
    1824:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    182a:	89 d6                	mov    %edx,%esi
    182c:	89 c7                	mov    %eax,%edi
    182e:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1835:	00 00 00 
    1838:	ff d0                	call   *%rax
      continue;
    183a:	e9 2c 03 00 00       	jmp    1b6b <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    183f:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1846:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    184c:	48 63 d0             	movslq %eax,%rdx
    184f:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1856:	48 01 d0             	add    %rdx,%rax
    1859:	0f b6 00             	movzbl (%rax),%eax
    185c:	0f be c0             	movsbl %al,%eax
    185f:	25 ff 00 00 00       	and    $0xff,%eax
    1864:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    186a:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1871:	0f 84 2e 03 00 00    	je     1ba5 <printf+0x427>
      break;
    switch(c) {
    1877:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    187e:	0f 84 32 01 00 00    	je     19b6 <printf+0x238>
    1884:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    188b:	0f 8f a1 02 00 00    	jg     1b32 <printf+0x3b4>
    1891:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1898:	0f 84 d4 01 00 00    	je     1a72 <printf+0x2f4>
    189e:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    18a5:	0f 8f 87 02 00 00    	jg     1b32 <printf+0x3b4>
    18ab:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    18b2:	0f 84 5b 01 00 00    	je     1a13 <printf+0x295>
    18b8:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    18bf:	0f 8f 6d 02 00 00    	jg     1b32 <printf+0x3b4>
    18c5:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    18cc:	0f 84 87 00 00 00    	je     1959 <printf+0x1db>
    18d2:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    18d9:	0f 8f 53 02 00 00    	jg     1b32 <printf+0x3b4>
    18df:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    18e6:	0f 84 2b 02 00 00    	je     1b17 <printf+0x399>
    18ec:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    18f3:	0f 85 39 02 00 00    	jne    1b32 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    18f9:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18ff:	83 f8 2f             	cmp    $0x2f,%eax
    1902:	77 23                	ja     1927 <printf+0x1a9>
    1904:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    190b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1911:	89 d2                	mov    %edx,%edx
    1913:	48 01 d0             	add    %rdx,%rax
    1916:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    191c:	83 c2 08             	add    $0x8,%edx
    191f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1925:	eb 12                	jmp    1939 <printf+0x1bb>
    1927:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    192e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1932:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1939:	8b 00                	mov    (%rax),%eax
    193b:	0f be d0             	movsbl %al,%edx
    193e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1944:	89 d6                	mov    %edx,%esi
    1946:	89 c7                	mov    %eax,%edi
    1948:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    194f:	00 00 00 
    1952:	ff d0                	call   *%rax
      break;
    1954:	e9 12 02 00 00       	jmp    1b6b <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1959:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    195f:	83 f8 2f             	cmp    $0x2f,%eax
    1962:	77 23                	ja     1987 <printf+0x209>
    1964:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    196b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1971:	89 d2                	mov    %edx,%edx
    1973:	48 01 d0             	add    %rdx,%rax
    1976:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    197c:	83 c2 08             	add    $0x8,%edx
    197f:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1985:	eb 12                	jmp    1999 <printf+0x21b>
    1987:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    198e:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1992:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1999:	8b 10                	mov    (%rax),%edx
    199b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19a1:	89 d6                	mov    %edx,%esi
    19a3:	89 c7                	mov    %eax,%edi
    19a5:	48 b8 8a 16 00 00 00 	movabs $0x168a,%rax
    19ac:	00 00 00 
    19af:	ff d0                	call   *%rax
      break;
    19b1:	e9 b5 01 00 00       	jmp    1b6b <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    19b6:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    19bc:	83 f8 2f             	cmp    $0x2f,%eax
    19bf:	77 23                	ja     19e4 <printf+0x266>
    19c1:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19c8:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19ce:	89 d2                	mov    %edx,%edx
    19d0:	48 01 d0             	add    %rdx,%rax
    19d3:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19d9:	83 c2 08             	add    $0x8,%edx
    19dc:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19e2:	eb 12                	jmp    19f6 <printf+0x278>
    19e4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19eb:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19ef:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19f6:	8b 10                	mov    (%rax),%edx
    19f8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    19fe:	89 d6                	mov    %edx,%esi
    1a00:	89 c7                	mov    %eax,%edi
    1a02:	48 b8 31 16 00 00 00 	movabs $0x1631,%rax
    1a09:	00 00 00 
    1a0c:	ff d0                	call   *%rax
      break;
    1a0e:	e9 58 01 00 00       	jmp    1b6b <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1a13:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a19:	83 f8 2f             	cmp    $0x2f,%eax
    1a1c:	77 23                	ja     1a41 <printf+0x2c3>
    1a1e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a25:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a2b:	89 d2                	mov    %edx,%edx
    1a2d:	48 01 d0             	add    %rdx,%rax
    1a30:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a36:	83 c2 08             	add    $0x8,%edx
    1a39:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a3f:	eb 12                	jmp    1a53 <printf+0x2d5>
    1a41:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1a48:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1a4c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1a53:	48 8b 10             	mov    (%rax),%rdx
    1a56:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a5c:	48 89 d6             	mov    %rdx,%rsi
    1a5f:	89 c7                	mov    %eax,%edi
    1a61:	48 b8 d8 15 00 00 00 	movabs $0x15d8,%rax
    1a68:	00 00 00 
    1a6b:	ff d0                	call   *%rax
      break;
    1a6d:	e9 f9 00 00 00       	jmp    1b6b <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1a72:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1a78:	83 f8 2f             	cmp    $0x2f,%eax
    1a7b:	77 23                	ja     1aa0 <printf+0x322>
    1a7d:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1a84:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a8a:	89 d2                	mov    %edx,%edx
    1a8c:	48 01 d0             	add    %rdx,%rax
    1a8f:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1a95:	83 c2 08             	add    $0x8,%edx
    1a98:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1a9e:	eb 12                	jmp    1ab2 <printf+0x334>
    1aa0:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1aa7:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1aab:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ab2:	48 8b 00             	mov    (%rax),%rax
    1ab5:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1abc:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1ac3:	00 
    1ac4:	75 41                	jne    1b07 <printf+0x389>
        s = "(null)";
    1ac6:	48 b8 0f 1f 00 00 00 	movabs $0x1f0f,%rax
    1acd:	00 00 00 
    1ad0:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1ad7:	eb 2e                	jmp    1b07 <printf+0x389>
        putc(fd, *(s++));
    1ad9:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1ae0:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1ae4:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1aeb:	0f b6 00             	movzbl (%rax),%eax
    1aee:	0f be d0             	movsbl %al,%edx
    1af1:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1af7:	89 d6                	mov    %edx,%esi
    1af9:	89 c7                	mov    %eax,%edi
    1afb:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1b02:	00 00 00 
    1b05:	ff d0                	call   *%rax
      while (*s)
    1b07:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1b0e:	0f b6 00             	movzbl (%rax),%eax
    1b11:	84 c0                	test   %al,%al
    1b13:	75 c4                	jne    1ad9 <printf+0x35b>
      break;
    1b15:	eb 54                	jmp    1b6b <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1b17:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b1d:	be 25 00 00 00       	mov    $0x25,%esi
    1b22:	89 c7                	mov    %eax,%edi
    1b24:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1b2b:	00 00 00 
    1b2e:	ff d0                	call   *%rax
      break;
    1b30:	eb 39                	jmp    1b6b <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1b32:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b38:	be 25 00 00 00       	mov    $0x25,%esi
    1b3d:	89 c7                	mov    %eax,%edi
    1b3f:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1b46:	00 00 00 
    1b49:	ff d0                	call   *%rax
      putc(fd, c);
    1b4b:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b51:	0f be d0             	movsbl %al,%edx
    1b54:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b5a:	89 d6                	mov    %edx,%esi
    1b5c:	89 c7                	mov    %eax,%edi
    1b5e:	48 b8 a8 15 00 00 00 	movabs $0x15a8,%rax
    1b65:	00 00 00 
    1b68:	ff d0                	call   *%rax
      break;
    1b6a:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1b6b:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1b72:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1b78:	48 63 d0             	movslq %eax,%rdx
    1b7b:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1b82:	48 01 d0             	add    %rdx,%rax
    1b85:	0f b6 00             	movzbl (%rax),%eax
    1b88:	0f be c0             	movsbl %al,%eax
    1b8b:	25 ff 00 00 00       	and    $0xff,%eax
    1b90:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1b96:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b9d:	0f 85 6f fc ff ff    	jne    1812 <printf+0x94>
    }
  }
}
    1ba3:	eb 01                	jmp    1ba6 <printf+0x428>
      break;
    1ba5:	90                   	nop
}
    1ba6:	90                   	nop
    1ba7:	c9                   	leave
    1ba8:	c3                   	ret

0000000000001ba9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1ba9:	55                   	push   %rbp
    1baa:	48 89 e5             	mov    %rsp,%rbp
    1bad:	48 83 ec 18          	sub    $0x18,%rsp
    1bb1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1bb5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1bb9:	48 83 e8 10          	sub    $0x10,%rax
    1bbd:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1bc1:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1bc8:	00 00 00 
    1bcb:	48 8b 00             	mov    (%rax),%rax
    1bce:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1bd2:	eb 2f                	jmp    1c03 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1bd4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd8:	48 8b 00             	mov    (%rax),%rax
    1bdb:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1bdf:	72 17                	jb     1bf8 <free+0x4f>
    1be1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1be5:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1be9:	72 2f                	jb     1c1a <free+0x71>
    1beb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bef:	48 8b 00             	mov    (%rax),%rax
    1bf2:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bf6:	72 22                	jb     1c1a <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1bf8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bfc:	48 8b 00             	mov    (%rax),%rax
    1bff:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1c03:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c07:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1c0b:	73 c7                	jae    1bd4 <free+0x2b>
    1c0d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c11:	48 8b 00             	mov    (%rax),%rax
    1c14:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c18:	73 ba                	jae    1bd4 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c1a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c1e:	8b 40 08             	mov    0x8(%rax),%eax
    1c21:	89 c0                	mov    %eax,%eax
    1c23:	48 c1 e0 04          	shl    $0x4,%rax
    1c27:	48 89 c2             	mov    %rax,%rdx
    1c2a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c2e:	48 01 c2             	add    %rax,%rdx
    1c31:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c35:	48 8b 00             	mov    (%rax),%rax
    1c38:	48 39 c2             	cmp    %rax,%rdx
    1c3b:	75 2d                	jne    1c6a <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1c3d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c41:	8b 50 08             	mov    0x8(%rax),%edx
    1c44:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c48:	48 8b 00             	mov    (%rax),%rax
    1c4b:	8b 40 08             	mov    0x8(%rax),%eax
    1c4e:	01 c2                	add    %eax,%edx
    1c50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c54:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1c57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c5b:	48 8b 00             	mov    (%rax),%rax
    1c5e:	48 8b 10             	mov    (%rax),%rdx
    1c61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c65:	48 89 10             	mov    %rdx,(%rax)
    1c68:	eb 0e                	jmp    1c78 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1c6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c6e:	48 8b 10             	mov    (%rax),%rdx
    1c71:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c75:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1c78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c7c:	8b 40 08             	mov    0x8(%rax),%eax
    1c7f:	89 c0                	mov    %eax,%eax
    1c81:	48 c1 e0 04          	shl    $0x4,%rax
    1c85:	48 89 c2             	mov    %rax,%rdx
    1c88:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c8c:	48 01 d0             	add    %rdx,%rax
    1c8f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1c93:	75 27                	jne    1cbc <free+0x113>
    p->s.size += bp->s.size;
    1c95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c99:	8b 50 08             	mov    0x8(%rax),%edx
    1c9c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ca0:	8b 40 08             	mov    0x8(%rax),%eax
    1ca3:	01 c2                	add    %eax,%edx
    1ca5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ca9:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1cac:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb0:	48 8b 10             	mov    (%rax),%rdx
    1cb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cb7:	48 89 10             	mov    %rdx,(%rax)
    1cba:	eb 0b                	jmp    1cc7 <free+0x11e>
  } else
    p->s.ptr = bp;
    1cbc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cc0:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1cc4:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1cc7:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1cce:	00 00 00 
    1cd1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cd5:	48 89 02             	mov    %rax,(%rdx)
}
    1cd8:	90                   	nop
    1cd9:	c9                   	leave
    1cda:	c3                   	ret

0000000000001cdb <morecore>:

static Header*
morecore(uint nu)
{
    1cdb:	55                   	push   %rbp
    1cdc:	48 89 e5             	mov    %rsp,%rbp
    1cdf:	48 83 ec 20          	sub    $0x20,%rsp
    1ce3:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1ce6:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1ced:	77 07                	ja     1cf6 <morecore+0x1b>
    nu = 4096;
    1cef:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1cf6:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1cf9:	48 c1 e0 04          	shl    $0x4,%rax
    1cfd:	48 89 c7             	mov    %rax,%rdi
    1d00:	48 b8 4d 15 00 00 00 	movabs $0x154d,%rax
    1d07:	00 00 00 
    1d0a:	ff d0                	call   *%rax
    1d0c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1d10:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1d15:	75 07                	jne    1d1e <morecore+0x43>
    return 0;
    1d17:	b8 00 00 00 00       	mov    $0x0,%eax
    1d1c:	eb 36                	jmp    1d54 <morecore+0x79>
  hp = (Header*)p;
    1d1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d22:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1d26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d2a:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d2d:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1d30:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d34:	48 83 c0 10          	add    $0x10,%rax
    1d38:	48 89 c7             	mov    %rax,%rdi
    1d3b:	48 b8 a9 1b 00 00 00 	movabs $0x1ba9,%rax
    1d42:	00 00 00 
    1d45:	ff d0                	call   *%rax
  return freep;
    1d47:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1d4e:	00 00 00 
    1d51:	48 8b 00             	mov    (%rax),%rax
}
    1d54:	c9                   	leave
    1d55:	c3                   	ret

0000000000001d56 <malloc>:

void*
malloc(uint nbytes)
{
    1d56:	55                   	push   %rbp
    1d57:	48 89 e5             	mov    %rsp,%rbp
    1d5a:	48 83 ec 30          	sub    $0x30,%rsp
    1d5e:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1d61:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1d64:	48 83 c0 0f          	add    $0xf,%rax
    1d68:	48 c1 e8 04          	shr    $0x4,%rax
    1d6c:	83 c0 01             	add    $0x1,%eax
    1d6f:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1d72:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1d79:	00 00 00 
    1d7c:	48 8b 00             	mov    (%rax),%rax
    1d7f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d83:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1d88:	75 4a                	jne    1dd4 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1d8a:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1d91:	00 00 00 
    1d94:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d98:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1d9f:	00 00 00 
    1da2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1da6:	48 89 02             	mov    %rax,(%rdx)
    1da9:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1db0:	00 00 00 
    1db3:	48 8b 00             	mov    (%rax),%rax
    1db6:	48 ba 50 1f 00 00 00 	movabs $0x1f50,%rdx
    1dbd:	00 00 00 
    1dc0:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1dc3:	48 b8 50 1f 00 00 00 	movabs $0x1f50,%rax
    1dca:	00 00 00 
    1dcd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1dd4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1dd8:	48 8b 00             	mov    (%rax),%rax
    1ddb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ddf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1de3:	8b 40 08             	mov    0x8(%rax),%eax
    1de6:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1de9:	72 65                	jb     1e50 <malloc+0xfa>
      if(p->s.size == nunits)
    1deb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1def:	8b 40 08             	mov    0x8(%rax),%eax
    1df2:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1df5:	75 10                	jne    1e07 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1df7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1dfb:	48 8b 10             	mov    (%rax),%rdx
    1dfe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e02:	48 89 10             	mov    %rdx,(%rax)
    1e05:	eb 2e                	jmp    1e35 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1e07:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e0b:	8b 40 08             	mov    0x8(%rax),%eax
    1e0e:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1e11:	89 c2                	mov    %eax,%edx
    1e13:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e17:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1e1a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e1e:	8b 40 08             	mov    0x8(%rax),%eax
    1e21:	89 c0                	mov    %eax,%eax
    1e23:	48 c1 e0 04          	shl    $0x4,%rax
    1e27:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1e2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e2f:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1e32:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1e35:	48 ba 60 1f 00 00 00 	movabs $0x1f60,%rdx
    1e3c:	00 00 00 
    1e3f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1e43:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1e46:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e4a:	48 83 c0 10          	add    $0x10,%rax
    1e4e:	eb 4e                	jmp    1e9e <malloc+0x148>
    }
    if(p == freep)
    1e50:	48 b8 60 1f 00 00 00 	movabs $0x1f60,%rax
    1e57:	00 00 00 
    1e5a:	48 8b 00             	mov    (%rax),%rax
    1e5d:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1e61:	75 23                	jne    1e86 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1e63:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1e66:	89 c7                	mov    %eax,%edi
    1e68:	48 b8 db 1c 00 00 00 	movabs $0x1cdb,%rax
    1e6f:	00 00 00 
    1e72:	ff d0                	call   *%rax
    1e74:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1e78:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1e7d:	75 07                	jne    1e86 <malloc+0x130>
        return 0;
    1e7f:	b8 00 00 00 00       	mov    $0x0,%eax
    1e84:	eb 18                	jmp    1e9e <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e8a:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1e8e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1e92:	48 8b 00             	mov    (%rax),%rax
    1e95:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1e99:	e9 41 ff ff ff       	jmp    1ddf <malloc+0x89>
  }
}
    1e9e:	c9                   	leave
    1e9f:	c3                   	ret
