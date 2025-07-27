CREATE TABLE userdetail (
  id INT AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  inactive TINYINT(1) DEFAULT 0,
  PRIMARY KEY (id)
);
INSERT INTO userdetail (id, name, inactive)
VALUES
(1, 'John Doe', 0),
(3, 'Jane Doe', 0),
(5, 'Bob Smith', 0),
(7, 'Alice Johnson', 0),
(9, 'Mike Brown', 0);

select * from userdetail



------------------------------------------------------------

CREATE SCHEMA settings;

CREATE TABLE settings.profile (
  id INT ,
  profilename VARCHAR(255) NOT NULL,
  userid INT,
  createdon DATETIME2,
  PRIMARY KEY (id)
);

INSERT INTO settings.profile (id, profilename, userid, createdon)
VALUES
(1, 'Superadmin', 1, DATEADD(DAY, (CHECKSUM(NEWID()) % 3650) - 1825 + CASE WHEN CHECKSUM(NEWID()) % 2 = 0 THEN 365 ELSE 0 END, '2020-01-01')),
(2, 'Editor', 3, DATEADD(DAY, (CHECKSUM(NEWID()) % 3650) - 1825 + CASE WHEN CHECKSUM(NEWID()) % 2 = 0 THEN 365 ELSE 0 END, '2020-01-01')),
(3, 'Viewer', 5, DATEADD(DAY, (CHECKSUM(NEWID()) % 3650) - 1825 + CASE WHEN CHECKSUM(NEWID()) % 2 = 0 THEN 365 ELSE 0 END, '2020-01-01')),
(4, 'Novoice', 7, DATEADD(DAY, (CHECKSUM(NEWID()) % 3650) - 1825 + CASE WHEN CHECKSUM(NEWID()) % 2 = 0 THEN 365 ELSE 0 END, '2020-01-01')),
(5, 'temp', 9, DATEADD(DAY, (CHECKSUM(NEWID()) % 3650) - 1825 + CASE WHEN CHECKSUM(NEWID()) % 2 = 0 THEN 365 ELSE 0 END, '2020-01-01'));

select * FROM settings.profile;




------------------------------------------------------------





CREATE CATALOG mysql_catalog properties(
    'type' = 'jdbc',
    'user' = 'root',
    'password' = 'YourStrong!Passw0rd',
    'jdbc_url' = 'jdbc:mysql://127.0.0.1:3306/dev_db',
    'driver_url' = 'mysql-connector-java-8.0.25.jar',
    'driver_class' = 'com.mysql.cj.jdbc.Driver'
);

CREATE CATALOG sqlserver_catalog
PROPERTIES (
    'type' = 'jdbc',
    'user' = 'sa',
    'password' = 'YourStrong!Passw0rd',
    'jdbc_url' = 'jdbc:sqlserver://127.0.0.1:1433;databaseName=master;trustServerCertificate=true',
    'driver_url' = 'mssql-jdbc-12.10.1.jre8.jar',
    'driver_class' = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
);


------------------------------------------------------------



select p.id,u.id,u.name from sqlserver_catalog.settings.profile p
join mysql_catalog.dev_db.userdetail u
on u.id=p.userid
limit 10;

--------------------------------------------------------------

SELECT u.name
FROM mysql_catalog.dev_db.userdetail u
WHERE u.id in (SELECT p.userid from sqlserver_catalog.settings.profile p WHERE p.id=1)
LIMIT 10;

--------------------------------------------------------------
WITH userids AS (
    SELECT u.id
    FROM mysql_catalog.dev_db.userdetail u
)
SELECT p.profilename,current_time(),p.createdon, date_add(p.createdon, INTERVAL 2 DAY)
FROM sqlserver_catalog.settings.profile p
WHERE p.userid IN (SELECT id FROM userids) and p.createdon < current_date()
LIMIT 10;

WITH profile_userids AS (
    SELECT p.userid
    FROM sqlserver_catalog.settings.profile p
    WHERE date_add(p.createdon, INTERVAL 2 DAY)< current_date()
)
SELECT u.name,current_time()
FROM mysql_catalog.dev_db.userdetail u
WHERE u.id IN (SELECT userid FROM profile_userids)
LIMIT 10;

WITH userids AS (
    SELECT u.id
    FROM mysql_catalog.dev_db.userdetail u
)
SELECT p.profilename,current_time(),p.createdon, date_add(p.createdon, INTERVAL 2 DAY),datediff(p.createdon,current_date())
FROM sqlserver_catalog.settings.profile p
WHERE cast(p.userid as DOUBLE) IN (SELECT id FROM userids) and p.createdon < current_date()
LIMIT 10;

