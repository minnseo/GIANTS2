package kr.spring.trading.controller;

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

import kr.spring.member.vo.MemberVO;
import kr.spring.trading.service.TradingService;
import kr.spring.trading.vo.TradingMarkVO;
import kr.spring.trading.vo.TradingVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TradingController {
	@Autowired
	private TradingService tradingService;
	
	/*=================
	 * 자바빈(VO) 초기화
	 * ===============*/
	@ModelAttribute
	public TradingVO initCommand() {
		return new TradingVO();
	}
	
	/*=================
	 * 게시판 글 등록
	 * ===============*/
	//등록 폼
	@GetMapping("/trading/tradingWrite.do")
	public String form() {
		return "tradingWrite";  //tiles 설정의 식별자
	}
	//전송된 데이터 처리
	@PostMapping("/trading/tradingWrite.do")
	public String submit(@Valid TradingVO tradingVO, BindingResult result, HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<중고거래 게시판 글쓰기>> : " + tradingVO);
		
		//상품 이미지 유효성 체크
		//MultipartFile -> byte[]로 변환한 경우, 파일을 업로드하지 않으면 byte[]로 생성되고 length는 0임
		if(tradingVO.getTrade_photo().length == 0) {
			result.rejectValue("trade_photo", "required");
		}
		if(tradingVO.getTrade_photo().length >= 5*1024*1024) { //5MB
							// 자바빈의 field명,    error code,  	 	에러 문구에 전달할 값,   기본 에러 문구(null일시 사용x)
			result.rejectValue("trade_photo", "limitUploadSize", new Object[] {"5MB"}, null);
		}
		
		//유효성 체크 결과, 오류가 있을 시 form 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 세팅
						//다운캐스팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		tradingVO.setMem_num(user.getMem_num());
		//IP 세팅
		tradingVO.setTrade_ip(request.getRemoteAddr());
		//글쓰기
		tradingService.insertTrading(tradingVO);
		
		model.addAttribute("message", "글 등록 완료!");
		model.addAttribute("url", request.getContextPath()+"/trading/tradingList.do");
		
		return "common/resultView";
	}
	
	
	/*=================
	 * 게시판 목록
	 * ===============*/
	@RequestMapping("/trading/tradingList.do")
	public ModelAndView getList(@RequestParam(value ="pageNum", defaultValue="1") int currentPage, @RequestParam(value="order",defaultValue="1") int order, String keyfield, String keyword) {

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		// 전체/검색 레코드 수
		int count = tradingService.selectRowCount(map);
		
		log.debug("<<count>> : " + count);
		
		//페이지 처리                                                        	  //row cnt, page cnt, 요청 url, 부가적인 parameter
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "tradingList.do", "&order=" + order);
		
		List<TradingVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = tradingService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("tradingList"); //tiles 설정의 식별자
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	//이미지 출력 
	@RequestMapping("/trading/imageView.do")
	public ModelAndView viewImage(@RequestParam int trade_num) {
		
		TradingVO tradingVO = tradingService.selectTrading(trade_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");

		mav.addObject("imageFile", tradingVO.getTrade_photo());
		mav.addObject("filename", tradingVO.getTrade_photoname());
		
		return mav;
	}
	
	/*=================
	 * 게시판 글 상세
	 * ===============*/
	@RequestMapping("/trading/tradingDetail.do")
	public ModelAndView getDetail(@RequestParam int trade_num) {
		log.debug("<<글 상세 - trade_num>> : " + trade_num);
		
		//해당 글의 조회수 증가
		tradingService.updateHit(trade_num);
		
		//글 상세
		TradingVO trading = tradingService.selectTrading(trade_num);
		
		//제목에 태그를 허용하지 않음
		trading.setTrade_title(StringUtil.useNoHtml(trading.getTrade_title()));
		
		//CKEditor를 사용하지 않을 경우, 내용에 태그 불허
		//trading.setTrade_content(StringUtil.useBrNoHtml(trading.getTrade_content()));
		
								// 	뷰 이름     	 속성명     속성값
		return new ModelAndView("tradingView", "trading", trading);
	}
	
	/*=================
	 * 게시판 글 수정
	 * ===============*/
	//수정 폼 호출
	@GetMapping("/trading/tradingUpdate.do")
	public String formUpdate(@RequestParam int trade_num, Model model) {
		TradingVO tradingVO = tradingService.selectTrading(trade_num);
		model.addAttribute("tradingVO", tradingVO);
		
		return "tradingModify";
	}
	//전송된 데이터 처리
	@PostMapping("/trading/tradingUpdate.do")
	public String submitUpdate(@Valid TradingVO tradingVO, BindingResult result, HttpServletRequest request, Model model) {
		log.debug("<<글 수정>> - TradingVO: " + tradingVO);
		
		//유효성 체크 결과, 오류가 있을 시 form 호출
		if(result.hasErrors()) {
			return "tradingModify";
		}
		
		//ip 세팅
		tradingVO.setTrade_ip(request.getRemoteAddr());
		//글 수정
		tradingService.updateTrading(tradingVO);
		
		//View에 표시할 메시지
		model.addAttribute("message", "글 수정 완료!");
		model.addAttribute("url", request.getContextPath()+"/trading/tradingDetail.do?trade_num=" + tradingVO.getTrade_num());
		
		return "common/resultView";
	}
	
	/*=================
	 * 게시판 글 삭제
	 * ===============*/
	@RequestMapping("/trading/tradingDelete.do")
	public String submitDelete(@RequestParam int trade_num) {
		log.debug("<<글 삭제 - trade_num>> : " + trade_num);
		
		//글 삭제
		tradingService.deleteTrading(trade_num);
		
		return "redirect:/trading/tradingList.do";
	}
	
	/*=================
	 * 게시판 북마크
	 * ===============*/
	//부모글 북마크 읽기
	@RequestMapping("/trading/getMark.do")
	@ResponseBody //ajax 통신
	public Map<String, Object> getMark(TradingMarkVO mark, HttpSession session){
		log.debug("<<게시판 북마크 읽기 = TradingMarkVO>> : " + mark);
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인이 되지 않은 상태
			mapJson.put("status", "noMark");
		} else { //로그인된 회원번호 세팅
			mark.setMem_num(user.getMem_num());
			
			TradingMarkVO tradingMark = tradingService.selectMark(mark);
			if(tradingMark != null) {
				mapJson.put("status", "yesMark");
			} else {
				mapJson.put("status", "noMark");
			}		
		}
		mapJson.put("count", tradingService.selectMarkCount(mark.getTrade_num()));
		
		return mapJson;
	}
	
	//부모글 북마크 등록/삭제 (toggle 형태)
	@RequestMapping("/trading/writeMark.do")
	@ResponseBody
	public Map<String, Object> writeMark(TradingMarkVO mark, HttpSession session){
		log.debug("<<게시판 북마크 등록/삭제 - TradingMarkVO>> : " + mark);
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		} else {
			//로그인된 회원번호 세팅
			mark.setMem_num(user.getMem_num());
			
			TradingMarkVO tradingMark = tradingService.selectMark(mark);
			if(tradingMark != null) {
				tradingService.deleteMark(tradingMark.getMark_num());
				
				mapJson.put("result", "success");
				mapJson.put("status", "noMark");
			} else { //등록된 북마크가 없으면 등록
				tradingService.insertMark(mark);
				
				mapJson.put("result", "success");
				mapJson.put("status", "yesMark");
			}
			mapJson.put("count", tradingService.selectMarkCount(mark.getTrade_num()));
		}
		
		return mapJson;
	}
	
	/*=================
	 * 북마크 목록
	 * ===============*/
	@RequestMapping("/member/bookmarkList.do")
	public ModelAndView getBookmarkList(@RequestParam(value ="pageNum", defaultValue="1") int currentPage, String keyfield, String keyword, HttpSession session) {

			Map<String,Object> map = new HashMap<String,Object>();
			map.put("keyfield", keyfield);
			map.put("keyword", keyword);
			
			MemberVO user = (MemberVO)session.getAttribute("user");
			map.put("mem_num", user.getMem_num());
			
			// 전체/검색 레코드 수
			int count = tradingService.selectBookmarkRowCount(map);
			
			log.debug("<<count>> : " + count);
			
			//페이지 처리                                                        	  //row cnt, page cnt, 요청 url
			PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "bookmarkList.do");
			
			List<TradingVO> list = null;
			if(count > 0) {
				map.put("start", page.getStartRow());
				map.put("end", page.getEndRow());
				
				list = tradingService.selectTradingBookmarkList(map);
			}
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("bookmarkList"); //tiles 설정의 식별자
			mav.addObject("count", count);
			mav.addObject("list", list);
			log.debug("<<list>> : " + list);
			mav.addObject("page", page.getPage());
			
			return mav;
		}
}
