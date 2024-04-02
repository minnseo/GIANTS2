package kr.spring.ticket.vo;

import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Range;

import kr.spring.member.vo.MemberDetailVO;
import kr.spring.member.vo.MemberVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatVO {
	private int seat_num;	// 좌석 구분번호
	private int grade_num;	// 등급 구분번호
	@Range(min=1, max=935)
	private int seat_block;	// 블록 번호
	@NotEmpty
	private String seat_row;// 좌석 행 배열
	@NotEmpty
	private String seat_col;// 좌석 열 배열
	@NotEmpty
	private int seat_quantity;
	
	private MemberDetailVO detailVO;
	
	private int seatB;	// 선택한 블럭 번호
	private String seatR;	// 선택한 좌석 행
	private String seatC;	// 선택한 좌석 열
	
	private String seat;
	private String seat_info;
}
