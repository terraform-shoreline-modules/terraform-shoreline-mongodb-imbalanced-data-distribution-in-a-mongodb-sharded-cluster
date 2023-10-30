terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "imbalanced_data_distribution_in_a_mongodb_sharded_cluster" {
  source    = "./modules/imbalanced_data_distribution_in_a_mongodb_sharded_cluster"

  providers = {
    shoreline = shoreline
  }
}