package kr.spring.food.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.food.vo.F_cartVO;
import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.food.vo.Food_reviewVO;
import kr.spring.member.vo.CompanyDetailVO;

@Mapper
public interface FoodMapper {
	//(관리자, 기업)
	//식품등록
	public void insertFood(FoodVO food);
	
	//식품수정
	public void fixFood(FoodVO food);
	
	//식품삭제
	@Delete("DELETE FROM food WHERE food_num=#{food_num}")
	public void deleteFood(Integer food_num);
	
	//---------------------------------------------------------
	//(공용)
	//식품 리스트 페이징
	public List<FoodVO> selectList(Map<String, Object> map);
	public int selectRowCount(String comp_num);
	
	//매장 리스트 페이징
	public List<CompanyDetailVO> selectCompList(Map<String, Object> map);
	public int selectCompRowCount(Map<String, Object> map);
	
	//식품 상세정보
	@Select("SELECT * FROM food WHERE food_num=#{food_num}")
	public FoodVO selectFood(int food_num);
	
	//매장 상세정보
	public CompanyDetailVO selectComp(String comp_num);
	
	//식품 매장후기
	public List<Food_reviewVO> selectReviewList(Map<String, Object> map);
	public int selectReviewRowCount(Map<String, Object> map);
	
	//매장후기 상세정보
	public Food_reviewVO selectFood_Review(Food_reviewVO fr);

	//---------------식품 장바구니 --------------------------------
	//장바구니 목록 조회
	public List<F_cartVO> selectF_cartList(int mem_num);
	
	//장바구니 조회(식품 코드를 이용)
	@Select("SELECT * FROM f_cart WHERE food_num=#{food_num} AND mem_num=#{mem_num}")
	public F_cartVO selectF_cart(F_cartVO f_cartVO);
	
	//장바구니 상품 등록
	public void insertF_cart(F_cartVO f_cartVO);
	
	//장바구니 모두 비우기
	@Delete("DELETE FROM f_cart WHERE mem_num=#{mem_num}")
	public void deleteF_cart(Integer mem_num);
	
	//장바구니 상품 업데이트(추가등록)
	@Update("UPDATE f_cart SET f_cart_quantity=#{f_cart_quantity} WHERE food_num=#{food_num} AND mem_num=#{mem_num}")
	public void updateF_cartByFood_num(F_cartVO f_cartVO);
	
	//장바구니 아이템 1개 삭제
	@Delete("DELETE FROM f_cart WHERE cart_num=#{cart_num}")
	public void deleteOneF_cart(Integer cart_num);
	
	//---------------식품 주문 --------------------------------
	//장바구니에서 주문한 총 금액 불러오기
	public int selectTotalByMem_num(Map<String,Object> map);
	//주문할 상품 목록 장바구니에서 호출
	public List<F_cartVO> selectF_cartListForOrder(Map<String,Object> map);

	//식품 주문등록하기
	public void insertF_order(F_orderVO f_order);
	public void insertF_order_detail(F_order_detailVO fod);
	//재고수 업데이트
	@Update("UPDATE food SET food_quantity=food_quantity-#{order_quantity} WHERE food_num=#{food_num}")
	public void updateFoodQuantity(F_order_detailVO fod);
	//주문 상품 장바구니에서 제거
	@Delete("DELETE FROM f_cart WHERE food_num=#{food_num} AND mem_num=#{mem_num}")
	public void deleteFodF_cart(@Param(value="food_num") Integer food_num,
								@Param(value="mem_num") Integer mem_num);
	
	//식품 주문(영수증)목록
	public List<F_orderVO> selectOrderList(Map<String, Object> map);
	public int selectOrderRowCount(Map<String,Object> map);
	
	//식품 주문(영수증)상세정보
	public F_orderVO selectF_order(Map<String,Object> map);
	@Select("SELECT * FROM f_order WHERE f_order_num=#{f_order_num}")
	public F_orderVO selectF_orderByNum(String f_order_num);
	//식품 주문 개별상세정보 
	@Select("SELECT * FROM f_order_detail WHERE f_order_num=#{f_order_num}")
	public List<F_order_detailVO> selectListF_orderDetail(String f_order_num);
	
	// (기업) QR코드 승인 및 업데이트 처리
	@Update("UPDATE f_order SET f_order_status=0 WHERE f_order_num=#{f_order_num}")
	public void updateF_orderStatus(String f_order_num);
	
	//------------------식품 리뷰--------------------------
	//리뷰 등록하기
	public void insertFoodReview(Food_reviewVO review);
	@Update("UPDATE f_order SET f_order_status=2 WHERE f_order_num=#{f_order_num}")
	public void updateF_orderStatusByReview(String f_order_num);
	
	//리뷰 삭제하기
	@Delete("DELETE FROM food_review WHERE review_num=#{review_num}")
	public void deleteReview(int review_num);
	
	//리뷰 상세정보
	@Select("SELECT * FROM food_review WHERE review_num=#{review_num}")
	public Food_reviewVO selectReview(int review_num);
	
	
}
