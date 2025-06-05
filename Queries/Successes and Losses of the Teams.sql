select L.name as League,T.name as 'Team',S.position,
case when L.league_id = T.league_id and position <= cl_spot then 'Champions League'
	 when L.league_id = T.league_id and position <= uel_spot then 'European League'
	 when L.league_id = T.league_id and position >= relegation_spot then 'Relegation'
	 end as 'European tournaments or relegation' 
From FootballData.dbo.Leagues as L
join FootballData.dbo.Teams as T
	on L.league_id = T.league_id
join FootballData.dbo.Standings as S
	on T.team_id = S.team_id
where S.position not between L.uel_spot+1 and relegation_spot-1
order by T.league_id,S.position