SELECT * FROM shopping_trends;

-- All transaction where the category is not footwear and age is greater than 50
SELECT * FROM shopping_trends
WHERE age > 50 AND Category != 'footwear'
ORDER BY age asc;

-- Total sales for each category
SELECT 
	DISTINCT category,
	SUM(purchase_amount_usd) as total_sales
FROM shopping_trends
GROUP BY category
ORDER BY Category asc;

-- Total sales with dicount or promo code based on category
SELECT 
	DISTINCT category,
	SUM(purchase_amount_usd) as total_sales
FROM shopping_trends
WHERE Discount_Applied = 'Yes' 
		OR 
		Promo_Code_Used = 'Yes'
GROUP BY category
ORDER BY Category asc;

-- Total sales with dicount or promo code 
SELECT 
	SUM(purchase_amount_usd) as total_sales
FROM shopping_trends
WHERE Discount_Applied = 'Yes' 
		OR 
		Promo_Code_Used = 'Yes';

-- Average age of customer who purchase item each product
SELECT
	DISTINCT category,
	AVG(age) as Average_age
FROM shopping_trends
GROUP BY Category;

-- Total sales from each location and number of customer
SELECT 
	DISTINCT location,
	SUM(purchase_amount_usd) as total_sales,
	COUNT (gender) as total_customers
FROM shopping_trends
GROUP BY location
ORDER BY total_sales;

-- Percentage of customer with positive subscription status
SELECT
	(
		SELECT 
			COUNT(gender) 
		FROM shopping_trends 
		WHERE Subscription_Status = 'yes'
	) / CAST(
			COUNT(gender) 
			as decimal(10, 2)
			) * 100
FROM shopping_trends;

-- Number of customer with active subscription
SELECT 
	COUNT (gender) as active_customers
FROM shopping_trends
WHERE Subscription_Status = 'yes';

-- Product popularity by demographic
SELECT TOP 5
	 location,
	 sum (purchase_amount_usd) as Item_Purchased
FROM shopping_trends
GROUP BY location
ORDER BY Item_Purchased asc;


-- Seasonal Sales Index
SELECT 
	season,
	SUM(purchase_amount_usd) as Total_Sales
FROM shopping_trends
GROUP BY season;

--Discount/Promo Effectiveness
SELECT
	Category,
	ROUND(
			(
				SELECT 
					SUM(Purchase_Amount_USD) 
				FROM shopping_trends 
				WHERE 
					Discount_Applied = 'Yes' 
					OR 
					Promo_Code_Used = 'Yes'
			) / SUM (Purchase_Amount_USD) * 100, 
		2) as Promo_Sales
FROM shopping_trends
GROUP BY Category

-- Shipping Type Preference
SELECT 
	Shipping_Type,
	COUNT (Shipping_Type) / CAST(
								(
									SELECT count(Shipping_Type) 
									FROM shopping_trends
								) as decimal(10, 2)
							) * 100 as Precentage_Per_Category
FROM shopping_trends
GROUP BY shipping_type;

-- Percentage of payment method
SELECT 
	DISTINCT preferred_payment_method,
	COUNT (Preferred_Payment_Method) / CAST(
								(
									SELECT count(Preferred_Payment_Method) 
									FROM shopping_trends
								) as decimal(10, 2)
							) * 100 as Precentage
FROM shopping_trends
GROUP BY Preferred_Payment_Method;

-- Top 10 Selling Items
SELECT TOP 10
	item_purchased,
	SUM(purchase_amount_USD) as Total_sales
FROM shopping_trends
GROUP BY item_purchased 
ORDER BY Total_sales desc
