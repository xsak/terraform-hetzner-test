variable "hetzner_token" {}

provider "hcloud" {
	token = var.hetzner_token
}

data "hcloud_network" "nw_ahoy" {
  name = "nw_default"
}

data "hcloud_ssh_key" "ssh_omni" { 
  name = "omni"
}

##########################
resource "hcloud_network" "nw_test" {
  name = "nw_test99"
  ip_range = "10.11.0.0/16"
}

resource "hcloud_network_subnet" "sn_test" { 
  network_id = hcloud_network.nw_test.id
  type = "server"
  network_zone = "eu-central"
  ip_range = "10.11.11.0/24"
}

resource "hcloud_server" "srv_test99" { 
  name = "Test99_server"
  image = "ubuntu-18.04"
  server_type = "cx11"
  location = "fsn1"
  ssh_keys = data.hcloud_ssh_key.ssh_omni.id
}

##########################
output "default_network_data" {
  value = data.hcloud_network.nw_ahoy.ip_range
}

