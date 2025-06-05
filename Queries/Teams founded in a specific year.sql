create function YearOfTeamFoundation
(@yr as varchar(25))
returns varchar(255)

begin

declare @team as varchar(255) = ''
select @team = @team + name + ', '
from FootballData.dbo.Teams
where founded_year = @yr;

If len(@team)>0
	set @team = LEFT(@team, len(@team) - 1)

return @team

end

select distinct cast(cast(founded_year as float) as int) as  'Founded Year',
dbo.YearOfTeamFoundation(founded_year) as Teams
From FootballData.dbo.Teams
where founded_year is not null
