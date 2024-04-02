--중고거래
CREATE TABLE TRADING(
 trade_num number not null,
 trade_title varchar2(60) not null,
 trade_content clob not null,
 trade_price number(9) not null,
 trade_hit number(8) default 0 not null,
 trade_date date default SYSDATE not null,
 trade_modifydate date,
 trade_status number(1) default 0 not null,
 trade_photo blob not null,
 trade_photoname varchar2(100) not null,
 trade_ip varchar2(15) not null,
 mem_num number not null,
 constraint TRADING_PK primary key (trade_num),
 constraint TRADING_FK foreign key (mem_num) references MEMBER(mem_num)
);

CREATE SEQUENCE trading_seq;

--북마크
CREATE TABLE BOOKMARK(
 mark_num number not null,
 trade_num number not null,
 mem_num number not null,
 constraint BOOKMARK_PK primary key (mark_num),
 constraint BOOKMARK_FK1 foreign key (trade_num) references TRADING(trade_num),
 constraint BOOKMARK_FK2 foreign key (mem_num) references MEMBER(mem_num)
);

CREATE SEQUENCE bookmark_seq;
/*
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

CREATE SEQUENCE chatroom_seq;

--채팅 상세  
CREATE TABLE CHAT(
 chat_num number not null,
 chatroom_num number not null,
 mem_num number not null,
 message varchar2(900) not null,
 reg_date date default SYSDATE not null,
 read_check number(1) not null,
 constraint CHAT_PK primary key (chat_num),
 constraint CHAT_FK1 foreign key (chatroom_num) references CHATROOM(chatroom_num)
 constraint CHAT_FK2 foreign key (mem_num) references CHATROOM(mem_num)
);

CREATE SEQUENCE chat_seq;
*/

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

CREATE SEQUENCE chatroom_seq;

--채팅 메시지
CREATE TABLE CHAT(
 chat_num number,
 chatroom_num number not null, --수신자
 mem_num number not null, --발신자
 message varchar2(4000) not null,
 chat_date date default sysdate not null,
 constraint CHAT_PK primary key (chat_num),
 constraint CHAT_FK1 foreign key (chatroom_num) references CHATROOM (chatroom_num),
 constraint CHAT_FK2 foreign key (mem_num) references MEMBER (mem_num) 
);

CREATE SEQUENCE chat_seq;

--메시지 읽음 여부 체크
CREATE TABLE CHAT_READ(
 chatroom_num number not null,
 chat_num number not null,
 mem_num number not null,
 constraint CHAT_READ_FK1 foreign key (chatroom_num) references CHATROOM (chatroom_num), 
 constraint CHAT_READ_FK2 foreign key (chat_num) references CHAT (chat_num),
 constraint CHAT_READ_FK3 foreign key (mem_num) references MEMBER (mem_num) 
);