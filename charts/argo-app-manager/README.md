# ArgoCD Application Manager

This chart tries to simplify creation of applications manifests for ArgoCD. It is a turn-key solution that fits my setup and will be kustomized directly for it. 

## Decisions

1. One Github repository is used to manage many Kubernetes cluster.
2. Each cluster is defined in separate directory and referenced in the chart via `clusterName` field.
3. Application values and secrets are downloaded from the git repository.

`https://raw.githubusercontent.com/<repoName>/<clusterName>/values/<appName>.yaml`

