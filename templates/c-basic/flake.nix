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
    devShells.default = pkgs.mkShell rec {
      name = "C basic devShells";

      nativeBuildInputs = oldShell.nativeBuildInputs; # [3]

      shellHook = ''
        echo -n "Hello, C environment";
      '';
    };
  });
}

# [3]: [original packages has been merge into others](https://github.com/hsjobeki/nixpkgs/blob/96a1ff01e43aee606027916d302f6ad82621806b/pkgs/build-support/mkshell/default.nix#L17-L34)
