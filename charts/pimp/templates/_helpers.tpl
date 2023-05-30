{{- define "pimp.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pimp.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pimp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pimp.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{- define "pimp.labels" -}}
helm.sh/chart: {{ include "pimp.chart" . | quote }}
{{ include "pimp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end }}
{{- end }}

{{- define "gitcall.pimp.imagePullPolicy" -}}
{{- if .Values.global.gitcall.imagePullPolicy -}}
{{ .Values.global.gitcall.imagePullPolicy }}
{{- else if .Values.global.imagePullPolicy -}}
{{ .Values.global.imagePullPolicy }}
{{- else -}}
{{ .Values.image.pullPolicy }}
{{- end -}}
{{- end }}

{{- define "gitcall.pimp.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype | default "public" }}/gitcall/servicespimp:{{ .Values.global.gitcall.pimp.tag | default .Chart.AppVersion }}
{{- end }}
