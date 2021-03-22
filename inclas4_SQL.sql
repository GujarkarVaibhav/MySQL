use inclass;
show tables;
select * from BANK_ACCOUNT;
select * from bank_account_details;
select * from Bank_Account_Relationship_Details;
select * from bank_customer;
select * from bank_customer_export;
select * from BANK_ACCOUNT_TRANSACTION;
select * from BANK_CUSTOMER_MESSAGES;
select * from BANK_INTEREST_RATE;
select * from bank_holidays;

# Question 1:
# 1) Print customer Id, customer name and average account_balance maintained by each customer for all 
# of his/her accounts in the bank.
/* Solution */

select b.customer_id,b.customer_name,avg(d.Balance_amount)
from bank_customer b left join bank_account_details d
on b.customer_id=d.customer_id
group by b.customer_id,b.customer_name;


# Question 2:
# 2) Print customer_id , account_number and balance_amount , 
# condition that if balance_amount is nil then assign transaction_amount  for account_type = "Credit Card"
/* Solution */

select distinct b.customer_id,b.account_number,if (b.balance_amount=0 and Account_type="Credit Card",t.Transaction_amount,b.balance_amount) 
as Balance_Amount
from bank_account_details b left join BANK_ACCOUNT_TRANSACTION t
on b.account_number=t.account_number;


# Question 3:
# 3) Print account_number and balance_amount , transaction_amount,Transaction_Date from Bank_Account_Details and 
# bank_account_transaction for all the transactions occurred during march,2020 and april, 2020
/* Solution */

select b.account_number,b.Balance_amount,t.transaction_amount,t.Transaction_Date
from bank_account_details b  join BANK_ACCOUNT_TRANSACTION t
on b.account_number=t.account_number
and (Transaction_Date  between '2020-03-01' and '2020-04-30');


# Question 4:
# 4) Print all of the customer id, account number,  balance_amount, transaction_amount , Transaction_Date 
# from bank_customer, Bank_Account_Details and bank_account_transaction tables where excluding 
# all of their transactions in march, 2020  month
/* Solution */

select d.customer_id, d.account_number,  d.balance_amount, t.transaction_amount , t.Transaction_Date
from Bank_Account_Details d left join bank_account_transaction t
on d.account_number=t.account_number
and date_format(Transaction_Date,'%Y-%m') <> '2020-03';

# Question 5:
# 5) Print only the customer id, account_number, balance_amount,transaction_amount ,transaction_date who did transactions 
# during the first quarter. Do not display the accounts if they have not done any transactions in the first quarter.
/* Solution */

select d.customer_id, d.account_number,  d.balance_amount, t.transaction_amount , t.Transaction_Date
from Bank_Account_Details d join bank_account_transaction t
on d.account_number=t.account_number
and date_format(Transaction_Date,'%Y-%m') between '2020-01' and '2020-03';

# Question 6:
# 6) Print account_number, Event and Customer_message from BANK_CUSTOMER_MESSAGES and Bank_Account_Details to 
# display an “Adhoc" Event for all customers who have  “SAVINGS" account_type account.
/* Solution */

SELECT Account_Number, Event , Customer_message ,ACCOUNT_TYPE
FROM Bank_Account_Details 
CROSS JOIN 
BANK_CUSTOMER_MESSAGES 
ON Event  = "Adhoc"  And ACCOUNT_TYPE = "SAVINGS";

# Question 7:
# 7) Print all Customer_id, Account_Number, Account_type, and display deducted balance_amount by  
# subtracting only negative transaction_amounts for Relationship_type =
#  "P" ( P - means  Primary , S - means Secondary ) .
/* Solution */

select d.Customer_id,d.Account_Number,d.Account_type,(d.balance_amount+t.transaction_amount) deducted_balance_amount
from bank_account_details d left join bank_account_transaction t
on d.account_number=t.account_number
and d.Relationship_type='P'
where t.transaction_amount<0;


