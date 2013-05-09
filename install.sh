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
    echo "the original pom.xml files have been already replaced, skipping the replacement"
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
cp target/dbpedia-spotlight-0.6-jar-with-dependencies.jar ../../bin/.

echo "creating a directory to store the indexes..."
cd ..
cd $SPOTLIGHTDIR
mkdir data
cd data

echo "Getting English index..."
wget 'https://siuc05.si.ehu.es/~ragerri/index-spotlight/index-en.tar.gz'
echo "done"
echo "Getting Spanish index..."
wget 'https://siuc05.si.ehu.es/~ragerri/index-spotlight/index-es.tar.gz'
echo "done"

echo "Decomprissing the English index..."
tar xvzf index-en.tar.gz
echo "Done"
echo "Decomprissing the Spanish index..."
tar xvzf index-es.tar.gz
echo "Done"

echo "finding pos-en-general-brown.HiddenMarkovModel..."
cd ..
cd $SPOTLIGHTDIR
find . -name "*pos-en-general-brown.HiddenMarkovModel*"
echo "done"
echo "Please change the server_en.properties and server_es.properties file to correctly point out to the current location of pos-en-general-brown.HiddenMarkovModel"

echo "Installation completed."


