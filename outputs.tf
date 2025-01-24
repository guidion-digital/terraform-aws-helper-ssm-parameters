output "arns" {
  value = { for k, v in module.ssm_parameter : k => v.arn }
}
