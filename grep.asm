
_grep:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 30          	sub    $0x30,%rsp
    1008:	48 89 7d d8          	mov    %rdi,-0x28(%rbp)
    100c:	89 75 d4             	mov    %esi,-0x2c(%rbp)
  int n, m;
  char *p, *q;

  m = 0;
    100f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1016:	e9 09 01 00 00       	jmp    1124 <grep+0x124>
    m += n;
    101b:	8b 45 ec             	mov    -0x14(%rbp),%eax
    101e:	01 45 fc             	add    %eax,-0x4(%rbp)
    buf[m] = '\0';
    1021:	48 ba 00 22 00 00 00 	movabs $0x2200,%rdx
    1028:	00 00 00 
    102b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    102e:	48 98                	cltq
    1030:	c6 04 02 00          	movb   $0x0,(%rdx,%rax,1)
    p = buf;
    1034:	48 b8 00 22 00 00 00 	movabs $0x2200,%rax
    103b:	00 00 00 
    103e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    while((q = strchr(p, '\n')) != 0){
    1042:	eb 5e                	jmp    10a2 <grep+0xa2>
      *q = 0;
    1044:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1048:	c6 00 00             	movb   $0x0,(%rax)
      if(match(pattern, p)){
    104b:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    104f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1053:	48 89 d6             	mov    %rdx,%rsi
    1056:	48 89 c7             	mov    %rax,%rdi
    1059:	48 b8 b2 12 00 00 00 	movabs $0x12b2,%rax
    1060:	00 00 00 
    1063:	ff d0                	call   *%rax
    1065:	85 c0                	test   %eax,%eax
    1067:	74 2d                	je     1096 <grep+0x96>
        *q = '\n';
    1069:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    106d:	c6 00 0a             	movb   $0xa,(%rax)
        write(1, p, q+1 - p);
    1070:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1074:	48 83 c0 01          	add    $0x1,%rax
    1078:	48 2b 45 f0          	sub    -0x10(%rbp),%rax
    107c:	89 c2                	mov    %eax,%edx
    107e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1082:	48 89 c6             	mov    %rax,%rsi
    1085:	bf 01 00 00 00       	mov    $0x1,%edi
    108a:	48 b8 bd 17 00 00 00 	movabs $0x17bd,%rax
    1091:	00 00 00 
    1094:	ff d0                	call   *%rax
      }
      p = q+1;
    1096:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    109a:	48 83 c0 01          	add    $0x1,%rax
    109e:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    while((q = strchr(p, '\n')) != 0){
    10a2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    10a6:	be 0a 00 00 00       	mov    $0xa,%esi
    10ab:	48 89 c7             	mov    %rax,%rdi
    10ae:	48 b8 9f 15 00 00 00 	movabs $0x159f,%rax
    10b5:	00 00 00 
    10b8:	ff d0                	call   *%rax
    10ba:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    10be:	48 83 7d e0 00       	cmpq   $0x0,-0x20(%rbp)
    10c3:	0f 85 7b ff ff ff    	jne    1044 <grep+0x44>
    }
    if(p == buf)
    10c9:	48 b8 00 22 00 00 00 	movabs $0x2200,%rax
    10d0:	00 00 00 
    10d3:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    10d7:	75 07                	jne    10e0 <grep+0xe0>
      m = 0;
    10d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    if(m > 0){
    10e0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    10e4:	7e 3e                	jle    1124 <grep+0x124>
      m -= p - buf;
    10e6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    10e9:	48 ba 00 22 00 00 00 	movabs $0x2200,%rdx
    10f0:	00 00 00 
    10f3:	48 8b 4d f0          	mov    -0x10(%rbp),%rcx
    10f7:	48 29 d1             	sub    %rdx,%rcx
    10fa:	89 ca                	mov    %ecx,%edx
    10fc:	29 d0                	sub    %edx,%eax
    10fe:	89 45 fc             	mov    %eax,-0x4(%rbp)
      memmove(buf, p, m);
    1101:	8b 55 fc             	mov    -0x4(%rbp),%edx
    1104:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1108:	48 b9 00 22 00 00 00 	movabs $0x2200,%rcx
    110f:	00 00 00 
    1112:	48 89 c6             	mov    %rax,%rsi
    1115:	48 89 cf             	mov    %rcx,%rdi
    1118:	48 b8 27 17 00 00 00 	movabs $0x1727,%rax
    111f:	00 00 00 
    1122:	ff d0                	call   *%rax
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    1124:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1127:	ba ff 03 00 00       	mov    $0x3ff,%edx
    112c:	29 c2                	sub    %eax,%edx
    112e:	89 d6                	mov    %edx,%esi
    1130:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1133:	48 98                	cltq
    1135:	48 ba 00 22 00 00 00 	movabs $0x2200,%rdx
    113c:	00 00 00 
    113f:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
    1143:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    1146:	89 f2                	mov    %esi,%edx
    1148:	48 89 ce             	mov    %rcx,%rsi
    114b:	89 c7                	mov    %eax,%edi
    114d:	48 b8 b0 17 00 00 00 	movabs $0x17b0,%rax
    1154:	00 00 00 
    1157:	ff d0                	call   *%rax
    1159:	89 45 ec             	mov    %eax,-0x14(%rbp)
    115c:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1160:	0f 8f b5 fe ff ff    	jg     101b <grep+0x1b>
    }
  }
}
    1166:	90                   	nop
    1167:	90                   	nop
    1168:	c9                   	leave
    1169:	c3                   	ret

000000000000116a <main>:

