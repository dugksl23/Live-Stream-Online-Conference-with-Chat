<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">



<title>Insert title here</title>
</head>

<style>


.section_main{
	width: 1200px;
    position: relative;
	z-index: 1;  
    margin: 0 auto;
} 
    
._main {
	margin: auto;
	width:1200px;;
}
</style>


<body>
    	
           <div class="container section_main">
               <div class="row" style="height:40px;"></div>
               <div class="row">
               		<c:if test="${id eq null}">
               		<div class="col-md-12">
     					<strong>로그인을 하시고 화상 회의를 이용해주세요!</strong>
     				</div>
     				</c:if>
     				<c:if test="${id ne null}">
						<div class="col-lg-8 col-md-10">
							<div class="forgot">
								<h2>Web 화상 회의 이용하는 방법</h2>
								<p></p>
								<ol class="list-unstyled">
									<li><strong>미팅 주최자</strong>
									</li>
									
									<li><span class="text-primary text-medium">1. </span>
										우측 끝단의 <i class="bi bi-camera-video" style="color:black; font-size:20px; cursor:pointer;"></i> 을 클릭해주세요.
									</li>
									<li><span class="text-primary text-medium">2. </span>
										클릭 후에는 모달창이 생성되며, 미팅 번호에 "5350344957" 를 입력해주세요.
									</li>
									<li><span class="text-primary text-medium">3. </span>
										진행하고 싶은 언어를 선택하시고, Join Meeting 버튼을 눌러주세요.
									</li>
									<li><span class="text-primary text-medium">4. </span>
										미팅이 개최가 되면, 우측 상단의  <i class="bi bi-camera-video" style="color:black; font-size:20px; cursor:pointer;"></i> 를 클릭하시고,
										참가를 희망하는 회원의 채팅창을 통해 참가자를 미팅에 초대해주세요.
									</li>
									
								</ol>
								<p></p>
								<ol class="list-unstyled">
									<li><strong>미팅 참가자</strong>
									</li>
									
									<li><span class="text-primary text-medium">1. </span>
										Tutor 찾기 게시판으로 이동해주세요.
									</li>
									<li><span class="text-primary text-medium">2. </span>
										현재 미팅을 주최하고 있는 Tutor의 테이블 정보가 나열되고 있습니다.
										해당 테이블의 우측 끝단의  <span><a id="head_chat" data-bs-toggle="modal" data-bs-target="#chat-modal"><i class="bi bi-chat-left-dots-fill" style="color:orange;font-size:20px; cursor:pointer;" id="chatting_icon"></i></a></span> 클릭해주세요.
									</li>
									<li><span class="text-primary text-medium">3. </span>
										채팅창이 활성화가 되면서 친구찾기 기능에 Tutor의 이름이 기입되어져 있습니다.
									</li>
									<li><span class="text-primary text-medium">4. </span>
										친구 찾기를 통해서 친구추가를 하시고, 메세지를 통해 미팅에 참가하고 싶다는 의사를 밝혀주세요!
										그후, 주최자는 해당 미팅에 참가자들을 선별하여 초대를 할 것입니다.
									</li>
									<li><span class="text-primary text-medium">5. </span>
										미팅 주최자가 참가자를 초대하면, 채팅창 우측 상단에 <i class="bi bi-camera-video" style="color:black; font-size:20px; cursor:pointer;"></i> 가 활성화가 됩니다.
										해당 아이콘을 클릭하시고 Join Meeting 버튼을 통해 참가해주세요.
									</li>
									
								</ol>
								
							</div>
						</div>
					</c:if>
               </div>

           </div>
    

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    

</body>
</html>