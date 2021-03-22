# Pre-Requsites
# Assuming Candidates are familiar with “Group by” and “Grouping functions” because these are used along with JOINS in the questionnaire. 

/*Table Definitions:

1. BANK_CUSTOMER - Details of Customers of the Bank
2. BANK_CUSTOMER_EXPORT - Details of Customers of the Bank
3. Bank_Account_Details - Account Details of the customers along with ADD on cards. One customer can have multiple details 
for Savings deposits,Recurring deposits, Credit Cards and Add on credit cards.
4. BANK_ACCOUNT - Account Details of the customers of savings deposits, recurring deposits and Credit card.
5. Bank_Account_Relationship_Details - Details of secondary accounts linked to primary accounts.
6. BANK_ACCOUNT_TRANSACTION - Details of the transactions.
7. BANK_CUSTOMER_MESSAGES - Details of Messages sent to customers after a transaction takes place.
8. BANK_INTEREST_RATE - Current interest rates for savings, RD and other accounts.
9. Bank_Holidays - Details of Bank Holidays.*/


create database InClass;
use inClass;


# Create below DB objects 

CREATE TABLE BANK_CUSTOMER ( customer_id INT ,
             	customer_name VARCHAR(20),
             	Address 	VARCHAR(20),
             	state_code  VARCHAR(3) ,    	 
             	Telephone   VARCHAR(10)	);
INSERT INTO BANK_CUSTOMER VALUES (123001,"Oliver", "225-5, Emeryville", "CA" , "1897614500");
INSERT INTO BANK_CUSTOMER VALUES (123002,"George", "194-6,New brighton","MN" , "1897617000");
INSERT INTO BANK_CUSTOMER VALUES (123003,"Harry", "2909-5,walnut creek","CA" , "1897617866");
INSERT INTO BANK_CUSTOMER VALUES (123004,"Jack", "229-5, Concord",  	"CA" , "1897627999");
INSERT INTO BANK_CUSTOMER VALUES (123005,"Jacob", "325-7, Mission Dist","SFO", "1897637000");
INSERT INTO BANK_CUSTOMER VALUES (123006,"Noah", "275-9, saint-paul" ,  "MN" , "1897613200");
INSERT INTO BANK_CUSTOMER VALUES (123007,"Charlie","125-1,Richfield",   "MN" , "1897617666");
INSERT INTO BANK_CUSTOMER VALUES (123008,"Robin","3005-1,Heathrow", 	"NY" , "1897614000");

CREATE TABLE BANK_CUSTOMER_EXPORT ( customer_id CHAR(10),
customer_name CHAR(20),
Address CHAR(20),
state_code  CHAR(3) ,    	 
Telephone  CHAR(10));
    
INSERT INTO BANK_CUSTOMER_EXPORT VALUES ("123001 ","Oliver", "225-5, Emeryville", "CA" , "1897614500") ;
INSERT INTO BANK_CUSTOMER_EXPORT VALUES ("123002 ","George", "194-6,New brighton","MN" , "189761700");

CREATE TABLE Bank_Account_Details(Customer_id INT,           	 
                             	Account_Number VARCHAR(19),
                              	Account_type VARCHAR(25),
                           	    Balance_amount INT,
                               	Account_status VARCHAR(10),             	 
                               	Relationship_type varchar(1) ) ;
