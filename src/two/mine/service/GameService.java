package two.mine.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import two.mine.dao.GameDAO;

public class GameService {
	
	HttpServletRequest request;
	HttpServletResponse response;
	
	public GameService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	//지뢰 분배하기
	public void mine() throws ServletException, IOException{
		String mine = request.getParameter("mine");
		System.out.println(mine);
		Mine ms = null;
		String[][] array = null;
		
		switch(mine){
		
		case"easy":
			ms = new Mine(9, 9);
			ms.setMineData(10);
			ms.analysisData();
			ms.printMineData();
			array = ms.array;
			break;
		case"normal":
			ms = new Mine(16, 16);
			ms.setMineData(40);
			ms.analysisData();
			ms.printMineData();
			array = ms.array;
			break;
		case"hard":
			ms = new Mine(16, 30);
			ms.setMineData(99);
			ms.analysisData();
			ms.printMineData();
			array = ms.array;
			break;
		}
		
		HashMap<String,String[][]> map = new HashMap<>();
		map.put("array", array);
		
		Gson json = new Gson();
		String obj = json.toJson(map);
		
		try {
			response.getWriter().println(obj);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	//결과 보여주기
	public void resultShow() throws ServletException, IOException{
		String id = (String) request.getSession().getAttribute("loginId");
		String level = request.getParameter("level");
		String time = request.getParameter("time");
		String success = request.getParameter("success");
		System.out.println(id+level+time+success);
		
		GameDAO dao = new GameDAO();
		System.out.println(dao);
		ArrayList<Integer> list = dao.resultShow(id,level,time,success);
		System.out.println(list);
		
		HashMap<String, ArrayList<Integer>> map = new HashMap<>();
		map.put("list", list);
		Gson json = new Gson();
		String obj = json.toJson(map);//json 형태의 문자열로 만들어 준다.
        System.out.println(obj);
        
        //한글 깨짐 방지
        response.setContentType("text/html; charset=UTF-8");
        //크로스도메인 허용 생략(외부에서 안쓰니)
        //response 객체를 통해서 반환
        response.getWriter().println(obj);
		
	}

	//빈칸 열기
	public void zeroOpener() throws ServletException, IOException{
		
		int floor = Integer.parseInt(request.getParameter("floor"));
		int room = Integer.parseInt(request.getParameter("room"));
		String level = request.getParameter("level");
		String[] mineArray = request.getParameterValues("list");
		String[][] javaMineArray = null; //자바에서 사용할 임시 배열
		List<String> zeroList = null; //0부분 담아둔 리스트?맵?
		Mine ms = null;
		
		System.out.println("층 : "+floor +" 호 : " +room+" 난이도 : "+level);

		switch(level){//값 받아온거 난이도별로 배열에 담기
		case"easy":
			javaMineArray = zeroBack(9,9,mineArray);//자바 내에서 사용하기 위해 다시 담아두기
			ms = new Mine(9,9,javaMineArray);// 그 배열을 뿌리고
			zeroList = ms.zeroSearch(floor, room,level);//zero인 부분 찾아내기
			break;
		case"normal":
			javaMineArray = zeroBack(16,16,mineArray);
			ms = new Mine(16,16,javaMineArray);
			zeroList = ms.zeroSearch(floor, room,level);
			break;
		case"hard":
			javaMineArray = zeroBack(16,30,mineArray);
			ms = new Mine(16,30,javaMineArray);
			zeroList = ms.zeroSearch(floor, room,level);
			break;
		}
		
		System.out.println(zeroList);

		HashMap<String, List<String>> map = new HashMap<>();
		map.put("list", zeroList);
		Gson json = new Gson();
		String obj = json.toJson(map);//json 형태의 문자열로 만들어 준다.
		
		System.out.println(obj);
		
        response.getWriter().println(obj);
		
	}

	//가져온거 자바배열에 담기
	private String[][] zeroBack(int x, int y, String[] mineArray) throws ServletException, IOException{
		
		String[][] javaMineArray = new String[x][y];
		
		for(int i = 0 ; i<x;i++){
			String[] mineSplit = mineArray[i].replace(" ", "").split(",");
			for(int j = 0; j<y;j++){
				javaMineArray[i][j] = mineSplit[j];
			}
		}
		System.out.println("담은 지뢰들");
		for(int i = 0 ; i<x;i++){
			for(int j = 0; j<y;j++){
				System.out.print(javaMineArray[i][j]);
			}
			System.out.println();
		}
		return javaMineArray;
		
	}
}
