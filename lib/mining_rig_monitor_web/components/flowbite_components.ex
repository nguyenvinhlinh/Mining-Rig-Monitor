defmodule MiningRigMonitorWeb.FlowbiteComponents do
  @moduledoc """
  Provides Flowbite  UI components.

  At first glance, this module may seem daunting, but its goal is to provide
  core building blocks for your application, such as modals, tables, and
  forms. The components consist mostly of markup and are well-documented
  with doc strings and declarative assigns. You may customize and style
  them in any way you want, based on your application growth and needs.

  The default components use Tailwind CSS, a utility-first CSS framework.
  See the [Tailwind CSS documentation](https://tailwindcss.com) to learn
  how to customize them or feel free to swap in another framework altogether.

  Icons are provided by [heroicons](https://heroicons.com). See `icon/1` for usage.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  import MiningRigMonitorWeb.Gettext



  @doc ~S"""
  Renders a table with flowbite styling.

  ## Examples

      <.flowbite_table id="users" rows={@users}>
        <:col :let={user} label="id"><%= user.id %></:col>
        <:col :let={user} label="username"><%= user.username %></:col>
      </.flowbite_table>
  """
  attr :id, :string, required: true
  attr :rows, :list, required: true
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
    default: &Function.identity/1,
    doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
  end

  slot :action, doc: "the slot for showing user actions in the last table column"

  def flowbite_table(assigns) do
    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end

    ~H"""
    <div class="overflow-hidden shadow">
      <table class="min-w-full divide-y divide-gray-200 table-fixed dark:divide-gray-600">
        <thead class="bg-gray-100 dark:bg-gray-700">
          <tr>
            <th :for={col <- @col} class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
              <%= col[:label] %>
            </th>
            <th :if={@action != []} class="p-4 text-xs font-medium text-left text-gray-500 uppercase dark:text-gray-400">
              <%= gettext("Actions") %>
            </th>
          </tr>
        </thead>
          <tbody class="bg-white divide-y divide-gray-200 dark:bg-gray-800 dark:divide-gray-700"
                 id={@id}
                 phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"} >
            <tr :for={row <- @rows} id={@row_id && @row_id.(row)} class="hover:bg-gray-100 dark:hover:bg-gray-700">
            <td
              :for={{col, i} <- Enum.with_index(@col)}
              phx-click={@row_click && @row_click.(row)}
              class={["p-4 text-base font-medium text-gray-900 whitespace-nowrap dark:text-white", @row_click && "hover:cursor-pointer"]}
              >
                <%= render_slot(col, @row_item.(row)) %>

            </td>
            <td :if={@action != []} class="p-4 space-x-2 whitespace-nowrap">
              <%= for action <- @action do %>
                <%= render_slot(action, @row_item.(row)) %>
              <% end %>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    """
  end
end
