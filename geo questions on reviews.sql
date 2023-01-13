#Find the average review score by state of the customer.
SELECT state, AVG(order_reviews.review_score)
FROM geo
JOIN customers ON customers.customer_zip_code_prefix = geo.zip_code_prefix
JOIN orders ON orders.customer_id = customers.customer_id
JOIN order_reviews ON order_reviews.order_id = orders.order_id
GROUP BY state;

#Do reviews containing positive words have a better score? Some Portuguese positive words are: “bom”, “otimo”, “gostei”, “recomendo” and “excelente”.
SELECT review_comment_message, AVG(review_score)
FROM order_reviews
WHERE review_comment_message IN ('bom', 'otimo', 'gostei', 'recomendo', 'excelente', 'satisfeiro', 'ótimo')
GROUP BY review_comment_message
order by review_score DESC;

#Considering only states having at least 30 reviews containing these words, 
#what is the state with the highest score?
SELECT COUNT(review_id) as total_reviews, AVG(review_score) as score_average, state
FROM order_reviews
JOIN orders ON orders.order_id = order_reviews.order_id
JOIN customers ON customers.customer_id = orders.customer_id
JOIN geo ON geo.zip_code_prefix = customers.customer_zip_code_prefix
GROUP BY state
ORDER BY total_reviews DESC;

#What is the state where there is a greater score change between all reviews and reviews containing positive words?

SELECT FORMAT(STDDEV_SAMP(total_reviews),2), state
FROM (SELECT state, count(*) total_reviews
FROM order_reviews
JOIN orders ON orders.order_id = order_reviews.order_id
JOIN customers ON customers.customer_id = orders.customer_id
JOIN geo ON geo.zip_code_prefix = customers.customer_zip_code_prefix
GROUP BY state
ORDER BY total_reviews DESC) t;

