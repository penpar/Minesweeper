package two.mine.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import two.mine.dto.MemberDTO;
import two.mine.dto.RankDTO;
import two.mine.dao.MemberDAO;
import two.mine.dao.RankDAO;

public class RankService {

	HttpServletRequest request;
	HttpServletResponse response;

	public RankService(HttpServletRequest request, 
			HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void gameRank() throws ServletException, IOException {
        	RankPeriod rp = new RankPeriod();

        	ArrayList<Integer>period = rp.PeriodCal();
        
        
			request.setCharacterEncoding("UTF-8");
			RankDAO dao = new RankDAO();
			
			//int p_day = period.get(0);

			ArrayList<RankDTO> todayRank = dao.RankDAO(period.get(0));
			ArrayList<RankDTO> weekRank = dao.RankDAO(period.get(1),period.get(2));
			ArrayList<RankDTO> countRank = dao.CountRankDAO();
			
			
			
			request.setAttribute("rank", todayRank);
			request.setAttribute("wrank", weekRank);
			request.setAttribute("crank", countRank);
			RequestDispatcher dis = request.getRequestDispatcher("gameViewRank.jsp");
			dis.forward(request, response);	
		}

	
	public void gameRankSearch() throws ServletException, IOException {
		
		HashMap map = new HashMap();
		
		String nick = request.getParameter("nickname");
		RankPeriod rp = new RankPeriod();
    	ArrayList<Integer>period = rp.PeriodCal();
    	
		System.out.println(nick);
		RankDAO dao = new RankDAO();
		ArrayList<RankDTO> rankInfo = dao.rankSearch(nick,period.get(0),period.get(1),period.get(2));
		
		// 아작스로 보낸다.
		map.put("rankInfo",rankInfo);
		Gson json = new Gson();
		String obj = json.toJson(map);
		System.out.println(obj);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
		
		/* 폼으로 보낸다 하지만 쓰진 않는다.
		request.setAttribute("rankInfo", rankInfo);
		RequestDispatcher dis = request.getRequestDispatcher("gameViewRank.jsp");
		dis.forward(request, response);
		*/
		
		
	}
	
	
		
		
	

}
