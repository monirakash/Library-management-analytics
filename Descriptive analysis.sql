----  Q1. Total number of books
SELECT COUNT(*) AS total_books FROM books;

-----Q2. Total number of members
SELECT COUNT(*) AS total_members FROM members;

---- Q3. Total issued transactions
SELECT COUNT(*) AS total_issues FROM issued_status;

---- Q4. Find employees with branch address---
SELECT e.emp_id, e.emp_name, b.branch_address
FROM employees e
JOIN branch b ON e.branch_id = b.branch_id;

-- Q5. show employees per branch----
SELECT branch_id, COUNT(*) AS total_employees
FROM employees
GROUP BY branch_id;

-- Q6. books by category
SELECT category, COUNT(*) AS book_count
FROM books
GROUP BY category
ORDER BY book_count DESC;

-- Q7. Currently unavailable books--
SELECT book_title
FROM books
WHERE status = 'No';

-- Q8. Members who issued at least one book---
SELECT DISTINCT m.member_name
FROM issued_status i
JOIN members m ON i.issued_member_id = m.member_id;

-- Q9. Employees who issued books
SELECT DISTINCT e.emp_name
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id;

-- Q10. Books never issued
SELECT book_title
FROM books
WHERE isbn NOT IN (
    SELECT issued_book_isbn FROM issued_status
);
