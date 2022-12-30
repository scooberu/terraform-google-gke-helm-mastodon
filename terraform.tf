terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = ">= 0.22.2"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.12.0"
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 4.47.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

provider "google" {}

provider "kubernetes" {
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
}

provider "kubectl" {
  cluster_ca_certificate = module.gke_auth.cluster_ca_certificate
  host                   = module.gke_auth.host
  token                  = module.gke_auth.token
  load_config_file       = false
}

provider "flux" {}
