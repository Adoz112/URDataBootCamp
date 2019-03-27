-- Section 1 (1a, 1b)
SELECT first_name, last_name
FROM actor

SELECT upper(concat(first_name,' ',last_name)) as 'Actor Name'
	from actor;
-- Section 2 (2a, 2b, 2c, 2d)
SELECT actor_id, first_name, last_name
	from actor
	where first_name like 'Joe';

SELECT first_name, last_name
	from actor
	where last_name like '%GEN%';

SELECT first_name, last_name
	from actor
	where last_name like '%LI%'
	order by last_name, first_name;

SELECT country_id, country
	from country
	where country in ('Afghanistan', 'Bangladesh', 'China');

-- Section 3 (3a, 3b, 3c)
alter table actor
	add column middle_name varchar(30) after first_name;
	select *
	from actor;
    
alter table actor
	modify column middle_name blob;
	select *
	from actor;
	
alter table actor
	drop column middle_name;
	select *
    from actor;

-- Section 4 (4a, 4b, 4c, 4d)
select last_name as 'Last Name', count(last_name) as 'Last Name Count'
	from actor
	group by last_name;

select last_name as 'Last Name', count(last_name) as 'Last Name Count'
	from actor
	group by last_name
	having count(last_name) > 1;

select first_name, last_name
	from actor
	where first_name = 'Groucho' and last_name = 'Williams';
	update actor
	set first_name = 'HARPO'
	where first_name = 'Groucho' and last_name = 'Williams';
	select *
	from actor
	where last_name = 'Williams';
	
select first_name
	from actor
	where first_name = 'Harpo';
    
update actor
	set first_name = 'GROUCHO'
	where first_name = 'Harpo';
update actor
	set first_name = case
		when first_name = 'Harpo' THEN 'GROUCHO'
    	when first_name = 'Groucho' THEN 'MUCHO GROUCHO'
    	else first_name
	END;
select *
from actor;

-- Section 5 (5a) + Section 6 (6a, 6b, 6c, 6d, 6e)
create table address_new (
		address_id integer(11) NOT NULL,
    		address varchar(30) NOT NULL,
    		adress2 varchar(30) NOT NULL,
    		district varchar(30) NOT NULL,
    		city_id integer(11) NOT NULL,
    		postal_code integer(11) NOT NULL,
    		phone integer(10) NOT NULL,
    		location varchar(30) NOT NULL,
    		last_update datetime
	);
select s.first_name as 'First Name', s.last_name as 'Last Name', a.address as 'Address'
	from staff as s
	join address as a 
	ON a.address_id = s.address_id;
select concat(s.first_name,' ',s.last_name) as 'Staff Member', sum(p.amount) as 'Total Amount'
	from payment as p
	join staff as s
	on p.staff_id = s.staff_id
	where payment_date like '2005-08%'
	group by p.staff_id;
select f.title as 'Film', count(fa.actor_id) as 'Number of Actors'
	from film as f
	join film_actor as fa
	on f.film_id = fa.film_id
	group by f.title;
select f.title as Film, count(i.inventory_id) as 'Inventory Count'
	from film as f
	join inventory as i
	on f.film_id = i.film_id
	where f.title = 'Hunchback Impossible'
	group by f.film_id;
select concat(c.first_name,' ',c.last_name) as 'Customer Name', sum(p.amount) as 'Total Paid'
	from payment as p
	join customer as c
	on p.customer_id = c.customer_id
	group by p.customer_id;
    
-- Section 7 (7a, 7b, 7c, 7d, 7e, 7f, 7g, 7h)
select f.title
	from film as f
	join language as l
	on f.language_id = l.language_id
	where f.title like 'K%' or 'Q%' and l.name = 'English';
select CONCAT(first_name,' ',last_name) as 'Actors in Trip'
	from actor
	where actor_id in 
	(select actor_id from film_actor where film_id = 
	(select film_id from film where title = 'Alone Trip'));
select concat(c.first_name,' ',c.last_name) as 'Name', c.email as 'E-mail'
	from customer as c
	join address as a on c.address_id = a.address_id
	join city as cty on a.city_id = cty.city_id
	join country as cit on cit.country_id = cty.country_id
	where cit.country = 'Canada';
select f.title as 'Movie Title'
	from film as f
	join film_category as fa on fa.film_id = f.film_id
	join category as c on c.category_id = fa.category_id
	where c.name = 'Family';
select f.title as 'Movie', count(r.rental_date) as 'Times Rented'
	from film as f
	join inventory as i on i.film_id = f.film_id
	join rental as r on r.inventory_id = i.inventory_id
	group by f.title
	order by count(r.rental_date) desc;

select store as 'Store', total_sales as 'Total Sales' from sales_by_store;

select concat(c.city,', ',cty.country) as `Store`, s.store_id as 'Store ID', sum(p.amount) as `Total Sales` 
from payment as p
join rental as r on r.rental_id = p.rental_id
join inventory as i on i.inventory_id = r.inventory_id
join store as s on s.store_id = i.store_id
join address as a on a.address_id = s.address_id
join city as c on c.city_id = a.city_id
join country as cty on cty.country_id = c.country_id

select s.store_id as 'Store ID', c.city as 'City', cty.country as 'Country'
from store as s
join address as a on a.address_id = s.address_id
join city as c on c.city_id = a.city_id
join country as cty on cty.country_id = c.country_id
order by s.store_id;

select c.name as 'Film', sum(p.amount) as 'Gross Revenue'
from category as c
join film_category as fc on fc.category_id = c.category_id
join inventory as i on i.film_id = fc.film_id
join rental as r on r.inventory_id = i.inventory_id
join payment as p on p.rental_id = r.rental_id
group by c.name
order by sum(p.amount) desc limit 5;


	
-- Section 8 (8a, 8b, 8c)
select c.name as 'Film', sum(p.amount) as 'Top_5_Genres'
from category as c
join film_category as fc on fc.category_id = c.category_id
join inventory as i on i.film_id = fc.film_id
join rental as r on r.inventory_id = i.inventory_id
join payment as p on p.rental_id = r.rental_id
group by c.name
order by sum(p.amount) desc limit 5;

alter table film
drop column Top_5_Genres;
select *
from film;










	
	

	



