output "arn" {
  value = var.parameter_configuration.insecure_value != null ? aws_ssm_parameter.this_non_sensitive[0].arn : aws_ssm_parameter.this_sensitive[0].arn
}
