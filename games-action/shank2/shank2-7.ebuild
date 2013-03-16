# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5
inherit games

SRC_URI="${PN}-linux-update${PV}.tgz"
HOMEPAGE="http://www.shankgame.com/"
DESCRIPTION="A sequel to a 2D side-scrolling beat 'em up video game Shank"
LICENSE="EULA"
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
"

pkg_nofetch(){
einfo ""
einfo "Please buy Humble Bundle with Shank2 included and place the downloaded file"
einfo "in /usr/portage/distfiles"
einfo ""
}
S=${WORKDIR}
GAMEDIR=${GAMES_PREFIX_OPT}/${PN}

src_install(){
	insinto "${GAMEDIR}"

	#install content
	doins -r data
	doins -r data-pc
	newicon Shank2.xpm ${PN}.xpm
	newdoc release_notes.txt README

	dodir bin
	exeinto "${GAMEDIR}/bin"
	insinto "${GAMEDIR}/bin"
	if use amd64
	then
		POSTFIX="64"
	fi
	if use x86
	then
		POSTFIX="32"
	fi

	#install exe files
	newexe "bin/${PN}-bin${POSTFIX}" ${PN}
	doins -r "bin/lib${POSTFIX}"
	games_make_wrapper "${PN}" "./${PN}" "${GAMEDIR}/bin"
	make_desktop_entry ${PN} "Shank 2"
	prepgamesdirs
}
