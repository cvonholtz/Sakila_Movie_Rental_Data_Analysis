SELECT *
from film_actor fa
order by film_id;

SELECT *
from rental r;

-- 16044 rows
-- main data model
SELECT r.rental_id as rental_id,
lower(f.title) as film_title,
ca.name as film_category,
f.rating as rating,
f.rental_rate as film_rental_rate,
f.'length' as film_length_minutes,
p.amount as rental_amount,
f.rental_duration as rental_duration_day,
r.rental_date as rental_date,
r.rental_date as return_date,
lower(s.first_name || ' ' || s.last_name) as staff_name,
c.customer_id as customer_id,
lower(c.first_name || ' ' || c.last_name) as customer_name,
LOWER(co.country) as customer_country, 
lower(ci.city) as customer_city,
s.store_id as store_id
from rental r 
left join payment p on r.rental_id = p.rental_id 
left join staff s on p.staff_id = s.staff_id 
left join customer c on r.customer_id = c.customer_id 
left join address a on c.address_id = a.address_id 
left join city ci on ci.city_id = a.city_id 
left join country co on ci.country_id = co.country_id 
left join inventory i on r.inventory_id = i.inventory_id 
left join film f on i.film_id = f.film_id 
left join film_category fc on f.film_id = fc.film_id 
left join category ca on fc.category_id = ca.category_id 



-- actors in films
select lower(a.first_name || ' ' || a.last_name) as actor_name,
a.actor_id,
lower(f.title) as film,
f.film_id
from film f 
left join film_actor fa on f.film_id = fa.film_id 
left join actor a on fa.actor_id = a.actor_id 


---store locations
select s.store_id,
co.country as country,
ci.city as city
from store s 
left join address a on s.address_id = a.address_id 
left join city ci on a.city_id = ci.city_id 
left join country co on ci.country_id = co.country_id 


select *
from film;

select *
from customer c
where email like 'mary.smith%';

select *
from address a;

select f.film_id,
a.actor_id 
from film f 
left join film_actor fa on f.film_id = fa.film_id 
left join actor a on fa.actor_id  = a.actor_id
---where f.film_id is null;

select *
from actor a
where a.first_name like 'nic%' or a.last_name like 'cage';


--- Rank sales by Genre
SELECT 
ca.name as film_category,
round(sum(p.amount), 2) as rental_amount,
RANK() OVER(ORDER BY sum(p.amount) DESC) Rank
from rental r 
left join payment p on r.rental_id = p.rental_id 
left join staff s on p.staff_id = s.staff_id 
left join customer c on r.customer_id = c.customer_id 
left join address a on c.address_id = a.address_id 
left join city ci on ci.city_id = a.city_id 
left join country co on ci.country_id = co.country_id 
left join inventory i on r.inventory_id = i.inventory_id 
left join film f on i.film_id = f.film_id 
left join film_category fc on f.film_id = fc.film_id 
left join category ca on fc.category_id = ca.category_id 
GROUP by ca.name
ORDER by rental_amount desc;


with cte as(
	select f.title as film_name,
	c.name as film_category,
	f.rental_duration as rental_duration,
	f.'length' as film_length,
	f.rating as film_rating,
	(a.first_name || ' ' || a.last_name) as actor_name
	from film f 
	left join film_category fc on f.film_id = fc.film_id 
	left join category c on fc.category_id = c.category_id 
	left join film_actor fa on fa.film_id = f.film_id 
	left join actor a on fa.actor_id = a.actor_id 
)

SELECT *
from cte

select *
from actor a 

