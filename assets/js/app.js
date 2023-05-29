import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

Hooks.ToggleAboutModal = {
  mounted() {
    this.el.addEventListener("click", e => {
      let aboutModal = document.getElementById("about-modal");
      aboutModal.classList.toggle("hidden");
    });
  }
};

Hooks.PlaySound = {
  mounted() {
    this.el.innerHTML = getPlayButtonSVG()
    
    this.el.addEventListener("click", e => {
      let audioObject = document.getElementById(this.el.getAttribute("phx-value-audioid"))

      if (audioObject && audioObject.paused){
        audioObject.play()
        this.el.innerHTML = getPauseButtonSVG()
      } else {
        audioObject.pause()
        this.el.innerHTML = getPlayButtonSVG()
      }
    })
  }
}

Hooks.ChangeAudioVolume = {
  mounted() {
    this.el.addEventListener("change", e => {
      let audioObject = document.getElementById(this.el.getAttribute("phx-value-audioid"))

      if (audioObject){
        audioObject.volume = this.el.value / 100
      }
    })
  }
}

function getPlayButtonSVG() {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="black" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polygon points="5 3 19 12 5 21 5 3"></polygon>
    </svg>`;
}


function getPauseButtonSVG() {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" fill="black" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <rect x="6" y="4" width="4" height="16"></rect>
      <rect x="14" y="4" width="4" height="16"></rect>
    </svg>`

}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken},})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()
window.liveSocket = liveSocket

