{ lib }:

rec {
  dropEmptyOptions = lib.attrsets.filterAttrs (_: value: ! (isNull value));

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
}
