# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils kde

DESCRIPTION="KNetworkManager is the KDE front end for NetworkManager."
HOMEPAGE="http://en.opensuse.org/Projects/KNetworkManager"
LICENSE="GPL-2"

SRC_URI="http://nouse.net/projects/KNetworkManager/0.1/${PN}-${PV}.tar.bz2
	http://sabayonlinux.org/distfiles/net-misc/patches/policy-fix.patch
	"

SLOT="2"
KEYWORDS="~x86 ~amd64"

IUSE="arts"
DEPENT="
        >=net-misc/networkmanager-0.6.2
        "
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}	
	S=${WORKDIR}/
	cd ${S}

	EPATCH_SOURCE="${DISTDIR}" EPATCH_SUFFIX="patch" \
        EPATCH_FORCE="yes" epatch

}

src_compile() {
	
	eautoreconf
	
        myconf="${myconf}
                $(use_with arts)
		--prefix=`kde-config --prefix`
		"
	
        kde_src_compile
}

src_install() {
		
        make || die "Make failed"
        emake DESTDIR=${D} install || die "Make Install failed"
        dodoc README NEWS TODO AUTHORS

}
