Name:           android-udev-rules
Version:        20220102
Release:        1%{?dist}
Summary:        Udev rules to connect Android devices to your linux box
License:        GPLv3+
URL:            https://github.com/M0Rf30/android-udev-rules
Source0:        https://github.com/M0Rf30/android-udev-rules/raw/master/51-android.rules
Source1:        https://github.com/M0Rf30/android-udev-rules/raw/master/README.md
Source2:        https://github.com/M0Rf30/android-udev-rules/raw/master/LICENSE
BuildArch:      noarch
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%description
Android udev rules list aimed to be the most comprehensive on the net.
Based on the official Android Studio documentation as well as suggestions from
the Archlinux and Github Communities.

%prep
cp %{SOURCE0} %{SOURCE1} %{SOURCE2} .

%build

%install
mkdir -p %{buildroot}/etc/udev/rules.d/.
install -m 644 51-android.rules %{buildroot}/etc/udev/rules.d/.

%clean
rm -rf %{buildroot}

%files
%config(noreplace) /etc/udev/rules.d/51-android.rules
%{!?_licensedir:%global license %%doc}
%license LICENSE
%doc README.md

%changelog

* Sun Jan 02 2022 Håkon Løvdal <kode@denkule.no> - 20220102-1
- Latest stable tag.

