{{- define "common.Name" -}}
{{- printf "%s" .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "gitcall.affinity" -}}
{{- if .Values.global.gitcall.affinity -}}
affinity:
{{ .Values.global.gitcall.affinity | toYaml | nindent 8 | trim }}
{{- end -}}
{{- end -}}

{{- define "common.ServiceMonitor.apiVersion" -}}
monitoring.coreos.com/v1
{{- end -}}

{{- define "common.ServiceMonitor.metadata.labes" -}}
simulator.observability/scrape: "true"
{{- end -}}

{{- define "common.imagePullSecrets" -}}
{{- if not (eq .Values.global.repotype "public") }}
imagePullSecrets:
- name: {{ .Values.global.imagePullSecrets.name }}
{{- end }}
{{- end -}}

{{- define "common.spec.strategy.type" -}}
{{ .Values.global.deploymentStrategy.type }}
{{- end -}}

{{- define "common.initContainers.image" -}}
{{- if and (ne .Values.global.imageRegistry "") (ne .Values.global.imageRegistry "docker-hub.middleware.biz") }}{{ .Values.global.imageRegistry }}/{{- end}}{{ .Values.global.alpineImage.registry }}/{{ if .Values.global.useCentos8 }}{{ .Values.global.centos8Repo }}/{{ else }}{{- if not (eq .Values.global.repotype "") }}{{ .Values.global.repotype }}/{{- end }}{{ end }}{{ .Values.global.alpineImage.repository }}:{{ .Values.global.alpineImage.tag }}
{{- end }}

