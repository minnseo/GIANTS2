package kr.spring.ticket.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.GameVO;
import kr.spring.ticket.vo.GradeVO;
import kr.spring.ticket.vo.SeatStatusVO;
import kr.spring.ticket.vo.SeatVO;
import kr.spring.ticket.vo.TicketVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TicketAdminController {
	@Autowired
	private TicketService ticketService;
	
	// javaBean(VO) 초기화
	@ModelAttribute
	public GameVO initGame() { return new GameVO(); }
	@ModelAttribute
	public GradeVO initGrade() { return new GradeVO(); }
	
	/* ----- [Grade] 좌석등급 목록 -----*/
	@RequestMapping("/ticket/gradeList.do")
	public String gradeList(GradeVO gradeVO, Model model) {
		int count = ticketService.selectGradeCount(gradeVO);		
		
		List<GradeVO> list = ticketService.selectGradeList(gradeVO);
				
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		
		return "gradeList";
	}
	
	/* ----- [Grade] 좌석등급 등록 -----*/
	// 등록 form
	@GetMapping("/ticket/gradeWrite.do")
	public String gradeForm() { return "gradeWrite"; }
	
	// 전송된 데이터 처리
	@PostMapping("/ticket/gradeWrite.do")
	public String gradeSubmit(@Valid GradeVO gradeVO, BindingResult result) {
		if(result.hasErrors()) { return gradeForm(); }
		
		ticketService.insertGrade(gradeVO);
		
		return "redirect:/ticket/gradeList.do";
	}
	
	/* ----- [Grade] 좌석등급 수정 -----*/
	// 수정 form
	@GetMapping("/ticket/gradeUpdate.do")
	public String gradeUpdateForm(@RequestParam int grade_num, Model model) {
		GradeVO gradeVO = ticketService.selectGrade(grade_num);
		model.addAttribute(gradeVO);
		
		return "gradeUpdate";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/ticket/gradeUpdate.do")
	public String gradeUpdateSubmit(@Valid GradeVO gradeVO, BindingResult result, HttpServletRequest request, Model model) {
		if(result.hasErrors()) { return "gradeUpdate"; }
		
		ticketService.updateGrade(gradeVO);
		
		model.addAttribute("message", "수정 완료");
		model.addAttribute("url", request.getContextPath() + "/ticket/gradeList.do");
		
		return "common/resultView"; 
	}
	
	/* ----- [Grade] 좌석등급 삭제 -----*/
	@RequestMapping("/ticket/gradeDelete.do")
	public String gradeDelete(@RequestParam int grade_num) {
		List<SeatVO> seatVO = ticketService.selectSeatByG(grade_num);
		
		for(SeatVO seat : seatVO) {
			ticketService.deleteSeatStatusByG(seat.getGrade_num());
			ticketService.deleteSeat(seat.getGrade_num());
		}
		
		ticketService.deleteGrade(grade_num);
		
		return "redirect:/ticket/gradeList.do";
	}
	
	/* ----- [Seat] 좌석정보 등록 ----- */
	@PostMapping("/ticket/seatWrite.do")
	public String seatSubmit(SeatVO seatVO, @RequestParam int grade_num) {
		seatVO.setGrade_num(grade_num);
		
		ticketService.insertSeat(seatVO);
		ticketService.updateGradeQuantity(grade_num);
		
		return "redirect:/ticket/seatList.do?grade_num=" + grade_num;
	}
	
	/* ----- [Seat] 좌석정보 상세 -----*/
	@RequestMapping("/ticket/seatList.do")
	public ModelAndView seatList(@RequestParam int grade_num, SeatVO seatVO) {
		GradeVO grade = ticketService.selectGrade(grade_num);
		
		int count = ticketService.selectSeatCount(seatVO);
		//int quantity = ticketService.selectSeatQuantity(grade_num);
		
		List<SeatVO> list = ticketService.selectSeatList(seatVO);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("seatList");
		mav.addObject("grade", grade);
		mav.addObject("count", count);
		mav.addObject("list", list);
		//mav.addObject("quantity", quantity);
		
		return mav;
	}
	
	
	/* ----- [Seat] 좌석정보 수정 -----*/
	@PostMapping("/ticket/seatUpdate.do")
	public String seatUpdateSubmit(SeatVO seatVO, @RequestParam int seat_num, @RequestParam int grade_num) {
		ticketService.updateSeat(seatVO);
		ticketService.updateGradeQuantity(grade_num);
		
		return "redirect:/ticket/seatList.do?grade_num=" + grade_num;
	}
	
	/* ----- [Seat] 좌석관리 -----*/
	@GetMapping("/ticket/seatEditForm.do")
	public String seatEditForm(@RequestParam int seat_num, Model model) {
		SeatVO seat = ticketService.selectSeat(seat_num);
		
		model.addAttribute("seat", seat);
		
		return "seatEditForm";
	}
	
	@RequestMapping("/ticket/seatEditForm.do")
	@ResponseBody
	public Map<String, Object> seatEditAjax(@RequestParam int seat_num) {
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		List<SeatStatusVO> list = ticketService.selectStatusBySeat(seat_num);
		mapJson.put("list", list);
		
		return mapJson;
	}
	
	@PostMapping("/ticket/seatEdit.do")
	public String seatEdit(SeatStatusVO statusVO, @RequestParam int status_num) {
		int statusNum = ticketService.selectStatusNum();
		
		SeatStatusVO status = new SeatStatusVO();
		
		int count = statusVO.getSeat_info().split(",").length;
		for(int i = 0; i < count; i++) {
			status.setStatus_num(statusNum);
			status.setSeat_num(statusVO.getSeat_num());
			status.setGrade_num(statusVO.getGrade_num());
			status.setSeat_info(statusVO.getSeat_info().split(",")[i]);
			status.setSeat_auth(statusVO.getSeat_auth());
			
			if(statusVO.getSeat_auth() == 2) { ticketService.insertSeatStatus(status); }
			else if(statusVO.getSeat_auth() == 0) { ticketService.deleteAdminStatus(status_num); }
		}
		
		/*
		 *  
		 * status.setSeat_num(seat_num); status.setGrade_num(grade_num);
		 * status.setSeat_info(seat_info); status.setSeat_auth(0);
		 */
		
		return "redirect:/ticket/seatEditForm.do?seat_num=" + statusVO.getSeat_num(); 
	}
	
	/* ----- [Game] 경기 등록 -----*/
	// 등록 form
	@GetMapping("/ticket/gameWrite.do")
	public String gameForm() { return "gameWrite"; }
	
	// 전송된 데이터 처리
	@PostMapping("/ticket/gameWrite.do")
	public String gameSubmit(@Valid GameVO gameVO, BindingResult result) {
		if(result.hasErrors()) { return gameForm(); }
		
		ticketService.insertGame(gameVO);
				
		return "redirect:/ticket/gameList.do";
	}
	
	/* ----- [Game] 경기 수정 -----*/
	// 등록 form
	@GetMapping("/ticket/gameUpdate.do")
	public String gameUpdateForm(@RequestParam int game_num, Model model) {
		GameVO gameVO = ticketService.selectGame(game_num);
		model.addAttribute(gameVO);
		
		return "gameUpdate";
	}
	
	// 전송된 데이터 처리
	@PostMapping("/ticket/gameUpdate.do")
	public String gameUpdateSubmit(@Valid GameVO gameVO, BindingResult result, HttpServletRequest request, Model model) {
		if(result.hasErrors()) { return "gameUpdate"; }
		
		if(gameVO.getGame_state() == 3) { ticketService.updateTicketByGameStatus(gameVO.getGame_num()); }
		
		ticketService.updateGame(gameVO);
		
		model.addAttribute("message", "수정 완료");
		model.addAttribute("url", request.getContextPath() + "/ticket/gameList.do");
		
		return "common/resultView";
	}
	
	/*	==========================
	 *		(기업) QR주문확인 - ticketQRcode.jsp
	 * 	==========================*/
	//기업이 QR코드를 찍었다고 가정하여, 이 페이지를 방문하였을 경우 
	//QR코드가 유효한지 확인하여 상태를 변경하고 해당 회원의 주문 내역을 출력하는 페이지로 이동
	@RequestMapping("/ticket/ticketQRcode.do")
	public String companyCheckQR(@RequestParam String ticket_num, HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//모든 조건을 확인한 후 해당 주문번호에 대해 QR상태를 업데이트 함
		ticketService.updateOrderStatus(ticket_num);
		
		//출력페이지용 데이터 적재
		TicketVO ticket = ticketService.selectTicket(ticket_num);
		model.addAttribute("ticket_num", ticket_num);
		model.addAttribute("ticket", ticket);
		
		return "afterCheckQR";
	}
}
