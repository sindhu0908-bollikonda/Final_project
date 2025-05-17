
-- 1. Data Cleaning – Remove Null or Blank Records
SELECT *
FROM superstore_data
WHERE Order_ID IS NOT NULL
  AND Product_ID IS NOT NULL
  AND Sales IS NOT NULL
  AND Profit IS NOT NULL
  AND Category IS NOT NULL
  AND Region IS NOT NULL;

-- 2. Profit Margin Calculation by Category and Sub-Category
SELECT
  Category,
  Sub_Category,
  SUM(Sales) AS Total_Sales,
  SUM(Profit) AS Total_Profit,
  ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0), 4) AS Profit_Margin
FROM superstore_data
GROUP BY Category, Sub_Category
ORDER BY Profit_Margin ASC;

-- 3. Region-Wise Aggregation of Sales and Profit
SELECT
  Region,
  SUM(Sales) AS Total_Sales,
  SUM(Profit) AS Total_Profit,
  COUNT(DISTINCT Order_ID) AS Total_Orders,
  ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0), 4) AS Profit_Margin
FROM superstore_data
GROUP BY Region
ORDER BY Total_Profit DESC;

-- 4. Identify Profit-Draining Products (Low or Negative Margins)
SELECT
  Product_ID,
  Product_Name,
  Category,
  Sub_Category,
  SUM(Sales) AS Total_Sales,
  SUM(Profit) AS Total_Profit,
  ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0), 4) AS Profit_Margin
FROM superstore_data
GROUP BY Product_ID, Product_Name, Category, Sub_Category
HAVING SUM(Profit) < 0
ORDER BY Profit_Margin ASC;
