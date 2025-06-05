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
    name                            = "ubuntu"
    environment                     = "development"
    project                         = "infra"
    key_name                        = "ryanta-profile"
    iam_instance_profile            = "ServerRole"
    security_groups                 = ["sg-030198b3e099e2620","sg-01106abb20f500c1c"]
    ami                             = "ami-0750a20e9959e44ff"
    instance_type                   = "t3.micro"
    count_start                     = "1"
    count_instance                  = "1"
    subnets                         = ["subnet-06a114a7ef004e36e", "subnet-03af21ec655b8267e", "subnet-0e73e42d9b6626ff5"]  
    root_disk                       = "20"
    root_disk_type                  = "gp3"



}
