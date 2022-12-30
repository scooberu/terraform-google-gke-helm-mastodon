resource "google_storage_bucket" "mastodon" {
  name     = var.bucket_name
  location = var.bucket_region
}

resource "google_service_account" "mastodon" {
  account_id   = "service-account-mastodon-storage"
  display_name = "A service account for Mastodon to access its GCS storage bucket"
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.mastodon.name
  role   = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.mastodon.email}"
  ]
}

resource "google_storage_hmac_key" "mastodon" {
  service_account_email = google_service_account.mastodon.email
}