INSERT INTO Bank_Account_Details  VALUES (123001, "4000-1956-3456",  "SAVINGS" , 200000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123001, "5000-1700-3456", "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO Bank_Account_Details  VALUES (123002, "4000-1956-2001",  "SAVINGS", 400000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S");
INSERT INTO Bank_Account_Details  VALUES (123003, "4000-1956-2900",  "SAVINGS" ,750000,"INACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123004, "5000-1700-6091", "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S");
INSERT INTO Bank_Account_Details  VALUES (123004, "4000-1956-3401",  "SAVINGS" , 655000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123005, "4000-1956-5102",  "SAVINGS" , 300000 ,"ACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123006, "4000-1956-5698",  "SAVINGS" , 455000 ,"ACTIVE" ,"P");
INSERT INTO Bank_Account_Details  VALUES (123007, "5000-1700-9800",  "SAVINGS" , 355000 ,"ACTIVE" ,"P");
INSERT INTO Bank_Account_Details  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S");
INSERT INTO Bank_Account_Details  VALUES (123007, "9000-1700-7777-4321",  "Credit Card"	,0  ,"INACTIVE", "P");
INSERT INTO Bank_Account_Details  VALUES (123007, '5900-1900-9877-5543', "Add-on Credit Card" ,   0   ,"ACTIVE", "S");
INSERT INTO Bank_Account_Details  VALUES (123008, "5000-1700-7755",  "SAVINGS"   	,0   	,"INACTIVE","P");
INSERT INTO Bank_Account_Details  VALUES (123006, '5800-1700-9800-7755', "Credit Card"   ,0   	,"ACTIVE", "P");
INSERT INTO Bank_Account_Details  VALUES (123006, '5890-1970-7706-8912', "Add-on Credit Card"   ,0   	,"ACTIVE", "S");

# CREATE Bank_Account Table:
# Create Table
CREATE TABLE BANK_ACCOUNT ( Customer_id INT, 		   			  
	                Account_Number VARCHAR(19),
		     Account_type VARCHAR(25),
		     Balance_amount INT ,
			Account_status VARCHAR(10), Relation_ship varchar(1) ) ;
# Insert records:
INSERT INTO BANK_ACCOUNT  VALUES (123001, "4000-1956-3456",  "SAVINGS"            , 200000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO BANK_ACCOUNT  VALUES (123002, "4000-1956-2001",  "SAVINGS"            , 400000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123003, "4000-1956-2900",  "SAVINGS"            ,750000,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "4000-1956-3401",  "SAVINGS"            , 655000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123005, "4000-1956-5102",  "SAVINGS"            , 300000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123006, "4000-1956-5698",  "SAVINGS"            , 455000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "5000-1700-9800",  "SAVINGS"            , 355000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "9000-1700-7777-4321",  "CREDITCARD"    ,0      ,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123008, "5000-1700-7755",  "SAVINGS"            ,NULL   ,"INACTIVE","P"); 


# CREATE TABLE Bank_Account_Relationship_Details

CREATE TABLE Bank_Account_Relationship_Details
                             	( Customer_id INT,
								Account_Number VARCHAR(19),
                            	Account_type VARCHAR(25),
                             	Linking_Account_Number VARCHAR(19));
INSERT INTO Bank_Account_Relationship_Details  VALUES (123001, "4000-1956-3456",  "SAVINGS" , "");
INSERT INTO Bank_Account_Relationship_Details  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" , "4000-1956-3456");  
INSERT INTO Bank_Account_Relationship_Details  VALUES (123002, "4000-1956-2001",  "SAVINGS" , "" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" , "4000-1956-2001" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123003, "4000-1956-2900",  "SAVINGS" , "" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" , "4000-1956-2900" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123004, "5000-1700-7791",  "RECURRING DEPOSITS" , "4000-1956-2900" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123007, "5000-1700-9800",  "SAVINGS" , "" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , "5000-1700-9800" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, "9000-1700-7777-4321",  "Credit Card" , "5000-1700-9800" );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5900-1900-9877-5543', 'Add-on Credit Card', '9000-1700-7777-4321' );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5800-1700-9800-7755', 'Credit Card', '4000-1956-5698' );
INSERT INTO Bank_Account_Relationship_Details  VALUES (NULL, '5890-1970-7706-8912', 'Add-on Credit Card', '5800-1700-9800-7755' );



# CREATE TABLE BANK_ACCOUNT_TRANSACTION

CREATE TABLE BANK_ACCOUNT_TRANSACTION (  
              	Account_Number VARCHAR(19),
              	Transaction_amount Decimal(18,2) ,
              	Transcation_channel VARCHAR(18) ,
             	Province varchar(3) ,
             	Transaction_Date Date) ;


INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-3456",  -2000, "ATM withdrawl" , "CA", "2020-01-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -4000, "POS-Walmart"   , "MN", "2020-02-14");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -1600, "UPI transfer"  , "MN", "2020-01-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -6000, "Bankers cheque", "CA", "2020-03-23");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  -3000, "Net banking"   , "CA", "2020-04-24");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-2001",  23000, "cheque deposit", "MN", "2020-03-15");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5000-1700-6091",  40000, "ECS transfer"  , "NY", "2020-02-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5000-1700-7791",  40000, "ECS transfer"  , "NY", "2020-02-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-3401",   8000, "Cash Deposit"  , "NY", "2020-01-19");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-5102",  -6500, "ATM withdrawal" , "NY", "2020-03-14");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-5698",  -9000, "Cash Deposit"  , "NY", "2020-03-27");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "4000-1956-9977",  50000, "ECS transfer"  , "NY", "2020-01-16");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -5000, "POS-Walmart", "NY", "2020-02-17");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -8000, "Shopping Cart", "MN", "2020-03-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "9000-1700-7777-4321",  -2500, "Shopping Cart", "MN", "2020-04-21");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( "5800-1700-9800-7755", -9000, "POS-Walmart","MN", "2020-04-13");
INSERT INTO BANK_ACCOUNT_TRANSACTION VALUES ( '5890-1970-7706-8912', -11000, "Shopping Cart" , "NY" , "2020-03-12") ;



