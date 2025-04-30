defmodule MiningRigMonitorWeb.NexusComponents do
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  import MiningRigMonitorWeb.Gettext

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.nx_flash_group flash={@flash} />
  """
  attr :flash, :map, required: true, doc: "the map of flash messages"
  attr :id, :string, default: "flash-group", doc: "the optional id of flash container"

  def nx_flash_group(assigns) do
    ~H"""
    <div id={@id} aria-live="polite">
      <.nx_flash kind={:info} flash={@flash} />
      <.nx_flash kind={:error} flash={@flash} />

      <.nx_flash
        id="client-error"
        kind={:error}
        title={gettext("We can't find the internet")}
        phx-disconnected={nx_show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={nx_hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
      >


    {gettext("Attempting to reconnect")}
      </.nx_flash>

      <.nx_flash
        id="server-error"
        kind={:error}
        title={gettext("Something went wrong!")}
        phx-disconnected={nx_show(".phx-client-error #client-error") |> JS.remove_attribute("hidden")}
        phx-connected={nx_hide("#client-error") |> JS.set_attribute({"hidden", ""})}
        hidden
        >
        {gettext("Hang in there while we get back on track")}
      </.nx_flash>
    </div>
    """
  end

  @doc """
  Renders flash notices.

  ## Examples

  <.nx_flash kind={:info} flash={@flash} />
  <.nx_flash kind={:info} phx-mounted={show("#flash")}>Welcome Back!</.flash>
  """
  attr :id, :string, doc: "the optional id of flash container"
  attr :flash, :map, default: %{}, doc: "the map of flash messages to display"
  attr :title, :string, default: nil
  attr :kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"
  slot :inner_block, doc: "the optional inner block that renders the flash message"

  def nx_flash(assigns) do
    assigns = assign_new(assigns, :id, fn -> "flash-#{assigns.kind}" end)

    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> nx_hide("##{@id}")}
      role="alert"
      class={[
             "fixed top-2 right-2 mr-2 w-80 sm:w-96 z-100 rounded-lg p-3 ring-1",
             @kind == :info &&  "alert alert-success alert-soft",
             @kind == :error && "alert alert-error alert-soft"
             ]}
      {@rest}
    >
      <svg :if={@kind == :info} xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
           stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-info-icon lucide-info">
        <circle cx="12" cy="12" r="10"/>
        <path d="M12 16v-4"/>
        <path d="M12 8h.01"/>
      </svg>

      <svg :if={@kind == :error} xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
           stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-x-icon lucide-circle-x">
        <circle cx="12" cy="12" r="10"/>
        <path d="m15 9-6 6"/>
        <path d="m9 9 6 6"/>
      </svg>
      <span>{@title}{msg}</span>
    </div>
    """
  end

  ## JS Commands

  def nx_show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      time: 300,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def nx_hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end


  @doc """
  nx_error/1 , receives error tuple {2 elemens} from FormField.errors.
  It will do string replacement and return error string
  """
  def nx_error({msg, opts}) do
    if count = opts[:count] do
      String.replace(msg, "%{count}", "#{count}", [global: true])
    else
      msg
    end
  end

  @doc """
  input_class/1 receives %FormField{} params. And return <input>'s class name.
  It's useful for form input error display!
  """
  def input_class(%Phoenix.HTML.FormField{}=form_field) do
    if used_input?(form_field) && form_field.errors != [] do
      "input w-full input-error"
    else
      "input w-full"
    end
  end
end
