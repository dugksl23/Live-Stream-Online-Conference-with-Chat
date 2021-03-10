package kh.pofo.dto;

import java.io.Serializable;
import java.sql.Date;

public class WritingDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int writing_id;
	private String board_code;
	private int uniq_bycode;
	private String writing_title;
	private String writing_content;
	private String writing_writer;
	private Date writing_date;
	private String writing_del;
	private String writing_open;
	private int writing_viewCount=0;
	public int getWriting_id() {
		return writing_id;
	}
	public void setWriting_id(int writing_id) {
		this.writing_id = writing_id;
	}
	public String getBoard_code() {
		return board_code;
	}
	public void setBoard_code(String board_code) {
		this.board_code = board_code;
	}
	public int getUniq_bycode() {
		return uniq_bycode;
	}
	public void setUniq_bycode(int uniq_bycode) {
		this.uniq_bycode = uniq_bycode;
	}
	public String getWriting_title() {
		return writing_title;
	}
	public void setWriting_title(String writing_title) {
		this.writing_title = writing_title;
	}
	public String getWriting_content() {
		return writing_content;
	}
	public void setWriting_content(String writing_content) {
		this.writing_content = writing_content;
	}
	public String getWriting_writer() {
		return writing_writer;
	}
	public void setWriting_writer(String writing_writer) {
		this.writing_writer = writing_writer;
	}
	public Date getWriting_date() {
		return writing_date;
	}
	public void setWriting_date(Date writing_date) {
		this.writing_date = writing_date;
	}
	public String getWriting_del() {
		return writing_del;
	}
	public void setWriting_del(String writing_del) {
		this.writing_del = writing_del;
	}
	public String getWriting_open() {
		return writing_open;
	}
	public void setWriting_open(String writing_open) {
		this.writing_open = writing_open;
	}
	public int getWriting_viewCount() {
		return writing_viewCount;
	}
	public void setWriting_viewCount(int writing_viewCount) {
		this.writing_viewCount = writing_viewCount;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public WritingDTO(int writing_id, String board_code, int uniq_bycode, String writing_title, String writing_content,
			String writing_writer, Date writing_date, String writing_del, String writing_open, int writing_viewCount) {
		super();
		this.writing_id = writing_id;
		this.board_code = board_code;
		this.uniq_bycode = uniq_bycode;
		this.writing_title = writing_title;
		this.writing_content = writing_content;
		this.writing_writer = writing_writer;
		this.writing_date = writing_date;
		this.writing_del = writing_del;
		this.writing_open = writing_open;
		this.writing_viewCount = writing_viewCount;
	}
	public WritingDTO() {
		super();
	}
	
		
	
}
