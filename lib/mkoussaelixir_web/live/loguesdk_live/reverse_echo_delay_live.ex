defmodule MkoussaelixirWeb.LoguesdkLive.ReverseEchoDelayLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h1>Korg NTS-1 Reverse Echo Delay FX</h1>
      <table class="download-table">
        <caption>Controls</caption>
        <tr>
          <th>Knob</th>
          <th>Function</th>
        </tr>
        <tr>
          <td>A</td>
          <td>Sets the length (1 - 2 seconds) of the audio to reverse</td>
        </tr>
        <tr>
          <td>B</td>
          <td>Sets trailing echo length</td>
        </tr>
        <tr>
          <td>Shift-B</td>
          <td>Wet/Dry Mix</td>
        </tr>
      </table>
      <br />
      <a href="https://github.com/MKoussa/reverse-echo">Github Repo</a>
      <br /><br />

      <form action="https://www.paypal.com/donate" method="post" target="_top">
        <input type="hidden" name="business" value="NA77856ZM84YE" />
        <input type="hidden" name="no_recurring" value="0" />
        <input
          type="hidden"
          name="item_name"
          value="Thank You for donating! I hope you enjoy Reverse Echo!"
        />
        <input type="hidden" name="currency_code" value="USD" />
        <input
          type="image"
          src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif"
          name="submit"
          title="PayPal - The safer, easier way to pay online!"
          alt="Donate with PayPal button"
        />
      </form>
      <br />
      <p>
        While I recommend you always use the latest version available, all previous versions are provided.<br />
        Use whichever version floats your boat!
      </p>
      <br />
      <table class="download-table">
        <caption>Download Reverse Echo Delay</caption>
        <tr>
          <th>Version</th>
          <th>Release Date</th>
          <th>Download</th>
          <th>Notes</th>
        </tr>
        <tr>
          <td>2.2</td>
          <td>May 22nd, 2024</td>
          <td>
            <a href="/NTKDIGUNIT/ReverseEcho/V2/ntkdigunit" download>reverse-echo.ntkdigunit</a>
          </td>
          <td>
            Implemented actual wet/dry mixing.<br />Shift-B %50 is now 50/50 wet/dry and %100 is fully wet.<br />Previously, shift-B %100 was 50/50 wet/dry.
          </td>
        </tr>
        <tr>
          <td>2.0</td>
          <td>May 12th, 2024</td>
          <td>
            <a href="/NTKDIGUNIT/ReverseEcho/V2/ntkdigunit" download>reverse-echo.ntkdigunit</a>
          </td>
          <td>Fixed static when changing parameters.<br />Moved to C++.</td>
        </tr>
        <tr>
          <td>1.0</td>
          <td>April 28th, 2024</td>
          <td>
            <a href="/NTKDIGUNIT/ReverseEcho/V1/ntkdigunit" download>reverse-echo.ntkdigunit</a>
          </td>
          <td>Added Wet/Dry<br />⚠️ Undefined Behavior</td>
        </tr>
        <tr>
          <td>0.0</td>
          <td>April 22nd, 2024</td>
          <td>
            <a href="/NTKDIGUNIT/ReverseEcho/V0/ntkdigunit" download>reverse-echo.ntkdigunit</a>
          </td>
          <td>Initial Release!<br />⚠️ Undefined Behavior</td>
        </tr>
      </table>
    </section>
    """
  end
end
