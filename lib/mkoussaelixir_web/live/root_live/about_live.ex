defmodule MkoussaelixirWeb.AboutLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="root-transition">
      <h2>ABOUT</h2>
      <p>Hello World! I'm Matthew Koussa and this is my site!</p>
      <p>
        Here you'll find my forrays into digital synthesis via the
        <.link navigate={~p"/loguesdk"}>Korg LogueSDK</.link>
        or <.link navigate={~p"/blorp"}>Blorp</.link>, a synthesizer built using the p5 Javscript library.
      </p>
      <p>
        Checkout my <a href="https://mkoussa.bandcamp.com">Bandcamp</a>, where you can stream/download/buy my music!
      </p>
      <p>Find me on <.link href="https://www.youtube.com/themkoussa">YouTube</.link></p>
      <p>This site is powered by:</p>
      <author>
        Elixir <%= Application.spec(:elixir, :vsn) %> | Phoenix <%= Application.spec(:phoenix, :vsn) %> |
        <a href="https://www.gigalixir.com/">Gigalixir</a>
        | LiveView <%= Application.spec(:live_view, :vsn) %>
      </author>

      <h3>SITE MAP</h3>
      <p>
        Give me your <i>money</i>. I mean, in a way. Here you can buy Korg LogueSDK pre-compiled binary files of FX. Or at least, you will be once I integrate with Shopify or Stripe, lol!
      </p>
      <.link navigate={~p"/shop/products"}>
        <.button style="width: 70%; background-color: #ffd3e9; color: #394f38; border-color: #ffd3e9; font-family: 'Six Caps'; font-size: clamp(20px, 3.5vw, 30px);">
          🗡 Shop 🗡
        </.button>
      </.link>
      <p>Precompiled file downloads and Github links to Logue-SDK projects.</p>
      <.link href={~p"/loguesdk"}>
        <.button style="width: 40%; background-color: gold; border-color: gold; color: black; font-family: 'Bebas Neue';">
          Korg LogueSDK
        </.button>
      </.link>
      <p>Browser Based Synthesizer using the p5 JS Library.</p>
      <.link navigate={~p"/blorp"}>
        <.button style="width: 50%; background-color: #7091ea; color: #394f38; border-color: #7091ea; font-family: 'Major Mono Display';">
          B L O R P
        </.button>
      </.link>

      <br /><br />
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  # def handle_event("connected", _, socket) do
  # end
end
