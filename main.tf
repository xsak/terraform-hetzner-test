resource "hcloud_ssh_key" "key_test99" {
  name = "Test99-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}


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
  ssh_keys = [ hcloud_ssh_key.key_test99.id ]
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
