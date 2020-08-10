#!/bin/bash
echo "***************************"
echo "** Building ***********"
echo "***************************"

WORKSPACE=/home/jenkins/jenkins-data/jenkins-home/workspace/pipeline-net
DEPENDENCIES=/home/jenkins/jenkins-data/jenkins-home/dependencies

docker run --rm -v $WORKSPACE/api/:/app -v $DEPENDENCIES:/root/.nuget/packages -w /app mcr.microsoft.com/dotnet/core/sdk:3.1-buster dotnet publish -c Release -o package

##workaround alterar owner da pasta package para remover com usuario jenkins..
docker run --rm -v $WORKSPACE/api/:/app -w /app mcr.microsoft.com/dotnet/core/sdk:3.1-buster chown -R 1000:1000 package
