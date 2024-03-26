use master
go
drop database dbMovies
go
create database dbMovies
go
use dbMovies
go

create table tbGenre
(GenreID int identity(0,1),
Genre varchar (30) primary key)
insert into tbGenre (Genre) values ('Kids'),('Scary'),('Action'),('Comedy'),('Romance'),('Fantasy'),('Mystery'),('Science Fiction')

create table tbSeries
(SeriesID varchar(4) primary key,
SeriesName varchar(30))
insert into tbSeries (SeriesID,SeriesName) values ('NONE','No Series'),('TWLT','Twilight')

create table tbMovies
(MovieID int primary key identity (0,1),
Name varchar (50), 
Genre varchar(30) foreign key references tbGenre(Genre),
ReleaseYear int,
ImagePath varchar(MAX),
Plot varchar (MAX),
SeriesID varchar(4) foreign key references tbSeries(SeriesID)
)
insert into tbMovies (Name,Genre, ReleaseYear, SeriesID) values ('Twilight','Fantasy',2008,'TWLT'),
('Twilight Saga: New Moon','Fantasy',2009,'TWLT'),('Twilight Saga:Eclipse','Fantasy',2010,'TWLT'),
('Twilight Saga: Breaking Dawn Part 1','Fantasy',2011,'TWLT'),('Twilight Saga: Breaking Dawn Part 2','Fantasy',2012,'TWLT')

