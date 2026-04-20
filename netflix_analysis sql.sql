create database netflix;

use netflix;

CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    country VARCHAR(50),
    signup_date DATE
);

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT,
    rating FLOAT
);

CREATE TABLE Subscriptions (
    sub_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    plan VARCHAR(20),
    start_date DATE,
    end_date DATE,
    price DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE WatchHistory (
    watch_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watch_date DATE,
    watch_duration INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);


#Users 
INSERT INTO Users (name, age, gender, country, signup_date) VALUES
('Ayesha', 25, 'Female', 'India', '2024-01-05'),
('Imran', 30, 'Male', 'India', '2024-01-12'),
('Zara', 27, 'Female', 'UAE', '2024-02-10'),
('Rohan', 35, 'Male', 'USA', '2024-03-15'),
('Fatima', 28, 'Female', 'UK', '2024-03-20'),
('Vivek', 22, 'Male', 'India', '2024-04-01'),
('Meera', 26, 'Female', 'India', '2024-04-12'),
('Karan', 33, 'Male', 'Canada', '2024-05-05'),
('Sneha', 24, 'Female', 'India', '2024-05-20'),
('John', 40, 'Male', 'USA', '2024-06-01');

#Movies 
INSERT INTO Movies (title, genre, release_year, rating) VALUES
('The Silent Sea', 'Sci-Fi', 2022, 8.1),
('Money Heist', 'Thriller', 2021, 9.0),
('Friends Reunion', 'Comedy', 2021, 8.5),
('Dark', 'Sci-Fi', 2020, 9.2),
('Stranger Things', 'Horror', 2023, 8.9),
('The Office', 'Comedy', 2019, 8.8),
('Extraction', 'Action', 2020, 7.8),
('Dune', 'Sci-Fi', 2021, 8.2),
('Wednesday', 'Horror', 2023, 8.6),
('Inception', 'Action', 2010, 9.3);

#Subscription 
INSERT INTO Subscriptions (user_id, plan, start_date, end_date, price) VALUES
(1, 'Basic', '2024-01-05', '2024-04-05', 499.00),
(2, 'Premium', '2024-01-12', '2024-07-12', 999.00),
(3, 'Standard', '2024-02-10', '2024-05-10', 699.00),
(4, 'Premium', '2024-03-15', '2024-09-15', 999.00),
(5, 'Standard', '2024-03-20', '2024-06-20', 699.00),
(6, 'Basic', '2024-04-01', '2024-07-01', 499.00),
(7, 'Standard', '2024-04-12', '2024-07-12', 699.00),
(8, 'Premium', '2024-05-05', '2024-11-05', 999.00),
(9, 'Basic', '2024-05-20', '2024-08-20', 499.00),
(10, 'Premium', '2024-06-01', '2024-12-01', 999.00);

#Watchhistory
INSERT INTO WatchHistory (user_id, movie_id, watch_date, watch_duration) VALUES
(1, 1, '2024-02-01', 120),
(1, 3, '2024-02-10', 90),
(2, 2, '2024-03-01', 150),
(2, 10, '2024-03-10', 130),
(3, 5, '2024-03-20', 100),
(3, 9, '2024-03-25', 110),
(4, 4, '2024-04-01', 200),
(4, 10, '2024-04-05', 180),
(5, 6, '2024-04-10', 140),
(5, 3, '2024-04-15', 80),
(6, 7, '2024-04-20', 160),
(7, 5, '2024-05-01', 120),
(7, 9, '2024-05-03', 90),
(8, 8, '2024-05-10', 150),
(8, 10, '2024-05-15', 170),
(9, 6, '2024-05-25', 130),
(9, 1, '2024-05-30', 100),
(10, 4, '2024-06-05', 190),
(10, 2, '2024-06-10', 160),
(10, 9, '2024-06-15', 120);


select * from users;
select * from movies;
select * from subscriptions;
select * from watchhistory;


#1. total number of users

select count(distinct user_id) as 'total users'
from users;

#This tells management how many unique customers have signed up on the platform.

#2. Users by country.

select name, country
from users;

select country,
count(name) as 'total users'
from users
group by country
order by 'total users' desc ;

#This shows which countries contribute the most users, helping decide where to invest in marketing and content.


#3. Subscription revenue by plan.

select plan, sum(price) as revenue
from subscriptions
group by plan
order by revenue desc;

#This calculates how much money each plan generates, helping evaluate which plan is most profitable.


#4. Most popular subscription plan.

select plan, count(user_id) as 'total users'
from subscriptions
group by plan
order by 'total users'
limit 1 ;

#This identifies the most subscribed plan; in this dataset, 
#Premium has the highest number of subscribers, indicating users value premium features.


#5. Top 5 rated movies.

select title, genre, rating
from movies
order by rating desc
limit 5 ;

#This helps highlight the highest-rated content, useful for recommendations and promotions on the home page.


#6. Most watched movies.

SELECT title, genre, COUNT(*) AS watch_count
FROM WatchHistory 
JOIN Movies  ON watchhistory.movie_id = Movies.movie_id
GROUP BY movies.movie_id, movies.title, movies.genre
ORDER BY watch_count desc
limit 3;

#This shows which movies are watched most often, indicating what type of content users actually consume, not just rate highly.


#7. Genre popularity (which genre is watched the most?).

select genre, count(genre) as watch
from watchhistory
join movies on watchhistory.movie_id = movies.movie_id
group by movies.genre
order by watch desc
limit 2 ;

#This tells us which genres drive the most viewing time;
# here Sci-Fi and Horror are among the top, useful for deciding future content investments.


# 8. Average watch time per user.

select name, avg(watch_duration) as avg_time
from users
join watchhistory on users.user_id = watchhistory.user_id
group by name
order by avg_time desc;

#This shows how engaged each user is on average per session, helping identify power users vs low-engagement users.


# 9. Which country spends the most time watching?

select country, sum(watch_duration) as 'total watch time'
from users
join watchhistory on users.user_id = watchhistory.user_id
group by country
order by 'total watch time' desc
limit 1 ;

#This summarizes total watch time by country and finds the top one, 
#indicating where users are most engaged with the platform.


#10.Rank movies by rating within each genre.

select genre, title, rating, rank() over (partition by genre order by rating desc) as 'rank'
from movies;

#This ranks movies inside each genre segment.


