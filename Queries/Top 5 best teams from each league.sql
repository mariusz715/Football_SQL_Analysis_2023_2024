select (select Name From FootballData.dbo.Leagues where league_id = s.league_id) as 'League',
S.position,T.name,S.points,S.won,s.draw,s.lost,s.goals_for,goals_against 
From FootballData.dbo.Standings as S
join FootballData.dbo.Teams as T
on S.team_id = T.team_id
where position<=5
order by s.league_id,S.position