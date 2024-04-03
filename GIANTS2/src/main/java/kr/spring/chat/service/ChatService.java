package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;

public interface ChatService {
	//채팅방 번호 생성
	public int selectChatRoomNum();
	
	//채팅방 생성
	public void insertChatRoom(ChatRoomVO chatRoomVO);
	
	//이미 존재하는 채팅방
	public ChatRoomVO selectExistedChatRoom(Integer trade_num, Integer buyer_num);
	
	//채팅방 정보 불러오기
	public ChatRoomVO selectChatRoom(Integer chatroom_num);
	
	//채팅 메시지 등록
	public void insertChat(ChatVO chatVO);
	
	//채팅 메시지 읽기
	public List<ChatVO> selectChatDetail(Map<String,Integer> map);
	
	//채팅방 목록
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	
}
