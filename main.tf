module "flux_cd" {
  source          = "./modules/flux_cd"
  github_owner    = var.github_owner
  repository_name = var.repository_name
  branch          = var.branch
  target_path     = var.target_path
  depends_on = [module.google_gke_cluster.id,
    module.gke_auth.token,
  module.github_configuration_repo.github_repo_id]
}

module "google_gke_cluster" {
  source                   = "./modules/google_gke_cluster"
  project_id               = var.project_id
  cluster_name             = var.cluster_name
  cluster_location         = var.cluster_zone
  network                  = "projects/${var.project_id}/global/networks/default"
  subnetwork               = "projects/${var.project_id}/regions/${var.cluster_region}/subnetworks/default"
  use_private_endpoint     = var.use_private_endpoint
  external_secrets_version = var.external_secrets_version
}

module "google_storage_bucket" {
  source     = "./modules/google_storage_bucket"
  project    = var.project_id
  depends_on = [module.google_gke_cluster.id]
}

module "google_cloud_sql_db" {
  source                     = "./modules/google_cloud_sql_db"
  project                    = var.project_id
  sql_db_region              = var.sql_db_region
  sql_db_name                = var.sql_db_name
  sql_db_cores               = var.sql_db_cores
  sql_db_ram_mb              = var.sql_db_ram_mb
  sql_db_autoresize          = var.sql_db_autoresize
  sql_db_initial_disk_size   = var.sql_db_initial_disk_size
  sql_db_max_disk_autoresize = var.sql_db_max_disk_autoresize
  sql_mastodon_user_password = var.sql_mastodon_postgres_secret
}

module "github_configuration_repo" {
  source                     = "./modules/github_configuration_repo"
  github_repo_name           = var.repository_name
  target_path                = var.target_path
  mastodon_replica_count     = var.mastodon_replica_count
  mastodon_image_tag         = var.mastodon_image_tag
  mastodon_image_pull_policy = var.mastodon_image_pull_policy
  admin_username             = var.admin_username
  admin_email                = var.admin_email
  local_domain               = var.local_domain
  locale                     = var.locale
  email_domain               = var.email_domain
  smtp_from_email            = var.smtp_from_email
  smtp_reply_to_email        = var.smtp_reply_to_email
  email_server               = var.email_server
  smtp_login_email           = var.smtp_login_email
  num_sidekiq_threads        = var.num_sidekiq_threads
  num_sidekiq_replicas       = var.num_sidekiq_replicas
  web_port                   = var.web_port
  web_replicas               = var.web_replicas
  single_user_mode           = var.single_user_mode
  bucket_name                = var.bucket_name
  bucket_region              = var.bucket_region
}

# We'll need this to install Flux on our cluster
# https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google/latest/submodules/auth
module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  project_id           = var.project_id
  cluster_name         = var.cluster_name
  location             = var.cluster_region
  use_private_endpoint = var.use_private_endpoint
  depends_on           = [module.google_gke_cluster.id]
}

module "k8s_secrets" {
  source                   = "./modules/k8s_secrets"
  storage_access_key       = module.google_storage_bucket.storage_access_key
  storage_secret           = module.google_storage_bucket.storage_secret
  smtp_login               = var.smtp_login
  smtp_password            = var.smtp_password
  redis_password           = var.redis_password
  otp_secret               = var.otp_secret
  secret_key_base          = var.secret_key_base
  vapid_private_key        = var.vapid_private_key
  vapid_public_key         = var.vapid_public_key
  mastodon_postgres_secret = var.mastodon_postgres_secret
  depends_on               = [module.google_gke_cluster.id]
}
