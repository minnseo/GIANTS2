package kr.spring.goods.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import kr.spring.goods.service.GoodsService;
import kr.spring.goods.vo.GoodsAnswerVO;
import kr.spring.goods.vo.GoodsFavVO;
import kr.spring.goods.vo.GoodsOptionVO;
import kr.spring.goods.vo.GoodsQnaVO;
import kr.spring.goods.vo.GoodsReviewVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.gorder.vo.GorderDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GoodsController {
	@Autowired
	private GoodsService goodsService;
	
	/*==========================
	 * 자바빈(VO) 초기화
	 *==========================*/
	@ModelAttribute
	public GoodsVO initCommand() {
		return new GoodsVO();
	}
	
	@ModelAttribute
	public GoodsReviewVO initCommand2() {
		return new GoodsReviewVO();
	}
	
	@ModelAttribute
	public GoodsQnaVO initCommand3() {
		return new GoodsQnaVO();
	}
	
	@ModelAttribute
	public GorderDetailVO initCommmand4() {
		return new GorderDetailVO();
	}
	
	@ModelAttribute
	public GoodsFavVO initCommmand5() {
		return new GoodsFavVO();
	}
	
	/*==========================
	 * 굿즈 등록
	 *==========================*/
	//등록 폼
	@GetMapping("/goods/registerGoods.do")
	public String form() {
		return "goodsRegister";
	}
	
	//전송된 데이터 처리
	@PostMapping("/goods/registerGoods.do")
	public String submit(@Valid GoodsVO goodsVO, BindingResult result, Model model,
							HttpServletRequest request, HttpSession session) {
		
		if(goodsVO.getGoods_photo().length >= 5*1024*1024) {//5MB
			result.rejectValue("goods_photo", "limitUploadSize", new Object[] {"5MB"}, null);
		}
				
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		goodsService.insertGoods(goodsVO);
		
		model.addAttribute("message", "상품등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/member/adminMypageGoodsList.do");

		return "common/resultView";
	}
	
	/*==========================
	 * 이미지 출력
	 *==========================*/
	@RequestMapping("/goods/imageView.do")
	public ModelAndView viewImage(@RequestParam int goods_num) {
		
		GoodsVO goodsVO = goodsService.selectGoods(goods_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		mav.addObject("imageFile", goodsVO.getGoods_photo());
		mav.addObject("filename", goodsVO.getGoods_photoname());
		
		return mav;
	}
	
	@RequestMapping("/goods/imageView2.do")
	public ModelAndView viewImage2(@RequestParam int review_num) {
		
		GoodsReviewVO reviewVO = goodsService.selectGoodsReview(review_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		mav.addObject("imageFile", reviewVO.getReview_photo());
		mav.addObject("filename", reviewVO.getReview_photoname());
		
		return mav;
	}

	
	/*==========================
	 * [일반회원] 굿즈 목록
	 *==========================*/
	@RequestMapping("/goods/goodsList.do")
	public ModelAndView getGoodsList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
									 @RequestParam(value="order", defaultValue="1") int order,
									 @RequestParam(value="goods_category", defaultValue="0") int goods_category,
									 String keyfield, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("goods_status", 2); 
		
		//전체|검색 레코드 수
		map.put("order", order);
		map.put("goods_category", goods_category);
		int count = goodsService.selectGoodsRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 12, 10, "goodsList.do", "&goods_category=" + goods_category);
		 
		List<GoodsVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = goodsService.selectGoodsList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("goodsList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		
		mav.addObject("page", page.getPage());
		
		return mav;
	}	
	
	/*==========================
	 * 굿즈 상세페이지
	 *==========================*/
	@RequestMapping("/goods/goodsDetail.do")
	public ModelAndView getGoodsDetail(@RequestParam int goods_num) {
		
		//상품 상세
		GoodsVO goods = goodsService.selectGoods(goods_num);

		int total_stock = goodsService.getGoodsTotalStock(goods_num);
		
		List<GoodsOptionVO> list = null;
		list = goodsService.selectOptionList(goods_num);
		
		//상품명에 태그를 허용하지 않음
		goods.setGoods_name(StringUtil.useNoHtml(goods.getGoods_name()));
		
		float avg_score = goodsService.getAvgScore(goods_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("goodsView");
		mav.addObject("goods", goods);
		mav.addObject("option", list);
		mav.addObject("avg_score", avg_score);
		mav.addObject("total_stock", total_stock);
		
		return mav;
	}
	
	/*==========================
	 * 굿즈 상세 - 리뷰 페이징 처리
	 *==========================*/
	@RequestMapping("/goods/reviewList.do")
	@ResponseBody
	public Map<String, Object> getReviewListAjax(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowCount", defaultValue="5") int rowCount,
									@RequestParam int goods_num, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("goods_num", goods_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//리뷰 레코드 수
		int count = goodsService.selectGreviewRowCount(goods_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 10, null);
		
		
		List<GoodsReviewVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = goodsService.selectGoodsReviewList(map);
		}else {
			list = Collections.emptyList(); //비어있는 배열
		}
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		mapJson.put("goods_num", goods_num);
		mapJson.put("page", page.getPage());
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		return mapJson;
	}
	
	/*==========================
	 * 굿즈 상세 - 리뷰 레코드 수
	 *==========================*/
	@RequestMapping("/goods/reviewListCountAjax.do")
	@ResponseBody
	public Map<String, Object> getReviewCountAjax(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowCount", defaultValue="5") int rowCount,
									@RequestParam int goods_num, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("goods_num", goods_num);
		
		//리뷰 레코드 수
		int count = goodsService.selectGreviewRowCount(goods_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 10, null);
				
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("result", "success");
		mapJson.put("page", page.getPage());
		
		return mapJson;
	}
	
	/*==========================
	 * 굿즈 상세 - 문의 페이징 처리
	 *==========================*/
	@RequestMapping("/goods/qnaList.do")
	@ResponseBody
	public Map<String, Object> getQnaListAjax(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowCount", defaultValue="5") int rowCount,
									@RequestParam int goods_num, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("goods_num", goods_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//리뷰 레코드 수
		int count = goodsService.selectGoodsQnaCount(goods_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 10, null);
		
		
		List<GoodsQnaVO> list = null;
		
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = goodsService.selectGoodsQnaList(map);
		}else {
			list = Collections.emptyList(); //비어있는 배열
		}
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		mapJson.put("goods_num", goods_num);
		mapJson.put("page", page.getPage());
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		return mapJson;
	}
	
	/*==========================
	 * 굿즈 상세 - 문의 레코드 수
	 *==========================*/
	@RequestMapping("/goods/qnaListCountAjax.do")
	@ResponseBody
	public Map<String, Object> getQnaCountAjax(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									@RequestParam(value="rowCount", defaultValue="5") int rowCount,
									@RequestParam int goods_num, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("goods_num", goods_num);
		
		//리뷰 레코드 수
		int count = goodsService.selectGoodsQnaCount(goods_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 10, null);
				
		Map<String, Object> mapJson = new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("result", "success");
		mapJson.put("page", page.getPage());
		
		return mapJson;
	}
	

	/*==========================
	 * [관리자] 굿즈 정보 수정
	 *==========================*/
	//수정 폼 호출
	@GetMapping("/goods/goodsUpdate.do")
	public String formUpdate(@RequestParam int goods_num, Model model) {
		 
		GoodsVO goodsVO = goodsService.selectGoods(goods_num);
		
		List<GoodsOptionVO> list = goodsService.selectOptionList(goods_num);
		
		model.addAttribute("goodsVO", goodsVO);
		model.addAttribute("list", list);
		
		return "goodsModify";	
	}
	
	//전송된 데이터 처리
	@PostMapping("/goods/goodsUpdate.do")
	public String submitUpdate(@Valid GoodsVO goodsVO, BindingResult result, 
								HttpServletRequest request, Model model)	{

		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			//return "goodsModify";
			return formUpdate(goodsVO.getGoods_num(), model);
		}

		//상품 정보 수정
		goodsService.updateGoods(goodsVO);
		
		model.addAttribute("message", "상품 수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/goods/goodsDetail.do?goods_num=" + goodsVO.getGoods_num());
		
		return "common/resultView";
	}
	
	
	/*======굿즈 찜하기=======*/
	//굿즈 좋아요 읽기
	@RequestMapping("/goods/getFav.do")
	@ResponseBody
	public Map<String, Object> getFav(GoodsFavVO fav, HttpSession session){
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인 되지 않은 상태
			mapJson.put("status", "noFav");
		}else { //로그인 된 상태
			//로그인 된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			GoodsFavVO goodsFav = goodsService.selectGoodsFav(fav);
			if(goodsFav != null) {
				mapJson.put("status", "yesFav");
			}else {
				mapJson.put("status", "noFav");
			}
			mapJson.put("count", goodsService.selectGoodsFavCount(fav.getGoods_num()));			
		}
		return mapJson;
	}
	
	//굿즈 찜하기 등록|취소
	@RequestMapping("/goods/writeFav.do")
	@ResponseBody
	public Map<String, Object> writeFav(GoodsFavVO fav, HttpSession session){
		
		Map<String, Object> mapJson = new HashMap<String, Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			//로그인 된 회원번호 셋팅
			fav.setMem_num(user.getMem_num());
			
			GoodsFavVO goodsFav = goodsService.selectGoodsFav(fav);
			if(goodsFav != null) { //등록한 찜하기가 있으면 삭제
				goodsService.deleteGoodsFav(goodsFav.getFav_num());
				
				mapJson.put("result", "success");
				mapJson.put("status", "noFav");
			}else { //등록한 찜하기가 없으면 등록
				goodsService.insertGoodsFav(fav);
				
				mapJson.put("result", "success");
				mapJson.put("status", "yesFav");
			}
			mapJson.put("count", goodsService.selectGoodsFavCount(fav.getGoods_num()));
		}
		return mapJson;
	}
	
	//굿즈 찜하기 목록 표시
	@RequestMapping("/member/goodsFavList.do")
	public ModelAndView getFavList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
									HttpSession session) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("mem_num", user.getMem_num());
		
		int count = goodsService.selectGoodsFavCountByMem_num(map);
		
		PagingUtil page = new PagingUtil(currentPage, count, 5, 10, null);
		
		List<GoodsFavVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = goodsService.selectGoodsFavList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("goodsFavList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*===============// 굿즈 리뷰 //===============*/	
	
	/*==========================
	 * 리뷰 등록
	 *==========================*/	
	//등록 폼 호출
	@GetMapping("/goods/writeReview.do")
	public String formReview(HttpServletRequest request, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 1);
		map.put("end", 1000000);
		map.put("goods_status", 3);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//List<GoodsVO> goods_list = goodsService.selectGoodsList(map);
		List<GorderDetailVO> order_list = goodsService.selectOrderDetailList(user.getMem_num());
		model.addAttribute("order_list", order_list);
		model.addAttribute("memberVO", user);
		
		int goods_num = Integer.parseInt(request.getParameter("goods_num"));
		request.setAttribute("goods_num", goods_num);
		
		return "reviewWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/goods/writeReview.do")
	public String submitReview(@Valid GoodsReviewVO reviewVO, BindingResult result, 
				HttpServletRequest request, HttpSession session, Model model) {
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return formReview(request, session, model);
		}
		
		//회원번호 셋팅
		reviewVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());
		//IP 셋팅
		reviewVO.setReview_ip(request.getRemoteAddr());
		
		//리뷰 등록
		goodsService.insertGoodReview(reviewVO);
		
		model.addAttribute("message", "리뷰등록이 완료되었습니다");
		model.addAttribute("url", request.getContextPath() + "/goods/goodsDetail.do?goods_num=" + reviewVO.getGoods_num() + "#goods_review");
		
		return "common/resultView";
	}
	
	/*==========================
	 * 리뷰 수정
	 *==========================*/	
	//수정 폼 호출
	@GetMapping("/goods/updateReview.do")
	public String formUpdateReview(@RequestParam int review_num, Model model) {
				
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 1);
		map.put("end", 50);
		map.put("goods_status", 3);
		
		List<GoodsVO> goods_list = goodsService.selectGoodsList(map);
		model.addAttribute("goods_list", goods_list);
		
		GoodsReviewVO reviewVO = goodsService.selectGoodsReview(review_num);
		
		model.addAttribute("goodsReviewVO", reviewVO);
		
		return "reviewModify";
	}
	
	//전송된 데이터 처리
	@PostMapping("/goods/updateReview.do")
	public String submitUpdateReview(@Valid GoodsReviewVO reviewVO, BindingResult result, 
								HttpServletRequest request, Model model) {
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "reviewModify";
		}
		
		//ip 셋팅
		reviewVO.setReview_ip(request.getRemoteAddr());
		//리뷰 수정
		goodsService.updateGoodsReview(reviewVO);
		
		model.addAttribute("message", "리뷰 수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/goods/goodsDetail.do?goods_num=" + reviewVO.getGoods_num() + "#goods_review");
		
		return "common/resultView";
	}
	
	/*==========================
	 * 리뷰 삭제
	 *==========================*/	
	@RequestMapping("/goods/deleteReview.do")
	public String deleteReview(@RequestParam int review_num) {
		
		GoodsReviewVO db_review = goodsService.selectGoodsReview(review_num);
		int goods_num = db_review.getGoods_num();
		
		//리뷰 삭제
		goodsService.deleteGoodsReview(review_num);
		
		return "redirect:/goods/goodsDetail.do?goods_num=" + goods_num + "#goods_review";
	}
	
	
	/*===============// 굿즈 문의 //===============*/	
	
	/*==========================
	 * 상품문의 등록
	 *==========================*/	
	//등록 폼 호출
	@GetMapping("/goods/writeQna.do")
	public String formQna(HttpServletRequest request, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", 1);
		map.put("end", 1000000);
		map.put("goods_status", 3);
		
		List<GoodsVO> goods_list = goodsService.selectGoodsList(map);
		model.addAttribute("goods_list", goods_list);
		model.addAttribute("user", (MemberVO)session.getAttribute("user"));
		
		int goods_num = Integer.parseInt(request.getParameter("goods_num"));
		request.setAttribute("goods_num", goods_num);
		
		return "qnaWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/goods/writeQna.do")
	public String submitQna(@Valid GoodsQnaVO qnaVO, BindingResult result,
							HttpServletRequest request, HttpSession session, Model model) {
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return formQna(request, session, model);
		}
		
		//회원번호 셋팅
		qnaVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());
		//IP 셋팅
		qnaVO.setQna_ip(request.getRemoteAddr());
		
		goodsService.insertGoodsQna(qnaVO);
		
		model.addAttribute("message", "상품문의가 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/goods/goodsDetail.do?goods_num=" + qnaVO.getGoods_num() + "#goods_qna");
		
		return "common/resultView";
	}
	
	/*==========================
	 * 상품문의 상세
	 *==========================*/	
	@RequestMapping("/goods/detailQna.do")
	public ModelAndView getDetailQna(@RequestParam int qna_num) {
		
		//상품문의 상세
		GoodsQnaVO qna = goodsService.selectQna(qna_num);
		
		//제목에 태그를 이용하지 않음
		qna.setQna_title(StringUtil.useNoHtml(qna.getQna_title()));
		
		//내용에 태그 불허
		qna.setQna_content(StringUtil.useBrNoHtml(qna.getQna_content()));
		
		return new ModelAndView("goodsQnaView", "qna", qna);
	}
	
	/*==========================
	 * 상품문의 수정
	 *==========================*/	
	//수정 폼 호출
	@GetMapping("/goods/updateGoodsQna.do")
	public String formUpdateQna(@RequestParam int qna_num, Model model) {
		
		GoodsQnaVO qnaVO = goodsService.selectQna(qna_num);
		
		model.addAttribute("goodsQnaVO", qnaVO);

		return "goodsQnaModify";
	}
	
	//전송된 데이터 처리
	@PostMapping("/goods/updateGoodsQna.do")
	public String submitUpdateQna(@Valid GoodsQnaVO qnaVO, BindingResult result, HttpServletRequest request, Model model) {
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "goodsQnaModify";
		}
		
		//ip 셋팅
		qnaVO.setQna_ip(request.getRemoteAddr());
		//상품문의 수정
		goodsService.updateGoodsQna(qnaVO);
		
		model.addAttribute("message", "상품문의 수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/goods/goodsList.do");
		
		return "common/resultView";
	}

	/*==========================
	 * 상품문의 삭제
	 *==========================*/	
	@RequestMapping("/goods/deleteGoodsQna.do")
	public String submitDeleteQna(@RequestParam int qna_num) {
		
		goodsService.deleteGoodsQna(qna_num);
		
		return "redirect:/goods/goodsList.do";
	}
		
	/*===============// 굿즈 문의 답변 //===============*/
	
	/*==========================
	 * 문의 답변 등록
	 *==========================*/	
	@RequestMapping("/goods/writeAnswer.do")
	@ResponseBody
	public Map<String, String> writeAnswer(GoodsAnswerVO answerVO, HttpSession session, HttpServletRequest request){
		
		Map<String, String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_auth() != 9){
			mapJson.put("result", "notAdmin");
		}else {
			//작성자 회원번호 등록
			answerVO.setMem_num(user.getMem_num());
			answerVO.setMem_id(user.getMem_id());
			//답변 등록
			goodsService.insertGoodsAnswer(answerVO);
			goodsService.updateGoodsQnaStatusDone(answerVO.getQna_num());
			
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	/*==========================
	 * 답변 목록
	 *==========================*/	
	@RequestMapping("/goods/listAnswer.do")
	@ResponseBody
	public Map<String, Object> getAnswerList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, 
											@RequestParam(value="rowCount", defaultValue="5") int rowCount,
											@RequestParam int qna_num, HttpSession session){
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qna_num", qna_num);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//전체 레코드 수
		int count = goodsService.selectGoodsAnswerCount(qna_num);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, rowCount, 1, null);
		
		List<GoodsAnswerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = goodsService.selectListGoodsAnswer(map);
		}else {
			list = Collections.emptyList();
		}
		
		Map<String, Object> mapJson	= new HashMap<String, Object>();
		mapJson.put("count", count);
		mapJson.put("list", list);
		
		//로그인한 회원번호 셋팅
		if(user != null) {
			mapJson.put("user_num", user.getMem_num());
		}
		return mapJson;
	}
	
	/*==========================
	 * 답변 삭제
	 *==========================*/	
	@RequestMapping("/goods/deleteAnswer.do")
	@ResponseBody
	public Map<String, String> deleteAnswer(@RequestParam int gans_num, HttpSession session){
		
		Map<String, String> mapJson	= new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		GoodsAnswerVO db_answer = goodsService.selectGoodsAnswer(gans_num);
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_auth() < 9) {
			mapJson.put("result", "notAdmin");
		}else if(user.getMem_auth() == 9  & user.getMem_num() == db_answer.getMem_num()) {
			goodsService.deleteGoodsAnswer(gans_num);
			
			int tmp_cnt = goodsService.selectGoodsAnswerCount(db_answer.getQna_num());
			if(tmp_cnt < 1) {
				goodsService.updateGoodsQnaStatusNot(db_answer.getQna_num());
			}
			
			mapJson.put("result", "success");
		}else {
			//로그인한 회원번호와 작성자 회원번호 불일치
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
	/*==========================
	 * 답변 수정
	 *==========================*/	
	@RequestMapping("/goods/updateAnswer.do")
	@ResponseBody
	public Map<String, String> modifyAnswer(GoodsAnswerVO answerVO, HttpSession session, HttpServletRequest request){
		
		Map<String, String> mapJson = new HashMap<String, String>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		GoodsAnswerVO db_answer = goodsService.selectGoodsAnswer(answerVO.getGans_num());
		
		if(user == null) {
			mapJson.put("result", "logout");
		}else if(user != null && user.getMem_auth() != 9) {
			mapJson.put("result", "notAdmin");
		}else if(user.getMem_auth() == 9 && user.getMem_num() == db_answer.getMem_num()) {
			goodsService.updateGoodsAnswer(answerVO);
			
			mapJson.put("result", "success");
		}else {
			mapJson.put("result", "wrongAccess");
		}
		return mapJson;
	}
	
	
}
