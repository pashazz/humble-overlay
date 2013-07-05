# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

inherit games

DESCRIPTION="A minimalist game about friendship and jumping."
HOMEPAGE="http://www.thomaswasalone.com/"
HUMAN_PN="Thomas Was Alone"
PROG_PN="thomasWasAlone"
SLOT="0"
SRC_URI="${PN}-linux-${PV}.tar"
IUSE=""
LICENSE="all-rights-reserved"
RESTRICT="fetch strip"
KEYWORDS="-* ~amd64 ~x86"
DEPEND=""
RDEPEND="
	x86? (
		media-libs/glu
		media-libs/mesa
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
	)
	amd64? (
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-xlibs
	)
"

S="${WORKDIR}/thomasLinuxStandalone"
GAMEDIR="${GAMES_PREFIX_OPT}/${PN}"

QA_PREBUILT="
	${GAMEDIR}/${PROG_PN}
	${GAMEDIR}/${PROG_PN}_Data/Mono/x86/libmono.so
"

pkg_nofetch() {
	einfo ""
	einfo "Please buy ${HUMAN_PN} at ${HOMEPAGE}"
	einfo "and place the downloaded file into /usr/portage/distfiles"
	einfo ""
}

src_install() {
	exeinto "${GAMEDIR}"
	insinto "${GAMEDIR}"

	doicon "${FILESDIR}/${PN}.png"
	doexe "${PROG_PN}"
	doins -r "${PROG_PN}_Data"

	# This seems to be extraneous.
	rm -rf "${D}${GAMEDIR}/${PROG_PN}_Data/Mono/etc"

	games_make_wrapper "${PN}" "${GAMEDIR}/${PROG_PN}"
	make_desktop_entry "${PN}" "${HUMAN_PN}"

	prepgamesdirs
}
