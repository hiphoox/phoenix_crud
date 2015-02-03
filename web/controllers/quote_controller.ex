defmodule PhoenixCrud.QuoteController do
  use Phoenix.Controller
  require IEx
   
  # alias PhoenixCrud.Router
  import PhoenixCrud.Router.Helpers

  plug :action

  def homepage(conn, _params) do
    conn
    |> assign(:quote, PhoenixCrud.Quote.Queries.random)
    |> render("show.html")
  end
  
  def index(conn, _params) do
    IEx.pry
    conn
    |> assign(:quotes, Repo.all(PhoenixCrud.Quote))
    |> render("index.html")
  end
  
  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"quote" => %{"saying" => saying, "author" => author}}) do
    q = %PhoenixCrud.Quote{saying: saying,  author: author}
    Repo.insert(q)

    redirect conn, to: quote_path(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    conn
    |> assign(:quote, Repo.get(PhoenixCrud.Quote, id))
    |> render("show.html")
  end

  def edit(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    conn
    |> assign(:quote, Repo.get(PhoenixCrud.Quote, id))
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "quote" => %{"saying" => saying, "author" => author}}) do
    {id, _} = Integer.parse(id)
    q = Repo.get(PhoenixCrud.Quote, id)
    q = %{q | saying: saying, author: author }
    Repo.update(q)
    redirect conn, to: quote_path(conn, :show, q.id)
  end

  def destroy(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    q = Repo.get(PhoenixCrud.Quote, id)
    Repo.delete(q)
    redirect conn, to: quote_path(conn, :index)
  end

end