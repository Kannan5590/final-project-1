 # 1 Identify the total number of customers and the churn rat
SELECT COUNT(*)  FROM churn;
SELECT COUNT(*) FROM churn.churn where `Customer Status`="Churned";
SELECT (SELECT COUNT(*) FROM churn.churn WHERE `Customer Status` = 'Churned') * 100.0 / (SELECT COUNT(*) FROM churn) AS churn_rate;

# 2 Find the average age of churned customers
SELECT AVG(Age) AS average_age_of_churned_customers
FROM churn.churn
WHERE `Customer Status` = 'Churned';

# 3 Discover the most common contract types among churned customers
SELECT `Contract`, COUNT(*) AS count
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Contract`
ORDER BY count DESC
LIMIT 1;

# 4 Analyze the distribution of monthly charges among churned customers
SELECT `Monthly Charge`, COUNT(*) AS count
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Monthly Charge`
ORDER BY count DESC
LIMIT 10;

# 5 Create a query to identify the contract types that are most prone to churn
SELECT 
    `Contract`,
    COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM churn.churn
GROUP BY `Contract`
ORDER BY churn_rate DESC;

# 6 Identify customers with high total charges who have churned
SELECT `Customer ID`, `Total Charges`, `Customer Status`
FROM churn.churn
WHERE `Customer Status` = 'Churned' AND `Total Charges` > 7000
ORDER BY `Total Charges` DESC;

# 7 Calculate the total charges distribution for churned and non-churned customers
SELECT 
    `Customer Status`,
    `Contract`,
    COUNT(*) AS customer_count,
    AVG(`Monthly Charge`) AS avg_monthly_charges,
    MAX(`Monthly Charge`) AS max_monthly_charges
FROM churn.churn
GROUP BY `Customer Status`, `Contract`;

# 8 Calculate the average monthly charges for different contract types among churned customers
SELECT 
    `Contract`,
    AVG(`Monthly Charge`) AS avg_monthly_charges
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Contract`;


#9 Identify customers who have both online security and online backup services and have not churned
SELECT
 `Customer ID`, `Online Security`, `Online Backup`, `Customer Status`
FROM churn.churn
WHERE `Customer Status` = 'Churned'
  AND `Online Security` = 'Yes'
  AND `Online Backup` = 'Yes';

# 10 Determine the most common combinations of services among churned customers  
  SELECT 
    `Online Security`, 
    `Online Backup`, 
    `Streaming TV`, 
    `Streaming Movies`, 
FROM churn.churn
WHERE `Customer Status` ='Churned'
GROUP BY `Online Security`, `Online Backup`, `Streaming TV`, `Streaming Movies`
ORDER BY combination_count DESC
LIMIT 1;

# 11 Identify the average total charges for customers grouped by gender and marital status
SELECT 
    `Gender`, 
    `Married`, 
    AVG(`Total Charges`) AS avg_total_charges
FROM churn.churn
GROUP BY `Gender`, `Married`;

# 12 Calculate the average monthly charges for different age groups among churned customers
SELECT 
    CASE 
        WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age >= 60 THEN '60 and above'
    END AS age_group,
    AVG(`Monthly Charge`) AS avg_monthly_charges
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY age_group;

# 13 Determine the average age and total charges for customers with multiple lines and online backup
SELECT 
    AVG(Age) AS avg_age,
    AVG(`Total Charges`) AS avg_total_charges
FROM churn.churn
WHERE `Multiple Lines` = 'Yes'
  AND `Online Backup` = 'Yes';

# 14 Identify the contract types with the highest churn rate among senior citizens (age 65 and over)
SELECT 
    `Contract`,
    COUNT(CASE WHEN `Customer Status` = 'Churned' THEN 1 END) * 100.0 / COUNT(*) AS churn_rate
FROM churn.churn
WHERE Age >= 65
GROUP BY `Contract`
ORDER BY churn_rate DESC;

# 15 Calculate the average monthly charges for customers who have multiple lines and streaming TV
SELECT 
    AVG(`Monthly Charge`) AS avg_monthly_charges,
    `Multiple Lines`,
    `Streaming TV`
   FROM churn.churn
WHERE `Multiple Lines` = 'Yes'
  AND `Streaming TV` = 'Yes';

# 16 Identify the customers who have churned and used the most online services
SELECT 
    `Customer ID`,
    (`Online Security` = 'Yes') + 
    (`Online Backup` = 'Yes') + 
    (`Streaming TV` = 'Yes') + 
    (`Streaming Movies` = 'Yes') AS online_service_count
FROM churn.churn
WHERE `Customer Status` = 'Churned'
ORDER BY online_service_count DESC;

# 17 Calculate the average age and total charges for customers with different combinations of streaming services
SELECT 
    `Streaming TV`, 
    `Streaming Movies`,
    AVG(Age) AS avg_age,
    sum(`Total Charges`) AS Sum_total_charges
FROM churn.churn
GROUP BY `Streaming TV`, `Streaming Movies`;

# 18 Identify the gender distribution among customers who have churned and are on yearly contracts
SELECT 
    `Gender`,
    `contract`
FROM churn.churn
WHERE `Customer Status` ='Churned'
  AND `Contract`='Yearly'
GROUP BY `Gender`;

# 19 Calculate the average monthly charges and total charges for customers who have churned, grouped by contract type and internet service type
SELECT 
    `Contract`, 
    `Internet Service`,
    AVG(`Monthly Charge`) AS avg_monthly_charges,
    AVG(`Total Charges`) AS avg_total_charges
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Contract`, `Internet Service`;

# 20 Find the customers who have churned and are not using online services, and their average total charges
SELECT 
    avg(`Total Charges`) AS avg_total_charges
FROM churn.churn
WHERE `Customer Status` = 'Churned'
  AND `Online Security` = 'No'
  AND `Online Backup` = 'No'
  AND `Streaming TV` = 'No'
  AND `Streaming Movies` = 'No';

# 21 Calculate the average monthly charges and total charges for customers who have churned, grouped by the number of dependents
SELECT 
    `Number of Dependents`, 
    AVG(`Monthly Charge`) AS avg_monthly_charges,
    AVG(`Total Charges`) AS avg_total_charges
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Number of Dependents`;

#22 Identify the customers who have churned, and their contract duration in months (for monthly contracts)

SELECT 
    `Customer ID`, 
    `Contract`
FROM churn.churn
WHERE `Customer Status`='Churned'
AND `Contract` = 'Month to Month';


# 23 Determine the average age and total charges for customers who have churned, grouped by internet service and phone service
SELECT 
    `Internet Service`, 
    `Phone Service`,
    AVG(Age) AS avg_age,
    AVG(`Total Charges`) AS avg_total_charges
FROM churn.churn
WHERE `Customer Status` = 'Churned'
GROUP BY `Internet Service`, `Phone Service`;





