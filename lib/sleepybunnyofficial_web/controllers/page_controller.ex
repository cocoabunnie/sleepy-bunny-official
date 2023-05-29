defmodule SleepybunnyofficialWeb.PageController do
  use SleepybunnyofficialWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket,
    playtalking: false,
    playtyping: false,
    show_about: false,
    all_sounds: [%{name: "Talking", url: "https://res.cloudinary.com/doz6esktv/video/upload/v1685208115/sounds/talking_rrwtqc.mp3"},
                %{name: "Typing", url: "https://res.cloudinary.com/doz6esktv/video/upload/v1685208222/sounds/typing_rf2zxu.mp3"},
                %{name: "Rain", url: "https://res.cloudinary.com/doz6esktv/video/upload/v1685165525/sounds/rain_xsyodt.mp3"},
                %{name: "LoFi", url: "https://res.cloudinary.com/doz6esktv/video/upload/v1685166062/sounds/lofi-official_zyxa6n.mp3"}]),
    layout: false}
  end

  def sound_player(%{name: _, url: _, volume: _} = assigns) do
    ~H"""
      <div>
        <p><%= @name %></p>
        <div class="flex flex-row items-center">
          <button id={"#{@name}-button"} phx-value-name={@name} phx-value-url={@url} phx-value-audioid={"audio-#{@name}"} phx-hook="PlaySound">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="black" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polygon points="5 3 19 12 5 21 5 3"></polygon>
            </svg>
          </button>

          <input class="appearance-none bg-darkblue h-[5px]" id={"#{@name}-volume"} type="range" min="1" max="100" value="100" phx-value-name={"#{@name}"} phx-hook="ChangeAudioVolume" phx-value-audioid={"audio-#{@name}"}>
        </div>
      </div>
    """
  end

  def github_link(assigns) do
    ~H"""
      <div class="fixed z-20 top-2 left-10 h-auto">
        <a href="https://github.com/cocoabunnie/sleepy-bunny-official" target="_blank">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white" width="35px" height="35px">
            <path d="M0 0h24v24H0z" fill="none"/>
            <path d="M12 0C5.4 0 0 5.4 0 12c0 5.3 3.4 9.8 8.1 11.4.6.1.9-.2.9-.6v-2.2c-3.3.7-4-1.6-4-1.6-.5-1.3-1.1-1.7-1.1-1.7-.9-.6.1-.6.1-.6 1 .1 1.5 1 1.5 1 .9 1.6 2.4 1.1 3 .8.1-.7.4-1.1.7-1.4-2.4-.3-4.9-1.2-4.9-5.4 0-1.2.4-2.2 1.1-3-.1-.3-.5-1.4.1-2.9 0 0 .9-.3 3 .9 1-.3 2-.5 3-.5s2 .2 3 .5c2.1-1.2 3-.9 3-.9.6 1.5.2 2.6.1 2.9.6.7 1.1 1.7 1.1 3 0 4.2-2.5 5.1-4.9 5.4.4.3.8.9.8 1.8v2.7c0 .4.3.7 1 .6 4.8-1.6 8.1-6.1 8.1-11.4C24 5.4 18.6 0 12 0z"/>
          </svg>
        </a>
      </div>
    """
  end

  def about_modal(assigns) do
    ~H"""
      <div id="about-modal" class="absolute hidden flex justify-center items-center w-full h-full z-20 px-10 overflow-clip">
          <div class="w-[400px] bg-white border border-2 border-darkpurple rounded-lg z-10 p-3">
            <button id="about-modal-close" class="flex justify-end w-full pr-1" phx-hook="ToggleAboutModal" phx-value-modalid="about-modal">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="black" width="24px" height="24px">
                <path d="M0 0h24v24H0z" fill="none"/>
                <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"/>
              </svg>
            </button>

            <p>
              Hello! \(^-^)/
              <br/>
              <br/>
              Thank you so much for checking out my app Sleep Bunny. :)
              <br/>
              I've always been a huge fan of these kinds of apps and I figured I make one on my own to practice Elixir and Phoenix.
              <br/>
              Enjoy your stay!
              <br/>
              <br/>
            </p>

            <div class="flex flex-row gap-2 ml-5">
              <span>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#FF69B4" width="24px" height="24px">
                  <path d="M0 0h24v24H0z" fill="none"/>
                  <path d="M12 20s-8.6-5.4-8.6-8.6c0-2.5 2-4.5 4.5-4.5 1.6 0 3.1.8 4 2 1.3-1.2 3-2 4.9-2 2.5 0 4.5 2 4.5 4.5 0 3.2-8.6 8.6-8.6 8.6z"/>
                </svg>
              </span>
              <p>Brianna</p>
            </div>

          </div>

          <div id="about-modal-background" class="absolute opacity-20 bg-black w-full h-full overflow-y-hidden" phx-hook="ToggleAboutModal" phx-value-modalid="about-modal"/>
        </div>
    """
  end

  def mobile_disclaimer_modal(assigns) do
    ~H"""
      <div id="mobile-disclaimer-modal" class="absolute lg:hidden flex justify-center items-center w-full h-full z-20 px-10 overflow-clip">
          <div class="w-[400px] bg-white border border-2 border-darkpurple rounded-lg z-10 p-3">
            <button id="mobile-modal-close" class="flex justify-end w-full pr-1" phx-hook="ToggleAboutModal" phx-value-modalid="mobile-disclaimer-modal">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="black" width="24px" height="24px">
                <path d="M0 0h24v24H0z" fill="none"/>
                <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"/>
              </svg>
            </button>

            <p>
              Disclaimer!! (^0^)
              <br/>
              <br/>
              I noticed you're on mobile! Due to certain security protections on most mobile browsers, the volume control most likely won't work on your mobile device at the moment.
              <br/>
              You can play the audio, but you'd have to control the audio with your device's built in volume control hardware (the buttons on the top/side)
              <br/>
              I'm currently working on fixing this issue, so hopefully it shouldn't be a problem soon! ^-^
              <br/>
              <br/>
              Other than that, have fun!!
              <br/>
              <br/>
            </p>

            <div class="flex flex-row gap-2 ml-5">
              <span>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#FF69B4" width="24px" height="24px">
                  <path d="M0 0h24v24H0z" fill="none"/>
                  <path d="M12 20s-8.6-5.4-8.6-8.6c0-2.5 2-4.5 4.5-4.5 1.6 0 3.1.8 4 2 1.3-1.2 3-2 4.9-2 2.5 0 4.5 2 4.5 4.5 0 3.2-8.6 8.6-8.6 8.6z"/>
                </svg>
              </span>
              <p>Brianna</p>
            </div>

          </div>

          <div id="mobile-modal-background" class="absolute opacity-20 bg-black w-full h-full overflow-y-hidden" phx-hook="ToggleAboutModal" phx-value-modalid="mobile-disclaimer-modal"/>
        </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div class="relative flex justify-center items-center bg-darkblue h-[calc(100vh)] w-[calc(100vw)] font-mono overflow-x-hidden lg:overflow-hidden">
      <div class="absolute flex justify-center items-center h-screen overflow-clip">
        <img class="opacity-40 animate-slow-spin h-[calc(300vh)] w-auto object-cover overflow-hide" src="https://res.cloudinary.com/doz6esktv/image/upload/v1685309633/sounds/StaryBackground_twj67t.png" alt="starry background"/>
      </div>

      <.mobile_disclaimer_modal/>

      <.github_link/>
      <button id="about-nav" class="fixed z-20 top-0 font-bold text-white top-2 right-10 uppercase" phx-hook="ToggleAboutModal" phx-value-modalid="about-modal">about</button>

      <.about_modal/>

      <div class="absolute flex flex-col gap-[20px] lg:gap-[100px] items-center w-fit h-fit max-w-[2000px]">
        <div class="w-fit flex justify-center">
          <img class="z-10 mt-[50px] h-[calc(20vh)] w-auto lg:h-[200px] lg:w-auto" src="https://res.cloudinary.com/doz6esktv/image/upload/v1685313306/sounds/Starry_Night_Header_vw5bzx.png" alt="Sleepy Bunny Header"/>
        </div>

        <div class="flex items-center justify-center w-full flex-col lg:flex-row lg:px-[200px]">
          <img class="animate-float h-[calc(30vh)] lg:h-[350px] w-auto" src="https://res.cloudinary.com/doz6esktv/image/upload/v1685313307/sounds/sleepyBunny_a5cmcn.png" alt="bunny sleeping on a cloud"/>

          <div class="flex grow min-w-[100px]"/>

          <div class="flex bg-white p-6 mb-5 rounded-lg flex-col justify-center items-center gap-3 h-fit">
            <p>Sound Board</p>
            <%= for sound <- @all_sounds do %>
              <.sound_player name={sound.name} url={sound.url} volume={}/>
            <% end %>
          </div>
        </div>
      </div>

      <div>
        <%= for sound <- @all_sounds do %>
          <audio id={"audio-#{sound.name}"} src={sound.url} loop/>
        <% end %>
      </div>
    </div>
    """
  end
end
