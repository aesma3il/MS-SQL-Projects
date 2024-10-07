--SELECT
--    product_name, 
--    brand_name, 
--    list_price
--FROM
--    production.products p
--INNER JOIN production.brands b 
--        ON b.brand_id = p.brand_id;

--drop view sales.product_info
CREATE VIEW sales.product_info
AS
SELECT
    product_name, 
    brand_name, 
    list_price
FROM
    production.products p
INNER JOIN production.brands b 
        ON b.brand_id = p.brand_id
WITH CHECK OPTION;


INSERT INTO sales.product_info(brand_name) 
VALUES ('ABOOD')

SELECT * FROM production.brands

SELECT * FROM sales.product_info



SELECT OBJECT_NAME(object_id) AS ViewName, definition
FROM sys.sql_modules
WHERE object_id = OBJECT_ID('sales.product_info')
AND definition LIKE '%WITH CHECK OPTION%';

SELECT * FROM sys.sql_modules
