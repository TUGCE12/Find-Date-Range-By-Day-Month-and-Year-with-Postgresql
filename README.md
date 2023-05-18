# Find Date Range By Day Month and Year with Postgresql


The principal purpose of the code written in the getDateRange.sql file is to find the difference between 2 dates using PostgreSQL.

If we take a closer look, the meaning of date range here is the difference between the employee's startdate and enddate. If the employee has not left the job and is still in the employee position, the get_date_range function takes today's date as enddate and calculates accordingly.

The importance of this project is that time difference in days/months/years cannot be obtained with ready-made functions. The accuracy of the output results can be doubted if the time difference is taken as only the year, only the month, or only the day. I wrote this script to get rid of these doubts.

You can find the relevant codes in the getDateRange.sql file.
