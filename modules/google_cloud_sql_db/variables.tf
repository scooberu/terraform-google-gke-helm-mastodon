variable "project_id" {
  description = "Google Project ID"
  type        = string
}

variable "sql_db_region" {
  description = "A valid region string; see valid values at https://cloud.google.com/sql/docs/postgres/instance-settings#region-values"
  type        = string
}

variable "sql_db_name" {
  description = "The name to use for the PSQL database"
  type        = string
}

variable "sql_db_cores" {
  description = "The number of CPU cores to use for the DB instance"
  type        = number
  default     = 2
}

variable "sql_db_ram_mb" {
  description = "The amount of RAM to use for the DB instance in **MEGABYTES**."
  type        = number
}

variable "sql_db_autoresize" {
  description = "Automatically increase the size of the DB volume when true. Don't when false."
  type        = bool
}

variable "sql_db_initial_disk_size" {
  description = "Initial disk size to use for the psql instance, in GB. Defaults to 10 GB."
  type        = number
}

variable "sql_db_max_disk_autoresize" {
  description = "PSQL can upsize itself automatically if it runs low on space. This value (in GB) would be the maximum disk size. The default of 0 means unlimited."
  type        = number
}

variable "sql_mastodon_user_password" {
  description = "Initial password to use for the mastodon user in the PSQL DB."
  type        = string
}
