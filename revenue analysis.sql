-- 11. Total rental revenue
SELECT SUM(b.rental_price) AS total_revenue
FROM issued_status i
JOIN books b ON i.issued_book_isbn = b.isbn;

-- 12. Revenue by category
SELECT b.category, SUM(b.rental_price) AS revenue
FROM issued_status i
JOIN books b ON i.issued_book_isbn = b.isbn
GROUP BY b.category
ORDER BY revenue DESC;

-- 13. Top 5 most issued books
SELECT issued_book_name, COUNT(*) AS issue_count
FROM issued_status
GROUP BY issued_book_name
ORDER BY issue_count DESC
LIMIT 5;

-- 14. Most active members
SELECT m.member_name, COUNT(*) AS total_issues
FROM issued_status i
JOIN members m ON i.issued_member_id = m.member_id
GROUP BY m.member_name
ORDER BY total_issues DESC;

-- 15. Employee productivity
SELECT e.emp_name, COUNT(*) AS books_issued
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id
GROUP BY e.emp_name
ORDER BY books_issued DESC;

-- 16. Average rental price per category
SELECT category, AVG(rental_price) AS avg_price
FROM books
GROUP BY category;

-- 17. Branch-wise revenue
SELECT b.branch_id, SUM(book.rental_price) AS revenue
FROM issued_status i
JOIN employees e ON i.issued_emp_id = e.emp_id
JOIN branch b ON e.branch_id = b.branch_id
JOIN books book ON i.issued_book_isbn = book.isbn
GROUP BY b.branch_id;

-- 18. Monthly issue trend
SELECT DATE_TRUNC('month', issued_date) AS month, COUNT(*) AS issues
FROM issued_status
GROUP BY month
ORDER BY month;
