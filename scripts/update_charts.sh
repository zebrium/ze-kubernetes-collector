cd ..
#helm repo index zlog-collector --url  https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/
cd ./charts
helm package zlog-collector
cd ..
#helm serve --repo-path ./charts --url https://raw.githubusercontent.com/zebrium/ze-kubernetes-collector/master/charts
helm serve --repo-path ./charts --url https://github.com/zebrium/ze-kubernetes-collector/releases/download/1.39.0
