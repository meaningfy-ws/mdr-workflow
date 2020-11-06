# Asset publishing life-cycle workflow
This repository provides the enterprise architecture and description of capabilities necessary for the digital transformation of the asset publishing life-cycle workflow.   

# Documents
* The *architectural design* and the detailed deployment specifications are provided in the [Enterprise Architecture document](docs/architecture/enterprise-architecture.pdf). 
* The *enterprise architecture model* is provided in the [Workflow model](docs/workflow-ea.eapx)
* The *technical guide* for installing and runnign the services are provided in the [Installation guide for the asset publishing workflow services](docs/tech-manual/tech-manual.pdf). 


# Repository Structure
* /docs - the documentation specific to this project
* /docs/architecture - the LaTeX source of the enterprise architecture document
* /docs/references - a database of literature references used in the enterprise architecture document and technical user manual 
* /docs/tech-manual - the technical user manual for installing and runnign the services
* /docker -the docker files representing specification and configurations for running the services on a target server
* README.md - this file

# Services and their respective configurations
Please note that the configured values can be changed by modifying the `/docker/.env/` file.

**RDF Differ API**

This service does the heavy lifting. The URL and port are described below, as well as the request timeout:

|Description | Value | Associated variable|
|------------|-------|--------------------|
| URL         |http://rdf-differ-api| RDF_DIFFER_API_LOCATION|
| Port        |4030 | RDF_DIFFER_API_PORT|
| Is in debug mode| True| RDF_DIFFER_DEBUG|
| Web server worker process timeout| 1200 | RDF_DIFFER_GUNICORN_TIMEOUT|

Please note that the URL is only available inside the same Docker containers network and is not visible from the outside. Its purpose is to provide a named way for a service to connect to another service. 

**RDF Differ UI**

This is the user interface over the RDF Differ API.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port        |8030 | RDF_DIFFER_UI_PORT|

The RDF differ user interface will be available on the host machine at the aforementioned default port.

**RDF Differ Fuseki**

This is the triple store that is used by the RDF Differ software package to calculate and store the diffs.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Admin account password | admin | RDF_DIFFER_FUSEKI_ADMIN_PASSWORD|
| User name| admin | RDF_DIFFER_FUSEKI_USERNAME |
| Password | admin | RDF_DIFFER_FUSEKI_PASSWORD|
| Folder where Fuseki stores data | ./data/diff | RDF_DIFFER_FUSEKI_DATA_FOLDER|
| Internal port | 3020 | RDF_DIFFER_FUSEKI_PORT |
| External port | 3030 | |
| Additional arguments passed to JVM | -Xmx2g | RDF_DIFFER_FUSEKI_JVM_ARGS|
| URL| http://rdf-differ-fuseki | RDF_DIFFER_FUSEKI_LOCATION|

Please note that the URL is only available inside the same Docker containers network and is not visible from the outside. Its purpose is to provide a named way for a service to connect to another service.


**RDF Validator API**

This service encapsulates the actual validation engine and exposes its functionality as an API.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 4010 | VALIDATOR_API_PORT|

*NOTE:* When validating SPARQL endpoints, the fully qualified domain name of the machine must be specified. As a consequence, `localhost` will never work.


**RDF Validator UI**

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 8010 | VALIDATOR_UI_PORT|
| URL| http://dev.meaningfy.ws:8010| RDF_VALIDATOR_UI_URL|

*NOTE:* When validating SPARQL endpoints, the fully qualified domain name of the machine must be specified. As a consequence, `localhost` will never work.

**Splash page**

This service displays a generic splash page on the default HTTP port. ???

**Jenkins server**

This service is running a Jenkins automation server, on port 8080, which will enable automation of complex processing tasks by aggregating them into processing pipelines.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 8080 | JENKINS_UI_PORT|
| Agents' port| 50000| JENKINS_AGENTS_PORT|


**LinkedPipes ETL storage**

Storage service for LinkedPipes ETL.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 8063 | LP_ETL_STORAGE_PORT|
| Domain| http://localhost:8060| LP_ETL_DOMAIN|

**LinkedPipes ETL executor**

This is the ETL executor engine for the LinkedPipes package.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 8065 | LP_ETL_EXECUTOR_PORT|
| Domain| http://localhost:8060| LP_ETL_DOMAIN|

**LinkedPipes ETL executor monitor**

This service is the monitor of the ETL executor.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 8061 | LP_ETL_MONITOR_PORT|
| Domain| http://localhost:8060| LP_ETL_DOMAIN|

