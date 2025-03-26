# We have to have four resource declerations for the four different configuration possibilities because:
#
# - key_id can not be null, so we have to either provide it or not provide it
# - lifecycle must be static, so same as above

resource "aws_ssm_parameter" "this_non_sensitive" {
  count = var.parameter_configuration.insecure_value != null && var.parameter_configuration.ignore_changes == false ? 1 : 0

  name           = var.parameter_name
  description    = var.parameter_configuration.description
  type           = var.parameter_configuration.type != null ? var.parameter_configuration.type : "String"
  insecure_value = var.parameter_configuration.insecure_value
  tags           = var.parameter_configuration.tags
}

resource "aws_ssm_parameter" "this_sensitive" {
  count = var.parameter_configuration.value != null && var.parameter_configuration.ignore_changes == false ? 1 : 0

  name        = var.parameter_name
  description = var.parameter_configuration.description
  type        = var.parameter_configuration.type != null ? var.parameter_configuration.type : "SecureString"
  value       = var.parameter_configuration.value
  key_id      = var.parameter_configuration.key_id
  tags        = var.parameter_configuration.tags
}

resource "aws_ssm_parameter" "this_non_sensitive_ignore_changes" {
  count = var.parameter_configuration.insecure_value != null && var.parameter_configuration.ignore_changes ? 1 : 0

  depends_on = [aws_ssm_parameter.this_non_sensitive]

  name           = var.parameter_name
  description    = var.parameter_configuration.description
  type           = var.parameter_configuration.type != null ? var.parameter_configuration.type : "String"
  insecure_value = var.parameter_configuration.insecure_value
  tags           = var.parameter_configuration.tags

  lifecycle {
    ignore_changes = [insecure_value]
  }
}

resource "aws_ssm_parameter" "this_sensitive_ignore_changes" {
  count = var.parameter_configuration.value != null && var.parameter_configuration.ignore_changes ? 1 : 0

  depends_on = [aws_ssm_parameter.this_sensitive]

  name        = var.parameter_name
  description = var.parameter_configuration.description
  type        = var.parameter_configuration.type != null ? var.parameter_configuration.type : "SecureString"
  value       = var.parameter_configuration.value
  key_id      = var.parameter_configuration.key_id
  tags        = var.parameter_configuration.tags

  lifecycle {
    ignore_changes = [value]
  }
}
