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

    initExtra =
      ''
        ${gitBashInitExtra}
        source ${posix-toolbox.ls-colors}/share/ls-colors/bash.sh
      '';
in
{
  options = {
    ptitfred.posix-toolbox.enable = lib.mkEnableOption "posix-toolbox";
  };

  config = {
    home.packages = lib.mkIf cfg.enable packages;

    programs.bash.initExtra =
      lib.mkIf (cfg.enable && config.programs.bash.enable) initExtra;
  };
}
