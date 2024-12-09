defmodule MkoussaelixirWeb.LoguesdkLive.ResourcesLive do
  use MkoussaelixirWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="loguesdk-mainBody">
      <h1>Resources</h1>
      <div style="border-radius: 15px;border: 5px solid var(--loguesdk-base); padding: clamp(0.1rem, 1vw, 1.5rem);">
        <img
          src="/images/korg-nts-1-mk-1-signal-route.png"
          style="width: clamp(2rem, 70vw, 52rem);
                 background-color: var(--loguesdk-base);"
        />
      </div>
      <br />
      <table class="download-table">
        <caption>Resources for programming the Korg NTS-1</caption>
        <thead>
          <tr>
            <th>Resource</th>
            <th>Type</th>
            <th>Link</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>MSYS</td>
            <td>Software Distribution and Building Platform for Windows</td>
            <td>
              <a href="https://www.msys2.org/" target="_blank">
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>API Reference</td>
            <td>Reference sheet for the Korg Logue-SDK and devices</td>
            <td>
              <a href="https://korginc.github.io/logue-sdk/" target="_blank">
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>Github Repo</td>
            <td>Official Github repository of the Korg Logue-SDK</td>
            <td>
              <a href="https://github.com/korginc/logue-sdk" target="_blank">
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>Owners Manual</td>
            <td>Downloadable .pdf of the Korg NTS-1 Owners Manual</td>
            <td>
              <.link
                href="/downloads/ntkdigunit/NTS-1_digital_Kit_OM_EFGSJ2.pdf"
                download
                target="_blank"
              >
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
              </.link>
            </td>
          </tr>
          <tr>
            <td>DOTEC-AUDIO Articles</td>
            <td>Getting Started programming the NTS-1 walkthrough</td>
            <td>
              <a
                href="https://www.korg.com/us/products/dj/nts_1/custom_effects.php#article1"
                target="_blank"
              >
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>Graham James Keane Setup</td>
            <td>Setting up the NTS-1 walkthrough by Graham James Keane</td>
            <td>
              <a href="https://korgnts1beginnersguide.wordpress.com/" target="_blank">
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>
              Free DSP eBook
            </td>
            <td>The Scientist and Engineer's Guide to Digital Signal Processing, Steven W. Smith</td>
            <td>
              <a
                href="https://www.analog.com/en/resources/technical-books/scientist_engineers_guide.html"
                target="_blank"
              >
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>Free DSP eBook</td>
            <td>
              Mathematics of the Discrete Fourier Transform (DFT) w/ Audio Applications by Julius O. Smith III
            </td>
            <td>
              <a href="https://www.dsprelated.com/freebooks/mdft/" target="_blank">
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>Free DSP eBook</td>
            <td>Introduction to Digital Filters by Julius O. Smith III</td>
            <td>
              <a href="https://www.dsprelated.com/freebooks/filters/" target="_blank">
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
          <tr>
            <td>YouTube Series</td>
            <td>Youngmoo Kim Applied DSP</td>
            <td>
              <a
                href="https://www.youtube.com/watch?v=yGeXEwdNd_s&list=PL_QS1A2ZqaG7p50cd0AgLeG9Q3TN64vZJ&pp=iAQB"
                target="_blank"
              >
                <svg
                  width="clamp(0.5rem, 8vw, 4rem)"
                  height="clamp(0.5rem, 8vw, 4rem)"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                >
                  <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                  <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                  <g id="SVGRepo_iconCarrier">
                    <path
                      stroke="var(--loguesdk-base)"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M12 6H7a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1v-5m-6 0 7.5-7.5M15 3h6v6"
                    >
                    </path>
                  </g>
                </svg>
              </a>
            </td>
          </tr>
        </tbody>
      </table>
    </section>
    """
  end
end
