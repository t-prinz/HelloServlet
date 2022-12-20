#!/bin/bash

APP_NAME=ROOT
TARGET=11
SOURCE=11

# Remove existing directory

if [ -d target ]
then
  echo "Deleting existing directory"
  rm -rf target
fi

## Remove existing war file

#if [ -f ${APP_NAME}.war ]
#then
#  echo "Removing existing war file"
#  rm ${APP_NAME}.war
#fi

# Create directory structure

echo "Creating directory structure"
mkdir -p target/${APP_NAME}/WEB-INF/classes

# Compile the application; put the class file in a separate directory

echo "Compiling the application"
# -g
javac -nowarn -target ${TARGET} -source ${SOURCE} -encoding UTF-8 -classpath ~/.m2/repository/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar -d target/${APP_NAME}/WEB-INF/classes ../src/main/java/mypkg/HelloServlet.java 

# Copy over the web.xml file

echo "Copying over the web.xml file"
cp ../src/main/webapp/WEB-INF/web.xml target/${APP_NAME}/WEB-INF

# Create the war file

#echo "Creating the war file"

pushd target/${APP_NAME}
jar -cvf ../${APP_NAME}.war .

popd
