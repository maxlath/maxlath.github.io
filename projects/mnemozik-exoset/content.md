### Mnemozik Exoset

Spending an unhealthy amount of time working on a computer while listening to music had an interesting side-effect: I have been listening to a lot of music. I started sharing a selection from that musical libraries with friends during parties, and they seemed to enjoy it. Maybe you will like it too. All credits go to the original artists.

<h4 id="mitmisch-2025">MnemozikExoset @ Mitmisch Festival 2025</h4>

<audio id="mitmisch-2025-audio" controls src="./assets/mnemozik-exoset-mitmisch-festival-2025.mp3">
  <source type="audio/mp3" />
</audio>

##### Tracklist

<ul class="tracklist" data-audio-id="mitmisch-2025-audio">
  <li><button><span class="timestamp">0:00:00</span> Electronik Orkestar - Arabian Night</button></li>
  <li><button><span class="timestamp">0:04:15</span> Electronik Orkestar - Turkish Song</button></li>
  <li><button><span class="timestamp">0:07:52</span> Watt The Fox - Taksim</button></li>
  <li><button><span class="timestamp">0:11:20</span> Watt The Fox - Madness</button></li>
  <li><button><span class="timestamp">0:13:20</span> Space Raverz - Cosmik Walker</button></li>
  <li><button><span class="timestamp">0:19:30</span> Tetra Hydro K - Hadra AlterVision</button></li>
  <li><button><span class="timestamp">0:24:08</span> Tetra Hydro K feat. KILLA P - Wah Gwaan !</button></li>
  <li><button><span class="timestamp">0:26:50</span> Watt The Fox - Consciousness (Miles From Mars Remix)</button></li>
  <li><button><span class="timestamp">0:31:00</span> DJ Europarking - Penniless Tonight [UFO12] [RECUT]</button></li>
  <li><button><span class="timestamp">0:33:30</span> DJ Europarking aka Dollkraut - 20inch Chrome [UFO7]</button></li>
  <li><button><span class="timestamp">0:35:55</span> 3Form - Cosmos</button></li>
  <li><button><span class="timestamp">0:39:20</span> Dantra - Wonder</button></li>
  <li><button><span class="timestamp">0:45:25</span> Jerome Isma-Ae - Hold That Sucker Down (Jerome Isma-Ae's 10 Year Anniversary Mix)</button></li>
  <li><button><span class="timestamp">0:47:37</span> Perceval - Croisade</button></li>
  <li><button><span class="timestamp">0:50:34</span> Guigoo - Farfaders (Mat Weasel & Guigoo)- Tapis Volant</button></li>
  <li><button><span class="timestamp">0:53:40</span> Velcro - Parasites [ZOUAW 03]</button></li>
  <li><button><span class="timestamp">1:00:55</span> Dacru Records - XSI - Nightmare (Talamasca vs XSI ft Lucid Remix)</button></li>
  <li><button><span class="timestamp">1:06:55</span> Reverence - Paranormal Attack - The Pill (Reverence Remix)</button></li>
  <li><button><span class="timestamp">1:11:50</span> Leandre Lethö - Acid Beat</button></li>
  <li><button><span class="timestamp">1:17:50</span> YSErecordings - Static Movement vs Dohak - Spaceship (Dual Core Remix)</button></li>
  <li><button><span class="timestamp">1:24:20</span> Stryker, Javier Bussola - Psychedelic Doctor</button></li>
  <li><button><span class="timestamp">1:31:25</span> Arkham Knights - Closing In (Extended Mix)</button></li>
  <li><button><span class="timestamp">1:37:45</span> Arkham Knights - The Vision</button></li>
  <li><button><span class="timestamp">1:40:50</span> Tetra Hydro K - Charcuterie Monin</button></li>
  <li><button><span class="timestamp">1:44:20</span> Watt The Fox feat. Ludo Ji - Neo Drum Talk - Trans-Organica</button></li>
  <li><button><span class="timestamp">1:51:03</span> Terrafractyl - Chromatic Fanatic</button></li>
</ul>

<script type="module">
  document.body.addEventListener('click', (e) => {
    const el = e.target
    const { tagName } = el
    if (tagName === 'BUTTON') {
      const audioEl = getAudioEl(el)
      const timestamp = getTimestamp(el)
      const time = getTimeFromTimestamp(timestamp)
      audioEl.currentTime = time
      audioEl.play()
      updateCurrenltyPlayingTrack()
      e.preventDefault()
      e.stopPropagation()
    }
  })

  document.body.addEventListener('keydown', (e) => {
    const el = e.target
    const { tagName } = el
    if (tagName === 'BUTTON') {
      if (e.ctrlKey || e.altKey || e.shiftKey) return
      const audioEl = getAudioEl(el)
      if (e.key === 'ArrowLeft') seekBackward(audioEl)
      else if (e.key === 'ArrowRight') seekForward(audioEl)
    }
  })

  Array.from(document.body.querySelectorAll('.tracklist button')).forEach(el => {
    const timestamp = getTimestamp(el)
    const title = el.innerText.split(' ').slice(1).join(' ')
    el.title = `Play "${title}" (starting at ${timestamp})`
  })

  function getAudioEl (el) {
    const { audioId } = el.closest('ul[data-audio-id]').dataset
    return document.getElementById(audioId)
  }

  function getTimestamp (el) {
    return Array.from(el.children).find(el => el.className === 'timestamp').innerText
  }

  const secondsPerMinute = 60
  const secondsPerHour = 60 * secondsPerMinute

  function getTimeFromTimestamp (timestamp) {
    const [ hours, minutes, seconds ] = timestamp.split(':').map(str => parseInt(str))
    return seconds + minutes * secondsPerMinute + hours * secondsPerHour
  }

  function getTimestampFromTime (time) {
    const hours = Math.floor(time / secondsPerHour)
    let remainer = time - hours * secondsPerHour
    const minutes = Math.floor(remainer / secondsPerMinute)
    const seconds = Math.floor(remainer - minutes * secondsPerMinute)
    return `${hours}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
  }

  function seekBackward (audioEl) {
    audioEl.currentTime -= 15
  }
  function seekForward (audioEl) {
    audioEl.currentTime += 15
  }

  function updateCurrenltyPlayingTrack () {
    Array.from(document.querySelectorAll('audio')).forEach(audioEl => {
      const { id, currentTime } = audioEl
      const currentTimestamp = getTimestampFromTime(currentTime)
      const tracksButtons = Array.from(document.querySelectorAll(`ul[data-audio-id="${id}"] button`))
      const previouslyPlaying = tracksButtons.find(el => el.classList.contains('playing'))
      const nextTrackButton = tracksButtons.find(el => {
        const timestamp = getTimestamp(el)
        return timestamp > currentTimestamp
      })
      const currentTrackButton = nextTrackButton.closest('li').previousElementSibling.childNodes[0]
      if (previouslyPlaying == null) {
        currentTrackButton.classList.add('playing')
      } else if (previouslyPlaying !== currentTrackButton) {
        currentTrackButton.classList.add('playing')
        previouslyPlaying.classList.remove('playing')
      }
    })
  }

  setInterval(updateCurrenltyPlayingTrack, 1000)
</script>

<style>
  audio{
    width: 100%;
  }
  .tracklist li{
    border-top: 1px solid #aaff00dd;
    border-left: 1px solid #aaff00dd;
    border-right: 1px solid #aaff00dd;
  }
  .tracklist li:first-child{
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
  }
  .tracklist li:last-child{
    border-bottom: 1px solid #aaff00dd;
    border-bottom-left-radius: 3px;
    border-bottom-right-radius: 3px;
  }
  h5{
    margin-bottom: 0.5rem;
  }
  .tracklist button{
    color: #448;
    width: 100%;
    text-align: start;
    padding: 0.3rem 0.4rem 0.4rem 0.4rem;
    transition: background-color 0.2s ease;
    user-select: text;
  }
  .tracklist button:hover{
    background-color: #aaff0055;
  }
  .timestamp{
    font-size: 0.9rem;
    color: #448;
    padding: 0 0.2rem;
    background-color: #ddd;
    border-radius: 3px;
  }
  .playing{
    background-color: #aaff00dd;
  }
</style>
