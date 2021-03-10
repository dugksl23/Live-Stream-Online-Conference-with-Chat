package kh.pofo.dto;

import java.sql.Date;

public class CommentDTO {
	
	private String comment_writer;
	private String comment_id;
	private int writing_id;
	private String comment_content;
	private Date comment_date;
	private Date comment_del;
	public String getComment_writer() {
		return comment_writer;
	}
	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}
	public String getComment_id() {
		return comment_id;
	}
	public void setComment_id(String comment_id) {
		this.comment_id = comment_id;
	}
	public int getWriting_id() {
		return writing_id;
	}
	public void setWriting_id(int writing_id) {
		this.writing_id = writing_id;
	}
	public String getComment_content() {
		return comment_content;
	}
	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}
	public Date getComment_date() {
		return comment_date;
	}
	public void setComment_date(Date comment_date) {
		this.comment_date = comment_date;
	}
	public Date getComment_del() {
		return comment_del;
	}
	public void setComment_del(Date comment_del) {
		this.comment_del = comment_del;
	}
	public CommentDTO(String comment_writer, String comment_id, int writing_id, String comment_content,
			Date comment_date, Date comment_del) {
		super();
		this.comment_writer = comment_writer;
		this.comment_id = comment_id;
		this.writing_id = writing_id;
		this.comment_content = comment_content;
		this.comment_date = comment_date;
		this.comment_del = comment_del;
	}
	public CommentDTO() {
		super();
	}
	
	
	
}
