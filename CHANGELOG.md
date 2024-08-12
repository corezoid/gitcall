# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Chart 0.3.3 [GitCall 2.7.4] - 2024-08-12
### Helm changes
- Update `values.yaml` file example
- Update `valkey` iamge registry to `docker.io/valkey`
- Update `valkey` image tag to `7.2.-alpine`
- Remove registry domain and switch to registry `service` and `NodePort`.
- Switch `registry-service.{{ .Release.Namespace }}.svc.cluster.local` to get image registry

## Chart 0.3.0 [GitCall 2.7.2] - 2024-08-06
### Helm changes

The following features have been added:
- Kubernetes NetworkPolicy (to Helm).
- ARM64 support.
- Affinity and tolerations inheritance for usercode pods.
- Prometheus metrics and gitcall dashboards.
- The ability to use a custom Dockerfile for usercode build (details: custom Dockerfile).
- The ability to use a custom path for specifying the root directory in git repo projects.
- Support for migrating a database to the gitcall application (the dedicated pod was removed).
- The following RBAC entities for gitcall (replacing the removed pimp) were added to Helm: Role, ServiceAccount, and RoleBind for access to kubeapi.
- JSONRPC-2.0/HTTP support for sending requests from gitcall to usercode. New builds will include usercode with the new protocol, while old builds will continue using JSONRPC-1.0/TCP.
- The valkey - to Helm for synchronization of states between gitcall app instances (Pub/Sub).
- The ability to return a verbose error for usercode launch failures (the usercode error is displayed, and the pod restarts).
- Correct error returns for timeout (task) and shutdown (service).

Version Upgrades
- docker:dind 23-dind -> 27-dind
- alpine 3.17 -> 3.20
- golang 1.20 -> 1.22
- k8s.io/api v0.18.0 -> v0.30.3
- go-docker v1.0.1 -> v27.1.1
- clojure:  temurin-20-lein-alpine -> temurin-22-lein-bookworm-slim
- golang: 1.20-alpine3.17 -> 1.22-alpine3.20
- java: openjdk:19-jdk-alpine3.15 -> amazoncorretto:22-alpine
- node: node:18.16-alpine3.17-> node:20-alpine
- php:  php:8.1-alpine3.17 -> php:8.3-alpine
- python: python:3.11-alpine3.17 -> python:3.12-alpine
- lisp: albertoeafworks/roswell:latest -> fukamachi/sbcl:2.4.5
- prolog: swipl:9.1.8 -> swipl:9.2.5

Improvements
- The pimp functionality for working with kubeapi has been moved to gitcall.
- The dundergitcall functionality for working with rabbitmq (tasks) has been moved to gitcall.
- The logrus logging module has been updated and replaced by slog.
- The module for working with the database has been updated, the sqlx has been added.
- The module for working with the rabbitmq has been updated, transitioned to the github.com/rabbitmq/amqp091-go site.
- All the unit and functional tests have been updated, and the tests for all the examples from https://github.com/corezoid/gitcall-examples have been added.
- The CI has been updated.
- All 8 Dockerfile/code runners have been updated to support the JSONRPC-2.0/HTTP protocol. Now, all the runners are included in the gitcall project instead of separate repos
- The user-build.sh script has been updated to support any command syntax: previously the commands containing quotation marks were not supported.

Config Changes
- The following config parameters have been added:
- A new parameter for connecting to postgres.
- The new dundergitcall.usercode.image_proxy parameter (proxy for downloading images; when not specified, images are downloaded directly from hub.docker.com).
- The new dundergitcall.usercode.idle_timeout parameter (interval in seconds after which the usercode pod will be stopped if it has no new tasks).
- The new log_level parameter.
- The new "metrics": { "listen_port": 8060 } parameter for metrics collection.
- Users must add the new dundergitcall.k8s section. This section was included in the pimp, and due to the transition of pimp functionality to gitcall, it must now be added to the gitcall config.
- The following config parameters have been removed:
```
db
servicespimp
connect_api
authz 
authn
sentry
gopsagent 
amqp.statusupdate_consumer 
dundergitcall.status_update
statuscleaner 
servicestopper 
dundergitcall.global_policy.dundergitcall_enabled 
dundergitcall.global_policy.dundergitcall_limit_cpu_milli_cores
dundergitcall.global_policy.dundergitcall_limit_memory_mb
dundergitcall.global_policy.dundergitcall_max_replicas
dundergitcall.global_policy.dundergitcall_min_replicas
dundergitcall.global_policy.dundergitcall_request_cpu_milli_cores
dundergitcall.global_policy.dundergitcall_request_memory_mb
dundergitcall.global_policy.usercode_wait_timeout_msec
```

Removals
The following components and features have been removed:

- For JS usercode images, the following preinstalled dependencies: crypto-js@4.1.1, dateutils@0.5.1, moment-timezone@0.5.41, moment@2.29.4, and axios@1.3.4. Users can install these dependencies using the Build command: npm i crypto-js@4.1.1 dateutils@0.5.1.
- The cz-tools/authz/authn/connect API.
- The helm gitcall-db-migrate.
- The helm pimp.


## Chart 0.2.2 [GitCall 2.6.0] - 2023-04-05
### Helm changes
- Add `PodMonitor` for `gitcall` application


## Chart 0.2.1 [GitCall 2.5.0] - 2023-03-29
### Helm changes
- New Chart version
- Fix service names in apps


## Chart 0.2.0 [GitCall 2.4.0] - 2023-03-23
### Helm changes
- New Chart version
