
# Variables
variable "vsphere_server" {
  type = string
  default = "default-value"
}
variable "vsphere_user" {
  type = string
  default = "default-value"
}
variable "vsphere_password" {
  type = string
  default = "default-value"
}
variable "datacenter" {
  type = string
  default = "default-value"
}
variable "network_name" {
  type = string
  default = "default-value"
}
variable "esxi_vsphere_ip" {
  type = string
  default = "default-value"
}
variable "esxi_ip" {
  type = string
  default = "default-value"
}


# Data sourcesname
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_network" "network" {
  name = var.network_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "store1" {
  name = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "ESXi1" {
    name = var.esxi_vsphere_ip
    datacenter_id = data.vsphere_datacenter.dc.id  
}

data "vsphere_virtual_machine" "vCenter" {
  name = "vCenter"
  datacenter_id = data.vsphere_datacenter.dc.id
}

