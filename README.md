# ze-kubernetes-collector
## Features
* Two step deployment using Kubernetes commands
* Sends logs from all Pods/Containers in a Kubernetes clusters
* Runs a single instance of the collector per node in a Kubernetes cluster

## Getting Started
##### Installing via kubectl
The commands below install Zebrium log collector as a Kubernetes DaemonSet. It runs one collector instance on each node in a Kubernetes cluster.

1. `kubectl create secret generic zlog-collector-config --from-literal=log-collector-url=YOUR_ZE_API_URL --from-literal=auth-token=YOUR_ZE_API_AUTH_TOKEN`
2. `kubectl create -f https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/templates/zlog-collector.yaml`

After a few minutes, logs should be viewable on Zebrium web UI.

The commands above install zlog-collector in default namespace. To install it in a separate namespace, follow the folowing instructions:

1. `kubectl create namespace <new_namespace_name>`. Replace `<new_namespace_name>` with your real namespace name.
2. `kubectl create secret generic zlog-collector-config --from-literal=log-collector-url=YOUR_ZE_API_URL --from-literal=auth-token=YOUR_ZE_API_AUTH_TOKEN --namespace <new_namespace_name>`
3. `wget https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/templates/zlog-collector.yaml`
4. Edit the downloaded `zlog-collector.yaml`, change `namespace: default` in the file to `namespace: <new_namespace_name>` (on one line).
5. `kubectl create -f zlog-collector.yaml --namespace <new_namespace_name>`

##### Installing via helm

###### helm version 2
1. `helm install --namespace zebrium  --name zlog-collector --set zebrium.deployment=YOUR_DEPLOYMENT_NAME,zebrium.collectorUrl=YOUR_ZE_API_URL,zebrium.authToken=YOUR_ZE_API_AUTH_TOKEN --repo https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/charts zlog-collector`

###### helm version 3
1. `kubectl create namespace zebrium`
2. `helm install zlog-collector zlog-collector --namespace zebrium --set zebrium.deployment=YOUR_DEPLOYMENT_NAME,zebrium.collectorUrl=YOUR_ZE_API_URL,zebrium.authToken=YOUR_ZE_API_AUTH_TOKEN --repo https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/charts`

## Configuration
No special configuration is required

##### Setup
By default, Zebrium's kubernetes log collector will be deployed to all Nodes in your cluster and collect logs from each container.

Additionally, each log line will have associated meta data from your Kubernetes deployment viewable in the Zebrium UI. This meta data will include:
1. All Kubernetes Identifier tags such as Node, Pod Name and Id, Container Name and Id, Namespace, etc.
2. All Kubernetss Labels
3. All Kubernetes Annotations

## Testing your installation
Once the collector has been deployed in your Kubernetes environment, your logs and anomaly detection will be available in the Zebrium UI.

## Contributors
* Brady Zuo (Zebrium)
