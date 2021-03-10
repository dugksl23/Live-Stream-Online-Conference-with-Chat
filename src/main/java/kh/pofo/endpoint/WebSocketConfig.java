package kh.pofo.endpoint;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

@SuppressWarnings("deprecation")
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig<StompEndpointRegistery> extends AbstractWebSocketMessageBrokerConfigurer {
	
	// 2. registerStomptEndpoints는 해당 링크로 동작하는 엔드포인트와 SockJs를 만들어 등록하겠다는 의미.
	@Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat").setAllowedOrigins("*").withSockJS();
    }
	// ---> 엔드포인트를 url mapping을 만들어 등록하는 작업.	
// === <전체 흐름 : 2. 핸드쉐이킹 과정 개입을 위한 configurer 재정 및 endpoint 연결 >
	
	// 1. STOMP는 중간에 메세지 브로커 역할이기에 WebSocket messageBrokerConfigurer를 구현.
	//     * broker : 연결된 socket들의 세션관리를 해준다. 즉 subscriber를 구독한 채널에 연결시켜주고.
	//                sender가 그 채널에 메세지를 보내면, subscriber들에게 전달하는 중간 다리 역할.==(modify configurer+session의 흐름까지 관리)
	public void configureMessageBroker(MessageBrokerRegistry config) {
			
		config.enableSimpleBroker("/subscribe/chat");//== receive socket
		//*채팅방에 입장하여 해당 채팅창을 구독, 즉 참여하고 있는 채팅창에 오는 메세지를 실시간으로 볼 수 있도록 먼저 구독이 필수!
		
		config.setApplicationDestinationPrefixes("/publish");// sendSocket
		//* 참여하고 있는 채팅창에 글을 써서 해당하는 주소로 메세지를 전달.
	}
	
	
	// --> websocket에서  handshaking 과정에서 http session의 값을 넘기는 역할.
	//     즉, configureMessageBroker에서 이제 publish할 때, 사용할 url prefix와
	//     subsriber할 때 사용할 url prefix를 설정해주는 과정이다.
	//     ex) /subscriber 아래로 들어오는 url이 해당 메세지를 구독하는 사람의 url(메세지를 받을 사람)
	//         /publisher는 메세지를 뿌릴 때 사용하는 url = 메시지를 뿌리는 쪽.
	


}
