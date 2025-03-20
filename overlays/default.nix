{ inputs, sources }:

let
    initialPackages = _final: prev: {
        naturaldocs = { };
    };

    overlays = {
        naturaldocs = import ./naturaldocs-addons.nix {
            inherit inputs sources;
        };
    };

    composeExtensions = f: g: final: prev:
        let
            applied = f final prev;
            prev'   = prev // applied;
        in
            applied // g final prev';

    composeManyExtensions = builtins.foldl' composeExtensions (_: _: {});

    default = composeManyExtensions (with overlays; [
        initialPackages
        naturaldocs
    ]);
in
    overlays // { inherit default; }