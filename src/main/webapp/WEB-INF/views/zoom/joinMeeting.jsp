<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<style>
* {
	box-sizing: border-box;
	padding: 0px;
	margin: 0px;
}

.bottom-nav {
	height: 50px;
	margin: auto;
	text-align: center;
}

.main {
	width: 1200px;
	height: 720px;
	margin: 0 auto;
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

/*====================================
    zoom 관련 style */
#zoom_ifrm {
	height: 600px;
	width: 100%;
	margin: 0 auto;
	border: 1px solid black;
}

#ifrm {
	width: 100%;
	height: 100%;
	border: 1px solid black;
}
</style>



<body>
	<div class="container">

		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/header.jsp" />
		</div>

		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/nav.jsp" />
		</div>

		<div class="row">
			<div class="col-md-6"></div>
		</div>
		<div class="row bg-light border-top border-bottom mb-1 pt-2 pb-2 pl-3">
			<div class="col-md-6 text-dark pl-3">
				<h6>
					<strong>${organizer}의 화상 미팅</strong>
				</h6>
			</div>
			<div class="col-md-6 text-end col-0 d-block">
			</div>
		</div>
		<div class="row border-top border-bottom mt-1 mb-1 pt-2 pb-2 pl-4">
			<div class="col-md-6 text-start text-dark">Tutor : ${organizer}</div>
		</div>


		<div class="row mt-1 mb-1 pt-5 pb-2">
			
			<c:if test="${organizer == id}">
			<div class="col-md-12"  style="margin-bottom:30px;">
				<div class="d-flex">
					<span>Meeting Number : </span><span style="font-family: fantasy; font-weight: 500; margin-left:5px;">${meetingNumber}</span>
				</div>
				
				<div class="d-flex">
					<span>Meeting PassCode : </span><span id="passCode" style="font-family:fantasy; font-weight:500; margin-left:5px;"></span>
				</div>
			</div>		
			</c:if>
			
			<div class="col-md-12">
				<div id="zoom_ifrm">
					<iframe id="ifrm" class="zoom_position" src=""></iframe>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12 text-center">
				<button onclick="zoomJoin()" id="join_meeting" class="btn btn-primary mx-auto" type="button" style="width: 100px;">Join</button>
			</div>
		</div>

		<div style="height:20px;"></div>
		<div class="row text-center border-bottom" style="padding-bottom: 30px;">

			
			<div class="col-md-12 m-b-12">
				<button id="board_hate" style="display:none;">
						<i class="bi bi-heart-fill" style="color:red; font-size: 2rem;"></i> 좋아요
					</button>
						
					<button id="board_like">
						<i class="bi bi-heart" style="font-size: 1rem;"></i> 좋아요
				</button>
			</div>
		</div>

		<div class="row bottom-nav" style="margin-top: 30px;">
			<div class="col-md-12"></div>
		</div>
		<div class="row footer">
			<jsp:include page="/WEB-INF/views/commonPage/footer.jsp" />
		</div>
	</div>


	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>



	<!--[스크롤 제자리 위치 function]========================================================-->
	<script>
		function scrollTop() {
			$(window).scroll(function() {
				var scrollValue = $(document).scrollTop();
				//console.log(scrollValue); 
				$(document).scrollTop(scrollValue);
			});
		}
	</script>

	<script>
		if ('${likeUser[0].like_id}' != '') {
			$('#board_like').hide();
			$('#board_hate').show();
		}


		var like_id = '${likeUser[0].like_id}';
		var likeCount = '${likeCount}';
		$('#board_like').on('click', function() {
			
			if ('${id}' != '') {
				
				$('#board_like').hide();
				$('#board_hate').show();

			}
		})


		$('#board_hate').on('click', function() {
			$('#board_like').show();
			$('#board_hate').hide();

		})
	</script>

<!--===========================================================
	[zoom iframe script]   -->
	<script>

		function zoomJoin() {
					
					$('#ifrm').attr('src',"/resources/zoom/zoom-app/CDN/meeting.html" + '${join_Url}');
					jQuery('#join_meeting').css('display', 'none');
					$('#join_meeting').hide();
					if('${organizer}'=='${id}'){
						var zWs=connectWs();
						$.ajax({
							url:"/zoom/getMeetingDetail.zoom"
						}).done(function(res){
							var result=JSON.parse(res);
							var pwd=result.meeting_pwd;
							
							$('#passCode').html(pwd);
							//<!-- ========================= zoom WEBSOCKET CLIENT 생성 ========================== -->
							var userInfo={
									title:'${userInfo[0].id}'+"님과의 화상 영어",
									thumbnail_url:'${userInfo[0].thumbnail_url}',
									id:'${userInfo[0].id}',
									date:new Date().format("hh:mm a/p")
							}
							
							
							userInfo=JSON.stringify(userInfo);
							zWs.send(userInfo);
						
							$.ajax({
								url:"/zoom/setTutors.zoom",
								type:"post",
								data:{userInfo:userInfo}
							}) 
							
					 
						})	
					}
		}			

				
				
		function back() {
			location.href = "/";
		}

		
	</script>
	



<script>

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

</body>

</html>