<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Login</title>
 <meta name="viewport" content="width=device-width, initial-scale=1">
    

    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="/resources/popupSignin/images/icons/favicon.ico" />
    <!--===============================================================================================-->
     <link rel="stylesheet" type="text/css" href="/resources/popupSignin/vendor/bootstrap/css/bootstrap.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/fonts/iconic/css/material-design-iconic-font.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/vendor/animate/animate.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/vendor/css-hamburgers/hamburgers.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/vendor/animsition/css/animsition.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/vendor/select2/select2.min.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/vendor/daterangepicker/daterangepicker.css">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/css/util.css">
    <link rel="stylesheet" type="text/css" href="/resources/popupSignin/css/main.css">
    <!--===============================================================================================-->


</head>
<body>


    <div class="limiter">
        <div class="container-login100">
        <!--style="background-image: url('/resources/images/bg-01.jpg');"  -->
            <div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
         
                    <span class="login100-form-title p-b-49">
                        Login
                    </span>
						
                    <div class="wrap-input100 validate-input m-b-23">
                    <!--  ccc"-->
                        <span class="label-input100">아이디</span>
                        <input class="input100" type="text" placeholder="ID 입력" name="id" id="id"  data-validate="ID 입력 필수!" required>
                        <span class="focus-input100" data-symbol="&#xf206;"></span>
                    </div>

                    <div class="wrap-input100 validate-input">
                    <span class="label-input100">비밀번호</span>
                        <input class="input100" type="password" name="password" id="password" placeholder="비밀번호 입력" data-validate="비밀번호 입력 필수!" required>
                        <span class="focus-input100" data-symbol="&#xf190;"></span>
                    </div>
                    <div style="margin-top:5px;">
                    	<span><input type="checkbox" id="saveId"></span><span style="font-family: Poppins-Medium; font-size: 15px; color: gray;"> ID 기억하기</span>
                    </div>



                    <div class="text-right p-t-8 p-b-31">
						<div class="row" id="login_result" style="margin-left:0px; color:red; font-size:15px;"></div>
                        <div class="findIPw row">
                        	<div class="col-md-6 text-start">
                        		<a href="/member/findIdProc.member">
                            		Forgot id?
                        		</a>
                        	</div>
                        	<div class="col-md-6 text-end">
	                        	<a href="/member/findPwProc.member" >
	                            	Forgot password?
	                        	</a>	
                        	</div>
                        	</div>
					</div>

                    <div class="container-login100-form-btn">
                        <div class="wrap-login100-form-btn">
                            <div class="login100-form-bgbtn"></div>
                            <button type="button" class="login100-form-btn" id="signin_btn">
                                Login
                            </button>
                        </div>
                    </div>

                    <div class="txt1 text-center p-t-54 p-b-20">
                        <span>
                            Or Sign Up Using
                        </span>
                    </div>

                    <div class="flex-c-m">
                   <!--<a href="#" class="login100-social-item bg1">
                            <i class="fa fa-facebook"></i>
                        </a>-->

                        <div id="sns_Login_btn">
							<!-- kakao server단으로 로그인 구현 -->
                            <ul class="list-group">
                                <li class="list-group-item" style="list-style-type: none; border:0px;">
                                <a id="custom-login-btn" href="javascript:loginWithKakao()"> 
                                <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="222" />
                                    </a>
                                    <script type="text/javascript">
                                        function loginWithKakao() {
                                            location.href="https://kauth.kakao.com/oauth/authorize?client_id=2e74016a55faeab59754ac119822f522&redirect_uri=http://localhost/member/kakaologin&response_type=code";
                                        }
                                    </script>
                                </li>
                            </ul>
                          
                        </div>
                    </div>
            </div>
        </div>
    </div>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<!--  singup_btn -->
    <script>
        $('#signup_btn').on('click', function() {
         	location.heft="/member/signup.member";
        })
    </script>

    <!-- ============= 일반 pure 로그인 ===================================== -->
    <script>
        $('#signin_btn').on('click', function() {
        	
        	
            var id = $('#id').val();
            var password = $('#password').val();
            
            if(id==''||password==''){
            	document.getElementById('login_result').innerHTML = "ID 또는 패스워드 입력이 누락되었습니다.";
                return false;
            }else{
	            		$.ajax({
				            	url:'/member/d_signin.member',
				                type:'post',
				                data: {id:id, password:password},
				                success: function(resp) {
				                    if (resp == 'd_success') {
				                    	location.href="/member/afterSignin.member";
				                    	
									} else if(resp == 'd_fail'){
				                    	document.getElementById('login_result').innerHTML = "ID 또는 패스워드가 일치하지 않습니다.";
				                    }
				                }
				            })
	            			}
			        })
	</script>
			
 
  <script>
                                //1. page loading 후,
                                //   쿠키에 저장된 id가 있다면 input, 없다면 공백처리.
                                $(document).ready(function() {
                                    var userInputId = getCookie('userId');
                                    $("#id").val(userInputId);
                                });

                                //2. 체크박스의 변화가 있을 시
                                $('#saveId').on('change', function() {
                                  
                                    // 2-1. id 저장하기를 체크했을 경우
                                    if ($('#saveId').is(':checked')) {
                                        var userInputId = $('#id').val();
                                        setCookie('userId', userInputId, 7) // 7일간 저장
                                    } else {
                                        deleteCookie('userId');
                                    }
								})

								//3. id 저장하기를 체크한 상태에서 id 입력 시
                                $('#id').on('keydown', function() {
                                    if ($('#id').is(':checked')) {
                                        var userId = $('#id').val();
                                        setCookie('userId', userId, 7);
                                    }
                                })

                                function setCookie(cookieName, value, exdays) {
                                    var exdate = new Date();
                                    exdate.setDate(exdate.getDate() + exdays);
                                    var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
                                    document.cookie = cookieName + "=" + cookieValue;
                                }

                                function deleteCookie(cookieName) {
                                    var expireDate = new Date();
                                    expireDate.setDate(expireDate.getDate() - 1);
                                    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
                                }

                                function getCookie(cookieName) {
                                    cookieName = cookieName + '=';
                                    var cookieData = document.cookie;
                                    var start = cookieData.indexOf(cookieName);
                                    var cookieValue = '';
                                    if (start != -1) {
                                        start += cookieName.length;
                                        var end = cookieData.indexOf(';', start);
                                        if (end == -1) end = cookieData.length;
                                        cookieValue = cookieData.substring(start, end);
                                    }
                                    return unescape(cookieValue);
                                }
                            </script>




</body>
</html>