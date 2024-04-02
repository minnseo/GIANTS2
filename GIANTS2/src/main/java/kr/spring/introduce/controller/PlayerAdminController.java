package kr.spring.introduce.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.commu.vo.CommuVO;
import kr.spring.introduce.service.PlayerService;
import kr.spring.introduce.vo.PlayerVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PlayerAdminController {
	@Autowired
	private PlayerService playerService;
	
	//자바빈 초기화
	@ModelAttribute
	public PlayerVO initCommand() {
		return new PlayerVO();
	}
	
	
	/*--------------
	 * 선수 등록
	 *-------------*/
	//등록 폼 
	@GetMapping("/introduce/admin_player.do")
	public String form() {
		return "admin_player";
	}
	
	//전송
	@PostMapping("/introduce/admin_player.do")
	public String submit(@Valid PlayerVO playerVO,
						 BindingResult result,
						 Model model,
						 HttpServletRequest request,
						 HttpSession session) {
		
		log.debug("<<선수 등록>> : " + playerVO);
		
		
		
		if(playerVO.getPlayer_photo().length == 0) {
			result.rejectValue("player_photo", "required");
		}
		
		
		//용량체크 (어노테이션에서 다양하게 체크 못하니까 용량체크는 컨트롤러에서 체크 해주기)
		if(playerVO.getPlayer_photo().length>=5*1024*1024) {//5MB
								//필드명,			에러코드,			에러문구에 전달할 값,	기본 에러 문구			
			result.rejectValue("player_photo", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		playerService.insertPlayer(playerVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "선수 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/introduce/player.do");
		
		
		return "common/resultView";
	}
	
	
	
	
	
	
	
	/*--------------
	 * 선수 정보 수정
	 *-------------*/
	//선수 정보 수정 폼 
	/*
	@GetMapping("/introduce/admin_playerModify.do")
	public String form_modify() {
		return "admin_playerModify";
	}
	
	//전송
	@PostMapping("/introduce/admin_playerModify.do")
	public String submit_modify(@Valid PlayerVO playerVO,
						 BindingResult result,
						 Model model,
						 HttpServletRequest request,
						 HttpSession session) {
		
		log.debug("<<선수 정보 수정>> : " + playerVO);
		
		
		
		if(playerVO.getPlayer_photo().length == 0) {
			result.rejectValue("player_photo", "required");
		}
		
		
		//용량체크 (어노테이션에서 다양하게 체크 못하니까 용량체크는 컨트롤러에서 체크 해주기)
		if(playerVO.getPlayer_photo().length>=5*1024*1024) {//5MB
								//필드명,			에러코드,			에러문구에 전달할 값,	기본 에러 문구			
			result.rejectValue("player_photo", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		playerService.updatePlayer(playerVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "선수 정보 수정이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/introduce/player.do");
		
		
		return "common/resultView";
	}
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*--------------
	 * 선수 정보 수정
	 *-------------*/
	//선수 정보 수정 폼 호출
		@GetMapping("/introduce/admin_playerModify.do")
		public String formModify(@RequestParam int player_num, Model model) {
			PlayerVO playerVO = playerService.selectPlayer(player_num);
			model.addAttribute("playerVO", playerVO);
			 
			return "admin_playerModify";
		}
		
		//전송된 데이터 처리
		@PostMapping("/introduce/admin_playerModify.do")
		public String submitUpdate(@Valid PlayerVO playerVO,
									BindingResult result,
									HttpServletRequest request,
									Model model) {
			log.debug("<<선수 정보 수정 - playerVO>> : " + playerVO);
			
			//유효성 체크 결과 오류가 있으면 폼을 다시 호출
			if(result.hasErrors()) {
				return "admin_playerModify";
			}
			
			//ip 세팅
			//playerVO.setCommu_ip(request.getRemoteAddr());
			
			//글 수정
			playerService.updatePlayer(playerVO);
			
			//View에 표시할 메시지
			model.addAttribute("message", "선수 정보 수정을 완료했습니다.");
			model.addAttribute("url", request.getContextPath()+"/introduce/player.do");
			
			return "common/resultView";
		}
		
		
		
		/*=== 선수 정보 삭제 ===*/
		@RequestMapping("/introduce/admin_playerDelete.do")
		public String submitDelete(@RequestParam int player_num) {
			log.debug("<<선수 정보 삭제 = player_num_num>> : " + player_num);
			
			//글 삭제
			playerService.deletePlayer(player_num);
			
			return "redirect:/introduce/player.do";
		}
	
	
	
	
	
	
	
	
	
}
