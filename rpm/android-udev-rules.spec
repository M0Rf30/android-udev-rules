Name:           android-udev-rules
Version:        20230310
Release:        1%{?dist}
Summary:        Udev rules to connect Android devices to your linux box
License:        GPL-3.0-or-later
URL:            https://github.com/M0Rf30/android-udev-rules
Source0:        https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules
Source1:        https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/README.md
Source2:        https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/LICENSE
Source3:        https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/android-udev.conf
BuildArch:      noarch
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

# Build with: rpmbuild --undefine=_disable_source_fetch -bb android-udev-rules.spec

%description
Android udev rules list aimed to be the most comprehensive on the net.
Based on the official Android Studio documentation as well as suggestions from
the Archlinux and Github Communities.

%prep
cp %{SOURCE0} %{SOURCE1} %{SOURCE2} %{SOURCE3} .

%build

%install
mkdir -p %{buildroot}/etc/udev/rules.d/.
install -m 644 51-android.rules %{buildroot}/etc/udev/rules.d/.
mkdir -p %{buildroot}/usr/lib/sysusers.d/.
install -m 644 android-udev.conf %{buildroot}/usr/lib/sysusers.d/.

%clean
rm -rf %{buildroot}

%files
%config(noreplace) /etc/udev/rules.d/51-android.rules
%config /usr/lib/sysusers.d/android-udev.conf
%{!?_licensedir:%global license %%doc}
%license LICENSE
%doc README.md

%post
systemd-sysusers
udevadm control --reload-rules
systemctl restart systemd-udevd.service

%postun
udevadm control --reload-rules
systemctl restart systemd-udevd.service

%changelog

* Fri Mar 10 2023 Giedrius Masalskis <giedrius@masalskis.net> - 20230310-1
- Install android-udev.conf and create system group.

* Sun Jan 02 2022 Håkon Løvdal <kode@denkule.no> - 20220102-1
- Latest stable tag.

