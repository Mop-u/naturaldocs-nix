{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        systems.url = "github:nix-systems/x86_64-linux";
        
        flake-utils.url = "github:numtide/flake-utils";
        flake-utils.inputs.systems.follows = "systems";
    };

    outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system: 
    let 
        pkgs = nixpkgs.legacyPackages.${system};
        version = "2.3";
    in { 
        packages.naturaldocs = pkgs.stdenvNoCC.mkDerivation {
            name = "naturaldocs";
            version = version;
            dontConfigure = true;

            src = pkgs.fetchurl {
                url = "https://naturaldocs.org/download/natural_docs/${version}/Natural_Docs_${version}.zip";
                hash = "sha256-N9z+qgruKjYirchYgu2s+5EcLnE9umWSy+5oEt7d0vI=";
            };

            nativeBuildInputs = with pkgs; [ unzip ];

            buildInputs = with pkgs; [ mono bash ];

            installPhase = ''
                mkdir -p "$out/NaturalDocs"
                cp -r ./* "$out/NaturalDocs/"
                mkdir -p $out/bin
                touch $out/bin/NaturalDocs
                echo "#! ${pkgs.bash}/bin/bash" >> "$out/bin/NaturalDocs"
                echo "exec ${pkgs.mono}/bin/mono $out/NaturalDocs/NaturalDocs.exe \$@" >> "$out/bin/NaturalDocs"
                chmod +x "$out/bin/NaturalDocs"
            '';

            system = builtins.currentSystem;

            meta = {
                homepage = "https://www.naturaldocs.org";
                description = "Natural Docs source code documentation system";
            };
        };
    });
}