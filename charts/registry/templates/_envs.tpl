{{- define "registry.envs" -}}
- name: REGISTRY_HTTP_HOST
  value: "http{{ if .Values.global.gitcall.registry.tls }}s{{ end }}://{{ include "registry.host" . }}"
- name: REGISTRY_HTTP_SECRET
  valueFrom:
    secretKeyRef:
      name: {{ include "common.Name" . }}-secret
      key: haSharedSecret
- name: REGISTRY_AUTH
  value: "htpasswd"
- name: REGISTRY_AUTH_HTPASSWD_REALM
  value: "Registry Realm"
- name: REGISTRY_AUTH_HTPASSWD_PATH
  value: "/auth/htpasswd"
- name: REGISTRY_STORAGE_DELETE_ENABLED
  value: "true"

{{- if eq .Values.storage.provider "filesystem" }}
- name: REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY
  value: "/var/lib/registry"
{{- else if eq .Values.storage.provider "s3" }}
- name: REGISTRY_STORAGE_S3_REGION
  value: {{ required ".Values.s3.region is required" .Values.storage.s3.region }}
- name: REGISTRY_STORAGE_S3_BUCKET
  value: {{ required ".Values.s3.bucket is required" .Values.storage.s3.bucket }}
{{- if and .Values.storage.s3.secretKey .Values.storage.s3.accessKey }}
- name: REGISTRY_STORAGE_S3_ACCESSKEY
  valueFrom:
    secretKeyRef:
      name: {{ include "common.Name" . }}-secret
      key: s3AccessKey
- name: REGISTRY_STORAGE_S3_SECRETKEY
  valueFrom:
    secretKeyRef:
      name: {{ include "common.Name" . }}-secret
      key: s3SecretKey
{{- end -}}

{{- if .Values.storage.s3.regionEndpoint }}
- name: REGISTRY_STORAGE_S3_REGIONENDPOINT
  value: {{ .Values.storage.s3.regionEndpoint }}
{{- end -}}

{{- if .Values.storage.s3.rootDirectory }}
- name: REGISTRY_STORAGE_S3_ROOTDIRECTORY
  value: {{ .Values.storage.s3.rootDirectory | quote }}
{{- end -}}
{{- end -}}
{{- end -}}
