{ lib }: arg:
lib.generators.toINI
{
  listsAsDuplicateKeys = true;
  mkKeyValue = key: value:
    let
      value' =
        if lib.trivial.isBool value then
          (if value then "true" else "false")
        else
          toString value;
    in
    "${key}=${value'}";
}
  arg
