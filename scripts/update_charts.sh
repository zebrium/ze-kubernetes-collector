cd ../charts
version=`cat zlog-collector/Chart.yaml | awk '/version: / { print $2 }'`
helm package zlog-collector
cd ..
helm serve --repo-path ./charts --url https://github.com/zebrium/ze-kubernetes-collector/releases/download/$version
