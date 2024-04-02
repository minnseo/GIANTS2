package kr.spring.food.controller;

import java.util.ArrayList;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.food.service.FoodService;
import kr.spring.food.vo.F_cartVO;
import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.food.vo.FoodVO;
import kr.spring.food.vo.Food_reviewVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.CompanyDetailVO;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FoodController {
	
	@Autowired
	private FoodService foodService;
	
	@Autowired
	private MemberService memberService;
	
	
	@ModelAttribute
	public FoodVO initCommand() {
		return new FoodVO();
	}
	
	@ModelAttribute
	public F_orderVO initCommand2() {
		return new F_orderVO();
	}
	
	@ModelAttribute
	public Food_reviewVO initCommand3() {
		return new Food_reviewVO();
	}
	
	
	/*	====================
	 *		매장이미지 출력
	 * 	====================*/
	@RequestMapping("/food/compImageView.do")
	public ModelAndView compImg(@RequestParam String comp_num) {
		
		
		log.debug("기업 프로필 확인중 >>> "+ comp_num);
		CompanyDetailVO comp = memberService.selectCompanyDetail(comp_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		mav.addObject("imageFile", comp.getComp_photo());
		mav.addObject("filename", comp.getComp_photoname());
			
		return mav;
	}
	
	/*	====================
	 *		이미지 출력
	 * 	====================*/
	@RequestMapping("/food/imageView.do")
	public ModelAndView viewImage(@RequestParam int food_num,
			                      @RequestParam int food_type) {
		
		FoodVO foodVO = 
				foodService.selectFood(food_num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("imageView");
		
		if(food_type==1) {//photo1
			mav.addObject("imageFile", foodVO.getFood_photo1());
			mav.addObject("filename", foodVO.getFood_photo1_name());
		}else if(food_type==2) {//photo2
			mav.addObject("imageFile", foodVO.getFood_photo2());
			mav.addObject("filename", foodVO.getFood_photo2_name());
		}
		return mav;
	}
	

	
	/*	=======================
	 *		(공용) 매장 목록 페이지 
	 * 	=======================*/
	@RequestMapping("/food/foodList.do")
	@ResponseBody
	public ModelAndView foodList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
								 @RequestParam(value = "comp_cate", defaultValue = "1") int comp_cate,
								 @RequestParam(value = "sort", defaultValue = "1") String sort) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comp_cate", comp_cate);
		map.put("sort", sort);
		int count = foodService.selectCompRowCount(map);
		
		//log.debug("매장 목록페이지 진입 >> : comp_cate : " + comp_cate + " sort : " + sort);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 5, 5, "foodList.do");
		
		List<CompanyDetailVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = foodService.selectCompList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("foodList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		mav.addObject("sort", sort);
		mav.addObject("comp_cate", comp_cate);
		return mav;
	}
	
	/*	============================
	 *		(공용) 기업 상세페이지 - 식품 메뉴
	 * 	============================*/
	@RequestMapping("/food/foodCompDetailMenu.do")
	public ModelAndView foodCompDetail(@RequestParam String comp_num,
									   @RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
									   HttpSession session) {
		
		CompanyDetailVO comp = foodService.selectComp(comp_num);
		int count = foodService.selectRowCount(comp_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		PagingUtil page = new PagingUtil(currentPage, count, 8, 5, "foodCompDetailMenu.do");
		
		List<FoodVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("comp_num", comp_num);
			
			list = foodService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("foodCompDetailMenu");
		mav.addObject("comp", comp);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		return mav;
	}
	
	
	
	/*	========================================
	 *		(기업) 기업 상세 -> 기업 수정 페이지 
	 * 	========================================*/
	@RequestMapping("/food/fixCompFoodList.do")
	public ModelAndView foodFixCompDetail(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
										  HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		CompanyDetailVO comp = foodService.selectComp(user.getCompanyDetailVO().getComp_num());
		int count = foodService.selectRowCount(comp.getComp_num());
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 5, 5, "fixCompFoodList.do");
		
		List<FoodVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			map.put("comp_num", comp.getComp_num());
			
			list = foodService.selectList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("fixCompFoodList");
		mav.addObject("comp", comp);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*	==========================
	 *		(기업) 식품 추가/등록 페이지
	 * 	==========================*/
	@GetMapping("/food/addNewFood.do")
	public String formAddNewFood() {
		return "addNewFood";
	}
	
	@PostMapping("/food/addNewFood.do")
	public String submitAddNewFood(@Valid FoodVO vo, BindingResult result,
									Model model, HttpServletRequest request,
									HttpSession session) {
		//log.debug("<< 식품 추가/등록 POST 작동 >> : " + vo);
		
		
		//상품 이미지 유효성 체크
		//MultipartFIle -> byte[]로 변환한 경우, 파일을 업로드 하지 않으면
		//byte[]은 생성되고 length는 0이 됨. 즉, null이 아니다.
		if (vo.getFood_photo1().length == 0) 
			result.rejectValue("food_photo1", "required");
		if (vo.getFood_photo2().length == 0) 
			result.rejectValue("food_photo2", "required");
		
		if(vo.getFood_photo1().length >= 10*1024*1024) 
			result.rejectValue("food_photo1", "limitUploadSize", new Object[] {"10MB"}, null);
		if(vo.getFood_photo2().length >= 10*1024*1024) 
			result.rejectValue("food_photo2", "limitUploadSize", new Object[] {"10MB"}, null);
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasErrors()) {
			return formAddNewFood();
		}
		
		//log.debug("<< 사업자 등록번호 세팅 전 >>");
		//사업자 등록 번호 VO에 세팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		vo.setComp_num(user.getCompanyDetailVO().getComp_num());
		
		//log.debug("<< 사업자 등록번호 완료 상품 등록 시작 >>");
		
		//상품 등록 sql 시작
		foodService.insertFood(vo);
		
		//View에 표시할 메세지
		model.addAttribute("message", "새 식품등록이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/food/fixCompFoodList.do");
		
		return "common/resultView";
	}
	
	/*	==========================
	 *		(기업) 식품 수정 페이지
	 * 	==========================*/
	@GetMapping("/food/fixFood.do")
	public String formFixFood(@RequestParam int food_num, Model model) {
		
		FoodVO foodVO = foodService.selectFood(food_num);
		model.addAttribute("foodVO", foodVO);
		
		return "fixFood";
	}
	@PostMapping("/food/fixFood.do")
	public String submitFixFood(@Valid FoodVO vo, BindingResult result,
								 Model model, HttpServletRequest request,
								 HttpSession session) {
		//유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasErrors()) {
			//log.debug("<<< 푸드 수정 폼 호출중 >>>");
			return formFixFood(vo.getFood_num(), model);
		}
		
		//log.debug("<<< 푸드 수정 submit 이미지 파일 수정 전 호출중 >>> : " + vo.getFood_photo1_name().length());
		
		//upload 이미지 파일들이 모두 동일할 경우 기존 데이터로 세팅
		FoodVO db_foodVO = foodService.selectFood(vo.getFood_num());
		
		if (vo.getFood_photo1_name()==db_foodVO.getFood_photo1_name() || vo.getFood_photo1_name().length()==0) {
			vo.setFood_photo1(null);
			vo.setFood_photo1_name(null);
		}
		if (vo.getFood_photo2_name()==db_foodVO.getFood_photo2_name() || vo.getFood_photo2_name().length()==0) {
			vo.setFood_photo2(null);
			vo.setFood_photo2_name(null);
		}
		
		log.debug("<<< 푸드 수정 submit 이미지 파일 수정 후 >>> : " + vo.getFood_photo1_name());
		
		foodService.fixFood(vo);
		
		//View에 표시할 메세지
		model.addAttribute("message", "수정이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/food/fixCompFoodList.do");
				
		return "common/resultView";
	}
	
	/*	==========================
	 *		(기업) 식품 삭제 페이지
	 * 	==========================*/
	@PostMapping("/food/deleteFood.do")
	public String submitDeleteFood(@RequestParam int food_num) {
		//log.debug("<< 식품 삭제 수행중 >> : " + food_num);
		
		//식품 삭제
		foodService.deleteFood(food_num);
		
		return "redirect:/food/fixCompFoodList.do";
	}
	
	
	/*	==========================
	 *		(공용) 식품 상세 페이지
	 * 	==========================*/
	//폼 호출
	@RequestMapping("/food/foodDetail.do")
	public String formFoodDetail(@RequestParam int food_num,
							 	 @RequestParam String comp_num,
							 	 Model model) {
		FoodVO food = foodService.selectFood(food_num);
		CompanyDetailVO comp = memberService.selectCompanyDetail(comp_num);
		model.addAttribute("food", food);
		model.addAttribute("comp", comp);
		
		return "foodDetail";
	}
	
	/*	==========================
	 *		(회원) 장바구니 담기 (foodDetail.js)스크립트
	 * 	==========================*/
	//장바구니 아이템 체크
	@RequestMapping("/food/foodCartCheck.do")
	@ResponseBody
	public Map<String,Object> foodCartCheck(@RequestParam int food_num,
											@RequestParam String comp_num,
											HttpSession session){
		//log.debug("<< 장바구니 아이템 체크 동작중 >> ");
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			List<F_cartVO> db_cart = new ArrayList<F_cartVO>();
			boolean check = false;
			//1.현재 로그인한 회원의 장바구니에 아이템이 존재하는지 조회
			db_cart = foodService.selectF_cartList(user.getMem_num());
			//log.debug("장바구니 리스트 크기"+db_cart.size());
			if (db_cart.size() != 0) {
				//  2.장바구니에 아이템이 있으면 해당 아이템의 comp_num이 
				//	  현재 등록해야 하는 식품의 comp_num과 다른지 확인
				for (F_cartVO cart : db_cart) {
					//장바구니에 담겨있는 아이템들과 현재 넣을 아이템의 매장번호가 다를경우
					if (!cart.getFoodVO().getComp_num().equals(comp_num)) {
						check = true;
						break;
					}
				}// end of for()----
			}
			if (check) {
				//장바구니 안에 다른 매장의 아이템이 있음을 알림
				mapJson.put("result", "MismatchCompany");
			}else {
				//장바구니가 비워져 있거나 동일상품임을 알림
				//log.debug("장바구니 체크 Empty 진입");
				if (db_cart.size() != 0) {
					mapJson.put("order", "NotEmpty");
				}
				mapJson.put("result", "Empty");
			}
		}
		return mapJson;
	}
	//장바구니 모두 비우기
	@RequestMapping("/food/foodEmptyCart.do")
	@ResponseBody
	public Map<String,Object> foodEmptyCart(HttpSession session){
		//log.debug("<< 장바구니 모두 비우기 동작중 >> ");
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//모두 비우기 진행
			foodService.deleteF_cart(user.getMem_num());
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	//장바구니 아이템 추가
	@RequestMapping("/food/foodAddCart.do")
	@ResponseBody
	public Map<String,Object> foodAddCart(F_cartVO f_cartVO,
										  HttpSession session){
		//log.debug("<< 장바구니 아이템 추가 동작중 >> :" + f_cartVO);
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			f_cartVO.setMem_num(user.getMem_num());
			F_cartVO db_cart = foodService.selectF_cart(f_cartVO);
			
			if (db_cart==null) {
				//등록된 동일 상품이 없는 경우
				//장바구니에 상품 등록
				foodService.insertF_cart(f_cartVO);
				mapJson.put("result", "success");
			}else {
				//등록된 동일 상품이 있음
				//재고수를 구하기 위해서 상품 정보 호출
				FoodVO db_food = foodService.selectFood(db_cart.getFood_num());
				
				//구매수량 합산
				int order_quantity = db_cart.getF_cart_quantity() + f_cartVO.getF_cart_quantity();
				
				if (db_food.getFood_quantity() < order_quantity) {
					//재고 수량보다 장바구니에 담을 수량이 더 많을 경우
					mapJson.put("result", "overquantity");
				}else {
					//기존 장바구니 상품 업데이트
					f_cartVO.setF_cart_quantity(order_quantity);
					//기존 장바구니 업데이트
					foodService.updateF_cartByFood_num(f_cartVO);
					mapJson.put("result", "success");
				}
			}
		}
		return mapJson;
	}
	//주문하기 버튼 동작
	@RequestMapping("/food/selectCartNums.do")
	@ResponseBody
	public Map<String,Object> selectCartNums(HttpSession session) {
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			List<F_cartVO> list = null;
			list = foodService.selectF_cartList(user.getMem_num());
			
			List <Integer> numList = new ArrayList<Integer>();
			for (F_cartVO cart : list) {
				numList.add(cart.getCart_num());
			}
			mapJson.put("list", numList);
			mapJson.put("result", "success");
			
		}
		
		
		return mapJson;
	}
	
	/*	==========================
	 *		(회원) 장바구니 페이지 - foodUserCartList.js
	 * 	==========================*/
	//폼 호출
	@RequestMapping("/food/fcart/foodUserCartList.do")
	public ModelAndView formFoodUserCartList(HttpSession session,
									   		 Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		//카트 목록을 mem_num을 통해서 조회하여 담아 넘김
		List<F_cartVO> list = null;
		list = foodService.selectF_cartList(user.getMem_num());
		
		//log.debug("내 장바구니 목록 확인하기 >>> " + list);
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("foodUserCartList");
		
		return mav;
	}
	
	//장바구니 수량 변경
	@RequestMapping("/food/fcart/changeCartQuantity.do")
	@ResponseBody
	public Map<String,Object> changeCartQuantity(F_cartVO f_cartVO, HttpSession session){
		
		//log.debug("<< 장바구니 수량 변경 진행중 >> :" + f_cartVO);
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//구매하고자 하는 상품의 재고 확인하기
			FoodVO food = foodService.selectFood(f_cartVO.getFood_num());
			if (food.getFood_status()==1) {
				//판매중지 상품
				mapJson.put("result", "stopSell");
			}else if (food.getFood_quantity() < f_cartVO.getF_cart_quantity()) {
				//재고가 부족함
				mapJson.put("result", "noQuantity");
			}else {
				//장바구니 수량 변경 진행
				//log.debug("<< 장바구니 수량 변경 진행중 >> :" + f_cartVO);
				f_cartVO.setMem_num(user.getMem_num());
				foodService.updateF_cartByFood_num(f_cartVO);
				mapJson.put("result", "success");
			}
		}
		return mapJson;
	}
	
	//장바구니 삭제버튼
	@RequestMapping("/food/fcart/deleteOneCart.do")
	@ResponseBody
	public Map<String,Object> deleteOneCart(@RequestParam int cart_num, HttpSession session){

		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			foodService.deleteOneF_cart(cart_num);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/*	==========================
	 *		(회원) 주문페이지
	 * 	==========================*/
	//장바구니 -> 주문 폼 호출
	@PostMapping("/food/forder/foodOrderForm.do")
	public String formFoodOrder(F_orderVO f_orderVO, HttpSession session,
	           					Model model, HttpServletRequest request) {
		
		if (f_orderVO.getCart_numbers()==null || f_orderVO.getCart_numbers().length==0) {
			model.addAttribute("message", "정상적인 주문이 아닙니다.");
			model.addAttribute("url", request.getContextPath()+"/food/fcart/foodUserCartList.do");
			return "common/resultView";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mem_num", user.getMem_num());
		map.put("cart_numbers", f_orderVO.getCart_numbers());
		int total_price = foodService.selectTotalByMem_num(map);
		if (total_price <= 0) {
			model.addAttribute("message", "정상적인 주문이 아니거나 상품의 수량이 부족합니다.");
			model.addAttribute("url", request.getContextPath()+"/food/fcart/foodUserCartList.do");
			return "common/resultView";
		}
		
		//장바구니에 담아둔 상품 정보 호출
		List<F_cartVO> cartList = foodService.selectF_cartListForOrder(map);
		int cnt = 0;
		for (F_cartVO f_cart : cartList) {
			FoodVO food = foodService.selectFood(f_cart.getFood_num());
			if (food.getFood_status()==1) {	//현재 오류 부분
				//해당상품이 판매중지인 경우
				model.addAttribute("message", "["+food.getFood_name()+"]상품은 판매 중지 되었습니다.");
				model.addAttribute("url", request.getContextPath()+"/food/fcart/foodUserCartList.do");
				return "common/resultView";
			}
			
			if (food.getFood_quantity() < f_cart.getF_cart_quantity()) {
				//해당상품의 재고 수량이 부족한 경우
				model.addAttribute("message", "["+food.getFood_name()+"]상품 재고수량 부족으로인한 주문 불가");
				model.addAttribute("url", request.getContextPath()+"/food/fcart/foodUserCartList.do");
				return "common/resultView";
			}
			//동일상품의 총 가격 세팅
			f_cart.setSub_total(f_cart.getF_cart_quantity() * f_cart.getF_cart_price());
			if (cnt==0) {
				CompanyDetailVO comp = foodService.selectComp(food.getComp_num());
				model.addAttribute("comp_name", comp.getComp_name());
			}
		}
		
		model.addAttribute("list", cartList);
		model.addAttribute("total_price", total_price);
		
		return "foodOrderForm";
	}
	
	//주문하기 결제 전 데이터 검증 - foodOrderForm.jsp
	@RequestMapping("/food/forder/checkBeforePayment.do")
	@ResponseBody
	public Map<String,Object> checkBeforePayment(F_orderVO f_orderVO, HttpSession session){
		
		//log.debug("<< 주문하기 결제 전 데이터 검증 수행중 >> :" + f_orderVO);
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) {
			mapJson.put("result", "logout");
		}else {
			//cart_num 이 일치하는지 체크
			if (f_orderVO.getCart_numbers() == null || f_orderVO.getCart_numbers().length==0) {
				mapJson.put("result", "UnknownCartNums");
			}
			
			//검증 확인
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mem_num", user.getMem_num());
			map.put("cart_numbers", f_orderVO.getCart_numbers());
			int total_price = foodService.selectTotalByMem_num(map);
			//db에 저장된 구매할 총 금액가격과 일치하는지 체크
			if (total_price <= 0) {
				mapJson.put("result", "NotMatchTotalPrice");
			}
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/* ----- [Order] 콜백 수신처리 -----*/
	@RequestMapping("/food/forder/insertF_orderPay.do")
	@ResponseBody
	public String inserF_orderPay(@RequestBody F_orderVO f_orderVO, HttpSession session, RedirectAttributes rttr) {
		
		//log.debug("결제완료 후 콜백 처리 "+ f_orderVO);
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_num", user.getMem_num());
		map.put("cart_numbers", f_orderVO.getCart_numbers());
		
		//장바구니에 담겨있는 상품 정보 호출
		List<F_cartVO> cartList = foodService.selectF_cartListForOrder(map);
		
		//개별 주문 상품들 저장
		List<F_order_detailVO> f_orderDetailList = new ArrayList<F_order_detailVO>();
		for (F_cartVO f_cart : cartList) {
			
			F_order_detailVO fod = new F_order_detailVO();
			fod.setFood_num(f_cart.getFood_num());
			fod.setFood_name(f_cart.getFoodVO().getFood_name());
			fod.setFood_price(f_cart.getF_cart_price());
			fod.setOrder_quantity(f_cart.getF_cart_quantity());
			fod.setFood_total(fod.getOrder_quantity()*fod.getFood_price());
			
			f_orderDetailList.add(fod);
		}
		
		f_orderVO.setMem_num(user.getMem_num());
		//사용 전 = 1, 후 = 0 
		f_orderVO.setF_order_status(1);
		f_orderVO.setQrlink("/food/forder/companyCheckQR.do?f_order_num=" + f_orderVO.getF_order_num()
						  + "&buyer_name=" + f_orderVO.getBuyer_name());
		
		//데이터 DB에 반영하기
		foodService.insertF_order(f_orderVO, f_orderDetailList);
		
		//log.debug("\n\n 전송된 데이터 처리중 >>> " + cartList);
		
		return "/food/forder/foodOrderSuccess.do";	// 결제이후 이동할 주소 지정
	}
	
	//주문완료 페이지 호출
	@RequestMapping("/food/forder/foodOrderSuccess.do")
	public String foodOrderSuccess(@RequestParam String f_order_num,
										HttpSession session, HttpServletRequest request, Model model) {
		//주문번호 + 회원번호를 통해서 인증
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		map.put("f_order_num", f_order_num);
		map.put("mem_num", user.getMem_num());
		
		F_orderVO f_order = foodService.selectF_order(map);
		if (f_order == null) {
			//본인이 아닐경우 매장목록으로
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		
		model.addAttribute("f_order", f_order);
		return "foodOrderSuccess";
	}
	/*	==========================
	 *		(회원) 주문페이지 끝
	 * 	==========================*/
	
	
	
	//QR코드를 출력하는 화면으로 이동
	@RequestMapping("/food/forder/myFoodQRcode.do")
	public String showQR(@RequestParam String f_order_num,
										HttpSession session, HttpServletRequest request, Model model) {
		//QR코드 링크를 요청하는 고객이 본인임을 확인
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		map.put("f_order_num", f_order_num);
		map.put("mem_num", user.getMem_num());
		
		F_orderVO f_order = foodService.selectF_order(map);
		if (f_order == null) {
			//본인이 아닐경우 매장목록으로
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		//유효기간이 만료되었을경우에 QR코드 사용상태를 변경
		
		//QR코드 사용상태를 확인함.
		
		model.addAttribute("f_order_num", f_order_num);
		model.addAttribute("qrlink",f_order.getQrlink());
		return "myFoodQRcode";
	}
	
	/*	==========================
	 *		(회원) 내 주문목록
	 * 	==========================*/
	@RequestMapping("/food/forder/myFoodOrderList.do")
	public ModelAndView myFoodOrderList (@RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
										 @RequestParam(value = "sort", defaultValue = "2") String sort,
										 HttpSession session) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		map.put("mem_num", user.getMem_num());
		map.put("sort", sort);
		int count = foodService.selectOrderRowCount(map);
		
		//log.debug("매장 목록페이지 진입 >> : comp_cate : " + comp_cate + " sort : " + sort);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(currentPage, count, 5, 5, "myFoodOrderList.do");
		
		List<F_orderVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = foodService.selectOrderList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myFoodOrderList");
		mav.addObject("count", count);
		mav.addObject("sort", sort);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	// (회원) 내 주문 상세정보확인
	@RequestMapping("/food/forder/myFoodOrderDetail.do")
	public String myFoodOrderDetail (@RequestParam String f_order_num, HttpSession session, Model model) {

		//주문번호(f_order_num)를 통하여 모든 정보를 출력함.
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		map.put("f_order_num", f_order_num);
		map.put("mem_num", user.getMem_num());
		
		//log.debug("\n\n 내 주문 상세정보 확인 호출 >>>  " + map);
		
		//주문정보 호출
		F_orderVO f_order = foodService.selectF_order(map);
		//개별 상품 주문정보 호출
		List<F_order_detailVO> detailList = foodService.selectListF_orderDetail(f_order_num);
		
		model.addAttribute("f_order", f_order);
		model.addAttribute("list", detailList);
		
		return "myFoodOrderDetail";
	}
	
	/*	==========================
	 *		(기업) QR주문확인 - compAfterCheckQR.jsp
	 * 	==========================*/
	//기업이 QR코드를 찍었다고 가정하여, 이 페이지를 방문하였을 경우 
	//QR코드가 유효한지 확인하여 상태를 변경하고 해당 회원의 주문 내역을 출력하는 페이지로 이동
	@RequestMapping("/food/forder/companyCheckQR.do")
	public String companyCheckQR(@RequestParam String f_order_num,
								 @RequestParam String buyer_name,
											 	HttpSession session, HttpServletRequest request, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		String comp_num = user.getCompanyDetailVO().getComp_num();
		if (comp_num==null || comp_num.trim()=="") {
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		
		F_orderVO db_f_order = foodService.selectF_orderByNum(f_order_num);
		if (!db_f_order.getBuyer_name().equals(buyer_name)) {
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		if (!db_f_order.getComp_num().equals(comp_num)) {
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		//모든 조건을 확인한 후 해당 주문번호에 대해 QR상태를 업데이트 함
		foodService.updateF_orderStatus(f_order_num);
		
		//출력페이지용 데이터 적재
		List<F_order_detailVO> detailList = foodService.selectListF_orderDetail(f_order_num);
		model.addAttribute("f_order", db_f_order);
		model.addAttribute("list", detailList);
		
		return "compAfterCheckQR";
	}
	
	
	/*	============================
	 *		(공용) 기업 상세페이지 - 기업 리뷰
	 * 	============================*/
	@RequestMapping("/food/foodCompDetailReview.do")
	public ModelAndView foodCompDetailReview(@RequestParam String comp_num,
									   		 @RequestParam(value = "pageNum", defaultValue = "1") int currentPage,
									   		 HttpSession session) {
		//log.debug("기업상세 페이지 진입 >>> comp_num : " + comp_num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comp_num", comp_num);
		
		CompanyDetailVO comp = foodService.selectComp(comp_num);
		int count = foodService.selectReviewRowCount(map);
		
		PagingUtil page = new PagingUtil(currentPage, count, 10, 5, "foodCompDetailReview.do","&comp_num="+comp_num);
		
		List<Food_reviewVO> list = null;
		if (count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = foodService.selectReviewList(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("foodCompDetailReview");
		mav.addObject("comp", comp);
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		return mav;
	}
	
	/*	============================
	 *		(공용) 리뷰 상세보기
	 * 	============================*/
	@RequestMapping("/food/foodReviewDetail.do")
	public ModelAndView foodReviewDetail(@RequestParam int review_num, HttpSession session) {
		
		Food_reviewVO food_reviewVO = foodService.selectReview(review_num);
		CompanyDetailVO comp = foodService.selectComp(food_reviewVO.getComp_num());
		ModelAndView mav = new ModelAndView();
		mav.setViewName("foodReviewDetail");
		mav.addObject("review", food_reviewVO);
		mav.addObject("comp", comp);
		return mav;
	}
	
	// 리뷰 삭제하기	foodReviewDetail.jsp 의 스크립트 동작
	@RequestMapping("/food/foodReviewDelete.do")
	@ResponseBody
	public Map<String,Object> foodReviewDelete(@RequestParam int review_num, HttpSession session){
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Food_reviewVO db_review = foodService.selectReview(review_num);
		if(user==null) {
			mapJson.put("result", "logout");
		}else if (user.getMem_auth()==9) {
			//관리자인 경우 수행
			foodService.deleteReview(review_num);
			mapJson.put("result", "success");
		}else if(db_review.getMem_num() != user.getMem_num()) {
			mapJson.put("result", "MisMatchUser");
		}else{
			foodService.deleteReview(review_num);
			mapJson.put("result", "success");
		}
		return mapJson;
	}
	
	/*	==========================
	 *		(회원) 리뷰작성
	 * 	==========================*/
	//폼 호출
	@GetMapping("/food/foodReviewForm.do")
	public String formFoodReview(@RequestParam String f_order_num, Model model, HttpSession session, HttpServletRequest request) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		F_orderVO f_order = foodService.selectF_orderByNum(f_order_num);
		
		if (user.getMem_num()!=f_order.getMem_num()) {
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		if (f_order.getF_order_status()!=0) {
			model.addAttribute("message", "잘못된 요청입니다.");
			model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
			return "common/resultView";
		}
		
		CompanyDetailVO comp = foodService.selectComp(f_order.getComp_num());
		
		model.addAttribute("f_order", f_order);
		model.addAttribute("comp_name" , comp.getComp_name());
		
		return "foodReviewForm";
	}
	
	@PostMapping("/food/foodReviewForm.do")
	public String submitFoodReview(@Valid Food_reviewVO vo, BindingResult result,@RequestParam String f_order_num, 
									Model model, HttpServletRequest request,
									HttpSession session) {
		
		//유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasErrors()) {
			return formFoodReview(f_order_num, model, session, request);
		}
		
		//log.debug("<< 사업자 등록번호 세팅 전 >>");
		//사업자 등록 번호 VO에 세팅
		MemberVO user = (MemberVO)session.getAttribute("user");
		vo.setMem_num(user.getMem_num());
		vo.setComp_num(foodService.selectF_orderByNum(f_order_num).getComp_num());
		vo.setComp_score(Integer.parseInt(vo.getComp_rate()));
		
		foodService.insertFoodReview(vo);
		foodService.updateF_orderStatusByReview(f_order_num);
		
		//View에 표시할 메세지
		model.addAttribute("message", "리뷰작성이 완료되었습니다.");
		model.addAttribute("url", request.getContextPath() + "/food/foodList.do");
		
		return "common/resultView";
	}
	
	
	
}















