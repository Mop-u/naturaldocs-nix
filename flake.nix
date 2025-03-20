{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    };

    outputs = { self, nixpkgs } @ inputs:
    let
        sources = import ./sources.nix;
    in
    {
        overlays = import ./overlays {
            inherit inputs sources;
        };

        overlay = self.overlays.default;
    };
}