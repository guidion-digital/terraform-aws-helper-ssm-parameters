variable "parameter_name" {
  description = "The name of the SSM parameter"
  type        = string
}

variable "parameter_configuration" {
  description = "Map of SSM parameters, and their configuration"

  type = object({
    description    = optional(string, "")
    type           = optional(string, null)
    ignore_changes = optional(bool, false)
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
