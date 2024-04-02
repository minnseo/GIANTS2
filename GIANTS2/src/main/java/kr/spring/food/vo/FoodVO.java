package kr.spring.food.vo;

import java.io.IOException;
import java.sql.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Range;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString(exclude = {"food_photo1","food_photo2"})
public class FoodVO {						//논리명					키 분류
	private int food_num;					//식품번호					PK
	private String comp_num;                //기업식별번호				FK
	@NotEmpty
	private String food_name;               //식품명
	@Range(min=1, max=99999999)
	private int food_price;                 //식품가격
	@Range(min=0, max=99999999)
	private int food_quantity;              //식품재고수량
	@NotEmpty
	private String food_content;            //식품 설명 텍스트
	private byte[] food_photo1;             //식품 메인이미지
	private String food_photo1_name;        //식품 메인이미지 명
	private byte[] food_photo2;             //식품 상세이미지
	private String food_photo2_name;        //식품 상세이미지 명
	private Date food_regDate;              //식품 등록날짜
	private Date food_modifyDate;           //식품 수정날짜
	@NotNull
	private int food_status;             //식품 판매상태 ex) 2:판매중, 1:판매중지(상품준비중)
	
	//업로드 파일 처리 - 메인
	public void setUpload1(MultipartFile upload1)throws IOException{
		//MultipartFile -> byte[] 변환
		setFood_photo1(upload1.getBytes());
		//파일명 구하기
		setFood_photo1_name(upload1.getOriginalFilename());
	}
	
	//업로드 파일 처리 - 상세
	public void setUpload2(MultipartFile upload2)throws IOException{
		//MultipartFile -> byte[] 변환
		setFood_photo2(upload2.getBytes());
		//파일명 구하기
		setFood_photo2_name(upload2.getOriginalFilename());
	}
}
