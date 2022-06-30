## --------------------------------------------------------------------------------------
## This makefile deals with all the calls needed for setting up & managing infrastructure
## --------------------------------------------------------------------------------------

RESOURCE_GROUP_NAME=tstate
OPS_STORAGE_ACCOUNT_NAME_=opsucantstate
STAGING_STORAGE_ACCOUNT_NAME_=stagingucantstate
PRODUCTION_STORAGE_ACCOUNT_NAME_=productionucantstate
LOCATION = westeurope
OPS_SUBSCRIPTION_ID = 7a0a0e4d-11b6-4962-90e5-f8150df63af4
STAGING_SUBSCRIPTION_ID = 62724847-f02e-4f3e-80ee-449b3e617694
PRODUCTION_SUBSCRIPTION_ID = 80104cab-4bf1-4255-91df-e26dc9b47ed4
OPS_CONTAINER_NAME = terraform-ops
STAGING_CONTAINER_NAME = terraform-staging
PRODUCTION_CONTAINER_NAME = terraform-production


# Read variables from .env:
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

help: ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

init-ops: ## Prepare working directory for commands on ops subscription.
.PHONY: init-ops
init-ops: set-ops-subscription
	cd environments/ops; terraform init

init-staging: ## Prepare working directory for commands on staging subscription.
.PHONY: init-staging
init-staging: set-staging-subscription
	cd environments/staging; terraform init

init-production: ## Prepare working directory for commands on production subscription.
.PHONY: init-production
init-production: set-production-subscription
	cd environments/production; terraform init

validate-staging: ## Check whether the configuration is valid for staging subscription.
.PHONY: validate-staging
validate-staging: set-staging-subscription
	cd environments/staging; terraform validate

validate-production: ## Check whether the configuration is valid for production subscription.
.PHONY: validate-production
validate-production: set-production-subscription
	cd environments/production; terraform validate

plan-staging: ## Show changes required by the current staging subscription configuration.
.PHONY: plan-staging
plan-staging: set-staging-subscription
	cd environments/staging; terraform plan

plan-ops: ## Show changes required by the current ops subscription configuration.
.PHONY: plan-ops
plan-ops: set-ops-subscription
	cd environments/ops; terraform plan

plan-production: ## Show changes required by the current production subscription configuration.
.PHONY: plan-production
plan-production: set-production-subscription
	cd environments/production; terraform plan

apply-ops: ## Create or update infrastructure for ops subscription.
.PHONY: apply-ops
apply-ops: set-ops-subscription
	cd environments/ops; terraform apply

apply-staging: ## Create or update infrastructure for staging subscription.
.PHONY: apply-staging
apply-staging: set-staging-subscription
	cd environments/staging; terraform apply

apply-production: ## Create or update infrastructure for production subscription.
.PHONY: apply-production
apply-production: set-production-subscription
	cd environments/production; terraform apply

destroy-staging: ## Destroy previously-created infrastructure on staging subscription.
.PHONY: destroy-staging
destroy-staging: set-staging-subscription
	cd environments/staging; terraform destroy

destroy-production: ## Destroy previously-created infrastructure on production subscription.
.PHONY: destroy-production
destroy-production: set-production-subscription
	cd environments/production; terraform destroy

destroy-ops: ## Destroy previously-created infrastructure on ops subscription.
.PHONY: destroy-ops
destroy-ops: set-ops-subscription
	cd environments/ops; terraform destroy

setup-ops-state-storage: ## Create staging resource storing resources & account.
.PHONY: setup-ops-state-storage
setup-ops-state-storage:
	./bin/create-storage-account $(RESOURCE_GROUP_NAME) $(OPS_STORAGE_ACCOUNT_NAME_) $(OPS_CONTAINER_NAME) $(LOCATION) $(OPS_SUBSCRIPTION_ID)

setup-staging-state-storage: ## Create staging resource storing resources & account.
.PHONY: setup-staging-state-storage
setup-staging-state-storage:
	./bin/create-storage-account $(RESOURCE_GROUP_NAME) $(STAGING_STORAGE_ACCOUNT_NAME_) $(STAGING_CONTAINER_NAME) $(LOCATION) $(STAGING_SUBSCRIPTION_ID)

setup-production-state-storage: ## Create production resource storing resources & account.
.PHONY: setup-production-state-storage
setup-production-state-storage:
	./bin/create-storage-account $(RESOURCE_GROUP_NAME) $(PRODUCTION_STORAGE_ACCOUNT_NAME_) $(PRODUCTION_CONTAINER_NAME) $(LOCATION) $(PRODUCTION_SUBSCRIPTION_ID)

delete-state-storage-staging: ## Delete all terraform storing resources & accounts.
.PHONY: delete-state-storage-staging
delete-state-storage-staging: set-staging-subscription
	./bin/delete-storage-accounts $(RESOURCE_GROUP_NAME)

delete-state-storage-ops: ## Delete all terraform storing resources & accounts.
.PHONY: delete-state-storage-ops
delete-state-storage-ops: set-ops-subscription
	./bin/delete-storage-accounts $(RESOURCE_GROUP_NAME)

delete-state-storage-production: ## Delete all terraform storing resources & accounts.
.PHONY: delete-state-storage-production
delete-state-storage-production: set-production-subscription
	./bin/delete-storage-accounts $(RESOURCE_GROUP_NAME)

.PHONY: set-ops-subscription
set-ops-subscription:
	./bin/set-subscription $(OPS_SUBSCRIPTION_ID)

.PHONY: set-staging-subscription
set-staging-subscription:
	./bin/set-subscription $(STAGING_SUBSCRIPTION_ID)

.PHONY: set-production-subscription
set-production-subscription:
	./bin/set-subscription $(PRODUCTION_SUBSCRIPTION_ID)