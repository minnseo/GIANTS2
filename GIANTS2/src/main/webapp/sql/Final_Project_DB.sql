--2023-07-28 오후 2시
--프로젝트 통쿼리
--총 테이블 34개

----------------------------------------------------------------------------------윤현종 YHJ
--회원 정보 테이블
create table MEMBER(
	mem_num number,
	mem_id varchar2(12) unique NOT null,
	mem_nickname varchar2(30),
	mem_auth number(1),
    passwd varchar2(35) NOT null,
	constraint MEMBER_PK primary key (mem_num)
);

--회원 상세 정보 테이블
create table MEMBER_DETAIL(
	mem_num number,
	mem_auid varchar2(36) NOT null,
	mem_name varchar2(30) NOT null,
	mem_public varchar2(6) NOT null,
	mem_phone varchar2(15) NOT null,
	mem_email varchar2(50) NOT null,
	mem_zipcode varchar2(90) NOT null,
	mem_address1 varchar2(90) NOT null,
	mem_address2 varchar2(90) NOT null,
	mem_photo blob,
	mem_photoname varchar2(100),
	mem_regdate date default sysdate  NOT null,
	mem_modifydate date,
	mem_point number NOT null,
	constraint MEMBER_DETAIL_pk primary key (mem_num),
	constraint MEMBER_DETAIL_fk foreign key (mem_num) references MEMBER(mem_num)
);


--기업 상세 정보 테이블
create table COMPANY_DETAIL(
    mem_num number NOT null,
	comp_num varchar2(40) unique NOT null,
	comp_owner varchar2(30) NOT null,
	comp_name varchar2(90) NOT null,
	comp_phone varchar2(15) NOT null,
	comp_email varchar2(50) NOT null,
	comp_zipcode varchar2(15) NOT null,
	comp_address1 varchar2(90) NOT null,
	comp_address2 varchar2(90) NOT null,
	comp_photo blob,
	comp_photoname varchar2(100),
	comp_regdate date default sysdate NOT null,
	comp_modifydate date,
	comp_content varchar2(2000),
	constraint COMPANY_DETAIL_pk primary key (mem_num),
	constraint COMPANY_DETAIL_fk foreign key (mem_num) references MEMBER(mem_num)
);


--메일 인증 테이블
create table MEMBER_CERT(
	mem_email varchar2(50) NOT null,
	mem_authkey number
);

------------------------------시퀀스
create sequence MEMBER_DETAIL_seq;


----------------------------------------------------------------------------------임희재 LHJ
--커뮤니티
CREATE TABLE commu(
 commu_num number not null,
 commu_title varchar2(90) not null,
 commu_content clob not null,
 commu_date date default SYSDATE not null,
 commu_modifydate date,
 commu_hit number(8),
 commu_ip varchar(15),
 mem_num number not null,
 constraint commu_pk primary key (commu_num),
 constraint commu_fk foreign key (mem_num) references member(mem_num)
);



--커뮤니티 좋아요
CREATE TABLE commu_like(
 commu_like_num number not null,
 commu_num number not null,
 mem_num number not null,
 constraint commu_like_pk primary key (commu_like_num),
 constraint commu_like_fk1 foreign key (commu_num) references commu(commu_num),
 constraint commu_like_fk2 foreign key (mem_num) references member(mem_num)
);



--커뮤니티 싫어요
CREATE TABLE commu_dislike(
 commu_dislike_num number not null,
 commu_num number not null,
 mem_num number not null,
 constraint commu_dislike_pk primary key (commu_dislike_num),
 constraint commu_dislike_fk1 foreign key (commu_num) references commu(commu_num),
 constraint commu_dislike_fk2 foreign key (mem_num) references member(mem_num)
);



--커뮤니티 신고
CREATE TABLE commu_report(
 repo_num number not null,
 repo_date date default SYSDATE not null,
 repo_ip varchar2(15) not null,
 repo_content clob not null,
 repo_category number not null,
 commu_num number not null,
 mem_num number not null,
 constraint commu_report_pk primary key (repo_num),
 constraint commu_report_fk1 foreign key (commu_num) references commu(commu_num),
 constraint commu_report_fk2 foreign key (mem_num) references member(mem_num)
);



