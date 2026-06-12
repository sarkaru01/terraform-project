variable "rg_name" {
  description = "name of the resource group"
  type        = string #list of string #map #boolean
  #it will accept only on single value and that value should be string
  default = "us-tf-rg"
}

variable "location" {
  description = "location of the resource group"
  type        = string
  default     = "east us"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "business_unit" {
  type    = string
  default = "sap"
}

variable "subnet_name" {
  type    = string
  default = "web-subnet"
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}