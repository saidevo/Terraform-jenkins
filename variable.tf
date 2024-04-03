variable "ami_id" {
  type = string
  
}
variable "instance_type" {
  type = string
  #default = "t2.medium"
}
variable "key_name" {
  type = string
  #default = "deamon"
}
variable "vpc_cidr" {
  type = string
  #default = "10.0.0.0/16"
}
variable "region" {
  type = string

}
