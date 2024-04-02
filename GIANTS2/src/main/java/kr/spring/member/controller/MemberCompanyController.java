package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.CompanyDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberCompanyController {
	@Autowired
	private MemberService memberService;
	 
	/*=====================
	 * 기업회원 푸드목록
	 *=====================*/	
	@RequestMapping("/member/compMypageFoodList.do")
	public ModelAndView compMypageFoodList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
										  HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CompanyDetailVO comp = memberService.selectCompCp(user.getCompanyDetailVO().getComp_num());
		int count = memberService.selectRowCountCp(comp.getComp_num());
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 5, 5, "compMypageFoodList.do");
		
		List<FoodVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("comp_num", comp.getComp_num());
			
			list = memberService.selectListCp(map);
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("compMypageFoodList");
		mav.addObject("comp", comp);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}

	/*====================
	 * 일반회원 푸드구매상세
	 *====================*/
	@RequestMapping("/member/compMypageOrderDetail.do")
	public String compMypageOrderDetail (@RequestParam String f_order_num,
										HttpSession session,
										Model model) {
		
		
		//주문번호(f_order_num)를 통하여 모든 정보를 출력함.
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		map.put("f_order_num", f_order_num);
		map.put("mem_num", user.getMem_num());
		
		//주문정보 호출
		F_orderVO f_order = memberService.selectF_orderCp(map);
		//개별 상품 주문정보 호출
		List<F_order_detailVO> detailList = memberService.selectListF_orderDetail(f_order_num);
		
		model.addAttribute("f_order", f_order);
		model.addAttribute("list", detailList);
		
		return "compMypageOrderDetail";
	}
	
	/*=====================
	 * 식품 삭제
	 *=====================*/
	@PostMapping("/member/deleteFood.do")
	public String submitDeleteFood(@RequestParam int food_num) {

		//식품 삭제
		memberService.deleteFood(food_num);
		
		return "redirect:/member/compMypageFoodList.do";
	}	

	/*=====================
	 * 기업회원 주문내역
	 *=====================*/
	@RequestMapping("/member/compMypageOrderList.do")
	public ModelAndView admin_list(
			      @RequestParam(value="pageNum",
			          defaultValue="1") int currentPage,
			            String keyfield, String keyword,
			            HttpSession session) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		map.put("comp_num", user.getCompanyDetailVO().getComp_num());
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = memberService.selectOrderCountFd(map);
		
		//페이지 처리
		PagingUtil page = 
				new PagingUtil(keyfield,keyword,currentPage,count,20,10,
						 "admin_list.do");
		
		List<F_orderVO> list = null;
		if(count > 0) {
			map.put(keyword, list);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectListOrderFd(map);
		} 
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("compMypageOrderList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*=====================
	 * 기업회원 매출관리
	 *=====================*/
	@RequestMapping("/member/compMypageSaleManage.do")
	public String companyMypageSaleManage(HttpSession session, Model model) {
		
		return "compMypageSaleManage";
	}
		
} 