package two.mine.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import two.mine.dao.MsgDAO;
import two.mine.dto.MsgDTO;

public class MsgService {

	HttpServletRequest request;
	HttpServletResponse response;
	
	public MsgService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void sendmsg() throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		String to = request.getParameter("to");
		String from = request.getParameter("from");
		String content = request.getParameter("content");
		System.out.println(to+"/"+from+"/"+content);
		MsgDAO dao = new MsgDAO();
		int success = dao.sendmsg(to,from,content);
		String msg ="쪽지 전송에 실패 했습니다.";
		if(success == 1){
			msg = "쪽지 전송에 성공 했습니다.";
		}
		request.setAttribute("msg", msg);
		RequestDispatcher dis =  request.getRequestDispatcher("./sendmsgresult.jsp");
		dis.forward(request, response);
		
		
	}

	public void receivemsg() throws ServletException, IOException{
		String id = (String) request.getSession().getAttribute("loginId");
		System.out.println("메시지 확인 id : "+id);
		MsgDAO dao = new MsgDAO();
		ArrayList<MsgDTO> list = dao.receivemsg(id);
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("./msgbox.jsp");
		dis.forward(request,response);
	}

}
