variable "cluster_ca_cert" {
    default = ""
    description = "The CA certificate to use to verify the cluster."
}
variable "cluster_endpoint" {
    default = ""
    description = "The endpoint of the cluster to connect too."
}
variable "cluster_name" {
    default = "tf-test-cluster"
}
variable "fqdn" {
    default = "crystalbasilica.co.uk"
    description = "The domain name to use for components and ingress"
}

variable "environment" {
    default = "dev"
    description = "The environment to deploy to"
}