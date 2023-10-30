
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Imbalanced data distribution in a MongoDB sharded cluster.
---

This incident type occurs when a MongoDB sharded cluster experiences an imbalance in the distribution of data across its shards. Sharding is a method of horizontally partitioning data across multiple servers to improve performance and scalability. However, if the distribution of data is uneven, it can lead to slower queries and poor performance. This can happen due to a variety of reasons, such as uneven data growth, uneven write patterns, or improper shard key selection. It is important to monitor and rebalance the data distribution periodically to ensure optimal performance.

### Parameters
```shell
export HOSTNAME="PLACEHOLDER"

export PORT="PLACEHOLDER"

export MONGODB_CONNECTION_STRING="PLACEHOLDER"

export DATABASE="PLACEHOLDER"

export COLLECTION="PLACEHOLDER"
```

## Debug

### Check the status of the MongoDB sharded cluster
```shell
mongo --host ${HOSTNAME} --port ${PORT} --eval "sh.status()"
```

### Check the status of the individual MongoDB shards
```shell
mongo --host ${HOSTNAME} --port ${PORT} --eval "sh.status({verbose:true})"
```

### Check the distribution of data across MongoDB shards
```shell
mongo --host ${HOSTNAME} --port ${PORT} --eval "db.collection.getShardDistribution()"
```

### Check the amount of data stored on each MongoDB shard
```shell
mongo --host ${HOSTNAME} --port ${PORT} --eval "db.collection.totalSize()"
```

## Repair

### Rebalance the data across the MongoDB shards
```shell
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


```