cd ../charts
helm package zlog-collector
cd ..
helm serve --repo-path ./charts --url https://github.com/zebrium/ze-kubernetes-collector/releases/download/1.45.2
