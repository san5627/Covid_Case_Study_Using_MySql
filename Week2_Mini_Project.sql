##########################
create database Corona;
use Corona;
select * from covid19;
# Format Date1 Column of Covid19 Table in SQL Date format i.e. YYYY-MM-DD 

#Q1 As real time data is downloaded, any missing values in any of the columns should be replaced with 0.
SELECT *
FROM covid19
WHERE date1|state|confirm|cured|death IS NULL; # No rows returned so no missing values

#Q2
#1.	 Government wants to focus on COVID 19 confirmed cases of  top 5 states. 

select state,max(confirm) as Total_Cases
from covid19
group by state
order by Total_Cases desc
limit 5;

/*# 2.	The Health Ministry wants to categorize according to confirm cases in each state.
if confirm cases greater than 300 display as “High Risk”
if confirm cases less than or equal to  50 display as “Low Risk”
else display “No Risk”. */

select state,max(confirm) as Total_Cases,
case 
when max(confirm)>300 then 'High risk'
when (max(confirm)>50 and max(confirm)<=300) then 'Medium risk'
when (max(confirm)<=50 and max(confirm)<=300) then 'Low risk'
else 'No Risk'
end 'Risk_Category'
from covid19
group by state;

#Q3.	The ICMR wants to estimate the confirmed cases for next day state wise. Hint:( Using window functions  )

select state,confirm as Confirmed_Covid_Cases,date1 As_of_date,
lead(confirm,1) over (partition by state order by date1) as Next_Day_Estimated_Covid_Cases
from covid19 where state is not null;

# if you by 'estimate' you mean predict using given latest data then you may consider below query which considers increase of 15% (according to given trend) of covid_cases daily.
SELECT  state,first_VALUE(date1) OVER (PARTITION BY state ORDER BY date1 desc  ) as 'Last_Recorded_Date',confirm as Confirmed_Cases,
adddate(first_VALUE(date1) OVER (PARTITION BY state ORDER BY date1 desc  ),1) as 'Next_Day', round(confirm *1.15) as Next_day_Estimated_Cases
FROM  covid19
where date1='2020-04-26'
union
SELECT  state,first_VALUE(date1) OVER (PARTITION BY state ORDER BY date1 desc  ) as 'Last_Recorded_Date',confirm as Confirmed_Cases,
adddate(first_VALUE(date1) OVER (PARTITION BY state ORDER BY date1 desc  ),6) as 'Next_Day', round(confirm *1.15) as Next_day_Estimated_Cases
FROM  covid19
where state='Nagaland' and date1 like'2020-04-21' ;

#Q4.	 Create a view  named “South_India_Statistics” with details of all southern states.
create view South_India_Statistics as
select * from covid19
where State in('Karnataka','Kerala','Tamil Nadu','Telangana');

/*
Q5.	Design a master details relationship between world(master) and covid19 as details table.

Table name : world 
Attributes/Columns:  country_id   int 
			   country_name varchar(20)
			   continent     varchar(20)

         	   Constraints : country_id ( primary key )
   Insert the following data :      
      insert into world values (1,'India',  'Asia'),(2,'Spain','Europe'),(3,'Italy','Europe');
*/
create table world(country_id int ,country_name varchar(20),continent varchar(20),primary key(country_id));
insert into world values (1,'India','Asia'),(2,'Spain','Europe'),(3,'Italy','Europe');
select * from world;
desc world;

#1.	Covid19 table has a column of country missing. (Add a column country_id  in covid19 and update country_id to 1
ALTER TABLE covid19 ADD country_id int;
ALTER TABLE covid19 ADD PRIMARY KEY (country_id);
update covid19 set country_id=1;
select * from covid19;
desc covid19;

#2.	Add a foreign key from world (country_id)  to covid19( country_id )
ALTER TABLE covid19
ADD FOREIGN KEY (country_id) REFERENCES World(country_id);
desc covid19;

/*
Q6.	Estimate all confirmed cases, cured and how many lives lost  in Asian country of India with States in Karnataka and Kerala. 
*/
select c.country_id,w.country_name,state,max(confirm) Confirmed_Cases,max(cured) Cured_Cases,max(death) Death_Count
from world w join covid19 c using(country_id)
group  by state
having c.state in ('Karnataka','Kerala')
order by max(confirm) desc;

/*
Q7.	A hacker is trying to hack and modify the contents in COVID19 table. Using SQL address the issue.
*/

LOCK TABLE covid19 WRITE;# this will block the table from any unscruplous activities
show processlist;
unlock tables; # use this command to release lock to enable access for hacker to hack the covid19 records :P .

