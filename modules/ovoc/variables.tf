variable "location" {
    type = string
}

variable "env_name" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "ovoc_vm_instance_type" {
    type = string
    default = "Standard_D8as_v4"
}
