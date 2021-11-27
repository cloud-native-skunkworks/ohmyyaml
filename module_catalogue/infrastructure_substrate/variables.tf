variable "cluster_name" {
    default = "tf-test-cluster"
}
variable "subnets" {
    default = ["subnet-12345678", "subnet-87654321"]
}
variable "instance_type" {
    default = "t2.micro"
}
variable "asg_max_size" {
    default = "3"
}