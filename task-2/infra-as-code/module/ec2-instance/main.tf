 provider "aws" {
  region  = var.aws_region
  profile = "default"
  }


  resource "aws_instance" "vm" {
  ami                       = var.ami
  instance_type             = var.instance_type
  count                     = var.count_instance
  key_name                  = var.key_name
  subnet_id                 = element(var.subnets , count.index)
  vpc_security_group_ids    = var.security_groups
  user_data                 = file("startup/init.sh")
  iam_instance_profile      = var.iam_instance_profile

  root_block_device {
    volume_size           = var.root_disk
    volume_type           = var.root_disk_type
    delete_on_termination = true

    tags = merge (
        {
          Name              = var.name,
          Environment       = var.environment,
          provisioner       = "terraform"
        },
        var.tags
      )
  }

}

output "private_ip" {
  value = aws_instance.vm.*.private_ip
}

output "instance_name" {
  value = aws_instance.vm[*].tags.Name
}