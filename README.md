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
oc login -u <username> -p <password> <url>
```

Build and validate kustomization target from a URL:
```console
kustomize build <url>
```

Apply resources from a URL containing kustomization.yaml:
```console
oc apply -k <url>
```

## Log into Argo CD dashboard
Argo CD upon installation generates an initial password for the username admin which is stored in a Kubernetes secret. 
Run the following command to decrypt the admin password:
```
oc get secret argocd-cluster-cluster -n openshift-gitops -ojsonpath='{.data.admin\.password}' | base64 -d
```