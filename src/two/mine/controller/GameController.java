
package two.mine.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import two.mine.service.GameService;
import two.mine.service.RankService;

@WebServlet({"/mine","/resultShow","/zeroOpener","/gameRank","/rankSearch"})
public class GameController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) 
					throws ServletException, IOException {
		photo(request,response);
	}

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		photo(request,response);
	}

	private void photo(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException{
		
		GameService mineService = new GameService(request, response);
		RankService rankService = new RankService(request, response);
		String url = request.getRequestURI();
		String ctx = request.getContextPath();
		String subArr = url.substring(ctx.length());
		
		System.out.println(subArr);
		
		switch(subArr) {

		case"/mine":
			System.out.println("마인 요청");
			mineService.mine();
			break;
			
		case"/resultShow":
			System.out.println("마인 요청");
			mineService.resultShow();
			break;
			
		case"/zeroOpener":
			System.out.println("빈칸 열기 요청");
			mineService.zeroOpener();
			break;
			
		case"/gameRank":
			System.out.println("랭크 보기");
			rankService.gameRank();
			break;
			
		case"/rankSearch":
			System.out.println("랭크 검색으로 보기");
			rankService.gameRankSearch();
			break;
		}
		
	}

}
