package two.mine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import two.mine.service.BoardService;

@WebServlet({ "/boardList", "/boardDetail", "/boardDelete", "/boardWrite", "/boardUpdate", "/boardWriteForm" ,"/boardUpdateForm","/comCreat","/comList","/comDel","/boardBlind","/blindcancel"})
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		multi(request, response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException  {
		multi(request, response);
	}

	private void multi(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException{
		
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String subAddr = uri.substring(ctx.length());
		System.out.println(subAddr);
		
		BoardService boardService = new BoardService(request,response);
		
switch(subAddr) {
		
		case "/boardList" :
			System.out.println("리스트 요청");
			boardService.boardList();
			break;
			
		case "/boardDetail" :
			System.out.println("리스트상세보기 요청");
			boardService.boardDetail();
			break;
			
		case "/boardDelete" :
			System.out.println("리스트삭제 요청");
			boardService.boardDelete();
			break;
		
		case "/boardWriteForm" :
			System.out.println("리스트글쓰기페이지요청");
			boardService.writeForm();
			break;
			
		case "/boardWrite" :
			System.out.println("리스트글등록하기 요청");
			boardService.boardWrite();
			break;
			
		case "/boardUpdateForm" :
			System.out.println("리스트수정페이지 요청");
			boardService.boardUpdateForm();
			break;
			
		case "/boardUpdate" :
			System.out.println("리스트수정하기요청");
			boardService.boardUpdate();
			break;
			
		case "/comCreat" :
			System.out.println("댓글 작성 요청");
			boardService.comCreat();
			break;
			
		case "/comList" :
			System.out.println("댓글 리스트 요청");
			boardService.comList();
			break;
			
		case "/comDel" :
			System.out.println("댓글 삭제 요청");
			boardService.comDel();
			break;
			
		case "/boardBlind":
			System.out.println("게시글 블라인드 처리");
			boardService.blind();
			break;
			
		case "/blindcancel":
			System.out.println("블라인드 해제");
			boardService.blindcancel();
			break;
			
		default : 
			response.getWriter().println("컨트롤러에서 에러났다" );
		}
	}

}
