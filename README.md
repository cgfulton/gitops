# Bootstrap

1. Install `openshift-gitops` operator
1. Create xray-demo namespace 
1. Install `s3-secret`
1. Make `cluster-argocd-application-controller` cluster-admin
1. Make `argocd-cluster-argocd-server` cluster-admin
1. Print ArgoCD UI `Route`
1. Print ArgoCD admin `password`
1. Install ArgoCD applications
```shell
sh bootstrap.sh
```