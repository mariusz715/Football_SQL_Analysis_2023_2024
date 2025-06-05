WITH Standings as
(Select T.name,
sum(Case when (T.team_id = M.home_team_id and M.winner = 'HOME_TEAM') or 
	(M.winner = 'AWAY_TEAM' and  T.team_id = away_team_id ) then 3 
	  when winner = 'DRAW' then 1 else 0 end) as 'Points'
From FootballData.dbo.Matches as M
left join FootballData.dbo.Teams as T
	on T.team_id = M.away_team_id or T.team_id = M.home_team_id
where T.league_id = 1 and cast(utc_date as date) < '01.01.2024'
group by T.name)

Select RANK() over (order by Points DESC) as 'Position',
name,Points
From Standings
order by Points DESC
