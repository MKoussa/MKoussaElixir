defmodule MkoussaelixirWeb.ErrorJSON do
  @moduledoc """
  This module is invoked by your endpoint in case of errors on JSON requests.

  See config/config.exs.
  """

  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end
  def render("404.json", assigns) do
    %{
      errors: %{
        detail:
          "I'm sorry, I can't seem to find anything at #{assigns.conn.request_path || "that place"}."
      }
    }
  end

  def render("401.json", _assigns) do
    %{
      errors: %{
        detail: "You are not authenticated. Please Try Again.}."
      }
    }
  end

  def render("500.json", _assigns) do
    %{
      errors: %{
        detail: "You are Lost.}."
      }
    }
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
