package kh.pofo.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pofo.dto.WritingDTO;

@Repository
public class HomeDAO {

	@Autowired
	private SqlSession db;
		
	public List<WritingDTO> home_boardList(String board_code) {
		
		List<WritingDTO> list=db.selectList("Home.home_boardList", board_code);
		return list;
	}
	
}
