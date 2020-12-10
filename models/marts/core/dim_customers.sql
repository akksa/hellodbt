{{ config (materialized="table")}}

with customers as (

	select * from {{ ref('stg_customers') }}
),

orders as (

	select * from {{ ref('fct_orders') }}
),
customer_orders as (
	select customer_id, max(order_date) as most_recent_order_date, min(order_date) as first_order_date, count(order_id) as number_of_orders, sum(amount) as lifetime_value from orders group by 1
),
final as (
	select customer_id, first_name, last_name, most_recent_order_date, first_order_date, coalesce(number_of_orders, 0) as number_of_orders, coalesce(lifetime_value,0) as lifetime_value from customers left join customer_orders using (customer_id)
)

select * from final