int
main(int argc, char *argv[])
{
    116a:	55                   	push   %rbp
    116b:	48 89 e5             	mov    %rsp,%rbp
    116e:	48 83 ec 30          	sub    $0x30,%rsp
    1172:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1175:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
  int fd, i;
  char *pattern;

  if(argc <= 1){
    1179:	83 7d dc 01          	cmpl   $0x1,-0x24(%rbp)
    117d:	7f 2f                	jg     11ae <main+0x44>
    printf(2, "usage: grep pattern [file ...]\n");
    117f:	48 b8 98 21 00 00 00 	movabs $0x2198,%rax
    1186:	00 00 00 
    1189:	48 89 c6             	mov    %rax,%rsi
    118c:	bf 02 00 00 00       	mov    $0x2,%edi
    1191:	b8 00 00 00 00       	mov    $0x0,%eax
    1196:	48 ba 70 1a 00 00 00 	movabs $0x1a70,%rdx
    119d:	00 00 00 
    11a0:	ff d2                	call   *%rdx
    exit();
    11a2:	48 b8 89 17 00 00 00 	movabs $0x1789,%rax
    11a9:	00 00 00 
    11ac:	ff d0                	call   *%rax
  }
  pattern = argv[1];
    11ae:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    11b2:	48 8b 40 08          	mov    0x8(%rax),%rax
    11b6:	48 89 45 f0          	mov    %rax,-0x10(%rbp)

  if(argc <= 2){
    11ba:	83 7d dc 02          	cmpl   $0x2,-0x24(%rbp)
    11be:	7f 24                	jg     11e4 <main+0x7a>
    grep(pattern, 0);
    11c0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    11c4:	be 00 00 00 00       	mov    $0x0,%esi
    11c9:	48 89 c7             	mov    %rax,%rdi
    11cc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11d3:	00 00 00 
    11d6:	ff d0                	call   *%rax
    exit();
    11d8:	48 b8 89 17 00 00 00 	movabs $0x1789,%rax
    11df:	00 00 00 
    11e2:	ff d0                	call   *%rax
  }

  for(i = 2; i < argc; i++){
    11e4:	c7 45 fc 02 00 00 00 	movl   $0x2,-0x4(%rbp)
    11eb:	e9 aa 00 00 00       	jmp    129a <main+0x130>
    if((fd = open(argv[i], 0)) < 0){
    11f0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    11f3:	48 98                	cltq
    11f5:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    11fc:	00 
    11fd:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1201:	48 01 d0             	add    %rdx,%rax
    1204:	48 8b 00             	mov    (%rax),%rax
    1207:	be 00 00 00 00       	mov    $0x0,%esi
    120c:	48 89 c7             	mov    %rax,%rdi
    120f:	48 b8 f1 17 00 00 00 	movabs $0x17f1,%rax
    1216:	00 00 00 
    1219:	ff d0                	call   *%rax
    121b:	89 45 ec             	mov    %eax,-0x14(%rbp)
    121e:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    1222:	79 49                	jns    126d <main+0x103>
      printf(1, "grep: cannot open %s\n", argv[i]);
    1224:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1227:	48 98                	cltq
    1229:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    1230:	00 
    1231:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    1235:	48 01 d0             	add    %rdx,%rax
    1238:	48 8b 00             	mov    (%rax),%rax
    123b:	48 b9 b8 21 00 00 00 	movabs $0x21b8,%rcx
    1242:	00 00 00 
    1245:	48 89 c2             	mov    %rax,%rdx
    1248:	48 89 ce             	mov    %rcx,%rsi
    124b:	bf 01 00 00 00       	mov    $0x1,%edi
    1250:	b8 00 00 00 00       	mov    $0x0,%eax
    1255:	48 b9 70 1a 00 00 00 	movabs $0x1a70,%rcx
    125c:	00 00 00 
    125f:	ff d1                	call   *%rcx
      exit();
    1261:	48 b8 89 17 00 00 00 	movabs $0x1789,%rax
    1268:	00 00 00 
    126b:	ff d0                	call   *%rax
    }
    grep(pattern, fd);
    126d:	8b 55 ec             	mov    -0x14(%rbp),%edx
    1270:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1274:	89 d6                	mov    %edx,%esi
    1276:	48 89 c7             	mov    %rax,%rdi
    1279:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1280:	00 00 00 
    1283:	ff d0                	call   *%rax
    close(fd);
    1285:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1288:	89 c7                	mov    %eax,%edi
    128a:	48 b8 ca 17 00 00 00 	movabs $0x17ca,%rax
    1291:	00 00 00 
    1294:	ff d0                	call   *%rax
  for(i = 2; i < argc; i++){
    1296:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    129a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    129d:	3b 45 dc             	cmp    -0x24(%rbp),%eax
    12a0:	0f 8c 4a ff ff ff    	jl     11f0 <main+0x86>
  }
  exit();
    12a6:	48 b8 89 17 00 00 00 	movabs $0x1789,%rax
    12ad:	00 00 00 
    12b0:	ff d0                	call   *%rax

00000000000012b2 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
    12b2:	55                   	push   %rbp
    12b3:	48 89 e5             	mov    %rsp,%rbp
    12b6:	48 83 ec 10          	sub    $0x10,%rsp
    12ba:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    12be:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '^')
    12c2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12c6:	0f b6 00             	movzbl (%rax),%eax
    12c9:	3c 5e                	cmp    $0x5e,%al
    12cb:	75 20                	jne    12ed <match+0x3b>
    return matchhere(re+1, text);
    12cd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12d1:	48 8d 50 01          	lea    0x1(%rax),%rdx
    12d5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    12d9:	48 89 c6             	mov    %rax,%rsi
    12dc:	48 89 d7             	mov    %rdx,%rdi
    12df:	48 b8 2c 13 00 00 00 	movabs $0x132c,%rax
    12e6:	00 00 00 
    12e9:	ff d0                	call   *%rax
    12eb:	eb 3d                	jmp    132a <match+0x78>
  do{  // must look at empty string
    if(matchhere(re, text))
    12ed:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    12f1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    12f5:	48 89 d6             	mov    %rdx,%rsi
    12f8:	48 89 c7             	mov    %rax,%rdi
    12fb:	48 b8 2c 13 00 00 00 	movabs $0x132c,%rax
    1302:	00 00 00 
    1305:	ff d0                	call   *%rax
    1307:	85 c0                	test   %eax,%eax
    1309:	74 07                	je     1312 <match+0x60>
      return 1;
    130b:	b8 01 00 00 00       	mov    $0x1,%eax
    1310:	eb 18                	jmp    132a <match+0x78>
  }while(*text++ != '\0');
    1312:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1316:	48 8d 50 01          	lea    0x1(%rax),%rdx
    131a:	48 89 55 f0          	mov    %rdx,-0x10(%rbp)
    131e:	0f b6 00             	movzbl (%rax),%eax
    1321:	84 c0                	test   %al,%al
    1323:	75 c8                	jne    12ed <match+0x3b>
  return 0;
    1325:	b8 00 00 00 00       	mov    $0x0,%eax
}
    132a:	c9                   	leave
    132b:	c3                   	ret

000000000000132c <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
    132c:	55                   	push   %rbp
    132d:	48 89 e5             	mov    %rsp,%rbp
    1330:	48 83 ec 10          	sub    $0x10,%rsp
    1334:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1338:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  if(re[0] == '\0')
    133c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1340:	0f b6 00             	movzbl (%rax),%eax
    1343:	84 c0                	test   %al,%al
    1345:	75 0a                	jne    1351 <matchhere+0x25>
    return 1;
    1347:	b8 01 00 00 00       	mov    $0x1,%eax
    134c:	e9 b4 00 00 00       	jmp    1405 <matchhere+0xd9>
  if(re[1] == '*')
    1351:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1355:	48 83 c0 01          	add    $0x1,%rax
    1359:	0f b6 00             	movzbl (%rax),%eax
    135c:	3c 2a                	cmp    $0x2a,%al
    135e:	75 29                	jne    1389 <matchhere+0x5d>
    return matchstar(re[0], re+2, text);
    1360:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1364:	48 8d 48 02          	lea    0x2(%rax),%rcx
    1368:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    136c:	0f b6 00             	movzbl (%rax),%eax
    136f:	0f be c0             	movsbl %al,%eax
    1372:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1376:	48 89 ce             	mov    %rcx,%rsi
    1379:	89 c7                	mov    %eax,%edi
    137b:	48 b8 07 14 00 00 00 	movabs $0x1407,%rax
    1382:	00 00 00 
    1385:	ff d0                	call   *%rax
    1387:	eb 7c                	jmp    1405 <matchhere+0xd9>
  if(re[0] == '$' && re[1] == '\0')
    1389:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    138d:	0f b6 00             	movzbl (%rax),%eax
    1390:	3c 24                	cmp    $0x24,%al
    1392:	75 20                	jne    13b4 <matchhere+0x88>
    1394:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1398:	48 83 c0 01          	add    $0x1,%rax
    139c:	0f b6 00             	movzbl (%rax),%eax
    139f:	84 c0                	test   %al,%al
    13a1:	75 11                	jne    13b4 <matchhere+0x88>
    return *text == '\0';
    13a3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13a7:	0f b6 00             	movzbl (%rax),%eax
    13aa:	84 c0                	test   %al,%al
    13ac:	0f 94 c0             	sete   %al
    13af:	0f b6 c0             	movzbl %al,%eax
    13b2:	eb 51                	jmp    1405 <matchhere+0xd9>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    13b4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13b8:	0f b6 00             	movzbl (%rax),%eax
    13bb:	84 c0                	test   %al,%al
    13bd:	74 41                	je     1400 <matchhere+0xd4>
    13bf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13c3:	0f b6 00             	movzbl (%rax),%eax
    13c6:	3c 2e                	cmp    $0x2e,%al
    13c8:	74 12                	je     13dc <matchhere+0xb0>
    13ca:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13ce:	0f b6 10             	movzbl (%rax),%edx
    13d1:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13d5:	0f b6 00             	movzbl (%rax),%eax
    13d8:	38 c2                	cmp    %al,%dl
    13da:	75 24                	jne    1400 <matchhere+0xd4>
    return matchhere(re+1, text+1);
    13dc:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    13e0:	48 8d 50 01          	lea    0x1(%rax),%rdx
    13e4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    13e8:	48 83 c0 01          	add    $0x1,%rax
    13ec:	48 89 d6             	mov    %rdx,%rsi
    13ef:	48 89 c7             	mov    %rax,%rdi
    13f2:	48 b8 2c 13 00 00 00 	movabs $0x132c,%rax
    13f9:	00 00 00 
    13fc:	ff d0                	call   *%rax
    13fe:	eb 05                	jmp    1405 <matchhere+0xd9>
  return 0;
    1400:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1405:	c9                   	leave
    1406:	c3                   	ret

