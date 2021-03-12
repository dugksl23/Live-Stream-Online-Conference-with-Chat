# Web conference and chat


**made by**  Yohan 김요한<br>
**contact**  010-3905-1285<br>
**email address**  dugksl23@naver.com<br>
**hosting addrres**  <http://13.209.87.252>

# 목차
#### 1. 프로젝트 소개
#### 2. 개발 환경
#### 3. 개발 의존성
#### 4. 주요기능
#### 5. 실행 영상

---

## 1. 프로젝트 소개

 - WEB 기반의 원격 회의 기능 및 채팅 기능을 통합한 원격 회의 전용 웹 사이트

---

## 2. 개발 환경

* **WAS** 
  * Apache-tomacat-8.5
  
* **Java EE IDE** 
  * Eclipse
  
* **DB** 
  * Oracle SQL Developer 11g
  
* **개발 언어** 
  * **Back-end** 
    * Java (jdk 1.8)
      *  JSP (JSTL) 
  * **Front-end** 
    * HTML
    * CSS
    * JavaScript
      * Jquery 3.5
       
* **프레임워크**
  * Spring Mybatis Legacy
  * maven
  
* **라이브러리**
  * Bootstrap 5
  * Spring Sockets (WebSocket, SockJS, Stomp)
  * Commons Email
  * CKeditor5
 
* **형상관리**
  * GithuB
  
* **외부 API**
  * Kakao Login REST API
  * ZOOM API
  * Duam 우편번호 찾기 API
  
* **WEB Hosting**
  * AWS EC2 Window

---

