package kr.spring.news.controller;

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

import kr.spring.member.vo.MemberVO;
import kr.spring.news.service.NewsService;
import kr.spring.news.vo.NewsVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NewsController {
	@Autowired
	private NewsService newsService;
	 
	//자바빈(VO) 초기화
	@ModelAttribute
	public NewsVO initCommand() {
		return new NewsVO();
	}
	
	/*==================
	 * 뉴스 목록
	 *==================*/
	@RequestMapping("/news/newsList.do")
	public ModelAndView getList(@RequestParam(value="pageNum", defaultValue="1") int currentPage,
							@RequestParam(value="order", defaultValue="1") int order,
							String keyfield, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		
		//전체/검색 레코드 수
		int count = newsService.selectNewsCount(map);
		
		log.debug("<<뉴스 count>> : " + count);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield, keyword, currentPage, count, 20, 10, "newsList.do", "&order=" + order);
		
		List<NewsVO> list = null;
		if(count > 0) {
			map.put("order", order);
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = newsService.selectNewsList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("newsList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*==================
	 * 뉴스 작성
	 *==================*/
	//등록 폼
	@GetMapping("/news/newsWrite.do")
	public String form() {
		return "newsWrite";
	}
	
	//전송된 데이터 처리
	@PostMapping("/news/newsWrite.do")
	public String submit(@Valid NewsVO newsVO, BindingResult result,
						 HttpServletRequest request, HttpSession session, Model model) {
		log.debug("<<뉴스 등록>> : " + newsVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return form();
		}
		
		//회원번호 셋팅
		newsVO.setMem_num(((MemberVO)session.getAttribute("user")).getMem_num());
		
		//뉴스 등록
		newsService.insertNews(newsVO);
		
		model.addAttribute("message", "뉴스 등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/news/newsList.do");
		
		return "common/resultView";
	}

	/*==================
	 * 뉴스 상세페이지
	 *==================*/
	@RequestMapping("/news/newsDetail.do")
	public ModelAndView getDetail(@RequestParam int news_num) {
		log.debug("<<뉴스 상세페이지>>" + news_num);
		
		newsService.updateHit(news_num);
		
		//뉴스 상세
		NewsVO news = newsService.selectNews(news_num);
		news.setNews_title(StringUtil.useNoHtml(news.getNews_title()));
				
		return new ModelAndView("newsView", "news", news);
	}
	
	/*==================
	 * 뉴스 수정
	 *==================*/
	//수정 폼 호출 
	@GetMapping("/news/newsUpdate.do")
	public String formUpdate(@RequestParam int news_num, Model model) {
		
		NewsVO newsVO = newsService.selectNews(news_num);
		
		model.addAttribute("newsVO", newsVO);
		
		return "newsModify";
	}
	
	//전송된 데이터 처리
	@PostMapping("/news/newsUpdate.do")
	public String submitUpdate(@Valid NewsVO newsVO, BindingResult result,
								HttpServletRequest request, Model model) {
		log.debug("<<뉴스 수정 - NewsVO>> : " + newsVO);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) {
			return "newsModify";
		}
		
		//뉴스 수정
		newsService.updateNews(newsVO);
		
		model.addAttribute("message", "뉴스 수정 완료!");
		model.addAttribute("url", request.getContextPath() + "/news/newsDetail.do?news_num=" + newsVO.getNews_num());
		
		return "common/resultView";
	}
	
	/*==================
	 * 뉴스 삭제
	 *==================*/
	@RequestMapping("/news/newsDelete.do")
	public String submitDelete(@RequestParam int news_num) {
		log.debug("<<뉴스 삭제 - news_num>>" + news_num);
		
		//뉴스 삭제
		newsService.deleteNews(news_num);
		
		return "redirect:/news/newsList.do";
	}
	
}
