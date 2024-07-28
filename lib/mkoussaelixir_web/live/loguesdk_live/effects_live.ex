defmodule MkoussaelixirWeb.LoguesdkLive.EffectsLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h1>Korg Logue Effects</h1>
      <p>
        I currently only have the NTS-1, so YMMV with these effects.<br />If you encounter any issues, let me know and I can try my best to resolve them!
      </p>
      <h2>
        <.link patch={~p"/loguesdk/stuttermodeffect"}>
          <.button>Stutter Mod Effect</.button>
        </.link>
      </h2>
      <p>Records a short audio sample and repeats it up to 50 times.</p>
      <h2>
        <.link patch={~p"/loguesdk/reverseechodelayeffect"}>
          <.button>Reverse Echo Delay Effect</.button>
        </.link>
      </h2>
      <p>Echos reversed audio input</p>
    </section>
    """
  end
end
