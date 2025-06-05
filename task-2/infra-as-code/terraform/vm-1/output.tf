output "ip_address_public" {
  value = module.default.public_ip
}

output "ip_address_private" {
  value = module.default.private_ip
}

output "data_rendered" {
  value = module.default.rendered
}