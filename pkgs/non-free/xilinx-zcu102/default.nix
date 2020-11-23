{ requireFile
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "xilinx-zcu102";

  version = "2020.1";

  src = requireFile rec {
    name = "xilinx-zcu102-v2020.1-final.tar.gz";
    url = "https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html";
    hashMode = "flat";
    sha256 = "1w00s0csrhw1iq9b0rzcclxvigj21v22f8izjiz4vhqy8avc6i90";
    message = ''
      Unfortunately, we cannot download ${name} automatically.

      Please go to

      ${url}

      to download

      xilinx-zcu102-v2020.1-final.bsp

      Then add it to the Nix store by running the following commands.

      mv xilinx-zcu102-v2020.1-final.bsp xilinx-zcu102-v2020.1-final.tar.gz
      nix-store --add-fixed sha256 xilinx-zcu102-v2020.1-final.tar.gz
      rm -f xilinx-zcu102-v2020.1-final.tar.gz
    '';
  };

  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    mkdir -p $out/share/${pname}

    cp pre-built/linux/images/bl31.elf $out/share/${pname}
    cp pre-built/linux/images/pmu_rom_qemu_sha3.elf $out/share/${pname}
    cp pre-built/linux/images/pmufw.elf $out/share/${pname}
    cp pre-built/linux/images/system.dtb $out/share/${pname}
    cp pre-built/linux/images/u-boot.elf $out/share/${pname}
    cp pre-built/linux/images/zynqmp-qemu-multiarch-arm.dtb $out/share/${pname}
    cp pre-built/linux/images/zynqmp-qemu-multiarch-pmu.dtb $out/share/${pname}
  '';

  outputHashAlgo = "sha256";
  outputHashMode = "recursive";
  outputHash = "00sbn4n8zl1axhzh3844hg74rbp313rf6hl3mbiwx77jvip3yjzg";

  meta = with stdenv.lib; {
    description = "Xilinx QEMU prebuilt binary blobs";
    homepage = "https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html";
    license = licenses.unfree;
  };
}
