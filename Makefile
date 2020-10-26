
BUILD_PRINT = \e[1;34mSTEP: \e[0m

#-----------------------------------------------------------------------------
# Basic commands
#-----------------------------------------------------------------------------

install-dev:
	@ echo "$(BUILD_PRINT)Installing the development requirements"
	@ pip install --upgrade pip
	@ pip install -r requirements/dev.txt
	@ sudo cp requirements/chromedriver /usr/bin
	@ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb

test:
	@ echo "$(BUILD_PRINT)Running the tests"
	@ pytest

#-----------------------------------------------------------------------------
# Development environment
#-----------------------------------------------------------------------------

build-linkedpipes:
	@ echo -e '$(BUILD_PRINT)Building the linked pipes images'
	@ docker-compose --file docker/linkedpipes-etl/docker-compose.yml --env-file docker/.env build

start-linkedpipes:
	@ echo -e '$(BUILD_PRINT)Building the linked pipes images'
	@ docker-compose --file docker/linkedpipes-etl/docker-compose.yml --env-file docker/.env up -d


#build-dev:
#	@ echo -e '$(BUILD_PRINT)Building the dev container'
#	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev build
#
#run-dev:
#	@ echo -e '$(BUILD_PRINT)Starting the dev services'
#	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev up -d
#
#stop-dev:
#	@ echo -e '$(BUILD_PRINT)Stopping the dev services'
#	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev down
#
#

#-----------------------------------------------------------------------------
# Fuseki related commands
#-----------------------------------------------------------------------------

run-fuseki:
	@ echo "$(BUILD_PRINT)Starting Fuseki on port $(if $(FUSEKI_PORT),$(FUSEKI_PORT),'default port')"
	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev up --build -d fuseki

stop-fuseki:
	@ echo "$(BUILD_PRINT)Stopping Fuseki"
	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev down

fuseki-create-test-dbs:
	@ echo "$(BUILD_PRINT)Building dummy "subdiv" and "abc" datasets at http://localhost:$(if $(FUSEKI_PORT),$(FUSEKI_PORT),unknown port)/$$/datasets"
	@ sleep 5
	@ curl --anyauth --user 'admin:admin' -d 'dbType=mem&dbName=subdiv'  'http://localhost:$(FUSEKI_PORT)/$$/datasets'
	@ curl --anyauth --user 'admin:admin' -d 'dbType=mem&dbName=abc'  'http://localhost:$(FUSEKI_PORT)/$$/datasets'

run-fuseki-dirty: run-fuseki fuseki-create-test-dbs

#-----------------------------------------------------------------------------
