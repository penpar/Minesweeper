package two.mine.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import two.mine.service.MsgService;


@WebServlet({"/sendmsg","/receivemsg"})
public class MsgController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException, IOException {
		process(request, response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		process(request, response);
	}

	private void process(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String subArr = uri.substring(ctx.length());
		System.out.println(subArr);
		MsgService msgservice = new MsgService(request,response);
		switch(subArr) {
			case"/sendmsg":
				System.out.println("메시지 발신");
				msgservice.sendmsg();
				break;
			
			case"/receivemsg":
				System.out.println("메시지 보기");
				msgservice.receivemsg();
				break;
			
			default:
				System.out.println("디폴트");
				
		}
	}

}
