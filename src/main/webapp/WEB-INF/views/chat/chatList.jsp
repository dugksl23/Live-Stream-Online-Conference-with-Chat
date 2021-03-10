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
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}
.menu_head{
margin-top:15px;
}
.menu_head>ul{
list-style:none; 
}


#add_room_btn{
	color:white;
	padding-right: 10px;
}

.menu_head li{
	color:white;
}

#add_room_btn{
	cursor:pointer;
}
</style>
<body>


	<div class="container">
		<div class="row justify-content-center head-100 js-pscroll">
			<div class="col-md-5 col-xl-4 chat head-100">
				<div class="card mb-sm-3 mb-md-0 contacts_card">
					<div class="card-header">
						<div class="input-group">
							<input id="inputKeyword" type="text" placeholder="Search Chat..." name="" class="form-control search">
							<div class="input-group-prepend">
								<span class="input-group-text search_btn">
								<i class="fas fa-search"></i></span>
							</div>
						</div>
                       <div class="menu_head">
								<ul style="margin-top:20px;">
									<li id="add_room_btn"><i class="fas fa-plus" id=""></i> 채팅방 개설</li>
								</ul>
				        </div>
                     </div>
					
					
					
					<div class="card-body contacts_body">
						<ui class="contacts">
						<!-- chatList body -->
						<c:forEach var="i" items="${chatUserList}">
							 <c:forEach var="j" items="${joinUserList}">
							 <c:choose>
							 <c:when test="${i.room_id == j.room_id}">
							 	<li class="" id="${i.room_id}">
								 	<div class="d-flex bd-highlight">
										<div class="img_cont">
											<img src="${j.thumbnail_url}" class="rounded-circle user_img"> 
										</div>
										<div class="user_info">
											<a href="/chat/chatting.chat?room_id=${i.room_id}&receiver_thumbnail_url=${j.thumbnail_url}&receiver_id=${j.user_id}">
											<span>${j.user_id}</span>
											</a>
											<p>${i.chat_content}</p>
											<p><span style="font-size:5px;">${i.date}</span></p>
										</div>
									</div>
							   </li>
							   </c:when>
							   </c:choose>
							</c:forEach>
						</c:forEach>
						<!-- multichatList body -->
						<c:forEach var="i" items="${multiChatList}">
							 	<li class="" id="${i.room_id}">
								 	<div class="d-flex bd-highlight">
										<div class="img_cont">
											<img src="${i.thumbnail_url}" class="rounded-circle user_img"> 
										</div>
										<div class="user_info">
											<a href="/chat/multiChatting.chat?room_id=${i.room_id}&receiver_thumbnail_url=${j.thumbnail_url}&receiver_id=${j.user_id}">
											<span>익명 채팅방</span>
											</a>
										</div>
									</div>
							   </li>
						</c:forEach>
						
						
						
						
						
						
						</ui>
					</div>
					<div class="row card-footer">
						<div class="col-6 text-center">
								<a href="/chat/friendsList.chat?user_id=${id}"><i class="bi bi-person" style="font-size: 2rem;"></i></a>
						</div>
						<div class="col-6 text-center">
								<a href="/chat/chatList.chat"><i class="bi bi-chat" style="font-size: 2rem;"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<!------ Include the above in your HEAD tag ---------->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
	

	<script>
 	
	var sjs = parent.connectSockJS(); 

	var client = Stomp.over(sjs);
	client.connect({}, function() {
		client.subscribe('/subscribe/chat/user/'+'${id}', function(res){
			
			var chat=JSON.parse(res.body);
			$.ajax({
				url:"/chat/searchFriends.chat",
				type:"get",
				data:{
					receiver_id:chat.receiver_id
				}
			}).done(function(res){
				
				var result=JSON.parse(res);
				if(result.result==1){
					return false;
				}else{
					$('.contacts').prepend(
							
							'<li class="" id='+chat.room_id+'>'+
								'<div class="d-flex bd-highlight">'+
									'<div class="img_cont">'+
										'<img src='+chat.sender_thumbnail_url+' class="rounded-circle user_img">'+ 
										 //'<span class="online_icon"></span>'+
									'</div>'+
									'<div class="user_info">'+
										'<a href="/chat/chatting.chat?room_id='+chat.room_id+'&receiver_id='+chat.receiver_id+'"><span>'+chat.sender_id+'</span></a>'+
										'<p>최신 메세지</p>'+
									'</div>'+
								'</div>'+
							'</li>'
						);
					//3. 동기화를 통해서는 friendsList.jsp에서 if문 분기점을 통한
					//   구독자가 아닌 대상에 한해서 구독자의 server를 통해 동기화 작업을 진행한다.	
				}
			})
		})
	})
	</script>
	
	
	<script>

		$('.search_btn').on('click', function(){
			searchKeyword();
		})
	
		$('#inputKeyword').on('keydown', function(e){
			if(e.keyCode==13){
				searchKeyword();
			}
		})
		
		function searchKeyword(){
			
			$.ajax({
				url:"/chat/searhRoom.chat",
				type:"get",
				data:{
					keyword:document.getElementById("inputKeyword").value
				}
		
			}).done(function(res){
				var result=JSON.parse(res);
				var joinUserList=JSON.parse(result.joinUserList);
				var chatUserList=JSON.parse(result.chatUserList);
				
				$('.contacts').remove();
				for(i=0; i<joinUserList.length; i++){
					
					for(j=0; j<chatUserList.length; j++){
						
						if(joinUserList.room_id==chatUserList.room_id){
							
							var ulTag=$('<ui>');
							ulTag.addClass('contacts');
							$('.contacts_body').append(ulTag);
							
							ulTag.append(
									
									'<li class="" id='+chatUserList[j].room_id+'>'+
										'<div class="d-flex bd-highlight">'+
											'<div class="img_cont">'+
												'<img src='+joinUserList[i].thumbnail_url+' class="rounded-circle user_img">'+ 
											'</div>'+
											'<div class="user_info">'+
												'<a href="/chat/chatting.chat?room_id='+chatUserList[j].room_id+'"><span>'+joinUserList[i].user_id+'</span></a>'+
												'<p>'+chatUserList[j].chat_content+'</p>'+
												'<p><span style="font-size:5px;">'+chatUserList[j].date+'</span></p>'+
											'</div>'+
										'</div>'+
									'</li>'
								);
							
						}
					}
				}
			})
		}

		
		
	</script>
	<script>
	$('#add_room_btn').on('click', function(){
		location.href="/chat/addChatRoom.chat";
	})

</script>


</body>
</html>