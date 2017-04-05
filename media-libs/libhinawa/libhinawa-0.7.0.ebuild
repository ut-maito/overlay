# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="I/O library of IEEE 1394 asynchronous transactions to/from units on the bus, with GObject Introspection. "
HOMEPAGE="https://github.com/takaswie/libhinawa"

SRC_URI="https://github.com/takaswie/libhinawa/archive/0.7.0.tar.gz"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
IUSE=""
SLOT="0"

DEPEND="dev-util/gtk-doc"
RDEPEND=""

RESTRICT=mirror""


S="${WORKDIR}/${P}/"


src_prepare() {
	default
	./autogen.sh
	# autoreconf --install
}

src_configure(){
	default
}

src_compile() {
	emake -j1 all
}

src_install() {
	emake DESTDIR="${D}" install
}
