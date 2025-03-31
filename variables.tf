variable "project" {
  description = "The project name"
  type        = string
}

variable "application_name" {
  description = "The application name. Used for namespacing if var.namespace is not supplied"
  type        = string
  default     = null
}

variable "namespace" {
  description = "Used for naming and tagging. Overrides var.application_name for namespacing if supplied"
  type        = string
  default     = null
}

variable "stage" {
  description = "The stage name"
  type        = string
}

variable "parameters" {
  description = "Map of SSM parameters, and their configuration"

  type = map(object({
    description    = optional(string, "")
    type           = optional(string, null)
    value          = optional(string, null)
    insecure_value = optional(string, null)
    ignore_changes = optional(bool, false)
    key_id         = optional(string, null)
    tier           = optional(string, "standard")
    tags           = optional(map(string), {})
  }))
}
