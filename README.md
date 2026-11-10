# Tutorial for making a video of a slideshow in OBS

Open Broadcaster Software (OBS) is a free, open-source software package for making videos.
It is no more difficult to use than some commercial software packages like Camtasia, which I own, but I find it takes several hours to master after long interruptions.
Camtasia's advantage is that it supports video editing.
I have learned that I would need to invest much more time than I'm willing to spend mastering editing.
I have decided that it is not worth my trouble.

Probably the simplest way to make videos with a slideshow is to make them in Zoom, since most people are already pretty familiar with it.
I have access to Zoom through my workplace.
I understand Zoom is not a universal solution.
OBS is a good solution, although you should expect to spend a couple of hours getting things set up and working.

OBS is the suggested software for preparing videos for the EmacsConf in December.
November 2026 was the fifth time I'd done this, and it took me about 3 hours to get OBS finally into a state where it could start recording a video.
I had done some stupid things, like leaving a cover over my webcam, so I couldn't see the green light indicating that the camera was actually on.
The black screen I saw was the back of the cover over the camera.
This mistake cost me about half an hour.

I decided to develop a detailed protocol for my future self.
I have posted it here for the benefit of others.
It's in an Org mode file and a Markdown file.

# Recording Issues

## Find a quiet room
The first problem with doing these recordings is finding a quiet enough room.
The best time of day is probably very early in the morning, when distant traffic noise is reduced.
I have a spot at home that is much quieter than my work office, where the ventilation system creates a lot of white noise.

## Find a good backdrop
The second difficulty is finding a good backdrop for your recording.
You can use a blank wall, or a bookcase with plants and/or other mementos to make it more interesting.
I have a bay window area in our main bedroom with Venetian blinds.
I close the blinds, which gives me a white backdrop for my talk.
Light leaks through the blinds when recording during the day, so recording in the dark is better.

## Resizing of the slides
The third problem is often the sizing and positioning of the slideshow in the captured area.
You can address this by loading PNG files for each slide.
OBS then handles the slide sizing.
You have to run a script to convert your slide PDF into PNG files.

## Positioning of webcam on slides
The fourth problem is positioning the box that contains your talking head.
You can customize the shape and size of this box in several ways.
Sometimes you're stuck with the presets, which may be a bit wider than you want.
The positioning of this box is critical and should be considered before you make your slides or as you make your slides because you do not want that box to cover up any important information in your slides.

## Remux the MKV file
The fifth problem you have to deal with is that OBS writes an MKV file. 
You have to remux it to convert it to an MP4 file you can run by double-clicking. 
I wrote it to my Movies folder in my top directory.
You can remux it through OBS under File/Remux Recording.

My initial recording was just under 20 minutes.
I was surprised to find it was only about 50 MB.
In years past, it was about 10 times larger.
You can configure OBS to generate the MP4 file automatically.

## Skip editing the movie
The sixth problem is whether to bother editing the video.
This can take many hours.
The recording can end up sounding quite choppy if you're an amateur video editor.
I have not been very successful in my attempts to do this.

I think many people think they can improve quality through editing.
I find that this isn't true, and it is much better to polish or talk as best as possible before you record.
You probably want to make several recordings, but by then you should be under the time limit, and your delivery should be fairly smooth.

It is actually faster to practice the talk many times before recording it.
Through practice, you can get your talk under the target talk length.
Then you can do several recorded rehearsals.
Then you can choose the best one.

You can display your talk speaker notes and glance at them as you go.
I prefer to memorize my talks so the delivery is more natural and smoother, and so it is not obvious that I might be reading notes.
To be frank, I have never really figured out how to display speaker notes effectively, so I have fallen back on memorizing my talks.
