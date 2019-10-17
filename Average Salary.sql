
SELECT B.pay_month, 
       B.department_id,
        CASE 
            WHEN A.avg_salary_paydate > B.dept_avg_pay THEN "lower"
            WHEN A.avg_salary_paydate = B.dept_avg_pay THEN "same"
            ELSE  "High"
        END AS comparison
FROM (
    SELECT MONTH(pay_date) as pay_month, 
           AVG(amount) as avg_salary_paydate
    FROM salary
    GROUP BY pay_date ) as A
JOIN
    ( SELECT MONTH(S.pay_date), 
             E.deartment_id,
             AVG(S.amount) as Dept_avg_pay
    FROM SALARY as S
    LEFT JOIN employee_AS E
    ON S.empployee_id = E.employee_id 
    GROUP BY pay_date, E.department_id ) as B
 on A.pay_month = B.pay_month
 ORDER BY pay_month, department_id 