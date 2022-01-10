-- Problem 5 : Get the count of bat/field toss_decision for every venue
SELECT venue, toss_decision, COUNT(toss_decision) as toss_decisions_made
FROM ipl_m 
GROUP BY venue, toss_decision 
ORDER BY venue, toss_decision;

-- Bonus : Get the count of bat/field toss_decision for every venue and corresponding win_count for each
SELECT venue, toss_decision, COUNT(toss_decision) as toss_decisions_made,
SUM(CASE WHEN winner = toss_winner THEN 1 ELSE 0 END) AS match_won
FROM ipl_m 
GROUP BY venue, toss_decision 
ORDER BY venue, toss_decision;