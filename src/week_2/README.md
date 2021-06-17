Tasks:

•	Create an init-s3.sh script which will do the next things:
o	Create a simple small text file
o	Create AWS S3 bucket (via AWS CLI commands)
o	Add versioning to S3 bucket (via AWS CLI commands)
o	Upload file to S3 (via AWS CLI commands)

•	Verify that uploaded file is not publicly available (you could not rich it from your working machine)

•	Create a Cloud Formation script which will deploy the next infrastructure:
o	EC2 instance with access to S3 service.
o	Implement file downloading from S3 bucket during instance startup (bucket and file should be created by init-s3.sh script).
o	Allow HTTP and SSH access to the EC2 instance

•	Nonfunctional requirements:
o	Use Parameters section in CloudFormation script for customization of input values for your script. Pass input values to the script in user data (for example S3 bucket name from which file should be read, its key, etc). Also ensure that you provided default values for them.
o	Use Outputs section in CloudFormation script for declaring output values. IP address of the created EC2 instance should be available as output parameter after stack creation