<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Learning English 자유게시판</title>

<!--===============================================================================================-->
<link rel="stylesheet" type="text/css"
	href="/resources/ckeditor5/sample/styles.css">

</head>
<style>
.bottom-nav {
	width: 1200px;
	height: 50px;
	margin: auto;
	text-align: center;
}


form_main {
	width: 100%;
}

.form_main h4 {
	font-family: roboto;
	font-size: 20px;
	font-weight: 300;
	margin-bottom: 15px;
	margin-top: 20px;
	text-transform: uppercase;
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

.form {
	border-radius: 7px;
	padding: 6px;
}

.txt-1[type="text"] {
	border: 1px solid black;
	margin: 10px 0;
	padding: 10px 0 10px 5px;
	width: 100%;
}

.txt-3[type="text"] {
	margin: 10px 0 0;
	padding: 10px 0 10px 5px;
	width: 100%;
	border: 1px solid black;
}

.txt2[type="submit"] {
	background: #242424 none repeat scroll 0 0;
	border: 1px solid #4f5c04;
	border-radius: 25px;
	color: #fff;
	font-size: 16px;
	font-style: normal;
	line-height: 35px;
	margin: 10px 0;
	padding: 0;
	text-transform: uppercase;
	width: 30%;
}

.txt2:hover {
	background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
	color: #5793ef;
	transition: all 0.5s ease 0s;
}

.w100-left {
	width: 100px;
	float: left;
}

.left {
	left: 200px;
}

#title {
	border: 1px solid lightgray !important;
}

/* =============================================
[ckeditor 넓이와 높이 style] */
.ck.ck-editor {
	width: 800px;
}

.ck-editor__editable {
	height: 500px;
	width: 800px;
}
</style>

<body>


	<div class="container">
		<!-- header -->
		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/header.jsp" />
		</div>

		<!-- header navi -->
		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/nav.jsp" />
		</div>

		<!-- section main-->
		<div class="row">
			<div class="col-md-12">
				<div class="form_main">
					<h4 class="heading">
						<strong>자유게시판 </strong> 글쓰기 <span></span>
					</h4>
					<div class="form">
						<c:forEach var="i" items="${list}">
							<form
								action="/board/after_updateWriting.board?writing_id=${i.writing_id}"
								method="post">
							<input type="text" class="text-1 form-control" style="margin-bottom:10px;" required
								value="${i.writing_title}" id="title" name="writing_title" class="txt-1">
							<textarea class="txt-3" id="content" name="writing_content"></textarea>
							<div class="checkboxs">
								<div class="w100-left">
									<input type="checkbox"> 댓글 허용
								</div>
								<div class="w100-left">
									<input type="checkbox" id="writing_open" name="writing_open"
										value="Y"> 공개
								</div>
								<div>
									<input type="checkbox"> 알림
								</div>
							</div>
							<input type="submit" value="submit" class="txt2">
						</form>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>

		<!-- bottom-navi -->
		<div class="row">
			<div class="col-md-12">
				<nav class="bottom-nav"></nav>
			</div>
		</div>

		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/footer.jsp" />
		</div>
	</div>




	<!-- =============================================================
[체크박스 공개 이벤트]  -->
	<script>

	$('input[name=writing_open]').attr("checked", true);
	$('input[name=writing_open]').on('click', function(){
		if($('input[name=writing_open]').is(":checked")==true){
			$('input[name=writing_open]').val("Y");
		}else{
			$('input[name=writing_open]').val("N");
		}
	})
</script>

<script>
$('#content').html('${list[0].writing_content}');
</script>

	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script src="/resources/ckeditor5/build/ckeditor.js"></script>



</body>
</html>