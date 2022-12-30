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


