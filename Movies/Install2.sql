use dbMovies
go
drop table tbDownload
go
create table tbDownload
(Name varchar(50),
Comment varchar(100))

go
drop procedure spAddDownload
go
create procedure spAddDownload
(@Name varchar(50),
@Comment varchar(100))
as begin
insert into tbDownload(Name,Comment) values (@Name,@Comment)
end
go

drop procedure spGetDownloads
go
create procedure spGetDownloads
as begin
select * from tbDownload
order by Name
end
go

drop procedure spDeleteDownload
go
create procedure spDeleteDownload
(@Name varchar(50))
as begin
delete from tbDownload where Name = @Name
end
go

use dbTVShows
ALTER TABLE tbSeasons
Add DoIHave bit DEFAULT 0