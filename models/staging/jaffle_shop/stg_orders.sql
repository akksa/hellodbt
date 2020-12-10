with orders as (
    select ID as order_id, user_id as customer_id, order_date, status from dbt.jaffle_shop_orders
)
select * from orders