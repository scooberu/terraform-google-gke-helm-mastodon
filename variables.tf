variable "bucket_region" {
  description = "A GCS bucket region string (e.g. 'US', 'EUR4', or 'ASIA-SOUTH1'; see https://cloud.google.com/storage/docs/locations"
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket to create"
  type        = string
  default     = "mastodon-bucket"
}

variable "cluster_name" {
  description = "Name to use for the GKE cluster that will host all compute & storage resources"
  type        = string
  default     = "mastodon-gke"
}

variable "cluster_zone" {
  description = "Zone in which to instantiate the GKE cluster"
  type        = string
}

variable "project_id" {
  description = "Google Cloud Project ID in which to host the GKE cluster, block storage, and PSQL DB"
  type        = string
}

variable "github_token" {
  description = "Personal Access Token for github (it is recommended to set this in env vars, e.g. `export TF_VAR_github_token=<token>`)"
  type        = string
}

variable "github_owner" {
  description = "The GitHub user who owns the repo we will store Mastodon server configuration in"
  type        = string
}

variable "sql_db_region" {
  description = "A valid region string; see valid values at https://cloud.google.com/sql/docs/postgres/instance-settings#region-values"
  type        = string
}

variable "sql_db_name" {
  description = "The name to use for the PSQL database"
  type        = string
  default     = "postgres-mastodon"
}

variable "sql_db_cores" {
  description = "The number of CPU cores to use for the DB instance"
  type        = number
  default     = 2
}

variable "sql_db_ram_mb" {
  description = "The amount of RAM to use for the DB instance in **MEGABYTES**."
  type        = number
  default     = 15258
}

variable "sql_db_autoresize" {
  description = "Automatically increase the size of the DB volume when true. Don't when false."
  type        = bool
  default     = true
}

variable "sql_db_initial_disk_size" {
  description = "Initial disk size to use for the psql instance, in GB. Defaults to 10 GB."
  type        = number
  default     = 10
}

variable "sql_db_max_disk_autoresize" {
  description = "PSQL can upsize itself automatically if it runs low on space. This value (in GB) would be the maximum disk size. The default of 0 means unlimited."
  type        = number
  default     = 0
}

variable "use_private_endpoint" {
  description = "Use a private GKE endpoint"
  type        = bool
  default     = false
}

variable "repository_name" {
  description = "Name of the GitHub Repo to use"
  type        = string
  default     = "mastodon_server_config"
}

variable "branch" {
  description = "Branch of the GitHub repo that Flux should use as Source of Truth for Mastodon config"
  type        = string
  default     = "main"
}

variable "target_path" {
  type        = string
  description = "Relative path to the Git repository root where the sync manifests are committed."
  default     = "app/"
}

variable "flux_namespace" {
  type        = string
  default     = "mastodon"
  description = "The Flux CD namespace"
}

variable "github_deploy_key_title" {
  type        = string
  description = "Name of GitHub deploy key to be created & managed by terraform"
}

variable "mastodon_replica_count" {
  description = "Number of Mastodon instance replicas to maintain"
  type        = number
  default     = 2
}

variable "mastodon_image_tag" {
  description = "Which dockerhub image tag to pull for this cluster. You can specify 'latest' if you wish, but then `mastodon_image_pull_policy` must be set to `Always` (else it should be `IfNotPresent`)."
  type        = string
  default     = "latest"
}

variable "mastodon_image_pull_policy" {
  description = "Image Pull Policy for the mastodon dockerhub image. This should be `IfNotPresent` if you are sticking with a particular image tag, and `Always` if you are using `latest` for `mastodon_image_tag`."
  type        = string
  default     = "Always"
}

variable "admin_username" {
  description = "Username to use for the admin user on this instance."
  type        = string
  default     = "admin"
}

variable "admin_email" {
  description = "Admin user's email address"
  type        = string
}

variable "local_domain" {
  description = "Mastodon local_domain config (e.g. mastodon.local)"
  type        = string
}

variable "locale" {
  description = "Locale for this Mastodon instance (e.g., 'en')"
  type        = string
}

variable "email_domain" {
  description = "Domain to use for SMTP"
  type        = string
}

variable "smtp_from_email" {
  description = "'From' email address to use for SMTP"
  type        = string
}

variable "smtp_reply_to_email" {
  description = "'Reply To' email address to use for SMTP"
  type        = string
}

variable "email_server" {
  description = "SMTP Server"
  type        = string
}

variable "smtp_login_email" {
  description = "Login Email for SMTP server"
  type        = string
}

variable "num_sidekiq_threads" {
  description = "Number of sidekiq jobs to execute in parallel per pod"
  type        = number
  default     = 25
}

variable "num_sidekiq_replicas" {
  description = "Number of sidekiq pod replicas to create"
  type         = number
  default      = 1
}

variable "web_port" {
  description = "Port to use for web pods"
  type        = number
  default     = 3000
}

variable "web_replicas" {
  description = "Number of web pod replicas to maintain"
  type        = number
  default     = 1
}

variable "single_user_mode" {
  description = "Run this as a single-user instance"
  type        = bool
  default     = false
}

variable "external_secrets_version" {
  description = "Version of the External Secrets operator to use on the cluster"
  type        = string
  default     = "0.7.0"
}

variable "storage_access_key" {
  description = "Access Key ID generated by the google_storage_bucket module"
  type        = string
}

variable "storage_secret" {
  description = "Secret Access Key generated by the google_storage_bucket module"
  type        = string
}

variable "smtp_login" {
  description = "SMTP server login username"
  type        = string
}

variable "smtp_password" {
  description = "SMTP server password"
  type        = string
}

variable "redis_password" {
  description = "Redis server password"
  type        = string
}

variable "otp_secret" {
  description = "OTP Secret (generate with: docker run -it tootsuite/mastodon:latest bundle exec rake secret)"
  type        = string
}

variable "secret_key_base" {
  description = "Base Secret Key (generate with: docker run -it tootsuite/mastodon:latest bundle exec rake secret)"
  type        = string
}

variable "vapid_private_key" {
  description = "Vapid Private Key (generate with: docker run -it tootsuite/mastodon:latest bundle exec rake mastodon:webpush:generate_vapid_key)"
  type        = string
}

variable "vapid_public_key" {
  description = "Vapid Public Key (generate with: docker run -it tootsuite/mastodon:latest bundle exec rake mastodon:webpush:generate_vapid_key)"
  type        = string
}

variable "mastodon_postgres_secret" {
  description = "Postgres password (generate with: docker run -it tootsuite/mastodon:latest bundle exec rake secret)"
  type        = string
}
