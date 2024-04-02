package kr.spring.gcart.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.gcart.vo.GcartVO;

@Mapper
public interface GcartMapper {

	// 장바구니 등록
	public void insertCart(GcartVO cart);

	// 회원번호 별 총 구매액
	public int getTotalByMem_num(Map<String, Object> map);

	// 장바구니 목록
	public List<GcartVO> getListCart(Map<String, Object> map);

	// 장바구니 상세
	@Select("SELECT * FROM g_cart  WHERE goods_num=#{goods_num} AND mem_num=#{mem_num}")
	public GcartVO getCart(GcartVO cart);

	//장바구니 수정 (개별 상품 수량 수정)
	@Update("UPDATE g_cart SET order_quantity=#{order_quantity} WHERE cart_num=#{cart_num}")
	public void updateCart(GcartVO cart);

	// 장바구니 상품 번호와 회원번호 별 수정
	@Update("UPDATE g_cart SET order_quantity=#{order_quantity} WHERE goods_num=#{goods_num} AND mem_num=#{mem_num}")
	public void updateCartByItem_num(GcartVO cart);

	// 장바구니 삭제
	@Delete("DELETE FROM g_cart WHERE cart_num=#{cart_num}")
	public void deleteCart(int cart_num);
	
	//장바구니 전체 삭제
	@Delete("DELETE FROM g_cart WHERE mem_num=#{mem_num}")
	public void deleteCartAll(int mem_num);

	// 옵션과 상품 번호로 재고 가져오기 - 굿즈쪽으로 나중에 보내기
	@Select("SELECT goods_stock FROM goods_option WHERE goods_num=#{goods_num} AND opt_num=#{opt_num}")
	public int getStockByoption(int goods_num, int opt_num);
}
