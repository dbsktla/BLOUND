package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class OrdersDAO {
	private static OrdersDAO odao;
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	
	public static OrdersDAO getInstance() {
		if(odao == null) {
			odao = new OrdersDAO();
		}
		return odao;
	}//getInstance
	
	private OrdersDAO(){
		try { //DBCP 방식으로 접속
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:comp/env");
			DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
		}
	}//생성자
	
	public int insertOrder(int sno, Vector<ProductBean> clist) throws Exception{
		//호출한 쪽으로 예외처리 넘기기
		int cnt = -1;
		for(int i=0;i<clist.size();i++) {
			String sql = "insert into orders values(orderseq.nextval,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, sno);
			ps.setInt(2, clist.get(i).getPnum());
			ps.setInt(3, clist.get(i).getPqty());
			ps.setInt(4, clist.get(i).getPqty()*clist.get(i).getPrice());
			cnt += ps.executeUpdate(); //누적시켜줌
		}
		return cnt;
	}//insertOrder
	
	public Vector<OrdersBean> getOrderList(String memid) throws Exception {
		String sql = "select m.name mname, m.id mid, p.pname, o.qty, o.amount "
				+ "from (orders o inner join member m on m.no = o.memno) inner join product p on o.pnum = p.pnum "
				+ "where id = ?";
		Vector<OrdersBean> lists = new Vector<OrdersBean>();
		ps = conn.prepareStatement(sql);
		ps.setString(1, memid);
		rs = ps.executeQuery();

		while(rs.next()) {
			OrdersBean ob = new OrdersBean();
			ob.setMname(rs.getString("mname"));
			ob.setMid(rs.getString("mid"));
			ob.setPname(rs.getString("pname"));
			ob.setQty(rs.getInt("qty"));
			ob.setAmount(rs.getInt("amount"));
			lists.add(ob);
		}
		return lists;
	}//getOrderList
}
