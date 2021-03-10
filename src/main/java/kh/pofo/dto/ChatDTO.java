package kh.pofo.dto;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class ChatDTO {

	
	private int chat_id;
	private String chat_content;
	private Date chat_date;
	private String user_id;
	private String room_id;
	private int rownumber;
	private String date;
	
	

	public ChatDTO() {
		super();
	}



	public int getChat_id() {
		return chat_id;
	}



	public void setChat_id(int chat_id) {
		this.chat_id = chat_id;
	}



	public String getChat_content() {
		return chat_content;
	}



	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}



	public Date getChat_date() {
		return chat_date;
	}



	public void setChat_date(Date chat_date) {
		this.chat_date = chat_date;
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



	public int getRownumber() {
		return rownumber;
	}



	public void setRownumber(int rownumber) {
		this.rownumber = rownumber;
	}



	public String getDate() {
		return date;
	}



	public void setDate(String date) {
		this.date = date;
	}



	public ChatDTO(int chat_id, String chat_content, Date chat_date, String user_id, String room_id, int rownumber,
			String date) {
		super();
		this.chat_id = chat_id;
		this.chat_content = chat_content;
		this.chat_date = chat_date;
		this.user_id = user_id;
		this.room_id = room_id;
		this.rownumber = rownumber;
		this.date = date;
	}



	
	
	
}
