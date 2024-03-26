use master
go
drop database dbTVShows
go
create database dbTVShows
go
use dbTVShows
go
create table tbTVShows
(ShowID int primary key identity (0,1),
ShowName varchar (70),
NumberOfSeasons int,
Plot varchar (MAX),
Concluded varchar (3),
ImageCover varchar(MAX))
insert into tbTVShows(ShowName,NumberOfSeasons,Plot,Concluded) values ('Friends',10,'In this 1994 sitcom, Rachel Green, Ross Geller, Monica Geller, Joey Tribbiani, Chandler Bing and Phoebe Buffay are all friends, living off of one another in the heart of NY. Over the course of 10 years, these average group of buddys go through massive mayhem, family trouble, past and future romances, fights, laughs, tears and surprises as they learn what it really means to be a friend.','Yes')

create table tbSeasons
(ShowID int foreign key references tbTVShows(ShowID),
SeasonID int primary key identity(0,1),
SeasonNumber int,
NumberOfEpisodes int,
YearStarted int)
insert into tbSeasons(ShowID,SeasonNumber,NumberOfEpisodes,YearStarted) values (0,1,24,1994),(0,2,24,1995),(0,3,25,1996),(0,4,24,1997),(0,5,24,1998),
(0,6,25,1999),(0,7,24,2000),(0,8,24,2001),(0,9,24,2002),(0,10,18,2003)

create table tbDownload
(ShowName varchar (70),
Comment varchar (150))


