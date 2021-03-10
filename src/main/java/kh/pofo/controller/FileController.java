package kh.pofo.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kh.pofo.service.FileService;

@Controller
@RequestMapping("/file")
public class FileController {

	
	@Autowired
	private FileService fService;
	
	//===========================================================
	//[CK 파일 업로드 이벤트 발생시 처리]=============================================
	@RequestMapping(value="/upload", method=RequestMethod.POST, produces = "text/plain; charset=UTF8")
	@ResponseBody
	public String ck_fileupload(Model model, @RequestParam(value="upload", required=false)MultipartFile fileupload, HttpServletRequest req) {
		
		String result=fService.ck_fileupload(fileupload);
		System.out.println(result);
		return result;
	}
}
