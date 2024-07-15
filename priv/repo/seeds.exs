# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Mkoussaelixir.Repo.insert!(%Mkoussaelixir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
for catTitle <- ["LogueSDK", "Modulation", "Delay", "Reverb", "Oscillator"] do
  {:ok, _} = Mkoussaelixir.Catalog.create_category(%{title: catTitle})
end

alias Mkoussaelixir.Catalog
alias Mkoussaelixir.Catalog.Product

for product <- [
      %{
        title: "Stutter",
        description: "Korg LogueSDK Stutter Mod FX",
        description_link: "#{MkoussaelixirWeb.Endpoint.url()}/loguesdk/stuttermodeffect",
        price: 2.99,
        views: 0,
        categories: ["LogueSDK", "Modulation"]
      },
      %{
        title: "Reverse Echo",
        description: "Korg LogueSDK Reverse Echo Delay FX",
        description_link: "#{MkoussaelixirWeb.Endpoint.url()}/loguesdk/reverseechodelayeffect",
        price: 2.99,
        views: 0,
        categories: ["LogueSDK", "Delay"]
      }
    ] do
  {:ok, _} = Mkoussaelixir.Catalog.create_product(product)
end
