
_kill:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 20          	sub    $0x20,%rsp
    1008:	89 7d ec             	mov    %edi,-0x14(%rbp)
    100b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  if(argc < 2){
    100f:	83 7d ec 01          	cmpl   $0x1,-0x14(%rbp)
    1013:	7f 2f                	jg     1044 <main+0x44>
    printf(2, "usage: kill pid...\n");
    1015:	48 b8 bd 1d 00 00 00 	movabs $0x1dbd,%rax
    101c:	00 00 00 
    101f:	48 89 c6             	mov    %rax,%rsi
    1022:	bf 02 00 00 00       	mov    $0x2,%edi
    1027:	b8 00 00 00 00       	mov    $0x0,%eax
    102c:	48 ba 9b 16 00 00 00 	movabs $0x169b,%rdx
    1033:	00 00 00 
    1036:	ff d2                	call   *%rdx
    exit();
    1038:	48 b8 b4 13 00 00 00 	movabs $0x13b4,%rax
    103f:	00 00 00 
    1042:	ff d0                	call   *%rax
  }
  for(i=1; i<argc; i++)
    1044:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    104b:	eb 38                	jmp    1085 <main+0x85>
    kill(atoi(argv[i]));
    104d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1050:	48 98                	cltq
    1052:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1059:	00 
    105a:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    105e:	48 01 d0             	add    %rdx,%rax
    1061:	48 8b 00             	mov    (%rax),%rax
    1064:	48 89 c7             	mov    %rax,%rdi
    1067:	48 b8 fa 12 00 00 00 	movabs $0x12fa,%rax
    106e:	00 00 00 
    1071:	ff d0                	call   *%rax
    1073:	89 c7                	mov    %eax,%edi
    1075:	48 b8 02 14 00 00 00 	movabs $0x1402,%rax
    107c:	00 00 00 
    107f:	ff d0                	call   *%rax
  for(i=1; i<argc; i++)
    1081:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1085:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1088:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    108b:	7c c0                	jl     104d <main+0x4d>
  exit();
    108d:	48 b8 b4 13 00 00 00 	movabs $0x13b4,%rax
    1094:	00 00 00 
    1097:	ff d0                	call   *%rax

0000000000001099 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1099:	55                   	push   %rbp
    109a:	48 89 e5             	mov    %rsp,%rbp
    109d:	48 83 ec 10          	sub    $0x10,%rsp
    10a1:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10a5:	89 75 f4             	mov    %esi,-0xc(%rbp)
    10a8:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    10ab:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10af:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10b2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10b5:	48 89 ce             	mov    %rcx,%rsi
    10b8:	48 89 f7             	mov    %rsi,%rdi
    10bb:	89 d1                	mov    %edx,%ecx
    10bd:	fc                   	cld
    10be:	f3 aa                	rep stos %al,(%rdi)
    10c0:	89 ca                	mov    %ecx,%edx
    10c2:	48 89 fe             	mov    %rdi,%rsi
    10c5:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10c9:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10cc:	90                   	nop
    10cd:	c9                   	leave
    10ce:	c3                   	ret

00000000000010cf <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10cf:	55                   	push   %rbp
    10d0:	48 89 e5             	mov    %rsp,%rbp
    10d3:	48 83 ec 20          	sub    $0x20,%rsp
    10d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10db:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    10df:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10e3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    10e7:	90                   	nop
    10e8:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    10ec:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10f0:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10f4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10f8:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10fc:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    1100:	0f b6 12             	movzbl (%rdx),%edx
    1103:	88 10                	mov    %dl,(%rax)
    1105:	0f b6 00             	movzbl (%rax),%eax
    1108:	84 c0                	test   %al,%al
    110a:	75 dc                	jne    10e8 <strcpy+0x19>
    ;
  return os;
    110c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1110:	c9                   	leave
    1111:	c3                   	ret

0000000000001112 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1112:	55                   	push   %rbp
    1113:	48 89 e5             	mov    %rsp,%rbp
    1116:	48 83 ec 10          	sub    $0x10,%rsp
    111a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    111e:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1122:	eb 0a                	jmp    112e <strcmp+0x1c>
    p++, q++;
    1124:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    1129:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    112e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1132:	0f b6 00             	movzbl (%rax),%eax
    1135:	84 c0                	test   %al,%al
    1137:	74 12                	je     114b <strcmp+0x39>
    1139:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    113d:	0f b6 10             	movzbl (%rax),%edx
    1140:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1144:	0f b6 00             	movzbl (%rax),%eax
    1147:	38 c2                	cmp    %al,%dl
    1149:	74 d9                	je     1124 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    114b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    114f:	0f b6 00             	movzbl (%rax),%eax
    1152:	0f b6 d0             	movzbl %al,%edx
    1155:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1159:	0f b6 00             	movzbl (%rax),%eax
    115c:	0f b6 c0             	movzbl %al,%eax
    115f:	29 c2                	sub    %eax,%edx
    1161:	89 d0                	mov    %edx,%eax
}
    1163:	c9                   	leave
    1164:	c3                   	ret

0000000000001165 <strlen>:

uint
strlen(char *s)
{
    1165:	55                   	push   %rbp
    1166:	48 89 e5             	mov    %rsp,%rbp
    1169:	48 83 ec 18          	sub    $0x18,%rsp
    116d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1171:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1178:	eb 04                	jmp    117e <strlen+0x19>
    117a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    117e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1181:	48 63 d0             	movslq %eax,%rdx
    1184:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1188:	48 01 d0             	add    %rdx,%rax
    118b:	0f b6 00             	movzbl (%rax),%eax
    118e:	84 c0                	test   %al,%al
    1190:	75 e8                	jne    117a <strlen+0x15>
    ;
  return n;
    1192:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1195:	c9                   	leave
    1196:	c3                   	ret

0000000000001197 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1197:	55                   	push   %rbp
    1198:	48 89 e5             	mov    %rsp,%rbp
    119b:	48 83 ec 10          	sub    $0x10,%rsp
    119f:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11a3:	89 75 f4             	mov    %esi,-0xc(%rbp)
    11a6:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    11a9:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11ac:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11af:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11b3:	89 ce                	mov    %ecx,%esi
    11b5:	48 89 c7             	mov    %rax,%rdi
    11b8:	48 b8 99 10 00 00 00 	movabs $0x1099,%rax
    11bf:	00 00 00 
    11c2:	ff d0                	call   *%rax
  return dst;
    11c4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11c8:	c9                   	leave
    11c9:	c3                   	ret

00000000000011ca <strchr>:

char*
strchr(const char *s, char c)
{
    11ca:	55                   	push   %rbp
    11cb:	48 89 e5             	mov    %rsp,%rbp
    11ce:	48 83 ec 10          	sub    $0x10,%rsp
    11d2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11d6:	89 f0                	mov    %esi,%eax
    11d8:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11db:	eb 17                	jmp    11f4 <strchr+0x2a>
    if(*s == c)
    11dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11e1:	0f b6 00             	movzbl (%rax),%eax
    11e4:	38 45 f4             	cmp    %al,-0xc(%rbp)
    11e7:	75 06                	jne    11ef <strchr+0x25>
      return (char*)s;
    11e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ed:	eb 15                	jmp    1204 <strchr+0x3a>
  for(; *s; s++)
    11ef:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11f4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11f8:	0f b6 00             	movzbl (%rax),%eax
    11fb:	84 c0                	test   %al,%al
    11fd:	75 de                	jne    11dd <strchr+0x13>
  return 0;
    11ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1204:	c9                   	leave
    1205:	c3                   	ret

0000000000001206 <gets>:

char*
gets(char *buf, int max)
{
    1206:	55                   	push   %rbp
    1207:	48 89 e5             	mov    %rsp,%rbp
    120a:	48 83 ec 20          	sub    $0x20,%rsp
    120e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1212:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1215:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    121c:	eb 4f                	jmp    126d <gets+0x67>
    cc = read(0, &c, 1);
    121e:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1222:	ba 01 00 00 00       	mov    $0x1,%edx
    1227:	48 89 c6             	mov    %rax,%rsi
    122a:	bf 00 00 00 00       	mov    $0x0,%edi
    122f:	48 b8 db 13 00 00 00 	movabs $0x13db,%rax
    1236:	00 00 00 
    1239:	ff d0                	call   *%rax
    123b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    123e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1242:	7e 36                	jle    127a <gets+0x74>
      break;
    buf[i++] = c;
    1244:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1247:	8d 50 01             	lea    0x1(%rax),%edx
    124a:	89 55 fc             	mov    %edx,-0x4(%rbp)
    124d:	48 63 d0             	movslq %eax,%rdx
    1250:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1254:	48 01 c2             	add    %rax,%rdx
    1257:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    125b:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    125d:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1261:	3c 0a                	cmp    $0xa,%al
    1263:	74 16                	je     127b <gets+0x75>
    1265:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1269:	3c 0d                	cmp    $0xd,%al
    126b:	74 0e                	je     127b <gets+0x75>
  for(i=0; i+1 < max; ){
    126d:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1270:	83 c0 01             	add    $0x1,%eax
    1273:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1276:	7f a6                	jg     121e <gets+0x18>
    1278:	eb 01                	jmp    127b <gets+0x75>
      break;
    127a:	90                   	nop
      break;
  }
  buf[i] = '\0';
    127b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    127e:	48 63 d0             	movslq %eax,%rdx
    1281:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1285:	48 01 d0             	add    %rdx,%rax
    1288:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    128b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    128f:	c9                   	leave
    1290:	c3                   	ret

0000000000001291 <stat>:

int
stat(char *n, struct stat *st)
{
    1291:	55                   	push   %rbp
    1292:	48 89 e5             	mov    %rsp,%rbp
    1295:	48 83 ec 20          	sub    $0x20,%rsp
    1299:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    129d:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12a5:	be 00 00 00 00       	mov    $0x0,%esi
    12aa:	48 89 c7             	mov    %rax,%rdi
    12ad:	48 b8 1c 14 00 00 00 	movabs $0x141c,%rax
    12b4:	00 00 00 
    12b7:	ff d0                	call   *%rax
    12b9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12bc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12c0:	79 07                	jns    12c9 <stat+0x38>
    return -1;
    12c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12c7:	eb 2f                	jmp    12f8 <stat+0x67>
  r = fstat(fd, st);
    12c9:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12d0:	48 89 d6             	mov    %rdx,%rsi
    12d3:	89 c7                	mov    %eax,%edi
    12d5:	48 b8 43 14 00 00 00 	movabs $0x1443,%rax
    12dc:	00 00 00 
    12df:	ff d0                	call   *%rax
    12e1:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    12e4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12e7:	89 c7                	mov    %eax,%edi
    12e9:	48 b8 f5 13 00 00 00 	movabs $0x13f5,%rax
    12f0:	00 00 00 
    12f3:	ff d0                	call   *%rax
  return r;
    12f5:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    12f8:	c9                   	leave
    12f9:	c3                   	ret

00000000000012fa <atoi>:

int
atoi(const char *s)
{
    12fa:	55                   	push   %rbp
    12fb:	48 89 e5             	mov    %rsp,%rbp
    12fe:	48 83 ec 18          	sub    $0x18,%rsp
    1302:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    1306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    130d:	eb 28                	jmp    1337 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    130f:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1312:	89 d0                	mov    %edx,%eax
    1314:	c1 e0 02             	shl    $0x2,%eax
    1317:	01 d0                	add    %edx,%eax
    1319:	01 c0                	add    %eax,%eax
    131b:	89 c1                	mov    %eax,%ecx
    131d:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1321:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1325:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1329:	0f b6 00             	movzbl (%rax),%eax
    132c:	0f be c0             	movsbl %al,%eax
    132f:	01 c8                	add    %ecx,%eax
    1331:	83 e8 30             	sub    $0x30,%eax
    1334:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1337:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    133b:	0f b6 00             	movzbl (%rax),%eax
    133e:	3c 2f                	cmp    $0x2f,%al
    1340:	7e 0b                	jle    134d <atoi+0x53>
    1342:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1346:	0f b6 00             	movzbl (%rax),%eax
    1349:	3c 39                	cmp    $0x39,%al
    134b:	7e c2                	jle    130f <atoi+0x15>
  return n;
    134d:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1350:	c9                   	leave
    1351:	c3                   	ret

0000000000001352 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1352:	55                   	push   %rbp
    1353:	48 89 e5             	mov    %rsp,%rbp
    1356:	48 83 ec 28          	sub    $0x28,%rsp
    135a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    135e:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1362:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1365:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1369:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    136d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1371:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1375:	eb 1d                	jmp    1394 <memmove+0x42>
    *dst++ = *src++;
    1377:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    137b:	48 8d 42 01          	lea    0x1(%rdx),%rax
    137f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1383:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1387:	48 8d 48 01          	lea    0x1(%rax),%rcx
    138b:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    138f:	0f b6 12             	movzbl (%rdx),%edx
    1392:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1394:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1397:	8d 50 ff             	lea    -0x1(%rax),%edx
    139a:	89 55 dc             	mov    %edx,-0x24(%rbp)
    139d:	85 c0                	test   %eax,%eax
    139f:	7f d6                	jg     1377 <memmove+0x25>
  return vdst;
    13a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    13a5:	c9                   	leave
    13a6:	c3                   	ret

00000000000013a7 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    13a7:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13ae:	49 89 ca             	mov    %rcx,%r10
    13b1:	0f 05                	syscall
    13b3:	c3                   	ret

00000000000013b4 <exit>:
SYSCALL(exit)
    13b4:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13bb:	49 89 ca             	mov    %rcx,%r10
    13be:	0f 05                	syscall
    13c0:	c3                   	ret

00000000000013c1 <wait>:
SYSCALL(wait)
    13c1:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13c8:	49 89 ca             	mov    %rcx,%r10
    13cb:	0f 05                	syscall
    13cd:	c3                   	ret

00000000000013ce <pipe>:
SYSCALL(pipe)
    13ce:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    13d5:	49 89 ca             	mov    %rcx,%r10
    13d8:	0f 05                	syscall
    13da:	c3                   	ret

00000000000013db <read>:
SYSCALL(read)
    13db:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    13e2:	49 89 ca             	mov    %rcx,%r10
    13e5:	0f 05                	syscall
    13e7:	c3                   	ret

00000000000013e8 <write>:
SYSCALL(write)
    13e8:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    13ef:	49 89 ca             	mov    %rcx,%r10
    13f2:	0f 05                	syscall
    13f4:	c3                   	ret

00000000000013f5 <close>:
SYSCALL(close)
    13f5:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    13fc:	49 89 ca             	mov    %rcx,%r10
    13ff:	0f 05                	syscall
    1401:	c3                   	ret

0000000000001402 <kill>:
SYSCALL(kill)
    1402:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    1409:	49 89 ca             	mov    %rcx,%r10
    140c:	0f 05                	syscall
    140e:	c3                   	ret

000000000000140f <exec>:
SYSCALL(exec)
    140f:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    1416:	49 89 ca             	mov    %rcx,%r10
    1419:	0f 05                	syscall
    141b:	c3                   	ret

000000000000141c <open>:
SYSCALL(open)
    141c:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1423:	49 89 ca             	mov    %rcx,%r10
    1426:	0f 05                	syscall
    1428:	c3                   	ret

0000000000001429 <mknod>:
SYSCALL(mknod)
    1429:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1430:	49 89 ca             	mov    %rcx,%r10
    1433:	0f 05                	syscall
    1435:	c3                   	ret

0000000000001436 <unlink>:
SYSCALL(unlink)
    1436:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    143d:	49 89 ca             	mov    %rcx,%r10
    1440:	0f 05                	syscall
    1442:	c3                   	ret

0000000000001443 <fstat>:
SYSCALL(fstat)
    1443:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    144a:	49 89 ca             	mov    %rcx,%r10
    144d:	0f 05                	syscall
    144f:	c3                   	ret

0000000000001450 <link>:
SYSCALL(link)
    1450:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1457:	49 89 ca             	mov    %rcx,%r10
    145a:	0f 05                	syscall
    145c:	c3                   	ret

000000000000145d <mkdir>:
SYSCALL(mkdir)
    145d:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1464:	49 89 ca             	mov    %rcx,%r10
    1467:	0f 05                	syscall
    1469:	c3                   	ret

000000000000146a <chdir>:
SYSCALL(chdir)
    146a:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1471:	49 89 ca             	mov    %rcx,%r10
    1474:	0f 05                	syscall
    1476:	c3                   	ret

0000000000001477 <dup>:
SYSCALL(dup)
    1477:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    147e:	49 89 ca             	mov    %rcx,%r10
    1481:	0f 05                	syscall
    1483:	c3                   	ret

0000000000001484 <getpid>:
SYSCALL(getpid)
    1484:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    148b:	49 89 ca             	mov    %rcx,%r10
    148e:	0f 05                	syscall
    1490:	c3                   	ret

0000000000001491 <sbrk>:
SYSCALL(sbrk)
    1491:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1498:	49 89 ca             	mov    %rcx,%r10
    149b:	0f 05                	syscall
    149d:	c3                   	ret

000000000000149e <sleep>:
SYSCALL(sleep)
    149e:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    14a5:	49 89 ca             	mov    %rcx,%r10
    14a8:	0f 05                	syscall
    14aa:	c3                   	ret

00000000000014ab <uptime>:
SYSCALL(uptime)
    14ab:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14b2:	49 89 ca             	mov    %rcx,%r10
    14b5:	0f 05                	syscall
    14b7:	c3                   	ret

00000000000014b8 <mmap>:
SYSCALL(mmap)
    14b8:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14bf:	49 89 ca             	mov    %rcx,%r10
    14c2:	0f 05                	syscall
    14c4:	c3                   	ret

00000000000014c5 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14c5:	55                   	push   %rbp
    14c6:	48 89 e5             	mov    %rsp,%rbp
    14c9:	48 83 ec 10          	sub    $0x10,%rsp
    14cd:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14d0:	89 f0                	mov    %esi,%eax
    14d2:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    14d5:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    14d9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14dc:	ba 01 00 00 00       	mov    $0x1,%edx
    14e1:	48 89 ce             	mov    %rcx,%rsi
    14e4:	89 c7                	mov    %eax,%edi
    14e6:	48 b8 e8 13 00 00 00 	movabs $0x13e8,%rax
    14ed:	00 00 00 
    14f0:	ff d0                	call   *%rax
}
    14f2:	90                   	nop
    14f3:	c9                   	leave
    14f4:	c3                   	ret

00000000000014f5 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    14f5:	55                   	push   %rbp
    14f6:	48 89 e5             	mov    %rsp,%rbp
    14f9:	48 83 ec 20          	sub    $0x20,%rsp
    14fd:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1500:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1504:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    150b:	eb 35                	jmp    1542 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    150d:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1511:	48 c1 e8 3c          	shr    $0x3c,%rax
    1515:	48 ba e0 1d 00 00 00 	movabs $0x1de0,%rdx
    151c:	00 00 00 
    151f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1523:	0f be d0             	movsbl %al,%edx
    1526:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1529:	89 d6                	mov    %edx,%esi
    152b:	89 c7                	mov    %eax,%edi
    152d:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1534:	00 00 00 
    1537:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    1539:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    153d:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1542:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1545:	83 f8 0f             	cmp    $0xf,%eax
    1548:	76 c3                	jbe    150d <print_x64+0x18>
}
    154a:	90                   	nop
    154b:	90                   	nop
    154c:	c9                   	leave
    154d:	c3                   	ret

000000000000154e <print_x32>:

  static void
print_x32(int fd, uint x)
{
    154e:	55                   	push   %rbp
    154f:	48 89 e5             	mov    %rsp,%rbp
    1552:	48 83 ec 20          	sub    $0x20,%rsp
    1556:	89 7d ec             	mov    %edi,-0x14(%rbp)
    1559:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    155c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1563:	eb 36                	jmp    159b <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1565:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1568:	c1 e8 1c             	shr    $0x1c,%eax
    156b:	89 c2                	mov    %eax,%edx
    156d:	48 b8 e0 1d 00 00 00 	movabs $0x1de0,%rax
    1574:	00 00 00 
    1577:	89 d2                	mov    %edx,%edx
    1579:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    157d:	0f be d0             	movsbl %al,%edx
    1580:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1583:	89 d6                	mov    %edx,%esi
    1585:	89 c7                	mov    %eax,%edi
    1587:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    158e:	00 00 00 
    1591:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1593:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1597:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    159b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    159e:	83 f8 07             	cmp    $0x7,%eax
    15a1:	76 c2                	jbe    1565 <print_x32+0x17>
}
    15a3:	90                   	nop
    15a4:	90                   	nop
    15a5:	c9                   	leave
    15a6:	c3                   	ret

00000000000015a7 <print_d>:

  static void
print_d(int fd, int v)
{
    15a7:	55                   	push   %rbp
    15a8:	48 89 e5             	mov    %rsp,%rbp
    15ab:	48 83 ec 30          	sub    $0x30,%rsp
    15af:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15b2:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15b5:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15b8:	48 98                	cltq
    15ba:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15be:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15c2:	79 04                	jns    15c8 <print_d+0x21>
    x = -x;
    15c4:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15c8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15cf:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15d3:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15da:	66 66 66 
    15dd:	48 89 c8             	mov    %rcx,%rax
    15e0:	48 f7 ea             	imul   %rdx
    15e3:	48 c1 fa 02          	sar    $0x2,%rdx
    15e7:	48 89 c8             	mov    %rcx,%rax
    15ea:	48 c1 f8 3f          	sar    $0x3f,%rax
    15ee:	48 29 c2             	sub    %rax,%rdx
    15f1:	48 89 d0             	mov    %rdx,%rax
    15f4:	48 c1 e0 02          	shl    $0x2,%rax
    15f8:	48 01 d0             	add    %rdx,%rax
    15fb:	48 01 c0             	add    %rax,%rax
    15fe:	48 29 c1             	sub    %rax,%rcx
    1601:	48 89 ca             	mov    %rcx,%rdx
    1604:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1607:	8d 48 01             	lea    0x1(%rax),%ecx
    160a:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    160d:	48 b9 e0 1d 00 00 00 	movabs $0x1de0,%rcx
    1614:	00 00 00 
    1617:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    161b:	48 98                	cltq
    161d:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1621:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1625:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    162c:	66 66 66 
    162f:	48 89 c8             	mov    %rcx,%rax
    1632:	48 f7 ea             	imul   %rdx
    1635:	48 89 d0             	mov    %rdx,%rax
    1638:	48 c1 f8 02          	sar    $0x2,%rax
    163c:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1640:	48 89 ca             	mov    %rcx,%rdx
    1643:	48 29 d0             	sub    %rdx,%rax
    1646:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    164a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    164f:	0f 85 7a ff ff ff    	jne    15cf <print_d+0x28>

  if (v < 0)
    1655:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1659:	79 32                	jns    168d <print_d+0xe6>
    buf[i++] = '-';
    165b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    165e:	8d 50 01             	lea    0x1(%rax),%edx
    1661:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1664:	48 98                	cltq
    1666:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    166b:	eb 20                	jmp    168d <print_d+0xe6>
    putc(fd, buf[i]);
    166d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1670:	48 98                	cltq
    1672:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1677:	0f be d0             	movsbl %al,%edx
    167a:	8b 45 dc             	mov    -0x24(%rbp),%eax
    167d:	89 d6                	mov    %edx,%esi
    167f:	89 c7                	mov    %eax,%edi
    1681:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1688:	00 00 00 
    168b:	ff d0                	call   *%rax
  while (--i >= 0)
    168d:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1691:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1695:	79 d6                	jns    166d <print_d+0xc6>
}
    1697:	90                   	nop
    1698:	90                   	nop
    1699:	c9                   	leave
    169a:	c3                   	ret

000000000000169b <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    169b:	55                   	push   %rbp
    169c:	48 89 e5             	mov    %rsp,%rbp
    169f:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    16a6:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16ac:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16b3:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16ba:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16c1:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16c8:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16cf:	84 c0                	test   %al,%al
    16d1:	74 20                	je     16f3 <printf+0x58>
    16d3:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    16d7:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    16db:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    16df:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    16e3:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    16e7:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    16eb:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    16ef:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    16f3:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    16fa:	00 00 00 
    16fd:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1704:	00 00 00 
    1707:	48 8d 45 10          	lea    0x10(%rbp),%rax
    170b:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1712:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1719:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1720:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1727:	00 00 00 
    172a:	e9 60 03 00 00       	jmp    1a8f <printf+0x3f4>
    if (c != '%') {
    172f:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1736:	74 24                	je     175c <printf+0xc1>
      putc(fd, c);
    1738:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    173e:	0f be d0             	movsbl %al,%edx
    1741:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1747:	89 d6                	mov    %edx,%esi
    1749:	89 c7                	mov    %eax,%edi
    174b:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1752:	00 00 00 
    1755:	ff d0                	call   *%rax
      continue;
    1757:	e9 2c 03 00 00       	jmp    1a88 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    175c:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1763:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1769:	48 63 d0             	movslq %eax,%rdx
    176c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1773:	48 01 d0             	add    %rdx,%rax
    1776:	0f b6 00             	movzbl (%rax),%eax
    1779:	0f be c0             	movsbl %al,%eax
    177c:	25 ff 00 00 00       	and    $0xff,%eax
    1781:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1787:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    178e:	0f 84 2e 03 00 00    	je     1ac2 <printf+0x427>
      break;
    switch(c) {
    1794:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    179b:	0f 84 32 01 00 00    	je     18d3 <printf+0x238>
    17a1:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    17a8:	0f 8f a1 02 00 00    	jg     1a4f <printf+0x3b4>
    17ae:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17b5:	0f 84 d4 01 00 00    	je     198f <printf+0x2f4>
    17bb:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17c2:	0f 8f 87 02 00 00    	jg     1a4f <printf+0x3b4>
    17c8:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17cf:	0f 84 5b 01 00 00    	je     1930 <printf+0x295>
    17d5:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17dc:	0f 8f 6d 02 00 00    	jg     1a4f <printf+0x3b4>
    17e2:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17e9:	0f 84 87 00 00 00    	je     1876 <printf+0x1db>
    17ef:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17f6:	0f 8f 53 02 00 00    	jg     1a4f <printf+0x3b4>
    17fc:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1803:	0f 84 2b 02 00 00    	je     1a34 <printf+0x399>
    1809:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1810:	0f 85 39 02 00 00    	jne    1a4f <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1816:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    181c:	83 f8 2f             	cmp    $0x2f,%eax
    181f:	77 23                	ja     1844 <printf+0x1a9>
    1821:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1828:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    182e:	89 d2                	mov    %edx,%edx
    1830:	48 01 d0             	add    %rdx,%rax
    1833:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1839:	83 c2 08             	add    $0x8,%edx
    183c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1842:	eb 12                	jmp    1856 <printf+0x1bb>
    1844:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    184b:	48 8d 50 08          	lea    0x8(%rax),%rdx
    184f:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1856:	8b 00                	mov    (%rax),%eax
    1858:	0f be d0             	movsbl %al,%edx
    185b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1861:	89 d6                	mov    %edx,%esi
    1863:	89 c7                	mov    %eax,%edi
    1865:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    186c:	00 00 00 
    186f:	ff d0                	call   *%rax
      break;
    1871:	e9 12 02 00 00       	jmp    1a88 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1876:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    187c:	83 f8 2f             	cmp    $0x2f,%eax
    187f:	77 23                	ja     18a4 <printf+0x209>
    1881:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1888:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    188e:	89 d2                	mov    %edx,%edx
    1890:	48 01 d0             	add    %rdx,%rax
    1893:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1899:	83 c2 08             	add    $0x8,%edx
    189c:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18a2:	eb 12                	jmp    18b6 <printf+0x21b>
    18a4:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18ab:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18af:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18b6:	8b 10                	mov    (%rax),%edx
    18b8:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18be:	89 d6                	mov    %edx,%esi
    18c0:	89 c7                	mov    %eax,%edi
    18c2:	48 b8 a7 15 00 00 00 	movabs $0x15a7,%rax
    18c9:	00 00 00 
    18cc:	ff d0                	call   *%rax
      break;
    18ce:	e9 b5 01 00 00       	jmp    1a88 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    18d3:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18d9:	83 f8 2f             	cmp    $0x2f,%eax
    18dc:	77 23                	ja     1901 <printf+0x266>
    18de:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18e5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18eb:	89 d2                	mov    %edx,%edx
    18ed:	48 01 d0             	add    %rdx,%rax
    18f0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18f6:	83 c2 08             	add    $0x8,%edx
    18f9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18ff:	eb 12                	jmp    1913 <printf+0x278>
    1901:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1908:	48 8d 50 08          	lea    0x8(%rax),%rdx
    190c:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1913:	8b 10                	mov    (%rax),%edx
    1915:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    191b:	89 d6                	mov    %edx,%esi
    191d:	89 c7                	mov    %eax,%edi
    191f:	48 b8 4e 15 00 00 00 	movabs $0x154e,%rax
    1926:	00 00 00 
    1929:	ff d0                	call   *%rax
      break;
    192b:	e9 58 01 00 00       	jmp    1a88 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1930:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1936:	83 f8 2f             	cmp    $0x2f,%eax
    1939:	77 23                	ja     195e <printf+0x2c3>
    193b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1942:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1948:	89 d2                	mov    %edx,%edx
    194a:	48 01 d0             	add    %rdx,%rax
    194d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1953:	83 c2 08             	add    $0x8,%edx
    1956:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    195c:	eb 12                	jmp    1970 <printf+0x2d5>
    195e:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1965:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1969:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1970:	48 8b 10             	mov    (%rax),%rdx
    1973:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1979:	48 89 d6             	mov    %rdx,%rsi
    197c:	89 c7                	mov    %eax,%edi
    197e:	48 b8 f5 14 00 00 00 	movabs $0x14f5,%rax
    1985:	00 00 00 
    1988:	ff d0                	call   *%rax
      break;
    198a:	e9 f9 00 00 00       	jmp    1a88 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    198f:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1995:	83 f8 2f             	cmp    $0x2f,%eax
    1998:	77 23                	ja     19bd <printf+0x322>
    199a:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    19a1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a7:	89 d2                	mov    %edx,%edx
    19a9:	48 01 d0             	add    %rdx,%rax
    19ac:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19b2:	83 c2 08             	add    $0x8,%edx
    19b5:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19bb:	eb 12                	jmp    19cf <printf+0x334>
    19bd:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19c4:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19c8:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19cf:	48 8b 00             	mov    (%rax),%rax
    19d2:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    19d9:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    19e0:	00 
    19e1:	75 41                	jne    1a24 <printf+0x389>
        s = "(null)";
    19e3:	48 b8 d1 1d 00 00 00 	movabs $0x1dd1,%rax
    19ea:	00 00 00 
    19ed:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    19f4:	eb 2e                	jmp    1a24 <printf+0x389>
        putc(fd, *(s++));
    19f6:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19fd:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1a01:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1a08:	0f b6 00             	movzbl (%rax),%eax
    1a0b:	0f be d0             	movsbl %al,%edx
    1a0e:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a14:	89 d6                	mov    %edx,%esi
    1a16:	89 c7                	mov    %eax,%edi
    1a18:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1a1f:	00 00 00 
    1a22:	ff d0                	call   *%rax
      while (*s)
    1a24:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a2b:	0f b6 00             	movzbl (%rax),%eax
    1a2e:	84 c0                	test   %al,%al
    1a30:	75 c4                	jne    19f6 <printf+0x35b>
      break;
    1a32:	eb 54                	jmp    1a88 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1a34:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a3a:	be 25 00 00 00       	mov    $0x25,%esi
    1a3f:	89 c7                	mov    %eax,%edi
    1a41:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1a48:	00 00 00 
    1a4b:	ff d0                	call   *%rax
      break;
    1a4d:	eb 39                	jmp    1a88 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a4f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a55:	be 25 00 00 00       	mov    $0x25,%esi
    1a5a:	89 c7                	mov    %eax,%edi
    1a5c:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1a63:	00 00 00 
    1a66:	ff d0                	call   *%rax
      putc(fd, c);
    1a68:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a6e:	0f be d0             	movsbl %al,%edx
    1a71:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a77:	89 d6                	mov    %edx,%esi
    1a79:	89 c7                	mov    %eax,%edi
    1a7b:	48 b8 c5 14 00 00 00 	movabs $0x14c5,%rax
    1a82:	00 00 00 
    1a85:	ff d0                	call   *%rax
      break;
    1a87:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a88:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a8f:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a95:	48 63 d0             	movslq %eax,%rdx
    1a98:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a9f:	48 01 d0             	add    %rdx,%rax
    1aa2:	0f b6 00             	movzbl (%rax),%eax
    1aa5:	0f be c0             	movsbl %al,%eax
    1aa8:	25 ff 00 00 00       	and    $0xff,%eax
    1aad:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1ab3:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1aba:	0f 85 6f fc ff ff    	jne    172f <printf+0x94>
    }
  }
}
    1ac0:	eb 01                	jmp    1ac3 <printf+0x428>
      break;
    1ac2:	90                   	nop
}
    1ac3:	90                   	nop
    1ac4:	c9                   	leave
    1ac5:	c3                   	ret

0000000000001ac6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1ac6:	55                   	push   %rbp
    1ac7:	48 89 e5             	mov    %rsp,%rbp
    1aca:	48 83 ec 18          	sub    $0x18,%rsp
    1ace:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1ad2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ad6:	48 83 e8 10          	sub    $0x10,%rax
    1ada:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ade:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1ae5:	00 00 00 
    1ae8:	48 8b 00             	mov    (%rax),%rax
    1aeb:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1aef:	eb 2f                	jmp    1b20 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1af1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1af5:	48 8b 00             	mov    (%rax),%rax
    1af8:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1afc:	72 17                	jb     1b15 <free+0x4f>
    1afe:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b02:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b06:	72 2f                	jb     1b37 <free+0x71>
    1b08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b0c:	48 8b 00             	mov    (%rax),%rax
    1b0f:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b13:	72 22                	jb     1b37 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b19:	48 8b 00             	mov    (%rax),%rax
    1b1c:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b20:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b24:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b28:	73 c7                	jae    1af1 <free+0x2b>
    1b2a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b2e:	48 8b 00             	mov    (%rax),%rax
    1b31:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b35:	73 ba                	jae    1af1 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b3b:	8b 40 08             	mov    0x8(%rax),%eax
    1b3e:	89 c0                	mov    %eax,%eax
    1b40:	48 c1 e0 04          	shl    $0x4,%rax
    1b44:	48 89 c2             	mov    %rax,%rdx
    1b47:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b4b:	48 01 c2             	add    %rax,%rdx
    1b4e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b52:	48 8b 00             	mov    (%rax),%rax
    1b55:	48 39 c2             	cmp    %rax,%rdx
    1b58:	75 2d                	jne    1b87 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1b5a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b5e:	8b 50 08             	mov    0x8(%rax),%edx
    1b61:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b65:	48 8b 00             	mov    (%rax),%rax
    1b68:	8b 40 08             	mov    0x8(%rax),%eax
    1b6b:	01 c2                	add    %eax,%edx
    1b6d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b71:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b74:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b78:	48 8b 00             	mov    (%rax),%rax
    1b7b:	48 8b 10             	mov    (%rax),%rdx
    1b7e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b82:	48 89 10             	mov    %rdx,(%rax)
    1b85:	eb 0e                	jmp    1b95 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1b87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8b:	48 8b 10             	mov    (%rax),%rdx
    1b8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b92:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1b95:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b99:	8b 40 08             	mov    0x8(%rax),%eax
    1b9c:	89 c0                	mov    %eax,%eax
    1b9e:	48 c1 e0 04          	shl    $0x4,%rax
    1ba2:	48 89 c2             	mov    %rax,%rdx
    1ba5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba9:	48 01 d0             	add    %rdx,%rax
    1bac:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1bb0:	75 27                	jne    1bd9 <free+0x113>
    p->s.size += bp->s.size;
    1bb2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb6:	8b 50 08             	mov    0x8(%rax),%edx
    1bb9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bbd:	8b 40 08             	mov    0x8(%rax),%eax
    1bc0:	01 c2                	add    %eax,%edx
    1bc2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc6:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1bc9:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bcd:	48 8b 10             	mov    (%rax),%rdx
    1bd0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd4:	48 89 10             	mov    %rdx,(%rax)
    1bd7:	eb 0b                	jmp    1be4 <free+0x11e>
  } else
    p->s.ptr = bp;
    1bd9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bdd:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1be1:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1be4:	48 ba 10 1e 00 00 00 	movabs $0x1e10,%rdx
    1beb:	00 00 00 
    1bee:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bf2:	48 89 02             	mov    %rax,(%rdx)
}
    1bf5:	90                   	nop
    1bf6:	c9                   	leave
    1bf7:	c3                   	ret

