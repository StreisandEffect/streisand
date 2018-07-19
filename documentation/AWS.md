AWS IAM role and policy setup
==========================

IAM Policy Setup
-----

* Log onto AWS and navigate to the IAM policy panel
![](screenshots/AWS/IAMPolicy1.png?raw=true)

* Create a IAM Policy
![](screenshots/AWS/IAMPolicy2.png?raw=true)

* Write a name and description for the policy, paste in the below policy document, then create the policy by clicking the button in the lower right corner.
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

* You should see a confirmation screen similar to the below:
![](screenshots/AWS/IAMPolicy4.png?raw=true)


IAM User Setup
-----
* Navigate to the IAM User panel

* Add a user name, select the `programmatic access` access type. Then click the `Next: Permissions` button
![](screenshots/AWS/IAMUser1.png?raw=true)

* Set the permissions for the IAM User by attaching the policy created above.
![](screenshots/AWS/IAMUser2.png?raw=true)

* Review the changes, the click the `Create User` button
![](screenshots/AWS/IAMUser3.png?raw=true)

* After the confirmation screen, download the `.csv` file — you'll use it when setting up your VPN.
![](screenshots/AWS/IAMUser4.png?raw=true)
