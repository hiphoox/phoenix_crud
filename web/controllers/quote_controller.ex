defmodule PhoenixCrud.QuoteController do
  use Phoenix.Controller

  plug :action

  def homepage(conn, _params) do
    render conn, "homepage.html"
  end
  
  def index(conn, _params) do
    conn
    |> assign(:quotes, Repo.all(PhoenixCrud.Quote))
    |> render("index.html")
  end
  
end