--커뮤니티 댓글
CREATE TABLE commu_reply(
 re_num number not null,
 re_content clob not null,
 re_ip varchar2(15) not null,
 re_date date default SYSDATE not null,
 re_modifydate date,
 commu_num number not null,
 mem_num number not null,
 constraint commu_reply_pk primary key (re_num),
 constraint commu_reply_fk1 foreign key (commu_num) references commu(commu_num),
 constraint commu_reply_fk2 foreign key (mem_num) references member(mem_num)
);

--커뮤니티 댓글 신고
CREATE TABLE COMMU_REPLY_REPORT	(
 re_repo_num number not null,
 re_repo_date date default SYSDATE not null,
 re_repo_ip varchar2(15) not null,
 re_repo_content clob not null,
 re_repo_category number(1) not null,
 re_num number not null,
 mem_num number not null,
 constraint commu_reply_report_pk primary key (re_repo_num),
 constraint commu_reply_report_fk1 foreign key (re_num) references commu_reply(re_num),
 constraint commu_reply_report_fk2 foreign key (mem_num) references member(mem_num)
);

--선수 소개
CREATE TABLE player(
 player_num number not null,
 player_name varchar2(30) not null,
 player_position varchar2(15) not null,
 player_photo varchar2(150) not null,
 player_birthday date not null,
 plyaer_height number(15) not null,
 player_weight number(15) not null,
 player_toway varchar2(30) not null,
 player_join varchar2(30) not null,
 player_manager clob not null,
 constraint player_num primary key (player_num)
);


------------------------------시퀀스
CREATE SEQUENCE commu_reply_report_seq;
CREATE SEQUENCE commu_seq;
CREATE SEQUENCE commu_like_seq;
CREATE SEQUENCE commu_dislike_seq;
CREATE SEQUENCE commu_report_seq;
CREATE SEQUENCE commu_reply_seq;
CREATE SEQUENCE player_seq; 



----------------------------------------------------------------------------------김민서 KMS

--중고거래
CREATE TABLE TRADING(
 trade_num number not null,
 trade_title varchar2(60) not null,
 trade_content clob not null,
 trade_price number(9) not null,
 trade_hit number(8) default 0 not null,
 trade_date date default SYSDATE not null,
 trade_modifydate date,
 trade_status number(1) not null,
 trade_photo1 varchar2(300) not null,
 trade_photo2 varchar2(300) not null,
 trade_ip varchar2(15) not null,
 mem_num number not null,
 bk_num number not null,
 constraint TRADING_PK primary key (trade_num),
 constraint TRADING_FK foreign key (mem_num) references MEMBER(mem_num)
);



--북마크
CREATE TABLE BOOKMARK(
 mark_num number not null,
 trade_num number not null,
 mem_num number not null,
 constraint BOOKMARK_PK primary key (mark_num),
 constraint BOOKMARK_FK1 foreign key (trade_num) references TRADING(trade_num),
 constraint BOOKMARK_FK2 foreign key (mem_num) references MEMBER(mem_num)
);



--채팅방
CREATE TABLE CHATROOM(
 chatroom_num number not null,
 trade_num number not null,
 seller_num number not null,
 buyer_num number not null,
 constraint CHATROOM_PK primary key (chatroom_num),
 constraint CHATROOM_FK1 foreign key (trade_num) references TRADING(trade_num),
 constraint CHATROOM_FK2 foreign key (seller_num) references MEMBER(mem_num),
 constraint CHATROOM_FK3 foreign key (buyer_num) references MEMBER(mem_num)
);



--채팅 상세 
CREATE TABLE CHAT(
 chat_num number not null,
 chatroom_num number not null,
 mem_num number not null,
 message varchar2(900) not null,
 reg_date date default SYSDATE not null,
 read_check number(1) not null,
 constraint CHAT_PK primary key (chat_num),
 constraint CHAT_FK1 foreign key (chatroom_num) references CHATROOM(chatroom_num),
 constraint CHAT_FK2 foreign key (mem_num) references MEMBER(mem_num)
);


------------------------------시퀀스
CREATE SEQUENCE trading_seq;
CREATE SEQUENCE bookmark_seq;
CREATE SEQUENCE chatroom_seq;
CREATE SEQUENCE chat_seq;

