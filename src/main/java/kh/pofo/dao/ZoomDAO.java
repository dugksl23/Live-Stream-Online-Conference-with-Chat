package kh.pofo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pofo.dto.MemberDTO;

@Repository
public class ZoomDAO {
	
	
	@Autowired
	private SqlSession db;
	
	//==============================================================================================================
	// ====  tutor detail db 저장  ==============================
	public int setTutors(String host_id) {
		
		int result=db.insert("Zoom.setTutors", host_id);
		
		return result;
	}
	
	public List<MemberDTO> getTutors() {

		List<MemberDTO> tutors=db.selectList("Zoom.getTutors");
		
		return tutors;
	}
	
	// ==============================================================================================================
	// ==== tutor delete db 저장 ==============================
	public int deleteTutors(String host_id) {

		int result = db.delete("Zoom.deleteTutors", host_id);

		return result;
	}
	
	public List<MemberDTO> searchTutors(String host_id) {
		
		 Map<String, Object> param=new HashMap<>();
		 param.put("host_id", host_id);
		 List<MemberDTO> tutorsInfo = db.selectList("Zoom.searchTutors", param);
		   
		 return tutorsInfo;
	}
	

}
