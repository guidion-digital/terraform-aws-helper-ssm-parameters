variable "parameter_name" {
  description = "The name of the SSM parameter"
  type        = string
}

variable "parameter_configuration" {
  description = "Map of SSM parameters, and their configuration"

  type = object({
    description    = optional(string, "")
    type           = optional(string, null)
    value          = optional(string, null)
    insecure_value = optional(string, null)
    key_id         = optional(string, null)
    tier           = optional(string, "standard")
    tags           = optional(map(string), {})
  })

  validation {
    condition     = !(var.parameter_configuration.value == null && var.parameter_configuration.insecure_value == null)
    error_message = "Either 'value' or 'insecure_value' must be provided"
  }

  validation {
    condition     = !(var.parameter_configuration.value != null && var.parameter_configuration.insecure_value != null)
    error_message = "'value' and 'insecure_value' are mutually exclusive, please provide only one"
  }
}

resource "aws_ssm_parameter" "this_non_sensitive" {
  count = var.parameter_configuration.insecure_value != null ? 1 : 0

  name           = var.parameter_name
  description    = var.parameter_configuration.description
  type           = var.parameter_configuration.type != null ? var.parameter_configuration.type : "String"
  insecure_value = var.parameter_configuration.insecure_value
  tags           = var.parameter_configuration.tags
}

resource "aws_ssm_parameter" "this_sensitive" {
  count = var.parameter_configuration.value != null ? 1 : 0

  name        = var.parameter_name
  description = var.parameter_configuration.description
  type        = var.parameter_configuration.type != null ? var.parameter_configuration.type : "SecureString"
  value       = var.parameter_configuration.value
  key_id      = var.parameter_configuration.key_id
  tags        = var.parameter_configuration.tags
}
