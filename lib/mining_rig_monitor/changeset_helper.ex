defmodule MiningRigMonitor.ChangesetHelper do
  import Ecto.Changeset

  def validate_field_list_exist_together(changeset, field_list, keyword\\[]) when Kernel.is_list(field_list) do
    field_value_list = Enum.map(field_list, fn(field) ->
      {_type_changes_data, value} = fetch_field(changeset, field)
      value
    end)

    field_list_length = Kernel.length(field_list)

    field_value_not_nil_list = Enum.filter(field_value_list, fn(e) ->
      Kernel.is_nil(e) == false
    end)

    if Kernel.length(field_value_not_nil_list) == 0 or Kernel.length(field_value_not_nil_list) == field_list_length do
      changeset
    else
      key = Keyword.get(keyword, :error_key, List.first(field_list))
      changeset
      |> add_error(key, "Must be exist together #{field_list |> Enum.join(",")}")
    end
  end
end
