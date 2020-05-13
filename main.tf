variable "hetzner_token" {}

provider "hcloud" {
	token = var.hetzner_token
}

data "hcloud_network" "nw_ahoy" {
  name = "nw_default"
}

output "default_network_data" {
  value = data.hcloud_network.nw_ahoy.ip_range
}
