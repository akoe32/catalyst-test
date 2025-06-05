variable "create_extra_disk" {
  description = "variabel create_extra_disk for enable attched disk"
  default = "false"
}

variable "aws_region" {
  default = ""
}


variable "name" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "iam_instance_profile" {
  default = ""
}

variable "environment" {
  default = ""
}

variable "ami" {
  default = ""
}

variable "project" {
  default = ""
}

variable "tags" {
  default     = {}
  type        = map(string)
}

variable "instance_type" {
  # type   = list(string)
  # default = []
  default     = {}
}

variable "subnets" {
  type   = list(string)
  default = []
  # type        = list(string)
  # default     = {}
}

variable "root_disk" {
  default = ""
}

variable "root_disk_type" {
  default = ""
}

variable "additional_disk" {
  default = ""
}

variable "additional_disk_type" {
  default = ""
}

variable "count_instance" {
  default = ""
}

variable "count_start" {
  default = ""
}

variable "startup_script" {
  default = ""
}

variable "agriaku-division" {
  default = ""
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "List of Availability Zones"
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of security_groups"
}