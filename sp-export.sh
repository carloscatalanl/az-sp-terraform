#!/bin/bash

# Set env vars
SUB_ID=$(az account show | jq .id -r)
read -p "Resource Group: " RG_NAME

SERVICE_PRINCIPAL=$(az ad sp create-for-rbac -n 'terraform-sp' --role Owner --scopes /subscriptions/$SUB_ID/resourceGroups/$RG_NAME | jq)

export ARM_SUBSCRIPTION_ID=$SUB_ID
export ARM_TENANT_ID=$(echo $SERVICE_PRINCIPAL | jq .tenant -r)
export ARM_CLIENT_ID=$(echo $SERVICE_PRINCIPAL | jq .appId -r)
export ARM_CLIENT_SECRET=$(echo $SERVICE_PRINCIPAL | jq .password -r)

###
# export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
# export ARM_TENANT_ID="<azure_subscription_tenant_id>"
# export ARM_CLIENT_ID="<service_principal_appid>"
# export ARM_CLIENT_SECRET="<service_principal_password>"
###