<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>

</head>      

<style>
 /*///////////////////////////////////
[main]    */    
    
.main{
	width: 1280px;
	height: 720px;
    position: relative;
	z-index: 1;  
    margin: 0 auto;
} 


.bottom-nav {
	width: 1200px;
	margin: auto;
	text-align: center;
}

/*//////////////////////////////////////////////////////////////////
[ withdrawal ]*/

    .limiter {
        width: 100%;
        margin: 0 auto;
        bakcground-color:none;
    }

    .container-login {
        width: 100%;
        min-height: 50vh;
        display: -webkit-box;
        display: -webkit-flex;
        display: -moz-box;
        display: -ms-flexbox;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-items: center;
        padding: 15px;
        background: white;
        height: 100%;
    }

    .wrap-login {
        width: 390px;
        background: #fff;
        top: 50px;
    }


    /*------------------------------------------------------------------
[ Form ]*/

    .login-form {
        width: 100%;
    }

    .login-form-title {
        display: block;
        font-family: Poppins-Bold;
        font-size: 39px;
        color: #333333;
        line-height: 1.2;
        text-align: center;
    }

    .login-form-avatar {
        display: block;
        width: 120px;
        height: 120px;
        border-radius: 50%;
        overflow: hidden;
        margin: 0 auto;
    }

    .login-form-avatar img {
        width: 100%;
    }

    /*------------------------------------------------------------------
[ Input ]*/

    .wrap-input {
        width: 100%;
        position: relative;
        border-bottom: 2px solid #d9d9d9;

    }

    .input {
        font-family: Poppins-SemiBold;
        font-size: 18px;
        color: #555555;
        line-height: 1.2;

        display: block;
        width: 100%;
        height: 52px;
        background: transparent;
        padding: 0 5px;
        border: 0px;
    }

    /*---------------------------------------------*/
    .focus-input {
        position: absolute;
        display: block;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
        pointer-events: none;
        border: 0px;
    }

    .focus-input::before {
        content: "";
        display: block;
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 0;
        height: 2px;
        border: 0px;

        -webkit-transition: all 0.4s;
        -o-transition: all 0.4s;
        -moz-transition: all 0.4s;
        transition: all 0.4s;

        background: #57b846;
    }

    .focus-input::after {
        font-family: Poppins-Medium;
        font-size: 18px;
        color: #999999;
        line-height: 1.2;
        border: 0px;

        content: attr(data-placeholder);
        display: block;
        width: 100%;
        position: absolute;
        top: 15px;
        left: 0px;
        padding-left: 5px;

        -webkit-transition: all 0.4s;
        -o-transition: all 0.4s;
        -moz-transition: all 0.4s;
        transition: all 0.4s;
    }

    .input:focus+.focus-input::after {
        top: -20px;
        font-size: 15px;
        border: 0px;
    }

    .input:focus+.focus-input::before {
        width: 100%;
        border: 0px;
    }

    .has-val.input1+.focus-input::after {
        top: -20px;
        font-size: 15px;
    }

    .has-val.input+.focus-input::before {
        width: 100%;
    }


    /*------------------------------------------------------------------
[ Button ]*/
    .container-login-form-btn {
        width: 100%;
        display: -webkit-box;
        display: -webkit-flex;
        display: -moz-box;
        display: -ms-flexbox;
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
    }

    .login-form-btn {
        font-family: Poppins-Medium;
        font-size: 13px;
        color: #fff;
        line-height:2;
        vertical-align: middle;
        text-transform: uppercase;
        border: 0px;
        display: -webkit-box;
        display: -webkit-flex;
        display: -moz-box;
        display: -ms-flexbox;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0 20px;
        width: 100%;
        height: 40px;
        background-color: #57b846;
        border-radius: 25px;
     
        box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5);
        -moz-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5);
        -webkit-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5);
        -o-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5);
        -ms-box-shadow: 0 10px 30px 0px rgba(87, 184, 70, 0.5);

        -webkit-transition: all 0.4s;
        -o-transition: all 0.4s;
        -moz-transition: all 0.4s;
        transition: all 0.4s;
    }

    .login-form-btn:hover {
        background-color: #333333;
        box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5);
        -moz-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5);
        -webkit-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5);
        -o-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5);
        -ms-box-shadow: 0 10px 30px 0px rgba(51, 51, 51, 0.5);
    }



    /*------------------------------------------------------------------
[ Alert validate ]*/

    .validate-input {
        position: relative;
    }

    .alert-validate::before {
        content: attr(data-validate);
        position: absolute;
        max-width: 70%;
        background-color: #fff;
        border: 1px solid #c80000;
        border-radius: 2px;
        padding: 4px 25px 4px 10px;
        top: 50%;
        -webkit-transform: translateY(-50%);
        -moz-transform: translateY(-50%);
        -ms-transform: translateY(-50%);
        -o-transform: translateY(-50%);
        transform: translateY(-50%);
        right: 0px;
        pointer-events: none;

        font-family: Poppins-Regular;
        color: #c80000;
        font-size: 13px;
        line-height: 1.4;
        text-align: left;

        visibility: hidden;
        opacity: 0;

        -webkit-transition: opacity 0.4s;
        -o-transition: opacity 0.4s;
        -moz-transition: opacity 0.4s;
        transition: opacity 0.4s;
    }

    .alert-validate::after {
        content: "\f06a";
        font-family: FontAwesome;
        font-size: 16px;
        color: #c80000;

        display: block;
        position: absolute;
        background-color: #fff;
        top: 50%;
        -webkit-transform: translateY(-50%);
        -moz-transform: translateY(-50%);
        -ms-transform: translateY(-50%);
        -o-transform: translateY(-50%);
        transform: translateY(-50%);
        right: 5px;
    }

    .alert-validate:hover:before {
        visibility: visible;
        opacity: 1;
    }

    @media (max-width: 992px) {
        .alert-validate::before {
            visibility: visible;
            opacity: 1;
        }
    }

    .p-b-20 {
        padding-bottom: 20px;
    }

    .p-b-70 {
        padding-bottom: 70px;
    }

    .m-b-35 {
        margin-bottom: 35px;
    }

    .m-b-25 {
        margin-bottom: 25px;
    }
    
    .m-b-10 {
        margin-bottom: 10px;
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
			<div class="col-md-12 main">
				<!-- 회원탈퇴 part -->
				<div class="limiter ">
						<div class="container-login bg-light">
							<div class="wrap-loginp-b-20">

								<span class="login-form-title p-b-70"> Welcome </span> <span
									class="login-form-avatar">
									 <img src="/resources/popupSignin/images/open.jpg" id="thumbnail">
								</span>
								
								<div class="wrap-input validate-inputm-b-35"
									data-validate="Enter username">
									<input class="input" type="text" name="id" id=id1> <span
										class="focus-input" data-placeholder="Username"></span>
								</div>


								<div class="wrap-input validate-input m-b-25"
									data-validate="Enter password">
									<input class="input" type="password" name="password"
										id=password1> <span class="focus-input"
										data-placeholder="Password"></span>
								</div>


								<div class="container-login-form-btn">
									<button class="login-form-btn m-b-10" id="withdrawal_btn">
										회원 탈퇴</button>
									<button class="login-form-btn" id="cancel_btn">취소</button>
								</div>

							</div>
						</div>
					</div>
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
  <!-- Cancel btn -->
  <script>
  	$('#cancel_btn').on('click', function(){
  		location.href="/mypage/myInfo.mypage?id=${id}";
  	})
  </script>

    <!-- 회원탈퇴 btn -->
    <script>
        $('#withdrawal_btn').on('click', function() {
        	
        	var id = $('#id1').val();
            var password = $('#password1').val();
            
        	if(id==''||password==''){
        		alert("아이디와 패스워드를 입력해주세요.");
        	}else if(${id}==id){
               
        		$.ajax({
                    url: '/member/d_signin.member',
                    type: 'post',
                    data: {
                        id: id,
                        password: password
                    },
                    success: function(resp) {

                        if (resp == 'd_success' || resp == "k_success") {

                            let result = confirm('정말로 삭제하시겠습니까?');
                            if (result) {

                                $.ajax({
                                    url: '/mypage/withdrawal.mypage',
                                    type: 'post',
                                    data: {
                                        id: id
                                    }
                                    
                                }).done(function(resp){
                                    alert(resp);
                                    location.href="/";
                                })
                            }
                        } else {
                        	alert("아이디 또는 비밀번호가 일치하지 않습니다.");
                        }
                    }
                })	
        	}else{
        		alert("ID 또는 비밀번호가 일치하지 않습니다.");
        	}
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

</body>
</html>