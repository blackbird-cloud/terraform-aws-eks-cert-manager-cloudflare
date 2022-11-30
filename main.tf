locals {
  cert_manager_name           = "cert-manager"
  cert_manager_name_namespace = kubernetes_namespace.cert_manager.metadata[0].name
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    labels      = var.labels
    annotations = var.annotations
    name        = local.cert_manager_name
  }
}

resource "helm_release" "cert_manager" {
  depends_on = [kubernetes_namespace.cert_manager, kubernetes_secret.cloudflare]

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.8.0"

  name      = local.cert_manager_name
  namespace = local.cert_manager_name_namespace

  values = [
    templatefile("./tmpl/values.yaml", {})
  ]
}
