-- chapter 3-1

-- Create Table
create table Book(
	bookid int primary key,
	bookname varchar(20),
	publisher varchar(20),
	price int);
create table Customer(
	custid int primary key,
	name varchar(20),
	address varchar(20),
	phone varchar(20));
create table Orders(
	orderid int primary key,
	custid int, 
	bookid int,
	saleprice int,
	orderdate varchar(20),
	foreign key (custid) references Customer(custid),
	foreign key (bookid) references Book(bookid));

-- Insert
insert into Book values(1, '축구의 역사', '굿스포츠', 7000);
insert into Book values(2, '축구 아는 여자', '나무수', 13000);
insert into Book values(3, '축구의 이해', '대한미디어', 22000);
insert into Book values(4, '골프 바이블', '대한미디어', 35000);
insert into Book values(5, '피겨 교본', '굿스포츠', 8000);
insert into Book values(6, '역도 단계별기술', '굿스포츠', 6000);
insert into Book values(7, '야구의 추억', '이상미디어', 20000);
insert into Book values(8, '야구를 부탁해', '이상미디어', 13000);
insert into Book values(9, '올림픽 이야기', '삼성당', 7500);
insert into Book values(10, 'Olympic Champions', 'Pearson', 13000);

insert into Customer values(1, '박지성', '영국 맨체스타', '000-5000-0001');
insert into Customer values(2, '김연아', '대한민국 서울', '000-6000-0001');
insert into Customer values(3, '장미란', '대한민국 강원도', '000-7000-0001');
insert into Customer values(4, '추신수', '미국 클리블랜드', '000-8000-0001');
insert into Customer values(5, '박세리', '대한민국 대전', null);

insert into Orders values(1, 1, 1, 6000, '2013-07-01');
insert into Orders values(2, 1, 3, 21000,'2013-07-03');
insert into Orders values(3, 2, 5, 8000, '2013-07-03');
insert into Orders values(4, 3, 6, 6000, '2013-07-04');
insert into Orders values(5, 4, 7, 20000, '2013-07-05');
insert into Orders values(6, 1, 2, 12000, '2013-07-07');
insert into Orders values(7, 4, 8, 13000, '2013-07-07');
insert into Orders values(8, 3, 10, 12000, '2013-07-08');
insert into Orders values(9, 2, 10, 7000, '2013-07-09');
insert into Orders values(10, 3, 8, 13000, '2013-07-10');

-- Select
1) select bookname, price from Book;
2) select * from Book;
3) select distinct publisher from Book;
4) select * from Book where price<20000;
5) select * from Book where 10000<=price and price<=20000;


























	
	