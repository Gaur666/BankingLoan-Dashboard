--Showing all data
select * from financial_loan

--KPI's
--Total Loan Applications
select count(id) as Total_Applications from financial_loan

--Total Loan Applications Month to Date(December 2021)
select count(id) as MTDTotal_Applications from financial_loan
where month(issue_date)=12 and YEAR(issue_date)=2021

--Total Loan Applications Previous Month to Date
select count(id) as PMTDTotal_Applications from financial_loan
where month(issue_date)=11 and YEAR(issue_date)=2021

--Total Funded Amount
SELECT SUM(loan_amount) as Total_fundedAmt from financial_loan

--Total Funded Amount Month To Date
SELECT SUM(loan_amount) as MTDTotal_fundedAmt from financial_loan
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

--Total Funded Amount Previos Month To Date
SELECT SUM(loan_amount) as PMTDTotal_fundedAmt from financial_loan
where MONTH(issue_date)=11 and YEAR(issue_date)=2021

--Total Amount Recieved 
select SUM(total_payment) as total_amount from financial_loan

--Total Amount Recieved MTD 
select SUM(total_payment) as MTDtotal_amount from financial_loan
where MONTH(issue_date)=12 and YEAR(issue_date)=2021

--Total Amount Recieved PMTD 
select SUM(total_payment) as PMTDtotal_amount from financial_loan
where MONTH(issue_date)=11 and year(issue_date)=2021

--Average Interest Rate
select Round(AVG(int_rate),4)*100 as Avg_Rate from financial_loan

--Average Interest Rate MTD
select Round(AVG(int_rate),4)*100 as MTDAvg_Rate from financial_loan
where month(issue_date)=12 and year(issue_date)=2021

--Average Interest Rate PMTD
select Round(AVG(int_rate),4)*100 as PMTDAvg_Rate from financial_loan
where month(issue_date)=11 and year(issue_date)=2021

--Average debt to income ratio
select AVG(dti) as Avg_DTI from financial_loan

--Average debt to income ratio MTD
select AVG(dti) as MTDAvg_DTI from financial_loan
where month(issue_date)=12 and year(issue_date)=2021

--Average debt to income ratio PMTD
select AVG(dti) as PMTDAvg_DTI from financial_loan
where month(issue_date)=11 and year(issue_date)=2021

--GOOD LOAN APPLICATION  and its %
select count(id) as total_goodLoan_app from financial_loan
where loan_status='Fully Paid' or loan_status='Currnet'
--Applications %
select
(count(CASE when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
/
count(id) as Good_loan_percentage
from financial_loan
--Good Loan Funded Amount
select sum(loan_amount) as total_goodLoan_Amount from financial_loan
where loan_status='Fully Paid' or loan_status='Currnet'
--Good Loan Amount Recieved
select sum(total_payment) as total_goodLoan_Amount_Rcvd from financial_loan
where loan_status='Fully Paid' or loan_status='Currnet'

--BAD LOAN APPLICATION AND ITS %
select count(id) as BadLoan_application from financial_loan
where loan_status='Charged Off'
--%
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan
--BAD Funded Amount
select sum(loan_amount) as BadLoan_FundedAmt from financial_loan
where loan_status='Charged Off'
--BAD loan Recieved Amount
select sum(total_payment) as BadLoan_RecievedAmt from financial_loan
where loan_status='Charged Off'

--LOAN STATUS
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan
    GROUP BY
        loan_status
--LOAN STATUS MTD(month to date) for DECEMBER
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--BANK LOAN REPORT(MONTH)
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--BANK LOAN REPORT(State)
select address_state,
count(id) as Total_applications,
sum(loan_amount) as Total_Amount,
sum(total_payment)as Total_AmtRecieved
from financial_loan
group by address_state
order by count(id) desc

--BANK LOAN REPORT(Term)
select term,
count(id) as Total_applications,
sum(loan_amount) as Total_Amount,
sum(total_payment)as Total_AmtRecieved
from financial_loan
group by term
order by count(id) desc

--BANK LOAN REPORT(Employee Length of applicants)
select emp_length,
count(id) as Total_applications,
sum(loan_amount) as Total_Amount,
sum(total_payment)as Total_AmtRecieved
from financial_loan
group by emp_length
order by count(id) desc


--BANK LOAN REPORT(Loan Purpose)
select purpose,
count(id) as Total_applications,
sum(loan_amount) as Total_Amount,
sum(total_payment)as Total_AmtRecieved
from financial_loan
group by purpose
order by purpose asc

--BANK LOAN REPORT(Home Ownership)
select home_ownership,
count(id) as Total_applications,
sum(loan_amount) as Total_Amount,
sum(total_payment)as Total_AmtRecieved
from financial_loan
--we can use filters(where grade is 'A') and a Bad Loan
where grade='A' and loan_status='Charged Off'
group by home_ownership
order by count(id) desc

