create database Game_DB;
use Game_DB;
create table Top_100_games_2025
(
    rank_ INT NOT NULL AUTO_INCREMENT,
    game_name VARCHAR(300) NOT NULL,
    current_players INT,
    peak_players INT,
    hours_played VARCHAR(50),
    PRIMARY KEY (rank_)
);
-- alter table top_100_games_2025
-- add column Rank_ int first;

-- alter table top_100_games_2025
-- drop Rank_;

select*from top_100_games_2025; 

-- truncate table top_100_games_2025; 