{ mkDerivation
, sources
, fetchurl
, bash
, mono
, unzip
}:

mkDerivation {
    name = "naturaldocs";
    version = sources.naturaldocs.version;
    dontConfigure = true;

    src = fetchurl sources.naturaldocs;

    nativeBuildInputs = [ unzip ];

    buildInputs = [ mono bash ];

    installPhase = ''
        mkdir -p "$out/NaturalDocs"
        cp -r ./* "$out/NaturalDocs/"
        mkdir -p $out/bin
        touch $out/bin/NaturalDocs
        echo "#! ${bash}/bin/bash" >> "$out/bin/NaturalDocs"
        echo "exec ${mono}/bin/mono $out/NaturalDocs/NaturalDocs.exe \$@" >> "$out/bin/NaturalDocs"
        chmod +x "$out/bin/NaturalDocs"
    '';

    system = builtins.currentSystem;

    meta = {
        homepage = "https://www.naturaldocs.org";
        description = "Natural Docs source code documentation system";
    };
}