create database sync_db
use sync_db
go


--pub
create table publisher (
    id int identity(1,1) primary key,
    fullname nvarchar(100) not null,
    age int not null,
    country nvarchar(100) not null,
    created_at datetime default getdate()
);
go

--sub
create table subscriber (
    id int identity(1,1) primary key,
    fullname nvarchar(100) not null,
    age int not null,
    country nvarchar(100) not null,
    created_at datetime default getdate()
);
go
select * from publisher
select * from subscriber

insert into publisher (fullname, age, country) values ('dilip', 30, 'IND');
insert into publisher (fullname, age, country) values ('dev', 25, 'UK');
insert into publisher (fullname, age, country) values ('raju', 35, 'IND');




--sync

create procedure sync_publisher_to_subscriber
as
begin
    insert into subscriber (fullname, age, country, created_at)
    select p.fullname, p.age, p.country, p.created_at
    from publisher p
    left join subscriber s on p.id = s.id
    where s.id is null;
end;
go

select * from publisher
select * from subscriber

exec sync_publisher_to_subscriber

select * from publisher
select * from subscriber


insert into publisher (fullname, age, country) values ('sri', 25, 'CAN');
