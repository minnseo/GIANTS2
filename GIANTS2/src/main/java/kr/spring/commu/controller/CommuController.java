package kr.spring.commu.controller;

import java.util.Collections;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.commu.service.CommuService;
import kr.spring.commu.vo.CommuFavVO;
import kr.spring.commu.vo.CommuReplyVO;
import kr.spring.commu.vo.CommuReportVO;
import kr.spring.commu.vo.CommuVO;
import kr.spring.introduce.vo.PlayerVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommuController {
	@Autowired
	private CommuService commuService;
	
	/*=== 자바빈 초기화 ===*/
	@ModelAttribute
	public CommuVO initCommand() {
		return new CommuVO();
	}
	
	/*=== 커뮤니티 글 등록 ===*/
	//등록 폼
	@GetMapping("/commu/write.do")
	public String form() {
		return "commuWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/commu/write.do")
	public String submit(@Valid CommuVO commuVO, BindingResult result, 
						 HttpServletRequest request, HttpSession session, Model model) {
		
		log.debug("<<커뮤니티 글쓰기>> : " + commuVO);
		
		//유효성 체크 결과 오류 발생 시 폼을 다시 호출
		if(result.hasErrors()) {
			return form();
		}
		 
		//회원 번호 세팅 (좀 길지만 한 번만 쓸거라 따로 변수 안 만들고 진행)
		//세션에 저장해놓은 user를 MemberVO로 다운캐스팅, 거기서 mem_num을 가져와서 commuVO의 mem_num에 set
		MemberVO user = (MemberVO)session.getAttribute("user");
		commuVO.setMem_num(user.getMem_num());
		
		//IP 셋팅
		commuVO.setCommu_ip(request.getRemoteAddr());
		
		//글 등록 처리
		commuService.insertCommu(commuVO);
		
		model.addAttribute("message", "글쓰기가 완료되었습니다.");
		model.addAttribute("url", request.getContextPath()+"/commu/commuList.do");
		
		return "common/resultView";
		
	}
	
	/*=== 커뮤니티 목록 ===*/
	@RequestMapping("/commu/commuList.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
								@RequestParam(value="order", defaultValue="1") int order,
								String keyfield, String keyword){
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield",keyfield);
		map.put("keyword",keyword);
		
		//전체or검색 레코드 수
		int count = commuService.selectRowCount(map);
		log.debug("<<count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,10,10,"commuList.do","&order="+order);
		
		List<CommuVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = commuService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("commuList");
		mav.addObject("count",count);
		mav.addObject("list",list);
		mav.addObject("page",page.getPage());
	
	return mav;
	}
	
	
	
	/*=== 커뮤니티 상세 ===*/
	@RequestMapping("/commu/detail.do")
	public ModelAndView getDetail(@RequestParam int commu_num) {
		log.debug("<<글 상세 - commu_num>> : " + commu_num);
		//해당 글의 조회수 증가
		commuService.updateHit(commu_num);
		//글 상세
		CommuVO commu = commuService.selectCommu(commu_num);
		//제목에 태그를 허용하지 않음
		commu.setCommu_title(StringUtil.useNoHtml(commu.getCommu_title()));
		//CKEditor를 사용하지 않을 경우 내용에도 태그를 허용하지 않음
		//board.setContent(StringUtil.useBrNoHtml(board.getContent()));
								//뷰 이름	     속성명 	속성값
		return new ModelAndView("commuView","commu",commu);
	}
	
	
	/*=== 커뮤니티 글 수정 ===*/
	
	//수정 폼 호출
	@GetMapping("/commu/update.do")
	public String formUpdate(@RequestParam int commu_num, Model model) {
		CommuVO commuVO = commuService.selectCommu(commu_num);
		model.addAttribute("commuVO", commuVO);
		 
		return "commuModify";
	}
	
	//전송된 데이터 처리
	@PostMapping("/commu/update.do")
	public String submitUpdate(@Valid CommuVO commuVO,
								BindingResult result,
								HttpServletRequest request,
								Model model) {
		log.debug("<<글 수정 - CommuVO>> : " + commuVO);
		
		//유효성 체크 결과 오류가 있으면 폼을 다시 호출
		if(result.hasErrors()) {
			return "commuModify";
		}
		
		//ip 세팅
		commuVO.setCommu_ip(request.getRemoteAddr());
		
		//글 수정
		commuService.updateCommu(commuVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정을 완료했습니다.");
		model.addAttribute("url", request.getContextPath()+"/commu/detail.do?commu_num="+commuVO.getCommu_num());
		
		return "common/resultView";
	}
	
	/*=== 커뮤니티 글 삭제 ===*/
	@RequestMapping("/commu/delete.do")
	public String submitDelete(@RequestParam int commu_num) {
		log.debug("<<글 삭제 = commu_num>> : " + commu_num);
		
		//글 삭제
		commuService.deleteCommu(commu_num);
		
		return "redirect:/commu/commuList.do";
	}
	
	/*=== 커뮤니티 글 좋아요 ===*/
	//부모글 좋아요 읽어오기
	@RequestMapping("/commu/getFav.do")
	@ResponseBody //ajax통신 이용
	public Map<String,Object> getFav(CommuFavVO fav, HttpSession session){
		log.debug("<<커뮤니티 좋아요 읽기>> : " + fav);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		//로그인 회원 정보 가져옴
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {//로그인x
			mapJson.put("status", "noFav");
		}else {//로그인o
			//로그인된 회원 번호 세팅
			fav.setMem_num(user.getMem_num());
			
			CommuFavVO commuFav = commuService.selectFav(fav);
			if(commuFav != null) {//로그인 회원이 헤당 글에 좋아요 누른 데이터가 있는 경우
				mapJson.put("status", "yesFav");
			}else {//로그인 회원이 해당 좋아요 누른 데이터가 없는 경우
				mapJson.put("status", "noFav");
			}
		}
		mapJson.put("count", commuService.selectFavCount(fav.getCommu_num()));
		
		
		return mapJson;
	}
	
	//부모글 좋아요 등록&삭제
		@RequestMapping("/commu/writeFav.do")
		@ResponseBody
		public Map<String,Object> writeFav(CommuFavVO fav, HttpSession session){
			log.debug("<<게시판 좋아요 등록/삭제 - CommuFavVO>> : " + fav);
			
			Map<String,Object> mapJson = new HashMap<String,Object>();
			
			//로그인 회원 정보 가져옴
			MemberVO user = (MemberVO)session.getAttribute("user");
			if(user == null) { //로그인 X
				mapJson.put("result", "logout");
			}else { //로그인 O
				//로그인된 회원 번호 세팅
				fav.setMem_num(user.getMem_num());
				
				CommuFavVO commuFav = commuService.selectFav(fav);
				if(commuFav != null) { //로그인 회원이 헤당 글에 좋아요 누른 데이터가 있는 경우 -> 삭제
					commuService.deleteFav(commuFav.getCommu_like_num());
					mapJson.put("result", "success");
					mapJson.put("status", "noFav");
				}else { //로그인 회원이 헤당 글에 좋아요 누른 데이터가 없는 경우 -> 등록
					commuService.insertFav(fav);
					mapJson.put("result", "success");
					mapJson.put("status", "yesFav");
				}
				mapJson.put("count", commuService.selectFavCount(fav.getCommu_num()));
			}
	
			return mapJson;
		}
		
		/*=== 댓글 등록 ===*/
		@RequestMapping("/commu/writeReply.do")
		@ResponseBody
		public Map<String,String> writeReply(CommuReplyVO commuReplyVO,
											 HttpSession session,
											 HttpServletRequest request){
			log.debug("<<댓글 등록>> : " + commuReplyVO);
			
			Map<String,String> mapJson = new HashMap<String,String>();
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			if(user == null) { //로그인 X
				mapJson.put("result", "logout");
			}else { //로그인 O
				//회원번호 등록
				commuReplyVO.setMem_num(user.getMem_num());
				//ip 등록
				commuReplyVO.setRe_ip(request.getRemoteAddr());
				//댓글 등록
				commuService.insertReply(commuReplyVO);
				mapJson.put("result", "success");
			}
			
			return mapJson;
		}
		
		
		
		/*=== 댓글 목록 ===*/
		@RequestMapping("/commu/listReply.do")
		@ResponseBody
		public Map<String,Object> getList(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
										  @RequestParam(value="rowCount",defaultValue="10") int rowCount,
										  @RequestParam int commu_num,
										  HttpSession session){
			log.debug("<<currentPage>> : " + currentPage);
			log.debug("<<commu_num>> : " + commu_num);
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("commu_num", commu_num);
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			
			//전체 레코드 수
			int count = commuService.selectRowCountReply(map);
			
			//페이지 처리
			PagingUtil page = new PagingUtil(currentPage,count,rowCount,1,null);
			
			List<CommuReplyVO> list = null;
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				list = commuService.selectListReply(map);
			}else {
				list = Collections.emptyList(); //빈 배열을 만들어 전달
			}
			
			Map<String,Object> mapJson = new HashMap<String,Object>();
			mapJson.put("count", count);
			mapJson.put("list", list);
			
			//로그인한 회원 정보 세팅
			if(user != null) {
				mapJson.put("user_num",user.getMem_num());
			}
			
			return mapJson;
		}
		
		
		/*=== 댓글 삭제 ===*/
		@RequestMapping("/commu/deleteReply.do")
		@ResponseBody //성공했는지 실패했는지 json문자열로 보여주기 위해 설정
		public Map<String,String> deleteReply(@RequestParam int re_num,
											  HttpSession session){
			log.debug("<<re_num>> : " + re_num);
			
			Map<String,String> mapJson = new HashMap<String,String>();
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			CommuReplyVO db_reply = commuService.selectReply(re_num); //작성자 회원 번호를 알기 위해서
			if(user == null) { //로그인 X
				mapJson.put("result", "logout");
			}else if(user != null && user.getMem_num() == db_reply.getMem_num()) { //작성자 본인일 시
				commuService.deleteReply(re_num);
				mapJson.put("result", "success");
			}else { //로그인은 되어있으나 작성자가 아닐 시
				mapJson.put("result", "wrongAccess");
			}
			
			return mapJson;
		}
		
		
		
		/*=== 댓글 수정 ===*/
		@RequestMapping("/commu/updateReply.do")
		@ResponseBody
		public Map<String,String> modifyReply(CommuReplyVO commuReplyVO,
											  HttpSession session,
											  HttpServletRequest request){
			log.debug("<<CommuReplyVO>> : " + commuReplyVO);
			
			Map<String,String> mapJson = new HashMap<String,String>();
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			CommuReplyVO db_reply = commuService.selectReply(commuReplyVO.getRe_num());
			if(user == null) { //로그인 X
				mapJson.put("result", "logout");
			}else if(user != null && user.getMem_num() == db_reply.getMem_num()) { //작성자 본인일 시
				//ip 등록
				commuReplyVO.setRe_ip(request.getRemoteAddr());
				//댓글 수정 처리
				commuService.updateReply(commuReplyVO);
				mapJson.put("result", "success");
			}else { //로그인은 되어있으나 작성자가 아닐 시
				mapJson.put("result", "wrongAccess");
			}
			
			return mapJson;
		}
		
		
	
		/*=== 커뮤니티 신고 ===*/
		@ModelAttribute
		public CommuReportVO initCommand_repo() {
			return new CommuReportVO();
		}
		
		
		//등록 폼
		@GetMapping("/commu/commuRepo.do")
		public String formRepo(@RequestParam int commu_num, Model model) {
			CommuVO vo = commuService.selectCommu(commu_num);
			
			model.addAttribute("commu", vo);
			return "commuRepo";
		}
		
		
		//전송된 데이터 처리
		@PostMapping("/commu/commuRepo.do")
		public String submitRepo(@RequestParam int commu_num, @Valid CommuReportVO commuReportVO, BindingResult result, 
							 HttpServletRequest request, HttpSession session, Model model) {
			
			log.debug("<<커뮤니티 신고>> : " + commuReportVO);
			
			
			
			//유효성 체크 결과 오류 발생 시 폼을 다시 호출
			if(result.hasErrors()) {
				return "commuRepo";
			}
			 
			//회원 번호 세팅 (좀 길지만 한 번만 쓸거라 따로 변수 안 만들고 진행)
			//세션에 저장해놓은 user를 MemberVO로 다운캐스팅, 거기서 mem_num을 가져와서 commuVO의 mem_num에 set
			MemberVO user = (MemberVO)session.getAttribute("user");
			//commuReportVO.setMem_num(user.getMem_num());
			
			
			
			
			//IP 셋팅
			commuReportVO.setRepo_ip(request.getRemoteAddr());
			commuReportVO.setCommu_num(commu_num);
			commuReportVO.setMem_num(user.getMem_num());
			
			
			//글 등록 처리
			commuService.insertReport(commuReportVO);
			
			
			model.addAttribute("message", "해당 게시물 신고가 완료되었습니다.");
			model.addAttribute("url", request.getContextPath()+"/commu/commuList.do");
			
			return "common/resultView";
			
		}
		
		
		
		/*--------------
		 * [관리자]신고 목록
		 *-------------*/
		/*
		@RequestMapping("/commu/commuRepoList.do")
		public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
									String keyfield,String keyword) {
			
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
			//status가 0이면 미표시(1), 표시(2) 모두 체크
			//map.put("status", 0);
			
			//전체/검색 레코드 수
			int count = commuService.selectRowCountReort(map);
			
			//페이지 처리
			PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,20,10,"commuRepoList.do");
			
			List<CommuReportVO> list = null;
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = commuService.selectListReport(map);
			}
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("commuRepoList");
			mav.addObject("count", count);
			mav.addObject("list", list);
			mav.addObject("page", page.getPage());
			
			return mav;
		}
		*/
		
		
		@RequestMapping("/commu/commuRepoList.do")
		public ModelAndView getcommuRepoList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
									@RequestParam(value="order", defaultValue="1") int order,
									String keyfield, String keyword){
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyfield",keyfield);
			map.put("keyword",keyword);
			
			//전체or검색 레코드 수
			int count = commuService.selectRowCountReort(map);
			log.debug("<<count>> : " + count);
			
			//페이지 처리
			PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,20,10,"commuRepoList.do","&order="+order);
			
			List<CommuReportVO> list = null;
			if(count > 0) {
				map.put("order", order);
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = commuService.selectListReport(map);
			}
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("commuRepoList");
			mav.addObject("count",count);
			mav.addObject("list",list);
			mav.addObject("page",page.getPage());
		
		return mav;
		}
		
		
		
		
		
		
		
		/*=== 커뮤니티 신고글 삭제 ===*/
		/* 
		@RequestMapping("/commu/deleteRepo.do")
		public String submitDeleteRepo(@RequestParam int repo_num) {
			log.debug("<<신고 글 삭제 = repo_num>> : " + repo_num);
			
			//글 삭제
			commuService.deleteReport(repo_num);
			
			return "redirect:/commu/commuRepoList.do";
		}
		*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		/*=== 커뮤니티 댓글 신고 ===*/
		
}