# Question 8:
# a) Display records of All Accounts , their Account_types, the transaction amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types

/* Solution */

select d.Account_Number,d.Account_type,d.Linking_Account_Number,t.Account_type
from Bank_Account_Relationship_Details d left join Bank_Account_Relationship_Details t
on d.Linking_Account_Number=t.account_number;

# Question 9:
# a) Display records of All Accounts , their Account_types, the transaction amount.
# b) Along with first step, Display other columns with corresponding linking account number, account types 
# c) After retrieving all records of accounts and their linked accounts, display the  
# transaction amount of accounts appeared  in another column.

/* Solution */

select d.Account_Number,d.Account_type,d.Linking_Account_Number,t.Account_type, bt.Transaction_amount
from Bank_Account_Relationship_Details d left join Bank_Account_Relationship_Details t
on t.Linking_Account_Number=d.account_number
left join bank_account_transaction bt 
on d.account_number=bt.account_number;

select * from BANK_ACCOUNT;
select * from bank_account_details;
select * from Bank_Account_Relationship_Details;
select * from bank_customer;
select * from bank_customer_export;
select * from BANK_ACCOUNT_TRANSACTION;
select * from BANK_CUSTOMER_MESSAGES;
select * from BANK_INTEREST_RATE;
select * from bank_holidays;

# Question 10:
# 10) Display all saving account holders have “Add-on Credit Cards" and “Credit cards"

/* Solution */

SELECT  
br1.Account_Number  primary_account_number ,
br1.Account_type  primary_account_type,
br2.Account_Number secondary_account_number,
br2.Account_type secondary_account_type
from bank_account_relationship_details br1
JOIN bank_account_relationship_details br2
on br1.Account_Number = br2.Linking_Account_Number
and br1.account_type='savings'
and br2.Account_type like '%Credit%' ;



# Question 11:
# 11)  Display  records of “SAVINGS” account linked with “Credit cards" account_type and its credit
# aggregate sum of transaction amount.

# Ref: Check linking relationship in bank_transaction_relationship_details.
        # Check transaction_amount in bank_account_transaction. 

/* Solution */

SELECT  
br1.Account_Number  primary_account_number ,
br1.Account_type  primary_account_type,
br2.Account_Number secondary_account_number,
br2.Account_type secondary_account_type,
sum(t.transaction_amount)
from bank_account_relationship_details br1
JOIN bank_account_relationship_details br2
on br1.Account_Number = br2.Linking_Account_Number
and br1.account_type='savings'
and br2.Account_type = 'Credit card'
join BANK_ACCOUNT_TRANSACTION t
on  br2.Account_Number= t.Account_Number
group by 
br1.Account_Number,
br1.Account_type ,
br2.Account_Number ,
br2.Account_type;

-- here you can not connect on br1.Account_Number= t.Account_Number as br1.account number has done any transaction
-- so everything you fetch depends on data and understsnding of the data.
-- Also the prefixes shoub be used logically.


Select
br1.Account_Number  Primary_account_number,
br1.Account_type	Primary_account_type,
br2.Account_Number  Secondary_account_number,
br2.Account_type	Secondary_account_type,
sum(
bt2.Transaction_amount)  Secondary_account_transaction_amount
FROM bank_account_relationship_details br1
JOIN bank_account_relationship_details br2
ON  br1.Account_Number   = br2.Linking_Account_Number
AND br2.Account_type      = 'Credit Card'    
JOIN bank_account_transaction bt2
on bt2.Account_Number = br2.Account_Number
group by
br1.Account_Number,
br1.Account_type,
br2.Account_Number,
br2.Account_type;



# Question 12:
# 12) Display all type of “Credit cards”  accounts including linked “Add-on Credit Cards" 
# type accounts with their respective aggregate sum of transaction amount.

# Ref: Check linking relationship in bank_transaction_relationship_details.
        # Check transaction_amount in bank_account_transaction. 

/* Solution */

