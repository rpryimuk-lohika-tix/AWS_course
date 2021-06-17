Tasks:

•	Develop and deploy via AWS CLI CloudFormation script which will create next infrastructure
o	Auto-scaling group (ASG) with two EC2 instances within it (we need to ensure that min amount of instances in the ASG is 2)
o	Allow SSH and HTTP access to EC2 instances
o	Add the ability for EC2 instances to install Java 8 during startup
•	Nonfunctional requirements:
o	Use Parameters section in CloudFormation script for customization of input values for your script (such as EC2 instance type, AMI ID, KeyName file, etc). Also ensure that you provided default values for them.
