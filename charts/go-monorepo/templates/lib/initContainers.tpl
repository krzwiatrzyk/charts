{{ define "common.initContainers" }}
- name: init
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  resources: {{ .Values.resources | toYaml | nindent 4 }}
  command: {{ .Values.init.command | toYaml | nindent 4 }}
  args:  {{ .Values.init.args | toYaml | nindent 4 }}
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
