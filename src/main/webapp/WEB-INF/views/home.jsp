<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
</head>
<style>
    
.bottom-nav {
	width: 1200px;
	height: 50px;
	margin: auto;
	text-align: center;
}
   
#chat
	position:relative;
	right:-200px;
	bottom:200px;
}
</style>
    
    
<body>
		<div class="container">
			<div class="row">
				<jsp:include page="/WEB-INF/views/commonPage/header.jsp" />
       		</div> 
			
			<div class="row">
				<jsp:include page="/WEB-INF/views/commonPage/nav.jsp"/>
       		</div>
       
       		 <div class="row">
       			<jsp:include page="/WEB-INF/views/commonPage/section.jsp"></jsp:include> 
       		</div>

		
       		<div class="row">
       			<nav class="bottom-nav"></nav>
       		</div>
       		<div class="row">
       			<jsp:include page="/WEB-INF/views/commonPage/footer.jsp"/>
       		</div>
       </div>


		
		

    
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>



</body>
</html>