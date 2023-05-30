{
  "db": {
    "dsn": "postgres://{{ .Values.global.db.secret.data.dbuser }}:{{ .Values.global.db.secret.data.dbpwd }}@{{ .Values.global.db.secret.data.dbhost }}:{{ .Values.global.db.secret.data.dbport }}/{{ .Values.global.gitcall.db_name | default "git_call" }}?sslmode=disable&binary_parameters=yes"
  },
  "amqp": {
    "connections": [
      {
        "host": "{{ .Values.global.mq.secret.data.host }}",
        "port": {{ .Values.global.mq.secret.data.port }},
        "username": "{{ .Values.global.mq.secret.data.username }}",
        "password": "{{ .Values.global.mq.secret.data.password }}",
        "vhost": "{{ include "gitcall.config.mq.vhost" . }}"
      }
    ],
    "buildarchive_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-buildarchive"
    },
    "buildservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-buildservice"
    },
    "deployservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-deployservice"
    },
    "getpolicy_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-getpolicy"
    },
    "getservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-getservice"
    },
    "getsshkey_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-getsshkey"
    },
    "refreshsshkey_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-refreshsshkey"
    },
    "removepolicy_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-setpolicy"
    },
    "removeservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-removeservice"
    },
    "runservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-runservice"
    },
    "saveservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-saveservice"
    },
    "setpolicy_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-setpolicy"
    },
    "statusupdate_consumer": {
      "prefetch": 1,
      "queue": "dundergitcall-status-update"
    },
    "stopservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-stopservice"
    },
    "validateservice_consumer": {
      "exchange": "gitcall-v2",
      "num_consumers": 1,
      "prefetch": 1,
      "queue": "gitcall-v2-validateservice"
    }
  },
  "dundergitcall": {
    "docker_config": {
      "auths": {
        {{ include "registry.host" . | quote }}: {
          "username": "{{ .Values.global.gitcall.secret.username }}",
          "password": "{{ .Values.global.gitcall.secret.password }}"
        }
      }
    },
    "docker_daemon": {
      "discovery": "dns",
      "host": "docker-service.{{ .Release.Namespace }}.svc.cluster.local",
      "port": 2375
    },
    "global_policy": {
      "dundergitcall_enabled": true,
      "dundergitcall_limit_cpu_milli_cores": 100,
      "dundergitcall_limit_memory_mb": 50,
      "dundergitcall_max_replicas": 2,
      "dundergitcall_min_replicas": 1,
      "dundergitcall_request_cpu_milli_cores": 100,
      "dundergitcall_request_memory_mb": 50,
      "usercode_concurrency": 10,
{{/*      "dundergitcall_image": "docker-hub.middleware.biz/public/gitcall/dundergitcall:2.0.1",*/}}
{{/*      "usercode_java_runner_image": "docker-hub.middleware.biz/public/gitcall/java-runner:0.1.5",*/}}
{{/*      "usercode_java_runtime_image": "docker-hub.middleware.biz/hub.docker.com/library/openjdk:19-ea-jdk-slim-bullseye",*/}}
{{/*      "usercode_js_runner_image": "docker-hub.middleware.biz/public/gitcall/js-runner:0.5.4",*/}}
      "usercode_limit_cpu_milli_cores": 100,
      "usercode_limit_memory_mb": 400,
      "usercode_limit_per_owner": 0,
      "usercode_max_replicas": 10,
      "usercode_min_replicas": 1,
{{/*      "usercode_php_runner_image": "docker-hub.middleware.biz/public/gitcall/php-runner:0.4.5",*/}}
{{/*      "usercode_php_runtime_image": "docker-hub.middleware.biz/public/gitcall/php-runtime:8.0-1",*/}}
{{/*      "usercode_proxy_image": "docker-hub.middleware.biz/public/gitcall/usercode-proxy:2.0.1",*/}}
{{/*      "usercode_python_runner_image": "docker-hub.middleware.biz/public/gitcall/python-runner:0.1.3",*/}}
{{/*      "usercode_python_runtime_image": "docker-hub.middleware.biz/public/gitcall/python:3.9-alpine3.13",*/}}
{{/*      "usercode_lisp_runner_image": "docker-hub.middleware.biz/public/gitcall/lisp-runner:latest",*/}}
{{/*      "usercode_lisp_runtime_image": "docker-hub.middleware.biz/hub.docker.com/fukamachi/roswell:21.10.14.111-alpine",*/}}
{{/*      "usercode_clojure_runner_image": "docker-hub.middleware.biz/public/gitcall/clojure-runner:latest",*/}}
{{/*      "usercode_clojure_runtime_image": "docker-hub.middleware.biz/hub.docker.com/library/clojure:temurin-19-lein-2.9.10-alpine",*/}}
{{/*      "usercode_prolog_runner_image": "docker-hub.middleware.biz/public/gitcall/prolog-runner:latest",*/}}
{{/*      "usercode_prolog_runtime_image": "docker-hub.middleware.biz/hub.docker.com/library/swipl:9.0.0",*/}}
      "usercode_request_cpu_milli_cores": 100,
      "usercode_request_memory_mb": 50,
      "usercode_result_size_bytes": 2097152,
      "usercode_scale_cpu_average_utilization": 80,
      "usercode_scale_prometheus_server": "http://prometheus-server.monitoring.svc.cluster.local",
      "usercode_timeout_msec": 15000,
      "usercode_wait_timeout_msec": 20000
    },
    "gopsagent": {
      "enabled": false,
      "host": "127.0.0.1",
      "port": 7789
    },
    "k8s": {
      "network_policy": false,
      "single_namespace": "{{ .Release.Namespace }}"
    },
    "prometheus": {
      "enabled": true,
      "metrics_host": "0.0.0.0",
      "metrics_port": 9100,
      "not_scraped_check_period_sec": 120,
      "type": "scrape"
    },
    "sentry": {
      "enabled": false
    },
    "status_update": {
      "transport": "amqp",
      "amqp_host": "{{ .Values.global.mq.secret.data.host }}",
      "amqp_port": {{ .Values.global.mq.secret.data.port }},
      "amqp_username": "{{ .Values.global.mq.secret.data.username }}",
      "amqp_password": "{{ .Values.global.mq.secret.data.password }}",
      "amqp_vhost": "{{ include "gitcall.config.mq.vhost" . }}",
      "amqp_queue": "dundergitcall-status-update",
      "period_sec": 10
    },
    "status_update_period_sec": 30,
    "status_update_queue": "dundergitcall-status-update",
    "system_amqp": {
      "host": "{{ .Values.global.mq.secret.data.host }}",
      "port": {{ .Values.global.mq.secret.data.port }},
      "username": "{{ .Values.global.mq.secret.data.username }}",
      "password": "{{ .Values.global.mq.secret.data.password }}",
      "vhost": "{{ include "gitcall.config.mq.vhost" . }}"
    },
    "task_amqp": {
      "host": "{{ .Values.global.mq.secret.data.host }}",
      "port": {{ .Values.global.mq.secret.data.port }},
      "username": "{{ .Values.global.mq.secret.data.username }}",
      "password": "{{ .Values.global.mq.secret.data.password }}",
      "vhost": "{{ include "gitcall.config.mq.task_vhost" . }}",
      "prefetch": 50,
      "workers_num": 50
    },
    "tmp_dir": "/tmp",
    "usercode": {
      "discovery_period_ms": 60000,
      "reconnect_period_ms": 5000,
      "service_port": 9999,
      "startup_discovery_period_ms": 100,
      "startup_period_ms": 300000,
      "worker_num": 50
    },
    "usercode_registry": {{ include "registry.host" . | quote }},
    "usercode_registry_schema": "http{{- if .Values.global.gitcall.registry.tls }}s{{- end }}"
  },
  "enigma": {
    "enabled": false
  },
  "gopsagent": {
    "enabled": true,
    "host": "127.0.0.1",
    "port": 7789
  },
  "prometheus": {
    "enabled": true,
    "metrics_host": "0.0.0.0",
    "metrics_port": 9100,
    "not_scraped_check_period_sec": 120,
    "type": "scrape"
  },
  "sentry": {
    "enabled": false
  },
  "servicespimp": {
    "uri": "http://pimp-service.{{ .Release.Namespace }}.svc.cluster.local:8080",
    "access_token": "{{ .Values.global.gitcall.secret }}"
  },
  "servicestopper": {
    "check_period_ms": 30000,
    "maybe_stop_after_idling_sec": 60,
    "stop_after_maybe_stop_ms": 5000,
    "worker_pool_size": 10
  },
  "status_update_exchange": "gitcall-v2-status-update",
  "statuscleaner": {
    "outdated_check_period_ms": 5000,
    "outdated_query_limit": 100,
    "outdated_time_ms": 35000
  },
  "authn": {
    "enabled": false,
    "http_host": "http://example.com:9999",
    "issuer": "example.com",
    "load_public_key": true,
    "service_password": "SET_ME",
    "service_subject": "gitcall"
  },
  "authz": {
    "http_host": "http://example.com:30007",
    "type": "server"
  },
  "connect_api": {
    "server": {
      "cors": {
        "allow_credentials": true,
        "allowed_headers": [
          "content-type",
          "authorization",
          "cookie",
          "accept"
        ],
        "allowed_methods": [
          "POST"
        ],
        "allowed_origins": [
          "https://*.example.com",
          "https://example.com"
        ],
        "enabled": true
      },
      "listen_host": "0.0.0.0",
      "listen_port": 30006
    }
  }
}