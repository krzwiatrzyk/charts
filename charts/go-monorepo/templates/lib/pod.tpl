{{ define "common.pod" }}
{{ if .Values.imagePullSecrets }}
imagePullSecrets: {{ .Values.imagePullSecrets | toYaml | nindent 2 }}
{{ end }}
containers: {{ include "common.containers" . | nindent 2 }}
initContainers: {{ include "common.initContainers" . | nindent 2 }}
{{ end }}