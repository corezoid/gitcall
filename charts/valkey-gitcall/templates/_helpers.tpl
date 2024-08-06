{{/*
Common labels
*/}}
{{- define "gitcall.valkey.labels" -}}
release: {{ .Release.Name }}
application: gitcall-valkey
{{- end }}

