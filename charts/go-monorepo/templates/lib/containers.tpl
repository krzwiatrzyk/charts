{{ define "common.containers" }}
- name: {{ .Values.name }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  resources: {{ .Values.resources | toYaml | nindent 4 }}
  {{ if .Values.args }}
  args: {{ .Values.args | toYaml | nindent 2 }}
  {{ end }}
  {{ if .Values.secretEnvs }} 
  envFrom:
  - secretRef:
      name: {{.Values.secretEnvs }} 
  {{ end }}
  {{ if .Values.envs }} 
  env:
    {{ range $key, $value := .Values.envs }}
    - name: {{ $key }}
      value: {{ $value }}
    {{ end }}
  {{ end }}
{{ end }}