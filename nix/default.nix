{ stdenv, lib, fetchFromGitHub, git, gnused }:

let packageScript = script: buildInputs: description:
      stdenv.mkDerivation rec {
        name = "posix-toolbox-" + script;

        src = ./..;

        inherit buildInputs;

        installPhase = ''
          mkdir -p $out/bin
          cp $src/${script} $out/bin/${script}
        '';

        postFixup =
          let runtimePath = lib.makeBinPath buildInputs;
           in ''
                sed -i "2 i export PATH=${runtimePath}:\$PATH" $out/bin/${script}
              '';

        meta = {
          homepage = "https://github.com/ptitfred/posix-toolbox";
          inherit description;
          license = lib.licenses.mit;
        };
      };

in { git-bubbles      = packageScript "git-bubbles"      [ git gnused ] "A git script to handle pull requests";
     git-checkout-log = packageScript "git-checkout-log" [ git ]        "A git script to browser reflog and follow checkouts";
   }
