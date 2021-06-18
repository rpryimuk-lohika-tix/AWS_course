{
    "Version": "2012-10-17",
    "Statement": [
           {
           "Effect": "Allow",
           "Action": [
                 "s3:ListBucket",
                 "s3:GetObject",
                 "s3:PutObject",
                 "s3:DeleteObject"
                 ],
           "Resource": [
                 "arn:aws:s3:::${s3_bucket_name}",
                 "arn:aws:s3:::${s3_bucket_name}/*"
                 ]
           }
    ]
 }