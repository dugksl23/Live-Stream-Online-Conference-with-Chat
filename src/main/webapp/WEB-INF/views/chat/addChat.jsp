<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">
<link rel="stylesheet" type="text/css" href="/resources/chat/chat.css?version=19">
<!--===============================================================================================-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<title>Insert title here</title>
</head>
<style>
.non-active:hover{
		background-color: rgba(0, 0, 0, 0.3);
}	
</style>

<body>



	<div class="container">
		<div class="row justify-content-center">
			<div class="col-md-5 col-xl-4 chat">
				<div class="card mb-sm-3 mb-md-0 contacts_card">
				
					<div class="card-header">
                        <div class="row input-group" style="color:white; font-weight:600;">
                            <div class="col-3">
                                <a href="/chat/chatList.chat"><i class="bi bi-arrow-left"></i></a> 초대 
                            </div>
                            <div class="col-9" style="text-align:right;">
                               <a id="btn_createMultiChatRoom" style="cursor:pointer;">OK</a>
                            </div>
						</div>
					    <div class='row' style="height:10px;"></div>
					    <div class="input-group">
							<input type="text" placeholder="Search..." name=""
								class="form-control search">
							<div class="input-group-prepend">
								<span class="input-group-text search_btn"><i
									class="fas fa-search"></i></span>
							</div>
						</div>
				    </div>
					
					<div class="card-body contacts_body">
						<ui class="contacts">
						<c:forEach var="i" items="${friendsList}">
						<li class="non-active">
							<div class="d-flex bd-highlight userInfo">
								<div class="img_cont">
									<img src="${i.thumbnail_url}" class="rounded-circle user_img"> 
								</div>
								<div class="user_info">
									<span style="float:left;" id="user_id">${i.user_id}</span>
									<div style="width:300px; text-align:right;">
										<div class="form-check">
										 <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
										 </div>
									</div>
								</div>
							</div>
						</li>
						</c:forEach>
						</ui>
					</div>
					<div class="card-footer"></div>
				</div>
			</div>
		</div>
	</div>


<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>


<script>
$('#btn_createMultiChatRoom').on('click', function(){
	
	var join_id="multi"+guid().replace(/-/gi,"");
	var room_id="multi"+guid().replace(/-/gi,"");
	

	$('.form-check-input').each(function(){
		if($(this).is(":checked")){
			
			var userInfos=$(this).closest('div.userInfo');
			var user_id=userInfos.find('#user_id').html();
			
			var chatJoinRoomDTO={
					join_id:join_id,
					user_id:user_id,
					room_id:room_id
			}
			console.log(chatJoinRoomDTO);
			
			$.ajax({
				url:"/chat/inviteFriends.chat",
				type:"post",
				data:chatJoinRoomDTO
			}).done(function(res){
				location.href=res;
			}) 
		}
	});

})


		
	function guid() {
		function _s4() {
			return ((1 + Math.random()) * 0x10000 | 0).toString(16)
					.substring(1);
		}
		return _s4() + _s4() + '-' + _s4() + '-' + _s4() + '-' + _s4()
				+ '-' + _s4() + _s4() + _s4();
	}
	
	
	
</script>


</body>
</html>