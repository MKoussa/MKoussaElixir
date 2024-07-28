defmodule MkoussaelixirWeb.LoguesdkLive.IndexLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h2>Korg LogueSDK</h2>
      <h3>Effects</h3>
      <p>Precompiled file downloads and Github links to Logue-SDK Effects.</p>
      <.link patch={~p"/loguesdk/effects/"}>
        <.button>Effects</.button>
      </.link>
      <h3>Oscillators</h3>
      <p>Coming Soon...</p>
      <.link patch={~p"/loguesdk/oscillators/"}>
        <.button>Oscillators</.button>
      </.link>
      <h3>Resources</h3>
      <p>Helpful links for coding the Korg NTS-1 (and DSP in general).</p>
      <.link patch={~p"/loguesdk/resources/"}>
        <.button>Resources</.button>
      </.link>
    </section>
    """
  end
end
