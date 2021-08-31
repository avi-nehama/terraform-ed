variable "location" {
    type = string
}

variable "resource_group_name" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "ump_instance_type" {
    type    = string
    default = "Standard_D2a_v4" 
}

