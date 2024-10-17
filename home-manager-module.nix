posix-toolbox:

{ config, lib, ... }:

let cfg = config.ptitfred.posix-toolbox;

    git-packages = with posix-toolbox; lib.lists.optional config.programs.git.enable [
      git-bubbles
      git-checkout-log
      git-tree
    ];

    tools-packages = [ posix-toolbox.wait-tcp ];

    packages =
      lib.lists.flatten [
        git-packages
        tools-packages
      ];

    gitBashInitExtra =
      lib.strings.optionalString config.programs.git.enable
        "source ${posix-toolbox.git-ps1}/share/posix-toolbox/git-ps1";

    bashInitExtra =
      ''
        ${gitBashInitExtra}
        source ${posix-toolbox.ls-colors}/share/ls-colors/bash.sh
      '';

    gitExtraConfig = {
      bubbles = dropEmptyOptions cfg.git-bubbles;
    } // renameGitPS1Options (dropEmptyOptions cfg.git-ps1);

    dropEmptyOptions = lib.attrsets.filterAttrs (_: value: ! (isNull value));

    renameGitPS1Options = renameOptions {
      "show-dirty-state" = showDirtyState: { name = "bash";  value = { inherit showDirtyState; }; };
      "check-threshold"  = threshold:      { name = "check"; value = { inherit threshold;      }; };
      "shorten"          = shorten:        { name = "ps1";   value = { inherit shorten;        }; };
    };

    renameOptions = mapping: lib.attrsets.mapAttrs' (renameOption mapping);

    renameOption = mapping: name: mapping.${name};

    mkSubmodule = description: options:
      lib.mkOption {
        inherit description;
        default = {};
        type = (lib.types.submodule {
          inherit options;
        });
      };

    mkOptionalStr  = mkOptional lib.types.str;
    mkOptionalBool = mkOptional lib.types.bool;
    mkOptionalInt  = mkOptional lib.types.int;

    mkOptional = type: description:
      lib.mkOption {
        inherit description;
        type = lib.types.nullOr type;
        default = null;
      };
in
{
  options = {
    ptitfred.posix-toolbox = {
      enable = lib.mkEnableOption "posix-toolbox";

      git-bubbles = mkSubmodule "options for git-bubbles" {
        remote-name = mkOptionalStr "remote-name";
        pattern     = mkOptionalStr "pattern";
      };

      git-ps1 = mkSubmodule "options for git-ps1" {
        show-dirty-state = mkOptionalBool "show-dirty-state";
        check-threshold  = mkOptionalInt  "check-threshold";
        shorten          = mkOptionalInt  "shorten";
      };
    };
  };

  config = {
    home.packages = lib.mkIf cfg.enable packages;

    programs.bash.initExtra =
      lib.mkIf (cfg.enable && config.programs.bash.enable) bashInitExtra;

    programs.git.extraConfig =
      lib.mkIf (cfg.enable && config.programs.git.enable) gitExtraConfig;
  };
}
