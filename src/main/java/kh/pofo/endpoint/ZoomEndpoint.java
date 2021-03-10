package kh.pofo.endpoint;



import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.scheduling.annotation.Async;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kh.pofo.dto.MemberDTO;

@ServerEndpoint(value = "/tutors", configurator = HttpSessionConfiurator.class)
public class ZoomEndpoint {
//5. server endpoint 과정에서 data 수신.
//    configurator class를 통해 handshaking 과정에 개입 가능.

	// 6. value의 중복을 허용치 않는 hashset으로 user의 중복 차단.
	// endpoint의 session이다.
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	private List<MemberDTO> userInfo = null;
	private String id = "비회원";
	// *비회원을 변수 선언. -> 로그인시 id값이 입력됨

	// ==============================================================================
	// 7. onOpen = user가 online일 때
	@OnOpen
	public void createMeeting(Session client, EndpointConfig endpointConfig) {
		System.out.println("create미팅 도착");
		// 7-1 접속 user들이 endpoint를 통해 url을 요청하면 메소드가 실행된다. ex/ tutor
		System.out.println(client.getId() + "님이 접속");
		// 7-2 접속 user의 객체(endpoint)를 set에 저장.
		clients.add(client);

		// 7-3 HttpSessionConfigurator 클래스(핸드쉐이킹을 수정하겠다는 class, 핸드쉐이킹 과정)로부터
		// serverEndpointRequest로 형변환했다. why? 핸드쉐이킹 과정에서 handshakeRequest는 사라지기에
		// 핸드쉐이킹 이후에도 존재하는 ServerEndpointCofig 객체에에 handshaking reqeust 객체가
		// HttpSession 형변환되어 저장되어있기에 이를 꺼내고 --> httpsession으로 형변환.
		HttpSession session = (HttpSession) endpointConfig.getUserProperties().get("h_session");
		userInfo = (List<MemberDTO>) session.getAttribute("userInfo");

	}

	// ==============================================================================
	// 8. onMessage == server에서 client들에게 보내는 내용

	@OnMessage
	public void getMeeting(Session session, String mtg) throws Exception {

		
		
		JsonObject obj = new JsonObject();
		// jsonobject는 server단이지만, server와 client의 중간 단계에 있는
		// endpoint로서의 역할이기에 component scan이 당연히 endpoint까지 scan을 돌지 않기에
		// autowired로 의존성 주입을 해줄수가 없어서 null이 발생된다.


		id = userInfo.get(0).getId();
		System.out.println("화상채팅 회원 아이디 :" + id);
		// *메세지를 보낸 회원을 위한 id용 변수
		String thumbnail_url = userInfo.get(0).getThumbnail_url();

		JsonParser parser=new JsonParser();
		JsonElement element=parser.parse(mtg);
		
		obj.addProperty("id", id);
		obj.addProperty("thumbnail_url", thumbnail_url);
		obj.addProperty("now", element.getAsJsonObject().get("date").toString().replaceAll("\"", ""));
		obj.addProperty("access", "true");

		synchronized (clients) {
			for (Session client : clients) {
				// *각 client 객체에 zoom meeting 게시글을 뿌리기 위한 for문

				// 현재의 websocket 통신을 요청한 client가 hashSet에 저장된
				// client와 같다면 메세지를 보내기 않기 위한 조건문
				if (session != client) {

					client.getBasicRemote().sendText(obj.toString());

				}
			}
		}

	}

	// ========== 3. onClose ========================================
	@OnClose
	public void onClose(Session session) throws Exception {

		JsonObject obj = new JsonObject();
		System.out.println("나간 회원 아이디" + id);
		
		if (id != "비회원") {
			// 화상채팅을 만든 회원의 게시글을 remove하기 위한 식별 값으로 id if문 분기점 생성
			obj.addProperty("id", id);
			obj.addProperty("access", "false");
		}

		clients.remove(session);
		// 접속자의 연결이 끊겼을 경우,
		// Hashset내에서 접속자의 instance를 session 공간에서 삭제하겠다는 의미.

		synchronized(clients) { 
			for(Session client:clients) {
				//*각 client 객체에 zoom meeting 게시글을 삭제하기 위한 for문
				if(session != client) {
					client.getBasicRemote().sendText(obj.toString());
				}
			} 
		}
		
	}

	@OnError
	public void handleError(Throwable t){

		t.printStackTrace();
	}

	
	@ExceptionHandler
	public String exceptionHandler(Exception e) {

		e.printStackTrace();

		return "error";
	}

	
	
}
