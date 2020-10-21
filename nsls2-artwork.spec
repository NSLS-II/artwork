# As this is only for artwork there is no meaningful debuginfo
%global debug_package %{nil}

Name:           nsls2-artwork 
Version:        0.1.6
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


%files
#%license LICENSE
%doc README.md
%{_datadir}/nsls2/bin/nsls2-change-wallpaper
%{_datadir}/nsls2/bin/set-wallpaper
%{_sysconfdir}/xdg/autostart/set-wallpaper.desktop
%{_datadir}/nsls2/tabs/*.png
%{_datadir}/nsls2/wallpapers/wallpaper.jpg
%{_datadir}/nsls2/wallpapers/beamlines/*.jpg
%{_datadir}/nsls2/wallpapers/generic/*.jpg

%changelog
* Wed Oct 21 2020 Stuart Campbell <scampbell@bnl.gov>
- Initial package 
