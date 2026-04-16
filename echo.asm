
_echo:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 20          	sub    $0x20,%rsp
    1008:	89 7d ec             	mov    %edi,-0x14(%rbp)
    100b:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;

  for(i = 1; i < argc; i++)
    100f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%rbp)
    1016:	eb 61                	jmp    1079 <main+0x79>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
    1018:	8b 45 fc             	mov    -0x4(%rbp),%eax
    101b:	83 c0 01             	add    $0x1,%eax
    101e:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1021:	7e 0c                	jle    102f <main+0x2f>
    1023:	48 b8 b1 1d 00 00 00 	movabs $0x1db1,%rax
    102a:	00 00 00 
    102d:	eb 0a                	jmp    1039 <main+0x39>
    102f:	48 b8 b3 1d 00 00 00 	movabs $0x1db3,%rax
    1036:	00 00 00 
    1039:	8b 55 fc             	mov    -0x4(%rbp),%edx
    103c:	48 63 d2             	movslq %edx,%rdx
    103f:	48 8d 0c d5 00 00 00 	lea    0x0(,%rdx,8),%rcx
    1046:	00 
    1047:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    104b:	48 01 ca             	add    %rcx,%rdx
    104e:	48 8b 12             	mov    (%rdx),%rdx
    1051:	48 be b5 1d 00 00 00 	movabs $0x1db5,%rsi
    1058:	00 00 00 
    105b:	48 89 c1             	mov    %rax,%rcx
    105e:	bf 01 00 00 00       	mov    $0x1,%edi
    1063:	b8 00 00 00 00       	mov    $0x0,%eax
    1068:	49 b8 8f 16 00 00 00 	movabs $0x168f,%r8
    106f:	00 00 00 
    1072:	41 ff d0             	call   *%r8
  for(i = 1; i < argc; i++)
    1075:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1079:	8b 45 fc             	mov    -0x4(%rbp),%eax
    107c:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    107f:	7c 97                	jl     1018 <main+0x18>
  exit();
    1081:	48 b8 a8 13 00 00 00 	movabs $0x13a8,%rax
    1088:	00 00 00 
    108b:	ff d0                	call   *%rax

000000000000108d <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    108d:	55                   	push   %rbp
    108e:	48 89 e5             	mov    %rsp,%rbp
    1091:	48 83 ec 10          	sub    $0x10,%rsp
    1095:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1099:	89 75 f4             	mov    %esi,-0xc(%rbp)
    109c:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    109f:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    10a3:	8b 55 f0             	mov    -0x10(%rbp),%edx
    10a6:	8b 45 f4             	mov    -0xc(%rbp),%eax
    10a9:	48 89 ce             	mov    %rcx,%rsi
    10ac:	48 89 f7             	mov    %rsi,%rdi
    10af:	89 d1                	mov    %edx,%ecx
    10b1:	fc                   	cld
    10b2:	f3 aa                	rep stos %al,(%rdi)
    10b4:	89 ca                	mov    %ecx,%edx
    10b6:	48 89 fe             	mov    %rdi,%rsi
    10b9:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    10bd:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    10c0:	90                   	nop
    10c1:	c9                   	leave
    10c2:	c3                   	ret

00000000000010c3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    10c3:	55                   	push   %rbp
    10c4:	48 89 e5             	mov    %rsp,%rbp
    10c7:	48 83 ec 20          	sub    $0x20,%rsp
    10cb:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10cf:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    10d3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10d7:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    10db:	90                   	nop
    10dc:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    10e0:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10e4:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10ec:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10f0:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    10f4:	0f b6 12             	movzbl (%rdx),%edx
    10f7:	88 10                	mov    %dl,(%rax)
    10f9:	0f b6 00             	movzbl (%rax),%eax
    10fc:	84 c0                	test   %al,%al
    10fe:	75 dc                	jne    10dc <strcpy+0x19>
    ;
  return os;
    1100:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1104:	c9                   	leave
    1105:	c3                   	ret

0000000000001106 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1106:	55                   	push   %rbp
    1107:	48 89 e5             	mov    %rsp,%rbp
    110a:	48 83 ec 10          	sub    $0x10,%rsp
    110e:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1112:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    1116:	eb 0a                	jmp    1122 <strcmp+0x1c>
    p++, q++;
    1118:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    111d:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1122:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1126:	0f b6 00             	movzbl (%rax),%eax
    1129:	84 c0                	test   %al,%al
    112b:	74 12                	je     113f <strcmp+0x39>
    112d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1131:	0f b6 10             	movzbl (%rax),%edx
    1134:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1138:	0f b6 00             	movzbl (%rax),%eax
    113b:	38 c2                	cmp    %al,%dl
    113d:	74 d9                	je     1118 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    113f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1143:	0f b6 00             	movzbl (%rax),%eax
    1146:	0f b6 d0             	movzbl %al,%edx
    1149:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    114d:	0f b6 00             	movzbl (%rax),%eax
    1150:	0f b6 c0             	movzbl %al,%eax
    1153:	29 c2                	sub    %eax,%edx
    1155:	89 d0                	mov    %edx,%eax
}
    1157:	c9                   	leave
    1158:	c3                   	ret

0000000000001159 <strlen>:

