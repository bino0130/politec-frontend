use kopo10;
drop table if exists gongji;
create table if not exists gongji (
id int not null primary key AUTO_INCREMENT,
title varchar(70),
date date,
content text)
DEFAULT charset = utf8mb4;
desc gongji;
insert into gongji (title, date, content) values ("이건 제목", "2019-01-01", '이건 내용');
delete from gongji where id=9;
select * from gongji;

drop table if exists product;
create table if not exists product (
id int not null primary key,
name varchar(30),
num int,
checkDate date,
registerDate date,
content text,
image_url text)
default charset = utf8mb4;

insert into product values (1, '사과', 10, '2019-09-06', '2019-09-06', '맛있는 사과', './apple.jpg');
insert into product values (1, '사과', 10, '2019-09-06', '2019-09-06', '맛있는 사과', './apple.jpg');
delete from product;
select * from product;