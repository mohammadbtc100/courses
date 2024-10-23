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