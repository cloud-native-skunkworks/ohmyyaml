resource "helm_release" "ohmyyaml-app" {
  name        = "ohmyyaml"
  chart       = "ohmyyaml"
  repository  = "../../app/charts"
  namespace   = "default"
  max_history = 3
}
