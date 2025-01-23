create database ipl_project_db;

use ipl_project_db;

-- convert the date datatype text to date

alter table matches
add column U_date date;

set sql_safe_updates = 0;

update matches
set U_date = str_to_date(date, "%d-%m-%Y");

-- Count of matches by umpires :
select umpire, count(umpire) as total_umpire 
from (
		select umpire1 as umpire from matches
        union all
		select umpire2 as umpire from matches
	) as combined_umpires
group by umpire
order by total_umpire desc
limit 10;

--  Most number of wins :
select winner, count(winner) as total_winner
from matches
group by winner
order by total_winner desc;

-- Number of tosses won by teams:
select toss_winner, count(toss_winner) as total_toss_win
from matches
group by toss_winner
order by total_toss_win desc;

-- Decision made after winning the toss :
with TossCounts as(select toss_decision, count(toss_decision) as total_toss_decision
from matches
group by toss_decision)

select toss_decision, (total_toss_decision / sum(total_toss_decision) over()) * 100 as percentage
from TossCounts;

