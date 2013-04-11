CREATE TABLE Cities (
    cityid integer AUTOINCREMENT PRIMARY KEY,
    fullname varchar(100),
    countryid integer FOREIGN KEY (Countries.id)
);