0000000000001407 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    1407:	55                   	push   %rbp
    1408:	48 89 e5             	mov    %rsp,%rbp
    140b:	48 83 ec 20          	sub    $0x20,%rsp
    140f:	89 7d fc             	mov    %edi,-0x4(%rbp)
    1412:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
    1416:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
    141a:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    141e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1422:	48 89 d6             	mov    %rdx,%rsi
    1425:	48 89 c7             	mov    %rax,%rdi
    1428:	48 b8 2c 13 00 00 00 	movabs $0x132c,%rax
    142f:	00 00 00 
    1432:	ff d0                	call   *%rax
    1434:	85 c0                	test   %eax,%eax
    1436:	74 07                	je     143f <matchstar+0x38>
      return 1;
    1438:	b8 01 00 00 00       	mov    $0x1,%eax
    143d:	eb 2d                	jmp    146c <matchstar+0x65>
  }while(*text!='\0' && (*text++==c || c=='.'));
    143f:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1443:	0f b6 00             	movzbl (%rax),%eax
    1446:	84 c0                	test   %al,%al
    1448:	74 1d                	je     1467 <matchstar+0x60>
    144a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    144e:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1452:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    1456:	0f b6 00             	movzbl (%rax),%eax
    1459:	0f be c0             	movsbl %al,%eax
    145c:	39 45 fc             	cmp    %eax,-0x4(%rbp)
    145f:	74 b9                	je     141a <matchstar+0x13>
    1461:	83 7d fc 2e          	cmpl   $0x2e,-0x4(%rbp)
    1465:	74 b3                	je     141a <matchstar+0x13>
  return 0;
    1467:	b8 00 00 00 00       	mov    $0x0,%eax
}
    146c:	c9                   	leave
    146d:	c3                   	ret

000000000000146e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    146e:	55                   	push   %rbp
    146f:	48 89 e5             	mov    %rsp,%rbp
    1472:	48 83 ec 10          	sub    $0x10,%rsp
    1476:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    147a:	89 75 f4             	mov    %esi,-0xc(%rbp)
    147d:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    1480:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    1484:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1487:	8b 45 f4             	mov    -0xc(%rbp),%eax
    148a:	48 89 ce             	mov    %rcx,%rsi
    148d:	48 89 f7             	mov    %rsi,%rdi
    1490:	89 d1                	mov    %edx,%ecx
    1492:	fc                   	cld
    1493:	f3 aa                	rep stos %al,(%rdi)
    1495:	89 ca                	mov    %ecx,%edx
    1497:	48 89 fe             	mov    %rdi,%rsi
    149a:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    149e:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    14a1:	90                   	nop
    14a2:	c9                   	leave
    14a3:	c3                   	ret

00000000000014a4 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    14a4:	55                   	push   %rbp
    14a5:	48 89 e5             	mov    %rsp,%rbp
    14a8:	48 83 ec 20          	sub    $0x20,%rsp
    14ac:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    14b0:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    14b4:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14b8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    14bc:	90                   	nop
    14bd:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    14c1:	48 8d 42 01          	lea    0x1(%rdx),%rax
    14c5:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    14c9:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    14cd:	48 8d 48 01          	lea    0x1(%rax),%rcx
    14d1:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    14d5:	0f b6 12             	movzbl (%rdx),%edx
    14d8:	88 10                	mov    %dl,(%rax)
    14da:	0f b6 00             	movzbl (%rax),%eax
    14dd:	84 c0                	test   %al,%al
    14df:	75 dc                	jne    14bd <strcpy+0x19>
    ;
  return os;
    14e1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    14e5:	c9                   	leave
    14e6:	c3                   	ret

00000000000014e7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    14e7:	55                   	push   %rbp
    14e8:	48 89 e5             	mov    %rsp,%rbp
    14eb:	48 83 ec 10          	sub    $0x10,%rsp
    14ef:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    14f3:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    14f7:	eb 0a                	jmp    1503 <strcmp+0x1c>
    p++, q++;
    14f9:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    14fe:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    1503:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1507:	0f b6 00             	movzbl (%rax),%eax
    150a:	84 c0                	test   %al,%al
    150c:	74 12                	je     1520 <strcmp+0x39>
    150e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1512:	0f b6 10             	movzbl (%rax),%edx
    1515:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1519:	0f b6 00             	movzbl (%rax),%eax
    151c:	38 c2                	cmp    %al,%dl
    151e:	74 d9                	je     14f9 <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    1520:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1524:	0f b6 00             	movzbl (%rax),%eax
    1527:	0f b6 d0             	movzbl %al,%edx
    152a:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    152e:	0f b6 00             	movzbl (%rax),%eax
    1531:	0f b6 c0             	movzbl %al,%eax
    1534:	29 c2                	sub    %eax,%edx
    1536:	89 d0                	mov    %edx,%eax
}
    1538:	c9                   	leave
    1539:	c3                   	ret

000000000000153a <strlen>:

