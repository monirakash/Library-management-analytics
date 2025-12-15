-- 19. Members issuing more than average
WITH member_issues AS (
    SELECT issued_member_id, COUNT(*) AS total
    FROM issued_status
    GROUP BY issued_member_id
)
SELECT m.member_name, mi.total
FROM member_issues mi
JOIN members m ON mi.issued_member_id = m.member_id
WHERE mi.total > (SELECT AVG(total) FROM member_issues);

-- 20. Employees earning above branch average
SELECT emp_name, salary
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE branch_id = e.branch_id
);

-- 21. Rank books by popularity
SELECT issued_book_name,
       COUNT(*) AS total_issues,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS popularity_rank
FROM issued_status
GROUP BY issued_book_name;

-- 22. Running total of issued books
SELECT issued_date,
       COUNT(*) AS daily_issues,
       SUM(COUNT(*)) OVER (ORDER BY issued_date) AS running_total
FROM issued_status
GROUP BY issued_date;

-- 23. Category-wise issue percentage
SELECT category,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS issue_pct
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY category;

-- 24. Books priced above category average
SELECT book_title, rental_price
FROM books b
WHERE rental_price >
      (SELECT AVG(rental_price)
       FROM books
       WHERE category = b.category);


-- 25. Employee contribution percentage
SELECT e.emp_name,
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS contribution_pct
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id
GROUP BY e.emp_name;

-- 26. Member lifetime value
SELECT m.member_name, SUM(b.rental_price) AS lifetime_value
FROM issued_status i
JOIN members m ON i.issued_member_id = m.member_id
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY m.member_name
ORDER BY lifetime_value DESC;

-- 27. Top-performing branch
SELECT b.branch_id, SUM(book.rental_price) AS revenue
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id
JOIN branch b ON e.branch_id = b.branch_id
JOIN books book ON i.issued_book_isbn = book.isbn
GROUP BY b.branch_id
ORDER BY revenue DESC
LIMIT 1;

-- 28. Employees with no issuing activity
SELECT emp_name
FROM employees
WHERE emp_id NOT IN (
    SELECT issued_emp_id FROM issued_status
);

-- 29. Members with no issuing activity
SELECT member_name
FROM members
WHERE member_id NOT IN (
    SELECT issued_member_id FROM issued_status
);

-- 30. Executive KPI snapshot
SELECT
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM members) AS total_members,
    (SELECT COUNT(*) FROM issued_status) AS total_issues,
    (SELECT SUM(rental_price)
     FROM books b
     JOIN issued_status i ON b.isbn = i.issued_book_isbn) AS total_revenue;
