# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5
inherit games eutils
DESCRIPTION="Gratuitous Space Battles - space battle simulation strategy"
HOMEPAGE="http://www.positech.co.uk/gratuitousspacebattles/index.html"
LICENSE="all-rights-reserved"
IUSE=""
RESTRICT="fetch strip"
SRC_URI="gsb1324679796.tar.gz"
KEYWORDS="x86 amd64"
SLOT="0"

RDEPEND="virtual/opengl
		 media-libs/libogg
		 media-libs/libsdl:0
		 media-libs/openal
		 media-libs/libpng:1.2
		 media-libs/libvorbis
		 x11-libs/libX11
		 x11-libs/libXext
		 x11-libs/libXft
		 media-libs/fontconfig
		 sys-libs/zlib
		 x11-libs/libxcb
		 x11-libs/libXrender
		 media-libs/aalib
		 media-libs/alsa-lib
		 dev-libs/expat
		 media-libs/freetype
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 sys-libs/ncurses
		 sys-libs/gpm"


DEPEND=""

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
	einfo
}

GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
S=${WORKDIR}/${PN}
src_prepare(){

	#unbundling some stuff
	if use x86
	then
		SUFFIX=""
		rm -rf lib64
		rm ${PN}.bin.x86_64
	fi
	if use amd64
	then
		SUFFIX="64"
		rm -rf lib
		rm ${PN}.bin.x86
	fi

	rm lib${SUFFIX}/libopenal.so.1
	rm lib${SUFFIX}/libpng12.so.0
	rm lib${SUFFIX}/libSDL-1.2.so.0
	rm lib${SUFFIX}/libvorbisfile.so.3
	rm lib${SUFFIX}/libvorbis.so.0

	#can't unbundle libsdl_image: game crashes for me with system-wide
	#can't unbundle libcurl: too old
	#can't unbundle libjpeg: too old
}

src_install(){
	WRAPPER_NAME="gsb"
	insinto ${GAMEDIR}
	doins -r data

	exeinto ${GAMEDIR}
	if use x86
	then
		newexe ${PN}.bin.x86 ${PN}
		doins -r lib
	fi

	if use amd64
	then
		newexe ${PN}.bin.x86_64 ${PN}
		doins -r lib64
	fi

	doicon ${PN}.png
	games_make_wrapper ${WRAPPER_NAME} ./${PN} ${GAMEDIR}
	make_desktop_entry ${WRAPPER_NAME} "Gratuitous Space Battles"

	dodoc README.linux
	dodoc ${PN}Manual.pdf
}

pkg_postinst(){
	games_pkg_postinst

	einfo ""
	einfo "Run '${WRAPPER_NAME}' to play!"
	einfo ""
}