uint
strlen(char *s)
{
    153a:	55                   	push   %rbp
    153b:	48 89 e5             	mov    %rsp,%rbp
    153e:	48 83 ec 18          	sub    $0x18,%rsp
    1542:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    1546:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    154d:	eb 04                	jmp    1553 <strlen+0x19>
    154f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1553:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1556:	48 63 d0             	movslq %eax,%rdx
    1559:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    155d:	48 01 d0             	add    %rdx,%rax
    1560:	0f b6 00             	movzbl (%rax),%eax
    1563:	84 c0                	test   %al,%al
    1565:	75 e8                	jne    154f <strlen+0x15>
    ;
  return n;
    1567:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    156a:	c9                   	leave
    156b:	c3                   	ret

000000000000156c <memset>:

void*
memset(void *dst, int c, uint n)
{
    156c:	55                   	push   %rbp
    156d:	48 89 e5             	mov    %rsp,%rbp
    1570:	48 83 ec 10          	sub    $0x10,%rsp
    1574:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    1578:	89 75 f4             	mov    %esi,-0xc(%rbp)
    157b:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    157e:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1581:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    1584:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1588:	89 ce                	mov    %ecx,%esi
    158a:	48 89 c7             	mov    %rax,%rdi
    158d:	48 b8 6e 14 00 00 00 	movabs $0x146e,%rax
    1594:	00 00 00 
    1597:	ff d0                	call   *%rax
  return dst;
    1599:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    159d:	c9                   	leave
    159e:	c3                   	ret

000000000000159f <strchr>:

char*
strchr(const char *s, char c)
{
    159f:	55                   	push   %rbp
    15a0:	48 89 e5             	mov    %rsp,%rbp
    15a3:	48 83 ec 10          	sub    $0x10,%rsp
    15a7:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    15ab:	89 f0                	mov    %esi,%eax
    15ad:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    15b0:	eb 17                	jmp    15c9 <strchr+0x2a>
    if(*s == c)
    15b2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15b6:	0f b6 00             	movzbl (%rax),%eax
    15b9:	38 45 f4             	cmp    %al,-0xc(%rbp)
    15bc:	75 06                	jne    15c4 <strchr+0x25>
      return (char*)s;
    15be:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15c2:	eb 15                	jmp    15d9 <strchr+0x3a>
  for(; *s; s++)
    15c4:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    15c9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    15cd:	0f b6 00             	movzbl (%rax),%eax
    15d0:	84 c0                	test   %al,%al
    15d2:	75 de                	jne    15b2 <strchr+0x13>
  return 0;
    15d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
    15d9:	c9                   	leave
    15da:	c3                   	ret

00000000000015db <gets>:

char*
gets(char *buf, int max)
{
    15db:	55                   	push   %rbp
    15dc:	48 89 e5             	mov    %rsp,%rbp
    15df:	48 83 ec 20          	sub    $0x20,%rsp
    15e3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    15e7:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    15ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    15f1:	eb 4f                	jmp    1642 <gets+0x67>
    cc = read(0, &c, 1);
    15f3:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    15f7:	ba 01 00 00 00       	mov    $0x1,%edx
    15fc:	48 89 c6             	mov    %rax,%rsi
    15ff:	bf 00 00 00 00       	mov    $0x0,%edi
    1604:	48 b8 b0 17 00 00 00 	movabs $0x17b0,%rax
    160b:	00 00 00 
    160e:	ff d0                	call   *%rax
    1610:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    1613:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1617:	7e 36                	jle    164f <gets+0x74>
      break;
    buf[i++] = c;
    1619:	8b 45 fc             	mov    -0x4(%rbp),%eax
    161c:	8d 50 01             	lea    0x1(%rax),%edx
    161f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1622:	48 63 d0             	movslq %eax,%rdx
    1625:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1629:	48 01 c2             	add    %rax,%rdx
    162c:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1630:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    1632:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    1636:	3c 0a                	cmp    $0xa,%al
    1638:	74 16                	je     1650 <gets+0x75>
    163a:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    163e:	3c 0d                	cmp    $0xd,%al
    1640:	74 0e                	je     1650 <gets+0x75>
  for(i=0; i+1 < max; ){
    1642:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1645:	83 c0 01             	add    $0x1,%eax
    1648:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    164b:	7f a6                	jg     15f3 <gets+0x18>
    164d:	eb 01                	jmp    1650 <gets+0x75>
      break;
    164f:	90                   	nop
      break;
  }
  buf[i] = '\0';
    1650:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1653:	48 63 d0             	movslq %eax,%rdx
    1656:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    165a:	48 01 d0             	add    %rdx,%rax
    165d:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    1660:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    1664:	c9                   	leave
    1665:	c3                   	ret

0000000000001666 <stat>:

int
stat(char *n, struct stat *st)
{
    1666:	55                   	push   %rbp
    1667:	48 89 e5             	mov    %rsp,%rbp
    166a:	48 83 ec 20          	sub    $0x20,%rsp
    166e:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1672:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1676:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    167a:	be 00 00 00 00       	mov    $0x0,%esi
    167f:	48 89 c7             	mov    %rax,%rdi
    1682:	48 b8 f1 17 00 00 00 	movabs $0x17f1,%rax
    1689:	00 00 00 
    168c:	ff d0                	call   *%rax
    168e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    1691:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1695:	79 07                	jns    169e <stat+0x38>
    return -1;
    1697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    169c:	eb 2f                	jmp    16cd <stat+0x67>
  r = fstat(fd, st);
    169e:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    16a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16a5:	48 89 d6             	mov    %rdx,%rsi
    16a8:	89 c7                	mov    %eax,%edi
    16aa:	48 b8 18 18 00 00 00 	movabs $0x1818,%rax
    16b1:	00 00 00 
    16b4:	ff d0                	call   *%rax
    16b6:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    16b9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    16bc:	89 c7                	mov    %eax,%edi
    16be:	48 b8 ca 17 00 00 00 	movabs $0x17ca,%rax
    16c5:	00 00 00 
    16c8:	ff d0                	call   *%rax
  return r;
    16ca:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    16cd:	c9                   	leave
    16ce:	c3                   	ret

00000000000016cf <atoi>:

int
atoi(const char *s)
{
    16cf:	55                   	push   %rbp
    16d0:	48 89 e5             	mov    %rsp,%rbp
    16d3:	48 83 ec 18          	sub    $0x18,%rsp
    16d7:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    16db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    16e2:	eb 28                	jmp    170c <atoi+0x3d>
    n = n*10 + *s++ - '0';
    16e4:	8b 55 fc             	mov    -0x4(%rbp),%edx
    16e7:	89 d0                	mov    %edx,%eax
    16e9:	c1 e0 02             	shl    $0x2,%eax
    16ec:	01 d0                	add    %edx,%eax
    16ee:	01 c0                	add    %eax,%eax
    16f0:	89 c1                	mov    %eax,%ecx
    16f2:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    16f6:	48 8d 50 01          	lea    0x1(%rax),%rdx
    16fa:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    16fe:	0f b6 00             	movzbl (%rax),%eax
    1701:	0f be c0             	movsbl %al,%eax
    1704:	01 c8                	add    %ecx,%eax
    1706:	83 e8 30             	sub    $0x30,%eax
    1709:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    170c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1710:	0f b6 00             	movzbl (%rax),%eax
    1713:	3c 2f                	cmp    $0x2f,%al
    1715:	7e 0b                	jle    1722 <atoi+0x53>
    1717:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    171b:	0f b6 00             	movzbl (%rax),%eax
    171e:	3c 39                	cmp    $0x39,%al
    1720:	7e c2                	jle    16e4 <atoi+0x15>
  return n;
    1722:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    1725:	c9                   	leave
    1726:	c3                   	ret

0000000000001727 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1727:	55                   	push   %rbp
    1728:	48 89 e5             	mov    %rsp,%rbp
    172b:	48 83 ec 28          	sub    $0x28,%rsp
    172f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    1733:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    1737:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    173a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    173e:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    1742:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    1746:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    174a:	eb 1d                	jmp    1769 <memmove+0x42>
    *dst++ = *src++;
    174c:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1750:	48 8d 42 01          	lea    0x1(%rdx),%rax
    1754:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    1758:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    175c:	48 8d 48 01          	lea    0x1(%rax),%rcx
    1760:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    1764:	0f b6 12             	movzbl (%rdx),%edx
    1767:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    1769:	8b 45 dc             	mov    -0x24(%rbp),%eax
    176c:	8d 50 ff             	lea    -0x1(%rax),%edx
    176f:	89 55 dc             	mov    %edx,-0x24(%rbp)
    1772:	85 c0                	test   %eax,%eax
    1774:	7f d6                	jg     174c <memmove+0x25>
  return vdst;
    1776:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    177a:	c9                   	leave
    177b:	c3                   	ret

000000000000177c <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    177c:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    1783:	49 89 ca             	mov    %rcx,%r10
    1786:	0f 05                	syscall
    1788:	c3                   	ret

0000000000001789 <exit>:
SYSCALL(exit)
    1789:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    1790:	49 89 ca             	mov    %rcx,%r10
    1793:	0f 05                	syscall
    1795:	c3                   	ret

0000000000001796 <wait>:
SYSCALL(wait)
    1796:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    179d:	49 89 ca             	mov    %rcx,%r10
    17a0:	0f 05                	syscall
    17a2:	c3                   	ret

00000000000017a3 <pipe>:
SYSCALL(pipe)
    17a3:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    17aa:	49 89 ca             	mov    %rcx,%r10
    17ad:	0f 05                	syscall
    17af:	c3                   	ret

00000000000017b0 <read>:
SYSCALL(read)
    17b0:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    17b7:	49 89 ca             	mov    %rcx,%r10
    17ba:	0f 05                	syscall
    17bc:	c3                   	ret

00000000000017bd <write>:
SYSCALL(write)
    17bd:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    17c4:	49 89 ca             	mov    %rcx,%r10
    17c7:	0f 05                	syscall
    17c9:	c3                   	ret

00000000000017ca <close>:
SYSCALL(close)
    17ca:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    17d1:	49 89 ca             	mov    %rcx,%r10
    17d4:	0f 05                	syscall
    17d6:	c3                   	ret

00000000000017d7 <kill>:
SYSCALL(kill)
    17d7:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    17de:	49 89 ca             	mov    %rcx,%r10
    17e1:	0f 05                	syscall
    17e3:	c3                   	ret

00000000000017e4 <exec>:
SYSCALL(exec)
    17e4:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    17eb:	49 89 ca             	mov    %rcx,%r10
    17ee:	0f 05                	syscall
    17f0:	c3                   	ret

00000000000017f1 <open>:
SYSCALL(open)
    17f1:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    17f8:	49 89 ca             	mov    %rcx,%r10
    17fb:	0f 05                	syscall
    17fd:	c3                   	ret

00000000000017fe <mknod>:
SYSCALL(mknod)
    17fe:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    1805:	49 89 ca             	mov    %rcx,%r10
    1808:	0f 05                	syscall
    180a:	c3                   	ret

000000000000180b <unlink>:
SYSCALL(unlink)
    180b:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    1812:	49 89 ca             	mov    %rcx,%r10
    1815:	0f 05                	syscall
    1817:	c3                   	ret

0000000000001818 <fstat>:
SYSCALL(fstat)
    1818:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    181f:	49 89 ca             	mov    %rcx,%r10
    1822:	0f 05                	syscall
    1824:	c3                   	ret

0000000000001825 <link>:
SYSCALL(link)
    1825:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    182c:	49 89 ca             	mov    %rcx,%r10
    182f:	0f 05                	syscall
    1831:	c3                   	ret

0000000000001832 <mkdir>:
SYSCALL(mkdir)
    1832:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    1839:	49 89 ca             	mov    %rcx,%r10
    183c:	0f 05                	syscall
    183e:	c3                   	ret

000000000000183f <chdir>:
SYSCALL(chdir)
    183f:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    1846:	49 89 ca             	mov    %rcx,%r10
    1849:	0f 05                	syscall
    184b:	c3                   	ret

000000000000184c <dup>:
SYSCALL(dup)
    184c:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    1853:	49 89 ca             	mov    %rcx,%r10
    1856:	0f 05                	syscall
    1858:	c3                   	ret

0000000000001859 <getpid>:
SYSCALL(getpid)
    1859:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    1860:	49 89 ca             	mov    %rcx,%r10
    1863:	0f 05                	syscall
    1865:	c3                   	ret

0000000000001866 <sbrk>:
SYSCALL(sbrk)
    1866:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    186d:	49 89 ca             	mov    %rcx,%r10
    1870:	0f 05                	syscall
    1872:	c3                   	ret

0000000000001873 <sleep>:
SYSCALL(sleep)
    1873:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    187a:	49 89 ca             	mov    %rcx,%r10
    187d:	0f 05                	syscall
    187f:	c3                   	ret

0000000000001880 <uptime>:
SYSCALL(uptime)
    1880:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    1887:	49 89 ca             	mov    %rcx,%r10
    188a:	0f 05                	syscall
    188c:	c3                   	ret

000000000000188d <traceread>:
SYSCALL(traceread)
    188d:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    1894:	49 89 ca             	mov    %rcx,%r10
    1897:	0f 05                	syscall
    1899:	c3                   	ret

000000000000189a <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    189a:	55                   	push   %rbp
    189b:	48 89 e5             	mov    %rsp,%rbp
    189e:	48 83 ec 10          	sub    $0x10,%rsp
    18a2:	89 7d fc             	mov    %edi,-0x4(%rbp)
    18a5:	89 f0                	mov    %esi,%eax
    18a7:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    18aa:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    18ae:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18b1:	ba 01 00 00 00       	mov    $0x1,%edx
    18b6:	48 89 ce             	mov    %rcx,%rsi
    18b9:	89 c7                	mov    %eax,%edi
    18bb:	48 b8 bd 17 00 00 00 	movabs $0x17bd,%rax
    18c2:	00 00 00 
    18c5:	ff d0                	call   *%rax
}
    18c7:	90                   	nop
    18c8:	c9                   	leave
    18c9:	c3                   	ret

00000000000018ca <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    18ca:	55                   	push   %rbp
    18cb:	48 89 e5             	mov    %rsp,%rbp
    18ce:	48 83 ec 20          	sub    $0x20,%rsp
    18d2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    18d5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    18d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    18e0:	eb 35                	jmp    1917 <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    18e2:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    18e6:	48 c1 e8 3c          	shr    $0x3c,%rax
    18ea:	48 ba e0 21 00 00 00 	movabs $0x21e0,%rdx
    18f1:	00 00 00 
    18f4:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    18f8:	0f be d0             	movsbl %al,%edx
    18fb:	8b 45 ec             	mov    -0x14(%rbp),%eax
    18fe:	89 d6                	mov    %edx,%esi
    1900:	89 c7                	mov    %eax,%edi
    1902:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1909:	00 00 00 
    190c:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    190e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1912:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    1917:	8b 45 fc             	mov    -0x4(%rbp),%eax
    191a:	83 f8 0f             	cmp    $0xf,%eax
    191d:	76 c3                	jbe    18e2 <print_x64+0x18>
}
    191f:	90                   	nop
    1920:	90                   	nop
    1921:	c9                   	leave
    1922:	c3                   	ret

0000000000001923 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    1923:	55                   	push   %rbp
    1924:	48 89 e5             	mov    %rsp,%rbp
    1927:	48 83 ec 20          	sub    $0x20,%rsp
    192b:	89 7d ec             	mov    %edi,-0x14(%rbp)
    192e:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1931:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1938:	eb 36                	jmp    1970 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    193a:	8b 45 e8             	mov    -0x18(%rbp),%eax
    193d:	c1 e8 1c             	shr    $0x1c,%eax
    1940:	89 c2                	mov    %eax,%edx
    1942:	48 b8 e0 21 00 00 00 	movabs $0x21e0,%rax
    1949:	00 00 00 
    194c:	89 d2                	mov    %edx,%edx
    194e:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    1952:	0f be d0             	movsbl %al,%edx
    1955:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1958:	89 d6                	mov    %edx,%esi
    195a:	89 c7                	mov    %eax,%edi
    195c:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1963:	00 00 00 
    1966:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    1968:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    196c:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    1970:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1973:	83 f8 07             	cmp    $0x7,%eax
    1976:	76 c2                	jbe    193a <print_x32+0x17>
}
    1978:	90                   	nop
    1979:	90                   	nop
    197a:	c9                   	leave
    197b:	c3                   	ret

000000000000197c <print_d>:

  static void
print_d(int fd, int v)
{
    197c:	55                   	push   %rbp
    197d:	48 89 e5             	mov    %rsp,%rbp
    1980:	48 83 ec 30          	sub    $0x30,%rsp
    1984:	89 7d dc             	mov    %edi,-0x24(%rbp)
    1987:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    198a:	8b 45 d8             	mov    -0x28(%rbp),%eax
    198d:	48 98                	cltq
    198f:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    1993:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1997:	79 04                	jns    199d <print_d+0x21>
    x = -x;
    1999:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    199d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    19a4:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    19a8:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    19af:	66 66 66 
    19b2:	48 89 c8             	mov    %rcx,%rax
    19b5:	48 f7 ea             	imul   %rdx
    19b8:	48 c1 fa 02          	sar    $0x2,%rdx
    19bc:	48 89 c8             	mov    %rcx,%rax
    19bf:	48 c1 f8 3f          	sar    $0x3f,%rax
    19c3:	48 29 c2             	sub    %rax,%rdx
    19c6:	48 89 d0             	mov    %rdx,%rax
    19c9:	48 c1 e0 02          	shl    $0x2,%rax
    19cd:	48 01 d0             	add    %rdx,%rax
    19d0:	48 01 c0             	add    %rax,%rax
    19d3:	48 29 c1             	sub    %rax,%rcx
    19d6:	48 89 ca             	mov    %rcx,%rdx
    19d9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    19dc:	8d 48 01             	lea    0x1(%rax),%ecx
    19df:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    19e2:	48 b9 e0 21 00 00 00 	movabs $0x21e0,%rcx
    19e9:	00 00 00 
    19ec:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    19f0:	48 98                	cltq
    19f2:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    19f6:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    19fa:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    1a01:	66 66 66 
    1a04:	48 89 c8             	mov    %rcx,%rax
    1a07:	48 f7 ea             	imul   %rdx
    1a0a:	48 89 d0             	mov    %rdx,%rax
    1a0d:	48 c1 f8 02          	sar    $0x2,%rax
    1a11:	48 c1 f9 3f          	sar    $0x3f,%rcx
    1a15:	48 89 ca             	mov    %rcx,%rdx
    1a18:	48 29 d0             	sub    %rdx,%rax
    1a1b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    1a1f:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    1a24:	0f 85 7a ff ff ff    	jne    19a4 <print_d+0x28>

  if (v < 0)
    1a2a:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    1a2e:	79 32                	jns    1a62 <print_d+0xe6>
    buf[i++] = '-';
    1a30:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1a33:	8d 50 01             	lea    0x1(%rax),%edx
    1a36:	89 55 f4             	mov    %edx,-0xc(%rbp)
    1a39:	48 98                	cltq
    1a3b:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    1a40:	eb 20                	jmp    1a62 <print_d+0xe6>
    putc(fd, buf[i]);
    1a42:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1a45:	48 98                	cltq
    1a47:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    1a4c:	0f be d0             	movsbl %al,%edx
    1a4f:	8b 45 dc             	mov    -0x24(%rbp),%eax
    1a52:	89 d6                	mov    %edx,%esi
    1a54:	89 c7                	mov    %eax,%edi
    1a56:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1a5d:	00 00 00 
    1a60:	ff d0                	call   *%rax
  while (--i >= 0)
    1a62:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    1a66:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1a6a:	79 d6                	jns    1a42 <print_d+0xc6>
}
    1a6c:	90                   	nop
    1a6d:	90                   	nop
    1a6e:	c9                   	leave
    1a6f:	c3                   	ret

0000000000001a70 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    1a70:	55                   	push   %rbp
    1a71:	48 89 e5             	mov    %rsp,%rbp
    1a74:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    1a7b:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    1a81:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    1a88:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    1a8f:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    1a96:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    1a9d:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    1aa4:	84 c0                	test   %al,%al
    1aa6:	74 20                	je     1ac8 <printf+0x58>
    1aa8:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    1aac:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    1ab0:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    1ab4:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    1ab8:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    1abc:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    1ac0:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    1ac4:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    1ac8:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    1acf:	00 00 00 
    1ad2:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    1ad9:	00 00 00 
    1adc:	48 8d 45 10          	lea    0x10(%rbp),%rax
    1ae0:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    1ae7:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    1aee:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1af5:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    1afc:	00 00 00 
    1aff:	e9 60 03 00 00       	jmp    1e64 <printf+0x3f4>
    if (c != '%') {
    1b04:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1b0b:	74 24                	je     1b31 <printf+0xc1>
      putc(fd, c);
    1b0d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1b13:	0f be d0             	movsbl %al,%edx
    1b16:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1b1c:	89 d6                	mov    %edx,%esi
    1b1e:	89 c7                	mov    %eax,%edi
    1b20:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1b27:	00 00 00 
    1b2a:	ff d0                	call   *%rax
      continue;
    1b2c:	e9 2c 03 00 00       	jmp    1e5d <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    1b31:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1b38:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1b3e:	48 63 d0             	movslq %eax,%rdx
    1b41:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1b48:	48 01 d0             	add    %rdx,%rax
    1b4b:	0f b6 00             	movzbl (%rax),%eax
    1b4e:	0f be c0             	movsbl %al,%eax
    1b51:	25 ff 00 00 00       	and    $0xff,%eax
    1b56:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    1b5c:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1b63:	0f 84 2e 03 00 00    	je     1e97 <printf+0x427>
      break;
    switch(c) {
    1b69:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1b70:	0f 84 32 01 00 00    	je     1ca8 <printf+0x238>
    1b76:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    1b7d:	0f 8f a1 02 00 00    	jg     1e24 <printf+0x3b4>
    1b83:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1b8a:	0f 84 d4 01 00 00    	je     1d64 <printf+0x2f4>
    1b90:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    1b97:	0f 8f 87 02 00 00    	jg     1e24 <printf+0x3b4>
    1b9d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1ba4:	0f 84 5b 01 00 00    	je     1d05 <printf+0x295>
    1baa:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    1bb1:	0f 8f 6d 02 00 00    	jg     1e24 <printf+0x3b4>
    1bb7:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1bbe:	0f 84 87 00 00 00    	je     1c4b <printf+0x1db>
    1bc4:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    1bcb:	0f 8f 53 02 00 00    	jg     1e24 <printf+0x3b4>
    1bd1:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    1bd8:	0f 84 2b 02 00 00    	je     1e09 <printf+0x399>
    1bde:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    1be5:	0f 85 39 02 00 00    	jne    1e24 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    1beb:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1bf1:	83 f8 2f             	cmp    $0x2f,%eax
    1bf4:	77 23                	ja     1c19 <printf+0x1a9>
    1bf6:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1bfd:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c03:	89 d2                	mov    %edx,%edx
    1c05:	48 01 d0             	add    %rdx,%rax
    1c08:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c0e:	83 c2 08             	add    $0x8,%edx
    1c11:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c17:	eb 12                	jmp    1c2b <printf+0x1bb>
    1c19:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c20:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c24:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c2b:	8b 00                	mov    (%rax),%eax
    1c2d:	0f be d0             	movsbl %al,%edx
    1c30:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c36:	89 d6                	mov    %edx,%esi
    1c38:	89 c7                	mov    %eax,%edi
    1c3a:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1c41:	00 00 00 
    1c44:	ff d0                	call   *%rax
      break;
    1c46:	e9 12 02 00 00       	jmp    1e5d <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    1c4b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1c51:	83 f8 2f             	cmp    $0x2f,%eax
    1c54:	77 23                	ja     1c79 <printf+0x209>
    1c56:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1c5d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c63:	89 d2                	mov    %edx,%edx
    1c65:	48 01 d0             	add    %rdx,%rax
    1c68:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1c6e:	83 c2 08             	add    $0x8,%edx
    1c71:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1c77:	eb 12                	jmp    1c8b <printf+0x21b>
    1c79:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1c80:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1c84:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1c8b:	8b 10                	mov    (%rax),%edx
    1c8d:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1c93:	89 d6                	mov    %edx,%esi
    1c95:	89 c7                	mov    %eax,%edi
    1c97:	48 b8 7c 19 00 00 00 	movabs $0x197c,%rax
    1c9e:	00 00 00 
    1ca1:	ff d0                	call   *%rax
      break;
    1ca3:	e9 b5 01 00 00       	jmp    1e5d <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    1ca8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1cae:	83 f8 2f             	cmp    $0x2f,%eax
    1cb1:	77 23                	ja     1cd6 <printf+0x266>
    1cb3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1cba:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1cc0:	89 d2                	mov    %edx,%edx
    1cc2:	48 01 d0             	add    %rdx,%rax
    1cc5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1ccb:	83 c2 08             	add    $0x8,%edx
    1cce:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1cd4:	eb 12                	jmp    1ce8 <printf+0x278>
    1cd6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1cdd:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1ce1:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1ce8:	8b 10                	mov    (%rax),%edx
    1cea:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1cf0:	89 d6                	mov    %edx,%esi
    1cf2:	89 c7                	mov    %eax,%edi
    1cf4:	48 b8 23 19 00 00 00 	movabs $0x1923,%rax
    1cfb:	00 00 00 
    1cfe:	ff d0                	call   *%rax
      break;
    1d00:	e9 58 01 00 00       	jmp    1e5d <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    1d05:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1d0b:	83 f8 2f             	cmp    $0x2f,%eax
    1d0e:	77 23                	ja     1d33 <printf+0x2c3>
    1d10:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1d17:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d1d:	89 d2                	mov    %edx,%edx
    1d1f:	48 01 d0             	add    %rdx,%rax
    1d22:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d28:	83 c2 08             	add    $0x8,%edx
    1d2b:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1d31:	eb 12                	jmp    1d45 <printf+0x2d5>
    1d33:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1d3a:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1d3e:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1d45:	48 8b 10             	mov    (%rax),%rdx
    1d48:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1d4e:	48 89 d6             	mov    %rdx,%rsi
    1d51:	89 c7                	mov    %eax,%edi
    1d53:	48 b8 ca 18 00 00 00 	movabs $0x18ca,%rax
    1d5a:	00 00 00 
    1d5d:	ff d0                	call   *%rax
      break;
    1d5f:	e9 f9 00 00 00       	jmp    1e5d <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    1d64:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    1d6a:	83 f8 2f             	cmp    $0x2f,%eax
    1d6d:	77 23                	ja     1d92 <printf+0x322>
    1d6f:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    1d76:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d7c:	89 d2                	mov    %edx,%edx
    1d7e:	48 01 d0             	add    %rdx,%rax
    1d81:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    1d87:	83 c2 08             	add    $0x8,%edx
    1d8a:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    1d90:	eb 12                	jmp    1da4 <printf+0x334>
    1d92:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    1d99:	48 8d 50 08          	lea    0x8(%rax),%rdx
    1d9d:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    1da4:	48 8b 00             	mov    (%rax),%rax
    1da7:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    1dae:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    1db5:	00 
    1db6:	75 41                	jne    1df9 <printf+0x389>
        s = "(null)";
    1db8:	48 b8 ce 21 00 00 00 	movabs $0x21ce,%rax
    1dbf:	00 00 00 
    1dc2:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    1dc9:	eb 2e                	jmp    1df9 <printf+0x389>
        putc(fd, *(s++));
    1dcb:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1dd2:	48 8d 50 01          	lea    0x1(%rax),%rdx
    1dd6:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    1ddd:	0f b6 00             	movzbl (%rax),%eax
    1de0:	0f be d0             	movsbl %al,%edx
    1de3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1de9:	89 d6                	mov    %edx,%esi
    1deb:	89 c7                	mov    %eax,%edi
    1ded:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1df4:	00 00 00 
    1df7:	ff d0                	call   *%rax
      while (*s)
    1df9:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    1e00:	0f b6 00             	movzbl (%rax),%eax
    1e03:	84 c0                	test   %al,%al
    1e05:	75 c4                	jne    1dcb <printf+0x35b>
      break;
    1e07:	eb 54                	jmp    1e5d <printf+0x3ed>
    case '%':
      putc(fd, '%');
    1e09:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e0f:	be 25 00 00 00       	mov    $0x25,%esi
    1e14:	89 c7                	mov    %eax,%edi
    1e16:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1e1d:	00 00 00 
    1e20:	ff d0                	call   *%rax
      break;
    1e22:	eb 39                	jmp    1e5d <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    1e24:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e2a:	be 25 00 00 00       	mov    $0x25,%esi
    1e2f:	89 c7                	mov    %eax,%edi
    1e31:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1e38:	00 00 00 
    1e3b:	ff d0                	call   *%rax
      putc(fd, c);
    1e3d:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    1e43:	0f be d0             	movsbl %al,%edx
    1e46:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    1e4c:	89 d6                	mov    %edx,%esi
    1e4e:	89 c7                	mov    %eax,%edi
    1e50:	48 b8 9a 18 00 00 00 	movabs $0x189a,%rax
    1e57:	00 00 00 
    1e5a:	ff d0                	call   *%rax
      break;
    1e5c:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    1e5d:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    1e64:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    1e6a:	48 63 d0             	movslq %eax,%rdx
    1e6d:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    1e74:	48 01 d0             	add    %rdx,%rax
    1e77:	0f b6 00             	movzbl (%rax),%eax
    1e7a:	0f be c0             	movsbl %al,%eax
    1e7d:	25 ff 00 00 00       	and    $0xff,%eax
    1e82:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    1e88:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    1e8f:	0f 85 6f fc ff ff    	jne    1b04 <printf+0x94>
    }
  }
}
    1e95:	eb 01                	jmp    1e98 <printf+0x428>
      break;
    1e97:	90                   	nop
}
    1e98:	90                   	nop
    1e99:	c9                   	leave
    1e9a:	c3                   	ret

0000000000001e9b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1e9b:	55                   	push   %rbp
    1e9c:	48 89 e5             	mov    %rsp,%rbp
    1e9f:	48 83 ec 18          	sub    $0x18,%rsp
    1ea3:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1ea7:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    1eab:	48 83 e8 10          	sub    $0x10,%rax
    1eaf:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1eb3:	48 b8 10 26 00 00 00 	movabs $0x2610,%rax
    1eba:	00 00 00 
    1ebd:	48 8b 00             	mov    (%rax),%rax
    1ec0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ec4:	eb 2f                	jmp    1ef5 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1ec6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eca:	48 8b 00             	mov    (%rax),%rax
    1ecd:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1ed1:	72 17                	jb     1eea <free+0x4f>
    1ed3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ed7:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1edb:	72 2f                	jb     1f0c <free+0x71>
    1edd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1ee1:	48 8b 00             	mov    (%rax),%rax
    1ee4:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1ee8:	72 22                	jb     1f0c <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1eea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1eee:	48 8b 00             	mov    (%rax),%rax
    1ef1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1ef5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1ef9:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    1efd:	73 c7                	jae    1ec6 <free+0x2b>
    1eff:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f03:	48 8b 00             	mov    (%rax),%rax
    1f06:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f0a:	73 ba                	jae    1ec6 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1f0c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f10:	8b 40 08             	mov    0x8(%rax),%eax
    1f13:	89 c0                	mov    %eax,%eax
    1f15:	48 c1 e0 04          	shl    $0x4,%rax
    1f19:	48 89 c2             	mov    %rax,%rdx
    1f1c:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f20:	48 01 c2             	add    %rax,%rdx
    1f23:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f27:	48 8b 00             	mov    (%rax),%rax
    1f2a:	48 39 c2             	cmp    %rax,%rdx
    1f2d:	75 2d                	jne    1f5c <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    1f2f:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f33:	8b 50 08             	mov    0x8(%rax),%edx
    1f36:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f3a:	48 8b 00             	mov    (%rax),%rax
    1f3d:	8b 40 08             	mov    0x8(%rax),%eax
    1f40:	01 c2                	add    %eax,%edx
    1f42:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f46:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1f49:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f4d:	48 8b 00             	mov    (%rax),%rax
    1f50:	48 8b 10             	mov    (%rax),%rdx
    1f53:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f57:	48 89 10             	mov    %rdx,(%rax)
    1f5a:	eb 0e                	jmp    1f6a <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    1f5c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f60:	48 8b 10             	mov    (%rax),%rdx
    1f63:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f67:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    1f6a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f6e:	8b 40 08             	mov    0x8(%rax),%eax
    1f71:	89 c0                	mov    %eax,%eax
    1f73:	48 c1 e0 04          	shl    $0x4,%rax
    1f77:	48 89 c2             	mov    %rax,%rdx
    1f7a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f7e:	48 01 d0             	add    %rdx,%rax
    1f81:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    1f85:	75 27                	jne    1fae <free+0x113>
    p->s.size += bp->s.size;
    1f87:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f8b:	8b 50 08             	mov    0x8(%rax),%edx
    1f8e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1f92:	8b 40 08             	mov    0x8(%rax),%eax
    1f95:	01 c2                	add    %eax,%edx
    1f97:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1f9b:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    1f9e:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    1fa2:	48 8b 10             	mov    (%rax),%rdx
    1fa5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fa9:	48 89 10             	mov    %rdx,(%rax)
    1fac:	eb 0b                	jmp    1fb9 <free+0x11e>
  } else
    p->s.ptr = bp;
    1fae:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fb2:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    1fb6:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    1fb9:	48 ba 10 26 00 00 00 	movabs $0x2610,%rdx
    1fc0:	00 00 00 
    1fc3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1fc7:	48 89 02             	mov    %rax,(%rdx)
}
    1fca:	90                   	nop
    1fcb:	c9                   	leave
    1fcc:	c3                   	ret

