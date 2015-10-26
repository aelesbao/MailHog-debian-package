#!/bin/bash

VERSION=${1:-0.1.8}
if [[ `uname -i` == 'x86_64' ]]; then
  _MAILHOG_ARCHITECTURE='amd64'
  _PACKAGE_ARCHITECTURE='amd64'
else
  _MAILHOG_ARCHITECTURE='386'
  _PACKAGE_ARCHITECTURE='i386'
fi

mkdir -p package/usr/sbin
wget "https://github.com/mailhog/MailHog/releases/download/v${VERSION}/MailHog_linux_${_MAILHOG_ARCHITECTURE}" -q -O package/usr/sbin/mailhog

sed -i "s/^Version:.*$/Version: ${VERSION}-1.0/g" package/DEBIAN/control
sed -i "s/^Architecture:.*$/Architecture: ${_PACKAGE_ARCHITECTURE}/g" package/DEBIAN/control

chmod 644 package/DEBIAN/conffiles
chmod 755 package/DEBIAN/postinst
chmod 755 package/DEBIAN/postrm
chmod 755 package/DEBIAN/preinst
chmod 755 package/DEBIAN/prerm
chmod 755 package/etc/
chmod 755 package/etc/default/
chmod 644 package/etc/default/mailhog
chmod 755 package/etc/init.d/
chmod 755 package/etc/init.d/mailhog
chmod 755 package/etc/init.d/mailhog
chmod 755 package/usr/
chmod 755 package/usr/sbin/mailhog
chmod 755 package/usr/share/
chmod 755 package/usr/share/doc/
chmod 755 package/usr/share/doc/mailhog/
chmod 644 package/usr/share/doc/mailhog/changelog.Debian.gz
chmod 644 package/usr/share/doc/mailhog/copyright
chmod 755 package/usr/share/lintian/
chmod 755 package/usr/share/lintian/overrides/
chmod 644 package/usr/share/lintian/overrides/mailhog
chmod 755 package/usr/share/man/
chmod 755 package/usr/share/man/man8/
chmod 644 package/usr/share/man/man8/mailhog.8.gz

fakeroot dpkg-deb --build package mailhog_${VERSION}-1.0_${_PACKAGE_ARCHITECTURE}.deb
