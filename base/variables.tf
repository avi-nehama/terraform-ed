variable "customer_name" {
  type = string
}

variable "location" {
  type    = string
  default = "westus2"
}

variable "create_network" {
  type        = bool
  default     = true
  description = "Whether or not a network should be created. If set to false, then a mng_subnet_id should be provided"
}

variable "mng_subnet_id" {
  type        = string
  default     = "/subscriptions/<subs_id>/..."
  description = "Override this variable value when you want to deploy the resources into an existing network"
}
