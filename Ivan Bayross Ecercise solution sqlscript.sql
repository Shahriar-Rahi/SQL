create table client_master 
( 
 client_no varchar(6) primary key check(client_no like 'C%'), 
 name varchar(20) NOT NULL, 
 address1 varchar(30), 
 address2 varchar(30), 
 city varchar(15), 
 state varchar(15), 
 pincode number(6), 
 bal_due number(10,2) 
);

create table product_master 
( 
 product_no varchar(6) primary key check(product_no like 'P%'), 
 description varchar(25) NOT NULL, 
 profit_percent number(5,2) NOT NULL, 
 unit_measure varchar(10) NOT NULL, 
 qty_on_hand number(8) NOT NULL, 
 recorder_lvl number(8) NOT NULL, 
 sell_price number(8,2) NOT NULL check(sell_price<>0), 
 cost_price number(8,2) NOT NULL check(cost_price<>0) 
);

alter table product_master modify description varchar(20);

create table salesman_master 
( 
 salesman_no varchar(6) primary key check(salesman_no like 'S%'), 
 salesman_name varchar(20) NOT NULL, 
 address1 varchar(30) NOT NULL, 
 address2 varchar(30), 
 city varchar(20), 
 pincode varchar(6), 
 state varchar(20), 
 sal_amt number(8,2) NOT NULL check(sal_amt<>0), 
 tgt_to_get number(6,2) NOT NULL check(tgt_to_get<>0), 
 ytd_sales number(6,2) NOT NULL, 
 remarks varchar(60) 
);

create table sales_order 
( 
 s_order_no varchar(6) primary key check(s_order_no like 'O%'), 
 s_order_date date, 
 client_no varchar(6) references client_master(client_no), 
 dely_addr varchar(25), 
 salesman_no varchar(6) references salesman_master(salesman_no), 
 dely_type char(1) default 'F' check(dely_type in ('P','F')), 
 billed_yn char(1), 
 dely_date date, 
 order_status varchar(10) check(order_status in('In Process','Fulfilled','BackOrder','Canceled')), 
 check(dely_date>s_order_date) 
);

create table sales_order_details 
( 
 s_order_no varchar(6) references sales_order(s_order_no), 
 product_no varchar(6) references product_master(product_no), 
 qty_ordered number(8), 
 qty_disp number(8), 
 product_rate number(10,2) 
);

create table challan_header 
( 
 challan_no varchar(6) primary key check(challan_no like 'CH%'), 
 s_order_no varchar(6) references sales_order(s_order_no), 
 challan_date date not null, 
 billed_yn char(1)  
);

create table challan_details 
( 
 challan_no references challan_header(challan_no), 
 product_no references product_master(product_no), 
 qty_disp number(8) 
);

insert into client_master values('C00001','Ivan Bayross','','','Bombay','Maharashtra',400054,15000);

insert into client_master values('C00002','Vandana Saitwal','','','Madras','Tamil Nadu',780001,0);

insert into client_master values('C00003','Pramada Jaguste','','','Bombay','Maharashtra',400057,5000);

insert into client_master values('C00004','Basu Navindgi','','','Bombay','Maharashtra',400056,0);

insert into client_master values('C00005','Ravi Sreedharan','','','Delhi','',100001,2000);

insert into client_master values('C00006','Rukmini','','','Bombay','Maharashtra',400050,0);

insert into product_master values('P00001','1.44 Floppies',5,'Piece',100,20,525,500);

insert into product_master values('P03453','Monitors',6,'Piece',10,3,12000,11280);

insert into product_master values('P06734','Mouse',5,'Piece',20,5,1050,1000);

insert into product_master values('P07865','1.22 Floppies',5,'Piece',100,20,525,500);

insert into product_master values('P07868','Keyboards',2,'Piece',10,3,3150,3050);

insert into product_master values('P07885','CD Drive',2.5,'Piece',10,3,5250,5100);

insert into product_master values('P07965','540 HDD',4,'Piece',10,3,8400,8000);

insert into product_master values('P07975','1.44 Drive',5,'Piece',10,3,1050,1000);

insert into product_master values('P08865','1.22 Drive',5,'Piece',2,3,1050,1000);

insert into salesman_master values('S00001','Kiran','A/14','Worli','Bombay',400002,'MAH',3000,100,50,'Good');

insert into salesman_master values('S00002','Manish','65','Nariman','Bombay',400001,'MAH',3000,200,100,'Good');

insert into salesman_master values('S00003','Ravi','P-7','Bandra','Bombay',400032,'MAH',3000,200,100,'Good');

insert into salesman_master values('S00004','Ashish','A/5','Juhu','Bombay',400044,'MAH',3000,200,150,'Good');

insert into sales_order values('O19001','12-jan-1996','C00001','','S00001','F','N','20-jan-1996','In Process');

insert into sales_order values('O19002','25-jan-1996','C00002','','S00002','P','N','27-jan-1996','Canceled');

insert into sales_order values('O46865','18-feb-1996','C00003','','S00003','F','Y','20-feb-1996','Fulfilled');

insert into sales_order values('O19003','03-apr-1996','C00001','','S00001','F','Y','07-apr-1996','Fulfilled');

insert into sales_order values('O46866','20-may-1996','C00004','','S00002','P','N','22-may-1996','Canceled');

insert into sales_order values('O10008','24-may-1996','C00005','','S00004','F','N','26-may-1996','In Process');

insert into sales_order_details values('O19001','P00001',4,4,525);

insert into sales_order_details values('O19001','P07965',2,1,8400);

insert into sales_order_details values('O19001','P07885',2,1,5250);

insert into sales_order_details values('O19002','P00001',10,0,525);

insert into sales_order_details values('O46865','P07868',3,3,3150);

insert into sales_order_details values('O46865','P07885',3,1,5250);

insert into sales_order_details values('O46865','P00001',10,10,525);

insert into sales_order_details values('O46865','P03453',4,4,1050);

insert into sales_order_details values('O19003','P03453',2,2,1050);

insert into sales_order_details values('O19003','P06734',1,1,12000);

insert into sales_order_details values('O46866','P07965',1,0,8400);

insert into sales_order_details values('O46866','P07975',1,0,1050);

insert into sales_order_details values('O10008','P00001',10,5,525);

insert into sales_order_details values('O10008','P07975',5,3,1050);

insert into challan_header values('CH9001','O19001','12-dec-1995','Y');

insert into challan_header values('CH6865','O46865','12-nov-1995','Y');

insert into challan_header values('CH3965','O10008','12-oct-1995','Y');

insert into challan_details values('CH9001','P00001',4);

insert into challan_details values('CH9001','P07965',1);

insert into challan_details values('CH9001','P07885',1);

insert into challan_details values('CH6865','P07868',3);

insert into challan_details values('CH6865','P03453',4);

insert into challan_details values('CH6865','P00001',10);

insert into challan_details values('CH3965','P00001',5);

insert into challan_details values('CH3965','P07975',2);

select * from client_master;

