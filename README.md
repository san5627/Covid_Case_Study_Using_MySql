# Covid-19-Case-Study-Using-MySQL

# SQL Project on Covid 19 in India State wise 

Context
This dataset provides a data of COVID-19 reported cases including cured and death information of states of India.

Content
The data is in CSV format and has 5 columns.

Date: Date in DD-MM-YYYY format
State: Name if the state
Confirm: Total number of confirmed cases as on Date
Cured: Total number of cured, discharged or migrated cases as on Date
Death: Total number of deaths as on Date

All figures are cumulative.
Acknowledgements  
This dataset is created and maintained using the data available in public domain.


1) As real time data is downloaded, any missing values in any of the columns should be replaced with 0.

2) Solved the following queries :

1.	 Government wants to focus on COVID 19 confirmed cases of  top 5 states. 

2.	The Health Ministry wants to categorize according to confirm cases in each state.
if confirm cases greater than 300 display as “High Risk”
if confirm cases less than or equal to  50 display as “Low Risk”
else display “No Risk”.

3.	The ICMR wants to estimate the confirmed cases for next day state wise.
Hint:( Using window functions )

 
4.	Create a view  named “South_India_Statistics” with details of all southern states.

5.	Design a master details relationship between world(master) and covid19 as details table.

Table name : world 
Attributes/Columns:  country_id   int 
			   country_name varchar(20)
			   continent     varchar(20)

         	   Constraints : country_id ( primary key )
   Insert the following data :      
      insert into world values (1,'India',  'Asia'),(2,'Spain','Europe'),(3,'Italy','Europe');


1.	Covid19 table has a column of country missing. (Add a column country_id  in covid19 and update country_id to 1)

2.	Add a foreign key from world (country_id)  to covid19( country_id )
    
3.	Estimate all confirmed cases, cured and how many lives lost  in Asian country of India with States in Karnataka and Kerala. 

4.	A hacker is trying to hack and modify the contents  in COVID19 table. Using SQL address the issue.
