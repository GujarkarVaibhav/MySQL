-- --------------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.
-- --------------------------------------------------------
use bank;
desc cricket_1;
desc cricket_2;
select * from cricket_1;
select * from cricket_2;
# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.
 
 select c1.Player_Name from cricket_1 c1 join cricket_2 c2
 on c1.Player_id=c2.Player_id;
 
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  scored runs more than 50

select player_id,runs,player_name from cricket_1 where runs>50;

# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.

select * from cricket_1 where player_name like 'y%v';

# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.
 
 select * from cricket_1 where player_name not like '%t';
 
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------
select * from cric_combined;

# Q5. Write a MySQL query to create a new column PC_Ratio that contains the divsion ratio 
# of popularity to charisma .(Hint :- Popularity divide by Charisma)

alter table cric_combined
add column PC_Ratio int;
alter table cric_combined
modify PC_Ratio float;
insert into cric_combined (PC_Ratio)
values(Popularity/Charisma);
delete from cric_combined
where Player_Id is null;
update cric_combined
set PC_Ratio=Popularity/Charisma;

# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.

select Player_Name,PC_Ratio from cric_combined
order by PC_Ratio desc limit 5;

# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.

select player_id,player_name from cric_combined 
where player_name like '%d%';

# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.

select player_id,PC_Ratio from cric_combined
where PC_Ratio between 0.12 and 0.25;

-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
select * from new_cricket;

# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
 
 select player_id,player_name from new_cricket
 where Charisma is null;
 
# Q10. Write a MySQL query to display all the NULL values imputed with 0.
 
select replace(charisma,null,'0') from new_cricket; 
SELECT IFNULL(Charisma, 0) FROM new_cricket;

# Q11. Separate all Player_Id into single numeric ids (example PL1 =  1).
 
 select Player_Id, substr(Player_Id,3) New_id from new_cricket;
 
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.

 select player_id,player_name, Charisma from new_cricket
 where Charisma >25;

-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------

select * from churn1;

# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
# for those paymentmethod is through Electronic check mode.

select floor(MonthlyServiceCharges) Rounded_MSCharges,ceil(TotalAmount) Total_Amount_Rounded
from churn1 where PaymentMethod = 'Electronic check';

# Q14. Rename the table churn1 to “Churn_Details”.

rename table churn1 to Churn_Details;


# Q15. Write a query to create a new column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.

alter table Churn_Details
add column new_Amount double;

update Churn_Details
set new_Amount=TotalAmount+MonthlyServiceCharges;

select * from Churn_Details;

# Q16. Rename column new_Amount to Amount.

alter table Churn_Details
rename column new_Amount to Amount;

# Q17. Drop the column “Amount” from the table “Churn_Details”.

alter table Churn_Details
drop Amount;

# Q18. Write a query to extract the customerID, InternetConnection and gender 
# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
# at the second position.

select customerID,InternetConnection,gender from Churn_Details
where InternetConnection like '_i%';

# Q19. Find the records where the tenure is 6x, where x is any number.

select * from Churn_Details
where tenure%6=0;

# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.

select upper(Player_Name) U_Player_Name,ifnull(Charisma,0) from cric_combined
order by Player_Name;