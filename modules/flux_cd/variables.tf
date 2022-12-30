variable "flux_namespace" {
  description = "Flux Namespace"
  type        = string
}

variable "github_owner" {
  description = "github owner"
  type        = string
}

variable "repository_name" {
  description = "repository name"
  type        = string
}

variable "branch" {
  description = "branch"
  type        = string
  default     = "main"
}

variable "target_path" {
  type        = string
  description = "Relative path to the Git repository root where the sync manifests are committed."
}

variable "github_deploy_key_title" {
  type = string
}
