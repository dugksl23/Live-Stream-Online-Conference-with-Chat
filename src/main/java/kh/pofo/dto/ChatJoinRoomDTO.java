package kh.pofo.dto;

import java.util.List;

public class ChatJoinRoomDTO {

	
	private String join_id;
	private String user_id;
	private String room_id;
	private List<ChatJoinRoomDTO> ChatJoinRoomDTO; //본인 자신을 참조한다.
	
	
	
	
	public List<ChatJoinRoomDTO> getChatJoinRoomDTO() {
		return ChatJoinRoomDTO;
	}




	public void setChatJoinRoomDTO(List<ChatJoinRoomDTO> chatJoinRoomDTO) {
		ChatJoinRoomDTO = chatJoinRoomDTO;
	}




	public ChatJoinRoomDTO() {
		super();
	}




	public String getJoin_id() {
		return join_id;
	}




	public void setJoin_id(String join_id) {
		this.join_id = join_id;
	}




	public String getUser_id() {
		return user_id;
	}




	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}




	public String getRoom_id() {
		return room_id;
	}




	public void setRoom_id(String room_id) {
		this.room_id = room_id;
	}







	public ChatJoinRoomDTO(String join_id, String user_id, String room_id) {
		super();
		this.join_id = join_id;
		this.user_id = user_id;
		this.room_id = room_id;
	}
	
	
	
	
}
