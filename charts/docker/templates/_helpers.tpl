{{- define "docker.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "docker.fullname" -}}
{{- printf "%s" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "docker.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "docker.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{- define "docker.labels" -}}
helm.sh/chart: {{ include "docker.chart" . | quote }}
{{ include "docker.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end }}
{{- end }}

{{- define "gitcall.docker.imagePullPolicy" -}}
{{- if .Values.global.gitcall.imagePullPolicy -}}
{{ .Values.global.gitcall.imagePullPolicy }}
{{- else if .Values.global.imagePullPolicy -}}
{{ .Values.global.imagePullPolicy }}
{{- else -}}
{{ .Values.image.pullPolicy }}
{{- end -}}
{{- end }}
