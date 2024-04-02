package kr.spring.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.member.vo.CompanyDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.vo.TicketVO;

@Mapper 
public interface MemberMapper { 
	/*==============
	 *   일반회원
	 *==============*/
	//회원번호생성
	@Select("SELECT MEMBER_DETAIL_seq.nextval FROM dual")
	public int selectMem_num();
	
	//일반회원가입
	@Insert("INSERT INTO MEMBER (mem_num,mem_id,passwd,mem_auth) VALUES (#{mem_num},#{mem_id},#{passwd},#{mem_auth})")
	public void insertMember(MemberVO member);
	public void insertMember_detail(MemberVO member);
	
	//기업회원가입
	@Insert("INSERT INTO MEMBER (mem_num,mem_id,passwd,mem_auth) VALUES (#{mem_num},#{mem_id},#{passwd},#{mem_auth})")
	public void insertCompany(MemberVO member);
	public void insertCompany_detail(MemberVO member);
	
	//ID를 이용한 회원정보 체크
	public MemberVO selectCheckMember(String id);
	public MemberVO selectCheckCompany(String id);
	
	public MemberVO selectCheckMemberNk(String nickname);
	
	//회원번호를 이용한 회원정보 구하기
	public MemberVO selectMember(Integer mem_num);
	public MemberVO selectCompany(Integer mem_num);
	
	@Select("SELECT * FROM company_detail WHERE comp_num=#{comp_num}")
	public CompanyDetailVO selectCompanyDetail(String comp_num);
	 
	//회원정보수정
	public void updateMember(MemberVO member);
	@Update("UPDATE MEMBER SET mem_nickname=#{mem_nickname} WHERE mem_num=#{mem_num}")
	public void updateMemberNk(MemberVO member);
	
	public void updateMember_detail(MemberVO member);
	public void updateCompany_detail(MemberVO member);
	
	//프로필 이미지 업데이트
	@Update("UPDATE MEMBER_DETAIL SET mem_photo=#{mem_photo},mem_photoname=#{mem_photoname} WHERE mem_num=#{mem_num}")
	public void updateProfile(MemberVO member);
	@Update("UPDATE COMPANY_DETAIL SET comp_photo=#{mem_photo},comp_photoname=#{mem_photoname} WHERE mem_num=#{mem_num}")
	public void updateComProfile(MemberVO member);
	
	//비밀번호수정
	@Update("UPDATE MEMBER SET passwd=#{passwd} WHERE mem_num=#{mem_num}")
	public void updatepasswd(MemberVO member);
	
	//회원탈퇴
	@Update("UPDATE MEMBER SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void deleteMember(Integer mem_num);
	@Delete("DELETE FROM MEMBER_DETAIL WHERE mem_num=#{mem_num}")
	public void deleteMember_detail(Integer mem_num);
	
	@Update("UPDATE MEMBER SET mem_auth=0 WHERE mem_num=#{mem_num}")
	public void deleteCompany(Integer mem_num);
	@Delete("DELETE FROM COMPANY_DETAIL WHERE mem_num=#{mem_num}")
	public void deleteCompany_detail(Integer mem_num);
	
	//자동로그인
	@Update("UPDATE MEMBER SET au_id=#{au_id} WHERE mem_num=#{mem_num}")
	public void updateAu_id(@Param("au_id") String au_id,
            				@Param("mem_num") int mem_num);
	@Select("SELECT m.mem_num,m.mem_id,m.mem_auth,m.au_id,m.passwd,m.mem_nickname,d.mem_email FROM MEMBER m JOIN MEMBER_DETAIL d ON m.mem_num=d.mem_num WHERE m.au_id=#{au_id}")
	public MemberVO selectAu_id(String au_id);
	@Update("UPDATE MEMBER SET au_id='' WHERE mem_num=#{mem_num}")
	public void deleteAu_id(int mem_num);
	
	/*==============
	 *   관리자
	 *==============*/
	//회원가입 - 관리자
	public int selectRowCount(Map<String,Object> map);
	public List<MemberVO> selectList(Map<String,Object> map);
	@Update("UPDATE MEMBER SET mem_auth=#{mem_auth} WHERE mem_num=#{mem_num}")
	public void updateByAdmin(MemberVO memberVO);
	
	//아이디 찾기
	public MemberVO findMemberId(String mem_name, String mem_phone);
	public MemberVO findCompanyId(String comp_owner, String comp_phone);
	//비밀번호 찾기
	public MemberVO findMemberPw(String mem_id, String mem_name, String mem_phone, String mem_email);
	public MemberVO findCompanyPw(String mem_id, String comp_owner, String comp_phone, String comp_email);
	public void changePw(int mem_num, String new_passwd);
	
	//기업페이지 - 푸드목록
	public CompanyDetailVO selectCompCp(String comp_num);
	public int selectRowCountCp(String comp_num);
	public List<FoodVO> selectListCp(Map<String, Object> map);
	//식품삭제
	@Delete("DELETE FROM food WHERE food_num=#{food_num}")
	public void deleteFood(Integer food_num);
	
	//관리자페이지 - 굿즈목록
	public int selectGoodsRowCount(Map<String, Object> map);
	public List<GoodsVO> selectGoodsList(Map<String, Object> map);
	
	//기업페이지 - 주문목록
	public int selectOrderCountFd(Map<String,Object> map);
	public List<F_orderVO> selectListOrderFd(Map<String,Object> map);
	
	//마이페이지 - 푸드구매내역
	public int selectOrderCountByMem_num(Map<String,Object> map);
	public List<F_orderVO> selectListOrderByMem_num(Map<String,Object> map);
	public F_orderVO selectF_order(Map<String,Object> map); //식품 주문(영수증)상세정보
	public F_orderVO selectF_orderCp(Map<String,Object> map); //식품 주문(영수증)상세정보
	@Select("SELECT * FROM f_order_detail WHERE f_order_num=#{f_order_num}")
	public List<F_order_detailVO> selectListF_orderDetail(String f_order_num); //식품 주문 개별상세정보	
	
	//마이페이지 - 티켓구매내역
	public int selectTicketCountByMem_num(Map<String,Object> map);
	public List<TicketVO> selectListTicketByMem_num(Map<String,Object> map);
	
	// 관리자페이지 - 티켓목록
	public int selectAdminTicketCount(Map<String, Object> map);
	public List<TicketVO> selectAdminListTicket(Map<String, Object> map);
	
	//관리자/사용자 - 주문상세
	@Select("SELECT * FROM F_ORDER WHERE f_order_num=#{f_order_num}")
	public F_orderVO selectOrder(String f_order_num);
	
	//개별상품목록	
	@Select("SELECT * FROM F_ORDER_DETAIL WHERE f_order_num=#{f_order_num} ORDER BY food_num DESC")
	public List<F_order_detailVO> selectListOrderDetail(String f_order_num);		
	
	//관리자/사용자 - 주문취소시 상품 수량 업데이트
	@Update("UPDATE FOOD SET food_quantity=food_quantity + #{order_quantity} WHERE food_num=#{food_num}")
	public void updateItemQuantity(F_order_detailVO orderDetailVO);	
	
	//관리자/사용자 - 주문상태수정
	@Update("UPDATE F_ORDER SET f_order_status=#{f_order_status} WHERE f_order_num=#{f_order_num}")
	public void updateOrderStatus(F_orderVO order);
}
