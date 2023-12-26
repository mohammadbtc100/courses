create database film;
use film;
/*tables*/
create table gender(
	gid tinyint primary key,
    gender nchar(4)
);
create table customers(
	cid int primary key auto_increment,
    cname nvarchar(50) not null,
    gid tinyint,
    address nvarchar(200),
    constraint gid_fk foreign key(gid) REFERENCES gender(gid) on delete cascade on update cascade 
);
alter table customers add column brd char(8);
create table cat(
	cid tinyint primary key auto_increment,
    cat nchar(20)
);
create table films(
	fid int primary key auto_increment,
    fname nvarchar(50) not null,
    cid tinyint,
    constraint cid_fk foreign key(cid) REFERENCES cat(cid) on delete cascade on update cascade 
);
create table borrow(
	cid int,
    fid int,
    stamp timestamp default current_timestamp,
    constraint custid_fk foreign key(cid) REFERENCES customers(cid) on delete cascade on update cascade,
    constraint filmid_fk foreign key(fid) REFERENCES films(fid) on delete cascade on update cascade 
);
/*data*/
insert into gender values(1,'آقا'),(2,'خانم');
insert into customers(cname,gid,address) values('حسین',1,'قم','13800511'),('سکینه',2,'بندر','13801011'),('اکبرشاه',1,'مشهد','13800501'),('الیزابت',2,'شیراز','13000511');
insert into cat(cat) values('اکشن'),('درام'),('اجتماعی'),('کمدی'),('ترسناک');
insert into films(fname,cid) values('EagleEye',1),('2012',1),('Avatar2',1),('OphenHeimer',1);
insert into borrow(cid,fid) values(1,1),(1,2),(2,2),(2,3),(3,3);
/*View*/
create view showCustomers
as
select cid,cname,address,gender from customers 
	left outer join gender
		on customers.gid=gender.gid;

select * from showcustomers;
/*Store Procedure => */
CREATE PROCEDURE showCustomers()
BEGIN
 select cid,cname,address,gender from customers 
	left outer join gender
		on customers.gid=gender.gid;
END;
call showCustomers();
/*function*/
CREATE FUNCTION toDate(brd char(8))
RETURNS char(10)
BEGIN
  RETURN concat(substring(brd,1,4),'/',substring(brd,5,2),'/',substring(brd,7,2));
END
select concat(substring('13800511',1,4),'/',substring('13800511',5,2),'/',substring('13800511',7,2));
select toDate('13800511');

CREATE DEFINER=`root`@`localhost` FUNCTION `toRnd`() RETURNS int(11)
BEGIN
  RETURN round(rand()*100);
END
select toRnd();

SELECT cname,cid FROM film.customers order by cname asc;
SELECT * FROM film.customers;

/*Index*/
create index customers_cname on customers(cname);

/*Trigger issue*/
create table amar(
id int primary key auto_increment,
skey char(20) not null,
svalue decimal(5,2)
);
insert into amar(skey,svalue) values('Borrow',5),('Customers',4),('Films',4);
SELECT id,skey,round(svalue) FROM film.amar;

create table log(
id int primary key auto_increment,
username nvarchar(50),
stamp timestamp default current_timestamp,
operation char(10),
description nvarchar(100)
);

DELIMITER $$;
create trigger insert_borrow
after insert
on borrow
for each row
begin
	update amar set svalue=svalue+1 where id=1;
    
    insert into log(username,stamp,operation,description)
		values(user(),now(),"INSERT",new.cid);
end;

DELIMITER $$;
create trigger delete_borrow
after delete
on borrow
for each row
begin
	update amar set svalue=svalue-1 where id=1;
    
    insert into log(username,stamp,operation,description)
		values(user(),now(),"DELETED",old.cid);
end;

