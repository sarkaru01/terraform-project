locals {

  resource_name_prefix = "${var.business_unit}-${var.environment}" #sap-dev
  project_tags = {                                                 #project tag is the name
    evn      = var.environment                                     #dev
    bu       = var.business_unit                                   #sap
    projectx = "sap"
    finance  = "101"
  }

}