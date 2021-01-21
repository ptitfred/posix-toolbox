{ pkgs ? import <nixpkgs> {}
}:

let aspell = pkgs.aspellWithDicts (d: [d.en]);
 in pkgs.mkShell {
      buildInputs = [ aspell pkgs.shellcheck ];
    }
