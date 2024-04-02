package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.member.vo.CompanyDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.vo.TicketVO;

public interface MemberService {
	//회원가입 - 일반
	public void insertMember(MemberVO member);
	public void insertCompany(MemberVO member);
	
	//ID를 이용한 회원정보 체크
	public MemberVO selectCheckMember(String id);
	public MemberVO selectCheckMemberNk(String nickname);
	
	//회원번호를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);
	public MemberVO selectCompany(Integer mem_num);
	
	public CompanyDetailVO selectCompanyDetail(String comp_num); 
	
	//회원정보 수정 
	public void updateMember_detail(MemberVO member);
	public void updateCompany(MemberVO member);
	public void updateMemberNk(MemberVO member);
	
	//프로필 이미지 업데이트
	public void updateProfile(MemberVO member);
	public void updateComProfile(MemberVO member);
	
	//비밀번호 수정 
	public void updatePasswd(MemberVO member);
	
	//회원탈퇴
	public void deleteMember(Integer mem_num);
	public void deleteCompany(Integer mem_num);
	
	//자동 로그인
	public void updateAu_id(String au_id, int mem_num);
	public MemberVO selectAu_id(String au_id);
	public void deleteAu_id(int mem_num);
	
	/*==============
	 *   관리자
	 *==============*/
	//회원가입 - 관리자
	public int selectRowCount(Map<String,Object> map);
	public List<MemberVO> selectList(Map<String,Object> map);
	public void updateByAdmin(MemberVO memberVO);
	
	//아이디 찾기
	public MemberVO findMemberId(String mem_name, String mem_phone);
	public MemberVO findCompanyId(String comp_owner, String comp_phone);
	//비밀번호 찾기
	public MemberVO findMemberPw(String mem_id, String mem_name, String mem_phone, String mem_email);
	public MemberVO findCompanyPw(String mem_id, String comp_owner, String comp_phone, String comp_email);
	public void changePw(int mem_num, String new_passwd);
	
	//기업페이지 : 푸드목록
	public CompanyDetailVO selectCompCp(String comp_num);
	public int selectRowCountCp(String comp_num);
	public List<FoodVO> selectListCp(Map<String, Object> map);
	
	//관리자페이지 : 굿즈목록
	//전체|검색 상품 레코드수
	public int selectGoodsRowCount(Map<String, Object> map);
	//전체|검색 상품 목록
	public List<GoodsVO> selectGoodsList(Map<String, Object> map);	
	
	//기업페이지 : 푸드목록
	public int selectOrderCountFd(Map<String,Object> map);
	public List<F_orderVO> selectListOrderFd(Map<String,Object> map);
	//식품삭제
	public void deleteFood(Integer food_num);
	
	//마이페이지 - 푸드구매내역
	public int selectOrderCountByMem_num(Map<String,Object> map);
	public List<F_orderVO> selectListOrderByMem_num(Map<String,Object> map);	
	public F_orderVO selectOrder(String f_order_num);
	public void updateOrderStatus(F_orderVO order);
	public List<F_order_detailVO> selectListOrderDetail(String f_order_num);
	public void updateItemQuantity(F_order_detailVO orderDetailVO);	
	public F_orderVO selectF_order(Map<String,Object> map); //식품 주문(영수증)상세정보
	public F_orderVO selectF_orderCp(Map<String,Object> map); //식품 주문(영수증)상세정보
	public List<F_order_detailVO> selectListF_orderDetail(String f_order_num); //식품 주문 개별상세정보	
	  
	// 마이페이지 - 티켓구매내역
	public int selectTicketCountByMem_num(Map<String,Object> map);
	public List<TicketVO> selectListTicketByMem_num(Map<String,Object> map);
	
	// 관리자페이지 - 티켓목록
	public int selectAdminTicketCount(Map<String, Object> map);
	public List<TicketVO> selectAdminListTicket(Map<String, Object> map);
}
