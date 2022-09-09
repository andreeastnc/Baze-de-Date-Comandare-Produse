-- 1. Selecteaza numarul de comenzi ale fiecarui client, sortate in functie de id-ul clientului
SELECT "client_id", COUNT("order_id")
FROM orders_ast
GROUP BY "client_id"
ORDER BY "client_id";

-- 2. Selecteaza comenzile cu valoare mai mare decat 100 al caror id al produselor este intre 1 si 3
SELECT "order_id", COUNT("product_id") product_count, SUM("price") total_price
FROM order_details_ast
GROUP BY "order_id"
HAVING COUNT("product_id") BETWEEN 1 AND 3 AND SUM("price") > 100
ORDER BY total_price DESC, product_count DESC;

-- 3. Selecteaza angajatii care au numele de familie Cristea
SELECT "first_name", "last_name" 
FROM employees_ast
WHERE LOWER("last_name") = 'cristea';

-- 4. Selecteaza angajatii si afiseaza numarul lor grupati dupa primele doua litere prenumelui
SELECT SUBSTR("first_name", 1, 2) first_two_letters, COUNT(*) 
FROM employees_ast
GROUP BY SUBSTR("first_name", 1, 2)
ORDER BY first_two_letters;

-- 5. Returneaza statusul comenzii si id-ul comenzii asignate fiecarui angajat (angajatii se ocupa de livrari)
SELECT "order_id", "order_status", "first_name", "last_name"
FROM orders_ast o
LEFT JOIN employees_ast e
ON e."employee_id" = o."employee_id";

-- 6. Afiseaza angajatii cu seful mentionat
SELECT "employee_id", COALESCE(TO_CHAR(NULLIF("manager_id","employee_id")), 'His own boss') boss
FROM employees_ast;

-- 7. Afiseaza ierarhia managerului Cristea
SELECT LEVEL, "employee_id", "last_name", "manager_id"
FROM employees_ast
START WITH "employee_id" = (SELECT "employee_id" FROM employees_ast WHERE UPPER("last_name")
LIKE 'CRISTEA')
CONNECT BY PRIOR  "employee_id" = "manager_id";

-- 8. Categoria de produse a carui cel mai mic pret de produs este mai mare de 50
SELECT "type_name", MIN("price") pret_peste_50_lei
FROM products_ast
INNER JOIN types_ast USING("type_id")
GROUP BY "type_name"
HAVING MIN("price") > 50
ORDER BY "type_name";

-- 9. Subinterogarea intoarce media preturilor dupa categoria de produs
-- iar interogarea returneaza media mediilor subinterogarii
SELECT ROUND(AVG(avg_price), 2) avg_of_avg
FROM(SELECT AVG("price") avg_price
    FROM products_ast
    GROUP BY "type_id"
);

-- 10. Selecteaza categoria de produse si pretul pentru cele mai scumpe produse per fiecare categorie
-- Returneaza doar produsul al carui cel mai mare pret este intre 50 si 100 
SELECT "type_name", MAX("price")
FROM products_ast
INNER JOIN types_ast
USING("type_id")
GROUP BY "type_name"
HAVING MAX("price") BETWEEN 50 AND 100
ORDER BY "type_name";

-- 11. Angajatii care nu participa la livrari si nu sunt manageri
SELECT "first_name", "last_name"
FROM employees_ast e
FULL OUTER JOIN orders_ast o ON e."employee_id" = o."employee_id"
WHERE "manager_id" IS NULL
ORDER BY "first_name", "last_name";
                    
-- 12. Selecteaza toti angajatii si vanzarile lor
SELECT DISTINCT "first_name", "last_name", "order_id", "order_status"
FROM orders_ast o
RIGHT JOIN employees_ast e ON e."employee_id" = o."employee_id"
ORDER BY "first_name", "last_name";

-- 13. Selecteaza produsele care au pretul mai mare decat media aritmetica a preturilor
-- tuturor produselor
SELECT "product_id", "product_name", "price"
FROM products_ast
WHERE "price" > (SELECT AVG("price")
                FROM products_ast)
ORDER BY "price";

-- 14. Selecteaza codul magazinului, numele magazinului si numarul de angajati care lucreaza
-- in acel magazin pentru magazinul cu numar maxim de angajati
SELECT "shop_id", "shop_name", COUNT("employee_id") numar_angajati
FROM employees_ast
JOIN shops_ast USING("shop_id")
GROUP BY "shop_id", "shop_name"
HAVING COUNT("employee_id") = (SELECT MAX(COUNT("employee_id"))
                             FROM employees_ast
                             GROUP BY "shop_id");



-- 15. Selecteaza produsul, pretul total pentru produsul respectiv pe tipuri si pretul total pentru produsul
-- respectiv pe tipurile 1 si 2
SELECT p."product_id" "Product",  (SELECT SUM("price") 
                        FROM products_ast 
                        WHERE "type_id" = 1 AND p."product_id" = "product_id") "Tip 1",
                        (SELECT SUM("price")
                        FROM products_ast
                        WHERE "type_id" = 2 AND p."product_id" = "product_id") "Tip 2",
                        SUM("price") "Total"
FROM products_ast p
GROUP BY p."product_id";

-- 16. Numele angajatilor care au lucrat in cel putin aceleasi magazine ca si angajatul cu coudl 6
SELECT "employee_id", "first_name", "last_name"
FROM employees_ast e
WHERE e."employee_id" >= 6 AND NOT EXISTS (SELECT 1
                    FROM shops_ast s
                    WHERE "employee_id" = 6
                    AND NOT EXISTS (SELECT 1
                            FROM shops_ast 
                            WHERE "employee_id" = e."employee_id" AND "shop_id" = s."shop_id"))
ORDER BY "employee_id";