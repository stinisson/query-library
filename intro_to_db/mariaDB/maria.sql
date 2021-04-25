-- 1) Skriv en query som hämtar produktnummer, produktnamn, department, kvantitet, pris och
-- radpris(qty*pris) för order 38. Sortera resultatet per department och produktnamn

SELECT productno, name, department, qty, orderrows.price, (qty*orderrows.price) AS row_tot
FROM products INNER JOIN orderrows
ON products.productno = orderrows.product
WHERE order_ = 38
ORDER BY department, name;

-- 2) Skriv en query som räknar ut det totala värdet på order 38
-- 1159.85

SELECT sum(qty*price) AS order_tot FROM orderrows WHERE order_ = 38;

-- 3) Vilken artikel har det sålts flest av och hur många?
--  Lemon Grass, 213, 36168

SELECT name, product, sum(qty) as num_sold
FROM products INNER JOIN orderrows ON products.productno = orderrows.product
GROUP BY product HAVING SUM(qty)  =
    (SELECT SUM(qty) AS tot FROM orderrows GROUP BY product ORDER BY tot DESC LIMIT 1);

SELECT name, product, sum(qty) as tot_sum
FROM products INNER JOIN orderrows
ON products.productno = orderrows.product
group by product order by sum(qty) DESC limit 1;

-- 4) Vilken artikel har sålts näst mest av och hur många?

SELECT name, product, sum(qty) as tot_sum
FROM products INNER JOIN orderrows
ON products.productno = orderrows.product
group by product order by sum(qty) DESC limit 1 OFFSET 1;

SELECT name, product, MAX(sumQty) as num_sold
FROM (SELECT name, product, SUM(qty) AS sumQty FROM orderrows
        INNER JOIN products on orderrows.product = products.productno
        GROUP BY product order by sumQty desc) s
WHERE sumQty NOT IN
      (SELECT MAX(sumQty) FROM (SELECT SUM(qty) AS sumQty FROM orderrows GROUP BY product ) x );

-- 5) Vilken artikel har sålt för mest pengar och hur mycket?

SELECT product, name, SUM(qty*orderrows.price) as tot_sell
FROM products INNER JOIN orderrows
ON products.productno = orderrows.product
GROUP BY product
HAVING tot_sell = (
            SELECT SUM(qty*orderrows.price) as t
            FROM orderrows
            GROUP BY product ORDER BY t DESC LIMIT 1
        );

SELECT product, name, SUM(qty*orderrows.price) AS tot_sell
FROM products INNER JOIN orderrows
ON products.productno = orderrows.product
GROUP BY product ORDER BY tot_sell DESC LIMIT 1;