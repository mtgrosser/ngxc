Name:    ngxc
Version: 0.5.0
Release: 1%{?dist}
Summary: Nginx configuration file compiler

License: MIT
Source0: https://github.com/mtgrosser/ngxc/archive/v%{version}.tar.gz

%description
Write your nginx configuration files in Ruby - no Ruby required!

%prep
%autosetup -v 

%build
rake

%install

mkdir -p %{buildroot}/%{_bindir}
mkdir -p %{buildroot}/usr/lib/systemd/system/nginx.service.d/%{name}.conf

install -m 0755 build/%{name} %{buildroot}/%{_bindir}/%{name}
install -m 0644 systemd/nginx.service.d/%{name}.conf %{buildroot}/usr/lib/systemd/system/nginx.service.d/%{name}.conf

%files
%{_bindir}/%{name}
/usr/lib/systemd/system/nginx.service.d/%{name}.conf

%changelog
* Mon Sep 11 2017 Matthias Grosser <mtgrosser@gmx.net> - 0.2.0-1
  - Updating to latest version
* Mon Aug 28 2017 Matthias Grosser <mtgrosser@gmx.net> - 0.1.1-1
  - First rpm package
