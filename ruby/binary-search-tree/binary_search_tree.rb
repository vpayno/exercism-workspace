# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/binary-search-tree
# Binary Search Tree exercise
class Bst
  attr_reader :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def insert(data)
    if data <= @data
      @left ? @left.insert(data) : @left = Bst.new(data)
    else
      @right ? @right.insert(data) : @right = Bst.new(data)
    end
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    @left&.each(&block)
    block.call(@data)
    @right&.each(&block)
  end
end
