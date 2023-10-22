package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CategoryDAO {
	private static CategoryDAO cdao;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	
	public static CategoryDAO getInstance() { //싱글톤 패턴
		if(cdao == null) {
			cdao = new CategoryDAO();
		}
		return cdao;
	}
	
	private CategoryDAO(){
		try { //DBCP 방식으로 접속
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
		}
	}//생성자
	
	public int insertCategory(CategoryBean cb) {
		int cnt = -1;
		String sql = "insert into category values(categoryseq.nextval,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, cb.getCode());
			ps.setString(2, cb.getCname());
			
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
	}//insertCategory
	
	public ArrayList<CategoryBean> getAllCategory() {
		ArrayList<CategoryBean> lists = new ArrayList<CategoryBean>();
		String sql = "select * from category order by cnum";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				CategoryBean cb = new CategoryBean();

				cb.setCnum(rs.getInt("cnum"));
				cb.setCode(rs.getString("code"));
				cb.setCname(rs.getString("cname"));
				lists.add(cb);
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
		return lists;
	}//getAllCategory
	
	public CategoryBean getUpdateNum(String cnum) {
		CategoryBean cb = new CategoryBean();
		String sql = "select * from category where cnum="+cnum;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				cb.setCnum(rs.getInt("cnum"));
				cb.setCode(rs.getString("code"));
				cb.setCname(rs.getString("cname"));
			}
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
		return cb;
	}//getUpdateNum
	
	public int updateCategory(CategoryBean cb) {
		int cnt = -1;
		String sql = "update category set code=?, cname=? where cnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, cb.getCode());
			ps.setString(2, cb.getCname());
			ps.setInt(3, cb.getCnum());
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
	}//updateCategory
	
	public int deleteCategory(String cnum) {
		int cnt = -1;
		String sql = "delete category where cnum="+cnum;
		try {
			ps = conn.prepareStatement(sql);
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
	}//deleteCategory
}
