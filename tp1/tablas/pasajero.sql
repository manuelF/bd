CREATE TABLE Users(
    user_id integer AUTOINCREMENT PRIMARY KEY,
    username varchar(50),
    firstname varchar(100),
    lastname varchar(100),
    dob date,
    nationality_id integer FOREIGN KEY (Nations.id),
    phone varchar(30),
    email varchar(100),
    profession varchar(100),

    frequenttraveler boolean,
    foodpreferences varchar(1000),
    
    --chosen destinations -- relacion con aeropuertos?
    
    flightcategory integer FOREIGN KEY (Category.id),
    flightseason integer, --alta = 1, baja = 0
    
    -- accompanied by -- relacion con otros usarios por 3ºfrm normal

);
