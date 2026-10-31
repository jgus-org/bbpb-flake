# bbpb-flake

A Nix flake that provides [bbpb](https://pypi.org/project/bbpb/), the `blackboxprotobuf` library for working with protobuf messages without a protobuf type definition, built from the project's PyPI source distribution.

## Outputs

- `packages.<system>.bbpb` — the bbpb package. The importable module is `blackboxprotobuf`; `bin/bbpb` is the command-line decoder the sdist declares and `meta.mainProgram` is `bbpb`.
- `packages.<system>.default` — the same derivation.
- `packages.<system>.update-version`, `packages.<system>.update-branches` — maintenance outputs that move the pin. Neither is needed to consume the flake.
- `checks.<system>.formatting`, `formatter` — this repository's own files.

There are no overlays, `nixosModules`, devShells or apps: nothing here installs a service.

## Consuming

```nix
# flake inputs
inputs.bbpb = {
  url = "github:jgus-org/bbpb-flake";
  inputs.nixpkgs.follows = "nixpkgs";
};

# then, as a member of a python environment
inputs.bbpb.packages.${system}.bbpb
```

Following `nixpkgs` is what makes the package usable next to other python code: the derivation is built against that nixpkgs' default CPython, so sharing the nixpkgs puts bbpb in the same interpreter's package set. Upstream declares `requires-python >= 3.8, < 4.0`. A consumer that follows a nixpkgs whose default `python3` is outside that range is on its own to reconcile.

## Build hosts

`aarch64-darwin`, `aarch64-linux` and `x86_64-linux`, which are flake-lib's default build hosts. bbpb is pure Python and its one runtime dependency is nixpkgs' own `six`, so there is nothing compiled in this closure that nixpkgs does not already build.

## What you get

**The version upstream releases, unpatched.** The pin tracks PyPI and the recipe applies no patches. 1.4.2, released 2025-03-14, is the newest release on PyPI.

**A library and its CLI from one derivation.** The module and the `bbpb` command come from the same output, which is how upstream ships them.

**No vendored protobuf.** bbpb decodes the wire format itself against `six` alone; it does not depend on Google's protobuf library, so nothing here needs generated message classes.

See [LICENSE.md](LICENSE.md) for licensing and copyright, and [NOTICE.md](NOTICE.md) for the terms of upstream and distributed artifacts.
