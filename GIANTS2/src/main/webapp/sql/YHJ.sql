--회원 정보 테이블
create table MEMBER(
	mem_num number,
	mem_id varchar2(12) unique NOT null,
	mem_nickname varchar2(30),
	mem_auth number(1) not null,
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
	mem_regdate default sysdate date NOT null,
	mem_modifydate date,
	mem_point number NOT null,
	constraint MEMBER_DETAIL_pk primary key (mem_num),
	constraint MEMBER_DETAIL_fk foreign key (mem_num) references MEMBER(mem_num)
);

--기업 상세 정보 테이블
create table COMPANY_DETAIL(
    mem_num number,
	comp_num varchar2(40) unique NOT null,
	comp_owner varchar2(30) NOT null,
	comp_cate number(1) NOT null,
	comp_name varchar2(90) NOT null,
	comp_cate number(1),
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