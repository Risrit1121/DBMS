copy Author(Author_Id, First_Name, Last_Name)
FROM '/Users/aravindshounikvanga/Documents/Sem4/DBMS2/Group_37_Assign2/authors.csv' WITH csv DELIMITER E'\u0005' ENCODING 'utf-8';
copy Research_paper(
    RP_id,
    Title,
    Publication_Year,
    Conference_Name,
    Abstract
)
FROM '/Users/aravindshounikvanga/Documents/Sem4/DBMS2/Group_37_Assign2/respaper.csv' WITH csv DELIMITER E'\u0005' ENCODING 'utf-8';
copy Paper_Author(RP_id, Author_id, num)
FROM '/Users/aravindshounikvanga/Documents/Sem4/DBMS2/Group_37_Assign2/paperauth.csv' WITH csv DELIMITER E'\u0005' ENCODING 'utf-8';
copy Citations(RP_id, CitRP_id)
FROM '/Users/aravindshounikvanga/Documents/Sem4/DBMS2/Group_37_Assign2/citations.csv' WITH csv DELIMITER E'\u0005' ENCODING 'utf-8';