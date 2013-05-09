#!/bin/tcsh

set SPOTLIGHTDIR = "dbpedia-spotlight";

cd .. 

if (-d $SPOTLIGHTDIR)
    echo "dbpedia spotlight already exists skipping the step of downloading it";
else
    echo "downloading dbepdia spotlight";
    git clone https://github.com/dbpedia-spotlight/dbpedia-spotlight.git

cd $SPOTLIGHTDIR

if (-e pom.xml.orig)
    echo "the original pom.xml files have been already replaced"
else
    mv pom.xml pom.xml.orig
    mv core/pom.xml core/pom.xml.orig
    cd ../IXA-EHU-DBpedia-spotlight
    cp pom.xml ../dbpedia-spotlight/.
    cp core/pom.xml ../dbpedia-spotlight/core/.
    cp conf/server_en.properties ../dbpedia-spotlight/conf/.
    cp conf/server_es.properties ../dbpedia-spotlight/conf/.

cd ..
cd $SPOTLIGHTDIR
echo "installing the modified dbpedia spolight"
mvn clean install

echo "creating the jar with dependencies"
cd dist
mvn clean package



