# Docker Workstation 구축

---

## 1. 프로젝트 개요
- macOS(OrbStack) 기반 Docker 개발 환경 구축
- 컨테이너 실행, Dockerfile 빌드, 포트 매핑, 볼륨 및 Git 연동까지 수행

---

## 2. 실행 환경

- OS: macOS 
- Terminal: macOS Terminal (OrbStack)

```bash
docker --version
git --version
```
```text
Docker version 28.5.2, build ecc6942
git version 2.53.0
```

---

## 3. 수행 체크리스트

[x] 터미널 기본 조작  

[x] 권한 변경 실습  

[x] Docker 설치/점검  

[x] 컨테이너 실행  

[x] Docker 기본 명령 실행  

[x] Dockerfile 작성 및 실행

[x] 포트 매핑   

[x] 바인드 마운트

[x] 볼륨 영속성

[x] Git/GitHub 연동

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
docker logs <CONTAINER ID>
docker stats
```

결과:
```bash
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

REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    e2ac70e7319a   2 weeks ago   10.1kB

CONTAINER ID   IMAGE         COMMAND    CREATED             STATUS                         PORTS     NAMES
cc6ecf2cb478   hello-world   "/hello"   25 seconds ago      Exited (0) 24 seconds ago                kind_fermi
1981c1f19f29   hello-world   "/hello"   40 minutes ago      Exited (0) 40 minutes ago                fervent_dhawan
725e78ec9491   hello-world   "/hello"   42 minutes ago      Exited (0) 42 minutes ago                sleepy_ellis
2a3b44a38795   hello-world   "/hello"   About an hour ago   Exited (0) About an hour ago             jolly_murdock

## docker logs cc6ecf2cb478 ( = kind_fermi)
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

## docker stats (실행 중인 컨테이너 없음)
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT   MEM %     NET I/O   BLOCK I/O   PIDS 
 
```
---

## 7. 컨테이너 실행

```bash
docker run -it ubuntu bash
```

결과:
```bash
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
689b91d88a0f: Pull complete 
Digest: sha256:84e77dee7d1bc93fb029a45e3c6cb9d8aa4831ccfcc7103d36e876938d28895b
Status: Downloaded newer image for ubuntu:latest
```

컨테이너 내부:

```bash
ls
echo "inside container"
exit
```
결과:
```bash
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

##echo "inside container"
inside container
##exit
exit
```


---

## 8. Dockerfile 기반 웹 서버

디렉토리 생성
```bash
mkdir -p ~/docker-practice/site
cd ~/docker-practice
```
결과:
```bash
## 디렉토리 생성 및 이동 확인
youngrae11032045@c4r6s1 docker-practice %
```

index.html
```bash
echo "<h1>Hello Docker</h1>" > site/index.html
cat site/index.html
```

결과
```bash
<h1>Hello Docker</h1>
```


Dockerfile
```bash
## touch Dockerfile (생성)
## nano Dockerfile (편집기 열기)

FROM nginx:alpine
COPY site/ /usr/share/nginx/html/

