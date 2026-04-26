
_alarmtest1:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char **argv)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 10          	sub    $0x10,%rsp
    1008:	89 7d fc             	mov    %edi,-0x4(%rbp)
    100b:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  fgproc();
    100f:	48 b8 a9 14 00 00 00 	movabs $0x14a9,%rax
    1016:	00 00 00 
    1019:	ff d0                	call   *%rax
  alarm(3);
    101b:	bf 03 00 00 00       	mov    $0x3,%edi
    1020:	48 b8 82 14 00 00 00 	movabs $0x1482,%rax
    1027:	00 00 00 
    102a:	ff d0                	call   *%rax
  while (1)
  {
    printf(1, "Still looping...\n");
    102c:	48 b8 ae 1d 00 00 00 	movabs $0x1dae,%rax
    1033:	00 00 00 
    1036:	48 89 c6             	mov    %rax,%rsi
    1039:	bf 01 00 00 00       	mov    $0x1,%edi
    103e:	b8 00 00 00 00       	mov    $0x0,%eax
    1043:	48 ba 8c 16 00 00 00 	movabs $0x168c,%rdx
    104a:	00 00 00 
    104d:	ff d2                	call   *%rdx
    sleep(500);
    104f:	bf f4 01 00 00       	mov    $0x1f4,%edi
    1054:	48 b8 68 14 00 00 00 	movabs $0x1468,%rax
    105b:	00 00 00 
    105e:	ff d0                	call   *%rax
    printf(1, "Still looping...\n");
    1060:	90                   	nop
    1061:	eb c9                	jmp    102c <main+0x2c>

0000000000001063 <stosb>:
  asm volatile("cld; rep outsl" : "=S"(addr), "=c"(cnt) : "d"(port), "0"(addr), "1"(cnt) : "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1063:	55                   	push   %rbp
    1064:	48 89 e5             	mov    %rsp,%rbp
    1067:	48 83 ec 10          	sub    $0x10,%rsp
    106b:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    106f:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1072:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" : "=D"(addr), "=c"(cnt) : "0"(addr), "1"(cnt), "a"(data) : "memory", "cc");
    1075:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1079:	8b 55 f0             	mov    -0x10(%rbp),%edx
    107c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    107f:	48 89 ce             	mov    %rcx,%rsi
    1082:	48 89 f7             	mov    %rsi,%rdi
    1085:	89 d1                	mov    %edx,%ecx
    1087:	fc                   	cld
    1088:	f3 aa                	rep stos %al,(%rdi)
    108a:	89 ca                	mov    %ecx,%edx
    108c:	48 89 fe             	mov    %rdi,%rsi
    108f:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    1093:	89 55 f0             	mov    %edx,-0x10(%rbp)
}
    1096:	90                   	nop
    1097:	c9                   	leave
    1098:	c3                   	ret

0000000000001099 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1099:	55                   	push   %rbp
    109a:	48 89 e5             	mov    %rsp,%rbp
    109d:	48 83 ec 20          	sub    $0x20,%rsp
    10a1:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    10a5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    10a9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    10b1:	90                   	nop
    10b2:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    10b6:	48 8d 42 01          	lea    0x1(%rdx),%rax
    10ba:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10be:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    10c2:	48 8d 48 01          	lea    0x1(%rax),%rcx
    10c6:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    10ca:	0f b6 12             	movzbl (%rdx),%edx
    10cd:	88 10                	mov    %dl,(%rax)
    10cf:	0f b6 00             	movzbl (%rax),%eax
    10d2:	84 c0                	test   %al,%al
    10d4:	75 dc                	jne    10b2 <strcpy+0x19>
    ;
  return os;
    10d6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    10da:	c9                   	leave
    10db:	c3                   	ret

00000000000010dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10dc:	55                   	push   %rbp
    10dd:	48 89 e5             	mov    %rsp,%rbp
    10e0:	48 83 ec 10          	sub    $0x10,%rsp
    10e4:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    10e8:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    10ec:	eb 0a                	jmp    10f8 <strcmp+0x1c>
    p++, q++;
    10ee:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    10f3:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    10f8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    10fc:	0f b6 00             	movzbl (%rax),%eax
    10ff:	84 c0                	test   %al,%al
    1101:	74 12                	je     1115 <strcmp+0x39>
    1103:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1107:	0f b6 10             	movzbl (%rax),%edx
    110a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    110e:	0f b6 00             	movzbl (%rax),%eax
    1111:	38 c2                	cmp    %al,%dl
    1113:	74 d9                	je     10ee <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1115:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1119:	0f b6 00             	movzbl (%rax),%eax
    111c:	0f b6 d0             	movzbl %al,%edx
    111f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1123:	0f b6 00             	movzbl (%rax),%eax
    1126:	0f b6 c0             	movzbl %al,%eax
    1129:	29 c2                	sub    %eax,%edx
    112b:	89 d0                	mov    %edx,%eax
}
    112d:	c9                   	leave
    112e:	c3                   	ret

000000000000112f <strlen>:

