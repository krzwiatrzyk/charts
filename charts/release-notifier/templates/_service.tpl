{{/*
Generic service template
*/}}
{{- define "..service" -}}
{{- $component := .component -}}
{{- $root := .root -}}
{{- $values := index $root.Values $component -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "..componentFullname" . }}
  labels:
    {{- include "..componentLabels" . | nindent 4 }}
spec:
  type: {{ $values.service.type }}
  ports:
    - port: {{ $values.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "..componentSelectorLabels" . | nindent 4 }}
{{- end }}
