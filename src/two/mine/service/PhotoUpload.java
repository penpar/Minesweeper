package two.mine.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

import two.mine.dto.BoardDTO;


public class PhotoUpload {
	
	HttpServletRequest request;
	String savePath;

	public PhotoUpload(HttpServletRequest request) {
		this.request = request;
		//1.저장 경로 지정
		String root = request.getSession().getServletContext().getRealPath("/"); //실제 경로
		savePath = root+"upload";
	}

	//사진올리기
	public BoardDTO regist(){
		
		BoardDTO dto =new BoardDTO();
		
		File dir = new File(savePath);
		
		//2.폴더 없으면 만들어 줌
		if(!dir.isDirectory()) {
			dir.mkdir();
		}
		
		//3.파일 저장
		String oriFileName = "";
		String newFileName = "";
		try {
			MultipartRequest multi = new MultipartRequest(request, savePath, 1024*1024*10, "UTF-8"); //multipart로 받아온거
			
			//4.이름 변경
			oriFileName = multi.getFilesystemName("photo");
			
			//파일이 있을 경우만 이름을 추출 한다.
			if(oriFileName != null) {				
				long currTime = System.currentTimeMillis();
				newFileName = currTime+"."
						+oriFileName.substring(oriFileName.indexOf(".")+1);
				System.out.println(savePath);
				File oriFile = new File(savePath+"/"+oriFileName);
				File newFile = new File(savePath+"/"+newFileName);
				oriFile.renameTo(newFile);
				
				dto.setOriFileName(oriFileName);
				dto.setNewFileName(newFileName);	
			}
			
			//5.파라메터(subject, content, user_name) 값 추출
			//6.DTO에 저장
			dto.setNickName(multi.getParameter("nickName"));
			dto.setB_subject(multi.getParameter("b_subject"));
			dto.setB_content(multi.getParameter("b_content"));
			//****************닉네임넣어*************************
			System.out.println(multi.getParameter("nickName"));
			System.out.println(multi.getParameter("b_subject"));
			System.out.println(multi.getParameter("b_content"));
			
			//수정 할 때 추가
			String b_key = multi.getParameter("b_key");
			System.out.println("b_key : "+b_key);
			if(b_key != null) {
				dto.setB_key(Integer.parseInt(b_key));
			}
			
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		return dto;
	}
	
	//삭제
		public void del(String fileName) {
			System.out.println("del path : "+savePath+"/"+fileName);
			File file = new File(savePath+"/"+fileName);
			if(file.exists()) {
				System.out.println("삭제 합니다.");
				boolean success = file.delete();
				System.out.println("삭제 성공 여부 : "+success);
			}
			
		}

}