select 
d1.Account_Number  Primary_account_number,
d1.Account_type	Primary_account_type,
d2.Account_Number  Secondary_account_number,
d2.Account_type	Secondary_account_type,
sum(t.Transaction_amount)  Secondary_account_transaction_amount
from Bank_Account_Relationship_Details d1 join Bank_Account_Relationship_Details d2
on d1.Account_Number=d2.Linking_Account_Number
-- and d1.Account_type='credit card'
and d2.Account_type like '%Credit%'
join bank_account_transaction t
on d2.Account_Number=t.Account_Number
group by 
d1.Account_Number,
d1.Account_type,
d2.Account_Number,
d2.Account_type;

# Question 13:
# 13) Display “SAVINGS” accounts and their corresponding aggregate sum of transaction amount 
# of all recurring deposits

/* Solution */
SELECT
br1.Account_Number  Primary_account_number,
br1.Account_type	Primary_account_type,
ba.Balance_amount ,
sum(bt2.Transaction_amount)  recurring_deposit_balance
FROM bank_account_relationship_details br1
JOIN bank_account_relationship_details br2
ON  br1.Account_Number   = br2.Linking_Account_Number
AND br2.Account_type 	like 'RECURRING DEPOSITS'    
JOIN bank_account_transaction bt2
on bt2.Account_Number = br2.Account_Number
JOIN bank_account BA
on ba.Account_Number = br1.Account_Number  
group by
br1.Account_Number,
br1.Account_type  ,
ba.Account_Number ,
ba.Balance_amount;



# Question 14:
# 14) Display recurring deposits and their transaction amounts in  Feb 2020  along with 
# associated SAVINGS account_number , balance.

/* Solution */
SELECT
br1.Account_Number  Primary_account_number,
br1.Account_type	Primary_account_type,
ba.Balance_amount ,
sum(bt2.Transaction_amount)  recurring_deposit_balance,
bt2.Transaction_Date
FROM bank_account_relationship_details br1
JOIN bank_account_relationship_details br2
ON  br1.Account_Number   = br2.Linking_Account_Number
AND br2.Account_type 	like 'RECURRING DEPOSITS'    
JOIN bank_account_transaction bt2
on bt2.Account_Number = br2.Account_Number
And   ( date_format(bt2.Transaction_Date , '%Y-%m') = "2020-02")
JOIN bank_account BA
on ba.Account_Number = br1.Account_Number  
group by
br1.Account_Number,
br1.Account_type  ,
ba.Account_Number ,
ba.Balance_amount,
bt2.Transaction_Date;



# Question 15:
# 15) Compare the aggregate sum transaction amount of current month versus aggregate transaction 
# with previous months.Display account_number, transaction_amount , 
-- sum of current month transaction amount ,
-- current month transaction date , 
-- sum of previous month transaction amount , 
-- previous month transaction date.
 
/* Solution */
SELECT
bt1.account_Number  Primary_account_number,
date_format(bt2.Transaction_Date , '%Y-%m') next_month_transaction_date,
sum(bt2.Transaction_amount) current_month_cr_tran,
sum(bt1.Transaction_amount) prev_month_cr_tran,
date_format(bt1.Transaction_Date , '%Y-%m') previous_month_transaction_date
FROM
bank_account_transaction bt2
JOIN
bank_account_transaction bt1
on bt2.Account_Number = bt1.Account_Number
and date_format(bt2.Transaction_Date , '%Y-%m') > date_format(bt1.Transaction_Date , '%Y-%m')
group by
bt2.account_Number,
date_format(bt2.Transaction_Date , '%Y-%m') ,
date_format(bt1.Transaction_Date , '%Y-%m');


# Question 16:
# 16) Display individual accounts absolute transaction of every next month is greater than the previous months .
 
