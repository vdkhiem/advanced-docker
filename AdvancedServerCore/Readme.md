# build advancedservercore image
docker build .t advancedservercore .

# publish AdvancedServerCore to hub.docker.com
1.Log in on https://hub.docker.com/
2.Click on Create Repository.
3.Choose a name (e.g. advancedservercore) and a description for your repository and click Create.

# run following command
docker login --username=vdkhiem
docker images # get image ID of advancedmysql image
docker tag <imageid> vdkhiem/advancedservercore:2020
docker push vdkhiem/advancedservercore