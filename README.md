DevOps CodeAssignment
=====================

This repository contains a sample MVC4 application that we would use to access how would you approach building and deploying a .NET web application in continuous integration environment. 

What is needed to run the application?
=====================================

1. Windows 7 or Windows 2008 machine
2. Visual Studio 2012
2. ASP.NET MVC4
3. NuGet

What is expected?
=================

You are expected to come up with an approach to building and deploying this web application for following environments

1. Locally for developers
2. Remotely on CI box where all the automation tests are run
3. Remotely on UAT box where acceptance testing by client teams happen (this environment may be open for public access)
4. Production environment


Your script should be able to build the application, run the unit tests and then deploy the application remotely with all the configuration settings updated correctly. Assume that site does not exist on the server and you have administrator rights on the server.  

Also keep following guidelines in mind

1. Clearly defined deployment steps
2. Easily extendible
3. Feel free to use any language that will work on Windows Server 2008/2012
4. Give notes for any security consideration 

Configuration Settings
======================

Application has following information stored in the configuration file

1. Username
2. Password


We would like to be able to use different configuration settings for different environments. It is expected that scripts manage this aspect with least manual intervention.