package kr.spring.food.vo;

import java.sql.Date;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Food_reviewVO {				//논리명			키 분류
	private int review_num;				//후기번호			PK
	private int mem_num;				//회원번호			FK
	private String comp_num;			//기업번호			FK
	private int comp_score;				//기업평점		
	@NotEmpty
	private String review_title;		//후기제목
	@NotEmpty
	private String review_content;		//후기내용
	private Date review_regdate;		//후기 작성일
	private Date review_mdate;			//후기 수정일
	@NotEmpty
	private String comp_rate;
	
	private String name;				//작성자명 = buyerName
}
