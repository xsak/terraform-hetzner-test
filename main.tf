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
  ip_range = "10.111.0.0/16"
}

resource "hcloud_network_subnet" "subn_test" { 
  network_id = hcloud_network.nw_test.id
  type = "server"
  network_zone = "eu-central"
  ip_range = "10.111.111.0/24"
}

resource "hcloud_server" "srv_test99" { 
  name = "Test99-server"
  image = "ubuntu-18.04"
  server_type = "cx11"
  location = "fsn1"
  ssh_keys = [ data.hcloud_ssh_key.ssh_omni.id ]
  labels = {
    projet = "Test",
    BestLabel = "Rekettye"
  }
  backups = false
}

resource "hcloud_server_network" "srv_nw_test99" {
  server_id = hcloud_server.srv_test99.id
  network_id = hcloud_network.nw_test.id
}

resource "hcloud_volume" "test99_volX" {
  name = "Test99_volume_X"
  size = 50
  server_id = hcloud_server.srv_test99.id
  automount = true
  format = "ext4"
}

// resource "hcloud_volume_attachment" "test99" {
//   volume_id = hcloud_volume.test99_volX.id
//   server_id = hcloud_server.srv_test99.id
//   automount = true
// }

##########################
output "default_network_data" {
  value = data.hcloud_network.nw_ahoy.ip_range
}

output "Test99_Server_ip" {
  value = hcloud_server.srv_test99.ipv4_address
}

output "Test99_Server_location" {
  value = hcloud_server.srv_test99.location
}

output "Test99_Server_status" {
  value = hcloud_server.srv_test99.status
}