----------------------------------------------------------------------------------권오윤 KOY
-- 상품정보
create table goods(
   goods_num number,
   goods_name varchar2(600) not null,
   goods_category number(1) not null, -- 1:유니폼/2:모자/3:응원도구/4:기타
   goods_quantity number(2) not null,
   goods_price number(9) not null,
   goods_disc number(3) default 0 not null,
   goods_dprice number(9) not null, -- 상품가격 * (1-할인율)
   goods_content clob not null,
   goods_photo blob not null,
   goods_photoname varchar2(100) not null,
   goods_regdate date default sysdate not null,
   goods_mdate date,
   goods_status number(1) default 2 not null, -- 1:미표시, 2:표시
   constraint goods_pk primary key (goods_num) 
);



-- 상품옵션
create table goods_option(
   opt_num number,
   goods_num number not null,
   goods_size number(1) not null, -- 1:85/2:90/3:95/4:100/5:105/6:110
   goods_stock number(9) not null, 
   constraint goods_opt_pk primary key (opt_num),
   constraint goods_opt_fk1 foreign key (goods_num) references goods (goods_num)
);



-- 상품후기
create table goods_review(
   review_num number,
   mem_num number not null,
   goods_num number not null,
   review_score number(1) not null,
   review_content clob not null,
   review_photo blob,
   review_photoname varchar2(100),
   review_regdate date default sysdate not null,
   review_mdate date,
   constraint goods_review_pk primary key (review_num),
   constraint goods_review_fk1 foreign key (mem_num) references member (mem_num),
   constraint goods_review_fk2 foreign key (goods_num) references goods (goods_num)
);



-- 상품 찜
create table goods_fav(
   fav_num number,
   mem_num number not null,
   goods_num number not null,
   constraint goods_fav_pk primary key (fav_num),
   constraint goods_fav_fk1 foreign key (mem_num) references member (mem_num),
   constraint goods_fav_fk2 foreign key (goods_num) references goods (goods_num)
); 



-- 구단 뉴스
create table news(
   news_num number,
   news_title varchar2(100) not null,
   news_content clob not null,
   news_regdate date default sysdate not null,
   news_mdate date,
   news_hit number(9) default 0 not null,
   mem_num number not null,
   constraint news_pk primary key (news_num),
   constraint news_fk1 foreign key (mem_num) references member (mem_num)
);



-- 경기 일정
create table game(
   game_num number,
   game_date date,
   game_opp number(1) not null, -- 1:SSG/2:키움/3:LG/4:KT/5:기아/6:NC/7:삼성/8:두산/9:한화
   game_hw number(1) not null, -- 1:홈/2:어웨이
   game_location number(2) not null, -- 1:사직/2:인천/3:잠실/4:고척/5:수원/6:대전/7:대구/8:광주/9:창원/10:울산/11:포항
   game_time number(1) not null, -- 1:18시30분/2:14시/3:17시/4:18시
   game_score varchar2(60) not null,
   game_result number(1) default 4 not null, -- 1:승/2:패/3:무/4:경기전/5:취소
   mem_num number not null,
   constraint game_pk primary key (game_num),
   constraint game_fk1 foreign key (mem_num) references member (mem_num)
);


------------------------------시퀀스
create sequence game_seq;
create sequence goods_seq;
create sequence goods_opt_seq;
create sequence goods_review_seq;
create sequence goods_fav_seq;
create sequence news_seq;


---------------------------------------------------------------------------------- 이영주 LYJ
--주문 테이블
create table G_ORDER(
	order_num number primary key, --주문 식별 번호
	mem_num number not null, --회원번호
	goods_name varchar2(600) not null, --상품이름
	order_payment number(1) not null, --결제 방법(0:무통장, 1:카드)
	order_status number(1) not null, --배송상태(0:결제완료, 1:배송준비, 2:배송중, 3:배송완료)
	order_regdate date default SYSDATE not null, --주문날짜
	order_modifydate date, --배송상태 수정일
	order_name varchar2(30) not null, --수령자명
	order_zipcode varchar2(5) not null, --우편번호
	order_address1 varchar2(50) not null, --주소
	order_address2 varchar2(50) not null, --상세주소
	mem_phone varchar2(15) not null, --수령자 전화번호
	order_message varchar2(1300),  --배송 메세지
	order_total number(9) not null, --총 주문 가격
	order_quantity number(9) not null, --주문 수량
	merchant_uid number not null, --가맹점 주문번호API
	CONSTRAINT G_ORDER_FK1 foreign key (mem_num) references member (mem_num)
);


