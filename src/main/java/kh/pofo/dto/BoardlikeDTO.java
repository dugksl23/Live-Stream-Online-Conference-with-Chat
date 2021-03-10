package kh.pofo.dto;

public class BoardlikeDTO {
	
	private int like_id;
	private int writing_id;
	private String user_id;
	public int getLike_id() {
		return like_id;
	}
	public void setLike_id(int like_id) {
		this.like_id = like_id;
	}
	public int getWriting_id() {
		return writing_id;
	}
	public void setWriting_id(int writing_id) {
		this.writing_id = writing_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public BoardlikeDTO(int like_id, int writing_id, String user_id) {
		super();
		this.like_id = like_id;
		this.writing_id = writing_id;
		this.user_id = user_id;
	}
	public BoardlikeDTO() {
		super();
	}
	
	
}
