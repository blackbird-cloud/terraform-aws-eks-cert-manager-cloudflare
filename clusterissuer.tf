resource "helm_release" "cluster_issuers" {
  depends_on = [kubernetes_namespace.cert_manager, kubernetes_secret.cloudflare, helm_release.cert_manager]

  chart = "${path.root}/charts/cluster-issuers"
  name  = "cluster-issuers"

  namespace = local.cert_manager_name_namespace

  set {
    type  = "string"
    name  = "cloudflare.email"
    value = var.cloudflare_email
  }

  dynamic "set" {
    for_each = [for index, domain in var.dns_zones : {
      index : index,
      name : domain
    }]
    content {
      type  = "string"
      name  = "dnsZones[${set.value.index}]"
      value = set.value.name
    }
  }
}
