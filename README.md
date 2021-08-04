# KUBERNETES COLLECTOR DETAILS
Zebrium's Kubernetes collector sends logs to Zebrium for automated Anomaly detection.
Our github repository is located [here](https://github.com/zebrium/ze-kubernetes-collector).

# ze-kubernetes-collector
## Features
* Two step deployment using Kubernetes commands
* Sends logs from all Pods/Containers in a Kubernetes clusters
* Runs a single instance of the collector per node in a Kubernetes cluster

## Getting Started

### Installing via helm
#### helm version 3
1. `kubectl create namespace zebrium`
2. `helm install zlog-collector zlog-collector --namespace zebrium --repo https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/charts --set zebrium.collectorUrl=YOUR_ZE_API_URL,zebrium.authToken=YOUR_ZE_API_AUTH_TOKEN,zebrium.deployment=YOUR_DEPLOYMENT_NAME,zebrium.timezone=KUBERNETES_HOST_TIMEZONE`

`KUBERNETES_HOST_TIMEZONE` is the timezone setting on kubernetes host, for example, "UTC" or "America/Los_Angeles". If this option is not provided, default value UTC will be used.

#### helm version 2
1. `helm install --namespace zebrium --name zlog-collector --repo https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/charts zlog-collector --set zebrium.collectorUrl=YOUR_ZE_API_URL,zebrium.authToken=YOUR_ZE_API_AUTH_TOKEN,zebrium.deployment=YOUR_DEPLOYMENT_NAME,zebrium.timezone=KUBERNETES_HOST_TIMEZONE`

`KUBERNETES_HOST_TIMEZONE` is the timezone setting on kubernetes host, for example, "UTC" or "America/Los_Angeles". If this option is not provided, default value UTC will be used.

### Uninstalling via helm

If you used the "helm install" command to install zlog-collector chart, you should use the following command to delete:
```
helm delete --purge zlog-collector
```

### Installing via kubectl
The commands below install the Zebrium log collector as a Kubernetes DaemonSet. It runs one collector instance on each node in a Kubernetes cluster.

1. `kubectl create secret generic zlog-collector-config --from-literal=log-collector-url=YOUR_ZE_API_URL --from-literal=auth-token=YOUR_ZE_API_AUTH_TOKEN`
2. `kubectl create -f https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/templates/zlog-collector.yaml`

After a few minutes, logs should be viewable on Zebrium web UI.

The commands above install zlog-collector in default namespace. To install it in a separate namespace, follow the folowing instructions:

1. `kubectl create namespace <new_namespace_name>`. Replace `<new_namespace_name>` with your real namespace name.
2. `kubectl create secret generic zlog-collector-config --from-literal=log-collector-url=YOUR_ZE_API_URL --from-literal=auth-token=YOUR_ZE_API_AUTH_TOKEN --namespace <new_namespace_name>`
3. `wget https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/templates/zlog-collector.yaml`
4. Edit the downloaded `zlog-collector.yaml`, change `namespace: default` in the file to `namespace: <new_namespace_name>` (on one line).
5. `kubectl create -f zlog-collector.yaml --namespace <new_namespace_name>`

### Uninstalling via kubectl
The commands below will uninstall the Zebrium log collector. This would typically be done prior to installing a newer version of the collector.
```
kubectl delete -f https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/templates/zlog-collector.yaml
kubectl delete secret zlog-collector-config
```
**Note:** You do not have to delete the secret if there is no change in URL and token when installing an upgraded collector.

## Configuration
No special configuration is required

## Tunable Parameters
<table>
  <tr>
    <th>Parameter</th>
    <th>Description</th>
    <th>Default Value</th>
    <th>Note</th>
  </tr>
  <tr>
    <td>zebrium.bufferTotalLimitSize</td>
    <td>Total disk buffer to use on node</td>
    <td>8GB</td>
    <td>Use helm command line option "--set zebrium.bufferTotalLimitSize=BUFFER_SIZE" to set. BUFFER_SIZE is either in MB or GB. For example, "256MB" or "1GB" </td>
  </tr>
  <tr>
    <td>zebrium.flushThreadCount</td>
    <td>The number of threads to flush the buffer.</td>
    <td>4</td>
    <td>If the destination of your logs is remote storage or service, adding a flush_thread_count option will parallelize your outputs (the default is 4). Using multiple threads can hide the IO/network latency </td>
  </tr>
  <tr>
    <td>zebrium.nodeLogsPath</td>
    <td>A list of log files to process.</td>
    <td>/var/log/*.log, /var/log/syslog, /var/log/messages, /var/log/secure</td>
    <td>List must not have spaces.</td>
  </tr>
</table>

### Log Path Mapping
Log path mapping is the process of detecting semantic items in log file paths (ids, configs and tags)
then including them in the Zebrium log data. This is enabled by providing a JSON mapping file to
the log collector, as described in the repo at https://www.github.com/zebrium/ze-fluentd-plugin. To use this functionality with the supplied
helm chart a **customValues.yaml** file should be completed and supplied to the **helm install**
command line with:

```
helm install ... -f customValues.yaml ...
``` 

A prototype customValues.yaml file is provided in the repo, with format:

```
overridePMFConfig: true
zebrium:
  pathMapFile: "pathMapFile.json"
customPMFConfig: {
  "mappings": {
    "patterns":["/var/log/remote_logs/(?<host>[^/]+)/.*"],
    "tags": [],
    "ids" : [
        "host"],
    "configs": []
  }
}
```

### Setup
By default, Zebrium's kubernetes log collector will be deployed to all Nodes in your cluster and collect logs from each container.

Additionally, each log line will have associated meta data from your Kubernetes deployment viewable in the Zebrium UI. This meta data will include:
1. All Kubernetes Identifier tags such as Node, Pod Name and Id, Container Name and Id, Namespace, etc.
2. All Kubernetes Labels
3. All Kubernetes Annotations

## Testing your installation
Once the collector has been deployed in your Kubernetes environment, your logs and anomaly detection will be available in the Zebrium UI.

## Troubleshooting
In the event that Zebrium requires the ze_collector logs for troubleshooting, you can use these commands:
1. Use: `kubectl get pods --namespace zebrium` to get the zlog-collector pod names first.
2. Use: `kubectl logs <pod_name> --namespace zebrium` to get logs. **Note:** There may be multiple pods containing logs.

## Contributors
* Brady Zuo (Zebrium)
* Braeden Earp (Zebrium)
* Rob Fair (Zebrium)
