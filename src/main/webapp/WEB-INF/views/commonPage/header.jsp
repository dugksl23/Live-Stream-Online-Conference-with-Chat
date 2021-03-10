<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

</head>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	margin:auto;
}
	
.header {
	width: 1200px;
	margin: auto;
}	

 
.row1_end>ul{
    list-style-type: none;
    border:none;
    height:30px;
}    
.row1_end>ul>li{
    float: right;
	font-weight: 800;
	width: 60px;
	font-size: 13px;
	font-family: fantasy;
	text-align: center;
	transition-duration: 0.3s;    
}    


.row1_end>ul>li:hover {
	float: right;
	font-weight: 800;
	font-size: 13px;
	font-family: fantasy;
	text-align: center;
	transition-duration: 0.3s;
	color: cornflowerblue;
	text-decoration: underline;
	cursor: pointer;
}


</style>
<body>

<!--  === header  start ===-->


    <div class="container header">
        <div class="row" style="height:10px;"></div>
		<div class="row d-flex">
		   <div class="col-md-6 col-md-offset-4 row1_center">
			</div>
			
			<div class="col-md-6 text-end row1_end">
				<ul>
					<li id="signup">회원가입</li>
					<li id="signin" data-bs-toggle="modal" data-bs-target="#signin-Modal">로그인</li>
					<li id="signout">로그아웃</li>
					<li id="signed">${id}</li>
				 </ul>
			</div>
		</div>
	
	    <div class="row d-flex">
                <div class="col-md-12">
                <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                  <div class="carousel-inner">
                    <div class="carousel-item active" data-bs-interval="10000">
                      <img src="/resources/popupSignin/images/bg-01.jpg" class="d-block w-100" style="height:140px;">
                    </div>
                    <div class="carousel-item" data-bs-interval="2000">
                      <img src="/resources/popupSignin/images/bg-01.jpg" class="d-block w-100" style="height:140px;">
                    </div>
                    <div class="carousel-item">
                      <img src="/resources/popupSignin/images/bg-01.jpg" class="d-block w-100" style="height:140px;">
                    </div>
                    
                  </div>
                 <!--  <a class="carousel-control-prev" href="#carouselExampleInterval" role="button" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#carouselExampleInterval" role="button" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                  </a> -->
                </div>
            </div>    
        </div>
    </div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>


<c:choose>
	<c:when test="${id!=null}">
    <script>
			$('#signin').hide();
			$('#signup').hide();
			$('#signout').show();
			$('#signed').show();
			
			$('#signout').on('click', function() {


				if ('${userInfo[0].sns_code}' == '01') {
					location.href = "/member/k_signout.member";
				} else if ('${userInfo[0].sns_code}' == '02') {
					location.href = "/member/d_signout.member";
				}
			});
			
			$('#signed').on('click', function(){
				location.href="/mypage/myInfo.mypage?id=${id}";
			});
	
			
		</script>
	</c:when>
	<c:when test="${id==null}">
		<script>
			$('#signin').show();
			$('#signup').show();
			
			$('#signout').hide();
			$('#signed').hide();
			

			$('#signup').on('click', function(){
					location.href="/member/signupProc.member";
			})
		</script>
	</c:when>
</c:choose>


    <!-- Modal -->
    <div class="modal fade" id="signin-Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <jsp:include page="/WEB-INF/views/login/popUpSigninView.jsp"/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</body>

<script>


</script>

<!-- zoom 전용 웹소켓 통신을 위한 ws 변수 및 function -->
<script>
function connectWs(){
	return new WebSocket("ws://localhost/tutors");
	//url 요청은 localhost면 localhost로
	// 실제 url을 입력했다면 실제 url로 입력해야 한다.
} 



</script>

<!-- chat 전용 SockJS 소켓 통신을 위한 SockJS function -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
	
<script>
function connectSockJS(){
	// === <전체 흐름 : 1. 채팅 웹소켓 연결 >
	return new SockJS("http://localhost/chat");

} 

</script>

<script>
//==== zoom 회의가 끝나고, 회의 종료가 아닌 page 이동 시에 connection을 감지하기 위한 로직
$(document).ready(function(){
 	$.ajax({
		url:"/zoom/deleteTutors.zoom",
		type:"get",
		data:{host_id:'${id}'}
	}) 
}) 

</script>


</html>