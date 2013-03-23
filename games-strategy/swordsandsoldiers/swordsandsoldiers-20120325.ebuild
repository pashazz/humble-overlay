# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5
inherit games eutils
HOMEPAGE="http://www.swordsandsoldiers.com/"
DESCRIPTION="Side-scrolling strategy featuring Aztecs, Chineses and Vikings"
LICENSE="all-rights-reserved"
RESTRICT="fetch strip"
IUSE=""
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="bindist fetch strip"

SRC_URI="x86? ( ${P}-i386.tar.gz )
		 amd64? ( ${P}-amd64.tar.gz )"

S=${WORKDIR}/${PN}
RDEPEND="virtual/opengl
		 media-libs/libsdl:0
		 virtual/glu
		 media-libs/freetype
		 sys-libs/zlib
		 x11-libs/libX11
		 x11-libs/libXext
		 x11-libs/libXft
		 x11-libs/libXinerama
		 media-libs/fontconfig
		 media-libs/libogg
		 media-libs/libvorbis
		 media-libs/openal
		 x11-libs/libxcb
		 x11-libs/libXrender
		 app-arch/bzip2
		 dev-libs/expat
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 x11-libs/libXpm
"
DEPEND=""
pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
MY_PN="SwordsAndSoldiers"
src_install(){
	insinto ${GAMEDIR}
	doins -r Data
	exeinto ${GAMEDIR}
	doexe ${MY_PN}.bin
	doexe ${MY_PN}Setup.bin

	newicon ${MY_PN}.png ${PN}.png
	newicon ${MY_PN}Setup.png ${PN}setup.png

	games_make_wrapper ${PN} ./${MY_PN}.bin ${GAMEDIR}
	games_make_wrapper ${PN}setup ./${MY_PN}Setup.bin ${GAMEDIR}

	make_desktop_entry ${PN} "Swords & Soldiers"
	make_desktop_entry ${PN}setup "Swords & Soldiers Setup" ${PN}setup

	dodoc README
	dodoc README.linux
}
