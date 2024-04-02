package kr.spring.ticket.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GameVO {
	private int grade_num;
	private int game_num;		// 경기구분번호
	@Pattern(regexp="^(202[34])-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$")
	private String game_date;	// 경기일자
	@Pattern(regexp="^(0[0-9]|1[0-9]|2[0-3]):(0[1-9]|[0-5][0-9])$")
	private String game_time;	// 경기시작시간
	@NotEmpty 
	private String game_team;	// 상태팀이름
	private int game_state;		// 경기예매가능여부
	@Range(min=0, max=1)
	private int game_week;		// 주중(0) or 주말(1)
	
	private GradeVO gradeVO;
	private SeatVO seatVO;
}
