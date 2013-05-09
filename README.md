IXA-EHU-DBpedia-spotlight
=========================

This repository contains all the required files to personalise the spotlight to be used within OpeNER

** Requirements: **

Java 1.7
Scala 2.9+
Maven 3

### 1 Download this repository

git clone git@github.com:ialdabe/IXA-EHU-DBpedia-spotlight.git
OR
git clone  git://github.com/ialdabe/IXA-EHU-DBpedia-spotlight.git

The command will create a directory called
IXA-EHU-DBpedia-spotlight. This repository contains all the necessary
information to create a modified version of the dbpedia spotlight. The
modified version is focused on the disambiguation of given entities.

### 2 Run the script 

sh install.sh

The script install.sh obtains the latest version of the dbpedia
spotlight and it modifies some of the files to run "our" version of
the spotlight. It is possible to do it step by step in order to
manually control each step of the process.

Steps: 

1) Download the dbpedia spotlight
   git clone https://github.com/dbpedia-spotlight/dbpedia-spotlight.git

   The latest version of the dbpedia-spotlight is obtained and it is stored in the "dbpedia-spotlight" directory

2) Modify some of the configuration files
   Copy from IXA-EHU-DBpedia-spotlight to dbpedia-spotlight the following files:
   - pom.xml
   - core/pom.xml
   - conf/server_en.properties
   - conf/server_es.properties

   server_en.properties and server_es.properties files contain the necessary information to run two different services: one to work with English and another one to work with Spanish

   The two pom.xml files are modified versions of the original ones to adapt the depedencies to our needs. 

3) Install the dbpedia spotlight
   cd dbpedia-spotlight
   mvn clean install

4) Create a jar to run the dbpedia spotlight as a service
   cd dbpedia-spotlight/dist
   mvn clean package

   This command creates (among others)
   - a jar containing all the necessary classes to run the dbpedia-spotlight with all the required dependencies
     This jar is obtained with two purposes: a) to run the server, and b) to be used by other programs 

   The jar is automatically copied to the bin directory of the
   dbpedia-spotlight. It will be used to run the server and to be used
   by other programs. Be careful, if you move it, be sure to change
   the corresponding paths.
   
5) Set the indexes for the English and Spanish dumps
   mkdir data
   wget 'https://siuc05.si.ehu.es/~ragerri/index-spotlight/index-en.tar.gz'
   wget 'https://siuc05.si.ehu.es/~ragerri/index-spotlight/index-es.tar.gz'

   tar xvzf index-en.tar.gz
   tar xvzf index-es.tar.gz

6) Find the pos-en-general-brown.HiddenMarkovModel

   Although this file is not used, it is necessary to set its locations in the server.properties files to the correct working of the spotlight. 

   Please, change the value manually. 

   The properties files contain the default value:
   
   org.dbpedia.spotlight.tagging.hmm = pos-en-general-brown.HiddenMarkovModel
   
   It is necessary to change the value for the one obtained by the command: 

   find . -name "*pos-en-general-brown.HiddenMarkovModel*"

### 3 Run the servers

    Before runing the servers, verify that the dbpedia-spotlight directory contains:
    * data/index-en directory
    * data/index-es directory
    * the correct location of the pos-en-general-brown.HiddenMarkovModel model
    * bin/dbpedia-spotlight-0.6-jar-with-dependencies.jar 

    If something is missing, go step by step in the install.sh script. 

    Go to the bin directory.

    - Run the server to disambiguate English entities

    java -jar dbpedia-spotlight-0.6-jar-with-dependencies.jar server_en.properties

    - Run the server to disambiguate Spanish entities

    java -jar dbpedia-spotlight-0.6-jar-with-dependencies.jar server_es.properties

   
   The English version works on: http://localhost:2020/rest

   The Spanish version works on: http://localhost:2222/rest

### 4 Testing the system

    curl http://localhost:2020/rest/disambiguate?spotter=SpotXmlParser + 
					"&confidence=" + CONFIDENCE
					+ "&support=" + SUPPORT
		                        + "&text" + text

The system requires the following type of input to disambiguate the given entities:

	<annotation text="Brazilian oil giant Petrobras and U.S. oilfield service company Halliburton have signed a technological cooperation agreement, Petrobras announced Monday. The two companies agreed on three projects: studies on contamination of fluids in oil wells, laboratory simulation of well production, and research on solidification of salt and carbon dioxide formations, said Petrobras. Twelve other projects are still under negotiation.">
	<surfaceForm name="oil" offset="10"/>
	<surfaceForm name="company" offset="56"/>
	<surfaceForm name="Halliburton" offset="64"/>
	<surfaceForm name="oil" offset="237"/>
	<surfaceForm name="other" offset="383"/>
	</annotation>
