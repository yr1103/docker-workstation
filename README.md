# Docker Workstation 구축

---

## 1. 프로젝트 개요
- WSL2(Ubuntu) 기반 Docker 개발 환경 구축
- 컨테이너 실행 및 검증, 포트 매핑, 볼륨, Git 연동 수행

---

## 2. 실행 환경

```bash
docker --version

Docker version 28.5.2, build ecc6942

git --version

git version 2.53.0

```
## 3. 수행 체크리스트

[ ] 터미널 기본 조작
[ ] 권한 변경 실습
[ ] Docker 설치/점검
[ ] 컨테이너 실행
[ ] Dockerfile 작성
[ ] 포트 매핑
[ ] 바인드 마운트
[ ] 볼륨 영속성
[ ] Git/GitHub 연동

---

## 4. 터미널 조작 로그

### 기본 명령

```bash
pwd
ls -la
```

결과:

```text
/Users/youngrae11032045

total 8
drwxr-x---+ 18 youngrae11032045  youngrae11032045   576  4  9 14:52 .
drwxr-xr-x  13 root              admin              416  4  9 14:45 ..
-r--------   1 youngrae11032045  youngrae11032045     8  4  9 14:45 .CFUserTextEncoding
drwxr-xr-x   5 youngrae11032045  youngrae11032045   160  4  9 14:45 .docker
drwxr-xr-x  10 youngrae11032045  youngrae11032045   320  4  9 14:45 .orbstack
drwxr-xr-x   3 youngrae11032045  youngrae11032045    96  4  9 14:45 .ssh
drwx------+  2 youngrae11032045  youngrae11032045    64  4  9 14:45 .Trash
drwxr-xr-x   3 youngrae11032045  youngrae11032045    96  4  9 14:46 .vscode
drwx------   3 youngrae11032045  youngrae11032045    96  4  9 14:52 .zsh_sessions
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Desktop
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Documents
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Downloads
drwx------@ 78 youngrae11032045  youngrae11032045  2496  4  9 15:01 Library
drwx------   3 youngrae11032045  youngrae11032045    96  4  9 14:45 Movies
drwx------+  3 youngrae11032045  youngrae11032045    96  4  9 14:45 Music
drwx------   4 youngrae11032045  youngrae11032045   160  4  9 14:45 OrbStack
drwx------+  4 youngrae11032045  youngrae11032045   128  4  9 14:45 Pictures
drwxr-xr-x+  4 youngrae11032045  youngrae11032045   128  4  9 14:45 Public
```

---

### 권한 변경

```bash
touch test.txt
chmod 755 test.txt
```

결과:

```text
chmod 755 test.txt
```
어떤게 달라졌는지 비교 설명 가능해야함.
---

## 5. Docker 설치 및 점검

```bash
docker --version
docker info
```

결과:

```text
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
 Containers: 1
  Running: 0
  Paused: 0
  Stopped: 1
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
docker images
docker ps -a
docker logs <컨테이너>
docker stats
```

결과:

```text
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    e2ac70e7319a   2 weeks ago   10.1kB

     PORTS     NAMES
2a3b44a38795   hello-world   "/hello"   29 minutes ago   Exited (0) 29 minutes ago             jolly_murdock

CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT   MEM %     NET I/O   BLOCK I/O   PIDS 

```

---

## 7. 컨테이너 실행

```bash
docker run hello-world
```

결과:

```text

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

---

## 8. Dockerfile 기반 웹 서버

### Dockerfile

```dockerfile
(코드)
```

### 실행

```bash
docker build -t my-web .
docker run -d -p 8080:80 my-web
```

결과:

```text
ERROR: docker: 'docker buildx build' requires 1 argument

Usage:  docker buildx build [OPTIONS] PATH | URL | -

Run 'docker buildx build --help' for more information

Unable to find image 'my-web:latest' locally
docker: Error response from daemon: pull access denied for my-web, repository does not exist or may require 'docker login': denied: requested access to the resource is denied

Run 'docker run --help' for more information

```

---

## 9. 포트 매핑 검증

```bash
curl http://localhost:8080
```

결과:

```text
Hello...
```

(또는 브라우저 캡처)

---

## 10. 바인드 마운트

(변경 전/후 비교 필수)

---

## 11. Docker 볼륨 (영속성)

(삭제 전/후 비교 필수)

---

## 12. Git 설정

```bash
git config --list
```

---

## 13. 트러블슈팅

### 문제 1

* 문제:
* 원인:
* 해결:

### 문제 2

* 문제:
* 원인:
* 해결:

```

---

# 5️⃣ 앞으로 진행 방식 (중요)

👉 이 방식으로 진행하면 README 자동 완성됨
