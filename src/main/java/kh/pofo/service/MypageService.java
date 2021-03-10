package kh.pofo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import encryption.Encryption;
import kh.pofo.dao.MypageDAO;
import kh.pofo.dto.MemberDTO;

@Service
public class MypageService {
	
	
	@Autowired
	private MypageDAO mpDao;
	
	public List<MemberDTO> myInfo(String id) {
		List<MemberDTO> list=mpDao.myInfo(id);
		return list;
	}

	public int updateMyInfo(MemberDTO dto) {

		int result=mpDao.updateMyInfo(dto);
		return result;
	}


	public String withdrawal(String id) {

		int result=mpDao.withdrawal(id);
		System.out.println("서비스 탈퇴 요청 확인");
		System.out.println(result);
		
		String msg="";
		if(result==1) {
			msg="탈퇴가 완료되었습니다.";
		}

		return msg;
	}

	
	//==========================================
	//[sns 유저용 update ]========================
	
	public String updateMyInfoForSnsUser(MemberDTO dto) {

		mpDao.updateMyInfoForSnsUser(dto);

		return null;
	}

	

}
