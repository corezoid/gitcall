# GitCall Helm Chart

## Requirements

- [Kubernetes](https://kubernetes.io/) >= 1.19.0
- [Helm](https://helm.sh/) >= 3.0

## Preparing

Clone this repo to your computer and `cd` into it:

```shell
git clone https://github.com/corezoid/gitcall-helm.git && cd gitcall-helm
```

## Values

Before start an installation process you have to set necessary values such as database and message queue hostnames, 
credentials, etc. Most of the value names are self-explanatory, and some not fully obvious cases are described below.

Do not edit the original `values.yaml`, make a copy and use it for your needs.

```shell
cp values.yaml my-values.yaml
```

## The Secret key

To secure different parts of GitCall a secret key required. You have to prepare it using random generator and set a 
`global.gitcall.secret` with a given value. The value must not be shorter than 64 characters. You can use any random generator 
tool or just a shell command:

```shell
echo $(for N in {1..12}; do echo -n $RANDOM; done | base64 | head -c 64)
```

In the most cases you don't have to change this key during upgrades. Surely, **keep this key in secret**. 

## RabbitMQ and PostgreSQL connection settings

Fill the  `global.mq` and `global.db` values with your credentials. 

## Docker Registry

GitCall sets up a Docker Registry and some parts of it need to be explicitly configured. 

At first, the Registry must be accessible using public DNS name, so you have to properly set up a DNS record and point 
it to your cluster's load balancer IP address, then set the `global.gitcall.registry.host` value. Always keep the 
`global.gitcall.registry.tls` set to `true`, unless you know what you're doing.

At second, you have to configure the storage for images using `registry.storage` parameters. Currently, this chart 
support two kind of storage: filesystem volume or an S3 bucket. By default, a filesystem volume is configured. If you
want to use it, make sure you've specified enough disk space in `registry.storage.filesystem.size` parameter and 
provided a valid storage class in the `registry.storage.filesystem.storageClass` (please consult your cloud provider, if
you're not sure what storage classes you can use).

In case if you need to use an S3 bucket instead of a regular volume, change value of `registry.storage.provider` to 
`s3`, uncomment and fill necessary values of `registry.storage.s3`.

## Installation/upgrading

```shell
export GITCALL_NAMESPACE="gitcall"
export GITCALL_RELEASE="prod"
```

After you finish all the preparations, make a final check to be sure that everything is okay:

```shell
helm lint -n ${GITCALL_NAMESPACE} -f my-values.yaml .
```

and start the installation/upgrading process:

```shell
helm upgrade -n ${GITCALL_NAMESPACE} --install --atomic --wait-for-jobs --create-namespace -f values.yaml ${GITCALL_RELEASE} .
```

## Uninstallation

```shell
helm uninstall -n ${GITCALL_NAMESPACE} --wait ${GITCALL_RELEASE}
```

## Changelog

### 0.0.1 (2023-03-07)

First version.