package kr.spring.food.service;

import java.util.List;
import java.util.Map;

import kr.spring.food.vo.F_cartVO;
import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.food.vo.Food_reviewVO;
import kr.spring.member.vo.CompanyDetailVO;

public interface FoodService {
	//(관리자, 기업)
	//식품등록
	public void insertFood(FoodVO food);
	
	//식품수정
	public void fixFood(FoodVO food);
	
	//식품삭제
	public void deleteFood(Integer food_num);
	
	//---------------------------------------------------------
	//(유저)
	//식품 리스트 페이징
	public List<FoodVO> selectList(Map<String, Object> map);
	public int selectRowCount(String comp_num);
	
	//매장 리스트 페이징
	public List<CompanyDetailVO> selectCompList(Map<String, Object> map);
	public int selectCompRowCount(Map<String, Object> map);
	
	//식품 매장후기
	public List<Food_reviewVO> selectReviewList(Map<String, Object> map);
	public int selectReviewRowCount(Map<String, Object> map);
	
	//식품 상세정보
	public FoodVO selectFood(int food_num);
	
	//매장 상세정보
	public CompanyDetailVO selectComp(String comp_num);
	
	//------------ 장바구니 ----------------------------------
	//회원의 장바구니 목록 조회
	public List<F_cartVO> selectF_cartList(int mem_num);
	//회원의 장바구니 조회(식품코드를 통해)
	public F_cartVO selectF_cart(F_cartVO f_cartVO);
	//장바구니 상품 등록
	public void insertF_cart(F_cartVO f_cartVO);
	//장바구니 모두 비우기
	public void deleteF_cart(Integer mem_num);
	//장바구니 상품 업데이트(추가등록)
	public void updateF_cartByFood_num(F_cartVO f_cartVO);
	//장바구니 아이템 1개 삭제
	public void deleteOneF_cart(Integer cart_num);
	
	//------------ 주문하기 ----------------------------------
	//장바구니에서 주문한 총 금액 불러오기
	public int selectTotalByMem_num(Map<String,Object> map);
	//주문할 상품 목록 장바구니에서 호출
	public List<F_cartVO> selectF_cartListForOrder(Map<String,Object> map);
	//식품 주문등록하기
	public void insertF_order(F_orderVO f_order, List<F_order_detailVO> list);
	
	//식품 주문(영수증)목록
	public List<F_orderVO> selectOrderList(Map<String, Object> map);
	public int selectOrderRowCount(Map<String,Object> map);
	
	//식품 주문(영수증)상세정보
	public F_orderVO selectF_order(Map<String,Object> map);
	public F_orderVO selectF_orderByNum(String f_order_num);
	//식품 주문 개별상세정보 
	public List<F_order_detailVO> selectListF_orderDetail(String f_order_num);
	
	// (기업) QR코드 승인 및 업데이트 처리
	public void updateF_orderStatus(String f_order_num);
	
	//------------------식품 리뷰--------------------------
	//리뷰 등록하기
	public void insertFoodReview(Food_reviewVO review);
	//리뷰 등록 후, 스탯 변경
	public void updateF_orderStatusByReview(String f_order_num);
	//리뷰 삭제하기
	public void deleteReview(int review_num);
	//리뷰 상세보기
	public Food_reviewVO selectReview(int review_num);
}
