USE Kinder_garden
--Запрещаем вставлять запись в Teacher_of_section, на текущий месяц и год на секции уже закреплен учитель

IF OBJECT_ID('TRG_DenyInsDupOfSectOnMonthYear') IS NOT NULL
DROP TRIGGER TRG_DenyInsDupOfSectOnMonthYear
GO
CREATE TRIGGER TRG_DenyInsDupOfSectOnMonthYear
ON Teacher_Of_section
AFTER INSERT AS
	BEGIN
		SET NOCOUNT ON;
		----------------------------------------------
	IF (EXISTS(SELECT Teacher_Of_section.month_sect,Teacher_Of_section.year_sect, Teacher_Of_section.id_section 
				FROM Kinder_garden.dbo.Teacher_Of_section
				WHERE (Teacher_Of_section.month_sect = (SELECT month_sect FROM INSERTED)
					AND Teacher_Of_section.year_sect = (SELECT year_sect FROM INSERTED)
					AND Teacher_Of_section.id_section = (SELECT id_section FROM INSERTED)
					)
			))

		BEGIN
			ROLLBACK
			PRINT'Вы не можете добавить преподавателя на данный месяц в данную секцию, так как на эту секцию уже закреплен преподаватель.'
		END
	ELSE
		BEGIN
			PRINT'Запись добавлена.'
		END
	END
GO
USE Kinder_garden

INSERT INTO Teacher_of_section(id_section, id_employee, month_sect, year_sect) VALUES
	(2, 3, 3, 2013)
GO
SELECT * from Teacher_of_section
ORDER BY year_sect, month_sect, id_section
GO


--Создаем резервную копию всех вставок в таблицу Работников
USE Kinder_garden
IF OBJECT_ID('TRG_InsertSyncEmp') IS NOT NULL
DROP TRIGGER TRG_InsertSyncEmp
GO

CREATE TRIGGER TRG_InsertSyncEmp 
ON Kinder_garden.dbo.Employee
AFTER INSERT AS
	BEGIN
		INSERT INTO Kinder_garden.dbo.Employee_BackUp(surname, first_name, last_name, birthday, home_address, telephone, id_med_record)
		SELECT surname, first_name, last_name, birthday, home_address, telephone, id_med_record 
		FROM INSERTED
	END
GO

INSERT INTO Employee (surname, first_name, last_name, birthday, home_address, telephone, id_med_record) VALUES 
('Grinko', 'Alex', 'Rigorioch', '2012-10-22 00:00:00', 'st. Pobedi, 34, 22', 380987415623, null) 


SELECT * from Employee
SELECT * from Employee_BackUp 
GO