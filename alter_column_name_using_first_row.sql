DELIMITER $$
CREATE PROCEDURE A18 ()
BEGIN
	DECLARE a INT DEFAULT 0;
    DECLARE str1 NVARCHAR(100) ;
	simple_loop: LOOP   
		-- SELECT @sql;
		SET @sql = NULL;
        SET a = a + 1;
        	SELECT column_name 
			INTO @sql
			FROM INFORMATION_SCHEMA.COLUMNS
		   WHERE table_schema = 'baka'
			 AND table_name = 'user'
			 AND ordinal_position = a;
          SET @value = CONCAT('SELECT ', @sql, ' FROM (SELECT * FROM user LIMIT 1) as a');
		  SET @sql = CONCAT('ALTER TABLE `user` RENAME COLUMN `', @sql, '` TO `', @value, '`');
          SELECT @sql;
         IF a = (SELECT MAX(ordinal_position) FROM information_schema. columns where table_schema = 'baka' and table_name = 'user')  THEN
            LEAVE simple_loop;
         END IF;
          
	END LOOP simple_loop;
  -- PREPARE stmt FROM @sql;
  -- EXECUTE stmt;
  -- DEALLOCATE PREPARE stmt;
  -- SELECT @sql;
END$$
DELIMITER ;
CALL `A18`();
