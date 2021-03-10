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
nav {
	width: 1200px;
	margin: 0 auto;
	text-align: center;
	margin-TOP:10px;
	margin-bottom:10px;
	
}

.nav-link{
	line-height:2.5;
	color:black;
}

.heading {
    border-bottom: 1px solid #fcab0e;
    padding-bottom: 9px;
    position: relative;
}
.heading span {
    background: #9e6600 none repeat scroll 0 0;
    bottom: -2px;
    height: 3px;
    left: 0;
    position: absolute;
    width: 75px;
} 
</style>

<body>
<div class="container bg-light border">
		<div class="row nav">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <div class="container">
		    <a class="navbar-brand" href="/">
		    	<h4 class="heading"><strong>Home</strong></h4>
			</a>
        	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    
		    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
		      <div class="navbar-nav">
		        <a class="nav-link" id="board" href="/board/boardList.board?cPage=1&board_code=00">자유게시판</a>
				<a class="nav-link" href="/zoom/zoomBoard.zoom">Tutor 찾기</a>
			</div>
		    </div>
		    
		    <c:if test="${id!=null}">
		    <div class="row">
		    
		    </div>
		    
		    <div class="row">
		      	<div class="col-md-12">
		      		<span><a id="head_zoom" data-bs-toggle="modal" data-bs-target="#zoom-modal"><i class="bi bi-camera-video" style="color:black; font-size:20px; cursor:pointer;"></i></a></span>
					<span><a id="head_chat" data-bs-toggle="modal" data-bs-target="#chat-modal"><i class="bi bi-chat-left-dots-fill" style="color:orange;font-size:20px; cursor:pointer;" id="chatting_icon"></i></a></span>
		      	</div>
		     </div>
		     </c:if>
		  </div>
		</nav>
		</div>
	</div>
	
	
				 

	<!-- //=================================================================
	==============================[채팅용 modal] =============================-->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<!-- Modal -->
	<div class="modal fade" id="chat-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content" style="border:none; background:gray;">
			 <div class="modal-body" style="border:none; background:gray;">
				<iframe id="chatlist_iframe" src="/chat/friendsList.chat" class="js-pscroll" style="width:100%; height:74vh; background:gray;"></iframe>
			 </div>
			 </div>
		</div>
	</div>

	<!-- //=================================================================
	==============================[zoom meeting holding용 modal] =============================-->
	
 		<!-- Modal -->
	    <div class="modal fade" id="zoom-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-sm">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div id="reg_tutor-Modal" class="modal-body">
	                      	<iframe id="zoom_iframe" src="/zoom/regTutor_Iframe.zoom" style="height:250px; width:283px;"></iframe>
					 </div>
	                <div class="modal-footer">
	                	<button id="join_meeting" type="submit" class="btn btn-dark text-start" data-bs-dismiss="modal">Join Meeting</button>
	                	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	                </div>
	            </div>
	        </div>
	    </div>

	<!-- ==== join-btn script==========================================================================-->
	<script>
	
		$('#join_meeting').on('click', function(){
			if('${id}'==''){
				alert('로그인을 해주세요.');
			}else{
				var join_meeting_btn=$('#zoom_iframe').contents().find('#join_meeting');
				var mn=$('#zoom_iframe').contents().find('#meeting_number').val();
				var name=$('#zoom_iframe').contents().find('#display_name').val();
				
				if(mn!=''&&name!=''){
					join_meeting_btn.trigger('click');
				}else{
					alert("미팅 번호 or 이름이 입력되지 않았습니다.");
			    }
			}
		})
	</script>


</body>
</html>