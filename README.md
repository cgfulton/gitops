# Getting Started
## Deploy AWS S3 Secret
Add your AWS access key and id to the secret and deploy:
```shell
oc apply -f- <<EOF
---
apiVersion: v1
kind: Namespace
metadata:
  name: xray-demo
spec:
  finalizers:
    - kubernetes
---
apiVersion: v1
kind: Secret
metadata:
  namespace: xray-demo
  name: s3-secret
stringData:
    AWS_ACCESS_KEY_ID: <replace_me>
    AWS_SECRET_ACCESS_KEY: <replace_me>
EOF
```

## Install ArgoCD Applications

Bootstrap the process by installing `openshift-gitops` operator:
```shell
oc apply -f https://raw.githubusercontent.com/cgfulton/gitops/main/openshift/openshift-operators/manual/gitops-operator-subscripiton.yaml
```

## Make ArgoCD a cluster-admin:
```shell
oc adm policy add-cluster-role-to-user cluster-admin \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-application-controller \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-server 
```

## Log into ArgoCD Dashboards

### ArgoCD Dashboard: `git-ops`

#### ArgoCD Route
```shell
oc get route argocd-cluster-server -n openshift-gitops
```

#### Admin Password
```shell
oc get secret argocd-cluster-cluster \
   -n openshift-gitops \
   -ojsonpath='{.data.admin\.password}' | base64 -d
```

### ArgoCD Dashboard: `odh`

#### ArgoCD Route
```shell
oc get route odh-argocd-cluster -n odh
```

#### Admin Password
```shell
oc get secret odh-argocd-cluster \
   -n odh \
   -ojsonpath='{.data.admin\.password}' | base64 -d
```

### ArgoCD Dashboard: `xray-demo`

#### ArgoCD Route
```shell
oc get route xray-demo-argocd-cluster -n xray-demo
```

#### Admin Password
```shell
oc get secret xray-demo-argocd-cluster \
   -n xray-demo \
   -ojsonpath='{.data.admin\.password}' | base64 -d
```

> Log into ArgoCD with the `admin` user with password from the previous step.

## Deploy ArgoCD Applications

Build, validate, and apply the Argo CD applications:
```shell
kustomize build https://github.com/cgfulton/gitops.git?ref=main | oc apply -f- 
```



