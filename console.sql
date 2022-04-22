create table customer
(
    id         int primary key,
    first_name varchar(100) not null,
    last_name  varchar(100) not null,
    city       varchar(100),
    country    varchar(100),
    phone      varchar(100)
);
create table supplier
(
    id            int primary key,
    company_name  varchar(100) not null,
    contact_name  varchar(100),
    contact_title varchar(100),
    city          varchar(100),
    country       varchar(100),
    phone         varchar(100),
    fax           varchar(100)
);
create table product
(
    id              int primary key,
    product_name    varchar(100)                 not null,
    unit_price      decimal(12, 2) default 0,
    package         varchar(100),
    is_discontinued boolean        default false,
    supplier_id     int references supplier (id) not null
);
create table orders
(
    id           int primary key,
    order_date   timestamp      default now(),
    order_number varchar(100),
    total_amount decimal(12, 2) default 0,
    customer_id  int references customer (id) not null
);
create table order_item
(
    id         int primary key,
    unit_price decimal(12, 2) default 0,
    quantity   int            default 1,
    order_id   int references orders (id)  not null,
    product_id int references product (id) not null
);
select * from supplier;
select * from product;
select * from orders;
select * from order_item;
select * from customer;

select * from customer where country like 'Canada'; --1

select  distinct country from customer; --2

select count(order_date) from orders; --3

select   max(total_amount) from orders; --4

select   sum(total_amount) from orders; --5



select sum(total_amount) from orders where order_date between '2020-01-01' and '2020-12-31';--6 (2014-жыл менде жок болгондуктан 2020 колдондум)

select avg(total_amount) from orders; --7


select round(avg(total_amount)),customer_id from orders
group by customer_id; --8

select * from customer where country = 'Brazil' or country = 'Spain'; --9

select * from orders  where order_date between '2020-01-01' and '2021-12-31' and total_amount < 100.00 ; --10 (2013-2014 жылдар менде жок)


select * from customer where country in ('Spain','German','France','Italy') order by country ; --11

select distinct s.country from customer join supplier s on customer.country = s.country;

 --12 Найти все страны клиентов, страны которых содержаться в таблице поставщиков


select * from customer where first_name like 'Jo%'; --13

select * from customer where first_name like '___a'; --14

select country, count(*) from customer group by country; --15


select country, count(*)  from customer  group by country order by count(country) desc ; --16


select sum(total_amount),count(*),customer_id  from orders
join customer c on c.id = orders.customer_id
group by customer_id order by sum(total_amount); --17



select sum(total_amount), count(*), customer_id,quantity   from orders join order_item oi on orders.id = oi.order_id
where quantity > 20
group by quantity, customer_id; --18


