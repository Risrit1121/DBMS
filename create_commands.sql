CREATE TABLE Author (
    Author_id INT NOT NULL,
    First_Name TEXT NOT NULL,
    Last_Name TEXT,
    PRIMARY KEY (Author_id)
);

CREATE TABLE Research_Paper (
    RP_id INT NOT NULL,
    Title TEXT NOT NULL,
    Publication_Year VARCHAR(100),
    Conference_Name TEXT,
    Abstract TEXT,
    PRIMARY KEY (RP_id)
);
CREATE TABLE Paper_Author (
    RP_id INT NOT NULL,
    Author_id INT NOT NULL,
    num INT NOT NULL,
    PRIMARY KEY (RP_id, Author_id),
    FOREIGN KEY (RP_id) REFERENCES Research_Paper(RP_id),
    FOREIGN KEY (Author_id) REFERENCES Author(Author_id),
    UNIQUE (RP_id, Author_id)
);
CREATE TABLE Citations (
    RP_id INT NOT NULL,
    CitRP_id INT NOT NULL,
    PRIMARY KEY (
        RP_id,
        CitRP_id
    ),
    FOREIGN KEY (RP_id) REFERENCES Research_Paper(RP_id),
    FOREIGN KEY (CitRP_id) REFERENCES Research_Paper(RP_id)
);

