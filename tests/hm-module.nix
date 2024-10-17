{ ... }:

{
  imports = [
    # required by home-manager, not relevant for our tests
    ./home-manager-required-configuration.nix
  ];

  # Let's enable bash to test bash related features
  programs.bash.enable = true;

  # Let's enable git to test bash related features
  programs.git.enable = true;

  # This is how you enable posix-toolbox features (depends on bash and git being active):
  ptitfred.posix-toolbox.enable = true;

  # Example configuration for git-bubbles:
  ptitfred.posix-toolbox.git-bubbles.remote-name = "mine";
}
