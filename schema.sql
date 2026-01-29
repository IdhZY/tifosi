-- =====================================================
-- BASE DE DONNÉES : TIFOSI
-- Script d'initialisation de la base de données et création du schéma
-- Auteur : IdhZY
-- =====================================================

-- INITIALISATION DE LA BASE DE DONNÉES ================


-- Suppression si existante
DROP DATABASE IF EXISTS tifosi;

-- Création de la base de données avec encodage UTF-8
CREATE DATABASE tifosi DEFAULT CHARACTER SET utf8mb4;

-- Sélection de la base de données
USE tifosi;

-- Création de l'utilisateur
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'xoXjog-qyztud-2qimqa';

-- Attribution des privilèges d'administration
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';


-- CRÉATION DES TABLES =================================

-- Sélection de la base de données
USE tifosi;

-- NIVEAU 1 TABLES PARENTES ============================

-- Création de la table "ingredient"
CREATE TABLE ingredient (
    id_ingredient INT PRIMARY KEY AUTO_INCREMENT,
    nom_ingredient VARCHAR(50) NOT NULL UNIQUE
);

-- Création de la table "client"
CREATE TABLE client (
    id_client INT PRIMARY KEY AUTO_INCREMENT,
    nom_client VARCHAR(50) NOT NULL,
    email_client VARCHAR(150) NOT NULL UNIQUE,
    code_postal INT NOT NULL CHECK (code_postal BETWEEN 1000 AND 99999)
);

-- Création de la table "marque"
CREATE TABLE marque (
    id_marque INT PRIMARY KEY AUTO_INCREMENT,
    nom_marque VARCHAR(50) NOT NULL UNIQUE
);

-- NIVEAU 2 TABLES ENFANTS =============================

-- Création de la table "focaccia"
CREATE TABLE focaccia (
    id_focaccia INT PRIMARY KEY AUTO_INCREMENT,
    nom_focaccia VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    CONSTRAINT chk_prix CHECK (prix > 0)
);

-- Création de la table "menu"
CREATE TABLE menu (
    id_menu INT PRIMARY KEY AUTO_INCREMENT,
    nom_menu VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL,
    CONSTRAINT chk_prix_menu CHECK (prix > 0)
);

-- Création de la table "boisson"
CREATE TABLE boisson (
    id_boisson INT PRIMARY KEY AUTO_INCREMENT,
    nom_boisson VARCHAR(50) NOT NULL UNIQUE,
    id_marque INT NOT NULL,
    CONSTRAINT fk_boisson_marque 
        FOREIGN KEY (id_marque) 
        REFERENCES marque(id_marque)
);

-- NIVEAU 3 TABLES D'ASSOCIATION ======================

-- Création de la table "comprend"
CREATE TABLE comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite INT NOT NULL CHECK (quantite > 0),
    PRIMARY KEY (id_focaccia, id_ingredient),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia),
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
);

-- Création de la table "achete"
CREATE TABLE achete (
    id_client INT NOT NULL,
    id_menu INT NOT NULL,
    date_achat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_client, id_menu, date_achat),
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);

-- Création de la table "est_constitue"
CREATE TABLE est_constitue (
    id_menu INT NOT NULL,
    id_focaccia INT NOT NULL,
    PRIMARY KEY (id_menu, id_focaccia),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
);

-- Création de la table "contient"
CREATE TABLE contient (
    id_boisson INT NOT NULL,
    id_menu INT NOT NULL,
    PRIMARY KEY (id_boisson, id_menu),
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);