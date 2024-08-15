# LOADING ENV FILE
-include .env

# DEFAULT VARIABLES
START_LOG = @echo "==================== START OF LOG ===================="
END_LOG = @echo "==================== END OF LOG ======================"

define deploy_dapp
	$(START_LOG)
	@OUTPUT=$$(cast send $(SELF_HOSTED_APPLICATION_FACTORY_ADDRESS) "deployContracts(address,address,bytes32,bytes32)" \
		$(AUTHORITY_OWNER_ADDRESS) \
		$(DAPP_OWNER_ADDRESS) \
		$(TEMPLATE_HASH) \
		0x000000000000000000000000000000000000000000000000000000000000090c \
		--rpc-url $(RPC_URL) --private-key $(PRIVATE_KEY) 2>&1); \
		if echo "$$OUTPUT" | grep -q "failed to estimate gas: message execution failed: exit 33"; then \
			echo "Failed to deploy the dapp. This happened because you are doing a deterministic deployment, \nwith the same salt number and for the same template hash at the same network.\nPlease, change the salt number if you are trying to deploy the same dapp"; \
		else \
			echo "$$OUTPUT"; \
		fi
	$(END_LOG)
endef

.PHONY: setup
setup: .env.tmpl
	@cp .env.tmpl .env

.PHONY: dapp
dapp:
	@echo "Deploying dapp..."
	@$(deploy_dapp)