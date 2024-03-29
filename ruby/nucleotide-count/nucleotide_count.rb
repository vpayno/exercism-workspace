# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/nucleotide-count
# Nucleotide Count exercise
class Nucleotide
  def initialize(sequence)
    @sequence = sequence.upcase.chomp
  end

  def self.from_dna(sequence)
    sequence = sequence.upcase.chomp
    e_invalid_sequence = 'DNA sequence must only contain nucleotides A, C, G and T'

    raise ArgumentError, e_invalid_sequence unless sequence.match(/^(|[ACGT]+)$/)

    Nucleotide.new(sequence)
  end

  def count(key)
    @sequence.chars.count(key)
  end

  def histogram
    template_hash = { 'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0 }

    @sequence.chars.each_with_object(template_hash) do |nucleotide, new_hash|
      new_hash[nucleotide] += 1
    end
  end
end