uint
strlen(char *s)
{
    1159:	55                   	push   %rbp
    115a:	48 89 e5             	mov    %rsp,%rbp
    115d:	48 83 ec 18          	sub    $0x18,%rsp
    1161:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1165:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    116c:	eb 04                	jmp    1172 <strlen+0x19>
    116e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1172:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1175:	48 63 d0             	movslq %eax,%rdx
    1178:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    117c:	48 01 d0             	add    %rdx,%rax
    117f:	0f b6 00             	movzbl (%rax),%eax
    1182:	84 c0                	test   %al,%al
    1184:	75 e8                	jne    116e <strlen+0x15>
    ;
  return n;
    1186:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1189:	c9                   	leave
    118a:	c3                   	ret

000000000000118b <memset>:

void*
memset(void *dst, int c, uint n)
{
    118b:	55                   	push   %rbp
    118c:	48 89 e5             	mov    %rsp,%rbp
    118f:	48 83 ec 10          	sub    $0x10,%rsp
    1193:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1197:	89 75 f4             	mov    %esi,-0xc(%rbp)
    119a:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    119d:	8b 55 f0             	mov    -0x10(%rbp),%edx
    11a0:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    11a3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11a7:	89 ce                	mov    %ecx,%esi
    11a9:	48 89 c7             	mov    %rax,%rdi
    11ac:	48 b8 8d 10 00 00 00 	movabs $0x108d,%rax
    11b3:	00 00 00 
    11b6:	ff d0                	call   *%rax
  return dst;
    11b8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    11bc:	c9                   	leave
    11bd:	c3                   	ret

00000000000011be <strchr>:

char*
strchr(const char *s, char c)
{
    11be:	55                   	push   %rbp
    11bf:	48 89 e5             	mov    %rsp,%rbp
    11c2:	48 83 ec 10          	sub    $0x10,%rsp
    11c6:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11ca:	89 f0                	mov    %esi,%eax
    11cc:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11cf:	eb 17                	jmp    11e8 <strchr+0x2a>
    if(*s == c)
    11d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11d5:	0f b6 00             	movzbl (%rax),%eax
    11d8:	38 45 f4             	cmp    %al,-0xc(%rbp)
    11db:	75 06                	jne    11e3 <strchr+0x25>
      return (char*)s;
    11dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11e1:	eb 15                	jmp    11f8 <strchr+0x3a>
  for(; *s; s++)
    11e3:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11e8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ec:	0f b6 00             	movzbl (%rax),%eax
    11ef:	84 c0                	test   %al,%al
    11f1:	75 de                	jne    11d1 <strchr+0x13>
  return 0;
    11f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11f8:	c9                   	leave
    11f9:	c3                   	ret

00000000000011fa <gets>:

char*
gets(char *buf, int max)
{
    11fa:	55                   	push   %rbp
    11fb:	48 89 e5             	mov    %rsp,%rbp
    11fe:	48 83 ec 20          	sub    $0x20,%rsp
    1202:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1206:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1209:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1210:	eb 4f                	jmp    1261 <gets+0x67>
    cc = read(0, &c, 1);
    1212:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    1216:	ba 01 00 00 00       	mov    $0x1,%edx
    121b:	48 89 c6             	mov    %rax,%rsi
    121e:	bf 00 00 00 00       	mov    $0x0,%edi
    1223:	48 b8 cf 13 00 00 00 	movabs $0x13cf,%rax
    122a:	00 00 00 
    122d:	ff d0                	call   *%rax
    122f:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1232:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1236:	7e 36                	jle    126e <gets+0x74>
      break;
    buf[i++] = c;
    1238:	8b 45 fc             	mov    -0x4(%rbp),%eax
    123b:	8d 50 01             	lea    0x1(%rax),%edx
    123e:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1241:	48 63 d0             	movslq %eax,%rdx
    1244:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1248:	48 01 c2             	add    %rax,%rdx
    124b:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    124f:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1251:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1255:	3c 0a                	cmp    $0xa,%al
    1257:	74 16                	je     126f <gets+0x75>
    1259:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    125d:	3c 0d                	cmp    $0xd,%al
    125f:	74 0e                	je     126f <gets+0x75>
  for(i=0; i+1 < max; ){
    1261:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1264:	83 c0 01             	add    $0x1,%eax
    1267:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    126a:	7f a6                	jg     1212 <gets+0x18>
    126c:	eb 01                	jmp    126f <gets+0x75>
      break;
    126e:	90                   	nop
      break;
  }
  buf[i] = '\0';
    126f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1272:	48 63 d0             	movslq %eax,%rdx
    1275:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1279:	48 01 d0             	add    %rdx,%rax
    127c:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    127f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1283:	c9                   	leave
    1284:	c3                   	ret

0000000000001285 <stat>:

int
stat(char *n, struct stat *st)
{
    1285:	55                   	push   %rbp
    1286:	48 89 e5             	mov    %rsp,%rbp
    1289:	48 83 ec 20          	sub    $0x20,%rsp
    128d:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1291:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1295:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1299:	be 00 00 00 00       	mov    $0x0,%esi
    129e:	48 89 c7             	mov    %rax,%rdi
    12a1:	48 b8 10 14 00 00 00 	movabs $0x1410,%rax
    12a8:	00 00 00 
    12ab:	ff d0                	call   *%rax
    12ad:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    12b0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    12b4:	79 07                	jns    12bd <stat+0x38>
    return -1;
    12b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12bb:	eb 2f                	jmp    12ec <stat+0x67>
  r = fstat(fd, st);
    12bd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    12c1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12c4:	48 89 d6             	mov    %rdx,%rsi
    12c7:	89 c7                	mov    %eax,%edi
    12c9:	48 b8 37 14 00 00 00 	movabs $0x1437,%rax
    12d0:	00 00 00 
    12d3:	ff d0                	call   *%rax
    12d5:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    12d8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12db:	89 c7                	mov    %eax,%edi
    12dd:	48 b8 e9 13 00 00 00 	movabs $0x13e9,%rax
    12e4:	00 00 00 
    12e7:	ff d0                	call   *%rax
  return r;
    12e9:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    12ec:	c9                   	leave
    12ed:	c3                   	ret

00000000000012ee <atoi>:

int
atoi(const char *s)
{
    12ee:	55                   	push   %rbp
    12ef:	48 89 e5             	mov    %rsp,%rbp
    12f2:	48 83 ec 18          	sub    $0x18,%rsp
    12f6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    12fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1301:	eb 28                	jmp    132b <atoi+0x3d>
    n = n*10 + *s++ - '0';
    1303:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1306:	89 d0                	mov    %edx,%eax
    1308:	c1 e0 02             	shl    $0x2,%eax
    130b:	01 d0                	add    %edx,%eax
    130d:	01 c0                	add    %eax,%eax
    130f:	89 c1                	mov    %eax,%ecx
    1311:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1315:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1319:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    131d:	0f b6 00             	movzbl (%rax),%eax
    1320:	0f be c0             	movsbl %al,%eax
    1323:	01 c8                	add    %ecx,%eax
    1325:	83 e8 30             	sub    $0x30,%eax
    1328:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    132b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    132f:	0f b6 00             	movzbl (%rax),%eax
    1332:	3c 2f                	cmp    $0x2f,%al
    1334:	7e 0b                	jle    1341 <atoi+0x53>
    1336:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    133a:	0f b6 00             	movzbl (%rax),%eax
    133d:	3c 39                	cmp    $0x39,%al
    133f:	7e c2                	jle    1303 <atoi+0x15>
  return n;
    1341:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1344:	c9                   	leave
    1345:	c3                   	ret

0000000000001346 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1346:	55                   	push   %rbp
    1347:	48 89 e5             	mov    %rsp,%rbp
    134a:	48 83 ec 28          	sub    $0x28,%rsp
    134e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1352:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1356:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    1359:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    135d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1361:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1365:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    1369:	eb 1d                	jmp    1388 <memmove+0x42>
    *dst++ = *src++;
    136b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    136f:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1373:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1377:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    137b:	48 8d 48 01          	lea    0x1(%rax),%rcx
    137f:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1383:	0f b6 12             	movzbl (%rdx),%edx
    1386:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1388:	8b 45 dc             	mov    -0x24(%rbp),%eax
    138b:	8d 50 ff             	lea    -0x1(%rax),%edx
    138e:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1391:	85 c0                	test   %eax,%eax
    1393:	7f d6                	jg     136b <memmove+0x25>
  return vdst;
    1395:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1399:	c9                   	leave
    139a:	c3                   	ret

000000000000139b <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    139b:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    13a2:	49 89 ca             	mov    %rcx,%r10
    13a5:	0f 05                	syscall
    13a7:	c3                   	ret

00000000000013a8 <exit>:
SYSCALL(exit)
    13a8:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    13af:	49 89 ca             	mov    %rcx,%r10
    13b2:	0f 05                	syscall
    13b4:	c3                   	ret

00000000000013b5 <wait>:
SYSCALL(wait)
    13b5:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    13bc:	49 89 ca             	mov    %rcx,%r10
    13bf:	0f 05                	syscall
    13c1:	c3                   	ret

00000000000013c2 <pipe>:
SYSCALL(pipe)
    13c2:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    13c9:	49 89 ca             	mov    %rcx,%r10
    13cc:	0f 05                	syscall
    13ce:	c3                   	ret

00000000000013cf <read>:
SYSCALL(read)
    13cf:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    13d6:	49 89 ca             	mov    %rcx,%r10
    13d9:	0f 05                	syscall
    13db:	c3                   	ret

00000000000013dc <write>:
SYSCALL(write)
    13dc:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    13e3:	49 89 ca             	mov    %rcx,%r10
    13e6:	0f 05                	syscall
    13e8:	c3                   	ret

00000000000013e9 <close>:
SYSCALL(close)
    13e9:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    13f0:	49 89 ca             	mov    %rcx,%r10
    13f3:	0f 05                	syscall
    13f5:	c3                   	ret

00000000000013f6 <kill>:
SYSCALL(kill)
    13f6:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    13fd:	49 89 ca             	mov    %rcx,%r10
    1400:	0f 05                	syscall
    1402:	c3                   	ret

0000000000001403 <exec>:
SYSCALL(exec)
    1403:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    140a:	49 89 ca             	mov    %rcx,%r10
    140d:	0f 05                	syscall
    140f:	c3                   	ret

0000000000001410 <open>:
SYSCALL(open)
    1410:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    1417:	49 89 ca             	mov    %rcx,%r10
    141a:	0f 05                	syscall
    141c:	c3                   	ret

000000000000141d <mknod>:
SYSCALL(mknod)
    141d:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1424:	49 89 ca             	mov    %rcx,%r10
    1427:	0f 05                	syscall
    1429:	c3                   	ret

000000000000142a <unlink>:
SYSCALL(unlink)
    142a:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1431:	49 89 ca             	mov    %rcx,%r10
    1434:	0f 05                	syscall
    1436:	c3                   	ret

0000000000001437 <fstat>:
SYSCALL(fstat)
    1437:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    143e:	49 89 ca             	mov    %rcx,%r10
    1441:	0f 05                	syscall
    1443:	c3                   	ret

0000000000001444 <link>:
SYSCALL(link)
    1444:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    144b:	49 89 ca             	mov    %rcx,%r10
    144e:	0f 05                	syscall
    1450:	c3                   	ret

0000000000001451 <mkdir>:
SYSCALL(mkdir)
    1451:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1458:	49 89 ca             	mov    %rcx,%r10
    145b:	0f 05                	syscall
    145d:	c3                   	ret

000000000000145e <chdir>:
SYSCALL(chdir)
    145e:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1465:	49 89 ca             	mov    %rcx,%r10
    1468:	0f 05                	syscall
    146a:	c3                   	ret

000000000000146b <dup>:
SYSCALL(dup)
    146b:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1472:	49 89 ca             	mov    %rcx,%r10
    1475:	0f 05                	syscall
    1477:	c3                   	ret

0000000000001478 <getpid>:
SYSCALL(getpid)
    1478:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    147f:	49 89 ca             	mov    %rcx,%r10
    1482:	0f 05                	syscall
    1484:	c3                   	ret

0000000000001485 <sbrk>:
SYSCALL(sbrk)
    1485:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    148c:	49 89 ca             	mov    %rcx,%r10
    148f:	0f 05                	syscall
    1491:	c3                   	ret

0000000000001492 <sleep>:
SYSCALL(sleep)
    1492:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    1499:	49 89 ca             	mov    %rcx,%r10
    149c:	0f 05                	syscall
    149e:	c3                   	ret

000000000000149f <uptime>:
SYSCALL(uptime)
    149f:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    14a6:	49 89 ca             	mov    %rcx,%r10
    14a9:	0f 05                	syscall
    14ab:	c3                   	ret

00000000000014ac <mmap>:
SYSCALL(mmap)
    14ac:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    14b3:	49 89 ca             	mov    %rcx,%r10
    14b6:	0f 05                	syscall
    14b8:	c3                   	ret

00000000000014b9 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14b9:	55                   	push   %rbp
    14ba:	48 89 e5             	mov    %rsp,%rbp
    14bd:	48 83 ec 10          	sub    $0x10,%rsp
    14c1:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14c4:	89 f0                	mov    %esi,%eax
    14c6:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    14c9:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    14cd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14d0:	ba 01 00 00 00       	mov    $0x1,%edx
    14d5:	48 89 ce             	mov    %rcx,%rsi
    14d8:	89 c7                	mov    %eax,%edi
    14da:	48 b8 dc 13 00 00 00 	movabs $0x13dc,%rax
    14e1:	00 00 00 
    14e4:	ff d0                	call   *%rax
}
    14e6:	90                   	nop
    14e7:	c9                   	leave
    14e8:	c3                   	ret

00000000000014e9 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    14e9:	55                   	push   %rbp
    14ea:	48 89 e5             	mov    %rsp,%rbp
    14ed:	48 83 ec 20          	sub    $0x20,%rsp
    14f1:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14f4:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14ff:	eb 35                	jmp    1536 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    1501:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1505:	48 c1 e8 3c          	shr    $0x3c,%rax
    1509:	48 ba d0 1d 00 00 00 	movabs $0x1dd0,%rdx
    1510:	00 00 00 
    1513:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1517:	0f be d0             	movsbl %al,%edx
    151a:	8b 45 ec             	mov    -0x14(%rbp),%eax
    151d:	89 d6                	mov    %edx,%esi
    151f:	89 c7                	mov    %eax,%edi
    1521:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1528:	00 00 00 
    152b:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    152d:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1531:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1536:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1539:	83 f8 0f             	cmp    $0xf,%eax
    153c:	76 c3                	jbe    1501 <print_x64+0x18>
}
    153e:	90                   	nop
    153f:	90                   	nop
    1540:	c9                   	leave
    1541:	c3                   	ret

0000000000001542 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1542:	55                   	push   %rbp
    1543:	48 89 e5             	mov    %rsp,%rbp
    1546:	48 83 ec 20          	sub    $0x20,%rsp
    154a:	89 7d ec             	mov    %edi,-0x14(%rbp)
    154d:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1550:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1557:	eb 36                	jmp    158f <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1559:	8b 45 e8             	mov    -0x18(%rbp),%eax
    155c:	c1 e8 1c             	shr    $0x1c,%eax
    155f:	89 c2                	mov    %eax,%edx
    1561:	48 b8 d0 1d 00 00 00 	movabs $0x1dd0,%rax
    1568:	00 00 00 
    156b:	89 d2                	mov    %edx,%edx
    156d:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1571:	0f be d0             	movsbl %al,%edx
    1574:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1577:	89 d6                	mov    %edx,%esi
    1579:	89 c7                	mov    %eax,%edi
    157b:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1582:	00 00 00 
    1585:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1587:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    158b:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    158f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1592:	83 f8 07             	cmp    $0x7,%eax
    1595:	76 c2                	jbe    1559 <print_x32+0x17>
}
    1597:	90                   	nop
    1598:	90                   	nop
    1599:	c9                   	leave
    159a:	c3                   	ret

000000000000159b <print_d>:

  static void
print_d(int fd, int v)
{
    159b:	55                   	push   %rbp
    159c:	48 89 e5             	mov    %rsp,%rbp
    159f:	48 83 ec 30          	sub    $0x30,%rsp
    15a3:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15a6:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15a9:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15ac:	48 98                	cltq
    15ae:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15b2:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15b6:	79 04                	jns    15bc <print_d+0x21>
    x = -x;
    15b8:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15c3:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15c7:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15ce:	66 66 66 
    15d1:	48 89 c8             	mov    %rcx,%rax
    15d4:	48 f7 ea             	imul   %rdx
    15d7:	48 c1 fa 02          	sar    $0x2,%rdx
    15db:	48 89 c8             	mov    %rcx,%rax
    15de:	48 c1 f8 3f          	sar    $0x3f,%rax
    15e2:	48 29 c2             	sub    %rax,%rdx
    15e5:	48 89 d0             	mov    %rdx,%rax
    15e8:	48 c1 e0 02          	shl    $0x2,%rax
    15ec:	48 01 d0             	add    %rdx,%rax
    15ef:	48 01 c0             	add    %rax,%rax
    15f2:	48 29 c1             	sub    %rax,%rcx
    15f5:	48 89 ca             	mov    %rcx,%rdx
    15f8:	8b 45 f4             	mov    -0xc(%rbp),%eax
    15fb:	8d 48 01             	lea    0x1(%rax),%ecx
    15fe:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    1601:	48 b9 d0 1d 00 00 00 	movabs $0x1dd0,%rcx
    1608:	00 00 00 
    160b:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    160f:	48 98                	cltq
    1611:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1615:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1619:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1620:	66 66 66 
    1623:	48 89 c8             	mov    %rcx,%rax
    1626:	48 f7 ea             	imul   %rdx
    1629:	48 89 d0             	mov    %rdx,%rax
    162c:	48 c1 f8 02          	sar    $0x2,%rax
    1630:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1634:	48 89 ca             	mov    %rcx,%rdx
    1637:	48 29 d0             	sub    %rdx,%rax
    163a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    163e:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1643:	0f 85 7a ff ff ff    	jne    15c3 <print_d+0x28>

  if (v < 0)
    1649:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    164d:	79 32                	jns    1681 <print_d+0xe6>
    buf[i++] = '-';
    164f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1652:	8d 50 01             	lea    0x1(%rax),%edx
    1655:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1658:	48 98                	cltq
    165a:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    165f:	eb 20                	jmp    1681 <print_d+0xe6>
    putc(fd, buf[i]);
    1661:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1664:	48 98                	cltq
    1666:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    166b:	0f be d0             	movsbl %al,%edx
    166e:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1671:	89 d6                	mov    %edx,%esi
    1673:	89 c7                	mov    %eax,%edi
    1675:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    167c:	00 00 00 
    167f:	ff d0                	call   *%rax
  while (--i >= 0)
    1681:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1685:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1689:	79 d6                	jns    1661 <print_d+0xc6>
}
    168b:	90                   	nop
    168c:	90                   	nop
    168d:	c9                   	leave
    168e:	c3                   	ret

000000000000168f <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    168f:	55                   	push   %rbp
    1690:	48 89 e5             	mov    %rsp,%rbp
    1693:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    169a:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    16a0:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16a7:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16ae:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16b5:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16bc:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16c3:	84 c0                	test   %al,%al
    16c5:	74 20                	je     16e7 <printf+0x58>
    16c7:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    16cb:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    16cf:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    16d3:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    16d7:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    16db:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    16df:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    16e3:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    16e7:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    16ee:	00 00 00 
    16f1:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    16f8:	00 00 00 
    16fb:	48 8d 45 10          	lea    0x10(%rbp),%rax
    16ff:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1706:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    170d:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1714:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    171b:	00 00 00 
    171e:	e9 60 03 00 00       	jmp    1a83 <printf+0x3f4>
    if (c != '%') {
    1723:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    172a:	74 24                	je     1750 <printf+0xc1>
      putc(fd, c);
    172c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1732:	0f be d0             	movsbl %al,%edx
    1735:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    173b:	89 d6                	mov    %edx,%esi
    173d:	89 c7                	mov    %eax,%edi
    173f:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1746:	00 00 00 
    1749:	ff d0                	call   *%rax
      continue;
    174b:	e9 2c 03 00 00       	jmp    1a7c <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1750:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1757:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    175d:	48 63 d0             	movslq %eax,%rdx
    1760:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1767:	48 01 d0             	add    %rdx,%rax
    176a:	0f b6 00             	movzbl (%rax),%eax
    176d:	0f be c0             	movsbl %al,%eax
    1770:	25 ff 00 00 00       	and    $0xff,%eax
    1775:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    177b:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1782:	0f 84 2e 03 00 00    	je     1ab6 <printf+0x427>
      break;
    switch(c) {
    1788:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    178f:	0f 84 32 01 00 00    	je     18c7 <printf+0x238>
    1795:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    179c:	0f 8f a1 02 00 00    	jg     1a43 <printf+0x3b4>
    17a2:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17a9:	0f 84 d4 01 00 00    	je     1983 <printf+0x2f4>
    17af:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17b6:	0f 8f 87 02 00 00    	jg     1a43 <printf+0x3b4>
    17bc:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17c3:	0f 84 5b 01 00 00    	je     1924 <printf+0x295>
    17c9:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17d0:	0f 8f 6d 02 00 00    	jg     1a43 <printf+0x3b4>
    17d6:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17dd:	0f 84 87 00 00 00    	je     186a <printf+0x1db>
    17e3:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17ea:	0f 8f 53 02 00 00    	jg     1a43 <printf+0x3b4>
    17f0:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17f7:	0f 84 2b 02 00 00    	je     1a28 <printf+0x399>
    17fd:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1804:	0f 85 39 02 00 00    	jne    1a43 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    180a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1810:	83 f8 2f             	cmp    $0x2f,%eax
    1813:	77 23                	ja     1838 <printf+0x1a9>
    1815:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    181c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1822:	89 d2                	mov    %edx,%edx
    1824:	48 01 d0             	add    %rdx,%rax
    1827:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    182d:	83 c2 08             	add    $0x8,%edx
    1830:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1836:	eb 12                	jmp    184a <printf+0x1bb>
    1838:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    183f:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1843:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    184a:	8b 00                	mov    (%rax),%eax
    184c:	0f be d0             	movsbl %al,%edx
    184f:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1855:	89 d6                	mov    %edx,%esi
    1857:	89 c7                	mov    %eax,%edi
    1859:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1860:	00 00 00 
    1863:	ff d0                	call   *%rax
      break;
    1865:	e9 12 02 00 00       	jmp    1a7c <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    186a:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1870:	83 f8 2f             	cmp    $0x2f,%eax
    1873:	77 23                	ja     1898 <printf+0x209>
    1875:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    187c:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1882:	89 d2                	mov    %edx,%edx
    1884:	48 01 d0             	add    %rdx,%rax
    1887:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    188d:	83 c2 08             	add    $0x8,%edx
    1890:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1896:	eb 12                	jmp    18aa <printf+0x21b>
    1898:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    189f:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18a3:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18aa:	8b 10                	mov    (%rax),%edx
    18ac:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18b2:	89 d6                	mov    %edx,%esi
    18b4:	89 c7                	mov    %eax,%edi
    18b6:	48 b8 9b 15 00 00 00 	movabs $0x159b,%rax
    18bd:	00 00 00 
    18c0:	ff d0                	call   *%rax
      break;
    18c2:	e9 b5 01 00 00       	jmp    1a7c <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    18c7:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18cd:	83 f8 2f             	cmp    $0x2f,%eax
    18d0:	77 23                	ja     18f5 <printf+0x266>
    18d2:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18d9:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18df:	89 d2                	mov    %edx,%edx
    18e1:	48 01 d0             	add    %rdx,%rax
    18e4:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18ea:	83 c2 08             	add    $0x8,%edx
    18ed:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18f3:	eb 12                	jmp    1907 <printf+0x278>
    18f5:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18fc:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1900:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1907:	8b 10                	mov    (%rax),%edx
    1909:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    190f:	89 d6                	mov    %edx,%esi
    1911:	89 c7                	mov    %eax,%edi
    1913:	48 b8 42 15 00 00 00 	movabs $0x1542,%rax
    191a:	00 00 00 
    191d:	ff d0                	call   *%rax
      break;
    191f:	e9 58 01 00 00       	jmp    1a7c <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1924:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    192a:	83 f8 2f             	cmp    $0x2f,%eax
    192d:	77 23                	ja     1952 <printf+0x2c3>
    192f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1936:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    193c:	89 d2                	mov    %edx,%edx
    193e:	48 01 d0             	add    %rdx,%rax
    1941:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1947:	83 c2 08             	add    $0x8,%edx
    194a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1950:	eb 12                	jmp    1964 <printf+0x2d5>
    1952:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1959:	48 8d 50 08          	lea    0x8(%rax),%rdx
    195d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1964:	48 8b 10             	mov    (%rax),%rdx
    1967:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    196d:	48 89 d6             	mov    %rdx,%rsi
    1970:	89 c7                	mov    %eax,%edi
    1972:	48 b8 e9 14 00 00 00 	movabs $0x14e9,%rax
    1979:	00 00 00 
    197c:	ff d0                	call   *%rax
      break;
    197e:	e9 f9 00 00 00       	jmp    1a7c <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1983:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1989:	83 f8 2f             	cmp    $0x2f,%eax
    198c:	77 23                	ja     19b1 <printf+0x322>
    198e:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1995:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    199b:	89 d2                	mov    %edx,%edx
    199d:	48 01 d0             	add    %rdx,%rax
    19a0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a6:	83 c2 08             	add    $0x8,%edx
    19a9:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19af:	eb 12                	jmp    19c3 <printf+0x334>
    19b1:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19b8:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19bc:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19c3:	48 8b 00             	mov    (%rax),%rax
    19c6:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    19cd:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    19d4:	00 
    19d5:	75 41                	jne    1a18 <printf+0x389>
        s = "(null)";
    19d7:	48 b8 ba 1d 00 00 00 	movabs $0x1dba,%rax
    19de:	00 00 00 
    19e1:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    19e8:	eb 2e                	jmp    1a18 <printf+0x389>
        putc(fd, *(s++));
    19ea:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19f1:	48 8d 50 01          	lea    0x1(%rax),%rdx
    19f5:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    19fc:	0f b6 00             	movzbl (%rax),%eax
    19ff:	0f be d0             	movsbl %al,%edx
    1a02:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a08:	89 d6                	mov    %edx,%esi
    1a0a:	89 c7                	mov    %eax,%edi
    1a0c:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1a13:	00 00 00 
    1a16:	ff d0                	call   *%rax
      while (*s)
    1a18:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a1f:	0f b6 00             	movzbl (%rax),%eax
    1a22:	84 c0                	test   %al,%al
    1a24:	75 c4                	jne    19ea <printf+0x35b>
      break;
    1a26:	eb 54                	jmp    1a7c <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1a28:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a2e:	be 25 00 00 00       	mov    $0x25,%esi
    1a33:	89 c7                	mov    %eax,%edi
    1a35:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1a3c:	00 00 00 
    1a3f:	ff d0                	call   *%rax
      break;
    1a41:	eb 39                	jmp    1a7c <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a43:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a49:	be 25 00 00 00       	mov    $0x25,%esi
    1a4e:	89 c7                	mov    %eax,%edi
    1a50:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1a57:	00 00 00 
    1a5a:	ff d0                	call   *%rax
      putc(fd, c);
    1a5c:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a62:	0f be d0             	movsbl %al,%edx
    1a65:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a6b:	89 d6                	mov    %edx,%esi
    1a6d:	89 c7                	mov    %eax,%edi
    1a6f:	48 b8 b9 14 00 00 00 	movabs $0x14b9,%rax
    1a76:	00 00 00 
    1a79:	ff d0                	call   *%rax
      break;
    1a7b:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a7c:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a83:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a89:	48 63 d0             	movslq %eax,%rdx
    1a8c:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a93:	48 01 d0             	add    %rdx,%rax
    1a96:	0f b6 00             	movzbl (%rax),%eax
    1a99:	0f be c0             	movsbl %al,%eax
    1a9c:	25 ff 00 00 00       	and    $0xff,%eax
    1aa1:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1aa7:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1aae:	0f 85 6f fc ff ff    	jne    1723 <printf+0x94>
    }
  }
}
    1ab4:	eb 01                	jmp    1ab7 <printf+0x428>
      break;
    1ab6:	90                   	nop
}
    1ab7:	90                   	nop
    1ab8:	c9                   	leave
    1ab9:	c3                   	ret

0000000000001aba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1aba:	55                   	push   %rbp
    1abb:	48 89 e5             	mov    %rsp,%rbp
    1abe:	48 83 ec 18          	sub    $0x18,%rsp
    1ac2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1ac6:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1aca:	48 83 e8 10          	sub    $0x10,%rax
    1ace:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ad2:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1ad9:	00 00 00 
    1adc:	48 8b 00             	mov    (%rax),%rax
    1adf:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ae3:	eb 2f                	jmp    1b14 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ae5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ae9:	48 8b 00             	mov    (%rax),%rax
    1aec:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1af0:	72 17                	jb     1b09 <free+0x4f>
    1af2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1af6:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1afa:	72 2f                	jb     1b2b <free+0x71>
    1afc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b00:	48 8b 00             	mov    (%rax),%rax
    1b03:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b07:	72 22                	jb     1b2b <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b09:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b0d:	48 8b 00             	mov    (%rax),%rax
    1b10:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b14:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b18:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b1c:	73 c7                	jae    1ae5 <free+0x2b>
    1b1e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b22:	48 8b 00             	mov    (%rax),%rax
    1b25:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b29:	73 ba                	jae    1ae5 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b2b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b2f:	8b 40 08             	mov    0x8(%rax),%eax
    1b32:	89 c0                	mov    %eax,%eax
    1b34:	48 c1 e0 04          	shl    $0x4,%rax
    1b38:	48 89 c2             	mov    %rax,%rdx
    1b3b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b3f:	48 01 c2             	add    %rax,%rdx
    1b42:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b46:	48 8b 00             	mov    (%rax),%rax
    1b49:	48 39 c2             	cmp    %rax,%rdx
    1b4c:	75 2d                	jne    1b7b <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1b4e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b52:	8b 50 08             	mov    0x8(%rax),%edx
    1b55:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b59:	48 8b 00             	mov    (%rax),%rax
    1b5c:	8b 40 08             	mov    0x8(%rax),%eax
    1b5f:	01 c2                	add    %eax,%edx
    1b61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b65:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b6c:	48 8b 00             	mov    (%rax),%rax
    1b6f:	48 8b 10             	mov    (%rax),%rdx
    1b72:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b76:	48 89 10             	mov    %rdx,(%rax)
    1b79:	eb 0e                	jmp    1b89 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1b7b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b7f:	48 8b 10             	mov    (%rax),%rdx
    1b82:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b86:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1b89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8d:	8b 40 08             	mov    0x8(%rax),%eax
    1b90:	89 c0                	mov    %eax,%eax
    1b92:	48 c1 e0 04          	shl    $0x4,%rax
    1b96:	48 89 c2             	mov    %rax,%rdx
    1b99:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b9d:	48 01 d0             	add    %rdx,%rax
    1ba0:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ba4:	75 27                	jne    1bcd <free+0x113>
    p->s.size += bp->s.size;
    1ba6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1baa:	8b 50 08             	mov    0x8(%rax),%edx
    1bad:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bb1:	8b 40 08             	mov    0x8(%rax),%eax
    1bb4:	01 c2                	add    %eax,%edx
    1bb6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bba:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1bbd:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bc1:	48 8b 10             	mov    (%rax),%rdx
    1bc4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc8:	48 89 10             	mov    %rdx,(%rax)
    1bcb:	eb 0b                	jmp    1bd8 <free+0x11e>
  } else
    p->s.ptr = bp;
    1bcd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bd1:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1bd5:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1bd8:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1bdf:	00 00 00 
    1be2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be6:	48 89 02             	mov    %rax,(%rdx)
}
    1be9:	90                   	nop
    1bea:	c9                   	leave
    1beb:	c3                   	ret

