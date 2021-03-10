<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/resources/chat/chat.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.min.css">

<!--===============================================================================================-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">


<title>Insert title here</title>
</head>
<style>
.msg_time{
width:80px;
margin-top:5px;}


#video-icon{
	display:none;
}
</style>
<body>
	
 <div class="container">
	<div class="col-md-5 col-xl-4 chat js-pscroll">
					<div class="card">
						<div class="card-header msg_head">
							<div class="d-flex bd-highlight">
								<div class="img_cont">
									<img src="${receiver_thumbnail_url}" class="rounded-circle user_img">
									<!--<span class="online_icon"></span>-->
								</div>
								<div class="user_info">
									<span>Chat with ${receiver_id}</span>
									<p>참가자 ${numberOfperson} 명</p>
								</div>
								<div class="video_cam" style="text-align:right;">
									<span><a href="/chat/chatList.chat"><i class="bi bi-arrow-left"></i></a></span>
									<span id="invitation-icon"><i class="bi bi-cast"></i></span>
									
									<span id="video-icon" style="text-align:right;"><a data-bs-toggle="modal" data-bs-target="#join_meeting-modal"><i class="fas fa-video"></i></a></span>
								</div>
							</div>
							
						</div>
						
						
						
						<div class="card-body msg_card_body chat-body">
							<c:forEach var="i" items="${chatHistory}">
							<c:choose>
								<c:when test="${i.user_id != id }">
							    <!-- others chat -->
								<div class="d-flex justify-content-start mb-4 chat-message-box">
									<div class="img_cont_msg">
										<img src="${receiver_thumbnail_url}" class='rounded-circle user_img_msg'>
									</div>
									<div class="msg_cotainer" style="max-width:320px; min-width:47px;">
										${i.chat_content}
										<span class="msg_time">${i.date}</span>
									</div>
								</div>
								</c:when>
							
								<c:when test="${i.user_id eq id}">
								<!--myChat-->
								<div class="d-flex justify-content-end mb-4 chat-message-box">
									<div class="msg_cotainer_send" style="max-width:320px; min-width:47px;">
											${i.chat_content}
										<span class="msg_time_send">${i.date}</span>
									</div>
									<div class="img_cont_msg">
										<img src="${userInfo[0].thumbnail_url}" class="rounded-circle user_img_msg">
									</div>
								</div>
								</c:when>
							</c:choose>
							</c:forEach>
						</div>
						
						<!-- 메세지 입력 -->
						<div class="card-footer">
							<div class="input-group">
								<div class="input-group-append">
									<span class="input-group-text attach_btn"><i class="fas fa-paperclip"></i></span>
								</div>
								<textarea id="inputMessage" class="form-control type_msg" placeholder="Type your message..."></textarea>
								<div class="input-group-append">
									<span class="input-group-text send_btn"><i class="fas fa-location-arrow"></i></span>
								</div>
							</div>
						</div>
					</div>
				</div>
	</div>
	
	
	
