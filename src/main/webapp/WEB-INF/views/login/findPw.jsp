<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>search for Password</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<style>
 body {
     background-position: center;
     background-color: #eee;
     background-repeat: no-repeat;
     background-size: cover;
     color: #505050;
     font-family: "Rubik", Helvetica, Arial, sans-serif;
     font-size: 14px;
     font-weight: normal;
     line-height: 1.5;
     text-transform: none
 }

 .forgot {
     background-color: #fff;
     padding: 12px;
     border: 1px solid #dfdfdf
 }

 .padding-bottom-3x {
     padding-bottom: 72px !important
 }

 .card-footer {
     background-color: #fff
 }

 .btn {
     font-size: 13px
 }

 .form-control:focus {
     color: #495057;
     background-color: #fff;
     border-color: #76b7e9;
     outline: 0;
     box-shadow: 0 0 0 0px #28a745
 }    
    
</style>

<body>

    	<div class="container padding-bottom-3x mb-2 mt-5">
	    <div class="row justify-content-center">
	        <div class="col-lg-8 col-md-10">
	            <div class="forgot">
	                <h2>비밀번호 찾기</h2>
	                <ol class="list-unstyled">
	               		<li><span class="text-primary text-medium">1. </span>회원가입 시 입력하신 ID와 이메일 주소를 입력해주세요.</li>
	                    <li><span class="text-primary text-medium">2. </span>해당 이메일 주소로 회원님의 갱신된 비밀번호가 발송됩니다.</li>	              
	                </ol>
	            </div>
	            	<form>
	                <div class="card-body">
	                    <div class="form-group"> 
	                        <label for="email-for-pass">ID</label> <input class="form-control" type="text" id="id" required><br>
	                    
	                    <label for="email-for-pass">이메일</label> 
	                    	<input class="form-control" type="text" id="email" required>
	                    </div>
	                </div>
	                <div class="card-footer"> 
	                	<button class="btn btn-success" type="button" id="findPw-btn">비밀번호 찾기</button> 
	                	<button class="btn btn-danger" type="button" id="back">Home으로 돌아가기</button> 
	                </div>
	            	</form>	
	        </div>
	    </div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script>
			
		

			$('#findPw-btn').on('click', function(){
				
				var id=$('#id').val();	
				var email=$('#email').val();
				
				if(id==""&&email==""){
					alert("아이디와 이메일을 작성해주세요.");
				}else if(id==""){
					alert("아이디를 작성해주세요.");
				}else if(email==""){
					alert("이메일을 작성해주세요.")
				}else{
			
						alert(id+email);
						$.ajax({
							url:'/member/findPw.member',
							type:'post',
							data:{id:id, email:email}, 
							success:function(resp) {
				                location.href="/";
							},
							fail:function(resp){
							}
				        })
				}
		
			 })
		</script>
	
	<script>
		$('#back').on('click', function(){
			location.href="/";
		})
		
	</script>
	
</body>
</html>