0000000000001bf8 <morecore>:

static Header*
morecore(uint nu)
{
    1bf8:	55                   	push   %rbp
    1bf9:	48 89 e5             	mov    %rsp,%rbp
    1bfc:	48 83 ec 20          	sub    $0x20,%rsp
    1c00:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1c03:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1c0a:	77 07                	ja     1c13 <morecore+0x1b>
    nu = 4096;
    1c0c:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c13:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c16:	48 c1 e0 04          	shl    $0x4,%rax
    1c1a:	48 89 c7             	mov    %rax,%rdi
    1c1d:	48 b8 91 14 00 00 00 	movabs $0x1491,%rax
    1c24:	00 00 00 
    1c27:	ff d0                	call   *%rax
    1c29:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c2d:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c32:	75 07                	jne    1c3b <morecore+0x43>
    return 0;
    1c34:	b8 00 00 00 00       	mov    $0x0,%eax
    1c39:	eb 36                	jmp    1c71 <morecore+0x79>
  hp = (Header*)p;
    1c3b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c3f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c43:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c47:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c4a:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c51:	48 83 c0 10          	add    $0x10,%rax
    1c55:	48 89 c7             	mov    %rax,%rdi
    1c58:	48 b8 c6 1a 00 00 00 	movabs $0x1ac6,%rax
    1c5f:	00 00 00 
    1c62:	ff d0                	call   *%rax
  return freep;
    1c64:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1c6b:	00 00 00 
    1c6e:	48 8b 00             	mov    (%rax),%rax
}
    1c71:	c9                   	leave
    1c72:	c3                   	ret

