# Netflix Movies and TV Shows Data Analysis using SQL
![netflix_logo (1).png](https://github.com/data-5/Netflix-movie-Analysis-project/blob/main/netflix_logo%20(1).png)

## Overview

This project showcases an in-depth analysis of Netflix’s vast content library, which includes both movies and TV shows. The analysis was conducted using **SQL** to answer 15 critical business questions, providing insights into Netflix's content trends, diversity, and catalog growth. The primary goal is to highlight Netflix’s content strategy through data-driven analysis.

## Objectives

The main objectives of this project are:

- To extract insights into Netflix's content catalog by analyzing its metadata (such as genres, countries, and release dates).
- To use SQL for answering key business questions about Netflix's content library.
- To highlight patterns in content types, production countries, and genre popularity over time.
- To identify trends that could guide Netflix’s content acquisition and recommendation strategies.

## Dataset

The data is sourced from the Kaggle Dataset.
  . Dataset Link [Netflix data]()

**Dataset Attributes:**
- **Total Rows**: 8,807
- **Total Columns**: 12
- **Missing Data**: Present in the *director*, *cast*, and *country* fields.

## Schema

The dataset schema is structured as follows:

| Column        | Description                                                  |
|---------------|--------------------------------------------------------------|
| show_id       | Unique identifier for each title                             |
| type          | Movie or TV Show                                              |
| title         | Title of the movie or TV show                                |
| director      | Director of the title (can be null)                          |
| cast          | Main cast members (can be null)                              |
| country       | Country where the title was produced (can be null)           |
| date_added    | Date the title was added to Netflix                          |
| release_year  | Year the title was originally released                       |
| rating        | Netflix age rating (e.g., PG-13, TV-MA)                      |
| duration      | Duration in minutes (for movies) or number of seasons (TV)   |
| listed_in     | Genres or categories the title belongs to                    |
| description   | Short description or synopsis of the title                   |

## Business Problems

The project aims to address several business problems that Netflix faces, including:

1. **Content Strategy**: How can Netflix optimize its content offerings by identifying the most popular genres and production countries?
2. **Audience Segmentation**: What are the most common content ratings, and how do they align with Netflix's audience segments?
3. **Library Growth**: How has Netflix’s content library evolved over time in terms of both volume and diversity?
4. **Content Acquisition**: Which countries and genres should Netflix target for future content acquisitions to fill gaps in its library?
5. **User Engagement**: How can Netflix leverage insights from genre and duration trends to increase viewer engagement and satisfaction?

## Solutions

To address these business problems, 15 key questions were answered using **SQL** queries. Below are some of the insights derived from this analysis:

### 1. Content Strategy
   - **Solution**: Identified the top 5 most common genres, such as Drama, Comedy, and Documentaries, which dominate Netflix’s content library.
   - **Query Example**:
     ```sql
     SELECT listed_in, COUNT(*) AS count
     FROM netflix_titles
     GROUP BY listed_in
     ORDER BY count DESC
     LIMIT 5;
     ```

### 2. Audience Segmentation
   - **Solution**: Analyzed the distribution of content ratings and found that **TV-MA** is the most frequent rating, aligning with a significant portion of Netflix's mature audience.
   - **Query Example**:
     ```sql
     SELECT rating, COUNT(*) AS total
     FROM netflix_titles
     GROUP BY rating
     ORDER BY total DESC;
     ```

### 3. Library Growth
   - **Solution**: Tracked the release and addition trends by analyzing titles added over time, revealing spikes in content during recent years.
   - **Query Example**:
     ```sql
     SELECT release_year, COUNT(*) AS total
     FROM netflix_titles
     GROUP BY release_year
     ORDER BY release_year;
     ```

### 4. Content Acquisition
   - **Solution**: Determined the countries producing the most Netflix content, with **United States**, **India**, and **UK** leading the charts. This insight can help guide future content partnerships.
   - **Query Example**:
     ```sql
     SELECT country, COUNT(*) AS total
     FROM netflix_titles
     WHERE country IS NOT NULL
     GROUP BY country
     ORDER BY total DESC
     LIMIT 5;
     ```

### 5. User Engagement
   - **Solution**: Analyzed the duration of movies and TV shows, which can inform recommendations. For example, shorter films may attract users looking for quick entertainment.
   - **Query Example**:
     ```sql
     SELECT type, AVG(CAST(SUBSTRING(duration, 1, 2) AS UNSIGNED)) AS avg_duration
     FROM netflix_titles
     WHERE type = 'Movie'
     GROUP BY type;
     ```

## Future Directions

Here are some potential future directions for extending the analysis:
- **Recommendation Systems**: Analyzing viewing trends to build better recommendation algorithms based on user preferences.
- **Regional Preferences**: Conducting a deeper analysis of content preferences in different regions of the world.
- **Sentiment Analysis**: Combining this data with user reviews to assess sentiment and feedback for specific genres or titles.

## Installation

Clone the repository:

```bash
https://github.com/data-5/Netflix-movie-Analysis-project.git
```

### SQL Setup

- You will need a **SQL environment** such as **POSTGRESSQL** to run the provided SQL scripts.
- The dataset is included in a `.csv` file. You can load it into your SQL database using the `LOAD DATA` or `COPY` command.
- Once the dataset is loaded, you can run the SQL queries provided in the `sql_queries.sql` file to reproduce the analysis.
