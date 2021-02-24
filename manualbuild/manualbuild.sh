#!/bin/bash

# Remove existing directory

if [ -d WEB-INF ]
then
  echo "Deleting existing directory"
  rm -rf WEB-INF
fi

# Remove existing war file

if [ -f HelloServletManual.war ]
then
  echo "Removing existing war file"
  rm HelloServletManual.war
fi

# Create directory structure

echo "Creating directory structure"
mkdir -p WEB-INF/classes

# Compile the application; put the class file in a separate directory

echo "Compiling the application"
javac -g -nowarn -target 1.8 -source 1.8 -encoding UTF-8 -classpath ~/.m2/repository/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar -d WEB-INF/classes ../src/main/java/mypkg/HelloServlet.java 

# Copy over the web.xml file

echo "Copying over the web.xml file"
cp ../src/main/webapp/WEB-INF/web.xml WEB-INF

# Create the war file

echo "Creating the war file"
jar -cvf ./HelloServletManual.war WEB-INF
#jar -cvf ./ROOT.war WEB-INF
