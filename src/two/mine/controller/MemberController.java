package two.mine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import two.mine.service.MemberService;

@WebServlet({ "/login","/logout","/join","/overlay","/nickoverlay","/friendList","/friendSearch","/friendUpdate","/friendDel","/profile","/avataChoice","/memUpdateForm","/memberUpdate","/memberList","/ban","/cancel","/banexp","/friendProfile"})
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response)
			throws ServletException, IOException {
		multi(request, response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response)
			throws ServletException, IOException {
		multi(request, response);
	}

	private void multi(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		MemberService memberService = new MemberService(request, response);		
		String ctx = request.getContextPath();
		String uri = request.getRequestURI();
		String subAddr = uri.substring(ctx.length());

		switch (subAddr) {
		
		case "/login":
			System.out.println("로그인 요청 중");
			memberService.login();
			break;
			
		case "/logout":
			System.out.println("로그아웃 요청 중");
			request.getSession().removeAttribute("loginId");
			request.getSession().removeAttribute("state");
			response.sendRedirect("./index.jsp");
			break;
			
		case "/join":
			System.out.println("회원가입 요청");
			memberService.join();
			break;
			
		case "/overlay":
			System.out.println("아이디 중복체크");
			memberService.overlay();
			break;
			
		case "/nickoverlay":
			System.out.println("닉네임 중복확인");
			memberService.nickoverlay();
			break;
			
		case"/friendList":
			System.out.println("친구 리스트 요청");	
			memberService.friendList();
			break;	
			
		case"/friendSearch":
			System.out.println("친구 검색 요청");	
			memberService.friendSearch();
			break;
			
		case"/friendUpdate":
			System.out.println("친구 추가");
			memberService.friendUpdate();
			break;
			
		case"/friendDel":
			System.out.println("친구 삭제");
			memberService.friendDel();
			break;
			
		case"/profile":
			System.out.println("프로필 요청");
			memberService.profile();
			break;
			
		case"/avataChoice":
			System.out.println("아바타 수정 요청");
			memberService.avataChoice();
			break;
			
		case"/memUpdateForm":
			System.out.println("회원 정보 수정 요청");
			memberService.memUpdateForm();
			break;
			
		case"/memberUpdate":
			System.out.println("회원 정보 수정");
			memberService.memberUpdate();
			break;
			
		case"/memberList":
			System.out.println("멤버 목록 요청");
			memberService.memberList();
			break;
			
		case"/ban":
			System.out.println("멤버 정지 요청");
			memberService.ban();
			break;
			
		case"/cancel":
			System.out.println("정지 해제");
			memberService.cancel();
			break;
			
		case"/banexp":
			System.out.println("정지 이력 조회");
			memberService.banexp();
			break;
			
		case"/friendProfile":
	         System.out.println("정지 이력 조회");
	         memberService.friendProfile();
	         break;
			
		default :
			System.out.println("404");

		}

	}
}
