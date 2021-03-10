<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <meta charset="UTF-8">
    <title>Document</title>
<link href="/resources/reg-form/css/bootstrap.min.css" rel="stylesheet">
</head>      

<style>
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
        width: 25%;
        height: 40px;
        background-color: #57b846;
        border-radius: 25px;
        margin-right: 50px;
     
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

    .file_input_textbox {display: inline; height:25px; border: 1px solid;width:10%; margin: 0 auto;}
	.file_input_div {display: inline; position:relative; width:80px; height:40px; overflow:hidden;}
	.file_input_img_btn {padding:0 0 0 5px; height:30px; }
	.file_input_hidden {
        float:left;
        font-size:29px; height:30px; position:absolute; 
        right:0px; top:0px; opacity:0; filter: alpha(opacity=0);
        -ms-filter: alpha(opacity=0); cursor:pointer;
    }

	.main{
	width:1200px;
	}
	.bottom-nav{
	height:50px;
	}
	
	#signup_btn{
		
		cursor:pointer;
	}
  
</style>


<body class="bg-light">
	<div class="container">
  	 

		<div class="row">
			<div class="col-md-12 py-5 text-center">
				<h2>회원 가입</h2>
			</div>
			<div class="col-md-12">
				<form action="/member/afterSignup.member" method="post" onsubmit="return false" enctype="multipart/form-data" id="signup-form">


					<div class="form-group" style="margin: auto; text-align: center;">
						<img id="thumbnail" class="d-block mx-auto mb-4" src="/resources/popupSignin/images/profile.jpg" alt="" width="100" height="100"> <input type="text" id="fileName" class="file_input_textbox form-control" style="width: 40%; margin: auto;" readonly>
						<div class="file_input_div ">
							<img src="/resources/popupSignin/images/open.jpg" class="file_input_img_btn" alt="open" /> 
							<input type="file" id="img-upload" name="thumbnail" class="file_input_hidden" accept="image/gif, image/jpeg, image/png"/>
						</div>
					</div>

					<div class="form-group">
						<label for="exampleInputName">이름</label> 
						<input type="text"
							class="form-control" id="name" name="name" placeholder="이름" data-validate="이름 입력 필수!" maxlength='10' required>
					</div>

					<div class="form-group">
						<label for="exampleInputName">아이디</label> 
						<input type="text" class="form-control" id="id" placeholder="아이디" aria-describedby="idlHelp" maxlength='16' minlength='4' name="id" data-validate="ID 입력 필수!" required>
						<div style="height:10px;"></div>
						<button type="button" class="btn btn-outline-secondary" id="checkId">ID 중복 검사</button>
					</div>

					<div class="form-group">
						<label for="exampleInputPassword1">비밀번호 </label> 
						<input type="password" class="form-control" id="password" placeholder="******" maxlength='16' minlength='6' name="password" data-validate="비밀번호 입력 필수!" required>
						<div style="height:10px;"></div>
						<input type="password" class="form-control" id="checkPw" placeholder="비밀번호 재입력" maxlength='16' minlength='6' data-validate="비밀번호 재입력 필수!" required>
						<div class="form-text text-muted">비밀번호 재입력</div> 
						<small class="form-text text-muted" id="checkpwResult" style="color:red;"></small>
					</div>


					<div class="form-group">
						<label for="exampleInputEmail1">E-mail</label> 
						<input type="email" class="form-control" id="email1" placeholder="Jem@email.com" aria-describedby="emailHelp" data-validate="E-mail 입력 필수!" name="email" required> 
						<small id="idlHelp" class="form-text text-muted">ID 또는 비밀번호 찾는 데에 사용될 것입니다.</small>
					</div>

					<div class="form-group">
						<label for="exampleInputContanct_number">전화번호</label> 
						<input type="text" class="form-control" id="contanct_number" placeholder="010-1234-5678 or 01012345678" aria-describedby="emailHelp" name="contact_number"> 
						<small id="emailHelp" class="form-text text-muted">자유롭게 기입해 주세요.</small>
					</div>



					<div class="form-group">
						<label for="exampleInputAddress1">주소 </label> 
						<input type="text" class="form-control" id="address1" placeholder="서울 특별시 광진구" name="address1" data-validate="주소지 입력 필수!" required>
						<div style="height:10px;"></div>
						<input type="text" class="form-control" id="address2" name="address2" placeholder="1234 Main St"> 
						<small class="form-text text-muted">기타 주소</small>
						<div style="height:10px;"></div>
						<button type="button" class="btn btn-outline-secondary" id="address_search_btn">주소 검색</button>
					</div>

					<div class="form-group">
						<label for="exampleInputPost_code">우편 번호 </label> 
						<input type="text" class="form-control" id="post_code" name="post_code" data-validate="우편번호 입력 필수!" required>
					</div>

					<div class="form-group">
						<label for="exampleInputPassword1">광고수신 </label> <br> 
						<input	type=checkbox id="ad" name="get_ad" value='N'> 수신 동의
					</div>
					
					<div class="container-login-form-btn">
						<button type="submit" class="login-form-btn m-b-10" id="signup_btn">가입</button>
						<button type="button" class="login-form-btn" id="cancel_btn">취소</button>
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<nav class="bottom-nav"></nav>
		</div>
	</div>	
	
	
	<!--=========================================================-->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

	<!-- [ 회원가입 버튼 hide ] ================================================================== -->
	<script>
	$('#signup').hide();
</script>

<!--  [ form submit 및 submit 버튼 클릭 이벤트 ] ================================================================== -->
<script>

