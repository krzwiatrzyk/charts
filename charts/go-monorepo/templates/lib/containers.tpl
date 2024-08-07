{{ define "common.containers" }}
- name: {{ .Values.name }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  resources: {{ .Values.resources | toYaml | nindent 4 }}
  {{ if .Values.args }}
  args: {{ .Values.args | toYaml | nindent 2 }}
  {{ end }}
  envFrom:
  {{ if .Values.secrets.enabled }} 
  - secretRef:
      name: {{ .Release.Name }}-envs
  {{ end }}
  {{ if .Values.envs }} 
  - configMapRef:
      name: {{ .Release.Name }}-envs
  {{ end }}
  {{ if .Values.env }}
  env: {{ .Values.env | toYaml | nindent 2 }}
  {{ end }}
{{ end }}