Part of the [Terrappy framework](https://github.com/guidion-digital/terrappy).

---

Creates SSM Parameters. See [examples](./examples/test_app/main.tf) for usage.

Values to `var.parameters{}.value` are automatically treated as secure, meaning that `var.parameters{}.type` is set to `SecureString`. This can be overridden by setting the type to `String` if desired. Conversely, values to `var.parameters{}.insecure_value` are treated as insecure `String` types by default (which can also be overridden).
