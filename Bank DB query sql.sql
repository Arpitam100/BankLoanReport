create database Bank_Loan_db
use Bank_Loan_db

select * from bank_loan_data

--total loan applications
select count(id) as Total_Loan_Applications from bank_loan_data

--month to date (MTD) loan application

select count(id) as MTD_Total_Loan_Applications from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

-- previous month to date (PMDT) total loan application

select count(id) as PMTD_Total_Loan_Applications from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

--(MTD-PMTD)/PMTD

--TOTAL LOAN AMOUNT
SELECT SUM(loan_amount) as Total_Funded_Amount from bank_loan_data

--month to date (MTD) loan amount
SELECT SUM(loan_amount) as MTD_Total_Funded_Amount from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--previous month to date (MTD) loan amount

SELECT SUM(loan_amount) as PMTD_Total_Funded_Amount from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

--total amount received from customer
select sum(total_payment) as Total_Amount_Received from bank_loan_data

--Month to Date (MTD) total amount received from customer

select sum(total_payment) as MTD_Total_Amount_Received from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--Previous Month to Date (PMTD) total amount received from customer

select sum(total_payment) as PMTD_Total_Amount_Received from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

--Average Interest Rate
select round(avg(int_rate), 4) * 100 as Avg_Interest_Rate from bank_loan_data

--Month to date (MTD)Average Interest Rate

select round(avg(int_rate), 4) * 100 as MTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--Previous Month to date (MTD)Average Interest Rate

select round(avg(int_rate), 4) * 100 as PMTD_Avg_Interest_Rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

--Average DTI
select round(avg(dti), 4) * 100 as Avg_DTI from bank_loan_data

--Month to date (MTD)Average DTI

select round(avg(dti), 4) * 100 as MTD_Avg_DTI from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

--Previous Month to date (MTD)Average Interest Rate

select round(avg(dti), 4) * 100 as PMTD_Avg_DTI from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021


------------------------Dashboard-1 (Summary)------------------------------------

--good loan & bad loan %

 ---good loan %
select 
	(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end) * 100)
	/
	count(id) as Good_loan_Percentage
from bank_loan_data

---Good loan Applications
select count(id) as Good_loan_Applications from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

---Good loan Funded Amount
select sum(loan_Amount) as Good_loan_Funded_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

---Good loan Received Amount
select sum(total_payment) as Good_loan_Received_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

---Bad loan %
select 
	(count(case when loan_status = 'Charged Off' then id end) * 100.0)
	/
	count(id) as Bad_loan_Percentage
from bank_loan_data

---Bad loan Applications
select count(id) as Bad_loan_Applications from bank_loan_data
where loan_status = 'Charged off'

---Bad loan Funded Amount
select sum(loan_Amount) as Bad_loan_Funded_Amount from bank_loan_data
where loan_status = 'Charged Off'

---Good loan Received Amount
select sum(total_payment) as Bad_loan_Received_Amount from bank_loan_data
where loan_status = 'Charged Off'

--loan status grid view

--loan status
SELECT
        loan_status,
        COUNT(id) AS Loan_Count,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status

---loan status

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

-----------------------------Dashboard-2(Overview)---------------------------------

--Monthly trends by issue date (line chart)

select
	Month(issue_date) as Month_Number,
	datename(month, issue_date) as Month_Name,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by Month(issue_date), datename(month, issue_date)
order by Month(issue_date)

---regional Analysis by state(Filled Map)

select
	address_state,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by address_state
order by sum(loan_amount) desc

---loan term analysis(Donut Chart)

select
	term,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by term
order by term

---employee length analysis (Bar chart)

select
	emp_length,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by emp_length
order by emp_length

---loan purpose breakdown

select
	purpose,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by purpose
order by count(id) desc

---home ownership analysis

select
	home_ownership,
	count(id) as Total_Loan_Applications,
	sum(loan_amount) as Total_Funded_Amount,
	sum(total_payment) as Total_Received_Amount
from bank_loan_data
group by home_ownership
order by count(id) desc

--------------------------------------------------Dashboard-3---------------------------------------------------------------


select * from bank_loan_data





