locals {
  # This is a hack to account for the fact that we have four possible resources. It's done like this because the logic to work out which ones need outputting became unreadable
  non_sensitive                = try(aws_ssm_parameter.this_non_sensitive[0].arn, null)
  sensitive                    = try(aws_ssm_parameter.this_sensitive[0].arn, null)
  non_sensitive_ignore_changes = try(aws_ssm_parameter.this_non_sensitive_ignore_changes[0].arn, null)
  sensitive_ignore_changes     = try(aws_ssm_parameter.this_sensitive_ignore_changes[0].arn, null)

  arn = one(compact([local.non_sensitive, local.non_sensitive_ignore_changes, local.sensitive, local.sensitive_ignore_changes]))
}

output "arn" {
  value = local.arn
}
