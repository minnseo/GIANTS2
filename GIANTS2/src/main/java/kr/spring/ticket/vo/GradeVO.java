package kr.spring.ticket.vo;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GradeVO {
	private int grade_num;		// 등급 구분 번호
	private int game_num;		// 경기 번호
	@NotEmpty
	private String title;		// 등급 이름
	@Range(min=0, max=999999)
	private int price_week;		// 주중 가격
	@Range(min=0, max=999999)
	private int price_weekend;	// 주말 가격
	
	private int quantity;
}
