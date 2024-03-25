defmodule Surface.CompilerTest.DebugAnnotationsUtil do
  def debug_heex_annotations_supported? do
    phoenix_live_view_version()
    |> Version.compare("0.20.0") != :lt
  end

  def debug_heex_annotations_option_supported? do
    phoenix_live_view_version()
    |> Version.match?(">= 0.20.0 and <= 0.20.9")
  end

  defmacro use_component() do
    if __MODULE__.debug_heex_annotations_option_supported?() do
      quote do
        use Surface.Component, debug_heex_annotations: true
      end
    else
      quote do
        use Surface.Component
      end
    end
  end

  defp phoenix_live_view_version do
    Application.spec(:phoenix_live_view, :vsn)
    |> to_string()
    |> Version.parse!()
  end
end
