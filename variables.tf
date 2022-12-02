variable "name" {
  default     = "cert-manager"
  type        = string
  description = "Name of the application"
}

variable "labels" {
  type = map(string)
  default = {
    istio-injection = "disabled"
  }
  description = "Labels applied to all Kubernetes resources"
}

variable "annotations" {
  type        = map(string)
  default     = {}
  description = "Annotations applied to all Kubernetes resources"
}

variable "cluster_id" {
  type        = string
  description = "AWS EKS cluster ID"
}

variable "cloudflare_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API token"
}

variable "cloudflare_email" {
  type        = string
  description = "Cloudflare email associated with the token"
}

variable "dns_zones" {
  type        = list(string)
  description = "List of dns zones we will be creating certificates for"
}
