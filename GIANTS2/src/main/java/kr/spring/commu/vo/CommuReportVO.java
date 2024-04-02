package kr.spring.commu.vo;


import java.sql.Date;

import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommuReportVO {
	private int repo_num; //신고 번호
	private Date repo_date; //신고 날짜
	private String repo_ip; //신고자 ip
	private String repo_content; //신고내용
	@NotNull
	private int repo_category; //신고범위
	private int commu_num; //커뮤니티 번호
	private int mem_num; //신고자 회원번호
	private String mem_nickname;
	
	//private String status;  
	
	
}
