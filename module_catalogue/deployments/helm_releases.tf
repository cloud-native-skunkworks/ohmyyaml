locals {
  nginx_template = templatefile("${path.module}/helm_values/nginx.yaml", {
  })
  prometheus_template = templatefile("${path.module}/helm_values/prometheus.yaml", {
    "fqdn" = var.fqdn
  })
}

resource "helm_release" "ohmyyaml" {
  name        = "ohmyyaml"
  chart  = "https://cns-tmp.s3.eu-west-1.amazonaws.com/ohmyyaml-0.1.0.tgz"
  namespace   = "default"
  max_history = 3
}

resource "helm_release" "nginx-ingress" {
  name             = "nginx-ingress"
  chart            = "nginx-ingress"
  repository       = "https://helm.nginx.com/stable"
  namespace        = "ingress"
  version          = "0.10.1"
  create_namespace = true
  wait             = false
  max_history      = 3

  values = [ local.nginx_template ]
}

resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  namespace        = "cert-manager"
  version          = "v1.6.1"
  create_namespace = true
  wait             = false
  max_history      = 3
  set {
    name  = "installCRDs"
    value = "true"
  }

}

resource "helm_release" "prometheus" {
  name             = "prom"
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  namespace        = "observability"
  version          = "18.1.0"
  create_namespace = true
  wait             = true
  reset_values     = true
  max_history      = 3
  values = [
    local.prometheus_template
  ]
}
