#!/bin/bash


cd WEB-INF

javac -cp lib/javax.servlet-api-3.1.0.jar -d classes src/mypkg/HelloServlet.java

cd ..

jar -cvf deployments/ROOT.war WEB-INF/classes WEB-INF/web.xml README.md LICENSE

