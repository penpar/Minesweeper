package two.mine.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.catalina.filters.CsrfPreventionFilter;

import two.mine.dto.MsgDTO;

public class MsgDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public MsgDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//메시지 보내기
	public int sendmsg(String to, String from, String content) {
		int success = 0;
		String id = null;
		String sql = null;
		
		sql = "SELECT id FROM member WHERE nickName = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, to);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				id = rs.getString("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		sql="INSERT INTO message (m_idx, m_to, m_from, m_content) VALUES (msg_seq.NEXTVAL,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, from);
			ps.setString(3, content);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}finally {
			try {
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return success;		
	}

	public ArrayList<MsgDTO> receivemsg(String id) {
		ArrayList<MsgDTO> list = new ArrayList<MsgDTO>();
		String sql = "SELECT * FROM message WHERE m_to=? ORDER BY m_date DESC";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()){
				System.out.println(rs.getDate("m_date"));
				MsgDTO dto = new MsgDTO();
				dto.setFrom(rs.getString("m_from"));
				dto.setContent(rs.getString("m_content"));
				dto.setDate(rs.getTimestamp("m_date"));
				dto.setState(rs.getInt("m_state"));
				list.add(dto);
			}
			sql = "UPDATE message SET m_state=1 WHERE m_to=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		System.out.println(list);
		return list;
	}

	//안읽은 메시지만 숫자 카운트
	public int newmsg(String sess) {
		int newmsg = 0;
		String sql = "select count(decode(m_state,0,1)) as newmsg from message where M_TO=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sess);
			rs = ps.executeQuery();
			if(rs.next()) {
				newmsg = rs.getInt("newmsg");
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
		
		return newmsg;
	}

}
