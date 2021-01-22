{ stdenv, coreutils, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "posix-toolbox-ls-colors";

  src = fetchFromGitHub {
    owner = "trapd00r";
    repo = "LS_COLORS";
    rev = "e91cc9cc69f6c4780f03b121bc633569742de7cd";
    sha256 = "1i2pc9k1g79wvdq3w2h3ikp3s2myalcvwin2l6gmyhz5cn0xjfg8";
  };

  buildInputs = [ coreutils ];

  installPhase = ''
    mkdir -p $out/share/ls-colors
    dircolors -b $src/LS_COLORS > $out/share/ls-colors/bash.sh
    dircolors -c $src/LS_COLORS > $out/share/ls-colors/csh.sh
  '';
}
