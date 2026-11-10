# What EmacsConf 2026 asks for

The conference is December 12 and 13, 2026. The target upload date was
October 30, 2026. The organizers say this date is a target and not a
hard deadline, so email emacsconf-org-private@gnu.org to let them know
your video is coming.

  Requirement            Value                             Where it is set in OBS
  ---------------------- --------------------------------- ----------------------------------
  Resolution             1280x720 (720p) or higher         Settings, Video
  Preferred format       WebM (MP4 accepted)               Convert after recording
  Colors                 Dark text on light background     In the slides themselves
  Room noise sample      5 seconds or more of silence      Record at the start of the take
  Opening line           \"Hi! I am NAME and I will...\"   Your script
  Window capture check   \"Swap red and blue\" option      Window Capture source properties

  : EmacsConf 2026 requirements and the matching OBS setting.

The analogy for the whole workflow is a slide carousel projector. The
PNG files are the slides in the tray, the Image Slide Show source is the
projector, and a hotkey is the clicker in your hand. OBS films the
screen while you talk.

# Step 1. Convert the PDF slides to PNG

OBS accepts PNG, JPEG, BMP, GIF, and a few other image types in the
Image Slide Show source. It does not read PDF. The script
`pdf2png.sh`{.verbatim} renders each page as a numbered PNG.

Install Poppler once.

``` bash
brew install poppler
```

Run the script on your deck.

``` bash
chmod +x pdf2png.sh
./pdf2png.sh emacsconf2026.pdf
# produces emacsconf2026_png/slide-01.png, slide-02.png, ...
```

The default width is 1920 pixels. OBS scales this down to 1280x720 with
sharp text. If you export from Beamer, use
`\documentclass[aspectratio=169]{beamer}`{.verbatim} so the slides fill
the 16:9 frame without black bars.

The zero-padded numbers matter because OBS sorts files by name. Without
padding, slide-10 would play before slide-2.

# Step 2. Set the OBS video and output settings

1.  Open Settings, then Video.
    - Base (Canvas) Resolution = 1280x720
    - Output (Scaled) Resolution = 1280x720
    - Common FPS Values = 30
2.  Open Settings, then Output. Set Output Mode to Simple.
    - Recording Path = a folder you can find again
    - Recording Quality = High Quality, Medium File Size
    - Recording Format = Matroska Video (.mkv) or Hybrid MP4. Both
      survive a crash. Use File, Remux Recordings to turn an .mkv into
      .mp4 afterward.
3.  Open Settings, then Audio. Set Mic/Auxiliary Audio to your external
    microphone or headset. Set Desktop Audio to Disabled unless you play
    sound from the computer.

# Step 3. Reuse a 2023 or 2024 scene

Your old scenes still hold the old PNG lists. Copy one rather than edit
it.

1.  In the Scenes dock, right-click the 2024 scene and choose Duplicate.
    Name it EmacsConf 2026.
2.  In the Sources dock of the new scene, double-click the Image Slide
    Show source.
3.  Remove the old files with the minus button. Click plus, choose Add
    Directory, and select `emacsconf2026_png`{.verbatim}.
4.  Set these properties.
    - Slide Mode = Manual (Use hotkeys to control slideshow)
    - Transition = Cut or Fade (Fade with 300 ms is gentle on viewers)
    - Bounding Size/Aspect Ratio = 1280x720
    - Loop = off
    - Hide when slideshow is done = off
5.  Right-click the source in the preview and choose Transform, then Fit
    to screen.

If you add or replace PNG files later, remove and re-add the directory.
OBS does not always notice new files in a folder that it already loaded.

# Step 4. Add your microphone and an optional webcam


The microphone appears in the Audio Mixer dock as Mic/Aux. Speak at
normal volume and watch the meter. Aim for peaks in the yellow range
around -12 dB, never touching red.

