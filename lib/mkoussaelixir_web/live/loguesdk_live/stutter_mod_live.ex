defmodule MkoussaelixirWeb.LoguesdkLive.StutterModLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h1>Korg NTS-1 Stutter Mod FX</h1>
      <p>
        This Mod FX samples up to 0.001953125 seconds of audio and repeats the sample up to 50 times.
        <br /> The sample time is set by the Time knob, and repeat amount is set by the Depth knob.
      </p>

      <a href="https://github.com/MKoussa/stutter">Github Repo</a>
      <br /><br />

      <form action="https://www.paypal.com/donate" method="post" target="_top">
        <input type="hidden" name="business" value="NA77856ZM84YE" />
        <input type="hidden" name="no_recurring" value="0" />
        <input
          type="hidden"
          name="item_name"
          value="Thank You for donating! I hope you enjoy Stutter!"
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
        Use whichever version floats your boat (and at your own risk)!
      </p>
      <br />
      <table class="download-table">
        <caption>Download Stutter Mod FX</caption>
        <tr>
          <th>Version</th>
          <th>Release Date</th>
          <th>Download</th>
          <th>Notes</th>
        </tr>
        <tr>
          <td>3.0</td>
          <td>May 13th, 2024</td>
          <td><a href="/NTKDIGUNIT/Stutter/V3/stutter.ntkdigunit" download>stutter.ntkdigunit</a></td>
          <td>Fixed undefined behavior and cracks/pops when changing parameters. Moved to C++.</td>
        </tr>
        <tr>
          <td>2.0</td>
          <td>April 14th, 2024</td>
          <td><a href="/NTKDIGUNIT/Stutter/V2/stutter.ntkdigunit" download>stutter.ntkdigunit</a></td>
          <td>⚠️ Undefined Behavior</td>
        </tr>
        <tr>
          <td>1.0</td>
          <td>April 12th, 2024</td>
          <td><a href="/NTKDIGUNIT/Stutter/V1/stutter.ntkdigunit" download>stutter.ntkdigunit</a></td>
          <td>Initial Release!<br />⚠️ Undefined Behavior</td>
        </tr>
      </table>
    </section>
    """
  end
end
