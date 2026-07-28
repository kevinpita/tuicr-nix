# tuicr-nix

Always up-to-date Nix package for [tuicr](https://tuicr.dev), a code review TUI with vim keybindings.

## Quick Start

```bash
nix run github:kevinpita/tuicr-nix
```

## Install

```bash
nix profile install github:kevinpita/tuicr-nix
```

## Use In A Flake

```nix
{
  inputs.tuicr-nix.url = "github:kevinpita/tuicr-nix";

  outputs = { tuicr-nix, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          tuicr-nix.packages.${system}.default
        ];
      };
    };
}
```

## Development

```bash
nix build .#tuicr
./result/bin/tuicr --version
```

## Updates

The update workflow checks upstream releases hourly and can also be run manually from GitHub Actions. When a new release exists, it updates `package.nix`, refreshes the fixed-output hashes, creates a pull request, and enables auto-merge.

Manual update:

```bash
./scripts/update.sh --check
./scripts/update.sh --version 0.19.1
```