0000000000001fcd <morecore>:

static Header*
morecore(uint nu)
{
    1fcd:	55                   	push   %rbp
    1fce:	48 89 e5             	mov    %rsp,%rbp
    1fd1:	48 83 ec 20          	sub    $0x20,%rsp
    1fd5:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    1fd8:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    1fdf:	77 07                	ja     1fe8 <morecore+0x1b>
    nu = 4096;
    1fe1:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    1fe8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1feb:	48 c1 e0 04          	shl    $0x4,%rax
    1fef:	48 89 c7             	mov    %rax,%rdi
    1ff2:	48 b8 66 18 00 00 00 	movabs $0x1866,%rax
    1ff9:	00 00 00 
    1ffc:	ff d0                	call   *%rax
    1ffe:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    2002:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    2007:	75 07                	jne    2010 <morecore+0x43>
    return 0;
    2009:	b8 00 00 00 00       	mov    $0x0,%eax
    200e:	eb 36                	jmp    2046 <morecore+0x79>
  hp = (Header*)p;
    2010:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2014:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    2018:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    201c:	8b 55 ec             	mov    -0x14(%rbp),%edx
    201f:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    2022:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2026:	48 83 c0 10          	add    $0x10,%rax
    202a:	48 89 c7             	mov    %rax,%rdi
    202d:	48 b8 9b 1e 00 00 00 	movabs $0x1e9b,%rax
    2034:	00 00 00 
    2037:	ff d0                	call   *%rax
  return freep;
    2039:	48 b8 10 26 00 00 00 	movabs $0x2610,%rax
    2040:	00 00 00 
    2043:	48 8b 00             	mov    (%rax),%rax
}
    2046:	c9                   	leave
    2047:	c3                   	ret

