#!/bin/tcsh

cd ..
git clone https://github.com/dbpedia-spotlight/dbpedia-spotlight.git

cd dbpedia-spotlight
mv pom.xml pom.xml.orig
mv core/pom.xml core/pom.xml.orig

cd ../IXA-EHU-DBpedia-spotlight
cp pom.xml ../dbpedia-spotlight/.
cp core/pom.xml ../dbpedia-spotlight/core/.
cp conf/server_en.properties ../dbpedia-spotlight/conf/.
cp conf/server_es.properties ../dbpedia-spotlight/conf/.

cd ../dbpedia-spotlight
mvn clean install

cd dist
mvn clean package



