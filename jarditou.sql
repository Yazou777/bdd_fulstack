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
        compa_prix_vente_pro   FLOAT NOT NULL,
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