uint
strlen(char *s)
{
    112f:	55                   	push   %rbp
    1130:	48 89 e5             	mov    %rsp,%rbp
    1133:	48 83 ec 18          	sub    $0x18,%rsp
    1137:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    113b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1142:	eb 04                	jmp    1148 <strlen+0x19>
    1144:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1148:	8b 45 fc             	mov    -0x4(%rbp),%eax
    114b:	48 63 d0             	movslq %eax,%rdx
    114e:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1152:	48 01 d0             	add    %rdx,%rax
    1155:	0f b6 00             	movzbl (%rax),%eax
    1158:	84 c0                	test   %al,%al
    115a:	75 e8                	jne    1144 <strlen+0x15>
    ;
  return n;
    115c:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    115f:	c9                   	leave
    1160:	c3                   	ret

0000000000001161 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1161:	55                   	push   %rbp
    1162:	48 89 e5             	mov    %rsp,%rbp
    1165:	48 83 ec 10          	sub    $0x10,%rsp
    1169:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    116d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    1170:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    1173:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1176:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1179:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    117d:	89 ce                	mov    %ecx,%esi
    117f:	48 89 c7             	mov    %rax,%rdi
    1182:	48 b8 63 10 00 00 00 	movabs $0x1063,%rax
    1189:	00 00 00 
    118c:	ff d0                	call   *%rax
  return dst;
    118e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    1192:	c9                   	leave
    1193:	c3                   	ret

0000000000001194 <strchr>:

char*
strchr(const char *s, char c)
{
    1194:	55                   	push   %rbp
    1195:	48 89 e5             	mov    %rsp,%rbp
    1198:	48 83 ec 10          	sub    $0x10,%rsp
    119c:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    11a0:	89 f0                	mov    %esi,%eax
    11a2:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    11a5:	eb 17                	jmp    11be <strchr+0x2a>
    if(*s == c)
    11a7:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11ab:	0f b6 00             	movzbl (%rax),%eax
    11ae:	38 45 f4             	cmp    %al,-0xc(%rbp)
    11b1:	75 06                	jne    11b9 <strchr+0x25>
      return (char*)s;
    11b3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11b7:	eb 15                	jmp    11ce <strchr+0x3a>
  for(; *s; s++)
    11b9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    11be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    11c2:	0f b6 00             	movzbl (%rax),%eax
    11c5:	84 c0                	test   %al,%al
    11c7:	75 de                	jne    11a7 <strchr+0x13>
  return 0;
    11c9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    11ce:	c9                   	leave
    11cf:	c3                   	ret

00000000000011d0 <gets>:

char*
gets(char *buf, int max)
{
    11d0:	55                   	push   %rbp
    11d1:	48 89 e5             	mov    %rsp,%rbp
    11d4:	48 83 ec 20          	sub    $0x20,%rsp
    11d8:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    11dc:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    11df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    11e6:	eb 4f                	jmp    1237 <gets+0x67>
    cc = read(0, &c, 1);
    11e8:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    11ec:	ba 01 00 00 00       	mov    $0x1,%edx
    11f1:	48 89 c6             	mov    %rax,%rsi
    11f4:	bf 00 00 00 00       	mov    $0x0,%edi
    11f9:	48 b8 a5 13 00 00 00 	movabs $0x13a5,%rax
    1200:	00 00 00 
    1203:	ff d0                	call   *%rax
    1205:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1208:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    120c:	7e 36                	jle    1244 <gets+0x74>
      break;
    buf[i++] = c;
    120e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1211:	8d 50 01             	lea    0x1(%rax),%edx
    1214:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1217:	48 63 d0             	movslq %eax,%rdx
    121a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    121e:	48 01 c2             	add    %rax,%rdx
    1221:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1225:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1227:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    122b:	3c 0a                	cmp    $0xa,%al
    122d:	74 16                	je     1245 <gets+0x75>
    122f:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1233:	3c 0d                	cmp    $0xd,%al
    1235:	74 0e                	je     1245 <gets+0x75>
  for(i=0; i+1 < max; ){
    1237:	8b 45 fc             	mov    -0x4(%rbp),%eax
    123a:	83 c0 01             	add    $0x1,%eax
    123d:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    1240:	7f a6                	jg     11e8 <gets+0x18>
    1242:	eb 01                	jmp    1245 <gets+0x75>
      break;
    1244:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1245:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1248:	48 63 d0             	movslq %eax,%rdx
    124b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    124f:	48 01 d0             	add    %rdx,%rax
    1252:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1255:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1259:	c9                   	leave
    125a:	c3                   	ret

000000000000125b <stat>:

int
stat(char *n, struct stat *st)
{
    125b:	55                   	push   %rbp
    125c:	48 89 e5             	mov    %rsp,%rbp
    125f:	48 83 ec 20          	sub    $0x20,%rsp
    1263:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1267:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    126b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    126f:	be 00 00 00 00       	mov    $0x0,%esi
    1274:	48 89 c7             	mov    %rax,%rdi
    1277:	48 b8 e6 13 00 00 00 	movabs $0x13e6,%rax
    127e:	00 00 00 
    1281:	ff d0                	call   *%rax
    1283:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1286:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    128a:	79 07                	jns    1293 <stat+0x38>
    return -1;
    128c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1291:	eb 2f                	jmp    12c2 <stat+0x67>
  r = fstat(fd, st);
    1293:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    1297:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129a:	48 89 d6             	mov    %rdx,%rsi
    129d:	89 c7                	mov    %eax,%edi
    129f:	48 b8 0d 14 00 00 00 	movabs $0x140d,%rax
    12a6:	00 00 00 
    12a9:	ff d0                	call   *%rax
    12ab:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    12ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    12b1:	89 c7                	mov    %eax,%edi
    12b3:	48 b8 bf 13 00 00 00 	movabs $0x13bf,%rax
    12ba:	00 00 00 
    12bd:	ff d0                	call   *%rax
  return r;
    12bf:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    12c2:	c9                   	leave
    12c3:	c3                   	ret

00000000000012c4 <atoi>:

int
atoi(const char *s)
{
    12c4:	55                   	push   %rbp
    12c5:	48 89 e5             	mov    %rsp,%rbp
    12c8:	48 83 ec 18          	sub    $0x18,%rsp
    12cc:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    12d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    12d7:	eb 28                	jmp    1301 <atoi+0x3d>
    n = n*10 + *s++ - '0';
    12d9:	8b 55 fc             	mov    -0x4(%rbp),%edx
    12dc:	89 d0                	mov    %edx,%eax
    12de:	c1 e0 02             	shl    $0x2,%eax
    12e1:	01 d0                	add    %edx,%eax
    12e3:	01 c0                	add    %eax,%eax
    12e5:	89 c1                	mov    %eax,%ecx
    12e7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    12eb:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12ef:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    12f3:	0f b6 00             	movzbl (%rax),%eax
    12f6:	0f be c0             	movsbl %al,%eax
    12f9:	01 c8                	add    %ecx,%eax
    12fb:	83 e8 30             	sub    $0x30,%eax
    12fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    1301:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1305:	0f b6 00             	movzbl (%rax),%eax
    1308:	3c 2f                	cmp    $0x2f,%al
    130a:	7e 0b                	jle    1317 <atoi+0x53>
    130c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1310:	0f b6 00             	movzbl (%rax),%eax
    1313:	3c 39                	cmp    $0x39,%al
    1315:	7e c2                	jle    12d9 <atoi+0x15>
  return n;
    1317:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    131a:	c9                   	leave
    131b:	c3                   	ret

000000000000131c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    131c:	55                   	push   %rbp
    131d:	48 89 e5             	mov    %rsp,%rbp
    1320:	48 83 ec 28          	sub    $0x28,%rsp
    1324:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1328:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    132c:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    132f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1333:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1337:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    133b:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    133f:	eb 1d                	jmp    135e <memmove+0x42>
    *dst++ = *src++;
    1341:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1345:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1349:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    134d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1351:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1355:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1359:	0f b6 12             	movzbl (%rdx),%edx
    135c:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    135e:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1361:	8d 50 ff             	lea    -0x1(%rax),%edx
    1364:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1367:	85 c0                	test   %eax,%eax
    1369:	7f d6                	jg     1341 <memmove+0x25>
  return vdst;
    136b:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    136f:	c9                   	leave
    1370:	c3                   	ret

0000000000001371 <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    1371:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1378:	49 89 ca             	mov    %rcx,%r10
    137b:	0f 05                	syscall
    137d:	c3                   	ret

000000000000137e <exit>:
SYSCALL(exit)
    137e:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1385:	49 89 ca             	mov    %rcx,%r10
    1388:	0f 05                	syscall
    138a:	c3                   	ret

000000000000138b <wait>:
SYSCALL(wait)
    138b:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    1392:	49 89 ca             	mov    %rcx,%r10
    1395:	0f 05                	syscall
    1397:	c3                   	ret

0000000000001398 <pipe>:
SYSCALL(pipe)
    1398:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    139f:	49 89 ca             	mov    %rcx,%r10
    13a2:	0f 05                	syscall
    13a4:	c3                   	ret

00000000000013a5 <read>:
SYSCALL(read)
    13a5:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    13ac:	49 89 ca             	mov    %rcx,%r10
    13af:	0f 05                	syscall
    13b1:	c3                   	ret

00000000000013b2 <write>:
SYSCALL(write)
    13b2:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    13b9:	49 89 ca             	mov    %rcx,%r10
    13bc:	0f 05                	syscall
    13be:	c3                   	ret

00000000000013bf <close>:
SYSCALL(close)
    13bf:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    13c6:	49 89 ca             	mov    %rcx,%r10
    13c9:	0f 05                	syscall
    13cb:	c3                   	ret

00000000000013cc <kill>:
SYSCALL(kill)
    13cc:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    13d3:	49 89 ca             	mov    %rcx,%r10
    13d6:	0f 05                	syscall
    13d8:	c3                   	ret

00000000000013d9 <exec>:
SYSCALL(exec)
    13d9:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    13e0:	49 89 ca             	mov    %rcx,%r10
    13e3:	0f 05                	syscall
    13e5:	c3                   	ret

00000000000013e6 <open>:
SYSCALL(open)
    13e6:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    13ed:	49 89 ca             	mov    %rcx,%r10
    13f0:	0f 05                	syscall
    13f2:	c3                   	ret

00000000000013f3 <mknod>:
SYSCALL(mknod)
    13f3:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    13fa:	49 89 ca             	mov    %rcx,%r10
    13fd:	0f 05                	syscall
    13ff:	c3                   	ret

0000000000001400 <unlink>:
SYSCALL(unlink)
    1400:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1407:	49 89 ca             	mov    %rcx,%r10
    140a:	0f 05                	syscall
    140c:	c3                   	ret

000000000000140d <fstat>:
SYSCALL(fstat)
    140d:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    1414:	49 89 ca             	mov    %rcx,%r10
    1417:	0f 05                	syscall
    1419:	c3                   	ret

000000000000141a <link>:
SYSCALL(link)
    141a:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    1421:	49 89 ca             	mov    %rcx,%r10
    1424:	0f 05                	syscall
    1426:	c3                   	ret

0000000000001427 <mkdir>:
SYSCALL(mkdir)
    1427:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    142e:	49 89 ca             	mov    %rcx,%r10
    1431:	0f 05                	syscall
    1433:	c3                   	ret

0000000000001434 <chdir>:
SYSCALL(chdir)
    1434:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    143b:	49 89 ca             	mov    %rcx,%r10
    143e:	0f 05                	syscall
    1440:	c3                   	ret

0000000000001441 <dup>:
SYSCALL(dup)
    1441:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1448:	49 89 ca             	mov    %rcx,%r10
    144b:	0f 05                	syscall
    144d:	c3                   	ret

000000000000144e <getpid>:
SYSCALL(getpid)
    144e:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1455:	49 89 ca             	mov    %rcx,%r10
    1458:	0f 05                	syscall
    145a:	c3                   	ret

000000000000145b <sbrk>:
SYSCALL(sbrk)
    145b:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    1462:	49 89 ca             	mov    %rcx,%r10
    1465:	0f 05                	syscall
    1467:	c3                   	ret

0000000000001468 <sleep>:
SYSCALL(sleep)
    1468:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    146f:	49 89 ca             	mov    %rcx,%r10
    1472:	0f 05                	syscall
    1474:	c3                   	ret

0000000000001475 <uptime>:
SYSCALL(uptime)
    1475:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    147c:	49 89 ca             	mov    %rcx,%r10
    147f:	0f 05                	syscall
    1481:	c3                   	ret

0000000000001482 <alarm>:

SYSCALL(alarm)
    1482:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1489:	49 89 ca             	mov    %rcx,%r10
    148c:	0f 05                	syscall
    148e:	c3                   	ret

000000000000148f <signal>:
SYSCALL(signal)
    148f:	48 c7 c0 17 00 00 00 	mov    $0x17,%rax
    1496:	49 89 ca             	mov    %rcx,%r10
    1499:	0f 05                	syscall
    149b:	c3                   	ret

000000000000149c <sigret>:
SYSCALL(sigret)
    149c:	48 c7 c0 18 00 00 00 	mov    $0x18,%rax
    14a3:	49 89 ca             	mov    %rcx,%r10
    14a6:	0f 05                	syscall
    14a8:	c3                   	ret

00000000000014a9 <fgproc>:
SYSCALL(fgproc)
    14a9:	48 c7 c0 19 00 00 00 	mov    $0x19,%rax
    14b0:	49 89 ca             	mov    %rcx,%r10
    14b3:	0f 05                	syscall
    14b5:	c3                   	ret

00000000000014b6 <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    14b6:	55                   	push   %rbp
    14b7:	48 89 e5             	mov    %rsp,%rbp
    14ba:	48 83 ec 10          	sub    $0x10,%rsp
    14be:	89 7d fc             	mov    %edi,-0x4(%rbp)
    14c1:	89 f0                	mov    %esi,%eax
    14c3:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    14c6:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    14ca:	8b 45 fc             	mov    -0x4(%rbp),%eax
    14cd:	ba 01 00 00 00       	mov    $0x1,%edx
    14d2:	48 89 ce             	mov    %rcx,%rsi
    14d5:	89 c7                	mov    %eax,%edi
    14d7:	48 b8 b2 13 00 00 00 	movabs $0x13b2,%rax
    14de:	00 00 00 
    14e1:	ff d0                	call   *%rax
}
    14e3:	90                   	nop
    14e4:	c9                   	leave
    14e5:	c3                   	ret

00000000000014e6 <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    14e6:	55                   	push   %rbp
    14e7:	48 89 e5             	mov    %rsp,%rbp
    14ea:	48 83 ec 20          	sub    $0x20,%rsp
    14ee:	89 7d ec             	mov    %edi,-0x14(%rbp)
    14f1:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    14f5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    14fc:	eb 35                	jmp    1533 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    14fe:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1502:	48 c1 e8 3c          	shr    $0x3c,%rax
    1506:	48 ba d0 1d 00 00 00 	movabs $0x1dd0,%rdx
    150d:	00 00 00 
    1510:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1514:	0f be d0             	movsbl %al,%edx
    1517:	8b 45 ec             	mov    -0x14(%rbp),%eax
    151a:	89 d6                	mov    %edx,%esi
    151c:	89 c7                	mov    %eax,%edi
    151e:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1525:	00 00 00 
    1528:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    152a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    152e:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1533:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1536:	83 f8 0f             	cmp    $0xf,%eax
    1539:	76 c3                	jbe    14fe <print_x64+0x18>
}
    153b:	90                   	nop
    153c:	90                   	nop
    153d:	c9                   	leave
    153e:	c3                   	ret

000000000000153f <print_x32>:

  static void
print_x32(int fd, uint x)
{
    153f:	55                   	push   %rbp
    1540:	48 89 e5             	mov    %rsp,%rbp
    1543:	48 83 ec 20          	sub    $0x20,%rsp
    1547:	89 7d ec             	mov    %edi,-0x14(%rbp)
    154a:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    154d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1554:	eb 36                	jmp    158c <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    1556:	8b 45 e8             	mov    -0x18(%rbp),%eax
    1559:	c1 e8 1c             	shr    $0x1c,%eax
    155c:	89 c2                	mov    %eax,%edx
    155e:	48 b8 d0 1d 00 00 00 	movabs $0x1dd0,%rax
    1565:	00 00 00 
    1568:	89 d2                	mov    %edx,%edx
    156a:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    156e:	0f be d0             	movsbl %al,%edx
    1571:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1574:	89 d6                	mov    %edx,%esi
    1576:	89 c7                	mov    %eax,%edi
    1578:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    157f:	00 00 00 
    1582:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1584:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1588:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    158c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    158f:	83 f8 07             	cmp    $0x7,%eax
    1592:	76 c2                	jbe    1556 <print_x32+0x17>
}
    1594:	90                   	nop
    1595:	90                   	nop
    1596:	c9                   	leave
    1597:	c3                   	ret

0000000000001598 <print_d>:

  static void
print_d(int fd, int v)
{
    1598:	55                   	push   %rbp
    1599:	48 89 e5             	mov    %rsp,%rbp
    159c:	48 83 ec 30          	sub    $0x30,%rsp
    15a0:	89 7d dc             	mov    %edi,-0x24(%rbp)
    15a3:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    15a6:	8b 45 d8             	mov    -0x28(%rbp),%eax
    15a9:	48 98                	cltq
    15ab:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    15af:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    15b3:	79 04                	jns    15b9 <print_d+0x21>
    x = -x;
    15b5:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    15b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    15c0:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    15c4:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    15cb:	66 66 66 
    15ce:	48 89 c8             	mov    %rcx,%rax
    15d1:	48 f7 ea             	imul   %rdx
    15d4:	48 c1 fa 02          	sar    $0x2,%rdx
    15d8:	48 89 c8             	mov    %rcx,%rax
    15db:	48 c1 f8 3f          	sar    $0x3f,%rax
    15df:	48 29 c2             	sub    %rax,%rdx
    15e2:	48 89 d0             	mov    %rdx,%rax
    15e5:	48 c1 e0 02          	shl    $0x2,%rax
    15e9:	48 01 d0             	add    %rdx,%rax
    15ec:	48 01 c0             	add    %rax,%rax
    15ef:	48 29 c1             	sub    %rax,%rcx
    15f2:	48 89 ca             	mov    %rcx,%rdx
    15f5:	8b 45 f4             	mov    -0xc(%rbp),%eax
    15f8:	8d 48 01             	lea    0x1(%rax),%ecx
    15fb:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    15fe:	48 b9 d0 1d 00 00 00 	movabs $0x1dd0,%rcx
    1605:	00 00 00 
    1608:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    160c:	48 98                	cltq
    160e:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    1612:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1616:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    161d:	66 66 66 
    1620:	48 89 c8             	mov    %rcx,%rax
    1623:	48 f7 ea             	imul   %rdx
    1626:	48 89 d0             	mov    %rdx,%rax
    1629:	48 c1 f8 02          	sar    $0x2,%rax
    162d:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1631:	48 89 ca             	mov    %rcx,%rdx
    1634:	48 29 d0             	sub    %rdx,%rax
    1637:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    163b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1640:	0f 85 7a ff ff ff    	jne    15c0 <print_d+0x28>

  if (v < 0)
    1646:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    164a:	79 32                	jns    167e <print_d+0xe6>
    buf[i++] = '-';
    164c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    164f:	8d 50 01             	lea    0x1(%rax),%edx
    1652:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1655:	48 98                	cltq
    1657:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    165c:	eb 20                	jmp    167e <print_d+0xe6>
    putc(fd, buf[i]);
    165e:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1661:	48 98                	cltq
    1663:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1668:	0f be d0             	movsbl %al,%edx
    166b:	8b 45 dc             	mov    -0x24(%rbp),%eax
    166e:	89 d6                	mov    %edx,%esi
    1670:	89 c7                	mov    %eax,%edi
    1672:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1679:	00 00 00 
    167c:	ff d0                	call   *%rax
  while (--i >= 0)
    167e:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1682:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1686:	79 d6                	jns    165e <print_d+0xc6>
}
    1688:	90                   	nop
    1689:	90                   	nop
    168a:	c9                   	leave
    168b:	c3                   	ret

000000000000168c <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    168c:	55                   	push   %rbp
    168d:	48 89 e5             	mov    %rsp,%rbp
    1690:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1697:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    169d:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    16a4:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    16ab:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    16b2:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    16b9:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    16c0:	84 c0                	test   %al,%al
    16c2:	74 20                	je     16e4 <printf+0x58>
    16c4:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    16c8:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    16cc:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    16d0:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    16d4:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    16d8:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    16dc:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    16e0:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    16e4:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    16eb:	00 00 00 
    16ee:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    16f5:	00 00 00 
    16f8:	48 8d 45 10          	lea    0x10(%rbp),%rax
    16fc:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1703:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    170a:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1711:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1718:	00 00 00 
    171b:	e9 60 03 00 00       	jmp    1a80 <printf+0x3f4>
    if (c != '%') {
    1720:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1727:	74 24                	je     174d <printf+0xc1>
      putc(fd, c);
    1729:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    172f:	0f be d0             	movsbl %al,%edx
    1732:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1738:	89 d6                	mov    %edx,%esi
    173a:	89 c7                	mov    %eax,%edi
    173c:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1743:	00 00 00 
    1746:	ff d0                	call   *%rax
      continue;
    1748:	e9 2c 03 00 00       	jmp    1a79 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    174d:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1754:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    175a:	48 63 d0             	movslq %eax,%rdx
    175d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1764:	48 01 d0             	add    %rdx,%rax
    1767:	0f b6 00             	movzbl (%rax),%eax
    176a:	0f be c0             	movsbl %al,%eax
    176d:	25 ff 00 00 00       	and    $0xff,%eax
    1772:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1778:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    177f:	0f 84 2e 03 00 00    	je     1ab3 <printf+0x427>
      break;
    switch(c) {
    1785:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    178c:	0f 84 32 01 00 00    	je     18c4 <printf+0x238>
    1792:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1799:	0f 8f a1 02 00 00    	jg     1a40 <printf+0x3b4>
    179f:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17a6:	0f 84 d4 01 00 00    	je     1980 <printf+0x2f4>
    17ac:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    17b3:	0f 8f 87 02 00 00    	jg     1a40 <printf+0x3b4>
    17b9:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17c0:	0f 84 5b 01 00 00    	je     1921 <printf+0x295>
    17c6:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    17cd:	0f 8f 6d 02 00 00    	jg     1a40 <printf+0x3b4>
    17d3:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17da:	0f 84 87 00 00 00    	je     1867 <printf+0x1db>
    17e0:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    17e7:	0f 8f 53 02 00 00    	jg     1a40 <printf+0x3b4>
    17ed:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    17f4:	0f 84 2b 02 00 00    	je     1a25 <printf+0x399>
    17fa:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1801:	0f 85 39 02 00 00    	jne    1a40 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1807:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    180d:	83 f8 2f             	cmp    $0x2f,%eax
    1810:	77 23                	ja     1835 <printf+0x1a9>
    1812:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1819:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    181f:	89 d2                	mov    %edx,%edx
    1821:	48 01 d0             	add    %rdx,%rax
    1824:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    182a:	83 c2 08             	add    $0x8,%edx
    182d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1833:	eb 12                	jmp    1847 <printf+0x1bb>
    1835:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    183c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1840:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1847:	8b 00                	mov    (%rax),%eax
    1849:	0f be d0             	movsbl %al,%edx
    184c:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1852:	89 d6                	mov    %edx,%esi
    1854:	89 c7                	mov    %eax,%edi
    1856:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    185d:	00 00 00 
    1860:	ff d0                	call   *%rax
      break;
    1862:	e9 12 02 00 00       	jmp    1a79 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1867:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    186d:	83 f8 2f             	cmp    $0x2f,%eax
    1870:	77 23                	ja     1895 <printf+0x209>
    1872:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1879:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    187f:	89 d2                	mov    %edx,%edx
    1881:	48 01 d0             	add    %rdx,%rax
    1884:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    188a:	83 c2 08             	add    $0x8,%edx
    188d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1893:	eb 12                	jmp    18a7 <printf+0x21b>
    1895:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    189c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18a0:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    18a7:	8b 10                	mov    (%rax),%edx
    18a9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    18af:	89 d6                	mov    %edx,%esi
    18b1:	89 c7                	mov    %eax,%edi
    18b3:	48 b8 98 15 00 00 00 	movabs $0x1598,%rax
    18ba:	00 00 00 
    18bd:	ff d0                	call   *%rax
      break;
    18bf:	e9 b5 01 00 00       	jmp    1a79 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    18c4:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    18ca:	83 f8 2f             	cmp    $0x2f,%eax
    18cd:	77 23                	ja     18f2 <printf+0x266>
    18cf:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    18d6:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18dc:	89 d2                	mov    %edx,%edx
    18de:	48 01 d0             	add    %rdx,%rax
    18e1:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    18e7:	83 c2 08             	add    $0x8,%edx
    18ea:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    18f0:	eb 12                	jmp    1904 <printf+0x278>
    18f2:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    18f9:	48 8d 50 08          	lea    0x8(%rax),%rdx
    18fd:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1904:	8b 10                	mov    (%rax),%edx
    1906:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    190c:	89 d6                	mov    %edx,%esi
    190e:	89 c7                	mov    %eax,%edi
    1910:	48 b8 3f 15 00 00 00 	movabs $0x153f,%rax
    1917:	00 00 00 
    191a:	ff d0                	call   *%rax
      break;
    191c:	e9 58 01 00 00       	jmp    1a79 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1921:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1927:	83 f8 2f             	cmp    $0x2f,%eax
    192a:	77 23                	ja     194f <printf+0x2c3>
    192c:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1933:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1939:	89 d2                	mov    %edx,%edx
    193b:	48 01 d0             	add    %rdx,%rax
    193e:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1944:	83 c2 08             	add    $0x8,%edx
    1947:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    194d:	eb 12                	jmp    1961 <printf+0x2d5>
    194f:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1956:	48 8d 50 08          	lea    0x8(%rax),%rdx
    195a:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1961:	48 8b 10             	mov    (%rax),%rdx
    1964:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    196a:	48 89 d6             	mov    %rdx,%rsi
    196d:	89 c7                	mov    %eax,%edi
    196f:	48 b8 e6 14 00 00 00 	movabs $0x14e6,%rax
    1976:	00 00 00 
    1979:	ff d0                	call   *%rax
      break;
    197b:	e9 f9 00 00 00       	jmp    1a79 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1980:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1986:	83 f8 2f             	cmp    $0x2f,%eax
    1989:	77 23                	ja     19ae <printf+0x322>
    198b:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1992:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1998:	89 d2                	mov    %edx,%edx
    199a:	48 01 d0             	add    %rdx,%rax
    199d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    19a3:	83 c2 08             	add    $0x8,%edx
    19a6:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    19ac:	eb 12                	jmp    19c0 <printf+0x334>
    19ae:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    19b5:	48 8d 50 08          	lea    0x8(%rax),%rdx
    19b9:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    19c0:	48 8b 00             	mov    (%rax),%rax
    19c3:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    19ca:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    19d1:	00 
    19d2:	75 41                	jne    1a15 <printf+0x389>
        s = "(null)";
    19d4:	48 b8 c0 1d 00 00 00 	movabs $0x1dc0,%rax
    19db:	00 00 00 
    19de:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    19e5:	eb 2e                	jmp    1a15 <printf+0x389>
        putc(fd, *(s++));
    19e7:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    19ee:	48 8d 50 01          	lea    0x1(%rax),%rdx
    19f2:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    19f9:	0f b6 00             	movzbl (%rax),%eax
    19fc:	0f be d0             	movsbl %al,%edx
    19ff:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a05:	89 d6                	mov    %edx,%esi
    1a07:	89 c7                	mov    %eax,%edi
    1a09:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1a10:	00 00 00 
    1a13:	ff d0                	call   *%rax
      while (*s)
    1a15:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1a1c:	0f b6 00             	movzbl (%rax),%eax
    1a1f:	84 c0                	test   %al,%al
    1a21:	75 c4                	jne    19e7 <printf+0x35b>
      break;
    1a23:	eb 54                	jmp    1a79 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1a25:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a2b:	be 25 00 00 00       	mov    $0x25,%esi
    1a30:	89 c7                	mov    %eax,%edi
    1a32:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1a39:	00 00 00 
    1a3c:	ff d0                	call   *%rax
      break;
    1a3e:	eb 39                	jmp    1a79 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1a40:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a46:	be 25 00 00 00       	mov    $0x25,%esi
    1a4b:	89 c7                	mov    %eax,%edi
    1a4d:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1a54:	00 00 00 
    1a57:	ff d0                	call   *%rax
      putc(fd, c);
    1a59:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1a5f:	0f be d0             	movsbl %al,%edx
    1a62:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1a68:	89 d6                	mov    %edx,%esi
    1a6a:	89 c7                	mov    %eax,%edi
    1a6c:	48 b8 b6 14 00 00 00 	movabs $0x14b6,%rax
    1a73:	00 00 00 
    1a76:	ff d0                	call   *%rax
      break;
    1a78:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1a79:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1a80:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1a86:	48 63 d0             	movslq %eax,%rdx
    1a89:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1a90:	48 01 d0             	add    %rdx,%rax
    1a93:	0f b6 00             	movzbl (%rax),%eax
    1a96:	0f be c0             	movsbl %al,%eax
    1a99:	25 ff 00 00 00       	and    $0xff,%eax
    1a9e:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1aa4:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1aab:	0f 85 6f fc ff ff    	jne    1720 <printf+0x94>
    }
  }
}
    1ab1:	eb 01                	jmp    1ab4 <printf+0x428>
      break;
    1ab3:	90                   	nop
}
    1ab4:	90                   	nop
    1ab5:	c9                   	leave
    1ab6:	c3                   	ret

0000000000001ab7 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1ab7:	55                   	push   %rbp
    1ab8:	48 89 e5             	mov    %rsp,%rbp
    1abb:	48 83 ec 18          	sub    $0x18,%rsp
    1abf:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1ac3:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1ac7:	48 83 e8 10          	sub    $0x10,%rax
    1acb:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1acf:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1ad6:	00 00 00 
    1ad9:	48 8b 00             	mov    (%rax),%rax
    1adc:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ae0:	eb 2f                	jmp    1b11 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ae2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ae6:	48 8b 00             	mov    (%rax),%rax
    1ae9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1aed:	72 17                	jb     1b06 <free+0x4f>
    1aef:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1af3:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1af7:	72 2f                	jb     1b28 <free+0x71>
    1af9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1afd:	48 8b 00             	mov    (%rax),%rax
    1b00:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b04:	72 22                	jb     1b28 <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b06:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b0a:	48 8b 00             	mov    (%rax),%rax
    1b0d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1b11:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b15:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1b19:	73 c7                	jae    1ae2 <free+0x2b>
    1b1b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b1f:	48 8b 00             	mov    (%rax),%rax
    1b22:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1b26:	73 ba                	jae    1ae2 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b28:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b2c:	8b 40 08             	mov    0x8(%rax),%eax
    1b2f:	89 c0                	mov    %eax,%eax
    1b31:	48 c1 e0 04          	shl    $0x4,%rax
    1b35:	48 89 c2             	mov    %rax,%rdx
    1b38:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b3c:	48 01 c2             	add    %rax,%rdx
    1b3f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b43:	48 8b 00             	mov    (%rax),%rax
    1b46:	48 39 c2             	cmp    %rax,%rdx
    1b49:	75 2d                	jne    1b78 <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1b4b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b4f:	8b 50 08             	mov    0x8(%rax),%edx
    1b52:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b56:	48 8b 00             	mov    (%rax),%rax
    1b59:	8b 40 08             	mov    0x8(%rax),%eax
    1b5c:	01 c2                	add    %eax,%edx
    1b5e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b62:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b65:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b69:	48 8b 00             	mov    (%rax),%rax
    1b6c:	48 8b 10             	mov    (%rax),%rdx
    1b6f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b73:	48 89 10             	mov    %rdx,(%rax)
    1b76:	eb 0e                	jmp    1b86 <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1b78:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b7c:	48 8b 10             	mov    (%rax),%rdx
    1b7f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1b83:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1b86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b8a:	8b 40 08             	mov    0x8(%rax),%eax
    1b8d:	89 c0                	mov    %eax,%eax
    1b8f:	48 c1 e0 04          	shl    $0x4,%rax
    1b93:	48 89 c2             	mov    %rax,%rdx
    1b96:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1b9a:	48 01 d0             	add    %rdx,%rax
    1b9d:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ba1:	75 27                	jne    1bca <free+0x113>
    p->s.size += bp->s.size;
    1ba3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ba7:	8b 50 08             	mov    0x8(%rax),%edx
    1baa:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bae:	8b 40 08             	mov    0x8(%rax),%eax
    1bb1:	01 c2                	add    %eax,%edx
    1bb3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bb7:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1bba:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1bbe:	48 8b 10             	mov    (%rax),%rdx
    1bc1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bc5:	48 89 10             	mov    %rdx,(%rax)
    1bc8:	eb 0b                	jmp    1bd5 <free+0x11e>
  } else
    p->s.ptr = bp;
    1bca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1bce:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1bd2:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1bd5:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1bdc:	00 00 00 
    1bdf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1be3:	48 89 02             	mov    %rax,(%rdx)
}
    1be6:	90                   	nop
    1be7:	c9                   	leave
    1be8:	c3                   	ret

