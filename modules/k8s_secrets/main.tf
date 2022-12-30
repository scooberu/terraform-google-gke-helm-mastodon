resource "kubernetes_secret" "mastodon_secrets" {
  metadata {
    name = "mastodon-server-secret"
  }

  data = {
    login             = var.smtp_login
    password          = var.smtp_password
    redis-password    = var.redis_password
    OTP_SECRET        = var.otp_secret
    SECRET_KEY_BASE   = var.secret_key_base
    VAPID_PRIVATE_KEY = var.vapid_private_key
    VAPID_PUBLIC_KEY  = var.vapid_public_key
  }

  type = "Opaque"
}

resource "kubernetes_secret" "postgres_secrets" {
  metadata {
    name = "mastodon-psql-secret"
  }

  data = {
    password = var.mastodon_postgres_secret
  }

  type = "Opaque"
}

resource "kubernetes_secret" "mastodon_storage_bucket_keys" {
  metadata {
    name = "mastodon-production-s3"
  }

  data = {
    AWS_ACCESS_KEY_ID     = var.storage_access_key
    AWS_SECRET_ACCESS_KEY = var.storage_secret
  }

  type = "Opaque"
}
