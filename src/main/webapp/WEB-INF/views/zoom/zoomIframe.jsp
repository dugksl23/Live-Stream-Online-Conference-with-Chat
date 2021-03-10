<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>



<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<script>
//==== zoom 회의가 끝나고, 회의 종료가 아닌 page 이동 시에 connection을 감지하기 위한 로직
$(document).ready(function(){
 	$.ajax({
		url:"/zoom/deleteTutors.zoom",
		type:"get",
		data:{host_id:'${id}'}
	}) 
}) 
</script>


<script>

$(document).ready(function(){
 	$.ajax({
		url:"/zoom/removeTutor.zoom",
		type:"get",
	}) 
}) 

</script>
</body>
</html>