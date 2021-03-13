# Getting Started

This repository contains a brief Getting Started guide for trying out the xray demo.

* [Install OpenShift GitOps](#install-openshift-gitops)
* [Log into Argo CD dashboard](#log-into-argo-cd-dashboard)
* [Configure OpenShift with Argo CD](#configure-openshift-with-argo-cd)
* [Deploy Applications with Argo CD](#deploy-applications-with-argo-cd)
* [Additional Argo CD instances](#additional-argo-cd-instances)

## Install OpenShift GitOps
Log into OpenShift Console as a cluster admin:
```console
oc login -u opentlc-mgr -p r3dh4t1! <url>
```

Build and validate kustomization target from a URL:
```console
oc apply -f https://raw.githubusercontent.com/cgfulton/gitops/main/openshift-gitops-subscription.yaml
```

## Log into Argo CD dashboard
Argo CD generates an initial admin password:
```console
oc get secret argocd-cluster-cluster -n openshift-gitops -ojsonpath='{.data.admin\.password}' | base64 -d
```

Get the Argo CD route:
```console
oc get route argocd-cluster-server
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

Looking at the Argo CD dashboard, you would notice that Argo CD applications.
