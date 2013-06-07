# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

inherit games check-reqs versionator eutils unpacker

HOMEPAGE="http://www.awesomenauts.com/"
DESCRIPTION="2D MOBA - war between robot armies"
LICENSE="all-rights-reserved"
MY_PN="Awesomenauts"
MY_PV="$(replace_all_version_separators -)"

DEPEND="app-arch/unzip"
SLOT="0"
SRC_URI="${MY_PN}-Linux-${MY_PV}.bin"
RESTRICT="fetch strip"
IUSE=""

KEYWORDS="~amd64 ~x86"
RDEPEND="virtual/opengl
x86? ( media-libs/glu
media-gfx/nvidia-cg-toolkit
media-libs/libsdl
media-libs/libtheora
x11-libs/libX11
media-libs/libogg
media-libs/libvorbis
media-libs/openal
media-libs/freetype
x11-libs/libXext
x11-libs/libxcb
x11-libs/libICE
x11-libs/libSM
sys-libs/zlib
media-libs/alsa-lib
media-sound/pulseaudio
sys-libs/zlib
app-arch/bzip2
dev-libs/json-c
x11-libs/libXtst
media-libs/libsndfile
media-libs/flac
x11-libs/libXau
x11-libs/libXdmcp
 )

amd64? ( app-emulation/emul-linux-x86-opengl
media-libs/libsdl[abi_x86_32]
media-gfx/nvidia-cg-toolkit[multilib]
media-libs/freetype[abi_x86_32]
app-emulation/emul-linux-x86-medialibs
x11-libs/libX11[abi_x86_32]
app-emulation/emul-linux-x86-soundlibs
app-emulation/emul-linux-x86-sdl
x11-libs/libXext[abi_x86_32]
app-emulation/emul-linux-x86-baselibs
x11-libs/libxcb[abi_x86_32]
x11-libs/libICE[abi_x86_32]
x11-libs/libSM[abi_x86_32]
x11-libs/libXtst[abi_x86_32]
x11-libs/libXau[abi_x86_32]
x11-libs/libXdmcp[abi_x86_32] )"


src_unpack() {
unpack_zip ${A}
}


S=${WORKDIR}/data
QA_PREBUILT="${GAMEDIR}/*bin*"

CHECKREQS_DISK_BUILD="815M"
GAMEDIR=${GAMES_PREFIX_OPT}/${PN}

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}


src_install(){
newicon ${MY_PN}Icon.png ${PN}.png
#newicon Settings.png ${PN}-settings.png
insinto ${GAMEDIR}
exeinto ${GAMEDIR}
doexe ${MY_PN}.bin.x86
doexe Settings.bin.x86
mv -v Data "${D}${GAMEDIR}" || die #815M

games_make_wrapper "${PN}" ./${MY_PN}.bin.x86 ${GAMEDIR}
games_make_wrapper ${PN}-settings ./Settings.bin.x86 ${GAMEDIR}

make_desktop_entry ${PN} "Awesomenauts"
make_desktop_entry ${PN}-settings "Awesomenauts Setup"

prepgamesdirs


}
