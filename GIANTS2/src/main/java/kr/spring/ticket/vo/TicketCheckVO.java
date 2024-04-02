package kr.spring.ticket.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketCheckVO {
	private int check_num;
	private int seat_num;	// 블록 구분
	private String seat_info;
	private int game_num;
	private int mem_num;
}
