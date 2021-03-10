package kh.pofo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.Gson;

import kh.pofo.dto.ChatDTO;
import kh.pofo.dto.ChatJoinRoomDTO;
import kh.pofo.dto.ChatRoomDTO;
import kh.pofo.dto.Chat_FriendsListDTO;
import kh.pofo.dto.MemberDTO;

@Repository
public class ChatDAO {

	@Autowired
	private SqlSession db;

	public int createChatRoom(String room_id) {

		int result=db.insert("Chat.createChatRoom", room_id);

		return result;
	}

	public int findRoom_idBy(String sender_id,String receiver_id) {

		Map<String, Object> param=new HashMap<>();
		param.put("sender_id", sender_id);
		param.put("receiver_id", receiver_id);
		System.out.println(sender_id);
		System.out.println(receiver_id);
		int result=db.selectOne("Chat.findRoomByRoom_id", param);

		return result;
	}

	public ChatRoomDTO getRoom_id(String sender_id,String receiver_id) {

		Map<String, Object> param=new HashMap<>();
		param.put("sender_id", sender_id);
		param.put("receiver_id", receiver_id);

		System.out.println(sender_id);
		System.out.println(receiver_id);

		ChatRoomDTO room=db.selectOne("Chat.getRoom_id", param);

		return room;
	}


	public int addFriends(Chat_FriendsListDTO dto) {

		int result=db.insert("Chat.addFriends", dto);

		return result;
	}

	public List<Map<String, Object>> friendsList(String user_id) {

		List<Map<String, Object>> list=db.selectList("Chat.friendsList", user_id);

		return list;

	}

	public List<Map<String, Object>> findNewFriendsList(String user_id, int startRowNum) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("user_id", user_id);
		param.put("startRowNum", startRowNum);
		
		List<Map<String, Object>> newFriendsList=db.selectList("Chat.findNewFriendsList", param);
			
		return  newFriendsList;
			
	}

	
	public int friendsCount(String id) {
		int result=db.selectOne("Chat.friendsCount", id);
		return result;
	}


	public int userJoin_Room(ChatJoinRoomDTO joinRoom) {

		int result=db.insert("Chat.userJoin_Room", joinRoom);
		return result;
	}

	public List<MemberDTO> searchFriends(String id) {

		Gson gson=new Gson();
		List<MemberDTO> friends=db.selectList("Chat.searchFriends",id);

		return friends;
	}

	public int findChatMessage(String room_id, String receiver_id) {

		Map<String, Object> param=new HashMap<>();
		param.put("room_id", room_id);
		param.put("receiver_id", receiver_id);
		int result=db.selectOne("findChatMessage", param);

		return result;
	}

	public int checkRegFriends(String id, String friends_id) {

		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("friends_id", friends_id);
		int result=db.selectOne("Chat.checkRegFriends",param);

		return result;
	}

	public List<Map<String, Object>> joinUserList(String id, String keyword) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("keyword", keyword);
		List<Map<String, Object>> joinUserList=db.selectList("Chat.joinUserList", param);

		return joinUserList;
	}

	public List<ChatDTO> chatUserList(String id) {

		List<ChatDTO> chatUserList=db.selectList("chatUserList", id);

		return chatUserList;
	}


	public int saveChatMessage(ChatDTO chat) {

		int result=db.insert("Chat.saveChatMessage",chat);

		return result;
	}

	public List<ChatDTO> getChatMessageHistory(String room_id){

		List<ChatDTO> chatHistory=db.selectList("Chat.getChatMessageHistory", room_id);
		return chatHistory;
	}

	public List<ChatDTO> update_ChatMessage_History(String room_id, int cRowNum) {

		int startRowNum=cRowNum;
		int endRowNum=startRowNum+99;

		Map<String, Object> param=new HashMap<>();
		param.put("room_id", room_id);
		param.put("startRowNum", startRowNum);
		param.put("endRowNum", endRowNum);

		List<ChatDTO> chatHistory=db.selectList("Chat.update_ChatMessage_History", param);

		return chatHistory;

	}  

	public int countNumberOfperson(String room_id) {

		int numberOfperson=db.selectOne("Chat.countNumberOfperson", room_id);
		return numberOfperson;
	}


	public List<Map<String, Object>> searhTheSortOfRoom(String keyword, String id) {

		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("keyword", keyword);

		List<Map<String, Object>> list=db.selectList("Chat.searchTheSortOfRoom",param);
		return list;

	}

	public int totalMessageCount(String id) {

		int totalMessageCount=db.selectOne("Chat.totalMessageCount", id);
		return totalMessageCount;
	}

	public List<ChatDTO> newMessageCount(String id) {

		List<ChatDTO> newMessageCount=db.selectList("Chat.newMessageCount", id);
		return newMessageCount; 
	}
	
	public int isRoom_id(String room_id) {
		int result=db.selectOne("Chat.isRoom_id",room_id);
		return result;
	}
	
	public List<Map<String, Object>> getMultiChat(String id) {
		
		List<Map<String, Object>> multiChatList=db.selectList("Chat.multiChat",id);
		
		return multiChatList;
	}
	
    public int deleteRoom(String room_id, String id) {
    	
		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("room_id", room_id);

    	int result=db.delete("Chat.deleteRoom", param);
    	return result;
    }
    

}
