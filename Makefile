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

generic_wallpaper = generic/NSLS-II_Generic_Desktop_Wallpaper_Dark.jpg
wallpaper_dir = $(datadir)/wallpapers

export wallpaper_dir
export libexecdir

.PHONY: all
all:

.PHONY: .install-cngscript
.install-cngscript: bin/nsls2-change-wallpaper
	mkdir -p $(DESTDIR)$(datadir)/bin
	install -m 755 -t $(DESTDIR)$(datadir)/bin $<

.PHONY: .install-setscript
.install-setscript: bin/set-wallpaper
	mkdir -p $(DESTDIR)$(datadir)/bin
	cat $< | envsubst '$${wallpaper_dir}' > $(DESTDIR)$(datadir)/bin/set-wallpaper
	chmod 755 $(DESTDIR)$(datadir)/bin/set-wallpaper

.PHONY: .install-autostart
.install-autostart: autostart/set-wallpaper.desktop
	mkdir -p $(DESTDIR)$(sysconfdir)/xdg/autostart
	cat $< | envsubst '$${libexecdir}' > $(DESTDIR)$(sysconfdir)/xdg/autostart/set-wallpaper.desktop

.PHONY: .install-tabs
.install-tabs: $(tabs)
	mkdir -p $(DESTDIR)$(datadir)/tabs
	install -m 644 -t $(DESTDIR)$(datadir)/tabs $?

.PHONY: .install-wallpapers
.install-wallpapers: $(wallpapers)
	mkdir -p $(DESTDIR)$(wallpaper_dir)/generic
	mkdir -p $(DESTDIR)$(wallpaper_dir)/beamlines
	install -m 644 -t $(DESTDIR)$(wallpaper_dir)/generic $(wallpapers_generic)
	install -m 644 -t $(DESTDIR)$(wallpaper_dir)/beamlines $(wallpapers_beamlines)
	cd $(DESTDIR)$(wallpaper_dir) && ln -sf $(generic_wallpaper) wallpaper.jpg

.PHONY: install
install: .install-wallpapers .install-tabs .install-setscript .install-autostart .install-cngscript
