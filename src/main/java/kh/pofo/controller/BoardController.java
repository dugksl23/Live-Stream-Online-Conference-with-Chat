package kh.pofo.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import kh.pofo.dto.BoardlikeDTO;
import kh.pofo.dto.MemberDTO;
import kh.pofo.dto.WritingDTO;
import kh.pofo.service.BoardService;
import kh.pofo.service.CommentService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardService bService;

	@Autowired
	private CommentService cService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private Gson gson;
		
	@RequestMapping("/insertTest.board")
	public void insertTest() throws Exception {
		bService.insertTest("test");
	}
	
	@RequestMapping("/boardList.board")
	public String boardList(int cPage, String board_code, Model model) throws Exception {
		
		//========================================================================
		//==== 0. 게시판의 code를 알기 위한 if문 분기점 ======================================
		if(board_code.contentEquals("00")) {
			session.setAttribute("board_name", "main");
			System.out.println("board_name :"+session.getAttribute("board_name"));
		}
		
		//========================================================================
		//===== 1. 게시판의 cPage별 navi ==============================================
		String navi=bService.getNavi(cPage, board_code);
		model.addAttribute("navi", navi);
		
		//========================================================================
		//===== 2. 게시판의 cpage별 record List =======================================
		List<WritingDTO> boardList=bService.boardList(cPage, board_code);
		model.addAttribute("boardList", boardList);
		
		//========================================================================
		// ==== 3. 게시글 별 총 댓글 수 ==================================================
		List<Map<String, Object>> commentsCount=bService.commentsCount();
		model.addAttribute("commentsCount", commentsCount);
		System.out.println("/board/"+session.getAttribute("board_name")+"BoardList");
		
		return "/board/"+session.getAttribute("board_name")+"BoardList";
	}
	
	//========================================================================
	// === 자유게시판 글쓰기와 글쓰기 수정 page로 이동 ==============
	@RequestMapping("/writingProc.board")
	public String writingProc(String proc, String board_code, Model model) {
		
		//========================================================================
		//==== 1. 게시팔 별 code 획득================================================
		if(board_code.contentEquals("00")) {
			session.setAttribute("board_code", "00");
		}
		
		//========================================================================
		// ==== 글쓰기와 글 수정 if문 분기점 ===============================================
		if(proc.contentEquals("new")) {
			return "/board/writing";
			
		}else if(proc.contentEquals("update")) {
			List<WritingDTO> list=(List<WritingDTO>)session.getAttribute("viewWriting");
			System.out.println(list.get(0).getWriting_title());
			model.addAttribute("list", list);
			return "board/updateWriting";
		}
		
		return "error";
	}


	// === 자유게시판, 글쓰기 완료 page  ==============
	@RequestMapping("/after_writing.board")
	public String afterWriting(WritingDTO dto) {
		System.out.println("글쓰기 도착");
		
		if(dto.getWriting_open()==null) {
			dto.setWriting_open("N");
		}
		
		dto.setWriting_writer((String)session.getAttribute("id"));
		bService.afterWriting(dto);
		
		return "redirect:/board/boardList.board?cPage=1&board_code="+dto.getBoard_code();
	}
	
	// === 자유게시판, 글쓰기 수정 완료 page ===========
	@RequestMapping("/after_updateWriting.board")
	public String afterUpdateWriting(WritingDTO dto) {
		
		dto.setWriting_writer((String)session.getAttribute("id"));
		if(dto.getWriting_open()==null) {
			dto.setWriting_open("N");
		}
		bService.afterUpdateWriting(dto);
		
		return "redirect:/board/viewWriting.board?cPage=1&writing_id="+dto.getWriting_id()+"&board_code="+dto.getBoard_code();
	}
	
	// === 글 삭제 로직 ===========
	@RequestMapping(value="/deleteWriting.board", produces="text/plain; charset=UTF8")
	@ResponseBody
	
	public String deleteWriting(int writing_id) {
		String result=bService.deleteWriting(writing_id);
		return result;
	}
	
	
	//========================================================================
	//=== 게시판 검색 기능 =========================================================
	@RequestMapping("/search.board")
	public String boardSearch(String choice, String search, int cPage, String board_code, Model model) {
		
		
		
		//========================================================================
		//==== 검색 조건 별, 전체 검색과 조건 검색 if문 분기점===================================
		if(search!=null) {
			session.setAttribute("choice", choice);
			session.setAttribute("search", search);
		}else if(search==null) {
			System.out.println("page눌렀을 때 searhc의 length");
			choice=(String)session.getAttribute("choice");
			search=(String)session.getAttribute("search");
		}
		
		//========================================================================
		//==== 0. 게시판의 code를 알기 위한 if문 분기점 =====================================
		if(board_code=="00") {
			session.setAttribute("board_name", "main");
		}
		
		//==== 1. 게시판 별, 검색 조건에 의한 레코드  검색 리스트 ================================
		List<WritingDTO> searchList=bService.searchBy(choice, search, cPage, board_code);
		model.addAttribute("boardList", searchList);
		
		//========================================================================
		//==== 2. 상기의 검색 리스트에 의한 페이징 처리  =======================================
		String sNavi=bService.getSearchNavi(choice, search,cPage, board_code);
		System.out.println(sNavi);
		model.addAttribute("navi", sNavi);
		
		return "/board/"+session.getAttribute("board_name")+"BoardList";
	}
	
	
	
	//========================================================================
	//=== 자유게시판 글 보기 기능 ====================================================
	@RequestMapping("/viewWriting.board")
	public String veiwWriting(WritingDTO dto, Model model){
		
		//========================================================================
		// ===== 1. 게시글 title, contents 보여주기  ========================================================
		List<WritingDTO> list=bService.viewWriting(dto);	
		session.setAttribute("viewWriting", list);
		model.addAttribute("list", list);
		
		//========================================================================
		//====== 2. 게시글의 이전글, 다음글 보여주기 ========================================
		List<Map<String, Object>> preNext=bService.preNext(dto);
		model.addAttribute("preNext",preNext);
		
		//========================================================================
		//====== 3. 댓글 보여주기 =====================================================
		List<Map<String, Object>> commentsList=cService.commentsList(dto);
		
		model.addAttribute("commentsList", commentsList);
		
		//========================================================================
		// ===== 4. viewCount update==============================================
		int result=bService.updateViewCount(dto.getWriting_id());
		
		//========================================================================
		// ==== 5. 댓글 수 보여주기 ====================================================
		int commentCountByWriting=bService.commentCountByWriting(dto);
		model.addAttribute("commentCountByWriting", commentCountByWriting);
		
		//========================================================================
		// ======= 5.  좋아요 or 싫어요  user 확인=======================================
		if(session.getAttribute("id")!=null) {
			String id=((String)session.getAttribute("id"));
			List<BoardlikeDTO> likeUser=bService.likeUser(dto.getWriting_id(), id);
			model.addAttribute("likeUser", likeUser);
		}
		
		//========================================================================
		// ======== 6. 좋아요 갯수 로직 ================================================
		int likeCount=bService.likeCount(dto);
		model.addAttribute("likeCount", likeCount);

		return "/board/viewWriting";
	}
	

	
	

	//=== 자유게시판, 글보기 좋아요 기능 ===================
	@RequestMapping(value="/board_like",  produces="text/plain; charset=UTF8")
	@ResponseBody
	public String board_like(BoardlikeDTO dto, Model model) {
		
		JsonObject obj=new JsonObject();
		// === db에 좋아요를 insert =====
		String msg=bService.board_like(dto);
		
		// ====  페이지 load, (비동기용) 좋아요 user의 like_id 조회 (select) =====
		List<BoardlikeDTO> likeUser=bService.likeUser(dto.getWriting_id(), (String)session.getAttribute("id"));
		obj.addProperty("likeUser", gson.toJson(likeUser));
		
		// ==== 페이지 load후, 해당 글의 (비동기용) 좋아요 갯수 갱신용(select) =======
		int likeCount=bService.likeCount(dto);
		obj.addProperty("likeCount", gson.toJson(likeCount));
		
		return obj.toString();
	}
	
	//=== 자유게시판, 글보기 싫어요 기능 ===================
	@RequestMapping(value="/board_hate", produces="text/plain; charset=UTF8")
	@ResponseBody
	public String board_hate(BoardlikeDTO dto,Model model) {
		
		
		String msg=bService.board_hate(dto);
		int likeCount=bService.likeCount(dto);
		System.out.println("삭제되었고");
		System.out.println(likeCount);
		return gson.toJson(likeCount).toString();
	}
	

	
	
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		
		e.printStackTrace();
		
		return "error";
	}
	
	
	
}