**LinkedPipes ETL UI**

This is the frontend for the LinkedPipes ETL software package.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Port | 8060 | LP_ETL_PORT|
| Domain| http://localhost:8060| LP_ETL_DOMAIN|

**LinkedPipes Fuseki**

This is the storage engine that is being used by LinkedPipes.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Admin password | admin | LP_ETL_FUSEKI_ADMIN_PASSWORD|
| Additional arguments passed to JVM| -Xmx2g| LP_ETL_FUSEKI_JVM_ARGS|
| Port| 3060| LP_ETL_FUSEKI_PORT|

**RDF Fingerprinter API**

This service is encapsulates the RDF fingerprinter engine and exposes its functionality via an API.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| URL | http://fingerprinter-api | RDF_FINGERPRINTER_API_LOCATION|
| Port| 4020| RDF_FINGERPRINTER_API_PORT|

Please note that the URL is only available inside the same Docker containers network and is not visible from the outside. Its purpose is to provide a named way for a service to connect to another service.

**RDF Fingerprinter UI**

This is the user interface over the RDF fingerprinter API.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| URL | http://fingerprinter-ui | RDF_FINGERPRINTER_UI_LOCATION|
| Port| 8020| RDF_FINGERPRINTER_UI_PORT|

Please note that the URL is only available inside the same Docker containers network and is not visible from the outside. Its purpose is to provide a named way for a service to connect to another service.

**RDF Fingerprinter Fuseki**

This is the storage engine that is being used by RDF Fingerprinter.

|Description | Value | Associated variable|
|------------|-------|--------------------|
| Admin password | admin | RDF_FINGERPRINTER_FUSEKI_ADMIN_PASSWORD|
| Additional arguments for JVM| -Xmx2g| RDF_FINGERPRINTER_FUSEKI_JVM_ARGS|
| External port| 3020 | RDF_FINGERPRINTER_FUSEKI_PORT|
| Internal port| 3030 ||

# Requirements

**Hardware requirements**

At least 16GB of RAM.
At least a 4 core CPU.
At least 64GB of free space.

**Software requirements** 

A Linux distribution having a kernel with a version higher than 5.4.0.

**Ports**

The following ports must be available on the host machine, as they will be bound to by different docker services:

|Port | Service|
|------------|-------|
|4030| RDF Differ API|
|8030| RDF Differ user interface|
|3030| RDF Differ Fuseki storage engine|
|4010| RDF Validator API|
|8010| RDF Validator user interface|
|80| Nginx default landing page|
|8080| Jenkins automation web server user interface|
|50000| Jenkins agents port|
|8063| LinkedPipes ETL storage|
|8065| LinkedPipes executor port|
|8061| LinkedPipes ETL monitor|
|2221, 2222, 2225| LinkedPipes ETL monitor|
|8060| LinkedPipes user interface|
|3060| LinkedPipes ETL Fuseki storage engine|
|4020| RDF Fingerprinter API|
|8020| RDF Fingerprinter user interface|
|3020| RDF Fingerprinter Fuseki storage engine|


# Deployment

**Install the Docker engine**

 Please follow the official instructions located here https://docs.docker.com/engine/install/ubuntu/
 
 
 
**Install Docker compose**

Please follow the official instructions located here https://docs.docker.com/compose/install/



**Clone the mdr-workflow repository to your target machine**
 
 Open a shell and paste the following line, then press <*Enter*>:

`git clone https://github.com/meaningfy-ws/mdr-workflow.git`
 


**Download the docker images and start the containers**

In the same shell, navigate to the repository "mdr-workflow" (where Git cloned the repository).


Please use the `make set-linekdpipes-etl-configurations` to prepare the LinkedPipes ETL configuration (this step is **mandatory**)

After the previous command has completed successfully, please run `make start-services` in the shell window.


# Contributing
You are more than welcome to help expand and mature this project. 

When contributing to this repository, please first discuss the change you wish to make via issue, email, or any other method with the owners of this repository before making a change.

Please note we adhere to [Apache code of conduct](https://www.apache.org/foundation/policies/conduct), please follow it in all your interactions with the project.  

# Licence 

The documents, such as reports and specifications, available in the /doc folder, are licenced under a [CC BY 4.0 licence](https://creativecommons.org/licenses/by/4.0/deed.en).

The scripts (stylesheets) and other executables are licenced under [GNU GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) licence.
