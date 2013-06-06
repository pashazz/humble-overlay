# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils games versionator
MY_PN="AirForte"
MY_PV="$(replace_version_separator 1 _ ${PV})"

SRC_URI="${PN}_v${MY_PV}.tar.gz"

LICENSE="all-rights-reserved"
DESCRIPTION="The high-altitude game of math, vocabulary, and geography"
HOMEPAGE="http://blendogames.com/airforte/"
RDEPEND="virtual/opengl
amd64? (
	app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-opengl
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs )
"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="fetch strip"

S="${WORKDIR}/${MY_PN}"

GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
QA_EXECSTACK="${GAMEDIR}/*.exe"
src_install(){
insinto ${GAMEDIR}
doins -r data/*
dodoc readme.htm

games_make_wrapper ${PN} ./${PN}linux ${GAMEDIR}
doicon ${FILESDIR}/${PN}.png
make_desktop_entry ${PN} "Air Forte"

fperms +x ${GAMEDIR}/*linux*
prepgamesdirs
}

pkg_postinst(){
	games_pkg_postinst

	einfo ""
	einfo "Run '${PN}' to play!"
	einfo ""
}