/* Solution */
SELECT
bt2.account_Number  Primary_account_number,
sum(bt2.Transaction_amount) current_month_tran,
bt2.Transaction_Date CURRENT_tran_date,
sum(bt1.Transaction_amount) prev_month_tran,
bt1.Transaction_Date prev_tran_date
FROM bank_account_transaction bt2
JOIN bank_account_transaction bt1
on bt2.Account_Number = bt1.Account_Number
and bt2.Transaction_Date > bt1.Transaction_Date
group by 
bt2.account_Number,
bt2.Transaction_Date,
bt1.Transaction_Date
HAVING abs(sum(bt2.Transaction_amount)) > abs(sum(bt1.Transaction_amount));


# Question 17:
# 17) Display the customer names who have all three account types - 
# savings, recurring and credit card account holders.
 show tables;
 desc bank_customer;
 desc bank_account;
/* Solution */
SELECT
	customer_name,
	ba.Account_Number savings_account_number,
	ba.Account_type savings_account_type,
	br1.Account_Number Recurring_deposit_account_number,
	br1.Account_type Recurring_deposit_account_type,
	br2.Account_Number credit_card_account_Number,
	br2.Account_type credit_card_account_type
FROM bank_account ba
join bank_customer bc
on ba.customer_id=bc.customer_id
JOIN bank_account_relationship_details br1 ON
	ba.Account_Number = br1.Linking_Account_Number AND(
    	br1.account_type IN('RECURRING DEPOSITS')
	)
JOIN bank_account_relationship_details br2 ON
	ba.account_number = br2.Linking_account_number AND(
    	br2.account_type LIKE '%Credit%'
	);


# Question 18:
# 18) Display savings accounts and its corresponding Recurring deposits transactions are more than 4 times.

/* Solution */
SELECT
	ba.Account_Number savings_account_number,
	ba.Account_type   savings_account_type,
	br.Account_Number recurring_deposit_account_number,
	br.Account_type   recurring_deposit_account_type,
	count(bat.transaction_date) transaction_date
FROM bank_account ba
JOIN bank_account_relationship_details br
ON ba.Account_Number = br.Linking_Account_Number
JOIN bank_account_transaction bat
ON   br.Account_Number = bat.Account_Number
and  br.Account_type   = 'RECURRING DEPOSITS'
group by
	ba.Account_Number,
	ba.Account_type  ,
	br.Account_Number,
	br.Account_type  
having count(bat.transaction_date) > 4;


# Question 19:
# 19) Display savings accounts and its recurring deposits account with their aggregate 
# transactions per month occurs in 3 different months.

/* Solution */
SELECT
	ba.Account_Number savings_account_number,
	ba.Account_type   savings_account_type,
	br.Account_Number recurring_deposit_account_number,
	br.Account_type   recurring_deposit_account_type,
	sum(bat.transaction_amount) Transaction_amount,
	count( DISTINCT date_format(bat.Transaction_Date, '%Y-%m') ) different_transaction_months
FROM bank_account ba
JOIN bank_account_relationship_details br
ON ba.Account_Number = br.Linking_Account_Number
JOIN bank_account_transaction bat
ON   br.Account_Number = bat.Account_Number
and  br.Account_type   = 'RECURRING DEPOSITS'
group by
	ba.Account_Number,
	ba.Account_type  ,
	br.Account_Number,
	br.Account_type  
having count(DISTINCT date_format(bat.Transaction_Date, '%Y-%m') )  >= 3;



# Question 20:
# 20) Find the no. of transactions of credit cards including add-on Credit Cards

/* Solution */
SELECT
	br1.Account_Number credit_card_account_number,
	br1.Account_type   credit_card_account_type,
	count(bat.transaction_amount) count_of_Transaction_amount
FROM
 	bank_account_relationship_details br1
LEFT JOIN
 	bank_account_relationship_details br2
ON br1.Account_Number     = br2.Linking_Account_Number
JOIN bank_account_transaction bat
ON   br1.Account_Number = bat.Account_Number
and  br1.Account_type   like '%Credit%'
group by
	br1.Account_Number,
	br1.Account_type;
