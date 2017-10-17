Certification et configuration d'Azure
======================================

<!--
Also a best effort at translation @alimakki
-->
Installation
------------
* Créer une application ( [guide visuel](https://docs.microsoft.com/fr-fr/azure/azure-resource-manager/resource-group-create-service-principal-portal#create-an-active-directory-application) )<br />
	Rechercher **Inscriptions d’applications** dans la barre de recherche et sélectionnez le premier résultat.<br />
	Sélectionnez **Inscriptions d’applications**.<br />
	Remplissez le formulaire:

		Name: StreisandAuth
		Application type: Web app / API
		Sign-on URL: http://StreisandAuth

* Assurez que l'application peut créer des instances Azure ( [guide visuel](https://docs.microsoft.com/fr-fr/azure/azure-resource-manager/resource-group-create-service-principal-portal#assign-application-to-role) )<br />
	Rechercher **Abonnements** dans la barre de recherche et sélectionnez le premier résultat.<br />
	Choisissez l'abonnement souhaité.<br />
	Sélectionnez **Access control (IAM)** à partir du menu nouvellement ouvert.<br />
	Ajouter:

		Role: Contributor
		Select: StreisandAuth

Autorisations
-------------
Emplacement du fichier:

		~/.azure/credentials

Format du fichier ( [source](https://docs.ansible.com/ansible/guide_azure.html#storing-in-a-file) ).

		[default]
		subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
		client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
		secret=xxxxxxxxxxxxxxxxx
		tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

Remplacez le motif **xxxxx** par les valeurs obtenues en suivant les étapes ci-dessous.

* Obtenir le **subscription_id**<br />
	Rechercher pour **Subscriptions** à partir du menu nouvellement ouvert.<br />
	L'ID de l'abonnement sera dans la deuxième colonne du tableau des abonnements.

* Obtenir le **client_id** ( [guide visuel](https://docs.microsoft.com/fr-fr/azure/azure-resource-manager/resource-group-create-service-principal-portal#get-application-id-and-authentication-key) )<br />
	Rechercher pour **App registrations** à partir du menu nouvellement ouvert.<br />
	Sélectionnez votre application dans la liste: **StreisandAuth**.<br />
	Le client_id est le [Guid](https://en.wikipedia.org/wiki/Universally_unique_identifier) sous **Application ID**.<br />

* Obtenir le **secret** ( [guide visuel](https://docs.microsoft.com/fr-fr/azure/azure-resource-manager/resource-group-create-service-principal-portal#get-application-id-and-authentication-key) )<br />
	Rechercher pour **App registrations** à partir du menu nouvellement ouvert.<br />
	Sélectionnez votre application dans la liste: **StreisandAuth**.<br />
	Sélectionnez **Keys** à partir du menu nouvellement ouvert à droite.<br />
	Créer une nouvelle clé:

		Key description: streisand
		Duration: Never expires
	La clé secrète sera générée après la sauvegarde.

* Obtenir le **tenant** ( [guide visuel](https://docs.microsoft.com/fr-fr/azure/azure-resource-manager/resource-group-create-service-principal-portal#get-tenant-id) )<br />
	Rechercher pour **Azure Active Directory** à partir du menu nouvellement ouvert.<br />
	Faites défiler vers le bas et sélectionnez **Properties** à partir du menu nouvellement ouvert à gauche.<br />
	Le locataire est le Guid sous **Directory ID**.<br />

Problèmes possibles et dépannage
--------------------------------
* You cannot register an application (Vous ne pouvez pas enregistrer une application)<br />
	Rechercher pour **Azure Active Directory** à partir du menu nouvellement ouvert.<br />
	Dans le menu gauche résultant, sélectionnez "User settings".<br />
	Assurez-vous que **App registrations** sont réglés sur **Yes**.
