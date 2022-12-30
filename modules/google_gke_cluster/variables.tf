variable "project_id" {
  type = string
}

variable "cluster_location" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "initial_node_count" {
  type = number
}

variable "network" {
  type = string
}

variable "subnetwork" {
  type = string
}

variable "use_private_endpoint" {
  type = bool
}