0000000000002048 <malloc>:

void*
malloc(uint nbytes)
{
    2048:	55                   	push   %rbp
    2049:	48 89 e5             	mov    %rsp,%rbp
    204c:	48 83 ec 30          	sub    $0x30,%rsp
    2050:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    2053:	8b 45 dc             	mov    -0x24(%rbp),%eax
    2056:	48 83 c0 0f          	add    $0xf,%rax
    205a:	48 c1 e8 04          	shr    $0x4,%rax
    205e:	83 c0 01             	add    $0x1,%eax
    2061:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    2064:	48 b8 10 26 00 00 00 	movabs $0x2610,%rax
    206b:	00 00 00 
    206e:	48 8b 00             	mov    (%rax),%rax
    2071:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2075:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    207a:	75 4a                	jne    20c6 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    207c:	48 b8 00 26 00 00 00 	movabs $0x2600,%rax
    2083:	00 00 00 
    2086:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    208a:	48 ba 10 26 00 00 00 	movabs $0x2610,%rdx
    2091:	00 00 00 
    2094:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2098:	48 89 02             	mov    %rax,(%rdx)
    209b:	48 b8 10 26 00 00 00 	movabs $0x2610,%rax
    20a2:	00 00 00 
    20a5:	48 8b 00             	mov    (%rax),%rax
    20a8:	48 ba 00 26 00 00 00 	movabs $0x2600,%rdx
    20af:	00 00 00 
    20b2:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    20b5:	48 b8 00 26 00 00 00 	movabs $0x2600,%rax
    20bc:	00 00 00 
    20bf:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    20c6:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    20ca:	48 8b 00             	mov    (%rax),%rax
    20cd:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    20d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    20d5:	8b 40 08             	mov    0x8(%rax),%eax
    20d8:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    20db:	72 65                	jb     2142 <malloc+0xfa>
      if(p->s.size == nunits)
    20dd:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    20e1:	8b 40 08             	mov    0x8(%rax),%eax
    20e4:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    20e7:	75 10                	jne    20f9 <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    20e9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    20ed:	48 8b 10             	mov    (%rax),%rdx
    20f0:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    20f4:	48 89 10             	mov    %rdx,(%rax)
    20f7:	eb 2e                	jmp    2127 <malloc+0xdf>
      else {
        p->s.size -= nunits;
    20f9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    20fd:	8b 40 08             	mov    0x8(%rax),%eax
    2100:	2b 45 ec             	sub    -0x14(%rbp),%eax
    2103:	89 c2                	mov    %eax,%edx
    2105:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2109:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    210c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2110:	8b 40 08             	mov    0x8(%rax),%eax
    2113:	89 c0                	mov    %eax,%eax
    2115:	48 c1 e0 04          	shl    $0x4,%rax
    2119:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    211d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2121:	8b 55 ec             	mov    -0x14(%rbp),%edx
    2124:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    2127:	48 ba 10 26 00 00 00 	movabs $0x2610,%rdx
    212e:	00 00 00 
    2131:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    2135:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    2138:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    213c:	48 83 c0 10          	add    $0x10,%rax
    2140:	eb 4e                	jmp    2190 <malloc+0x148>
    }
    if(p == freep)
    2142:	48 b8 10 26 00 00 00 	movabs $0x2610,%rax
    2149:	00 00 00 
    214c:	48 8b 00             	mov    (%rax),%rax
    214f:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    2153:	75 23                	jne    2178 <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    2155:	8b 45 ec             	mov    -0x14(%rbp),%eax
    2158:	89 c7                	mov    %eax,%edi
    215a:	48 b8 cd 1f 00 00 00 	movabs $0x1fcd,%rax
    2161:	00 00 00 
    2164:	ff d0                	call   *%rax
    2166:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    216a:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    216f:	75 07                	jne    2178 <malloc+0x130>
        return 0;
    2171:	b8 00 00 00 00       	mov    $0x0,%eax
    2176:	eb 18                	jmp    2190 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    2178:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    217c:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    2180:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2184:	48 8b 00             	mov    (%rax),%rax
    2187:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    218b:	e9 41 ff ff ff       	jmp    20d1 <malloc+0x89>
  }
}
    2190:	c9                   	leave
    2191:	c3                   	ret
