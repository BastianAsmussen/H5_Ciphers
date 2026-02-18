let
  pkgs = import <nixpkgs> {};

  inherit (pkgs) lib;

  # Splits a string into a list of logical characters, correctly handling
  # multi-byte Danish letters.
  splitDanish = str: let
    # Split on Æ, Ø, or Å. Matched groups become list elements, unmatched
    # parts become plain strings.
    parts = builtins.split "(Æ|Ø|Å)" str;
  in
    builtins.concatMap (
      part:
        if builtins.isList part
        then part # A matched Danish letter, e.g. ["Æ"].
        else lib.stringToCharacters part # ASCII chunk, safe to split by byte.
    )
    parts;

  alphabet = let
    chars = splitDanish "ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ";
  in {
    list = chars;
    len = builtins.length chars;
  };

  input = splitDanish "KRCKN OØ NOA WSXNÅA AKVAO ÅZØYQ S COØNOX?";
  rotation = -10;

  mod = a: b: let
    r = a - (a / b) * b;
  in
    if r < 0
    then r + b
    else r;
in
  builtins.concatStringsSep ""
  (map (c: let
    idx = lib.lists.findFirstIndex (c': c == c') null alphabet.list;
    idx' = mod (idx + rotation) alphabet.len;

    c' = builtins.elemAt alphabet.list idx';
  in
    if idx == null
    then c
    else c')
  input)
