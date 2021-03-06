{ lib, fetchFromGitLab, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "tezos-rust-libs";
  version = "1.0";

  src = fetchFromGitLab {
    owner = "tezos";
    repo = "tezos-rust-libs";
    rev = "v${version}";
    sha256 = "1ffkzbvb0ls4wk9205g3xh2c26cmwnl68x43gh6dm9z4xsic94v5";
  };

  cargoSha256 = "0dgyqfr3dvvdwdi1wvpd7v9j21740jy4zwrwiwknw7csb4bq9wfx";

  preBuild = ''
    mkdir .cargo
    mv cargo-config .cargo/config
  '';

  postInstall = ''
    mkdir $out/lib/tezos-rust-libs
    cp -r rustc-bls12-381/include $out/include
    cp $out/lib/librustc_bls12_381.a $out/lib/tezos-rust-libs
    cp $out/lib/librustzcash.a $out/lib/tezos-rust-libs
  '';

  doCheck = true;

  meta = {
    homepage = "https://gitlab.com/tezos/tezos-rust-libs";
    description = "Tezos: all rust dependencies and their dependencies";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.ulrikstrid ];
  };
}
