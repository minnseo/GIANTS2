package kr.spring.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.chat.service.ChatService;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;
//import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.trading.service.TradingService;
import kr.spring.util.PagingUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ChatController {
	@Autowired
	private ChatService chatService;;
	//@Autowired
	//private MemberService memberService;
	@Autowired
	private TradingService tradingService;
	
	/* =================
	 *    채팅방 생성
	 * =============== */
	@PostMapping("/chat/chatRoomWrite.do")
	@ResponseBody
	public Map<String,Object> chatRoomWrite(ChatRoomVO vo, HttpSession session, Model model) {
		log.debug("<<채팅방 만들기>> : " + vo);
		
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		//로그인한 회원만 채팅 가능
		MemberVO user = (MemberVO)session.getAttribute("user");

		if(user == null) {
			mapJson.put("result", "logout");
		}else {
			vo.setBuyer_num(user.getMem_num());
			vo.setSeller_num(tradingService.selectMemNumByTradeNum(vo.getTrade_num()));
			
			ChatRoomVO chatroom = chatService.selectExistedChatRoom(vo.getTrade_num(), vo.getBuyer_num());
			
			//로그인한 회원번호(구매자)와 게시글 작성자(판매자) 회원번호가 같은지 체크
			if(user.getMem_num() == vo.getSeller_num()) {
				mapJson.put("result", "samePerson");
				
			//기존에 만들어진 채팅방이 있는지 체크(trade_num, buyer_num)
			} else if(chatroom != null) { 
				mapJson.put("result", "alredyExist");
				mapJson.put("chatroom_num", chatroom.getChatroom_num());
			} else{
				vo.setChatroom_num(chatService.selectChatRoomNum());
				vo.setTrade_num(vo.getTrade_num());
				
				chatService.insertChatRoom(vo);
				mapJson.put("result", "success");
				mapJson.put("chatroom_num", vo.getChatroom_num());
			}
			
		}

		return mapJson; 
	}

	/* =================
	 * 채팅 메시지 처리
	 * =============== */
	//채팅 메시지 페이지 호출
	@GetMapping("/chat/chatting.do")
	public String chatting(@RequestParam int chatroom_num, Model model) {
		ChatRoomVO chatroomVO = (ChatRoomVO)chatService.selectChatRoom(chatroom_num);
		model.addAttribute("chatroomVO", chatroomVO);
		
		return "chat/chatting"; //jsp 파일명 (tiles 설정 x) 
	}
	//채팅 메시지 전송
	@RequestMapping("/chat/writeChat.do")
	@ResponseBody
	public Map<String,Object> writeChatAjax(ChatVO vo, HttpSession session){
		log.debug("<<채팅 등록>>");
		Map<String,Object> mapJson = new HashMap<String,Object>();
		//로그인 체크
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인 X
			mapJson.put("result", "logout");
		}else { //로그인 O
			vo.setMem_num(user.getMem_num()); //발신자
			
			log.debug("<<채팅 메시지 전송>> : " + vo);
			
			chatService.insertChat(vo);
			mapJson.put("result", "success");
		}
		
		return mapJson;
	}
	
	//채팅 메시지 읽기
	@RequestMapping("/chat/chatDetailAjax.do")
	@ResponseBody
	public Map<String,Object> chatDetailAjax(@RequestParam int chatroom_num, HttpSession session){
		Map<String,Object> mapJson = new HashMap<String,Object>();
		
		//로그인 체크
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null) { //로그인 X
			mapJson.put("result", "logout");
		}else { //로그인 O
			Map<String,Integer> map = new HashMap<String,Integer>();
			map.put("chatroom_num", chatroom_num);
			map.put("mem_num", user.getMem_num());
			//데이터 읽어와서 list에 저장
			List<ChatVO> list = chatService.selectChatDetail(map);
			
			mapJson.put("result", "success");
			mapJson.put("list", list);
			mapJson.put("user_num", user.getMem_num());
		}
		
		return mapJson;
	}
	
	/* =================
	 * 채팅방 목록
	 * =============== */
	@RequestMapping("/chat/chatList.do")
	public String chatList(@RequestParam(value = "pageNum", defaultValue = "1") int currentPage, HttpSession session, Model model) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		Map<String,Object> map = new HashMap<String, Object>();
		//로그인한 회원번호가 판매자/구매자의 회원번호와 일치하는 2가지 경우 모두 체크
		map.put("seller_num", user.getMem_num());
		map.put("buyer_num", user.getMem_num());
		map.put("user_mem_num", user.getMem_num());
		
		int count = chatService.selectRowCount(map);
		
		//페이지 처리
		PagingUtil page = new PagingUtil(null, null, currentPage, count, 30, 10, "chatList.do");
		
		List<ChatRoomVO> list = null;
		if(count > 0) {
			map.put("start", page.getStartRow());
			map.put("end", page.getEndRow());
			
			list = chatService.selectChatRoomList(map);
		}
		log.debug("<<list>> : "+list);
		//Model을 이용한 세팅정보 불러오기
		model.addAttribute("count", count);
		model.addAttribute("list", list);
		model.addAttribute("page", page.getPage());
		return "chatList";
	}

}