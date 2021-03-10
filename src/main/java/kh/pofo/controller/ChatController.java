
package kh.pofo.controller;


import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kh.pofo.dto.ChatDTO;
import kh.pofo.dto.ChatJoinRoomDTO;
import kh.pofo.dto.ChatRoomDTO;
import kh.pofo.dto.Chat_FriendsListDTO;
import kh.pofo.dto.MemberDTO;
import kh.pofo.service.ChatService;



@Controller
@RequestMapping("/chat")
public class ChatController {
    
	
    @Autowired
    private ChatService cService;
     
    @Autowired
    private HttpSession session;
    
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;
    
    
  
    @MessageMapping("/chat/user")
    public void subscribe_User(@PathVariable("user") String user_id, ChatJoinRoomDTO joinRoom, String join_url, SimpMessageHeaderAccessor headerAccessor, Principal principal, ChatRoomDTO room) {
        
    	JsonParser parser=new JsonParser(); 
		String sender_id=parser.parse(user_id).getAsJsonObject().get("sender_id").toString().replaceAll("\"", "");
		String receiver_id=parser.parse(user_id).getAsJsonObject().get("receiver_id").toString().replaceAll("\"", "");
		String room_id=parser.parse(user_id).getAsJsonObject().get("room_id").toString().replaceAll("\"", "");
		String sender_thumbnail_url=parser.parse(user_id).getAsJsonObject().get("sender_thumbnail_url").toString().replaceAll("\"", "");
		
		if(cService.findRoom_idBy(sender_id, receiver_id)==0) {
			joinRoom.setRoom_id(room_id);
			joinRoom.setJoin_id(UUID.randomUUID().toString().replaceAll("-", ""));
			
			joinRoom.setUser_id(sender_id);
			cService.userJoin_Room(joinRoom);
				
			joinRoom.setUser_id(receiver_id);
			cService.userJoin_Room(joinRoom); 
			cService.createChatRoom(room_id);
		}
		
		JsonObject obj=new JsonObject();
		obj.addProperty("sender_id", sender_id);
		obj.addProperty("room_id", room_id);
		obj.addProperty("sender_thumbnail_url", sender_thumbnail_url);
		obj.addProperty("receiver_id", receiver_id);
		
		
		simpMessagingTemplate.convertAndSend("/subscribe/chat/user/"+receiver_id, obj.toString());
    }
    
