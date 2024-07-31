defmodule MkoussaelixirWeb.AboutLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="root-transition">
      <h2>ABOUT</h2>
      <p>Hello World! I'm Matthew Koussa and this is my site!</p>
      <p>
        Here you'll find my forrays into digital synthesis via the
        <a href={~p"/loguesdk"}>Korg LogueSDK</a>
        or <a href={~p"/blorp"}>Blorp</a>, a synthesizer built using the p5 Javscript library.
      </p>
      <p>
        Checkout my <a href="https://mkoussa.bandcamp.com">Bandcamp</a>, where you can stream/download/buy my music!
      </p>
      <p>This site is powered by:</p>
      <author>
        Elixir <%= Application.spec(:elixir, :vsn) %> | Phoenix <%= Application.spec(:phoenix, :vsn) %> |
        <a href="https://www.gigalixir.com/">Gigalixir</a>
        | LiveView <%= Application.spec(:liveview, :vsn) %>
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
        <.button style="width: 30%; background-color: #ffd3e9; color: #394f38; border-color: #ffd3e9; font-family: 'Six Caps'; font-size: clamp(20px, 3.5vw, 30px);">
          Shop
        </.button>
      </.link>
      <p>
        Give me your <i>money</i>. I mean, in a way. Here you can buy Korg LogueSDK pre-compiled binary files of FX.
      </p>
      <.link href={~p"/loguesdk"}>
        <.button style="width: 40%; background-color: gold; border-color: gold; color: black; font-family: 'Bebas Neue';">
          Korg LogueSDK
        </.button>
      </.link>
      <p>Precompiled file downloads and Github links to Logue-SDK projects.</p>
      <.link patch={~p"/mkoussa"}>
        <.button style="width: 30%;">About</.button>
      </.link>
      <p>
        What does this all even <i>mean</i>? Especially considering this is where you're currently at!
      </p>
      <.link href={~p"/blorp"}>
        <.button style="width: 50%; background-color: #7091ea; color: #394f38; border-color: #7091ea; font-family: 'Major Mono Display';">
          B L O R P
        </.button>
      </.link>
      <p>Browser Based Synthesizer using the p5 JS Library.</p>
    </section>

    <.link patch={~p"/thermostat"}>
      <.button>Thermostat</.button>
    </.link>
    <br /><br />
    """
  end

  def mount(params, session, socket) do
    IO.inspect(params)
    IO.inspect(session)
    IO.inspect(socket)
    {:ok, socket}
  end
end
