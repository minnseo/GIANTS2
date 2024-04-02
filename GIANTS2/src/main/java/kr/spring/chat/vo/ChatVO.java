package kr.spring.chat.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatVO {
	private int chat_num; //채팅 번호
	private int chatroom_num; //수신 그룹
	private int mem_num; //발신자
	private String message; //메시지
	private String chat_date; //채팅 메시지 발송 날짜
	
	private int read_count; //채팅 메시지를 읽지 않은 회원 수
	private String mem_id; //발신자 id
	private String mem_nickname; //발신자 닉네임
}
