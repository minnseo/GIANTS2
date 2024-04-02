package kr.spring.ticket.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TicketVO {
	private String ticket_num;
	private int mem_num;
	private int game_num;
	private String ticket_date;
	private Date ticket_modify;

	private int grade_num;
	private int status_num;
	private int check_num;
	
	private String order_name;
	private String order_phone;
	private String order_email;
	private String game_title;
	private String game_date;
	private String game_time;
	private int ticket_quantity;
	private int total_price;
	private String pg;
	private String pay_method;
	private int ticket_status;
	
	private String qrlink;
	private int order_status;
}
