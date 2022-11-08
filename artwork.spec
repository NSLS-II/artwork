# As this is only for artwork there is no meaningful debuginfo
%global debug_package %{nil}

Name:           artwork
Version:        0.2.1
Release:        1%{?dist}
Summary:        NSLS-II Artwork 

License:        Redistributable, no modification permitted
URL:            https://github.com/NSLS-II/artwork
Source0:        https://github.com/NSLS-II/artwork/archive/v%{version}/artwork-v%{version}.tar.gz

#BuildRequires:  
#Requires:       

%description
Package for NSLS-II Artwork

%prep
%setup -q -n artwork-%{version}

%build

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}/%{_datadir}/nsls2
make DESTDIR=%{buildroot} \
     prefix=%{_prefix} \
     sysconfdir=%{_sysconfdir} \
     install

%post
%{_datadir}/nsls2/bin/nsls2-change-wallpaper

%files
#%license LICENSE
%doc README.md
%{_datadir}/nsls2/bin/nsls2-change-wallpaper
%{_datadir}/nsls2/bin/set-wallpaper
%{_sysconfdir}/xdg/autostart/set-wallpaper.desktop
%{_datadir}/nsls2/tabs/*.png
%{_datadir}/nsls2/photos/*.jpg
%{_datadir}/nsls2/wallpapers/wallpaper.jpg
%{_datadir}/nsls2/wallpapers/beamlines/*.jpg
%{_datadir}/nsls2/wallpapers/generic/*.jpg

%changelog
* Tue Nov 08 2022 Stuart Campbell <scampbell@bnl.gov> 0.2.1-1
- Added some more photos

* Fri Sep 30 2022 Stuart Campbell <scampbell@bnl.gov> 0.2.0-1
- Updated all the wallpapers for the NSLS-II Rebranding

* Fri Dec 17 2021 Stuart B. Wilkins <swilkins@bnl.gov>
- Added post install script to spec file
- Updated XFP wallpaper to correct long name

* Mon Dec 13 2021 Stuart B. Wilkins <swilkins@bnl.gov>
- Renamed package from nsls2-artwork to artwork
- Added photos dir

* Thu Oct 22 2020 Stuart Campbell <scampbell@bnl.gov>
- Renamed package from nsls2-artwork to artwork-nsls2

* Wed Oct 21 2020 Stuart Campbell <scampbell@bnl.gov>
- Initial package 


