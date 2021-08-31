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

variable "ump_admin_username" {
    type = string
    default = "umpZdmin"
    sensitive = true
}

variable "ump_admin_password" {
    type = string
    default = "pwd@4ump"
    sensitive = true
}