0000000000001c73 <malloc>:

void*
malloc(uint nbytes)
{
    1c73:	55                   	push   %rbp
    1c74:	48 89 e5             	mov    %rsp,%rbp
    1c77:	48 83 ec 30          	sub    $0x30,%rsp
    1c7b:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c7e:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c81:	48 83 c0 0f          	add    $0xf,%rax
    1c85:	48 c1 e8 04          	shr    $0x4,%rax
    1c89:	83 c0 01             	add    $0x1,%eax
    1c8c:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c8f:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1c96:	00 00 00 
    1c99:	48 8b 00             	mov    (%rax),%rax
    1c9c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ca0:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1ca5:	75 4a                	jne    1cf1 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1ca7:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1cae:	00 00 00 
    1cb1:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1cb5:	48 ba 10 1e 00 00 00 	movabs $0x1e10,%rdx
    1cbc:	00 00 00 
    1cbf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cc3:	48 89 02             	mov    %rax,(%rdx)
    1cc6:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1ccd:	00 00 00 
    1cd0:	48 8b 00             	mov    (%rax),%rax
    1cd3:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1cda:	00 00 00 
    1cdd:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1ce0:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1ce7:	00 00 00 
    1cea:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1cf1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cf5:	48 8b 00             	mov    (%rax),%rax
    1cf8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d00:	8b 40 08             	mov    0x8(%rax),%eax
    1d03:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1d06:	72 65                	jb     1d6d <malloc+0xfa>
      if(p->s.size == nunits)
    1d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0c:	8b 40 08             	mov    0x8(%rax),%eax
    1d0f:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d12:	75 10                	jne    1d24 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d14:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d18:	48 8b 10             	mov    (%rax),%rdx
    1d1b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d1f:	48 89 10             	mov    %rdx,(%rax)
    1d22:	eb 2e                	jmp    1d52 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1d24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d28:	8b 40 08             	mov    0x8(%rax),%eax
    1d2b:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d2e:	89 c2                	mov    %eax,%edx
    1d30:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d34:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d37:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3b:	8b 40 08             	mov    0x8(%rax),%eax
    1d3e:	89 c0                	mov    %eax,%eax
    1d40:	48 c1 e0 04          	shl    $0x4,%rax
    1d44:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d48:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d4c:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d4f:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d52:	48 ba 10 1e 00 00 00 	movabs $0x1e10,%rdx
    1d59:	00 00 00 
    1d5c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d60:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d63:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d67:	48 83 c0 10          	add    $0x10,%rax
    1d6b:	eb 4e                	jmp    1dbb <malloc+0x148>
    }
    if(p == freep)
    1d6d:	48 b8 10 1e 00 00 00 	movabs $0x1e10,%rax
    1d74:	00 00 00 
    1d77:	48 8b 00             	mov    (%rax),%rax
    1d7a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d7e:	75 23                	jne    1da3 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1d80:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d83:	89 c7                	mov    %eax,%edi
    1d85:	48 b8 f8 1b 00 00 00 	movabs $0x1bf8,%rax
    1d8c:	00 00 00 
    1d8f:	ff d0                	call   *%rax
    1d91:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d95:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d9a:	75 07                	jne    1da3 <malloc+0x130>
        return 0;
    1d9c:	b8 00 00 00 00       	mov    $0x0,%eax
    1da1:	eb 18                	jmp    1dbb <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1da3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1dab:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1daf:	48 8b 00             	mov    (%rax),%rax
    1db2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1db6:	e9 41 ff ff ff       	jmp    1cfc <malloc+0x89>
  }
}
    1dbb:	c9                   	leave
    1dbc:	c3                   	ret
