resource "github_repository" "mastodon_server_config_repo" {
  name        = var.github_repo_name
  description = "Repo storing configuration for a Mastodon cluster"

  visibility = "private"
}

resource "github_repository_file" "source" {
  repository = github_repository.mastodon_server_config_repo.name
  branch     = "main"
  file       = "${var.target_path}/source.yaml"
  content    = <<EOF
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: GitRepository
metadata:
  name: mastodon
  namespace: default
spec:
  interval: 5m
  url: https://github.com/mastodon/chart
  ref:
    branch: main
EOF
}

# TODO: Does it make more sense to use the helm_release resource?
resource "github_repository_file" "release" {
  repository = github_repository.mastodon_server_config_repo.name
  branch     = "main"
  file       = "${var.target_path}/release.yaml"
  content    = <<EOF
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: mastodon
  namespace: default
spec:
  interval: 5m
  chart:
    spec:
      chart: ./chart
      sourceRef:
        kind: GitRepository
        name: mastodon
      interval: 5m
  valuesFrom:
    - kind: ConfigMap
      name: mastodon-values
EOF
}

resource "github_repository_file" "kustomizeconfig" {
  repository = github_repository.mastodon_server_config_repo.name
  branch     = "main"
  file       = "${var.target_path}/kustomizeconfig.yaml"
  content    = <<EOF
nameReference:
  - kind: ConfigMap
    version: v1
    fieldSpecs:
      - path: spec/valuesFrom/name
        kind: HelmRelease
EOF
}

resource "github_repository_file" "kustomization" {
  repository = github_repository.mastodon_server_config_repo.name
  branch     = "main"
  file       = "${var.target_path}/kustomization.yaml"
  content    = <<EOF
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: default
resources:
  - source.yaml
  - release.yaml
  - sealed-secret-postgres.yaml
  - sealed-secret-mastodon-server.yaml
configMapGenerator:
  - name: mastodon-values
    files:
      - values.yaml
configurations:
  - kustomizeconfig.yaml
EOF
}

resource "github_repository_file" "values" {
  repository = github_repository.mastodon_server_config_repo.name
  branch     = "main"
  file       = "${var.target_path}/values.yaml"
  content    = <<EOF
replicaCount: ${var.mastodon_replica_count}
image:
  repository: tootsuite/mastodon
  tag: "${var.mastodon_image_tag}"
  pullPolicy: "${var.mastodon_image_pull_policy}"
mastodon:
  createAdmin:
    enabled: true
    username: ${var.admin_username}
    email: ${var.admin_email}
  local_domain: ${var.local_domain}
  locale: ${var.locale}
  s3:
    enabled: true
    existingSecret: "mastodon-production-s3"
    bucket: "${var.bucket_name}"
    endpoint: https://storage.googleapis.com
    hostname: storage.googleapis.com
    region: "${var.bucket_region}"
  secrets:
    existingSecret: "mastodon-server-secret"
  singleUserMode: ${var.single_user_mode}
  workers:
    - name: all-queues
      concurrency: ${var.num_sidekiq_threads}
      replicas: ${var.num_sidekiq_replicas}
  smtp:
    auth_method: plain
    ca_file: /etc/ssl/certs/ca-certificates.crt
    delivery_method: smtp
    domain: ${var.email_domain}
    enable_starttls: "auto"
    from_address: ${var.smtp_from_email}
    openssl_verify_mode: peer
    port: 587
    reply_to: ${var.smtp_reply_to_email}
    server: ${var.email_server}
    tls: true
    existingSecret: mastodon-server-secret
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-issuer
    nginx.org/client-max-body-size: 40m
  ingressClassName:
  hosts:
    - host: ${var.local_domain}
      paths:
        - path: "/"
  tls:
    - secretName: mastodon-tls
      hosts:
        - ${var.local_domain}
elasticsearch:
  master:
    masterOnly: false
    replicaCount: 1
  data:
    replicaCount: 0
  coordinating:
    replicaCount: 0
  ingest:
    replicaCount: 0
postgresql:
  enabled: true
  auth:
    database: mastodon_production
    username: mastodon
    existingSecret: "mastodon-psql-secret"
redis:
  auth:
    existingSecret: "mastodon-server-secret"
web:
  port: ${var.web_port}
  replicas: ${var.web_replicas}
resources: {}
EOF
}
