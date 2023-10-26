# [KUBERNETES](https://kubernetes.io)

[Getting started](https://kubernetes.io/docs/setup) is easy and can be done on a local machine, into the cloud, or datacenter.

Several Kubernetes components can also be deployed as container images within the cluster and it is recommended to run Kubernetes components as container images wherever that is possible.

## MINIKUBE (DEVELOPMENT)

```console
minikube stop

minikube delete

minikube config set cpus 4
minikube config set memory 16GB
minikube config set disk-size 40GB
minikube config set driver kvm2 # does not support static ip

minikube config view # to double check

minikube start # starts virtual machine with dynamic ip
```

[Configure Static IP](https://minikube.sigs.k8s.io/docs/tutorials/static_ip) instructions, if necessary.

```console
minikube stop

minikube delete # cluster reset is necessary

minikube start --driver docker --static-ip 192.168.100.100
```

[Enable Ingress Addons](https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns) instructions, if necessary.

```console
minikube addons enable ingress
minikube addons enable ingress-dns

minikube addons list # to double check
```

### Port Forward

```console
kubectl port-forward service/postgresql 5432:5432
```

## CLUSTER (PRODUCTION)

- [Download Kubernetes](https://kubernetes.io/releases/download)
- Download and [install tools](https://kubernetes.io/docs/tasks/tools/) including **kubectl**
- Select a [container runtime](https://kubernetes.io/docs/setup/production-environment/container-runtimes) for the cluster

Also, it is important to learn about [best practices](https://kubernetes.io/docs/setup/best-practices) for cluster setup.

### Managed Services

Managed Kubernetes is when third-party providers take over responsibility for some or all of the work necessary for the successful set-up and operation of K8s.

Leveraging a managed version of Kubernetes allows developers and businesses to take advantage of containerized application deployment, leading to a faster time to market.

[AWS](https://aws.amazon.com/eks), [Google](https://cloud.google.com/kubernetes-engine) and [Azure](https://azure.microsoft.com/en-us/products/kubernetes-service), among others, offer this kind of service.

## NAMESPACES (ORGANIZATION)

In this project the following namespace configuration is recommended as part of the architecture design:

- **apps** -> webapp + restapi + analytics
- **data** -> storage + database + stream + blockchain
- **work** -> workflow + pipeline + transform + engine + metric

## HELM-CHARTS (OPERATORS)

Different applications make up this project. In development environment, single pod deployments (no high availability) is acceptable for simplicity. In production environments, however, it is more interesting to use [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator), preferably through [Helm Charts](https://helm.sh/docs/topics/charts) to carry out more reliable and scalable configurations.

[ArtifactHub](https://artifacthub.io) is a chart repository to find, install and publish Kubernetes packages.

[OperatorHub](https://operatorhub.io) is a operator repository for the Kubernetes community to share operators.

Some useful charts include (not exaustive list):

- [Spark](https://github.com/GoogleCloudPlatform/spark-on-k8s-operator)
- [MinIO](https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-operator-helm.html)
- [Postgres](https://stackgres.io/install/)
- [Kafka](https://github.com/confluentinc/cp-helm-charts)
- [Prometheus](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)

> Helm is like a package manager. It can install applications on your cluster, but it has only some basic logic for updates to its configuration or for version upgrades. You control it through the helm commands and call it when you need it. So it helps you with some tasks, but it is still up to you to run your Kafka cluster day-to-day.
>
> Operators on the other hand are (usually) more sophisticated. They don't handle only the installation but also day-2 operations. They essentially try to encode the knowledge and the tasks a human operator running someting like a Kafka cluster would need and do into an application (= the operator). The operator runs all the time in your cluster, and constantly monitors the Kafka cluster to see what is happening in it, if some actions should be taken, and so on. For something like Kafka, the Strimzi operator for example incorporates the rolling update knowledge such as that the controller broker should be rolled last and partition replicas kept in-sync, it deals with upgrades which in Kafka usually consist of multiple rolling updates, handles certificate renewals, and much more.
>
> So an operator will normally do a lot more things for you than a Helm Chart as it operates the Kafka cluster for you. For stateful applications such as Kafka or for example databases, this can often make a huge difference. But it is usually also more opinionated as it does things the way it was programmed to which might be different from what you were used to. Helm Charts normally give you a lot of freedom to do things any way you want.
>
> Note: Different operators have different features and levels of maturity. So they might or might not support different tasks.
>
> https://stackoverflow.com/a/75695962