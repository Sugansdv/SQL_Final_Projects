CREATE DATABASE sports_tournament_tracker;
USE sports_tournament_tracker;

CREATE TABLE teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team1_id INT NOT NULL,
    team2_id INT NOT NULL,
    match_date DATE NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES teams(id) ON DELETE CASCADE,
    FOREIGN KEY (team2_id) REFERENCES teams(id) ON DELETE CASCADE
);

CREATE TABLE scores (
    match_id INT NOT NULL,
    team_id INT NOT NULL,
    score INT NOT NULL,
    PRIMARY KEY (match_id, team_id),
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

INSERT INTO teams (name) VALUES
('Lions'),
('Tigers'),
('Bears');

INSERT INTO matches (team1_id, team2_id, match_date) VALUES
(1, 2, '2025-08-01'),
(1, 3, '2025-08-03'),
(2, 3, '2025-08-05');

INSERT INTO scores (match_id, team_id, score) VALUES
(1, 1, 3), (1, 2, 2), 
(2, 1, 1), (2, 3, 4), 
(3, 2, 2), (3, 3, 2); 


-- Win/loss stats 
SELECT 
    t.name AS team_name,
    SUM(CASE WHEN s.score > opp.score THEN 1 ELSE 0 END) AS wins,
    SUM(CASE WHEN s.score < opp.score THEN 1 ELSE 0 END) AS losses,
    SUM(CASE WHEN s.score = opp.score THEN 1 ELSE 0 END) AS draws
FROM teams t
JOIN scores s ON t.id = s.team_id
JOIN scores opp 
    ON s.match_id = opp.match_id AND s.team_id <> opp.team_id
GROUP BY t.name
ORDER BY wins DESC, draws DESC;

-- Leaderboard ranking 
SELECT 
    t.name AS team_name,
    SUM(
        CASE 
            WHEN s.score > opp.score THEN 3
            WHEN s.score = opp.score THEN 1
            ELSE 0
        END
    ) AS points
FROM teams t
JOIN scores s ON t.id = s.team_id
JOIN scores opp 
    ON s.match_id = opp.match_id AND s.team_id <> opp.team_id
GROUP BY t.name
ORDER BY points DESC, team_name;

-- upcoming matches
SELECT 
    m.match_date,
    t1.name AS team1,
    t2.name AS team2
FROM matches m
JOIN teams t1 ON m.team1_id = t1.id
JOIN teams t2 ON m.team2_id = t2.id
WHERE m.match_date >= CURDATE()
ORDER BY m.match_date;


