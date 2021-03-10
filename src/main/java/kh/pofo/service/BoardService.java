package kh.pofo.service;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import kh.pofo.dao.BoardDAO;
import kh.pofo.dto.BoardlikeDTO;
import kh.pofo.dto.MemberDTO;
import kh.pofo.dto.WritingDTO;
import kh.pofo.statics.BoardConfiguration;

@Service
public class BoardService {

	
	@Autowired
	private BoardDAO bDAO;
	
	@Autowired
	private HttpSession session;
	
	public void insertTest(String test) throws InterruptedException {
		
		bDAO.insertTest(test);
	}
	
	public List<WritingDTO> boardList(int cPage, String board_code) {
		
		List<WritingDTO> list=bDAO.boardList(cPage, board_code);
		return list;
	}
	
	
	public List<Map<String, Object>> commentsCount(){
		List<Map<String, Object>> commentCount=bDAO.commentsCount();
		return commentCount;
	}
	
	// 동기화에 따른 댓글수 함수
	public int commentCountByWriting(WritingDTO dto) {
		
		int result=bDAO.commentCountByWriting(dto);
		return result; 
	}

	
	public int afterWriting(WritingDTO dto) {
		
		int result=bDAO.afterWriting(dto);
		return result;
	}
	
	
	public int afterUpdateWriting(WritingDTO dto) {
		
		int result=bDAO.afterUpdateWriting(dto);
		
		return result;
	}
	
	public String deleteWriting(int writing_id) {
		int result=bDAO.deleteWriting(writing_id);
		
		String msg="";
		if(result==1) {
			msg="삭제가 완료되었습니다.";
		}
		
		return msg;
	}
	
	
	public List<WritingDTO> viewWriting(WritingDTO dto){
		List<WritingDTO> list=bDAO.viewWriting(dto);
		return list;
	}
	
	public List<Map<String, Object>> preNext(WritingDTO dto){
		
		List<Map<String, Object>> preNext=bDAO.preNext(dto);
		return preNext;
	}
	
	public int updateViewCount(int writing_id) {
		int result=bDAO.updateViewCount(writing_id);
		return result;
	}

	
	public List<WritingDTO> searchBy(String choice, String search, int cPage, String board_code){
		
		List<WritingDTO> searchList=bDAO.searchBy(choice,search, cPage);
		return searchList;
	}
	
	//게시판 진입 시, 레코드 갯수 취득
	private int recordTotalCount(String board_code) {
		
		int totalCount=bDAO.recordTotalCount(board_code);
		return totalCount;
	}
	
	// 게시판 진입 후, 검색 조건에 의한 레코드 갯수 취득
	private int recordTotalCountBySearch(String choice, String search, String board_code) {
		
		int totalCount=bDAO.recordTotalCountBySearch(choice, search, board_code);
		return totalCount;
	}
	
	
	
