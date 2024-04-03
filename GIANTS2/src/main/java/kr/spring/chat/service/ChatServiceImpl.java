package kr.spring.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.chat.dao.ChatMapper;
import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ChatServiceImpl implements ChatService{
	@Autowired
	ChatMapper chatMapper;
	
	//채팅방 번호 생성
	@Override
	public int selectChatRoomNum() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	//채팅방 생성
	@Override
	public void insertChatRoom(ChatRoomVO chatRoomVO) {
		//기본키 생성
		chatRoomVO.setChatroom_num(chatMapper.selectChatRoomNum());
		//채팅방 생성
		chatMapper.insertChatRoom(chatRoomVO);
	}
	
	//이미 존재하는 채팅방
	@Override
	public ChatRoomVO selectExistedChatRoom(Integer trade_num, Integer buyer_num) {
		return chatMapper.selectExistedChatRoom(trade_num, buyer_num);
	}
	
	//채팅방 정보 불러오기
	@Override
	public ChatRoomVO selectChatRoom(Integer chatroom_num) {
		return chatMapper.selectChatRoom(chatroom_num);
	}
	
	//채팅 메시지 등록
	@Override
	public void insertChat(ChatVO chatVO) {
		//채팅 번호를 생성해서 자바빈에 저장
		chatVO.setChat_num(chatMapper.selectChatNum());
		//채팅 메시지 저장
		chatMapper.insertChat(chatVO);
		//채팅방 멤버가 읽지 않은 채팅 정보를 저장
		ChatRoomVO vo = chatMapper.selectChatMember(chatVO.getChatroom_num());
		chatMapper.insertChatRead(chatVO.getChatroom_num(), chatVO.getChat_num(), vo.getSeller_num()); 
		chatMapper.insertChatRead(chatVO.getChatroom_num(), chatVO.getChat_num(), vo.getBuyer_num());							  
	}
	
	//채팅 메시지 읽기
	@Override
	public List<ChatVO> selectChatDetail(Map<String, Integer> map) {
		//읽은 채팅 기록은 삭제
		chatMapper.deleteChatRead(map);
		//채팅 메시지 반환
		return chatMapper.selectChatDetail(map);
	}
	
	//채팅방 목록
	@Override
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map) {
		return chatMapper.selectChatRoomList(map);
	}
	
	//채팅방 레코드 수
	@Override
	public int selectRowCount(Map<String, Object> map) {
		return chatMapper.selectRowCount(map);
	}
	
}
