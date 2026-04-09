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
Docker version 29.3.1, build c2be9cc
git version 2.43.0
```

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
/mnt/c/Windows/system32

```


권한 변경
ls -l test.txt
chmod 755 test.txt
ls -l test.txt

결과:

(변경 전/후 비교 결과)

## 5. Docker 설치 및 점검
docker --version
docker info

결과:

(출력 복붙)

## 6. Docker 기본 운영 명령
docker run hello-world
docker images
docker ps -a
docker logs <컨테이너ID>
docker stats

결과:

(출력 복붙)

## 7. 컨테이너 실행
docker run -it ubuntu bash

컨테이너 내부:

ls
echo "inside container"
exit

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

## 9. 포트 매핑 검증
curl http://localhost:8080

결과:

Hello Docker

또는 브라우저 접속:

http://localhost:8080

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

## 12. Git 설정
git config --global user.name "yourname"
git config --global user.email "you@example.com"
git config --list

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
