--커뮤니티
CREATE TABLE commu(
 commu_num number,
 commu_title varchar2(90) not null,
 commu_content clob not null,
 commu_date date default SYSDATE not null,
 commu_modifydate date,
 commu_hit number(8) default 0 not null,
 commu_ip varchar(15),
 mem_num number not null,
 constraint commu_pk primary key (commu_num),
 constraint commu_fk foreign key (mem_num) references member (mem_num)
);

CREATE SEQUENCE commu_seq;

--커뮤니티 좋아요
CREATE TABLE commu_like(
 commu_like_num number not null,
 commu_num number not null,
 mem_num number not null,
 constraint commu_like_pk primary key (commu_like_num),
 constraint commu_like_fk1 foreign key (commu_num) references commu(commu_num),
 constraint commu_like_fk2 foreign key (mem_num) references member(mem_num)
);

CREATE SEQUENCE commu_like_seq;

--커뮤니티 싫어요
CREATE TABLE commu_dislike(
 commu_dislike_num number not null,
 commu_num number not null,
 mem_num number not null,
 constraint commu_dislike_pk primary key (commu_dislike_num),
 constraint commu_like_fk1 foreign key (commu_num) references commu(commu_num),
 constraint commu_like_fk2 foreign key (mem_num) references member(mem_num)
);

CREATE SEQUENCE commu_dislike_seq;

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

CREATE SEQUENCE commu_report_seq;

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

CREATE SEQUENCE commu_reply_seq;

--선수 소개
CREATE TABLE player(
 player_num number not null,
 player_name varchar2(30) not null,
 player_backnumber varchar2(3) not null,
 player_position varchar2(15) not null,
 player_photo blob not null,
 player_birthday date not null,
 player_height number(15) not null,
 player_weight number(15) not null,
 player_toway varchar2(30) not null,
 player_join varchar2(30) not null,
 player_career clob,
 constraint player_pk primary key (player_num)
);

CREATE SEQUENCE player_seq; 

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
 constraint commu_reply_report_fk1 foreign key (re_num) references post_reply(re_num),
 constraint commu_reply_report_fk2 foreign key (mem_num) references member(mem_num)
);

CREATE SEQUENCE commu_reply_report_seq;

