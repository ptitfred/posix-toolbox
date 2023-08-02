{ runCommand, git, git-prd, git-pwd, prd, short-path }:

runCommand "posix-toolbox-git-ps1"
  {
    src = ./scripts;
    buildInputs = [ git git-prd git-pwd prd short-path ];
  }
  ''
    mkdir -p $out/share/posix-toolbox
    substitute $src/git-ps1 $out/share/posix-toolbox/git-ps1 \
      --replace "prd_ "    ${prd}/bin/prd \
      --replace git-prd    ${git-prd}/bin/git-prd \
      --replace git-pwd    ${git-pwd}/bin/git-pwd \
      --replace short-path ${short-path}/bin/short-path
  ''
