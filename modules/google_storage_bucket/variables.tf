variable "bucket_region" {
  description = "A GCS bucket region string (e.g. 'US', 'EUR4', or 'ASIA-SOUTH1'; see https://cloud.google.com/storage/docs/locations"
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket to create"
  type        = string
}

variable "project_id" {
  type = string
}
