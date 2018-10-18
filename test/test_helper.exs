ExUnit.start()

defmodule ExAws.Iam.TestHelper do
  def read_file(entity, name) do
    File.read!("test/support/responses/#{entity}/#{name}.xml")    
  end
end
