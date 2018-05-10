package two.mine.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GameDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public GameDAO() {
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	//결과값 저장 및 출력하기
	public ArrayList<Integer> resultShow(String id, String level, String time, String success) {
		System.out.println(id+level+time+success);
		
		Calendar day = Calendar.getInstance();
	    int p_day = day.get(Calendar.DAY_OF_YEAR);
	    
		String sql = "INSERT INTO game(id,p_success,p_time,p_level,p_day) VALUES(?,?,?,?,?)";
		int totalCount = 0;
		int winCount = 0;
		ArrayList<Integer> list = new ArrayList<>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, success);
			ps.setInt(3, Integer.parseInt(time));
			ps.setString(4, level);
			ps.setInt(5, p_day);
			
			ps.executeUpdate();
			
			sql = "SELECT COUNT(*) AS count FROM game WHERE id = ? AND p_level = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, level);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt("count");
				System.out.println(totalCount);
				list.add(totalCount);
			}
			
			sql = "SELECT COUNT(CASE WHEN p_success='true' AND p_level=? AND id=? THEN 1 END) AS winCount FROM game";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, level);
			ps.setString(2, id);
			rs = ps.executeQuery();
			System.out.println(rs);
			if(rs.next()) {
				winCount = rs.getInt("winCount");
				list.add(winCount);
			}

			if(success.equals("true")) {
				list.add(1);
			}else {
				list.add(0);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
		
	}
}