## 저장 후 종료 ctrl o , enter, ctrl x
```

빌드
```bash
docker build -t my-web .
```
결과
```bash
[+] Building 7.0s (7/7) FINISHED                                                                                                                                  docker:orbstack
 => [internal] load build definition from Dockerfile                                                                                                                         0.1s
 => => transferring dockerfile: 89B                                                                                                                                          0.0s
 => [internal] load metadata for docker.io/library/nginx:alpine                                                                                                              2.2s
 => [internal] load .dockerignore                                                                                                                                            0.1s
 => => transferring context: 2B                                                                                                                                              0.0s
 => [1/2] FROM docker.io/library/nginx:alpine@sha256:645eda1c2477aaa9b879f73909b9222c6f19798dd45be6706268d82a661c6e6d                                                        3.8s
 => => resolve docker.io/library/nginx:alpine@sha256:645eda1c2477aaa9b879f73909b9222c6f19798dd45be6706268d82a661c6e6d                                                        0.2s
 => => sha256:645eda1c2477aaa9b879f73909b9222c6f19798dd45be6706268d82a661c6e6d 10.33kB / 10.33kB                                                                             0.0s
 => => sha256:589002ba0eaed121a1dbf42f6648f29e5be55d5c8a6ee0f8eaa0285cc21ac153 3.86MB / 3.86MB                                                                               0.6s
 => => sha256:c1263cc56873d66f381fd07149aa0dc7244dd7c941334cd18473c46509f08465 2.50kB / 2.50kB                                                                               0.0s
 => => sha256:5bd7bd52e5bcab15a093466b90e37472b0d0c0081052522afb8924cbdaf15f56 12.32kB / 12.32kB                                                                             0.0s
 => => sha256:f03becc8ac15611cfcc421c977a5ba4d65456093570788523a4ba557689aa7f7 1.87MB / 1.87MB                                                                               0.9s
 => => sha256:15e759724ff67f262e38bb7c070af9d0b84f959f9b37fa966f68bf2f881a4b62 627B / 627B                                                                                   0.7s
 => => extracting sha256:589002ba0eaed121a1dbf42f6648f29e5be55d5c8a6ee0f8eaa0285cc21ac153                                                                                    0.1s
 => => sha256:ff9f59a6a62e9e9f29d7a84fb18865b45664d3f0d061eff7548bd61746dd101c 957B / 957B                                                                                   1.1s
 => => sha256:a71873b303e8d75170b7ced2725b01b3ae15ad76f0d4eef16a49335821b6a0ef 404B / 404B                                                                                   1.3s
 => => extracting sha256:f03becc8ac15611cfcc421c977a5ba4d65456093570788523a4ba557689aa7f7                                                                                    0.1s
 => => sha256:34dfdd2ef1f920d0054dde2fc09ddc83ff8e71d05fadb79e2cab6e6234596f0a 1.21kB / 1.21kB                                                                               1.4s
 => => sha256:c8a2fa3a88d244a3f32dcbc9c1f7649c662661a28c624198ada43aa0b7598e7f 1.40kB / 1.40kB                                                                               1.6s
 => => extracting sha256:15e759724ff67f262e38bb7c070af9d0b84f959f9b37fa966f68bf2f881a4b62                                                                                    0.0s
 => => extracting sha256:ff9f59a6a62e9e9f29d7a84fb18865b45664d3f0d061eff7548bd61746dd101c                                                                                    0.0s
 => => sha256:1165b869c51a1a0747d78cec8fab96c30156a979e51ecf2f91aa792e557d94a4 20.25MB / 20.25MB                                                                             2.2s
 => => extracting sha256:a71873b303e8d75170b7ced2725b01b3ae15ad76f0d4eef16a49335821b6a0ef                                                                                    0.0s
 => => extracting sha256:34dfdd2ef1f920d0054dde2fc09ddc83ff8e71d05fadb79e2cab6e6234596f0a                                                                                    0.0s
 => => extracting sha256:c8a2fa3a88d244a3f32dcbc9c1f7649c662661a28c624198ada43aa0b7598e7f                                                                                    0.0s
 => => extracting sha256:1165b869c51a1a0747d78cec8fab96c30156a979e51ecf2f91aa792e557d94a4                                                                                    0.4s
 => [internal] load build context                                                                                                                                            0.3s
 => => transferring context: 92B                                                                                                                                             0.0s
 => [2/2] COPY site/ /usr/share/nginx/html/                                                                                                                                  0.2s
 => exporting to image                                                                                                                                                       0.2s
 => => exporting layers                                                                                                                                                      0.1s
 => => writing image sha256:f86bbe94d263a95eabed4675c32a20186069d0ec075dbc884190485aab95991f                                                                                 0.0s
 => => naming to docker.io/library/my-web                                                                                                                                    0.0s
