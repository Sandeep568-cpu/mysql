use project;
select * from swiggy;
select * from swiggy limit 9;
-- 01 HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
select distinct restaurant_name as high_ratted from swiggy where rating >4.5;
-- 02 WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
select city,count(distinct restaurant_name)
 as highest_number_restau  from swiggy 
 group by city 
 order by highest_number_restau desc limit 1;

--  HOW MANY RESTAURANTS SELL( HAVE WORD "PIZZA" IN THEIR NAME)?

select count(distinct restaurant_name) 
as pizza_restaurants from swiggy 
where restaurant_name like '%pizza%';

-- 03 WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
select cuisine, count(*) common_cuisine
from swiggy
group by cuisine
order by common_cuisine desc
limit 1;
select * from swiggy;
-- WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?

select city, avg(rating) 
as average_ratting
from swiggy
group by city;


select city, avg(rating) as average_rating
from swiggy group by city;
-- 06 WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?


select restaurant_name,menu_category, max(price) as highestprice
from swiggy 
where menu_category = 'recommended'
group by restaurant_name,menu_category ;
-- 07 FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE. 
select * from swiggy;

select distinct restaurant_name, cost_per_person
from swiggy
where cuisine<> 'indian' 
 order by cost_per_person desc
 limit 10;
 -- FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL    
   -- RESTAURANTS TOGETHER.
 select distinct restaurant_name,cost_per_person from swiggy 
 where cost_per_person>(select avg(cost_per_person) from swiggy);

-- 09 RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.

select distinct t1.restaurant_name,t1.city,t2.city
from swiggy t1 join swiggy t2  
on t1.restaurant_name=t2.restaurant_name and
t1.city<>t2.city;

-- same table join query 
-- 10 WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?
select * from swiggy;

select distinct restaurant_name,menu_category ,
count(item) as no_of_items 
from swiggy
where menu_category ='main course'
group by restaurant_name,menu_category
order by no_of_items desc limit 1;
-- 11 LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME

select distinct restaurant_name
(count(case when veg_or_nonveg = 'veg'then 1 end)*100/count(*) )
as vegeterian
from swiggy 

group by restaurant_name

having vegeterian =100.00
order by restaurant_name



select distinct restaurant_name ,
(count(case when veg_or_nonveg='Veg' then 1 end)*100/
count(*)) as vegetarian_percetage
from swiggy
group by restaurant_name
having vegetarian_percetage=100.00
order by restaurant_name desc;

-- 12 WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
select distinct restaurant_name ,
 avg(price) as average_price
 from swiggy
group by restaurant_name
order by average_price
limit 1;
select * from swiggy;
-- 13 WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
select distinct restaurant_name, count(distinct menu_category) as no_of_categories from swiggy
group by restaurant_name
order by no_of_categories 
limit 5;

-- 14 WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
select distinct restaurant_name,
(count(case when veg_or_nonveg='Non-veg' then 1 end)*100
/count(*)) as nonvegetarian_percentage
from swiggy
group by restaurant_name
order by nonvegetarian_percentage desc limit 1;

-- 15 Determine the Most Expensive and Least Expensive Cities for Dining:
-- 16 Calculate the Rating Rank for Each Restaurant Within Its City

WITH CityExpense AS (
    SELECT city,
        MAX(cost_per_person) AS max_cost,
        MIN(cost_per_person) AS min_cost
    FROM swiggy
    GROUP BY city
)
SELECT city,max_cost,min_cost
FROM CityExpense
ORDER BY max_cost DESC;

WITH RatingRankByCity AS (
    SELECT distinct
        restaurant_name,
        city,
        rating,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY rating DESC) AS rating_rank
    FROM swiggy
)
SELECT
    restaurant_name,
    city,
    rating,
    rating_rank
FROM RatingRankByCity
WHERE rating_rank = 1;

















