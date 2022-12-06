DROP DATABASE IF EXISTS `exercice`;

CREATE DATABASE `exercice`;

USE `exercice`;

CREATE TABLE client(
        cli_num          INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        cli_nom          VARCHAR(50) NOT NULL,
        cli_adresse      VARCHAR(50),
        cli_tel          VARCHAR(30)      
);

CREATE TABLE commande(
        com_num          INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        cli_num          INT NOT NULL,
        com_date         DATE NOT NULL,
        com_obs          VARCHAR(50),
        FOREIGN KEY (cli_num) REFERENCES client (cli_num)     
);

CREATE TABLE produit(
        pro_num           INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        pro_libelle       VARCHAR(50) NOT NULL,
        pro_description   VARCHAR(50)         
);

CREATE TABLE detail(
        com_num         INT NOT NULL,
        pro_num         INT NOT NULL,
        det_qte         INT NOT NULL,
        FOREIGN KEY (com_num) REFERENCES commande (com_num),
        FOREIGN KEY (pro_num) REFERENCES produit (pro_num),
        PRIMARY KEY (com_num, pro_num)
);