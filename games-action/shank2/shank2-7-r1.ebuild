# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5
inherit games check-reqs

SRC_URI="${PN}-linux-update${PV}.tgz"
HOMEPAGE="http://www.shankgame.com/"
DESCRIPTION="A sequel to a 2D side-scrolling beat 'em up video game Shank"
LICENSE="all-rights-reserved"
RESTRICT="fetch strip"
IUSE=""
SLOT="0"
KEYWORDS="amd64 x86"
RDEPEND="virtual/opengl
		 media-libs/alsa-lib
		 x11-libs/libX11
		 x11-libs/libXext
		 dev-libs/libx86
		 x11-libs/libxcb
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 media-libs/libsdl
		 sys-libs/gpm
		 virtual/glu
		 x11-libs/libICE
		 x11-libs/libSM
		 sys-libs/ncurses
		 media-libs/aalib
"
CHECKREQS_DISK_BUILD="1800M"

pkg_nofetch(){
einfo ""
einfo "Please buy Humble Bundle with Shank2 included and place the downloaded file"
einfo "in /usr/portage/distfiles"
einfo ""
}

S=${WORKDIR}
GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${GAMEDIR}/bin/${PN}"


src_prepare(){
	rm bin/${PN}-bin || die

	if use x86
	then
		mv bin/${PN}-bin32 bin/${PN} || die
		BITS="32"
		rm -rf bin/lib64 || die
		rm bin/${PN}-bin64 || die

	fi
	if use amd64
	then
		mv bin/${PN}-bin64 bin/${PN} || die
		BITS="64"
		rm -rf bin/lib32 || die
		rm bin/${PN}-bin32 || die
	fi

	#remove bundled libraries
	rm bin/lib${BITS}/libdirect-1.2.so.9
	rm bin/lib${BITS}/libdirectfb-1.2.so.9
	rm bin/lib${BITS}/libfusion-1.2.so.9
	rm bin/lib${BITS}/libvga.so.1
	rm bin/lib${BITS}/libx86.so.1
	rm bin/lib${BITS}/libSDL-1.2.so.0

}

src_install(){
	insinto "${GAMEDIR}"

	#install content

	dodir "${GAMEDIR}"
	mv -v data data-pc "${D}${GAMEDIR}" || die # mv 1.8G files

	newicon Shank2.xpm ${PN}.xpm
	newdoc release_notes.txt README

	dodir bin
	exeinto "${GAMEDIR}/bin"
	insinto "${GAMEDIR}/bin"

	#install exe files
	doexe bin/${PN}
	doins -r bin/lib${BITS}

	games_make_wrapper "${PN}" "./${PN}" "${GAMEDIR}/bin"
	make_desktop_entry ${PN} "Shank 2"
	prepgamesdirs
}
