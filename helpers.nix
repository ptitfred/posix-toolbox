{ runCommand, lib }:

let mkCheck = name: script:
      runCommand name {} ''
        mkdir -p $out
        ${script}
      '';

in { mkChecks = lib.attrsets.mapAttrs mkCheck; }
