defmodule ExAws.Iam.TestMacro do
  import SweetXml, only: [sigil_x: 2]

  defmacro defparser(action, opts) do
    action_name = to_camel(action)

    fields =
      opts
      |> Keyword.get(:fields)
      |> Enum.map(fn field ->
        compile(field)
      end)

    quote do
      def parse(xml, unquote(action_name)) do
        SweetXml.xpath(xml, ~x"//#{unquote(xml_path(action_name))}", [
          {
            unquote(xml_node(action_name)),
            [~x"//#{unquote(xml_path(action_name))}" | unquote(fields)]
          }
        ])
      end

      def fields do
        unquote(fields)
      end
    end
  end

  defp xml_path(action), do: action <> "Response"
  defp xml_node(action), do: xml_path(action) |> to_snake()

  defp compile(field) when is_atom(field) do
    quote do
      {unquote(field), ~x"./#{unquote(to_camel(field))}/text()"s}
    end
  end

  defp compile({:sigil_x, _, _} = field), do: field

  defp compile({key, value}) do
    quote do
      {unquote(key), unquote(compile(value))}
    end
  end

  defp compile(list) when is_list(list) do
    Enum.map(list, fn field ->
      compile(field)
    end)
  end

  defp to_camel(atom) do
    atom
    |> Atom.to_string()
    |> Macro.camelize()
  end

  defp to_snake(string) do
    string
    |> Macro.underscore()
    |> String.to_atom()
  end
end