    @MessageMapping("/chat/room")
    @Async
    public void sendChatMessage(@PathVariable("chatMessage") String chatMessage, ChatDTO chat, SimpMessageHeaderAccessor headerAccessor, Principal principal, ChatRoomDTO room) {
        
           int result=cService.saveChatMessage(chat);
    	   
           JsonParser parser=new JsonParser();
 		   JsonElement element=parser.parse(chatMessage);
 		   String receiver_id=element.getAsJsonObject().get("receiver_id").toString().replace("\"", "");
     	   
 		   //== room은 메세지를 보낸시점을 기준으로 한다. 하지만 받는 이는 메세지를 받을 수 없기에
 		   //   내가 메세지를 보냄과 동시에 입장하게끔 하는 로직을 생성.
    	   if(cService.findChatMessage(chat.getRoom_id(), receiver_id)==0) {
    		  
     		   chat.setChat_content(receiver_id+"님이 입장하셨습니다.");
     		   chat.setUser_id(receiver_id);
     		   
    		   cService.saveChatMessage(chat);
         	
    	   }
    	  JsonObject obj=new JsonObject();
    	   obj.addProperty("chatMessage", chatMessage.toString());
    	   
    	   simpMessagingTemplate.convertAndSend("/subscribe/chat/room/"+chat.getRoom_id(), obj.toString());
    }
    
    
    @RequestMapping("/chatting.chat")
    public String chatting(String room_id, String receiver_thumbnail_url, String receiver_id, Chat_FriendsListDTO dto, Model m) {
    	
    	//1. chatList.jsp에서 채팅 대상과의 정보를 취득하여 저장.
    	m.addAttribute("receiver_id", receiver_id);
    	m.addAttribute("room_id", room_id);
    	m.addAttribute("receiver_thumbnail_url", receiver_thumbnail_url);
    	System.out.println("receiver id :"+receiver_id);

    	//2. 채팅 메세지를 받은 user의 새로운 친구 추가 기능.
    	//   sender와 receiver의 입장이 반대가 되어 친구리스트 테이블에 추가한다.
    	if(cService.checkRegFriends(receiver_id, (String)session.getAttribute("id"))==0) {
    		dto.setUser_id(receiver_id);
    		dto.setFriends_id((String)session.getAttribute("id"));
    		cService.addFriends(dto);
    	}
    	
    	//2. 채팅방의 참가 인원
    	int numberOfperson=cService.countNumberOfperson(room_id);
    	m.addAttribute("numberOfperson", numberOfperson);

    	//3. 채팅방의 chat History == 기본 location은 1을 기본으로 한다.
    	List<ChatDTO> chatHistory=cService.getChatMessageHistory(room_id);

    	m.addAttribute("chatHistory",chatHistory);
    	m.addAttribute("cRowNum", chatHistory.size());

    	//=============================================================================
    	//============== zoom과 관련된 채팅 로직 =============================================
    	// 1. joinMeeting.jsp로 이동했을 경우, 주최자(tutor)의 id를 취득하여
    	//     session에 저장하여, zoonController에서의  joinMeeting.jsp와 순서의 차이를 두면서 
    	//     주최자와 참가자의 id값을 통일시킨다.
    	if((String)session.getAttribute("organizer")==null) {
    		System.out.println("organizer은?"+(String)session.getAttribute("organizer"));
    		System.out.println("tutor_id는?"+receiver_id);
        	session.setAttribute("organizer", receiver_id); 
        }
    	
    	return "/chat/chatting";
    }

 
    
    @RequestMapping("/addFriends.chat")
    @ResponseBody
    public String addFriends(Chat_FriendsListDTO dto) {
    	
    	int result=cService.addFriends(dto);
    	
    	return "added";
    }
    
    //===============================================================================================
    //====== [ 친구 목록 불러오기 select ] =====================================================================
    @RequestMapping("/friendsList.chat")  
    public String friendsList(Model m, Integer friendsCount) {

    	//비동기로 계속 늘어나기 때문에. if문을 통해서 존재여부 확인해서 있으면 return false하는 구문 추가하기.
    	if((String)session.getAttribute("id")!=null) {
    		
    		int current_FriendsCount = cService.friendsCount((String)session.getAttribute("id"));
    		m.addAttribute("current_FriendsCount", current_FriendsCount);
    		System.out.println("current Count?"+current_FriendsCount);

    		// ==== 1. 나의 친구리스트가 같다라는 전제를 base로 둔다.
    		List<ConcurrentHashMap<String, Object>> friendsList=cService.friendsList((String)session.getAttribute("id")); //친추된 친구의 수가 4일 경우
    		m.addAttribute("friendsList", friendsList);
    		
    		//=== 2. 타인이 나를 친추했는지 여부 확인================	
    		//       상대방의 친추후, 채팅을 보내서 새로운 친구추가 기능을 위한 로직
    		// ===  새로 친구 추가된 user를 확인하기 위한 if문 분기점 ===
			/*
			 * if(friendsCount<current_FriendsCount) {
			 * System.out.println("현재 기존 친구 수보다 많아요!"); //1. 최신 조회 결과의 size가 클 경우, 기존 사이즈의
			 * ROWNUM 이후부터 최신 추가된 친구들의 list를 불러온다. List<Map<String, Object>>
			 * newFriendsList=cService.findNewFriendsList((String)session.getAttribute("id")
			 * , current_FriendsCount);
			 * System.out.println("current_FriendsCount :"+current_FriendsCount);
			 * 
			 * //* 2021.03.05 java.util.ConcurrentModificationException error // 에러 이유 :
			 * list의 index를 참조하여 2중 foreach가 돌고 있기에. 2중 for문의 index를 건드리지 않고 안전하게 삭제하기 위해서는
			 * // 해결책 : ConcurrentHashMap (동기화처리를 지원함.) for(Map<String, Object>
			 * i:friendsList) { for(Map<String, Object> j:newFriendsList) {
			 * 
			 * if(i.get("friends_id")==j.get("friends_id")) { i.remove("user_id");
			 * i.remove("room_id"); i.remove("thumbnail_url"); i.remove("join_id"); } } }
			 * 
			 * m.addAttribute("friendsList", friendsList);// 기존 친구 list
			 * m.addAttribute("newFriendsList", newFriendsList);// 친추된 친구list }
			 */
    		System.out.println("최종적은 친구의 수는?"+current_FriendsCount);
    		session.setAttribute("current_FriendsCount", current_FriendsCount);

    	}


    	return "/chat/friendsList";

    }


  
  @RequestMapping("/chatList.chat")  
  public String chatList( Model m) {
	  
	  List<Map<String, Object>> joinUserList=cService.joinUserList((String)session.getAttribute("id"), "");
	  m.addAttribute("joinUserList", joinUserList);
	  
	  List<ChatDTO> chatUserList=cService.chatUserList((String)session.getAttribute("id"));//keyword 용 null
	  m.addAttribute("chatUserList", chatUserList);
	  
	  List<ChatDTO> newMessageCount=cService.newMessageCount((String)session.getAttribute("id"));
	  
	  m.addAttribute("newMessageCount", newMessageCount);
	  
	  //4. multichat용도의 동기화 로직
	  List<Map<String, Object>> multiChatList=cService.getMultiChat((String)session.getAttribute("id"));
	  m.addAttribute("multiChatList",multiChatList);
	  m.addAttribute("multiChatList_count",multiChatList.size());
	  
	  
	return "/chat/chatList";
	
  }
  
