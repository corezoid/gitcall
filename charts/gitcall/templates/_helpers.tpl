{{- define "gitcall.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "gitcall.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "gitcall.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "gitcall.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name | trunc 63 | trimSuffix "-" | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}

{{- define "gitcall.labels" -}}
app: gitcall
helm.sh/chart: {{ include "gitcall.chart" . | quote }}
{{ include "gitcall.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end }}
{{- end }}

{{- define "gitcall.config.mq.vhost" -}}
{{- if .Values.global.mq.secret.data.vhost -}}
{{ .Values.global.mq.secret.data.vhost }}
{{- else -}}
{{ .Values.config.mq_vhost }}
{{- end -}}
{{- end -}}

{{- define "gitcall.config.mq.task_vhost" -}}
{{- if .Values.global.gitcall.dunder_mq_vhost -}}
{{ .Values.global.gitcall.dunder_mq_vhost }}
{{- else -}}
{{ .Values.config.mq.task_vhost }}
{{- end -}}
{{- end -}}

{{- define "gitcall.gitcall.imagePullPolicy" -}}
{{- if .Values.global.gitcall.imagePullPolicy -}}
{{ .Values.global.gitcall.imagePullPolicy }}
{{- else if .Values.global.imagePullPolicy -}}
{{ .Values.global.imagePullPolicy }}
{{- else -}}
{{ .Values.image.pullPolicy }}
{{- end -}}
{{- end }}

{{- define "gitcall.gitcall.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype | default "public" }}/gitcall:{{ .Values.global.gitcall.tag | default .Chart.AppVersion }}
{{- end }}
