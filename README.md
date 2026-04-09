# Docker Workstation 구축

---

## 1. 프로젝트 개요
- WSL2(Ubuntu) 기반 Docker 개발 환경 구축
- 컨테이너 실행, Dockerfile 빌드, 포트 매핑, 볼륨 및 Git 연동까지 수행

---

## 2. 실행 환경

```bash
docker --version
git --version
```
결과:

```text
Docker version 28.5.2, build ecc6942
git version 2.53.0
```

---

## 3. 수행 체크리스트

[o] 터미널 기본 조작  

[o] 권한 변경 실습  

[o] Docker 설치/점검  

[o] 컨테이너 실행  

[o] Docker 기본 명령 실행  

[o] Dockerfile 작성 및 실행

[o] 포트 매핑   

[o] 바인드 마운트

[o] 볼륨 영속성

[o] Git/GitHub 연동

---

## 4. 터미널 조작 로그

기본 명령
```bash
pwd
ls -la
mkdir test-dir
cd test-dir
touch test.txt
echo "hello" > test.txt
cat test.txt
```

결과:
```bash
/Users/youngrae11032045
total 16
drwxr-x---+ 20 youngrae11032045  youngrae11032045   640  4  9 15:24 .
drwxr-xr-x  13 root              admin              416  4  9 14:45 ..
-r--------   1 youngrae11032045  youngrae11032045     8  4  9 14:45 .CFUserTextEncoding
drwxr-xr-x   5 youngrae11032045  youngrae11032045   160  4  9 14:45 .docker
drwxr-xr-x  10 youngrae11032045  youngrae11032045   320  4  9 14:45 .orbstack
drwxr-xr-x   3 youngrae11032045  youngrae11032045    96  4  9 14:45 .ssh
drwx------+  2 youngrae11032045  youngrae11032045    64  4  9 14:45 .Trash
drwxr-xr-x   3 youngrae11032045  youngrae11032045    96  4  9 14:46 .vscode
-rw-------   1 youngrae11032045  youngrae11032045   275  4  9 15:24 .zsh_history
drwx------   6 youngrae11032045  youngrae11032045   192  4  9 15:24 .zsh_sessions
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Desktop
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Documents
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Downloads
drwx------@ 78 youngrae11032045  youngrae11032045  2496  4  9 15:01 Library
drwx------   3 youngrae11032045  youngrae11032045    96  4  9 14:45 Movies
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Music
drwx------   4 youngrae11032045  youngrae11032045   160  4  9 14:45 OrbStack
drwx------+  4 youngrae11032045  youngrae11032045   128  4  9 14:45 Pictures
drwxr-xr-x+  4 youngrae11032045  youngrae11032045   128  4  9 14:45 Public
-rwxr-xr-x   1 youngrae11032045  youngrae11032045     0  4  9 15:19 test.txt

## test.dir 생성
## test.txt 생성
total 8
drwxr-xr-x   3 youngrae11032045  youngrae11032045   96  4  9 15:53 .
drwxr-x---+ 21 youngrae11032045  youngrae11032045  672  4  9 15:53 ..
-rw-r--r--   1 youngrae11032045  youngrae11032045    6  4  9 15:53 test.txt
## cat test.txt 
hello
```

권한 변경
```bash
ls -l test.txt
chmod 755 test.txt
ls -l test.txt
```

결과:
```bash
## 변경 전
-rw-r--r--  1 youngrae11032045  youngrae11032045  6  4  9 15:53 test.txt

## chmod 755 test.txt

## 변경 후
-rwxr-xr-x  1 youngrae11032045  youngrae11032045  6  4  9 15:53 test.txt
```
---

## 5. Docker 설치 및 점검

```bash
docker --version
docker info
```

