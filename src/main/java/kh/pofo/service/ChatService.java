package kh.pofo.service;



import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.pofo.dao.ChatDAO;
import kh.pofo.dto.ChatDTO;
import kh.pofo.dto.ChatJoinRoomDTO;
import kh.pofo.dto.ChatRoomDTO;
import kh.pofo.dto.Chat_FriendsListDTO;
import kh.pofo.dto.MemberDTO;

@Service
public class ChatService {

	@Autowired
	private ChatDAO cDAO;

	public int createChatRoom(String room_id) {

		int result=cDAO.createChatRoom(room_id);
		return result;
	}


	public int findRoom_idBy(String sender_id,String receiver_id) {

		int result=cDAO.findRoom_idBy(sender_id, receiver_id);

		return result;
	}

	public String getRoom_id(String sender_id,String receiver_id) {

		ChatRoomDTO room=cDAO.getRoom_id(sender_id, receiver_id);

		return room.getRoom_id();
	}

	public int addFriends(Chat_FriendsListDTO dto) {

		int result=cDAO.addFriends(dto);

		return result;
	}




	public List<ConcurrentHashMap<String, Object>> friendsList(String user_id) {

		List<ConcurrentHashMap<String, Object>> list=cDAO.friendsList(user_id);

		return list;

	}

	public List<Map<String, Object>> findNewFriendsList(String user_id, int startRowNum) {

		List<Map<String, Object>> newFriendsList=cDAO.findNewFriendsList(user_id, startRowNum);

		return  newFriendsList;

	}

	public int friendsCount(String id) {
		int result=cDAO.friendsCount(id);
		return result;
	}

	public int userJoin_Room(ChatJoinRoomDTO joinRoom) {

		int result=cDAO.userJoin_Room(joinRoom);
		return result;
	}



	public List<MemberDTO> searchFriends(String id) {

		List<MemberDTO> friends=cDAO.searchFriends(id);

		return friends;
	}

	public int findChatMessage(String room_id, String receiver_id) {

		int result=cDAO.findChatMessage(room_id, receiver_id);

		return result;
	}


	public int checkRegFriends(String id, String friends_id) {

		int result=cDAO.checkRegFriends(id, friends_id);
		return result;
	}



	public List<Map<String, Object>> joinUserList(String id, String keyword) {

		List<Map<String, Object>> joinUserList=cDAO.joinUserList(id, keyword);

		return joinUserList;
	}

	public List<ChatDTO> chatUserList(String id) {

		List<ChatDTO> chatUserList=cDAO.chatUserList(id);

		return chatUserList;
	}


	public int saveChatMessage(ChatDTO chat) {

		int result=cDAO.saveChatMessage(chat);
		return result;
	}

	public List<ChatDTO> getChatMessageHistory(String room_id){

		List<ChatDTO> chatHistory=cDAO.getChatMessageHistory(room_id);
		Collections.reverse(chatHistory);

		return chatHistory;
	}

	public List<ChatDTO> update_ChatMessage_History(String room_id, int cRowNum) {

		List<ChatDTO> chatHistory=cDAO.update_ChatMessage_History(room_id, cRowNum);

		return chatHistory;

	}  

	public int countNumberOfperson(String room_id) {

		int numberOfperson=cDAO.countNumberOfperson(room_id);
		return numberOfperson;
	}


	public List<Map<String, Object>> searhTheSortOfRoom(String keyword,String id) {

		List<Map<String, Object>> list=cDAO.searhTheSortOfRoom(keyword, id);
		return list;
	}


	public int totalMessageCount(String id) {

		int totalMessageCount=cDAO.totalMessageCount(id);
		return totalMessageCount;
	}

	public List<ChatDTO> newMessageCount(String id) {

		List<ChatDTO> newMessageCount=cDAO.newMessageCount(id);
		return newMessageCount;
	}
	
	public int isRoom_id(String room_id) {
		int result=cDAO.isRoom_id(room_id);
		return result;
	}


	public List<Map<String, Object>> getMultiChat(String id) {
		
		List<Map<String, Object>> multiChatList=cDAO.getMultiChat(id);
		
		return multiChatList;
	}
	
    public int deleteRoom(String room_id, String id) {
    	int result=cDAO.deleteRoom(room_id, id);
    	return result;
    }
    

}
