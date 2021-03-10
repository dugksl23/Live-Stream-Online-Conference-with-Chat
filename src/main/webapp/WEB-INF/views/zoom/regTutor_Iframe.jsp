<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<title>Insert title here</title>
</head>
<style>
 #zmmtg-root {
	display:none !important;
	margin:0 auto !important;
	position:none !important;

}
#zmmtg {
	overflow: auto;
}
</style>
		

<!-- ================================================================================================== -->		
		
	<div class="container">
		<div class="row">
			<div class="col-lg-12" style="margin-top: 20px; margin-bottom: 20px;">
				<a class="navbar-brand col-md-12">Zoom 미팅 시작 / 참여</a>
			</div>

			<div class="col-lg-4 col-md-4" style="pading-left: 20px; margin-bottom: 10px;">
				<div class="form-group">
					<label for="exampleInputName">미팅 번호</label> 
					<input type="text" name="meeting_id" id="meeting_number" value="" maxLength="200" style="width: 180px" placeholder="Meeting Number"
						class="form-control" required>
				</div>
			</div>
			<div class="col-lg-4 col-md-4">
				<div class="form-group">
					<label for="exampleInputName">이름</label> 
					<input type="text" style="width: 180px" name="display_name" id="display_name" value="${userInfo[0].name}" maxLength="100" class="form-control" required>
				</div>
			</div>			
			
			<div class="col" style="height:20px;"></div>
			
			<div class="col-lg-4 col-md-4">
				<div class="form-group" style="margin-bottom: 10px; display:none;">
					<label for="exampleInputName">미팅 Host</label>
					<select id="meeting_role" name="role" class="sdk-select">
						<option value=1>주최자</option>
 						<option value=0>참가자</option>
						<!--<option value=5>Assistant</option> -->
					</select>
				</div>

				<div class="form-group">
					<label for="exampleInputName" style="margin-bottom: 20px;">언어 선택</label> 
						<span> <select id="meeting_lang" class="sdk-select" name="meeting_lang" required>
							<option value="ko-KO">Korean 한국어</option>
							<option value="en-US">English</option>
							<option value="de-DE">German Deutsch</option>
							<option value="es-ES">Spanish EspaÃ±ol</option>
							<option value="fr-FR">French FranÃ§ais</option>
							<option value="jp-JP">Japanese 日本語</option>
							<option value="pt-PT">Portuguese Portuguese</option>
							<option value="ru-RU">Russian Русский</option>
							<option value="zh-CN">Chinese 简体中文</option>
							<option value="zh-TW">Chinese 繁体中文</option>
							<option value="vi-VN">Vietnamese Tiếng Việt</option>
							<option value="it-IT">Italian italiano</option>
					</select>
					</span>
				</div>
			</div>

		</div>
	</div>
	
	
	<!--  ======================================================================================
			 =================기본 입력 값 display none;==================================================-->
				<div class="form-group" style="display: none;">
					<select id="meeting_role" class="sdk-select">
						<option value=1>Host</option>
						<!--     <option value=0>Attendee</option>
	                            	<option value=5>Assistant</option>
	                         -->
					</select>
				</div>

				<div class="form-group" style="display: none;">
					<select id="meeting_role" class="sdk-select">
						<option value=1>Host</option>
						<!--     <option value=0>Attendee</option>
	                            	<option value=5>Assistant</option>
	                         -->
					</select>
				</div>


				<div class="form-group" style="display: none;">
					<select id="meeting_china" class="sdk-select">
						<option value=0>Global</option>
						<!--<option value=1>China</option> -->
					</select>
				</div>

				<div class="form-group" style="display: none;">
					<input type="text" name="meeting_email" id="meeting_email"
						value="${userInfo[0].email}" style="width: 150px" maxLength="32"
						placeholder="Email option" class="form-control">
				</div>
				
				<div class="form-group mt-10" style="display: none;">
					<button type="submit" class="btn btn-dark" id="join_meeting" style="margin-bottom: 30px;">Join Meeting</button>
				</div>
				
	
				
	
	<script src="https://source.zoom.us/1.9.0/lib/vendor/react.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/react-dom.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/redux.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/redux-thunk.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/lodash.min.js"></script>
	<script src="https://source.zoom.us/zoom-meeting-1.9.0.min.js"></script>
	<script src="/resources/zoom/zoom-app/CDN/js/tool.js"></script>
	<script src="/resources/zoom/zoom-app/CDN/js/vconsole.min.js"></script>
	<script src="/resources/zoom/zoom-app/CDN/js/index.js?version=31"></script>


	<!--===============================================================================================-->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	

</body>
</html>