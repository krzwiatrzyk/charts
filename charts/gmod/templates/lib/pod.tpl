{{ define "common.pod" }}
{{ if .Values.imagePullSecrets }}
imagePullSecrets: {{ .Values.imagePullSecrets | toYaml | nindent 2 }}
{{ end }}
containers: {{ include "common.containers" . | nindent 2 }}
volumes:
- name: config
  configMap:
    name: {{ .Release.Name }}-config
{{ end }}