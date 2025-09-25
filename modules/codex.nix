{ stdenv
, fetchurl
, lib
,
}:
let
  owner = "openai";
  repo = "codex";
  version = "rust-v0.19.0";
  assetName = "codex-x86_64-unknown-linux-gnu.tar.gz";
  downloadUrl = "https://github.com/${owner}/${repo}/releases/download/${version}/${assetName}";
  extracted = "${repo}-x86_64-unknown-linux-gnu";
in
stdenv.mkDerivation rec {
  pname = "${repo}-${version}";
  inherit version;

  src = fetchurl {
    url = downloadUrl;
    sha256 = "sha256-qCAqGEb8YwU70xGMTGowbrFTRTaypQOL/zOUpwrCB8E=";
  };

  unpackPhase = "true";
  buildPhase = "true";

  installPhase = ''
    mkdir -p $out/bin
    # extract the flat tarball into a temp dir
    tar xzf $src -C $out/bin
    # rename the binary to "codex"
    mv $out/bin/${extracted} $out/bin/${repo}
    # ensure it's executable
    chmod +x $out/bin/${repo}
  '';

  meta = with lib; {
    description = "Codex ${version} binary from GitHub Releases";
    homepage = "https://github.com/${owner}/${repo}/releases/tag/${version}";
    license = licenses.mit;
  };
}
