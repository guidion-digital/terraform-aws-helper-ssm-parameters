module "ssm_parameters" {
  source = "../../"

  project          = "test"
  application_name = "test"
  stage            = "test"

  parameters = {
    "sensitive" = {
      value = "foobar"

      tags = {
        "foo" = "bar"
      }
    }

    "non_sensitive" = {
      insecure_value = "foobar"
    }
  }
}
