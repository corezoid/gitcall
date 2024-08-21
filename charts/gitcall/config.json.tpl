{
  "log_level": "{{ .Values.global.gitcall.log_level | default "info" }}",
  "metrics": {
    "listen_port": 8060
  },
  "postgres": {
    "host": "{{ .Values.global.db.secret.data.dbhost }}",
    "port": {{ .Values.global.db.secret.data.dbport }},
    "database": "{{ .Values.global.gitcall.db_name | default "git_call" }}",
    "user": "{{ .Values.global.db.secret.data.dbuser }}",
    "password": "{{ .Values.global.db.secret.data.dbpwd }}"
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
        "registry-service.{{ .Release.Namespace }}.svc.cluster.local:5000": {
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
      "usercode_concurrency": 10,
      "usercode_limit_cpu_milli_cores": 100,
      "usercode_limit_memory_mb": 200,
      "usercode_limit_per_owner": 0,
      "usercode_max_replicas": 10,
      "usercode_min_replicas": 1,
      "usercode_request_cpu_milli_cores": 100,
      "usercode_request_memory_mb": 50,
      "usercode_result_size_bytes": 2097152,
      "usercode_scale_cpu_average_utilization": 80,
      "usercode_scale_prometheus_server": "http://prometheus-server.monitoring.svc.cluster.local",
      "usercode_timeout_msec": {{ .Values.global.gitcall.usercodeTimeoutMsec | default 60000 }},
      "usercode_idle_timeout_msec": {{ .Values.global.gitcall.usercodeIdleTimeoutMsec | default 120000 }}
    },
    "k8s": {
      "manage_namespaces": false,
      "single_namespace": "{{ .Release.Namespace }}",
      "apply_timeout_ms": 20000,
      "auth": {
          "in_cluster": true
        },
      "image_pull_secrets": [
        {
          "secret_name": "{{ .Release.Name }}-pimp",
          "docker_config": {
            "auths": {
              "localhost:{{ .Values.global.gitcall.registry.nodePort | default "32500" }}": {
                "username": "{{ .Values.global.gitcall.secret.username }}",
                "password": "{{ .Values.global.gitcall.secret.password }}"
              }
            }
          }
        }
      ],
      "registry_pull_host": "localhost:{{ .Values.global.gitcall.registry.nodePort | default "32500" }}"
    },
    "task_amqp": {
      "host": "{{ .Values.global.mq.secret.data.host }}",
      "port": {{ .Values.global.mq.secret.data.port }},
      "username": "{{ .Values.global.mq.secret.data.username }}",
      "password": "{{ .Values.global.mq.secret.data.password }}",
      "vhost": "{{ include "gitcall.config.mq.task_vhost" . }}",
      "prefetch": 50
    },
    "tmp_dir": "/tmp",
    "usercode": {
      "service_port": 9999
    },
    "usercode_registry": "registry-service.{{ .Release.Namespace }}.svc.cluster.local:5000",
    "usercode_registry_schema": "http"
  },
  "enigma": {
    "enabled": false
  },
  "status_update_exchange": "gitcall-v2-status-update",
  "redis": {
    "host": {{ .Values.global.valkey.secret.data.host | quote }},
    "port": {{ .Values.global.valkey.secret.data.port }},
    "database": 0,
    "password": {{ .Values.global.valkey.secret.data.password | quote }}
  }
}
