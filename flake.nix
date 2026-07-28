{
  description = "Nix flake for tuicr, a code review TUI with vim keybindings";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      overlay = final: _prev: {
        tuicr = final.callPackage ./package.nix { };
      };
    in
    flake-utils.lib.eachSystem systems
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
        in
        {
          packages = {
            default = pkgs.tuicr;
            tuicr = pkgs.tuicr;
          };

          apps = {
            default = {
              type = "app";
              program = "${pkgs.tuicr}/bin/tuicr";
            };
            tuicr = {
              type = "app";
              program = "${pkgs.tuicr}/bin/tuicr";
            };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              gh
              jq
              nixpkgs-fmt
            ];
          };
        }
      )
    // {
      overlays.default = overlay;
    };
}
