# resource "vsphere_datacenter" "prod_datacenter" {
#   name = "prod_datacenter"
# }

# data "vsphere_datacenter" "prod_datacenter" {
#   name = "prod_datacenter"
# }

# resource "vsphere_folder" "VMs" {
#   path = "VMs"
#   type = "vm"
#   datacenter_id = vsphere_datacenter.prod_datacenter.id
# }

data "vsphere_datacenter" "prod_datacenter" {
  name = "prod_datacenter"
}

data "vsphere_compute_cluster" "compute_cluster" {
  name = "compute-cluster"
  datacenter_id = data.vsphere_datacenter.prod_datacenter.id
}

# resource "vsphere_compute_cluster" "compute_cluster" {
#   name            = "terraform-compute-cluster-test"
#   datacenter_id   = data.vsphere_datacenter.prod_datacenter.moid <<- Moid quand la ressource n'est pas encore créée

#   drs_enabled          = true
#   drs_automation_level = "fullyAutomated"

#   ha_enabled = true
# #   depends_on = [
# #     vsphere_datacenter.prod_datacenter
# #   ]
# }


# resource "vsphere_host" "esx-01" {
#   hostname = "192.168.86.131"
#   username = "root"
#   password = "Admin123/"
#   cluster  = data.vsphere_compute_cluster.compute_cluster.id
# }

data "vsphere_host" "esx01" {
  name = "192.168.86.131"
  datacenter_id = data.vsphere_datacenter.prod_datacenter.id
}

data "vsphere_datastore" "ds01" {
  name = "datastore1 (1)"
  datacenter_id = data.vsphere_datacenter.prod_datacenter.id
}

data "vsphere_network" "net01" {
  name = "VM Network"
  datacenter_id = data.vsphere_datacenter.prod_datacenter.id
}

resource "vsphere_virtual_machine" "vm01" {
    name = "vm-01"
    resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
    datastore_id = data.vsphere_datastore.ds01.id

    num_cpus = 2
    memory = 1024

    network_interface {
      network_id = data.vsphere_network.net01.id
    }

    wait_for_guest_ip_timeout = -1
    wait_for_guest_net_timeout = -1

    disk {
      label = "disk01"
      thin_provisioned = true
      size = 32
    }
    cdrom {
      datastore_id = data.vsphere_datastore.ds01.id
      path = "/ISOs/ubuntu-22.04.2-desktop-amd64.iso"
    }

    guest_id = "ubuntu64Guest"
  
}