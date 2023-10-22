package shop;

import java.util.Vector;

public class CartBean {
private Vector<ProductBean> clist; //어레이 리스트 하위 객체인 vector로 만들어서 여러 상품 정보를 담아주기
	
	public CartBean() {
		clist = new Vector<ProductBean>();
	}//생성자
	
	//장바구니 담는 메서드
	public void addProduct(String pnum, String oqty) {//상품번호, 주문수량
		//clist 0 : 11번 상품정보
		// 		1 : 14번 상품정보 / 같은 상품을 다시 넣어도 분리되어서 담긴다는 단점이 있음
		
		int pnum_new = Integer.parseInt(pnum);
		int oqty_new = Integer.parseInt(oqty);
		
		//장바구니에 같은 상품이 있는 경우
		for(int i=0;i<clist.size();i++) {
			//clist.get(i).상품번호 == pnum; 
			//clist.get(i).주문수량 += oqty; 
			if(clist.get(i).getPnum() == pnum_new) {
				int cpqty = clist.get(i).getPqty();
					clist.get(i).setPqty(cpqty + oqty_new);
					return;
			}
		}
		
		//장바구니에 없는경우(같은게 없거나 비어있는 경우)
		ProductDAO pdao = ProductDAO.getInstance();
		ProductBean pb = pdao.getProductView(pnum); //번호의 레코드에 해당하는 상품 정보를 가져오기
		pb.setPqty(Integer.parseInt(oqty)); //주문 수량을 재고 수량 자리에 임시로 저장해줌
		clist.add(pb); //가져온 정보를 clist 즉, vector 객체에 넣어주기
		
	}//addProduct
	
	//장바구니 담은 상품 가져오는 메서드
	public Vector<ProductBean> getAllProducts() {
		
		return clist;
	}//getAllProduct
	
	//장바구니에 담은 주문 수량 가져오는 메서드
	public void setEdit(String pnum,String oqty) {
		int pnum_new = Integer.parseInt(pnum);
		int oqty_new = Integer.parseInt(oqty);
		
		for(ProductBean pb : clist) {
			if(pb.getPnum() == pnum_new) {
				if(oqty_new == 0) { //새로 넣은 상품 수량이 0개라면 삭제
					clist.removeElement(pb);
					break;
				}else {
					pb.setPqty(oqty_new);
					break;
				}
			}
		}
	}//setEdit
	
	//장바구니 한 상품 지우기
	public void removeProduct(String pnum) {
		int pnum_new = Integer.parseInt(pnum);
		
		for(ProductBean pb : clist) {
			if(pb.getPnum() == pnum_new) {
					clist.removeElement(pb);
					break;
			}
		}
	}//delCart
	
	//장바구니 상품 전체 삭제
	public void removeAllProduct() {
		clist.removeAllElements();
	}//removeAllProduct
}
