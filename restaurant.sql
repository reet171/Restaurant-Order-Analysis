use restaurant;

-- Explore Menu table.
-- 1. View the menu_items table.
select * from menu_items;

-- 2. Find the number of items on the menu?
select count(*) from menu_items;

-- 3. What are the least and most expensive items on the menu?
select * from menu_items
order by price;

select * from menu_items
order by price desc;

-- 4. How many italian dishes are on the menu?
select count(*) from menu_items
where category='Italian';

-- 5. What are the least and most expensive Italian dishes on the menu?
select *from menu_items
where category='Italian'
order by price;

select *from menu_items
where category='Italian'
order by price desc;

-- 6. How many dishes are in each category?
select category,count(menu_item_id) as num_dishes
from menu_items
group by category; 


-- 7. What is the average dish price within each category?
select category,avg(price) as avg_price
from menu_items
group by category; 


-- Explore order table.
-- 1. View the order_details table?
select * from order_details;

-- 2. What is the date range of the table?
select min(order_date),max(order_date) from order_details;

-- 3. How many orders were made within this date range?
select count(distinct order_id) from order_details;

-- 4. How many items were ordered within this date range?
select count(*) from order_details;

-- 5. Which orders had the most number of items?
select order_id,count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;

-- 6. How many orders had more than 12 items?
select count(*) from
(select order_id,count(item_id) as num_items
from order_details
group by order_id
having num_items>12) as num_orders;


-- Analyze the customer behavior
-- 1. Combine the menu_items and order_details tables into a single table.
select * from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items?what categories were they in?
select item_name,category,count(order_details_id) as num_purchases
from order_details od
left join menu_items mi
on od.item_id = mi.menu_item_id
group by item_name,category
order by num_purchases desc;

-- 3. What are the top 5 orders that spent the most money?
select order_id,sum(price) as total_spend
from order_details od left join menu_item mi
on od.item_id=mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;

-- 4. View the details of the highest spend order.What insights can you gather from the data.
select category,count(item_id) as num_items
from order_details od  left join menu_items mi
on od.item_id = mi.menu_item_id
where order_id = 400
group by category;


-- 5. View the details of the to 5 highest spend order.What insights can you gather from the data.
select order_id,category,count(item_id) as num_items
from order_details od left join menu_items mi
on od.item_id = mi.menu_item_id
where order_id in (400,2027,1957,330,2675)
group by order_id,category
limit 5;