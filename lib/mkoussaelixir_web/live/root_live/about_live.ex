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
      <p>This site is powered by:</p>
      <author>
        Elixir <%= Application.spec(:elixir, :vsn) %> | Phoenix <%= Application.spec(:phoenix, :vsn) %> |
        <a href="https://www.gigalixir.com/">Gigalixir</a>
        | LiveView <%= Application.spec(:live_view, :vsn) %>
      </author>
      <%!--
      <.link href="https://mkoussa.bandcamp.com">
        <h2>MKOUSSA Bandcamp</h2>
      </.link> --%>
      <%!-- <span style="display: block;">
        <iframe
          style="border: 0; width: 20vw; height: 20vw;"
          src="https://bandcamp.com/EmbeddedPlayer/album=3490434269/size=large/bgcol=333333/linkcol=e99708/tracklist=true/transparent=true/"
          seamless
        >
          <a href="https://mkoussa.bandcamp.com/album/rise">Rise by MKoussa</a>
        </iframe>

        <iframe
          style="border: 0; width: 20vw; height: 20vw;"
          src="https://bandcamp.com/EmbeddedPlayer/album=949237618/size=large/bgcol=333333/linkcol=e99708/tracklist=true/transparent=true/"
          seamless
        >
          <a href="https://mkoussa.bandcamp.com/album/intro-birth">Intro//Birth by MKoussa</a>
        </iframe>
      </span> --%>
      <h3>SITE MAP</h3>
      <.link navigate={~p"/shop/products"}>
        <.button style="width: 70%; background-color: #ffd3e9; color: #394f38; border-color: #ffd3e9; font-family: 'Six Caps'; font-size: clamp(20px, 3.5vw, 30px);">
          🗡 Shop 🗡
        </.button>
      </.link>
      <p>
        Give me your <i>money</i>. I mean, in a way. Here you can buy Korg LogueSDK pre-compiled binary files of FX. Or at least, you will be once I integrate with Shopify or Stripe, lol!
      </p>
      <.link href={~p"/loguesdk"}>
        <.button style="width: 40%; background-color: gold; border-color: gold; color: black; font-family: 'Bebas Neue';">
          Korg LogueSDK
        </.button>
      </.link>
      <p>Precompiled file downloads and Github links to Logue-SDK projects.</p>
      <.link navigate={~p"/blorp"}>
        <.button style="width: 50%; background-color: #7091ea; color: #394f38; border-color: #7091ea; font-family: 'Major Mono Display';">
          B L O R P
        </.button>
      </.link>
      <p>Browser Based Synthesizer using the p5 JS Library.</p>

      <.link patch={~p"/chat/rooms"}>
        <.button style="animation: rainbow 45s linear; animation-iteration-count: infinite; animation-timing-function: linear;">
          <h3>WORLD CHAT<br />🌍 🌏 🌎</h3>
        </.button>
      </.link>
      <p>Chat Rooms! You'll need an account though.</p>
      <.link patch={~p"/thermostat"}>
        <.button>Thermostat (IYKYK)</.button>
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
