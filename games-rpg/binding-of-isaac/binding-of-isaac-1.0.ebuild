# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit games eutils

DESCRIPTION="Action RPG similar to the Legend of Zelda with randomized dungeons"
HOMEPAGE="http://www.bindingofisaac.com/"
SRC_URI="the_binding_of_isaac_wrath_of_the_lamb-linux.tar.gz"

LICENSE="Commercial"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="fetch strip"
MY_PN="isaac"

RDEPEND=">=dev-db/sqlite-3
	>=media-libs/libpng-1.5
	media-libs/alsa-lib
	>=x11-libs/gtk+-2[-aqua,introspection]
	dev-libs/expat
	media-libs/mesa
	x11-libs/cairo
	x11-libs/libXinerama
	x11-libs/pango[X]
		amd64? (
	app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-opengl
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs )"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Fetch ${SRC_URI} and put it into ${DISTDIR}"
	einfo "You can play a demo at http://www.newgrounds.com/portal/view/581168"
	einfo "Purchase the game from http://www.humblebundle.com/"
}



src_install() {
	exeinto "${GAMES_BINDIR}"
	newexe "Binding of Isaac/The Binding of Isaac + Wrath of the Lamb" ${MY_PN}
	doicon "${FILESDIR}/${MY_PN}.png"
	make_desktop_entry ${MY_PN} "The Binding of Isaac" ${MY_PN}
	prepgamesdirs
}
