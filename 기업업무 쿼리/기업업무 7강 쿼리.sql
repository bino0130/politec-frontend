use kopo10;
drop table if exists gongji;
create table if not exists gongji (
id int not null primary key AUTO_INCREMENT,
title varchar(70),
date date,
content text)
DEFAULT charset = utf8mb4;
desc gongji;
desc gongji;
insert into gongji (title, date, content) values ("이건 제목", "2019-01-01", '이건 내용');
delete from gongji where id=9;
select * from gongji;

drop table if exists product;
create table if not exists product (
id varchar(70) not null primary key,
name varchar(100),
num int,
checkDate date,
registerDate date,
content text,
image_url text)
default charset = utf8mb4;
desc product;
alter table product modify id varchar(20);
select max(id) from product;

insert into product values ('122126', '사과', 10, now(), '2019-09-06', '맛있는 사과', './apple.jpg');
insert into product values (1, '사과', 10, '2019-09-06', '2019-09-06', '맛있는 사과', './apple.jpg');
delete from product;
select * from product;

insert into product values ('122122','청주사과', 10, now(), now(), '테스트1', './apple.jpg');
insert into product values ('122123','델몬트 바나나', 10, now(), now(), '테스트2', './banana.jpg');
insert into product values ('122124','보노보노', 10, now(), now(), '테스트3', './bonobono.jpg');
insert into product values ('122125','시원한 수박', 10, now(), now(), '테스트4', './watermelon.jpg');
insert into product values ('122126','공지사항5', 10, now(), now(), 'ㄱㄱㄱ', './apple.jpg');
insert into product values ('122127','공지사항6', 10, now(), now(), 'ㄴㄴㄴ', './banana.jpg');
insert into product values ('122128','공지사항7', 10, now(), now(), 'ㄷㄷㄷ', './bonobono.jpg');
insert into product values ('122129','공지사항8', 10, now(), now(), 'ㄹㄹㄹ', './watermelon.jpg');
insert into product values ('122130','ㄱㄱㄱ', 10, now(), now(), 'ㄱㄱㄱ', './apple.jpg');
insert into product values ('122131','ㄴㄴㄴ', 10, now(), now(), 'ㄴㄴㄴ', './banana.jpg');
insert into product values ('122132','ㄷㄷㄷ', 10, now(), now(), 'ㄷㄷㄷ', './bonobono.jpg');
insert into product values ('122133','ㄹㄹㄹ', 10, now(), now(), 'ㄹㄹㄹ', './watermelon.jpg');