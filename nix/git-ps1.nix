{ stdenv, git, git-prd, git-pwd, prd, short-path }:

let git-ps1 =
      stdenv.mkDerivation {
        name = "posix-toolbox-git-ps1";
        src = ./../src;
        buildInputs = [ git git-prd git-pwd prd short-path ];
        installPhase = ''
            mkdir -p $out/share/posix-toolbox
            substitute $src/bash/git-ps1 $out/share/posix-toolbox/git-ps1 \
              --replace "prd_ "    ${prd}/bin/prd \
              --replace git-prd    ${git-prd}/bin/git-prd \
              --replace git-pwd    ${git-pwd}/bin/git-pwd \
              --replace short-path ${short-path}/bin/short-path
          '';
      };
in { inherit git-ps1; }
