terraform {
    required_providers {
        aws = {
        version = ">= 2.7.0"
        source = "hashicorp/aws"
        }
    }
}

module "default" {
    source                          = "../module/ec2-instance"
    aws_region                      = "ap-southeast-1"
    availability_zones               = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
    name                            = "vm-2"
    environment                     = "development"
    project                         = "infra"
    key_name                        = "ryanta-profile"
    iam_instance_profile            = "ServerRole"
    security_groups                 = ["sg-xxxxx","sg-0xxxxx"]
    ami                             = "ami-0750a20e9959e44ff"
    instance_type                   = "t4g.micro"
    count_start                     = "1"
    count_instance                  = "1"
    subnets                         = ["subnet-0xxxx", "subnet-0xxxx", "subnet-00xxxx"]  
    root_disk                       = "20"
    root_disk_type                  = "gp3"



}
