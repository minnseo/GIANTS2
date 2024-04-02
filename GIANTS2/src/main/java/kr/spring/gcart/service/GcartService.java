package kr.spring.gcart.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import kr.spring.gcart.vo.GcartVO;

public interface GcartService {
	// 장바구니 등록
	public void insertCart(GcartVO cart);

	// 회원번호 별 총 구매액
	public int getTotalByMem_num(Map<String, Object> map);
	
	// 적립 예정 포인트
	public int getTotalByPoint(Map<String, Object> map);
	// 장바구니 목록
	public List<GcartVO> getListCart(Map<String, Object> map);

	// 장바구니 등록 시 상품 굿즈 재고 변경
	// public void updateGoodsStockFromCart();

	// 장바구니 상세
	public GcartVO getCart(GcartVO cart);

	// 장바구니 수정(개별 상품 수량 설정)
	public void updateCart(GcartVO cart);

	// 장바구니 상품 번호와 회원번호 별 수정
	public void updateCartByItem_num(GcartVO cart);

	// 장바구니 선택 삭제
	public void deleteCart(int cart_num);
	
	// 장바구니 전체 삭제
	public void deleteCartAll(int mem_num);

	// 옵션과 상품 번호로 재고 가져오기 - 굿즈쪽으로 나중에 보내기
	public int getStockByoption(int goods_num, int opt_num);
}
