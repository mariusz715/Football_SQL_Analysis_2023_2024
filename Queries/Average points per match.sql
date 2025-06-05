select Rank() over(order by Format(cast(points/(S.won+S.draw+s.lost) as float),'0.00') desc) as Position,
T.name,L.name as 'League',(S.won+S.draw+s.lost) as 'Matches',S.points,
Format(cast(points/(S.won+S.draw+s.lost) as float),'0.00') as 'Average points per match',
S.won,s.draw,s.lost
From FootballData.dbo.Standings as S
join FootballData.dbo.Teams as T
on S.team_id = T.team_id
join FootballData.dbo.Leagues as L
on T.league_id = L.league_id
order by 'Average points per match' desc