0000000000001bec <morecore>:

static Header*
morecore(uint nu)
{
    1bec:	55                   	push   %rbp
    1bed:	48 89 e5             	mov    %rsp,%rbp
    1bf0:	48 83 ec 20          	sub    $0x20,%rsp
    1bf4:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1bf7:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1bfe:	77 07                	ja     1c07 <morecore+0x1b>
    nu = 4096;
    1c00:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c07:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c0a:	48 c1 e0 04          	shl    $0x4,%rax
    1c0e:	48 89 c7             	mov    %rax,%rdi
    1c11:	48 b8 85 14 00 00 00 	movabs $0x1485,%rax
    1c18:	00 00 00 
    1c1b:	ff d0                	call   *%rax
    1c1d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c21:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c26:	75 07                	jne    1c2f <morecore+0x43>
    return 0;
    1c28:	b8 00 00 00 00       	mov    $0x0,%eax
    1c2d:	eb 36                	jmp    1c65 <morecore+0x79>
  hp = (Header*)p;
    1c2f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c33:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c37:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c3b:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c3e:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c41:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c45:	48 83 c0 10          	add    $0x10,%rax
    1c49:	48 89 c7             	mov    %rax,%rdi
    1c4c:	48 b8 ba 1a 00 00 00 	movabs $0x1aba,%rax
    1c53:	00 00 00 
    1c56:	ff d0                	call   *%rax
  return freep;
    1c58:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1c5f:	00 00 00 
    1c62:	48 8b 00             	mov    (%rax),%rax
}
    1c65:	c9                   	leave
    1c66:	c3                   	ret

