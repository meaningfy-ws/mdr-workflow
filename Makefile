.PHONY: test install lint start-services stop-services docker-stop-dev docker-start-dev docker-build-dev


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

build-dev:
	@ echo -e '$(BUILD_PRINT)Building the dev container'
	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev build

run-dev:
	@ echo -e '$(BUILD_PRINT)Starting the dev services'
	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev up -d

stop-dev:
	@ echo -e '$(BUILD_PRINT)Stopping the dev services'
	@ docker-compose --file docker-compose.dev.yml --env-file .env.dev down

populate-fuseki:
	@ python scripts/commands.py

#-----------------------------------------------------------------------------
# Production environment
#-----------------------------------------------------------------------------

build-prod:
	@ echo -e '$(BUILD_PRINT)Building the prod container'
	@ docker-compose --file docker-compose.yml --env-file .env.prod build

run-prod:
	@ echo -e '$(BUILD_PRINT)Starting the prod services'
	@ docker-compose --file docker-compose.yml --env-file .env.prod up -d

stop-prod:
	@ echo -e '$(BUILD_PRINT)Stopping the prod services'
	@ docker-compose --file docker-compose.yml --env-file .env.prod down

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
# Gherkin feature and acceptance test generation commands
#-----------------------------------------------------------------------------

FEATURES_FOLDER = tests/features
STEPS_FOLDER = tests/steps
FEATURE_FILES := $(wildcard $(FEATURES_FOLDER)/*.feature)
EXISTENT_TEST_FILES = $(wildcard $(STEPS_FOLDER)/*.py)
HYPOTHETICAL_TEST_FILES :=  $(addprefix $(STEPS_FOLDER)/test_, $(notdir $(FEATURE_FILES:.feature=.py)))
TEST_FILES := $(filter-out $(EXISTENT_TEST_FILES),$(HYPOTHETICAL_TEST_FILES))

generate-tests-from-features: $(TEST_FILES)
	@ echo "$(BUILD_PRINT)The following test files should be generated: $(TEST_FILES)"
	@ echo "$(BUILD_PRINT)Done generating missing feature files"
	@ echo "$(BUILD_PRINT)Verifying if there are any missing step implementations"
	@ py.test --generate-missing --feature $(FEATURES_FOLDER)

$(addprefix $(STEPS_FOLDER)/test_, $(notdir $(STEPS_FOLDER)/%.py)): $(FEATURES_FOLDER)/%.feature
	@ echo "$(BUILD_PRINT)Generating the testfile "$@"  from "$<" feature file"
	@ pytest-bdd generate $< > $@
	@ sed -i  's|features|../features|' $@

#-----------------------------------------------------------------------------
# Default
#-----------------------------------------------------------------------------
all:
	install test