	//게시판 별, 총 게시물에 따른 페이징 처리
	public String getNavi(int currentPage, String board_code) {
		
		
		// 1. 총 게시물의 수를 구한다.
		int recordTotalCount=recordTotalCount(board_code);
		System.out.println(recordTotalCount);
		// 2. 총 게시물%10에 따른 페이지의 수
		int pageTotalCount=recordTotalCount/BoardConfiguration.recordCount_Per_Page;
		
		//3. 총 페이지수 관리 based on the recordTotalCount
		if(recordTotalCount%BoardConfiguration.naviCount_Per_page>0) {
			pageTotalCount++;
			//자바 계산식에 따른, 총게시물%10의 나머지 값이 x.1 이상일 경우,
			//소수점은 정수로 치환된다. ex)5.1 -> 1;
			//따라서, 나머지값이 0보다 클 경우에는,
			//총 페이지 갯수를 1개씩 늘린다. ex) 51개일 경우, 총 페이지의 수는 5.1 => 6page
		}
		
		//4. page 보안처리
		if(currentPage<1) {
			//현재 위치한 페이지가 1보다 작다면 1page만 존재.
			currentPage=1;
		}else if(currentPage>pageTotalCount) {
			//현재 페이지가 총 페이지수보다 클 경우,
			//총 페이지 갯수로 동일시.
			currentPage=pageTotalCount;
		}
		
		//5. startNavi와 endNavi
		//   *java에서의 int의 나눗셈 결과에서, 나머지(소숫점)은 취급하지 않는다.
		int startNavi=(((currentPage-1)/BoardConfiguration.recordCount_Per_Page)*BoardConfiguration.recordCount_Per_Page)+1;
		int endNavi=startNavi+BoardConfiguration.naviCount_Per_page-1;
		
		//6. endNavi와 총 페이지수 일치
		if(endNavi>pageTotalCount) {
			//endNavi는 startNavi에 따라+10한, 20,30,40 page순으로 끝나기에 endnavi가 항상 더 많아지는 구조이다.
			//반면, pageToatalCount는 recourdTotalCount/10을 기준으로 하기에
			//차이가 발생하기에 이를 일치시킨다.
			endNavi=pageTotalCount;
		}
		
		boolean needPrev=true;
		boolean needNext=true;
		
		if(startNavi==1) {needPrev=false;}
		if(endNavi==pageTotalCount) {needNext=false;}
		
		StringBuilder sb=new StringBuilder();
		

			sb.append(
					"<div class='container'>"+
					"<div class='row'>"+		
					"<nav aria-label='Page navigation example'>"+
					"<ul class='pagination justify-content-center'>"
					);
			if(needPrev) {
				sb.append("<li class='page-item'>"+
						 "<a class='page-link' href=/board/boardList.board?cPage="+(startNavi-1)+"&board_code="+board_code+" aria-label='Previous'>"+
						 	"<span aria-hidden='true'>&laquo;</span>"+
						 "</a>"+
						"</li>");
			}
			
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<li class='page-item'><a class='page-link' href='/board/boardList.board?cPage="+i+"&board_code="+board_code+"'>"+i+"</a></li>");
				//sb.append("<a href='/board/boardList.board?cPage="+i+"'> "+i+" </a>");
			}
			
			if(needNext) {
				sb.append("<li class='page-item'>" + 
						"      <a class='page-link' href='/board/boardList.board?cPage="+(endNavi+1)+"&board_code="+board_code+"' aria-label='Next'>" + 
						"        <span aria-hidden='true'>&raquo;</span>" + 
						"      </a>" + 
						"  </li>");
						//sb.append("<a href='/board/boardList.board?cPage="+(endNavi+1)+"'> > </a>");
			}
			
			sb.append("  </ul>" + 
					"</nav>"+
					"</div>"+
					"</div");
				
