CREATE OR REPLACE FUNCTION adempiere.JP_NextBusinessDay (p_date timestamp with time zone,p_C_Calendar_ID numeric) RETURNS timestamp with time zone
	LANGUAGE plpgsql
AS $$

DECLARE
	v_nextDate	date := trunc(p_Date);
	v_isHoliday	boolean	:= true;
	nbd adempiere.C_NonBusinessDay%ROWTYPE;
	
begin
	v_isHoliday := true;
	loop
		v_isHoliday := false;

		FOR nbd IN	SELECT *
					FROM C_NonBusinessDay
					WHERE IsActive ='Y' and Date1 >= v_nextDate
						AND C_Calendar_ID = p_C_Calendar_ID
					ORDER BY Date1
		LOOP
			exit when v_nextDate <> trunc(nbd.Date1);
			v_nextDate := v_nextDate + 1;
			v_isHoliday := true;
		end loop;
		exit when v_isHoliday=false;
	end loop;
	--
	return v_nextDate::timestamp with time zone;
end;
$$