  @RequestMapping(value="/searchFriends.chat", method=RequestMethod.GET)
  @ResponseBody
  public String searchFriends(String receiver_id, ChatJoinRoomDTO joinRoom, Chat_FriendsListDTO cf) {
	  
	  JsonObject obj=new JsonObject();
	
	  int result=cService.checkRegFriends((String)session.getAttribute("id"), receiver_id);
	  System.out.println("현재의 친구는 등록여부는?"+result);
	  obj.addProperty("result", result);
	  //2. 친구가 없다면 추가/ 있다면 pass

	  if(result==0) {
		
		  List<MemberDTO> friends=cService.searchFriends(receiver_id);
		  obj.addProperty("friends", "notAdded");
		  obj.addProperty("addFriends", new Gson().toJson(friends).toString());
		  
		  String room_id=UUID.randomUUID().toString().replaceAll("-", "");
		  String join_id=UUID.randomUUID().toString().replaceAll("-", "");
		
		  joinRoom.setJoin_id(join_id);
		  joinRoom.setRoom_id(room_id);
		  joinRoom.setUser_id((String)session.getAttribute("id"));
		  cService.userJoin_Room(joinRoom);
		  joinRoom.setUser_id(receiver_id);
		  cService.userJoin_Room(joinRoom);
		  cService.createChatRoom(room_id);
		  
		  //3. 친추 및 채팅 메세지를 받은 user의 새로운 친구 추가 기능.
		  //   sender와 receiver의 입장이 반대가 되어 친구리스트 테이블에 추가한다.
		  cf.setUser_id(receiver_id);
		  cf.setFriends_id((String)session.getAttribute("id"));
		  cService.addFriends(cf);
		  
		  //4. 친구의 수를 조회하기.
		  obj.addProperty("frinedsCount", cService.friendsCount((String)session.getAttribute("id")));
		  
		}
	  
	  return obj.toString();
  }

  
  
  	@RequestMapping("/findRoom_idBy")
  	@ResponseBody
  	public String findRoom_idBy(String receiver_id) {
  		
  	  String room_id="alreadyCreated";
	  if(cService.findRoom_idBy((String)session.getAttribute("id"), receiver_id)==1) {
			 room_id=cService.getRoom_id((String)session.getAttribute("id"), receiver_id);
			 System.out.println("search 친구 에서의 room_id 존재여부:"+room_id);
	  }
	
	 return room_id;
	
  	}
  	
