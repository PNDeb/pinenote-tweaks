# Debian Trixie for the Pine64 PineNote

## Introduction

Hi there, nice of you to install this Debian image on your PineNote!

Before you begin, please bear in mind that the PineNote, and this image, is
aimed a experienced users and developers, and many things need manual tweaking
or do not just work yet.
However, many things also work, and you can take control of quite a lot of
things.
If you have not done this yet, we strongly recommend to at least skim this
document before proceeding to use your PineNote.

If you want to improve this text, merge requests are very very much appreciated!

[Improve on github](https://github.com/PNDeb/pinenote-tweaks/tree/main/pn_handbook)

## Where to get help

Remember, software for the PineNote is created by the community, for the
community!

Probably the best and fastest way to get help is to join the PineNote chat via
Matrix, irc, or Discord. Please refer to the wiki page for more information on
chats and forums: [Pine64
Wiki](https://wiki.pine64.org/wiki/Main_Page#Community_and_Support).

## Getting started

* User/Password: You are logged in as user "user" with password "1234". sudo is
  activated. We suggest to set a root password:

    ```
    sudo su - root
    passwd
    ```

* The **Documents/** directory contains one sample .pdf and one .epub file. Try
  opening them and start reading!

* You may want (should!) to reconfigure your locales:

	```
	sudo dpkg-reconfigure locales
 	```

* The status bar at the top contains the refresh button and the PineNote-Helper
  Gnome extension, which helps you to control some aspects of the eink display.
  Both of these items will become important for an effective use of the
  PineNote in a Gnome environment.

* (advanced users) Your PineNote comes partitioned with two operating system partitions (**os1** and **os2**, each ca. 15 GB in size).
  The default install resides on **os1**, leaving **os2** for experiments, such as other distributions images, etc. If you plan on modifying this installation heavily, a second install to **os2** could help in recovering from serious errors. More information on installing a Debian image to **os2** can be found [here](https://github.com/PNDeb/pinenote-debian-image/blob/trixie/partition_tables/Readme.md).

## How do I...

* **Read a book (epub)/pdf**:
	* Koreader is already installed and should be registered for corresponding
	  file types
* **Take notes**: Xournalpp is installed on the Pinenote by default.
  Other note-taking apps to test/consider:
	* https://github.com/saber-notes/
	* rnote
	* syioek (???)
* Surf the internet using Firefox
* **Use the Pinenote as an external screen?**:
	* (untested) The Weylus project could be of help: https://github.com/H-M-H/Weylus
* **Use an external monitor with the Pinenote?**: The Pinenote is not wired to provide external display support via usb-c (this is called [alternate mode](https://en.wikipedia.org/wiki/USB-C#Alternate_modes). Therefore, if you want to use the PineNote as an external display, you will need to use other means.
	* (untested) The Weylus project could be of help: https://github.com/H-M-H/Weylus
   	* (untested) Provided that you are running a newer GNOME installation on your computer, you could try to use gnome remote connections and virtual monitors (https://ubuntuhandbook.org/index.php/2023/07/share-extended-screen-gnome/)

## Updates

Apart from a number of tweaks aimed at producing an improved user experience on
the PineNote, and a few patched packages, you are running a Debian Trixie
operating system which can be maintained as very other system. Use `apt` or
`aptitude` to manage you packages. `gnome-software` is also installed and should prompt you within GNOME in regular intervals if software updates are available.

A PineNote package repository is in its early testing phase, and should be
configured by default in this installation. For manual configuration of the
repository, please refer to [this part of the image
Readme.](https://github.com/PNDeb/pinenote-debian-image/tree/dev#pinenote-specific-debian-repository)

## Using another partition for /home

Depending on the method of installation, /home is located on the root
partition, which is quite small in size (check by analysing the output of the
*mount* command).
However, a bash script is
provided in `/root/switch_home_to_other_partition.sh` which can be used to
change the partition that is used for /home. The script can also transfer data
from the current /home to the new partition. Call as root.

Example to switch /home to /dev/mmcblk0p7:

	cd /root
	switch_home_to_other_partition.sh /dev/mmcblk0p7

## Switching the default boot partitions

TODO

## Documentation for apps/systems

### Wakeup-Sources

* Cover
* Bluetooth
* Power cable
* Button
* Touch screen

### Sleep sources

* PWR-Button-press
* Pen-Button-Press

### BLE Pen (Buttons)

The PineNote Pen interfaces with the PineNote using two interfaces:

* The stylus input is one using the touchscreen (cyttsp5 driver),
* on the other hand, the three buttons are controlled via a separate
  Bluetooth-Low-Energy-based connection.

  A driver for the BLE-button interface was developed by smaeul
	(https://github.com/smaeul/linux/commits/rk356x-ebc-dev).

The hardware contains non-volatile storage for the MAC address - it could be
that the pen just works. Otherwise, as root, connect manually:

	echo 1 > /sys/bus/spi/devices/spi4.0/scan; # scanning takes ca. 12 seconds
											 # press the buttons during scanning
    # print MAC address pen
	cat /sys/bus/spi/devices/spi4.0/scan
	echo [MAC] > /sys/bus/spi/devices/spi4.0/pen_address

Afterwards, check that the pen is working by checking the pen attributes:

	cat /sys/bus/spi/devices/spi4.0/pen_version
	cat /sys/bus/spi/devices/spi4.0/pen_battery

### EBC Kernel Driver

The EBC subsystem controls the eink (or epd) display and is one of components
which require most tweaking for each user.

	* ioctls

		* trigger global refresh
		* set offline-screen
		* [to implement] set standby screen mask & behavior
	* misc:

		* discuss the waveform-switching issues in a general DE environment:
		  recommend to always do a global refresh after switching waveforms,
		  unless you know that your buffer is compatible
### Usage

All module parameters are controlled using the sysfs parameters in
/sys/module/rockchip_ebc/parameters

The module parameters can also be set on module load time, for example using
the modprobe configuration file:

	root@pinenote:~# cat /etc/modprobe.d/rockchip_ebc.conf
	options rockchip_ebc direct_mode=0 auto_refresh=1 split_area_limit=0 panel_reflection=1

By default the parameters in /sys/module/rockchip_ebc/parameters need to be
writen to as root, but this can be easily changed via udev rules.

### Debugging

Newer versions of the kernel driver use the (dynamic debug
feature)[https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html]
of the linux kernel.

As root, the following commands should get you going. Note that the line
numbers can change between kernel releases! Check the output of `cat control |
grep rockchip_ebc`

	cd /sys/kernel/debug/dynamic_debug/
	# lists all debug outputs available for the module
	cat control  | grep rockchip_ebc
	# now we can activate/disable individual debug statements
	echo -n 'file drivers/gpu/drm/rockchip/rockchip_ebc.c line 1289 +p' > control
	# list currently active (=p) debug statements
	cat control  | grep rockchip_ebc | grep " =p "


### Overview of module/sysfs-parameters:

* TODO
* **split_area_limit** split_area_limit denotes the number of splits that the
  driver is allowed to apply to individual clips. The idea is: when you submit
  two damage regions for drawing, and both regions overlap, and the first one
  already started, then it sometimes makes sense to split the second area into
  four smaller regions, from which three can already start drawing. This is
  really useful for writing applications where there is usually a little bit of
  overlap between subsequent drawing areas

In addition, two custom ioctls are currently implemented for the ebc driver:

* TODO

### Black and White mode

Activate with

	echo 1 > /sys/module/rockchip_ebc/parameters/bw_mode

the threshold value can be set using:

	echo 7 > /sys/module/rockchip_ebc/parameters/bw_threshold

7 is the default value, meaning that all pixel values lower than 7 will be cast
to 0 (black) and all values larger than, or equal to, 7 will be cast to 15
(white).

### Auto Refresh

Enabling automatic global (full screen) refreshes:

	echo 1 > /sys/module/rockchip_ebc/parameters/auto_refresh

Global refreshes are triggered based on the area drawing using partial
refreshes, in units of total screen area.

	echo 2 > /sys/module/rockchip_ebc/parameters/refresh_threshold

therefore will trigger a globlal refresh whenever 2 screen areas where drawn.

The threshold should be set according to the application used. For example,
evince and xournalpp really like to redraw the screen very often, so a value of
20 suffices.
Other require lower numbers.

The waveform to use for global refreshes can be set via

	echo 4 > /sys/module/rockchip_ebc/parameters/refresh_waveform

A value of 4 is the default.

### Waveforms

* the **default_waveform** parameter controls which waveform is used. Based on
  information from include/drm/drm_epd_helper.h, the integer values are
  associated with the following waveforms:

		0: @DRM_EPD_WF_RESET: Used to initialize the panel, ends with white
		1: @DRM_EPD_WF_A2: Fast transitions between black and white only
		2: @DRM_EPD_WF_DU: Transitions 16-level grayscale to monochrome
		3: @DRM_EPD_WF_DU4: Transitions 16-level grayscale to 4-level grayscale
		4: @DRM_EPD_WF_GC16: High-quality but flashy 16-level grayscale
		5: @DRM_EPD_WF_GCC16: Less flashy 16-level grayscale
		6: @DRM_EPD_WF_GL16: Less flashy 16-level grayscale
		7: @DRM_EPD_WF_GLR16: Less flashy 16-level grayscale, plus anti-ghosting
		8: @DRM_EPD_WF_GLD16: Less flashy 16-level grayscale, plus anti-ghosting

* (side note): Based on information from drivers/gpu/drm/drm_epd_helper.c, the
  Pinenote uses eps lut form 0x19, which associated waveform types with the
  luts stored in the file as:

		.versions = {
		    0x19,
		    0x43,
		},
		.format = DRM_EPD_LUT_5BIT_PACKED,
		.modes = {
		    [DRM_EPD_WF_RESET]  = 0,
		    [DRM_EPD_WF_DU]     = 1,
		    [DRM_EPD_WF_DU4]    = 7,
		    [DRM_EPD_WF_GC16]   = 2,
		    [DRM_EPD_WF_GL16]   = 3,
		    [DRM_EPD_WF_GLR16]  = 4,
		    [DRM_EPD_WF_GLD16]  = 5,
		    [DRM_EPD_WF_A2]     = 6,
		    [DRM_EPD_WF_GCC16]  = 4,
		},

  For example, if you want to inspect/modify the A2 waveform, this corresponds
  to the 7th waveform in the lut file (index 6), but is activated via
  **default_waveoform** by writing value 1.

### Trimming the A2 waveform

You can trim the A2 waveform for improved writing performance, with the
downside that black sometimes is displayed in gray tones.

The supplied script is very slow and unoptimized and therefore not run
automatically (run time on pinenote ca. 20 minutes).

Call these command in a root shell to trim the A2 waveform (note: this will
reboot the pinenote once):

	cd /root
	# this command should take ca. 20 minutes !!!
    time python3 parse_waveforms_and_modify.py
	# save the original waveforms for later use
    mv /lib/firmware/rockchip/ebc.wbf /lib/firmware/rockchip/ebc_orig.wbf
   	ln -s /lib/firmware/rockchip/ebc_modified.wbf /lib/firmware/rockchip/ebc.wbf
	update-initramfs -u -k all
	reboot

### Xournalpp/Writing

* At this point, despite disabling animations, GNOME still shows the spinning
  animation in the panel when xournalpp is started. This prevents proper and
  fast drawing of screen regions. For best experience, wait until the loading
  animation stops before you start drawing/writing.
* Switch to "BW+Dither" mode when working in Xpp
* The default configuration uses evsieve to merge events from the pen (for
  drawing) and the pen buttons. This is a solution to the problem that the pen
  input and the pen buttons are completely independent systems and therefore
  register as different inputs in the system.

  The evsieve solution add something like 15 ms lag to the input (according to
  the evsieve readme). You can disable this approach by running (in a root
  shell):

	systemctl stop evsieve.service
	systemctl disable evsieve.service

  Make sure to restart Xpp and to reconfigure the input sources in the
  settings.
* By default the touch screen is disabled as an input for Xpp. You need to
  activate it in the settings in order to scroll using touch gestures.
* If the pen buttons are configured, holding down the button nearest to the tip
  should allow you to scroll using the pen.
* (depending on XPP version) After both pen and touch scrolling a global
  refresh is triggered
* Kinetic scrolling needs to be disabled because GTK3's implementation
  interferes with some aspect of touch input handling, including touch cancel
  events

## What is not working?

In general, for an up-to-date list of open issues, refer to PNDEB-issue
tracker. TODO

* Open Issues

	* Gnome extension: There are issues when suspend/screen blanking (i.e.,
	  unloading of the extension is broken)

# Topics to cover here

* DBUS service

	* contrl ebc driver
	* [to implement] handle pen pairing/unpairing

* The GNOME extension
* Pen
* Resources
