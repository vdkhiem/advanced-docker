# publish AdvancedMySql to hub.docker.com
1.Log in on https://hub.docker.com/
2.Click on Create Repository.
3.Choose a name (e.g. advancedmysqlcore) and a description for your repository and click Create.

# run following command
docker login --username=vdkhiem
docker images # get image ID of advancedmysql image
docker tag <imageid> vdkhiem/advancedmysqlcore:5.7.27
docker push vdkhiem/advancedmysql

Example
PS C:\Users\khiem> docker login --username=vdkhiem
Password:
Login Succeeded
PS C:\Users\khiem> docker tag 6ad33df3e8e8 vdkhiem/advancedmysqlcore:5.7.27
PS C:\Users\khiem> docker push vdkhiem/advancedmysqlcore

# mysql windows container 
https://hub.docker.com/r/dshatohin/mysql-servercore
https://github.com/dshatohin/mysql-servercore-docker/tree/master/mysql-servercore_5.7-ltsc2019

