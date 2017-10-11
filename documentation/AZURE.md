Azure credential and setup
==========================

- - -
[English](AZURE.md), [Français](AZURE-fr.md)
- - -

Setup
-----
* Create an application ( [visual guide](https://docs.microsoft.com/en-in/azure/azure-resource-manager/resource-group-create-service-principal-portal#create-an-active-directory-application) )<br />
	Search for **App registrations** in the top search bar and select the first result.<br />
	Select **New application registration**.<br />
	Fill in the application form:

		Name: StreisandAuth
		Application type: Web app / API
		Sign-on URL: http://StreisandAuth

* Ensure that the application can create Azure instances ( [visual guide](https://docs.microsoft.com/en-in/azure/azure-resource-manager/resource-group-create-service-principal-portal#assign-application-to-role) )<br />
	Search for **Subscriptions** in the top search bar and select the first result.<br />
	Choose the desired subscription.<br />
	Select **Access control (IAM)** from the newly opened menu.<br />
	Add:

		Role: Contributor
		Select: StreisandAuth

Credentials
-----------
File location:

		~/.azure/credentials

File format ( [source](https://docs.ansible.com/ansible/guide_azure.html#storing-in-a-file) ).

		[default]
		subscription_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
		client_id=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
		secret=xxxxxxxxxxxxxxxxx
		tenant=xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

Replace the **xxxxx** pattern with the values obtained by following the below steps.

* Get the **subscription_id**<br />
	Search for **Subscriptions** in the top search bar and select the first result.<br />
	The subscription ID will be in the second column of the subscriptions table.

* Get the **client_id** ( [visual guide](https://docs.microsoft.com/en-in/azure/azure-resource-manager/resource-group-create-service-principal-portal#get-application-id-and-authentication-key) )<br />
	Search for **App registrations** in the top search bar and select the first result.<br />
	Select your application from the list: **StreisandAuth**.<br />
	The client_id is the [Guid](https://en.wikipedia.org/wiki/Universally_unique_identifier) under **Application ID**.<br />

* Get the **secret** ( [visual guide](https://docs.microsoft.com/en-in/azure/azure-resource-manager/resource-group-create-service-principal-portal#get-application-id-and-authentication-key) )<br />
	Search for **App registrations** in the top search bar and select the first result.<br />
	Select your application from the list: **StreisandAuth**.<br />
	Select **Keys** from the newly opened menu on the right.<br />
	Create a new key:

		Key description: streisand
		Duration: Never expires
	The secret key will be generated after saving.

* Get the **tenant** ( [visual guide](https://docs.microsoft.com/en-in/azure/azure-resource-manager/resource-group-create-service-principal-portal#get-tenant-id) )<br />
	Search for **Azure Active Directory** in the top search bar and select the first result.<br />
	Scroll down and select **Properties** from the newly opened left menu.<br />
	The tenant is the Guid under **Directory ID**.<br />

Possible issues and troubleshooting
-----------------------------------
* You cannot register an application<br />
	Search for **Azure Active Directory** in the top search bar and select the first result.<br />
	In the resulting left menu select "User settings".<br />
	Ensure that **App registrations** is set to **Yes**.
