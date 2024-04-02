package kr.spring.news.vo;

import javax.validation.constraints.NotEmpty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NewsVO {
	private int news_num;
	@NotEmpty
	private String news_title;
	@NotEmpty
	private String news_content;
	private String news_regdate;
	private String news_mdate;
	private int news_hit;
	private int mem_num;
	
	private String mem_id;
	private String mem_nickname;
}
