# frozen_string_literal: false

# https://exercism.org/tracks/ruby/exercises/circular-buffer
# Circular Buffer exercise
class CircularBuffer
  def initialize(capacity = 1)
    @capacity = capacity
    @buffer = Array.new(@capacity, nil)
    @read_ptr = 0
    @write_ptr = 0
  end

  def clear
    @read_ptr = 0
    @write_ptr = 0
  end

  def read
    raise BufferEmptyException if @read_ptr == @write_ptr

    data = @buffer[@read_ptr]
    @read_ptr = (@read_ptr + 1) % (@capacity + 1)

    data
  end

  def write(data)
    new_write_ptr = (@write_ptr + 1) % (@capacity + 1)
    raise BufferFullException if new_write_ptr == @read_ptr

    @buffer[@write_ptr] = data
    @write_ptr = new_write_ptr
  end

  def write!(data)
    new_write_ptr = (@write_ptr + 1) % (@capacity + 1)
    @read_ptr = (@read_ptr + 1) % (@capacity + 1) if new_write_ptr == @read_ptr

    @buffer[@write_ptr] = data
    @write_ptr = new_write_ptr
  end

  def to_s
    output = []
    output.push("   buffer: #{@buffer}")
    output.push("write_ptr: #{@write_ptr}")
    output.push(" read_ptr: #{@read_ptr}")
    output.push(" capacity: #{@capacity}")

    output.join("\n")
  end

  # Raised when the buffer size is zero
  class BufferEmptyException < StandardError
  end

  # Raised when the buffer is full
  class BufferFullException < StandardError
  end
end