<!-- 		<!-- Modal -->
 	    <div class="modal fade" id="join_meeting-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div id="reg_tutor-Modal" class="modal-body">
	                      	<iframe id="zoom_iframe" src="/zoom/regTutor_Iframe.zoom" style="height:250px;"></iframe>
					 </div>
	                <div class="modal-footer">
	                	<button id="join_meeting" type="submit" class="btn btn-dark text-start" data-bs-dismiss="modal">Join Meeting</button>
	                	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	                </div>
	            </div>
	        </div>
	    </div> 
	    
	    
	    
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<script>	
		$( document ).ready(function() {
			$('.chat-body').scrollTop($('.chat-body')[0].scrollHeight);
			$('#vedio-icon').hide();
		});

	
		
		function chatForm(chatting, whosChat){
	
			var chatForm=$('<div>');
		
			if(whosChat=='myChat'){
				chatForm.addClass('d-flex justify-content-end mb-4');
				chatForm.append(
						'<div class="msg_cotainer_send" style="max-width:320px; min-width:47px;">'+
							chatting.chat_content+
							'<span class="msg_time_send msg_tilme">'+chatting.date+'</span>'+
						'</div>'+
						'<div class="img_cont_msg" id="'+chatting.user_id+'">'+
							'<img src="${userInfo[0].thumbnail_url}" class="rounded-circle user_img_msg">'+
						'</div>'		
				);
			}else if(whosChat=='othersChat'){
				chatForm.addClass('d-flex justify-content-start mb-4');
				chatForm.append(
						'<div class="img_cont_msg" id="'+chatting.user_id+'">'+
							'<img src="'+chatting.sender_thumbnail+'" class="rounded-circle user_img_msg">'+
						'</div>'+
						'<div class="msg_cotainer" style="max-width:320px; min-width:47px;">'+
							chatting.chat_content+
							'<span class="msg_time">'+chatting.date+'</span>'+
						'</div>'
				);
			}
			
			return chatForm;
			
		}
		</script>
		
		<script>
		var mn;
		// === <전체 흐름 : 1. 채팅 웹소켓 연결 >
		var sjs = parent.connectSockJS(); // sockjs 연결
		//new SockJS("http://localhost/chat");

		var client = Stomp.over(sjs);
		//=========== 1. 채팅방 구독 및 메세지 수신 subscriber ========================
		client.connect({}, function() {
			console.log("구독 대상과의 채팅 서버의 socket 연결");
			
			// session에 저장된 room_id값을 사용하여 다시금 1:1 채팅방 개설
			client.subscribe("/subscribe/chat/room/" + '${room_id}', function(res) {
				
				// 구독한 채널로부터의 수신을 받아 메세지 div 생성
				var chat = JSON.parse(res.body);
				mn=chat.mn;
				if(chat.organizer!='${id}'&&chat.organizer!=null){
					if($('#video-icon').css('display')=='none'){
						$('#video-icon').show();
					}
				}
				//============ 단순 채팅 로직=======================================	
				
					if(chat.chatMessage==null){
						return false;
					}
					var chatMessage = JSON.parse(chat.chatMessage);
					var appendChatForm;
					// ==== my chat ============================
					if (chatMessage.user_id == '${id}') {
						appendChatForm=chatForm(JSON.parse(chat.chatMessage), "myChat");
					// ==== other chat ============================
					} else if (chatMessage.user_id != '${id}') {
						appendChatForm=chatForm(JSON.parse(chat.chatMessage), "othersChat");
					}
					$('.chat-body').append(appendChatForm);
						
					var top = $('.chat-body').prop('scrollHeight')+ appendChatForm.prop('scrollHeight');
					$('.chat-body').stop().animate({scrollTop : top}, 10);
					$('#inputMessage').val('');				
				
			})
		})

		//======== 2. 메세지 송신(보내기) sender ===================
		function send() {
			client.send("/publish/chat/room", {}, JSON.stringify({
				chat_content : $('#inputMessage').val(),
				user_id : '${id}',
				room_id : '${room_id}',
				date:new Date().format("hh:mm a/p"),
				sender_thumbnail:'${userInfo[0].thumbnail_url}',
				receiver_id:'${receiver_id}'
			}))
		}

		//==================== 메세지 보내기 버튼 클릭 이벤트 ======================================================
 		$('.send_btn').on('click', function() {

			if ($('#inputMessage').val() != '') {
				send();
			}
		}) 
		
		$('#inputMessage').on('keydown', function(e){
			if(e.keyCode==13){
				if ($('#inputMessage').val() != '') {
					send();
				}
			}
		})
	
		
		//==================== zoom 미팅이 활성화 되었을 때의 처리 로직 ======================================================

		// ==== <<< 이 로직은 주최자와 관련된 로직 >> joinMeeting url 확인 분기점
	 		
	 	$('#invitation-icon').on('click', function(){
	 		
	 		if('${organizer}'=='${id}'){
	 					
	 			var result=confirm('${receiver_id} 님을 초대하시겠습니까?');
		 	//================ 미팅 주최자================================================
		 			if(result){
		 				var userRoom_url="/subscribe/chat/room/" + '${room_id}';
		 				
		 				client.send(userRoom_url, {}, JSON.stringify({
		 					organizer:'${id}',
		 					mn:'${meetingNumber}'
		 					
		 				}))
		 			} 
	 		}else{
	 			alert('미팅을 열어주세요!');
	 		}
		})
		
	 	
		
	 	$('#video-icon').on('click', function(){
	 		
				$('#zoom_iframe').contents().find('#meeting_number').val(mn);
				$('#video-icon').hide();	
		})  

		
	</script>
	
	<script>

	function disconnect() {
		client.disconnect();
	}
	
	/*<!-- ========================= 현재 시간을 local time으로 parse 함수 ========================== --> */
	Date.prototype.format = function(f) {
	    if (!this.valueOf()) return " ";
	 
	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	    var d = this;
	     
	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
	        switch ($1) {
	            case "yyyy": return d.getFullYear();
	            case "yy": return (d.getFullYear() % 1000).zf(2);
	            case "MM": return (d.getMonth() + 1).zf(2);
	            case "dd": return d.getDate().zf(2);
	            case "E": return weekName[d.getDay()];
	            case "HH": return d.getHours().zf(2);
	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
	            case "mm": return d.getMinutes().zf(2);
	            case "ss": return d.getSeconds().zf(2);
	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
	            default: return $1;
	        }
	    });
	};
	
	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	Number.prototype.zf = function(len){return this.toString().zf(len);};


	</script>

	<script>
	
		$(document).ready(function() {
			$('#action_menu_btn').click(function() {
				$('.action_menu').toggle();
			});
		});
	</script>
	
	
	<!-- ===================== 스크롤 최상단 감지 이벤트 및 과거 대화 기록을 retreive 하는 로직 (*db단에서의 sysdate을 js단에서 format도 실시!!)==================================================================== -->
	<script>
	
	
	var cRowNum='${cRowNum}'; 
	
	$(".chat-body").scroll(function(){
		var scrollTop = $(this).scrollTop();
		var c_scrollHeight=$('.chat-body').prop('scrollHeight');
		if(scrollTop==0){
       		
       		$.ajax({
       			url:"/chat/update_ChatMessage_History.chat?room_id=${room_id}&cRowNum="+cRowNum,
       		}).done(function(res){
       			var result=JSON.parse(res);
       			
       			var listChatHistory;
       			if(result.isUpdated=='nothingUpdated'){
       				//=============== not update ChatMessage=================
   					return false;
       			}else{
       				//=============== update ChatMessage=================
       				listChatHistory=JSON.parse(result.chatHistory);
               		cRowNum=result.cRowNum;
           			
           			for(i=0; i<listChatHistory.length; i++){
           				
           				listChatHistory[i].date=new Date(listChatHistory[i].date).format("hh:mm a/p");
    					
						var current_chatBodyHeight=$('.chat-body').prop('scrollHeight'); 
						var appendChatForm;
        				// ==== my chat ============================
        				if (listChatHistory[i].user_id == '${id}') {
        					appendChatForm=chatForm(listChatHistory[i], "myChat");
        				// ==== other chat ============================
        				} else if (listChatHistory[i].user_id != '${id}') {
        					appendChatForm=chatForm(listChatHistory[i], "othersChat");
        				}
        				$('.chat-body').prepend(appendChatForm);
        				
        				var updated_scrollHeight = $('.chat-body').prop('scrollHeight');
        				
        				console.log("update 이전의 scrollHeight"+c_scrollHeight);
        				console.log("update된 scrollTop"+updated_scrollHeight);
        				var top=(Number(updated_scrollHeight)-Number(c_scrollHeight));
        				$('.chat-body').scrollTop(top);
        			}
       			}
       		})	
       	 }
	});
</script>

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