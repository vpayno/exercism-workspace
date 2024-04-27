"""Python Protein Translation Exercism"""

import re
from enum import Enum
from enum import auto as enum_auto

K_CODON_LENGTH: int = 3


class Proteins(Enum):
    METHIONINE = enum_auto()
    PHENYLALANINE = enum_auto()
    LEUCINE = enum_auto()
    SERINE = enum_auto()
    TYROSINE = enum_auto()
    CYSTEINE = enum_auto()
    TRYPTOPHAN = enum_auto()
    STOP = enum_auto()


ProteinNameT = str
RnaSequenceT = str
CodonSequenceT = str
CodonListT = list[CodonSequenceT]
ProteinListT = list[ProteinNameT]
CodonToProteinT = dict[CodonSequenceT, Proteins]

CodonToProtein: CodonToProteinT = {
    "AUG": Proteins.METHIONINE,
    "UUU": Proteins.PHENYLALANINE,
    "UUC": Proteins.PHENYLALANINE,
    "UUA": Proteins.LEUCINE,
    "UUG": Proteins.LEUCINE,
    "UCU": Proteins.SERINE,
    "UCC": Proteins.SERINE,
    "UCA": Proteins.SERINE,
    "UCG": Proteins.SERINE,
    "UAU": Proteins.TYROSINE,
    "UAC": Proteins.TYROSINE,
    "UGU": Proteins.CYSTEINE,
    "UGC": Proteins.CYSTEINE,
    "UGG": Proteins.TRYPTOPHAN,
    "UAA": Proteins.STOP,
    "UAG": Proteins.STOP,
    "UGA": Proteins.STOP,
}


def proteins(rna_sequence: RnaSequenceT) -> ProteinListT:
    r"""Translate RNA to Proteins.

    >>> re.match(r"(\w\w\w)", "AUGUUUUCU").groups()
    ('AUG',)
    >>> re.findall(r"(\w\w\w)", "AUGUUUUCU")
    ['AUG', 'UUU', 'UCU']

    :param rna_sequence: sequence of RNA nucleotide sequences
    :return: list of proteins
    """
    result: ProteinListT = []

    if rna_sequence == "":
        return result

    if len(rna_sequence) % K_CODON_LENGTH != 0:
        return result

    rna_sequence = rna_sequence.upper()

    codons: CodonListT = re.findall(r"(\w\w\w)", rna_sequence)

    if codons is None:
        return result

    codon: CodonSequenceT
    for codon in codons:
        print(f"codon: {codon}")

        protein: Proteins = CodonToProtein.get(codon, Proteins.STOP)

        if protein == Proteins.STOP:
            break

        result.append(protein.name.title())

    return result
