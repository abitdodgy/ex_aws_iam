# ExAws IAM

Easily interact with the AWS IAM API to work with users, access keys, and much more. This is an IAM service module for [ExAws](https://github.com/ex-aws/ex_aws).

```elixir
user =
  "my_user"
  |> Iam.create_user(path: "/my/path")
  |> ExAws.request()
  |> Iam.to_user()

%Iam.User{
  arn: "arn:aws:iam::085326204011:user",
  create_date: "2018-10-17T13:36:28Z",
  path: "/my/path/",
  username: "my_username",
  user_id: "AIDAJMIUVQAU2TW666HH2"
}

access_key =
  "my_user"
  |> Iam.create_access_key()
  |> ExAws.request()
  |> Iam.to_access_key()

%AccessKey{
  access_key_id: "AKIAJMQYDBOGSEDSCLJA",
  access_key_selector: "HMAC",
  create_date: "2018-10-17T13:50:19Z",
  secret_access_key: "WfDYxMvaYbDj+VO87DHAwzzW3rQDifiFzej7Z5a0",
  status: "Active",
  username: "my_user"
}

Iam.delete_access_key("AKIAJMQYDBOGSEDSCLJA", "my_user")
Iam.delete_user("my_user")
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

The following operations are currently available.

### User

  * ListUsers
  * GetUser
  * CreateUser
  * UpdateUser
  * DeleteUser

### AccessKey

  * ListAccessKeys
  * GetAccessKeyLastUsed
  * CreateAccessKey
  * UpdateAccessKey
  * DeleteAccessKey

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
