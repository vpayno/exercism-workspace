// Transcribes a DNA strand to an RNA strand.
// https://exercism.org/tracks/dart/exercises/anagram

typedef nucleotide_t = String;
typedef nucleotides_t = List<nucleotide_t>;
typedef dna_strand_t = String;
typedef rna_strand_t = String;
typedef dna_to_rna_t = Map<nucleotide_t, nucleotide_t>;
typedef rna_to_dna_t = Map<nucleotide_t, nucleotide_t>;

class RnaTranscription {
  dna_to_rna_t dna_to_rna = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U',
  };

  rna_strand_t toRna(dna_strand_t dna_strand) {
    rna_strand_t rna_strand = "";

    nucleotides_t dna_nucleotides = dna_strand.split('');

    var iter = dna_nucleotides.iterator;

    while (iter.moveNext()) {
      nucleotide_t dna_nucleotide = iter.toString();
      rna_strand += dna_to_rna[dna_nucleotide].toString();
    }

    return rna_strand;
  }
}
