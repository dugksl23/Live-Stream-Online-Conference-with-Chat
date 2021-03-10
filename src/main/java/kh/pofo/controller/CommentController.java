package kh.pofo.controller;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import kh.pofo.dto.CommentDTO;
import kh.pofo.service.CommentService;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService cService;
	
	@Autowired 
	private Gson gson;
	
	@RequestMapping(value="/writeComment.cm", produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String writeComment(CommentDTO dto, HttpServletRequest req) throws Exception {
		
		JsonObject obj=new JsonObject();
		
		req.setCharacterEncoding("utf-8");
		// ===== 댓글 쓰기 ========
		int result=cService.writeComment(dto);
		
		//====== 댓글 쓰기 비동기로직 ======
		List<Map<String, Object>> commentBox=cService.commentBox(dto.getWriting_id());
		
		String comment=gson.toJson(commentBox).toString();
		SimpleDateFormat str=new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		
		obj.addProperty("comment", comment);
		obj.addProperty("comment_date", str.format(commentBox.get(0).get("comment_date")));
		//===== 댓글 쓰기 비동기에 따른 댓글수 갱신 =======
		int commentCount=cService.commentCountByWriting(dto);
		obj.addProperty("commentCount", commentCount);
		
		return	obj.toString();
	}
	
	@RequestMapping("/deleteComment.cm")
	@ResponseBody
	public String deleteComment(CommentDTO dto) {
		
		JsonObject obj=new JsonObject();
		
		String result=cService.deleteComment(dto);
		
		//===== 댓글 쓰기 비동기에 따른 댓글수 갱신 =======
		int commentCount=cService.commentCountByWriting(dto);
		obj.addProperty("commentCount", commentCount);
				
		
		return obj.toString();
	}
	
	@RequestMapping("/updateComment.cm")
	@ResponseBody
	public String updateComment(CommentDTO dto) {
		System.out.println(dto.getComment_id());
		System.out.println(dto.getComment_content());
		
		String result=cService.updateComment(dto);
		return result;
	}
	
	@ExceptionHandler
	public String exceptionHandler(Exception e) {
		
		e.printStackTrace();
		
		return "error";
	}
}