--주문 상세 테이블
create table G_ORDER_DETAIL(
	detail_num number primary key, --주문 상세 식별 번호
	mem_num number not null, --회원번호
	order_num number not null, -- 주문번호
	order_quantity number(5) not null, --주문개수
	order_point number(5) not null, --상품 1개 당 적립예정 포인트(결제 금액의 2%) 
	order_dcost number default 3000 not null, --배송비
	goods_num number not null, --상품 식별 번호
	goods_name varchar2(600) not null, --상품명
	goods_price number(9) not null, --상품 금액
	goods_dprice number(9) not null, --할인된 가격(상품가격*(1-할인율))
	goods_total number(9) not null, --총 상품금액(동일 상품 합산 금액)
	mem_point number default 0 not null, --회원 보유 포인트
	CONSTRAINT G_ORDER_DETAIL_FK2 foreign key(mem_num) references member(mem_num), 
	CONSTRAINT G_ORDER_DETAIL_FK1 foreign key(order_num) references g_order(order_num),
	CONSTRAINT G_ORDER_DETAIL_FK3 foreign key(goods_num) references goods(goods_num) 
);



--장바구니 테이블
create table G_CART(
	cart_num number primary key, --장바구니 식별 번호
	goods_num number not null, --상품 식별 번호
	mem_num number not null, --회원 식별 번호
	order_quantity number(5) not null, --주문수량
	reg_date date default SYSDATE not null, --장바구니에 넣은 날짜
	CONSTRAINT G_CART_FK1 foreign key(goods_num) references goods(goods_num),
	CONSTRAINT G_CART_FK2 foreign key(mem_num) references member(mem_num)
);


------------------------------시퀀스
CREATE SEQUENCE G_CART_SEQ;
CREATE SEQUENCE G_ORDER_SEQ;
CREATE SEQUENCE G_ORDER_DETAIL_SEQ;


----------------------------------------------------------------------------------남소희 NSH
-- 경기정보
CREATE TABLE tgame(
	game_num NUMBER,
	game_date VARCHAR2(30) NOT NULL,
	game_time VARCHAR2(20) NOT NULL,
	game_team VARCHAR2(15) NOT NULL,
	game_state NUMBER(1) DEFAULT 0 NOT NULL,	-- 0:예매가능, 1:경기취소, 2:매진
	CONSTRAINT tgame_pk PRIMARY KEY (game_num)
);


-- 좌석등급
CREATE TABLE grade(
	grade_num NUMBER,
    game_num NUMBER,
	title VARCHAR2(30) NOT NULL,
	quantity NUMBER(5) NOT NULL,
	price_week NUMBER(9) NOT NULL,
	price_weekend NUMBER(9) NOT NULL,
	CONSTRAINT grade_pk PRIMARY KEY (grade_num),
	CONSTRAINT grade_fk FOREIGN KEY (game_num) REFERENCES tgame (game_num)
);


-- 좌석정보
CREATE TABLE seat(
	seat_num NUMBER,
    grade_num NUMBER,
	seat_block NUMBER(3) NOT NULL,
	seat_row VARCHAR2(30) NOT NULL,
	seat_col VARCHAR2(30) NOT NULL,
	CONSTRAINT seat_pk PRIMARY KEY (seat_num),
	CONSTRAINT seat_fk FOREIGN KEY (grade_num) REFERENCES grade (grade_num)
);


-- 좌석상태
CREATE TABLE seat_status(
	status_num NUMBER,
    seat_num NUMBER,
	seat_row VARCHAR2(30) NOT NULL,
	seat_col VARCHAR2(30) NOT NULL,
	seat_date VARCHAR2(30) NOT NULL,
	seat_auth NUMBER(20) NOT NULL,	-- 1:예매완료, 2:예매불가
	CONSTRAINT seat_status_pk PRIMARY KEY (status_num),
	CONSTRAINT seat_status_fk FOREIGN KEY (seat_num) REFERENCES seat (seat_num)
);


