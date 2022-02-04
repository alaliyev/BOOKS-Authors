create database [Library]
use [Library]
create table Authors 
(
Id int primary key identity,
Name nvarchar(30),
Surname nvarchar(30))

create table Books 
(
Id int primary key identity,
Name nvarchar(99) check (Len(Name)>2 and Len(Name)<100),
AuthorId int constraint FK_Books_AuthorId foreign key references Authors(Id),
PageCount int check(PageCount>2)
)  

insert into Authors 
values ('Friedrich',' Nietzsche'),('Yuval Noah',' Harari'),('Adam','Smith')

insert into Books
values ('The Wealth of Nations',3,950),('Thus Spoke Zarathustra: A Book for All and None',1,352),('Sapiens',2,443)

create view vw_ViewDetails
as
Select * from 
(select b.Name,b.Pagecount, (a.Name + '' + a.Surname) as Fullname  from Books b join Authors a
on b.AuthorId=a.Id) as	BookDetails

select * from vw_ViewDetails

create procedure usp_selectBookWithAuthorNames
@Name nvarchar(30) as 
select * from vw_ViewDetails where [Name]>=@Name

exec usp_selectBookWithAuthorNames 'Adam'

create procedure usp_deleteAuthor
@Name nvarchar (30) = ''
as delete from Authors where Name=@Name

exec usp_deleteAuthor 'Adam'

create procedure usp_addAuthor
@Name nvarchar(30),
@Surname nvarchar(30)
as insert into Authors (Name,Surname)
values (@Name,@Surname)

exec usp_addAuthor 'Leo','Tolstoy'

create procedure usp_updateAuthors
@Id int,
@Name nvarchar(30),
@Surname nvarchar(30)
as
update Authors
set Name = @Name, Surname =@Surname where Id = @Id


exec usp_updateAuthors @Id=2, @Name=Francais, @Surname=Breguet

create view vw_AuthorMaxPageCount
as select * from
(select a.Id,Max(b.Pagecount), (a.Name + '' + a.Surname) as Fullname  from Books b join Authors a
on b.AuthorId=a.Id) as AuthorRelatedDetails





