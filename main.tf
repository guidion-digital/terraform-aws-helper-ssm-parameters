locals {
  base_tags = {
    "Terraform" = "true",
    "Module"    = "ssm-parameters",
    "project"   = var.project,
    "stage"     = var.stage
  }

  tags = var.application_name != null ? merge(local.base_tags, { "application" = var.application_name, }) : local.base_tags
}

module "these_tags" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  namespace = var.project
  name      = var.application_name
  delimiter = "-"

  tags = local.tags
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

locals {
  namespace = var.namespace != null ? var.namespace : var.application_name != null ? "/applications/${var.application_name}" : ""
}

module "ssm_parameter" {
  source = "./modules/ssm-parameter"

  for_each = local.parameters

  parameter_name          = "${local.namespace}/${each.value.parameter_name}"
  parameter_configuration = each.value.parameter_configuration
}
