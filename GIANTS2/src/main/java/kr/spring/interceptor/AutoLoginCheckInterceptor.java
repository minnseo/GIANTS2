package kr.spring.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AutoLoginCheckInterceptor implements HandlerInterceptor{
	//au_id를 저장 (자동 로그인에 사용되는 유니크 식별값)
	
	//table access
	@Autowired
	MemberService memberService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			                 HttpServletResponse response,
			                 Object handler)throws Exception{
		log.debug("<<AutoLoginCheckInterceptor 진입>>");
		
		//아래 findCookie 호출
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) {
			//로그인x시 쿠키
			Cookie now_cookie = findCookie(request.getCookies(), "au-log");
			if(now_cookie != null) {
				//au_id를 읽어옴
				MemberVO memberVO = 
						memberService.selectAu_id(now_cookie.getValue());
				log.debug("<<자동로그인 처리 MemberVO>> : " + memberVO);
				if(memberVO != null && memberVO.getMem_auth() > 2) {
					//일반회원부터 자동로그인 할 수 있도록 처리(탈퇴, 정지회원 불가)
					session.setAttribute("user", memberVO);
					log.debug("<<자동로그인 성공>>");
				}
			}
		}
		
		return true;
	}
	
	private Cookie findCookie(Cookie[] cookies, String name) {
		if(cookies == null || cookies.length == 0) {
			return null; //쿠기가 없다
		}
		else {
			for(int i=0; i<cookies.length; i++) {
				String cookie_name = cookies[i].getName();
				if(cookie_name.equals(name)) {
					return cookies[i]; //원하는 쿠키를 추출
				}
			}
			return null;
		}
	}
	
}
