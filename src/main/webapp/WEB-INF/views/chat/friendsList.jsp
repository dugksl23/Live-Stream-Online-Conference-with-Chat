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
<style>

#friends_id{
cursor:pointer;
}
#friends_id:hover{
cursor:pointer;
text-decoration:underline;
text-decoration-color: blue;
}

.profile_title{
	color:white;
	font-weight:600;
}
</style>

</head>
<body>


	<div class="container">
		<div class="row justify-content-center head-100 js-pscroll">
			<div class="col-md-5 col-xl-4 chat head-100">
				<div class="card mb-sm-3 mb-md-0 contacts_card">
					<div class="card-header">
						<div class="input-group">
							<input type="text" placeholder="Search..." name=""
								class="form-control search inputTutors" id="inputTutors">
							<div class="input-group-prepend">
								<span class="input-group-text search_btn searchTutors"> <i
									class="fas fa-search"></i></span>
							</div>
						</div>
						<div class="row" style="height: 20px;"></div>
						<div class="profile_title">My Profile</div>
						<div style="height:5px;"></div>
						<div class="d-flex bd-highlight user_info_body">
							<div class="img_cont">
								<img src="${userInfo[0].thumbnail_url}"
									class="rounded-circle user_img"> <span
									class="online_icon"></span>
							</div>
							<div class="user_info">
								<span>${id}</span>
							</div>
						</div>
					</div>


					<div class="profile_title">
						<span class="friendsCount">Friends ${current_FriendsCount}</span></div>
					<div class="card-body contacts_body">
						<ui class="contacts">
						<c:forEach var="i" items="${friendsList}">
							<li class="active">
								<div class="d-flex bd-highlight contacts_user" id='${i.user_id}'>
									<div class="img_cont">
										<img src='${i.thumbnail_url}' class='rounded-circle user_img'>
									</div>
									<div class="user_info">
										<a href="/chat/chatting.chat?room_id=${i.room_id}&receiver_thumbnail_url=${i.thumbnail_url}&receiver_id=${i.user_id}" class="contacts_id"><span>${i.user_id}</span></a>
									</div>
								</div>
							</li>
						</c:forEach> 
						</ui>
					</div>
					<div class="row card-footer">
						<div class="col-6 text-center">
							<a href="/chat/friendsList.chat?friendsCount=${current_FriendsCount}"><i
								class="bi bi-person" style="font-size: 2rem;"></i></a>
						</div>
						<div class="col-6 text-center">
							<a href="/chat/chatList.chat"><i class="bi bi-chat"
								style="font-size: 2rem;"></i></a>
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
	<!--===============================================================================================-->
	<script src="/resources/board/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	
	<script>
		$('.js-pscroll').each(function() {
			var ps = new PerfectScrollbar(this);

			$(window).on('resize', function() {
				ps.update();
			})
		});
	</script>
	

	<script>
	
		$('.searchTutors').on('click', function(){
			
			if($('.inputTutors').val()=='${id}') {
				return false;
			} else if($('.inputTutors').val()!=''){
				searchTutors();
			}
		})
		
		$('.inputTutors').on('keydown', function(e){
				if(e.keyCode==13){
					if($('.inputTutors').val()=='${id}') {
						return false;
					} else if($('.inputTutors').val()!=''){
						searchTutors();
					}
				}
		})
			
		function searchTutors(){
			$.ajax({
				url : '/member/duplicateCheck.member',
				type : "get",
				data : {
					id : $('.inputTutors').val()
				},
				success : function(res) {
					if(res=='사용 가능한 ID입니다.'){
						alert('존재하지 않는 아이디 입니다.');
						$('.inputTutors').val('');
					}else{
						
						var result=confirm($('.inputTutors').val()+"님을 추가하시겠습니까?");
						
						if(result){
						
							//===== 1. 비동기 친구 추가=======================
							$.ajax({
								url:"/chat/searchFriends.chat",
								type:"get",
								data:{receiver_id:$('.inputTutors').val()}
							}).done(function(e){
								var obj=JSON.parse(e);
								
								if(obj.friends=="notAdded"){
									$('.friendsCount').html("Friends"+" "+obj.frinedsCount);
									var newFriends=$('.contacts');
									
									var friends=JSON.parse(obj.addFriends);
									newFriends.prepend(
												'<li class="active offline">'+
												'<div class="d-flex bd-highlight contacts_user" id='+friends[0].id+'>'+
													'<div class="img_cont">'+
														'<img src="'+friends[0].thumbnail_url+'" class="rounded-circle user_img">'+
															/* '<span class="online_icon"></span>'+ */
													'</div>'+
													'<div class="user_info">'+
														'<span id="friends_id">'+friends[0].id+'</span>'+
														/*'<p>'+friends[0].id+' is online</p>'+*/
													'</div>'+
												'</div>'+
												'</li>'
									);
									//===== 2. 친구를 db에 추가 ===================
									$.ajax({
										url:"/chat/addFriends.chat",
										type:"get",
										data:{
											user_id:'${id}',
											friends_id:$('.inputTutors').val()
										}
									}).done(function(res){
										$('.inputTutors').val('');		
									})	
									
								}else{
									return false;
								}
							})
						}
					}
					
				}
			})
		}
	</script>
	

	<script>
		$('.card-footer>div:eq(0)>a:eq(0)').on('click', function(){
			var cPage=location.href;
			if(cPage==location.href){
				return false;
			}
		})
	</script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

 	<script>
	
	var room_id="notCreated";
	if('${id}'!=''){
		
		
		$(document).on('click', '.contacts_user', function(){
			
			var receiver=$(this).closest('div.contacts_user');
			
			$.ajax({
				url:"/chat/findRoom_idBy",
				type:"get",
				data:{
					receiver_id:receiver.attr("id")
				}
			}).done(function(res){
				room_id=res;
			})
			
	
			var sjs= parent.connectSockJS(); 
			
			client = Stomp.over(sjs);

			client.connect({}, function(){
				console.log('본인용 채널을 생성을 위한 socket 연결 (개인용 pub/sub 서버 구축)');

				var receiver_id=receiver.attr('id');
				var receiver_thumbnail_url=receiver.find('.user_img').attr("src");
				
				if(room_id=="notCreated"){
					room_id=guid().replace(/-/gi,"");
				}

				client.send('/publish/chat/user' ,{}, JSON.stringify({
					sender_id:'${id}',
					sender_thumbnail_url:'${userInfo[0].thumbnail_url}',
					room_id:room_id,
					receiver_id:receiver_id,
					receiver_thumbnail_url:receiver_thumbnail_url,
				}))
			
				location.href="/chat/chatting.chat?room_id="+room_id+"&receiver_id="+receiver_id+"&receiver_thumbnail_url="+receiver_thumbnail_url+"";
				
			}) 
			
			
			})
	}

		
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