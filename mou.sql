
2.

CREATE VIEW incentive
AS SELECT DISTINCT salesman_id, name
FROM salesman a
WHERE 3 <=
   (SELECT COUNT (*)
    FROM salesman b
    WHERE a.salesman_id = b.salesman_id);




4.

CREATE VIEW citynum
AS SELECT city, COUNT (DISTINCT salesman_id)
FROM salesman
GROUP BY city;
