let
    version = "2.3.1";
    hash    = "sha256-khROLesf8mBtKTQ8/qID6okFSa0vd8A98c6i2AFJcss=";
in
{
    naturaldocs = {
        url = "https://naturaldocs.org/download/natural_docs/${version}/Natural_Docs_${version}.zip";
        inherit version hash;
    };
}