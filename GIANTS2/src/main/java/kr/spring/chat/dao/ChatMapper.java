package kr.spring.chat.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.spring.chat.vo.ChatRoomVO;
import kr.spring.chat.vo.ChatVO;

@Mapper
public interface ChatMapper {
	//채팅방 번호 생성
	@Select("SELECT chatroom_seq.nextval FROM dual")
	public int selectChatRoomNum();
	
	//채팅방 생성
	@Insert("INSERT INTO chatroom (chatroom_num, trade_num, seller_num, buyer_num) VALUES (#{chatroom_num}, #{trade_num}, #{seller_num}, #{buyer_num})")
	public void insertChatRoom(ChatRoomVO chatRoomVO);
	
	//이미 존재하는 채팅방
	@Select("SELECT * FROM chatroom WHERE trade_num=#{trade_num} AND buyer_num=#{buyer_num}")
	public ChatRoomVO selectExistedChatRoom(Integer trade_num, Integer buyer_num);
	
	//채팅방 정보 불러오기
	@Select("SELECT * FROM chatroom WHERE chatroom_num=#{chatroom_num}")
	public ChatRoomVO selectChatRoom(Integer chatroom_num);	
	
	//채팅 메시지 번호 생성
	@Select("SELECT chat_seq.nextval FROM dual")
	public int selectChatNum();		
	
	//채팅 메시지 등록
	public void insertChat(ChatVO chatVO);
	
	//채팅 멤버 읽기
	public ChatRoomVO selectChatMember(Integer chatroom_num);

	//읽지 않은 채팅 기록 저장
	@Insert("INSERT INTO chat_read(chatroom_num,chat_num,mem_num) VALUES(#{chatroom_num},#{chat_num},#{mem_num})")
	public void insertChatRead(@Param(value="chatroom_num") int chatroom_num, 
							   @Param(value="chat_num") int chat_num, 
							   @Param(value="mem_num") int mem_num);
	
	//채팅 메시지 읽기
	public List<ChatVO> selectChatDetail(Map<String,Integer> map);

	//읽은 채팅 기록 삭제 (메시지 읽음 처리)
	@Delete("DELETE FROM chat_read WHERE chatroom_num=#{chatroom_num} AND mem_num=#{mem_num}")
	public void deleteChatRead(Map<String,Integer> map);

 	//채팅방 목록
	public List<ChatRoomVO> selectChatRoomList(Map<String, Object> map);
	public int selectRowCount(Map<String, Object> map);
	
	//채팅방 나가기
	/*
	public void deleteChatRoomMember(ChatRoomVO chatroomVO);
	@Delete("DELETE FROM chat WHERE chatroom_num=#{chatroom_num}")
	public void deleteChat(Integer chatroom_num);
	@Delete("DELETE FROM chatroom WHERE chatroom_num=#{chatroom_num}")
	public void deleteChatRoom(Integer chatroom_num);
	*/
}
