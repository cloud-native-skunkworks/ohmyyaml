variable "cluster_name" {
    default = "tf-test-cluster"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "asg_max_size" {
    default = "3"
}