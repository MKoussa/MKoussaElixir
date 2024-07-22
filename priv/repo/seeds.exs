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

alias Mkoussaelixir.Catalog.Category
alias Mkoussaelixir.Catalog
alias Mkoussaelixir.Catalog.Product

for product <- [
      %{
        title: "Stutter",
        description:
          "Stutter is a Mod FX that samples up to 0.001953125 seconds of audio and repeats the sample up to 50 times.",
        description_link: "#{MkoussaelixirWeb.Endpoint.url()}/loguesdk/stuttermodeffect",
        price: 2.99,
        views: 0
      },
      %{
        title: "Reverse Echo",
        description:
          "Reverse Echo samples the incoming audio and plays it back in reverse and repeats it. You can set both the audio sample length and how many times it repeats.",
        description_link: "#{MkoussaelixirWeb.Endpoint.url()}/loguesdk/reverseechodelayeffect",
        price: 2.99,
        views: 0
      }
    ] do
  {:ok, _} = Mkoussaelixir.Catalog.create_product(product)
end