-- 주문정보
CREATE TABLE ticket(
	ticket_num VARCHAR2(20),
    mem_num NUMBER,
    game_num NUMBER,
    seat_num NUMBER,
	ticket_date DATE DEFAULT SYSDATE NOT NULL,
	ticket_quantity NUMBER(1) NOT NULL,
	ticket_modify DATE,
	total_price NUMBER(9) NOT NULL,
	ticket_status NUMBER(1) NOT NULL,
	ticket_qrlink CLOB NOT NULL,
	pg varchar2(30) not null,
	pay_method varchar2(30) not null,
	CONSTRAINT ticket_pk PRIMARY KEY (ticket_num),
	CONSTRAINT ticket_fk FOREIGN KEY (mem_num) REFERENCES member (mem_num),
	CONSTRAINT ticket_fk2 FOREIGN KEY (game_num) REFERENCES tgame (game_num),
	CONSTRAINT ticket_fk3 FOREIGN KEY (seat_num) REFERENCES seat (seat_num)
);

------------------------------시퀀스
CREATE SEQUENCE game_seq;
CREATE SEQUENCE grade_seq;
CREATE SEQUENCE seat_seq;
CREATE SEQUENCE seat_status_seq;

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




--통합 주문 시퀀스 번호  (굿즈, 식품, 티켓 에서 활용중)
create sequence order_seq;

----------------------------------------------------------------------------------

--테이블 삭제 쿼리
drop table BOOKMARK cascade constraints; 
drop table CHAT cascade constraints; 
drop table CHATROOM cascade constraints; 
drop table COMMU_DISLIKE cascade constraints; 
drop table COMMU_LIKE cascade constraints; 
drop table COMMU_REPLY cascade constraints; 
drop table COMMU_REPLY_REPORT cascade constraints; 
drop table COMMU_REPORT cascade constraints; 
drop table COMMU cascade constraints; 
drop table F_CART cascade constraints; 
drop table F_ORDER cascade constraints; 
drop table F_ORDER_DETAIL cascade constraints; 
drop table FOOD_REVIEW cascade constraints; 
drop table FOOD cascade constraints; 
drop table G_CART cascade constraints; 
drop table G_ORDER cascade constraints; 
drop table G_ORDER_DETAIL cascade constraints; 
drop table GAME cascade constraints; 
drop table GOODS_FAV cascade constraints; 
drop table GOODS_REVIEW cascade constraints; 
drop table GOODS_OPTION cascade constraints; 
drop table GOODS cascade constraints; 
drop table MEMBER_CERT cascade constraints; 
drop table NEWS cascade constraints; 
drop table SEAT_STATUS cascade constraints; 
drop table SEAT cascade constraints; 
drop table GRADE cascade constraints; 
drop table TGAME cascade constraints; 
drop table TICKET cascade constraints; 
drop table TRADING cascade constraints;
drop table PLAYER cascade constraints; 
drop table COMPANY_DETAIL cascade constraints; 
drop table MEMBER_DETAIL cascade constraints; 
drop table MEMBER cascade constraints; 

--시퀀스 삭제 쿼리

drop sequence BOOKMARK_SEQ;
drop sequence CHAT_SEQ;
drop sequence CHATROOM_SEQ;
drop sequence COMMU_DISLIKE_SEQ;
drop sequence COMMU_LIKE_SEQ;
drop sequence COMMU_REPLY_REPORT_SEQ;
drop sequence COMMU_REPLY_SEQ;
drop sequence COMMU_REPORT_SEQ;
drop sequence COMMU_SEQ;
drop sequence COMPANY_DETAIL_SEQ;
drop sequence F_CART_SEQ;
drop sequence F_ORDER_DETAIL_SEQ;
drop sequence FOOD_REVIEW_SEQ;
drop sequence FOOD_SEQ;
drop sequence G_CART_SEQ;
drop sequence G_ORDER_DETAIL_SEQ;
drop sequence G_ORDER_SEQ;
drop sequence GAME_SEQ;
drop sequence GOODS_FAV_SEQ;
drop sequence GOODS_OPT_SEQ;
drop sequence GOODS_REVIEW_SEQ;
drop sequence GOODS_SEQ;
drop sequence GRADE_SEQ;
drop sequence MEMBER_DETAIL_SEQ;
drop sequence NEWS_SEQ;
drop sequence PLAYER_SEQ;
drop sequence SEAT_SEQ;
drop sequence SEAT_STATUS_SEQ;
drop sequence TRADING_SEQ;

commit;