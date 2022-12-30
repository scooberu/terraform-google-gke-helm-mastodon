output "github_repo_id" {
  description = "ID of the repo (mostly just to verify that it has completed creation)"
  value       = github_repository.mastodon_server_config_repo.repo_id
}
