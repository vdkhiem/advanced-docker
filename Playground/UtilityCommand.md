# Push a image to docker hub registry
https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html
docker login --username=vdkhiem
docker images # get image ID
docker tag cc250cef714f vdkhiem/advancedservercore:2020
docker push vdkhiem/advancedservercore

# Example dockerfile to generate Advanced App image
FROM vdkhiem/advancedservercore:2020
COPY Natasha.AdvancedLive.2020.2.0.3460.zip ac.ps1 c:/
RUN powershell -Command \
    New-Item -Path c:\ -Name 2020.2.0.3460 -ItemType directory; \
    Expand-Archive -Path c:\Natasha.AdvancedLive.2020.2.0.3460.zip -DestinationPath c:\2020.2.0.3460; \
    Remove-Item c:\Natasha.AdvancedLive.2020.2.0.3460.zip
RUN c:\\2020.2.0.3460\\tools\\ac.exe -cm:"NewInstance" -s:"192.168.1.84" -sw:"No" -u:"root" -p:"root" -d:"2020.2.0.3460" -c:"ci=1;ct=;cn=;" -c:"ci=2;ct=;cp=1;cn=;" -c:"ci=3;ct=AU;cp=2;cv=Yes;cn=AU;"  -dw:"No" -dn:"No" -du:"root" -dp:"root" -i:"2020.2.0.3460" -h:"C:\\2020.2.0.3460\\2020.2.0.3460\\" -w:"Default Web Site" -v:"2020.2.0.3460" -po:"DefaultAppPool" -output:"Forced" -dbsrvtype:"MySql"

# Spin up a new Advanced App container
    # create a advanced container interactive mode, once inside container, launch powershell
docker run -ti --rm -p 8000:80 --name advanced-container advanced-app-image powershell


# Miscellanous commands
#docker build -t advanced-image-$build_number .
#docker run -ti -p 8083:80 --name advanced-container-$build_number advanced-image-$build_number powershell .\ac.ps1 -build_number $build_number -db_server $db_server

# Powershell command
Remove-Website -Name 'Default Web Site'; // remove website
New-Website -Name 'advanced' -PhysicalPath 'C:\2020.2.0.3460\2020.2.0.3460' -Port 80 -Force // add new website

New-Website -Name 'Default Web Site' -PhysicalPath 'C:\2020.2.0.3460\2020.2.0.3460' -Port 80 -Force // add new website

#
docker run --name mysql-db -e MYSQL_ROOT_PWD=root -e DB_NAME=database -e DB_USER=dbuser -e DB_USER_PWD=userpassword -d dshatohin/mysql-servercore:latest

#replace string in file powershell
(Get-Content -path C:\2020.2.0.3460\2020.2.0.3460\web.config -Raw) -replace 'Server=172.30.92.153','Server=mysql-db'

#docker run --name advanced-app --network advanced-net -p 8081:80 -ti advanced-app-image powershell .\ac.ps1 -build_number $build_number -db_server $db_server -db_user $db_user -db_password $db_password

# command clean up containers and network
docker container rm -f $(docker ps -a -q)   
docker network rm advanced-net
docker image rm advanced-app-image
.\start.ps1 -build_number 2020.2.0.3857 -db_user root -db_password root

docker container exec -ti advanced-app-container powershell .\ac.ps1 -build_number 2020.2.0.3460 -db_server "localhost,3306" -db_user root -db_password root

# create a new network and connect containers to network
docker network create advanced-net -d nat
docker network connect advanced-net advanced-app-container
docker network connect advanced-net advanced-mysql-container