# CREATE TABLE BANK_CUSTOMER_MESSAGES

CREATE TABLE BANK_CUSTOMER_MESSAGES (  
              	Event VARCHAR(24),
              	Customer_message VARCHAR(75),
              	Notice_delivery_mode VARCHAR(15)) ;


INSERT INTO BANK_CUSTOMER_MESSAGES VALUES ( "Adhoc", "All Banks are closed due to announcement of National strike", "mobile" ) ;
INSERT INTO BANK_CUSTOMER_MESSAGES VALUES ( "Transaction Limit", "Only limited withdrawals per card are allowed from ATM machines", "mobile" );
INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    10000.00     ,'ECS transfer',     'MN' ,    '2020-02-16' ) ;

-- inserted for queries after 17th  
INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    40000.00     ,'ECS transfer',     'MN' ,    '2020-03-18' ) ;

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    60000.00     ,'ECS transfer',     'MN' ,    '2020-04-18' ) ;

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    20000.00     ,'ECS transfer',     'MN' ,    '2020-03-20' ) ;

-- inserted for queries after 24th 

INSERT INTO `bank_account_transaction`(`Account_Number`, `Transaction_amount`, `Transcation_channel`, `Province`, `Transaction_Date`) VALUES
('4000-1956-9977' ,    49000.00     ,'ECS transfer',     'MN' ,    '2020-06-18' ) ;




# CREATE TABLE BANK_INTEREST_RATE

CREATE TABLE BANK_INTEREST_RATE(  
            	account_type varchar(24),
              	interest_rate decimal(4,2),
            	month varchar(2),
            	year  varchar(4)
             	)	;

INSERT  INTO BANK_INTEREST_RATE VALUES ( "SAVINGS" , 0.04 , '02' , '2020' );
INSERT  INTO BANK_INTEREST_RATE VALUES ( "RECURRING DEPOSITS" , 0.07, '02' , '2020' );
INSERT  INTO BANK_INTEREST_RATE VALUES   ( "PRIVILEGED_INTEREST_RATE" , 0.08 , '02' , '2020' );


# Bank_holidays:
Create table Bank_Holidays (
						 Holiday  date ,
						 Start_time datetime ,
						 End_time timestamp);
						 
						 
Insert into bank_holidays values ( '2020-05-20', now(), now() ) ;

Insert into bank_holidays values( '2020-03-13' , now(), now() ) ;



