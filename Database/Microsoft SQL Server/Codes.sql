create table student(
	id int identity(1,1) primary key,
	[name] varchar(50) not null,
	score decimal(5,2),
	comment varchar(200)
);

insert into student(name,score) values('Ali',15.5);
insert into student(name,score) values('Reza',13.0);
insert into student(name,score) values('Hadi',17.0);
insert into student(name,score) values('Mousa',20.0);

select * from student

select * from student inner join novels on student.id=novels.id;
select * from student as s inner join novels as n on s.id=n.id;
select * from student s inner join novels n on s.id=n.id;

select s.*,n.name,n.cover from student s inner join novels n on s.id=n.id;


select * from student where id=1 or id=2
 union
 select * from student where id=2 or id=4;

select * from student where id=1 or id=2
 intersect
 select * from student where id=2 or id=4;


