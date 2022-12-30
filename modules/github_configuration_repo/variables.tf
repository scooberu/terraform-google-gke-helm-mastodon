variable "github_repo_name" {
  description = "The name to use for the GitHub repo that will store your server configuration"
  type        = string
}

variable "target_path" {
  description = "Path for helm config to be stored in & synced from"
  type        = string
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

variable "num_sidekiq_threads" {
  description = "Number of sidekiq jobs to execute in parallel per pod"
  type        = number
  default     = 25
}

variable "num_sidekiq_replicas" {
  description = "Number of sidekiq pod replicas to create"
  type        = number
  default     = 1
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

variable "bucket_region" {
  description = "A GCS bucket region string (e.g. 'US', 'EUR4', or 'ASIA-SOUTH1'; see https://cloud.google.com/storage/docs/locations"
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket to create"
  type        = string
  default     = "mastodon-bucket"
}
