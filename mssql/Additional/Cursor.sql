USE Kinder_garden
-- создадим процедуру, которая будет выбирать данные из одной таблицы, 
-- перебирать их в курсоре анализируя, есть ли такие данные во второй таблице
-- и вставлять в третью таблицу, если данные записи удовлетворяют определённым критериям.
CREATE PROCEDURE [dbo].[MyProcedure] AS

DECLARE @ID INT
DECLARE @QUA INT
DECLARE @VAL VARCHAR (500)
DECLARE @NAM VARCHAR (500)
/*Объявляем курсор*/
DECLARE @CURSOR CURSOR
/*Заполняем курсор*/
SET @CURSOR  = CURSOR SCROLL
FOR
SELECT  INDEX, QUANTITY, VALUE,  NAME  
  FROM  My_First_Table WHERE  QUANTITY > 1
/*Открываем курсор*/
OPEN @CURSOR
/*Выбираем первую строку*/
FETCH NEXT FROM @CURSOR INTO @ID, @QUA, @VAL, @NAM
/*Выполняем в цикле перебор строк*/
WHILE @@FETCH_STATUS = 0
BEGIN

        IF NOT EXISTS(SELECT VAL FROM My_Second_Table WHERE ID=@ID)
        BEGIN
/*Вставляем параметры в третью таблицу если условие соблюдается*/
                INSERT INTO My_Third_Table (VALUE, NAME) VALUE(@VAL, @NAM)
        END
/*Выбираем следующую строку*/
FETCH NEXT FROM @CURSOR INTO @ID, @QUA, @VAL, @NAM
END
CLOSE @CURSOR

-----------------------------------------------

курсор для вывода списка фирм и клиентов из Москвы.

DECLARE  @firm    VARCHAR(50),
         @fam     VARCHAR(50),
         @message VARCHAR(80)
PRINT ' Список клиентов'
DECLARE klient_cursor CURSOR LOCAL FOR
    SELECT Фирма, Фамилия
    FROM Клиент
    WHERE Город='Москва'
    ORDER BY Фирма, Фамилия

OPEN klient_cursor
FETCH NEXT FROM klient_cursor INTO @firm, @fam
WHILE @@FETCH_STATUS=0
BEGIN
    SELECT @message='Клиент '+@fam+
                    ' Фирма '+ @firm
    PRINT @message

-- переход к следующему клиенту--

    FETCH NEXT FROM klient_cursor 
      INTO @firm, @fam
END
CLOSE klient_cursor
DEALLOCATE klient_cursor