Right-click Mic/Aux and choose Filters. Add Noise Suppression (RNNoise)
and then Limiter at -1 dB. This helps, but the organizers can do better
denoising if you also give them the silent room sample.

A webcam is optional. If you add a Video Capture Device, shrink it to a
corner where no slide text sits. The order in the Sources list is the
stacking order, and the top item covers the ones below.

# Step 5. Assign hotkeys for the slides

1.  Open Settings, then Hotkeys.
2.  Scroll to the name of your Image Slide Show source.
3.  Assign keys for Next Slide and Previous Slide. Page Down and Page Up
    work well, and most presentation clickers send these keys.
4.  Also assign Start Recording and Stop Recording, for example
    Ctrl+Shift+R and Ctrl+Shift+S.

On macOS, OBS needs Input Monitoring and Accessibility permissions in
System Settings, Privacy and Security. Without them, the hotkeys only
work while the OBS window has focus. Test the keys before the real take.

Keep speaker notes visible without filming them. Open the PDF in a
viewer on a second monitor, or print the notes. OBS films only what is
in the scene, so nothing else on your screen appears in the video.

# Step 6. Record the talk

1.  Close notification apps, turn off fans, and silence your phone.
2.  Click the first slide into place. Press Previous Slide a few times
    to be sure you are at slide 1.
3.  Press Start Recording.
4.  Stay silent for 5 to 10 seconds. This is the room noise sample.
5.  Say \"Hi! I am Blaine Mooers and I will be talking about TOPIC.\"
6.  Advance slides with your Next Slide key as you speak.
7.  If you stumble, pause for three seconds and repeat the sentence. The
    pause makes the cut easy to find in the editor.
8.  Press Stop Recording.

The organizers note that many speakers record the narration first, edit
it to time, and then lay slides over it. With this approach you can
record in OBS with only the slides and your voice, then trim in
Kdenlive.

# Step 7. Check, trim, and convert to WebM

1.  Watch the whole recording. Check that the text is readable at 720p
    and that the audio has no clipping.
2.  Trim silences and retakes in Kdenlive if needed. Keep the opening
    silence as a separate clip for the organizers.
3.  Convert to WebM with the two-pass `compress-video.sh`{.verbatim}
    script on the EmacsConf prepare page. Copy it into a file and run it
    like this.

``` bash
sh compress-video.sh recording.mkv emacsconf2026-mooers.webm
```

The first pass shows a speed of zero. This is normal. The second pass
shows real progress.

1.  Upload through the web service when it opens, or email
    emacsconf-org-private@gnu.org for instructions.

# Troubleshooting

`\index{OBS!troubleshooting}`{=latex}

  Problem                          Fix
  -------------------------------- ---------------------------------------------------
  Slides play in the wrong order   Check zero padding in file names
  Slides advance on their own      Set Slide Mode to Manual
  Hotkeys do nothing outside OBS   Grant Input Monitoring and Accessibility on macOS
  Black bars beside the slides     Export 16:9 slides (Beamer aspectratio=169)
  Red and blue look swapped        Toggle \"Swap red and blue\" in Window Capture
  New PNG files do not appear      Remove and re-add the directory in the source
  Text looks blurry                Raise WIDTH in the script, e.g. WIDTH=2560

  : Common problems and their fixes.

# Checklist

``` org
- [ ] Export slides as 16:9 PDF with dark text on a light background
- [ ] Run pdf2png.sh and confirm the slide count
- [ ] Set OBS canvas and output to 1280x720 at 30 fps
- [ ] Duplicate the 2024 scene and load the new PNG directory
- [ ] Set Slide Mode to Manual and assign Next and Previous hotkeys
- [ ] Test microphone levels and noise filters
- [ ] Record 5 to 10 seconds of silence, then the talk
- [ ] Review and trim the recording
- [ ] Convert to WebM with compress-video.sh
- [ ] Email emacsconf-org-private@gnu.org about the late upload
```
