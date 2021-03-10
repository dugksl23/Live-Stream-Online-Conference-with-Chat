<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<title>Learning English</title>
<meta charset="UTF-8">

</head>
<style>
#zmmtg-root {
	display:none;
	overflow:auto;
	style:all:none;
}
#zmmtg{
overflow:auto;}


</style>


<div class="contaienr border bg-light" style="border: 1px solid rightgray;">
	<div class="row" style="margin-left:60px;">

		<div class="col-lg-12" style="margin-top:20px; margin-bottom:20px;">
			<a class="navbar-brand col-md-12">Zoom 미팅 시작 / 참여</a>
		</div>
		
		<div class="col-lg-4 col-md-6" style="pading-left:20px;  display:none;">
			<div class="form-group">
				<label for="exampleInputName">이름</label> <input type="text"
					name="name" id="display_name" name="name" maxLength="100"
					style="width: 180px" placeholder="Name" class="form-control"
					value="${userInfo[0].name}">
			</div>

			<div class="form-group" style=" display:none;">
				<label for="exampleInputName">E-mail</label> <input type="text"
					name="email" id="meeting_email" value="" style="width: 180px"
					maxLength="32" placeholder="Email option" class="form-control" value="${userInfo[0].email}">
			</div>
		</div>
		
		
		<div class="col-lg-4 col-md-6 d-block">

			<div class="form-group">
				<label for="exampleInputName">미팅 번호</label> <input type="text"
					name="meeting_id" id="meeting_number" value="" maxLength="200"
					style="width: 180px" placeholder="Meeting Number"
					class="form-control" required>
			</div>
			
			<div class="form-group col-md-12 col-md-6" style="margin-bottom:15px; display:none;">
					<label for="exampleInputName">미팅 Host</label> <select
						id="meeting_role" name="role" class="sdk-select">
						<option value=1>주최자</option>
						<option value=0>Attendee</option>
						<option value=5>Assistant</option>
					</select>
			</div>
			 

 			<div class="form-group" style="margin-bottom:15px;">
				<label for="exampleInputName">비밀 번호</label> <input type="text"
					name="meeting_pwd" id="meeting_pwd" value="" style="width: 180px"
					maxLength="32" placeholder="Meeting Password" class="form-control"
					required>
			</div> 


		</div>
		<div class="col-lg-4">
			<div class="row">
				
				<div class="form-group mt-10 col-md-6" style="margin-bottom:15px; display:none;">
					<label for="exampleInputName">지역 선택</label> <select
						id="meeting_china" class="sdk-select" name="location">
						<option value=0>Global</option>
					</select>
				</div>
				
				<div class="form-group mt-10 col-md-12" style="margin-bottom:15px;">
					<label for="exampleInputName">언어 선택</label> <select
						id="meeting_lang" class="sdk-select" name="meeting_lang" required>
						<option value="en-US">English</option>
						<option value="de-DE">German Deutsch</option>
						<option value="es-ES">Spanish EspaÃ±ol</option>
						<option value="fr-FR">French FranÃ§ais</option>
						<option value="jp-JP">Japanese 日本語</option>
						<option value="pt-PT">Portuguese Portuguese</option>
						<option value="ru-RU">Russian Русский</option>
						<option value="zh-CN">Chinese 简体中文</option>
						<option value="zh-TW">Chinese 繁体中文</option>
						<option value="ko-KO">Korean 한국어</option>
						<option value="vi-VN">Vietnamese Tiếng Việt</option>
						<option value="it-IT">Italian italiano</option>
					</select>
				</div>
				
				
				
				<div class="form-group mt-10 col-md-12">
					<button type="submit" class="btn btn-dark" id="join_meeting" style="margin-bottom:20px;">Create
						Meeting</button>
				</div>
				
			</div>
		</div>
	</div>
</div>


<script src="https://source.zoom.us/1.9.0/lib/vendor/react.min.js"></script>
<script src="https://source.zoom.us/1.9.0/lib/vendor/react-dom.min.js"></script>
<script src="https://source.zoom.us/1.9.0/lib/vendor/redux.min.js"></script>
<script src="https://source.zoom.us/1.9.0/lib/vendor/redux-thunk.min.js"></script>
<script src="https://source.zoom.us/1.9.0/lib/vendor/lodash.min.js"></script>
<script src="https://source.zoom.us/zoom-meeting-1.9.0.min.js"></script>
<script src="/resources/zoom/zoom-app/CDN/js/tool.js"></script>
<script src="/resources/zoom/zoom-app/CDN/js/vconsole.min.js"></script>
<script src="/resources/zoom/zoom-app/CDN/js/index.js?version=29"></script>

<!--===============================================================================================-->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>

</body>
</html>
