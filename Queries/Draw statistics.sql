select T.name,
sum(case when M.winner like 'DRAW' then 1 else 0 end) as 'DRAWS',
sum(case when M.winner like 'DRAW' then 1 else 0 end) as 'Draw Points'
From FootballData.dbo.Matches as M 
Left join FootballData.dbo.Teams as T
	on T.team_id =  M.away_team_id or T.team_id = M.home_team_id
group by T.name
Order by 'DRAWS' Desc