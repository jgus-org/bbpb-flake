{
  description = "bbpb: Python library for working with protobuf messages without a protobuf type definition";

  inputs = {
    # Unfollowed on purpose: flake-lib resolves the org formatter from its own nixpkgs pin.
    flake-lib.url = "github:jgus-org/flake-lib/v1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      flake-lib,
      nixpkgs,
    }:
    flake-lib.lib.mkPythonFlake {
      inherit
        nixpkgs
        self
        ;
      package = {
        attr = "bbpb";
        buildSystem = p: [ p.poetry-core ];
        dependencies = p: [ p.six ];
        description = "Library for working with protobuf messages without a protobuf type definition.";
        extra.pythonImportsCheck = [ "blackboxprotobuf" ];
        meta = {
          homepage = "https://github.com/nccgroup/blackboxprotobuf";
          license = nixpkgs.lib.licenses.mit;
          mainProgram = "bbpb";
        };
      };
      pin = import ./pin.nix;
      source = {
        format = "sdist";
        pname = "bbpb";
        type = "pypi";
      };
    };
}
