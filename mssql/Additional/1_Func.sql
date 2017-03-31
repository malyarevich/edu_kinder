USE Kinder_garden
--13.	Суми оплат вцілому всього закладу за певний проміжок часу
GO 
IF OBJECT_ID (N'dbo.FuncSumOfDateForGarden', N'FN') IS NOT NULL
    DROP FUNCTION dbo.FuncSumOfDateForGarden;
GO
CREATE FUNCTION FuncSumOfDateForGarden(@date_begin DATE, @date_end DATE)
	RETURNS INT AS
		BEGIN
		DECLARE @t INT
		SET @t = (
			SELECT SUM([Сумма за весь период]) AS [Общая сумма садика]
			FROM (SELECT COUNT(Visits_Journal.id_visit)*Sections.cost AS [Сумма за весь период]
			FROM (Sections INNER JOIN Visits_Journal ON Sections.id_section = Visits_Journal.id_section)
				INNER JOIN List_of_section ON Sections.id_section = List_of_section.id_section
			WHERE (YEAR(@date_begin) + MONTH(@date_begin) * 0.01 <= 
					YEAR(Visits_Journal.date_visit) + MONTH(Visits_Journal.date_visit) * 0.01 + DAY(Visits_Journal.date_visit) * 0.0001)
				AND (YEAR(@date_end) + MONTH(@date_end) * 0.01 >= 
					YEAR(Visits_Journal.date_visit) + MONTH(Visits_Journal.date_visit) * 0.01 + DAY(Visits_Journal.date_visit) * 0.0001) 
			GROUP BY Sections.cost, Visits_Journal.id_visit) AS X
			)
		RETURN @t
		END
--
 
GO
USE Kinder_garden
SELECT Kinder_garden.dbo.FuncSumOfDateForGarden('2000-10-01', '2015-11-12') AS [Общая сумма оплат на заведение]
--///--