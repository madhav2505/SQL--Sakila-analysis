use sakila;

-- 1a

select first_name,last_name from actor;

-- 1b

select concat(upper(first_name), ' ', upper(last_name)) as 'Actor Name' from actor;

-- 2a

select actor_id, first_name,last_name from actor where first_name='joe';

-- 2b

select * from actor where last_name like '%gen%';

-- 2c

select * from  actor where last_name like '%li%' order by last_name,first_name;

-- 2d

select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');

-- 3a

alter table actor add middle_name char(1) not null after first_name;

-- 3b

alter table actor modify middle_name blob;

-- 3c

alter table actor drop column middle_name;

-- 4a

select last_name, count(*) as 'num of actors with last name' from actor group by last_name;

-- 4b

select last_name, count(*) as 'num of actors with last name' from actor group by last_name having count(*) >= 2;

-- 4c

update actor set first_name = 'HARPO' where last_name = 'WILLIAMS' and first_name = 'GROUCHO';

-- 4d

update actor set first_name = case when first_name = 'HARPO' then 'GROUCHO' else 'MUCHO GROUCHO' end where actor_id = 172;

-- 5a

show create table sakila.address;
desc  sakila.address;

-- 6a

select s.first_name, s.last_name,a.address, a.address2, a.district, c.city, a.postal_code from staff s 
join address a on s.address_id = a.address_id 
join city c on c.city_id = a.city_id;

-- 6b

select s.staff_id, s.first_name, s.last_name, sum(amount) from staff s 
join payment p on s.staff_id = p.staff_id
where month(payment_date) = 8 and year(payment_date) = 2005
group by s.staff_id;

-- 6c

select f.film_id, f.title, count(actor_id) as 'number of actors' from film f
inner join film_actor a on f.film_id = a.film_id
group by f.film_id;

-- 6d

select count(*) from inventory i 
join film f on i.film_id = f.film_id
where f.title = 'HUNCHBACK IMPOSSIBLE';

-- 6e

select c.customer_id, c.first_name, c.last_name, sum(p.amount) as 'Total_Amount' from customer c 
join payment p on c.customer_id = p.customer_id
group by c.customer_id order by c.last_name;

-- 7a

select title from film where title in 
(select title from film where title like 'K%' or title like'Q%');

-- 7b

select actor_id,first_name,last_name from actor where actor_id in 
(select actor_id from film_actor where film_id in( 
 select film_id from film where title = 'ALONE TRIP'));
 
-- 7c

select first_name, last_name, email from customer cus
join address a on cus.address_id = a.address_id
join city c on a.city_id = c.city_id
join country co on co.country_id = c.country_id
where co.country = 'CANADA';

-- 7d

select rating, title, description from film where rating in ('G', 'PG') order by rating;

-- 7e

select title, rental_duration from film order by rental_duration desc;

-- 7f

select s.store_id,  sum(amount) from store s
join customer c on s.store_id = c.store_id
join payment p on p.customer_id =  c.customer_id 
group by s.store_id;

-- 7g

select store_id, address, address2, district, city, postal_code, country from store s 
join address a on s.address_id = a.address_id 
join city c on a.city_id = c.city_id
join country y on c.country_id = y.country_id;

-- 7h

select c.name, sum(amount) as amount from category c
join film_category f on c.category_id = f.category_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by c.name order by amount desc limit 5;

-- 8a

create view top_five_genres as 
select c.name, sum(amount) as amount from category c
join film_category f on c.category_id = f.category_id
join inventory i on i.film_id = f.film_id
join rental r on r.inventory_id = i.inventory_id
join payment p on p.rental_id = r.rental_id
group by c.name order by amount desc limit 5;

-- 8b

select * from top_five_genres;

-- 8c

drop view top_five_genres;




