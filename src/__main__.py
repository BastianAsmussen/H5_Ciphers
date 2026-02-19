"""
H5 Ciphers
"""


def caesar_shift(alphabet, char, rotation):
    alphabet_len = len(alphabet)

    try:
        idx = alphabet.index(char) + rotation
        idx += alphabet_len if idx < 0 else -alphabet_len

        return alphabet[idx]

    except ValueError:
        return char


def caesar_cipher(input, rotation):
    alphabet = list("ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ")
    output = ""

    for char in input.upper():
        output += caesar_shift(alphabet, char, rotation)

    return output


if __name__ == "__main__":
    caesar_input = "KRCKN OØ NOA WSXNÅA AKVAO ÅZØYQ S COØNOX?"
    caesar_rotation = -10
    caesar_output = caesar_cipher(caesar_input, caesar_rotation)

    print(f"Caesar Input: {caesar_input}")
    print(f"Caesar Output: {caesar_output}")
