IXA-EHU-DBpedia-spotlight
=========================

This repository contains all the required files to personalise the spotlight to be used within OpeNER

** Requirements: **

Java 1.7
Scala 2.9+
Maven 3

### 1 Download this repository

git clone git@github.com:ialdabe/IXA-EHU-DBpedia-spotlight.git

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

   This command creates:
   - a jar containing all the necessary classes to run the dbpedia-spotlight with all the required dependencies
     This jar is obtained with two purposes: a) to run the server, and b) to be used by other programs 
   - a debian distribution

5) spotter.dict



### 3 Install the modified dbpedia spotlight

### 
