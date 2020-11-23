{
  description = "Xilinx ZynqMP Development Environment";

  inputs.nixpkgs.url = "nixpkgs/nixos-20.09";

  outputs = { self, nixpkgs }: {
    devShell.x86_64-linux =
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";

          config.allowUnfree = true;
        };

        xilinx-qemu = pkgs.callPackage ./pkgs/xilinx-qemu { };

        xilinx-zcu102 = pkgs.callPackage ./pkgs/non-free/xilinx-zcu102 { };
      in
      with pkgs;
      mkShell {
        buildInputs = [
          xilinx-qemu
          xilinx-zcu102
        ];

        XILINX_ZCU102_BINARY_BLOB_PATH="${xilinx-zcu102}/share/xilinx-zcu102";
      };
  };
}
