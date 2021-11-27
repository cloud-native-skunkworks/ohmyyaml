variable "cluster_name" {
    default = ""
    description = "The name of the cluster to connect too."
}
variable "cluster_ca_cert" {
    default = ""
    description = "The CA certificate to use to verify the cluster."
}
variable "cluster_endpoint" {
    default = ""
    description = "The endpoint of the cluster to connect too."
}
variable "charts_directory" {
    default = "."
}