# install the openshift-gitops operator
oc apply -k "https://raw.githubusercontent.com/cgfulton/gitops/main/openshift/openshift-operators/manual/gitops-operator-subscripiton.yaml"

# Make Argocd cluster admin
oc adm policy add-cluster-role-to-user cluster-admin \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-application-controller \
       system:serviceaccount:openshift-gitops:argocd-cluster-argocd-server

# ArgoCD Route
oc get route odh-argocd-cluster -n odh

# Admin Password
oc get secret odh-argocd-cluster \
   -n odh \
   -ojsonpath='{.data.admin\.password}' | base64 -d

# Deploy Applicaitons
# kustomize build https://github.com/cgfulton/gitops.git?ref=main | oc apply -f-
