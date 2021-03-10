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

    .file_input_textbox {display: inline !important; height:28px !important; border: 1px solid !important; width:40% !important; margin: 0 auto !important;}
	.file_input_div {display: inline !important; position:relative !important; width:80px !important; height:40px !important; overflow:hidden !important;}
	.file_input_img_btn {padding:0 0 0 5px !important; height:30px !important; }
	.file_input_hidden {
        float:left !important;
        font-size:29px !important; height:35px !important; position:absolute !important; 
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
				<h2>회원 정보 수정</h2>
			</div>
			<div class="col-md-12">
				<form action="/mypage/afterUpdateMyInfo.mypage" method="post" onsubmit="return false" enctype="multipart/form-data" id="updateMyInfo-form">
					<c:forEach var="i" items="${userInfo}">
					<div class="form-group" style="margin: auto; text-align: center;">
						<img id="thumbnail" class="d-block mx-auto mb-4 rounded-circle user_img" src="/resources/popupSignin/images/profile.jpg" alt="" width="100" height="100"> 
							<input type="text" id="fileName" width="100" class="file_input_textbox form-control" readonly>

						<div class="file_input_div ">
							<!-- input type="file을 opacity:0으로 하고, float를 통한 viewport를 통해 겹치게한다.
							          하지만, open img가 보이게 되며,첨부파일 클릭은만 가능해진다.  -->
							<img src="/resources/popupSignin/images/open.jpg" class="file_input_img_btn" alt="open" /> 
							<input type="file" id="img-upload" name="thumbnail" accept="image/gif, image/jpeg, image/png" class="file_input_hidden" />
						</div>
					</div>

					<div class="form-group">
						<label for="exampleInputName">이름</label> 
						<input type="text" 	class="form-control" id="name" name="name" placeholder="${i.name}" data-validate="이름 입력 필수!" required>
					</div>

					<div class="form-group">
						<label for="exampleInputName">아이디</label> 
						<input type="text" class="form-control" id="id" value="${i.id}" aria-describedby="idlHelp" maxlength='16' minlength='4' name="id" readonly>
					</div>

					<div class="form-group password-container">
						<label for="exampleInputPassword1">비밀번호 </label> 
						<input type="password" class="form-control" id="myInfo_password" placeholder="******" maxlength='16' minlength='6' name="password" data-validate="비밀번호 입력 필수!" required>
						<div style="height:10px;"></div>
						<input type="password" class="form-control" id="checkPw" placeholder="비밀번호 재입력" maxlength='16' minlength='6' data-validate="비밀번호  재입력 필수!" required>
						<small class="form-text text-muted">비밀번호 재입력</small> 
						<small class="form-text text-muted" id="checkpwResult" style="color:red;"></small>
					</div>


					<div class="form-group">
						<label for="exampleInputEmail1">E-mail</label> 
						<input type="email" class="form-control" id="email1" placeholder="${i.email}" aria-describedby="emailHelp" name="email" data-validate="E-mail 입력 필수!" required>
						<small id="idlHelp" class="form-text text-muted">ID 또는 비밀번호를 찾는 데에 사용될 것입니다.</small>
					</div>

					<div class="form-group">
						<label for="exampleInputContanct_number">전화번호</label> 
						<input type="text" class="form-control" id="contanct_number" placeholder="${i.contact_number}" aria-describedby="emailHelp" name="contact_number"> 
						<small id="emailHelp" class="form-text text-muted">자유롭게 기입해주세요.</small>
					</div>



					<div class="form-group">
						<label for="exampleInputAddress1">주소 </label> 
						<input type="text" class="form-control" id="address1" placeholder="${i.address1}" name="address1" data-validate="주소지 입력 필수!" required>
						<div style="height:10px;"></div>
						<input type="text" class="form-control" id="address2" name="address2" placeholder="${i.address2}"> 
						<small class="form-text text-muted">기타 주소</small>
						<div style="height:10px;"></div>
						
						<button type="button" class="btn btn-outline-secondary" id="address_search_btn">주소 검색</button>
					</div>

					<div class="form-group">
						<label for="exampleInputPost_code">우편 번호 </label> 
						<input type="text" class="form-control" id="post_code" name="post_code" placeholder="${i.post_code}" data-validate="우편번호 입력 필수!" required>
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
				</form>
			</div>
		</div>
        <div class="row">
			<nav class="bottom-nav">b-navi</nav>
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

<script>
$('#update_btn').on('click', function(){
	return formSubmit();
})	

	function formSubmit(){
						if($('#checkPw').val()!=$('#myInfo_password').val()||$('#checkPw').val()!=$('#myInfo_password').val()){
							alert("비밀번호가 일치하지 않습니다.");
							return false;
						}else if($('#myInfo_passowrd').val()!=''&&$('#name').val()!=''&&$('#email').val()!=''&&$('#address1').val()!=''&&$('#post_code').val()!=''&&$('#checkPw').val()==$('#myInfo_password').val()){
							
							$('#updateMyInfo-form').attr("onsubmit", true);
							$('#updateMyInfo-form').submit();
						}
					
				
			}
		
	

</script>


<!-- [ 비번 유효성 검사 ] ================================================================== -->
<script>
  $('#checkPw').on('input', function(){
	  if($('#checkPw').val()!=$('#myInfo_password').val()){
		  $('#checkpwResult').html('비밀번호가 일치하지 않습니다.');
	  }else{
          $('#checkpwResult').html('비밀번호가 일치합니다.');
	  }
  })
  
  $('#myInfo_password').on('input', function(){
	  if($('#checkPw').val()!=$('#myInfo_password').val()){
		  $('#checkpwResult').html('비밀번호가 일치하지 않습니다.');
	  }else{
          $('#checkpwResult').html('비밀번호가 일치합니다.');
	  }
  })
</script>


<!-- [ 돌아가기(취소) 버튼 click 이벤트 ] ================================================================== -->
<script>
  	$('#cancel_btn').on('click', function(){
  		location.href="/mypage/myInfo.mypage?id=${id}";
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

if($('#ad').val()=='Y'){
       	$('#ad').val('Y');
       	$('#ad').attr("checked", true)
       	
}else{
        $('#ad').val('N');
        $('#ad').attr("checked", false)
}

</script>

<!-- [ 다음 주소지 입력 함수 ] ================================================================== -->
<script	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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
         console.log(files);
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
                    return false;
                }else if(files_size > limit){
                	alert("10mb를 초과하실 수 없습니다.");
                	$('#img-upload').val(null);
                	return false;
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

<!-- thumbnail 미리보기 with file input tag-->
<script>
							   
if('${userInfo[0].thumbnail_url}'!=''&&'${userInfo[0].sns_code}'==02){
    $('#thumbnail').attr("src", '${userInfo[0].thumbnail_url}');
}else if('${userInfo[0].thumbnail_url}'!=''&&'${userInfo[0].sns_code}'==01){
    $('#thumbnail').attr("src", '${userInfo[0].thumbnail_url}');
}
</script>

<!--///////////////////////////////////////////////////////////
[snsUser용 myinfo view]  -->
<script>
   	if(${userInfo[0].sns_code}!=02){
   		
   		$('.password-container').hide();
   		
        $('.file_input_img_btn').hide();
   		$('#img-upload').hide();
   		
        $(".file_input_textbox").val("sns User는 변경 불가");
   		$(".file_input_textbox").css("text-align","center");
   		$(".file_input_textbox").css("color","red");
   		$(".file_input_textbox").css("border-color","lightblue");
   		$(".file_input_textbox").css("font-weight","bold");
   		
   		$(".file_input_textbox").attr("readonly", true);
   	}

</script>



</body>
</html>