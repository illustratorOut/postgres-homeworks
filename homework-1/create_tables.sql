-- SQL-команды для создания таблиц

CREATE TABLE employees(
	employee_id int,
	first_name char(50),
	last_name char(50),
	title text,
	birth_date date,
	notes text
);

CREATE TABLE customers(
	customer_id char(50),
	company_name char(50),
	contact_name char(50)
);

CREATE TABLE orders(
	order_id int,
	customer_id char(50),
	employee_id int,
	order_date date,
	ship_city char(50)
);
