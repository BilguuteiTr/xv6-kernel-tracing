
_usertests:     file format elf64-x86-64


Disassembly of section .text:

0000000000001000 <failexit>:
char name[3];
char *echoargv[] = { "echo", "ALL", "TESTS", "PASSED", 0 };

void
failexit(const char * const msg)
{
    1000:	55                   	push   %rbp
    1001:	48 89 e5             	mov    %rsp,%rbp
    1004:	48 83 ec 10          	sub    $0x10,%rsp
    1008:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
  printf(1, "!! FAILED %s\n", msg);
    100c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1010:	48 b9 6e 71 00 00 00 	movabs $0x716e,%rcx
    1017:	00 00 00 
    101a:	48 89 c2             	mov    %rax,%rdx
    101d:	48 89 ce             	mov    %rcx,%rsi
    1020:	bf 01 00 00 00       	mov    $0x1,%edi
    1025:	b8 00 00 00 00       	mov    $0x0,%eax
    102a:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    1031:	00 00 00 
    1034:	ff d1                	call   *%rcx
  exit();
    1036:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    103d:	00 00 00 
    1040:	ff d0                	call   *%rax

0000000000001042 <iputtest>:
}

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
    1042:	55                   	push   %rbp
    1043:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "iput test\n");
    1046:	48 b8 7c 71 00 00 00 	movabs $0x717c,%rax
    104d:	00 00 00 
    1050:	48 89 c6             	mov    %rax,%rsi
    1053:	bf 01 00 00 00       	mov    $0x1,%edi
    1058:	b8 00 00 00 00       	mov    $0x0,%eax
    105d:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1064:	00 00 00 
    1067:	ff d2                	call   *%rdx

  if(mkdir("iputdir") < 0){
    1069:	48 b8 87 71 00 00 00 	movabs $0x7187,%rax
    1070:	00 00 00 
    1073:	48 89 c7             	mov    %rax,%rdi
    1076:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    107d:	00 00 00 
    1080:	ff d0                	call   *%rax
    1082:	85 c0                	test   %eax,%eax
    1084:	79 19                	jns    109f <iputtest+0x5d>
    failexit("mkdir");
    1086:	48 b8 8f 71 00 00 00 	movabs $0x718f,%rax
    108d:	00 00 00 
    1090:	48 89 c7             	mov    %rax,%rdi
    1093:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    109a:	00 00 00 
    109d:	ff d0                	call   *%rax
  }
  if(chdir("iputdir") < 0){
    109f:	48 b8 87 71 00 00 00 	movabs $0x7187,%rax
    10a6:	00 00 00 
    10a9:	48 89 c7             	mov    %rax,%rdi
    10ac:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    10b3:	00 00 00 
    10b6:	ff d0                	call   *%rax
    10b8:	85 c0                	test   %eax,%eax
    10ba:	79 19                	jns    10d5 <iputtest+0x93>
    failexit("chdir iputdir");
    10bc:	48 b8 95 71 00 00 00 	movabs $0x7195,%rax
    10c3:	00 00 00 
    10c6:	48 89 c7             	mov    %rax,%rdi
    10c9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    10d0:	00 00 00 
    10d3:	ff d0                	call   *%rax
  }
  if(unlink("../iputdir") < 0){
    10d5:	48 b8 a3 71 00 00 00 	movabs $0x71a3,%rax
    10dc:	00 00 00 
    10df:	48 89 c7             	mov    %rax,%rdi
    10e2:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    10e9:	00 00 00 
    10ec:	ff d0                	call   *%rax
    10ee:	85 c0                	test   %eax,%eax
    10f0:	79 19                	jns    110b <iputtest+0xc9>
    failexit("unlink ../iputdir");
    10f2:	48 b8 ae 71 00 00 00 	movabs $0x71ae,%rax
    10f9:	00 00 00 
    10fc:	48 89 c7             	mov    %rax,%rdi
    10ff:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1106:	00 00 00 
    1109:	ff d0                	call   *%rax
  }
  if(chdir("/") < 0){
    110b:	48 b8 c0 71 00 00 00 	movabs $0x71c0,%rax
    1112:	00 00 00 
    1115:	48 89 c7             	mov    %rax,%rdi
    1118:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    111f:	00 00 00 
    1122:	ff d0                	call   *%rax
    1124:	85 c0                	test   %eax,%eax
    1126:	79 19                	jns    1141 <iputtest+0xff>
    failexit("chdir /");
    1128:	48 b8 c2 71 00 00 00 	movabs $0x71c2,%rax
    112f:	00 00 00 
    1132:	48 89 c7             	mov    %rax,%rdi
    1135:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    113c:	00 00 00 
    113f:	ff d0                	call   *%rax
  }
  printf(1, "iput test ok\n");
    1141:	48 b8 ca 71 00 00 00 	movabs $0x71ca,%rax
    1148:	00 00 00 
    114b:	48 89 c6             	mov    %rax,%rsi
    114e:	bf 01 00 00 00       	mov    $0x1,%edi
    1153:	b8 00 00 00 00       	mov    $0x0,%eax
    1158:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    115f:	00 00 00 
    1162:	ff d2                	call   *%rdx
}
    1164:	90                   	nop
    1165:	5d                   	pop    %rbp
    1166:	c3                   	ret

0000000000001167 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
    1167:	55                   	push   %rbp
    1168:	48 89 e5             	mov    %rsp,%rbp
    116b:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  printf(1, "exitiput test\n");
    116f:	48 b8 d8 71 00 00 00 	movabs $0x71d8,%rax
    1176:	00 00 00 
    1179:	48 89 c6             	mov    %rax,%rsi
    117c:	bf 01 00 00 00       	mov    $0x1,%edi
    1181:	b8 00 00 00 00       	mov    $0x0,%eax
    1186:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    118d:	00 00 00 
    1190:	ff d2                	call   *%rdx

  pid = fork();
    1192:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    1199:	00 00 00 
    119c:	ff d0                	call   *%rax
    119e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid < 0){
    11a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11a5:	79 19                	jns    11c0 <exitiputtest+0x59>
    failexit("fork");
    11a7:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    11ae:	00 00 00 
    11b1:	48 89 c7             	mov    %rax,%rdi
    11b4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11bb:	00 00 00 
    11be:	ff d0                	call   *%rax
  }
  if(pid == 0){
    11c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    11c4:	0f 85 ae 00 00 00    	jne    1278 <exitiputtest+0x111>
    if(mkdir("iputdir") < 0){
    11ca:	48 b8 87 71 00 00 00 	movabs $0x7187,%rax
    11d1:	00 00 00 
    11d4:	48 89 c7             	mov    %rax,%rdi
    11d7:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    11de:	00 00 00 
    11e1:	ff d0                	call   *%rax
    11e3:	85 c0                	test   %eax,%eax
    11e5:	79 19                	jns    1200 <exitiputtest+0x99>
      failexit("mkdir");
    11e7:	48 b8 8f 71 00 00 00 	movabs $0x718f,%rax
    11ee:	00 00 00 
    11f1:	48 89 c7             	mov    %rax,%rdi
    11f4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    11fb:	00 00 00 
    11fe:	ff d0                	call   *%rax
    }
    if(chdir("iputdir") < 0){
    1200:	48 b8 87 71 00 00 00 	movabs $0x7187,%rax
    1207:	00 00 00 
    120a:	48 89 c7             	mov    %rax,%rdi
    120d:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    1214:	00 00 00 
    1217:	ff d0                	call   *%rax
    1219:	85 c0                	test   %eax,%eax
    121b:	79 19                	jns    1236 <exitiputtest+0xcf>
      failexit("child chdir");
    121d:	48 b8 ec 71 00 00 00 	movabs $0x71ec,%rax
    1224:	00 00 00 
    1227:	48 89 c7             	mov    %rax,%rdi
    122a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1231:	00 00 00 
    1234:	ff d0                	call   *%rax
    }
    if(unlink("../iputdir") < 0){
    1236:	48 b8 a3 71 00 00 00 	movabs $0x71a3,%rax
    123d:	00 00 00 
    1240:	48 89 c7             	mov    %rax,%rdi
    1243:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    124a:	00 00 00 
    124d:	ff d0                	call   *%rax
    124f:	85 c0                	test   %eax,%eax
    1251:	79 19                	jns    126c <exitiputtest+0x105>
      failexit("unlink ../iputdir");
    1253:	48 b8 ae 71 00 00 00 	movabs $0x71ae,%rax
    125a:	00 00 00 
    125d:	48 89 c7             	mov    %rax,%rdi
    1260:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1267:	00 00 00 
    126a:	ff d0                	call   *%rax
    }
    exit();
    126c:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1273:	00 00 00 
    1276:	ff d0                	call   *%rax
  }
  wait();
    1278:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    127f:	00 00 00 
    1282:	ff d0                	call   *%rax
  printf(1, "exitiput test ok\n");
    1284:	48 b8 f8 71 00 00 00 	movabs $0x71f8,%rax
    128b:	00 00 00 
    128e:	48 89 c6             	mov    %rax,%rsi
    1291:	bf 01 00 00 00       	mov    $0x1,%edi
    1296:	b8 00 00 00 00       	mov    $0x0,%eax
    129b:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    12a2:	00 00 00 
    12a5:	ff d2                	call   *%rdx
}
    12a7:	90                   	nop
    12a8:	c9                   	leave
    12a9:	c3                   	ret

00000000000012aa <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
    12aa:	55                   	push   %rbp
    12ab:	48 89 e5             	mov    %rsp,%rbp
    12ae:	48 83 ec 10          	sub    $0x10,%rsp
  int pid;

  printf(1, "openiput test\n");
    12b2:	48 b8 0a 72 00 00 00 	movabs $0x720a,%rax
    12b9:	00 00 00 
    12bc:	48 89 c6             	mov    %rax,%rsi
    12bf:	bf 01 00 00 00       	mov    $0x1,%edi
    12c4:	b8 00 00 00 00       	mov    $0x0,%eax
    12c9:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    12d0:	00 00 00 
    12d3:	ff d2                	call   *%rdx
  if(mkdir("oidir") < 0){
    12d5:	48 b8 19 72 00 00 00 	movabs $0x7219,%rax
    12dc:	00 00 00 
    12df:	48 89 c7             	mov    %rax,%rdi
    12e2:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    12e9:	00 00 00 
    12ec:	ff d0                	call   *%rax
    12ee:	85 c0                	test   %eax,%eax
    12f0:	79 19                	jns    130b <openiputtest+0x61>
    failexit("mkdir oidir");
    12f2:	48 b8 1f 72 00 00 00 	movabs $0x721f,%rax
    12f9:	00 00 00 
    12fc:	48 89 c7             	mov    %rax,%rdi
    12ff:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1306:	00 00 00 
    1309:	ff d0                	call   *%rax
  }
  pid = fork();
    130b:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    1312:	00 00 00 
    1315:	ff d0                	call   *%rax
    1317:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid < 0){
    131a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    131e:	79 19                	jns    1339 <openiputtest+0x8f>
    failexit("fork");
    1320:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    1327:	00 00 00 
    132a:	48 89 c7             	mov    %rax,%rdi
    132d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1334:	00 00 00 
    1337:	ff d0                	call   *%rax
  }
  if(pid == 0){
    1339:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    133d:	75 4c                	jne    138b <openiputtest+0xe1>
    int fd = open("oidir", O_RDWR);
    133f:	48 b8 19 72 00 00 00 	movabs $0x7219,%rax
    1346:	00 00 00 
    1349:	be 02 00 00 00       	mov    $0x2,%esi
    134e:	48 89 c7             	mov    %rax,%rdi
    1351:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1358:	00 00 00 
    135b:	ff d0                	call   *%rax
    135d:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0){
    1360:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1364:	78 19                	js     137f <openiputtest+0xd5>
      failexit("open directory for write succeeded");
    1366:	48 b8 30 72 00 00 00 	movabs $0x7230,%rax
    136d:	00 00 00 
    1370:	48 89 c7             	mov    %rax,%rdi
    1373:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    137a:	00 00 00 
    137d:	ff d0                	call   *%rax
    }
    exit();
    137f:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1386:	00 00 00 
    1389:	ff d0                	call   *%rax
  }
  sleep(1);
    138b:	bf 01 00 00 00       	mov    $0x1,%edi
    1390:	48 b8 36 68 00 00 00 	movabs $0x6836,%rax
    1397:	00 00 00 
    139a:	ff d0                	call   *%rax
  if(unlink("oidir") != 0){
    139c:	48 b8 19 72 00 00 00 	movabs $0x7219,%rax
    13a3:	00 00 00 
    13a6:	48 89 c7             	mov    %rax,%rdi
    13a9:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    13b0:	00 00 00 
    13b3:	ff d0                	call   *%rax
    13b5:	85 c0                	test   %eax,%eax
    13b7:	74 19                	je     13d2 <openiputtest+0x128>
    failexit("unlink");
    13b9:	48 b8 53 72 00 00 00 	movabs $0x7253,%rax
    13c0:	00 00 00 
    13c3:	48 89 c7             	mov    %rax,%rdi
    13c6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    13cd:	00 00 00 
    13d0:	ff d0                	call   *%rax
  }
  wait();
    13d2:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    13d9:	00 00 00 
    13dc:	ff d0                	call   *%rax
  printf(1, "openiput test ok\n");
    13de:	48 b8 5a 72 00 00 00 	movabs $0x725a,%rax
    13e5:	00 00 00 
    13e8:	48 89 c6             	mov    %rax,%rsi
    13eb:	bf 01 00 00 00       	mov    $0x1,%edi
    13f0:	b8 00 00 00 00       	mov    $0x0,%eax
    13f5:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    13fc:	00 00 00 
    13ff:	ff d2                	call   *%rdx
}
    1401:	90                   	nop
    1402:	c9                   	leave
    1403:	c3                   	ret

0000000000001404 <opentest>:

// simple file system tests

void
opentest(void)
{
    1404:	55                   	push   %rbp
    1405:	48 89 e5             	mov    %rsp,%rbp
    1408:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "open test\n");
    140c:	48 b8 6c 72 00 00 00 	movabs $0x726c,%rax
    1413:	00 00 00 
    1416:	48 89 c6             	mov    %rax,%rsi
    1419:	bf 01 00 00 00       	mov    $0x1,%edi
    141e:	b8 00 00 00 00       	mov    $0x0,%eax
    1423:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    142a:	00 00 00 
    142d:	ff d2                	call   *%rdx
  fd = open("echo", 0);
    142f:	48 b8 58 71 00 00 00 	movabs $0x7158,%rax
    1436:	00 00 00 
    1439:	be 00 00 00 00       	mov    $0x0,%esi
    143e:	48 89 c7             	mov    %rax,%rdi
    1441:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1448:	00 00 00 
    144b:	ff d0                	call   *%rax
    144d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    1450:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    1454:	79 19                	jns    146f <opentest+0x6b>
    failexit("open echo");
    1456:	48 b8 77 72 00 00 00 	movabs $0x7277,%rax
    145d:	00 00 00 
    1460:	48 89 c7             	mov    %rax,%rdi
    1463:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    146a:	00 00 00 
    146d:	ff d0                	call   *%rax
  }
  close(fd);
    146f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1472:	89 c7                	mov    %eax,%edi
    1474:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    147b:	00 00 00 
    147e:	ff d0                	call   *%rax
  fd = open("doesnotexist", 0);
    1480:	48 b8 81 72 00 00 00 	movabs $0x7281,%rax
    1487:	00 00 00 
    148a:	be 00 00 00 00       	mov    $0x0,%esi
    148f:	48 89 c7             	mov    %rax,%rdi
    1492:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1499:	00 00 00 
    149c:	ff d0                	call   *%rax
    149e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    14a1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    14a5:	78 19                	js     14c0 <opentest+0xbc>
    failexit("open doesnotexist succeeded!");
    14a7:	48 b8 8e 72 00 00 00 	movabs $0x728e,%rax
    14ae:	00 00 00 
    14b1:	48 89 c7             	mov    %rax,%rdi
    14b4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    14bb:	00 00 00 
    14be:	ff d0                	call   *%rax
  }
  printf(1, "open test ok\n");
    14c0:	48 b8 ab 72 00 00 00 	movabs $0x72ab,%rax
    14c7:	00 00 00 
    14ca:	48 89 c6             	mov    %rax,%rsi
    14cd:	bf 01 00 00 00       	mov    $0x1,%edi
    14d2:	b8 00 00 00 00       	mov    $0x0,%eax
    14d7:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    14de:	00 00 00 
    14e1:	ff d2                	call   *%rdx
}
    14e3:	90                   	nop
    14e4:	c9                   	leave
    14e5:	c3                   	ret

00000000000014e6 <writetest>:

void
writetest(void)
{
    14e6:	55                   	push   %rbp
    14e7:	48 89 e5             	mov    %rsp,%rbp
    14ea:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  int i;

  printf(1, "small file test\n");
    14ee:	48 b8 b9 72 00 00 00 	movabs $0x72b9,%rax
    14f5:	00 00 00 
    14f8:	48 89 c6             	mov    %rax,%rsi
    14fb:	bf 01 00 00 00       	mov    $0x1,%edi
    1500:	b8 00 00 00 00       	mov    $0x0,%eax
    1505:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    150c:	00 00 00 
    150f:	ff d2                	call   *%rdx
  fd = open("small", O_CREATE|O_RDWR);
    1511:	48 b8 ca 72 00 00 00 	movabs $0x72ca,%rax
    1518:	00 00 00 
    151b:	be 02 02 00 00       	mov    $0x202,%esi
    1520:	48 89 c7             	mov    %rax,%rdi
    1523:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    152a:	00 00 00 
    152d:	ff d0                	call   *%rax
    152f:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    1532:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1536:	79 19                	jns    1551 <writetest+0x6b>
    failexit("error: creat small");
    1538:	48 b8 d0 72 00 00 00 	movabs $0x72d0,%rax
    153f:	00 00 00 
    1542:	48 89 c7             	mov    %rax,%rdi
    1545:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    154c:	00 00 00 
    154f:	ff d0                	call   *%rax
  }
  for(i = 0; i < 100; i++){
    1551:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1558:	e9 bc 00 00 00       	jmp    1619 <writetest+0x133>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
    155d:	48 b9 e3 72 00 00 00 	movabs $0x72e3,%rcx
    1564:	00 00 00 
    1567:	8b 45 f8             	mov    -0x8(%rbp),%eax
    156a:	ba 0a 00 00 00       	mov    $0xa,%edx
    156f:	48 89 ce             	mov    %rcx,%rsi
    1572:	89 c7                	mov    %eax,%edi
    1574:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    157b:	00 00 00 
    157e:	ff d0                	call   *%rax
    1580:	83 f8 0a             	cmp    $0xa,%eax
    1583:	74 34                	je     15b9 <writetest+0xd3>
      printf(1, "error: write aa %d new file failed\n", i);
    1585:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1588:	48 b9 f0 72 00 00 00 	movabs $0x72f0,%rcx
    158f:	00 00 00 
    1592:	89 c2                	mov    %eax,%edx
    1594:	48 89 ce             	mov    %rcx,%rsi
    1597:	bf 01 00 00 00       	mov    $0x1,%edi
    159c:	b8 00 00 00 00       	mov    $0x0,%eax
    15a1:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    15a8:	00 00 00 
    15ab:	ff d1                	call   *%rcx
      exit();
    15ad:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    15b4:	00 00 00 
    15b7:	ff d0                	call   *%rax
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
    15b9:	48 b9 14 73 00 00 00 	movabs $0x7314,%rcx
    15c0:	00 00 00 
    15c3:	8b 45 f8             	mov    -0x8(%rbp),%eax
    15c6:	ba 0a 00 00 00       	mov    $0xa,%edx
    15cb:	48 89 ce             	mov    %rcx,%rsi
    15ce:	89 c7                	mov    %eax,%edi
    15d0:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    15d7:	00 00 00 
    15da:	ff d0                	call   *%rax
    15dc:	83 f8 0a             	cmp    $0xa,%eax
    15df:	74 34                	je     1615 <writetest+0x12f>
      printf(1, "error: write bb %d new file failed\n", i);
    15e1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    15e4:	48 b9 20 73 00 00 00 	movabs $0x7320,%rcx
    15eb:	00 00 00 
    15ee:	89 c2                	mov    %eax,%edx
    15f0:	48 89 ce             	mov    %rcx,%rsi
    15f3:	bf 01 00 00 00       	mov    $0x1,%edi
    15f8:	b8 00 00 00 00       	mov    $0x0,%eax
    15fd:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    1604:	00 00 00 
    1607:	ff d1                	call   *%rcx
      exit();
    1609:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1610:	00 00 00 
    1613:	ff d0                	call   *%rax
  for(i = 0; i < 100; i++){
    1615:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1619:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    161d:	0f 8e 3a ff ff ff    	jle    155d <writetest+0x77>
    }
  }
  close(fd);
    1623:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1626:	89 c7                	mov    %eax,%edi
    1628:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    162f:	00 00 00 
    1632:	ff d0                	call   *%rax
  fd = open("small", O_RDONLY);
    1634:	48 b8 ca 72 00 00 00 	movabs $0x72ca,%rax
    163b:	00 00 00 
    163e:	be 00 00 00 00       	mov    $0x0,%esi
    1643:	48 89 c7             	mov    %rax,%rdi
    1646:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    164d:	00 00 00 
    1650:	ff d0                	call   *%rax
    1652:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    1655:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1659:	79 19                	jns    1674 <writetest+0x18e>
    failexit("error: open small");
    165b:	48 b8 44 73 00 00 00 	movabs $0x7344,%rax
    1662:	00 00 00 
    1665:	48 89 c7             	mov    %rax,%rdi
    1668:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    166f:	00 00 00 
    1672:	ff d0                	call   *%rax
  }
  i = read(fd, buf, 2000);
    1674:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    167b:	00 00 00 
    167e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1681:	ba d0 07 00 00       	mov    $0x7d0,%edx
    1686:	48 89 ce             	mov    %rcx,%rsi
    1689:	89 c7                	mov    %eax,%edi
    168b:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    1692:	00 00 00 
    1695:	ff d0                	call   *%rax
    1697:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(i != 2000){
    169a:	81 7d fc d0 07 00 00 	cmpl   $0x7d0,-0x4(%rbp)
    16a1:	74 19                	je     16bc <writetest+0x1d6>
    failexit("read");
    16a3:	48 b8 56 73 00 00 00 	movabs $0x7356,%rax
    16aa:	00 00 00 
    16ad:	48 89 c7             	mov    %rax,%rdi
    16b0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    16b7:	00 00 00 
    16ba:	ff d0                	call   *%rax
  }
  close(fd);
    16bc:	8b 45 f8             	mov    -0x8(%rbp),%eax
    16bf:	89 c7                	mov    %eax,%edi
    16c1:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    16c8:	00 00 00 
    16cb:	ff d0                	call   *%rax

  if(unlink("small") < 0){
    16cd:	48 b8 ca 72 00 00 00 	movabs $0x72ca,%rax
    16d4:	00 00 00 
    16d7:	48 89 c7             	mov    %rax,%rdi
    16da:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    16e1:	00 00 00 
    16e4:	ff d0                	call   *%rax
    16e6:	85 c0                	test   %eax,%eax
    16e8:	79 25                	jns    170f <writetest+0x229>
    failexit("unlink small");
    16ea:	48 b8 5b 73 00 00 00 	movabs $0x735b,%rax
    16f1:	00 00 00 
    16f4:	48 89 c7             	mov    %rax,%rdi
    16f7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    16fe:	00 00 00 
    1701:	ff d0                	call   *%rax
    exit();
    1703:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    170a:	00 00 00 
    170d:	ff d0                	call   *%rax
  }
  printf(1, "small file test ok\n");
    170f:	48 b8 68 73 00 00 00 	movabs $0x7368,%rax
    1716:	00 00 00 
    1719:	48 89 c6             	mov    %rax,%rsi
    171c:	bf 01 00 00 00       	mov    $0x1,%edi
    1721:	b8 00 00 00 00       	mov    $0x0,%eax
    1726:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    172d:	00 00 00 
    1730:	ff d2                	call   *%rdx
}
    1732:	90                   	nop
    1733:	c9                   	leave
    1734:	c3                   	ret

0000000000001735 <writetest1>:

void
writetest1(void)
{
    1735:	55                   	push   %rbp
    1736:	48 89 e5             	mov    %rsp,%rbp
    1739:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd, n;

  printf(1, "big files test\n");
    173d:	48 b8 7c 73 00 00 00 	movabs $0x737c,%rax
    1744:	00 00 00 
    1747:	48 89 c6             	mov    %rax,%rsi
    174a:	bf 01 00 00 00       	mov    $0x1,%edi
    174f:	b8 00 00 00 00       	mov    $0x0,%eax
    1754:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    175b:	00 00 00 
    175e:	ff d2                	call   *%rdx

  fd = open("big", O_CREATE|O_RDWR);
    1760:	48 b8 8c 73 00 00 00 	movabs $0x738c,%rax
    1767:	00 00 00 
    176a:	be 02 02 00 00       	mov    $0x202,%esi
    176f:	48 89 c7             	mov    %rax,%rdi
    1772:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1779:	00 00 00 
    177c:	ff d0                	call   *%rax
    177e:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    1781:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1785:	79 19                	jns    17a0 <writetest1+0x6b>
    failexit("error: creat big");
    1787:	48 b8 90 73 00 00 00 	movabs $0x7390,%rax
    178e:	00 00 00 
    1791:	48 89 c7             	mov    %rax,%rdi
    1794:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    179b:	00 00 00 
    179e:	ff d0                	call   *%rax
  }

  for(i = 0; i < MAXFILE; i++){
    17a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    17a7:	eb 56                	jmp    17ff <writetest1+0xca>
    ((int*)buf)[0] = i;
    17a9:	48 ba 40 88 00 00 00 	movabs $0x8840,%rdx
    17b0:	00 00 00 
    17b3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    17b6:	89 02                	mov    %eax,(%rdx)
    if(write(fd, buf, 512) != 512){
    17b8:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    17bf:	00 00 00 
    17c2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    17c5:	ba 00 02 00 00       	mov    $0x200,%edx
    17ca:	48 89 ce             	mov    %rcx,%rsi
    17cd:	89 c7                	mov    %eax,%edi
    17cf:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    17d6:	00 00 00 
    17d9:	ff d0                	call   *%rax
    17db:	3d 00 02 00 00       	cmp    $0x200,%eax
    17e0:	74 19                	je     17fb <writetest1+0xc6>
      failexit("error: write big file");
    17e2:	48 b8 a1 73 00 00 00 	movabs $0x73a1,%rax
    17e9:	00 00 00 
    17ec:	48 89 c7             	mov    %rax,%rdi
    17ef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    17f6:	00 00 00 
    17f9:	ff d0                	call   *%rax
  for(i = 0; i < MAXFILE; i++){
    17fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    17ff:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1802:	3d 8b 00 00 00       	cmp    $0x8b,%eax
    1807:	76 a0                	jbe    17a9 <writetest1+0x74>
    }
  }

  close(fd);
    1809:	8b 45 f4             	mov    -0xc(%rbp),%eax
    180c:	89 c7                	mov    %eax,%edi
    180e:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    1815:	00 00 00 
    1818:	ff d0                	call   *%rax

  fd = open("big", O_RDONLY);
    181a:	48 b8 8c 73 00 00 00 	movabs $0x738c,%rax
    1821:	00 00 00 
    1824:	be 00 00 00 00       	mov    $0x0,%esi
    1829:	48 89 c7             	mov    %rax,%rdi
    182c:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1833:	00 00 00 
    1836:	ff d0                	call   *%rax
    1838:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    183b:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    183f:	79 19                	jns    185a <writetest1+0x125>
    failexit("error: open big");
    1841:	48 b8 b7 73 00 00 00 	movabs $0x73b7,%rax
    1848:	00 00 00 
    184b:	48 89 c7             	mov    %rax,%rdi
    184e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1855:	00 00 00 
    1858:	ff d0                	call   *%rax
  }

  n = 0;
    185a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(;;){
    i = read(fd, buf, 512);
    1861:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    1868:	00 00 00 
    186b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    186e:	ba 00 02 00 00       	mov    $0x200,%edx
    1873:	48 89 ce             	mov    %rcx,%rsi
    1876:	89 c7                	mov    %eax,%edi
    1878:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    187f:	00 00 00 
    1882:	ff d0                	call   *%rax
    1884:	89 45 fc             	mov    %eax,-0x4(%rbp)
    if(i == 0){
    1887:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    188b:	75 41                	jne    18ce <writetest1+0x199>
      if(n == MAXFILE - 1){
    188d:	81 7d f8 8b 00 00 00 	cmpl   $0x8b,-0x8(%rbp)
    1894:	0f 85 cb 00 00 00    	jne    1965 <writetest1+0x230>
        printf(1, "read only %d blocks from big. failed", n);
    189a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    189d:	48 b9 c8 73 00 00 00 	movabs $0x73c8,%rcx
    18a4:	00 00 00 
    18a7:	89 c2                	mov    %eax,%edx
    18a9:	48 89 ce             	mov    %rcx,%rsi
    18ac:	bf 01 00 00 00       	mov    $0x1,%edi
    18b1:	b8 00 00 00 00       	mov    $0x0,%eax
    18b6:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    18bd:	00 00 00 
    18c0:	ff d1                	call   *%rcx
        exit();
    18c2:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    18c9:	00 00 00 
    18cc:	ff d0                	call   *%rax
      }
      break;
    } else if(i != 512){
    18ce:	81 7d fc 00 02 00 00 	cmpl   $0x200,-0x4(%rbp)
    18d5:	74 34                	je     190b <writetest1+0x1d6>
      printf(1, "read failed %d\n", i);
    18d7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    18da:	48 b9 ed 73 00 00 00 	movabs $0x73ed,%rcx
    18e1:	00 00 00 
    18e4:	89 c2                	mov    %eax,%edx
    18e6:	48 89 ce             	mov    %rcx,%rsi
    18e9:	bf 01 00 00 00       	mov    $0x1,%edi
    18ee:	b8 00 00 00 00       	mov    $0x0,%eax
    18f3:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    18fa:	00 00 00 
    18fd:	ff d1                	call   *%rcx
      exit();
    18ff:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1906:	00 00 00 
    1909:	ff d0                	call   *%rax
    }
    if(((int*)buf)[0] != n){
    190b:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    1912:	00 00 00 
    1915:	8b 00                	mov    (%rax),%eax
    1917:	39 45 f8             	cmp    %eax,-0x8(%rbp)
    191a:	74 40                	je     195c <writetest1+0x227>
      printf(1, "read content of block %d is %d. failed\n",
             n, ((int*)buf)[0]);
    191c:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    1923:	00 00 00 
      printf(1, "read content of block %d is %d. failed\n",
    1926:	8b 10                	mov    (%rax),%edx
    1928:	8b 45 f8             	mov    -0x8(%rbp),%eax
    192b:	48 be 00 74 00 00 00 	movabs $0x7400,%rsi
    1932:	00 00 00 
    1935:	89 d1                	mov    %edx,%ecx
    1937:	89 c2                	mov    %eax,%edx
    1939:	bf 01 00 00 00       	mov    $0x1,%edi
    193e:	b8 00 00 00 00       	mov    $0x0,%eax
    1943:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    194a:	00 00 00 
    194d:	41 ff d0             	call   *%r8
      exit();
    1950:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1957:	00 00 00 
    195a:	ff d0                	call   *%rax
    }
    n++;
    195c:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    i = read(fd, buf, 512);
    1960:	e9 fc fe ff ff       	jmp    1861 <writetest1+0x12c>
      break;
    1965:	90                   	nop
  }
  close(fd);
    1966:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1969:	89 c7                	mov    %eax,%edi
    196b:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    1972:	00 00 00 
    1975:	ff d0                	call   *%rax
  if(unlink("big") < 0){
    1977:	48 b8 8c 73 00 00 00 	movabs $0x738c,%rax
    197e:	00 00 00 
    1981:	48 89 c7             	mov    %rax,%rdi
    1984:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    198b:	00 00 00 
    198e:	ff d0                	call   *%rax
    1990:	85 c0                	test   %eax,%eax
    1992:	79 25                	jns    19b9 <writetest1+0x284>
    failexit("unlink big");
    1994:	48 b8 28 74 00 00 00 	movabs $0x7428,%rax
    199b:	00 00 00 
    199e:	48 89 c7             	mov    %rax,%rdi
    19a1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    19a8:	00 00 00 
    19ab:	ff d0                	call   *%rax
    exit();
    19ad:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    19b4:	00 00 00 
    19b7:	ff d0                	call   *%rax
  }
  printf(1, "big files ok\n");
    19b9:	48 b8 33 74 00 00 00 	movabs $0x7433,%rax
    19c0:	00 00 00 
    19c3:	48 89 c6             	mov    %rax,%rsi
    19c6:	bf 01 00 00 00       	mov    $0x1,%edi
    19cb:	b8 00 00 00 00       	mov    $0x0,%eax
    19d0:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    19d7:	00 00 00 
    19da:	ff d2                	call   *%rdx
}
    19dc:	90                   	nop
    19dd:	c9                   	leave
    19de:	c3                   	ret

00000000000019df <createtest>:

void
createtest(void)
{
    19df:	55                   	push   %rbp
    19e0:	48 89 e5             	mov    %rsp,%rbp
    19e3:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(1, "many creates, followed by unlink test\n");
    19e7:	48 b8 48 74 00 00 00 	movabs $0x7448,%rax
    19ee:	00 00 00 
    19f1:	48 89 c6             	mov    %rax,%rsi
    19f4:	bf 01 00 00 00       	mov    $0x1,%edi
    19f9:	b8 00 00 00 00       	mov    $0x0,%eax
    19fe:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1a05:	00 00 00 
    1a08:	ff d2                	call   *%rdx

  name[0] = 'a';
    1a0a:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1a11:	00 00 00 
    1a14:	c6 00 61             	movb   $0x61,(%rax)
  name[2] = '\0';
    1a17:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1a1e:	00 00 00 
    1a21:	c6 40 02 00          	movb   $0x0,0x2(%rax)
  for(i = 0; i < 52; i++){
    1a25:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a2c:	eb 4b                	jmp    1a79 <createtest+0x9a>
    name[1] = '0' + i;
    1a2e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a31:	83 c0 30             	add    $0x30,%eax
    1a34:	89 c2                	mov    %eax,%edx
    1a36:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1a3d:	00 00 00 
    1a40:	88 50 01             	mov    %dl,0x1(%rax)
    fd = open(name, O_CREATE|O_RDWR);
    1a43:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1a4a:	00 00 00 
    1a4d:	be 02 02 00 00       	mov    $0x202,%esi
    1a52:	48 89 c7             	mov    %rax,%rdi
    1a55:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1a5c:	00 00 00 
    1a5f:	ff d0                	call   *%rax
    1a61:	89 45 f8             	mov    %eax,-0x8(%rbp)
    close(fd);
    1a64:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1a67:	89 c7                	mov    %eax,%edi
    1a69:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    1a70:	00 00 00 
    1a73:	ff d0                	call   *%rax
  for(i = 0; i < 52; i++){
    1a75:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1a79:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1a7d:	7e af                	jle    1a2e <createtest+0x4f>
  }
  for(i = 0; i < 52; i++){
    1a7f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1a86:	eb 32                	jmp    1aba <createtest+0xdb>
    name[1] = '0' + i;
    1a88:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1a8b:	83 c0 30             	add    $0x30,%eax
    1a8e:	89 c2                	mov    %eax,%edx
    1a90:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1a97:	00 00 00 
    1a9a:	88 50 01             	mov    %dl,0x1(%rax)
    unlink(name);
    1a9d:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1aa4:	00 00 00 
    1aa7:	48 89 c7             	mov    %rax,%rdi
    1aaa:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    1ab1:	00 00 00 
    1ab4:	ff d0                	call   *%rax
  for(i = 0; i < 52; i++){
    1ab6:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1aba:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1abe:	7e c8                	jle    1a88 <createtest+0xa9>
  }
  for(i = 0; i < 52; i++){
    1ac0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    1ac7:	eb 59                	jmp    1b22 <createtest+0x143>
    name[1] = '0' + i;
    1ac9:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1acc:	83 c0 30             	add    $0x30,%eax
    1acf:	89 c2                	mov    %eax,%edx
    1ad1:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1ad8:	00 00 00 
    1adb:	88 50 01             	mov    %dl,0x1(%rax)
    fd = open(name, O_RDWR);
    1ade:	48 b8 40 a8 00 00 00 	movabs $0xa840,%rax
    1ae5:	00 00 00 
    1ae8:	be 02 00 00 00       	mov    $0x2,%esi
    1aed:	48 89 c7             	mov    %rax,%rdi
    1af0:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    1af7:	00 00 00 
    1afa:	ff d0                	call   *%rax
    1afc:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0) {
    1aff:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    1b03:	78 19                	js     1b1e <createtest+0x13f>
      failexit("open should fail.");
    1b05:	48 b8 6f 74 00 00 00 	movabs $0x746f,%rax
    1b0c:	00 00 00 
    1b0f:	48 89 c7             	mov    %rax,%rdi
    1b12:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1b19:	00 00 00 
    1b1c:	ff d0                	call   *%rax
  for(i = 0; i < 52; i++){
    1b1e:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    1b22:	83 7d fc 33          	cmpl   $0x33,-0x4(%rbp)
    1b26:	7e a1                	jle    1ac9 <createtest+0xea>
    }
  }

  printf(1, "many creates, followed by unlink; ok\n");
    1b28:	48 b8 88 74 00 00 00 	movabs $0x7488,%rax
    1b2f:	00 00 00 
    1b32:	48 89 c6             	mov    %rax,%rsi
    1b35:	bf 01 00 00 00       	mov    $0x1,%edi
    1b3a:	b8 00 00 00 00       	mov    $0x0,%eax
    1b3f:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1b46:	00 00 00 
    1b49:	ff d2                	call   *%rdx
}
    1b4b:	90                   	nop
    1b4c:	c9                   	leave
    1b4d:	c3                   	ret

0000000000001b4e <dirtest>:

void dirtest(void)
{
    1b4e:	55                   	push   %rbp
    1b4f:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "mkdir test\n");
    1b52:	48 b8 ae 74 00 00 00 	movabs $0x74ae,%rax
    1b59:	00 00 00 
    1b5c:	48 89 c6             	mov    %rax,%rsi
    1b5f:	bf 01 00 00 00       	mov    $0x1,%edi
    1b64:	b8 00 00 00 00       	mov    $0x0,%eax
    1b69:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1b70:	00 00 00 
    1b73:	ff d2                	call   *%rdx

  if(mkdir("dir0") < 0){
    1b75:	48 b8 ba 74 00 00 00 	movabs $0x74ba,%rax
    1b7c:	00 00 00 
    1b7f:	48 89 c7             	mov    %rax,%rdi
    1b82:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    1b89:	00 00 00 
    1b8c:	ff d0                	call   *%rax
    1b8e:	85 c0                	test   %eax,%eax
    1b90:	79 19                	jns    1bab <dirtest+0x5d>
    failexit("mkdir");
    1b92:	48 b8 8f 71 00 00 00 	movabs $0x718f,%rax
    1b99:	00 00 00 
    1b9c:	48 89 c7             	mov    %rax,%rdi
    1b9f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1ba6:	00 00 00 
    1ba9:	ff d0                	call   *%rax
  }

  if(chdir("dir0") < 0){
    1bab:	48 b8 ba 74 00 00 00 	movabs $0x74ba,%rax
    1bb2:	00 00 00 
    1bb5:	48 89 c7             	mov    %rax,%rdi
    1bb8:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    1bbf:	00 00 00 
    1bc2:	ff d0                	call   *%rax
    1bc4:	85 c0                	test   %eax,%eax
    1bc6:	79 19                	jns    1be1 <dirtest+0x93>
    failexit("chdir dir0");
    1bc8:	48 b8 bf 74 00 00 00 	movabs $0x74bf,%rax
    1bcf:	00 00 00 
    1bd2:	48 89 c7             	mov    %rax,%rdi
    1bd5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1bdc:	00 00 00 
    1bdf:	ff d0                	call   *%rax
  }

  if(chdir("..") < 0){
    1be1:	48 b8 ca 74 00 00 00 	movabs $0x74ca,%rax
    1be8:	00 00 00 
    1beb:	48 89 c7             	mov    %rax,%rdi
    1bee:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    1bf5:	00 00 00 
    1bf8:	ff d0                	call   *%rax
    1bfa:	85 c0                	test   %eax,%eax
    1bfc:	79 19                	jns    1c17 <dirtest+0xc9>
    failexit("chdir ..");
    1bfe:	48 b8 cd 74 00 00 00 	movabs $0x74cd,%rax
    1c05:	00 00 00 
    1c08:	48 89 c7             	mov    %rax,%rdi
    1c0b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c12:	00 00 00 
    1c15:	ff d0                	call   *%rax
  }

  if(unlink("dir0") < 0){
    1c17:	48 b8 ba 74 00 00 00 	movabs $0x74ba,%rax
    1c1e:	00 00 00 
    1c21:	48 89 c7             	mov    %rax,%rdi
    1c24:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    1c2b:	00 00 00 
    1c2e:	ff d0                	call   *%rax
    1c30:	85 c0                	test   %eax,%eax
    1c32:	79 19                	jns    1c4d <dirtest+0xff>
    failexit("unlink dir0");
    1c34:	48 b8 d6 74 00 00 00 	movabs $0x74d6,%rax
    1c3b:	00 00 00 
    1c3e:	48 89 c7             	mov    %rax,%rdi
    1c41:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1c48:	00 00 00 
    1c4b:	ff d0                	call   *%rax
  }
  printf(1, "mkdir test ok\n");
    1c4d:	48 b8 e2 74 00 00 00 	movabs $0x74e2,%rax
    1c54:	00 00 00 
    1c57:	48 89 c6             	mov    %rax,%rsi
    1c5a:	bf 01 00 00 00       	mov    $0x1,%edi
    1c5f:	b8 00 00 00 00       	mov    $0x0,%eax
    1c64:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1c6b:	00 00 00 
    1c6e:	ff d2                	call   *%rdx
}
    1c70:	90                   	nop
    1c71:	5d                   	pop    %rbp
    1c72:	c3                   	ret

0000000000001c73 <exectest>:

void
exectest(void)
{
    1c73:	55                   	push   %rbp
    1c74:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "exec test\n");
    1c77:	48 b8 f1 74 00 00 00 	movabs $0x74f1,%rax
    1c7e:	00 00 00 
    1c81:	48 89 c6             	mov    %rax,%rsi
    1c84:	bf 01 00 00 00       	mov    $0x1,%edi
    1c89:	b8 00 00 00 00       	mov    $0x0,%eax
    1c8e:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1c95:	00 00 00 
    1c98:	ff d2                	call   *%rdx
  if(exec("echo", echoargv) < 0){
    1c9a:	48 ba e0 87 00 00 00 	movabs $0x87e0,%rdx
    1ca1:	00 00 00 
    1ca4:	48 b8 58 71 00 00 00 	movabs $0x7158,%rax
    1cab:	00 00 00 
    1cae:	48 89 d6             	mov    %rdx,%rsi
    1cb1:	48 89 c7             	mov    %rax,%rdi
    1cb4:	48 b8 a7 67 00 00 00 	movabs $0x67a7,%rax
    1cbb:	00 00 00 
    1cbe:	ff d0                	call   *%rax
    1cc0:	85 c0                	test   %eax,%eax
    1cc2:	79 19                	jns    1cdd <exectest+0x6a>
    failexit("exec echo");
    1cc4:	48 b8 fc 74 00 00 00 	movabs $0x74fc,%rax
    1ccb:	00 00 00 
    1cce:	48 89 c7             	mov    %rax,%rdi
    1cd1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1cd8:	00 00 00 
    1cdb:	ff d0                	call   *%rax
  }
  printf(1, "exec test ok\n");
    1cdd:	48 b8 06 75 00 00 00 	movabs $0x7506,%rax
    1ce4:	00 00 00 
    1ce7:	48 89 c6             	mov    %rax,%rsi
    1cea:	bf 01 00 00 00       	mov    $0x1,%edi
    1cef:	b8 00 00 00 00       	mov    $0x0,%eax
    1cf4:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1cfb:	00 00 00 
    1cfe:	ff d2                	call   *%rdx
}
    1d00:	90                   	nop
    1d01:	5d                   	pop    %rbp
    1d02:	c3                   	ret

0000000000001d03 <nullptrtest>:

void
nullptrtest(void)
{
    1d03:	55                   	push   %rbp
    1d04:	48 89 e5             	mov    %rsp,%rbp
    1d07:	48 83 ec 10          	sub    $0x10,%rsp
  printf(1, "null pointer test\n");
    1d0b:	48 b8 14 75 00 00 00 	movabs $0x7514,%rax
    1d12:	00 00 00 
    1d15:	48 89 c6             	mov    %rax,%rsi
    1d18:	bf 01 00 00 00       	mov    $0x1,%edi
    1d1d:	b8 00 00 00 00       	mov    $0x0,%eax
    1d22:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1d29:	00 00 00 
    1d2c:	ff d2                	call   *%rdx
  printf(1, "expect one killed process\n");
    1d2e:	48 b8 27 75 00 00 00 	movabs $0x7527,%rax
    1d35:	00 00 00 
    1d38:	48 89 c6             	mov    %rax,%rsi
    1d3b:	bf 01 00 00 00       	mov    $0x1,%edi
    1d40:	b8 00 00 00 00       	mov    $0x0,%eax
    1d45:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1d4c:	00 00 00 
    1d4f:	ff d2                	call   *%rdx
  int ppid = getpid();
    1d51:	48 b8 1c 68 00 00 00 	movabs $0x681c,%rax
    1d58:	00 00 00 
    1d5b:	ff d0                	call   *%rax
    1d5d:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if (fork() == 0) {
    1d60:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    1d67:	00 00 00 
    1d6a:	ff d0                	call   *%rax
    1d6c:	85 c0                	test   %eax,%eax
    1d6e:	75 4c                	jne    1dbc <nullptrtest+0xb9>
    *(addr_t *)(0) = 10;
    1d70:	b8 00 00 00 00       	mov    $0x0,%eax
    1d75:	48 c7 00 0a 00 00 00 	movq   $0xa,(%rax)
    printf(1, "can write to unmapped page 0, failed");
    1d7c:	48 b8 48 75 00 00 00 	movabs $0x7548,%rax
    1d83:	00 00 00 
    1d86:	48 89 c6             	mov    %rax,%rsi
    1d89:	bf 01 00 00 00       	mov    $0x1,%edi
    1d8e:	b8 00 00 00 00       	mov    $0x0,%eax
    1d93:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1d9a:	00 00 00 
    1d9d:	ff d2                	call   *%rdx
    kill(ppid);
    1d9f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1da2:	89 c7                	mov    %eax,%edi
    1da4:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    1dab:	00 00 00 
    1dae:	ff d0                	call   *%rax
    exit();
    1db0:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1db7:	00 00 00 
    1dba:	ff d0                	call   *%rax
  } else {
    wait();
    1dbc:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    1dc3:	00 00 00 
    1dc6:	ff d0                	call   *%rax
  }
  printf(1, "null pointer test ok\n");
    1dc8:	48 b8 6d 75 00 00 00 	movabs $0x756d,%rax
    1dcf:	00 00 00 
    1dd2:	48 89 c6             	mov    %rax,%rsi
    1dd5:	bf 01 00 00 00       	mov    $0x1,%edi
    1dda:	b8 00 00 00 00       	mov    $0x0,%eax
    1ddf:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    1de6:	00 00 00 
    1de9:	ff d2                	call   *%rdx
}
    1deb:	90                   	nop
    1dec:	c9                   	leave
    1ded:	c3                   	ret

0000000000001dee <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
    1dee:	55                   	push   %rbp
    1def:	48 89 e5             	mov    %rsp,%rbp
    1df2:	48 83 ec 20          	sub    $0x20,%rsp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    1df6:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
    1dfa:	48 89 c7             	mov    %rax,%rdi
    1dfd:	48 b8 66 67 00 00 00 	movabs $0x6766,%rax
    1e04:	00 00 00 
    1e07:	ff d0                	call   *%rax
    1e09:	85 c0                	test   %eax,%eax
    1e0b:	74 19                	je     1e26 <pipe1+0x38>
    failexit("pipe()");
    1e0d:	48 b8 83 75 00 00 00 	movabs $0x7583,%rax
    1e14:	00 00 00 
    1e17:	48 89 c7             	mov    %rax,%rdi
    1e1a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1e21:	00 00 00 
    1e24:	ff d0                	call   *%rax
  }
  pid = fork();
    1e26:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    1e2d:	00 00 00 
    1e30:	ff d0                	call   *%rax
    1e32:	89 45 e8             	mov    %eax,-0x18(%rbp)
  seq = 0;
    1e35:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  if(pid == 0){
    1e3c:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    1e40:	0f 85 a6 00 00 00    	jne    1eec <pipe1+0xfe>
    close(fds[0]);
    1e46:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1e49:	89 c7                	mov    %eax,%edi
    1e4b:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    1e52:	00 00 00 
    1e55:	ff d0                	call   *%rax
    for(n = 0; n < 5; n++){
    1e57:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    1e5e:	eb 7a                	jmp    1eda <pipe1+0xec>
      for(i = 0; i < 1033; i++)
    1e60:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1e67:	eb 21                	jmp    1e8a <pipe1+0x9c>
        buf[i] = seq++;
    1e69:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1e6c:	8d 50 01             	lea    0x1(%rax),%edx
    1e6f:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1e72:	89 c1                	mov    %eax,%ecx
    1e74:	48 ba 40 88 00 00 00 	movabs $0x8840,%rdx
    1e7b:	00 00 00 
    1e7e:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1e81:	48 98                	cltq
    1e83:	88 0c 02             	mov    %cl,(%rdx,%rax,1)
      for(i = 0; i < 1033; i++)
    1e86:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1e8a:	81 7d f8 08 04 00 00 	cmpl   $0x408,-0x8(%rbp)
    1e91:	7e d6                	jle    1e69 <pipe1+0x7b>
      if(write(fds[1], buf, 1033) != 1033){
    1e93:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1e96:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    1e9d:	00 00 00 
    1ea0:	ba 09 04 00 00       	mov    $0x409,%edx
    1ea5:	48 89 ce             	mov    %rcx,%rsi
    1ea8:	89 c7                	mov    %eax,%edi
    1eaa:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    1eb1:	00 00 00 
    1eb4:	ff d0                	call   *%rax
    1eb6:	3d 09 04 00 00       	cmp    $0x409,%eax
    1ebb:	74 19                	je     1ed6 <pipe1+0xe8>
        failexit("pipe1 oops 1");
    1ebd:	48 b8 8a 75 00 00 00 	movabs $0x758a,%rax
    1ec4:	00 00 00 
    1ec7:	48 89 c7             	mov    %rax,%rdi
    1eca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1ed1:	00 00 00 
    1ed4:	ff d0                	call   *%rax
    for(n = 0; n < 5; n++){
    1ed6:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    1eda:	83 7d f4 04          	cmpl   $0x4,-0xc(%rbp)
    1ede:	7e 80                	jle    1e60 <pipe1+0x72>
      }
    }
    exit();
    1ee0:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1ee7:	00 00 00 
    1eea:	ff d0                	call   *%rax
  } else if(pid > 0){
    1eec:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    1ef0:	0f 8e 20 01 00 00    	jle    2016 <pipe1+0x228>
    close(fds[1]);
    1ef6:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    1ef9:	89 c7                	mov    %eax,%edi
    1efb:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    1f02:	00 00 00 
    1f05:	ff d0                	call   *%rax
    total = 0;
    1f07:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%rbp)
    cc = 1;
    1f0e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
    1f15:	eb 75                	jmp    1f8c <pipe1+0x19e>
      for(i = 0; i < n; i++){
    1f17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    1f1e:	eb 4a                	jmp    1f6a <pipe1+0x17c>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1f20:	48 ba 40 88 00 00 00 	movabs $0x8840,%rdx
    1f27:	00 00 00 
    1f2a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1f2d:	48 98                	cltq
    1f2f:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    1f33:	0f be c8             	movsbl %al,%ecx
    1f36:	8b 45 fc             	mov    -0x4(%rbp),%eax
    1f39:	8d 50 01             	lea    0x1(%rax),%edx
    1f3c:	89 55 fc             	mov    %edx,-0x4(%rbp)
    1f3f:	31 c8                	xor    %ecx,%eax
    1f41:	0f b6 c0             	movzbl %al,%eax
    1f44:	85 c0                	test   %eax,%eax
    1f46:	74 1e                	je     1f66 <pipe1+0x178>
          failexit("pipe1 oops 2");
    1f48:	48 b8 97 75 00 00 00 	movabs $0x7597,%rax
    1f4f:	00 00 00 
    1f52:	48 89 c7             	mov    %rax,%rdi
    1f55:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    1f5c:	00 00 00 
    1f5f:	ff d0                	call   *%rax
    1f61:	e9 ec 00 00 00       	jmp    2052 <pipe1+0x264>
      for(i = 0; i < n; i++){
    1f66:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    1f6a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    1f6d:	3b 45 f4             	cmp    -0xc(%rbp),%eax
    1f70:	7c ae                	jl     1f20 <pipe1+0x132>
          return;
        }
      }
      total += n;
    1f72:	8b 45 f4             	mov    -0xc(%rbp),%eax
    1f75:	01 45 ec             	add    %eax,-0x14(%rbp)
      cc = cc * 2;
    1f78:	d1 65 f0             	shll   $1,-0x10(%rbp)
      if(cc > sizeof(buf))
    1f7b:	8b 45 f0             	mov    -0x10(%rbp),%eax
    1f7e:	3d 00 20 00 00       	cmp    $0x2000,%eax
    1f83:	76 07                	jbe    1f8c <pipe1+0x19e>
        cc = sizeof(buf);
    1f85:	c7 45 f0 00 20 00 00 	movl   $0x2000,-0x10(%rbp)
    while((n = read(fds[0], buf, cc)) > 0){
    1f8c:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1f8f:	8b 55 f0             	mov    -0x10(%rbp),%edx
    1f92:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    1f99:	00 00 00 
    1f9c:	48 89 ce             	mov    %rcx,%rsi
    1f9f:	89 c7                	mov    %eax,%edi
    1fa1:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    1fa8:	00 00 00 
    1fab:	ff d0                	call   *%rax
    1fad:	89 45 f4             	mov    %eax,-0xc(%rbp)
    1fb0:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    1fb4:	0f 8f 5d ff ff ff    	jg     1f17 <pipe1+0x129>
    }
    if(total != 5 * 1033){
    1fba:	81 7d ec 2d 14 00 00 	cmpl   $0x142d,-0x14(%rbp)
    1fc1:	74 34                	je     1ff7 <pipe1+0x209>
      printf(1, "pipe1 oops 3 total %d\n", total);
    1fc3:	8b 45 ec             	mov    -0x14(%rbp),%eax
    1fc6:	48 b9 a4 75 00 00 00 	movabs $0x75a4,%rcx
    1fcd:	00 00 00 
    1fd0:	89 c2                	mov    %eax,%edx
    1fd2:	48 89 ce             	mov    %rcx,%rsi
    1fd5:	bf 01 00 00 00       	mov    $0x1,%edi
    1fda:	b8 00 00 00 00       	mov    $0x0,%eax
    1fdf:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    1fe6:	00 00 00 
    1fe9:	ff d1                	call   *%rcx
      exit();
    1feb:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    1ff2:	00 00 00 
    1ff5:	ff d0                	call   *%rax
    }
    close(fds[0]);
    1ff7:	8b 45 e0             	mov    -0x20(%rbp),%eax
    1ffa:	89 c7                	mov    %eax,%edi
    1ffc:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2003:	00 00 00 
    2006:	ff d0                	call   *%rax
    wait();
    2008:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    200f:	00 00 00 
    2012:	ff d0                	call   *%rax
    2014:	eb 19                	jmp    202f <pipe1+0x241>
  } else {
    failexit("fork()");
    2016:	48 b8 bb 75 00 00 00 	movabs $0x75bb,%rax
    201d:	00 00 00 
    2020:	48 89 c7             	mov    %rax,%rdi
    2023:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    202a:	00 00 00 
    202d:	ff d0                	call   *%rax
  }
  printf(1, "pipe1 ok\n");
    202f:	48 b8 c2 75 00 00 00 	movabs $0x75c2,%rax
    2036:	00 00 00 
    2039:	48 89 c6             	mov    %rax,%rsi
    203c:	bf 01 00 00 00       	mov    $0x1,%edi
    2041:	b8 00 00 00 00       	mov    $0x0,%eax
    2046:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    204d:	00 00 00 
    2050:	ff d2                	call   *%rdx
}
    2052:	c9                   	leave
    2053:	c3                   	ret

0000000000002054 <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
    2054:	55                   	push   %rbp
    2055:	48 89 e5             	mov    %rsp,%rbp
    2058:	48 83 ec 20          	sub    $0x20,%rsp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
    205c:	48 b8 cc 75 00 00 00 	movabs $0x75cc,%rax
    2063:	00 00 00 
    2066:	48 89 c6             	mov    %rax,%rsi
    2069:	bf 01 00 00 00       	mov    $0x1,%edi
    206e:	b8 00 00 00 00       	mov    $0x0,%eax
    2073:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    207a:	00 00 00 
    207d:	ff d2                	call   *%rdx
  pid1 = fork();
    207f:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    2086:	00 00 00 
    2089:	ff d0                	call   *%rax
    208b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(pid1 == 0)
    208e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2092:	75 03                	jne    2097 <preempt+0x43>
    for(;;)
    2094:	90                   	nop
    2095:	eb fd                	jmp    2094 <preempt+0x40>
      ;

  pid2 = fork();
    2097:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    209e:	00 00 00 
    20a1:	ff d0                	call   *%rax
    20a3:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid2 == 0)
    20a6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    20aa:	75 03                	jne    20af <preempt+0x5b>
    for(;;)
    20ac:	90                   	nop
    20ad:	eb fd                	jmp    20ac <preempt+0x58>
      ;

  pipe(pfds);
    20af:	48 8d 45 ec          	lea    -0x14(%rbp),%rax
    20b3:	48 89 c7             	mov    %rax,%rdi
    20b6:	48 b8 66 67 00 00 00 	movabs $0x6766,%rax
    20bd:	00 00 00 
    20c0:	ff d0                	call   *%rax
  pid3 = fork();
    20c2:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    20c9:	00 00 00 
    20cc:	ff d0                	call   *%rax
    20ce:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid3 == 0){
    20d1:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    20d5:	75 70                	jne    2147 <preempt+0xf3>
    close(pfds[0]);
    20d7:	8b 45 ec             	mov    -0x14(%rbp),%eax
    20da:	89 c7                	mov    %eax,%edi
    20dc:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    20e3:	00 00 00 
    20e6:	ff d0                	call   *%rax
    if(write(pfds[1], "x", 1) != 1)
    20e8:	8b 45 f0             	mov    -0x10(%rbp),%eax
    20eb:	48 b9 d6 75 00 00 00 	movabs $0x75d6,%rcx
    20f2:	00 00 00 
    20f5:	ba 01 00 00 00       	mov    $0x1,%edx
    20fa:	48 89 ce             	mov    %rcx,%rsi
    20fd:	89 c7                	mov    %eax,%edi
    20ff:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    2106:	00 00 00 
    2109:	ff d0                	call   *%rax
    210b:	83 f8 01             	cmp    $0x1,%eax
    210e:	74 23                	je     2133 <preempt+0xdf>
      printf(1, "preempt write error");
    2110:	48 b8 d8 75 00 00 00 	movabs $0x75d8,%rax
    2117:	00 00 00 
    211a:	48 89 c6             	mov    %rax,%rsi
    211d:	bf 01 00 00 00       	mov    $0x1,%edi
    2122:	b8 00 00 00 00       	mov    $0x0,%eax
    2127:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    212e:	00 00 00 
    2131:	ff d2                	call   *%rdx
    close(pfds[1]);
    2133:	8b 45 f0             	mov    -0x10(%rbp),%eax
    2136:	89 c7                	mov    %eax,%edi
    2138:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    213f:	00 00 00 
    2142:	ff d0                	call   *%rax
    for(;;)
    2144:	90                   	nop
    2145:	eb fd                	jmp    2144 <preempt+0xf0>
      ;
  }

  close(pfds[1]);
    2147:	8b 45 f0             	mov    -0x10(%rbp),%eax
    214a:	89 c7                	mov    %eax,%edi
    214c:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2153:	00 00 00 
    2156:	ff d0                	call   *%rax
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    2158:	8b 45 ec             	mov    -0x14(%rbp),%eax
    215b:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    2162:	00 00 00 
    2165:	ba 00 20 00 00       	mov    $0x2000,%edx
    216a:	48 89 ce             	mov    %rcx,%rsi
    216d:	89 c7                	mov    %eax,%edi
    216f:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    2176:	00 00 00 
    2179:	ff d0                	call   *%rax
    217b:	83 f8 01             	cmp    $0x1,%eax
    217e:	74 28                	je     21a8 <preempt+0x154>
    printf(1, "preempt read error");
    2180:	48 b8 ec 75 00 00 00 	movabs $0x75ec,%rax
    2187:	00 00 00 
    218a:	48 89 c6             	mov    %rax,%rsi
    218d:	bf 01 00 00 00       	mov    $0x1,%edi
    2192:	b8 00 00 00 00       	mov    $0x0,%eax
    2197:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    219e:	00 00 00 
    21a1:	ff d2                	call   *%rdx
    21a3:	e9 d1 00 00 00       	jmp    2279 <preempt+0x225>
    return;
  }
  close(pfds[0]);
    21a8:	8b 45 ec             	mov    -0x14(%rbp),%eax
    21ab:	89 c7                	mov    %eax,%edi
    21ad:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    21b4:	00 00 00 
    21b7:	ff d0                	call   *%rax
  printf(1, "kill... ");
    21b9:	48 b8 ff 75 00 00 00 	movabs $0x75ff,%rax
    21c0:	00 00 00 
    21c3:	48 89 c6             	mov    %rax,%rsi
    21c6:	bf 01 00 00 00       	mov    $0x1,%edi
    21cb:	b8 00 00 00 00       	mov    $0x0,%eax
    21d0:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    21d7:	00 00 00 
    21da:	ff d2                	call   *%rdx
  kill(pid1);
    21dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    21df:	89 c7                	mov    %eax,%edi
    21e1:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    21e8:	00 00 00 
    21eb:	ff d0                	call   *%rax
  kill(pid2);
    21ed:	8b 45 f8             	mov    -0x8(%rbp),%eax
    21f0:	89 c7                	mov    %eax,%edi
    21f2:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    21f9:	00 00 00 
    21fc:	ff d0                	call   *%rax
  kill(pid3);
    21fe:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2201:	89 c7                	mov    %eax,%edi
    2203:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    220a:	00 00 00 
    220d:	ff d0                	call   *%rax
  printf(1, "wait... ");
    220f:	48 b8 08 76 00 00 00 	movabs $0x7608,%rax
    2216:	00 00 00 
    2219:	48 89 c6             	mov    %rax,%rsi
    221c:	bf 01 00 00 00       	mov    $0x1,%edi
    2221:	b8 00 00 00 00       	mov    $0x0,%eax
    2226:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    222d:	00 00 00 
    2230:	ff d2                	call   *%rdx
  wait();
    2232:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    2239:	00 00 00 
    223c:	ff d0                	call   *%rax
  wait();
    223e:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    2245:	00 00 00 
    2248:	ff d0                	call   *%rax
  wait();
    224a:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    2251:	00 00 00 
    2254:	ff d0                	call   *%rax
  printf(1, "preempt ok\n");
    2256:	48 b8 11 76 00 00 00 	movabs $0x7611,%rax
    225d:	00 00 00 
    2260:	48 89 c6             	mov    %rax,%rsi
    2263:	bf 01 00 00 00       	mov    $0x1,%edi
    2268:	b8 00 00 00 00       	mov    $0x0,%eax
    226d:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2274:	00 00 00 
    2277:	ff d2                	call   *%rdx
}
    2279:	c9                   	leave
    227a:	c3                   	ret

000000000000227b <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
    227b:	55                   	push   %rbp
    227c:	48 89 e5             	mov    %rsp,%rbp
    227f:	48 83 ec 10          	sub    $0x10,%rsp
  int i, pid;

  for(i = 0; i < 100; i++){
    2283:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    228a:	e9 86 00 00 00       	jmp    2315 <exitwait+0x9a>
    pid = fork();
    228f:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    2296:	00 00 00 
    2299:	ff d0                	call   *%rax
    229b:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0){
    229e:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    22a2:	79 25                	jns    22c9 <exitwait+0x4e>
      printf(1, "fork");
    22a4:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    22ab:	00 00 00 
    22ae:	48 89 c6             	mov    %rax,%rsi
    22b1:	bf 01 00 00 00       	mov    $0x1,%edi
    22b6:	b8 00 00 00 00       	mov    $0x0,%eax
    22bb:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    22c2:	00 00 00 
    22c5:	ff d2                	call   *%rdx
      return;
    22c7:	eb 79                	jmp    2342 <exitwait+0xc7>
    }
    if(pid){
    22c9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    22cd:	74 36                	je     2305 <exitwait+0x8a>
      if(wait() != pid){
    22cf:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    22d6:	00 00 00 
    22d9:	ff d0                	call   *%rax
    22db:	39 45 f8             	cmp    %eax,-0x8(%rbp)
    22de:	74 31                	je     2311 <exitwait+0x96>
        printf(1, "wait wrong pid\n");
    22e0:	48 b8 1d 76 00 00 00 	movabs $0x761d,%rax
    22e7:	00 00 00 
    22ea:	48 89 c6             	mov    %rax,%rsi
    22ed:	bf 01 00 00 00       	mov    $0x1,%edi
    22f2:	b8 00 00 00 00       	mov    $0x0,%eax
    22f7:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    22fe:	00 00 00 
    2301:	ff d2                	call   *%rdx
        return;
    2303:	eb 3d                	jmp    2342 <exitwait+0xc7>
      }
    } else {
      exit();
    2305:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    230c:	00 00 00 
    230f:	ff d0                	call   *%rax
  for(i = 0; i < 100; i++){
    2311:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2315:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    2319:	0f 8e 70 ff ff ff    	jle    228f <exitwait+0x14>
    }
  }
  printf(1, "exitwait ok\n");
    231f:	48 b8 2d 76 00 00 00 	movabs $0x762d,%rax
    2326:	00 00 00 
    2329:	48 89 c6             	mov    %rax,%rsi
    232c:	bf 01 00 00 00       	mov    $0x1,%edi
    2331:	b8 00 00 00 00       	mov    $0x0,%eax
    2336:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    233d:	00 00 00 
    2340:	ff d2                	call   *%rdx
}
    2342:	c9                   	leave
    2343:	c3                   	ret

0000000000002344 <mem>:

void
mem(void)
{
    2344:	55                   	push   %rbp
    2345:	48 89 e5             	mov    %rsp,%rbp
    2348:	48 83 ec 20          	sub    $0x20,%rsp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
    234c:	48 b8 3a 76 00 00 00 	movabs $0x763a,%rax
    2353:	00 00 00 
    2356:	48 89 c6             	mov    %rax,%rsi
    2359:	bf 01 00 00 00       	mov    $0x1,%edi
    235e:	b8 00 00 00 00       	mov    $0x0,%eax
    2363:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    236a:	00 00 00 
    236d:	ff d2                	call   *%rdx
  ppid = getpid();
    236f:	48 b8 1c 68 00 00 00 	movabs $0x681c,%rax
    2376:	00 00 00 
    2379:	ff d0                	call   *%rax
    237b:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if((pid = fork()) == 0){
    237e:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    2385:	00 00 00 
    2388:	ff d0                	call   *%rax
    238a:	89 45 f0             	mov    %eax,-0x10(%rbp)
    238d:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2391:	0f 85 29 01 00 00    	jne    24c0 <mem+0x17c>
    m1 = 0;
    2397:	48 c7 45 f8 00 00 00 	movq   $0x0,-0x8(%rbp)
    239e:	00 
    while((m2 = malloc(100001)) != 0){
    239f:	eb 13                	jmp    23b4 <mem+0x70>
      //printf(1, "m2 %p\n", m2);
      *(void**)m2 = m1;
    23a1:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    23a5:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    23a9:	48 89 10             	mov    %rdx,(%rax)
      m1 = m2;
    23ac:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    23b0:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while((m2 = malloc(100001)) != 0){
    23b4:	bf a1 86 01 00       	mov    $0x186a1,%edi
    23b9:	48 b8 0b 70 00 00 00 	movabs $0x700b,%rax
    23c0:	00 00 00 
    23c3:	ff d0                	call   *%rax
    23c5:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    23c9:	48 83 7d e8 00       	cmpq   $0x0,-0x18(%rbp)
    23ce:	75 d1                	jne    23a1 <mem+0x5d>
    }
    printf(1, "alloc ended\n");
    23d0:	48 b8 44 76 00 00 00 	movabs $0x7644,%rax
    23d7:	00 00 00 
    23da:	48 89 c6             	mov    %rax,%rsi
    23dd:	bf 01 00 00 00       	mov    $0x1,%edi
    23e2:	b8 00 00 00 00       	mov    $0x0,%eax
    23e7:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    23ee:	00 00 00 
    23f1:	ff d2                	call   *%rdx
    while(m1){
    23f3:	eb 26                	jmp    241b <mem+0xd7>
      m2 = *(void**)m1;
    23f5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    23f9:	48 8b 00             	mov    (%rax),%rax
    23fc:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
      free(m1);
    2400:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2404:	48 89 c7             	mov    %rax,%rdi
    2407:	48 b8 5e 6e 00 00 00 	movabs $0x6e5e,%rax
    240e:	00 00 00 
    2411:	ff d0                	call   *%rax
      m1 = m2;
    2413:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2417:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    while(m1){
    241b:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    2420:	75 d3                	jne    23f5 <mem+0xb1>
    }
    m1 = malloc(1024*20);
    2422:	bf 00 50 00 00       	mov    $0x5000,%edi
    2427:	48 b8 0b 70 00 00 00 	movabs $0x700b,%rax
    242e:	00 00 00 
    2431:	ff d0                	call   *%rax
    2433:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(m1 == 0){
    2437:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    243c:	75 40                	jne    247e <mem+0x13a>
      printf(1, "couldn't allocate mem?!!\n");
    243e:	48 b8 51 76 00 00 00 	movabs $0x7651,%rax
    2445:	00 00 00 
    2448:	48 89 c6             	mov    %rax,%rsi
    244b:	bf 01 00 00 00       	mov    $0x1,%edi
    2450:	b8 00 00 00 00       	mov    $0x0,%eax
    2455:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    245c:	00 00 00 
    245f:	ff d2                	call   *%rdx
      kill(ppid);
    2461:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2464:	89 c7                	mov    %eax,%edi
    2466:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    246d:	00 00 00 
    2470:	ff d0                	call   *%rax
      exit();
    2472:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2479:	00 00 00 
    247c:	ff d0                	call   *%rax
    }
    free(m1);
    247e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    2482:	48 89 c7             	mov    %rax,%rdi
    2485:	48 b8 5e 6e 00 00 00 	movabs $0x6e5e,%rax
    248c:	00 00 00 
    248f:	ff d0                	call   *%rax
    printf(1, "mem ok\n");
    2491:	48 b8 6b 76 00 00 00 	movabs $0x766b,%rax
    2498:	00 00 00 
    249b:	48 89 c6             	mov    %rax,%rsi
    249e:	bf 01 00 00 00       	mov    $0x1,%edi
    24a3:	b8 00 00 00 00       	mov    $0x0,%eax
    24a8:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    24af:	00 00 00 
    24b2:	ff d2                	call   *%rdx
    exit();
    24b4:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    24bb:	00 00 00 
    24be:	ff d0                	call   *%rax
  } else {
    wait();
    24c0:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    24c7:	00 00 00 
    24ca:	ff d0                	call   *%rax
  }
}
    24cc:	90                   	nop
    24cd:	c9                   	leave
    24ce:	c3                   	ret

00000000000024cf <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
    24cf:	55                   	push   %rbp
    24d0:	48 89 e5             	mov    %rsp,%rbp
    24d3:	48 83 ec 30          	sub    $0x30,%rsp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
    24d7:	48 b8 73 76 00 00 00 	movabs $0x7673,%rax
    24de:	00 00 00 
    24e1:	48 89 c6             	mov    %rax,%rsi
    24e4:	bf 01 00 00 00       	mov    $0x1,%edi
    24e9:	b8 00 00 00 00       	mov    $0x0,%eax
    24ee:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    24f5:	00 00 00 
    24f8:	ff d2                	call   *%rdx

  unlink("sharedfd");
    24fa:	48 b8 82 76 00 00 00 	movabs $0x7682,%rax
    2501:	00 00 00 
    2504:	48 89 c7             	mov    %rax,%rdi
    2507:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    250e:	00 00 00 
    2511:	ff d0                	call   *%rax
  fd = open("sharedfd", O_CREATE|O_RDWR);
    2513:	48 b8 82 76 00 00 00 	movabs $0x7682,%rax
    251a:	00 00 00 
    251d:	be 02 02 00 00       	mov    $0x202,%esi
    2522:	48 89 c7             	mov    %rax,%rdi
    2525:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    252c:	00 00 00 
    252f:	ff d0                	call   *%rax
    2531:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
    2534:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2538:	79 28                	jns    2562 <sharedfd+0x93>
    printf(1, "fstests: cannot open sharedfd for writing");
    253a:	48 b8 90 76 00 00 00 	movabs $0x7690,%rax
    2541:	00 00 00 
    2544:	48 89 c6             	mov    %rax,%rsi
    2547:	bf 01 00 00 00       	mov    $0x1,%edi
    254c:	b8 00 00 00 00       	mov    $0x0,%eax
    2551:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2558:	00 00 00 
    255b:	ff d2                	call   *%rdx
    return;
    255d:	e9 1c 02 00 00       	jmp    277e <sharedfd+0x2af>
  }
  pid = fork();
    2562:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    2569:	00 00 00 
    256c:	ff d0                	call   *%rax
    256e:	89 45 ec             	mov    %eax,-0x14(%rbp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
    2571:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    2575:	75 07                	jne    257e <sharedfd+0xaf>
    2577:	b9 63 00 00 00       	mov    $0x63,%ecx
    257c:	eb 05                	jmp    2583 <sharedfd+0xb4>
    257e:	b9 70 00 00 00       	mov    $0x70,%ecx
    2583:	48 8d 45 de          	lea    -0x22(%rbp),%rax
    2587:	ba 0a 00 00 00       	mov    $0xa,%edx
    258c:	89 ce                	mov    %ecx,%esi
    258e:	48 89 c7             	mov    %rax,%rdi
    2591:	48 b8 2f 65 00 00 00 	movabs $0x652f,%rax
    2598:	00 00 00 
    259b:	ff d0                	call   *%rax
  for(i = 0; i < 1000; i++){
    259d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    25a4:	eb 4b                	jmp    25f1 <sharedfd+0x122>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    25a6:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
    25aa:	8b 45 f0             	mov    -0x10(%rbp),%eax
    25ad:	ba 0a 00 00 00       	mov    $0xa,%edx
    25b2:	48 89 ce             	mov    %rcx,%rsi
    25b5:	89 c7                	mov    %eax,%edi
    25b7:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    25be:	00 00 00 
    25c1:	ff d0                	call   *%rax
    25c3:	83 f8 0a             	cmp    $0xa,%eax
    25c6:	74 25                	je     25ed <sharedfd+0x11e>
      printf(1, "fstests: write sharedfd failed\n");
    25c8:	48 b8 c0 76 00 00 00 	movabs $0x76c0,%rax
    25cf:	00 00 00 
    25d2:	48 89 c6             	mov    %rax,%rsi
    25d5:	bf 01 00 00 00       	mov    $0x1,%edi
    25da:	b8 00 00 00 00       	mov    $0x0,%eax
    25df:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    25e6:	00 00 00 
    25e9:	ff d2                	call   *%rdx
      break;
    25eb:	eb 0d                	jmp    25fa <sharedfd+0x12b>
  for(i = 0; i < 1000; i++){
    25ed:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    25f1:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    25f8:	7e ac                	jle    25a6 <sharedfd+0xd7>
    }
  }
  if(pid == 0)
    25fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
    25fe:	75 0c                	jne    260c <sharedfd+0x13d>
    exit();
    2600:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2607:	00 00 00 
    260a:	ff d0                	call   *%rax
  else
    wait();
    260c:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    2613:	00 00 00 
    2616:	ff d0                	call   *%rax
  close(fd);
    2618:	8b 45 f0             	mov    -0x10(%rbp),%eax
    261b:	89 c7                	mov    %eax,%edi
    261d:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2624:	00 00 00 
    2627:	ff d0                	call   *%rax
  fd = open("sharedfd", 0);
    2629:	48 b8 82 76 00 00 00 	movabs $0x7682,%rax
    2630:	00 00 00 
    2633:	be 00 00 00 00       	mov    $0x0,%esi
    2638:	48 89 c7             	mov    %rax,%rdi
    263b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2642:	00 00 00 
    2645:	ff d0                	call   *%rax
    2647:	89 45 f0             	mov    %eax,-0x10(%rbp)
  if(fd < 0){
    264a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    264e:	79 28                	jns    2678 <sharedfd+0x1a9>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    2650:	48 b8 e0 76 00 00 00 	movabs $0x76e0,%rax
    2657:	00 00 00 
    265a:	48 89 c6             	mov    %rax,%rsi
    265d:	bf 01 00 00 00       	mov    $0x1,%edi
    2662:	b8 00 00 00 00       	mov    $0x0,%eax
    2667:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    266e:	00 00 00 
    2671:	ff d2                	call   *%rdx
    return;
    2673:	e9 06 01 00 00       	jmp    277e <sharedfd+0x2af>
  }
  nc = np = 0;
    2678:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    267f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2682:	89 45 f8             	mov    %eax,-0x8(%rbp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    2685:	eb 39                	jmp    26c0 <sharedfd+0x1f1>
    for(i = 0; i < sizeof(buf); i++){
    2687:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    268e:	eb 28                	jmp    26b8 <sharedfd+0x1e9>
      if(buf[i] == 'c')
    2690:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2693:	48 98                	cltq
    2695:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
    269a:	3c 63                	cmp    $0x63,%al
    269c:	75 04                	jne    26a2 <sharedfd+0x1d3>
        nc++;
    269e:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
      if(buf[i] == 'p')
    26a2:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26a5:	48 98                	cltq
    26a7:	0f b6 44 05 de       	movzbl -0x22(%rbp,%rax,1),%eax
    26ac:	3c 70                	cmp    $0x70,%al
    26ae:	75 04                	jne    26b4 <sharedfd+0x1e5>
        np++;
    26b0:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    for(i = 0; i < sizeof(buf); i++){
    26b4:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    26b8:	8b 45 fc             	mov    -0x4(%rbp),%eax
    26bb:	83 f8 09             	cmp    $0x9,%eax
    26be:	76 d0                	jbe    2690 <sharedfd+0x1c1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    26c0:	48 8d 4d de          	lea    -0x22(%rbp),%rcx
    26c4:	8b 45 f0             	mov    -0x10(%rbp),%eax
    26c7:	ba 0a 00 00 00       	mov    $0xa,%edx
    26cc:	48 89 ce             	mov    %rcx,%rsi
    26cf:	89 c7                	mov    %eax,%edi
    26d1:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    26d8:	00 00 00 
    26db:	ff d0                	call   *%rax
    26dd:	89 45 e8             	mov    %eax,-0x18(%rbp)
    26e0:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
    26e4:	7f a1                	jg     2687 <sharedfd+0x1b8>
    }
  }
  close(fd);
    26e6:	8b 45 f0             	mov    -0x10(%rbp),%eax
    26e9:	89 c7                	mov    %eax,%edi
    26eb:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    26f2:	00 00 00 
    26f5:	ff d0                	call   *%rax
  unlink("sharedfd");
    26f7:	48 b8 82 76 00 00 00 	movabs $0x7682,%rax
    26fe:	00 00 00 
    2701:	48 89 c7             	mov    %rax,%rdi
    2704:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    270b:	00 00 00 
    270e:	ff d0                	call   *%rax
  if(nc == 10000 && np == 10000){
    2710:	81 7d f8 10 27 00 00 	cmpl   $0x2710,-0x8(%rbp)
    2717:	75 2e                	jne    2747 <sharedfd+0x278>
    2719:	81 7d f4 10 27 00 00 	cmpl   $0x2710,-0xc(%rbp)
    2720:	75 25                	jne    2747 <sharedfd+0x278>
    printf(1, "sharedfd ok\n");
    2722:	48 b8 0b 77 00 00 00 	movabs $0x770b,%rax
    2729:	00 00 00 
    272c:	48 89 c6             	mov    %rax,%rsi
    272f:	bf 01 00 00 00       	mov    $0x1,%edi
    2734:	b8 00 00 00 00       	mov    $0x0,%eax
    2739:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2740:	00 00 00 
    2743:	ff d2                	call   *%rdx
    2745:	eb 37                	jmp    277e <sharedfd+0x2af>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    2747:	8b 55 f4             	mov    -0xc(%rbp),%edx
    274a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    274d:	48 be 18 77 00 00 00 	movabs $0x7718,%rsi
    2754:	00 00 00 
    2757:	89 d1                	mov    %edx,%ecx
    2759:	89 c2                	mov    %eax,%edx
    275b:	bf 01 00 00 00       	mov    $0x1,%edi
    2760:	b8 00 00 00 00       	mov    $0x0,%eax
    2765:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    276c:	00 00 00 
    276f:	41 ff d0             	call   *%r8
    exit();
    2772:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2779:	00 00 00 
    277c:	ff d0                	call   *%rax
  }
}
    277e:	c9                   	leave
    277f:	c3                   	ret

0000000000002780 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    2780:	55                   	push   %rbp
    2781:	48 89 e5             	mov    %rsp,%rbp
    2784:	48 83 ec 50          	sub    $0x50,%rsp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    2788:	48 b8 2d 77 00 00 00 	movabs $0x772d,%rax
    278f:	00 00 00 
    2792:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    2796:	48 b8 30 77 00 00 00 	movabs $0x7730,%rax
    279d:	00 00 00 
    27a0:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    27a4:	48 b8 33 77 00 00 00 	movabs $0x7733,%rax
    27ab:	00 00 00 
    27ae:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    27b2:	48 b8 36 77 00 00 00 	movabs $0x7736,%rax
    27b9:	00 00 00 
    27bc:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  char *fname;

  printf(1, "fourfiles test\n");
    27c0:	48 b8 39 77 00 00 00 	movabs $0x7739,%rax
    27c7:	00 00 00 
    27ca:	48 89 c6             	mov    %rax,%rsi
    27cd:	bf 01 00 00 00       	mov    $0x1,%edi
    27d2:	b8 00 00 00 00       	mov    $0x0,%eax
    27d7:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    27de:	00 00 00 
    27e1:	ff d2                	call   *%rdx

  for(pi = 0; pi < 4; pi++){
    27e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    27ea:	e9 3f 01 00 00       	jmp    292e <fourfiles+0x1ae>
    fname = names[pi];
    27ef:	8b 45 f0             	mov    -0x10(%rbp),%eax
    27f2:	48 98                	cltq
    27f4:	48 8b 44 c5 b0       	mov    -0x50(%rbp,%rax,8),%rax
    27f9:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    unlink(fname);
    27fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2801:	48 89 c7             	mov    %rax,%rdi
    2804:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    280b:	00 00 00 
    280e:	ff d0                	call   *%rax

    pid = fork();
    2810:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    2817:	00 00 00 
    281a:	ff d0                	call   *%rax
    281c:	89 45 dc             	mov    %eax,-0x24(%rbp)
    if(pid < 0){
    281f:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    2823:	79 19                	jns    283e <fourfiles+0xbe>
      failexit("fork");
    2825:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    282c:	00 00 00 
    282f:	48 89 c7             	mov    %rax,%rdi
    2832:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2839:	00 00 00 
    283c:	ff d0                	call   *%rax
    }

    if(pid == 0){
    283e:	83 7d dc 00          	cmpl   $0x0,-0x24(%rbp)
    2842:	0f 85 e2 00 00 00    	jne    292a <fourfiles+0x1aa>
      fd = open(fname, O_CREATE | O_RDWR);
    2848:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    284c:	be 02 02 00 00       	mov    $0x202,%esi
    2851:	48 89 c7             	mov    %rax,%rdi
    2854:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    285b:	00 00 00 
    285e:	ff d0                	call   *%rax
    2860:	89 45 e4             	mov    %eax,-0x1c(%rbp)
      if(fd < 0){
    2863:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    2867:	79 19                	jns    2882 <fourfiles+0x102>
        failexit("create");
    2869:	48 b8 49 77 00 00 00 	movabs $0x7749,%rax
    2870:	00 00 00 
    2873:	48 89 c7             	mov    %rax,%rdi
    2876:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    287d:	00 00 00 
    2880:	ff d0                	call   *%rax
      }

      memset(buf, '0'+pi, 512);
    2882:	8b 45 f0             	mov    -0x10(%rbp),%eax
    2885:	8d 48 30             	lea    0x30(%rax),%ecx
    2888:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    288f:	00 00 00 
    2892:	ba 00 02 00 00       	mov    $0x200,%edx
    2897:	89 ce                	mov    %ecx,%esi
    2899:	48 89 c7             	mov    %rax,%rdi
    289c:	48 b8 2f 65 00 00 00 	movabs $0x652f,%rax
    28a3:	00 00 00 
    28a6:	ff d0                	call   *%rax
      for(i = 0; i < 12; i++){
    28a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    28af:	eb 67                	jmp    2918 <fourfiles+0x198>
        if((n = write(fd, buf, 500)) != 500){
    28b1:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    28b8:	00 00 00 
    28bb:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    28be:	ba f4 01 00 00       	mov    $0x1f4,%edx
    28c3:	48 89 ce             	mov    %rcx,%rsi
    28c6:	89 c7                	mov    %eax,%edi
    28c8:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    28cf:	00 00 00 
    28d2:	ff d0                	call   *%rax
    28d4:	89 45 e0             	mov    %eax,-0x20(%rbp)
    28d7:	81 7d e0 f4 01 00 00 	cmpl   $0x1f4,-0x20(%rbp)
    28de:	74 34                	je     2914 <fourfiles+0x194>
          printf(1, "write failed %d\n", n);
    28e0:	8b 45 e0             	mov    -0x20(%rbp),%eax
    28e3:	48 b9 50 77 00 00 00 	movabs $0x7750,%rcx
    28ea:	00 00 00 
    28ed:	89 c2                	mov    %eax,%edx
    28ef:	48 89 ce             	mov    %rcx,%rsi
    28f2:	bf 01 00 00 00       	mov    $0x1,%edi
    28f7:	b8 00 00 00 00       	mov    $0x0,%eax
    28fc:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    2903:	00 00 00 
    2906:	ff d1                	call   *%rcx
          exit();
    2908:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    290f:	00 00 00 
    2912:	ff d0                	call   *%rax
      for(i = 0; i < 12; i++){
    2914:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2918:	83 7d fc 0b          	cmpl   $0xb,-0x4(%rbp)
    291c:	7e 93                	jle    28b1 <fourfiles+0x131>
        }
      }
      exit();
    291e:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2925:	00 00 00 
    2928:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    292a:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    292e:	83 7d f0 03          	cmpl   $0x3,-0x10(%rbp)
    2932:	0f 8e b7 fe ff ff    	jle    27ef <fourfiles+0x6f>
    }
  }

  for(pi = 0; pi < 4; pi++){
    2938:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%rbp)
    293f:	eb 10                	jmp    2951 <fourfiles+0x1d1>
    wait();
    2941:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    2948:	00 00 00 
    294b:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    294d:	83 45 f0 01          	addl   $0x1,-0x10(%rbp)
    2951:	83 7d f0 03          	cmpl   $0x3,-0x10(%rbp)
    2955:	7e ea                	jle    2941 <fourfiles+0x1c1>
  }

  for(i = 0; i < 2; i++){
    2957:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    295e:	e9 17 01 00 00       	jmp    2a7a <fourfiles+0x2fa>
    fname = names[i];
    2963:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2966:	48 98                	cltq
    2968:	48 8b 44 c5 b0       	mov    -0x50(%rbp,%rax,8),%rax
    296d:	48 89 45 e8          	mov    %rax,-0x18(%rbp)
    fd = open(fname, 0);
    2971:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2975:	be 00 00 00 00       	mov    $0x0,%esi
    297a:	48 89 c7             	mov    %rax,%rdi
    297d:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2984:	00 00 00 
    2987:	ff d0                	call   *%rax
    2989:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    total = 0;
    298c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    2993:	eb 54                	jmp    29e9 <fourfiles+0x269>
      for(j = 0; j < n; j++){
    2995:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    299c:	eb 3d                	jmp    29db <fourfiles+0x25b>
        if(buf[j] != '0'+i){
    299e:	48 ba 40 88 00 00 00 	movabs $0x8840,%rdx
    29a5:	00 00 00 
    29a8:	8b 45 f8             	mov    -0x8(%rbp),%eax
    29ab:	48 98                	cltq
    29ad:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    29b1:	0f be d0             	movsbl %al,%edx
    29b4:	8b 45 fc             	mov    -0x4(%rbp),%eax
    29b7:	83 c0 30             	add    $0x30,%eax
    29ba:	39 c2                	cmp    %eax,%edx
    29bc:	74 19                	je     29d7 <fourfiles+0x257>
          failexit("wrong char");
    29be:	48 b8 61 77 00 00 00 	movabs $0x7761,%rax
    29c5:	00 00 00 
    29c8:	48 89 c7             	mov    %rax,%rdi
    29cb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    29d2:	00 00 00 
    29d5:	ff d0                	call   *%rax
      for(j = 0; j < n; j++){
    29d7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    29db:	8b 45 f8             	mov    -0x8(%rbp),%eax
    29de:	3b 45 e0             	cmp    -0x20(%rbp),%eax
    29e1:	7c bb                	jl     299e <fourfiles+0x21e>
        }
      }
      total += n;
    29e3:	8b 45 e0             	mov    -0x20(%rbp),%eax
    29e6:	01 45 f4             	add    %eax,-0xc(%rbp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    29e9:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    29f0:	00 00 00 
    29f3:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    29f6:	ba 00 20 00 00       	mov    $0x2000,%edx
    29fb:	48 89 ce             	mov    %rcx,%rsi
    29fe:	89 c7                	mov    %eax,%edi
    2a00:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    2a07:	00 00 00 
    2a0a:	ff d0                	call   *%rax
    2a0c:	89 45 e0             	mov    %eax,-0x20(%rbp)
    2a0f:	83 7d e0 00          	cmpl   $0x0,-0x20(%rbp)
    2a13:	7f 80                	jg     2995 <fourfiles+0x215>
    }
    close(fd);
    2a15:	8b 45 e4             	mov    -0x1c(%rbp),%eax
    2a18:	89 c7                	mov    %eax,%edi
    2a1a:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2a21:	00 00 00 
    2a24:	ff d0                	call   *%rax
    if(total != 12*500){
    2a26:	81 7d f4 70 17 00 00 	cmpl   $0x1770,-0xc(%rbp)
    2a2d:	74 34                	je     2a63 <fourfiles+0x2e3>
      printf(1, "wrong length %d\n", total);
    2a2f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2a32:	48 b9 6c 77 00 00 00 	movabs $0x776c,%rcx
    2a39:	00 00 00 
    2a3c:	89 c2                	mov    %eax,%edx
    2a3e:	48 89 ce             	mov    %rcx,%rsi
    2a41:	bf 01 00 00 00       	mov    $0x1,%edi
    2a46:	b8 00 00 00 00       	mov    $0x0,%eax
    2a4b:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    2a52:	00 00 00 
    2a55:	ff d1                	call   *%rcx
      exit();
    2a57:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2a5e:	00 00 00 
    2a61:	ff d0                	call   *%rax
    }
    unlink(fname);
    2a63:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    2a67:	48 89 c7             	mov    %rax,%rdi
    2a6a:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    2a71:	00 00 00 
    2a74:	ff d0                	call   *%rax
  for(i = 0; i < 2; i++){
    2a76:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2a7a:	83 7d fc 01          	cmpl   $0x1,-0x4(%rbp)
    2a7e:	0f 8e df fe ff ff    	jle    2963 <fourfiles+0x1e3>
  }

  printf(1, "fourfiles ok\n");
    2a84:	48 b8 7d 77 00 00 00 	movabs $0x777d,%rax
    2a8b:	00 00 00 
    2a8e:	48 89 c6             	mov    %rax,%rsi
    2a91:	bf 01 00 00 00       	mov    $0x1,%edi
    2a96:	b8 00 00 00 00       	mov    $0x0,%eax
    2a9b:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2aa2:	00 00 00 
    2aa5:	ff d2                	call   *%rdx
}
    2aa7:	90                   	nop
    2aa8:	c9                   	leave
    2aa9:	c3                   	ret

0000000000002aaa <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    2aaa:	55                   	push   %rbp
    2aab:	48 89 e5             	mov    %rsp,%rbp
    2aae:	48 83 ec 30          	sub    $0x30,%rsp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    2ab2:	48 b8 8b 77 00 00 00 	movabs $0x778b,%rax
    2ab9:	00 00 00 
    2abc:	48 89 c6             	mov    %rax,%rsi
    2abf:	bf 01 00 00 00       	mov    $0x1,%edi
    2ac4:	b8 00 00 00 00       	mov    $0x0,%eax
    2ac9:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2ad0:	00 00 00 
    2ad3:	ff d2                	call   *%rdx

  for(pi = 0; pi < 4; pi++){
    2ad5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2adc:	e9 15 01 00 00       	jmp    2bf6 <createdelete+0x14c>
    pid = fork();
    2ae1:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    2ae8:	00 00 00 
    2aeb:	ff d0                	call   *%rax
    2aed:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid < 0){
    2af0:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2af4:	79 19                	jns    2b0f <createdelete+0x65>
      failexit("fork");
    2af6:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    2afd:	00 00 00 
    2b00:	48 89 c7             	mov    %rax,%rdi
    2b03:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2b0a:	00 00 00 
    2b0d:	ff d0                	call   *%rax
    }

    if(pid == 0){
    2b0f:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    2b13:	0f 85 d9 00 00 00    	jne    2bf2 <createdelete+0x148>
      name[0] = 'p' + pi;
    2b19:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2b1c:	83 c0 70             	add    $0x70,%eax
    2b1f:	88 45 d0             	mov    %al,-0x30(%rbp)
      name[2] = '\0';
    2b22:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
      for(i = 0; i < N; i++){
    2b26:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2b2d:	e9 aa 00 00 00       	jmp    2bdc <createdelete+0x132>
        name[1] = '0' + i;
    2b32:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b35:	83 c0 30             	add    $0x30,%eax
    2b38:	88 45 d1             	mov    %al,-0x2f(%rbp)
        fd = open(name, O_CREATE | O_RDWR);
    2b3b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2b3f:	be 02 02 00 00       	mov    $0x202,%esi
    2b44:	48 89 c7             	mov    %rax,%rdi
    2b47:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2b4e:	00 00 00 
    2b51:	ff d0                	call   *%rax
    2b53:	89 45 f4             	mov    %eax,-0xc(%rbp)
        if(fd < 0){
    2b56:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2b5a:	79 19                	jns    2b75 <createdelete+0xcb>
          failexit("create");
    2b5c:	48 b8 49 77 00 00 00 	movabs $0x7749,%rax
    2b63:	00 00 00 
    2b66:	48 89 c7             	mov    %rax,%rdi
    2b69:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2b70:	00 00 00 
    2b73:	ff d0                	call   *%rax
        }
        close(fd);
    2b75:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2b78:	89 c7                	mov    %eax,%edi
    2b7a:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2b81:	00 00 00 
    2b84:	ff d0                	call   *%rax
        if(i > 0 && (i % 2 ) == 0){
    2b86:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2b8a:	7e 4c                	jle    2bd8 <createdelete+0x12e>
    2b8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b8f:	83 e0 01             	and    $0x1,%eax
    2b92:	85 c0                	test   %eax,%eax
    2b94:	75 42                	jne    2bd8 <createdelete+0x12e>
          name[1] = '0' + (i / 2);
    2b96:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2b99:	89 c2                	mov    %eax,%edx
    2b9b:	c1 ea 1f             	shr    $0x1f,%edx
    2b9e:	01 d0                	add    %edx,%eax
    2ba0:	d1 f8                	sar    $1,%eax
    2ba2:	83 c0 30             	add    $0x30,%eax
    2ba5:	88 45 d1             	mov    %al,-0x2f(%rbp)
          if(unlink(name) < 0){
    2ba8:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2bac:	48 89 c7             	mov    %rax,%rdi
    2baf:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    2bb6:	00 00 00 
    2bb9:	ff d0                	call   *%rax
    2bbb:	85 c0                	test   %eax,%eax
    2bbd:	79 19                	jns    2bd8 <createdelete+0x12e>
            failexit("unlink");
    2bbf:	48 b8 53 72 00 00 00 	movabs $0x7253,%rax
    2bc6:	00 00 00 
    2bc9:	48 89 c7             	mov    %rax,%rdi
    2bcc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2bd3:	00 00 00 
    2bd6:	ff d0                	call   *%rax
      for(i = 0; i < N; i++){
    2bd8:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2bdc:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2be0:	0f 8e 4c ff ff ff    	jle    2b32 <createdelete+0x88>
          }
        }
      }
      exit();
    2be6:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2bed:	00 00 00 
    2bf0:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    2bf2:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2bf6:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2bfa:	0f 8e e1 fe ff ff    	jle    2ae1 <createdelete+0x37>
    }
  }

  for(pi = 0; pi < 4; pi++){
    2c00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2c07:	eb 10                	jmp    2c19 <createdelete+0x16f>
    wait();
    2c09:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    2c10:	00 00 00 
    2c13:	ff d0                	call   *%rax
  for(pi = 0; pi < 4; pi++){
    2c15:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2c19:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2c1d:	7e ea                	jle    2c09 <createdelete+0x15f>
  }

  name[0] = name[1] = name[2] = 0;
    2c1f:	c6 45 d2 00          	movb   $0x0,-0x2e(%rbp)
    2c23:	0f b6 45 d2          	movzbl -0x2e(%rbp),%eax
    2c27:	88 45 d1             	mov    %al,-0x2f(%rbp)
    2c2a:	0f b6 45 d1          	movzbl -0x2f(%rbp),%eax
    2c2e:	88 45 d0             	mov    %al,-0x30(%rbp)
  for(i = 0; i < N; i++){
    2c31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2c38:	e9 f2 00 00 00       	jmp    2d2f <createdelete+0x285>
    for(pi = 0; pi < 4; pi++){
    2c3d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2c44:	e9 d8 00 00 00       	jmp    2d21 <createdelete+0x277>
      name[0] = 'p' + pi;
    2c49:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2c4c:	83 c0 70             	add    $0x70,%eax
    2c4f:	88 45 d0             	mov    %al,-0x30(%rbp)
      name[1] = '0' + i;
    2c52:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2c55:	83 c0 30             	add    $0x30,%eax
    2c58:	88 45 d1             	mov    %al,-0x2f(%rbp)
      fd = open(name, 0);
    2c5b:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2c5f:	be 00 00 00 00       	mov    $0x0,%esi
    2c64:	48 89 c7             	mov    %rax,%rdi
    2c67:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2c6e:	00 00 00 
    2c71:	ff d0                	call   *%rax
    2c73:	89 45 f4             	mov    %eax,-0xc(%rbp)
      if((i == 0 || i >= N/2) && fd < 0){
    2c76:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2c7a:	74 06                	je     2c82 <createdelete+0x1d8>
    2c7c:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2c80:	7e 3c                	jle    2cbe <createdelete+0x214>
    2c82:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2c86:	79 36                	jns    2cbe <createdelete+0x214>
        printf(1, "oops createdelete %s didn't exist\n", name);
    2c88:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2c8c:	48 b9 a0 77 00 00 00 	movabs $0x77a0,%rcx
    2c93:	00 00 00 
    2c96:	48 89 c2             	mov    %rax,%rdx
    2c99:	48 89 ce             	mov    %rcx,%rsi
    2c9c:	bf 01 00 00 00       	mov    $0x1,%edi
    2ca1:	b8 00 00 00 00       	mov    $0x0,%eax
    2ca6:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    2cad:	00 00 00 
    2cb0:	ff d1                	call   *%rcx
        exit();
    2cb2:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2cb9:	00 00 00 
    2cbc:	ff d0                	call   *%rax
      } else if((i >= 1 && i < N/2) && fd >= 0){
    2cbe:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2cc2:	7e 42                	jle    2d06 <createdelete+0x25c>
    2cc4:	83 7d fc 09          	cmpl   $0x9,-0x4(%rbp)
    2cc8:	7f 3c                	jg     2d06 <createdelete+0x25c>
    2cca:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2cce:	78 36                	js     2d06 <createdelete+0x25c>
        printf(1, "oops createdelete %s did exist\n", name);
    2cd0:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2cd4:	48 b9 c8 77 00 00 00 	movabs $0x77c8,%rcx
    2cdb:	00 00 00 
    2cde:	48 89 c2             	mov    %rax,%rdx
    2ce1:	48 89 ce             	mov    %rcx,%rsi
    2ce4:	bf 01 00 00 00       	mov    $0x1,%edi
    2ce9:	b8 00 00 00 00       	mov    $0x0,%eax
    2cee:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    2cf5:	00 00 00 
    2cf8:	ff d1                	call   *%rcx
        exit();
    2cfa:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    2d01:	00 00 00 
    2d04:	ff d0                	call   *%rax
      }
      if(fd >= 0)
    2d06:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    2d0a:	78 11                	js     2d1d <createdelete+0x273>
        close(fd);
    2d0c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    2d0f:	89 c7                	mov    %eax,%edi
    2d11:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2d18:	00 00 00 
    2d1b:	ff d0                	call   *%rax
    for(pi = 0; pi < 4; pi++){
    2d1d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2d21:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2d25:	0f 8e 1e ff ff ff    	jle    2c49 <createdelete+0x19f>
  for(i = 0; i < N; i++){
    2d2b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2d2f:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2d33:	0f 8e 04 ff ff ff    	jle    2c3d <createdelete+0x193>
    }
  }

  for(i = 0; i < N; i++){
    2d39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    2d40:	eb 3c                	jmp    2d7e <createdelete+0x2d4>
    for(pi = 0; pi < 4; pi++){
    2d42:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    2d49:	eb 29                	jmp    2d74 <createdelete+0x2ca>
      name[0] = 'p' + i;
    2d4b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d4e:	83 c0 70             	add    $0x70,%eax
    2d51:	88 45 d0             	mov    %al,-0x30(%rbp)
      name[1] = '0' + i;
    2d54:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2d57:	83 c0 30             	add    $0x30,%eax
    2d5a:	88 45 d1             	mov    %al,-0x2f(%rbp)
      unlink(name);
    2d5d:	48 8d 45 d0          	lea    -0x30(%rbp),%rax
    2d61:	48 89 c7             	mov    %rax,%rdi
    2d64:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    2d6b:	00 00 00 
    2d6e:	ff d0                	call   *%rax
    for(pi = 0; pi < 4; pi++){
    2d70:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    2d74:	83 7d f8 03          	cmpl   $0x3,-0x8(%rbp)
    2d78:	7e d1                	jle    2d4b <createdelete+0x2a1>
  for(i = 0; i < N; i++){
    2d7a:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    2d7e:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    2d82:	7e be                	jle    2d42 <createdelete+0x298>
    }
  }

  printf(1, "createdelete ok\n");
    2d84:	48 b8 e8 77 00 00 00 	movabs $0x77e8,%rax
    2d8b:	00 00 00 
    2d8e:	48 89 c6             	mov    %rax,%rsi
    2d91:	bf 01 00 00 00       	mov    $0x1,%edi
    2d96:	b8 00 00 00 00       	mov    $0x0,%eax
    2d9b:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2da2:	00 00 00 
    2da5:	ff d2                	call   *%rdx
}
    2da7:	90                   	nop
    2da8:	c9                   	leave
    2da9:	c3                   	ret

0000000000002daa <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    2daa:	55                   	push   %rbp
    2dab:	48 89 e5             	mov    %rsp,%rbp
    2dae:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    2db2:	48 b8 f9 77 00 00 00 	movabs $0x77f9,%rax
    2db9:	00 00 00 
    2dbc:	48 89 c6             	mov    %rax,%rsi
    2dbf:	bf 01 00 00 00       	mov    $0x1,%edi
    2dc4:	b8 00 00 00 00       	mov    $0x0,%eax
    2dc9:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    2dd0:	00 00 00 
    2dd3:	ff d2                	call   *%rdx
  fd = open("unlinkread", O_CREATE | O_RDWR);
    2dd5:	48 b8 0a 78 00 00 00 	movabs $0x780a,%rax
    2ddc:	00 00 00 
    2ddf:	be 02 02 00 00       	mov    $0x202,%esi
    2de4:	48 89 c7             	mov    %rax,%rdi
    2de7:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2dee:	00 00 00 
    2df1:	ff d0                	call   *%rax
    2df3:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2df6:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2dfa:	79 19                	jns    2e15 <unlinkread+0x6b>
    failexit("create unlinkread");
    2dfc:	48 b8 15 78 00 00 00 	movabs $0x7815,%rax
    2e03:	00 00 00 
    2e06:	48 89 c7             	mov    %rax,%rdi
    2e09:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2e10:	00 00 00 
    2e13:	ff d0                	call   *%rax
  }
  write(fd, "hello", 5);
    2e15:	48 b9 27 78 00 00 00 	movabs $0x7827,%rcx
    2e1c:	00 00 00 
    2e1f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2e22:	ba 05 00 00 00       	mov    $0x5,%edx
    2e27:	48 89 ce             	mov    %rcx,%rsi
    2e2a:	89 c7                	mov    %eax,%edi
    2e2c:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    2e33:	00 00 00 
    2e36:	ff d0                	call   *%rax
  close(fd);
    2e38:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2e3b:	89 c7                	mov    %eax,%edi
    2e3d:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2e44:	00 00 00 
    2e47:	ff d0                	call   *%rax

  fd = open("unlinkread", O_RDWR);
    2e49:	48 b8 0a 78 00 00 00 	movabs $0x780a,%rax
    2e50:	00 00 00 
    2e53:	be 02 00 00 00       	mov    $0x2,%esi
    2e58:	48 89 c7             	mov    %rax,%rdi
    2e5b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2e62:	00 00 00 
    2e65:	ff d0                	call   *%rax
    2e67:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    2e6a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    2e6e:	79 19                	jns    2e89 <unlinkread+0xdf>
    failexit("open unlinkread");
    2e70:	48 b8 2d 78 00 00 00 	movabs $0x782d,%rax
    2e77:	00 00 00 
    2e7a:	48 89 c7             	mov    %rax,%rdi
    2e7d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2e84:	00 00 00 
    2e87:	ff d0                	call   *%rax
  }
  if(unlink("unlinkread") != 0){
    2e89:	48 b8 0a 78 00 00 00 	movabs $0x780a,%rax
    2e90:	00 00 00 
    2e93:	48 89 c7             	mov    %rax,%rdi
    2e96:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    2e9d:	00 00 00 
    2ea0:	ff d0                	call   *%rax
    2ea2:	85 c0                	test   %eax,%eax
    2ea4:	74 19                	je     2ebf <unlinkread+0x115>
    failexit("unlink unlinkread");
    2ea6:	48 b8 3d 78 00 00 00 	movabs $0x783d,%rax
    2ead:	00 00 00 
    2eb0:	48 89 c7             	mov    %rax,%rdi
    2eb3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2eba:	00 00 00 
    2ebd:	ff d0                	call   *%rax
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    2ebf:	48 b8 0a 78 00 00 00 	movabs $0x780a,%rax
    2ec6:	00 00 00 
    2ec9:	be 02 02 00 00       	mov    $0x202,%esi
    2ece:	48 89 c7             	mov    %rax,%rdi
    2ed1:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    2ed8:	00 00 00 
    2edb:	ff d0                	call   *%rax
    2edd:	89 45 f8             	mov    %eax,-0x8(%rbp)
  write(fd1, "yyy", 3);
    2ee0:	48 b9 4f 78 00 00 00 	movabs $0x784f,%rcx
    2ee7:	00 00 00 
    2eea:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2eed:	ba 03 00 00 00       	mov    $0x3,%edx
    2ef2:	48 89 ce             	mov    %rcx,%rsi
    2ef5:	89 c7                	mov    %eax,%edi
    2ef7:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    2efe:	00 00 00 
    2f01:	ff d0                	call   *%rax
  close(fd1);
    2f03:	8b 45 f8             	mov    -0x8(%rbp),%eax
    2f06:	89 c7                	mov    %eax,%edi
    2f08:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2f0f:	00 00 00 
    2f12:	ff d0                	call   *%rax

  if(read(fd, buf, sizeof(buf)) != 5){
    2f14:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    2f1b:	00 00 00 
    2f1e:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2f21:	ba 00 20 00 00       	mov    $0x2000,%edx
    2f26:	48 89 ce             	mov    %rcx,%rsi
    2f29:	89 c7                	mov    %eax,%edi
    2f2b:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    2f32:	00 00 00 
    2f35:	ff d0                	call   *%rax
    2f37:	83 f8 05             	cmp    $0x5,%eax
    2f3a:	74 19                	je     2f55 <unlinkread+0x1ab>
    failexit("unlinkread read failed");
    2f3c:	48 b8 53 78 00 00 00 	movabs $0x7853,%rax
    2f43:	00 00 00 
    2f46:	48 89 c7             	mov    %rax,%rdi
    2f49:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2f50:	00 00 00 
    2f53:	ff d0                	call   *%rax
  }
  if(buf[0] != 'h'){
    2f55:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    2f5c:	00 00 00 
    2f5f:	0f b6 00             	movzbl (%rax),%eax
    2f62:	3c 68                	cmp    $0x68,%al
    2f64:	74 19                	je     2f7f <unlinkread+0x1d5>
    failexit("unlinkread wrong data");
    2f66:	48 b8 6a 78 00 00 00 	movabs $0x786a,%rax
    2f6d:	00 00 00 
    2f70:	48 89 c7             	mov    %rax,%rdi
    2f73:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2f7a:	00 00 00 
    2f7d:	ff d0                	call   *%rax
  }
  if(write(fd, buf, 10) != 10){
    2f7f:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    2f86:	00 00 00 
    2f89:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2f8c:	ba 0a 00 00 00       	mov    $0xa,%edx
    2f91:	48 89 ce             	mov    %rcx,%rsi
    2f94:	89 c7                	mov    %eax,%edi
    2f96:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    2f9d:	00 00 00 
    2fa0:	ff d0                	call   *%rax
    2fa2:	83 f8 0a             	cmp    $0xa,%eax
    2fa5:	74 19                	je     2fc0 <unlinkread+0x216>
    failexit("unlinkread write");
    2fa7:	48 b8 80 78 00 00 00 	movabs $0x7880,%rax
    2fae:	00 00 00 
    2fb1:	48 89 c7             	mov    %rax,%rdi
    2fb4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    2fbb:	00 00 00 
    2fbe:	ff d0                	call   *%rax
  }
  close(fd);
    2fc0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    2fc3:	89 c7                	mov    %eax,%edi
    2fc5:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    2fcc:	00 00 00 
    2fcf:	ff d0                	call   *%rax
  unlink("unlinkread");
    2fd1:	48 b8 0a 78 00 00 00 	movabs $0x780a,%rax
    2fd8:	00 00 00 
    2fdb:	48 89 c7             	mov    %rax,%rdi
    2fde:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    2fe5:	00 00 00 
    2fe8:	ff d0                	call   *%rax
  printf(1, "unlinkread ok\n");
    2fea:	48 b8 91 78 00 00 00 	movabs $0x7891,%rax
    2ff1:	00 00 00 
    2ff4:	48 89 c6             	mov    %rax,%rsi
    2ff7:	bf 01 00 00 00       	mov    $0x1,%edi
    2ffc:	b8 00 00 00 00       	mov    $0x0,%eax
    3001:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    3008:	00 00 00 
    300b:	ff d2                	call   *%rdx
}
    300d:	90                   	nop
    300e:	c9                   	leave
    300f:	c3                   	ret

0000000000003010 <linktest>:

void
linktest(void)
{
    3010:	55                   	push   %rbp
    3011:	48 89 e5             	mov    %rsp,%rbp
    3014:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "linktest\n");
    3018:	48 b8 a0 78 00 00 00 	movabs $0x78a0,%rax
    301f:	00 00 00 
    3022:	48 89 c6             	mov    %rax,%rsi
    3025:	bf 01 00 00 00       	mov    $0x1,%edi
    302a:	b8 00 00 00 00       	mov    $0x0,%eax
    302f:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    3036:	00 00 00 
    3039:	ff d2                	call   *%rdx

  unlink("lf1");
    303b:	48 b8 aa 78 00 00 00 	movabs $0x78aa,%rax
    3042:	00 00 00 
    3045:	48 89 c7             	mov    %rax,%rdi
    3048:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    304f:	00 00 00 
    3052:	ff d0                	call   *%rax
  unlink("lf2");
    3054:	48 b8 ae 78 00 00 00 	movabs $0x78ae,%rax
    305b:	00 00 00 
    305e:	48 89 c7             	mov    %rax,%rdi
    3061:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3068:	00 00 00 
    306b:	ff d0                	call   *%rax

  fd = open("lf1", O_CREATE|O_RDWR);
    306d:	48 b8 aa 78 00 00 00 	movabs $0x78aa,%rax
    3074:	00 00 00 
    3077:	be 02 02 00 00       	mov    $0x202,%esi
    307c:	48 89 c7             	mov    %rax,%rdi
    307f:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3086:	00 00 00 
    3089:	ff d0                	call   *%rax
    308b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    308e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3092:	79 19                	jns    30ad <linktest+0x9d>
    failexit("create lf1");
    3094:	48 b8 b2 78 00 00 00 	movabs $0x78b2,%rax
    309b:	00 00 00 
    309e:	48 89 c7             	mov    %rax,%rdi
    30a1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    30a8:	00 00 00 
    30ab:	ff d0                	call   *%rax
  }
  if(write(fd, "hello", 5) != 5){
    30ad:	48 b9 27 78 00 00 00 	movabs $0x7827,%rcx
    30b4:	00 00 00 
    30b7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    30ba:	ba 05 00 00 00       	mov    $0x5,%edx
    30bf:	48 89 ce             	mov    %rcx,%rsi
    30c2:	89 c7                	mov    %eax,%edi
    30c4:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    30cb:	00 00 00 
    30ce:	ff d0                	call   *%rax
    30d0:	83 f8 05             	cmp    $0x5,%eax
    30d3:	74 19                	je     30ee <linktest+0xde>
    failexit("write lf1");
    30d5:	48 b8 bd 78 00 00 00 	movabs $0x78bd,%rax
    30dc:	00 00 00 
    30df:	48 89 c7             	mov    %rax,%rdi
    30e2:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    30e9:	00 00 00 
    30ec:	ff d0                	call   *%rax
  }
  close(fd);
    30ee:	8b 45 fc             	mov    -0x4(%rbp),%eax
    30f1:	89 c7                	mov    %eax,%edi
    30f3:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    30fa:	00 00 00 
    30fd:	ff d0                	call   *%rax

  if(link("lf1", "lf2") < 0){
    30ff:	48 ba ae 78 00 00 00 	movabs $0x78ae,%rdx
    3106:	00 00 00 
    3109:	48 b8 aa 78 00 00 00 	movabs $0x78aa,%rax
    3110:	00 00 00 
    3113:	48 89 d6             	mov    %rdx,%rsi
    3116:	48 89 c7             	mov    %rax,%rdi
    3119:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    3120:	00 00 00 
    3123:	ff d0                	call   *%rax
    3125:	85 c0                	test   %eax,%eax
    3127:	79 19                	jns    3142 <linktest+0x132>
    failexit("link lf1 lf2");
    3129:	48 b8 c7 78 00 00 00 	movabs $0x78c7,%rax
    3130:	00 00 00 
    3133:	48 89 c7             	mov    %rax,%rdi
    3136:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    313d:	00 00 00 
    3140:	ff d0                	call   *%rax
  }
  unlink("lf1");
    3142:	48 b8 aa 78 00 00 00 	movabs $0x78aa,%rax
    3149:	00 00 00 
    314c:	48 89 c7             	mov    %rax,%rdi
    314f:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3156:	00 00 00 
    3159:	ff d0                	call   *%rax

  if(open("lf1", 0) >= 0){
    315b:	48 b8 aa 78 00 00 00 	movabs $0x78aa,%rax
    3162:	00 00 00 
    3165:	be 00 00 00 00       	mov    $0x0,%esi
    316a:	48 89 c7             	mov    %rax,%rdi
    316d:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3174:	00 00 00 
    3177:	ff d0                	call   *%rax
    3179:	85 c0                	test   %eax,%eax
    317b:	78 19                	js     3196 <linktest+0x186>
    failexit("unlinked lf1 but it is still there!");
    317d:	48 b8 d8 78 00 00 00 	movabs $0x78d8,%rax
    3184:	00 00 00 
    3187:	48 89 c7             	mov    %rax,%rdi
    318a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3191:	00 00 00 
    3194:	ff d0                	call   *%rax
  }

  fd = open("lf2", 0);
    3196:	48 b8 ae 78 00 00 00 	movabs $0x78ae,%rax
    319d:	00 00 00 
    31a0:	be 00 00 00 00       	mov    $0x0,%esi
    31a5:	48 89 c7             	mov    %rax,%rdi
    31a8:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    31af:	00 00 00 
    31b2:	ff d0                	call   *%rax
    31b4:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    31b7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    31bb:	79 19                	jns    31d6 <linktest+0x1c6>
    failexit("open lf2");
    31bd:	48 b8 fc 78 00 00 00 	movabs $0x78fc,%rax
    31c4:	00 00 00 
    31c7:	48 89 c7             	mov    %rax,%rdi
    31ca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    31d1:	00 00 00 
    31d4:	ff d0                	call   *%rax
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    31d6:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    31dd:	00 00 00 
    31e0:	8b 45 fc             	mov    -0x4(%rbp),%eax
    31e3:	ba 00 20 00 00       	mov    $0x2000,%edx
    31e8:	48 89 ce             	mov    %rcx,%rsi
    31eb:	89 c7                	mov    %eax,%edi
    31ed:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    31f4:	00 00 00 
    31f7:	ff d0                	call   *%rax
    31f9:	83 f8 05             	cmp    $0x5,%eax
    31fc:	74 19                	je     3217 <linktest+0x207>
    failexit("read lf2");
    31fe:	48 b8 05 79 00 00 00 	movabs $0x7905,%rax
    3205:	00 00 00 
    3208:	48 89 c7             	mov    %rax,%rdi
    320b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3212:	00 00 00 
    3215:	ff d0                	call   *%rax
  }
  close(fd);
    3217:	8b 45 fc             	mov    -0x4(%rbp),%eax
    321a:	89 c7                	mov    %eax,%edi
    321c:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3223:	00 00 00 
    3226:	ff d0                	call   *%rax

  if(link("lf2", "lf2") >= 0){
    3228:	48 ba ae 78 00 00 00 	movabs $0x78ae,%rdx
    322f:	00 00 00 
    3232:	48 b8 ae 78 00 00 00 	movabs $0x78ae,%rax
    3239:	00 00 00 
    323c:	48 89 d6             	mov    %rdx,%rsi
    323f:	48 89 c7             	mov    %rax,%rdi
    3242:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    3249:	00 00 00 
    324c:	ff d0                	call   *%rax
    324e:	85 c0                	test   %eax,%eax
    3250:	78 19                	js     326b <linktest+0x25b>
    failexit("link lf2 lf2 succeeded! oops");
    3252:	48 b8 0e 79 00 00 00 	movabs $0x790e,%rax
    3259:	00 00 00 
    325c:	48 89 c7             	mov    %rax,%rdi
    325f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3266:	00 00 00 
    3269:	ff d0                	call   *%rax
  }

  unlink("lf2");
    326b:	48 b8 ae 78 00 00 00 	movabs $0x78ae,%rax
    3272:	00 00 00 
    3275:	48 89 c7             	mov    %rax,%rdi
    3278:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    327f:	00 00 00 
    3282:	ff d0                	call   *%rax
  if(link("lf2", "lf1") >= 0){
    3284:	48 ba aa 78 00 00 00 	movabs $0x78aa,%rdx
    328b:	00 00 00 
    328e:	48 b8 ae 78 00 00 00 	movabs $0x78ae,%rax
    3295:	00 00 00 
    3298:	48 89 d6             	mov    %rdx,%rsi
    329b:	48 89 c7             	mov    %rax,%rdi
    329e:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    32a5:	00 00 00 
    32a8:	ff d0                	call   *%rax
    32aa:	85 c0                	test   %eax,%eax
    32ac:	78 19                	js     32c7 <linktest+0x2b7>
    failexit("link non-existant succeeded! oops");
    32ae:	48 b8 30 79 00 00 00 	movabs $0x7930,%rax
    32b5:	00 00 00 
    32b8:	48 89 c7             	mov    %rax,%rdi
    32bb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    32c2:	00 00 00 
    32c5:	ff d0                	call   *%rax
  }

  if(link(".", "lf1") >= 0){
    32c7:	48 ba aa 78 00 00 00 	movabs $0x78aa,%rdx
    32ce:	00 00 00 
    32d1:	48 b8 52 79 00 00 00 	movabs $0x7952,%rax
    32d8:	00 00 00 
    32db:	48 89 d6             	mov    %rdx,%rsi
    32de:	48 89 c7             	mov    %rax,%rdi
    32e1:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    32e8:	00 00 00 
    32eb:	ff d0                	call   *%rax
    32ed:	85 c0                	test   %eax,%eax
    32ef:	78 19                	js     330a <linktest+0x2fa>
    failexit("link . lf1 succeeded! oops");
    32f1:	48 b8 54 79 00 00 00 	movabs $0x7954,%rax
    32f8:	00 00 00 
    32fb:	48 89 c7             	mov    %rax,%rdi
    32fe:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3305:	00 00 00 
    3308:	ff d0                	call   *%rax
  }

  printf(1, "linktest ok\n");
    330a:	48 b8 6f 79 00 00 00 	movabs $0x796f,%rax
    3311:	00 00 00 
    3314:	48 89 c6             	mov    %rax,%rsi
    3317:	bf 01 00 00 00       	mov    $0x1,%edi
    331c:	b8 00 00 00 00       	mov    $0x0,%eax
    3321:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    3328:	00 00 00 
    332b:	ff d2                	call   *%rdx
}
    332d:	90                   	nop
    332e:	c9                   	leave
    332f:	c3                   	ret

0000000000003330 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    3330:	55                   	push   %rbp
    3331:	48 89 e5             	mov    %rsp,%rbp
    3334:	48 83 ec 50          	sub    $0x50,%rsp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    3338:	48 b8 7c 79 00 00 00 	movabs $0x797c,%rax
    333f:	00 00 00 
    3342:	48 89 c6             	mov    %rax,%rsi
    3345:	bf 01 00 00 00       	mov    $0x1,%edi
    334a:	b8 00 00 00 00       	mov    $0x0,%eax
    334f:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    3356:	00 00 00 
    3359:	ff d2                	call   *%rdx
  file[0] = 'C';
    335b:	c6 45 ed 43          	movb   $0x43,-0x13(%rbp)
  file[2] = '\0';
    335f:	c6 45 ef 00          	movb   $0x0,-0x11(%rbp)
  for(i = 0; i < 40; i++){
    3363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    336a:	e9 5e 01 00 00       	jmp    34cd <concreate+0x19d>
    file[1] = '0' + i;
    336f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3372:	83 c0 30             	add    $0x30,%eax
    3375:	88 45 ee             	mov    %al,-0x12(%rbp)
    unlink(file);
    3378:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    337c:	48 89 c7             	mov    %rax,%rdi
    337f:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3386:	00 00 00 
    3389:	ff d0                	call   *%rax
    pid = fork();
    338b:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    3392:	00 00 00 
    3395:	ff d0                	call   *%rax
    3397:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid && (i % 3) == 1){
    339a:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    339e:	74 4f                	je     33ef <concreate+0xbf>
    33a0:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    33a3:	48 63 c1             	movslq %ecx,%rax
    33a6:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    33ad:	48 c1 e8 20          	shr    $0x20,%rax
    33b1:	48 89 c2             	mov    %rax,%rdx
    33b4:	89 c8                	mov    %ecx,%eax
    33b6:	c1 f8 1f             	sar    $0x1f,%eax
    33b9:	29 c2                	sub    %eax,%edx
    33bb:	89 d0                	mov    %edx,%eax
    33bd:	01 c0                	add    %eax,%eax
    33bf:	01 d0                	add    %edx,%eax
    33c1:	29 c1                	sub    %eax,%ecx
    33c3:	89 ca                	mov    %ecx,%edx
    33c5:	83 fa 01             	cmp    $0x1,%edx
    33c8:	75 25                	jne    33ef <concreate+0xbf>
      link("C0", file);
    33ca:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    33ce:	48 ba 8c 79 00 00 00 	movabs $0x798c,%rdx
    33d5:	00 00 00 
    33d8:	48 89 c6             	mov    %rax,%rsi
    33db:	48 89 d7             	mov    %rdx,%rdi
    33de:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    33e5:	00 00 00 
    33e8:	ff d0                	call   *%rax
    33ea:	e9 bc 00 00 00       	jmp    34ab <concreate+0x17b>
    } else if(pid == 0 && (i % 5) == 1){
    33ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    33f3:	75 4e                	jne    3443 <concreate+0x113>
    33f5:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    33f8:	48 63 c1             	movslq %ecx,%rax
    33fb:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    3402:	48 c1 e8 20          	shr    $0x20,%rax
    3406:	89 c2                	mov    %eax,%edx
    3408:	d1 fa                	sar    $1,%edx
    340a:	89 c8                	mov    %ecx,%eax
    340c:	c1 f8 1f             	sar    $0x1f,%eax
    340f:	29 c2                	sub    %eax,%edx
    3411:	89 d0                	mov    %edx,%eax
    3413:	c1 e0 02             	shl    $0x2,%eax
    3416:	01 d0                	add    %edx,%eax
    3418:	29 c1                	sub    %eax,%ecx
    341a:	89 ca                	mov    %ecx,%edx
    341c:	83 fa 01             	cmp    $0x1,%edx
    341f:	75 22                	jne    3443 <concreate+0x113>
      link("C0", file);
    3421:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3425:	48 ba 8c 79 00 00 00 	movabs $0x798c,%rdx
    342c:	00 00 00 
    342f:	48 89 c6             	mov    %rax,%rsi
    3432:	48 89 d7             	mov    %rdx,%rdi
    3435:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    343c:	00 00 00 
    343f:	ff d0                	call   *%rax
    3441:	eb 68                	jmp    34ab <concreate+0x17b>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    3443:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3447:	be 02 02 00 00       	mov    $0x202,%esi
    344c:	48 89 c7             	mov    %rax,%rdi
    344f:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3456:	00 00 00 
    3459:	ff d0                	call   *%rax
    345b:	89 45 f4             	mov    %eax,-0xc(%rbp)
      if(fd < 0){
    345e:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    3462:	79 36                	jns    349a <concreate+0x16a>
        printf(1, "concreate create %s failed\n", file);
    3464:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3468:	48 b9 8f 79 00 00 00 	movabs $0x798f,%rcx
    346f:	00 00 00 
    3472:	48 89 c2             	mov    %rax,%rdx
    3475:	48 89 ce             	mov    %rcx,%rsi
    3478:	bf 01 00 00 00       	mov    $0x1,%edi
    347d:	b8 00 00 00 00       	mov    $0x0,%eax
    3482:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    3489:	00 00 00 
    348c:	ff d1                	call   *%rcx
        exit();
    348e:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    3495:	00 00 00 
    3498:	ff d0                	call   *%rax
      }
      close(fd);
    349a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    349d:	89 c7                	mov    %eax,%edi
    349f:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    34a6:	00 00 00 
    34a9:	ff d0                	call   *%rax
    }
    if(pid == 0)
    34ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    34af:	75 0c                	jne    34bd <concreate+0x18d>
      exit();
    34b1:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    34b8:	00 00 00 
    34bb:	ff d0                	call   *%rax
    else
      wait();
    34bd:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    34c4:	00 00 00 
    34c7:	ff d0                	call   *%rax
  for(i = 0; i < 40; i++){
    34c9:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    34cd:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    34d1:	0f 8e 98 fe ff ff    	jle    336f <concreate+0x3f>
  }

  memset(fa, 0, sizeof(fa));
    34d7:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    34db:	ba 28 00 00 00       	mov    $0x28,%edx
    34e0:	be 00 00 00 00       	mov    $0x0,%esi
    34e5:	48 89 c7             	mov    %rax,%rdi
    34e8:	48 b8 2f 65 00 00 00 	movabs $0x652f,%rax
    34ef:	00 00 00 
    34f2:	ff d0                	call   *%rax
  fd = open(".", 0);
    34f4:	48 b8 52 79 00 00 00 	movabs $0x7952,%rax
    34fb:	00 00 00 
    34fe:	be 00 00 00 00       	mov    $0x0,%esi
    3503:	48 89 c7             	mov    %rax,%rdi
    3506:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    350d:	00 00 00 
    3510:	ff d0                	call   *%rax
    3512:	89 45 f4             	mov    %eax,-0xc(%rbp)
  n = 0;
    3515:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  while(read(fd, &de, sizeof(de)) > 0){
    351c:	e9 cd 00 00 00       	jmp    35ee <concreate+0x2be>
    if(de.inum == 0)
    3521:	0f b7 45 b0          	movzwl -0x50(%rbp),%eax
    3525:	66 85 c0             	test   %ax,%ax
    3528:	0f 84 bf 00 00 00    	je     35ed <concreate+0x2bd>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    352e:	0f b6 45 b2          	movzbl -0x4e(%rbp),%eax
    3532:	3c 43                	cmp    $0x43,%al
    3534:	0f 85 b4 00 00 00    	jne    35ee <concreate+0x2be>
    353a:	0f b6 45 b4          	movzbl -0x4c(%rbp),%eax
    353e:	84 c0                	test   %al,%al
    3540:	0f 85 a8 00 00 00    	jne    35ee <concreate+0x2be>
      i = de.name[1] - '0';
    3546:	0f b6 45 b3          	movzbl -0x4d(%rbp),%eax
    354a:	0f be c0             	movsbl %al,%eax
    354d:	83 e8 30             	sub    $0x30,%eax
    3550:	89 45 fc             	mov    %eax,-0x4(%rbp)
      if(i < 0 || i >= sizeof(fa)){
    3553:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3557:	78 08                	js     3561 <concreate+0x231>
    3559:	8b 45 fc             	mov    -0x4(%rbp),%eax
    355c:	83 f8 27             	cmp    $0x27,%eax
    355f:	76 37                	jbe    3598 <concreate+0x268>
        printf(1, "concreate weird file %s\n", de.name);
    3561:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    3565:	48 8d 50 02          	lea    0x2(%rax),%rdx
    3569:	48 b8 ab 79 00 00 00 	movabs $0x79ab,%rax
    3570:	00 00 00 
    3573:	48 89 c6             	mov    %rax,%rsi
    3576:	bf 01 00 00 00       	mov    $0x1,%edi
    357b:	b8 00 00 00 00       	mov    $0x0,%eax
    3580:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    3587:	00 00 00 
    358a:	ff d1                	call   *%rcx
        exit();
    358c:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    3593:	00 00 00 
    3596:	ff d0                	call   *%rax
      }
      if(fa[i]){
    3598:	8b 45 fc             	mov    -0x4(%rbp),%eax
    359b:	48 98                	cltq
    359d:	0f b6 44 05 c0       	movzbl -0x40(%rbp,%rax,1),%eax
    35a2:	84 c0                	test   %al,%al
    35a4:	74 37                	je     35dd <concreate+0x2ad>
        printf(1, "concreate duplicate file %s\n", de.name);
    35a6:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    35aa:	48 8d 50 02          	lea    0x2(%rax),%rdx
    35ae:	48 b8 c4 79 00 00 00 	movabs $0x79c4,%rax
    35b5:	00 00 00 
    35b8:	48 89 c6             	mov    %rax,%rsi
    35bb:	bf 01 00 00 00       	mov    $0x1,%edi
    35c0:	b8 00 00 00 00       	mov    $0x0,%eax
    35c5:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    35cc:	00 00 00 
    35cf:	ff d1                	call   *%rcx
        exit();
    35d1:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    35d8:	00 00 00 
    35db:	ff d0                	call   *%rax
      }
      fa[i] = 1;
    35dd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    35e0:	48 98                	cltq
    35e2:	c6 44 05 c0 01       	movb   $0x1,-0x40(%rbp,%rax,1)
      n++;
    35e7:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    35eb:	eb 01                	jmp    35ee <concreate+0x2be>
      continue;
    35ed:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    35ee:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    35f2:	8b 45 f4             	mov    -0xc(%rbp),%eax
    35f5:	ba 10 00 00 00       	mov    $0x10,%edx
    35fa:	48 89 ce             	mov    %rcx,%rsi
    35fd:	89 c7                	mov    %eax,%edi
    35ff:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    3606:	00 00 00 
    3609:	ff d0                	call   *%rax
    360b:	85 c0                	test   %eax,%eax
    360d:	0f 8f 0e ff ff ff    	jg     3521 <concreate+0x1f1>
    }
  }
  close(fd);
    3613:	8b 45 f4             	mov    -0xc(%rbp),%eax
    3616:	89 c7                	mov    %eax,%edi
    3618:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    361f:	00 00 00 
    3622:	ff d0                	call   *%rax

  if(n != 40){
    3624:	83 7d f8 28          	cmpl   $0x28,-0x8(%rbp)
    3628:	74 19                	je     3643 <concreate+0x313>
    failexit("concreate not enough files in directory listing");
    362a:	48 b8 e8 79 00 00 00 	movabs $0x79e8,%rax
    3631:	00 00 00 
    3634:	48 89 c7             	mov    %rax,%rdi
    3637:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    363e:	00 00 00 
    3641:	ff d0                	call   *%rax
  }

  for(i = 0; i < 40; i++){
    3643:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    364a:	e9 a6 01 00 00       	jmp    37f5 <concreate+0x4c5>
    file[1] = '0' + i;
    364f:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3652:	83 c0 30             	add    $0x30,%eax
    3655:	88 45 ee             	mov    %al,-0x12(%rbp)
    pid = fork();
    3658:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    365f:	00 00 00 
    3662:	ff d0                	call   *%rax
    3664:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(pid < 0){
    3667:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    366b:	79 19                	jns    3686 <concreate+0x356>
      failexit("fork");
    366d:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    3674:	00 00 00 
    3677:	48 89 c7             	mov    %rax,%rdi
    367a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3681:	00 00 00 
    3684:	ff d0                	call   *%rax
    }
    if(((i % 3) == 0 && pid == 0) ||
    3686:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    3689:	48 63 c1             	movslq %ecx,%rax
    368c:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    3693:	48 c1 e8 20          	shr    $0x20,%rax
    3697:	48 89 c2             	mov    %rax,%rdx
    369a:	89 c8                	mov    %ecx,%eax
    369c:	c1 f8 1f             	sar    $0x1f,%eax
    369f:	29 c2                	sub    %eax,%edx
    36a1:	89 d0                	mov    %edx,%eax
    36a3:	01 c0                	add    %eax,%eax
    36a5:	01 d0                	add    %edx,%eax
    36a7:	29 c1                	sub    %eax,%ecx
    36a9:	89 ca                	mov    %ecx,%edx
    36ab:	85 d2                	test   %edx,%edx
    36ad:	75 06                	jne    36b5 <concreate+0x385>
    36af:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    36b3:	74 38                	je     36ed <concreate+0x3bd>
       ((i % 3) == 1 && pid != 0)){
    36b5:	8b 4d fc             	mov    -0x4(%rbp),%ecx
    36b8:	48 63 c1             	movslq %ecx,%rax
    36bb:	48 69 c0 56 55 55 55 	imul   $0x55555556,%rax,%rax
    36c2:	48 c1 e8 20          	shr    $0x20,%rax
    36c6:	48 89 c2             	mov    %rax,%rdx
    36c9:	89 c8                	mov    %ecx,%eax
    36cb:	c1 f8 1f             	sar    $0x1f,%eax
    36ce:	29 c2                	sub    %eax,%edx
    36d0:	89 d0                	mov    %edx,%eax
    36d2:	01 c0                	add    %eax,%eax
    36d4:	01 d0                	add    %edx,%eax
    36d6:	29 c1                	sub    %eax,%ecx
    36d8:	89 ca                	mov    %ecx,%edx
    if(((i % 3) == 0 && pid == 0) ||
    36da:	83 fa 01             	cmp    $0x1,%edx
    36dd:	0f 85 a4 00 00 00    	jne    3787 <concreate+0x457>
       ((i % 3) == 1 && pid != 0)){
    36e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    36e7:	0f 84 9a 00 00 00    	je     3787 <concreate+0x457>
      close(open(file, 0));
    36ed:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    36f1:	be 00 00 00 00       	mov    $0x0,%esi
    36f6:	48 89 c7             	mov    %rax,%rdi
    36f9:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3700:	00 00 00 
    3703:	ff d0                	call   *%rax
    3705:	89 c7                	mov    %eax,%edi
    3707:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    370e:	00 00 00 
    3711:	ff d0                	call   *%rax
      close(open(file, 0));
    3713:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3717:	be 00 00 00 00       	mov    $0x0,%esi
    371c:	48 89 c7             	mov    %rax,%rdi
    371f:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3726:	00 00 00 
    3729:	ff d0                	call   *%rax
    372b:	89 c7                	mov    %eax,%edi
    372d:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3734:	00 00 00 
    3737:	ff d0                	call   *%rax
      close(open(file, 0));
    3739:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    373d:	be 00 00 00 00       	mov    $0x0,%esi
    3742:	48 89 c7             	mov    %rax,%rdi
    3745:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    374c:	00 00 00 
    374f:	ff d0                	call   *%rax
    3751:	89 c7                	mov    %eax,%edi
    3753:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    375a:	00 00 00 
    375d:	ff d0                	call   *%rax
      close(open(file, 0));
    375f:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    3763:	be 00 00 00 00       	mov    $0x0,%esi
    3768:	48 89 c7             	mov    %rax,%rdi
    376b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3772:	00 00 00 
    3775:	ff d0                	call   *%rax
    3777:	89 c7                	mov    %eax,%edi
    3779:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3780:	00 00 00 
    3783:	ff d0                	call   *%rax
    3785:	eb 4c                	jmp    37d3 <concreate+0x4a3>
    } else {
      unlink(file);
    3787:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    378b:	48 89 c7             	mov    %rax,%rdi
    378e:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3795:	00 00 00 
    3798:	ff d0                	call   *%rax
      unlink(file);
    379a:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    379e:	48 89 c7             	mov    %rax,%rdi
    37a1:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    37a8:	00 00 00 
    37ab:	ff d0                	call   *%rax
      unlink(file);
    37ad:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37b1:	48 89 c7             	mov    %rax,%rdi
    37b4:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    37bb:	00 00 00 
    37be:	ff d0                	call   *%rax
      unlink(file);
    37c0:	48 8d 45 ed          	lea    -0x13(%rbp),%rax
    37c4:	48 89 c7             	mov    %rax,%rdi
    37c7:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    37ce:	00 00 00 
    37d1:	ff d0                	call   *%rax
    }
    if(pid == 0)
    37d3:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    37d7:	75 0c                	jne    37e5 <concreate+0x4b5>
      exit();
    37d9:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    37e0:	00 00 00 
    37e3:	ff d0                	call   *%rax
    else
      wait();
    37e5:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    37ec:	00 00 00 
    37ef:	ff d0                	call   *%rax
  for(i = 0; i < 40; i++){
    37f1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    37f5:	83 7d fc 27          	cmpl   $0x27,-0x4(%rbp)
    37f9:	0f 8e 50 fe ff ff    	jle    364f <concreate+0x31f>
  }

  printf(1, "concreate ok\n");
    37ff:	48 b8 18 7a 00 00 00 	movabs $0x7a18,%rax
    3806:	00 00 00 
    3809:	48 89 c6             	mov    %rax,%rsi
    380c:	bf 01 00 00 00       	mov    $0x1,%edi
    3811:	b8 00 00 00 00       	mov    $0x0,%eax
    3816:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    381d:	00 00 00 
    3820:	ff d2                	call   *%rdx
}
    3822:	90                   	nop
    3823:	c9                   	leave
    3824:	c3                   	ret

0000000000003825 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    3825:	55                   	push   %rbp
    3826:	48 89 e5             	mov    %rsp,%rbp
    3829:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, i;

  printf(1, "linkunlink test\n");
    382d:	48 b8 26 7a 00 00 00 	movabs $0x7a26,%rax
    3834:	00 00 00 
    3837:	48 89 c6             	mov    %rax,%rsi
    383a:	bf 01 00 00 00       	mov    $0x1,%edi
    383f:	b8 00 00 00 00       	mov    $0x0,%eax
    3844:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    384b:	00 00 00 
    384e:	ff d2                	call   *%rdx

  unlink("x");
    3850:	48 b8 d6 75 00 00 00 	movabs $0x75d6,%rax
    3857:	00 00 00 
    385a:	48 89 c7             	mov    %rax,%rdi
    385d:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3864:	00 00 00 
    3867:	ff d0                	call   *%rax
  pid = fork();
    3869:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    3870:	00 00 00 
    3873:	ff d0                	call   *%rax
    3875:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(pid < 0){
    3878:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    387c:	79 19                	jns    3897 <linkunlink+0x72>
    failexit("fork");
    387e:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    3885:	00 00 00 
    3888:	48 89 c7             	mov    %rax,%rdi
    388b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3892:	00 00 00 
    3895:	ff d0                	call   *%rax
  }

  unsigned int x = (pid ? 1 : 97);
    3897:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    389b:	74 09                	je     38a6 <linkunlink+0x81>
    389d:	c7 45 f8 01 00 00 00 	movl   $0x1,-0x8(%rbp)
    38a4:	eb 07                	jmp    38ad <linkunlink+0x88>
    38a6:	c7 45 f8 61 00 00 00 	movl   $0x61,-0x8(%rbp)
  for(i = 0; i < 100; i++){
    38ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    38b4:	e9 cd 00 00 00       	jmp    3986 <linkunlink+0x161>
    x = x * 1103515245 + 12345;
    38b9:	8b 45 f8             	mov    -0x8(%rbp),%eax
    38bc:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    38c2:	05 39 30 00 00       	add    $0x3039,%eax
    38c7:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if((x % 3) == 0){
    38ca:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    38cd:	89 ca                	mov    %ecx,%edx
    38cf:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    38d4:	48 0f af c2          	imul   %rdx,%rax
    38d8:	48 c1 e8 20          	shr    $0x20,%rax
    38dc:	89 c2                	mov    %eax,%edx
    38de:	d1 ea                	shr    $1,%edx
    38e0:	89 d0                	mov    %edx,%eax
    38e2:	01 c0                	add    %eax,%eax
    38e4:	01 d0                	add    %edx,%eax
    38e6:	29 c1                	sub    %eax,%ecx
    38e8:	89 ca                	mov    %ecx,%edx
    38ea:	85 d2                	test   %edx,%edx
    38ec:	75 2e                	jne    391c <linkunlink+0xf7>
      close(open("x", O_RDWR | O_CREATE));
    38ee:	48 b8 d6 75 00 00 00 	movabs $0x75d6,%rax
    38f5:	00 00 00 
    38f8:	be 02 02 00 00       	mov    $0x202,%esi
    38fd:	48 89 c7             	mov    %rax,%rdi
    3900:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3907:	00 00 00 
    390a:	ff d0                	call   *%rax
    390c:	89 c7                	mov    %eax,%edi
    390e:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3915:	00 00 00 
    3918:	ff d0                	call   *%rax
    391a:	eb 66                	jmp    3982 <linkunlink+0x15d>
    } else if((x % 3) == 1){
    391c:	8b 4d f8             	mov    -0x8(%rbp),%ecx
    391f:	89 ca                	mov    %ecx,%edx
    3921:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    3926:	48 0f af c2          	imul   %rdx,%rax
    392a:	48 c1 e8 20          	shr    $0x20,%rax
    392e:	89 c2                	mov    %eax,%edx
    3930:	d1 ea                	shr    $1,%edx
    3932:	89 d0                	mov    %edx,%eax
    3934:	01 c0                	add    %eax,%eax
    3936:	01 d0                	add    %edx,%eax
    3938:	29 c1                	sub    %eax,%ecx
    393a:	89 ca                	mov    %ecx,%edx
    393c:	83 fa 01             	cmp    $0x1,%edx
    393f:	75 28                	jne    3969 <linkunlink+0x144>
      link("cat", "x");
    3941:	48 ba d6 75 00 00 00 	movabs $0x75d6,%rdx
    3948:	00 00 00 
    394b:	48 b8 37 7a 00 00 00 	movabs $0x7a37,%rax
    3952:	00 00 00 
    3955:	48 89 d6             	mov    %rdx,%rsi
    3958:	48 89 c7             	mov    %rax,%rdi
    395b:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    3962:	00 00 00 
    3965:	ff d0                	call   *%rax
    3967:	eb 19                	jmp    3982 <linkunlink+0x15d>
    } else {
      unlink("x");
    3969:	48 b8 d6 75 00 00 00 	movabs $0x75d6,%rax
    3970:	00 00 00 
    3973:	48 89 c7             	mov    %rax,%rdi
    3976:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    397d:	00 00 00 
    3980:	ff d0                	call   *%rax
  for(i = 0; i < 100; i++){
    3982:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3986:	83 7d fc 63          	cmpl   $0x63,-0x4(%rbp)
    398a:	0f 8e 29 ff ff ff    	jle    38b9 <linkunlink+0x94>
    }
  }

  if(pid)
    3990:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    3994:	74 0e                	je     39a4 <linkunlink+0x17f>
    wait();
    3996:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    399d:	00 00 00 
    39a0:	ff d0                	call   *%rax
    39a2:	eb 0c                	jmp    39b0 <linkunlink+0x18b>
  else
    exit();
    39a4:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    39ab:	00 00 00 
    39ae:	ff d0                	call   *%rax

  printf(1, "linkunlink ok\n");
    39b0:	48 b8 3b 7a 00 00 00 	movabs $0x7a3b,%rax
    39b7:	00 00 00 
    39ba:	48 89 c6             	mov    %rax,%rsi
    39bd:	bf 01 00 00 00       	mov    $0x1,%edi
    39c2:	b8 00 00 00 00       	mov    $0x0,%eax
    39c7:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    39ce:	00 00 00 
    39d1:	ff d2                	call   *%rdx
}
    39d3:	90                   	nop
    39d4:	c9                   	leave
    39d5:	c3                   	ret

00000000000039d6 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    39d6:	55                   	push   %rbp
    39d7:	48 89 e5             	mov    %rsp,%rbp
    39da:	48 83 ec 20          	sub    $0x20,%rsp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    39de:	48 b8 4a 7a 00 00 00 	movabs $0x7a4a,%rax
    39e5:	00 00 00 
    39e8:	48 89 c6             	mov    %rax,%rsi
    39eb:	bf 01 00 00 00       	mov    $0x1,%edi
    39f0:	b8 00 00 00 00       	mov    $0x0,%eax
    39f5:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    39fc:	00 00 00 
    39ff:	ff d2                	call   *%rdx
  unlink("bd");
    3a01:	48 b8 57 7a 00 00 00 	movabs $0x7a57,%rax
    3a08:	00 00 00 
    3a0b:	48 89 c7             	mov    %rax,%rdi
    3a0e:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3a15:	00 00 00 
    3a18:	ff d0                	call   *%rax

  fd = open("bd", O_CREATE);
    3a1a:	48 b8 57 7a 00 00 00 	movabs $0x7a57,%rax
    3a21:	00 00 00 
    3a24:	be 00 02 00 00       	mov    $0x200,%esi
    3a29:	48 89 c7             	mov    %rax,%rdi
    3a2c:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3a33:	00 00 00 
    3a36:	ff d0                	call   *%rax
    3a38:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(fd < 0){
    3a3b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    3a3f:	79 19                	jns    3a5a <bigdir+0x84>
    failexit("bigdir create");
    3a41:	48 b8 5a 7a 00 00 00 	movabs $0x7a5a,%rax
    3a48:	00 00 00 
    3a4b:	48 89 c7             	mov    %rax,%rdi
    3a4e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3a55:	00 00 00 
    3a58:	ff d0                	call   *%rax
  }
  close(fd);
    3a5a:	8b 45 f8             	mov    -0x8(%rbp),%eax
    3a5d:	89 c7                	mov    %eax,%edi
    3a5f:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3a66:	00 00 00 
    3a69:	ff d0                	call   *%rax

  for(i = 0; i < 500; i++){
    3a6b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3a72:	eb 77                	jmp    3aeb <bigdir+0x115>
    name[0] = 'x';
    3a74:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    3a78:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3a7b:	8d 50 3f             	lea    0x3f(%rax),%edx
    3a7e:	85 c0                	test   %eax,%eax
    3a80:	0f 48 c2             	cmovs  %edx,%eax
    3a83:	c1 f8 06             	sar    $0x6,%eax
    3a86:	83 c0 30             	add    $0x30,%eax
    3a89:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    3a8c:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3a8f:	89 d0                	mov    %edx,%eax
    3a91:	c1 f8 1f             	sar    $0x1f,%eax
    3a94:	c1 e8 1a             	shr    $0x1a,%eax
    3a97:	01 c2                	add    %eax,%edx
    3a99:	83 e2 3f             	and    $0x3f,%edx
    3a9c:	29 c2                	sub    %eax,%edx
    3a9e:	89 d0                	mov    %edx,%eax
    3aa0:	83 c0 30             	add    $0x30,%eax
    3aa3:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    3aa6:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(link("bd", name) != 0){
    3aaa:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    3aae:	48 ba 57 7a 00 00 00 	movabs $0x7a57,%rdx
    3ab5:	00 00 00 
    3ab8:	48 89 c6             	mov    %rax,%rsi
    3abb:	48 89 d7             	mov    %rdx,%rdi
    3abe:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    3ac5:	00 00 00 
    3ac8:	ff d0                	call   *%rax
    3aca:	85 c0                	test   %eax,%eax
    3acc:	74 19                	je     3ae7 <bigdir+0x111>
      failexit("bigdir link");
    3ace:	48 b8 68 7a 00 00 00 	movabs $0x7a68,%rax
    3ad5:	00 00 00 
    3ad8:	48 89 c7             	mov    %rax,%rdi
    3adb:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3ae2:	00 00 00 
    3ae5:	ff d0                	call   *%rax
  for(i = 0; i < 500; i++){
    3ae7:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3aeb:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    3af2:	7e 80                	jle    3a74 <bigdir+0x9e>
    }
  }

  unlink("bd");
    3af4:	48 b8 57 7a 00 00 00 	movabs $0x7a57,%rax
    3afb:	00 00 00 
    3afe:	48 89 c7             	mov    %rax,%rdi
    3b01:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3b08:	00 00 00 
    3b0b:	ff d0                	call   *%rax
  for(i = 0; i < 500; i++){
    3b0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    3b14:	eb 6a                	jmp    3b80 <bigdir+0x1aa>
    name[0] = 'x';
    3b16:	c6 45 ee 78          	movb   $0x78,-0x12(%rbp)
    name[1] = '0' + (i / 64);
    3b1a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3b1d:	8d 50 3f             	lea    0x3f(%rax),%edx
    3b20:	85 c0                	test   %eax,%eax
    3b22:	0f 48 c2             	cmovs  %edx,%eax
    3b25:	c1 f8 06             	sar    $0x6,%eax
    3b28:	83 c0 30             	add    $0x30,%eax
    3b2b:	88 45 ef             	mov    %al,-0x11(%rbp)
    name[2] = '0' + (i % 64);
    3b2e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    3b31:	89 d0                	mov    %edx,%eax
    3b33:	c1 f8 1f             	sar    $0x1f,%eax
    3b36:	c1 e8 1a             	shr    $0x1a,%eax
    3b39:	01 c2                	add    %eax,%edx
    3b3b:	83 e2 3f             	and    $0x3f,%edx
    3b3e:	29 c2                	sub    %eax,%edx
    3b40:	89 d0                	mov    %edx,%eax
    3b42:	83 c0 30             	add    $0x30,%eax
    3b45:	88 45 f0             	mov    %al,-0x10(%rbp)
    name[3] = '\0';
    3b48:	c6 45 f1 00          	movb   $0x0,-0xf(%rbp)
    if(unlink(name) != 0){
    3b4c:	48 8d 45 ee          	lea    -0x12(%rbp),%rax
    3b50:	48 89 c7             	mov    %rax,%rdi
    3b53:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3b5a:	00 00 00 
    3b5d:	ff d0                	call   *%rax
    3b5f:	85 c0                	test   %eax,%eax
    3b61:	74 19                	je     3b7c <bigdir+0x1a6>
      failexit("bigdir unlink failed");
    3b63:	48 b8 74 7a 00 00 00 	movabs $0x7a74,%rax
    3b6a:	00 00 00 
    3b6d:	48 89 c7             	mov    %rax,%rdi
    3b70:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3b77:	00 00 00 
    3b7a:	ff d0                	call   *%rax
  for(i = 0; i < 500; i++){
    3b7c:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    3b80:	81 7d fc f3 01 00 00 	cmpl   $0x1f3,-0x4(%rbp)
    3b87:	7e 8d                	jle    3b16 <bigdir+0x140>
    }
  }

  printf(1, "bigdir ok\n");
    3b89:	48 b8 89 7a 00 00 00 	movabs $0x7a89,%rax
    3b90:	00 00 00 
    3b93:	48 89 c6             	mov    %rax,%rsi
    3b96:	bf 01 00 00 00       	mov    $0x1,%edi
    3b9b:	b8 00 00 00 00       	mov    $0x0,%eax
    3ba0:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    3ba7:	00 00 00 
    3baa:	ff d2                	call   *%rdx
}
    3bac:	90                   	nop
    3bad:	c9                   	leave
    3bae:	c3                   	ret

0000000000003baf <subdir>:

void
subdir(void)
{
    3baf:	55                   	push   %rbp
    3bb0:	48 89 e5             	mov    %rsp,%rbp
    3bb3:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, cc;

  printf(1, "subdir test\n");
    3bb7:	48 b8 94 7a 00 00 00 	movabs $0x7a94,%rax
    3bbe:	00 00 00 
    3bc1:	48 89 c6             	mov    %rax,%rsi
    3bc4:	bf 01 00 00 00       	mov    $0x1,%edi
    3bc9:	b8 00 00 00 00       	mov    $0x0,%eax
    3bce:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    3bd5:	00 00 00 
    3bd8:	ff d2                	call   *%rdx

  unlink("ff");
    3bda:	48 b8 a1 7a 00 00 00 	movabs $0x7aa1,%rax
    3be1:	00 00 00 
    3be4:	48 89 c7             	mov    %rax,%rdi
    3be7:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3bee:	00 00 00 
    3bf1:	ff d0                	call   *%rax
  if(mkdir("dd") != 0){
    3bf3:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    3bfa:	00 00 00 
    3bfd:	48 89 c7             	mov    %rax,%rdi
    3c00:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    3c07:	00 00 00 
    3c0a:	ff d0                	call   *%rax
    3c0c:	85 c0                	test   %eax,%eax
    3c0e:	74 19                	je     3c29 <subdir+0x7a>
    failexit("subdir mkdir dd");
    3c10:	48 b8 a7 7a 00 00 00 	movabs $0x7aa7,%rax
    3c17:	00 00 00 
    3c1a:	48 89 c7             	mov    %rax,%rdi
    3c1d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3c24:	00 00 00 
    3c27:	ff d0                	call   *%rax
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    3c29:	48 b8 b7 7a 00 00 00 	movabs $0x7ab7,%rax
    3c30:	00 00 00 
    3c33:	be 02 02 00 00       	mov    $0x202,%esi
    3c38:	48 89 c7             	mov    %rax,%rdi
    3c3b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3c42:	00 00 00 
    3c45:	ff d0                	call   *%rax
    3c47:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3c4a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3c4e:	79 19                	jns    3c69 <subdir+0xba>
    failexit("create dd/ff");
    3c50:	48 b8 bd 7a 00 00 00 	movabs $0x7abd,%rax
    3c57:	00 00 00 
    3c5a:	48 89 c7             	mov    %rax,%rdi
    3c5d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3c64:	00 00 00 
    3c67:	ff d0                	call   *%rax
  }
  write(fd, "ff", 2);
    3c69:	48 b9 a1 7a 00 00 00 	movabs $0x7aa1,%rcx
    3c70:	00 00 00 
    3c73:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3c76:	ba 02 00 00 00       	mov    $0x2,%edx
    3c7b:	48 89 ce             	mov    %rcx,%rsi
    3c7e:	89 c7                	mov    %eax,%edi
    3c80:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    3c87:	00 00 00 
    3c8a:	ff d0                	call   *%rax
  close(fd);
    3c8c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3c8f:	89 c7                	mov    %eax,%edi
    3c91:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3c98:	00 00 00 
    3c9b:	ff d0                	call   *%rax

  if(unlink("dd") >= 0){
    3c9d:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    3ca4:	00 00 00 
    3ca7:	48 89 c7             	mov    %rax,%rdi
    3caa:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3cb1:	00 00 00 
    3cb4:	ff d0                	call   *%rax
    3cb6:	85 c0                	test   %eax,%eax
    3cb8:	78 19                	js     3cd3 <subdir+0x124>
    failexit("unlink dd (non-empty dir) succeeded!");
    3cba:	48 b8 d0 7a 00 00 00 	movabs $0x7ad0,%rax
    3cc1:	00 00 00 
    3cc4:	48 89 c7             	mov    %rax,%rdi
    3cc7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3cce:	00 00 00 
    3cd1:	ff d0                	call   *%rax
  }

  if(mkdir("/dd/dd") != 0){
    3cd3:	48 b8 f5 7a 00 00 00 	movabs $0x7af5,%rax
    3cda:	00 00 00 
    3cdd:	48 89 c7             	mov    %rax,%rdi
    3ce0:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    3ce7:	00 00 00 
    3cea:	ff d0                	call   *%rax
    3cec:	85 c0                	test   %eax,%eax
    3cee:	74 19                	je     3d09 <subdir+0x15a>
    failexit("subdir mkdir dd/dd");
    3cf0:	48 b8 fc 7a 00 00 00 	movabs $0x7afc,%rax
    3cf7:	00 00 00 
    3cfa:	48 89 c7             	mov    %rax,%rdi
    3cfd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3d04:	00 00 00 
    3d07:	ff d0                	call   *%rax
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    3d09:	48 b8 0f 7b 00 00 00 	movabs $0x7b0f,%rax
    3d10:	00 00 00 
    3d13:	be 02 02 00 00       	mov    $0x202,%esi
    3d18:	48 89 c7             	mov    %rax,%rdi
    3d1b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3d22:	00 00 00 
    3d25:	ff d0                	call   *%rax
    3d27:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3d2a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3d2e:	79 19                	jns    3d49 <subdir+0x19a>
    failexit("create dd/dd/ff");
    3d30:	48 b8 18 7b 00 00 00 	movabs $0x7b18,%rax
    3d37:	00 00 00 
    3d3a:	48 89 c7             	mov    %rax,%rdi
    3d3d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3d44:	00 00 00 
    3d47:	ff d0                	call   *%rax
  }
  write(fd, "FF", 2);
    3d49:	48 b9 28 7b 00 00 00 	movabs $0x7b28,%rcx
    3d50:	00 00 00 
    3d53:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d56:	ba 02 00 00 00       	mov    $0x2,%edx
    3d5b:	48 89 ce             	mov    %rcx,%rsi
    3d5e:	89 c7                	mov    %eax,%edi
    3d60:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    3d67:	00 00 00 
    3d6a:	ff d0                	call   *%rax
  close(fd);
    3d6c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3d6f:	89 c7                	mov    %eax,%edi
    3d71:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3d78:	00 00 00 
    3d7b:	ff d0                	call   *%rax

  fd = open("dd/dd/../ff", 0);
    3d7d:	48 b8 2b 7b 00 00 00 	movabs $0x7b2b,%rax
    3d84:	00 00 00 
    3d87:	be 00 00 00 00       	mov    $0x0,%esi
    3d8c:	48 89 c7             	mov    %rax,%rdi
    3d8f:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3d96:	00 00 00 
    3d99:	ff d0                	call   *%rax
    3d9b:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3d9e:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3da2:	79 19                	jns    3dbd <subdir+0x20e>
    failexit("open dd/dd/../ff");
    3da4:	48 b8 37 7b 00 00 00 	movabs $0x7b37,%rax
    3dab:	00 00 00 
    3dae:	48 89 c7             	mov    %rax,%rdi
    3db1:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3db8:	00 00 00 
    3dbb:	ff d0                	call   *%rax
  }
  cc = read(fd, buf, sizeof(buf));
    3dbd:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    3dc4:	00 00 00 
    3dc7:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3dca:	ba 00 20 00 00       	mov    $0x2000,%edx
    3dcf:	48 89 ce             	mov    %rcx,%rsi
    3dd2:	89 c7                	mov    %eax,%edi
    3dd4:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    3ddb:	00 00 00 
    3dde:	ff d0                	call   *%rax
    3de0:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(cc != 2 || buf[0] != 'f'){
    3de3:	83 7d f8 02          	cmpl   $0x2,-0x8(%rbp)
    3de7:	75 11                	jne    3dfa <subdir+0x24b>
    3de9:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    3df0:	00 00 00 
    3df3:	0f b6 00             	movzbl (%rax),%eax
    3df6:	3c 66                	cmp    $0x66,%al
    3df8:	74 19                	je     3e13 <subdir+0x264>
    failexit("dd/dd/../ff wrong content");
    3dfa:	48 b8 48 7b 00 00 00 	movabs $0x7b48,%rax
    3e01:	00 00 00 
    3e04:	48 89 c7             	mov    %rax,%rdi
    3e07:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e0e:	00 00 00 
    3e11:	ff d0                	call   *%rax
  }
  close(fd);
    3e13:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3e16:	89 c7                	mov    %eax,%edi
    3e18:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    3e1f:	00 00 00 
    3e22:	ff d0                	call   *%rax

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    3e24:	48 ba 62 7b 00 00 00 	movabs $0x7b62,%rdx
    3e2b:	00 00 00 
    3e2e:	48 b8 0f 7b 00 00 00 	movabs $0x7b0f,%rax
    3e35:	00 00 00 
    3e38:	48 89 d6             	mov    %rdx,%rsi
    3e3b:	48 89 c7             	mov    %rax,%rdi
    3e3e:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    3e45:	00 00 00 
    3e48:	ff d0                	call   *%rax
    3e4a:	85 c0                	test   %eax,%eax
    3e4c:	74 19                	je     3e67 <subdir+0x2b8>
    failexit("link dd/dd/ff dd/dd/ffff");
    3e4e:	48 b8 6d 7b 00 00 00 	movabs $0x7b6d,%rax
    3e55:	00 00 00 
    3e58:	48 89 c7             	mov    %rax,%rdi
    3e5b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e62:	00 00 00 
    3e65:	ff d0                	call   *%rax
  }

  if(unlink("dd/dd/ff") != 0){
    3e67:	48 b8 0f 7b 00 00 00 	movabs $0x7b0f,%rax
    3e6e:	00 00 00 
    3e71:	48 89 c7             	mov    %rax,%rdi
    3e74:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    3e7b:	00 00 00 
    3e7e:	ff d0                	call   *%rax
    3e80:	85 c0                	test   %eax,%eax
    3e82:	74 19                	je     3e9d <subdir+0x2ee>
    failexit("unlink dd/dd/ff");
    3e84:	48 b8 86 7b 00 00 00 	movabs $0x7b86,%rax
    3e8b:	00 00 00 
    3e8e:	48 89 c7             	mov    %rax,%rdi
    3e91:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3e98:	00 00 00 
    3e9b:	ff d0                	call   *%rax
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    3e9d:	48 b8 0f 7b 00 00 00 	movabs $0x7b0f,%rax
    3ea4:	00 00 00 
    3ea7:	be 00 00 00 00       	mov    $0x0,%esi
    3eac:	48 89 c7             	mov    %rax,%rdi
    3eaf:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3eb6:	00 00 00 
    3eb9:	ff d0                	call   *%rax
    3ebb:	85 c0                	test   %eax,%eax
    3ebd:	78 19                	js     3ed8 <subdir+0x329>
    failexit("open (unlinked) dd/dd/ff succeeded");
    3ebf:	48 b8 98 7b 00 00 00 	movabs $0x7b98,%rax
    3ec6:	00 00 00 
    3ec9:	48 89 c7             	mov    %rax,%rdi
    3ecc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3ed3:	00 00 00 
    3ed6:	ff d0                	call   *%rax
  }

  if(chdir("dd") != 0){
    3ed8:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    3edf:	00 00 00 
    3ee2:	48 89 c7             	mov    %rax,%rdi
    3ee5:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    3eec:	00 00 00 
    3eef:	ff d0                	call   *%rax
    3ef1:	85 c0                	test   %eax,%eax
    3ef3:	74 19                	je     3f0e <subdir+0x35f>
    failexit("chdir dd");
    3ef5:	48 b8 bb 7b 00 00 00 	movabs $0x7bbb,%rax
    3efc:	00 00 00 
    3eff:	48 89 c7             	mov    %rax,%rdi
    3f02:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f09:	00 00 00 
    3f0c:	ff d0                	call   *%rax
  }
  if(chdir("dd/../../dd") != 0){
    3f0e:	48 b8 c4 7b 00 00 00 	movabs $0x7bc4,%rax
    3f15:	00 00 00 
    3f18:	48 89 c7             	mov    %rax,%rdi
    3f1b:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    3f22:	00 00 00 
    3f25:	ff d0                	call   *%rax
    3f27:	85 c0                	test   %eax,%eax
    3f29:	74 19                	je     3f44 <subdir+0x395>
    failexit("chdir dd/../../dd");
    3f2b:	48 b8 d0 7b 00 00 00 	movabs $0x7bd0,%rax
    3f32:	00 00 00 
    3f35:	48 89 c7             	mov    %rax,%rdi
    3f38:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f3f:	00 00 00 
    3f42:	ff d0                	call   *%rax
  }
  if(chdir("dd/../../../dd") != 0){
    3f44:	48 b8 e2 7b 00 00 00 	movabs $0x7be2,%rax
    3f4b:	00 00 00 
    3f4e:	48 89 c7             	mov    %rax,%rdi
    3f51:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    3f58:	00 00 00 
    3f5b:	ff d0                	call   *%rax
    3f5d:	85 c0                	test   %eax,%eax
    3f5f:	74 19                	je     3f7a <subdir+0x3cb>
    failexit("chdir dd/../../dd");
    3f61:	48 b8 d0 7b 00 00 00 	movabs $0x7bd0,%rax
    3f68:	00 00 00 
    3f6b:	48 89 c7             	mov    %rax,%rdi
    3f6e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3f75:	00 00 00 
    3f78:	ff d0                	call   *%rax
  }
  if(chdir("./..") != 0){
    3f7a:	48 b8 f1 7b 00 00 00 	movabs $0x7bf1,%rax
    3f81:	00 00 00 
    3f84:	48 89 c7             	mov    %rax,%rdi
    3f87:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    3f8e:	00 00 00 
    3f91:	ff d0                	call   *%rax
    3f93:	85 c0                	test   %eax,%eax
    3f95:	74 19                	je     3fb0 <subdir+0x401>
    failexit("chdir ./..");
    3f97:	48 b8 f6 7b 00 00 00 	movabs $0x7bf6,%rax
    3f9e:	00 00 00 
    3fa1:	48 89 c7             	mov    %rax,%rdi
    3fa4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3fab:	00 00 00 
    3fae:	ff d0                	call   *%rax
  }

  fd = open("dd/dd/ffff", 0);
    3fb0:	48 b8 62 7b 00 00 00 	movabs $0x7b62,%rax
    3fb7:	00 00 00 
    3fba:	be 00 00 00 00       	mov    $0x0,%esi
    3fbf:	48 89 c7             	mov    %rax,%rdi
    3fc2:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    3fc9:	00 00 00 
    3fcc:	ff d0                	call   *%rax
    3fce:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    3fd1:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    3fd5:	79 19                	jns    3ff0 <subdir+0x441>
    failexit("open dd/dd/ffff");
    3fd7:	48 b8 01 7c 00 00 00 	movabs $0x7c01,%rax
    3fde:	00 00 00 
    3fe1:	48 89 c7             	mov    %rax,%rdi
    3fe4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    3feb:	00 00 00 
    3fee:	ff d0                	call   *%rax
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    3ff0:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    3ff7:	00 00 00 
    3ffa:	8b 45 fc             	mov    -0x4(%rbp),%eax
    3ffd:	ba 00 20 00 00       	mov    $0x2000,%edx
    4002:	48 89 ce             	mov    %rcx,%rsi
    4005:	89 c7                	mov    %eax,%edi
    4007:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    400e:	00 00 00 
    4011:	ff d0                	call   *%rax
    4013:	83 f8 02             	cmp    $0x2,%eax
    4016:	74 19                	je     4031 <subdir+0x482>
    failexit("read dd/dd/ffff wrong len");
    4018:	48 b8 11 7c 00 00 00 	movabs $0x7c11,%rax
    401f:	00 00 00 
    4022:	48 89 c7             	mov    %rax,%rdi
    4025:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    402c:	00 00 00 
    402f:	ff d0                	call   *%rax
  }
  close(fd);
    4031:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4034:	89 c7                	mov    %eax,%edi
    4036:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    403d:	00 00 00 
    4040:	ff d0                	call   *%rax

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    4042:	48 b8 0f 7b 00 00 00 	movabs $0x7b0f,%rax
    4049:	00 00 00 
    404c:	be 00 00 00 00       	mov    $0x0,%esi
    4051:	48 89 c7             	mov    %rax,%rdi
    4054:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    405b:	00 00 00 
    405e:	ff d0                	call   *%rax
    4060:	85 c0                	test   %eax,%eax
    4062:	78 19                	js     407d <subdir+0x4ce>
    failexit("open (unlinked) dd/dd/ff succeeded");
    4064:	48 b8 98 7b 00 00 00 	movabs $0x7b98,%rax
    406b:	00 00 00 
    406e:	48 89 c7             	mov    %rax,%rdi
    4071:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4078:	00 00 00 
    407b:	ff d0                	call   *%rax
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    407d:	48 b8 2b 7c 00 00 00 	movabs $0x7c2b,%rax
    4084:	00 00 00 
    4087:	be 02 02 00 00       	mov    $0x202,%esi
    408c:	48 89 c7             	mov    %rax,%rdi
    408f:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4096:	00 00 00 
    4099:	ff d0                	call   *%rax
    409b:	85 c0                	test   %eax,%eax
    409d:	78 19                	js     40b8 <subdir+0x509>
    failexit("create dd/ff/ff succeeded");
    409f:	48 b8 34 7c 00 00 00 	movabs $0x7c34,%rax
    40a6:	00 00 00 
    40a9:	48 89 c7             	mov    %rax,%rdi
    40ac:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    40b3:	00 00 00 
    40b6:	ff d0                	call   *%rax
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    40b8:	48 b8 4e 7c 00 00 00 	movabs $0x7c4e,%rax
    40bf:	00 00 00 
    40c2:	be 02 02 00 00       	mov    $0x202,%esi
    40c7:	48 89 c7             	mov    %rax,%rdi
    40ca:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    40d1:	00 00 00 
    40d4:	ff d0                	call   *%rax
    40d6:	85 c0                	test   %eax,%eax
    40d8:	78 19                	js     40f3 <subdir+0x544>
    failexit("create dd/xx/ff succeeded");
    40da:	48 b8 57 7c 00 00 00 	movabs $0x7c57,%rax
    40e1:	00 00 00 
    40e4:	48 89 c7             	mov    %rax,%rdi
    40e7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    40ee:	00 00 00 
    40f1:	ff d0                	call   *%rax
  }
  if(open("dd", O_CREATE) >= 0){
    40f3:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    40fa:	00 00 00 
    40fd:	be 00 02 00 00       	mov    $0x200,%esi
    4102:	48 89 c7             	mov    %rax,%rdi
    4105:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    410c:	00 00 00 
    410f:	ff d0                	call   *%rax
    4111:	85 c0                	test   %eax,%eax
    4113:	78 19                	js     412e <subdir+0x57f>
    failexit("create dd succeeded");
    4115:	48 b8 71 7c 00 00 00 	movabs $0x7c71,%rax
    411c:	00 00 00 
    411f:	48 89 c7             	mov    %rax,%rdi
    4122:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4129:	00 00 00 
    412c:	ff d0                	call   *%rax
  }
  if(open("dd", O_RDWR) >= 0){
    412e:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    4135:	00 00 00 
    4138:	be 02 00 00 00       	mov    $0x2,%esi
    413d:	48 89 c7             	mov    %rax,%rdi
    4140:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4147:	00 00 00 
    414a:	ff d0                	call   *%rax
    414c:	85 c0                	test   %eax,%eax
    414e:	78 19                	js     4169 <subdir+0x5ba>
    failexit("open dd rdwr succeeded");
    4150:	48 b8 85 7c 00 00 00 	movabs $0x7c85,%rax
    4157:	00 00 00 
    415a:	48 89 c7             	mov    %rax,%rdi
    415d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4164:	00 00 00 
    4167:	ff d0                	call   *%rax
  }
  if(open("dd", O_WRONLY) >= 0){
    4169:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    4170:	00 00 00 
    4173:	be 01 00 00 00       	mov    $0x1,%esi
    4178:	48 89 c7             	mov    %rax,%rdi
    417b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4182:	00 00 00 
    4185:	ff d0                	call   *%rax
    4187:	85 c0                	test   %eax,%eax
    4189:	78 19                	js     41a4 <subdir+0x5f5>
    failexit("open dd wronly succeeded");
    418b:	48 b8 9c 7c 00 00 00 	movabs $0x7c9c,%rax
    4192:	00 00 00 
    4195:	48 89 c7             	mov    %rax,%rdi
    4198:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    419f:	00 00 00 
    41a2:	ff d0                	call   *%rax
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    41a4:	48 ba b5 7c 00 00 00 	movabs $0x7cb5,%rdx
    41ab:	00 00 00 
    41ae:	48 b8 2b 7c 00 00 00 	movabs $0x7c2b,%rax
    41b5:	00 00 00 
    41b8:	48 89 d6             	mov    %rdx,%rsi
    41bb:	48 89 c7             	mov    %rax,%rdi
    41be:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    41c5:	00 00 00 
    41c8:	ff d0                	call   *%rax
    41ca:	85 c0                	test   %eax,%eax
    41cc:	75 19                	jne    41e7 <subdir+0x638>
    failexit("link dd/ff/ff dd/dd/xx succeeded");
    41ce:	48 b8 c0 7c 00 00 00 	movabs $0x7cc0,%rax
    41d5:	00 00 00 
    41d8:	48 89 c7             	mov    %rax,%rdi
    41db:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    41e2:	00 00 00 
    41e5:	ff d0                	call   *%rax
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    41e7:	48 ba b5 7c 00 00 00 	movabs $0x7cb5,%rdx
    41ee:	00 00 00 
    41f1:	48 b8 4e 7c 00 00 00 	movabs $0x7c4e,%rax
    41f8:	00 00 00 
    41fb:	48 89 d6             	mov    %rdx,%rsi
    41fe:	48 89 c7             	mov    %rax,%rdi
    4201:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    4208:	00 00 00 
    420b:	ff d0                	call   *%rax
    420d:	85 c0                	test   %eax,%eax
    420f:	75 19                	jne    422a <subdir+0x67b>
    failexit("link dd/xx/ff dd/dd/xx succeededn");
    4211:	48 b8 e8 7c 00 00 00 	movabs $0x7ce8,%rax
    4218:	00 00 00 
    421b:	48 89 c7             	mov    %rax,%rdi
    421e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4225:	00 00 00 
    4228:	ff d0                	call   *%rax
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    422a:	48 ba 62 7b 00 00 00 	movabs $0x7b62,%rdx
    4231:	00 00 00 
    4234:	48 b8 b7 7a 00 00 00 	movabs $0x7ab7,%rax
    423b:	00 00 00 
    423e:	48 89 d6             	mov    %rdx,%rsi
    4241:	48 89 c7             	mov    %rax,%rdi
    4244:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    424b:	00 00 00 
    424e:	ff d0                	call   *%rax
    4250:	85 c0                	test   %eax,%eax
    4252:	75 19                	jne    426d <subdir+0x6be>
    failexit("link dd/ff dd/dd/ffff succeeded");
    4254:	48 b8 10 7d 00 00 00 	movabs $0x7d10,%rax
    425b:	00 00 00 
    425e:	48 89 c7             	mov    %rax,%rdi
    4261:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4268:	00 00 00 
    426b:	ff d0                	call   *%rax
  }
  if(mkdir("dd/ff/ff") == 0){
    426d:	48 b8 2b 7c 00 00 00 	movabs $0x7c2b,%rax
    4274:	00 00 00 
    4277:	48 89 c7             	mov    %rax,%rdi
    427a:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    4281:	00 00 00 
    4284:	ff d0                	call   *%rax
    4286:	85 c0                	test   %eax,%eax
    4288:	75 19                	jne    42a3 <subdir+0x6f4>
    failexit("mkdir dd/ff/ff succeeded");
    428a:	48 b8 30 7d 00 00 00 	movabs $0x7d30,%rax
    4291:	00 00 00 
    4294:	48 89 c7             	mov    %rax,%rdi
    4297:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    429e:	00 00 00 
    42a1:	ff d0                	call   *%rax
  }
  if(mkdir("dd/xx/ff") == 0){
    42a3:	48 b8 4e 7c 00 00 00 	movabs $0x7c4e,%rax
    42aa:	00 00 00 
    42ad:	48 89 c7             	mov    %rax,%rdi
    42b0:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    42b7:	00 00 00 
    42ba:	ff d0                	call   *%rax
    42bc:	85 c0                	test   %eax,%eax
    42be:	75 19                	jne    42d9 <subdir+0x72a>
    failexit("mkdir dd/xx/ff succeeded");
    42c0:	48 b8 49 7d 00 00 00 	movabs $0x7d49,%rax
    42c7:	00 00 00 
    42ca:	48 89 c7             	mov    %rax,%rdi
    42cd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    42d4:	00 00 00 
    42d7:	ff d0                	call   *%rax
  }
  if(mkdir("dd/dd/ffff") == 0){
    42d9:	48 b8 62 7b 00 00 00 	movabs $0x7b62,%rax
    42e0:	00 00 00 
    42e3:	48 89 c7             	mov    %rax,%rdi
    42e6:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    42ed:	00 00 00 
    42f0:	ff d0                	call   *%rax
    42f2:	85 c0                	test   %eax,%eax
    42f4:	75 19                	jne    430f <subdir+0x760>
    failexit("mkdir dd/dd/ffff succeeded");
    42f6:	48 b8 62 7d 00 00 00 	movabs $0x7d62,%rax
    42fd:	00 00 00 
    4300:	48 89 c7             	mov    %rax,%rdi
    4303:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    430a:	00 00 00 
    430d:	ff d0                	call   *%rax
  }
  if(unlink("dd/xx/ff") == 0){
    430f:	48 b8 4e 7c 00 00 00 	movabs $0x7c4e,%rax
    4316:	00 00 00 
    4319:	48 89 c7             	mov    %rax,%rdi
    431c:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4323:	00 00 00 
    4326:	ff d0                	call   *%rax
    4328:	85 c0                	test   %eax,%eax
    432a:	75 19                	jne    4345 <subdir+0x796>
    failexit("unlink dd/xx/ff succeeded");
    432c:	48 b8 7d 7d 00 00 00 	movabs $0x7d7d,%rax
    4333:	00 00 00 
    4336:	48 89 c7             	mov    %rax,%rdi
    4339:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4340:	00 00 00 
    4343:	ff d0                	call   *%rax
  }
  if(unlink("dd/ff/ff") == 0){
    4345:	48 b8 2b 7c 00 00 00 	movabs $0x7c2b,%rax
    434c:	00 00 00 
    434f:	48 89 c7             	mov    %rax,%rdi
    4352:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4359:	00 00 00 
    435c:	ff d0                	call   *%rax
    435e:	85 c0                	test   %eax,%eax
    4360:	75 19                	jne    437b <subdir+0x7cc>
    failexit("unlink dd/ff/ff succeeded");
    4362:	48 b8 97 7d 00 00 00 	movabs $0x7d97,%rax
    4369:	00 00 00 
    436c:	48 89 c7             	mov    %rax,%rdi
    436f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4376:	00 00 00 
    4379:	ff d0                	call   *%rax
  }
  if(chdir("dd/ff") == 0){
    437b:	48 b8 b7 7a 00 00 00 	movabs $0x7ab7,%rax
    4382:	00 00 00 
    4385:	48 89 c7             	mov    %rax,%rdi
    4388:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    438f:	00 00 00 
    4392:	ff d0                	call   *%rax
    4394:	85 c0                	test   %eax,%eax
    4396:	75 19                	jne    43b1 <subdir+0x802>
    failexit("chdir dd/ff succeeded");
    4398:	48 b8 b1 7d 00 00 00 	movabs $0x7db1,%rax
    439f:	00 00 00 
    43a2:	48 89 c7             	mov    %rax,%rdi
    43a5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    43ac:	00 00 00 
    43af:	ff d0                	call   *%rax
  }
  if(chdir("dd/xx") == 0){
    43b1:	48 b8 c7 7d 00 00 00 	movabs $0x7dc7,%rax
    43b8:	00 00 00 
    43bb:	48 89 c7             	mov    %rax,%rdi
    43be:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    43c5:	00 00 00 
    43c8:	ff d0                	call   *%rax
    43ca:	85 c0                	test   %eax,%eax
    43cc:	75 19                	jne    43e7 <subdir+0x838>
    failexit("chdir dd/xx succeeded");
    43ce:	48 b8 cd 7d 00 00 00 	movabs $0x7dcd,%rax
    43d5:	00 00 00 
    43d8:	48 89 c7             	mov    %rax,%rdi
    43db:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    43e2:	00 00 00 
    43e5:	ff d0                	call   *%rax
  }

  if(unlink("dd/dd/ffff") != 0){
    43e7:	48 b8 62 7b 00 00 00 	movabs $0x7b62,%rax
    43ee:	00 00 00 
    43f1:	48 89 c7             	mov    %rax,%rdi
    43f4:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    43fb:	00 00 00 
    43fe:	ff d0                	call   *%rax
    4400:	85 c0                	test   %eax,%eax
    4402:	74 19                	je     441d <subdir+0x86e>
    failexit("unlink dd/dd/ff");
    4404:	48 b8 86 7b 00 00 00 	movabs $0x7b86,%rax
    440b:	00 00 00 
    440e:	48 89 c7             	mov    %rax,%rdi
    4411:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4418:	00 00 00 
    441b:	ff d0                	call   *%rax
  }
  if(unlink("dd/ff") != 0){
    441d:	48 b8 b7 7a 00 00 00 	movabs $0x7ab7,%rax
    4424:	00 00 00 
    4427:	48 89 c7             	mov    %rax,%rdi
    442a:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4431:	00 00 00 
    4434:	ff d0                	call   *%rax
    4436:	85 c0                	test   %eax,%eax
    4438:	74 19                	je     4453 <subdir+0x8a4>
    failexit("unlink dd/ff");
    443a:	48 b8 e3 7d 00 00 00 	movabs $0x7de3,%rax
    4441:	00 00 00 
    4444:	48 89 c7             	mov    %rax,%rdi
    4447:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    444e:	00 00 00 
    4451:	ff d0                	call   *%rax
  }
  if(unlink("dd") == 0){
    4453:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    445a:	00 00 00 
    445d:	48 89 c7             	mov    %rax,%rdi
    4460:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4467:	00 00 00 
    446a:	ff d0                	call   *%rax
    446c:	85 c0                	test   %eax,%eax
    446e:	75 19                	jne    4489 <subdir+0x8da>
    failexit("unlink non-empty dd succeeded");
    4470:	48 b8 f0 7d 00 00 00 	movabs $0x7df0,%rax
    4477:	00 00 00 
    447a:	48 89 c7             	mov    %rax,%rdi
    447d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4484:	00 00 00 
    4487:	ff d0                	call   *%rax
  }
  if(unlink("dd/dd") < 0){
    4489:	48 b8 0e 7e 00 00 00 	movabs $0x7e0e,%rax
    4490:	00 00 00 
    4493:	48 89 c7             	mov    %rax,%rdi
    4496:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    449d:	00 00 00 
    44a0:	ff d0                	call   *%rax
    44a2:	85 c0                	test   %eax,%eax
    44a4:	79 19                	jns    44bf <subdir+0x910>
    failexit("unlink dd/dd");
    44a6:	48 b8 14 7e 00 00 00 	movabs $0x7e14,%rax
    44ad:	00 00 00 
    44b0:	48 89 c7             	mov    %rax,%rdi
    44b3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    44ba:	00 00 00 
    44bd:	ff d0                	call   *%rax
  }
  if(unlink("dd") < 0){
    44bf:	48 b8 a4 7a 00 00 00 	movabs $0x7aa4,%rax
    44c6:	00 00 00 
    44c9:	48 89 c7             	mov    %rax,%rdi
    44cc:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    44d3:	00 00 00 
    44d6:	ff d0                	call   *%rax
    44d8:	85 c0                	test   %eax,%eax
    44da:	79 19                	jns    44f5 <subdir+0x946>
    failexit("unlink dd");
    44dc:	48 b8 21 7e 00 00 00 	movabs $0x7e21,%rax
    44e3:	00 00 00 
    44e6:	48 89 c7             	mov    %rax,%rdi
    44e9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    44f0:	00 00 00 
    44f3:	ff d0                	call   *%rax
  }

  printf(1, "subdir ok\n");
    44f5:	48 b8 2b 7e 00 00 00 	movabs $0x7e2b,%rax
    44fc:	00 00 00 
    44ff:	48 89 c6             	mov    %rax,%rsi
    4502:	bf 01 00 00 00       	mov    $0x1,%edi
    4507:	b8 00 00 00 00       	mov    $0x0,%eax
    450c:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4513:	00 00 00 
    4516:	ff d2                	call   *%rdx
}
    4518:	90                   	nop
    4519:	c9                   	leave
    451a:	c3                   	ret

000000000000451b <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    451b:	55                   	push   %rbp
    451c:	48 89 e5             	mov    %rsp,%rbp
    451f:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, sz;

  printf(1, "bigwrite test\n");
    4523:	48 b8 36 7e 00 00 00 	movabs $0x7e36,%rax
    452a:	00 00 00 
    452d:	48 89 c6             	mov    %rax,%rsi
    4530:	bf 01 00 00 00       	mov    $0x1,%edi
    4535:	b8 00 00 00 00       	mov    $0x0,%eax
    453a:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4541:	00 00 00 
    4544:	ff d2                	call   *%rdx

  unlink("bigwrite");
    4546:	48 b8 45 7e 00 00 00 	movabs $0x7e45,%rax
    454d:	00 00 00 
    4550:	48 89 c7             	mov    %rax,%rdi
    4553:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    455a:	00 00 00 
    455d:	ff d0                	call   *%rax
  for(sz = 499; sz < 12*512; sz += 471){
    455f:	c7 45 fc f3 01 00 00 	movl   $0x1f3,-0x4(%rbp)
    4566:	e9 e7 00 00 00       	jmp    4652 <bigwrite+0x137>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    456b:	48 b8 45 7e 00 00 00 	movabs $0x7e45,%rax
    4572:	00 00 00 
    4575:	be 02 02 00 00       	mov    $0x202,%esi
    457a:	48 89 c7             	mov    %rax,%rdi
    457d:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4584:	00 00 00 
    4587:	ff d0                	call   *%rax
    4589:	89 45 f4             	mov    %eax,-0xc(%rbp)
    if(fd < 0){
    458c:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    4590:	79 19                	jns    45ab <bigwrite+0x90>
      failexit("cannot create bigwrite");
    4592:	48 b8 4e 7e 00 00 00 	movabs $0x7e4e,%rax
    4599:	00 00 00 
    459c:	48 89 c7             	mov    %rax,%rdi
    459f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    45a6:	00 00 00 
    45a9:	ff d0                	call   *%rax
    }
    int i;
    for(i = 0; i < 2; i++){
    45ab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
    45b2:	eb 67                	jmp    461b <bigwrite+0x100>
      int cc = write(fd, buf, sz);
    45b4:	8b 55 fc             	mov    -0x4(%rbp),%edx
    45b7:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    45be:	00 00 00 
    45c1:	8b 45 f4             	mov    -0xc(%rbp),%eax
    45c4:	48 89 ce             	mov    %rcx,%rsi
    45c7:	89 c7                	mov    %eax,%edi
    45c9:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    45d0:	00 00 00 
    45d3:	ff d0                	call   *%rax
    45d5:	89 45 f0             	mov    %eax,-0x10(%rbp)
      if(cc != sz){
    45d8:	8b 45 f0             	mov    -0x10(%rbp),%eax
    45db:	3b 45 fc             	cmp    -0x4(%rbp),%eax
    45de:	74 37                	je     4617 <bigwrite+0xfc>
        printf(1, "write(%d) ret %d\n", sz, cc);
    45e0:	8b 55 f0             	mov    -0x10(%rbp),%edx
    45e3:	8b 45 fc             	mov    -0x4(%rbp),%eax
    45e6:	48 be 65 7e 00 00 00 	movabs $0x7e65,%rsi
    45ed:	00 00 00 
    45f0:	89 d1                	mov    %edx,%ecx
    45f2:	89 c2                	mov    %eax,%edx
    45f4:	bf 01 00 00 00       	mov    $0x1,%edi
    45f9:	b8 00 00 00 00       	mov    $0x0,%eax
    45fe:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    4605:	00 00 00 
    4608:	41 ff d0             	call   *%r8
        exit();
    460b:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    4612:	00 00 00 
    4615:	ff d0                	call   *%rax
    for(i = 0; i < 2; i++){
    4617:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    461b:	83 7d f8 01          	cmpl   $0x1,-0x8(%rbp)
    461f:	7e 93                	jle    45b4 <bigwrite+0x99>
      }
    }
    close(fd);
    4621:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4624:	89 c7                	mov    %eax,%edi
    4626:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    462d:	00 00 00 
    4630:	ff d0                	call   *%rax
    unlink("bigwrite");
    4632:	48 b8 45 7e 00 00 00 	movabs $0x7e45,%rax
    4639:	00 00 00 
    463c:	48 89 c7             	mov    %rax,%rdi
    463f:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4646:	00 00 00 
    4649:	ff d0                	call   *%rax
  for(sz = 499; sz < 12*512; sz += 471){
    464b:	81 45 fc d7 01 00 00 	addl   $0x1d7,-0x4(%rbp)
    4652:	81 7d fc ff 17 00 00 	cmpl   $0x17ff,-0x4(%rbp)
    4659:	0f 8e 0c ff ff ff    	jle    456b <bigwrite+0x50>
  }

  printf(1, "bigwrite ok\n");
    465f:	48 b8 77 7e 00 00 00 	movabs $0x7e77,%rax
    4666:	00 00 00 
    4669:	48 89 c6             	mov    %rax,%rsi
    466c:	bf 01 00 00 00       	mov    $0x1,%edi
    4671:	b8 00 00 00 00       	mov    $0x0,%eax
    4676:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    467d:	00 00 00 
    4680:	ff d2                	call   *%rdx
}
    4682:	90                   	nop
    4683:	c9                   	leave
    4684:	c3                   	ret

0000000000004685 <bigfile>:

void
bigfile(void)
{
    4685:	55                   	push   %rbp
    4686:	48 89 e5             	mov    %rsp,%rbp
    4689:	48 83 ec 10          	sub    $0x10,%rsp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    468d:	48 b8 84 7e 00 00 00 	movabs $0x7e84,%rax
    4694:	00 00 00 
    4697:	48 89 c6             	mov    %rax,%rsi
    469a:	bf 01 00 00 00       	mov    $0x1,%edi
    469f:	b8 00 00 00 00       	mov    $0x0,%eax
    46a4:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    46ab:	00 00 00 
    46ae:	ff d2                	call   *%rdx

  unlink("bigfile");
    46b0:	48 b8 92 7e 00 00 00 	movabs $0x7e92,%rax
    46b7:	00 00 00 
    46ba:	48 89 c7             	mov    %rax,%rdi
    46bd:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    46c4:	00 00 00 
    46c7:	ff d0                	call   *%rax
  fd = open("bigfile", O_CREATE | O_RDWR);
    46c9:	48 b8 92 7e 00 00 00 	movabs $0x7e92,%rax
    46d0:	00 00 00 
    46d3:	be 02 02 00 00       	mov    $0x202,%esi
    46d8:	48 89 c7             	mov    %rax,%rdi
    46db:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    46e2:	00 00 00 
    46e5:	ff d0                	call   *%rax
    46e7:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    46ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    46ee:	79 19                	jns    4709 <bigfile+0x84>
    failexit("cannot create bigfile");
    46f0:	48 b8 9a 7e 00 00 00 	movabs $0x7e9a,%rax
    46f7:	00 00 00 
    46fa:	48 89 c7             	mov    %rax,%rdi
    46fd:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4704:	00 00 00 
    4707:	ff d0                	call   *%rax
  }
  for(i = 0; i < 20; i++){
    4709:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    4710:	eb 6a                	jmp    477c <bigfile+0xf7>
    memset(buf, i, 600);
    4712:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4715:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    471c:	00 00 00 
    471f:	ba 58 02 00 00       	mov    $0x258,%edx
    4724:	89 c6                	mov    %eax,%esi
    4726:	48 89 cf             	mov    %rcx,%rdi
    4729:	48 b8 2f 65 00 00 00 	movabs $0x652f,%rax
    4730:	00 00 00 
    4733:	ff d0                	call   *%rax
    if(write(fd, buf, 600) != 600){
    4735:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    473c:	00 00 00 
    473f:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4742:	ba 58 02 00 00       	mov    $0x258,%edx
    4747:	48 89 ce             	mov    %rcx,%rsi
    474a:	89 c7                	mov    %eax,%edi
    474c:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    4753:	00 00 00 
    4756:	ff d0                	call   *%rax
    4758:	3d 58 02 00 00       	cmp    $0x258,%eax
    475d:	74 19                	je     4778 <bigfile+0xf3>
      failexit("write bigfile");
    475f:	48 b8 b0 7e 00 00 00 	movabs $0x7eb0,%rax
    4766:	00 00 00 
    4769:	48 89 c7             	mov    %rax,%rdi
    476c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4773:	00 00 00 
    4776:	ff d0                	call   *%rax
  for(i = 0; i < 20; i++){
    4778:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    477c:	83 7d fc 13          	cmpl   $0x13,-0x4(%rbp)
    4780:	7e 90                	jle    4712 <bigfile+0x8d>
    }
  }
  close(fd);
    4782:	8b 45 f4             	mov    -0xc(%rbp),%eax
    4785:	89 c7                	mov    %eax,%edi
    4787:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    478e:	00 00 00 
    4791:	ff d0                	call   *%rax

  fd = open("bigfile", 0);
    4793:	48 b8 92 7e 00 00 00 	movabs $0x7e92,%rax
    479a:	00 00 00 
    479d:	be 00 00 00 00       	mov    $0x0,%esi
    47a2:	48 89 c7             	mov    %rax,%rdi
    47a5:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    47ac:	00 00 00 
    47af:	ff d0                	call   *%rax
    47b1:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    47b4:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    47b8:	79 19                	jns    47d3 <bigfile+0x14e>
    failexit("cannot open bigfile");
    47ba:	48 b8 be 7e 00 00 00 	movabs $0x7ebe,%rax
    47c1:	00 00 00 
    47c4:	48 89 c7             	mov    %rax,%rdi
    47c7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    47ce:	00 00 00 
    47d1:	ff d0                	call   *%rax
  }
  total = 0;
    47d3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)
  for(i = 0; ; i++){
    47da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    cc = read(fd, buf, 300);
    47e1:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    47e8:	00 00 00 
    47eb:	8b 45 f4             	mov    -0xc(%rbp),%eax
    47ee:	ba 2c 01 00 00       	mov    $0x12c,%edx
    47f3:	48 89 ce             	mov    %rcx,%rsi
    47f6:	89 c7                	mov    %eax,%edi
    47f8:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    47ff:	00 00 00 
    4802:	ff d0                	call   *%rax
    4804:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(cc < 0){
    4807:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    480b:	79 19                	jns    4826 <bigfile+0x1a1>
      failexit("read bigfile");
    480d:	48 b8 d2 7e 00 00 00 	movabs $0x7ed2,%rax
    4814:	00 00 00 
    4817:	48 89 c7             	mov    %rax,%rdi
    481a:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4821:	00 00 00 
    4824:	ff d0                	call   *%rax
    }
    if(cc == 0)
    4826:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    482a:	0f 84 8e 00 00 00    	je     48be <bigfile+0x239>
      break;
    if(cc != 300){
    4830:	81 7d f0 2c 01 00 00 	cmpl   $0x12c,-0x10(%rbp)
    4837:	74 19                	je     4852 <bigfile+0x1cd>
      failexit("short read bigfile");
    4839:	48 b8 df 7e 00 00 00 	movabs $0x7edf,%rax
    4840:	00 00 00 
    4843:	48 89 c7             	mov    %rax,%rdi
    4846:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    484d:	00 00 00 
    4850:	ff d0                	call   *%rax
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    4852:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    4859:	00 00 00 
    485c:	0f b6 00             	movzbl (%rax),%eax
    485f:	0f be d0             	movsbl %al,%edx
    4862:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4865:	89 c1                	mov    %eax,%ecx
    4867:	c1 e9 1f             	shr    $0x1f,%ecx
    486a:	01 c8                	add    %ecx,%eax
    486c:	d1 f8                	sar    $1,%eax
    486e:	39 c2                	cmp    %eax,%edx
    4870:	75 24                	jne    4896 <bigfile+0x211>
    4872:	48 b8 40 88 00 00 00 	movabs $0x8840,%rax
    4879:	00 00 00 
    487c:	0f b6 80 2b 01 00 00 	movzbl 0x12b(%rax),%eax
    4883:	0f be d0             	movsbl %al,%edx
    4886:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4889:	89 c1                	mov    %eax,%ecx
    488b:	c1 e9 1f             	shr    $0x1f,%ecx
    488e:	01 c8                	add    %ecx,%eax
    4890:	d1 f8                	sar    $1,%eax
    4892:	39 c2                	cmp    %eax,%edx
    4894:	74 19                	je     48af <bigfile+0x22a>
      failexit("read bigfile wrong data");
    4896:	48 b8 f2 7e 00 00 00 	movabs $0x7ef2,%rax
    489d:	00 00 00 
    48a0:	48 89 c7             	mov    %rax,%rdi
    48a3:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    48aa:	00 00 00 
    48ad:	ff d0                	call   *%rax
    }
    total += cc;
    48af:	8b 45 f0             	mov    -0x10(%rbp),%eax
    48b2:	01 45 f8             	add    %eax,-0x8(%rbp)
  for(i = 0; ; i++){
    48b5:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    cc = read(fd, buf, 300);
    48b9:	e9 23 ff ff ff       	jmp    47e1 <bigfile+0x15c>
      break;
    48be:	90                   	nop
  }
  close(fd);
    48bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
    48c2:	89 c7                	mov    %eax,%edi
    48c4:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    48cb:	00 00 00 
    48ce:	ff d0                	call   *%rax
  if(total != 20*600){
    48d0:	81 7d f8 e0 2e 00 00 	cmpl   $0x2ee0,-0x8(%rbp)
    48d7:	74 19                	je     48f2 <bigfile+0x26d>
    failexit("read bigfile wrong total");
    48d9:	48 b8 0a 7f 00 00 00 	movabs $0x7f0a,%rax
    48e0:	00 00 00 
    48e3:	48 89 c7             	mov    %rax,%rdi
    48e6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    48ed:	00 00 00 
    48f0:	ff d0                	call   *%rax
  }
  unlink("bigfile");
    48f2:	48 b8 92 7e 00 00 00 	movabs $0x7e92,%rax
    48f9:	00 00 00 
    48fc:	48 89 c7             	mov    %rax,%rdi
    48ff:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4906:	00 00 00 
    4909:	ff d0                	call   *%rax

  printf(1, "bigfile test ok\n");
    490b:	48 b8 23 7f 00 00 00 	movabs $0x7f23,%rax
    4912:	00 00 00 
    4915:	48 89 c6             	mov    %rax,%rsi
    4918:	bf 01 00 00 00       	mov    $0x1,%edi
    491d:	b8 00 00 00 00       	mov    $0x0,%eax
    4922:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4929:	00 00 00 
    492c:	ff d2                	call   *%rdx
}
    492e:	90                   	nop
    492f:	c9                   	leave
    4930:	c3                   	ret

0000000000004931 <fourteen>:

void
fourteen(void)
{
    4931:	55                   	push   %rbp
    4932:	48 89 e5             	mov    %rsp,%rbp
    4935:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    4939:	48 b8 34 7f 00 00 00 	movabs $0x7f34,%rax
    4940:	00 00 00 
    4943:	48 89 c6             	mov    %rax,%rsi
    4946:	bf 01 00 00 00       	mov    $0x1,%edi
    494b:	b8 00 00 00 00       	mov    $0x0,%eax
    4950:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4957:	00 00 00 
    495a:	ff d2                	call   *%rdx

  if(mkdir("12345678901234") != 0){
    495c:	48 b8 43 7f 00 00 00 	movabs $0x7f43,%rax
    4963:	00 00 00 
    4966:	48 89 c7             	mov    %rax,%rdi
    4969:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    4970:	00 00 00 
    4973:	ff d0                	call   *%rax
    4975:	85 c0                	test   %eax,%eax
    4977:	74 19                	je     4992 <fourteen+0x61>
    failexit("mkdir 12345678901234");
    4979:	48 b8 52 7f 00 00 00 	movabs $0x7f52,%rax
    4980:	00 00 00 
    4983:	48 89 c7             	mov    %rax,%rdi
    4986:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    498d:	00 00 00 
    4990:	ff d0                	call   *%rax
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    4992:	48 b8 68 7f 00 00 00 	movabs $0x7f68,%rax
    4999:	00 00 00 
    499c:	48 89 c7             	mov    %rax,%rdi
    499f:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    49a6:	00 00 00 
    49a9:	ff d0                	call   *%rax
    49ab:	85 c0                	test   %eax,%eax
    49ad:	74 19                	je     49c8 <fourteen+0x97>
    failexit("mkdir 12345678901234/123456789012345");
    49af:	48 b8 88 7f 00 00 00 	movabs $0x7f88,%rax
    49b6:	00 00 00 
    49b9:	48 89 c7             	mov    %rax,%rdi
    49bc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    49c3:	00 00 00 
    49c6:	ff d0                	call   *%rax
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    49c8:	48 b8 b0 7f 00 00 00 	movabs $0x7fb0,%rax
    49cf:	00 00 00 
    49d2:	be 00 02 00 00       	mov    $0x200,%esi
    49d7:	48 89 c7             	mov    %rax,%rdi
    49da:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    49e1:	00 00 00 
    49e4:	ff d0                	call   *%rax
    49e6:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    49e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    49ed:	79 19                	jns    4a08 <fourteen+0xd7>
    failexit("create 123456789012345/123456789012345/123456789012345");
    49ef:	48 b8 e0 7f 00 00 00 	movabs $0x7fe0,%rax
    49f6:	00 00 00 
    49f9:	48 89 c7             	mov    %rax,%rdi
    49fc:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a03:	00 00 00 
    4a06:	ff d0                	call   *%rax
  }
  close(fd);
    4a08:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4a0b:	89 c7                	mov    %eax,%edi
    4a0d:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    4a14:	00 00 00 
    4a17:	ff d0                	call   *%rax
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    4a19:	48 b8 18 80 00 00 00 	movabs $0x8018,%rax
    4a20:	00 00 00 
    4a23:	be 00 00 00 00       	mov    $0x0,%esi
    4a28:	48 89 c7             	mov    %rax,%rdi
    4a2b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4a32:	00 00 00 
    4a35:	ff d0                	call   *%rax
    4a37:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    4a3a:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4a3e:	79 19                	jns    4a59 <fourteen+0x128>
    failexit("open 12345678901234/12345678901234/12345678901234");
    4a40:	48 b8 48 80 00 00 00 	movabs $0x8048,%rax
    4a47:	00 00 00 
    4a4a:	48 89 c7             	mov    %rax,%rdi
    4a4d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a54:	00 00 00 
    4a57:	ff d0                	call   *%rax
  }
  close(fd);
    4a59:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4a5c:	89 c7                	mov    %eax,%edi
    4a5e:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    4a65:	00 00 00 
    4a68:	ff d0                	call   *%rax

  if(mkdir("12345678901234/12345678901234") == 0){
    4a6a:	48 b8 7a 80 00 00 00 	movabs $0x807a,%rax
    4a71:	00 00 00 
    4a74:	48 89 c7             	mov    %rax,%rdi
    4a77:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    4a7e:	00 00 00 
    4a81:	ff d0                	call   *%rax
    4a83:	85 c0                	test   %eax,%eax
    4a85:	75 19                	jne    4aa0 <fourteen+0x16f>
    failexit("mkdir 12345678901234/12345678901234 succeeded");
    4a87:	48 b8 98 80 00 00 00 	movabs $0x8098,%rax
    4a8e:	00 00 00 
    4a91:	48 89 c7             	mov    %rax,%rdi
    4a94:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4a9b:	00 00 00 
    4a9e:	ff d0                	call   *%rax
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    4aa0:	48 b8 c8 80 00 00 00 	movabs $0x80c8,%rax
    4aa7:	00 00 00 
    4aaa:	48 89 c7             	mov    %rax,%rdi
    4aad:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    4ab4:	00 00 00 
    4ab7:	ff d0                	call   *%rax
    4ab9:	85 c0                	test   %eax,%eax
    4abb:	75 19                	jne    4ad6 <fourteen+0x1a5>
    failexit("mkdir 12345678901234/123456789012345 succeeded");
    4abd:	48 b8 e8 80 00 00 00 	movabs $0x80e8,%rax
    4ac4:	00 00 00 
    4ac7:	48 89 c7             	mov    %rax,%rdi
    4aca:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ad1:	00 00 00 
    4ad4:	ff d0                	call   *%rax
  }

  printf(1, "fourteen ok\n");
    4ad6:	48 b8 17 81 00 00 00 	movabs $0x8117,%rax
    4add:	00 00 00 
    4ae0:	48 89 c6             	mov    %rax,%rsi
    4ae3:	bf 01 00 00 00       	mov    $0x1,%edi
    4ae8:	b8 00 00 00 00       	mov    $0x0,%eax
    4aed:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4af4:	00 00 00 
    4af7:	ff d2                	call   *%rdx
}
    4af9:	90                   	nop
    4afa:	c9                   	leave
    4afb:	c3                   	ret

0000000000004afc <rmdot>:

void
rmdot(void)
{
    4afc:	55                   	push   %rbp
    4afd:	48 89 e5             	mov    %rsp,%rbp
  printf(1, "rmdot test\n");
    4b00:	48 b8 24 81 00 00 00 	movabs $0x8124,%rax
    4b07:	00 00 00 
    4b0a:	48 89 c6             	mov    %rax,%rsi
    4b0d:	bf 01 00 00 00       	mov    $0x1,%edi
    4b12:	b8 00 00 00 00       	mov    $0x0,%eax
    4b17:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4b1e:	00 00 00 
    4b21:	ff d2                	call   *%rdx
  if(mkdir("dots") != 0){
    4b23:	48 b8 30 81 00 00 00 	movabs $0x8130,%rax
    4b2a:	00 00 00 
    4b2d:	48 89 c7             	mov    %rax,%rdi
    4b30:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    4b37:	00 00 00 
    4b3a:	ff d0                	call   *%rax
    4b3c:	85 c0                	test   %eax,%eax
    4b3e:	74 19                	je     4b59 <rmdot+0x5d>
    failexit("mkdir dots");
    4b40:	48 b8 35 81 00 00 00 	movabs $0x8135,%rax
    4b47:	00 00 00 
    4b4a:	48 89 c7             	mov    %rax,%rdi
    4b4d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4b54:	00 00 00 
    4b57:	ff d0                	call   *%rax
  }
  if(chdir("dots") != 0){
    4b59:	48 b8 30 81 00 00 00 	movabs $0x8130,%rax
    4b60:	00 00 00 
    4b63:	48 89 c7             	mov    %rax,%rdi
    4b66:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    4b6d:	00 00 00 
    4b70:	ff d0                	call   *%rax
    4b72:	85 c0                	test   %eax,%eax
    4b74:	74 19                	je     4b8f <rmdot+0x93>
    failexit("chdir dots");
    4b76:	48 b8 40 81 00 00 00 	movabs $0x8140,%rax
    4b7d:	00 00 00 
    4b80:	48 89 c7             	mov    %rax,%rdi
    4b83:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4b8a:	00 00 00 
    4b8d:	ff d0                	call   *%rax
  }
  if(unlink(".") == 0){
    4b8f:	48 b8 52 79 00 00 00 	movabs $0x7952,%rax
    4b96:	00 00 00 
    4b99:	48 89 c7             	mov    %rax,%rdi
    4b9c:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4ba3:	00 00 00 
    4ba6:	ff d0                	call   *%rax
    4ba8:	85 c0                	test   %eax,%eax
    4baa:	75 19                	jne    4bc5 <rmdot+0xc9>
    failexit("rm . worked");
    4bac:	48 b8 4b 81 00 00 00 	movabs $0x814b,%rax
    4bb3:	00 00 00 
    4bb6:	48 89 c7             	mov    %rax,%rdi
    4bb9:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4bc0:	00 00 00 
    4bc3:	ff d0                	call   *%rax
  }
  if(unlink("..") == 0){
    4bc5:	48 b8 ca 74 00 00 00 	movabs $0x74ca,%rax
    4bcc:	00 00 00 
    4bcf:	48 89 c7             	mov    %rax,%rdi
    4bd2:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4bd9:	00 00 00 
    4bdc:	ff d0                	call   *%rax
    4bde:	85 c0                	test   %eax,%eax
    4be0:	75 19                	jne    4bfb <rmdot+0xff>
    failexit("rm .. worked");
    4be2:	48 b8 57 81 00 00 00 	movabs $0x8157,%rax
    4be9:	00 00 00 
    4bec:	48 89 c7             	mov    %rax,%rdi
    4bef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4bf6:	00 00 00 
    4bf9:	ff d0                	call   *%rax
  }
  if(chdir("/") != 0){
    4bfb:	48 b8 c0 71 00 00 00 	movabs $0x71c0,%rax
    4c02:	00 00 00 
    4c05:	48 89 c7             	mov    %rax,%rdi
    4c08:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    4c0f:	00 00 00 
    4c12:	ff d0                	call   *%rax
    4c14:	85 c0                	test   %eax,%eax
    4c16:	74 19                	je     4c31 <rmdot+0x135>
    failexit("chdir /");
    4c18:	48 b8 c2 71 00 00 00 	movabs $0x71c2,%rax
    4c1f:	00 00 00 
    4c22:	48 89 c7             	mov    %rax,%rdi
    4c25:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c2c:	00 00 00 
    4c2f:	ff d0                	call   *%rax
  }
  if(unlink("dots/.") == 0){
    4c31:	48 b8 64 81 00 00 00 	movabs $0x8164,%rax
    4c38:	00 00 00 
    4c3b:	48 89 c7             	mov    %rax,%rdi
    4c3e:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4c45:	00 00 00 
    4c48:	ff d0                	call   *%rax
    4c4a:	85 c0                	test   %eax,%eax
    4c4c:	75 19                	jne    4c67 <rmdot+0x16b>
    failexit("unlink dots/. worked");
    4c4e:	48 b8 6b 81 00 00 00 	movabs $0x816b,%rax
    4c55:	00 00 00 
    4c58:	48 89 c7             	mov    %rax,%rdi
    4c5b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c62:	00 00 00 
    4c65:	ff d0                	call   *%rax
  }
  if(unlink("dots/..") == 0){
    4c67:	48 b8 80 81 00 00 00 	movabs $0x8180,%rax
    4c6e:	00 00 00 
    4c71:	48 89 c7             	mov    %rax,%rdi
    4c74:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4c7b:	00 00 00 
    4c7e:	ff d0                	call   *%rax
    4c80:	85 c0                	test   %eax,%eax
    4c82:	75 19                	jne    4c9d <rmdot+0x1a1>
    failexit("unlink dots/.. worked");
    4c84:	48 b8 88 81 00 00 00 	movabs $0x8188,%rax
    4c8b:	00 00 00 
    4c8e:	48 89 c7             	mov    %rax,%rdi
    4c91:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4c98:	00 00 00 
    4c9b:	ff d0                	call   *%rax
  }
  if(unlink("dots") != 0){
    4c9d:	48 b8 30 81 00 00 00 	movabs $0x8130,%rax
    4ca4:	00 00 00 
    4ca7:	48 89 c7             	mov    %rax,%rdi
    4caa:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4cb1:	00 00 00 
    4cb4:	ff d0                	call   *%rax
    4cb6:	85 c0                	test   %eax,%eax
    4cb8:	74 19                	je     4cd3 <rmdot+0x1d7>
    failexit("unlink dots");
    4cba:	48 b8 9e 81 00 00 00 	movabs $0x819e,%rax
    4cc1:	00 00 00 
    4cc4:	48 89 c7             	mov    %rax,%rdi
    4cc7:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4cce:	00 00 00 
    4cd1:	ff d0                	call   *%rax
  }
  printf(1, "rmdot ok\n");
    4cd3:	48 b8 aa 81 00 00 00 	movabs $0x81aa,%rax
    4cda:	00 00 00 
    4cdd:	48 89 c6             	mov    %rax,%rsi
    4ce0:	bf 01 00 00 00       	mov    $0x1,%edi
    4ce5:	b8 00 00 00 00       	mov    $0x0,%eax
    4cea:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4cf1:	00 00 00 
    4cf4:	ff d2                	call   *%rdx
}
    4cf6:	90                   	nop
    4cf7:	5d                   	pop    %rbp
    4cf8:	c3                   	ret

0000000000004cf9 <dirfile>:

void
dirfile(void)
{
    4cf9:	55                   	push   %rbp
    4cfa:	48 89 e5             	mov    %rsp,%rbp
    4cfd:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;

  printf(1, "dir vs file\n");
    4d01:	48 b8 b4 81 00 00 00 	movabs $0x81b4,%rax
    4d08:	00 00 00 
    4d0b:	48 89 c6             	mov    %rax,%rsi
    4d0e:	bf 01 00 00 00       	mov    $0x1,%edi
    4d13:	b8 00 00 00 00       	mov    $0x0,%eax
    4d18:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4d1f:	00 00 00 
    4d22:	ff d2                	call   *%rdx

  fd = open("dirfile", O_CREATE);
    4d24:	48 b8 c1 81 00 00 00 	movabs $0x81c1,%rax
    4d2b:	00 00 00 
    4d2e:	be 00 02 00 00       	mov    $0x200,%esi
    4d33:	48 89 c7             	mov    %rax,%rdi
    4d36:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4d3d:	00 00 00 
    4d40:	ff d0                	call   *%rax
    4d42:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0){
    4d45:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4d49:	79 19                	jns    4d64 <dirfile+0x6b>
    failexit("create dirfile");
    4d4b:	48 b8 c9 81 00 00 00 	movabs $0x81c9,%rax
    4d52:	00 00 00 
    4d55:	48 89 c7             	mov    %rax,%rdi
    4d58:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4d5f:	00 00 00 
    4d62:	ff d0                	call   *%rax
  }
  close(fd);
    4d64:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4d67:	89 c7                	mov    %eax,%edi
    4d69:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    4d70:	00 00 00 
    4d73:	ff d0                	call   *%rax
  if(chdir("dirfile") == 0){
    4d75:	48 b8 c1 81 00 00 00 	movabs $0x81c1,%rax
    4d7c:	00 00 00 
    4d7f:	48 89 c7             	mov    %rax,%rdi
    4d82:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    4d89:	00 00 00 
    4d8c:	ff d0                	call   *%rax
    4d8e:	85 c0                	test   %eax,%eax
    4d90:	75 19                	jne    4dab <dirfile+0xb2>
    failexit("chdir dirfile succeeded");
    4d92:	48 b8 d8 81 00 00 00 	movabs $0x81d8,%rax
    4d99:	00 00 00 
    4d9c:	48 89 c7             	mov    %rax,%rdi
    4d9f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4da6:	00 00 00 
    4da9:	ff d0                	call   *%rax
  }
  fd = open("dirfile/xx", 0);
    4dab:	48 b8 f0 81 00 00 00 	movabs $0x81f0,%rax
    4db2:	00 00 00 
    4db5:	be 00 00 00 00       	mov    $0x0,%esi
    4dba:	48 89 c7             	mov    %rax,%rdi
    4dbd:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4dc4:	00 00 00 
    4dc7:	ff d0                	call   *%rax
    4dc9:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    4dcc:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4dd0:	78 19                	js     4deb <dirfile+0xf2>
    failexit("create dirfile/xx succeeded");
    4dd2:	48 b8 fb 81 00 00 00 	movabs $0x81fb,%rax
    4dd9:	00 00 00 
    4ddc:	48 89 c7             	mov    %rax,%rdi
    4ddf:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4de6:	00 00 00 
    4de9:	ff d0                	call   *%rax
  }
  fd = open("dirfile/xx", O_CREATE);
    4deb:	48 b8 f0 81 00 00 00 	movabs $0x81f0,%rax
    4df2:	00 00 00 
    4df5:	be 00 02 00 00       	mov    $0x200,%esi
    4dfa:	48 89 c7             	mov    %rax,%rdi
    4dfd:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4e04:	00 00 00 
    4e07:	ff d0                	call   *%rax
    4e09:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    4e0c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4e10:	78 19                	js     4e2b <dirfile+0x132>
    failexit("create dirfile/xx succeeded");
    4e12:	48 b8 fb 81 00 00 00 	movabs $0x81fb,%rax
    4e19:	00 00 00 
    4e1c:	48 89 c7             	mov    %rax,%rdi
    4e1f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e26:	00 00 00 
    4e29:	ff d0                	call   *%rax
  }
  if(mkdir("dirfile/xx") == 0){
    4e2b:	48 b8 f0 81 00 00 00 	movabs $0x81f0,%rax
    4e32:	00 00 00 
    4e35:	48 89 c7             	mov    %rax,%rdi
    4e38:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    4e3f:	00 00 00 
    4e42:	ff d0                	call   *%rax
    4e44:	85 c0                	test   %eax,%eax
    4e46:	75 19                	jne    4e61 <dirfile+0x168>
    failexit("mkdir dirfile/xx succeeded");
    4e48:	48 b8 17 82 00 00 00 	movabs $0x8217,%rax
    4e4f:	00 00 00 
    4e52:	48 89 c7             	mov    %rax,%rdi
    4e55:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e5c:	00 00 00 
    4e5f:	ff d0                	call   *%rax
  }
  if(unlink("dirfile/xx") == 0){
    4e61:	48 b8 f0 81 00 00 00 	movabs $0x81f0,%rax
    4e68:	00 00 00 
    4e6b:	48 89 c7             	mov    %rax,%rdi
    4e6e:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4e75:	00 00 00 
    4e78:	ff d0                	call   *%rax
    4e7a:	85 c0                	test   %eax,%eax
    4e7c:	75 19                	jne    4e97 <dirfile+0x19e>
    failexit("unlink dirfile/xx succeeded");
    4e7e:	48 b8 32 82 00 00 00 	movabs $0x8232,%rax
    4e85:	00 00 00 
    4e88:	48 89 c7             	mov    %rax,%rdi
    4e8b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4e92:	00 00 00 
    4e95:	ff d0                	call   *%rax
  }
  if(link("README", "dirfile/xx") == 0){
    4e97:	48 ba f0 81 00 00 00 	movabs $0x81f0,%rdx
    4e9e:	00 00 00 
    4ea1:	48 b8 4e 82 00 00 00 	movabs $0x824e,%rax
    4ea8:	00 00 00 
    4eab:	48 89 d6             	mov    %rdx,%rsi
    4eae:	48 89 c7             	mov    %rax,%rdi
    4eb1:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    4eb8:	00 00 00 
    4ebb:	ff d0                	call   *%rax
    4ebd:	85 c0                	test   %eax,%eax
    4ebf:	75 19                	jne    4eda <dirfile+0x1e1>
    failexit("link to dirfile/xx succeeded");
    4ec1:	48 b8 55 82 00 00 00 	movabs $0x8255,%rax
    4ec8:	00 00 00 
    4ecb:	48 89 c7             	mov    %rax,%rdi
    4ece:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4ed5:	00 00 00 
    4ed8:	ff d0                	call   *%rax
  }
  if(unlink("dirfile") != 0){
    4eda:	48 b8 c1 81 00 00 00 	movabs $0x81c1,%rax
    4ee1:	00 00 00 
    4ee4:	48 89 c7             	mov    %rax,%rdi
    4ee7:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    4eee:	00 00 00 
    4ef1:	ff d0                	call   *%rax
    4ef3:	85 c0                	test   %eax,%eax
    4ef5:	74 19                	je     4f10 <dirfile+0x217>
    failexit("unlink dirfile");
    4ef7:	48 b8 72 82 00 00 00 	movabs $0x8272,%rax
    4efe:	00 00 00 
    4f01:	48 89 c7             	mov    %rax,%rdi
    4f04:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f0b:	00 00 00 
    4f0e:	ff d0                	call   *%rax
  }

  fd = open(".", O_RDWR);
    4f10:	48 b8 52 79 00 00 00 	movabs $0x7952,%rax
    4f17:	00 00 00 
    4f1a:	be 02 00 00 00       	mov    $0x2,%esi
    4f1f:	48 89 c7             	mov    %rax,%rdi
    4f22:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4f29:	00 00 00 
    4f2c:	ff d0                	call   *%rax
    4f2e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd >= 0){
    4f31:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    4f35:	78 19                	js     4f50 <dirfile+0x257>
    failexit("open . for writing succeeded");
    4f37:	48 b8 81 82 00 00 00 	movabs $0x8281,%rax
    4f3e:	00 00 00 
    4f41:	48 89 c7             	mov    %rax,%rdi
    4f44:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4f4b:	00 00 00 
    4f4e:	ff d0                	call   *%rax
  }
  fd = open(".", 0);
    4f50:	48 b8 52 79 00 00 00 	movabs $0x7952,%rax
    4f57:	00 00 00 
    4f5a:	be 00 00 00 00       	mov    $0x0,%esi
    4f5f:	48 89 c7             	mov    %rax,%rdi
    4f62:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    4f69:	00 00 00 
    4f6c:	ff d0                	call   *%rax
    4f6e:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(write(fd, "x", 1) > 0){
    4f71:	48 b9 d6 75 00 00 00 	movabs $0x75d6,%rcx
    4f78:	00 00 00 
    4f7b:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4f7e:	ba 01 00 00 00       	mov    $0x1,%edx
    4f83:	48 89 ce             	mov    %rcx,%rsi
    4f86:	89 c7                	mov    %eax,%edi
    4f88:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    4f8f:	00 00 00 
    4f92:	ff d0                	call   *%rax
    4f94:	85 c0                	test   %eax,%eax
    4f96:	7e 19                	jle    4fb1 <dirfile+0x2b8>
    failexit("write . succeeded");
    4f98:	48 b8 9e 82 00 00 00 	movabs $0x829e,%rax
    4f9f:	00 00 00 
    4fa2:	48 89 c7             	mov    %rax,%rdi
    4fa5:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    4fac:	00 00 00 
    4faf:	ff d0                	call   *%rax
  }
  close(fd);
    4fb1:	8b 45 fc             	mov    -0x4(%rbp),%eax
    4fb4:	89 c7                	mov    %eax,%edi
    4fb6:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    4fbd:	00 00 00 
    4fc0:	ff d0                	call   *%rax

  printf(1, "dir vs file OK\n");
    4fc2:	48 b8 b0 82 00 00 00 	movabs $0x82b0,%rax
    4fc9:	00 00 00 
    4fcc:	48 89 c6             	mov    %rax,%rsi
    4fcf:	bf 01 00 00 00       	mov    $0x1,%edi
    4fd4:	b8 00 00 00 00       	mov    $0x0,%eax
    4fd9:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    4fe0:	00 00 00 
    4fe3:	ff d2                	call   *%rdx
}
    4fe5:	90                   	nop
    4fe6:	c9                   	leave
    4fe7:	c3                   	ret

0000000000004fe8 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    4fe8:	55                   	push   %rbp
    4fe9:	48 89 e5             	mov    %rsp,%rbp
    4fec:	48 83 ec 10          	sub    $0x10,%rsp
  int i, fd;

  printf(1, "empty file name\n");
    4ff0:	48 b8 c0 82 00 00 00 	movabs $0x82c0,%rax
    4ff7:	00 00 00 
    4ffa:	48 89 c6             	mov    %rax,%rsi
    4ffd:	bf 01 00 00 00       	mov    $0x1,%edi
    5002:	b8 00 00 00 00       	mov    $0x0,%eax
    5007:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    500e:	00 00 00 
    5011:	ff d2                	call   *%rdx

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    5013:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    501a:	e9 38 01 00 00       	jmp    5157 <iref+0x16f>
    if(mkdir("irefd") != 0){
    501f:	48 b8 d1 82 00 00 00 	movabs $0x82d1,%rax
    5026:	00 00 00 
    5029:	48 89 c7             	mov    %rax,%rdi
    502c:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    5033:	00 00 00 
    5036:	ff d0                	call   *%rax
    5038:	85 c0                	test   %eax,%eax
    503a:	74 19                	je     5055 <iref+0x6d>
      failexit("mkdir irefd");
    503c:	48 b8 d7 82 00 00 00 	movabs $0x82d7,%rax
    5043:	00 00 00 
    5046:	48 89 c7             	mov    %rax,%rdi
    5049:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5050:	00 00 00 
    5053:	ff d0                	call   *%rax
    }
    if(chdir("irefd") != 0){
    5055:	48 b8 d1 82 00 00 00 	movabs $0x82d1,%rax
    505c:	00 00 00 
    505f:	48 89 c7             	mov    %rax,%rdi
    5062:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    5069:	00 00 00 
    506c:	ff d0                	call   *%rax
    506e:	85 c0                	test   %eax,%eax
    5070:	74 19                	je     508b <iref+0xa3>
      failexit("chdir irefd");
    5072:	48 b8 e3 82 00 00 00 	movabs $0x82e3,%rax
    5079:	00 00 00 
    507c:	48 89 c7             	mov    %rax,%rdi
    507f:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5086:	00 00 00 
    5089:	ff d0                	call   *%rax
    }

    mkdir("");
    508b:	48 b8 ef 82 00 00 00 	movabs $0x82ef,%rax
    5092:	00 00 00 
    5095:	48 89 c7             	mov    %rax,%rdi
    5098:	48 b8 f5 67 00 00 00 	movabs $0x67f5,%rax
    509f:	00 00 00 
    50a2:	ff d0                	call   *%rax
    link("README", "");
    50a4:	48 ba ef 82 00 00 00 	movabs $0x82ef,%rdx
    50ab:	00 00 00 
    50ae:	48 b8 4e 82 00 00 00 	movabs $0x824e,%rax
    50b5:	00 00 00 
    50b8:	48 89 d6             	mov    %rdx,%rsi
    50bb:	48 89 c7             	mov    %rax,%rdi
    50be:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    50c5:	00 00 00 
    50c8:	ff d0                	call   *%rax
    fd = open("", O_CREATE);
    50ca:	48 b8 ef 82 00 00 00 	movabs $0x82ef,%rax
    50d1:	00 00 00 
    50d4:	be 00 02 00 00       	mov    $0x200,%esi
    50d9:	48 89 c7             	mov    %rax,%rdi
    50dc:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    50e3:	00 00 00 
    50e6:	ff d0                	call   *%rax
    50e8:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    50eb:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    50ef:	78 11                	js     5102 <iref+0x11a>
      close(fd);
    50f1:	8b 45 f8             	mov    -0x8(%rbp),%eax
    50f4:	89 c7                	mov    %eax,%edi
    50f6:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    50fd:	00 00 00 
    5100:	ff d0                	call   *%rax
    fd = open("xx", O_CREATE);
    5102:	48 b8 f0 82 00 00 00 	movabs $0x82f0,%rax
    5109:	00 00 00 
    510c:	be 00 02 00 00       	mov    $0x200,%esi
    5111:	48 89 c7             	mov    %rax,%rdi
    5114:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    511b:	00 00 00 
    511e:	ff d0                	call   *%rax
    5120:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(fd >= 0)
    5123:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5127:	78 11                	js     513a <iref+0x152>
      close(fd);
    5129:	8b 45 f8             	mov    -0x8(%rbp),%eax
    512c:	89 c7                	mov    %eax,%edi
    512e:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    5135:	00 00 00 
    5138:	ff d0                	call   *%rax
    unlink("xx");
    513a:	48 b8 f0 82 00 00 00 	movabs $0x82f0,%rax
    5141:	00 00 00 
    5144:	48 89 c7             	mov    %rax,%rdi
    5147:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    514e:	00 00 00 
    5151:	ff d0                	call   *%rax
  for(i = 0; i < 50 + 1; i++){
    5153:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5157:	83 7d fc 32          	cmpl   $0x32,-0x4(%rbp)
    515b:	0f 8e be fe ff ff    	jle    501f <iref+0x37>
  }

  chdir("/");
    5161:	48 b8 c0 71 00 00 00 	movabs $0x71c0,%rax
    5168:	00 00 00 
    516b:	48 89 c7             	mov    %rax,%rdi
    516e:	48 b8 02 68 00 00 00 	movabs $0x6802,%rax
    5175:	00 00 00 
    5178:	ff d0                	call   *%rax
  printf(1, "empty file name OK\n");
    517a:	48 b8 f3 82 00 00 00 	movabs $0x82f3,%rax
    5181:	00 00 00 
    5184:	48 89 c6             	mov    %rax,%rsi
    5187:	bf 01 00 00 00       	mov    $0x1,%edi
    518c:	b8 00 00 00 00       	mov    $0x0,%eax
    5191:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5198:	00 00 00 
    519b:	ff d2                	call   *%rdx
}
    519d:	90                   	nop
    519e:	c9                   	leave
    519f:	c3                   	ret

00000000000051a0 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    51a0:	55                   	push   %rbp
    51a1:	48 89 e5             	mov    %rsp,%rbp
    51a4:	48 83 ec 10          	sub    $0x10,%rsp
  int n, pid;

  printf(1, "fork test\n");
    51a8:	48 b8 07 83 00 00 00 	movabs $0x8307,%rax
    51af:	00 00 00 
    51b2:	48 89 c6             	mov    %rax,%rsi
    51b5:	bf 01 00 00 00       	mov    $0x1,%edi
    51ba:	b8 00 00 00 00       	mov    $0x0,%eax
    51bf:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    51c6:	00 00 00 
    51c9:	ff d2                	call   *%rdx

  for(n=0; n<1000; n++){
    51cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    51d2:	eb 2b                	jmp    51ff <forktest+0x5f>
    pid = fork();
    51d4:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    51db:	00 00 00 
    51de:	ff d0                	call   *%rax
    51e0:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(pid < 0)
    51e3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    51e7:	78 21                	js     520a <forktest+0x6a>
      break;
    if(pid == 0)
    51e9:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    51ed:	75 0c                	jne    51fb <forktest+0x5b>
      exit();
    51ef:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    51f6:	00 00 00 
    51f9:	ff d0                	call   *%rax
  for(n=0; n<1000; n++){
    51fb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    51ff:	81 7d fc e7 03 00 00 	cmpl   $0x3e7,-0x4(%rbp)
    5206:	7e cc                	jle    51d4 <forktest+0x34>
    5208:	eb 01                	jmp    520b <forktest+0x6b>
      break;
    520a:	90                   	nop
  }

  if(n == 1000){
    520b:	81 7d fc e8 03 00 00 	cmpl   $0x3e8,-0x4(%rbp)
    5212:	75 48                	jne    525c <forktest+0xbc>
    failexit("fork claimed to work 1000 times");
    5214:	48 b8 18 83 00 00 00 	movabs $0x8318,%rax
    521b:	00 00 00 
    521e:	48 89 c7             	mov    %rax,%rdi
    5221:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5228:	00 00 00 
    522b:	ff d0                	call   *%rax
  }

  for(; n > 0; n--){
    522d:	eb 2d                	jmp    525c <forktest+0xbc>
    if(wait() < 0){
    522f:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    5236:	00 00 00 
    5239:	ff d0                	call   *%rax
    523b:	85 c0                	test   %eax,%eax
    523d:	79 19                	jns    5258 <forktest+0xb8>
      failexit("wait stopped early");
    523f:	48 b8 38 83 00 00 00 	movabs $0x8338,%rax
    5246:	00 00 00 
    5249:	48 89 c7             	mov    %rax,%rdi
    524c:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5253:	00 00 00 
    5256:	ff d0                	call   *%rax
  for(; n > 0; n--){
    5258:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
    525c:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    5260:	7f cd                	jg     522f <forktest+0x8f>
    }
  }

  if(wait() != -1){
    5262:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    5269:	00 00 00 
    526c:	ff d0                	call   *%rax
    526e:	83 f8 ff             	cmp    $0xffffffff,%eax
    5271:	74 19                	je     528c <forktest+0xec>
    failexit("wait got too many");
    5273:	48 b8 4b 83 00 00 00 	movabs $0x834b,%rax
    527a:	00 00 00 
    527d:	48 89 c7             	mov    %rax,%rdi
    5280:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5287:	00 00 00 
    528a:	ff d0                	call   *%rax
  }

  printf(1, "fork test OK\n");
    528c:	48 b8 5d 83 00 00 00 	movabs $0x835d,%rax
    5293:	00 00 00 
    5296:	48 89 c6             	mov    %rax,%rsi
    5299:	bf 01 00 00 00       	mov    $0x1,%edi
    529e:	b8 00 00 00 00       	mov    $0x0,%eax
    52a3:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    52aa:	00 00 00 
    52ad:	ff d2                	call   *%rdx
}
    52af:	90                   	nop
    52b0:	c9                   	leave
    52b1:	c3                   	ret

00000000000052b2 <sbrktest>:

void
sbrktest(void)
{
    52b2:	55                   	push   %rbp
    52b3:	48 89 e5             	mov    %rsp,%rbp
    52b6:	48 81 ec 90 00 00 00 	sub    $0x90,%rsp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(1, "sbrk test\n");
    52bd:	48 b8 6b 83 00 00 00 	movabs $0x836b,%rax
    52c4:	00 00 00 
    52c7:	48 89 c6             	mov    %rax,%rsi
    52ca:	bf 01 00 00 00       	mov    $0x1,%edi
    52cf:	b8 00 00 00 00       	mov    $0x0,%eax
    52d4:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    52db:	00 00 00 
    52de:	ff d2                	call   *%rdx
  oldbrk = sbrk(0);
    52e0:	bf 00 00 00 00       	mov    $0x0,%edi
    52e5:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    52ec:	00 00 00 
    52ef:	ff d0                	call   *%rax
    52f1:	48 89 45 e8          	mov    %rax,-0x18(%rbp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    52f5:	bf 00 00 00 00       	mov    $0x0,%edi
    52fa:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5301:	00 00 00 
    5304:	ff d0                	call   *%rax
    5306:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  int i;
  for(i = 0; i < 5000; i++){
    530a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    5311:	eb 76                	jmp    5389 <sbrktest+0xd7>
    b = sbrk(1);
    5313:	bf 01 00 00 00       	mov    $0x1,%edi
    5318:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    531f:	00 00 00 
    5322:	ff d0                	call   *%rax
    5324:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    if(b != a){
    5328:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    532c:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5330:	74 40                	je     5372 <sbrktest+0xc0>
      printf(1, "sbrk test failed %d %p %p\n", i, a, b);
    5332:	48 8b 4d b0          	mov    -0x50(%rbp),%rcx
    5336:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    533a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    533d:	48 be 76 83 00 00 00 	movabs $0x8376,%rsi
    5344:	00 00 00 
    5347:	49 89 c8             	mov    %rcx,%r8
    534a:	48 89 d1             	mov    %rdx,%rcx
    534d:	89 c2                	mov    %eax,%edx
    534f:	bf 01 00 00 00       	mov    $0x1,%edi
    5354:	b8 00 00 00 00       	mov    $0x0,%eax
    5359:	49 b9 33 6a 00 00 00 	movabs $0x6a33,%r9
    5360:	00 00 00 
    5363:	41 ff d1             	call   *%r9
      exit();
    5366:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    536d:	00 00 00 
    5370:	ff d0                	call   *%rax
    }
    *b = 1;
    5372:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    5376:	c6 00 01             	movb   $0x1,(%rax)
    a = b + 1;
    5379:	48 8b 45 b0          	mov    -0x50(%rbp),%rax
    537d:	48 83 c0 01          	add    $0x1,%rax
    5381:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  for(i = 0; i < 5000; i++){
    5385:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    5389:	81 7d f4 87 13 00 00 	cmpl   $0x1387,-0xc(%rbp)
    5390:	7e 81                	jle    5313 <sbrktest+0x61>
  }
  pid = fork();
    5392:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    5399:	00 00 00 
    539c:	ff d0                	call   *%rax
    539e:	89 45 e4             	mov    %eax,-0x1c(%rbp)
  if(pid < 0){
    53a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    53a5:	79 19                	jns    53c0 <sbrktest+0x10e>
    failexit("sbrk test fork");
    53a7:	48 b8 91 83 00 00 00 	movabs $0x8391,%rax
    53ae:	00 00 00 
    53b1:	48 89 c7             	mov    %rax,%rdi
    53b4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    53bb:	00 00 00 
    53be:	ff d0                	call   *%rax
  }
  c = sbrk(1);
    53c0:	bf 01 00 00 00       	mov    $0x1,%edi
    53c5:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    53cc:	00 00 00 
    53cf:	ff d0                	call   *%rax
    53d1:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  c = sbrk(1);
    53d5:	bf 01 00 00 00       	mov    $0x1,%edi
    53da:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    53e1:	00 00 00 
    53e4:	ff d0                	call   *%rax
    53e6:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a + 1){
    53ea:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    53ee:	48 83 c0 01          	add    $0x1,%rax
    53f2:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    53f6:	74 19                	je     5411 <sbrktest+0x15f>
    failexit("sbrk test failed post-fork");
    53f8:	48 b8 a0 83 00 00 00 	movabs $0x83a0,%rax
    53ff:	00 00 00 
    5402:	48 89 c7             	mov    %rax,%rdi
    5405:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    540c:	00 00 00 
    540f:	ff d0                	call   *%rax
  }
  if(pid == 0)
    5411:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    5415:	75 0c                	jne    5423 <sbrktest+0x171>
    exit();
    5417:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    541e:	00 00 00 
    5421:	ff d0                	call   *%rax
  wait();
    5423:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    542a:	00 00 00 
    542d:	ff d0                	call   *%rax

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    542f:	bf 00 00 00 00       	mov    $0x0,%edi
    5434:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    543b:	00 00 00 
    543e:	ff d0                	call   *%rax
    5440:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  amt = (BIG) - (addr_t)a;
    5444:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5448:	89 c2                	mov    %eax,%edx
    544a:	b8 00 00 40 06       	mov    $0x6400000,%eax
    544f:	29 d0                	sub    %edx,%eax
    5451:	89 45 d4             	mov    %eax,-0x2c(%rbp)
  p = sbrk(amt);
    5454:	8b 45 d4             	mov    -0x2c(%rbp),%eax
    5457:	48 89 c7             	mov    %rax,%rdi
    545a:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5461:	00 00 00 
    5464:	ff d0                	call   *%rax
    5466:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  if (p != a) {
    546a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    546e:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5472:	74 19                	je     548d <sbrktest+0x1db>
    failexit("sbrk test failed to grow big address space; enough phys mem?");
    5474:	48 b8 c0 83 00 00 00 	movabs $0x83c0,%rax
    547b:	00 00 00 
    547e:	48 89 c7             	mov    %rax,%rdi
    5481:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5488:	00 00 00 
    548b:	ff d0                	call   *%rax
  }
  lastaddr = (char*) (BIG-1);
    548d:	48 c7 45 c0 ff ff 3f 	movq   $0x63fffff,-0x40(%rbp)
    5494:	06 
  *lastaddr = 99;
    5495:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    5499:	c6 00 63             	movb   $0x63,(%rax)

  // can one de-allocate?
  a = sbrk(0);
    549c:	bf 00 00 00 00       	mov    $0x0,%edi
    54a1:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    54a8:	00 00 00 
    54ab:	ff d0                	call   *%rax
    54ad:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-4096);
    54b1:	48 c7 c7 00 f0 ff ff 	mov    $0xfffffffffffff000,%rdi
    54b8:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    54bf:	00 00 00 
    54c2:	ff d0                	call   *%rax
    54c4:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c == (char*)0xffffffff){
    54c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    54cd:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    54d1:	75 19                	jne    54ec <sbrktest+0x23a>
    failexit("sbrk could not deallocate");
    54d3:	48 b8 fd 83 00 00 00 	movabs $0x83fd,%rax
    54da:	00 00 00 
    54dd:	48 89 c7             	mov    %rax,%rdi
    54e0:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    54e7:	00 00 00 
    54ea:	ff d0                	call   *%rax
  }
  c = sbrk(0);
    54ec:	bf 00 00 00 00       	mov    $0x0,%edi
    54f1:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    54f8:	00 00 00 
    54fb:	ff d0                	call   *%rax
    54fd:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a - 4096){
    5501:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5505:	48 2d 00 10 00 00    	sub    $0x1000,%rax
    550b:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    550f:	74 3b                	je     554c <sbrktest+0x29a>
    printf(1, "sbrk deallocation produced wrong address, a %p c %p\n", a, c);
    5511:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    5515:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5519:	48 be 18 84 00 00 00 	movabs $0x8418,%rsi
    5520:	00 00 00 
    5523:	48 89 d1             	mov    %rdx,%rcx
    5526:	48 89 c2             	mov    %rax,%rdx
    5529:	bf 01 00 00 00       	mov    $0x1,%edi
    552e:	b8 00 00 00 00       	mov    $0x0,%eax
    5533:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    553a:	00 00 00 
    553d:	41 ff d0             	call   *%r8
    exit();
    5540:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    5547:	00 00 00 
    554a:	ff d0                	call   *%rax
  }

  // can one re-allocate that page?
  a = sbrk(0);
    554c:	bf 00 00 00 00       	mov    $0x0,%edi
    5551:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5558:	00 00 00 
    555b:	ff d0                	call   *%rax
    555d:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(4096);
    5561:	bf 00 10 00 00       	mov    $0x1000,%edi
    5566:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    556d:	00 00 00 
    5570:	ff d0                	call   *%rax
    5572:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a || sbrk(0) != a + 4096){
    5576:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    557a:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    557e:	75 21                	jne    55a1 <sbrktest+0x2ef>
    5580:	bf 00 00 00 00       	mov    $0x0,%edi
    5585:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    558c:	00 00 00 
    558f:	ff d0                	call   *%rax
    5591:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
    5595:	48 81 c2 00 10 00 00 	add    $0x1000,%rdx
    559c:	48 39 d0             	cmp    %rdx,%rax
    559f:	74 3b                	je     55dc <sbrktest+0x32a>
    printf(1, "sbrk re-allocation failed, a %p c %p\n", a, c);
    55a1:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    55a5:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    55a9:	48 be 50 84 00 00 00 	movabs $0x8450,%rsi
    55b0:	00 00 00 
    55b3:	48 89 d1             	mov    %rdx,%rcx
    55b6:	48 89 c2             	mov    %rax,%rdx
    55b9:	bf 01 00 00 00       	mov    $0x1,%edi
    55be:	b8 00 00 00 00       	mov    $0x0,%eax
    55c3:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    55ca:	00 00 00 
    55cd:	41 ff d0             	call   *%r8
    exit();
    55d0:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    55d7:	00 00 00 
    55da:	ff d0                	call   *%rax
  }
  if(*lastaddr == 99){
    55dc:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    55e0:	0f b6 00             	movzbl (%rax),%eax
    55e3:	3c 63                	cmp    $0x63,%al
    55e5:	75 19                	jne    5600 <sbrktest+0x34e>
    // should be zero
    failexit("sbrk de-allocation didn't really deallocate");
    55e7:	48 b8 78 84 00 00 00 	movabs $0x8478,%rax
    55ee:	00 00 00 
    55f1:	48 89 c7             	mov    %rax,%rdi
    55f4:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    55fb:	00 00 00 
    55fe:	ff d0                	call   *%rax
  }

  a = sbrk(0);
    5600:	bf 00 00 00 00       	mov    $0x0,%edi
    5605:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    560c:	00 00 00 
    560f:	ff d0                	call   *%rax
    5611:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  c = sbrk(-(sbrk(0) - oldbrk));
    5615:	bf 00 00 00 00       	mov    $0x0,%edi
    561a:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5621:	00 00 00 
    5624:	ff d0                	call   *%rax
    5626:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    562a:	48 29 c2             	sub    %rax,%rdx
    562d:	48 89 d0             	mov    %rdx,%rax
    5630:	48 89 c7             	mov    %rax,%rdi
    5633:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    563a:	00 00 00 
    563d:	ff d0                	call   *%rax
    563f:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  if(c != a){
    5643:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    5647:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    564b:	74 3b                	je     5688 <sbrktest+0x3d6>
    printf(1, "sbrk downsize failed, a %p c %p\n", a, c);
    564d:	48 8b 55 d8          	mov    -0x28(%rbp),%rdx
    5651:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5655:	48 be a8 84 00 00 00 	movabs $0x84a8,%rsi
    565c:	00 00 00 
    565f:	48 89 d1             	mov    %rdx,%rcx
    5662:	48 89 c2             	mov    %rax,%rdx
    5665:	bf 01 00 00 00       	mov    $0x1,%edi
    566a:	b8 00 00 00 00       	mov    $0x0,%eax
    566f:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    5676:	00 00 00 
    5679:	41 ff d0             	call   *%r8
    exit();
    567c:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    5683:	00 00 00 
    5686:	ff d0                	call   *%rax
  }

  printf(1, "expecting 10 killed processes:\n");
    5688:	48 b8 d0 84 00 00 00 	movabs $0x84d0,%rax
    568f:	00 00 00 
    5692:	48 89 c6             	mov    %rax,%rsi
    5695:	bf 01 00 00 00       	mov    $0x1,%edi
    569a:	b8 00 00 00 00       	mov    $0x0,%eax
    569f:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    56a6:	00 00 00 
    56a9:	ff d2                	call   *%rdx
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+1000000); a += 100000){
    56ab:	48 b8 00 00 00 00 00 	movabs $0xffff800000000000,%rax
    56b2:	80 ff ff 
    56b5:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    56b9:	e9 a8 00 00 00       	jmp    5766 <sbrktest+0x4b4>
    ppid = getpid();
    56be:	48 b8 1c 68 00 00 00 	movabs $0x681c,%rax
    56c5:	00 00 00 
    56c8:	ff d0                	call   *%rax
    56ca:	89 45 b8             	mov    %eax,-0x48(%rbp)
    pid = fork();
    56cd:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    56d4:	00 00 00 
    56d7:	ff d0                	call   *%rax
    56d9:	89 45 e4             	mov    %eax,-0x1c(%rbp)
    if(pid < 0){
    56dc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    56e0:	79 19                	jns    56fb <sbrktest+0x449>
      failexit("fork");
    56e2:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    56e9:	00 00 00 
    56ec:	48 89 c7             	mov    %rax,%rdi
    56ef:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    56f6:	00 00 00 
    56f9:	ff d0                	call   *%rax
    }
    if(pid == 0){
    56fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%rbp)
    56ff:	75 51                	jne    5752 <sbrktest+0x4a0>
      printf(1, "oops could read %p = %c\n", a, *a);
    5701:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    5705:	0f b6 00             	movzbl (%rax),%eax
    5708:	0f be d0             	movsbl %al,%edx
    570b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    570f:	48 be f0 84 00 00 00 	movabs $0x84f0,%rsi
    5716:	00 00 00 
    5719:	89 d1                	mov    %edx,%ecx
    571b:	48 89 c2             	mov    %rax,%rdx
    571e:	bf 01 00 00 00       	mov    $0x1,%edi
    5723:	b8 00 00 00 00       	mov    $0x0,%eax
    5728:	49 b8 33 6a 00 00 00 	movabs $0x6a33,%r8
    572f:	00 00 00 
    5732:	41 ff d0             	call   *%r8
      kill(ppid);
    5735:	8b 45 b8             	mov    -0x48(%rbp),%eax
    5738:	89 c7                	mov    %eax,%edi
    573a:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    5741:	00 00 00 
    5744:	ff d0                	call   *%rax
      exit();
    5746:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    574d:	00 00 00 
    5750:	ff d0                	call   *%rax
    }
    wait();
    5752:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    5759:	00 00 00 
    575c:	ff d0                	call   *%rax
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+1000000); a += 100000){
    575e:	48 81 45 f8 a0 86 01 	addq   $0x186a0,-0x8(%rbp)
    5765:	00 
    5766:	48 b8 3f 42 0f 00 00 	movabs $0xffff8000000f423f,%rax
    576d:	80 ff ff 
    5770:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5774:	0f 83 44 ff ff ff    	jae    56be <sbrktest+0x40c>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    577a:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    577e:	48 89 c7             	mov    %rax,%rdi
    5781:	48 b8 66 67 00 00 00 	movabs $0x6766,%rax
    5788:	00 00 00 
    578b:	ff d0                	call   *%rax
    578d:	85 c0                	test   %eax,%eax
    578f:	74 19                	je     57aa <sbrktest+0x4f8>
    failexit("pipe()");
    5791:	48 b8 83 75 00 00 00 	movabs $0x7583,%rax
    5798:	00 00 00 
    579b:	48 89 c7             	mov    %rax,%rdi
    579e:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    57a5:	00 00 00 
    57a8:	ff d0                	call   *%rax
  }
  printf(1, "expecting failed sbrk()s:\n");
    57aa:	48 b8 09 85 00 00 00 	movabs $0x8509,%rax
    57b1:	00 00 00 
    57b4:	48 89 c6             	mov    %rax,%rsi
    57b7:	bf 01 00 00 00       	mov    $0x1,%edi
    57bc:	b8 00 00 00 00       	mov    $0x0,%eax
    57c1:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    57c8:	00 00 00 
    57cb:	ff d2                	call   *%rdx
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    57cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    57d4:	e9 e6 00 00 00       	jmp    58bf <sbrktest+0x60d>
    if((pids[i] = fork()) == 0){
    57d9:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    57e0:	00 00 00 
    57e3:	ff d0                	call   *%rax
    57e5:	8b 55 f4             	mov    -0xc(%rbp),%edx
    57e8:	48 63 d2             	movslq %edx,%rdx
    57eb:	89 44 95 80          	mov    %eax,-0x80(%rbp,%rdx,4)
    57ef:	8b 45 f4             	mov    -0xc(%rbp),%eax
    57f2:	48 98                	cltq
    57f4:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    57f8:	85 c0                	test   %eax,%eax
    57fa:	0f 85 8d 00 00 00    	jne    588d <sbrktest+0x5db>
      // allocate a lot of memory
      int ret = (int)(addr_t)sbrk(BIG - (addr_t)sbrk(0));
    5800:	bf 00 00 00 00       	mov    $0x0,%edi
    5805:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    580c:	00 00 00 
    580f:	ff d0                	call   *%rax
    5811:	48 89 c2             	mov    %rax,%rdx
    5814:	b8 00 00 40 06       	mov    $0x6400000,%eax
    5819:	48 29 d0             	sub    %rdx,%rax
    581c:	48 89 c7             	mov    %rax,%rdi
    581f:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5826:	00 00 00 
    5829:	ff d0                	call   *%rax
    582b:	89 45 bc             	mov    %eax,-0x44(%rbp)
      if(ret < 0)
    582e:	83 7d bc 00          	cmpl   $0x0,-0x44(%rbp)
    5832:	79 23                	jns    5857 <sbrktest+0x5a5>
        printf(1, "sbrk returned -1 as expected\n");
    5834:	48 b8 24 85 00 00 00 	movabs $0x8524,%rax
    583b:	00 00 00 
    583e:	48 89 c6             	mov    %rax,%rsi
    5841:	bf 01 00 00 00       	mov    $0x1,%edi
    5846:	b8 00 00 00 00       	mov    $0x0,%eax
    584b:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5852:	00 00 00 
    5855:	ff d2                	call   *%rdx
      write(fds[1], "x", 1);
    5857:	8b 45 ac             	mov    -0x54(%rbp),%eax
    585a:	48 b9 d6 75 00 00 00 	movabs $0x75d6,%rcx
    5861:	00 00 00 
    5864:	ba 01 00 00 00       	mov    $0x1,%edx
    5869:	48 89 ce             	mov    %rcx,%rsi
    586c:	89 c7                	mov    %eax,%edi
    586e:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    5875:	00 00 00 
    5878:	ff d0                	call   *%rax
      // sit around until killed
      for(;;)
        sleep(1000);
    587a:	bf e8 03 00 00       	mov    $0x3e8,%edi
    587f:	48 b8 36 68 00 00 00 	movabs $0x6836,%rax
    5886:	00 00 00 
    5889:	ff d0                	call   *%rax
    588b:	eb ed                	jmp    587a <sbrktest+0x5c8>
    }
    if(pids[i] != -1)
    588d:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5890:	48 98                	cltq
    5892:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5896:	83 f8 ff             	cmp    $0xffffffff,%eax
    5899:	74 20                	je     58bb <sbrktest+0x609>
      read(fds[0], &scratch, 1); // wait
    589b:	8b 45 a8             	mov    -0x58(%rbp),%eax
    589e:	48 8d 8d 7f ff ff ff 	lea    -0x81(%rbp),%rcx
    58a5:	ba 01 00 00 00       	mov    $0x1,%edx
    58aa:	48 89 ce             	mov    %rcx,%rsi
    58ad:	89 c7                	mov    %eax,%edi
    58af:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    58b6:	00 00 00 
    58b9:	ff d0                	call   *%rax
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    58bb:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    58bf:	8b 45 f4             	mov    -0xc(%rbp),%eax
    58c2:	83 f8 09             	cmp    $0x9,%eax
    58c5:	0f 86 0e ff ff ff    	jbe    57d9 <sbrktest+0x527>
  }

  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate one here
  c = sbrk(4096);
    58cb:	bf 00 10 00 00       	mov    $0x1000,%edi
    58d0:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    58d7:	00 00 00 
    58da:	ff d0                	call   *%rax
    58dc:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    58e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    58e7:	eb 38                	jmp    5921 <sbrktest+0x66f>
    if(pids[i] == -1)
    58e9:	8b 45 f4             	mov    -0xc(%rbp),%eax
    58ec:	48 98                	cltq
    58ee:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    58f2:	83 f8 ff             	cmp    $0xffffffff,%eax
    58f5:	74 25                	je     591c <sbrktest+0x66a>
      continue;
    kill(pids[i]);
    58f7:	8b 45 f4             	mov    -0xc(%rbp),%eax
    58fa:	48 98                	cltq
    58fc:	8b 44 85 80          	mov    -0x80(%rbp,%rax,4),%eax
    5900:	89 c7                	mov    %eax,%edi
    5902:	48 b8 9a 67 00 00 00 	movabs $0x679a,%rax
    5909:	00 00 00 
    590c:	ff d0                	call   *%rax
    wait();
    590e:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    5915:	00 00 00 
    5918:	ff d0                	call   *%rax
    591a:	eb 01                	jmp    591d <sbrktest+0x66b>
      continue;
    591c:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    591d:	83 45 f4 01          	addl   $0x1,-0xc(%rbp)
    5921:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5924:	83 f8 09             	cmp    $0x9,%eax
    5927:	76 c0                	jbe    58e9 <sbrktest+0x637>
  }
  if(c == (char*)0xffffffff){ // ?
    5929:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    592e:	48 39 45 d8          	cmp    %rax,-0x28(%rbp)
    5932:	75 19                	jne    594d <sbrktest+0x69b>
    failexit("failed sbrk leaked memory");
    5934:	48 b8 42 85 00 00 00 	movabs $0x8542,%rax
    593b:	00 00 00 
    593e:	48 89 c7             	mov    %rax,%rdi
    5941:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5948:	00 00 00 
    594b:	ff d0                	call   *%rax
  }

  if(sbrk(0) > oldbrk)
    594d:	bf 00 00 00 00       	mov    $0x0,%edi
    5952:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5959:	00 00 00 
    595c:	ff d0                	call   *%rax
    595e:	48 39 45 e8          	cmp    %rax,-0x18(%rbp)
    5962:	73 2a                	jae    598e <sbrktest+0x6dc>
    sbrk(-(sbrk(0) - oldbrk));
    5964:	bf 00 00 00 00       	mov    $0x0,%edi
    5969:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5970:	00 00 00 
    5973:	ff d0                	call   *%rax
    5975:	48 8b 55 e8          	mov    -0x18(%rbp),%rdx
    5979:	48 29 c2             	sub    %rax,%rdx
    597c:	48 89 d0             	mov    %rdx,%rax
    597f:	48 89 c7             	mov    %rax,%rdi
    5982:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    5989:	00 00 00 
    598c:	ff d0                	call   *%rax

  printf(1, "sbrk test OK\n");
    598e:	48 b8 5c 85 00 00 00 	movabs $0x855c,%rax
    5995:	00 00 00 
    5998:	48 89 c6             	mov    %rax,%rsi
    599b:	bf 01 00 00 00       	mov    $0x1,%edi
    59a0:	b8 00 00 00 00       	mov    $0x0,%eax
    59a5:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    59ac:	00 00 00 
    59af:	ff d2                	call   *%rdx
}
    59b1:	90                   	nop
    59b2:	c9                   	leave
    59b3:	c3                   	ret

00000000000059b4 <validatetest>:

void
validatetest(void)
{
    59b4:	55                   	push   %rbp
    59b5:	48 89 e5             	mov    %rsp,%rbp
    59b8:	48 83 ec 10          	sub    $0x10,%rsp
  int hi;
  addr_t p;

  printf(1, "validate test\n");
    59bc:	48 b8 6a 85 00 00 00 	movabs $0x856a,%rax
    59c3:	00 00 00 
    59c6:	48 89 c6             	mov    %rax,%rsi
    59c9:	bf 01 00 00 00       	mov    $0x1,%edi
    59ce:	b8 00 00 00 00       	mov    $0x0,%eax
    59d3:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    59da:	00 00 00 
    59dd:	ff d2                	call   *%rdx
  hi = 1100*1024;
    59df:	c7 45 f4 00 30 11 00 	movl   $0x113000,-0xc(%rbp)

  // first page not mapped
  for(p = 4096; p <= (uint)hi; p += 4096){
    59e6:	48 c7 45 f8 00 10 00 	movq   $0x1000,-0x8(%rbp)
    59ed:	00 
    59ee:	eb 46                	jmp    5a36 <validatetest+0x82>
    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    59f0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    59f4:	48 ba 79 85 00 00 00 	movabs $0x8579,%rdx
    59fb:	00 00 00 
    59fe:	48 89 c6             	mov    %rax,%rsi
    5a01:	48 89 d7             	mov    %rdx,%rdi
    5a04:	48 b8 e8 67 00 00 00 	movabs $0x67e8,%rax
    5a0b:	00 00 00 
    5a0e:	ff d0                	call   *%rax
    5a10:	83 f8 ff             	cmp    $0xffffffff,%eax
    5a13:	74 19                	je     5a2e <validatetest+0x7a>
      failexit("link should not succeed.");
    5a15:	48 b8 84 85 00 00 00 	movabs $0x8584,%rax
    5a1c:	00 00 00 
    5a1f:	48 89 c7             	mov    %rax,%rdi
    5a22:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5a29:	00 00 00 
    5a2c:	ff d0                	call   *%rax
  for(p = 4096; p <= (uint)hi; p += 4096){
    5a2e:	48 81 45 f8 00 10 00 	addq   $0x1000,-0x8(%rbp)
    5a35:	00 
    5a36:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5a39:	89 c0                	mov    %eax,%eax
    5a3b:	48 3b 45 f8          	cmp    -0x8(%rbp),%rax
    5a3f:	73 af                	jae    59f0 <validatetest+0x3c>
    }
  }

  printf(1, "validate ok\n");
    5a41:	48 b8 9d 85 00 00 00 	movabs $0x859d,%rax
    5a48:	00 00 00 
    5a4b:	48 89 c6             	mov    %rax,%rsi
    5a4e:	bf 01 00 00 00       	mov    $0x1,%edi
    5a53:	b8 00 00 00 00       	mov    $0x0,%eax
    5a58:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5a5f:	00 00 00 
    5a62:	ff d2                	call   *%rdx
}
    5a64:	90                   	nop
    5a65:	c9                   	leave
    5a66:	c3                   	ret

0000000000005a67 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    5a67:	55                   	push   %rbp
    5a68:	48 89 e5             	mov    %rsp,%rbp
    5a6b:	48 83 ec 10          	sub    $0x10,%rsp
  int i;

  printf(1, "bss test\n");
    5a6f:	48 b8 aa 85 00 00 00 	movabs $0x85aa,%rax
    5a76:	00 00 00 
    5a79:	48 89 c6             	mov    %rax,%rsi
    5a7c:	bf 01 00 00 00       	mov    $0x1,%edi
    5a81:	b8 00 00 00 00       	mov    $0x0,%eax
    5a86:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5a8d:	00 00 00 
    5a90:	ff d2                	call   *%rdx
  for(i = 0; i < sizeof(uninit); i++){
    5a92:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5a99:	eb 34                	jmp    5acf <bsstest+0x68>
    if(uninit[i] != '\0'){
    5a9b:	48 ba 60 a8 00 00 00 	movabs $0xa860,%rdx
    5aa2:	00 00 00 
    5aa5:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5aa8:	48 98                	cltq
    5aaa:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    5aae:	84 c0                	test   %al,%al
    5ab0:	74 19                	je     5acb <bsstest+0x64>
      failexit("bss test");
    5ab2:	48 b8 b4 85 00 00 00 	movabs $0x85b4,%rax
    5ab9:	00 00 00 
    5abc:	48 89 c7             	mov    %rax,%rdi
    5abf:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5ac6:	00 00 00 
    5ac9:	ff d0                	call   *%rax
  for(i = 0; i < sizeof(uninit); i++){
    5acb:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5acf:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5ad2:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    5ad7:	76 c2                	jbe    5a9b <bsstest+0x34>
    }
  }
  printf(1, "bss test ok\n");
    5ad9:	48 b8 bd 85 00 00 00 	movabs $0x85bd,%rax
    5ae0:	00 00 00 
    5ae3:	48 89 c6             	mov    %rax,%rsi
    5ae6:	bf 01 00 00 00       	mov    $0x1,%edi
    5aeb:	b8 00 00 00 00       	mov    $0x0,%eax
    5af0:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5af7:	00 00 00 
    5afa:	ff d2                	call   *%rdx
}
    5afc:	90                   	nop
    5afd:	c9                   	leave
    5afe:	c3                   	ret

0000000000005aff <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    5aff:	55                   	push   %rbp
    5b00:	48 89 e5             	mov    %rsp,%rbp
    5b03:	48 83 ec 10          	sub    $0x10,%rsp
  int pid, fd;

  unlink("bigarg-ok");
    5b07:	48 b8 ca 85 00 00 00 	movabs $0x85ca,%rax
    5b0e:	00 00 00 
    5b11:	48 89 c7             	mov    %rax,%rdi
    5b14:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    5b1b:	00 00 00 
    5b1e:	ff d0                	call   *%rax
  pid = fork();
    5b20:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    5b27:	00 00 00 
    5b2a:	ff d0                	call   *%rax
    5b2c:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid == 0){
    5b2f:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5b33:	0f 85 ef 00 00 00    	jne    5c28 <bigargtest+0x129>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    5b39:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    5b40:	eb 21                	jmp    5b63 <bigargtest+0x64>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    5b42:	48 ba 80 cf 00 00 00 	movabs $0xcf80,%rdx
    5b49:	00 00 00 
    5b4c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5b4f:	48 98                	cltq
    5b51:	48 b9 d8 85 00 00 00 	movabs $0x85d8,%rcx
    5b58:	00 00 00 
    5b5b:	48 89 0c c2          	mov    %rcx,(%rdx,%rax,8)
    for(i = 0; i < MAXARG-1; i++)
    5b5f:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5b63:	83 7d fc 1e          	cmpl   $0x1e,-0x4(%rbp)
    5b67:	7e d9                	jle    5b42 <bigargtest+0x43>
    args[MAXARG-1] = 0;
    5b69:	48 b8 80 cf 00 00 00 	movabs $0xcf80,%rax
    5b70:	00 00 00 
    5b73:	48 c7 80 f8 00 00 00 	movq   $0x0,0xf8(%rax)
    5b7a:	00 00 00 00 
    printf(1, "bigarg test\n");
    5b7e:	48 b8 b5 86 00 00 00 	movabs $0x86b5,%rax
    5b85:	00 00 00 
    5b88:	48 89 c6             	mov    %rax,%rsi
    5b8b:	bf 01 00 00 00       	mov    $0x1,%edi
    5b90:	b8 00 00 00 00       	mov    $0x0,%eax
    5b95:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5b9c:	00 00 00 
    5b9f:	ff d2                	call   *%rdx
    exec("echo", args);
    5ba1:	48 ba 80 cf 00 00 00 	movabs $0xcf80,%rdx
    5ba8:	00 00 00 
    5bab:	48 b8 58 71 00 00 00 	movabs $0x7158,%rax
    5bb2:	00 00 00 
    5bb5:	48 89 d6             	mov    %rdx,%rsi
    5bb8:	48 89 c7             	mov    %rax,%rdi
    5bbb:	48 b8 a7 67 00 00 00 	movabs $0x67a7,%rax
    5bc2:	00 00 00 
    5bc5:	ff d0                	call   *%rax
    printf(1, "bigarg test ok\n");
    5bc7:	48 b8 c2 86 00 00 00 	movabs $0x86c2,%rax
    5bce:	00 00 00 
    5bd1:	48 89 c6             	mov    %rax,%rsi
    5bd4:	bf 01 00 00 00       	mov    $0x1,%edi
    5bd9:	b8 00 00 00 00       	mov    $0x0,%eax
    5bde:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5be5:	00 00 00 
    5be8:	ff d2                	call   *%rdx
    fd = open("bigarg-ok", O_CREATE);
    5bea:	48 b8 ca 85 00 00 00 	movabs $0x85ca,%rax
    5bf1:	00 00 00 
    5bf4:	be 00 02 00 00       	mov    $0x200,%esi
    5bf9:	48 89 c7             	mov    %rax,%rdi
    5bfc:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    5c03:	00 00 00 
    5c06:	ff d0                	call   *%rax
    5c08:	89 45 f4             	mov    %eax,-0xc(%rbp)
    close(fd);
    5c0b:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5c0e:	89 c7                	mov    %eax,%edi
    5c10:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    5c17:	00 00 00 
    5c1a:	ff d0                	call   *%rax
    exit();
    5c1c:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    5c23:	00 00 00 
    5c26:	ff d0                	call   *%rax
  } else if(pid < 0){
    5c28:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    5c2c:	79 19                	jns    5c47 <bigargtest+0x148>
    failexit("bigargtest: fork");
    5c2e:	48 b8 d2 86 00 00 00 	movabs $0x86d2,%rax
    5c35:	00 00 00 
    5c38:	48 89 c7             	mov    %rax,%rdi
    5c3b:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5c42:	00 00 00 
    5c45:	ff d0                	call   *%rax
  }
  wait();
    5c47:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    5c4e:	00 00 00 
    5c51:	ff d0                	call   *%rax
  fd = open("bigarg-ok", 0);
    5c53:	48 b8 ca 85 00 00 00 	movabs $0x85ca,%rax
    5c5a:	00 00 00 
    5c5d:	be 00 00 00 00       	mov    $0x0,%esi
    5c62:	48 89 c7             	mov    %rax,%rdi
    5c65:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    5c6c:	00 00 00 
    5c6f:	ff d0                	call   *%rax
    5c71:	89 45 f4             	mov    %eax,-0xc(%rbp)
  if(fd < 0){
    5c74:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    5c78:	79 19                	jns    5c93 <bigargtest+0x194>
    failexit("bigarg test");
    5c7a:	48 b8 e3 86 00 00 00 	movabs $0x86e3,%rax
    5c81:	00 00 00 
    5c84:	48 89 c7             	mov    %rax,%rdi
    5c87:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    5c8e:	00 00 00 
    5c91:	ff d0                	call   *%rax
  }
  close(fd);
    5c93:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5c96:	89 c7                	mov    %eax,%edi
    5c98:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    5c9f:	00 00 00 
    5ca2:	ff d0                	call   *%rax
  unlink("bigarg-ok");
    5ca4:	48 b8 ca 85 00 00 00 	movabs $0x85ca,%rax
    5cab:	00 00 00 
    5cae:	48 89 c7             	mov    %rax,%rdi
    5cb1:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    5cb8:	00 00 00 
    5cbb:	ff d0                	call   *%rax
}
    5cbd:	90                   	nop
    5cbe:	c9                   	leave
    5cbf:	c3                   	ret

0000000000005cc0 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    5cc0:	55                   	push   %rbp
    5cc1:	48 89 e5             	mov    %rsp,%rbp
    5cc4:	48 83 ec 60          	sub    $0x60,%rsp
  int nfiles;
  int fsblocks = 0;
    5cc8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%rbp)

  printf(1, "fsfull test\n");
    5ccf:	48 b8 ef 86 00 00 00 	movabs $0x86ef,%rax
    5cd6:	00 00 00 
    5cd9:	48 89 c6             	mov    %rax,%rsi
    5cdc:	bf 01 00 00 00       	mov    $0x1,%edi
    5ce1:	b8 00 00 00 00       	mov    $0x0,%eax
    5ce6:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5ced:	00 00 00 
    5cf0:	ff d2                	call   *%rdx

  for(nfiles = 0; ; nfiles++){
    5cf2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    char name[64];
    name[0] = 'f';
    5cf9:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    5cfd:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5d00:	48 63 d0             	movslq %eax,%rdx
    5d03:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    5d0a:	48 c1 ea 20          	shr    $0x20,%rdx
    5d0e:	c1 fa 06             	sar    $0x6,%edx
    5d11:	c1 f8 1f             	sar    $0x1f,%eax
    5d14:	29 c2                	sub    %eax,%edx
    5d16:	89 d0                	mov    %edx,%eax
    5d18:	83 c0 30             	add    $0x30,%eax
    5d1b:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    5d1e:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5d21:	48 63 c2             	movslq %edx,%rax
    5d24:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    5d2b:	48 c1 e8 20          	shr    $0x20,%rax
    5d2f:	c1 f8 06             	sar    $0x6,%eax
    5d32:	89 d1                	mov    %edx,%ecx
    5d34:	c1 f9 1f             	sar    $0x1f,%ecx
    5d37:	29 c8                	sub    %ecx,%eax
    5d39:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    5d3f:	89 d0                	mov    %edx,%eax
    5d41:	29 c8                	sub    %ecx,%eax
    5d43:	48 63 d0             	movslq %eax,%rdx
    5d46:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    5d4d:	48 c1 ea 20          	shr    $0x20,%rdx
    5d51:	c1 fa 05             	sar    $0x5,%edx
    5d54:	c1 f8 1f             	sar    $0x1f,%eax
    5d57:	29 c2                	sub    %eax,%edx
    5d59:	89 d0                	mov    %edx,%eax
    5d5b:	83 c0 30             	add    $0x30,%eax
    5d5e:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    5d61:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5d64:	48 63 c2             	movslq %edx,%rax
    5d67:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    5d6e:	48 c1 e8 20          	shr    $0x20,%rax
    5d72:	c1 f8 05             	sar    $0x5,%eax
    5d75:	89 d1                	mov    %edx,%ecx
    5d77:	c1 f9 1f             	sar    $0x1f,%ecx
    5d7a:	29 c8                	sub    %ecx,%eax
    5d7c:	6b c8 64             	imul   $0x64,%eax,%ecx
    5d7f:	89 d0                	mov    %edx,%eax
    5d81:	29 c8                	sub    %ecx,%eax
    5d83:	48 63 d0             	movslq %eax,%rdx
    5d86:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    5d8d:	48 c1 ea 20          	shr    $0x20,%rdx
    5d91:	c1 fa 02             	sar    $0x2,%edx
    5d94:	c1 f8 1f             	sar    $0x1f,%eax
    5d97:	29 c2                	sub    %eax,%edx
    5d99:	89 d0                	mov    %edx,%eax
    5d9b:	83 c0 30             	add    $0x30,%eax
    5d9e:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    5da1:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5da4:	48 63 c2             	movslq %edx,%rax
    5da7:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    5dae:	48 c1 e8 20          	shr    $0x20,%rax
    5db2:	89 c1                	mov    %eax,%ecx
    5db4:	c1 f9 02             	sar    $0x2,%ecx
    5db7:	89 d0                	mov    %edx,%eax
    5db9:	c1 f8 1f             	sar    $0x1f,%eax
    5dbc:	29 c1                	sub    %eax,%ecx
    5dbe:	89 c8                	mov    %ecx,%eax
    5dc0:	c1 e0 02             	shl    $0x2,%eax
    5dc3:	01 c8                	add    %ecx,%eax
    5dc5:	01 c0                	add    %eax,%eax
    5dc7:	89 d1                	mov    %edx,%ecx
    5dc9:	29 c1                	sub    %eax,%ecx
    5dcb:	89 c8                	mov    %ecx,%eax
    5dcd:	83 c0 30             	add    $0x30,%eax
    5dd0:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    5dd3:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    printf(1, "writing %s\n", name);
    5dd7:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5ddb:	48 b9 fc 86 00 00 00 	movabs $0x86fc,%rcx
    5de2:	00 00 00 
    5de5:	48 89 c2             	mov    %rax,%rdx
    5de8:	48 89 ce             	mov    %rcx,%rsi
    5deb:	bf 01 00 00 00       	mov    $0x1,%edi
    5df0:	b8 00 00 00 00       	mov    $0x0,%eax
    5df5:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    5dfc:	00 00 00 
    5dff:	ff d1                	call   *%rcx
    int fd = open(name, O_CREATE|O_RDWR);
    5e01:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5e05:	be 02 02 00 00       	mov    $0x202,%esi
    5e0a:	48 89 c7             	mov    %rax,%rdi
    5e0d:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    5e14:	00 00 00 
    5e17:	ff d0                	call   *%rax
    5e19:	89 45 f0             	mov    %eax,-0x10(%rbp)
    if(fd < 0){
    5e1c:	83 7d f0 00          	cmpl   $0x0,-0x10(%rbp)
    5e20:	79 2f                	jns    5e51 <fsfull+0x191>
      printf(1, "open %s failed\n", name);
    5e22:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5e26:	48 b9 08 87 00 00 00 	movabs $0x8708,%rcx
    5e2d:	00 00 00 
    5e30:	48 89 c2             	mov    %rax,%rdx
    5e33:	48 89 ce             	mov    %rcx,%rsi
    5e36:	bf 01 00 00 00       	mov    $0x1,%edi
    5e3b:	b8 00 00 00 00       	mov    $0x0,%eax
    5e40:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    5e47:	00 00 00 
    5e4a:	ff d1                	call   *%rcx
      break;
    5e4c:	e9 8c 00 00 00       	jmp    5edd <fsfull+0x21d>
    }
    int total = 0;
    5e51:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
    while(1){
      int cc = write(fd, buf, 512);
    5e58:	48 b9 40 88 00 00 00 	movabs $0x8840,%rcx
    5e5f:	00 00 00 
    5e62:	8b 45 f0             	mov    -0x10(%rbp),%eax
    5e65:	ba 00 02 00 00       	mov    $0x200,%edx
    5e6a:	48 89 ce             	mov    %rcx,%rsi
    5e6d:	89 c7                	mov    %eax,%edi
    5e6f:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    5e76:	00 00 00 
    5e79:	ff d0                	call   *%rax
    5e7b:	89 45 ec             	mov    %eax,-0x14(%rbp)
      if(cc < 512)
    5e7e:	81 7d ec ff 01 00 00 	cmpl   $0x1ff,-0x14(%rbp)
    5e85:	7e 0c                	jle    5e93 <fsfull+0x1d3>
        break;
      total += cc;
    5e87:	8b 45 ec             	mov    -0x14(%rbp),%eax
    5e8a:	01 45 f4             	add    %eax,-0xc(%rbp)
      fsblocks++;
    5e8d:	83 45 f8 01          	addl   $0x1,-0x8(%rbp)
    while(1){
    5e91:	eb c5                	jmp    5e58 <fsfull+0x198>
        break;
    5e93:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    5e94:	8b 45 f4             	mov    -0xc(%rbp),%eax
    5e97:	48 b9 18 87 00 00 00 	movabs $0x8718,%rcx
    5e9e:	00 00 00 
    5ea1:	89 c2                	mov    %eax,%edx
    5ea3:	48 89 ce             	mov    %rcx,%rsi
    5ea6:	bf 01 00 00 00       	mov    $0x1,%edi
    5eab:	b8 00 00 00 00       	mov    $0x0,%eax
    5eb0:	48 b9 33 6a 00 00 00 	movabs $0x6a33,%rcx
    5eb7:	00 00 00 
    5eba:	ff d1                	call   *%rcx
    close(fd);
    5ebc:	8b 45 f0             	mov    -0x10(%rbp),%eax
    5ebf:	89 c7                	mov    %eax,%edi
    5ec1:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    5ec8:	00 00 00 
    5ecb:	ff d0                	call   *%rax
    if(total == 0)
    5ecd:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    5ed1:	74 09                	je     5edc <fsfull+0x21c>
  for(nfiles = 0; ; nfiles++){
    5ed3:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    5ed7:	e9 1d fe ff ff       	jmp    5cf9 <fsfull+0x39>
      break;
    5edc:	90                   	nop
  }

  while(nfiles >= 0){
    5edd:	e9 f5 00 00 00       	jmp    5fd7 <fsfull+0x317>
    char name[64];
    name[0] = 'f';
    5ee2:	c6 45 a0 66          	movb   $0x66,-0x60(%rbp)
    name[1] = '0' + nfiles / 1000;
    5ee6:	8b 45 fc             	mov    -0x4(%rbp),%eax
    5ee9:	48 63 d0             	movslq %eax,%rdx
    5eec:	48 69 d2 d3 4d 62 10 	imul   $0x10624dd3,%rdx,%rdx
    5ef3:	48 c1 ea 20          	shr    $0x20,%rdx
    5ef7:	c1 fa 06             	sar    $0x6,%edx
    5efa:	c1 f8 1f             	sar    $0x1f,%eax
    5efd:	29 c2                	sub    %eax,%edx
    5eff:	89 d0                	mov    %edx,%eax
    5f01:	83 c0 30             	add    $0x30,%eax
    5f04:	88 45 a1             	mov    %al,-0x5f(%rbp)
    name[2] = '0' + (nfiles % 1000) / 100;
    5f07:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5f0a:	48 63 c2             	movslq %edx,%rax
    5f0d:	48 69 c0 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rax
    5f14:	48 c1 e8 20          	shr    $0x20,%rax
    5f18:	c1 f8 06             	sar    $0x6,%eax
    5f1b:	89 d1                	mov    %edx,%ecx
    5f1d:	c1 f9 1f             	sar    $0x1f,%ecx
    5f20:	29 c8                	sub    %ecx,%eax
    5f22:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
    5f28:	89 d0                	mov    %edx,%eax
    5f2a:	29 c8                	sub    %ecx,%eax
    5f2c:	48 63 d0             	movslq %eax,%rdx
    5f2f:	48 69 d2 1f 85 eb 51 	imul   $0x51eb851f,%rdx,%rdx
    5f36:	48 c1 ea 20          	shr    $0x20,%rdx
    5f3a:	c1 fa 05             	sar    $0x5,%edx
    5f3d:	c1 f8 1f             	sar    $0x1f,%eax
    5f40:	29 c2                	sub    %eax,%edx
    5f42:	89 d0                	mov    %edx,%eax
    5f44:	83 c0 30             	add    $0x30,%eax
    5f47:	88 45 a2             	mov    %al,-0x5e(%rbp)
    name[3] = '0' + (nfiles % 100) / 10;
    5f4a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5f4d:	48 63 c2             	movslq %edx,%rax
    5f50:	48 69 c0 1f 85 eb 51 	imul   $0x51eb851f,%rax,%rax
    5f57:	48 c1 e8 20          	shr    $0x20,%rax
    5f5b:	c1 f8 05             	sar    $0x5,%eax
    5f5e:	89 d1                	mov    %edx,%ecx
    5f60:	c1 f9 1f             	sar    $0x1f,%ecx
    5f63:	29 c8                	sub    %ecx,%eax
    5f65:	6b c8 64             	imul   $0x64,%eax,%ecx
    5f68:	89 d0                	mov    %edx,%eax
    5f6a:	29 c8                	sub    %ecx,%eax
    5f6c:	48 63 d0             	movslq %eax,%rdx
    5f6f:	48 69 d2 67 66 66 66 	imul   $0x66666667,%rdx,%rdx
    5f76:	48 c1 ea 20          	shr    $0x20,%rdx
    5f7a:	c1 fa 02             	sar    $0x2,%edx
    5f7d:	c1 f8 1f             	sar    $0x1f,%eax
    5f80:	29 c2                	sub    %eax,%edx
    5f82:	89 d0                	mov    %edx,%eax
    5f84:	83 c0 30             	add    $0x30,%eax
    5f87:	88 45 a3             	mov    %al,-0x5d(%rbp)
    name[4] = '0' + (nfiles % 10);
    5f8a:	8b 55 fc             	mov    -0x4(%rbp),%edx
    5f8d:	48 63 c2             	movslq %edx,%rax
    5f90:	48 69 c0 67 66 66 66 	imul   $0x66666667,%rax,%rax
    5f97:	48 c1 e8 20          	shr    $0x20,%rax
    5f9b:	89 c1                	mov    %eax,%ecx
    5f9d:	c1 f9 02             	sar    $0x2,%ecx
    5fa0:	89 d0                	mov    %edx,%eax
    5fa2:	c1 f8 1f             	sar    $0x1f,%eax
    5fa5:	29 c1                	sub    %eax,%ecx
    5fa7:	89 c8                	mov    %ecx,%eax
    5fa9:	c1 e0 02             	shl    $0x2,%eax
    5fac:	01 c8                	add    %ecx,%eax
    5fae:	01 c0                	add    %eax,%eax
    5fb0:	89 d1                	mov    %edx,%ecx
    5fb2:	29 c1                	sub    %eax,%ecx
    5fb4:	89 c8                	mov    %ecx,%eax
    5fb6:	83 c0 30             	add    $0x30,%eax
    5fb9:	88 45 a4             	mov    %al,-0x5c(%rbp)
    name[5] = '\0';
    5fbc:	c6 45 a5 00          	movb   $0x0,-0x5b(%rbp)
    unlink(name);
    5fc0:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    5fc4:	48 89 c7             	mov    %rax,%rdi
    5fc7:	48 b8 ce 67 00 00 00 	movabs $0x67ce,%rax
    5fce:	00 00 00 
    5fd1:	ff d0                	call   *%rax
    nfiles--;
    5fd3:	83 6d fc 01          	subl   $0x1,-0x4(%rbp)
  while(nfiles >= 0){
    5fd7:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    5fdb:	0f 89 01 ff ff ff    	jns    5ee2 <fsfull+0x222>
  }

  printf(1, "fsfull test finished\n");
    5fe1:	48 b8 28 87 00 00 00 	movabs $0x8728,%rax
    5fe8:	00 00 00 
    5feb:	48 89 c6             	mov    %rax,%rsi
    5fee:	bf 01 00 00 00       	mov    $0x1,%edi
    5ff3:	b8 00 00 00 00       	mov    $0x0,%eax
    5ff8:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    5fff:	00 00 00 
    6002:	ff d2                	call   *%rdx
}
    6004:	90                   	nop
    6005:	c9                   	leave
    6006:	c3                   	ret

0000000000006007 <uio>:

void
uio()
{
    6007:	55                   	push   %rbp
    6008:	48 89 e5             	mov    %rsp,%rbp
    600b:	48 83 ec 10          	sub    $0x10,%rsp
  #define RTC_ADDR 0x70
  #define RTC_DATA 0x71

  ushort port = 0;
    600f:	66 c7 45 fe 00 00    	movw   $0x0,-0x2(%rbp)
  uchar val = 0;
    6015:	c6 45 fd 00          	movb   $0x0,-0x3(%rbp)
  int pid;

  printf(1, "uio test\n");
    6019:	48 b8 3e 87 00 00 00 	movabs $0x873e,%rax
    6020:	00 00 00 
    6023:	48 89 c6             	mov    %rax,%rsi
    6026:	bf 01 00 00 00       	mov    $0x1,%edi
    602b:	b8 00 00 00 00       	mov    $0x0,%eax
    6030:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    6037:	00 00 00 
    603a:	ff d2                	call   *%rdx
  pid = fork();
    603c:	48 b8 3f 67 00 00 00 	movabs $0x673f,%rax
    6043:	00 00 00 
    6046:	ff d0                	call   *%rax
    6048:	89 45 f8             	mov    %eax,-0x8(%rbp)
  if(pid == 0){
    604b:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    604f:	75 52                	jne    60a3 <uio+0x9c>
    port = RTC_ADDR;
    6051:	66 c7 45 fe 70 00    	movw   $0x70,-0x2(%rbp)
    val = 0x09;  /* year */
    6057:	c6 45 fd 09          	movb   $0x9,-0x3(%rbp)
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    605b:	0f b6 45 fd          	movzbl -0x3(%rbp),%eax
    605f:	0f b7 55 fe          	movzwl -0x2(%rbp),%edx
    6063:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    6064:	66 c7 45 fe 71 00    	movw   $0x71,-0x2(%rbp)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    606a:	0f b7 45 fe          	movzwl -0x2(%rbp),%eax
    606e:	89 c2                	mov    %eax,%edx
    6070:	ec                   	in     (%dx),%al
    6071:	88 45 fd             	mov    %al,-0x3(%rbp)
    printf(1, "uio test succeeded\n");
    6074:	48 b8 48 87 00 00 00 	movabs $0x8748,%rax
    607b:	00 00 00 
    607e:	48 89 c6             	mov    %rax,%rsi
    6081:	bf 01 00 00 00       	mov    $0x1,%edi
    6086:	b8 00 00 00 00       	mov    $0x0,%eax
    608b:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    6092:	00 00 00 
    6095:	ff d2                	call   *%rdx
    exit();
    6097:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    609e:	00 00 00 
    60a1:	ff d0                	call   *%rax
  } else if(pid < 0){
    60a3:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    60a7:	79 19                	jns    60c2 <uio+0xbb>
    failexit("fork");
    60a9:	48 b8 e7 71 00 00 00 	movabs $0x71e7,%rax
    60b0:	00 00 00 
    60b3:	48 89 c7             	mov    %rax,%rdi
    60b6:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    60bd:	00 00 00 
    60c0:	ff d0                	call   *%rax
  }
  wait();
    60c2:	48 b8 59 67 00 00 00 	movabs $0x6759,%rax
    60c9:	00 00 00 
    60cc:	ff d0                	call   *%rax
  printf(1, "uio test done\n");
    60ce:	48 b8 5c 87 00 00 00 	movabs $0x875c,%rax
    60d5:	00 00 00 
    60d8:	48 89 c6             	mov    %rax,%rsi
    60db:	bf 01 00 00 00       	mov    $0x1,%edi
    60e0:	b8 00 00 00 00       	mov    $0x0,%eax
    60e5:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    60ec:	00 00 00 
    60ef:	ff d2                	call   *%rdx
}
    60f1:	90                   	nop
    60f2:	c9                   	leave
    60f3:	c3                   	ret

00000000000060f4 <argptest>:

void argptest()
{
    60f4:	55                   	push   %rbp
    60f5:	48 89 e5             	mov    %rsp,%rbp
    60f8:	48 83 ec 10          	sub    $0x10,%rsp
  int fd;
  fd = open("init", O_RDONLY);
    60fc:	48 b8 6b 87 00 00 00 	movabs $0x876b,%rax
    6103:	00 00 00 
    6106:	be 00 00 00 00       	mov    $0x0,%esi
    610b:	48 89 c7             	mov    %rax,%rdi
    610e:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    6115:	00 00 00 
    6118:	ff d0                	call   *%rax
    611a:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if (fd < 0) {
    611d:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    6121:	79 19                	jns    613c <argptest+0x48>
    failexit("open");
    6123:	48 b8 70 87 00 00 00 	movabs $0x8770,%rax
    612a:	00 00 00 
    612d:	48 89 c7             	mov    %rax,%rdi
    6130:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    6137:	00 00 00 
    613a:	ff d0                	call   *%rax
  }
  read(fd, sbrk(0) - 1, -1);
    613c:	bf 00 00 00 00       	mov    $0x0,%edi
    6141:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    6148:	00 00 00 
    614b:	ff d0                	call   *%rax
    614d:	48 8d 48 ff          	lea    -0x1(%rax),%rcx
    6151:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6154:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    6159:	48 89 ce             	mov    %rcx,%rsi
    615c:	89 c7                	mov    %eax,%edi
    615e:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    6165:	00 00 00 
    6168:	ff d0                	call   *%rax
  close(fd);
    616a:	8b 45 fc             	mov    -0x4(%rbp),%eax
    616d:	89 c7                	mov    %eax,%edi
    616f:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    6176:	00 00 00 
    6179:	ff d0                	call   *%rax
  printf(1, "arg test passed\n");
    617b:	48 b8 75 87 00 00 00 	movabs $0x8775,%rax
    6182:	00 00 00 
    6185:	48 89 c6             	mov    %rax,%rsi
    6188:	bf 01 00 00 00       	mov    $0x1,%edi
    618d:	b8 00 00 00 00       	mov    $0x0,%eax
    6192:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    6199:	00 00 00 
    619c:	ff d2                	call   *%rdx
}
    619e:	90                   	nop
    619f:	c9                   	leave
    61a0:	c3                   	ret

00000000000061a1 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    61a1:	55                   	push   %rbp
    61a2:	48 89 e5             	mov    %rsp,%rbp
  randstate = randstate * 1664525 + 1013904223;
    61a5:	48 b8 08 88 00 00 00 	movabs $0x8808,%rax
    61ac:	00 00 00 
    61af:	48 8b 00             	mov    (%rax),%rax
    61b2:	48 69 c0 0d 66 19 00 	imul   $0x19660d,%rax,%rax
    61b9:	48 8d 90 5f f3 6e 3c 	lea    0x3c6ef35f(%rax),%rdx
    61c0:	48 b8 08 88 00 00 00 	movabs $0x8808,%rax
    61c7:	00 00 00 
    61ca:	48 89 10             	mov    %rdx,(%rax)
  return randstate;
    61cd:	48 b8 08 88 00 00 00 	movabs $0x8808,%rax
    61d4:	00 00 00 
    61d7:	48 8b 00             	mov    (%rax),%rax
}
    61da:	5d                   	pop    %rbp
    61db:	c3                   	ret

00000000000061dc <main>:

int
main(int argc, char *argv[])
{
    61dc:	55                   	push   %rbp
    61dd:	48 89 e5             	mov    %rsp,%rbp
    61e0:	48 83 ec 10          	sub    $0x10,%rsp
    61e4:	89 7d fc             	mov    %edi,-0x4(%rbp)
    61e7:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  printf(1, "usertests starting\n");
    61eb:	48 b8 86 87 00 00 00 	movabs $0x8786,%rax
    61f2:	00 00 00 
    61f5:	48 89 c6             	mov    %rax,%rsi
    61f8:	bf 01 00 00 00       	mov    $0x1,%edi
    61fd:	b8 00 00 00 00       	mov    $0x0,%eax
    6202:	48 ba 33 6a 00 00 00 	movabs $0x6a33,%rdx
    6209:	00 00 00 
    620c:	ff d2                	call   *%rdx

  if(open("usertests.ran", 0) >= 0){
    620e:	48 b8 9a 87 00 00 00 	movabs $0x879a,%rax
    6215:	00 00 00 
    6218:	be 00 00 00 00       	mov    $0x0,%esi
    621d:	48 89 c7             	mov    %rax,%rdi
    6220:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    6227:	00 00 00 
    622a:	ff d0                	call   *%rax
    622c:	85 c0                	test   %eax,%eax
    622e:	78 19                	js     6249 <main+0x6d>
    failexit("already ran user tests -- rebuild fs.img");
    6230:	48 b8 a8 87 00 00 00 	movabs $0x87a8,%rax
    6237:	00 00 00 
    623a:	48 89 c7             	mov    %rax,%rdi
    623d:	48 b8 00 10 00 00 00 	movabs $0x1000,%rax
    6244:	00 00 00 
    6247:	ff d0                	call   *%rax
  }
  close(open("usertests.ran", O_CREATE));
    6249:	48 b8 9a 87 00 00 00 	movabs $0x879a,%rax
    6250:	00 00 00 
    6253:	be 00 02 00 00       	mov    $0x200,%esi
    6258:	48 89 c7             	mov    %rax,%rdi
    625b:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    6262:	00 00 00 
    6265:	ff d0                	call   *%rax
    6267:	89 c7                	mov    %eax,%edi
    6269:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    6270:	00 00 00 
    6273:	ff d0                	call   *%rax

  argptest();
    6275:	48 b8 f4 60 00 00 00 	movabs $0x60f4,%rax
    627c:	00 00 00 
    627f:	ff d0                	call   *%rax
  createdelete();
    6281:	48 b8 aa 2a 00 00 00 	movabs $0x2aaa,%rax
    6288:	00 00 00 
    628b:	ff d0                	call   *%rax
  linkunlink();
    628d:	48 b8 25 38 00 00 00 	movabs $0x3825,%rax
    6294:	00 00 00 
    6297:	ff d0                	call   *%rax
  concreate();
    6299:	48 b8 30 33 00 00 00 	movabs $0x3330,%rax
    62a0:	00 00 00 
    62a3:	ff d0                	call   *%rax
  fourfiles();
    62a5:	48 b8 80 27 00 00 00 	movabs $0x2780,%rax
    62ac:	00 00 00 
    62af:	ff d0                	call   *%rax
  sharedfd();
    62b1:	48 b8 cf 24 00 00 00 	movabs $0x24cf,%rax
    62b8:	00 00 00 
    62bb:	ff d0                	call   *%rax

  bigargtest();
    62bd:	48 b8 ff 5a 00 00 00 	movabs $0x5aff,%rax
    62c4:	00 00 00 
    62c7:	ff d0                	call   *%rax
  bigwrite();
    62c9:	48 b8 1b 45 00 00 00 	movabs $0x451b,%rax
    62d0:	00 00 00 
    62d3:	ff d0                	call   *%rax
  bigargtest();
    62d5:	48 b8 ff 5a 00 00 00 	movabs $0x5aff,%rax
    62dc:	00 00 00 
    62df:	ff d0                	call   *%rax
  bsstest();
    62e1:	48 b8 67 5a 00 00 00 	movabs $0x5a67,%rax
    62e8:	00 00 00 
    62eb:	ff d0                	call   *%rax
  sbrktest();
    62ed:	48 b8 b2 52 00 00 00 	movabs $0x52b2,%rax
    62f4:	00 00 00 
    62f7:	ff d0                	call   *%rax
  validatetest();
    62f9:	48 b8 b4 59 00 00 00 	movabs $0x59b4,%rax
    6300:	00 00 00 
    6303:	ff d0                	call   *%rax

  opentest();
    6305:	48 b8 04 14 00 00 00 	movabs $0x1404,%rax
    630c:	00 00 00 
    630f:	ff d0                	call   *%rax
  writetest();
    6311:	48 b8 e6 14 00 00 00 	movabs $0x14e6,%rax
    6318:	00 00 00 
    631b:	ff d0                	call   *%rax
  writetest1();
    631d:	48 b8 35 17 00 00 00 	movabs $0x1735,%rax
    6324:	00 00 00 
    6327:	ff d0                	call   *%rax
  createtest();
    6329:	48 b8 df 19 00 00 00 	movabs $0x19df,%rax
    6330:	00 00 00 
    6333:	ff d0                	call   *%rax

  openiputtest();
    6335:	48 b8 aa 12 00 00 00 	movabs $0x12aa,%rax
    633c:	00 00 00 
    633f:	ff d0                	call   *%rax
  exitiputtest();
    6341:	48 b8 67 11 00 00 00 	movabs $0x1167,%rax
    6348:	00 00 00 
    634b:	ff d0                	call   *%rax
  iputtest();
    634d:	48 b8 42 10 00 00 00 	movabs $0x1042,%rax
    6354:	00 00 00 
    6357:	ff d0                	call   *%rax

  mem();
    6359:	48 b8 44 23 00 00 00 	movabs $0x2344,%rax
    6360:	00 00 00 
    6363:	ff d0                	call   *%rax
  pipe1();
    6365:	48 b8 ee 1d 00 00 00 	movabs $0x1dee,%rax
    636c:	00 00 00 
    636f:	ff d0                	call   *%rax
  preempt();
    6371:	48 b8 54 20 00 00 00 	movabs $0x2054,%rax
    6378:	00 00 00 
    637b:	ff d0                	call   *%rax
  exitwait();
    637d:	48 b8 7b 22 00 00 00 	movabs $0x227b,%rax
    6384:	00 00 00 
    6387:	ff d0                	call   *%rax
  nullptrtest();
    6389:	48 b8 03 1d 00 00 00 	movabs $0x1d03,%rax
    6390:	00 00 00 
    6393:	ff d0                	call   *%rax

  rmdot();
    6395:	48 b8 fc 4a 00 00 00 	movabs $0x4afc,%rax
    639c:	00 00 00 
    639f:	ff d0                	call   *%rax
  fourteen();
    63a1:	48 b8 31 49 00 00 00 	movabs $0x4931,%rax
    63a8:	00 00 00 
    63ab:	ff d0                	call   *%rax
  bigfile();
    63ad:	48 b8 85 46 00 00 00 	movabs $0x4685,%rax
    63b4:	00 00 00 
    63b7:	ff d0                	call   *%rax
  subdir();
    63b9:	48 b8 af 3b 00 00 00 	movabs $0x3baf,%rax
    63c0:	00 00 00 
    63c3:	ff d0                	call   *%rax
  linktest();
    63c5:	48 b8 10 30 00 00 00 	movabs $0x3010,%rax
    63cc:	00 00 00 
    63cf:	ff d0                	call   *%rax
  unlinkread();
    63d1:	48 b8 aa 2d 00 00 00 	movabs $0x2daa,%rax
    63d8:	00 00 00 
    63db:	ff d0                	call   *%rax
  dirfile();
    63dd:	48 b8 f9 4c 00 00 00 	movabs $0x4cf9,%rax
    63e4:	00 00 00 
    63e7:	ff d0                	call   *%rax
  iref();
    63e9:	48 b8 e8 4f 00 00 00 	movabs $0x4fe8,%rax
    63f0:	00 00 00 
    63f3:	ff d0                	call   *%rax
  forktest();
    63f5:	48 b8 a0 51 00 00 00 	movabs $0x51a0,%rax
    63fc:	00 00 00 
    63ff:	ff d0                	call   *%rax
  bigdir(); // slow
    6401:	48 b8 d6 39 00 00 00 	movabs $0x39d6,%rax
    6408:	00 00 00 
    640b:	ff d0                	call   *%rax
  uio();
    640d:	48 b8 07 60 00 00 00 	movabs $0x6007,%rax
    6414:	00 00 00 
    6417:	ff d0                	call   *%rax

  exectest(); // will exit
    6419:	48 b8 73 1c 00 00 00 	movabs $0x1c73,%rax
    6420:	00 00 00 
    6423:	ff d0                	call   *%rax

  exit();
    6425:	48 b8 4c 67 00 00 00 	movabs $0x674c,%rax
    642c:	00 00 00 
    642f:	ff d0                	call   *%rax

0000000000006431 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    6431:	55                   	push   %rbp
    6432:	48 89 e5             	mov    %rsp,%rbp
    6435:	48 83 ec 10          	sub    $0x10,%rsp
    6439:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    643d:	89 75 f4             	mov    %esi,-0xc(%rbp)
    6440:	89 55 f0             	mov    %edx,-0x10(%rbp)
  asm volatile("cld; rep stosb" :
    6443:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    6447:	8b 55 f0             	mov    -0x10(%rbp),%edx
    644a:	8b 45 f4             	mov    -0xc(%rbp),%eax
    644d:	48 89 ce             	mov    %rcx,%rsi
    6450:	48 89 f7             	mov    %rsi,%rdi
    6453:	89 d1                	mov    %edx,%ecx
    6455:	fc                   	cld
    6456:	f3 aa                	rep stos %al,(%rdi)
    6458:	89 ca                	mov    %ecx,%edx
    645a:	48 89 fe             	mov    %rdi,%rsi
    645d:	48 89 75 f8          	mov    %rsi,-0x8(%rbp)
    6461:	89 55 f0             	mov    %edx,-0x10(%rbp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    6464:	90                   	nop
    6465:	c9                   	leave
    6466:	c3                   	ret

0000000000006467 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    6467:	55                   	push   %rbp
    6468:	48 89 e5             	mov    %rsp,%rbp
    646b:	48 83 ec 20          	sub    $0x20,%rsp
    646f:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    6473:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  char *os;

  os = s;
    6477:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    647b:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  while((*s++ = *t++) != 0)
    647f:	90                   	nop
    6480:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    6484:	48 8d 42 01          	lea    0x1(%rdx),%rax
    6488:	48 89 45 e0          	mov    %rax,-0x20(%rbp)
    648c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6490:	48 8d 48 01          	lea    0x1(%rax),%rcx
    6494:	48 89 4d e8          	mov    %rcx,-0x18(%rbp)
    6498:	0f b6 12             	movzbl (%rdx),%edx
    649b:	88 10                	mov    %dl,(%rax)
    649d:	0f b6 00             	movzbl (%rax),%eax
    64a0:	84 c0                	test   %al,%al
    64a2:	75 dc                	jne    6480 <strcpy+0x19>
    ;
  return os;
    64a4:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    64a8:	c9                   	leave
    64a9:	c3                   	ret

00000000000064aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
    64aa:	55                   	push   %rbp
    64ab:	48 89 e5             	mov    %rsp,%rbp
    64ae:	48 83 ec 10          	sub    $0x10,%rsp
    64b2:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    64b6:	48 89 75 f0          	mov    %rsi,-0x10(%rbp)
  while(*p && *p == *q)
    64ba:	eb 0a                	jmp    64c6 <strcmp+0x1c>
    p++, q++;
    64bc:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    64c1:	48 83 45 f0 01       	addq   $0x1,-0x10(%rbp)
  while(*p && *p == *q)
    64c6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    64ca:	0f b6 00             	movzbl (%rax),%eax
    64cd:	84 c0                	test   %al,%al
    64cf:	74 12                	je     64e3 <strcmp+0x39>
    64d1:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    64d5:	0f b6 10             	movzbl (%rax),%edx
    64d8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    64dc:	0f b6 00             	movzbl (%rax),%eax
    64df:	38 c2                	cmp    %al,%dl
    64e1:	74 d9                	je     64bc <strcmp+0x12>
  return (uchar)*p - (uchar)*q;
    64e3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    64e7:	0f b6 00             	movzbl (%rax),%eax
    64ea:	0f b6 d0             	movzbl %al,%edx
    64ed:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    64f1:	0f b6 00             	movzbl (%rax),%eax
    64f4:	0f b6 c0             	movzbl %al,%eax
    64f7:	29 c2                	sub    %eax,%edx
    64f9:	89 d0                	mov    %edx,%eax
}
    64fb:	c9                   	leave
    64fc:	c3                   	ret

00000000000064fd <strlen>:

uint
strlen(char *s)
{
    64fd:	55                   	push   %rbp
    64fe:	48 89 e5             	mov    %rsp,%rbp
    6501:	48 83 ec 18          	sub    $0x18,%rsp
    6505:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  for(n = 0; s[n]; n++)
    6509:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    6510:	eb 04                	jmp    6516 <strlen+0x19>
    6512:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    6516:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6519:	48 63 d0             	movslq %eax,%rdx
    651c:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6520:	48 01 d0             	add    %rdx,%rax
    6523:	0f b6 00             	movzbl (%rax),%eax
    6526:	84 c0                	test   %al,%al
    6528:	75 e8                	jne    6512 <strlen+0x15>
    ;
  return n;
    652a:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    652d:	c9                   	leave
    652e:	c3                   	ret

000000000000652f <memset>:

void*
memset(void *dst, int c, uint n)
{
    652f:	55                   	push   %rbp
    6530:	48 89 e5             	mov    %rsp,%rbp
    6533:	48 83 ec 10          	sub    $0x10,%rsp
    6537:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    653b:	89 75 f4             	mov    %esi,-0xc(%rbp)
    653e:	89 55 f0             	mov    %edx,-0x10(%rbp)
  stosb(dst, c, n);
    6541:	8b 55 f0             	mov    -0x10(%rbp),%edx
    6544:	8b 4d f4             	mov    -0xc(%rbp),%ecx
    6547:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    654b:	89 ce                	mov    %ecx,%esi
    654d:	48 89 c7             	mov    %rax,%rdi
    6550:	48 b8 31 64 00 00 00 	movabs $0x6431,%rax
    6557:	00 00 00 
    655a:	ff d0                	call   *%rax
  return dst;
    655c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
}
    6560:	c9                   	leave
    6561:	c3                   	ret

0000000000006562 <strchr>:

char*
strchr(const char *s, char c)
{
    6562:	55                   	push   %rbp
    6563:	48 89 e5             	mov    %rsp,%rbp
    6566:	48 83 ec 10          	sub    $0x10,%rsp
    656a:	48 89 7d f8          	mov    %rdi,-0x8(%rbp)
    656e:	89 f0                	mov    %esi,%eax
    6570:	88 45 f4             	mov    %al,-0xc(%rbp)
  for(; *s; s++)
    6573:	eb 17                	jmp    658c <strchr+0x2a>
    if(*s == c)
    6575:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6579:	0f b6 00             	movzbl (%rax),%eax
    657c:	38 45 f4             	cmp    %al,-0xc(%rbp)
    657f:	75 06                	jne    6587 <strchr+0x25>
      return (char*)s;
    6581:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6585:	eb 15                	jmp    659c <strchr+0x3a>
  for(; *s; s++)
    6587:	48 83 45 f8 01       	addq   $0x1,-0x8(%rbp)
    658c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6590:	0f b6 00             	movzbl (%rax),%eax
    6593:	84 c0                	test   %al,%al
    6595:	75 de                	jne    6575 <strchr+0x13>
  return 0;
    6597:	b8 00 00 00 00       	mov    $0x0,%eax
}
    659c:	c9                   	leave
    659d:	c3                   	ret

000000000000659e <gets>:

char*
gets(char *buf, int max)
{
    659e:	55                   	push   %rbp
    659f:	48 89 e5             	mov    %rsp,%rbp
    65a2:	48 83 ec 20          	sub    $0x20,%rsp
    65a6:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    65aa:	89 75 e4             	mov    %esi,-0x1c(%rbp)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    65ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    65b4:	eb 4f                	jmp    6605 <gets+0x67>
    cc = read(0, &c, 1);
    65b6:	48 8d 45 f7          	lea    -0x9(%rbp),%rax
    65ba:	ba 01 00 00 00       	mov    $0x1,%edx
    65bf:	48 89 c6             	mov    %rax,%rsi
    65c2:	bf 00 00 00 00       	mov    $0x0,%edi
    65c7:	48 b8 73 67 00 00 00 	movabs $0x6773,%rax
    65ce:	00 00 00 
    65d1:	ff d0                	call   *%rax
    65d3:	89 45 f8             	mov    %eax,-0x8(%rbp)
    if(cc < 1)
    65d6:	83 7d f8 00          	cmpl   $0x0,-0x8(%rbp)
    65da:	7e 36                	jle    6612 <gets+0x74>
      break;
    buf[i++] = c;
    65dc:	8b 45 fc             	mov    -0x4(%rbp),%eax
    65df:	8d 50 01             	lea    0x1(%rax),%edx
    65e2:	89 55 fc             	mov    %edx,-0x4(%rbp)
    65e5:	48 63 d0             	movslq %eax,%rdx
    65e8:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    65ec:	48 01 c2             	add    %rax,%rdx
    65ef:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    65f3:	88 02                	mov    %al,(%rdx)
    if(c == '\n' || c == '\r')
    65f5:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    65f9:	3c 0a                	cmp    $0xa,%al
    65fb:	74 16                	je     6613 <gets+0x75>
    65fd:	0f b6 45 f7          	movzbl -0x9(%rbp),%eax
    6601:	3c 0d                	cmp    $0xd,%al
    6603:	74 0e                	je     6613 <gets+0x75>
  for(i=0; i+1 < max; ){
    6605:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6608:	83 c0 01             	add    $0x1,%eax
    660b:	39 45 e4             	cmp    %eax,-0x1c(%rbp)
    660e:	7f a6                	jg     65b6 <gets+0x18>
    6610:	eb 01                	jmp    6613 <gets+0x75>
      break;
    6612:	90                   	nop
      break;
  }
  buf[i] = '\0';
    6613:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6616:	48 63 d0             	movslq %eax,%rdx
    6619:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    661d:	48 01 d0             	add    %rdx,%rax
    6620:	c6 00 00             	movb   $0x0,(%rax)
  return buf;
    6623:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    6627:	c9                   	leave
    6628:	c3                   	ret

0000000000006629 <stat>:

int
stat(char *n, struct stat *st)
{
    6629:	55                   	push   %rbp
    662a:	48 89 e5             	mov    %rsp,%rbp
    662d:	48 83 ec 20          	sub    $0x20,%rsp
    6631:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    6635:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    6639:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    663d:	be 00 00 00 00       	mov    $0x0,%esi
    6642:	48 89 c7             	mov    %rax,%rdi
    6645:	48 b8 b4 67 00 00 00 	movabs $0x67b4,%rax
    664c:	00 00 00 
    664f:	ff d0                	call   *%rax
    6651:	89 45 fc             	mov    %eax,-0x4(%rbp)
  if(fd < 0)
    6654:	83 7d fc 00          	cmpl   $0x0,-0x4(%rbp)
    6658:	79 07                	jns    6661 <stat+0x38>
    return -1;
    665a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    665f:	eb 2f                	jmp    6690 <stat+0x67>
  r = fstat(fd, st);
    6661:	48 8b 55 e0          	mov    -0x20(%rbp),%rdx
    6665:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6668:	48 89 d6             	mov    %rdx,%rsi
    666b:	89 c7                	mov    %eax,%edi
    666d:	48 b8 db 67 00 00 00 	movabs $0x67db,%rax
    6674:	00 00 00 
    6677:	ff d0                	call   *%rax
    6679:	89 45 f8             	mov    %eax,-0x8(%rbp)
  close(fd);
    667c:	8b 45 fc             	mov    -0x4(%rbp),%eax
    667f:	89 c7                	mov    %eax,%edi
    6681:	48 b8 8d 67 00 00 00 	movabs $0x678d,%rax
    6688:	00 00 00 
    668b:	ff d0                	call   *%rax
  return r;
    668d:	8b 45 f8             	mov    -0x8(%rbp),%eax
}
    6690:	c9                   	leave
    6691:	c3                   	ret

0000000000006692 <atoi>:

int
atoi(const char *s)
{
    6692:	55                   	push   %rbp
    6693:	48 89 e5             	mov    %rsp,%rbp
    6696:	48 83 ec 18          	sub    $0x18,%rsp
    669a:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  int n;

  n = 0;
    669e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    66a5:	eb 28                	jmp    66cf <atoi+0x3d>
    n = n*10 + *s++ - '0';
    66a7:	8b 55 fc             	mov    -0x4(%rbp),%edx
    66aa:	89 d0                	mov    %edx,%eax
    66ac:	c1 e0 02             	shl    $0x2,%eax
    66af:	01 d0                	add    %edx,%eax
    66b1:	01 c0                	add    %eax,%eax
    66b3:	89 c1                	mov    %eax,%ecx
    66b5:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    66b9:	48 8d 50 01          	lea    0x1(%rax),%rdx
    66bd:	48 89 55 e8          	mov    %rdx,-0x18(%rbp)
    66c1:	0f b6 00             	movzbl (%rax),%eax
    66c4:	0f be c0             	movsbl %al,%eax
    66c7:	01 c8                	add    %ecx,%eax
    66c9:	83 e8 30             	sub    $0x30,%eax
    66cc:	89 45 fc             	mov    %eax,-0x4(%rbp)
  while('0' <= *s && *s <= '9')
    66cf:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    66d3:	0f b6 00             	movzbl (%rax),%eax
    66d6:	3c 2f                	cmp    $0x2f,%al
    66d8:	7e 0b                	jle    66e5 <atoi+0x53>
    66da:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    66de:	0f b6 00             	movzbl (%rax),%eax
    66e1:	3c 39                	cmp    $0x39,%al
    66e3:	7e c2                	jle    66a7 <atoi+0x15>
  return n;
    66e5:	8b 45 fc             	mov    -0x4(%rbp),%eax
}
    66e8:	c9                   	leave
    66e9:	c3                   	ret

00000000000066ea <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    66ea:	55                   	push   %rbp
    66eb:	48 89 e5             	mov    %rsp,%rbp
    66ee:	48 83 ec 28          	sub    $0x28,%rsp
    66f2:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
    66f6:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    66fa:	89 55 dc             	mov    %edx,-0x24(%rbp)
  char *dst, *src;

  dst = vdst;
    66fd:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6701:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  src = vsrc;
    6705:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    6709:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  while(n-- > 0)
    670d:	eb 1d                	jmp    672c <memmove+0x42>
    *dst++ = *src++;
    670f:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    6713:	48 8d 42 01          	lea    0x1(%rdx),%rax
    6717:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    671b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    671f:	48 8d 48 01          	lea    0x1(%rax),%rcx
    6723:	48 89 4d f8          	mov    %rcx,-0x8(%rbp)
    6727:	0f b6 12             	movzbl (%rdx),%edx
    672a:	88 10                	mov    %dl,(%rax)
  while(n-- > 0)
    672c:	8b 45 dc             	mov    -0x24(%rbp),%eax
    672f:	8d 50 ff             	lea    -0x1(%rax),%edx
    6732:	89 55 dc             	mov    %edx,-0x24(%rbp)
    6735:	85 c0                	test   %eax,%eax
    6737:	7f d6                	jg     670f <memmove+0x25>
  return vdst;
    6739:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
}
    673d:	c9                   	leave
    673e:	c3                   	ret

000000000000673f <fork>:
    mov $SYS_ ## name, %rax; \
    mov %rcx, %r10 ;\
    syscall		  ;\
    ret

SYSCALL(fork)
    673f:	48 c7 c0 01 00 00 00 	mov    $0x1,%rax
    6746:	49 89 ca             	mov    %rcx,%r10
    6749:	0f 05                	syscall
    674b:	c3                   	ret

000000000000674c <exit>:
SYSCALL(exit)
    674c:	48 c7 c0 02 00 00 00 	mov    $0x2,%rax
    6753:	49 89 ca             	mov    %rcx,%r10
    6756:	0f 05                	syscall
    6758:	c3                   	ret

0000000000006759 <wait>:
SYSCALL(wait)
    6759:	48 c7 c0 03 00 00 00 	mov    $0x3,%rax
    6760:	49 89 ca             	mov    %rcx,%r10
    6763:	0f 05                	syscall
    6765:	c3                   	ret

0000000000006766 <pipe>:
SYSCALL(pipe)
    6766:	48 c7 c0 04 00 00 00 	mov    $0x4,%rax
    676d:	49 89 ca             	mov    %rcx,%r10
    6770:	0f 05                	syscall
    6772:	c3                   	ret

0000000000006773 <read>:
SYSCALL(read)
    6773:	48 c7 c0 05 00 00 00 	mov    $0x5,%rax
    677a:	49 89 ca             	mov    %rcx,%r10
    677d:	0f 05                	syscall
    677f:	c3                   	ret

0000000000006780 <write>:
SYSCALL(write)
    6780:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
    6787:	49 89 ca             	mov    %rcx,%r10
    678a:	0f 05                	syscall
    678c:	c3                   	ret

000000000000678d <close>:
SYSCALL(close)
    678d:	48 c7 c0 15 00 00 00 	mov    $0x15,%rax
    6794:	49 89 ca             	mov    %rcx,%r10
    6797:	0f 05                	syscall
    6799:	c3                   	ret

000000000000679a <kill>:
SYSCALL(kill)
    679a:	48 c7 c0 06 00 00 00 	mov    $0x6,%rax
    67a1:	49 89 ca             	mov    %rcx,%r10
    67a4:	0f 05                	syscall
    67a6:	c3                   	ret

00000000000067a7 <exec>:
SYSCALL(exec)
    67a7:	48 c7 c0 07 00 00 00 	mov    $0x7,%rax
    67ae:	49 89 ca             	mov    %rcx,%r10
    67b1:	0f 05                	syscall
    67b3:	c3                   	ret

00000000000067b4 <open>:
SYSCALL(open)
    67b4:	48 c7 c0 0f 00 00 00 	mov    $0xf,%rax
    67bb:	49 89 ca             	mov    %rcx,%r10
    67be:	0f 05                	syscall
    67c0:	c3                   	ret

00000000000067c1 <mknod>:
SYSCALL(mknod)
    67c1:	48 c7 c0 11 00 00 00 	mov    $0x11,%rax
    67c8:	49 89 ca             	mov    %rcx,%r10
    67cb:	0f 05                	syscall
    67cd:	c3                   	ret

00000000000067ce <unlink>:
SYSCALL(unlink)
    67ce:	48 c7 c0 12 00 00 00 	mov    $0x12,%rax
    67d5:	49 89 ca             	mov    %rcx,%r10
    67d8:	0f 05                	syscall
    67da:	c3                   	ret

00000000000067db <fstat>:
SYSCALL(fstat)
    67db:	48 c7 c0 08 00 00 00 	mov    $0x8,%rax
    67e2:	49 89 ca             	mov    %rcx,%r10
    67e5:	0f 05                	syscall
    67e7:	c3                   	ret

00000000000067e8 <link>:
SYSCALL(link)
    67e8:	48 c7 c0 13 00 00 00 	mov    $0x13,%rax
    67ef:	49 89 ca             	mov    %rcx,%r10
    67f2:	0f 05                	syscall
    67f4:	c3                   	ret

00000000000067f5 <mkdir>:
SYSCALL(mkdir)
    67f5:	48 c7 c0 14 00 00 00 	mov    $0x14,%rax
    67fc:	49 89 ca             	mov    %rcx,%r10
    67ff:	0f 05                	syscall
    6801:	c3                   	ret

0000000000006802 <chdir>:
SYSCALL(chdir)
    6802:	48 c7 c0 09 00 00 00 	mov    $0x9,%rax
    6809:	49 89 ca             	mov    %rcx,%r10
    680c:	0f 05                	syscall
    680e:	c3                   	ret

000000000000680f <dup>:
SYSCALL(dup)
    680f:	48 c7 c0 0a 00 00 00 	mov    $0xa,%rax
    6816:	49 89 ca             	mov    %rcx,%r10
    6819:	0f 05                	syscall
    681b:	c3                   	ret

000000000000681c <getpid>:
SYSCALL(getpid)
    681c:	48 c7 c0 0b 00 00 00 	mov    $0xb,%rax
    6823:	49 89 ca             	mov    %rcx,%r10
    6826:	0f 05                	syscall
    6828:	c3                   	ret

0000000000006829 <sbrk>:
SYSCALL(sbrk)
    6829:	48 c7 c0 0c 00 00 00 	mov    $0xc,%rax
    6830:	49 89 ca             	mov    %rcx,%r10
    6833:	0f 05                	syscall
    6835:	c3                   	ret

0000000000006836 <sleep>:
SYSCALL(sleep)
    6836:	48 c7 c0 0d 00 00 00 	mov    $0xd,%rax
    683d:	49 89 ca             	mov    %rcx,%r10
    6840:	0f 05                	syscall
    6842:	c3                   	ret

0000000000006843 <uptime>:
SYSCALL(uptime)
    6843:	48 c7 c0 0e 00 00 00 	mov    $0xe,%rax
    684a:	49 89 ca             	mov    %rcx,%r10
    684d:	0f 05                	syscall
    684f:	c3                   	ret

0000000000006850 <traceread>:
SYSCALL(traceread)
    6850:	48 c7 c0 16 00 00 00 	mov    $0x16,%rax
    6857:	49 89 ca             	mov    %rcx,%r10
    685a:	0f 05                	syscall
    685c:	c3                   	ret

000000000000685d <putc>:

#include <stdarg.h>

static void
putc(int fd, char c)
{
    685d:	55                   	push   %rbp
    685e:	48 89 e5             	mov    %rsp,%rbp
    6861:	48 83 ec 10          	sub    $0x10,%rsp
    6865:	89 7d fc             	mov    %edi,-0x4(%rbp)
    6868:	89 f0                	mov    %esi,%eax
    686a:	88 45 f8             	mov    %al,-0x8(%rbp)
  write(fd, &c, 1);
    686d:	48 8d 4d f8          	lea    -0x8(%rbp),%rcx
    6871:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6874:	ba 01 00 00 00       	mov    $0x1,%edx
    6879:	48 89 ce             	mov    %rcx,%rsi
    687c:	89 c7                	mov    %eax,%edi
    687e:	48 b8 80 67 00 00 00 	movabs $0x6780,%rax
    6885:	00 00 00 
    6888:	ff d0                	call   *%rax
}
    688a:	90                   	nop
    688b:	c9                   	leave
    688c:	c3                   	ret

000000000000688d <print_x64>:

static char digits[] = "0123456789abcdef";

  static void
print_x64(int fd, addr_t x)
{
    688d:	55                   	push   %rbp
    688e:	48 89 e5             	mov    %rsp,%rbp
    6891:	48 83 ec 20          	sub    $0x20,%rsp
    6895:	89 7d ec             	mov    %edi,-0x14(%rbp)
    6898:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
  int i;
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    689c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    68a3:	eb 35                	jmp    68da <print_x64+0x4d>
    putc(fd, digits[x >> (sizeof(addr_t) * 8 - 4)]);
    68a5:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
    68a9:	48 c1 e8 3c          	shr    $0x3c,%rax
    68ad:	48 ba 10 88 00 00 00 	movabs $0x8810,%rdx
    68b4:	00 00 00 
    68b7:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax
    68bb:	0f be d0             	movsbl %al,%edx
    68be:	8b 45 ec             	mov    -0x14(%rbp),%eax
    68c1:	89 d6                	mov    %edx,%esi
    68c3:	89 c7                	mov    %eax,%edi
    68c5:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    68cc:	00 00 00 
    68cf:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(addr_t) * 2); i++, x <<= 4)
    68d1:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    68d5:	48 c1 65 e0 04       	shlq   $0x4,-0x20(%rbp)
    68da:	8b 45 fc             	mov    -0x4(%rbp),%eax
    68dd:	83 f8 0f             	cmp    $0xf,%eax
    68e0:	76 c3                	jbe    68a5 <print_x64+0x18>
}
    68e2:	90                   	nop
    68e3:	90                   	nop
    68e4:	c9                   	leave
    68e5:	c3                   	ret

00000000000068e6 <print_x32>:

  static void
print_x32(int fd, uint x)
{
    68e6:	55                   	push   %rbp
    68e7:	48 89 e5             	mov    %rsp,%rbp
    68ea:	48 83 ec 20          	sub    $0x20,%rsp
    68ee:	89 7d ec             	mov    %edi,-0x14(%rbp)
    68f1:	89 75 e8             	mov    %esi,-0x18(%rbp)
  int i;
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    68f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%rbp)
    68fb:	eb 36                	jmp    6933 <print_x32+0x4d>
    putc(fd, digits[x >> (sizeof(uint) * 8 - 4)]);
    68fd:	8b 45 e8             	mov    -0x18(%rbp),%eax
    6900:	c1 e8 1c             	shr    $0x1c,%eax
    6903:	89 c2                	mov    %eax,%edx
    6905:	48 b8 10 88 00 00 00 	movabs $0x8810,%rax
    690c:	00 00 00 
    690f:	89 d2                	mov    %edx,%edx
    6911:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
    6915:	0f be d0             	movsbl %al,%edx
    6918:	8b 45 ec             	mov    -0x14(%rbp),%eax
    691b:	89 d6                	mov    %edx,%esi
    691d:	89 c7                	mov    %eax,%edi
    691f:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6926:	00 00 00 
    6929:	ff d0                	call   *%rax
  for (i = 0; i < (sizeof(uint) * 2); i++, x <<= 4)
    692b:	83 45 fc 01          	addl   $0x1,-0x4(%rbp)
    692f:	c1 65 e8 04          	shll   $0x4,-0x18(%rbp)
    6933:	8b 45 fc             	mov    -0x4(%rbp),%eax
    6936:	83 f8 07             	cmp    $0x7,%eax
    6939:	76 c2                	jbe    68fd <print_x32+0x17>
}
    693b:	90                   	nop
    693c:	90                   	nop
    693d:	c9                   	leave
    693e:	c3                   	ret

000000000000693f <print_d>:

  static void
print_d(int fd, int v)
{
    693f:	55                   	push   %rbp
    6940:	48 89 e5             	mov    %rsp,%rbp
    6943:	48 83 ec 30          	sub    $0x30,%rsp
    6947:	89 7d dc             	mov    %edi,-0x24(%rbp)
    694a:	89 75 d8             	mov    %esi,-0x28(%rbp)
  char buf[16];
  int64 x = v;
    694d:	8b 45 d8             	mov    -0x28(%rbp),%eax
    6950:	48 98                	cltq
    6952:	48 89 45 f8          	mov    %rax,-0x8(%rbp)

  if (v < 0)
    6956:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    695a:	79 04                	jns    6960 <print_d+0x21>
    x = -x;
    695c:	48 f7 5d f8          	negq   -0x8(%rbp)

  int i = 0;
    6960:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%rbp)
  do {
    buf[i++] = digits[x % 10];
    6967:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    696b:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    6972:	66 66 66 
    6975:	48 89 c8             	mov    %rcx,%rax
    6978:	48 f7 ea             	imul   %rdx
    697b:	48 c1 fa 02          	sar    $0x2,%rdx
    697f:	48 89 c8             	mov    %rcx,%rax
    6982:	48 c1 f8 3f          	sar    $0x3f,%rax
    6986:	48 29 c2             	sub    %rax,%rdx
    6989:	48 89 d0             	mov    %rdx,%rax
    698c:	48 c1 e0 02          	shl    $0x2,%rax
    6990:	48 01 d0             	add    %rdx,%rax
    6993:	48 01 c0             	add    %rax,%rax
    6996:	48 29 c1             	sub    %rax,%rcx
    6999:	48 89 ca             	mov    %rcx,%rdx
    699c:	8b 45 f4             	mov    -0xc(%rbp),%eax
    699f:	8d 48 01             	lea    0x1(%rax),%ecx
    69a2:	89 4d f4             	mov    %ecx,-0xc(%rbp)
    69a5:	48 b9 10 88 00 00 00 	movabs $0x8810,%rcx
    69ac:	00 00 00 
    69af:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
    69b3:	48 98                	cltq
    69b5:	88 54 05 e0          	mov    %dl,-0x20(%rbp,%rax,1)
    x /= 10;
    69b9:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
    69bd:	48 ba 67 66 66 66 66 	movabs $0x6666666666666667,%rdx
    69c4:	66 66 66 
    69c7:	48 89 c8             	mov    %rcx,%rax
    69ca:	48 f7 ea             	imul   %rdx
    69cd:	48 89 d0             	mov    %rdx,%rax
    69d0:	48 c1 f8 02          	sar    $0x2,%rax
    69d4:	48 c1 f9 3f          	sar    $0x3f,%rcx
    69d8:	48 89 ca             	mov    %rcx,%rdx
    69db:	48 29 d0             	sub    %rdx,%rax
    69de:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  } while(x != 0);
    69e2:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    69e7:	0f 85 7a ff ff ff    	jne    6967 <print_d+0x28>

  if (v < 0)
    69ed:	83 7d d8 00          	cmpl   $0x0,-0x28(%rbp)
    69f1:	79 32                	jns    6a25 <print_d+0xe6>
    buf[i++] = '-';
    69f3:	8b 45 f4             	mov    -0xc(%rbp),%eax
    69f6:	8d 50 01             	lea    0x1(%rax),%edx
    69f9:	89 55 f4             	mov    %edx,-0xc(%rbp)
    69fc:	48 98                	cltq
    69fe:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%rbp,%rax,1)

  while (--i >= 0)
    6a03:	eb 20                	jmp    6a25 <print_d+0xe6>
    putc(fd, buf[i]);
    6a05:	8b 45 f4             	mov    -0xc(%rbp),%eax
    6a08:	48 98                	cltq
    6a0a:	0f b6 44 05 e0       	movzbl -0x20(%rbp,%rax,1),%eax
    6a0f:	0f be d0             	movsbl %al,%edx
    6a12:	8b 45 dc             	mov    -0x24(%rbp),%eax
    6a15:	89 d6                	mov    %edx,%esi
    6a17:	89 c7                	mov    %eax,%edi
    6a19:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6a20:	00 00 00 
    6a23:	ff d0                	call   *%rax
  while (--i >= 0)
    6a25:	83 6d f4 01          	subl   $0x1,-0xc(%rbp)
    6a29:	83 7d f4 00          	cmpl   $0x0,-0xc(%rbp)
    6a2d:	79 d6                	jns    6a05 <print_d+0xc6>
}
    6a2f:	90                   	nop
    6a30:	90                   	nop
    6a31:	c9                   	leave
    6a32:	c3                   	ret

0000000000006a33 <printf>:
// Print to the given fd. Only understands %d, %x, %p, %s.
  void
printf(int fd, char *fmt, ...)
{
    6a33:	55                   	push   %rbp
    6a34:	48 89 e5             	mov    %rsp,%rbp
    6a37:	48 81 ec f0 00 00 00 	sub    $0xf0,%rsp
    6a3e:	89 bd 1c ff ff ff    	mov    %edi,-0xe4(%rbp)
    6a44:	48 89 b5 10 ff ff ff 	mov    %rsi,-0xf0(%rbp)
    6a4b:	48 89 95 60 ff ff ff 	mov    %rdx,-0xa0(%rbp)
    6a52:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    6a59:	4c 89 85 70 ff ff ff 	mov    %r8,-0x90(%rbp)
    6a60:	4c 89 8d 78 ff ff ff 	mov    %r9,-0x88(%rbp)
    6a67:	84 c0                	test   %al,%al
    6a69:	74 20                	je     6a8b <printf+0x58>
    6a6b:	0f 29 45 80          	movaps %xmm0,-0x80(%rbp)
    6a6f:	0f 29 4d 90          	movaps %xmm1,-0x70(%rbp)
    6a73:	0f 29 55 a0          	movaps %xmm2,-0x60(%rbp)
    6a77:	0f 29 5d b0          	movaps %xmm3,-0x50(%rbp)
    6a7b:	0f 29 65 c0          	movaps %xmm4,-0x40(%rbp)
    6a7f:	0f 29 6d d0          	movaps %xmm5,-0x30(%rbp)
    6a83:	0f 29 75 e0          	movaps %xmm6,-0x20(%rbp)
    6a87:	0f 29 7d f0          	movaps %xmm7,-0x10(%rbp)
  va_list ap;
  int i, c;
  char *s;

  va_start(ap, fmt);
    6a8b:	c7 85 20 ff ff ff 10 	movl   $0x10,-0xe0(%rbp)
    6a92:	00 00 00 
    6a95:	c7 85 24 ff ff ff 30 	movl   $0x30,-0xdc(%rbp)
    6a9c:	00 00 00 
    6a9f:	48 8d 45 10          	lea    0x10(%rbp),%rax
    6aa3:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    6aaa:	48 8d 85 50 ff ff ff 	lea    -0xb0(%rbp),%rax
    6ab1:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    6ab8:	c7 85 4c ff ff ff 00 	movl   $0x0,-0xb4(%rbp)
    6abf:	00 00 00 
    6ac2:	e9 60 03 00 00       	jmp    6e27 <printf+0x3f4>
    if (c != '%') {
    6ac7:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6ace:	74 24                	je     6af4 <printf+0xc1>
      putc(fd, c);
    6ad0:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6ad6:	0f be d0             	movsbl %al,%edx
    6ad9:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6adf:	89 d6                	mov    %edx,%esi
    6ae1:	89 c7                	mov    %eax,%edi
    6ae3:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6aea:	00 00 00 
    6aed:	ff d0                	call   *%rax
      continue;
    6aef:	e9 2c 03 00 00       	jmp    6e20 <printf+0x3ed>
    }
    c = fmt[++i] & 0xff;
    6af4:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    6afb:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    6b01:	48 63 d0             	movslq %eax,%rdx
    6b04:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    6b0b:	48 01 d0             	add    %rdx,%rax
    6b0e:	0f b6 00             	movzbl (%rax),%eax
    6b11:	0f be c0             	movsbl %al,%eax
    6b14:	25 ff 00 00 00       	and    $0xff,%eax
    6b19:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    if (c == 0)
    6b1f:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    6b26:	0f 84 2e 03 00 00    	je     6e5a <printf+0x427>
      break;
    switch(c) {
    6b2c:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    6b33:	0f 84 32 01 00 00    	je     6c6b <printf+0x238>
    6b39:	83 bd 3c ff ff ff 78 	cmpl   $0x78,-0xc4(%rbp)
    6b40:	0f 8f a1 02 00 00    	jg     6de7 <printf+0x3b4>
    6b46:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    6b4d:	0f 84 d4 01 00 00    	je     6d27 <printf+0x2f4>
    6b53:	83 bd 3c ff ff ff 73 	cmpl   $0x73,-0xc4(%rbp)
    6b5a:	0f 8f 87 02 00 00    	jg     6de7 <printf+0x3b4>
    6b60:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    6b67:	0f 84 5b 01 00 00    	je     6cc8 <printf+0x295>
    6b6d:	83 bd 3c ff ff ff 70 	cmpl   $0x70,-0xc4(%rbp)
    6b74:	0f 8f 6d 02 00 00    	jg     6de7 <printf+0x3b4>
    6b7a:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    6b81:	0f 84 87 00 00 00    	je     6c0e <printf+0x1db>
    6b87:	83 bd 3c ff ff ff 64 	cmpl   $0x64,-0xc4(%rbp)
    6b8e:	0f 8f 53 02 00 00    	jg     6de7 <printf+0x3b4>
    6b94:	83 bd 3c ff ff ff 25 	cmpl   $0x25,-0xc4(%rbp)
    6b9b:	0f 84 2b 02 00 00    	je     6dcc <printf+0x399>
    6ba1:	83 bd 3c ff ff ff 63 	cmpl   $0x63,-0xc4(%rbp)
    6ba8:	0f 85 39 02 00 00    	jne    6de7 <printf+0x3b4>
    case 'c':
      putc(fd, va_arg(ap, int));
    6bae:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6bb4:	83 f8 2f             	cmp    $0x2f,%eax
    6bb7:	77 23                	ja     6bdc <printf+0x1a9>
    6bb9:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6bc0:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6bc6:	89 d2                	mov    %edx,%edx
    6bc8:	48 01 d0             	add    %rdx,%rax
    6bcb:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6bd1:	83 c2 08             	add    $0x8,%edx
    6bd4:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6bda:	eb 12                	jmp    6bee <printf+0x1bb>
    6bdc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6be3:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6be7:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6bee:	8b 00                	mov    (%rax),%eax
    6bf0:	0f be d0             	movsbl %al,%edx
    6bf3:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6bf9:	89 d6                	mov    %edx,%esi
    6bfb:	89 c7                	mov    %eax,%edi
    6bfd:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6c04:	00 00 00 
    6c07:	ff d0                	call   *%rax
      break;
    6c09:	e9 12 02 00 00       	jmp    6e20 <printf+0x3ed>
    case 'd':
      print_d(fd, va_arg(ap, int));
    6c0e:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6c14:	83 f8 2f             	cmp    $0x2f,%eax
    6c17:	77 23                	ja     6c3c <printf+0x209>
    6c19:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6c20:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6c26:	89 d2                	mov    %edx,%edx
    6c28:	48 01 d0             	add    %rdx,%rax
    6c2b:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6c31:	83 c2 08             	add    $0x8,%edx
    6c34:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6c3a:	eb 12                	jmp    6c4e <printf+0x21b>
    6c3c:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6c43:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6c47:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6c4e:	8b 10                	mov    (%rax),%edx
    6c50:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6c56:	89 d6                	mov    %edx,%esi
    6c58:	89 c7                	mov    %eax,%edi
    6c5a:	48 b8 3f 69 00 00 00 	movabs $0x693f,%rax
    6c61:	00 00 00 
    6c64:	ff d0                	call   *%rax
      break;
    6c66:	e9 b5 01 00 00       	jmp    6e20 <printf+0x3ed>
    case 'x':
      print_x32(fd, va_arg(ap, uint));
    6c6b:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6c71:	83 f8 2f             	cmp    $0x2f,%eax
    6c74:	77 23                	ja     6c99 <printf+0x266>
    6c76:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6c7d:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6c83:	89 d2                	mov    %edx,%edx
    6c85:	48 01 d0             	add    %rdx,%rax
    6c88:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6c8e:	83 c2 08             	add    $0x8,%edx
    6c91:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6c97:	eb 12                	jmp    6cab <printf+0x278>
    6c99:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6ca0:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6ca4:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6cab:	8b 10                	mov    (%rax),%edx
    6cad:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6cb3:	89 d6                	mov    %edx,%esi
    6cb5:	89 c7                	mov    %eax,%edi
    6cb7:	48 b8 e6 68 00 00 00 	movabs $0x68e6,%rax
    6cbe:	00 00 00 
    6cc1:	ff d0                	call   *%rax
      break;
    6cc3:	e9 58 01 00 00       	jmp    6e20 <printf+0x3ed>
    case 'p':
      print_x64(fd, va_arg(ap, addr_t));
    6cc8:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6cce:	83 f8 2f             	cmp    $0x2f,%eax
    6cd1:	77 23                	ja     6cf6 <printf+0x2c3>
    6cd3:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6cda:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6ce0:	89 d2                	mov    %edx,%edx
    6ce2:	48 01 d0             	add    %rdx,%rax
    6ce5:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6ceb:	83 c2 08             	add    $0x8,%edx
    6cee:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6cf4:	eb 12                	jmp    6d08 <printf+0x2d5>
    6cf6:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6cfd:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6d01:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6d08:	48 8b 10             	mov    (%rax),%rdx
    6d0b:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6d11:	48 89 d6             	mov    %rdx,%rsi
    6d14:	89 c7                	mov    %eax,%edi
    6d16:	48 b8 8d 68 00 00 00 	movabs $0x688d,%rax
    6d1d:	00 00 00 
    6d20:	ff d0                	call   *%rax
      break;
    6d22:	e9 f9 00 00 00       	jmp    6e20 <printf+0x3ed>
    case 's':
      if ((s = va_arg(ap, char*)) == 0)
    6d27:	8b 85 20 ff ff ff    	mov    -0xe0(%rbp),%eax
    6d2d:	83 f8 2f             	cmp    $0x2f,%eax
    6d30:	77 23                	ja     6d55 <printf+0x322>
    6d32:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    6d39:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d3f:	89 d2                	mov    %edx,%edx
    6d41:	48 01 d0             	add    %rdx,%rax
    6d44:	8b 95 20 ff ff ff    	mov    -0xe0(%rbp),%edx
    6d4a:	83 c2 08             	add    $0x8,%edx
    6d4d:	89 95 20 ff ff ff    	mov    %edx,-0xe0(%rbp)
    6d53:	eb 12                	jmp    6d67 <printf+0x334>
    6d55:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    6d5c:	48 8d 50 08          	lea    0x8(%rax),%rdx
    6d60:	48 89 95 28 ff ff ff 	mov    %rdx,-0xd8(%rbp)
    6d67:	48 8b 00             	mov    (%rax),%rax
    6d6a:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    6d71:	48 83 bd 40 ff ff ff 	cmpq   $0x0,-0xc0(%rbp)
    6d78:	00 
    6d79:	75 41                	jne    6dbc <printf+0x389>
        s = "(null)";
    6d7b:	48 b8 d1 87 00 00 00 	movabs $0x87d1,%rax
    6d82:	00 00 00 
    6d85:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
      while (*s)
    6d8c:	eb 2e                	jmp    6dbc <printf+0x389>
        putc(fd, *(s++));
    6d8e:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    6d95:	48 8d 50 01          	lea    0x1(%rax),%rdx
    6d99:	48 89 95 40 ff ff ff 	mov    %rdx,-0xc0(%rbp)
    6da0:	0f b6 00             	movzbl (%rax),%eax
    6da3:	0f be d0             	movsbl %al,%edx
    6da6:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6dac:	89 d6                	mov    %edx,%esi
    6dae:	89 c7                	mov    %eax,%edi
    6db0:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6db7:	00 00 00 
    6dba:	ff d0                	call   *%rax
      while (*s)
    6dbc:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    6dc3:	0f b6 00             	movzbl (%rax),%eax
    6dc6:	84 c0                	test   %al,%al
    6dc8:	75 c4                	jne    6d8e <printf+0x35b>
      break;
    6dca:	eb 54                	jmp    6e20 <printf+0x3ed>
    case '%':
      putc(fd, '%');
    6dcc:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6dd2:	be 25 00 00 00       	mov    $0x25,%esi
    6dd7:	89 c7                	mov    %eax,%edi
    6dd9:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6de0:	00 00 00 
    6de3:	ff d0                	call   *%rax
      break;
    6de5:	eb 39                	jmp    6e20 <printf+0x3ed>
    default:
      // Print unknown % sequence to draw attention.
      putc(fd, '%');
    6de7:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6ded:	be 25 00 00 00       	mov    $0x25,%esi
    6df2:	89 c7                	mov    %eax,%edi
    6df4:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6dfb:	00 00 00 
    6dfe:	ff d0                	call   *%rax
      putc(fd, c);
    6e00:	8b 85 3c ff ff ff    	mov    -0xc4(%rbp),%eax
    6e06:	0f be d0             	movsbl %al,%edx
    6e09:	8b 85 1c ff ff ff    	mov    -0xe4(%rbp),%eax
    6e0f:	89 d6                	mov    %edx,%esi
    6e11:	89 c7                	mov    %eax,%edi
    6e13:	48 b8 5d 68 00 00 00 	movabs $0x685d,%rax
    6e1a:	00 00 00 
    6e1d:	ff d0                	call   *%rax
      break;
    6e1f:	90                   	nop
  for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
    6e20:	83 85 4c ff ff ff 01 	addl   $0x1,-0xb4(%rbp)
    6e27:	8b 85 4c ff ff ff    	mov    -0xb4(%rbp),%eax
    6e2d:	48 63 d0             	movslq %eax,%rdx
    6e30:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    6e37:	48 01 d0             	add    %rdx,%rax
    6e3a:	0f b6 00             	movzbl (%rax),%eax
    6e3d:	0f be c0             	movsbl %al,%eax
    6e40:	25 ff 00 00 00       	and    $0xff,%eax
    6e45:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%rbp)
    6e4b:	83 bd 3c ff ff ff 00 	cmpl   $0x0,-0xc4(%rbp)
    6e52:	0f 85 6f fc ff ff    	jne    6ac7 <printf+0x94>
    }
  }
}
    6e58:	eb 01                	jmp    6e5b <printf+0x428>
      break;
    6e5a:	90                   	nop
}
    6e5b:	90                   	nop
    6e5c:	c9                   	leave
    6e5d:	c3                   	ret

0000000000006e5e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    6e5e:	55                   	push   %rbp
    6e5f:	48 89 e5             	mov    %rsp,%rbp
    6e62:	48 83 ec 18          	sub    $0x18,%rsp
    6e66:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  Header *bp, *p;

  bp = (Header*)ap - 1;
    6e6a:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
    6e6e:	48 83 e8 10          	sub    $0x10,%rax
    6e72:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6e76:	48 b8 90 d0 00 00 00 	movabs $0xd090,%rax
    6e7d:	00 00 00 
    6e80:	48 8b 00             	mov    (%rax),%rax
    6e83:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6e87:	eb 2f                	jmp    6eb8 <free+0x5a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    6e89:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6e8d:	48 8b 00             	mov    (%rax),%rax
    6e90:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6e94:	72 17                	jb     6ead <free+0x4f>
    6e96:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6e9a:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6e9e:	72 2f                	jb     6ecf <free+0x71>
    6ea0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6ea4:	48 8b 00             	mov    (%rax),%rax
    6ea7:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6eab:	72 22                	jb     6ecf <free+0x71>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    6ead:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6eb1:	48 8b 00             	mov    (%rax),%rax
    6eb4:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    6eb8:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6ebc:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    6ec0:	73 c7                	jae    6e89 <free+0x2b>
    6ec2:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6ec6:	48 8b 00             	mov    (%rax),%rax
    6ec9:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6ecd:	73 ba                	jae    6e89 <free+0x2b>
      break;
  if(bp + bp->s.size == p->s.ptr){
    6ecf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6ed3:	8b 40 08             	mov    0x8(%rax),%eax
    6ed6:	89 c0                	mov    %eax,%eax
    6ed8:	48 c1 e0 04          	shl    $0x4,%rax
    6edc:	48 89 c2             	mov    %rax,%rdx
    6edf:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6ee3:	48 01 c2             	add    %rax,%rdx
    6ee6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6eea:	48 8b 00             	mov    (%rax),%rax
    6eed:	48 39 c2             	cmp    %rax,%rdx
    6ef0:	75 2d                	jne    6f1f <free+0xc1>
    bp->s.size += p->s.ptr->s.size;
    6ef2:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6ef6:	8b 50 08             	mov    0x8(%rax),%edx
    6ef9:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6efd:	48 8b 00             	mov    (%rax),%rax
    6f00:	8b 40 08             	mov    0x8(%rax),%eax
    6f03:	01 c2                	add    %eax,%edx
    6f05:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f09:	89 50 08             	mov    %edx,0x8(%rax)
    bp->s.ptr = p->s.ptr->s.ptr;
    6f0c:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f10:	48 8b 00             	mov    (%rax),%rax
    6f13:	48 8b 10             	mov    (%rax),%rdx
    6f16:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f1a:	48 89 10             	mov    %rdx,(%rax)
    6f1d:	eb 0e                	jmp    6f2d <free+0xcf>
  } else
    bp->s.ptr = p->s.ptr;
    6f1f:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f23:	48 8b 10             	mov    (%rax),%rdx
    6f26:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f2a:	48 89 10             	mov    %rdx,(%rax)
  if(p + p->s.size == bp){
    6f2d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f31:	8b 40 08             	mov    0x8(%rax),%eax
    6f34:	89 c0                	mov    %eax,%eax
    6f36:	48 c1 e0 04          	shl    $0x4,%rax
    6f3a:	48 89 c2             	mov    %rax,%rdx
    6f3d:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f41:	48 01 d0             	add    %rdx,%rax
    6f44:	48 39 45 f0          	cmp    %rax,-0x10(%rbp)
    6f48:	75 27                	jne    6f71 <free+0x113>
    p->s.size += bp->s.size;
    6f4a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f4e:	8b 50 08             	mov    0x8(%rax),%edx
    6f51:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f55:	8b 40 08             	mov    0x8(%rax),%eax
    6f58:	01 c2                	add    %eax,%edx
    6f5a:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f5e:	89 50 08             	mov    %edx,0x8(%rax)
    p->s.ptr = bp->s.ptr;
    6f61:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6f65:	48 8b 10             	mov    (%rax),%rdx
    6f68:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f6c:	48 89 10             	mov    %rdx,(%rax)
    6f6f:	eb 0b                	jmp    6f7c <free+0x11e>
  } else
    p->s.ptr = bp;
    6f71:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f75:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
    6f79:	48 89 10             	mov    %rdx,(%rax)
  freep = p;
    6f7c:	48 ba 90 d0 00 00 00 	movabs $0xd090,%rdx
    6f83:	00 00 00 
    6f86:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6f8a:	48 89 02             	mov    %rax,(%rdx)
}
    6f8d:	90                   	nop
    6f8e:	c9                   	leave
    6f8f:	c3                   	ret

0000000000006f90 <morecore>:

static Header*
morecore(uint nu)
{
    6f90:	55                   	push   %rbp
    6f91:	48 89 e5             	mov    %rsp,%rbp
    6f94:	48 83 ec 20          	sub    $0x20,%rsp
    6f98:	89 7d ec             	mov    %edi,-0x14(%rbp)
  char *p;
  Header *hp;

  if(nu < 4096)
    6f9b:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%rbp)
    6fa2:	77 07                	ja     6fab <morecore+0x1b>
    nu = 4096;
    6fa4:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%rbp)
  p = sbrk(nu * sizeof(Header));
    6fab:	8b 45 ec             	mov    -0x14(%rbp),%eax
    6fae:	48 c1 e0 04          	shl    $0x4,%rax
    6fb2:	48 89 c7             	mov    %rax,%rdi
    6fb5:	48 b8 29 68 00 00 00 	movabs $0x6829,%rax
    6fbc:	00 00 00 
    6fbf:	ff d0                	call   *%rax
    6fc1:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  if(p == (char*)-1)
    6fc5:	48 83 7d f8 ff       	cmpq   $0xffffffffffffffff,-0x8(%rbp)
    6fca:	75 07                	jne    6fd3 <morecore+0x43>
    return 0;
    6fcc:	b8 00 00 00 00       	mov    $0x0,%eax
    6fd1:	eb 36                	jmp    7009 <morecore+0x79>
  hp = (Header*)p;
    6fd3:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    6fd7:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
  hp->s.size = nu;
    6fdb:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6fdf:	8b 55 ec             	mov    -0x14(%rbp),%edx
    6fe2:	89 50 08             	mov    %edx,0x8(%rax)
  free((void*)(hp + 1));
    6fe5:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    6fe9:	48 83 c0 10          	add    $0x10,%rax
    6fed:	48 89 c7             	mov    %rax,%rdi
    6ff0:	48 b8 5e 6e 00 00 00 	movabs $0x6e5e,%rax
    6ff7:	00 00 00 
    6ffa:	ff d0                	call   *%rax
  return freep;
    6ffc:	48 b8 90 d0 00 00 00 	movabs $0xd090,%rax
    7003:	00 00 00 
    7006:	48 8b 00             	mov    (%rax),%rax
}
    7009:	c9                   	leave
    700a:	c3                   	ret

000000000000700b <malloc>:

void*
malloc(uint nbytes)
{
    700b:	55                   	push   %rbp
    700c:	48 89 e5             	mov    %rsp,%rbp
    700f:	48 83 ec 30          	sub    $0x30,%rsp
    7013:	89 7d dc             	mov    %edi,-0x24(%rbp)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    7016:	8b 45 dc             	mov    -0x24(%rbp),%eax
    7019:	48 83 c0 0f          	add    $0xf,%rax
    701d:	48 c1 e8 04          	shr    $0x4,%rax
    7021:	83 c0 01             	add    $0x1,%eax
    7024:	89 45 ec             	mov    %eax,-0x14(%rbp)
  if((prevp = freep) == 0){
    7027:	48 b8 90 d0 00 00 00 	movabs $0xd090,%rax
    702e:	00 00 00 
    7031:	48 8b 00             	mov    (%rax),%rax
    7034:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7038:	48 83 7d f0 00       	cmpq   $0x0,-0x10(%rbp)
    703d:	75 4a                	jne    7089 <malloc+0x7e>
    base.s.ptr = freep = prevp = &base;
    703f:	48 b8 80 d0 00 00 00 	movabs $0xd080,%rax
    7046:	00 00 00 
    7049:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    704d:	48 ba 90 d0 00 00 00 	movabs $0xd090,%rdx
    7054:	00 00 00 
    7057:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    705b:	48 89 02             	mov    %rax,(%rdx)
    705e:	48 b8 90 d0 00 00 00 	movabs $0xd090,%rax
    7065:	00 00 00 
    7068:	48 8b 00             	mov    (%rax),%rax
    706b:	48 ba 80 d0 00 00 00 	movabs $0xd080,%rdx
    7072:	00 00 00 
    7075:	48 89 02             	mov    %rax,(%rdx)
    base.s.size = 0;
    7078:	48 b8 80 d0 00 00 00 	movabs $0xd080,%rax
    707f:	00 00 00 
    7082:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%rax)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    7089:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    708d:	48 8b 00             	mov    (%rax),%rax
    7090:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    7094:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7098:	8b 40 08             	mov    0x8(%rax),%eax
    709b:	3b 45 ec             	cmp    -0x14(%rbp),%eax
    709e:	72 65                	jb     7105 <malloc+0xfa>
      if(p->s.size == nunits)
    70a0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70a4:	8b 40 08             	mov    0x8(%rax),%eax
    70a7:	39 45 ec             	cmp    %eax,-0x14(%rbp)
    70aa:	75 10                	jne    70bc <malloc+0xb1>
        prevp->s.ptr = p->s.ptr;
    70ac:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70b0:	48 8b 10             	mov    (%rax),%rdx
    70b3:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    70b7:	48 89 10             	mov    %rdx,(%rax)
    70ba:	eb 2e                	jmp    70ea <malloc+0xdf>
      else {
        p->s.size -= nunits;
    70bc:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70c0:	8b 40 08             	mov    0x8(%rax),%eax
    70c3:	2b 45 ec             	sub    -0x14(%rbp),%eax
    70c6:	89 c2                	mov    %eax,%edx
    70c8:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70cc:	89 50 08             	mov    %edx,0x8(%rax)
        p += p->s.size;
    70cf:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70d3:	8b 40 08             	mov    0x8(%rax),%eax
    70d6:	89 c0                	mov    %eax,%eax
    70d8:	48 c1 e0 04          	shl    $0x4,%rax
    70dc:	48 01 45 f8          	add    %rax,-0x8(%rbp)
        p->s.size = nunits;
    70e0:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70e4:	8b 55 ec             	mov    -0x14(%rbp),%edx
    70e7:	89 50 08             	mov    %edx,0x8(%rax)
      }
      freep = prevp;
    70ea:	48 ba 90 d0 00 00 00 	movabs $0xd090,%rdx
    70f1:	00 00 00 
    70f4:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
    70f8:	48 89 02             	mov    %rax,(%rdx)
      return (void*)(p + 1);
    70fb:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    70ff:	48 83 c0 10          	add    $0x10,%rax
    7103:	eb 4e                	jmp    7153 <malloc+0x148>
    }
    if(p == freep)
    7105:	48 b8 90 d0 00 00 00 	movabs $0xd090,%rax
    710c:	00 00 00 
    710f:	48 8b 00             	mov    (%rax),%rax
    7112:	48 39 45 f8          	cmp    %rax,-0x8(%rbp)
    7116:	75 23                	jne    713b <malloc+0x130>
      if((p = morecore(nunits)) == 0)
    7118:	8b 45 ec             	mov    -0x14(%rbp),%eax
    711b:	89 c7                	mov    %eax,%edi
    711d:	48 b8 90 6f 00 00 00 	movabs $0x6f90,%rax
    7124:	00 00 00 
    7127:	ff d0                	call   *%rax
    7129:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    712d:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    7132:	75 07                	jne    713b <malloc+0x130>
        return 0;
    7134:	b8 00 00 00 00       	mov    $0x0,%eax
    7139:	eb 18                	jmp    7153 <malloc+0x148>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    713b:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    713f:	48 89 45 f0          	mov    %rax,-0x10(%rbp)
    7143:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    7147:	48 8b 00             	mov    (%rax),%rax
    714a:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    if(p->s.size >= nunits){
    714e:	e9 41 ff ff ff       	jmp    7094 <malloc+0x89>
  }
}
    7153:	c9                   	leave
    7154:	c3                   	ret
