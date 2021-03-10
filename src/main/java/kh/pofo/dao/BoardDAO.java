package kh.pofo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kh.pofo.dto.BoardlikeDTO;
import kh.pofo.dto.WritingDTO;
import kh.pofo.statics.BoardConfiguration;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSession db;
	
	
	public void insertTest(String writer) throws InterruptedException {
		for (int i = 0; i < 150; i++) {
			System.out.println(i + " 번째 입력중...");
			String title = "title" + i;
			String content = "content" + i;
			Map<String, String> param = new HashMap<String, String>();
			param.put("writer", "writer");
			param.put("title", title);
			param.put("contents", content);
			
			db.insert("Board.insertTest", param);
			Thread.sleep(500);
		}
		System.out.println("입력완료");
	}
	
	
	public List<WritingDTO> boardList(int cPage, String board_code){
		
		//startRowNum과endRowNum은 가져올 게시물의 번호이기에, 나눗셈(10)을 하지 않는다.
		int startRowNum=(cPage-1)*BoardConfiguration.naviCount_Per_page+1;
		int endRowNum=startRowNum+BoardConfiguration.naviCount_Per_page-1;
		System.out.println("startRowNum : "+startRowNum);
		System.out.println("endRowNum : "+endRowNum);
		
		Map<String, Object> param=new HashMap<>();
		param.put("startRowNum",startRowNum);
		param.put("endRowNum",endRowNum);
		param.put("board_code",board_code);
		
		
		List<WritingDTO> list=db.selectList("Board.boardList", param);
		return list;
	}
	
	public List<Map<String, Object>> commentsCount(){
		
		List<Map<String, Object>> commentCount=db.selectList("Board.commentsCount");
		return commentCount;
	}
	
	public int commentCountByWriting(WritingDTO dto) {
		
		int result=db.selectOne("Board.commentCountByWriting", dto);
		return result; 
	}
	
	public int afterWriting(WritingDTO dto) {
		
		int result=db.insert("Board.mainBoard_writing", dto);
		return result;
	}
	
	public int afterUpdateWriting(WritingDTO dto) {
		
		int result=db.update("Board.updateWriting", dto);
		
		return result;
	}
	
	public int deleteWriting(int writing_id) {
		
		int result=db.update("Board.deleteWriting",writing_id);
		
		return result;
	}
	
	
	public List<WritingDTO> viewWriting(WritingDTO dto){
		List<WritingDTO> list=db.selectList("Board.viewWriting", dto);
		return list;
	}
	
	public List<Map<String, Object>> preNext(WritingDTO dto){
		
		List<Map<String, Object>> preNext=db.selectList("Board.preNext",dto);
		return preNext;
	}
	
	public int updateViewCount(int writing_id){
		int result=db.update("Board.updateViewCount", writing_id);
		return result;
	}

	
	public List<WritingDTO> searchBy(String choice, String search, int cPage){
		
		//startRowNum과endRowNum은 가져올 게시물의 번호이기에, 나눗셈(10)을 하지 않는다.
		int startRowNum=(cPage-1)*BoardConfiguration.naviCount_Per_page+1;
		int endRowNum=startRowNum+BoardConfiguration.naviCount_Per_page-1;
		System.out.println("startRowNum : "+startRowNum);
		System.out.println("endRowNum : "+endRowNum);
				
		
		Map<String, Object> param=new HashMap<>();
		param.put("choice", choice);
		param.put("search", search);
		param.put("startRowNum", startRowNum);
		param.put("endRowNum", endRowNum);
		
		List<WritingDTO> searchList=db.selectList("Board.searchBy", param);
		return searchList;
	}
	
	//게시판 별, 총 레코드 갯수
	public int recordTotalCount(String board_code) {
		
		int totalCount=db.selectOne("Board.recordTotalCount", board_code);
		return totalCount;
	}
	
	//게시판 별, 검색 조건에 의한 총 게시물 갯수
	public int recordTotalCountBySearch(String choice, String search, String board_code) {
		
		Map<String, Object> param=new HashMap<>();
		param.put("choice", choice);
		param.put("search", search);
		param.put("board_code", board_code);
		
		int totalCount=db.selectOne("Board.recordTotalCountBySearch", param);
		return totalCount;
	}
	
	
	//========================================================
	//[게시판 좋아요 기능]========================================
	public int board_like(BoardlikeDTO dto) {
		
		int result=db.insert("Board.board_like",dto);
		
		return result;
	}
	
	//=== 자유게시판, 글보기 싫어요 기능 ===================
	public int board_hate(BoardlikeDTO dto) {
			
		int result=db.delete("Board.board_hate",dto);
			
		return result;
	}
	
	//========================================================
		//[게시판 좋아요 갯수 및 좋아요 user 확인 로직]============================
	public List<BoardlikeDTO> likeUser(int writing_id, String user_id){
		
		Map<String, Object> param=new HashMap<>();
		param.put("writing_id", writing_id);
		param.put("user_id", user_id);
		
		List<BoardlikeDTO> likeUser=db.selectList("Board.likeUser", param);
		return likeUser;
	}
	
	//========================================================
	//[게시판 좋아요 갯수 확인 로직]============================
	public int likeCount(BoardlikeDTO dto){
		
		int likeCount=db.selectOne("Board.likeCount", dto);
		
		return likeCount;
	}
			
	//========================================================
	//[게시판 좋아요 갯수 확인 (동기화)로직 for Writing ]============================
	public int likeCount(WritingDTO dto){
		int likeCount=db.selectOne("Board.likeCount", dto);
		return likeCount;
	}
	
		
}
