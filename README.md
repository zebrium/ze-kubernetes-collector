# ze-kubernetes-collector
## Installation

The commands below install Zebrium log collector as a Kubernetes DaemonSet. It runs one collector instance on each node in a Kubernetes cluster.

1. `kubectl create secret generic zlog-collector-config --from-literal=log-collector-url=<ZEBRIUM_API_URL> --from-literal=auth-token=<AUTH_TOKEN>`
2. `kubectl create -f https://raw.githubusercontent.com/zebrium/zlog-collector/master/zlog-collector.yaml`

After a few minutes, logs should be viewable on Zebrium web UI.

## Configuration
You can add labels to your application to provide application information so Zebrium UI can display them. By default Zebrium log collector uses the following three labels to get software and test information from pods:
1. `zebrium.com/branch`: branch of application software
2. `zebrium.com/build`: build of application software

## Environment variables
<table>
  <tr>
    <th>Environment Variable</th>
    <th>Description</th>
    <th>Default Value</th>
  </tr>
  <tr>
    <td>ZE_LABEL_BRANCH</td>
    <td>Kubernetes pod label name of software branch</td>
    <td>zebrium.com/branch</td>
  </tr>
  <tr>
    <td>ZE_LABEL_BUILD</td>
    <td>Kubernetes pod label name for software build</td>
    <td>zebrium.com/build</td>
  </tr>
  <tr>
    <td>CONTAINER_LOGS_PATH</td>
    <td>Path to Kubernetes container log directory </td>
    <td>/var/log/containers/*.log</td>
  </tr>
  <tr>
    <td>EXCLUDE_NAMESPACE_REGEX</td>
    <td>Regular expression of name spaces to be excluded from log collecting</td>
    <td>&quot;&quot;</td>
  </tr>
  <tr>
    <td>EXCLUDE_POD_REGEX</td>
    <td>Regular expression of pods to be excluded from log collecting</td>
    <td>&quot;&quot;</td>
  </tr>
</table>
