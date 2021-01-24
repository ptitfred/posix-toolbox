{ pkgs ? import <nixpkgs> {}
}:

let aspell = pkgs.aspellWithDicts (d: [d.en]);
 in pkgs.mkShell {
      buildInputs = [ aspell pkgs.findutils pkgs.git pkgs.nix-linter pkgs.shellcheck ];
    }
