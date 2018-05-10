package two.mine.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import two.mine.dao.MemberDAO;
import two.mine.dao.MsgDAO;
import two.mine.dto.BanListDTO;
import two.mine.dto.GameDTO;
import two.mine.dto.MemberDTO;

public class MemberService {

	HttpServletRequest request;
	HttpServletResponse response;
	
	public MemberService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	//로그인 요청
		public void login() throws IOException, ServletException {
			String id  = request.getParameter("id");
			String pw = request.getParameter("pw");
			System.out.println(id+"/"+pw);
			//DB쪽으로 넘겨야 함 (DAO)
			MemberDAO dao = new MemberDAO();
			
			if(dao.login(id,pw)) {  //id,pw 인자값
				//유져 상태 확인
				MemberDAO dao1 = new MemberDAO();
				int state = dao1.state(id);
				System.out.println("state "+state);
				if(state == 1) {
					System.out.println("정지절차");
					MemberDAO dao2 = new MemberDAO();
					String reason = dao2.reasonlookup(id);
					
					request.setAttribute("msg", "정지된 아이디 입니다.");
					request.setAttribute("reason", reason);
					RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
					dis.forward(request, response);				
				}else {
				//세션에 아이디와 상태 넣기
				request.getSession().setAttribute("loginId", id);
				request.getSession().setAttribute("state", state);
				response.sendRedirect("./index.jsp");
				}
			}else{
				request.setAttribute("msg", "로그인에 실패하였습니다.");			
				RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
				dis.forward(request, response);
			}
			
		}

