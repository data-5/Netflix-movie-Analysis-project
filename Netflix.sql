-- Netflix Project
DROP TABLE IF EXISTS netflix_data ;
Create Table netflix_data
(
show_id VARCHAR(6),
type VARCHAR(10),
title VARCHAR(150),
director VARCHAR(250),
castS VARCHAR(1000),
country VARCHAR(150),
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(10),
duration VARCHAR(15),
listed_in VARCHAR(100),
description VARCHAR(250)
);

SELECT * FROM netflix_data;

SELECT
COUNT(*) as total_content
FROM netflix_data;

SELECT 
DISTINCT type
FROM netflix_data ;

-- 15 Business Problems

-- 1. Count the number of movies vs Tv shows
SELECT 
type,
COUNT(*) as total_content
FROM netflix_data
GROUP BY 1;

-- 2. Find the most common rating for movies and Tv shows
SELECT 
type,rating
FROM
(SELECT
type,rating,
COUNT(*) as highest,
RANK() OVER(PARTITION BY type ORDER BY count(*) desc) AS RANKING
FROM netflix_data
GROUP BY 1,2
)as t1
	WHERE 
	ranking = 1;
;

-- 3. list all movies released in a specific year (e.g .2020)
SELECT * FROM netflix_data
WHERE
type = 'Movie'
AND
release_year = 2020
;

-- 4. Find the  top 5 countries with the most content on netflix
SELECT * FROM netflix_data;
SELECT 
TRIM(UNNEST(STRING_TO_ARRAY(country,','))) as countries,
COUNT(show_id) as counts
FROM netflix_data
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 5. Identify the longest movie
SELECT * FROM netflix_data
WHERE type = 'Movie'
AND 
SPLIT_PART(duration,' ',1)::numeric = (SELECT Max(SPLIT_PART(duration,' ',1)::numeric) FROM netflix_data)

-- 6. Find the content that added in the last 5 years
SELECT 
*
FROM netflix_data
WHERE TO_DATE(date_added,'Month dd,yyyy')>= CURRENT_DATE - INTERVAL '5 YEARS';

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka';
SELECT * FROM 
netflix_data
WHERE 
director ILIKE '%Rajiv Chilaka%';

-- 8. List of all the TV shows with more than 5 season
SELECT 
duration
FROM 
netflix_data
WHERE type = 'TV Show'
AND 
SPLIT_PART(duration,' ',1)::numeric > 5
order by 
SPLIT_PART(duration,' ',1)::numeric desc
;

-- 9. Count the number of content items in each genre
SELECT 
TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ',')))as genre,
COUNT(show_id) as total_content
FROM
netflix_data
GROUP BY genre
ORDER BY COUNT(*) DESC;

-- 10. Find each year and the average numbers of content release by India on netflix,
 -- return top 5 year with the highest avg content release
SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month dd,yyyy')),
	COUNT(*) AS yearly_content,
	ROUND(COUNT(*)::numeric /(SELECT COUNT(*) FROM netflix_data WHERE country = 'India')::numeric * 100 
	,2)as avg_content_per_year
	FROM
	netflix_data
	WHERE COUNTRY = 'India'
	GROUP BY 1;

-- 11. List all the movies that are documentaries
SELECT 
*
FROM netflix_data
WHERE type = 'Movie'
AND 
listed_in ilike '%Documentaries%';

-- 12. Find all content without a director
SELECT * FROM netflix_data
WHERE 
	director IS NULL;

-- 13. Find how many movie actors 'Salman Khan' appeared in the last 10 years!
SELECT
 *
FROM netflix_data
WHERE 
	casts ilike '%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10 ;

-- 14. Find the top 10 actors who appeared in the highest number of movies produced in india.
SELECT
UNNEST(STRING_TO_ARRAY(casts,','))as actors,
COUNT (*)
FROM netflix_data
WHERE country ilike '%India%'
GROUP BY 1
ORDER BY 2 DESC;

-- 15. Categorize the content based on the presence of the kwywords 'kill' and 'violence' in the description field.
-- Label content containing these keywords as 'Bad' a nd all other content as 'Good'. Count how many items fall into each category.
WITH new_table
AS
(
SELECT 
*, CASE
	WHEN description ILIKE '%kill%' OR
	description ILIKE '%violent%' THEN 'Bad_Content'
	ELSE 'Good_Content'
END category
FROM netflix_data
)
SELECT 
category,
COUNT(*) as total_count
FROM new_table
GROUP BY 1

