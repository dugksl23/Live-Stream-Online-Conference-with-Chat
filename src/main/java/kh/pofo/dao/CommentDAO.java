package kh.pofo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pofo.dto.CommentDTO;
import kh.pofo.dto.WritingDTO;

@Repository
public class CommentDAO {

	@Autowired
	private SqlSession db;
	
	public int writeComment(CommentDTO dto) {
		
		int result=db.insert("Comment.writeComment",dto);
		return result;
	}
	
	public List<Map<String, Object>> commentsList(WritingDTO dto){
		
		List<Map<String, Object>> commentsList=db.selectList("Comment.commentList",dto);
		return commentsList;
	}
	
	
	// 비동기화에 따른 댓글수 함수
	public int commentCountByWriting(CommentDTO dto) {
			
		int result=db.selectOne("Comment.commentCountByWriting",dto);
		return result; 
	}
	
	
	public List<Map<String, Object>> commentBox(int writing_id){
		
		List<Map<String, Object>> commentBox=db.selectList("Comment.commentBox",writing_id);
		
		return commentBox;
	}
	
	public int deleteComment(CommentDTO dto) {
		System.out.println(dto.getComment_id());
		int result=db.update("Comment.deleteComment",dto.getComment_id());
		return result;
	}
	
	public int updateComment(CommentDTO dto) {
		int result=db.update("Comment.updateComment",dto);
		return result;
	}
	
}
