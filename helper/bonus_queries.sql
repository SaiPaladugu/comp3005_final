-- Divide the goal into 6 equal-size areas (top-left, top-middle, top-right, bottom-left, bottom-middle, and
-- bottom-right). In the La Liga seasons of 2020/2021, 2019/2020, and 2018/2019 combined, find the players
-- who shot the most in either the top-left or top-right corners. Sort them from highest to lowest


SELECT 
    Shot.player_name,
    COUNT(Shot.event_id) AS number_of_shots
FROM 
    Shot
JOIN 
    Matches ON Shot.match_id = Matches.match_id
JOIN 
    Competitions ON Matches.competition_id = Competitions.competition_id 
    AND Matches.season_id = Competitions.season_id
WHERE 
    Competitions.competition_name = 'La Liga' 
    AND (
        Competitions.season_name = '2020/2021' 
        OR Competitions.season_name = '2019/2020'
        OR Competitions.season_name = '2018/2019'
    )
    AND (
        ((Shot.end_location_y <= 38.67 AND Shot.end_location_y >= 36) AND (Shot.end_location_z >= 1.33 AND Shot.end_location_z <= 2.67))
        OR 
        ((Shot.end_location_y >= 41.33 AND Shot.end_location_y <= 44) AND (Shot.end_location_z >= 1.33 AND Shot.end_location_z <= 2.67))
    )
GROUP BY 
    Shot.player_name
HAVING 
    COUNT(Shot.event_id) >= 1
ORDER BY 
    number_of_shots DESC;

------------------------------------------------------------------------------------------------------------------------------

-- In the La Liga season of 2020/2021, find the teams with the most successful passes into the box. Sort
-- them from the highest to lowest

SELECT 
    Pass.team_name,
    COUNT(Pass.event_id) AS number_of_passes
FROM 
    Pass
JOIN 
    Matches ON Pass.match_id = Matches.match_id
JOIN 
    Competitions ON Matches.competition_id = Competitions.competition_id 
    AND Matches.season_id = Competitions.season_id
WHERE 
    Competitions.competition_name = 'La Liga' 
    AND Competitions.season_name = '2020/2021'
    AND Pass.end_location_x BETWEEN 102 AND 120
    AND Pass.end_location_y BETWEEN 18 AND 62
GROUP BY 
    Pass.team_name
HAVING 
    COUNT(Pass.event_id) >= 1
ORDER BY 
    number_of_passes DESC;