# posix-toolbox

![tests](https://github.com/ptitfred/posix-toolbox/workflows/tests/badge.svg)

## About

A collection of Unix scripts to ease my life. Mostly around git.

It's very personal and you might find some ideas in it but I doubt anybody would
properly use it as is.

## What's in the toolbox

A collection of script to add to your PATH:
- [git-authors](src/scripts/git-authors), a git script to list committers other a commit range
- [git-bubbles](src/scripts/git-bubbles), a git script to handle pull requests
- [git-checkout-log](src/scripts/git-checkout-log), a git script to browser reflog and follow checkouts
- [git-prd](src/scripts/git-prd), a git script to display the path of the root of a git repository relative to your HOME directory
- [git-pwd](src/scripts/git-pwd), a git script to display the path relative to the root of a git repository
- [git-rm-others](src/scripts/git-rm-others), a git script to clean the working copy from untracked files
- [git-search](src/scripts/git-search), a git script to search the diff other a commit range
- [git-short](src/scripts/git-short), a git script to display short SHA1 of a given commit
- [git-std-init](src/scripts/git-std-init), a git script to setup a repository with an initial empty commit and a base and master branches
- [git-tree](src/scripts/git-tree), a git script to tree files handled by git
- [prd](src/scripts/prd), a script to print the working directory relative to your HOME directory
- [repeat](src/scripts/repeat), a script to repeat a command some times
- [short-path](src/scripts/short-path), a script to abbreviate every directory unless the last part of a path
- [wait-tcp](src/scripts/wait-tcp), a script to wait for some server sockets to be opened on a TCP

2 source-able bash scripts to customize your terminal:
- [git-ps1](src/scripts/git-ps1), a PS1 expression, mostly focusing on handling git
- [ls-colors](src/ls-colors.nix), a LS_COLORS env var, built from [trapd00r's LS_COLORS](https://github.com/trapd00r/LS_COLORS)

## How-to install

This project relies on [nix](https://nixos.org), and [flakes must be enabled](https://nixos.wiki/wiki/Flakes#Enable_flakes).

### Test from a shell

```bash
nix shell github:ptitfred/posix-toolbox
```

### Install via a profile

I would recommend you to use [home-manager](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes) instead (see below), but if you prefer a more classic approach, you can install it in your user's path this way:

```bash
nix profile install github:ptitfred/posix-toolbox
```

### Install via home-manager

The flake exposes an overlay, let's first configure it (via a flake input for instance):

```nix
{ inputs, ... }:

{
  nixpkgs.overlays = [ inputs.posix-toolbox.overlay ];
}
```

We can now add the scripts we'd like in our PATH via the `home.packages` list:

```nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    posix-toolbox.git-bubbles
    posix-toolbox.git-checkout-log
    posix-toolbox.ls-colors
  ];
}
```

You can also configure bash to use the PS1 provided by this project via home-manager:

```nix
{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''
      source ${pkgs.posix-toolbox.git-ps1}/share/posix-toolbox/git-ps1
    '';
  };
}
```

It's exactly the same for the ls-colors:

```nix
{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''
      source ${pkgs.posix-toolbox.ls-colors}/share/ls-colors/bash.sh
    '';
  };
}
```

If you're curious about [home-manager](https://github.com/nix-community/home-manager)
you can learn about it via [their official documentation](https://nix-community.github.io/home-manager)
or by examples via [my own configuration](https://github.com/ptitfred/home-manager).

* * *

Copyright &copy; 2010-, Frédéric Menou and Céline Louvet. Licensed under [MIT License].

[MIT License]: https://github.com/ptitfred/posix-toolbox/raw/master/LICENSE.txt
