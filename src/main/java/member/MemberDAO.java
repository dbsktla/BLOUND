package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	private static MemberDAO mdao;
	PreparedStatement ps = null;
	ResultSet rs = null;
	Connection conn = null;
	
	private MemberDAO(){
		try { //DBCP 방식으로 접속
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
		}
	}//생성자
	
	//MemberDao 객체를 싱글톤 패턴으로 생성
	public static MemberDAO getInstance() {
		if(mdao==null) {
			mdao = new MemberDAO();
		}
		return mdao;
	}
	
	public MemberBean getMemberInfo(String id, String password) {
		MemberBean member = null;
		String sql = "select * from member where id=? and password=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, password);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				member = getMemberBean(rs);
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
		return member;
	}//getMemberInfo
	
	private MemberBean getMemberBean(ResultSet rs2) throws SQLException {
			
			MemberBean member = new MemberBean();
			member.setNo(rs2.getInt("no"));
			member.setId(rs2.getString("id"));
			member.setPassword(rs2.getString("password"));
			member.setName(rs2.getString("name"));
			member.setPostcode(rs2.getString("postcode"));
			member.setAddress(rs2.getString("address"));
			member.setDetailAddress(rs2.getString("detailAddress"));
			member.setRrn1(rs2.getString("rrn1"));
			member.setRrn2(rs2.getString("rrn2"));
			member.setHp1(rs2.getString("hp1"));
			member.setHp2(rs2.getString("hp2"));
			member.setHp3(rs2.getString("hp3"));
			member.setEmail(rs2.getString("email"));
			member.setJoindate(rs2.getString("joindate"));
		
		return member;
	}//getMemberBean
	
	public boolean searchId(String userid) {
		boolean flag = false;
		String sql = "select * from member where id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			rs = ps.executeQuery();
			if(rs.next()) {
				flag = true;
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
		return flag;
	}//searchId
	
	public int insertMember(MemberBean mb) {
		int cnt = -1;
		String sql = "insert into member values(memberseq.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mb.getId());
			ps.setString(2, mb.getPassword());
			ps.setString(3, mb.getName());
			ps.setString(4, mb.getPostcode());
			ps.setString(5, mb.getAddress());
			ps.setString(6, mb.getDetailAddress());
			ps.setString(7, mb.getRrn1());
			ps.setString(8, mb.getRrn2());
			ps.setString(9, mb.getHp1());
			ps.setString(10, mb.getHp2());
			ps.setString(11, mb.getHp3());
			ps.setString(12, mb.getEmail());
			ps.setString(13, mb.getJoindate());
			
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
	}//insertMember
	
	public MemberBean findId(String name, String rrn1, String rrn2) {
		MemberBean member = null;
		String sql = "select * from member where name=? and rrn1=? and rrn2=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);
			rs = ps.executeQuery();
			
			//찾은 레코드 한줄을 묶음으로 묶기 위해서 메서드화 시켜서 넘겨줌
			if(rs.next()) {
				member = getMemberBean(rs);
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
		//찾으면 memberBean 객체가 리턴되고 못찾으면 null
		return member;
	}//findId
	
	public MemberBean findPw(String name, String id, String rrn1, String rrn2) {
		MemberBean member = null;
		String sql = "select * from member where name=? and rrn1=? and rrn2=? and id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, rrn1);
			ps.setString(3, rrn2);
			ps.setString(4, id);
			rs = ps.executeQuery();
			
			//찾은 레코드 한줄을 묶음으로 묶기 위해서 메서드화 시켜서 넘겨줌
			if(rs.next()) {
				member = getMemberBean(rs);
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
		return member;
	}//findpw
}
