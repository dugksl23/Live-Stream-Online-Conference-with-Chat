package kh.pofo.service;

import java.io.IOException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import kh.pofo.dao.ZoomDAO;
import kh.pofo.dto.MemberDTO;


@Service
public class ZoomService {

	@Autowired
	private ZoomDAO zDAO;
	
	public String generateSignature(String apiKey, String meetingNumber, Integer role) {
		try {

			String apiSecret = "OG2F7NFlAuVok8NIjd9B0xub8YzuFEqPeL1l";

			Mac hasher = Mac.getInstance("HmacSHA256");
			String ts = Long.toString(System.currentTimeMillis() - 30000);
			String msg = String.format("%s%s%s%d", apiKey, meetingNumber, ts, role);

			hasher.init(new SecretKeySpec(apiSecret.getBytes(), "HmacSHA256"));

			String message = Base64.getEncoder().encodeToString(msg.getBytes());
			byte[] hash = hasher.doFinal(message.getBytes());

			String hashBase64Str = DatatypeConverter.printBase64Binary(hash);
			String tmpString = String.format("%s.%s.%s.%d.%s", apiKey, meetingNumber, ts, role, hashBase64Str);
			String encodedString = Base64.getEncoder().encodeToString(tmpString.getBytes());
			return encodedString.replaceAll("\\=+$", "");

		} catch (NoSuchAlgorithmException e) {
		} catch (InvalidKeyException e) {
		}
		return "";
	}
	
	
	public String createToken() {
		
		String API_Key="Xe3GR-3PR72qMsP_WS9Elw";
		String API_Secret="OG2F7NFlAuVok8NIjd9B0xub8YzuFEqPeL1l";
		
		//Header 부분 설정
		Map<String, Object> headers = new HashMap<>();
		headers.put("typ", "JWT");
		headers.put("alg", "HS256");
		// 헤더의 경우, 토큰 타입(typ),와 alg(암호화 알고리즘)이 포함되어야 한다.
		
		//payload 부분 설정
		Map<String, Object> payloads =new HashMap<>();
		
		Long expiredTime=1000*60L*60L*2L; // TOKEN 유효시간 1시간
		Date ext= new Date();
		ext.setTime(ext.getTime()+expiredTime);
		
		payloads.put("ext", ext);
		payloads.put("iss", API_Key);
		// 내용은 원하는(노출가능한) 데이터, 토큰 발급대상, 토큰 만료기간, 토큰 수령자 등등 여러 내용 담는다.
		
		
		 // 토큰 Builder
        String jwt = Jwts.builder()
                .setHeader(headers) // Headers 설정
                .setClaims(payloads) // Claims 설정
                .setSubject("user") // 토큰 용도 
                .setExpiration(ext) // 토큰 만료 시간 설정
                .signWith(SignatureAlgorithm.HS256, API_Secret.getBytes()) // HS256과 Key로 Sign
                .compact(); // 토큰 생성
		
		// 서명의 경우, jwts.builder()와 signwith() 메소드를 이용.
		//첫번째 매개변수로는 해시 알고리즘, 두번째로는 key의 bytesㅇ ㅣㅂ력
		// 그리고 토큰 생성을 위한 jwts.builder().compact() 호출.
		
		return jwt.toString();
	}
	
	public String retrieveDetailOf_theMeeting(String access_Token, String meetingNumber) throws IOException {
		
		OkHttpClient client = new OkHttpClient();

		Request request = new Request.Builder()
		  .url("https://api.zoom.us/v2/meetings/"+meetingNumber)
		  .get()
		  .addHeader("authorization", "Bearer "+ access_Token)
		  .build();

		final Response response = client.newCall(request).execute();
		String result=response.body().string();
		System.out.println(result);
		response.body().close();
		
		
		JsonParser parser=new JsonParser();
		JsonElement element=parser.parse(result);
		
		String join_Url=element.getAsJsonObject().get("join_url").toString();
		
		
		return join_Url;
	}
	
	
	
	//==============================================================================================================
	// ====  tutor detail db 저장  ==============================
	public int setTutors(String host_id) {
		
		int result=zDAO.setTutors(host_id);
		return result;
	}
	
	public List<MemberDTO> getTutors() {

		List<MemberDTO> tutors=zDAO.getTutors();

		return tutors;
	}
	
	// ==============================================================================================================
	// ==== tutor delete db 저장 ==============================
	public String deleteTutors(String host_id) {

		String msg="";	
		
		int result = zDAO.deleteTutors(host_id);
		if(result==1) {
			msg="삭제 완료";
		}
		return msg;
	}
	
	public List<MemberDTO> searchTutors(String host_id) {
		
		 List<MemberDTO> tutorsInfo = zDAO.searchTutors(host_id);
		   
		 return tutorsInfo;
	}
	
	

	
	
}
