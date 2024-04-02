package kr.spring.gorder.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.gorder.vo.GorderVO;
import kr.spring.gcart.vo.GcartVO;
import kr.spring.gorder.vo.GorderDetailVO;

@Mapper
public interface GorderMapper {
	//바로구매 시 장바구니 null체크 
	@Select("select * from g_cart where mem_num=#{mem_num}")
	public List<GcartVO> CheckCartToDirectBuy(int mem_num);
	
	//===============================
	//주문 목록 모든 리스트
	public List<GorderVO> getListSale();		
	//총 금액
	@Select("select sum(order_total) as order_revenue from g_order where order_status<5")
	public int allTotal();
	
	//원래 상품명 읽어오기
	@Select("select goods_name from goods where goods_num=#{goods_num}")
	public String dbGoodsName(int goods_num);
	
	//월 별 매출
	public  List<GorderDetailVO> orderMonth(String year);
	
	//카테고리 별 count
	public List<GorderDetailVO> countCategory();
	
	
	//==============================
	
	
	// 주문 등록
	@Select("SELECT g_order_seq.nextval FROM dual")
	public int selectOrderNum();
	public void insertOrder(GorderVO order);
	public void insertOrderDetail(GorderDetailVO vo);
	public void updatePoint(int mem_num);
	
	// 포인트 사용 시 차감
	@Update("UPDATE member_detail set mem_point = mem_point - #{used_point} WHERE mem_num = #{mem_num}")
	public void usingPoint(int used_point, int mem_num);

	// 재고수 차감
	@Update("UPDATE goods_option SET goods_stock=goods_stock-#{order_quantity} WHERE goods_num=#{goods_num}")
	public void updateQuantity(GorderDetailVO orderDetailVO);

	// 주문 상품 장바구니에서 제거
	@Delete("DELETE FROM g_cart WHERE goods_num=#{goods_num} AND mem_num=#{mem_num}")
	public void deleteCartItem(@Param(value = "goods_num") Integer goods_num,
											 @Param(value = "mem_num") Integer mem_num);

	// 관리자 - 전체/검색 레코드 수
	public int selectOrderCount(Map<String, Object> map);
	// 관리자 - 전체/검색 목록
	public List<GorderVO> selectListOrder(Map<String, Object> map);

	// 사용자 - 전체/검색 레코드 수
	public int selectOrderCountByMem_num(Map<String, Object> map);
	// 사용자 - 전체/검색 목록
	public List<GorderVO> selectListOrderByMem_num(Map<String, Object> map);

	// 관리자/사용자 - 주문상세
	@Select("SELECT * FROM g_order WHERE order_num=#{order_num}")
	public GorderVO selectOrder(int order_num);
	// 관리자/사용자 - 개별상품목록
	@Select("SELECT * FROM g_order_detail WHERE order_num=#{order_num} ORDER BY goods_num DESC")
	public List<GorderDetailVO> selectListOrderDetail(int order_num);
	// 관리자/사용자 - 배송지 수정
	public void updateOrder(GorderVO order);
	// 관리자/사용자 - 주문상태 수정(주문 취소 시에도 사용)
	@Update("UPDATE g_order SET order_status=#{order_status},order_modifydate=SYSDATE WHERE order_num=#{order_num}")
	public void updateOrderStatus(GorderVO order);

	// 관리자/사용자 - 주문취소 시 상품 수량 업데이트
	@Update("UPDATE goods_option SET goods_stock=goods_stock + #{order_quantity} WHERE goods_num=#{goods_num}")
	public void updateGoodsQuantity(GorderDetailVO orderDetailVO);
	//주문 취소 시 포인트 돌려주기
	@Update("UPDATE member_detail SET mem_point = mem_point + #{used_point} WHERE mem_num = #{mem_num}")
	public void rollbackPoint(int used_point, int mem_num);
	
	public List<GorderDetailVO> selectListByOrder(GorderDetailVO gorderDetailVO);
}
