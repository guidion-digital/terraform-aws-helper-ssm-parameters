module "these_tags" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = var.project
  name      = var.application_name
  delimiter = "-"

  tags = {
    "Terraform"   = "true",
    "Module"      = "app-lambda",
    "project"     = var.project,
    "application" = var.application_name,
    "stage"       = var.stage
  }
}

locals {
  parameters = {
    for key, value in var.parameters : key => {
      parameter_name = key
      parameter_configuration = merge(value, {
        tags = merge(module.these_tags.tags, value.tags)
      })
    }
  }
}

module "ssm_parameter" {
  source = "./modules/ssm-parameter"

  for_each = local.parameters

  parameter_name          = each.value.parameter_name
  parameter_configuration = each.value.parameter_configuration
}
