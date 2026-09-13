{ lib, ... }: {
  options.secretspec = lib.mkSinkUndeclaredOptions { };
  options.home-manager = lib.mkSinkUndeclaredOptions { };

  config = { };
}
