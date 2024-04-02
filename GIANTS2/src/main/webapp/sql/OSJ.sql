---------------------------------------------------------------------------------- 오세진 OSJ
--푸드 테이블
CREATE TABLE FOOD(
  food_num number not null,						--식품번호
  food_name varchar2(200) not null,				--식품 상품명
  food_price number(9) not null,				--식품 가격
  food_quantity number(9) not null,				--식품 재고 수량
  food_content clob,							--식품 상세설명 텍스트
  food_photo1 blob not null,					--식품 메인 페이지용
  food_photo1_name varchar2(100) not null,		--메인이미지 이름
  food_photo2 blob,								--식품 상세 페이지용
  food_photo2_name varchar2(100),				--상세이미지 이름
  food_regDate date DEFAULT SYSDATE not null,	--식품 정보 등록날짜
  food_modifyDate date,							--식품 정보 수정날짜
  food_status number DEFAULT 1 not null,		--식품 판매상태 확인여부용(기본값 : 1)
  comp_num varchar2(40) not null,						--식품 판매자 정보 식별 번호
  CONSTRAINT food_pk PRIMARY KEY (food_num),
  CONSTRAINT food_fk1 FOREIGN KEY (comp_num) references COMPANY_DETAIL (comp_num)
);



--식품 장바구니 테이블
CREATE TABLE F_CART(
  cart_num number not null,					--식품 장바구니 식별 번호
  food_num number not null,                 --식품 정보 식별 번호
  mem_num number not null,                  --구매자 식별 번호
  f_cart_quantity number(9) not null,       --식품 구매수량
  f_cart_price number(9) not null,          --식품 장바구니 총 가격
  CONSTRAINT f_cart_pk PRIMARY KEY (cart_num),
  CONSTRAINT f_cart_fk1 FOREIGN KEY (food_num) references FOOD (food_num),
  CONSTRAINT f_cart_fk2 FOREIGN KEY (mem_num) references MEMBER (mem_num)
);



--식품 주문정보 테이블
CREATE TABLE F_ORDER(
  f_order_num varchar2(20) not null,
  food_num number not null,                 		--식품 정보 식별 번호
  mem_num number not null,                  		--구매자 식별 번호
  comp_num varchar2(40) not null,					--기업 정보 식별 번호
  f_order_regDate date DEFAULT SYSDATE not null,    --식품 주문 등록날짜
  f_order_expireDate date not null,                 --식품 주문 유효기간
  f_order_status number DEFAULT 1 not null,         --QR 사용 여부 확인용
  f_order_qrlink clob not null,                     --QR 이미지생성후 링크 저장용
  pg varchar2(30) not null,                         --PG사 구분 코드
  pay_method varchar2(30) not null,                 --결제수단 구분 코드
  CONSTRAINT f_order_pk PRIMARY KEY (f_order_num),
  CONSTRAINT f_order_fk1 FOREIGN KEY (food_num) references FOOD (food_num),
  CONSTRAINT f_order_fk2 FOREIGN KEY (mem_num) references MEMBER (mem_num),
  CONSTRAINT f_order_fk3 FOREIGN KEY (comp_num) references COMPANY_DETAIL (comp_num)
);

--식품 주문정보 식별 번호 시퀀스
--굿즈, 식품, 티켓 모두 시퀀스를 공유하여 사용함.


--식품 주문 상세정보 테이블
CREATE TABLE F_ORDER_DETAIL(
  f_detail_num number not null,						--식품 주문상세정보 식별 번호
  food_num number not null,                         --식품 정보 식별 번호
  f_order_num varchar2(20) not null,                --식품 주문정보 식별 번호
  order_quantity number(5) not null,                --주문 개수
  food_name varchar2(200),                          --식품 상품명
  food_price number(9),                             --식품 가격
  food_total number(9),                             --동일상품 합산 금액
  CONSTRAINT f_order_detail_pk PRIMARY KEY (f_detail_num),
  CONSTRAINT f_order_detail_fk1 FOREIGN KEY (food_num) references FOOD (food_num),
  CONSTRAINT f_order_detail_fk2 FOREIGN KEY (f_order_num) references F_ORDER (f_order_num)
);




--식품 매장 후기 테이블
CREATE TABLE FOOD_REVIEW(
  review_num number not null,                         --상품 후기 식별번호
  mem_num number not null,                            --회원 식별 번호
  comp_num varchar2(40) NOT null,                           --기업 식별 번호
  comp_score number(1) not null,                      --매장 별점 평균점수
  review_title varchar2(100) not null,                     --회원작성 후기 제목
  review_content clob not null,                       --회원작성 후기 내용
  review_regdate date DEFAULT SYSDATE not null,       --회원후기 작성일(default: SYSDATE)
  review_mdate date,                                  --회원후기 수정일
  CONSTRAINT food_review_pk PRIMARY KEY (review_num),
  CONSTRAINT food_review_fk1 FOREIGN KEY (mem_num) references MEMBER (mem_num),
  CONSTRAINT food_review_fk2 FOREIGN KEY (comp_num) references COMPANY_DETAIL (comp_num)
);




------------------------------시퀀스
--식품 식별 번호 시퀀스
CREATE SEQUENCE food_seq;
--식품 장바구니 식별 번호 시퀀스
CREATE SEQUENCE f_cart_seq;
--식품 주문 상세정보 시퀀스
CREATE SEQUENCE f_order_detail_seq;
--식품 매장 후기 시퀀스
CREATE SEQUENCE food_review_seq;