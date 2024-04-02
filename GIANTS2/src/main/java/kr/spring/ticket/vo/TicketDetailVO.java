package kr.spring.ticket.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketDetailVO {
	private int detail_num;
	private String ticket_num;
	private String seat_info;
}
