"""Python Protein Translation Exercism"""

import re
from enum import Enum
from enum import auto as enum_auto

K_CODON_LENGTH: int = 3


class Proteins(Enum):
    Methionine = enum_auto()
    Phenylalanine = enum_auto()
    Leucine = enum_auto()
    Serine = enum_auto()
    Tyrosine = enum_auto()
    Cysteine = enum_auto()
    Tryptophan = enum_auto()
    STOP = enum_auto()


ProteinNameT = str
RnaSequenceT = str
CodonSequenceT = str
CodonListT = list[CodonSequenceT]
ProteinListT = list[ProteinNameT]
CodonToProteinT = dict[CodonSequenceT, Proteins]

CodonToProtein: CodonToProteinT = {
    "AUG": Proteins.Methionine,
    "UUU": Proteins.Phenylalanine,
    "UUC": Proteins.Phenylalanine,
    "UUA": Proteins.Leucine,
    "UUG": Proteins.Leucine,
    "UCU": Proteins.Serine,
    "UCC": Proteins.Serine,
    "UCA": Proteins.Serine,
    "UCG": Proteins.Serine,
    "UAU": Proteins.Tyrosine,
    "UAC": Proteins.Tyrosine,
    "UGU": Proteins.Cysteine,
    "UGC": Proteins.Cysteine,
    "UGG": Proteins.Tryptophan,
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

        result.append(protein.name)

    return result
