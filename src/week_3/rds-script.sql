CREATE DATABASE testDB;
CREATE TABLE Tree (
    treeId int,
    treeName varchar(255)
);
INSERT INTO Tree VALUES (1, "Lipa");
INSERT INTO Tree VALUES (2, "Kashtan");
INSERT INTO Tree VALUES (3, "Berezka");
SELECT treeId, treeName FROM Tree;