결과:
```bash
Docker version 28.5.2, build ecc6942
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/youngrae11032045/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/youngrae11032045/.docker/cli-plugins/docker-compose

Server:
 Containers: 3
  Running: 0
  Paused: 0
  Stopped: 3
 Images: 1
 Server Version: 28.5.2
 Storage Driver: overlay2
  Backing Filesystem: btrfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 1c4457e00facac03ce1d75f7b6777a7a851e5c41
 runc version: d842d7719497cc3b774fd71620278ac9e17710e0
 init version: de40ad0
 Security Options:
  seccomp
   Profile: builtin
  cgroupns
 Kernel Version: 6.17.8-orbstack-00308-g8f9c941121b1
 Operating System: OrbStack
 OSType: linux
 Architecture: x86_64
 CPUs: 6
 Total Memory: 15.67GiB
 Name: orbstack
 ID: 40bbd0f9-79a2-49b9-8a7f-b13735426473
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Experimental: false
 Insecure Registries:
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false
 Product License: Community Engine
 Default Address Pools:
   Base: 192.168.97.0/24, Size: 24
   Base: 192.168.107.0/24, Size: 24
   Base: 192.168.117.0/24, Size: 24
   Base: 192.168.147.0/24, Size: 24
   Base: 192.168.148.0/24, Size: 24
   Base: 192.168.155.0/24, Size: 24
   Base: 192.168.156.0/24, Size: 24
   Base: 192.168.158.0/24, Size: 24
   Base: 192.168.163.0/24, Size: 24
   Base: 192.168.164.0/24, Size: 24
   Base: 192.168.165.0/24, Size: 24
   Base: 192.168.166.0/24, Size: 24
   Base: 192.168.167.0/24, Size: 24
   Base: 192.168.171.0/24, Size: 24
   Base: 192.168.172.0/24, Size: 24
   Base: 192.168.181.0/24, Size: 24
   Base: 192.168.183.0/24, Size: 24
   Base: 192.168.186.0/24, Size: 24
   Base: 192.168.207.0/24, Size: 24
   Base: 192.168.214.0/24, Size: 24
   Base: 192.168.215.0/24, Size: 24
   Base: 192.168.216.0/24, Size: 24
   Base: 192.168.223.0/24, Size: 24
   Base: 192.168.227.0/24, Size: 24
   Base: 192.168.228.0/24, Size: 24
   Base: 192.168.229.0/24, Size: 24
   Base: 192.168.237.0/24, Size: 24
   Base: 192.168.239.0/24, Size: 24
   Base: 192.168.242.0/24, Size: 24
   Base: 192.168.247.0/24, Size: 24
   Base: fd07:b51a:cc66:d000::/56, Size: 64

WARNING: DOCKER_INSECURE_NO_IPTABLES_RAW is set
```
---

## 6. Docker 기본 운영 명령

```bash
docker run hello-world
docker images
docker ps -a
docker logs <컨테이너ID>
docker stats
```

결과:
```bash
(출력 복붙)
```
---

## 7. 컨테이너 실행

```bash
docker run -it ubuntu bash
```


컨테이너 내부:

ls
echo "inside container"
exit

---

## 8. Dockerfile 기반 웹 서버

디렉토리 생성
mkdir -p ~/docker-practice/site
cd ~/docker-practice
index.html
echo "<h1>Hello Docker</h1>" > site/index.html
Dockerfile
FROM nginx:alpine
COPY site/ /usr/share/nginx/html/

빌드
docker build -t my-web .

실행
docker run -d -p 8080:80 --name my-web-container my-web

---

## 9. 포트 매핑 검증
curl http://localhost:8080

결과:

Hello Docker

또는 브라우저 접속:

http://localhost:8080

---

## 10. 바인드 마운트

docker run -d -p 8081:80 \
-v $(pwd)/site:/usr/share/nginx/html \
nginx:alpine

변경 전
curl http://localhost:8081

파일 수정
echo "<h1>Changed</h1>" > site/index.html

변경 후
curl http://localhost:8081

---

## 11. Docker 볼륨 (영속성)
docker volume create mydata

데이터 생성
docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
docker exec vol-test bash -c "echo hello > /data/file.txt"
docker exec vol-test cat /data/file.txt

컨테이너 삭제
docker rm -f vol-test

데이터 유지 확인
docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
docker exec vol-test2 cat /data/file.txt

결과:

hello

---

## 12. Git 설정
git config --global user.name "yourname"
git config --global user.email "you@example.com"
git config --list

---

## 13. 트러블슈팅

문제 1: WSL에서 docker 실행 오류

문제: docker-desktop 환경에서 docker 실행 시 오류 발생

원인: docker-desktop은 내부용 WSL

해결: Ubuntu WSL에서 실행

문제 2: docker build 실패

문제: docker build 실행 시 에러 발생

원인: build 경로 지정 안 함

해결: docker build -t my-web . 로 수정

## 14. 검증 방법

docker 명령 실행 결과 확인

curl로 포트 접속 확인

볼륨 데이터 유지 확인
