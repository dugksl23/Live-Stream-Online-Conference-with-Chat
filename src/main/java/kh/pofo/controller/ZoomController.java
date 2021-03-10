package kh.pofo.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kh.pofo.dto.MemberDTO;
import kh.pofo.service.ZoomService;

@Controller
@RequestMapping("/zoom")
public class ZoomController {

	@Autowired
	private ZoomService zService;


	@Autowired
	private HttpSession session;

	@RequestMapping("/zoomBoard.zoom")
	public String zoomBoard(Model model) {

		List<MemberDTO> tutors=zService.getTutors();

		model.addAttribute("tutors", tutors);

		return "/zoom/zoomBoard";
	}

	@RequestMapping("/generateSignature.zoom")
	@ResponseBody
	public String generateSignature(String apiKey, String meetingNumber, Integer role) {

		String signature=zService.generateSignature(apiKey, meetingNumber, role);
		return signature;
	}


	@RequestMapping("/regTutor.zoom")
	public String regTutor() {
		return "/zoom/regTutor";
	}

	@RequestMapping("/regTutor_Iframe.zoom")
	public String regTutor_Iframe() {
		return "/zoom/regTutor_Iframe";
	}


	@RequestMapping(value="/createMeeting.zoom",  method = RequestMethod.POST, produces="text/plain; charset=UTF8")
	@ResponseBody
	public String createMeeting(String name, String mn, String email, String pwd, String role, String lang,
			String signature, String china, String apiKey, Model model) {

		String joinUrl = "?name=" + name + "" + "&mn=" + mn + "" + "&email=" + email + "" + "&pwd=" + pwd + ""
				+ "&role=" + role + "" + "&lang=" + lang + "" + "&signature=" + signature + "" + "&china=" + china + ""
				+ "&apiKey=" + apiKey + "";

		session.setAttribute("join_Url", joinUrl);
		session.setAttribute("meetingNumber", mn);
		
		String redirectUrl="/zoom/joinMeeting.zoom";

		return redirectUrl;

	}

	@RequestMapping("/joinMeeting.zoom")
	public String joinMeeting() {
		
		String organizer=(String)session.getAttribute("organizer");
		if(organizer==null) {
			System.out.println("tutor_id 생성되기 전이라서 생성함");
			session.setAttribute("organizer", (String)session.getAttribute("id"));
		}

		return "/zoom/joinMeeting";
	}

	@RequestMapping(value="/getMeetingDetail.zoom", produces="text/plain; charset=UTF8")
	@ResponseBody
	public String retrieveDetailOf_theMeeting() throws IOException {
		
		//========================================================
		// 1. jwt token (access token)생성
		String access_Token = zService.createToken();
		String invite_Url=zService.retrieveDetailOf_theMeeting(access_Token, (String)session.getAttribute("meetingNumber"));
		int pwd_length=invite_Url.indexOf("pwd=");
		String pwd=invite_Url.substring(pwd_length+4).replace("\"", "");
		JsonObject obj=new JsonObject();
		obj.addProperty("meeting_pwd", pwd);
		
		return obj.toString();
	}

	//====================================================================================================================
	// [tutor의 정보를 db에 저장] ===============================================
	@RequestMapping(value = "/setTutors.zoom", method = RequestMethod.POST)
	public String setTutors(String userInfo) {

		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(userInfo);
		
		String host_id = element.getAsJsonObject().get("id").getAsString();
		String date=element.getAsJsonObject().get("date").getAsString();
		
		session.setAttribute("host_time",date);

		int result = zService.setTutors(host_id);

		return "redirect:/zoom/zoomBoard.zoom";
	}


	@RequestMapping("/deleteTutors.zoom")
	@ResponseBody
	public String deleteTutors(String host_id) {
		
		String result = zService.deleteTutors(host_id);
		session.removeAttribute("join_Url");
		
		return result;
	}

	@RequestMapping("/searchTutors.zoom")
	public String searchTutors(String host_id, Model m) {

		List<MemberDTO> tutors= zService.searchTutors(host_id);
		m.addAttribute("tutors",tutors);	

		return "/zoom/zoomBoard";
	}


	@RequestMapping("/zoomIframe.zoom")
	public String zoomIframe() {

		return "/zoom/zoomIframe";
	}

	@RequestMapping("/createMeeting_Iframe.zoom")
	public String createMeeting_Iframe() {

		return "/zoom/createMeeting";
	}


	@RequestMapping("/removeTutor.zoom")
	@ResponseBody
	public String removeTutor() {
		
		session.removeAttribute("organizer");
		
		return "";
		
	}
	
	
	@ExceptionHandler
	public String exceptionHandler(Exception e) {

		e.printStackTrace();

		return "error";
	}



}