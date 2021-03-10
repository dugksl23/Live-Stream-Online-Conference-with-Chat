package kh.pofo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import encryption.Encryption;
import kh.pofo.dto.MemberDTO;
import kh.pofo.service.MemberService;
import kh.pofo.service.MypageService;



@Controller
@RequestMapping("/mypage")
public class MypageController {
	

	@Autowired
	private MypageService mpService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired 
	private MemberService mService;


	@RequestMapping("/myInfo.mypage")
	public String myInfo(String id, Model model) {
		System.out.println("myinfo 도착");
		List<MemberDTO> list=mpService.myInfo(id);
		session.setAttribute("userInfo", list);
		System.out.println("광고수신여부 : "+list.get(0).getGet_ad());
		return "/mypage/myInfoView"; 
	}


	@RequestMapping("/updateMyInfo.mypage")
	public String updateMyInfoProc(Model model) {
		System.out.println("update my info도착확인");

		return "/mypage/updateMyInfoView"; 
	}



	@RequestMapping(value="/afterUpdateMyInfo.mypage", produces = "text/plain; charset=UTF8")
	public String afterUpdateMyInfo(MemberDTO dto, MultipartFile[] thumbnail) throws Exception {
		
		
		dto.setPassword(Encryption.getSHA256(dto.getPassword()));
		dto.setSns_code((String)session.getAttribute("sns_code"));
		System.out.println(dto.getGet_ad());
		if(dto.getGet_ad()==null) {
			System.out.println("null");
			dto.setGet_ad("N");
		}
		
		// [direct user용 myinfo update]================
		if(dto.getSns_code().contentEquals("02")&&thumbnail[0].getSize()!=0) {
			
			dto.setThumbnail_url(mService.upload(thumbnail));
			mpService.updateMyInfo(dto);
			
		}else if(dto.getSns_code().contentEquals("02")&&thumbnail[0].getSize()==0) {
			mpService.updateMyInfo(dto);
			
		}
		//[sns user용 myinfo update]================	
		else if(dto.getSns_code().contentEquals("01")&&thumbnail[0].getSize()==0) {
			mpService.updateMyInfoForSnsUser(dto);
		}
		
		return "redirect:/mypage/myInfo.mypage?id="+dto.getId();
	}

	@RequestMapping("/withdrawlProc.mypage")
	public String withdrawlProc() {
		System.out.println("회원탈퇴 도착 확인");
		return "/mypage/withdrawalView";
	}

	@RequestMapping(value="withdrawal.mypage", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String withdrawal(String id) {
		System.out.println("탈퇴 요청 확인");
		String result=mpService.withdrawal(id);
		session.invalidate();
		session.removeAttribute("id");
		System.out.println(result);
		return result;
	}


	@ExceptionHandler
	public String exceptionHandler(Exception e) {

		e.printStackTrace();

		return "error";
	}
}
