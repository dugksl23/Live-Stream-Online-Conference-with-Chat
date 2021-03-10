package kh.pofo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pofo.dto.MemberDTO;

@Repository
public class MypageDAO {
	
	@Autowired
	private SqlSession db;
	
	
	public List<MemberDTO> myInfo(String id){
		
		List<MemberDTO> list=db.selectList("Mypage.myInfo", id);
		return list;
	
	}
	
	public int updateMyInfo(MemberDTO dto) {
		
		int result=db.update("Mypage.updateMyInfo", dto);
		return result;
	}
	
	public int withdrawal(String id) {
		System.out.println("db 탈퇴요청 확인");
		int result=db.update("Mypage.withdrawal", id);
		return result;
	}
	
	public int updateMyInfoForSnsUser(MemberDTO dto) {
		
		int result=db.update("Mypage.updateMyInfoForSnsUser", dto);
		
		return result;
	}

}
