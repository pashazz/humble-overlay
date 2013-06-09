# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

inherit games versionator eutils unpacker-nixstaller

HOMEPAGE="http://tomorrowcorporation.com/littleinferno"
DESCRIPTION="Sandbox oriented set-on-fire puzzle video game"
MY_PN="LittleInferno"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE="bundled-libs"
RESTRICT="fetch strip"
GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
SRC_URI="${MY_PN}-${PV}.sh"

S=${WORKDIR}
DEPEND=""
RDEPEND="virtual/opengl
x86? (
media-libs/openal
x11-libs/libX11
x11-libs/libXext
x11-libs/libXau
x11-libs/libXdmcp
x11-libs/libxcb
net-misc/curl
!bundled-libs? (
media-libs/libvorbis
media-libs/libogg )
)
amd64? (
app-emulation/emul-linux-x86-sdl
app-emulation/emul-linux-x86-baselibs
app-emulation/emul-linux-x86-opengl
app-emulation/emul-linux-x86-xlibs
!bundled-libs? ( app-emulation/emul-linux-x86-soundlibs )
)
"
pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_unpack(){
nixstaller_unpack instarchive_all instarchive_linux_all
}

src_install(){
insinto ${GAMEDIR}
if use bundled-libs ; then
	doins -r lib
fi

doins *.pak
doins -r shaders
exeinto ${GAMEDIR}
doexe ${MY_PN}.bin.x86
games_make_wrapper ${PN} "./${MY_PN}.bin.x86" ${GAMEDIR}
newicon ${MY_PN}.png ${PN}.png
make_desktop_entry ${PN} "Little Inferno"
prepgamesdirs
}
