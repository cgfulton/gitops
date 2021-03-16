# Getting Started

This repository contains a brief Getting Started guide for trying out the xray demo.

* [Install OpenShift GitOps](#install-openshift-gitops)
* [Log into Argo CD dashboard](#log-into-argo-cd-dashboard)
* [Configure OpenShift with Argo CD](#configure-openshift-with-argo-cd)
* [Deploy Applications with Argo CD](#deploy-applications-with-argo-cd)

## Install OpenShift GitOps
Log into OpenShift Console as a cluster admin:
```console
oc login -u opentlc-mgr -p r3dh4t1! <url>
```

Bootstrap the process by installing openshift-gitops:
```console
kustomize build https://github.com/cgfulton/gitops/openshift-gitops/resources?ref=main | oc apply -f-
```

Elevate `argocd-cluster-argocd-application-controller` to cluster-admin in the xray-demo namespace:
```console
oc adm policy add-cluster-role-to-user cluster-admin \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-application-controller \
       -n xray-demo
```

## Log into Argo CD dashboard
Argo CD generates an initial admin password:
```console
oc get secret argocd-cluster-cluster \
   -n openshift-gitops \
   -ojsonpath='{.data.admin\.password}' | base64 -d
```

Get the Argo CD route:
```console
oc get route argocd-cluster-server -n openshift-gitops
```

Log into Argo CD with `admin` username and the password retrieved from the previous step.

## Deploy XRay Demo

Build and validate kustomization target from a URL:
```console
kustomize build https://github.com/cgfulton/gitops.git
```

Apply resources from a URL containing kustomization.yaml:
```console
oc apply -k https://github.com/cgfulton/gitops.git
```

Looking at the Argo CD dashboard, you would notice that XRay Demo application is deploying.
