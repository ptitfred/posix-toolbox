{ stdenv, lib, makeWrapper }:

script: inputs: description:
  stdenv.mkDerivation rec {
    name = "posix-toolbox-" + script;

    src = ./../src;

    buildInputs = inputs ++ [ makeWrapper ] ;

    installPhase =
      let runtimePath = lib.makeBinPath inputs;
       in ''
            mkdir -p $out/bin
            cp $src/${script} $out/bin/${script}
            wrapProgram $out/bin/${script} --prefix PATH : "${runtimePath}"
          '';

    meta = {
      homepage = "https://github.com/ptitfred/posix-toolbox";
      inherit description;
      license = lib.licenses.mit;
    };
  }
