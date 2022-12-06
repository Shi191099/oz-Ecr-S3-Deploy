#!/bin/bash
sudo su -
mkdir /home/ec2-user/oz
cd /home/ec2-user/oz

echo "setting source bucket credentials"
aws configure set aws_access_key_id Access_Key
aws configure set aws_secret_access_key Secret_Key
echo "credentials set successful"

aws s3 cp s3://oz-s3-ec2-04/sample.war .

yum install docker -y
service docker start
chmod 777 /var/run/docker.sock
service docker status

aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 805392809179.dkr.ecr.ap-southeast-2.amazonaws.com

docker pull 805392809179.dkr.ecr.ap-southeast-2.amazonaws.com/oz-pipeline-04:latest

docker run -td -v sample.war:/data -P 805392809179.dkr.ecr.ap-southeast-2.amazonaws.com/oz-pipeline-04:latest
