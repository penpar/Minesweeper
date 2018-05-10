package two.mine.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import two.mine.dao.BoardDAO;
import two.mine.dto.BoardDTO;

public class BoardService {

	HttpServletRequest request;
	HttpServletResponse response;
	
	public BoardService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	//리스트요청
			public void boardList() throws ServletException, IOException{
			request.setCharacterEncoding("UTF-8");
			String caNum = request.getParameter("ca_num");
			System.out.println("카테고리 넘버 : " + caNum);
			String opt = request.getParameter("opt");
			String condition = request.getParameter("condition");
			System.out.println("opt : "+opt);
			System.out.println("condition : " + condition);
							
			BoardDAO dao = new BoardDAO();
			
			int page = 1;//현재 페이지
			String currentPage = request.getParameter("page");
			System.out.println("현재 페이지" + currentPage);
			if(currentPage !=null) {
				page = Integer.parseInt(currentPage);
			}
			System.out.println("페이지"+page);
			int countList = 15; // 한 화면에 보여줄 게시글 수 
			int countPage = 10; // 한 화면에 보여줄 페이지 수
			int totalCount = dao.boardCount(caNum,opt,condition); // 게시글 총 개수
			
			System.out.println("필요한 페이지 : " +totalCount);
			
			int totalPage = totalCount / countList; // 총 페이지

			if (totalCount % countList > 0) {
			    totalPage++;
			}

			if (totalPage < page) {
			    page = totalPage;
			}

			int startPage = ((page - 1) / 10) * 10 + 1; //글 페이징 부분에서 보여줄 첫번째 번호
			int endPage = startPage + countPage - 1; // 글 페이징 부분에서 보여줄 마지막 번호

			if (endPage > totalPage) {
			    endPage = totalPage;
			}
			
			//페이징관련
			/////////////////////////////////////////////////////////////////////////////////////////
			//검색 관련
			
				dao = new BoardDAO();
				ArrayList<BoardDTO> list = dao.list(caNum,page,countList,opt,condition);
				
				System.out.println("사이즈 : " + list.size());
				if(list.size() >0) {
					request.setAttribute("list", list);
				}else {
					request.setAttribute("msg", "불러올 리스트가 없습니다.");
				}
				
					if(opt == null ) {
						request.setAttribute("opt", null);
					}else {
						request.setAttribute("opt", opt);
					}
					if(condition == null) {
						request.setAttribute("condition", null);
					}else {
						request.setAttribute("condition", condition);
					}
					request.setAttribute("spage", page);
			        request.setAttribute("maxPage", totalPage);
			        request.setAttribute("startPage", startPage);
			        request.setAttribute("endPage", endPage);
					request.setAttribute("ca_num", caNum);
					
					RequestDispatcher dis = request.getRequestDispatcher("boardList.jsp");
					dis.forward(request, response);
			}

		//글쓰기 페이지요청
		public void writeForm() throws ServletException, IOException{
			BoardDAO dao = new BoardDAO();
			String id = (String) request.getSession().getAttribute("loginId");
			String caNum = request.getParameter("ca_num");
			System.out.println("글쓰기 카테고리 : " + caNum);
			System.out.println(id);
			String nickName = dao.writeForm(id);
			
			request.setAttribute("ca_num", caNum);
			request.setAttribute("nickName", nickName);
			request.setAttribute("id", id);
			RequestDispatcher dis = request.getRequestDispatcher("boardWriteForm.jsp");
			dis.forward(request, response);
		}
		
