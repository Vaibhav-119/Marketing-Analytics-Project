-- SQL Query to categorize products based on their price
SELECT 
    ProductID,
    ProductName,
    Price,
    CASE
        WHEN Price < 50 THEN 'Low'
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'High'
    END AS PriceCategory
FROM
    products;
   
-- SQL statement to join dim_customers with dim_geography to enrich customer data with geographic information
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Email,
    c.Gender,
    c.Age,
    g.Country,
    g.City
FROM
    customers c
        LEFT JOIN
    geography g ON c.GeographyID = g.GeographyID;  -- Joins the two tables on the GeographyID field to match customers with their geographic information

-- Query to clean whitespace issues in the ReviewText column
SELECT 
    ReviewID,
    CustomerID,
    ProductID,
    ReviewDate,
    Rating,
    REPLACE(ReviewText, '  ', ' ') AS ReviewText
FROM
    customer_reviews;

-- Query to clean and normalize the engagement_data table
SELECT 
    EngagementID,  
    ContentID,  
	CampaignID,  
    ProductID,  
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  -- Replaces "Socialmedia" with "Social Media" and then converts all ContentType values to uppercase
	-- Views
	SUBSTRING_INDEX(ViewsClicksCombined, '-', 1) AS Views,
	SUBSTRING_INDEX(ViewsClicksCombined, '-', -1) AS Clicks,
    Likes,  -- Selects the number of likes the content received
    -- Converts the EngagementDate to the dd.mm.yyyy format
    DATE_FORMAT(STR_TO_DATE(EngagementDate, '%Y-%m-%d'), '%d.%m.%Y') AS EngagementDate  -- Converts and formats the date as dd.mm.yyyy
FROM 
     engagement_data  -- Specifies the source table from which to select the data
WHERE 
    ContentType != 'Newsletter';  -- Filters out rows where ContentType is 'Newsletter' as these are not relevant for our analysis
    
