<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
<link href="/resources/reg-form/css/bootstrap.min.css" rel="stylesheet">
</head>      

<style>
    .container-login-form-btn {
        width: 100% !important; 
        display: -webkit-box !important;
        display: -webkit-flex !important;
        display: -moz-box !important;
        display: -ms-flexbox !important;
        display: flex !important;
        flex-wrap: wrap !important;
        justify-content: center !important;
    }

    .login-form-btn {
        font-family: Poppins-Medium !important;
        font-size: 13px !important;
        color: #fff !important;
        line-height:2 !important;
        vertical-align: middle !important;
        text-transform: uppercase !important;
        border: 0px !important;
        display: -webkit-box !important;
        display: -webkit-flex !important;
        display: -moz-box !important;
        display: -ms-flexbox !important;
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        padding: 0 20px !important;
        width: 25% !important;
        height: 40px !important;
        background-color: #57b846 !important;
        border-radius: 25px !important;
        margin-right: 50px !important;
     
        box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5) !important;
        -moz-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5) !important;
        -webkit-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5) !important;
        -o-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5) !important;
        -ms-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5) !important;

        -webkit-transition: all 0.4s !important;
        -o-transition: all 0.4s !important;
        -moz-transition: all 0.4s !important;
        transition: all 0.4s !important;
    }

    .login-form-btn:hover {
        background-color: #333333 !important;
        box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5) !important;
        -moz-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5) !important;
        -webkit-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5) !important;
        -o-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5) !important;
        -ms-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5) !important;
    }

    .file_input_textbox {display: inline !important; height:25px !important; border: 1px solid !important;width:10% !important; margin: 0 auto !important;}
	.file_input_div {display: inline !important; position:relative !important; width:80px !important; height:40px !important; overflow:hidden !important;}
	.file_input_img_btn {padding:0 0 0 5px !important; height:30px !important; }
	.file_input_hidden {
        float:left !important;
        font-size:29px !important; height:30px !important; position:absolute !important; 
        right:0px !important; top:0px !important; opacity:0 !important; filter: alpha(opacity=0) !important;
        -ms-filter: alpha(opacity=0) !important; cursor:pointer !important;
    }

	.main{
	width:1200px !important;
	}
  
</style>


<body class="bg-light">


	
	<div class="container">
  	     <div class="row">
  	     	<jsp:include page="/WEB-INF/views/commonPage/header.jsp"/>
  	     </div>
  	     
  	     <div class="row">
  	     	<jsp:include page="/WEB-INF/views/commonPage/myInfo_nav.jsp"/>
  	     </div>
  	     
  	     
  	     <div class="row">
			<div class="col-md-12 py-5 text-center">
				<h2>회원 정보</h2>
			</div>
			<div class="col-md-12">
				<c:forEach var="i" items="${userInfo}">
					<div class="form-group" style="margin: auto; text-align: center;">
						<img id="thumbnail" class="d-block mx-auto mb-4 rounded-circle user_img"
							src="/resources/popupSignin/images/profile.jpg" alt="" width="100"
							height="100">
					</div>

					<div class="form-group">
						<label for="exampleInputName">이름</label> <input type="text"
							class="form-control" id="name" name="name" value="${i.name}" readonly>
					</div>

					<div class="form-group">
						<label for="exampleInputName">아이디</label> 
						<input type="text" class="form-control" id="id" value="${i.id}"
							aria-describedby="idlHelp" maxlength='16' minlength='4' name="id" readonly>
					</div>

					<div class="form-group">
						<label for="exampleInputEmail1">이메일</label> <input type="email"
							class="form-control" id="email1" value="${i.email}"
							aria-describedby="emailHelp" name="email" readonly> 
					</div>

					<div class="form-group">
						<label for="exampleInputContanct_number">전화번호</label> 
						<input type="text" class="form-control" id="contanct_number" value="${i.contact_number}" aria-describedby="emailHelp" name="contact_number" readonly> 
					</div>



					<div class="form-group">
						<label for="exampleInputAddress1">주소 </label> 
						<input type="text" class="form-control" id="address1" value="${i.address1}" name="address1" readonly>
						<div style="height:10px;"></div>
						<input type="text" class="form-control" id="address2"
							name="address2" value="${i.address2}" readonly> 
							<small class="form-text text-muted">기타 주소</small>
					</div>

					<div class="form-group">
						<label for="exampleInputPost_code">우편 번호 </label>
						 <input	type="text" class="form-control" id="post_code" name="post_code" value="${i.post_code}" readonly>
                    </div>

					<div class="form-group">
						<label for="exampleInputPassword1">광고수신 </label> <br> 
						<input	type=checkbox id="ad" name="get_ad" value='${i.get_ad}'> 수신 동의
                    </div>
                    
					<div class="container-login-form-btn">
						<button type="submit" class="login-form-btn m-b-10" id="update_btn">수정</button>
						<button type="button" class="login-form-btn" id="cancel_btn">취소</button>
					</div>
					</c:forEach>
					<div style="height:10px;"></div>
			</div>
		</div>
        <div class="row">
			<nav class="bottom-nav"></nav>
		</div>
		
		<div class="row">
  	     	<jsp:include page="/WEB-INF/views/commonPage/footer.jsp"/>
  	     </div>
  	     
</div>	
<!--=========================================================-->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

<!-- [ 회원가입 버튼 hide ] ================================================================== -->
<script>
	$('#signup').hide();
</script>

<!-- [ 회원 정보 보기 nav hide ] ================================================================== -->
<script>
	$('#myInfoView').hide();
</script>



<!-- [ 돌아가기(취소) 버튼 click 이벤트 ] ================================================================== -->
<script>
  	$('#cancel_btn').on('click', function(){
  		location.href="/mypage/myInfo.mypage?id=${id}";
  	})
  	
  	$('#update_btn').on('click', function(){
  		location.href="/mypage/updateMyInfo.mypage?id=${id}";
  	})
  	
</script>


<!-- thumbnail 미리보기 with file input tag-->
<script>
							   
if('${userInfo[0].thumbnail_url}'!=''&&'${userInfo[0].sns_code}'==02){
    $('#thumbnail').attr("src", '${userInfo[0].thumbnail_url}');
}else if('${userInfo[0].thumbnail_url}'!=''&&'${userInfo[0].sns_code}'==01){
    $('#thumbnail').attr("src", '${userInfo[0].thumbnail_url}');
}
</script>


<script>
//광고 수신 여부 =====================================================================================	
$('#ad').on('click', function(){
    		
    if($('#ad').val()=='Y'){
    	$('#ad').val('Y');
    }else{
    	$('#ad').val('N');
    }
})
   		
 if( $('#ad').val()=='Y'){
       	$('#ad').val('Y');
       	$('#ad').attr("checked", true)
       	
    }else{
        $('#ad').val('N');
        $('#ad').attr("checked", false)
    }
</script>

</body>
</html>