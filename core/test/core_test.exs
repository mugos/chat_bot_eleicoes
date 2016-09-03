defmodule CoreTest do
  use ExUnit.Case
  doctest Core

  test "test test" do
    assert 1 + 1 == 2
  end

  test "test things are being inserted" do
    # Clean Database
    RethinkDB.Query.table("tasks") |> RethinkDB.Query.delete |> Core.Database.run

    table_query = RethinkDB.Query.table("tasks")

    q = RethinkDB.Query.insert(table_query, %{name: "Hello", attr: "World"})

    {:ok, %RethinkDB.Record{data: %{"inserted" => 1, "generated_keys" => [key]}}} = Core.Database.run(q)

    {:ok, %RethinkDB.Collection{data: [%{"id" => ^key, "name" => "Hello", "attr" => "World"}]}} = Core.Database.run(table_query)
  end

  test "create and validate" do
    # Clean Database
    RethinkDB.Query.table("tasks")
      |> RethinkDB.Query.delete
      |> Core.Database.run

    # Create tasks
    insert_query = RethinkDB.Query.table("tasks")
      |> RethinkDB.Query.insert(%{name: "Carlos", attr: "22"})
      |> Core.Database.run

    { :ok, %RethinkDB.Record{data: %{"inserted" => 1, "generated_keys" => [key]}} } = insert_query
  end

  test "read" do
    # Clean Database
    RethinkDB.Query.table("tasks")
      |> RethinkDB.Query.delete
      |> Core.Database.run

    # Create tasks
    RethinkDB.Query.table("tasks")
      |> RethinkDB.Query.insert(%{"name" => "Carlos", "attr" => "22"})
      |> Core.Database.run

    # Read query
    read_query = RethinkDB.Query.table("tasks")
      |> Core.Database.run

    # IO.inspect read_query

    { :ok, %RethinkDB.Collection{data: [%{"id" => key, "name" => "Carlos", "attr" => "22"}]} } = read_query
  end
end
