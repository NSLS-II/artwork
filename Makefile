# Set common variables
prefix = /usr/local
datarootdir = $(prefix)/share
datadir = $(datarootdir)/nsls2
sysconfdir = $(prefix)/etc
exec_prefix = $(prefix)
libexecdir = $(exec_prefix)/libexec


wallpapers_beamlines  = $(wildcard wallpapers/beamlines/*.jpg)
wallpapers_generic    = $(wildcard wallpapers/generic/*.jpg)
tabs = $(wildcard tabs/*.png)
photos = $(wildcard photos/*.jpg)
scripts = $(wildcard bin/*)
autostart = $(wildcard autostart/*.desktop)

generic_wallpaper = generic/NSLS-II_Generic_Desktop_Wallpaper_Dark.jpg
wallpaper_dir = $(datadir)/wallpapers

export wallpaper_dir
export libexecdir

.PHONY: all
all:

.PHONY: .install-scripts
.install-scripts: $(scripts)
	mkdir -p $(DESTDIR)$(datadir)/bin
	install -m 755 -t $(DESTDIR)$(datadir)/bin $?

.PHONY: .install-autostart
.install-autostart: $(autostart)
	mkdir -p $(DESTDIR)$(sysconfdir)/xdg/autostart
	install -m 644 -t $(DESTDIR)$(sysconfdir)/xdg/autostart $?

.PHONY: .install-tabs
.install-tabs: $(tabs)
	mkdir -p $(DESTDIR)$(datadir)/tabs
	install -m 644 -t $(DESTDIR)$(datadir)/tabs $?

.PHONY: .install-photos
.install-tabs: $(photos)
	mkdir -p $(DESTDIR)$(datadir)/photos
	install -m 644 -t $(DESTDIR)$(datadir)/photos $?

.PHONY: .install-wallpapers
.install-wallpapers: $(wallpapers)
	mkdir -p $(DESTDIR)$(wallpaper_dir)/generic
	mkdir -p $(DESTDIR)$(wallpaper_dir)/beamlines
	install -m 644 -t $(DESTDIR)$(wallpaper_dir)/generic $(wallpapers_generic)
	install -m 644 -t $(DESTDIR)$(wallpaper_dir)/beamlines $(wallpapers_beamlines)
	cd $(DESTDIR)$(wallpaper_dir) && ln -sf $(generic_wallpaper) wallpaper.jpg

.PHONY: install
install: .install-wallpapers .install-tabs .install-autostart .install-scripts .install-photos
