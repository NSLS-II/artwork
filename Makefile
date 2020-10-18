# Set common variables
prefix = /usr/local
datarootdir = $(prefix)/share
datadir = $(datarootdir)/nsls2
sysconfdir = $(prefix)/etc
exec_prefix = $(prefix)
libexecdir = $(exec_prefix)/libexec

wallpapers = $(wildcard wallpapers/*.jpg)
tabs = $(wildcard tabs/*.png)
scripts = bin/set-wallpaper
autostart = autostart/set-wallpaper.desktop

generic_wallpaper = NSLS-II_Generic_Desktop_Wallpaper_Dark.jpg

.PHONY: all
all:

.PHONY: .install-autostart
.install-autostart: $(autostart)
	install -m 644 -t $(sysconfdir)/xdg/autostart $?

.PHONY: .install-scripts
.install-scripts: $(scripts)
	mkdir -p $(libexecdir)/nsls2
	install -m 755 -t $(libexecdir)/nsls2 $?

.PHONY: .install-tabs
.install-tabs: $(tabs)
	mkdir -p $(datadir)/tabs
	install -m 644 -t $(datadir)/tabs $?

.PHONY: .install-wallpapers
.install-wallpapers: $(wallpapers)
	mkdir -p $(datadir)/wallpapers
	install -m 644 -t $(datadir)/wallpapers $?
	cd ${datadir}/wallpapers && ln -sf $(generic_wallpaper) wallpaper.jpg

.PHONY: install
install: .install-wallpapers .install-tabs .install-scripts .install-autostart
