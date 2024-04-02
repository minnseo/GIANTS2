package kr.spring.member.controller;

import java.util.HashMap; 
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.goods.vo.GoodsVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.CompanyDetailVO;
import kr.spring.member.vo.MemberDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberAdminController {
	@Autowired
	private MemberService memberService; 
	
	/*=====================
	 * 관리자 : 회원목록
	 *=====================*/
	@RequestMapping("/member/admin_list.do")
	public ModelAndView getList(
			@RequestParam(value="pageNum",
						  defaultValue="1") int currentPage,
											String keyfield,
											String keyword,
											HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = memberService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page =
				new PagingUtil(keyfield,keyword,currentPage,
							   count,10,10,"admin_list.do");
		
		List<MemberVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectList(map);
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMemberList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*=====================
	 * 일반회원 수정폼
	 *=====================*/
	@GetMapping("/member/admin_updateMem.do")
	public String form(@RequestParam int mem_num, Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);
		model.addAttribute("memberVO", memberVO);
		return "adminMemberModify";
	}
	//전송된 데이터 처리
	@PostMapping("/member/admin_updateMem.do")
	public String submit(MemberVO memberVO, Model model,
						 HttpServletRequest request) {
		
		//회원권한 수정
		memberService.updateByAdmin(memberVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "회원등급 수정 완료");
		model.addAttribute("url", request.getContextPath()
								  + "/member/admin_updateMem.do?mem_num="
								  + memberVO.getMem_num());
		
		return "common/resultView";
	} 
	
	/*=====================
	 * 기업회원 수정폼
	 *=====================*/
	@GetMapping("/member/admin_updateComp.do")
	public String formComp(@RequestParam int mem_num, Model model) {
		MemberVO companyVO = memberService.selectCompany(mem_num);
		model.addAttribute("memberVO", companyVO);
		return "adminCompanyModify";
	}
	//전송된 데이터 처리
	@PostMapping("/member/admin_updateComp.do")
	public String submitComp(MemberVO memberVO, Model model,
						 HttpServletRequest request) {
		
		//회원권한 수정
		memberService.updateByAdmin(memberVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "회원등급 수정 완료");
		model.addAttribute("url", request.getContextPath()
								  + "/member/admin_updateComp.do?mem_num="
								  + memberVO.getMem_num());
		
		return "common/resultView";
	}
	
	/*=====================
	 * 관리자 티켓관리
	 *=====================*/
	@RequestMapping("/member/adminMypageTicket.do")
	public ModelAndView adminMypageTicket(@RequestParam(value="pageNum", defaultValue="1") int currentPage, String keyfield, String keyword, HttpSession session, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		int count = memberService.selectAdminTicketCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 10, "adminMypageTicket.do");
		
		List<TicketVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectAdminListTicket(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMypageTicket");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	/*
	/*=====================
	 * 관리자 굿즈관리
	 *=====================*/
	@RequestMapping("/member/adminMypageGoodsList.do")
	public ModelAndView process(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="goods_category", defaultValue="0") int goods_category,
								String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("goods_status", 3); //status가 3이면 판매중(1), 판매중지(2) 모두 체크
		
		//전체|검색 레코드 수
		map.put("goods_category", goods_category);
		int count = memberService.selectGoodsRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 10, 10, "adminMypageGoodsList.do", "&goods_category=" + goods_category);
		
		List<GoodsVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("order", 1);
			map.put("goods_category", goods_category);
			
			list = memberService.selectGoodsList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("adminMypageGoods");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}		
} 