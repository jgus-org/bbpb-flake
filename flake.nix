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
      inherit nixpkgs self;
      payload.packages =
        {
          buildPackage,
          pkgs,
          python,
          ...
        }:
        {
          bbpb = buildPackage {
            build-system = [ python.poetry-core ];
            dependencies = [ python.six ];
            meta = {
              description = "Library for working with protobuf messages without a protobuf type definition.";
              homepage = "https://github.com/nccgroup/blackboxprotobuf";
              license = pkgs.lib.licenses.mit;
              mainProgram = "bbpb";
            };
            pname = "bbpb";
            pyproject = true;
            pythonImportsCheck = [ "blackboxprotobuf" ];
          };
        };
      upstream = {
        format = "sdist";
        pin = import ./pin.nix;
        pname = "bbpb";
        type = "pypi";
      };
    };
}
