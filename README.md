# ze-kubernetes-collector
## Features
* Two step deployment using Kubernetes commands
* Sends logs from all Pods/Containers in a Kubernetes clusters
* Runs a single instance of the collector per node in a Kubernetes cluster

## Getting Started
##### Installing
The commands below install Zebrium log collector as a Kubernetes DaemonSet. It runs one collector instance on each node in a Kubernetes cluster.

1. `kubectl create secret generic zlog-collector-config --from-literal=log-collector-url=https://YOUR_ZE_API_INSTANCE_NAME.zebrium.com --from-literal=auth-token=YOUR_ZE_API_AUTH_TOKEN`
2. `kubectl create -f https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/templates/zlog-collector.yaml`

After a few minutes, logs should be viewable on Zebrium web UI.

## Configuration
No special configuration is required

##### Setup
By default, Zebrium's kubernetes log collector will be deployed to all Nodes in your cluster and collect logs from each container.

Additionally, each log line will have associated meta data from your Kubernetes deployment viewable in the Zebrium UI. This meta data will include:
1. All Kubernetes Identifier tags such as Node, Pod Name and Id, Container Name and Id, Namespace, etc..
2. All Kubernetss Labels
3. All Kubernetes Annotations

## Testing your installation
Once the collector has been deployed in your Kubernetes environment, your logs and anomaly detection will be available in the Zebrium UI.

## Contributors
* Brady Zuo (Zebrium)
