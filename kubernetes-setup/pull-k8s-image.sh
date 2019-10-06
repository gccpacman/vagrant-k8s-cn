#!/bin/bash
set -e

KUBE_VERSION=v1.14.7
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.3.10
CORE_DNS_VERSION=1.3.1

GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/google_containers

images=(kube-proxy:${KUBE_VERSION}
kube-scheduler:${KUBE_VERSION}
kube-controller-manager:${KUBE_VERSION}
kube-apiserver:${KUBE_VERSION}
pause:${KUBE_PAUSE_VERSION}
etcd:${ETCD_VERSION}
coredns:${CORE_DNS_VERSION})

for imageName in ${images[@]} ; do
  docker pull $ALIYUN_URL/$imageName
  docker tag  $ALIYUN_URL/$imageName $GCR_URL/$imageName
  docker rmi $ALIYUN_URL/$imageName
done

HELM_TILLER_VERSION=v2.14.3
HELM_TILLER_ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/google_containers/tiller:${HELM_TILLER_VERSION}
HELM_TILLER_URL=gcr.io/kubernetes-helm/tiller:${HELM_TILLER_VERSION}

docker pull $HELM_TILLER_ALIYUN_URL
docker tag $HELM_TILLER_ALIYUN_URL $HELM_TILLER_URL
docker rmi $HELM_TILLER_ALIYUN_URL

DEFAULT_BACKEND_VERSION=1.5
DEFAULT_BACKEND_IMAGE_NAME=defaultbackend-amd64:${DEFAULT_BACKEND_VERSION}
docker pull gotok8s/${DEFAULT_BACKEND_IMAGE_NAME}
docker tag gotok8s/${DEFAULT_BACKEND_IMAGE_NAME} ${GCR_URL}/${DEFAULT_BACKEND_IMAGE_NAME}
docker rmi gotok8s/${DEFAULT_BACKEND_IMAGE_NAME}