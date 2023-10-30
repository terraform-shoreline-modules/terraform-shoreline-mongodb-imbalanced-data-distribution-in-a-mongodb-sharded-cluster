bash

#!/bin/bash



# Set the MongoDB connection string

MONGODB_CONN_STR=${MONGODB_CONNECTION_STRING}



# Enable the balancer if it's not already enabled

mongo $MONGODB_CONN_STR --eval 'sh.setBalancerState(true)'



# Wait for the balancer to finish any ongoing operations

mongo $MONGODB_CONN_STR --eval 'sh.waitForBalancer()'



# Rebalance the data across the shards

mongo $MONGODB_CONN_STR --eval 'sh.rebalanceCollection("${DATABASE}.${COLLECTION}")'



# Disable the balancer once the rebalancing is complete

mongo $MONGODB_CONN_STR --eval 'sh.setBalancerState(false)'