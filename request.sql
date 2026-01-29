-- =====================================================
-- BASE DE DONNÉES : TIFOSI
-- Script de requête des données
-- Auteur : IdhZY
-- =====================================================

USE tifosi;

-- Requete 1 : Afficher la liste des noms des focaccias par ordre alphabétique croissant
SELECT nom_focaccia
FROM focaccia
ORDER BY nom_focaccia ASC;

-- Requete 2 : Afficher le nombre total d'ingrédients
SELECT COUNT(*) AS total_ingredients
FROM ingredient;

-- Requete 3 : Afficher le prix moyen des focaccias
SELECT AVG(prix) AS prix_moyen_focaccia
FROM focaccia;

-- Requete 4 : Afficher la liste des boissons avec leur marque, triée par nom de boisson
SELECT b.nom_boisson, m.nom_marque
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom_boisson ASC;

-- Requete 5 : Afficher la liste des ingrédients pour une Raclaccia
SELECT i.nom_ingredient
FROM ingredient i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN focaccia f ON c.id_focaccia = f.id_focaccia
WHERE f.nom_focaccia = 'Raclaccia';

-- Requete 6 : Afficher le nom et le nombre d'ingrédients pour chaque foccacia
SELECT f.nom_focaccia, COUNT(fi.id_ingredient) AS nombre_ingredients
FROM focaccia f
LEFT JOIN comprend fi ON f.id_focaccia = fi.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia;

-- Requete 7 : Afficher le nom de la focaccia qui a le plus d'ingrédients
SELECT f.nom_focaccia
FROM focaccia f
JOIN comprend fi ON f.id_focaccia = fi.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia
ORDER BY COUNT(fi.id_ingredient) DESC
LIMIT 1;

-- Requete 8 : Afficher la liste des focaccia qui contiennent de l'ail
SELECT f.nom_focaccia
FROM focaccia f
JOIN comprend fi ON f.id_focaccia = fi.id_focaccia
JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
WHERE i.nom_ingredient = 'Ail';

-- Requete 9 : Afficher la liste des ingrédients inutilisés
SELECT i.nom_ingredient
FROM ingredient i
LEFT JOIN comprend fi ON i.id_ingredient = fi.id_ingredient
WHERE fi.id_ingredient IS NULL;

-- Requete 10 : Afficher la liste des focaccia qui n'ont pas de champignons
SELECT f.nom_focaccia
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT fi.id_focaccia
    FROM comprend fi
    JOIN ingredient i ON fi.id_ingredient = i.id_ingredient
    WHERE i.nom_ingredient = 'Champignon'
);