#!/bin/bash

PS3='Select OpenShift Version: '
options=("4.5" "4.6" "4.7")
select opt in "${options[@]}"
do
    case $opt in
        "4.5")
            VERSION=$opt
            break
            ;;
        "4.6")
            VERSION=$opt
            break
            ;;
        "4.7")
            VERSION=$opt
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

read -p 'AWS Access Key: ' AWS_ACCESS_KEY_ID
read -sp 'AWS Secret Access Key: ' AWS_SECRET_ACCESS_KEY

# install the openshift-gitops operator
oc apply -k ./overlays/${VERSION}/operators/openshift-gitops/subscripiton.yaml

# Create demo directory and secret
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
    AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
    AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
EOF

# Make Argocd cluster admin
oc adm policy add-cluster-role-to-user cluster-admin \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-application-controller \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-server

# ArgoCD Route
oc get route odh-argocd-cluster -n openshift-gitops

# Admin Password
oc get secret odh-argocd-cluster argocd-cluster-cluster -n openshift-gitops \
   -ojsonpath='{.data.admin\.password}' | base64 -d

# Deploy Applications
kustomize build | oc apply -f-
