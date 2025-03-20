{ inputs, sources }:

final: prev:
{
    naturaldocs = final.callPackage ../naturaldocs.nix {
        inherit (final.stdenvNoCC) mkDerivation;
        inherit sources;
    };
}