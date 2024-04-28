{{ define "common.containers" }}
- name: gmod
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  resources: {{ .Values.resources | toYaml | nindent 4 }}
  {{ if .Values.args }}
  args: {{ .Values.args | toYaml | nindent 2 }}
  {{ end }}
  ports:
  {{ range $portName, $portConfig := .Values.ports -}}
  - containerPort: {{ $portConfig.port }}
    name: {{ $portName }}
  {{ end }}
  volumeMounts:
  - mountPath: /gmod
    name: config
  {{ if .Values.secretEnvs }} 
  envFrom:
  - secretRef:
      name: {{.Values.secretEnvs }} 
  {{ end }}
{{ end }}