# Description #
A Fitness Tracking web application built with Java and JSP utilising JSON serialisation for data storage. Project developed as a group, programming was done as a pair between Sophie and Ben, all commits from either should be treated as the pair.

---

# Requirements #
* Java RE 8.x
* Java JDK 12.x
* NetBeans 11.x
* Apache Tomcat 9.x

*Developed and tested on Windows 10 with NetBeans, deployment on other platforms should be possible but is untested.*

---

# Usage #
1. Install the requirements listed above, upon completing Tomcat installation **do not** start the server.
2. Navigate to the server config location (`C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf`) and open the `tomcat-users.xml` file. At the bottom of this file, before the closing `</tomcat-users>` tag, append the line `<user username="admin" password="password" roles="manager-script"/>`. The username and password are arbitrary, but must be noted for later use.
3. Open the `FitnessApp/` project within NetBeans, **make sure to run NetBeans as an administrator, else the project will not deploy**, install any necessary requirements as prompted.
4. You should be prompted to add missing server, start the wizard by right-clicking on the project, then follow the configuration options for Tomcat. Paths for server location can be found within the `Configure Tomcat` shortcut in the start menu. The server location should default to `C:\Program Files\Apache Software Foundation\Tomcat 9.0`. Username and password should be set to the values chosen in step 2.
5. You should now be able to deploy and access the web app at `http://localhost:8080/FitnessApp/`

*In order to access full functionality, including food and activity data, move the contents of the `TomcatData/` folder to the server location (`C:\Program Files\Apache Software Foundation\Tomcat 9.0`).*