## 3. 개발 의존성

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>kh.pofo</groupId>
	<artifactId>controller</artifactId>
	<name>Fianl_Project</name>
	<packaging>war</packaging>
	<version>1.0.0-BUILD-SNAPSHOT</version>
	<properties>
		<java-version>1.8</java-version>
		<org.springframework-version>5.2.1.RELEASE</org.springframework-version>
		<org.aspectj-version>1.6.10</org.aspectj-version>
		<org.slf4j-version>1.6.6</org.slf4j-version>
	</properties>


   <!--OJDBC repo -->
   <repositories>
    <repository>
     <id>OJDBC6 repo</id>
     <url>https://www.datanucleus.org/downloads/maven2/</url>
    </repository>
   </repositories>

   <dependencies>


    <!-- Servlet 쓰레드 -->
    <dependency>
       <groupId>javax.servlet</groupId>
       <artifactId>javax.servlet-api</artifactId>
       <version>3.0.1</version>
       <scope>provided</scope>
    </dependency>


    <!-- WebSocket -->
    <dependency>
     <groupId>org.springframework</groupId>
     <artifactId>spring-websocket</artifactId>
     <version>${org.springframework-version}</version>
    </dependency>

    <dependency>
     <groupId>org.springframework</groupId>
     <artifactId>spring-messaging</artifactId>
     <version>${org.springframework-version}</version>
    </dependency>

    <!-- stomp -->
    <dependency>
     <groupId>org.springframework.integration</groupId>
     <artifactId>spring-integration-stomp</artifactId>
     <version>5.3.2.RELEASE</version>
    </dependency>


    <!-- jackson -->
    <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-core</artifactId>
            <version>2.9.9</version>
       </dependency>




    <dependency>
     <groupId>javax.servlet</groupId>
     <artifactId>javax.servlet-api</artifactId>
     <version>3.1.0</version>
     <scope>provided</scope>
    </dependency>


    <!-- https://mvnrepository.com/artifact/javax.websocket/javax.websocket-api -->
    <dependency>
     <groupId>javax.websocket</groupId>
     <artifactId>javax.websocket-api</artifactId>
     <version>1.1</version>
     <scope>provided</scope>
    </dependency>

    <!-- https://mvnrepository.com/artifact/github.ilevshevich.annotation-processor/require-non-null-processor -->



    <!-- https://mvnrepository.com/artifact/com.squareup.okhttp/okhttp -->
    <dependency>
     <groupId>com.squareup.okhttp</groupId>
     <artifactId>okhttp</artifactId>
     <version>2.7.5</version>
    </dependency>

    <dependency>
     <groupId>com.squareup.okhttp3</groupId>
     <artifactId>okhttp</artifactId>
     <version>3.8.1</version>
    </dependency>
    <!-- Thanks for using https://jar-download.com -->


    <!-- jwt 토큰 발급 maven -->
    <dependency>
     <groupId>io.jsonwebtoken</groupId>
     <artifactId>jjwt</artifactId>
     <version>0.9.1</version>
    </dependency>

    <!-- jwt xml binding을 위한 maven 종속주입 -->
    <dependency>
     <groupId>javax.xml.bind</groupId>
     <artifactId>jaxb-api</artifactId>
     <version>2.1</version>
    </dependency>

    <!-- 메일 api -->
    <dependency>
     <groupId>org.apache.commons</groupId>
     <artifactId>commons-email</artifactId>
     <version>1.2</version>
    </dependency>


    <!-- https://mvnrepository.com/artifact/com.googlecode.json-simple/json-simple -->
    <dependency>
     <groupId>com.googlecode.json-simple</groupId>
     <artifactId>json-simple</artifactId>
     <version>1.1</version>
    </dependency>

    <!--jsonArr - https://mvnrepository.com/artifact/com.google.code.gson/gson -->
    <dependency>
     <groupId>com.google.code.gson</groupId>
     <artifactId>gson</artifactId>
     <version>2.8.6</version>
    </dependency>


    <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
    <dependency>
     <groupId>org.springframework</groupId>
     <artifactId>spring-jdbc</artifactId>
     <version>5.2.10.RELEASE</version>
    </dependency>

    <dependency>
     <groupId>oracle</groupId>
     <artifactId>ojdbc6</artifactId>
     <version>11.2.0.3</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/org.apache.commons/commons-dbcp2 -->
    <dependency>
     <groupId>org.apache.commons</groupId>
     <artifactId>commons-dbcp2</artifactId>
     <version>2.8.0</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/com.google.code.gson/gson -->
    <dependency>
     <groupId>com.google.code.gson</groupId>
     <artifactId>gson</artifactId>
     <version>2.8.6</version>
    </dependency>

    <!-- Mybatis -->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
     <groupId>org.mybatis</groupId>
     <artifactId>mybatis</artifactId>
     <version>3.4.6</version>
    </dependency>


    <!-- Spring + Mybatis Collaborate -->
    <dependency>
     <groupId>org.mybatis</groupId>
     <artifactId>mybatis-spring</artifactId>
     <version>1.3.2</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/commons-fileupload/commons-fileupload -->
    <dependency>
     <groupId>commons-fileupload</groupId>
     <artifactId>commons-fileupload</artifactId>
     <version>1.4</version>
    </dependency>
    <!-- kor directory -->
    <dependency>
     <groupId>xerces</groupId>
     <artifactId>xercesImpl</artifactId>
     <version>2.9.1</version>
    </dependency>
  </project>
```

---

## 4. 주요 기능


 1. **게시판 페이지**
    * 글쓰기 / 글 수정 / 글 삭제 / 댓글 작성 / 댓글 수정 / 댓글 삭제/ (CRUD) / 좋아요 기능/ 검색 기능 / Paging 처리
 
 2. **회원 페이지** 
    * 회원가입 / 회원 정보 수정 / 탈퇴 / 아이디 및 비밀번호 찾기
 
 3. **채팅**  
    * 친구 추가 / 1:1 채팅 / 단체 채팅 / Zoom 화상 회의 초대
 
 4. **화상 회의 게시판** 
    * Zoom API를 활용한 화상 회의

---

## 5. 실행 영상


 
