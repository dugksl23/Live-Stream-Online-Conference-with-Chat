package kh.pofo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pofo.dto.MemberDTO;



@Repository
public class MemberDAO {

	@Autowired
	private SqlSession db;
	
	public int saveKakaoUserInfo(String id, String email, String name, String thumbnail_url) {
		System.out.println("dao : "+id+email);
		Map<String, Object> param=new HashMap<String, Object>();
		param.put("id", id);
		param.put("email", email);
		param.put("name", name);
		param.put("thumbnail_url", thumbnail_url);
		
		int result=db.insert("Member.k_signup", param);
			
		return result;
	}
	
	public List<MemberDTO> snsUserInfo(String id) {
		
		List<MemberDTO> snsUserInfo=db.selectList("Member.snsUserInfo", id);
		return snsUserInfo;
	}
	
	public int updateKakaoUserInfo(String id, String email, String name, String thumbnail_url) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("email", email);
		param.put("name", name);
		param.put("thumbnail_url", thumbnail_url);
		
		int result=db.insert("Member.k_updateMyInfo", param);
			
		return result;
	}
	
	
	
	public int checkId(String id) {
		System.out.println("dao단에서의 id 확인 : "+id);
		int result=db.selectOne("Member.checkId", id);
		System.out.println(result);
		return result;
	}

	public int signin(MemberDTO dto) {
		
		int result=db.selectOne("Member.signin", dto);
		return result;
	}
	




	public int signup(MemberDTO dto) {
		System.out.println("dao단에서의  dto");
		
		int result=db.insert("Member.signup", dto);
		
		return result;
	}
	
	
	public int findPw(String id, String email) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("email", email);
		int result=db.selectOne("Member.findPw", param);
		return result; 
	}
	
	
	public int updatePw(String id, String pw) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("id", id);
		param.put("pw", pw);
		
		int result=db.update("Mypage.updatePw", param);
		return result;
	}
	
	public String findId(String name, String email) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("name", name);
		param.put("email", email);
		String result=db.selectOne("Member.findId", param);
		return result; 
	}
	
}