```


실행
```bash
docker run -d -p 8080:80 --name my-web-container my-web
```

결과
```bash
678ec3ac72d907d5f08b149cf98272a9be488d58001e52e30389b0b6254405be
```

---

## 9. 포트 매핑 검증

```bash
curl http://localhost:8080
```

결과:

```bash
<h1>Hello Docker</h1>
```


---

## 10. 바인드 마운트

```bash
docker run -d -p 8081:80 \
-v $(pwd)/site:/usr/share/nginx/html \
nginx:alpine
```

변경 전
```bash
curl http://localhost:8081
```

결과
```bash
<h1>Hello Docker</h1>
```

파일 수정
```bash
echo "<h1>Changed</h1>" > site/index.html
cat site/index.html
```

결과
```bash
<h1>Changed</h1>
```

변경 후
```bash
curl http://localhost:8081
```

결과
```bash
<h1>Changed</h1>
```

---

## 11. Docker 볼륨 (영속성)

볼륨 생성
```bash
docker volume create mydata
```

데이터 생성
```bash
docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
docker exec vol-test bash -c "echo hello > /data/file.txt"
docker exec vol-test cat /data/file.txt
```

결과
```bash
hello
```

컨테이너 삭제
```bash
docker rm -f vol-test
```

데이터 유지 확인
```bash
docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
docker exec vol-test2 cat /data/file.txt

```

결과:
```bash
hello
```
---

## 12. Git 설정 및 Github 연동

```bash
git config --global user.name "yourname"
git config --global user.email "your@email.com"
git config --list

```

결과:

```bash
credential.helper=osxkeychain
user.name=yourname
user.email=your@email.com
```
GitHub 저장소 생성 및 연결 완료

---

## 13. 트러블슈팅

문제 1: Docker Hub 이미지 다운로드 실패

문제: docker build 실행 시 lookup auth.docker.io: no such host 오류 발생

원인 가설: DNS 또는 네트워크 문제로 Docker Hub 접근 실패

확인: docker pull nginx:alpine 실행 시 동일 오류 발생 확인

해결/대안: 네트워크 재연결 및 Docker 재시작 후 정상 동작

문제 2: docker build 실패

문제: docker build -t my-web 실행 시 오류 발생

원인 가설: build context(.)를 지정하지 않아 Dockerfile 위치 인식 실패

확인: 에러 메시지에서 argument 부족 확인

해결/대안: docker build -t my-web .로 수정하여 해결


## 14. 검증 방법

Docker 설치 확인: docker --version, docker info

컨테이너/이미지 상태 확인: docker images, docker ps -a

로그 확인: docker logs

리소스 확인: docker stats --no-stream

포트 매핑 확인: curl http://localhost:8080

바인드 마운트 확인: 파일 수정 전/후 비교

볼륨 영속성 확인: 컨테이너 삭제 전/후 데이터 비교

Git 설정 확인: git config --list

GitHub 연동 확인: push 및 저장소 확인

## 15. 개념 및 설계 설명

---

## 15. 개념 및 설계 설명

### 1) 프로젝트 디렉토리 구조 설계

- `docker-practice/`
  - `site/` → 웹 서버에서 사용할 HTML 파일
    
  - `Dockerfile` → 이미지 빌드 정의

설계 기준:
- 웹 리소스와 Docker 설정을 분리하여 관리
- 
- Dockerfile 기준 상대 경로 COPY를 사용하기 위해 동일 디렉토리에 배치

---

### 2) 포트 매핑과 볼륨 재현 방식

- 포트 매핑:
```bash
docker run -d -p 8080:80 my-web
```
설명:

-컨테이너 내부 80번 포트를 호스트 8080번 포트로 연결

-브라우저에서 localhost:8080으로 접근 가능

바인드 마운트:
```bash
-v $(pwd)/site:/usr/share/nginx/html
```

설명:
-호스트 파일 변경 시 컨테이너에 즉시 반영

-개발 환경에서 실시간 수정 가능

```bash
docker volume create mydata
```
설명:
-컨테이너 삭제 후에도 데이터 유지

-영속성 보장
