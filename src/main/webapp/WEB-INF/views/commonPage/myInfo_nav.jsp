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


.nav-link{
	line-height:2.5 !important;
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

<div class="container">
		<div class="row nav">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <div class="container">
		    <a class="navbar-brand" href="/">
		    	<h4 class="heading"><strong>Home</strong></h4>
			</a>
        	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse text-center" id="navbarNavAltMarkup">
		      <div class="navbar-nav">
		        <a class="nav-link active" id="myInfoView" aria-current="page" href="/mypage/myInfo.mypage?id=${id}">회원 정보 보기</a>
		        <a class="nav-link"  id="updateMyInfo" href="/mypage/updateMyInfo.mypage?id=${id}">회원 정보 수정</a>
		        <a class="nav-link"  id="withdrawal" href="/mypage/withdrawlProc.mypage">회원 탈퇴</a>
		        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
		      <!--   <a class="nav-link">
		            <form class="d-flex">
                        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-secondary" type="button">Search</button>
                    </form>
		        </a> -->
		      </div>
		    </div>
		  </div>
		</nav>
		</div>
	</div>



<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    



</body>
</html>