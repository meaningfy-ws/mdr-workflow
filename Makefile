
BUILD_PRINT = \e[1;34mSTEP: \e[0m

#-----------------------------------------------------------------------------
# Basic commands
#-----------------------------------------------------------------------------

install:
	@ echo "$(BUILD_PRINT)Installing the development requirements"
	@ pip install --upgrade pip
	@ pip install -r requirements/dev.txt
	@ sudo requirements/install_chrome_and_driver.sh

test:
	@ echo "$(BUILD_PRINT)Running the tests"
	@ pytest

set-linekdpipes-etl-configurations:
	@ echo "$(BUILD_PRINT)Setting configuration for LinkedPipes ETL"
	@ docker rm temp | true
	@ docker volume rm linkedpipes-configuration | true
	@ docker volume create linkedpipes-configuration
	@ docker container create --name temp -v linkedpipes-configuration:/data busybox
	@ docker cp ./docker/linkedpipes-etl/configuration/configuration.properties temp:/data
	@ docker rm temp

start-services: set-linekdpipes-etl-configurations
	@ echo "$(BUILD_PRINT)Starting the Docker compose services"
	@ docker-compose --file docker/docker-compose.yml --env-file docker/.env up -d

stop-services:
	@ echo "$(BUILD_PRINT)Stopping the Docker compose services"
	@ docker-compose --file docker/docker-compose.yml --env-file docker/.env down

#-----------------------------------------------------------------------------
# Template commands
#-----------------------------------------------------------------------------
build-template-volumes:
	@ docker volume create rdf-differ-template

differ-set-report-template:
	@ [ "$(location)" ] || ( echo ">> template 'location' is not set"; exit 1 )
	@ echo "$(BUILD_PRINT)Copying custom differ template"
	@ docker rm temp | true
	@ docker volume rm rdf-differ-template | true
	@ docker volume create rdf-differ-template
	@ docker container create --name temp -v rdf-differ-template:/data busybox
	@ docker cp $(location). temp:/data
	@ docker rm temp
