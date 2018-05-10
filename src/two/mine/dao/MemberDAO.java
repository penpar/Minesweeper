package two.mine.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import two.mine.dto.BanListDTO;
import two.mine.dto.GameDTO;
import two.mine.dto.MemberDTO;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public MemberDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//로그인 확인
	public boolean login(String id, String pw) {
		
		String sql = "SELECT id FROM member WHERE id=? AND pw=?";
		boolean success = false;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			success = rs.next();
			
		} catch (Exception e) {
			e.printStackTrace();
			return success;
		}finally {
			try {
				rs.close();
				ps.close();
				conn.close();
			}catch (Exception e) {
				e.printStackTrace();
				}
		}
		return success;
	}
	
	//아디 중복확인
		public int idChk(String userID) {
			
			String sql = "SELECT * FROM member WHERE id=?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, userID);
				rs = ps.executeQuery();
				if(rs.next() || userID.equals("")) {
					return 0; // 이미 존재하는 회원
				}else {
					return 1; // 가입 가능한 회원
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
						if(rs != null) rs.close();
						if(ps != null) ps.close();
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
			}
			return -1; //데이터베이스 오류
		}


		//회원가입
		public int register(String userID, String userPassword, String userName, 
				String userAge, String userGender, String userEmail, String userNickName) {
			String sql = "INSERT INTO member(id, pw, name, nickname, email, gender, birthday) VALUES(?,?,?,?,?,?,?)";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, userID);
				ps.setString(2, userPassword);
				ps.setString(3, userName);
				ps.setString(4, userNickName);
				ps.setString(5, userEmail);
				ps.setString(6, userGender);
				ps.setString(7, userAge);
				
				
				return ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
						if(rs != null) rs.close();
						if(ps != null) ps.close();
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
			}
			return -1; //데이터베이스 오류
		}

		//닉네임 중복확인
		public int nickChk(String userNickName) {
			
			String sql = "SELECT * FROM member WHERE nickname=?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, userNickName);
				rs = ps.executeQuery();
				if(rs.next() || userNickName.equals("")) {
					return 0; // 이미 존재하는 회원
				}else {
					return 1; // 가입 가능한 회원
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
						if(rs != null) rs.close();
						if(ps != null) ps.close();
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
			}
			return -1; //데이터베이스 오류
		}
		
		//친구목록보기
		public ArrayList<MemberDTO> freindDAO(String id) {
			ArrayList<MemberDTO> friend = new ArrayList<MemberDTO>();
			

			String sql = "SELECT F_id FROM friend WHERE id = ?";
			//String sql = "SELECT F_id FROM friend WHERE id = ?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();
				System.out.println(id);
				while(rs.next()) {
					MemberDTO dto = new MemberDTO();
					dto.setF_id(rs.getString("F_id"));
					friend.add(dto);			
					System.out.println("rs.next");
				}
				System.out.println(friend.size());
			} catch (SQLException e) {
				e.printStackTrace();
			}finally 
				{
					try {
						rs.close();
						ps.close();
						conn.close();				
					} catch (SQLException e) {	
						e.printStackTrace();
					}
			}
			System.out.println("성공");
			return friend;
			
		}

		//친구검색
		public ArrayList<MemberDTO> friendSearch(String id) {
			ArrayList<MemberDTO> s_friend = new ArrayList<MemberDTO>();
			System.out.println("DAO"+ id);
			String sql = "SELECT nickname,id FROM member WHERE nickname = ?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, id);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					MemberDTO dto = new MemberDTO();
					dto.setF_id(rs.getString("nickname"));	
					dto.setId(rs.getString("id"));
					s_friend.add(dto);
				}
				System.out.println(s_friend.size());

			} catch (SQLException e) {
				e.printStackTrace();
			}finally 
				{
					try {
						rs.close();
						ps.close();
						conn.close();				
					} catch (SQLException e) {	
						e.printStackTrace();
					}
			}
			return s_friend;
		
		}
		
		//친구추가
		public int friendUpdate(String id, String f_id) {
			int success = 0;
			String nickname = "";
			String sql1 = "SELECT nickname FROM member WHERE nickname = ?";  
			try {
				ps = conn.prepareStatement(sql1);
				ps.setString(1, id);
				rs = ps.executeQuery();

				if(rs.next()) {
					nickname = rs.getString("nickname");	
				}
				
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

			try {
		
				if(!nickname.equals(f_id)) {
				String sql2 = "INSERT INTO friend VALUES(?,?)";
				ps = conn.prepareStatement(sql2);
				
				ps.setString(1,id);
				ps.setString(2,f_id);
				
				success =ps.executeUpdate();
			}else {
				return success;
			}

			} catch (SQLException e) {
				e.printStackTrace();
				return success;
			}finally{
				try {
					ps.close();
					conn.close();
				} catch (SQLException e) {	}

			}
			return success;
		}

		//친구삭제
		public int friendDel(String id, String f_id) {
			int success = 0 ;
			
			String sql = "DELETE FROM friend WHERE id=? and f_id =?";
			
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1,id);
				ps.setString(2, f_id);
				success = ps.executeUpdate();	
				
			} catch (SQLException e) {
				e.printStackTrace();
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

		//프로필 불러오기
		public GameDTO profile(String id , int i) {
            
            System.out.println("dao"+id);
            GameDTO gameDto = new GameDTO();
            String sql = "";
            
            if(i == 1) {
            
            sql = "SELECT id FROM member WHERE nickname = ?";
            
            try {
               ps = conn.prepareStatement(sql);
               ps.setString(1, id);
               rs = ps.executeQuery();
               if(rs.next()) {
                  id = rs.getString("id");
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
            
            System.out.println(id);
            }
            
            
            
            sql = "SELECT nickName,avataPhoto FROM member WHERE id = ?";
            
            int aC=0;
            int wC=0;
            try {
               ps = conn.prepareStatement(sql);
               ps.setString(1, id);
               rs = ps.executeQuery();
               if(rs.next()) {
                  gameDto.setUserNickName(rs.getString("nickname"));
                  if(rs.getString("avataPhoto")!=null) {
                     gameDto.setAvataPhoto(rs.getString("avataPhoto"));
                  }else {
                     gameDto.setAvataPhoto(null);
                  }
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
            
            sql = "SELECT COUNT(CASE WHEN p_success='true' AND p_level='normal' AND id=? THEN 1 END) AS winCount FROM game";
            try {
               ps = conn.prepareStatement(sql);
               ps.setString(1, id);
               rs = ps.executeQuery();
               if(rs.next()) {
                  wC = rs.getInt("winCount");
                  gameDto.setWinCount(rs.getInt("winCount"));
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
            sql = "SELECT COUNT(CASE WHEN p_level='normal' AND id=? THEN 1 END) AS allCount FROM game";
            try {
               ps = conn.prepareStatement(sql);
               ps.setString(1, id);
               rs = ps.executeQuery();
               if(rs.next()) {
                  aC = rs.getInt("allCount");
                  gameDto.setAllCount(rs.getInt("allCount"));
               }
            } catch (SQLException e) {
               e.printStackTrace();
            }
            sql = "SELECT min(p_time) AS maxTime FROM game WHERE id = ? AND p_success='true' AND p_level='normal'";
            try {
               ps = conn.prepareStatement(sql);
               ps.setString(1, id);
               rs = ps.executeQuery();
               if(rs.next()) {
                  gameDto.setMaxTime(rs.getInt("maxTime"));
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
            return gameDto;
         }

				//아바타 선택하기
				public int avataChoice(String avataNum, String loginId) {
					int success = 0;
					
					String sql = "UPDATE member SET avataPhoto=? WHERE id = ?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, avataNum);
						ps.setString(2, loginId);
						
						success = ps.executeUpdate();
						
					} catch (SQLException e) {
						e.printStackTrace();
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

				//회원 정보 수정 페이지 요청
				public MemberDTO memUpdateForm(String id) {
					MemberDTO dto = new MemberDTO();
					
					String sql = "SELECT id,name,birthday,email,nickName FROM member WHERE id=?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, id);
						rs = ps.executeQuery();
						
						if(rs.next()) {
							dto.setId(rs.getString("id"));
							dto.setUserName(rs.getString("name"));
							dto.setUserAge(rs.getString("birthday"));
							dto.setUserEmail(rs.getString("email"));
							dto.setUserNickName(rs.getString("nickName"));
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
					return dto;
				}

				//회원 정보 수정
				public int memberUpdate(String pw, String nickName, String email, String userGender, String id) {
					int success = 0 ;
					
					String sql = "UPDATE member SET pw = ? , nickName = ? , email = ? , gender=? WHERE id = ?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, pw);
						ps.setString(2, nickName);
						ps.setString(3, email);
						ps.setString(4, userGender);
						ps.setString(5, id);
						
						success = ps.executeUpdate();
						
					} catch (SQLException e) {
						e.printStackTrace();
					}

					return success;
				}
				
				//유져 상태 확인
				public int state(String id) {
					int state = 0;// 0 : 일반회원, 1 : 정지회원, 2 : 관리자
					String sql = "SELECT state FROM member WHERE id=?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, id);
						rs = ps.executeQuery();
						if(rs.next()) {					
							state = rs.getInt("state");
							System.out.println("상태확인 성공 : "+state);
						}
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
					return state;
					
				}
				//회원 목록 불러오기
				public ArrayList<MemberDTO> memberList() {	
					System.out.println("멤버목록 디비");
					String sql = "SELECT id,nickname,birthday,email,state FROM member ORDER BY state DESC";
					ArrayList<MemberDTO> arry = new ArrayList<MemberDTO>();
					try {
						ps = conn.prepareStatement(sql);
						rs = ps.executeQuery();
						while(rs.next()){
							MemberDTO dto = new MemberDTO();
							dto.setUserID(rs.getString("id"));
							dto.setUserNickName(rs.getString("nickname"));
							dto.setUserEmail(rs.getString("email"));
							dto.setUserAge(rs.getString("birthday"));
							dto.setState(rs.getInt("state"));
							arry.add(dto);
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
					
					return arry;
				}

				public int ban(String id, String reason) {
					int success = 0;
					String sql = "UPDATE member SET state=1 WHERE id=?";
					try {
						conn.setAutoCommit(false);
						ps= conn.prepareStatement(sql);
						ps.setString(1, id);
						int result = ps.executeUpdate();
						if(result==1){
							String sql1 = "INSERT INTO banlist (id,reason) VALUES(?,?)";
							ps = conn.prepareStatement(sql1);
							ps.setString(1, id);
							ps.setString(2, reason);
							success = ps.executeUpdate();
							if(success==1) {
								conn.commit();
							}else {
								conn.rollback();
							}
							
						}
					} catch (SQLException e) {
						e.printStackTrace(); 
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

				public int cancel(String id) {
					int success = 0;
					String sql = "UPDATE member SET state=0 WHERE id=?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, id);
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

				public String reasonlookup(String id) {
					String reason = null;
					String sql = "SELECT * FROM (SELECT ROW_NUMBER() OVER (order by ban_date desc) AS rn ,reason FROM banlist WHERE id=?) WHERE rn=1";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, id);
						rs = ps.executeQuery();
						if(rs.next()) {
							reason = rs.getString("reason");
							System.out.println(reason);
							}
					} catch (SQLException e) {
						e.printStackTrace();
					} finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}				
					}
					
					return reason;
				}

				public ArrayList<BanListDTO> banexp(String id) {
					ArrayList<BanListDTO> array = new ArrayList<BanListDTO>();
					String sql = "SELECT reason, ban_date FROM banlist WHERE id=?";
					try {
						ps = conn.prepareStatement(sql);
						ps.setString(1, id);
						rs = ps.executeQuery();
						while(rs.next()) {
							BanListDTO dto = new BanListDTO();
							dto.setReason(rs.getString("reason"));
							dto.setBan_date(rs.getDate("ban_date"));
							array.add(dto);
						}
					} catch (SQLException e) {
						e.printStackTrace();
						return null;
					}finally {
						try {
							rs.close();
							ps.close();
							conn.close();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
					return array;
				}
				
				//친구 프로필 보기
	            public GameDTO friendProfile(String nickName) {
	               GameDTO gameDto = new GameDTO();
	               String id = null;
	               /*String sql = "SELECT m.nickName,m.avataPhoto, COUNT(CASE WHEN g.p_success='true' AND g.p_level='normal' THEN 1 END) AS winCount,"
	                     + " COUNT(CASE WHEN g.id=? THEN 1 END) AS allCount,min(g.p_time) AS maxTime "
	                     + " FROM member m,game g WHERE g.id=? AND m.id=?";*/
	               String sql = "SELECT id,nickName,avataPhoto FROM member WHERE nickName = ?";
	               int aC=0;
	               int wC=0;
	               try {
	                  ps = conn.prepareStatement(sql);
	                  ps.setString(1, nickName);
	                  rs = ps.executeQuery();
	                  if(rs.next()) {
	                     gameDto.setUserNickName(rs.getString("nickname"));
	                     id=rs.getString("id");
	                     if(rs.getString("avataPhoto")!=null) {
	                        gameDto.setAvataPhoto(rs.getString("avataPhoto"));
	                     }else {
	                        gameDto.setAvataPhoto(null);
	                     }
	                  }
	               } catch (SQLException e) {
	                  e.printStackTrace();
	               }
	               
	               sql = "SELECT COUNT(CASE WHEN p_success='true' AND p_level='normal' AND id=? THEN 1 END) AS winCount FROM game";
	               try {
	                  ps = conn.prepareStatement(sql);
	                  ps.setString(1, id);
	                  rs = ps.executeQuery();
	                  if(rs.next()) {
	                     wC = rs.getInt("winCount");
	                     gameDto.setWinCount(rs.getInt("winCount"));
	                  }
	               } catch (SQLException e) {
	                  e.printStackTrace();
	               }
	               sql = "SELECT COUNT(CASE WHEN p_level='normal' AND id=? THEN 1 END) AS allCount FROM game";
	               try {
	                  ps = conn.prepareStatement(sql);
	                  ps.setString(1, id);
	                  rs = ps.executeQuery();
	                  if(rs.next()) {
	                     aC = rs.getInt("allCount");
	                     gameDto.setAllCount(rs.getInt("allCount"));
	                  }
	               } catch (SQLException e) {
	                  e.printStackTrace();
	               }
	               sql = "SELECT min(p_time) AS maxTime FROM game WHERE id = ? AND p_success='true' AND p_level='normal'";
	               try {
	                  ps = conn.prepareStatement(sql);
	                  ps.setString(1, id);
	                  rs = ps.executeQuery();
	                  if(rs.next()) {
	                     gameDto.setMaxTime(rs.getInt("maxTime"));
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
	               return gameDto;
	            }
}