############################################ Questions ############################################

use inclass;
select * from BANK_ACCOUNT_TRANSACTION;
select * from bank_holidays;
select * from BANK_INTEREST_RATE;
select * from BANK_CUSTOMER_MESSAGES;
select * from Bank_Account_Relationship_Details;
select * from BANK_ACCOUNT;
select * from BANK_CUSTOMER_EXPORT;
select * from bank_customer;

select * from Bank_Account_Details;
# Question 1:
# 1) Print credit card transactions with sum of transaction_amount on all Fridays and sum of transaction_amount on all other days.

select day_in_week,abs(sum(transaction_amount)) as total_transaction_amount from 
(select account_type,transaction_amount,transaction_date,
case when dayname(transaction_date)='Friday' then 'Friday transaction amount'
else 'Otherday transaction amount' end as day_in_week from bank_account_transaction bat 
join bank_account_details bad
on bad.account_number=bat.account_number
where account_type like '%Credit Card%') t group by day_in_week;

Select 	Sum(Case when Dayname(Transaction_date) ='FRIDAY' then abs(transaction_Amount) else 0  END) as 'Friday_transaction',
    Sum(Case when Dayname(Transaction_date) !='FRIDAY' then abs(transaction_Amount)  else 0	END) as  'Other_Day_transaction'
From bank_Account_Details ba
join bank_account_transaction bat
on ba.Account_number=bat.Account_Number
where ba.Account_type LIKE '%CREDIT%';


# Question 2:
# 2) Show the details of credit cards whose aggregate transaction amount during holidays  is greater than other days .   

select 
t.account_number,t.account_type,
sum(if(Status_of_day='Working Day',abs(transaction_amount),0) ) Spending_working_day,
sum(if(Status_of_day='HoliDay',abs(transaction_amount),0) ) Spending_holiday
from 
 (select d.account_number, d.account_type ,bt.transaction_amount,
case when bt.Transaction_Date=bh.Holiday then 'Holiday' else 'Working Day' end as Status_of_day 
from Bank_Account_Details d right join BANK_ACCOUNT_TRANSACTION bt
on d.account_number=bt.account_number
left JOIN bank_holidays bh
ON bt.Transaction_Date=bh.Holiday
where account_type like '%credit%') t
group by t.account_number,t.account_type;

Select 	Sum(Case when Dayname(Transaction_date) ='FRIDAY' then abs(transaction_Amount) else 0  END) as 'Friday_transaction',
    Sum(Case when Dayname(Transaction_date) !='FRIDAY' then abs(transaction_Amount)  else 0	END) as  'Other_Day_transaction'
From bank_Account_Details ba
join bank_account_transaction bat
on ba.Account_number=bat.Account_Number
where ba.Account_type LIKE '%CREDIT%';


# Question 3:
# 3) Generate a report to Send Ad-hoc holiday greetings - “Happy Holiday” for all transactions occurred during Holidays in 4th month.

SELECT 	ba.Account_Number ,
 ba.Account_type,
 bat.Transaction_Date, 
 "Happy Holiday" as message
FROM  	bank_Account_Details ba
JOIN bank_account_transaction bat
ON   ba.Account_Number = bat.Account_Number
JOIN Bank_holidays
On holiday =transaction_Date
where   month(holiday)=3;

# Question 4:
# 4) Calculate the Bank accrued interest with respect to their RECURRING DEPOSITS  for any deposits older than 30 days . 

Select br.account_number,br.Account_type,sum(transaction_Amount*interest_rate)
FROM bank_Account_Details ba
JOIN bank_account_relationship_details br
ON   ba.Account_Number = br.Linking_Account_Number
JOIN bank_interest_rate bir
ON   bir.account_type = br.Account_type
Join bank_account_transaction bat 
ON   br.Account_Number = bat.Account_Number
Where br.Account_type =   'RECURRING DEPOSITS'
group by  br.account_number, br.Account_type
having current_Date()
-min(transaction_Date) >30;


