#!/bin/bash
sudo su -
mkdir /home/ec2-user/oz
cd /home/ec2-user/oz

echo "setting source bucket credentials"
aws configure set aws_access_key_id AKIA3XBJG7TNRPSTXLOS
aws configure set aws_secret_access_key PPcj10r+BbHw9VVW8aQ0KGgYFJSLXiF1H/Ae3dBs
echo "credentials set successful"

aws s3 cp s3://oz-s3-ec2-04/sample.war .

yum install docker -y
service docker start
service docker status

aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 805392809179.dkr.ecr.ap-southeast-2.amazonaws.com

docker pull 805392809179.dkr.ecr.ap-southeast-2.amazonaws.com/oz-pipeline-04:latest

docker run -td --name oz-s3-ecr-ec2 -v sample.war:/data -p 80:8080 805392809179.dkr.ecr.ap-southeast-2.amazonaws.com/oz-pipeline-04:latest
