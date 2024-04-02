package kr.spring.main.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.gcart.vo.GcartVO;
import kr.spring.goods.service.GoodsService;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.gorder.service.GorderService;
import kr.spring.member.vo.MemberVO;
import kr.spring.news.service.NewsService;
import kr.spring.news.vo.NewsVO;
import kr.spring.ticket.service.TicketService;
import kr.spring.ticket.vo.GameVO;
import lombok.extern.slf4j.Slf4j;
 
@Slf4j
@Controller
public class MainController {
	@Autowired
	private NewsService newsService;
	
	@Autowired
	private TicketService ticketService;
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private GorderService orderService; 
	
	@RequestMapping("/")
	public String main() { return "redirect:/main/main.do"; }
	
	@RequestMapping("/main/main.do")
	public String main(GameVO gameVO, NewsVO newsVO, GoodsVO goodsVO, HttpSession session, Model model) {
		List<GameVO> list = ticketService.selectTicketGameList(gameVO);
		List<NewsVO> newsList = newsService.selectNewsForMain(newsVO);
		List<GoodsVO> goodsList = goodsService.selectListByDisc(goodsVO);
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user!=null) {
			int mem_num = user.getMem_num();
			List<GcartVO> cartList = orderService.CheckCartToDirectBuy(mem_num);
			int cart_count = cartList.size();
			model.addAttribute("cart_count", cart_count);
		}
		
		
		
		model.addAttribute("list", list);
		model.addAttribute("newsList", newsList);
		model.addAttribute("goodsList", goodsList);
		
		return "main";	// Tiles 설정의 식별자(main.jsp 의미 X)
	}
}
