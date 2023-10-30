resource "shoreline_notebook" "imbalanced_data_distribution_in_a_mongodb_sharded_cluster" {
  name       = "imbalanced_data_distribution_in_a_mongodb_sharded_cluster"
  data       = file("${path.module}/data/imbalanced_data_distribution_in_a_mongodb_sharded_cluster.json")
  depends_on = [shoreline_action.invoke_rebalance_mongodb]
}

resource "shoreline_file" "rebalance_mongodb" {
  name             = "rebalance_mongodb"
  input_file       = "${path.module}/data/rebalance_mongodb.sh"
  md5              = filemd5("${path.module}/data/rebalance_mongodb.sh")
  description      = "Rebalance the data across the MongoDB shards"
  destination_path = "/tmp/rebalance_mongodb.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_rebalance_mongodb" {
  name        = "invoke_rebalance_mongodb"
  description = "Rebalance the data across the MongoDB shards"
  command     = "`chmod +x /tmp/rebalance_mongodb.sh && /tmp/rebalance_mongodb.sh`"
  params      = ["COLLECTION","DATABASE","MONGODB_CONNECTION_STRING"]
  file_deps   = ["rebalance_mongodb"]
  enabled     = true
  depends_on  = [shoreline_file.rebalance_mongodb]
}

