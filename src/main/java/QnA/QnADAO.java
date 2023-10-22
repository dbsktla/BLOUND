package QnA;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class QnADAO {
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url ="jdbc:oracle:thin:@localhost:1521:orcl";
	String dbid="jspid";
	String dbpw="jsppw";
	Connection conn = null ;
	PreparedStatement ps = null;
	ResultSet rs = null;

	private static QnADAO bdao;

	public static QnADAO getInstance() {
		if(bdao==null) {
			bdao = new QnADAO();
			System.out.println("객체 생성");
		}
		return bdao;
	}

	private QnADAO() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,dbid,dbpw);
			System.out.println(1);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}//

	public int getArticleCount(){

		int count = 0;
		String sql = "select count(*) as cnt from board";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} try {
			if(ps != null)
				ps.close();
			if(rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("전체 레코드 갯수:" + count);
		return count;
	}//getArticleCount


	public ArrayList<QnABean> getArticles(int start, int end){
		//		1페이지 : 1,5
		//		2페이지 : 6,10

		ArrayList<QnABean> lists = new ArrayList<QnABean>();

		//3.sql문 작성, 분석
		String sql = "select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip " ;		        
		sql += "from (select rownum as rank, num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from (select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip ";
		sql += "from board  ";
		sql += "order by ref desc, re_step asc )) ";
		sql += "where rank between ? and ? ";	


		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,start);
			ps.setInt(2,end);

			if (ps != null)
				System.out.println("SQL문 분석 성공");
			else
				System.out.println("SQL문 분석 실패");

			//4.sql문 실행
			rs = ps.executeQuery();
			if (rs != null)
				System.out.println("select 실행 성공");
			else
				System.out.println("select 실행 실패");

			while(rs.next()){
				QnABean qb = new QnABean();

				qb.setNum(rs.getInt("num"));
				qb.setWriter(rs.getString("writer"));
				qb.setEmail(rs.getString("email"));
				qb.setSubject(rs.getString("subject"));
				qb.setPasswd(rs.getString("passwd"));
				qb.setReg_date(rs.getTimestamp("reg_date"));
				qb.setReadcount(rs.getInt("ref"));
				qb.setReadcount(rs.getInt("readcount"));
				qb.setRe_step(rs.getInt("re_step"));
				qb.setRe_level(rs.getInt("re_level"));
				qb.setContent(rs.getString("content"));
				qb.setIp(rs.getString("ip"));

				lists.add(qb);
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			//5.자원 반납
			try {
				if(ps != null)
					ps.close();
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return lists;
	}//getArticles

	//원글쓰기
	public int insertArticle(QnABean qb) { // 5+2
		int cnt = -1;
		System.out.println("insertArticle");
		String sql = "insert into board(num,writer,subject,email,content,passwd,reg_date,ref,re_step,re_level,ip) "
				+ "values(board_seq.nextval,?,?,?,?,?,?,board_seq.currval,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, qb.getWriter());
			ps.setString(2, qb.getSubject());
			ps.setString(3, qb.getEmail());
			ps.setString(4, qb.getContent());
			ps.setString(5, qb.getPasswd());
			ps.setTimestamp(6, qb.getReg_date());
			ps.setInt(7, 0); // re_step
			ps.setInt(8, 0); // re_level
			ps.setString(9, qb.getIp());

			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;

	}//insertArticle

	public QnABean getArticleByNum(String num) {

		String sql2 = "update board set readcount = readcount+1 where num=?";


		QnABean qb = new QnABean();
		String sql = "select * from board where num=?";
		try {

			ps = conn.prepareStatement(sql2);
			ps.setString(1, num);
			ps.executeUpdate();

			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				qb.setNum(rs.getInt("num"));
				qb.setWriter(rs.getString("writer"));
				qb.setEmail(rs.getString("email"));
				qb.setSubject(rs.getString("subject"));
				qb.setPasswd(rs.getString("passwd"));
				qb.setReg_date(rs.getTimestamp("reg_date"));
				qb.setReadcount(rs.getInt("readcount"));
				qb.setRef(rs.getInt("ref"));
				qb.setRe_step(rs.getInt("re_step"));
				qb.setRe_level(rs.getInt("re_level"));
				qb.setContent(rs.getString("content"));
				qb.setIp(rs.getString("ip"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}  finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return qb;
	}//getArticleByNum

	public QnABean getContentByNum(String num){

		QnABean qb = new QnABean();
		String sql = "select * from board where num=?";
		try {

			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				qb.setNum(rs.getInt("num"));
				qb.setWriter(rs.getString("writer"));
				qb.setEmail(rs.getString("email"));
				qb.setSubject(rs.getString("subject"));
				qb.setPasswd(rs.getString("passwd"));
				qb.setReg_date(rs.getTimestamp("reg_date"));
				qb.setReadcount(rs.getInt("readcount"));
				qb.setRef(rs.getInt("ref"));
				qb.setRe_step(rs.getInt("re_step"));
				qb.setRe_level(rs.getInt("re_level"));
				qb.setContent(rs.getString("content"));
				qb.setIp(rs.getString("ip"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}  finally {
			try {
				if(ps!=null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return qb;
	}

	public int updateArticle(QnABean qb){ // 5+1
		System.out.println(qb.getPasswd()); // 수정form에서 입력한 비번

		int cnt = -1;

		String sql = "select passwd from board where num=?";
		String sql2 = "update board set writer=?, email=?, "
				+ "subject=?,content=? where num=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qb.getNum());
			rs = ps.executeQuery();
			if(rs.next()) {
				String dbpw = rs.getString("passwd");
				if(dbpw.equals(qb.getPasswd())) { // 입력한비번 == db비번

					ps = conn.prepareStatement(sql2);
					ps.setString(1, qb.getWriter());
					ps.setString(2, qb.getEmail());
					ps.setString(3, qb.getSubject());
					ps.setString(4, qb.getContent());
					ps.setInt(5, qb.getNum());
					cnt = ps.executeUpdate();

				}else {

				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return cnt;
	}//updateArticle

	public int deleteArticle(String num, String passwd) {
		String sql = "select passwd from board where num=?";
		String sql2 = "delete board where num=?";
		int cnt = -1;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, num);
			rs = ps.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("passwd"); 
				if(dbpw.equals(passwd)) { // 입력한비번 == db비번
					ps = conn.prepareStatement(sql2);
					ps.setString(1, num);
					cnt = ps.executeUpdate();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();

				if(rs!=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}//deleteArticle
	
	public int replyArticle(QnABean qb){
		//10가지 정보가 넘어옴
//		7가지 : 답글
//		3가지 : 부모정보(ref,re_step,re_level)
//		
//		update~
//		insert 
		int re_step,re_level,cnt = -1;
		
		String sql = "update board set re_step=re_step+1 where ref=? and re_step>?";
		String sql2 = "insert into board(num,writer,subject,email,content,passwd,reg_date,ref,re_step,re_level,ip) "
				+ "values(board_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, qb.getRef());
			ps.setInt(2, qb.getRe_step());
			ps.executeUpdate();
			
			re_step = qb.getRe_step() + 1;
			re_level = qb.getRe_level() + 1;

			ps = conn.prepareStatement(sql2);
			ps.setString(1, qb.getWriter());
			ps.setString(2, qb.getSubject());
			ps.setString(3, qb.getEmail());
			ps.setString(4, qb.getContent());
			ps.setString(5, qb.getPasswd());
			ps.setTimestamp(6, qb.getReg_date());
			ps.setInt(7, qb.getRef()); // ref
			ps.setInt(8, re_step); // re_step
			ps.setInt(9, re_level); // re_level
			ps.setString(10, qb.getIp());
			cnt = ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)
					ps.close();

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
}
