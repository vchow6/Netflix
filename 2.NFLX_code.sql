USE netflix;

#Create nflx_top_ten table
CREATE TABLE nflx_top_ten(
	category varchar(50),
    cumulative_weeks_in_top_10 int,
    weekly_hours_viewed int,
    season_title varchar(50),
    weekly_rank	int,
    show_title varchar(50),
    date_added date,
    week date
);

#import nflx_top_ten file
LOAD DATA LOCAL INFILE '/Users/viridianachow/Desktop/Resume/YipitData/NFLX_DS_9_23/CSV/nflx_top_ten.csv'
INTO TABLE nflx_top_ten
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM nflx_top_ten;

#Create imdb_rating table
CREATE TABLE imdb_rating(
	title varchar(50),
    rating int
);

#import imdb_rating file
LOAD DATA LOCAL INFILE '/Users/viridianachow/Desktop/Resume/YipitData/NFLX_DS_9_23/CSV/imdb_rating.csv'
INTO TABLE imdb_rating
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM imdb_rating;

#create runtime table
CREATE TABLE runtime(
	title varchar(50),
    runtime int
);

#import runtime file
LOAD DATA LOCAL INFILE '/Users/viridianachow/Desktop/Resume/YipitData/NFLX_DS_9_23/CSV/runtime.csv'
INTO TABLE runtime
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * FROM runtime;

#Question 1
SELECT
	show_title,
	COUNT(show_title) AS num_of_appearance,
    ROUND(AVG(weekly_hours_viewed), 2) AS avg_weekly_hours_viewed
FROM
	nflx_top_ten
WHERE category = 'TV (English)'
GROUP BY show_title
ORDER BY COUNT(show_title) DESC
LIMIT 1;

#Question 2a
SELECT
	nf.show_title AS show_title,
    im.rating AS rating
FROM
	nflx_top_ten nf
		RIGHT JOIN 
	imdb_rating im ON nf.show_title = im.title
WHERE
	nf.category = 'Films (Non-English)'
ORDER BY rating ASC
LIMIT 1;

#Qeustion 2b
SELECT
	show_title,
    ROUND(AVG(weekly_hours_viewed), 2) AS avg_weekly_hours_viewed
FROM
	nflx_top_ten
WHERE
	show_title = 'Words Bubble Up Like Soda Pop';

#Question 3
SELECT
	show_title,
    cumulative_weeks_in_top_10
FROM
	nflx_top_ten
WHERE category = 'Films (English)'
ORDER BY cumulative_weeks_in_top_10 DESC
LIMIT 1;

SELECT
	show_title,
    SUM(weekly_hours_viewed)
FROM
	nflx_top_ten
WHERE show_title = 'Red Notice'
GROUP BY show_title;


SELECT 
	title,
    runtime AS runtime_min,
    runtime/60 AS runtime_hrs
FROM
	runtime
WHERE
	title = 'Red Notice';


