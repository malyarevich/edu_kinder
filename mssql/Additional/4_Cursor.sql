USE Kinder_garden
-----------------------------------------------
--курсор для вывода списка детей которые ходят на кружки.

DECLARE	@SFL			VARCHAR(250),
		@amountSections INT,
		@message		VARCHAR(250)
PRINT ' Список детей:'
DECLARE CRS_ChildOnSections CURSOR LOCAL FOR
    SELECT (Child.surname + ' ' + Child.first_name + ' ' + Child.last_name) AS [ФИО], COUNT(List_of_section.id_child) AS [Кол-во секций]
    FROM Child INNER JOIN List_of_section ON Child.id_child = List_of_section.id_child
    GROUP BY Child.surname, Child.first_name, Child.last_name
	ORDER BY [ФИО]ASC, [Кол-во секций] ASC

OPEN CRS_ChildOnSections
FETCH NEXT FROM CRS_ChildOnSections INTO @SFL, @amountSections
WHILE @@FETCH_STATUS=0
BEGIN
    /*SELECT @message = 'Ребенок '+ @SFL +
                    ' Кол-во '+ @amountSections*/
    PRINT ('Ребенок - '+ @SFL + CHAR(13) + SPACE(3) + 'кол-во посещаемых секций '+ CONVERT(VARCHAR(250), @amountSections))

    FETCH NEXT FROM CRS_ChildOnSections 
      INTO @SFL, @amountSections
END
CLOSE CRS_ChildOnSections
DEALLOCATE CRS_ChildOnSections
-------------------------------------

--EXPLICIT
-- TBL_temp
USE Kinder_garden
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'TBL_temp') AND type in (N'U'))
DROP TABLE TBL_temp
GO--1
CREATE TABLE TBL_temp
(
	id_tmp INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	id_child INT NOT NULL,--Child.id_child%TYPE NOT NULL,
	surname VARCHAR(250) NOT NULL,
	first_name VARCHAR(250) NOT NULL,
	last_name VARCHAR(250) NOT NULL
)--tmp-1
GO
--

--1--non-parametric
--Childs that does not attend sections.
USE Kinder_garden
DECLARE @Chld_id INT
DECLARE @Chld_surname VARCHAR(250)
DECLARE @Chld_firstName VARCHAR(250)
DECLARE @Chld_lastName VARCHAR(250)
DECLARE @Chld_birthday DATE
DECLARE @Chld_homeAddress VARCHAR(250)
DECLARE @Chld_idGroup INT
DECLARE @Chld_idTypeRel INT

DECLARE @CRS_getChilds CURSOR
	SET @CRS_getChilds = CURSOR FOR
		SELECT * FROM Child
	OPEN @CRS_getChilds
	FETCH NEXT FROM @CRS_getChilds INTO @Chld_id, @Chld_surname, @Chld_firstName, @Chld_lastName,
		@Chld_birthday, @Chld_homeAddress, @Chld_idGroup, @Chld_idTypeRel--%ROWTYPE
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS(SELECT id_child 
			FROM List_of_section
			WHERE List_of_section.id_child=@Chld_id)
		BEGIN
			INSERT INTO TBL_temp (id_child, surname, first_name, last_name) 
				VALUES(@Chld_id, @Chld_surname, @Chld_firstName, @Chld_lastName)
		END
		FETCH NEXT FROM @CRS_getChilds INTO @Chld_id, @Chld_surname, @Chld_firstName, @Chld_lastName,
		@Chld_birthday, @Chld_homeAddress, @Chld_idGroup, @Chld_idTypeRel--%ROWTYPE
	END
	CLOSE @CRS_getChilds

	--
GO
SELECT * FROM TBL_temp
GO
TRUNCATE TABLE TBL_temp
GO
DEALLOCATE @CRS_getChilds

--2--parametric.
--Is This Child that attend sections.
USE Kinder_garden
DECLARE @Chld_id INT
DECLARE @Chld_surname VARCHAR(250)
DECLARE @Chld_firstName VARCHAR(250)
DECLARE @Chld_lastName VARCHAR(250)
DECLARE @Sctn_title VARCHAR(250)

--parametric-without-procedure
DECLARE @Need_idChild INT
SET @Need_idChild = 1

DECLARE @CRS_isChildAttendSections CURSOR
	SET @CRS_isChildAttendSections = CURSOR FOR
		SELECT DISTINCT Child.id_child, Child.surname, Child.first_name, Child.last_name, Sections.name_of_section
		FROM (Child INNER JOIN List_of_section ON Child.id_child = List_of_section.id_child)
			INNER JOIN Sections ON List_of_section.id_section = Sections.id_section
		WHERE Child.id_child = @Need_idChild
	OPEN @CRS_isChildAttendSections
	FETCH NEXT FROM @CRS_isChildAttendSections INTO @Chld_id, @Chld_surname, @Chld_firstName, @Chld_lastName, @Sctn_title--%ROWTYPE
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT (@Chld_surname + SPACE(1) + @Chld_firstName + SPACE(1) + @Chld_lastName + ' attend - ' + @Sctn_title + '.')  
	FETCH NEXT FROM @CRS_isChildAttendSections INTO @Chld_id, @Chld_surname, @Chld_firstName, @Chld_lastName, @Sctn_title--%ROWTYPE
	END
	CLOSE @CRS_isChildAttendSections

	--
GO
DEALLOCATE @CRS_isChildAttendSections