Configuration de contrôle d'accès AWS IAM
=========================================

Configuration d'accès IAM
-------------------------

* Connectez-vous à AWS et naviguez jusqu'à le panneau Gestion des identités et des accès (IAM) 
![](screenshots/AWS/IAMPolicy1.png?raw=true)

* Créer un groupe de resources
![](screenshots/AWS/IAMPolicy2.png?raw=true)

* Entrez un nom et une description pour la groupe de resources, coller le document de ci-dessous, puis créez la resource en cliquant sur le bouton dans le coin inférieur droit.
![](screenshots/AWS/IAMPolicy3.png?raw=true)

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EC2Policies",
            "Action": [
                "ec2:AllocateAddress",
                "ec2:AssociateAddress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:CreateSecurityGroup",
                "ec2:ImportKeyPair",
                "ec2:CreateTags",
                "ec2:CreateSecurityGroup",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeAddresses",
                "ec2:DescribeAlarms",
                "ec2:DescribeImages",
                "ec2:DescribeInstances",
                "ec2:DescribeKeyPairs",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:RunInstances",
                "ec2:DeleteKeyPair"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "CloudwatchPolicies",
            "Action": [
                "cloudwatch:DescribeAlarms",
                "cloudwatch:PutMetricAlarm"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "IAMPolicies",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
```

* Vous devriez voir un écran de confirmation semblable au suivant:
![](screenshots/AWS/IAMPolicy4.png?raw=true)


Configuration de l'utilisateur d'IAM
-----
* Naviguez jusqu'à le panneau Gestion des identités et des accès (IAM)

* Ajoutez un utilisateur, selectionnez `Accès par programmation`. Cliquez le bouton `Suivant: Autorisations`
![](screenshots/AWS/IAMUser1.png?raw=true)

* Définissez les autorisations pour l'utilisateur IAM en attachant le document créée ci-dessus.
![](screenshots/AWS/IAMUser2.png?raw=true)

* Vérifiez les changements, puis cliquez sur le bouton `Créer un utilisateur`
![](screenshots/AWS/IAMUser3.png?raw=true)

* Après l'écran de confirmation, téléchargez le fichier `.csv` — vous l'utiliserez lors de la configuration de votre VPN.
![](screenshots/AWS/IAMUser4.png?raw=true)
