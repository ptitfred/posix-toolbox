{ writeShellApplication
, nix-linter
, aspellWithDicts
}:

let aspell = aspellWithDicts (d: [d.en]);
in
{
  lint = writeShellApplication {
    name = "posix-toolbox-lint-nix";
    runtimeInputs = [ nix-linter ];
    text = builtins.readFile ./lint.sh;
  };
  spell = writeShellApplication {
    name = "posix-toolbox-spell";
    runtimeInputs = [ aspell ];
    text = builtins.readFile ./spell.sh;
  };
}
