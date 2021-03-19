# Getting Started

### Install Operators
1. Install Openshift Operators
   1. amq-streams Operator
      - InstallPlan
      - Subscription
   1. kogito Operator
      - InstallPlan
      - Subscription
   1. opendatahub Operator
      - InstallPlan
      - Subscription
1. Install Openshift Storage Operator
   - OperatorGroup 
   - InstallPlan
   - Subscription  
   - StorageCluster
1. Install Openshift Serverless Operator
   - OperatorGroup
   - InstallPlan
   - Subscription
   - knative-eventing
   - knative-serving
1. Install GitOps Operator
   - OperatorGroup
   - InstallPlan
   - Subscription
 

### Add AWS S3 Secret
```shell
oc apply -f- <<EOF
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

### Install GitOps
Bootstrap the process by installing openshift-gitops operator:
```console
kustomize build https://github.com/cgfulton/gitops/openshift/openshift-gitops/resources?ref=main | oc apply -f-
```

Elevate Argo CD to cluster-admin in the xray-demo namespace:
```console
oc adm policy add-cluster-role-to-user cluster-admin \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-application-controller \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-server 
```

## Log into Argo CD dashboard
Get the Argo CD route:
```console
oc get route argocd-cluster-server -n openshift-gitops
```
Access the generated password for the username admin:
```console
oc get secret argocd-cluster-cluster \
   -n openshift-gitops \
   -ojsonpath='{.data.admin\.password}' | base64 -d
```
Log into Argo CD with `admin` user and the password retrieved from the previous step.

## Deploy XRay Demo
Build, validate, and apply the Argo CD applications:
```console
kustomize build https://github.com/cgfulton/gitops.git?ref=main | oc apply -f- 
```

Looking at the Argo CD dashboard, you would notice that XRay Demo application is deploying.


