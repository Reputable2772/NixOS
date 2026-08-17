{ lib }:
let
  /*
    mapAttrsTreeDepth

    Recursively applies mapping functions to an attribute set and its leaf values
    up to a specified depth, using a **bottom-up** evaluation order.

    Bottom-Up Semantics:
    Inner leaves and child attrsets are fully evaluated and mapped *before*
    the resulting processed attribute set is passed to the parent's `mapAttrs`.

    Root Bypass:
    The top-level root attribute set is evaluated (its children are mapped),
    but the root set itself is returned as-is. It is *never* passed to `mapAttrs`.

    Mapping Rules:
    - `mapAttr currentDepth attrName attrVal`: Operates exclusively on leaf values.
    - `mapAttrs currentDepth attrName attrSet`: Operates on entire attribute sets.

    Depth Rules (for maxDepth = D):
    - Level 0 (root) starts at `currentDepth = 0`.
    - Attrsets at levels 1 through D receive `mapAttrs`.
    - Leaf values at levels 0 through D-1 receive `mapAttr`.
    - Everything strictly at or below level D is left completely untouched.

    Type:
      mapAttrsTreeDepth ::
        (Int -> String -> Any -> Any) ->
        (Int -> String -> AttrSet -> AttrSet) ->
        Int ->
        AttrSet ->
        AttrSet
  */
  mapAttrsTreeDepth =
    _mapAttr: _mapAttrs: _maxDepth: _attrs:
    let
      _mapAttrsRecursiveDepth =
        currentDepth: attrName: attrs:
        let
          processedAttrs =
            if currentDepth < _maxDepth then
              lib.mapAttrs (
                childName: childVal:
                if lib.isAttrs childVal then
                  _mapAttrsRecursiveDepth (currentDepth + 1) childName childVal
                else
                  _mapAttr currentDepth childName childVal
              ) attrs
            else
              attrs;
        in
        # Skip mapAttrs for the root
        if attrName == null then processedAttrs else _mapAttrs currentDepth attrName processedAttrs;
    in
    _mapAttrsRecursiveDepth 0 null _attrs;
in
mapAttrsTreeDepth
