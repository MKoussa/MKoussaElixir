defmodule MkoussaelixirWeb.ProductAPIControllerTest do
  use MkoussaelixirWeb.ConnCase

  import Mkoussaelixir.ProductAPIsFixtures

  alias Mkoussaelixir.ProductAPIs.ProductAPI

  @create_attrs %{
    link: "some link",
    title: "some title"
  }
  @update_attrs %{
    link: "some updated link",
    title: "some updated title"
  }
  @invalid_attrs %{link: nil, title: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all productapis", %{conn: conn} do
      conn = get(conn, ~p"/api/productapis")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product_api" do
    test "renders product_api when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/productapis", product_api: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/productapis/#{id}")

      assert %{
               "id" => ^id,
               "link" => "some link",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/productapis", product_api: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product_api" do
    setup [:create_product_api]

    test "renders product_api when data is valid", %{
      conn: conn,
      product_api: %ProductAPI{id: id} = product_api
    } do
      conn = put(conn, ~p"/api/productapis/#{product_api}", product_api: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/productapis/#{id}")

      assert %{
               "id" => ^id,
               "link" => "some updated link",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product_api: product_api} do
      conn = put(conn, ~p"/api/productapis/#{product_api}", product_api: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product_api" do
    setup [:create_product_api]

    test "deletes chosen product_api", %{conn: conn, product_api: product_api} do
      conn = delete(conn, ~p"/api/productapis/#{product_api}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/productapis/#{product_api}")
      end
    end
  end

  defp create_product_api(_) do
    product_api = product_api_fixture()
    %{product_api: product_api}
  end
end
