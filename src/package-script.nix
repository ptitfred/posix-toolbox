{ lib, stdenv, makeWrapper }:

name: description: inputs: script:

stdenv.mkDerivation {
  name = "posix-toolbox-" + name;

  unpackPhase = "true";

  buildInputs = inputs ++ [ makeWrapper ] ;

  installPhase =
    let runtimePath = lib.makeBinPath inputs;
     in ''
          mkdir -p $out/bin
          cp ${script} $out/bin/${name}
          wrapProgram $out/bin/${name} --prefix PATH : "${runtimePath}"
        '';

  meta = {
    homepage = "https://github.com/ptitfred/posix-toolbox";
    inherit description;
    license = lib.licenses.mit;
  };
}
