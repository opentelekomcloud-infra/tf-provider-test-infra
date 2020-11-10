terraform {
  required_providers {
    opentelekomcloud = {
      source  = "opentelekomcloud/opentelekomcloud"
      version = "~> 1.21.2"
    }
  }
  backend swift {
    container = "tf-provider-otc-acceptance"
  }
  required_version = ">= 0.13"
}

provider opentelekomcloud {}
