-- FUNCTION: public.sp_numerospares(integer, integer)

-- DROP FUNCTION IF EXISTS public.sp_numerospares(integer, integer);

CREATE OR REPLACE FUNCTION public.sp_numerospares(
	x integer,
	y integer,
	OUT res double precision)
    RETURNS double precision
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
res := 0;
FOR i in x..y LOOP
	IF (i % 2 = 0) THEN
		res := res + i;
	END IF;
-- 	x := x + 1;
END LOOP;
END;
$BODY$;

SELECT * FROM sp_numerospares(0,100); -- testando a função. Retorna 2550.

ALTER FUNCTION public.sp_numerospares(integer, integer)
    OWNER TO postgres;