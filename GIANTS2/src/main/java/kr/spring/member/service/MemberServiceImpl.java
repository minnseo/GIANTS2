package kr.spring.member.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.member.dao.MemberMapper;
import kr.spring.member.vo.CompanyDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.vo.TicketVO;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		memberMapper.insertMember(member);
		memberMapper.insertMember_detail(member);
	}
	
	@Override 
	public void insertCompany(MemberVO member) {
		member.setMem_num(memberMapper.selectMem_num());
		memberMapper.insertCompany(member);
		memberMapper.insertCompany_detail(member);
	}
	
	@Override
	public MemberVO selectCheckMember(String id) {
		return memberMapper.selectCheckMember(id);
	}

	@Override
	public MemberVO selectMember(Integer mem_num) {
		return memberMapper.selectMember(mem_num);
	}
	
	@Override
	public MemberVO selectCompany(Integer mem_num) {
		return memberMapper.selectCompany(mem_num);
	}

	@Override
	public void updateMember_detail(MemberVO member) {
		memberMapper.updateMember_detail(member);
	}
	
	@Override
	public void updateCompany(MemberVO member) {
		memberMapper.updateCompany_detail(member);
	}
	
	@Override
	public void updateAu_id(String au_id, int mem_num) {
		memberMapper.updateAu_id(au_id, mem_num);
	}

	@Override
	public MemberVO selectAu_id(String au_id) {
		return memberMapper.selectAu_id(au_id);
	}

	@Override
	public void deleteAu_id(int mem_num) {
		memberMapper.deleteAu_id(mem_num);
	}

	@Override
	public void updateProfile(MemberVO member) {
		memberMapper.updateProfile(member);
	}
	
	@Override
	public void updatePasswd(MemberVO member) {
		memberMapper.updatepasswd(member);
	}

	@Override
	public void deleteMember(Integer mem_num) {
		memberMapper.deleteMember(mem_num);
		memberMapper.deleteMember_detail(mem_num);
	}
	
	@Override
	public void deleteCompany(Integer mem_num) {
		memberMapper.deleteCompany(mem_num);
		memberMapper.deleteCompany_detail(mem_num); 
		
	}

	@Override
	public CompanyDetailVO selectCompanyDetail(String comp_num) {
		return memberMapper.selectCompanyDetail(comp_num);
	}

	@Override
	public void updateComProfile(MemberVO member) {
		memberMapper.updateComProfile(member);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return memberMapper.selectRowCount(map);
	}

	@Override
	public List<MemberVO> selectList(Map<String, Object> map) {
		return memberMapper.selectList(map);
	}
	

	@Override
	public void updateByAdmin(MemberVO memberVO) {
		memberMapper.updateByAdmin(memberVO);
	}

	@Override
	public MemberVO selectCheckMemberNk(String nickname) {
		return memberMapper.selectCheckMemberNk(nickname);
	}

	@Override
	public void updateMemberNk(MemberVO member) {
		memberMapper.updateMemberNk(member);
	}

	@Override
	public MemberVO findMemberId(String mem_name, String mem_phone) {
		return memberMapper.findMemberId(mem_name, mem_phone);
	}
	
	@Override
	public MemberVO findMemberPw(String mem_id, String mem_name, String mem_phone, String mem_email) {
		return memberMapper.findMemberPw(mem_id, mem_name, mem_phone, mem_email);
	}
	
	@Override
	public void changePw(int mem_num, String new_passwd) {
		memberMapper.changePw(mem_num, new_passwd);
	}

	@Override
	public MemberVO findCompanyId(String comp_owner, String comp_phone) {
		return memberMapper.findCompanyId(comp_owner, comp_phone);
	}

	@Override
	public MemberVO findCompanyPw(String mem_id, String comp_owner, String comp_phone, String comp_email) {
		return memberMapper.findCompanyPw(mem_id, comp_owner, comp_phone, comp_email);
	}

	@Override
	public CompanyDetailVO selectCompCp(String comp_num) {
		return memberMapper.selectCompCp(comp_num);
	}

	@Override
	public int selectRowCountCp(String comp_num) {
		return memberMapper.selectRowCountCp(comp_num);
	}

	@Override
	public List<FoodVO> selectListCp(Map<String, Object> map) {
		return memberMapper.selectListCp(map);
	}

	@Override
	public int selectGoodsRowCount(Map<String, Object> map) {
		return memberMapper.selectGoodsRowCount(map);
	}

	@Override
	public List<GoodsVO> selectGoodsList(Map<String, Object> map) {
		return memberMapper.selectGoodsList(map);
	}

	@Override
	public int selectOrderCountFd(Map<String, Object> map) {
		return memberMapper.selectOrderCountFd(map);
	}

	@Override
	public List<F_orderVO> selectListOrderFd(Map<String, Object> map) {
		return memberMapper.selectListOrderFd(map);
	}

	@Override
	public int selectOrderCountByMem_num(Map<String, Object> map) {
		return memberMapper.selectOrderCountByMem_num(map);
	}

	@Override
	public List<F_orderVO> selectListOrderByMem_num(Map<String, Object> map) {
		return memberMapper.selectListOrderByMem_num(map);
	}

	@Override
	public void deleteFood(Integer food_num) {
		memberMapper.deleteFood(food_num);
	}

	@Override
	public F_orderVO selectOrder(String f_order_num) {
		return memberMapper.selectOrder(f_order_num);
	}

	@Override
	public int selectTicketCountByMem_num(Map<String, Object> map) {
		return memberMapper.selectTicketCountByMem_num(map);
	}

	@Override
	public List<TicketVO> selectListTicketByMem_num(Map<String, Object> map) {
		return memberMapper.selectListTicketByMem_num(map);
	}

	@Override
	public F_orderVO selectF_order(Map<String, Object> map) {
		return memberMapper.selectF_order(map);
	}
	
	@Override
	public F_orderVO selectF_orderCp(Map<String, Object> map) {
		return memberMapper.selectF_orderCp(map);
	}

	@Override
	public List<F_order_detailVO> selectListF_orderDetail(String f_order_num) {
		return memberMapper.selectListF_orderDetail(f_order_num);
	}

	@Override
	public int selectAdminTicketCount(Map<String, Object> map) { return memberMapper.selectAdminTicketCount(map); }

	@Override
	public List<TicketVO> selectAdminListTicket(Map<String, Object> map) { return memberMapper.selectAdminListTicket(map); }


	@Override
	public List<F_order_detailVO> selectListOrderDetail(String f_order_num) {
		return memberMapper.selectListOrderDetail(f_order_num);
	}

	@Override
	public void updateItemQuantity(F_order_detailVO orderDetailVO) {
		memberMapper.updateItemQuantity(orderDetailVO);
	}
	
	@Override
	public void updateOrderStatus(F_orderVO order) {
		memberMapper.updateOrderStatus(order);
		//주문취소일 경우만 상품 개수 조정
		if(order.getF_order_status() == 9) {
			List<F_order_detailVO> detailList = memberMapper.selectListOrderDetail(order.getF_order_num());
			for(F_order_detailVO vo : detailList) {
				memberMapper.updateItemQuantity(vo);
			}
		}
	}

}