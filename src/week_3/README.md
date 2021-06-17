Tasks:

•	Create a simple SQL script rds-script.sql which will perform next things:
o	Database creation
o	Creation of one simple table for tests
o	Adding some dummy data to the table
o	A simple select statement which will return all entries from the table
•	Create a simple dynamodb-script.sh which will do the next things (via AWS CLI commands):
o	Display existing Dynamo DB tables
o	Add a few entries in the table
o	Read entries from the table
•	Create a init-s3.sh script which will do the next things:
o	Create AWS S3 bucket
o	Upload the rds-script.sql and the dynamodb-script.sh to an S3 bucket
•	Create a Terraform script which will create the next infrastructure:
o	One Dynamo DB table
o	One RDS database (postgres)
o	Create an EC2 instance with all needful access permissions (to S3, DynamoDB and RDS)
o	All scripts from S3 should be copied to the instance during startup
o	Add access permissions for HTTP, SSH, and to selected RDS database
o	An RDS endpoint and port should be available in the script output
o	As usual please put as much customization as possible via input variables to the script
•	SSH to a created EC2 instance and execute both scripts in order to test your solution