module "ssm_parameters" {
  source = "../../"

  project          = "test"
  application_name = "test"
  stage            = "test"

  parameters = {
    "foobar_sensitive" = {
      value = "foobar"

      tags = {
        "foo" = "bar"
      }
    }

    "foobar_non_sensitive" = {
      insecure_value = "foobar"
    }

    "foobar_non_sensitive_ignore_changes" = {
      insecure_value = "foobar"
      ignore_changes = true
    }
  }
}

output "ssm_parameter_arns" {
  value = module.ssm_parameters.arns
}
