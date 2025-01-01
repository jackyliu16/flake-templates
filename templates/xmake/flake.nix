{
  inputs = {
    super = {
      url = "path:../basic/";
      flake = true;
    };
  };

  outputs = {self, super}@inputs: super.inputs.utils.lib.eachSystem [
    "x86_64-linux"
  ] (system: let 
    pkgs = super.outputs.pkgs.${system}; 
    oldShell = super.outputs.devShells.${system}.default;
  in {
    devShells.default = pkgs.mkShellNoCC rec {
      name = "C basic devShells";

      nativeBuildInputs = oldShell.nativeBuildInputs; # [3]

      packages = with pkgs; [
        gdb
      ];

      buildInputs = with pkgs; [
        gcc
        xmake
      ];

      shellHook = ''
      	# Unset environment variables, required for xmake to find
				# the linker/compiler that we provide here [4]
				unset CC
				unset CXX
				unset LD
				unset AR
				unset AS
				unset RANLIB
				unset STRIP
				unset CFLAGS
				unset CXXFLAGS
				unset LDFLAGS
				echo "C++ development environment loaded"
      '';
    };
  });
}

# [3]: [original packages has been merge into others](https://github.com/hsjobeki/nixpkgs/blob/96a1ff01e43aee606027916d302f6ad82621806b/pkgs/build-support/mkshell/default.nix#L17-L34)
# [4]: [unset env var for xmake](https://github.com/tiltedphoques/TiltedEvolution/blob/869d34f95df18458d56fa2eb87a99f70ed93e9cc/flake.nix#L28-L40)
