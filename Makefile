
BUILD_PRINT = \e[1;34mSTEP: \e[0m

#-----------------------------------------------------------------------------
# Basic commands
#-----------------------------------------------------------------------------

install:
	@ echo "$(BUILD_PRINT)Installing the development requirements"
	@ pip install --upgrade pip
	@ pip install -r requirements/dev.txt
	@ sudo cp requirements/chromedriver /usr/bin
	@ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && sudo dpkg -i google-chrome-stable_current_amd64.deb

test:
	@ echo "$(BUILD_PRINT)Running the tests"
	@ pytest


build-linkedpipes:
	@ echo -e '$(BUILD_PRINT)Building the linked pipes images'
	@ docker-compose --file docker/linkedpipes-etl/docker-compose.yml --env-file docker/.env build

start-linkedpipes:
	@ echo -e '$(BUILD_PRINT)Building the linked pipes images'
	@ docker-compose --file docker/linkedpipes-etl/docker-compose.yml --env-file docker/.env up -d


start-services:
	@ docker-compose --file docker/docker-compose.yml --env-file docker/.env up

stop-services:
	@ docker-compose --file docker/docker-compose.yml --env-file docker/.env down