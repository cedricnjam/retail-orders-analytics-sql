# Retail Orders Performance Analytics (SQL Server / T-SQL)

## 📌 Présentation du Projet
Projet d'analyse décisionnelle et d'exploration de performance commerciale mené sur un jeu de données retail de **9 994 transactions** (2022 - 2023). 

L'objectif consiste à modéliser la donnée brute sous SQL Server, calculer les indicateurs clés de vente (chiffre d'affaires net, marges, paniers moyens) et identifier les leviers de rentabilité par segment, catégorie et zone géographique.

---

## 🛠️ Stack Technique & Compétences Mobilisées
* **SGBD** : Microsoft SQL Server (T-SQL)
* **Agrégations & Filtrage** : `GROUP BY`, `HAVING`, `CASE WHEN`
* **Analytique avancée** : Common Table Expressions (`WITH CTE`), Fonctions de fenêtrage (`LAG() OVER()`)
* **Nettoyage & typage** : Prise en compte dynamique des remises et calculs de marges réelles

---

## 📊 Métriques Clés Extraites
* **Chiffre d'affaires net global** : 11 079 328,20 $
* **Bénéfice net total** : 1 039 928,20 $
* **Volume de commandes** : 9 994 transactions
* **Panier moyen unitaire** : 1 108,60 $

---

## 🔍 Analyses Réalisées
1. **Pilotage commercial global** : Calcul du chiffre d'affaires réel déduit des remises promotionnelles et de la valeur moyenne de commande.
2. **Top Produits & Catégories** : Identification des générateurs de revenus moteurs (`Technology` et `Furniture` en tête).
3. **Segmentation de panier (CASE WHEN)** : Classification des transactions selon la valeur d'achat (Paniers élevés, moyens et petits).
4. **Dynamique temporelle N vs N-1** : Analyse de la croissance d'une année sur l'autre (2022 vs 2023) à l'aide de la fonction de fenêtrage `LAG()`.
5. **Audit des sous-catégories phares** : Filtrage conditionnel (`HAVING`) sur les lignes d'activité générant plus de 50 000 $ de chiffre d'affaires.

---

## 🚀 Structure du Dépôt
* `retail_orders_analysis.sql` : Script SQL complet contenant l'ensemble des requêtes ordonnées par cas d'usage métier.
* `orders.csv` : Données sources de vente au format plat.
