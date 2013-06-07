# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

inherit games versionator eutils unpacker

HOMEPAGE="http://store.steampowered.com/app/115100/"
DESCRIPTION="Halloween adventure from Double Fine Productions"
LICENSE="all-rights-reserved"
MY_PN="CostumeQuest"
MY_PV="$(replace_all_version_separators -)"

SRC_URI="${MY_PN}-Linux-${MY_PV}-setup.bin"
SLOT="0"
RESTRICT="fetch strip"
IUSE="bundled-libs"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND="virtual/opengl
!bundled-libs? ( amd64? ( media-libs/libsdl:2[abi_x86_32] )
x86? ( media-libs/libsdl:2 )
)
"
src_unpack() {
unpack_zip ${A}
}

pkg_nofetch() {
einfo ""
einfo "Please buy the game from http://doublefine.com/"
einfo "and downlad it into /usr/portage/distfiles"
einfo ""
}

GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
S=${WORKDIR}/data
src_install() {
insinto ${GAMEDIR}
exeinto ${GAMEDIR}
doins -r Data
doins -r Linux
doins -r OGL
doins -r Win
doins DFCONFIG
doexe Cq.bin.x86
newicon ${MY_PN}.png ${PN}.png

dodir lib
insinto ${GAMEDIR}/lib
cd lib
doins libfmodevent-4.42.16.so  libfmodeventnet-4.42.16.so  libfmodex-4.42.16.so

if use bundled-libs ; then
doins libSDL2-2.0.so.0
fi

games_make_wrapper ${PN} ./Cq.bin.x86 ${GAMEDIR}
make_desktop_entry ${PN} "Costume Quest"
prepgamesdirs

}
