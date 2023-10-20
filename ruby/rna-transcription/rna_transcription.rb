# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/rna-transcription
# RNA Transcription exercise
module Complement
  def self.of_dna(dna_sequence)
    dna_sequence = dna_sequence.upcase.chomp

    return '' if dna_sequence.empty?

    raise ArgumentError, "invalid dna sequence [#{dna_sequence}]" unless dna_sequence.match(/^[GCTA]+$/)

    rna_sequence = dna_sequence.chars.map do |nucleotide|
      dna_to_rna = {
        'G' => 'C',
        'C' => 'G',
        'T' => 'A',
        'A' => 'U'
      }
      dna_to_rna[nucleotide]
    end

    rna_sequence.join('')
  end
end
