resource "google_sql_database_instance" "mastodon_psql" {
  name                  = var.sql_db_name
  region                = var.sql_db_region
  project               = var.project_id
  disk_autoresize       = var.sql_db_autoresize
  disk_size             = var.sql_db_initial_disk_size
  disk_autoresize_limit = var.sql_db_max_disk_autoresize
  database_version      = "POSTGRES_14"
  settings {
    tier = "db-custom-${var.sql_db_cores}-${var.sql_db_ram_mb}"
  }
  deletion_protection = true
}

resource "google_sql_user" "mastodon" {
  name     = "mastodon"
  project  = var.project_id
  instance = google_sql_database_instance.mastodon_psql.name
  password = var.sql_mastodon_user_password
}

resource "google_sql_database" "mastodon_database" {
  name     = "mastodon"
  project  = var.project_id
  instance = google_sql_database_instance.mastodon_psql.name
}
