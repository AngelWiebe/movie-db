use dbMovies
go
drop procedure spGetMoviesFromGenre
go
create procedure spGetMoviesFromGenre
(@Genre varchar (30),
@column varchar(20))
as begin
if(@column='SeriesIDA' or @column='SeriesIDD')
begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,Genre from tbMovies where Genre = @Genre 
order by case when @column =  'SeriesIDA' then SeriesID end ASC,
         case when @column =  'SeriesIDD' then SeriesID end DESC,
		 ReleaseYear
end
else
begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,Genre from tbMovies where Genre = @Genre 
order by case when @column =  'NameA' then Name end ASC,
		 case when @column =  'ReleaseYearA' then ReleaseYear end ASC,
		 case when @column =  'NameD' then Name end DESC,
		 case when @column =  'ReleaseYearD' then ReleaseYear end DESC
end		 
end
go

drop procedure spGetAllMoviesDataList
go
create procedure spGetAllMoviesDataList
(@PageNumber int, 
@PageSize int=50)
as begin
declare @Begin int
declare @End int
set @Begin = ((@PageNumber-1)*@PageSize)+1
set @End = (@Begin+@PageSize)-1
--select @Begin, @End
create table #temp
(#RowID int,
#MovieID int,
#Name varchar (50), 
#Genre varchar(30),
#ReleaseYear int,
#ImagePath varchar(MAX),
#Plot varchar (MAX),
#SeriesID varchar(4))
insert into #temp(#RowID,#MovieID,#Name,#Genre,#ReleaseYear,#ImagePath,#Plot,#SeriesID)
select ROW_NUMBER() over (order by SeriesID,ReleaseYear) as RowID, 
MovieID, Name, Genre, ReleaseYear, ImagePath, Plot,SeriesID from tbMovies
select #MovieID as MovieID,#Name as Name,#Genre as Genre,#ReleaseYear as ReleaseYear,'/Images/'+#ImagePath as ImagePath,
#Plot as Plot,#SeriesID as SeriesID 
from #temp 
where #RowID between @Begin and @End
end
go
--exec spGetAllMoviesDataList @PageNumber=2

drop procedure spGetNumberOfPages
go
create procedure spGetNumberOfPages
(@PageSize int = 50)
as begin
declare @count int
select @count = count(*) from tbMovies
set @count = ((@count-1)/@PageSize) +1
select @count
end

go

drop procedure spGetMoviesDataListForGenre
go
create procedure spGetMoviesDataListForGenre
(@PageNumber int, 
@PageSize int=50,
@Genre varchar (30))
as begin
declare @Begin int
declare @End int
set @Begin = ((@PageNumber-1)*@PageSize)+1
set @End = (@Begin+@PageSize)-1
--select @Begin, @End
create table #temp
(#RowID int,
#MovieID int,
#Name varchar (50), 
#Genre varchar(30),
#ReleaseYear int,
#ImagePath varchar(MAX),
#Plot varchar (MAX),
#SeriesID varchar(4))

insert into #temp(#RowID,#MovieID,#Name,#Genre,#ReleaseYear,#ImagePath,#Plot,#SeriesID)
select ROW_NUMBER() over (order by SeriesID,ReleaseYear) as RowID, 
MovieID, Name, Genre, ReleaseYear, ImagePath, Plot,SeriesID from tbMovies
where Genre = @Genre
order by SeriesID,ReleaseYear

select #MovieID as MovieID, #Name as Name, #Genre as Genre, #ReleaseYear as ReleaseYear,'/Images/'+#ImagePath as ImagePath,
#Plot as Plot,#SeriesID as SeriesID 
from #temp 
where #RowID between @Begin and @End
end
go
--exec spGetAllMoviesDataListForGenre @Genre = 'Animated', @PageNumber=2

drop procedure spGetNumberOfPagesForGenre
go
create procedure spGetNumberOfPagesForGenre
(@PageSize int = 50,
@Genre varchar (30))
as begin
declare @count int
select @count = count(*) from tbMovies where Genre = @Genre
set @count = ((@count-1)/@PageSize) +1
select @count
end

go

drop procedure spGetMoviesBySeries
go
create procedure spGetMoviesBySeries
(@SeriesID varchar (4))
as begin
select * from tbMovies where SeriesID = @SeriesID order by ReleaseYear
end
go

drop procedure spGetMovie
go
create procedure spGetMovie
(@MovieID int)
as begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,tbGenre.Genre, GenreID from tbMovies,tbGenre 
where MovieID = @MovieID AND tbGenre.Genre = tbMovies.Genre
end
go

drop procedure spGetAllMovies
go
create procedure spGetAllMovies
(@column varchar(20))
as begin
if(@column='SeriesIDA' or @column='SeriesIDD')
begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,tbGenre.Genre,GenreID from tbMovies,tbGenre
where tbMovies.Genre = tbGenre.Genre
order by case when @column =  'SeriesIDA' then SeriesID end ASC,
         case when @column =  'SeriesIDD' then SeriesID end DESC,
		 ReleaseYear
end
else
begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,Genre from tbMovies
order by case when @column =  'NameA' then Name end ASC,
		 case when @column =  'ReleaseYearA' then ReleaseYear end ASC,
		 case when @column =  'NameD' then Name end DESC,
		 case when @column =  'ReleaseYearD' then ReleaseYear end DESC
end		 
end
go

drop procedure spAddMovie
go
create procedure spAddMovie
(@Name varchar (50),
@Genre varchar (30),
@ReleaseYear int,
@Plot varchar (MAX),
@SeriesID varchar (4))
as begin
insert into tbMovies (Name,Genre,ReleaseYear,Plot,SeriesID) values (@Name,@Genre,@ReleaseYear,@Plot,@SeriesID)
select @@IDENTITY as MovieID
end
go

drop procedure spUpdateMovie
go
create procedure spUpdateMovie
(@MovieID int,
@Name varchar (50),
@Genre varchar (30),
@ReleaseYear int,
@Plot varchar (MAX),
@SeriesID varchar (4))
as begin
update tbMovies set
Name = @Name,
Genre = @Genre,
ReleaseYear = @ReleaseYear,
Plot = @Plot,
SeriesID = @SeriesID
where MovieID = @MovieID
end
go

drop procedure spDeleteMovie
go
create procedure spDeleteMovie
(@MovieID int)
as begin
delete from tbMovies where MovieID = @MovieID
end
go

drop procedure spGetGenres
go
create procedure spGetGenres
as begin
select * from tbGenre 
order by Genre
end
go

drop procedure spGetSeries
go
create procedure spGetSeries
as begin
select * from tbSeries
order by SeriesName
end
go

drop procedure spAddSeries
go
create procedure spAddSeries
(@SeriesID varchar (4),
@SeriesName varchar (30))
as begin
insert into tbSeries (SeriesID,SeriesName) values (@SeriesID,@SeriesName)
end
go

drop procedure spDeleteSeries
go
create procedure spDeleteSeries
(@SeriesID varchar(4))
as begin
delete from tbSeries where SeriesID = @SeriesID
end
go

drop procedure spUpdateImage
go
create procedure spUpdateImage
(@ImagePath varchar(MAX),
@MovieID int)
as begin
update tbMovies set
ImagePath = @ImagePath
where MovieID = @MovieID
end
go

drop procedure spFindMovies
go
create procedure spFindMovies
(@Name varchar (100))
as begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,Genre from tbMovies 
where Name like '%' + @Name + '%'
order by SeriesID,ReleaseYear
end
go

drop procedure spFindByPlot
go
create procedure spFindByPlot
(@Plot varchar (250))
as begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,Genre from tbMovies 
where Plot like '%' + @Plot + '%'
order by SeriesID,ReleaseYear
end
go

drop procedure spSearchByYear
go
create procedure spSearchByYear
(@Year int)
as begin
select MovieID,Name,Plot, '/Images/'+ImagePath as ImagePath,SeriesID,ReleaseYear,Genre from tbMovies 
where ReleaseYear=@Year
end
go

drop procedure spAddGenre
go
create procedure spAddGenre
(@Genre varchar(30))
as begin
insert into tbGenre (Genre) values (@Genre)
end
go

drop procedure spDeleteGenre
go
create procedure spDeleteGenre
(@GenreID int)
as begin
delete from tbGenre where GenreID = @GenreID
end
go

use dbTVShows
go
drop procedure spAddShow
go
create procedure spAddShow
(@ShowName varchar (70),
@NumberOfSeasons int,
@Plot varchar (MAX),
@Concluded varchar (3))
as begin
insert into tbTVShows (ShowName,NumberOfSeasons,Plot,Concluded) values (@ShowName,@NumberOfSeasons,@Plot,@Concluded)
select @@IDENTITY as ShowID
end
go

drop procedure spDeleteShow
go
create procedure spDeleteShow
(@ShowID int)
as begin
delete from tbSeasons where ShowID = @ShowID 
delete from tbTVShows where ShowID =  @ShowID
end
go

drop procedure spUpdateShow
go
create procedure spUpdateShow
(@ShowID int,
@ShowName varchar (70),
@NumberOfSeasons int,
@Plot varchar (MAX),
@Concluded varchar (3))
as begin
update tbTVShows set
ShowName = @ShowName,
NumberOfSeasons = @NumberOfSeasons,
Plot = @Plot,
Concluded = @Concluded
where ShowID = @ShowID
end
go

drop procedure spGetShows
go
create procedure spGetShows
(@ShowID int = null)
as begin
select ShowName,ShowID,NumberOfSeasons,'/Images/'+ImageCover as ImageCover, Plot, Concluded from tbTVShows 
where ShowID = ISNULL(@ShowID, ShowID)
order by ShowName
end
go

drop procedure spFindShows
go
create procedure spFindShows
(@Name varchar (100))
as begin
select ShowName,'/Images/'+ ImageCover as ImageCover,ShowID,Plot,NumberOfSeasons,Concluded from tbTVShows 
where ShowName like '%' + @Name + '%'
order by ShowName
end
go

drop procedure spGetSeasons
go
create procedure spGetSeasons
(@ShowID int)
as begin
select ShowName,YearStarted,SeasonNumber,NumberOfEpisodes,tbSeasons.SeasonID,tbTVShows.ShowID, DoIHave from tbSeasons,tbTVShows
where tbSeasons.ShowID = @ShowID AND tbTVShows.ShowID = tbSeasons.ShowID
order by ShowName,SeasonNumber
end
go

drop procedure spAddSeason
go
create procedure spAddSeason
(@ShowID int,
@SeasonNumber int,
@NumberOfEpisodes int,
@YearStarted int,
@DoIHave int)
as begin
insert into tbSeasons (SeasonNumber,NumberOfEpisodes,YearStarted,ShowID,DoIHave) values (@SeasonNumber,@NumberOfEpisodes,@YearStarted,@ShowID,@DoIHave) 
select @@IDENTITY as SeasonID
end
go

drop procedure spUpdateSeason
go
create procedure spUpdateSeason
(@SeasonID int,
@ShowID int,
@SeasonNumber int,
@NumberOfEpisodes int,
@YearStarted int,
@DoIHave bit)
as begin
update tbSeasons set
ShowID = @ShowID,
SeasonNumber = @SeasonNumber,
NumberOfEpisodes = @NumberOfEpisodes,
YearStarted = @YearStarted,
DoIHave = @DoIHave
where SeasonID = @SeasonID
end
go

drop procedure spDeleteSeason
go
create procedure spDeleteSeason
(@SeasonID int)
as begin
delete from tbSeasonsHad where SeasonID = @SeasonID
delete from tbSeasons where SeasonID = @SeasonID
end
go

drop procedure spUpdateShowImage
go
create procedure spUpdateShowImage
(@ImageCover varchar(MAX),
@ShowID int)
as begin
update tbTVShows set
ImageCover = @ImageCover
where ShowID = @ShowID
end
go

drop procedure spAddToDownloads
go
create procedure spAddToDownloads
(@ShowName varchar (70),
@Comment varchar (150))
as begin
insert into tbDownload (ShowName,Comment) values (@ShowName,@Comment)
end
go

drop procedure spDeleteFromDownloads
go
create procedure spDeletefromDownloads
(@ShowName varchar (70),
@Comment varchar (150))
as begin
delete from tbDownload where ShowName = @ShowName AND Comment = @Comment
end
go

drop procedure spGetDownloads
go
create procedure spGetDownloads
as begin
select * from tbDownload
order by ShowName
end
go

drop procedure spGetOngoingShows
go
create procedure spGetOngoingShows
as begin
select ShowName,'/Images/'+ ImageCover as ImageCover,ShowID,Plot,NumberOfSeasons,Concluded from tbTVShows
where Concluded = 'No'
order by ShowName
end
go
