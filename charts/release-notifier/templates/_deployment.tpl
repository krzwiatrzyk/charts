{{/*
Generic deployment template
*/}}
{{- define "..deployment" -}}
{{- $component := .component -}}
{{- $root := .root -}}
{{- $values := index $root.Values $component -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "..componentFullname" . }}
  labels:
    {{- include "..componentLabels" . | nindent 4 }}
spec:
  {{- if not (and $values.autoscaling $values.autoscaling.enabled) }}
  replicas: {{ $values.replicaCount | default 1 }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "..componentSelectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with $values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "..componentLabels" . | nindent 8 }}
        {{- with $values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- with $values.podSecurityContext }}
      securityContext:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      containers:
        - name: {{ $component }}
          {{- with $values.securityContext }}
          securityContext:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          image: "{{ $values.image.repository }}:{{ $values.image.tag | default $root.Chart.AppVersion }}"
          imagePullPolicy: {{ $values.image.pullPolicy }}
          {{- if $values.command }}
          command:
            {{- toYaml $values.command | nindent 12 }}
          {{- end }}
          {{- if $values.args }}
          args:
            {{- toYaml $values.args | nindent 12 }}
          {{- end }}
          ports:
            - name: http
              containerPort: {{ $values.service.port }}
              protocol: TCP
          {{- if $values.envs }}
          env:
            {{- range $key, $value := $values.envs }}
            - name: {{ $key }}
              value: {{ $value | quote }}
            {{- end }}
          {{- end }}
          {{- with $values.livenessProbe }}
          livenessProbe:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with $values.readinessProbe }}
          readinessProbe:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with $values.resources }}
          resources:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with $values.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
      {{- with $values.volumes }}
      volumes:
        {{- range . }}
        - name: {{ .name }}
          {{- if .persistentVolumeClaim }}
          persistentVolumeClaim:
            {{- if eq .persistentVolumeClaim.claimName "pvc" }}
            claimName: {{ include "..fullname" $root }}-pvc
            {{- else }}
            claimName: {{ .persistentVolumeClaim.claimName }}
            {{- end }}
          {{- else }}
            {{- toYaml (omit . "name") | nindent 12 }}
          {{- end }}
        {{- end }}
      {{- end }}
      {{- with $values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end }}
