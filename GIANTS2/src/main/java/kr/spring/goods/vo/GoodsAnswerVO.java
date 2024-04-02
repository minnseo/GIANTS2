package kr.spring.goods.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GoodsAnswerVO {
	private int gans_num;
	private String gans_content;
	private String gans_regdate;
	private String gans_mdate;
	private int mem_num;
	private int qna_num;
	
	private String mem_id;
}
