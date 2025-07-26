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
  PRIMARY KEY (id)
);

INSERT INTO settings.profile (id, profilename, userid)
VALUES
(1, 'Superadmin', 1),
(2, 'Editor', 3),
(3, 'Viewer', 5),
(4, 'Novoice', 7),
(5, 'temp', 9);

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
    'jdbc_url' = 'jdbc:sqlserver://127.0.0.1:1433;databaseName=test_db;trustServerCertificate=true',
    'driver_url' = 'mssql-jdbc-12.10.1.jre8.jar',
    'driver_class' = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
);

