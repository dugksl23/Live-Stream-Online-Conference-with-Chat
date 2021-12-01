# Live Stream Online Conference with Chat


**made by**  Yohan 김요한<br>
**contact**  (82) 10-3905-1285<br>
**email address**  dugksl23@naver.com<br>
**hosting addrres**  <http://13.209.87.252>

# 목차
#### 1. Project Introduction
#### 2. Development environment
#### 3. Development dependencies
#### 4. Main Features Summary
#### 5. Main function description

---

## 1. Project Introduction

 - Provides web-based Live Streaming and Chatting complex services.


## 2. Development environment

* **WAS** 
  * Apache-tomacat-8.5
  
* **Java EE IDE** 
  * Eclipse
  
* **DB** 
  * Oracle SQL Developer 11g
  
* **Languages** 
  * **Back-end** 
    * Java (jdk 1.8)
      *  JSP (JSTL) 
  * **Front-end** 
    * HTML
    * CSS
    * JavaScript
      * Jquery 3.5
       
* **Framework**
  * Spring Mybatis Legacy
  * maven
  
* **Libraries**
  * Bootstrap 5
  * Spring Sockets (WebSocket, SockJS, Stomp)
  * Commons Email
  * CKeditor5
 
* **Congifuation Management**
  * Git
  * GithuB
  
* **External API**
  * Kakao Login REST API
  * ZOOM API
  * Duam 우편번호 찾기 API
  
* **WEB Hosting**
  * AWS EC2 Window


## 3. Development dependencies

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





## 4. Main Features Summary

 #### 1. **Board**
     - read the post page  
	1) Previous article and next article
	2) writing a comment and deletion and edit 
	3) Writing a 
	4) Post deletion and edit 
	5) image upload
	6) Like feature

     - 게시글 테이블 페이지
	1) read the post
	2) writing
	3) Search by condition
	4) Paging
 
 #### 2. **회원**
	1) 회원가입
	2) 회원정보 수정
	3) 회원탈퇴
	4) 아이디 및 비밀번호 찾기 
 	
 #### 3. **채팅**  
	1) 친구 찾기
	2) 친구 추가
	3) 1:1 채팅
	4) 단체 채팅
	5) 새로운 친구
	6) 채팅 목록

 #### 4. **화상 회의 게시판**
	1) Zoom API를 활용한 화상 회의

 #### 5. **화상 회의 초대**
	1) 채팅을 통한 화상 회의 초대
	2) 채팅을 통한 회의 참가

	





	
## 5. 주요 기능 설명

--- 

### 게시판 
 - **게시글 읽기 페이지**

![image](https://user-images.githubusercontent.com/68539491/110901249-624c0d00-8347-11eb-927c-26abfa4cc20a.png)
 

 - **게시글 테이블 페이지**

![image](https://user-images.githubusercontent.com/68539491/110902995-151d6a80-834a-11eb-8fb7-0b0419936f0c.png)

---

### 마이페이지 (회원) 
 - **회원가입 페이지**

![image](https://user-images.githubusercontent.com/68539491/110903363-aee51780-834a-11eb-86bf-8ca069198f19.png)

 - **회원정보 보기 페이지**

![image](https://user-images.githubusercontent.com/68539491/110903562-fc618480-834a-11eb-9590-7c731e9c644a.png)

---

### 채팅
 - **친구 목록 페이지**

![image](https://user-images.githubusercontent.com/68539491/110903690-29ae3280-834b-11eb-9fd5-aecf9ad02ccd.png)


 - **채팅 목록 페이지**
 
![image](https://user-images.githubusercontent.com/68539491/110903708-33379a80-834b-11eb-8608-4d20dc86be08.png)


 - **1:1 채팅 페이지**
 
![image](https://user-images.githubusercontent.com/68539491/110903744-3fbbf300-834b-11eb-9fd6-8ec704b0d15f.png)


---

### 화상 회의 
 - **화상 회의 개최**
 
![image](https://user-images.githubusercontent.com/68539491/110904064-bce76800-834b-11eb-81cd-9929ed48a724.png)
![image](https://user-images.githubusercontent.com/68539491/110904137-d983a000-834b-11eb-8688-aa873eb48f4f.png)
![image](https://user-images.githubusercontent.com/68539491/110904279-1354a680-834c-11eb-8be3-641494766d51.png)


---

### 화상 회의 초대 / 참가
 - **화상 회의 초대**
 
![image](https://user-images.githubusercontent.com/68539491/110904398-3ed79100-834c-11eb-8801-aee8a5cab171.png)

![image](https://user-images.githubusercontent.com/68539491/110904420-49922600-834c-11eb-8a99-4b3f9306cc15.png) 

  - **화상 회의 참가**
  
![image](https://user-images.githubusercontent.com/68539491/110904456-5adb3280-834c-11eb-8992-e6c6bf92bfb9.png)

	


 


 
