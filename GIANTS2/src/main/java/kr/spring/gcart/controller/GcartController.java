package kr.spring.gcart.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.gcart.service.GcartService;
import kr.spring.gcart.vo.GcartVO;
import kr.spring.goods.service.GoodsService;
import kr.spring.goods.vo.GoodsOptionVO;
import kr.spring.goods.vo.GoodsVO;
import kr.spring.gorder.service.GorderService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import kr.spring.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class GcartController {
	@Autowired
	private GcartService cartService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private GorderService orderService;
	


	/*
	 * ======================== 장바구니 목록 조회 ========================
	 */

	@RequestMapping("/gorder/goods_cart.do")
	public String list(HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_num", user.getMem_num());

		// 회원번호별 총구매액
		int all_total = cartService.getTotalByMem_num(map);

		List<GcartVO> list = null;
		if (all_total > 0) {
			list = cartService.getListCart(map);
		}
		log.debug("<<장바구니 목록 조회>> : " + list);
		model.addAttribute("all_total", all_total);
		model.addAttribute("list", list);

		return "goods_cart";
	}

	// =========== 장바구니 등록 ============
	//옵션이 다른 경우 다른 상품 취급
	@RequestMapping("/cart/write.do")
	@ResponseBody
	public Map<String, String> addToCart(GcartVO cartVO, HttpSession session) {
		Map<String, String> mapJson = new HashMap<String, String>();
		MemberVO user = (MemberVO) session.getAttribute("user");
		// 로그인 x
		if (user == null) {
			mapJson.put("result", "logout");
		}
		// 로그인 o
		else {
			cartVO.setMem_num(user.getMem_num()); 
			GcartVO db_cart = cartService.getCart(cartVO);
			
			log.debug("GcartVO : " + db_cart);
			
			// 동일상품x - 장바구니에 상품이 없거나 옵션이 다르면 추가해주기. db_cart==null인 경우를 먼저 체크해줘야 뒤의 조건의 boolean을 체크하므로 순서 중요!
			if (db_cart ==null || db_cart.getOpt_num() != cartVO.getOpt_num()) { 
				cartService.insertCart(cartVO);
				mapJson.put("result", "success");
			}
			// 동일상품o - 상품+옵션이 같은 경우
			else {
				// 재고를 구하기 위해 상품 정보 호출
				GoodsVO db_goods = goodsService.selectGoodsAllInfo(db_cart.getGoods_num());
				// 굿즈의 옵션 별 재고 가져오기 
				int db_stock = cartService.getStockByoption(db_goods.getGoods_num(), cartVO.getOpt_num());
				
				log.debug("<<굿즈 옵션별 재고 >> : " + db_stock);
				
				//구매 수량 합산(기존 장바구니에 있던 수량 + 새로 장바구니에 넣은 수량)
				int order_quantity = db_cart.getOrder_quantity() + cartVO.getOrder_quantity();
				log.debug("<<장바구니+구매 수량 >> : " + order_quantity);
				
				if(db_stock < order_quantity) {
					mapJson.put("result", "overquantity"); //재고가 장바구니에 담은 수량보다 작은경우
				}
				else {
					//수량설정 
					cartVO.setOrder_quantity(order_quantity);
					cartService.updateCartByItem_num(cartVO);
					mapJson.put("result", "success");
				}
			}
		}

		return mapJson;
	}

	/*
	 * ===================== 장바구니 상품 수량 변경 =====================
	 */
	@RequestMapping("/cart/modifyCart.do")
	@ResponseBody
	public Map<String, String> submitModify(GcartVO cartVO, HttpSession session) {
		Map<String, String> mapJson = new HashMap<String, String>();
		// 재고를 구하기 위해 상품 정보 호출
		log.debug("<<장바구니 수정 - cartVO>> : " + cartVO); 
		
		 GcartVO db_cart = cartService.getCart(cartVO); 
		 
		 log.debug("<<장바구니 수정 - db_cart>> : " + db_cart); 
		 
		 GoodsVO db_goods = goodsService.selectGoods(db_cart.getGoods_num());
		 log.debug("<< db_cart >> : " + db_cart); 
		 log.debug("<< db_goods >> : " + db_goods);

		
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			cartVO.setMem_num(user.getMem_num()); 
			// 현재 구매하고자 하는 상품의 재고수를 구해야하므로 상품 정보를 가져오자
			GoodsVO goods = goodsService.selectGoods(cartVO.getGoods_num());
			// 굿즈의 옵션 별 재고 가져오기 
			log.debug("<<재고 가져오기 goods.getGoods_num() >> : " + goods.getGoods_num());
			log.debug("<<재고 가져오기 cartVO.getOpt_num() >> : " + cartVO.getOpt_num());
			
			int db_stock = cartService.getStockByoption(goods.getGoods_num(), db_cart.getOpt_num());
			
			if (goods.getGoods_status() == 2) {// 상품 미표시
				mapJson.put("result", "noSale");
			} 
			else if(db_stock < cartVO.getOrder_quantity()){
				mapJson.put("result", "noQuantity"); //재고부족
			}
			
			else {// 상품 수량 변경 가능
				cartService.updateCart(cartVO);
				mapJson.put("result", "success");
			}
		}
		return mapJson;
	}

	/*
	 * ===================== 장바구니 상품 삭제 =====================
	 */
	@RequestMapping("/cart/deleteCart.do")
	@ResponseBody
	public Map<String, String> delete(@RequestParam int cart_num, HttpSession session) {
		Map<String, String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			cartService.deleteCart(cart_num);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	@RequestMapping("/cart/deleteCartAll.do")
	@ResponseBody
	public Map<String, String> deleteAll(HttpSession session) {
		Map<String, String> mapJson = new HashMap<String, String>();

		MemberVO user = (MemberVO) session.getAttribute("user");
		if (user == null) {
			mapJson.put("result", "logout");
		} else {
			cartService.deleteCartAll(user.getMem_num());
			mapJson.put("result", "success");
		}
		return mapJson;
	}

}// end Controller
