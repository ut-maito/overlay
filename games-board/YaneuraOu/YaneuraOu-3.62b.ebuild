# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs
inherit git-r3

DESCRIPTION="OpenSorce USI Japanese chess engine, claimed to be the future engine"
HOMEPAGE="http://yaneuraou.yaneu.com/"

EGIT_REPO_URI="https://github.com/yaneurao/${PN}.git"
LICENSE="GPL-3"
SLOT="2016-Mid"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_avx2 cpu_flags_x86_sse cpu_flags_x86_sse4_2 \
	cpu_flags_x86_sse4_1 cpu_flags_x86_sse2 general-64 general-32"

DEPEND="|| ( app-arch/unzip	app-arch/zip )"
RDEPEND=""

RESTRICT=mirror""

S="${WORKDIR}/${P}/source/"


src_prepare() {
	default

	if [ "${PV}" = "3.62b" ];then
		git reset --hard 7c48fce2dd30ed909a1114c014d0f6ecc2ac6102 ||die
	fi
}

src_compile() {
	local my_arch

	use general-32 && my_arch=nosse
	use general-64 && my_arch=nosse
	use cpu_flags_x86_sse4_2 && my_arch=sse2
	use cpu_flags_x86_sse4_1 && my_arch=sse41
	use cpu_flags_x86_sse4_2 && my_arch=sse42
	use cpu_flags_x86_avx2 && my_arch=avx2
	emake ${my_arch} ARCH="${my_arch}" \
		COMP=$(tc-getCXX) \
		COMPILER=$(tc-getCXX)
}

src_install() {
	dobin "${PN}-by-gcc"
}
