variable "hetzner_token" {}

provider "hcloud" {
	token = var.hetzner_token
}
