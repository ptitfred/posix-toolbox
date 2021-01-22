# posix-toolbox

![tests](https://github.com/ptitfred/posix-toolbox/workflows/tests/badge.svg)

## About

A collection of Unix scripts to ease my life. Mostly around git.

It's very personal and you might find some ideas in it but I doubt anybody would
properly use it as is.

## What's in the toolbox

A collection of script to add to your PATH:
- [git-authors](src/git-authors), a git script to list committers other a commit range
- [git-bubbles](src/git-bubbles), a git script to handle pull requests
- [git-checkout-log](src/git-checkout-log), a git script to browser reflog and follow checkouts
- [git-prd](src/git-prd), a git script to display the path of the root of a git repository relative to your HOME directory
- [git-pwd](src/git-pwd), a git script to display the path relative to the root of a git repository
- [git-rm-others](src/git-rm-others), a git script to clean the working copy from untracked files
- [git-search](src/git-search), a git script to search the diff other a commit range
- [git-short](src/git-short), a git script to display short SHA1 of a given commit
- [git-std-init](src/git-std-init), a git script to setup a repository with an initial empty commit and a base and master branches
- [prd](src/prd), a script to print the working directory relative to your HOME directory
- [repeat](src/repeat), a script to repeat a command some times
- [short-path](src/short-path), a script to abbreviate every directory unless the last part of a path
- [wait-tcp](src/wait-tcp), a script to wait for some server sockets to be opened on a TCP

2 source-able bash scripts to customize your terminal:
- [git-ps1](src/bash/git-ps1), a PS1 expression, mostly focusing on handling git
- [ls-colors](nix/ls-colors.nix), a LS_COLORS env var, built from [trapd00r's LS_COLORS](https://github.com/trapd00r/LS_COLORS)

## How-to install

- [via Nix](#nix)
- [from sources](#from-sources) (deprecated)

### Nix

You can install it from the sources this way:

```bash
nix-env -i -f nix/release.nix
```

You can also add it to an overlay, such as this one:

```nix
self: super:

let fetchPackage = owner: repo: path: rev: sha256:
      self.callPackage (self.fetchFromGitHub { inherit owner repo rev sha256; } + path) {};
in {
     posix-toolbox = fetchPackage "ptitfred" "posix-toolbox" "/nix/default.nix"
       "fd7cc9afaacfe673c1d125b6c86bfd2abf73b53d" "0xr91i4sggbd32z5wj8ar1lz7wpcvjjs86zcq0mc785720y8629k";
   }
```

And letter install some scripts from the nix path:

```bash
nix-env -i -f '<nixpkgs>' posix-toolbox
```

I would recommend you to use home-manager instead, in which case you would like to include the scripts you're interested in in the `home.packages` list:

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

### From sources

:warning: **With 2.0 release, it's not untested and at your own risk.** I will only use Nix from now on.

You still have the old-school approach to checkout the sources and add it to your PATH:

```bash
git checkout https://github.com/ptitfred/posix-toolbox
export PATH=$(pwd)/posix-toolbox/src:$PATH
```

* * *

Copyright &copy; 2010-, Frédéric Menou and Céline Louvet. Licensed under [MIT License].

[MIT License]: https://github.com/ptitfred/posix-toolbox/raw/master/LICENSE.txt
