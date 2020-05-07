FROM nanoserver/iis-php
#FROM mcr.microsoft.com/windows/nanoserver:1803

MAINTAINER khiem.vo@myob.com

COPY mysql-init.txt my.ini c:/
ADD https://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.22-winx64.zip mysql.zip
RUN powershell -command \
    Expand-Archive -Path c:\mysql.zip -DestinationPath C:\ ; \
    ren C:\mysql-5.7.22-winx64 C:\MySQL ; \
    Move-Item -Path C:\mysql-init.txt -Destination C:\MySQL\mysql-init.txt ; \
    Move-Item -Path C:\my.ini -Destination C:\MySQL\my.ini ; \
    New-Item -Path C:\MySQL\data -ItemType directory ; \
    C:\MySQL\bin\mysqld.exe --initialize --init-file=C:\\MySQL\\mysql-init.txt --console --explicit_defaults_for_timestamp ; \
    C:\MySQL\bin\mysqld.exe --install ;

ENV MYSQL C:\\MySQL
RUN setx PATH /M %PATH%;C:\MySQL\bin