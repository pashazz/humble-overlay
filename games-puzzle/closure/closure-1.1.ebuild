EAPI=5
inherit games unpacker-nixstaller
MY_PN="Closure"
DESCRIPTION="Lights manipulation side-scrolling arcade game"
IUSE=""
SLOT="0"
REVISION="2012-12-18"
LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/xz-utils"
RDEPEND="media-libs/libsdl:0
		 media-libs/alsa-lib
		 media-libs/openal
		 x11-libs/libX11
		 x11-libs/libXext
		 x11-libs/libxcb
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 media-libs/freealut
		 sys-libs/ncurses
		 sys-libs/gpm
		 media-libs/aalib
		 amd64? ( media-gfx/nvidia-cg-toolkit[multilib] )
		 x86? ( media-gfx/nvidia-cg-toolkit )"
HOMEPAGE="http://closuregame.com/"

GAMEDIR=${GAMES_PREFIX_OPT}/${PN}
RESTRICT="fetch strip bindist"
SRC_URI="${MY_PN}-Linux-${PV}-${REVISION}.sh"

if use x86
then
	GAMEBIN="${MY_PN}.bin.x86"
fi

if use amd64
then
	GAMEBIN="${MY_PN}.bin.x86_64"
fi

QA_PREBUILT=$GAMEBIN
QA_WX_LOAD="${GAMEDIR}/resources/shaders/*.cgelf"

S=${WORKDIR}

pkg_nofetch(){
	einfo ""
	einfo "Please buy Humble Bundle with Closure included and place the downloaded file"
	einfo " ${A}"
	einfo "in ${DISTDIR}"
	einfo ""
}

src_unpack(){
	if use x86
	then
		nixstaller_unpack instarchive_linux_x86 instarchive_all
	fi

	if use amd64
	then
		nixstaller_unpack instarchive_linux_x86_64 instarchive_all
	fi

}

src_install(){
	insinto ${GAMEDIR}
	doins -r resources

	exeinto ${GAMEDIR}
	newexe ${GAMEBIN} ${PN}

	dodoc README.linux
	newicon "${MY_PN}.png" "${PN}.png"
	games_make_wrapper "${PN}" "./${PN}" "${GAMEDIR}"
	make_desktop_entry "${PN}" "${MY_PN}"
	prepgamesdirs
}
