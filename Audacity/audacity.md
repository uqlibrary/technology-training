# Audacity: introduction to audio editing

Audacity is an Open Source, cross-platform tool for audio editing.

Among other features, Audacity allows you to:

* record live audio and computer playback
* edit and export in a variety of file formats
* cut, copy, splice and mix sounds
* apply a variety of effects

Audacity started in 1999 and is currently being used as a professional-grade audio editor in many applications, including music and podcast production.

## What we'll learn

This training covers how to:

* import audio into Audacity
* move and delete sections
* clean up background noise
* switch between sound visualisation tools
* use a few essential effects
* export to a variety of formats
* publish audio online

## Download some audio

Our two 1919 sample audio files come from the Internet Archive. You can download the two archived files [here](https://cloudstor.aarnet.edu.au/plus/s/fHnlJvlEl09Iz3T), and extract them on you desktop.

The pages that describe the recordings are here:

* The comedy bit: https://archive.org/details/78_cohen-at-the-picnic-part-2_monroe-silver-silver_gbia0095538/
* The song: https://archive.org/details/AgnesLynn

## Import an audio file

Audacity supports a variety of audio formats. We deal with MP3 files today.

To import an audio file: File > Open... > choose the first file.

You can also drag-and-drop an audio file into Audacity. Try that with the second file.

## Interface

We are dealing with two stereo clips here. The top half of a clip is the left channel, and the bottom half is the right channel.

The louder the sound, the higher the waveform. The quieter, the closer to the middle point.
The dark blue area show the waveform peak of grouped samples (the loudest part), whereas the light blue area shows the Root Mean Square value of grouped samples (an guide to how loud it sounds).

## Controls

We have two audio files. If we press play (green button, or spacebar), they will be played at the same time.

We can focus on the speech by **muting** the song, with the "Mute" button. It is then obvious which track is muted, as it is displayed in grey.

We can use the mouse wheel to scroll vertically through our audio clips. To zoom and pan the audio clips efficiently, we need to learn about the keyboard keys we can associate with the mouse wheel:

*  <kbd>Ctrl</kbd> + Scroll: zoom in and out
*  <kbd>Ctrl</kbd> + Scroll: navigate up and down the timeline

These controls allow us to quickly navigate the clips and find the precise spots we want to work on. Make sure you practise them! You will notice that it is a lot more comfortable to work with Audacity when using a mouse.

If you zoom close enough to a soundwave, you will see that sound can't be stored digitally as actual waves. Each dot is a sample point. Depending on the bitrate of your audio file (i.e. the quality), the encoding will be more or less precise.

## Clipping and normalising

You might see red lines on the "Cohen at the Picnic" track (if not, use "View > Show Clipping"). This denotes **clipping**, which means the soundwave goes over an intensity limit, which might result in artefacts when exporting the project.

To resolve clipping, we can **normalise** the track, which is equivalent to reducing the amplitude of the soundwave, for it to fit within a range. Click on the grey area next to the track to select it, and use:

Effect > Normalize...

That should have reduced the amplitude, and removed the red bars.

## Compressing

Sometimes, normalising is not enough. If a recording has a few very loud peaks, but the rest is very quiet, it might be worth it playing with **compression**. Select the whole clip and use:

Effect > Compressor...

We can use the default settings and see the effect.

The compressor amplifies quiet parts differently to louder parts, according to the settings. This means that we can make quieter sections a lot louder, while only amplifying the peaks a tiny bit – or even lowering their level. It ends up evening out the volume of the whole recording, which can be particularly useful if the audio is to be played in a noisy environment.

As you can expect, the compressor has to be used carefully as it reduces the dynamic range of a recording, i.e. it can render a sound less interesting because of less variability in the amplitude.

You might have to normalise again after compressing – keep an eye on clipping.

## Noise reduction

As you can hear, there is quite a lot of noise in this first track. Luckily, the recording starts with a few seconds of only noise before the clock and the narrator come in.

We can use this section to create a noise profile, and then use the noise reduction effect to try and clean part of the noise.

1. Select the section at the beginning of the recording that is only noise (you can then use the spacebar to play only that section and check if you only selected noise)
1. Use "Effect > Noise Reduction..."
1. Click "Get Noise Profile"
1. Select the whole track
1. Use "Effect > Noise Reduction..." again
1. Click OK

You can play with the effect's settings to optimise the noise reduction.

## Removing audio

Now that we have cleaned up some of the noise, we can remove the first few seconds of the clip so we get straight away to the interesting bit.

With the selection tool, we can select the (roughly) 4 first seconds, and remove them with <kbd>Del</kbd>. We can do the same thing with the end of the recording.

## Fading in and out

To make our recording start smoothly, we can fade the sound in.

Still using our selection tool, select the first two seconds of the clip, and use:

Effect > Fade In.

We can do the same with the end of the recording, but using the "Fade Out" effect instead.

## Moving audio

Let's unmute the second track. We want the song to start at the end of the spoken recording. We can do that by changing to the Time Shift Tool and sliding the clip to the right.

Let's make sure the two clips fade into each other by fading the song in. We also want to normalise this track so the sound level is similar to the first one.

## Using the spectrogram

You can switch between visualisation tools by using the clip title dropdown menu.

The spectrogram view makes it possible to visualise frequencies rather than the level, and can help finding specific sounds in the recording.

For example, if there is a constant high-pitched hissing noise throughout a recording, the spectral selection tool will allow the selection of the precise frequency, and the Spectra edit mutlitool effect will remove it:

* Select > Spectral > Toggle spectral selection
* Effect > Spectral edit multitool

## Saving and exporting

Saving an Audacity project will save everything in the current state, so you can keep editing your audio files and putting everything together.

If you are finished with your project and you want to export a finished product, you can use "File > Export". A few common formats are listed, including lossy formats like MP3 and OGG, and lossless formats like WAV. Using "Export Audio...", you can choose other formats FLAC, a lossless format that uses less space than WAV.

Try exporting you project and giving it relevant **tags** so information can be displayed by audio players. By default, Audacity will use the tags from the first clip imported into the project.

The resulting file is a single stereo audio file. You can also "Mix and Render" tracks inside a project, which is the equivalent.

## Where to find audio files?

Always make sure that the licence is compatible with your us of the files.

* The Internet Archive is a great source of recordings: https://archive.org/details/audio
* FreeSound.org is a wealth of sound snippets released under Creative Commons licences
* SoundCloud can be searched with Creative Commons licence filters
* http://freemusicarchive.org/ offers thousands of songs released under a variety of licences
* Wikimedia Commons can also be searched for audio files: https://commons.wikimedia.org/wiki/Category:Audio_files
* http://dig.ccmixter.org/ specialises in making Creative Commons music discoverable.

## Where to publish?

Once more, make sure you have the right to release the recording publicly.

The choice of platform used to publish an audio file will depend on the audience and the use.

The Internet Archive and Wikimedia Commons are non-profit organisations that are generally considered to be reliable hosts of media. SoundCloud is very popular to share audio files, in particular because of its social features, but it is run by a for-profit entity that has been having difficulties to survive in the last few years.

Freesound is an initiative of the Music Technology Group, a research group of the Universitat Pompeu Fabra (UPF) in Barcelona. Having a project like this one backed up by a university's infrastructure is a good sign of sustainability.

Both the Internet Archive and SoundCloud will allow you to embed a sound into another webpage, which might be useful.

