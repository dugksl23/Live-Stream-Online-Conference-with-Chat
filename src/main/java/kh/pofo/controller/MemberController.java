package kh.pofo.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kh.pofo.dto.MemberDTO;
import kh.pofo.service.MemberService;
import kh.pofo.service.MypageService;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private HttpSession session;

	@Autowired
	private MemberService mService;
	
	@Autowired
	private MypageService mpService;
	
	

	
	
	

	
	
	//1. javascript 제어 login 구현
	
	@RequestMapping("k_signin.member")
	@ResponseBody
	public void getAccessToken(String authObj1) {
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(authObj1);
		System.out.println(authObj1);
		String access_Token = element.getAsJsonObject().get("access_token").getAsString();
        //String refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
		System.out.println(access_Token);
		session.setAttribute("access_Token", access_Token);
	}
	
	@RequestMapping(value="userInfo.member", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String kakaoLogin(String userInfo, Model model) {
		
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(userInfo);
		
		String kakaoUid=element.getAsJsonObject().get("id").getAsString();
		
		JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
		JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
		 
	    String name = properties.getAsJsonObject().get("nickname").getAsString();
	    String email = kakao_account.getAsJsonObject().get("email").getAsString();
		String thumbnail=element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("profile").getAsJsonObject().get("thumbnail_image_url").getAsString();
		
		//======== 로그인 또는 회원가입 성공 후에 sns 유형 저장=====
	    mService.saveUserInfo(kakaoUid, email,name, thumbnail);
	    session.setAttribute("sns_code", "01");
	    
	    return null;
	}
	
	
	@RequestMapping(value="k_signout.member")
	public String signOut(HttpSession session) {
		System.out.println("카카오 로그아웃 도착");
		mService.kakaoLogout((String)session.getAttribute("access_Token"));
	    session.invalidate();
	    return "redirect:/";
	}

//================= 카카오토 관련 로그인 / 회원정보 저장 / 로그아웃 =========================
	
	
	
	 
	 
	//2. server를 통한 login 제어
	@RequestMapping("/kakaologin")
	public String login(@RequestParam(value = "code", required = false) String code) throws Exception{
		
	        System.out.println("#########" + code);
	        String access_Token = mService.getAccessToken(code);
	        System.out.println("###access_Token#### : " + access_Token);
	        
	        HashMap<String, Object> snsUserInfo=mService.getUserInfo(access_Token);
	        session.setAttribute("access_Token", access_Token);
	        
	        mService.saveUserInfo((String)snsUserInfo.get("id"), (String)snsUserInfo.get("email"), (String)snsUserInfo.get("name"),(String)snsUserInfo.get("thumbnail"));
	        
	        List<MemberDTO> userInfo=mService.snsUserInfo((String)snsUserInfo.get("id"));
			session.setAttribute("userInfo", userInfo);
	        session.setAttribute("id", userInfo.get(0).getId());
	        session.setAttribute("sns_code", userInfo.get(0).getSns_code());
	        	
	        return "redirect:/";
	}
	 
	
	
//=============== 3.  direct 회원 로직 구현 ================================	
	 
	@RequestMapping("popUpSignin.member")
	public String popupSinginProc() {
		System.out.println("경로 확인");
		return "/login/popUpSigninView";
	}
	
	
	
	@RequestMapping(value="duplicateCheck.member", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String checkDuplicateId(String id) {
	
		String result=mService.checkId(id);
		return result;
	}
	
	@RequestMapping(value="d_signin.member", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String singin(MemberDTO dto) throws Exception {
		
		int result=mService.signin(dto);
		String msg="";
		if(result==1) {
			System.out.println("다이렉트 로그인 성공");
			
			List<MemberDTO> userInfo=mpService.myInfo(dto.getId());
			session.setAttribute("id", userInfo.get(0).getId());
			session.setAttribute("userInfo", userInfo);
			session.setAttribute("sns_code", userInfo.get(0).getSns_code());
	        
			msg="d_success";
		}else {
			msg="d_fail";
		}
		return msg;
	}
	
	
	@RequestMapping("afterSignin.member")
	public String aferSignin() {
		System.out.println("도착");
		
		return "redirect:/";
	}

	@RequestMapping(value="/signupProc.member",  produces = "text/plain; charset=UTF8")
	public String signupProc() {
		System.out.println("도착 확인");
		return "/login/signupView";
	}

	@RequestMapping(value="afterSignup.member", produces = "text/plain; charset=UTF8")
	public String signup(MemberDTO dto, MultipartFile[] thumbnail, Model model, HttpServletRequest req) throws Exception {
		
		req.setCharacterEncoding("utf-8");

		if(thumbnail[0].getSize()!=0) {
			
			dto.setThumbnail_url(mService.upload(thumbnail));
			System.out.println(dto.getThumbnail_url());
		} 
		
		int result=mService.signup(dto);
		if(result==1) {
			model.addAttribute("signupResult", result);
		}else {
			model.addAttribute("signupResult", result);
		}
		
		return "redirect:/";
	}

	@RequestMapping("/d_signout")
	public String signOut() {
		session.invalidate();
		return "redirect:/";
	}

	
	// 비밀번호 찾기 view 이동
	@RequestMapping("/findPwProc.member")
	public String findPwProc() {
		return "/login/findPw";
	}
	
	// search for password
	@RequestMapping(value="/findPw.member", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String findPw(Model model,MemberDTO dto) throws EmailException {
		
		System.out.println("find pw controller 도착");
		System.out.println("id :"+dto.getId());
		System.out.println("email :"+dto.getEmail());
		
		String msg=mService.findPw(dto);
		
		return msg;
	}
	
	
	// id 찾기 view 이동
	@RequestMapping("/findIdProc.member")
	public String findIdProc() {
		return "/login/findId";
	}
	
	// search for password
	@RequestMapping(value="/findId.member", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String findId(Model model,MemberDTO dto) throws EmailException {
		
		System.out.println("find pw controller 도착");
		System.out.println("name :"+dto.getName());
		System.out.println("email :"+dto.getEmail());
		
		String msg=mService.findId(dto);
		
		return msg;
	}
	
	
	
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		
		e.printStackTrace();
		
		return "error";
	}
}
