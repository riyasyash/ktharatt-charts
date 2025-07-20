{{/*
Expand the name of the chart.
*/}}
{{- define "ktharatt.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ktharatt.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ktharatt.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ktharatt.labels" -}}
helm.sh/chart: {{ include "ktharatt.chart" . }}
{{ include "ktharatt.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ktharatt.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ktharatt.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ktharatt.operatorServiceAccountName" -}}
{{- if .Values.operatorServiceAccount.create }}
{{- default (include "ktharatt.fullname" .) .Values.operatorServiceAccount.name }}
{{- else }}
{{- default "default" .Values.operatorServiceAccount.name }}
{{- end }}
{{- end }}
{{- define "ktharatt.workerServiceAccountName" -}}
{{- if .Values.workerServiceAccount.create }}
{{- default (include "ktharatt.fullname" .) .Values.workerServiceAccount.name }}
{{- else }}
{{- default "default" .Values.workerServiceAccount.name }}
{{- end }}
{{- end }}
