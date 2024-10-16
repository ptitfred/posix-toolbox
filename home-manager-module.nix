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
      bubbles = lib.attrsets.filterAttrs (_: value: ! (isNull value)) cfg.git-bubbles;
    };

    mkOptionalStr = description:
      lib.mkOption {
        inherit description;
        type = lib.types.nullOr lib.types.str;
        default = null;
      };
in
{
  options = {
    ptitfred.posix-toolbox = {
      enable = lib.mkEnableOption "posix-toolbox";

      git-bubbles = lib.mkOption {
        description = "options for git-bubbles";
        default = {};
        type = (lib.types.submodule {
          options = {
            remote-name = mkOptionalStr "remote-name";
            pattern = mkOptionalStr "pattern";
          };
        });
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
