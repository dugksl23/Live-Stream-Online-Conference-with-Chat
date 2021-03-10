<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">

<title>Insert title here</title>
</head>
<style>

.bottom-nav {
	width: 1200px;
	height: 50px;
	margin: 0 auto;
	text-align: center;
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

#zoom_iframe{
height:100% !important;
width:100% !important;
position:none !important;
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
			<div class="col-md-12">
				<button id="create-meeting-btn" data-bs-toggle="modal" data-bs-target="#create_meeting-modal">회의 시작하기</button>
			</div>
		</div>
		
		<div class="row">
			<div class="bottom-nav"></div>
		</div>
		
		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/footer.jsp" />
		</div>
		
		<!-- Modal -->
	    <div class="modal fade" id="create_meeting-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                </div>
	                <div id="reg_tutor-Modal" class="modal-body" style="height:300px;">
	                      	<iframe id="zoom_iframe" src="/zoom/regTutor_Iframe.zoom"></iframe>
					 </div>
	                <div class="modal-footer">
	                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	                </div>
	            </div>
	        </div>
	    </div>

	</div>


</body>
</html>