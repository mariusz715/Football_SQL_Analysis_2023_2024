WITH Half as
(Select T.name,
sum(Case when (T.team_id = M.home_team_id and M.winner = 'HOME_TEAM') or 
	(M.winner = 'AWAY_TEAM' and  T.team_id = away_team_id ) then 3 
	  when winner = 'DRAW' then 1 else 0 end) as 'Points',
Rank() Over( Order by 
			sum(Case when (T.team_id = M.home_team_id and M.winner = 'HOME_TEAM') or 
			(M.winner = 'AWAY_TEAM' and  T.team_id = away_team_id ) then 3 
			when winner = 'DRAW' then 1 else 0 end) DESC) as 'Half Season Position'
From FootballData.dbo.Matches as M
left join FootballData.dbo.Teams as T
	on T.team_id = M.away_team_id or T.team_id = M.home_team_id
where T.league_id = 1 and cast(utc_date as date) < '01.01.2024'
group by T.name),

FullSeason as
(select S.standing_id,T.name,S.points 
From FootballData.dbo.Teams as T
join FootballData.dbo.Standings as S
	on T.team_id = S.team_id
where T.league_id = 1
)

select FS.name, H.[Half Season Position],
case when H.[Half Season Position]-FS.standing_id>0 then N'↑ '+ CAST( (H.[Half Season Position]-FS.standing_id) as nvarchar)
	 when H.[Half Season Position]-FS.standing_id<0 then N'↓ '+ CAST( (FS.standing_id-H.[Half Season Position]) as nvarchar)
	 else '= 0'
end as 'Progress', FS.standing_id,FS.points
From Half as H 
join FullSeason as FS
on H.name = FS.name