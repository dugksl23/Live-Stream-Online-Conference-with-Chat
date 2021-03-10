package kh.pofo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kh.pofo.dao.CommentDAO;
import kh.pofo.dto.CommentDTO;
import kh.pofo.dto.WritingDTO;

@Service
public class CommentService {

	@Autowired
	private CommentDAO cDAO;
	
	public int writeComment(CommentDTO dto) {
		
		int result=cDAO.writeComment(dto);
		
		return result;
	}
	
	public List<Map<String, Object>> commentsList(WritingDTO dto) {
		
		List<Map<String, Object>> commentsList=cDAO.commentsList(dto);
		
		return commentsList;
	}
	
	// 비동기화에 따른 댓글수 함수
	public int commentCountByWriting(CommentDTO dto) {
		
		int result=cDAO.commentCountByWriting(dto);
		return result; 
	}
	
	
	public List<Map<String, Object>> commentBox(int writing_id) {
		
		List<Map<String, Object>> commentBox=cDAO.commentBox(writing_id);
		
		return commentBox;
	}
	
	public String deleteComment(CommentDTO dto) {
		int result=cDAO.deleteComment(dto);
		String msg="";
		if(result==1) {
			msg="삭제가 완료되었습니다.";
		}
		return msg;
	}
	
	public String updateComment(CommentDTO dto) {
		int result=cDAO.updateComment(dto);
		String msg="";
		if(result==1) {
			msg="update done";
		}
		return msg;
	}
	
	
	
}
