-- 상품정보
create table goods(
   goods_num number,
   goods_name varchar2(600) not null,
   goods_category number(1) not null, -- 1:유니폼/2:모자/3:응원도구/4:기타
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

create sequence goods_seq;

-- 상품옵션
create table goods_option(
   opt_num number not null,
   goods_num number not null,
   goods_size varchar2(20) not null, -- 1:85/2:90/3:95/4:100/5:105/6:110/7:옵션없음
   goods_stock number(9) not null, 
   constraint goods_opt_pk primary key (opt_num),
   constraint goods_opt_fk1 foreign key (goods_num) references goods (goods_num)
);

create sequence goods_opt_seq;

-- 상품후기
create table goods_review(
   review_num number,
   mem_num number not null,
   goods_num number not null,
   review_title varchar2(100) not null,
   review_score number(1) not null,
   review_content clob not null,
   review_photo blob,
   review_photoname varchar2(100),
   review_regdate date default sysdate not null,
   review_mdate date,
   review_ip varchar2(50) not null,
   constraint goods_review_pk primary key (review_num),
   constraint goods_review_fk1 foreign key (mem_num) references member (mem_num),
   constraint goods_review_fk2 foreign key (goods_num) references goods (goods_num)
);

create sequence goods_review_seq;

-- 상품문의
create table goods_qna(
	qna_num number,
	qna_title varchar2(100) not null,
	qna_content clob not null,
	qna_regdate date default sysdate not null,
	qna_mdate date,
	qna_status number(1) default 1 not null, -- 1:답변전, 2:답변완료
	mem_num number not null,
	qna_ip varchar2(50) not null,
	goods_num number not null,
	constraint goods_qna_pk primary key (qna_num),
   	constraint goods_qna_fk1 foreign key (mem_num) references member (mem_num),
   	constraint goods_qna_fk2 foreign key (goods_num) references goods (goods_num)
);

create sequence goods_qna_seq;

-- 상품문의 답변
create table goods_answer(
	gans_num number,
	gans_content varchar2(900) not null,
	gans_regdate date default sysdate not null,
	gans_mdate date,
	mem_num number not null,
	qna_num number not null,
	constraint goods_ans_pk primary key (gans_num),
	constraint goods_ans_fk1 foreign key (mem_num) references member (mem_num),
	constraint goods_ans_fk2 foreign key (qna_num) references goods_qna (qna_num)
);

create sequence goods_answer_seq;

-- 상품 찜
create table goods_fav(
   fav_num number,
   mem_num number not null,
   goods_num number not null,
   constraint goods_fav_pk primary key (fav_num),
   constraint goods_fav_fk1 foreign key (mem_num) references member (mem_num),
   constraint goods_fav_fk2 foreign key (goods_num) references goods (goods_num)
); 

create sequence goods_fav_seq;

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

create sequence news_seq;

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

create sequence game_seq;