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
setscript = set-wallpaper
autostart = set-wallpaper.desktop

generic_wallpaper = generic/NSLS-II_Generic_Desktop_Wallpaper_Dark.jpg
wallpaper_dir = $(datadir)/wallpapers

export wallpaper_dir
export libexecdir

.PHONY: all
all:

.PHONY: .install-autostart
.install-autostart: autostart/$(autostart)
	mkdir -p $(DESTDIR)$(sysconfdir)/xdg/autostart
	cat $< | envsubst '$${libexecdir}' > $(DESTDIR)$(sysconfdir)/xdg/autostart/$(autostart)

.PHONY: .install-setscript
.install-setscript: bin/$(setscript)
	mkdir -p $(DESTDIR)$(libexecdir)/nsls2
	cat $< | envsubst '$${wallpaper_dir}' > $(DESTDIR)$(libexecdir)/nsls2/$(setscript)
	chmod 755 $(DESTDIR)$(libexecdir)/nsls2/$(setscript)

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
install: .install-wallpapers .install-tabs .install-setscript .install-autostart
