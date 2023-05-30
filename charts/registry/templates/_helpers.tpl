{{- define "registry.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "registry.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "registry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "registry.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{- define "registry.labels" -}}
helm.sh/chart: {{ include "registry.chart" . | quote }}
{{ include "registry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- end }}

{{- define "ingressClassName" -}}
{{- if .Values.global.ingress.className -}}
{{ .Values.global.ingress.className }}
{{- else -}}
{{ .Values.ingress.className }}
{{- end -}}
{{- end -}}

{{- define "registry.host" -}}
{{- if .Values.global.gitcall.registry.host -}}
{{ .Values.global.gitcall.registry.host }}
{{- else if and .Values.global.domain .Values.global.gitcall.registry.subDomain -}}
{{ printf "%s.%s" .Values.global.gitcall.registry.subDomain .Values.global.domain }}
{{- end -}}
{{- end -}}
