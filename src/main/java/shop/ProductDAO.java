package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ProductDAO {
	private static ProductDAO pdao;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	
	public static ProductDAO getInstance() {
		if(pdao == null) {
			pdao = new ProductDAO();
		}
		return pdao;
	}//getInstance
	
	private ProductDAO(){
		try { //DBCP 방식으로 접속
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
		}
	}//생성자
	
	public int insertProduct(MultipartRequest mr) {
		int cnt = -1;
		String sql = "insert into product "
				+ "values(productseq.nextval,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, mr.getParameter("pname"));
			
			//pcategory_fk에는 카테고리 코드가 들어가있음. 여기에 pcode를 연결시켜줌(pcode는 db상에 없는 이름)
			String p_fk = mr.getParameter("pcategory_fk");
			p_fk += " / "+mr.getParameter("pcode");
			ps.setString(2, p_fk);//pcategory_fk+pcode
			
			ps.setString(3, mr.getFilesystemName("pimage"));
			ps.setInt(4, Integer.parseInt(mr.getParameter("pqty")));
			ps.setInt(5, Integer.parseInt(mr.getParameter("price")));
			ps.setString(6, mr.getParameter("pcontents"));
			ps.setInt(7, Integer.parseInt(mr.getParameter("point")));
			
			Date d = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(d);
			ps.setString(8, today);
			
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
	}//insertProduct
	
	public ArrayList<ProductBean> getAllProduct() {
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product order by pnum";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductBean pb = new ProductBean();

				pb.setPnum(rs.getInt("pnum"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPqty(rs.getInt("pqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPoint(rs.getInt("point"));
				pb.setPinputdate(rs.getString("pinputdate"));
				lists.add(pb);
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
	
	public int deleteProduct(String pnum) {
		int cnt = -1;
		String sql = "delete product where pnum="+pnum;
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
	}//deleteProduct
	
	public ProductBean getProductView(String pnum) {
		ProductBean pb = new ProductBean();
		String sql = "select * from product where pnum="+pnum;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {

				pb.setPnum(rs.getInt("pnum"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPqty(rs.getInt("pqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPoint(rs.getInt("point"));
				pb.setPinputdate(rs.getString("pinputdate"));
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
		return pb;
	}//getProductView
	
	public int updateProduct(MultipartRequest mr, String img) {
		int cnt = -1;
		String sql = "update product set pname=?,pimage=?,pqty=?,price=?,pcontents=?,point=? where pnum=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mr.getParameter("pname"));
			ps.setString(2, img);
			ps.setString(3, mr.getParameter("pqty"));
			ps.setString(4, mr.getParameter("price"));
			ps.setString(5, mr.getParameter("pcontents"));
			ps.setString(6, mr.getParameter("point"));
			ps.setString(7, mr.getParameter("pnum"));
			
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
	}//updateProduct
	
	public ArrayList<ProductBean> getBycategory(String code) {
		ArrayList<ProductBean> list = new ArrayList<ProductBean>();
		//man양말 < 이런식으로 전에 카테고리+이름으로 설정했음. 따라서 포함됐다 이런식으로 접근
		String sql = "select * from product where pcategory_fk like ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, code+"%"); //earplugs / Study noise%
			rs = ps.executeQuery();
			while (rs.next()) {
				ProductBean pb = new ProductBean();
				pb.setPnum(rs.getInt("pnum"));
				pb.setPname(rs.getString("pname"));
				pb.setPcategory_fk(rs.getString("pcategory_fk"));
				pb.setPimage(rs.getString("pimage"));
				pb.setPqty(rs.getInt("pqty"));
				pb.setPrice(rs.getInt("price"));
				pb.setPcontents(rs.getString("pcontents"));
				pb.setPoint(rs.getInt("point"));
				pb.setPinputdate(rs.getString("pinputdate"));
				list.add(pb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}//getBycategory
	
	public void updatepqty(Vector<ProductBean> clist ) throws SQLException {
		int opqty = 0;
		for(int i=0;i<clist.size();i++) {
			
			String sql = "select pqty from product where pnum=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, clist.get(i).getPnum());
			rs = ps.executeQuery();
			if(rs.next()) {
				opqty = rs.getInt("pqty");
			}
			String sql2 = "update product set pqty=? where pnum=?";
			ps = conn.prepareStatement(sql2);
			ps.setInt(1, opqty - clist.get(i).getPqty());
			ps.setInt(2, clist.get(i).getPnum());
		}
		ps.executeUpdate();
	}//updatepqty
}