  	@RequestMapping(value="/searhRoom.chat")
  	@ResponseBody
  	public String searhTheSortOfRoom(String keyword) {

  		List<Map<String, Object>> joinUserList=cService.joinUserList((String)session.getAttribute("id"), keyword);

  		List<ChatDTO> chatUserList=cService.chatUserList((String)session.getAttribute("id"));

  		JsonObject obj=new JsonObject();
  		obj.addProperty("joinUserList", new Gson().toJson(joinUserList).toString());
  		obj.addProperty("chatUserList", new Gson().toJson(chatUserList).toString());


  		return obj.toString();

  	}
  
  	@RequestMapping("/update_ChatMessage_History.chat")
  	@ResponseBody
  	public String update_ChatMessage_History(String room_id, int cRowNum) {
		
  		List<ChatDTO> chatHistory=cService.update_ChatMessage_History(room_id, cRowNum);
  		int updated_cRowNum=chatHistory.get(chatHistory.size()-1).getRownumber();
  		
  		JsonObject obj=new JsonObject();
  		if(cRowNum<updated_cRowNum) {
  			obj.addProperty("chatHistory", new Gson().toJson(chatHistory).toString());
  	  		obj.addProperty("cRowNum", chatHistory.get(chatHistory.size()-1).getRownumber());
  	  		obj.addProperty("isUpdated", "Updated");
	  	}else {
  	  		obj.addProperty("isUpdated", "nothingUpdated");
	  	}
  		return obj.toString();
  		
  	}  	
  	
  	
  	@RequestMapping("/addChatRoom.chat")
	public String addChatRoom(Model model) {
		
  		List<ConcurrentHashMap<String, Object>> friendsList=cService.friendsList((String)session.getAttribute("id")); //친추된 친구의 수가 4일 경우
		model.addAttribute("friendsList",friendsList);
  		
		
		return "/chat/addChat";
	}

  	@RequestMapping(value="/inviteFriends.chat", method=RequestMethod.POST)
  	@ResponseBody
  	public String inviteFriends(@ModelAttribute("chatJoinRoomDTO") ChatJoinRoomDTO mRoom, Model m) {
  		
  		session.setAttribute("room_id", mRoom.getRoom_id());
  		session.setAttribute("receiver_id", mRoom.getUser_id());
  		cService.userJoin_Room(mRoom);
  		
  		return "/chat/multiChatting.chat?room_id="+mRoom.getRoom_id()+"&join_id="+mRoom.getJoin_id();
  	}
	
  	
  	@RequestMapping("/multiChatting.chat")
  	public String multiChatting(String room_id, String join_id, ChatJoinRoomDTO cjr, Model m) {
  		
  		System.out.println("룸 아이디는?"+room_id);
  		m.addAttribute("room_id",room_id);  
  		
  		return "/chat/multiChatting";
  	}

    @MessageMapping("/chat/multi_room")
    @Async
    public void sendChatMessageAtMultiChat(@PathVariable("chatMessage") String chatMessage, ChatDTO chat, SimpMessageHeaderAccessor headerAccessor, Principal principal, ChatRoomDTO room) {
        
           int result=cService.saveChatMessage(chat);
    	   
           JsonParser parser=new JsonParser();
 		   JsonElement element=parser.parse(chatMessage);
 		   String receiver_id=element.getAsJsonObject().get("receiver_id").toString().replace("\"", "");
     	   
 		   
    	   JsonObject obj=new JsonObject();
    	   obj.addProperty("chatMessage", chatMessage.toString());
    	   
    	   simpMessagingTemplate.convertAndSend("/subscribe/chat/multi_room/"+chat.getRoom_id(), obj.toString());
    }
    
    
    @RequestMapping("/deleteRoom.chat")
    public String deleteRoom(String room_id) {
    	cService.deleteRoom(room_id, (String)session.getAttribute("id"));
    	return "deleted";
    }
    
    
    
    
} 
