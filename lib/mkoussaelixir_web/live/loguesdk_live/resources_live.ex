defmodule MkoussaelixirWeb.LoguesdkLive.ResourcesLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h1>Resources</h1>
      <h3>Windows Tooling</h3>
      <a href="https://www.msys2.org/">
        MSYS - Software Distribution and Building Platform for Windows
      </a>
      <br />
      <h3>Korg Logue-SDK</h3>
      <a href="https://korginc.github.io/logue-sdk/">Logue-SDK API Reference</a>
      <br />
      <a href="https://github.com/korginc/logue-sdk">Logue-SDK Github Repo</a>
      <br />
      <h3>NTS-1</h3>
      <a href="http://nic.vajn.icu/PDF/audio-gear/Korg/NTS-1/NTS-1_digital_Kit_OM_EFGSJ2.pdf">
        Korg NTS-1 Owners Manual
      </a>
      <br />
      <h4>Walk Throughs</h4>
      <a href="https://www.korg.com/us/products/dj/nts_1/custom_effects.php#article1">
        Korg DOTEC-AUDIO Articles
      </a>
      <br />
      <a href="https://korgnts1beginnersguide.wordpress.com/">
        Graham James Keane Setup Walk Through
      </a>
      <br />
      <h3>Books</h3>
      <h4>DSP</h4>
      <a href="https://www.analog.com/en/resources/technical-books/scientist_engineers_guide.html">
        The Scientist and Engineer's Guide to Digital Signal Processing, Steven W. Smith
      </a>
      <br />
      <a href="https://www.dsprelated.com/freebooks/mdft/">
        Mathematics of the Discrete Fourier Transform (DFT) w/ Audio Applications by Julius O. Smith III
      </a>
      <br />
      <a href="https://www.dsprelated.com/freebooks/filters/">
        Introduction to Digital Filters by Julius O. Smith III
      </a>
      <br />
      <h3>YouTube</h3>
      <h4>DSP</h4>
      <a href="https://www.youtube.com/watch?v=yGeXEwdNd_s&list=PL_QS1A2ZqaG7p50cd0AgLeG9Q3TN64vZJ&pp=iAQB">
        Youngmoo Kim Applied DSP
      </a>
      <br />
    </section>
    """
  end
end
