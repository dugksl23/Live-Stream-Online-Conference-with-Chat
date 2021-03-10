package kh.pofo.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import encryption.Encryption;
import kh.pofo.dao.MemberDAO;
import kh.pofo.dao.MypageDAO;
import kh.pofo.dto.MemberDTO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO mDao;

	@Autowired
	private HttpSession session;

	//---------------------------------------------------------------------------------------------------------------김요한
	public void saveUserInfo(String id, String email,String name, String thumbnail) {

		if(!(mDao.checkId(id)==1)) {
			mDao.saveKakaoUserInfo(id, email, name, thumbnail);
		}else if(mDao.checkId(id)==1) {
			mDao.updateKakaoUserInfo(id, email, name, thumbnail);
		}
	}



	public String getAccessToken (String authorize_code)  {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";


		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			//    POST 요청을 위해 기본값이 false인 setDoOutput을 true로

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			//    POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=2e74016a55faeab59754ac119822f522");  //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost/member/kakaologin");     // 본인이 설정해 놓은 경로
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			//    결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			//    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			//    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			//현 버젼에서는 아직 사용가능하지만 후 버젼에서는 사라져 있을수도 있다 라는정도의 의미인걸로 알고있어요
			//물론 후 버젼에서는 개선된 기능으로 메소드 이름 변경되어 나오겠죠

			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			//br.close();
			//bw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("getaccess_token:"+access_Token);
		return access_Token;
		//access token) : 인증 후에 사용자가 서비스 제공자가 아닌 소비자를 통해서 보호된 자원에 접근하기 위한 키를 포함한 값.
		/*
		 * 소비자가 서비스제공자에게 요청토큰을 요청한다. 
		 * 서비스제공자가 소비자에게 요청토큰을 발급해준다. 
		 * 소비자가 사용자를 서비스제공자로 이동시킨다.
		 * 여기서 사용자 인증이 수행된다. 
		 * 서비스제공자가 사용자를 소비자로 이동시킨다. 
		 * 소비자가 접근토큰을 요청한다. 
		 * 서비스제공자가 접근토큰 발급한다. 
		 * 발급된 접근토큰을 이용하여 소비자에서 사용자 정보에 접근한다.
		 */
	}


	//3. 로그아웃
	public void kakaoLogout(String access_Token) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		try {

			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			System.out.println("response message : "+conn.getResponseMessage());
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String result = "";
			String line = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println(result);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}



	/*https://antdev.tistory.com/37#recentComments*/

	public HashMap<String, Object> getUserInfo (String access_Token) throws Exception{

		//1. 요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap 타입으로 선언!
		HashMap<String, Object> userInfo=new HashMap<>();
		System.out.println("user info의 accessToken :"+access_Token);
		//2. 하기의 url로 request하여, userInfo의 정보를 가져올 것이기에
		//   URL을 객체를 통해 하기의 url을 담는다.
		String requestURL="https://kapi.kakao.com/v2/user/me";
		URL url=new URL(requestURL);

		//3. connection 객체 선언
		//Java 에서 HTTP로 데이터를 송, 수신하기 위해서는
		//HttpURLConnection 클래스를 이용한다.
		HttpURLConnection conn=(HttpURLConnection) url.openConnection();

		// 4. POST 요청을 위해 기본값이 false인 setDoOutput을 true로
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		
		//4. host server에 request에 필요한 KEY값을 셋팅한다.
		conn.setRequestProperty("Authorization", "Bearer " + access_Token);
		conn.setRequestProperty("charset", "utf-8");


		// 5.카카오 서버로부터 userInfo에 대한 response가 true일 시 200 아니면 400
		int responseCode=conn.getResponseCode();
		System.out.println("responseCode : " + responseCode);


		System.out.println("response message : "+conn.getResponseMessage());
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line;
		String result = "";

		//버퍼에 있는 정보를 하나의 문자열로 변환.
		while ((line = br.readLine()) != null) {
			result += line;
		}
		
		JsonElement element = JsonParser.parseString(result);
	    System.out.println(element);
	    String id=element.getAsJsonObject().get("id").getAsString();
	    String nickname=element.getAsJsonObject().get("properties").getAsJsonObject().get("nickname").getAsString();
	    String email=element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
	 	String thumbnail=element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("profile").getAsJsonObject().get("thumbnail_image_url").getAsString();
		
	 	userInfo.put("id", id);
		userInfo.put("name", nickname);
		userInfo.put("email", email);
		userInfo.put("thumbnail", thumbnail);
		
		//URLConnection에 대한 doOutput 필드값을 지정된 값으로 설정한다. 
		//URL 연결은 입출력에 사용될 수 있다.
		//URL 연결을 출력용으로 사용하려는 경우 DoOutput 플래그를 true로 설정하고, 그렇지 않은 경우는 false로 설정해야 한다. 기본값은 false이다.
		return userInfo;
	}

	public int signin(MemberDTO dto) {
		
		String password=Encryption.getSHA256(dto.getPassword());
		dto.setPassword(password);
		int result=mDao.signin(dto);
		
		return result;
	}

	public List<MemberDTO> snsUserInfo(String id) {

		List<MemberDTO> snsUserInfo=mDao.snsUserInfo(id);
		return snsUserInfo;
	}

	public int signup(MemberDTO dto) throws Exception {
		System.out.println("service단에서의 dto");
		String password=Encryption.getSHA256(dto.getPassword());
		dto.setPassword(password);
		
		int result=mDao.signup(dto);
		return result;
	}

	public String checkId(String id) {
		System.out.println("service 단에서의 id : "+id);
		int result=mDao.checkId(id);
		String msg=null;
		if(result==1) {
			return msg="이미 사용중인 ID입니다.";
		}else {
			return msg="사용 가능한 ID입니다.";
		}
	}




	public String sendEmail(MemberDTO dto, String div) throws EmailException {
		
		//1. mail server 설정
		String charset ="utf-8";
		String hostSMTP="smtp.naver.com";
		//naver : smtp.naver.com
		//gmail : smtp.gmail.com
		String hostSMTPid="dugksl23@naver.com"; // 서버 이메일 주소(보내는 사람 주소)
		String hostSMTPpw="Cjqjdugks12!@";
		
		//보내는 사람 email 및 제목, 내용
		String fromEmail=hostSMTPid; //받는이의 이메일에 표시될 보내는 사람의 email.
		String fromName="Learning English"; //보내는 이의 서버 이름
		String subject="";
		String msg="";
		
		if(div.equals("findPw")) {
			subject = "Learning English의 임시 비밀번호 입니다.";
			msg +="<div align='center' style='border:1px solid black; font-family:verdana;'>";
			msg +="<h3 style='color:blue;'>";
			msg +=dto.getId()+"님의 임시 비밀번호 입니다. 로그인 후에 비밀번호를 변경하여 주십시오.</h3>";
			msg +="<p>임시 비밀번호 : ";
			msg +=dto.getPassword()+"</p></div>";
			
		}else if(div.contentEquals("findId")){
			subject = "Learning English의 ID 입니다.";
			msg +="<div align='center' style='border:1px solid black; font-family:verdana;'>";
			msg +="<h3 style='color:blue;'>";
			msg +=dto.getName()+"님의 아이디 입니다.</h3>";
			msg +="<p>아이디 : ";
			msg +=dto.getId()+"</p></div>";
		}
		
		
		// 받는 사람 e-mail 주소
		String email=dto.getEmail();
		
		HtmlEmail hEmail=new HtmlEmail();
		hEmail.setDebug(true);
		hEmail.setCharset(charset);
		hEmail.setSSL(true);
		hEmail.setHostName(hostSMTP);
		hEmail.setSmtpPort(587);//NAVER 이용시에는 587
		
		hEmail.setAuthentication(hostSMTPid, hostSMTPpw);
		hEmail.setTLS(true);
		hEmail.addTo(email, dto.getName());//받는이 Email
		hEmail.setFrom(fromEmail, fromName, charset);
		hEmail.setSubject(subject);
		hEmail.setHtmlMsg(msg);
		hEmail.send();
		msg="등록된 계정의 E-mail로 전송되었습니다.";
		
		return msg;
	}
	
	
	
	// ==============================================
	//[비밀번호 찾기] ================================
		
	public String findPw(MemberDTO dto) throws EmailException {
		
		String msg="";
		if(mDao.findPw(dto.getId(),dto.getEmail())==1) {
			//임시비밀번호 생성 및 메일에 보낼 암호 
			String tempPw=UUID.randomUUID().toString().replaceAll("-", "");
			dto.setPassword(tempPw);
			System.out.println("임시비밀번호"+tempPw);
			
			// db에 임시비밀번호의 암호도된 번호를 setting
			String pw=Encryption.getSHA256(tempPw);
			System.out.println("암호화된 임시 비밀번호 :"+pw);
			int result=mDao.updatePw(dto.getId(), pw);
			
			// db의 결과
			System.out.println("수정 결과"+result);
			
			//비밀번호 변경 메일 발송
			msg=sendEmail(dto,"findPw");//sendEmail 메소드 호출
			System.out.println(msg);
		}else {
			msg="ID 또는 Email 정보가 일치하지 않습니다.";
		}
	
		return msg;
	}
	
	// ==============================================
	//[id 찾기] ================================
	
	public String findId(MemberDTO dto) throws EmailException {
		System.out.println(dto.getName()+dto.getEmail());
		String msg="";
		int result=mDao.existId(dto.getName(),dto.getEmail());
		if(result!=0) {
			
			dto.setId(mDao.findId(dto.getName(), dto.getEmail()));
			msg=sendEmail(dto,"findId");//sendEmail 메소드 호출
			System.out.println(msg);
		}else {
			msg="등록된 이름 또는 Email 정보가 일치하지 않습니다."+
				"확인 후 다시 이용해주세요.";
		}
	
		return msg;
	}
	
	
	// ======================================================
	// [thumbnail upload 및 다운로드] ===========================
	
	public String upload(MultipartFile[] upload) throws Exception{
	//1. file tag의 name 값과 server단의 mapping된  함수의
	//	 MultipartFile자료형의 매개변수명을 일치.
	System.out.println(upload[0].getOriginalFilename());	
	//2. server(tomcat)에 업로드 파일이 저장되는 경로를 문자열로 저장.
	String realPath=session.getServletContext().getRealPath("thumbnail");
	
	//3. 해당 경로를 가진 문자열(String)을 file 자료형으로 객체화한다.
	File filesPath=new File(realPath);
	
	//4. 해당 경로에 folder가 생성되어있는지 여부 확인을 위한 if문.
	if(!filesPath.exists()) {
		filesPath.mkdir();
		//해당경로에 임시 folder를 생성하는 메소드	
	}
	
	//5. originalName획득 및 savedName 생성 
	String save_Name=UUID.randomUUID().toString().replaceAll("-", "")+upload[0].getOriginalFilename();
	
	//6. upload된 파일을 server단에 저장
	//6-1. server단의 저장경로 + 업로드될 targetFile의 경로를 
	//     File 자료형으로 객체화.
	
	//7. 해당 file이 존재한다면 삭제.
	File targetFile=new File(filesPath.getAbsolutePath()+"/"+save_Name);
	if(targetFile.exists()) {
		targetFile.delete();
	}
	
	//7. targetFile을 server단 저장경로에 copy.
	FileCopyUtils.copy(upload[0].getBytes(), targetFile);
	//첫번째 인자 : 복사할 데이터의 크기
	//두번째 인자 : 저장할 file의 경로에 data 복사
	
	return "/"+filesPath.getName()+"/"+save_Name+"";
	}
	
	
	

}
