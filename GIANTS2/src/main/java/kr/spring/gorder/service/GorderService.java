package kr.spring.gorder.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.gcart.vo.GcartVO;
import kr.spring.gorder.vo.GorderDetailVO;
import kr.spring.gorder.vo.GorderVO;

public interface GorderService {
	//바로구매 시 장바구니 null체크 
	public List<GcartVO> CheckCartToDirectBuy(int mem_num);
		
	//월 별 굿즈이름, 판매량
	public  List<GorderDetailVO> orderMonth(String year);
	
	//총 매출
	public int allTotal();
	public List<GorderVO> getListSale();
	
	//카테고리 count
	public List<GorderDetailVO> countCategory();
	
	//원래 상품명 읽어오기
	public String dbGoodsName(int goods_num);
	
	
	
	// 주문 등록
	// 포인트 누적해주기
	public void insertOrder(GorderVO order, List<GorderDetailVO> list); // Mapper에서는 order, orderDetail 따로 처리
	public void updatePoint(int mem_num);

	// 포인트 사용하기
	public void usingPoint(int mem_point, int mem_num);
	
	
	// 관리자 - 전체/검색 레코드 수
	public int selectOrderCount(Map<String, Object> map);

	// 관리자 - 전체/검색 목록
	public List<GorderVO> selectListOrder(Map<String, Object> map);

	// 사용자 - 전체/검색 레코드 수
	public int selectOrderCountByMem_num(Map<String, Object> map);

	// 사용자 - 전체/검색 목록
	public List<GorderVO> selectListOrderByMem_num(Map<String, Object> map);

	// 관리자/사용자 - 주문상세
	public GorderVO selectOrder(int order_num);

	// 관리자/사용자 - 개별상품목록
	public List<GorderDetailVO> selectListOrderDetail(int order_num);

	// 관리자/사용자 - 배송지수정
	public void updateOrder(GorderVO order);

	// 관리자 - 주문상태수정
	public void updateOrderStatus(GorderVO order);
	
	//주문 취소 시 상품 수량 돌려주기
	public void updateGoodsQuantity(GorderDetailVO orderDetailVO);

	//주문 취소 시 포인트 돌려주기
	public void rollbackPoint(int used_point, int mem_num);

}
