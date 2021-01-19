{ stdenv, lib, fetchFromGitHub, git, gnused }:

stdenv.mkDerivation rec {
  name = "git-bubbles";

  src = ./..;

  buildInputs = [ git gnused ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/git-bubbles $out/bin/git-bubbles
  '';

  postFixup =
    let runtimePath = lib.makeBinPath buildInputs;
     in ''
          sed -i "2 i export PATH=${runtimePath}:\$PATH" $out/bin/git-bubbles
        '';

  meta = {
    homepage = "https://github.com/ptitfred/posix-toolbox";
    description = "A git script to handle pull requests";
    license = lib.licenses.mit;
  };
}
