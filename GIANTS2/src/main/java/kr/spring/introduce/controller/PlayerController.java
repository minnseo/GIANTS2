package kr.spring.introduce.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.introduce.service.PlayerService;
import kr.spring.introduce.vo.PlayerVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PlayerController {
	@Autowired
	private PlayerService playerService;
	
	
	//이미지 출력
	@RequestMapping("/introduce/imageView.do")
	public ModelAndView viewImage(@RequestParam int player_num) {
		
		PlayerVO playerVO = playerService.selectPlayer(player_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		mav.addObject("imageFile",playerVO.getPlayer_photo());
		mav.addObject("filename",playerVO.getPlayer_photoname());
	
		return mav;
	}
	
	/*--------------
	 * [일반]선수 목록
	 *-------------*/
	@RequestMapping("/introduce/player.do")
	public ModelAndView process(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								String keyfield,String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//status가 0이면 미표시(1), 표시(2) 모두 체크
		//map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = playerService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,30,1,"player.do");
		
		List<PlayerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = playerService.selectPlayerList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("player");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	/*--------------
	 * [선수 소개]코치
	 *-------------*/
	@RequestMapping("/introduce/playerList_c.do")
	public ModelAndView process_c(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								String keyfield,String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//status가 0이면 미표시(1), 표시(2) 모두 체크
		//map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = playerService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,30,10,"playerList_c.do");
		
		List<PlayerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = playerService.selectPlayerList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("playerList_c");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*--------------
	 * [선수 소개]투수
	 *-------------*/
	@RequestMapping("/introduce/playerList_t.do")
	public ModelAndView process_t(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								String keyfield,String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//status가 0이면 미표시(1), 표시(2) 모두 체크
		//map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = playerService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,30,10,"playerList_t.do");
		
		List<PlayerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = playerService.selectPlayerList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("playerList_t");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*--------------
	 * [선수 소개]포수
	 *-------------*/
	@RequestMapping("/introduce/playerList_p.do")
	public ModelAndView process_p(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								String keyfield,String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//status가 0이면 미표시(1), 표시(2) 모두 체크
		//map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = playerService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,30,10,"playerList_p.do");
		
		List<PlayerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = playerService.selectPlayerList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("playerList_p");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*--------------
	 * [선수 소개]외야수
	 *-------------*/
	@RequestMapping("/introduce/playerList_w.do")
	public ModelAndView process_w(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								String keyfield,String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//status가 0이면 미표시(1), 표시(2) 모두 체크
		//map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = playerService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,30,10,"playerList_w.do");
		
		List<PlayerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = playerService.selectPlayerList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("playerList_w");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
	/*--------------
	 * [선수 소개]내야수
	 *-------------*/
	@RequestMapping("/introduce/playerList_n.do")
	public ModelAndView process_n(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
								String keyfield,String keyword) {
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		//status가 0이면 미표시(1), 표시(2) 모두 체크
		//map.put("status", 0);
		
		//전체/검색 레코드 수
		int count = playerService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,count,30,10,"playerList_n.do");
		
		List<PlayerVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = playerService.selectPlayerList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("playerList_n");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	
}
