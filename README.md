# ExAws IAM

Easily interact with the AWS IAM API to work with users, access keys, and any other entity. This is an IAM service module for [ExAws](https://github.com/ex-aws/ex_aws).

The lib provides a low-level `operation/3` function to build any IAM API action.

```elixir
op = Iam.operation(:list_users, max_items: 50, path: "/my/path/")
%ExAws.Operation.Query{
  action: "ListUsers",
  params: %{
    "Action" => "ListUsers",
    "MaxItems" => 50,
    "Path" => "/my/path/",
    "Version" => "2010-05-08"
  },
  parser: &ExAws.Iam.Parser.parse/2,
  path: "/my/path/",
  service: :iam
}

resp = ExAws.request(op)
{:ok,
 %{
   body: %{
     list_users_result: %{
       is_truncated: "false",
       users: [
         %{
           arn: "arn:aws:iam::085326204011:user/my/path/abitdodgy",
           create_date: "2018-10-17T00:09:19Z",
           path: "/my/path/",
           user_id: "AIDAIAPPW7ERTKFL2R3TI",
           user_name: "abitdodgy"
         }
       ]
     },
     response_metadata: %{request_id: "25c67fa6-d212-11e8-b8d6-a7951e68fc2c"}
   },
   status_code: 200
 }}
```

The lib also provides higher-level convenience functions for interacting with specific services.

```elixir
op = Iam.create_user("my_user", path: "/my/path")
%ExAws.Operation.Query{
  action: "CreateUser",
  params: %{
    "Action" => "CreateUser",
    "Path" => "/my/path",
    "UserName" => "my_user",
    "Version" => "2010-05-08"
  },
  parser: &ExAws.Iam.Parser.parse/2,
  path: "/my/path",
  service: :iam
}
```

You can also return entity structs.

```
user =
  op
  |> ExAws.request()
  |> Iam.to_user()

%Iam.User{
  arn: "arn:aws:iam::085326204011:user/my_user",
  create_date: "2018-10-17T13:36:28Z",
  path: "/my/path/",
  user_name: "my_user",
  user_id: "AIDAJMIUVQAU2TW666HH2"
}

Iam.delete_user("my_user")
```

Parsers are currently implemented for the following actions:

  * CreateAccessKey
  * CreateGroup
  * CreateUser
  * DeleteAccessKey
  * DeleteGroup
  * DeleteUser
  * GetAccessKeyLastUsed
  * GetGroup
  * GetUser
  * ListAccessKeys
  * ListGroup
  * ListUsers
  * UpdateAccessKey
  * UpdateGroup
  * UpdateUser

You can also provider your own parser as long as it implements a `parse/2` function.

```elixir
Iam.operation(:list_users, parser: &MyParser.parse/2)
```

## Installation

Ensure that both `ex_aws`, its dependencies, and `ex_aws_iam` are in your list of dependencies.

```elixir
def deps do
  [
    {:ex_aws, "~> 2.0"},
    {:ex_aws_iam, "~> 0.1.0"},
    {:hackney, "~> 1.9"},
    {:sweet_xml, "~> 0.6"}
  ]
end
```

Ensure that ExAws is properly configured.

```
config :ex_aws,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role]
```

## Usage

[See the documentation](https://hexdocs.pm/ex_aws_iam/ExAws.Iam.html) for details.

## License

The MIT License

Copyright (c) 2018 Mohamad El-Husseini

Permission is hereby granted, free of charge, 
to any person obtaining a copy of this software and 
associated documentation files (the "Software"), to 
deal in the Software without restriction, including 
without limitation the rights to use, copy, modify, 
merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom 
the Software is furnished to do so, 
subject to the following conditions:

The above copyright notice and this permission notice 
shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
