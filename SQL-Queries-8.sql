use sakila;

#1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length  , rank() over(order by length desc) as "Rank"
from film
where length is not null or length <> 0;

#2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, length, rating, rank() over(partition by rating order by length desc) as "Rank"
from film
where length is not null or length <> 0;

#3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select name, count(film_id) from category c
left join film_category fc on c.category_id = fc.category_id
group by c.category_id;

#4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select a.actor_id, count(film_id) from actor a 
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
order by count(film_id) desc limit 1;

-- SELECT 
--     a.actor_id, COUNT(f.film_id) AS cnt, GROUP_CONCAT(f.title)
-- FROM
--     actor a
--         INNER JOIN
--     film_actor fa ON a.actor_id = fa.actor_id
--         INNER JOIN
--     film f ON f.film_id = fa.film_id
-- GROUP BY a.actor_id
-- ORDER BY cnt DESC
-- LIMIT 1;

#5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select c.customer_id, count(rental_id) from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id
order by count(rental_id) desc limit 1;

#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
select f.film_id, f.title, count(rental_id) as cnt from film f 
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id
order by cnt desc limit 1;