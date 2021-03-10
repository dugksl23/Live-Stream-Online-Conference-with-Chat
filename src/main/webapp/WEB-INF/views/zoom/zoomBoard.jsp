<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">


<title>Learning English</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="/resources/board/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/board/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/board/vendor/animate/animate.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/board/vendor/select2/select2.min.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/board/vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/board/css/util.css">
<link rel="stylesheet" type="text/css"
	href="/resources/board/css/main.css">
<!--===============================================================================================-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
</head>
<style>


.main {
	margin: auto;
	width:1200px;;
}
.bottom-nav {
	width: 1200px;
	height: 50px;
	margin: auto;
	text-align: center;
}

/* search style */
#inputGroupSelect01 {
	height: 35px;
}

#inputSearch {
	width: 100px;
	height: 35px;
	border: 1px solid lightgray;
	margin-left: 10px;
	margin-right: 10px;
}

#inputSearch:focus {
	width: 100px;
	height: 35px;
	border: 1px solid blue;
	margin-left: 10px;
	margin-right: 10px;
}

#search-btn {
	height: 35px;
}

#writing-btn {
	height: 35px;
}

.a {
	text-decoration: none;
	color: black;
}

.mt-50 {
	margin-top: 50px;
}

.mb-20 {
	margin-bottom: 20px;
}

</style>


<body>
	<div class="container">

 		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/header.jsp" />
		</div>

		<div class="row" >
			<jsp:include page="/WEB-INF/views/commonPage/nav.jsp" />
		</div>

		<!-- zoom 게시판 section 매인 -->
		<div class="row">
			<div class="col-md-12">
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
						  
							<div class="table100 ver5 main" style="width:100%; margin:0 auto;">
								<div class="table100-head" id="table-head">
									<table>
										<thead>
											<tr class="row100h head">
												<th class="cell100 column1 text-center" style="padding-left:60px;"><strong>사진</strong></th>
												<th class="cell100 column2 text-center"><strong>Tutor</strong></th>
												<th class="cell100 column3 text-center"><strong>시간</strong></th>
												<th class="cell100 column4 text-center"><strong>접속</strong></th>
												<th class="cell100 column5 text-center"><strong>메세지</strong></th>
											</tr>
										</thead>
									</table>
								</div>




								<c:forEach var="i" items="${tutors}">
									<div class="col-md-12 table100-body js-pscroll" id="${i.id}">
										<table>
											<tbody>
												<tr class="row100 body text-center">
													<td class="cell100 column1 text-center">
														<img src='${i.thumbnail_url}' style="height:70px; width:70px;">
													</td>
													<td class="cell100 column2 text-center">
														 <span>
															${i.id}
														</span>
													</td>
													<td class="cell100 column3 text-center">${i.email}</td>
													<td class="cell100 column4">
														<i class="bi bi-circle-fill" style="color:green"></i>
													</td>
													<td class="cell100 column5">
														<c:if test="${id ne null}">
														<a  class="zoom-chat" data-bs-toggle="modal" data-bs-target="#chat-modal">
												 		  <i class="bi bi-chat-left-dots-fill" style="color:orange;"></i>
														</a>
														</c:if>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- search 및 글쓰기 btn-->
		<div class="row">
			<div class="col-md-12">
				<form action="/zoom/searchTutors.zoom" method="post" id="mainSearch-form">
					<div class="searchBox">
						<div class="input-group mt-1">
							<select class="custom-select outline-secondary" id="inputGroupSelect01" name="choice">
								<option selected value="writing_title">Tutors</option>
							</select> 
							<input type=text id=inputSearch class="form-control" placeholder="Search" name="host_id">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="submit" id="search-btn">검색</button>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-4"></div>
		</div>

		<div class="row" style="margin-top: 20px;">${navi}</div>

		<!-- footer -->
		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/footer.jsp" />
		</div>
	</div>




	<!--==============================================================================
	[zoom 웹소켓을 통한 비동기 zoom 게시글 생성 로직]============================================== -->
	<script>
	//2. 서버로부터 온 응답을 수신할 때 호출되는 메소드
	var zWs=connectWs();
	
	zWs.onmessage=function(res){
		
		
		let userInfo=JSON.parse(res.data);
	
		if(userInfo.access=='true'){
			
		
			$('#table-head').after(
					
					'<div class="col-md-12 table100-body js-pscroll text-end"  id='+userInfo.id+'>'+
					'<table>'+
						'<tbody>'+
							'<tr class="row100 body text-center">'+
								'<td class="cell100 column1 text-center">'+
									'<img src='+userInfo.thumbnail_url+' style="height:70px; width:70px;">'+
								'<td>'+									
								'<td class="cell100 column2 text-center">'+userInfo.id+'</td>'+
								'<td class="cell100 column3 text-start">'+userInfo.now+'</td>'+
								'<td class="cell100 column5 text-center"><i class="bi bi-circle-fill" style="color:green"></i>'+
								'</td>'+
								'<td class="cell100 column5" text-start>'+
									'<c:if test="${id ne null}">'+
						 			'<a  class="zoom-chat"  data-bs-toggle="modal" data-bs-target="#chat-modal">'+
						 		  		'<i class="bi bi-chat-left-dots-fill" style="color:orange;"></i>'+
									'</a>'+
									'</c:if>'+
								'</td>'+
							'</tr>'+
						'</tbody>'+
					'</table>'+
					'</div>'
				); 			
		}else if(userInfo.access=='false'){
			
			$('#'+userInfo.id).remove();
			
			$.ajax({
				url:"/zoom/deleteTutors.zoom",
				type:"get",
				data:{host_id:userInfo.id}
			})
			
		}
	}
	
 	/* zWs.onclose=function(){
		$.ajax({
			url:"/zoom/removeTutor.zoom",
		})	
 	} */
	
	</script>

	<!-- 비동기 생성된 또는 동기로 생성된 tutor table의  message 아이콘 클릭 이벤트 -->
	<script>
	$(document).on('click', '.zoom-chat', function(){

			var tutor_div=$(this).closest('div.table100-body');
			var tutorInfo={
					tutor_id:tutor_div.attr('id'),
					thumbnail_url:tutor_div.find('img').attr('src')
			}
			

		 	$('#chatlist_iframe').contents().find(".inputTutors").val(tutorInfo.tutor_id);

		})	
	
	</script>

</body>
</html>
