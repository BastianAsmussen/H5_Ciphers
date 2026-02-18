# Caesar Cipher Decoder

This project is built using [Nix](https://nixos.org).

## Running

```sh
nix eval -f caesar.nix
```

## Hurdles

Nix has a _very_ hard time with multi-byte characters in some cases.
Due to Nix treating a string as a list of bytes, and thus being _unable_ to
handle [Unicode](https://en.wikipedia.org/wiki/Unicode) properly when
[splitting a string by characters](https://noogle.dev/f/lib/stringToCharacters).

Creating a Caesar Cipher decrypter with the evaluation language being Nix
itself, we're in the deep end with regard to string handling, so I had to
create my own function from scratch for handling Danish characters as the first
byte of each Danish-only character has the same value (`0xC3`), so all index
lookups become essentially invalid.
