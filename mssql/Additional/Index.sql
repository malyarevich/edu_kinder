USE Kinder_garden
--индекс для таблицы Клиент по столбцу Фамилия в первичной группе файлов
CREATE UNIQUE CLUSTERED INDEX index_klient1
  ON Клиент (Фамилия)
  WITH DROP_EXISTING
  ON PRIMARY
  -
  -- индекс для таблицы Клиент по столбцам Фамилия и Имя в первичной группе файлов
  -- элементы индекса будут упорядочены по убыванию.
  -- запретим автоматическое обновление статистики при изменении данных в таблице
  -- установим фактор заполнения индексных страниц на уровне 30%
  CREATE UNIQUE NONCLUSTERED INDEX index_klient2
  ON Клиент (Фамилия DESC,Имя DESC)
  WITH FILLFACTOR=30,
  STATISTICS_NORECOMPUTE
  ON PRIMARY