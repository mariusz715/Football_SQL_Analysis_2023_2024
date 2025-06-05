select T.name,
sum(case when T.team_id = M.home_team_id and M.winner like 'Home_Team' then 1 else 0 end) as 'Home Wins',
sum(case when T.team_id = M.home_team_id and M.winner like 'Home_Team' then 3 else 0 end) as 'Home Points'
From FootballData.dbo.Matches as M 
Left join FootballData.dbo.Teams as T
	on T.team_id =  M.away_team_id or T.team_id = M.home_team_id
group by T.name
Order by 'Home Wins' Desc