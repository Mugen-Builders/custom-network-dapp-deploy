# LOADING ENV FILE
-include .env

# DEFAULT VARIABLES
START_LOG = @echo "==================== START OF LOG ===================="
END_LOG = @echo "==================== END OF LOG ======================"

define deploy_dapp
	$(START_LOG)
	@cast send 0x75966108D94b7bc1724421421174Bf57c33c1c94 "deployContracts(address,address,bytes32,bytes32)" \
		$(AUTHORITY_OWNER_ADDRESS) \
		$(DAPP_OWNER_ADDRESS) \
		$(TEMPLATE_HASH) \
		0x000000000000000000000000000000000000000000000000000000000000063c \
		--rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY)
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