		//리스트글쓰기요청
		public void boardWrite() throws ServletException, IOException{
			//사용자 상태 확인
			int state = (int) request.getSession().getAttribute("state");
			//파일 업로드 실행 -> 파일, 파라메터 ->DTO반환
			PhotoUpload upload = new PhotoUpload(request);
			BoardDTO dto =upload.regist();
			
			String id = (String) request.getSession().getAttribute("loginId");
			String caNum = request.getParameter("ca_num");
			dto.setId(id);
			dto.setCa_num(Integer.parseInt(caNum));
			dto.setB_order(state);
			
			System.out.println("보드라이트 : "+id);
			System.out.println("보드라이트 :" +caNum);
			String msg="등록에 실패했습니다.";
			
			if(dto != null) {
				BoardDAO dao = new BoardDAO();
				if(dao.write(dto) == 1) {
					msg="등록에 성공 했습니다.";
				}
			}
					
			request.setAttribute("msg", msg);
			RequestDispatcher dis = request.getRequestDispatcher("/boardList?id="+id);
			dis.forward(request, response);
			//DAO로 저장 요청 ->결과값 반환(1|0) ->클라이언트에 전달
					
		}





		//상세보기 요청
	      public void boardDetail() throws ServletException, IOException{
	         
	         System.out.println("닉네임 : "+request.getParameter("nickName"));
	         System.out.println("비키 : "+request.getParameter("b_key"));
	         
	         int bkey = Integer.parseInt(request.getParameter("b_key"));
	         String caNum = request.getParameter("ca_num");
	         
	         System.out.println("비키 : " +bkey);
	         
	         BoardDAO dao = new BoardDAO();
	         BoardDTO dto = dao.detail(bkey);
	         
	         if(dto !=null) {
	            request.setAttribute("ca_num", caNum);
	            request.setAttribute("dto", dto);
	            request.setAttribute("idx", request.getParameter("b_idx"));
	            request.setAttribute("nickName", request.getParameter("nickName"));
	            RequestDispatcher dis = request.getRequestDispatcher("boardDetail.jsp");
	            dis.forward(request, response);
	         }else {
	            response.sendRedirect("list");
	         }
	      }


		//삭제요청
		public void boardDelete() throws ServletException, IOException{
			
			int bkey = Integer.parseInt(request.getParameter("b_key"));
			String caNum = request.getParameter("ca_num");
			System.out.println(bkey);
			
			BoardDAO dao = new BoardDAO();
			String fileName = dao.fileNameCall(bkey);
			
			String msg="삭제에 실패 했습니다.";
			if(dao.delete(bkey) == 1) {
				
				System.out.println(fileName);
				if(fileName != null) {
					PhotoUpload photo = new PhotoUpload(request);
					photo.del(fileName);
				}
				msg = "삭제에 성공 하였습니다.";			
			}
			request.setAttribute("msg", msg);
			request.setAttribute("ca_num", caNum);
			RequestDispatcher dis = request.getRequestDispatcher("/boardList");
			dis.forward(request, response);
			
		}


		//수정페이지 요청
		public void boardUpdateForm() throws ServletException, IOException{
			
			int bkey = Integer.parseInt(request.getParameter("b_key"));
			String caNum = request.getParameter("ca_num");
			BoardDAO dao = new BoardDAO();
			BoardDTO dto = dao.detail(bkey);
				
			if(dto != null) {
				request.setAttribute("ca_num", caNum);
				request.setAttribute("dto", dto);
				request.setAttribute("nickName", request.getParameter("nickName"));
				RequestDispatcher dis = request.getRequestDispatcher("boardUpdateForm.jsp");
				dis.forward(request, response);
			}else {
				response.sendRedirect("./boardList"); // asd
			}	
		}
		
