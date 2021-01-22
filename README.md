# posix-toolbox

![tests](https://github.com/ptitfred/posix-toolbox/workflows/tests/badge.svg)

Copyright &copy; 2010-, Frédéric Menou and Céline Louvet. Licensed under [MIT License].

## About

A collection of Unix scripts to ease my life. Mostly around git.

It's very personal and you might find some ideas in it but I doubt anybody would
properly use it as is.

[MIT License]: https://github.com/ptitfred/posix-toolbox/raw/master/LICENSE.txt

## How-to install

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

You still have the old-school approach to checkout the sources and add it to your PATH:

```bash
git checkout https://github.com/ptitfred/posix-toolbox
export PATH=$(pwd)/posix-toolbox/src:$PATH
```
