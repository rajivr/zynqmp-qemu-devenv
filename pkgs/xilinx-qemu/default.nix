{ stdenv
, fetchFromGitHub
, buildPackages
, bison
, curl
, flex
, glib
, gnutls
, libgcrypt
, lzo
, ncurses
, nettle
, perl
, pixman
, pkgconfig
, python3
, snappy
, texinfo
, vde2
, zlib
}:

stdenv.mkDerivation rec {
  pname = "xilinx-qemu";

  version = "2020.2";

  src = fetchFromGitHub {
    owner = "Xilinx";
    repo = "qemu";
    rev = "xilinx-v2020.2";
    sha256 = "0hqkid2g6rnyqparbnjpjjhrpfjp3lxjid0samcys6frdnarkmbx";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    (buildPackages.python3.withPackages (p: [ p.libfdt ]))
    bison
    flex
    pkgconfig
    python3
  ];

  buildInputs =
    [
      curl
      glib
      gnutls
      libgcrypt
      lzo
      ncurses
      nettle
      perl
      pixman
      snappy
      texinfo
      vde2
      zlib
    ];

  patches = [
    ./no-etc-install.patch
  ];

  preConfigure = ''
    unset CPP # intereferes with dependency calculation
  '';

  configureFlags =
    [
      "--sysconfdir=/etc"
      "--localstatedir=/var"
      "--target-list=aarch64-softmmu,microblazeel-softmmu"
      "--enable-fdt"
      "--disable-kvm"
      "--disable-xen"
      "--enable-gcrypt"
    ];

  doCheck = false; # tries to access /dev

  meta = with stdenv.lib; {
    homepage = http://www.qemu.org/;
    description = "A generic and open source machine emulator and virtualizer";
    license = licenses.gpl2Plus;
  };
}
