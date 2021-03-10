<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title></title>
</head>

<style>
    *{
     box-sizing: border-box;
        
    }
    
        .sdk-select {
            height: 34px;
            border-radius: 4px;
        }

        .websdktest button {
            float: right;
            margin-left: 5px;
        }

        #nav-tool {
            margin-bottom: 0px;
        }

        #show-test-tool {
            position: absolute;
            top: 100px;
            left: 0;
            display: block;
            z-index: 99999;
        }

        #display_name {
            width: 250px;
        }


        #websdk-iframe {
            width: 700px;
            height: 500px;
            border: 1px;
            border-color: red;
            border-style: dashed;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            left: 50%;
            margin: 0;
        }
    </style>


<body>


	 <nav id="nav-tool" class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand">Zoom Web</a>
            </div>
            <div id="navbar" class="websdktest">
                <form class="navbar-form navbar-right" id="meeting_form">
                    <div class="form-group">
                        <input type="text" name="display_name" id="display_name" value="${name}" maxLength="100"
                            class="form-control" required>
                    </div>
                    <div class="form-group">
                        <input type="text" name="meeting_number" id="meeting_number" value="${meeting_id}" maxLength="200"
                            style="width:150px" placeholder="Meeting Number" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <input type="text" name="meeting_pwd" id="meeting_pwd" value="${password}" style="width:150px"
                            maxLength="32" placeholder="Meeting Password" class="form-control">
                    </div>
                    <div class="form-group">
                        <input type="text" name="meeting_email" id="meeting_email" value="${email}" style="width:150px"
                            maxLength="32" placeholder="Email option" class="form-control">
                    </div> 


                    <div class="form-group">
                        <select id="meeting_role" class="sdk-select">
                            <option value=1>Host</option>
                        <!--     <option value=0>Attendee</option>
                            	<option value=5>Assistant</option>
                         -->
                         </select>
                    </div>
                    <div class="form-group">
                        <select id="meeting_china" class="sdk-select" value="${location}">
                            <option value=0>Global</option>
                          <!--<option value=1>China</option> --> 
                        </select>
                    </div>
                    <div class="form-group">
                        <select id="meeting_lang" class="sdk-select" value="${meeting_lang}">
                            <option value="en-US">English</option>
                            <option value="de-DE">German Deutsch</option>
                            <option value="es-ES">Spanish Español</option>
                            <option value="fr-FR">French Français</option>
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

                    <input type="hidden" value="" id="copy_link_value" />
                    <button type="submit" class="btn btn-primary" id="join_meeting">Join</button>
                </form>
            </div>
            <!--/.navbar-collapse -->
        </div>
    </nav>


	<script src="https://source.zoom.us/1.9.0/lib/vendor/react.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/react-dom.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/redux.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/redux-thunk.min.js"></script>
	<script src="https://source.zoom.us/1.9.0/lib/vendor/lodash.min.js"></script>
	<script src="https://source.zoom.us/zoom-meeting-1.9.0.min.js"></script>
	<script src="/resources/zoom/zoom-app/CDN/js/tool.js"></script>
	<script src="/resources/zoom/zoom-app/CDN/js/vconsole.min.js"></script>
	<script src="/resources/zoom/zoom-app/CDN/js/index.js?version=16"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script>
		
		$('#display_name').val('${name}');
		$('#meeting_number').val('${meeting_id}');
		$('#meeting_pwd').val('${password}');
		
		$(document).ready(function(){
		$("#join_meeting").trigger("click");
		});  
</script>

</body>
</html>