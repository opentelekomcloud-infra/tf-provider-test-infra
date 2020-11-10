#!/usr/bin/env bash

OUTPUT_FILE=outputs.txt

terraform init >/dev/null
terraform apply --auto-approve >/dev/null
terraform output >$OUTPUT_FILE

function get_var() {
  var_name=$1
  grep -oP "(?<=${var_name} = ).+" $OUTPUT_FILE
}

OS_NETWORK_ID=$(get_var network_id)
OS_VPC_ID=$(get_var vpc_id)
OS_SUBNET_ID=$(get_var subnet_id)
OS_IMAGE_ID=$(get_var image_id)
OS_KEYPAIR_NAME=$(get_var keypair_name)
OS_EXTGW_ID=$(get_var external_gw_id)

echo "
# To get environment variables for running terraform accepance tests, run
# eval \$(./env.sh)
#
# Please note that you still have to provide auth variables:
# OS_AUTH_URL, OS_TENANT_NAME, OS_USERNAME, OS_PASSWORD, OS_USER_DOMAIN_NAME, OS_ACCESS_KEY, OS_SECRET_KEY

export OS_NETWORK_ID=$OS_NETWORK_ID
export OS_VPC_ID=$OS_VPC_ID
export OS_SUBNET_ID=$OS_SUBNET_ID
export OS_IMAGE_ID=$OS_IMAGE_ID
export OS_KEYPAIR_NAME=$OS_KEYPAIR_NAME
export OS_KEYPAIR_NAME=$OS_KEYPAIR_NAME
export OS_EXTGW_ID=$OS_EXTGW_ID

export TF_ACC=1
export OS_POOL_NAME=ext_admin_net
export OS_FLAVOR_NAME=s2.large.2
export OS_AVAILABILITY_ZONE=eu-de-03
export OS_FLAVOR_ID=s2.large.2
export OS_DCS_ENVIRONMENT=1

# semicolon-separated list:
# TF_ACC=1;OS_KEYPAIR_NAME=$OS_KEYPAIR_NAME;OS_NETWORK_ID=$OS_NETWORK_ID;OS_VPC_ID=$OS_VPC_ID;OS_SUBNET_ID=$OS_SUBNET_ID;OS_IMAGE_ID=$OS_IMAGE_ID;OS_POOL_NAME=ext_admin_net;OS_FLAVOR_NAME=s2.large.2;OS_AVAILABILITY_ZONE=eu-de-03;OS_EXTGW_ID=$OS_EXTGW_ID;OS_FLAVOR_ID=s2.large.2;OS_DCS_ENVIRONMENT=1;
"
