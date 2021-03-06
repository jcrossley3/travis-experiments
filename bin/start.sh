#!/bin/bash

if [ "$CI" = "true" ]; then
  exec minikube start --memory=8192 --cpus=4 \
       --kubernetes-version=v1.10.0 \
       --vm-driver=none \
       --bootstrapper=localkube \
       --extra-config=controller-manager.cluster-signing-cert-file="/var/lib/localkube/certs/ca.crt" \
       --extra-config=controller-manager.cluster-signing-key-file="/var/lib/localkube/certs/ca.key" \
       --extra-config=apiserver.admission-control="DenyEscalatingExec,LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"
else
  exec minikube start --memory=8192 --cpus=4 \
       --kubernetes-version=v1.10.4 \
       --vm-driver=kvm2 \
       --bootstrapper=kubeadm \
       --extra-config=controller-manager.cluster-signing-cert-file="/var/lib/localkube/certs/ca.crt" \
       --extra-config=controller-manager.cluster-signing-key-file="/var/lib/localkube/certs/ca.key" \
       --extra-config=apiserver.admission-control="DenyEscalatingExec,LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"
fi
