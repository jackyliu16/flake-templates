{
  description = "A template for Nix based project setup.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    # Add the system/architecture you would like to support here. Note that not
    # all packages in the official nixpkgs support all platforms.
    "x86_64-linux"  
  ] (system: let
    pkgs = import nixpkgs {
      inherit system;

      # Add overlays here if you need to override the nixpkgs
      # official packages.
      overlays = [];
      
      config.allowUnfree = false;
    };
  in {
    pkgs = pkgs;
    devShells.default = pkgs.mkShellNoCC rec { #[1] [2]
      name = "basic devShells";
      
      # a list of packages to add to the shell environment
      packages = with pkgs; [
        zellij
      ];

      shellHooks = ''
        echo -n "hello, basic environment!\n";
      '';
    };
  });
  # SpeedUp for CHINA user [0]
  # nixConfig.extra-experimental-features = "nix-command flakes";
  # nixConfig.extra-substituters = [
  #   "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  # ];
}
# [0]: [flake-format](https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-flake.html#flake-format)
# [1]: [pkgs.mkShell](https://nixos.org/manual/nixpkgs/stable/#sec-pkgs-mkShell)
# [2]: [other param like buildInputs](https://nixos.org/manual/nixpkgs/stable/#ssec-stdenv-dependencies)
