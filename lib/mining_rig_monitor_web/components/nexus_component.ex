defmodule MiningRigMonitorWeb.NexusComponents do
  use Phoenix.Component

  alias Phoenix.LiveView.JS
  import MiningRigMonitorWeb.Gettext

  @doc """
  Shows the flash group with standard titles and content.

  ## Examples

      <.flash_group flash={@flash} />
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
        <.nx_icon name="hero-arrow-path" class="ml-1 h-3 w-3 motion-safe:animate-spin" />
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
        <.nx_icon name="hero-arrow-path" class="ml-1 h-3 w-3 motion-safe:animate-spin" />
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
             "fixed top-2 right-2 mr-2 w-80 sm:w-96 z-50 rounded-lg p-3 ring-1",
             @kind == :info &&  "alert alert-success alert-soft",
             @kind == :error && "alert alert-error alert-soft"
             ]}
      {@rest}
    >
      <span class="iconify lucide--info size-5"></span>

      <span>{@title}{msg}</span>

      <button type="button" class="group absolute top-1 right-1 p-2" aria-label={gettext("close")}>
        <.nx_icon name="hero-x-mark-solid" class="h-5 w-5 opacity-40 group-hover:opacity-70" />
      </button>
    </div>
    """
  end

  @doc """
  Renders a [Heroicon](https://heroicons.com).

  Heroicons come in three styles – outline, solid, and mini.
  By default, the outline style is used, but solid and mini may
  be applied by using the `-solid` and `-mini` suffix.

  You can customize the size and colors of the icons by setting
  width, height, and background color classes.

  Icons are extracted from the `deps/heroicons` directory and bundled within
  your compiled app.css by the plugin in your `assets/tailwind.config.js`.

  ## Examples

      <.icon name="hero-x-mark-solid" />
      <.icon name="hero-arrow-path" class="ml-1 w-3 h-3 animate-spin" />
  """
  attr :name, :string, required: true
  attr :class, :string, default: nil
  attr :id, :string, default: nil

  def nx_icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} id={@id}/>
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
end
