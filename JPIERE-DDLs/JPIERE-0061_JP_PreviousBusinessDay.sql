CREATE OR REPLACE FUNCTION adempiere.JP_PreviousBusinessDay (p_date timestamp with time zone, p_C_Calendar_ID numeric) RETURNS timestamp with time zone
	LANGUAGE plpgsql
AS $$

DECLARE
	v_prevDate	date := trunc(p_Date);
	v_isHoliday	boolean	:= true;
	nbd adempiere.C_NonBusinessDay%ROWTYPE;
	
begin
	v_isHoliday := true;
	loop

		v_isHoliday := false;

		FOR nbd IN	SELECT *
					FROM C_NonBusinessDay
					WHERE IsActive ='Y' and Date1 <= v_prevDate
						AND C_Calendar_ID = p_C_Calendar_ID
					ORDER BY Date1 desc
		LOOP
			exit when v_prevDate <> trunc(nbd.Date1);
			v_prevDate := v_prevDate - 1;
			v_isHoliday := true;
		end loop;
		exit when v_isHoliday=false;
	end loop;
	--
	return v_prevDate::timestamp with time zone;
end;
$$

