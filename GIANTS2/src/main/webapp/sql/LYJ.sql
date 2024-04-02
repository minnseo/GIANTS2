--주문 테이블
create table G_ORDER(
	order_num number primary key, --주문 식별 번호
	mem_num number not null, --회원번호
	goods_name varchar2(600) not null, --상품이름
	order_payment number(1) not null, --결제 방법(0:무통장, 1:카드)
	order_status number(1) default 0 not null, --배송상태(0:결제완료, 1:배송준비, 2:배송중, 3:배송완료)
	order_regdate date default SYSDATE not null, --주문날짜
	order_modifydate date, --배송상태 수정일
	order_name varchar2(30) not null, --수령자 이름
    receive_name varchar2(30) not null, --결제자 이름
	order_zipcode varchar2(5) not null, --우편번호
	order_address1 varchar2(50) not null, --주소
	order_address2 varchar2(50) not null, --상세주소
	mem_phone varchar2(15) not null, --수령자 전화번호
	order_message varchar2(1300),  --배송 메세지
	order_total number(9) not null, --총 주문 가격
	merchant_uid number not null, --가맹점 주문번호API
	CONSTRAINT G_ORDER_FK1 foreign key (mem_num) references member (mem_num)
);
CREATE SEQUENCE G_ORDER_SEQ;

--주문 상세 테이블
create table G_ORDER_DETAIL(
	detail_num number primary key, --주문 상세 식별 번호
	mem_num number not null, --회원번호
	order_num number not null, -- 주문번호
	order_point number(5) not null, --상품 1개 당 적립예정 포인트(결제 금액의 2%)   
	order_dcost number default 3000 not null, --배송비
	goods_num number not null, --상품 식별 번호
	goods_name varchar2(600) not null, --상품명
	goods_dprice number(9) not null, --상품 금액
	goods_total number(9) not null, --총 상품금액(동일 상품 합산 금액)
	goods_size number(1) not null, --상품 옵션
	mem_point number default 0 not null, --회원 보유 포인트
	CONSTRAINT G_ORDER_DETAIL_FK2 foreign key(mem_num) references member(mem_num), 
	CONSTRAINT G_ORDER_DETAIL_FK1 foreign key(order_num) references g_order(order_num),
	CONSTRAINT G_ORDER_DETAIL_FK3 foreign key(goods_num) references goods(goods_num) 
);

CREATE SEQUENCE G_ORDER_DETAIL_SEQ;




--장바구니 테이블
create table G_CART(
	cart_num number primary key, --장바구니 식별 번호
	goods_num number not null, --상품 식별 번호
	mem_num number not null, --회원 식별 번호
	order_quantity number(5) not null, --주문수량
	opt_num number not null, --옵션 식별 번호
	reg_date date default SYSDATE not null, --장바구니에 넣은 날짜
	CONSTRAINT G_CART_FK1 foreign key(goods_num) references goods(goods_num),
	CONSTRAINT G_CART_FK2 foreign key(mem_num) references member(mem_num),
	CONSTRAINT G_CART_FK3 foreign key(opt_num) references goods_option(opt_num)
	
);

CREATE SEQUENCE G_CART_SEQ;
