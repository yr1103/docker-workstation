# Docker Workstation 구축

## 📌 1. 프로젝트 개요

본 프로젝트는 터미널, Docker, Git을 활용하여 재현 가능한 개발 환경을 구축하는 것을 목표로 한다.

* CLI 기반 파일/권한 관리
* Docker 컨테이너 실행 및 관리
* Dockerfile 기반 커스텀 이미지 제작
* 포트 매핑 및 네트워크 이해
* 볼륨을 통한 데이터 영속성 확인
* Git/GitHub 협업 환경 구축

→ 단순 실행이 아닌 “왜 이렇게 동작하는지 설명 가능한 수준”까지 이해하는 것이 목표이다.

---

## 2. 실행 환경

* OS: macOS
* Shell: zsh
* Terminal: macOS Terminal
* Docker: Docker version 28.5.2
* Git: git version 2.53.0
* Container Engine: OrbStack

---

##  3. 수행 체크리스트

### 기능 동작 검증

* [x] 터미널 기본 명령어 수행
* [x] 파일/디렉토리 권한 변경
* [x] Docker 설치 및 실행 확인
* [x] hello-world 실행
* [x] 이미지/컨테이너 관리
* [x] Dockerfile 빌드
* [x] 포트 매핑 접속 확인
* [x] Docker 볼륨 영속성 확인
* [x] Git 설정 및 GitHub 연동

---

## 4. 프로젝트 디렉토리 구조

```
project-root/
  app/
    index.html
  Dockerfile
  README.md
  logs/
```

### 설계 기준

* app/ : 웹 서버 소스 코드
* logs/ : 실행 증거 저장
* Dockerfile은 루트에 위치하여 빌드 단순화

---

## 5. 터미널 작업 로그

```bash
pwd
ls -la
mkdir practice
cd practice
touch test.txt
cp test.txt copy.txt
mv copy.txt moved.txt
rm moved.txt
```

---

## 6. 파일 권한 실습

```bash
ls -l test.txt
chmod 644 test.txt
ls -l test.txt

mkdir dir_test
chmod 755 dir_test
ls -ld dir_test

ls -l test.txt
chmod 600 test.txt
ls -l test.txt

mkdir dir_test
chmod 700 dir_test
ls -ld dir_test
```

### 권한 설명

* 644 → rw-r--r--
* 755 → rwxr-xr-x

→ r(4), w(2), x(1)의 합으로 계산됨

### 파일 권한 숫자 표기 해석
리눅스 권한은 owner / group / others 순서로 설정되며,  
각 권한은 r=4, w=2, x=1의 합으로 표현된다.

- 644 = rw-r--r--
  - 소유자: 읽기, 쓰기
  - 그룹: 읽기만 가능
  - 기타 사용자: 읽기만 가능

- 600 = rw-------
  - 소유자만 읽기, 쓰기 가능
  - 그룹/기타 사용자는 접근 불가

- 755 = rwxr-xr-x
  - 소유자는 읽기, 쓰기, 실행 가능
  - 그룹/기타 사용자는 읽기, 실행 가능

- 700 = rwx------
  - 소유자만 읽기, 쓰기, 실행 가능
  - 그룹/기타 사용자는 접근 불가
 
일반 파일은 보통 실행 권한이 필요 없어서 644를 많이 사용하고,
디렉토리는 내부 진입/탐색을 위해 실행(x) 권한이 필요하므로 755를 자주 사용한다.
보안이 더 중요한 경우 파일은 600, 디렉토리는 700처럼 소유자만 접근 가능하도록 제한할 수 있다.

---

## 7. Docker 기본 검증

```bash
docker --version
docker info
```

```bash
docker run hello-world
```

---

## 8. Docker 운영 명령

```bash
docker images
docker ps
docker ps -a
docker logs <container_id>
docker stats
```
이미지/컨테이너 정리 확인
```bash
docker stop <container_name>
docker rm <container_name>
docker rmi <image_name>
docker images
```


---

## 9. 컨테이너 실행 실습

```bash
docker run -it ubuntu bash
```

```bash
ls
echo "hello"
exit
```

---

## 10. Dockerfile 기반 커스텀 이미지

### Dockerfile

```dockerfile
FROM nginx:alpine

LABEL maintainer="me"

COPY app/ /usr/share/nginx/html/

ENV APP_ENV=dev
```

---

### 빌드

```bash
docker build -t my-web:1.0 .
```

---

### 실행

```bash
docker run -d -p 8080:80 --name my-web my-web:1.0
```

---

## 11. 포트 매핑 검증

```bash
curl http://localhost:8080
```

→ 브라우저에서도 접속 확인

---

## 12. 볼륨 영속성 검증

```bash
docker volume create mydata
```

```bash
docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
```

```bash
docker exec -it vol-test bash
echo hello > /data/file.txt
exit
```

```bash
docker rm -f vol-test
```

```bash
docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
docker exec -it vol-test2 cat /data/file.txt
```

→ 컨테이너 삭제 후에도 데이터 유지 확인

---

## 13. Git & GitHub 설정

```bash
git config --global user.name "your_name"
git config --global user.email "your_email"
git config --list
```

```bash
git init
git add .
git commit -m "init"
git remote add origin <repo_url>
git push -u origin main
```

---

## 14. 핵심 개념 정리

### 이미지 vs 컨테이너

* Image: 실행 템플릿
* Container: 실행된 인스턴스

---

### 포트 매핑 이유

* 컨테이너는 외부와 분리된 네트워크
* 접근하려면 포트 연결 필요

---

### 절대 vs 상대 경로

* 절대 경로: /Users/...
* 상대 경로: ./app

---

## 15. 트러블슈팅

### 문제 1: 포트 충돌

```bash
lsof -i :8080
```

👉 해결: 포트 변경

---

### 문제 2: 데이터 유실

👉 원인: 컨테이너 내부 저장
👉 해결: volume 사용

---

## 🎤 16. 심층 질문 대비

### 포트 충돌 해결 순서

1. 포트 사용 확인
2. 프로세스 종료 또는 포트 변경

---

### 데이터 유실 방지

* Docker Volume 사용

---

### 가장 어려웠던 점

작성해야함.

---

## 17. 결론

이 프로젝트를 통해 컨테이너 기반 개발 환경과 재현 가능한 시스템 구축을 이해하였다.
🚀 실행
```bash
docker run -d -p 8080:80 --name my-web my-web:1.0
```
