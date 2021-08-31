variable "location" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "ovoc_image_offer"{
    type = string
    default = "audcovoc"
}

variable "ovoc_image_sku"{
    type = string
    default = "acovoce4azure"
}


variable "ovoc_vm_instance_type" {
    type = string
    default = "Standard_D8as_v4"
}

variable "ovoc_admin_username" {
    type = string
    default = "ovocZdmin"
    sensitive = true
}

variable "ovoc_admin_password" {
    type = string
    default = "pwd@4ovoc"
    sensitive = true
}


variable "ovoc_data_disk_size_gb" {
    type = number
    default = 512
}


