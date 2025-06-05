select P1.Name as 'Name of first player',cast(P1.date_of_birth as date) As 'Date of Birth',P2.Name as 'Name of second player'
From FootballData.dbo.Players as P1,
FootballData.dbo.Players as P2
where P1.date_of_birth = P2.date_of_birth
and P1.player_id <P2.player_id
order by P1.date_of_birth