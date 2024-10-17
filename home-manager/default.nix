posix-toolbox:

{ config, lib, pkgs, ... }:

let cfg = config.ptitfred.posix-toolbox;
    helpers = pkgs.callPackage ./helpers.nix {};

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
      bubbles = helpers.dropEmptyOptions cfg.git-bubbles;
    } // renameGitPS1Options (helpers.dropEmptyOptions cfg.git-ps1);

    renameGitPS1Options = helpers.renameOptions {
      "show-dirty-state" = showDirtyState: { name = "bash";  value = { inherit showDirtyState; }; };
      "check-threshold"  = threshold:      { name = "check"; value = { inherit threshold;      }; };
      "shorten"          = shorten:        { name = "ps1";   value = { inherit shorten;        }; };
    };
in
{
  options = {
    ptitfred.posix-toolbox = {
      enable = lib.mkEnableOption "posix-toolbox";

      git-bubbles = helpers.mkSubmodule "options for git-bubbles" {
        remote-name = helpers.mkOptionalStr "remote-name";
        pattern     = helpers.mkOptionalStr "pattern";
      };

      git-ps1 = helpers.mkSubmodule "options for git-ps1" {
        show-dirty-state = helpers.mkOptionalBool "show-dirty-state";
        check-threshold  = helpers.mkOptionalInt  "check-threshold";
        shorten          = helpers.mkOptionalInt  "shorten";
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