	//회원가입
	public void join() throws ServletException, IOException{
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String userID = request.getParameter("userID");
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String birthyy = request.getParameter("birthyy");
		String birthmm = request.getParameter("birthmm");
		String birthdd = request.getParameter("birthdd");
		
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userNickName = request.getParameter("userNickName");
		String userAge = birthyy+"-"+birthmm+"-"+birthdd;
		
		String overlayD = request.getParameter("overlayD");
		String overlayN = request.getParameter("overlayN");
		System.out.println(userID+userPassword1+userName+userAge+userGender+userEmail+userNickName);
		
		String allVal = null;
		
		//값 확인
		if(userID == null || userID.equals("") || userPassword1 == null || userPassword1.equals("")
				|| userPassword2 == null || userPassword2.equals("") || userName == null || userName.equals("") 
				|| userAge == null || userAge.equals("") || userGender == null || userGender.equals("")
				|| userEmail == null || userEmail.equals("") || userNickName == null || userNickName.equals("")) {
			//request.getSession().setAttribute("messageType", "오류 메세지");
			//request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			//response.sendRedirect("./joinForm.jsp");
			response.getWriter().println(-2);
			//return;
		}else if(overlayD.equals("false")) {//아이디
			response.getWriter().println(-3);
		}else if(overlayN.equals("false")) {//닉네임
			response.getWriter().println(-4);
		}else if(!userPassword1.equals(userPassword2)) {//비밀번호 확인
			System.out.println(userPassword1);
			System.out.println(userPassword2);
			//request.getSession().setAttribute("messageType", "오류 메세지");
			//request.getSession().setAttribute("messageContent", "비밀번호를 동일하게 입력해주세요.");
			//response.sendRedirect("./joinForm.jsp");
			response.getWriter().println(-1);
			//return;
		}else {
			allVal = "good";
		}
		
		if(allVal != null) {
			int result = new MemberDAO().register(userID, userPassword1, userName, userAge, userGender, userEmail, userNickName);
			
			if(result == 1) {//회원가입 성공 여부
				
				//request.getSession().setAttribute("messageType", "성공 메세지");
				//request.getSession().setAttribute("messageContent", "회원가입을 축하드립니다!!");
				//response.sendRedirect("./joinForm.jsp");
				response.getWriter().println(1);
				//return;
			}else {
				//request.getSession().setAttribute("messageType", "실패 메세지");
				//request.getSession().setAttribute("messageContent", "회원가입에 실패하셨습니다.");
				//response.sendRedirect("./joinForm.jsp");
				response.getWriter().println(0);
				//return;
			}
		}

	}

	
	//아이디 중복 확인
	public void overlay() throws IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userID = request.getParameter("userID");
		
		
		response.getWriter().write(new MemberDAO().idChk(userID) + "");

	}

	//닉네임 중복확인
	public void nickoverlay() throws IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userNickName = request.getParameter("userNickName");

		response.getWriter().write(new MemberDAO().nickChk(userNickName) + "");
	}
	
	//친구 리스트 뽑기
	public void friendList() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(false);
		String s_id = (String)session.getAttribute("loginId"); 
		System.out.println(s_id);
		
		MemberDAO dao = new MemberDAO();
		ArrayList<MemberDTO> friend = dao.freindDAO(s_id);
		System.out.println(friend.size());
		
		request.setAttribute("friend", friend);
		RequestDispatcher dis = request.getRequestDispatcher("friendList.jsp");
		dis.forward(request, response);	
	}

	//친구 검색 기능
	public void friendSearch() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");//검색한 아이디//닉네임
		
		request.getSession().setAttribute("searchId", id);
		MemberDAO dao = new MemberDAO();
		ArrayList<MemberDTO> s_friend = dao.friendSearch(id);
		
		HttpSession session = request.getSession(false);
		String s_id = (String)session.getAttribute("searchId"); 
		System.out.println("s_id = " + s_id);
		System.out.println(s_friend);

		request.setAttribute("s_friend", s_friend);
		RequestDispatcher dis = request.getRequestDispatcher("friendSearch.jsp");
		dis.forward(request, response);
	}
	
	//친구추가
	public void friendUpdate() throws IOException, ServletException {
		
		HttpSession session = request.getSession(false);
		String id = (String)session.getAttribute("loginId");   // 서치를 시도한 아이디를 가져 오기 로그인세션 아이디
		String s_id = (String)session.getAttribute("searchId"); // 검색해서 search된 아이디를 세션에 저장
		System.out.println(id+"  서치 아이디"+s_id); 
		// 생각 : 로그인세션 아이디를 기준으로 서치된 아이디 쿼리문으로 추가하기 // 내 아이디는 추가가 되면 안된다!
		
		String msg = "친구를 추가해 주세요";
		
		MemberDAO dao = new MemberDAO();
/*		if(id.equals(s_id)) {
			System.out.println("본인의 아이디는 친구 추가 할 수 없습니다.");
			msg = "본인의 아이디는 추가 할 수 없습니다.";
		}
	*/	
		if(dao.friendUpdate(id,s_id) == 1) {
			//response.sendRedirect("./friendUpdate.jsp");
			System.out.println("추가 완료");
			msg = "친구가 추가 되었습니다.";
		}else {
			System.out.println("본인의 아이디는 친구 추가 할 수 없습니다.");
			msg = "본인의 아이디는 추가 할 수 없습니다.";
		}
		
		request.setAttribute("msg1", msg);
		RequestDispatcher dis = request.getRequestDispatcher("friendUpdate.jsp");
		dis.forward(request, response);
	}

	//친구 삭제
	public void friendDel() throws ServletException, IOException {
		// 삭제를 시도한 세션 아이디 가져오기 위함이다
		HttpSession session = request.getSession(false);
		String id = (String)session.getAttribute("loginId");  
		
		String f_id = request.getParameter("f_id");
		System.out.println(f_id);
		
		MemberDAO dao = new MemberDAO();
		if(dao.friendDel(id, f_id)==1) {
			System.out.println("삭제성공");
		}
		friendList();
		
	}
		
	//프로필 보기
	   public void profile() throws ServletException, IOException{
	         String nick= request.getParameter("nickname");
	         System.out.println("nick : " + nick);
	                  
	         String sess = (String) request.getSession().getAttribute("loginId");
	         System.out.println(sess);
	         
	         int status =0;
	         int newmsg = 0;
	         GameDTO dto = null;
	         
	         if(nick!=null) {
	            System.out.println("ncik dto");
	            status=1;
	            MemberDAO dao = new MemberDAO();
	            dto= dao.profile(nick,1);
	            MsgDAO mdao = new MsgDAO();
				newmsg = mdao.newmsg(sess);
	         }else {
	            if(sess!=null){
	               status=1;
	               MemberDAO dao = new MemberDAO();
	               dto= dao.profile(sess,0);
	               MsgDAO mdao = new MsgDAO();
					newmsg = mdao.newmsg(sess);
	            }
	            
	         }
	         HashMap<String, Object> map = new HashMap<String, Object>();

	         map.put("status", status);
	         map.put("dto", dto);
	         map.put("newmsg",newmsg);
	         System.out.println();
	         Gson json = new Gson();//Gson 라이브러리를 통해      
	         String obj = json.toJson(map);//json 형태의 문자열로 만들어 준다.
	         
	         System.out.println(obj);
	         response.setContentType("test/html; charset=UTF-8");//한글 꺠짐 방지
	         response.getWriter().println(obj);
	      }
		//아바타 선택하기
		public void avataChoice() throws ServletException, IOException {
			String avataNum = request.getParameter("avataNum");
			String loginId = (String) request.getSession().getAttribute("loginId");
			
			System.out.println(loginId);
			System.out.println(avataNum);
			
			MemberDAO dao = new MemberDAO();
			
			int success = dao.avataChoice(avataNum,loginId);
			HashMap<String, Integer> map = new HashMap<>();
			
			map.put("success", success);
			
			Gson json = new Gson();
			
			String obj = json.toJson(map);
			response.getWriter().println(obj);
			
		}

		//회원정보 수정페이지 요청
		public void memUpdateForm() throws ServletException, IOException{
			System.out.println("온다");
			String id = (String) request.getSession().getAttribute("loginId");
			System.out.println(id);
			MemberDAO dao = new MemberDAO();
			MemberDTO dto = dao.memUpdateForm(id);
			
			HashMap<String, MemberDTO> map = new HashMap<>();
			
			map.put("dto", dto);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			response.setContentType("test/html; charset=UTF-8");//한글 꺠짐 방지
			response.getWriter().println(obj);
			
			/*request.setAttribute("id", dto.getId());
			request.setAttribute("userName", dto.getUserName());
			request.setAttribute("userAge", dto.getUserAge());
			
			RequestDispatcher dis = request.getRequestDispatcher("/index.jsp");
			dis.forward(request, response);*/
			
		}

		//정보 수정
		public void memberUpdate() throws ServletException, IOException{
			String pw = request.getParameter("pw");
			String nickName = request.getParameter("userNickName");
			String userGender = request.getParameter("userGender");
			String email = request.getParameter("userEmail");
			String id = request.getParameter("id");
			System.out.println(pw+"//"+nickName+"//"+userGender+"//"+email);
			
			MemberDAO dao = new MemberDAO();
			int success = dao.memberUpdate(pw,nickName,email,userGender,id);
			
			HashMap<String, Integer> map = new HashMap<>();
			
			map.put("success", success);
			
			Gson json = new Gson();
			String obj = json.toJson(map);
			
			response.getWriter().println(obj);
			
		}
		//관리자 회원 조회
		public void memberList() throws ServletException, IOException {
			System.out.println("멤버목록서비스");
			MemberDAO dao = new MemberDAO();
			ArrayList<MemberDTO> list = dao.memberList();
			request.setAttribute("list", list);
			RequestDispatcher dis = request.getRequestDispatcher("memberadmin.jsp");
			dis.forward(request, response);		
		}
		//정지
		public void ban() throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			String id = request.getParameter("id");
			String reason = request.getParameter("reason");
			System.out.println("정지할 아이디 : "+id+" 사유 : "+reason); 
			MemberDAO dao = new MemberDAO();
			int success = dao.ban(id,reason);
			String msg = "정지에 실패했습니다.";
			if(success == 1) {
				System.out.println("정지 성공했습니다.");
				msg="정지에 성공 했습니다.";
			}
			request.setAttribute("msg", msg);
			RequestDispatcher dis = request.getRequestDispatcher("banresult.jsp");
			dis.forward(request, response);
		}
		//정지 해제
		public void cancel() throws ServletException, IOException{
			String id = request.getParameter("id");
			MemberDAO dao = new MemberDAO();
			int success = dao.cancel(id);
			String msg = "해제에 실패 했습니다.";
			if(success == 1) {
				System.out.println("해제 성공했습니다.");
				msg = "정지가 해제 되었습니다.";
			}
			request.setAttribute("msg", msg);
			RequestDispatcher dis = request.getRequestDispatcher("memberList");
			dis.forward(request, response);
			
		}
		//정지 이력 조회
		public void banexp() throws ServletException, IOException{
			String id = request.getParameter("id");
			System.out.println("이력조회 아이디 : "+id);
			MemberDAO dao = new MemberDAO();
			ArrayList<BanListDTO> array = dao.banexp(id);
			request.setAttribute("list", array);
			RequestDispatcher dis = request.getRequestDispatcher("banexpForm.jsp");
			dis.forward(request, response);	
			
		}
		
		//친구 프로필
	      public void friendProfile() throws ServletException, IOException{
	         String nickName = request.getParameter("nickName");
	         System.out.println(nickName);
	         
	         MemberDAO dao = new MemberDAO();
	         GameDTO dto = dao.friendProfile(nickName);
	         
	         HashMap<String, Object> map = new HashMap<String, Object>();

	         map.put("dto", dto);
	         
	         Gson json = new Gson();//Gson 라이브러리를 통해      
	         String obj = json.toJson(map);//json 형태의 문자열로 만들어 준다.
	         
	         System.out.println(obj);
	         response.setContentType("test/html; charset=UTF-8");//한글 꺠짐 방지
	         response.getWriter().println(obj);
	         
	      }

	}



