# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5
inherit games check-reqs unpacker eutils

HOMEPAGE="http://oilrush-game.com/"
DESCRIPTION="A naval strategy game by Unigine Corp"
RESTRICT="fetch strip"
LICENSE="all-rigts-reserved"
TIMESTAMP="1370041755"
IUSE="bundled-libs"
SLOT="0"
KEYWORDS="~amd64 ~x86"
SRC_URI="OilRush_${PV}_Linux_${TIMESTAMP}.run"
RDEPEND="virtual/opengl
media-libs/freetype
media-libs/fontconfig
x11-libs/libXext
x11-libs/libX11
x11-libs/libXrender
dev-libs/expat
sys-libs/zlib
x11-libs/libXau
x11-libs/libXdmcp
x11-libs/libxcb
app-arch/bzip2
!bundled-libs? ( media-libs/openal )
"



CHECKREQS_DISK_BUILD="1330M"

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

S=${WORKDIR}
GAMEDIR=${GAMES_PREFIX_OPT}/${PN}

src_unpack(){
	unpack_makeself
}

src_prepare(){
	local NOTMYARCH=$(usex amd64 "x86 x64")
	if ! use bundled-libs ; then
		einfo "Removing bundled OpenAL..."
		rm -v bin/libopenal.so*
	fi

	rm bin/*${NOTMYARCH}*
}


src_install(){
	insinto ${GAMEDIR}
	exeinto ${GAMEDIR}
	dodoc documentation/user_manual.pdf
	doicon data/launcher/${PN}.png
	doexe launcher.sh
	doins -r data bin
	doins ${PN}.cfg

	make_desktop_entry ${PN} "Oil Rush"
	games_make_wrapper ${PN} "./launcher.sh" ${GAMEDIR}

	local myarch=$(usex amd64 "x64" "x86")
	fperms +x ${GAMEDIR}/bin/launcher_${myarch}
	fperms +x ${GAMEDIR}/bin/OilRush_${myarch}

	prepgamesdirs
}
