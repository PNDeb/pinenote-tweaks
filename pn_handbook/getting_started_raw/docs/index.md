# Getting Started with the PineNote

<!-- First point of contact, should give just enough to know whats what and
setup someone who has used Linux before -->

Welcome to your new PineNote, we hope you enjoy the experience of using the
PineNote.
The PineNote comes loaded with a community maintained Debian based distribution
that has been pre-configured for a reasonble starting point.
Of course, you are welcome to customise your device to suit _you_.

## Introduction

The Pinenote Debian should be fairly self explanatory, but there is a new menu
in the top bar of gnome that controls the ePaper display.
The display can render high quality greyscale, but due to the technology this
makes screen updates slower, as the screen does more refreshes and flickering.
This menu allows rapidly changing mode to suit what you are doing on the
device.

The screen features a Wacom digitiser for the pen input, and this is supported
out of the box.

### WiFi & Bluetooth
<!-- TODO -->
The PineNote can be connected to WiFi by using the menu in the top right hand
corner, and then tapping on the WiFi symbol.
Bluetooth also works as expected and shows up in this menu. This will allow you
to pair keyboards and other peripherals to the device.

Please keep in mind that the PineNote uses the same WIFI+Bluetooth combo also
found in various Raspberry Pi devices and shares some of the peculiarities of
this devices.
The most important thing to remember is that WIFI and BT share one antenna.
Moving Wifi over to a 5 Ghz network can not only improve WIFI experience in
congested areas for the PineNote, but can also drastically improve Bluetooth
quality.

### Updates

<!-- TODO -->
As the current operating system is Debian, the command line update tool is
`apt` but also the GUI program "Software" can be used to pull updates.
Where possible the OS is kept as close to upstream Debian, so everything should
feel about the same.

Please note that the PineNote comes with a custom package repository
pre-configured
This repository provides PineNote-specific packages, as well as a few patched
Debian packages that are useful/required for a smooth user experience.
The system is configured to prioritise this custom repository and will not
upgrade packages found in this repository with stock packages from the main
repository (this is called 'pinning').
This setup ensures improved working reliability of your PineNote, as the custom
repository is purely community maintained. While waiting for PN-specific
patches, we would not want stock packages to break the PN experience!

### ePaper Modes

ePaper displays work differently than traditional lcds.
Summarizing, these displays change their content by applying different voltage
waveforms to individual pixels, resulting in different shades of gray.
Problematic is that these waveforms differ depending on current temperature and
current state (color) of a given pixel.
In general, updating these displays is slow (complete screen updates can take
seconds!).

However, different waveforms have been developed by the panel producers to
improve response times.
However, speed is bought at the expensive of quality, and fast waveforms
exhibit artifacts (remnants of previous images), or can only operate on a
limited color subspace (i.e., only for black and white pixels).

In daily operation of the PineNote, you will most probably only encounter three
waveforms:

* GC16: This is the default, high-quality waveform that enables 16 grayscale
  colors. It's also the slowest refresh type.
* DU4: This is a somewhat faster waveform, good for reading. It supports only 4
  colors.
* A2: This is a very fast black & white waveform, useful for fast changes of
  screen content  (i.e., drawing, writing).

One additional feature of the hardware is partial refresh capability: The
display can only be updated in a certain, rectangular region. This can greatly
improve response times, but requires adapted software.

The default Gnome environment comes with a simple extension installed that lets
you change the current panel waveform (as well as enable dithering for the
black and white mode).

[TODO: image here]

### Touch Gestures in Debian

Gnome comes with some touch gestures built in. Please refer to the linked help
page from Gnome for detailed information.
However, the most important gesture is bringing up the On-Screen Keyboard (OSK)
by swiping two fingers from the button screen border upwards.

https://help.gnome.org/users/gnome-help/stable/touchscreen-gestures.html.en

### Thank you

<!--
pgwipeout?
-->

Finally, this software distribution is bought to you by Maximilian who has
tirelessly worked away and making this experience as polished as possible.
There have also been huge contributions by Samuel Holland and others who have
created the upstream ePaper driver that is used for this screen.