$('#signup_btn').on('click', function(){
	return formSubmit();
})	
	
	
	function formSubmit(){
		if ($('#id').val() != null) {
			$.ajax({
				url : '/member/duplicateCheck.member',
				type : "post",
				data : {id : $('#id').val()},
				success : function(res) {
					if (res == "사용 가능한 ID입니다.") {
						if($('#checkPw').val()!=$('#password').val()||$('#password').val()!=$('#checkPw').val()){
							alert("비밀번호가 일치하지 않습니다.");
							return false;
						}else if($('#id').val()!=''&&$('#passowrd').val()!=''&&$('#name').val()!=''&&$('#email').val()!=''&&$('#address1').val()!=''&&$('#post_code').val()!=''&&$('#checkPw').val()==$('#password').val()){
							$('#signup-form').attr("onsubmit", true);
							$('#signup-form').submit();
						}
						
					}else if(res="이미 사용중인 ID입니다."){
						$('#checkId').html(res);
						$('#checkId').focus();
						return false;
					}
				},
				fail:function(res){
					$('#checkId').html(res);
				}
			})
		}else{
			return false;
		}
	}
</script>

	<!-- [ id 유효성 검사 ] ================================================================== -->
<script>
			$('#checkId').on('click', function() {
				var id = $('#id').val();
				if (id == "") {
					$('#checkId').html("유효한 아이디를 입력해주세요.");				
				} else if (id != "") {

					$.ajax({
						url : '/member/duplicateCheck.member',
						type : "post",
						data : {
							id : $('#id').val()
						},
						success : function(res) {
							$('#checkId').html(res);
							$('#checkId').focus();
						},
						fail : function(res) {
						}
					})
				}

			})
</script>

	<!-- ================================================================================= -->

	<!-- [ 비번 유효성 검사 ] ================================================================== -->
	<script>
  $('#checkPw').on('input', function(){
	  if($('#checkPw').val()!=$('#password').val()){
		  $('#checkpwResult').html('비밀번호가 일치하지 않습니다.');
	  }else{
          $('#checkpwResult').html('비밀번호가 일치합니다.');
	  }
  })
  
  $('#password').on('input', function(){
	  if($('#checkPw').val()!=$('#password').val()){
		  $('#checkpwResult').html('비밀번호가 일치하지 않습니다.');
		  $('#checkpwResult').focus();
		  
	  }else{
          $('#checkpwResult').html('비밀번호가 일치합니다.');
          $('#checkpwResult').focus();
		}
  })
</script>
	<!-- [ 돌아가기(취소) 버튼 click 이벤트 ] ================================================================== -->
	<script>
  	$('#cancel_btn').on('click', function(){
  		location.href="/";
  	})
</script>


	<script>
    
// 광고 수신 여부 =====================================================================================	
$('#ad').on('click', function(){
    		
    if($('#ad').val()=='N'){
    	$('#ad').val('Y');
    	
    }else{
    	$('#ad').val('N');
    }
})
          
</script>

	<!-- [ 다음 주소지 입력 함수 ] ================================================================== -->
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		
		 function daumPostcode() {
		            new daum.Postcode({
		                oncomplete: function(data) {
		                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                            document.getElementById('post_code').value = data.zonecode;
		                    document.getElementById("address1").value = roadAddr;
		                    
		                }
		            }).open();
		        }
       
       
          let search = document.getElementById("address_search_btn");
		        search.onclick = daumPostcode;
	
</script>

<!-- [ 썸네일 업로드 이벤트 ] ==================================================================== -->
<script>
     $('#img-upload').on('change', function(e){
         var sel_files;
         var limit=10485760;
         /* e.target.files는 이벤트 객체인 e를 console에 찍어보면 type, target 등 노출*/
         /*files를 찍으면 filesList안에 배열형태로 파일에 대한 정보가 나온다. 
         /name, size, type 등 말이다.*/
        var files=e.target.files;
		var files_size=files[0].size;
         
         /* Array.prototype.slice.call(files)는 이 코드가 존재하는 함수의 매개변수로 넘어온 값을 Array(배열)로 변환하겠다는 것이다*/
         var filesArr=Array.prototype.slice.call(files);

         /*fileArr는 배열로 되어있기 때문에 forEach를 쓸 수 있다. 
         type.match를 통해 이미지 확장자만 업로드할 수 있도록 체크한다. 
                   만약 이미지 확장자외에 다른 파일을 업로드 할 시 null이 반환된다.*/
         filesArr.forEach(function(f){
             if(!f.type.match('image.*')){
                    alert('확장자는 이미지 파일만 가능합니다.');
                    $('#img-upload').val(null);	               
                    return;
                }else if(files_size > limit){
                	alert("10mb를 초과하실 수 없습니다.");
                	$('#img-upload').val(null);
                	return;
                }else{
                	sel_filse=f;
                	 /* FileReader 객체 생성 */     
                    var reader=new FileReader();
                    /* reader의 onload가 함수 실행되면서
                    FileReader.onload는 load의 이벤트 핸들러로 읽기 동작이 성공적으로 완료 되었을 때마다 발생한다.*/
                    reader.onload=function(e){
                        /* 업로드된 이미지의 base64 인코딩 된 스트링 데이터 */
                        $('#thumbnail').attr("src", e.target.result);
                        $('#fileName').val($('#img-upload').val());
                        
                    }
                    
                      /* 
                   get_file[0] 을 읽어서 read 행위가 종료되면 loadend 이벤트가 트리거 되고 
                   onload 에 설정했던 return 으로 넘어간다.
                                         이와 함게 base64 인코딩 된 스트링 데이터가 result 속성에 담겨진다.
                   readAsDataURL 메서드는 f를 읽어 오는 역할을 한다. 이 경우 업로드 된 파일의 정보를 읽는다.
                    */
                    reader.readAsDataURL(f);
                }
       })
         
     })
</script>



</body>
</html>