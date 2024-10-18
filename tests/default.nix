{ writeShellApplication
, aspellWithDicts
}:

let aspell = aspellWithDicts (d: [d.en]);
in
{
  spell = writeShellApplication {
    name = "posix-toolbox-spell";
    runtimeInputs = [ aspell ];
    text = builtins.readFile ./spell.sh;
  };
}
