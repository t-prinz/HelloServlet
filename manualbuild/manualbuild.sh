#!/bin/bash

# Remove existing directory

if [ -d WEB-INF ]
then
  echo "Deleting existing directory"
  rm -rf WEB-INF
fi

# Create directory structure

echo "Creating directory structure"
mkdir -p WEB-INF/classes

# Compile the application; put the class file in a separate directory

javac -classpath ~/.m2/repository/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar -d WEB-INF/classes ../src/main/java/mypkg/HelloServlet.java 

# Copy over the web.xml file

cp ../src/main/webapp/WEB-INF/web.xml WEB-INF

# Create the war file

jar -cvf ./HelloServletManual.war WEB-INF
#jar -cvf ./ROOT.war WEB-INF
