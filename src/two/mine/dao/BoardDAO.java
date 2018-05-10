package two.mine.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import two.mine.dto.BoardDTO;

public class BoardDAO {

   Connection conn = null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   
   public BoardDAO() {
      try {
         Context ctx = new InitialContext();
         DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
         conn = ds.getConnection();
      } catch (Exception e) {
         e.printStackTrace();
      }
      
   }
   //리스트요청
         public ArrayList<BoardDTO> list(String caNum, int page, int countList, String opt, String condition) {
            ArrayList<BoardDTO> list = new  ArrayList<BoardDTO>();
            //page 현재 페이지 // countList 한 페이지 내에서 보여줄 내용
            
            String sql = null;
            int endListRnum = page*countList;
            int startListRnum = endListRnum - 14;
            System.out.println("끝 : " +endListRnum);
            System.out.println("시작 : " +startListRnum);
             try {
                if(opt == null) {//검색 안했을때
                   sql="SELECT * FROM ( \r\n" + 
                            "SELECT ROW_NUMBER() OVER(ORDER BY b_idx DESC) AS rnum,\r\n" + 
                            "m.nickName, b.b_key, b.id, b.b_idx, b.b_date, b.bHit, b.ca_num,b.state, b.b_order,b.b_subject\r\n" + 
                            "FROM bbs b,member m WHERE b.id =m.id and ca_num=? ORDER BY b_order DESC, b_idx DESC)\r\n" + 
                            "WHERE rnum>=? and rnum<=?";
                      
                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, Integer.parseInt(caNum));
                        ps.setInt(2, startListRnum);
                        ps.setInt(3, endListRnum);
                        
                }else if(opt.equals("0")) {//제목
                   sql="SELECT * FROM ( \r\n" + 
                         "SELECT ROW_NUMBER() OVER(ORDER BY b_idx DESC) AS rnum,\r\n" + 
                         "m.nickName, b.b_key, b.id, b.b_idx, b.b_date, b.bHit, b.ca_num,b.state, b.b_order,b.b_subject\r\n" + 
                         "FROM bbs b,member m WHERE b.id =m.id and b.ca_num=? and b.b_subject like ? ORDER BY b_order DESC, b_idx DESC)\r\n" + 
                         "WHERE rnum>=? and rnum<=?";

                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, Integer.parseInt(caNum));
                        ps.setString(2, '%'+condition+'%');
                        ps.setInt(3, startListRnum);
                        ps.setInt(4, endListRnum);
                        
                }else if(opt.equals("1")) {//내용
                   sql="SELECT * FROM ( \r\n" + 
                            "SELECT ROW_NUMBER() OVER(ORDER BY b_idx DESC) AS rnum,\r\n" + 
                            "m.nickName, b.b_key, b.id, b.b_idx, b.b_date, b.bHit, b.ca_num,b.state, b.b_order,b.b_subject\r\n" + 
                            "FROM bbs b,member m WHERE b.id =m.id and b.ca_num=? and b.b_content like ? ORDER BY b_order DESC, b_idx DESC)\r\n" + 
                            "WHERE rnum>=? and rnum<=?";

                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, Integer.parseInt(caNum));
                        ps.setString(2, '%'+condition+'%');
                        ps.setInt(3, startListRnum);
                        ps.setInt(4, endListRnum);
                        
                }else if(opt.equals("2")) {//제목+내용
                   sql="SELECT * FROM ( \r\n" + 
                            "SELECT ROW_NUMBER() OVER(ORDER BY b_idx DESC) AS rnum,\r\n" + 
                            "m.nickName, b.b_key, b.id, b.b_idx, b.b_date, b.bHit, b.ca_num,b.state, b.b_order,b.b_subject\r\n" + 
                            "FROM bbs b,member m WHERE b.id =m.id and b.ca_num=? and (b.b_subject like ? AND b.b_content like ?) ORDER BY b_order DESC, b_idx DESC)\r\n" + 
                            "WHERE rnum>=? and rnum<=?";

                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, Integer.parseInt(caNum));
                        ps.setString(2, '%'+condition+'%');
                        ps.setString(3, '%'+condition+'%');
                        ps.setInt(4, startListRnum);
                        ps.setInt(5, endListRnum);
                        
                }else {//닉네임
                   sql="SELECT * FROM ( \r\n" + 
                            "SELECT ROW_NUMBER() OVER(ORDER BY b_idx DESC) AS rnum,\r\n" + 
                            "m.nickName, b.b_key, b.id, b.b_idx, b.b_date, b.bHit, b.ca_num,b.state, b.b_order,b.b_subject\r\n" + 
                            "FROM bbs b,member m WHERE b.id =m.id and b.ca_num=? and m.nickName like ? ORDER BY b_order DESC, b_idx DESC)\r\n" + 
                            "WHERE rnum>=? and rnum<=?";

                        ps = conn.prepareStatement(sql);
                        ps.setInt(1, Integer.parseInt(caNum));
                        ps.setString(2, '%'+condition+'%');
                        ps.setInt(3, startListRnum);
                        ps.setInt(4, endListRnum);
                }
                
               rs = ps.executeQuery();
               while(rs.next()) {
                  
                  BoardDTO dto = new BoardDTO();
                  dto.setB_key(rs.getInt("b_key"));
                  dto.setId(rs.getString("id"));
                  dto.setB_idx(rs.getInt("b_idx"));
                  dto.setB_subject(rs.getString("b_subject"));
                  dto.setNickName(rs.getString("nickName"));
                  dto.setB_date(rs.getDate("b_date"));
                  dto.setbHit(rs.getInt("bHit"));
                  dto.setCa_num(rs.getInt("ca_num"));
                  dto.setB_order(rs.getInt("b_order"));
                  dto.setState(rs.getInt("state"));
                  
                  String csql = "select count(decode(b_key,?,1)) as c_count from coment";
                  PreparedStatement ps1 = conn.prepareStatement(csql);
                  ps1.setInt(1, rs.getInt("b_key"));
                  ResultSet rs1 = ps1.executeQuery();
                  if(rs1.next()){
                     dto.setC_count(rs1.getInt("c_count"));
                  }
                  rs1.close();
                  ps1.close();
                  
                  list.add(dto);
               }

            } catch (Exception e) {
               e.printStackTrace();
               return null;
            }finally {
               try {
                  rs.close();
                  ps.close();
                  conn.close();
               } catch (Exception e) {
                  e.printStackTrace();
               }
            }
            return list;
         }

      //글쓰기 페이지 요청
         public String writeForm(String id) {
            String sql="SELECT nickName FROM member WHERE id=?";
            String nickName = null;
            try {
               ps = conn.prepareStatement(sql);
               ps.setString(1, id);
               rs = ps.executeQuery();
               if(rs.next()) {
                  nickName = rs.getString("nickName");
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
            return nickName;
         }
      
         //글 등록하기 요청
         public int write(BoardDTO dto) {

            int success = 0;
            String sql ="INSERT INTO bbs(b_key,id,b_idx,b_subject,b_content,ca_num,b_order) VALUES(bbs_seq.NEXTVAL,?,free_seq.NEXTVAL,?,?,?,?)";
            //tip_seq
            if(dto.getCa_num() == 1){
               sql ="INSERT INTO bbs(b_key,id,b_idx,b_subject,b_content,ca_num,b_order) VALUES(bbs_seq.NEXTVAL,?,tip_seq.NEXTVAL,?,?,?,?)";
            }
            try {
               ps = conn.prepareStatement(sql,new int[] {1}); //실행쿼리,집어넣고나서 첫번째 컬럼(b_key)을 반환해라
               
               System.out.println(dto.getId());
               System.out.println(dto.getB_subject());
               System.out.println( dto.getB_content());
               System.out.println(dto.getCa_num());

               ps.setString(1, dto.getId());
               ps.setString(2, dto.getB_subject());
               ps.setString(3, dto.getB_content());
               ps.setInt(4, dto.getCa_num());
               ps.setInt(5, dto.getB_order());
               
               
               success = ps.executeUpdate();
               rs = ps.getGeneratedKeys(); //반환한 값(b_key)을 받아줌
               if(rs.next()) {
                  long fk = rs.getLong(1); //int는 간혹 에러가 남
                  System.out.println("FK : "+fk);
                  sql = "INSERT INTO photo VALUES(photo_seq.NEXTVAL,?,?,?)";
                  ps = conn.prepareStatement(sql);
                  ps.setLong(1, fk);
                  ps.setString(2, dto.getOriFileName());
                  ps.setString(3, dto.getNewFileName());
                  success = ps.executeUpdate();
               }
            } catch (SQLException e) {
               e.printStackTrace();
               return 0;
            }finally {
               try {
                  rs.close();
                  ps.close();
                  conn.close();
               } catch (SQLException e) {
                  e.printStackTrace();
               }
            }
            return success;
         }

      //상세보기 요청
      public BoardDTO detail(int bkey) {
         BoardDTO dto = new BoardDTO();
         String sql="SELECT * FROM bbs WHERE b_key=?";
         try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bkey);
            rs = ps.executeQuery();
            if(rs.next()) {
               upHit(bkey);
               dto.setId(rs.getString("id"));
               dto.setB_idx(rs.getInt("b_idx"));
               dto.setB_subject(rs.getString("b_subject"));
               dto.setB_content(rs.getString("b_content"));
               dto.setB_key(rs.getInt("b_key"));
               
               String newFileName = fileNameCall(bkey);
               if(newFileName !=null) {
                  System.out.println(newFileName);
                  dto.setNewFileName(newFileName);
               }
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
         
         return dto;
      }
      
         //조회수 올리기
         private void upHit(int bkey) {
         String sql="UPDATE bbs SET bHit = bHit+1 WHERE b_key = ?";
            
         try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bkey);
            ps.executeUpdate();
         } catch (SQLException e) {
               e.printStackTrace();
            }
            
         }

      //파일이름 가져오기
      public String fileNameCall(int bkey) {
         String newFileName = null;
         String sql = "SELECT newFileName FROM photo WHERE b_key=?";
         try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bkey);
            rs = ps.executeQuery();
            newFileName = rs.next() ? rs.getString(1) : null; 
         } catch (SQLException e) {
            e.printStackTrace();
         }
         System.out.println("파일이름가져오기 : "+newFileName);
         return newFileName;
         }

      //글삭제 요청
      public int delete(int bkey) {
         int success = 0;
         
         String sql="DELETE FROM bbs WHERE b_key=?";
         
         try {         
            ps = conn.prepareStatement(sql);
            ps.setInt(1, bkey);
            success = ps.executeUpdate();
         } catch (SQLException e) {
            e.printStackTrace();
            return 0;
         }finally {
            try {
               rs.close();
               ps.close();
               conn.close();
            } catch (SQLException e) {}
         }      
         return success;
      }

      //수정하기
      public void update(BoardDTO dto) {
         String sql = "UPDATE bbs SET b_subject=?, b_content=? WHERE b_key=?";
         try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, dto.getB_subject());
            ps.setString(2, dto.getB_content());
            ps.setInt(3, dto.getB_key());
            ps.executeUpdate();
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
         
      }
      
      public void fileNameCall(String delFileName,BoardDTO dto) {
         try {
         if(delFileName != null) { //기존 파일이 있는가?
            String sql = "UPDATE photo SET newFileName = ? WHERE b_key = ?";
            
               ps = conn.prepareStatement(sql);
               ps.setString(1, dto.getNewFileName());
               ps.setInt(2, dto.getB_key());
            }else {//기존 파일이 없는가?
               String sql="INSERT INTO photo VALUES(photo_seq.NEXTVAL,?,?,?)";
               ps = conn.prepareStatement(sql);
               ps.setInt(1, dto.getB_key());
               ps.setString(2, dto.getOriFileName());
               ps.setString(3, dto.getNewFileName());
               }
               ps.executeUpdate();
         } catch (SQLException e) {
               e.printStackTrace();
         }finally{
            try {
               ps.close();
               conn.close();
            } catch (SQLException e) {
               e.printStackTrace();
            }
         }

      }
      //댓글 작성 요청
            public int comCreat(String id, String bKey, String content) {
               int success = 0;
               
               String sql = "INSERT INTO coment(c_idx,id,b_key,c_content)VALUES(com_seq.NEXTVAL,?,?,?)";
               try {
                  ps = conn.prepareStatement(sql);
                  ps.setString(1, id);
                  ps.setString(2, bKey);
                  ps.setString(3, content);
                  
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
            
            //댓글 리스트 요청
            public ArrayList<BoardDTO> comList(String bKey, String id, HttpServletRequest request) {
               
                  ArrayList<BoardDTO> list = new  ArrayList<BoardDTO>();
                  
                  String sql = "SELECT c.c_idx,c.id,c.c_content,c.c_date,c.b_key,m.nickName FROM coment c, member m WHERE c.b_key = ? AND m.id=c.id ORDER BY c.c_date DESC";
                  
                  try {
                     
                     ps = conn.prepareStatement(sql);
                     ps.setInt(1, Integer.parseInt(bKey));
                     rs = ps.executeQuery();
                     
                     while(rs.next()) {
                        
                        BoardDTO dto = new BoardDTO();
                        dto.setC_idx(rs.getInt("c_idx"));
                        dto.setId(rs.getString("id"));
                        dto.setB_key(rs.getInt("b_key"));
                        dto.setC_content(rs.getString("c_content"));
                        dto.setC_date(rs.getString("c_date"));
                        dto.setNickName(rs.getString("nickName"));
                        list.add(dto);
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
            
            //댓글삭제
            public void comDel(String cIdx) {
               
               String sql = "DELETE FROM coment WHERE c_idx=?";
               try {
                  ps = conn.prepareStatement(sql);
                  ps.setInt(1, Integer.parseInt(cIdx));
                  ps.executeUpdate();
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
            }
            
            public void blind(String b_key) {
               String sql = "UPDATE bbs SET state=1 WHERE b_key=?";
               try {
                  ps = conn.prepareStatement(sql);
                  ps.setString(1, b_key);
                  ps.executeUpdate();
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
            }
            
            public void blindcancel(String idx) {
               String sql = "UPDATE bbs SET state=0 WHERE b_key=?";
               try {
                  ps = conn.prepareStatement(sql);
                  ps.setString(1, idx);
                  ps.executeUpdate();
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
            }
            //DB에 등록된 개시글 총 개수
            public int boardCount(String caNum, String opt, String condition) {
               int totalCount = 0;
               
               String sql = null;

               try {
                  if(opt ==null || opt.equals("")) {//첫 리스트
                     sql = "SELECT COUNT(*) as totalCount FROM bbs WHERE ca_num = ?";
                     ps = conn.prepareStatement(sql);
                     ps.setInt(1, Integer.parseInt(caNum));
                  }else if(opt.equals("0")) {//제목
                     sql = "SELECT COUNT(*) as totalCount FROM bbs WHERE b_subject like ? AND ca_num = ?";
                     ps = conn.prepareStatement(sql);
                     ps.setString(1, '%'+condition+'%');
                     ps.setInt(2, Integer.parseInt(caNum));
                  }else if(opt.equals("1")) {//내용
                     sql = "SELECT COUNT(*) as totalCount FROM bbs WHERE b_content like ? AND ca_num = ?";
                     ps = conn.prepareStatement(sql);
                     ps.setString(1, '%'+condition+'%');
                     ps.setInt(2, Integer.parseInt(caNum));
                  }else if(opt.equals("2")) {//내용+제목
                     sql = "SELECT COUNT(*) as totalCount FROM bbs WHERE (b_subject like ? OR b_content like ?) AND ca_num = ?";
                     ps = conn.prepareStatement(sql);
                     ps.setString(1, '%'+condition+'%');
                     ps.setString(2, '%'+condition+'%');
                     ps.setInt(3, Integer.parseInt(caNum));
                  }else {//닉네임
                     sql = "SELECT COUNT(*) as totalCount FROM bbs b,member m WHERE m.id=b.id AND m.nickName like ? AND b.ca_num = ?";
                     ps = conn.prepareStatement(sql);
                     ps.setString(1, '%'+condition+'%');
                     ps.setInt(2, Integer.parseInt(caNum));
                  }
                  
                  rs = ps.executeQuery();
                  
                  if(rs.next()) {
                     totalCount = rs.getInt("totalCount");
                  }
                  
               }catch (SQLException e) {
                  e.printStackTrace();
               }finally {
                  try {
                     rs.close();
                     ps.close();
                     conn.close();
                  } catch (SQLException e) {e.printStackTrace();}
               }
               return totalCount;
            }
      
}