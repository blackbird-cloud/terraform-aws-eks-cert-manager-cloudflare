resource "kubernetes_secret" "cloudflare" {
  metadata {
    name      = "cloudflare"
    namespace = local.cert_manager_name_namespace
  }

  data = {
    cloudflare_api_key = var.cloudflare_token
  }
}
