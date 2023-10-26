# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/protein-translation
# Protein Translation exercise
module Translation
  CODON_LENGTH = 3

  def self.to_protein(codon)
    codon2protein = {
      'AUG' => 'Methionine',
      'UUU' => 'Phenylalanine',
      'UUC' => 'Phenylalanine',
      'UUA' => 'Leucine',
      'UUG' => 'Leucine',
      'UCU' => 'Serine',
      'UCC' => 'Serine',
      'UCA' => 'Serine',
      'UCG' => 'Serine',
      'UAU' => 'Tyrosine',
      'UAC' => 'Tyrosine',
      'UGU' => 'Cysteine',
      'UGC' => 'Cysteine',
      'UGG' => 'Tryptophan',
      'UAA' => 'STOP',
      'UAG' => 'STOP',
      'UGA' => 'STOP'
    }

    raise InvalidCodonError, 'invalid codon' unless codon2protein.key?(codon)

    codon2protein[codon]
  end

  def self.of_rna(rna_sequence)
    return [] if rna_sequence.empty?

    has_stop = false
    codons = []
    rna_sequence.scan(/([A-Z]{3})/) do |match|
      codon = match[0]

      if %w[UAA UAG UGA].include?(codon)
        has_stop = true
        break
      end

      codons.push(codon)
    end

    raise InvalidCodonError, 'invalid codon' if !has_stop && rna_sequence.length.modulo(CODON_LENGTH).positive?

    codons.map { |codon| to_protein(codon) }
  end
end

# InvalidCodonError exception
class InvalidCodonError < StandardError
  attr_reader :data

  def initialize(data)
    super
    @data = data
  end
end
