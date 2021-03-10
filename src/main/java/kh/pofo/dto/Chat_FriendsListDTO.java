package kh.pofo.dto;

public class Chat_FriendsListDTO {
	
	
	private String user_id;
	private String friends_id;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getFriends_id() {
		return friends_id;
	}
	public void setFriends_id(String friends_id) {
		this.friends_id = friends_id;
	}
	public Chat_FriendsListDTO(String user_id, String friends_id) {
		super();
		this.user_id = user_id;
		this.friends_id = friends_id;
	}
	public Chat_FriendsListDTO() {
		super();
	}

	

}
