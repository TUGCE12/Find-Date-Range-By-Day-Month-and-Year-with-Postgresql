CREATE TABLE employees(
firstname varchar(50) not null ,
lastname varchar(50) not null, 
enddate DATE, 
startdate DATE not null,
status varchar(50) not null

);


INSERT INTO employees VALUES ('Tugce','Celik','2021-11-29','2019-07-09', 'employe');
INSERT INTO employees VALUES ('Ayse','Erdem',null,'2012-09-09', 'employe');

SELECT *
FROM public.employees;

CREATE OR REPLACE FUNCTION get_date_ranges()
  RETURNS TABLE(
	  emp_name varchar(50),
	  emp_surname varchar(50),
	  emp_startdate date,
	  emp_enddate date,
	  range_day int,
	  range_month int,
	  range_year int
  )
  AS $$
DECLARE
  var_r record;
  
  end_day int;
  end_month int;
  end_year int;
  start_day int;
  start_month int;
  start_year int;
  
BEGIN
  FOR var_r IN (SELECT firstname, lastname, enddate, startdate,status FROM public.employees)
  LOOP
emp_name := var_r.firstname;
	emp_surname := var_r.lastname;
	emp_startdate := var_r.startdate;
	start_day := DATE_PART('day',var_r.startdate);
	start_month := DATE_PART('month',var_r.startdate);
	start_year := DATE_PART('year',var_r.startdate);
	IF var_r.enddate IS NULL
	THEN
		begin
		emp_enddate := CURRENT_DATE; 
		end_day := DATE_PART('day',CURRENT_DATE);
		end_month := DATE_PART('month',CURRENT_DATE);
		end_year := DATE_PART('year',CURRENT_DATE);
		end;
	ELSE
begin
		emp_enddate := var_r.enddate;
		end_day := DATE_PART('day',var_r.enddate);
		end_month := DATE_PART('month',var_r.enddate);
		end_year := DATE_PART('year',var_r.enddate);
		end;
	END IF;


IF end_day <= start_day
	THEN
		begin
		range_day := end_day +30 - start_day;
		end_month := end_month -1;
		IF end_month <= start_month
		THEN
			begin
			range_month := end_month +12 - start_month;
			end_year := end_year - 1;
			end;
		ELSE
			begin
range_month := end_month - start_month;
			end;
		END IF;
		range_year := end_year - start_year;
		end;
	ELSE
		begin
		range_day := end_day - start_day;
		IF end_month <= start_month
		THEN
			begin
			range_month := end_month +12 - start_month;
			end_year := end_year - 1;
			end;
		ELSE
			begin
range_month := end_month - start_month;
			end;
		END IF;
		range_year := end_year - start_year;
end;
	END IF;
  	RETURN NEXT;
  END LOOP;
END;$$ language 'plpgsql';

SELECT * FROM get_date_ranges();
