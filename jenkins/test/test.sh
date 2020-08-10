#!/bin/bash

echo "***************************"
echo "** Testing ***********"
echo "***************************"

WORKSPACE=/home/jenkins/jenkins-data/jenkins-home/workspace/pipeline-net
DEPENDENCIES=/home/jenkins/jenkins-data/jenkins-home/dependencies

docker run --rm -v $WORKSPACE/Tests:/app -v $DEPENDENCIES:/root/.nuget/packages -w /app mcr.microsoft.com/dotnet/core/sdk:3.1-buster dotnet test --verbosity=normal --results-directory /app --logger "trx;LogFileName=test_results.trx" "Tests.csproj"