0000000000001be9 <morecore>:

static Header*
morecore(uint nu)
{
    1be9:	55                   	push   %rbp
    1bea:	48 89 e5             	mov    %rsp,%rbp
    1bed:	48 83 ec 20          	sub    $0x20,%rsp
    1bf1:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1bf4:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1bfb:	77 07                	ja     1c04 <morecore+0x1b>
    nu = 4096;
    1bfd:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1c04:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1c07:	48 c1 e0 04          	shl    $0x4,%rax
    1c0b:	48 89 c7             	mov    %rax,%rdi
    1c0e:	48 b8 5b 14 00 00 00 	movabs $0x145b,%rax
    1c15:	00 00 00 
    1c18:	ff d0                	call   *%rax
    1c1a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    1c1e:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    1c23:	75 07                	jne    1c2c <morecore+0x43>
    return 0;
    1c25:	b8 00 00 00 00       	mov    $0x0,%eax
    1c2a:	eb 36                	jmp    1c62 <morecore+0x79>
  hp = (Header*)p;
    1c2c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1c30:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    1c34:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c38:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1c3b:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    1c3e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1c42:	48 83 c0 10          	add    $0x10,%rax
    1c46:	48 89 c7             	mov    %rax,%rdi
    1c49:	48 b8 b7 1a 00 00 00 	movabs $0x1ab7,%rax
    1c50:	00 00 00 
    1c53:	ff d0                	call   *%rax
  return freep;
    1c55:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1c5c:	00 00 00 
    1c5f:	48 8b 00             	mov    (%rax),%rax
}
    1c62:	c9                   	leave
    1c63:	c3                   	ret

