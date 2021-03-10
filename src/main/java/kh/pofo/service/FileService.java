package kh.pofo.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService {
	
	@Autowired
	private HttpSession session;

	//========================================================
	//[ck-file upload]========================================
		
	public String ck_fileupload(MultipartFile fileupload) {
			
		
		//1. file original name 취득
				String ori_name=fileupload.getOriginalFilename();
				System.out.println(ori_name);
				
				//2. upload 경로 설정(tomcat의 realPath)
				String realPath=session.getServletContext().getRealPath("/ckupload");
				
				//3. 상기의 경로를 file 자료형으로 객체화한다.
				File filesPath=new File(realPath);
				System.out.println(filesPath.getName());
				System.out.println("realPath의 서버 경로"+session.getServletContext().getContextPath());
				//4. 해당 경로에 folder 생성
				if(!filesPath.exists()) {
					boolean result=filesPath.mkdir();
					System.out.println("폴더 생성 여부 : "+result);
				}
				
				//5. savedName 생성
				String saved_Name=UUID.randomUUID().toString().replace("-", "")+ori_name;
				
				//6. server단의 저장 경로에 해당 saved_name의 파일을 객체화한다..
				File targetFile=new File(filesPath.getAbsolutePath()+"/"+saved_Name);
				
				//7. server단에 상기의 경로에 file을 뿌린다.
				try {
					FileCopyUtils.copy(fileupload.getBytes(), targetFile);
					return "{ \"uploaded\" : true, \"url\" : \"http://localhost/"+filesPath.getName()+"/"+saved_Name+"\" }";
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return "{ \"uploaded\" : false, \"error\": { \"message\": \"업로드 중 에러가 발생했습니다. 다시 시도해 주세요.\" } }";
				}
		}
		
	
}
