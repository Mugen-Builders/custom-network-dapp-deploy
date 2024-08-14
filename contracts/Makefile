# LOADING ENV FILE
-include .env

# DEFAULT VARIABLES
START_LOG = @echo "==================== START OF LOG ===================="
END_LOG = @echo "==================== END OF LOG ======================"

define deploy_dapp
	$(START_LOG)
	@forge script script/DeployDapp.s.sol --rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) --broadcast -vvv
	$(END_LOG)
endef

.PHONY: setup
setup: .env.tmpl
	@forge install
	@cp .env.tmpl .env

.PHONY: dapp
dapp:
	@echo "Deploying dapp..."
	@$(deploy_dapp)