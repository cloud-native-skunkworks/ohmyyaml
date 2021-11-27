resource "helm_release" "ohmyyaml" {
  name        = "ohmyyaml"
  chart       = "ohmyyaml"
  repository  = "${var.charts_directory}/charts"
  namespace   = "default"
  max_history = 3
}
