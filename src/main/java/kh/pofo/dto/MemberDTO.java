package kh.pofo.dto;

import java.io.Serializable;
import java.util.Date;


public class MemberDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private String password;
	private String name;
	private Date reg_date;
	private String email;
	private String address1;
	private String address2;
	private String post_code;
	private String contact_number;
	private String sns_code;
	private String get_ad;
	private String withdrawal;
	private String thumbnail_url="/resources/popupSignin/images/profile.jpg";
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getPost_code() {
		return post_code;
	}
	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}
	public String getContact_number() {
		return contact_number;
	}
	public void setContact_number(String contact_number) {
		this.contact_number = contact_number;
	}
	public String getSns_code() {
		return sns_code;
	}
	public void setSns_code(String sns_code) {
		this.sns_code = sns_code;
	}
	public String getGet_ad() {
		return get_ad;
	}
	public void setGet_ad(String get_ad) {
		this.get_ad = get_ad;
	}
	public String getWithdrawal() {
		return withdrawal;
	}
	public void setWithdrawal(String withdrawal) {
		this.withdrawal = withdrawal;
	}
	public String getThumbnail_url() {
		return thumbnail_url;
	}
	public void setThumbnail_url(String thumbnail_url) {
		this.thumbnail_url = thumbnail_url;
	}
	public MemberDTO(String id, String password, String name, Date reg_date, String email, String address1,
			String address2, String post_code, String contact_number, String sns_code, String get_ad, String withdrawal,
			String thumbnail_url) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.reg_date = reg_date;
		this.email = email;
		this.address1 = address1;
		this.address2 = address2;
		this.post_code = post_code;
		this.contact_number = contact_number;
		this.sns_code = sns_code;
		this.get_ad = get_ad;
		this.withdrawal = withdrawal;
		this.thumbnail_url = thumbnail_url;
	}
	public MemberDTO() {
		super();
	}
	
	
	
	
}
