defmodule MkoussaelixirWeb.LoguesdkLive.StutterModLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h1>Korg NTS-1 Stutter Mod FX</h1>
      <p>
        This Mod FX takes a microsample of audio and repeats it a determined amount of time before resetting.
      </p>
      <br />
      <div class="youtube-video-container">
        <iframe
          width="560"
          height="315"
          src="https://www.youtube.com/embed/6lOtE0ug8MI?si=5FNgTFPtR54wJaZX"
          title="YouTube video player"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
          referrerpolicy="strict-origin-when-cross-origin"
          allowfullscreen
        >
        </iframe>
      </div>
      <br />
      <table class="download-table">
        <caption>Controls</caption>
        <tr>
          <th>Knob</th>
          <th>Function</th>
          <th>Range</th>
        </tr>
        <tr>
          <td>A</td>
          <td>Length of the audio to sample</td>
          <td>0.000020833 - 0.001953125 seconds</td>
        </tr>
        <tr>
          <td>B</td>
          <td>Repeat amount</td>
          <td>1 - 50</td>
        </tr>
      </table>
      <br />
      <a href="https://github.com/MKoussa/stutter">
        <svg
          height="32"
          aria-hidden="true"
          viewBox="0 0 24 24"
          version="1.1"
          width="32"
          data-view-component="true"
          class="octicon octicon-mark-github v-align-middle"
          stroke="var(--loguesdk-base)"
          fill="var(--loguesdk-base)"
          style="padding-right: 1rem;"
        >
          <path d="M12.5.75C6.146.75 1 5.896 1 12.25c0 5.089 3.292 9.387 7.863 10.91.575.101.79-.244.79-.546 0-.273-.014-1.178-.014-2.142-2.889.532-3.636-.704-3.866-1.35-.13-.331-.69-1.352-1.18-1.625-.402-.216-.977-.748-.014-.762.906-.014 1.553.834 1.769 1.179 1.035 1.74 2.688 1.25 3.349.948.1-.747.402-1.25.733-1.538-2.559-.287-5.232-1.279-5.232-5.678 0-1.25.445-2.285 1.178-3.09-.115-.288-.517-1.467.115-3.048 0 0 .963-.302 3.163 1.179.92-.259 1.897-.388 2.875-.388.977 0 1.955.13 2.875.388 2.2-1.495 3.162-1.179 3.162-1.179.633 1.581.23 2.76.115 3.048.733.805 1.179 1.825 1.179 3.09 0 4.413-2.688 5.39-5.247 5.678.417.36.776 1.05.776 2.128 0 1.538-.014 2.774-.014 3.162 0 .302.216.662.79.547C20.709 21.637 24 17.324 24 12.25 24 5.896 18.854.75 12.5.75Z">
          </path>
        </svg>
        Github Repo
      </a>
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
          <th>Download .ntkdigunit</th>
          <th>Notes</th>
        </tr>
        <tr>
          <td>3.0</td>
          <td>May 13th, 2024</td>
          <td>
            <a download href={~p"/downloads/ntkdigunit/stutter/modfx/v3-0/stutter.ntkdigunit"}>
              <svg
                width="clamp(0.5rem, 8vw, 4rem)"
                height="clamp(0.5rem, 8vw, 4rem)"
                viewBox="0 0 24 24"
                stroke="var(--loguesdk-base)"
                xmlns="http://www.w3.org/2000/svg"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                <g id="SVGRepo_iconCarrier">
                  <path
                    d="M21 21H3M18 11L12 17M12 17L6 11M12 17V3"
                    stroke="var(--loguesdk-base)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                  </path>
                </g>
              </svg>
            </a>
          </td>
          <td>Fixed undefined behavior and cracks/pops when changing parameters. Moved to C++.</td>
        </tr>
        <tr>
          <td>2.0</td>
          <td>April 14th, 2024</td>
          <td>
            <a href={~p"/downloads/ntkdigunit/stutter/modfx/v2-0/stutter.ntkdigunit"} download>
              <svg
                width="clamp(0.5rem, 8vw, 4rem)"
                height="clamp(0.5rem, 8vw, 4rem)"
                viewBox="0 0 24 24"
                stroke="var(--loguesdk-base)"
                xmlns="http://www.w3.org/2000/svg"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                <g id="SVGRepo_iconCarrier">
                  <path
                    d="M21 21H3M18 11L12 17M12 17L6 11M12 17V3"
                    stroke="var(--loguesdk-base)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                  </path>
                </g>
              </svg>
            </a>
          </td>
          <td>⚠️ Undefined Behavior</td>
        </tr>
        <tr>
          <td>1.0</td>
          <td>April 12th, 2024</td>
          <td>
            <a href={~p"/downloads/ntkdigunit/stutter/modfx/v1-0/stutter.ntkdigunit"} download>
              <svg
                width="clamp(0.5rem, 8vw, 4rem)"
                height="clamp(0.5rem, 8vw, 4rem)"
                viewBox="0 0 24 24"
                stroke="var(--loguesdk-base)"
                xmlns="http://www.w3.org/2000/svg"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                <g id="SVGRepo_iconCarrier">
                  <path
                    d="M21 21H3M18 11L12 17M12 17L6 11M12 17V3"
                    stroke="var(--loguesdk-base)"
                    stroke-width="2"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  >
                  </path>
                </g>
              </svg>
            </a>
          </td>
          <td>Initial Release!<br />⚠️ Undefined Behavior</td>
        </tr>
      </table>
    </section>
    """
  end

  # def handle_event("send_file", %{"filepath" => filepath}, socket) do
  #   # {:noreply, socket}
  #   send_download(socket, {:file, filepath})
  # end
end
