use bank;
	
Alter table Finance_2 Modify column last_pymnt_d date;

#------------ (1) Year wise loan amount Stats

Select year(issue_d) as issue_years, sum(loan_amnt) as total_amount from finance_1
Group By issue_years
Order By total_amount DESC;

#------------- (2) Grade and sub grade wise revol_bal

SELECT f1.grade, f1.Sub_grade, SUM(f2.revol_bal) as 'Total Revol Bal' FROM finance_1 as f1 JOIN finance_2 as f2 
ON f1.id = f2.id
GROUP BY f1.grade, f1.sub_grade
ORDER BY f1.Sub_grade;

#------------- (3) Total Payment for Verified Status Vs Total Payment for Non Verified Status

Select f1.Verification_status, ROUND(SUM(f2.total_pymnt)) as `Total Payment`FROM finance_1 as f1 JOIN finance_2 as f2 ON f1.id = f2.id
WHERE f1.verification_status IN ('Verified', 'Not Verified')
GROUP BY f1.Verification_status;

#---------------- (4) State wise and month wise loan status

Select addr_state, loan_status, count(loan_status) as No_of_loans from finance_1
group by addr_state, loan_status;

select monthname(f2.last_credit_pull_d) as Pay_Month, count(f1.loan_status) as No_of_Loans from finance_1 as f1 join finance_2 as f2
on f1.id = f2.id
group by pay_month;

#------------------ (5) Home ownership Vs last payment date stats

Select year(f2.last_pymnt_d) as payment_year, monthname(f2.last_pymnt_d) as payment_month, f1.home_ownership, count(f1.home_ownership) as 'total'
from finance_1 as f1 JOIN finance_2 as f2
on f1.id = f2.id
Group by payment_year, payment_month, f1.home_ownership
Order by payment_year DESC;


	








