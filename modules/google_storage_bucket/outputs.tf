output "storage_access_key" {
  value       = google_storage_hmac_key.mastodon.access_id
  description = "Access Key for the Storage Bucket"
}

output "storage_secret" {
  value       = google_storage_hmac_key.mastodon.secret
  description = "Secret Access Key for the Storage Bucket"
}
