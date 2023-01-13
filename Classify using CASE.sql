CREATE TABLE shipping_status AS
	select shipping_limit_date as limit_date, order_delivered_customer_date as delivered_date,
	CASE
		WHEN shipping_limit_date > order_delivered_customer_date THEN 'ON TIME'
		WHEN shipping_limit_date = order_delivered_customer_date THEN 'ON TIME'
		WHEN shipping_limit_date < order_delivered_customer_date THEN 'DELAYED'
		ELSE 'is null'
	END AS Delivery_Status
	from order_items
	JOIN orders on orders.order_id = order_items.order_id;

SELECT * from shipping_status; 
