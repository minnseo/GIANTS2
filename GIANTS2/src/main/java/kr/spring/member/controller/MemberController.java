package kr.spring.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import kr.spring.food.vo.F_orderVO;
import kr.spring.food.vo.F_order_detailVO;
import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.ticket.vo.TicketVO;
import kr.spring.util.AuthCheckException;
import kr.spring.util.FileUtil;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	/*=====================
	 * 로그 대상 지정
	 *=====================*/
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	/*=====================
	 * 자바빈 초기화
	 *=====================*/
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}

	
	/*=====================
	 * 회원가입
	 *=====================*/
	@RequestMapping("/member/registerCommon.do")
	public String form() {
		return "commonRegister";
	}
	
	@RequestMapping("/member/memregresult.do")
	public String formm() {
		return "memregresult";
	}
	
	/*=====================
	 * 일반회원 아이디 찾기
	 *=====================*/
	@GetMapping("/member/findId.do")
	public String formFindId() {
		return "memberfindId";
	}
	@PostMapping("/member/findId.do")
	public String submitFindId(@Valid MemberVO memberVO, BindingResult result,
			Model model, HttpServletRequest request, HttpSession session) {
		
		MemberVO db_member = memberService.findMemberId(memberVO.getMem_name(),memberVO.getMem_phone());
		
		if(db_member!=null) {
			if(db_member.getMemberDetailVO().getMem_name().equals(memberVO.getMem_name())
					&& db_member.getMemberDetailVO().getMem_phone().equals(memberVO.getMem_phone())) {
				
				model.addAttribute("db_member", db_member);
				return "findIdResult";
			}
		}else {
			return "memberfindId";
		}
		return "memberfindId";
	}
	
	/*=====================
	 * 기업회원 아이디 찾기
	 *=====================*/
	@GetMapping("/member/findIdCp.do")
	public String formFindIdCp() {
		return "companyfindId";
	}
	@PostMapping("/member/findIdCp.do")
	public String submitFindIdCp(@Valid MemberVO memberVO, BindingResult result,
			Model model, HttpServletRequest request, HttpSession session) {
		
		MemberVO db_member = memberService.findCompanyId(memberVO.getComp_owner(),memberVO.getComp_phone());
		if(db_member!=null) {
			if(db_member.getCompanyDetailVO().getComp_owner().equals(memberVO.getComp_owner())
					&& db_member.getCompanyDetailVO().getComp_phone().equals(memberVO.getComp_phone())) {
				
				model.addAttribute("db_member", db_member);
				return "findIdResultCp";
			}
		}else {
			return "companyfindId";
		}
		return "companyfindId";
	}
	
	/*=====================
	 * 일반회원 비밀번호 찾기
	 *=====================*/
	@GetMapping("/member/findPw.do")
	public String formFindPw() {
		return "memberfindPw";
	}
	@PostMapping("/member/findPw.do")
	public String submitFindPw(@Valid MemberVO memberVO, BindingResult result,
							   Model model, HttpServletRequest request, HttpSession session) {
		
		MemberVO db_member = memberService.findMemberPw(memberVO.getMem_id(),
														memberVO.getMem_name(),
														memberVO.getMem_phone(),
														memberVO.getMem_email());
		
		if(db_member!=null) {
			if(db_member.getMem_id().equals(memberVO.getMem_id())
					&& db_member.getMemberDetailVO().getMem_name().equals(memberVO.getMem_name())
					&& db_member.getMemberDetailVO().getMem_phone().equals(memberVO.getMem_phone())
					&& db_member.getMemberDetailVO().getMem_email().equals(memberVO.getMem_email())) {
				
				 // 난수 생성
		        String new_passwd = RandomStringUtils.randomNumeric(6);
		        
		        // 모델에 난수 추가
		        model.addAttribute("new_passwd", new_passwd);

		        // 비밀번호 변경
		        memberService.changePw(db_member.getMem_num(), new_passwd);
		        
				model.addAttribute("db_member", db_member);
				return "findPwResult";
			}
		}else {
			return "memberfindPw";
		}
		return "memberfindPw";
	}
	
	/*=====================
	 * 기업회원 비밀번호 찾기
	 *=====================*/
	@GetMapping("/member/findPwCp.do")
	public String formFindPwCp() {
		return "companyfindPw";
	}
	@PostMapping("/member/findPwCp.do")
	public String submitFindPwCp(@Valid MemberVO memberVO, BindingResult result,
							   Model model, HttpServletRequest request, HttpSession session) {
		
		MemberVO db_member = memberService.findCompanyPw(memberVO.getMem_id(),
														memberVO.getComp_owner(),
														memberVO.getComp_phone(),
														memberVO.getComp_email());
		
		if(db_member!=null) {
			if(db_member.getMem_id().equals(memberVO.getMem_id())
					&& db_member.getCompanyDetailVO().getComp_owner().equals(memberVO.getComp_owner())
					&& db_member.getCompanyDetailVO().getComp_phone().equals(memberVO.getComp_phone())
					&& db_member.getCompanyDetailVO().getComp_email().equals(memberVO.getComp_email())) {
				
				 // 난수 생성
		        String new_passwd = RandomStringUtils.randomNumeric(6);
		        
		        // 모델에 난수 추가
		        model.addAttribute("new_passwd", new_passwd);

		        // 비밀번호 변경
		        memberService.changePw(db_member.getMem_num(), new_passwd);
		        
				model.addAttribute("db_member", db_member);
				return "findPwResult";
			}
		}else {
			return "companyfindPw";
		}
		return "companyfindPw";
	}
	
	
	/*=====================
	 * 유효성 검사
	 *=====================*/
	//회원가입시 아이디 유효성 체크
	@RequestMapping("/member/confirmId.do")
	@ResponseBody
	public Map<String, String> confirmId(@RequestParam String mem_id) {

		Map<String, String> mapAjax = new HashMap<String, String>();
		MemberVO member = memberService.selectCheckMember(mem_id);
		if (member != null) {
			// 아이디 중복
			mapAjax.put("result", "idDuplicated");
		} else {
			if (!Pattern.matches("^[A-Za-z0-9]{4,12}$", mem_id)) {
				// 패턴불일치
				mapAjax.put("result", "notMatchPattern");
			} else {
				// 패턴 일치하면서 아이디 미중복
				mapAjax.put("result", "idNotFound");
			}
		}
		return mapAjax;
	}
	//회원가입시 닉네임 유효성 체크
	@RequestMapping("/member/confirmNk.do")
	@ResponseBody
	public Map<String, String> confirmNk(@RequestParam String mem_nickname) {
		Map<String, String> mapAjax = new HashMap<String, String>();
		MemberVO member2 = memberService.selectCheckMemberNk(mem_nickname);
		if (member2 != null) {
			// 닉네임 중복
			mapAjax.put("result", "nkDuplicated");
		} else {
			mapAjax.put("result", "nkNotFound");
		}
		return mapAjax;
	}
	
	//회원정보수정시 닉네임 유효성 체크
	@RequestMapping("/member/confirmNkMd.do")
	@ResponseBody
	public Map<String, String> confirmNkMd(@RequestParam String mem_nickname) {
		Map<String, String> mapAjax = new HashMap<String, String>();
		MemberVO member = memberService.selectCheckMemberNk(mem_nickname);
		if (member != null) {
			// 닉네임 중복
			mapAjax.put("result", "nkDuplicated");
		} else {
			mapAjax.put("result", "nkNotFound");
		}
		return mapAjax;
	}
	 
	
	/*=====================
	 * 일반 회원가입
	 *=====================*/
	@GetMapping("/member/registerMember.do")
	public String formMember() {
		return "memberRegister";
	}
	// 일반회원가입 처리
	@PostMapping("/member/registerMember.do")
	public String submit(@Valid MemberVO memberVO, BindingResult result,
			Model model, HttpServletRequest request, HttpSession session) {
		// 일반 회원 가입시 auth 값을 2
		memberVO.setMem_auth(2);
		memberVO.getMemberDetailVO().setMem_point(0);

		// 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) { return formMember(); }
		
		// 정상 처리 시 회원가입
		memberService.insertMember(memberVO);
		model.addAttribute("accessMsg", "(일반)회원가입이 완료되었습니다.");

		return "memregresult";
	}
	
	/*=====================
	 * 기업 회원가입
	 *=====================*/
	@GetMapping("/member/registerCompany.do")
	public String formCompany() {
		return "companyRegister";
	}
	// 기업회원가입 처리
	@PostMapping("/member/registerCompany.do")
	public String submitCompany(@Valid MemberVO memberVO, BindingResult result,
								Model model) {
		
		// 기업 회원 가입시 auth 값을 3
		memberVO.setMem_auth(3);

		// 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasErrors()) { return formCompany(); }

		// 정상 처리 시 회원가입
		memberService.insertCompany(memberVO);
		model.addAttribute("accessMsg", "(기업)회원가입이 완료되었습니다.");

		return "memregresult";
	}
	

	/*=====================
	 * 로그인
	 *=====================*/
	// 로그인폼
	@GetMapping("/member/login.do")
	public String formLogin() {
		return "memberLogin";
	}
	// 로그인 데이터 처리
	@PostMapping("/member/login.do")
	public String submitLogin(@Valid MemberVO memberVO, 
							   BindingResult result, 
							   HttpSession session,
							   Model model,
						   	   HttpServletResponse response) {

		// id와 passwd 필드만 유효성 체크 결과 오류가 있으면 폼 호출
		if (result.hasFieldErrors("mem_id") || result.hasFieldErrors("passwd")) {
			return formLogin();
		}
		// 로그인 체크(id, 비밀번호 일치 여부 체크)
		MemberVO member = null;
		try {
			member = memberService.selectCheckMember(memberVO.getMem_id());
			boolean check = false;

			if (member != null) {
				// 비밀번호 일치 여부 체크
				check = member.isCheckedPasswd(memberVO.getPasswd());
			}
			if (check) { // 인증 성공
				
				// 자동 로그인 체크 시작//
				boolean autoLogin = memberVO.getAuto() != null && memberVO.getAuto().equals("on");
				if (autoLogin) {
					// 자동로그인 체크를 한 경우
					String au_id = member.getAu_id();
					if (au_id == null) {
						// 자동로그인 체크 식별값 생성
						au_id = UUID.randomUUID().toString();
						memberService.updateAu_id(au_id, member.getMem_num());
					}

					// 쿠키 생성
					Cookie auto_cookie = new Cookie("au-log", au_id);
					auto_cookie.setMaxAge(60 * 60 * 24 * 7);// 쿠키 유효시간 1주일
					auto_cookie.setPath("/");

					response.addCookie(auto_cookie);
				}
				// 자동 로그인 체크 끝//
				
				if (member.getMem_auth() == 3) {
					// 기업일때 기업정보 세팅
					member = memberService.selectCompany(member.getMem_num());
				} else {
					// 기업이 아닌 회원정보 세팅 (정지, 일반, 관리자)
					member = memberService.selectMember(member.getMem_num());
				}
				// 인증 성공, 로그인 처리
				session.setAttribute("user", member);
				return "redirect:/main/main.do";
			}
			// 인증 실패
			throw new AuthCheckException();

		} catch (AuthCheckException e) {
			// 인증 실패로 로그인폼 호출
			if (member != null && member.getMem_auth() == 1) {
				// 정지회원 메시지 표시
				result.reject("noAuthority");
			} else {
				result.reject("invalidIdOrPassword");
			}
			return formLogin();
		}
	}
	

	/*=====================
	 * 로그아웃
	 *=====================*/
	@RequestMapping("/member/logout.do")
	public String logout(HttpSession session,
						 HttpServletResponse response) {
		// 로그아웃
		session.invalidate();

		// 자동로그인 해제 시작//
		//클라이언트 쿠키 처리
		Cookie auto_cookie = new Cookie("au-log","");
		auto_cookie.setMaxAge(0); //쿠키의 삭제
		auto_cookie.setPath("/");
		
		response.addCookie(auto_cookie);		
		// 자동로그인 해제 끝//

		return "redirect:/main/main.do";
	}

	
	/*=====================
	 * 마이페이지
	 *=====================*/
	@RequestMapping("/member/myPage.do")
	public String myPage(HttpSession session, Model model) {
		
		MemberVO user = (MemberVO) session.getAttribute("user");
		// 회원 정보 반환
		MemberVO member = memberService.selectMember(user.getMem_num());
		MemberVO company = memberService.selectCompany(user.getMem_num());
		
		
		model.addAttribute("member", member);
		model.addAttribute("company", company);
		
		return "myPage";
	}
	
	/*=====================
	 * 일반 회원정보 수정
	 *=====================*/
	@GetMapping("/member/updateMember.do")
	public String formUpdateMember(HttpSession session,
								   Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO memberVO = memberService.selectMember(user.getMem_num());
		model.addAttribute("memberVO", memberVO);
		return "memberModify";
	}
	//전송된 데이터 처리
	@PostMapping("/member/updateMember.do")
	public String submitUpdate(@Valid MemberVO memberVO,
			                   BindingResult result,
			                   HttpSession session) {
		
		//유효성체크결과오류가 있으면 폼호출
		if(result.hasErrors()) {
			return "memberModify";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());
		
		//회원정보변경
		memberService.updateMember_detail(memberVO);
		
		return "redirect:/member/myPage.do";
	}
	
	/*=====================
	 * 기업 회원정보 수정
	 *=====================*/
	@GetMapping("/member/updateCompany.do")
	public String formUpdateCompany(HttpSession session,
								    Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO memberVO = memberService.selectCompany(user.getMem_num());
		model.addAttribute("memberVO", memberVO);
		return "companyModify";
	}
	//전송된 데이터 처리
	@PostMapping("/member/updateCompany.do")
	public String submitUpdateCompany(@Valid MemberVO memberVO,
									  BindingResult result,
									  HttpSession session) {
		//유효성체크결과오류가 있으면 폼호출
		if(result.hasErrors()) {
			return "companyModify";
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());
		
		//회원정보변경
		memberService.updateCompany(memberVO);
		
		return "redirect:/member/myPage.do";
	}	
	
	/*=====================
	 * 닉네임 변경
	 *=====================*/
	//닉네임 변경 폼 호출
	@GetMapping("/member/changeNkMd.do")
	public String formChangeNkMd(HttpSession session,
			   					 Model model) {
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		MemberVO memberVO = memberService.selectMember(user.getMem_num());
		model.addAttribute("memberVO", memberVO);
		
		return "memberChangeNkMd";
	}
	@PostMapping("/member/changeNkMd.do")
	public String submitchangeNk(@Valid MemberVO memberVO,
			                     BindingResult result,
			                     HttpSession session) {
		
		//유효성체크결과오류가 있으면 폼호출
		//if(result.hasErrors()) { return "memberChangeNkMd"; }
		 
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());
		
		//닉네임변경
		memberService.updateMemberNk(memberVO);
		
		return "redirect:/member/myPage.do";
	}
	
	/*=====================
	 * 마이페이지 : 비밀번호변경
	 *=====================*/
	//비밀번호 변경 폼 호출
	@GetMapping("/member/changePasswd.do")
	public String formChangePasswd() {
		return "memberChangePasswd";
	}
	//전송된 데이터 처리
	@PostMapping("/member/changePasswd.do")
	public String submitChangePasswd(@Valid MemberVO memberVO,
									 BindingResult result,
									 HttpSession session,
									 HttpServletRequest request,
									 Model model) {
		
		//now_passwd와 passwd 유효성 체크 결과 오류가 있으면 폼 호출
		if(result.hasFieldErrors("now_passwd") || 
				result.hasFieldErrors("passwd")) {
			return formChangePasswd();
		}
		
		MemberVO user = (MemberVO)session.getAttribute("user");
		memberVO.setMem_num(user.getMem_num());
		
		if(user.getMem_auth()==3) {
			MemberVO db_member = memberService.selectCompany(memberVO.getMem_num());
			
			//폼에서 전송한 현재 비밀번호와 DB에서 받아온 비밀번호 일치 여부 체크
			if(!db_member.getPasswd().equals(memberVO.getNow_passwd())) {
				//DB에 등록된 비밀번호와 입력한 비밀번호가 불일치
				result.rejectValue("now_passwd", "invalidPassword");
				return formChangePasswd();
			}
		}else {
			MemberVO db_member = memberService.selectMember(memberVO.getMem_num());
			
			if(!db_member.getPasswd().equals(memberVO.getNow_passwd())) {
				result.rejectValue("now_passwd", "invalidPassword");
				return formChangePasswd();
			}
		}
		
		//비밀번호 변경
		memberService.updatePasswd(memberVO);
		
		/* 비밀번호 변경시 자동로그인 기능 해제 */
		//설정되어 있는 자동로그인 기능 해제 ( 모든 브라우저에 설정된 자동로그인 해제 )
		memberService.deleteAu_id(memberVO.getMem_num());
		
		//View에 표시할 메시지 처리
		model.addAttribute("message", 
				"비밀번호변경 완료(*재접속시 설정되어 있는 자동로그인 기능 해제)");
		model.addAttribute("url", 
				request.getContextPath() + "/member/myPage.do");
		
		return "common/resultView";
	}
	
	/*=====================
	 * 마이페이지 : 프로필사진
	 *=====================*/
	//프로필 사진 출력(로그인 전용)
	@RequestMapping("/member/photoView.do")
	public String getProfile(HttpSession session,
							 HttpServletRequest request,
							 Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user==null) { //로그인이 안된 경우
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			// model을 이용한 전달
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		}else { //로그인 된 경우
			MemberVO memberVO;
			if(user.getMem_auth()==3) {
				memberVO = memberService.selectCompany(user.getMem_num());
			}else{
				memberVO = memberService.selectMember(user.getMem_num());
			}
			viewProfile(memberVO,request,model);
		}
		return "imageView";
	}
	 
	//프로필 사진 출력 (회원번호 지정)
	@RequestMapping("/member/viewProfile.do")
	public String getProfileByMem_num(@RequestParam int mem_num,
									  HttpServletRequest request,
									  Model model) {
		MemberVO memberVO = memberService.selectMember(mem_num);
		viewProfile(memberVO, request, model);
		
		return "imageView";
	}
	
	//프로필 사진 처리를 위한 공통 코드
	public void viewProfile(MemberVO memberVO, HttpServletRequest request, Model model) {
		
		if (memberVO == null || (memberVO.getMem_auth()==3 &&  memberVO.getCompanyDetailVO().getComp_photoname()==null) || (memberVO.getMem_auth()==2 &&  memberVO.getMemberDetailVO().getMem_photoname()==null)) {
			// 업로드한 프로필 사진이 없는 경우
			
			// 기본 이미지 읽기
			byte[] readbyte = FileUtil.getBytes(request.getServletContext().getRealPath("/image_bundle/face.png"));
			// model을 이용한 전달
			model.addAttribute("imageFile", readbyte);
			model.addAttribute("filename", "face.png");
		
		} else { // 업로드한 프로필 사진이 있는 경우
			if(memberVO.getMem_auth()==3) {
				model.addAttribute("imageFile", memberVO.getCompanyDetailVO().getComp_photo());
				model.addAttribute("filename", memberVO.getCompanyDetailVO().getComp_photoname());
			}else {
				model.addAttribute("imageFile", memberVO.getMemberDetailVO().getMem_photo());
				model.addAttribute("filename", memberVO.getMemberDetailVO().getMem_photoname());
			}
			
		}

	}
	//프로필 사진 업데이트
	@RequestMapping("/member/updateMyPhoto.do")
	@ResponseBody
	public Map<String,String> updateProfile(MemberVO memberVO,
											HttpSession session){
		//updateComProfile
		Map<String,String> mapAjax = new HashMap<String,String>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		if(user==null) {
			mapAjax.put("result", "logout");
			
		}else {
			memberVO.setMem_num(user.getMem_num());
			if (user.getMem_auth() == 2) {
				memberService.updateProfile(memberVO);
			}else if(user.getMem_auth() == 3) {
				memberService.updateComProfile(memberVO);
			}
			
			mapAjax.put("result", "success");
		}
		
		return mapAjax;
	}

	
	/*=====================
	 * 일반 회원탈퇴
	 *=====================*/
	@GetMapping("/member/deleteMember.do")
	public String formDeleteMember() {
		return "memberDelete";
	}

	// 전송된 데이터 처리
	@PostMapping("/member/deleteMember.do")
	public String submitDeleteMember(@Valid MemberVO memberVO, BindingResult result, HttpSession session, Model model) {

		// id와 passwd 필드만 유효성 체크
		// 유효성 체크 결과 오류가 있으면폼 호출
		if (result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return formDeleteMember();
		}

		MemberVO user = (MemberVO) session.getAttribute("user");
		MemberVO db_member = memberService.selectMember(user.getMem_num());

		boolean check = false;

		// 아이디 비밀번호 일치 여부 체크
		try {
			if (db_member != null && db_member.getMem_id().equals(memberVO.getMem_id())) {
				// 비밀번호 일치 여부 체크
				check = db_member.isCheckedPasswd(memberVO.getPasswd());
			}
			if (check) {
				// 인증성공, 회원정보 삭제
				memberService.deleteMember(user.getMem_num());
				// 로그아웃
				session.invalidate();
				model.addAttribute("accessMsg", "회원탈퇴를 완료했습니다.");
				return "memregresult2";
			}
			// 인증실패
			throw new AuthCheckException();
		} catch (AuthCheckException e) {
			result.reject("invalidIdOrPassword");
			return formDeleteMember();
		}
	}
	
	/*=====================
	 * 기업회원 탈퇴
	 *=====================*/
	@GetMapping("/member/deleteCompany.do")
	public String formDeleteCompany() {
		return "companyDelete";
	}
	// 전송된 데이터 처리
	@PostMapping("/member/deleteCompany.do")
	public String submitDeleteCompany(@Valid MemberVO memberVO, BindingResult result, HttpSession session, Model model) {

		// id와 passwd 필드만 유효성 체크
		// 유효성 체크 결과 오류가 있으면폼 호출
		if (result.hasFieldErrors("id") || result.hasFieldErrors("passwd")) {
			return formDeleteCompany();
		}

		MemberVO user = (MemberVO) session.getAttribute("user");
		MemberVO db_member = memberService.selectCompany(user.getMem_num());
		
		boolean check = false;

		// 아이디 비밀번호 일치 여부 체크
		try {
			if (db_member != null && db_member.getMem_id().equals(memberVO.getMem_id())) {
				// 비밀번호 일치 여부 체크
				check = db_member.isCheckedPasswd(memberVO.getPasswd());
			}
			if (check) {
				// 인증성공, 회원정보 삭제
				memberService.deleteCompany(user.getMem_num());
				// 로그아웃
				session.invalidate();
				model.addAttribute("accessMsg", "회원탈퇴를 완료했습니다.");
				return "memregresult2";
			}
			// 인증실패
			throw new AuthCheckException();
		} catch (AuthCheckException e) {
			result.reject("invalidId	OrPassword");
			return formDeleteCompany();
		}
	}
	
	/*=====================
	 * 일반회원 티켓구매내역
	 *=====================*/
	@RequestMapping("/member/memberMypageTicketList.do")
	public ModelAndView memberTicketList(@RequestParam(value="pageNum", defaultValue="1") int currentPage, String keyfield, String keyword, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num());
		
		// 전체/검색 레코드수
		int count = memberService.selectTicketCountByMem_num(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage, count, 20, 10, "memberMypageTicketList.do");
		
		List<TicketVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectListTicketByMem_num(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberMypageTicketList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}
	
	/*=====================
	 * 일반회원 푸드구매내역
	 *=====================*/	
	@RequestMapping("/member/memberMypageFoodList.do")
		public ModelAndView memberMypageFoodList(@RequestParam(value="pageNum",
												 defaultValue="1") int currentPage,
			                                     String keyfield, String keyword,
			                                     HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyfield", keyfield);
		map.put("keyword", keyword);
		map.put("mem_num", user.getMem_num()); 
		
		//전체/검색 레코드수
		int count = memberService.selectOrderCountByMem_num(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(keyfield,keyword,currentPage,
				               count,20,10,"orderList.do");
		
		List<F_orderVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = memberService.selectListOrderByMem_num(map);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberMypageFoodList");
		mav.addObject("count", count);
		mav.addObject("list", list);
		mav.addObject("page", page.getPage());
		
		return mav;
	}	

	/*====================
	 * 일반회원 푸드구매상세
	 *====================*/
	@RequestMapping("/member/memberMypageFoodDetail.do")
	public String memberMypageFoodDetail (@RequestParam String f_order_num,
										  HttpSession session,
										  Model model) {
		
		
		//주문번호(f_order_num)를 통하여 모든 정보를 출력함.
		Map<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)session.getAttribute("user");
		
		map.put("f_order_num", f_order_num);
		map.put("mem_num", user.getMem_num());
		
		//주문정보 호출
		F_orderVO f_order = memberService.selectF_order(map);
		//개별 상품 주문정보 호출
		List<F_order_detailVO> detailList = memberService.selectListF_orderDetail(f_order_num);
		
		model.addAttribute("f_order", f_order);
		model.addAttribute("list", detailList);
		
		return "memberMypageFoodDetail";
	}
	
	/*====================
	 * 사용자 주문취소
	 *====================*/
	@RequestMapping("/member/orderCancel.do")
	public String submitCancel(@RequestParam String f_order_num,
			                   Model model, HttpSession session,
			                   HttpServletRequest request) {
		//주문취소
		F_orderVO vo = new F_orderVO();
		
		vo.setF_order_num(f_order_num);
		vo.setF_order_status(9); // 1:사용전 0:사용후 9:주문취소
		memberService.updateOrderStatus(vo);
		
		model.addAttribute("message", "주문취소가 완료되었습니다.");
		model.addAttribute("url", 
				request.getContextPath()+"/member/memberMypageFoodList.do");
		
		return "common/resultView";
	}  
	
	/*=====================
	 * 일반회원 굿즈구매내역
	 *=====================*/
	@RequestMapping("/member/memberMypageGoodList.do")
	public String memberGoodList(HttpSession session, Model model) {
		
		return "memberMypageGoodList";
	}
}
