data opentelekomcloud_images_image_v2 debian {
  name = "Standard_Debian_10_latest"
}

data opentelekomcloud_networking_network_v2 ext {
  name = "admin_external_net"
}

resource opentelekomcloud_vpc_v1 vpc {
  cidr = "192.168.0.0/16"
  name = "vpc-do-not-delete-pls"
}

resource opentelekomcloud_compute_keypair_v2 kp {
  name = "keypair-do-not-delete-pls"
}

resource opentelekomcloud_vpc_subnet_v1 subnet {
  cidr       = "192.168.0.0/16"
  gateway_ip = "192.168.0.1"
  name       = "subnet-do-not-delete-pls"
  vpc_id     = opentelekomcloud_vpc_v1.vpc.id
}

output vpc_id {
  value = opentelekomcloud_vpc_v1.vpc.id
}

output network_id {
  value = opentelekomcloud_vpc_subnet_v1.subnet.id
}

output subnet_id {
  value = opentelekomcloud_vpc_subnet_v1.subnet.subnet_id
}

output image_id {
  value = data.opentelekomcloud_images_image_v2.debian.id
}

output keypair_name {
  value = opentelekomcloud_compute_keypair_v2.kp.name
}

output external_gw_id {
  value = data.opentelekomcloud_networking_network_v2.ext.id
}