		return sb.toString();
	}
	
	
	//검색 조건별 페이징 처리 로직.
	public String getSearchNavi(String choice, String search, int currentPage, String board_code) {
		
		
		// 1. 총 게시물의 수를 구한다.
		int recordTotalCount=recordTotalCountBySearch(choice, search, board_code);
		System.out.println(recordTotalCount);
		// 2. 총 게시물%10에 따른 페이지의 수
		int pageTotalCount=recordTotalCount/BoardConfiguration.recordCount_Per_Page;
		
		//3. 총 페이지수 관리 based on the recordTotalCount
		if(recordTotalCount%BoardConfiguration.naviCount_Per_page>0) {
			pageTotalCount++;
			//자바 계산식에 따른, 총게시물%10의 나머지 값이 x.1 이상일 경우,
			//소수점은 정수로 치환된다. ex)5.1 -> 1;
			//따라서, 나머지값이 0보다 클 경우에는,
			//총 페이지 갯수를 1개씩 늘린다. ex) 51개일 경우, 총 페이지의 수는 5.1 => 6page
		}
		
		//4. page 보안처리
		if(currentPage<1) {
			//현재 위치한 페이지가 1보다 작다면 1page만 존재.
			currentPage=1;
		}else if(currentPage>pageTotalCount) {
			//현재 페이지가 총 페이지수보다 클 경우,
			//총 페이지 갯수로 동일시.
			currentPage=pageTotalCount;
		}
		
		//5. startNavi와 endNavi
		//   *java에서의 int의 나눗셈 결과에서, 나머지(소숫점)은 취급하지 않는다.
		int startNavi=(((currentPage-1)/BoardConfiguration.recordCount_Per_Page)*BoardConfiguration.recordCount_Per_Page)+1;
		int endNavi=startNavi+BoardConfiguration.naviCount_Per_page-1;
		
		//6. endNavi와 총 페이지수 일치
		if(endNavi>pageTotalCount) {
			//endNavi는 startNavi에 따라+10한, 20,30,40 page순으로 끝나기에 endnavi가 항상 더 많아지는 구조이다.
			//반면, pageToatalCount는 recourdTotalCount/10을 기준으로 하기에
			//차이가 발생하기에 이를 일치시킨다.
			endNavi=pageTotalCount;
		}
		
		boolean needPrev=true;
		boolean needNext=true;
		
		if(startNavi==1) {needPrev=false;}
		if(endNavi==pageTotalCount) {needNext=false;}
		
		StringBuilder sb=new StringBuilder();
		

			sb.append(
					"<div class='container'>"+
					"<div class='row'>"+
					"<nav class='row' aria-label='Page navigation example'>"+
					"<ul class='pagination justify-content-center'>"
					);
			if(needPrev) {
				sb.append("<li class='page-item'>"+
						 "<a class='page-link' href=/board/search.board?cPage="+(startNavi-1)+"&board_code="+board_code+"aria-label='Previous'>"+
						 	"<span aria-hidden='true'>&laquo;</span>"+
						 "</a>"+
						"</li>");
						//sb.append("<a href='/board/boardList.board?cPage="+(startNavi-1)+"'> < </a> ");
			}
			
			for(int i=startNavi; i<=endNavi; i++) {
				sb.append("<li class='page-item'><a class='page-link' href='/board/search.board?cPage="+i+"&board_code="+board_code+"'>"+i+"</a></li>");
				//sb.append("<a href='/board/boardList.board?cPage="+i+"'> "+i+" </a>");
			}
			
			if(needNext) {
				sb.append("<li class='page-item'>" + 
						"      <a class='page-link' href='/board/search.board?cPage="+(endNavi+1)+"&board_code="+board_code+"' aria-label='Next'>" + 
						"        <span aria-hidden='true'>&raquo;</span>" + 
						"      </a>" + 
						"  </li>");
						//sb.append("<a href='/board/boardList.board?cPage="+(endNavi+1)+"'> > </a>");
			}
			
			sb.append("  </ul>" + 
					"</nav>"+
					"</div>"+
					"</div>");
				
		return sb.toString();
	}
	
	
	
	
	

	//========================================================
	//[게시판 좋아요 기능]========================================
	public String board_like(BoardlikeDTO dto) {
		
		int result=bDAO.board_like(dto);
		String msg="";
		if(result==1) {
			msg="like";
		}else {
			msg="hate";
		}
		
		return msg;
	}
	
	//=== 자유게시판, 글보기 싫어요 기능 ===================
	public String board_hate(BoardlikeDTO dto) {
		
		int result=bDAO.board_hate(dto);
		String msg="";
		if(result==1) {
			msg="hate";
		}
		
		return msg;
	}
	
	//========================================================
	//[게시판 좋아요 user 확인 로직]============================
	public List<BoardlikeDTO> likeUser(int writing_id, String user_id){
		List<BoardlikeDTO> likeUser=bDAO.likeUser(writing_id, user_id);
		return likeUser;
	}
	
	
	//========================================================
	//[게시판 좋아요 갯수 비동기 업데이트 로직 for BoardLike]============================
	public int likeCount(BoardlikeDTO dto){
		int likeCount=bDAO.likeCount(dto);
		return likeCount;
	}
	
	//========================================================
	//[게시판 좋아요 갯수 확인 (동기화)로직 for Writing ]============================
	public int likeCount(WritingDTO dto){
		int likeCount=bDAO.likeCount(dto);
		return likeCount;
	}
	
	

			
		


}