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



</head>
<style>


*{
margin:0;
padding:0;
box-sizing: border-box;
        
}
.bottom-nav {
	width: 1200px;
	height: 50px;
	margin: auto;
	text-align: center;
}

.main {
	margin: auto;
	width:1200px;;
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

		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/nav.jsp" />
		</div>

		<!-- 자유게시판 section 매인 -->
		<div class="row">
			<div class="col-md-12">
				<div class="limiter">
					<div class="container-table100">
						<div class="wrap-table100">
							<div class="table100 ver5 main" style="width:100%; margin:0 auto;">
								<div class="table100-head">
									<table>
										<thead>
											<tr class="row100">
												<th class="cell100 column1 text-center" style="padding-left:60px;"><strong>번호</strong></th>
												<th class="cell100 column2 text-center"><strong>제목</strong></th>
												<th class="cell100 column3 text-center"><strong>글쓴이</strong></th>
												<th class="cell100 column4 text-center"><strong>시간</strong></th>
												<th class="cell100 column5 text-center"><strong>조회수</strong></th>
											</tr>
										</thead>
									</table>
								</div>
								<c:forEach var="i" items="${boardList}">
									<div class="col-md-12 table100-body js-pscroll">
										<table>
											<tbody>
												<tr class="row100 body text-center">
													<td class="cell100 column1">${i.uniq_bycode}</td>
													<td class="cell100 column2">
														 <span>
															<a class="a" href="/board/viewWriting.board?writing_id=${i.writing_id}&board_code=00">${i.writing_title}</a>
														</span>

														<c:forEach var="j" items="${commentsCount}">
															<c:if test="${i.writing_id==j.writing_id}">
																<span style="padding-left: 10px;">${j.commentcount}</span>
															</c:if>
														</c:forEach>
													</td>
													<td class="cell100 column3">${i.writing_writer}</td>
													<td class="cell100 column4">${i.writing_date}</td>
													<td class="cell100 column5">${i.writing_viewCount}</td>
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
			<div class="col-md-6 text-end">
				<form action="/board/search.board?cPage=1&board_code=00" method=post
					id="mainSearch-form">
					<div class="searchBox">
						<div class="input-group mt-1">
							<select class="custom-select outline-secondary"
								id="inputGroupSelect01" name="choice">
								<option selected value="writing_title">제목</option>
								<option value="writing_writer">글쓴이</option>
							</select> <input type=text id=inputSearch class="form-control"
								placeholder="  Search" name="search">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button"
									id="search-btn">검색</button>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="col-md-4"></div>
			<div class="col-md-2 pt-1 text-center">
				<c:if test="${id!=null}">
					<button type="submit" class="btn btn-outline-secondary"
						id="writing-btn">글쓰기</button>
				</c:if>
			</div>
		</div>

		<div class="row" style="margin-top: 20px;">${navi}</div>

		<!-- footer -->
		<div class="row">
			<jsp:include page="/WEB-INF/views/commonPage/footer.jsp" />
		</div>
	</div>

	<!--===============================================================================================-->

	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
	<!--===============================================================================================-->
	<script src="/resources/board/js/main.js"></script>


	<!--========================== 글쓰기 btn  ==========================================================-->

	<script>
		$('#writing-btn').on('click', function() {
			//location.href = "/board/insertTest.board";
			location.href = "/board/writingProc.board?proc=new&board_code=00";
		})
	</script>

	<script>
		$('#search-btn').on('click', function() {
			$('#mainSearch-form').submit();
		})
	</script>


	<!-- =============================================================================================== 
	[navi 목록 script]-->
	<script>
		$('#home').hide();
	</script>
</body>
</html>
