--创建管理员信息表
create table admin(
  aid int primary key,
  aname varchar2(20 char),
  pwd varchar2(20 char)
)tablespace   ycspace;



--创建用户表
drop table usersInfo;
create table usersInfo(
       usid int primary key,
       uname varchar2(20 char),
       upwd varchar2(20 char)
)tablespace   ycspace;

--类型表
create table topic(
      tid int primary key,
      tname varchar2(20 char)       
)tablespace   ycspace;

--新闻表
drop table news;
create table news(
       nid int primary key,  --新闻编号
       ntid int  --新闻类型编号
      constraint FK_news_topic references topic(tid),
       ntitle varchar2(200 char) not null,  --新闻标题
       nauthor varchar2(50 char) not null,  --新闻作者
       ncreatedate date,  --新闻发布日期
       npicpath varchar2(200 char),  --新闻图片路径
       ncontent varchar2(4000 char) not null,  --新闻内容
       nmodifydate date,  --新闻修改日期
       nsummary varchar2(500 char) --新闻摘要
) tablespace   ycspace;

SELECT * FROM news;
--New - topic 主外键
--alter table news add constraint fk_news_topic foreign key(ntid) references topic(tid);

--评论表
drop table comments;
create table comments(
       cid int primary key,  --评论编号
       cnid int not null  --评论的新闻编号
      constraint FK_ntid references news(nid),
       ccontent varchar2(4000 char),  --评论内容
       cdate date, --评论日期
       cip varchar2(100 char),  --评论的ip地址
       usid int
            constraint FK_usid references usersInfo(usid)
)tablespace   ycspace;

--创建序列
create sequence seq_aid increment by 1 start with 10001;
create sequence seq_usid increment by 1 start with 10001;
create sequence seq_tid increment by 1 start with 10001;
create sequence seq_nid increment by 1 start with 10001;
create sequence seq_cid increment by 1 start with 10001;


--创建索引

--用户名唯一
create unique index index_uname on usersInfo(uname);

--新闻标题建立普通索引
create unique index index_ntitle on news(ntitle);

--创建一些触发器，完成每一个表的主键自增
--管理员编号
create or replace trigger tri_aid
before insert on admin
for each row
begin
       select seq_aid.nextval into :new.aid from dual;
end;

--用户表编号
create or replace trigger tri_usid
before insert on usersInfo
for each row
begin
       select seq_usid.nextval into :new.usid from dual;
end;


--评论表的主键触发器
create or replace trigger tri_cid
before insert on comments
for each row
begin
      select seq_cid.nextval into :new.cid from dual;
end;


--新闻表的触发器
create or replace trigger tri_nid
before insert on  news
for each row
begin
       select seq_nid.nextval into :new.nid from dual;
end;


--类型表的触发器
create or replace trigger tri_tid
before insert on topic
for each row
begin
       select seq_tid.nextval into :new.tid from dual;
end;

insert into topic values(1,'国内');
insert into topic values(1,'国际');
insert into topic values(1,'军事');
insert into topic values(1,'娱乐');
insert into topic values(1,'体育');
insert into topic values(1,'社会');

select * from topic;

select * from (select a.*,rownum as rn from (select * from news where ntid=10001) a where rownum<=10) where rn>5;


select n.* from news n,topic t where n.ntid=t.tid and tname like '国内';

insert into admin values(1,'a','a');
select * from news;
insert into admin values(1,'navy','a');

