# Note: Accrued interest calculation =  transaction_amount * interest_rate 
-- fields/tables:   interest_rate @bank_interest_rate table 
--                  transaction_amount @bank_account_transaction 
 
 # Pre-requisite Use bank schema tables from Online_Day7_Takehome to solve the queries.

# Question 5:
# 5) Display the Savings Account number whose corresponding Credit cards and  AddonCredit card transactions have occured more than one time .

select a as Saving_Account_Number ,Account_type,Credit_card_number,credit_card_type ,count(Transaction_)
from ( 
select d1.account_number a ,d1.Account_type Account_type ,
d2.account_number Credit_card_number , d2.account_type credit_card_type ,
t1.transaction_amount Transaction_
from Bank_Account_Details d1 
join Bank_Account_Relationship_Details d2
on  d1.account_number=d2.Linking_Account_Number
and d1.account_type='SAVINGS'
join bank_account_transaction t1 
on d2.account_number=t1.account_number
where d2.account_type like '%credit%'
) t
group by a,Account_type,Credit_card_number,credit_card_type
having count(Transaction_)>1;


SELECT	ba.Account_Number as savings_account_number, ba.Account_type  as savings_account_type,
	br.Account_Number as Credit_cardt_account_number, br.Account_type as	CreditCard_account_type, count(bat.transaction_date)  as Count_credit_card_trsanctions
FROM bank_Account_Details ba
LEFT JOIN bank_account_relationship_details br
ON  ba.Account_Number = br.Linking_Account_Number
LEFT JOIN bank_account_transaction bat
ON br.Account_Number = bat.Account_Number
Where br.Account_type like '%Credit%'    
group by ba.Account_Number, ba.Account_type,br.Account_Number, br.Account_type 
having count(bat.transaction_date) > 1;



# Question 6:
# 6) Display the Savings Account number whose corresponding AddonCredit card transactions have occured atleast once. 

select a as Saving_Account_Number ,Account_type,Credit_card_number,credit_card_type ,count(Transaction_)
from ( 
select d1.account_number a ,d1.Account_type Account_type ,
d2.account_number Credit_card_number , d2.account_type credit_card_type ,
t1.transaction_amount Transaction_
from Bank_Account_Details d1 
join Bank_Account_Relationship_Details d2
on  d1.account_number=d2.Linking_Account_Number
join bank_account_transaction t1 
on d2.account_number=t1.account_number
where d2.account_type = 'add-on credit card'
) t
group by a,Account_type,Credit_card_number,credit_card_type
having count(Transaction_)>=1;


SELECT ba.Account_Number as savings_account_number, ba.Account_type as  savings_account_type,
	br.Account_Number as Credit_cardt_account_number, br.Account_type  as 	CreditCard_account_type, count(bat.transaction_date) as Count_credit_card_trsanctions
FROM bank_Account_Details ba
LEFT JOIN  bank_account_relationship_details br
ON  ba.Account_Number = br.Linking_Account_Number
LEFT JOIN  bank_account_transaction bat
ON  br.Account_Number = bat.Account_Number
WHERE  br.Account_type like '%Add-on Credit%'    
group by ba.Account_Number,ba.Account_type  ,br.Account_Number,br.Account_type  
having count(bat.transaction_date) >= 1;



# Question 7:
# 7) Print the customer_id and length of customer_id using Natural join on  Tables :  bank_customer  and  bank_customer_export 
# Note: Do not use table alias to refer to column names.

select customer_id,length(customer_id)
from bank_customer natural join bank_customer_export
group by customer_id;


# Question 8:
# 8) Print customer_id, customer_name and other common columns  from both the Tables :  bank_customer & bank_customer_export without missing any matching customer_id key column records. 
-- Note: refer datatype conversion if found any missing records

select *
from bank_customer natural join bank_customer_export;

Select  distinct bc.customer_id ,  	bce.customer_name
from  bank_customer_export bce 
natural join   bank_customer  bc
where bce.customer_id   = bc.customer_id;