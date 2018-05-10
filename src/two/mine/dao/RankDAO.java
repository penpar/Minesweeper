package two.mine.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


import two.mine.dto.RankDTO;

public class RankDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	Statement ss = null;
	ResultSet rs = null;
	
	public RankDAO() {
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	///////////////// today 랭크/////////////////////////
	public ArrayList<RankDTO> RankDAO(int p_day) {
		
		ArrayList<RankDTO> rank = new ArrayList<RankDTO>();
		
		//String sql = "select id, max(p_time) as p_time FROM game WHERE p_date = ? group by id order by p_time ASC";  


		System.out.println("date :" + p_day);
		// String sql = "SELECT * FROM game WHERE p_date = ? ORDER BY p_time ASC";
		
		String sql = "select nickname, min(p_time) as p_time ,ROW_NUMBER() OVER(ORDER BY min(p_time) ASC) as rank "
				+ "FROM game ,member "
				+ "WHERE p_day = ? and P_success = 'true' and game.id = member.id and p_level='normal'"
				+ "group by nickname order by p_time ASC";

		
				/*
				"select nickname, min(p_time) as p_time "
				   + "FROM game, member "
				   + "WHERE p_day = ? and P_success = '성공' and game.id = member.id "
				   + "group by nickname "
				   + "order by p_time ASC";*/
		//String sql = "SELECT F_id FROM friend WHERE id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_day);
			rs = ps.executeQuery();
			System.out.println(p_day);
			while(rs.next()) {
				RankDTO dto = new RankDTO();
				
				dto.setR_id(rs.getString("nickname"));
				dto.setP_time(rs.getInt("p_time"));
				rank.add(dto);			
				if(rank.size() > 9) {
					return rank;
				}
			}
			System.out.println(rank.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return rank;
	}
	
	
	///////////////////// week 랭크 ///////////////////////////
public ArrayList<RankDTO> RankDAO(int p_week1, int p_week2) {
		
		ArrayList<RankDTO> w_rank = new ArrayList<RankDTO>();
		
		//String sql = "select id, max(p_time) as p_time FROM game WHERE p_date = ? group by id order by p_time ASC";  


		System.out.println("date :" + p_week1 + " / " +p_week2);
		// String sql = "SELECT * FROM game WHERE p_date = ? ORDER BY p_time ASC";
		
		String sql = "select nickname, min(p_time) as p_time ,ROW_NUMBER() OVER(ORDER BY min(p_time) ASC) as rank "
				+ "FROM game ,member "
				+ "WHERE p_day between ? and ? and P_success = 'true' and game.id = member.id and p_level='normal'"
				+ "group by nickname order by p_time ASC";
				
				/*
				"select nickname, min(p_time) as p_time "
				   + "FROM game, member "
				   + "WHERE p_day between ? and ? and P_success = '성공' and game.id = member.id "
				   + "group by nickname order by p_time ASC";*/
		//String sql = "SELECT F_id FROM friend WHERE id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_week1);
			ps.setInt(2, p_week2);
			rs = ps.executeQuery();
			while(rs.next()) {
				RankDTO dto = new RankDTO();
				
				dto.setR_id(rs.getString("nickname"));
			//	dto.setP_success(rs.getString("p_success"));
				dto.setP_time(rs.getInt("p_time"));
			//	dto.setP_level(rs.getString("p_level"));
			//	dto.setP_date(rs.getDate("p_date"));
				w_rank.add(dto);			
				if(w_rank.size() > 9) {
					return w_rank;
				}
			}
			System.out.println("w_rank : "+w_rank.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally 
			{
				try {
					rs.close();
					ps.close();
									
				} catch (SQLException e) {	
					e.printStackTrace();
				}
		}
	
		return w_rank;
	}

	//////////////////////// 성공 횟수 ///////////////////////////////////////
	public ArrayList<RankDTO> CountRankDAO() {

	ArrayList<RankDTO> countRank = new ArrayList<RankDTO>();
		
		String sql = "SELECT member.nickname, max(p_date), COUNT(CASE WHEN p_success='true' AND p_level='normal' and member.id = game.id THEN 1 END) AS wincount, "
				+ "COUNT(CASE WHEN p_success='false' AND p_level='normal' and member.id = game.id THEN 1 END) AS failcount "
				+ "FROM game, member "
				+ "group by member.nickname "
				+ "HAVING COUNT(CASE WHEN p_success='true' AND p_level='normal' and member.id = game.id THEN 1 END) > 1 "
				+ "order by wincount DESC , max(p_date) asc";
		
		//String sql = "SELECT F_id FROM friend WHERE id = ?";
		try {
			ss = conn.createStatement();
			rs = ss.executeQuery(sql);
			while(rs.next()) {
				RankDTO dto = new RankDTO();
				
				dto.setR_id(rs.getString("nickname"));
			//	dto.setP_success(rs.getString("p_success"));
				int victory = rs.getInt("wincount");
				int fail = rs.getInt("failcount");
				System.out.println("승리 횟수  : " + victory);
				System.out.println("실패 횟수  : " +fail);
				dto.setCount(victory);
				double total = ((double)victory + (double)fail);
				double mul = ((double)victory/total)*100;

				double d = Double.parseDouble(String.format("%.2f", mul));
				System.out.println("승률 : " + d);
				dto.setPercentV(d);
				
				
				//	dto.setP_date(rs.getDate("p_date"));
				countRank.add(dto);			
				if(countRank.size() > 9) {
					return countRank;
				}
				
			}
			System.out.println("count" + countRank.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally 
			{
				try {
					rs.close();
					ss.close();
					conn.close();				
				} catch (SQLException e) {	
					e.printStackTrace();
				}
		}
	
		return countRank;
	}

	
	//랭크 검색
	public ArrayList<RankDTO> rankSearch(String nick, Integer today, Integer week1, Integer week2) {

			ArrayList<RankDTO> rankInfo = new ArrayList<RankDTO>();
			
			System.out.println("DAO : "+ nick);
			String sql1 = "select nickname, min(p_time) as p_time ,ROW_NUMBER() OVER(ORDER BY min(p_time) ASC) as rank1 "
					+ "FROM game ,member "
					+ "WHERE p_day = ? and P_success = 'true' and game.id = member.id "
					+ "group by nickname order by p_time ASC";
			RankDTO dto = new RankDTO();
			String dbNick1 = "";
			String dbNick2 = "";
			int dbToday = 0;
			int dbWeek =0;
			int victory = 0; 
			double winRatio = 0;
			try {
				ps = conn.prepareStatement(sql1);
				ps.setInt(1, today);
				
				rs = ps.executeQuery();
				
				while(rs.next()) {
					dbNick1 = rs.getString("nickname");
					if(nick.equals(dbNick1)) {
						
						 dbToday = rs.getInt("rank1");
						 System.out.println("하루   "+dbNick1);
						 System.out.println("하루   "+dbToday);
					}
				}
				
				String sql2 = "select nickname, min(p_time) as p_time ,ROW_NUMBER() OVER(ORDER BY min(p_time) ASC) as rank2 "
						+ "FROM game ,member "
						+ "WHERE p_day between ? and ? and P_success = 'true' and game.id = member.id "
						+ "group by nickname order by p_time ASC";
			
				ps = conn.prepareStatement(sql2);
				ps.setInt(1, week1);
				ps.setInt(2, week2);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					dbNick2 = rs.getString("nickname");
					System.out.println("한 주  : " + dbNick2);
					if(nick.equals(dbNick2)) {
					dbWeek = rs.getInt("rank2");
					}
				}
				
				
				String sql3 = "SELECT member.nickname, max(p_date), COUNT(CASE WHEN p_success='true' AND p_level='normal' and member.id = game.id THEN 1 END) AS wincount, "
						+ "COUNT(CASE WHEN p_success='false' AND p_level='normal' and member.id = game.id THEN 1 END) AS failcount "
						+ "FROM game, member "
						+ "group by member.nickname "
						+ "HAVING COUNT(CASE WHEN p_success='true' AND p_level='normal' and member.id = game.id THEN 1 END) > 1 "
						+ "order by wincount DESC , max(p_date) asc";
				
				
				ss = conn.createStatement();
				rs = ss.executeQuery(sql3);
			
				while(rs.next()) {
				
					dbNick2 = rs.getString("nickname");
					if(nick.equals(dbNick2)) {
					victory = rs.getInt("wincount");
					int fail = rs.getInt("failcount");
					
					double total = ((double)victory + (double)fail);
					double mul = ((double)victory/total)*100;

					winRatio = Double.parseDouble(String.format("%.2f", mul));
					System.out.println("승률 : " + winRatio);
					}
				
				}
	
				
				dto.setNickname(nick);
				dto.setRankToday(dbToday);
				dto.setRankWeek(dbWeek);
				dto.setPercentV(winRatio);
				dto.setCount(victory);
				rankInfo.add(dto);
				
				System.out.println(dto.getNickname());

				System.out.println(dto.getRankToday());

				System.out.println(dto.getRankWeek());
				
				System.out.println(dto.getPercentV());
				
				System.out.println(dto.getPercentV());
				

			} catch (SQLException e) {
				e.printStackTrace();
			}finally{
				try {
					rs.close();
					ps.close();
					conn.close();
				} catch (SQLException e) {
	
					e.printStackTrace();
				}
	
			}

			return rankInfo;
		}
		
		

	
	
}
