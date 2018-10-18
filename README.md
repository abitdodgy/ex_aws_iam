# ExAws IAM

This is an IAM service module for [ExAws](https://github.com/ex-aws/ex_aws).

This is a work in progress and the API may change. The following operations are available:

### User

  * ListUsers
  * GetUser
  * CreateUser
  * UpdateUser
  * DeleteUser

### AccessKey

  * ListAccessKeys
  * GetAccessKeyLastUsed
  * GetAccessKey
  * UpdateAccessKey
  * DeleteAccessKey

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_aws_iam` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
  	{:ex_aws, "~> 2.0"},
    {:ex_aws_iam, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_aws_iam](https://hexdocs.pm/ex_aws_iam).
