{ stdenv, lib }:

script: buildInputs: description:
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
  }
