DROP DATABASE IF EXISTS `jarditou`;

CREATE DATABASE `jarditou`;

USE `jarditou`;

CREATE TABLE `client`(
        cli_id          INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        cli_type			BOOL,
        cli_nom         VARCHAR(50) NOT NULL,
        cli_prenom      VARCHAR(50) NOT NULL,
        cli_adresse     VARCHAR(100) NOT NULL,
		  cli_cp          CHAR(5),
		  cli_ville       VARCHAR(50),
		  cli_tel			VARCHAR(10),
		  cli_mail			VARCHAR(50)
);

CREATE TABLE commande(
        com_id         				  INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        com_date_commande          DATE NOT NULL,
        com_date_livraison         DATE,
        com_etat         			  VARCHAR(25),
        com_edit_facture			  BOOL,
        cli_id                     INT NOT NULL,
        
        FOREIGN KEY (cli_id) REFERENCES `client` (cli_id)     
);

CREATE TABLE fournisseur(
        fou_id          INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        fou_nom         VARCHAR(50) NOT NULL,
        fou_adresse     VARCHAR(100) NOT NULL,
        fou_cp				CHAR(5),
        fou_ville			VARCHAR(50),
        fou_tel			VARCHAR(10),
        fou_mail			VARCHAR(50),
        fou_type			BOOL
);

CREATE TABLE rubrique(
        rub_id          INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        rub_libelle     VARCHAR(50) NOT NULL     
);

CREATE TABLE produit(
        pro_code         CHAR(6) NOT NULL PRIMARY KEY,
        pro_libelle      VARCHAR(100) NOT NULL,
        pro_desc         VARCHAR(250),
        pro_photo			 VARCHAR(250),
        pro_affichage    BOOL,
        pro_prix_achat   INT NOT NULL,
        pro_stock_phy    INT NOT NULL,
        pro_stock_aler   INT NOT NULL,
        fou_id           INT NOT NULL,
        rub_id           INT NOT NULL,
        FOREIGN KEY (fou_id) REFERENCES fournisseur (fou_id),
        FOREIGN KEY (rub_id) REFERENCES rubrique (rub_id)
);

CREATE TABLE panier(
        comp_qte_pro           INT NOT NULL,
        comp_prix_vente_par      FLOAT NOT NULL,
        comp_prix_vente_pro   FLOAT NOT NULL,
		  pro_code					CHAR(6) NOT NULL,
		  com_id						INT NOT NULL,
		  FOREIGN KEY (pro_code) REFERENCES produit (pro_code),
        FOREIGN KEY (com_id) REFERENCES commande (com_id),
        PRIMARY KEY (pro_code, com_id)        
);


CREATE UNIQUE INDEX date_com 
ON client (cli_nom)
;

CREATE  UNIQUE  INDEX date_com 
ON commande ( com_date_commande ) 
;

INSERT INTO produit (pro_code ,pro_libelle ,fou_id)
VALUES
("1","prd1",1)
;


INSERT INTO panier (comp_qte_pro ,comp_prix_vente_par ,comp_prix_vente_pro ,pro_code ,com_id)
VALUES
(5,5,5,"5",24),
(6,6,6,"6",24),
(7,7,7,"7",25),
(8,8,8,"8",25),
(9,9,9,"9",26),
(10,10,10,"10",26),
(11,11,11,"11",27),
(12,12,12,"12",27),
(13,13,13,"13",28),
(14,14,14,"14",28),
(15,15,15,"15",29),
(16,16,16,"16",29),
(17,17,17,"17",30),
(18,18,18,"18",30),
(19,19,19,"19",31),
(20,20,20,"20",31),
(21,21,21,"21",31)
;


CREATE USER 'gestionnaire'@'%' IDENTIFIED BY '123';
CREATE USER 'approvisionneur'@'%' IDENTIFIED BY '123';
CREATE USER 'administrateur'@'%' IDENTIFIED BY '123';


GRANT ALL PRIVILEGES 
ON jarditou.produit
TO 'approvisionneur'@'%';
FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES 
ON jarditou.*
TO 'administrateur'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;