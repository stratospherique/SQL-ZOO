/* 1. Modify it to show the matchid and player name for all goals scored by Germany.*/
SELECT goal.matchid, goal.player FROM goal 
INNER JOIN eteam ON goal.teamid = eteam.id
  WHERE goal.teamid = 'GER';

  /*2.  Show id, stadium, team1, team2 for just game 1012*/
SELECT id,stadium,team1,team2
  FROM game
WHERE id=1012;

/* 3. Modify it to show the player, teamid, stadium and mdate for every German goal.*/
SELECT g.player,g.teamid,m.stadium,m.mdate
  FROM game m JOIN goal g ON (g.matchid=m.id)
WHERE g.teamid='GER';

/* 4. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'*/
SELECT ga.team1,ga.team2, go.player
FROM game ga
INNER JOIN goal go ON go.matchid=ga.id
WHERE go.player LIKE 'Mario%';

/* 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */
SELECT go.player, go.teamid,et.coach, go.gtime
  FROM goal go 
INNER JOIN eteam et ON go.teamid = et.id 
 WHERE go.gtime<=10;

 /* 6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */
 SELECT ga.mdate, et.teamname
FROM game ga
INNER JOIN eteam et ON (ga.team1=et.id )
WHERE et.coach = 'Fernando Santos' ;

/* 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */
SELECT go.player
FROM goal go
INNER JOIN game ga ON go.matchid = ga.id
WHERE ga.stadium = 'National Stadium, Warsaw';

/* 8.  nstead show the name of all players who scored a goal against Germany.*/
SELECT DISTINCT go.player
  FROM game ga JOIN goal go ON go.matchid = ga.id 
    WHERE ((ga.team1='GER' AND ga.team2!='GER') OR (ga.team1!='GER' AND ga.team2='GER')) AND (go.teamid !='GER');


/* 9.  Show teamname and the total number of goals scored*/
SELECT b.teamname , COUNT(x.teamid)
 FROM goal x
JOIN eteam b ON x.teamid=b.id
GROUP BY b.teamname

/* 10.  Show the stadium and the number of goals scored in each stadium*/
SELECT ga.stadium,COUNT(go.matchid)
FROM goal go
INNER JOIN game ga ON go.matchid=ga.id
GROUP BY ga.stadium

/* 11. For every match involving 'POL', show the matchid, date and the number of goals scored. */
SELECT goal.matchid,game.mdate,COUNT(goal.matchid)
  FROM game JOIN goal ON goal.matchid = game.id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid,game.mdate;

/* 12.  For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'*/ 
SELECT goal.matchid,game.mdate,COUNT(goal.teamid)
FROM goal
INNER JOIN game ON goal.matchid = game.id
WHERE goal.teamid='GER'
GROUP BY goal.matchid,game.mdate

/* 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises. */
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1, 
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM game 
LEFT JOIN goal 
ON matchid = id
GROUP by mdate, matchid, team1, team2;