{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    system.url = github:nix-systems/default-linux;
    flake-utils = {
      url = github:numtide/flake-utils;
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
          packages = {
            default = pkgs.linuxKernel.packages.linux_latest_libre.rtl8812au.override {
              src = self;
            };
          };
        });
}
