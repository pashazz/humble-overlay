# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

inherit games versionator eutils unpacker


HOMEPAGE="http://www.englishcountrytune.com/"
MY_PN="English Country Tune"
SLOT="0"
SRC_URI="EnglishCountryTune_Linux_${PV}.tar.gz"
IUSE=""
LICENSE="all-rights-reserved"
RESTRICT="fetch strip"
KEYWORDS="-* ~amd64 ~x86"
DEPEND=""
RDEPEND="virtual/opengl
virtual/glu
x11-libs/libX11
x11-libs/libXext
x11-libs/libXcursor
x11-libs/libxcb
x11-libs/libXrender
x11-libs/libXfixes
x11-libs/libXau
x11-libs/libXdmcp"


S="${WORKDIR}/${MY_PN}"

GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
pkg_nofetch(){
einfo ""
einfo "Please buy ${MY_PN} at ${HOMEPAGE}"
einfo "and place the downloaded file into /usr/portage/distfiles"
einfo ""
}

QA_WX_LOAD="${GAMEDIR}/${MY_PN}_Data/Mono/$(arch)/libmono.so"
src_install(){

doicon ${FILESDIR}/${PN}.png
exeinto ${GAMEDIR}
newexe "${MY_PN}.$(arch)" ${PN}

insinto "${GAMEDIR}/${PN}_Data"
dodir "${GAMEDIR}/${PN}_Data"
cd "${MY_PN}_Data"
doins -r Managed Resources
doins level* mainData *.assets*
insinto "${GAMEDIR}/${PN}_Data/Mono"
doins -r Mono/$(arch)

games_make_wrapper ${PN} ./${PN} ${GAMEDIR}
make_desktop_entry ${PN} "${MY_PN}"

prepgamesdirs
}