0000000000001c64 <malloc>:

void*
malloc(uint nbytes)
{
    1c64:	55                   	push   %rbp
    1c65:	48 89 e5             	mov    %rsp,%rbp
    1c68:	48 83 ec 30          	sub    $0x30,%rsp
    1c6c:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c6f:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1c72:	48 83 c0 0f          	add    $0xf,%rax
    1c76:	48 c1 e8 04          	shr    $0x4,%rax
    1c7a:	83 c0 01             	add    $0x1,%eax
    1c7d:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    1c80:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1c87:	00 00 00 
    1c8a:	48 8b 00             	mov    (%rax),%rax
    1c8d:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1c91:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    1c96:	75 4a                	jne    1ce2 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    1c98:	48 b8 f0 1d 00 00 00 	movabs $0x1df0,%rax
    1c9f:	00 00 00 
    1ca2:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1ca6:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1cad:	00 00 00 
    1cb0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1cb4:	48 89 02             	mov    %rax,(%rdx)
    1cb7:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1cbe:	00 00 00 
    1cc1:	48 8b 00             	mov    (%rax),%rax
    1cc4:	48 ba f0 1d 00 00 00 	movabs $0x1df0,%rdx
    1ccb:	00 00 00 
    1cce:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    1cd1:	48 b8 f0 1d 00 00 00 	movabs $0x1df0,%rax
    1cd8:	00 00 00 
    1cdb:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ce2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ce6:	48 8b 00             	mov    (%rax),%rax
    1ce9:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1ced:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cf1:	8b 40 08             	mov    0x8(%rax),%eax
    1cf4:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    1cf7:	72 65                	jb     1d5e <malloc+0xfa>
      if(p->s.size == nunits)
    1cf9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1cfd:	8b 40 08             	mov    0x8(%rax),%eax
    1d00:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    1d03:	75 10                	jne    1d15 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    1d05:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d09:	48 8b 10             	mov    (%rax),%rdx
    1d0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d10:	48 89 10             	mov    %rdx,(%rax)
    1d13:	eb 2e                	jmp    1d43 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    1d15:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d19:	8b 40 08             	mov    0x8(%rax),%eax
    1d1c:	2b 45 ec             	sub    -0x14(%rbp),%eax
    1d1f:	89 c2                	mov    %eax,%edx
    1d21:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d25:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    1d28:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d2c:	8b 40 08             	mov    0x8(%rax),%eax
    1d2f:	89 c0                	mov    %eax,%eax
    1d31:	48 c1 e0 04          	shl    $0x4,%rax
    1d35:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    1d39:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d3d:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1d40:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    1d43:	48 ba 00 1e 00 00 00 	movabs $0x1e00,%rdx
    1d4a:	00 00 00 
    1d4d:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1d51:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    1d54:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d58:	48 83 c0 10          	add    $0x10,%rax
    1d5c:	eb 4e                	jmp    1dac <malloc+0x148>
    }
    if(p == freep)
    1d5e:	48 b8 00 1e 00 00 00 	movabs $0x1e00,%rax
    1d65:	00 00 00 
    1d68:	48 8b 00             	mov    (%rax),%rax
    1d6b:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1d6f:	75 23                	jne    1d94 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    1d71:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1d74:	89 c7                	mov    %eax,%edi
    1d76:	48 b8 e9 1b 00 00 00 	movabs $0x1be9,%rax
    1d7d:	00 00 00 
    1d80:	ff d0                	call   *%rax
    1d82:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1d86:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1d8b:	75 07                	jne    1d94 <malloc+0x130>
        return 0;
    1d8d:	b8 00 00 00 00       	mov    $0x0,%eax
    1d92:	eb 18                	jmp    1dac <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d94:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1d98:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1d9c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1da0:	48 8b 00             	mov    (%rax),%rax
    1da3:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    1da7:	e9 41 ff ff ff       	jmp    1ced <malloc+0x89>
  }
}
    1dac:	c9                   	leave
    1dad:	c3                   	ret
