"""Python Protein Translation Exercism"""

import re
from enum import Enum
from enum import auto as enum_auto

K_CODON_LENGTH: int = 3


class Proteins(Enum):
    """Protein Enum"""

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


def proteins(rna_sequence: RnaSequenceT) -> ProteinListT:
    r"""Translate RNA to Proteins.

    >>> re.match(r"(\w\w\w)", "AUGUUUUCU").groups()
    ('AUG',)
    >>> re.findall(r"(\w\w\w)", "AUGUUUUCU")
    ['AUG', 'UUU', 'UCU']

    :param rna_sequence: sequence of RNA nucleotide sequences
    :return: list of proteins
    """
    protein_list: ProteinListT = []

    if rna_sequence == "":
        return protein_list

    if len(rna_sequence) % K_CODON_LENGTH != 0:
        return protein_list

    rna_sequence = rna_sequence.upper()

    codons: CodonListT = re.findall(r"(\w\w\w)", rna_sequence)

    if codons is None:
        return protein_list

    codon: CodonSequenceT
    for codon in codons:
        print(f"codon: {codon}")

        protein: Proteins

        match codon:
            case "AUG":
                protein = Proteins.METHIONINE
            case "UUU" | "UUC":
                protein = Proteins.PHENYLALANINE
            case "UUA" | "UUG":
                protein = Proteins.LEUCINE
            case "UCU" | "UCC" | "UCA" | "UCG":
                protein = Proteins.SERINE
            case "UAU" | "UAC":
                protein = Proteins.TYROSINE
            case "UGU" | "UGC":
                protein = Proteins.CYSTEINE
            case "UGG":
                protein = Proteins.TRYPTOPHAN
            case "UAA" | "UAG" | "UGA":
                protein = Proteins.STOP
            case _:
                # or break
                protein = Proteins.STOP

        if protein == Proteins.STOP:
            break

        protein_list.append(protein.name.title())

    return protein_list
