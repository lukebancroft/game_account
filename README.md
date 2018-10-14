# game_account
game_account est un gestionnaire universel de comptes de jeux permettant de :
- Gérer des données d'utilisateurs, de résultats de parties et de messages via une interface admin
- Manipuler ces données graçe à une API REST

Installation
-

Pré-requis :
- Serveur Apache qui tourne sur le port 8888 ou le changer à la ligne 13 de application.yml
```sh
cdnRootUrl: http://localhost:8888/tpGrails
```
- Changer le répertoire de stockage des avatars des utilisateurs à la ligne 12 de application.yml pour correspondre à votre configuration
```sh
cdnFolder: /Users/Luke/Sites/tpGrails
```


Utilisation de la plateforme :
- Pour vous connecter à la plateforme, vous pourrez utiliser les identifiants "admin" et "123" ou ceux de n'importe quel autre utilisateur présent dans bootstrap.groovy
- Pour accéder aux pages autres que celle du login, connectez-vous avec un compte administrateur
- L'application utilise une base de données en mémoire H2 avec des données de test, si vous souhaitez utiliser votre propre BDD MySQL, dans application.yml échangez le code sous "dataSource:" et "environments:development:dataSource" par celui qui est commenté en saisissant les paramètres appropriés puis commentez le code du servletContext dans Bootstrap.groovy
- Pour vous connecter à la base de données H2, allez sur http://localhost:8081/dbconsole et entrez "sa" en login et aucun mot de passe

Fonctionnalités
-

- Graphique Chart.js sur la page d'accueil récapitulant le nombre de parties des 12 derniers mois
- Statistiques des entités sur la page d'accueil
- Visualisation, modification et création d'utilisateurs, de résultats de parties et de messages
- Supression de tous les messages lus à 4h du matin, tous les matins graçe à un trigger Cron
- Stockage des avatars des utilisateurs sur une plateforme "distante" Apache avec Ajax et visualisation après upload
- Gestion de la sécurité et des rôles utilisateur par Grails Spring Security
- Web service REST requêtable depuis http://localhost:8888/api/
 
 API
 -
 **Documentation complète et tests cURL disponibles ici : https://documenter.getpostman.com/view/5602536/RWgrxxYm#d4d6209e-6fbd-4e7d-8cc4-9b27a0de32ba**
 
 Gestion des requêtes dans le contrôleur ApiController


Projet M2 MBDS Nice Sophia Antipolis - Promo 2018/2019 - Enseignant: Grégory Galli - Langage : Grails 3.3.8
