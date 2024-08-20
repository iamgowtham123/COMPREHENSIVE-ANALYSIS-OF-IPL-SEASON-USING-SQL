-- 1. Scorers in a Match
-- List the top 3 highest-scoring batsmen for a given match along with their runs.


-- USING BATSMEN DATABASE 
use batting_summary;
select * from mytable;

select batsmanName,runs from mytable 
ORDER BY runs DESC
LIMIT 3;


-- 2. Best Economy Rates
-- Find the top 5 bowlers with the best ECONOMY rates in a given season.
-- USING BOWLING DATABASE
use bowling_summary;
select * from mytable;

SELECT bowlerName,economy from mytable order by economy ASC limit 5;

-- 3. Most Sixes in a Match
-- Identify the batsman who hit the most sixes in a particular match.
-- USIMG BATSMAN DATABASE
USE batting_summary;
SELECT * FROM mytable;

select matchh_id,matchh,batsmanName,6s from mytable 
order by 6s 
DESC LIMIT 1;

-- 4. Match Winners by Margin
-- List all matches where the winning team won by a margin of more than  50 runs or 6 wickets.
-- USING MATCH SUMMARY DATABASE

use match_summary;
select * from mytable;
select match_id,winner,margin from mytable where margin > "50 runs" or margin >"6 wickets";


-- 5. Team's Total Runs in a Match
-- Calculate the total runs scored by each team in a specific match.

use batting_summary;
select * from mytable;
select matchh,matchh_id,sum(runs) as total_runs 
from mytable group by matchh_id,matchh;

-- 6. Players' Roles Distribution
-- Count the number of players in each playing role (batsman, bowler, all-rounder, etc.) in the tournament.
-- USING PLAYER DATABASE
use players;
SELECT  * FROM mytable;

select playingRole,count(playingRole) AS COUNTING from mytable group by playingRole;

-- 7. Maiden Overs by Bowlers
-- List the bowlers who have bowled maiden overs in a specific match and how many they bowled.
use bowling_summary;
SELECT  * FROM mytable;
select matchh,bowlerName,count(*) as maiden from mytable Where maiden >= 1 group by matchh,bowlerName;

-- 8. Top Partnerships
-- Determine the highest batting partnership for a particular team in a specific match.
use batting_summary;
SELECT  * FROM mytable;
--------------------------------------------------------------------------------
-- 9. Most Economical Bowler
-- Identify the bowler with the lowest economy rate in matches won by their team.
use bowling_summary;
SELECT  * FROM mytable;

use match_summary;
select * from mytable;



SELECT b.bowlingTeam, b.bowlerName,m.winner, MIN(b.economy) AS lowest_economy_rate
FROM bowling_summary.mytable b
JOIN match_summary.mytable m ON b.matchh_id = m.match_id
WHERE b.bowlingTeam = m.winner
GROUP BY b.bowlerName, b.bowlingTeam,m.winner
ORDER BY lowest_economy_rate ASC
LIMIT 1;


-- 10.Centuries and Half-Centuries
-- List all the batsmen who have scored centuries (100 or more runs) or half-centuries (50-99 runs) in a match.

use batting_summary;
select * from mytable;


select batsmanName,matchh_id,runs,
Case 
When runs>=100 THEN "Century"
When runs>=50 AND runs < 100 Then "Half-Century"
ELSE "Dummy"
ENd as run_category
FRom mytable
where runs>=50
order by runs desc;

-- 11.Most Dismissals by a Bowler
-- Find the bowler with the highest number of dismissals (wickets taken) in a particular match.

use bowling_summary;
select * from mytable;

select bowlerName,matchh,matchh_id,sum(wickets) as wicket from mytable
GROUP BY matchh_id,bowlerName,matchh
order by wicket desc
limit 1;


-- 12.Boundary Hitters
-- List the batsmen who have hit more than 5 boundaries (fours and sixes) in a match.

use batting_summary;
select * from mytable;

select matchh_id,batsmanName,6s,4s,matchh from mytable where 6s > 5 or 4s > 5
group by matchh_id,batsmanName,4s,6s,matchh

-- 13.Win Percentage of Teams
-- Calculate the win percentage of each team across the tournament.

use match_summary;
select * from mytable;


SELECT m.winner,COUNT(m.winner) AS total_wins,
(COUNT(m.winner) / (SELECT COUNT(*) FROM match_summary.mytable)) * 100 AS win_percentage
FROM match_summary.mytable m
GROUP BY m.winner ORDER BY win_percentage DESC;

-- 14.All-round Performers
-- Identify players who have scored more than 50 runs and taken 3 or more wickets in a match.

use batting_summary;
select * from mytable;
use bowling_summary;
select * from mytable;


select DISTINCT b.matchh_id,b.batsmanName,b.runs,bw.wickets from batting_summary.mytable b
JOIN bowling_summary.mytable bw ON b.batsmanName = bw.bowlerName
 where b.runs>50 and bw.wickets>=3

-- 15.Match Results by Date
-- List all matches with their results (winner, margin) that were played on a specific date.

use match_summary;
select * from mytable;


select m.winner,m.margin,m.matchDate from mytable m
Where m.matchDate="Oct 15, 2021"