0000000000001c67 <malloc>:

void*
malloc(uint nbytes)
{
    1c67:	55                   	push   %rbp
    1c68:	48 89 e5             	mov    %rsp,%rbp
    1c6b:	48 83 ec 30          	sub    $0x30,%rsp
    1c6f:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c72:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c75:	48 83 c0 0f          	add    $0xf,%rax
    1c79:	48 c1 e8 04          	shr    $0x4,%rax
    1c7d:	83 c0 01             	add    $0x1,%eax
    1c80:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c83:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1c8a:	00 00 00 
    1c8d:	48 8b 00             	mov    (%rax),%rax
    1c90:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c94:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c99:	75 4a                	jne    1ce5 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1c9b:	48 b8 f0 1d 00 00 00 	movabs $0x1df0,%rax
    1ca2:	00 00 00 
    1ca5:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ca9:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1cb0:	00 00 00 
    1cb3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb7:	48 89 02             	mov    %rax,(%rdx)
    1cba:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1cc1:	00 00 00 
    1cc4:	48 8b 00             	mov    (%rax),%rax
    1cc7:	48 ba f0 1d 00 00 00 	movabs $0x1df0,%rdx
    1cce:	00 00 00 
    1cd1:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1cd4:	48 b8 f0 1d 00 00 00 	movabs $0x1df0,%rax
    1cdb:	00 00 00 
    1cde:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ce5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce9:	48 8b 00             	mov    (%rax),%rax
    1cec:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1cf0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf4:	8b 40 08             	mov    0x8(%rax),%eax
    1cf7:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1cfa:	72 65                	jb     1d61 <malloc+0xfa>
      if(p->s.size == nunits)
    1cfc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d00:	8b 40 08             	mov    0x8(%rax),%eax
    1d03:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d06:	75 10                	jne    1d18 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d08:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d0c:	48 8b 10             	mov    (%rax),%rdx
    1d0f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d13:	48 89 10             	mov    %rdx,(%rax)
    1d16:	eb 2e                	jmp    1d46 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1d18:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d1c:	8b 40 08             	mov    0x8(%rax),%eax
    1d1f:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d22:	89 c2                	mov    %eax,%edx
    1d24:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d28:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d2b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2f:	8b 40 08             	mov    0x8(%rax),%eax
    1d32:	89 c0                	mov    %eax,%eax
    1d34:	48 c1 e0 04          	shl    $0x4,%rax
    1d38:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d3c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d40:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d43:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d46:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1d4d:	00 00 00 
    1d50:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d54:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d57:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d5b:	48 83 c0 10          	add    $0x10,%rax
    1d5f:	eb 4e                	jmp    1daf <malloc+0x148>
    }
    if(p == freep)
    1d61:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1d68:	00 00 00 
    1d6b:	48 8b 00             	mov    (%rax),%rax
    1d6e:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d72:	75 23                	jne    1d97 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1d74:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d77:	89 c7                	mov    %eax,%edi
    1d79:	48 b8 ec 1b 00 00 00 	movabs $0x1bec,%rax
    1d80:	00 00 00 
    1d83:	ff d0                	call   *%rax
    1d85:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d89:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d8e:	75 07                	jne    1d97 <malloc+0x130>
        return 0;
    1d90:	b8 00 00 00 00       	mov    $0x0,%eax
    1d95:	eb 18                	jmp    1daf <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d9b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d9f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da3:	48 8b 00             	mov    (%rax),%rax
    1da6:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1daa:	e9 41 ff ff ff       	jmp    1cf0 <malloc+0x89>
  }
}
    1daf:	c9                   	leave
    1db0:	c3                   	ret
