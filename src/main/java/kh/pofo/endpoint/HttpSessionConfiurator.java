package kh.pofo.endpoint;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import org.springframework.beans.factory.annotation.Autowired;

public class HttpSessionConfiurator extends Configurator {
//*이 클래스는 웹소켓통신(핸드쉐이킹 과정에서 )httpsession을  웹소켓 session에 저장하겠다는 것.
	
	
	

	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		
		//1. HandShaking 과정 중, session에 저장된 값들을 
		//   handshakeRequest 객체를 통해 HttpSession에 저장.
		HttpSession session=(HttpSession)request.getHttpSession();
	
		//2. static처럼 어디서든 존재하는 ServerEndpointConfig sec을 통해
		//   HttpSession으로 형변환된 핸드쉐익 request 객체를 sec에 저장한다.
		//   why? hadns shaking 이후에 이 객체를 사라지기에, sec를 통해 
		//        serverendpointcongif 객체에 저장한다.
		
		
		//처음 접속할 때 handshake를 거치고 그 다음에는 동기식으로 바뀌기 때문에 
		//이 handshake할 때 Map에 다가 WebSocketSession으로 키로 설정해서 HttpSession을 넣고,
		//WebSocket안에서는 WebSocketSession키로 HttpSession를 가져와서 사용하면 됩니다.
		if(session!=null) {
			
			sec.getUserProperties().put("h_session", session);
		}else {
			//3. null이 취득되는 현상이 발생하기에, Request weblistner class 생성 
			sec.getUserProperties().put("h_session", session);
		}
		
		
	}
	
	
}