		//리스트 수정 요청
	      public void boardUpdate() throws ServletException, IOException{
	         //int bkey = Integer.parseInt(request.getParameter("idx"));
	         //파일 업로드 실행 -> 파일,파라메터 ->DTO반환
	         PhotoUpload upload = new PhotoUpload(request);
	         BoardDTO dto = upload.regist();
	         String caNum = request.getParameter("ca_num");
	         String nickName = request.getParameter("nickName");
	         String bKey = request.getParameter("b_key");
	         System.out.println(nickName +"//"+ dto.getB_key());
	         System.out.println("리스트 비키 : "+dto.getB_key());
	         System.out.println("subject : "+dto.getB_subject());
	         System.out.println("content : "+dto.getB_content());
	         System.out.println("newfileName : "+dto.getNewFileName());
	         
	         BoardDAO dao  = new BoardDAO();
	         //기존 파일명 검색
	         String delFileName = dao.fileNameCall(dto.getB_key());//new
	         System.out.println("delFileName : "+delFileName);
	         System.out.println(dto);
	         //글수정(1|0 반환갑 생략)
	         dao.update(dto);
	         
	         if(dto.getNewFileName() != null) {//새로올린 파일이 있을 경우
	            //파일명 수정하고
	            dao = new BoardDAO();
	            dao.fileNameCall(delFileName,dto);
	            //기존파일 삭제
	            if(delFileName !=null) {
	               PhotoUpload photo =new PhotoUpload(request);
	               photo.del(delFileName);
	            }
	         }
	         String msg = "난리난다.";
	         //성공하면 detail 실패하면 updateForm
	         request.setAttribute("b_key", bKey);
	         request.setAttribute("b_key", dto.getB_key());
	         request.setAttribute("nickName", nickName);
	         request.setAttribute("msg", msg);
	         request.setAttribute("ca_num", caNum);
	         RequestDispatcher dis = request.getRequestDispatcher("/boardDetail");
	         dis.forward(request, response);
	         //response.sendRedirect("boardList");
	      }
		
		//댓글 작성 요청
				public void comCreat() throws ServletException, IOException{
					String id = (String) request.getSession().getAttribute("loginId");
					String bKey = request.getParameter("b_key");
					String content = request.getParameter("textarea");
					
					BoardDAO dao = new BoardDAO();
					
					int success = dao.comCreat(id,bKey,content);
					
					HashMap<String, Integer> map = new HashMap<>();
					
					map.put("success", success);
					
					Gson json = new Gson();
					String obj = json.toJson(map);
					response.getWriter().println(obj);
					
				}

				//댓글 리스트 요청
				public void comList() throws ServletException, IOException{
					
					String bKey = request.getParameter("b_key");
					String id = (String) request.getSession().getAttribute("loginId");
					
					BoardDAO dao = new BoardDAO();
					ArrayList<BoardDTO> list = dao.comList(bKey,id,request);
					
					HashMap<String, ArrayList<BoardDTO>> map = new HashMap<>();
					
					if(list.size() >0) {
						map.put("list", list);
					}else {
						map.put("list", null);
					}

					Gson json = new Gson();
					String obj = json.toJson(map);
					response.setContentType("test/html; charset=UTF-8");//한글 꺠짐 방지
					response.getWriter().println(obj);
					
					
				}

				//댓글 삭제 요청
				public void comDel() throws ServletException, IOException{
					String cIdx = request.getParameter("idx");
					String nickName = request.getParameter("nickName");
					System.out.println("닉네임 :"+nickName);
					
					BoardDAO dao = new BoardDAO();
					dao.comDel(cIdx);
					
					System.out.println(cIdx);
					request.setAttribute("nickName", nickName);
					RequestDispatcher dis = request.getRequestDispatcher("/boardDetail");
					dis.forward(request, response);
					
				}
				
				public void blind() throws ServletException, IOException{
					String b_key = request.getParameter("b_key");
					String caNum = request.getParameter("ca_num");
					BoardDAO dao = new BoardDAO();
					dao.blind(b_key);
					response.sendRedirect("./boardList?ca_num="+caNum);
				}

				public void blindcancel() throws ServletException, IOException{
					String b_key = request.getParameter("b_key");
					String caNum = request.getParameter("ca_num");
					BoardDAO dao = new BoardDAO();
					dao.blindcancel(b_key);
					response.sendRedirect("./boardList?ca_num="+caNum);
					
				}


}
